package pe.sige.common.messaging;

import io.quarkus.arc.properties.IfBuildProperty;
import io.quarkus.scheduler.Scheduled;
import io.smallrye.mutiny.Multi;
import io.smallrye.mutiny.Uni;
import io.smallrye.reactive.messaging.MutinyEmitter;
import io.smallrye.reactive.messaging.kafka.api.OutgoingKafkaRecordMetadata;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.time.OffsetDateTime;
import java.util.List;
import org.eclipse.microprofile.reactive.messaging.Channel;
import org.eclipse.microprofile.reactive.messaging.Message;
import org.hibernate.reactive.mutiny.Mutiny;
import org.jboss.logging.Logger;

/**
 * Publica en Kafka los eventos pendientes del outbox.
 * {@code FOR UPDATE SKIP LOCKED} permite varias replicas del servicio sin publicar dos veces el mismo lote.
 * La entrega es "al menos una vez": los consumidores son idempotentes ({@link ProcessedEvents}).
 */
@ApplicationScoped
@IfBuildProperty(name = "sige.outbox.enabled", stringValue = "true", enableIfMissing = true)
public class OutboxRelay {

    private static final Logger LOG = Logger.getLogger(OutboxRelay.class);
    private static final String PENDING = "select * from outbox_event where published_at is null and attempts < 20 "
            + "order by created_at limit 100 for update skip locked";

    @Inject
    Mutiny.SessionFactory sf;

    @Inject
    @Channel("outbox")
    MutinyEmitter<String> emitter;

    @Scheduled(every = "${sige.outbox.interval:2s}", concurrentExecution = Scheduled.ConcurrentExecution.SKIP)
    Uni<Void> publishPending() {
        return sf.withTransaction(s -> s.createNativeQuery(PENDING, OutboxEvent.class).getResultList()
                .flatMap(this::publishAll))
                .onFailure().invoke(t -> LOG.warn("Fallo al publicar outbox: " + t.getMessage()))
                .onFailure().recoverWithNull();
    }

    private Uni<Void> publishAll(List<OutboxEvent> events) {
        if (events.isEmpty()) {
            return Uni.createFrom().voidItem();
        }
        return Multi.createFrom().iterable(events)
                .onItem().transformToUniAndConcatenate(this::publish)
                .collect().last().replaceWithVoid();
    }

    private Uni<Void> publish(OutboxEvent e) {
        Message<String> msg = Message.of(e.payload).addMetadata(OutgoingKafkaRecordMetadata.<String>builder()
                .withTopic(e.topic)
                .withKey(e.aggregateId)
                .build());
        return emitter.sendMessage(msg)
                .invoke(() -> e.publishedAt = OffsetDateTime.now())
                .onFailure().invoke(t -> {
                    e.attempts++;
                    LOG.warnf("No se pudo publicar %s (%s): %s", e.id, e.eventType, t.getMessage());
                })
                .onFailure().recoverWithNull()
                .replaceWithVoid();
    }
}

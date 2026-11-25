package pe.sige.common.messaging;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.smallrye.mutiny.Uni;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import java.time.OffsetDateTime;
import java.util.UUID;
import org.eclipse.microprofile.config.inject.ConfigProperty;

/**
 * Registra eventos de integracion en la tabla outbox dentro de la MISMA transaccion
 * que el cambio de negocio. {@link OutboxRelay} los publica luego en Kafka.
 * Asi nunca se publica un evento de algo que no se guardo, ni se pierde uno que si.
 */
@ApplicationScoped
public class Outbox {

    @Inject
    ObjectMapper mapper;

    @ConfigProperty(name = "quarkus.application.name")
    String source;

    /** Debe llamarse dentro de una transaccion reactiva activa (@WithTransaction). */
    public Uni<OutboxEvent> record(String topic, String type, String aggregateType, String aggregateId, Object data) {
        EventEnvelope env = new EventEnvelope(UUID.randomUUID(), type, source, aggregateId, OffsetDateTime.now(), 1,
                mapper.valueToTree(data));
        OutboxEvent e = new OutboxEvent();
        e.id = env.id();
        e.topic = topic;
        e.eventType = type;
        e.aggregateType = aggregateType;
        e.aggregateId = aggregateId;
        e.createdAt = env.time();
        try {
            e.payload = mapper.writeValueAsString(env);
        } catch (JsonProcessingException ex) {
            return Uni.createFrom().failure(ex);
        }
        return e.persist();
    }
}

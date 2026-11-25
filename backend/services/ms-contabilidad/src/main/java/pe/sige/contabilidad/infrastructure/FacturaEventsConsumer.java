package pe.sige.contabilidad.infrastructure;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.quarkus.hibernate.reactive.panache.Panache;
import io.smallrye.mutiny.Uni;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.eclipse.microprofile.reactive.messaging.Incoming;
import pe.sige.common.events.FacturaEvent;
import pe.sige.common.messaging.EventEnvelope;
import pe.sige.common.messaging.ProcessedEvents;
import pe.sige.common.persistence.AuditContext;
import pe.sige.contabilidad.application.AsientoVentasService;

/** Contabilizacion automatica de ventas a partir de los eventos de ms-ventas. */
@ApplicationScoped
public class FacturaEventsConsumer {

    private static final String CONSUMER = "contabilidad.asiento-ventas";

    @Inject
    ObjectMapper mapper;

    @Inject
    ProcessedEvents processed;

    @Inject
    AsientoVentasService asientos;

    @Incoming("ventas-facturas")
    public Uni<Void> onFactura(String json) throws Exception {
        EventEnvelope env = mapper.readValue(json, EventEnvelope.class);
        FacturaEvent f = mapper.treeToValue(env.data(), FacturaEvent.class);
        AuditContext.setUser("evento:" + env.source());
        return Panache.withTransaction(() -> processed.firstTime(env.id(), CONSUMER).flatMap(first -> {
            if (!first) {
                return Uni.createFrom().voidItem();
            }
            return switch (env.type()) {
                case FacturaEvent.EMITIDA -> asientos.generar(f).replaceWithVoid();
                case FacturaEvent.ANULADA -> asientos.anular(f).replaceWithVoid();
                default -> Uni.createFrom().voidItem();
            };
        }));
    }
}

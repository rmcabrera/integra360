package pe.sige.logistica.infrastructure;

import com.fasterxml.jackson.databind.ObjectMapper;
import io.quarkus.hibernate.reactive.panache.Panache;
import io.smallrye.mutiny.Uni;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import org.eclipse.microprofile.reactive.messaging.Incoming;
import org.jboss.logging.Logger;
import pe.sige.common.events.FacturaEvent;
import pe.sige.common.messaging.EventEnvelope;
import pe.sige.common.messaging.ProcessedEvents;
import pe.sige.common.persistence.AuditContext;
import pe.sige.logistica.application.KardexService;
import pe.sige.logistica.application.MovimientoKardex;
import pe.sige.logistica.domain.KardexCalculator;

/**
 * Venta emitida -> salida de almacen en kardex. Venta anulada -> se eliminan esas salidas y se recalcula
 * (antes: trigger/SP_KARDEX_INSERT y SP_KARDEX_DELETE invocados desde la ventana de facturacion).
 */
@ApplicationScoped
public class FacturaEventsConsumer {

    private static final Logger LOG = Logger.getLogger(FacturaEventsConsumer.class);
    private static final String CONSUMER = "logistica.kardex";

    @Inject
    ObjectMapper mapper;

    @Inject
    ProcessedEvents processed;

    @Inject
    KardexService kardex;

    @Incoming("ventas-facturas")
    public Uni<Void> onFactura(String json) throws Exception {
        EventEnvelope env = mapper.readValue(json, EventEnvelope.class);
        FacturaEvent f = mapper.treeToValue(env.data(), FacturaEvent.class);
        AuditContext.setUser("evento:" + env.source());
        return Panache.withTransaction(() -> processed.firstTime(env.id(), CONSUMER).flatMap(first -> {
            if (!first) {
                LOG.debugf("Evento %s ya procesado", env.id());
                return Uni.createFrom().voidItem();
            }
            return switch (env.type()) {
                case FacturaEvent.EMITIDA -> salidas(f);
                case FacturaEvent.ANULADA -> reversa(f);
                default -> Uni.createFrom().voidItem();
            };
        }));
    }

    private Uni<Void> salidas(FacturaEvent f) {
        Uni<Void> chain = Uni.createFrom().voidItem();
        for (var it : f.items()) {
            if (it.codiProd() == null) {
                continue;
            }
            var mov = new MovimientoKardex(it.codiProd(), f.codiAlma(), f.fecha().atStartOfDay(), KardexCalculator.SALIDA,
                    it.cantidad(), null, f.codiTipoDocu(), f.serie(), f.numero(), f.codiFact(), it.codiDeta(),
                    f.codiMone(), f.tipoCambio(), "VENTA " + f.serie() + "-" + f.numero() + ", CLIENTE " + f.codiClieProv());
            chain = chain.chain(() -> kardex.registrar(mov).replaceWithVoid());
        }
        return chain;
    }

    private Uni<Void> reversa(FacturaEvent f) {
        Uni<Void> chain = Uni.createFrom().voidItem();
        for (var it : f.items()) {
            if (it.codiProd() == null) {
                continue;
            }
            chain = chain.chain(() -> kardex.eliminarPorDocumento(f.codiFact(), KardexCalculator.SALIDA, it.codiProd(),
                    f.fecha().getYear()).replaceWithVoid());
        }
        return chain;
    }
}

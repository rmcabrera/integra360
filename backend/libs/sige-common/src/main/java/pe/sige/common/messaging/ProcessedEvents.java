package pe.sige.common.messaging;

import io.quarkus.hibernate.reactive.panache.Panache;
import io.smallrye.mutiny.Uni;
import jakarta.enterprise.context.ApplicationScoped;
import java.util.UUID;

/**
 * Consumidor idempotente: registra el id del evento en {@code processed_event}.
 * Devuelve {@code true} solo la primera vez, dentro de la transaccion del procesamiento,
 * de modo que si el procesamiento falla el registro tambien se revierte.
 */
@ApplicationScoped
public class ProcessedEvents {

    public Uni<Boolean> firstTime(UUID eventId, String consumer) {
        return Panache.getSession().flatMap(s -> s
                .createNativeQuery("insert into processed_event(event_id, consumer) values (:id, :c) on conflict do nothing")
                .setParameter("id", eventId)
                .setParameter("c", consumer)
                .executeUpdate())
                .map(rows -> rows > 0);
    }
}

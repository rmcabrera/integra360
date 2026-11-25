package pe.sige.common.messaging;

import com.fasterxml.jackson.databind.JsonNode;
import java.time.OffsetDateTime;
import java.util.UUID;

/**
 * Sobre de evento de integracion, inspirado en CloudEvents 1.0.
 *
 * @param id          identificador unico (clave de idempotencia en los consumidores)
 * @param type        tipo, p.ej. {@code ventas.factura.emitida}
 * @param source      servicio emisor, p.ej. {@code ms-ventas}
 * @param subject     id del agregado (p.ej. codigo de factura)
 * @param time        momento de ocurrencia
 * @param dataVersion version del esquema de {@code data}
 * @param data        contenido del evento
 */
public record EventEnvelope(UUID id, String type, String source, String subject, OffsetDateTime time, int dataVersion,
        JsonNode data) {
}

package pe.sige.common.messaging;

import io.quarkus.hibernate.reactive.panache.PanacheEntityBase;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.OffsetDateTime;
import java.util.UUID;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.type.SqlTypes;

/** Evento pendiente de publicar (patron Transactional Outbox). Vive en el esquema de cada servicio. */
@Entity(name = "OutboxEvent")
@Table(name = "outbox_event")
public class OutboxEvent extends PanacheEntityBase {

    @Id
    public UUID id;

    @Column(name = "aggregate_type", nullable = false)
    public String aggregateType;

    @Column(name = "aggregate_id", nullable = false)
    public String aggregateId;

    @Column(name = "event_type", nullable = false)
    public String eventType;

    @Column(nullable = false)
    public String topic;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(nullable = false, columnDefinition = "jsonb")
    public String payload;

    @Column(name = "created_at", nullable = false)
    public OffsetDateTime createdAt;

    @Column(name = "published_at")
    public OffsetDateTime publishedAt;

    @Column(nullable = false)
    public int attempts;
}

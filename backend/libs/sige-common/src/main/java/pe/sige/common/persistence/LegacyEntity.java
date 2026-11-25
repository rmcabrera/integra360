package pe.sige.common.persistence;

import io.quarkus.hibernate.reactive.panache.PanacheEntityBase;
import jakarta.persistence.Column;
import jakarta.persistence.MappedSuperclass;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Version;
import java.time.OffsetDateTime;

/**
 * Superclase de todas las tablas migradas del sistema PowerBuilder.
 * <ul>
 *   <li>Auditoria minima (creacion, modificacion, usuario).</li>
 *   <li>Bloqueo optimista con {@code row_version}: reemplaza el control de concurrencia
 *       que hacia el DataWindow con su clausula WHERE de columnas modificadas.</li>
 * </ul>
 */
@MappedSuperclass
public abstract class LegacyEntity extends PanacheEntityBase {

    @Column(name = "audit_created_at", nullable = false, updatable = false)
    public OffsetDateTime auditCreatedAt;

    @Column(name = "audit_updated_at")
    public OffsetDateTime auditUpdatedAt;

    @Column(name = "audit_user", length = 60)
    public String auditUser;

    @Version
    @Column(name = "row_version", nullable = false)
    public Long rowVersion;

    @PrePersist
    void onCreate() {
        if (auditCreatedAt == null) {
            auditCreatedAt = OffsetDateTime.now();
        }
        auditUser = AuditContext.currentUser();
    }

    @PreUpdate
    void onUpdate() {
        auditUpdatedAt = OffsetDateTime.now();
        auditUser = AuditContext.currentUser();
    }
}

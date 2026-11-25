package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SOLI_PRES_CRON_DEVO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SoliPresCronDevo")
@Table(name = "soli_pres_cron_devo")
@IdClass(SoliPresCronDevo.Pk.class)
public class SoliPresCronDevo extends LegacyEntity {

    /** Legado: CODI_SOLI_PRES */
    @Id
    @Column(name = "codi_soli_pres", length = 10, nullable = false)
    public String codiSoliPres;

    /** Legado: NRO_ITEM */
    @Id
    @Column(name = "nro_item", nullable = false)
    public Short nroItem;

    /** Legado: NRO_CUOT */
    @Column(name = "nro_cuot")
    public Short nroCuot;

    /** Legado: FECH_VENC */
    @Column(name = "fech_venc")
    public LocalDateTime fechVenc;

    /** Legado: MONT_CUOT */
    @Column(name = "mont_cuot", precision = 15, scale = 4)
    public BigDecimal montCuot;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiSoliPres;
        public Short nroItem;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiSoliPres, other.codiSoliPres)
                && Objects.equals(nroItem, other.nroItem);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiSoliPres, nroItem);
        }
    }
}

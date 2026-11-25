package pe.sige.maestros.domain.legacy;

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
 * Tabla legado <b>dbo.VALORES_UNITARIOS_ANUALES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ValoresUnitariosAnuales")
@Table(name = "valores_unitarios_anuales")
@IdClass(ValoresUnitariosAnuales.Pk.class)
public class ValoresUnitariosAnuales extends LegacyEntity {

    /** Legado: CODI_VALO_UNIT */
    @Id
    @Column(name = "codi_valo_unit", nullable = false)
    public Integer codiValoUnit;

    /** Legado: FECH_ASIG */
    @Id
    @Column(name = "fech_asig", nullable = false)
    public LocalDateTime fechAsig;

    /** Legado: FECH_ASIG_FIN */
    @Column(name = "fech_asig_fin")
    public LocalDateTime fechAsigFin;

    /** Legado: VALOR */
    @Column(name = "valor", precision = 12, scale = 2, nullable = false)
    public BigDecimal valor;

    /** Legado: TIPO_VALO */
    @Column(name = "tipo_valo", nullable = false)
    public Boolean tipoValo;

    /** Legado: ESTA_ACTI */
    @Column(name = "esta_acti", nullable = false)
    public Boolean estaActi;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Integer codiValoUnit;
        public LocalDateTime fechAsig;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiValoUnit, other.codiValoUnit)
                && Objects.equals(fechAsig, other.fechAsig);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiValoUnit, fechAsig);
        }
    }
}

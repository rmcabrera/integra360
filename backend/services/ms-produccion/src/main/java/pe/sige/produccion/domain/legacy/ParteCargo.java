package pe.sige.produccion.domain.legacy;

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
 * Tabla legado <b>dbo.PARTE_CARGO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ParteCargo")
@Table(name = "parte_cargo")
@IdClass(ParteCargo.Pk.class)
public class ParteCargo extends LegacyEntity {

    /** Legado: CODI_CARG */
    @Id
    @Column(name = "codi_carg", length = 4, nullable = false)
    public String codiCarg;

    /** Legado: FECH_ASIG */
    @Id
    @Column(name = "fech_asig", nullable = false)
    public LocalDateTime fechAsig;

    /** Legado: CODI_UNID_OPER */
    @Id
    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    /** Legado: PARTE */
    @Column(name = "parte", precision = 12, scale = 3)
    public BigDecimal parte;

    /** Legado: ADICIONAL */
    @Column(name = "adicional", precision = 12, scale = 3)
    public BigDecimal adicional;

    /** Legado: ESPE_PART */
    @Column(name = "espe_part", precision = 12, scale = 3)
    public BigDecimal espePart;

    /** Legado: ESPE_ADIC */
    @Column(name = "espe_adic", precision = 12, scale = 3)
    public BigDecimal espeAdic;

    /** Legado: EMPRESA */
    @Column(name = "empresa", precision = 12, scale = 3)
    public BigDecimal empresa;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiCarg;
        public LocalDateTime fechAsig;
        public String codiUnidOper;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiCarg, other.codiCarg)
                && Objects.equals(fechAsig, other.fechAsig)
                && Objects.equals(codiUnidOper, other.codiUnidOper);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiCarg, fechAsig, codiUnidOper);
        }
    }
}

package pe.sige.finanzas.domain.legacy;

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
 * Tabla legado <b>dbo.ESCRIBALO_DETA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "EscribaloDeta")
@Table(name = "escribalo_deta")
@IdClass(EscribaloDeta.Pk.class)
public class EscribaloDeta extends LegacyEntity {

    /** Legado: CODI_ESCR */
    @Id
    @Column(name = "codi_escr", length = 10, nullable = false)
    public String codiEscr;

    /** Legado: CODI_CONTABLE */
    @Id
    @Column(name = "codi_contable", length = 10, nullable = false)
    public String codiContable;

    /** Legado: FECHA */
    @Column(name = "fecha")
    public LocalDateTime fecha;

    /** Legado: REGB */
    @Column(name = "regb", length = 7)
    public String regb;

    /** Legado: CODI_VOUC */
    @Column(name = "codi_vouc", length = 10)
    public String codiVouc;

    /** Legado: CODI_RELA */
    @Column(name = "codi_rela", length = 10)
    public String codiRela;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 10)
    public String codiMone;

    /** Legado: IMPORTE */
    @Column(name = "importe", precision = 12, scale = 4)
    public BigDecimal importe;

    /** Legado: ESTA */
    @Column(name = "esta")
    public Boolean esta;

    /** Legado: CODI_AGRU */
    @Column(name = "codi_agru", length = 10)
    public String codiAgru;

    /** Legado: NRO_DOCU */
    @Column(name = "nro_docu", length = 50)
    public String nroDocu;

    /** Legado: SUBDIA */
    @Column(name = "subdia", length = 1)
    public String subdia;

    @Column(name = "codi_tipo_docu", length = 4)
    public String codiTipoDocu;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiEscr;
        public String codiContable;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiEscr, other.codiEscr)
                && Objects.equals(codiContable, other.codiContable);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiEscr, codiContable);
        }
    }
}

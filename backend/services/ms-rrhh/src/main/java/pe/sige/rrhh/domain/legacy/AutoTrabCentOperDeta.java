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
 * Tabla legado <b>dbo.AUTO_TRAB_CENT_OPER_DETA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "AutoTrabCentOperDeta")
@Table(name = "auto_trab_cent_oper_deta")
@IdClass(AutoTrabCentOperDeta.Pk.class)
public class AutoTrabCentOperDeta extends LegacyEntity {

    /** Legado: CODI_AUTO_TRAB_CO */
    @Id
    @Column(name = "codi_auto_trab_co", length = 5, nullable = false)
    public String codiAutoTrabCo;

    /** Legado: NRO_DETA */
    @Id
    @Column(name = "nro_deta", nullable = false)
    public Short nroDeta;

    /** Legado: CODI_PERS */
    @Column(name = "codi_pers", length = 5)
    public String codiPers;

    /** Legado: FECH_INIC */
    @Column(name = "fech_inic")
    public LocalDateTime fechInic;

    /** Legado: FECH_TERM */
    @Column(name = "fech_term")
    public LocalDateTime fechTerm;

    /** Legado: NUME_HORA_NORM */
    @Column(name = "nume_hora_norm", precision = 9, scale = 2)
    public BigDecimal numeHoraNorm;

    /** Legado: NUME_HORA_25 */
    @Column(name = "nume_hora_25", precision = 9, scale = 2)
    public BigDecimal numeHora25;

    /** Legado: NUME_HORA_35 */
    @Column(name = "nume_hora_35", precision = 9, scale = 2)
    public BigDecimal numeHora35;

    /** Legado: NUME_HORA_NOCT */
    @Column(name = "nume_hora_noct", precision = 9, scale = 2)
    public BigDecimal numeHoraNoct;

    /** Legado: SITU_HORA_25 */
    @Column(name = "situ_hora_25", length = 2)
    public String situHora25;

    /** Legado: SITU_HORA_35 */
    @Column(name = "situ_hora_35", length = 2)
    public String situHora35;

    /** Legado: SITU_HORA_NOCT */
    @Column(name = "situ_hora_noct", length = 2)
    public String situHoraNoct;

    /** Legado: DETA_TRAB */
    @Column(name = "deta_trab", length = 250)
    public String detaTrab;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiAutoTrabCo;
        public Short nroDeta;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiAutoTrabCo, other.codiAutoTrabCo)
                && Objects.equals(nroDeta, other.nroDeta);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiAutoTrabCo, nroDeta);
        }
    }
}

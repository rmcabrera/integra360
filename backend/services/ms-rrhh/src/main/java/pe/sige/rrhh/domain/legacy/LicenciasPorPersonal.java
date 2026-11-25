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
 * Tabla legado <b>dbo.LICENCIAS_POR_PERSONAL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "LicenciasPorPersonal")
@Table(name = "licencias_por_personal")
@IdClass(LicenciasPorPersonal.Pk.class)
public class LicenciasPorPersonal extends LegacyEntity {

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: CODI_TIPO_LICE */
    @Id
    @Column(name = "codi_tipo_lice", length = 3, nullable = false)
    public String codiTipoLice;

    /** Legado: MOTIVO */
    @Column(name = "motivo", length = 100)
    public String motivo;

    /** Legado: FECH_INIC */
    @Id
    @Column(name = "fech_inic", nullable = false)
    public LocalDateTime fechInic;

    /** Legado: FECH_TERM */
    @Column(name = "fech_term", nullable = false)
    public LocalDateTime fechTerm;

    /** Legado: ESTA_ACTI */
    @Column(name = "esta_acti")
    public Boolean estaActi;

    /** Legado: GOCE_HABE */
    @Column(name = "goce_habe")
    public Boolean goceHabe;

    /** Legado: NRO_DIAS_REMU */
    @Column(name = "nro_dias_remu")
    public Integer nroDiasRemu;

    /** Legado: OBSERVACIONES */
    @Column(name = "observaciones", length = 200)
    public String observaciones;

    @Column(name = "nro_hora_remu", precision = 9, scale = 2)
    public BigDecimal nroHoraRemu;

    /** Legado: CODI_JEFE_INME_AUTO */
    @Column(name = "codi_jefe_inme_auto", length = 5)
    public String codiJefeInmeAuto;

    /** Legado: CODI_JEFE_SUPE_AUTO */
    @Column(name = "codi_jefe_supe_auto", length = 5)
    public String codiJefeSupeAuto;

    /** Legado: CODI_TIPO_SUSP_LABO */
    @Column(name = "codi_tipo_susp_labo")
    public Short codiTipoSuspLabo;

    /** Legado: NRO_CITT */
    @Column(name = "nro_citt", length = 15)
    public String nroCitt;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPers;
        public String codiTipoLice;
        public LocalDateTime fechInic;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPers, other.codiPers)
                && Objects.equals(codiTipoLice, other.codiTipoLice)
                && Objects.equals(fechInic, other.fechInic);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPers, codiTipoLice, fechInic);
        }
    }
}

package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ASISTENCIA_TRIPULANTES_PESCA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "AsistenciaTripulantesPesca")
@Table(name = "asistencia_tripulantes_pesca")
@IdClass(AsistenciaTripulantesPesca.Pk.class)
public class AsistenciaTripulantesPesca extends LegacyEntity {

    /** Legado: CODI_SEMA */
    @Id
    @Column(name = "codi_sema", length = 8, nullable = false)
    public String codiSema;

    /** Legado: CODI_UNID_OPER */
    @Id
    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: CODI_CARG */
    @Column(name = "codi_carg", length = 4, nullable = false)
    public String codiCarg;

    /** Legado: JUEVES */
    @Column(name = "jueves", length = 1)
    public String jueves;

    /** Legado: VIERNES */
    @Column(name = "viernes", length = 1)
    public String viernes;

    /** Legado: SABADO */
    @Column(name = "sabado", length = 1)
    public String sabado;

    /** Legado: DOMINGO */
    @Column(name = "domingo", length = 1)
    public String domingo;

    /** Legado: LUNES */
    @Column(name = "lunes", length = 1)
    public String lunes;

    /** Legado: MARTES */
    @Column(name = "martes", length = 1)
    public String martes;

    /** Legado: MIERCOLES */
    @Column(name = "miercoles", length = 1)
    public String miercoles;

    /** Legado: JUEV_CARG */
    @Column(name = "juev_carg", length = 4)
    public String juevCarg;

    /** Legado: VIER_CARG */
    @Column(name = "vier_carg", length = 4)
    public String vierCarg;

    /** Legado: SABA_CARG */
    @Column(name = "saba_carg", length = 4)
    public String sabaCarg;

    /** Legado: DOMI_CARG */
    @Column(name = "domi_carg", length = 4)
    public String domiCarg;

    /** Legado: LUNE_CARG */
    @Column(name = "lune_carg", length = 4)
    public String luneCarg;

    /** Legado: MART_CARG */
    @Column(name = "mart_carg", length = 4)
    public String martCarg;

    /** Legado: MIER_CARG */
    @Column(name = "mier_carg", length = 4)
    public String mierCarg;

    /** Legado: NRO_ASIS */
    @Id
    @Column(name = "nro_asis", length = 1, nullable = false)
    public String nroAsis;

    /** Legado: MESANIO */
    @Column(name = "mesanio", length = 6)
    public String mesanio;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiSema;
        public String codiUnidOper;
        public String codiPers;
        public String nroAsis;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiSema, other.codiSema)
                && Objects.equals(codiUnidOper, other.codiUnidOper)
                && Objects.equals(codiPers, other.codiPers)
                && Objects.equals(nroAsis, other.nroAsis);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiSema, codiUnidOper, codiPers, nroAsis);
        }
    }
}

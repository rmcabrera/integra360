package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.VACACIONES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Vacaciones")
@Table(name = "vacaciones")
@IdClass(Vacaciones.Pk.class)
public class Vacaciones extends LegacyEntity {

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: FECH_INIC */
    @Id
    @Column(name = "fech_inic", nullable = false)
    public LocalDateTime fechInic;

    /** Legado: FECH_TERM */
    @Column(name = "fech_term")
    public LocalDateTime fechTerm;

    /** Legado: NRO_DIAS */
    @Column(name = "nro_dias")
    public Short nroDias;

    /** Legado: ANIO */
    @Column(name = "anio", length = 4, nullable = false)
    public String anio;

    /** Legado: MES */
    @Column(name = "mes", length = 2, nullable = false)
    public String mes;

    /** Legado: ESTA_ACTI */
    @Column(name = "esta_acti")
    public Boolean estaActi;

    /** Legado: OBSERVACIONES */
    @Column(name = "observaciones", length = 200)
    public String observaciones;

    /** Legado: CODI_TIPO_VACA */
    @Column(name = "codi_tipo_vaca", length = 2)
    public String codiTipoVaca;

    /** Legado: ANIO_INI */
    @Column(name = "anio_ini", length = 4)
    public String anioIni;

    /** Legado: ANIO_FIN */
    @Column(name = "anio_fin", length = 4)
    public String anioFin;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPers;
        public LocalDateTime fechInic;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPers, other.codiPers)
                && Objects.equals(fechInic, other.fechInic);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPers, fechInic);
        }
    }
}

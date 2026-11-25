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
 * Tabla legado <b>dbo.TIPO_RIES_TASA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoRiesTasa")
@Table(name = "tipo_ries_tasa")
@IdClass(TipoRiesTasa.Pk.class)
public class TipoRiesTasa extends LegacyEntity {

    /** Legado: CODI_TIPO_RIES */
    @Id
    @Column(name = "codi_tipo_ries", length = 2, nullable = false)
    public String codiTipoRies;

    /** Legado: FECH_INIC */
    @Id
    @Column(name = "fech_inic", nullable = false)
    public LocalDateTime fechInic;

    /** Legado: FECH_FIN */
    @Column(name = "fech_fin")
    public LocalDateTime fechFin;

    /** Legado: CODI_TIPO_PERS */
    @Id
    @Column(name = "codi_tipo_pers", length = 2, nullable = false)
    public String codiTipoPers;

    /** Legado: TASA */
    @Column(name = "tasa", precision = 9, scale = 4)
    public BigDecimal tasa;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiTipoRies;
        public LocalDateTime fechInic;
        public String codiTipoPers;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiTipoRies, other.codiTipoRies)
                && Objects.equals(fechInic, other.fechInic)
                && Objects.equals(codiTipoPers, other.codiTipoPers);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiTipoRies, fechInic, codiTipoPers);
        }
    }
}

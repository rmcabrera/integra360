package pe.sige.ventas.domain.legacy;

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
 * Tabla legado <b>dbo.LIQUIDACION_RUTA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "LiquidacionRuta")
@Table(name = "liquidacion_ruta")
@IdClass(LiquidacionRuta.Pk.class)
public class LiquidacionRuta extends LegacyEntity {

    @Id
    @Column(name = "codi_liqu", nullable = false)
    public Long codiLiqu;

    @Id
    @Column(name = "codi_deta", nullable = false)
    public Integer codiDeta;

    @Column(name = "zona_part", length = 255)
    public String zonaPart;

    @Column(name = "zona_lleg", length = 255)
    public String zonaLleg;

    @Column(name = "flete", precision = 18, scale = 2)
    public BigDecimal flete;

    @Column(name = "fecha_ini")
    public LocalDateTime fechaIni;

    @Column(name = "fecha_fin")
    public LocalDateTime fechaFin;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "codi_orden_soli")
    public Long codiOrdenSoli;

    @Column(name = "placa_tracto", length = 5)
    public String placaTracto;

    @Column(name = "placa_carreta", length = 5)
    public String placaCarreta;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiLiqu;
        public Integer codiDeta;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiLiqu, other.codiLiqu)
                && Objects.equals(codiDeta, other.codiDeta);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiLiqu, codiDeta);
        }
    }
}

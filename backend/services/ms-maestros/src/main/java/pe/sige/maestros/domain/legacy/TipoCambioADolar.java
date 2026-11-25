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
 * Tabla legado <b>dbo.TIPO_CAMBIO_A_DOLAR</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "TipoCambioADolar")
@Table(name = "tipo_cambio_a_dolar")
@IdClass(TipoCambioADolar.Pk.class)
public class TipoCambioADolar extends LegacyEntity {

    /** Legado: CODI_MONE_ORIG */
    @Id
    @Column(name = "codi_mone_orig", length = 2, nullable = false)
    public String codiMoneOrig;

    /** Legado: FECH_CAMB */
    @Id
    @Column(name = "fech_camb", nullable = false)
    public LocalDateTime fechCamb;

    /** Legado: COMPRA */
    @Column(name = "compra", precision = 9, scale = 4)
    public BigDecimal compra;

    /** Legado: VENTA */
    @Column(name = "venta", precision = 9, scale = 4)
    public BigDecimal venta;

    /** Legado: CODI_MONE_CAMB */
    @Id
    @Column(name = "codi_mone_camb", length = 2, nullable = false)
    public String codiMoneCamb;

    /** Legado: VENTA_COMER_D_A_S */
    @Column(name = "venta_comer_d_a_s", precision = 9, scale = 4)
    public BigDecimal ventaComerDAS;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiMoneOrig;
        public LocalDateTime fechCamb;
        public String codiMoneCamb;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiMoneOrig, other.codiMoneOrig)
                && Objects.equals(fechCamb, other.fechCamb)
                && Objects.equals(codiMoneCamb, other.codiMoneCamb);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiMoneOrig, fechCamb, codiMoneCamb);
        }
    }
}

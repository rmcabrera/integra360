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
 * Tabla legado <b>dbo.FACTURA_ANTICIPOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "FacturaAnticipos")
@Table(name = "factura_anticipos")
@IdClass(FacturaAnticipos.Pk.class)
public class FacturaAnticipos extends LegacyEntity {

    @Id
    @Column(name = "codi_fact", length = 10, nullable = false)
    public String codiFact;

    @Id
    @Column(name = "id_sec", nullable = false)
    public Integer idSec;

    @Column(name = "codi_tipo_docu", length = 4)
    public String codiTipoDocu;

    @Column(name = "serie", length = 10)
    public String serie;

    @Column(name = "numero", length = 20)
    public String numero;

    @Column(name = "fecha_pago_rece")
    public LocalDateTime fechaPagoRece;

    @Column(name = "fecha_pago_efec")
    public LocalDateTime fechaPagoEfec;

    @Column(name = "monto_anti", precision = 18, scale = 2)
    public BigDecimal montoAnti;

    /** Legado: Descripcion */
    @Column(name = "descripcion", length = 200)
    public String descripcion;

    /** Legado: Hora_pago */
    @Column(name = "hora_pago")
    public LocalDateTime horaPago;

    /** Legado: Precio */
    @Column(name = "precio", precision = 12, scale = 2)
    public BigDecimal precio;

    /** Legado: codi_Fact_anti */
    @Column(name = "codi_fact_anti", length = 10)
    public String codiFactAnti;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiFact;
        public Integer idSec;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiFact, other.codiFact)
                && Objects.equals(idSec, other.idSec);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiFact, idSec);
        }
    }
}

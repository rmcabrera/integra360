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
 * Tabla legado <b>dbo.SUBSIDIOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Subsidios")
@Table(name = "subsidios")
@IdClass(Subsidios.Pk.class)
public class Subsidios extends LegacyEntity {

    @Column(name = "mesanio", length = 6, nullable = false)
    public String mesanio;

    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    @Id
    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    @Column(name = "codi_carg", length = 4, nullable = false)
    public String codiCarg;

    @Column(name = "monto", precision = 12, scale = 2)
    public BigDecimal monto;

    @Column(name = "dias")
    public Integer dias;

    /** Legado: CODI_SEMA */
    @Id
    @Column(name = "codi_sema", length = 8, nullable = false)
    public String codiSema;

    @Id
    @Column(name = "certificado", length = 50, nullable = false)
    public String certificado;

    @Column(name = "fecha_inicio")
    public LocalDateTime fechaInicio;

    @Column(name = "fecha_fin")
    public LocalDateTime fechaFin;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    @Column(name = "tipocambio", precision = 18, scale = 3)
    public BigDecimal tipocambio;

    @Column(name = "pagoempresa", length = 1)
    public String pagoempresa;

    @Column(name = "pagoessalud", length = 1)
    public String pagoessalud;

    @Column(name = "fechapago")
    public LocalDateTime fechapago;

    @Column(name = "observaciones", length = 250)
    public String observaciones;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPers;
        public String codiUnidOper;
        public String codiSema;
        public String certificado;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPers, other.codiPers)
                && Objects.equals(codiUnidOper, other.codiUnidOper)
                && Objects.equals(codiSema, other.codiSema)
                && Objects.equals(certificado, other.certificado);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPers, codiUnidOper, codiSema, certificado);
        }
    }
}

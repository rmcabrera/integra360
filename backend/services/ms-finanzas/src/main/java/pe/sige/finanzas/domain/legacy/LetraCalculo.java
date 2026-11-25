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
 * Tabla legado <b>dbo.Letra_Calculo</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "LetraCalculo")
@Table(name = "letra_calculo")
@IdClass(LetraCalculo.Pk.class)
public class LetraCalculo extends LegacyEntity {

    /** Legado: Codi_Letra */
    @Id
    @Column(name = "codi_letra", length = 3, nullable = false)
    public String codiLetra;

    /** Legado: Anio */
    @Id
    @Column(name = "anio", length = 4, nullable = false)
    public String anio;

    /** Legado: Codi_Contable */
    @Column(name = "codi_contable", length = 10)
    public String codiContable;

    /** Legado: Nro_Cuen_Banco */
    @Column(name = "nro_cuen_banco", length = 7)
    public String nroCuenBanco;

    /** Legado: Nro_Cuen_Amor */
    @Column(name = "nro_cuen_amor", length = 7)
    public String nroCuenAmor;

    /** Legado: Nro_Cuen_Inte */
    @Column(name = "nro_cuen_inte", length = 7)
    public String nroCuenInte;

    /** Legado: Fech_Venc */
    @Column(name = "fech_venc")
    public LocalDateTime fechVenc;

    /** Legado: Importe_Amor */
    @Column(name = "importe_amor", precision = 18, scale = 2)
    public BigDecimal importeAmor;

    /** Legado: Importe_Inte */
    @Column(name = "importe_inte", precision = 18, scale = 2)
    public BigDecimal importeInte;

    /** Legado: Tipo_Situ */
    @Column(name = "tipo_situ", length = 2)
    public String tipoSitu;

    /** Legado: Observacion */
    @Column(name = "observacion", length = 50)
    public String observacion;

    /** Legado: Fecha */
    @Column(name = "fecha")
    public LocalDateTime fecha;

    /** Legado: Tipo */
    @Id
    @Column(name = "tipo", length = 1, nullable = false)
    public String tipo;

    /** Legado: Saldo */
    @Column(name = "saldo", precision = 18, scale = 2)
    public BigDecimal saldo;

    /** Legado: Codi_Mone */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiLetra;
        public String anio;
        public String tipo;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiLetra, other.codiLetra)
                && Objects.equals(anio, other.anio)
                && Objects.equals(tipo, other.tipo);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiLetra, anio, tipo);
        }
    }
}

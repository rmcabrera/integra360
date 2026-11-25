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
 * Tabla legado <b>dbo.DEPOSITOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Depositos")
@Table(name = "depositos")
@IdClass(Depositos.Pk.class)
public class Depositos extends LegacyEntity {

    @Id
    @Column(name = "codi_depo", length = 10, nullable = false)
    public String codiDepo;

    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;

    @Id
    @Column(name = "codi_alma", length = 2, nullable = false)
    public String codiAlma;

    @Column(name = "nro_oper", length = 100)
    public String nroOper;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "codi_respo", length = 5)
    public String codiRespo;

    @Column(name = "codi_usua_soli", length = 5)
    public String codiUsuaSoli;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    @Column(name = "importe", precision = 18, scale = 2)
    public BigDecimal importe;

    @Column(name = "glosa", length = 200)
    public String glosa;

    @Column(name = "fecha_depo")
    public LocalDateTime fechaDepo;

    @Column(name = "estado", length = 1)
    public String estado;

    @Column(name = "tipo", length = 1)
    public String tipo;

    @Column(name = "creacion")
    public LocalDateTime creacion;

    @Column(name = "codi_vouc", length = 10)
    public String codiVouc;

    @Column(name = "hecho_por", length = 5)
    public String hechoPor;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiDepo;
        public String codiAlma;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiDepo, other.codiDepo)
                && Objects.equals(codiAlma, other.codiAlma);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiDepo, codiAlma);
        }
    }
}

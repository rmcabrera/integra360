package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.REGISTRO_PRODUCTO_DETA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "RegistroProductoDeta")
@Table(name = "registro_producto_deta")
@IdClass(RegistroProductoDeta.Pk.class)
public class RegistroProductoDeta extends LegacyEntity {

    @Id
    @Column(name = "codi_regi_prod", nullable = false)
    public Long codiRegiProd;

    @Id
    @Column(name = "codi_deta", nullable = false)
    public Integer codiDeta;

    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    @Column(name = "cantidad", precision = 18, scale = 3)
    public BigDecimal cantidad;

    @Column(name = "q1_1", precision = 18, scale = 3)
    public BigDecimal q11;

    @Column(name = "q2_1", precision = 18, scale = 3)
    public BigDecimal q21;

    @Column(name = "q1_2", precision = 18, scale = 3)
    public BigDecimal q12;

    @Column(name = "q2_2", precision = 18, scale = 3)
    public BigDecimal q22;

    @Column(name = "q1_3", precision = 18, scale = 3)
    public BigDecimal q13;

    @Column(name = "q2_3", precision = 18, scale = 3)
    public BigDecimal q23;

    @Column(name = "q1_4", precision = 18, scale = 3)
    public BigDecimal q14;

    @Column(name = "q2_4", precision = 18, scale = 3)
    public BigDecimal q24;

    @Column(name = "q1_5", precision = 18, scale = 3)
    public BigDecimal q15;

    @Column(name = "q2_5", precision = 18, scale = 3)
    public BigDecimal q25;

    @Column(name = "q1_6", precision = 18, scale = 3)
    public BigDecimal q16;

    @Column(name = "q2_6", precision = 18, scale = 3)
    public BigDecimal q26;

    @Column(name = "nro_diacult")
    public Integer nroDiacult;

    @Column(name = "cod_eta")
    public Long codEta;

    @Column(name = "enfermedades", length = 150)
    public String enfermedades;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiRegiProd;
        public Integer codiDeta;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiRegiProd, other.codiRegiProd)
                && Objects.equals(codiDeta, other.codiDeta);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiRegiProd, codiDeta);
        }
    }
}

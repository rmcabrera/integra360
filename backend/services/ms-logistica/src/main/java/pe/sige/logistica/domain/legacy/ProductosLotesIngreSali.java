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
 * Tabla legado <b>dbo.PRODUCTOS_LOTES_INGRE_SALI</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ProductosLotesIngreSali")
@Table(name = "productos_lotes_ingre_sali")
@IdClass(ProductosLotesIngreSali.Pk.class)
public class ProductosLotesIngreSali extends LegacyEntity {

    /** codigo segun ingreso o salida */
    @Id
    @Column(name = "codi_deta_ingre_sali", length = 12, nullable = false)
    public String codiDetaIngreSali;

    @Id
    @Column(name = "codi_prod_alma_lote", nullable = false)
    public Long codiProdAlmaLote;

    @Column(name = "cantidad", precision = 18, scale = 2)
    public BigDecimal cantidad;

    /** 1=ingreso,2=salida */
    @Id
    @Column(name = "io", nullable = false)
    public Integer io;

    @Column(name = "codi_ingr_sali", length = 10)
    public String codiIngrSali;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiDetaIngreSali;
        public Long codiProdAlmaLote;
        public Integer io;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiDetaIngreSali, other.codiDetaIngreSali)
                && Objects.equals(codiProdAlmaLote, other.codiProdAlmaLote)
                && Objects.equals(io, other.io);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiDetaIngreSali, codiProdAlmaLote, io);
        }
    }
}

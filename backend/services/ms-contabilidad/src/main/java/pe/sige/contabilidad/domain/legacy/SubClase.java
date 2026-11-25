package pe.sige.contabilidad.domain.legacy;

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
 * Tabla legado <b>dbo.SUB_CLASE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SubClase")
@Table(name = "sub_clase")
@IdClass(SubClase.Pk.class)
public class SubClase extends LegacyEntity {

    /** Legado: Cod_clase */
    @Id
    @Column(name = "cod_clase", length = 3, nullable = false)
    public String codClase;

    /** Legado: Cod_subclase */
    @Id
    @Column(name = "cod_subclase", length = 3, nullable = false)
    public String codSubclase;

    /** Legado: Nomb_subclase */
    @Column(name = "nomb_subclase", length = 40, nullable = false)
    public String nombSubclase;

    /** Legado: Id_Bien_Detraccion */
    @Column(name = "id_bien_detraccion", length = 2)
    public String idBienDetraccion;

    /** Legado: Tasa_Detraccion */
    @Column(name = "tasa_detraccion", precision = 18, scale = 4)
    public BigDecimal tasaDetraccion;

    @Column(name = "unidad_negocio", length = 10)
    public String unidadNegocio;

    /** Legado: Unidad */
    @Column(name = "unidad", length = 8)
    public String unidad;

    @Column(name = "flag_cargo_directo", length = 1)
    public String flagCargoDirecto;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codClase;
        public String codSubclase;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codClase, other.codClase)
                && Objects.equals(codSubclase, other.codSubclase);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codClase, codSubclase);
        }
    }
}

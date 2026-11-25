package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ZARP_OBSE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ZarpObse")
@Table(name = "zarp_obse")
@IdClass(ZarpObse.Pk.class)
public class ZarpObse extends LegacyEntity {

    /** Legado: CODI_ZARP */
    @Id
    @Column(name = "codi_zarp", length = 10, nullable = false)
    public String codiZarp;

    /** Legado: NRO_OBSE */
    @Id
    @Column(name = "nro_obse", nullable = false)
    public Short nroObse;

    /** Legado: DESC_OBSE */
    @Column(name = "desc_obse", length = 250)
    public String descObse;

    /** Legado: NRO_CUEN */
    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;

    /** Legado: CODI_SIST_EMBA */
    @Column(name = "codi_sist_emba", length = 2)
    public String codiSistEmba;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiZarp;
        public Short nroObse;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiZarp, other.codiZarp)
                && Objects.equals(nroObse, other.nroObse);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiZarp, nroObse);
        }
    }
}

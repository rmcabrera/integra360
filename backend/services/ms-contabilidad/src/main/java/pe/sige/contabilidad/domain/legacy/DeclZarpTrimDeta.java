package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.DECL_ZARP_TRIM_DETA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DeclZarpTrimDeta")
@Table(name = "decl_zarp_trim_deta")
@IdClass(DeclZarpTrimDeta.Pk.class)
public class DeclZarpTrimDeta extends LegacyEntity {

    /** Legado: CODI_ZARP_TRIM */
    @Id
    @Column(name = "codi_zarp_trim", length = 10, nullable = false)
    public String codiZarpTrim;

    /** Legado: NRO_ITEM */
    @Id
    @Column(name = "nro_item", length = 2, nullable = false)
    public String nroItem;

    /** Legado: CODI_PERS */
    @Column(name = "codi_pers", length = 5)
    public String codiPers;

    /** Legado: NRO_MATR_PERS */
    @Column(name = "nro_matr_pers", length = 30)
    public String nroMatrPers;

    /** Legado: FIN_VIGE_MATR */
    @Column(name = "fin_vige_matr")
    public LocalDateTime finVigeMatr;

    /** Legado: CODI_CARG */
    @Column(name = "codi_carg", length = 4)
    public String codiCarg;

    /** Legado: CODI_TITU */
    @Column(name = "codi_titu", length = 2)
    public String codiTitu;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiZarpTrim;
        public String nroItem;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiZarpTrim, other.codiZarpTrim)
                && Objects.equals(nroItem, other.nroItem);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiZarpTrim, nroItem);
        }
    }
}

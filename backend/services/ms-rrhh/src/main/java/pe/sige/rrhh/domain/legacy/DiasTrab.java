package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Dias_Trab</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DiasTrab")
@Table(name = "dias_trab")
@IdClass(DiasTrab.Pk.class)
public class DiasTrab extends LegacyEntity {

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: CODI_UNID_OPER */
    @Id
    @Column(name = "codi_unid_oper", length = 5, nullable = false)
    public String codiUnidOper;

    /** Legado: CODI_SEMA */
    @Id
    @Column(name = "codi_sema", length = 8, nullable = false)
    public String codiSema;

    /** Legado: DIAS */
    @Column(name = "dias")
    public Long dias;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPers;
        public String codiUnidOper;
        public String codiSema;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPers, other.codiPers)
                && Objects.equals(codiUnidOper, other.codiUnidOper)
                && Objects.equals(codiSema, other.codiSema);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPers, codiUnidOper, codiSema);
        }
    }
}

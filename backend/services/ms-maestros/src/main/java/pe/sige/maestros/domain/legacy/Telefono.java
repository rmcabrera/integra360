package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.TELEFONO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Telefono")
@Table(name = "telefono")
@IdClass(Telefono.Pk.class)
public class Telefono extends LegacyEntity {

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: NRO_TELE */
    @Id
    @Column(name = "nro_tele", length = 12, nullable = false)
    public String nroTele;

    /** Legado: TIPO_TELE */
    @Column(name = "tipo_tele", length = 20)
    public String tipoTele;

    /** Legado: OBSERVACION */
    @Column(name = "observacion", length = 50)
    public String observacion;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPers;
        public String nroTele;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPers, other.codiPers)
                && Objects.equals(nroTele, other.nroTele);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPers, nroTele);
        }
    }
}

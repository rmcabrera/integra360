package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.DECLARA_JURADA_MERCA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DeclaraJuradaMerca")
@Table(name = "declara_jurada_merca")
@IdClass(DeclaraJuradaMerca.Pk.class)
public class DeclaraJuradaMerca extends LegacyEntity {

    @Id
    @Column(name = "codi_decla", nullable = false)
    public Long codiDecla;

    @Id
    @Column(name = "codi_lin", length = 2, nullable = false)
    public String codiLin;

    @Column(name = "monto_linea")
    public Long montoLinea;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiDecla;
        public String codiLin;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiDecla, other.codiDecla)
                && Objects.equals(codiLin, other.codiLin);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiDecla, codiLin);
        }
    }
}

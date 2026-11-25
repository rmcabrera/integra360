package pe.sige.maestros.domain.legacy;

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
 * Tabla legado <b>dbo.FERIADOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Feriados")
@Table(name = "feriados")
@IdClass(Feriados.Pk.class)
public class Feriados extends LegacyEntity {

    /** Legado: MES */
    @Id
    @Column(name = "mes", length = 2, nullable = false)
    public String mes;

    /** Legado: DIA */
    @Id
    @Column(name = "dia", length = 2, nullable = false)
    public String dia;

    /** Legado: ANIO */
    @Id
    @Column(name = "anio", length = 4, nullable = false)
    public String anio;

    /** Legado: DESC_FERI */
    @Column(name = "desc_feri", length = 50, nullable = false)
    public String descFeri;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String mes;
        public String dia;
        public String anio;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(mes, other.mes)
                && Objects.equals(dia, other.dia)
                && Objects.equals(anio, other.anio);
        }

        @Override
        public int hashCode() {
            return Objects.hash(mes, dia, anio);
        }
    }
}

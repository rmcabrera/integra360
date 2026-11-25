package pe.sige.rrhh.domain.legacy;

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
 * Tabla legado <b>dbo.CONSTANCIA_JUICIOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ConstanciaJuicios")
@Table(name = "constancia_juicios")
@IdClass(ConstanciaJuicios.Pk.class)
public class ConstanciaJuicios extends LegacyEntity {

    @Id
    @Column(name = "codi_juic", length = 6, nullable = false)
    public String codiJuic;

    @Id
    @Column(name = "nro_pago", length = 4, nullable = false)
    public String nroPago;

    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    @Column(name = "registro", length = 10)
    public String registro;

    @Column(name = "bene_juic", length = 200)
    public String beneJuic;

    @Column(name = "nro_reso", length = 50)
    public String nroReso;

    @Column(name = "juzgado", length = 200)
    public String juzgado;

    @Column(name = "valor", precision = 12, scale = 2)
    public BigDecimal valor;

    /** Legado: SEMANA */
    @Id
    @Column(name = "semana", length = 8, nullable = false)
    public String semana;

    /** Legado: FECHA */
    @Column(name = "fecha")
    public LocalDateTime fecha;

    /** Legado: DNI */
    @Column(name = "dni", length = 11)
    public String dni;

    /** Legado: nro_Asis */
    @Column(name = "nro_asis", length = 1)
    public String nroAsis;

    @Column(name = "tipo", length = 1)
    public String tipo;

    @Column(name = "mesanio", length = 6)
    public String mesanio;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiJuic;
        public String nroPago;
        public String codiPers;
        public String semana;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiJuic, other.codiJuic)
                && Objects.equals(nroPago, other.nroPago)
                && Objects.equals(codiPers, other.codiPers)
                && Objects.equals(semana, other.semana);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiJuic, nroPago, codiPers, semana);
        }
    }
}

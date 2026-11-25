package pe.sige.finanzas.domain.legacy;

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
 * Tabla legado <b>dbo.CAJA_CHICA_DEPO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CajaChicaDepo")
@Table(name = "caja_chica_depo")
@IdClass(CajaChicaDepo.Pk.class)
public class CajaChicaDepo extends LegacyEntity {

    @Id
    @Column(name = "codi_depo", length = 10, nullable = false)
    public String codiDepo;

    @Id
    @Column(name = "codi_docu", length = 10, nullable = false)
    public String codiDocu;

    @Column(name = "tipo_rela", length = 1)
    public String tipoRela;

    @Column(name = "codi_tipo_docu", length = 4)
    public String codiTipoDocu;

    @Column(name = "ser_fact", length = 10)
    public String serFact;

    @Column(name = "nro_fact", length = 20)
    public String nroFact;

    @Column(name = "tota_fact", precision = 12, scale = 3)
    public BigDecimal totaFact;

    @Column(name = "importe", precision = 18, scale = 3)
    public BigDecimal importe;

    @Column(name = "grupo")
    public Integer grupo;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiDepo;
        public String codiDocu;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiDepo, other.codiDepo)
                && Objects.equals(codiDocu, other.codiDocu);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiDepo, codiDocu);
        }
    }
}

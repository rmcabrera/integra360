package pe.sige.logistica.domain.legacy;

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
 * Tabla legado <b>dbo.ACEPTACION_LISTA_REQUE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "AceptacionListaReque")
@Table(name = "aceptacion_lista_reque")
@IdClass(AceptacionListaReque.Pk.class)
public class AceptacionListaReque extends LegacyEntity {

    /** Legado: CODI_DETA_LIST_REQU */
    @Id
    @Column(name = "codi_deta_list_requ", length = 10, nullable = false)
    public String codiDetaListRequ;

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: ACEPTACION */
    @Column(name = "aceptacion")
    public Boolean aceptacion;

    /** Legado: NRO_JERA */
    @Column(name = "nro_jera")
    public Short nroJera;

    /** Legado: FECH_ACEP */
    @Column(name = "fech_acep")
    public LocalDateTime fechAcep;

    /** CANTIDAD ACEPTADA */
    @Column(name = "cantidad", precision = 9, scale = 2)
    public BigDecimal cantidad;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiDetaListRequ;
        public String codiPers;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiDetaListRequ, other.codiDetaListRequ)
                && Objects.equals(codiPers, other.codiPers);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiDetaListRequ, codiPers);
        }
    }
}

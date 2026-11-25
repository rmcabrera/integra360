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
 * Tabla legado <b>dbo.VALE_SALIDA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ValeSalida")
@Table(name = "vale_salida")
@IdClass(ValeSalida.Pk.class)
public class ValeSalida extends LegacyEntity {

    @Id
    @Column(name = "codi_sali", nullable = false)
    public Long codiSali;

    @Id
    @Column(name = "codi_alma", length = 2, nullable = false)
    public String codiAlma;

    @Column(name = "nro_vale")
    public Long nroVale;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    @Column(name = "codi_tipo_docu", length = 4)
    public String codiTipoDocu;

    @Column(name = "serie", length = 3)
    public String serie;

    @Column(name = "numero", length = 10)
    public String numero;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    /** Legado: CODI_MOTI_TRAS */
    @Column(name = "codi_moti_tras", length = 2)
    public String codiMotiTras;

    @Column(name = "tpc", precision = 18, scale = 4)
    public BigDecimal tpc;

    @Column(name = "observacion", length = 250)
    public String observacion;

    @Column(name = "codi_alma_dest", length = 2)
    public String codiAlmaDest;

    @Column(name = "codi_pers", length = 5)
    public String codiPers;

    @Column(name = "correlativo")
    public Long correlativo;

    @Column(name = "codi_orde")
    public Long codiOrde;

    @Column(name = "anulado", length = 1)
    public String anulado;

    @Column(name = "subt", precision = 18, scale = 2)
    public BigDecimal subt;

    @Column(name = "igv", precision = 18, scale = 2)
    public BigDecimal igv;

    @Column(name = "total", precision = 18, scale = 2)
    public BigDecimal total;

    @Column(name = "transporte", length = 5)
    public String transporte;

    @Column(name = "placa", length = 10)
    public String placa;

    @Column(name = "prov_dest", length = 5)
    public String provDest;

    @Column(name = "chofer", length = 4)
    public String chofer;

    @Column(name = "periodo", length = 4)
    public String periodo;

    @Column(name = "indice_rela")
    public Long indiceRela;

    @Column(name = "procedencia", length = 3)
    public String procedencia;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiSali;
        public String codiAlma;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiSali, other.codiSali)
                && Objects.equals(codiAlma, other.codiAlma);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiSali, codiAlma);
        }
    }
}

package pe.sige.finanzas.domain.legacy;

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
 * Tabla legado <b>dbo.CAJA_CHICA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CajaChica")
@Table(name = "caja_chica")
@IdClass(CajaChica.Pk.class)
public class CajaChica extends LegacyEntity {

    @Id
    @Column(name = "codi_alma", length = 2, nullable = false)
    public String codiAlma;

    @Id
    @Column(name = "nro_recibo", length = 10, nullable = false)
    public String nroRecibo;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Id
    @Column(name = "tipo_io", nullable = false)
    public Integer tipoIo;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "glosa", length = 150)
    public String glosa;

    @Column(name = "codi_tipo_docu", length = 4)
    public String codiTipoDocu;

    @Column(name = "serie", length = 10)
    public String serie;

    @Column(name = "nro_docu", length = 20)
    public String nroDocu;

    @Column(name = "tipo_contab", length = 3)
    public String tipoContab;

    @Column(name = "importe", precision = 18, scale = 3)
    public BigDecimal importe;

    @Column(name = "codi_usua_soli", length = 5)
    public String codiUsuaSoli;

    @Column(name = "prov_canc", length = 1)
    public String provCanc;

    /** Legado: hora_Real */
    @Column(name = "hora_real")
    public LocalDateTime horaReal;

    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    @Column(name = "placa_carreta", length = 5)
    public String placaCarreta;

    @Column(name = "rendir", length = 1)
    public String rendir;

    @Column(name = "nro_recibo_aux", length = 10)
    public String nroReciboAux;

    @Column(name = "codi_liqu")
    public Long codiLiqu;

    @Column(name = "importe_s", precision = 18, scale = 3)
    public BigDecimal importeS;

    @Column(name = "ruta_de", length = 200)
    public String rutaDe;

    @Column(name = "ruta_a", length = 200)
    public String rutaA;

    @Column(name = "fecha_docu")
    public LocalDateTime fechaDocu;

    @Column(name = "placa", length = 5)
    public String placa;

    @Column(name = "galones", precision = 18, scale = 2)
    public BigDecimal galones;

    @Column(name = "km_ini", precision = 18, scale = 2)
    public BigDecimal kmIni;

    @Column(name = "km_fin", precision = 18, scale = 2)
    public BigDecimal kmFin;

    @Column(name = "fecha_vence")
    public LocalDateTime fechaVence;

    @Column(name = "dscto_adm", length = 1)
    public String dsctoAdm;

    @Column(name = "hecho_por", length = 5)
    public String hechoPor;

    @Column(name = "estado", length = 1)
    public String estado;

    @Column(name = "activo", length = 1)
    public String activo;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiAlma;
        public String nroRecibo;
        public Integer tipoIo;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiAlma, other.codiAlma)
                && Objects.equals(nroRecibo, other.nroRecibo)
                && Objects.equals(tipoIo, other.tipoIo);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiAlma, nroRecibo, tipoIo);
        }
    }
}

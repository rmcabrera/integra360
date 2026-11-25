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
 * Tabla legado <b>dbo.KARDEX_ALMACENES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "KardexAlmacenes")
@Table(name = "kardex_almacenes")
@IdClass(KardexAlmacenes.Pk.class)
public class KardexAlmacenes extends LegacyEntity {

    @Column(name = "codigo")
    public Long codigo;

    @Id
    @Column(name = "codi_transa", nullable = false)
    public Long codiTransa;

    @Id
    @Column(name = "codi_alma", length = 2, nullable = false)
    public String codiAlma;

    @Id
    @Column(name = "item", nullable = false)
    public Integer item;

    @Id
    @Column(name = "codi_prod", length = 8, nullable = false)
    public String codiProd;

    @Id
    @Column(name = "i_o", length = 1, nullable = false)
    public String iO;

    @Column(name = "cantidad", precision = 18, scale = 4)
    public BigDecimal cantidad;

    @Column(name = "precio", precision = 18, scale = 4)
    public BigDecimal precio;

    @Column(name = "total", precision = 18, scale = 2)
    public BigDecimal total;

    @Column(name = "codi_unid_medi", length = 50)
    public String codiUnidMedi;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    @Column(name = "tipo_cambio", precision = 18, scale = 4)
    public BigDecimal tipoCambio;

    @Column(name = "ingr_cant", precision = 18, scale = 4)
    public BigDecimal ingrCant;

    @Column(name = "sali_cant", precision = 18, scale = 4)
    public BigDecimal saliCant;

    @Column(name = "prec_unit", precision = 18, scale = 4)
    public BigDecimal precUnit;

    @Column(name = "prec_prom", precision = 18, scale = 4)
    public BigDecimal precProm;

    @Column(name = "stock", precision = 18, scale = 4)
    public BigDecimal stock;

    @Column(name = "ingr_valo", precision = 18, scale = 4)
    public BigDecimal ingrValo;

    @Column(name = "egre_valo", precision = 18, scale = 4)
    public BigDecimal egreValo;

    @Column(name = "saldo_valo", precision = 18, scale = 4)
    public BigDecimal saldoValo;

    @Column(name = "periodo")
    public Integer periodo;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "exonerado", length = 1)
    public String exonerado;

    @Column(name = "igv", precision = 18, scale = 2)
    public BigDecimal igv;

    @Column(name = "venta", precision = 18, scale = 2)
    public BigDecimal venta;

    @Column(name = "valorigv", precision = 18, scale = 2)
    public BigDecimal valorigv;

    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;

    /** Legado: Productor */
    @Column(name = "productor", length = 5)
    public String productor;

    @Column(name = "acidez", precision = 18, scale = 3)
    public BigDecimal acidez;

    @Column(name = "cantcolpex", precision = 18, scale = 4)
    public BigDecimal cantcolpex;

    @Column(name = "entradafisico", precision = 18, scale = 4)
    public BigDecimal entradafisico;

    @Column(name = "salidafisico", precision = 18, scale = 4)
    public BigDecimal salidafisico;

    @Column(name = "promfisico", precision = 18, scale = 4)
    public BigDecimal promfisico;

    @Column(name = "stockfisico", precision = 18, scale = 4)
    public BigDecimal stockfisico;

    @Column(name = "ingresofisico", precision = 18, scale = 4)
    public BigDecimal ingresofisico;

    @Column(name = "egresofisico", precision = 18, scale = 4)
    public BigDecimal egresofisico;

    @Column(name = "saldofisico", precision = 18, scale = 4)
    public BigDecimal saldofisico;

    @Column(name = "transporte", length = 4)
    public String transporte;

    @Column(name = "placa", length = 10)
    public String placa;

    @Column(name = "ticket", length = 10)
    public String ticket;

    @Column(name = "codi_tipo_docu", length = 4)
    public String codiTipoDocu;

    @Column(name = "serguia", length = 5)
    public String serguia;

    @Column(name = "nroguia", length = 10)
    public String nroguia;

    @Column(name = "codi_moti_tras", length = 2)
    public String codiMotiTras;

    @Column(name = "nro_vales")
    public Long nroVales;

    @Column(name = "indice_rela")
    public Long indiceRela;

    /** Legado: Codi_Tipo_Enva */
    @Column(name = "codi_tipo_enva")
    public Short codiTipoEnva;

    /** Legado: Num_Enva */
    @Column(name = "num_enva")
    public Short numEnva;

    /** Legado: Exceso */
    @Column(name = "exceso", precision = 18, scale = 4)
    public BigDecimal exceso;

    /** Legado: Faltante */
    @Column(name = "faltante", precision = 18, scale = 4)
    public BigDecimal faltante;

    /** Legado: Observaciones */
    @Column(name = "observaciones", length = 50)
    public String observaciones;

    /** Legado: Concen_IQF */
    @Column(name = "concen_iqf", precision = 18, scale = 2)
    public BigDecimal concenIqf;

    /** Legado: ProdServIQF */
    @Column(name = "prodserviqf", length = 50)
    public String prodserviqf;

    /** Legado: Canti_ProdServIQF */
    @Column(name = "canti_prodserviqf")
    public Long cantiProdserviqf;

    /** Legado: UM_ProdServIQF */
    @Column(name = "um_prodserviqf", length = 2)
    public String umProdserviqf;

    /** Legado: DeseIQF */
    @Column(name = "deseiqf", length = 50)
    public String deseiqf;

    /** Legado: Canti_DeseIQF */
    @Column(name = "canti_deseiqf")
    public Long cantiDeseiqf;

    /** Legado: UM_DeseIQF */
    @Column(name = "um_deseiqf", length = 2)
    public String umDeseiqf;

    /** Legado: Canti_RHPM_IQF */
    @Column(name = "canti_rhpm_iqf")
    public Long cantiRhpmIqf;

    /** Legado: UM_RHPM_IQF */
    @Column(name = "um_rhpm_iqf", length = 2)
    public String umRhpmIqf;

    /** Legado: Moti_RHPM_IQF */
    @Column(name = "moti_rhpm_iqf", length = 50)
    public String motiRhpmIqf;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public Long codiTransa;
        public String codiAlma;
        public Integer item;
        public String codiProd;
        public String iO;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiTransa, other.codiTransa)
                && Objects.equals(codiAlma, other.codiAlma)
                && Objects.equals(item, other.item)
                && Objects.equals(codiProd, other.codiProd)
                && Objects.equals(iO, other.iO);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiTransa, codiAlma, item, codiProd, iO);
        }
    }
}

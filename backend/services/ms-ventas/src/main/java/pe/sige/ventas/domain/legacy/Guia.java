package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.GUIA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Guia")
@Table(name = "guia")
public class Guia extends LegacyEntity {

    /** Legado: Codi_Guia */
    @Id
    @Column(name = "codi_guia", nullable = false)
    public Long codiGuia;

    @Column(name = "ser_guia", length = 4)
    public String serGuia;

    @Column(name = "nro_guia", nullable = false)
    public Integer nroGuia;

    @Column(name = "fech_tras")
    public LocalDateTime fechTras;

    @Column(name = "punto_partida", length = 150)
    public String puntoPartida;

    @Column(name = "e_p", length = 250)
    public String eP;

    @Column(name = "orde_compr", length = 50)
    public String ordeCompr;

    @Column(name = "codi_clie_dest", length = 5)
    public String codiClieDest;

    @Column(name = "punto_llegada", length = 150)
    public String puntoLlegada;

    @Column(name = "codi_trans", length = 5)
    public String codiTrans;

    @Column(name = "placa_vehi", length = 50)
    public String placaVehi;

    /** Legado: CODI_MOTI_TRAS */
    @Column(name = "codi_moti_tras", length = 2)
    public String codiMotiTras;

    @Column(name = "otros_obs", length = 150)
    public String otrosObs;

    @Column(name = "codi_fact", length = 10)
    public String codiFact;

    @Column(name = "marca_placa", length = 50)
    public String marcaPlaca;

    @Column(name = "nro_licencia", length = 50)
    public String nroLicencia;

    @Column(name = "peso_total", precision = 18, scale = 3)
    public BigDecimal pesoTotal;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    @Column(name = "sub_total", precision = 18, scale = 2)
    public BigDecimal subTotal;

    @Column(name = "igv_venta", precision = 18, scale = 2)
    public BigDecimal igvVenta;

    /** Legado: Total_venta */
    @Column(name = "total_venta", precision = 18, scale = 2)
    public BigDecimal totalVenta;

    @Column(name = "codi_docu_sali", length = 10)
    public String codiDocuSali;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "codi_alma_desti", length = 2)
    public String codiAlmaDesti;

    @Column(name = "estado", length = 1)
    public String estado;

    @Column(name = "codi_unid_vehi", length = 5)
    public String codiUnidVehi;

    @Column(name = "codi_chof", length = 4)
    public String codiChof;

    @Column(name = "ruc_dni", length = 15)
    public String rucDni;

    @Column(name = "codi_orden_pedi")
    public Long codiOrdenPedi;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "nom_terc", length = 100)
    public String nomTerc;

    @Column(name = "const_ins", length = 50)
    public String constIns;

    @Column(name = "observaciones", length = 255)
    public String observaciones;

    @Column(name = "apro_por", length = 5)
    public String aproPor;

    @Column(name = "creacion")
    public LocalDateTime creacion;

    @Column(name = "envio", length = 1)
    public String envio;

    @Column(name = "tipo_gene", length = 1)
    public String tipoGene;

    @Column(name = "dist_part")
    public Integer distPart;

    @Column(name = "dist_dest")
    public Integer distDest;

    @Column(name = "codi_unid_medi_peso", length = 2)
    public String codiUnidMediPeso;

    @Column(name = "tipo_traslado", length = 2)
    public String tipoTraslado;

    @Column(name = "codi_clie_comp", length = 5)
    public String codiClieComp;

    @Column(name = "codi_nota_ingre", length = 10)
    public String codiNotaIngre;
}

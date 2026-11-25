package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.GUIA_TRANSPORTISTA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "GuiaTransportista")
@Table(name = "guia_transportista")
public class GuiaTransportista extends LegacyEntity {

    @Id
    @Column(name = "id_guia", nullable = false)
    public Long idGuia;

    @Column(name = "serie", length = 5)
    public String serie;

    @Column(name = "numero")
    public Long numero;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "fecha_inic_tras")
    public LocalDateTime fechaInicTras;

    @Column(name = "via_tipo_part", length = 50)
    public String viaTipoPart;

    @Column(name = "via_nomb_part", length = 150)
    public String viaNombPart;

    @Column(name = "nro_part", length = 50)
    public String nroPart;

    @Column(name = "interior_part", length = 50)
    public String interiorPart;

    @Column(name = "zona_part", length = 150)
    public String zonaPart;

    @Column(name = "dist_part")
    public Short distPart;

    @Column(name = "prov_part")
    public Short provPart;

    @Column(name = "depa_part")
    public Short depaPart;

    @Column(name = "via_tipo_dest", length = 50)
    public String viaTipoDest;

    @Column(name = "via_nomb_dest", length = 150)
    public String viaNombDest;

    @Column(name = "nro_dest", length = 50)
    public String nroDest;

    @Column(name = "interior_dest", length = 50)
    public String interiorDest;

    @Column(name = "zona_dest", length = 150)
    public String zonaDest;

    @Column(name = "dist_dest")
    public Short distDest;

    @Column(name = "prov_dest")
    public Short provDest;

    @Column(name = "depa_dest")
    public Short depaDest;

    @Column(name = "codi_clie_remi", length = 5)
    public String codiClieRemi;

    @Column(name = "codi_clie_dest", length = 5)
    public String codiClieDest;

    @Column(name = "codi_clie_subc", length = 5)
    public String codiClieSubc;

    @Column(name = "marca_vehi", length = 50)
    public String marcaVehi;

    @Column(name = "codi_unid_vehi", length = 5)
    public String codiUnidVehi;

    @Column(name = "codi_unid_carr", length = 10)
    public String codiUnidCarr;

    @Column(name = "codi_trans", length = 4)
    public String codiTrans;

    @Column(name = "observaciones", length = 250)
    public String observaciones;

    @Column(name = "orden_despa", length = 50)
    public String ordenDespa;

    @Column(name = "orden_venta", length = 50)
    public String ordenVenta;

    @Column(name = "guia_remitente", length = 50)
    public String guiaRemitente;

    /** Legado: CODI_FACT */
    @Column(name = "codi_fact", length = 10)
    public String codiFact;

    @Column(name = "estado", length = 1)
    public String estado;

    @Column(name = "codi_orden_soli")
    public Long codiOrdenSoli;

    @Column(name = "codi_deta")
    public Long codiDeta;
}

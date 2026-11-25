package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ALMACEN</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Almacen")
@Table(name = "almacen")
public class Almacen extends LegacyEntity {

    /** Legado: CODI_ALMA */
    @Id
    @Column(name = "codi_alma", length = 2, nullable = false)
    public String codiAlma;

    /** Legado: DESC_ALMA */
    @Column(name = "desc_alma", length = 100)
    public String descAlma;

    /** Legado: DIRECCION */
    @Column(name = "direccion", length = 100)
    public String direccion;

    /** Legado: TELEFONO */
    @Column(name = "telefono", length = 50)
    public String telefono;

    /** Legado: NEMO_ALMA */
    @Column(name = "nemo_alma", length = 20)
    public String nemoAlma;

    /** Legado: UBICACION */
    @Column(name = "ubicacion", length = 50)
    public String ubicacion;

    @Column(name = "tipo", length = 1)
    public String tipo;

    @Column(name = "codi_luga", length = 3)
    public String codiLuga;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "codi_alma_princi", length = 2)
    public String codiAlmaPrinci;

    /** Legado: CODI_UNID_OPER */
    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    @Column(name = "nro_cuen", length = 7)
    public String nroCuen;

    @Column(name = "representante", length = 5)
    public String representante;

    @Column(name = "nro_cuen_d", length = 7)
    public String nroCuenD;

    @Column(name = "distrito", length = 100)
    public String distrito;

    @Column(name = "correo", length = 150)
    public String correo;

    @Column(name = "ruta", length = 255)
    public String ruta;

    @Column(name = "impresora", length = 150)
    public String impresora;

    /** Legado: CODI_ALMA_DESC */
    @Column(name = "codi_alma_desc", length = 2)
    public String codiAlmaDesc;

    /** Legado: codigo_Estable */
    @Column(name = "codigo_estable", length = 4)
    public String codigoEstable;

    @Column(name = "activo", length = 1)
    public String activo;

    @Column(name = "codigo_ubigeo", length = 6)
    public String codigoUbigeo;

    @Column(name = "dist_alma")
    public Integer distAlma;
}

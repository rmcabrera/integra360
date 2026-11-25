package pe.sige.seguridad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Empresa</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Empresa")
@Table(name = "empresa")
public class Empresa extends LegacyEntity {

    /** Legado: Razon_Social */
    @Id
    @Column(name = "razon_social", length = 50, nullable = false)
    public String razonSocial;

    /** Legado: Ruc */
    @Column(name = "ruc", length = 15)
    public String ruc;

    /** Legado: Representante */
    @Column(name = "representante", length = 100)
    public String representante;

    /** Legado: DOCU_IDEN_REPR */
    @Column(name = "docu_iden_repr", length = 12)
    public String docuIdenRepr;

    /** Legado: Cargo */
    @Column(name = "cargo", length = 30)
    public String cargo;

    /** Legado: Direccion */
    @Column(name = "direccion", length = 150)
    public String direccion;

    /** Legado: Telefono */
    @Column(name = "telefono", length = 100)
    public String telefono;

    /** Legado: Fax */
    @Column(name = "fax", length = 50)
    public String fax;

    /** Legado: Direccion_ */
    @Column(name = "direccion_x", length = 150)
    public String direccionX;

    /** Legado: Telefono_ */
    @Column(name = "telefono_x", length = 50)
    public String telefonoX;

    /** Legado: Fax_ */
    @Column(name = "fax_x", length = 50)
    public String faxX;

    /** Legado: Acti_Econ_Prin */
    @Column(name = "acti_econ_prin", length = 200)
    public String actiEconPrin;

    /** Legado: NRO_REGI */
    @Column(name = "nro_regi", length = 20)
    public String nroRegi;

    /** Legado: FECH_INCR */
    @Column(name = "fech_incr")
    public LocalDateTime fechIncr;

    /** Legado: UBIGEO */
    @Column(name = "ubigeo", length = 20)
    public String ubigeo;

    /** Legado: OBJE_SOCI */
    @Column(name = "obje_soci", length = 255)
    public String objeSoci;

    /** Legado: OBJE_SOCI_2 */
    @Column(name = "obje_soci_2", length = 255)
    public String objeSoci2;

    /** Legado: TIPO_EMPR */
    @Column(name = "tipo_empr", length = 100)
    public String tipoEmpr;

    /** Legado: CIIU */
    @Column(name = "ciiu", length = 20)
    public String ciiu;

    /** Legado: CUEN_CON_INMU */
    @Column(name = "cuen_con_inmu", length = 300)
    public String cuenConInmu;

    /** Legado: E_MAIL */
    @Column(name = "e_mail", length = 50)
    public String eMail;

    /** Legado: PAGI_WEB */
    @Column(name = "pagi_web", length = 100)
    public String pagiWeb;

    /** Legado: DEPARTAMENTO */
    @Column(name = "departamento", length = 50)
    public String departamento;

    /** Legado: PROVINCIA */
    @Column(name = "provincia", length = 50)
    public String provincia;

    /** Legado: DISTRITO */
    @Column(name = "distrito", length = 50)
    public String distrito;

    /** Legado: URBANIZACION */
    @Column(name = "urbanizacion", length = 50)
    public String urbanizacion;

    /** Legado: CODI_CAJA */
    @Column(name = "codi_caja", length = 10)
    public String codiCaja;

    /** Legado: INICIAL */
    @Column(name = "inicial", length = 10)
    public String inicial;

    /** Legado: DNIREPRE */
    @Column(name = "dnirepre", length = 8)
    public String dnirepre;

    /** Legado: NOM_BOLE */
    @Column(name = "nom_bole", length = 150)
    public String nomBole;

    /** Legado: CAR_BOLE */
    @Column(name = "car_bole", length = 150)
    public String carBole;

    /** Legado: DOCU_BOLE */
    @Column(name = "docu_bole", length = 20)
    public String docuBole;

    /** Legado: DAT_MOSTRAR */
    @Column(name = "dat_mostrar", length = 30)
    public String datMostrar;

    /** Legado: GRUPO */
    @Column(name = "grupo", length = 10)
    public String grupo;

    /** Legado: SECTOR */
    @Column(name = "sector", length = 20)
    public String sector;

    /** Legado: REPR_FLOTA */
    @Column(name = "repr_flota", length = 100)
    public String reprFlota;

    /** Legado: DNI_REPR_FLOT */
    @Column(name = "dni_repr_flot", length = 20)
    public String dniReprFlot;

    /** Legado: CODI_TIPO_EMPR */
    @Column(name = "codi_tipo_empr", length = 2)
    public String codiTipoEmpr;

    /** Legado: IQF_REG_USO */
    @Column(name = "iqf_reg_uso", length = 5)
    public String iqfRegUso;

    /** Legado: IQF_REG_RU */
    @Column(name = "iqf_reg_ru", length = 6)
    public String iqfRegRu;

    /** Legado: RUTA_ARCHIVO */
    @Column(name = "ruta_archivo", length = 255)
    public String rutaArchivo;

    @Column(name = "ubl_21", length = 1)
    public String ubl21;
}

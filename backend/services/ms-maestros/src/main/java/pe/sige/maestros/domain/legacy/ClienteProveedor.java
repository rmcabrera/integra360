package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CLIENTE_PROVEEDOR</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ClienteProveedor")
@Table(name = "cliente_proveedor")
public class ClienteProveedor extends LegacyEntity {

    /** Legado: CODI_CLIE_PROV */
    @Id
    @Column(name = "codi_clie_prov", length = 5, nullable = false)
    public String codiClieProv;

    /** Legado: TIPO_PERS */
    @Column(name = "tipo_pers", length = 12)
    public String tipoPers;

    /** Legado: RAZO_SOCI */
    @Column(name = "razo_soci", length = 100)
    public String razoSoci;

    /** Legado: NOMB_1 */
    @Column(name = "nomb_1", length = 30)
    public String nomb1;

    /** Legado: NOMB_2 */
    @Column(name = "nomb_2", length = 30)
    public String nomb2;

    /** Legado: APEL_1 */
    @Column(name = "apel_1", length = 30)
    public String apel1;

    /** Legado: APEL_2 */
    @Column(name = "apel_2", length = 30)
    public String apel2;

    /** Legado: RUC */
    @Column(name = "ruc", length = 15)
    public String ruc;

    /** Legado: REPR_LEGA */
    @Column(name = "repr_lega", length = 120)
    public String reprLega;

    /** Legado: DENOMINACION */
    @Column(name = "denominacion", length = 100)
    public String denominacion;

    /** Legado: DIRECCION */
    @Column(name = "direccion", length = 150)
    public String direccion;

    /** Legado: TELE_1 */
    @Column(name = "tele_1", length = 12)
    public String tele1;

    /** Legado: TELE_2 */
    @Column(name = "tele_2", length = 12)
    public String tele2;

    /** Legado: FAX */
    @Column(name = "fax", length = 12)
    public String fax;

    /** Legado: E_MAIL */
    @Column(name = "e_mail", length = 150)
    public String eMail;

    /** Legado: TIPO_RELA */
    @Column(name = "tipo_rela", length = 25)
    public String tipoRela;

    /** Legado: DISTRITO */
    @Column(name = "distrito", length = 50)
    public String distrito;

    /** Legado: PROVINCIA */
    @Column(name = "provincia", length = 50)
    public String provincia;

    /** Legado: DEPARTAMENTO */
    @Column(name = "departamento", length = 50)
    public String departamento;

    /** Legado: CODI_ACTI_ECON */
    @Column(name = "codi_acti_econ", length = 4)
    public String codiActiEcon;

    /** Legado: SUJE_DETR */
    @Column(name = "suje_detr")
    public Boolean sujeDetr;

    /** Legado: ABREVIATURA */
    @Column(name = "abreviatura", length = 30)
    public String abreviatura;

    /** Legado: PROPIO */
    @Column(name = "propio")
    public Boolean propio;

    /** Legado: RETEN */
    @Column(name = "reten", length = 1)
    public String reten;

    /** Legado: NRO_CERTIFICADO */
    @Column(name = "nro_certificado", length = 4)
    public String nroCertificado;

    /** Legado: Codi_Tipo_Docu_Iden */
    @Column(name = "codi_tipo_docu_iden")
    public Short codiTipoDocuIden;

    /** Legado: FECH_NACI */
    @Column(name = "fech_naci")
    public LocalDateTime fechNaci;

    /** Legado: SEXO */
    @Column(name = "sexo", length = 1)
    public String sexo;

    /** Legado: CODI_NACION */
    @Column(name = "codi_nacion")
    public Short codiNacion;

    /** Legado: ESSALUD_VIDA */
    @Column(name = "essalud_vida", length = 1)
    public String essaludVida;

    /** Legado: DOMICILIADO */
    @Column(name = "domiciliado", length = 1)
    public String domiciliado;

    /** Legado: DV */
    @Column(name = "dv")
    public Short dv;

    @Column(name = "esta_acti", length = 1)
    public String estaActi;

    @Column(name = "frecuencia", length = 2)
    public String frecuencia;

    @Column(name = "codi_ubi_dist")
    public Integer codiUbiDist;

    @Column(name = "codi_sunat_esta", length = 4)
    public String codiSunatEsta;
}

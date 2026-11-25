package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.DERECHO_HABIENTE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DerechoHabiente")
@Table(name = "derecho_habiente")
@IdClass(DerechoHabiente.Pk.class)
public class DerechoHabiente extends LegacyEntity {

    /** Legado: CODI_PERS */
    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: CODI_DERE_HABI */
    @Id
    @Column(name = "codi_dere_habi", nullable = false)
    public Short codiDereHabi;

    /** Legado: TIPO_RELA */
    @Column(name = "tipo_rela", length = 40)
    public String tipoRela;

    /** Legado: NOMB_1 */
    @Column(name = "nomb_1", length = 30, nullable = false)
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

    /** Legado: CODI_TIPO_DOCU */
    @Column(name = "codi_tipo_docu", length = 4)
    public String codiTipoDocu;

    /** Legado: NRO_DOCU_IDEN */
    @Column(name = "nro_docu_iden", length = 30)
    public String nroDocuIden;

    /** Legado: FECH_NACI */
    @Column(name = "fech_naci")
    public LocalDateTime fechNaci;

    /** Legado: SEXO */
    @Column(name = "sexo", length = 1)
    public String sexo;

    /** Legado: SITUACION */
    @Column(name = "situacion", length = 1)
    public String situacion;

    /** Legado: MOTI_BAJA */
    @Column(name = "moti_baja", length = 1)
    public String motiBaja;

    /** Legado: DOMICILIO */
    @Column(name = "domicilio", length = 1)
    public String domicilio;

    /** Legado: INCAPACIDAD */
    @Column(name = "incapacidad")
    public Boolean incapacidad;

    /** Legado: CERT_MEDI */
    @Column(name = "cert_medi", length = 20)
    public String certMedi;

    /** Legado: Codi_Tipo_Docu_Iden */
    @Column(name = "codi_tipo_docu_iden")
    public Short codiTipoDocuIden;

    /** Legado: Codi_Vinc_Fami */
    @Column(name = "codi_vinc_fami")
    public Short codiVincFami;

    @Column(name = "tipo_doc_acred_pater")
    public Short tipoDocAcredPater;

    @Column(name = "nro_doc_acred_pater", length = 20)
    public String nroDocAcredPater;

    @Column(name = "fech_alta")
    public LocalDateTime fechAlta;

    @Column(name = "fech_baja")
    public LocalDateTime fechBaja;

    /** Legado: Codi_Moti_Baja_DH */
    @Column(name = "codi_moti_baja_dh")
    public Short codiMotiBajaDh;

    @Column(name = "nro_resolu_direct", length = 20)
    public String nroResoluDirect;

    /** Legado: Codi_Via */
    @Column(name = "codi_via")
    public Short codiVia;

    /** Legado: Nomb_via */
    @Column(name = "nomb_via", length = 20)
    public String nombVia;

    /** Legado: Num_via */
    @Column(name = "num_via", length = 4)
    public String numVia;

    /** Legado: Interior_via */
    @Column(name = "interior_via", length = 4)
    public String interiorVia;

    /** Legado: Codi_Zona */
    @Column(name = "codi_zona")
    public Short codiZona;

    /** Legado: Nomb_Zona */
    @Column(name = "nomb_zona", length = 20)
    public String nombZona;

    @Column(name = "referencia", length = 40)
    public String referencia;

    /** Legado: Codi_Ubi_Reg */
    @Column(name = "codi_ubi_reg")
    public Short codiUbiReg;

    /** Legado: Codi_Ubi_Prov */
    @Column(name = "codi_ubi_prov")
    public Short codiUbiProv;

    /** Legado: Codi_Ubi_Dist */
    @Column(name = "codi_ubi_dist")
    public Short codiUbiDist;

    @Column(name = "codi_pais", length = 3)
    public String codiPais;

    @Column(name = "mesconcep", length = 6)
    public String mesconcep;

    @Column(name = "codi_docu_vinculo")
    public Integer codiDocuVinculo;

    @Column(name = "codi_ldistanci", length = 3)
    public String codiLdistanci;

    @Column(name = "telefono", length = 10)
    public String telefono;

    @Column(name = "correo", length = 70)
    public String correo;

    /** Clave primaria compuesta */
    public static class Pk implements Serializable {
        public String codiPers;
        public Short codiDereHabi;

        public Pk() {
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (!(o instanceof Pk other)) return false;
            return Objects.equals(codiPers, other.codiPers)
                && Objects.equals(codiDereHabi, other.codiDereHabi);
        }

        @Override
        public int hashCode() {
            return Objects.hash(codiPers, codiDereHabi);
        }
    }
}

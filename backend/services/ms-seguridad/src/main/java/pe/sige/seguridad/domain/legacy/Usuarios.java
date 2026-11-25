package pe.sige.seguridad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.USUARIOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Usuarios")
@Table(name = "usuarios")
public class Usuarios extends LegacyEntity {

    /** Legado: CODI_USUA */
    @Id
    @Column(name = "codi_usua", length = 5, nullable = false)
    public String codiUsua;

    /** Legado: APEL_1 */
    @Column(name = "apel_1", length = 25)
    public String apel1;

    /** Legado: APEL_2 */
    @Column(name = "apel_2", length = 25)
    public String apel2;

    /** Legado: NOMB_1 */
    @Column(name = "nomb_1", length = 25)
    public String nomb1;

    /** Legado: NOMB_2 */
    @Column(name = "nomb_2", length = 25)
    public String nomb2;

    /** Legado: CODI_PERS */
    @Column(name = "codi_pers", length = 5)
    public String codiPers;

    /** Legado: LOGIN */
    @Column(name = "login", length = 50, nullable = false)
    public String login;

    /** Legado: CLAVE */
    @Column(name = "clave", length = 50, nullable = false)
    public String clave;

    /** Legado: FECH_INIC_VIGE */
    @Column(name = "fech_inic_vige", nullable = false)
    public LocalDateTime fechInicVige;

    /** Legado: ESTA_CLAV */
    @Column(name = "esta_clav")
    public Boolean estaClav;

    /** Legado: CODI_CARG */
    @Column(name = "codi_carg", length = 4)
    public String codiCarg;

    /** Legado: CODI_GRUP */
    @Column(name = "codi_grup")
    public Integer codiGrup;

    @Column(name = "fech_camb")
    public LocalDateTime fechCamb;

    @Column(name = "recordar")
    public Integer recordar;

    /** Legado: CODI_ALMA */
    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    /** Legado: MULTI_ACCESO */
    @Column(name = "multi_acceso", length = 1)
    public String multiAcceso;
}

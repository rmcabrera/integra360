package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.LISTA_DE_REQUERIMIENTOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ListaDeRequerimientos")
@Table(name = "lista_de_requerimientos")
public class ListaDeRequerimientos extends LegacyEntity {

    /** Legado: CODI_LIST_REQU */
    @Id
    @Column(name = "codi_list_requ", length = 8, nullable = false)
    public String codiListRequ;

    /** Legado: FECH_LIST_REQU */
    @Column(name = "fech_list_requ", nullable = false)
    public LocalDateTime fechListRequ;

    /** Legado: CODI_PERS_RESP */
    @Column(name = "codi_pers_resp", length = 5)
    public String codiPersResp;

    /** Legado: ESTADO */
    @Column(name = "estado", length = 1)
    public String estado;

    /** Legado: CODI_UNID_OPER_SOLI */
    @Column(name = "codi_unid_oper_soli", length = 5)
    public String codiUnidOperSoli;

    /** Legado: CODI_UNID_OPER_DEST */
    @Column(name = "codi_unid_oper_dest", length = 5)
    public String codiUnidOperDest;

    /** Legado: PEDI_TRAB */
    @Column(name = "pedi_trab", length = 1)
    public String pediTrab;

    /** Legado: MOTIVO */
    @Column(name = "motivo", length = 250)
    public String motivo;

    /** Legado: TIPO_USO */
    @Column(name = "tipo_uso", length = 1)
    public String tipoUso;

    /** Legado: MANT_ACTI */
    @Column(name = "mant_acti", length = 1)
    public String mantActi;

    /** Legado: OBSERVACION */
    @Column(name = "observacion", length = 1500)
    public String observacion;

    /** Legado: OBSERVACION_2 */
    @Column(name = "observacion_2", length = 200)
    public String observacion2;

    /** Legado: OBSERVACION_3 */
    @Column(name = "observacion_3", length = 200)
    public String observacion3;

    /** Legado: OBSERVACION_4 */
    @Column(name = "observacion_4", length = 200)
    public String observacion4;

    /** Legado: OBSERVACION_5 */
    @Column(name = "observacion_5", length = 200)
    public String observacion5;

    /** Legado: PRIO */
    @Column(name = "prio")
    public Short prio;

    /** Legado: Codi_Alma */
    @Column(name = "codi_alma", length = 2)
    public String codiAlma;
}

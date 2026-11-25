package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ORDEN_DE_PEDIDO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "OrdenDePedido")
@Table(name = "orden_de_pedido")
public class OrdenDePedido extends LegacyEntity {

    /** Legado: CODI_ORDE_PEDI */
    @Id
    @Column(name = "codi_orde_pedi", length = 10, nullable = false)
    public String codiOrdePedi;

    /** Legado: FECH_PEDI */
    @Column(name = "fech_pedi", nullable = false)
    public LocalDateTime fechPedi;

    /** Legado: ESTADO */
    @Column(name = "estado", length = 1)
    public String estado;

    /** Legado: CODI_LIST_REQU */
    @Column(name = "codi_list_requ", length = 8)
    public String codiListRequ;

    /** Legado: OBSERVACION */
    @Column(name = "observacion", length = 250)
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

    /** Legado: NRO_ORDE_PEDI */
    @Column(name = "nro_orde_pedi", length = 10)
    public String nroOrdePedi;

    /** Legado: PEDI_TRAB */
    @Column(name = "pedi_trab", length = 1)
    public String pediTrab;

    /** Legado: CODI_PERS_RESP */
    @Column(name = "codi_pers_resp", length = 5)
    public String codiPersResp;

    /** Legado: CODI_UNID_OPER_SOLI */
    @Column(name = "codi_unid_oper_soli", length = 5)
    public String codiUnidOperSoli;

    /** Legado: CODI_UNID_OPER_DEST */
    @Column(name = "codi_unid_oper_dest", length = 5)
    public String codiUnidOperDest;

    /** Legado: MOTIVO */
    @Column(name = "motivo", length = 250)
    public String motivo;

    /** Legado: TIPO_USO */
    @Column(name = "tipo_uso", length = 1)
    public String tipoUso;

    /** Legado: MANT_ACTI */
    @Column(name = "mant_acti", length = 1)
    public String mantActi;

    /** Legado: PRIO */
    @Column(name = "prio")
    public Short prio;

    /** Legado: Codi_Alma */
    @Column(name = "codi_alma", length = 2)
    public String codiAlma;
}

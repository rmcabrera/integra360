package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ORDEN_PRODUCCION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "OrdenProduccion")
@Table(name = "orden_produccion")
public class OrdenProduccion extends LegacyEntity {

    /** Legado: Codi_Orde_Produc */
    @Id
    @Column(name = "codi_orde_produc", nullable = false)
    public Integer codiOrdeProduc;

    /** Legado: Nro_Orde_Produc */
    @Column(name = "nro_orde_produc", nullable = false)
    public Integer nroOrdeProduc;

    /** Legado: Fecha_Orde_Produc */
    @Column(name = "fecha_orde_produc", nullable = false)
    public LocalDateTime fechaOrdeProduc;

    /** Legado: Codi_Clie */
    @Column(name = "codi_clie", length = 5, nullable = false)
    public String codiClie;

    /** Legado: Descripcion */
    @Column(name = "descripcion", length = 200, nullable = false)
    public String descripcion;

    /** Legado: Nro_OC_Clie */
    @Column(name = "nro_oc_clie", length = 25)
    public String nroOcClie;

    /** Legado: Fecha_Entrega */
    @Column(name = "fecha_entrega", nullable = false)
    public LocalDateTime fechaEntrega;

    /** Legado: Prec_Unit */
    @Column(name = "prec_unit", precision = 18, scale = 8, nullable = false)
    public BigDecimal precUnit;

    /** Legado: Cantidad */
    @Column(name = "cantidad", precision = 18, scale = 2, nullable = false)
    public BigDecimal cantidad;

    /** Legado: Codi_Unid_Medi */
    @Column(name = "codi_unid_medi", length = 2)
    public String codiUnidMedi;

    /** Legado: Tama1 */
    @Column(name = "tama1", precision = 9, scale = 2)
    public BigDecimal tama1;

    /** Legado: Tama2 */
    @Column(name = "tama2", precision = 9, scale = 2)
    public BigDecimal tama2;

    /** Legado: Codi_Unid_MediT */
    @Column(name = "codi_unid_medit", length = 2)
    public String codiUnidMedit;

    /** Legado: Otros_Acabado */
    @Column(name = "otros_acabado", length = 200)
    public String otrosAcabado;

    /** Legado: Observaciones */
    @Column(name = "observaciones", length = 800)
    public String observaciones;

    /** Legado: Codi_Usua */
    @Column(name = "codi_usua", length = 5, nullable = false)
    public String codiUsua;

    /** Legado: Estado */
    @Column(name = "estado", length = 1)
    public String estado;

    /** Legado: Tipo_Pers */
    @Column(name = "tipo_pers", length = 1)
    public String tipoPers;

    /** Legado: Id_Clie_Natu */
    @Column(name = "id_clie_natu")
    public Integer idClieNatu;

    /** Legado: Codi_Mone */
    @Column(name = "codi_mone", length = 2, nullable = false)
    public String codiMone;

    /** Legado: Tama */
    @Column(name = "tama", length = 25)
    public String tama;

    /** Legado: NroOrdeFisico */
    @Column(name = "nroordefisico")
    public Short nroordefisico;

    /** Legado: Otro_Material */
    @Column(name = "otro_material", length = 50)
    public String otroMaterial;

    /** Legado: Cliente */
    @Column(name = "cliente", length = 75)
    public String cliente;

    /** Legado: Direccion */
    @Column(name = "direccion", length = 75)
    public String direccion;

    @Column(name = "nro_docu", length = 20)
    public String nroDocu;

    /** Legado: DESCRIPCION_item */
    @Column(name = "descripcion_item", length = 1000)
    public String descripcionItem;

    @Column(name = "material", length = 200)
    public String material;

    @Column(name = "color", length = 200)
    public String color;

    @Column(name = "acabado", length = 200)
    public String acabado;

    /** P producto , S servicio */
    @Column(name = "serv_prod", length = 1)
    public String servProd;

    /** Legado: Total */
    @Column(name = "total", precision = 18, scale = 2)
    public BigDecimal total;

    @Column(name = "codi_tipo_op")
    public Integer codiTipoOp;

    @Column(name = "aurtoriza_por", length = 5)
    public String aurtorizaPor;

    @Column(name = "solicitado_por", length = 5)
    public String solicitadoPor;
}

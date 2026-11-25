package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.REGISTRO_ORDEN_PEDIDO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "RegistroOrdenPedido")
@Table(name = "registro_orden_pedido")
public class RegistroOrdenPedido extends LegacyEntity {

    @Id
    @Column(name = "codi_orden_pedi", nullable = false)
    public Long codiOrdenPedi;

    @Column(name = "codi_pers_resp", length = 5)
    public String codiPersResp;

    @Column(name = "codi_unid_oper_soli", length = 2)
    public String codiUnidOperSoli;

    @Column(name = "codi_unid_oper_dest", length = 2)
    public String codiUnidOperDest;

    @Column(name = "motivo", length = 250)
    public String motivo;

    @Column(name = "observacion")
    public String observacion;

    /** Legado: Codi_Guia */
    @Column(name = "codi_guia")
    public Long codiGuia;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "estado", length = 1)
    public String estado;

    @Column(name = "envio", length = 1)
    public String envio;

    @Column(name = "apro_por", length = 5)
    public String aproPor;

    @Column(name = "libe_por", length = 5)
    public String libePor;

    @Column(name = "codi_alma_orig", length = 2)
    public String codiAlmaOrig;

    @Column(name = "super_por", length = 5)
    public String superPor;
}

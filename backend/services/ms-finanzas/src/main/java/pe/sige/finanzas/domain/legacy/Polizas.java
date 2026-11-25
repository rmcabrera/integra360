package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Polizas</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Polizas")
@Table(name = "polizas")
public class Polizas extends LegacyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "codi_poli", nullable = false)
    public Long codiPoli;

    @Column(name = "descripcion", length = 50)
    public String descripcion;

    @Column(name = "tipo", length = 20)
    public String tipo;

    /** Legado: Codi_clie_prov */
    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    /** Legado: Codi_Unid_Oper */
    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    @Column(name = "fech_adqui")
    public LocalDateTime fechAdqui;

    @Column(name = "fech_vigen")
    public LocalDateTime fechVigen;

    @Column(name = "n_meses_pago")
    public Integer nMesesPago;

    @Column(name = "dia_pago")
    public Integer diaPago;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;

    @Column(name = "monto_mensual", precision = 18, scale = 2)
    public BigDecimal montoMensual;

    @Column(name = "dias_aviso")
    public Integer diasAviso;
}

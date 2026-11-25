package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CAPTACION_VISITA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CaptacionVisita")
@Table(name = "captacion_visita")
public class CaptacionVisita extends LegacyEntity {

    @Id
    @Column(name = "codi_capta", nullable = false)
    public Long codiCapta;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "agricultor", length = 150)
    public String agricultor;

    @Column(name = "zona", length = 250)
    public String zona;

    @Column(name = "cultivo", length = 250)
    public String cultivo;

    @Column(name = "area", length = 250)
    public String area;

    @Column(name = "etapa", length = 50)
    public String etapa;

    @Column(name = "codi_rec")
    public Long codiRec;

    @Column(name = "codi_usua", length = 5)
    public String codiUsua;

    @Column(name = "tipo", length = 1)
    public String tipo;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "telefono", length = 15)
    public String telefono;

    @Column(name = "e_mail", length = 50)
    public String eMail;

    @Column(name = "siembra", length = 50)
    public String siembra;

    @Column(name = "area_nro", precision = 18, scale = 2)
    public BigDecimal areaNro;

    @Column(name = "codi_cap")
    public Long codiCap;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;
}

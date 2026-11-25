package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CAPTACION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Captacion")
@Table(name = "captacion")
public class Captacion extends LegacyEntity {

    @Id
    @Column(name = "codi_cap", nullable = false)
    public Long codiCap;

    @Column(name = "nro_doc", length = 15)
    public String nroDoc;

    @Column(name = "cliente", length = 150)
    public String cliente;

    @Column(name = "zona", length = 250)
    public String zona;

    @Column(name = "cultivo", length = 250)
    public String cultivo;

    @Column(name = "area", length = 250)
    public String area;

    @Column(name = "etapa", length = 50)
    public String etapa;

    @Column(name = "captado", length = 5)
    public String captado;

    @Column(name = "observaciones", length = 250)
    public String observaciones;

    @Column(name = "codi_usua", length = 5)
    public String codiUsua;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "tipo_pers", length = 12)
    public String tipoPers;

    @Column(name = "codi_tipo_docu_iden")
    public Short codiTipoDocuIden;

    @Column(name = "apel_1", length = 30)
    public String apel1;

    @Column(name = "apel_2", length = 30)
    public String apel2;

    @Column(name = "nomb_1", length = 30)
    public String nomb1;

    @Column(name = "nomb_2", length = 30)
    public String nomb2;

    @Column(name = "denominacion", length = 100)
    public String denominacion;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "frecuencia", length = 2)
    public String frecuencia;
}

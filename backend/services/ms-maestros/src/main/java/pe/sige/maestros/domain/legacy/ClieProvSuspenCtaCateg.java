package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CLIE_PROV_SUSPEN_CTA_CATEG</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ClieProvSuspenCtaCateg")
@Table(name = "clie_prov_suspen_cta_categ")
public class ClieProvSuspenCtaCateg extends LegacyEntity {

    @Id
    @Column(name = "codi_clie_prov_sups_cta_categ", nullable = false)
    public Long codiClieProvSupsCtaCateg;

    @Column(name = "codi_clie_prov", length = 5, nullable = false)
    public String codiClieProv;

    @Column(name = "nro_operacion", length = 15)
    public String nroOperacion;

    @Column(name = "fech_inicio", nullable = false)
    public LocalDateTime fechInicio;

    @Column(name = "anio", length = 4, nullable = false)
    public String anio;

    @Column(name = "medio_presentacion", length = 1, nullable = false)
    public String medioPresentacion;
}

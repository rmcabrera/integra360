package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.RATIO_PRODUCCION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "RatioProduccion")
@Table(name = "ratio_produccion")
public class RatioProduccion extends LegacyEntity {

    /** Legado: CODI_RATI_PROD */
    @Id
    @Column(name = "codi_rati_prod", length = 10, nullable = false)
    public String codiRatiProd;

    /** Legado: CODI_TURN */
    @Column(name = "codi_turn", length = 2, nullable = false)
    public String codiTurn;

    /** Legado: CODI_RATI */
    @Column(name = "codi_rati", length = 2, nullable = false)
    public String codiRati;

    /** Legado: FECH_RATI_PROD */
    @Column(name = "fech_rati_prod", nullable = false)
    public LocalDateTime fechRatiProd;

    /** Legado: VALO_RATI_PROD */
    @Column(name = "valo_rati_prod", precision = 12, scale = 3, nullable = false)
    public BigDecimal valoRatiProd;

    /** Legado: CODI_UNID_NEGO */
    @Column(name = "codi_unid_nego", length = 2)
    public String codiUnidNego;
}

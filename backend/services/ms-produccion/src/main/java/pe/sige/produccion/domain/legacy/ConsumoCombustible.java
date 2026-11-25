package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CONSUMO_COMBUSTIBLE</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ConsumoCombustible")
@Table(name = "consumo_combustible")
public class ConsumoCombustible extends LegacyEntity {

    /** Legado: CODI_CONS_COMB */
    @Id
    @Column(name = "codi_cons_comb", length = 5, nullable = false)
    public String codiConsComb;

    /** Legado: CODI_UNID_TRAN */
    @Column(name = "codi_unid_tran", length = 4)
    public String codiUnidTran;

    /** Legado: ANIO */
    @Column(name = "anio", length = 4)
    public String anio;

    /** Legado: MES */
    @Column(name = "mes", length = 2)
    public String mes;

    /** Legado: KILO_INIC */
    @Column(name = "kilo_inic", precision = 18, scale = 2, nullable = false)
    public BigDecimal kiloInic;

    /** Legado: KILO_FINA */
    @Column(name = "kilo_fina", precision = 18, scale = 2, nullable = false)
    public BigDecimal kiloFina;
}

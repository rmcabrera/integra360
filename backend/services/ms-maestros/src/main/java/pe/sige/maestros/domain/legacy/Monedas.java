package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.MONEDAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Monedas")
@Table(name = "monedas")
public class Monedas extends LegacyEntity {

    /** Legado: CODI_MONE */
    @Id
    @Column(name = "codi_mone", length = 2, nullable = false)
    public String codiMone;

    /** Legado: DESC_MONE */
    @Column(name = "desc_mone", length = 50, nullable = false)
    public String descMone;

    /** Legado: SIMBOLO */
    @Column(name = "simbolo", length = 10)
    public String simbolo;

    /** Legado: CODI_SUNAT */
    @Column(name = "codi_sunat", nullable = false)
    public Short codiSunat;
}

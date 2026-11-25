package pe.sige.maestros.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SEMANA</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Semana")
@Table(name = "semana")
public class Semana extends LegacyEntity {

    /** Legado: CODI_SEMA */
    @Id
    @Column(name = "codi_sema", length = 8, nullable = false)
    public String codiSema;

    /** Legado: NRO_SEMA */
    @Column(name = "nro_sema", nullable = false)
    public Short nroSema;

    /** Legado: FECH_INIC */
    @Column(name = "fech_inic", nullable = false)
    public LocalDateTime fechInic;

    /** Legado: FECH_TERM */
    @Column(name = "fech_term")
    public LocalDateTime fechTerm;

    /** Legado: ANIOMES */
    @Column(name = "aniomes", length = 6)
    public String aniomes;

    /** Legado: CODI_TIPO_PERS */
    @Column(name = "codi_tipo_pers", length = 2)
    public String codiTipoPers;
}

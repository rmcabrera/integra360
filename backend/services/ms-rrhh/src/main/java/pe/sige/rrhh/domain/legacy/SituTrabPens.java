package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SITU_TRAB_PENS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "SituTrabPens")
@Table(name = "situ_trab_pens")
public class SituTrabPens extends LegacyEntity {

    /** Legado: Codi_Situ_Trab_Pens */
    @Id
    @Column(name = "codi_situ_trab_pens", nullable = false)
    public Short codiSituTrabPens;

    /** Legado: Codi_Situ_Trab_Pens_Sunat */
    @Column(name = "codi_situ_trab_pens_sunat", nullable = false)
    public Short codiSituTrabPensSunat;

    /** Legado: Afiliado_EPS */
    @Column(name = "afiliado_eps", nullable = false)
    public Short afiliadoEps;

    /** Legado: Desc_Situ_Trab_Pens */
    @Column(name = "desc_situ_trab_pens", length = 150, nullable = false)
    public String descSituTrabPens;

    /** Legado: Codi_Situ_Trab_Pens_plame */
    @Column(name = "codi_situ_trab_pens_plame")
    public Short codiSituTrabPensPlame;
}

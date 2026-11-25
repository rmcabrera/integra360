package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CATEGORIA_TRABAJADOR</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CategoriaTrabajador")
@Table(name = "categoria_trabajador")
public class CategoriaTrabajador extends LegacyEntity {

    /** 0=Ninguno,1=Personal Direccion,2=Personal Confianza */
    @Id
    @Column(name = "codi_cate_trab", nullable = false)
    public Short codiCateTrab;

    /** Legado: DESC_CATE_TRAB */
    @Column(name = "desc_cate_trab", length = 50, nullable = false)
    public String descCateTrab;

    /** Legado: ABRE_CATE_TRAB */
    @Column(name = "abre_cate_trab", length = 12)
    public String abreCateTrab;

    /** Legado: ORDE_CATE_TRAB */
    @Column(name = "orde_cate_trab")
    public Short ordeCateTrab;

    /** Legado: CODI_SUNAT */
    @Column(name = "codi_sunat")
    public Integer codiSunat;
}

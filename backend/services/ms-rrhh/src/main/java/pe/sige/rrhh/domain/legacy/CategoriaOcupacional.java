package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CATEGORIA_OCUPACIONAL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "CategoriaOcupacional")
@Table(name = "categoria_ocupacional")
public class CategoriaOcupacional extends LegacyEntity {

    @Id
    @Column(name = "cod_categ_ocup", nullable = false)
    public Integer codCategOcup;

    @Column(name = "desc_categ_ocup", length = 100)
    public String descCategOcup;

    @Column(name = "codigo_sunat")
    public Integer codigoSunat;

    @Column(name = "privador", length = 1)
    public String privador;

    @Column(name = "publico", length = 1)
    public String publico;

    @Column(name = "otro", length = 1)
    public String otro;
}

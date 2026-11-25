package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SINDICATOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Sindicatos")
@Table(name = "sindicatos")
public class Sindicatos extends LegacyEntity {

    @Id
    @Column(name = "codi_sind", length = 2, nullable = false)
    public String codiSind;

    @Column(name = "descrip", length = 100, nullable = false)
    public String descrip;

    /** Legado: Tipo */
    @Column(name = "tipo", length = 1)
    public String tipo;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "porcentaje")
    public Long porcentaje;

    @Column(name = "tipo_valor", length = 1)
    public String tipoValor;

    @Column(name = "nemo", length = 30)
    public String nemo;
}

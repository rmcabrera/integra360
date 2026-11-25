package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.REGISTRO_PRODUCTO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "RegistroProducto")
@Table(name = "registro_producto")
public class RegistroProducto extends LegacyEntity {

    @Id
    @Column(name = "codi_regi_prod", nullable = false)
    public Long codiRegiProd;

    @Column(name = "cultivo", length = 250)
    public String cultivo;

    @Column(name = "area", length = 250)
    public String area;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    /** Legado: COD_ZONA */
    @Column(name = "cod_zona")
    public Long codZona;

    @Column(name = "cod_cultivo")
    public Integer codCultivo;
}

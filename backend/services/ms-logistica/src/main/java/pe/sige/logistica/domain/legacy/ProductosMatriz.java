package pe.sige.logistica.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PRODUCTOS_MATRIZ</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ProductosMatriz")
@Table(name = "productos_matriz")
public class ProductosMatriz extends LegacyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_mat", nullable = false)
    public Long idMat;

    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    @Column(name = "codi_rota")
    public Long codiRota;

    @Column(name = "fecha")
    public LocalDateTime fecha;
}

package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.COMISIONES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Comisiones")
@Table(name = "comisiones")
public class Comisiones extends LegacyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_comi", nullable = false)
    public Long idComi;

    @Column(name = "mes")
    public Integer mes;

    @Column(name = "anio")
    public Integer anio;

    @Column(name = "codi_alma", length = 2)
    public String codiAlma;

    @Column(name = "codi_prod", length = 8)
    public String codiProd;

    @Column(name = "desc_prod", length = 200)
    public String descProd;

    @Column(name = "desc_pres", length = 200)
    public String descPres;

    @Column(name = "cantidad", precision = 18, scale = 2)
    public BigDecimal cantidad;

    @Column(name = "valor", precision = 18, scale = 3)
    public BigDecimal valor;

    @Column(name = "comision", precision = 18, scale = 3)
    public BigDecimal comision;

    @Column(name = "valor_comision", precision = 18, scale = 3)
    public BigDecimal valorComision;

    @Column(name = "codi_depen", length = 8)
    public String codiDepen;

    @Column(name = "desc_depen", length = 200)
    public String descDepen;

    @Column(name = "desc_prese_depen", length = 200)
    public String descPreseDepen;
}

package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.BOLETAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Boletas")
@Table(name = "boletas")
public class Boletas extends LegacyEntity {

    /** Clave sustituta agregada en la migracion (la tabla legado no tenia PK) */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public Long id;

    /** Legado: CODI_BOLE */
    @Column(name = "codi_bole", length = 10, nullable = false)
    public String codiBole;

    /** Legado: SERIE */
    @Column(name = "serie", length = 3, nullable = false)
    public String serie;

    /** Legado: NUMERO */
    @Column(name = "numero", length = 6, nullable = false)
    public String numero;

    /** Legado: CODI_CLIE_PROV */
    @Column(name = "codi_clie_prov", length = 5, nullable = false)
    public String codiClieProv;

    /** Legado: FECHA */
    @Column(name = "fecha", nullable = false)
    public LocalDateTime fecha;

    /** Legado: MONTO */
    @Column(name = "monto", precision = 12, scale = 2)
    public BigDecimal monto;

    /** Legado: TIPO */
    @Column(name = "tipo", length = 2)
    public String tipo;

    /** Legado: CODI_MONE */
    @Column(name = "codi_mone", length = 2)
    public String codiMone;
}

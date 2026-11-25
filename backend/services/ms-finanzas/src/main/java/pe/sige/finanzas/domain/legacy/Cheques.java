package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CHEQUES</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Cheques")
@Table(name = "cheques")
public class Cheques extends LegacyEntity {

    /** Legado: CODI_CHEQ */
    @Id
    @Column(name = "codi_cheq", length = 10, nullable = false)
    public String codiCheq;

    /** Legado: NRO_CHEQ */
    @Column(name = "nro_cheq", length = 8, nullable = false)
    public String nroCheq;

    /** Legado: NRO_CUEN */
    @Column(name = "nro_cuen", length = 7, nullable = false)
    public String nroCuen;

    /** Legado: CODI_CLIE_PROV */
    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    /** Legado: FECHA */
    @Column(name = "fecha")
    public LocalDateTime fecha;

    /** Legado: IMPORTE */
    @Column(name = "importe", precision = 12, scale = 2)
    public BigDecimal importe;

    /** Legado: ESTADO */
    @Column(name = "estado", length = 1)
    public String estado;
}

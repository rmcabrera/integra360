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
 * Tabla legado <b>dbo.ALMACEN_DOC_REGULARIZAR</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "AlmacenDocRegularizar")
@Table(name = "almacen_doc_regularizar")
public class AlmacenDocRegularizar extends LegacyEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idd_sec", nullable = false)
    public Long iddSec;

    @Column(name = "codi_alma", length = 2, nullable = false)
    public String codiAlma;

    @Column(name = "codi_tipo_docu", length = 4, nullable = false)
    public String codiTipoDocu;

    @Column(name = "serie_alma", length = 5, nullable = false)
    public String serieAlma;

    @Column(name = "nro_docu_empieza")
    public Long nroDocuEmpieza;

    @Column(name = "fecha")
    public LocalDateTime fecha;

    @Column(name = "creacion")
    public LocalDateTime creacion;
}

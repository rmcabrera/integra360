package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PERS_TRIP_VIGE_CERT</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PersTripVigeCert")
@Table(name = "pers_trip_vige_cert")
public class PersTripVigeCert extends LegacyEntity {

    /** Legado: CODI_VIGE_CERT_TRIP */
    @Id
    @Column(name = "codi_vige_cert_trip", length = 6, nullable = false)
    public String codiVigeCertTrip;

    /** Legado: CODI_PERS */
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    /** Legado: FECH_INIC_VIGE */
    @Column(name = "fech_inic_vige")
    public LocalDateTime fechInicVige;

    /** Legado: FECH_TERM_VIGE */
    @Column(name = "fech_term_vige")
    public LocalDateTime fechTermVige;

    /** Legado: NRO_MATR */
    @Column(name = "nro_matr", length = 12)
    public String nroMatr;

    /** Legado: CODI_CARG */
    @Column(name = "codi_carg", length = 4)
    public String codiCarg;

    @Column(name = "tipo_titu", length = 2)
    public String tipoTitu;
}

package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.ESCRIBALO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Escribalo")
@Table(name = "escribalo")
public class Escribalo extends LegacyEntity {

    /** Legado: CODI_ESCR */
    @Id
    @Column(name = "codi_escr", length = 10, nullable = false)
    public String codiEscr;

    /** Legado: FECHA */
    @Column(name = "fecha")
    public LocalDateTime fecha;

    /** Legado: NRO_ESCR */
    @Column(name = "nro_escr", length = 6)
    public String nroEscr;

    /** Legado: ANIO */
    @Column(name = "anio", length = 4)
    public String anio;

    /** Legado: INIC */
    @Column(name = "inic", length = 10)
    public String inic;

    /** Legado: DE */
    @Column(name = "de", length = 200)
    public String de;

    /** Legado: PARA */
    @Column(name = "para", length = 200)
    public String para;

    /** Legado: ASUNTO */
    @Column(name = "asunto", length = 200)
    public String asunto;

    /** Legado: CODI_USUA_GENE */
    @Column(name = "codi_usua_gene", length = 5)
    public String codiUsuaGene;

    /** Legado: FECH_INIC */
    @Column(name = "fech_inic")
    public LocalDateTime fechInic;

    /** Legado: FECH_FIN */
    @Column(name = "fech_fin")
    public LocalDateTime fechFin;
}

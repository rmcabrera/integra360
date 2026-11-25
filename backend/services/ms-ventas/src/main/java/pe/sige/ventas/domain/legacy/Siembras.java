package pe.sige.ventas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.SIEMBRAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Siembras")
@Table(name = "siembras")
public class Siembras extends LegacyEntity {

    @Id
    @Column(name = "codi_siembra", nullable = false)
    public Long codiSiembra;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "fec_siembra")
    public LocalDateTime fecSiembra;

    @Column(name = "fec_estima_termi")
    public LocalDateTime fecEstimaTermi;

    @Column(name = "fec_termino")
    public LocalDateTime fecTermino;

    @Column(name = "nro_hecta", precision = 18, scale = 2)
    public BigDecimal nroHecta;

    @Column(name = "cod_cultivo")
    public Integer codCultivo;

    @Column(name = "cod_zona")
    public Long codZona;

    /** Legado: ubicación */
    @Column(name = "ubicacion", length = 100)
    public String ubicacion;

    @Column(name = "observa", length = 100)
    public String observa;

    @Column(name = "terreno", length = 50)
    public String terreno;

    @Column(name = "textsuelo", length = 100)
    public String textsuelo;

    @Column(name = "triego", length = 50)
    public String triego;

    @Column(name = "cvecinos", length = 255)
    public String cvecinos;

    @Column(name = "credsoc")
    public Boolean credsoc;

    @Column(name = "expcult", precision = 18, scale = 2)
    public BigDecimal expcult;

    @Column(name = "asestecn", length = 50)
    public String asestecn;

    @Column(name = "edadcult", precision = 18, scale = 2)
    public BigDecimal edadcult;

    @Column(name = "relacomerc", length = 150)
    public String relacomerc;

    @Column(name = "prodhect", precision = 18, scale = 2)
    public BigDecimal prodhect;

    @Column(name = "preccult", precision = 18, scale = 4)
    public BigDecimal preccult;

    @Column(name = "utilbruta", precision = 18, scale = 2)
    public BigDecimal utilbruta;

    @Column(name = "utilneta", precision = 18, scale = 2)
    public BigDecimal utilneta;

    @Column(name = "gastos", precision = 18, scale = 2)
    public BigDecimal gastos;

    @Column(name = "comprador", length = 150)
    public String comprador;

    @Column(name = "codi_mone", length = 2)
    public String codiMone;
}

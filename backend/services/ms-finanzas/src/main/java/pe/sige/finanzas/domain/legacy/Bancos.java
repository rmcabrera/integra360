package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.BANCOS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Bancos")
@Table(name = "bancos")
public class Bancos extends LegacyEntity {

    /** Legado: CODI_BANC */
    @Id
    @Column(name = "codi_banc", length = 2, nullable = false)
    public String codiBanc;

    /** Legado: DESC_BANC */
    @Column(name = "desc_banc", length = 50)
    public String descBanc;

    /** Legado: DIRE_BANC */
    @Column(name = "dire_banc", length = 150)
    public String direBanc;

    /** Legado: TELE_BANC */
    @Column(name = "tele_banc", length = 30)
    public String teleBanc;

    /** Legado: FAX_BANC */
    @Column(name = "fax_banc", length = 20)
    public String faxBanc;

    /** Legado: NEMO */
    @Column(name = "nemo", length = 10)
    public String nemo;

    /** Legado: CODI_CLIE_PROV */
    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    /** Legado: CODI_SUNAT */
    @Column(name = "codi_sunat", length = 2)
    public String codiSunat;

    /** Legado: TEA_CTS */
    @Column(name = "tea_cts", precision = 12, scale = 4)
    public BigDecimal teaCts;

    @Column(name = "tea_cts_dola", precision = 12, scale = 6)
    public BigDecimal teaCtsDola;
}

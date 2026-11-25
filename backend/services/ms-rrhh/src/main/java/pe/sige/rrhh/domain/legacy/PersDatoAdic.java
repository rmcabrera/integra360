package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PERS_DATO_ADIC</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PersDatoAdic")
@Table(name = "pers_dato_adic")
public class PersDatoAdic extends LegacyEntity {

    @Id
    @Column(name = "codi_pers", length = 5, nullable = false)
    public String codiPers;

    @Column(name = "nro_cert_salu", length = 20)
    public String nroCertSalu;

    @Column(name = "cert_ante_poli", length = 20)
    public String certAntePoli;

    @Column(name = "cert_ante_pena_alfa", length = 20)
    public String certAntePenaAlfa;

    @Column(name = "sabe_nadar")
    public Boolean sabeNadar;

    /** Legado: SMO */
    @Column(name = "smo")
    public Boolean smo;

    /** Legado: tipo_SMO */
    @Column(name = "tipo_smo", length = 20)
    public String tipoSmo;

    @Column(name = "carn_discamet")
    public Boolean carnDiscamet;

    @Column(name = "lice_port_arma")
    public Boolean licePortArma;

    @Column(name = "nro_carn_disc", length = 20)
    public String nroCarnDisc;

    @Column(name = "nro_lice_arma_alfa", length = 20)
    public String nroLiceArmaAlfa;
}

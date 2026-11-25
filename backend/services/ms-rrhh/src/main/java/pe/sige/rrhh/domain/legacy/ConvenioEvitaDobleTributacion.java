package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CONVENIO_EVITA_DOBLE_TRIBUTACION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "ConvenioEvitaDobleTributacion")
@Table(name = "convenio_evita_doble_tributacion")
public class ConvenioEvitaDobleTributacion extends LegacyEntity {

    @Id
    @Column(name = "cod_conv_evita_dob_tribu", nullable = false)
    public Integer codConvEvitaDobTribu;

    @Column(name = "desc_conv_evita_dob_tribu", length = 50)
    public String descConvEvitaDobTribu;

    @Column(name = "cod_sunat")
    public Integer codSunat;
}

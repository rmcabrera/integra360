package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.DEMANDAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Demandas")
@Table(name = "demandas")
public class Demandas extends LegacyEntity {

    @Id
    @Column(name = "codi_dema", length = 10, nullable = false)
    public String codiDema;

    @Column(name = "nro_expe", length = 100)
    public String nroExpe;

    @Column(name = "materia", length = 150)
    public String materia;

    @Column(name = "codi_juez", length = 3)
    public String codiJuez;

    @Column(name = "codi_juzg", length = 2)
    public String codiJuzg;

    @Column(name = "codi_espe", length = 3)
    public String codiEspe;

    @Column(name = "codi_pers", length = 5)
    public String codiPers;

    @Column(name = "codi_clie_prov", length = 5)
    public String codiClieProv;

    @Column(name = "fech_ingr")
    public LocalDateTime fechIngr;

    @Column(name = "codi_unid_oper", length = 5)
    public String codiUnidOper;

    /** Legado: codi_Carg */
    @Column(name = "codi_carg", length = 4)
    public String codiCarg;

    @Column(name = "antecedente")
    public String antecedente;

    @Column(name = "anio", length = 4)
    public String anio;

    @Column(name = "secretaria", length = 200)
    public String secretaria;

    @Column(name = "estado", length = 50)
    public String estado;

    @Column(name = "fech_rece")
    public LocalDateTime fechRece;

    @Column(name = "codi_abog", length = 3)
    public String codiAbog;

    @Column(name = "proceso", length = 20)
    public String proceso;

    @Column(name = "monto_dema", precision = 18, scale = 2)
    public BigDecimal montoDema;

    @Column(name = "nombres", length = 200)
    public String nombres;

    @Column(name = "situ_actu")
    public String situActu;
}

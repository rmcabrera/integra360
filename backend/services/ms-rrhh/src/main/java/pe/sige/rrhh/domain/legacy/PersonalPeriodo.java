package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PERSONAL_PERIODO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "PersonalPeriodo")
@Table(name = "personal_periodo")
public class PersonalPeriodo extends LegacyEntity {

    /** Legado: Codi_Periodo */
    @Id
    @Column(name = "codi_periodo", nullable = false)
    public Long codiPeriodo;

    /** Legado: Codi_Pers_categ */
    @Column(name = "codi_pers_categ", nullable = false)
    public Long codiPersCateg;

    /** Legado: Fech_Inicio */
    @Column(name = "fech_inicio", nullable = false)
    public LocalDateTime fechInicio;

    /** Legado: Fech_Fin */
    @Column(name = "fech_fin")
    public LocalDateTime fechFin;

    /** Legado: Codi_Moti_Fin_Peri */
    @Column(name = "codi_moti_fin_peri")
    public Short codiMotiFinPeri;

    /** Legado: Codi_Moda_Forma */
    @Column(name = "codi_moda_forma")
    public Short codiModaForma;

    @Column(name = "nro_operacion", length = 15)
    public String nroOperacion;

    /** Legado: Anio */
    @Column(name = "anio")
    public Short anio;

    /** Legado: Medio_Presenta */
    @Column(name = "medio_presenta")
    public Short medioPresenta;
}

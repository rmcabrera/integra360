package pe.sige.produccion.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Analisis_Aceite</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "AnalisisAceite")
@Table(name = "analisis_aceite")
public class AnalisisAceite extends LegacyEntity {

    /** Legado: Cod_Analisis */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cod_analisis", nullable = false)
    public Long codAnalisis;

    /** Legado: Codi_ingr */
    @Column(name = "codi_ingr", nullable = false)
    public Long codiIngr;

    /** Legado: Codi_Alma */
    @Column(name = "codi_alma", length = 2, nullable = false)
    public String codiAlma;

    /** Legado: Item */
    @Column(name = "item", nullable = false)
    public Integer item;

    /** Legado: Codi_Prod */
    @Column(name = "codi_prod", length = 8, nullable = false)
    public String codiProd;

    @Column(name = "i_o", length = 1, nullable = false)
    public String iO;

    /** 0 no analizado 1 analizado */
    @Column(name = "condicion", nullable = false)
    public Short condicion;

    /** Legado: Fecha_Analisis */
    @Column(name = "fecha_analisis")
    public LocalDateTime fechaAnalisis;

    /** Legado: Fecha_Registro */
    @Column(name = "fecha_registro", nullable = false)
    public LocalDateTime fechaRegistro;

    /** Persona que registra el analisis */
    @Column(name = "codi_usua", length = 5)
    public String codiUsua;

    /** 1 habilitado  0 rechazado   */
    @Column(name = "estado_ingreso")
    public Short estadoIngreso;
}

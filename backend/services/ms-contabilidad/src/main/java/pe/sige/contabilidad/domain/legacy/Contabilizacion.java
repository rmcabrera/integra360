package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.CONTABILIZACION</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Contabilizacion")
@Table(name = "contabilizacion")
public class Contabilizacion extends LegacyEntity {

    /** Legado: CODIGO */
    @Id
    @Column(name = "codigo", length = 4, nullable = false)
    public String codigo;

    /** Legado: ORIGEN */
    @Column(name = "origen", length = 5)
    public String origen;

    /** Legado: TIPOD */
    @Column(name = "tipod", length = 4)
    public String tipod;

    /** Legado: DESCRIP */
    @Column(name = "descrip", length = 70)
    public String descrip;

    /** Legado: CUENTA1 */
    @Column(name = "cuenta1", length = 7)
    public String cuenta1;

    /** Legado: CA1 */
    @Column(name = "ca1", length = 1)
    public String ca1;

    /** Legado: DESC1 */
    @Column(name = "desc1", length = 50)
    public String desc1;

    /** Legado: CUENTA2 */
    @Column(name = "cuenta2", length = 7)
    public String cuenta2;

    /** Legado: CA2 */
    @Column(name = "ca2", length = 1)
    public String ca2;

    /** Legado: DESC2 */
    @Column(name = "desc2", length = 50)
    public String desc2;

    /** Legado: CTASunat */
    @Column(name = "ctasunat", length = 7)
    public String ctasunat;

    /** Legado: CUENTA3 */
    @Column(name = "cuenta3", length = 7)
    public String cuenta3;

    /** Legado: CA3 */
    @Column(name = "ca3", length = 1)
    public String ca3;

    /** Legado: DESC3 */
    @Column(name = "desc3", length = 50)
    public String desc3;

    /** Legado: CUENTA4 */
    @Column(name = "cuenta4", length = 7)
    public String cuenta4;

    /** Legado: CA4 */
    @Column(name = "ca4", length = 1)
    public String ca4;

    /** Legado: DESC4 */
    @Column(name = "desc4", length = 50)
    public String desc4;

    /** Legado: CUENTA5 */
    @Column(name = "cuenta5", length = 7)
    public String cuenta5;

    /** Legado: CA5 */
    @Column(name = "ca5", length = 1)
    public String ca5;

    /** Legado: DESC5 */
    @Column(name = "desc5", length = 50)
    public String desc5;

    /** Legado: SUBDIARIO */
    @Column(name = "subdiario", length = 1)
    public String subdiario;
}

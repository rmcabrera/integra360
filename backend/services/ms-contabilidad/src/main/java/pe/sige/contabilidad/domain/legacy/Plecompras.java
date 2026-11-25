package pe.sige.contabilidad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.PLECOMPRAS</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Plecompras")
@Table(name = "plecompras")
public class Plecompras extends LegacyEntity {

    /** Clave sustituta agregada en la migracion (la tabla legado no tenia PK) */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public Long id;

    /** Legado: Columna 0 */
    @Column(name = "columna_0", length = 50)
    public String columna0;

    /** Legado: Columna 1 */
    @Column(name = "columna_1", length = 50)
    public String columna1;

    /** Legado: Columna 2 */
    @Column(name = "columna_2", length = 50)
    public String columna2;

    /** Legado: Columna 3 */
    @Column(name = "columna_3", length = 50)
    public String columna3;

    /** Legado: Columna 4 */
    @Column(name = "columna_4", length = 50)
    public String columna4;

    /** Legado: Columna 5 */
    @Column(name = "columna_5", length = 50)
    public String columna5;

    /** Legado: Columna 6 */
    @Column(name = "columna_6", length = 50)
    public String columna6;

    /** Legado: Columna 7 */
    @Column(name = "columna_7", length = 50)
    public String columna7;

    /** Legado: Columna 8 */
    @Column(name = "columna_8", length = 50)
    public String columna8;

    /** Legado: Columna 9 */
    @Column(name = "columna_9", length = 50)
    public String columna9;

    /** Legado: Columna 10 */
    @Column(name = "columna_10", length = 50)
    public String columna10;

    /** Legado: Columna 11 */
    @Column(name = "columna_11", length = 50)
    public String columna11;

    /** Legado: Columna 12 */
    @Column(name = "columna_12", length = 100)
    public String columna12;

    /** Legado: Columna 13 */
    @Column(name = "columna_13", length = 50)
    public String columna13;

    /** Legado: Columna 14 */
    @Column(name = "columna_14", length = 50)
    public String columna14;

    /** Legado: Columna 15 */
    @Column(name = "columna_15", length = 50)
    public String columna15;

    /** Legado: Columna 16 */
    @Column(name = "columna_16", length = 50)
    public String columna16;

    /** Legado: Columna 17 */
    @Column(name = "columna_17", length = 50)
    public String columna17;

    /** Legado: Columna 18 */
    @Column(name = "columna_18", length = 50)
    public String columna18;

    /** Legado: Columna 19 */
    @Column(name = "columna_19", length = 50)
    public String columna19;

    /** Legado: Columna 20 */
    @Column(name = "columna_20", length = 50)
    public String columna20;

    /** Legado: Columna 21 */
    @Column(name = "columna_21", length = 50)
    public String columna21;

    /** Legado: Columna 22 */
    @Column(name = "columna_22", length = 50)
    public String columna22;

    /** Legado: Columna 23 */
    @Column(name = "columna_23", length = 50)
    public String columna23;

    /** Legado: Columna 24 */
    @Column(name = "columna_24", length = 50)
    public String columna24;

    /** Legado: Columna 25 */
    @Column(name = "columna_25", length = 50)
    public String columna25;

    /** Legado: Columna 26 */
    @Column(name = "columna_26", length = 50)
    public String columna26;

    /** Legado: Columna 27 */
    @Column(name = "columna_27", length = 50)
    public String columna27;

    /** Legado: Columna 28 */
    @Column(name = "columna_28", length = 50)
    public String columna28;

    /** Legado: Columna 29 */
    @Column(name = "columna_29", length = 50)
    public String columna29;

    /** Legado: Columna 30 */
    @Column(name = "columna_30", length = 50)
    public String columna30;

    /** Legado: Columna 31 */
    @Column(name = "columna_31", length = 50)
    public String columna31;

    /** Legado: Columna 32 */
    @Column(name = "columna_32", length = 50)
    public String columna32;

    /** Legado: Columna 33 */
    @Column(name = "columna_33", length = 50)
    public String columna33;

    /** Legado: Columna 34 */
    @Column(name = "columna_34", length = 50)
    public String columna34;

    /** Legado: Columna 35 */
    @Column(name = "columna_35", length = 50)
    public String columna35;

    /** Legado: Columna 36 */
    @Column(name = "columna_36", length = 50)
    public String columna36;

    /** Legado: Columna 37 */
    @Column(name = "columna_37", length = 50)
    public String columna37;

    /** Legado: Columna 38 */
    @Column(name = "columna_38", length = 50)
    public String columna38;

    /** Legado: Columna 39 */
    @Column(name = "columna_39", length = 50)
    public String columna39;

    /** Legado: Columna 40 */
    @Column(name = "columna_40", length = 50)
    public String columna40;

    /** Legado: Columna 41 */
    @Column(name = "columna_41", length = 50)
    public String columna41;
}

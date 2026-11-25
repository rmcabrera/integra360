package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.REGIMEN_LABORAL</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "RegimenLaboral")
@Table(name = "regimen_laboral")
public class RegimenLaboral extends LegacyEntity {

    /** Clave sustituta agregada en la migracion (la tabla legado no tenia PK) */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public Long id;

    @Column(name = "codigo", length = 2, nullable = false)
    public String codigo;

    @Column(name = "descripcion", length = 200)
    public String descripcion;

    @Column(name = "abreviada", length = 100)
    public String abreviada;

    @Column(name = "privado", length = 1)
    public String privado;

    @Column(name = "publico", length = 1)
    public String publico;

    @Column(name = "otros", length = 1)
    public String otros;
}

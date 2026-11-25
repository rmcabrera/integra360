package pe.sige.rrhh.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.DOCUMENTO_VINCULO</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DocumentoVinculo")
@Table(name = "documento_vinculo")
public class DocumentoVinculo extends LegacyEntity {

    /** Clave sustituta agregada en la migracion (la tabla legado no tenia PK) */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    public Long id;

    @Column(name = "codi_docu_vinculo", nullable = false)
    public Integer codiDocuVinculo;

    @Column(name = "codi_docu_vinculo_sunat", length = 3)
    public String codiDocuVinculoSunat;

    @Column(name = "descipcion_docu", length = 100)
    public String descipcionDocu;

    @Column(name = "descripcion_abre", length = 100)
    public String descripcionAbre;

    @Column(name = "vinculo", length = 5)
    public String vinculo;
}

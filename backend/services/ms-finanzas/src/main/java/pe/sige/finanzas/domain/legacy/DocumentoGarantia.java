package pe.sige.finanzas.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Documento_garantia</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "DocumentoGarantia")
@Table(name = "documento_garantia")
public class DocumentoGarantia extends LegacyEntity {

    @Id
    @Column(name = "codi_docg", length = 2, nullable = false)
    public String codiDocg;

    @Column(name = "doc_garantia", length = 50)
    public String docGarantia;
}

package pe.sige.seguridad.domain.legacy;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import pe.sige.common.persistence.LegacyEntity;

/**
 * Tabla legado <b>dbo.Conexion</b>.
 * <p>Generado por tools/db-migrator: no editar. La logica de negocio va en el paquete {@code application}.
 */
@Entity(name = "Conexion")
@Table(name = "conexion")
public class Conexion extends LegacyEntity {

    /** Legado: Empresa */
    @Id
    @Column(name = "empresa", length = 50, nullable = false)
    public String empresa;

    /** Legado: _DBMS */
    @Column(name = "dbms", length = 50)
    public String dbms;

    /** Legado: _ServerName */
    @Column(name = "servername", length = 50)
    public String servername;

    /** Legado: _LogPass */
    @Column(name = "logpass", length = 50)
    public String logpass;

    /** Legado: _LogId */
    @Column(name = "logid", length = 50)
    public String logid;

    /** Legado: _AutoCommit */
    @Column(name = "autocommit", length = 50)
    public String autocommit;

    /** Legado: _database */
    @Column(name = "database", length = 50)
    public String database;

    /** Legado: _dbparm */
    @Column(name = "dbparm", length = 50)
    public String dbparm;
}

package pe.sige.seguridad.domain.legacy;

import jakarta.enterprise.context.ApplicationScoped;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import pe.sige.common.catalog.EntityCatalog;
import pe.sige.common.catalog.EntityMeta;
import pe.sige.common.catalog.FieldMeta;

/** Catalogo de entidades legado de ms-seguridad (21 tablas). Generado: no editar. */
@ApplicationScoped
public class LegacyCatalog implements EntityCatalog {

    private final Map<String, EntityMeta> entities = new LinkedHashMap<>();

    public LegacyCatalog() {
        load0();
    }

    private void add(EntityMeta m) {
        entities.put(m.name(), m);
    }

    private static FieldMeta f(String field, String column, String type, int length, boolean required, boolean id, boolean generated, String label) {
        return new FieldMeta(field, column, type, length, required, id, generated, label);
    }

    private void load0() {
        add(new EntityMeta("usuarios", "USUARIOS", "Usuarios", Usuarios.class, null, List.of(
                f("codiUsua", "codi_usua", "String", 5, true, true, false, "Codi Usua"),
                f("apel1", "apel_1", "String", 25, false, false, false, "Apel 1"),
                f("apel2", "apel_2", "String", 25, false, false, false, "Apel 2"),
                f("nomb1", "nomb_1", "String", 25, false, false, false, "Nomb 1"),
                f("nomb2", "nomb_2", "String", 25, false, false, false, "Nomb 2"),
                f("codiPers", "codi_pers", "String", 5, false, false, false, "Codi Pers"),
                f("login", "login", "String", 50, true, false, false, "Login"),
                f("clave", "clave", "String", 50, true, false, false, "Clave"),
                f("fechInicVige", "fech_inic_vige", "LocalDateTime", 0, true, false, false, "Fech Inic Vige"),
                f("estaClav", "esta_clav", "Boolean", 0, false, false, false, "Esta Clav"),
                f("codiCarg", "codi_carg", "String", 4, false, false, false, "Codi Carg"),
                f("codiGrup", "codi_grup", "Integer", 0, false, false, false, "Codi Grup"),
                f("fechCamb", "fech_camb", "LocalDateTime", 0, false, false, false, "Fech Camb"),
                f("recordar", "recordar", "Integer", 0, false, false, false, "Recordar"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"),
                f("multiAcceso", "multi_acceso", "String", 1, false, false, false, "Multi Acceso"))));
        add(new EntityMeta("firmas", "Firmas", "Firmas", Firmas.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("f1", "f1", "String", 30, false, false, false, "F1"),
                f("f2", "f2", "String", 30, false, false, false, "F2"),
                f("f3", "f3", "String", 30, false, false, false, "F3"),
                f("f4", "f4", "String", 30, false, false, false, "F4"),
                f("f5", "f5", "String", 30, false, false, false, "F5"))));
        add(new EntityMeta("notas_posits", "NOTAS_POSITS", "Notas Posits", NotasPosits.class, null, List.of(
                f("iddNota", "idd_nota", "Long", 0, true, true, true, "Idd Nota"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("descripcion", "descripcion", "String", 250, false, false, false, "Descripcion"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"))));
        add(new EntityMeta("consistencias", "Consistencias", "Consistencias", Consistencias.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("cuenta", "cuenta", "String", 3, false, false, false, "Cuenta"),
                f("cargoAbono", "cargo_abono", "String", 1, false, false, false, "Cargo Abono"))));
        add(new EntityMeta("configsys", "ConfigSys", "Configsys", Configsys.class, null, List.of(
                f("idConf", "id_conf", "Integer", 0, true, true, false, "Id Conf"),
                f("valor", "valor", "String", 50, false, false, false, "Valor"))));
        add(new EntityMeta("conexion", "Conexion", "Conexion", Conexion.class, null, List.of(
                f("empresa", "empresa", "String", 50, true, true, false, "Empresa"),
                f("dbms", "dbms", "String", 50, false, false, false, "Dbms"),
                f("servername", "servername", "String", 50, false, false, false, "Servername"),
                f("logpass", "logpass", "String", 50, false, false, false, "Logpass"),
                f("logid", "logid", "String", 50, false, false, false, "Logid"),
                f("autocommit", "autocommit", "String", 50, false, false, false, "Autocommit"),
                f("database", "database", "String", 50, false, false, false, "Database"),
                f("dbparm", "dbparm", "String", 50, false, false, false, "Dbparm"))));
        add(new EntityMeta("auditoria", "AUDITORIA", "Auditoria", Auditoria.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("anio", "anio", "Short", 0, true, false, false, "Anio"),
                f("mes", "mes", "Short", 0, true, false, false, "Mes"),
                f("fecha", "fecha", "LocalDateTime", 0, true, false, false, "Fecha"),
                f("maquina", "maquina", "String", 50, true, false, false, "Maquina"),
                f("aplicacion", "aplicacion", "String", 100, true, false, false, "Aplicacion"),
                f("codiUsua", "codi_usua", "String", 5, true, false, false, "Codi Usua"),
                f("accion", "accion", "String", 1, true, false, false, "Accion"),
                f("objeto", "objeto", "String", 100, false, false, false, "Objeto"),
                f("codigo", "codigo", "String", 50, false, false, false, "Codigo"),
                f("observacion", "observacion", "String", 300, false, false, false, "Observacion"))));
        add(new EntityMeta("empresa", "Empresa", "Empresa", Empresa.class, null, List.of(
                f("razonSocial", "razon_social", "String", 50, true, true, false, "Razon Social"),
                f("ruc", "ruc", "String", 15, false, false, false, "Ruc"),
                f("representante", "representante", "String", 100, false, false, false, "Representante"),
                f("docuIdenRepr", "docu_iden_repr", "String", 12, false, false, false, "Docu Iden Repr"),
                f("cargo", "cargo", "String", 30, false, false, false, "Cargo"),
                f("direccion", "direccion", "String", 150, false, false, false, "Direccion"),
                f("telefono", "telefono", "String", 100, false, false, false, "Telefono"),
                f("fax", "fax", "String", 50, false, false, false, "Fax"),
                f("direccionX", "direccion_x", "String", 150, false, false, false, "Direccion X"),
                f("telefonoX", "telefono_x", "String", 50, false, false, false, "Telefono X"),
                f("faxX", "fax_x", "String", 50, false, false, false, "Fax X"),
                f("actiEconPrin", "acti_econ_prin", "String", 200, false, false, false, "Acti Econ Prin"),
                f("nroRegi", "nro_regi", "String", 20, false, false, false, "Nro Regi"),
                f("fechIncr", "fech_incr", "LocalDateTime", 0, false, false, false, "Fech Incr"),
                f("ubigeo", "ubigeo", "String", 20, false, false, false, "Ubigeo"),
                f("objeSoci", "obje_soci", "String", 255, false, false, false, "Obje Soci"),
                f("objeSoci2", "obje_soci_2", "String", 255, false, false, false, "Obje Soci 2"),
                f("tipoEmpr", "tipo_empr", "String", 100, false, false, false, "Tipo Empr"),
                f("ciiu", "ciiu", "String", 20, false, false, false, "Ciiu"),
                f("cuenConInmu", "cuen_con_inmu", "String", 300, false, false, false, "Cuen Con Inmu"),
                f("eMail", "e_mail", "String", 50, false, false, false, "E Mail"),
                f("pagiWeb", "pagi_web", "String", 100, false, false, false, "Pagi Web"),
                f("departamento", "departamento", "String", 50, false, false, false, "Departamento"),
                f("provincia", "provincia", "String", 50, false, false, false, "Provincia"),
                f("distrito", "distrito", "String", 50, false, false, false, "Distrito"),
                f("urbanizacion", "urbanizacion", "String", 50, false, false, false, "Urbanizacion"),
                f("codiCaja", "codi_caja", "String", 10, false, false, false, "Codi Caja"),
                f("inicial", "inicial", "String", 10, false, false, false, "Inicial"),
                f("dnirepre", "dnirepre", "String", 8, false, false, false, "Dnirepre"),
                f("nomBole", "nom_bole", "String", 150, false, false, false, "Nom Bole"),
                f("carBole", "car_bole", "String", 150, false, false, false, "Car Bole"),
                f("docuBole", "docu_bole", "String", 20, false, false, false, "Docu Bole"),
                f("datMostrar", "dat_mostrar", "String", 30, false, false, false, "Dat Mostrar"),
                f("grupo", "grupo", "String", 10, false, false, false, "Grupo"),
                f("sector", "sector", "String", 20, false, false, false, "Sector"),
                f("reprFlota", "repr_flota", "String", 100, false, false, false, "Repr Flota"),
                f("dniReprFlot", "dni_repr_flot", "String", 20, false, false, false, "Dni Repr Flot"),
                f("codiTipoEmpr", "codi_tipo_empr", "String", 2, false, false, false, "Codi Tipo Empr"),
                f("iqfRegUso", "iqf_reg_uso", "String", 5, false, false, false, "Iqf Reg Uso"),
                f("iqfRegRu", "iqf_reg_ru", "String", 6, false, false, false, "Iqf Reg Ru"),
                f("rutaArchivo", "ruta_archivo", "String", 255, false, false, false, "Ruta Archivo"),
                f("ubl21", "ubl_21", "String", 1, false, false, false, "Ubl 21"))));
        add(new EntityMeta("usuarios_grupos", "USUARIOS_GRUPOS", "Usuarios Grupos", UsuariosGrupos.class, UsuariosGrupos.Pk.class, List.of(
                f("codiUsua", "codi_usua", "String", 5, true, true, false, "Codi Usua"),
                f("codiGrup", "codi_grup", "Integer", 0, true, true, false, "Codi Grup"))));
        add(new EntityMeta("visor_de_eventos", "VISOR_DE_EVENTOS", "Visor De Eventos", VisorDeEventos.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Id"),
                f("opcion", "opcion", "String", 50, false, false, false, "Opcion"),
                f("usuario", "usuario", "String", 5, false, false, false, "Usuario"),
                f("accion", "accion", "String", 1, false, false, false, "Accion"),
                f("informacion", "informacion", "String", 0, false, false, false, "Informacion"),
                f("computer", "computer", "String", 20, false, false, false, "Computer"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"))));
        add(new EntityMeta("viso_even", "VISO_EVEN", "Viso Even", VisoEven.class, VisoEven.Pk.class, List.of(
                f("fechEven", "fech_even", "LocalDateTime", 0, true, true, false, "Fech Even"),
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("descEven", "desc_even", "String", 200, false, false, false, "Desc Even"),
                f("namePc", "name_pc", "String", 30, false, false, false, "Name Pc"))));
        add(new EntityMeta("cierre_mes_user", "CIERRE_MES_USER", "Cierre Mes User", CierreMesUser.class, null, List.of(
                f("codiCierre", "codi_cierre", "Long", 0, true, true, false, "Codi Cierre"),
                f("codiUsua", "codi_usua", "String", 5, false, false, false, "Codi Usua"),
                f("mes", "mes", "String", 2, false, false, false, "Mes"),
                f("anio", "anio", "String", 4, false, false, false, "Anio"))));
        add(new EntityMeta("cierre_mes", "CIERRE_MES", "Cierre Mes", CierreMes.class, null, List.of(
                f("codiCierre", "codi_cierre", "Long", 0, true, true, false, "Codi Cierre"),
                f("anio", "anio", "String", 4, false, false, false, "Anio"),
                f("mes", "mes", "String", 2, false, false, false, "Mes"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"))));
        add(new EntityMeta("aceptacion_x_usuario", "ACEPTACION_X_USUARIO", "Aceptacion X Usuario", AceptacionXUsuario.class, AceptacionXUsuario.Pk.class, List.of(
                f("codiUsua", "codi_usua", "String", 5, true, true, false, "Codi Usua"),
                f("codiTipoAcep", "codi_tipo_acep", "String", 2, true, true, false, "Codi Tipo Acep"),
                f("crear", "crear", "String", 1, false, false, false, "Crear"),
                f("modificar", "modificar", "String", 1, false, false, false, "Modificar"),
                f("eliminar", "eliminar", "String", 1, false, false, false, "Eliminar"),
                f("guardar", "guardar", "String", 1, false, false, false, "Guardar"))));
        add(new EntityMeta("acceso", "ACCESO", "Acceso", Acceso.class, null, List.of(
                f("codAcceso", "cod_acceso", "Long", 0, true, true, false, "Cod Acceso"),
                f("codiUsua", "codi_usua", "String", 5, true, false, false, "Codi Usua"),
                f("fechaAcce", "fecha_acce", "LocalDateTime", 0, true, false, false, "Fecha Acce"),
                f("hora", "hora", "LocalDateTime", 0, true, false, false, "Hora"),
                f("tipo", "tipo", "String", 1, true, false, false, "Tipo"),
                f("glosa", "glosa", "String", 150, true, false, false, "Glosa"))));
        add(new EntityMeta("parametros", "Parametros", "Parametros", Parametros.class, null, List.of(
                f("idParm", "id_parm", "Integer", 0, true, true, false, "Id Parm"),
                f("descParm", "desc_parm", "String", 50, false, false, false, "Desc Parm"),
                f("valorParm", "valor_parm", "String", 100, false, false, false, "Valor Parm"),
                f("valor1", "valor1", "Long", 0, false, false, false, "Valor1"),
                f("valor2", "valor2", "Long", 0, false, false, false, "Valor2"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"))));
        add(new EntityMeta("grupos", "Grupos", "Grupos", Grupos.class, null, List.of(
                f("codiGrup", "codi_grup", "Integer", 0, true, true, false, "Codi Grup"),
                f("nombGrup", "nomb_grup", "String", 15, true, false, false, "Nomb Grup"))));
        add(new EntityMeta("menugrupos", "MenuGrupos", "Menugrupos", Menugrupos.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("codiMenu", "codi_menu", "Integer", 0, true, false, false, "Codi Menu"),
                f("nombMenu", "nomb_menu", "String", 150, true, false, false, "Nomb Menu"),
                f("codiGrup", "codi_grup", "Integer", 0, true, false, false, "Codi Grup"),
                f("activo", "activo", "Integer", 0, true, false, false, "Activo"),
                f("nivel", "nivel", "Integer", 0, false, false, false, "Nivel"),
                f("clase", "clase", "String", 50, false, false, false, "Clase"))));
        add(new EntityMeta("empresa_establecimiento", "EMPRESA_ESTABLECIMIENTO", "Empresa Establecimiento", EmpresaEstablecimiento.class, null, List.of(
                f("codiEmpreEstab", "codi_empre_estab", "Integer", 0, true, true, false, "Codi Empre Estab"),
                f("codiEmpre", "codi_empre", "Integer", 0, false, false, false, "Codi Empre"),
                f("codigoDenomi", "codigo_denomi", "String", 4, false, false, false, "Codigo Denomi"),
                f("denominacion", "denominacion", "String", 50, true, false, false, "Denominacion"),
                f("codiTipoEstab", "codi_tipo_estab", "Short", 0, true, false, false, "Codi Tipo Estab"),
                f("centroRiesgo", "centro_riesgo", "String", 1, true, false, false, "Centro Riesgo"))));
        add(new EntityMeta("empresa_establec_tasas", "EMPRESA_ESTABLEC_TASAS", "Empresa Establec Tasas", EmpresaEstablecTasas.class, null, List.of(
                f("codiTasa", "codi_tasa", "Integer", 0, true, true, false, "Codi Tasa"),
                f("codiEmpreEstab", "codi_empre_estab", "Integer", 0, true, false, false, "Codi Empre Estab"),
                f("tasa", "tasa", "Long", 0, true, false, false, "Tasa"),
                f("estado", "estado", "String", 1, false, false, false, "Estado"))));
        add(new EntityMeta("parametro", "Parametro", "Parametro", Parametro.class, null, List.of(
                f("codParam", "cod_param", "Short", 0, true, true, false, "Cod Param"),
                f("descParam", "desc_param", "String", 75, true, false, false, "Desc Param"),
                f("unidMedi", "unid_medi", "String", 15, false, false, false, "Unid Medi"),
                f("nemo", "nemo", "String", 15, true, false, false, "Nemo"),
                f("ordenRepo", "orden_repo", "Short", 0, false, false, false, "Orden Repo"),
                f("limitemin", "limitemin", "BigDecimal", 0, true, false, false, "Limitemin"),
                f("limitemax", "limitemax", "BigDecimal", 0, true, false, false, "Limitemax"),
                f("optimo", "optimo", "Short", 0, true, false, false, "el valor optimo es hacia 1 arriba 0 abajo"),
                f("codiProd", "codi_prod", "String", 8, true, false, false, "Codi Prod"),
                f("tipo", "tipo", "Short", 0, true, false, false, "0 valor 1 porcentaje"),
                f("calculable", "calculable", "Short", 0, true, false, false, "Calculable"))));
    }

    @Override
    public String service() {
        return "seguridad";
    }

    @Override
    public Optional<EntityMeta> find(String name) {
        return Optional.ofNullable(entities.get(name));
    }

    @Override
    public List<EntityMeta> all() {
        return List.copyOf(entities.values());
    }
}

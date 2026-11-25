package pe.sige.maestros.domain.legacy;

import jakarta.enterprise.context.ApplicationScoped;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import pe.sige.common.catalog.EntityCatalog;
import pe.sige.common.catalog.EntityMeta;
import pe.sige.common.catalog.FieldMeta;

/** Catalogo de entidades legado de ms-maestros (44 tablas). Generado: no editar. */
@ApplicationScoped
public class LegacyCatalog implements EntityCatalog {

    private final Map<String, EntityMeta> entities = new LinkedHashMap<>();

    public LegacyCatalog() {
        load0();
        load1();
    }

    private void add(EntityMeta m) {
        entities.put(m.name(), m);
    }

    private static FieldMeta f(String field, String column, String type, int length, boolean required, boolean id, boolean generated, String label) {
        return new FieldMeta(field, column, type, length, required, id, generated, label);
    }

    private void load0() {
        add(new EntityMeta("tipo_documento", "TIPO_DOCUMENTO", "Tipo Documento", TipoDocumento.class, null, List.of(
                f("codiTipoDocu", "codi_tipo_docu", "String", 4, true, true, false, "Codi Tipo Docu"),
                f("descTipoDocu", "desc_tipo_docu", "String", 150, true, false, false, "Desc Tipo Docu"),
                f("tipoCont", "tipo_cont", "String", 1, false, false, false, "Tipo Cont"),
                f("nemo", "nemo", "String", 3, false, false, false, "Nemo"),
                f("formaPago", "forma_pago", "String", 3, false, false, false, "Forma Pago"),
                f("codiTipoEssa", "codi_tipo_essa", "Short", 0, false, false, false, "Codi Tipo Essa"),
                f("tipoSunat", "tipo_sunat", "String", 2, false, false, false, "Tipo Sunat"),
                f("codiSunat", "codi_sunat", "String", 2, false, false, false, "Codi Sunat"))));
        add(new EntityMeta("monedas", "MONEDAS", "Monedas", Monedas.class, null, List.of(
                f("codiMone", "codi_mone", "String", 2, true, true, false, "Codi Mone"),
                f("descMone", "desc_mone", "String", 50, true, false, false, "Desc Mone"),
                f("simbolo", "simbolo", "String", 10, false, false, false, "Simbolo"),
                f("codiSunat", "codi_sunat", "Short", 0, true, false, false, "Codi Sunat"))));
        add(new EntityMeta("cliente_proveedor", "CLIENTE_PROVEEDOR", "Cliente Proveedor", ClienteProveedor.class, null, List.of(
                f("codiClieProv", "codi_clie_prov", "String", 5, true, true, false, "Codi Clie Prov"),
                f("tipoPers", "tipo_pers", "String", 12, false, false, false, "Tipo Pers"),
                f("razoSoci", "razo_soci", "String", 100, false, false, false, "Razo Soci"),
                f("nomb1", "nomb_1", "String", 30, false, false, false, "Nomb 1"),
                f("nomb2", "nomb_2", "String", 30, false, false, false, "Nomb 2"),
                f("apel1", "apel_1", "String", 30, false, false, false, "Apel 1"),
                f("apel2", "apel_2", "String", 30, false, false, false, "Apel 2"),
                f("ruc", "ruc", "String", 15, false, false, false, "Ruc"),
                f("reprLega", "repr_lega", "String", 120, false, false, false, "Repr Lega"),
                f("denominacion", "denominacion", "String", 100, false, false, false, "Denominacion"),
                f("direccion", "direccion", "String", 150, false, false, false, "Direccion"),
                f("tele1", "tele_1", "String", 12, false, false, false, "Tele 1"),
                f("tele2", "tele_2", "String", 12, false, false, false, "Tele 2"),
                f("fax", "fax", "String", 12, false, false, false, "Fax"),
                f("eMail", "e_mail", "String", 150, false, false, false, "E Mail"),
                f("tipoRela", "tipo_rela", "String", 25, false, false, false, "Tipo Rela"),
                f("distrito", "distrito", "String", 50, false, false, false, "Distrito"),
                f("provincia", "provincia", "String", 50, false, false, false, "Provincia"),
                f("departamento", "departamento", "String", 50, false, false, false, "Departamento"),
                f("codiActiEcon", "codi_acti_econ", "String", 4, false, false, false, "Codi Acti Econ"),
                f("sujeDetr", "suje_detr", "Boolean", 0, false, false, false, "Suje Detr"),
                f("abreviatura", "abreviatura", "String", 30, false, false, false, "Abreviatura"),
                f("propio", "propio", "Boolean", 0, false, false, false, "Propio"),
                f("reten", "reten", "String", 1, false, false, false, "Reten"),
                f("nroCertificado", "nro_certificado", "String", 4, false, false, false, "Nro Certificado"),
                f("codiTipoDocuIden", "codi_tipo_docu_iden", "Short", 0, false, false, false, "Codi Tipo Docu Iden"),
                f("fechNaci", "fech_naci", "LocalDateTime", 0, false, false, false, "Fech Naci"),
                f("sexo", "sexo", "String", 1, false, false, false, "Sexo"),
                f("codiNacion", "codi_nacion", "Short", 0, false, false, false, "Codi Nacion"),
                f("essaludVida", "essalud_vida", "String", 1, false, false, false, "Essalud Vida"),
                f("domiciliado", "domiciliado", "String", 1, false, false, false, "Domiciliado"),
                f("dv", "dv", "Short", 0, false, false, false, "Dv"),
                f("estaActi", "esta_acti", "String", 1, false, false, false, "Esta Acti"),
                f("frecuencia", "frecuencia", "String", 2, false, false, false, "Frecuencia"),
                f("codiUbiDist", "codi_ubi_dist", "Integer", 0, false, false, false, "Codi Ubi Dist"),
                f("codiSunatEsta", "codi_sunat_esta", "String", 4, false, false, false, "Codi Sunat Esta"))));
        add(new EntityMeta("unidad_medida", "UNIDAD_MEDIDA", "Unidad Medida", UnidadMedida.class, null, List.of(
                f("codiUnidMedi", "codi_unid_medi", "String", 2, true, true, false, "Codi Unid Medi"),
                f("descUnidMedi", "desc_unid_medi", "String", 100, false, false, false, "Desc Unid Medi"),
                f("tipoUnidMedi", "tipo_unid_medi", "String", 50, false, false, false, "Tipo Unid Medi"),
                f("simbUnidMedi", "simb_unid_medi", "String", 3, false, false, false, "Simb Unid Medi"),
                f("codiSunat", "codi_sunat", "String", 2, true, false, false, "Codi Sunat"),
                f("unidMediInte", "unid_medi_inte", "String", 3, false, false, false, "Unid Medi Inte"))));
        add(new EntityMeta("unid_oper", "UNID_OPER", "Unid Oper", UnidOper.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("codiUnidOper", "codi_unid_oper", "String", 5, true, false, false, "Codi Unid Oper"),
                f("descUnidOper", "desc_unid_oper", "String", 100, true, false, false, "Desc Unid Oper"),
                f("codiPers", "codi_pers", "String", 5, false, false, false, "Codi Pers"),
                f("ubicacion", "ubicacion", "String", 100, false, false, false, "Ubicacion"),
                f("codiLcc", "codi_lcc", "String", 5, false, false, false, "Codi Lcc"))));
        add(new EntityMeta("unidad_negocio", "UNIDAD_NEGOCIO", "Unidad Negocio", UnidadNegocio.class, null, List.of(
                f("codiUnidNego", "codi_unid_nego", "String", 2, true, true, false, "Codi Unid Nego"),
                f("descUnidNego", "desc_unid_nego", "String", 50, true, false, false, "Desc Unid Nego"))));
        add(new EntityMeta("tipo_cambio_a_dolar", "TIPO_CAMBIO_A_DOLAR", "Tipo Cambio A Dolar", TipoCambioADolar.class, TipoCambioADolar.Pk.class, List.of(
                f("codiMoneOrig", "codi_mone_orig", "String", 2, true, true, false, "Codi Mone Orig"),
                f("fechCamb", "fech_camb", "LocalDateTime", 0, true, true, false, "Fech Camb"),
                f("compra", "compra", "BigDecimal", 0, false, false, false, "Compra"),
                f("venta", "venta", "BigDecimal", 0, false, false, false, "Venta"),
                f("codiMoneCamb", "codi_mone_camb", "String", 2, true, true, false, "Codi Mone Camb"),
                f("ventaComerDAS", "venta_comer_d_a_s", "BigDecimal", 0, false, false, false, "Venta Comer D A S"))));
        add(new EntityMeta("valores_unitarios", "VALORES_UNITARIOS", "Valores Unitarios", ValoresUnitarios.class, null, List.of(
                f("codiValoUnit", "codi_valo_unit", "Integer", 0, true, true, false, "Codi Valo Unit"),
                f("descValoUnit", "desc_valo_unit", "String", 50, false, false, false, "Desc Valo Unit"),
                f("nemo", "nemo", "String", 4, false, false, false, "Nemo"))));
        add(new EntityMeta("valores_unitarios_anuales", "VALORES_UNITARIOS_ANUALES", "Valores Unitarios Anuales", ValoresUnitariosAnuales.class, ValoresUnitariosAnuales.Pk.class, List.of(
                f("codiValoUnit", "codi_valo_unit", "Integer", 0, true, true, false, "Codi Valo Unit"),
                f("fechAsig", "fech_asig", "LocalDateTime", 0, true, true, false, "Fech Asig"),
                f("fechAsigFin", "fech_asig_fin", "LocalDateTime", 0, false, false, false, "Fech Asig Fin"),
                f("valor", "valor", "BigDecimal", 0, true, false, false, "Valor"),
                f("tipoValo", "tipo_valo", "Boolean", 0, true, false, false, "Tipo Valo"),
                f("estaActi", "esta_acti", "Boolean", 0, true, false, false, "Esta Acti"))));
        add(new EntityMeta("referencias", "REFERENCIAS", "Referencias", Referencias.class, null, List.of(
                f("codiRefe", "codi_refe", "String", 2, true, true, false, "Codi Refe"),
                f("descripRefe", "descrip_refe", "String", 100, false, false, false, "Descrip Refe"))));
        add(new EntityMeta("tipo_empresa", "TIPO_EMPRESA", "Tipo Empresa", TipoEmpresa.class, null, List.of(
                f("codiTipoEmpr", "codi_tipo_empr", "String", 2, true, true, false, "Codi Tipo Empr"),
                f("descTipoEmpr", "desc_tipo_empr", "String", 50, false, false, false, "Desc Tipo Empr"),
                f("nemo", "nemo", "String", 20, false, false, false, "Nemo"))));
        add(new EntityMeta("feriados", "FERIADOS", "Feriados", Feriados.class, Feriados.Pk.class, List.of(
                f("mes", "mes", "String", 2, true, true, false, "Mes"),
                f("dia", "dia", "String", 2, true, true, false, "Dia"),
                f("anio", "anio", "String", 4, true, true, false, "Anio"),
                f("descFeri", "desc_feri", "String", 50, true, false, false, "Desc Feri"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"))));
        add(new EntityMeta("tipo_medida", "TIPO_MEDIDA", "Tipo Medida", TipoMedida.class, null, List.of(
                f("codigo", "codigo", "String", 2, true, true, false, "Codigo"),
                f("descMedida", "desc_medida", "String", 50, false, false, false, "Desc Medida"))));
        add(new EntityMeta("codigos_ldistancia", "CODIGOS_LDISTANCIA", "Codigos Ldistancia", CodigosLdistancia.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("codiLdistanci", "codi_ldistanci", "String", 3, true, false, false, "Codi Ldistanci"),
                f("descripcion", "descripcion", "String", 50, false, false, false, "Descripcion"))));
        add(new EntityMeta("motivos", "MOTIVOS", "Motivos", Motivos.class, null, List.of(
                f("codiMoti", "codi_moti", "String", 3, true, true, false, "Codi Moti"),
                f("descMoti", "desc_moti", "String", 100, true, false, false, "Desc Moti"))));
        add(new EntityMeta("aduana", "ADUANA", "Aduana", Aduana.class, null, List.of(
                f("codiAduana", "codi_aduana", "Short", 0, true, true, false, "Codi Aduana"),
                f("codiSunat", "codi_sunat", "String", 3, true, false, false, "Codi Sunat"),
                f("descAduana", "desc_aduana", "String", 200, true, false, false, "Desc Aduana"))));
        add(new EntityMeta("ubigeo_region", "UBIGEO_REGION", "Ubigeo Region", UbigeoRegion.class, null, List.of(
                f("codiUbiReg", "codi_ubi_reg", "Short", 0, true, true, false, "Codi Ubi Reg"),
                f("codiUbiRegSunat", "codi_ubi_reg_sunat", "String", 2, true, false, false, "Codi Ubi Reg Sunat"),
                f("descUbiReg", "desc_ubi_reg", "String", 100, true, false, false, "Desc Ubi Reg"))));
        add(new EntityMeta("via", "VIA", "Via", Via.class, null, List.of(
                f("codiVia", "codi_via", "Short", 0, true, true, false, "Codi Via"),
                f("codiViaSunat", "codi_via_sunat", "String", 2, true, false, false, "Codi Via Sunat"),
                f("descVia", "desc_via", "String", 20, true, false, false, "Desc Via"),
                f("nemoVia", "nemo_via", "String", 5, false, false, false, "Nemo Via"))));
        add(new EntityMeta("tipo_pago", "TIPO_PAGO", "Tipo Pago", TipoPago.class, null, List.of(
                f("codiTipoMedioPago", "codi_tipo_medio_pago", "Short", 0, true, true, false, "Codi Tipo Medio Pago"),
                f("codiSunat", "codi_sunat", "String", 3, true, false, false, "Codi Sunat"),
                f("descTipoMedioPago", "desc_tipo_medio_pago", "String", 250, true, false, false, "Desc Tipo Medio Pago"),
                f("nemo", "nemo", "String", 30, false, false, false, "Nemo"))));
        add(new EntityMeta("clie_prov_suspen_cta_categ", "CLIE_PROV_SUSPEN_CTA_CATEG", "Clie Prov Suspen Cta Categ", ClieProvSuspenCtaCateg.class, null, List.of(
                f("codiClieProvSupsCtaCateg", "codi_clie_prov_sups_cta_categ", "Long", 0, true, true, false, "Codi Clie Prov Sups Cta Categ"),
                f("codiClieProv", "codi_clie_prov", "String", 5, true, false, false, "Codi Clie Prov"),
                f("nroOperacion", "nro_operacion", "String", 15, false, false, false, "Nro Operacion"),
                f("fechInicio", "fech_inicio", "LocalDateTime", 0, true, false, false, "Fech Inicio"),
                f("anio", "anio", "String", 4, true, false, false, "Anio"),
                f("medioPresentacion", "medio_presentacion", "String", 1, true, false, false, "Medio Presentacion"))));
        add(new EntityMeta("zonas", "ZONAS", "Zonas", Zonas.class, null, List.of(
                f("codZona", "cod_zona", "Long", 0, true, true, false, "Cod Zona"),
                f("descZona", "desc_zona", "String", 100, false, false, false, "Desc Zona"))));
        add(new EntityMeta("zona", "ZONA", "Zona", Zona.class, null, List.of(
                f("codiZona", "codi_zona", "Short", 0, true, true, false, "Codi Zona"),
                f("codiZonaSunat", "codi_zona_sunat", "String", 2, true, false, false, "Codi Zona Sunat"),
                f("descZona", "desc_zona", "String", 50, true, false, false, "Desc Zona"),
                f("nemoZona", "nemo_zona", "String", 5, false, false, false, "Nemo Zona"))));
        add(new EntityMeta("acti_econ_prin", "ACTI_ECON_PRIN", "Acti Econ Prin", ActiEconPrin.class, null, List.of(
                f("codiActiEcon", "codi_acti_econ", "String", 4, true, true, false, "Codi Acti Econ"),
                f("descActiEcon", "desc_acti_econ", "String", 200, false, false, false, "Desc Acti Econ"),
                f("nemoActiEcon", "nemo_acti_econ", "String", 20, false, false, false, "Nemo Acti Econ"))));
        add(new EntityMeta("estados", "ESTADOS", "Estados", Estados.class, null, List.of(
                f("estado", "estado", "String", 1, true, true, false, "Estado"),
                f("descEsta", "desc_esta", "String", 50, false, false, false, "Desc Esta"))));
        add(new EntityMeta("establecimiento", "ESTABLECIMIENTO", "Establecimiento", Establecimiento.class, null, List.of(
                f("codiEsta", "codi_esta", "Short", 0, true, true, false, "Codi Esta"),
                f("codiEstaSunat", "codi_esta_sunat", "String", 2, true, false, false, "Codi Esta Sunat"),
                f("descEsta", "desc_esta", "String", 100, true, false, false, "Desc Esta"))));
    }

    private void load1() {
        add(new EntityMeta("tipo_unid_oper", "TIPO_UNID_OPER", "Tipo Unid Oper", TipoUnidOper.class, null, List.of(
                f("codiTipoUnidOper", "codi_tipo_unid_oper", "String", 2, true, true, false, "Codi Tipo Unid Oper"),
                f("descTipoUnidOper", "desc_tipo_unid_oper", "String", 100, false, false, false, "Desc Tipo Unid Oper"),
                f("nemo", "nemo", "String", 4, false, false, false, "Nemo"))));
        add(new EntityMeta("unidad_medida_sunat", "UNIDAD_MEDIDA_SUNAT", "Unidad Medida Sunat", UnidadMedidaSunat.class, null, List.of(
                f("codigo", "codigo", "String", 2, true, true, false, "Codigo"),
                f("descUnid", "desc_unid", "String", 50, false, false, false, "Desc Unid"))));
        add(new EntityMeta("unidad_medida_inter", "UNIDAD_MEDIDA_INTER", "Unidad Medida Inter", UnidadMedidaInter.class, null, List.of(
                f("codiUnidMedi", "codi_unid_medi", "String", 5, true, true, false, "Codi Unid Medi"),
                f("descUnidMedi", "desc_unid_medi", "String", 255, false, false, false, "Desc Unid Medi"),
                f("tipoUnidMedi", "tipo_unid_medi", "String", 50, false, false, false, "Tipo Unid Medi"),
                f("simbUnidMedi", "simb_unid_medi", "String", 3, false, false, false, "Simb Unid Medi"),
                f("codiSunat", "codi_sunat", "String", 2, false, false, false, "Codi Sunat"))));
        add(new EntityMeta("cultivos", "CULTIVOS", "Cultivos", Cultivos.class, null, List.of(
                f("codCultivo", "cod_cultivo", "Integer", 0, true, true, false, "Cod Cultivo"),
                f("descCultivo", "desc_cultivo", "String", 100, false, false, false, "Desc Cultivo"),
                f("nroDias", "nro_dias", "Integer", 0, false, false, false, "Nro Dias"))));
        add(new EntityMeta("semana", "SEMANA", "Semana", Semana.class, null, List.of(
                f("codiSema", "codi_sema", "String", 8, true, true, false, "Codi Sema"),
                f("nroSema", "nro_sema", "Short", 0, true, false, false, "Nro Sema"),
                f("fechInic", "fech_inic", "LocalDateTime", 0, true, false, false, "Fech Inic"),
                f("fechTerm", "fech_term", "LocalDateTime", 0, false, false, false, "Fech Term"),
                f("aniomes", "aniomes", "String", 6, false, false, false, "Aniomes"),
                f("codiTipoPers", "codi_tipo_pers", "String", 2, false, false, false, "Codi Tipo Pers"))));
        add(new EntityMeta("tipo_docu_iden", "TIPO_DOCU_IDEN", "Tipo Docu Iden", TipoDocuIden.class, null, List.of(
                f("codiTipoDocuIden", "codi_tipo_docu_iden", "Short", 0, true, true, false, "Codi Tipo Docu Iden"),
                f("codiSunat", "codi_sunat", "Short", 0, true, false, false, "Codi Sunat"),
                f("descTipoDocuIden", "desc_tipo_docu_iden", "String", 100, true, false, false, "Desc Tipo Docu Iden"),
                f("nemo", "nemo", "String", 20, false, false, false, "Nemo"))));
        add(new EntityMeta("terceros", "Terceros", "Terceros", Terceros.class, null, List.of(
                f("dni", "dni", "String", 10, true, true, false, "Dni"),
                f("datos", "datos", "String", 100, false, false, false, "Datos"),
                f("codiCarg", "codi_carg", "String", 4, false, false, false, "Codi Carg"))));
        add(new EntityMeta("nacion", "NACION", "Nacion", Nacion.class, null, List.of(
                f("codiNacion", "codi_nacion", "Short", 0, true, true, false, "Codi Nacion"),
                f("codiNacionSunat", "codi_nacion_sunat", "String", 4, true, false, false, "Codi Nacion Sunat"),
                f("descNacion", "desc_nacion", "String", 150, true, false, false, "Desc Nacion"))));
        add(new EntityMeta("cliente_natural", "Cliente_Natural", "Cliente Natural", ClienteNatural.class, null, List.of(
                f("idClieNatu", "id_clie_natu", "Integer", 0, true, true, false, "Id Clie Natu"),
                f("apellidos", "apellidos", "String", 50, true, false, false, "Apellidos"),
                f("nombres", "nombres", "String", 50, true, false, false, "Nombres"),
                f("nroDocu", "nro_docu", "String", 20, false, false, false, "Nro Docu"),
                f("direccion", "direccion", "String", 100, false, false, false, "Direccion"),
                f("codiClieProv", "codi_clie_prov", "String", 5, true, false, false, "Codi Clie Prov"))));
        add(new EntityMeta("domicilio", "Domicilio", "Domicilio", Domicilio.class, null, List.of(
                f("codiDomi", "codi_domi", "String", 4, true, true, false, "Codi Domi"),
                f("descDomi", "desc_domi", "String", 150, false, false, false, "Desc Domi"),
                f("distrito", "distrito", "String", 30, false, false, false, "Distrito"),
                f("provincia", "provincia", "String", 30, false, false, false, "Provincia"),
                f("departamento", "departamento", "String", 30, false, false, false, "Departamento"))));
        add(new EntityMeta("documentos", "Documentos", "Documentos", Documentos.class, Documentos.Pk.class, List.of(
                f("codiTipoDocu", "codi_tipo_docu", "String", 4, true, true, false, "Codi Tipo Docu"),
                f("serie", "serie", "Short", 0, true, true, false, "Serie"),
                f("nroActual", "nro_actual", "Integer", 0, true, false, false, "Nro Actual"))));
        add(new EntityMeta("transportistas", "Transportistas", "Transportistas", Transportistas.class, null, List.of(
                f("codiTrans", "codi_trans", "String", 4, true, true, false, "Codi Trans"),
                f("descTrans", "desc_trans", "String", 100, false, false, false, "Desc Trans"),
                f("iden", "iden", "String", 20, false, false, false, "Iden"),
                f("direccion", "direccion", "String", 150, false, false, false, "Direccion"),
                f("nroLiceCond", "nro_lice_cond", "String", 25, false, false, false, "Nro Lice Cond"),
                f("nextel", "nextel", "String", 15, false, false, false, "Nextel"))));
        add(new EntityMeta("transacciones", "TRANSACCIONES", "Transacciones", Transacciones.class, null, List.of(
                f("codiTran", "codi_tran", "String", 3, true, true, false, "Codi Tran"),
                f("descTran", "desc_tran", "String", 20, true, false, false, "Desc Tran"))));
        add(new EntityMeta("pais_emisor", "PAIS_EMISOR", "Pais Emisor", PaisEmisor.class, null, List.of(
                f("id", "id", "Long", 0, true, true, true, "Clave sustituta agregada en la migracion (la tabla legado no tenia PK)"),
                f("codiPaisEmi", "codi_pais_emi", "String", 3, true, false, false, "Codi Pais Emi"),
                f("descripcion", "descripcion", "String", 150, false, false, false, "Descripcion"))));
        add(new EntityMeta("evento", "EVENTO", "Evento", Evento.class, null, List.of(
                f("codiPlan", "codi_plan", "Long", 0, true, true, false, "Codi Plan"),
                f("nroEven", "nro_even", "String", 12, false, false, false, "Nro Even"),
                f("evento", "evento", "String", 100, false, false, false, "Evento"),
                f("tipo", "tipo", "String", 20, false, false, false, "Tipo"),
                f("fecha", "fecha", "LocalDateTime", 0, false, false, false, "Fecha"),
                f("duracion", "duracion", "LocalDateTime", 0, false, false, false, "Duracion"),
                f("hIni", "h_ini", "LocalDateTime", 0, false, false, false, "H Ini"),
                f("hFin", "h_fin", "LocalDateTime", 0, false, false, false, "H Fin"),
                f("ubicacion", "ubicacion", "String", 150, false, false, false, "Ubicacion"),
                f("notas", "notas", "String", 0, false, false, false, "Notas"),
                f("informe", "informe", "String", 0, false, false, false, "Informe"),
                f("codiAlma", "codi_alma", "String", 2, false, false, false, "Codi Alma"),
                f("codiPers", "codi_pers", "String", 5, false, false, false, "Codi Pers"))));
        add(new EntityMeta("etapa_fenologica", "ETAPA_FENOLOGICA", "Etapa Fenologica", EtapaFenologica.class, null, List.of(
                f("codEta", "cod_eta", "Long", 0, true, true, false, "Cod Eta"),
                f("descEta", "desc_eta", "String", 100, false, false, false, "Desc Eta"))));
        add(new EntityMeta("ubigeo_provincia", "UBIGEO_PROVINCIA", "Ubigeo Provincia", UbigeoProvincia.class, null, List.of(
                f("codiUbiProv", "codi_ubi_prov", "Short", 0, true, true, false, "Codi Ubi Prov"),
                f("codiUbiProvSunat", "codi_ubi_prov_sunat", "String", 4, true, false, false, "Codi Ubi Prov Sunat"),
                f("descUbiProv", "desc_ubi_prov", "String", 100, true, false, false, "Desc Ubi Prov"),
                f("codiUbiRegSunat", "codi_ubi_reg_sunat", "String", 2, false, false, false, "Codi Ubi Reg Sunat"))));
        add(new EntityMeta("ubigeo_distrito", "UBIGEO_DISTRITO", "Ubigeo Distrito", UbigeoDistrito.class, null, List.of(
                f("codiUbiDist", "codi_ubi_dist", "Short", 0, true, true, false, "Codi Ubi Dist"),
                f("codiUbiDistSunat", "codi_ubi_dist_sunat", "String", 6, true, false, false, "Codi Ubi Dist Sunat"),
                f("descUbiDist", "desc_ubi_dist", "String", 100, true, false, false, "Desc Ubi Dist"),
                f("codiUbiProvSunat", "codi_ubi_prov_sunat", "String", 4, false, false, false, "Codi Ubi Prov Sunat"))));
        add(new EntityMeta("telefono", "TELEFONO", "Telefono", Telefono.class, Telefono.Pk.class, List.of(
                f("codiPers", "codi_pers", "String", 5, true, true, false, "Codi Pers"),
                f("nroTele", "nro_tele", "String", 12, true, true, false, "Nro Tele"),
                f("tipoTele", "tipo_tele", "String", 20, false, false, false, "Tipo Tele"),
                f("observacion", "observacion", "String", 50, false, false, false, "Observacion"))));
    }

    @Override
    public String service() {
        return "maestros";
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

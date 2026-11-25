-- Generado por tools/db-migrator a partir del script SQL Server legado. No editar a mano:
-- los cambios evolutivos van en migraciones nuevas (V100__..., V101__...).
-- Servicio: ms-ventas (Facturacion, Ventas y Operaciones comerciales)
-- Tablas: 72

-- Tipo_Factura
CREATE TABLE tipo_factura (
    codi_tipo varchar(2) NOT NULL,
    descrip varchar(30) NOT NULL,
    tipo varchar(1),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_tipo_factura PRIMARY KEY (codi_tipo)
);

-- FACTURA
CREATE TABLE factura (
    codi_fact varchar(10) NOT NULL,
    codi_alma varchar(2),
    codi_clie_prov varchar(5) NOT NULL,
    fech_fact timestamp(3) NOT NULL,
    codi_tipo_docu varchar(4),
    ser_fact varchar(5) NOT NULL,
    nro_fact varchar(10) NOT NULL,
    orde_fact varchar(30),
    tele_fact varchar(50),
    guia_fact varchar(250),
    venc_fact timestamp(3),
    tipo_fact varchar(2),
    codi_mone varchar(2),
    tcambio numeric(19,4),
    codi_tipo_pago integer,
    tipo_credito smallint,
    valo_fact numeric(12,3),
    dscto_fact numeric(19,4),
    subtota_fact numeric(19,4),
    tota_exonerado numeric(19,4),
    valor_igv numeric(12,2),
    igv_fact numeric(12,3),
    tota_fact numeric(12,3),
    codi_orde_grua varchar(10),
    estado varchar(1),
    codi_unid_oper varchar(5),
    codi_vouc varchar(10),
    contabilizado varchar(1),
    aplica_igv varchar(1),
    cod_imp integer,
    cod_usua varchar(5),
    impreso varchar(1),
    cod_usua_vende varchar(5),
    cod_siembra bigint,
    fec_pago timestamp(3),
    cod_cultivo integer,
    cod_zona bigint,
    cod_usua_recetista varchar(5),
    prov_canc varchar(1),
    creacion timestamp(3),
    hectarea numeric(18,3),
    hecho_por varchar(5),
    nro_dias integer,
    codi_conv bigint,
    fecha_siembra timestamp(3),
    detra varchar(1),
    codi_bien_serv varchar(5),
    printer_name varchar(250),
    dias_fact bigint,
    mes integer GENERATED ALWAYS AS (EXTRACT(MONTH FROM fech_fact)::integer) STORED,
    anio integer GENERATED ALWAYS AS (EXTRACT(YEAR FROM fech_fact)::integer) STORED,
    codi_oper varchar(4),
    cod_usua_modi varchar(5),
    total_gratuita numeric(12,2),
    fecha_elim timestamp(3),
    motivo_elim varchar(100),
    codi_desc varchar(2),
    dscto_global numeric(12,2),
    factor_dscto numeric(12,2),
    nro_cuotas integer,
    codi_guia_rem bigint,
    tipo_impr varchar(1),
    pdetr numeric(18,3),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_factura PRIMARY KEY (codi_fact)
);

-- PRODUCTOS_OFERTAS
CREATE TABLE productos_ofertas (
    item bigint NOT NULL,
    codi_prod varchar(8),
    cantidad numeric(18,2),
    precio numeric(18,4),
    fecha_ini timestamp(3),
    fecha_fin timestamp(3),
    estado varchar(1),
    codi_alma varchar(2),
    codi_mone varchar(2),
    usado numeric(12,4),
    precio_costo numeric(12,4),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_productos_ofertas PRIMARY KEY (item)
);

-- FACTURA_DETALLE
CREATE TABLE factura_detalle (
    codi_fact varchar(10) NOT NULL,
    codi_deta varchar(3) NOT NULL,
    codi_alma varchar(2),
    codi_item varchar(10),
    codi_prod varchar(8),
    desc_item varchar(300),
    codi_unid_medi varchar(2),
    cant_item numeric(12,3),
    prec_item numeric(18,7),
    prec_lista numeric(18,7),
    dscto_prec numeric(19,4),
    dscto_item numeric(19,4),
    impo_item numeric(12,3),
    igv numeric(18,3),
    codi_mate varchar(10),
    cant_saldo bigint,
    codi_imp integer,
    prec_costo numeric(19,4),
    incl_igv varchar(1),
    saldo_conv numeric(18,2),
    prod_ofer varchar(1),
    codi_desc_deta varchar(2),
    codi_tipo_afec varchar(2),
    tipo_rot varchar(7),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_factura_detalle PRIMARY KEY (codi_fact, codi_deta)
);

-- CLIENTE_CREDITOS
CREATE TABLE cliente_creditos (
    codi_credito bigint NOT NULL,
    codi_clie_prov varchar(5) NOT NULL,
    fec_inic_cred timestamp(3) NOT NULL,
    codi_mone varchar(2) NOT NULL,
    monto_cred numeric(19,4) NOT NULL,
    fec_fin_cred timestamp(3),
    observa_cred varchar(100),
    codi_usua_autoriza varchar(5) NOT NULL,
    estado varchar(1),
    codi_usua_responsa varchar(5),
    tipo_cred varchar(1),
    codi_alma varchar(2),
    multi_credito varchar(1),
    tipo_pago varchar(1),
    doc_garantia varchar(2),
    fec_pago timestamp(3),
    fec_icomp timestamp(3),
    fconyuge boolean,
    faval boolean,
    cdnicliente boolean,
    cdniconyuge boolean,
    ccontrarrend boolean,
    crecserv varchar(100),
    ctitprop varchar(100),
    terrprop varchar(255),
    casa varchar(255),
    vehiculo varchar(255),
    negocio varchar(255),
    referencias varchar(255),
    fec_csf timestamp(3),
    codigosf varchar(20),
    calificacion varchar(50),
    capital numeric(18,2),
    intereses numeric(18,2),
    total numeric(18,2),
    vae1 numeric(18,2),
    vae2 numeric(18,2),
    vae3 numeric(18,2),
    vac1 numeric(18,2),
    vac2 numeric(18,2),
    vac3 numeric(18,2),
    infocorp varchar(1),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_cliente_creditos PRIMARY KEY (codi_credito)
);

-- FACTURA_CREDITO
CREATE TABLE factura_credito (
    codi_fact varchar(10) NOT NULL,
    codi_credito bigint NOT NULL,
    monto numeric(19,4) NOT NULL,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_factura_credito PRIMARY KEY (codi_fact, codi_credito)
);

-- RECOMENDACION_DETA
CREATE TABLE recomendacion_deta (
    codi_rec bigint NOT NULL,
    codi_deta bigint NOT NULL,
    codi_prod varchar(8),
    dosis varchar(100),
    descripcion varchar(100),
    dosis_cant numeric(18,2),
    prec_espe numeric(18,2),
    cant_unidad numeric(12,3),
    total_val numeric(12,2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_recomendacion_deta PRIMARY KEY (codi_rec, codi_deta)
);

-- LIQUIDACION_RUTA
CREATE TABLE liquidacion_ruta (
    codi_liqu bigint NOT NULL,
    codi_deta integer NOT NULL,
    zona_part varchar(255),
    zona_lleg varchar(255),
    flete numeric(18,2),
    fecha_ini timestamp(3),
    fecha_fin timestamp(3),
    codi_clie_prov varchar(5),
    codi_orden_soli bigint,
    placa_tracto varchar(5),
    placa_carreta varchar(5),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_liquidacion_ruta PRIMARY KEY (codi_liqu, codi_deta)
);

-- LIQUIDACION_DETA
CREATE TABLE liquidacion_deta (
    codi_liqu bigint NOT NULL,
    codi_deta integer NOT NULL,
    fecha timestamp(3),
    detalle varchar(150),
    f varchar(1),
    importe numeric(12,3),
    codi_tipo_docu varchar(4),
    serie varchar(10),
    nro_docu varchar(20),
    tipo_contab varchar(3),
    codi_clie_prov varchar(5),
    estado varchar(1),
    nro_recibo varchar(10),
    codi_ruta varchar(5),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_liquidacion_deta PRIMARY KEY (codi_liqu, codi_deta)
);

-- LIQUIDACION
CREATE TABLE liquidacion (
    codi_liqu bigint NOT NULL,
    serie varchar(5),
    nro varchar(10),
    codi_trans varchar(5),
    gastos numeric(12,3),
    flete numeric(12,3),
    zona_part varchar(150),
    zona_dest varchar(150),
    mercaderia varchar(150),
    placa_tracto varchar(5),
    placa_carreta varchar(5),
    fecha_sal timestamp(3),
    fecha_lleg timestamp(3),
    codi_clie_prov varchar(5),
    nro_recibo varchar(10),
    total numeric(12,3),
    rendir varchar(1),
    combustible numeric(12,3),
    costo_comb numeric(12,3),
    saldo numeric(12,3),
    codi_orden_soli bigint,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_liquidacion PRIMARY KEY (codi_liqu)
);

-- NOTA_VENTA_DETALLE
CREATE TABLE nota_venta_detalle (
    codi_nota_venta bigint NOT NULL,
    id_sec bigint NOT NULL,
    codi_prod varchar(8),
    cantidad numeric(18,4),
    prec_item numeric(12,4),
    prec_lista numeric(19,4),
    dscto_prec numeric(19,4),
    dscto_item numeric(19,4),
    impo_item numeric(12,3),
    igv numeric(18,3),
    codi_alma varchar(2),
    codi_imp integer,
    desc_item varchar(150),
    prec_costo numeric(19,4),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_nota_venta_detalle PRIMARY KEY (codi_nota_venta, id_sec)
);

-- NOTA_VENTA
CREATE TABLE nota_venta (
    codi_nota_venta bigint NOT NULL,
    codi_alma varchar(2),
    nro_nota_venta bigint,
    codi_clie_prov varchar(5),
    fecha timestamp(3),
    codi_mone varchar(2),
    tcambio numeric(19,4),
    creacion timestamp(3),
    codi_tipo_pago integer,
    tipo_credito smallint,
    codi_usua varchar(5),
    cod_imp integer,
    cod_siembra bigint,
    cod_cultivo integer,
    cod_zona bigint,
    cod_usua_recetista varchar(5),
    hectarea numeric(18,3),
    nro_dias integer,
    fec_pago timestamp(3),
    venc_fact timestamp(3),
    codi_fact varchar(10),
    valor_igv numeric(12,2),
    valo_fact numeric(12,3),
    subtota_fact numeric(19,4),
    igv_fact numeric(12,3),
    tota_exonerado numeric(19,4),
    tota_fact numeric(12,3),
    estado varchar(1),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_nota_venta PRIMARY KEY (codi_nota_venta)
);

-- CONOCIMIENTO
CREATE TABLE conocimiento (
    codi_con_mer bigint NOT NULL,
    fecha timestamp(3),
    codi_alma varchar(2),
    cultivo varchar(150),
    variedad varchar(150),
    epoca varchar(2),
    periodo numeric(18,2),
    zona varchar(150),
    sector varchar(150),
    area varchar(150),
    rendimiento numeric(18,2),
    precio numeric(18,2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_conocimiento PRIMARY KEY (codi_con_mer)
);

-- CONFIGURACION_VEHICULAR
CREATE TABLE configuracion_vehicular (
    id_conf integer NOT NULL,
    desc_conf varchar(50),
    carga_util numeric(18,3),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_configuracion_vehicular PRIMARY KEY (id_conf)
);

-- HOJA_VIDA_DETA
CREATE TABLE hoja_vida_deta (
    codi_hoja bigint NOT NULL,
    codi_deta integer NOT NULL,
    diagnostico varchar(150),
    recomendacion varchar(150),
    dosis numeric(18,3),
    gasto numeric(18,3),
    gasto_agro numeric(18,3),
    gasto_total numeric(18,3),
    etapa varchar(50),
    fecha_prog timestamp(3),
    fecha_vis timestamp(3),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_hoja_vida_deta PRIMARY KEY (codi_hoja, codi_deta)
);

-- HOJA_VIDA
CREATE TABLE hoja_vida (
    codi_hoja bigint NOT NULL,
    grupo varchar(250),
    razon varchar(250),
    ruc varchar(11),
    email_emp varchar(100),
    email_logi varchar(100),
    email_ventas varchar(100),
    email_tecni varchar(100),
    direccion varchar(100),
    localidad varchar(100),
    provincia varchar(100),
    departamento varchar(100),
    telef varchar(15),
    celular varchar(15),
    cobertura varchar(150),
    ape_1 varchar(100),
    ape_2 varchar(100),
    nombres varchar(150),
    codigo varchar(20),
    cargo varchar(100),
    propietario varchar(100),
    arrendatario varchar(100),
    jefe_campo varchar(100),
    logistica varchar(100),
    zona_pers varchar(100),
    prov_pers varchar(100),
    dist_pers varchar(100),
    depa_pers varchar(100),
    email varchar(100),
    fech_nac timestamp(3),
    dni varchar(8),
    telef_pers varchar(15),
    estado_civ varchar(20),
    celular_pers varchar(15),
    grado varchar(100),
    familia varchar(100),
    especie varchar(100),
    variedad varchar(100),
    siembra varchar(100),
    surco numeric(18,3),
    golpe numeric(18,3),
    surco_2 numeric(18,3),
    area numeric(18,3),
    semilla varchar(50),
    nro_semilla numeric(18,3),
    densidad numeric(18,3),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_hoja_vida PRIMARY KEY (codi_hoja)
);

-- TIPO_NOTAS
CREATE TABLE tipo_notas (
    codi_tipo varchar(2) NOT NULL,
    descrip varchar(50) NOT NULL,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_tipo_notas PRIMARY KEY (codi_tipo)
);

-- ALMACEN_DOCUMENTOS
CREATE TABLE almacen_documentos (
    codi_alma varchar(2) NOT NULL,
    codi_tipo_docu varchar(4) NOT NULL,
    serie_alma varchar(5) NOT NULL,
    nro_docu_empieza bigint,
    nro_actual bigint,
    estado varchar(1),
    tipo_fact varchar(1),
    codi_cont_docu bigint,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_almacen_documentos PRIMARY KEY (codi_alma, codi_tipo_docu, serie_alma)
);

-- CLIENTE_VENDEDOR
CREATE TABLE cliente_vendedor (
    id_clie_vende bigint GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    codi_usua varchar(5),
    codi_clie_prov varchar(5),
    estado varchar(1),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_cliente_vendedor PRIMARY KEY (id_clie_vende)
);

-- MOTIVO_TRASLADO
CREATE TABLE motivo_traslado (
    codi_moti_tras varchar(2) NOT NULL,
    desc_moti_tras varchar(200),
    nemo_moti_tras varchar(30),
    codi_tipo_is varchar(2),
    codi_sunat_elec varchar(2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_motivo_traslado PRIMARY KEY (codi_moti_tras)
);

-- MOTIVO_NOTA_CRED
CREATE TABLE motivo_nota_cred (
    id_moti integer NOT NULL,
    desc_moti varchar(50),
    codi_sunat varchar(2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_motivo_nota_cred PRIMARY KEY (id_moti)
);

-- FACTURA_ANTICIPOS
CREATE TABLE factura_anticipos (
    codi_fact varchar(10) NOT NULL,
    id_sec integer NOT NULL,
    codi_tipo_docu varchar(4),
    serie varchar(10),
    numero varchar(20),
    fecha_pago_rece timestamp(3),
    fecha_pago_efec timestamp(3),
    monto_anti numeric(18,2),
    descripcion varchar(200),
    hora_pago timestamp(3),
    precio numeric(12,2),
    codi_fact_anti varchar(10),
    codi_mone varchar(2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_factura_anticipos PRIMARY KEY (codi_fact, id_sec)
);

-- PLAN_MARKETING
CREATE TABLE plan_marketing (
    codi_plan bigint NOT NULL,
    codi_alma varchar(2),
    mes varchar(2),
    sem1 varchar(8),
    sem2 varchar(8),
    sem3 varchar(8),
    sem4 varchar(8),
    codi_usua varchar(5),
    registro varchar(150),
    fecha timestamp(3),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_plan_marketing PRIMARY KEY (codi_plan)
);

-- TIPO_COMISION  (sin PK en el legado: se agrega clave sustituta)
CREATE TABLE tipo_comision (
    id bigint GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    id_tipocomi integer,
    desc_tipocomi varchar(50),
    porcentaje numeric(18,2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_tipo_comision PRIMARY KEY (id)
);

-- TIPO_CARGA
CREATE TABLE tipo_carga (
    codi_carga varchar(4) NOT NULL,
    descripcion varchar(150),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_tipo_carga PRIMARY KEY (codi_carga)
);

-- CLIENTE_CREDITO_HISTORIAL
CREATE TABLE cliente_credito_historial (
    codi_credito bigint NOT NULL,
    codi_deta bigint NOT NULL,
    fecha timestamp(3),
    decripcion varchar(255),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_cliente_credito_historial PRIMARY KEY (codi_credito, codi_deta)
);

-- CAPTACION_VISITA
CREATE TABLE captacion_visita (
    codi_capta bigint NOT NULL,
    fecha timestamp(3),
    agricultor varchar(150),
    zona varchar(250),
    cultivo varchar(250),
    area varchar(250),
    etapa varchar(50),
    codi_rec bigint,
    codi_usua varchar(5),
    tipo varchar(1),
    codi_alma varchar(2),
    telefono varchar(15),
    e_mail varchar(50),
    siembra varchar(50),
    area_nro numeric(18,2),
    codi_cap bigint,
    codi_clie_prov varchar(5),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_captacion_visita PRIMARY KEY (codi_capta)
);

-- CAPTACION
CREATE TABLE captacion (
    codi_cap bigint NOT NULL,
    nro_doc varchar(15),
    cliente varchar(150),
    zona varchar(250),
    cultivo varchar(250),
    area varchar(250),
    etapa varchar(50),
    captado varchar(5),
    observaciones varchar(250),
    codi_usua varchar(5),
    fecha timestamp(3),
    tipo_pers varchar(12),
    codi_tipo_docu_iden smallint,
    apel_1 varchar(30),
    apel_2 varchar(30),
    nomb_1 varchar(30),
    nomb_2 varchar(30),
    denominacion varchar(100),
    codi_clie_prov varchar(5),
    codi_alma varchar(2),
    frecuencia varchar(2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_captacion PRIMARY KEY (codi_cap)
);

-- CREDITOS_TIPOS
CREATE TABLE creditos_tipos (
    codi_tipo_cred bigint NOT NULL,
    descripcion varchar(150),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_creditos_tipos PRIMARY KEY (codi_tipo_cred)
);

-- CREDITOS_LINEAS
CREATE TABLE creditos_lineas (
    codi_lin_cred bigint NOT NULL,
    descripcion varchar(150),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_creditos_lineas PRIMARY KEY (codi_lin_cred)
);

-- CREDITOS_DETALLE
CREATE TABLE creditos_detalle (
    codi_credito bigint NOT NULL,
    codi_deta bigint GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    fecha timestamp(3),
    codi_mone varchar(2),
    valor numeric(18,2),
    activo varchar(1),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_creditos_detalle PRIMARY KEY (codi_credito, codi_deta)
);

-- CREDITOS
CREATE TABLE creditos (
    codi_credito bigint NOT NULL,
    codi_clie_prov varchar(5) NOT NULL,
    fec_inic_cred timestamp(3) NOT NULL,
    codi_mone varchar(2) NOT NULL,
    monto_cred numeric(19,4) NOT NULL,
    fec_fin_cred timestamp(3),
    observa_cred varchar(100),
    codi_usua_autoriza varchar(5) NOT NULL,
    estado varchar(1),
    codi_usua_responsa varchar(5),
    tipo_cred varchar(1),
    codi_alma varchar(2),
    multi_credito varchar(1),
    tipo_pago bigint,
    doc_garantia varchar(1),
    interes numeric(18,2),
    igv numeric(18,2),
    gastos numeric(18,2),
    total numeric(18,2),
    codi_lin_cred bigint,
    codi_proy varchar(10),
    codi_clie_fav varchar(5),
    periodo varchar(2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_creditos PRIMARY KEY (codi_credito)
);

-- acta_entrega
CREATE TABLE acta_entrega (
    codi_act bigint NOT NULL,
    fecha timestamp(3),
    nro bigint,
    codi_alma varchar(2),
    codi_clie_prov varchar(5),
    estado varchar(1),
    persona_responsable varchar(200),
    dni varchar(15),
    domicilio varchar(200),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_acta_entrega PRIMARY KEY (codi_act)
);

-- RUTA_SEMANAL
CREATE TABLE ruta_semanal (
    codi_ruta bigint NOT NULL,
    zona varchar(150),
    cliente varchar(150),
    cultivo varchar(150),
    area varchar(150),
    etapa varchar(150),
    observacion varchar(150),
    codi_usua varchar(5),
    fecha timestamp(3),
    codi_alma varchar(2),
    zona_aux varchar(150),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_ruta_semanal PRIMARY KEY (codi_ruta)
);

-- RUTA_ORDEN
CREATE TABLE ruta_orden (
    codi_ruta varchar(5) NOT NULL,
    descripcion varchar(150),
    destino varchar(150),
    distancia numeric(18,2),
    origen varchar(150),
    codi_ori integer,
    codi_des integer,
    valor numeric(18,2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_ruta_orden PRIMARY KEY (codi_ruta)
);

-- RUTA
CREATE TABLE ruta (
    codi_ruta bigint NOT NULL,
    zona varchar(150),
    dia_l varchar(150),
    dia_m varchar(150),
    dia_mc varchar(150),
    dia_j varchar(150),
    dia_v varchar(150),
    dia_sa varchar(150),
    codi_usua varchar(5),
    fecha timestamp(3),
    fecha_sal timestamp(3),
    codi_alma varchar(2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_ruta PRIMARY KEY (codi_ruta)
);

-- ROTACION
CREATE TABLE rotacion (
    codi_rota bigint NOT NULL,
    codi_prod varchar(8),
    cantidad numeric(12,2),
    lote varchar(150),
    fecha timestamp(3),
    tipo varchar(1),
    codi_alma varchar(2),
    fecha_venc timestamp(3),
    observaciones varchar(255),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_rotacion PRIMARY KEY (codi_rota)
);

-- COMISIONES
CREATE TABLE comisiones (
    id_comi bigint GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    mes integer,
    anio integer,
    codi_alma varchar(2),
    codi_prod varchar(8),
    desc_prod varchar(200),
    desc_pres varchar(200),
    cantidad numeric(18,2),
    valor numeric(18,3),
    comision numeric(18,3),
    valor_comision numeric(18,3),
    codi_depen varchar(8),
    desc_depen varchar(200),
    desc_prese_depen varchar(200),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_comisiones PRIMARY KEY (id_comi)
);

-- METAS_LINEA_ROTA
CREATE TABLE metas_linea_rota (
    cod_lin_pro varchar(2) NOT NULL,
    codi_rota integer NOT NULL,
    meta1 numeric(18,2),
    meta2 numeric(18,2),
    meta3 numeric(18,2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_metas_linea_rota PRIMARY KEY (cod_lin_pro, codi_rota)
);

-- RECOMENDACION
CREATE TABLE recomendacion (
    codi_rec bigint NOT NULL,
    diagnostico varchar(250),
    recomendacion varchar(250),
    nro_rec bigint,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_recomendacion PRIMARY KEY (codi_rec)
);

-- FACTURA_CUOTAS
CREATE TABLE factura_cuotas (
    codi_fact varchar(10) NOT NULL,
    id_sec integer NOT NULL,
    fecha timestamp(3),
    monto numeric(18,2),
    fecha_nc timestamp(3),
    monto_nc numeric(18,2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_factura_cuotas PRIMARY KEY (codi_fact, id_sec)
);

-- Producto_Comision
CREATE TABLE producto_comision (
    id_comi_prod bigint GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    codi_prod varchar(8),
    desc_prod varchar(200),
    comision numeric(18,2),
    inicio numeric(18,2),
    fin numeric(18,2),
    codi_depen varchar(8),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_producto_comision PRIMARY KEY (id_comi_prod)
);

-- BAZAR
CREATE TABLE bazar (
    codi_baza varchar(2) NOT NULL,
    nomb_baza varchar(100),
    mont_inte numeric(12,3),
    tipo_mont bigint,
    codi_clie_prov varchar(5),
    observacion varchar(200),
    codi_conc varchar(6),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_bazar PRIMARY KEY (codi_baza)
);

-- FACTURA_SUNAT  (sin PK en el legado: se agrega clave sustituta)
CREATE TABLE factura_sunat (
    id bigint GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    codi_fact varchar(10),
    estado integer,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_factura_sunat PRIMARY KEY (id)
);

-- NOTA_CREDITO
CREATE TABLE nota_credito (
    codi_nota_cred varchar(10) NOT NULL,
    ser_nota_cred varchar(5) NOT NULL,
    nro_nota_cred varchar(10) NOT NULL,
    codi_clie_prov varchar(5) NOT NULL,
    fech_nota_cred timestamp(3) NOT NULL,
    valo_vent numeric(12,3) NOT NULL,
    igv numeric(12,3) NOT NULL,
    prec_vent numeric(12,3) NOT NULL,
    codi_mone varchar(2) NOT NULL,
    observacion varchar(250),
    codi_unid_oper varchar(5),
    codi_sema varchar(8),
    codi_deta_zarp varchar(15),
    estado varchar(1),
    cuenta1 varchar(7),
    cuenta2 varchar(7),
    cuenta3 varchar(7),
    contabilizado varchar(1),
    codi_tipo varchar(2),
    razon_social varchar(150),
    direccion varchar(150),
    ruc varchar(12),
    codi_vouc varchar(10),
    exonerado varchar(1),
    codi_fact varchar(10),
    codi_alma varchar(2),
    id_moti integer,
    moti_otro varchar(50),
    tipo_oper varchar(4),
    fecha_elim timestamp(3),
    motivo_elim varchar(100),
    tipo_impr varchar(1),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_nota_credito PRIMARY KEY (codi_nota_cred)
);

-- CLIENTE_CREDITOS_GARANTIA
CREATE TABLE cliente_creditos_garantia (
    codi_credito bigint NOT NULL,
    doc_garantia varchar(2) NOT NULL,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_cliente_creditos_garantia PRIMARY KEY (codi_credito, doc_garantia)
);

-- ORDEN_SOLICITUD_SERVICIO_DETA
CREATE TABLE orden_solicitud_servicio_deta (
    codi_orden_soli bigint NOT NULL,
    codi_deta bigint NOT NULL,
    codi_tracto varchar(5),
    codi_carreta varchar(5),
    codi_trans varchar(4),
    codi_carga varchar(4),
    cantidad numeric(18,2),
    codi_unid_medi varchar(2),
    precio numeric(18,2),
    estado varchar(1),
    observacion varchar(150),
    importe numeric(18,2),
    id_guia bigint,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_orden_solicitud_servicio_deta PRIMARY KEY (codi_orden_soli, codi_deta)
);

-- ORDEN_SOLICITUD_SERVICIO
CREATE TABLE orden_solicitud_servicio (
    codi_orden_soli bigint NOT NULL,
    nro_orden_soli bigint,
    codi_clie_prov varchar(5),
    codi_ruta varchar(5),
    contacto varchar(150),
    telefono varchar(20),
    fecha timestamp(3),
    condicion varchar(1),
    codi_aux bigint,
    facturado varchar(1),
    responsable varchar(5),
    flete numeric(18,2),
    igv numeric(18,2),
    codi_mone varchar(2),
    tipo varchar(1),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_orden_solicitud_servicio PRIMARY KEY (codi_orden_soli)
);

-- REGISTRO_VALE
CREATE TABLE registro_vale (
    codi_vale bigint NOT NULL,
    codi_alma varchar(2),
    nro_vale bigint,
    codi_clie_prov varchar(5),
    fecha timestamp(3),
    codi_mone varchar(2),
    tcambio numeric(19,4),
    creacion timestamp(3) DEFAULT CURRENT_TIMESTAMP,
    codi_tipo_pago integer,
    tipo_credito smallint,
    codi_usua varchar(5),
    cod_imp integer,
    cod_siembra bigint,
    cod_cultivo integer,
    cod_zona bigint,
    cod_usua_recetista varchar(5),
    hectarea numeric(18,3),
    nro_dias integer,
    fec_pago timestamp(3),
    venc_fact timestamp(3),
    codi_fact varchar(10),
    valor_igv numeric(12,2),
    valo_fact numeric(12,3),
    subtota_fact numeric(19,4),
    igv_fact numeric(12,3),
    tota_exonerado numeric(19,4),
    tota_fact numeric(12,3),
    estado varchar(1),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_registro_vale PRIMARY KEY (codi_vale)
);

-- vale_CREDITO
CREATE TABLE vale_credito (
    codi_vale bigint NOT NULL,
    codi_credito bigint NOT NULL,
    monto numeric(19,4) NOT NULL,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_vale_credito PRIMARY KEY (codi_vale, codi_credito)
);

-- UBICACION
CREATE TABLE ubicacion (
    codi_ubi bigint NOT NULL,
    codi_alma varchar(2),
    zona varchar(150),
    sector varchar(250),
    subsector varchar(250),
    fecha timestamp(3),
    codi_usua varchar(5),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_ubicacion PRIMARY KEY (codi_ubi)
);

-- COTIZACION
CREATE TABLE cotizacion (
    codi_coti bigint NOT NULL,
    nro_cotiza bigint,
    fecha timestamp(3),
    codi_alma varchar(2),
    codi_clie_prov varchar(5),
    lugar_ent varchar(250),
    tiempo_ent varchar(250),
    observaciones varchar(250),
    fecha_venc timestamp(3),
    forma_pago varchar(2),
    fact_dias integer,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_cotizacion PRIMARY KEY (codi_coti)
);

-- NOTA_DEBITO
CREATE TABLE nota_debito (
    codi_nota_debi varchar(10) NOT NULL,
    ser_nota_debi varchar(5) NOT NULL,
    nro_nota_debi varchar(10) NOT NULL,
    codi_clie_prov varchar(5) NOT NULL,
    fech_nota_debi timestamp(3) NOT NULL,
    valo_vent numeric(12,3) NOT NULL,
    igv numeric(12,3) NOT NULL,
    prec_vent numeric(12,3) NOT NULL,
    codi_mone varchar(2) NOT NULL,
    observacion1 varchar(200),
    observacion2 varchar(200),
    codi_unid_oper varchar(5),
    codi_sema varchar(8),
    codi_deta_zarp varchar(15),
    estado varchar(1),
    cuenta1 varchar(7),
    cuenta2 varchar(7),
    cuenta3 varchar(7),
    contabilizado varchar(1),
    codi_tipo varchar(2),
    razon_social varchar(150),
    direccion varchar(150),
    ruc varchar(12),
    codi_vouc varchar(10),
    exonerado varchar(1),
    codi_alma varchar(2),
    codi_fact varchar(10),
    tipo_oper varchar(4),
    fecha_elim timestamp(3),
    motivo_elim varchar(100),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_nota_debito PRIMARY KEY (codi_nota_debi)
);

-- CUOTAS_SUCURSAL
CREATE TABLE cuotas_sucursal (
    anio integer NOT NULL,
    mes integer NOT NULL,
    codi_alma varchar(2) NOT NULL,
    monto numeric(18,2),
    cod_lin_pro varchar(2) NOT NULL,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_cuotas_sucursal PRIMARY KEY (anio, mes, codi_alma, cod_lin_pro)
);

-- CULTIVOS_PRINCIPAL
CREATE TABLE cultivos_principal (
    codi_culti bigint NOT NULL,
    cultivo varchar(150),
    periodo varchar(150),
    epoca varchar(150),
    zona varchar(250),
    rendimiento numeric(18,3),
    porc_parti numeric(18,3),
    codi_usua varchar(5),
    fecha timestamp(3),
    nro_peri numeric(18,3),
    codi_alma varchar(2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_cultivos_principal PRIMARY KEY (codi_culti)
);

-- GUIA_TRANSPORTISTA
CREATE TABLE guia_transportista (
    id_guia bigint NOT NULL,
    serie varchar(5),
    numero bigint,
    fecha timestamp(3),
    fecha_inic_tras timestamp(3),
    via_tipo_part varchar(50),
    via_nomb_part varchar(150),
    nro_part varchar(50),
    interior_part varchar(50),
    zona_part varchar(150),
    dist_part smallint,
    prov_part smallint,
    depa_part smallint,
    via_tipo_dest varchar(50),
    via_nomb_dest varchar(150),
    nro_dest varchar(50),
    interior_dest varchar(50),
    zona_dest varchar(150),
    dist_dest smallint,
    prov_dest smallint,
    depa_dest smallint,
    codi_clie_remi varchar(5),
    codi_clie_dest varchar(5),
    codi_clie_subc varchar(5),
    marca_vehi varchar(50),
    codi_unid_vehi varchar(5),
    codi_unid_carr varchar(10),
    codi_trans varchar(4),
    observaciones varchar(250),
    orden_despa varchar(50),
    orden_venta varchar(50),
    guia_remitente varchar(50),
    codi_fact varchar(10),
    estado varchar(1),
    codi_orden_soli bigint,
    codi_deta bigint,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_guia_transportista PRIMARY KEY (id_guia)
);

-- GUIA
CREATE TABLE guia (
    codi_guia bigint NOT NULL,
    ser_guia varchar(4),
    nro_guia integer NOT NULL,
    fech_tras timestamp(3),
    punto_partida varchar(150),
    e_p varchar(250),
    orde_compr varchar(50),
    codi_clie_dest varchar(5),
    punto_llegada varchar(150),
    codi_trans varchar(5),
    placa_vehi varchar(50),
    codi_moti_tras varchar(2),
    otros_obs varchar(150),
    codi_fact varchar(10),
    marca_placa varchar(50),
    nro_licencia varchar(50),
    peso_total numeric(18,3),
    codi_mone varchar(2),
    sub_total numeric(18,2),
    igv_venta numeric(18,2),
    total_venta numeric(18,2),
    codi_docu_sali varchar(10),
    codi_alma varchar(2),
    codi_alma_desti varchar(2),
    estado varchar(1),
    codi_unid_vehi varchar(5),
    codi_chof varchar(4),
    ruc_dni varchar(15),
    codi_orden_pedi bigint,
    fecha timestamp(3),
    nom_terc varchar(100),
    const_ins varchar(50),
    observaciones varchar(255),
    apro_por varchar(5),
    creacion timestamp(3),
    envio varchar(1),
    tipo_gene varchar(1),
    dist_part integer,
    dist_dest integer,
    codi_unid_medi_peso varchar(2),
    tipo_traslado varchar(2),
    codi_clie_comp varchar(5),
    codi_nota_ingre varchar(10),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_guia PRIMARY KEY (codi_guia)
);

-- Unidad_transporte
CREATE TABLE unidad_transporte (
    codi_unid_tran varchar(4) NOT NULL,
    desc_unid_tran varchar(100),
    marc_unid_tran varchar(20),
    plac_unid_tran varchar(10),
    cert_unid_tran varchar(12),
    colo_unid_tran varchar(10),
    lice_unid_trans varchar(20),
    mot_unid_tran varchar(20),
    anio_unid_tran varchar(4),
    cod_tran_unid_tran varchar(10),
    codi_tipo varchar(1),
    nro_plac_remo varchar(20),
    apel_1_chof varchar(30),
    apel_2_chof varchar(30),
    nomb_1_chof varchar(30),
    nomb_2_chof varchar(30),
    lice_cond_chof varchar(20),
    dni_chof varchar(20),
    inte_exte varchar(1),
    codi_unid_oper varchar(5),
    capacidad numeric(18,2),
    id_conf integer,
    codi_carreta varchar(5),
    codi_trans varchar(4),
    codi_tracto varchar(5),
    tipo_unidad varchar(50),
    permiso varchar(1),
    soat_ini timestamp(3),
    soat_fin timestamp(3),
    codi_prop varchar(5),
    codi_alma varchar(2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_unidad_transporte PRIMARY KEY (codi_unid_tran)
);

-- convenio
CREATE TABLE convenio (
    codi_conv bigint NOT NULL,
    codi_fact varchar(10),
    fecha timestamp(3),
    nro bigint,
    codi_alma varchar(2),
    codi_clie_prov varchar(5),
    codi_mone varchar(2),
    estado varchar(1),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_convenio PRIMARY KEY (codi_conv)
);

-- REGISTRO_VALE_DETALLE
CREATE TABLE registro_vale_detalle (
    codi_vale bigint NOT NULL,
    id_sec bigint NOT NULL,
    codi_prod varchar(8),
    cantidad numeric(18,4),
    prec_item numeric(12,4),
    prec_lista numeric(19,4),
    dscto_prec numeric(19,4),
    dscto_item numeric(19,4),
    impo_item numeric(12,3),
    igv numeric(18,3),
    codi_alma varchar(2),
    codi_imp integer,
    desc_item varchar(150),
    prec_costo numeric(19,4),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_registro_vale_detalle PRIMARY KEY (codi_vale, id_sec)
);

-- GUIA_TRANSPORTISTA_DETALLE
CREATE TABLE guia_transportista_detalle (
    id_guia bigint NOT NULL,
    item integer NOT NULL,
    codi_prod varchar(8),
    descripcion varchar(200),
    cantidad numeric(18,3),
    peso numeric(18,3),
    codi_unid_medi varchar(2),
    costo_minimo numeric(18,4),
    precio numeric(18,3),
    total numeric(18,3),
    codi_deta_oss bigint,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_guia_transportista_detalle PRIMARY KEY (id_guia, item)
);

-- GUIA_DETALLE
CREATE TABLE guia_detalle (
    codi_guia bigint NOT NULL,
    item_guia integer NOT NULL,
    codi_prod varchar(8),
    cantidad numeric(18,4),
    codi_unid_medi varchar(2),
    descripcion varchar(100),
    prec_unit numeric(18,4),
    valor_venta numeric(18,4),
    descuento numeric(12,2),
    prec_venta numeric(12,4),
    peso_total numeric(12,2),
    observaciones varchar(150),
    doc varchar(5),
    ser varchar(5),
    nro varchar(10),
    prec_compra numeric(18,4),
    codi_deta_orde_pedi varchar(12),
    prec_venta_real numeric(12,4),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_guia_detalle PRIMARY KEY (codi_guia, item_guia)
);

-- NOTA_DEBITO_DETA
CREATE TABLE nota_debito_deta (
    codi_nota_debi varchar(10) NOT NULL,
    codi_deta varchar(3) NOT NULL,
    desc_item text,
    cant_item numeric(12,3),
    prec_item numeric(12,3),
    impo_item numeric(12,3),
    codi_unid_medi varchar(2),
    codi_item varchar(10),
    igv numeric(18,2),
    codi_deta_fact varchar(3),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_nota_debito_deta PRIMARY KEY (codi_nota_debi, codi_deta)
);

-- convenio_detalle
CREATE TABLE convenio_detalle (
    codi_conv bigint NOT NULL,
    fecha timestamp(3) NOT NULL,
    codi_prod varchar(8) NOT NULL,
    cantidad numeric(12,3),
    descripcion varchar(150),
    item integer,
    estado integer,
    saldo numeric(12,3),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_convenio_detalle PRIMARY KEY (codi_conv, fecha, codi_prod)
);

-- NOTA_CREDITO_DETA
CREATE TABLE nota_credito_deta (
    codi_nota_cred varchar(10) NOT NULL,
    codi_deta varchar(3) NOT NULL,
    desc_item text,
    codi_unid_medi varchar(2),
    cant_item numeric(12,3),
    prec_item numeric(12,3),
    impo_item numeric(12,3),
    codi_item varchar(10),
    igv numeric(18,2),
    codi_deta_fact varchar(3),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_nota_credito_deta PRIMARY KEY (codi_nota_cred, codi_deta)
);

-- BOLETAS  (sin PK en el legado: se agrega clave sustituta)
CREATE TABLE boletas (
    id bigint GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    codi_bole varchar(10) NOT NULL,
    serie varchar(3) NOT NULL,
    numero varchar(6) NOT NULL,
    codi_clie_prov varchar(5) NOT NULL,
    fecha timestamp(3) NOT NULL,
    monto numeric(12,2),
    tipo varchar(2),
    codi_mone varchar(2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_boletas PRIMARY KEY (id)
);

-- acta_entrega_detalle
CREATE TABLE acta_entrega_detalle (
    codi_act bigint NOT NULL,
    codi_prod varchar(8) NOT NULL,
    cantidad numeric(12,3),
    descripcion varchar(150),
    item integer NOT NULL,
    codi_conv bigint,
    item_conv integer,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_acta_entrega_detalle PRIMARY KEY (codi_act, codi_prod, item)
);

-- FACTURA_PESCA  (sin PK en el legado: se agrega clave sustituta)
CREATE TABLE factura_pesca (
    id bigint GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    codi_fact_pesc varchar(10) NOT NULL,
    codi_clie_prov varchar(5) NOT NULL,
    fech_emis timestamp(3) NOT NULL,
    valo_vent numeric(12,3) NOT NULL,
    igv numeric(12,3) NOT NULL,
    valo_tota numeric(12,3) NOT NULL,
    codi_mone varchar(2),
    ser_fact varchar(3),
    nro_fact varchar(10),
    tipo_fact varchar(2),
    codi_unid_oper varchar(5),
    detr_tota numeric(12,3),
    codi_sema varchar(8),
    porc_detr numeric(12,3),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_factura_pesca PRIMARY KEY (id)
);

-- FACTURAS
CREATE TABLE facturas (
    codi_fact integer NOT NULL,
    serie_fact smallint NOT NULL,
    nro_fact integer NOT NULL,
    fecha_fact timestamp(0) NOT NULL,
    tipo_pers varchar(1),
    codi_clie varchar(5) NOT NULL,
    id_clie_natu_f integer,
    valorventa numeric(18,2) NOT NULL,
    igv numeric(18,2) NOT NULL,
    total numeric(18,2) NOT NULL,
    estado varchar(1) NOT NULL,
    codi_usua varchar(5) NOT NULL,
    observaciones varchar(200),
    exonerado smallint NOT NULL,
    codi_mone varchar(2) NOT NULL,
    codi_tipo_docu varchar(4),
    tipo_cambio numeric(18,4) DEFAULT 0.0000,
    entrega smallint,
    tipo smallint,
    nro_oc_clie varchar(25),
    impreso smallint NOT NULL,
    cliente varchar(75),
    direccion varchar(75),
    nro_docu varchar(20),
    serv_prod varchar(1),
    cancelada smallint DEFAULT 0,
    provisionada smallint DEFAULT 0,
    codi_vouc varchar(10),
    fechareg timestamp(3) DEFAULT CURRENT_TIMESTAMP,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_facturas PRIMARY KEY (codi_fact)
);

-- SIEMBRAS
CREATE TABLE siembras (
    codi_siembra bigint NOT NULL,
    codi_clie_prov varchar(5),
    fec_siembra timestamp(3),
    fec_estima_termi timestamp(3),
    fec_termino timestamp(3),
    nro_hecta numeric(18,2),
    cod_cultivo integer,
    cod_zona bigint,
    ubicacion varchar(100),
    observa varchar(100),
    terreno varchar(50),
    textsuelo varchar(100),
    triego varchar(50),
    cvecinos varchar(255),
    credsoc boolean,
    expcult numeric(18,2),
    asestecn varchar(50),
    edadcult numeric(18,2),
    relacomerc varchar(150),
    prodhect numeric(18,2),
    preccult numeric(18,4),
    utilbruta numeric(18,2),
    utilneta numeric(18,2),
    gastos numeric(18,2),
    comprador varchar(150),
    codi_mone varchar(2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_siembras PRIMARY KEY (codi_siembra)
);

-- BOLETAS_DETALLE
CREATE TABLE boletas_detalle (
    codi_bole varchar(10) NOT NULL,
    codi_deta varchar(3) NOT NULL,
    codi_item varchar(10),
    descripcion text,
    cant_item numeric(12,2),
    precio numeric(12,2),
    total numeric(12,2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_boletas_detalle PRIMARY KEY (codi_bole, codi_deta)
);

-- FACTURAS_DETALLE
CREATE TABLE facturas_detalle (
    codi_fact integer NOT NULL,
    item_fact smallint NOT NULL,
    codi_prod_serv varchar(8),
    descripcion varchar(150),
    cantidad numeric(18,2),
    codi_unid_medi varchar(2),
    prec_inc_igv numeric(18,8),
    prec_unit numeric(18,8),
    subtotal numeric(18,4),
    origen smallint,
    estado varchar(1) NOT NULL,
    codi_orde_produc integer,
    codi_guia integer,
    item_guia smallint,
    detalle varchar(1000),
    detalle2 varchar(250),
    detalle3 varchar(250),
    detalle4 varchar(250),
    detadescrip varchar(1000),
    descripcion_item varchar(1000) NOT NULL,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_facturas_detalle PRIMARY KEY (codi_fact, item_fact)
);

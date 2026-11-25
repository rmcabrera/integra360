-- Generado por tools/db-migrator a partir del script SQL Server legado. No editar a mano:
-- los cambios evolutivos van en migraciones nuevas (V100__..., V101__...).
-- Servicio: ms-logistica (Logistica, Almacen y Compras)
-- Tablas: 80

-- ALMACEN
CREATE TABLE almacen (
    codi_alma varchar(2) NOT NULL,
    desc_alma varchar(100),
    direccion varchar(100),
    telefono varchar(50),
    nemo_alma varchar(20),
    ubicacion varchar(50),
    tipo varchar(1),
    codi_luga varchar(3),
    codi_clie_prov varchar(5),
    codi_alma_princi varchar(2),
    codi_unid_oper varchar(5),
    nro_cuen varchar(7),
    representante varchar(5),
    nro_cuen_d varchar(7),
    distrito varchar(100),
    correo varchar(150),
    ruta varchar(255),
    impresora varchar(150),
    codi_alma_desc varchar(2),
    codigo_estable varchar(4),
    activo varchar(1),
    codigo_ubigeo varchar(6),
    dist_alma integer,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_almacen PRIMARY KEY (codi_alma)
);

-- NOTA_INGRESO
CREATE TABLE nota_ingreso (
    codi_nota_ingr varchar(10) NOT NULL,
    codi_clie_prov varchar(5),
    codi_tipo_docu varchar(4),
    nro_seri varchar(5),
    nro_docu varchar(15),
    codi_unid_oper_soli varchar(5),
    codi_unid_oper_dest varchar(5),
    fech_nota_ingr timestamp(3),
    tipo_nota_ingr varchar(20),
    importe numeric(12,4),
    codi_pers_vist_buen varchar(5),
    codi_pers_elab varchar(5),
    codi_mone varchar(2),
    prec_tota numeric(12,4),
    observaciones varchar(100),
    codi_turn varchar(2),
    codi_unid_nego varchar(2),
    nro_seri_docu_cont varchar(5),
    nro_docu_cont varchar(15),
    codi_tipo_docu_cont varchar(4),
    fech_guia_remi timestamp(3),
    fech_reg_fact timestamp(3),
    fech_proceso timestamp(3),
    contab boolean,
    tipo_camb numeric(15,4),
    afecto boolean,
    estado varchar(1),
    codi_sema varchar(8),
    prov_pesc varchar(5),
    viveres boolean,
    codi_emba varchar(5),
    nro_nota_ingr varchar(10),
    igv numeric(18,4),
    otro_afec numeric(18,4),
    otro_no_afec numeric(18,4),
    codi_alma varchar(2),
    codi_alma_desti varchar(2),
    codi_docu_sali varchar(10),
    codi_transportista varchar(5),
    registro varchar(10),
    fech_venc_fact timestamp(3),
    codi_chof varchar(4),
    codi_alma_dest varchar(2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_nota_ingreso PRIMARY KEY (codi_nota_ingr)
);

-- FAMILIA_PRODUCTO
CREATE TABLE familia_producto (
    codi_fami_prod varchar(2) NOT NULL,
    desc_fami_prod varchar(100),
    prod_serv varchar(1),
    nro_cuen varchar(7),
    cod_lin_pro varchar(2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_familia_producto PRIMARY KEY (codi_fami_prod)
);

-- SUB_FAMILIA_PRODUCTO
CREATE TABLE sub_familia_producto (
    codi_sub_fami_prod varchar(4) NOT NULL,
    desc_sub_fami_prod varchar(100),
    codi_fami_prod varchar(2),
    poli_prec_adic numeric(9,4) DEFAULT 0,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_sub_familia_producto PRIMARY KEY (codi_sub_fami_prod)
);

-- PRODUCTOS
CREATE TABLE productos (
    codi_prod varchar(8) NOT NULL,
    desc_prod varchar(150) NOT NULL,
    codi_sub_fami_prod varchar(4),
    codi_unid_medi varchar(2),
    codi_mone varchar(2),
    prec_prom numeric(14,2) DEFAULT 0,
    stock numeric(9,2) NOT NULL DEFAULT 0,
    stoc_mini numeric(9,2) DEFAULT 0,
    stoc_maxi numeric(9,2) DEFAULT 0,
    punt_repe numeric(9,2) DEFAULT 0,
    fech_venc timestamp(3),
    esta_prod varchar(25),
    stoc_temp numeric(9,2) DEFAULT 0,
    ubicacion varchar(50),
    nro_cuen varchar(7),
    iqf boolean,
    porc_detr numeric(15,4),
    poli_prec numeric(18,4),
    exonerado varchar(1),
    prec_list_1 numeric(15,4),
    prec_list_2 numeric(15,4),
    cost_prod numeric(15,4),
    analisis smallint,
    material smallint,
    codi_clie_prov varchar(5),
    cod_pres integer,
    fec_registro timestamp(3),
    prec_prov numeric(19,4),
    descto_compra numeric(19,4),
    descto_porcenta numeric(19,4),
    cod_impuesto integer,
    tcambio numeric(9,3),
    nro_decim_precio integer,
    costo_oper numeric(18,2),
    codi_aux varchar(8),
    id_tipocomi integer,
    codi_tipo_exis varchar(2),
    peso numeric(18,3),
    rotacion integer,
    codi_prod_sunat varchar(8),
    esta_acti varchar(1),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_productos PRIMARY KEY (codi_prod)
);

-- Almacen_Producto
CREATE TABLE almacen_producto (
    codi_alma varchar(2) NOT NULL,
    codi_prod varchar(8) NOT NULL,
    prec_costo numeric(18,3),
    stock_alma numeric(18,2),
    stock_min_alma numeric(18,2),
    stock_temp_alma numeric(18,2),
    prec_prom_alma numeric(18,3),
    prec_porc_uti_men numeric(18,2),
    prec_porc_uti_may numeric(18,2),
    prec_porc_uti_esp numeric(18,2),
    prec numeric(18,2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_almacen_producto PRIMARY KEY (codi_alma, codi_prod)
);

-- KARDEX
CREATE TABLE kardex (
    codi_kard varchar(20) NOT NULL,
    codi_prod varchar(8),
    codi_tipo_docu varchar(4),
    nro_seri varchar(5),
    nro_docu varchar(15),
    codi_unid_oper_soli varchar(5),
    codi_unid_oper_dest varchar(5),
    codi_cuen varchar(7),
    fech_tran timestamp(3),
    cant_ingr numeric(18,4),
    cant_sali numeric(18,4),
    cant_saldo numeric(18,4),
    cant_saldo_alma numeric(18,4),
    prec_unit numeric(12,4),
    prec_prom numeric(12,4),
    prec_prom_alma numeric(18,4),
    valo_ingr numeric(18,4),
    valo_sali numeric(18,4),
    valo_saldo numeric(18,4),
    valo_ingr_alma numeric(18,4),
    valo_sali_alma numeric(18,4),
    valo_saldo_alma numeric(18,4),
    codi_mone varchar(2),
    tipo_camb numeric(12,4),
    i_o varchar(1),
    codi_docu_i_o varchar(10),
    concepto varchar(250),
    nro_guia varchar(15),
    periodo integer,
    estado varchar(1),
    item varchar(12),
    codi_alma varchar(2),
    prodserviqf varchar(50),
    canti_prodserviqf numeric(18,4),
    um_prodserviqf varchar(2),
    deseiqf varchar(50),
    canti_deseiqf numeric(18,4),
    um_deseiqf varchar(2),
    canti_rhpm_iqf bigint,
    um_rhpm_iqf varchar(2),
    moti_rhpm_iqf varchar(50),
    creacion timestamp(3),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_kardex PRIMARY KEY (codi_kard)
);

-- LISTA_DE_REQUERIMIENTOS
CREATE TABLE lista_de_requerimientos (
    codi_list_requ varchar(8) NOT NULL,
    fech_list_requ timestamp(3) NOT NULL,
    codi_pers_resp varchar(5),
    estado varchar(1),
    codi_unid_oper_soli varchar(5),
    codi_unid_oper_dest varchar(5),
    pedi_trab varchar(1),
    motivo varchar(250),
    tipo_uso varchar(1),
    mant_acti varchar(1),
    observacion varchar(1500),
    observacion_2 varchar(200),
    observacion_3 varchar(200),
    observacion_4 varchar(200),
    observacion_5 varchar(200),
    prio smallint,
    codi_alma varchar(2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_lista_de_requerimientos PRIMARY KEY (codi_list_requ)
);

-- ORDEN_DE_PEDIDO
CREATE TABLE orden_de_pedido (
    codi_orde_pedi varchar(10) NOT NULL,
    fech_pedi timestamp(3) NOT NULL,
    estado varchar(1),
    codi_list_requ varchar(8),
    observacion varchar(250),
    observacion_2 varchar(200),
    observacion_3 varchar(200),
    observacion_4 varchar(200),
    observacion_5 varchar(200),
    nro_orde_pedi varchar(10),
    pedi_trab varchar(1),
    codi_pers_resp varchar(5),
    codi_unid_oper_soli varchar(5),
    codi_unid_oper_dest varchar(5),
    motivo varchar(250),
    tipo_uso varchar(1),
    mant_acti varchar(1),
    prio smallint,
    codi_alma varchar(2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_orden_de_pedido PRIMARY KEY (codi_orde_pedi)
);

-- DOCU_SALI_MATE
CREATE TABLE docu_sali_mate (
    codi_docu_sali varchar(10) NOT NULL,
    codi_unid_oper_rece varchar(5),
    codi_tipo_docu_sali varchar(4),
    codi_orde_pedi varchar(10),
    codi_pers_emis varchar(5),
    codi_pers_rece varchar(5),
    fech_emis timestamp(3) NOT NULL,
    codi_turn varchar(2),
    codi_unid_nego varchar(2),
    codi_clie_prov varchar(5),
    nro_seri_docu_sali varchar(5),
    nro_docu_sali varchar(10),
    motivo varchar(150),
    observacion varchar(150),
    tipo_sali varchar(20),
    tipo_dest varchar(2),
    codi_pers_reci_mate varchar(5),
    moti_sali varchar(10),
    codi_puer_sali varchar(2),
    estado varchar(1),
    viveres boolean,
    codi_emba varchar(5),
    codi_sema_pesc varchar(5),
    nro_sali varchar(10),
    kilometraje numeric(18,2) DEFAULT 0,
    kilo_mill numeric(18,2),
    codi_alma varchar(2),
    codi_alma_desti varchar(2),
    codi_fact varchar(10),
    condicion varchar(1),
    fech_reg_fact timestamp(3),
    codi_tipo_docu_cont varchar(4),
    nro_seri_docu_cont varchar(5),
    nro_docu_cont varchar(10),
    importe numeric(18,4),
    igv numeric(18,4),
    prec_tota numeric(18,4),
    contab integer,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_docu_sali_mate PRIMARY KEY (codi_docu_sali)
);

-- TIPO_INGR_SALI
CREATE TABLE tipo_ingr_sali (
    codi_tipo_is varchar(2) NOT NULL,
    desc_tipo_is varchar(100),
    nemo_tipo_is varchar(15),
    i_s varchar(1),
    codi_sunat_moti_tras varchar(2),
    desc_sunat_moti_tras varchar(50),
    contabilizar smallint,
    nro_cuen varchar(7),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_tipo_ingr_sali PRIMARY KEY (codi_tipo_is)
);

-- DETALLE_DOCU_SALI
CREATE TABLE detalle_docu_sali (
    codi_deta_docu_sali varchar(12) NOT NULL,
    codi_docu_sali varchar(10) NOT NULL,
    nro_cuen varchar(7),
    codi_prod varchar(8) NOT NULL,
    cantidad numeric(10,4),
    prec_costo numeric(18,4),
    prec_prom numeric(12,4),
    stoc_sali numeric(12,4),
    fech_ulti_sali timestamp(3),
    cant_ulti_sali numeric(12,4),
    codi_orde_pedi varchar(10),
    codi_unid_oper varchar(5),
    codi_alma varchar(2),
    codi_alma_desti varchar(2),
    codi_deta_orde_pedi varchar(12),
    prec_kard numeric(18,4),
    concen_iqf bigint,
    prodserviqf varchar(50),
    canti_prodserviqf bigint,
    um_prodserviqf varchar(2),
    deseiqf varchar(50),
    canti_deseiqf bigint,
    um_deseiqf varchar(2),
    canti_rhpm_iqf bigint,
    um_rhpm_iqf varchar(2),
    moti_rhpm_iqf varchar(50),
    observaciones varchar(50),
    prec_unit numeric(18,6),
    nro_cuen_ni varchar(7),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_detalle_docu_sali PRIMARY KEY (codi_deta_docu_sali)
);

-- LINEA_FAMILIA_PRO
CREATE TABLE linea_familia_pro (
    cod_lin_pro varchar(2) NOT NULL,
    des_lin_pro varchar(100),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_linea_familia_pro PRIMARY KEY (cod_lin_pro)
);

-- PRESENTACION
CREATE TABLE presentacion (
    cod_pres integer NOT NULL,
    desc_pres varchar(50),
    um varchar(2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_presentacion PRIMARY KEY (cod_pres)
);

-- DETALLE_NOTA_INGRESO
CREATE TABLE detalle_nota_ingreso (
    codi_nota_ingr varchar(10) NOT NULL,
    nro_item_nota_ingr varchar(12) NOT NULL,
    codi_prod varchar(8),
    cantidad numeric(18,4),
    codi_mone varchar(2),
    prec_unit numeric(18,4),
    codi_unid_oper varchar(5),
    nro_cuen varchar(7),
    prec_kard numeric(18,4),
    stoc_ulti numeric(15,4),
    stoc_temp_ulti numeric(15,4),
    prec_ulti numeric(18,4),
    porc_detr numeric(15,4),
    codi_deta_orde_comp varchar(12),
    codi_mone_ulti_prec varchar(2),
    codi_alma varchar(2),
    codi_deta_orde_pedi varchar(12),
    codi_tipo_enva smallint,
    num_enva smallint,
    exceso numeric(18,4),
    faltante numeric(18,4),
    observaciones varchar(50),
    concen_iqf numeric(18,2),
    dscto_porcentaje numeric(18,3),
    prec_compra numeric(18,4),
    tipo_compra varchar(1),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_detalle_nota_ingreso PRIMARY KEY (codi_nota_ingr, nro_item_nota_ingr)
);

-- KARDEX_ALMACENES
CREATE TABLE kardex_almacenes (
    codigo bigint,
    codi_transa bigint NOT NULL,
    codi_alma varchar(2) NOT NULL,
    item integer NOT NULL,
    codi_prod varchar(8) NOT NULL,
    i_o varchar(1) NOT NULL,
    cantidad numeric(18,4),
    precio numeric(18,4),
    total numeric(18,2),
    codi_unid_medi varchar(50),
    codi_mone varchar(2),
    tipo_cambio numeric(18,4),
    ingr_cant numeric(18,4),
    sali_cant numeric(18,4),
    prec_unit numeric(18,4),
    prec_prom numeric(18,4),
    stock numeric(18,4),
    ingr_valo numeric(18,4),
    egre_valo numeric(18,4),
    saldo_valo numeric(18,4),
    periodo integer,
    fecha timestamp(3),
    exonerado varchar(1),
    igv numeric(18,2),
    venta numeric(18,2),
    valorigv numeric(18,2),
    nro_cuen varchar(7),
    productor varchar(5),
    acidez numeric(18,3),
    cantcolpex numeric(18,4),
    entradafisico numeric(18,4),
    salidafisico numeric(18,4),
    promfisico numeric(18,4),
    stockfisico numeric(18,4),
    ingresofisico numeric(18,4),
    egresofisico numeric(18,4),
    saldofisico numeric(18,4),
    transporte varchar(4),
    placa varchar(10),
    ticket varchar(10),
    codi_tipo_docu varchar(4),
    serguia varchar(5),
    nroguia varchar(10),
    codi_moti_tras varchar(2),
    nro_vales bigint,
    indice_rela bigint,
    codi_tipo_enva smallint,
    num_enva smallint,
    exceso numeric(18,4),
    faltante numeric(18,4),
    observaciones varchar(50),
    concen_iqf numeric(18,2),
    prodserviqf varchar(50),
    canti_prodserviqf bigint,
    um_prodserviqf varchar(2),
    deseiqf varchar(50),
    canti_deseiqf bigint,
    um_deseiqf varchar(2),
    canti_rhpm_iqf bigint,
    um_rhpm_iqf varchar(2),
    moti_rhpm_iqf varchar(50),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_kardex_almacenes PRIMARY KEY (codi_transa, codi_alma, item, codi_prod, i_o)
);

-- REGISTRO_PRODUCTO_DETA
CREATE TABLE registro_producto_deta (
    codi_regi_prod bigint NOT NULL,
    codi_deta integer NOT NULL,
    codi_prod varchar(8),
    cantidad numeric(18,3),
    q1_1 numeric(18,3),
    q2_1 numeric(18,3),
    q1_2 numeric(18,3),
    q2_2 numeric(18,3),
    q1_3 numeric(18,3),
    q2_3 numeric(18,3),
    q1_4 numeric(18,3),
    q2_4 numeric(18,3),
    q1_5 numeric(18,3),
    q2_5 numeric(18,3),
    q1_6 numeric(18,3),
    q2_6 numeric(18,3),
    nro_diacult integer,
    cod_eta bigint,
    enfermedades varchar(150),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_registro_producto_deta PRIMARY KEY (codi_regi_prod, codi_deta)
);

-- REGISTRO_PRODUCTO
CREATE TABLE registro_producto (
    codi_regi_prod bigint NOT NULL,
    cultivo varchar(250),
    area varchar(250),
    codi_alma varchar(2),
    cod_zona bigint,
    cod_cultivo integer,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_registro_producto PRIMARY KEY (codi_regi_prod)
);

-- REGISTRO_ORDEN_PEDIDO_DETA
CREATE TABLE registro_orden_pedido_deta (
    codi_orden_pedi bigint NOT NULL,
    codi_deta integer NOT NULL,
    codi_prod varchar(8),
    cantidad numeric(18,3),
    cantidad_aux numeric(12,2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_registro_orden_pedido_deta PRIMARY KEY (codi_orden_pedi, codi_deta)
);

-- REGISTRO_ORDEN_PEDIDO
CREATE TABLE registro_orden_pedido (
    codi_orden_pedi bigint NOT NULL,
    codi_pers_resp varchar(5),
    codi_unid_oper_soli varchar(2),
    codi_unid_oper_dest varchar(2),
    motivo varchar(250),
    observacion text,
    codi_guia bigint,
    fecha timestamp(3),
    estado varchar(1),
    envio varchar(1),
    apro_por varchar(5),
    libe_por varchar(5),
    codi_alma_orig varchar(2),
    super_por varchar(5),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_registro_orden_pedido PRIMARY KEY (codi_orden_pedi)
);

-- TIPO_EXISTENCIA
CREATE TABLE tipo_existencia (
    codi_tipo_exis varchar(2) NOT NULL,
    codi_sunat varchar(2) NOT NULL,
    desc_tipo_exis varchar(100) NOT NULL,
    nemo varchar(30),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_tipo_existencia PRIMARY KEY (codi_tipo_exis)
);

-- TIPO_ENVASES
CREATE TABLE tipo_envases (
    codi_tipo_enva smallint NOT NULL,
    desc_emva varchar(50) NOT NULL,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_tipo_envases PRIMARY KEY (codi_tipo_enva)
);

-- DOCU_SALI_X_ORDE_PEDI
CREATE TABLE docu_sali_x_orde_pedi (
    codi_docu_sali varchar(10) NOT NULL,
    codi_orde_pedi varchar(10) NOT NULL,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_docu_sali_x_orde_pedi PRIMARY KEY (codi_docu_sali, codi_orde_pedi)
);

-- KITS
CREATE TABLE kits (
    codi_kit_inte varchar(4) NOT NULL,
    codi_kit_marc varchar(15) NOT NULL,
    desc_kit varchar(150),
    marc_kit varchar(50),
    abre_kit varchar(20),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_kits PRIMARY KEY (codi_kit_inte)
);

-- MATERIAL
CREATE TABLE material (
    codi_material integer NOT NULL,
    desc_material varchar(50) NOT NULL,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_material PRIMARY KEY (codi_material)
);

-- MARCA
CREATE TABLE marca (
    codi_marca varchar(4) NOT NULL,
    desc_marca varchar(50),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_marca PRIMARY KEY (codi_marca)
);

-- LOTE_SITUACION
CREATE TABLE lote_situacion (
    id_situ integer NOT NULL,
    descripcion varchar(100),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_lote_situacion PRIMARY KEY (id_situ)
);

-- ORDE_SERV_X_PROY
CREATE TABLE orde_serv_x_proy (
    codi_orde_comp varchar(10) NOT NULL,
    codi_proy varchar(10) NOT NULL,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_orde_serv_x_proy PRIMARY KEY (codi_orde_comp, codi_proy)
);

-- prec_prom_inve
CREATE TABLE prec_prom_inve (
    prod varchar(8) NOT NULL,
    precio numeric(15,4) NOT NULL,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_prec_prom_inve PRIMARY KEY (prod)
);

-- ALMACEN_DOC_REGULARIZAR
CREATE TABLE almacen_doc_regularizar (
    idd_sec bigint GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    codi_alma varchar(2) NOT NULL,
    codi_tipo_docu varchar(4) NOT NULL,
    serie_alma varchar(5) NOT NULL,
    nro_docu_empieza bigint,
    fecha timestamp(3),
    creacion timestamp(3),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_almacen_doc_regularizar PRIMARY KEY (idd_sec)
);

-- PRODUCTOS_EVENTOS
CREATE TABLE productos_eventos (
    codi_prod varchar(8) NOT NULL,
    codi_alma varchar(2) NOT NULL,
    fecha timestamp(3) NOT NULL,
    evento varchar(255),
    tipo varchar(1),
    hecho_por varchar(5),
    activo varchar(1),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_productos_eventos PRIMARY KEY (codi_prod, codi_alma, fecha)
);

-- PRODUCTOS_BAJA_ROTACION
CREATE TABLE productos_baja_rotacion (
    codi_rota bigint GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    descripcion varchar(150),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_productos_baja_rotacion PRIMARY KEY (codi_rota)
);

-- PRODUCTOS_BAJA
CREATE TABLE productos_baja (
    id_ven integer NOT NULL,
    codi_prod varchar(8) NOT NULL,
    codi_rota bigint,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_productos_baja PRIMARY KEY (id_ven, codi_prod)
);

-- PRODUCTOS_MATRIZ
CREATE TABLE productos_matriz (
    id_mat bigint GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    codi_prod varchar(8),
    codi_rota bigint,
    fecha timestamp(3),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_productos_matriz PRIMARY KEY (id_mat)
);

-- PRODUCTOS_LOTES_VALE_CRED
CREATE TABLE productos_lotes_vale_cred (
    codi_deta_ingre_sali varchar(12) NOT NULL,
    codi_prod_alma_lote bigint NOT NULL,
    cantidad numeric(18,2),
    codi_vale bigint NOT NULL,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_productos_lotes_vale_cred PRIMARY KEY (codi_deta_ingre_sali, codi_prod_alma_lote, codi_vale)
);

-- PRODUCTOS_LOTES_NOTA_VENTA
CREATE TABLE productos_lotes_nota_venta (
    codi_deta_ingre_sali varchar(12) NOT NULL,
    codi_prod_alma_lote bigint NOT NULL,
    cantidad numeric(18,2),
    codi_nota_venta bigint NOT NULL,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_productos_lotes_nota_venta PRIMARY KEY (codi_deta_ingre_sali, codi_prod_alma_lote, codi_nota_venta)
);

-- CCNU_SEGMENTOS
CREATE TABLE ccnu_segmentos (
    cod_seg varchar(2) NOT NULL,
    desc_seg varchar(250),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_ccnu_segmentos PRIMARY KEY (cod_seg)
);

-- CCNU_PRODUCTOS
CREATE TABLE ccnu_productos (
    codi_prod_sunat varchar(8) NOT NULL,
    codi_clas varchar(6) NOT NULL,
    desc_prod_sunat varchar(250),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_ccnu_productos PRIMARY KEY (codi_prod_sunat, codi_clas)
);

-- CCNU_FAMILIAS
CREATE TABLE ccnu_familias (
    codi_fami varchar(4) NOT NULL,
    cod_seg varchar(2) NOT NULL,
    desc_fami varchar(250),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_ccnu_familias PRIMARY KEY (codi_fami, cod_seg)
);

-- CCNU_CLASES
CREATE TABLE ccnu_clases (
    codi_clas varchar(6) NOT NULL,
    codi_fami varchar(4) NOT NULL,
    desc_clas varchar(250),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_ccnu_clases PRIMARY KEY (codi_clas, codi_fami)
);

-- ORDEN_DESPACHO_COMBUSTIBLE_DETA
CREATE TABLE orden_despacho_combustible_deta (
    codi_orden_des bigint NOT NULL,
    codi_deta bigint NOT NULL,
    codi_tracto varchar(5),
    codi_trans varchar(4),
    codi_prod varchar(8),
    cantidad numeric(18,2),
    precio numeric(18,2),
    importe numeric(18,2),
    valor numeric(18,2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_orden_despacho_combustible_deta PRIMARY KEY (codi_orden_des, codi_deta)
);

-- ORDEN_DESPACHO_COMBUSTIBLE
CREATE TABLE orden_despacho_combustible (
    codi_orden_des bigint NOT NULL,
    nro_orden_des bigint NOT NULL,
    codi_orden_soli bigint,
    tipo varchar(1),
    fecha timestamp(3),
    codi_mone varchar(2),
    codi_clie_prov varchar(5),
    elabora_por varchar(5),
    autoriza_por varchar(5),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_orden_despacho_combustible PRIMARY KEY (codi_orden_des, nro_orden_des)
);

-- COTIZACION_DETA
CREATE TABLE cotizacion_deta (
    codi_coti bigint NOT NULL,
    codi_deta integer NOT NULL,
    codi_prod varchar(8),
    cantidad numeric(18,3),
    stock numeric(18,3),
    p_unit numeric(18,3),
    total numeric(18,3),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_cotizacion_deta PRIMARY KEY (codi_coti, codi_deta)
);

-- COTIZACION_DE_PEDIDOS
CREATE TABLE cotizacion_de_pedidos (
    codi_coti varchar(10) NOT NULL,
    fech_coti timestamp(3),
    tiem_plaz_cred integer,
    codi_unid_medi varchar(2),
    estado varchar(1),
    codi_mone varchar(2),
    prec_tota_coti numeric(12,2),
    codi_orde_pedi varchar(10),
    codi_list_requ_orig varchar(8),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_cotizacion_de_pedidos PRIMARY KEY (codi_coti)
);

-- DETALLE_ORDEN_COMPRA_DISTRIBUCION
CREATE TABLE detalle_orden_compra_distribucion (
    codi_orde_comp varchar(10) NOT NULL,
    codi_prod varchar(8) NOT NULL,
    codi_alma varchar(2) NOT NULL,
    cantidad numeric(18,4),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_detalle_orden_compra_distribucion PRIMARY KEY (codi_orde_comp, codi_prod, codi_alma)
);

-- DETALLE_ORDEN_SERVICIO
CREATE TABLE detalle_orden_servicio (
    codi_deta_orde_comp varchar(12) NOT NULL,
    codi_orde_comp varchar(10) NOT NULL,
    codi_prod varchar(8) NOT NULL,
    desc_serv varchar(250),
    cantidad numeric(18,4),
    precio numeric(12,4),
    codi_mone varchar(2),
    nro_cuen varchar(7),
    tipo_desc boolean,
    descuento numeric(12,4),
    prec_orig numeric(12,4),
    codi_deta_orde_pedi varchar(12),
    codi_unid_medi varchar(2),
    codi_unid_oper varchar(5),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_detalle_orden_servicio PRIMARY KEY (codi_deta_orde_comp, codi_orde_comp)
);

-- ACABADO
CREATE TABLE acabado (
    codi_acab smallint NOT NULL,
    desc_acab varchar(100) NOT NULL,
    nemo_aca varchar(50),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_acabado PRIMARY KEY (codi_acab)
);

-- compromisos_pactados_deta
CREATE TABLE compromisos_pactados_deta (
    codi_comp bigint NOT NULL,
    codi_deta integer NOT NULL,
    codi_prod varchar(8),
    cantidad numeric(18,3),
    p_unit numeric(18,3),
    total numeric(18,3),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_compromisos_pactados_deta PRIMARY KEY (codi_comp, codi_deta)
);

-- compromisos_pactados
CREATE TABLE compromisos_pactados (
    codi_comp bigint NOT NULL,
    nro_comp bigint,
    fecha timestamp(3),
    codi_alma varchar(2),
    codi_clie_prov varchar(5),
    tipo varchar(1),
    observaciones varchar(250),
    fecha_venc timestamp(3),
    lugar varchar(50),
    codi_mone varchar(2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_compromisos_pactados PRIMARY KEY (codi_comp)
);

-- COLOR
CREATE TABLE color (
    codi_color smallint NOT NULL,
    desc_color varchar(100),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_color PRIMARY KEY (codi_color)
);

-- PRODUCTOS_SIN_VENTA
CREATE TABLE productos_sin_venta (
    fecha timestamp(3) NOT NULL,
    codi_prod varchar(8) NOT NULL,
    desc_prod varchar(150),
    codi_alma varchar(2),
    ultimaventa timestamp(3),
    plazo timestamp(3),
    diassinventa bigint,
    observaciones varchar(255),
    codi_usua varchar(5),
    creacion timestamp(3) DEFAULT CURRENT_TIMESTAMP,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_productos_sin_venta PRIMARY KEY (fecha, codi_prod)
);

-- PRODUCTOS_PRECIO
CREATE TABLE productos_precio (
    codi_item bigint GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    codi_deta_nota_ingr varchar(12),
    codi_prod varchar(8),
    precio numeric(18,4),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_productos_precio PRIMARY KEY (codi_item)
);

-- PROYECTO
CREATE TABLE proyecto (
    codi_proy varchar(10) NOT NULL,
    desc_proy varchar(100),
    fech_proy timestamp(3),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_proyecto PRIMARY KEY (codi_proy)
);

-- PRODUCTO_ALMACEN_LOTE_PEDIDO
CREATE TABLE producto_almacen_lote_pedido (
    id bigint GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    codi_prod_alma_lote bigint NOT NULL,
    codi_alma varchar(2) NOT NULL,
    codi_prod varchar(8) NOT NULL,
    lote varchar(30) NOT NULL,
    fec_vence timestamp(3),
    stock numeric(18,2),
    ubicacion varchar(50),
    condicion varchar(1),
    situacion integer,
    codi_orden_pedi integer,
    canti_salida_venta numeric(18,2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_producto_almacen_lote_pedido PRIMARY KEY (id)
);

-- VALE_SALIDA
CREATE TABLE vale_salida (
    codi_sali bigint NOT NULL,
    codi_alma varchar(2) NOT NULL,
    nro_vale bigint,
    fecha timestamp(3),
    codi_mone varchar(2),
    codi_tipo_docu varchar(4),
    serie varchar(3),
    numero varchar(10),
    codi_clie_prov varchar(5),
    codi_moti_tras varchar(2),
    tpc numeric(18,4),
    observacion varchar(250),
    codi_alma_dest varchar(2),
    codi_pers varchar(5),
    correlativo bigint,
    codi_orde bigint,
    anulado varchar(1),
    subt numeric(18,2),
    igv numeric(18,2),
    total numeric(18,2),
    transporte varchar(5),
    placa varchar(10),
    prov_dest varchar(5),
    chofer varchar(4),
    periodo varchar(4),
    indice_rela bigint,
    procedencia varchar(3),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_vale_salida PRIMARY KEY (codi_sali, codi_alma)
);

-- ORDEN_DE_COMPRA
CREATE TABLE orden_de_compra (
    codi_orde_comp varchar(10) NOT NULL,
    codi_clie_prov varchar(5) NOT NULL,
    fecha timestamp(3) NOT NULL,
    estado varchar(1),
    codi_mone varchar(2),
    importe numeric(18,4),
    codi_unid_oper_soli varchar(5),
    codi_unid_oper_dest varchar(5),
    cond_pago varchar(10),
    fech_entr timestamp(3),
    luga_entr varchar(100),
    codi_unid_medi varchar(2),
    tiem_plaz_cred bigint,
    atencion varchar(100),
    nro_coti varchar(20),
    tipo_desc boolean,
    descuento numeric(18,4) DEFAULT 0,
    sub_tota numeric(18,4) DEFAULT 0,
    codi_tipo_docu_cont varchar(4),
    igv numeric(18,4) DEFAULT 0,
    rent_cuar_cate numeric(18,4) DEFAULT 0,
    ies numeric(18,4) DEFAULT 0,
    total numeric(18,4) DEFAULT 0,
    pedi_trab varchar(1),
    detraccion boolean,
    tota_detr numeric(18,4),
    nro_orde_comp varchar(10),
    contab boolean,
    tipo_gene varchar(1),
    obse_1 varchar(255),
    obse_2 varchar(250),
    obse_3 varchar(250),
    obse_4 varchar(250),
    obse_5 varchar(250),
    obse_6 varchar(250),
    obse_7 varchar(250),
    obse_8 varchar(250),
    obse_9 varchar(250),
    obse_10 varchar(250),
    valo_vent boolean,
    nro_guia varchar(20),
    nro_fact varchar(20),
    afec_rete boolean,
    hech_por varchar(5),
    modi_por varchar(5),
    auto_por varchar(5),
    soli_por varchar(5),
    nro_pres varchar(50),
    desc_cond_pago varchar(100),
    nro_seri varchar(5),
    codi_alma varchar(2),
    otro_no_afec bigint,
    codi_bien_serv varchar(5),
    porc_detra numeric(12,2),
    apro_por varchar(5),
    codi_ofi bigint,
    anulado varchar(1),
    motivo varchar(255),
    fech_docu_cont timestamp(3),
    anio varchar(4),
    factor integer,
    nro_comp bigint,
    codi_trans varchar(4),
    dias integer,
    codi_luga varchar(2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_orden_de_compra PRIMARY KEY (codi_orde_comp)
);

-- NOTA_INGR_POR_ORDE_COMP
CREATE TABLE nota_ingr_por_orde_comp (
    codi_orde_comp varchar(10) NOT NULL,
    codi_nota_ingr varchar(10) NOT NULL,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_nota_ingr_por_orde_comp PRIMARY KEY (codi_orde_comp, codi_nota_ingr)
);

-- SALIDA_MATERIAL
CREATE TABLE salida_material (
    codi_docu_sali varchar(10) NOT NULL,
    nro_seri varchar(3),
    nro_docu_sali varchar(7),
    codi_tipo_docu varchar(4),
    fech_emis timestamp(3) NOT NULL,
    fech_inic_tras timestamp(3),
    codi_domi_part varchar(4),
    domi_part_dist varchar(30),
    domi_part_prov varchar(30),
    domi_part_depa varchar(30),
    domi_part_dire varchar(200),
    dest_codi_clie_prov varchar(5),
    dest_apel_o_razo_soci varchar(200),
    dest_dire varchar(200),
    dest_iden varchar(15),
    dest_tipo_docu_iden varchar(4),
    codi_domi_lleg varchar(4),
    domi_lleg_dist varchar(30),
    domi_lleg_prov varchar(30),
    domi_lleg_depa varchar(30),
    domi_lleg_dire varchar(200),
    codi_unid_tran varchar(4),
    codi_trans varchar(4),
    codi_tipo_docu_comp_pago varchar(4),
    comp_pago_seri varchar(5),
    comp_pago_nro varchar(15),
    codi_moti_tras varchar(2),
    moti_tras_desc varchar(200),
    codi_mone_cost varchar(2),
    cost_mini numeric(15,4),
    codi_unid_medi_peso varchar(4),
    peso_tota numeric(15,4),
    estado varchar(1),
    tipo_gene varchar(1),
    codi_pers_emit_guia varchar(5),
    codi_pers_reci_guia varchar(5),
    apel_1_reci_guia varchar(50),
    apel_2_reci_guia varchar(50),
    nomb_1_reci_guia varchar(50),
    nomb_2_reci_guia varchar(50),
    codi_unid_oper_rece varchar(5),
    observacion varchar(200),
    moti_sali varchar(200),
    apel_1_chof varchar(30),
    apel_2_chof varchar(30),
    nomb_1_chof varchar(30),
    nomb_2_chof varchar(30),
    lice_cond_chof varchar(20),
    dni_chof varchar(20),
    con_reto varchar(1),
    indi_reto varchar(1),
    indi_devo_mate_emba varchar(1),
    cimt varchar(20),
    codi_alma varchar(2),
    marca_transpo varchar(20),
    nro_placa_transpo varchar(20),
    empre_trans_razo_soci varchar(50),
    empre_trans_ruc varchar(15),
    empre_trans_domici varchar(50),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_salida_material PRIMARY KEY (codi_docu_sali)
);

-- ALMACENES
CREATE TABLE almacenes (
    codi_alma varchar(3) NOT NULL,
    desc_alma varchar(50) NOT NULL,
    ubic_alma varchar(100) NOT NULL,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_almacenes PRIMARY KEY (codi_alma)
);

-- TIPO_ACEPTACION
CREATE TABLE tipo_aceptacion (
    codi_tipo_acep varchar(2) NOT NULL,
    desc_acep_requ varchar(50),
    nemo varchar(4),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_tipo_aceptacion PRIMARY KEY (codi_tipo_acep)
);

-- PRODUCTO_ALMACEN_LOTE
CREATE TABLE producto_almacen_lote (
    codi_prod_alma_lote bigint GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    codi_alma varchar(2) NOT NULL,
    codi_prod varchar(8) NOT NULL,
    lote varchar(30) NOT NULL,
    fec_vence timestamp(3),
    stock numeric(18,2),
    ubicacion varchar(50),
    condicion varchar(1),
    situacion integer,
    fech_vence_real timestamp(3),
    p_arreglo varchar(255),
    s_arreglo varchar(255),
    iden varchar(50),
    codi_orde_comp varchar(10),
    correlativo integer,
    canti_salida_venta numeric(18,2),
    fec_ingreso timestamp(3),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_producto_almacen_lote PRIMARY KEY (codi_prod_alma_lote)
);

-- PRINCIPIO_X_PRODUCTO
CREATE TABLE principio_x_producto (
    codi_prod varchar(8) NOT NULL,
    sec integer GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    codi_prin varchar(3),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_principio_x_producto PRIMARY KEY (codi_prod, sec)
);

-- PRINCIPIO_ACTIVO
CREATE TABLE principio_activo (
    codi_prin varchar(3) NOT NULL,
    descripcion varchar(100),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_principio_activo PRIMARY KEY (codi_prin)
);

-- UNID_OPER_DIVI
CREATE TABLE unid_oper_divi (
    codi_divi_unid_oper varchar(3) NOT NULL,
    desc_divi_unid_oper varchar(200),
    codi_tipo_unid_oper varchar(2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_unid_oper_divi PRIMARY KEY (codi_divi_unid_oper)
);

-- CONTROL_PROBLEMAS_DETALLE
CREATE TABLE control_problemas_detalle (
    id_control bigint NOT NULL,
    id_sec integer NOT NULL,
    id_sub_fami_prod varchar(4),
    opcion varchar(255),
    dosis varchar(255),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_control_problemas_detalle PRIMARY KEY (id_control, id_sec)
);

-- CONTROL_PROBLEMAS
CREATE TABLE control_problemas (
    id_control bigint NOT NULL,
    nro_control bigint,
    fecha timestamp(3),
    descripcion varchar(255),
    hecho_por varchar(5),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_control_problemas PRIMARY KEY (id_control)
);

-- Almacen_Usuario
CREATE TABLE almacen_usuario (
    codi_alma varchar(2) NOT NULL,
    codi_usua varchar(5) NOT NULL,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_almacen_usuario PRIMARY KEY (codi_alma, codi_usua)
);

-- SALI_MATE_X_PROY
CREATE TABLE sali_mate_x_proy (
    codi_docu_sali varchar(10) NOT NULL,
    codi_proy varchar(10) NOT NULL,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_sali_mate_x_proy PRIMARY KEY (codi_docu_sali, codi_proy)
);

-- SALI_MATE_X_DOCU_SALI
CREATE TABLE sali_mate_x_docu_sali (
    codi_docu_sali_mate varchar(10) NOT NULL,
    codi_docu_sali varchar(10) NOT NULL,
    tipo_docu_orig_sali varchar(2) NOT NULL,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_sali_mate_x_docu_sali PRIMARY KEY (codi_docu_sali_mate, codi_docu_sali, tipo_docu_orig_sali)
);

-- PROVEEDOR_PRODUCTOS
CREATE TABLE proveedor_productos (
    codi_clie_prov varchar(5) NOT NULL,
    codi_fami_prod varchar(2) NOT NULL,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_proveedor_productos PRIMARY KEY (codi_clie_prov, codi_fami_prod)
);

-- ORDEN_COMPRA_DETALLE
CREATE TABLE orden_compra_detalle (
    codi_orde bigint NOT NULL,
    item integer NOT NULL,
    codi_prod varchar(8),
    cantidad numeric(18,4),
    precio numeric(18,4),
    codi_unid_medi varchar(2),
    total numeric(18,2),
    nro_cuen varchar(7),
    saldo numeric(18,4),
    igv numeric(18,2),
    venta numeric(18,2),
    valorigv numeric(18,2),
    estado varchar(1),
    codi_alma varchar(2),
    exonerado varchar(1),
    acidez numeric(18,3),
    serguia varchar(5),
    nroguia varchar(10),
    transporte varchar(5),
    placa varchar(10),
    codi_moti_tras varchar(2),
    pesocolp numeric(18,4),
    ticket varchar(10),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_orden_compra_detalle PRIMARY KEY (codi_orde, item)
);

-- DETALLE_SALIDA_MATERIALES
CREATE TABLE detalle_salida_materiales (
    codi_deta_docu_sali varchar(12) NOT NULL,
    codi_docu_sali varchar(10) NOT NULL,
    nro_cuen varchar(7),
    codi_prod varchar(8),
    desc_prod varchar(250),
    codi_unid_medi_prod varchar(2),
    cantidad numeric(18,4),
    peso numeric(18,4),
    codi_unid_medi_peso varchar(2),
    codi_unid_oper varchar(5),
    con_reto varchar(1),
    indi_reto varchar(1),
    codi_deta_orig varchar(12),
    tipo_orig varchar(1),
    codi_alma varchar(2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_detalle_salida_materiales PRIMARY KEY (codi_deta_docu_sali)
);

-- ORDEN_COMPRA_PEDIDO_COTIZA
CREATE TABLE orden_compra_pedido_cotiza (
    codi_orde_comp varchar(10) NOT NULL,
    codi_docu varchar(10) NOT NULL,
    codi_tipo_docu varchar(4) NOT NULL,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_orden_compra_pedido_cotiza PRIMARY KEY (codi_orde_comp, codi_docu, codi_tipo_docu)
);

-- DETALLE_ORDEN_COMPRA
CREATE TABLE detalle_orden_compra (
    codi_deta_orde_comp varchar(12) NOT NULL,
    codi_orde_comp varchar(10) NOT NULL,
    codi_prod varchar(8) NOT NULL,
    cantidad numeric(18,4),
    precio numeric(18,4),
    codi_mone varchar(2),
    nro_cuen varchar(7),
    tipo_desc integer,
    descuento numeric(12,4),
    prec_orig numeric(18,4),
    codi_deta_orde_pedi varchar(12),
    codi_unid_oper varchar(5),
    codi_alma varchar(2),
    proc_pedi varchar(1),
    fecha_venc timestamp(3),
    tipo_compra varchar(1),
    codi_unid_medi_orde varchar(2),
    tipo_prod varchar(5),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_detalle_orden_compra PRIMARY KEY (codi_deta_orde_comp)
);

-- DETALLE_ORDEN_DE_PEDIDO
CREATE TABLE detalle_orden_de_pedido (
    codi_deta_orde_pedi varchar(12) NOT NULL,
    codi_orde_pedi varchar(10) NOT NULL,
    codi_prod varchar(8),
    cantidad numeric(10,4),
    nro_cuen varchar(7),
    estado varchar(1),
    prec_prom numeric(12,3) DEFAULT 0,
    prec_ulti numeric(12,3) DEFAULT 0,
    codi_mone_prec_ulti varchar(2),
    codi_clie_prov_ulti varchar(5),
    stoc_ulti numeric(15,4),
    stoc_temp_ulti numeric(15,4),
    nro_ulti_sali varchar(10),
    fech_ulti_sali timestamp(3),
    cant_ulti_sali numeric(15,4),
    cons_prom numeric(15,4),
    cuen_cost varchar(7),
    luga_aten varchar(4),
    codi_unid_oper varchar(5),
    codi_alma varchar(2),
    prec_venta numeric(18,3),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_detalle_orden_de_pedido PRIMARY KEY (codi_deta_orde_pedi)
);

-- DETALLE_COTIZACION_PEDIDO
CREATE TABLE detalle_cotizacion_pedido (
    codi_deta_coti varchar(12) NOT NULL,
    codi_coti varchar(10),
    codi_prod varchar(8),
    cantidad numeric(9,2),
    codi_unid_medi_tiem varchar(2),
    tiem_resp numeric(18,2),
    codi_mone varchar(2),
    prec_unit numeric(18,2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_detalle_cotizacion_pedido PRIMARY KEY (codi_deta_coti)
);

-- DETALLE_LISTAREQUERIMIENTOS
CREATE TABLE detalle_listarequerimientos (
    codi_deta_list_requ varchar(10) NOT NULL,
    codi_list_requ varchar(8) NOT NULL,
    codi_prod varchar(8) NOT NULL,
    cantidad numeric(10,4),
    nro_cuen varchar(7),
    stoc_ulti numeric(15,4),
    stoc_temp_ulti numeric(15,4),
    ulti_prec numeric(18,4),
    codi_mone_ulti_prec varchar(2),
    cuen_cost varchar(7),
    fech_ulti_requ timestamp(3),
    codi_unid_oper varchar(5),
    codi_alma varchar(2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_detalle_listarequerimientos PRIMARY KEY (codi_deta_list_requ)
);

-- KIT_DETA
CREATE TABLE kit_deta (
    codi_kit_inte varchar(4) NOT NULL,
    nro_item integer NOT NULL,
    codi_prod varchar(8) NOT NULL,
    cantidad numeric(9,2),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_kit_deta PRIMARY KEY (codi_kit_inte, nro_item)
);

-- PRODUCTOS_LOTES_INGRE_SALI
CREATE TABLE productos_lotes_ingre_sali (
    codi_deta_ingre_sali varchar(12) NOT NULL,
    codi_prod_alma_lote bigint NOT NULL,
    cantidad numeric(18,2),
    io integer NOT NULL,
    codi_ingr_sali varchar(10),
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_productos_lotes_ingre_sali PRIMARY KEY (codi_deta_ingre_sali, codi_prod_alma_lote, io)
);

-- ACEPTACION_LISTA_REQUE
CREATE TABLE aceptacion_lista_reque (
    codi_deta_list_requ varchar(10) NOT NULL,
    codi_pers varchar(5) NOT NULL,
    aceptacion boolean,
    nro_jera smallint,
    fech_acep timestamp(3),
    cantidad numeric(9,2) DEFAULT 0,
    audit_created_at timestamptz NOT NULL DEFAULT now(),
    audit_updated_at timestamptz,
    audit_user varchar(60),
    row_version bigint NOT NULL DEFAULT 0,
    CONSTRAINT pk_aceptacion_lista_reque PRIMARY KEY (codi_deta_list_requ, codi_pers)
);

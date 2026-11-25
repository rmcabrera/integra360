CREATE PROCEDURE [dbo].[UPA_INVETARIO_BALANCE_SALDOS_2]
	@TIPO [tinyint],
	@ANIO [char](4),
	@MES [char](2),
	@CUEN [char](2)
WITH EXECUTE AS CALLER
AS
--declare @TIPO TINYINT, @ANIO CHAR(4), @MES CHAR(2), @CUEN CHAR(2) 
--select @TIPO =4 , @ANIO ='2010' , @MES ='03' ,@CUEN	='40'

set nocount on

DECLARE 	@AN	SMALLINT,
		@MS	TINYINT

		set @an	=  cast(@anio as smallint) 
		set @ms	 = cast(@mes as tinyint) 

declare @Titu varchar(200) 

IF @TIPO = 1 or @tipo=3 or @tipo=4 -- MES de campo FECHA
   BEGIN
	if len(@CUEN)=2 set @Titu = (select desc_clas_cuen from clases_cuentas C (nolock) where codi_clas_cuen=@cuen)
	if len(@CUEN)=3 set @Titu = (select desc_subc from SUB_CLAS_CUEN C (nolock) where codi_subc=@cuen)
	--if len(@CUEN)=4 set @Titu = (select desc_sub_4 from SUB_CLASE_CONT_4 C (nolock) where codi_subc_4=@cuen)
	if len(@CUEN)=5 set @Titu = (select desc_lcc from LINEA_CLASE_C C (nolock) where codi_lcc=@cuen)
	if len(@CUEN)=7 set @Titu = (select desc_cuen from cuentas_contable C (nolock) where nro_cuen=@cuen)

	declare @TX table (codi_sunat int null,  ruc varchar(15) null, prov varchar(100) null, registro varchar(20) null, 
			   saldo_sol numeric(12,2) null, saldo_dol numeric(12,2) null, fecha datetime null, nro_cuen char(7) null)

	insert @Tx
	SELECT CLIE_PROV.codi_sunat, CLIE_PROV.ruc , CLIE_PROV.prov, 
		MOVI_CONTABLES.registro,
		saldo_sol   = isnull( sum( (case when cargo_abono='C' THEN IMPORTE ELSE 0 END ) - (case when cargo_abono='A' THEN IMPORTE ELSE 0 END )) , 0) ,
		saldo_dol = isnull( sum( (case when cargo_abono='C' THEN IMPORTE_d ELSE 0 END ) - (case when cargo_abono='A' THEN IMPORTE_d ELSE 0 END ) ) , 0 ),
        	(select min(fecha) from movi_contables mc (nolock) 
			where mc.registro = MOVI_CONTABLES.registro ) as fecha ,
		nro_cuen
	FROM MOVI_CONTABLES (nolock)
	INNER JOIN 
		(select cp.codi_clie_prov, cp.ruc, tdi.codi_sunat,(case when upper(cp.tipo_pers)='NATURAL' then apel_1+' '+apel_2+ isnull(' '+nomb_1,'')+isnull(' '+nomb_2,'') else razo_soci end) as prov 
	       	from cliente_proveedor cp (nolock) 
			inner join TIPO_DOCU_IDEN tdi (nolock) on cp.Codi_Tipo_Docu_Iden = tdi.Codi_Tipo_Docu_Iden 
	       	) CLIE_PROV
	       	ON MOVI_CONTABLES.Codi_clie_prov = CLIE_PROV.codi_clie_prov		 	
	WHERE anio = @ANIO and mes < = @MES and left(nro_cuen,len(@CUEN))=@CUEN and subdia not in ('x')  --and registro is not null
	GROUP BY CLIE_PROV.codi_sunat, CLIE_PROV.ruc , CLIE_PROV.prov, nro_cuen,MOVI_CONTABLES.registro
	HAVING 
	isnull( sum( (case when cargo_abono='C' THEN IMPORTE ELSE 0 END ) - (case when cargo_abono='A' THEN IMPORTE ELSE 0 END )) , 0) <> 0
		OR isnull( sum( (case when cargo_abono='C' THEN IMPORTE_d ELSE 0 END ) - (case when cargo_abono='A' THEN IMPORTE_d ELSE 0 END ) ) , 0 )<>0

	declare @ruc table (ruc varchar(15) null)


	IF @TIPO=1 AND left(@cuen,2)='41'
	begin
		insert @ruc
		select ruc 
		from @Tx group by ruc having count(ruc)>1
		
		select codi_sunat ,  ruc , prov , 
			(select top 1 codi_clie_prov from cliente_proveedor C (nolock) where c.ruc=t.ruc AND TIPO_RELA='T') ,
			 saldo_sol , saldo_dol , fecha , 
			@cuen , @Titu,
			nro_cuen ,
			(select desc_cuen from cuentas_contable C (nolock) where c.nro_cuen = T.nro_cuen) Clase,
			'' 
		from @Tx t
			where isnull(ruc,'') not in (select ruc from @Ruc)
		union all
		select max(codi_sunat) ,  ruc , max(prov) , 
			(select top 1 codi_clie_prov from cliente_proveedor C (nolock) where c.ruc=x.ruc AND TIPO_RELA='T') ,
			 sum(saldo_sol) , sum(saldo_dol) , null , 
			@cuen , @Titu,
			nro_cuen ,
			(select desc_cuen from cuentas_contable C (nolock) where c.nro_cuen = X.nro_cuen) Clase,
			''
		from @Tx X
			where isnull(ruc,'') in (select ruc from @Ruc)
			group by ruc,nro_cuen

	end
	else
	begin
		insert @ruc
		select ruc 
		from @Tx group by ruc having count(ruc)>1	

		if @Tipo=1
			select codi_sunat ,  ruc , prov , registro ,   saldo_sol , saldo_dol , fecha , 
				@cuen , @Titu,
				nro_cuen ,
				(select desc_cuen from cuentas_contable C (nolock) where c.nro_cuen = T.nro_cuen) Clase,
				'' 
			from @Tx t
				where isnull(ruc,'') not in (select ruc from @Ruc)
			union all
			select max(codi_sunat) ,  ruc , max(prov) , null,   sum(saldo_sol) , sum(saldo_dol) , null , 
				@cuen , @Titu,
				nro_cuen ,
				(select desc_cuen from cuentas_contable C (nolock) where c.nro_cuen = X.nro_cuen) Clase,
				''
			from @Tx X
				where isnull(ruc,'') in (select ruc from @Ruc)
				group by ruc,nro_cuen
		if @Tipo=3
		select codi_sunat ,  ruc , prov , registro,   saldo_sol , saldo_dol , fecha, 
			@cuen , @Titu,
			nro_cuen ,
			(select desc_cuen from cuentas_contable C (nolock) where c.nro_cuen = T.nro_cuen) Clase,
			(select rtrim(serie) + '-'+rtrim(nro_docu ) 
				from movi_contables M (nolock) where subdia='V' and M.registro=T.registro) docu,
			(select CODI_tipo_docu
				from movi_contables M (nolock) where subdia='V' and M.registro=T.registro) tipo
	
		from @Tx T
		where isnull(ruc,'') in (select ruc from @Ruc)

		IF @TIPO=4
			select max(codi_sunat) ,  '', max(prov) , 
				'' ,
				 sum(saldo_sol) , sum(saldo_dol) , null , 
				@cuen , @Titu,
				nro_cuen ,
				(select desc_cuen from cuentas_contable C (nolock) where c.nro_cuen = X.nro_cuen) Clase,
				''
			from @Tx X
			group by nro_cuen

	end	

   END
ELSE	-- MES de campo FECHA_PAGO
   BEGIN
	SELECT CLIE_PROV.codi_sunat, CLIE_PROV.ruc , CLIE_PROV.prov, MOVI_CONTABLES.registro,
		soles   = sum( (case when cargo_abono='C' THEN IMPORTE ELSE 0 END ) - (case when cargo_abono='A' THEN IMPORTE ELSE 0 END )),
		dolares = sum( (case when cargo_abono='C' THEN IMPORTE_d ELSE 0 END ) - (case when cargo_abono='A' THEN IMPORTE_d ELSE 0 END )),
	       (select top 1 fecha from movi_contables mc where mc.registro = MOVI_CONTABLES.registro ) as fecha 
	FROM MOVI_CONTABLES 
				INNER JOIN 
					(select cp.codi_clie_prov, cp.ruc, tdi.codi_sunat,(case when upper(cp.tipo_pers)='NATURAL' then apel_1+' '+apel_2+ isnull(' '+nomb_1,'')+isnull(' '+nomb_2,'') else razo_soci end) as prov 
				       	from cliente_proveedor  cp inner join TIPO_DOCU_IDEN tdi on cp.Codi_Tipo_Docu_Iden = tdi.Codi_Tipo_Docu_Iden 
				       	) CLIE_PROV
				       	ON MOVI_CONTABLES.Codi_clie_prov = CLIE_PROV.codi_clie_prov
	WHERE anio =@anio and mes < = @mes and subdia not in ('x') and left(nro_cuen,2)=@CUEN 
	GROUP BY CLIE_PROV.codi_sunat, CLIE_PROV.ruc , CLIE_PROV.prov, MOVI_CONTABLES.registro
   END
GO

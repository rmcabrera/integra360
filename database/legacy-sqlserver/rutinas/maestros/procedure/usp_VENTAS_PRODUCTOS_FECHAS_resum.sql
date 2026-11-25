CREATE PROCEDURE [dbo].[usp_VENTAS_PRODUCTOS_FECHAS_resum]
	@TIPO [varchar](2),
	@CODI_ALMA [char](2),
	@FEC1 [datetime],
	@FEC2 [datetime],
	@CODI_CLIE_PROV [char](5),
	@SUBFAMILIA [char](4),
	@CODI_PRES [int]
WITH EXECUTE AS CALLER
AS
--declare @TIPO varCHAR(2) , @CODI_ALMA CHAR(2) , @FEC1 DATETIME , @FEC2 DATETIME  , @CODI_CLIE_PROV CHAR(5)  , @SUBFAMILIA char(4) , @CODI_PRES INT 
--select @TIPO ='00', @CODI_ALMA ='07' , @FEC1 ='01/01/2017', @FEC2 ='30/01/2017', @CODI_CLIE_PROV ='', @SUBFAMILIA ='', @CODI_PRES =0

set nocount on 
create table #REsul (nemo_alma varchar(50) null, codi_clie_prov char(5) null, laboratorio varchar(250) null, desc_sub_fami_prod varchar(250) null,
					desc_prod varchar(250) null, desc_pres varchar(50) null, venta_cant_conta numeric(12,3) null, venta_valor_Conta numeric(12,4) null,
					venta_costo_conta numeric(12,4) null, venta_cant_cred numeric(12,4) null, venta_valor_cred numeric(12,4) null, venta_costo_cred numeric(12,4) null)

insert #REsul
exec PA_VENTAS_PRODUCTOS_FECHAS @TIPO =@tipo , @CODI_ALMA =@CODI_ALMA , @FEC1 =@FEC1, @FEC2 =@fec2 , 
				@CODI_CLIE_PROV =@CODI_CLIE_PROV, @SUBFAMILIA =@SUBFAMILIA , @CODI_PRES =@CODI_PRES


select null as nemo_alma , codi_clie_prov , laboratorio , null as desc_sub_fami_prod ,
					null as desc_prod , null as desc_pres , 
					sum(venta_cant_conta ) as venta_cant_conta , 
					sum(venta_valor_Conta ) as venta_valor_Conta ,
					sum(venta_costo_conta ) as venta_costo_conta , sum(venta_cant_cred ) as venta_cant_cred , 
					sum(venta_valor_cred ) as venta_valor_cred , 
					sum(venta_costo_cred ) as venta_costo_cred 
from #REsul
group by codi_clie_prov , laboratorio

drop table #REsul
GO

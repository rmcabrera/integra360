CREATE PROCEDURE [dbo].[usp_canje_letras]
	@anio [char](4),
	@fecha [datetime],
	@clie [char](5),
	@cuen [varchar](200)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @fecha datetime, @clie char(5), @cuen varchar(200) 
--select @anio ='2018', @fecha ='22/03/2018', @clie ='16553', @cuen ='421,422,423'

set nocount on

declare @lstDato  INT    
declare @lnuPosComa int        
        
declare  @sx table(cta varchar(7) collate sql_latin1_general_cp1_ci_as null)
WHILE  LEN(@cuen)> 0                                        
BEGIN                                        
 SET @lnuPosComa = CHARINDEX(',', @cuen ) -- Buscamos el caracter separador                                        
 IF ( @lnuPosComa=0 )                                        
 BEGIN                                        
  SET @lstDato = @cuen                                        
  SET @cuen = ''                                        
 END                                        
 ELSE                                        
 BEGIN                                        
  SET @lstDato = Substring( @cuen , 1  , @lnuPosComa-1)                                        
  SET @cuen = Substring( @cuen , @lnuPosComa + 1 , LEN(@cuen))                                        
 END                                        
                                        
 insert @sx select @lstDato          
END      


select '0' as Chec,codi_tipo_docu,cod,Est.codi_clie_prov,Imp , ImpD, Fs, Est.Registro, Est.nro_cuen, razon_social,desc_cuen, nro_docu,compr,
		glosa, subdia, fecha_venc, anio, mes, Sg.codi_mone, tipo_cambio , serie, fo
from 
		(select max(fecha) as Fs, codi_clie_prov,sum(importe) as Imp , sum(importe_d) as ImpD, registro,nro_cuen  , min(fecha) FO
	from 
		(select fecha, codi_clie_prov,importe*case when cargo_Abono='C' then 1 else -1 end as importe ,
				importe_d*case when cargo_Abono='C' then 1 else -1 end as importe_d, 
					 registro, nro_cuen 
		from movi_contables (nolock)
			 where anio=@anio and codi_clie_prov=@clie and fecha <= @fecha and not (registro is null)  
					--and left(nro_Cuen,3) in ('421','422','423')
					and exists (select * from @Sx S where left(movi_contables.nro_cuen, len(S.cta))= S.cta)
		) as Sl group by codi_clie_prov, nro_cuen,registro) as Est , empresa, cuentas_contable,
(select codi_tipo_docu,cod,codi_clie_prov, nro_cuen, registro,compr, nro_docu,glosa, subdia, fecha_venc, anio, mes, codi_mone, tipo_cambio, serie  
	from movi_contables as Ct (nolock),
		(select min(codi_contable) as cod from movi_contables (nolock), 
			(select codi_clie_prov, registro, nro_cuen from movi_contables x (nolock)
				where x.codi_clie_prov=@clie and exists (select * from @Sx S where left(x.nro_cuen, len(S.cta))= S.cta)
				group by codi_clie_prov, registro, nro_cuen) as GR 
where movi_contables.codi_clie_prov=@clie  and movi_contables.nro_cuen=gr.nro_cuen and
	movi_contables.codi_clie_prov=Gr.codi_clie_prov and gr.registro=movi_contables.registro 
group by movi_contables.codi_clie_prov,movi_contables.nro_cuen, movi_contables.registro) as Sl
where sl.cod=ct.codi_contable) as SG
	 where	sg.codi_clie_prov=@clie and not (imp=0 and impd=0) and cuentas_contable.nro_cuen=est.nro_cuen and SG.codi_clie_prov=est.codi_clie_prov
	and SG.nro_Cuen=est.nro_cuen and Sg.registro=est.registro
GO

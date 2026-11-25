CREATE PROCEDURE [dbo].[usp_reporte_letras]
	@anio [char](4),
	@cuenta [char](7),
	@fec [datetime]
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @cuenta char(7) , @fec datetime
--select @anio='2019', @cuenta='4231101', @fec='27/08/2019'

set nocount on

SELECT codi_tipo_docu, codi_contable COD, S1.codi_clie_prov,
		(Select denominacion from cliente_proveedor (nolock) where codi_clie_prov=s1.codi_clie_prov) razon,
		Imp, ImpD, FS, FO, S1.Registro , S1.nro_cuen ,
		(Select top 1 razon_social from empresa) Razon_social, 
		(Select desc_cuen from cuentas_contable CU (nolock) where cu.nro_cuen=S1.nro_cuen) desc_cuen,
		nro_docu, compr, glosa, subdia,FV, anio, mes, codi_mone, tipo_cambio,
		(select nemo from bancos B where  b.codi_banc= S2.banco_aux) Banco,
		nro_fact,
		
		dbo.fn_repo_letras_produc(s1.registro, @fec)   as  situ_cheq , 
		
		dateadd(dd,  8, fv ) ultimodia,
		case month( fv) when 1 then 'ENERO' when 2 then 'FEBRERO' when 3 then 'MARZO' when 4 then 'ABRIL' when 5 then 'MAYO' when 6 then 'JUNIO' when 7 then 'JULIO' when 8 then 'AGOSTO' 
				when 9 then 'SETIEMBRE' when 10 then 'OCTUBRE' when 11 then 'NOVIEMBRE' when 12 then 'DICIEMBRE' else '' end + ' - '+ cast(year( fv) as varchar)  as CMes,
		convert(char(10),fv ,103)  +'  -  '+
			case  datepart(dw,fv)  when 7 then 'Domingo' when 1 then 'Lunes' when 2 then 'Martes' when 3 then 'Miércoles' when 4 then 'Jueves' when 5 then 'Viernes' when 6 then 'Sábado' end  DIaSEM
from 
(select max(fecha) as FS, min(fecha) as FO, codi_clie_prov, isnull(sum( case when cargo_abono='C' then isnull(importe,0) else -1*isnull(importe,0) end ),0) Imp,
	isnull(sum(case when cargo_abono ='C' then isnull(importe_d,0) else -1*isnull(importe_d,0) end ),0) ImpD, registro, nro_cuen,	Max(fecha_venc) FV,
	max(nro_Fact)  as nro_Fact	 
	from movi_contables  (nolock) 
	where anio =@anio and left(nro_cuen,len(@cuenta))= @cuenta and fecha < DATEADD ( day , 1, @fec) 
				and not (registro is null or ltrim(registro)='') 
	group by codi_clie_prov,nro_cuen,registro 
	having not (isnull(sum( case when cargo_abono='C' then isnull(importe,0) else -1*isnull(importe,0) end ),0)=0
			and isnull(sum(case when cargo_abono ='C' then isnull(importe_d,0) else -1*isnull(importe_d,0) end ),0)=0)) S1
JOIN
(select  tipo_cambio as tipo_cambio,codi_tipo_docu,codi_contable,ct.codi_clie_prov, ct.nro_cuen, ct.registro,compr, 
     nro_docu,glosa, subdia, fecha_venc, anio, mes, codi_mone ,banco_aux,situ_cheq
	from movi_contables as Ct (nolock)
		join (select  Y.codi_clie_prov, Y.registro, Y.nro_cuen, min(codi_contable) minx  
                    from movi_contables Y(nolock)
			 where Y.anio =@anio and subdia in ('L','S') and left(Y.nro_cuen,len(@cuenta))=@cuenta 
					and fecha < DATEADD ( day , 1, @fec)  and isnull(registro,'') <>'' 
				group by Y.codi_clie_prov, Y.registro, Y.nro_cuen) as X 
			on Ct.codi_clie_prov=X.codi_clie_prov and Ct.registro=X.registro and Ct.nro_cuen=X.nro_cuen and
				ct.codi_contable=x.minx) S2
on S1.codi_clie_prov = S2.codi_clie_prov and S1.registro=S2.registro and S1.nro_cuen=S2.nro_cuen  
where (abs(imp)>0.1 and codi_mone='01') or (abs(impd)>0.1 and codi_mone='02')
GO

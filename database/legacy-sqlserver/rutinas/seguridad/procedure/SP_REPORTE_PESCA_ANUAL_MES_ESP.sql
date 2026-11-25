CREATE PROCEDURE [dbo].[SP_REPORTE_PESCA_ANUAL_MES_ESP]
	@anio [char](4)
WITH EXECUTE AS CALLER
AS
begin
	select  (select desc_unid_oper from si_rosa.dbo.embarcaciones  E where E.codi_unid_oper=S.codi_unid_oper) Embar,
		(select desc_espe from si_rosa.dbo.Especies E where E.codi_espe =S.codi_espe) Especie,
		sum(enero) mes1, sum(febrero) mes2, sum(MArzo) mes3, sum(abril) mes4, 
		sum(mayo) mes5, sum(junio) mes6, sum(julio) mes7, sum(agosto) mes8, 
		sum(setiembre) mes9, sum(octubre) mes10, sum(noviembre) mes11, sum(diciembre) mes12 , (select razon_social from si_rosa.dbo.empresa) Empresa,
		 (select  top 1 grupo  from si_rosa.dbo.embarcaciones)  grupo
	From
		(select 	year(fech_Repo) anio, 
			case when month(fech_repo)= 1 then sum(cantidad) else 0 end Enero ,
			case when month(fech_repo)= 2 then sum(cantidad) else 0 end Febrero ,
			case when month(fech_repo)= 3 then sum(cantidad) else 0 end Marzo ,
			case when month(fech_repo)= 4 then sum(cantidad) else 0 end Abril ,
			case when month(fech_repo)= 5 then sum(cantidad) else 0 end Mayo ,
			case when month(fech_repo)= 6 then sum(cantidad) else 0 end Junio ,
			case when month(fech_repo)= 7 then sum(cantidad) else 0 end Julio ,
			case when month(fech_repo)= 8 then sum(cantidad) else 0 end Agosto ,
			case when month(fech_repo)= 9 then sum(cantidad) else 0 end Setiembre ,
			case when month(fech_repo)= 10 then sum(cantidad) else 0 end Octubre ,
			case when month(fech_repo)= 11 then sum(cantidad) else 0 end Noviembre ,
			case when month(fech_repo)= 12 then sum(cantidad) else 0 end Diciembre ,
		        codi_unid_oper , codi_espe
			from 
				si_rosa.dbo.zarpes Z join si_rosa.dbo.detalle_zarpe D
				on Z.codi_zarp=D.codi_zarp
				where year(fech_Repo)=@anio and cantidad>0
				group by year(fech_repo) , month(fech_repo), codi_unid_oper,codi_espe) S
		group by anio,codi_unid_oper ,codi_espe
	union all
	select  (select desc_unid_oper from si_isab.dbo.embarcaciones  E where E.codi_unid_oper=S.codi_unid_oper) Embar,
		(select desc_espe from si_isab.dbo.Especies E where E.codi_espe =S.codi_espe) Especie,
		sum(enero) mes1, sum(febrero) mes2, sum(MArzo) mes3, sum(abril) mes4, 
		sum(mayo) mes5, sum(junio) mes6, sum(julio) mes7, sum(agosto) mes8, 
		sum(setiembre) mes9, sum(octubre) mes10, sum(noviembre) mes11, sum(diciembre) mes12 , (select razon_social from si_isab.dbo.empresa) Empresa,
		 (select  top 1 grupo  from si_isab.dbo.embarcaciones)  grupo
	From
		(select 	year(fech_Repo) anio, 
			case when month(fech_repo)= 1 then sum(cantidad) else 0 end Enero ,
			case when month(fech_repo)= 2 then sum(cantidad) else 0 end Febrero ,
			case when month(fech_repo)= 3 then sum(cantidad) else 0 end Marzo ,
			case when month(fech_repo)= 4 then sum(cantidad) else 0 end Abril ,
			case when month(fech_repo)= 5 then sum(cantidad) else 0 end Mayo ,
			case when month(fech_repo)= 6 then sum(cantidad) else 0 end Junio ,
			case when month(fech_repo)= 7 then sum(cantidad) else 0 end Julio ,
			case when month(fech_repo)= 8 then sum(cantidad) else 0 end Agosto ,
			case when month(fech_repo)= 9 then sum(cantidad) else 0 end Setiembre ,
			case when month(fech_repo)= 10 then sum(cantidad) else 0 end Octubre ,
			case when month(fech_repo)= 11 then sum(cantidad) else 0 end Noviembre ,
			case when month(fech_repo)= 12 then sum(cantidad) else 0 end Diciembre ,
		        codi_unid_oper , codi_espe
			from 
				si_isab.dbo.zarpes Z join si_isab.dbo.detalle_zarpe D
				on Z.codi_zarp=D.codi_zarp
				where year(fech_Repo)=@anio and cantidad>0
				group by year(fech_repo) , month(fech_repo), codi_unid_oper,codi_espe) S
		group by anio,codi_unid_oper ,codi_espe

		
end
GO

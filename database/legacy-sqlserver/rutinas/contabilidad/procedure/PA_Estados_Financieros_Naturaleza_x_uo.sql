CREATE PROCEDURE [dbo].[PA_Estados_Financieros_Naturaleza_x_uo]
	@anio [char](4),
	@mes_i [char](2),
	@mes_f [char](2),
	@tipo [tinyint]
WITH EXECUTE AS CALLER
AS
--declare @anio  char(4),  @mes_i  char(2),   @mes_f  char(2),  @tipo tinyint
--select @anio  ='2012',  @mes_i  ='01',   @mes_f  ='01',  @tipo =2
set nocount on
  
Declare @id tinyint    
 
-- 1 del mes  2 acumulado de '01' al  mes   
  
Create Table #Tempo  
 ( Ide  tinyint not null,  
   Desc_Ide varchar(150) null, --descripcion del grupo ESTADOS_FINANCIEROS  
   Cod    varchar (3) not null,  
   Descripcion varchar(100) not null,  
   Monto  decimal (18,2) not null,  
   Orden  int null,  --orden dentro del grupo ESTADOS_FINANCIEROS_DETALLE  
	codi_unid_oper  char(5) null,
	desc_unid_oper varchar(100) null          )  
  
Insert into #Tempo (Ide, Desc_Ide, Cod, Descripcion, monto,orden,codi_unid_oper, desc_unid_oper)  
  select id, 
		(Select Descripcion From Estados_Financieros F (nolock) where F.id = sql.id) Estado,  
		cod, 
		upper(dbo.uf_nom_cuen(cod)) as Descripcion,   
		sum(monto) as monto,
		(Select orden From Estados_Financieros F (nolock) where F.id = sql.id)*100+
			(Select orden From estados_financieros_detalle F (nolock)
					where F.id = sQL.ID  and F.nro_cuen = cod) orden,
		isnull(codi_unid_oper,''),
		isnull((select isnull(nemo_uo,desc_unid_oper) from unid_oper U (nolock) where u.codi_unid_oper=Sql.codi_unid_oper),'') Desc_unid_oper
				
  from
  (Select  E.ID , 		
		   left(MC.nro_cuen,len(E.nro_cuen)) as Cod ,  
         (case cargo_abono when 'A' then importe else -1*importe end) as monto,  
		(Select orden From estados_financieros_detalle F (nolock)
				where F.id = E.ID  and F.nro_cuen = left(MC.nro_cuen,len(E.nro_cuen))) as Orden  ,
		codi_unid_oper
  from  movi_contables MC  (nolock)
	join estados_financieros_detalle E (nolock)
	on left(MC.nro_cuen,len(E.nro_cuen)) = E.nro_cuen
  where  MC.anio= @ANIO and MC.mes BETWEEN @MES_I  AND @MES_F and MC.subdia <>'X'  
		and e.id in (select EF.id from estados_financieros EF (nolock) where tipo=2)) SQL
    Group by id, cod ,codi_unid_oper
     
 Select T.Ide,T.Desc_Ide,T.Cod ,T.Descripcion,T.Monto,T.Orden  , codi_unid_oper+' - '+desc_unid_oper Desc_unid  
 From #Tempo T inner join ESTADOS_FINANCIEROS EF on EF.ID = T.ide  
 order by EF.Orden, t.ORDEN  
 
 drop table #Tempo
GO

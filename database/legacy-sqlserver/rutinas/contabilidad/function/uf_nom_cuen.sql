CREATE FUNCTION [dbo].[uf_nom_cuen](@cuen [varchar](7))
RETURNS [varchar](250) WITH EXECUTE AS CALLER
AS 
begin  
 declare @Rt varchar(250)  
 if len(@cuen) =7   
  set @Rt = ( select desc_cuen from cuentas_contable C (nolock) where c.nro_cuen=@cuen)  
 if len(@cuen) =5  
  set @Rt = ( select desc_lcc from LINEA_CLASE_C C (nolock) where c.codi_lcc=@cuen)   
 if len(@cuen) =4   
  set @Rt = ( select desc_sub_4 from SUB_CLASE_CONT_4 C (nolock) where c.codi_subc_4=@cuen)  
 if len(@cuen) =3   
  set @Rt =  ( select desc_subc from SUB_CLAS_CUEN C (nolock) where c.codi_subc=@cuen )  
 if len(@cuen) =2  
  set @Rt = ( select desc_clas_cuen from clases_Cuentas C (nolock) where c.codi_clas_cuen=@cuen )  
 if @Rt is null set @RT=''  
  
 return @RT  
     
end
GO

CREATE FUNCTION [dbo].[uf_dato_max_kardex](@prod [char](8), @fech [datetime], @Dato [int], @alma [char](2))
RETURNS [varchar](10) WITH EXECUTE AS CALLER
AS 
begin

	--declare @prod char(8), @fech datetime, @Dato int, @alma char(2)
	--select @prod='00011455', @fech='22/01/2016 16:46:47.017', @dato = 1, @alma ='00'

	declare @Rs varchar(10)
	declare @Tipo varchar(5), @Serie varchar(10) , @nro varchar(10), @oper varchar(5)

	select top  1 
			@tipo=(case when i_o=1 then   
				  (Select (select tipo_sunat from tipo_documento t (nolock)   
				   where t.codi_tipo_docu=isnull(codi_tipo_docu_cont,n.codi_tipo_docu) ) from nota_ingreso N (nolock)   
				   where N.codi_nota_ingr = K.codi_docu_i_o and i_o = 1)    
				  else (Select (select tipo_sunat from tipo_documento t (nolock)   
				   where codi_tipo_docu = codi_tipo_docu_sali) from docu_sali_mate D (nolock)   
				   where D.codi_docu_sali = K.codi_docu_i_o and i_o = 2) end),
	   
		 @serie= case when i_o=1 then   
			  (Select isnull(nro_seri_docu_cont, nro_seri) from nota_ingreso N (nolock)   
					where N.codi_nota_ingr = K.codi_docu_i_o and i_o = 1)    
			  else (Select nro_seri_docu_sali from docu_sali_mate D (nolock)   
			   where D.codi_docu_sali = K.codi_docu_i_o and i_o = 2) end ,  
	  
		  @nro = case when i_o=1 then   
			  (Select isnull(nro_docu_cont, nro_docu)  from nota_ingreso N (nolock)   
			   where N.codi_nota_ingr = K.codi_docu_i_o and i_o = 1)    
			  else (Select nro_docu_sali from docu_sali_mate D (nolock)   
			   where D.codi_docu_sali = K.codi_docu_i_o and i_o = 2) end ,  
		  
		  @oper= case when i_o=1 then   
			  (Select (select codi_sunat_moti_tras from tipo_ingr_sali T (nolock)  
				where codi_tipo_is=tipo_nota_ingr )  from nota_ingreso N (nolock)   
			   where N.codi_nota_ingr = K.codi_docu_i_o and i_o = 1)    
			  else (Select (select codi_sunat_moti_tras from tipo_ingr_sali T (nolock)  
				where codi_tipo_is=tipo_sali )  from docu_sali_mate D (nolock)   
			   where D.codi_docu_sali = K.codi_docu_i_o and i_o = 2) end 
	   
	from kardex K (nolock)
	where codi_prod=@prod and fech_tran=@fech and (codi_alma=@alma or @alma='00')
	
	order by i_o desc

	if @dato=1 set @rs=@tipo
	if @dato=2 set @rs=@serie
	if @dato=3 set @rs=@nro
	if @dato=4 set @rs=@oper

	return @rs
	
end
GO

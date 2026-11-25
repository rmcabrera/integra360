CREATE PROCEDURE [dbo].[usp_genera_sire]
	@anio [char](4),
	@mes [char](2),
	@TipoEstru [varchar](4),
	@Anexo [varchar](2)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @mes char(2) ,@TipoEstru varchar(4), @Anexo varchar(2)      
--select @anio ='2023', @mes ='03', @TipoEstru ='8', @Anexo='8'
                      
                                                                
declare @Ruc varchar(11)                                                                    
                                                              
select @Ruc =ruc from empresa (nolock)                                                                 
         
if @TipoEstru='8.4' --------------------Compras
  
  if @Anexo='8'
	exec PA_Registro_Compras_libro_A8 @mes=@mes,@anio=@anio        
  
  if @Anexo='11'
	exec PA_Registro_Compras_libro_A11 @mes=@mes,@anio=@anio        
      
if @TipoEstru='14'   --------------------Ventas
  
  if @Anexo='2'
	exec PA_Registro_Ventas_libro_A2 @anio=@anio,@mes=@mes

  if @Anexo='3'
	exec PA_Registro_Ventas_libro_A3 @anio=@anio,@mes=@mes
GO

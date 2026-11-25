CREATE PROCEDURE [dbo].[usp_genera_ple]
	@anio [char](4),
	@mes [char](2),
	@TipoEstru [varchar](4)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4), @mes char(2) ,@TipoEstru varchar(4)     
--select @anio ='2022', @mes ='08', @TipoEstru ='8.1'
                      
                                                                
declare @Ruc varchar(11)                                                                    
                                                              
select @Ruc =ruc from empresa (nolock)                                                                
                                       
if @TipoEstru='5' --------------------Libro diario      
	exec PA_LIBRO_DIARIO_ple @anio=@anio,  @mes=@mes    
  
if @TipoEstru='5.3' --------------------Libro diario      
	exec usp_libro_diario_ple_detalle_plan @anio=@anio,  @mes=@mes    
    
if @TipoEstru='6' --------------------Libro mayor      
	exec PA_Libro_Mayor_ple @anio=@anio,  @mes=@mes    
       
if @TipoEstru='8' --------------------Compras      
	exec PA_Registro_compras_libro @anio=@anio, @mes=@mes

if @TipoEstru='8.1' --------------------Compras No Domi
  exec PA_Registro_Compras_no_domic_libro @anio=@anio, @mes=@mes	
      
if @TipoEstru='14'   --------------------Prestador de Serv	icios con Rentas de Cuarta categoría: Detalle de comprobantes.                                            
	exec PA_Registro_Ventas_libro @anio=@anio,@mes=@mes
GO

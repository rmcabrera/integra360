CREATE PROCEDURE [dbo].[usp_generar_transferencia]
	@anio [char](4),
	@fi [datetime],
	@ff [datetime],
	@TipoEstru [varchar](2)
WITH EXECUTE AS CALLER
AS
--declare @anio char(4),@fi datetime, @ff datetime, @TipoEstru varchar(2)    
--select @anio ='2012',@fi ='01/01/2012',@ff ='30/01/2012',  @TipoEstru ='2'    
                    
                                                         
declare @Ruc varchar(11)                                                                  
                                                            
select @Ruc =ruc from empresa (nolock)                                                              
                                     
if @TipoEstru='1' --------------------Generar Costo    
  begin     
  exec usp_genera_costos @anio=@anio, @fi=@fi, @ff=@ff
  end     
  
  
if @TipoEstru='2' --------------------Generar Ingreso    
  begin     
  exec usp_genera_ingreso @anio=@anio, @fi=@fi, @ff=@ff
  end
GO

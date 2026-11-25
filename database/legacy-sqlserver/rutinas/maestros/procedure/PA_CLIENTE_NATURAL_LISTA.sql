CREATE PROCEDURE [dbo].[PA_CLIENTE_NATURAL_LISTA]
	@campo [char](1),
	@valor [varchar](50)
WITH EXECUTE AS CALLER
AS
if @campo='A' 

begin

  SELECT Cliente_Natural.Id_Clie_Natu,   
         Cliente_Natural.Apellidos,   
         Cliente_Natural.Nombres,   
         Cliente_Natural.Nro_Docu,   
         Cliente_Natural.Direccion,   
         Cliente_Natural.Codi_Clie_Prov  
    FROM Cliente_Natural   where Cliente_Natural.Apellidos like  @valor + '%'
end 

else if @campo='N' 

begin

  SELECT Cliente_Natural.Id_Clie_Natu,   
         Cliente_Natural.Apellidos,   
         Cliente_Natural.Nombres,   
         Cliente_Natural.Nro_Docu,   
         Cliente_Natural.Direccion,   
         Cliente_Natural.Codi_Clie_Prov  
    FROM Cliente_Natural   where Cliente_Natural.Nombres like @valor  + '%'
end 

else  --- Nro documento

begin

  SELECT Cliente_Natural.Id_Clie_Natu,   
         Cliente_Natural.Apellidos,   
         Cliente_Natural.Nombres,   
         Cliente_Natural.Nro_Docu,   
         Cliente_Natural.Direccion,   
         Cliente_Natural.Codi_Clie_Prov  
    FROM Cliente_Natural   where Cliente_Natural.Nro_Docu like  @valor   + '%'
end
GO

CREATE PROCEDURE [dbo].[PA_CLIENTES_PROVEEORES_FILTRO]
	@TIPO [char](1),
	@valor [varchar](100)
WITH EXECUTE AS CALLER
AS
begin
  
if @tipo='A' -- buscar por apellidos
begin
	SELECT CP.CODI_CLIE_PROV,   CP.DENOMINACION,    CP.RUC , CP.DIRECCION  ,
	isnull((SELECT TOP 1 CODI_CREDITO FROM CLIENTE_CREDITOS WHERE CODI_CLIE_PROV = CP.CODI_CLIE_PROV),0) 'Cred' 
                FROM CLIENTE_PROVEEDOR  CP
                where upper( ( rtrim(cp.apel_1) + ' ' + rtrim(cp.apel_2))) like @valor  
	order by cp.apel_1 ,  cp.apel_2

end

if @tipo='N' -- buscar por Nombres
begin
	SELECT CP.CODI_CLIE_PROV,   CP.DENOMINACION,    CP.RUC , CP.DIRECCION  ,
	isnull((SELECT TOP 1 CODI_CREDITO FROM CLIENTE_CREDITOS WHERE CODI_CLIE_PROV = CP.CODI_CLIE_PROV),0) 'Cred' 
                FROM CLIENTE_PROVEEDOR  CP
                where upper( ( rtrim(cp.nomb_1) + ' ' + rtrim(cp.nomb_2)))  like @valor  
	order by cp.nomb_1 , cp.nomb_2

end

if @tipo='D' -- buscar por Denominacion
begin
	SELECT CP.CODI_CLIE_PROV,   CP.DENOMINACION,    CP.RUC , CP.DIRECCION  ,
	isnull((SELECT TOP 1 CODI_CREDITO FROM CLIENTE_CREDITOS WHERE CODI_CLIE_PROV = CP.CODI_CLIE_PROV),0) 'Cred' 
                FROM CLIENTE_PROVEEDOR  CP
                where  upper( ( rtrim(cp.DENOMINACION)))  like @valor  
	order by cp.DENOMINACION

end

if @tipo='R' -- buscar por RUC
begin
	SELECT CP.CODI_CLIE_PROV,   CP.DENOMINACION,    CP.RUC , CP.DIRECCION  ,
	isnull((SELECT TOP 1 CODI_CREDITO FROM CLIENTE_CREDITOS WHERE CODI_CLIE_PROV = CP.CODI_CLIE_PROV),0) 'Cred' 
                FROM CLIENTE_PROVEEDOR  CP
                where  upper( ( rtrim(cp.RUC)))  like @valor  
	order by cp.DENOMINACION

end
else
	begin
 
	SELECT CP.CODI_CLIE_PROV,   CP.DENOMINACION,    CP.RUC , CP.DIRECCION ,
	isnull((SELECT TOP 1 CODI_CREDITO FROM CLIENTE_CREDITOS WHERE CODI_CLIE_PROV = CP.CODI_CLIE_PROV),0) 'Cred' 
	 FROM CLIENTE_PROVEEDOR  CP
	order by cp.apel_1 ,  apel_2
	 end
end
GO

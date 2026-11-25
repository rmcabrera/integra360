CREATE PROCEDURE [dbo].[sp_MeDaraProblemas]
	@Codi_Area [char](2),
	@Nomb_Area [varchar](100),
	@Ubica [varchar](100)
WITH EXECUTE AS CALLER
AS
begin

truncate table Areas
insert into Areas values(@Codi_Area,@Nomb_Area, @Ubica) 
end
--Conexion 1
begin tran
select @@spid
exec sp_getapplock 'NoProblemas','Exclusive'
exec sp_MeDaraProblemas '41' ,'Burdel', 'Mas alla' 

-- despues de la conexión 1
exec sp_lock
exec sp_releaseapplock 'NoProblemas'
exec sp_lock
commit tran
GO

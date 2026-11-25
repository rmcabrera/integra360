CREATE PROCEDURE [dbo].[sp_insert_Lock]
WITH EXECUTE AS CALLER
AS
begin tran
select @@spid
exec sp_getapplock 'NoProblemas','Exclusive'
exec sp_lock
exec sp_releaseapplock 'NoProblemas'
exec sp_lock
commit tran
GO

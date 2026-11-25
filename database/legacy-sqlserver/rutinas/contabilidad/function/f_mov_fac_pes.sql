CREATE FUNCTION [dbo].[f_mov_fac_pes](@fac [char](10), @doc [char](4), @sd [char](1))
RETURNS [char](1) WITH EXECUTE AS CALLER
AS 
BEGIN 
declare @d as char(1)
declare @r as char(1)
set @d=null
select @d=tipo_fact from factura_pesca where (ser_Fact   in (select distinct serie from movi_contables where codi_tipo_docu=@doc and subdia=@Sd)
	and nro_Fact   in (select distinct nro_docu from movi_contables where codi_tipo_docu=@doc and subdia=@sd) ) and codi_fact_pesc=@fac ;
if (not @d  is null and ltrim(rtrim(@d))<>'')  set @r='G'
else set @r='P'
return @r
END
GO

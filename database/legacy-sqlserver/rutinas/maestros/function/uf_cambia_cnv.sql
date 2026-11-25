CREATE FUNCTION [dbo].[uf_cambia_cnv](@cadena [varchar](250))
RETURNS [varchar](100) WITH EXECUTE AS CALLER
AS 
begin
--	declare @cadena char(200)
--	set @cadena='F."V. / SE#RV.| DE R°A:STREºO D&E E/P`S $ asdsa año  aÑo'

	declare @NV table (valor char(1), reem varchar(3))
	declare @Car char(1), @rt varchar(250)
	declare @ree varchar(3)

	set @rt=@cadena
	insert @Nv
	select '"','' union all
	select '#','' union all
	select '/','' union all
	select ':','' union all
	select '&','' union all
	select 'º','' union all
	select '`','' union all
	select '=','' union all
	select '''','' union all
	select '°','' union all
	select '$','USD' union all
	select '%','' union all	
	select 'ª','' union all	
	select 'Ñ','NI' union all	
	select 'ñ','ni' union all	
	select '|','' 

	declare CNV cursor for select valor , reem from @NV
	open CNV
	fetch CNV into @Car, @ree
	while @@Fetch_status=0
	begin
		set @rt = replace(@rt,@car,@ree)
		
		fetch CNV into @Car, @ree
	end 
	close CNV
	deallocate CNV
	--select left(@rt,100)
	return left(@rt,100)
end
GO

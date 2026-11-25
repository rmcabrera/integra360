CREATE PROCEDURE [dbo].[SP_Report_Quincena_Moto]
	@mesa [char](8)
WITH EXECUTE AS CALLER
AS
begin
	Declare @per char(5)
	declare @code char(5)
	Declare @nom varchar(70)
	declare @net numeric(12,2)
	declare @ne varchar(30)
	Declare @car char(4)
	Declare @nc varchar(20)
	Declare @sne numeric(12,2)
	Declare @sba numeric(12,2)
	declare @di numeric(2)
	Declare @qui numeric(12,2)
	create table #temporal (codemb char(5) null,  embar varchar(30) null, codper char(5) null, personas varchar(70) null, 
		cargo char(4) null, mensualidad numeric(12,2) null, basico numeric(12,2) null,	 dias numeric(2) null,  quincena numeric(12,2) null,
		neto numeric(12,2) null,  cte numeric(12,2) null ,  otros numeric(12,2) null,  descu numeric(12,2) null)
	declare C1 cursor for select codi_pers , importe, codi_unid_oper from planilla_boni_moto where mesanio=@mesa  and tipo='Q'
	open C1
	fetch C1 into @per, @net ,@code
	WHILE @@FETCH_STATUS = 0
	begin
		set @ne=''
		set @nc =''
		set @nom=''
		set @di=0
		set @qui=0
		set @sne=0
		set @sba=0
		select @ne= desc_unid_oper from embarcaciones where codi_unid_oper=@code
		select @nom = apel_1+ ' '  + apel_2 + ' '+ nomb_1+ ' '+ nomb_2 ,   @car = codi_carg, @sne=suel_neto , @sba=suel_basi from personal
			where codi_pers=@per
		select @di=dias_traba_quin from asistencia_motorista where codi_pers=@per and mesanio=@mesa and codi_unid_oper=@code
		set @qui=@net
		insert into #temporal (codemb, embar, codper, personas, cargo, mensualidad, basico, dias, quincena, neto)
			values(@code, @ne, @per, @nom, @car ,@sne, @sba, @di, @qui, @net )
		fetch C1 into @per, @net, @code
	end
	close C1
	deallocate C1
	select * from #temporal
end
GO

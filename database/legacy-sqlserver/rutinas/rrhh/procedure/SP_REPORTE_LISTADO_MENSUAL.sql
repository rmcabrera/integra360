CREATE PROCEDURE [dbo].[SP_REPORTE_LISTADO_MENSUAL]
	@mesa [char](6),
	@emb [char](5)
WITH EXECUTE AS CALLER
AS
BEGIN
	Declare @pers char(5)
	Declare @nemb varchar(30)
	Declare @nom varchar(200)
	Declare @dn varchar(12)
	Declare @dias int
	Declare @par numeric(12,2)
	Declare @boni numeric(12,2)
	Declare @total numeric(12,2)
	Declare @par1 numeric(12,2)
	Declare @boni1 numeric(12,2)
	Declare @total1 numeric(12,2)
	Declare @cts numeric(12,2)
	Declare @vaca numeric(12,2)
	Declare @grati numeric(12,2)

	Create Table #Temporal (DNI char(12) null, nombres varchar(200) null, TotalBoni numeric(12,2) null, TotalParticipacion numeric(12,2) null , TotalRemu numeric (12,2) ,
				DiasPesca int null,  CTS numeric (12,2) null,  Vacaciones numeric (12,2) null, Gratificaciones numeric(12,2) null, embarcacion varchar(30) null,
				Totalafec numeric (12,2) NULL)

	
	set @nemb= (Select desc_unid_oper from embarcaciones where codi_unid_oper=@emb)
	declare C1 cursor for select distinct codi_pers from planilla_de_tripulantes where mesanio=@mesa and codi_unid_oper=@emb
		union 
		select distinct codi_pers from planilla_boni_moto where left(mesanio,2)=right(@mesa,2) and right(mesanio,4)=left(@mesa,4) and codi_unid_oper=@emb
	open C1
	Fetch C1 into @pers
	while @@FETCH_STATUS=0
	begin
		set @dias =0
		set @nom=''
		set @dn=''
		set @par=0
		set @boni=0
		set @total=0
		set @par1=0
		set @boni1=0
		set @total1=0
		set @cts=0
		set @vaca=0
		set @grati=0

		select @nom= apel_1+ isnull(' '+apel_2,'') + isnull(' '+nomb_1,'')+isnull(' '+nomb_2,'') , @dn= isnull(nro_docu_iden ,'') from personal where codi_pers=@pers

		select @par= isnull( sum(isnull(valor,0)),0) from planilla_de_tripulantes , planilla_tripulante_conceptos
			where mesanio=@mesa and planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
				and codi_conc='199999' and codi_pers=@pers and codi_unid_oper=@emb

		select @boni= isnull(valor,0) from planilla_boni_moto , planilla_boni_concepto
			where left(mesanio,2)=right(@mesa,2) and right(mesanio,4)=left(@mesa,4) and planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
				and codi_conc='199999' and tipo='M' and codi_pers=@pers and codi_unid_oper=@emb

		set @total = @par + @boni

		select @par1= isnull( sum(isnull(valor,0)),0) from planilla_de_tripulantes , planilla_tripulante_conceptos
			where mesanio=@mesa and planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
				and codi_conc='199998' and codi_pers=@pers and codi_unid_oper=@emb

		select @boni1= isnull(valor,0) from planilla_boni_moto , planilla_boni_concepto
			where left(mesanio,2)=right(@mesa,2) and right(mesanio,4)=left(@mesa,4) and planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
				and codi_conc='199998' and tipo='M' and codi_pers=@pers and codi_unid_oper=@emb

		set @total1 = @par1 + @boni1

		set @dias= dbo.F_DIAS_SALIDA(left(@mesa,4),@pers,'1',right(@mesa,2))

		
		set @cts = isnull((select isnull(sum(isnull(valor,0)), 0) from planilla_de_tripulantes , planilla_tripulante_conceptos where mesanio=@mesa and planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
				and codi_conc='301052' and codi_pers=@pers and codi_unid_oper=@emb),0) + isnull((select isnull(sum(isnull(valor,0)),0)  from planilla_boni_moto , planilla_boni_concepto
				where left(mesanio,2)=right(@mesa,2) and right(mesanio,4)=left(@mesa,4) and planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
					and codi_conc='301052' and tipo='M' and codi_pers=@pers and codi_unid_oper=@emb),0)

		set @vaca = isnull((select isnull(sum(isnull(valor,0)), 0) from planilla_de_tripulantes , planilla_tripulante_conceptos where mesanio=@mesa and planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
				and codi_conc='101901' and codi_pers=@pers and codi_unid_oper=@emb) ,0)  + isnull( (select isnull(sum(isnull(valor,0)),0) from planilla_boni_moto , planilla_boni_concepto
				where left(mesanio,2)=right(@mesa,2) and right(mesanio,4)=left(@mesa,4) and planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
					and codi_conc='101901' and tipo='M' and codi_pers=@pers and codi_unid_oper=@emb),0)


		set @grati = isnull((select isnull(sum(isnull(valor,0)), 0) from planilla_de_tripulantes , planilla_tripulante_conceptos where mesanio=@mesa and planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
				and codi_conc='101902' and codi_pers=@pers and codi_unid_oper=@emb) , 0 ) + isnull( (select isnull(sum(isnull(valor,0)),0) from planilla_boni_moto , planilla_boni_concepto
				where left(mesanio,2)=right(@mesa,2) and right(mesanio,4)=left(@mesa,4) and planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
					and codi_conc='101902' and tipo='M' and codi_pers=@pers and codi_unid_oper=@emb),0)


		insert into #Temporal (DNI , nombres , TotalBoni , TotalParticipacion , TotalRemu  ,	DiasPesca ,  CTS,  Vacaciones, Gratificaciones, embarcacion,Totalafec)
			values (@dn, @nom, @boni,@par, @total,  @dias , @cts, @vaca, @grati, @nemb,@TOTAL1)
			
		Fetch C1 into @pers
	end
	close C1
	deallocate C1

	Select * , (Select top 1 razon_social from empresa) Empr From #temporal order by nombres
END
GO

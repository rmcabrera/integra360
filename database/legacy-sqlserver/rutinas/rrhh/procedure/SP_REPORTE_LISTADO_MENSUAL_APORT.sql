CREATE PROCEDURE [dbo].[SP_REPORTE_LISTADO_MENSUAL_APORT]
	@mesa [char](6),
	@fact [numeric](12, 3),
	@min [numeric](12, 3)
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
	Declare @quin numeric(12,2)
	Declare @pen numeric(12,2)
	Declare @adm numeric(12,2)
	Declare @sal numeric(12,2)
	Declare @sct numeric(12,2)
	declare @emb char(5)
	declare @afec char(5)

	Create Table #Temporal (DNI char(12) null, nombres varchar(200) null, TotalBoni numeric(12,2) null, TotalParticipacion numeric(12,2) null , TotalRemu numeric (12,2) ,
				DiasPesca int null,  CTS numeric (12,2) null,  Vacaciones numeric (12,2) null, Gratificaciones numeric(12,2) null, embarcacion varchar(30) null,
				Totalafec numeric (12,2) NULL, quinta numeric (12,2) NULL,
				pensiones numeric(12,2) null,  adminis numeric(12,2) null,  salud  numeric(12,2) null,  sctr numeric(12,2) null )

	
	set @nemb= (Select desc_unid_oper from embarcaciones where codi_unid_oper=@emb)

	declare C2 cursor for select codi_unid_oper from embarcaciones order by codi_unid_oper

	open c2
	fetch c2 into @emb
	while @@FETCH_STATUS=0
	begin
		set @nemb = (select desc_unid_oper from embarcaciones e where E.codi_unid_oper =@emb)
		declare C1 cursor for select distinct codi_pers from planilla_de_tripulantes where mesanio=@mesa and codi_unid_oper=@emb
			union 
			select distinct codi_pers from planilla_boni_moto where mesanio=right(@mesa,2)+left(@mesa,4)  and codi_unid_oper=@emb

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
			set @quin=0
			set @pen=0
			set @adm=0
			set @sal=0
			set @sct=0
	
			select @nom= apel_1+ isnull(' '+apel_2,'') + isnull(' '+nomb_1,'')+isnull(' '+nomb_2,'') , @dn= isnull(nro_docu_iden ,'') , @afec=isnull(AFECTO_LEY,'0') from personal where codi_pers=@pers
	
			select @par= isnull( sum(isnull(valor,0)),0) from planilla_de_tripulantes , planilla_tripulante_conceptos
				where mesanio=@mesa and planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
					and codi_conc='199999' and codi_pers=@pers and codi_unid_oper=@emb
	
			select @boni= isnull(valor,0) from planilla_boni_moto , planilla_boni_concepto
				where mesanio=right(@mesa,2)+left(@mesa,4)  and planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
					and codi_conc='199999' and tipo='M' and codi_pers=@pers and codi_unid_oper=@emb
	
			set @total = @par + @boni
	
			select @par1= isnull( sum(isnull(valor,0)),0) from planilla_de_tripulantes , planilla_tripulante_conceptos
				where mesanio=@mesa and planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
					and codi_conc='199998' and codi_pers=@pers and codi_unid_oper=@emb
	
			select @boni1= isnull(valor,0) from planilla_boni_moto , planilla_boni_concepto
				where mesanio=right(@mesa,2)+left(@mesa,4)  and planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
					and codi_conc='199998' and tipo='M' and codi_pers=@pers and codi_unid_oper=@emb
	
			set @total1 = @par1 + @boni1
	
--			set @dias= dbo.F_DIAS_SALIDA(left(@mesa,4),@pers,'1',right(@mesa,2))
			set @dias= dbo.F_DIAS_LABO_TRIPU(@mesa, @pers, (select top 1 codi_carg from personal P where P.codi_pers=@pers))

			set @cts = isnull((select isnull(sum(isnull(valor,0)), 0) from planilla_de_tripulantes , planilla_tripulante_conceptos where mesanio=@mesa and planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
					and codi_conc='301052' and codi_pers=@pers and codi_unid_oper=@emb) , 0 ) + isnull( (select isnull(sum(isnull(valor,0)),0) from planilla_boni_moto , planilla_boni_concepto
					where mesanio=right(@mesa,2)+left(@mesa,4)  and planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
						and codi_conc='301052' and tipo='M' and codi_pers=@pers and codi_unid_oper=@emb),0)

	
			set @vaca = isnull((select isnull(sum(isnull(valor,0)), 0) from planilla_de_tripulantes , planilla_tripulante_conceptos where mesanio=@mesa and planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
					and codi_conc='101901' and codi_pers=@pers and codi_unid_oper=@emb) ,0)  + isnull( (select isnull(sum(isnull(valor,0)),0) from planilla_boni_moto , planilla_boni_concepto
					where mesanio=right(@mesa,2)+left(@mesa,4)  and planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
						and codi_conc='101901' and tipo='M' and codi_pers=@pers and codi_unid_oper=@emb),0)
	
	
			set @grati = isnull((select isnull(sum(isnull(valor,0)), 0) from planilla_de_tripulantes , planilla_tripulante_conceptos where mesanio=@mesa and planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
					and codi_conc='101902' and codi_pers=@pers and codi_unid_oper=@emb) , 0 ) + isnull( (select isnull(sum(isnull(valor,0)),0) from planilla_boni_moto , planilla_boni_concepto
					where mesanio=right(@mesa,2)+left(@mesa,4)  and planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
						and codi_conc='101902' and tipo='M' and codi_pers=@pers and codi_unid_oper=@emb),0)
	
	
			set @quin = isnull((select isnull(sum(isnull(valor,0)), 0) from planilla_de_tripulantes , planilla_tripulante_conceptos where mesanio=@mesa and planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
					and codi_conc='200040' and codi_pers=@pers and codi_unid_oper=@emb) , 0 ) + isnull( (select isnull(sum(isnull(valor,0)),0) from planilla_boni_moto , planilla_boni_concepto
					where mesanio=right(@mesa,2)+left(@mesa,4)  and planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
						and codi_conc='200040' and tipo='M' and codi_pers=@pers and codi_unid_oper=@emb),0)

			set @pen = isnull((select isnull(sum(isnull(valor,0)), 0) from planilla_de_tripulantes , planilla_tripulante_conceptos where mesanio=@mesa and planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
					and (codi_conc='200101' or codi_conc='300033') and codi_pers=@pers and codi_unid_oper=@emb) , 0 ) + isnull( (select isnull(sum(isnull(valor,0)),0) from planilla_boni_moto , planilla_boni_concepto
					where mesanio=right(@mesa,2)+left(@mesa,4)  and planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
						and  (codi_conc='200101' or codi_conc='300033') and tipo='M' and codi_pers=@pers and codi_unid_oper=@emb),0) 


			set @adm = isnull((select isnull(sum(isnull(valor,0)), 0) from planilla_de_tripulantes , planilla_tripulante_conceptos where mesanio=@mesa and planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
					and (codi_conc='301050') and codi_pers=@pers and codi_unid_oper=@emb) , 0 ) + isnull( (select isnull(sum(isnull(valor,0)),0) from planilla_boni_moto , planilla_boni_concepto
					where mesanio=right(@mesa,2)+left(@mesa,4)  and planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
						and  (codi_conc='301050' ) and tipo='M' and codi_pers=@pers and codi_unid_oper=@emb),0)
	

			set @sal = isnull((select isnull(sum(isnull(valor,0)), 0) from planilla_de_tripulantes , planilla_tripulante_conceptos where mesanio=@mesa and planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
					and (codi_conc='301051') and codi_pers=@pers and codi_unid_oper=@emb) , 0 ) + isnull( (select isnull(sum(isnull(valor,0)),0) from planilla_boni_moto , planilla_boni_concepto
					where mesanio=right(@mesa,2)+left(@mesa,4)  and planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
						and  (codi_conc='301051' ) and tipo='M' and codi_pers=@pers and codi_unid_oper=@emb),0)

		--	if (@afec='1')
		--	begin
				declare @por numeric(12,3)
				set @por = (select case when tipo_valo=0 then valor/100 else valor end from valores_unitarios_anuales where 
						codi_valo_unit in (select top 1 codi_valo_unit from conceptos_afectos_planillas where codi_conc='301051' ))

				if (@total1 <= @fact*@min) set @sal = @fact* @min*@por
				
		--	end
	
			set @sct = isnull((select isnull(sum(isnull(valor,0)), 0) from planilla_de_tripulantes , planilla_tripulante_conceptos where mesanio=@mesa and planilla_de_tripulantes.codi_plan_trip= planilla_tripulante_conceptos.codi_plan_trip
					and (codi_conc='300020' or codi_conc='300021') and codi_pers=@pers and codi_unid_oper=@emb) , 0 ) + isnull( (select isnull(sum(isnull(valor,0)),0) from planilla_boni_moto , planilla_boni_concepto
					where mesanio=right(@mesa,2)+left(@mesa,4)  and planilla_boni_moto.codi_plan_boni= planilla_boni_concepto.codi_plan_boni
						and  (codi_conc='300020' or codi_conc='300021') and tipo='M' and codi_pers=@pers and codi_unid_oper=@emb),0)

			insert into #Temporal (DNI , nombres , TotalBoni , TotalParticipacion , TotalRemu  ,	DiasPesca ,  CTS,  Vacaciones, Gratificaciones, embarcacion,Totalafec, quinta,
					pensiones ,  adminis ,  salud  ,  sctr )
				values (@dn, @nom, @boni,@par, @total,  @dias , @cts, @vaca, @grati, @nemb,@TOTAL1,@quin, @pen ,@adm , @sal ,@sct)
				
			Fetch C1 into @pers
		end
		close C1
		deallocate C1
		fetch c2 into @emb
	end
	close c2
	deallocate c2

	Select * , (Select top 1 razon_social from empresa) Empr From #temporal order by nombres
END
GO

CREATE PROCEDURE [dbo].[sp_camb_sali_mate]
	@codi_sali_inic [char](10),
	@codi_sali_nuev [char](10),
	@indi [varchar](250) OUTPUT
WITH EXECUTE AS CALLER
AS
--Campos de Cabecera
Declare @codi_unid_oper_rece char (5)
Declare @codi_tipo_docu_sali char (5)
Declare @CODI_ORDE_PEDI char (10)
Declare @CODI_PERS_EMIS char (5)
Declare @CODI_PERS_RECE char (5)
Declare @FECH_EMIS datetime
Declare @CODI_TURN char (2)
Declare @CODI_UNID_NEGO char (2)
Declare @CODI_CLIE_PROV char (5)
Declare @NRO_SERI_DOCU_SALI char (5)
Declare @NRO_DOCU_SALI char (10)
Declare @MOTIVO varchar (150)
Declare @OBSERVACION varchar (150)
Declare @TIPO_SALI varchar (20)
Declare @TIPO_DEST char (2)
Declare @CODI_PERS_RECI_MATE char (5)
Declare @MOTI_SALI char (10)
Declare @CODI_PUER_SALI char (2)
--Fin campos de  cabecera
--Campos del Detalle
Declare @CODI_DETA_DOCU_SALI char (12)
Declare @NRO_CUEN char (7)
Declare @CODI_PROD char (8)
Declare @CANTIDAD numeric(10,4)
Declare @PREC_PROM decimal(12,4)
Declare @STOC_SALI decimal(12,4)
Declare @FECH_ULTI_SALI datetime
Declare @CANT_ULTI_SALI decimal(12,4)
Declare @CODI_ORDE_PEDI_d char (10)
--Fin Campos del Detalle
Declare @CODI_ORDE_PEDI_op char (10)
Declare @codi_proy char (10)
Declare @CODI_sali_mate char (10)
Declare @ESTADO char (1)


Declare @cont_cabe1 integer
Declare @cont_cabe2 integer
Declare @cont_cabe3 integer
Declare @cont_deta1 integer
Declare @cont_deta1c as char(2)
Declare @cont_deta2 integer
Declare @cont_op1 integer
Declare @cont_op2 integer
Declare @cont_sp1 integer
Declare @cont_sp2 integer
Declare @cont_sm1 integer
Declare @cont_sm2 integer

Declare @indi1 as varchar(200)
Declare @indi2 as varchar(200)
Declare @indi3 as varchar(200)
Declare @indi4 as varchar(200)

--set @codi_sali_inic = replicate( '0', 10 - len(@codi_sali_inic) ) +  @codi_sali_inic
set @codi_sali_nuev = replicate( '0', 10 - len(@codi_sali_nuev) ) +  @codi_sali_nuev
set @indi = ''
set @indi1 = ''
set @indi2 = ''
set @indi3 = ''
set @indi4 = ''
Select @cont_cabe1 = count(codi_docu_sali) from docu_sali_mate where codi_docu_sali = @codi_sali_inic;
if @cont_cabe1 > 0 
begin
	Select @cont_cabe2 = count(codi_docu_sali) from docu_sali_mate where codi_docu_sali = @codi_sali_nuev;
	if @cont_cabe2 <= 0 
	begin
		Select @codi_unid_oper_rece = codi_unid_oper_rece , @codi_tipo_docu_sali = codi_tipo_docu_sali , @CODI_ORDE_PEDI = CODI_ORDE_PEDI,
		           @CODI_PERS_EMIS = CODI_PERS_EMIS, @CODI_PERS_RECE = CODI_PERS_RECE, @FECH_EMIS = FECH_EMIS, @CODI_TURN = CODI_TURN,
		           @CODI_UNID_NEGO = CODI_UNID_NEGO, @CODI_CLIE_PROV = CODI_CLIE_PROV, @NRO_SERI_DOCU_SALI = NRO_SERI_DOCU_SALI,
		           @NRO_DOCU_SALI = NRO_DOCU_SALI, @MOTIVO = MOTIVO, @OBSERVACION = OBSERVACION, @TIPO_SALI = TIPO_SALi,
		           @TIPO_DEST = TIPO_DEST, @CODI_PERS_RECI_MATE = CODI_PERS_RECI_MATE, @MOTI_SALI = MOTI_SALI, @codi_puer_sali = codi_puer_sali,
		           @ESTADO = ESTADO
		from Docu_sali_mate
		where codi_docu_sali = @codi_sali_inic;
		
		Insert Into Docu_sali_mate (codi_docu_sali, codi_unid_oper_rece , codi_tipo_docu_sali , CODI_ORDE_PEDI, CODI_PERS_EMIS, CODI_PERS_RECE, FECH_EMIS, 
			CODI_TURN, CODI_UNID_NEGO, CODI_CLIE_PROV, NRO_SERI_DOCU_SALI, NRO_DOCU_SALI, MOTIVO, OBSERVACION, TIPO_SALi,
		           TIPO_DEST, CODI_PERS_RECI_MATE, MOTI_SALI, codi_puer_sali , ESTADO)
		values ( @codi_sali_nuev, @codi_unid_oper_rece , @codi_tipo_docu_sali , @CODI_ORDE_PEDI, @CODI_PERS_EMIS, @CODI_PERS_RECe,
			@FECH_EMIS, @CODI_TURN, @CODI_UNID_NEGO, @CODI_CLIE_PROV, @NRO_SERI_DOCU_SALI, @NRO_DOCU_SALI, @MOTIVO, 
			@OBSERVACION, @TIPO_SALi, @TIPO_DEST, @CODI_PERS_RECI_MATE, @MOTI_SALI, @codi_puer_sali, @ESTADO)

		Select @cont_cabe3 = count(codi_docu_sali) from docu_sali_mate where codi_docu_sali = @codi_sali_nuev;
		if @cont_cabe3 > 0 	
		begin
			set @cont_deta1 = 0
			Declare Curs_carg_deta_docu_sali_mate cursor for
			Select NRO_CUEN, CODI_PROD, CANTIDAD, PREC_PROM, STOC_SALI, FECH_ULTI_SALI, CANT_ULTI_SALI, CODI_ORDE_PEDI
			from detalle_docu_sali where codi_docu_sali = @codi_sali_inic;
			Open Curs_carg_deta_docu_sali_mate;
			Fetch Curs_carg_deta_docu_sali_mate 
			Into @nro_cuen, @CODI_PROD, @cantidad, @prec_prom, @stoc_sali, @fech_ulti_sali, @CANT_ULTI_SALI, @codi_orde_pedi_d
			while @@fetch_status = 0
			begin
				set @cont_deta1 = @cont_deta1 + 1
				set @cont_deta1c = cast ( @cont_deta1 as char(2) )
				set @cont_deta1c = replicate('0', 2 - len ( @cont_deta1c ) ) + @cont_deta1c 
				set @codi_deta_docu_sali = @codi_sali_nuev + @cont_deta1c 

				Insert Into Detalle_docu_sali (codi_deta_docu_sali, codi_docu_sali, NRO_CUEN, CODI_PROD, CANTIDAD, PREC_PROM, 
					STOC_SALI, FECH_ULTI_SALI, CANT_ULTI_SALI, CODI_ORDE_PEDI )
				Values ( @codi_deta_docu_sali , @codi_sali_nuev, @NRO_CUEN, @CODI_PROD, @CANTIDAD, @PREC_PROM, 
					@STOC_SALI, @FECH_ULTI_SALI, @CANT_ULTI_SALI, @CODI_ORDE_PEDI_d)
				
				Select @cont_deta2 = count(codi_docu_sali) from detalle_docu_sali where codi_deta_docu_sali = @codi_deta_docu_sali;
				if @cont_deta2 = 0 
				begin
					if @indi1 = ''
					begin
						set @indi1 = 'No se pudo Insertar en el Detalle el prod. con código: ' + @codi_prod
					end
					else
					begin	
						set @indi1 = @INDI1 + ', ' + @codi_prod
					end
				end
				Fetch Curs_carg_deta_docu_sali_mate 
				Into @nro_cuen, @CODI_PROD, @cantidad, @prec_prom, @stoc_sali, @fech_ulti_sali, @CANT_ULTI_SALI, @codi_orde_pedi_d;				
			end
			Close Curs_carg_deta_docu_sali_mate ;
			Deallocate Curs_carg_deta_docu_sali_mate ;
			set @indi = @indi + ' ' + @indi1
			if @indi1 = '' 
			begin
				delete from detalle_docu_sali where codi_docu_sali = @codi_sali_inic;			
			end			
			
			Select @cont_op1 = count( codi_orde_pedi) from docu_sali_x_orde_pedi where codi_docu_Sali = @codi_sali_inic;
			if @cont_op1 > 0 
			begin
				Declare Curs_carg_orde_pedi_ds cursor for Select codi_orde_pedi from docu_sali_x_orde_pedi 
				where codi_docu_Sali = @codi_sali_inic;
				Open Curs_carg_orde_pedi_ds ;
				Fetch Curs_carg_orde_pedi_ds into @codi_orde_pedi_op
				while @@fetch_status = 0
				begin
					Insert Into docu_sali_x_orde_pedi ( codi_docu_sali, codi_orde_pedi)
					values ( @codi_sali_nuev, @codi_orde_pedi_op )
					Select @cont_op2 = count( codi_orde_pedi) from docu_sali_x_orde_pedi 
					where codi_docu_Sali = @codi_sali_nuev and codi_orde_pedi = @codi_orde_pedi_op ;
					if @cont_op2 <= 0 
					begin
						if @indi2 = '' 
						begin
							set @indi2 = 'No se pudo Insertar  a la Salida la Orden de Pedido con código : ' + @codi_orde_pedi_op
						end
						else
						begin
							set @indi2 = @indi2 + ', ' + @codi_orde_pedi_op
						end							
						
					end
					Fetch Curs_carg_orde_pedi_ds into @codi_orde_pedi_op
				end
				Close Curs_carg_orde_pedi_ds ;
				deallocate Curs_carg_orde_pedi_ds ;
				set @indi = @indi + ' ' + @indi2
				if @indi2 = ''
				begin
					Delete from docu_sali_x_orde_pedi where codi_docu_sali = @codi_sali_inic;										
				end
					
			end
			
			Select @cont_sp1 = count( codi_docu_sali) from sali_mate_x_proy where codi_docu_Sali = @codi_sali_inic;
			if @cont_sp1 > 0 
			begin
				Declare Curs_carg_proy_sali cursor for Select codi_proy from sali_mate_x_proy 
				where codi_docu_Sali = @codi_sali_inic;
				Open Curs_carg_proy_sali ;
				Fetch Curs_carg_proy_sali into @codi_proy
				while @@fetch_status = 0
				begin
					Insert Into sali_mate_x_proy ( codi_docu_sali, codi_proy )
					values ( @codi_sali_nuev, @codi_proy )
					Select @cont_sp2 = count( codi_docu_sali) from sali_mate_x_proy 
					where codi_docu_Sali = @codi_sali_nuev and codi_proy = @codi_proy ;
					if @cont_sp2 <= 0 
					begin
						if @indi3 = '' 
						begin
							set @indi3 = 'No se pudo Insertar a la Salida el Proyecto con código : ' + @codi_proy
						end
						else
						begin
							set @indi3 = @indi3 + ', ' + @codi_proy
						end							
						
					end
					
					Fetch Curs_carg_proy_sali into @codi_proy
				end
				close Curs_carg_proy_sali ;
				deallocate Curs_carg_proy_sali ;
				set @indi = @indi + ' ' + @indi3
				if @indi3 = ''
				begin
					Delete from sali_mate_x_proy where codi_docu_sali = @codi_sali_inic;										
				end
			end
			
			Select @cont_sm1 = count( codi_docu_sali) from Sali_mate_x_docu_sali where codi_docu_Sali = @codi_sali_inic;
			if @cont_sm1 > 0 
			begin
				Declare Curs_carg_sali_mate_sali cursor for Select codi_docu_sali_mate from Sali_mate_x_docu_sali 
				where codi_docu_Sali = @codi_sali_inic;
				Open Curs_carg_sali_mate_sali ;
				Fetch Curs_carg_sali_mate_sali into @CODI_sali_mate
				while @@fetch_status = 0
				begin
					Insert Into Sali_mate_x_docu_sali ( codi_docu_sali, codi_docu_sali_mate )
					values ( @codi_sali_nuev, @CODI_sali_mate )
					Select @cont_sm2 = count( codi_docu_sali) from Sali_mate_x_docu_sali 
					where codi_docu_Sali = @codi_sali_nuev and codi_docu_sali_mate = @CODI_sali_mate ;
					if @cont_sm2 <= 0 
					begin
						if @indi4 = '' 
						begin
							set @indi4 = 'No se pudo Insertar a la Salida La Salida de Material con código : ' + @CODI_sali_mate
						end
						else
						begin
							set @indi4 = @indi4 + ', ' + @CODI_sali_mate
						end							
						
					end
					
					Fetch Curs_carg_sali_mate_sali into @CODI_sali_mate
				end
				close Curs_carg_sali_mate_sali ;
				deallocate Curs_carg_sali_mate_sali ;
				set @indi = @indi + ' ' + @indi4
				if @indi4 = ''
				begin
					Delete from Sali_mate_x_docu_sali where codi_docu_sali = @codi_sali_inic;										
				end
			end			
			if @indi1 = '' and @indi2 = '' and @indi3 = '' and @indi4 = '' 
			begin 
				delete from docu_sali_mate where codi_docu_sali = @codi_sali_inic;
			end
		end
		else
		begin
			set @indi = 'La Salida de Material Nueva no se pudo Insertar, Verifique los Datos por Favor'
		end		
		
	end
	else
	begin
		set @indi = 'La Salida de Material Nueva ya existe, Ingrese otro Núemro de Salida de Material'
	end	
end
else
begin
	set @indi = 'La Salida de Material a Cambiar no existe'
end

create table #indi(indi varchar(250) null)

Insert Into #indi (indi ) values (@indi)
Select * from #indi
--Docu_sali_mate
--Detalle_docu_Sali
--docu_sali_x_orde_pedi
--sali_mate_x_proy
--Sali_mate_x_docu_sali
GO

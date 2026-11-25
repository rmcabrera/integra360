CREATE TRIGGER [dbo].[MC_ni_Delete] ON [dbo].[Movi_Contables] 
FOR DELETE 
AS
	Declare @subdia char(1)
	--NI - Logistica de SUMINISTROS
	Declare @CODI_NOTA_INGR CHAR(10)
	--NI - Logistica de SUMINISTROS
	Declare @Codi_Ingr		NUMERIC
	Declare @Codi_Alma		CHAR(2)
	Declare @Tipo_Pago		varchar(10)
	Declare @cont int	
	Declare @Anio char(4)	
	declare @regis varchar(11)

--SOLO SE HACE PARA EL SUBDIA C porque para el subdia A (automatico) se hace mediante el generar automatico del libro diario

------------------- Para restaurar el campo Prov_Canc en '0' de la tabla Factura y Caja Chica y poder volver generar la Provisión 
-------------------  de los pagos en efectivo o a crédito.
declare CDelete cursor for Select	codi_nota_ingr	,Codi_Ingr,Codi_Alma,subdia,	 nro_orde_pedi, anio, registro 
From Deleted
open cDelete
fetch CDelete into @CODI_NOTA_INGR ,@Codi_Ingr, @Codi_Alma,@subdia, @Tipo_Pago, @anio , @regis 
while @@FETCH_STATUS=0 
begin
	
	if @subdia = 'C'
	   Begin
	
		IF NOT ((@CODI_NOTA_INGR IS NULL) 	or rtrim(ltrim(@codi_nota_ingr))= '')-- SUMINISTROS
		     Begin
			if ltrim(rtrim(@tipo_pago))='C'
			begin
				select @cont=isnull(count(codi_nota_ingr),0) from movi_contables (nolock) where anio=@anio and codi_nota_ingr=rtrim(@codi_nota_ingr)
				if @cont=0
				begin
					update caja_chica set prov_canc='0' where nro_recibo=rtrim(@codi_nota_ingr)
				end
			end
			Else
			begin
				if isnumeric(@codi_nota_ingr)=1
					Update Nota_Ingreso Set contab = 0 Where cast(codi_nota_ingr as numeric) = @codi_nota_ingr
				else
					Update Nota_Ingreso Set contab = 0 Where rtrim(codi_nota_ingr) = rtrim(@codi_nota_ingr)
			end
		     End
/*		ELSE
		     Begin						-- MATERIAS PRIMAS Y AUXILIARES
			Update Nota_Ingreso_Aceite  Set contabilizado = 0 where codi_ingr = @codi_ingr and  codi_alma = @codi_alma
		     End*/
	   End
	if @Subdia='M'
	Begin
		if not ((@codi_nota_ingr is null ) or rtrim(ltrim(@codi_nota_ingr))= '')
		begin
			if rtrim(ltrim(@Tipo_Pago))='E'
			begin
				update factura set prov_canc='0' where codi_fact=@codi_nota_ingr
			end
			if rtrim(ltrim(@Tipo_Pago))='C'
			begin
				
				update caja_chica set prov_canc='0' where nro_recibo=rtrim(@codi_nota_ingr)
			end
			if rtrim(ltrim(@Tipo_Pago))='M'
			begin
				select @cont=isnull(count(codi_nota_ingr),0) from movi_contables (nolock) where anio=@anio and codi_nota_ingr=rtrim(@codi_nota_ingr)
				if @cont>0
				begin
					update caja_chica set prov_canc='0' where nro_recibo=rtrim(@codi_nota_ingr)
				end
			end
			
			--Update Nota_Ingreso Set contab = 0 Where cast(codi_nota_ingr as numeric) = @codi_nota_ingr
			
		end	

	end

	if @subdia='L' 
	begin
		delete LETRAS_PRODUCTOS where registro=@regis
	end

	fetch CDelete into @CODI_NOTA_INGR ,@Codi_Ingr, @Codi_Alma,@subdia, @Tipo_Pago, @anio, @regis 
end
close CDelete
deallocate CDelete
GO

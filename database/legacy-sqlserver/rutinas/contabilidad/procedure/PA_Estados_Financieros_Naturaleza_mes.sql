CREATE PROCEDURE [dbo].[PA_Estados_Financieros_Naturaleza_mes]
	@fecha [smalldatetime]
WITH EXECUTE AS CALLER
AS
Declare
	@anio 	char (4),
	@mes 	char(2),
	@id	tinyint		


Create Table #Tempo
	( Ide		tinyint not null,
	  Desc_Ide	varchar(150) null, --descripcion del grupo ESTADOS_FINANCIEROS
	  Cod   	varchar (3) not null,
	  Descripcion	varchar(100) not null,
	  Monto		decimal (18,2) not null,
	  Orden		tinyint null		--orden dentro del grupo ESTADOS_FINANCIEROS_DETALLE
      	)

set @anio = cast(  year(@fecha) as char(4) ) 
set @mes  = replicate ('0', 2 - len (cast(  month(@fecha) as varchar(2) ))  ) + cast(  month(@fecha) as varchar(2) )  

Declare Cursor_TIPO cursor for 
	select id	from ESTADOS_FINANCIEROS	where Tipo = 2
   open Cursor_TIPO
   fetch Cursor_TIPO into @id
	WHILE @@FETCH_STATUS = 0
	      begin	
		INSERT INTO #Tempo (Ide, Desc_Ide, Cod, Descripcion, monto,orden)
		Select 	@ID , (Select Descripcion From Estados_Financieros where id = @ID ),
			left(MC.nro_cuen,2) as Cod	,
		       	(Select desc_clas_cuen From Clases_Cuentas Where codi_clas_cuen = left(MC.nro_cuen,2)) as Descripcion,	
		       	sum(case cargo_abono when 'A' then importe else -1*importe end) as monto,
			(Select orden From estados_financieros_detalle where id = @ID  and nro_cuen = left(MC.nro_cuen,2)) as Orden
		from 	movi_contables MC
		where 	MC.anio= @ANIO and MC.mes=@MES and MC.subdia <>'X' and 
			left(MC.nro_cuen,2) in (Select nro_cuen from estados_financieros_detalle where id = @ID ) 
			AND left(MC.nro_cuen,2) NOT in ('71','69')			
		Group by left(MC.nro_cuen,2)
		UNION
		Select 	@ID , (Select Descripcion From Estados_Financieros where id = @ID ),
			left(MC.nro_cuen,3) as Cod	,
		       	(Select desc_subc 	From Sub_Clas_Cuen Where codi_subc = left(MC.nro_cuen,3)) as Descripcion,	
		       	sum(case cargo_abono when 'A' then importe else -1*importe end) as monto,
			(Select orden From estados_financieros_detalle where id = @ID  and nro_cuen = left(MC.nro_cuen,3)) as Orden
		from 	movi_contables MC
		where 	MC.anio=@ANIO and MC.mes = @MES and MC.subdia <>'X' and 
			left(MC.nro_cuen,3) in (Select nro_cuen from estados_financieros_detalle where id = @ID )
			AND left(MC.nro_cuen,2) NOT in ('71','69')
		Group by left(MC.nro_cuen,3)



		--SUMA	left(MC.nro_cuen,2) in ('71','69')
		if @ID = 4 --PRODUCCION DEL JERCICIO
		   Begin
			INSERT INTO #Tempo (Ide, Desc_Ide, Cod, Descripcion, monto,orden)
			Select 	4 , (Select Descripcion From Estados_Financieros where id = @ID ),
				'00' as Cod,
			       	'PRODUCCIÓN ALMACENADA' as Descripcion,	
			       	sum(case cargo_abono when 'A' then importe else -1*importe end) as monto,
				2	 as Orden
			from 	movi_contables MC
			where 	MC.anio= @ANIO and MC.mes=@MES and MC.subdia <>'X' and 
				left(MC.nro_cuen,2) in ('71','69')			

		    end	
		fetch Cursor_TIPO into @ID 
	      end 
    close Cursor_TIPO 
    deallocate Cursor_TIPO 



	Select T.Ide,T.Desc_Ide,T.Cod ,T.Descripcion,T.Monto,T.Orden	
	From #Tempo T inner join ESTADOS_FINANCIEROS EF on EF.ID = T.ide
	order by EF.Orden, t.ORDEN
GO

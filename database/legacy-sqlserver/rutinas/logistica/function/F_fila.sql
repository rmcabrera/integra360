CREATE FUNCTION [dbo].[F_fila](@i [tinyint], @codi_orde_produc [int])
RETURNS [varchar](248) WITH EXECUTE AS CALLER
AS 
BEGIN 

Declare @rt varchar(245)



Declare @Descripcion 	varchar(200),
	@Observaciones	varchar(50),
	@linea1		varchar(245),
	@linea2		varchar(245),
	@linea3		varchar(245),
	@linea4		varchar(245)
	


	--DESCRIPCION
	Select @linea1 = descripcion + case when observaciones is null or len(ltrim(rtrim(observaciones)))= 0 then '' else ', ' + observaciones end
	From Orden_Produccion 	where codi_orde_produc = @codi_orde_produc	
	--select @linea1


	--MATERIAL
	Declare @desc_material  varchar(200),
		@otro_material  varchar(50),
		@mate_aux	varchar(50)		

	set @otro_material = (select otro_material from orden_produccion where codi_orde_produc = @codi_orde_produc )
	set @desc_material	= ''
	declare C1 cursor for Select p.desc_material  From orden_produc_deta_material  op inner join material p on p.codi_material = op.codi_prod where codi_orde_produc = @codi_orde_produc
	open C1
	fetch C1 into @mate_aux
	while (@@FETCH_STATUS=0)
	     begin
		set @desc_material = @desc_material + @mate_aux + ', ' 
   		fetch C1 into @mate_aux
	     end
	close C1
	deallocate C1
	set @desc_material = rtrim(ltrim(@desc_material))
	if len(@desc_material) > 1
	   begin
		set @desc_material = substring( @desc_material, 1 , len(@desc_material) - 1 )
	   end
	set @linea2 =  case 
			when @desc_material =''  and (@otro_material is null 	 or len(rtrim(ltrim(@otro_material)))= 0) then ''
			when @desc_material =''  and (@otro_material is not null or len(@otro_material)>= 1 		) then 'MATERIAL: ' + @otro_material
			when @desc_material <>'' and (@otro_material is null 	 or len(rtrim(ltrim(@otro_material)))= 0) then 'MATERIAL: ' + @desc_material
			when @desc_material <>'' and (@otro_material is not null or len(@otro_material)>= 1 		) then 'MATERIAL: ' + @desc_material + ' - '+ @otro_material
			end
	--select @linea2


	--ACABADO
	Declare @desc_ACABADO  	varchar(200),
		@Otros_Acabado  varchar(50),
		@acab_aux	varchar(50)		

	set @otros_acabado = (select otros_acabado from orden_produccion where codi_orde_produc = @codi_orde_produc )
	set @desc_acabado	= ''
	declare C2 cursor for Select p.desc_acab  From orden_produc_deta_acabado  op inner join acabado p on p.codi_acab = op.codi_acab where codi_orde_produc = @codi_orde_produc
	open C2
	fetch C2 into @acab_aux
	while (@@FETCH_STATUS=0)
	     begin
		set @desc_acabado = @desc_acabado + @acab_aux + ', ' 
   		fetch C2 into @acab_aux
	     end
	close C2
	deallocate C2
	set @desc_acabado = rtrim(ltrim(@desc_acabado)) 
	if len(@desc_acabado) > 1
	   begin
		set @desc_acabado = substring( @desc_acabado, 1 , len(@desc_acabado) - 1 )
	   end
	set @linea3 =  case 
			when @desc_acabado =''  and (@otros_acabado is null 	 or len(rtrim(ltrim(@otros_acabado)))= 0)  then ''
			when @desc_acabado =''  and (@otros_acabado is not null 	 or len(@otros_acabado)>= 1 		) then 'ACABADO: ' + @otros_ACABADO
			when @desc_acabado <>'' and (@otros_acabado is null 	 or len(rtrim(ltrim(@otros_acabado)))= 0)  then 'ACABADO: ' + @desc_ACABADO
			when @desc_acabado <>'' and (@otros_acabado is not null   or len(@otros_acabado)>= 1 		) then 'ACABADO: ' + @desc_ACABADO + ' - '+ @otros_ACABADO
			end
	--select @linea3





	--COLOR
	Declare @desc_COLOR  	varchar(175),
		@TAMANO		varchar(70),
		@color_aux	varchar(50)		

		--tamano
		declare @um   	varchar(5),
			@tama 	varchar(40),
			@tp1	varchar(30),
			@t1 	decimal(9,2),
			@t2 	decimal(9,2)

		select  @t1 = tama1 , 
			@t2 = tama2 , 
			@um = (select um.SIMB_UNID_MEDI from unidad_medida um where um.codi_unid_medi =  codi_unid_medit )  ,
			@tama = tama
		from orden_produccion
		where codi_orde_produc = @codi_orde_produc

		if @t1 <> 0  
		   begin
			set @tp1 =  cast(@t1 as varchar(8)) + ' x ' + cast(@t2 as varchar(8)) +' ' + @um
		   end


		if @tama is not null or len(rtrim(ltrim(@tama))) >= 1  
		   begin
			set @tamano = @tp1 + ', '  +@tama
		   end
		else
		   begin
			set @tamano = @tp1
		   end


	set @desc_color	= ''
	declare C2 cursor for Select p.desc_color  From orden_produc_deta_color  op inner join color p on p.codi_color = op.codi_color where codi_orde_produc = @codi_orde_produc
	open C2
	fetch C2 into @color_aux
	while (@@FETCH_STATUS=0)
	     begin
		set @desc_color = @desc_color + @color_aux + ', ' 
   		fetch C2 into @color_aux
	     end
	close C2
	deallocate C2
	set @desc_color = rtrim(ltrim(@desc_color)) 
	if len(@desc_color) > 1
	   begin
		set @desc_color = substring( @desc_color, 1 , len(@desc_color) - 1 )
	   end
	set @linea4 =  case 
			when @desc_color =''  and (@tamano is null 	 or len(rtrim(ltrim(@tamano)))= 0)  	then ''
			when @desc_color =''  and (@tamano is not null 	 or len(@tamano)>= 1 		) 	then 'TAMAÑO: ' + @tamano
			when @desc_color <>'' and (@tamano is null 	 or len(rtrim(ltrim(@tamano)))= 0)  	then 'COLOR: ' + @desc_ACABADO
			when @desc_color <>'' and (@tamano is not null   or len(@tamano)>= 1 		) 	then 'COLOR: ' + @desc_ACABADO + 'TAMAÑO: ' + @tamano
			end
	--select @linea4


	if @i = 1
	   begin 
		set @rt = @linea1 
	   end
	if @i = 2 
	   begin 
		set @rt = @linea2	
	   end
	if @i = 3 
	   begin 
		set @rt = @linea3 
	    end
	if @i = 4 
	   begin 
		set @rt = @linea4 
	   end
	
	return @rt

END
GO

CREATE PROCEDURE [dbo].[sp_actu_regi_por_cuen_subd]
	@cuenta [char](7),
	@mes [char](2),
	@anio [char](4),
	@subdia [char](1)
WITH EXECUTE AS CALLER
AS
Declare @codi_cont char(10)
Declare @maxi_regi char(8)
Declare @maxi_regi_inic char(8)
Declare @maxi_regi_nume integer
Declare @maxi_regi_nume_char char(8)
Declare @registro char(10)

Declare Curs_carg_cuen_actu Cursor for
Select codi_contable from movi_contables 
where nro_cuen = @cuenta and mes = @mes and anio = @anio and subdia = @subdia
and ( registro = '0' or left( registro , 4 ) = 'FINC' or registro  is null )
order by fecha, nro_docu;
Open Curs_carg_cuen_actu ;
Fetch Curs_carg_cuen_actu into @codi_cont;
while @@fetch_status = 0
begin
	print @codi_cont
	set @maxi_regi_inic = right(@anio,1 ) + @mes + @subdia
	Select @maxi_regi = isnull( Max( registro ) , '0' ) from movi_contables 
	where mes = @mes and anio = @anio and subdia = @subdia and left( registro , 1) = right ( @anio,1 ) ;
--	print @maxi_regi 
	if rtrim( ltrim( @maxi_regi )) = '' begin set @maxi_regi = '0' end	
	if @maxi_regi = '0'
	begin
		set @maxi_regi_nume =  cast( @maxi_regi as integer ) + 1  
		set @maxi_regi_nume_char = replicate ( '0', 4 - len( cast( @maxi_regi_nume  as char) ) ) + cast( @maxi_regi_nume as char )
		set @registro = left( @maxi_regi_inic , 4 ) + left( @maxi_regi_nume_char , 4 ) 
		/*print 'a'
		print @maxi_regi 
		print @maxi_regi_nume
		print @maxi_regi_nume_char
		print @registro*/
		Update movi_contables 
		set registro = @registro 
		from movi_contables 
		where codi_contable = @codi_cont;
	end
	else
	begin
		set @maxi_regi = substring( @maxi_regi , 5, 6)
		if rtrim( ltrim( @maxi_regi )) = '' begin set @maxi_regi = '0' end	
		
		set @maxi_regi_nume =  cast( @maxi_regi as integer ) + 1  
		set @maxi_regi_nume_char = replicate ( '0', 4 - len( cast( @maxi_regi_nume  as char) ) ) + cast( @maxi_regi_nume as char )
		set @registro = left( @maxi_regi_inic , 4 ) + left( @maxi_regi_nume_char , 4 ) 
		/*print 'b'
		print @maxi_regi 
		print @maxi_regi_nume
		print @maxi_regi_nume_char
		print @registro*/

		Update movi_contables 
		set registro = @registro 
		from movi_contables 
		where codi_contable = @codi_cont;	
	
	end	
	Fetch Curs_carg_cuen_actu into @codi_cont;
	
end
close Curs_carg_cuen_actu ;
Deallocate Curs_carg_cuen_actu ;
GO

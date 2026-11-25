CREATE FUNCTION [dbo].[F_orde_pedi_sali](@codi_sali [char](10))
RETURNS [varchar](100) WITH EXECUTE AS CALLER
AS 
BEGIN 

	declare @orde_pedi_sali varchar(100)
	Declare @op char (10)
	Declare @nop char (10)
	Declare @tp char (1)
	declare @nro_op integer
	declare @cont integer
	Select @nro_op = isnull( count(codi_docu_sali) , 0 ) From Docu_sali_x_orde_pedi where codi_docu_sali = @codi_sali
	set @cont = 0
	if @nro_op > 0 
	begin
		Declare curs_carg_opsm Cursor for
		Select codi_orde_pedi From Docu_sali_x_orde_pedi where codi_docu_sali = @codi_sali;
		Open curs_carg_opsm;
		fetch next from curs_carg_opsm into @op;
		While @@fetch_status = 0
		begin
			set @cont = @cont + 1
			Select @nop = isnull(nro_orde_pedi , ' ') From Orden_de_pedido where codi_orde_pedi = @op;
			set @nop = cast( ( cast( @nop as decimal(10,0) ))  as char(10) )
			if @cont = 1
			begin
				set @orde_pedi_sali = @nop
			end
			else
			begin
				set @orde_pedi_sali = @orde_pedi_sali + ' - ' + @nop
			end
			fetch next from curs_carg_opsm into @op;
		end
		Close curs_carg_opsm;
		Deallocate curs_carg_opsm;
	end		
	else
	begin
		set @orde_pedi_sali = ''
	end
	
	return @orde_pedi_sali
END
GO

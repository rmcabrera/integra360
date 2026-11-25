CREATE FUNCTION [dbo].[F_sali_x_guia](@CODI_sali_mate [char](10))
RETURNS [varchar](30) WITH EXECUTE AS CALLER
AS 
BEGIN 
	DECLARE @RT VARCHAR(30)
	DECLARE @sm CHAR(10)
	declare @cont int
	set @cont = 0
	SET @RT = ''
	SET @sm = ''
	Declare curs_reco_sali_mate Cursor for
	Select codi_docu_sali 
	from sali_mate_x_docu_sali 
	where codi_docu_sali_mate = @CODI_sali_mate;
	Open curs_reco_sali_mate;
	fetch next from curs_reco_sali_mate into @SM;
	While @@fetch_status = 0
	begin
		set @cont = @cont + 1		
		if @cont = 1
		begin
			set @rt = cast( ( cast (@sm as numeric ) ) as varchar)
		end
		else
		begin
			set @rt = @rt + '-' + cast( ( cast (@sm as numeric ) ) as varchar)
		end
		fetch next from curs_reco_sali_mate into @SM;
	end
	CLOSE curs_reco_sali_mate;
	DEALLOCATE curs_reco_sali_mate;
	RETURN @rt
END
GO

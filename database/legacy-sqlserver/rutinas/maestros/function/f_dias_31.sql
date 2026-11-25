CREATE FUNCTION [dbo].[f_dias_31](@fi [datetime], @ff [datetime])
RETURNS [smallint] WITH EXECUTE AS CALLER
AS 
BEGIN 
	Declare @fech_auxi datetime
	Declare @fech_auxi2 datetime
	declare @indi bit
	declare @n31 smallint
	set @indi = 0
	set @fech_auxi = @fi
	set @n31 = 0
	while @indi = 0
	begin
		set @fech_auxi = dateadd(month, 1, @fech_Auxi)
		set @fech_auxi2 = dateadd(day, -1, @fech_Auxi)
		if @fech_auxi2 <= @ff
		begin
			if datepart(day, @fech_auxi2) = 31
			begin
				set @n31 = @n31 + 1
			end
		end		
		else
		begin
			set @indi = 1
		end
	end
	return @n31 
END
GO

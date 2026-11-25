CREATE FUNCTION [dbo].[F_Cont_Mov_h](@sd [char](1), @cuenta [char](7))
RETURNS [int] WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @rt int
	declare @cuen_1 char(7)
	declare @cuen_2 char(7)
	declare @cuen_3 char(7)
--	declare @cuen_4 char(7)

	Select @cuen_1 = cuenta1 from contabilizacion where subdiario = @sd
	Select @cuen_2 = cuenta2 from contabilizacion where subdiario = @sd
	Select @cuen_3 = cuenta4 from contabilizacion where subdiario = @sd
	--Select @cuen_4 = cuenta4 from contabilizacion where subdiario = @sd

	if left( @cuen_1 ,1) = left( @cuenta ,1) begin set @rt = 1 end
	if left(@cuen_2 , 5 ) = left( @cuenta , 5 ) begin set @rt = 2 end
	if left(@cuen_3 , 5) = left ( @cuenta , 5 ) begin set @rt = 3 end
	--if @cuen_4 = @cuenta begin  set @rt = 4 end

	return @rt
END
GO

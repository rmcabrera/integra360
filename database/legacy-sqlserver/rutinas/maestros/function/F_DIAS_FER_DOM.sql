CREATE FUNCTION [dbo].[F_DIAS_FER_DOM](@ani [varchar](4))
RETURNS [int] WITH EXECUTE AS CALLER
AS 
BEGIN 
	declare @ct int
	declare @I int
	declare @nd int
	declare @cd int
	declare @nmes1 numeric(4)
	declare @nmes2 numeric(2)
	declare @ma1 varchar(10)
	declare @ma2 varchar(10)
	declare @fec datetime
	declare @di varchar(2)
	declare @ms varchar(2)
	declare @an varchar(4)
	
	set @ct=1
	set @cd=0
	while (@ct<13)
	begin
		if ((@ct+1) <=12) 
		begin
			set @ma1= '01/'+replicate('0', 2 - len(convert(varchar(2),@ct)))+convert(varchar(2),@ct)+'/'+@ani
			set @ma2= '01/'+replicate('0', 2 - len(convert(varchar(2),@ct +1)))+convert(varchar(2),@ct+1)+'/'+@ani
			set @nd= DATEDIFF ( d , convert (datetime, @ma1), convert (datetime, @ma2) ) 						
		end
		else
		begin
			set @ma1= '01/'+replicate('0', 2 - len(convert(varchar(2),@ct)))+convert(varchar(2),@ct)+'/'+@ani
			set @ma2= '01/01/'+ cast(convert(numeric(4) ,@ani) +1 as varchar(4))
			set @nd= DATEDIFF ( d , convert (datetime, @ma1), convert (datetime, @ma2) ) 						
		end
		set @i=1
		while (@i<=@nd)
		begin
			set @fec= cast((replicate('0', 2 - len(convert(varchar(2),@i)))+convert(varchar(2),@i))+'/'+
				  (replicate('0', 2 - len(convert(varchar(2),@ct)))+convert(varchar(2),@ct))+'/'+@ani as datetime)
			if (upper(DATENAME(dw,@fec))='DOMINGO' or upper(DATENAME(dw,@fec))='SUNDAY') set @cd=@cd + 1 
			set  @i=@i +1
		end
		set @ct = @ct + 1
	end
	
	Declare C1 cursor for select dia, mes, anio from feriados where anio=@ani
	open C1
	fetch C1 into @di, @ms, @an
	WHILE @@FETCH_STATUS = 0
	begin	
		set @fec= cast(@di+'/'+@ms+'/'+@an as datetime)
		if (not (upper(DATENAME(dw,@fec))='DOMINGO' or upper(DATENAME(dw,@fec))='SUNDAY' )) set @cd=@cd + 1 
		fetch C1 into @di, @ms, @an
	end
	close C1
	deallocate C1
	
	return @cd
END
GO

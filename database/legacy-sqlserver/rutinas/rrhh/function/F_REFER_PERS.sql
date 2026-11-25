CREATE FUNCTION [dbo].[F_REFER_PERS](@PER [char](5))
RETURNS [varchar](300) WITH EXECUTE AS CALLER
AS 
BEGIN 
	DECLARE @RT varchar(300)
	DECLARE @V varchar(100)
	DECLARE @id int
	set @rt=''
	set @id=2	
	DECLARE C1 CURSOR FOR 	select rtrim(empresa) + space(4)+rtrim(cargo) + space(4)+ CONVERT(CHAR(10),fech_INIC,103) +' - '+ CONVERT(CHAR(10),fech_TERM,103) as  fit 
			from PERs_refe_labo where codi_pers=@per
	OPEN C1
	FETCH C1 INTO @V 
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @RT=@RT+@V +CHAR(13)
		FETCH C1 INTO @V 
	END
	CLOSE C1
	DEALLOCATE C1
	if ( len(@rt)>0)
	begin
		SET @RT= RTRIM(@RT)
		SET @RT= SUBSTRING(@RT,1,LEN(@RT) - 1)
	end 
	return  @RT
END
GO

CREATE FUNCTION [dbo].[F_DATOS_FAMILIA](@PER [char](5), @id [int])
RETURNS [varchar](300) WITH EXECUTE AS CALLER
AS 
BEGIN 
	DECLARE @RT VARCHAR(255)
	DECLARE @V VARCHAR(100)
	set @rt=''
	DECLARE C1 CURSOR FOR 	select nomb_1 +isnull(' '+nomb_2,'') + isnull(' '+apel_1,'')+ isnull(' '+apel_2,'')+ space(10)+ISNUll(convert(char(10),fech_naci ,103),'') as Nombres
		from derecho_habiente where codi_pers=@per and 
		(case when (tipo_rela='ESPOSA' OR tipo_rela='ESPOSO' OR tipo_rela='ESPOSO(A)' OR tipo_rela='CONVIVIENTE')  then 2
			when (tipo_rela='PADRE' or tipo_rela='MADRE') then 1 when (tipo_rela='HIJO(A)' OR tipo_rela='HIJA' OR tipo_rela='HIJO') then 3 end)=@id
	OPEN C1
	FETCH C1 INTO @V 
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @RT=@RT+@V +CHAR(13)
		FETCH C1 INTO @V 
	END
	CLOSE C1
	DEALLOCATE C1
	if(len(@rt)>0)
	begin
		SET @RT = RTRIM(@RT)
		SET @RT= SUBSTRING(@RT,1,LEN(@RT) - 1)
	end
	return @RT
END
GO

CREATE FUNCTION [dbo].[F_CTA_CTE_PERS](@PER [char](5))
RETURNS [varchar](300) WITH EXECUTE AS CALLER
AS 
BEGIN 
	DECLARE @RT VARCHAR(300)
	DECLARE @V VARCHAR(100)
	set @rt=''
	DECLARE C1 CURSOR FOR sELECT (select rtrim(nemo) from bancos B where b.codi_banc=C.codi_banc) +': '+nro_cta_cte	
				FROM CTA_CTE_PERSONAL c WHERE CODI_PERS=@PER and tipo_cta_cte = '02'
	OPEN C1
	FETCH C1 INTO @V 
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @RT=@RT+@V +' / '
		FETCH C1 INTO @V 
	END
	CLOSE C1
	DEALLOCATE C1
	if ( len(@rt)>0)
	begin
		SET @RT= RTRIM(@RT)
		SET @RT= SUBSTRING(@RT,1,LEN(@RT) - 1)
	end 
	RETURN @RT
END
GO

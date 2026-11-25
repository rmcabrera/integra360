CREATE PROCEDURE [dbo].[sp_carg_coti_unic_indi]
	@esta_coti [char](1),
	@codi_coti_unic_prov [char](10) OUTPUT,
	@CODI_coti_prov [char](10) OUTPUT,
	@Estado [char](1) OUTPUT,
	@Fech_coti_unic [datetime] OUTPUT
WITH EXECUTE AS CALLER
AS
Declare  @CODI_cu CHAR(10), @codi_cp char(10)
Declare @esta char (10)
Declare @fech_cu datetime
Declare @cont integer

CREATE TABLE #Coti_Unic_Pend
(Codi_coti_unic Char(10),  CODI_COTI_PROV char(10), ESTADO char(1), FECH_COTI_UNIC datetime)
Insert Into #Coti_Unic_Pend
SELECT CODI_COTI_UNIC_PROV, CODI_COTI_PROV, ESTADO, FECH_COTI_UNIC 
FROM COTIZACION_UNICA
Where Estado = @esta_coti

CREATE TABLE #Coti_Unic
(Codi_coti_unic Char(10),  CODI_COTI_PROV char(10), ESTADO char(1), FECH_COTI_UNIC datetime)

DECLARE curs_Agre_Coti CURSOR FOR 
SELECT CODI_COTI_UNIC, CODI_COTI_PROV, ESTADO, FECH_COTI_UNIC 
FROM #Coti_Unic_Pend
OPEN curs_Agre_Coti
FETCH NEXT FROM curs_Agre_Coti
INTO @codi_cu, @codi_cp, @esta, @fech_cu
WHILE @@FETCH_STATUS = 0
BEGIN
	   DECLARE curs_busq CURSOR FOR 
	   SELECT Count(codi_coti_unic)
	   FROM #Coti_Unic
	   Where  Codi_coti_unic = @codi_cu
	   OPEN curs_busq
	   FETCH NEXT FROM curs_busq INTO @cont
	   WHILE @@FETCH_STATUS = 0
	   BEGIN
		if @cont <= 0 
		   Begin
			insert Into #Coti_Unic (Codi_coti_unic, Codi_coti_prov, Estado, Fech_Coti_unic )
			Values (@codi_cu, @codi_cp, @esta, @fech_cu)
		   End
	         FETCH NEXT FROM curs_busq INTO @cont
	   END
	   CLOSE Curs_Busq
	   DEALLOCATE Curs_Busq
	   FETCH NEXT FROM curs_Agre_Coti
	   INTO @codi_cu, @codi_cp, @esta, @fech_cu
END
CLOSE curs_Agre_Coti
Select *
from #Coti_Unic
GO

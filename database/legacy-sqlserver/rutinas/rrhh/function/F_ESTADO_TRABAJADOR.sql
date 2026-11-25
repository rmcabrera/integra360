CREATE FUNCTION [dbo].[F_ESTADO_TRABAJADOR](@PERS [char](5), @HORAS [numeric](2, 0), @DIA [datetime], @MES [int], @INDI [char](1))
RETURNS [char](2) WITH EXECUTE AS CALLER
AS 
BEGIN 
	DECLARE @RT CHAR(2)
	DECLARE @SL CHAR(5)
	DECLARE @DD VARCHAR(15)	
	DECLARE @fech_inic AS DATETIME
	DECLARE @ULTI INTEGER
	DECLARE @cg INTEGER
	DECLARE @FERI INTEGER
	declare @fech_ic datetime
	SET @DD=DATENAME (WEEKDAY , @DIA)
	set @fech_inic = convert( datetime , ('01/' + CAST ( @MES AS CHAR(2) ) + '/' + (cast(YEAR(@DIA) as char(4))) ) , 103)
	SET @FECH_INIC = DATEADD(MONTH,1, @FECH_INIC)
	SET @FECH_INIC = DATEADD(DAY,-1, @FECH_INIC)
	IF @INDI = 'Q' 
	BEGIN
		SET @ULTI = 15
	END
	ELSE
	BEGIN
		SET @ULTI = DATEPART(DAY, @FECH_INIC)
	END

	SET @FERI = (SELECT COUNT(MES) FROM FERIADOS WHERE MONTH(@DIA) = CAST( MES AS INTEGER ) AND DAY( @DIA) = CAST( DIA AS INTEGER ) 
			AND YEAR( @DIA) = CAST( ANIO AS INTEGER ))

	IF ( MONTH(@DIA) = @MES)
	BEGIN
		IF (DAY(@DIA) <= @ULTI)
		BEGIN
			IF (@HORAS>0 )
			BEGIN
				SET @RT=CONVERT(CHAR(2),@HORAS)
			END
			ELSE
			BEGIN
				IF (UPPER(@DD)<>'DOMINGO') 
				BEGIN			
					IF (@FERI <= 0 ) 
					BEGIN
						SELECT @SL=CODI_PERS FROM VACACIONES WHERE CODI_PERS=@PERS AND
							(@DIA BETWEEN FECH_INIC AND FECH_TERM)
						IF(@SL<>'' AND NOT (@SL IS NULL)) 
						BEGIN
							SET @RT='V'
						END
						ELSE
						BEGIN
							SELECT @SL=CODI_TIPO_LICE FROM LICENCIAS_POR_PERSONAL  WHERE CODI_PERS=@PERS AND
							(@DIA BETWEEN FECH_INIC AND FECH_TERM) 
							IF(@SL<>'' AND NOT (@SL IS NULL)) 
							BEGIN
								IF @SL = '003' 
								BEGIN
									SELECT @cg = GOCE_HABE FROM LICENCIAS_POR_PERSONAL  WHERE CODI_PERS=@PERS AND
										(@DIA BETWEEN FECH_INIC AND FECH_TERM)
									if @cg = 1 begin SET @RT='PG' end
									if @cg = 0 begin SET @RT='PS' end
								END
								ELSE
								BEGIN								
									IF @SL = '004' 
									BEGIN
										SET @RT='S'
									END
									ELSE
									begin
										IF @SL = '001'
										BEGIN
											SET @RT='D'
										END
										ELSE
										begin
											IF @SL = '005'
											BEGIN
												SET @RT='E'
											END
											ELSE
											BEGIN
												IF @SL = '006'
												BEGIN
													SET @RT='CT'
												end
												else
												begin
													SET @RT='L'
												end
											END
												
										end
									end
								END
							END
							ELSE
							BEGIN
								SELECT @fech_ic = FECH_CESE  FROM PERSONAL WHERE CODI_PERS=@PERS 									
								IF (@dia > @fech_ic )  SET @RT='C'
								ELSE 
								begin
									SELECT @fech_ic = FECH_INGRE  FROM PERSONAL WHERE CODI_PERS=@PERS 
									IF (@dia < @fech_ic )  SET @RT=''
									else SET @RT='F'
								end								
								
							END
				
						END
					END
					ELSE 	SET @RT=''	
				END
				ELSE 	SET @RT=''	
			END
		END
		ELSE 	SET @RT=''
	END
	ELSE SET @RT=''
	RETURN @RT
END
GO

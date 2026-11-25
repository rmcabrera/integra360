CREATE TRIGGER [dbo].[KA_Insert] ON [dbo].[KARDEX_ALMACENES] 
FOR INSERT
AS
	Declare @i_o		char(1)
	Declare @analisis	tinyint 
	Declare @codi_prod	char(8)

	Select @i_o = i_o, @codi_prod = codi_prod From Inserted
	set @analisis 	=(select analisis from productos where codi_prod = @codi_prod)
	
	If @i_o = 'I' 
	   Begin
		--si requiere analisis
		If @analisis = 1 
		  Begin
			Insert Analisis_Aceite ( Codi_ingr , codi_alma , item , codi_prod , i_o, Condicion)
			Select codi_transa, codi_alma,item,codi_prod,i_o, 0 
			From Inserted
		   End 
	   End
GO

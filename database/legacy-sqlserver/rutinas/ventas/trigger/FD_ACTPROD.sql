CREATE TRIGGER [dbo].[FD_ACTPROD] ON [dbo].[FACTURA_DETALLE] 
FOR INSERT
AS
                Declare @pro char(8)
                Declare @ofer char(1)
                declare @ls_alma char(2)
                declare @ld_fecha datetime
                declare @fact char(10)
                declare @ld_cant numeric(12,4) , @ld_saldo numeric(12,4)

                select @fact= codi_fact ,@pro = codi_prod, @ofer = prod_ofer, @ls_alma =codi_alma, @ld_cant= cant_item
                               from Inserted

                if @ofer=1
                begin
                               select @ld_fecha = fech_fact from factura (nolock) where codi_fact=@fact
                               
                               update productos_ofertas set usado= isnull(usado,0) + @ld_cant
                               where codi_prod=@pro and estado='1' and @ld_fecha between fecha_ini and fecha_fin
                                               and codi_alma=@ls_alma           

                               select @ld_saldo = (cantidad - usado)  from productos_ofertas (nolock)
                               where codi_alma=@ls_alma  and codi_prod=@pro and estado='1' and @ld_fecha between fecha_ini and fecha_fin
                                                         
                               
                               if @ld_saldo<=0 
                               begin
                                               update productos_ofertas set estado='0'
                                               where codi_alma=@ls_alma and codi_prod=@pro and estado='1' and @ld_fecha between fecha_ini and fecha_fin
                                                                                          
                               end
                end
GO

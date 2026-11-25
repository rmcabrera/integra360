CREATE FUNCTION [dbo].[F_NUMLET](@numero [varchar](20))
RETURNS [varchar](200) WITH EXECUTE AS CALLER
AS 
--declare @numero as varchar(20)
--select @numero=133.38

BEGIN 
 declare @EnLetras as varchar (200)
 declare @paso as integer 
 declare @b as integer
 declare @nn as  numeric(12,2)
 declare @expresion as varchar (200)
  declare @entero as  varchar (20)
 declare @deci as varchar(10)
 Declare @flag as varchar (1)
 set @flag = 'N'
 set @paso=1
 set @nn=convert( numeric(12,2), @numero)  
 set @numero=cast(@nn as varchar(20))

set @entero=''
set @deci =''
set @expresion =''
 while (@paso <= Len(@numero))
 begin 
    If (SUBSTRING(@numero, @paso, 1) = '.') set @flag = 'S'
    Else
     BEGIN
	  If (@flag = 'N' ) set @entero = @entero + SUBSTRING(@numero, @paso, 1)  --Extae la parte entera del numero
	  Else set @deci = @deci + SUBSTRING(@numero, @paso, 1)  --Extrae la parte decimal del numero
      end
   set @paso=@paso+ 1
 end
 
 If (Len(@deci) = 1) set  @deci = @deci + '0'
 
 set @flag = 'N'
  If (convert(numeric,@numero) >= -999999999 And convert(numeric,@numero) <= 999999999 )
 begin
 set @paso= Len(@entero)  + 1
 while (@paso>=1)
 begin
      set @paso = @paso - 1
     set @b = Len(@entero) - (@paso - 1)
     if (@paso=3 or @paso=6 or @paso=9)
     begin
	  if (substring(@entero, @b, 1)='1') 
	   begin
	                    If (substring(@entero, @b + 1, 1) = '0' And substring(@entero,@b + 2, 1) = '0') set @expresion = @expresion +'cien '
	                    Else  set @expresion = @expresion + 'ciento '
	   end
	   if (substring(@entero, @b, 1)='2') set @expresion = @expresion+ 'doscientos '
	   if (substring(@entero, @b, 1)='3') set @expresion = @expresion+ 'trescientos '
	   if (substring(@entero, @b, 1)='4') set @expresion = @expresion + 'cuatrocientos '
	   if (substring(@entero, @b, 1)='5') set @expresion = @expresion + 'quinientos '
	   if (substring(@entero, @b, 1)='6') set @expresion = @expresion + 'seiscientos '
	   if (substring(@entero, @b, 1)='7') set @expresion = @expresion + 'setecientos '
	   if (substring(@entero, @b, 1)='8') set @expresion = @expresion + 'ochocientos '
	   if (substring(@entero, @b, 1)='9') set @expresion = @expresion + 'novecientos '
	  set @flag='N'
    end 
   if (@paso=2 or @paso=5 or @paso=8)
      begin
         if (substring(@entero, @b, 1)='1') 
          begin
                 If (substring(@entero, @b + 1, 1) = '0' )
                     begin
		     set @flag='S'
		      set @expresion =@expresion +'diez '
	       end
	    If (substring(@entero, @b + 1, 1) = '1')
	       begin
		     set @flag='S'
		      set @expresion = @expresion +'once '
	       end
	   If (substring(@entero, @b + 1, 1) = '2')
	       begin
		     set @flag='S'
		      set @expresion =@expresion +'doce '
	       end
	  If (substring(@entero, @b + 1, 1) = '3')
	       begin
		     set @flag='S'
		     set @expresion = @expresion +'trece '
	      end
               If (substring(@entero, @b + 1, 1) = '4')
	       begin
		     set @flag='S'
		      set @expresion =@expresion +'catorce '
	       end
	 If (substring(@entero, @b + 1, 1) = '5')
	       begin
		     set @flag='S'
		      set @expresion = @expresion +'quince '
	       end
	 If (substring(@entero, @b + 1, 1) > '5')
	       begin
		     set @flag='N'
		      set @expresion =@expresion +'dieci'
	       end
        end
        if (substring(@entero, @b, 1)='2') 
         BEGIN
      	   If (substring(@entero, @b + 1, 1) = '0' )
	       begin
		     set @flag='S'
		      set @expresion =@expresion+'veinte '
	       end
         else
	    begin
		     set @flag='N'
		      set @expresion =@expresion+'veinti'
	    end
          end
        if (substring(@entero, @b, 1)='3') 
	   BEGIN
	         If (substring(@entero, @b + 1, 1) = '0' )
		       begin
			     set @flag='S'
			      set @expresion = @expresion+'treinta '
		       end
	      else
	         begin
		     set @flag='N'
		      set @expresion = @expresion+'treinta y '
 	        end
               end
        if (substring(@entero, @b, 1)='4') 
           BEGIN
	         If (substring(@entero, @b + 1, 1) = '0' )
		       begin
			     set @flag='S'
			      set @expresion =@expresion+'cuarenta '
		       end
	        else
	            begin
		     set @flag='N'
		      set @expresion = @expresion+'cuarenta y '
		 end
           end
       if (substring(@entero, @b, 1)='5') 
         BEGIN
                 If (substring(@entero, @b + 1, 1) = '0' )
	        begin
		     set @flag='S'
		      set @expresion =@expresion+'cincuenta '
	         end
                else
	     begin
                       set @flag='N'
	          set @expresion =@expresion+'cincuenta y '
                   end
         end
      if (substring(@entero, @b, 1)='6') 
 	BEGIN
                 If (substring(@entero, @b + 1, 1) = '0' )
	       begin
		     set @flag='S'
		      set @expresion = @expresion+'sesenta '
	       end
	    else
	      begin
	  	   set @flag='N'
		      set @expresion =@expresion+'sesenta y '
	      end
	 end
     if (substring(@entero, @b, 1)='7') 
         BEGIN
	         If (substring(@entero, @b + 1, 1) = '0' )
		    begin
			     set @flag='S'
			      set @expresion = @expresion +'setenta '
		       end
	         else
		  begin
			     set @flag='N'
			      set @expresion = @expresion +'setenta y '
		    end
       end
    if (substring(@entero, @b, 1)='8') 
    BEGIN
         If (substring(@entero, @b + 1, 1) = '0' )
   	    begin
		     set @flag='S'
		      set @expresion = @expresion+'ochenta '
	    end
         else
	    begin
		     set @flag='N'
		      set @expresion = @expresion+'ochenta y '
	    end
   end
   if (substring(@entero, @b, 1)='9') 
        BEGIN
             If (substring(@entero, @b + 1, 1) = '0' )
	       begin
		     set @flag='S'
		      set @expresion =@expresion+'noventa '
                     end
	 else
	    begin
		     set @flag='N'
		      set @expresion = @expresion+'noventa y '
	     end
         end
    end 
 if (@paso=1 or @paso=4 or @paso=7)
    begin
          if (substring(@entero, @b, 1)='1') 
	  begin
	      if(@flag='N') 
		   begin
		         if (@paso=1) set @expresion = @expresion + 'uno '
		         else set @expresion = @expresion + 'un '
		   end
	     end
          if (substring(@entero, @b, 1)='2') 
	  begin
		   if(@flag='N') set @expresion = @expresion+ 'dos '
	  end
           if (substring(@entero, @b, 1)='3') 
	  begin
		   if(@flag='N') set @expresion = @expresion + 'tres '
               end
           if (substring(@entero, @b, 1)='4') 
	  begin
	              if(@flag='N') set @expresion = @expresion + 'cuatro '
	  end
          if (substring(@entero, @b, 1)='5') 
	  begin
		   if(@flag='N') set @expresion = @expresion + 'cinco '
	  end
          if (substring(@entero, @b, 1)='6') 
	  begin
		   if(@flag='N') set @expresion = @expresion + 'seis '
	  end
          if (substring(@entero, @b, 1)='7') 
	  begin
		   if(@flag='N') set @expresion = @expresion+ 'siete '
           end
            if (substring(@entero, @b, 1)='8') 
	  begin
		   if(@flag='N') set @expresion = @expresion+ 'ocho '
	  end
             if (substring(@entero, @b, 1)='9') 
	  begin
		   if(@flag='N') set @expresion = @expresion+ 'nueve '
	  end
   end
 
      If (@paso = 4 )
	 begin
	      If (substring(@entero, 6, 1) <> '0' Or substring(@entero, 5, 1) <> '0' Or substring(@entero, 4, 1) <> '0' Or (substring(@entero, 6, 1) ='0' And substring(@entero, 5, 1) = '0' And substring(@entero, 4, 1) = '0' And  Len(@entero) <= 6) ) set @expresion = @expresion + 'mil '
	 End
      If (@paso = 7 )
         begin 
               If( Len(@entero) = 7 And substring(@entero, 1, 1) ='1') set @expresion = @expresion + 'millón '
              Else set @expresion = @expresion + 'millones '
         end  
 end

   if (@deci='') set @deci='00'    
   If (@deci <> '' )
	    begin
         		     if(rtrim(@expresion)='' or @expresion is null)  set @expresion='cero'
		    If(substring(@entero, 1, 1) = '-' ) set @EnLetras = 'menos ' + upper(@expresion) + ' y ' + @deci  + '/100'
		      Else set @EnLetras = upper(@expresion) + ' y ' + @deci + '/100' 
	    end
   Else
	   begin
		     if(@expresion='')  set @expresion='cero'
		      If(substring(@entero, 1, 1) = '-' ) set @EnLetras = 'menos ' + upper(@expresion)
		      Else  set @EnLetras = upper(@expresion)
	   End
    end
Else   set @EnLetras = ''
 
     return @enletras
END
GO

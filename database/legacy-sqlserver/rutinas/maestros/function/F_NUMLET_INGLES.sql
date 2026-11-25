CREATE FUNCTION [dbo].[F_NUMLET_INGLES](@numero [varchar](20))
RETURNS [varchar](200) WITH EXECUTE AS CALLER
AS 
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
 set @numero=ltrim(cast(@nn as varchar(20)))
set @entero=''
set @deci=''
set @expresion=''
if (SUBSTRING(@numero, len(@numero), 1) ='0') set @numero = SUBSTRING(@numero,1, len(@numero) -1 )



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

set @paso = @paso -1 
set @entero = rtrim(ltrim(@entero))
 If (Len(@deci) = 1) set  @deci = @deci + '0'
 
 set @flag = 'N'
  If (convert(numeric(12,2),@numero) >= -999999999 And convert(numeric(12,2),@numero) <= 999999999 )

 begin
  while (@paso>=1)
 begin
      set @paso = @paso - 1
     set @b = Len(@entero) - (@paso - 1)
     if (@paso=3 or @paso=6 or @paso=9)
     begin
	  if (substring(@entero, @b, 1)='1') 
	   begin
	                    If (substring(@entero, @b + 1, 1) = '0' And substring(@entero,@b + 2, 1) = '0') set @expresion = @expresion +'ONE HUNDRED '
	                    Else  set @expresion = @expresion + 'ONE HUNDRED '
	   end
	   if (substring(@entero, @b, 1)='2') set @expresion = @expresion+ 'TWO HUNDRED '
	   if (substring(@entero, @b, 1)='3') set @expresion = @expresion+ 'THREE HUNDRED '
	   if (substring(@entero, @b, 1)='4') set @expresion = @expresion + 'FOUR HUNDRED '
	   if (substring(@entero, @b, 1)='5') set @expresion = @expresion + 'FIVE HUNDRED '
	   if (substring(@entero, @b, 1)='6') set @expresion = @expresion + 'SIX HUNDRED '
	   if (substring(@entero, @b, 1)='7') set @expresion = @expresion + 'SEVEN HUNDRED '
	   if (substring(@entero, @b, 1)='8') set @expresion = @expresion + 'EIGHT HUNDRED '
	   if (substring(@entero, @b, 1)='9') set @expresion = @expresion + 'NINE HUNDRED '
	  set @flag='N'

    end 
   if (@paso=2 or @paso=5 or @paso=8)
      begin
         if (substring(@entero, @b, 1)='1') 
          begin
                 If (substring(@entero, @b + 1, 1) = '0' )
                     begin
		     set @flag='S'
		      set @expresion = @expresion + 'TEN '
	       end
	    If (substring(@entero, @b + 1, 1) = '1')
	       begin
		     set @flag='S'
		      set @expresion = @expresion +'EVELEN '
	       end
	   If (substring(@entero, @b + 1, 1) = '2')
	       begin
		     set @flag='S'
		      set @expresion =@expresion +'TWELVE '
	       end
	  If (substring(@entero, @b + 1, 1) = '3')
	       begin
		     set @flag='S'
		     set @expresion = @expresion +'THIRTEEN '
	      end
               If (substring(@entero, @b + 1, 1) = '4')
	       begin
		     set @flag='S'
		      set @expresion =@expresion +'FOURTEEN '
	       end
	 If (substring(@entero, @b + 1, 1) = '5')
	       begin
		     set @flag='S'
		      set @expresion = @expresion +'FIFTEEN '
	       end
	 If (substring(@entero, @b + 1, 1) ='6')
	       begin
		     set @flag='S'
		     set @expresion = @expresion + 'SIXTEEN '
	       end
	 If (substring(@entero, @b + 1, 1) ='7')
	       begin
		     set @flag='S'
		     set @expresion = @expresion + 'SEVENTEEN '
	       end
	 If (substring(@entero, @b + 1, 1) ='8')
	       begin
		     set @flag='S'
		     set @expresion =@expresion+ 'EIGHTTEEN '
	       end
	 If (substring(@entero, @b + 1, 1) ='9')
	       begin
		     set @flag='S'
		     set @expresion = @expresion + 'NINETEEN '
	       end
        end
        if (substring(@entero, @b, 1)='2') 
         BEGIN
      	--   If (substring(@entero, @b + 1, 1) = '0' )
	 --      begin
		     set @flag='N'
		      set @expresion =@expresion + 'TWENTY ' 
	--       end
       --  else
	--    begin
	--	     set @flag='N'
	--	      set @expresion ='TWENTY ' + @expresion
	--      set @expresion =@expresion+'veinti'
	  --  end
          end
        if (substring(@entero, @b, 1)='3') 
	   BEGIN
--	         If (substring(@entero, @b + 1, 1) = '0' )
--		       begin
			     set @flag='N'
			      set @expresion = @expresion+'THIRTY '
--		       end
--	      else
--	         begin
--		     set @flag='N'
--		      set @expresion = @expresion+'treinti'
 --	        end
               end
        if (substring(@entero, @b, 1)='4') 
           BEGIN
--	         If (substring(@entero, @b + 1, 1) = '0' )
--		       begin
			     set @flag='N'
			      set @expresion =@expresion+'FORTY '
--		       end
--	        else
--	            begin
--		     set @flag='N'
--		      set @expresion = @expresion+'cuarenti'
--		 end
           end
       if (substring(@entero, @b, 1)='5') 
         BEGIN
--                 If (substring(@entero, @b + 1, 1) = '0' )
--	        begin
		     set @flag='N'
		      set @expresion =@expresion+'FIFTY '
--	         end
 --               else
--	     begin
  --                     set @flag='N'
--	          set @expresion =@expresion+'cincuenti'
          --         end
         end
      if (substring(@entero, @b, 1)='6') 
 	BEGIN
               --  If (substring(@entero, @b + 1, 1) = '0' )
	   --    begin
		     set @flag='N'
		      set @expresion = @expresion+'SIXTY '
	--       end
	 --   else
	    --  begin
	--  	   set @flag='N'
	--	      set @expresion =@expresion+'sesenti'
	    --  end
	 end
     if (substring(@entero, @b, 1)='7') 
         BEGIN
	--         If (substring(@entero, @b + 1, 1) = '0' )
		--    begin
			     set @flag='N'
			      set @expresion = @expresion +'SEVENTY '
	--	       end
--	         else
		--  begin
		--	     set @flag='N'
		--	      set @expresion = @expresion +'setenti'
	--	    end
       end
    if (substring(@entero, @b, 1)='8') 
    BEGIN
        -- If (substring(@entero, @b + 1, 1) = '0' )
   	--    begin
		     set @flag='N'
		      set @expresion = @expresion+'EIGHTY '
--	    end
        -- else
	 --   begin
	--	     set @flag='N'
	--	      set @expresion = @expresion+'ochenti'
--	    end
   end
   if (substring(@entero, @b, 1)='9') 
        BEGIN
--      If (substring(@entero, @b + 1, 1) = '0' )
--	       begin
		     set @flag='N'
		      set @expresion =@expresion+'NINETY '
  --                   end
--	 else
--	    begin
--		     set @flag='N'
--		      set @expresion = @expresion+'noventi'
--	     end
         end
    end 
 if (@paso=1 or @paso=4 or @paso=7)
    begin
          if (substring(@entero, @b, 1)='1') 
	  begin
	      if(@flag='N') 
		   begin
		         if (@paso=1) set @expresion = @expresion + 'ONE '
		         else set @expresion = @expresion + 'ONE '
		   end
	     end
          if (substring(@entero, @b, 1)='2') 
	  begin
		   if(@flag='N') set @expresion = @expresion+ 'TWO '
	  end
           if (substring(@entero, @b, 1)='3') 
	  begin
		   if(@flag='N') set @expresion = @expresion + 'THREE '
               end
           if (substring(@entero, @b, 1)='4') 
	  begin
	              if(@flag='N') set @expresion = @expresion + 'FOUR '
	  end
          if (substring(@entero, @b, 1)='5') 
	  begin
		   if(@flag='N') set @expresion = @expresion + 'FIVE '
	  end
          if (substring(@entero, @b, 1)='6') 
	  begin
		   if(@flag='N') set @expresion =  @expresion + 'SIX '
	  end
          if (substring(@entero, @b, 1)='7') 
	  begin
		   if(@flag='N') set @expresion =  @expresion+ 'SEVEN ' 
           end
            if (substring(@entero, @b, 1)='8') 
	  begin
		   if(@flag='N') set @expresion =   @expresion + 'EIGHT '
	  end
             if (substring(@entero, @b, 1)='9') 
	  begin
		   if(@flag='N') set @expresion =  @expresion + 'NINE '
	  end
   end
   If ( @paso = 4  and len(@entero)>=4)
	 begin
	      If (substring(@entero, 6, 1) <> '0' Or substring(@entero, 5, 1) <> '0' Or substring(@entero, 4, 1) <> '0' Or 
		(substring(@entero, 6, 1) ='0' And substring(@entero, 5, 1) = '0' And substring(@entero, 4, 1) = '0'  )  )		
		set @expresion = @expresion + 'THOUSAND '
	 End
     If (@paso = 7 )
         begin 

	if (len(@entero)>=7 ) set @expresion = @expresion + 'MILLION '
        end  
 end

   if (@deci='') set @deci='00'    
   If (@deci <> '' )
	    begin
         		    if(rtrim(@expresion)='' or @expresion is null)  set @expresion='ZERO'
		    If(substring(@entero, 1, 1) = '-' ) set @EnLetras = 'menos ' +rtrim(ltrim(upper(@expresion))) + ' AND ' + @deci  + '/100'
		      Else set @EnLetras = rtrim(ltrim(upper(@expresion))) + ' AND ' + @deci + '/100' 
	    end
   Else
	   begin
		     if(@expresion='')  set @expresion='ZERO'
		      If(substring(@entero, 1, 1) = '-' ) set @EnLetras = 'menos ' + upper(@expresion)
		      Else  set @EnLetras = upper(@expresion)
	   End
    end
Else   set @EnLetras = ''
 
     return @enletras

END
GO

CREATE PROCEDURE [dbo].[SP_Reporte_Semana_Pesca]
	@semana [char](8)
WITH EXECUTE AS CALLER
AS
Begin
	Declare @Faux datetime
	Declare @Fini datetime
	Declare @Fter datetime
	Declare @emb char(5)
	Declare @Tm numeric(12,3)
	Declare @Pt numeric(12,3)
	Declare @C int
	Select @Fini = Fech_inic ,@Fter =fech_term from semana where codi_sema=@semana

	Create Table #Temporal(codi_unid_oper char(5) null, ju numeric(12,3) null,  p1 numeric(12,3) null, vi numeric(12,3) null, 
		p2 numeric(12,3) null, sa numeric(12,3) null, p3 numeric(12,3) null, do numeric(12,3) null, p4 numeric(12,3) null,  
		lu numeric(12,3) null, p5 numeric(12,3) null, ma numeric(12,3) null, p6 numeric(12,3) null, mi numeric(12,3) null, p7 numeric(12,3) null)
	
	Declare C1 cursor for select codi_unid_oper from embarcaciones
	Open C1
	fetch C1 into @emb
	WHILE @@FETCH_STATUS = 0
	begin		
		insert into #temporal (codi_unid_oper) values (@emb)
		set @faux = @Fini
		set @C=1
		while @Faux<=@FTer
		begin
			set @TM=0
			set @PT=0
    			select  @TM = pesc_real, @Pt= comb_reci  from zarpes where convert(char(10),fech_repo,103) = convert(char(10),@Faux, 103) 
				and codi_unid_oper=@emb and codi_sema=@semana

			if(@c=1)	update #temporal set ju=@Tm where codi_unid_oper=@emb
			if(@c=2)	update #temporal set vi=@Tm where codi_unid_oper=@emb
			if(@c=3)	update #temporal set sa=@Tm where codi_unid_oper=@emb
			if(@c=4)	update #temporal set do=@Tm where codi_unid_oper=@emb
			if(@c=5)	update #temporal set lu=@Tm where codi_unid_oper=@emb
			if(@c=6)	update #temporal set ma=@Tm where codi_unid_oper=@emb
			if(@c=7)	update #temporal set mi=@Tm where codi_unid_oper=@emb

			if(@c=1)	update #temporal set p1=@Pt where codi_unid_oper=@emb
			if(@c=2)	update #temporal set p2=@PT where codi_unid_oper=@emb
			if(@c=3)	update #temporal set p3=@PT where codi_unid_oper=@emb
			if(@c=4)	update #temporal set p4=@PT where codi_unid_oper=@emb
			if(@c=5)	update #temporal set p5=@PT where codi_unid_oper=@emb
			if(@c=6)	update #temporal set p6=@PT where codi_unid_oper=@emb
			if(@c=7)	update #temporal set p7=@PT where codi_unid_oper=@emb

			set @C= @C + 1
			set @Faux=DATEADD(day,1,@Faux)
		end 
		fetch C1 into @emb
	end 
	Close C1
	Deallocate C1	
	
	select * from #temporal
End
GO

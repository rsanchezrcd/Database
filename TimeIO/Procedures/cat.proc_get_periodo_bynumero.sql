SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create proc cat.proc_get_periodo_bynumero
		@per_int  int
		,@year  int = null
		,@id_per char(36) OUTPUT
	as begin
		if @year is null begin
			select @year = year(getdate());
		end;
		select @id_per = id_periodo from cat.periodos 
		where _per =@per_int  and _year = @year;
		
	end;
GO

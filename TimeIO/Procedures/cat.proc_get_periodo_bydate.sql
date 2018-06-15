SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [cat].[proc_get_periodo_bydate]
		@date nvarchar(8) = null
		, @id_per char(36) OUTPUT
	as begin
		if @date is null begin
			select @date = convert(nvarchar(8), getdate(),112);
		end;
		select top 1 @id_per = id_periodo from cat.periodos 
		where convert(datetime,@date) between ini_date and end_date
		and _cerrado = 0;	
	end;
GO

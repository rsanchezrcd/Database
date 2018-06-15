SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE function [cat].[func_get_id_periodo_by_datos] (
	@year int
	,@per int
) returns char(36)
as begin
	declare @id char(36);
	select @id = id_periodo
	from cat.periodos with(nolock)
	where _year = @year and _per = @per;
	return (@id);
end;

GO

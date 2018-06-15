SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create function [cat].[func_get_id_periodo] (
	@fecha datetime
) returns char(36)
as begin
	declare @id char(36);
	select @id = id_periodo
	from cat.periodos with(nolock)
	where @fecha between ini_date and end_date;
	return (@id);
end;

GO

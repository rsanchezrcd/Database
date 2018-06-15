SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE function [cat].[func_get_periodo] (
	@id char(36)
) returns nvarchar(4)
as begin
	declare @per nvarchar(4);

	select @per = RIGHT(_year,2)+ rtrim(format(_per,'00'))
	from cat.periodos with(nolock)
	where id_periodo= @id
	return (@per);
end;

GO

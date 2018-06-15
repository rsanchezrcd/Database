SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE function [cat].[func_get_id_employee] (
	@alter int
) returns char(36)
as begin
	declare @id char(36);
	select @id = employee_id 
	from cat.employees with(nolock)
	where _alter_id = @alter;
	return (@id);
end;
GO

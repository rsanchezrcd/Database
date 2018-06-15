SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create function [cat].[func_get_employee_alter] (
	@id char(36)
) returns int
as begin
	declare @alter int;
	select @alter = _alter_id 
	from cat.employees with(nolock)
	where employee_id = @id;
	return (@alter);
end;
GO

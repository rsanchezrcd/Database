SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [cat].[proc_employees_for_operator_search_bynum]
	@num nvarchar(7)
as begin
	select employee_id,	_alter_id,	adm.FirstWord(_name) _name,	adm.FirstWord(_lastname)_lastname,	adm.FirstWord(_maidenname)_maidenname, active
	from cat.vw_employees_for_operator
	where _alter_id = @num and active = 1
	order by _alter_id asc
end
GO

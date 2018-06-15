SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc cat.proc_employees_for_operator as begin
	select employee_id,	_alter_id,	_name,	_lastname,	_maidenname,	active
	from cat.vw_employees_for_operator
	order by _alter_id asc
end
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE view cat.vw_employees_for_operator
as select 
		
		employee_id
		,_alter_id 
		,_nombres _name
		,_apellido_paterno _lastname
		,_apellido_materno _maidenname
		--, rtrim(_alter_id) + ' - ' + rtrim(_nombres) + ' ' + rtrim(_apellido_paterno) [_to_show]
		,active
	from cat.employees
	
	--order by _alter_id asc
GO

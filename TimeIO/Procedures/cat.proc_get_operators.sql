SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc cat.proc_get_operators
	@ope char(36)
as begin
	set nocount on;

	declare @ord tinyint 
	select @ord = _order from cat.roles with(nolock)
	where id_role = (select id_role from cat.operator with(nolock)
					 where operator_id = @ope) 

	select
		o.operator_id
		,o._username
		,o.employee_id
		,e._alter_id
		,o._name
		,o._lastname
		,o._domain 
		,o.id_departamento
		,d._departamento_code
		,d._departamento_name
		,o.id_role
		,r._role_name
		,r._order
	from cat.operator o with(nolock)
	inner join cat.roles r with(nolock) on r.id_role = o.id_role 
	inner join cat.departamentos d with(nolock) on d.id_departamento = o.id_departamento
	inner join cat.employees e with(nolock) on e.employee_id = o.employee_id
	where r._order >= @ord;
end

GO

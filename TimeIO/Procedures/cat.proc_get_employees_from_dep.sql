SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc cat.proc_get_employees_from_dep
	@dep char(36)
as begin
	select 
		e.employee_id
		,e._alter_id
		,rtrim(e._nombres) +' ' + rtrim(e._apellido_paterno) + ' ' + rtrim(e._apellido_materno) [_name]
		,rtrim(p._posicion_code) + ' - '+ rtrim(p._posicion_name) [_position]
		,e._clase
		,e._checa
	from cat.employees e with (nolock)
	inner join cat.posicion p with (nolock) on p.posicion_id = e.posicion_id and p.active = 1
	where e.departamento_id = @dep
		and e._status = 1
		and e.active = 1
	order by p._posicion_code asc, e._alter_id asc;
end;
GO

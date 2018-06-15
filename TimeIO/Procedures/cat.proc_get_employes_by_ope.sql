SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure cat.proc_get_employes_by_ope
	@ope char(36)
as begin
	set nocount on;
	select 
		e.employee_id
		,convert(int,e._alter_id) [_alter_id]
		,rtrim(e._nombres) + ' ' + rtrim(e._apellido_paterno) + ' ' + rtrim(e._apellido_materno) [_nombre]
		,d._departamento_name
		,d._departamento_code
		,p._posicion_name
		,p._posicion_code
		,l._locacion_code
	from cat.employees e with (nolock)
	inner join cat.departamento_operator do with (nolock) on (e.departamento_id = do.id_departamento)
	inner join cat.departamentos d with (nolock) on (e.departamento_id = d.id_departamento)
	inner join cat.posicion p with (nolock) on (e.posicion_id = p.posicion_id)
	inner join cat.locacion l with (nolock) on (e.locacion_id = l.locacion_id)
	where do.id_operator = @ope and e._status = 1
	order by [_alter_id] asc;
end;
GO

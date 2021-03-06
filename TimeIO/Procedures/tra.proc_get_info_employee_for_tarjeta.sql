SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create proc tra.proc_get_info_employee_for_tarjeta
	 @per char(36)
	,@emp char(36)
as begin
	set nocount on;

	select  
		cat.func_get_periodo(@per) [_periodo]
		,e._alter_id
		,(rtrim(e._apellido_paterno) + ' ' + rtrim(e._apellido_materno) + ', ' + rtrim(e._nombres)) [_nombre]
		,e._checa
		,convert(nvarchar(10),e._hire_date, 121) [_hire_date]
		,rtrim(d._departamento_code) [_departamento_code]
		,rtrim(d._departamento_name) [_departamento_name]
		,rtrim(p._posicion_code) [_posicion_code]
		,rtrim(p._posicion_name) [_posicion_name]
		,rtrim(e._clase) [_clase]
		,p._horas_extras
		,p._horas_nocturnas
		,p._festivos
		,p._prima_dominical
	from cat.employees e with(nolock)
	inner join cat.departamentos d with(nolock) on d.id_departamento = e.departamento_id
	inner join cat.posicion p with(nolock) on p.posicion_id = e.posicion_id
	where e.employee_id = @emp;

end;
			
	
GO

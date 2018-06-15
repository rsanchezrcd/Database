SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [cat].[proc_get_employees_by_ope_by_alter]
	@ope char(36)
	,@alter nvarchar(10)
	,@result bit = 0 OUTPUT
	,@msg nvarchar(1024) = 'Error' OUTPUT
	,@per char(36) = null
as begin
	set nocount on;
	declare @ini date
	if @per is null begin
		exec cat.proc_get_fecha_ini_periodo_actual @ini OUTPUT
	end else begin
		select @ini = ini_date from cat.periodos where id_periodo = @per;
	end

	if (exists( select 
					e.employee_id					
				from cat.employees e with (nolock)
				inner join cat.departamento_operator do with (nolock) on (e.departamento_id = do.id_departamento)				
				where do.id_operator = @ope and cat.func_isactive_bydt(@ini, e.employee_id) = 1 and _alter_id = @alter )) begin
		
		select 
			e.employee_id
			,convert(int,e._alter_id) [_alter_id]
			,rtrim(e._nombres) + ' ' + rtrim(e._apellido_paterno) + ' ' + rtrim(e._apellido_materno) [_nombre]
			,rtrim(d._departamento_name) [_departamento_name]
			,rtrim(d._departamento_code) [_departamento_code]
			,rtrim(p._posicion_name) [_posicion_name]
			,rtrim(p._posicion_code) [_posicion_code]
			,rtrim(l._locacion_code) [_locacion_code]
			,rtrim(e._clase) [_clase]
			,rtrim(convert(varchar(10),e._hire_date,120)) [_hire_date]
		from cat.employees e with (nolock)
		inner join cat.departamento_operator do with (nolock) on (e.departamento_id = do.id_departamento)
		inner join cat.departamentos d with (nolock) on (e.departamento_id = d.id_departamento)
		inner join cat.posicion p with (nolock) on (e.posicion_id = p.posicion_id)
		inner join cat.locacion l with (nolock) on (e.locacion_id = l.locacion_id)
		where do.id_operator = @ope and cat.func_isactive_bydt(@ini, e.employee_id) = 1 and _alter_id = @alter;
		set @msg = 'ok';
		set @result = 1;
	end else begin
		set @msg = 'Inexistente';
		set @result = 0;
	end;
	
end;
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE proc adm.[proc_get_data_request]	
	@id int
	,@code int = null OUTPUT
	,@emp char(36) = null OUTPUT
	,@nombre nvarchar(128) = null OUTPUT
	,@locacion nvarchar(128) = null OUTPUT
	,@loc nvarchar(36) = null OUTPUT
	,@departamento nvarchar(128) = null OUTPUT
	,@dep nvarchar(36) = null OUTPUT
	,@posicion nvarchar(128)  = null OUTPUT
	,@pos nvarchar(36) = null OUTPUT
	,@id_role char(36) = null OUTPUT
	,@correo nvarchar(64) = null OUTPUT
	,@id_email char(36) = null OUTPUT	
	,@msg nvarchar(128) OUTPUT
as begin
	set nocount on;
	if (exists(select id_employee from adm.operator_request
				where id_operator_request = @id and _atendida = 0)) begin

		select   @emp = id_employee 
				,@id_role = id_role
				,@correo = _correo
				,@id_email = id_email
		from adm.operator_request
		where id_operator_request = @id;
	 
		if(not exists(select active from cat.operator 
			where employee_id = @emp and active = 1)) begin

			select 
				@code = e._alter_id				
				,@nombre = rtrim(e._apellido_paterno) + ' ' + rtrim(e._apellido_materno) + ', ' + rtrim(e._nombres)
				,@locacion = rtrim(l._locacion_code)
				,@loc = l.locacion_id
				,@departamento = rtrim(d._departamento_code) + ' - ' + rtrim(_departamento_name)
				,@dep = d.id_departamento
				,@posicion = rtrim(p._posicion_code) + ' - ' + rtrim(p._posicion_name)
				,@pos = p.posicion_id
			from cat.employees e with (nolock)
			inner join cat.departamentos d with (nolock) on (d.id_departamento = e.departamento_id)
			inner join cat.locacion l with (nolock) on (l.locacion_id = e.locacion_id)
			inner join cat.posicion p with (nolock) on (p.posicion_id = e.posicion_id)
			where e.employee_id = @emp and cat.func_isactive_bydt(getdate() ,@emp) = 1;
			---------------------------------------------
			if @emp is null 
				set @msg = 'C&oacute;digo inexistente...';
			else
				set @msg = 'OK';
		end else begin
			set @msg = 'C&oacute;digo ocupado...';
		end
	end else begin
		set @msg = 'Solicitud inexistente...';
	end
end
GO

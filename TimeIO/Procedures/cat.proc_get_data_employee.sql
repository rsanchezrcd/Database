SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


create proc [cat].[proc_get_data_employee]	
	@id int
	,@emp char(36) = null OUTPUT
	,@nombre nvarchar(128) = null OUTPUT
	,@locacion nvarchar(128) = null OUTPUT
	,@loc nvarchar(36) = null OUTPUT
	,@departamento nvarchar(128) = null OUTPUT
	,@dep nvarchar(36) = null OUTPUT
	,@posicion nvarchar(128)  = null OUTPUT
	,@pos nvarchar(36) = null OUTPUT
	,@msg nvarchar(128) OUTPUT
as begin
	set nocount on;
	if(not exists(select active from cat.operator 
		where employee_id = cat.func_get_id_employee(@id) and active = 1)) begin

		select 
			@emp = e.employee_id
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
		where e._alter_id = @id and cat.func_isactive_bydt(getdate() ,cat.func_get_id_employee(@id)) = 1;
		---------------------------------------------
		if @emp is null 
			set @msg = 'C&oacute;digo inexistente...';
		else
			set @msg = 'OK';
	end else begin
		set @msg = 'C&oacute;digo ocupado...';
	end

end
GO

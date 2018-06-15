SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
 
 
CREATE proc adm.proc_get_solicitudes
	@ope char(36)
as begin
	set nocount on;

	declare @order int, @rol char(36)

	select @rol = id_role from cat.operator where operator_id = @ope and active = 1;
	select @order = _order from cat.roles where id_role = @rol and active = 1;
	SELECT  
		o.id_operator_request [id_request]
		,convert(nvarchar(16),o.[insert_date],120) _fecha
		,cat.[func_get_operator](o.insert_operator_id) _solicitante  
		,cat.func_get_employee_alter(id_employee) _alter_id
		,rtrim(e._nombres) + ' ' + rtrim(e._apellido_paterno) + ' ' + rtrim(e._apellido_materno) _nombre
		,r.id_role  
		,r._role_name 
		,o.[_atendida]
	FROM [adm].[operator_request] o with (nolock)
	inner join cat.roles r with (nolock) on r.id_role = o.id_role
	inner join cat.employees e with (nolock) on e.employee_id = o.id_employee
	where o._atendida = 0 and r._order >= @order;
end

GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [adm].[vw_request_operator_dbmail] AS select
		o.id_operator_request [id_request]
	,cast(convert(nvarchar(16),o.[id_operator_request],120) as nvarchar(128)) [#Solicitud]	
	,cast(convert(nvarchar(16),o.[insert_date],120) as nvarchar(128)) [Fecha]	
	,cast(cat.func_get_employee_alter(id_employee) as nvarchar(128)) [Codigo Empleado]
	,cast((rtrim(e._nombres) + ' ' + rtrim(e._apellido_paterno) + ' ' + rtrim(e._apellido_materno)) as nvarchar(128)) [Nombre Empleado]
	,cast(r._role_descr as nvarchar(128)) [Rol Solicitado]
	,cast(upper(cat.[func_get_operator](o.insert_operator_id)) as nvarchar(128)) [Solicitante]
	,cast('https://asistenciarcd.aicollection.net/' as nvarchar(128)) [Url]
from adm.operator_request o with (nolock)
inner join cat.roles r with (nolock) on r.id_role = o.id_role
inner join cat.employees e with (nolock) on e.employee_id = o.id_employee
GO

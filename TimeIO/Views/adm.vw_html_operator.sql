SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE view adm.vw_html_operator
as select 	 
		o.[operator_id]
		,'<div class=''fs mt5 gpo bloque''><span style=''width:calc(30% - 10px);'' class=''enlinea fs td''>_alter_id:</span><input style=''width:calc(30% - 48px);'' id=''_alter_id'' type=''number'' min=''1'' max=''999999'' class=''fs enlinea '' value='''+convert(nvarchar(64),e.[_alter_id])+ '''/>' [_alter_id]
		,'<input id=''employee_id'' type=''text'' class=''fs enlinea oculto '' value='''+convert(nvarchar(64),o.[employee_id])+ '''/></div>' [employee_id]		
		,'<div class=''fs mt5 gpo bloque''><span style=''width:calc(30% - 10px);'' class=''enlinea fs td''>_username:</span><input style=''width:calc(70% - 48px);'' id=''_username'' type=''text'' class=''fs enlinea '' value='''+convert(nvarchar(64),[_username])+ '''/></div>' [_username]
		,'<div class=''fs mt5 gpo bloque oculto''><span style=''width:calc(30% - 10px);'' class=''enlinea fs td''>_password:</span><input style=''width:calc(70% - 48px);'' id=''_password'' type=''text'' class=''fs enlinea '' value='''+convert(nvarchar(64),[_password])+ '''/></div>' [_password]		
		,'<div class=''fs mt5 gpo bloque''><span style=''width:calc(30% - 10px);'' class=''enlinea fs td''>_ad_user:</span><input  id=''_ad_user'' type=''checkbox'' class=''fs enlinea '' checked='''+convert(char(1),[_ad_user])+''' value='''+convert(nvarchar(64),[_ad_user])+ '''/></div>' [_ad_user]
		,'<div class=''fs mt5 gpo bloque''><span style=''width:calc(30% - 10px);'' class=''enlinea fs td''>_domain:</span><input style=''width:calc(70% - 48px);'' id=''_domain'' type=''text'' class=''fs enlinea '' value='''+convert(nvarchar(64),[_domain])+ '''/></div>' [_domain]
		,'<div class=''fs mt5 gpo bloque''><span style=''width:calc(30% - 10px);'' class=''enlinea fs td''>_name:</span><input style=''width:calc(70% - 48px);'' id=''_name'' type=''text'' class=''fs enlinea '' value='''+convert(nvarchar(64),[_name])+ '''/></div>' [_name]
		,'<div class=''fs mt5 gpo bloque''><span style=''width:calc(30% - 10px);'' class=''enlinea fs td''>_lastname:</span><input style=''width:calc(70% - 48px);'' id=''_lastname'' type=''text'' class=''fs enlinea '' value='''+convert(nvarchar(64),[_lastname])+ '''/></div>' [_lastname]
		,'<div class=''fs mt5 gpo bloque''><span style=''width:calc(30% - 10px);'' class=''enlinea fs td''>_email:</span><input style=''width:calc(70% - 48px);'' id=''_email'' type=''text'' class=''fs enlinea '' value='''+convert(nvarchar(64),[_email])+ '''/></div>' [_email]
		,'<div class=''fs mt5 gpo bloque''><span style=''width:calc(30% - 10px);'' class=''enlinea fs td''>_is_admin:</span><input  id=''_is_admin'' type=''checkbox'' checked='''+convert(char(1),[_ad_user])+''' class=''fs enlinea '' value='''+convert(nvarchar(64),[_is_admin])+ '''/></div>' [_is_admin]
		,'<div class=''fs mt5 gpo bloque''><span style=''width:calc(30% - 10px);'' class=''enlinea fs td''>active:</span><input  id=''active'' type=''checkbox'' checked='''+convert(char(1),[_ad_user])+''' class=''fs enlinea '' value='''+convert(nvarchar(64),o.[active])+ '''/></div>' [active]
		,'<div class=''fs mt5 gpo bloque''><span style=''width:calc(30% - 10px);'' class=''enlinea fs td''>_role_name:</span><input style=''width:calc(70% - 48px);''id=''_role_name'' type=''text'' class=''fs enlinea '' value='''+convert(nvarchar(64),r.[_role_name])+ '''/>' [_role_name]
		,'<input id=''id_role'' type=''text'' class=''fs enlinea oculto '' value='''+convert(nvarchar(64),o.[id_role])+ '''/></div>' [id_role]
		,'<div class=''fs mt5 gpo bloque''><span style=''width:calc(30% - 10px);'' class=''enlinea fs td''>_departamento_code:</span><input style=''width:calc(30% - 48px);'' id=''_departamento_code'' type=''number'' min=''1'' max=''999999'' class=''fs enlinea '' value='''+rtrim(convert(nvarchar(64),d.[_departamento_code]))+ '''/>' [_departamento_code]
		,'<input id=''id_departamento'' type=''text'' class=''fs enlinea oculto'' value='''+convert(nvarchar(64),o.[id_departamento])+ '''/></div>' [id_departamento]
		from cat.operator o
inner join cat.employees e on e.employee_id = o.employee_id
inner join cat.roles r on r.id_role = o.id_role
inner join cat.departamentos d on d.id_departamento = o.id_departamento
GO

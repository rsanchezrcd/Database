SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure tra.proc_get_horas_extras_tarjeta

	 @emp char(36) 
	,@per char(36)

as begin
	set nocount on;

	select 
		convert(nvarchar(10),cat.func_get_fecha_bycn_byper(_cn,id_periodo),120) Fecha
		,_pagadas Horas
		,convert(nvarchar(19),insert_date,120) FechaCaptura
		,cat.func_get_operator(insert_operator_id) UsuarioCaptura
	from tra.horas_extras_log
	where id_employee = @emp and id_periodo = @per and active = 1 and _pagadas > 0;


end;

GO

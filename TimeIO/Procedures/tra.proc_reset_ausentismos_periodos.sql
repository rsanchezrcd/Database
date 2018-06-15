SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc tra.proc_reset_ausentismos_periodos
	@fecha datetime = null
as begin
	set nocount on;
	if @fecha is null set @fecha = getdate();
	---
	update tra.ausentismos set	
		id_periodo = cat.func_get_id_periodo(_ausentismo_date) 
	where
		_ausentismo_date >= @fecha
		and id_periodo <> cat.func_get_id_periodo(_ausentismo_date);
	print '[TRA] Registros Actualizados: ' + rtrim(@@rowcount)
	update stg.ausentismos_eliminados set	
		id_periodo = cat.func_get_id_periodo(_ausentismo_date) 
	where
		_ausentismo_date >= @fecha
		and id_periodo <> cat.func_get_id_periodo(_ausentismo_date);
	print '[STG] Registros Actualizados: ' + rtrim(@@rowcount)
end
GO

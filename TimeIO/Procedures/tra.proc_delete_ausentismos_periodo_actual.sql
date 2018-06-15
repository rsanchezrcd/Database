SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure tra.proc_delete_ausentismos_periodo_actual
	@doit bit = 0
as begin
	set nocount on;

	declare @per  char(36)
	exec cat.proc_get_periodo_actual @per OUTPUT

	if @doit = 0 begin
		select * from tra.ausentismos
		where (insert_operator_id = cat.func_get_id_operator('IFC-VACACIONES') 
			OR insert_operator_id = cat.func_get_id_operator('IFC-INCAPACIDADES')
			OR insert_operator_id = cat.func_get_id_operator('IFC-BAJAS'))
		AND id_periodo = @per;
	end else begin 
		--Eliminamos registros de tabla productiva
		delete from tra.ausentismos
		where (insert_operator_id = cat.func_get_id_operator('IFC-VACACIONES') 
			OR insert_operator_id = cat.func_get_id_operator('IFC-INCAPACIDADES') 
			OR insert_operator_id = cat.func_get_id_operator('IFC-BAJAS'))
		AND id_periodo = @per;
		--Eliminamos registros de tabla stg
		delete
		  FROM [TimeIO].[stg].[ausentismos_eliminados]
		  where (insert_operator_id = cat.func_get_id_operator('IFC-VACACIONES') 
			OR insert_operator_id = cat.func_get_id_operator('IFC-INCAPACIDADES')
			OR insert_operator_id = cat.func_get_id_operator('IFC-BAJAS'))
		AND id_periodo = cat.func_get_id_periodo_by_datos(2018,8)
	end 
end;
GO

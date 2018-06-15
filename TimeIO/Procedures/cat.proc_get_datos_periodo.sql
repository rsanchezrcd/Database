SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc cat.proc_get_datos_periodo
	@per char(36) 
	as begin
		select 
			_per
			,_days
			,ini_date
			,end_date
			,_year
			,_dia_cierre
			,RIGHT(_year,2) + REPLICATE('0',2-LEN(RTRIM(_per))) + RTRIM(_per) [_year_per]
		from cat.periodos where id_periodo = @per;
	end
GO

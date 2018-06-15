SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
 CREATE procedure [cat].[proc_get_fecha_fin_periodo_actual]	
	@fecha_fin datetime OUTPUT
 as begin
	set nocount on;
	SELECT TOP (1)
		@fecha_fin = [end_date]		 
	FROM [TimeIO].[cat].[periodos]
	where _cerrado = 0
	and _actual = 1
	--and _year = 2017
	order by ini_date asc;
end;
GO

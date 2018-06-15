SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
 create procedure [cat].[proc_get_fecha_ini_periodo]
	@per char(36)
	,@fecha_ini datetime OUTPUT
 as begin
	set nocount on;
	SELECT TOP (1)
		@fecha_ini = [ini_date]		 
	FROM [TimeIO].[cat].[periodos]
	where id_periodo = @per;
end;
GO

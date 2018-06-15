SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		rsanchez
-- Create date: 20170927
-- Description:	Obtener si el col esta activo
-- =============================================
CREATE FUNCTION cat.func_isactive_bydt (
	@fecha datetime	
	,@emp char(36)
)
RETURNS bit
AS
BEGIN
	declare @status bit
	select 
		@status = (case when _fecha_baja is null then _status 
						when _fecha_baja > @fecha then 1
						when _fecha_baja < @fecha then 0 end )
	from cat.employees
	where employee_id = @emp

	return @status
END
GO

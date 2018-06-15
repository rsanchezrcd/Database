SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		rsanchez
-- Create date: 20180313
-- Description:	Obtenemos la locacion al pasar el operador
-- =============================================
CREATE FUNCTION cat.func_get_loc_by_ope
(
	@ope char(36)
)
RETURNS char(36)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @loc char(36)

	-- Add the T-SQL statements to compute the return value here
	SELECT @loc = locacion_id from cat.employees 
	where employee_id = (select employee_id from cat.operator where operator_id = @ope);

	-- Return the result of the function
	RETURN @loc

END
GO

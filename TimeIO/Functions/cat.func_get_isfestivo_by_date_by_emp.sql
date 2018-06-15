SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		rsanchez
-- Create date: 20180209
-- Description:	verificar si la fecha es festivo por col.
-- =============================================
CREATE FUNCTION cat.func_get_isfestivo_by_date_by_emp
(
	@fecha date
	,@emp char(36)
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @res bit, @loc char(36)

	-- Add the T-SQL statements to compute the return value here
	select @loc = locacion_id from cat.employees with (nolock) where employee_id = @emp;

	select @res = active from cat.festivo with (nolock) where _festivo_date = @fecha and id_locacion = @loc;
	-- Return the result of the function
	RETURN @res;

END
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION cat.func_get_fecha_bycn_byper 
(
	@cn char(4)
	,@per char(36)
)
RETURNS date
AS
BEGIN
	-- Declare the return variable here
	DECLARE @fecha date

	set @cn = replace(@cn, '_','');

	-- Add the T-SQL statements to compute the return value here
	SELECT @fecha = fecha_nat from adm.fechas 
	where id_periodo = @per and _cn = @cn;

	-- Return the result of the function
	RETURN @fecha

END
GO

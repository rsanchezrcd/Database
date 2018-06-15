SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		rsanchez
-- Create date: 20180211
-- Description:	comprueba si el operador tiene acceso al departamento
-- =============================================
CREATE FUNCTION cat.func_dep_available_by_ope
(
	@dep char(36), @ope char(36)
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @res bit

	-- Add the T-SQL statements to compute the return value here
	if (exists(select top 1 id_departamento from cat.departamento_operator with(nolock) where id_departamento = @dep and id_operator = @ope ))
		set @res = 1
	else 
		set @res = 0
	
	RETURN @res

END
GO

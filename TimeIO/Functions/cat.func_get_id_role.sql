SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		rsanchez
-- Create date: 20171024
-- Description:	transforma nombre de role a id
-- =============================================
CREATE FUNCTION cat.func_get_id_role
(
	-- Add the parameters for the function here
	@name nvarchar(64)
)
RETURNS char(36)
AS
BEGIN
	-- Declare the return variable here
	return (select id_role from cat.roles with (nolock)
				where _role_name = @name and active = 1)

END
GO

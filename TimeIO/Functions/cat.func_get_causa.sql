SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		rsanchez
-- Create date: 20180218
-- Description:	obtenemos causa text 
-- =============================================
CREATE FUNCTION cat.func_get_causa
(
	-- Add the parameters for the function here
	@cau char(36)
)
RETURNS nvarchar(128)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @causa nvarchar(128)

	-- Add the T-SQL statements to compute the return value here
	SELECT @causa = _causa from cat.causa where id_causa = @cau

	-- Return the result of the function
	RETURN @causa

END
GO

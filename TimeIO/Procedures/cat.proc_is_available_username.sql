SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		rsanchez
-- Create date: 20171215
-- Description:	Verifica Existencia de usuario de dominio
-- =============================================
CREATE PROCEDURE cat.proc_is_available_username
	@username nvarchar(64)
	,@available bit OUTPUT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if(exists(select operator_id from cat.operator 
			where _username = @username))
		set @available = 0;
	else
		set @available = 1;
END
GO

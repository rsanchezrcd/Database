SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		rsanchez
-- Create date: 20171215
-- Description:	Verifica Existencia de usuario de dominio
-- =============================================
CREATE PROCEDURE cat.proc_get_available_users
	 @users nvarchar(max)	
AS
BEGIN	
	SET NOCOUNT ON;

	select u._part [_username]
	from cat.func_split(@users,',') u
    left join cat.operator o on o._username = u._part
	where o.operator_id is null and u._part is not null;
END
GO

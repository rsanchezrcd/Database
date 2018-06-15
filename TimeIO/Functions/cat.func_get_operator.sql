SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		rsanchez
-- Create date: 20171020
-- Description:	obtiene el username
-- =============================================
CREATE FUNCTION [cat].[func_get_operator]
(
	-- Add the parameters for the function here
	@ope char(36)
)
RETURNS nvarchar(64)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @user nvarchar(64)
	set @user = '';
	if @ope = 'INTERFACE-VACACIONES-000000000-00000' begin
		set @user = 'IFC-VACACIONES';
	end;
	if @ope = 'INTERFACE-INCAPACIDA-DES000000-00000' begin
		set @user = 'IFC-INCAPACIDADES';
	end;

	if @ope = 'INTERFACE-AUSENTISMO-S00000000-00000' begin
		set @user = 'IFC-AUSENTISMOS';
	end;
	if @ope = 'AUTOMATIC-O000000000-000000000-00000' begin
		set @user = 'AUTOMATICO';
	end;
	
	if @ope = 'INTERFACE-BAJAS00000-000000000-00000' begin
		set @user = 'IFC-BAJAS';
	end;
	if @user = '' begin
		select @user = _username from cat.operator with (nolock)
		where operator_id = @ope;
	end;	
	-- Return the result of the function
	RETURN @user
END
GO

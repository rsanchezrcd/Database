SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		rsanchez
-- Create date: 20171020
-- Description:	obtiene el username
-- =============================================
CREATE FUNCTION [cat].[func_get_id_operator]
(
	-- Add the parameters for the function here
	@ope nvarchar(64)
)
RETURNS char(36)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @id nvarchar(64)
	set @id = '';
	if @ope = 'IFC-VACACIONES' begin
		set @id = 'INTERFACE-VACACIONES-000000000-00000';
	end;
	if @ope = 'IFC-INCAPACIDADES' begin
		set @id = 'INTERFACE-INCAPACIDA-DES000000-00000';
	end;
    if @ope = 'IFC-AUSENTISMOS' begin
		set @id = 'INTERFACE-AUSENTISMO-S00000000-00000';
	end;
	if @ope = 'AUTOMATICO' begin
		set @id = 'AUTOMATIC-O000000000-000000000-00000';
	end;
	if @ope = 'IFC-BAJAS' begin
		set @id = 'INTERFACE-BAJAS00000-000000000-00000';
	end;

	if @id = '' begin
		select @id = operator_id from cat.operator with (nolock)
		where _username = @ope;
	end;	
	-- Return the result of the function
	RETURN @id
END

GO

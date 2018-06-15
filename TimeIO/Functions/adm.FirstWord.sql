SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [adm].[FirstWord] (@value varchar(max))
RETURNS varchar(max)
AS
BEGIN
    RETURN CASE CHARINDEX(' ', @value, 1)
        WHEN 0 THEN @value
        ELSE SUBSTRING(@value, 1, CHARINDEX(' ', @value, 1) - 1) END
END
GO

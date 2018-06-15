SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE function [cat].[func_get_letra] (
	@id char(36)
) returns nvarchar(3)
as begin
	declare @letra nvarchar(3);
	select @letra = _letra 
	from cat.ausentismos with(nolock)
	where id_ausentismo = @id;
	return (@letra);
end;
GO

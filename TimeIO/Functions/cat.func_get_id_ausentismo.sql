SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE function [cat].[func_get_id_ausentismo] (
	@letra char(1)
) returns char(36)
as begin
	declare @id char(36);
	select @id = id_ausentismo 
	from cat.ausentismos with(nolock)
	where _letra = @letra;
	return (@id);
end;
GO

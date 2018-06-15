SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create function [cat].[func_get_letra_descr] (
	@letra char(1)
) returns nvarchar(128)
as begin
	
	declare @desc nvarchar(3);
	select @desc = rtrim(_descripcion) 
	from cat.ausentismos with(nolock)
	where _letra= @letra;
	return (@desc);
end;
GO

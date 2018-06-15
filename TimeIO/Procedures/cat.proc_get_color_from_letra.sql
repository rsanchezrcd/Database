SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create procedure cat.proc_get_color_from_letra
	@letra char(1)
	,@color nvarchar(64) OUTPUT
as begin
	select @color = _color from cat.ausentismos
	where _letra = @letra and active = 1;
end
GO

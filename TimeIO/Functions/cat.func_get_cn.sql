SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create function cat.func_get_cn (
	@fecha datetime
) returns nvarchar(3)
as begin
	declare @cn nvarchar(3);
	select @cn = _cn from adm.fechas
	where fecha_nat = @fecha;
	return (@cn);
end;
GO

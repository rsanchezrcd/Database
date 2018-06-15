SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create proc adm.proc_get_param
	@parametro nvarchar(32)
as begin
	select _valor from adm.parametros
	where 
			_parametro = @parametro
		and active = 1
end;
GO

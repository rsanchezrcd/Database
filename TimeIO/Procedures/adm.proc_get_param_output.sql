SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create proc [adm].[proc_get_param_output]
	@parametro nvarchar(32)
	,@value nvarchar(128) OUTPUT
as begin
	select @value = _valor from adm.parametros
	where 
			_parametro = @parametro
		and active = 1;
	return
	
end;
GO

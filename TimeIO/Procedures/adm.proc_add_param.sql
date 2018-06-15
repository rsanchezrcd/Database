SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create proc adm.proc_add_param
	@parametro nvarchar(32)
	,@valor nvarchar(256)
	,@convert_to nvarchar(32)
	,@active bit
	,@op char(36)
	
as begin
	begin try
		begin transaction
			insert into adm.parametros (_parametro, _valor, _convert_to, active, insert_operator_id)
			values (@parametro,@valor, @convert_to, @active,@op);
		commit transaction
	end try
	begin catch
		rollback transaction
	end catch
end;
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [cat].[proc_add_departamento_to_ope]
	 @do_ope char(36)
	,@ope char(36)
	,@dep char(36)
as begin
	set nocount on
	begin try
		set transaction isolation level read uncommitted
		begin transaction
			insert into cat.departamento_operator(id_departamento,id_operator,insert_operator_id)
			values(@dep,@ope,@do_ope);
		commit transaction
	end try
	begin catch
		print 'Error: ' + error_message();
		print 'Linea: ' + convert(nvarchar(11),error_line());

		rollback transaction
	end catch
	set nocount off
end;


GO

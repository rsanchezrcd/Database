SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure adm.proc_add_log
	 @do_ope char(36)
	,@log nvarchar(128)
	,@tabla nvarchar(128)
	,@del bit = 0
	,@ins bit = 0
	,@upd bit = 0
	,@affected_operator char(36) = null
	,@affected_column sysname = null
	,@affected_column_value nvarchar(128) = null
as begin
	set nocount on;
	begin try
		set transaction isolation level read uncommitted
		begin transaction
			declare @q nvarchar(max)
			set @q = 'insert into '+@log+' (_tabla, id_operator, _delete,_insert,_update, _affected_operator,_affected_column,_affected_column_value)
					  values('''+@tabla+''', '''+@do_ope+''', '+rtrim(@del)+','+rtrim(@ins)+','+rtrim(@upd)+', '''+@affected_operator+''', '''+@affected_column+''','''+@affected_column_value+''')';
			exec(@q)

			declare @valor nvarchar(11); 
			exec [adm].[proc_get_param_output] @parametro = 'keep_logs_for_ndays', @value = @valor output;

			set @q = 'delete from '+@log+' where fecha_insert < dateadd(day, -'+@valor+', getdate())';
			exec(@q)
		commit transaction
	end try
	begin catch
		declare @number int = ERROR_NUMBER()
				,@severity int = ERROR_SEVERITY()
				,@state int = ERROR_STATE()
				,@procedure nvarchar(128) = ERROR_PROCEDURE()
				,@line int= ERROR_LINE()
				,@message nvarchar(4000) = ERROR_MESSAGE();
		exec log.proc_add_error_log
				@ope = @do_ope
				,@error_number = @number
				,@error_severity = @severity
				,@error_state = @state
				,@error_procedure = @procedure
				,@error_line = @line
				,@error_message = @message;	
		print 'Error: ' + error_message();
		print 'Line: ' + rtrim(error_line());	
		rollback transaction
	end catch
end;
GO

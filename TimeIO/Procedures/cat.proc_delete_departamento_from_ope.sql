SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create procedure cat.proc_delete_departamento_from_ope
	 @ope char(36)
	,@dep char(36)
	,@log bit = 0
	,@do_ope char(36) = null
as begin
	set nocount on
	begin try
		set transaction isolation level read uncommitted;
		begin transaction
			-- Eliminamos registro
			delete from cat.departamento_operator
			where id_operator = @ope and id_departamento = @dep;
			-- Escribimos log
			if @log = 1 and @do_ope is not null begin
				exec [adm].[proc_add_log]
					@do_ope
					,'cat.log_'
					,'cat.departamento_operator'
					,1,0,0
					,@ope
					,'id_departamento'
					,@dep;				
			end;			
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
end


GO

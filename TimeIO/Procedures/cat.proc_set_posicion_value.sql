SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure cat.proc_set_posicion_value
	 @column nvarchar(64)
	,@pos char(36)
	,@val bit 
	,@do_ope char(36) = null
	,@log bit = 1
as begin
	set nocount on;
	begin try
		set transaction isolation level read uncommitted;
		begin transaction
			declare @query nvarchar(3000)
			
			set @query = '
			update cat.posicion
				set '+rtrim(@column)+' = '+rtrim(@val)+'
					,update_operator_id = '''+rtrim(@do_ope)+'''
			where 
					posicion_id = '''+rtrim(@pos)+'''
				and active = 1;';

			exec(@query)		
			
			if @log = 1 and @do_ope is not null begin
				exec [adm].[proc_add_log]
					@do_ope
					,'cat.log_'
					,'cat.posicion'
					,0,0,1
					,@pos
					,@column
					,@val;				
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

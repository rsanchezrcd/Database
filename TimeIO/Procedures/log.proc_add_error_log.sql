SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create procedure log.proc_add_error_log
	 @ope char(36)
	 ,@error_number int = null
	 ,@error_severity int = null
	 ,@error_state int = null
	 ,@error_procedure nvarchar(128)
	 ,@error_line int
	 ,@error_message nvarchar(4000)
as begin
	set nocount on;

	declare @valor int; 
	exec [adm].[proc_get_param_output] @parametro = 'keep_logs_for_ndays', @value = @valor output;

	delete from log.error where fecha_insert < dateadd(day, -@valor, getdate());

	insert into log.error( id_operator,_error_number,_error_severity,_error_state,_error_procedure,_error_line,_error_message)
	values (@ope
			,@error_number
			,@error_severity
			,@error_state
			,@error_procedure
			,@error_line
			,@error_message
	);

end
GO

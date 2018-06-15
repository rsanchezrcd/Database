SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		rsanchez	
-- Create date: 20170912
-- Description:	Envio de Notificación bajo determinado
--				numero de eventos.
-- =============================================
CREATE TRIGGER log.tr_notifica_errores
   ON  log.error
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @c int 

	select @c = count(*)
	from log.error where fecha_insert >= DATEADD(hour, -24, getdate())

	if @c >= 10 begin
		DECLARE @html nvarchar(MAX);
		EXEC adm.[proc_query_to_html] 
				@html = @html OUTPUT,  
				@orderBy = 'order by fecha_insert desc',
				@query = 'select a.* from (select top 10
							e.id_error
							,e.fecha_insert
							,e._error_procedure
							,e._error_message
							,e._error_line
							--,e._error_severity
							,o._username
						from [log].[error] e
						inner join [cat].[operator ]o on o.operator_id = e.id_operator
						where fecha_insert >= DATEADD(hour, -24, getdate())
						order by fecha_insert desc) a';
		
		
		
		-----------------------------------------------
		-- Envio de Notificación.
		-----------------------------------------------
		declare @profile nvarchar(128), @recipient nvarchar(512);		 
		exec [adm].[proc_get_param_output] @parametro = 'databasemail_profile', @value = @profile output;
		exec [adm].[proc_get_param_output] @parametro = 'databasemail_recipient', @value = @recipient output;
		EXEC msdb.dbo.sp_send_dbmail  
				@profile_name = @profile,  
				@recipients = @recipient, 
				@body = @html,  
				@body_format = 'HTML',
				@subject = 'Errores en AsistenciaRCD [Asistencia][MEX]';

	end;

	
   

END
GO

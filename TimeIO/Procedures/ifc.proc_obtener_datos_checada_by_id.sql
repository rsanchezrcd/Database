SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


create proc [ifc].[proc_obtener_datos_checada_by_id]
	 @in_id char(36)
	,@in_vw nvarchar(128)  
	,@out_checada_src datetime OUTPUT		
	,@out_dispositivo nvarchar(64) OUTPUT
	,@out_codigo_src int OUTPUT			
	,@out_access bit OUTPUT
	,@out_dn char(2) OUTPUT
	
as begin
	begin try
		SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
		begin transaction
			-----------------------------------------------------------------
			declare @query nvarchar(max);
			declare @checadas table (id char(36)
									,_checada_src datetime 		
									,_dispositivo nvarchar(64) 
									,_codigo_src int 			
									,_access bit
									,_dn char(2) );
			-----------------------------------------------------------------
			set @query = 'select 
								id 
								,_checada_src  		
								,_dispositivo  
								,_codigo_src  			
								,_access 
								,_dn 
							from ' + @in_vw + ' where id = ''' + @in_id+ '''';
			
			-----------------------------------------------------------------
			insert into @checadas
			exec(@query);
			-----------------------------------------------------------------

			select	 
				 @out_codigo_src = _codigo_src
				,@out_checada_src = _checada_src
				,@out_access = _access
				,@out_dispositivo = _dispositivo
				,@out_dn = _dn
			from 		
				@checadas
			where id = @in_id; 
			-----------------------------------------------------------------
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
				@ope = 'INTERFACE'
				,@error_number = @number
				,@error_severity = @severity
				,@error_state = @state
				,@error_procedure = @procedure
				,@error_line = @line
				,@error_message = @message;	
		print 'Error: ' + error_message();
		print 'Linea: ' + convert(nvarchar(11),error_line());

		rollback transaction
	end catch
end
GO

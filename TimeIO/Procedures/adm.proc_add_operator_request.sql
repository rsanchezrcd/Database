SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [adm].[proc_add_operator_request]
	 @ope char(36)
	,@emp char(36)
	,@loc char(36)
	,@rol char(36)
	,@correo nvarchar(128)
	,@id_mail char(36)
	,@departamentos nvarchar(max)
	,@result bit OUTPUT
	,@msg nvarchar(128) OUTPUT
	,@sql_error nvarchar(max) = null OUTPUT
	,@id int OUTPUT
as begin

	set nocount on;
	set transaction isolation level read uncommitted;
	begin try	
		begin transaction
			declare @idt table (_id int);

			if (not exists (select id_operator_request from adm.operator_request
							where id_employee = @emp and _atendida = 0) and
				not exists (select operator_id from cat.operator
							where employee_id = @emp and active = 1)) begin
				---------------------------------------------------------------------
				-- Insertamos datos de solicitud
				---------------------------------------------------------------------
				insert into adm.operator_request(insert_operator_id,id_employee,id_role,id_locacion,_correo,id_email, _atendida)
				output inserted.id_operator_request into @idt
				values (@ope,@emp,@rol,@loc,@correo,@id_mail,0);
				---------------------------------------------------------------------v
				-- Obtenemos el id de la solicitud
				---------------------------------------------------------------------
				select @id = _id from @idt;
				---------------------------------------------------------------------
				-- Insertamos los deprtamentos
				---------------------------------------------------------------------
				insert into adm.ope_req_dep(id_operator_request, id_departamento)
				select @id, _part 
				from cat.func_split(@departamentos,',');

				DECLARE @html nvarchar(MAX), @q nvarchar(MAX);
				set @q = 'select 							 
							 [column] [Time.io]
							,[value] [Solicitud Usuario]
						from adm.vw_request_operator_dbmail 
						unpivot(
							[value]
							for [column] in ([#Solicitud],[Fecha], [Codigo Empleado],[Nombre Empleado],[Rol Solicitado],[Solicitante],[Url])
						)unpiv
						where [id_request] = '+ rtrim(@id);
				EXEC [adm].[proc_query_to_html] 
						@html = @html OUTPUT,  
						@orderBy = '',
						@query = @q;
				-----------------------------------------------
				-- Envio de Notificación.
				-----------------------------------------------
				DECLARE	@profile nvarchar(128), @rec nvarchar(128),@sol nvarchar(128)
				EXEC	[adm].[proc_get_param_output]
						@parametro = N'databasemail_profile',
						@value = @profile OUTPUT

				select @rec = _soporte_mail from cat.locacion where locacion_id = @loc;
				select @sol = _email from cat.operator where operator_id = @ope;

				if @sol is not null begin 
					set @rec = @rec + ';'+@sol;
				end

				declare @s nvarchar(255) = '#'+ rtrim(@id) + ' | Nueva Solicitud de Usuario | AsistenciaRCD';
				EXEC msdb.dbo.sp_send_dbmail  
						@profile_name = @profile, 
						@recipients = @rec, 
						@body = @html,  
						@body_format = 'HTML',
						@subject = @s,
						@exclude_query_output = 1;
				---------------------------------------------------------------------
				-- Resultados
				---------------------------------------------------------------------


				set @result = 1;
				set @msg = 'Solicitud Enviada...';
				---------------------------------------------------------------------
			end else begin
				set @result = 1;
				set @msg = 'El usuario ya existe o ya fue solicitado...';
			end
		commit transaction
	end try
	begin catch		
		rollback transaction
		set @sql_error = ERROR_MESSAGE();
		set @msg = 'Error en SQL';
		set @result = 0;
		set @id = 0;
	end catch

	--truncate table [adm].[ope_req_dep]
	--truncate table [adm].[operator_request]
	/*delete from [adm].[operator_request]
	DBCC CHECKIDENT ('[adm].[operator_request]',RESEED, 0)
	DBCC CHECKIDENT ('[adm].[ope_req_dep]',RESEED, 0)*/

end




GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [adm].[proc_add_operator_domain_solicitud]
	 @solicitud int
	,@employee_id char(36)
	,@username nvarchar(64)
	,@domain nvarchar(64)
	,@correo nvarchar(128)
	,@id_role char(36)	
	,@do_ope char(36)
	,@deptos nvarchar(max) = null
	,@result bit OUTPUT
	,@msg nvarchar(512) OUTPUT 
as begin 
	set nocount on;
	
	begin try
		begin transaction
			declare @idt table (_id char(36))
			declare   @dep char(36)
					, @ope char(36)
					, @name nvarchar(64)
					, @lastname nvarchar(64);

			select top 1 
				 @dep = departamento_id 
				,@name = _nombres
				,@lastname = _apellido_paterno
			from cat.employees 
			where employee_id = @employee_id;  
			-- insertamos operador
			insert into cat.operator(employee_id
									,_username
									,_ad_user
									,_domain
									,_name
									,_lastname
									,_email
									,_is_admin
									,id_role	
									,id_departamento								
									,insert_operator_id) 
			output inserted.operator_id into @idt(_id)
			values
			(@employee_id, @username, 1, @domain ,@name, @lastname, @correo, 0,@id_role,@dep,@do_ope);
			
			select @ope = _id from @idt
			if @deptos is not null begin
				-- insertar deptos por parametro.
				insert into cat.departamento_operator(insert_operator_id, id_departamento, id_operator)
				select @do_ope,_part,@ope 
				from cat.func_split(@deptos,',');
				
			end else begin 
				-- insertamos departamento por default.	
				exec [cat].[proc_add_departamento_to_ope] @do_ope, @ope, @dep;
			end;
			exec cat.proc_inserta_permisos_role @ope, @id_role, @do_ope, @result OUTPUT
			-- resultados			
			set @msg = 'Usuario Insertado'
			update adm.operator_request
				set _atendida = 1
			where id_operator_request = @solicitud;

			---------------------------------------------
				declare @loc char(36)
				DECLARE @html nvarchar(MAX), @q nvarchar(MAX), @usuario nvarchar(64),@usu nvarchar(128);
				select @usu = _email, @usuario = _username from cat.operator where employee_id = @employee_id;
				set @q = 'select 							 
							 [column] [Time.io]
							,[value] [Solicitud Usuario]
							
						from adm.vw_request_operator_dbmail 
						unpivot(
							[value]
							for [column] in ([#Solicitud],[Fecha], [Codigo Empleado],[Nombre Empleado],[Rol Solicitado],[Solicitante],[Url])
						)unpiv
						where [id_request] = '+ rtrim(@solicitud) + '
						union all
						select ''Usuario'', '''+rtrim(@usuario)+'''';
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
				select @loc = locacion_id from  cat.employees where employee_id = @employee_id;
				select @rec = _soporte_mail from cat.locacion where locacion_id = @loc;
				select @sol = _email from cat.operator where operator_id = @ope;
				

				if @sol is not null begin 
					set @rec = @rec + ';'+@sol + ';' + @usu;
				end

				declare @s nvarchar(255) = '#'+ rtrim(@solicitud) + ' | Solicitud de Usuario Completada | AsistenciaRCD';
				EXEC msdb.dbo.sp_send_dbmail  
						@profile_name = @profile, 
						@recipients = @rec, 
						@body = @html,  
						@body_format = 'HTML',
						@subject = @s,
						@exclude_query_output = 1;

		commit transaction
	end try
	begin catch
		rollback transaction
		set @result = 0;
		set @msg = 'Error: ' + ERROR_MESSAGE()
	end catch
end;

GO

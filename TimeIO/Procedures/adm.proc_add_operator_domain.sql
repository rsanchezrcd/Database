SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [adm].[proc_add_operator_domain]
	@employee_id char(36)
	,@username nvarchar(64)
	,@domain nvarchar(64)
	,@name nvarchar(64) 
	,@lastname nvarchar(64) 
	,@id_role char(36)	
	,@do_ope char(36)
	,@result bit OUTPUT
	,@msg nvarchar(512) OUTPUT 
as begin 
	set nocount on;
	
	begin try
		begin transaction
			declare @idt table (_id char(36))
			declare @dep char(36), @ope char(36)

			select top 1 @dep = departamento_id from cat.employees 
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
			(@employee_id, @username, 1, @domain ,@name, @lastname, '', 0,@id_role,@dep,@do_ope);
			
			-- insertamos departamento por default
			select @ope = _id from @idt
			exec [cat].[proc_add_departamento_to_ope] @do_ope, @ope, @dep
			
			exec cat.proc_inserta_permisos_role @ope, @id_role, @do_ope, @result OUTPUT
			-- resultados			
			set @msg = 'Usuario Insertado'
		commit transaction
	end try
	begin catch
		rollback transaction
		set @result = 0;
		set @msg = 'Error: ' + ERROR_MESSAGE()
	end catch
end;

GO

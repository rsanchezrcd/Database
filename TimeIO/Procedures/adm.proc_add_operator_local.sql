SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [adm].[proc_add_operator_local]
	@employee_id char(36)
	,@username nvarchar(64)
	,@password varchar(max)
	,@salt char(36)
	,@name nvarchar(64) 
	,@lastname nvarchar(64) 
	,@email nvarchar(128) 
	,@is_admin bit
as begin 
	
	insert into cat.operator(employee_id, _username, _password, _salt,_name, _lastname, _email, _is_admin) values
	(@employee_id, @username, @password, @salt,@name, @lastname, @email, @is_admin);
end;
GO

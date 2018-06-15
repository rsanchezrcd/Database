SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

create proc adm.proc_add_conexion	
	@name varchar(32)  
	,@engine varchar(32)   
	,@server varchar(128)   
	,@port int
	,@user varchar(32) 
	,@pass varchar(32) 
	,@data varchar(32)
	,@id_operator char(36)
as begin
	insert into adm.conexiones(_name ,_engine ,_server ,_port ,_user ,_pass ,_data ,insert_operator_id)
	values(@name, @engine, @server, @port, @user, @pass, @data, @id_operator);
end;

GO

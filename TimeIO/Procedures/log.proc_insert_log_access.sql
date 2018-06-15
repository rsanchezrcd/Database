SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

create proc [log].proc_insert_log_access
	@id_operator char(36)
	,@from_ip nvarchar(15)
	,@from_hostname nvarchar(32)
as begin
	insert into [log].accesos (id_operator,_from_ip,_from_hostname)
	values (@id_operator,@from_ip, @from_hostname);
end;
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
  create proc cat.proc_add_role
	@ope char(36)
	,@name nvarchar(64)
	,@desc nvarchar(128)
as begin
	insert into cat.roles(insert_operator_id,_role_name,_role_descr)
	values(@ope,@name,@desc);
end;
GO

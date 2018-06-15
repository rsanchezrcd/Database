SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
  create proc adm.[proc_add_query]
	@ope char(36)
	,@name nvarchar(64)
	,@scrp nvarchar(128)
as begin
	insert into adm.queries(insert_operator_id,_query_name,_query_script)
	values(@ope,@name,@scrp);
end;
GO

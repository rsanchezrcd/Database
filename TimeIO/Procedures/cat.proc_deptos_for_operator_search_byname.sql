SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [cat].[proc_deptos_for_operator_search_byname]
	@name nvarchar(32) = '%'	
as begin
	
	select  id_departamento,	[_departamento_code], [_departamento_name]	, active
	from cat.departamentos
	where 	[_departamento_name] like '%'+@name+'%'				
	and active = 1
	order by [_departamento_name] asc
end
GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create proc [cat].proc_roles_for_operator_search_byname
	@name nvarchar(64) = '%'	
as begin
	if @name is null set @name = '%';	

	select id_role,	_role_name,	_role_descr, active
	from cat.roles
	where 	_role_name like '%'+@name+'%'				
	and active = 1
	order by _role_name asc
end
GO

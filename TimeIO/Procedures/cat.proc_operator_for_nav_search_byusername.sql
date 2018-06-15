SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [cat].[proc_operator_for_nav_search_byusername]
	@username nvarchar(64)
as begin 
	if @username = '' return;
	select 
		operator_id
		,_username
		,_name
		,_lastname
		,active
	from cat.operator
	where active = 1 and _username like '%'+ @username +'%'
	order by _username asc;
end;

GO

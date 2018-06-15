SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create proc cat.proc_operator_for_nav_search_byname
	@name nvarchar(64) = '%'
	,@lastname nvarchar(64) = '%'
	--,@maidenname nvarchar(64) = '%'
as begin
	if @name is null set @name = '%';
	if @lastname is null set @lastname = '%';
	--if @maidenname is null set @maidenname = '%';

	select operator_id,	_username,	_name,	_lastname, active
	from cat.operator
	where 	_name like '%'+@name+'%'	
			and _lastname like '%'+@lastname+'%'	
			--and _maidenname like '%'+@maidenname+'%'	
	and active = 1
	order by _username asc
end
GO

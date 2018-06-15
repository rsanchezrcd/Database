SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [cat].[proc_employees_for_operator_search_byname]
	@name nvarchar(64) = '%'
	,@lastname nvarchar(64) = '%'
	,@maidenname nvarchar(64) = '%'
as begin
	if @name is null set @name = '%';
	if @lastname is null set @lastname = '%';
	if @maidenname is null set @maidenname = '%';

	select employee_id,	_alter_id
		,	adm.FirstWord(rtrim(_name)) [_name]
		,	adm.FirstWord(rtrim(_lastname)) [_lastname]
		,	adm.FirstWord(rtrim(_maidenname)) [_maidenname]
		,	active
	from cat.vw_employees_for_operator
	where 	_name like '%'+@name+'%'	
			and _lastname like '%'+@lastname+'%'	
			and _maidenname like '%'+@maidenname+'%'	
	and active = 1
	order by _alter_id asc
end
GO

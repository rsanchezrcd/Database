SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [cat].[proc_objects_by_name]	
	@schema_name nvarchar(64) = '%'
	,@object_name nvarchar(64) = '%'
as begin
	
	if @schema_name is null set @schema_name = '%';
	if @object_name is null set @object_name = '%';

	select 
		 object_id
		,[_item_name]
		,[_schema_name]
		,[_object_name]			
		,active
	from adm.vw_sys_objects	where 		
			 _schema_name like '%'+@schema_name+'%'	
			and _object_name like '%'+@object_name+'%'	
	
	order by _item_name asc
end

GO

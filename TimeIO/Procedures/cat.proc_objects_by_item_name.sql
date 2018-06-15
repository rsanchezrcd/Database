SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [cat].[proc_objects_by_item_name]	
	@item_name nvarchar(64) = '%'
	
as begin
	
	if @item_name is null set @item_name = '%';
	

	select 
		 object_id
		,[_item_name]
		,[_schema_name]
		,[_object_name]			
		,active
	from adm.vw_sys_objects	where 		
			 _item_name like '%'+@item_name+'%'	
			
	
	order by _item_name asc
end
GO

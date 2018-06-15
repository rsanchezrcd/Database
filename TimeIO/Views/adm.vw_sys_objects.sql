SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE view adm.vw_sys_objects as
select 	
	s.schema_id
	,o.object_id
	,s.name [_schema_name]
	,o.name [_object_name]	
	,s.name +'.'+o.name [_item_name]
	,1 [active]
from sys.objects o 
	inner join sys.schemas s on o.schema_id = s.schema_id
where type = 'U'
GO

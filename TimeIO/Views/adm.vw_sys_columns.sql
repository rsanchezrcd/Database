SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE view adm.vw_sys_columns as
select 
	c.name [_column_name]
	,c.column_id [_order]
	,o.object_id 
	,c.max_length [_size]
from sys.columns c
inner join sys.objects o on c.object_id = o.object_id
where o.type = 'U'
GO

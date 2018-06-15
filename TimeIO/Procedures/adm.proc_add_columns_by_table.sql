SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create proc adm.proc_add_columns_by_table
	 @tabla nvarchar(128) 
as begin
declare @tabla_n nvarchar(128) = @tabla;
declare @op char(36) = (select operator_id from cat.operator where LOWER(_username) = 'administrator')
declare @nav char(36) = (select id_navigator from adm.navigator where LOWER(_table) = @tabla)
declare @ind int;
set @ind = CHARINDEX('.',@tabla, 0);
set @tabla = SUBSTRING(@tabla,@ind+1, len(@tabla));
insert into adm.columnas (id_navigator,_tabla
		,_columna
		,_label
		,_width
		,_special_class
		,_title
		,_input_type
		,_required
		,_prefix
		,_order
		,_align
		,insert_operator_id)
select 
	@nav [id_navigator]
	,@tabla_n [_tabla]
	,c.name [_columna]  
	,replace(c.name,'_','') [_label]
	,case when not c.name like '[_]%' then
		 case when c.name = 'active' then 32 else 0 end
	else c.max_length end [_width]
	,case   
		when c.name not like '[_]%' then 'noinput' 
		when c.name = 'active' then 'checkbox' else 'input' end [_special_class]
	,replace(c.name,'_','') [_title]
	,case when not c.name like '[_]%' then null else 'text' end [_input_type]
	,case when not c.name like '[_]%' then 0 else 1 end [_required]
	,case when not c.name like '[_]%' then null else 'tb_' end [_prefix]
	,column_id [_order]
	,case when c.name = 'active' then 'center' else 'left' end [_align]
	,@op [insert_operator_id]
from sys.columns c
inner join sys.tables t on c.object_id = t.object_id
where 
	t.name = @tabla 
and (c.name like '[_]%'
	or c.name = 'active'
	or c.name like 'id[_]%'
	or c.name like '%[_]id')
and c.name not like 'insert%'
and c.name not like 'update%'
end;
GO

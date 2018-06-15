SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc adm.create_html_edit_from_row
	@table nvarchar(64)
	,@id_field nvarchar(64)
	,@id char(36)
	,@fields_values nvarchar(max) --formato html
	,@fields_names nvarchar(max)
	,@extra nvarchar(max) = null

as begin
	declare @query nvarchar(max)
	set @query = ' select ' + @id_field + ', columna, value from ( 
				select ' + @fields_values + ' from ' + @table + ' where ' + @id_field + ' = ''' + @id + ''') d
				unpivot (value for columna in ('+@fields_names+')) unpiv';
	exec (@query);
end
GO

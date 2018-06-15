SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [adm].[proc_get_columnas]
	@id_navigator char(36)
as begin
	select 
		id_columna
		,_tabla
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
		,_has_options
		,_options_source
		,_options_id
		,_options_show
		,_needed
	from adm.columnas 
	where id_navigator = @id_navigator and active = 1
	order by _order asc;
end;
GO

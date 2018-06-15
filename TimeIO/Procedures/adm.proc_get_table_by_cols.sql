SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create proc adm.proc_get_table_by_cols
 @columnas nvarchar(max) 
,@tabla nvarchar(128) 
as begin
	declare @query nvarchar(max);
	set @query = 'select ' + @columnas + ' from ' + @tabla+ ';'
	exec (@query);
end
GO

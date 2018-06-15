SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [adm].[proc_get_val]
	@field nvarchar(32)
	,@table nvarchar(32)
	,@where nvarchar(32)
	,@where_val varchar(max)
	,@type nvarchar(32)
	,@active nvarchar(1)
as begin
	declare @query nvarchar(max) =
	'select '+@field+' from ' + @table +'
		where 
			'+@where+' = convert('+@type+','''+@where_val+''')
		and active = '+@active+';'
	exec sys.sp_sqlexec @query;
end;
GO

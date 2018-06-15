SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create proc adm.proc_get_permiso_by_url_op
	@id_navigator char(36)
	,@id_operator char(36)
	,@field nvarchar(32)
as begin
	declare @query nvarchar(1024);
	set @query = 'select ' + @field+ ' from adm.nav_by_ope 
		where id_navigator = '''+@id_navigator + ''' and id_operator =  ''' + @id_operator +''' and active = 1' ;
	
	--select @query;
	exec sys.sp_sqlexec @query;
end;
GO

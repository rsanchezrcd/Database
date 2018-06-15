SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [tra].[proc_get_cn_val] (
	  @cn nvarchar(4)
	 ,@emp char(36)
	 ,@per char(36)
	 ,@value nvarchar(3) OUTPUT
) 
as begin
	SET NOCOUNT ON;
	declare @sqlCommand nvarchar(512) = 'select @val = ' +ltrim(rtrim(@cn))+' from tra.lista where id_employee = '''+@emp+''' and id_periodo = '''+ @per+ '''';
	exec sp_executesql @sqlCommand , N'@val nvarchar(3) OUTPUT', @val = @value OUTPUT	
	
end;

GO

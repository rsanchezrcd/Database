SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [adm].[proc_query_to_html] 
(
  @query nvarchar(MAX), --A query to turn into HTML format. It should not include an ORDER BY clause.
  @orderBy nvarchar(MAX) = NULL, --An optional ORDER BY clause. It should contain the words 'ORDER BY'.
  @html nvarchar(MAX) = NULL OUTPUT --The HTML output of the procedure.
)
AS
BEGIN   
  SET NOCOUNT ON;

  IF @orderBy IS NULL BEGIN
    SET @orderBy = ''  
  END
  --print @query;
  SET @orderBy = REPLACE(@orderBy, '''', '''''');

  DECLARE @realQuery nvarchar(MAX) = '	
	DECLARE @fecha nvarchar(128);
    DECLARE @headerRow nvarchar(MAX);
    DECLARE @cols nvarchar(MAX);    

    SELECT * INTO #dynSql FROM (' + @query + ') sub;

    SELECT @cols = COALESCE(@cols + '', '''''''', '', '''') + ''['' + name + ''] AS ''''td''''''
    FROM tempdb.sys.columns 
    WHERE object_id = object_id(''tempdb..#dynSql'')
    ORDER BY column_id;

    SET @cols = ''SET @html = CAST(( SELECT '' + @cols + '' FROM #dynSql ' + @orderBy + ' FOR XML PATH(''''tr''''), ELEMENTS XSINIL) AS nvarchar(max))''    

    EXEC sys.sp_executesql @cols, N''@html nvarchar(MAX) OUTPUT'', @html=@html OUTPUT

    SELECT @headerRow = COALESCE(@headerRow + '''', '''') + ''<th><font color="white" face="verdana" size="2">'' + name + ''</font></th>'' 
    FROM tempdb.sys.columns 
    WHERE object_id = object_id(''tempdb..#dynSql'')
    ORDER BY column_id;
	
	set @fecha =''<p>Fecha de Reporte: ''+ convert(nvarchar(19), getdate(),120)+'' </p>''
    SET @headerRow = ''<tr bgcolor="#294B72">'' + @headerRow + ''</tr>'';

    SET @html =''<table border="1" cellpadding="5" cellspacing="1" >'' + @headerRow + @html + ''</table>'' + @fecha;    
    ';

  EXEC sys.sp_executesql @realQuery, N'@html nvarchar(MAX) OUTPUT', @html=@html OUTPUT
END
GO

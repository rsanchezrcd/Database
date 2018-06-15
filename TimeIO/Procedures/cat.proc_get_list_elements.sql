SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc cat.proc_get_list_elements
	@table nvarchar(64)
	,@columns nvarchar(1024)
	,@where nvarchar(1024) = ''
	,@active bit = null
	,@distinct bit = 1
	,@verbose bit = 0
	,@orderby nvarchar(1024) = null
as begin
	set nocount on;
	declare @query nvarchar(max)
	
	--Validamos distinct
	if @distinct = 1 set @query = N'select distinct '+ rtrim(@columns)+' from '+ rtrim(@table)  else set @query =  N'select '+ rtrim(@columns)+' from '+ rtrim(@table);
	--Validamos active

	if @active is not null
		if @active = 1 set @query = @query  + ' where active = 1 ' else set @query = @query  + ' where active = 0'  ;
	
	set @where = replace(@where,'1=1', '')
	set @where = replace(@where,';', '')
	set @where = replace(@where,'--', '')
	set @where = replace(@where,'select', '')
	set @where = replace(@where,'insert', '')
	set @where = replace(@where,'delete', '')
	set @where = replace(@where,'drop', '')
	set @where = replace(@where,'create', '')
	set @where = replace(@where,'alter', '')
	
	--Validamos where
	if @active is null
		set @query = @query + ' where ' + rtrim(@where);
	else
		if LEN(rtrim(@where))>0 set @query = @query + ' and ' + rtrim(@where);

	if @orderby is not null 
		set @query = @query + ' order by ' + @orderby;
	
	set @query = replace(@query,'1=1', '')
	set @query = replace(@query,';', '')
	set @query = replace(@query,'--', '')

	if @verbose = 1 print @query;
	begin try
		begin transaction
			execute (@query)
		commit transaction
	end try
	begin catch
		print 'Error: ' + error_message()
		print @query
		rollback transaction
	end catch
end
GO

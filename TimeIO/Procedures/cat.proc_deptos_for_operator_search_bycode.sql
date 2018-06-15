SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [cat].[proc_deptos_for_operator_search_bycode]
	@code nvarchar(32) = '%'	
	,@limit bit = 0
as begin
	set nocount on;
	---------------------------------------------------------
	if @limit = 1 begin
		declare @rows int
		exec [adm].[proc_get_param_output]
				@parametro = N'rows_in_searchbox',
				@value = @rows OUTPUT
		select  
			id_departamento	
			,rtrim([_departamento_code]) [_departamento_code]
			,rtrim([_departamento_name]) [_departamento_name]	
			, active
		from cat.departamentos with(nolock)
		where [_departamento_code] like '%'+@code+'%'				
		and active = 1
		order by [_departamento_name] asc
		offset 0 rows fetch next @rows rows only;
	end;

	if @limit = 0 begin
		select  
			id_departamento	
			,rtrim([_departamento_code]) [_departamento_code]
			,rtrim([_departamento_name]) [_departamento_name]	
			, active
		from cat.departamentos with(nolock)
		where [_departamento_code] like '%'+@code+'%'				
		and active = 1
		order by [_departamento_name] asc;
	end;
	
	----------------------------------------------------------
	set nocount off;
end
GO

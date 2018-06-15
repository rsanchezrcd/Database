SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [cat].[proc_deptos_for_operator_search_bycode_or_byname]
	@code nvarchar(32) = '%'	
	,@limit bit = 0
	,@ope char(36) = null
as begin
	set nocount on;
	---------------------------------------------------------
	if @limit = 1 begin
		declare @rows int
		exec [adm].[proc_get_param_output]
				@parametro = N'rows_in_searchbox',
				@value = @rows OUTPUT
		select  
			d.id_departamento	
			,ltrim(rtrim(d.[_departamento_code])) [_departamento_code]
			,ltrim(rtrim(d.[_departamento_name])) [_departamento_name]	
			,(select count(*) from cat.employees with (nolock) where departamento_id = d.id_departamento)	[_employees]
			,d.active
			--,o.id_operator
		from cat.departamentos d with(nolock)
		left join cat.departamento_operator o with(nolock) on (o.id_departamento = d.id_departamento and o.id_operator = @ope)
		where 
				
				o.id_departamento is null
			and (d.[_departamento_code] like '%'+@code+'%'		
					or d.[_departamento_name] like '%'+@code+'%')	
			and d.active = 1
			and (select count(*) from cat.employees with (nolock) where departamento_id = d.id_departamento) > 0
		order by d.[_departamento_name] asc
		offset 0 rows fetch next @rows rows only;
	end;

	if @limit = 0 begin
		select  
			d.id_departamento	
			,rtrim(d.[_departamento_code]) [_departamento_code]
			,rtrim(d.[_departamento_name]) [_departamento_name]
			,(select count(*) from cat.employees with (nolock) where departamento_id = d.id_departamento)	[_employees]
			,d.active
		from cat.departamentos d with(nolock)
		left join cat.departamento_operator o with(nolock) on (o.id_departamento = d.id_departamento and o.id_operator = @ope)
		where 
				
			o.id_departamento is null
			and (d.[_departamento_code] like '%'+@code+'%'		
					or d.[_departamento_name] like '%'+@code+'%')	
			and d.active = 1
			and (select count(*) from cat.employees with (nolock) where departamento_id = d.id_departamento) > 0
		order by d.[_departamento_name] asc
	end;
	
	----------------------------------------------------------
	set nocount off;
end;


GO

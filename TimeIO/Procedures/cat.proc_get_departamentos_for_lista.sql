SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure cat.proc_get_departamentos_for_lista
	@ope char(36)
as begin
	set nocount on;


	select 		
		rtrim(d._departamento_code) +' - '+rtrim(d._departamento_name) text
		,a._favorite
		,a.id_departamento id
		,case when (d._father_id is null ) then '0' else d._father_id end parentid
		/*,(select 
				case count(*) when 0 then 0
							  else 1 end  
			from cat.departamento_operator with (nolock)
			where id_operator = a.id_operator and id_departamento = d._father_id ) _hasfather
		,(select 
				case count(*) when 0 then 0
							  else 1 end  
			from cat.departamento_operator A with (nolock)
			inner join cat.departamentos B with (nolock) on A.id_departamento = B.id_departamento
			where id_operator = a.id_operator and B._father_id = d.id_departamento ) _haschildren*/
		
	from cat.departamento_operator a with (nolock)
	inner join cat.departamentos d with (nolock) on d.id_departamento = a.id_departamento
	where a.id_operator = @ope
	--order by _hasfather asc , _haschildren desc, _departamento_name asc;
	----

end;
GO

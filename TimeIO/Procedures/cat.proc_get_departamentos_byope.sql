SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [cat].[proc_get_departamentos_byope]
	@ope char(36)
as begin 	
	select 
		d.id_departamento
		,rtrim(a._departamento_code) _departamento_code
		,rtrim(a._departamento_name) _departamento_name
		,(select count(*) from cat.employees e with(nolock)
			where e.departamento_id = d.id_departamento and e._status = 1 and e.active = 1) _empleados_directos
		,d._favorite
	from cat.departamento_operator d with(nolock)
	inner join cat.departamentos a with(nolock) on d.id_departamento = a.id_departamento
	where d.id_operator = @ope and a.active = 1;
end
GO

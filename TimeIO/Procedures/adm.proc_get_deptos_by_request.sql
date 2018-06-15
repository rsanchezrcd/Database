SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure adm.proc_get_deptos_by_request
	@id int
as BEGIN
	set nocount on;
	select 
		r.id_departamento
		,rtrim(d._departamento_code) [_departamento_code]
		,rtrim(d._departamento_name) [_departamento_name]
		,rtrim(d._departamento_code) + ' - ' + rtrim(d._departamento_name) [_departamento]
	from adm.ope_req_dep r
	inner join cat.departamentos d on (r.id_departamento = d.id_departamento)
	where r.id_operator_request = @id and d.active = 1;
end;
GO

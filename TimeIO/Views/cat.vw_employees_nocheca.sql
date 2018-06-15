SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create view cat.vw_employees_nocheca
as
select 
	rtrim(e._alter_id) [IDEmpleado]
	,rtrim(e._nombres) [Nombres] 
	,rtrim(e._apellido_paterno) [ApellidoPaterno]
	,rtrim(e._apellido_materno) [ApellidoMaterno]
	,e._clase [Clase]
	,l._locacion_code [IDLocacion]
	,d._departamento_code [IDDepartamento]
	,d._departamento_name [Departamento]
	,p._posicion_code [IDPosicion]
	,p._posicion_name [Posicion]
from cat.employees e
inner join cat.locacion l on e.locacion_id = l.locacion_id 
inner join cat.departamentos d on e.departamento_id = d.id_departamento 
inner join cat.posicion p on e.posicion_id = p.posicion_id
where _checa = 0 and _status = 1;

GO

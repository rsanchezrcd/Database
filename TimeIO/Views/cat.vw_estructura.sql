SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE view cat.vw_estructura as
select  
	distinct
	 e.locacion_id
	,rtrim(l._locacion_code) _locacion_code
	,rtrim(l._locacion_name) _locacion_name
	,e.departamento_id
	,rtrim(d._departamento_code) _departamento_code
	,rtrim(d._departamento_name) _departamento_name
	,e.posicion_id
	,rtrim(p._posicion_code) _posicion_code
	,rtrim(p._posicion_name) _posicion_name
	,isnull(p._festivos,0) _festivos
	,isnull(p._horas_extras,0) _horas_extras
	,isnull(p._prima_dominical,0) _prima_dominical
	,isnull(p._horas_nocturnas,0) _horas_nocturnas
	
from cat.employees e with(nolock)
inner join cat.locacion l with(nolock) on e.locacion_id = l.locacion_id
inner join cat.departamentos d with(nolock) on e.departamento_id = d.id_departamento
inner join cat.posicion p with(nolock) on e.posicion_id = p.posicion_id
where l.active = 1

GO

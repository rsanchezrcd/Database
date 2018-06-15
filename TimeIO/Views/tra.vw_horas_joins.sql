SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [tra].[vw_horas_joins] AS 

SELECT l.[id_horas_extras]
      ,l.[id_employee]
	  ,convert(int,rtrim(e._alter_id)) _alter_id
	  ,rtrim(e._nombres) _nombres
	  ,rtrim(e._apellido_paterno) _apellido_paterno
	  ,rtrim(e._apellido_materno) _apellido_materno
      ,l.[id_periodo]
	  ,p._per
	  ,o.locacion_id
	  ,rtrim(o._locacion_code) _locacion_code
	  ,rtrim(o._locacion_name) _locacion_name
	  ,d.id_departamento
	  ,rtrim(d._departamento_code) _departamento_code
	  ,rtrim(d._departamento_name) _departamento_name
	  ,s.posicion_id
	  ,rtrim(s._posicion_code) _posicion_code
	  ,rtrim(s._posicion_name) _posicion_name
      ,l.[_horas]
	  ,l.[_pagadas]
      ,l.[_c01]
      ,l.[_c02]
      ,l.[_c03]
      ,l.[_c04]
      ,l.[_c05]
      ,l.[_c06]
      ,l.[_c07]
      ,l.[_c08]
      ,l.[_c09]
      ,l.[_c10]
      ,l.[_c11]
      ,l.[_c12]
      ,l.[_c13]
      ,l.[_c14]
      ,l.[_c15]
      ,l.[_c16]
	  ,l.[_p01]
      ,l.[_p02]
      ,l.[_p03]
      ,l.[_p04]
      ,l.[_p05]
      ,l.[_p06]
      ,l.[_p07]
      ,l.[_p08]
      ,l.[_p09]
      ,l.[_p10]
      ,l.[_p11]
      ,l.[_p12]
      ,l.[_p13]
      ,l.[_p14]
      ,l.[_p15]
      ,l.[_p16]         
     
  FROM [TimeIO].[tra].[horas_extras] l with(nolock)
  inner join [TimeIO].cat.employees e with(nolock) on (l.id_employee = e.employee_id)
  inner join [TimeIO].cat.periodos p with(nolock) on (l.id_periodo = p.id_periodo)
  inner join [TimeIO].cat.locacion o with(nolock) on (e.locacion_id = o.locacion_id)
  inner join [TimeIO].cat.departamentos d with(nolock) on (e.departamento_id = d.id_departamento)
  inner join [TimeIO].cat.posicion s with(nolock) on (e.posicion_id = s.posicion_id)
  -- where e._status = 1;



GO

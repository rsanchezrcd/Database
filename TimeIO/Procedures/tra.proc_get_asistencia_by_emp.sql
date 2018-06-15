SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [tra].[proc_get_asistencia_by_emp]
	@per char(36)
	,@emp char(36)
as BEGIN
	
	select 
		cat.func_get_periodo(f.id_periodo) _periodo
		,f._etiqueta
		,f._day_txt
		,f._cN
		,convert(varchar(10), fecha_nat,120) _fecha
		 ,(select case f._cN 
			when 'c01' then  l._c01
			when 'c02' then  l._c02
			when 'c03' then  l._c03
			when 'c04' then  l._c04
			when 'c05' then  l._c05
			when 'c06' then  l._c06
			when 'c07' then  l._c07
			when 'c08' then  l._c08
			when 'c09' then  l._c09
			when 'c10' then  l._c10
			when 'c11' then  l._c11
			when 'c12' then  l._c12
			when 'c13' then  l._c13
			when 'c14' then  l._c14
			when 'c15' then  l._c15
			when 'c16' then  l._c16
			else '' end from tra.lista l with(nolock) where l.id_periodo = f.id_periodo and l.id_employee = e.employee_id) [_letra]
		 ,isnull(convert(nvarchar(19),j._entrada, 120), '-') _entrada
		 ,isnull(convert(nvarchar(19),j._salida, 120),'-') _salida
	     ,isnull(j._jornada, 0) _jornada
		 ,(select case f._cN 
			when 'c01' then  l._c01
			when 'c02' then  l._c02
			when 'c03' then  l._c03
			when 'c04' then  l._c04
			when 'c05' then  l._c05
			when 'c06' then  l._c06
			when 'c07' then  l._c07
			when 'c08' then  l._c08
			when 'c09' then  l._c09
			when 'c10' then  l._c10
			when 'c11' then  l._c11
			when 'c12' then  l._c12
			when 'c13' then  l._c13
			when 'c14' then  l._c14
			when 'c15' then  l._c15
			when 'c16' then  l._c16
			else 0 end from tra.horas_nocturnas l with(nolock) where l.id_periodo = f.id_periodo and l.id_employee = e.employee_id) [_hn]

		 --,cat.func_get_letra
		
	from adm.fechas f with(nolock)
	inner join cat.employees e with(nolock) on (e.employee_id = @emp)
	left join tra.jornadas j with(nolock) on (f.fecha_nat = j._fecha_ent and j.employee_id = @emp)
	where 
			f.id_periodo = @per
		and f.id_fecha is not null
		
	order by fecha_int asc, _entrada asc;


end;
GO

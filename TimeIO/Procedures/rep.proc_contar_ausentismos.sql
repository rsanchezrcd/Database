SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE proc rep.proc_contar_ausentismos
	@ope char(36)
	,@aus char(36)
	,@per char(36)
	,@dep char(36) = '*'
	,@top int = 50
as begin 

	set nocount on;

	declare @letra char(1), @fin date;
	select @letra = cat.func_get_letra(@aus)
		 , @fin = convert(date,getdate());

	IF OBJECT_ID('tempdb..#deptos') IS NOT NULL
		DROP TABLE #deptos;
	
	select 
		id_departamento
		,case  @dep 
			when '*' then 1  
			when id_departamento then 1
			else 0 end _incluido
	into #deptos
	from cat.departamento_operator 
	where id_operator = @ope
	
	

	IF OBJECT_ID('tempdb..#contar_ausentismos') IS NOT NULL
		DROP TABLE #contar_ausentismos;

	select 
		id_lista
		,id_periodo
		,id_employee
		,case when right(_c01,1) = @letra and [cat].[func_get_fecha_bycn_byper]('_c01',id_periodo) <= @fin then 1 else 0 end _c01
		,case when right(_c02,1) = @letra and [cat].[func_get_fecha_bycn_byper]('_c02',id_periodo) <= @fin then 1 else 0 end _c02
		,case when right(_c03,1) = @letra and [cat].[func_get_fecha_bycn_byper]('_c03',id_periodo) <= @fin then 1 else 0 end _c03
		,case when right(_c04,1) = @letra and [cat].[func_get_fecha_bycn_byper]('_c04',id_periodo) <= @fin then 1 else 0 end _c04
		,case when right(_c05,1) = @letra and [cat].[func_get_fecha_bycn_byper]('_c05',id_periodo) <= @fin then 1 else 0 end _c05
		,case when right(_c06,1) = @letra and [cat].[func_get_fecha_bycn_byper]('_c06',id_periodo) <= @fin then 1 else 0 end _c06
		,case when right(_c07,1) = @letra and [cat].[func_get_fecha_bycn_byper]('_c07',id_periodo) <= @fin then 1 else 0 end _c07
		,case when right(_c08,1) = @letra and [cat].[func_get_fecha_bycn_byper]('_c08',id_periodo) <= @fin then 1 else 0 end _c08
		,case when right(_c09,1) = @letra and [cat].[func_get_fecha_bycn_byper]('_c09',id_periodo) <= @fin then 1 else 0 end _c09
		,case when right(_c10,1) = @letra and [cat].[func_get_fecha_bycn_byper]('_c10',id_periodo) <= @fin then 1 else 0 end _c10
		,case when right(_c11,1) = @letra and [cat].[func_get_fecha_bycn_byper]('_c11',id_periodo) <= @fin then 1 else 0 end _c11
		,case when right(_c12,1) = @letra and [cat].[func_get_fecha_bycn_byper]('_c12',id_periodo) <= @fin then 1 else 0 end _c12
		,case when right(_c13,1) = @letra and [cat].[func_get_fecha_bycn_byper]('_c13',id_periodo) <= @fin then 1 else 0 end _c13
		,case when right(_c14,1) = @letra and [cat].[func_get_fecha_bycn_byper]('_c14',id_periodo) <= @fin then 1 else 0 end _c14
		,case when right(_c15,1) = @letra and [cat].[func_get_fecha_bycn_byper]('_c15',id_periodo) <= @fin then 1 else 0 end _c15
		,case when right(_c16,1) = @letra and [cat].[func_get_fecha_bycn_byper]('_c16',id_periodo) <= @fin then 1 else 0 end _c16
	into #contar_ausentismos
	from tra.lista l 
	inner join cat.employees e on l.id_employee = e.employee_id
	where id_periodo = @per 
		and e.departamento_id in (select id_departamento from #deptos where _incluido = 1 and id_departamento <> '*')
		and _status = 1

	select top (@top)
		 cat.func_get_employee_alter(sumados.id_employee) Codigo
		,rtrim(e._nombres) [Nombres] 
		,rtrim(e._apellido_paterno) [ApellidoPaterno]
		,rtrim(e._apellido_materno) [ApellidoMaterno]
		,e._clase [Clase]
		,l._locacion_code [Locacion] 
		,d._departamento_code [IDDepartamento]
		,d._departamento_name [Departamento]
		,p._posicion_code [IDPosicion]
		,p._posicion_name [Posicion]
		,cat.func_get_periodo(sumados.id_periodo) [Periodo]
		,cat.func_get_letra(sumados.id_ausentismo) [Letra]
		,sumados.Total
	from (select 
			 id_lista
			 ,id_employee
			 ,id_periodo
			 ,@aus id_ausentismo
			 ,(_c01+_c02+_c03+_c04+_c05+_c06+_c07+_c08+_c09+_c10+_c11+_c12+_c13+_c14+_c15+_c16) Total
			from #contar_ausentismos) sumados
	inner join cat.employees e on sumados.id_employee = e.employee_id
	inner join cat.locacion l on e.locacion_id = l.locacion_id
	inner join cat.departamentos d on e.departamento_id = d.id_departamento 
	inner join cat.posicion p on e.posicion_id = p.posicion_id
	where sumados.total > 0
	order by sumados.total desc;
	
	IF OBJECT_ID('tempdb..#contar_ausentismos') IS NOT NULL
		drop table #contar_ausentismos;
	IF OBJECT_ID('tempdb..#deptos') IS NOT NULL
		drop table #deptos;
end

GO

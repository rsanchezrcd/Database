SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [ifc].[proc_get_diferencias]
	@per int
	,@ano int
	,@locaciones nvarchar(max)
	,@exclude nvarchar(max)
	
as begin

	set nocount on;
	declare @le_per char(36)
	select @le_per = id_periodo from cat.periodos where _per = @per and _year = @ano;
	select * from (
		select  

	
			d.*
			,case when (C01_v + C02_v + C03_v + C04_v + C05_v + C06_v + C07_v + C08_v + C09_v + C10_v + C11_v + C12_v + C13_v + C14_v /*+ C15_v + C16_v*/) > 0 then 1 else 0 end diferente

		from (
			select 
				i.numero
				,l._locacion_code
				,C01	
				,C02	
				,C03	
				,C04	
				,C05	
				,C06	
				,C07	
				,C08	
				,C09	
				,C10	
				,C11	
				,C12	
				,C13	
				,C14	
				--,C15	
				--,C16
				,'-' [-]
				,_C01	
				,_C02	
				,_C03	
				,_C04	
				,_C05	
				,_C06	
				,_C07	
				,_C08	
				,_C09	
				,_C10	
				,_C11	
				,_C12	
				,_C13	
				,_C14	
				--,_C15	
				--,_C16

				----

				,case when replace(C01, 'B', 'F') <> left(replace(replace(_c01, '/', 'F'), 'B', 'F'),1) then 1 else 0 end C01_v
				,case when replace(C02, 'B', 'F') <> left(replace(replace(_c02, '/', 'F'), 'B', 'F'),1) then 1 else 0 end C02_v
				,case when replace(C03, 'B', 'F') <> left(replace(replace(_c03, '/', 'F'), 'B', 'F'),1) then 1 else 0 end C03_v
				,case when replace(C04, 'B', 'F') <> left(replace(replace(_c04, '/', 'F'), 'B', 'F'),1) then 1 else 0 end C04_v
				,case when replace(C05, 'B', 'F') <> left(replace(replace(_c05, '/', 'F'), 'B', 'F'),1) then 1 else 0 end C05_v
				,case when replace(C06, 'B', 'F') <> left(replace(replace(_c06, '/', 'F'), 'B', 'F'),1) then 1 else 0 end C06_v
				,case when replace(C07, 'B', 'F') <> left(replace(replace(_c07, '/', 'F'), 'B', 'F'),1) then 1 else 0 end C07_v
				,case when replace(C08, 'B', 'F') <> left(replace(replace(_c08, '/', 'F'), 'B', 'F'),1) then 1 else 0 end C08_v
				,case when replace(C09, 'B', 'F') <> left(replace(replace(_c09, '/', 'F'), 'B', 'F'),1) then 1 else 0 end C09_v
				,case when replace(C10, 'B', 'F') <> left(replace(replace(_c10, '/', 'F'), 'B', 'F'),1) then 1 else 0 end C10_v
				,case when replace(C11, 'B', 'F') <> left(replace(replace(_c11, '/', 'F'), 'B', 'F'),1) then 1 else 0 end C11_v
				,case when replace(C12, 'B', 'F') <> left(replace(replace(_c12, '/', 'F'), 'B', 'F'),1) then 1 else 0 end C12_v
				,case when replace(C13, 'B', 'F') <> left(replace(replace(_c13, '/', 'F'), 'B', 'F'),1) then 1 else 0 end C13_v
				,case when replace(C14, 'B', 'F') <> left(replace(replace(_c14, '/', 'F'), 'B', 'F'),1) then 1 else 0 end C14_v
				--,case when replace(C15, 'B', 'F') <> left(replace(replace(_c15, '/', 'F'), 'B', 'F'),1) then 1 else 0 end C15_v
				--,case when replace(C16, 'B', 'F') <> left(replace(replace(_c16, '/', 'F'), 'B', 'F'),1) then 1 else 0 end C16_v
				--,0 C13_v
				--,0 C14_v
				--,0 C15_v
				--,0 C16_v

				,d._departamento_name, d._departamento_code

			from va.asistenciasql.dbo.inasist i
			inner join cat.employees e on  i.numero = e._alter_id
			inner join cat.departamentos d on e.departamento_id = d.id_departamento
			inner join cat.locacion l on e.locacion_id = l.locacion_id
			inner join tra.lista tl on e.employee_id = tl.id_employee and id_periodo = @le_per
			where l._locacion_code in (select _part from cat.func_split(@locaciones,','))
			and i.periodo = @per and i.ano = @ano
			and d._departamento_code not in (select _part from cat.func_split(@exclude,','))

		) d) dd
	where dd.diferente = 1 
end

GO

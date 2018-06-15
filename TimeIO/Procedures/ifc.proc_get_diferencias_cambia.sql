SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [ifc].[proc_get_diferencias_cambia]
	@per int
	,@ano int
	,@locaciones nvarchar(max)
	,@exclude nvarchar(max)
	,@cambia bit = 0 
	
as begin

	set nocount on;
	declare @le_per char(36)
	select @le_per = id_periodo from cat.periodos where _per = @per and _year = @ano;
	select * into #asistencia_cambia from (
		select  
			 @per _per
			,@ano _ano	
			,d.*
			,case when (C01_v + C02_v + C03_v + C04_v + C05_v + C06_v + C07_v + C08_v + C09_v + C10_v + C11_v + C12_v + C13_v + C14_v + C15_v  + C16_v) > 0 then 1 else 0 end diferente
		
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
				,C15	
				,C16
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
				,_C15	
				,_C16

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
				,case when replace(C15, 'B', 'F') <> left(replace(replace(_c15, '/', 'F'), 'B', 'F'),1) then 1 else 0 end C15_v
				,case when replace(C16, 'B', 'F') <> left(replace(replace(_c16, '/', 'F'), 'B', 'F'),1) then 1 else 0 end C16_v
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
	where dd.diferente = 1 and numero not in (70577);

	--select * from #asistencia_cambia;

	if @cambia = 1 begin
		--select 1
		update v set 
			 v.C01 = case when left(t._C01,1) = '/' then 'F' else left(t._C01,1) end   
			,v.C02 = case when left(t._C02,1) = '/' then 'F' else left(t._C02,1) end   
			,v.C03 = case when left(t._C03,1) = '/' then 'F' else left(t._C03,1) end   
			,v.C04 = case when left(t._C04,1) = '/' then 'F' else left(t._C04,1) end   
			,v.C05 = case when left(t._C05,1) = '/' then 'F' else left(t._C05,1) end   
			,v.C06 = case when left(t._C06,1) = '/' then 'F' else left(t._C06,1) end   
			,v.C07 = case when left(t._C07,1) = '/' then 'F' else left(t._C07,1) end   
			,v.C08 = case when left(t._C08,1) = '/' then 'F' else left(t._C08,1) end   
			,v.C09 = case when left(t._C09,1) = '/' then 'F' else left(t._C09,1) end   
			,v.C10 = case when left(t._C10,1) = '/' then 'F' else left(t._C10,1) end   
			,v.C11 = case when left(t._C11,1) = '/' then 'F' else left(t._C11,1) end   
			,v.C12 = case when left(t._C12,1) = '/' then 'F' else left(t._C12,1) end   
			,v.C13 = case when left(t._C13,1) = '/' then 'F' else left(t._C13,1) end   
			,v.C14 = case when left(t._C14,1) = '/' then 'F' else left(t._C14,1) end  
			,v.C15 = case when left(t._C15,1) = '/' then 'F' else left(t._C15,1) end  
			,v.C16 = case when left(t._C16,1) = '/' then 'F' else left(t._C16,1) end 
		from VA.AsistenciaSQL.dbo.INASIST v
		inner join #asistencia_cambia t on (v.ano = t._ano and v.periodo = t._per and v.numero = t.numero )
	end else begin
		select t.* 
			
		from VA.AsistenciaSQL.dbo.INASIST v
		inner join #asistencia_cambia t on (v.ano = t._ano and v.periodo = t._per and v.numero = t.numero )
	end;

	drop table #asistencia_cambia;
end
GO

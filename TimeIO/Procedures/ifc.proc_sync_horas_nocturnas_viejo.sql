SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure ifc.proc_sync_horas_nocturnas_viejo (
	@year smallint 
	,@per int 
	,@cambia bit = 0
) as begin
	set nocount on;

	IF OBJECT_ID('tempdb..#horas_nocturnas_cambia', 'U') IS NOT NULL 
		DROP TABLE #horas_nocturnas_cambia; 

	select 
		 p._year ano
		,p._per periodo
		,e._alter_id numero
		,h._horas
		,_c01 ,_c02 ,_c03 ,_c04 ,_c05 ,_c06 ,_c07 ,_c08 ,_c09 ,_c10 ,_c11 ,_c12 ,_c13 ,_c14 ,_c15 ,_c16
	into #horas_nocturnas_cambia
	from tra.horas_nocturnas h
	inner join cat.periodos p on ( h.id_periodo = p.id_periodo)
	inner join cat.employees e on (h.id_employee = e.employee_id)
	where p._year = @year and p._per = @per

	if @cambia = 1 begin

		--insertamos los registros que hacen falta
		insert into VA.AsistenciaSQL.dbo.HORASEXTNOC (ano, periodo, HOTEL,	DIVISION,	DEPTO,	SUBDEPTO,numero ,H01 ,H02 ,H03 ,H04 ,H05 ,H06 ,H07 ,H08 ,H09 ,H10 ,H11 ,H12 ,H13 ,H14 ,H15 ,H16  )
		select 
			t.ano, t.periodo, 1,0,0,0, t.numero,_c01 ,_c02 ,_c03 ,_c04 ,_c05 ,_c06 ,_c07 ,_c08 ,_c09 ,_c10 ,_c11 ,_c12 ,_c13 ,_c14 ,_c15 ,_c16
		from #horas_nocturnas_cambia t 
		left join VA.AsistenciaSQL.dbo.HORASEXTNOC v  on (v.ano = t.ano and v.periodo = t.periodo and v.numero = t.numero)
		where  t.numero is not null and v.numero is null and t._horas > 0;
		
		--actualizamos los registros en db vieja
		update v set
			 v.H01 = t._c01
			,v.H02 = t._c02
			,v.H03 = t._c03
			,v.H04 = t._c04
			,v.H05 = t._c05
			,v.H06 = t._c06
			,v.H07 = t._c07
			,v.H08 = t._c08
			,v.H09 = t._c09
			,v.H10 = t._c10
			,v.H11 = t._c11
			,v.H12 = t._c12
			,v.H13 = t._c13
			,v.H14 = t._c14
			--,v.H15 = t._c15
			--,v.H16 = t._c16
		from VA.AsistenciaSQL.dbo.HORASEXTNOC v 
		inner join  #horas_nocturnas_cambia t  on (v.ano = t.ano and v.periodo = t.periodo and v.numero = t.numero)
		

	end else begin
		select 
			*
		from #horas_nocturnas_cambia t 
		left join VA.AsistenciaSQL.dbo.HORASEXTNOC v  on (v.ano = t.ano and v.periodo = t.periodo and v.numero = t.numero)
		where  t.numero is not null and v.numero is null and t._horas > 0
	end;
	

	DROP TABLE #horas_nocturnas_cambia; 
end;
GO

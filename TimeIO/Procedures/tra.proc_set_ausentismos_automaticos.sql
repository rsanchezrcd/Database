SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure tra.proc_set_ausentismos_automaticos
	
as begin
	set nocount on;

	declare @per char(36)
	exec cat.proc_get_periodo_actual @per OUTPUT
	
	
	select 
		newid() id
		,a.id_locacion
		,a.id_ausentismo
		,a._clase
		,a._week_day
		,f.fecha_int
		,f.id_periodo
		,f._cN
		,0 _sync
	into #auto_existentes
	from adm.fechas f
	inner join cat.ausentismo_automatico a on f._day_week = a._week_day
	where id_periodo = @per and fecha_int < convert(int,convert(nvarchar(8), getdate(), 112))
		and a.active = 1
	order by fecha_nat asc;

	
	declare @id char(36), @loc char(36), @aus char(36), @cla nvarchar(6), @fecha int , @cn char(3)
	
	while (exists(select top 1 id from #auto_existentes where _sync  = 0)) begin
		select top 1 
			@id = id 
			,@loc = id_locacion
			,@aus = id_ausentismo
			,@cla = _clase
			,@fecha = fecha_int
			,@cn = _cN
		from #auto_existentes where _sync  = 0;
		------------------------------------------

		select 
			  newid() id_emp
			, employee_id 
			, 0 _sync 
		into #empleados 
		from tra.lista l with (nolock)
		inner join cat.employees e with (nolock) on (l.id_employee = e.employee_id)
		where l.id_periodo = @per and e._clase = @cla and e.locacion_id = @loc
		and cat.func_get_val_lista_bycn_byper_byemp(@cn, @per, l.id_employee) = 'F';

		declare @id_emp char(36), @emp char(36), @letra char(1) ,@color nvarchar(64),@result bit ,@msg nvarchar(max), @cau char(36), @_cn char(4)
		while(exists (select top 1 id_emp from #empleados where _sync = 0)) begin
			select top 1
				@id_emp = id_emp  
				,@emp = employee_id
				,@letra = cat.func_get_letra(@aus)
			from #empleados where _sync = 0;
			

			if (not exists(select id_ausentismo 
							from tra.ausentismos
							where active = 1 and id_periodo = @per
								and convert(int,convert(nvarchar(8),_ausentismo_date,112)) = @fecha
								and employee_id = @emp 
								and cat.func_get_letra(id_ausentismo) = 'F' )) begin
				set @_cn = '_'+@cn
				select top 1 @cau = id_causa from cat.causa where activo = 1 and _auto = 1 and id_ausentismo = @aus;
				exec tra.proc_set_ausentismo  @per, @emp, @_cn, @letra, 'AUTOMATIC-O000000000-000000000-00000', @cau, null, null, @color OUTPUT, @result OUTPUT, @msg OUTPUT
			end;
			update #empleados set
				_sync = 1
			where id_emp = @id_emp;
		end;
		drop table #empleados
		------------------------------------------
		update #auto_existentes set
			_sync = 1
		where id = @id;
	end;
	--select * from #auto_existentes
	


	drop table #auto_existentes;

end;

GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create  proc tra.proc_festivos_automaticos
	@per char(36) = null 
as begin
	set nocount on;
	declare @hoy date, @ini date, @aus char(36)

	if (@per is null) begin
		exec cat.proc_get_periodo_actual @per OUTPUT
	end
	--select @per per
	select 
		 @hoy = convert(date,getdate())
		,@ini = convert(date,ini_date)
		,@aus =cat.func_get_id_ausentismo('D')
	from cat.periodos 
	where id_periodo = @per and active = 1;

	declare @fes date, @loc char(36),@cn char(3)


	select id_locacion, _festivo_date, 0 _sync
	into #festivos
	from cat.festivo 
	where _festivo_date between @ini and @hoy and isnull(_calificado,0) = 0

	while(exists(select top 1 
					_sync 
				from #festivos where _sync = 0)) begin 
		----------------------------------------------------------------------------
		select top 1 
			@fes = _festivo_date, @loc = id_locacion  
		from #festivos where _sync = 0;
		select @cn = _cn from adm.fechas where fecha_nat = @fes
		
		--select @cn cn , @loc loc 
		select 
			  newid() id_emp
			, employee_id 
			, @fes _festivo_date
			, @per id_periodo
			, 0 _sync 
		into #empleados 
		from tra.lista l with (nolock)
		inner join cat.employees e with (nolock) on (l.id_employee = e.employee_id)
		where l.id_periodo = @per and e.locacion_id = @loc
		and cat.func_get_val_lista_bycn_byper_byemp(@cn, @per, l.id_employee) = 'F';

		insert into #empleados 
		select 
			  newid() id_emp
			, employee_id 
			, @fes _festivo_date
			, @per id_periodo
			, 0 _sync  
		from tra.lista l with (nolock)
		inner join cat.employees e with (nolock) on (l.id_employee = e.employee_id)
		where l.id_periodo = @per and e.locacion_id = @loc
		and cat.func_get_val_lista_bycn_byper_byemp(@cn, @per, l.id_employee) = 'D'

		update x
			set x._sync = 1
		from #empleados x
		where x.employee_id in (select employee_id 
								from tra.ausentismos
								where id_ausentismo = cat.func_get_id_ausentismo('D')
								and employee_id = x.employee_id
								and id_periodo = x.id_periodo
								and _ausentismo_date = x._festivo_date
								and active = 1)
		
		declare @id_emp char(36), @emp char(36), @letra char(1) ,@color nvarchar(64),@result bit ,@msg nvarchar(max), @cau char(36), @_cn char(4)
		while (exists(select top 1 id_emp from #empleados where _sync = 0)) begin
			select top 1
				@id_emp = id_emp  
				,@emp = employee_id
				,@letra = 'D'
			from #empleados where _sync = 0;

			set @_cn = '_'+@cn
			select top 1 @cau = id_causa from cat.causa where activo = 1 and _auto = 1 and id_ausentismo = @aus;
			exec tra.proc_set_ausentismo  @per, @emp, @_cn, @letra, 'AUTOMATIC-O000000000-000000000-00000', @cau, null, null, @color OUTPUT, @result OUTPUT, @msg OUTPUT
			
			update #empleados set
				_sync = 1
			where id_emp = @id_emp;
		end;

		drop table #empleados

		update #festivos set _sync = 1 
		where id_locacion = @loc and _festivo_date =  @fes and _sync = 0
		----------------------------------------------------------------------------
	end

	drop table #festivos
end

GO

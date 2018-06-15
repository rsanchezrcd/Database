SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [adm].[proc_create_lista_rows]
	 @per char(36)
	,@ope char(36)
as begin
	begin try
		set nocount on;
		set transaction isolation level read committed
		begin transaction
			-- elimino datos previos del periodo 
			-- delete from tra.lista where id_periodo = @per;
			print 'Registros Eliminados..'
			-- inserto datos del periodo
			insert into tra.lista (id_employee, id_periodo, insert_operator_id) 
			select
				  e.employee_id
				, @per
				, @ope 
			from cat.employees e
			left join tra.lista l on e.employee_id = l.id_employee 
									and l.id_periodo = @per
			where e.employee_id is not null and e._status = 1 and l.id_employee is null
			order by e._alter_id;
			print 'Registros insertados...'
			-- descansos automaticos por colaborador
			
			declare @queries table (_query nvarchar(max), _exec bit);
			declare @query nvarchar(max);
			--select _cN from adm.fechas where id_periodo = @per and _day_week = 1;
			insert into @queries (_query, _exec)
			select 
				--e.employee_id,-- _cN 
				'update tra.lista set _' + _cN + ' = ''D'' 
				where _' + _cN + ' = ''F'' and  id_periodo = ''' + @per + ''' and id_employee = ''' + e.employee_id +''''
				 [_query]
				 ,0 [_exec]
			from cat.employees e 
			inner join adm.fechas f 
				on f.id_periodo = @per and f._day_week = 1 and e._d = 1
			union all
			select 
				--e.employee_id,-- _cN 
				'update tra.lista set _' + _cN + ' = ''D'' 
				where _' + _cN + ' = ''F'' and  id_periodo = ''' + @per + ''' and id_employee = ''' + e.employee_id +''''
				 [_query]
				 ,0 [_exec]
			from cat.employees e 
			inner join adm.fechas f 
				on f.id_periodo = @per and f._day_week = 2 and e._l = 1
			union all
			select 
				--e.employee_id,-- _cN 
				'update tra.lista set _' + _cN + ' = ''D'' 
				where _' + _cN + ' = ''F'' and  id_periodo = ''' + @per + ''' and id_employee = ''' + e.employee_id +''''
				 [_query]
				 ,0 [_exec]
			from cat.employees e 
			inner join adm.fechas f 
				on f.id_periodo = @per and f._day_week = 3 and e._m = 1
			union all
			select 
				--e.employee_id,-- _cN 
				'update tra.lista set _' + _cN + ' = ''D'' 
				where _' + _cN + ' = ''F'' and  id_periodo = ''' + @per + ''' and id_employee = ''' + e.employee_id +''''
				 [_query]
				 ,0 [_exec]
			from cat.employees e 
			inner join adm.fechas f 
				on f.id_periodo = @per and f._day_week = 4 and e._x = 1
			union all
			select 
				--e.employee_id,-- _cN 
				'update tra.lista set _' + _cN + ' = ''D'' 
				where _' + _cN + ' = ''F'' and  id_periodo = ''' + @per + ''' and id_employee = ''' + e.employee_id +''''
				 [_query]
				 ,0 [_exec]
			from cat.employees e 
			inner join adm.fechas f 
				on f.id_periodo = @per and f._day_week = 5 and e._j = 1
			union all
			select 
				--e.employee_id,-- _cN 
				'update tra.lista set _' + _cN + ' = ''D'' 
				where _' + _cN + ' = ''F'' and id_periodo = ''' + @per + ''' and id_employee = ''' + e.employee_id +''''
				 [_query]
				 ,0 [_exec]
			from cat.employees e 
			inner join adm.fechas f 
				on f.id_periodo = @per and f._day_week = 6 and e._v = 1
			union all
			select 
				--e.employee_id,-- _cN 
				'update tra.lista set _' + _cN + ' = ''D'' 
				where _' + _cN + ' = ''F'' and  id_periodo = ''' + @per + ''' and id_employee = ''' + e.employee_id +''''
				 [_query]
				 ,0 [_exec]
			from cat.employees e 
			inner join adm.fechas f 
				on f.id_periodo = @per and f._day_week = 7 and e._s = 1

			while (exists (select top 1 _query from @queries where _exec = 0 order by _query asc )) begin
				select top 1 @query = _query from @queries where _exec = 0 order by _query asc
				exec (@query);
				update @queries set _exec = 1
				where _query = @query;
			end
			print 'Descansos actualizados...'
		commit transaction
	end try
	
	begin catch
		declare @number int = ERROR_NUMBER()
				,@severity int = ERROR_SEVERITY()
				,@state int = ERROR_STATE()
				,@procedure nvarchar(128) = ERROR_PROCEDURE()
				,@line int= ERROR_LINE()
				,@message nvarchar(4000) = ERROR_MESSAGE();
		exec log.proc_add_error_log
				@ope = @ope
				,@error_number = @number
				,@error_severity = @severity
				,@error_state = @state
				,@error_procedure = @procedure
				,@error_line = @line
				,@error_message = @message;	
		print 'Error: ' + error_message();
		print 'Line: ' + rtrim(error_line());	
		rollback transaction
	end catch
	
end
GO

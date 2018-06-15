SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


CREATE procedure [ifc].[proc_sync_bajas_ingresos]
	@verbose bit = 0
	,@exclude nvarchar(max) = null
as begin
	SET NOCOUNT ON;
	SET DATEFIRST 1;

	--print @verbose
	------------------------------------------------------------
	-- Variables de Uso
	------------------------------------------------------------
	declare  @fec_ini_per datetime
			,@fec_fin_per datetime
			,@per char(36)
			,@emp char(36)
			,@ope char(36) 
			,@aus char(36)
			,@ins int
			,@upd int
			,@del int

	------------------------------------------------------------
	-- Tabla variable de Bajas
	------------------------------------------------------------
	declare @bajas table( employee_id char(36)
						, _dias tinyint
						, _ini datetime
						, _fin datetime 
						, _sync bit );
	------------------------------------------------------------
	-- Tabla variable de Ausentismos
	------------------------------------------------------------
	declare @ausentismos table( insert_operator_id char(36)
								, id_ausentismo char(36)
								, _ausentismo_date datetime
								, _alter_id int
								, employee_id char(36)
								, _cN nvarchar(3)
								, id_periodo char(36)
								, _sync bit
								--, _query nvarchar(max)
							);							
	------------------------------------------------------------
	-- Poblamos Variables 
	------------------------------------------------------------
	exec cat.proc_get_fecha_ini_periodo_actual @fec_ini_per OUT;
	exec cat.proc_get_fecha_fin_periodo_actual @fec_fin_per OUT;


	if (convert(nvarchar(8),getdate(), 112) >= convert(nvarchar(8),dateadd(day,1,@fec_fin_per), 112)) begin
		return;
	end

	select	 @per = cat.func_get_id_periodo(@fec_ini_per)
			,@aus = cat.func_get_id_ausentismo('B')
			,@ope = 'INTERFACE-BAJAS00000-000000000-00000';

	------------------------------------------------------------
	-- Insertamos en tra.lista los nuevos ingresos
	-- despues de poblar la tabla variable bajas
	------------------------------------------------------------
	insert into tra.lista (id_employee, id_periodo, insert_operator_id) 
	select 
		e.employee_id
		,@per
		,@ope
	from cat.employees e with (nolock)
	left join tra.lista l  with (nolock) on  l.id_employee = e.employee_id	and	l.id_periodo = @per 
	where
			l.id_lista is null 
		and e._status = 1
		and e._hire_date >= @fec_ini_per
		and e._alter_id not in (select _part from cat.func_split(@exclude, ','));
	if @verbose = 1 set @ins = @@ROWCOUNT
	if @verbose = 1 print 'Insertados tra.lista: ' + rtrim(@ins)

	------------------------------------------------------------
	-- Insertamos en tra.lista coloboradores faltantes
	-- ingresos de periodos pasados
	------------------------------------------------------------	
	insert into tra.lista (id_employee, id_periodo, insert_operator_id) 
	select 
		e.employee_id
		--,cat.func_get_employee_alter(e.employee_id)
		,@per
		,@ope
	from cat.employees e with (nolock)
	left join tra.lista l  with (nolock) on  l.id_employee = e.employee_id	
											and	l.id_periodo = @per
	where
			l.id_lista is null 
		and e._status = 1
		and e._hire_date <= @fec_ini_per
		and e._alter_id not in (select _part from cat.func_split(@exclude, ','));;

	------------------------------------------------------------
	-- Poblamos tabla @bajas
	------------------------------------------------------------
	insert into @bajas
	select
		 e.employee_id
		,(datediff(day, e._fecha_baja, @fec_fin_per)+1)_dias 
		,e._fecha_baja _ini
		,@fec_fin_per _fin
		,0 _sync 
	from cat.employees e with (nolock)
	inner join tra.lista l with (nolock) on l.id_employee = e.employee_id
	where 
			l.id_periodo = @per
		and e._fecha_baja is not null 
		and e._status = 0
		and e._fecha_baja >= @fec_ini_per
		and (datediff(day, e._fecha_baja, @fec_fin_per)+1) > 0
		and e._alter_id not in (select _part from cat.func_split(@exclude, ','))
	
	union all
	------------------------------------------------------------
	-- Agregamos Ingresos 
	------------------------------------------------------------
	select 
		e.employee_id
		,case when @fec_ini_per = _hire_date then 0 else (datediff(day, @fec_ini_per, _hire_date)) end _dias 
		,case when @fec_ini_per = _hire_date then null else @fec_ini_per end _ini
		,case when @fec_ini_per = _hire_date then null else _hire_date-1 end _fin
		,0 _sync
		--,_hire_date
		--,e.* 
	from cat.employees e with (nolock)	
	where			
			e._status = 1
		and e._hire_date >= @fec_ini_per
		and e._alter_id not in (select _part from cat.func_split(@exclude, ','));

	------------------------------------------------------------
	-- Comprobamos existan registros en tabla @bajas 
	------------------------------------------------------------
	if (exists (select top 1 employee_id 
					from @bajas 
					where	_sync = 0
						and _ini is not null 
						and _fin is not null)) begin
		------------------------------------------------------------
		-- Variables de uso 
		------------------------------------------------------------
		declare	 @cn nvarchar(3)
				,@c int, @d int
				,@ini datetime, @fin datetime
				,@actual datetime
				
				
	
		------------------------------------------------------------
		-- Recorremos bajas y poblamos tabla @ausentismos 
		------------------------------------------------------------
		while (exists (select top 1 employee_id 
						from @bajas 
						where	_sync = 0
							and _ini is not null 
							and _fin is not null)) begin
			select top 1 
				@emp = employee_id 
				,@ini = convert(varchar(8),_ini,112)
				,@fin = convert(varchar(8),_fin,112)
			from @bajas 
			where	_sync = 0
				and _ini is not null 
				and _fin is not null;
			
			set @actual = @ini;
			while (@actual <=  @fin) begin

				insert into @ausentismos
				select 
					@ope -- ID Generico 
					,@aus
					,@actual
					,cat.func_get_employee_alter(@emp)
					,@emp
					,cat.func_get_cn(@actual)
					,@per
					,0;
				
					
				--				
				set @actual = dateadd(day,1, @actual);
			end;

			update @bajas
				set _sync = 1
			where employee_id = @emp 
		end

		-------------------------------------------------------
		-- Insertamos en stage los registros a eliminar de tra.lista 
		-------------------------------------------------------	
		insert into stg.ausentismos_eliminados ([id_tra_ausentismo],insert_operator_id, id_ausentismo, _ausentismo_date, employee_id, _cN, id_periodo ,_sync)
		select 
			a.id_tra_ausentismo
			,a.insert_operator_id
			,a.id_ausentismo
			,a._ausentismo_date
			,a.employee_id
			,a._cN
			,a.id_periodo
			,0 [_sync]
			
		from tra.ausentismos a with(nolock) 
		left join @ausentismos b  on (	a.employee_id = b.employee_id 
									and a.id_ausentismo = b.id_ausentismo
									and a._ausentismo_date = b._ausentismo_date)
		where   b._ausentismo_date IS NULL
			and isnull(a._deleted,0) = 0
			and a._ausentismo_date >= @fec_ini_per
			and a.insert_operator_id = @ope
			and (a.id_ausentismo = @aus)
			--and b._cN is not null;
		if @verbose = 1 set @del = @@ROWCOUNT
		if @verbose = 1 print 'Eliminados: ' + rtrim(@del);

		-------------------------------------------------------
		-- Insertamos en tra.ausentismos registros que faltan
		-------------------------------------------------------
		insert into tra.ausentismos (insert_operator_id, id_ausentismo, _ausentismo_date, employee_id, _cN, id_periodo ,_sync)
		select 
			a.insert_operator_id
			,a.id_ausentismo
			,a._ausentismo_date
			,a.employee_id
			,a._cN
			,a.id_periodo
			,a._sync			
		from @ausentismos a 
		left join tra.ausentismos b with(nolock) on (a.employee_id = b.employee_id 
													and a.id_ausentismo = b.id_ausentismo
													and a._ausentismo_date = b._ausentismo_date)
		where b.id_tra_ausentismo is null
			and a._ausentismo_date >= @fec_ini_per
			and a._cN is not null;
		------------------------------------------------------------
		if @verbose = 1 set @ins = @@ROWCOUNT
		if @verbose = 1 print 'Insertados: ' + rtrim(@ins);
		------------------------------------------------------------
		-- Actualizamos _deleted en tra.ausentismos en base a lo 
		-- insertado en stage
		------------------------------------------------------------
		update tra.ausentismos
			set _deleted = 1
		where id_tra_ausentismo in(
			select id_tra_ausentismo 
			from stg.ausentismos_eliminados		
			where _sync = 0 and _ausentismo_date >= @fec_ini_per and id_ausentismo = @aus
		);

		------------------------------------------------------------
		-- Sync con Tra.lista -- inserts 
		------------------------------------------------------------
		declare @q nvarchar(max)
				,@id int
		------------------------------------------------------------	
		while exists(
			select top 1 id_tra_ausentismo 
			from tra.ausentismos a with(nolock)
			inner join tra.lista l with(nolock) on a.id_periodo = l.id_periodo and a.employee_id = l.id_employee
			where 
					a.insert_operator_id = @ope
				and (a.id_ausentismo = @aus)
				and a._sync = 0
				and a._ausentismo_date >= @fec_ini_per) begin

			begin try
				set transaction isolation level read committed
				begin transaction

					select top 1 @id= a.id_tra_ausentismo 
						, @q = 'update tra.lista 
									set _'+ a._cN +' = (case	when _'+ a._cN +' is null then  '''+rtrim(cat.func_get_letra(a.id_ausentismo))+'''
																				when LEN(rtrim(_'+ a._cN +')) > 1 then convert(nvarchar(3),'''+rtrim(cat.func_get_letra(a.id_ausentismo))+'''+RIGHT(rtrim(_'+ a._cN +'),1))														
																				else '''+rtrim(cat.func_get_letra(a.id_ausentismo))+''' end)
								where id_employee = '''+a.employee_id+''' and id_periodo = '''+a.id_periodo+''''
			
					from tra.ausentismos a with(nolock)
					inner join tra.lista l with(nolock) on a.id_periodo = l.id_periodo and a.employee_id = l.id_employee
					where 
							a.insert_operator_id =@ope
						and (a.id_ausentismo = @aus)
						and a._sync = 0
						and a._ausentismo_date >= @fec_ini_per		
					------------------------------------------------------------
					exec( @q) -- Ejecutamos query dinamico
					------------------------------------------------------------
					-- Actualizamos _sync de tra.ausentismos
					------------------------------------------------------------
					update tra.ausentismos
						set _sync = 1
					where id_tra_ausentismo = @id;
					if @verbose = 1 set @ins = @ins + @@ROWCOUNT;
				commit transaction
			end try
			begin catch
				print error_message();
				rollback transaction
			end catch
		end;	
		if @verbose = 1 print 'Insertados sync: ' + rtrim(@ins);	
		-------------------------------------------------------
		-- Sync con tra.lista -- deletes ----------------------
		-------------------------------------------------------
		while exists(
			select top 1 id_tra_ausentismo 
			from stg.ausentismos_eliminados a with(nolock)
			inner join tra.lista l with(nolock) on a.id_periodo = l.id_periodo and a.employee_id = l.id_employee
			where 
					a.insert_operator_id =@ope
				and (a.id_ausentismo = @aus)
				and a._sync = 0
				and a._ausentismo_date >= @fec_ini_per) begin
			
			begin try
				set transaction isolation level read committed
				begin transaction
				
					select top 1 @id= a.id_tra_ausentismo 
						, @q = 'update tra.lista 
									set _'+ a._cN +' = (case isnull(_'+ a._cN +',''nul'') 
															when '''+rtrim(cat.func_get_letra(a.id_ausentismo))+''' then ''F''																									
															when '''+rtrim(cat.func_get_letra(a.id_ausentismo))+'/'' then ''/''	
															when '''+rtrim(cat.func_get_letra(a.id_ausentismo))+'.'' then ''.''											
															when ''nul'' then null
															else _'+ a._cN +' end)
								where id_employee = '''+a.employee_id+''' and id_periodo = '''+a.id_periodo+''''	
			
					from stg.ausentismos_eliminados a with(nolock)
					inner join tra.lista l with(nolock) on a.id_periodo = l.id_periodo and a.employee_id = l.id_employee
					where 
							a.insert_operator_id =@ope
						and (a.id_ausentismo = @aus)
						and a._sync = 0
						and a._ausentismo_date >= @fec_ini_per		
					------------------------------------------------------------
					exec(@q) -- Ejecutamos query dinamico
					------------------------------------------------------------
					-- Actualizamos stage.ausentismos
					------------------------------------------------------------
					update stg.ausentismos_eliminados
						set _sync = 1
					where id_tra_ausentismo = @id;

					delete from tra.ausentismos where _sync = 1 and _deleted = 1 and id_tra_ausentismo = @id;
					delete from stg.ausentismos_eliminados where _sync = 1 and id_tra_ausentismo = @id;

					if @verbose = 1 set @del = @del + @@ROWCOUNT;
				commit transaction
			end try
			begin catch
				print error_message();
				rollback transaction
			end catch
		end;	
		if @verbose = 1 print 'Eliminados sync: ' + rtrim(@del); 
	end; --endif exist @bajas
end;
GO

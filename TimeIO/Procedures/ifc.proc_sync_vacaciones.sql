SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [ifc].[proc_sync_vacaciones]
	@verbose bit = 0
as begin
	SET NOCOUNT ON;
	SET DATEFIRST 1; 
	------------------------------------------------------------
	-- Variables Estadisticas
	------------------------------------------------------------
	declare @exec_fin datetime, @exec_ini datetime = getdate()	
	------------------------------------------------------------
	-- Variables de uso
	------------------------------------------------------------
	declare @fec_ini_per datetime
	declare @vacaciones table(_id_tmp char(36)
							, _dias int
							, _alter_id int
							, _inicio datetime
							, _fin datetime
							, _descansos0 int
							, _descansos1 int
							, _sync bit default 0);
	------------------------------------------------------------
	-- Obtengo la fecha de inicio del periodo actual
	------------------------------------------------------------
	exec [cat].[proc_get_fecha_ini_periodo_actual] @fec_ini_per OUTPUT
	if @verbose = 1 print 'Fecha inicio PER: ' + convert(nvarchar(8),@fec_ini_per,112)
	------------------------------------------------------------
	-- Inserto en tabla variable los datos extraidos de PS
	------------------------------------------------------------
	insert into @vacaciones
	select --top 1
		newid()
		,(datediff(day, BGN_DT, END_DT)+1) [_dias]
		,convert(int,EMPLID) [_alter_id]
		,BGN_DT [_inicio]
		,END_DT [_fin]
		--,PH_FECDD1
		,case PH_FECDD1 
			when '1753-01-01 00:00:00.000' then null
			else datepart(WEEKDAY,PH_FECDD1) end [_descansos0]
		,case PH_FECDD2 
			when '1753-01-01 00:00:00.000' then null
			else datepart(WEEKDAY,PH_FECDD2) end [_descansos1]
		,0 
	from PS.HRSYS.adm.PS_PH_VACCTRLASIVW with(nolock)
	where APPROVAL_FLAG ='S' and BGN_DT >= @fec_ini_per 

	union all

	select --top 1
		newid()
		,(datediff(day, @fec_ini_per, END_DT)+1) [_dias]
		,convert(int,EMPLID) [_alter_id]
		,@fec_ini_per [_inicio]
		,END_DT [_fin]
		--,PH_FECDD1
		,case PH_FECDD1 
			when '1753-01-01 00:00:00.000' then null
			else datepart(WEEKDAY,PH_FECDD1) end [_descansos0]
		,case PH_FECDD2 
			when '1753-01-01 00:00:00.000' then null
			else datepart(WEEKDAY,PH_FECDD2) end [_descansos1]
		,0
	from PS.HRSYS.adm.PS_PH_VACCTRLASIVW with(nolock)
	where APPROVAL_FLAG ='S' and BGN_DT < @fec_ini_per and END_DT >= @fec_ini_per;

	------------------------------------------------------------
	-- Validamos si hay registros de vacaciones
	------------------------------------------------------------
	if (exists ( select top 1 _id_tmp from @vacaciones)) begin		
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
								, _sync bit);
		------------------------------------------------------------
		-- Variables de uso 
		------------------------------------------------------------
		declare @vac char(36), @des char(36)
				,@emp char(36), @alt int
				,@cn nvarchar(3)
				,@c int, @d int, @dday0 int,  @dday1 int
				,@ini datetime
				,@actual char(36)
		------------------------------------------------------------
		-- Declaramos contadores
		------------------------------------------------------------
		declare  @eliminados int, @insertados int;
		------------------------------------------------------------
		-- Asignamos los ids a vacaciones y descansos
		------------------------------------------------------------
		select @vac = cat.func_get_id_ausentismo('V')
			 , @des = cat.func_get_id_ausentismo('D')
		------------------------------------------------------------
		-- Recorremos tabla vacaciones
		------------------------------------------------------------
		while exists (select top 1 _id_tmp from @vacaciones where _sync = 0) begin				
			------------------------------------------------------------
			-- Llenamos variables de uso
			------------------------------------------------------------
			select 
				top 1 
				@actual = v._id_tmp 
				,@alt = v._alter_id
				,@emp = cat.func_get_id_employee(v._alter_id)			
				,@d = v._dias
				,@c = 0
				,@ini = v._inicio
				,@dday0 = v._descansos0
				,@dday1 = v._descansos1
			from @vacaciones v		
			where v._sync = 0;

			if @emp is not null begin -- Validamos que el empleado exista
				while (@d > 0) begin -- Recorremos los dias			
					------------------------------------------------------------
					-- Insertamos registro por día en tabla variable ausentismos
					------------------------------------------------------------
					insert into @ausentismos
					select 
						'INTERFACE-VACACIONES-000000000-00000' -- ID Generico 
						,case when datepart(weekday,dateadd(day, @c, @ini)) = @dday0 or datepart(weekday,dateadd(day, @c, @ini)) = @dday1 then @des 
							  when cat.func_get_isfestivo_by_date_by_emp(dateadd(day, @c, @ini), @emp) = 1 then @des else @vac end
						,dateadd(day, @c, @ini)
						,@alt
						,@emp
						,cat.func_get_cn(dateadd(day, @c, @ini))
						,cat.func_get_id_periodo(dateadd(day, @c, @ini))
						,0;
					--
					set @d = @d - 1;
					set @c = @c + 1;
				end;
			end;
			------------------------------------------------------------
			-- Actualizams _sync en tabla variable @vacaciones
			------------------------------------------------------------
			update @vacaciones
				set _sync = 1
			where _id_tmp = @actual;
		end;	
		
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
			and a.insert_operator_id = 'INTERFACE-VACACIONES-000000000-00000' 
			and (a.id_ausentismo = @vac or a.id_ausentismo = @des)
			--and b._cN is not null;

	
		if @verbose = 1 set @eliminados = @@ROWCOUNT
		if @verbose = 1 print 'Eliminados: ' + rtrim(@eliminados);
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
		if @verbose = 1 set @insertados = @@ROWCOUNT
		if @verbose = 1 print 'Insertados: ' + rtrim(@insertados);
		------------------------------------------------------------
		-- Actualizamos _deleted en tra.ausentismos en base a lo 
		-- insertado en stage
		------------------------------------------------------------
		update tra.ausentismos
			set _deleted = 1
		where id_tra_ausentismo in(
			select id_tra_ausentismo 
			from stg.ausentismos_eliminados		
			where _sync = 0 and _ausentismo_date >= @fec_ini_per
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
					a.insert_operator_id ='INTERFACE-VACACIONES-000000000-00000' 
				and (a.id_ausentismo = @vac or a.id_ausentismo = @des)
				and a._sync = 0
				and a._ausentismo_date >= @fec_ini_per) begin
			begin try
				set transaction isolation level read committed
				begin transaction tran_vacaciones
					select top 1 @id= a.id_tra_ausentismo 
						, @q = 'update tra.lista 
									set _'+ a._cN +' = (case isnull(_'+a._cN+',''nul'') when ''.'' then convert(nvarchar(3),'''+rtrim(cat.func_get_letra(a.id_ausentismo))+'.'')
																		  when ''/'' then convert(nvarchar(3),'''+rtrim(cat.func_get_letra(a.id_ausentismo))+'/'')
																		  when ''V/'' then convert(nvarchar(3),'''+rtrim(cat.func_get_letra(a.id_ausentismo))+'/'')
																		  when ''D/'' then convert(nvarchar(3),'''+rtrim(cat.func_get_letra(a.id_ausentismo))+'/'')
																		  when ''D.'' then convert(nvarchar(3),'''+rtrim(cat.func_get_letra(a.id_ausentismo))+'.'')
																		  when ''V.'' then convert(nvarchar(3),'''+rtrim(cat.func_get_letra(a.id_ausentismo))+'.'')
																		  when ''V'' then convert(nvarchar(3),'''+rtrim(cat.func_get_letra(a.id_ausentismo))+''')
																		  when ''D'' then convert(nvarchar(3),'''+rtrim(cat.func_get_letra(a.id_ausentismo))+''')
																		  when ''nul'' then convert(nvarchar(3),'''+rtrim(cat.func_get_letra(a.id_ausentismo))+''')
																		  else convert(nvarchar(3),'''+rtrim(cat.func_get_letra(a.id_ausentismo))+''') end)
								where id_employee = '''+a.employee_id+''' and id_periodo = '''+a.id_periodo+''''	
					
					from tra.ausentismos a with(nolock)
					inner join tra.lista l with(nolock) on a.id_periodo = l.id_periodo and a.employee_id = l.id_employee
					where 
							a.insert_operator_id ='INTERFACE-VACACIONES-000000000-00000' 
						and (a.id_ausentismo = @vac or a.id_ausentismo = @des)
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

					

					if @verbose = 1 set @insertados = @insertados + @@ROWCOUNT;
				commit transaction tran_vacaciones
			end try
			begin catch
				print ERROR_MESSAGE()
				rollback transaction tran_vacaciones
			end catch
			
			
		end;	
		if @verbose = 1 print 'Insertados sync: ' + rtrim(@insertados);

		-------------------------------------------------------
		-- Sync con tra.lista -- deletes ----------------------
		-------------------------------------------------------
		while exists(
			select top 1 id_tra_ausentismo 
			from stg.ausentismos_eliminados a with(nolock)
			inner join tra.lista l with(nolock) on a.id_periodo = l.id_periodo and a.employee_id = l.id_employee
			where 
					a.insert_operator_id ='INTERFACE-VACACIONES-000000000-00000' 
				and (a.id_ausentismo = cat.func_get_id_ausentismo('V') or a.id_ausentismo = cat.func_get_id_ausentismo('D'))
				and a._sync = 0
				and a._ausentismo_date >= @fec_ini_per) begin

			begin try
				set transaction isolation level read committed
				begin transaction tran_delete_vacaciones

					select top 1 @id= a.id_tra_ausentismo 
						, @q = 'update tra.lista 
									set _'+ a._cN +' = (case isnull(_'+ a._cN +',''nul'') 
															when ''V'' then ''F''
															when ''D'' then ''F''												
															when ''V/'' then ''/''
															when ''D/'' then ''/''
															when ''D.'' then ''.''
															when ''V.'' then ''.''											
															when ''nul'' then null
															else _'+ a._cN +' end)
								where id_employee = '''+a.employee_id+''' and id_periodo = '''+a.id_periodo+''''	
					
					from stg.ausentismos_eliminados a with(nolock)
					inner join tra.lista l with(nolock) on a.id_periodo = l.id_periodo and a.employee_id = l.id_employee
					where 
							a.insert_operator_id ='INTERFACE-VACACIONES-000000000-00000' 
						and (a.id_ausentismo = @vac or a.id_ausentismo = @des)
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

					if @verbose = 1 set @eliminados = @eliminados + @@ROWCOUNT;
				commit transaction tran_delete_vacaciones
			end try
			begin catch
				print ERROR_MESSAGE()
				rollback transaction tran_delete_vacaciones
			end catch
		end;	
		if @verbose = 1 print 'Eliminados sync: ' + rtrim(@eliminados); 
	end --/*endif exists @vacaciones*/

end;
GO

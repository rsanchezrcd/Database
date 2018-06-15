SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [ifc].[proc_sync_incapacidades]
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
	declare @incapacidades table(_id_tmp char(36)
							, _dias int
							, _alter_id int
							, _inicio datetime
							, _fin datetime							
							, _sync bit default 0
							, _folio nvarchar(10)
							, _ps_type char(1));
	------------------------------------------------------------
	-- Obtengo la fecha de inicio del periodo actual
	------------------------------------------------------------
	exec [cat].[proc_get_fecha_ini_periodo_actual] @fec_ini_per OUTPUT
	if @verbose = 1 print 'Fecha inicio PER: ' + convert(nvarchar(8),@fec_ini_per,112)
	------------------------------------------------------------
	-- Inserto en tabla variable los datos extraidos de PS
	------------------------------------------------------------
	insert into @incapacidades
	select 
		newid() [_id_tmp]
		,(datediff(day, BEGIN_DT, RETURN_DT)+1) [_dias]
		,convert(int,EMPLID) [_alter_id]
		,BEGIN_DT [_inicio]
		,RETURN_DT [_fin]
		,0 [_sync]
		,ABS_NOTIFY [_folio]
		,ABSENCE_TYPE [_ps_type]
	from PS.HRSYS.adm.PS_PH_INCCTRLASIVW with (nolock)
	where BEGIN_DT >= @fec_ini_per 
	union all
	select 
		newid() [_id_tmp]
		,(datediff(day, @fec_ini_per, RETURN_DT)+1) [_dias]
		,convert(int,EMPLID) [_alter_id]
		,@fec_ini_per [_inicio]
		,RETURN_DT [_fin]
		,0 [_sync]
		,ABS_NOTIFY [_folio]
		,ABSENCE_TYPE [_ps_type]
	from PS.HRSYS.adm.PS_PH_INCCTRLASIVW with (nolock)
	where BEGIN_DT < @fec_ini_per and RETURN_DT >= @fec_ini_per;

	------------------------------------------------------------
	-- Validamos si hay registros de vacaciones
	------------------------------------------------------------
	if (exists ( select top 1 _id_tmp from @incapacidades)) begin		
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
									, _folio nvarchar(10)
									, _ps_type char(1)
								);
	
		------------------------------------------------------------
		-- Variables de uso 
		------------------------------------------------------------
		declare @inc char(36)
				,@emp char(36), @alt int
				,@cn nvarchar(3)
				,@c int, @d int
				,@ini datetime
				,@actual char(36)
				,@folio nvarchar(10), @ps_type char(1)
		------------------------------------------------------------
		-- Declaramos contadores
		------------------------------------------------------------
		declare  @eliminados int, @insertados int;
		------------------------------------------------------------
		-- Asignamos los ids a incapacidades
		------------------------------------------------------------
		select @inc = cat.func_get_id_ausentismo('I')
		------------------------------------------------------------
		-- Recorremos tabla incapacidades
		------------------------------------------------------------
		while exists (select top 1 _id_tmp from @incapacidades where _sync = 0) begin				
			------------------------------------------------------------
			-- Llenamos variables de uso
			------------------------------------------------------------
			select 
				top 1 
				@actual = i._id_tmp 
				,@alt = i._alter_id
				,@emp = cat.func_get_id_employee(i._alter_id)			
				,@d = i._dias
				,@c = 0
				,@ini = i._inicio
				,@folio = i._folio
				,@ps_type = i._ps_type				
			from @incapacidades i	
			where i._sync = 0;

			if @emp is not null begin -- Validamos que el empleado exista
				while (@d > 0) begin -- Recorremos los dias			
					------------------------------------------------------------
					-- Insertamos registro por día en tabla variable ausentismos
					------------------------------------------------------------
					insert into @ausentismos
					select 
						'INTERFACE-INCAPACIDA-DES000000-00000' -- ID Generico 
						,@inc
						,dateadd(day, @c, @ini)
						,@alt
						,@emp
						,cat.func_get_cn(dateadd(day, @c, @ini))
						,cat.func_get_id_periodo(dateadd(day, @c, @ini))
						,0
						,@folio
						,@ps_type;
					--
					set @d = @d - 1;
					set @c = @c + 1;
				end;
			end;
			------------------------------------------------------------
			-- Actualizams _sync en tabla variable @incapacidades
			------------------------------------------------------------
			update @incapacidades
				set _sync = 1
			where _id_tmp = @actual;
		end;
		-------------------------------------------------------
		-- Insertamos en stage los registros a eliminar de tra.lista 
		-------------------------------------------------------	
		insert into stg.ausentismos_eliminados ([id_tra_ausentismo],insert_operator_id, id_ausentismo, _ausentismo_date, employee_id, _cN, id_periodo ,_sync, _folio, _ps_type)
		select 
			a.id_tra_ausentismo
			,a.insert_operator_id
			,a.id_ausentismo
			,a._ausentismo_date
			,a.employee_id
			,a._cN
			,a.id_periodo
			,0 [_sync]
			,a._folio
			,a._ps_type
		from tra.ausentismos a with(nolock) 
		left join @ausentismos b  on (	a.employee_id = b.employee_id 
									and a.id_ausentismo = b.id_ausentismo
									and a._ausentismo_date = b._ausentismo_date)
		where   b._ausentismo_date IS NULL
			and isnull(a._deleted,0) = 0
			and a._ausentismo_date >= @fec_ini_per
			and a.insert_operator_id = 'INTERFACE-INCAPACIDA-DES000000-00000'
			and (a.id_ausentismo = @inc)
			--and b._cN is not null;

	
		if @verbose = 1 set @eliminados = @@ROWCOUNT
		if @verbose = 1 print 'Eliminados: ' + rtrim(@eliminados);
		-------------------------------------------------------
		-- Insertamos en tra.ausentismos registros que faltan
		-------------------------------------------------------
		insert into tra.ausentismos (insert_operator_id, id_ausentismo, _ausentismo_date, employee_id, _cN, id_periodo ,_sync, _folio, _ps_type)
		select 
			a.insert_operator_id
			,a.id_ausentismo
			,a._ausentismo_date
			,a.employee_id
			,a._cN
			,a.id_periodo
			,a._sync
			,a._folio
			,a._ps_type	
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
			where _sync = 0 and _ausentismo_date >= @fec_ini_per and id_ausentismo = @inc		
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
					a.insert_operator_id ='INTERFACE-INCAPACIDA-DES000000-00000'
				and (a.id_ausentismo = @inc)
				and a._sync = 0
				and a._ausentismo_date >= @fec_ini_per) begin
			begin try
				set transaction isolation level read committed
				begin transaction ifc_incapacidades

					select top 1 @id= a.id_tra_ausentismo 
						, @q = 'update tra.lista 
									set _'+ a._cN +' = (case	when _'+a._cN+' is null then  '''+rtrim(cat.func_get_letra(a.id_ausentismo))+'''
																when LEN(rtrim(_'+a._cN+')) > 1 then convert(nvarchar(3),'''+rtrim(cat.func_get_letra(a.id_ausentismo))+'''+ RIGHT(rtrim(_'+a._cN+'),1))														
																else '''+rtrim(cat.func_get_letra(a.id_ausentismo))+''' end)
								where id_employee = '''+a.employee_id+''' and id_periodo = '''+a.id_periodo+''''	
					
					from tra.ausentismos a with(nolock)
					inner join tra.lista l with(nolock) on a.id_periodo = l.id_periodo and a.employee_id = l.id_employee
					where 
							a.insert_operator_id ='INTERFACE-INCAPACIDA-DES000000-00000'
						and (a.id_ausentismo = @inc)
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
				commit transaction ifc_incapacidades
			end try
			begin catch
				print ERROR_MESSAGE()
				rollback transaction ifc_incapacidades
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
					a.insert_operator_id ='INTERFACE-INCAPACIDA-DES000000-00000' 
				and (a.id_ausentismo = @inc)
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
							a.insert_operator_id ='INTERFACE-INCAPACIDA-DES000000-00000' 
						and (a.id_ausentismo = @inc)
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
				commit transaction
			end try
			begin catch
				print ERROR_MESSAGE()
				rollback transaction
			end catch 
		end;	
		if @verbose = 1 print 'Eliminados sync: ' + rtrim(@eliminados); 
	end; --/*endif exists @incapacidades*/	

	--####
	--select * from @ausentismos
	--####
end;

GO

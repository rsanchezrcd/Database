SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
  CREATE proc [ifc].[proc_employees]
	@op char(36) = null
	,@ifc char(36) = null
	,@result bit OUTPUT
  as begin
	--begin try
		--set transaction isolation level read uncommitted
		--begin transaction tran_employees
			if @op is null set @op = '00000000-0000-0000-0000-000000000000';
			declare @inserted int = 0
					,@updated int = 0
					,@ini datetime
					,@fin datetime
					,@dif int
			select @ini = getdate();
			-----------------------------------------------------------------
			--inserta nuevos colaboradores
			-----------------------------------------------------------------
			insert into [TimeIO].[cat].[employees] ( 
				insert_operator_id 
				,_alter_id, _nombres
				,_apellido_paterno
				,_apellido_materno
				,_status
				,_clase
				,locacion_id
				,departamento_id
				,posicion_id
				,_legal_id
				,_hire_date
				,_fecha_baja			
			)
			select 
				 @op [insert_operator_id],
				 _alter_id
				,_nombres
				,_apellido_paterno
				,_apellido_materno
				,_status
				,_clase
				,locacion_id
				,departamento_id
				,posicion_id
				,_legal_id
				,_hire_date	
				,_fecha_baja		
			from [stg].[vw_employees_converted] 			
			where _existe = 0;
			------
			set @inserted = @@ROWCOUNT;

			declare @fec_ini_per datetime
			exec cat.proc_get_fecha_ini_periodo_actual @fec_ini_per OUT
			-----------------------------------------------------------------
			-- update status
			-----------------------------------------------------------------
			update x
				set x._status = 0
				   ,x._fecha_baja = isnull(y._fecha_baja,@fec_ini_per-1)
			from cat.employees x with (nolock)
				left join stg.vw_employees_converted y on x._alter_id = y._alter_id
			where	y._alter_id is null
				and x._status = 1;			
			
			-----------------------------------------------------------------
			-- update nombres
			-----------------------------------------------------------------
			update x
				set x._nombres = y._nombres collate SQL_Latin1_General_CP1_CI_AS
				   ,x._apellido_paterno = y._apellido_paterno collate SQL_Latin1_General_CP1_CI_AS
				   ,x._apellido_materno = y._apellido_materno collate SQL_Latin1_General_CP1_CI_AS
			from cat.employees x with (nolock)
				left join stg.vw_employees_converted y on x._alter_id = y._alter_id
			where	_existe = 1	 and (
					x._nombres <> y._nombres collate SQL_Latin1_General_CP1_CI_AS
				   or x._apellido_paterno <> y._apellido_paterno collate SQL_Latin1_General_CP1_CI_AS
				   or x._apellido_materno <> y._apellido_materno collate SQL_Latin1_General_CP1_CI_AS)
			------

			set @updated = @updated + @@ROWCOUNT;

			update x
				set x._status = y._status
				   ,x._hire_date = y._hire_date
				   ,x._fecha_baja = y._fecha_baja
			from cat.employees x with (nolock)
				inner join stg.vw_employees_converted y on x._alter_id = y._alter_id
			where	_existe = 1
				and x._status <> y._status or x._hire_date <> y._hire_date;
			------
			set @updated = @updated + @@ROWCOUNT;
			-----------------------------------------------------------------
			-- update locacion
			-----------------------------------------------------------------
			update x
				set x.locacion_id = y.locacion_id
			from cat.employees x with (nolock)
				inner join stg.vw_employees_converted y on x._alter_id = y._alter_id
			where	_existe = 1
				and x.locacion_id <> y.locacion_id;
			------
			set @updated = @updated + @@ROWCOUNT;
			-----------------------------------------------------------------
			-- update departamento
			-----------------------------------------------------------------
			update x
				set x.departamento_id = y.departamento_id
			from cat.employees x with (nolock)
				inner join stg.vw_employees_converted y on x._alter_id = y._alter_id
			where	_existe = 1
				and x.departamento_id <> y.departamento_id;
			------
			set @updated = @updated + @@ROWCOUNT;
			-----------------------------------------------------------------
			-- update posicion
			-----------------------------------------------------------------
			update x
				set x.posicion_id = y.posicion_id
			from cat.employees x with (nolock)
				inner join stg.vw_employees_converted y on x._alter_id = y._alter_id
			where	_existe = 1
				and x.posicion_id <> y.posicion_id;
			------
			set @updated = @updated + @@ROWCOUNT;

			-----------------------------------------------------------------
			-- update clase
			-----------------------------------------------------------------
			update x
				set x._clase = y._clase collate SQL_Latin1_General_CP1_CI_AS
			from cat.employees x with (nolock)
				inner join stg.vw_employees_converted y on x._alter_id = y._alter_id
			where	_existe = 1
				and x._clase <> y._clase collate SQL_Latin1_General_CP1_CI_AS;
			-----------------------------------------------------------------
			-- Eliminamos de tra.lista los colaboradores que 
			-- ya son baja al inicio del periodo actual.
			-----------------------------------------------------------------
			delete from tra.lista 
			where cat.func_isactive_bydt(@fec_ini_per, id_employee) = 0
			and id_periodo = cat.func_get_id_periodo(@fec_ini_per);
			-----------------------------------------------------------------
			-- Insertamos evento en tabla ifc.event
			-- No tocar
			-----------------------------------------------------------------
			select @fin = getdate();
			set @dif = DATEDIFF(second, @ini, @fin);
			if @ifc is not null begin			
				
				insert into ifc.event(
					_type, id_interface, _message , _inserted, _updated, _ini , _fin, _dif
				)values(
					1 -- success
					,@ifc,'Success',@inserted, @updated, @ini, @fin, @dif
				);
			end;
			set @result = 1


			--RAISERROR ('Error de prueba...', 16, 10);			
		--commit transaction tran_employees
	--end try
	--begin catch
		/*rollback transaction tran_employees
		if @ifc is not null begin			
			
			insert into ifc.event(
				_type, id_interface, _message 
			)values(
				0 -- error
				,@ifc,convert(nvarchar(max),ERROR_MESSAGE())
			);
		end;
		declare	  @txt nvarchar(max)
				, @date nvarchar(23) 
				, @sub nvarchar(max)
		select @date = convert(varchar, getdate() ,121) 
		
		set @txt =  'Errores detecados en la ejecucion del SP ifc.proc_employees'; 
		set @txt = @txt + CHAR(13)+CHAR(10)+'	* Error: 	' + convert(nvarchar(max),ERROR_MESSAGE()); 
		set @txt = @txt + CHAR(13)+CHAR(10)+'	* Date: 	' + @date;
		set @sub = '[IFC][Time.io][Errores]['+@date+'][ifc.proc_employees]'
		EXEC msdb.dbo.sp_send_dbmail  
			@profile_name = 'RelayRiviera',  
			@recipients = 'rsanchez@rcdhotels.com',  
			@body = @txt,
			@subject =  @sub;
		set @result  =1;
	end catch*/
end
GO

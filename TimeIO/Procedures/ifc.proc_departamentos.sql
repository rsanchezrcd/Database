SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
  CREATE proc [ifc].[proc_departamentos]
	@op char(36) = null
	,@ifc char(36) = null
	,@result bit OUTPUT
  as begin
	begin try
		begin transaction
			if @op is null set @op = '00000000-0000-0000-0000-000000000000';
			-----------------------------------------------------------------
			declare  @inserted int = 0
					,@updated int = 0					
					,@ini datetime
					,@fin datetime
					,@dif int
			select @ini = getdate();
			-----------------------------------------------------------------
			
			-----------------------------------------------------------------
			-- Insertar departamentos nuevos
			-----------------------------------------------------------------
			insert into [TimeIO].[cat].[departamentos] ( 
					[insert_operator_id] 
				,	[_departamento_code]
				,	[_departamento_name]
			)
			select 
				 @op [insert_operator_id],				 
				 P.[DEPTID] [_departamento_code]
				,P.[DESCR_DEPT] [_departamento_name]
				
			from stg.departamento P				
				left join [TimeIO].[cat].[departamentos] d on P.[DEPTID] collate SQL_Latin1_General_CP1_CI_AS = d.[_departamento_code]
			where					
					P.[DEPTID] collate SQL_Latin1_General_CP1_CI_AS not in (SELECT [_departamento_code]
																			FROM [TimeIO].[cat].[departamentos])
				and P.[DEPTID] is not null
			--group by P.[DEPTID], P.[DESCR];
			set @inserted = @@ROWCOUNT;
			-----------------------------------------------------------------

			-----------------------------------------------------------------
			-- Actualizar parents
			-----------------------------------------------------------------
			update y 
				set y._father_id = x._dad
			from cat.departamentos y
			inner join ( select distinct
							c.id_departamento
							,b.id_departamento _dad 	
						from stg.departamento a
						inner join cat.departamentos b on a.PARENT_NODE_NAME collate SQL_Latin1_General_CP1_CI_AS = b._departamento_code
						inner join cat.departamentos c on a.DEPTID collate SQL_Latin1_General_CP1_CI_AS = c._departamento_code
			
						) x on y.id_departamento = x.id_departamento
			set @updated = @updated + @@ROWCOUNT;
			-----------------------------------------------------------------
			-- Actualizar nombres de departamentos
			-----------------------------------------------------------------
			update y
				set y._departamento_name = x._departamento_name
			from cat.departamentos y
			inner join (select 
							 --@op [insert_operator_id],
							 P.[DEPTID] [_departamento_code]
							,P.[DESCR_DEPT] [_departamento_name]
				
						from stg.departamento P				
							inner join [TimeIO].[cat].[departamentos] d on P.[DEPTID] collate SQL_Latin1_General_CP1_CI_AS = d.[_departamento_code]
						where					
								P.[DESCR_DEPT] collate SQL_Latin1_General_CP1_CI_AS  <> d._departamento_name
				
						) x on y._departamento_code = x._departamento_code collate SQL_Latin1_General_CP1_CI_AS
			
			set @updated = @updated + @@ROWCOUNT;

			--select @inserted, @updated
			 
			-----------------------------------------------------------------
			-- Inserto evento success
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
		commit transaction
	end try
	begin catch
		rollback transaction
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
		
		set @txt =  'Errores detecados en la ejecucion del SP ifc.proc_depatamentos'; 
		set @txt = @txt + CHAR(13)+CHAR(10)+'	* Error: 	' + convert(nvarchar(max),ERROR_MESSAGE()); 
		set @txt = @txt + CHAR(13)+CHAR(10)+'	* Date: 	' + @date;
		set @sub = '[IFC][Time.io][Errores]['+@date+'][ifc.proc_departamentos]'
		EXEC msdb.dbo.sp_send_dbmail  
			@profile_name = 'RelayRiviera',  
			@recipients = 'rsanchez@rcdhotels.com',  
			@body = @txt,
			@subject =  @sub;
		
		set @result = 0;
	end catch
end

GO

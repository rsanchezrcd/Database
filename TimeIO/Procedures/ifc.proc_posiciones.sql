SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
  CREATE proc [ifc].[proc_posiciones]
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
			--select * from [PS].[HRSYS].[adm].[VW_RHEMPDEP_RSM]
			insert into [TimeIO].[cat].[posicion]( 
					[insert_operator_id] 
				,	[_posicion_code]
				,	[_posicion_name]
			)
			select 
				 @op [insert_operator_id],
				 P.[POSITION_NBR] _posicion_code
				,P.[POSITION_DESCR] _posicion_name
				
			from stg.employees P				
				left join [TimeIO].[cat].[posicion] n on P.[JOBCODE] collate SQL_Latin1_General_CP1_CI_AS = n._posicion_code
			where					
					P.[POSITION_NBR] collate SQL_Latin1_General_CP1_CI_AS not in (SELECT [_posicion_code]
																			FROM [TimeIO].[cat].[posicion])
				and P.[POSITION_NBR] is not null
			group by P.[POSITION_NBR], P.[POSITION_DESCR];
			set @inserted = @@ROWCOUNT;
			-----------------------------------------------------------------
			
			-----------------------------------------------------------------
			-- Actualizar nombres de departamentos
			-----------------------------------------------------------------
			update y
				set y._posicion_name = x._posicion_name
			from cat.posicion y
			inner join (select 
							 --@op [insert_operator_id],
							 P.[POSITION_NBR] _posicion_code
							,P.[POSITION_DESCR] _posicion_name
				
						from stg.employees P				
							inner join [TimeIO].[cat].posicion n on P.[POSITION_NBR] collate SQL_Latin1_General_CP1_CI_AS = n._posicion_code
						where					
								P.[POSITION_DESCR] collate SQL_Latin1_General_CP1_CI_AS  <> n._posicion_name
				
						group by P.[POSITION_NBR], P.[POSITION_DESCR]) x on y._posicion_code = x._posicion_code collate SQL_Latin1_General_CP1_CI_AS
			
			set @updated = @@ROWCOUNT;

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
		set @result = 1;
	end catch
end

GO

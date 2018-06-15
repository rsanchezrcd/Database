SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [ifc].[proc_stg_employees]
	@ifc char(36) = null
	,@result bit OUTPUT
as begin
	begin try
		begin transaction
			declare  @inserted int = 0					
					,@ini datetime
					,@fin datetime
					,@dif int
			set @ini = getdate();
			--------------------------------
			truncate table stg.employees
			--------------------------------
			insert into stg.employees(
			   [EMPLID]
			  ,[EMPL_RCD]
			  ,[FIRST_NAME]
			  ,[LAST_NAME]
			  ,[SECOND_LAST_NAME]
			  ,[DEPTID]
			  ,[DESCR]
			  ,[ORIG_HIRE_DT]
			  ,[JOBCODE]
			  ,[JOBDESCR]
			  ,[NUMERO]
			  ,[EMPLCLASS]
			  ,[EMPL_STATUS]
			  ,[COMPANY]
			  ,[LOCATION]
			  ,[VACACIONES]
			  ,[HOTEL]
			  ,[NATIONAL_ID]
			  ,[EFFDT]
			  ,[TERMINATION_DT]
			  ,[POSITION_NBR]	
			  ,[POSITION_DESCR]  
			)
			select distinct R.[EMPLID]
			  ,R.[EMPL_RCD]
			  ,R.[FIRST_NAME]
			  ,R.[LAST_NAME]
			  ,R.[SECOND_LAST_NAME]
			  ,R.[DEPTID]
			  ,R.[DESCR]
			  ,R.[ORIG_HIRE_DT]
			  ,R.[JOBCODE]
			  ,R.[JOBDESCR]
			  ,R.[NUMERO]
			  ,R.[EMPLCLASS]
			  ,R.[EMPL_STATUS]
			  ,R.[COMPANY]
			  ,R.[LOCATION]
			  ,R.[VACACIONES]
			  ,R.[HOTEL]
			  ,R.[NATIONAL_ID]
			  ,R.[EFFDT]
			  ,R.[TERMINATION_DT]
			  ,R.[POSITION_NBR]
			  ,P.[DESCR]
			 from PS.HRSYS.[adm].[VW_RHEMPDEP] R with(nolock)
			 inner join PS.HRSYS.dbo.PS_PH_RHPOSACT_VW P with(nolock) on P.[POSITION_NBR] = R.[POSITION_NBR]
			 where LOCATION in (select distinct _alter_code collate Latin1_General_BIN  
								from cat.locacion with(nolock)
								where active = 1)
								--and EMPLID = '078422'
			 set @inserted = @@ROWCOUNT;

			 ---------------------------------------------
			 --STAGE departamentos
			 ---------------------------------------------
			 truncate table stg.departamento
			 insert into stg.departamento
			 select DEPTID, DESCR_DEPT, PARENT_NODE_NAME 
			 from PS.HRSYS.[adm].[VW_RHSEGDEP]
			 set @inserted = @inserted + @@ROWCOUNT;

			 set @fin = getdate();
			 set @dif = DATEDIFF(second, @ini, @fin);
			 
			 if @ifc is not null begin			
				
				insert into ifc.event(
					_type, id_interface, _message , _inserted, _updated, _ini , _fin, _dif
				)values(
					1 -- success
					,@ifc,'Success',@inserted, 0, @ini, @fin, @dif
				);
			end;
			set @result = 1
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
		set @date = convert(varchar, getdate() ,121) 
		
		set @txt =  'Errores detecados en la ejecucion del SP ifc.proc_stg_employees'; 
		set @txt = @txt + CHAR(13)+CHAR(10)+'	* Error: 	' + convert(nvarchar(max),ERROR_MESSAGE()); 
		set @txt = @txt + CHAR(13)+CHAR(10)+'	* Date: 	' + @date;
		set @sub = '[IFC][Time.io][Errores]['+@date+'][ifc.proc_stg_employees]'
		EXEC msdb.dbo.sp_send_dbmail  
			@profile_name = 'RelayRiviera',  
			@recipients = 'rsanchez@rcdhotels.com',  
			@body = @txt,
			@subject =  @sub;

		set @result = 0
	end catch
end

GO

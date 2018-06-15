SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
/*
ALTER procedure [cat].[proc_set_emp_checa]
	 @emp char(36)
	,@ope char(36)
	,@val bit 
	,@res bit output
	,@msg nvarchar(1024) output
as begin
	
	set nocount on;

	begin try
		set transaction isolation level read committed
		begin transaction tran_set_emp_checa
			
			declare @a bit;

			select @a = _checa 
			from cat.employees 
			where employee_id = @emp;
			
			if @a<>@val begin
				update cat.employees set 
					_checa = @val
					,update_operator_id = @ope
					,update_date = getdate()
				where employee_id = @emp;

				declare @per char(36)
				select @per = cat.func_get_id_periodo(getdate())
				if @val = 0 begin
					update tra.lista set 
						_c01 = (case when isnull(_c01,'F') = 'F' then 'N' else _c01 end)
						,_c02 = (case when isnull(_c02,'F') = 'F' then 'N' else _c02 end)
						,_c03 = (case when isnull(_c03,'F') = 'F' then 'N' else _c03 end)
						,_c04 = (case when isnull(_c04,'F') = 'F' then 'N' else _c04 end)
						,_c05 = (case when isnull(_c05,'F') = 'F' then 'N' else _c05 end)
						,_c06 = (case when isnull(_c06,'F') = 'F' then 'N' else _c06 end)
						,_c07 = (case when isnull(_c07,'F') = 'F' then 'N' else _c07 end)
						,_c08 = (case when isnull(_c08,'F') = 'F' then 'N' else _c08 end)
						,_c09 = (case when isnull(_c09,'F') = 'F' then 'N' else _c09 end)
						,_c10 = (case when isnull(_c10,'F') = 'F' then 'N' else _c10 end)
						,_c11 = (case when isnull(_c11,'F') = 'F' then 'N' else _c11 end)
						,_c12 = (case when isnull(_c12,'F') = 'F' then 'N' else _c12 end)
						,_c13 = (case when isnull(_c13,'F') = 'F' then 'N' else _c13 end)
						,_c14 = (case when isnull(_c14,'F') = 'F' then 'N' else _c14 end)
						,_c15 = (case when isnull(_c15,'F') = 'F' then 'N' else _c15 end)
						,_c16 = (case when isnull(_c16,'F') = 'F' then 'N' else _c16 end)
					where id_employee = @emp and id_periodo = @per;
				end;
				if @val = 1 begin
					update tra.lista set 
						_c01 = (case when isnull(_c01,'N') = 'N' then 'F' else _c01 end)
						,_c02 = (case when isnull(_c02,'N') = 'N' then 'F' else _c02 end)
						,_c03 = (case when isnull(_c03,'N') = 'N' then 'F' else _c03 end)
						,_c04 = (case when isnull(_c04,'N') = 'N' then 'F' else _c04 end)
						,_c05 = (case when isnull(_c05,'N') = 'N' then 'F' else _c05 end)
						,_c06 = (case when isnull(_c06,'N') = 'N' then 'F' else _c06 end)
						,_c07 = (case when isnull(_c07,'N') = 'N' then 'F' else _c07 end)
						,_c08 = (case when isnull(_c08,'N') = 'N' then 'F' else _c08 end)
						,_c09 = (case when isnull(_c09,'N') = 'N' then 'F' else _c09 end)
						,_c10 = (case when isnull(_c10,'N') = 'N' then 'F' else _c10 end)
						,_c11 = (case when isnull(_c11,'N') = 'N' then 'F' else _c11 end)
						,_c12 = (case when isnull(_c12,'N') = 'N' then 'F' else _c12 end)
						,_c13 = (case when isnull(_c13,'N') = 'N' then 'F' else _c13 end)
						,_c14 = (case when isnull(_c14,'N') = 'N' then 'F' else _c14 end)
						,_c15 = (case when isnull(_c15,'N') = 'N' then 'F' else _c15 end)
						,_c16 = (case when isnull(_c16,'N') = 'N' then 'F' else _c16 end)
					where id_employee = @emp and id_periodo = @per;
				end;
				set @res = 1
				set @msg = 'Configurado correctamente ...';
			end else begin
				set @res = 0;
				set @msg = 'Previamente configurado ...';
			end; 
		commit transaction tran_set_emp_checa
	end try
	begin catch
		print error_message();
		set @res = 0;
		set @msg = error_message();
		rollback transaction tran_set_emp_checa
	end catch
	

end;

go

declare @res  bit
	,@msg nvarchar(1024) , @emp char(36), @ope char(36)

select @ope = cat.func_get_id_operator('rsanchez'), @emp = cat.func_get_id_employee(6820) 

exec [cat].[proc_set_emp_checa]
	 @emp 
	,@ope 
	,0
	,@res  output
	,@msg  output

select @res , @msg


go

*/


CREATE procedure tra.proc_califica_nocheca_byper
	@per char(36) = null
as begin
	
	set nocount on;
	declare @employees table( _emp char(36),_alter int,  _done bit);
	declare @emp char(36)
	if @per is null begin
		exec cat.proc_get_periodo_actual @per OUTPUT
	end
	insert into @employees
	select employee_id, _alter_id ,0 from cat.employees where _checa = 0;


	while (exists (select top 1 _emp from @employees where _done = 0)) begin
		begin try 
			set transaction isolation level read committed
			begin transaction tran_no_checa
				select top 1 @emp = _emp from @employees where _done = 0;
				---------------------------------------------------------
				update tra.lista set 
						_c01 = (case when isnull(_c01,'F') = 'F' or isnull(_c01,'F') = '/' then 'N' else _c01 end)
						,_c02 = (case when isnull(_c02,'F') = 'F' or isnull(_c01,'F') = '/' then 'N' else _c02 end)
						,_c03 = (case when isnull(_c03,'F') = 'F' or isnull(_c01,'F') = '/' then 'N' else _c03 end)
						,_c04 = (case when isnull(_c04,'F') = 'F' or isnull(_c01,'F') = '/' then 'N' else _c04 end)
						,_c05 = (case when isnull(_c05,'F') = 'F' or isnull(_c01,'F') = '/' then 'N' else _c05 end)
						,_c06 = (case when isnull(_c06,'F') = 'F' or isnull(_c01,'F') = '/' then 'N' else _c06 end)
						,_c07 = (case when isnull(_c07,'F') = 'F' or isnull(_c01,'F') = '/' then 'N' else _c07 end)
						,_c08 = (case when isnull(_c08,'F') = 'F' or isnull(_c01,'F') = '/' then 'N' else _c08 end)
						,_c09 = (case when isnull(_c09,'F') = 'F' or isnull(_c01,'F') = '/' then 'N' else _c09 end)
						,_c10 = (case when isnull(_c10,'F') = 'F' or isnull(_c01,'F') = '/' then 'N' else _c10 end)
						,_c11 = (case when isnull(_c11,'F') = 'F' or isnull(_c01,'F') = '/' then 'N' else _c11 end)
						,_c12 = (case when isnull(_c12,'F') = 'F' or isnull(_c01,'F') = '/' then 'N' else _c12 end)
						,_c13 = (case when isnull(_c13,'F') = 'F' or isnull(_c01,'F') = '/' then 'N' else _c13 end)
						,_c14 = (case when isnull(_c14,'F') = 'F' or isnull(_c01,'F') = '/' then 'N' else _c14 end)
						,_c15 = (case when isnull(_c15,'F') = 'F' or isnull(_c01,'F') = '/' then 'N' else _c15 end)
						,_c16 = (case when isnull(_c16,'F') = 'F' or isnull(_c01,'F') = '/' then 'N' else _c16 end)
				where id_employee = @emp and id_periodo = @per;
				---------------------------------------------------------
				update @employees set _done = 1
				where _emp = @emp;
			commit transaction tran_no_checa

			
		end try
		begin catch
			print error_message();
			rollback transaction tran_no_checa
		end catch
	end;

	declare @per_int int , @ano int
	select top 1 @per_int = _per, @ano = _year from cat.periodos where id_periodo = @per;
			
	delete from va.asistenciasql.dbo.inasist 
	where ano = @ano and periodo = @per_int 
	and numero in (select _alter from @employees);
	
end;


GO

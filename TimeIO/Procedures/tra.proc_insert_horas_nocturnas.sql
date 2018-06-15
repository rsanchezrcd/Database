SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [tra].[proc_insert_horas_nocturnas]
  @per char(36)
 ,@emp char(36)
 ,@ope char(36)
 ,@cn char(4)
 ,@val int = null
 ,@msg nvarchar(1024) output
 ,@res bit output
 ,@pagadas int output
as begin 
	set nocount on;

	begin try
		set transaction isolation level read committed
		begin transaction tran_insert_horas_nocturnas
			------------------
			--Declaramos variables
			declare @idt table (_id char(36));
			declare @g int, @fec char(36), @a bit, @b bit, @fechaint int, @he_override bit, @hn tinyint
			------------------
			--Obtenemos el id de Fecha
			select top 1 @fec = id_fecha, @fechaint = fecha_int from adm.fechas where id_periodo = @per and _cN = lower(rtrim(replace(@cn, '_', '')));
			------------------
			--Obtenemos si el periodo está cerrado
			select @a = (case when _cerrado = 1 then 0 else 1 end)  from cat.periodos where id_periodo = @per;
			------------------
			--Si el valor es nulo convertimos a 0 
			if @val is null set @val = 0;
			------------------
			if @a = 1 begin
				select @b = _horas_nocturnas from cat.posicion p 
				inner join cat.employees e on p.posicion_id = e.posicion_id
				where e.employee_id = @emp;
			end
			select @he_override = _he_override from cat.roles
			where id_role =  (select id_role from cat.operator where operator_id = @ope)

			/*select @hn = (case when _horas_nocturnas = 1 then 1 else 0 end) 
			from cat.posicion 
			where posicion_id =(select posicion_id from cat.employees where employee_id = @emp)*/

			------------------
			if @a = 1 begin
				if @b = 1 or @he_override = 1 begin
					
					if @val = 1 or @val = 0 begin
						declare  @jor int
								,@ent datetime
								,@fec_min  datetime
								,@fec_max  datetime
								,@min nvarchar(5)
								,@max nvarchar(5)
						exec adm.proc_get_param_output 'horas_nocturnas_min', @min OUTPUT
						exec adm.proc_get_param_output 'horas_nocturnas_max', @max OUTPUT

						select @jor = sum(_jornada) 
							,@ent = max(_entrada)
							,@fec_min = convert(datetime , max(_fecha_ent)) + @min
							,@fec_max = convert(datetime , max(_fecha_ent)) + @max
						from tra.jornadas
						where employee_id = @emp and id_periodo = @per and _cN = replace(@cn, '_', '');
						--print @fec_min
						if ((@jor >= 470 and ( @ent between @fec_min and @fec_max)) or @he_override = 1 or @val = 0) begin
							declare @q nvarchar(1024)
							select @q = 'update tra.horas_nocturnas set
										_'+replace(@cn, '_', '')+' = '+rtrim(@val)+' 	
									where id_employee = '''+ @emp+''' and id_periodo = ''' + @per +'''';
							exec(@q)
							select @q = 'declare @idt table (_id char(36));
										update tra.horas_nocturnas set						 
											_horas = (_c01 + _c02 + _c03 + _c04 + _c05 +_c06 + _c07 + _c08 + _c09 + _c10 + _c11 + _c12 + _c13 + _c14 + _c15 +_c16 )	,
											update_date = getdate()	
										output inserted.id_horas_nocturnas into @idt				
									where id_employee = '''+ @emp+''' and id_periodo = ''' + @per +''';
									select * from @idt';
							insert into @idt
							exec(@q)
							set @res = 1;
						end else begin
							set @res = 0
							--set @msg = 'No aplica Jornada Nocturna ...'
						end;
					end

					if @res = 1 begin
						declare @id char(36)
						select top 1 @id = _id  from @idt; 
						---select @pagadas = _horas from tra.horas_nocturnas where id_horas_nocturnas = @id;
						--- descativamos horas pagadas anteriormente
						--- se mantienen registros como log
						update tra.horas_nocturnas_log set active = 0
						where id_employee = @emp and id_periodo = @per and _cn = @cn;

						--insertamos nuevo registro
						insert into tra.horas_nocturnas_log (insert_operator_id, id_horas_nocturnas, id_employee,id_periodo, _cn, _horas, id_fecha)
						values (@ope,@id,@emp,@per,@cn, @val, @fec);
						set @res = 1
						set @msg = 'Horas Insertadas'
					end else begin 
						set @res = 0
						set @msg = 'Horas insuficientes o no aplica nocturna...'
					end 
				end else begin 
					set @res = 0
					set @msg = 'Posicion no Autorizada...'
				end 
			end else begin 
				set @res = 0
				set @msg = 'Periodo Cerrado ...'
			end 

			select @pagadas = _horas from tra.horas_nocturnas
			where id_employee = @emp and id_periodo = @per;
		commit transaction tran_insert_horas_nocturnas


		
	end try
	begin catch
		print error_message()
		set @res = 0
		rollback transaction tran_insert_horas_nocturnas
	end catch
	-----------------------------------

	if @res = 1 begin
		declare @alter int, @fechaviejo nvarchar(10);
	
		select 
			  @fechaviejo = convert(nvarchar(10), @fechaint )
			, @alter = _alter_id from cat.employees
		where employee_id = @emp;
		--exec VA.AsistenciaSQL.ifc.sp_insert_hora @alter, @fechaviejo, @val
	end
	-----------------------------------
end

GO

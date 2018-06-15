SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [tra].[proc_insert_horas_extras]
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
		begin transaction tran_insert_horas_extras
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
				select @b = _horas_extras from cat.posicion p 
				inner join cat.employees e on p.posicion_id = e.posicion_id
				where e.employee_id = @emp;
			end
			select @he_override = _he_override from cat.roles
			where id_role =  (select id_role from cat.operator where operator_id = @ope)

			select @hn = (case when _horas_nocturnas = 1 then 1 else 0 end) 
			from cat.posicion 
			where posicion_id =(select posicion_id from cat.employees where employee_id = @emp)

			------------------
			if @a = 1 begin
				if @b = 1 or @he_override = 1 begin
					set @res = 0 --inicializa resultado
					if @cn = '_c01' begin
				
						select @g = (isnull(_c01,0) + @hn) from  tra.horas_extras
						where id_periodo = @per and id_employee = @emp;
						if @g >= @val or @he_override = 1 begin
							------------------
							update tra.horas_extras set
								_p01 = @val
								,update_date = getdate()
								,_pagadas = (isnull(@val,0)+isnull(_p02,0)+isnull(_p03,0)+isnull(_p04,0)+isnull(_p05,0)+isnull(_p06,0)+isnull(_p07,0)+isnull(_p08,0)+isnull(_p09,0)+isnull(_p10,0)+isnull(_p11,0)+isnull(_p12,0)+isnull(_p13,0)+isnull(_p14,0)+isnull(_p15,0)+isnull(_p16,0))
							output inserted.id_horas_extras into @idt
							where id_periodo = @per and id_employee = @emp;
							------------------
							set @res = 1
						end
					end
					------------------
					------------------
					if @cn = '_c02' begin			
						select @g = (isnull(_c02,0) + @hn) from  tra.horas_extras
						where id_periodo = @per and id_employee = @emp;
						if @g >= @val or @he_override = 1 begin
							------------------
							update tra.horas_extras set
								_p02 = @val
								,update_date = getdate()
								,_pagadas = (isnull(_p01,0)+isnull(@val,0)+isnull(_p03,0)+isnull(_p04,0)+isnull(_p05,0)+isnull(_p06,0)+isnull(_p07,0)+isnull(_p08,0)+isnull(_p09,0)+isnull(_p10,0)+isnull(_p11,0)+isnull(_p12,0)+isnull(_p13,0)+isnull(_p14,0)+isnull(_p15,0)+isnull(_p16,0))
							output inserted.id_horas_extras into @idt
							where id_periodo = @per and id_employee = @emp
							------------------
							set @res = 1
						end
					end
					------------------
					------------------
					if @cn = '_c03' begin			
						select @g = (isnull(_c03,0) + @hn) from  tra.horas_extras
						where id_periodo = @per and id_employee = @emp;
						if @g >= @val or @he_override = 1 begin
							------------------
							update tra.horas_extras set
								_p03 = @val
								,update_date = getdate()
								,_pagadas = (isnull(_p01,0)+isnull(_p02,0)+isnull(@val,0)+isnull(_p04,0)+isnull(_p05,0)+isnull(_p06,0)+isnull(_p07,0)+isnull(_p08,0)+isnull(_p09,0)+isnull(_p10,0)+isnull(_p11,0)+isnull(_p12,0)+isnull(_p13,0)+isnull(_p14,0)+isnull(_p15,0)+isnull(_p16,0))
							output inserted.id_horas_extras into @idt
							where id_periodo = @per and id_employee = @emp
							------------------
							set @res = 1
						end
					end
					------------------
					------------------
					if @cn = '_c04' begin			
						select @g = (isnull(_c04,0) + @hn) from  tra.horas_extras
						where id_periodo = @per and id_employee = @emp;
						if @g >= @val or @he_override = 1 begin
							------------------
							update tra.horas_extras set
								_p04 = @val
								,update_date = getdate()
								,_pagadas = (isnull(_p01,0)+isnull(_p02,0)+isnull(_p03,0)+isnull(@val,0)+isnull(_p05,0)+isnull(_p06,0)+isnull(_p07,0)+isnull(_p08,0)+isnull(_p09,0)+isnull(_p10,0)+isnull(_p11,0)+isnull(_p12,0)+isnull(_p13,0)+isnull(_p14,0)+isnull(_p15,0)+isnull(_p16,0))
							output inserted.id_horas_extras into @idt
							where id_periodo = @per and id_employee = @emp
							------------------
							set @res = 1
						end
					end
					------------------
					------------------
					if @cn = '_c05' begin			
						select @g = (isnull(_c05,0) + @hn) from  tra.horas_extras
						where id_periodo = @per and id_employee = @emp;
						if @g >= @val or @he_override = 1 begin
							------------------
							update tra.horas_extras set
								_p05 = @val
								,update_date = getdate()
								,_pagadas = (isnull(_p01,0)+isnull(_p02,0)+isnull(_p03,0)+isnull(_p04,0)+isnull(@val,0)+isnull(_p06,0)+isnull(_p07,0)+isnull(_p08,0)+isnull(_p09,0)+isnull(_p10,0)+isnull(_p11,0)+isnull(_p12,0)+isnull(_p13,0)+isnull(_p14,0)+isnull(_p15,0)+isnull(_p16,0))
							output inserted.id_horas_extras into @idt
							where id_periodo = @per and id_employee = @emp
							------------------
							set @res = 1
						end
					end
					------------------
					------------------
					if @cn = '_c06' begin			
						select @g = (isnull(_c06,0) + @hn) from  tra.horas_extras
						where id_periodo = @per and id_employee = @emp;
						if @g >= @val or @he_override = 1 begin
							------------------
							update tra.horas_extras set
								_p06 = @val
								,update_date = getdate()
								,_pagadas = (isnull(_p01,0)+isnull(_p02,0)+isnull(_p03,0)+isnull(_p04,0)+isnull(_p05,0)+isnull(@val,0)+isnull(_p07,0)+isnull(_p08,0)+isnull(_p09,0)+isnull(_p10,0)+isnull(_p11,0)+isnull(_p12,0)+isnull(_p13,0)+isnull(_p14,0)+isnull(_p15,0)+isnull(_p16,0))
							output inserted.id_horas_extras into @idt
							where id_periodo = @per and id_employee = @emp
							------------------
							set @res = 1
						end
					end
					------------------
					------------------
					if @cn = '_c07' begin			
						select @g = (isnull(_c07,0) + @hn) from  tra.horas_extras
						where id_periodo = @per and id_employee = @emp;
						if @g >= @val or @he_override = 1 begin
							------------------
							update tra.horas_extras set
								_p07 = @val
								,update_date = getdate()
								,_pagadas = (isnull(_p01,0)+isnull(_p02,0)+isnull(_p03,0)+isnull(_p04,0)+isnull(_p05,0)+isnull(_p06,0)+isnull(@val,0)+isnull(_p08,0)+isnull(_p09,0)+isnull(_p10,0)+isnull(_p11,0)+isnull(_p12,0)+isnull(_p13,0)+isnull(_p14,0)+isnull(_p15,0)+isnull(_p16,0))
							output inserted.id_horas_extras into @idt
							where id_periodo = @per and id_employee = @emp
							------------------
							set @res = 1
						end
					end
					------------------
					------------------
					if @cn = '_c08' begin			
						select @g = (isnull(_c08,0) + @hn) from  tra.horas_extras
						where id_periodo = @per and id_employee = @emp;
						if @g >= @val or @he_override = 1 begin
							------------------
							update tra.horas_extras set
								_p08 = @val
								,update_date = getdate()
								,_pagadas = (isnull(_p01,0)+isnull(_p02,0)+isnull(_p03,0)+isnull(_p04,0)+isnull(_p05,0)+isnull(_p06,0)+isnull(_p07,0)+isnull(@val,0)+isnull(_p09,0)+isnull(_p10,0)+isnull(_p11,0)+isnull(_p12,0)+isnull(_p13,0)+isnull(_p14,0)+isnull(_p15,0)+isnull(_p16,0))
							output inserted.id_horas_extras into @idt
							where id_periodo = @per and id_employee = @emp
							------------------
							set @res = 1
						end
					end
					------------------
					------------------
					if @cn = '_c09' begin			
						select @g = (isnull(_c09,0) + @hn) from  tra.horas_extras
						where id_periodo = @per and id_employee = @emp;
						if @g >= @val or @he_override = 1 begin
							------------------
							update tra.horas_extras set
								_p09 = @val
								,update_date = getdate()
								,_pagadas = (isnull(_p01,0)+isnull(_p02,0)+isnull(_p03,0)+isnull(_p04,0)+isnull(_p05,0)+isnull(_p06,0)+isnull(_p07,0)+isnull(_p08,0)+isnull(@val,0)+isnull(_p10,0)+isnull(_p11,0)+isnull(_p12,0)+isnull(_p13,0)+isnull(_p14,0)+isnull(_p15,0)+isnull(_p16,0))
							output inserted.id_horas_extras into @idt
							where id_periodo = @per and id_employee = @emp
							------------------
							set @res = 1
						end
					end
					------------------
					------------------
					if @cn = '_c10' begin			
						select @g = (isnull(_c10,0) + @hn) from  tra.horas_extras
						where id_periodo = @per and id_employee = @emp;
						if @g >= @val or @he_override = 1 begin
							------------------
							update tra.horas_extras set
								_p10 = @val
								,update_date = getdate()
								,_pagadas = (isnull(_p01,0)+isnull(_p02,0)+isnull(_p03,0)+isnull(_p04,0)+isnull(_p05,0)+isnull(_p06,0)+isnull(_p07,0)+isnull(_p08,0)+isnull(_p09,0)+isnull(@val,0)+isnull(_p11,0)+isnull(_p12,0)+isnull(_p13,0)+isnull(_p14,0)+isnull(_p15,0)+isnull(_p16,0))
							output inserted.id_horas_extras into @idt
							where id_periodo = @per and id_employee = @emp
							------------------
							set @res = 1
						end
					end
					------------------
					------------------
					if @cn = '_c11' begin			
						select @g = (isnull(_c11,0) + @hn) from  tra.horas_extras
						where id_periodo = @per and id_employee = @emp;
						if @g >= @val or @he_override = 1 begin
							------------------
							update tra.horas_extras set
								_p11 = @val
								,update_date = getdate()
								,_pagadas = (isnull(_p01,0)+isnull(_p02,0)+isnull(_p03,0)+isnull(_p04,0)+isnull(_p05,0)+isnull(_p06,0)+isnull(_p07,0)+isnull(_p08,0)+isnull(_p09,0)+isnull(_p10,0)+isnull(@val,0)+isnull(_p12,0)+isnull(_p13,0)+isnull(_p14,0)+isnull(_p15,0)+isnull(_p16,0))
							output inserted.id_horas_extras into @idt
							where id_periodo = @per and id_employee = @emp
							------------------
							set @res = 1
						end
					end
					------------------
					------------------
					if @cn = '_c12' begin			
						select @g = (isnull(_c12,0) + @hn) from  tra.horas_extras
						where id_periodo = @per and id_employee = @emp;
						if @g >= @val or @he_override = 1 begin
							------------------
							update tra.horas_extras set
								_p12 = @val
								,update_date = getdate()
								,_pagadas = (isnull(_p01,0)+isnull(_p02,0)+isnull(_p03,0)+isnull(_p04,0)+isnull(_p05,0)+isnull(_p06,0)+isnull(_p07,0)+isnull(_p08,0)+isnull(_p09,0)+isnull(_p10,0)+isnull(_p11,0)+isnull(@val,0)+isnull(_p13,0)+isnull(_p14,0)+isnull(_p15,0)+isnull(_p16,0))
							output inserted.id_horas_extras into @idt
							where id_periodo = @per and id_employee = @emp
							------------------
							set @res = 1
						end
					end
					------------------
					------------------
					if @cn = '_c13' begin			
						select @g = (isnull(_c13,0) + @hn) from  tra.horas_extras
						where id_periodo = @per and id_employee = @emp;
						if @g >= @val or @he_override = 1 begin
							------------------
							update tra.horas_extras set
								_p13 = @val
								,update_date = getdate()
								,_pagadas = (isnull(_p01,0)+isnull(_p02,0)+isnull(_p03,0)+isnull(_p04,0)+isnull(_p05,0)+isnull(_p06,0)+isnull(_p07,0)+isnull(_p08,0)+isnull(_p09,0)+isnull(_p10,0)+isnull(_p11,0)+isnull(_p12,0)+isnull(@val,0)+isnull(_p14,0)+isnull(_p15,0)+isnull(_p16,0))
							output inserted.id_horas_extras into @idt
							where id_periodo = @per and id_employee = @emp
							------------------
							set @res = 1
						end
					end
					------------------
					------------------
					if @cn = '_c14' begin			
						select @g = (isnull(_c14,0) + @hn) from  tra.horas_extras
						where id_periodo = @per and id_employee = @emp;
						if @g >= @val or @he_override = 1 begin
							------------------
							update tra.horas_extras set
								_p14 = @val
								,update_date = getdate()
								,_pagadas = (isnull(_p01,0)+isnull(_p02,0)+isnull(_p03,0)+isnull(_p04,0)+isnull(_p05,0)+isnull(_p06,0)+isnull(_p07,0)+isnull(_p08,0)+isnull(_p09,0)+isnull(_p10,0)+isnull(_p11,0)+isnull(_p12,0)+isnull(_p13,0)+isnull(@val,0)+isnull(_p15,0)+isnull(_p16,0))
							output inserted.id_horas_extras into @idt
							where id_periodo = @per and id_employee = @emp
							------------------
							set @res = 1
						end
					end
					------------------
					------------------
					if @cn = '_c15' begin			
						select @g = (isnull(_c15,0) + @hn) from  tra.horas_extras
						where id_periodo = @per and id_employee = @emp;
						if @g >= @val or @he_override = 1 begin
							------------------
							update tra.horas_extras set
								_p15 = @val
								,update_date = getdate()
								,_pagadas = (isnull(_p01,0)+isnull(_p02,0)+isnull(_p03,0)+isnull(_p04,0)+isnull(_p05,0)+isnull(_p06,0)+isnull(_p07,0)+isnull(_p08,0)+isnull(_p09,0)+isnull(_p10,0)+isnull(_p11,0)+isnull(_p12,0)+isnull(_p13,0)+isnull(_p14,0)+isnull(@val,0)+isnull(_p16,0))
							output inserted.id_horas_extras into @idt
							where id_periodo = @per and id_employee = @emp
							------------------
							set @res = 1
						end
					end
					------------------
					------------------
					if @cn = '_c16' begin			
						select @g = (isnull(_c16,0) + @hn) from  tra.horas_extras
						where id_periodo = @per and id_employee = @emp;
						if @g >= @val or @he_override = 1 begin
							------------------
							update tra.horas_extras set
								_p16 = @val
								,update_date = getdate()
								,_pagadas = (isnull(_p01,0)+isnull(_p02,0)+isnull(_p03,0)+isnull(_p04,0)+isnull(_p05,0)+isnull(_p06,0)+isnull(_p07,0)+isnull(_p08,0)+isnull(_p09,0)+isnull(_p10,0)+isnull(_p11,0)+isnull(_p12,0)+isnull(_p13,0)+isnull(_p14,0)+isnull(_p15,0)+isnull(@val,0))
							output inserted.id_horas_extras into @idt
							where id_periodo = @per and id_employee = @emp
							------------------
							set @res = 1
						end
					end
					------------------
					if @res = 1 begin
						declare @id char(36)
						select top 1 @id = _id from @idt 
						--- descativamos horas pagadas anteriormente
						--- se mantienen registros como log
						update tra.horas_extras_log set active = 0
						where id_employee = @emp and id_periodo = @per and _cn = @cn;

						--insertamos nuevo registro
						insert into tra.horas_extras_log (insert_operator_id, id_horas_extras, id_employee,id_periodo, _cn, _pagadas, id_fecha)
						values (@ope,@id,@emp,@per,@cn, @val, @fec);
						set @res = 1
						set @msg = 'Horas Insertadas'
					end else begin 
						set @res = 0
						set @msg = 'Horas insuficientes ...'
					end 
				end else begin 
					set @res = 0
					set @msg = 'Posicion no Autorizada...'
				end 
			end else begin 
				set @res = 0
				set @msg = 'Periodo Cerrado ...'
			end 

			select @pagadas = _pagadas from tra.horas_extras
			where id_employee = @emp and id_periodo = @per;
		commit transaction tran_insert_horas_extras


		
	end try
	begin catch
		print error_message()
		set @res = 0
		rollback transaction tran_insert_horas_extras
	end catch
	-----------------------------------

	if @res = 1 begin
		declare @alter int, @fechaviejo nvarchar(10);
	
		select 
			  @fechaviejo = convert(nvarchar(10), @fechaint )
			, @alter = _alter_id from cat.employees
		where employee_id = @emp;
		exec VA.AsistenciaSQL.ifc.sp_insert_hora @alter, @fechaviejo, @val
	end
	-----------------------------------
end
GO

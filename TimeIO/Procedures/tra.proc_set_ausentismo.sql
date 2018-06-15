SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [tra].[proc_set_ausentismo]
	 @per char(36)
	,@emp char(36)
	,@cn nvarchar(4)
	,@letra char(1)
	,@ope char(36)
	,@cau char(36) = null
	,@coment text = null
	,@fec date = null
	,@color nvarchar(64) = 'black' OUTPUT
	,@result bit = 0 OUTPUT
	,@msg nvarchar(128) OUTPUT
as begin
	SET NOCOUNT ON;
	begin try
		set transaction isolation level read committed
		begin transaction tran_set_ausentismo

			declare @fec_ini datetime, @per_act char(36), @cerrado bit
			exec cat.proc_get_fecha_ini_periodo_actual @fec_ini OUTPUT
			select @cerrado = _cerrado from cat.periodos
			where id_periodo = @per

			if (@cerrado = 0) begin	
				if (not exists(select id_ausentismo from cat.ausentismos where _reescribible = 0 and _letra = @letra)) begin
				
					----------------------------------------------------------------------------
					declare @query nvarchar(max);
					set @query = N'update l 
						set '+rtrim(@cn)+' = (case when len(rtrim(ltrim('+rtrim(@cn)+'))) > 1 then '''+rtrim(@letra)+''' + RIGHT(ltrim(rtrim('+rtrim(@cn)+')), 1) else '''+rtrim(@letra)+''' end )
					from tra.lista l 				
					where l.id_periodo = '''+rtrim(@per)+''' and l.id_employee = '''+rtrim(@emp) +'''
					and LEFT(ltrim(rtrim('+rtrim(@cn)+')), 1) not in (select _letra from cat.ausentismos where _reescribible = 0)';
					exec(@query);
					----------------------------------------------------------------------------
					if (@@rowcount = 1) begin
						update tra.ausentismos
							set active = 0 
								,update_operator_id = @ope
						where 
								id_periodo = @per 
							and employee_id = @emp 
							and _cN = replace(rtrim(@cn),'_','')
							and active = 1;
						----------------------------------------------------------------------------
						declare @fecha datetime, @id int, @fechaint int
						declare @idt table (_id int);
						select
							@fechaint = f.fecha_int
							,@fecha = f.fecha_nat						
						from adm.fechas f where id_periodo = @per and _cN = replace(@cn,'_','');
						----------------------------------------------------------------------------
						insert into tra.ausentismos ( insert_operator_id
													, id_ausentismo
													, _ausentismo_date
													, employee_id
													, _cN, id_periodo
													, _sync)
						output inserted.id_tra_ausentismo into @idt
						values(@ope, cat.func_get_id_ausentismo(@letra),@fecha, @emp, replace(@cn,'_',''), @per, 1);
						select top 1 @id = _id from  @idt;
						----------------------------------------------------------------------------
						if (@cau is not null) begin
							declare @continua bit = 1;
							if @fec is not null begin
								declare @isfestivo bit 
								select @isfestivo = isnull(_valida_festivo, 0) from cat.causa where id_causa = @cau;
								exec tra.proc_validar_fecha_tomada @emp, @fec, @isfestivo, @continua OUTPUT
							end
							if @continua = 1 begin
								insert into tra.ausentismo_causa (insert_operator_id,id_tra_ausentismo, id_causa, _comentarios, _fecha_pasada)
								values (@ope, @id, @cau, @coment, @fec);
							end else begin
								set @result = 0;
								set @msg = 'Fecha Invalida.';
								rollback transaction tran_set_ausentismo
								return;
							end;
						end;

						----------------------------------------------------------------------------
						exec cat.proc_get_color_from_letra @letra , @color OUTPUT

						
						set @msg = 'Ausentismo Capturado.';
						set @result = 1; 
					end else begin
						set @msg = 'Captura no permitida.';
						set @result = 0;
					end
				end else begin
					set @msg = 'No es posible sobreescribir el ausentismo.';
					set @result = 0;
				end
			end else begin
				set @msg = 'Periodo cerrado.';				
				set @result = 0;
			end
		commit transaction tran_set_ausentismo
		----------------------------------------------------------------------------
		--IFC Asistencia VariosDB
		----------------------------------------------------------------------------
		if @result = 1 begin 
			declare @alter int, @fechaviejo nvarchar(10);
			select
				   @fechaviejo = convert(nvarchar(10), @fechaint )
				,  @alter = _alter_id from cat.employees where employee_id = @emp;
			exec VA.AsistenciaSQL.ifc.sp_insert_letra @alter, @fechaviejo , @letra
		end
		----------------------------------------------------------------------------
	end try
	begin catch
		set @result = 0;
		set @msg = 'Error SQL'
		print 'Error:' + error_message()
		print 'Line:' + rtrim(error_line())
		rollback transaction tran_set_ausentismo
	end catch
end;

GO

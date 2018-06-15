SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [tra].[proc_calc_horas_nocturnas_by_cn]
	 @emp char(36)
	,@per char(36)
	,@cn nvarchar(3)	
as begin
	set nocount on;
	declare @cerrado bit
	select @cerrado = _cerrado from cat.periodos 
	where id_periodo = @per; 
	--------------------------------------------------------------------------------------------
	-- Revisamos si el periodo está cerrado
	--------------------------------------------------------------------------------------------
	if @cerrado = 0 begin
		declare @hn bit
				--,@min smallint

		--------------------------------------------------------------------------------------------
		-- Revisamos si tiene habilitado el cálculo de horas extras
		--------------------------------------------------------------------------------------------
		select
			@hn = _horas_nocturnas
			--,@min = _jornada
		from cat.posicion with(nolock)
		where posicion_id = (select posicion_id from cat.employees e
								where e.employee_id = @emp);
		--select @he, @min
		if @hn = 1 begin
			-- Si no se ha creado el tra.horas_extra del periodo
			if(not exists(select _c01 from tra.horas_nocturnas where id_employee = @emp and id_periodo = @per)) begin
				insert into tra.horas_nocturnas (id_employee, id_periodo) values (@emp, @per);
			end;

			declare  @val int 
					,@ent datetime
					,@fec_min  datetime
					,@fec_max  datetime

			select @val = (sum(_jornada) / 60.0)
				,@ent = min(_entrada)
				,@fec_min = convert(datetime , min(_fecha_ent)) + '21:00'
				,@fec_max = convert(datetime , min(_fecha_ent)) + '23:45'
			from tra.jornadas
			where employee_id = @emp and id_periodo = @per and _cN = @cn;



			if @val >= 8 and ( @ent between @fec_min and @fec_max) begin
                declare @idt table (_id char(36));
				declare @q nvarchar(1024)
				select @q = 'update tra.horas_nocturnas set
							_'+@cn+' = 1 	
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
				exec(@q);

                declare @id char(36), @fec char(36), @ope char(36)
                select top 1 @id = _id , @ope = 'AUTOMATIC-O000000000-000000000-00000' from @idt; 

                --Obtenemos el id de Fecha
			    select top 1 @fec = id_fecha
                from adm.fechas where id_periodo = @per and _cN = lower(rtrim(replace(@cn, '_', '')));
                --
                insert into tra.horas_nocturnas_log (insert_operator_id, id_horas_nocturnas, id_employee,id_periodo, _cn, _horas, id_fecha)
				values (@ope,@id,@emp,@per,@cn, 1, @fec);
			end else return;
		end else begin
			return
		end
	end else begin
		print 'Error: Periodo Cerrado'
		return
	end
end

GO

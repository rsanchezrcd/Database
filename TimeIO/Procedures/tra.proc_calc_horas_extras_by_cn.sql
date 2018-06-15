SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc tra.proc_calc_horas_extras_by_cn
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
		declare @he bit
				,@min smallint

		--------------------------------------------------------------------------------------------
		-- Revisamos si tiene habilitado el cálculo de horas extras
		--------------------------------------------------------------------------------------------
		select
			@he = _horas_extras 
			,@min = _jornada
		from cat.posicion with(nolock)
		where posicion_id = (select posicion_id from cat.employees e
								where e.employee_id = @emp);
		--select @he, @min
		if @he = 1 begin
			-- Si no se ha creado el tra.horas_extra del periodo
			if(not exists(select _c01 from tra.horas_extras where id_employee = @emp and id_periodo = @per)) begin
				insert into tra.horas_extras (id_employee, id_periodo) values (@emp, @per);
			end;

			declare @val int 
			select @val = (sum(_jornada) / 60) - @min from tra.jornadas
			where employee_id = @emp and id_periodo = @per and _cN = @cn;

			if @val > 0 begin
				declare @q nvarchar(1024)
				select @q = 'update tra.horas_extras set
							_'+@cn+' = ' + rtrim(@val) + ' 	
						where id_employee = '''+ @emp+''' and id_periodo = ''' + @per +'''';
				exec(@q)
				select @q = 'update tra.horas_extras set						 
							_horas = (_c01 + _c02 + _c03 + _c04 + _c05 +_c06 + _c07 + _c08 + _c09 + _c10 + _c11 + _c12 + _c13 + _c14 + _c15 +_c16 )	,
							update_date = getdate()					
						where id_employee = '''+ @emp+''' and id_periodo = ''' + @per +'''';
				exec(@q)
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

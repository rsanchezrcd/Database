SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Sanchez
-- Create date: 2017-03-31
-- Description:	Cruce de valores a tabla tra.lista desde tra.jornadas
-- =============================================
CREATE proc [tra].[proc_send_jornada_to_lista]
	@id_jornada char(36)
	,@recalc bit = 0
AS BEGIN
	
	SET NOCOUNT ON;

	declare
			@days tinyint,
			@query nvarchar(max),
			@fec_ini datetime,
			@cn nvarchar(3),
			@id_periodo char(36),
			@employee_id char(36),
			@entrada datetime,
			@salida datetime,
			@cerrado bit
	select 
		top 1
		@cn = _cN
		,@entrada = _entrada
		,@salida = _salida
		,@id_periodo = id_periodo
		,@employee_id = employee_id		
	from tra.jornadas where id_jornada = @id_jornada;

	---------------------------------------------------
	select @cerrado = _cerrado from cat.periodos 
	where id_periodo = @id_periodo;
	if (@cerrado = 1) return;
	---------------------------------------------------
	exec cat.proc_get_fecha_ini_periodo @id_periodo ,@fec_ini OUTPUT
	
	if @salida is not null and @entrada >= @fec_ini begin
		select @query = 'update tra.lista	
		 set _'+ @cn + ' = (case isnull(_'+ @cn + ' ,''nul'')
								when ''F'' then ''.''
								when ''/'' then ''.'' 
								when ''.'' then ''.''
								when ''nul'' then ''.'' 
								else LEFT(_'+ @cn + ', 1) + ''.'' end) 
		 where id_employee = '''+ @employee_id+''' and id_periodo = ''' + @id_periodo +''' ';
		--select @query = 'test'
		exec (@query);		
	end;

	if @salida is null and @entrada >= @fec_ini begin		
		
		select @query = 'update tra.lista	
		 set _'+ @cn + ' = (case isnull(_'+ @cn + ' ,''nul'')
								when ''.'' then ''/'' 
								when ''F'' then ''/'' 
								when ''nul'' then ''/'' 
								else LEFT(_'+ @cn + ', 1) + ''/'' end)								  			
		 where id_employee = '''+ @employee_id+''' and id_periodo = ''' + @id_periodo +''' ';		
		exec (@query);		
	end;
	------------------------------------------------------------------------------------------
	-- Recalcular asistencias de todo el periodo. (Cuidado: Cuando hay errores)
	------------------------------------------------------------------------------------------
	if @recalc = 1 begin
		--exec tra.proc_recalc_tra_lista @id_periodo, @employee_id
		return
	end

	------------------------------------------------------------------------------------------
	-- Calculamos los días trabajados.
	------------------------------------------------------------------------------------------
	exec tra.proc_calc_dias_trabajados  @id_periodo, @employee_id, @days OUTPUT
	select @query = 'update tra.lista	
		set _days = '+ convert(varchar,@days) +'
		where id_employee = '''+ @employee_id+''' and id_periodo = ''' + @id_periodo +''' ';	
	exec (@query);

	------------------------------------------------------------------------------------------
	-- Calculamos Horas Extras
	------------------------------------------------------------------------------------------	
	exec [tra].[proc_calc_horas_extras_by_cn] @employee_id, @id_periodo, @cn 
	exec [tra].[proc_calc_horas_nocturnas_by_cn] @employee_id, @id_periodo, @cn 
END

GO

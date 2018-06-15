SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ramon Sanchez
-- Create date: 2017-03-31
-- Description:	Cruce de valores a tabla tra.lista desde tra.jornadas
-- =============================================
CREATE TRIGGER [tra].[tr_send_jornada_to_lista]
   ON [tra].[jornadas]
   AFTER UPDATE
AS 
BEGIN
	
	SET NOCOUNT ON;

	declare @cn nvarchar(3),
			@id_periodo char(36),
			@employee_id char(36),
			@entrada datetime,
			@salida datetime,
			@days tinyint,
			@query nvarchar(max),
			@fec_ini datetime;

	select 
		top 1
		@cn = _cN
		,@entrada = _entrada
		,@salida = _salida
		,@id_periodo = id_periodo
		,@employee_id = employee_id
		
	from inserted;

	exec cat.proc_get_fecha_ini_periodo_actual @fec_ini OUTPUT

	if @salida is not null and @entrada >= @fec_ini begin		
		select @days = (_days + 1)  from tra.lista 
		where id_employee = @employee_id
		and id_periodo = @id_periodo;

		select @query = 'update tra.lista	
		 set _'+ @cn + ' = (case isnull(_'+ @cn + ' ,''nul'')
								when ''F'' then ''.''
								when ''/'' then ''.'' 
								when ''.'' then ''.''
								when ''nul'' then ''.'' 
								else LEFT(_'+ @cn + ', 1) + ''.'' end) 
			,_days = '+ convert(varchar,@days) +'
		 where id_employee = '''+ @employee_id+''' and id_periodo = ''' + @id_periodo +''' ';
		--select @query = 'test'
		exec (@query);
	end;

END
GO
DISABLE TRIGGER [tra].[tr_send_jornada_to_lista]
	ON [tra].[jornadas]
GO

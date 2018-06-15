SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [tra].[tr_send_slash_to_lista] 
   ON  [tra].[jornadas] 
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

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

END
GO
DISABLE TRIGGER [tra].[tr_send_slash_to_lista]
	ON [tra].[jornadas]
GO

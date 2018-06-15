SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE proc tra.proc_get_jornada_by_datos
	@emp char(36)
	,@per  char(36)
	,@cn  char(4)
	,@jor int OUTPUT
as begin
	set nocount on;
	SELECT  
		@jor = sum(_jornada) 
      
	FROM [TimeIO].[tra].[jornadas]
	where 
			_jornada is not null
		and employee_id = @emp
		and id_periodo = @per
		and _cN = replace(@cn,'_','');

	if @jor is null set @jor = 0;
end;

GO

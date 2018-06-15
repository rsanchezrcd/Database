SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [tra].[proc_get_jornadas_by_employee]
	 @per char(36)
	,@emp char(36)
as begin
	set nocount on;
	SET LANGUAGE Spanish
	select 		
		upper(convert(nvarchar(6),_entrada , 7)) + ' ' +  convert(nvarchar(5),_hora_ent) _entrada		
		,upper(convert(nvarchar(6),_salida , 7)) + ' ' +  convert(nvarchar(5),_hora_sal)  _salida		
		,_jornada
			
	from tra.jornadas j with(nolock)
	where
			j.employee_id = @emp
		and  j.id_periodo = @per
	order by j._entrada desc;
end;
GO

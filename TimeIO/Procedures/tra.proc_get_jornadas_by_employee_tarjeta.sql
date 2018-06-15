SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [tra].[proc_get_jornadas_by_employee_tarjeta]
	 @per char(36)
	,@emp char(36)
as begin
	set nocount on;
	SET LANGUAGE Spanish
	select 		
		convert(nvarchar(19),j._entrada,120) _entrada		
		,convert(nvarchar(19),j._salida,120)  _salida		
		,_jornada
			
	from tra.jornadas j with(nolock)
	where
			j.employee_id = @emp
		and  j.id_periodo = @per
	order by j._entrada desc;
end;
GO

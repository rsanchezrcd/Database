SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE proc tra.proc_get_checadas_by_employee
	 @per char(36)
	,@emp char(36)
as begin
	set nocount on;
	select 
		convert(nvarchar(19),_checada,120) _checada
		,case _tipo
			when 0 then 'E'
			when 1 then 'S'	end _tipo
		,_dispositivo_code	
	from tra.checadas with(nolock)
	where
			employee_id = @emp
		and cat.func_get_id_periodo(_checada_fecha) = @per
	order by _checada desc;
end;
GO

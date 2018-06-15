SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [tra].[proc_get_checadas_by_employee_tarjeta]
	 @per char(36)
	,@emp char(36)
as begin
	set nocount on;

	
	select a._checada, a._tipo, a._dispositivo_code from (
		select 
			convert(nvarchar(19),_entrada,120) _checada
			,'E' _tipo
			,_dispositivo_code_ent _dispositivo_code
		from tra.jornadas with (nolock)
		where
				employee_id = @emp
			and id_periodo = @per
		union all
		select 
			convert(nvarchar(19),_salida,120) _checada
			,'S' _tipo
			,_dispositivo_code_sal _dispositivo_code
		from tra.jornadas with (nolock)
		where
				employee_id = @emp
			and id_periodo = @per
			and _salida is not null) a
	order by a._checada desc;
end;
GO

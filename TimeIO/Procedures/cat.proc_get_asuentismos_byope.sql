SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [cat].[proc_get_asuentismos_byope]
	@ope char(36)

as begin 
	select 
		id_ausentismo
		,0 _assigned
		,_letra
		,_descripcion
	from cat.ausentismos
	where id_ausentismo not in (select 
									t.id_ausentismo									
								from cat.ausentismos_operator t
								inner join cat.ausentismos a on t.id_ausentismo = a.id_ausentismo
								where t.id_operator = @ope)
		and active = 1
	union all
	select 
		t.id_ausentismo
		, 1 [_assigned]
		,a._letra
		,a._descripcion		
	from cat.ausentismos_operator t
	inner join cat.ausentismos a on t.id_ausentismo = a.id_ausentismo
	where t.id_operator = @ope;
end
GO

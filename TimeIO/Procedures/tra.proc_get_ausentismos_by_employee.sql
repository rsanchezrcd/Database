SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [tra].[proc_get_ausentismos_by_employee]
	 @per char(36)
	,@emp char(36)
as begin
	set nocount on;

	select 
		a.id_tra_ausentismo
		,convert(nvarchar(10),a._ausentismo_date,121) _ausentismo_date
		,t._letra _letra
		,upper(t._descripcion) _ausentismo_desc
		,cat.func_get_operator(a.insert_operator_id) _operator
		,rtrim(isnull(u._causa,'undefined')) _causa
		,isnull(c._comentarios, 'undefined') _comentarios
		,convert(nvarchar(19),a.insert_date,120) _insert_date
	from tra.ausentismos a with(nolock)
	left join tra.ausentismo_causa c  with(nolock) on c.id_tra_ausentismo = a.id_tra_ausentismo
	inner join cat.ausentismos t with(nolock) on a.id_ausentismo = t.id_ausentismo
	left join cat.causa u  with(nolock) on u.id_causa = c.id_causa
	where
			a.id_tra_ausentismo is not null
		and a.employee_id = @emp
		and a.id_periodo = @per and a.active = 1 
	order by a._ausentismo_date desc;
end;


GO

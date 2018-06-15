SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [tra].[proc_get_ausentismos_by_employee_expand]
	 @per char(36)
	,@emp char(36)
as begin
	set nocount on;

	select 
		a.id_tra_ausentismo IDTraAusentismo
		,cat.func_get_employee_alter(@emp) Codigo
		,convert(nvarchar(10),a._ausentismo_date,120) FechaAusentismo
		,t._letra Letra 
		,upper(t._descripcion) DescripcionAusentismo
		,upper(cat.func_get_operator(a.insert_operator_id)) UsuarioCaptura
		,rtrim(isnull(u._causa,'-')) Causa
		,case when isnull(_viejo,0) = 0 then isnull(c._comentarios, '-') else _comentarios_viejo end Comentarios
		,convert(nvarchar(19),a.insert_date,120) FechaCaptura
		,convert(nvarchar(10),c._fecha_pasada,120) FechaTomada
	from tra.ausentismos a with(nolock)
	left join tra.ausentismo_causa c  with(nolock) on c.id_tra_ausentismo = a.id_tra_ausentismo
	inner join cat.ausentismos t with(nolock) on a.id_ausentismo = t.id_ausentismo
	left join cat.causa u  with(nolock) on u.id_causa = c.id_causa
	where
			a.id_tra_ausentismo is not null
		and a.employee_id = @emp
		and a.id_periodo = @per and a.active = 1 
	order by a._ausentismo_date asc;
end;


GO

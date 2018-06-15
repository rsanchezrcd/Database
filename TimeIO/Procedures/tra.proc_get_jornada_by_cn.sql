SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

 CREATE proc [tra].[proc_get_jornada_by_cn]
	@cn char(4)
	,@emp char(36)
	,@per char(36)
	,@fec date OUTPUT
	,@ent nvarchar(8) OUTPUT
	,@sal nvarchar(8)  OUTPUT
	,@jor int OUTPUT
	,@aus nvarchar(64) = null OUTPUT
as begin
	set nocount on;

	set @cn = replace(@cn, '_','');
	select top 1
		 @fec = _fecha_ent
		,@ent = convert(nvarchar(8),_hora_ent)
		,@sal = isnull(convert(nvarchar(8),_hora_sal), '-')
		,@jor = isnull(_jornada, 0)
	from tra.jornadas with(nolock)
	where 
			employee_id = @emp 
		and _cn = @cn
		and id_periodo = @per
	order by insert_date desc;

	if @jor = 0 or @jor is null begin
		select top 1 @aus = '('+c._letra + ') '+ c._descripcion
		from tra.ausentismos a with(nolock) 
		inner join cat.ausentismos c with(nolock) on c.id_ausentismo = a.id_ausentismo
		where a.employee_id = @emp 
		and a._cn = @cn
		and a.id_periodo = @per
		and a.active = 1
		order by a.insert_date desc;
	end;
end

GO

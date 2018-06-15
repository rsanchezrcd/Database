SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE proc ifc.proc_sync_sistema_viejo
	@per int
	,@ano int
	,@locaciones nvarchar(max)
	,@exclude nvarchar(max)
as begin
	set nocount on 

	declare @alters table (_alter int )
	declare @ausentismos table (id char(36), _letra char(1), _fecha int, _alter int , _sync bit ) 
	
	insert into @alters
	exec  ifc.proc_get_diferencias_alter
		@per 
		,@ano 
		,@locaciones
		,@exclude


	insert into @ausentismos (id, _letra, _fecha,_alter, _sync) 
	select 
		 newid()
		,cat.func_get_letra(a.id_ausentismo) _letra
		,convert(int,convert(nvarchar(8),a._ausentismo_date, 112)) _fecha
		,e._alter_id _alter
		,0
	from tra.ausentismos a with(nolock)
	inner join cat.operator o with(nolock) on a.insert_operator_id = o.operator_id 
	inner join cat.employees e with(nolock) on a.employee_id = e.employee_id
	where cat.func_get_periodo(id_periodo) = '1807'
	and e._alter_id in (select _alter from @alters)

	declare @c int 
	select @c = count(*) from @ausentismos
	print 'Count: ' + rtrim(@c);

	declare @id char(36), @alter int, @fechaint int , @letra char(1)
	while(exists(select top 1 _sync from @ausentismos where _sync = 0 )) begin
		select top 1  
			@id = id
			, @alter = _alter
			, @fechaint = _fecha
			, @letra = _letra 
		from @ausentismos where _sync = 0;

		exec VA.AsistenciaSQL.ifc.sp_insert_letra @alter, @fechaint, @letra

		update @ausentismos
			set _sync = 1
		where id = @id;
	end
end

GO

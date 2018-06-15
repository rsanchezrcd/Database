SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE proc tra.proc_get_title_dia
	 @per char(36)
	,@emp char(36)
	,@cn char(4)
	,@title nvarchar(128) OUTPUT
as begin
	
	set nocount on;
	SET LANGUAGE Spanish;

	declare @t table (_letra char(3))
	declare @descr nvarchar(128)
			,@jornada nvarchar(128)
			,@letra char(1)
	
	insert into @t
	exec('select '+@cn+' from tra.lista with(nolock) 
			where id_employee = '''+@emp + ''' and id_periodo = ''' + @per+ '''')
	select @letra = left(_letra,1) from @t
	--select @letra

	select @descr = '[ ' +_letra +' ] '+ _descripcion from cat.ausentismos
	where _letra = @letra
	--select @descr 
	select
		@jornada = 'E: ' + upper(convert(nvarchar(6),_entrada , 7)) + ' ' +  convert(nvarchar(5),_hora_ent) + ' | S: ' + isnull(upper(convert(nvarchar(6),_salida , 7)),'') + ' ' +  isnull(convert(nvarchar(5),_hora_sal),'') + ' | J: ' + isnull(convert(char(5), dateadd(MINUTE, _jornada, ''), 114),'')
	from tra.jornadas
	where _cn = replace(@cn, '_', '') and id_periodo = @per and employee_id = @emp
	--select @jornada
	if @jornada is not null 
		set @title = rtrim(@descr) + ' | ' + rtrim(@jornada)
	else 
		set @title = rtrim(@descr) 
end

GO

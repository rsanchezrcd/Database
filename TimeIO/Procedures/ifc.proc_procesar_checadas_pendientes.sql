SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [ifc].[proc_procesar_checadas_pendientes] 
	@c int = 250
as begin
	
	set nocount on
	declare @isrunning  bit
	select @isrunning = _running from ifc.interface
	where _interface_name ='handpunch'

	if @isrunning = 0 begin
		update ifc.interface set _running = 1
		where _interface_name ='handpunch'	

		---------------------------------------------------------
		--Declaracion de Variables
		---------------------------------------------------------
		declare @ids table (id_source char(36), _checada datetime, sync bit );
		declare @fecha_min datetime, @ini datetime, @fin datetime 
				,@x int, @y int = 0;
		---------------------------------------------------------
		--Obtener fecha inicial
		set @ini = getdate();
		---------------------------------------------------------
		exec cat.proc_get_fecha_ini_periodo_actual @fecha_min OUTPUT
		---------------------------------------------------------
		--Registros pendientes
		---------------------------------------------------------
		select @x = count(*)
		from ifc.vw_ids_pendientes with(nolock)
		where _checada >= @fecha_min;
		---------------------------------------------------------
		--Inserto en tabla temporal
		---------------------------------------------------------
		insert into @ids
		select 	id_source
			, _checada 
			, 0 sync
		from ifc.vw_ids_pendientes with(nolock)
		where _checada >= @fecha_min
		order by _checada asc
		offset 0 rows
		fetch next @c rows only;
		---------------------------------------------------------
		--print '--------------------------------';
		--print 'Pendientes por Procesar: ' + convert(varchar, @x)
		--print '--------------------------------';
		---------------------------------------------------------
		--Mientras existan registros en la tabla 
		--temporal con sync = 0
		---------------------------------------------------------
		while (exists(select top 1 id_source from @ids where sync = 0 order by _checada asc))begin	
			declare @id char(36)
			select top 1 @id = id_source from @ids where sync = 0 order by _checada asc
				
			exec [ifc].[proc_inserta_checada_validada] @id, 0

			update @ids	
				set sync = 1
			where id_source = @id

			set @y = @y + 1; 
			--print '--------------------------------';
		end;
		---------------------------------------------------------
		-- insert en log
		---------------------------------------------------------
		set @fin = getdate();
	
		update ifc.interface set _running = 0 
		where _interface_name ='handpunch'	
	
		/*insert into ifc.log (_pendientes ,_procesados, _solicitados, _status, _msg, _time)
		values (@x, @y, @c, 1, 'Procesado Correctamente',convert(nvarchar(8), @fin - @ini , 108) );*/


	end else begin
		print 'IFC is running...'
		return;
	end;	
	
end
GO

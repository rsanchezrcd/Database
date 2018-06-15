SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



CREATE proc [tra].[proc_send_checada_to_jornadas] 
	@id_checada char(36),
	@dispositivo_code varchar(64), 
	@employee_id char(36),
	@checada datetime, 	
	@tipo bit, 
	@sync bit,
	@id_jornada char(36) OUTPUT
	
as begin
	set nocount on;
	declare @cN nvarchar(3),
			@id_periodo char(36),
			@date nvarchar(8)							
	declare @idt table (_id char(36));

	if @tipo = 0 begin	
					
		select 
			@cN = f._cN
			, @date = convert(nvarchar(8),f.fecha_nat,112)
		from adm.fechas f
		where f.fecha_nat = convert(nvarchar(8), @checada, 112);
					
			
		-------------------------------------
		-- declare @id_periodo char(36), @date nvarchar(8) = '20171026'
		exec cat.proc_get_periodo_bydate @date, @id_periodo OUTPUT;
		--select * from cat.periodos where id_periodo = @id_periodo
		--print 'cn: '+@cN + ', per: ' + @id_periodo;
		-------------------------------------				
		insert into tra.jornadas (employee_id
									,id_checada_entrada
									,_entrada
									,_fecha_ent
									,_hora_ent 
									,_dispositivo_code_ent
									,_cN
									,id_periodo)
		output inserted.id_jornada into @idt
		values (@employee_id
				,@id_checada
				,@checada
				,@checada
				,@checada
				,@dispositivo_code
				,@cN
				,@id_periodo);	
					
		------------------------------------------------------
		update tra.checadas							
			set _sync = 1
		where id_checada = @id_checada;
		------------------------------------------------------
			

	end	else begin
			
		declare @entrada datetime							
				
				
		select top 1 
			@id_jornada = id_jornada
			,@entrada = _entrada						
		from  tra.jornadas
		where
			employee_id = @employee_id
			and _salida is null
			order by _entrada desc
		--------------------------------------------
		update  tra.jornadas set						
			_jornada = DATEDIFF(minute, @entrada, @checada) 
			,id_checada_salida = @id_checada
			,_salida = @checada
			,_dispositivo_code_sal = @dispositivo_code
			,_fecha_sal = @checada							
			,_hora_sal = @checada
		output inserted.id_jornada into @idt
		where id_jornada = @id_jornada; 			
					
		--------------------------------------------

		update tra.checadas							
			set _sync = 1
		where id_checada = @id_checada;				
		
	end

	select @id_jornada = _id from @idt;
	
end
GO

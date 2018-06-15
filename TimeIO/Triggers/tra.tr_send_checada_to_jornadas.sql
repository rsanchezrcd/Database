SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



CREATE trigger [tra].[tr_send_checada_to_jornadas] on [tra].[checadas]
after insert AS
begin
	set nocount on;
	declare @id_checada char(36),
			@dispositivo_code varchar(64), 
			@employee_id char(36),
			@checada datetime, 
			@checada_fecha date, 
			@checada_hora time,
			@tipo bit, 
			@sync bit,
			@cN nvarchar(3),
			@id_periodo char(36),
			@date nvarchar(8);
						
	select 
		@id_checada = id_checada 
		,@dispositivo_code = _dispositivo_code
		,@employee_id = employee_id
		,@checada = _checada
		,@checada_fecha = _checada_fecha
		,@checada_hora = _checada_hora
		,@tipo = _tipo
		,@sync = _sync
	from inserted;

	if @tipo = 0 
		begin			
					
			select 
				@cN = _cN 
				, @date = convert(nvarchar(8), @checada, 112)
			from adm.fechas
			where fecha_nat = @checada_fecha;
					
			
			-------------------------------------
			exec cat.proc_get_periodo_bydate 
					@date	
				, @id_periodo OUTPUT;
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
			values (@employee_id
					,@id_checada
					,@checada
					,@checada_fecha
					,@checada_hora
					,@dispositivo_code
					,@cN
					,@id_periodo);	
					
			------------------------------------------------------
			update tra.checadas							
				set _sync = 1
			where id_checada = @id_checada;
			------------------------------------------------------
			

		end
	else
		begin
			
			declare @entrada datetime, 							
					@id_jornada char(36);
				
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
				,_fecha_sal = @checada_fecha							
				,_hora_sal = @checada_hora 
			where id_jornada = @id_jornada; 			
					
			--------------------------------------------

			update tra.checadas							
				set _sync = 1
			where id_checada = @id_checada;
				
		
		end
	
end
GO
DISABLE TRIGGER [tra].[tr_send_checada_to_jornadas]
	ON [tra].[checadas]
GO

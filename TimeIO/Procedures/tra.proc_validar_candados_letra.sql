SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [tra].[proc_validar_candados_letra]
	 @letra_anterior char(1)
	,@per char(36)
	,@emp char(36)
	,@cn nvarchar(4)
	,@letra char(1)
	,@ope char(36)
	,@aus char(36) = null OUTPUT
	,@result bit = 0 OUTPUT
	,@msg nvarchar(128) OUTPUT
as begin
	SET NOCOUNT ON;
	begin try
		set transaction isolation level read committed
		begin transaction tran_validar_candados_letra

			declare @cerrado bit
					,@futuro bit
					,@permitido bit
					,@existe bit
					,@rescribible bit
					,@ant char(36)
					,@atras int
					,@max int
					,@fec date
					,@rol char(36)
					,@rol_max bit
					,@rol_atras bit
					,@count int
					,@clase nvarchar(6)
					,@req_jor bit

			select @cerrado = _cerrado from cat.periodos
			where id_periodo = @per
			if @cerrado = 1 begin
				set @aus = null
				set @result = 0
				set @msg = 'Periodo Cerrado ...'
				commit transaction tran_validar_candados_letra
				return;
			end 

			select @clase = _clase from cat.employees where employee_id = @emp;
			if (exists(select id 
						from cat.not_ausentismo_clase 
						where rtrim(_clase) = rtrim(@clase) and id_ausentismo = cat.func_get_id_ausentismo(@letra) and active = 1)) begin
				set @result = 0;
				set @msg = 'Clase Empleado invalida [Clase: '+rtrim(@clase)+']';
				commit transaction tran_validar_candados_letra
				return;
			end
			
			select 
				 @rescribible = _reescribible
				 
			from cat.ausentismos
			where _letra = @letra_anterior;
			if @rescribible = 0  begin
				set @result = 0
				set @msg = 'No es posible sobre-escribir ...';
				commit transaction tran_validar_candados_letra
				return;
			end 

			select @fec = fecha_nat from adm.fechas 
			where id_periodo = @per and _cn = replace(@cn, '_', '');
			-----------------------
			select 
				 @aus = id_ausentismo 
				,@futuro  = _futuro
				,@permitido = _permitido
				,@atras = _dias_atras
				,@max = _max_periodo
				,@req_jor = isnull(_requiere_jornada,0)
			from cat.ausentismos
			where _letra = @letra;

			--declare @atras_emp int, @max_emp int 
			select 
				@atras = isnull(_dias_atras, @atras)
				,@max = isnull(_max_periodo, @max)
			from cat.ausentismo_employee 
			where id_employee = @emp and id_ausentismo = cat.func_get_id_ausentismo(@letra)
			------------------------
			if (not exists(select id_ausentismo from cat.ausentismos where active = 1 and id_ausentismo = @aus)) begin
				set @result = 0
				set @msg = 'Ausentismo inexistente ...';
				commit transaction tran_validar_candados_letra
				return;
			end;

			if (not exists(select id_ausentismo from cat.ausentismos_operator where id_operator = @ope and id_ausentismo = @aus) or @permitido = 0) begin
				set @result = 0
				set @msg = 'Sin permisos sobre el ausentismo ...';
				commit transaction tran_validar_candados_letra
				return;
			end;


			select @rol = id_role from cat.operator 
			where operator_id = @ope

			select 
				@rol_max = _aus_max_periodo_override
				,@rol_atras = _aus_dias_atras_override
			from cat.roles 
			where id_role = @rol;


			if @futuro = 0 and  @fec >= convert(date,getdate()) begin
				set @result = 0
				set @msg = 'No Permitido Calificar a futuro ...';
				commit transaction tran_validar_candados_letra
				return;
			end 
			if @fec < dateadd(day, -@atras, convert(date,getdate())) and @rol_atras = 0 begin
				set @result = 0
				set @msg = 'Límite de días hacia atras alcanzado ...';
				commit transaction tran_validar_candados_letra
				return;
			end 

			select @count = count(*) from tra.ausentismos a
			inner join cat.operator o on a.insert_operator_id = o.operator_id
			where a.id_ausentismo = @aus and a.employee_id = @emp and a.id_periodo = @per and a.active = 1;
			if @count >= @max and @rol_max = 0 begin
				set @result = 0
				set @msg = 'Límite de capturas alcanzado ...';
				commit transaction tran_validar_candados_letra
				return;
			end 

			if @req_jor = 1 begin
				declare @jor int 
				exec tra.proc_get_jornada_by_datos @emp, @per, @cn , @jor OUTPUT
				if @jor < 420 begin -- jornada de 7 horas
					set @result = 0
					set @msg = 'Jornada Insuficiente ...';
					commit transaction tran_validar_candados_letra
					return;
				end		
			end;
			
		set @result = 1;
		set @msg = 'Permiso concedido ...';
		commit transaction tran_validar_candados_letra
	end try
	begin catch
		set @result = 0;
		print 'Error:' + error_message()
		print 'Line:' + rtrim(error_line())
		rollback transaction tran_validar_candados_letra
	end catch
end;


GO

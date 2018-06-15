SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO


create procedure [tra].[proc_validar_dias_atras]
	@emp char(36)
	,@per char(36)
	,@ope char(36)
	,@cn char(4)
	,@letra char(1)
	,@res bit = 0 OUTPUT
as begin 
	
	set nocount on;
	begin try
		set transaction isolation level read committed
		begin transaction tran_validar_dias_atras
			
			declare @atras int, @rol char(36) , @rol_atras bit, @fec date
			--------------------------------------------------------------------
			-- obtenemos dias atras del ausentismo
			--------------------------------------------------------------------
			select 
				@atras = _dias_atras	
			from cat.ausentismos
			where _letra = @letra;
			--------------------------------------------------------------------
			-- obtenemos el role del operator
			--------------------------------------------------------------------
			select @rol = id_role from cat.operator 
			where operator_id = @ope
			--------------------------------------------------------------------
			-- obtenemos si es override en el role
			--------------------------------------------------------------------
			select 
				@rol_atras = _aus_dias_atras_override
			from cat.roles 
			where id_role = @rol;
			--------------------------------------------------------------------
			-- obtenemos fecha del cn
			--------------------------------------------------------------------
			select @fec = fecha_nat from adm.fechas 
			where id_periodo = @per and _cn = replace(@cn, '_', '');

			--------------------------------------------------------------------
			if @fec < dateadd(day, -@atras, convert(date,getdate())) and @rol_atras = 0 begin
				set @res = 0
			end else begin
				set @res = 1
			end;
		commit transaction tran_validar_dias_atras
	end try
	begin catch
		set @res = 0
		print error_message()
		rollback transaction tran_validar_dias_atras
	end catch
end;
GO

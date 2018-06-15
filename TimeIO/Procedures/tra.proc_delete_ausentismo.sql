SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [tra].[proc_delete_ausentismo]
	 @emp char(36)
	,@per char(36)
	,@cn nvarchar(4)
	,@ope char(36)
	,@ant nvarchar(3) = 'F' OUTPUT
	,@color nvarchar(54) = 'black' OUTPUT
	,@msg nvarchar(512) OUTPUT
	,@result bit = 0 OUTPUT
	,@verbose bit = 0
as begin
	SET NOCOUNT ON;

	begin try
		set transaction isolation level read committed
		begin transaction tran_delete_ausentismo
			declare @cerrado bit

			select @cerrado = _cerrado 
			from cat.periodos 
			where id_periodo = @per

			if @cerrado = 0 begin
				declare @aus char(36)			
				declare @letra char(1)
				declare @id_tra_aus int
			

				select @aus = a.[id_ausentismo]
					  ,@id_tra_aus = A.id_tra_ausentismo
				from tra.ausentismos a
				inner join cat.ausentismos c on (c.id_ausentismo = a.id_ausentismo)
				where 
						a.active = 1
					and a._cn = replace(@cn, '_', '') 
					and a.employee_id = @emp
					and a.id_periodo = @per
					and c._reescribible = 1;

				if(@aus is null) begin				
					exec tra.proc_get_cn_val @cn, @emp , @per , @letra OUTPUT 						
					select @aus = _id
					from (select cat.func_get_id_ausentismo(LEFT(rtrim(ltrim(@letra)),1)) _id) s
					inner join cat.ausentismos c on (s._id = c.id_ausentismo)
					where c._reescribible = 1;
				end; 
			
				if(@aus is not null) begin
					if(@id_tra_aus is not null) begin
						update tra.ausentismos
							set active = 0
								,update_operator_id = @ope
								,update_date = getdate()
						where id_tra_ausentismo = @id_tra_aus;
					end;
					declare @s datetime, @e datetime
					select top 1 
						@e = _entrada, @s = _salida 
					from tra.jornadas
					where employee_id = @emp and id_periodo = @per and _cN = replace(@cn, '_', '')
					order by _entrada desc;
				
					select @letra = LEFT(cat.func_get_letra(@aus),1)		 
				
					if @verbose = 1 print 'id_ausentismo: ' + rtrim(@aus)
					if @verbose = 1 print 'Letra: ' + isnull(rtrim(@letra),'0')
					exec cat.proc_get_permiso_by_letra @letra, @ope, @result OUTPUT
					if @verbose = 1 print 'Resultado permiso letra: ' + rtrim(@result)
					if (@result = 1) begin
						if (@e is null) begin
							set @ant = 'F';					
						end
						if (@e is not null and @s is null) begin
							set @ant = '/';					
						end
						if (@e is not null and @s is not null) begin
							set @ant = '.';					
						end

						exec tra.proc_set_cn_val @cn, @emp , @per , @ant
						exec [cat].[proc_get_color_from_letra] @ant , @color OUTPUT
						set @result = 1;
						set @msg = 'Ausentismo eliminado.'
					end else begin
						set @result = 0;
						set @msg = 'Operador sin permisos sobre el ausentismo.'
					end;
				end else begin
					set @result = 0;
					set @msg = 'No es posible eliminar el Ausentismo.'
				end;
			end else begin
				set @result = 0;
				set @msg = 'Periodo cerrado.'
			end;	
						
		commit transaction tran_delete_ausentismo
		----------------------------------------------------------------------------
		--IFC Asistencia VariosDB
		----------------------------------------------------------------------------
		if @result = 1 or @ant = '.' begin 
			declare @alter int, @fechaint nvarchar(10);
			select
				@fechaint = convert(nvarchar(10),f.fecha_int)								
			from adm.fechas f where id_periodo = @per and _cN = replace(@cn,'_','');
			declare @escribe char(1)
			if @ant = '/' set @escribe = 'F' else set @escribe = @ant;

			select @alter = _alter_id from cat.employees where employee_id = @emp;
			exec VA.AsistenciaSQL.ifc.sp_insert_letra @alter, @fechaint, @escribe
		end
		----------------------------------------------------------------------------
	end try
	begin catch
		set @result = 0;
		print 'Error:' + error_message()
		print 'Line:' + rtrim(error_line())
		rollback transaction tran_delete_ausentismo
	end catch
end;

GO

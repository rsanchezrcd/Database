SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO



CREATE procedure [tra].[proc_get_lista_by_emp_by_per]
	@emp int, @per char(36), @ope char(36)
as begin
	set nocount on;
	declare  @acc bit
			,@vig bit
			,@fec_ini date
			,@emp_char char(36)

	exec cat.proc_get_fecha_ini_periodo @per, @fec_ini OUTPUT
	select @acc = cat.func_dep_available_by_ope(departamento_id, @ope)
		 , @vig = cat.func_isactive_bydt(@fec_ini, employee_id) 
		 , @emp_char = employee_id
	from cat.employees where _alter_id = @emp;
	--select @acc, @vig
	if (@acc = 1 and @vig = 1) begin
		select 
			[id_lista]
		  ,[id_employee]
		  ,[_alter_id]
		  ,[_nombres]
		  ,[_apellido_paterno]
		  ,[_apellido_materno]
		  ,[id_periodo]
		  ,[_per]
		  ,[locacion_id]
		  ,[_locacion_code]
		  ,[_locacion_name]
		  ,[id_departamento]
		  ,[_departamento_code]
		  ,[_departamento_name]
		  ,[posicion_id]
		  ,[_posicion_code]
		  ,[_posicion_name]
		  ,[_days]
		  ,[_c01]
		  ,[_c02]
		  ,[_c03]
		  ,[_c04]
		  ,[_c05]
		  ,[_c06]
		  ,[_c07]
		  ,[_c08]
		  ,[_c09]
		  ,[_c10]
		  ,[_c11]
		  ,[_c12]
		  ,[_c13]
		  ,[_c14]
		  ,[_c15]
		  ,case when [_c16] is null then 'F' else [_c16] end [_c16]
		  ,[_year]
		  ,[_excluido]
		  ,[_cerrado] 
		from tra.vw_lista_joins with(nolock)
		where 
				id_periodo = @per
			and id_employee = @emp_char
		order by 
			 _alter_id asc 
		
	end else begin
		print 'Lista no disponible...'
	end;
	
	
end

GO

SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
  create proc [tra].[proc_get_horas_by_emp_by_per]	
	 @emp int, @per char(36), @ope char(36)
  as begin
	set nocount on
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
			[id_horas_extras]
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
		  ,_horas
		  ,isnull(_pagadas,0)_pagadas
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
		  ,isnull([_c16],0) [_c16]
		  ,isnull([_p01],0) [_p01]
		  ,isnull([_p02],0) [_p02]
		  ,isnull([_p03],0) _p03
		  ,isnull([_p04],0) _p04
		  ,isnull([_p05],0) _p05
		  ,isnull([_p06],0) _p06
		  ,isnull([_p07],0) _p07
		  ,isnull([_p08],0) _p08
		  ,isnull([_p09],0) _p09
		  ,isnull([_p10],0) _p10
		  ,isnull([_p11],0) _p11
		  ,isnull([_p12],0) _p12
		  ,isnull([_p13],0) _p13
		  ,isnull([_p14],0) _p14
		  ,isnull([_p15],0) _p15
		  ,isnull([_p16],0) _p16
		  
		from tra.vw_horas_joins with(nolock)
		where 
				id_periodo = @per
			and id_employee = @emp_char
		order by 
			 
			_alter_id asc --ya viene en int desde la vista
		
		
	end;
  end;
GO

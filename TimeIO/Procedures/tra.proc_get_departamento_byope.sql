SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		rsanchez
-- Create date: 20170915
-- Description:	Obtengo departamento inicial
-- =============================================
CREATE PROCEDURE tra.proc_get_departamento_byope
	-- Add the parameters for the stored procedure here
	@ope char(36)
	,@dep char(36) OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;

	select @dep = id_departamento 
	from cat.departamento_operator
	where id_operator = @ope and _favorite = 1;
	------------------------------------------------------------
	--Cuando no tiene Favorito asignamos el depto al que pertenece
	------------------------------------------------------------
	if @dep is null begin
		declare @emp char(36);
		select @emp = employee_id from cat.operator with(nolock) where operator_id = @ope;
		select @dep = departamento_id from cat.employees with(nolock) where employee_id = @emp;
	end;
END
GO

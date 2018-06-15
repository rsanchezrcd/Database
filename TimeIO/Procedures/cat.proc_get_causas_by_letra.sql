SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [cat].[proc_get_causas_by_letra]
	@letra char(1) 
	,@ope char(36) = null
as begin
	SET NOCOUNT ON;
	declare @rol char(36)
	select top 1 @rol = id_role from cat.operator where operator_id = @ope;

	if @letra is not null begin
		select  
			id_causa
			,_causa
			,_comentarios
			,_requiere_fecha
			,_min_fecha
			,convert(nvarchar(10),getdate(),121) _max_fecha
		from cat.causa with(nolock)
		where id_ausentismo = cat.func_get_id_ausentismo(@letra) 
			and (id_role is null or id_role = @rol)
			and activo = 1
		order by _causa asc;
	end;
end;
GO

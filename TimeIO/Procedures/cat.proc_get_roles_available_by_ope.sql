SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc cat.proc_get_roles_available_by_ope
	@ope char(36)
as begin
	set nocount on;
	declare @level smallint
			,@rol char(36);

	select @rol = o.id_role from cat.operator o where o.operator_id = @ope;
	select @level = r._order from cat.roles r where id_role = @rol


	select r.id_role, r._role_name from cat.roles r
	where r._order >= @level and r.active = 1
	order by r._order asc;


end


GO

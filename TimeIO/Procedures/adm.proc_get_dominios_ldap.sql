SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE proc adm.proc_get_dominios_ldap
	
as begin
	set nocount on;
	
	select d.id_dominio, d._host 
	from adm.dominios d with (nolock) 
	where d.active = 1
	order by d.id_dominio asc;
end;

GO

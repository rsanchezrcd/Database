SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
  create proc cat.proc_get_dominios_correo
  as begin
	set nocount on;
	SELECT 
		 [id_email]     
		,[_domain]
	FROM [cat].[email]
	where active = 1;
  end
GO

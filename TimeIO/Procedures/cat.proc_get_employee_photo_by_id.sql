SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [cat].[proc_get_employee_photo_by_id]
	@id char(36)
as begin
	set nocount on;	
	
	select [_employee_photo]
	from cat.employee_photo with (nolock)
	where id_employee = @id and activo= 1;
	
end;

GO

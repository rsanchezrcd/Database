SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER cat.tr_update_employee_photo
   ON  [cat].[employees]
   AFTER INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @id int;
	select @id = convert(int,_alter_id) from inserted;

	update m
		set m._employee_photo = p.employee_photo
	from TimeIO.cat.employees m
	inner join [PS].HRSYS.dbo.PS_EMPL_PHOTO p on (m._alter_id = convert(int, p.emplid))
	where p.emplid = @id
    -- Insert statements for trigger here

END
GO
DISABLE TRIGGER [cat].[tr_update_employee_photo]
	ON [cat].[employees]
GO

CREATE ROLE [db_execute] AUTHORIZATION [dbo]
GO

ALTER ROLE [db_execute] ADD MEMBER [AICOLLECTION\dbexecute]

GO
ALTER ROLE [db_execute] ADD MEMBER [AICOLLECTION\soporteprov]

GO
ALTER ROLE [db_execute] ADD MEMBER [AICOLLECTION\SRRMMORPH01$]

GO
ALTER ROLE [db_execute] ADD MEMBER [link_user]

GO
ALTER ROLE [db_execute] ADD MEMBER [soporteprov]

GO

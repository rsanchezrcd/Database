SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

/****** Script for SelectTopNRows command from SSMS  ******/
CREATE view [tra].[vw_checadas] as 
SELECT [id_checada]
      ,c.[insert_date]
      ,e._alter_id
      ,c.[employee_id]
      ,[_checada]
      ,[_checada_fecha]
      ,[_checada_hora]
      ,[_dispositivo_code]
      ,[_tipo]
      ,[_sync]
  FROM [TimeIO].[tra].[checadas] c with (nolock)
  inner join cat.employees e with (nolock) on c.employee_id = e.employee_id
GO

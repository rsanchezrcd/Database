SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE view cat.vw_operator as 
select e._alter_id [employee_id]
		,o.[_username]
      ,o.[_password]
      ,o.[_salt]
      ,o.[_ad_user]
      ,o.[_domain]
      ,o.[_name]
      ,o.[_lastname]
      ,o.[_email]
      ,o.[_is_admin]
      ,o.[active]
      ,o.[insert_operator_id]
      ,o.[update_operator_id]
      ,o.[insert_date]
      ,o.[update_date]
from cat.operator o
inner join cat.employees e on o.employee_id = e.employee_id


GO

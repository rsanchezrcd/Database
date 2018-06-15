SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create view adm.vw_nav_fathers
as
SELECT _clave, _item_name, active
  FROM [adm].navigator
where _is_father = 1 and active = 1
GO

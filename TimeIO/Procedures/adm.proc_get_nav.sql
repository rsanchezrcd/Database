SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [adm].[proc_get_nav]
	@username nvarchar(64)
as begin 
	SELECT 
		n.id_navigator
		,a._is_father
		,a._is_child
		, case when(a._is_child = 0 and a._is_father = 0) then 1 else 0 end [_is_single]
		,a._father
		,a._item_name
		,a._item_icon
		,a._title
		,a._url
		,a._order
		,case when _father is null then CONCAT( _order,'.', '0' ) else CONCAT( _father,'.', _order )end [real_order]
	FROM [adm].nav_by_ope n 
		inner join cat.operator o on (n.id_operator = o.operator_id)
		inner join adm.navigator a on (n.id_navigator = a.id_navigator)
	where 
			o._username = @username
		and o.active = 1
		and n.active = 1
		and a.active = 1
	order by 
		real_order asc
end;

GO

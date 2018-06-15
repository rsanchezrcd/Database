SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE proc [adm].[proc_get_navigator_byoperator]
	@ope char(36)
as
select * from (
select 
	0 id
	,0 _assigned
	,@ope id_operator
	,id_navigator
	,case when _is_child = 1 then 
			(select '<span data-is=''0'' data-father='''+convert(varchar,n._father)+ '''></span>'+_item_name  + '::'+ n._item_name 
				from adm.navigator
				where _clave = n._father )
		else '<span data-is=''1'' data-clave='''+convert(varchar,n._clave)+'''></span>' + _item_name end _item_name
	,_is_father
	,_is_child 
	,'-' _full
	,'-' _read
	,'-' _write
	,'-' _special
	,n._father
	,case when n._father is null then CONCAT( n._order,'.', '0' ) else CONCAT( n._father,'.', n._order )end [real_order]
from adm.navigator n
 where id_navigator not in (select id_navigator 
							from adm.nav_by_ope 
							where id_operator = @ope) 


union all

SELECT 
	a.id
	  ,case when a.id_operator is null then 0 else 1 end [_assigned]
      ,a.[id_operator]
      ,n.[id_navigator]
	  
	  ,case when _is_child = 1 then 
			(select '<span data-is=''0'' data-father='''+convert(varchar,n._father)+ '''></span>'+_item_name  + '::'+ n._item_name 
				from adm.navigator
				where _clave = n._father )
		else '<span data-is=''1'' data-clave='''+convert(varchar,n._clave)+'''></span>' + _item_name end _item_name
	  ,n._is_father
	  ,n._is_child	  
      ,case when a.[_full] = 0 then '<i data-val=''0'' data-for=''_full'' data-ope=''' +a.[id_operator] +''' data-nav=''' +n.[id_navigator]+ ''' class=''box fa fa-1x fa-square-o''></i>' 
		else '<i data-val=''1'' data-for=''_full'' data-ope=''' +a.[id_operator] +''' data-nav=''' +n.[id_navigator]+ '''  class=''box fa fa-1x fa-check-square-o''></i>' end _full
      ,case when a.[_read] = 0 then '<i data-val=''0'' data-for=''_read'' data-ope=''' +a.[id_operator] +''' data-nav=''' +n.[id_navigator]+ '''  class=''box fa fa-1x fa-square-o''></i>' 
		else '<i data-val=''1'' data-for=''_read'' data-ope=''' +a.[id_operator] +''' data-nav=''' +n.[id_navigator]+ '''  class=''box fa fa-1x fa-check-square-o''></i>'  end _read
      ,case when a.[_write] = 0 then '<i data-val=''0'' data-for=''_write'' data-ope=''' +a.[id_operator] +''' data-nav=''' +n.[id_navigator]+ '''  class=''box fa fa-1x fa-square-o''></i>' 
		else '<i data-val=''1'' data-for=''_write'' data-ope=''' +a.[id_operator] +''' data-nav=''' +n.[id_navigator]+ '''  class=''box fa fa-1x fa-check-square-o''></i>'  end _write
      ,case when a.[_special]= 0 then '<i data-val=''0'' data-for=''_special'' data-ope=''' +a.[id_operator] +''' data-nav=''' +n.[id_navigator]+ '''  class=''box fa fa-1x fa-square-o''></i>' 
		else '<i data-val=''1'' data-for=''_special'' data-ope=''' +a.[id_operator] +''' data-nav=''' +n.[id_navigator]+ '''  class=''box fa fa-1x fa-check-square-o''></i>'  end _special
      --,a.[active]
	  ,n._father
	  ,case when n._father is null then CONCAT( n._order,'.', '0' ) else CONCAT( n._father,'.', n._order )end [real_order]
      
  FROM [adm].[nav_by_ope] a
  inner join adm.navigator n on a.id_navigator = n.id_navigator    
  where n.id_navigator is not null 
		and ( a.id_operator = @ope or a.id_operator is null)		
		and n.active = 1) a
  order by a.real_order asc;

GO

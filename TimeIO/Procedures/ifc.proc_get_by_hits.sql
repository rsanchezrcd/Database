SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO

CREATE proc ifc.proc_get_by_hits
as begin 	
	select 
		i._order
		,i.id_interface 
		,i._interface_name
		,q.id_query
		,q._query_name
		,i._minutes
		,e.insert_date [_last_execution]
		,i._need_op
		--,e.id_interface
		
	from ifc.interface i
		inner join adm.queries q on i.id_query = q.id_query 
		left join (select id_interface, max(insert_date) insert_date from  ifc.event
					where _type = 1 group by id_interface  ) e on i.id_interface = e.id_interface 
									
	where	
		    --q.active = 1
			i.active = 1
		and _by_hits = 1
		and (getdate() >  dateadd(MINUTE, i._minutes, e.insert_date) 
							or e.id_interface is null )
												
		--
		and (i.id_interface_father not in (select 		
												i.id_interface 	
											from ifc.interface i											
												left join (select id_interface, max(insert_date) insert_date from  ifc.event
															where _type = 1 group by id_interface ) e on i.id_interface = e.id_interface 
											where 												
													_by_hits = 1		
												and (getdate() > dateadd(MINUTE, i._minutes, e.insert_date) 
														or e.insert_date is null))
				or i.id_interface_father is null)
		order by _order asc;
	
		
end;

GO

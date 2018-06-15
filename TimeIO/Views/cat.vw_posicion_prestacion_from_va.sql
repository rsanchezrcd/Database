SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
create view cat.vw_posicion_prestacion_from_va
as
SELECT    
      v.[POSITION_NBR] [_posicion_code]	 
      ,case when isnull([AUTHE], 0 )= 'A' then 1 else 0 end [_horas_extras]
      ,case when [AUTPD] = 'A' then 1 else 0 end [_festivos]
	  ,case when [AUTPD] = 'A' then 1 else 0 end [_prima_dominical]
	  ,case when [HENOCT] = 'A' then 1 else 0 end [_horas_nocturnas]	  

FROM VA.[AsistenciaSQL].[dbo].[vwPosicionesAutorizadas] v with(nolock)
inner join VA.[AsistenciaSQL].[dbo].RHPOSACT h with(nolock) on (v.position_nbr = h.position_nbr)
left join  (select distinct Position_nbr, location , emplclass from VA.[AsistenciaSQL].[dbo].RHEMPDEP) l on (v.[POSITION_NBR] = l.[POSITION_NBR])
where h.eff_status = 'A' and l.location not in  ('HRCPC', 'HRHPC')
 
GO

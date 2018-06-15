SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
  create proc [ifc].[proc_device_status]
	@days int = 1
  as begin
  -- status checadores---
	  SELECT 
		b.NAME_ [DEVICE]
		,b.LOCATION 
		--,s.STATUS
		,CASE s.STATUS 
			WHEN 2 THEN 'OK'
			else 'ERROR' end [STATUS]
		, (select count(*) from MorphoManager.dbo.Task where MORPHOACCESSTERMINALID = b.id and datediff(HOUR,CREATEDDATETIME , getdate()) > @days) [TASKS]
	  FROM MorphoManager.dbo.BiometricDevice b
	  inner join MorphoManager.dbo.BiometricDeviceStatus s on b.ID = s.ID
	  order by b.LOCATION, b.NAME_;
  end


GO

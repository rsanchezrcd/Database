SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		rsanchez
-- Create date: 20170929
-- Description:	Elimina de jornadas las checadas eliminadas
-- =============================================
CREATE TRIGGER [tra].[tr_delete_checada_from_jornadas]
   ON  [tra].[checadas]
   AFTER DELETE
AS 
BEGIN
	
	SET NOCOUNT ON;
	
	delete j
	from tra.jornadas j 
	inner join inserted i on j.id_checada_entrada = i.id_checada
	where i._tipo = 0 and j._salida is null;

	update  j
		set  j._jornada = null
			,j._salida = null
			,j._fecha_sal = null
			,j._hora_sal = null
			,j.[_dispositivo_code_sal] = null
	from tra.jornadas j 
	inner join inserted i on j.id_checada_salida = i.id_checada
	where i._tipo = 1 and j._salida is not null;

END
GO
DISABLE TRIGGER [tra].[tr_delete_checada_from_jornadas]
	ON [tra].[checadas]
GO

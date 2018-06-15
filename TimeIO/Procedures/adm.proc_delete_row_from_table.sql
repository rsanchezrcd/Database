SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [adm].[proc_delete_row_from_table]
	-- Add the parameters for the stored procedure here
	@tabla varchar(64)
	,@columna varchar(64)
	,@id char(36)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		begin transaction
			declare @query nvarchar(max) = 'delete from '+ @tabla +' where ' +@columna+ ' = ''' + @id+''';';
			exec(@query);
		commit transaction
	end try
	begin catch		
		
		RAISERROR( 15600,-1,-1, 'Error de transaction - [adm].[proc_delete_row_from_table]');
		rollback transaction
	end catch
END
GO

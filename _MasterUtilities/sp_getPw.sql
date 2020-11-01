
use [master];
go

IF EXISTS (SELECT *
           FROM   sys.objects
           WHERE  object_id = OBJECT_ID(N'[dbo].[sp_getPw]')
                  AND type IN ( N'FN', N'IF', N'TF', N'FS', N'FT' ))
  DROP FUNCTION [dbo].sp_getPw

GO 

/*
declare @pw nvarchar(250) ;
set @pw = (SELECT master.dbo.sp_getPw ('ECMLibrary'));
print @pw ;
*/
CREATE FUNCTION sp_getPw (@PwID nvarchar(250))
RETURNS nvarchar(250) AS
BEGIN

	declare @pw nvarchar(250) = '' ;
	declare @cmd nvarchar(200) = '';

	/* SET THESE VARIABLES TO THE PERMANENT VALUES */
	declare @ECMLibrary nvarchar(250) = 'Junebug1';
	declare @ecmocr nvarchar(250) = 'Junebug1';
	declare @ecmuser nvarchar(250) = 'Junebug1';
	DECLARE @ecmadmin nvarchar(250) = 'ecmadmin';
	DECLARE @ecmsys nvarchar(250) = 'ecmsys';
	DECLARE @wmiller nvarchar(250) = 'wmiller';
	DECLARE @ecmlogin nvarchar(250) = 'ecmlogin';
	DECLARE @dbmgr nvarchar(250) = 'dbmgr';
	DECLARE @##MS_PolicyTsqlExecutionLogin## nvarchar(250) = '##MS_PolicyTsqlExecutionLogin##';
	DECLARE @##MS_PolicyEventProcessingLogin## nvarchar(250) = '##MS_PolicyEventProcessingLogin##';

	
	if (@PwID = 'ecmuser')
		set @pw = @ecmuser;    
	if (@PwID = 'ecmocr')
		set @pw = @ecmocr ;
    if (@PwID = 'ECMLibrary')
		set @pw = @ECMLibrary ;

    RETURN @pw
END
USE DataMartPlatform;
GO

DECLARE
      @msg AS nvarchar (max) ;
DECLARE
      @DBNAME AS nvarchar (250) = 'KenticoCMS_2';
DECLARE
      @ROUTINE_NAME AS nvarchar (250) = '';
DECLARE
      @ROUTINE_DEFINITION AS nvarchar (max) = '';
declare @ii int = 0 ;
declare @i int = 0 ;

set @i = (SELECT  count(*)
	   FROM INFORMATION_SCHEMA.ROUTINES 
	   WHERE ROUTINE_DEFINITION LIKE '%, 0) AS CT%' 
	   AND ROUTINE_TYPE = 'PROCEDURE') ;


DECLARE C CURSOR
    FOR SELECT ROUTINE_NAME , 
               ROUTINE_DEFINITION
          FROM INFORMATION_SCHEMA.ROUTINES
          WHERE ROUTINE_DEFINITION LIKE '%, 0) AS CT%'
            AND ROUTINE_TYPE = 'PROCEDURE' order by ROUTINE_NAME ;


OPEN C;

FETCH NEXT FROM C INTO @ROUTINE_NAME , @ROUTINE_DEFINITION;

WHILE @@FETCH_STATUS = 0
    BEGIN
	   set @ii = @ii + 1 ;
        SET @ROUTINE_DEFINITION = REPLACE (@ROUTINE_DEFINITION , ', 0) AS CT' , ', @VersionNbr) AS CT') ;
        SET @ROUTINE_DEFINITION = REPLACE (@ROUTINE_DEFINITION , 'create procedure [dbo].' , 'alter procedure [dbo].') ;
        
	   --SET @msg = 'Processing: #' + cast(@ii as nvarchar(50)) + ' of '+cast(@i as nvarchar(50)) + ' : ' +  @ROUTINE_NAME;
    --    EXEC PrintImmediate @msg;

	   begin try
		  exec (@ROUTINE_DEFINITION) ;
	   end try
	   begin catch
		  --EXEC proc_CreateBaseTable 'KenticoCMS_3', 'HFit_CMS_User_CHANGES', 1 ; 
		  set @msg = 'EXEC proc_CreateBaseTable ' + substring(@ROUTINE_NAME,11,9999) ;
		  EXEC PrintImmediate @msg;
	   end catch

        FETCH NEXT FROM C INTO @ROUTINE_NAME , @ROUTINE_DEFINITION;
    END;

CLOSE C;
DEALLOCATE C; 



if exists (Select name from sys.tabkles where name = 'VIEW_DDL_BACKUP')
    drop table VIEW_DDL_BACKUP;

SELECT
       o.name
     , 'DROP view ' + o.name AS DropDDL
     , definition AS CreateDDL
INTO
     VIEW_DDL_BACKUP
FROM sys.objects AS o
     JOIN sys.sql_modules AS m
     ON
       m.object_id = o.object_id
WHERE -- o.object_id = object_id( 'view_HFit_HealthAssesmentUserResponses') and 
o.type = 'V' AND
o.name IN
(
    SELECT DISTINCT
		 T.Table_name
    FROM information_schema.columns AS C
	    JOIN information_schema.tables AS T
	    ON
		 T.table_name = C.table_name
    WHERE
		 C.data_type = 'bigint' AND
		 T.table_type = 'VIEW'
);
-- SELECT * FROM VIEW_DDL_BACKUP;

--**********************************************************

DECLARE
       @MySql AS NVARCHAR (MAX) 
     ,@TableName AS NVARCHAR (250) = ''
     ,@Msg AS NVARCHAR (MAX) = ''
     ,@DropDDL AS NVARCHAR (MAX) = ''
     ,@CreateDDL AS NVARCHAR (MAX) = '';

DECLARE CursorVIEWS CURSOR
    FOR
        SELECT
               name
             , DropDDL
             , CreateDDL
        FROM VIEW_DDL_BACKUP;

OPEN CursorVIEWS;

FETCH NEXT FROM CursorVIEWS INTO @TableName , @DropDDL , @CreateDDL;

WHILE
       @@FETCH_STATUS = 0
    BEGIN
        BEGIN TRANSACTION TX1;

        BEGIN TRY
		  SET @Msg = '--.....................................';
            EXEC PrintImmediate  @Msg;
            SET @Msg = 'Processing: ' + @TableName;
            EXEC PrintImmediate  @Msg;
            EXEC (@DropDDL) ;
		  SET @Msg = 'Dropped: ' + @TableName;
            EXEC PrintImmediate  @Msg;
            EXEC (@CreateDDL) ;
		  SET @Msg = 'Regenerated: ' + @TableName;
            EXEC PrintImmediate  @Msg;
            COMMIT TRANSACTION TX1;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION TX1;
            SET @Msg = '--*******************************************************';
            EXEC PrintImmediate  @Msg;
            SET @Msg = 'ERROR Processing: ' + @TableName;
            EXEC PrintImmediate  @Msg;
            EXEC PrintImmediate  @DropDDL;
            EXEC PrintImmediate  @CreateDDL;
            SET @Msg = '--*******************************************************';
            EXEC PrintImmediate  @Msg;
        END CATCH;

        FETCH NEXT FROM CursorVIEWS INTO @TableName , @DropDDL , @CreateDDL;
    END;

CLOSE CursorVIEWS;
DEALLOCATE CursorVIEWS; 

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

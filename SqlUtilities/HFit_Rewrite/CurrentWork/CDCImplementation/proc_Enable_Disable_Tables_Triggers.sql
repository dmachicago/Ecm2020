
-- --use KenticoCMS_Datamart_2

--ALTER INDEX IHash_view_EDW_Eligibility ON dbo.BASE_view_EDW_Eligibility DISABLE;
--DISABLE TRIGGER TRIG_DEL_BASE_view_EDW_Eligibility ON BASE_view_EDW_Eligibility;
--ALTER INDEX IHash_view_EDW_Eligibility ON dbo.BASE_view_EDW_Eligibility REBUILD;
--ENABLE TRIGGER TRIG_DEL_BASE_view_EDW_Eligibility ON BASE_view_EDW_Eligibility;

GO
PRINT 'Executing proc_Enable_Disable_Tables_Triggers.sql';
GO
PRINT 'CREATING Disable_TableTriggers.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'Disable_TableTriggers') 
    BEGIN
        DROP PROCEDURE
             Disable_TableTriggers;
    END;
GO
-- exec Disable_TableTriggers 'FACT_TrackerData', 1
CREATE PROCEDURE dbo.Disable_TableTriggers (
       @TblName AS NVARCHAR (250) 
     , @PreviewOnly AS BIT = 0) 
--@Type INT
AS
BEGIN
    DECLARE
           @trigger_name AS NVARCHAR (250) 
         , @Trigger_owner  AS NVARCHAR (250) 
         , @table_schema AS NVARCHAR (250) 
         , @table_name AS NVARCHAR (250) 
         , @isupdate AS INT
         , @isdelete AS INT
         , @isinsert AS INT
         , @isinsteadof AS INT
         , @disabled AS INT
         , @IndexName NVARCHAR (MAX) 
         , @MySql VARCHAR (MAX) ;

    SELECT
           sysobjects.name AS trigger_name
         , USER_NAME (sysobjects.uid) AS trigger_owner
         , s.name AS table_schema
         , OBJECT_NAME (parent_obj) AS table_name
         , OBJECTPROPERTY ( id , 'ExecIsUpdateTrigger') AS isupdate
         , OBJECTPROPERTY ( id , 'ExecIsDeleteTrigger') AS isdelete
         , OBJECTPROPERTY ( id , 'ExecIsInsertTrigger') AS isinsert
         , OBJECTPROPERTY ( id , 'ExecIsAfterTrigger') AS isafter
         , OBJECTPROPERTY ( id , 'ExecIsInsteadOfTrigger') AS isinsteadof
         , OBJECTPROPERTY (id , 'ExecIsTriggerDisabled') AS disabled
    INTO
         #TempTableTriggers
    FROM sysobjects
         INNER JOIN sysusers
         ON
           sysobjects.uid = sysusers.uid
         INNER JOIN sys.tables AS t
         ON
           sysobjects.parent_obj = t.object_id
         INNER JOIN sys.schemas AS s
         ON
           t.schema_id = s.schema_id
    WHERE
           sysobjects.type = 'TR' AND
           OBJECT_NAME (parent_obj) = @TblName;

    DECLARE TriggerCursor CURSOR
        FOR
            SELECT
                   Quotename (trigger_name) 
                 , Trigger_owner
                 , table_schema
                 , Quotename (table_name) 
                 , isupdate
                 , isdelete
                 , isinsert
                 , isinsteadof
                 , disabled
            FROM #TempTableTriggers;

    OPEN TriggerCursor;
    FETCH NEXT FROM TriggerCursor INTO @trigger_name , @Trigger_owner , @table_schema , @table_name , @isupdate , @isdelete , @isinsert , @isinsteadof , @disabled;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            --DISABLE TRIGGER TRIG_DEL_BASE_view_EDW_Eligibility ON BASE_view_EDW_Eligibility;
            SET @MySql = 'DISABLE TRIGGER ' + @trigger_name + ' ON ' + @table_name;
            IF @PreviewOnly = 1
                BEGIN
                    PRINT @MySql;
                END;
            ELSE
                BEGIN
                    EXEC PrintImmediate @MySql;
                    EXEC (@MySql) ;
                END;
            FETCH NEXT FROM TriggerCursor INTO @trigger_name , @Trigger_owner , @table_schema , @table_name , @isupdate , @isdelete , @isinsert , @isinsteadof , @disabled;
        END;

    CLOSE TriggerCursor;
    DEALLOCATE TriggerCursor;
END;
GO
PRINT 'CREATING Enable_TableTriggers.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'Enable_TableTriggers') 
    BEGIN
        DROP PROCEDURE
             Enable_TableTriggers;
    END;
GO
-- exec Enable_TableTriggers 'FACT_TrackerData', 1
CREATE PROCEDURE dbo.Enable_TableTriggers (
       @TblName AS NVARCHAR (250) 
     , @PreviewOnly AS BIT = 0) 
--@Type INT
AS
BEGIN
    DECLARE
           @trigger_name AS NVARCHAR (250) 
         , @Trigger_owner  AS NVARCHAR (250) 
         , @table_schema AS NVARCHAR (250) 
         , @table_name AS NVARCHAR (250) 
         , @isupdate AS INT
         , @isdelete AS INT
         , @isinsert AS INT
         , @isinsteadof AS INT
         , @disabled AS INT
         , @IndexName NVARCHAR (MAX) 
         , @MySql VARCHAR (MAX) ;

    SELECT
           sysobjects.name AS trigger_name
         , USER_NAME (sysobjects.uid) AS trigger_owner
         , s.name AS table_schema
         , OBJECT_NAME (parent_obj) AS table_name
         , OBJECTPROPERTY ( id , 'ExecIsUpdateTrigger') AS isupdate
         , OBJECTPROPERTY ( id , 'ExecIsDeleteTrigger') AS isdelete
         , OBJECTPROPERTY ( id , 'ExecIsInsertTrigger') AS isinsert
         , OBJECTPROPERTY ( id , 'ExecIsAfterTrigger') AS isafter
         , OBJECTPROPERTY ( id , 'ExecIsInsteadOfTrigger') AS isinsteadof
         , OBJECTPROPERTY (id , 'ExecIsTriggerDisabled') AS disabled
    INTO
         #TempTableTriggers
    FROM sysobjects
         INNER JOIN sysusers
         ON
           sysobjects.uid = sysusers.uid
         INNER JOIN sys.tables AS t
         ON
           sysobjects.parent_obj = t.object_id
         INNER JOIN sys.schemas AS s
         ON
           t.schema_id = s.schema_id
    WHERE
           sysobjects.type = 'TR' AND
           OBJECT_NAME (parent_obj) = @TblName;

    DECLARE TriggerCursor CURSOR
        FOR
            SELECT
                   Quotename (trigger_name) 
                 , Trigger_owner
                 , table_schema
                 , Quotename (table_name) 
                 , isupdate
                 , isdelete
                 , isinsert
                 , isinsteadof
                 , disabled
            FROM #TempTableTriggers;

    OPEN TriggerCursor;
    FETCH NEXT FROM TriggerCursor INTO @trigger_name , @Trigger_owner , @table_schema , @table_name , @isupdate , @isdelete , @isinsert , @isinsteadof , @disabled;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            --DISABLE TRIGGER TRIG_DEL_BASE_view_EDW_Eligibility ON BASE_view_EDW_Eligibility;
            SET @MySql = 'ENABLE TRIGGER ' + @trigger_name + ' ON ' + @table_name;
            IF @PreviewOnly = 1
                BEGIN
                    PRINT @MySql;
                END;
            ELSE
                BEGIN
                    EXEC PrintImmediate @MySql;
                    EXEC (@MySql) ;
                END;
            FETCH NEXT FROM TriggerCursor INTO @trigger_name , @Trigger_owner , @table_schema , @table_name , @isupdate , @isdelete , @isinsert , @isinsteadof , @disabled;
        END;

    CLOSE TriggerCursor;
    DEALLOCATE TriggerCursor;
END;

GO
PRINT 'Executed proc_Enable_Disable_Tables_Triggers.sql';
GO



-- use KenticoCMS_DataMart_2

--  select * from information_schema.columns where table_name = 'BASE_CMS_user' --	SurrogateKey_cms_user

-- get all existing indexes into a temp table
-- drop the PK index as it exist
-- add the desired 

CREATE PROCEDURE proc_AddSurrogateKeyRel
AS
BEGIN

    DECLARE
           @ParentTbl AS NVARCHAR (250) 
         , @ChildTbl AS NVARCHAR (250) 
         , @PreviewOnly AS NVARCHAR (250) = 'YES';

    DECLARE
           @ParentSKeyName AS NVARCHAR (250) 
         , @ChildSKeyName AS NVARCHAR (250) 
         , @ForeignKeyName AS NVARCHAR (250) 
         , @MySql AS NVARCHAR (MAX) 
         , @TrigName AS NVARCHAR (250) 
         , @iCnt AS INT;

    SET @ParentTbl = 'BASE_CMS_user';
    SET @ChildTbl = 'BASE_Hfit_PPTEligibility';

    BEGIN TRY
        DROP TABLE
             #Triggers;
    END TRY
    BEGIN CATCH
        PRINT 'Processing #Triggers';
    END CATCH;

    SELECT
           so.name AS trigger_name
         , USER_NAME (so.uid) AS trigger_owner
         , USER_NAME (so2.uid) AS table_schema
         , OBJECT_NAME (so.parent_obj) AS table_name
         , OBJECTPROPERTY (so.id , 'ExecIsUpdateTrigger') AS isupdate
         , OBJECTPROPERTY (so.id , 'ExecIsDeleteTrigger') AS isdelete
         , OBJECTPROPERTY (so.id , 'ExecIsInsertTrigger') AS isinsert
         , OBJECTPROPERTY (so.id , 'ExecIsAfterTrigger') AS isafter
         , OBJECTPROPERTY (so.id , 'ExecIsInsteadOfTrigger') AS isinsteadof
         , OBJECTPROPERTY (so.id , 'ExecIsTriggerDisabled') AS disabled INTO
                                                                             #Triggers
    FROM
         sysobjects AS so
         INNER JOIN sysobjects AS so2
         ON
           so.parent_obj = so2.Id
    WHERE so.type = 'TR';

    --SELECT *
    --       FROM #Triggers
    --       WHERE table_name = @ChildTbl;

    DECLARE C CURSOR
        FOR SELECT
                   trigger_name
            FROM #Triggers
            WHERE
                   table_name = @ChildTbl;

    OPEN C;
    FETCH NEXT FROM C INTO @TrigName;

    --Disable all child table triggers
    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @MySql = 'DISABLE TRIGGER [' + @TrigName + '] ON dbo.' + @ChildTbl;
            PRINT @MySql;
            IF
                   @PreviewOnly != 'YES'
                BEGIN
                    EXEC (@MySql) 
                END;
            OPEN C;
            FETCH NEXT FROM C INTO @TrigName;
        END;

    SET @iCnt = CHARINDEX ('BASE_' , @ChildTbl) ;
    PRINT '@iCnt: ' + CAST (@iCnt AS NVARCHAR (50)) ;
    IF @iCnt > 0
        BEGIN
            SET @ParentSKeyName = 'SurrogateKey_' + SUBSTRING (@ParentTbl , 6 , 999) ;
            SET @ChildSKeyName = 'SurrogateKey_' + SUBSTRING (@ParentTbl , 6 , 999) ;
            SET @ForeignKeyName = 'SurrogateKey_' + SUBSTRING (@ParentTbl , 6 , 999) ;
        END;
    PRINT '@ChildSKeyName : ' + @ChildSKeyName;
    PRINT '@ForeignKeyName : ' + @ForeignKeyName;

    IF NOT EXISTS (SELECT
                          column_name
                   FROM information_schema.columns
                   WHERE
                          table_name = @ChildTbl AND
                          column_name = @ChildSKeyName) 
        BEGIN
            PRINT 'Surrogate key, ' + @ChildSKeyName + ' being added to ' + @ChildTbl;
            SET @MySql = 'alter table ' + @ChildTbl + ' add ' + @ChildSKeyName + ' bigint not null default 0 ';
            IF
                   @PreviewOnly != 'YES'
                BEGIN
                    EXEC (@MySql) 
                END;
        END;
    ELSE
        BEGIN
            PRINT 'Surrogate key, ' + @ChildSKeyName + ' already exist in ' + @ChildTbl;
        END;

    --REMOVE Existing Primary Key

    SET @MySql = '';
    SET @MySql = @MySql + 'UPDATE ChildTbl SET ChildTbl.' + @ChildSKeyName + ' = ParentTbl.' + @ChildSKeyName + CHAR (10) ;
    SET @MySql = @MySql + 'FROM ' + CHAR (10) ;
    SET @MySql = @MySql + '    ' + @ChildTbl + ' as ChildTbl ' + CHAR (10) ;
    SET @MySql = @MySql + '    JOIN ' + CHAR (10) ;
    SET @MySql = @MySql + '    ' + @ParentTbl + ' as ParentTbl ON  ' + CHAR (10) ;
    SET @MySql = @MySql + '	   ChildTbl.svr=ParentTbl.svr ' + CHAR (10) ;
    SET @MySql = @MySql + '    and ChildTbl.dbname=ParentTbl.dbname ' + CHAR (10) ;
    SET @MySql = @MySql + '    and ChildTbl.userid=ParentTbl.userid ' + CHAR (10) ;
    PRINT @MySql;

    IF
           @PreviewOnly != 'YES'
        BEGIN
            EXEC (@MySql) 
        END;

    -- ADD New Primary Key

    --ENABLE all table triggers
    DECLARE C2 CURSOR
        FOR SELECT
                   trigger_name
            FROM #Triggers
            WHERE
                   table_name = @ChildTbl;

    OPEN C2;
    FETCH NEXT FROM C2 INTO @TrigName;

    --Disable all child table triggers
    WHILE
           @@FETCH_STATUS = 0
        BEGIN
            SET @MySql = 'ENABLE TRIGGER [' + @TrigName + '] ON dbo.' + @ChildTbl;
            PRINT @MySql;
            IF
                   @PreviewOnly != 'YES'
                BEGIN
                    EXEC (@MySql) 
                END;
            OPEN C2;
            FETCH NEXT FROM C2 INTO @TrigName;
        END;
END;
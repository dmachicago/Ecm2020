
/*-----------------------------------------------------------------------------
use KenticoCMSDebug	    --2192 / 2090
use KenticoCMSDev	    --2170 / 2112
use KenticoCMSTest	    --2166 / 2105

select * from sys.indexes

alter table HFit_SchemaChangeMonitor alter column DB_User nvarchar(250) null
alter table HFit_SchemaChangeMonitor alter column EventName nvarchar(250) null
alter table HFit_SchemaChangeMonitor alter column ObjectName nvarchar(250) null
*/

GO
PRINT 'Executing proc_FindRemoveDupIndexes.sql';
GO
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'proc_FindRemoveDupIndexes') 
    BEGIN
        DROP PROCEDURE
             proc_FindRemoveDupIndexes
    END;
GO
CREATE PROCEDURE proc_FindRemoveDupIndexes
AS
BEGIN

/*-------------------------------------------------------------------------------------
AUTHOR:	  W. Dale Miller
CONTACT:	  dm@DmaChicago.com
DATE:	  07/10/2010
Purpose:	  Finds indexes that have redundant columns. Modified for HFit use 12.01.2015.
*/

    DECLARE
           @CML AS INT = 0;
    BEGIN TRY
        IF NOT EXISTS (SELECT
                              name
                       FROM sys.tables
                       WHERE
                              name = 'HFit_SchemaChangeMonitor') 
            BEGIN
                PRINT 'WARNING: Schema Monitoring may need to be installed in the database.'
            END;

        SET @CML = (SELECT
                           CHARACTER_MAXIMUM_LENGTH
                    FROM information_schema.columns
                    WHERE
                           table_name = 'HFit_SchemaChangeMonitor' AND
                           column_name = 'DB_User') ;
        PRINT @CML;
        IF @CML < 250
            BEGIN
                ALTER TABLE HFit_SchemaChangeMonitor ALTER COLUMN DB_User NVARCHAR (250) NULL;
                ALTER TABLE HFit_SchemaChangeMonitor ALTER COLUMN EventName NVARCHAR (250) NULL;
                ALTER TABLE HFit_SchemaChangeMonitor ALTER COLUMN ObjectName NVARCHAR (250) NULL;
            END;
    END TRY
    BEGIN CATCH
        PRINT 'NOTICE: verify HFit_SchemaChangeMonitor column widths - OR, Schema Monitoring may need to be installed in the database.';
    END CATCH;
    BEGIN TRY
        DROP TABLE
             TEMP_DupIndexes;
    END TRY
    BEGIN CATCH
        PRINT 'TEMP_DupIndexes created';
    END CATCH;

    WITH MyDuplicate
        AS (SELECT
                   Sch.name AS SchemaName
                 , Obj.name AS TableName
                 , Idx.name AS IndexName
                 , INDEX_COL (Sch.name + '.' + Obj.name , Idx.index_id , 1) AS Col1
                 , INDEX_COL (Sch.name + '.' + Obj.name , Idx.index_id , 2) AS Col2
                 , INDEX_COL (Sch.name + '.' + Obj.name , Idx.index_id , 3) AS Col3
                 , INDEX_COL (Sch.name + '.' + Obj.name , Idx.index_id , 4) AS Col4
                 , INDEX_COL (Sch.name + '.' + Obj.name , Idx.index_id , 5) AS Col5
                 , INDEX_COL (Sch.name + '.' + Obj.name , Idx.index_id , 6) AS Col6
                 , INDEX_COL (Sch.name + '.' + Obj.name , Idx.index_id , 7) AS Col7
                 , INDEX_COL (Sch.name + '.' + Obj.name , Idx.index_id , 8) AS Col8
                 , INDEX_COL (Sch.name + '.' + Obj.name , Idx.index_id , 9) AS Col9
                 , INDEX_COL (Sch.name + '.' + Obj.name , Idx.index_id , 10) AS Col10
                 , INDEX_COL (Sch.name + '.' + Obj.name , Idx.index_id , 11) AS Col11
                 , INDEX_COL (Sch.name + '.' + Obj.name , Idx.index_id , 12) AS Col12
                 , INDEX_COL (Sch.name + '.' + Obj.name , Idx.index_id , 13) AS Col13
                 , INDEX_COL (Sch.name + '.' + Obj.name , Idx.index_id , 14) AS Col14
                 , INDEX_COL (Sch.name + '.' + Obj.name , Idx.index_id , 15) AS Col15
                 , INDEX_COL (Sch.name + '.' + Obj.name , Idx.index_id , 16) AS Col16
            FROM sys.indexes AS Idx
                 INNER JOIN sys.objects AS Obj
                 ON
                   Idx.object_id = Obj.object_id
                 INNER JOIN sys.schemas AS Sch
                 ON
                   Sch.schema_id = Obj.schema_id
            WHERE index_id > 0) 
        SELECT
               MD1.SchemaName
             , MD1.TableName
             , MD1.IndexName
             , MD2.IndexName AS OverLappingIndex
             , MD1.Col1
             , MD1.Col2
             , MD1.Col3
             , MD1.Col4
             , MD1.Col5
             , MD1.Col6
             , MD1.Col7
             , MD1.Col8
             , MD1.Col9
             , MD1.Col10
             , MD1.Col11
             , MD1.Col12
             , MD1.Col13
             , MD1.Col14
             , MD1.Col15
             , MD1.Col16
             , (SELECT
                       count (*) 
                FROM (VALUES (MD1.Col1) ,
                             (MD1.Col2) ,
                             (MD1.Col3) ,
                             (MD1.Col4) ,
                             (MD1.Col5) ,
                             (MD1.Col6) ,
                             (MD1.Col7) ,
                             (MD1.Col8) ,
                             (MD1.Col9) ,
                             (MD1.Col10) ,
                             (MD1.Col11) ,
                             (MD1.Col12) ,
                             (MD1.Col13) ,
                             (MD1.Col14) ,
                             (MD1.Col15) ,
                             (MD1.Col16)) AS t (XVAL) 
                WHERE XVAL IS NOT NULL
               ) AS NotNullCount
             , 'DROP INDEX ' + MD1.IndexName + ' ON ' + MD1.TableName AS DropCMD

        INTO
             TEMP_DupIndexes
        FROM MyDuplicate AS MD1
             INNER JOIN MyDuplicate AS MD2
             ON
               MD1.tablename = MD2.tablename AND
               MD1.indexname <> MD2.indexname AND
               MD1.Col1 = MD2.Col1 AND
               (
               MD1.Col2 IS NULL OR
               MD2.Col2 IS NULL OR
               MD1.Col2 = MD2.Col2) AND
               (
               MD1.Col3 IS NULL OR
               MD2.Col3 IS NULL OR
               MD1.Col3 = MD2.Col3) AND
               (
               MD1.Col4 IS NULL OR
               MD2.Col4 IS NULL OR
               MD1.Col4 = MD2.Col4) AND
               (
               MD1.Col5 IS NULL OR
               MD2.Col5 IS NULL OR
               MD1.Col5 = MD2.Col5) AND
               (
               MD1.Col6 IS NULL OR
               MD2.Col6 IS NULL OR
               MD1.Col6 = MD2.Col6) AND
               (
               MD1.Col7 IS NULL OR
               MD2.Col7 IS NULL OR
               MD1.Col7 = MD2.Col7) AND
               (
               MD1.Col8 IS NULL OR
               MD2.Col8 IS NULL OR
               MD1.Col8 = MD2.Col8) AND
               (
               MD1.Col9 IS NULL OR
               MD2.Col9 IS NULL OR
               MD1.Col9 = MD2.Col9) AND
               (
               MD1.Col10 IS NULL OR
               MD2.Col10 IS NULL OR
               MD1.Col10 = MD2.Col10) AND
               (
               MD1.Col11 IS NULL OR
               MD2.Col11 IS NULL OR
               MD1.Col11 = MD2.Col11) AND
               (
               MD1.Col12 IS NULL OR
               MD2.Col12 IS NULL OR
               MD1.Col12 = MD2.Col12) AND
               (
               MD1.Col13 IS NULL OR
               MD2.Col13 IS NULL OR
               MD1.Col13 = MD2.Col13) AND
               (
               MD1.Col14 IS NULL OR
               MD2.Col14 IS NULL OR
               MD1.Col14 = MD2.Col14) AND
               (
               MD1.Col15 IS NULL OR
               MD2.Col15 IS NULL OR
               MD1.Col15 = MD2.Col15) AND
               (
               MD1.Col16 IS NULL OR
               MD2.Col16 IS NULL OR
               MD1.Col16 = MD2.Col16) 
        ORDER BY
                 MD1.SchemaName , MD1.TableName , MD1.IndexName , MD1.Col1 DESC , MD1.Col2 DESC , MD1.Col3 DESC , MD1.Col4 DESC , MD1.Col5 DESC , MD1.Col6 DESC , MD1.Col7 DESC , MD1.Col8 DESC , MD1.Col9 DESC , MD1.Col10 DESC;
    --MD1.SchemaName , MD1.TableName , MD1.IndexName, MD1.Col1, MD1.Col2,MD1.Col3,MD1.Col4,MD1.Col5,MD1.Col6,MD1.Col7,MD1.Col8,MD1.Col9,MD1.Col10 ;

    ALTER TABLE TEMP_DupIndexes
    ADD
                RowNbr INT IDENTITY (1 , 1) 
                           NOT NULL;
    ALTER TABLE TEMP_DupIndexes
    ADD
                KeepThisIndex INT NULL;

    UPDATE TEMP_DupIndexes
        SET
            KeepThisIndex = 1
    WHERE
           tablename = 'Analytics_ConversionCampaign' AND
           IndexNAme = 'PK_Analytics_ConversionCampaign';

    UPDATE TEMP_DupIndexes
        SET
            KeepThisIndex = 1
    WHERE
           tablename = 'Chat_InitiatedChatRequest' AND
           IndexNAme = 'UQ_Chat_InitiatedChatRequest_UserIDContactID';

    UPDATE TEMP_DupIndexes
        SET
            KeepThisIndex = 1
    WHERE
           tablename = 'Chat_InitiatedChatRequest' AND
           IndexNAme = 'UQ_Chat_InitiatedChatRequest_RoomID';

    UPDATE TEMP_DupIndexes
        SET
            KeepThisIndex = 1
    WHERE
           tablename = 'Chat_OnlineSupport' AND
           IndexNAme = 'UQ_Chat_OnlineSupport_ChatUserID-SiteID';

    UPDATE TEMP_DupIndexes
        SET
            KeepThisIndex = 1
    WHERE
           tablename = 'Chat_OnlineUser' AND
           IndexNAme = 'UQ_Chat_OnlineUser_SiteID-ChatUserID';

    --*************************************************************
    DELETE FROM TEMP_DupIndexes
    WHERE
          IndexName LIKE 'PK_%' OR
          OverLappingIndex LIKE 'PK_%';
    --*************************************************************
    SELECT
           *
    FROM TEMP_DupIndexes
    WHERE OverlappingIndex IN (SELECT
                                      IndexName
                               FROM TEMP_DupIndexes) 
    ORDER BY
             SchemaName , TableName , col1 DESC , col2 DESC , col3 DESC , col4 DESC , col5 DESC , col6 DESC , col7 DESC , col8 DESC , col9 DESC , col10 DESC;
    -- HFit_HealthAssesmentUserQuestion
    --*************************************************************

    DECLARE
           @PreviewOnly AS BIT = 0
         , @PrevTableName AS NVARCHAR (250) = ''
         , @TableName AS NVARCHAR (250) = ''
         , @IndexName AS NVARCHAR (250) = ''
         , @OverLappingIndex AS NVARCHAR (250) = ''
         , @NotNullCount AS INT = 0
         , @PrevNotNullCount AS INT = 0
         , @Cmd AS NVARCHAR (MAX) = ''
         , @DropCmd AS NVARCHAR (MAX) = ''
         , @DropSql AS NVARCHAR (MAX) = ''
         , @Msg AS NVARCHAR (MAX) = ''
         , @OverLappingIndexIsPK AS BIT = 0
         , @IndexNameIsPK AS BIT = 0
         , @SchemaName AS NVARCHAR (250) = '';

    DECLARE
           @T AS TABLE (
                       IndexName NVARCHAR (500)) ;

    DECLARE C CURSOR
        FOR
            SELECT
                   SchemaName
                 , TableName
                 , IndexName
                 , OverLappingIndex
                 , DropCmd
                 , NotNullCount
            FROM TEMP_DupIndexes;

    OPEN C;

    FETCH NEXT FROM C INTO @SchemaName , @TableName , @IndexName , @OverLappingIndex , @DropCmd , @NotNullCount;

    WHILE
           @@FETCH_STATUS = 0
        BEGIN

            SET @TableName = '[' + @TableName + ']';
            SET @IndexName = '[' + @IndexName + ']';
            SET @OverLappingIndex = '[' + @OverLappingIndex + ']';

            IF
                   charindex (@OverLappingIndex , 'PK_') > 0
                BEGIN
                    PRINT '>>>: SKIPPING ' + @OverLappingIndex;
                    GOTO AlreadyGone;
                END;
            IF
                   charindex (@IndexName , 'PK_') > 0
                BEGIN
                    PRINT '>>>: SKIPPING ' + @IndexName;
                    GOTO AlreadyGone;
                END;

            SET @Msg = '****: ' + @TableName + ' : ' + @IndexName + ' : ' + @OverLappingIndex;
            EXEC PrintImmediate @Msg;

            IF EXISTS (SELECT
                              IndexName
                       FROM @T
                       WHERE
                              INdexName = @IndexName) 
                BEGIN
                    PRINT '-- ** -- INDEX already removed: ' + @IndexName;
                    GOTO AlreadyGone;
                END;
            IF EXISTS (SELECT
                              TABLE_NAME
                       FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                       WHERE
                              CONSTRAINT_TYPE = 'PRIMARY KEY' AND
                              TABLE_NAME = @TableName AND
                              CONSTRAINT_NAME = @IndexName AND
                              TABLE_SCHEMA = 'dbo') 
                BEGIN
                    SET @IndexNameIsPK = 1;
                    PRINT '@IndexName PRIMARYKEY - ' + @IndexName;
                END;
            ELSE
                BEGIN
                    SET @IndexNameIsPK = 0;
                END;

            IF EXISTS (SELECT
                              TABLE_NAME
                       FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                       WHERE
                              CONSTRAINT_TYPE = 'PRIMARY KEY' AND
                              TABLE_NAME = @TableName AND
                              CONSTRAINT_NAME = @OverLappingIndex AND
                              TABLE_SCHEMA = 'dbo') 
                BEGIN
                    SET @OverLappingIndexIsPK = 1;
                    PRINT '@OverLappingIndex PRIMARYKEY - ' + @OverLappingIndex;
                END;
            ELSE
                BEGIN
                    SET @OverLappingIndexIsPK = 0;
                END;

            IF
                   @PrevTableName != @TableName
                BEGIN
                    PRINT '$$ Table Changed from ' + @PrevTableName + ' TO ' + @TableName;
                    SET @PrevNotNullCount = 0;
                END;

            SET @Msg = '@@@@: @IndexNameIsPK = ' + cast (@IndexNameIsPK AS NVARCHAR (50)) + ' / @OverLappingIndexIsPK = ' + cast (@OverLappingIndexIsPK AS NVARCHAR (50)) ;
            EXEC PrintImmediate @Msg;

            IF
                   @IndexNameIsPK = 0 AND
                   @OverLappingIndexIsPK = 1
                BEGIN
                    PRINT '!! SKIPPING: ' + @IndexName + ' is NOT a PK and ' + @OverLappingIndex + ' is . NOT Dropping either.';
                    INSERT INTO @T (
                           IndexName) 
                    VALUES (@OverLappingIndex) ;
                    GOTO AlreadyGone;
                END;
            IF
                   @IndexNameIsPK = 1 AND
                   @OverLappingIndexIsPK = 0
                BEGIN
                    PRINT '++ ' + @IndexName + ' is a PK and ' + @OverLappingIndex + ' is not. Dropping ' + @OverLappingIndex + '.';
                    SET @DropSql = 'Drop Index ' + @IndexName + ' on ' + @TableName;
                    BEGIN TRY
                        IF @PreviewOnly = 0
                            BEGIN
                                EXEC (@DropSql) ;
                            END;
                        ELSE
                            BEGIN
                                PRINT '1:0 @DropSql: ' + @DropSql;
                            END;
                        INSERT INTO @T (
                               IndexName) 
                        VALUES (@OverLappingIndex) ;
                    END TRY
                    BEGIN CATCH
                        PRINT '!! NOTICE: ' + @DropSql;
                    END CATCH;
                    GOTO AlreadyGone;
                END;

            IF
                   @IndexNameIsPK = 1 AND
                   @OverLappingIndexIsPK = 1
                BEGIN
                    PRINT '++ ' + @IndexName + ' is a PK and ' + @OverLappingIndex + ' is TOO. Dropping ' + @OverLappingIndex + '.';
                    SET @DropSql = 'Drop Index ' + @IndexName + ' on ' + @TableName;
                    BEGIN TRY
                        IF @PreviewOnly = 0
                            BEGIN
                                EXEC (@DropSql) ;
                            END;
                        ELSE
                            BEGIN
                                PRINT '1:1 @DropSql: ' + @DropSql;
                            END;
                        INSERT INTO @T (
                               IndexName) 
                        VALUES (@OverLappingIndex) ;
                    END TRY
                    BEGIN CATCH
                        PRINT '!! NOTICE: ' + @DropSql;
                    END CATCH;
                    GOTO AlreadyGone;
                END;

            IF
                   @IndexNameIsPK = 0 AND
                   @OverLappingIndexIsPK = 0
                BEGIN
                    IF EXISTS (SELECT
                                      TABLE_NAME
                               FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                               WHERE
                                      CONSTRAINT_TYPE = 'PRIMARY KEY' AND
                                      TABLE_NAME = @TableName AND
                                      CONSTRAINT_NAME = @OverLappingIndex AND
                                      TABLE_SCHEMA = 'dbo') 
                        BEGIN
                            EXEC PrintImmediate '@OverLappingIndex: IS A PRiMARY KEY.';
                        END;
                    ELSE
                        BEGIN
                            EXEC PrintImmediate '@OverLappingIndex: NOT A PKEY.';
                        END;

                    SET @DropSql = 'Drop Index ' + @OverLappingIndex + ' on ' + @TableName;
                    IF @PreviewOnly = 1
                        BEGIN
                            PRINT '0:0 Dropping OverLappingIndex: ' + @DropSql;
                        END;
                    ELSE
                        BEGIN
                            BEGIN TRY
                                EXEC (@DropSql) ;
                                INSERT INTO @T (
                                       IndexName) 
                                VALUES (@OverLappingIndex) ;
                            END TRY
                            BEGIN CATCH
                                PRINT '!! NOTICE: ' + @DropSql;
                            END CATCH;
                        END;

                END;
            ELSE
                BEGIN
                    PRINT 'PRIMARY KEY INDEX (Skipped): ' + @OverLappingIndex;
                    INSERT INTO @T (
                           IndexName) 
                    VALUES (@OverLappingIndex) ;
                END;

            AlreadyGone:
            SET @PrevTableName = @TableName;
            FETCH NEXT FROM C INTO @SchemaName , @TableName , @IndexName , @OverLappingIndex , @DropCmd , @NotNullCount;
        END;

    CLOSE C;
    DEALLOCATE C;

    SELECT
           *
    FROM @T;

    PRINT '******** COMPLETED : RERUN if NEEDED **************';
END;
GO
PRINT 'Executed proc_FindRemoveDupIndexes.sql';
GO

/*----------------------------------------------------------
SELECT TABLE_NAME
    FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
    WHERE
		  CONSTRAINT_TYPE = 'PRIMARY KEY' AND
		  TABLE_NAME = 'HFit_HealthAssesmentUserQuestion' AND
		  CONSTRAINT_NAME = 'PK_HFit_HealthAssesmentUserQuestion' 
			 AND TABLE_SCHEMA = 'dbo'
*/

/*------------------------------------------------------------------------------------------------------------------------------------------------------------
 NOTIFICATIONS in use KenticoCMSDebug
Drop Index [nonKeyName] on [CMS_SettingsKey]
Drop Index [IDX_UserSettings_SettingsUserID] on [CMS_UserSettings]
Drop Index [IDX_UserSettings_SettingsUserID] on [CMS_UserSettings]
Drop Index [IX_CMS_UserSettings_UserSettingsUserID] on [CMS_UserSettings]
Drop Index [IX_NC_HFit_CoachingEnrollmentSyncStaging_SourceSystemCode_ProcessGUID_INC_AccountCD_UserGuid_ServiceLevel] on [HFit_CoachingEnrollmentSyncStaging]
Drop Index [IX_OM_ScoreContactRule_ScoreID] on [OM_ScoreContactRule]
Drop Index [nonDataSource] on [HFit_DataEntry_Clinical]
Drop Index [nonDataSource] on [HFit_DataEntry_Clinical]
Drop Index [IX_OM_Membership_RelatedID] on [OM_Membership]
Drop Index [UQ_Chat_OnlineUser_SiteID-ChatUserID] on [Chat_OnlineUser]
Drop Index [UQ_Chat_InitiatedChatRequest_UserIDContactID] on [Chat_InitiatedChatRequest]
*/

/*----------------------------------------------------------------------------------------------------------------------------------------------------------------------
 NOTIFICATIONS use KenticoCMSDev
NOTICE: Drop Index [IDX_UserSettings_SettingsUserID] on [CMS_UserSettings]
NOTICE: Drop Index [IDX_UserSettings_SettingsUserID] on [CMS_UserSettings]
NOTICE: Drop Index [IDX_UserSettings_SettingsUserID] on [CMS_UserSettings]
NOTICE: Drop Index [IX_CMS_Class_ClassName] on [CMS_Class]
NOTICE: Drop Index [IX_CMS_UserSettings_UserSettingsUserID] on [CMS_UserSettings]
NOTICE: Drop Index [IX_CMS_UserSettings_UserSettingsUserID] on [CMS_UserSettings]
NOTICE: Drop Index [IX_NC_HFit_CoachingEnrollmentSyncStaging_SourceSystemCode_ProcessGUID_INC_AccountCD_UserGuid_ServiceLevel] on [HFit_CoachingEnrollmentSyncStaging]
NOTICE: Drop Index [IX_NC_HFit_CoachingEnrollmentSyncStaging_SourceSystemCode_ProcessGUID_INC_AccountCD_UserGuid_ServiceLevel] on [HFit_CoachingEnrollmentSyncStaging]
NOTICE: Drop Index [IX_NC_HFit_CoachingEnrollmentSyncStaging_SourceSystemCode_ProcessGUID_INC_UserGUID_EnrollmentStatus] on [HFit_CoachingEnrollmentSyncStaging]
NOTICE: Drop Index [IX_NC_HFit_CoachingEnrollmentSyncStaging_SourceSystemCode_ProcessGUID_INC_UserGUID_EnrollmentStatusDateTime] on [HFit_CoachingEnrollmentSyncStaging]
NOTICE: Drop Index [IX_OM_Membership_RelatedID] on [OM_Membership]
NOTICE: Drop Index [IX_OM_ScoreContactRule_ScoreID] on [OM_ScoreContactRule]
NOTICE: Drop Index [nonDataSource] on [HFit_DataEntry_Clinical]
NOTICE: Drop Index [nonDataSource] on [HFit_DataEntry_Clinical]
NOTICE: Drop Index [nonKeyName] on [CMS_SettingsKey]
NOTICE: Drop Index [UQ_Chat_InitiatedChatRequest_RoomID] on [Chat_InitiatedChatRequest]
NOTICE: Drop Index [UQ_Chat_InitiatedChatRequest_UserIDContactID] on [Chat_InitiatedChatRequest]
NOTICE: Drop Index [UQ_Chat_OnlineUser_SiteID-ChatUserID] on [Chat_OnlineUser]
*/

GO

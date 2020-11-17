IF EXISTS (SELECT
           name
             FROM sys.procedures
             WHERE name = 'sp_FindDependentColumns') 
    BEGIN
        DROP PROCEDURE
        sp_FindDependentColumns;
    END;
GO
--drop table EDW_ViewBaseColumns
--exec sp_FindDependentColumns 'view_EDW_RewardAwardDetail' NULL NULL
--exec sp_FindDependentColumns 'view_EDW_HealthAssesment' NULL NULL
--select * from EDW_ViewBaseColumns order by OwnerView, OwnerObj,DepObj,ColumnName
CREATE PROCEDURE sp_FindDependentColumns
@PARENT_VIEW AS nvarchar (100) 
, @OWNER_OBJ AS nvarchar (100) = NULL
, @OBJLEVEL AS int = NULL
AS
BEGIN

    --DECLARE @PARENT_VIEW AS nvarchar (100) = 'view_EDW_SmallStepResponses';
    --DECLARE @OWNER_OBJ AS nvarchar (100) = NULL;
    --DECLARE @OBJLEVEL AS int = 0;

    DECLARE
       @MASTER_VIEW AS nvarchar (100) = NULL;
    IF @OWNER_OBJ IS NULL
        BEGIN
            SET @OWNER_OBJ = @PARENT_VIEW;
        END;
    IF NOT EXISTS (SELECT
                   table_name
                     FROM information_schema.tables
                     WHERE table_name = 'EDW_ViewBaseColumns') 
        BEGIN
            CREATE TABLE dbo.EDW_ViewBaseColumns (
            OwnerView nvarchar (100) NOT NULL
          , OwnerObj nvarchar (100) NOT NULL
          , DepObj nvarchar (100) NOT NULL
          , ColumnName nvarchar (100) NOT NULL
          , TypeObj nvarchar (10) NOT NULL
          , ObjLevel int NULL
          , CreateDate datetime2 (7) NULL
          , RowNbr int IDENTITY (1, 1) 
                       NOT NULL
          , CONSTRAINT PK_EDW_ViewBaseColumns PRIMARY KEY CLUSTERED (OwnerView ASC, OwnerObj ASC, DepObj ASC, ColumnName ASC) 
                WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]) 
            ON [PRIMARY];
            ALTER TABLE dbo.EDW_ViewBaseColumns
            ADD
            CONSTRAINT DF_EDW_ViewBaseColumns_CreateDate DEFAULT GETDATE () FOR CreateDate;            
        END;
    DECLARE
       @cc AS int = 0;
    DECLARE
       @iCnt AS int = 0;
    DECLARE
       @ObjName AS nvarchar (100) ;
    DECLARE
       @DepObj AS nvarchar (100) ;
    DECLARE
       @ColName AS nvarchar (100) ;
    DECLARE db_cursor CURSOR
        FOR SELECT
            obj_name = SUBSTRING (OBJECT_NAME (d.id) , 1, 100) 
          , dep_obj = SUBSTRING (OBJECT_NAME (d.depid) , 1, 100) 
          , col_name = SUBSTRING (name, 1, 100) 
              FROM
                   sysdepends AS d
                       JOIN syscolumns AS c
                           ON d.depid = c.id
                          AND d.depnumber = c.colid
              WHERE OBJECT_NAME (d.id) = @PARENT_VIEW;
    OPEN db_cursor;
    FETCH NEXT FROM db_cursor INTO @ObjName, @DepObj, @ColName;
    WHILE @@FETCH_STATUS = 0
        BEGIN
            SET @iCnt = (SELECT
                         COUNT (*) 
                           FROM sys.views
                           WHERE name = @DepObj) ;
            IF @iCnt > 0
                BEGIN
                    PRINT 'Nested View: ' + @DepObj + ' CALL Recursive';
                    SET @cc = (SELECT
                               COUNT (*) 
                                 FROM EDW_ViewBaseColumns
                                 WHERE OwnerView = @ObjName
                                   AND DepObj = @DepObj
                                   AND ColumnName = @ColName) ;
                    IF @cc = 0
                        BEGIN
                            INSERT INTO EDW_ViewBaseColumns (
                            OwnerView
                          , DepObj
                          , ColumnName
                          , TypeObj
                          , ObjLevel
                          , OwnerObj) 
                            VALUES
                                   (@ObjName, @DepObj, @ColName, ' V', @OBJLEVEL, @OWNER_OBJ) ;
                        END;
                END;
            ELSE
                BEGIN
                    PRINT 'BASE Table: ' + @DepObj + ' insert into temp table';
                    SET @cc = (SELECT
                               COUNT (*) 
                                 FROM EDW_ViewBaseColumns
                                 WHERE OwnerView = @ObjName
                                   AND DepObj = @DepObj
                                   AND ColumnName = @ColName) ;
                    IF @cc = 0
                        BEGIN
                            INSERT INTO EDW_ViewBaseColumns (
                            OwnerView
                          , DepObj
                          , ColumnName
                          , TypeObj
                          , ObjLevel
                          , OwnerObj) 
                            VALUES
                                   (@ObjName, @DepObj, @ColName, ' T', @OBJLEVEL, @OWNER_OBJ) ;
                        END;
                END;
            FETCH NEXT FROM db_cursor INTO @ObjName, @DepObj, @ColName;
        END;
    CLOSE db_cursor;
    DEALLOCATE db_cursor;
END;
-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

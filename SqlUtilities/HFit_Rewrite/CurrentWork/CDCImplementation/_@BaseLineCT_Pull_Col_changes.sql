
-- USE [KenticoCMS_Datamart_2];
GO
PRINT 'CREATING MART Object Var Procs ';
GO
--*****************************************************************************************
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'mart_GenColObjVarDcls') 
    BEGIN
        DROP PROCEDURE
             mart_GenColObjVarDcls;
    END;
GO
PRINT 'Creating mart_GenColObjVarDcls';
GO
CREATE PROCEDURE mart_GenColObjVarDcls (
       @InstanceName VARCHAR (250) 
     , @TblName VARCHAR (250) 
     , @DeclStmt VARCHAR (MAX) OUT) 
AS
BEGIN

/*---------------------------------------------------------------------------------------------------
    Author:	 W. Dale Miller
    Date:		 03/03/2016
    Purpose:	 Generate single declare statement of the variables needed to hold the Column Object IDs
    Model:	 NA
    USE:
		  DECLARE @r VARCHAR(max)
		  EXEC mart_GenColObjVarDcls 'KenticoCMS_3', 'CMS_User', @r OUTPUT
		  SELECT @r
*/

    BEGIN TRY
        DROP TABLE
             #TempDcls;
    END TRY
    BEGIN CATCH
        PRINT 'INIT #TempDcls';
    END CATCH;
    CREATE TABLE #TempDcls (
                 cols NVARCHAR (500)) ;
    DECLARE
         @MySql AS NVARCHAR (MAX) = '';
    SET @MySql = 'insert into #TempDcls select column_name from  ' + @InstanceName + '.information_schema.columns where table_name = ''' + @TblNAme + '''';
    PRINT @MySql;
    EXEC (@MySql) ;

    DECLARE
         @i AS BIGINT = 0
       , @ColDcl AS NVARCHAR (MAX) = 'Declare ' + CHAR (10) ;

    SELECT
           @ColDcl = @ColDcl + '     @' + cols + '_ObjID as int = 0,' + CHAR (10) 
    FROM #TempDcls
    WHERE
          cols NOT IN ('SVR' , 'HashCode' , 'DBNAME' , 'ItemID' , 'Action') AND cols NOT LIKE 'Surrogate%' AND cols NOT LIKE 'SYS_CHANGE%';

    SET @ColDcl = LTRIM (RTRIM (@ColDcl)) ;
    SET @i = LEN (@ColDcl) ;
    SET @ColDcl = SUBSTRING (@ColDcl , 1 , @i - 2) ;
    SET @ColDcl = @ColDcl + ';';

    SELECT
           @DeclStmt = @ColDcl;
END;

GO
--*****************************************************************************************
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'mart_GenPopulateObjVarSetStmts') 
    BEGIN
        DROP PROCEDURE
             mart_GenPopulateObjVarSetStmts;
    END;
GO
PRINT 'Creating mart_GenPopulateObjVarSetStmts';
GO

CREATE PROCEDURE mart_GenPopulateObjVarSetStmts (
       @InstanceName VARCHAR (250) 
     , @TblName VARCHAR (250) 
     , @RunStmt VARCHAR (MAX) OUT) 
AS
BEGIN

/*--------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
    Author:	 W. Dale Miller
    Date:		 03/03/2016
    Purpose:	 Generate the statements required to populate the Column Object variables
    Model:	 EXEC @HAPaperFlg_ObjID = proc_GetColumnID 'KenticoCMS_3' , 'CMS_User' , 'HAPaperFlg';
    USE:
	   DECLARE @r VARCHAR(max)
	   EXEC mart_GenPopulateObjVarSetStmts 'KenticoCMS_3', 'CMS_User', @r OUTPUT
	   SELECT @r
*/
    BEGIN TRY
        DROP TABLE
             #TempExecStmts;
    END TRY
    BEGIN CATCH
        PRINT 'INIT #TempExecStmts';
    END CATCH;
    CREATE TABLE #TempExecStmts (
                 cols NVARCHAR (500)) ;
    DECLARE
         @MySql AS NVARCHAR (MAX) = '';
    SET @MySql = 'insert into #TempExecStmts select column_name from  ' + @InstanceName + '.information_schema.columns where table_name = ''' + @TblNAme + '''';
    PRINT @MySql;
    EXEC (@MySql) ;

    DECLARE
         @i AS BIGINT = 0
       , @ExecStmt AS NVARCHAR (MAX) = '';

    SELECT
           @ExecStmt = @ExecStmt + 'EXEC @' + cols + '_ObjID  = proc_GetColumnID "' + @InstanceName + '", "' + @TblNAme + '", "' + cols + '" ; ' + CHAR (10) 
    FROM #TempExecStmts
    WHERE
          cols NOT IN ('SVR' , 'HashCode' , 'DBNAME' , 'ItemID' , 'Action') AND cols NOT LIKE 'Surrogate%' AND cols NOT LIKE 'SYS_CHANGE%';

    SET @ExecStmt = LTRIM (RTRIM (@ExecStmt)) ;
    PRINT @ExecStmt;
    --set @i = len(@ExecStmt)
    --set @ExecStmt = substring(@ExecStmt, 1, @i -2) ;
    SELECT
           @RunStmt = @ExecStmt;
END;

GO
--*****************************************************************************************
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'mart_GenViewObjVars') 
    BEGIN
        DROP PROCEDURE
             mart_GenViewObjVars;
    END;
GO
PRINT 'Creating mart_GenViewObjVars';
GO

CREATE PROCEDURE mart_GenViewObjVars (
       @InstanceName VARCHAR (250) 
     , @TblName VARCHAR (250) 
     , @ViewStmt VARCHAR (MAX) OUT) 
AS
BEGIN

/*------------------------------------------------------------------------------------------------------------
    Author:	 W. Dale Miller
    Date:		 03/03/2016
    Purpose:	 Generate the view statements
    Model:	 ,S.CT_HAPaperFlg = CHANGE_TRACKING_IS_COLUMN_IN_MASK (@HAPaperFlg_ObjID , CTE.SYS_CHANGE_COLUMNS) 
    USE:
	   DECLARE @r VARCHAR(max)
	   EXEC mart_GenViewObjVars 'KenticoCMS_3', 'CMS_User', @r OUTPUT
	   SELECT @r
*/

    BEGIN TRY
        DROP TABLE
             #TempViewObjVars;
    END TRY
    BEGIN CATCH
        PRINT 'INIT #TempViewObjVars';
    END CATCH;
    CREATE TABLE #TempViewObjVars (
                 cols NVARCHAR (500)) ;
    DECLARE
         @MySql AS NVARCHAR (MAX) = '';
    SET @MySql = 'insert into #TempViewObjVars select column_name from  ' + @InstanceName + '.information_schema.columns where table_name = ''' + @TblNAme + '''';
    PRINT @MySql;
    EXEC (@MySql) ;

    DECLARE
         @i AS BIGINT = 0
       , @QryStmt AS NVARCHAR (MAX) = ' ';

    SELECT
           @QryStmt = @QryStmt + '  ,S.CT_' + cols + ' = CHANGE_TRACKING_IS_COLUMN_IN_MASK (@' + cols + '_ObjID, CTE.SYS_CHANGE_COLUMNS) ' + CHAR (10) 
    FROM #TempViewObjVars
    WHERE
          cols NOT IN ('SVR' , 'HashCode' , 'DBNAME' , 'ItemID' , 'Action') AND cols NOT LIKE 'Surrogate%' AND cols NOT LIKE 'SYS_CHANGE%';

    SET @QryStmt = LTRIM (RTRIM (@QryStmt)) ;
    --set @i = len(@QryStmt)
    --set @QryStmt = substring(@QryStmt, 1, @i -2) ;
    SELECT
           @ViewStmt = @QryStmt;
END;
GO
--*****************************************************************************************
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'mart_GenViewObjCaseStmts') 
    BEGIN
        DROP PROCEDURE
             mart_GenViewObjCaseStmts;
    END;
GO
PRINT 'Creating mart_GenViewObjCaseStmts';
GO

CREATE PROCEDURE mart_GenViewObjCaseStmts (
       @InstanceName VARCHAR (250) 
     , @TblName VARCHAR (250) 
     , @ViewStmt VARCHAR (MAX) OUT) 
AS
BEGIN

/*------------------------------------------------------------------------------------------------------------
    Author:	 W. Dale Miller
    Date:		 03/03/2016
    Purpose:	 Generate the view statements
    Model:	 ,S.CT_HAPaperFlg = CHANGE_TRACKING_IS_COLUMN_IN_MASK (@HAPaperFlg_ObjID , CTE.SYS_CHANGE_COLUMNS) 
    USE:
	   DECLARE @r VARCHAR(max)
	   EXEC mart_GenViewObjCaseStmts 'KenticoCMS_3', 'CMS_User', @r OUTPUT
	   SELECT @r
*/

    BEGIN TRY
        DROP TABLE
             #TempViewObjVars;
    END TRY
    BEGIN CATCH
        PRINT 'INIT #TempViewObjVars';
    END CATCH;
    CREATE TABLE #TempViewObjVars (
                 cols NVARCHAR (500)) ;
    DECLARE
         @MySql AS NVARCHAR (MAX) = '';
    SET @MySql = 'insert into #TempViewObjVars select column_name from  ' + @InstanceName + '.information_schema.columns where table_name = ''' + @TblNAme + '''';
    PRINT @MySql;
    EXEC (@MySql) ;

    DECLARE
         @i AS BIGINT = 0
       , @QryStmt AS NVARCHAR (MAX) = ' ';

    SET @QryStmt = ',S.CT_RowDataUpdated = CASE ' + CHAR (10) ;
    SELECT
           @QryStmt = @QryStmt + '  WHEN CHANGE_TRACKING_IS_COLUMN_IN_MASK (@' + cols + '_ObjID, CTE.SYS_CHANGE_COLUMNS) = 1 ' + CHAR (10) + '        Then 1' + CHAR (10) 
    FROM #TempViewObjVars
    WHERE
          cols NOT IN ('SVR' , 'HashCode' , 'DBNAME' , 'ItemID' , 'Action') AND cols NOT LIKE 'Surrogate%' AND cols NOT LIKE 'SYS_CHANGE%';

    SET @QryStmt = LTRIM (RTRIM (@QryStmt)) ;
    SET @QryStmt = @QryStmt + '    ELSE 0' + CHAR (10) + '    END --Case';
    SELECT
           @ViewStmt = @QryStmt;
END;
GO
--*****************************************************************************************
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'mart_GenObjVarBitFlgAlterStmts') 
    BEGIN
        DROP PROCEDURE
             mart_GenObjVarBitFlgAlterStmts;
    END;
GO
PRINT 'Creating mart_GenObjVarBitFlgAlterStmts';
GO
CREATE PROCEDURE mart_GenObjVarBitFlgAlterStmts (
       @InstanceName VARCHAR (250) 
     , @TblName VARCHAR (250) 
     , @AlterStatememts VARCHAR (MAX) OUT) 
AS
BEGIN

/*--------------------------------------------------------------------------------------
    use KenticoCMS_Datamart_2
    Author:	 W. Dale Miller
    Date:		 03/03/2016
    Purpose:	 Generate the alter statements requried to add the FLG columns
    Model:	 alter table HFit_HealthAssesmentUserStarted add CT_HAPaperFlg bit null 
    USE:
	   DECLARE @r VARCHAR(max)
	   EXEC mart_GenObjVarBitFlgAlterStmts 'KenticoCMS_3', 'CMS_User', @r OUTPUT
	   SELECT @r
*/
    BEGIN TRY
        DROP TABLE
             #TempViewObjVars;
    END TRY
    BEGIN CATCH
        PRINT 'INIT #TempViewObjVars';
    END CATCH;
    CREATE TABLE #TempViewObjVars (
                 cols NVARCHAR (500)) ;
    DECLARE
         @MySql AS NVARCHAR (MAX) = ''
       , @BaseTbl AS NVARCHAR (500) = '' + @TblName;
    SET @MySql = 'insert into #TempViewObjVars select column_name from  ' + @InstanceName + '.information_schema.columns where table_name = ''' + @TblNAme + '''';
    PRINT @MySql;
    EXEC (@MySql) ;

    DECLARE
         @i AS BIGINT = 0
       , @AlterStmt AS NVARCHAR (MAX) = ' ';
    SELECT
           @AlterStmt = @AlterStmt + 'If not exists (Select table_name from information_schema.columns where table_name = ''' + @BaseTbl + ''' and column_name = ''' + 'CT_' + cols + ''')' + CHAR (10) + '      alter table ' + @BaseTbl + ' add CT_' + cols + ' bit null ' + CHAR (10) + '--GO' + CHAR (10) 
    FROM #TempViewObjVars
    WHERE
    cols NOT IN ('SVR' , 'HashCode' , 'DBNAME' , 'ItemID' , 'Action') AND cols NOT LIKE 'Surrogate%' AND cols NOT LIKE 'SYS_CHANGE%';
    SET @AlterStmt = @AlterStmt + 'If not exists (Select table_name from information_schema.columns where table_name = ''' + @BaseTbl + ''' and column_name = ''CT_RowDataUpdated'')' + CHAR (10) + '      alter table ' + @BaseTbl + ' add CT_RowDataUpdated bit null  default 1 ' + CHAR (10) + '--GO' + CHAR (10) ;
    SET @AlterStmt = LTRIM (RTRIM (@AlterStmt)) ;
    EXEC (@AlterStmt) ;
    SELECT
           @AlterStatememts = @AlterStmt;
END;
GO
--*****************************************************************************************
IF EXISTS (SELECT
                  name
           FROM sys.procedures
           WHERE
                  name = 'mart_DropObjVarAlterStmts') 
    BEGIN
        DROP PROCEDURE
             mart_DropObjVarAlterStmts;
    END;
GO
PRINT 'Creating mart_DropObjVarAlterStmts';
GO
CREATE PROCEDURE mart_DropObjVarAlterStmts (
       @TblName VARCHAR (250) 
     , @AlterStatememts VARCHAR (MAX) OUT) 
AS
BEGIN

/*-------------------------------------------------------------------------------------
    Author:	 W. Dale Miller
    Date:		 03/03/2016
    Purpose:	 Generate the alter statements requried to DROP the FLG columns
    Model:	 alter table HFit_HealthAssesmentUserStarted drop column CT_HAPaperFlg 
    USE:
	   DECLARE @r VARCHAR(max)
	   EXEC mart_DropObjVarAlterStmts 'HFit_HealthAssesmentUserStarted', @r OUTPUT
	   SELECT @r
*/
    DECLARE
     @i AS BIGINT = 0
   , @DropStmt AS NVARCHAR (MAX) = ' ';
    SELECT
           @DropStmt = @DropStmt + 'If exists (Select table_name from information_schema.columns where table_name = ''' + @TblName + ''' and column_name = ''' + column_name + ''')' + CHAR (10) + '     alter table ' + table_name + ' drop column ' + column_name + CHAR (10) + '--GO' + CHAR (10) 
    FROM information_schema.columns
    WHERE
           table_name = @TblName AND column_name LIKE 'CT_%';
    SET @DropStmt = LTRIM (RTRIM (@DropStmt)) ;
    --set @i = len(@DropStmt)
    --set @DropStmt = substring(@DropStmt, 1, @i -2) ;
    SELECT
           @AlterStatememts = @DropStmt;
END;
GO
PRINT 'MART Object Var Procs created';
GO
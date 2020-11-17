
GO

/*
select * from ActiveServers
delete from ActiveServers

select distinct isAzure +'|' + SvrName + '|' + DBName +'|' + isnull(UserID,'') + '|' + isnull(pwd,'') as [DATA]
from [dbo].[ActiveServers]

*/

IF EXISTS
(
    SELECT 1
    FROM sys.tables
    WHERE name = 'ActiveServers'
)
    DROP TABLE ActiveServers;
GO
BEGIN
    CREATE TABLE ActiveServers
    (GroupName NVARCHAR(50) NOT NULL
                            DEFAULT 'NA', 
     isAzure   CHAR(1) DEFAULT 'Y', 
     SvrName   NVARCHAR(150) NOT NULL, 
     DBName    NVARCHAR(150) NOT NULL, 
     UserID    NVARCHAR(60) NULL, 
     pwd       NVARCHAR(60) NULL, 
     [UID]     UNIQUEIDENTIFIER NOT NULL
                                DEFAULT NEWID()
    );
    CREATE INDEX pkActiveDatabases
    ON ActiveServers
    ([UID]
    );
    CREATE INDEX pi01ActiveDatabases
    ON ActiveServers
    (GroupName
    );
    CREATE INDEX pi02ActiveDatabases
    ON ActiveServers
    (SvrName, DBName
    );
END;
GO
IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'UTIL_ActiveDatabases'
)
    BEGIN
        DROP PROCEDURE UTIL_ActiveDatabases;
END;
GO
CREATE PROCEDURE UTIL_ActiveDatabases
(@GroupName NVARCHAR(50), 
 @SvrName   NVARCHAR(150), 
 @DBName    NVARCHAR(150), 
 @isAzure   CHAR(1)       = 'Y', 
 @UserID    NVARCHAR(60)  = NULL, 
 @pwd       NVARCHAR(60)  = NULL
)
AS
    BEGIN
        DECLARE @cnt INT= 0;
        SET @cnt =
        (
            SELECT COUNT(*)
            FROM ActiveServers
            WHERE GroupName = @GroupName
                  AND SvrName = @SvrName
                  AND DBName = @DBName
        );
        IF
           (@cnt = 1
           )
            BEGIN
                UPDATE ActiveServers
                  SET 
                      UserID = @Userid, 
                      pwd = @pwd, 
                      isAzure = @isAzure
                WHERE GroupName = @GroupName
                      AND SvrName = @SvrName
                      AND DBName = @DBName;
                PRINT 'UPDATING: ' + @GroupName + ' @ ' + @SvrName + '.' + @DBName;
        END;
            ELSE
            BEGIN
                PRINT 'ADDING: ' + @GroupName + ' @ ' + @SvrName + '.' + @DBName;
                INSERT INTO ActiveServers
                ( GroupName, 
                  SvrName, 
                  DBName, 
                  isAzure, 
                  UserID, 
                  pwd
                ) 
                VALUES
                (
                       @GroupName
                     , @SvrName
                     , @DBName
                     , @isAzure
                     , @UserID
                     , @pwd
                );
        END;
    END;
GO

/*
select * from ActiveServers ;
*/
DECLARE @currdb NVARCHAR(150)= DB_NAME();
IF
   (@currdb = 'DFINAnalytics'
   )
   print '********************** Executing EXEC UTIL_ActiveDatabases into ActiveServers **********************';
    BEGIN		
        DECLARE @GroupName NVARCHAR(50), @SvrName NVARCHAR(150), @DBName NVARCHAR(150), @isAzure CHAR(1), @UserID NVARCHAR(60), @pwd NVARCHAR(60);
        SET @GroupName = 'dfintest';
        SET @isAzure = 'Y';
        SET @SvrName = 'dfin.database.windows.net,1433';
        SET @DBName = 'TestAzureDB';
        SET @UserID = 'wmiller';
        SET @pwd = 'Junebug1';
        EXEC UTIL_ActiveDatabases 
             @GroupName, 
             @SvrName, 
             @DBName, 
             @isAzure, 
             @UserID, 
             @pwd;
        SET @GroupName = 'dfintest';
        SET @isAzure = 'Y';
        SET @SvrName = 'dfin.database.windows.net,1433';
        SET @DBName = 'AW_AZURE';
        SET @UserID = 'wmiller';
        SET @pwd = 'Junebug1';
        EXEC UTIL_ActiveDatabases 
             @GroupName, 
             @SvrName, 
             @DBName, 
             @isAzure, 
             @UserID, 
             @pwd;
        SET @GroupName = 'dfintest';
        SET @isAzure = 'N';
        SET @SvrName = 'ALIEN15';
        SET @DBName = 'TestDB';
        SET @UserID = NULL;
        SET @pwd = NULL;
        EXEC UTIL_ActiveDatabases 
             @GroupName, 
             @SvrName, 
             @DBName, 
             @isAzure, 
             @UserID, 
             @pwd;

/*SET @GroupName = 'dfintest';
SET @isAzure = 'N';
SET @SvrName = 'SVR2016';
SET @DBName = 'DFINAnalytics';
SET @UserID = 'sa';
SET @pwd = 'Junebug1';
EXEC UTIL_ActiveDatabases @GroupName, @SvrName, @DBName, @isAzure, @UserID, @pwd;*/

        SET @GroupName = 'dfintest';
        SET @isAzure = 'N';
        SET @SvrName = 'SVR2016';
        SET @DBName = 'DFS';
        SET @UserID = 'sa';
        SET @pwd = 'Junebug1';
        EXEC UTIL_ActiveDatabases 
             @GroupName, 
             @SvrName, 
             @DBName, 
             @isAzure, 
             @UserID, 
             @pwd;
        SET @GroupName = 'dfintest';
        SET @isAzure = 'N';
        SET @SvrName = 'SVR2016';
        SET @DBName = 'MstrData';
        SET @UserID = 'sa';
        SET @pwd = 'Junebug1';
        EXEC UTIL_ActiveDatabases 
             @GroupName, 
             @SvrName, 
             @DBName, 
             @isAzure, 
             @UserID, 
             @pwd;
        SET @GroupName = 'dfintest';
        SET @isAzure = 'N';
        SET @SvrName = 'SVR2016';
        SET @DBName = 'MstrPort';
        SET @UserID = 'sa';
        SET @pwd = 'Junebug1';
        EXEC UTIL_ActiveDatabases 
             @GroupName, 
             @SvrName, 
             @DBName, 
             @isAzure, 
             @UserID, 
             @pwd;
        SET @GroupName = 'dfintest';
        SET @isAzure = 'N';
        SET @SvrName = 'SVR2016';
        SET @DBName = 'TestXml';
        SET @UserID = 'sa';
        SET @pwd = 'Junebug1';
        EXEC UTIL_ActiveDatabases 
             @GroupName, 
             @SvrName, 
             @DBName, 
             @isAzure, 
             @UserID, 
             @pwd;
        SET @GroupName = 'dfintest';
        SET @isAzure = 'N';
        SET @SvrName = 'SVR2016';
        SET @DBName = 'AW_VMWARE';
        SET @UserID = 'sa';
        SET @pwd = 'Junebug1';
        EXEC UTIL_ActiveDatabases 
             @GroupName, 
             @SvrName, 
             @DBName, 
             @isAzure, 
             @UserID, 
             @pwd;

/*SET @GroupName = 'dfintest';
SET @isAzure = 'N';
SET @SvrName = 'ALIEN15';
SET @DBName = 'DFINAnalytics';
SET @UserID = NULL;
SET @pwd = NULL;
EXEC UTIL_ActiveDatabases @GroupName, @SvrName, @DBName, @isAzure, @UserID, @pwd;*/

        SET @GroupName = 'dfintest';
        SET @isAzure = 'N';
        SET @SvrName = 'ALIEN15';
        SET @DBName = 'PowerDatabase';
        SET @UserID = NULL;
        SET @pwd = NULL;
        EXEC UTIL_ActiveDatabases 
             @GroupName, 
             @SvrName, 
             @DBName, 
             @isAzure, 
             @UserID, 
             @pwd;
        SET @GroupName = 'dfintest';
        SET @isAzure = 'N';
        SET @SvrName = 'ALIEN15';
        SET @DBName = 'WDM';
        SET @UserID = NULL;
        SET @pwd = NULL;
        EXEC UTIL_ActiveDatabases 
             @GroupName, 
             @SvrName, 
             @DBName, 
             @isAzure, 
             @UserID, 
             @pwd;
        IF(@@SERVERNAME != 'ALIEN15'
           AND DB_NAME() != 'DFINAnalytics')
            BEGIN
                PRINT 'SERVER: Truncating ActiveServers ' + @@SERVERNAME + '.' + DB_NAME();
                TRUNCATE TABLE [dbo].[ActiveServers];
        END;
            ELSE
            BEGIN
                PRINT 'SERVER: NOT deleting ActiveServers ' + @@SERVERNAME + '.' + DB_NAME();
        END;
END;
GO
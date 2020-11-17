

GO
PRINT 'Executing create_EmailProfileAndUser.sql';
GO

BEGIN TRY
    CREATE USER MartEmailAdmin WITHOUT LOGIN WITH DEFAULT_SCHEMA = dbo;
    PRINT 'Created user MartEmailAdmin.';
END TRY
BEGIN CATCH
    PRINT 'MartEmailAdmin already exists in DB.';
END CATCH;
GO
BEGIN TRY
    CREATE ROLE [DatabaseMailUserRole] AUTHORIZATION [db_owner];
    PRINT 'Created role DatabaseMailUserRole.';
END TRY
BEGIN CATCH
    PRINT 'Role DatabaseMailUserRole already exists in DB.';
END CATCH;
GO
BEGIN TRY
    ALTER ROLE [DatabaseMailUserRole] ADD MEMBER [MartEmailAdmin];
    PRINT 'Altered role DatabaseMailUserRole.';
END TRY
BEGIN CATCH
    PRINT 'Altered role DatabaseMailUserRole successfully.';
END CATCH;
GO
PRINT 'Executed create_EmailProfileAndUser.sql';
GO

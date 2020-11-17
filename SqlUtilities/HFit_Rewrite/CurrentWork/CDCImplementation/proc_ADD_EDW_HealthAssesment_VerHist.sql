
GO
PRINT 'Executing proc_ADD_EDW_HealthAssesment_VerHist.sql';
GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_ADD_EDW_HealthAssesment_VerHist') 
    BEGIN
        DROP PROCEDURE proc_ADD_EDW_HealthAssesment_VerHist
    END;
GO
CREATE PROCEDURE proc_ADD_EDW_HealthAssesment_VerHist (@DBNAME nvarchar (254) 
                                                     , @CurrVersion bigint) 
AS
BEGIN
    INSERT INTO dbo.BASE_MART_EDW_HealthAssesment_VerHist (dbname
                                                         , VerNo
                                                         , CreateDate) 
    VALUES
           (@DBNAME, @CurrVersion, GETDATE ()) ;
END;
GO
PRINT 'Executed proc_ADD_EDW_HealthAssesment_VerHist.sql';
GO

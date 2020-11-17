
go
use KenticoCMS_DataMart

go
print 'executing proc_EDW_Create_HFIT_LKP_EDW_ALLOWED_MPI.SQL'
go

if exists (select name from sys.procedures where name = 'proc_EDW_Create_HFIT_LKP_EDW_ALLOWED_MPI')
    drop procedure proc_EDW_Create_HFIT_LKP_EDW_ALLOWED_MPI;

go
--WDMXX
-- exec proc_EDW_Create_HFIT_LKP_EDW_ALLOWED_MPI
CREATE PROCEDURE proc_EDW_Create_HFIT_LKP_EDW_ALLOWED_MPI
AS
BEGIN
    IF NOT EXISTS (SELECT
                          name
                          FROM sys.tables
                          WHERE name = 'HFIT_LKP_EDW_ALLOWED_MPI') 
        BEGIN
            PRINT 'Creating Lookup table HFIT_LKP_EDW_ALLOWED_MPI';
            CREATE TABLE dbo.HFIT_LKP_EDW_ALLOWED_MPI (
                         HFITUSERMPINUMBER bigint NULL
            ) 
            ON [PRIMARY];

            CREATE UNIQUE CLUSTERED INDEX PK_HFIT_LKP_EDW_ALLOWED_MPI ON dbo.HFIT_LKP_EDW_ALLOWED_MPI
            (
            HFITUSERMPINUMBER ASC
            )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY];

        END;

    truncate TABLE HFIT_LKP_EDW_ALLOWED_MPI;

    INSERT INTO HFIT_LKP_EDW_ALLOWED_MPI
    (
           HFITUSERMPINUMBER) 
    SELECT DISTINCT
           HFITUSERMPINUMBER
           FROM CMS_USERSETTINGS AS USERSETTINGS
           WHERE USERSETTINGS.HFITUSERMPINUMBER NOT IN (
                 SELECT
                        BASE_HFIT_LKP_EDW_REJECTMPI.REJECTMPICODE
                        FROM DBO.BASE_HFIT_LKP_EDW_REJECTMPI) 
             AND HFITUSERMPINUMBER IS NOT NULL
    AND HFITUSERMPINUMBER > 0 ;
END;

go
print 'Executed proc_EDW_Create_HFIT_LKP_EDW_ALLOWED_MPI.SQL'
go
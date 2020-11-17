
go 
print 'Executing create_HFITUSERMPINUMBER.sql'
go

IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'HFIT_LKP_EDW_ALLOWED_MPI') 
    BEGIN

        CREATE TABLE dbo.HFIT_LKP_EDW_ALLOWED_MPI (
                     HFITUSERMPINUMBER BIGINT NULL
        ) 
        ON [PRIMARY];

        CREATE CLUSTERED INDEX PKI_HFITUSERMPINUMBER ON HFIT_LKP_EDW_ALLOWED_MPI
        (
        HFITUSERMPINUMBER ASC
        );

    END; 
go 
print 'Executed create_HFITUSERMPINUMBER.sql'
go

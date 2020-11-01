
-- WDM 10-19-2020   15 days till a new administration
IF OBJECT_ID('df_DataSource_CreateDate', 'D') IS NULL
BEGIN
     ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [df_DataSource_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
END
	
go
if not exists (select 1 from INFORMATION_SCHEMA.columns where column_name = 'RowCreationDate' and table_name = 'datasource')
    alter table datasource add RowCreationDate datetime not null default getdate()
go

IF EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'PI_DS_RetentionExpirationDate'
)
    drop INDEX PI_DS_RetentionExpirationDate ON DataSource;
go
IF NOT EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = 'PI_DS_RetentionExpirationDate'
)
    CREATE INDEX PI_DS_RetentionExpirationDate ON DataSource(RetentionExpirationDate,RowCreationDate);
go

IF EXISTS
(
    SELECT 1
    FROM sys.procedures
    WHERE name = 'spUpdateRetention'
)
    DROP PROCEDURE spUpdateRetention;
GO

-- exec spUpdateRetention
CREATE PROCEDURE spUpdateRetention
AS
    BEGIN

		UPDATE DataSource SET CreateDate = getdate(), RetentionExpirationDate = DATEADD(YEAR,10,GETDATE())  WHERE RetentionExpirationDate < '01-01-1970';
		UPDATE DataSource SET RowCreationDate = getdate() WHERE RowCreationDate is null

        UPDATE DataSource
          SET 
              RetentionExpirationDate = DATEADD(year, R.RetentionUnits, getdate())
        FROM dbo.DataSource AS DS
             INNER JOIN dbo.Directory AS DIR ON DS.FileDirectory = DIR.FQN
             INNER JOIN [Retention] R ON R.RetentionCode = DIR.RetentionCode
        WHERE DS.RetentionExpirationDate < '01-01-1970';

        UPDATE DataSource
          SET 
              RetentionExpirationDate = DATEADD(year, R.RetentionUnits, getdate())
        FROM dbo.DataSource AS DS
             INNER JOIN dbo.Directory AS DIR ON DS.FileDirectory LIKE '%' + DIR.FQN + '%'
             INNER JOIN [Retention] R ON R.RetentionCode = DIR.RetentionCode
        WHERE DS.RetentionExpirationDate < '01-01-1970';
    END;
GO
EXEC spUpdateRetention;
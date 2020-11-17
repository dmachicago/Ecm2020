

GO
PRINT 'Executing fix_Tracker_Null_PKeys.sql';
GO

IF NOT EXISTS(SELECT CONSTRAINT_NAME
                FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                WHERE
                      CONSTRAINT_TYPE = 'PRIMARY KEY'
                  AND TABLE_NAME = 'FACT_HFit_TrackerInstance_Tracker'
                  AND TABLE_SCHEMA = 'dbo')
    BEGIN
        ALTER TABLE dbo.FACT_HFit_TrackerInstance_Tracker
        ADD CONSTRAINT FACT_HFit_TrackerInstance_Tracker_PKID PRIMARY KEY(SVR , DBNAME , UserID , ITemID , RowNUmber);

    END;

IF NOT EXISTS(SELECT CONSTRAINT_NAME
                FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
                WHERE
                      CONSTRAINT_TYPE = 'PRIMARY KEY'
                  AND TABLE_NAME = 'FACT_HFit_TrackerCardio'
                  AND TABLE_SCHEMA = 'dbo')
    BEGIN
        IF EXISTS(SELECT name
                    FROM sys.indexes
                    WHERE name = 'PI01_FACT_HFit_TrackerCardio')
            BEGIN
                DROP INDEX PI01_FACT_HFit_TrackerCardio ON dbo.FACT_HFit_TrackerCardio;
            END;

        IF EXISTS(SELECT name
                    FROM sys.indexes
                    WHERE name = 'PKEY_FACT_HFit_TrackerCardio')
            BEGIN
                DROP INDEX PKEY_FACT_HFit_TrackerCardio ON dbo.FACT_HFit_TrackerCardio WITH(ONLINE = OFF);
            END;

        ALTER TABLE dbo.FACT_HFit_TrackerCardio ALTER COLUMN ItemID int NOT NULL;
        ALTER TABLE dbo.FACT_HFit_TrackerCardio ALTER COLUMN UserID int NOT NULL;
        ALTER TABLE dbo.FACT_HFit_TrackerCardio ALTER COLUMN SVR nvarchar(100)NOT NULL;
        ALTER TABLE dbo.FACT_HFit_TrackerCardio ALTER COLUMN DBNAME nvarchar(100)NOT NULL;

        ALTER TABLE dbo.FACT_HFit_TrackerCardio
        ADD CONSTRAINT FACT_HFit_TrackerCardio_PKID PRIMARY KEY(SVR , DBNAME , UserID , ITemID);

        CREATE NONCLUSTERED INDEX PI01_FACT_HFit_TrackerCardio ON dbo.FACT_HFit_TrackerCardio(ClientCode ASC , SVR ASC , DBNAME ASC)INCLUDE(TrackerNameAggregateTable , ItemID)WITH(PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON , FILLFACTOR = 80)ON [PRIMARY];

        CREATE UNIQUE INDEX PKEY_FACT_HFit_TrackerCardio ON dbo.FACT_HFit_TrackerCardio(TrackerNameAggregateTable ASC , ItemID ASC , SVR ASC , DBNAME ASC)WITH(PAD_INDEX = OFF , STATISTICS_NORECOMPUTE = OFF , SORT_IN_TEMPDB = OFF , IGNORE_DUP_KEY = OFF , DROP_EXISTING = OFF , ONLINE = OFF , ALLOW_ROW_LOCKS = ON , ALLOW_PAGE_LOCKS = ON , FILLFACTOR = 80)ON [PRIMARY];

    END;

GO
PRINT 'Executed fix_Tracker_Null_PKeys.sql';
GO

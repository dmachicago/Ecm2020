
GO
-- drop table ActiveServers
DECLARE @db NVARCHAR(150)= '';
SET @db = DB_NAME();
print 'WORKING IN DATABASE: ' + @db ;
IF @db = 'DFINAnalytics'
    BEGIN
        IF NOT EXISTS
        (
            SELECT 1
            FROM sys.tables
            WHERE name = 'ActiveServers'
        )
            BEGIN
                CREATE TABLE [dbo].[ActiveServers]
                (GroupName nvarchar(50) not null,
				[isAzure] [CHAR](1) NOT NULL, 
                 [SvrName] [NVARCHAR](250) NOT NULL, 
                 [DBName]  [NVARCHAR](250) NOT NULL, 
                 [UserID]  [NVARCHAR](50) NULL, 
                 [pwd]     [NVARCHAR](50) NULL, 
                 [UID]     [UNIQUEIDENTIFIER] NOT NULL
                )
                ON [PRIMARY];
                ALTER TABLE [dbo].[ActiveServers]
                ADD CONSTRAINT [DF_ActiveServers_UID] DEFAULT(NEWID()) FOR [UID];
                CREATE UNIQUE INDEX pkActiveServers
                ON ActiveServers
                (GroupName, [UID]
                );
        END;
END;
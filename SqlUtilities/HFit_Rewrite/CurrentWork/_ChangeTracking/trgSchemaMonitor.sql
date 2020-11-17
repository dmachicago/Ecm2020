
GO
PRINT 'Creating TRIGGER trgSchemaMonitor.';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trgSchemaMonitor') 
    BEGIN
        PRINT 'DISABELING TRIGGER trgSchemaMonitor.';
        DECLARE @S nvarchar (200) ;
        SET @S = 'DISABLE TRIGGER trgSchemaMonitor ON DATABASE';
        EXEC (@S) ;
    END;
GO
PRINT 'Creating trgSchemaMonitor for #44945';
PRINT 'Dropping trgSchemaMonitor if it exists';
IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trgSchemaMonitor') 
    BEGIN
        PRINT 'Dropping trgSchemaMonitor';
        DROP TRIGGER
             trgSchemaMonitor ON DATABASE;
    END;
GO

--print('CHANGING to the instrument DB.');
--GO
--use instrument
--go

PRINT 'FQN: trgSchemaMonitor.SQL';
PRINT 'Processing trgSchemaMonitor.sql';
GO

--if exists(Select name from sys.triggers where name = 'trgSchemaMonitor')
--BEGIN
--	drop trigger trgSchemaMonitor ;
--	print('TRIGGER trgSchemaMonitor found and removed, continuing.');
--END
--go

IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE name = 'SchemaChangeMonitor') 
    BEGIN
        DROP TABLE
             dbo.SchemaChangeMonitor;
        PRINT 'Table SchemaChangeMonitor found, continuing.';
    END;
GO

SET ANSI_NULLS ON;
SET ANSI_PADDING ON;
SET ANSI_WARNINGS ON;
SET ARITHABORT ON;
SET CONCAT_NULL_YIELDS_NULL ON;
SET NUMERIC_ROUNDABORT OFF;
SET QUOTED_IDENTIFIER ON;

--WDM

SET QUOTED_IDENTIFIER ON;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'SchemaChangeMonitor') 
    BEGIN
        PRINT 'Creating table SchemaChangeMonitor.';

        --drop TABLE SchemaChangeMonitor 
        --go

        CREATE TABLE dbo.SchemaChangeMonitor (
                     PostTime datetime2 (7) NULL
                   , DB_User nvarchar (254) NULL
                   , IP_Address nvarchar (254) NULL
                   , CUR_User nvarchar (254) NULL
                   , Event nvarchar (254) NULL
                   , TSQL nvarchar (max) NULL
                   , OBJ nvarchar (254) NULL
                   , RowNbr int IDENTITY (1, 1) 
                                NOT NULL
                   , ServerName nvarchar (254) NULL) ;

    --ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];
    --ALTER TABLE dbo.SchemaChangeMonitor
    --ADD
    --			CONSTRAINT DF_SchemaChangeMonitor_ServerName DEFAULT @@servername FOR ServerName;
    --CREATE NONCLUSTERED INDEX PI_SchemaChangeMonitor ON dbo.SchemaChangeMonitor (OBJ ASC) ;
    --GRANT SELECT ON [dbo].[SchemaChangeMonitor] TO [platformuser_dev] ;
    --GRANT INSERT ON [dbo].[SchemaChangeMonitor] TO [platformuser_dev] ;
    --REVOKE DELETE ON [dbo].[SchemaChangeMonitor] TO [platformuser_dev] ;
    --REVOKE UPDATE ON [dbo].[SchemaChangeMonitor] TO [platformuser_dev] ;

    END;
GO
IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE name = 'SchemaMonitorObjectName') 
    BEGIN
        PRINT 'Table SchemaMonitorObjectName FOUND, continuing.';
    END;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'SchemaMonitorObjectName') 
    BEGIN
        PRINT 'Creating table SchemaMonitorObjectName';
        SET ANSI_NULLS ON;
        SET ANSI_PADDING ON;
        SET ANSI_WARNINGS ON;
        SET ARITHABORT ON;
        SET CONCAT_NULL_YIELDS_NULL ON;
        SET NUMERIC_ROUNDABORT OFF;
        SET QUOTED_IDENTIFIER ON;

        --drop TABLE dbo.SchemaMonitorObjectName
        --go

        CREATE TABLE dbo.SchemaMonitorObjectName (
                     ObjectName nvarchar (254) 
                   , ObjectType nvarchar (25)) ;
        CREATE UNIQUE CLUSTERED INDEX PKI_SchemaMonitorObjectName ON dbo.SchemaMonitorObjectName (ObjectName ASC, ObjectType ASC) ;
    END;
GO
IF EXISTS (SELECT
                  name
                  FROM sys.tables
                  WHERE name = 'SchemaMonitorObjectNotify') 
    BEGIN
        PRINT 'Table SchemaMonitorObjectNotify NOT FOUND, continuing.';
    END;
IF NOT EXISTS (SELECT
                      name
                      FROM sys.tables
                      WHERE name = 'SchemaMonitorObjectNotify') 
    BEGIN
        SET ANSI_NULLS ON;
        SET ANSI_PADDING ON;
        SET ANSI_WARNINGS ON;
        SET ARITHABORT ON;
        SET CONCAT_NULL_YIELDS_NULL ON;
        SET NUMERIC_ROUNDABORT OFF;
        SET QUOTED_IDENTIFIER ON;
        CREATE TABLE dbo.SchemaMonitorObjectNotify (
                     EmailAddr nvarchar (254)) ;
        CREATE UNIQUE CLUSTERED INDEX PCI_SchemaMonitorObjectNotify ON dbo.SchemaMonitorObjectNotify (EmailAddr ASC) ;

        --GRANT SELECT ON [dbo].SchemaMonitorObjectNotify TO [platformuser_dev] ;
        --GRANT INSERT ON [dbo].SchemaMonitorObjectNotify TO [platformuser_dev] ;
        --REVOKE DELETE ON [dbo].SchemaMonitorObjectNotify TO [platformuser_dev] ;
        --REVOKE UPDATE ON [dbo].SchemaMonitorObjectNotify TO [platformuser_dev] ;		

        INSERT INTO dbo.SchemaMonitorObjectNotify (
               EmailAddr) 
        VALUES
               (
               'wdalemiller@gmail.com') ;
    END;
GO
PRINT 'Creating view_SchemaChangeMonitor';
GO

--DROP TRIGGER trgSchemaMonitor on DATABASE
--disable TRIGGER trgSchemaMonitor on DATABASE
--enable TRIGGER trgSchemaMonitor on DATABASE

IF EXISTS (SELECT
                  name
                  FROM sys.views
                  WHERE name = 'view_SchemaChangeMonitor') 
    BEGIN
        PRINT 'Creating view_SchemaChangeMonitor, continuing';
        DROP VIEW
             view_SchemaChangeMonitor;
    END;
GO
CREATE VIEW view_SchemaChangeMonitor
AS SELECT
          PostTime
        , DB_User
        , IP_Address
        , CUR_User
        , Event
        , TSQL
        , OBJ
          FROM SchemaChangeMonitor;
GO

--GRANT SELECT ON  [dbo].view_SchemaChangeMonitor TO [platformuser_dev] ;
--GRANT INSERT ON  [Schema].[Table] TO [User] ;
--REVOKE DELETE ON  [Schema].[Table] TO [User] ;
--REVOKE UPDATE ON  [Schema].[Table] TO [User] ;

PRINT 'Created view_SchemaChangeMonitor';
GO
IF EXISTS (SELECT
                  name
                  FROM sys.triggers
                  WHERE name = 'trgSchemaMonitor') 
    BEGIN
        PRINT 'creating trgSchemaMonitor';
        DROP TRIGGER
             trgSchemaMonitor;
    END;
GO
PRINT 'Updating trgSchemaMonitor';
GO

--disable TRIGGER dbo.trgSchemaMonitor database

DECLARE @DB nvarchar (100) = (SELECT
                                     DB_NAME ());
PRINT 'Current DB: ' + @DB;
IF @DB = 'KenticoCMS_QA'
    BEGIN
        DECLARE @I int = 0;
        SET @i = (SELECT
                         COUNT (*) 
                         FROM SchemaMonitorObjectNotify
                         WHERE EmailAddr = 'John.Croft@hfit.com');
        IF @i = 0
            BEGIN
                INSERT INTO dbo.SchemaMonitorObjectNotify (
                       EmailAddr) 
                VALUES
                       (
                       'John.Croft@hfit.com') ;
            END;
        ELSE
            BEGIN
                PRINT 'Croft already exists in GREEN.';
            END;
        GRANT SELECT ON dbo.view_SchemaDiff TO JCroft;
        GRANT SELECT ON dbo.view_SchemaChangeMonitor TO JCroft;
        PRINT 'Added John Croft to the Schema Monitor system.';
    END;
GO
CREATE TRIGGER trgSchemaMonitor ON DATABASE
    FOR DDL_DATABASE_LEVEL_EVENTS
AS
BEGIN
    SET ANSI_NULLS ON;
    SET ANSI_PADDING ON;
    SET ANSI_WARNINGS ON;
    SET ARITHABORT ON;
    SET CONCAT_NULL_YIELDS_NULL ON;
    SET NUMERIC_ROUNDABORT OFF;
    SET QUOTED_IDENTIFIER ON;

    DECLARE @data xml;
    DECLARE @IPADDR nvarchar (254) ;
    DECLARE @CUR_User nvarchar (254) ;
    SET @CUR_User = SYSTEM_USER;
    SET @IPADDR = (SELECT
                          CONVERT (nvarchar (254) , CONNECTIONPROPERTY ('client_net_address')));
    SET @data = EVENTDATA () ;
    SET NOCOUNT ON;
    INSERT INTO SchemaChangeMonitor (
           PostTime
         , DB_User
         , IP_Address
         , CUR_User
         , OBJ
         , Event
         , TSQL) 
    VALUES
           (
           GETDATE () , CONVERT (nvarchar (254) , CURRENT_USER) , @IPADDR, @CUR_User, @data.value ('(/EVENT_INSTANCE/ObjectName)[1]', 'nvarchar(254)') , @data.value ('(/EVENT_INSTANCE/EventType)[1]', 'nvarchar(254)') , @data.value ('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(max)')) ;

    --THIS WILL DELETE records older than 90 days.
    --delete from SchemaChangeMonitor where PostTime < getdate() - 90 ;

    SET NOCOUNT OFF;
END;
GO

--grant execute on trgSchemaMonitor to PUBLIC ;
--go
--grant execute on sp_SchemaMonitorReport to platformuser_dev ; 
--GO

enable TRIGGER
 trgSchemaMonitor ON DATABASE;
PRINT '********************************************************************';
PRINT 'DATABASE trgSchemaMonitor HAS BEEN DISABLED       ******************';
PRINT '********************************************************************';
PRINT 'Processed trgSchemaMonitor.sql';

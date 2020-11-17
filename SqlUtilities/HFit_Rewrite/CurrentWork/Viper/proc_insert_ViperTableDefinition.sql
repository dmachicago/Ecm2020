
USE [Viper]
GO


select * from [dbo].[view_ClientMappings] 
select * from [ClientFileMaps]

ALTER TABLE [dbo].[ClientFileMaps] DROP CONSTRAINT [FK_ClientFileMaps_TableColID]
GO

ALTER TABLE [dbo].[ClientFileMaps] DROP CONSTRAINT [FK_ClientFileMaps_FileID]
GO

DROP TABLE [dbo].[ClientFileMaps]
GO

CREATE TABLE [dbo].[ClientFileMaps]
(
	[ClientMapID] [int] identity(1,1) NOT NULL,
	[FileID] [int] NOT NULL,
	[ColumnOrder] [int] NOT NULL,
	[TableColID] [int] NULL,
	[ColumnName] [varchar](150) NOT NULL,
	[Required] [bit] NOT NULL default 0,
	[LookUpKey] [bit] NOT NULL default 0,
	[LookUpKeyPosition] [int] NULL default 0,
	[FileTypeCode] [nvarchar](50) not NULL,
	[ClientID] [int] not NULL,
	[ColumnTypeID] [int] NULL,
	[FileTypeID] [int] NULL,
 CONSTRAINT [PK_ClientFileMaps] PRIMARY KEY CLUSTERED 
(
	[ClientMapID] ASC
)   WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
)   ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[ClientFileMaps]  WITH CHECK ADD  CONSTRAINT [FK_ClientFileMaps_FileID] FOREIGN KEY([FileID])
REFERENCES [dbo].[Files] ([FileID])
GO

ALTER TABLE [dbo].[ClientFileMaps] CHECK CONSTRAINT [FK_ClientFileMaps_FileID]
GO

ALTER TABLE [dbo].[ClientFileMaps]  WITH CHECK ADD  CONSTRAINT [FK_ClientFileMaps_TableColID] FOREIGN KEY([TableColID])
REFERENCES [dbo].[TableDefinitions] ([TableColID])
GO

ALTER TABLE [dbo].[ClientFileMaps] CHECK CONSTRAINT [FK_ClientFileMaps_TableColID]
GO



select * from information_schema.columns where column_name = 'FileTypeID'
select * from information_schema.columns where table_name = 'ClientFileMaps'

select * from ClientFileMaps
select * from ColumnTypes
select * from FileTypes
select * from TableDefinitions
select * from Files
select * from FileStructure

alter table ClientFileMaps add FileTypeCode nvarchar(50) null 
alter table ClientFileMaps add ClietID int null 
alter table ClientFileMaps add ColumnTypeID int null 
alter table ClientFileMaps add FileTypeID int null 
alter table ClientFileMaps alter column TableColID int null
alter table ClientFileMaps alter column ClientMapID not null


-- drop table FileStructure
-- select * from FileStructure
create table FileStructure
(
    ClientIdentifier nvarchar(50) not null,
    Column_Name nvarchar(100) not null,
    ColumnDataType nvarchar(50) not null,
    FileTypeCode nvarchar(50) not null,
    ClientID int not null,
    ColumnOrderNo int not null
)

alter table FileStructure add FileTypeCode nvarchar(50) null 
update FileStructure set FileTypeCode = 'ELIG'
GO
DROP INDEX [PKI_FileStructure] ON [dbo].[FileStructure]
go
CREATE UNIQUE NONCLUSTERED INDEX [PKI_FileStructure] ON [dbo].[FileStructure]
(
	[ClientIdentifier] ASC,
	[Column_Name] ASC ,
	FileTypeCode 
)
INCLUDE ( 	[ColumnDataType],
	[ColumnOrderNo]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO


select ShortName from Client as C join Files as F on C.ClientID = F.ClientID and F.[FileName] = 'PPT_TEST_Data.csv'

--alter table TableDefinitions add FileID int  NULL
--select * From files
--select * From TableDefinitions
GO
IF EXISTS (SELECT name
             FROM sys.views
             WHERE name = 'view_FullTableDefinition') 
    BEGIN
        DROP VIEW view_FullTableDefinition;
    END;
GO

-- select * from view_FullTableDefinition where ShortName = 'PPTLoad' and FileMask = 'PPT_TEST_Data' order by ColumnOrder
CREATE VIEW view_FullTableDefinition
AS SELECT TD.TableColID , 
          FT.FileTypeID , 
          TD.FileID , 
          TD.ColumnName , 
          TD.ColumnTypeID , 
          TD.ColumnLength , 
          TD.ColumnOrder , 
          TD.ClientID , 
          F.FileMask , 
          F.AddDate , 
          F.AddTime , 
          F.FileExtension , 
          F.[DateFormat] , 
          F.TimeFormat , 
          F.PickupLocation , 
          F.PostLocation , 
          F.ArchiveLocation , 
          F.HeaderRow , 
          F.FooterRow , 
          F.Delimiter , 
          F.ErrorThresholdPct , 
          F.[FileName] , 
          C.FullName , 
          C.ShortName , 
          C.Acctid , 
          C.SiteId , 
          CT.TypeSynonym , 
          CT.DataType
     FROM
          FILES AS F
          JOIN FileTypes AS FT
          ON F.FileTypeID = FT.FileTypeID
          JOIN TableDefinitions AS TD
          ON TD.FileID = F.FileID
          JOIN Client AS C
          ON C.ClientID = F.ClientID
          JOIN ColumnTypes AS CT
          ON TD.ColumnTypeID = CT.ColumnTypeID;

GO
IF EXISTS (SELECT name
             FROM sys.procedures
             WHERE name = 'proc_insert_ViperTableDefinition') 
    BEGIN
        DROP PROCEDURE proc_insert_ViperTableDefinition;
    END;
GO


-- drop procedure proc_insert_ViperTableDefinition
-- exec proc_insert_ViperTableDefinition 'PPTLoad', 'PPT_TEST_Data.csv', 'ClientID', 'int' , 0
CREATE PROCEDURE proc_insert_ViperTableDefinition (@ClientShortName AS nvarchar (100) , 
                                                   @FileName AS nvarchar (100) , 
										 @FileTypeCode AS nvarchar (50) , 										 
                                                   @ColumnName AS nvarchar (100) , 
                                                   @ColumnTypeSynonym AS nvarchar (100) , 
                                                   @ColumnOrder int = 0) 
AS
BEGIN

    --declare @ColumnName as nvarchar(100) = null ;
    --declare @ColumnOrder int = null ;
    DECLARE
          @ClientID int = NULL,
          @AcctID nvarchar (50) = NULL,
          @DataType nvarchar (50) = NULL,
          @ColumnTypeID int = NULL,
          @FileID int = NULL,
          @I int = NULL ;

    SET @FileID = (SELECT FileID
                     FROM Files
                     WHERE FileName = @FileName) ;
    SET @DataType = (SELECT DataType
                       FROM ColumnTypes
                       WHERE TypeSynonym = @ColumnTypeSynonym) ;
    SET @ColumnTypeID = (SELECT ColumnTypeID
                           FROM ColumnTypes
                           WHERE TypeSynonym = @ColumnTypeSynonym) ;
    SET @ClientID = (SELECT ClientID
                       FROM Client
                       WHERE ShortName = @ClientShortName) ;
    SET @AcctID = (SELECT Acctid
                     FROM Client
                     WHERE ShortName = @ClientShortName) ;

    SET @I = (SELECT COUNT (*)
                FROM dbo.TableDefinitions
                WHERE ClientID = @ClientID
                  AND FileID = @FileID
                  AND ColumnName = @ColumnName) ;

    IF @I > 0
        BEGIN
            PRINT 'Column ' + @ColumnName + ', within FTP File,' + @FileName + ', already defined - skipping.';
            RETURN;
        END;

    INSERT INTO dbo.ClientFileMaps (FileID, 
							 ColumnOrder , 
                                    TableColID ,                                     
                                    ColumnName , 
                                    FileTypeCode,
							 ClientID,
							 ColumnTypeID,
							 FileTypeID) 
    VALUES (@FileID, 
		  @ColumnOrder , 
            -1 , 
            @ColumnName , 
            @FileTypeCode,
		  @ClientID,
		  @ColumnTypeID,
		  @FileID) ;

END;
GO

--@ClientShortName AS nvarchar (100) , 
--@FileName AS nvarchar (100) , 
--@FileTypeCode AS nvarchar (50) , 										 
--@ColumnName AS nvarchar (100) , 
--@ColumnTypeSynonym AS nvarchar (100) , 
--@ColumnOrder int = 0

create index UK_ClientFileMaps on ClientFileMaps (

-- delete from TableDefinitions where FileID = 2
-- Select * from ClientFileMaps where FileID = 2
-- update TableDefinitions set FIleID = 2 where FileID is null 
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'PPTID' , 'int' , 0;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'ClientID' , 'int' , 1;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'ClientCode' , 'varchar' , 2;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'UserID' , 'int' , 3;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'IDCard' , 'datetime' , 4;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'FirstName' , 'varchar' , 5;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'LastName' , 'varchar' , 6;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'MiddleInit' , 'varchar' , 7;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'BirthDate' , 'datetime' , 8;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Gender' , 'varchar' , 9;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'AddressLine1' , 'varchar' , 10;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'AddressLine2' , 'varchar' , 11;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'City' , 'varchar' , 12;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'State' , 'varchar' , 13;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'PostalCode' , 'varchar' , 14;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'HomePhoneNum' , 'varchar' , 15;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'WorkPhoneNum' , 'varchar' , 16;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'MobilePhoneNum' , 'varchar' , 17;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'EmailAddress' , 'varchar' , 18;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'MPI' , 'int' , 19;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'MatchMethodCode' , 'varchar' , 20;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'SSN' , 'varchar' , 21;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'PrimarySSN' , 'varchar' , 22;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'HireDate' , 'datetime' , 23;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'TermDate' , 'datetime' , 24;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'RetireeDate' , 'datetime' , 25;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'PlanName' , 'varchar' , 26;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'PlanDescription' , 'varchar' , 27;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'PlanID' , 'varchar' , 28;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'PlanStartDate' , 'datetime' , 29;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'PlanEndDate' , 'datetime' , 30;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Company' , 'varchar' , 31;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'CompanyCd' , 'varchar' , 32;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'LocationName' , 'varchar' , 33;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'LocationCd' , 'varchar' , 34;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'DepartmentName' , 'varchar' , 35;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'DepartmentCd' , 'varchar' , 36;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'UnionCd' , 'varchar' , 37;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'BenefitGrp' , 'varchar' , 38;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'PayGrp' , 'varchar' , 39;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Division' , 'varchar' , 40;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'JobTitle' , 'varchar' , 41;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'JobCd' , 'varchar' , 42;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'TeamName' , 'varchar' , 43;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'MaritalStatus' , 'varchar' , 44;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'PersonType' , 'varchar' , 45;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'PersonStatus' , 'varchar' , 46;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'EmployeeType' , 'varchar' , 47;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'CoverageType' , 'varchar' , 48;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'EmployeeStatus' , 'varchar' , 49;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'PayCd' , 'varchar' , 50;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'BenefitStatus' , 'varchar' , 51;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'PlanType' , 'varchar' , 52;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'ClientPlatformElig' , 'varchar' , 53;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'ClientHRAElig' , 'varchar' , 54;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'ClientLMElig' , 'varchar' , 55;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'ClientIncentiveElig' , 'varchar' , 56;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'ClientCMElig' , 'varchar' , 57;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'ClientScreeningElig' , 'varchar' , 58;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Custom1' , 'varchar' , 59;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Custom2' , 'varchar' , 60;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Custom3' , 'varchar' , 61;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Custom4' , 'varchar' , 62;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Custom5' , 'varchar' , 63;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Custom6' , 'varchar' , 64;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Custom7' , 'varchar' , 65;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Custom8' , 'varchar' , 66;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Custom9' , 'varchar' , 67;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Custom10' , 'varchar' , 68;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Custom11' , 'varchar' , 69;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Custom12' , 'varchar' , 70;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Custom13' , 'varchar' , 71;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Custom14' , 'varchar' , 72;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Custom15' , 'varchar' , 73;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'ChangeStatusFlag' , 'varchar' , 74;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Last_Update_Dt' , 'varchar' , 75;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'FlatFileName' , 'varchar' , 76;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'ItemGUID' , 'UniqueIdentifier' , 77;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Hashbyte_Checksum' , 'varchar' , 78;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'Primary_MPI' , 'int' , 79;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'MPI_Relationship_Type' , 'varchar' , 80;
EXEC proc_insert_ViperTableDefinition 'PPTLoad' , 'PPT_TEST_Data.csv' , 'ELIG',  'WorkInd' , 'varchar' , 81;


select ColumnName,ColumnOrder,'1' as ID  from TableDefinitions where FileID = 2 --order by ColumnName
union
select ColumnName,ColumnOrder,'2' as ID  from TableDefinitions where FileID = 2  
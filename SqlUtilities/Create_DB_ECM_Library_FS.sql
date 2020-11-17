USE [ECM.Library.FS]
GO
/****** Object:  User [ECMLibrary]    Script Date: 10/15/2015 7:35:03 PM ******/
CREATE USER [ECMLibrary] FOR LOGIN [BUILTIN\Administrators]
GO
/****** Object:  User [ecmocr]    Script Date: 10/15/2015 7:35:04 PM ******/
CREATE USER [ecmocr] FOR LOGIN [ecmlibrary] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [ECMLibrary]
GO
ALTER ROLE [db_owner] ADD MEMBER [ecmocr]
GO
/****** Object:  FullTextCatalog [ftCatalog]    Script Date: 10/15/2015 7:35:04 PM ******/
CREATE FULLTEXT CATALOG [ftCatalog]WITH ACCENT_SENSITIVITY = OFF

GO
/****** Object:  FullTextCatalog [ftEmail]    Script Date: 10/15/2015 7:35:04 PM ******/
CREATE FULLTEXT CATALOG [ftEmail]WITH ACCENT_SENSITIVITY = OFF

GO
/****** Object:  FullTextCatalog [ftEmailCatalog]    Script Date: 10/15/2015 7:35:04 PM ******/
CREATE FULLTEXT CATALOG [ftEmailCatalog]WITH ACCENT_SENSITIVITY = OFF

GO
/****** Object:  StoredProcedure [dbo].[AppliedDbUpdatesSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
 * PROCEDURE: AppliedDbUpdatesSelProc 
 */

CREATE PROCEDURE [dbo].[AppliedDbUpdatesSelProc]
(
    @CompanyID     nvarchar(50),
    @FixID         nvarchar(50))
AS
BEGIN
    SELECT CompanyID,
           FixID,
           Status,
           ReturnMsg,
           ApplyDate
      FROM AppliedDbUpdates
     WHERE CompanyID = @CompanyID
       AND FixID     = @FixID

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[ArchiveFromSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[ArchiveFromSelProc]
(
    @FromEmailAddr     nvarchar(254),
    @SenderName        varchar(254),
    @UserID            varchar(25))
AS
BEGIN
    SELECT FromEmailAddr,
           SenderName,
           UserID
      FROM ArchiveFrom
     WHERE FromEmailAddr = @FromEmailAddr
       AND SenderName    = @SenderName
       AND UserID        = @UserID

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[ArchiveHistContentTypeSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: ArchiveHistContentTypeSelProc 
 */

CREATE PROCEDURE [dbo].[ArchiveHistContentTypeSelProc]
(
    @ArchiveID            nvarchar(50),
    @Directory            nvarchar(254),
    @FileType             nvarchar(50))
AS
BEGIN
    SELECT ArchiveID,
           Directory,
           FileType,
           NbrFilesArchived
      FROM ArchiveHistContentType
     WHERE ArchiveID = @ArchiveID
       AND Directory = @Directory
       AND FileType  = @FileType

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[ArchiveHistSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: ArchiveHistSelProc 
 */

CREATE PROCEDURE [dbo].[ArchiveHistSelProc]
(
    @ArchiveID            nvarchar(50))
AS
BEGIN
    SELECT ArchiveID,
           ArchiveDate,
           NbrFilesArchived,
           UserGuid
      FROM ArchiveHist
     WHERE ArchiveID = @ArchiveID

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[AtributeSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: AtributeSelProc 
 */

CREATE PROCEDURE [dbo].[AtributeSelProc]
(
    @AttributeName         nvarchar(50))
AS
BEGIN
    SELECT AttributeName,
           AttributeDataType,
           AttributeDesc
      FROM Atribute
     WHERE AttributeName = @AttributeName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[AttachmentTypeSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: AttachmentTypeSelProc 
 */

CREATE PROCEDURE [dbo].[AttachmentTypeSelProc]
(
    @AttachmentCode     nvarchar(50))
AS
BEGIN
    SELECT AttachmentCode,
           Description
      FROM AttachmentType
     WHERE AttachmentCode = @AttachmentCode

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[AttributeDatatypeSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: AttributeDatatypeSelProc 
 */

CREATE PROCEDURE [dbo].[AttributeDatatypeSelProc]
(
    @AttributeDataType     nvarchar(50))
AS
BEGIN
    SELECT AttributeDataType
      FROM AttributeDatatype
     WHERE AttributeDataType = @AttributeDataType

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[AttributesSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: AttributesSelProc 
 */

CREATE PROCEDURE [dbo].[AttributesSelProc]
(
    @AttributeName         nvarchar(50))
AS
BEGIN
    SELECT AttributeName,
           AttributeDataType,
           AttributeDesc,
           AssoApplication
      FROM Attributes
     WHERE AttributeName = @AttributeName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[AvailFileTypesSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[AvailFileTypesSelProc]
(
    @ExtCode     nvarchar(50))
AS
BEGIN
    SELECT ExtCode
      FROM AvailFileTypes
     WHERE ExtCode = @ExtCode

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[BusinessFunctionJargonSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: BusinessFunctionJargonSelProc 
 */

CREATE PROCEDURE [dbo].[BusinessFunctionJargonSelProc]
(
    @CorpFuncName            nvarchar(80),
    @WordID                  int,
    @JargonWords_tgtWord     nvarchar(50),
    @JargonCode              nvarchar(50),
    @CorpName                nvarchar(50))
AS
BEGIN
    SELECT CorpFuncName,
           WordID,
           JargonWords_tgtWord,
           JargonCode,
           CorpName
      FROM BusinessFunctionJargon
     WHERE CorpFuncName        = @CorpFuncName
       AND WordID              = @WordID
       AND JargonWords_tgtWord = @JargonWords_tgtWord
       AND JargonCode          = @JargonCode
       AND CorpName            = @CorpName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[BusinessJargonCodeSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: BusinessJargonCodeSelProc 
 */

CREATE PROCEDURE [dbo].[BusinessJargonCodeSelProc]
(
    @JargonCode     nvarchar(50))
AS
BEGIN
    SELECT JargonCode,
           JargonDesc
      FROM BusinessJargonCode
     WHERE JargonCode = @JargonCode

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[CaptureItemsSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: CaptureItemsSelProc 
 */

CREATE PROCEDURE [dbo].[CaptureItemsSelProc]
(
    @CaptureItemsCode     nvarchar(50))
AS
BEGIN
    SELECT CaptureItemsCode,
           CaptureItemsDesc,
           CreateDate
      FROM CaptureItems
     WHERE CaptureItemsCode = @CaptureItemsCode

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[CategorySelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
 * PROCEDURE: CategorySelProc 
 */

CREATE PROCEDURE [dbo].[CategorySelProc]
(
    @CategoryName     nvarchar(50))
AS
BEGIN
    SELECT CategoryName,
           Description
      FROM Category
     WHERE CategoryName = @CategoryName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[CompanySelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
 * PROCEDURE: CompanySelProc 
 */

CREATE PROCEDURE [dbo].[CompanySelProc]
(
    @CompanyID       nvarchar(50))
AS
BEGIN
    SELECT CompanyID,
           CompanyName
      FROM Company
     WHERE CompanyID = @CompanyID

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[ContactFromSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[ContactFromSelProc]
(
    @FromEmailAddr     nvarchar(254),
    @SenderName        varchar(254),
    @UserID            varchar(25))
AS
BEGIN
    SELECT FromEmailAddr,
           SenderName,
           UserID,
           Verified
      FROM ContactFrom
     WHERE FromEmailAddr = @FromEmailAddr
       AND SenderName    = @SenderName
       AND UserID        = @UserID

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[ContactsArchiveSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[ContactsArchiveSelProc]
(
    @Email1Address                    nvarchar(80),
    @FullName                         nvarchar(80),
    @UserID                           char(25))
AS
BEGIN
    SELECT Email1Address,
           FullName,
           UserID,
           Account,
           Anniversary,
           Application,
           AssistantName,
           AssistantTelephoneNumber,
           BillingInformation,
           Birthday,
           Business2TelephoneNumber,
           BusinessAddress,
           BusinessAddressCity,
           BusinessAddressCountry,
           BusinessAddressPostalCode,
           BusinessAddressPostOfficeBox,
           BusinessAddressState,
           BusinessAddressStreet,
           BusinessCardType,
           BusinessFaxNumber,
           BusinessHomePage,
           BusinessTelephoneNumber,
           CallbackTelephoneNumber,
           CarTelephoneNumber,
           Categories,
           Children,
           xClass,
           Companies,
           CompanyName,
           ComputerNetworkName,
           Conflicts,
           ConversationTopic,
           CreationTime,
           CustomerID,
           Department,
           Email1AddressType,
           Email1DisplayName,
           Email1EntryID,
           Email2Address,
           Email2AddressType,
           Email2DisplayName,
           Email2EntryID,
           Email3Address,
           Email3AddressType,
           Email3DisplayName,
           Email3EntryID,
           FileAs,
           FirstName,
           FTPSite,
           Gender,
           GovernmentIDNumber,
           Hobby,
           Home2TelephoneNumber,
           HomeAddress,
           HomeAddressCountry,
           HomeAddressPostalCode,
           HomeAddressPostOfficeBox,
           HomeAddressState,
           HomeAddressStreet,
           HomeFaxNumber,
           HomeTelephoneNumber,
           IMAddress,
           Importance,
           Initials,
           InternetFreeBusyAddress,
           JobTitle,
           Journal,
           Language,
           LastModificationTime,
           LastName,
           LastNameAndFirstName,
           MailingAddress,
           MailingAddressCity,
           MailingAddressCountry,
           MailingAddressPostalCode,
           MailingAddressPostOfficeBox,
           MailingAddressState,
           MailingAddressStreet,
           ManagerName,
           MiddleName,
           Mileage,
           MobileTelephoneNumber,
           NetMeetingAlias,
           NetMeetingServer,
           NickName,
           Title,
           Body,
           OfficeLocation,
           Subject
      FROM ContactsArchive
     WHERE Email1Address = @Email1Address
       AND FullName      = @FullName
       AND UserID        = @UserID

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[ContainerSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* 
 * PROCEDURE: ContainerSelProc 
 */

CREATE PROCEDURE [dbo].[ContainerSelProc]
(
    @ContainerGuid     uniqueidentifier)
AS
BEGIN
    SELECT ContainerGuid,
           ContainerName
      FROM Container
     WHERE ContainerGuid = @ContainerGuid

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[ContainerStorageSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: ContainerStorageSelProc 
 */

CREATE PROCEDURE [dbo].[ContainerStorageSelProc]
(
    @StoreCode         nvarchar(50),
    @ContainerType     nvarchar(25))
AS
BEGIN
    SELECT StoreCode,
           ContainerType
      FROM ContainerStorage
     WHERE StoreCode     = @StoreCode
       AND ContainerType = @ContainerType

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[ContentContainerSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* 
 * PROCEDURE: ContentContainerSelProc 
 */

CREATE PROCEDURE [dbo].[ContentContainerSelProc]
(
    @ContentTypeCode     nchar(1),
    @ContentGuid         nvarchar(50),
    @UserID              nvarchar(50))
AS
BEGIN
    SELECT ContentTypeCode,
           ContentGuid,
           UserID,
           ContainerName
      FROM ContentContainer
     WHERE ContentTypeCode = @ContentTypeCode
       AND ContentGuid     = @ContentGuid
       AND UserID          = @UserID

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[ContentUserSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* 
 * PROCEDURE: ContentUserSelProc 
 */

CREATE PROCEDURE [dbo].[ContentUserSelProc]
(
    @ContentTypeCode     nchar(1),
    @ContentGuid         nvarchar(50),
    @UserID              nvarchar(50))
AS
BEGIN
    SELECT ContentTypeCode,
           ContentGuid,
           UserID,
           NbrOccurances
      FROM ContentUser
     WHERE ContentTypeCode = @ContentTypeCode
       AND ContentGuid     = @ContentGuid
       AND UserID          = @UserID

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[ConvertedDocsSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: ConvertedDocsSelProc 
 */

CREATE PROCEDURE [dbo].[ConvertedDocsSelProc]
(
    @FQN          nvarchar(254),
    @CorpName     nvarchar(50))
AS
BEGIN
    SELECT FQN,
           FileName,
           XMLName,
           XMLDIr,
           FileDir,
           CorpName
      FROM ConvertedDocs
     WHERE FQN      = @FQN
       AND CorpName = @CorpName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[CoOwnerSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[CoOwnerSelProc]
(
    @RowId                   int)
AS
BEGIN
    SELECT RowId,
           CurrentOwnerUserID,
           CreateDate,
           PreviousOwnerUserID
      FROM CoOwner
     WHERE RowId = @RowId

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[CorpContainerSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: CorpContainerSelProc 
 */

CREATE PROCEDURE [dbo].[CorpContainerSelProc]
(
    @ContainerType     nvarchar(25),
    @CorpFuncName      nvarchar(80),
    @CorpName          nvarchar(50))
AS
BEGIN
    SELECT ContainerType,
           QtyDocCode,
           CorpFuncName,
           CorpName
      FROM CorpContainer
     WHERE ContainerType = @ContainerType
       AND CorpFuncName  = @CorpFuncName
       AND CorpName      = @CorpName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[CorpFunctionSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: CorpFunctionSelProc 
 */

CREATE PROCEDURE [dbo].[CorpFunctionSelProc]
(
    @CorpFuncName     nvarchar(80),
    @CorpName         nvarchar(50))
AS
BEGIN
    SELECT CorpFuncName,
           CorpFuncDesc,
           CreateDate,
           CorpName
      FROM CorpFunction
     WHERE CorpFuncName = @CorpFuncName
       AND CorpName     = @CorpName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[CorporationSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: CorporationSelProc 
 */

CREATE PROCEDURE [dbo].[CorporationSelProc]
(
    @CorpName     nvarchar(50))
AS
BEGIN
    SELECT CorpName
      FROM Corporation
     WHERE CorpName = @CorpName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[DatabasesSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DatabasesSelProc]
(
    @DB_ID           nvarchar(50))
AS
BEGIN
    SELECT DB_ID,
           DB_CONN_STR
      FROM Databases
     WHERE DB_ID = @DB_ID

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[DataOwnersSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DataOwnersSelProc]
(
    @SourceGuid                nvarchar(50),
    @UserID                    nvarchar(50),
    @GroupOwnerUserID          nvarchar(50),
    @GroupName                 nvarchar(80),
    @DataSourceOwnerUserID     nvarchar(50))
AS
BEGIN
    SELECT PrimaryOwner,
           OwnerTypeCode,
           FullAccess,
           ReadOnly,
           DeleteAccess,
           Searchable,
           SourceGuid,
           UserID,
           GroupOwnerUserID,
           GroupName,
           DataSourceOwnerUserID
      FROM DataOwners
     WHERE SourceGuid            = @SourceGuid
       AND UserID                = @UserID
       AND GroupOwnerUserID      = @GroupOwnerUserID
       AND GroupName             = @GroupName
       AND DataSourceOwnerUserID = @DataSourceOwnerUserID

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[DataSourceCheckOutSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DataSourceCheckOutSelProc]
(
    @SourceGuid                nvarchar(50),
    @DataSourceOwnerUserID     nvarchar(50),
    @CheckedOutByUserID        nvarchar(50))
AS
BEGIN
    SELECT SourceGuid,
           DataSourceOwnerUserID,
           CheckedOutByUserID,
           isReadOnly,
           isForUpdate,
           checkOutDate
      FROM DataSourceCheckOut
     WHERE SourceGuid            = @SourceGuid
       AND DataSourceOwnerUserID = @DataSourceOwnerUserID
       AND CheckedOutByUserID    = @CheckedOutByUserID

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[DataSourceRestoreHistorySelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DataSourceRestoreHistorySelProc]
(
    @SeqNo                     int)
AS
BEGIN
    SELECT SourceGuid,
           RestoredToMachine,
           RestoreUserName,
           RestoreUserID,
           RestoreUserDomain,
           RestoreDate,
           DataSourceOwnerUserID,
           SeqNo,
           TypeContentCode,
           CreateDate,
           DocumentName,
           FQN,
           VerifiedData
      FROM DataSourceRestoreHistory
     WHERE SeqNo = @SeqNo

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[DataSourceSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: DataSourceSelProc 
 */

CREATE PROCEDURE [dbo].[DataSourceSelProc]
(
    @SourceGuid         nvarchar(50))
AS
BEGIN
    SELECT SourceGuid,
           CreateDate,
           SourceName,
           SourceImage,
           SourceTypeCode
      FROM DataSource
     WHERE SourceGuid = @SourceGuid

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[DB_UpdatesSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
 * PROCEDURE: DB_UpdatesSelProc 
 */

CREATE PROCEDURE [dbo].[DB_UpdatesSelProc]
(
    @FixID              nvarchar(50))
AS
BEGIN
    SELECT SqlStmt,
           CreateDate,
           FixID,
           FixDescription,
           DBName,
           CompanyID,
           MachineName
      FROM DB_Updates
     WHERE FixID = @FixID

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[DeleteFromSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DeleteFromSelProc]
(
    @FromEmailAddr     nvarchar(254),
    @SenderName        varchar(254),
    @UserID            varchar(25))
AS
BEGIN
    SELECT FromEmailAddr,
           SenderName,
           UserID
      FROM DeleteFrom
     WHERE FromEmailAddr = @FromEmailAddr
       AND SenderName    = @SenderName
       AND UserID        = @UserID

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[DirectorySelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[DirectorySelProc]
(
    @UserID             nvarchar(50),
    @FQN                varchar(254))
AS
BEGIN
    SELECT UserID,
           IncludeSubDirs,
           FQN,
           DB_ID,
           VersionFiles,
           ckMetaData,
           ckPublic,
           ckDisableDir,
           QuickRefEntry,
           isSysDefault
      FROM Directory
     WHERE UserID = @UserID
       AND FQN    = @FQN

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[ECM_HivePerftest]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec [ECM_HivePerftest]

 CREATE PROCEDURE [dbo].[ECM_HivePerftest]
 AS
 DECLARE @result int
 BEGIN
 	declare @datetime1 datetime
 	declare @datetime2 datetime
 	declare @elapsed_seconds int
 	declare @elapsed_milliseconds int
 	declare @elapsed_time datetime
 	declare @elapsed_days int
 	declare @elapsed_hours int
 	declare @elapsed_minutes int
 	
 	declare @iCount int
 
 	select @datetime1 = GETDATE()
 
 	set @iCount = (select COUNT(*) from datasource where SourceGuid = 'xx')
 	set @iCount = (select COUNT(*) from Email where EmailGuid = 'xx')
 	set @iCount = (select COUNT(*) from EmailAttachment where EmailGuid = 'xx')
 	set @iCount = (select COUNT(*) from SourceAttribute where SourceGuid = 'xx')
 
 	select @datetime2 = GETDATE()
 
 	select @elapsed_time = @datetime2-@datetime1
 	select @elapsed_days = datediff(day,0,@elapsed_time)
 	select @elapsed_hours = datepart(hour,@elapsed_time)
 	select @elapsed_minutes = datepart(minute,@elapsed_time)
 	select @elapsed_seconds = datepart(second,@elapsed_time)
 	select @elapsed_milliseconds = datepart(millisecond,@elapsed_time)
 
 	declare @cr varchar(4), @cr2 varchar(4)
 	select @cr = char(13)+Char(10)
 	select @cr2 = @cr+@cr
 
 /*
 	print	'Elapsed Time: '+convert(varchar(30),@elapsed_time,121)+' ='+@cr+
 		'	 '+convert(varchar(30),@datetime2,121)+
 		' - '+convert(varchar(30),@datetime1,121)+@cr2
 
 	print	'Elapsed Time Parts:'+@cr+
 		' Days         = '+convert(varchar(20),@elapsed_days)+@cr+
 		' Hours        = '+convert(varchar(20),@elapsed_hours)+@cr+
 		' Minutess     = '+convert(varchar(20),@elapsed_minutes)+@cr+
 		' Secondss     = '+convert(varchar(20),@elapsed_seconds)+@cr+
 		' Milliseconds = '+convert(varchar(20), @elapsed_milliseconds)+@cr2+@cr2
 
 		SET @result = @elapsed_milliseconds
 */
 
 	SELECT @elapsed_milliseconds AS Result
 
 END


GO
/****** Object:  StoredProcedure [dbo].[ECM_HivePerftestV2]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ECM_HivePerftestV2]
  (@MilliSeconds int output)
  AS
  BEGIN
  	declare @datetime1 datetime
  	declare @datetime2 datetime
  	declare @elapsed_seconds int
  	declare @elapsed_milliseconds int
  	declare @elapsed_time datetime
  	declare @elapsed_days int
  	declare @elapsed_hours int
  	declare @elapsed_minutes int
  	
  	declare @iCount int
  
  	select @datetime1 = GETDATE()
  
  	set @iCount = (select COUNT(*) from datasource where SourceGuid = 'xx')
  	set @iCount = (select COUNT(*) from Email where EmailGuid = 'xx')
  	set @iCount = (select COUNT(*) from EmailAttachment where EmailGuid = 'xx')
  	set @iCount = (select COUNT(*) from SourceAttribute where SourceGuid = 'xx')
  
  	select @datetime2 = GETDATE()
  
  	select @elapsed_time = @datetime2-@datetime1
  	select @elapsed_days = datediff(day,0,@elapsed_time)
  	select @elapsed_hours = datepart(hour,@elapsed_time)
  	select @elapsed_minutes = datepart(minute,@elapsed_time)
  	select @elapsed_seconds = datepart(second,@elapsed_time)
  	select @elapsed_milliseconds = datepart(millisecond,@elapsed_time)
  
  	declare @cr varchar(4), @cr2 varchar(4)
  	select @cr = char(13)+Char(10)
  	select @cr2 = @cr+@cr
  
  /*
  	print	'Elapsed Time: '+convert(varchar(30),@elapsed_time,121)+' ='+@cr+
  		'	 '+convert(varchar(30),@datetime2,121)+
  		' - '+convert(varchar(30),@datetime1,121)+@cr2
  
  	print	'Elapsed Time Parts:'+@cr+
  		' Days         = '+convert(varchar(20),@elapsed_days)+@cr+
  		' Hours        = '+convert(varchar(20),@elapsed_hours)+@cr+
  		' Minutess     = '+convert(varchar(20),@elapsed_minutes)+@cr+
  		' Secondss     = '+convert(varchar(20),@elapsed_seconds)+@cr+
  		' Milliseconds = '+convert(varchar(20), @elapsed_milliseconds)+@cr2+@cr2
  
  		SET @result = @elapsed_milliseconds
  */
  
  	SELECT @MilliSeconds = @elapsed_milliseconds 
  
  END


GO
/****** Object:  StoredProcedure [dbo].[ECM_spaceused]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[ECM_spaceused] --- 2003/05/19 14:00
@objname nvarchar(776) = null,		-- The object we want size on.
@updateusage varchar(5) = false		-- Param. for specifying that
					-- usage info. should be updated.
as

declare @id	int			-- The object id that takes up space
		,@type	character(2) -- The object type.
		,@pages	bigint			-- Working variable for size calc.
		,@dbname sysname
		,@dbsize bigint
		,@logsize bigint
		,@reservedpages  bigint
		,@usedpages  bigint
		,@rowCount bigint

/*
**  Check to see if user wants usages updated.
*/

if @updateusage is not null
	begin
		select @updateusage=lower(@updateusage)

		if @updateusage not in ('true','false')
			begin
				raiserror(15143,-1,-1,@updateusage)
				return(1)
			end
	end
/*
**  Check to see that the objname is local.
*/
if @objname IS NOT NULL
begin

	select @dbname = parsename(@objname, 3)

	if @dbname is not null and @dbname <> db_name()
		begin
			raiserror(15250,-1,-1)
			return (1)
		end

	if @dbname is null
		select @dbname = db_name()

	/*
	**  Try to find the object.
	*/
	SELECT @id = object_id, @type = type FROM sys.objects WHERE object_id = object_id(@objname)

	-- Translate @id to internal-table for queue
	IF @type = 'SQ'
		SELECT @id = object_id FROM sys.internal_tables WHERE parent_id = @id and internal_type = 201 --ITT_ServiceQueue

	/*
	**  Does the object exist?
	*/
	if @id is null
		begin
			raiserror(15009,-1,-1,@objname,@dbname)
			return (1)
		end

	-- Is it a table, view or queue?
	IF @type NOT IN ('U ','S ','V ','SQ','IT')
	begin
		raiserror(15234,-1,-1)
		return (1)
	end
end

/*
**  Update usages if user specified to do so.
*/

if @updateusage = 'true'
	begin
		if @objname is null
			dbcc updateusage(0) with no_infomsgs
		else
			dbcc updateusage(0,@objname) with no_infomsgs
		print ' '
	end

set nocount on

/*
**  If @id is null, then we want summary data.
*/
if @id is null
begin
	select @dbsize = sum(convert(bigint,case when status & 64 = 0 then size else 0 end))
		, @logsize = sum(convert(bigint,case when status & 64 <> 0 then size else 0 end))
		from dbo.sysfiles

	select @reservedpages = sum(a.total_pages),
		@usedpages = sum(a.used_pages),
		@pages = sum(
				CASE
					-- XML-Index and FT-Index internal tables are not considered `data`, but is part of `index_size`
					When it.internal_type IN (202,204,211,212,213,214,215,216) Then 0
					When a.type <> 1 Then a.used_pages
					When p.index_id < 2 Then a.data_pages
					Else 0
				END
			)
	from sys.partitions p join sys.allocation_units a on p.partition_id = a.container_id
		left join sys.internal_tables it on p.object_id = it.object_id

	/* unallocated space could not be negative */
	--select 
	--	database_name = db_name(),
	--	database_size = ltrim(str((convert (dec (15,2),@dbsize) + convert (dec (15,2),@logsize)) 
	--		* 8192 / 1048576,15,2) + ' MB'),
	--	'unallocated space' = ltrim(str((case when @dbsize >= @reservedpages then
	--		(convert (dec (15,2),@dbsize) - convert (dec (15,2),@reservedpages)) 
	--		* 8192 / 1048576 else 0 end),15,2) + ' MB')

	/*
	**  Now calculate the summary data.
	**  reserved: sum(reserved) where indid in (0, 1, 255)
	** data: sum(data_pages) + sum(text_used)
	** index: sum(used) where indid in (0, 1, 255) - data
	** unused: sum(reserved) - sum(used) where indid in (0, 1, 255)
	*/
	--select
	--	reserved = ltrim(str(@reservedpages * 8192 / 1024.,15,0) + ' KB'),
	--	data = ltrim(str(@pages * 8192 / 1024.,15,0) + ' KB'),
	--	index_size = ltrim(str((@usedpages - @pages) * 8192 / 1024.,15,0) + ' KB'),
	--	unused = ltrim(str((@reservedpages - @usedpages) * 8192 / 1024.,15,0) + ' KB')
end

/*
**  We want a particular object.
*/
else
begin
	/*
	** Now calculate the summary data. 
	*  Note that LOB Data and Row-overflow Data are counted as Data Pages.
	*/
	SELECT 
		@reservedpages = SUM (reserved_page_count),
		@usedpages = SUM (used_page_count),
		@pages = SUM (
			CASE
				WHEN (index_id < 2) THEN (in_row_data_page_count + lob_used_page_count + row_overflow_used_page_count)
				ELSE lob_used_page_count + row_overflow_used_page_count
			END
			),
		@rowCount = SUM (
			CASE
				WHEN (index_id < 2) THEN row_count
				ELSE 0
			END
			)
	FROM sys.dm_db_partition_stats
	WHERE object_id = @id;

	/*
	** Check if table has XML Indexes or Fulltext Indexes which use internal tables tied to this table
	*/
	IF (SELECT count(*) FROM sys.internal_tables WHERE parent_id = @id AND internal_type IN (202,204,211,212,213,214,215,216)) > 0 
	BEGIN
		/*
		**  Now calculate the summary data. Row counts in these internal tables don't 
		**  contribute towards row count of original table.
		*/
		SELECT 
			@reservedpages = @reservedpages + sum(reserved_page_count),
			@usedpages = @usedpages + sum(used_page_count)
		FROM sys.dm_db_partition_stats p, sys.internal_tables it
		WHERE it.parent_id = @id AND it.internal_type IN (202,204,211,212,213,214,215,216) AND p.object_id = it.object_id;
	END

	SELECT 
		name = OBJECT_NAME (@id),
		rows = convert (char(11), @rowCount),
		reserved = LTRIM (STR (@reservedpages * 8, 15, 0) + ' KB'),
		data = LTRIM (STR (@pages * 8, 15, 0) + ' KB'),
		index_size = LTRIM (STR ((CASE WHEN @usedpages > @pages THEN (@usedpages - @pages) ELSE 0 END) * 8, 15, 0) + ' KB'),
		unused = LTRIM (STR ((CASE WHEN @reservedpages > @usedpages THEN (@reservedpages - @usedpages) ELSE 0 END) * 8, 15, 0) + ' KB')

	
end

Select 
	database_name = db_name(),
	database_size = ltrim(str((convert (dec (15,2),@dbsize) + convert (dec (15,2),@logsize)) 
			* 8192 / 1048576,15,2) + ' MB'),
	index_size = LTRIM (STR ((CASE WHEN @usedpages > @pages THEN (@usedpages - @pages) ELSE 0 END) * 8, 15, 0) + ' KB')


return (0) -- sp_spaceused




GO
/****** Object:  StoredProcedure [dbo].[EcmIssueSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
 * PROCEDURE: EcmIssueSelProc 
 */

CREATE PROCEDURE [dbo].[EcmIssueSelProc]
(
    @IssueTitle           nvarchar(250))
AS
BEGIN
    SELECT IssueTitle,
           IssueDescription,
           CreationDate,
           StatusCode,
           SeverityCode,
           CategoryName,
           EMail
      FROM EcmIssue
     WHERE IssueTitle = @IssueTitle

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[EcmResponseSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
 * PROCEDURE: EcmResponseSelProc 
 */

CREATE PROCEDURE [dbo].[EcmResponseSelProc]
(
    @IssueTitle      nvarchar(250),
    @ResponseID      int)
AS
BEGIN
    SELECT IssueTitle,
           Response,
           CreateDate,
           LastModDate,
           ResponseID
      FROM EcmResponse
     WHERE IssueTitle = @IssueTitle
       AND ResponseID = @ResponseID

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[EcmUserSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
 * PROCEDURE: EcmUserSelProc 
 */

CREATE PROCEDURE [dbo].[EcmUserSelProc]
(
    @EMail           nvarchar(50))
AS
BEGIN
    SELECT EMail,
           PhoneNumber,
           YourName,
           YourCompany,
           PassWord,
           Authority,
           CreateDate,
           CompanyID,
           LastUpdate
      FROM EcmUser
     WHERE EMail = @EMail

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[EmailArchParmsSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[EmailArchParmsSelProc]
(
    @UserID                 nvarchar(50),
    @FolderName             nvarchar(254))
AS
BEGIN
    SELECT UserID,
           ArchiveEmails,
           RemoveAfterArchive,
           SetAsDefaultFolder,
           ArchiveAfterXDays,
           RemoveAfterXDays,
           RemoveXDays,
           ArchiveXDays,
           FolderName,
           DB_ID,
           ArchiveOnlyIfRead
      FROM EmailArchParms
     WHERE UserID     = @UserID
       AND FolderName = @FolderName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[EmailImageSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: EmailImageSelProc 
 */

CREATE PROCEDURE [dbo].[EmailImageSelProc]
(
    @EmailGuid         nvarchar(50),
    @ImageTypeCode     nvarchar(50))
AS
BEGIN
    SELECT emailImage,
           EmailGuid,
           ImageTypeCode
      FROM EmailImage
     WHERE EmailGuid     = @EmailGuid
       AND ImageTypeCode = @ImageTypeCode

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[EmailImageTypeSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: EmailImageTypeSelProc 
 */

CREATE PROCEDURE [dbo].[EmailImageTypeSelProc]
(
    @ImageTypeCode     nvarchar(50))
AS
BEGIN
    SELECT ImageTypeCode,
           Description
      FROM EmailImageType
     WHERE ImageTypeCode = @ImageTypeCode

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[EmailSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[EmailSelProc]
(
    @EmailGuid                   nvarchar(50))
AS
BEGIN
    SELECT EmailGuid,
           SUBJECT,
           SentTO,
           Body,
           Bcc,
           BillingInformation,
           CC,
           Companies,
           CreationTime,
           ReadReceiptRequested,
           ReceivedByName,
           ReceivedTime,
           AllRecipients,
           UserID,
           SenderEmailAddress,
           SenderName,
           Sensitivity,
           SentOn,
           MsgSize,
           DeferredDeliveryTime,
           EntryID,
           ExpiryTime,
           LastModificationTime,
           EmailImage,
           Accounts,
           RowID,
           ShortSubj,
           SourceTypeCode,
           OriginalFolder,
           StoreID,
           isPublic,
           RetentionExpirationDate,
           IsPublicPreviousState,
           isAvailable,
           CurrMailFolderID,
           isPerm,
           isMaster,
           CreationDate
      FROM Email
     WHERE EmailGuid = @EmailGuid

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[ExcludedFilesSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[ExcludedFilesSelProc]
(
    @UserID      nvarchar(50),
    @ExtCode     nvarchar(50),
    @FQN         varchar(254))
AS
BEGIN
    SELECT UserID,
           ExtCode,
           FQN
      FROM ExcludedFiles
     WHERE UserID  = @UserID
       AND ExtCode = @ExtCode
       AND FQN     = @FQN

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[ExcludeFromSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[ExcludeFromSelProc]
(
    @FromEmailAddr     nvarchar(254),
    @SenderName        varchar(254),
    @UserID            varchar(25))
AS
BEGIN
    SELECT FromEmailAddr,
           SenderName,
           UserID
      FROM ExcludeFrom
     WHERE FromEmailAddr = @FromEmailAddr
       AND SenderName    = @SenderName
       AND UserID        = @UserID

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[funcEcmUpdateDB]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create Procedure [dbo].[funcEcmUpdateDB]
	@pSql nVarChar(max)
AS
Exec sp_executesql @pSql


GO
/****** Object:  StoredProcedure [dbo].[FUncSkipWordsSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: FUncSkipWordsSelProc 
 */

CREATE PROCEDURE [dbo].[FUncSkipWordsSelProc]
(
    @CorpFuncName     nvarchar(80),
    @tgtWord          nvarchar(18),
    @CorpName         nvarchar(50))
AS
BEGIN
    SELECT CorpFuncName,
           tgtWord,
           CorpName
      FROM FUncSkipWords
     WHERE CorpFuncName = @CorpFuncName
       AND tgtWord      = @tgtWord
       AND CorpName     = @CorpName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[FunctionProdJargonSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: FunctionProdJargonSelProc 
 */

CREATE PROCEDURE [dbo].[FunctionProdJargonSelProc]
(
    @CorpFuncName       nvarchar(80),
    @JargonCode         nvarchar(50),
    @CorpName           nvarchar(50))
AS
BEGIN
    SELECT KeyFlag,
           RepeatDataCode,
           CorpFuncName,
           JargonCode,
           CorpName
      FROM FunctionProdJargon
     WHERE CorpFuncName = @CorpFuncName
       AND JargonCode   = @JargonCode
       AND CorpName     = @CorpName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[GetAllTableSizes]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GetAllTableSizes]
AS
/*
    Obtains spaced used data for ALL user tables in the database
*/
DECLARE @TableName VARCHAR(100)    --For storing values in the cursor

--Cursor to get the name of all user tables from the sysobjects listing
DECLARE tableCursor CURSOR
FOR 
select [name]
from dbo.sysobjects 
where  OBJECTPROPERTY(id, N'IsUserTable') = 1
FOR READ ONLY

--A procedure level temp table to store the results
CREATE TABLE #TempTable
(
    tableName varchar(100),
    numberofRows varchar(100),
    reservedSize varchar(50),
    dataSize varchar(50),
    indexSize varchar(50),
    unusedSize varchar(50)
)

--Open the cursor
OPEN tableCursor

--Get the first table name from the cursor
FETCH NEXT FROM tableCursor INTO @TableName

--Loop until the cursor was not able to fetch
WHILE (@@Fetch_Status >= 0)
BEGIN
    --Dump the results of the sp_spaceused query to the temp table
    INSERT  #TempTable
        EXEC sp_spaceused @TableName

    --Get the next table name
    FETCH NEXT FROM tableCursor INTO @TableName
END

--Get rid of the cursor
CLOSE tableCursor
DEALLOCATE tableCursor

--Select all records so we can use the reults
SELECT * 
FROM #TempTable

--Final cleanup!
DROP TABLE #TempTable


GO
/****** Object:  StoredProcedure [dbo].[gp_ActiveSearchGuids_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ActiveSearchGuids_Delete]
(
	@UserID nvarchar(50),
	@DocGuid nvarchar(50)
)
AS
/*
** Delete a row from the ActiveSearchGuids table
*/
DELETE FROM [ActiveSearchGuids] WHERE [UserID] = @UserID AND [DocGuid] = @DocGuid

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the ActiveSearchGuids table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_ActiveSearchGuids_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ActiveSearchGuids_Insert]
(
	@UserID nvarchar(50),
	@DocGuid nvarchar(50)
)
AS
/*
** Add a row to the ActiveSearchGuids table
*/

INSERT INTO [ActiveSearchGuids]
( [UserID], [DocGuid]
)
VALUES
( @UserID, @DocGuid
)

/*
** Select the new row
*/
SELECT
	gv_ActiveSearchGuids.*
FROM
	gv_ActiveSearchGuids
WHERE
	[UserID] = @UserID
	AND [DocGuid] = @DocGuid


GO
/****** Object:  StoredProcedure [dbo].[gp_ActiveSearchGuids_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ActiveSearchGuids_SelectAll]
AS
/*
** Select all rows from the ActiveSearchGuids table
*/

SELECT 
	gv_ActiveSearchGuids.*
FROM
	gv_ActiveSearchGuids
ORDER BY
	[UserID],
	[DocGuid]


GO
/****** Object:  StoredProcedure [dbo].[gp_ActiveSearchGuids_SelectByUserIDAndDocGuid]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ActiveSearchGuids_SelectByUserIDAndDocGuid]
(
	@UserID nvarchar(50),
	@DocGuid nvarchar(50)
)
AS
/*
** Select a row from the ActiveSearchGuids table by primary key
*/

SELECT 
	gv_ActiveSearchGuids.*
FROM
	gv_ActiveSearchGuids WHERE [UserID] = @UserID AND [DocGuid] = @DocGuid


GO
/****** Object:  StoredProcedure [dbo].[gp_ActiveSearchGuids_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ActiveSearchGuids_Update]
(
	@UserIDOriginal nvarchar(50), 
	@UserID nvarchar(50),
	@DocGuidOriginal nvarchar(50), 
	@DocGuid nvarchar(50),
	@SeqNO int
)
AS
/*
** Update a row in the ActiveSearchGuids table using the primary key
*/
UPDATE [ActiveSearchGuids] SET [UserID] = @UserID, [DocGuid] = @DocGuid WHERE [UserID] = @UserIDOriginal AND [DocGuid] = @DocGuidOriginal


/*
** Select the updated row
*/
SELECT
	gv_ActiveSearchGuids.*
FROM
	gv_ActiveSearchGuids
WHERE
	[UserID] = @UserIDOriginal
	AND [DocGuid] = @DocGuidOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveFrom_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveFrom_Delete]
(
	@FromEmailAddr nvarchar(254),
	@SenderName varchar(254),
	@UserID varchar(25)
)
AS
/*
** Delete a row from the ArchiveFrom table
*/
DELETE FROM [ArchiveFrom] WHERE [FromEmailAddr] = @FromEmailAddr AND [SenderName] = @SenderName AND [UserID] = @UserID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the ArchiveFrom table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveFrom_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveFrom_Insert]
(
	@FromEmailAddr nvarchar(254),
	@SenderName varchar(254),
	@UserID varchar(25)
)
AS
/*
** Add a row to the ArchiveFrom table
*/

INSERT INTO [ArchiveFrom]
( [FromEmailAddr], [SenderName], [UserID]
)
VALUES
( @FromEmailAddr, @SenderName, @UserID
)

/*
** Select the new row
*/
SELECT
	gv_ArchiveFrom.*
FROM
	gv_ArchiveFrom
WHERE
	[FromEmailAddr] = @FromEmailAddr
	AND [SenderName] = @SenderName
	AND [UserID] = @UserID


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveFrom_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveFrom_SelectAll]
AS
/*
** Select all rows from the ArchiveFrom table
*/

SELECT 
	gv_ArchiveFrom.*
FROM
	gv_ArchiveFrom
ORDER BY
	[FromEmailAddr],
	[SenderName],
	[UserID]


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveFrom_SelectByFromEmailAddrAndSenderNameAndUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveFrom_SelectByFromEmailAddrAndSenderNameAndUserID]
(
	@FromEmailAddr nvarchar(254),
	@SenderName varchar(254),
	@UserID varchar(25)
)
AS
/*
** Select a row from the ArchiveFrom table by primary key
*/

SELECT 
	gv_ArchiveFrom.*
FROM
	gv_ArchiveFrom WHERE [FromEmailAddr] = @FromEmailAddr AND [SenderName] = @SenderName AND [UserID] = @UserID


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveFrom_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveFrom_Update]
(
	@FromEmailAddrOriginal nvarchar(254), 
	@FromEmailAddr nvarchar(254),
	@SenderNameOriginal varchar(254), 
	@SenderName varchar(254),
	@UserIDOriginal varchar(25), 
	@UserID varchar(25)
)
AS
/*
** Update a row in the ArchiveFrom table using the primary key
*/
UPDATE [ArchiveFrom] SET [FromEmailAddr] = @FromEmailAddr, [SenderName] = @SenderName, [UserID] = @UserID WHERE [FromEmailAddr] = @FromEmailAddrOriginal AND [SenderName] = @SenderNameOriginal AND [UserID] = @UserIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_ArchiveFrom.*
FROM
	gv_ArchiveFrom
WHERE
	[FromEmailAddr] = @FromEmailAddrOriginal
	AND [SenderName] = @SenderNameOriginal
	AND [UserID] = @UserIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHist_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveHist_Delete]
(
	@ArchiveID nvarchar(50)
)
AS
/*
** Delete a row from the ArchiveHist table
*/
DELETE FROM [ArchiveHist] WHERE [ArchiveID] = @ArchiveID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the ArchiveHist table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHist_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveHist_Insert]
(
	@ArchiveID nvarchar(50),
	@ArchiveDate datetime,
	@NbrFilesArchived int,
	@UserGuid nvarchar(50)
)
AS
/*
** Add a row to the ArchiveHist table
*/

INSERT INTO [ArchiveHist]
( [ArchiveID], [ArchiveDate], [NbrFilesArchived], [UserGuid]
)
VALUES
( @ArchiveID, @ArchiveDate, @NbrFilesArchived, @UserGuid
)

/*
** Select the new row
*/
SELECT
	gv_ArchiveHist.*
FROM
	gv_ArchiveHist
WHERE
	[ArchiveID] = @ArchiveID


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHist_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveHist_SelectAll]
AS
/*
** Select all rows from the ArchiveHist table
*/

SELECT 
	gv_ArchiveHist.*
FROM
	gv_ArchiveHist
ORDER BY
	[ArchiveID]


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHist_SelectByArchiveID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveHist_SelectByArchiveID]
(
	@ArchiveID nvarchar(50)
)
AS
/*
** Select a row from the ArchiveHist table by primary key
*/

SELECT 
	gv_ArchiveHist.*
FROM
	gv_ArchiveHist WHERE [ArchiveID] = @ArchiveID


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHist_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveHist_Update]
(
	@ArchiveIDOriginal nvarchar(50), 
	@ArchiveID nvarchar(50),
	@ArchiveDate datetime,
	@NbrFilesArchived int,
	@UserGuid nvarchar(50)
)
AS
/*
** Update a row in the ArchiveHist table using the primary key
*/
UPDATE [ArchiveHist] SET [ArchiveID] = @ArchiveID, [ArchiveDate] = @ArchiveDate, [NbrFilesArchived] = @NbrFilesArchived, [UserGuid] = @UserGuid WHERE [ArchiveID] = @ArchiveIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_ArchiveHist.*
FROM
	gv_ArchiveHist
WHERE
	[ArchiveID] = @ArchiveIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHistContentType_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveHistContentType_Delete]
(
	@ArchiveID nvarchar(50),
	@Directory nvarchar(254),
	@FileType nvarchar(50)
)
AS
/*
** Delete a row from the ArchiveHistContentType table
*/
DELETE FROM [ArchiveHistContentType] WHERE [ArchiveID] = @ArchiveID AND [Directory] = @Directory AND [FileType] = @FileType

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the ArchiveHistContentType table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHistContentType_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveHistContentType_Insert]
(
	@ArchiveID nvarchar(50),
	@Directory nvarchar(254),
	@FileType nvarchar(50),
	@NbrFilesArchived int
)
AS
/*
** Add a row to the ArchiveHistContentType table
*/

INSERT INTO [ArchiveHistContentType]
( [ArchiveID], [Directory], [FileType], [NbrFilesArchived]
)
VALUES
( @ArchiveID, @Directory, @FileType, @NbrFilesArchived
)

/*
** Select the new row
*/
SELECT
	gv_ArchiveHistContentType.*
FROM
	gv_ArchiveHistContentType
WHERE
	[ArchiveID] = @ArchiveID
	AND [Directory] = @Directory
	AND [FileType] = @FileType


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHistContentType_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveHistContentType_SelectAll]
AS
/*
** Select all rows from the ArchiveHistContentType table
*/

SELECT 
	gv_ArchiveHistContentType.*
FROM
	gv_ArchiveHistContentType
ORDER BY
	[ArchiveID],
	[Directory],
	[FileType]


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHistContentType_SelectByArchiveID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveHistContentType_SelectByArchiveID]
(
	@ArchiveID nvarchar(50)
)
AS
/*
** Select rows from the ArchiveHistContentType table by ArchiveID
*/
SELECT 
	gv_ArchiveHistContentType.*
FROM
	gv_ArchiveHistContentType WHERE [ArchiveID] = @ArchiveID ORDER BY [ArchiveID], [Directory], [FileType]


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHistContentType_SelectByArchiveIDAndDirectoryAndFileType]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveHistContentType_SelectByArchiveIDAndDirectoryAndFileType]
(
	@ArchiveID nvarchar(50),
	@Directory nvarchar(254),
	@FileType nvarchar(50)
)
AS
/*
** Select a row from the ArchiveHistContentType table by primary key
*/

SELECT 
	gv_ArchiveHistContentType.*
FROM
	gv_ArchiveHistContentType WHERE [ArchiveID] = @ArchiveID AND [Directory] = @Directory AND [FileType] = @FileType


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveHistContentType_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveHistContentType_Update]
(
	@ArchiveIDOriginal nvarchar(50), 
	@ArchiveID nvarchar(50),
	@DirectoryOriginal nvarchar(254), 
	@Directory nvarchar(254),
	@FileTypeOriginal nvarchar(50), 
	@FileType nvarchar(50),
	@NbrFilesArchived int
)
AS
/*
** Update a row in the ArchiveHistContentType table using the primary key
*/
UPDATE [ArchiveHistContentType] SET [ArchiveID] = @ArchiveID, [Directory] = @Directory, [FileType] = @FileType, [NbrFilesArchived] = @NbrFilesArchived WHERE [ArchiveID] = @ArchiveIDOriginal AND [Directory] = @DirectoryOriginal AND [FileType] = @FileTypeOriginal


/*
** Select the updated row
*/
SELECT
	gv_ArchiveHistContentType.*
FROM
	gv_ArchiveHistContentType
WHERE
	[ArchiveID] = @ArchiveIDOriginal
	AND [Directory] = @DirectoryOriginal
	AND [FileType] = @FileTypeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveStats_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveStats_Delete]
(
	@StatGuid nvarchar(50)
)
AS
/*
** Delete a row from the ArchiveStats table
*/
DELETE FROM [ArchiveStats] WHERE [StatGuid] = @StatGuid

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the ArchiveStats table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveStats_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveStats_Insert]
(
	@ArchiveStartDate datetime,
	@Status nvarchar(50),
	@Successful nchar(1),
	@ArchiveType nvarchar(50),
	@TotalEmailsInRepository int,
	@TotalContentInRepository int,
	@UserID nvarchar(50),
	@ArchiveEndDate datetime,
	@StatGuid nvarchar(50)
)
AS
/*
** Add a row to the ArchiveStats table
*/

INSERT INTO [ArchiveStats]
( [ArchiveStartDate], [Status], [Successful], [ArchiveType], [TotalEmailsInRepository], [TotalContentInRepository], [UserID], [ArchiveEndDate], [StatGuid]
)
VALUES
( @ArchiveStartDate, @Status, @Successful, @ArchiveType, @TotalEmailsInRepository, @TotalContentInRepository, @UserID, @ArchiveEndDate, @StatGuid
)

/*
** Select the new row
*/
SELECT
	gv_ArchiveStats.*
FROM
	gv_ArchiveStats
WHERE
	[StatGuid] = @StatGuid


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveStats_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveStats_SelectAll]
AS
/*
** Select all rows from the ArchiveStats table
*/

SELECT 
	gv_ArchiveStats.*
FROM
	gv_ArchiveStats
ORDER BY
	[StatGuid]


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveStats_SelectByStatGuid]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveStats_SelectByStatGuid]
(
	@StatGuid nvarchar(50)
)
AS
/*
** Select a row from the ArchiveStats table by primary key
*/

SELECT 
	gv_ArchiveStats.*
FROM
	gv_ArchiveStats WHERE [StatGuid] = @StatGuid


GO
/****** Object:  StoredProcedure [dbo].[gp_ArchiveStats_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ArchiveStats_Update]
(
	@StatGuidOriginal nvarchar(50), 
	@StatGuid nvarchar(50),
	@ArchiveStartDate datetime,
	@Status nvarchar(50),
	@Successful nchar(1),
	@ArchiveType nvarchar(50),
	@TotalEmailsInRepository int,
	@TotalContentInRepository int,
	@UserID nvarchar(50),
	@ArchiveEndDate datetime,
	@EntrySeq int
)
AS
/*
** Update a row in the ArchiveStats table using the primary key
*/
UPDATE [ArchiveStats] SET [ArchiveStartDate] = @ArchiveStartDate, [Status] = @Status, [Successful] = @Successful, [ArchiveType] = @ArchiveType, [TotalEmailsInRepository] = @TotalEmailsInRepository, [TotalContentInRepository] = @TotalContentInRepository, [UserID] = @UserID, [ArchiveEndDate] = @ArchiveEndDate, [StatGuid] = @StatGuid WHERE [StatGuid] = @StatGuidOriginal


/*
** Select the updated row
*/
SELECT
	gv_ArchiveStats.*
FROM
	gv_ArchiveStats
WHERE
	[StatGuid] = @StatGuidOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_AssignableUserParameters_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AssignableUserParameters_Delete]
(
	@ParmName nchar(50)
)
AS
/*
** Delete a row from the AssignableUserParameters table
*/
DELETE FROM [AssignableUserParameters] WHERE [ParmName] = @ParmName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the AssignableUserParameters table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_AssignableUserParameters_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AssignableUserParameters_Insert]
(
	@ParmName nchar(50),
	@isPerm bit
)
AS
/*
** Add a row to the AssignableUserParameters table
*/

INSERT INTO [AssignableUserParameters]
( [ParmName], [isPerm]
)
VALUES
( @ParmName, @isPerm
)

/*
** Select the new row
*/
SELECT
	gv_AssignableUserParameters.*
FROM
	gv_AssignableUserParameters
WHERE
	[ParmName] = @ParmName


GO
/****** Object:  StoredProcedure [dbo].[gp_AssignableUserParameters_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AssignableUserParameters_SelectAll]
AS
/*
** Select all rows from the AssignableUserParameters table
*/

SELECT 
	gv_AssignableUserParameters.*
FROM
	gv_AssignableUserParameters
ORDER BY
	[ParmName]


GO
/****** Object:  StoredProcedure [dbo].[gp_AssignableUserParameters_SelectByParmName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AssignableUserParameters_SelectByParmName]
(
	@ParmName nchar(50)
)
AS
/*
** Select a row from the AssignableUserParameters table by primary key
*/

SELECT 
	gv_AssignableUserParameters.*
FROM
	gv_AssignableUserParameters WHERE [ParmName] = @ParmName


GO
/****** Object:  StoredProcedure [dbo].[gp_AssignableUserParameters_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AssignableUserParameters_Update]
(
	@ParmNameOriginal nchar(50), 
	@ParmName nchar(50),
	@isPerm bit
)
AS
/*
** Update a row in the AssignableUserParameters table using the primary key
*/
UPDATE [AssignableUserParameters] SET [ParmName] = @ParmName, [isPerm] = @isPerm WHERE [ParmName] = @ParmNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_AssignableUserParameters.*
FROM
	gv_AssignableUserParameters
WHERE
	[ParmName] = @ParmNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_AttachmentType_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AttachmentType_Delete]
(
	@AttachmentCode nvarchar(50)
)
AS
/*
** Delete a row from the AttachmentType table
*/
DELETE FROM [AttachmentType] WHERE [AttachmentCode] = @AttachmentCode

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the AttachmentType table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_AttachmentType_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AttachmentType_Insert]
(
	@AttachmentCode nvarchar(50),
	@Description nvarchar(254),
	@isZipFormat bit
)
AS
/*
** Add a row to the AttachmentType table
*/

INSERT INTO [AttachmentType]
( [AttachmentCode], [Description], [isZipFormat]
)
VALUES
( @AttachmentCode, @Description, @isZipFormat
)

/*
** Select the new row
*/
SELECT
	gv_AttachmentType.*
FROM
	gv_AttachmentType
WHERE
	[AttachmentCode] = @AttachmentCode


GO
/****** Object:  StoredProcedure [dbo].[gp_AttachmentType_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AttachmentType_SelectAll]
AS
/*
** Select all rows from the AttachmentType table
*/

SELECT 
	gv_AttachmentType.*
FROM
	gv_AttachmentType
ORDER BY
	[AttachmentCode]


GO
/****** Object:  StoredProcedure [dbo].[gp_AttachmentType_SelectByAttachmentCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AttachmentType_SelectByAttachmentCode]
(
	@AttachmentCode nvarchar(50)
)
AS
/*
** Select a row from the AttachmentType table by primary key
*/

SELECT 
	gv_AttachmentType.*
FROM
	gv_AttachmentType WHERE [AttachmentCode] = @AttachmentCode


GO
/****** Object:  StoredProcedure [dbo].[gp_AttachmentType_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AttachmentType_Update]
(
	@AttachmentCodeOriginal nvarchar(50), 
	@AttachmentCode nvarchar(50),
	@Description nvarchar(254),
	@isZipFormat bit
)
AS
/*
** Update a row in the AttachmentType table using the primary key
*/
UPDATE [AttachmentType] SET [AttachmentCode] = @AttachmentCode, [Description] = @Description, [isZipFormat] = @isZipFormat WHERE [AttachmentCode] = @AttachmentCodeOriginal


/*
** Select the updated row
*/
SELECT
	gv_AttachmentType.*
FROM
	gv_AttachmentType
WHERE
	[AttachmentCode] = @AttachmentCodeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_AttributeDatatype_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AttributeDatatype_Delete]
(
	@AttributeDataType nvarchar(50)
)
AS
/*
** Delete a row from the AttributeDatatype table
*/
DELETE FROM [AttributeDatatype] WHERE [AttributeDataType] = @AttributeDataType

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the AttributeDatatype table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_AttributeDatatype_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AttributeDatatype_Insert]
(
	@AttributeDataType nvarchar(50)
)
AS
/*
** Add a row to the AttributeDatatype table
*/

INSERT INTO [AttributeDatatype]
( [AttributeDataType]
)
VALUES
( @AttributeDataType
)

/*
** Select the new row
*/
SELECT
	gv_AttributeDatatype.*
FROM
	gv_AttributeDatatype
WHERE
	[AttributeDataType] = @AttributeDataType


GO
/****** Object:  StoredProcedure [dbo].[gp_AttributeDatatype_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AttributeDatatype_SelectAll]
AS
/*
** Select all rows from the AttributeDatatype table
*/

SELECT 
	gv_AttributeDatatype.*
FROM
	gv_AttributeDatatype
ORDER BY
	[AttributeDataType]


GO
/****** Object:  StoredProcedure [dbo].[gp_AttributeDatatype_SelectByAttributeDataType]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AttributeDatatype_SelectByAttributeDataType]
(
	@AttributeDataType nvarchar(50)
)
AS
/*
** Select a row from the AttributeDatatype table by primary key
*/

SELECT 
	gv_AttributeDatatype.*
FROM
	gv_AttributeDatatype WHERE [AttributeDataType] = @AttributeDataType


GO
/****** Object:  StoredProcedure [dbo].[gp_AttributeDatatype_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AttributeDatatype_Update]
(
	@AttributeDataTypeOriginal nvarchar(50), 
	@AttributeDataType nvarchar(50)
)
AS
/*
** Update a row in the AttributeDatatype table using the primary key
*/
UPDATE [AttributeDatatype] SET [AttributeDataType] = @AttributeDataType WHERE [AttributeDataType] = @AttributeDataTypeOriginal


/*
** Select the updated row
*/
SELECT
	gv_AttributeDatatype.*
FROM
	gv_AttributeDatatype
WHERE
	[AttributeDataType] = @AttributeDataTypeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_Attributes_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Attributes_Delete]
(
	@AttributeName nvarchar(50)
)
AS
/*
** Delete a row from the Attributes table
*/
DELETE FROM [Attributes] WHERE [AttributeName] = @AttributeName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the Attributes table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_Attributes_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Attributes_Insert]
(
	@AttributeName nvarchar(50),
	@AttributeDataType nvarchar(50),
	@AttributeDesc nvarchar(2000),
	@AssoApplication nvarchar(50),
	@AllowedValues nvarchar(254)
)
AS
/*
** Add a row to the Attributes table
*/

INSERT INTO [Attributes]
( [AttributeName], [AttributeDataType], [AttributeDesc], [AssoApplication], [AllowedValues]
)
VALUES
( @AttributeName, @AttributeDataType, @AttributeDesc, @AssoApplication, @AllowedValues
)

/*
** Select the new row
*/
SELECT
	gv_Attributes.*
FROM
	gv_Attributes
WHERE
	[AttributeName] = @AttributeName


GO
/****** Object:  StoredProcedure [dbo].[gp_Attributes_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Attributes_SelectAll]
AS
/*
** Select all rows from the Attributes table
*/

SELECT 
	gv_Attributes.*
FROM
	gv_Attributes
ORDER BY
	[AttributeName]


GO
/****** Object:  StoredProcedure [dbo].[gp_Attributes_SelectByAttributeDataType]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Attributes_SelectByAttributeDataType]
(
	@AttributeDataType nvarchar(50)
)
AS
/*
** Select rows from the Attributes table by AttributeDataType
*/
SELECT 
	gv_Attributes.*
FROM
	gv_Attributes WHERE [AttributeDataType] = @AttributeDataType ORDER BY [AttributeName]


GO
/****** Object:  StoredProcedure [dbo].[gp_Attributes_SelectByAttributeName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Attributes_SelectByAttributeName]
(
	@AttributeName nvarchar(50)
)
AS
/*
** Select a row from the Attributes table by primary key
*/

SELECT 
	gv_Attributes.*
FROM
	gv_Attributes WHERE [AttributeName] = @AttributeName


GO
/****** Object:  StoredProcedure [dbo].[gp_Attributes_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Attributes_Update]
(
	@AttributeNameOriginal nvarchar(50), 
	@AttributeName nvarchar(50),
	@AttributeDataType nvarchar(50),
	@AttributeDesc nvarchar(2000),
	@AssoApplication nvarchar(50),
	@AllowedValues nvarchar(254)
)
AS
/*
** Update a row in the Attributes table using the primary key
*/
UPDATE [Attributes] SET [AttributeName] = @AttributeName, [AttributeDataType] = @AttributeDataType, [AttributeDesc] = @AttributeDesc, [AssoApplication] = @AssoApplication, [AllowedValues] = @AllowedValues WHERE [AttributeName] = @AttributeNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_Attributes.*
FROM
	gv_Attributes
WHERE
	[AttributeName] = @AttributeNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_AvailFileTypes_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AvailFileTypes_Delete]
(
	@ExtCode nvarchar(50)
)
AS
/*
** Delete a row from the AvailFileTypes table
*/
DELETE FROM [AvailFileTypes] WHERE [ExtCode] = @ExtCode

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the AvailFileTypes table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_AvailFileTypes_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AvailFileTypes_Insert]
(
	@ExtCode nvarchar(50)
)
AS
/*
** Add a row to the AvailFileTypes table
*/

INSERT INTO [AvailFileTypes]
( [ExtCode]
)
VALUES
( @ExtCode
)

/*
** Select the new row
*/
SELECT
	gv_AvailFileTypes.*
FROM
	gv_AvailFileTypes
WHERE
	[ExtCode] = @ExtCode


GO
/****** Object:  StoredProcedure [dbo].[gp_AvailFileTypes_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AvailFileTypes_SelectAll]
AS
/*
** Select all rows from the AvailFileTypes table
*/

SELECT 
	gv_AvailFileTypes.*
FROM
	gv_AvailFileTypes
ORDER BY
	[ExtCode]


GO
/****** Object:  StoredProcedure [dbo].[gp_AvailFileTypes_SelectByExtCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AvailFileTypes_SelectByExtCode]
(
	@ExtCode nvarchar(50)
)
AS
/*
** Select a row from the AvailFileTypes table by primary key
*/

SELECT 
	gv_AvailFileTypes.*
FROM
	gv_AvailFileTypes WHERE [ExtCode] = @ExtCode


GO
/****** Object:  StoredProcedure [dbo].[gp_AvailFileTypes_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AvailFileTypes_Update]
(
	@ExtCodeOriginal nvarchar(50), 
	@ExtCode nvarchar(50)
)
AS
/*
** Update a row in the AvailFileTypes table using the primary key
*/
UPDATE [AvailFileTypes] SET [ExtCode] = @ExtCode WHERE [ExtCode] = @ExtCodeOriginal


/*
** Select the updated row
*/
SELECT
	gv_AvailFileTypes.*
FROM
	gv_AvailFileTypes
WHERE
	[ExtCode] = @ExtCodeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_AvailFileTypesUndefined_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AvailFileTypesUndefined_Delete]
(
	@FileType nvarchar(50)
)
AS
/*
** Delete a row from the AvailFileTypesUndefined table
*/
DELETE FROM [AvailFileTypesUndefined] WHERE [FileType] = @FileType

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the AvailFileTypesUndefined table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_AvailFileTypesUndefined_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AvailFileTypesUndefined_Insert]
(
	@FileType nvarchar(50),
	@SubstituteType nvarchar(50),
	@Applied bit
)
AS
/*
** Add a row to the AvailFileTypesUndefined table
*/

INSERT INTO [AvailFileTypesUndefined]
( [FileType], [SubstituteType], [Applied]
)
VALUES
( @FileType, @SubstituteType, @Applied
)

/*
** Select the new row
*/
SELECT
	gv_AvailFileTypesUndefined.*
FROM
	gv_AvailFileTypesUndefined
WHERE
	[FileType] = @FileType


GO
/****** Object:  StoredProcedure [dbo].[gp_AvailFileTypesUndefined_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AvailFileTypesUndefined_SelectAll]
AS
/*
** Select all rows from the AvailFileTypesUndefined table
*/

SELECT 
	gv_AvailFileTypesUndefined.*
FROM
	gv_AvailFileTypesUndefined
ORDER BY
	[FileType]


GO
/****** Object:  StoredProcedure [dbo].[gp_AvailFileTypesUndefined_SelectByFileType]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AvailFileTypesUndefined_SelectByFileType]
(
	@FileType nvarchar(50)
)
AS
/*
** Select a row from the AvailFileTypesUndefined table by primary key
*/

SELECT 
	gv_AvailFileTypesUndefined.*
FROM
	gv_AvailFileTypesUndefined WHERE [FileType] = @FileType


GO
/****** Object:  StoredProcedure [dbo].[gp_AvailFileTypesUndefined_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_AvailFileTypesUndefined_Update]
(
	@FileTypeOriginal nvarchar(50), 
	@FileType nvarchar(50),
	@SubstituteType nvarchar(50),
	@Applied bit
)
AS
/*
** Update a row in the AvailFileTypesUndefined table using the primary key
*/
UPDATE [AvailFileTypesUndefined] SET [FileType] = @FileType, [SubstituteType] = @SubstituteType, [Applied] = @Applied WHERE [FileType] = @FileTypeOriginal


/*
** Select the updated row
*/
SELECT
	gv_AvailFileTypesUndefined.*
FROM
	gv_AvailFileTypesUndefined
WHERE
	[FileType] = @FileTypeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessFunctionJargon_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_BusinessFunctionJargon_Delete]
(
	@CorpFuncName nvarchar(80),
	@WordID int,
	@JargonWords_tgtWord nvarchar(50),
	@JargonCode nvarchar(50),
	@CorpName nvarchar(50)
)
AS
/*
** Delete a row from the BusinessFunctionJargon table
*/
DELETE FROM [BusinessFunctionJargon] WHERE [CorpFuncName] = @CorpFuncName AND [WordID] = @WordID AND [JargonWords_tgtWord] = @JargonWords_tgtWord AND [JargonCode] = @JargonCode AND [CorpName] = @CorpName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the BusinessFunctionJargon table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessFunctionJargon_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_BusinessFunctionJargon_Insert]
(
	@CorpFuncName nvarchar(80),
	@JargonWords_tgtWord nvarchar(50),
	@JargonCode nvarchar(50),
	@CorpName nvarchar(50)
)
AS
/*
** Add a row to the BusinessFunctionJargon table
*/

INSERT INTO [BusinessFunctionJargon]
( [CorpFuncName], [JargonWords_tgtWord], [JargonCode], [CorpName]
)
VALUES
( @CorpFuncName, @JargonWords_tgtWord, @JargonCode, @CorpName
)

/*
** Select the new row
*/
SELECT
	gv_BusinessFunctionJargon.*
FROM
	gv_BusinessFunctionJargon
WHERE
	[CorpFuncName] = @CorpFuncName
	AND [WordID] = (SELECT SCOPE_IDENTITY())
	AND [JargonWords_tgtWord] = @JargonWords_tgtWord
	AND [JargonCode] = @JargonCode
	AND [CorpName] = @CorpName


GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessFunctionJargon_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_BusinessFunctionJargon_SelectAll]
AS
/*
** Select all rows from the BusinessFunctionJargon table
*/

SELECT 
	gv_BusinessFunctionJargon.*
FROM
	gv_BusinessFunctionJargon
ORDER BY
	[CorpFuncName],
	[WordID],
	[JargonWords_tgtWord],
	[JargonCode],
	[CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessFunctionJargon_SelectByCorpFuncNameAndCorpName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_BusinessFunctionJargon_SelectByCorpFuncNameAndCorpName]
(
	@CorpFuncName nvarchar(80),
	@CorpName nvarchar(50)
)
AS
/*
** Select rows from the BusinessFunctionJargon table by CorpFuncName and CorpName
*/
SELECT 
	gv_BusinessFunctionJargon.*
FROM
	gv_BusinessFunctionJargon WHERE [CorpFuncName] = @CorpFuncName AND [CorpName] = @CorpName ORDER BY [CorpFuncName], [WordID], [JargonWords_tgtWord], [JargonCode], [CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessFunctionJargon_SelectByCorpFuncNameAndWordIDAndJargonWords_tgtWordAndJargonCodeAndCorpName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_BusinessFunctionJargon_SelectByCorpFuncNameAndWordIDAndJargonWords_tgtWordAndJargonCodeAndCorpName]
(
	@CorpFuncName nvarchar(80),
	@WordID int,
	@JargonWords_tgtWord nvarchar(50),
	@JargonCode nvarchar(50),
	@CorpName nvarchar(50)
)
AS
/*
** Select a row from the BusinessFunctionJargon table by primary key
*/

SELECT 
	gv_BusinessFunctionJargon.*
FROM
	gv_BusinessFunctionJargon WHERE [CorpFuncName] = @CorpFuncName AND [WordID] = @WordID AND [JargonWords_tgtWord] = @JargonWords_tgtWord AND [JargonCode] = @JargonCode AND [CorpName] = @CorpName


GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessFunctionJargon_SelectByJargonCodeAndJargonWords_tgtWord]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_BusinessFunctionJargon_SelectByJargonCodeAndJargonWords_tgtWord]
(
	@JargonCode nvarchar(50),
	@JargonWords_tgtWord nvarchar(50)
)
AS
/*
** Select rows from the BusinessFunctionJargon table by JargonCode and JargonWords_tgtWord
*/
SELECT 
	gv_BusinessFunctionJargon.*
FROM
	gv_BusinessFunctionJargon WHERE [JargonCode] = @JargonCode AND [JargonWords_tgtWord] = @JargonWords_tgtWord ORDER BY [CorpFuncName], [WordID], [JargonWords_tgtWord], [JargonCode], [CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessFunctionJargon_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_BusinessFunctionJargon_Update]
(
	@CorpFuncNameOriginal nvarchar(80), 
	@CorpFuncName nvarchar(80),
	@WordIDOriginal int,
	@JargonWords_tgtWordOriginal nvarchar(50), 
	@JargonWords_tgtWord nvarchar(50),
	@JargonCodeOriginal nvarchar(50), 
	@JargonCode nvarchar(50),
	@CorpNameOriginal nvarchar(50), 
	@CorpName nvarchar(50)
)
AS
/*
** Update a row in the BusinessFunctionJargon table using the primary key
*/
UPDATE [BusinessFunctionJargon] SET [CorpFuncName] = @CorpFuncName, [JargonWords_tgtWord] = @JargonWords_tgtWord, [JargonCode] = @JargonCode, [CorpName] = @CorpName WHERE [CorpFuncName] = @CorpFuncNameOriginal AND [WordID] = @WordIDOriginal AND [JargonWords_tgtWord] = @JargonWords_tgtWordOriginal AND [JargonCode] = @JargonCodeOriginal AND [CorpName] = @CorpNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_BusinessFunctionJargon.*
FROM
	gv_BusinessFunctionJargon
WHERE
	[CorpFuncName] = @CorpFuncNameOriginal
	AND [WordID] = @WordIDOriginal
	AND [JargonWords_tgtWord] = @JargonWords_tgtWordOriginal
	AND [JargonCode] = @JargonCodeOriginal
	AND [CorpName] = @CorpNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessJargonCode_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_BusinessJargonCode_Delete]
(
	@JargonCode nvarchar(50)
)
AS
/*
** Delete a row from the BusinessJargonCode table
*/
DELETE FROM [BusinessJargonCode] WHERE [JargonCode] = @JargonCode

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the BusinessJargonCode table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessJargonCode_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_BusinessJargonCode_Insert]
(
	@JargonCode nvarchar(50),
	@JargonDesc nvarchar(18)
)
AS
/*
** Add a row to the BusinessJargonCode table
*/

INSERT INTO [BusinessJargonCode]
( [JargonCode], [JargonDesc]
)
VALUES
( @JargonCode, @JargonDesc
)

/*
** Select the new row
*/
SELECT
	gv_BusinessJargonCode.*
FROM
	gv_BusinessJargonCode
WHERE
	[JargonCode] = @JargonCode


GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessJargonCode_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_BusinessJargonCode_SelectAll]
AS
/*
** Select all rows from the BusinessJargonCode table
*/

SELECT 
	gv_BusinessJargonCode.*
FROM
	gv_BusinessJargonCode
ORDER BY
	[JargonCode]


GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessJargonCode_SelectByJargonCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_BusinessJargonCode_SelectByJargonCode]
(
	@JargonCode nvarchar(50)
)
AS
/*
** Select a row from the BusinessJargonCode table by primary key
*/

SELECT 
	gv_BusinessJargonCode.*
FROM
	gv_BusinessJargonCode WHERE [JargonCode] = @JargonCode


GO
/****** Object:  StoredProcedure [dbo].[gp_BusinessJargonCode_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_BusinessJargonCode_Update]
(
	@JargonCodeOriginal nvarchar(50), 
	@JargonCode nvarchar(50),
	@JargonDesc nvarchar(18)
)
AS
/*
** Update a row in the BusinessJargonCode table using the primary key
*/
UPDATE [BusinessJargonCode] SET [JargonCode] = @JargonCode, [JargonDesc] = @JargonDesc WHERE [JargonCode] = @JargonCodeOriginal


/*
** Select the updated row
*/
SELECT
	gv_BusinessJargonCode.*
FROM
	gv_BusinessJargonCode
WHERE
	[JargonCode] = @JargonCodeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_CaptureItems_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CaptureItems_Delete]
(
	@CaptureItemsCode nvarchar(50)
)
AS
/*
** Delete a row from the CaptureItems table
*/
DELETE FROM [CaptureItems] WHERE [CaptureItemsCode] = @CaptureItemsCode

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the CaptureItems table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_CaptureItems_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CaptureItems_Insert]
(
	@CaptureItemsCode nvarchar(50),
	@CaptureItemsDesc nvarchar(18),
	@CreateDate datetime
)
AS
/*
** Add a row to the CaptureItems table
*/

INSERT INTO [CaptureItems]
( [CaptureItemsCode], [CaptureItemsDesc], [CreateDate]
)
VALUES
( @CaptureItemsCode, @CaptureItemsDesc, @CreateDate
)

/*
** Select the new row
*/
SELECT
	gv_CaptureItems.*
FROM
	gv_CaptureItems
WHERE
	[CaptureItemsCode] = @CaptureItemsCode


GO
/****** Object:  StoredProcedure [dbo].[gp_CaptureItems_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CaptureItems_SelectAll]
AS
/*
** Select all rows from the CaptureItems table
*/

SELECT 
	gv_CaptureItems.*
FROM
	gv_CaptureItems
ORDER BY
	[CaptureItemsCode]


GO
/****** Object:  StoredProcedure [dbo].[gp_CaptureItems_SelectByCaptureItemsCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CaptureItems_SelectByCaptureItemsCode]
(
	@CaptureItemsCode nvarchar(50)
)
AS
/*
** Select a row from the CaptureItems table by primary key
*/

SELECT 
	gv_CaptureItems.*
FROM
	gv_CaptureItems WHERE [CaptureItemsCode] = @CaptureItemsCode


GO
/****** Object:  StoredProcedure [dbo].[gp_CaptureItems_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CaptureItems_Update]
(
	@CaptureItemsCodeOriginal nvarchar(50), 
	@CaptureItemsCode nvarchar(50),
	@CaptureItemsDesc nvarchar(18),
	@CreateDate datetime
)
AS
/*
** Update a row in the CaptureItems table using the primary key
*/
UPDATE [CaptureItems] SET [CaptureItemsCode] = @CaptureItemsCode, [CaptureItemsDesc] = @CaptureItemsDesc, [CreateDate] = @CreateDate WHERE [CaptureItemsCode] = @CaptureItemsCodeOriginal


/*
** Select the updated row
*/
SELECT
	gv_CaptureItems.*
FROM
	gv_CaptureItems
WHERE
	[CaptureItemsCode] = @CaptureItemsCodeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_ContactFrom_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ContactFrom_Delete]
(
	@FromEmailAddr nvarchar(254),
	@SenderName varchar(254),
	@UserID varchar(25)
)
AS
/*
** Delete a row from the ContactFrom table
*/
DELETE FROM [ContactFrom] WHERE [FromEmailAddr] = @FromEmailAddr AND [SenderName] = @SenderName AND [UserID] = @UserID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the ContactFrom table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_ContactFrom_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ContactFrom_Insert]
(
	@FromEmailAddr nvarchar(254),
	@SenderName varchar(254),
	@UserID varchar(25),
	@Verified int
)
AS
/*
** Add a row to the ContactFrom table
*/

INSERT INTO [ContactFrom]
( [FromEmailAddr], [SenderName], [UserID], [Verified]
)
VALUES
( @FromEmailAddr, @SenderName, @UserID, @Verified
)

/*
** Select the new row
*/
SELECT
	gv_ContactFrom.*
FROM
	gv_ContactFrom
WHERE
	[FromEmailAddr] = @FromEmailAddr
	AND [SenderName] = @SenderName
	AND [UserID] = @UserID


GO
/****** Object:  StoredProcedure [dbo].[gp_ContactFrom_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ContactFrom_SelectAll]
AS
/*
** Select all rows from the ContactFrom table
*/

SELECT 
	gv_ContactFrom.*
FROM
	gv_ContactFrom
ORDER BY
	[FromEmailAddr],
	[SenderName],
	[UserID]


GO
/****** Object:  StoredProcedure [dbo].[gp_ContactFrom_SelectByFromEmailAddrAndSenderNameAndUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ContactFrom_SelectByFromEmailAddrAndSenderNameAndUserID]
(
	@FromEmailAddr nvarchar(254),
	@SenderName varchar(254),
	@UserID varchar(25)
)
AS
/*
** Select a row from the ContactFrom table by primary key
*/

SELECT 
	gv_ContactFrom.*
FROM
	gv_ContactFrom WHERE [FromEmailAddr] = @FromEmailAddr AND [SenderName] = @SenderName AND [UserID] = @UserID


GO
/****** Object:  StoredProcedure [dbo].[gp_ContactFrom_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ContactFrom_Update]
(
	@FromEmailAddrOriginal nvarchar(254), 
	@FromEmailAddr nvarchar(254),
	@SenderNameOriginal varchar(254), 
	@SenderName varchar(254),
	@UserIDOriginal varchar(25), 
	@UserID varchar(25),
	@Verified int
)
AS
/*
** Update a row in the ContactFrom table using the primary key
*/
UPDATE [ContactFrom] SET [FromEmailAddr] = @FromEmailAddr, [SenderName] = @SenderName, [UserID] = @UserID, [Verified] = @Verified WHERE [FromEmailAddr] = @FromEmailAddrOriginal AND [SenderName] = @SenderNameOriginal AND [UserID] = @UserIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_ContactFrom.*
FROM
	gv_ContactFrom
WHERE
	[FromEmailAddr] = @FromEmailAddrOriginal
	AND [SenderName] = @SenderNameOriginal
	AND [UserID] = @UserIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_ContactsArchive_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ContactsArchive_Delete]
(
	@Email1Address nvarchar(80),
	@FullName nvarchar(80),
	@UserID char(25)
)
AS
/*
** Delete a row from the ContactsArchive table
*/
DELETE FROM [ContactsArchive] WHERE [Email1Address] = @Email1Address AND [FullName] = @FullName AND [UserID] = @UserID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the ContactsArchive table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_ContactsArchive_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ContactsArchive_Insert]
(
	@Email1Address nvarchar(80),
	@FullName nvarchar(80),
	@UserID char(25),
	@Account nvarchar(4000),
	@Anniversary nvarchar(4000),
	@Application nvarchar(4000),
	@AssistantName nvarchar(4000),
	@AssistantTelephoneNumber nvarchar(4000),
	@BillingInformation nvarchar(4000),
	@Birthday nvarchar(4000),
	@Business2TelephoneNumber nvarchar(4000),
	@BusinessAddress nvarchar(4000),
	@BusinessAddressCity nvarchar(4000),
	@BusinessAddressCountry nvarchar(4000),
	@BusinessAddressPostalCode nvarchar(4000),
	@BusinessAddressPostOfficeBox nvarchar(4000),
	@BusinessAddressState nvarchar(4000),
	@BusinessAddressStreet nvarchar(4000),
	@BusinessCardType nvarchar(4000),
	@BusinessFaxNumber nvarchar(4000),
	@BusinessHomePage nvarchar(4000),
	@BusinessTelephoneNumber nvarchar(4000),
	@CallbackTelephoneNumber nvarchar(4000),
	@CarTelephoneNumber nvarchar(4000),
	@Categories nvarchar(4000),
	@Children nvarchar(4000),
	@xClass nvarchar(4000),
	@Companies nvarchar(4000),
	@CompanyName nvarchar(4000),
	@ComputerNetworkName nvarchar(4000),
	@Conflicts nvarchar(4000),
	@ConversationTopic nvarchar(4000),
	@CreationTime nvarchar(4000),
	@CustomerID nvarchar(4000),
	@Department nvarchar(4000),
	@Email1AddressType nvarchar(4000),
	@Email1DisplayName nvarchar(4000),
	@Email1EntryID nvarchar(4000),
	@Email2Address nvarchar(4000),
	@Email2AddressType nvarchar(4000),
	@Email2DisplayName nvarchar(4000),
	@Email2EntryID nvarchar(4000),
	@Email3Address nvarchar(4000),
	@Email3AddressType nvarchar(4000),
	@Email3DisplayName nvarchar(4000),
	@Email3EntryID nvarchar(4000),
	@FileAs nvarchar(4000),
	@FirstName nvarchar(4000),
	@FTPSite nvarchar(4000),
	@Gender nvarchar(4000),
	@GovernmentIDNumber nvarchar(4000),
	@Hobby nvarchar(4000),
	@Home2TelephoneNumber nvarchar(4000),
	@HomeAddress nvarchar(4000),
	@HomeAddressCountry nvarchar(4000),
	@HomeAddressPostalCode nvarchar(4000),
	@HomeAddressPostOfficeBox nvarchar(4000),
	@HomeAddressState nvarchar(4000),
	@HomeAddressStreet nvarchar(4000),
	@HomeFaxNumber nvarchar(4000),
	@HomeTelephoneNumber nvarchar(4000),
	@IMAddress nvarchar(4000),
	@Importance nvarchar(4000),
	@Initials nvarchar(4000),
	@InternetFreeBusyAddress nvarchar(4000),
	@JobTitle nvarchar(4000),
	@Journal nvarchar(4000),
	@Language nvarchar(4000),
	@LastModificationTime nvarchar(4000),
	@LastName nvarchar(4000),
	@LastNameAndFirstName nvarchar(4000),
	@MailingAddress nvarchar(4000),
	@MailingAddressCity nvarchar(4000),
	@MailingAddressCountry nvarchar(4000),
	@MailingAddressPostalCode nvarchar(4000),
	@MailingAddressPostOfficeBox nvarchar(4000),
	@MailingAddressState nvarchar(4000),
	@MailingAddressStreet nvarchar(4000),
	@ManagerName nvarchar(4000),
	@MiddleName nvarchar(4000),
	@Mileage nvarchar(4000),
	@MobileTelephoneNumber nvarchar(4000),
	@NetMeetingAlias nvarchar(4000),
	@NetMeetingServer nvarchar(4000),
	@NickName nvarchar(4000),
	@Title nvarchar(4000),
	@Body nvarchar(4000),
	@OfficeLocation nvarchar(4000),
	@Subject nvarchar(4000)
)
AS
/*
** Add a row to the ContactsArchive table
*/

INSERT INTO [ContactsArchive]
( [Email1Address], [FullName], [UserID], [Account], [Anniversary], [Application], [AssistantName], [AssistantTelephoneNumber], [BillingInformation], [Birthday], [Business2TelephoneNumber], [BusinessAddress], [BusinessAddressCity], [BusinessAddressCountry], [BusinessAddressPostalCode], [BusinessAddressPostOfficeBox], [BusinessAddressState], [BusinessAddressStreet], [BusinessCardType], [BusinessFaxNumber], [BusinessHomePage], [BusinessTelephoneNumber], [CallbackTelephoneNumber], [CarTelephoneNumber], [Categories], [Children], [xClass], [Companies], [CompanyName], [ComputerNetworkName], [Conflicts], [ConversationTopic], [CreationTime], [CustomerID], [Department], [Email1AddressType], [Email1DisplayName], [Email1EntryID], [Email2Address], [Email2AddressType], [Email2DisplayName], [Email2EntryID], [Email3Address], [Email3AddressType], [Email3DisplayName], [Email3EntryID], [FileAs], [FirstName], [FTPSite], [Gender], [GovernmentIDNumber], [Hobby], [Home2TelephoneNumber], [HomeAddress], [HomeAddressCountry], [HomeAddressPostalCode], [HomeAddressPostOfficeBox], [HomeAddressState], [HomeAddressStreet], [HomeFaxNumber], [HomeTelephoneNumber], [IMAddress], [Importance], [Initials], [InternetFreeBusyAddress], [JobTitle], [Journal], [Language], [LastModificationTime], [LastName], [LastNameAndFirstName], [MailingAddress], [MailingAddressCity], [MailingAddressCountry], [MailingAddressPostalCode], [MailingAddressPostOfficeBox], [MailingAddressState], [MailingAddressStreet], [ManagerName], [MiddleName], [Mileage], [MobileTelephoneNumber], [NetMeetingAlias], [NetMeetingServer], [NickName], [Title], [Body], [OfficeLocation], [Subject]
)
VALUES
( @Email1Address, @FullName, @UserID, @Account, @Anniversary, @Application, @AssistantName, @AssistantTelephoneNumber, @BillingInformation, @Birthday, @Business2TelephoneNumber, @BusinessAddress, @BusinessAddressCity, @BusinessAddressCountry, @BusinessAddressPostalCode, @BusinessAddressPostOfficeBox, @BusinessAddressState, @BusinessAddressStreet, @BusinessCardType, @BusinessFaxNumber, @BusinessHomePage, @BusinessTelephoneNumber, @CallbackTelephoneNumber, @CarTelephoneNumber, @Categories, @Children, @xClass, @Companies, @CompanyName, @ComputerNetworkName, @Conflicts, @ConversationTopic, @CreationTime, @CustomerID, @Department, @Email1AddressType, @Email1DisplayName, @Email1EntryID, @Email2Address, @Email2AddressType, @Email2DisplayName, @Email2EntryID, @Email3Address, @Email3AddressType, @Email3DisplayName, @Email3EntryID, @FileAs, @FirstName, @FTPSite, @Gender, @GovernmentIDNumber, @Hobby, @Home2TelephoneNumber, @HomeAddress, @HomeAddressCountry, @HomeAddressPostalCode, @HomeAddressPostOfficeBox, @HomeAddressState, @HomeAddressStreet, @HomeFaxNumber, @HomeTelephoneNumber, @IMAddress, @Importance, @Initials, @InternetFreeBusyAddress, @JobTitle, @Journal, @Language, @LastModificationTime, @LastName, @LastNameAndFirstName, @MailingAddress, @MailingAddressCity, @MailingAddressCountry, @MailingAddressPostalCode, @MailingAddressPostOfficeBox, @MailingAddressState, @MailingAddressStreet, @ManagerName, @MiddleName, @Mileage, @MobileTelephoneNumber, @NetMeetingAlias, @NetMeetingServer, @NickName, @Title, @Body, @OfficeLocation, @Subject
)

/*
** Select the new row
*/
SELECT
	gv_ContactsArchive.*
FROM
	gv_ContactsArchive
WHERE
	[Email1Address] = @Email1Address
	AND [FullName] = @FullName
	AND [UserID] = @UserID


GO
/****** Object:  StoredProcedure [dbo].[gp_ContactsArchive_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ContactsArchive_SelectAll]
AS
/*
** Select all rows from the ContactsArchive table
*/

SELECT 
	gv_ContactsArchive.*
FROM
	gv_ContactsArchive
ORDER BY
	[Email1Address],
	[FullName],
	[UserID]


GO
/****** Object:  StoredProcedure [dbo].[gp_ContactsArchive_SelectByEmail1AddressAndFullNameAndUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ContactsArchive_SelectByEmail1AddressAndFullNameAndUserID]
(
	@Email1Address nvarchar(80),
	@FullName nvarchar(80),
	@UserID char(25)
)
AS
/*
** Select a row from the ContactsArchive table by primary key
*/

SELECT 
	gv_ContactsArchive.*
FROM
	gv_ContactsArchive WHERE [Email1Address] = @Email1Address AND [FullName] = @FullName AND [UserID] = @UserID


GO
/****** Object:  StoredProcedure [dbo].[gp_ContactsArchive_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ContactsArchive_Update]
(
	@Email1AddressOriginal nvarchar(80), 
	@Email1Address nvarchar(80),
	@FullNameOriginal nvarchar(80), 
	@FullName nvarchar(80),
	@UserIDOriginal char(25), 
	@UserID char(25),
	@Account nvarchar(4000),
	@Anniversary nvarchar(4000),
	@Application nvarchar(4000),
	@AssistantName nvarchar(4000),
	@AssistantTelephoneNumber nvarchar(4000),
	@BillingInformation nvarchar(4000),
	@Birthday nvarchar(4000),
	@Business2TelephoneNumber nvarchar(4000),
	@BusinessAddress nvarchar(4000),
	@BusinessAddressCity nvarchar(4000),
	@BusinessAddressCountry nvarchar(4000),
	@BusinessAddressPostalCode nvarchar(4000),
	@BusinessAddressPostOfficeBox nvarchar(4000),
	@BusinessAddressState nvarchar(4000),
	@BusinessAddressStreet nvarchar(4000),
	@BusinessCardType nvarchar(4000),
	@BusinessFaxNumber nvarchar(4000),
	@BusinessHomePage nvarchar(4000),
	@BusinessTelephoneNumber nvarchar(4000),
	@CallbackTelephoneNumber nvarchar(4000),
	@CarTelephoneNumber nvarchar(4000),
	@Categories nvarchar(4000),
	@Children nvarchar(4000),
	@xClass nvarchar(4000),
	@Companies nvarchar(4000),
	@CompanyName nvarchar(4000),
	@ComputerNetworkName nvarchar(4000),
	@Conflicts nvarchar(4000),
	@ConversationTopic nvarchar(4000),
	@CreationTime nvarchar(4000),
	@CustomerID nvarchar(4000),
	@Department nvarchar(4000),
	@Email1AddressType nvarchar(4000),
	@Email1DisplayName nvarchar(4000),
	@Email1EntryID nvarchar(4000),
	@Email2Address nvarchar(4000),
	@Email2AddressType nvarchar(4000),
	@Email2DisplayName nvarchar(4000),
	@Email2EntryID nvarchar(4000),
	@Email3Address nvarchar(4000),
	@Email3AddressType nvarchar(4000),
	@Email3DisplayName nvarchar(4000),
	@Email3EntryID nvarchar(4000),
	@FileAs nvarchar(4000),
	@FirstName nvarchar(4000),
	@FTPSite nvarchar(4000),
	@Gender nvarchar(4000),
	@GovernmentIDNumber nvarchar(4000),
	@Hobby nvarchar(4000),
	@Home2TelephoneNumber nvarchar(4000),
	@HomeAddress nvarchar(4000),
	@HomeAddressCountry nvarchar(4000),
	@HomeAddressPostalCode nvarchar(4000),
	@HomeAddressPostOfficeBox nvarchar(4000),
	@HomeAddressState nvarchar(4000),
	@HomeAddressStreet nvarchar(4000),
	@HomeFaxNumber nvarchar(4000),
	@HomeTelephoneNumber nvarchar(4000),
	@IMAddress nvarchar(4000),
	@Importance nvarchar(4000),
	@Initials nvarchar(4000),
	@InternetFreeBusyAddress nvarchar(4000),
	@JobTitle nvarchar(4000),
	@Journal nvarchar(4000),
	@Language nvarchar(4000),
	@LastModificationTime nvarchar(4000),
	@LastName nvarchar(4000),
	@LastNameAndFirstName nvarchar(4000),
	@MailingAddress nvarchar(4000),
	@MailingAddressCity nvarchar(4000),
	@MailingAddressCountry nvarchar(4000),
	@MailingAddressPostalCode nvarchar(4000),
	@MailingAddressPostOfficeBox nvarchar(4000),
	@MailingAddressState nvarchar(4000),
	@MailingAddressStreet nvarchar(4000),
	@ManagerName nvarchar(4000),
	@MiddleName nvarchar(4000),
	@Mileage nvarchar(4000),
	@MobileTelephoneNumber nvarchar(4000),
	@NetMeetingAlias nvarchar(4000),
	@NetMeetingServer nvarchar(4000),
	@NickName nvarchar(4000),
	@Title nvarchar(4000),
	@Body nvarchar(4000),
	@OfficeLocation nvarchar(4000),
	@Subject nvarchar(4000)
)
AS
/*
** Update a row in the ContactsArchive table using the primary key
*/
UPDATE [ContactsArchive] SET [Email1Address] = @Email1Address, [FullName] = @FullName, [UserID] = @UserID, [Account] = @Account, [Anniversary] = @Anniversary, [Application] = @Application, [AssistantName] = @AssistantName, [AssistantTelephoneNumber] = @AssistantTelephoneNumber, [BillingInformation] = @BillingInformation, [Birthday] = @Birthday, [Business2TelephoneNumber] = @Business2TelephoneNumber, [BusinessAddress] = @BusinessAddress, [BusinessAddressCity] = @BusinessAddressCity, [BusinessAddressCountry] = @BusinessAddressCountry, [BusinessAddressPostalCode] = @BusinessAddressPostalCode, [BusinessAddressPostOfficeBox] = @BusinessAddressPostOfficeBox, [BusinessAddressState] = @BusinessAddressState, [BusinessAddressStreet] = @BusinessAddressStreet, [BusinessCardType] = @BusinessCardType, [BusinessFaxNumber] = @BusinessFaxNumber, [BusinessHomePage] = @BusinessHomePage, [BusinessTelephoneNumber] = @BusinessTelephoneNumber, [CallbackTelephoneNumber] = @CallbackTelephoneNumber, [CarTelephoneNumber] = @CarTelephoneNumber, [Categories] = @Categories, [Children] = @Children, [xClass] = @xClass, [Companies] = @Companies, [CompanyName] = @CompanyName, [ComputerNetworkName] = @ComputerNetworkName, [Conflicts] = @Conflicts, [ConversationTopic] = @ConversationTopic, [CreationTime] = @CreationTime, [CustomerID] = @CustomerID, [Department] = @Department, [Email1AddressType] = @Email1AddressType, [Email1DisplayName] = @Email1DisplayName, [Email1EntryID] = @Email1EntryID, [Email2Address] = @Email2Address, [Email2AddressType] = @Email2AddressType, [Email2DisplayName] = @Email2DisplayName, [Email2EntryID] = @Email2EntryID, [Email3Address] = @Email3Address, [Email3AddressType] = @Email3AddressType, [Email3DisplayName] = @Email3DisplayName, [Email3EntryID] = @Email3EntryID, [FileAs] = @FileAs, [FirstName] = @FirstName, [FTPSite] = @FTPSite, [Gender] = @Gender, [GovernmentIDNumber] = @GovernmentIDNumber, [Hobby] = @Hobby, [Home2TelephoneNumber] = @Home2TelephoneNumber, [HomeAddress] = @HomeAddress, [HomeAddressCountry] = @HomeAddressCountry, [HomeAddressPostalCode] = @HomeAddressPostalCode, [HomeAddressPostOfficeBox] = @HomeAddressPostOfficeBox, [HomeAddressState] = @HomeAddressState, [HomeAddressStreet] = @HomeAddressStreet, [HomeFaxNumber] = @HomeFaxNumber, [HomeTelephoneNumber] = @HomeTelephoneNumber, [IMAddress] = @IMAddress, [Importance] = @Importance, [Initials] = @Initials, [InternetFreeBusyAddress] = @InternetFreeBusyAddress, [JobTitle] = @JobTitle, [Journal] = @Journal, [Language] = @Language, [LastModificationTime] = @LastModificationTime, [LastName] = @LastName, [LastNameAndFirstName] = @LastNameAndFirstName, [MailingAddress] = @MailingAddress, [MailingAddressCity] = @MailingAddressCity, [MailingAddressCountry] = @MailingAddressCountry, [MailingAddressPostalCode] = @MailingAddressPostalCode, [MailingAddressPostOfficeBox] = @MailingAddressPostOfficeBox, [MailingAddressState] = @MailingAddressState, [MailingAddressStreet] = @MailingAddressStreet, [ManagerName] = @ManagerName, [MiddleName] = @MiddleName, [Mileage] = @Mileage, [MobileTelephoneNumber] = @MobileTelephoneNumber, [NetMeetingAlias] = @NetMeetingAlias, [NetMeetingServer] = @NetMeetingServer, [NickName] = @NickName, [Title] = @Title, [Body] = @Body, [OfficeLocation] = @OfficeLocation, [Subject] = @Subject WHERE [Email1Address] = @Email1AddressOriginal AND [FullName] = @FullNameOriginal AND [UserID] = @UserIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_ContactsArchive.*
FROM
	gv_ContactsArchive
WHERE
	[Email1Address] = @Email1AddressOriginal
	AND [FullName] = @FullNameOriginal
	AND [UserID] = @UserIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_ContainerStorage_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ContainerStorage_Delete]
(
	@StoreCode nvarchar(50),
	@ContainerType nvarchar(25)
)
AS
/*
** Delete a row from the ContainerStorage table
*/
DELETE FROM [ContainerStorage] WHERE [StoreCode] = @StoreCode AND [ContainerType] = @ContainerType

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the ContainerStorage table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_ContainerStorage_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ContainerStorage_Insert]
(
	@StoreCode nvarchar(50),
	@ContainerType nvarchar(25)
)
AS
/*
** Add a row to the ContainerStorage table
*/

INSERT INTO [ContainerStorage]
( [StoreCode], [ContainerType]
)
VALUES
( @StoreCode, @ContainerType
)

/*
** Select the new row
*/
SELECT
	gv_ContainerStorage.*
FROM
	gv_ContainerStorage
WHERE
	[StoreCode] = @StoreCode
	AND [ContainerType] = @ContainerType


GO
/****** Object:  StoredProcedure [dbo].[gp_ContainerStorage_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ContainerStorage_SelectAll]
AS
/*
** Select all rows from the ContainerStorage table
*/

SELECT 
	gv_ContainerStorage.*
FROM
	gv_ContainerStorage
ORDER BY
	[StoreCode],
	[ContainerType]


GO
/****** Object:  StoredProcedure [dbo].[gp_ContainerStorage_SelectByContainerType]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ContainerStorage_SelectByContainerType]
(
	@ContainerType nvarchar(25)
)
AS
/*
** Select rows from the ContainerStorage table by ContainerType
*/
SELECT 
	gv_ContainerStorage.*
FROM
	gv_ContainerStorage WHERE [ContainerType] = @ContainerType ORDER BY [StoreCode], [ContainerType]


GO
/****** Object:  StoredProcedure [dbo].[gp_ContainerStorage_SelectByStoreCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ContainerStorage_SelectByStoreCode]
(
	@StoreCode nvarchar(50)
)
AS
/*
** Select rows from the ContainerStorage table by StoreCode
*/
SELECT 
	gv_ContainerStorage.*
FROM
	gv_ContainerStorage WHERE [StoreCode] = @StoreCode ORDER BY [StoreCode], [ContainerType]


GO
/****** Object:  StoredProcedure [dbo].[gp_ContainerStorage_SelectByStoreCodeAndContainerType]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ContainerStorage_SelectByStoreCodeAndContainerType]
(
	@StoreCode nvarchar(50),
	@ContainerType nvarchar(25)
)
AS
/*
** Select a row from the ContainerStorage table by primary key
*/

SELECT 
	gv_ContainerStorage.*
FROM
	gv_ContainerStorage WHERE [StoreCode] = @StoreCode AND [ContainerType] = @ContainerType


GO
/****** Object:  StoredProcedure [dbo].[gp_ContainerStorage_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ContainerStorage_Update]
(
	@StoreCodeOriginal nvarchar(50), 
	@StoreCode nvarchar(50),
	@ContainerTypeOriginal nvarchar(25), 
	@ContainerType nvarchar(25)
)
AS
/*
** Update a row in the ContainerStorage table using the primary key
*/
UPDATE [ContainerStorage] SET [StoreCode] = @StoreCode, [ContainerType] = @ContainerType WHERE [StoreCode] = @StoreCodeOriginal AND [ContainerType] = @ContainerTypeOriginal


/*
** Select the updated row
*/
SELECT
	gv_ContainerStorage.*
FROM
	gv_ContainerStorage
WHERE
	[StoreCode] = @StoreCodeOriginal
	AND [ContainerType] = @ContainerTypeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_ConvertedDocs_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ConvertedDocs_Delete]
(
	@FQN nvarchar(254),
	@CorpName nvarchar(50)
)
AS
/*
** Delete a row from the ConvertedDocs table
*/
DELETE FROM [ConvertedDocs] WHERE [FQN] = @FQN AND [CorpName] = @CorpName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the ConvertedDocs table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_ConvertedDocs_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ConvertedDocs_Insert]
(
	@FQN nvarchar(254),
	@FileName nvarchar(254),
	@XMLName nvarchar(254),
	@XMLDIr nvarchar(254),
	@FileDir nvarchar(254),
	@CorpName nvarchar(50)
)
AS
/*
** Add a row to the ConvertedDocs table
*/

INSERT INTO [ConvertedDocs]
( [FQN], [FileName], [XMLName], [XMLDIr], [FileDir], [CorpName]
)
VALUES
( @FQN, @FileName, @XMLName, @XMLDIr, @FileDir, @CorpName
)

/*
** Select the new row
*/
SELECT
	gv_ConvertedDocs.*
FROM
	gv_ConvertedDocs
WHERE
	[FQN] = @FQN
	AND [CorpName] = @CorpName


GO
/****** Object:  StoredProcedure [dbo].[gp_ConvertedDocs_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ConvertedDocs_SelectAll]
AS
/*
** Select all rows from the ConvertedDocs table
*/

SELECT 
	gv_ConvertedDocs.*
FROM
	gv_ConvertedDocs
ORDER BY
	[FQN],
	[CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_ConvertedDocs_SelectByCorpName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ConvertedDocs_SelectByCorpName]
(
	@CorpName nvarchar(50)
)
AS
/*
** Select rows from the ConvertedDocs table by CorpName
*/
SELECT 
	gv_ConvertedDocs.*
FROM
	gv_ConvertedDocs WHERE [CorpName] = @CorpName ORDER BY [FQN], [CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_ConvertedDocs_SelectByFQNAndCorpName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ConvertedDocs_SelectByFQNAndCorpName]
(
	@FQN nvarchar(254),
	@CorpName nvarchar(50)
)
AS
/*
** Select a row from the ConvertedDocs table by primary key
*/

SELECT 
	gv_ConvertedDocs.*
FROM
	gv_ConvertedDocs WHERE [FQN] = @FQN AND [CorpName] = @CorpName


GO
/****** Object:  StoredProcedure [dbo].[gp_ConvertedDocs_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ConvertedDocs_Update]
(
	@FQNOriginal nvarchar(254), 
	@FQN nvarchar(254),
	@CorpNameOriginal nvarchar(50), 
	@CorpName nvarchar(50),
	@FileName nvarchar(254),
	@XMLName nvarchar(254),
	@XMLDIr nvarchar(254),
	@FileDir nvarchar(254)
)
AS
/*
** Update a row in the ConvertedDocs table using the primary key
*/
UPDATE [ConvertedDocs] SET [FQN] = @FQN, [FileName] = @FileName, [XMLName] = @XMLName, [XMLDIr] = @XMLDIr, [FileDir] = @FileDir, [CorpName] = @CorpName WHERE [FQN] = @FQNOriginal AND [CorpName] = @CorpNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_ConvertedDocs.*
FROM
	gv_ConvertedDocs
WHERE
	[FQN] = @FQNOriginal
	AND [CorpName] = @CorpNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_CoOwner_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CoOwner_Delete]
(
	@RowId int
)
AS
/*
** Delete a row from the CoOwner table
*/
DELETE FROM [CoOwner] WHERE [RowId] = @RowId

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the CoOwner table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_CoOwner_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CoOwner_Insert]
(
	@CurrentOwnerUserID nvarchar(50),
	@CreateDate datetime,
	@PreviousOwnerUserID nvarchar(50)
)
AS
/*
** Add a row to the CoOwner table
*/

INSERT INTO [CoOwner]
( [CurrentOwnerUserID], [CreateDate], [PreviousOwnerUserID]
)
VALUES
( @CurrentOwnerUserID, @CreateDate, @PreviousOwnerUserID
)

/*
** Select the new row
*/
SELECT
	gv_CoOwner.*
FROM
	gv_CoOwner
WHERE
	[RowId] = (SELECT SCOPE_IDENTITY())


GO
/****** Object:  StoredProcedure [dbo].[gp_CoOwner_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CoOwner_SelectAll]
AS
/*
** Select all rows from the CoOwner table
*/

SELECT 
	gv_CoOwner.*
FROM
	gv_CoOwner
ORDER BY
	[RowId]


GO
/****** Object:  StoredProcedure [dbo].[gp_CoOwner_SelectByCurrentOwnerUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CoOwner_SelectByCurrentOwnerUserID]
(
	@CurrentOwnerUserID nvarchar(50)
)
AS
/*
** Select rows from the CoOwner table by CurrentOwnerUserID
*/
SELECT 
	gv_CoOwner.*
FROM
	gv_CoOwner WHERE [CurrentOwnerUserID] = @CurrentOwnerUserID ORDER BY [RowId]


GO
/****** Object:  StoredProcedure [dbo].[gp_CoOwner_SelectByPreviousOwnerUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CoOwner_SelectByPreviousOwnerUserID]
(
	@PreviousOwnerUserID nvarchar(50)
)
AS
/*
** Select rows from the CoOwner table by PreviousOwnerUserID
*/
SELECT 
	gv_CoOwner.*
FROM
	gv_CoOwner WHERE [PreviousOwnerUserID] = @PreviousOwnerUserID ORDER BY [RowId]


GO
/****** Object:  StoredProcedure [dbo].[gp_CoOwner_SelectByRowId]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CoOwner_SelectByRowId]
(
	@RowId int
)
AS
/*
** Select a row from the CoOwner table by primary key
*/

SELECT 
	gv_CoOwner.*
FROM
	gv_CoOwner WHERE [RowId] = @RowId


GO
/****** Object:  StoredProcedure [dbo].[gp_CoOwner_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CoOwner_Update]
(
	@RowIdOriginal int,
	@CurrentOwnerUserID nvarchar(50),
	@CreateDate datetime,
	@PreviousOwnerUserID nvarchar(50)
)
AS
/*
** Update a row in the CoOwner table using the primary key
*/
UPDATE [CoOwner] SET [CurrentOwnerUserID] = @CurrentOwnerUserID, [CreateDate] = @CreateDate, [PreviousOwnerUserID] = @PreviousOwnerUserID WHERE [RowId] = @RowIdOriginal


/*
** Select the updated row
*/
SELECT
	gv_CoOwner.*
FROM
	gv_CoOwner
WHERE
	[RowId] = @RowIdOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_CorpContainer_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CorpContainer_Delete]
(
	@ContainerType nvarchar(25),
	@CorpFuncName nvarchar(80),
	@CorpName nvarchar(50)
)
AS
/*
** Delete a row from the CorpContainer table
*/
DELETE FROM [CorpContainer] WHERE [ContainerType] = @ContainerType AND [CorpFuncName] = @CorpFuncName AND [CorpName] = @CorpName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the CorpContainer table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_CorpContainer_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CorpContainer_Insert]
(
	@ContainerType nvarchar(25),
	@QtyDocCode nvarchar(10),
	@CorpFuncName nvarchar(80),
	@CorpName nvarchar(50)
)
AS
/*
** Add a row to the CorpContainer table
*/

INSERT INTO [CorpContainer]
( [ContainerType], [QtyDocCode], [CorpFuncName], [CorpName]
)
VALUES
( @ContainerType, @QtyDocCode, @CorpFuncName, @CorpName
)

/*
** Select the new row
*/
SELECT
	gv_CorpContainer.*
FROM
	gv_CorpContainer
WHERE
	[ContainerType] = @ContainerType
	AND [CorpFuncName] = @CorpFuncName
	AND [CorpName] = @CorpName


GO
/****** Object:  StoredProcedure [dbo].[gp_CorpContainer_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CorpContainer_SelectAll]
AS
/*
** Select all rows from the CorpContainer table
*/

SELECT 
	gv_CorpContainer.*
FROM
	gv_CorpContainer
ORDER BY
	[ContainerType],
	[CorpFuncName],
	[CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_CorpContainer_SelectByContainerType]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CorpContainer_SelectByContainerType]
(
	@ContainerType nvarchar(25)
)
AS
/*
** Select rows from the CorpContainer table by ContainerType
*/
SELECT 
	gv_CorpContainer.*
FROM
	gv_CorpContainer WHERE [ContainerType] = @ContainerType ORDER BY [ContainerType], [CorpFuncName], [CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_CorpContainer_SelectByContainerTypeAndCorpFuncNameAndCorpName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CorpContainer_SelectByContainerTypeAndCorpFuncNameAndCorpName]
(
	@ContainerType nvarchar(25),
	@CorpFuncName nvarchar(80),
	@CorpName nvarchar(50)
)
AS
/*
** Select a row from the CorpContainer table by primary key
*/

SELECT 
	gv_CorpContainer.*
FROM
	gv_CorpContainer WHERE [ContainerType] = @ContainerType AND [CorpFuncName] = @CorpFuncName AND [CorpName] = @CorpName


GO
/****** Object:  StoredProcedure [dbo].[gp_CorpContainer_SelectByCorpFuncNameAndCorpName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CorpContainer_SelectByCorpFuncNameAndCorpName]
(
	@CorpFuncName nvarchar(80),
	@CorpName nvarchar(50)
)
AS
/*
** Select rows from the CorpContainer table by CorpFuncName and CorpName
*/
SELECT 
	gv_CorpContainer.*
FROM
	gv_CorpContainer WHERE [CorpFuncName] = @CorpFuncName AND [CorpName] = @CorpName ORDER BY [ContainerType], [CorpFuncName], [CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_CorpContainer_SelectByQtyDocCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CorpContainer_SelectByQtyDocCode]
(
	@QtyDocCode nvarchar(10)
)
AS
/*
** Select rows from the CorpContainer table by QtyDocCode
*/
SELECT 
	gv_CorpContainer.*
FROM
	gv_CorpContainer WHERE [QtyDocCode] = @QtyDocCode ORDER BY [ContainerType], [CorpFuncName], [CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_CorpContainer_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CorpContainer_Update]
(
	@ContainerTypeOriginal nvarchar(25), 
	@ContainerType nvarchar(25),
	@CorpFuncNameOriginal nvarchar(80), 
	@CorpFuncName nvarchar(80),
	@CorpNameOriginal nvarchar(50), 
	@CorpName nvarchar(50),
	@QtyDocCode nvarchar(10)
)
AS
/*
** Update a row in the CorpContainer table using the primary key
*/
UPDATE [CorpContainer] SET [ContainerType] = @ContainerType, [QtyDocCode] = @QtyDocCode, [CorpFuncName] = @CorpFuncName, [CorpName] = @CorpName WHERE [ContainerType] = @ContainerTypeOriginal AND [CorpFuncName] = @CorpFuncNameOriginal AND [CorpName] = @CorpNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_CorpContainer.*
FROM
	gv_CorpContainer
WHERE
	[ContainerType] = @ContainerTypeOriginal
	AND [CorpFuncName] = @CorpFuncNameOriginal
	AND [CorpName] = @CorpNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_CorpFunction_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CorpFunction_Delete]
(
	@CorpFuncName nvarchar(80),
	@CorpName nvarchar(50)
)
AS
/*
** Delete a row from the CorpFunction table
*/
DELETE FROM [CorpFunction] WHERE [CorpFuncName] = @CorpFuncName AND [CorpName] = @CorpName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the CorpFunction table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_CorpFunction_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CorpFunction_Insert]
(
	@CorpFuncName nvarchar(80),
	@CorpFuncDesc nvarchar(4000),
	@CreateDate datetime,
	@CorpName nvarchar(50)
)
AS
/*
** Add a row to the CorpFunction table
*/

INSERT INTO [CorpFunction]
( [CorpFuncName], [CorpFuncDesc], [CreateDate], [CorpName]
)
VALUES
( @CorpFuncName, @CorpFuncDesc, @CreateDate, @CorpName
)

/*
** Select the new row
*/
SELECT
	gv_CorpFunction.*
FROM
	gv_CorpFunction
WHERE
	[CorpFuncName] = @CorpFuncName
	AND [CorpName] = @CorpName


GO
/****** Object:  StoredProcedure [dbo].[gp_CorpFunction_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CorpFunction_SelectAll]
AS
/*
** Select all rows from the CorpFunction table
*/

SELECT 
	gv_CorpFunction.*
FROM
	gv_CorpFunction
ORDER BY
	[CorpFuncName],
	[CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_CorpFunction_SelectByCorpFuncNameAndCorpName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CorpFunction_SelectByCorpFuncNameAndCorpName]
(
	@CorpFuncName nvarchar(80),
	@CorpName nvarchar(50)
)
AS
/*
** Select a row from the CorpFunction table by primary key
*/

SELECT 
	gv_CorpFunction.*
FROM
	gv_CorpFunction WHERE [CorpFuncName] = @CorpFuncName AND [CorpName] = @CorpName


GO
/****** Object:  StoredProcedure [dbo].[gp_CorpFunction_SelectByCorpName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CorpFunction_SelectByCorpName]
(
	@CorpName nvarchar(50)
)
AS
/*
** Select rows from the CorpFunction table by CorpName
*/
SELECT 
	gv_CorpFunction.*
FROM
	gv_CorpFunction WHERE [CorpName] = @CorpName ORDER BY [CorpFuncName], [CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_CorpFunction_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_CorpFunction_Update]
(
	@CorpFuncNameOriginal nvarchar(80), 
	@CorpFuncName nvarchar(80),
	@CorpNameOriginal nvarchar(50), 
	@CorpName nvarchar(50),
	@CorpFuncDesc nvarchar(4000),
	@CreateDate datetime
)
AS
/*
** Update a row in the CorpFunction table using the primary key
*/
UPDATE [CorpFunction] SET [CorpFuncName] = @CorpFuncName, [CorpFuncDesc] = @CorpFuncDesc, [CreateDate] = @CreateDate, [CorpName] = @CorpName WHERE [CorpFuncName] = @CorpFuncNameOriginal AND [CorpName] = @CorpNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_CorpFunction.*
FROM
	gv_CorpFunction
WHERE
	[CorpFuncName] = @CorpFuncNameOriginal
	AND [CorpName] = @CorpNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_Corporation_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Corporation_Delete]
(
	@CorpName nvarchar(50)
)
AS
/*
** Delete a row from the Corporation table
*/
DELETE FROM [Corporation] WHERE [CorpName] = @CorpName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the Corporation table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_Corporation_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Corporation_Insert]
(
	@CorpName nvarchar(50)
)
AS
/*
** Add a row to the Corporation table
*/

INSERT INTO [Corporation]
( [CorpName]
)
VALUES
( @CorpName
)

/*
** Select the new row
*/
SELECT
	gv_Corporation.*
FROM
	gv_Corporation
WHERE
	[CorpName] = @CorpName


GO
/****** Object:  StoredProcedure [dbo].[gp_Corporation_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Corporation_SelectAll]
AS
/*
** Select all rows from the Corporation table
*/

SELECT 
	gv_Corporation.*
FROM
	gv_Corporation
ORDER BY
	[CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_Corporation_SelectByCorpName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Corporation_SelectByCorpName]
(
	@CorpName nvarchar(50)
)
AS
/*
** Select a row from the Corporation table by primary key
*/

SELECT 
	gv_Corporation.*
FROM
	gv_Corporation WHERE [CorpName] = @CorpName


GO
/****** Object:  StoredProcedure [dbo].[gp_Corporation_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Corporation_Update]
(
	@CorpNameOriginal nvarchar(50), 
	@CorpName nvarchar(50)
)
AS
/*
** Update a row in the Corporation table using the primary key
*/
UPDATE [Corporation] SET [CorpName] = @CorpName WHERE [CorpName] = @CorpNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_Corporation.*
FROM
	gv_Corporation
WHERE
	[CorpName] = @CorpNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_Databases_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Databases_Delete]
(
	@DB_ID nvarchar(50)
)
AS
/*
** Delete a row from the Databases table
*/
DELETE FROM [Databases] WHERE [DB_ID] = @DB_ID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the Databases table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_Databases_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Databases_Insert]
(
	@DB_ID nvarchar(50),
	@DB_CONN_STR nvarchar(254)
)
AS
/*
** Add a row to the Databases table
*/

INSERT INTO [Databases]
( [DB_ID], [DB_CONN_STR]
)
VALUES
( @DB_ID, @DB_CONN_STR
)

/*
** Select the new row
*/
SELECT
	gv_Databases.*
FROM
	gv_Databases
WHERE
	[DB_ID] = @DB_ID


GO
/****** Object:  StoredProcedure [dbo].[gp_Databases_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Databases_SelectAll]
AS
/*
** Select all rows from the Databases table
*/

SELECT 
	gv_Databases.*
FROM
	gv_Databases
ORDER BY
	[DB_ID]


GO
/****** Object:  StoredProcedure [dbo].[gp_Databases_SelectByDB_ID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Databases_SelectByDB_ID]
(
	@DB_ID nvarchar(50)
)
AS
/*
** Select a row from the Databases table by primary key
*/

SELECT 
	gv_Databases.*
FROM
	gv_Databases WHERE [DB_ID] = @DB_ID


GO
/****** Object:  StoredProcedure [dbo].[gp_Databases_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Databases_Update]
(
	@DB_IDOriginal nvarchar(50), 
	@DB_ID nvarchar(50),
	@DB_CONN_STR nvarchar(254)
)
AS
/*
** Update a row in the Databases table using the primary key
*/
UPDATE [Databases] SET [DB_ID] = @DB_ID, [DB_CONN_STR] = @DB_CONN_STR WHERE [DB_ID] = @DB_IDOriginal


/*
** Select the updated row
*/
SELECT
	gv_Databases.*
FROM
	gv_Databases
WHERE
	[DB_ID] = @DB_IDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_DataOwners_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataOwners_Delete]
(
	@SourceGuid nvarchar(50),
	@UserID nvarchar(50),
	@GroupOwnerUserID nvarchar(50),
	@GroupName nvarchar(80),
	@DataSourceOwnerUserID nvarchar(50)
)
AS
/*
** Delete a row from the DataOwners table
*/
DELETE FROM [DataOwners] WHERE [SourceGuid] = @SourceGuid AND [UserID] = @UserID AND [GroupOwnerUserID] = @GroupOwnerUserID AND [GroupName] = @GroupName AND [DataSourceOwnerUserID] = @DataSourceOwnerUserID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the DataOwners table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_DataOwners_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataOwners_Insert]
(
	@PrimaryOwner bit,
	@OwnerTypeCode nvarchar(50),
	@FullAccess bit,
	@ReadOnly bit,
	@DeleteAccess bit,
	@Searchable bit,
	@SourceGuid nvarchar(50),
	@UserID nvarchar(50),
	@GroupOwnerUserID nvarchar(50),
	@GroupName nvarchar(80),
	@DataSourceOwnerUserID nvarchar(50)
)
AS
/*
** Add a row to the DataOwners table
*/

INSERT INTO [DataOwners]
( [PrimaryOwner], [OwnerTypeCode], [FullAccess], [ReadOnly], [DeleteAccess], [Searchable], [SourceGuid], [UserID], [GroupOwnerUserID], [GroupName], [DataSourceOwnerUserID]
)
VALUES
( @PrimaryOwner, @OwnerTypeCode, @FullAccess, @ReadOnly, @DeleteAccess, @Searchable, @SourceGuid, @UserID, @GroupOwnerUserID, @GroupName, @DataSourceOwnerUserID
)

/*
** Select the new row
*/
SELECT
	gv_DataOwners.*
FROM
	gv_DataOwners
WHERE
	[SourceGuid] = @SourceGuid
	AND [UserID] = @UserID
	AND [GroupOwnerUserID] = @GroupOwnerUserID
	AND [GroupName] = @GroupName
	AND [DataSourceOwnerUserID] = @DataSourceOwnerUserID


GO
/****** Object:  StoredProcedure [dbo].[gp_DataOwners_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataOwners_SelectAll]
AS
/*
** Select all rows from the DataOwners table
*/

SELECT 
	gv_DataOwners.*
FROM
	gv_DataOwners
ORDER BY
	[SourceGuid],
	[UserID],
	[GroupOwnerUserID],
	[GroupName],
	[DataSourceOwnerUserID]


GO
/****** Object:  StoredProcedure [dbo].[gp_DataOwners_SelectBySourceGuidAndUserIDAndGroupOwnerUserIDAndGroupNameAndDataSourceOwnerUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataOwners_SelectBySourceGuidAndUserIDAndGroupOwnerUserIDAndGroupNameAndDataSourceOwnerUserID]
(
	@SourceGuid nvarchar(50),
	@UserID nvarchar(50),
	@GroupOwnerUserID nvarchar(50),
	@GroupName nvarchar(80),
	@DataSourceOwnerUserID nvarchar(50)
)
AS
/*
** Select a row from the DataOwners table by primary key
*/

SELECT 
	gv_DataOwners.*
FROM
	gv_DataOwners WHERE [SourceGuid] = @SourceGuid AND [UserID] = @UserID AND [GroupOwnerUserID] = @GroupOwnerUserID AND [GroupName] = @GroupName AND [DataSourceOwnerUserID] = @DataSourceOwnerUserID


GO
/****** Object:  StoredProcedure [dbo].[gp_DataOwners_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataOwners_Update]
(
	@SourceGuidOriginal nvarchar(50), 
	@SourceGuid nvarchar(50),
	@UserIDOriginal nvarchar(50), 
	@UserID nvarchar(50),
	@GroupOwnerUserIDOriginal nvarchar(50), 
	@GroupOwnerUserID nvarchar(50),
	@GroupNameOriginal nvarchar(80), 
	@GroupName nvarchar(80),
	@DataSourceOwnerUserIDOriginal nvarchar(50), 
	@DataSourceOwnerUserID nvarchar(50),
	@PrimaryOwner bit,
	@OwnerTypeCode nvarchar(50),
	@FullAccess bit,
	@ReadOnly bit,
	@DeleteAccess bit,
	@Searchable bit
)
AS
/*
** Update a row in the DataOwners table using the primary key
*/
UPDATE [DataOwners] SET [PrimaryOwner] = @PrimaryOwner, [OwnerTypeCode] = @OwnerTypeCode, [FullAccess] = @FullAccess, [ReadOnly] = @ReadOnly, [DeleteAccess] = @DeleteAccess, [Searchable] = @Searchable, [SourceGuid] = @SourceGuid, [UserID] = @UserID, [GroupOwnerUserID] = @GroupOwnerUserID, [GroupName] = @GroupName, [DataSourceOwnerUserID] = @DataSourceOwnerUserID WHERE [SourceGuid] = @SourceGuidOriginal AND [UserID] = @UserIDOriginal AND [GroupOwnerUserID] = @GroupOwnerUserIDOriginal AND [GroupName] = @GroupNameOriginal AND [DataSourceOwnerUserID] = @DataSourceOwnerUserIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_DataOwners.*
FROM
	gv_DataOwners
WHERE
	[SourceGuid] = @SourceGuidOriginal
	AND [UserID] = @UserIDOriginal
	AND [GroupOwnerUserID] = @GroupOwnerUserIDOriginal
	AND [GroupName] = @GroupNameOriginal
	AND [DataSourceOwnerUserID] = @DataSourceOwnerUserIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_DataSource_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataSource_Delete]
(
	@SourceGuid nvarchar(50),
	@DataSourceOwnerUserID nvarchar(50)
)
AS
/*
** Delete a row from the DataSource table
*/
DELETE FROM [DataSource] WHERE [SourceGuid] = @SourceGuid AND [DataSourceOwnerUserID] = @DataSourceOwnerUserID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the DataSource table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_DataSource_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataSource_Insert]
(
	@SourceGuid nvarchar(50),
	@CreateDate datetime,
	@SourceName nvarchar(254),
	@SourceImage image,
	@SourceTypeCode nvarchar(50),
	@FQN nvarchar(254),
	@VersionNbr int,
	@LastAccessDate datetime,
	@FileLength int,
	@LastWriteTime datetime,
	@UserID nvarchar(50),
	@DataSourceOwnerUserID nvarchar(50),
	@isPublic nchar(1),
	@FileDirectory nvarchar(300),
	@OriginalFileType nvarchar(50),
	@RetentionExpirationDate datetime,
	@IsPublicPreviousState nchar(1),
	@isAvailable nchar(1),
	@isContainedWithinZipFile nchar(1),
	@IsZipFile nchar(1),
	@DataVerified bit,
	@ZipFileGuid nvarchar(50),
	@ZipFileFQN nvarchar(254),
	@Description nvarchar(max),
	@KeyWords nvarchar(2000),
	@Notes nvarchar(2000),
	@isPerm nchar(1),
	@isMaster nchar(1),
	@CreationDate datetime,
	@OcrPerformed nchar(1),
	@isGraphic nchar(1),
	@GraphicContainsText nchar(1),
	@OcrText nvarchar(max),
	@ImageHiddenText nvarchar(max),
	@isWebPage nchar(1),
	@ParentGuid nvarchar(50)
)
AS
/*
** Add a row to the DataSource table
*/

INSERT INTO [DataSource]
( [SourceGuid], [CreateDate], [SourceName], [SourceImage], [SourceTypeCode], [FQN], [VersionNbr], [LastAccessDate], [FileLength], [LastWriteTime], [UserID], [DataSourceOwnerUserID], [isPublic], [FileDirectory], [OriginalFileType], [RetentionExpirationDate], [IsPublicPreviousState], [isAvailable], [isContainedWithinZipFile], [IsZipFile], [DataVerified], [ZipFileGuid], [ZipFileFQN], [Description], [KeyWords], [Notes], [isPerm], [isMaster], [CreationDate], [OcrPerformed], [isGraphic], [GraphicContainsText], [OcrText], [ImageHiddenText], [isWebPage], [ParentGuid]
)
VALUES
( @SourceGuid, @CreateDate, @SourceName, @SourceImage, @SourceTypeCode, @FQN, @VersionNbr, @LastAccessDate, @FileLength, @LastWriteTime, @UserID, @DataSourceOwnerUserID, @isPublic, @FileDirectory, @OriginalFileType, @RetentionExpirationDate, @IsPublicPreviousState, @isAvailable, @isContainedWithinZipFile, @IsZipFile, @DataVerified, @ZipFileGuid, @ZipFileFQN, @Description, @KeyWords, @Notes, @isPerm, @isMaster, @CreationDate, @OcrPerformed, @isGraphic, @GraphicContainsText, @OcrText, @ImageHiddenText, @isWebPage, @ParentGuid
)

/*
** Select the new row
*/
SELECT
	gv_DataSource.*
FROM
	gv_DataSource
WHERE
	[SourceGuid] = @SourceGuid
	AND [DataSourceOwnerUserID] = @DataSourceOwnerUserID


GO
/****** Object:  StoredProcedure [dbo].[gp_DataSource_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataSource_SelectAll]
AS
/*
** Select all rows from the DataSource table
*/

SELECT 
	gv_DataSource.*
FROM
	gv_DataSource
ORDER BY
	[SourceGuid],
	[DataSourceOwnerUserID]


GO
/****** Object:  StoredProcedure [dbo].[gp_DataSource_SelectBySourceGuidAndDataSourceOwnerUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataSource_SelectBySourceGuidAndDataSourceOwnerUserID]
(
	@SourceGuid nvarchar(50),
	@DataSourceOwnerUserID nvarchar(50)
)
AS
/*
** Select a row from the DataSource table by primary key
*/

SELECT 
	gv_DataSource.*
FROM
	gv_DataSource WHERE [SourceGuid] = @SourceGuid AND [DataSourceOwnerUserID] = @DataSourceOwnerUserID


GO
/****** Object:  StoredProcedure [dbo].[gp_DataSource_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataSource_Update]
(
	@SourceGuidOriginal nvarchar(50), 
	@SourceGuid nvarchar(50),
	@DataSourceOwnerUserIDOriginal nvarchar(50), 
	@DataSourceOwnerUserID nvarchar(50),
	@CreateDate datetime,
	@SourceName nvarchar(254),
	@SourceImage image,
	@SourceTypeCode nvarchar(50),
	@FQN nvarchar(254),
	@VersionNbr int,
	@LastAccessDate datetime,
	@FileLength int,
	@LastWriteTime datetime,
	@UserID nvarchar(50),
	@isPublic nchar(1),
	@FileDirectory nvarchar(300),
	@OriginalFileType nvarchar(50),
	@RetentionExpirationDate datetime,
	@IsPublicPreviousState nchar(1),
	@isAvailable nchar(1),
	@isContainedWithinZipFile nchar(1),
	@IsZipFile nchar(1),
	@DataVerified bit,
	@ZipFileGuid nvarchar(50),
	@ZipFileFQN nvarchar(254),
	@Description nvarchar(max),
	@KeyWords nvarchar(2000),
	@Notes nvarchar(2000),
	@isPerm nchar(1),
	@isMaster nchar(1),
	@CreationDate datetime,
	@OcrPerformed nchar(1),
	@isGraphic nchar(1),
	@GraphicContainsText nchar(1),
	@OcrText nvarchar(max),
	@ImageHiddenText nvarchar(max),
	@isWebPage nchar(1),
	@ParentGuid nvarchar(50)
)
AS
/*
** Update a row in the DataSource table using the primary key
*/
UPDATE [DataSource] SET [SourceGuid] = @SourceGuid, [CreateDate] = @CreateDate, [SourceName] = @SourceName, [SourceImage] = @SourceImage, [SourceTypeCode] = @SourceTypeCode, [FQN] = @FQN, [VersionNbr] = @VersionNbr, [LastAccessDate] = @LastAccessDate, [FileLength] = @FileLength, [LastWriteTime] = @LastWriteTime, [UserID] = @UserID, [DataSourceOwnerUserID] = @DataSourceOwnerUserID, [isPublic] = @isPublic, [FileDirectory] = @FileDirectory, [OriginalFileType] = @OriginalFileType, [RetentionExpirationDate] = @RetentionExpirationDate, [IsPublicPreviousState] = @IsPublicPreviousState, [isAvailable] = @isAvailable, [isContainedWithinZipFile] = @isContainedWithinZipFile, [IsZipFile] = @IsZipFile, [DataVerified] = @DataVerified, [ZipFileGuid] = @ZipFileGuid, [ZipFileFQN] = @ZipFileFQN, [Description] = @Description, [KeyWords] = @KeyWords, [Notes] = @Notes, [isPerm] = @isPerm, [isMaster] = @isMaster, [CreationDate] = @CreationDate, [OcrPerformed] = @OcrPerformed, [isGraphic] = @isGraphic, [GraphicContainsText] = @GraphicContainsText, [OcrText] = @OcrText, [ImageHiddenText] = @ImageHiddenText, [isWebPage] = @isWebPage, [ParentGuid] = @ParentGuid WHERE [SourceGuid] = @SourceGuidOriginal AND [DataSourceOwnerUserID] = @DataSourceOwnerUserIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_DataSource.*
FROM
	gv_DataSource
WHERE
	[SourceGuid] = @SourceGuidOriginal
	AND [DataSourceOwnerUserID] = @DataSourceOwnerUserIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceCheckOut_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataSourceCheckOut_Delete]
(
	@SourceGuid nvarchar(50),
	@DataSourceOwnerUserID nvarchar(50),
	@CheckedOutByUserID nvarchar(50)
)
AS
/*
** Delete a row from the DataSourceCheckOut table
*/
DELETE FROM [DataSourceCheckOut] WHERE [SourceGuid] = @SourceGuid AND [DataSourceOwnerUserID] = @DataSourceOwnerUserID AND [CheckedOutByUserID] = @CheckedOutByUserID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the DataSourceCheckOut table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceCheckOut_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataSourceCheckOut_Insert]
(
	@SourceGuid nvarchar(50),
	@DataSourceOwnerUserID nvarchar(50),
	@CheckedOutByUserID nvarchar(50),
	@isReadOnly bit,
	@isForUpdate bit,
	@checkOutDate datetime
)
AS
/*
** Add a row to the DataSourceCheckOut table
*/

INSERT INTO [DataSourceCheckOut]
( [SourceGuid], [DataSourceOwnerUserID], [CheckedOutByUserID], [isReadOnly], [isForUpdate], [checkOutDate]
)
VALUES
( @SourceGuid, @DataSourceOwnerUserID, @CheckedOutByUserID, @isReadOnly, @isForUpdate, @checkOutDate
)

/*
** Select the new row
*/
SELECT
	gv_DataSourceCheckOut.*
FROM
	gv_DataSourceCheckOut
WHERE
	[SourceGuid] = @SourceGuid
	AND [DataSourceOwnerUserID] = @DataSourceOwnerUserID
	AND [CheckedOutByUserID] = @CheckedOutByUserID


GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceCheckOut_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataSourceCheckOut_SelectAll]
AS
/*
** Select all rows from the DataSourceCheckOut table
*/

SELECT 
	gv_DataSourceCheckOut.*
FROM
	gv_DataSourceCheckOut
ORDER BY
	[SourceGuid],
	[DataSourceOwnerUserID],
	[CheckedOutByUserID]


GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceCheckOut_SelectByCheckedOutByUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataSourceCheckOut_SelectByCheckedOutByUserID]
(
	@CheckedOutByUserID nvarchar(50)
)
AS
/*
** Select rows from the DataSourceCheckOut table by CheckedOutByUserID
*/
SELECT 
	gv_DataSourceCheckOut.*
FROM
	gv_DataSourceCheckOut WHERE [CheckedOutByUserID] = @CheckedOutByUserID ORDER BY [SourceGuid], [DataSourceOwnerUserID], [CheckedOutByUserID]


GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceCheckOut_SelectByDataSourceOwnerUserIDAndSourceGuid]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataSourceCheckOut_SelectByDataSourceOwnerUserIDAndSourceGuid]
(
	@DataSourceOwnerUserID nvarchar(50),
	@SourceGuid nvarchar(50)
)
AS
/*
** Select rows from the DataSourceCheckOut table by DataSourceOwnerUserID and SourceGuid
*/
SELECT 
	gv_DataSourceCheckOut.*
FROM
	gv_DataSourceCheckOut WHERE [DataSourceOwnerUserID] = @DataSourceOwnerUserID AND [SourceGuid] = @SourceGuid ORDER BY [SourceGuid], [DataSourceOwnerUserID], [CheckedOutByUserID]


GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceCheckOut_SelectBySourceGuidAndDataSourceOwnerUserIDAndCheckedOutByUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataSourceCheckOut_SelectBySourceGuidAndDataSourceOwnerUserIDAndCheckedOutByUserID]
(
	@SourceGuid nvarchar(50),
	@DataSourceOwnerUserID nvarchar(50),
	@CheckedOutByUserID nvarchar(50)
)
AS
/*
** Select a row from the DataSourceCheckOut table by primary key
*/

SELECT 
	gv_DataSourceCheckOut.*
FROM
	gv_DataSourceCheckOut WHERE [SourceGuid] = @SourceGuid AND [DataSourceOwnerUserID] = @DataSourceOwnerUserID AND [CheckedOutByUserID] = @CheckedOutByUserID


GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceCheckOut_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataSourceCheckOut_Update]
(
	@SourceGuidOriginal nvarchar(50), 
	@SourceGuid nvarchar(50),
	@DataSourceOwnerUserIDOriginal nvarchar(50), 
	@DataSourceOwnerUserID nvarchar(50),
	@CheckedOutByUserIDOriginal nvarchar(50), 
	@CheckedOutByUserID nvarchar(50),
	@isReadOnly bit,
	@isForUpdate bit,
	@checkOutDate datetime
)
AS
/*
** Update a row in the DataSourceCheckOut table using the primary key
*/
UPDATE [DataSourceCheckOut] SET [SourceGuid] = @SourceGuid, [DataSourceOwnerUserID] = @DataSourceOwnerUserID, [CheckedOutByUserID] = @CheckedOutByUserID, [isReadOnly] = @isReadOnly, [isForUpdate] = @isForUpdate, [checkOutDate] = @checkOutDate WHERE [SourceGuid] = @SourceGuidOriginal AND [DataSourceOwnerUserID] = @DataSourceOwnerUserIDOriginal AND [CheckedOutByUserID] = @CheckedOutByUserIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_DataSourceCheckOut.*
FROM
	gv_DataSourceCheckOut
WHERE
	[SourceGuid] = @SourceGuidOriginal
	AND [DataSourceOwnerUserID] = @DataSourceOwnerUserIDOriginal
	AND [CheckedOutByUserID] = @CheckedOutByUserIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceRestoreHistory_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataSourceRestoreHistory_Delete]
(
	@SeqNo int
)
AS
/*
** Delete a row from the DataSourceRestoreHistory table
*/
DELETE FROM [DataSourceRestoreHistory] WHERE [SeqNo] = @SeqNo

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the DataSourceRestoreHistory table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceRestoreHistory_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataSourceRestoreHistory_Insert]
(
	@SourceGuid nvarchar(50),
	@RestoredToMachine nvarchar(50),
	@RestoreUserName nvarchar(50),
	@RestoreUserID nvarchar(50),
	@RestoreUserDomain nvarchar(254),
	@RestoreDate datetime,
	@DataSourceOwnerUserID nvarchar(50),
	@TypeContentCode nvarchar(50),
	@CreateDate datetime,
	@DocumentName nvarchar(254),
	@FQN nvarchar(500),
	@VerifiedData nchar(1),
	@OrigCrc nvarchar(50),
	@RestoreCrc nvarchar(50)
)
AS
/*
** Add a row to the DataSourceRestoreHistory table
*/

INSERT INTO [DataSourceRestoreHistory]
( [SourceGuid], [RestoredToMachine], [RestoreUserName], [RestoreUserID], [RestoreUserDomain], [RestoreDate], [DataSourceOwnerUserID], [TypeContentCode], [CreateDate], [DocumentName], [FQN], [VerifiedData], [OrigCrc], [RestoreCrc]
)
VALUES
( @SourceGuid, @RestoredToMachine, @RestoreUserName, @RestoreUserID, @RestoreUserDomain, @RestoreDate, @DataSourceOwnerUserID, @TypeContentCode, @CreateDate, @DocumentName, @FQN, @VerifiedData, @OrigCrc, @RestoreCrc
)

/*
** Select the new row
*/
SELECT
	gv_DataSourceRestoreHistory.*
FROM
	gv_DataSourceRestoreHistory
WHERE
	[SeqNo] = (SELECT SCOPE_IDENTITY())


GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceRestoreHistory_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataSourceRestoreHistory_SelectAll]
AS
/*
** Select all rows from the DataSourceRestoreHistory table
*/

SELECT 
	gv_DataSourceRestoreHistory.*
FROM
	gv_DataSourceRestoreHistory
ORDER BY
	[SeqNo]


GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceRestoreHistory_SelectByDataSourceOwnerUserIDAndSourceGuid]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataSourceRestoreHistory_SelectByDataSourceOwnerUserIDAndSourceGuid]
(
	@DataSourceOwnerUserID nvarchar(50),
	@SourceGuid nvarchar(50)
)
AS
/*
** Select rows from the DataSourceRestoreHistory table by DataSourceOwnerUserID and SourceGuid
*/
SELECT 
	gv_DataSourceRestoreHistory.*
FROM
	gv_DataSourceRestoreHistory WHERE [DataSourceOwnerUserID] = @DataSourceOwnerUserID AND [SourceGuid] = @SourceGuid ORDER BY [SeqNo]


GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceRestoreHistory_SelectBySeqNo]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataSourceRestoreHistory_SelectBySeqNo]
(
	@SeqNo int
)
AS
/*
** Select a row from the DataSourceRestoreHistory table by primary key
*/

SELECT 
	gv_DataSourceRestoreHistory.*
FROM
	gv_DataSourceRestoreHistory WHERE [SeqNo] = @SeqNo


GO
/****** Object:  StoredProcedure [dbo].[gp_DataSourceRestoreHistory_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataSourceRestoreHistory_Update]
(
	@SeqNoOriginal int,
	@SourceGuid nvarchar(50),
	@RestoredToMachine nvarchar(50),
	@RestoreUserName nvarchar(50),
	@RestoreUserID nvarchar(50),
	@RestoreUserDomain nvarchar(254),
	@RestoreDate datetime,
	@DataSourceOwnerUserID nvarchar(50),
	@TypeContentCode nvarchar(50),
	@CreateDate datetime,
	@DocumentName nvarchar(254),
	@FQN nvarchar(500),
	@VerifiedData nchar(1),
	@OrigCrc nvarchar(50),
	@RestoreCrc nvarchar(50)
)
AS
/*
** Update a row in the DataSourceRestoreHistory table using the primary key
*/
UPDATE [DataSourceRestoreHistory] SET [SourceGuid] = @SourceGuid, [RestoredToMachine] = @RestoredToMachine, [RestoreUserName] = @RestoreUserName, [RestoreUserID] = @RestoreUserID, [RestoreUserDomain] = @RestoreUserDomain, [RestoreDate] = @RestoreDate, [DataSourceOwnerUserID] = @DataSourceOwnerUserID, [TypeContentCode] = @TypeContentCode, [CreateDate] = @CreateDate, [DocumentName] = @DocumentName, [FQN] = @FQN, [VerifiedData] = @VerifiedData, [OrigCrc] = @OrigCrc, [RestoreCrc] = @RestoreCrc WHERE [SeqNo] = @SeqNoOriginal


/*
** Select the updated row
*/
SELECT
	gv_DataSourceRestoreHistory.*
FROM
	gv_DataSourceRestoreHistory
WHERE
	[SeqNo] = @SeqNoOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_DataTypeCodes_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataTypeCodes_Delete]
(
	@FileType nvarchar(255)
)
AS
/*
** Delete a row from the DataTypeCodes table
*/
DELETE FROM [DataTypeCodes] WHERE [FileType] = @FileType

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the DataTypeCodes table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_DataTypeCodes_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataTypeCodes_Insert]
(
	@FileType nvarchar(255),
	@VerNbr nvarchar(255),
	@Publisher nvarchar(255),
	@Definition nvarchar(255)
)
AS
/*
** Add a row to the DataTypeCodes table
*/

INSERT INTO [DataTypeCodes]
( [FileType], [VerNbr], [Publisher], [Definition]
)
VALUES
( @FileType, @VerNbr, @Publisher, @Definition
)

/*
** Select the new row
*/
SELECT
	gv_DataTypeCodes.*
FROM
	gv_DataTypeCodes
WHERE
	[FileType] = @FileType


GO
/****** Object:  StoredProcedure [dbo].[gp_DataTypeCodes_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataTypeCodes_SelectAll]
AS
/*
** Select all rows from the DataTypeCodes table
*/

SELECT 
	gv_DataTypeCodes.*
FROM
	gv_DataTypeCodes
ORDER BY
	[FileType]


GO
/****** Object:  StoredProcedure [dbo].[gp_DataTypeCodes_SelectByFileType]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataTypeCodes_SelectByFileType]
(
	@FileType nvarchar(255)
)
AS
/*
** Select a row from the DataTypeCodes table by primary key
*/

SELECT 
	gv_DataTypeCodes.*
FROM
	gv_DataTypeCodes WHERE [FileType] = @FileType


GO
/****** Object:  StoredProcedure [dbo].[gp_DataTypeCodes_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DataTypeCodes_Update]
(
	@FileTypeOriginal nvarchar(255), 
	@FileType nvarchar(255),
	@VerNbr nvarchar(255),
	@Publisher nvarchar(255),
	@Definition nvarchar(255)
)
AS
/*
** Update a row in the DataTypeCodes table using the primary key
*/
UPDATE [DataTypeCodes] SET [FileType] = @FileType, [VerNbr] = @VerNbr, [Publisher] = @Publisher, [Definition] = @Definition WHERE [FileType] = @FileTypeOriginal


/*
** Select the updated row
*/
SELECT
	gv_DataTypeCodes.*
FROM
	gv_DataTypeCodes
WHERE
	[FileType] = @FileTypeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_DB_UpdateHist_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DB_UpdateHist_Delete]
(
	@FixID int,
	@CompanyID nvarchar(50),
	@MachineName nvarchar(50)
)
AS
/*
** Delete a row from the DB_UpdateHist table
*/
DELETE FROM [DB_UpdateHist] WHERE [FixID] = @FixID AND [CompanyID] = @CompanyID AND [MachineName] = @MachineName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the DB_UpdateHist table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_DB_UpdateHist_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DB_UpdateHist_Insert]
(
	@CreateDate datetime,
	@FixID int,
	@DBName nvarchar(50),
	@CompanyID nvarchar(50),
	@MachineName nvarchar(50),
	@Status nvarchar(50)
)
AS
/*
** Add a row to the DB_UpdateHist table
*/

INSERT INTO [DB_UpdateHist]
( [CreateDate], [FixID], [DBName], [CompanyID], [MachineName], [Status]
)
VALUES
( @CreateDate, @FixID, @DBName, @CompanyID, @MachineName, @Status
)

/*
** Select the new row
*/
SELECT
	gv_DB_UpdateHist.*
FROM
	gv_DB_UpdateHist
WHERE
	[FixID] = @FixID
	AND [CompanyID] = @CompanyID
	AND [MachineName] = @MachineName


GO
/****** Object:  StoredProcedure [dbo].[gp_DB_UpdateHist_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DB_UpdateHist_SelectAll]
AS
/*
** Select all rows from the DB_UpdateHist table
*/

SELECT 
	gv_DB_UpdateHist.*
FROM
	gv_DB_UpdateHist
ORDER BY
	[FixID],
	[CompanyID],
	[MachineName]


GO
/****** Object:  StoredProcedure [dbo].[gp_DB_UpdateHist_SelectByFixIDAndCompanyIDAndMachineName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DB_UpdateHist_SelectByFixIDAndCompanyIDAndMachineName]
(
	@FixID int,
	@CompanyID nvarchar(50),
	@MachineName nvarchar(50)
)
AS
/*
** Select a row from the DB_UpdateHist table by primary key
*/

SELECT 
	gv_DB_UpdateHist.*
FROM
	gv_DB_UpdateHist WHERE [FixID] = @FixID AND [CompanyID] = @CompanyID AND [MachineName] = @MachineName


GO
/****** Object:  StoredProcedure [dbo].[gp_DB_UpdateHist_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DB_UpdateHist_Update]
(
	@FixIDOriginal int, 
	@FixID int,
	@CompanyIDOriginal nvarchar(50), 
	@CompanyID nvarchar(50),
	@MachineNameOriginal nvarchar(50), 
	@MachineName nvarchar(50),
	@CreateDate datetime,
	@DBName nvarchar(50),
	@Status nvarchar(50)
)
AS
/*
** Update a row in the DB_UpdateHist table using the primary key
*/
UPDATE [DB_UpdateHist] SET [CreateDate] = @CreateDate, [FixID] = @FixID, [DBName] = @DBName, [CompanyID] = @CompanyID, [MachineName] = @MachineName, [Status] = @Status WHERE [FixID] = @FixIDOriginal AND [CompanyID] = @CompanyIDOriginal AND [MachineName] = @MachineNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_DB_UpdateHist.*
FROM
	gv_DB_UpdateHist
WHERE
	[FixID] = @FixIDOriginal
	AND [CompanyID] = @CompanyIDOriginal
	AND [MachineName] = @MachineNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_DB_Updates_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DB_Updates_Delete]
(
	@FixID int
)
AS
/*
** Delete a row from the DB_Updates table
*/
DELETE FROM [DB_Updates] WHERE [FixID] = @FixID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the DB_Updates table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_DB_Updates_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DB_Updates_Insert]
(
	@SqlStmt nvarchar(max),
	@CreateDate datetime,
	@FixID int,
	@FixDescription nvarchar(4000),
	@DBName nvarchar(50),
	@CompanyID nvarchar(50),
	@MachineName nvarchar(50)
)
AS
/*
** Add a row to the DB_Updates table
*/

INSERT INTO [DB_Updates]
( [SqlStmt], [CreateDate], [FixID], [FixDescription], [DBName], [CompanyID], [MachineName]
)
VALUES
( @SqlStmt, @CreateDate, @FixID, @FixDescription, @DBName, @CompanyID, @MachineName
)

/*
** Select the new row
*/
SELECT
	gv_DB_Updates.*
FROM
	gv_DB_Updates
WHERE
	[FixID] = @FixID


GO
/****** Object:  StoredProcedure [dbo].[gp_DB_Updates_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DB_Updates_SelectAll]
AS
/*
** Select all rows from the DB_Updates table
*/

SELECT 
	gv_DB_Updates.*
FROM
	gv_DB_Updates
ORDER BY
	[FixID]


GO
/****** Object:  StoredProcedure [dbo].[gp_DB_Updates_SelectByFixID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DB_Updates_SelectByFixID]
(
	@FixID int
)
AS
/*
** Select a row from the DB_Updates table by primary key
*/

SELECT 
	gv_DB_Updates.*
FROM
	gv_DB_Updates WHERE [FixID] = @FixID


GO
/****** Object:  StoredProcedure [dbo].[gp_DB_Updates_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DB_Updates_Update]
(
	@FixIDOriginal int, 
	@FixID int,
	@SqlStmt nvarchar(max),
	@CreateDate datetime,
	@FixDescription nvarchar(4000),
	@DBName nvarchar(50),
	@CompanyID nvarchar(50),
	@MachineName nvarchar(50)
)
AS
/*
** Update a row in the DB_Updates table using the primary key
*/
UPDATE [DB_Updates] SET [SqlStmt] = @SqlStmt, [CreateDate] = @CreateDate, [FixID] = @FixID, [FixDescription] = @FixDescription, [DBName] = @DBName, [CompanyID] = @CompanyID, [MachineName] = @MachineName WHERE [FixID] = @FixIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_DB_Updates.*
FROM
	gv_DB_Updates
WHERE
	[FixID] = @FixIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_DeleteFrom_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DeleteFrom_Delete]
(
	@FromEmailAddr nvarchar(254),
	@SenderName varchar(254),
	@UserID varchar(25)
)
AS
/*
** Delete a row from the DeleteFrom table
*/
DELETE FROM [DeleteFrom] WHERE [FromEmailAddr] = @FromEmailAddr AND [SenderName] = @SenderName AND [UserID] = @UserID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the DeleteFrom table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_DeleteFrom_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DeleteFrom_Insert]
(
	@FromEmailAddr nvarchar(254),
	@SenderName varchar(254),
	@UserID varchar(25)
)
AS
/*
** Add a row to the DeleteFrom table
*/

INSERT INTO [DeleteFrom]
( [FromEmailAddr], [SenderName], [UserID]
)
VALUES
( @FromEmailAddr, @SenderName, @UserID
)

/*
** Select the new row
*/
SELECT
	gv_DeleteFrom.*
FROM
	gv_DeleteFrom
WHERE
	[FromEmailAddr] = @FromEmailAddr
	AND [SenderName] = @SenderName
	AND [UserID] = @UserID


GO
/****** Object:  StoredProcedure [dbo].[gp_DeleteFrom_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DeleteFrom_SelectAll]
AS
/*
** Select all rows from the DeleteFrom table
*/

SELECT 
	gv_DeleteFrom.*
FROM
	gv_DeleteFrom
ORDER BY
	[FromEmailAddr],
	[SenderName],
	[UserID]


GO
/****** Object:  StoredProcedure [dbo].[gp_DeleteFrom_SelectByFromEmailAddrAndSenderNameAndUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DeleteFrom_SelectByFromEmailAddrAndSenderNameAndUserID]
(
	@FromEmailAddr nvarchar(254),
	@SenderName varchar(254),
	@UserID varchar(25)
)
AS
/*
** Select a row from the DeleteFrom table by primary key
*/

SELECT 
	gv_DeleteFrom.*
FROM
	gv_DeleteFrom WHERE [FromEmailAddr] = @FromEmailAddr AND [SenderName] = @SenderName AND [UserID] = @UserID


GO
/****** Object:  StoredProcedure [dbo].[gp_DeleteFrom_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_DeleteFrom_Update]
(
	@FromEmailAddrOriginal nvarchar(254), 
	@FromEmailAddr nvarchar(254),
	@SenderNameOriginal varchar(254), 
	@SenderName varchar(254),
	@UserIDOriginal varchar(25), 
	@UserID varchar(25)
)
AS
/*
** Update a row in the DeleteFrom table using the primary key
*/
UPDATE [DeleteFrom] SET [FromEmailAddr] = @FromEmailAddr, [SenderName] = @SenderName, [UserID] = @UserID WHERE [FromEmailAddr] = @FromEmailAddrOriginal AND [SenderName] = @SenderNameOriginal AND [UserID] = @UserIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_DeleteFrom.*
FROM
	gv_DeleteFrom
WHERE
	[FromEmailAddr] = @FromEmailAddrOriginal
	AND [SenderName] = @SenderNameOriginal
	AND [UserID] = @UserIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_Directory_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Directory_Delete]
(
	@UserID nvarchar(50),
	@FQN varchar(254)
)
AS
/*
** Delete a row from the Directory table
*/
DELETE FROM [Directory] WHERE [UserID] = @UserID AND [FQN] = @FQN

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the Directory table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_Directory_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Directory_Insert]
(
	@UserID nvarchar(50),
	@IncludeSubDirs char(1),
	@FQN varchar(254),
	@DB_ID nvarchar(50),
	@VersionFiles char(1),
	@ckMetaData nchar(1),
	@ckPublic nchar(1),
	@ckDisableDir nchar(1),
	@QuickRefEntry char(10),
	@isSysDefault bit,
	@OcrDirectory nchar(1)
)
AS
/*
** Add a row to the Directory table
*/

INSERT INTO [Directory]
( [UserID], [IncludeSubDirs], [FQN], [DB_ID], [VersionFiles], [ckMetaData], [ckPublic], [ckDisableDir], [QuickRefEntry], [isSysDefault], [OcrDirectory]
)
VALUES
( @UserID, @IncludeSubDirs, @FQN, @DB_ID, @VersionFiles, @ckMetaData, @ckPublic, @ckDisableDir, @QuickRefEntry, @isSysDefault, @OcrDirectory
)

/*
** Select the new row
*/
SELECT
	gv_Directory.*
FROM
	gv_Directory
WHERE
	[UserID] = @UserID
	AND [FQN] = @FQN


GO
/****** Object:  StoredProcedure [dbo].[gp_Directory_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Directory_SelectAll]
AS
/*
** Select all rows from the Directory table
*/

SELECT 
	gv_Directory.*
FROM
	gv_Directory
ORDER BY
	[UserID],
	[FQN]


GO
/****** Object:  StoredProcedure [dbo].[gp_Directory_SelectByDB_ID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Directory_SelectByDB_ID]
(
	@DB_ID nvarchar(50)
)
AS
/*
** Select rows from the Directory table by DB_ID
*/
SELECT 
	gv_Directory.*
FROM
	gv_Directory WHERE [DB_ID] = @DB_ID ORDER BY [UserID], [FQN]


GO
/****** Object:  StoredProcedure [dbo].[gp_Directory_SelectByUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Directory_SelectByUserID]
(
	@UserID nvarchar(50)
)
AS
/*
** Select rows from the Directory table by UserID
*/
SELECT 
	gv_Directory.*
FROM
	gv_Directory WHERE [UserID] = @UserID ORDER BY [UserID], [FQN]


GO
/****** Object:  StoredProcedure [dbo].[gp_Directory_SelectByUserIDAndFQN]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Directory_SelectByUserIDAndFQN]
(
	@UserID nvarchar(50),
	@FQN varchar(254)
)
AS
/*
** Select a row from the Directory table by primary key
*/

SELECT 
	gv_Directory.*
FROM
	gv_Directory WHERE [UserID] = @UserID AND [FQN] = @FQN


GO
/****** Object:  StoredProcedure [dbo].[gp_Directory_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Directory_Update]
(
	@UserIDOriginal nvarchar(50), 
	@UserID nvarchar(50),
	@FQNOriginal varchar(254), 
	@FQN varchar(254),
	@IncludeSubDirs char(1),
	@DB_ID nvarchar(50),
	@VersionFiles char(1),
	@ckMetaData nchar(1),
	@ckPublic nchar(1),
	@ckDisableDir nchar(1),
	@QuickRefEntry char(10),
	@isSysDefault bit,
	@OcrDirectory nchar(1)
)
AS
/*
** Update a row in the Directory table using the primary key
*/
UPDATE [Directory] SET [UserID] = @UserID, [IncludeSubDirs] = @IncludeSubDirs, [FQN] = @FQN, [DB_ID] = @DB_ID, [VersionFiles] = @VersionFiles, [ckMetaData] = @ckMetaData, [ckPublic] = @ckPublic, [ckDisableDir] = @ckDisableDir, [QuickRefEntry] = @QuickRefEntry, [isSysDefault] = @isSysDefault, [OcrDirectory] = @OcrDirectory WHERE [UserID] = @UserIDOriginal AND [FQN] = @FQNOriginal


/*
** Select the updated row
*/
SELECT
	gv_Directory.*
FROM
	gv_Directory
WHERE
	[UserID] = @UserIDOriginal
	AND [FQN] = @FQNOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_EcmUser_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EcmUser_Delete]
(
	@EMail nvarchar(50)
)
AS
/*
** Delete a row from the EcmUser table
*/
DELETE FROM [EcmUser] WHERE [EMail] = @EMail

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the EcmUser table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_EcmUser_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EcmUser_Insert]
(
	@EMail nvarchar(50),
	@PhoneNumber nvarchar(20),
	@YourName nvarchar(100),
	@YourCompany nvarchar(50),
	@PassWord nvarchar(50),
	@Authority nchar(1),
	@CreateDate datetime,
	@CompanyID nvarchar(50),
	@LastUpdate datetime
)
AS
/*
** Add a row to the EcmUser table
*/

INSERT INTO [EcmUser]
( [EMail], [PhoneNumber], [YourName], [YourCompany], [PassWord], [Authority], [CreateDate], [CompanyID], [LastUpdate]
)
VALUES
( @EMail, @PhoneNumber, @YourName, @YourCompany, @PassWord, @Authority, @CreateDate, @CompanyID, @LastUpdate
)

/*
** Select the new row
*/
SELECT
	gv_EcmUser.*
FROM
	gv_EcmUser
WHERE
	[EMail] = @EMail


GO
/****** Object:  StoredProcedure [dbo].[gp_EcmUser_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EcmUser_SelectAll]
AS
/*
** Select all rows from the EcmUser table
*/

SELECT 
	gv_EcmUser.*
FROM
	gv_EcmUser
ORDER BY
	[EMail]


GO
/****** Object:  StoredProcedure [dbo].[gp_EcmUser_SelectByEMail]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EcmUser_SelectByEMail]
(
	@EMail nvarchar(50)
)
AS
/*
** Select a row from the EcmUser table by primary key
*/

SELECT 
	gv_EcmUser.*
FROM
	gv_EcmUser WHERE [EMail] = @EMail


GO
/****** Object:  StoredProcedure [dbo].[gp_EcmUser_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EcmUser_Update]
(
	@EMailOriginal nvarchar(50), 
	@EMail nvarchar(50),
	@PhoneNumber nvarchar(20),
	@YourName nvarchar(100),
	@YourCompany nvarchar(50),
	@PassWord nvarchar(50),
	@Authority nchar(1),
	@CreateDate datetime,
	@CompanyID nvarchar(50),
	@LastUpdate datetime
)
AS
/*
** Update a row in the EcmUser table using the primary key
*/
UPDATE [EcmUser] SET [EMail] = @EMail, [PhoneNumber] = @PhoneNumber, [YourName] = @YourName, [YourCompany] = @YourCompany, [PassWord] = @PassWord, [Authority] = @Authority, [CreateDate] = @CreateDate, [CompanyID] = @CompanyID, [LastUpdate] = @LastUpdate WHERE [EMail] = @EMailOriginal


/*
** Select the updated row
*/
SELECT
	gv_EcmUser.*
FROM
	gv_EcmUser
WHERE
	[EMail] = @EMailOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_Email_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Email_Delete]
(
	@EmailGuid nvarchar(50)
)
AS
/*
** Delete a row from the Email table
*/
DELETE FROM [Email] WHERE [EmailGuid] = @EmailGuid

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the Email table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_Email_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Email_Insert]
(
	@EmailGuid nvarchar(50),
	@SUBJECT nvarchar(2000),
	@SentTO nvarchar(2000),
	@Body text,
	@Bcc nvarchar(max),
	@BillingInformation nvarchar(200),
	@CC nvarchar(max),
	@Companies nvarchar(2000),
	@CreationTime datetime,
	@ReadReceiptRequested nvarchar(50),
	@ReceivedByName nvarchar(80),
	@ReceivedTime datetime,
	@AllRecipients nvarchar(max),
	@UserID nvarchar(80),
	@SenderEmailAddress nvarchar(80),
	@SenderName nvarchar(100),
	@Sensitivity nvarchar(50),
	@SentOn datetime,
	@MsgSize int,
	@DeferredDeliveryTime datetime,
	@EntryID varchar(150),
	@ExpiryTime datetime,
	@LastModificationTime datetime,
	@EmailImage image,
	@Accounts nvarchar(2000),
	@ShortSubj nvarchar(250),
	@SourceTypeCode nvarchar(50),
	@OriginalFolder nvarchar(254),
	@StoreID varchar(750),
	@isPublic nchar(1),
	@RetentionExpirationDate datetime,
	@IsPublicPreviousState nchar(1),
	@isAvailable nchar(1),
	@CurrMailFolderID nvarchar(300),
	@isPerm nchar(1),
	@isMaster nchar(1),
	@CreationDate datetime,
	@NbrAttachments int,
	@CRC varchar(50),
	@Description nvarchar(max),
	@KeyWords nvarchar(2000)
)
AS
/*
** Add a row to the Email table
*/

INSERT INTO [Email]
( [EmailGuid], [SUBJECT], [SentTO], [Body], [Bcc], [BillingInformation], [CC], [Companies], [CreationTime], [ReadReceiptRequested], [ReceivedByName], [ReceivedTime], [AllRecipients], [UserID], [SenderEmailAddress], [SenderName], [Sensitivity], [SentOn], [MsgSize], [DeferredDeliveryTime], [EntryID], [ExpiryTime], [LastModificationTime], [EmailImage], [Accounts], [ShortSubj], [SourceTypeCode], [OriginalFolder], [StoreID], [isPublic], [RetentionExpirationDate], [IsPublicPreviousState], [isAvailable], [CurrMailFolderID], [isPerm], [isMaster], [CreationDate], [NbrAttachments], [CRC], [Description], [KeyWords]
)
VALUES
( @EmailGuid, @SUBJECT, @SentTO, @Body, @Bcc, @BillingInformation, @CC, @Companies, @CreationTime, @ReadReceiptRequested, @ReceivedByName, @ReceivedTime, @AllRecipients, @UserID, @SenderEmailAddress, @SenderName, @Sensitivity, @SentOn, @MsgSize, @DeferredDeliveryTime, @EntryID, @ExpiryTime, @LastModificationTime, @EmailImage, @Accounts, @ShortSubj, @SourceTypeCode, @OriginalFolder, @StoreID, @isPublic, @RetentionExpirationDate, @IsPublicPreviousState, @isAvailable, @CurrMailFolderID, @isPerm, @isMaster, @CreationDate, @NbrAttachments, @CRC, @Description, @KeyWords
)

/*
** Select the new row
*/
SELECT
	gv_Email.*
FROM
	gv_Email
WHERE
	[EmailGuid] = @EmailGuid


GO
/****** Object:  StoredProcedure [dbo].[gp_Email_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Email_SelectAll]
AS
/*
** Select all rows from the Email table
*/

SELECT 
	gv_Email.*
FROM
	gv_Email
ORDER BY
	[EmailGuid]


GO
/****** Object:  StoredProcedure [dbo].[gp_Email_SelectByEmailGuid]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Email_SelectByEmailGuid]
(
	@EmailGuid nvarchar(50)
)
AS
/*
** Select a row from the Email table by primary key
*/

SELECT 
	gv_Email.*
FROM
	gv_Email WHERE [EmailGuid] = @EmailGuid


GO
/****** Object:  StoredProcedure [dbo].[gp_Email_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Email_Update]
(
	@EmailGuidOriginal nvarchar(50), 
	@EmailGuid nvarchar(50),
	@SUBJECT nvarchar(2000),
	@SentTO nvarchar(2000),
	@Body text,
	@Bcc nvarchar(max),
	@BillingInformation nvarchar(200),
	@CC nvarchar(max),
	@Companies nvarchar(2000),
	@CreationTime datetime,
	@ReadReceiptRequested nvarchar(50),
	@ReceivedByName nvarchar(80),
	@ReceivedTime datetime,
	@AllRecipients nvarchar(max),
	@UserID nvarchar(80),
	@SenderEmailAddress nvarchar(80),
	@SenderName nvarchar(100),
	@Sensitivity nvarchar(50),
	@SentOn datetime,
	@MsgSize int,
	@DeferredDeliveryTime datetime,
	@EntryID varchar(150),
	@ExpiryTime datetime,
	@LastModificationTime datetime,
	@EmailImage image,
	@Accounts nvarchar(2000),
	@RowID int,
	@ShortSubj nvarchar(250),
	@SourceTypeCode nvarchar(50),
	@OriginalFolder nvarchar(254),
	@StoreID varchar(750),
	@isPublic nchar(1),
	@RetentionExpirationDate datetime,
	@IsPublicPreviousState nchar(1),
	@isAvailable nchar(1),
	@CurrMailFolderID nvarchar(300),
	@isPerm nchar(1),
	@isMaster nchar(1),
	@CreationDate datetime,
	@NbrAttachments int,
	@CRC varchar(50),
	@Description nvarchar(max),
	@KeyWords nvarchar(2000)
)
AS
/*
** Update a row in the Email table using the primary key
*/
UPDATE [Email] SET [EmailGuid] = @EmailGuid, [SUBJECT] = @SUBJECT, [SentTO] = @SentTO, [Body] = @Body, [Bcc] = @Bcc, [BillingInformation] = @BillingInformation, [CC] = @CC, [Companies] = @Companies, [CreationTime] = @CreationTime, [ReadReceiptRequested] = @ReadReceiptRequested, [ReceivedByName] = @ReceivedByName, [ReceivedTime] = @ReceivedTime, [AllRecipients] = @AllRecipients, [UserID] = @UserID, [SenderEmailAddress] = @SenderEmailAddress, [SenderName] = @SenderName, [Sensitivity] = @Sensitivity, [SentOn] = @SentOn, [MsgSize] = @MsgSize, [DeferredDeliveryTime] = @DeferredDeliveryTime, [EntryID] = @EntryID, [ExpiryTime] = @ExpiryTime, [LastModificationTime] = @LastModificationTime, [EmailImage] = @EmailImage, [Accounts] = @Accounts, [ShortSubj] = @ShortSubj, [SourceTypeCode] = @SourceTypeCode, [OriginalFolder] = @OriginalFolder, [StoreID] = @StoreID, [isPublic] = @isPublic, [RetentionExpirationDate] = @RetentionExpirationDate, [IsPublicPreviousState] = @IsPublicPreviousState, [isAvailable] = @isAvailable, [CurrMailFolderID] = @CurrMailFolderID, [isPerm] = @isPerm, [isMaster] = @isMaster, [CreationDate] = @CreationDate, [NbrAttachments] = @NbrAttachments, [CRC] = @CRC, [Description] = @Description, [KeyWords] = @KeyWords WHERE [EmailGuid] = @EmailGuidOriginal


/*
** Select the updated row
*/
SELECT
	gv_Email.*
FROM
	gv_Email
WHERE
	[EmailGuid] = @EmailGuidOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailArchParms_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailArchParms_Delete]
(
	@UserID nvarchar(50),
	@FolderName nvarchar(254)
)
AS
/*
** Delete a row from the EmailArchParms table
*/
DELETE FROM [EmailArchParms] WHERE [UserID] = @UserID AND [FolderName] = @FolderName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the EmailArchParms table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailArchParms_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailArchParms_Insert]
(
	@UserID nvarchar(50),
	@ArchiveEmails char(1),
	@RemoveAfterArchive char(1),
	@SetAsDefaultFolder char(1),
	@ArchiveAfterXDays char(1),
	@RemoveAfterXDays char(1),
	@RemoveXDays int,
	@ArchiveXDays int,
	@FolderName nvarchar(254),
	@DB_ID nvarchar(50),
	@ArchiveOnlyIfRead nchar(1),
	@isSysDefault bit
)
AS
/*
** Add a row to the EmailArchParms table
*/

INSERT INTO [EmailArchParms]
( [UserID], [ArchiveEmails], [RemoveAfterArchive], [SetAsDefaultFolder], [ArchiveAfterXDays], [RemoveAfterXDays], [RemoveXDays], [ArchiveXDays], [FolderName], [DB_ID], [ArchiveOnlyIfRead], [isSysDefault]
)
VALUES
( @UserID, @ArchiveEmails, @RemoveAfterArchive, @SetAsDefaultFolder, @ArchiveAfterXDays, @RemoveAfterXDays, @RemoveXDays, @ArchiveXDays, @FolderName, @DB_ID, @ArchiveOnlyIfRead, @isSysDefault
)

/*
** Select the new row
*/
SELECT
	gv_EmailArchParms.*
FROM
	gv_EmailArchParms
WHERE
	[UserID] = @UserID
	AND [FolderName] = @FolderName


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailArchParms_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailArchParms_SelectAll]
AS
/*
** Select all rows from the EmailArchParms table
*/

SELECT 
	gv_EmailArchParms.*
FROM
	gv_EmailArchParms
ORDER BY
	[UserID],
	[FolderName]


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailArchParms_SelectByDB_ID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailArchParms_SelectByDB_ID]
(
	@DB_ID nvarchar(50)
)
AS
/*
** Select rows from the EmailArchParms table by DB_ID
*/
SELECT 
	gv_EmailArchParms.*
FROM
	gv_EmailArchParms WHERE [DB_ID] = @DB_ID ORDER BY [UserID], [FolderName]


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailArchParms_SelectByUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailArchParms_SelectByUserID]
(
	@UserID nvarchar(50)
)
AS
/*
** Select rows from the EmailArchParms table by UserID
*/
SELECT 
	gv_EmailArchParms.*
FROM
	gv_EmailArchParms WHERE [UserID] = @UserID ORDER BY [UserID], [FolderName]


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailArchParms_SelectByUserIDAndFolderName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailArchParms_SelectByUserIDAndFolderName]
(
	@UserID nvarchar(50),
	@FolderName nvarchar(254)
)
AS
/*
** Select a row from the EmailArchParms table by primary key
*/

SELECT 
	gv_EmailArchParms.*
FROM
	gv_EmailArchParms WHERE [UserID] = @UserID AND [FolderName] = @FolderName


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailArchParms_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailArchParms_Update]
(
	@UserIDOriginal nvarchar(50), 
	@UserID nvarchar(50),
	@FolderNameOriginal nvarchar(254), 
	@FolderName nvarchar(254),
	@ArchiveEmails char(1),
	@RemoveAfterArchive char(1),
	@SetAsDefaultFolder char(1),
	@ArchiveAfterXDays char(1),
	@RemoveAfterXDays char(1),
	@RemoveXDays int,
	@ArchiveXDays int,
	@DB_ID nvarchar(50),
	@ArchiveOnlyIfRead nchar(1),
	@isSysDefault bit
)
AS
/*
** Update a row in the EmailArchParms table using the primary key
*/
UPDATE [EmailArchParms] SET [UserID] = @UserID, [ArchiveEmails] = @ArchiveEmails, [RemoveAfterArchive] = @RemoveAfterArchive, [SetAsDefaultFolder] = @SetAsDefaultFolder, [ArchiveAfterXDays] = @ArchiveAfterXDays, [RemoveAfterXDays] = @RemoveAfterXDays, [RemoveXDays] = @RemoveXDays, [ArchiveXDays] = @ArchiveXDays, [FolderName] = @FolderName, [DB_ID] = @DB_ID, [ArchiveOnlyIfRead] = @ArchiveOnlyIfRead, [isSysDefault] = @isSysDefault WHERE [UserID] = @UserIDOriginal AND [FolderName] = @FolderNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_EmailArchParms.*
FROM
	gv_EmailArchParms
WHERE
	[UserID] = @UserIDOriginal
	AND [FolderName] = @FolderNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailAttachment_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailAttachment_Delete]
(
	@RowID int
)
AS
/*
** Delete a row from the EmailAttachment table
*/
DELETE FROM [EmailAttachment] WHERE [RowID] = @RowID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the EmailAttachment table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailAttachment_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailAttachment_Insert]
(
	@Attachment image,
	@AttachmentName nvarchar(254),
	@EmailGuid nvarchar(50),
	@AttachmentCode nvarchar(50),
	@AttachmentType nvarchar(50),
	@UserID nvarchar(50),
	@isZipFileEntry bit,
	@OcrText nvarchar(max),
	@isPublic char(1)
)
AS
/*
** Add a row to the EmailAttachment table
*/

INSERT INTO [EmailAttachment]
( [Attachment], [AttachmentName], [EmailGuid], [AttachmentCode], [AttachmentType], [UserID], [isZipFileEntry], [OcrText], [isPublic]
)
VALUES
( @Attachment, @AttachmentName, @EmailGuid, @AttachmentCode, @AttachmentType, @UserID, @isZipFileEntry, @OcrText, @isPublic
)

/*
** Select the new row
*/
SELECT
	gv_EmailAttachment.*
FROM
	gv_EmailAttachment
WHERE
	[RowID] = (SELECT SCOPE_IDENTITY())


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailAttachment_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailAttachment_SelectAll]
AS
/*
** Select all rows from the EmailAttachment table
*/

SELECT 
	gv_EmailAttachment.*
FROM
	gv_EmailAttachment
ORDER BY
	[RowID]


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailAttachment_SelectByEmailGuid]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailAttachment_SelectByEmailGuid]
(
	@EmailGuid nvarchar(50)
)
AS
/*
** Select rows from the EmailAttachment table by EmailGuid
*/
SELECT 
	gv_EmailAttachment.*
FROM
	gv_EmailAttachment WHERE [EmailGuid] = @EmailGuid ORDER BY [RowID]


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailAttachment_SelectByRowID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailAttachment_SelectByRowID]
(
	@RowID int
)
AS
/*
** Select a row from the EmailAttachment table by primary key
*/

SELECT 
	gv_EmailAttachment.*
FROM
	gv_EmailAttachment WHERE [RowID] = @RowID


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailAttachment_SelectByUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailAttachment_SelectByUserID]
(
	@UserID nvarchar(50)
)
AS
/*
** Select rows from the EmailAttachment table by UserID
*/
SELECT 
	gv_EmailAttachment.*
FROM
	gv_EmailAttachment WHERE [UserID] = @UserID ORDER BY [RowID]


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailAttachment_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailAttachment_Update]
(
	@RowIDOriginal int,
	@Attachment image,
	@AttachmentName nvarchar(254),
	@EmailGuid nvarchar(50),
	@AttachmentCode nvarchar(50),
	@AttachmentType nvarchar(50),
	@UserID nvarchar(50),
	@isZipFileEntry bit,
	@OcrText nvarchar(max),
	@isPublic char(1)
)
AS
/*
** Update a row in the EmailAttachment table using the primary key
*/
UPDATE [EmailAttachment] SET [Attachment] = @Attachment, [AttachmentName] = @AttachmentName, [EmailGuid] = @EmailGuid, [AttachmentCode] = @AttachmentCode, [AttachmentType] = @AttachmentType, [UserID] = @UserID, [isZipFileEntry] = @isZipFileEntry, [OcrText] = @OcrText, [isPublic] = @isPublic WHERE [RowID] = @RowIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_EmailAttachment.*
FROM
	gv_EmailAttachment
WHERE
	[RowID] = @RowIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailAttachmentSearchList_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailAttachmentSearchList_Insert]
(
	@UserID nvarchar(50),
	@EmailGuid nvarchar(50)
)
AS
/*
** Add a row to the EmailAttachmentSearchList table
*/

INSERT INTO [EmailAttachmentSearchList]
( [UserID], [EmailGuid]
)
VALUES
( @UserID, @EmailGuid
)

/*
** Select the new row
*/
SELECT
	gv_EmailAttachmentSearchList.*
FROM
	gv_EmailAttachmentSearchList


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailAttachmentSearchList_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailAttachmentSearchList_SelectAll]
AS
/*
** Select all rows from the EmailAttachmentSearchList table
*/

SELECT 
	gv_EmailAttachmentSearchList.*
FROM
	gv_EmailAttachmentSearchList


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailAttachmentSearchList_SelectBy]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[gp_EmailAttachmentSearchList_SelectBy] AS PRINT 'ALTER PROC will update this'


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailFolder_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailFolder_Delete]
(
	@UserID nvarchar(80),
	@FolderID nvarchar(100)
)
AS
/*
** Delete a row from the EmailFolder table
*/
DELETE FROM [EmailFolder] WHERE [UserID] = @UserID AND [FolderID] = @FolderID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the EmailFolder table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailFolder_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailFolder_Insert]
(
	@UserID nvarchar(80),
	@FolderName nvarchar(254),
	@ParentFolderName nvarchar(254),
	@FolderID nvarchar(100),
	@ParentFolderID nvarchar(100),
	@SelectedForArchive char(1),
	@StoreID nvarchar(500),
	@isSysDefault bit
)
AS
/*
** Add a row to the EmailFolder table
*/

INSERT INTO [EmailFolder]
( [UserID], [FolderName], [ParentFolderName], [FolderID], [ParentFolderID], [SelectedForArchive], [StoreID], [isSysDefault]
)
VALUES
( @UserID, @FolderName, @ParentFolderName, @FolderID, @ParentFolderID, @SelectedForArchive, @StoreID, @isSysDefault
)

/*
** Select the new row
*/
SELECT
	gv_EmailFolder.*
FROM
	gv_EmailFolder
WHERE
	[UserID] = @UserID
	AND [FolderID] = @FolderID


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailFolder_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailFolder_SelectAll]
AS
/*
** Select all rows from the EmailFolder table
*/

SELECT 
	gv_EmailFolder.*
FROM
	gv_EmailFolder
ORDER BY
	[UserID],
	[FolderID]


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailFolder_SelectByUserIDAndFolderID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailFolder_SelectByUserIDAndFolderID]
(
	@UserID nvarchar(80),
	@FolderID nvarchar(100)
)
AS
/*
** Select a row from the EmailFolder table by primary key
*/

SELECT 
	gv_EmailFolder.*
FROM
	gv_EmailFolder WHERE [UserID] = @UserID AND [FolderID] = @FolderID


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailFolder_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailFolder_Update]
(
	@UserIDOriginal nvarchar(80), 
	@UserID nvarchar(80),
	@FolderIDOriginal nvarchar(100), 
	@FolderID nvarchar(100),
	@FolderName nvarchar(254),
	@ParentFolderName nvarchar(254),
	@ParentFolderID nvarchar(100),
	@SelectedForArchive char(1),
	@StoreID nvarchar(500),
	@isSysDefault bit
)
AS
/*
** Update a row in the EmailFolder table using the primary key
*/
UPDATE [EmailFolder] SET [UserID] = @UserID, [FolderName] = @FolderName, [ParentFolderName] = @ParentFolderName, [FolderID] = @FolderID, [ParentFolderID] = @ParentFolderID, [SelectedForArchive] = @SelectedForArchive, [StoreID] = @StoreID, [isSysDefault] = @isSysDefault WHERE [UserID] = @UserIDOriginal AND [FolderID] = @FolderIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_EmailFolder.*
FROM
	gv_EmailFolder
WHERE
	[UserID] = @UserIDOriginal
	AND [FolderID] = @FolderIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailToDelete_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailToDelete_Insert]
(
	@EmailGuid nvarchar(50),
	@StoreID nvarchar(500),
	@UserID nvarchar(100),
	@MessageID nchar(100)
)
AS
/*
** Add a row to the EmailToDelete table
*/

INSERT INTO [EmailToDelete]
( [EmailGuid], [StoreID], [UserID], [MessageID]
)
VALUES
( @EmailGuid, @StoreID, @UserID, @MessageID
)

/*
** Select the new row
*/
SELECT
	gv_EmailToDelete.*
FROM
	gv_EmailToDelete


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailToDelete_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_EmailToDelete_SelectAll]
AS
/*
** Select all rows from the EmailToDelete table
*/

SELECT 
	gv_EmailToDelete.*
FROM
	gv_EmailToDelete


GO
/****** Object:  StoredProcedure [dbo].[gp_EmailToDelete_SelectBy]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[gp_EmailToDelete_SelectBy] AS PRINT 'ALTER PROC will update this'


GO
/****** Object:  StoredProcedure [dbo].[gp_ExcludedFiles_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ExcludedFiles_Delete]
(
	@UserID nvarchar(50),
	@ExtCode nvarchar(50),
	@FQN varchar(254)
)
AS
/*
** Delete a row from the ExcludedFiles table
*/
DELETE FROM [ExcludedFiles] WHERE [UserID] = @UserID AND [ExtCode] = @ExtCode AND [FQN] = @FQN

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the ExcludedFiles table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_ExcludedFiles_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ExcludedFiles_Insert]
(
	@UserID nvarchar(50),
	@ExtCode nvarchar(50),
	@FQN varchar(254)
)
AS
/*
** Add a row to the ExcludedFiles table
*/

INSERT INTO [ExcludedFiles]
( [UserID], [ExtCode], [FQN]
)
VALUES
( @UserID, @ExtCode, @FQN
)

/*
** Select the new row
*/
SELECT
	gv_ExcludedFiles.*
FROM
	gv_ExcludedFiles
WHERE
	[UserID] = @UserID
	AND [ExtCode] = @ExtCode
	AND [FQN] = @FQN


GO
/****** Object:  StoredProcedure [dbo].[gp_ExcludedFiles_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ExcludedFiles_SelectAll]
AS
/*
** Select all rows from the ExcludedFiles table
*/

SELECT 
	gv_ExcludedFiles.*
FROM
	gv_ExcludedFiles
ORDER BY
	[UserID],
	[ExtCode],
	[FQN]


GO
/****** Object:  StoredProcedure [dbo].[gp_ExcludedFiles_SelectByUserIDAndExtCodeAndFQN]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ExcludedFiles_SelectByUserIDAndExtCodeAndFQN]
(
	@UserID nvarchar(50),
	@ExtCode nvarchar(50),
	@FQN varchar(254)
)
AS
/*
** Select a row from the ExcludedFiles table by primary key
*/

SELECT 
	gv_ExcludedFiles.*
FROM
	gv_ExcludedFiles WHERE [UserID] = @UserID AND [ExtCode] = @ExtCode AND [FQN] = @FQN


GO
/****** Object:  StoredProcedure [dbo].[gp_ExcludedFiles_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ExcludedFiles_Update]
(
	@UserIDOriginal nvarchar(50), 
	@UserID nvarchar(50),
	@ExtCodeOriginal nvarchar(50), 
	@ExtCode nvarchar(50),
	@FQNOriginal varchar(254), 
	@FQN varchar(254)
)
AS
/*
** Update a row in the ExcludedFiles table using the primary key
*/
UPDATE [ExcludedFiles] SET [UserID] = @UserID, [ExtCode] = @ExtCode, [FQN] = @FQN WHERE [UserID] = @UserIDOriginal AND [ExtCode] = @ExtCodeOriginal AND [FQN] = @FQNOriginal


/*
** Select the updated row
*/
SELECT
	gv_ExcludedFiles.*
FROM
	gv_ExcludedFiles
WHERE
	[UserID] = @UserIDOriginal
	AND [ExtCode] = @ExtCodeOriginal
	AND [FQN] = @FQNOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_ExcludeFrom_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ExcludeFrom_Delete]
(
	@FromEmailAddr nvarchar(254),
	@SenderName varchar(254),
	@UserID varchar(25)
)
AS
/*
** Delete a row from the ExcludeFrom table
*/
DELETE FROM [ExcludeFrom] WHERE [FromEmailAddr] = @FromEmailAddr AND [SenderName] = @SenderName AND [UserID] = @UserID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the ExcludeFrom table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_ExcludeFrom_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ExcludeFrom_Insert]
(
	@FromEmailAddr nvarchar(254),
	@SenderName varchar(254),
	@UserID varchar(25)
)
AS
/*
** Add a row to the ExcludeFrom table
*/

INSERT INTO [ExcludeFrom]
( [FromEmailAddr], [SenderName], [UserID]
)
VALUES
( @FromEmailAddr, @SenderName, @UserID
)

/*
** Select the new row
*/
SELECT
	gv_ExcludeFrom.*
FROM
	gv_ExcludeFrom
WHERE
	[FromEmailAddr] = @FromEmailAddr
	AND [SenderName] = @SenderName
	AND [UserID] = @UserID


GO
/****** Object:  StoredProcedure [dbo].[gp_ExcludeFrom_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ExcludeFrom_SelectAll]
AS
/*
** Select all rows from the ExcludeFrom table
*/

SELECT 
	gv_ExcludeFrom.*
FROM
	gv_ExcludeFrom
ORDER BY
	[FromEmailAddr],
	[SenderName],
	[UserID]


GO
/****** Object:  StoredProcedure [dbo].[gp_ExcludeFrom_SelectByFromEmailAddrAndSenderNameAndUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ExcludeFrom_SelectByFromEmailAddrAndSenderNameAndUserID]
(
	@FromEmailAddr nvarchar(254),
	@SenderName varchar(254),
	@UserID varchar(25)
)
AS
/*
** Select a row from the ExcludeFrom table by primary key
*/

SELECT 
	gv_ExcludeFrom.*
FROM
	gv_ExcludeFrom WHERE [FromEmailAddr] = @FromEmailAddr AND [SenderName] = @SenderName AND [UserID] = @UserID


GO
/****** Object:  StoredProcedure [dbo].[gp_ExcludeFrom_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ExcludeFrom_Update]
(
	@FromEmailAddrOriginal nvarchar(254), 
	@FromEmailAddr nvarchar(254),
	@SenderNameOriginal varchar(254), 
	@SenderName varchar(254),
	@UserIDOriginal varchar(25), 
	@UserID varchar(25)
)
AS
/*
** Update a row in the ExcludeFrom table using the primary key
*/
UPDATE [ExcludeFrom] SET [FromEmailAddr] = @FromEmailAddr, [SenderName] = @SenderName, [UserID] = @UserID WHERE [FromEmailAddr] = @FromEmailAddrOriginal AND [SenderName] = @SenderNameOriginal AND [UserID] = @UserIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_ExcludeFrom.*
FROM
	gv_ExcludeFrom
WHERE
	[FromEmailAddr] = @FromEmailAddrOriginal
	AND [SenderName] = @SenderNameOriginal
	AND [UserID] = @UserIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_FilesToDelete_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_FilesToDelete_Delete]
(
	@UserID nvarchar(50),
	@MachineName nvarchar(100),
	@FQN nvarchar(254)
)
AS
/*
** Delete a row from the FilesToDelete table
*/
DELETE FROM [FilesToDelete] WHERE [UserID] = @UserID AND [MachineName] = @MachineName AND [FQN] = @FQN

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the FilesToDelete table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_FilesToDelete_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_FilesToDelete_Insert]
(
	@UserID nvarchar(50),
	@MachineName nvarchar(100),
	@FQN nvarchar(254),
	@PendingDelete bit
)
AS
/*
** Add a row to the FilesToDelete table
*/

INSERT INTO [FilesToDelete]
( [UserID], [MachineName], [FQN], [PendingDelete]
)
VALUES
( @UserID, @MachineName, @FQN, @PendingDelete
)

/*
** Select the new row
*/
SELECT
	gv_FilesToDelete.*
FROM
	gv_FilesToDelete
WHERE
	[UserID] = @UserID
	AND [MachineName] = @MachineName
	AND [FQN] = @FQN


GO
/****** Object:  StoredProcedure [dbo].[gp_FilesToDelete_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_FilesToDelete_SelectAll]
AS
/*
** Select all rows from the FilesToDelete table
*/

SELECT 
	gv_FilesToDelete.*
FROM
	gv_FilesToDelete
ORDER BY
	[UserID],
	[MachineName],
	[FQN]


GO
/****** Object:  StoredProcedure [dbo].[gp_FilesToDelete_SelectByUserIDAndMachineNameAndFQN]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_FilesToDelete_SelectByUserIDAndMachineNameAndFQN]
(
	@UserID nvarchar(50),
	@MachineName nvarchar(100),
	@FQN nvarchar(254)
)
AS
/*
** Select a row from the FilesToDelete table by primary key
*/

SELECT 
	gv_FilesToDelete.*
FROM
	gv_FilesToDelete WHERE [UserID] = @UserID AND [MachineName] = @MachineName AND [FQN] = @FQN


GO
/****** Object:  StoredProcedure [dbo].[gp_FilesToDelete_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_FilesToDelete_Update]
(
	@UserIDOriginal nvarchar(50), 
	@UserID nvarchar(50),
	@MachineNameOriginal nvarchar(100), 
	@MachineName nvarchar(100),
	@FQNOriginal nvarchar(254), 
	@FQN nvarchar(254),
	@PendingDelete bit
)
AS
/*
** Update a row in the FilesToDelete table using the primary key
*/
UPDATE [FilesToDelete] SET [UserID] = @UserID, [MachineName] = @MachineName, [FQN] = @FQN, [PendingDelete] = @PendingDelete WHERE [UserID] = @UserIDOriginal AND [MachineName] = @MachineNameOriginal AND [FQN] = @FQNOriginal


/*
** Select the updated row
*/
SELECT
	gv_FilesToDelete.*
FROM
	gv_FilesToDelete
WHERE
	[UserID] = @UserIDOriginal
	AND [MachineName] = @MachineNameOriginal
	AND [FQN] = @FQNOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_FUncSkipWords_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_FUncSkipWords_Delete]
(
	@CorpFuncName nvarchar(80),
	@tgtWord nvarchar(18),
	@CorpName nvarchar(50)
)
AS
/*
** Delete a row from the FUncSkipWords table
*/
DELETE FROM [FUncSkipWords] WHERE [CorpFuncName] = @CorpFuncName AND [tgtWord] = @tgtWord AND [CorpName] = @CorpName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the FUncSkipWords table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_FUncSkipWords_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_FUncSkipWords_Insert]
(
	@CorpFuncName nvarchar(80),
	@tgtWord nvarchar(18),
	@CorpName nvarchar(50)
)
AS
/*
** Add a row to the FUncSkipWords table
*/

INSERT INTO [FUncSkipWords]
( [CorpFuncName], [tgtWord], [CorpName]
)
VALUES
( @CorpFuncName, @tgtWord, @CorpName
)

/*
** Select the new row
*/
SELECT
	gv_FUncSkipWords.*
FROM
	gv_FUncSkipWords
WHERE
	[CorpFuncName] = @CorpFuncName
	AND [tgtWord] = @tgtWord
	AND [CorpName] = @CorpName


GO
/****** Object:  StoredProcedure [dbo].[gp_FUncSkipWords_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_FUncSkipWords_SelectAll]
AS
/*
** Select all rows from the FUncSkipWords table
*/

SELECT 
	gv_FUncSkipWords.*
FROM
	gv_FUncSkipWords
ORDER BY
	[CorpFuncName],
	[tgtWord],
	[CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_FUncSkipWords_SelectByCorpFuncNameAndCorpName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_FUncSkipWords_SelectByCorpFuncNameAndCorpName]
(
	@CorpFuncName nvarchar(80),
	@CorpName nvarchar(50)
)
AS
/*
** Select rows from the FUncSkipWords table by CorpFuncName and CorpName
*/
SELECT 
	gv_FUncSkipWords.*
FROM
	gv_FUncSkipWords WHERE [CorpFuncName] = @CorpFuncName AND [CorpName] = @CorpName ORDER BY [CorpFuncName], [tgtWord], [CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_FUncSkipWords_SelectByCorpFuncNameAndtgtWordAndCorpName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_FUncSkipWords_SelectByCorpFuncNameAndtgtWordAndCorpName]
(
	@CorpFuncName nvarchar(80),
	@tgtWord nvarchar(18),
	@CorpName nvarchar(50)
)
AS
/*
** Select a row from the FUncSkipWords table by primary key
*/

SELECT 
	gv_FUncSkipWords.*
FROM
	gv_FUncSkipWords WHERE [CorpFuncName] = @CorpFuncName AND [tgtWord] = @tgtWord AND [CorpName] = @CorpName


GO
/****** Object:  StoredProcedure [dbo].[gp_FUncSkipWords_SelectBytgtWord]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_FUncSkipWords_SelectBytgtWord]
(
	@tgtWord nvarchar(18)
)
AS
/*
** Select rows from the FUncSkipWords table by tgtWord
*/
SELECT 
	gv_FUncSkipWords.*
FROM
	gv_FUncSkipWords WHERE [tgtWord] = @tgtWord ORDER BY [CorpFuncName], [tgtWord], [CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_FUncSkipWords_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_FUncSkipWords_Update]
(
	@CorpFuncNameOriginal nvarchar(80), 
	@CorpFuncName nvarchar(80),
	@tgtWordOriginal nvarchar(18), 
	@tgtWord nvarchar(18),
	@CorpNameOriginal nvarchar(50), 
	@CorpName nvarchar(50)
)
AS
/*
** Update a row in the FUncSkipWords table using the primary key
*/
UPDATE [FUncSkipWords] SET [CorpFuncName] = @CorpFuncName, [tgtWord] = @tgtWord, [CorpName] = @CorpName WHERE [CorpFuncName] = @CorpFuncNameOriginal AND [tgtWord] = @tgtWordOriginal AND [CorpName] = @CorpNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_FUncSkipWords.*
FROM
	gv_FUncSkipWords
WHERE
	[CorpFuncName] = @CorpFuncNameOriginal
	AND [tgtWord] = @tgtWordOriginal
	AND [CorpName] = @CorpNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_FunctionProdJargon_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_FunctionProdJargon_Delete]
(
	@CorpFuncName nvarchar(80),
	@JargonCode nvarchar(50),
	@CorpName nvarchar(50)
)
AS
/*
** Delete a row from the FunctionProdJargon table
*/
DELETE FROM [FunctionProdJargon] WHERE [CorpFuncName] = @CorpFuncName AND [JargonCode] = @JargonCode AND [CorpName] = @CorpName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the FunctionProdJargon table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_FunctionProdJargon_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_FunctionProdJargon_Insert]
(
	@KeyFlag binary(50),
	@RepeatDataCode nvarchar(50),
	@CorpFuncName nvarchar(80),
	@JargonCode nvarchar(50),
	@CorpName nvarchar(50)
)
AS
/*
** Add a row to the FunctionProdJargon table
*/

INSERT INTO [FunctionProdJargon]
( [KeyFlag], [RepeatDataCode], [CorpFuncName], [JargonCode], [CorpName]
)
VALUES
( @KeyFlag, @RepeatDataCode, @CorpFuncName, @JargonCode, @CorpName
)

/*
** Select the new row
*/
SELECT
	gv_FunctionProdJargon.*
FROM
	gv_FunctionProdJargon
WHERE
	[CorpFuncName] = @CorpFuncName
	AND [JargonCode] = @JargonCode
	AND [CorpName] = @CorpName


GO
/****** Object:  StoredProcedure [dbo].[gp_FunctionProdJargon_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_FunctionProdJargon_SelectAll]
AS
/*
** Select all rows from the FunctionProdJargon table
*/

SELECT 
	gv_FunctionProdJargon.*
FROM
	gv_FunctionProdJargon
ORDER BY
	[CorpFuncName],
	[JargonCode],
	[CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_FunctionProdJargon_SelectByCorpFuncNameAndCorpName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_FunctionProdJargon_SelectByCorpFuncNameAndCorpName]
(
	@CorpFuncName nvarchar(80),
	@CorpName nvarchar(50)
)
AS
/*
** Select rows from the FunctionProdJargon table by CorpFuncName and CorpName
*/
SELECT 
	gv_FunctionProdJargon.*
FROM
	gv_FunctionProdJargon WHERE [CorpFuncName] = @CorpFuncName AND [CorpName] = @CorpName ORDER BY [CorpFuncName], [JargonCode], [CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_FunctionProdJargon_SelectByCorpFuncNameAndJargonCodeAndCorpName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_FunctionProdJargon_SelectByCorpFuncNameAndJargonCodeAndCorpName]
(
	@CorpFuncName nvarchar(80),
	@JargonCode nvarchar(50),
	@CorpName nvarchar(50)
)
AS
/*
** Select a row from the FunctionProdJargon table by primary key
*/

SELECT 
	gv_FunctionProdJargon.*
FROM
	gv_FunctionProdJargon WHERE [CorpFuncName] = @CorpFuncName AND [JargonCode] = @JargonCode AND [CorpName] = @CorpName


GO
/****** Object:  StoredProcedure [dbo].[gp_FunctionProdJargon_SelectByJargonCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_FunctionProdJargon_SelectByJargonCode]
(
	@JargonCode nvarchar(50)
)
AS
/*
** Select rows from the FunctionProdJargon table by JargonCode
*/
SELECT 
	gv_FunctionProdJargon.*
FROM
	gv_FunctionProdJargon WHERE [JargonCode] = @JargonCode ORDER BY [CorpFuncName], [JargonCode], [CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_FunctionProdJargon_SelectByRepeatDataCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_FunctionProdJargon_SelectByRepeatDataCode]
(
	@RepeatDataCode nvarchar(50)
)
AS
/*
** Select rows from the FunctionProdJargon table by RepeatDataCode
*/
SELECT 
	gv_FunctionProdJargon.*
FROM
	gv_FunctionProdJargon WHERE [RepeatDataCode] = @RepeatDataCode ORDER BY [CorpFuncName], [JargonCode], [CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_FunctionProdJargon_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_FunctionProdJargon_Update]
(
	@CorpFuncNameOriginal nvarchar(80), 
	@CorpFuncName nvarchar(80),
	@JargonCodeOriginal nvarchar(50), 
	@JargonCode nvarchar(50),
	@CorpNameOriginal nvarchar(50), 
	@CorpName nvarchar(50),
	@KeyFlag binary(50),
	@RepeatDataCode nvarchar(50)
)
AS
/*
** Update a row in the FunctionProdJargon table using the primary key
*/
UPDATE [FunctionProdJargon] SET [KeyFlag] = @KeyFlag, [RepeatDataCode] = @RepeatDataCode, [CorpFuncName] = @CorpFuncName, [JargonCode] = @JargonCode, [CorpName] = @CorpName WHERE [CorpFuncName] = @CorpFuncNameOriginal AND [JargonCode] = @JargonCodeOriginal AND [CorpName] = @CorpNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_FunctionProdJargon.*
FROM
	gv_FunctionProdJargon
WHERE
	[CorpFuncName] = @CorpFuncNameOriginal
	AND [JargonCode] = @JargonCodeOriginal
	AND [CorpName] = @CorpNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_GlobalSeachResults_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_GlobalSeachResults_Delete]
(
	@ContentGuid nvarchar(50),
	@UserID nvarchar(50)
)
AS
/*
** Delete a row from the GlobalSeachResults table
*/
DELETE FROM [GlobalSeachResults] WHERE [ContentGuid] = @ContentGuid AND [UserID] = @UserID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the GlobalSeachResults table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_GlobalSeachResults_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_GlobalSeachResults_Insert]
(
	@ContentTitle nvarchar(254),
	@ContentAuthor nvarchar(254),
	@ContentType nvarchar(50),
	@CreateDate nvarchar(50),
	@ContentExt nvarchar(50),
	@ContentGuid nvarchar(50),
	@UserID nvarchar(50),
	@FileName nvarchar(254),
	@FileSize int,
	@NbrOfAttachments int,
	@FromEmailAddress nvarchar(254),
	@AllRecipiants nvarchar(max),
	@Weight int
)
AS
/*
** Add a row to the GlobalSeachResults table
*/

INSERT INTO [GlobalSeachResults]
( [ContentTitle], [ContentAuthor], [ContentType], [CreateDate], [ContentExt], [ContentGuid], [UserID], [FileName], [FileSize], [NbrOfAttachments], [FromEmailAddress], [AllRecipiants], [Weight]
)
VALUES
( @ContentTitle, @ContentAuthor, @ContentType, @CreateDate, @ContentExt, @ContentGuid, @UserID, @FileName, @FileSize, @NbrOfAttachments, @FromEmailAddress, @AllRecipiants, @Weight
)

/*
** Select the new row
*/
SELECT
	gv_GlobalSeachResults.*
FROM
	gv_GlobalSeachResults
WHERE
	[ContentGuid] = @ContentGuid
	AND [UserID] = @UserID


GO
/****** Object:  StoredProcedure [dbo].[gp_GlobalSeachResults_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_GlobalSeachResults_SelectAll]
AS
/*
** Select all rows from the GlobalSeachResults table
*/

SELECT 
	gv_GlobalSeachResults.*
FROM
	gv_GlobalSeachResults
ORDER BY
	[ContentGuid],
	[UserID]


GO
/****** Object:  StoredProcedure [dbo].[gp_GlobalSeachResults_SelectByContentGuidAndUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_GlobalSeachResults_SelectByContentGuidAndUserID]
(
	@ContentGuid nvarchar(50),
	@UserID nvarchar(50)
)
AS
/*
** Select a row from the GlobalSeachResults table by primary key
*/

SELECT 
	gv_GlobalSeachResults.*
FROM
	gv_GlobalSeachResults WHERE [ContentGuid] = @ContentGuid AND [UserID] = @UserID


GO
/****** Object:  StoredProcedure [dbo].[gp_GlobalSeachResults_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_GlobalSeachResults_Update]
(
	@ContentGuidOriginal nvarchar(50), 
	@ContentGuid nvarchar(50),
	@UserIDOriginal nvarchar(50), 
	@UserID nvarchar(50),
	@ContentTitle nvarchar(254),
	@ContentAuthor nvarchar(254),
	@ContentType nvarchar(50),
	@CreateDate nvarchar(50),
	@ContentExt nvarchar(50),
	@FileName nvarchar(254),
	@FileSize int,
	@NbrOfAttachments int,
	@FromEmailAddress nvarchar(254),
	@AllRecipiants nvarchar(max),
	@Weight int
)
AS
/*
** Update a row in the GlobalSeachResults table using the primary key
*/
UPDATE [GlobalSeachResults] SET [ContentTitle] = @ContentTitle, [ContentAuthor] = @ContentAuthor, [ContentType] = @ContentType, [CreateDate] = @CreateDate, [ContentExt] = @ContentExt, [ContentGuid] = @ContentGuid, [UserID] = @UserID, [FileName] = @FileName, [FileSize] = @FileSize, [NbrOfAttachments] = @NbrOfAttachments, [FromEmailAddress] = @FromEmailAddress, [AllRecipiants] = @AllRecipiants, [Weight] = @Weight WHERE [ContentGuid] = @ContentGuidOriginal AND [UserID] = @UserIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_GlobalSeachResults.*
FROM
	gv_GlobalSeachResults
WHERE
	[ContentGuid] = @ContentGuidOriginal
	AND [UserID] = @UserIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_GroupLibraryAccess_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_GroupLibraryAccess_Delete]
(
	@UserID nvarchar(50),
	@LibraryName nvarchar(80),
	@GroupOwnerUserID nvarchar(50),
	@GroupName nvarchar(80)
)
AS
/*
** Delete a row from the GroupLibraryAccess table
*/
DELETE FROM [GroupLibraryAccess] WHERE [UserID] = @UserID AND [LibraryName] = @LibraryName AND [GroupOwnerUserID] = @GroupOwnerUserID AND [GroupName] = @GroupName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the GroupLibraryAccess table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_GroupLibraryAccess_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_GroupLibraryAccess_Insert]
(
	@UserID nvarchar(50),
	@LibraryName nvarchar(80),
	@GroupOwnerUserID nvarchar(50),
	@GroupName nvarchar(80)
)
AS
/*
** Add a row to the GroupLibraryAccess table
*/

INSERT INTO [GroupLibraryAccess]
( [UserID], [LibraryName], [GroupOwnerUserID], [GroupName]
)
VALUES
( @UserID, @LibraryName, @GroupOwnerUserID, @GroupName
)

/*
** Select the new row
*/
SELECT
	gv_GroupLibraryAccess.*
FROM
	gv_GroupLibraryAccess
WHERE
	[UserID] = @UserID
	AND [LibraryName] = @LibraryName
	AND [GroupOwnerUserID] = @GroupOwnerUserID
	AND [GroupName] = @GroupName


GO
/****** Object:  StoredProcedure [dbo].[gp_GroupLibraryAccess_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_GroupLibraryAccess_SelectAll]
AS
/*
** Select all rows from the GroupLibraryAccess table
*/

SELECT 
	gv_GroupLibraryAccess.*
FROM
	gv_GroupLibraryAccess
ORDER BY
	[UserID],
	[LibraryName],
	[GroupOwnerUserID],
	[GroupName]


GO
/****** Object:  StoredProcedure [dbo].[gp_GroupLibraryAccess_SelectByGroupNameAndGroupOwnerUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_GroupLibraryAccess_SelectByGroupNameAndGroupOwnerUserID]
(
	@GroupName nvarchar(80),
	@GroupOwnerUserID nvarchar(50)
)
AS
/*
** Select rows from the GroupLibraryAccess table by GroupName and GroupOwnerUserID
*/
SELECT 
	gv_GroupLibraryAccess.*
FROM
	gv_GroupLibraryAccess WHERE [GroupName] = @GroupName AND [GroupOwnerUserID] = @GroupOwnerUserID ORDER BY [UserID], [LibraryName], [GroupOwnerUserID], [GroupName]


GO
/****** Object:  StoredProcedure [dbo].[gp_GroupLibraryAccess_SelectByLibraryNameAndUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_GroupLibraryAccess_SelectByLibraryNameAndUserID]
(
	@LibraryName nvarchar(80),
	@UserID nvarchar(50)
)
AS
/*
** Select rows from the GroupLibraryAccess table by LibraryName and UserID
*/
SELECT 
	gv_GroupLibraryAccess.*
FROM
	gv_GroupLibraryAccess WHERE [LibraryName] = @LibraryName AND [UserID] = @UserID ORDER BY [UserID], [LibraryName], [GroupOwnerUserID], [GroupName]


GO
/****** Object:  StoredProcedure [dbo].[gp_GroupLibraryAccess_SelectByUserIDAndLibraryNameAndGroupOwnerUserIDAndGroupName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_GroupLibraryAccess_SelectByUserIDAndLibraryNameAndGroupOwnerUserIDAndGroupName]
(
	@UserID nvarchar(50),
	@LibraryName nvarchar(80),
	@GroupOwnerUserID nvarchar(50),
	@GroupName nvarchar(80)
)
AS
/*
** Select a row from the GroupLibraryAccess table by primary key
*/

SELECT 
	gv_GroupLibraryAccess.*
FROM
	gv_GroupLibraryAccess WHERE [UserID] = @UserID AND [LibraryName] = @LibraryName AND [GroupOwnerUserID] = @GroupOwnerUserID AND [GroupName] = @GroupName


GO
/****** Object:  StoredProcedure [dbo].[gp_GroupLibraryAccess_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_GroupLibraryAccess_Update]
(
	@UserIDOriginal nvarchar(50), 
	@UserID nvarchar(50),
	@LibraryNameOriginal nvarchar(80), 
	@LibraryName nvarchar(80),
	@GroupOwnerUserIDOriginal nvarchar(50), 
	@GroupOwnerUserID nvarchar(50),
	@GroupNameOriginal nvarchar(80), 
	@GroupName nvarchar(80)
)
AS
/*
** Update a row in the GroupLibraryAccess table using the primary key
*/
UPDATE [GroupLibraryAccess] SET [UserID] = @UserID, [LibraryName] = @LibraryName, [GroupOwnerUserID] = @GroupOwnerUserID, [GroupName] = @GroupName WHERE [UserID] = @UserIDOriginal AND [LibraryName] = @LibraryNameOriginal AND [GroupOwnerUserID] = @GroupOwnerUserIDOriginal AND [GroupName] = @GroupNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_GroupLibraryAccess.*
FROM
	gv_GroupLibraryAccess
WHERE
	[UserID] = @UserIDOriginal
	AND [LibraryName] = @LibraryNameOriginal
	AND [GroupOwnerUserID] = @GroupOwnerUserIDOriginal
	AND [GroupName] = @GroupNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_GroupUsers_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_GroupUsers_Delete]
(
	@UserID nvarchar(50),
	@GroupOwnerUserID nvarchar(50),
	@GroupName nvarchar(80)
)
AS
/*
** Delete a row from the GroupUsers table
*/
DELETE FROM [GroupUsers] WHERE [UserID] = @UserID AND [GroupOwnerUserID] = @GroupOwnerUserID AND [GroupName] = @GroupName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the GroupUsers table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_GroupUsers_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_GroupUsers_Insert]
(
	@UserID nvarchar(50),
	@FullAccess bit,
	@ReadOnlyAccess bit,
	@DeleteAccess bit,
	@Searchable bit,
	@GroupOwnerUserID nvarchar(50),
	@GroupName nvarchar(80)
)
AS
/*
** Add a row to the GroupUsers table
*/

INSERT INTO [GroupUsers]
( [UserID], [FullAccess], [ReadOnlyAccess], [DeleteAccess], [Searchable], [GroupOwnerUserID], [GroupName]
)
VALUES
( @UserID, @FullAccess, @ReadOnlyAccess, @DeleteAccess, @Searchable, @GroupOwnerUserID, @GroupName
)

/*
** Select the new row
*/
SELECT
	gv_GroupUsers.*
FROM
	gv_GroupUsers
WHERE
	[UserID] = @UserID
	AND [GroupOwnerUserID] = @GroupOwnerUserID
	AND [GroupName] = @GroupName


GO
/****** Object:  StoredProcedure [dbo].[gp_GroupUsers_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_GroupUsers_SelectAll]
AS
/*
** Select all rows from the GroupUsers table
*/

SELECT 
	gv_GroupUsers.*
FROM
	gv_GroupUsers
ORDER BY
	[UserID],
	[GroupOwnerUserID],
	[GroupName]


GO
/****** Object:  StoredProcedure [dbo].[gp_GroupUsers_SelectByUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_GroupUsers_SelectByUserID]
(
	@UserID nvarchar(50)
)
AS
/*
** Select rows from the GroupUsers table by UserID
*/
SELECT 
	gv_GroupUsers.*
FROM
	gv_GroupUsers WHERE [UserID] = @UserID ORDER BY [UserID], [GroupOwnerUserID], [GroupName]


GO
/****** Object:  StoredProcedure [dbo].[gp_GroupUsers_SelectByUserIDAndGroupOwnerUserIDAndGroupName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_GroupUsers_SelectByUserIDAndGroupOwnerUserIDAndGroupName]
(
	@UserID nvarchar(50),
	@GroupOwnerUserID nvarchar(50),
	@GroupName nvarchar(80)
)
AS
/*
** Select a row from the GroupUsers table by primary key
*/

SELECT 
	gv_GroupUsers.*
FROM
	gv_GroupUsers WHERE [UserID] = @UserID AND [GroupOwnerUserID] = @GroupOwnerUserID AND [GroupName] = @GroupName


GO
/****** Object:  StoredProcedure [dbo].[gp_GroupUsers_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_GroupUsers_Update]
(
	@UserIDOriginal nvarchar(50), 
	@UserID nvarchar(50),
	@GroupOwnerUserIDOriginal nvarchar(50), 
	@GroupOwnerUserID nvarchar(50),
	@GroupNameOriginal nvarchar(80), 
	@GroupName nvarchar(80),
	@FullAccess bit,
	@ReadOnlyAccess bit,
	@DeleteAccess bit,
	@Searchable bit
)
AS
/*
** Update a row in the GroupUsers table using the primary key
*/
UPDATE [GroupUsers] SET [UserID] = @UserID, [FullAccess] = @FullAccess, [ReadOnlyAccess] = @ReadOnlyAccess, [DeleteAccess] = @DeleteAccess, [Searchable] = @Searchable, [GroupOwnerUserID] = @GroupOwnerUserID, [GroupName] = @GroupName WHERE [UserID] = @UserIDOriginal AND [GroupOwnerUserID] = @GroupOwnerUserIDOriginal AND [GroupName] = @GroupNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_GroupUsers.*
FROM
	gv_GroupUsers
WHERE
	[UserID] = @UserIDOriginal
	AND [GroupOwnerUserID] = @GroupOwnerUserIDOriginal
	AND [GroupName] = @GroupNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_HelpText_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_HelpText_Delete]
(
	@ScreenName nvarchar(100),
	@WidgetName nvarchar(100)
)
AS
/*
** Delete a row from the HelpText table
*/
DELETE FROM [HelpText] WHERE [ScreenName] = @ScreenName AND [WidgetName] = @WidgetName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the HelpText table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_HelpText_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_HelpText_Insert]
(
	@ScreenName nvarchar(100),
	@HelpText nvarchar(max),
	@WidgetName nvarchar(100),
	@WidgetText nvarchar(254),
	@DisplayHelpText bit,
	@LastUpdate datetime,
	@CreateDate datetime,
	@UpdatedBy nvarchar(50)
)
AS
/*
** Add a row to the HelpText table
*/

INSERT INTO [HelpText]
( [ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [LastUpdate], [CreateDate], [UpdatedBy]
)
VALUES
( @ScreenName, @HelpText, @WidgetName, @WidgetText, @DisplayHelpText, @LastUpdate, @CreateDate, @UpdatedBy
)

/*
** Select the new row
*/
SELECT
	gv_HelpText.*
FROM
	gv_HelpText
WHERE
	[ScreenName] = @ScreenName
	AND [WidgetName] = @WidgetName


GO
/****** Object:  StoredProcedure [dbo].[gp_HelpText_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_HelpText_SelectAll]
AS
/*
** Select all rows from the HelpText table
*/

SELECT 
	gv_HelpText.*
FROM
	gv_HelpText
ORDER BY
	[ScreenName],
	[WidgetName]


GO
/****** Object:  StoredProcedure [dbo].[gp_HelpText_SelectByScreenNameAndWidgetName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_HelpText_SelectByScreenNameAndWidgetName]
(
	@ScreenName nvarchar(100),
	@WidgetName nvarchar(100)
)
AS
/*
** Select a row from the HelpText table by primary key
*/

SELECT 
	gv_HelpText.*
FROM
	gv_HelpText WHERE [ScreenName] = @ScreenName AND [WidgetName] = @WidgetName


GO
/****** Object:  StoredProcedure [dbo].[gp_HelpText_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_HelpText_Update]
(
	@ScreenNameOriginal nvarchar(100), 
	@ScreenName nvarchar(100),
	@WidgetNameOriginal nvarchar(100), 
	@WidgetName nvarchar(100),
	@HelpText nvarchar(max),
	@WidgetText nvarchar(254),
	@DisplayHelpText bit,
	@LastUpdate datetime,
	@CreateDate datetime,
	@UpdatedBy nvarchar(50)
)
AS
/*
** Update a row in the HelpText table using the primary key
*/
UPDATE [HelpText] SET [ScreenName] = @ScreenName, [HelpText] = @HelpText, [WidgetName] = @WidgetName, [WidgetText] = @WidgetText, [DisplayHelpText] = @DisplayHelpText, [LastUpdate] = @LastUpdate, [CreateDate] = @CreateDate, [UpdatedBy] = @UpdatedBy WHERE [ScreenName] = @ScreenNameOriginal AND [WidgetName] = @WidgetNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_HelpText.*
FROM
	gv_HelpText
WHERE
	[ScreenName] = @ScreenNameOriginal
	AND [WidgetName] = @WidgetNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_HelpTextUser_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_HelpTextUser_Insert]
(
	@UserID nvarchar(50),
	@ScreenName nvarchar(100),
	@HelpText nvarchar(max),
	@WidgetName nvarchar(100),
	@WidgetText nvarchar(254),
	@DisplayHelpText bit,
	@CompanyID nvarchar(50),
	@LastUpdate datetime,
	@CreateDate datetime
)
AS
/*
** Add a row to the HelpTextUser table
*/

INSERT INTO [HelpTextUser]
( [UserID], [ScreenName], [HelpText], [WidgetName], [WidgetText], [DisplayHelpText], [CompanyID], [LastUpdate], [CreateDate]
)
VALUES
( @UserID, @ScreenName, @HelpText, @WidgetName, @WidgetText, @DisplayHelpText, @CompanyID, @LastUpdate, @CreateDate
)

/*
** Select the new row
*/
SELECT
	gv_HelpTextUser.*
FROM
	gv_HelpTextUser


GO
/****** Object:  StoredProcedure [dbo].[gp_HelpTextUser_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_HelpTextUser_SelectAll]
AS
/*
** Select all rows from the HelpTextUser table
*/

SELECT 
	gv_HelpTextUser.*
FROM
	gv_HelpTextUser


GO
/****** Object:  StoredProcedure [dbo].[gp_HelpTextUser_SelectBy]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[gp_HelpTextUser_SelectBy] AS PRINT 'ALTER PROC will update this'


GO
/****** Object:  StoredProcedure [dbo].[gp_ImageTypeCodes_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ImageTypeCodes_Delete]
(
	@ImageTypeCode nvarchar(50)
)
AS
/*
** Delete a row from the ImageTypeCodes table
*/
DELETE FROM [ImageTypeCodes] WHERE [ImageTypeCode] = @ImageTypeCode

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the ImageTypeCodes table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_ImageTypeCodes_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ImageTypeCodes_Insert]
(
	@ImageTypeCode nvarchar(50),
	@ImageTypeCodeDesc nvarchar(250)
)
AS
/*
** Add a row to the ImageTypeCodes table
*/

INSERT INTO [ImageTypeCodes]
( [ImageTypeCode], [ImageTypeCodeDesc]
)
VALUES
( @ImageTypeCode, @ImageTypeCodeDesc
)

/*
** Select the new row
*/
SELECT
	gv_ImageTypeCodes.*
FROM
	gv_ImageTypeCodes
WHERE
	[ImageTypeCode] = @ImageTypeCode


GO
/****** Object:  StoredProcedure [dbo].[gp_ImageTypeCodes_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ImageTypeCodes_SelectAll]
AS
/*
** Select all rows from the ImageTypeCodes table
*/

SELECT 
	gv_ImageTypeCodes.*
FROM
	gv_ImageTypeCodes
ORDER BY
	[ImageTypeCode]


GO
/****** Object:  StoredProcedure [dbo].[gp_ImageTypeCodes_SelectByImageTypeCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ImageTypeCodes_SelectByImageTypeCode]
(
	@ImageTypeCode nvarchar(50)
)
AS
/*
** Select a row from the ImageTypeCodes table by primary key
*/

SELECT 
	gv_ImageTypeCodes.*
FROM
	gv_ImageTypeCodes WHERE [ImageTypeCode] = @ImageTypeCode


GO
/****** Object:  StoredProcedure [dbo].[gp_ImageTypeCodes_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ImageTypeCodes_Update]
(
	@ImageTypeCodeOriginal nvarchar(50), 
	@ImageTypeCode nvarchar(50),
	@ImageTypeCodeDesc nvarchar(250)
)
AS
/*
** Update a row in the ImageTypeCodes table using the primary key
*/
UPDATE [ImageTypeCodes] SET [ImageTypeCode] = @ImageTypeCode, [ImageTypeCodeDesc] = @ImageTypeCodeDesc WHERE [ImageTypeCode] = @ImageTypeCodeOriginal


/*
** Select the updated row
*/
SELECT
	gv_ImageTypeCodes.*
FROM
	gv_ImageTypeCodes
WHERE
	[ImageTypeCode] = @ImageTypeCodeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_IncludedFiles_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_IncludedFiles_Delete]
(
	@UserID nvarchar(50),
	@ExtCode nvarchar(50),
	@FQN nvarchar(254)
)
AS
/*
** Delete a row from the IncludedFiles table
*/
DELETE FROM [IncludedFiles] WHERE [UserID] = @UserID AND [ExtCode] = @ExtCode AND [FQN] = @FQN

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the IncludedFiles table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_IncludedFiles_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_IncludedFiles_Insert]
(
	@UserID nvarchar(50),
	@ExtCode nvarchar(50),
	@FQN nvarchar(254)
)
AS
/*
** Add a row to the IncludedFiles table
*/

INSERT INTO [IncludedFiles]
( [UserID], [ExtCode], [FQN]
)
VALUES
( @UserID, @ExtCode, @FQN
)

/*
** Select the new row
*/
SELECT
	gv_IncludedFiles.*
FROM
	gv_IncludedFiles
WHERE
	[UserID] = @UserID
	AND [ExtCode] = @ExtCode
	AND [FQN] = @FQN


GO
/****** Object:  StoredProcedure [dbo].[gp_IncludedFiles_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_IncludedFiles_SelectAll]
AS
/*
** Select all rows from the IncludedFiles table
*/

SELECT 
	gv_IncludedFiles.*
FROM
	gv_IncludedFiles
ORDER BY
	[UserID],
	[ExtCode],
	[FQN]


GO
/****** Object:  StoredProcedure [dbo].[gp_IncludedFiles_SelectByUserIDAndExtCodeAndFQN]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_IncludedFiles_SelectByUserIDAndExtCodeAndFQN]
(
	@UserID nvarchar(50),
	@ExtCode nvarchar(50),
	@FQN nvarchar(254)
)
AS
/*
** Select a row from the IncludedFiles table by primary key
*/

SELECT 
	gv_IncludedFiles.*
FROM
	gv_IncludedFiles WHERE [UserID] = @UserID AND [ExtCode] = @ExtCode AND [FQN] = @FQN


GO
/****** Object:  StoredProcedure [dbo].[gp_IncludedFiles_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_IncludedFiles_Update]
(
	@UserIDOriginal nvarchar(50), 
	@UserID nvarchar(50),
	@ExtCodeOriginal nvarchar(50), 
	@ExtCode nvarchar(50),
	@FQNOriginal nvarchar(254), 
	@FQN nvarchar(254)
)
AS
/*
** Update a row in the IncludedFiles table using the primary key
*/
UPDATE [IncludedFiles] SET [UserID] = @UserID, [ExtCode] = @ExtCode, [FQN] = @FQN WHERE [UserID] = @UserIDOriginal AND [ExtCode] = @ExtCodeOriginal AND [FQN] = @FQNOriginal


/*
** Select the updated row
*/
SELECT
	gv_IncludedFiles.*
FROM
	gv_IncludedFiles
WHERE
	[UserID] = @UserIDOriginal
	AND [ExtCode] = @ExtCodeOriginal
	AND [FQN] = @FQNOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_IncludeImmediate_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_IncludeImmediate_Delete]
(
	@FromEmailAddr nvarchar(254),
	@SenderName varchar(254),
	@UserID varchar(25)
)
AS
/*
** Delete a row from the IncludeImmediate table
*/
DELETE FROM [IncludeImmediate] WHERE [FromEmailAddr] = @FromEmailAddr AND [SenderName] = @SenderName AND [UserID] = @UserID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the IncludeImmediate table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_IncludeImmediate_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_IncludeImmediate_Insert]
(
	@FromEmailAddr nvarchar(254),
	@SenderName varchar(254),
	@UserID varchar(25)
)
AS
/*
** Add a row to the IncludeImmediate table
*/

INSERT INTO [IncludeImmediate]
( [FromEmailAddr], [SenderName], [UserID]
)
VALUES
( @FromEmailAddr, @SenderName, @UserID
)

/*
** Select the new row
*/
SELECT
	gv_IncludeImmediate.*
FROM
	gv_IncludeImmediate
WHERE
	[FromEmailAddr] = @FromEmailAddr
	AND [SenderName] = @SenderName
	AND [UserID] = @UserID


GO
/****** Object:  StoredProcedure [dbo].[gp_IncludeImmediate_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_IncludeImmediate_SelectAll]
AS
/*
** Select all rows from the IncludeImmediate table
*/

SELECT 
	gv_IncludeImmediate.*
FROM
	gv_IncludeImmediate
ORDER BY
	[FromEmailAddr],
	[SenderName],
	[UserID]


GO
/****** Object:  StoredProcedure [dbo].[gp_IncludeImmediate_SelectByFromEmailAddrAndSenderNameAndUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_IncludeImmediate_SelectByFromEmailAddrAndSenderNameAndUserID]
(
	@FromEmailAddr nvarchar(254),
	@SenderName varchar(254),
	@UserID varchar(25)
)
AS
/*
** Select a row from the IncludeImmediate table by primary key
*/

SELECT 
	gv_IncludeImmediate.*
FROM
	gv_IncludeImmediate WHERE [FromEmailAddr] = @FromEmailAddr AND [SenderName] = @SenderName AND [UserID] = @UserID


GO
/****** Object:  StoredProcedure [dbo].[gp_IncludeImmediate_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_IncludeImmediate_Update]
(
	@FromEmailAddrOriginal nvarchar(254), 
	@FromEmailAddr nvarchar(254),
	@SenderNameOriginal varchar(254), 
	@SenderName varchar(254),
	@UserIDOriginal varchar(25), 
	@UserID varchar(25)
)
AS
/*
** Update a row in the IncludeImmediate table using the primary key
*/
UPDATE [IncludeImmediate] SET [FromEmailAddr] = @FromEmailAddr, [SenderName] = @SenderName, [UserID] = @UserID WHERE [FromEmailAddr] = @FromEmailAddrOriginal AND [SenderName] = @SenderNameOriginal AND [UserID] = @UserIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_IncludeImmediate.*
FROM
	gv_IncludeImmediate
WHERE
	[FromEmailAddr] = @FromEmailAddrOriginal
	AND [SenderName] = @SenderNameOriginal
	AND [UserID] = @UserIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_InformationProduct_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_InformationProduct_Delete]
(
	@ContainerType nvarchar(25),
	@CorpFuncName nvarchar(80),
	@CorpName nvarchar(50)
)
AS
/*
** Delete a row from the InformationProduct table
*/
DELETE FROM [InformationProduct] WHERE [ContainerType] = @ContainerType AND [CorpFuncName] = @CorpFuncName AND [CorpName] = @CorpName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the InformationProduct table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_InformationProduct_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_InformationProduct_Insert]
(
	@CreateDate datetime,
	@Code char(10),
	@RetentionCode nvarchar(50),
	@VolitilityCode nvarchar(50),
	@ContainerType nvarchar(25),
	@CorpFuncName nvarchar(80),
	@InfoTypeCode nvarchar(50),
	@CorpName nvarchar(50)
)
AS
/*
** Add a row to the InformationProduct table
*/

INSERT INTO [InformationProduct]
( [CreateDate], [Code], [RetentionCode], [VolitilityCode], [ContainerType], [CorpFuncName], [InfoTypeCode], [CorpName]
)
VALUES
( @CreateDate, @Code, @RetentionCode, @VolitilityCode, @ContainerType, @CorpFuncName, @InfoTypeCode, @CorpName
)

/*
** Select the new row
*/
SELECT
	gv_InformationProduct.*
FROM
	gv_InformationProduct
WHERE
	[ContainerType] = @ContainerType
	AND [CorpFuncName] = @CorpFuncName
	AND [CorpName] = @CorpName


GO
/****** Object:  StoredProcedure [dbo].[gp_InformationProduct_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_InformationProduct_SelectAll]
AS
/*
** Select all rows from the InformationProduct table
*/

SELECT 
	gv_InformationProduct.*
FROM
	gv_InformationProduct
ORDER BY
	[ContainerType],
	[CorpFuncName],
	[CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_InformationProduct_SelectByCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_InformationProduct_SelectByCode]
(
	@Code char(10)
)
AS
/*
** Select rows from the InformationProduct table by Code
*/
SELECT 
	gv_InformationProduct.*
FROM
	gv_InformationProduct WHERE [Code] = @Code ORDER BY [ContainerType], [CorpFuncName], [CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_InformationProduct_SelectByContainerTypeAndCorpFuncNameAndCorpName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_InformationProduct_SelectByContainerTypeAndCorpFuncNameAndCorpName]
(
	@ContainerType nvarchar(25),
	@CorpFuncName nvarchar(80),
	@CorpName nvarchar(50)
)
AS
/*
** Select a row from the InformationProduct table by primary key
*/

SELECT 
	gv_InformationProduct.*
FROM
	gv_InformationProduct WHERE [ContainerType] = @ContainerType AND [CorpFuncName] = @CorpFuncName AND [CorpName] = @CorpName


GO
/****** Object:  StoredProcedure [dbo].[gp_InformationProduct_SelectByInfoTypeCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_InformationProduct_SelectByInfoTypeCode]
(
	@InfoTypeCode nvarchar(50)
)
AS
/*
** Select rows from the InformationProduct table by InfoTypeCode
*/
SELECT 
	gv_InformationProduct.*
FROM
	gv_InformationProduct WHERE [InfoTypeCode] = @InfoTypeCode ORDER BY [ContainerType], [CorpFuncName], [CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_InformationProduct_SelectByRetentionCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_InformationProduct_SelectByRetentionCode]
(
	@RetentionCode nvarchar(50)
)
AS
/*
** Select rows from the InformationProduct table by RetentionCode
*/
SELECT 
	gv_InformationProduct.*
FROM
	gv_InformationProduct WHERE [RetentionCode] = @RetentionCode ORDER BY [ContainerType], [CorpFuncName], [CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_InformationProduct_SelectByVolitilityCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_InformationProduct_SelectByVolitilityCode]
(
	@VolitilityCode nvarchar(50)
)
AS
/*
** Select rows from the InformationProduct table by VolitilityCode
*/
SELECT 
	gv_InformationProduct.*
FROM
	gv_InformationProduct WHERE [VolitilityCode] = @VolitilityCode ORDER BY [ContainerType], [CorpFuncName], [CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_InformationProduct_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_InformationProduct_Update]
(
	@ContainerTypeOriginal nvarchar(25), 
	@ContainerType nvarchar(25),
	@CorpFuncNameOriginal nvarchar(80), 
	@CorpFuncName nvarchar(80),
	@CorpNameOriginal nvarchar(50), 
	@CorpName nvarchar(50),
	@CreateDate datetime,
	@Code char(10),
	@RetentionCode nvarchar(50),
	@VolitilityCode nvarchar(50),
	@InfoTypeCode nvarchar(50)
)
AS
/*
** Update a row in the InformationProduct table using the primary key
*/
UPDATE [InformationProduct] SET [CreateDate] = @CreateDate, [Code] = @Code, [RetentionCode] = @RetentionCode, [VolitilityCode] = @VolitilityCode, [ContainerType] = @ContainerType, [CorpFuncName] = @CorpFuncName, [InfoTypeCode] = @InfoTypeCode, [CorpName] = @CorpName WHERE [ContainerType] = @ContainerTypeOriginal AND [CorpFuncName] = @CorpFuncNameOriginal AND [CorpName] = @CorpNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_InformationProduct.*
FROM
	gv_InformationProduct
WHERE
	[ContainerType] = @ContainerTypeOriginal
	AND [CorpFuncName] = @CorpFuncNameOriginal
	AND [CorpName] = @CorpNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_InformationType_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_InformationType_Delete]
(
	@InfoTypeCode nvarchar(50)
)
AS
/*
** Delete a row from the InformationType table
*/
DELETE FROM [InformationType] WHERE [InfoTypeCode] = @InfoTypeCode

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the InformationType table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_InformationType_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_InformationType_Insert]
(
	@CreateDate datetime,
	@InfoTypeCode nvarchar(50),
	@Description nvarchar(4000)
)
AS
/*
** Add a row to the InformationType table
*/

INSERT INTO [InformationType]
( [CreateDate], [InfoTypeCode], [Description]
)
VALUES
( @CreateDate, @InfoTypeCode, @Description
)

/*
** Select the new row
*/
SELECT
	gv_InformationType.*
FROM
	gv_InformationType
WHERE
	[InfoTypeCode] = @InfoTypeCode


GO
/****** Object:  StoredProcedure [dbo].[gp_InformationType_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_InformationType_SelectAll]
AS
/*
** Select all rows from the InformationType table
*/

SELECT 
	gv_InformationType.*
FROM
	gv_InformationType
ORDER BY
	[InfoTypeCode]


GO
/****** Object:  StoredProcedure [dbo].[gp_InformationType_SelectByInfoTypeCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_InformationType_SelectByInfoTypeCode]
(
	@InfoTypeCode nvarchar(50)
)
AS
/*
** Select a row from the InformationType table by primary key
*/

SELECT 
	gv_InformationType.*
FROM
	gv_InformationType WHERE [InfoTypeCode] = @InfoTypeCode


GO
/****** Object:  StoredProcedure [dbo].[gp_InformationType_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_InformationType_Update]
(
	@InfoTypeCodeOriginal nvarchar(50), 
	@InfoTypeCode nvarchar(50),
	@CreateDate datetime,
	@Description nvarchar(4000)
)
AS
/*
** Update a row in the InformationType table using the primary key
*/
UPDATE [InformationType] SET [CreateDate] = @CreateDate, [InfoTypeCode] = @InfoTypeCode, [Description] = @Description WHERE [InfoTypeCode] = @InfoTypeCodeOriginal


/*
** Select the updated row
*/
SELECT
	gv_InformationType.*
FROM
	gv_InformationType
WHERE
	[InfoTypeCode] = @InfoTypeCodeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_JargonWords_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_JargonWords_Delete]
(
	@tgtWord nvarchar(50),
	@JargonCode nvarchar(50)
)
AS
/*
** Delete a row from the JargonWords table
*/
DELETE FROM [JargonWords] WHERE [tgtWord] = @tgtWord AND [JargonCode] = @JargonCode

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the JargonWords table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_JargonWords_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_JargonWords_Insert]
(
	@tgtWord nvarchar(50),
	@jDesc nvarchar(4000),
	@CreateDate datetime,
	@JargonCode nvarchar(50)
)
AS
/*
** Add a row to the JargonWords table
*/

INSERT INTO [JargonWords]
( [tgtWord], [jDesc], [CreateDate], [JargonCode]
)
VALUES
( @tgtWord, @jDesc, @CreateDate, @JargonCode
)

/*
** Select the new row
*/
SELECT
	gv_JargonWords.*
FROM
	gv_JargonWords
WHERE
	[tgtWord] = @tgtWord
	AND [JargonCode] = @JargonCode


GO
/****** Object:  StoredProcedure [dbo].[gp_JargonWords_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_JargonWords_SelectAll]
AS
/*
** Select all rows from the JargonWords table
*/

SELECT 
	gv_JargonWords.*
FROM
	gv_JargonWords
ORDER BY
	[tgtWord],
	[JargonCode]


GO
/****** Object:  StoredProcedure [dbo].[gp_JargonWords_SelectByJargonCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_JargonWords_SelectByJargonCode]
(
	@JargonCode nvarchar(50)
)
AS
/*
** Select rows from the JargonWords table by JargonCode
*/
SELECT 
	gv_JargonWords.*
FROM
	gv_JargonWords WHERE [JargonCode] = @JargonCode ORDER BY [tgtWord], [JargonCode]


GO
/****** Object:  StoredProcedure [dbo].[gp_JargonWords_SelectBytgtWordAndJargonCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_JargonWords_SelectBytgtWordAndJargonCode]
(
	@tgtWord nvarchar(50),
	@JargonCode nvarchar(50)
)
AS
/*
** Select a row from the JargonWords table by primary key
*/

SELECT 
	gv_JargonWords.*
FROM
	gv_JargonWords WHERE [tgtWord] = @tgtWord AND [JargonCode] = @JargonCode


GO
/****** Object:  StoredProcedure [dbo].[gp_JargonWords_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_JargonWords_Update]
(
	@tgtWordOriginal nvarchar(50), 
	@tgtWord nvarchar(50),
	@JargonCodeOriginal nvarchar(50), 
	@JargonCode nvarchar(50),
	@jDesc nvarchar(4000),
	@CreateDate datetime
)
AS
/*
** Update a row in the JargonWords table using the primary key
*/
UPDATE [JargonWords] SET [tgtWord] = @tgtWord, [jDesc] = @jDesc, [CreateDate] = @CreateDate, [JargonCode] = @JargonCode WHERE [tgtWord] = @tgtWordOriginal AND [JargonCode] = @JargonCodeOriginal


/*
** Select the updated row
*/
SELECT
	gv_JargonWords.*
FROM
	gv_JargonWords
WHERE
	[tgtWord] = @tgtWordOriginal
	AND [JargonCode] = @JargonCodeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_LibDirectory_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibDirectory_Delete]
(
	@DirectoryName nvarchar(254),
	@UserID nvarchar(50),
	@LibraryName nvarchar(80)
)
AS
/*
** Delete a row from the LibDirectory table
*/
DELETE FROM [LibDirectory] WHERE [DirectoryName] = @DirectoryName AND [UserID] = @UserID AND [LibraryName] = @LibraryName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the LibDirectory table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_LibDirectory_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibDirectory_Insert]
(
	@DirectoryName nvarchar(254),
	@UserID nvarchar(50),
	@LibraryName nvarchar(80)
)
AS
/*
** Add a row to the LibDirectory table
*/

INSERT INTO [LibDirectory]
( [DirectoryName], [UserID], [LibraryName]
)
VALUES
( @DirectoryName, @UserID, @LibraryName
)

/*
** Select the new row
*/
SELECT
	gv_LibDirectory.*
FROM
	gv_LibDirectory
WHERE
	[DirectoryName] = @DirectoryName
	AND [UserID] = @UserID
	AND [LibraryName] = @LibraryName


GO
/****** Object:  StoredProcedure [dbo].[gp_LibDirectory_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibDirectory_SelectAll]
AS
/*
** Select all rows from the LibDirectory table
*/

SELECT 
	gv_LibDirectory.*
FROM
	gv_LibDirectory
ORDER BY
	[DirectoryName],
	[UserID],
	[LibraryName]


GO
/****** Object:  StoredProcedure [dbo].[gp_LibDirectory_SelectByDirectoryNameAndUserIDAndLibraryName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibDirectory_SelectByDirectoryNameAndUserIDAndLibraryName]
(
	@DirectoryName nvarchar(254),
	@UserID nvarchar(50),
	@LibraryName nvarchar(80)
)
AS
/*
** Select a row from the LibDirectory table by primary key
*/

SELECT 
	gv_LibDirectory.*
FROM
	gv_LibDirectory WHERE [DirectoryName] = @DirectoryName AND [UserID] = @UserID AND [LibraryName] = @LibraryName


GO
/****** Object:  StoredProcedure [dbo].[gp_LibDirectory_SelectByLibraryNameAndUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibDirectory_SelectByLibraryNameAndUserID]
(
	@LibraryName nvarchar(80),
	@UserID nvarchar(50)
)
AS
/*
** Select rows from the LibDirectory table by LibraryName and UserID
*/
SELECT 
	gv_LibDirectory.*
FROM
	gv_LibDirectory WHERE [LibraryName] = @LibraryName AND [UserID] = @UserID ORDER BY [DirectoryName], [UserID], [LibraryName]


GO
/****** Object:  StoredProcedure [dbo].[gp_LibDirectory_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibDirectory_Update]
(
	@DirectoryNameOriginal nvarchar(254), 
	@DirectoryName nvarchar(254),
	@UserIDOriginal nvarchar(50), 
	@UserID nvarchar(50),
	@LibraryNameOriginal nvarchar(80), 
	@LibraryName nvarchar(80)
)
AS
/*
** Update a row in the LibDirectory table using the primary key
*/
UPDATE [LibDirectory] SET [DirectoryName] = @DirectoryName, [UserID] = @UserID, [LibraryName] = @LibraryName WHERE [DirectoryName] = @DirectoryNameOriginal AND [UserID] = @UserIDOriginal AND [LibraryName] = @LibraryNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_LibDirectory.*
FROM
	gv_LibDirectory
WHERE
	[DirectoryName] = @DirectoryNameOriginal
	AND [UserID] = @UserIDOriginal
	AND [LibraryName] = @LibraryNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_LibEmail_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibEmail_Delete]
(
	@EmailFolderEntryID nvarchar(200),
	@UserID nvarchar(50),
	@LibraryName nvarchar(80)
)
AS
/*
** Delete a row from the LibEmail table
*/
DELETE FROM [LibEmail] WHERE [EmailFolderEntryID] = @EmailFolderEntryID AND [UserID] = @UserID AND [LibraryName] = @LibraryName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the LibEmail table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_LibEmail_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibEmail_Insert]
(
	@EmailFolderEntryID nvarchar(200),
	@UserID nvarchar(50),
	@LibraryName nvarchar(80),
	@FolderName nvarchar(250)
)
AS
/*
** Add a row to the LibEmail table
*/

INSERT INTO [LibEmail]
( [EmailFolderEntryID], [UserID], [LibraryName], [FolderName]
)
VALUES
( @EmailFolderEntryID, @UserID, @LibraryName, @FolderName
)

/*
** Select the new row
*/
SELECT
	gv_LibEmail.*
FROM
	gv_LibEmail
WHERE
	[EmailFolderEntryID] = @EmailFolderEntryID
	AND [UserID] = @UserID
	AND [LibraryName] = @LibraryName


GO
/****** Object:  StoredProcedure [dbo].[gp_LibEmail_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibEmail_SelectAll]
AS
/*
** Select all rows from the LibEmail table
*/

SELECT 
	gv_LibEmail.*
FROM
	gv_LibEmail
ORDER BY
	[EmailFolderEntryID],
	[UserID],
	[LibraryName]


GO
/****** Object:  StoredProcedure [dbo].[gp_LibEmail_SelectByEmailFolderEntryIDAndUserIDAndLibraryName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibEmail_SelectByEmailFolderEntryIDAndUserIDAndLibraryName]
(
	@EmailFolderEntryID nvarchar(200),
	@UserID nvarchar(50),
	@LibraryName nvarchar(80)
)
AS
/*
** Select a row from the LibEmail table by primary key
*/

SELECT 
	gv_LibEmail.*
FROM
	gv_LibEmail WHERE [EmailFolderEntryID] = @EmailFolderEntryID AND [UserID] = @UserID AND [LibraryName] = @LibraryName


GO
/****** Object:  StoredProcedure [dbo].[gp_LibEmail_SelectByLibraryNameAndUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibEmail_SelectByLibraryNameAndUserID]
(
	@LibraryName nvarchar(80),
	@UserID nvarchar(50)
)
AS
/*
** Select rows from the LibEmail table by LibraryName and UserID
*/
SELECT 
	gv_LibEmail.*
FROM
	gv_LibEmail WHERE [LibraryName] = @LibraryName AND [UserID] = @UserID ORDER BY [EmailFolderEntryID], [UserID], [LibraryName]


GO
/****** Object:  StoredProcedure [dbo].[gp_LibEmail_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibEmail_Update]
(
	@EmailFolderEntryIDOriginal nvarchar(200), 
	@EmailFolderEntryID nvarchar(200),
	@UserIDOriginal nvarchar(50), 
	@UserID nvarchar(50),
	@LibraryNameOriginal nvarchar(80), 
	@LibraryName nvarchar(80),
	@FolderName nvarchar(250)
)
AS
/*
** Update a row in the LibEmail table using the primary key
*/
UPDATE [LibEmail] SET [EmailFolderEntryID] = @EmailFolderEntryID, [UserID] = @UserID, [LibraryName] = @LibraryName, [FolderName] = @FolderName WHERE [EmailFolderEntryID] = @EmailFolderEntryIDOriginal AND [UserID] = @UserIDOriginal AND [LibraryName] = @LibraryNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_LibEmail.*
FROM
	gv_LibEmail
WHERE
	[EmailFolderEntryID] = @EmailFolderEntryIDOriginal
	AND [UserID] = @UserIDOriginal
	AND [LibraryName] = @LibraryNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_Library_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Library_Delete]
(
	@UserID nvarchar(50),
	@LibraryName nvarchar(80)
)
AS
/*
** Delete a row from the Library table
*/
DELETE FROM [Library] WHERE [UserID] = @UserID AND [LibraryName] = @LibraryName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the Library table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_Library_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Library_Insert]
(
	@UserID nvarchar(50),
	@LibraryName nvarchar(80),
	@isPublic nchar(1)
)
AS
/*
** Add a row to the Library table
*/

INSERT INTO [Library]
( [UserID], [LibraryName], [isPublic]
)
VALUES
( @UserID, @LibraryName, @isPublic
)

/*
** Select the new row
*/
SELECT
	gv_Library.*
FROM
	gv_Library
WHERE
	[UserID] = @UserID
	AND [LibraryName] = @LibraryName


GO
/****** Object:  StoredProcedure [dbo].[gp_Library_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Library_SelectAll]
AS
/*
** Select all rows from the Library table
*/

SELECT 
	gv_Library.*
FROM
	gv_Library
ORDER BY
	[UserID],
	[LibraryName]


GO
/****** Object:  StoredProcedure [dbo].[gp_Library_SelectByUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Library_SelectByUserID]
(
	@UserID nvarchar(50)
)
AS
/*
** Select rows from the Library table by UserID
*/
SELECT 
	gv_Library.*
FROM
	gv_Library WHERE [UserID] = @UserID ORDER BY [UserID], [LibraryName]


GO
/****** Object:  StoredProcedure [dbo].[gp_Library_SelectByUserIDAndLibraryName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Library_SelectByUserIDAndLibraryName]
(
	@UserID nvarchar(50),
	@LibraryName nvarchar(80)
)
AS
/*
** Select a row from the Library table by primary key
*/

SELECT 
	gv_Library.*
FROM
	gv_Library WHERE [UserID] = @UserID AND [LibraryName] = @LibraryName


GO
/****** Object:  StoredProcedure [dbo].[gp_Library_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Library_Update]
(
	@UserIDOriginal nvarchar(50), 
	@UserID nvarchar(50),
	@LibraryNameOriginal nvarchar(80), 
	@LibraryName nvarchar(80),
	@isPublic nchar(1)
)
AS
/*
** Update a row in the Library table using the primary key
*/
UPDATE [Library] SET [UserID] = @UserID, [LibraryName] = @LibraryName, [isPublic] = @isPublic WHERE [UserID] = @UserIDOriginal AND [LibraryName] = @LibraryNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_Library.*
FROM
	gv_Library
WHERE
	[UserID] = @UserIDOriginal
	AND [LibraryName] = @LibraryNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryItems_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibraryItems_Delete]
(
	@LibraryItemGuid nvarchar(50),
	@LibraryOwnerUserID nvarchar(50),
	@LibraryName nvarchar(80)
)
AS
/*
** Delete a row from the LibraryItems table
*/
DELETE FROM [LibraryItems] WHERE [LibraryItemGuid] = @LibraryItemGuid AND [LibraryOwnerUserID] = @LibraryOwnerUserID AND [LibraryName] = @LibraryName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the LibraryItems table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryItems_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibraryItems_Insert]
(
	@SourceGuid nvarchar(50),
	@ItemTitle nvarchar(254),
	@ItemType nvarchar(50),
	@LibraryItemGuid nvarchar(50),
	@DataSourceOwnerUserID nvarchar(50),
	@LibraryOwnerUserID nvarchar(50),
	@LibraryName nvarchar(80),
	@AddedByUserGuidId nvarchar(50)
)
AS
/*
** Add a row to the LibraryItems table
*/

INSERT INTO [LibraryItems]
( [SourceGuid], [ItemTitle], [ItemType], [LibraryItemGuid], [DataSourceOwnerUserID], [LibraryOwnerUserID], [LibraryName], [AddedByUserGuidId]
)
VALUES
( @SourceGuid, @ItemTitle, @ItemType, @LibraryItemGuid, @DataSourceOwnerUserID, @LibraryOwnerUserID, @LibraryName, @AddedByUserGuidId
)

/*
** Select the new row
*/
SELECT
	gv_LibraryItems.*
FROM
	gv_LibraryItems
WHERE
	[LibraryItemGuid] = @LibraryItemGuid
	AND [LibraryOwnerUserID] = @LibraryOwnerUserID
	AND [LibraryName] = @LibraryName


GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryItems_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibraryItems_SelectAll]
AS
/*
** Select all rows from the LibraryItems table
*/

SELECT 
	gv_LibraryItems.*
FROM
	gv_LibraryItems
ORDER BY
	[LibraryItemGuid],
	[LibraryOwnerUserID],
	[LibraryName]


GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryItems_SelectByLibraryItemGuidAndLibraryOwnerUserIDAndLibraryName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibraryItems_SelectByLibraryItemGuidAndLibraryOwnerUserIDAndLibraryName]
(
	@LibraryItemGuid nvarchar(50),
	@LibraryOwnerUserID nvarchar(50),
	@LibraryName nvarchar(80)
)
AS
/*
** Select a row from the LibraryItems table by primary key
*/

SELECT 
	gv_LibraryItems.*
FROM
	gv_LibraryItems WHERE [LibraryItemGuid] = @LibraryItemGuid AND [LibraryOwnerUserID] = @LibraryOwnerUserID AND [LibraryName] = @LibraryName


GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryItems_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibraryItems_Update]
(
	@LibraryItemGuidOriginal nvarchar(50), 
	@LibraryItemGuid nvarchar(50),
	@LibraryOwnerUserIDOriginal nvarchar(50), 
	@LibraryOwnerUserID nvarchar(50),
	@LibraryNameOriginal nvarchar(80), 
	@LibraryName nvarchar(80),
	@SourceGuid nvarchar(50),
	@ItemTitle nvarchar(254),
	@ItemType nvarchar(50),
	@DataSourceOwnerUserID nvarchar(50),
	@AddedByUserGuidId nvarchar(50)
)
AS
/*
** Update a row in the LibraryItems table using the primary key
*/
UPDATE [LibraryItems] SET [SourceGuid] = @SourceGuid, [ItemTitle] = @ItemTitle, [ItemType] = @ItemType, [LibraryItemGuid] = @LibraryItemGuid, [DataSourceOwnerUserID] = @DataSourceOwnerUserID, [LibraryOwnerUserID] = @LibraryOwnerUserID, [LibraryName] = @LibraryName, [AddedByUserGuidId] = @AddedByUserGuidId WHERE [LibraryItemGuid] = @LibraryItemGuidOriginal AND [LibraryOwnerUserID] = @LibraryOwnerUserIDOriginal AND [LibraryName] = @LibraryNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_LibraryItems.*
FROM
	gv_LibraryItems
WHERE
	[LibraryItemGuid] = @LibraryItemGuidOriginal
	AND [LibraryOwnerUserID] = @LibraryOwnerUserIDOriginal
	AND [LibraryName] = @LibraryNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryUsers_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibraryUsers_Delete]
(
	@UserID nvarchar(50),
	@LibraryOwnerUserID nvarchar(50),
	@LibraryName nvarchar(80)
)
AS
/*
** Delete a row from the LibraryUsers table
*/
DELETE FROM [LibraryUsers] WHERE [UserID] = @UserID AND [LibraryOwnerUserID] = @LibraryOwnerUserID AND [LibraryName] = @LibraryName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the LibraryUsers table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryUsers_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibraryUsers_Insert]
(
	@ReadOnly bit,
	@CreateAccess bit,
	@UpdateAccess bit,
	@DeleteAccess bit,
	@UserID nvarchar(50),
	@LibraryOwnerUserID nvarchar(50),
	@LibraryName nvarchar(80)
)
AS
/*
** Add a row to the LibraryUsers table
*/

INSERT INTO [LibraryUsers]
( [ReadOnly], [CreateAccess], [UpdateAccess], [DeleteAccess], [UserID], [LibraryOwnerUserID], [LibraryName]
)
VALUES
( @ReadOnly, @CreateAccess, @UpdateAccess, @DeleteAccess, @UserID, @LibraryOwnerUserID, @LibraryName
)

/*
** Select the new row
*/
SELECT
	gv_LibraryUsers.*
FROM
	gv_LibraryUsers
WHERE
	[UserID] = @UserID
	AND [LibraryOwnerUserID] = @LibraryOwnerUserID
	AND [LibraryName] = @LibraryName


GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryUsers_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibraryUsers_SelectAll]
AS
/*
** Select all rows from the LibraryUsers table
*/

SELECT 
	gv_LibraryUsers.*
FROM
	gv_LibraryUsers
ORDER BY
	[UserID],
	[LibraryOwnerUserID],
	[LibraryName]


GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryUsers_SelectByUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibraryUsers_SelectByUserID]
(
	@UserID nvarchar(50)
)
AS
/*
** Select rows from the LibraryUsers table by UserID
*/
SELECT 
	gv_LibraryUsers.*
FROM
	gv_LibraryUsers WHERE [UserID] = @UserID ORDER BY [UserID], [LibraryOwnerUserID], [LibraryName]


GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryUsers_SelectByUserIDAndLibraryOwnerUserIDAndLibraryName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibraryUsers_SelectByUserIDAndLibraryOwnerUserIDAndLibraryName]
(
	@UserID nvarchar(50),
	@LibraryOwnerUserID nvarchar(50),
	@LibraryName nvarchar(80)
)
AS
/*
** Select a row from the LibraryUsers table by primary key
*/

SELECT 
	gv_LibraryUsers.*
FROM
	gv_LibraryUsers WHERE [UserID] = @UserID AND [LibraryOwnerUserID] = @LibraryOwnerUserID AND [LibraryName] = @LibraryName


GO
/****** Object:  StoredProcedure [dbo].[gp_LibraryUsers_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LibraryUsers_Update]
(
	@UserIDOriginal nvarchar(50), 
	@UserID nvarchar(50),
	@LibraryOwnerUserIDOriginal nvarchar(50), 
	@LibraryOwnerUserID nvarchar(50),
	@LibraryNameOriginal nvarchar(80), 
	@LibraryName nvarchar(80),
	@ReadOnly bit,
	@CreateAccess bit,
	@UpdateAccess bit,
	@DeleteAccess bit
)
AS
/*
** Update a row in the LibraryUsers table using the primary key
*/
UPDATE [LibraryUsers] SET [ReadOnly] = @ReadOnly, [CreateAccess] = @CreateAccess, [UpdateAccess] = @UpdateAccess, [DeleteAccess] = @DeleteAccess, [UserID] = @UserID, [LibraryOwnerUserID] = @LibraryOwnerUserID, [LibraryName] = @LibraryName WHERE [UserID] = @UserIDOriginal AND [LibraryOwnerUserID] = @LibraryOwnerUserIDOriginal AND [LibraryName] = @LibraryNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_LibraryUsers.*
FROM
	gv_LibraryUsers
WHERE
	[UserID] = @UserIDOriginal
	AND [LibraryOwnerUserID] = @LibraryOwnerUserIDOriginal
	AND [LibraryName] = @LibraryNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_License_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_License_Delete]
(
	@LicenseID int
)
AS
/*
** Delete a row from the License table
*/
DELETE FROM [License] WHERE [LicenseID] = @LicenseID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the License table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_License_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_License_Insert]
(
	@Agreement nvarchar(2000),
	@VersionNbr int,
	@ActivationDate datetime,
	@InstallDate datetime,
	@CustomerID nvarchar(50),
	@CustomerName nvarchar(254),
	@XrtNxr1 nvarchar(50),
	@ServerIdentifier varchar(100),
	@SqlInstanceIdentifier varchar(100)
)
AS
/*
** Add a row to the License table
*/

INSERT INTO [License]
( [Agreement], [VersionNbr], [ActivationDate], [InstallDate], [CustomerID], [CustomerName], [XrtNxr1], [ServerIdentifier], [SqlInstanceIdentifier]
)
VALUES
( @Agreement, @VersionNbr, @ActivationDate, @InstallDate, @CustomerID, @CustomerName, @XrtNxr1, @ServerIdentifier, @SqlInstanceIdentifier
)

/*
** Select the new row
*/
SELECT
	gv_License.*
FROM
	gv_License
WHERE
	[LicenseID] = (SELECT SCOPE_IDENTITY())


GO
/****** Object:  StoredProcedure [dbo].[gp_License_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_License_SelectAll]
AS
/*
** Select all rows from the License table
*/

SELECT 
	gv_License.*
FROM
	gv_License
ORDER BY
	[LicenseID]


GO
/****** Object:  StoredProcedure [dbo].[gp_License_SelectByLicenseID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_License_SelectByLicenseID]
(
	@LicenseID int
)
AS
/*
** Select a row from the License table by primary key
*/

SELECT 
	gv_License.*
FROM
	gv_License WHERE [LicenseID] = @LicenseID


GO
/****** Object:  StoredProcedure [dbo].[gp_License_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_License_Update]
(
	@LicenseIDOriginal int,
	@Agreement nvarchar(2000),
	@VersionNbr int,
	@ActivationDate datetime,
	@InstallDate datetime,
	@CustomerID nvarchar(50),
	@CustomerName nvarchar(254),
	@XrtNxr1 nvarchar(50),
	@ServerIdentifier varchar(100),
	@SqlInstanceIdentifier varchar(100)
)
AS
/*
** Update a row in the License table using the primary key
*/
UPDATE [License] SET [Agreement] = @Agreement, [VersionNbr] = @VersionNbr, [ActivationDate] = @ActivationDate, [InstallDate] = @InstallDate, [CustomerID] = @CustomerID, [CustomerName] = @CustomerName, [XrtNxr1] = @XrtNxr1, [ServerIdentifier] = @ServerIdentifier, [SqlInstanceIdentifier] = @SqlInstanceIdentifier WHERE [LicenseID] = @LicenseIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_License.*
FROM
	gv_License
WHERE
	[LicenseID] = @LicenseIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfile_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LoadProfile_Delete]
(
	@ProfileName nvarchar(50)
)
AS
/*
** Delete a row from the LoadProfile table
*/
DELETE FROM [LoadProfile] WHERE [ProfileName] = @ProfileName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the LoadProfile table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfile_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LoadProfile_Insert]
(
	@ProfileName nvarchar(50),
	@ProfileDesc nvarchar(254)
)
AS
/*
** Add a row to the LoadProfile table
*/

INSERT INTO [LoadProfile]
( [ProfileName], [ProfileDesc]
)
VALUES
( @ProfileName, @ProfileDesc
)

/*
** Select the new row
*/
SELECT
	gv_LoadProfile.*
FROM
	gv_LoadProfile
WHERE
	[ProfileName] = @ProfileName


GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfile_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LoadProfile_SelectAll]
AS
/*
** Select all rows from the LoadProfile table
*/

SELECT 
	gv_LoadProfile.*
FROM
	gv_LoadProfile
ORDER BY
	[ProfileName]


GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfile_SelectByProfileName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LoadProfile_SelectByProfileName]
(
	@ProfileName nvarchar(50)
)
AS
/*
** Select a row from the LoadProfile table by primary key
*/

SELECT 
	gv_LoadProfile.*
FROM
	gv_LoadProfile WHERE [ProfileName] = @ProfileName


GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfile_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LoadProfile_Update]
(
	@ProfileNameOriginal nvarchar(50), 
	@ProfileName nvarchar(50),
	@ProfileDesc nvarchar(254)
)
AS
/*
** Update a row in the LoadProfile table using the primary key
*/
UPDATE [LoadProfile] SET [ProfileName] = @ProfileName, [ProfileDesc] = @ProfileDesc WHERE [ProfileName] = @ProfileNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_LoadProfile.*
FROM
	gv_LoadProfile
WHERE
	[ProfileName] = @ProfileNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfileItem_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LoadProfileItem_Delete]
(
	@ProfileName nvarchar(50),
	@SourceTypeCode nvarchar(50)
)
AS
/*
** Delete a row from the LoadProfileItem table
*/
DELETE FROM [LoadProfileItem] WHERE [ProfileName] = @ProfileName AND [SourceTypeCode] = @SourceTypeCode

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the LoadProfileItem table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfileItem_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LoadProfileItem_Insert]
(
	@ProfileName nvarchar(50),
	@SourceTypeCode nvarchar(50)
)
AS
/*
** Add a row to the LoadProfileItem table
*/

INSERT INTO [LoadProfileItem]
( [ProfileName], [SourceTypeCode]
)
VALUES
( @ProfileName, @SourceTypeCode
)

/*
** Select the new row
*/
SELECT
	gv_LoadProfileItem.*
FROM
	gv_LoadProfileItem
WHERE
	[ProfileName] = @ProfileName
	AND [SourceTypeCode] = @SourceTypeCode


GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfileItem_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LoadProfileItem_SelectAll]
AS
/*
** Select all rows from the LoadProfileItem table
*/

SELECT 
	gv_LoadProfileItem.*
FROM
	gv_LoadProfileItem
ORDER BY
	[ProfileName],
	[SourceTypeCode]


GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfileItem_SelectByProfileName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LoadProfileItem_SelectByProfileName]
(
	@ProfileName nvarchar(50)
)
AS
/*
** Select rows from the LoadProfileItem table by ProfileName
*/
SELECT 
	gv_LoadProfileItem.*
FROM
	gv_LoadProfileItem WHERE [ProfileName] = @ProfileName ORDER BY [ProfileName], [SourceTypeCode]


GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfileItem_SelectByProfileNameAndSourceTypeCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LoadProfileItem_SelectByProfileNameAndSourceTypeCode]
(
	@ProfileName nvarchar(50),
	@SourceTypeCode nvarchar(50)
)
AS
/*
** Select a row from the LoadProfileItem table by primary key
*/

SELECT 
	gv_LoadProfileItem.*
FROM
	gv_LoadProfileItem WHERE [ProfileName] = @ProfileName AND [SourceTypeCode] = @SourceTypeCode


GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfileItem_SelectBySourceTypeCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LoadProfileItem_SelectBySourceTypeCode]
(
	@SourceTypeCode nvarchar(50)
)
AS
/*
** Select rows from the LoadProfileItem table by SourceTypeCode
*/
SELECT 
	gv_LoadProfileItem.*
FROM
	gv_LoadProfileItem WHERE [SourceTypeCode] = @SourceTypeCode ORDER BY [ProfileName], [SourceTypeCode]


GO
/****** Object:  StoredProcedure [dbo].[gp_LoadProfileItem_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_LoadProfileItem_Update]
(
	@ProfileNameOriginal nvarchar(50), 
	@ProfileName nvarchar(50),
	@SourceTypeCodeOriginal nvarchar(50), 
	@SourceTypeCode nvarchar(50)
)
AS
/*
** Update a row in the LoadProfileItem table using the primary key
*/
UPDATE [LoadProfileItem] SET [ProfileName] = @ProfileName, [SourceTypeCode] = @SourceTypeCode WHERE [ProfileName] = @ProfileNameOriginal AND [SourceTypeCode] = @SourceTypeCodeOriginal


/*
** Select the updated row
*/
SELECT
	gv_LoadProfileItem.*
FROM
	gv_LoadProfileItem
WHERE
	[ProfileName] = @ProfileNameOriginal
	AND [SourceTypeCode] = @SourceTypeCodeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_Machine_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Machine_Delete]
(
	@MachineName nvarchar(254)
)
AS
/*
** Delete a row from the Machine table
*/
DELETE FROM [Machine] WHERE [MachineName] = @MachineName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the Machine table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_Machine_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Machine_Insert]
(
	@MachineName nvarchar(254)
)
AS
/*
** Add a row to the Machine table
*/

INSERT INTO [Machine]
( [MachineName]
)
VALUES
( @MachineName
)

/*
** Select the new row
*/
SELECT
	gv_Machine.*
FROM
	gv_Machine
WHERE
	[MachineName] = @MachineName


GO
/****** Object:  StoredProcedure [dbo].[gp_Machine_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Machine_SelectAll]
AS
/*
** Select all rows from the Machine table
*/

SELECT 
	gv_Machine.*
FROM
	gv_Machine
ORDER BY
	[MachineName]


GO
/****** Object:  StoredProcedure [dbo].[gp_Machine_SelectByMachineName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Machine_SelectByMachineName]
(
	@MachineName nvarchar(254)
)
AS
/*
** Select a row from the Machine table by primary key
*/

SELECT 
	gv_Machine.*
FROM
	gv_Machine WHERE [MachineName] = @MachineName


GO
/****** Object:  StoredProcedure [dbo].[gp_Machine_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Machine_Update]
(
	@MachineNameOriginal nvarchar(254), 
	@MachineName nvarchar(254)
)
AS
/*
** Update a row in the Machine table using the primary key
*/
UPDATE [Machine] SET [MachineName] = @MachineName WHERE [MachineName] = @MachineNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_Machine.*
FROM
	gv_Machine
WHERE
	[MachineName] = @MachineNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_MyTempTable_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_MyTempTable_Delete]
(
	@docid int
)
AS
/*
** Delete a row from the MyTempTable table
*/
DELETE FROM [MyTempTable] WHERE [docid] = @docid

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the MyTempTable table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_MyTempTable_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_MyTempTable_Insert]
(
	@docid int,
	@key nvarchar(100)
)
AS
/*
** Add a row to the MyTempTable table
*/

INSERT INTO [MyTempTable]
( [docid], [key]
)
VALUES
( @docid, @key
)

/*
** Select the new row
*/
SELECT
	gv_MyTempTable.*
FROM
	gv_MyTempTable
WHERE
	[docid] = @docid


GO
/****** Object:  StoredProcedure [dbo].[gp_MyTempTable_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_MyTempTable_SelectAll]
AS
/*
** Select all rows from the MyTempTable table
*/

SELECT 
	gv_MyTempTable.*
FROM
	gv_MyTempTable
ORDER BY
	[docid]


GO
/****** Object:  StoredProcedure [dbo].[gp_MyTempTable_SelectBydocid]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_MyTempTable_SelectBydocid]
(
	@docid int
)
AS
/*
** Select a row from the MyTempTable table by primary key
*/

SELECT 
	gv_MyTempTable.*
FROM
	gv_MyTempTable WHERE [docid] = @docid


GO
/****** Object:  StoredProcedure [dbo].[gp_MyTempTable_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_MyTempTable_Update]
(
	@docidOriginal int, 
	@docid int,
	@key nvarchar(100)
)
AS
/*
** Update a row in the MyTempTable table using the primary key
*/
UPDATE [MyTempTable] SET [docid] = @docid, [key] = @key WHERE [docid] = @docidOriginal


/*
** Select the updated row
*/
SELECT
	gv_MyTempTable.*
FROM
	gv_MyTempTable
WHERE
	[docid] = @docidOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_OutlookFrom_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_OutlookFrom_Delete]
(
	@FromEmailAddr nvarchar(254),
	@SenderName varchar(254),
	@UserID varchar(25)
)
AS
/*
** Delete a row from the OutlookFrom table
*/
DELETE FROM [OutlookFrom] WHERE [FromEmailAddr] = @FromEmailAddr AND [SenderName] = @SenderName AND [UserID] = @UserID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the OutlookFrom table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_OutlookFrom_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_OutlookFrom_Insert]
(
	@FromEmailAddr nvarchar(254),
	@SenderName varchar(254),
	@UserID varchar(25),
	@Verified int
)
AS
/*
** Add a row to the OutlookFrom table
*/

INSERT INTO [OutlookFrom]
( [FromEmailAddr], [SenderName], [UserID], [Verified]
)
VALUES
( @FromEmailAddr, @SenderName, @UserID, @Verified
)

/*
** Select the new row
*/
SELECT
	gv_OutlookFrom.*
FROM
	gv_OutlookFrom
WHERE
	[FromEmailAddr] = @FromEmailAddr
	AND [SenderName] = @SenderName
	AND [UserID] = @UserID


GO
/****** Object:  StoredProcedure [dbo].[gp_OutlookFrom_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_OutlookFrom_SelectAll]
AS
/*
** Select all rows from the OutlookFrom table
*/

SELECT 
	gv_OutlookFrom.*
FROM
	gv_OutlookFrom
ORDER BY
	[FromEmailAddr],
	[SenderName],
	[UserID]


GO
/****** Object:  StoredProcedure [dbo].[gp_OutlookFrom_SelectByFromEmailAddrAndSenderNameAndUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_OutlookFrom_SelectByFromEmailAddrAndSenderNameAndUserID]
(
	@FromEmailAddr nvarchar(254),
	@SenderName varchar(254),
	@UserID varchar(25)
)
AS
/*
** Select a row from the OutlookFrom table by primary key
*/

SELECT 
	gv_OutlookFrom.*
FROM
	gv_OutlookFrom WHERE [FromEmailAddr] = @FromEmailAddr AND [SenderName] = @SenderName AND [UserID] = @UserID


GO
/****** Object:  StoredProcedure [dbo].[gp_OutlookFrom_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_OutlookFrom_Update]
(
	@FromEmailAddrOriginal nvarchar(254), 
	@FromEmailAddr nvarchar(254),
	@SenderNameOriginal varchar(254), 
	@SenderName varchar(254),
	@UserIDOriginal varchar(25), 
	@UserID varchar(25),
	@Verified int
)
AS
/*
** Update a row in the OutlookFrom table using the primary key
*/
UPDATE [OutlookFrom] SET [FromEmailAddr] = @FromEmailAddr, [SenderName] = @SenderName, [UserID] = @UserID, [Verified] = @Verified WHERE [FromEmailAddr] = @FromEmailAddrOriginal AND [SenderName] = @SenderNameOriginal AND [UserID] = @UserIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_OutlookFrom.*
FROM
	gv_OutlookFrom
WHERE
	[FromEmailAddr] = @FromEmailAddrOriginal
	AND [SenderName] = @SenderNameOriginal
	AND [UserID] = @UserIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_OwnerHistory_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_OwnerHistory_Delete]
(
	@RowId int
)
AS
/*
** Delete a row from the OwnerHistory table
*/
DELETE FROM [OwnerHistory] WHERE [RowId] = @RowId

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the OwnerHistory table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_OwnerHistory_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_OwnerHistory_Insert]
(
	@PreviousOwnerUserID nvarchar(50),
	@CurrentOwnerUserID nvarchar(50),
	@CreateDate datetime
)
AS
/*
** Add a row to the OwnerHistory table
*/

INSERT INTO [OwnerHistory]
( [PreviousOwnerUserID], [CurrentOwnerUserID], [CreateDate]
)
VALUES
( @PreviousOwnerUserID, @CurrentOwnerUserID, @CreateDate
)

/*
** Select the new row
*/
SELECT
	gv_OwnerHistory.*
FROM
	gv_OwnerHistory
WHERE
	[RowId] = (SELECT SCOPE_IDENTITY())


GO
/****** Object:  StoredProcedure [dbo].[gp_OwnerHistory_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_OwnerHistory_SelectAll]
AS
/*
** Select all rows from the OwnerHistory table
*/

SELECT 
	gv_OwnerHistory.*
FROM
	gv_OwnerHistory
ORDER BY
	[RowId]


GO
/****** Object:  StoredProcedure [dbo].[gp_OwnerHistory_SelectByCurrentOwnerUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_OwnerHistory_SelectByCurrentOwnerUserID]
(
	@CurrentOwnerUserID nvarchar(50)
)
AS
/*
** Select rows from the OwnerHistory table by CurrentOwnerUserID
*/
SELECT 
	gv_OwnerHistory.*
FROM
	gv_OwnerHistory WHERE [CurrentOwnerUserID] = @CurrentOwnerUserID ORDER BY [RowId]


GO
/****** Object:  StoredProcedure [dbo].[gp_OwnerHistory_SelectByPreviousOwnerUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_OwnerHistory_SelectByPreviousOwnerUserID]
(
	@PreviousOwnerUserID nvarchar(50)
)
AS
/*
** Select rows from the OwnerHistory table by PreviousOwnerUserID
*/
SELECT 
	gv_OwnerHistory.*
FROM
	gv_OwnerHistory WHERE [PreviousOwnerUserID] = @PreviousOwnerUserID ORDER BY [RowId]


GO
/****** Object:  StoredProcedure [dbo].[gp_OwnerHistory_SelectByRowId]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_OwnerHistory_SelectByRowId]
(
	@RowId int
)
AS
/*
** Select a row from the OwnerHistory table by primary key
*/

SELECT 
	gv_OwnerHistory.*
FROM
	gv_OwnerHistory WHERE [RowId] = @RowId


GO
/****** Object:  StoredProcedure [dbo].[gp_OwnerHistory_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_OwnerHistory_Update]
(
	@RowIdOriginal int,
	@PreviousOwnerUserID nvarchar(50),
	@CurrentOwnerUserID nvarchar(50),
	@CreateDate datetime
)
AS
/*
** Update a row in the OwnerHistory table using the primary key
*/
UPDATE [OwnerHistory] SET [PreviousOwnerUserID] = @PreviousOwnerUserID, [CurrentOwnerUserID] = @CurrentOwnerUserID, [CreateDate] = @CreateDate WHERE [RowId] = @RowIdOriginal


/*
** Select the updated row
*/
SELECT
	gv_OwnerHistory.*
FROM
	gv_OwnerHistory
WHERE
	[RowId] = @RowIdOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_PgmTrace_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_PgmTrace_Insert]
(
	@StmtID nvarchar(50),
	@PgmName nvarchar(254),
	@Stmt nvarchar(max),
	@CreateDate datetime,
	@ConnectiveGuid nvarchar(50),
	@UserID nvarchar(50)
)
AS
/*
** Add a row to the PgmTrace table
*/

INSERT INTO [PgmTrace]
( [StmtID], [PgmName], [Stmt], [CreateDate], [ConnectiveGuid], [UserID]
)
VALUES
( @StmtID, @PgmName, @Stmt, @CreateDate, @ConnectiveGuid, @UserID
)

/*
** Select the new row
*/
SELECT
	gv_PgmTrace.*
FROM
	gv_PgmTrace


GO
/****** Object:  StoredProcedure [dbo].[gp_PgmTrace_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_PgmTrace_SelectAll]
AS
/*
** Select all rows from the PgmTrace table
*/

SELECT 
	gv_PgmTrace.*
FROM
	gv_PgmTrace


GO
/****** Object:  StoredProcedure [dbo].[gp_PgmTrace_SelectBy]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[gp_PgmTrace_SelectBy] AS PRINT 'ALTER PROC will update this'


GO
/****** Object:  StoredProcedure [dbo].[gp_ProcessFileAs_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ProcessFileAs_Delete]
(
	@ExtCode nvarchar(50)
)
AS
/*
** Delete a row from the ProcessFileAs table
*/
DELETE FROM [ProcessFileAs] WHERE [ExtCode] = @ExtCode

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the ProcessFileAs table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_ProcessFileAs_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ProcessFileAs_Insert]
(
	@ExtCode nvarchar(50),
	@ProcessExtCode nvarchar(50),
	@Applied bit
)
AS
/*
** Add a row to the ProcessFileAs table
*/

INSERT INTO [ProcessFileAs]
( [ExtCode], [ProcessExtCode], [Applied]
)
VALUES
( @ExtCode, @ProcessExtCode, @Applied
)

/*
** Select the new row
*/
SELECT
	gv_ProcessFileAs.*
FROM
	gv_ProcessFileAs
WHERE
	[ExtCode] = @ExtCode


GO
/****** Object:  StoredProcedure [dbo].[gp_ProcessFileAs_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ProcessFileAs_SelectAll]
AS
/*
** Select all rows from the ProcessFileAs table
*/

SELECT 
	gv_ProcessFileAs.*
FROM
	gv_ProcessFileAs
ORDER BY
	[ExtCode]


GO
/****** Object:  StoredProcedure [dbo].[gp_ProcessFileAs_SelectByExtCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ProcessFileAs_SelectByExtCode]
(
	@ExtCode nvarchar(50)
)
AS
/*
** Select a row from the ProcessFileAs table by primary key
*/

SELECT 
	gv_ProcessFileAs.*
FROM
	gv_ProcessFileAs WHERE [ExtCode] = @ExtCode


GO
/****** Object:  StoredProcedure [dbo].[gp_ProcessFileAs_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ProcessFileAs_Update]
(
	@ExtCodeOriginal nvarchar(50), 
	@ExtCode nvarchar(50),
	@ProcessExtCode nvarchar(50),
	@Applied bit
)
AS
/*
** Update a row in the ProcessFileAs table using the primary key
*/
UPDATE [ProcessFileAs] SET [ExtCode] = @ExtCode, [ProcessExtCode] = @ProcessExtCode, [Applied] = @Applied WHERE [ExtCode] = @ExtCodeOriginal


/*
** Select the updated row
*/
SELECT
	gv_ProcessFileAs.*
FROM
	gv_ProcessFileAs
WHERE
	[ExtCode] = @ExtCodeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_ProdCaptureItems_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ProdCaptureItems_Delete]
(
	@CaptureItemsCode nvarchar(50),
	@ContainerType nvarchar(25),
	@CorpFuncName nvarchar(80),
	@CorpName nvarchar(50)
)
AS
/*
** Delete a row from the ProdCaptureItems table
*/
DELETE FROM [ProdCaptureItems] WHERE [CaptureItemsCode] = @CaptureItemsCode AND [ContainerType] = @ContainerType AND [CorpFuncName] = @CorpFuncName AND [CorpName] = @CorpName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the ProdCaptureItems table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_ProdCaptureItems_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ProdCaptureItems_Insert]
(
	@CaptureItemsCode nvarchar(50),
	@SendAlert bit,
	@ContainerType nvarchar(25),
	@CorpFuncName nvarchar(80),
	@CorpName nvarchar(50)
)
AS
/*
** Add a row to the ProdCaptureItems table
*/

INSERT INTO [ProdCaptureItems]
( [CaptureItemsCode], [SendAlert], [ContainerType], [CorpFuncName], [CorpName]
)
VALUES
( @CaptureItemsCode, @SendAlert, @ContainerType, @CorpFuncName, @CorpName
)

/*
** Select the new row
*/
SELECT
	gv_ProdCaptureItems.*
FROM
	gv_ProdCaptureItems
WHERE
	[CaptureItemsCode] = @CaptureItemsCode
	AND [ContainerType] = @ContainerType
	AND [CorpFuncName] = @CorpFuncName
	AND [CorpName] = @CorpName


GO
/****** Object:  StoredProcedure [dbo].[gp_ProdCaptureItems_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ProdCaptureItems_SelectAll]
AS
/*
** Select all rows from the ProdCaptureItems table
*/

SELECT 
	gv_ProdCaptureItems.*
FROM
	gv_ProdCaptureItems
ORDER BY
	[CaptureItemsCode],
	[ContainerType],
	[CorpFuncName],
	[CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_ProdCaptureItems_SelectByCaptureItemsCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ProdCaptureItems_SelectByCaptureItemsCode]
(
	@CaptureItemsCode nvarchar(50)
)
AS
/*
** Select rows from the ProdCaptureItems table by CaptureItemsCode
*/
SELECT 
	gv_ProdCaptureItems.*
FROM
	gv_ProdCaptureItems WHERE [CaptureItemsCode] = @CaptureItemsCode ORDER BY [CaptureItemsCode], [ContainerType], [CorpFuncName], [CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_ProdCaptureItems_SelectByCaptureItemsCodeAndContainerTypeAndCorpFuncNameAndCorpName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ProdCaptureItems_SelectByCaptureItemsCodeAndContainerTypeAndCorpFuncNameAndCorpName]
(
	@CaptureItemsCode nvarchar(50),
	@ContainerType nvarchar(25),
	@CorpFuncName nvarchar(80),
	@CorpName nvarchar(50)
)
AS
/*
** Select a row from the ProdCaptureItems table by primary key
*/

SELECT 
	gv_ProdCaptureItems.*
FROM
	gv_ProdCaptureItems WHERE [CaptureItemsCode] = @CaptureItemsCode AND [ContainerType] = @ContainerType AND [CorpFuncName] = @CorpFuncName AND [CorpName] = @CorpName


GO
/****** Object:  StoredProcedure [dbo].[gp_ProdCaptureItems_SelectByContainerTypeAndCorpFuncNameAndCorpName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ProdCaptureItems_SelectByContainerTypeAndCorpFuncNameAndCorpName]
(
	@ContainerType nvarchar(25),
	@CorpFuncName nvarchar(80),
	@CorpName nvarchar(50)
)
AS
/*
** Select rows from the ProdCaptureItems table by ContainerType, CorpFuncName and CorpName
*/
SELECT 
	gv_ProdCaptureItems.*
FROM
	gv_ProdCaptureItems WHERE [ContainerType] = @ContainerType AND [CorpFuncName] = @CorpFuncName AND [CorpName] = @CorpName ORDER BY [CaptureItemsCode], [ContainerType], [CorpFuncName], [CorpName]


GO
/****** Object:  StoredProcedure [dbo].[gp_ProdCaptureItems_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ProdCaptureItems_Update]
(
	@CaptureItemsCodeOriginal nvarchar(50), 
	@CaptureItemsCode nvarchar(50),
	@ContainerTypeOriginal nvarchar(25), 
	@ContainerType nvarchar(25),
	@CorpFuncNameOriginal nvarchar(80), 
	@CorpFuncName nvarchar(80),
	@CorpNameOriginal nvarchar(50), 
	@CorpName nvarchar(50),
	@SendAlert bit
)
AS
/*
** Update a row in the ProdCaptureItems table using the primary key
*/
UPDATE [ProdCaptureItems] SET [CaptureItemsCode] = @CaptureItemsCode, [SendAlert] = @SendAlert, [ContainerType] = @ContainerType, [CorpFuncName] = @CorpFuncName, [CorpName] = @CorpName WHERE [CaptureItemsCode] = @CaptureItemsCodeOriginal AND [ContainerType] = @ContainerTypeOriginal AND [CorpFuncName] = @CorpFuncNameOriginal AND [CorpName] = @CorpNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_ProdCaptureItems.*
FROM
	gv_ProdCaptureItems
WHERE
	[CaptureItemsCode] = @CaptureItemsCodeOriginal
	AND [ContainerType] = @ContainerTypeOriginal
	AND [CorpFuncName] = @CorpFuncNameOriginal
	AND [CorpName] = @CorpNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_QtyDocs_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QtyDocs_Delete]
(
	@QtyDocCode nvarchar(10)
)
AS
/*
** Delete a row from the QtyDocs table
*/
DELETE FROM [QtyDocs] WHERE [QtyDocCode] = @QtyDocCode

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the QtyDocs table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_QtyDocs_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QtyDocs_Insert]
(
	@QtyDocCode nvarchar(10),
	@Description nvarchar(4000),
	@CreateDate datetime
)
AS
/*
** Add a row to the QtyDocs table
*/

INSERT INTO [QtyDocs]
( [QtyDocCode], [Description], [CreateDate]
)
VALUES
( @QtyDocCode, @Description, @CreateDate
)

/*
** Select the new row
*/
SELECT
	gv_QtyDocs.*
FROM
	gv_QtyDocs
WHERE
	[QtyDocCode] = @QtyDocCode


GO
/****** Object:  StoredProcedure [dbo].[gp_QtyDocs_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QtyDocs_SelectAll]
AS
/*
** Select all rows from the QtyDocs table
*/

SELECT 
	gv_QtyDocs.*
FROM
	gv_QtyDocs
ORDER BY
	[QtyDocCode]


GO
/****** Object:  StoredProcedure [dbo].[gp_QtyDocs_SelectByQtyDocCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QtyDocs_SelectByQtyDocCode]
(
	@QtyDocCode nvarchar(10)
)
AS
/*
** Select a row from the QtyDocs table by primary key
*/

SELECT 
	gv_QtyDocs.*
FROM
	gv_QtyDocs WHERE [QtyDocCode] = @QtyDocCode


GO
/****** Object:  StoredProcedure [dbo].[gp_QtyDocs_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QtyDocs_Update]
(
	@QtyDocCodeOriginal nvarchar(10), 
	@QtyDocCode nvarchar(10),
	@Description nvarchar(4000),
	@CreateDate datetime
)
AS
/*
** Update a row in the QtyDocs table using the primary key
*/
UPDATE [QtyDocs] SET [QtyDocCode] = @QtyDocCode, [Description] = @Description, [CreateDate] = @CreateDate WHERE [QtyDocCode] = @QtyDocCodeOriginal


/*
** Select the updated row
*/
SELECT
	gv_QtyDocs.*
FROM
	gv_QtyDocs
WHERE
	[QtyDocCode] = @QtyDocCodeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_QuickDirectory_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QuickDirectory_Delete]
(
	@UserID nvarchar(50),
	@FQN varchar(254)
)
AS
/*
** Delete a row from the QuickDirectory table
*/
DELETE FROM [QuickDirectory] WHERE [UserID] = @UserID AND [FQN] = @FQN

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the QuickDirectory table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_QuickDirectory_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QuickDirectory_Insert]
(
	@UserID nvarchar(50),
	@IncludeSubDirs char(1),
	@FQN varchar(254),
	@DB_ID nvarchar(50),
	@VersionFiles char(1),
	@ckMetaData nchar(1),
	@ckPublic nchar(1),
	@ckDisableDir nchar(1),
	@QuickRefEntry bit
)
AS
/*
** Add a row to the QuickDirectory table
*/

INSERT INTO [QuickDirectory]
( [UserID], [IncludeSubDirs], [FQN], [DB_ID], [VersionFiles], [ckMetaData], [ckPublic], [ckDisableDir], [QuickRefEntry]
)
VALUES
( @UserID, @IncludeSubDirs, @FQN, @DB_ID, @VersionFiles, @ckMetaData, @ckPublic, @ckDisableDir, @QuickRefEntry
)

/*
** Select the new row
*/
SELECT
	gv_QuickDirectory.*
FROM
	gv_QuickDirectory
WHERE
	[UserID] = @UserID
	AND [FQN] = @FQN


GO
/****** Object:  StoredProcedure [dbo].[gp_QuickDirectory_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QuickDirectory_SelectAll]
AS
/*
** Select all rows from the QuickDirectory table
*/

SELECT 
	gv_QuickDirectory.*
FROM
	gv_QuickDirectory
ORDER BY
	[UserID],
	[FQN]


GO
/****** Object:  StoredProcedure [dbo].[gp_QuickDirectory_SelectByUserIDAndFQN]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QuickDirectory_SelectByUserIDAndFQN]
(
	@UserID nvarchar(50),
	@FQN varchar(254)
)
AS
/*
** Select a row from the QuickDirectory table by primary key
*/

SELECT 
	gv_QuickDirectory.*
FROM
	gv_QuickDirectory WHERE [UserID] = @UserID AND [FQN] = @FQN


GO
/****** Object:  StoredProcedure [dbo].[gp_QuickDirectory_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QuickDirectory_Update]
(
	@UserIDOriginal nvarchar(50), 
	@UserID nvarchar(50),
	@FQNOriginal varchar(254), 
	@FQN varchar(254),
	@IncludeSubDirs char(1),
	@DB_ID nvarchar(50),
	@VersionFiles char(1),
	@ckMetaData nchar(1),
	@ckPublic nchar(1),
	@ckDisableDir nchar(1),
	@QuickRefEntry bit
)
AS
/*
** Update a row in the QuickDirectory table using the primary key
*/
UPDATE [QuickDirectory] SET [UserID] = @UserID, [IncludeSubDirs] = @IncludeSubDirs, [FQN] = @FQN, [DB_ID] = @DB_ID, [VersionFiles] = @VersionFiles, [ckMetaData] = @ckMetaData, [ckPublic] = @ckPublic, [ckDisableDir] = @ckDisableDir, [QuickRefEntry] = @QuickRefEntry WHERE [UserID] = @UserIDOriginal AND [FQN] = @FQNOriginal


/*
** Select the updated row
*/
SELECT
	gv_QuickDirectory.*
FROM
	gv_QuickDirectory
WHERE
	[UserID] = @UserIDOriginal
	AND [FQN] = @FQNOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRef_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QuickRef_Delete]
(
	@QuickRefIdNbr int
)
AS
/*
** Delete a row from the QuickRef table
*/
DELETE FROM [QuickRef] WHERE [QuickRefIdNbr] = @QuickRefIdNbr

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the QuickRef table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRef_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QuickRef_Insert]
(
	@UserID nvarchar(50),
	@QuickRefName nvarchar(50)
)
AS
/*
** Add a row to the QuickRef table
*/

INSERT INTO [QuickRef]
( [UserID], [QuickRefName]
)
VALUES
( @UserID, @QuickRefName
)

/*
** Select the new row
*/
SELECT
	gv_QuickRef.*
FROM
	gv_QuickRef
WHERE
	[QuickRefIdNbr] = (SELECT SCOPE_IDENTITY())


GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRef_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QuickRef_SelectAll]
AS
/*
** Select all rows from the QuickRef table
*/

SELECT 
	gv_QuickRef.*
FROM
	gv_QuickRef
ORDER BY
	[QuickRefIdNbr]


GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRef_SelectByQuickRefIdNbr]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QuickRef_SelectByQuickRefIdNbr]
(
	@QuickRefIdNbr int
)
AS
/*
** Select a row from the QuickRef table by primary key
*/

SELECT 
	gv_QuickRef.*
FROM
	gv_QuickRef WHERE [QuickRefIdNbr] = @QuickRefIdNbr


GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRef_SelectByUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QuickRef_SelectByUserID]
(
	@UserID nvarchar(50)
)
AS
/*
** Select rows from the QuickRef table by UserID
*/
SELECT 
	gv_QuickRef.*
FROM
	gv_QuickRef WHERE [UserID] = @UserID ORDER BY [QuickRefIdNbr]


GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRef_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QuickRef_Update]
(
	@QuickRefIdNbrOriginal int,
	@UserID nvarchar(50),
	@QuickRefName nvarchar(50)
)
AS
/*
** Update a row in the QuickRef table using the primary key
*/
UPDATE [QuickRef] SET [UserID] = @UserID, [QuickRefName] = @QuickRefName WHERE [QuickRefIdNbr] = @QuickRefIdNbrOriginal


/*
** Select the updated row
*/
SELECT
	gv_QuickRef.*
FROM
	gv_QuickRef
WHERE
	[QuickRefIdNbr] = @QuickRefIdNbrOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRefItems_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QuickRefItems_Delete]
(
	@QuickRefItemGuid nvarchar(50)
)
AS
/*
** Delete a row from the QuickRefItems table
*/
DELETE FROM [QuickRefItems] WHERE [QuickRefItemGuid] = @QuickRefItemGuid

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the QuickRefItems table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRefItems_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QuickRefItems_Insert]
(
	@QuickRefIdNbr int,
	@FQN nvarchar(300),
	@QuickRefItemGuid nvarchar(50),
	@SourceGuid nvarchar(50),
	@DataSourceOwnerUserID nvarchar(50),
	@Author nvarchar(300),
	@Description nvarchar(max),
	@Keywords nvarchar(2000),
	@FileName nvarchar(80),
	@DirName nvarchar(254),
	@MarkedForDeletion bit
)
AS
/*
** Add a row to the QuickRefItems table
*/

INSERT INTO [QuickRefItems]
( [QuickRefIdNbr], [FQN], [QuickRefItemGuid], [SourceGuid], [DataSourceOwnerUserID], [Author], [Description], [Keywords], [FileName], [DirName], [MarkedForDeletion]
)
VALUES
( @QuickRefIdNbr, @FQN, @QuickRefItemGuid, @SourceGuid, @DataSourceOwnerUserID, @Author, @Description, @Keywords, @FileName, @DirName, @MarkedForDeletion
)

/*
** Select the new row
*/
SELECT
	gv_QuickRefItems.*
FROM
	gv_QuickRefItems
WHERE
	[QuickRefItemGuid] = @QuickRefItemGuid


GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRefItems_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QuickRefItems_SelectAll]
AS
/*
** Select all rows from the QuickRefItems table
*/

SELECT 
	gv_QuickRefItems.*
FROM
	gv_QuickRefItems
ORDER BY
	[QuickRefItemGuid]


GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRefItems_SelectByQuickRefIdNbr]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QuickRefItems_SelectByQuickRefIdNbr]
(
	@QuickRefIdNbr int
)
AS
/*
** Select rows from the QuickRefItems table by QuickRefIdNbr
*/
SELECT 
	gv_QuickRefItems.*
FROM
	gv_QuickRefItems WHERE [QuickRefIdNbr] = @QuickRefIdNbr ORDER BY [QuickRefItemGuid]


GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRefItems_SelectByQuickRefItemGuid]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QuickRefItems_SelectByQuickRefItemGuid]
(
	@QuickRefItemGuid nvarchar(50)
)
AS
/*
** Select a row from the QuickRefItems table by primary key
*/

SELECT 
	gv_QuickRefItems.*
FROM
	gv_QuickRefItems WHERE [QuickRefItemGuid] = @QuickRefItemGuid


GO
/****** Object:  StoredProcedure [dbo].[gp_QuickRefItems_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_QuickRefItems_Update]
(
	@QuickRefItemGuidOriginal nvarchar(50), 
	@QuickRefItemGuid nvarchar(50),
	@QuickRefIdNbr int,
	@FQN nvarchar(300),
	@SourceGuid nvarchar(50),
	@DataSourceOwnerUserID nvarchar(50),
	@Author nvarchar(300),
	@Description nvarchar(max),
	@Keywords nvarchar(2000),
	@FileName nvarchar(80),
	@DirName nvarchar(254),
	@MarkedForDeletion bit
)
AS
/*
** Update a row in the QuickRefItems table using the primary key
*/
UPDATE [QuickRefItems] SET [QuickRefIdNbr] = @QuickRefIdNbr, [FQN] = @FQN, [QuickRefItemGuid] = @QuickRefItemGuid, [SourceGuid] = @SourceGuid, [DataSourceOwnerUserID] = @DataSourceOwnerUserID, [Author] = @Author, [Description] = @Description, [Keywords] = @Keywords, [FileName] = @FileName, [DirName] = @DirName, [MarkedForDeletion] = @MarkedForDeletion WHERE [QuickRefItemGuid] = @QuickRefItemGuidOriginal


/*
** Select the updated row
*/
SELECT
	gv_QuickRefItems.*
FROM
	gv_QuickRefItems
WHERE
	[QuickRefItemGuid] = @QuickRefItemGuidOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_Recipients_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Recipients_Delete]
(
	@Recipient nvarchar(254),
	@EmailGuid nvarchar(50)
)
AS
/*
** Delete a row from the Recipients table
*/
DELETE FROM [Recipients] WHERE [Recipient] = @Recipient AND [EmailGuid] = @EmailGuid

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the Recipients table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_Recipients_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Recipients_Insert]
(
	@Recipient nvarchar(254),
	@EmailGuid nvarchar(50),
	@TypeRecp nchar(10)
)
AS
/*
** Add a row to the Recipients table
*/

INSERT INTO [Recipients]
( [Recipient], [EmailGuid], [TypeRecp]
)
VALUES
( @Recipient, @EmailGuid, @TypeRecp
)

/*
** Select the new row
*/
SELECT
	gv_Recipients.*
FROM
	gv_Recipients
WHERE
	[Recipient] = @Recipient
	AND [EmailGuid] = @EmailGuid


GO
/****** Object:  StoredProcedure [dbo].[gp_Recipients_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Recipients_SelectAll]
AS
/*
** Select all rows from the Recipients table
*/

SELECT 
	gv_Recipients.*
FROM
	gv_Recipients
ORDER BY
	[Recipient],
	[EmailGuid]


GO
/****** Object:  StoredProcedure [dbo].[gp_Recipients_SelectByEmailGuid]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Recipients_SelectByEmailGuid]
(
	@EmailGuid nvarchar(50)
)
AS
/*
** Select rows from the Recipients table by EmailGuid
*/
SELECT 
	gv_Recipients.*
FROM
	gv_Recipients WHERE [EmailGuid] = @EmailGuid ORDER BY [Recipient], [EmailGuid]


GO
/****** Object:  StoredProcedure [dbo].[gp_Recipients_SelectByRecipientAndEmailGuid]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Recipients_SelectByRecipientAndEmailGuid]
(
	@Recipient nvarchar(254),
	@EmailGuid nvarchar(50)
)
AS
/*
** Select a row from the Recipients table by primary key
*/

SELECT 
	gv_Recipients.*
FROM
	gv_Recipients WHERE [Recipient] = @Recipient AND [EmailGuid] = @EmailGuid


GO
/****** Object:  StoredProcedure [dbo].[gp_Recipients_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Recipients_Update]
(
	@RecipientOriginal nvarchar(254), 
	@Recipient nvarchar(254),
	@EmailGuidOriginal nvarchar(50), 
	@EmailGuid nvarchar(50),
	@TypeRecp nchar(10)
)
AS
/*
** Update a row in the Recipients table using the primary key
*/
UPDATE [Recipients] SET [Recipient] = @Recipient, [EmailGuid] = @EmailGuid, [TypeRecp] = @TypeRecp WHERE [Recipient] = @RecipientOriginal AND [EmailGuid] = @EmailGuidOriginal


/*
** Select the updated row
*/
SELECT
	gv_Recipients.*
FROM
	gv_Recipients
WHERE
	[Recipient] = @RecipientOriginal
	AND [EmailGuid] = @EmailGuidOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_RepeatData_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RepeatData_Delete]
(
	@RepeatDataCode nvarchar(50)
)
AS
/*
** Delete a row from the RepeatData table
*/
DELETE FROM [RepeatData] WHERE [RepeatDataCode] = @RepeatDataCode

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the RepeatData table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_RepeatData_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RepeatData_Insert]
(
	@RepeatDataCode nvarchar(50),
	@RepeatDataDesc nvarchar(4000)
)
AS
/*
** Add a row to the RepeatData table
*/

INSERT INTO [RepeatData]
( [RepeatDataCode], [RepeatDataDesc]
)
VALUES
( @RepeatDataCode, @RepeatDataDesc
)

/*
** Select the new row
*/
SELECT
	gv_RepeatData.*
FROM
	gv_RepeatData
WHERE
	[RepeatDataCode] = @RepeatDataCode


GO
/****** Object:  StoredProcedure [dbo].[gp_RepeatData_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RepeatData_SelectAll]
AS
/*
** Select all rows from the RepeatData table
*/

SELECT 
	gv_RepeatData.*
FROM
	gv_RepeatData
ORDER BY
	[RepeatDataCode]


GO
/****** Object:  StoredProcedure [dbo].[gp_RepeatData_SelectByRepeatDataCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RepeatData_SelectByRepeatDataCode]
(
	@RepeatDataCode nvarchar(50)
)
AS
/*
** Select a row from the RepeatData table by primary key
*/

SELECT 
	gv_RepeatData.*
FROM
	gv_RepeatData WHERE [RepeatDataCode] = @RepeatDataCode


GO
/****** Object:  StoredProcedure [dbo].[gp_RepeatData_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RepeatData_Update]
(
	@RepeatDataCodeOriginal nvarchar(50), 
	@RepeatDataCode nvarchar(50),
	@RepeatDataDesc nvarchar(4000)
)
AS
/*
** Update a row in the RepeatData table using the primary key
*/
UPDATE [RepeatData] SET [RepeatDataCode] = @RepeatDataCode, [RepeatDataDesc] = @RepeatDataDesc WHERE [RepeatDataCode] = @RepeatDataCodeOriginal


/*
** Select the updated row
*/
SELECT
	gv_RepeatData.*
FROM
	gv_RepeatData
WHERE
	[RepeatDataCode] = @RepeatDataCodeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_RestorationHistory_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RestorationHistory_Insert]
(
	@SourceType nvarchar(50),
	@SourceGuid nvarchar(50),
	@OriginalCrc nvarchar(50),
	@RestoredCrc nvarchar(50),
	@RestorationDate nchar(10),
	@RestoredBy nvarchar(50)
)
AS
/*
** Add a row to the RestorationHistory table
*/

INSERT INTO [RestorationHistory]
( [SourceType], [SourceGuid], [OriginalCrc], [RestoredCrc], [RestorationDate], [RestoredBy]
)
VALUES
( @SourceType, @SourceGuid, @OriginalCrc, @RestoredCrc, @RestorationDate, @RestoredBy
)

/*
** Select the new row
*/
SELECT
	gv_RestorationHistory.*
FROM
	gv_RestorationHistory


GO
/****** Object:  StoredProcedure [dbo].[gp_RestorationHistory_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RestorationHistory_SelectAll]
AS
/*
** Select all rows from the RestorationHistory table
*/

SELECT 
	gv_RestorationHistory.*
FROM
	gv_RestorationHistory


GO
/****** Object:  StoredProcedure [dbo].[gp_RestorationHistory_SelectBy]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[gp_RestorationHistory_SelectBy] AS PRINT 'ALTER PROC will update this'


GO
/****** Object:  StoredProcedure [dbo].[gp_Retention_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Retention_Delete]
(
	@RetentionCode nvarchar(50)
)
AS
/*
** Delete a row from the Retention table
*/
DELETE FROM [Retention] WHERE [RetentionCode] = @RetentionCode

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the Retention table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_Retention_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Retention_Insert]
(
	@RetentionCode nvarchar(50),
	@RetentionDesc nvarchar(18),
	@RetentionYears int,
	@RetentionAction nvarchar(50)
)
AS
/*
** Add a row to the Retention table
*/

INSERT INTO [Retention]
( [RetentionCode], [RetentionDesc], [RetentionYears], [RetentionAction]
)
VALUES
( @RetentionCode, @RetentionDesc, @RetentionYears, @RetentionAction
)

/*
** Select the new row
*/
SELECT
	gv_Retention.*
FROM
	gv_Retention
WHERE
	[RetentionCode] = @RetentionCode


GO
/****** Object:  StoredProcedure [dbo].[gp_Retention_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Retention_SelectAll]
AS
/*
** Select all rows from the Retention table
*/

SELECT 
	gv_Retention.*
FROM
	gv_Retention
ORDER BY
	[RetentionCode]


GO
/****** Object:  StoredProcedure [dbo].[gp_Retention_SelectByRetentionCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Retention_SelectByRetentionCode]
(
	@RetentionCode nvarchar(50)
)
AS
/*
** Select a row from the Retention table by primary key
*/

SELECT 
	gv_Retention.*
FROM
	gv_Retention WHERE [RetentionCode] = @RetentionCode


GO
/****** Object:  StoredProcedure [dbo].[gp_Retention_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Retention_Update]
(
	@RetentionCodeOriginal nvarchar(50), 
	@RetentionCode nvarchar(50),
	@RetentionDesc nvarchar(18),
	@RetentionYears int,
	@RetentionAction nvarchar(50)
)
AS
/*
** Update a row in the Retention table using the primary key
*/
UPDATE [Retention] SET [RetentionCode] = @RetentionCode, [RetentionDesc] = @RetentionDesc, [RetentionYears] = @RetentionYears, [RetentionAction] = @RetentionAction WHERE [RetentionCode] = @RetentionCodeOriginal


/*
** Select the updated row
*/
SELECT
	gv_Retention.*
FROM
	gv_Retention
WHERE
	[RetentionCode] = @RetentionCodeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_RetentionTemp_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RetentionTemp_Delete]
(
	@ContentGuid nvarchar(50)
)
AS
/*
** Delete a row from the RetentionTemp table
*/
DELETE FROM [RetentionTemp] WHERE [ContentGuid] = @ContentGuid

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the RetentionTemp table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_RetentionTemp_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RetentionTemp_Insert]
(
	@UserID nvarchar(50),
	@ContentGuid nvarchar(50),
	@TypeContent nvarchar(50)
)
AS
/*
** Add a row to the RetentionTemp table
*/

INSERT INTO [RetentionTemp]
( [UserID], [ContentGuid], [TypeContent]
)
VALUES
( @UserID, @ContentGuid, @TypeContent
)

/*
** Select the new row
*/
SELECT
	gv_RetentionTemp.*
FROM
	gv_RetentionTemp
WHERE
	[ContentGuid] = @ContentGuid


GO
/****** Object:  StoredProcedure [dbo].[gp_RetentionTemp_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RetentionTemp_SelectAll]
AS
/*
** Select all rows from the RetentionTemp table
*/

SELECT 
	gv_RetentionTemp.*
FROM
	gv_RetentionTemp
ORDER BY
	[ContentGuid]


GO
/****** Object:  StoredProcedure [dbo].[gp_RetentionTemp_SelectByContentGuid]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RetentionTemp_SelectByContentGuid]
(
	@ContentGuid nvarchar(50)
)
AS
/*
** Select a row from the RetentionTemp table by primary key
*/

SELECT 
	gv_RetentionTemp.*
FROM
	gv_RetentionTemp WHERE [ContentGuid] = @ContentGuid


GO
/****** Object:  StoredProcedure [dbo].[gp_RetentionTemp_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RetentionTemp_Update]
(
	@ContentGuidOriginal nvarchar(50), 
	@ContentGuid nvarchar(50),
	@UserID nvarchar(50),
	@TypeContent nvarchar(50)
)
AS
/*
** Update a row in the RetentionTemp table using the primary key
*/
UPDATE [RetentionTemp] SET [UserID] = @UserID, [ContentGuid] = @ContentGuid, [TypeContent] = @TypeContent WHERE [ContentGuid] = @ContentGuidOriginal


/*
** Select the updated row
*/
SELECT
	gv_RetentionTemp.*
FROM
	gv_RetentionTemp
WHERE
	[ContentGuid] = @ContentGuidOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_RiskLevel_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RiskLevel_Insert]
(
	@RiskCode char(10),
	@Description nvarchar(4000),
	@CreateDate datetime
)
AS
/*
** Add a row to the RiskLevel table
*/

INSERT INTO [RiskLevel]
( [RiskCode], [Description], [CreateDate]
)
VALUES
( @RiskCode, @Description, @CreateDate
)

/*
** Select the new row
*/
SELECT
	gv_RiskLevel.*
FROM
	gv_RiskLevel


GO
/****** Object:  StoredProcedure [dbo].[gp_RiskLevel_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RiskLevel_SelectAll]
AS
/*
** Select all rows from the RiskLevel table
*/

SELECT 
	gv_RiskLevel.*
FROM
	gv_RiskLevel


GO
/****** Object:  StoredProcedure [dbo].[gp_RiskLevel_SelectBy]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[gp_RiskLevel_SelectBy] AS PRINT 'ALTER PROC will update this'


GO
/****** Object:  StoredProcedure [dbo].[gp_RunParms_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RunParms_Delete]
(
	@Parm nvarchar(50),
	@UserID nvarchar(50)
)
AS
/*
** Delete a row from the RunParms table
*/
DELETE FROM [RunParms] WHERE [Parm] = @Parm AND [UserID] = @UserID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the RunParms table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_RunParms_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RunParms_Insert]
(
	@Parm nvarchar(50),
	@ParmValue nvarchar(50),
	@UserID nvarchar(50)
)
AS
/*
** Add a row to the RunParms table
*/

INSERT INTO [RunParms]
( [Parm], [ParmValue], [UserID]
)
VALUES
( @Parm, @ParmValue, @UserID
)

/*
** Select the new row
*/
SELECT
	gv_RunParms.*
FROM
	gv_RunParms
WHERE
	[Parm] = @Parm
	AND [UserID] = @UserID


GO
/****** Object:  StoredProcedure [dbo].[gp_RunParms_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RunParms_SelectAll]
AS
/*
** Select all rows from the RunParms table
*/

SELECT 
	gv_RunParms.*
FROM
	gv_RunParms
ORDER BY
	[Parm],
	[UserID]


GO
/****** Object:  StoredProcedure [dbo].[gp_RunParms_SelectByParmAndUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RunParms_SelectByParmAndUserID]
(
	@Parm nvarchar(50),
	@UserID nvarchar(50)
)
AS
/*
** Select a row from the RunParms table by primary key
*/

SELECT 
	gv_RunParms.*
FROM
	gv_RunParms WHERE [Parm] = @Parm AND [UserID] = @UserID


GO
/****** Object:  StoredProcedure [dbo].[gp_RunParms_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RunParms_Update]
(
	@ParmOriginal nvarchar(50), 
	@Parm nvarchar(50),
	@UserIDOriginal nvarchar(50), 
	@UserID nvarchar(50),
	@ParmValue nvarchar(50)
)
AS
/*
** Update a row in the RunParms table using the primary key
*/
UPDATE [RunParms] SET [Parm] = @Parm, [ParmValue] = @ParmValue, [UserID] = @UserID WHERE [Parm] = @ParmOriginal AND [UserID] = @UserIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_RunParms.*
FROM
	gv_RunParms
WHERE
	[Parm] = @ParmOriginal
	AND [UserID] = @UserIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_RuntimeErrors_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RuntimeErrors_Insert]
(
	@ErrorMsg nvarchar(max),
	@StackTrace nvarchar(max),
	@EntryDate datetime,
	@IdNbr nvarchar(50),
	@ConnectiveGuid nvarchar(50),
	@UserID nvarchar(50)
)
AS
/*
** Add a row to the RuntimeErrors table
*/

INSERT INTO [RuntimeErrors]
( [ErrorMsg], [StackTrace], [EntryDate], [IdNbr], [ConnectiveGuid], [UserID]
)
VALUES
( @ErrorMsg, @StackTrace, @EntryDate, @IdNbr, @ConnectiveGuid, @UserID
)

/*
** Select the new row
*/
SELECT
	gv_RuntimeErrors.*
FROM
	gv_RuntimeErrors


GO
/****** Object:  StoredProcedure [dbo].[gp_RuntimeErrors_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_RuntimeErrors_SelectAll]
AS
/*
** Select all rows from the RuntimeErrors table
*/

SELECT 
	gv_RuntimeErrors.*
FROM
	gv_RuntimeErrors


GO
/****** Object:  StoredProcedure [dbo].[gp_RuntimeErrors_SelectBy]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[gp_RuntimeErrors_SelectBy] AS PRINT 'ALTER PROC will update this'


GO
/****** Object:  StoredProcedure [dbo].[gp_SavedItems_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SavedItems_Delete]
(
	@Userid nvarchar(50),
	@SaveName nvarchar(50),
	@SaveTypeCode nvarchar(50),
	@ValName nvarchar(50)
)
AS
/*
** Delete a row from the SavedItems table
*/
DELETE FROM [SavedItems] WHERE [Userid] = @Userid AND [SaveName] = @SaveName AND [SaveTypeCode] = @SaveTypeCode AND [ValName] = @ValName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the SavedItems table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_SavedItems_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SavedItems_Insert]
(
	@Userid nvarchar(50),
	@SaveName nvarchar(50),
	@SaveTypeCode nvarchar(50),
	@ValName nvarchar(50),
	@ValValue nvarchar(254)
)
AS
/*
** Add a row to the SavedItems table
*/

INSERT INTO [SavedItems]
( [Userid], [SaveName], [SaveTypeCode], [ValName], [ValValue]
)
VALUES
( @Userid, @SaveName, @SaveTypeCode, @ValName, @ValValue
)

/*
** Select the new row
*/
SELECT
	gv_SavedItems.*
FROM
	gv_SavedItems
WHERE
	[Userid] = @Userid
	AND [SaveName] = @SaveName
	AND [SaveTypeCode] = @SaveTypeCode
	AND [ValName] = @ValName


GO
/****** Object:  StoredProcedure [dbo].[gp_SavedItems_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SavedItems_SelectAll]
AS
/*
** Select all rows from the SavedItems table
*/

SELECT 
	gv_SavedItems.*
FROM
	gv_SavedItems
ORDER BY
	[Userid],
	[SaveName],
	[SaveTypeCode],
	[ValName]


GO
/****** Object:  StoredProcedure [dbo].[gp_SavedItems_SelectByUseridAndSaveNameAndSaveTypeCodeAndValName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SavedItems_SelectByUseridAndSaveNameAndSaveTypeCodeAndValName]
(
	@Userid nvarchar(50),
	@SaveName nvarchar(50),
	@SaveTypeCode nvarchar(50),
	@ValName nvarchar(50)
)
AS
/*
** Select a row from the SavedItems table by primary key
*/

SELECT 
	gv_SavedItems.*
FROM
	gv_SavedItems WHERE [Userid] = @Userid AND [SaveName] = @SaveName AND [SaveTypeCode] = @SaveTypeCode AND [ValName] = @ValName


GO
/****** Object:  StoredProcedure [dbo].[gp_SavedItems_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SavedItems_Update]
(
	@UseridOriginal nvarchar(50), 
	@Userid nvarchar(50),
	@SaveNameOriginal nvarchar(50), 
	@SaveName nvarchar(50),
	@SaveTypeCodeOriginal nvarchar(50), 
	@SaveTypeCode nvarchar(50),
	@ValNameOriginal nvarchar(50), 
	@ValName nvarchar(50),
	@ValValue nvarchar(254)
)
AS
/*
** Update a row in the SavedItems table using the primary key
*/
UPDATE [SavedItems] SET [Userid] = @Userid, [SaveName] = @SaveName, [SaveTypeCode] = @SaveTypeCode, [ValName] = @ValName, [ValValue] = @ValValue WHERE [Userid] = @UseridOriginal AND [SaveName] = @SaveNameOriginal AND [SaveTypeCode] = @SaveTypeCodeOriginal AND [ValName] = @ValNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_SavedItems.*
FROM
	gv_SavedItems
WHERE
	[Userid] = @UseridOriginal
	AND [SaveName] = @SaveNameOriginal
	AND [SaveTypeCode] = @SaveTypeCodeOriginal
	AND [ValName] = @ValNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_SearchHistory_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SearchHistory_Delete]
(
	@RowID int
)
AS
/*
** Delete a row from the SearchHistory table
*/
DELETE FROM [SearchHistory] WHERE [RowID] = @RowID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the SearchHistory table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_SearchHistory_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SearchHistory_Insert]
(
	@SearchSql nvarchar(max),
	@SearchDate datetime,
	@UserID nvarchar(50),
	@ReturnedRows int,
	@StartTime datetime,
	@EndTime datetime,
	@CalledFrom nvarchar(50),
	@TypeSearch nvarchar(50)
)
AS
/*
** Add a row to the SearchHistory table
*/

INSERT INTO [SearchHistory]
( [SearchSql], [SearchDate], [UserID], [ReturnedRows], [StartTime], [EndTime], [CalledFrom], [TypeSearch]
)
VALUES
( @SearchSql, @SearchDate, @UserID, @ReturnedRows, @StartTime, @EndTime, @CalledFrom, @TypeSearch
)

/*
** Select the new row
*/
SELECT
	gv_SearchHistory.*
FROM
	gv_SearchHistory
WHERE
	[RowID] = (SELECT SCOPE_IDENTITY())


GO
/****** Object:  StoredProcedure [dbo].[gp_SearchHistory_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SearchHistory_SelectAll]
AS
/*
** Select all rows from the SearchHistory table
*/

SELECT 
	gv_SearchHistory.*
FROM
	gv_SearchHistory
ORDER BY
	[RowID]


GO
/****** Object:  StoredProcedure [dbo].[gp_SearchHistory_SelectByRowID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SearchHistory_SelectByRowID]
(
	@RowID int
)
AS
/*
** Select a row from the SearchHistory table by primary key
*/

SELECT 
	gv_SearchHistory.*
FROM
	gv_SearchHistory WHERE [RowID] = @RowID


GO
/****** Object:  StoredProcedure [dbo].[gp_SearchHistory_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SearchHistory_Update]
(
	@RowIDOriginal int,
	@SearchSql nvarchar(max),
	@SearchDate datetime,
	@UserID nvarchar(50),
	@ReturnedRows int,
	@StartTime datetime,
	@EndTime datetime,
	@CalledFrom nvarchar(50),
	@TypeSearch nvarchar(50)
)
AS
/*
** Update a row in the SearchHistory table using the primary key
*/
UPDATE [SearchHistory] SET [SearchSql] = @SearchSql, [SearchDate] = @SearchDate, [UserID] = @UserID, [ReturnedRows] = @ReturnedRows, [StartTime] = @StartTime, [EndTime] = @EndTime, [CalledFrom] = @CalledFrom, [TypeSearch] = @TypeSearch WHERE [RowID] = @RowIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_SearchHistory.*
FROM
	gv_SearchHistory
WHERE
	[RowID] = @RowIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_SearhParmsHistory_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SearhParmsHistory_Insert]
(
	@UserID nvarchar(50),
	@SearchDate datetime,
	@Screen nvarchar(50),
	@QryParms nvarchar(max)
)
AS
/*
** Add a row to the SearhParmsHistory table
*/

INSERT INTO [SearhParmsHistory]
( [UserID], [SearchDate], [Screen], [QryParms]
)
VALUES
( @UserID, @SearchDate, @Screen, @QryParms
)




GO
/****** Object:  StoredProcedure [dbo].[gp_SearhParmsHistory_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SearhParmsHistory_SelectAll]
AS
/*
** Select all rows from the SearhParmsHistory table
*/

SELECT 
	gv_SearhParmsHistory.*
FROM
	gv_SearhParmsHistory


GO
/****** Object:  StoredProcedure [dbo].[gp_SearhParmsHistory_SelectBy]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[gp_SearhParmsHistory_SelectBy] AS PRINT 'ALTER PROC will update this'


GO
/****** Object:  StoredProcedure [dbo].[gp_SkipWords_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SkipWords_Delete]
(
	@tgtWord nvarchar(18)
)
AS
/*
** Delete a row from the SkipWords table
*/
DELETE FROM [SkipWords] WHERE [tgtWord] = @tgtWord

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the SkipWords table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_SkipWords_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SkipWords_Insert]
(
	@tgtWord nvarchar(18)
)
AS
/*
** Add a row to the SkipWords table
*/

INSERT INTO [SkipWords]
( [tgtWord]
)
VALUES
( @tgtWord
)

/*
** Select the new row
*/
SELECT
	gv_SkipWords.*
FROM
	gv_SkipWords
WHERE
	[tgtWord] = @tgtWord


GO
/****** Object:  StoredProcedure [dbo].[gp_SkipWords_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SkipWords_SelectAll]
AS
/*
** Select all rows from the SkipWords table
*/

SELECT 
	gv_SkipWords.*
FROM
	gv_SkipWords
ORDER BY
	[tgtWord]


GO
/****** Object:  StoredProcedure [dbo].[gp_SkipWords_SelectBytgtWord]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SkipWords_SelectBytgtWord]
(
	@tgtWord nvarchar(18)
)
AS
/*
** Select a row from the SkipWords table by primary key
*/

SELECT 
	gv_SkipWords.*
FROM
	gv_SkipWords WHERE [tgtWord] = @tgtWord


GO
/****** Object:  StoredProcedure [dbo].[gp_SkipWords_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SkipWords_Update]
(
	@tgtWordOriginal nvarchar(18), 
	@tgtWord nvarchar(18)
)
AS
/*
** Update a row in the SkipWords table using the primary key
*/
UPDATE [SkipWords] SET [tgtWord] = @tgtWord WHERE [tgtWord] = @tgtWordOriginal


/*
** Select the updated row
*/
SELECT
	gv_SkipWords.*
FROM
	gv_SkipWords
WHERE
	[tgtWord] = @tgtWordOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_SourceAttribute_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SourceAttribute_Delete]
(
	@AttributeName nvarchar(50),
	@SourceGuid nvarchar(50),
	@DataSourceOwnerUserID nvarchar(50)
)
AS
/*
** Delete a row from the SourceAttribute table
*/
DELETE FROM [SourceAttribute] WHERE [AttributeName] = @AttributeName AND [SourceGuid] = @SourceGuid AND [DataSourceOwnerUserID] = @DataSourceOwnerUserID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the SourceAttribute table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_SourceAttribute_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SourceAttribute_Insert]
(
	@AttributeValue nvarchar(254),
	@AttributeName nvarchar(50),
	@SourceGuid nvarchar(50),
	@DataSourceOwnerUserID nvarchar(50),
	@SourceTypeCode nvarchar(50)
)
AS
/*
** Add a row to the SourceAttribute table
*/

INSERT INTO [SourceAttribute]
( [AttributeValue], [AttributeName], [SourceGuid], [DataSourceOwnerUserID], [SourceTypeCode]
)
VALUES
( @AttributeValue, @AttributeName, @SourceGuid, @DataSourceOwnerUserID, @SourceTypeCode
)

/*
** Select the new row
*/
SELECT
	gv_SourceAttribute.*
FROM
	gv_SourceAttribute
WHERE
	[AttributeName] = @AttributeName
	AND [SourceGuid] = @SourceGuid
	AND [DataSourceOwnerUserID] = @DataSourceOwnerUserID


GO
/****** Object:  StoredProcedure [dbo].[gp_SourceAttribute_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SourceAttribute_SelectAll]
AS
/*
** Select all rows from the SourceAttribute table
*/

SELECT 
	gv_SourceAttribute.*
FROM
	gv_SourceAttribute
ORDER BY
	[AttributeName],
	[SourceGuid],
	[DataSourceOwnerUserID]


GO
/****** Object:  StoredProcedure [dbo].[gp_SourceAttribute_SelectByAttributeNameAndSourceGuidAndDataSourceOwnerUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SourceAttribute_SelectByAttributeNameAndSourceGuidAndDataSourceOwnerUserID]
(
	@AttributeName nvarchar(50),
	@SourceGuid nvarchar(50),
	@DataSourceOwnerUserID nvarchar(50)
)
AS
/*
** Select a row from the SourceAttribute table by primary key
*/

SELECT 
	gv_SourceAttribute.*
FROM
	gv_SourceAttribute WHERE [AttributeName] = @AttributeName AND [SourceGuid] = @SourceGuid AND [DataSourceOwnerUserID] = @DataSourceOwnerUserID


GO
/****** Object:  StoredProcedure [dbo].[gp_SourceAttribute_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SourceAttribute_Update]
(
	@AttributeNameOriginal nvarchar(50), 
	@AttributeName nvarchar(50),
	@SourceGuidOriginal nvarchar(50), 
	@SourceGuid nvarchar(50),
	@DataSourceOwnerUserIDOriginal nvarchar(50), 
	@DataSourceOwnerUserID nvarchar(50),
	@AttributeValue nvarchar(254),
	@SourceTypeCode nvarchar(50)
)
AS
/*
** Update a row in the SourceAttribute table using the primary key
*/
UPDATE [SourceAttribute] SET [AttributeValue] = @AttributeValue, [AttributeName] = @AttributeName, [SourceGuid] = @SourceGuid, [DataSourceOwnerUserID] = @DataSourceOwnerUserID, [SourceTypeCode] = @SourceTypeCode WHERE [AttributeName] = @AttributeNameOriginal AND [SourceGuid] = @SourceGuidOriginal AND [DataSourceOwnerUserID] = @DataSourceOwnerUserIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_SourceAttribute.*
FROM
	gv_SourceAttribute
WHERE
	[AttributeName] = @AttributeNameOriginal
	AND [SourceGuid] = @SourceGuidOriginal
	AND [DataSourceOwnerUserID] = @DataSourceOwnerUserIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_SourceContainer_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SourceContainer_Delete]
(
	@ContainerType nvarchar(25)
)
AS
/*
** Delete a row from the SourceContainer table
*/
DELETE FROM [SourceContainer] WHERE [ContainerType] = @ContainerType

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the SourceContainer table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_SourceContainer_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SourceContainer_Insert]
(
	@ContainerType nvarchar(25),
	@ContainerDesc nvarchar(4000),
	@CreateDate datetime
)
AS
/*
** Add a row to the SourceContainer table
*/

INSERT INTO [SourceContainer]
( [ContainerType], [ContainerDesc], [CreateDate]
)
VALUES
( @ContainerType, @ContainerDesc, @CreateDate
)

/*
** Select the new row
*/
SELECT
	gv_SourceContainer.*
FROM
	gv_SourceContainer
WHERE
	[ContainerType] = @ContainerType


GO
/****** Object:  StoredProcedure [dbo].[gp_SourceContainer_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SourceContainer_SelectAll]
AS
/*
** Select all rows from the SourceContainer table
*/

SELECT 
	gv_SourceContainer.*
FROM
	gv_SourceContainer
ORDER BY
	[ContainerType]


GO
/****** Object:  StoredProcedure [dbo].[gp_SourceContainer_SelectByContainerType]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SourceContainer_SelectByContainerType]
(
	@ContainerType nvarchar(25)
)
AS
/*
** Select a row from the SourceContainer table by primary key
*/

SELECT 
	gv_SourceContainer.*
FROM
	gv_SourceContainer WHERE [ContainerType] = @ContainerType


GO
/****** Object:  StoredProcedure [dbo].[gp_SourceContainer_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SourceContainer_Update]
(
	@ContainerTypeOriginal nvarchar(25), 
	@ContainerType nvarchar(25),
	@ContainerDesc nvarchar(4000),
	@CreateDate datetime
)
AS
/*
** Update a row in the SourceContainer table using the primary key
*/
UPDATE [SourceContainer] SET [ContainerType] = @ContainerType, [ContainerDesc] = @ContainerDesc, [CreateDate] = @CreateDate WHERE [ContainerType] = @ContainerTypeOriginal


/*
** Select the updated row
*/
SELECT
	gv_SourceContainer.*
FROM
	gv_SourceContainer
WHERE
	[ContainerType] = @ContainerTypeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_SourceType_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SourceType_Delete]
(
	@SourceTypeCode nvarchar(50)
)
AS
/*
** Delete a row from the SourceType table
*/
DELETE FROM [SourceType] WHERE [SourceTypeCode] = @SourceTypeCode

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the SourceType table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_SourceType_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SourceType_Insert]
(
	@SourceTypeCode nvarchar(50),
	@StoreExternal bit,
	@SourceTypeDesc nvarchar(254),
	@Indexable bit
)
AS
/*
** Add a row to the SourceType table
*/

INSERT INTO [SourceType]
( [SourceTypeCode], [StoreExternal], [SourceTypeDesc], [Indexable]
)
VALUES
( @SourceTypeCode, @StoreExternal, @SourceTypeDesc, @Indexable
)

/*
** Select the new row
*/
SELECT
	gv_SourceType.*
FROM
	gv_SourceType
WHERE
	[SourceTypeCode] = @SourceTypeCode


GO
/****** Object:  StoredProcedure [dbo].[gp_SourceType_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SourceType_SelectAll]
AS
/*
** Select all rows from the SourceType table
*/

SELECT 
	gv_SourceType.*
FROM
	gv_SourceType
ORDER BY
	[SourceTypeCode]


GO
/****** Object:  StoredProcedure [dbo].[gp_SourceType_SelectBySourceTypeCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SourceType_SelectBySourceTypeCode]
(
	@SourceTypeCode nvarchar(50)
)
AS
/*
** Select a row from the SourceType table by primary key
*/

SELECT 
	gv_SourceType.*
FROM
	gv_SourceType WHERE [SourceTypeCode] = @SourceTypeCode


GO
/****** Object:  StoredProcedure [dbo].[gp_SourceType_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SourceType_Update]
(
	@SourceTypeCodeOriginal nvarchar(50), 
	@SourceTypeCode nvarchar(50),
	@StoreExternal bit,
	@SourceTypeDesc nvarchar(254),
	@Indexable bit
)
AS
/*
** Update a row in the SourceType table using the primary key
*/
UPDATE [SourceType] SET [SourceTypeCode] = @SourceTypeCode, [StoreExternal] = @StoreExternal, [SourceTypeDesc] = @SourceTypeDesc, [Indexable] = @Indexable WHERE [SourceTypeCode] = @SourceTypeCodeOriginal


/*
** Select the updated row
*/
SELECT
	gv_SourceType.*
FROM
	gv_SourceType
WHERE
	[SourceTypeCode] = @SourceTypeCodeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_Storage_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Storage_Delete]
(
	@StoreCode nvarchar(50)
)
AS
/*
** Delete a row from the Storage table
*/
DELETE FROM [Storage] WHERE [StoreCode] = @StoreCode

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the Storage table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_Storage_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Storage_Insert]
(
	@StoreCode nvarchar(50),
	@StoreDesc nvarchar(18),
	@CreateDate datetime
)
AS
/*
** Add a row to the Storage table
*/

INSERT INTO [Storage]
( [StoreCode], [StoreDesc], [CreateDate]
)
VALUES
( @StoreCode, @StoreDesc, @CreateDate
)

/*
** Select the new row
*/
SELECT
	gv_Storage.*
FROM
	gv_Storage
WHERE
	[StoreCode] = @StoreCode


GO
/****** Object:  StoredProcedure [dbo].[gp_Storage_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Storage_SelectAll]
AS
/*
** Select all rows from the Storage table
*/

SELECT 
	gv_Storage.*
FROM
	gv_Storage
ORDER BY
	[StoreCode]


GO
/****** Object:  StoredProcedure [dbo].[gp_Storage_SelectByStoreCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Storage_SelectByStoreCode]
(
	@StoreCode nvarchar(50)
)
AS
/*
** Select a row from the Storage table by primary key
*/

SELECT 
	gv_Storage.*
FROM
	gv_Storage WHERE [StoreCode] = @StoreCode


GO
/****** Object:  StoredProcedure [dbo].[gp_Storage_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Storage_Update]
(
	@StoreCodeOriginal nvarchar(50), 
	@StoreCode nvarchar(50),
	@StoreDesc nvarchar(18),
	@CreateDate datetime
)
AS
/*
** Update a row in the Storage table using the primary key
*/
UPDATE [Storage] SET [StoreCode] = @StoreCode, [StoreDesc] = @StoreDesc, [CreateDate] = @CreateDate WHERE [StoreCode] = @StoreCodeOriginal


/*
** Select the updated row
*/
SELECT
	gv_Storage.*
FROM
	gv_Storage
WHERE
	[StoreCode] = @StoreCodeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_SubDir_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SubDir_Delete]
(
	@UserID nvarchar(50),
	@SUBFQN nvarchar(254),
	@FQN varchar(254)
)
AS
/*
** Delete a row from the SubDir table
*/
DELETE FROM [SubDir] WHERE [UserID] = @UserID AND [SUBFQN] = @SUBFQN AND [FQN] = @FQN

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the SubDir table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_SubDir_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SubDir_Insert]
(
	@UserID nvarchar(50),
	@SUBFQN nvarchar(254),
	@FQN varchar(254),
	@ckPublic nchar(1),
	@ckDisableDir nchar(1),
	@OcrDirectory nchar(1),
	@VersionFiles nchar(1),
	@isSysDefault bit
)
AS
/*
** Add a row to the SubDir table
*/

INSERT INTO [SubDir]
( [UserID], [SUBFQN], [FQN], [ckPublic], [ckDisableDir], [OcrDirectory], [VersionFiles], [isSysDefault]
)
VALUES
( @UserID, @SUBFQN, @FQN, @ckPublic, @ckDisableDir, @OcrDirectory, @VersionFiles, @isSysDefault
)

/*
** Select the new row
*/
SELECT
	gv_SubDir.*
FROM
	gv_SubDir
WHERE
	[UserID] = @UserID
	AND [SUBFQN] = @SUBFQN
	AND [FQN] = @FQN


GO
/****** Object:  StoredProcedure [dbo].[gp_SubDir_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SubDir_SelectAll]
AS
/*
** Select all rows from the SubDir table
*/

SELECT 
	gv_SubDir.*
FROM
	gv_SubDir
ORDER BY
	[UserID],
	[SUBFQN],
	[FQN]


GO
/****** Object:  StoredProcedure [dbo].[gp_SubDir_SelectByFQNAndUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SubDir_SelectByFQNAndUserID]
(
	@FQN varchar(254),
	@UserID nvarchar(50)
)
AS
/*
** Select rows from the SubDir table by FQN and UserID
*/
SELECT 
	gv_SubDir.*
FROM
	gv_SubDir WHERE [FQN] = @FQN AND [UserID] = @UserID ORDER BY [UserID], [SUBFQN], [FQN]


GO
/****** Object:  StoredProcedure [dbo].[gp_SubDir_SelectByUserIDAndSUBFQNAndFQN]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SubDir_SelectByUserIDAndSUBFQNAndFQN]
(
	@UserID nvarchar(50),
	@SUBFQN nvarchar(254),
	@FQN varchar(254)
)
AS
/*
** Select a row from the SubDir table by primary key
*/

SELECT 
	gv_SubDir.*
FROM
	gv_SubDir WHERE [UserID] = @UserID AND [SUBFQN] = @SUBFQN AND [FQN] = @FQN


GO
/****** Object:  StoredProcedure [dbo].[gp_SubDir_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SubDir_Update]
(
	@UserIDOriginal nvarchar(50), 
	@UserID nvarchar(50),
	@SUBFQNOriginal nvarchar(254), 
	@SUBFQN nvarchar(254),
	@FQNOriginal varchar(254), 
	@FQN varchar(254),
	@ckPublic nchar(1),
	@ckDisableDir nchar(1),
	@OcrDirectory nchar(1),
	@VersionFiles nchar(1),
	@isSysDefault bit
)
AS
/*
** Update a row in the SubDir table using the primary key
*/
UPDATE [SubDir] SET [UserID] = @UserID, [SUBFQN] = @SUBFQN, [FQN] = @FQN, [ckPublic] = @ckPublic, [ckDisableDir] = @ckDisableDir, [OcrDirectory] = @OcrDirectory, [VersionFiles] = @VersionFiles, [isSysDefault] = @isSysDefault WHERE [UserID] = @UserIDOriginal AND [SUBFQN] = @SUBFQNOriginal AND [FQN] = @FQNOriginal


/*
** Select the updated row
*/
SELECT
	gv_SubDir.*
FROM
	gv_SubDir
WHERE
	[UserID] = @UserIDOriginal
	AND [SUBFQN] = @SUBFQNOriginal
	AND [FQN] = @FQNOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_SubLibrary_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SubLibrary_Delete]
(
	@UserID nvarchar(50),
	@SubUserID nvarchar(50),
	@LibraryName nvarchar(80),
	@SubLibraryName nvarchar(80)
)
AS
/*
** Delete a row from the SubLibrary table
*/
DELETE FROM [SubLibrary] WHERE [UserID] = @UserID AND [SubUserID] = @SubUserID AND [LibraryName] = @LibraryName AND [SubLibraryName] = @SubLibraryName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the SubLibrary table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_SubLibrary_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SubLibrary_Insert]
(
	@UserID nvarchar(50),
	@SubUserID nvarchar(50),
	@LibraryName nvarchar(80),
	@SubLibraryName nvarchar(80)
)
AS
/*
** Add a row to the SubLibrary table
*/

INSERT INTO [SubLibrary]
( [UserID], [SubUserID], [LibraryName], [SubLibraryName]
)
VALUES
( @UserID, @SubUserID, @LibraryName, @SubLibraryName
)

/*
** Select the new row
*/
SELECT
	gv_SubLibrary.*
FROM
	gv_SubLibrary
WHERE
	[UserID] = @UserID
	AND [SubUserID] = @SubUserID
	AND [LibraryName] = @LibraryName
	AND [SubLibraryName] = @SubLibraryName


GO
/****** Object:  StoredProcedure [dbo].[gp_SubLibrary_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SubLibrary_SelectAll]
AS
/*
** Select all rows from the SubLibrary table
*/

SELECT 
	gv_SubLibrary.*
FROM
	gv_SubLibrary
ORDER BY
	[UserID],
	[SubUserID],
	[LibraryName],
	[SubLibraryName]


GO
/****** Object:  StoredProcedure [dbo].[gp_SubLibrary_SelectByLibraryNameAndUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SubLibrary_SelectByLibraryNameAndUserID]
(
	@LibraryName nvarchar(80),
	@UserID nvarchar(50)
)
AS
/*
** Select rows from the SubLibrary table by LibraryName and UserID
*/
SELECT 
	gv_SubLibrary.*
FROM
	gv_SubLibrary WHERE [LibraryName] = @LibraryName AND [UserID] = @UserID ORDER BY [UserID], [SubUserID], [LibraryName], [SubLibraryName]


GO
/****** Object:  StoredProcedure [dbo].[gp_SubLibrary_SelectBySubLibraryName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SubLibrary_SelectBySubLibraryName]
(
	@SubLibraryName nvarchar(80)
)
AS
/*
** Select rows from the SubLibrary table by SubLibraryName
*/
SELECT 
	gv_SubLibrary.*
FROM
	gv_SubLibrary WHERE [SubLibraryName] = @SubLibraryName ORDER BY [UserID], [SubUserID], [LibraryName], [SubLibraryName]


GO
/****** Object:  StoredProcedure [dbo].[gp_SubLibrary_SelectByUserIDAndSubUserIDAndLibraryNameAndSubLibraryName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SubLibrary_SelectByUserIDAndSubUserIDAndLibraryNameAndSubLibraryName]
(
	@UserID nvarchar(50),
	@SubUserID nvarchar(50),
	@LibraryName nvarchar(80),
	@SubLibraryName nvarchar(80)
)
AS
/*
** Select a row from the SubLibrary table by primary key
*/

SELECT 
	gv_SubLibrary.*
FROM
	gv_SubLibrary WHERE [UserID] = @UserID AND [SubUserID] = @SubUserID AND [LibraryName] = @LibraryName AND [SubLibraryName] = @SubLibraryName


GO
/****** Object:  StoredProcedure [dbo].[gp_SubLibrary_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SubLibrary_Update]
(
	@UserIDOriginal nvarchar(50), 
	@UserID nvarchar(50),
	@SubUserIDOriginal nvarchar(50), 
	@SubUserID nvarchar(50),
	@LibraryNameOriginal nvarchar(80), 
	@LibraryName nvarchar(80),
	@SubLibraryNameOriginal nvarchar(80), 
	@SubLibraryName nvarchar(80)
)
AS
/*
** Update a row in the SubLibrary table using the primary key
*/
UPDATE [SubLibrary] SET [UserID] = @UserID, [SubUserID] = @SubUserID, [LibraryName] = @LibraryName, [SubLibraryName] = @SubLibraryName WHERE [UserID] = @UserIDOriginal AND [SubUserID] = @SubUserIDOriginal AND [LibraryName] = @LibraryNameOriginal AND [SubLibraryName] = @SubLibraryNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_SubLibrary.*
FROM
	gv_SubLibrary
WHERE
	[UserID] = @UserIDOriginal
	AND [SubUserID] = @SubUserIDOriginal
	AND [LibraryName] = @LibraryNameOriginal
	AND [SubLibraryName] = @SubLibraryNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_sysdiagrams_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_sysdiagrams_Delete]
(
	@diagram_id int
)
AS
/*
** Delete a row from the sysdiagrams table
*/
DELETE FROM [sysdiagrams] WHERE [diagram_id] = @diagram_id

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the sysdiagrams table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_sysdiagrams_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_sysdiagrams_Insert]
(
	@name nvarchar(128),
	@principal_id int,
	@version int,
	@definition varbinary(max)
)
AS
/*
** Add a row to the sysdiagrams table
*/

INSERT INTO [sysdiagrams]
( [name], [principal_id], [version], [definition]
)
VALUES
( @name, @principal_id, @version, @definition
)

/*
** Select the new row
*/
SELECT
	gv_sysdiagrams.*
FROM
	gv_sysdiagrams
WHERE
	[diagram_id] = (SELECT SCOPE_IDENTITY())


GO
/****** Object:  StoredProcedure [dbo].[gp_sysdiagrams_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_sysdiagrams_SelectAll]
AS
/*
** Select all rows from the sysdiagrams table
*/

SELECT 
	gv_sysdiagrams.*
FROM
	gv_sysdiagrams
ORDER BY
	[diagram_id]


GO
/****** Object:  StoredProcedure [dbo].[gp_sysdiagrams_SelectBydiagram_id]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_sysdiagrams_SelectBydiagram_id]
(
	@diagram_id int
)
AS
/*
** Select a row from the sysdiagrams table by primary key
*/

SELECT 
	gv_sysdiagrams.*
FROM
	gv_sysdiagrams WHERE [diagram_id] = @diagram_id


GO
/****** Object:  StoredProcedure [dbo].[gp_sysdiagrams_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_sysdiagrams_Update]
(
	@diagram_idOriginal int,
	@name nvarchar(128),
	@principal_id int,
	@version int,
	@definition varbinary(max)
)
AS
/*
** Update a row in the sysdiagrams table using the primary key
*/
UPDATE [sysdiagrams] SET [name] = @name, [principal_id] = @principal_id, [version] = @version, [definition] = @definition WHERE [diagram_id] = @diagram_idOriginal


/*
** Select the updated row
*/
SELECT
	gv_sysdiagrams.*
FROM
	gv_sysdiagrams
WHERE
	[diagram_id] = @diagram_idOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_SystemParms_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SystemParms_Delete]
(
	@SysParm nvarchar(50)
)
AS
/*
** Delete a row from the SystemParms table
*/
DELETE FROM [SystemParms] WHERE [SysParm] = @SysParm

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the SystemParms table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_SystemParms_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SystemParms_Insert]
(
	@SysParm nvarchar(50),
	@SysParmDesc nvarchar(250),
	@SysParmVal nvarchar(250),
	@flgActive nchar(1),
	@isDirectory nchar(1),
	@isEmailFolder nchar(1),
	@flgAllSubDirs nchar(1)
)
AS
/*
** Add a row to the SystemParms table
*/

INSERT INTO [SystemParms]
( [SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]
)
VALUES
( @SysParm, @SysParmDesc, @SysParmVal, @flgActive, @isDirectory, @isEmailFolder, @flgAllSubDirs
)

/*
** Select the new row
*/
SELECT
	gv_SystemParms.*
FROM
	gv_SystemParms
WHERE
	[SysParm] = @SysParm


GO
/****** Object:  StoredProcedure [dbo].[gp_SystemParms_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SystemParms_SelectAll]
AS
/*
** Select all rows from the SystemParms table
*/

SELECT 
	gv_SystemParms.*
FROM
	gv_SystemParms
ORDER BY
	[SysParm]


GO
/****** Object:  StoredProcedure [dbo].[gp_SystemParms_SelectBySysParm]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SystemParms_SelectBySysParm]
(
	@SysParm nvarchar(50)
)
AS
/*
** Select a row from the SystemParms table by primary key
*/

SELECT 
	gv_SystemParms.*
FROM
	gv_SystemParms WHERE [SysParm] = @SysParm


GO
/****** Object:  StoredProcedure [dbo].[gp_SystemParms_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_SystemParms_Update]
(
	@SysParmOriginal nvarchar(50), 
	@SysParm nvarchar(50),
	@SysParmDesc nvarchar(250),
	@SysParmVal nvarchar(250),
	@flgActive nchar(1),
	@isDirectory nchar(1),
	@isEmailFolder nchar(1),
	@flgAllSubDirs nchar(1)
)
AS
/*
** Update a row in the SystemParms table using the primary key
*/
UPDATE [SystemParms] SET [SysParm] = @SysParm, [SysParmDesc] = @SysParmDesc, [SysParmVal] = @SysParmVal, [flgActive] = @flgActive, [isDirectory] = @isDirectory, [isEmailFolder] = @isEmailFolder, [flgAllSubDirs] = @flgAllSubDirs WHERE [SysParm] = @SysParmOriginal


/*
** Select the updated row
*/
SELECT
	gv_SystemParms.*
FROM
	gv_SystemParms
WHERE
	[SysParm] = @SysParmOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_UD_Qty_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UD_Qty_Delete]
(
	@Code char(10)
)
AS
/*
** Delete a row from the UD_Qty table
*/
DELETE FROM [UD_Qty] WHERE [Code] = @Code

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the UD_Qty table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_UD_Qty_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UD_Qty_Insert]
(
	@Code char(10),
	@Description char(10)
)
AS
/*
** Add a row to the UD_Qty table
*/

INSERT INTO [UD_Qty]
( [Code], [Description]
)
VALUES
( @Code, @Description
)

/*
** Select the new row
*/
SELECT
	gv_UD_Qty.*
FROM
	gv_UD_Qty
WHERE
	[Code] = @Code


GO
/****** Object:  StoredProcedure [dbo].[gp_UD_Qty_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UD_Qty_SelectAll]
AS
/*
** Select all rows from the UD_Qty table
*/

SELECT 
	gv_UD_Qty.*
FROM
	gv_UD_Qty
ORDER BY
	[Code]


GO
/****** Object:  StoredProcedure [dbo].[gp_UD_Qty_SelectByCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UD_Qty_SelectByCode]
(
	@Code char(10)
)
AS
/*
** Select a row from the UD_Qty table by primary key
*/

SELECT 
	gv_UD_Qty.*
FROM
	gv_UD_Qty WHERE [Code] = @Code


GO
/****** Object:  StoredProcedure [dbo].[gp_UD_Qty_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UD_Qty_Update]
(
	@CodeOriginal char(10), 
	@Code char(10),
	@Description char(10)
)
AS
/*
** Update a row in the UD_Qty table using the primary key
*/
UPDATE [UD_Qty] SET [Code] = @Code, [Description] = @Description WHERE [Code] = @CodeOriginal


/*
** Select the updated row
*/
SELECT
	gv_UD_Qty.*
FROM
	gv_UD_Qty
WHERE
	[Code] = @CodeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_upgrade_status_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_upgrade_status_Insert]
(
	@name varchar(30),
	@status varchar(10)
)
AS
/*
** Add a row to the upgrade_status table
*/

INSERT INTO [upgrade_status]
( [name], [status]
)
VALUES
( @name, @status
)

/*
** Select the new row
*/
SELECT
	gv_upgrade_status.*
FROM
	gv_upgrade_status


GO
/****** Object:  StoredProcedure [dbo].[gp_upgrade_status_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_upgrade_status_SelectAll]
AS
/*
** Select all rows from the upgrade_status table
*/

SELECT 
	gv_upgrade_status.*
FROM
	gv_upgrade_status


GO
/****** Object:  StoredProcedure [dbo].[gp_upgrade_status_SelectBy]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[gp_upgrade_status_SelectBy] AS PRINT 'ALTER PROC will update this'


GO
/****** Object:  StoredProcedure [dbo].[gp_UrlList_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UrlList_Delete]
(
	@URL nvarchar(425)
)
AS
/*
** Delete a row from the UrlList table
*/
DELETE FROM [UrlList] WHERE [URL] = @URL

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the UrlList table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_UrlList_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UrlList_Insert]
(
	@URL nvarchar(425)
)
AS
/*
** Add a row to the UrlList table
*/

INSERT INTO [UrlList]
( [URL]
)
VALUES
( @URL
)

/*
** Select the new row
*/
SELECT
	gv_UrlList.*
FROM
	gv_UrlList
WHERE
	[URL] = @URL


GO
/****** Object:  StoredProcedure [dbo].[gp_UrlList_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UrlList_SelectAll]
AS
/*
** Select all rows from the UrlList table
*/

SELECT 
	gv_UrlList.*
FROM
	gv_UrlList
ORDER BY
	[URL]


GO
/****** Object:  StoredProcedure [dbo].[gp_UrlList_SelectByURL]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UrlList_SelectByURL]
(
	@URL nvarchar(425)
)
AS
/*
** Select a row from the UrlList table by primary key
*/

SELECT 
	gv_UrlList.*
FROM
	gv_UrlList WHERE [URL] = @URL


GO
/****** Object:  StoredProcedure [dbo].[gp_UrlList_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UrlList_Update]
(
	@URLOriginal nvarchar(425), 
	@URL nvarchar(425)
)
AS
/*
** Update a row in the UrlList table using the primary key
*/
UPDATE [UrlList] SET [URL] = @URL WHERE [URL] = @URLOriginal


/*
** Select the updated row
*/
SELECT
	gv_UrlList.*
FROM
	gv_UrlList
WHERE
	[URL] = @URLOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_UrlRejection_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UrlRejection_Delete]
(
	@RejectionPattern nvarchar(50)
)
AS
/*
** Delete a row from the UrlRejection table
*/
DELETE FROM [UrlRejection] WHERE [RejectionPattern] = @RejectionPattern

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the UrlRejection table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_UrlRejection_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UrlRejection_Insert]
(
	@RejectionPattern nvarchar(50)
)
AS
/*
** Add a row to the UrlRejection table
*/

INSERT INTO [UrlRejection]
( [RejectionPattern]
)
VALUES
( @RejectionPattern
)

/*
** Select the new row
*/
SELECT
	gv_UrlRejection.*
FROM
	gv_UrlRejection
WHERE
	[RejectionPattern] = @RejectionPattern


GO
/****** Object:  StoredProcedure [dbo].[gp_UrlRejection_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UrlRejection_SelectAll]
AS
/*
** Select all rows from the UrlRejection table
*/

SELECT 
	gv_UrlRejection.*
FROM
	gv_UrlRejection
ORDER BY
	[RejectionPattern]


GO
/****** Object:  StoredProcedure [dbo].[gp_UrlRejection_SelectByRejectionPattern]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UrlRejection_SelectByRejectionPattern]
(
	@RejectionPattern nvarchar(50)
)
AS
/*
** Select a row from the UrlRejection table by primary key
*/

SELECT 
	gv_UrlRejection.*
FROM
	gv_UrlRejection WHERE [RejectionPattern] = @RejectionPattern


GO
/****** Object:  StoredProcedure [dbo].[gp_UrlRejection_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UrlRejection_Update]
(
	@RejectionPatternOriginal nvarchar(50), 
	@RejectionPattern nvarchar(50)
)
AS
/*
** Update a row in the UrlRejection table using the primary key
*/
UPDATE [UrlRejection] SET [RejectionPattern] = @RejectionPattern WHERE [RejectionPattern] = @RejectionPatternOriginal


/*
** Select the updated row
*/
SELECT
	gv_UrlRejection.*
FROM
	gv_UrlRejection
WHERE
	[RejectionPattern] = @RejectionPatternOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_UserCurrParm_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UserCurrParm_Insert]
(
	@UserID nvarchar(50),
	@ParmName nvarchar(50),
	@ParmVal nvarchar(2000)
)
AS
/*
** Add a row to the UserCurrParm table
*/

INSERT INTO [UserCurrParm]
( [UserID], [ParmName], [ParmVal]
)
VALUES
( @UserID, @ParmName, @ParmVal
)

/*
** Select the new row
*/
SELECT
	gv_UserCurrParm.*
FROM
	gv_UserCurrParm


GO
/****** Object:  StoredProcedure [dbo].[gp_UserCurrParm_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UserCurrParm_SelectAll]
AS
/*
** Select all rows from the UserCurrParm table
*/

SELECT 
	gv_UserCurrParm.*
FROM
	gv_UserCurrParm


GO
/****** Object:  StoredProcedure [dbo].[gp_UserCurrParm_SelectBy]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[gp_UserCurrParm_SelectBy] AS PRINT 'ALTER PROC will update this'


GO
/****** Object:  StoredProcedure [dbo].[gp_UserGroup_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UserGroup_Delete]
(
	@GroupOwnerUserID nvarchar(50),
	@GroupName nvarchar(80)
)
AS
/*
** Delete a row from the UserGroup table
*/
DELETE FROM [UserGroup] WHERE [GroupOwnerUserID] = @GroupOwnerUserID AND [GroupName] = @GroupName

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the UserGroup table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_UserGroup_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UserGroup_Insert]
(
	@GroupOwnerUserID nvarchar(50),
	@GroupName nvarchar(80)
)
AS
/*
** Add a row to the UserGroup table
*/

INSERT INTO [UserGroup]
( [GroupOwnerUserID], [GroupName]
)
VALUES
( @GroupOwnerUserID, @GroupName
)

/*
** Select the new row
*/
SELECT
	gv_UserGroup.*
FROM
	gv_UserGroup
WHERE
	[GroupOwnerUserID] = @GroupOwnerUserID
	AND [GroupName] = @GroupName


GO
/****** Object:  StoredProcedure [dbo].[gp_UserGroup_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UserGroup_SelectAll]
AS
/*
** Select all rows from the UserGroup table
*/

SELECT 
	gv_UserGroup.*
FROM
	gv_UserGroup
ORDER BY
	[GroupOwnerUserID],
	[GroupName]


GO
/****** Object:  StoredProcedure [dbo].[gp_UserGroup_SelectByGroupOwnerUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UserGroup_SelectByGroupOwnerUserID]
(
	@GroupOwnerUserID nvarchar(50)
)
AS
/*
** Select rows from the UserGroup table by GroupOwnerUserID
*/
SELECT 
	gv_UserGroup.*
FROM
	gv_UserGroup WHERE [GroupOwnerUserID] = @GroupOwnerUserID ORDER BY [GroupOwnerUserID], [GroupName]


GO
/****** Object:  StoredProcedure [dbo].[gp_UserGroup_SelectByGroupOwnerUserIDAndGroupName]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UserGroup_SelectByGroupOwnerUserIDAndGroupName]
(
	@GroupOwnerUserID nvarchar(50),
	@GroupName nvarchar(80)
)
AS
/*
** Select a row from the UserGroup table by primary key
*/

SELECT 
	gv_UserGroup.*
FROM
	gv_UserGroup WHERE [GroupOwnerUserID] = @GroupOwnerUserID AND [GroupName] = @GroupName


GO
/****** Object:  StoredProcedure [dbo].[gp_UserGroup_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UserGroup_Update]
(
	@GroupOwnerUserIDOriginal nvarchar(50), 
	@GroupOwnerUserID nvarchar(50),
	@GroupNameOriginal nvarchar(80), 
	@GroupName nvarchar(80)
)
AS
/*
** Update a row in the UserGroup table using the primary key
*/
UPDATE [UserGroup] SET [GroupOwnerUserID] = @GroupOwnerUserID, [GroupName] = @GroupName WHERE [GroupOwnerUserID] = @GroupOwnerUserIDOriginal AND [GroupName] = @GroupNameOriginal


/*
** Select the updated row
*/
SELECT
	gv_UserGroup.*
FROM
	gv_UserGroup
WHERE
	[GroupOwnerUserID] = @GroupOwnerUserIDOriginal
	AND [GroupName] = @GroupNameOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_UserReassignHist_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UserReassignHist_Insert]
(
	@PrevUserID nvarchar(50),
	@PrevUserName nvarchar(50),
	@PrevEmailAddress nvarchar(254),
	@PrevUserPassword nvarchar(254),
	@PrevAdmin nchar(1),
	@PrevisActive nchar(1),
	@PrevUserLoginID nvarchar(50),
	@ReassignedUserID nvarchar(50),
	@ReassignedUserName nvarchar(50),
	@ReassignedEmailAddress nvarchar(254),
	@ReassignedUserPassword nvarchar(254),
	@ReassignedAdmin nchar(1),
	@ReassignedisActive nchar(1),
	@ReassignedUserLoginID nvarchar(50),
	@ReassignmentDate datetime,
	@RowID uniqueidentifier
)
AS
/*
** Add a row to the UserReassignHist table
*/

INSERT INTO [UserReassignHist]
( [PrevUserID], [PrevUserName], [PrevEmailAddress], [PrevUserPassword], [PrevAdmin], [PrevisActive], [PrevUserLoginID], [ReassignedUserID], [ReassignedUserName], [ReassignedEmailAddress], [ReassignedUserPassword], [ReassignedAdmin], [ReassignedisActive], [ReassignedUserLoginID], [ReassignmentDate]
)
VALUES
( @PrevUserID, @PrevUserName, @PrevEmailAddress, @PrevUserPassword, @PrevAdmin, @PrevisActive, @PrevUserLoginID, @ReassignedUserID, @ReassignedUserName, @ReassignedEmailAddress, @ReassignedUserPassword, @ReassignedAdmin, @ReassignedisActive, @ReassignedUserLoginID, @ReassignmentDate
)

/*
** Select the new row
*/
SELECT
	gv_UserReassignHist.*
FROM
	gv_UserReassignHist


GO
/****** Object:  StoredProcedure [dbo].[gp_UserReassignHist_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_UserReassignHist_SelectAll]
AS
/*
** Select all rows from the UserReassignHist table
*/

SELECT 
	gv_UserReassignHist.*
FROM
	gv_UserReassignHist


GO
/****** Object:  StoredProcedure [dbo].[gp_UserReassignHist_SelectBy]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[gp_UserReassignHist_SelectBy] AS PRINT 'ALTER PROC will update this'


GO
/****** Object:  StoredProcedure [dbo].[gp_Users_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Users_Delete]
(
	@UserID nvarchar(50)
)
AS
/*
** Delete a row from the Users table
*/
DELETE FROM [Users] WHERE [UserID] = @UserID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the Users table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_Users_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Users_Insert]
(
	@UserID nvarchar(50),
	@UserName nvarchar(50),
	@EmailAddress nvarchar(254),
	@UserPassword nvarchar(254),
	@Admin nchar(1),
	@isActive nchar(1),
	@UserLoginID nvarchar(50)
)
AS
/*
** Add a row to the Users table
*/

INSERT INTO [Users]
( [UserID], [UserName], [EmailAddress], [UserPassword], [Admin], [isActive], [UserLoginID]
)
VALUES
( @UserID, @UserName, @EmailAddress, @UserPassword, @Admin, @isActive, @UserLoginID
)

/*
** Select the new row
*/
SELECT
	gv_Users.*
FROM
	gv_Users
WHERE
	[UserID] = @UserID


GO
/****** Object:  StoredProcedure [dbo].[gp_Users_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Users_SelectAll]
AS
/*
** Select all rows from the Users table
*/

SELECT 
	gv_Users.*
FROM
	gv_Users
ORDER BY
	[UserID]


GO
/****** Object:  StoredProcedure [dbo].[gp_Users_SelectByUserID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Users_SelectByUserID]
(
	@UserID nvarchar(50)
)
AS
/*
** Select a row from the Users table by primary key
*/

SELECT 
	gv_Users.*
FROM
	gv_Users WHERE [UserID] = @UserID


GO
/****** Object:  StoredProcedure [dbo].[gp_Users_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Users_Update]
(
	@UserIDOriginal nvarchar(50), 
	@UserID nvarchar(50),
	@UserName nvarchar(50),
	@EmailAddress nvarchar(254),
	@UserPassword nvarchar(254),
	@Admin nchar(1),
	@isActive nchar(1),
	@UserLoginID nvarchar(50)
)
AS
/*
** Update a row in the Users table using the primary key
*/
UPDATE [Users] SET [UserID] = @UserID, [UserName] = @UserName, [EmailAddress] = @EmailAddress, [UserPassword] = @UserPassword, [Admin] = @Admin, [isActive] = @isActive, [UserLoginID] = @UserLoginID WHERE [UserID] = @UserIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_Users.*
FROM
	gv_Users
WHERE
	[UserID] = @UserIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_Volitility_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Volitility_Delete]
(
	@VolitilityCode nvarchar(50)
)
AS
/*
** Delete a row from the Volitility table
*/
DELETE FROM [Volitility] WHERE [VolitilityCode] = @VolitilityCode

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the Volitility table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_Volitility_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Volitility_Insert]
(
	@VolitilityCode nvarchar(50),
	@VolitilityDesc nvarchar(18),
	@CreateDate datetime
)
AS
/*
** Add a row to the Volitility table
*/

INSERT INTO [Volitility]
( [VolitilityCode], [VolitilityDesc], [CreateDate]
)
VALUES
( @VolitilityCode, @VolitilityDesc, @CreateDate
)

/*
** Select the new row
*/
SELECT
	gv_Volitility.*
FROM
	gv_Volitility
WHERE
	[VolitilityCode] = @VolitilityCode


GO
/****** Object:  StoredProcedure [dbo].[gp_Volitility_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Volitility_SelectAll]
AS
/*
** Select all rows from the Volitility table
*/

SELECT 
	gv_Volitility.*
FROM
	gv_Volitility
ORDER BY
	[VolitilityCode]


GO
/****** Object:  StoredProcedure [dbo].[gp_Volitility_SelectByVolitilityCode]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Volitility_SelectByVolitilityCode]
(
	@VolitilityCode nvarchar(50)
)
AS
/*
** Select a row from the Volitility table by primary key
*/

SELECT 
	gv_Volitility.*
FROM
	gv_Volitility WHERE [VolitilityCode] = @VolitilityCode


GO
/****** Object:  StoredProcedure [dbo].[gp_Volitility_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_Volitility_Update]
(
	@VolitilityCodeOriginal nvarchar(50), 
	@VolitilityCode nvarchar(50),
	@VolitilityDesc nvarchar(18),
	@CreateDate datetime
)
AS
/*
** Update a row in the Volitility table using the primary key
*/
UPDATE [Volitility] SET [VolitilityCode] = @VolitilityCode, [VolitilityDesc] = @VolitilityDesc, [CreateDate] = @CreateDate WHERE [VolitilityCode] = @VolitilityCodeOriginal


/*
** Select the updated row
*/
SELECT
	gv_Volitility.*
FROM
	gv_Volitility
WHERE
	[VolitilityCode] = @VolitilityCodeOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_WebSource_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_WebSource_Delete]
(
	@SourceGuid nvarchar(50)
)
AS
/*
** Delete a row from the WebSource table
*/
DELETE FROM [WebSource] WHERE [SourceGuid] = @SourceGuid

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the WebSource table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_WebSource_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_WebSource_Insert]
(
	@SourceGuid nvarchar(50),
	@CreateDate datetime,
	@SourceName nvarchar(254),
	@SourceImage image,
	@SourceTypeCode nvarchar(50),
	@FileLength int,
	@LastWriteTime datetime,
	@RetentionExpirationDate datetime,
	@Description nvarchar(max),
	@KeyWords nvarchar(2000),
	@Notes nvarchar(2000),
	@CreationDate datetime
)
AS
/*
** Add a row to the WebSource table
*/

INSERT INTO [WebSource]
( [SourceGuid], [CreateDate], [SourceName], [SourceImage], [SourceTypeCode], [FileLength], [LastWriteTime], [RetentionExpirationDate], [Description], [KeyWords], [Notes], [CreationDate]
)
VALUES
( @SourceGuid, @CreateDate, @SourceName, @SourceImage, @SourceTypeCode, @FileLength, @LastWriteTime, @RetentionExpirationDate, @Description, @KeyWords, @Notes, @CreationDate
)

/*
** Select the new row
*/
SELECT
	gv_WebSource.*
FROM
	gv_WebSource
WHERE
	[SourceGuid] = @SourceGuid


GO
/****** Object:  StoredProcedure [dbo].[gp_WebSource_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_WebSource_SelectAll]
AS
/*
** Select all rows from the WebSource table
*/

SELECT 
	gv_WebSource.*
FROM
	gv_WebSource
ORDER BY
	[SourceGuid]


GO
/****** Object:  StoredProcedure [dbo].[gp_WebSource_SelectBySourceGuid]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_WebSource_SelectBySourceGuid]
(
	@SourceGuid nvarchar(50)
)
AS
/*
** Select a row from the WebSource table by primary key
*/

SELECT 
	gv_WebSource.*
FROM
	gv_WebSource WHERE [SourceGuid] = @SourceGuid


GO
/****** Object:  StoredProcedure [dbo].[gp_WebSource_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_WebSource_Update]
(
	@SourceGuidOriginal nvarchar(50), 
	@SourceGuid nvarchar(50),
	@CreateDate datetime,
	@SourceName nvarchar(254),
	@SourceImage image,
	@SourceTypeCode nvarchar(50),
	@FileLength int,
	@LastWriteTime datetime,
	@RetentionExpirationDate datetime,
	@Description nvarchar(max),
	@KeyWords nvarchar(2000),
	@Notes nvarchar(2000),
	@CreationDate datetime
)
AS
/*
** Update a row in the WebSource table using the primary key
*/
UPDATE [WebSource] SET [SourceGuid] = @SourceGuid, [CreateDate] = @CreateDate, [SourceName] = @SourceName, [SourceImage] = @SourceImage, [SourceTypeCode] = @SourceTypeCode, [FileLength] = @FileLength, [LastWriteTime] = @LastWriteTime, [RetentionExpirationDate] = @RetentionExpirationDate, [Description] = @Description, [KeyWords] = @KeyWords, [Notes] = @Notes, [CreationDate] = @CreationDate WHERE [SourceGuid] = @SourceGuidOriginal


/*
** Select the updated row
*/
SELECT
	gv_WebSource.*
FROM
	gv_WebSource
WHERE
	[SourceGuid] = @SourceGuidOriginal


GO
/****** Object:  StoredProcedure [dbo].[gp_ZippedFiles_Delete]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ZippedFiles_Delete]
(
	@ContentGUID nvarchar(50)
)
AS
/*
** Delete a row from the ZippedFiles table
*/
DELETE FROM [ZippedFiles] WHERE [ContentGUID] = @ContentGUID

IF @@ROWCOUNT = 0
BEGIN
	RAISERROR ('Delete failed: Zero rows were deleted from the ZippedFiles table', 16, 1)
END


GO
/****** Object:  StoredProcedure [dbo].[gp_ZippedFiles_Insert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ZippedFiles_Insert]
(
	@ContentGUID nvarchar(50),
	@SourceTypeCode nvarchar(50),
	@SourceImage image,
	@SourceGuid nvarchar(50),
	@DataSourceOwnerUserID nvarchar(50)
)
AS
/*
** Add a row to the ZippedFiles table
*/

INSERT INTO [ZippedFiles]
( [ContentGUID], [SourceTypeCode], [SourceImage], [SourceGuid], [DataSourceOwnerUserID]
)
VALUES
( @ContentGUID, @SourceTypeCode, @SourceImage, @SourceGuid, @DataSourceOwnerUserID
)

/*
** Select the new row
*/
SELECT
	gv_ZippedFiles.*
FROM
	gv_ZippedFiles
WHERE
	[ContentGUID] = @ContentGUID


GO
/****** Object:  StoredProcedure [dbo].[gp_ZippedFiles_SelectAll]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ZippedFiles_SelectAll]
AS
/*
** Select all rows from the ZippedFiles table
*/

SELECT 
	gv_ZippedFiles.*
FROM
	gv_ZippedFiles
ORDER BY
	[ContentGUID]


GO
/****** Object:  StoredProcedure [dbo].[gp_ZippedFiles_SelectByContentGUID]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ZippedFiles_SelectByContentGUID]
(
	@ContentGUID nvarchar(50)
)
AS
/*
** Select a row from the ZippedFiles table by primary key
*/

SELECT 
	gv_ZippedFiles.*
FROM
	gv_ZippedFiles WHERE [ContentGUID] = @ContentGUID


GO
/****** Object:  StoredProcedure [dbo].[gp_ZippedFiles_SelectByDataSourceOwnerUserIDAndSourceGuid]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ZippedFiles_SelectByDataSourceOwnerUserIDAndSourceGuid]
(
	@DataSourceOwnerUserID nvarchar(50),
	@SourceGuid nvarchar(50)
)
AS
/*
** Select rows from the ZippedFiles table by DataSourceOwnerUserID and SourceGuid
*/
SELECT 
	gv_ZippedFiles.*
FROM
	gv_ZippedFiles WHERE [DataSourceOwnerUserID] = @DataSourceOwnerUserID AND [SourceGuid] = @SourceGuid ORDER BY [ContentGUID]


GO
/****** Object:  StoredProcedure [dbo].[gp_ZippedFiles_Update]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[gp_ZippedFiles_Update]
(
	@ContentGUIDOriginal nvarchar(50), 
	@ContentGUID nvarchar(50),
	@SourceTypeCode nvarchar(50),
	@SourceImage image,
	@SourceGuid nvarchar(50),
	@DataSourceOwnerUserID nvarchar(50)
)
AS
/*
** Update a row in the ZippedFiles table using the primary key
*/
UPDATE [ZippedFiles] SET [ContentGUID] = @ContentGUID, [SourceTypeCode] = @SourceTypeCode, [SourceImage] = @SourceImage, [SourceGuid] = @SourceGuid, [DataSourceOwnerUserID] = @DataSourceOwnerUserID WHERE [ContentGUID] = @ContentGUIDOriginal


/*
** Select the updated row
*/
SELECT
	gv_ZippedFiles.*
FROM
	gv_ZippedFiles
WHERE
	[ContentGUID] = @ContentGUIDOriginal


GO
/****** Object:  StoredProcedure [dbo].[GraphicsSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
 * PROCEDURE: GraphicsSelProc 
 */

CREATE PROCEDURE [dbo].[GraphicsSelProc]
(
    @GraphicID      int,
    @IssueTitle     nvarchar(400))
AS
BEGIN
    SELECT GraphicID,
           Graphic,
           ResponseID,
           EMail,
           IssueTitle
      FROM Graphics
     WHERE GraphicID  = @GraphicID
       AND IssueTitle = @IssueTitle

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[GroupLibraryAccessSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GroupLibraryAccessSelProc]
(
    @UserID               nvarchar(50),
    @LibraryName          nvarchar(80),
    @GroupOwnerUserID     nvarchar(50),
    @GroupName            nvarchar(80))
AS
BEGIN
    SELECT UserID,
           LibraryName,
           GroupOwnerUserID,
           GroupName
      FROM GroupLibraryAccess
     WHERE UserID           = @UserID
       AND LibraryName      = @LibraryName
       AND GroupOwnerUserID = @GroupOwnerUserID
       AND GroupName        = @GroupName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[GroupUsersSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[GroupUsersSelProc]
(
    @UserID               nvarchar(50),
    @GroupOwnerUserID     nvarchar(50),
    @GroupName            nvarchar(80))
AS
BEGIN
    SELECT UserID,
           FullAccess,
           ReadOnlyAccess,
           DeleteAccess,
           Searchable,
           GroupOwnerUserID,
           GroupName
      FROM GroupUsers
     WHERE UserID           = @UserID
       AND GroupOwnerUserID = @GroupOwnerUserID
       AND GroupName        = @GroupName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[IncludedFilesSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[IncludedFilesSelProc]
(
    @UserID      nvarchar(50),
    @ExtCode     nvarchar(50),
    @FQN         nvarchar(254))
AS
BEGIN
    SELECT UserID,
           ExtCode,
           FQN
      FROM IncludedFiles
     WHERE UserID  = @UserID
       AND ExtCode = @ExtCode
       AND FQN     = @FQN

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[IncludeImmediateSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[IncludeImmediateSelProc]
(
    @FromEmailAddr     nvarchar(254),
    @SenderName        varchar(254),
    @UserID            varchar(25))
AS
BEGIN
    SELECT FromEmailAddr,
           SenderName,
           UserID
      FROM IncludeImmediate
     WHERE FromEmailAddr = @FromEmailAddr
       AND SenderName    = @SenderName
       AND UserID        = @UserID

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[InformationProductSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: InformationProductSelProc 
 */

CREATE PROCEDURE [dbo].[InformationProductSelProc]
(
    @ContainerType      nvarchar(25),
    @CorpFuncName       nvarchar(80),
    @CorpName           nvarchar(50))
AS
BEGIN
    SELECT CreateDate,
           Code,
           RetentionCode,
           VolitilityCode,
           ContainerType,
           CorpFuncName,
           InfoTypeCode,
           CorpName
      FROM InformationProduct
     WHERE ContainerType = @ContainerType
       AND CorpFuncName  = @CorpFuncName
       AND CorpName      = @CorpName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[InformationTypeSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: InformationTypeSelProc 
 */

CREATE PROCEDURE [dbo].[InformationTypeSelProc]
(
    @InfoTypeCode     nvarchar(50))
AS
BEGIN
    SELECT CreateDate,
           InfoTypeCode,
           Description
      FROM InformationType
     WHERE InfoTypeCode = @InfoTypeCode

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[InsertAttachment]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertAttachment]		
		@EmailGuid nvarchar(50),
		@Attachment image,		
		@AttachmentName varchar(254),
		@AttachmentCode varchar(50),
		@UserID varchar(50),
		@CRC varchar(50)
AS
set nocount on
	INSERT INTO [EmailAttachment] (
		[Attachment],
		[AttachmentName],
		[EmailGuid],
		[AttachmentCode],
	    [UserID],
	    CRC
)
	VALUES (
		@Attachment,
		@AttachmentName,
		@EmailGuid,
		@AttachmentCode,
	    @UserID,
	    @CRC
)
RETURN

/****** Object:  StoredProcedure [dbo].[EditAlbum]    Script Date: 03/18/2007 17:30:39 ******/
SET ANSI_NULLS ON



GO
/****** Object:  StoredProcedure [dbo].[InsertDataSource]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
/*
'Dim file_DirName$ = FileAttributes(0)
          'Dim file_SourceName$ = FileAttributes(1)
          'Dim file_FullName$ = FileAttributes(2)
          'Dim file_Length$ = FileAttributes(3)
          'Dim file_SourceTypeCode$ = FileAttributes(4)
          'Dim file_LastAccessDate$ = FileAttributes(5)
          'Dim file_CreateDate$ = FileAttributes(6)
          'Dim file_LastWriteTime$ = FileAttributes(7)
*/
create PROCEDURE [dbo].[InsertDataSource]		
		@SourceGuid nvarchar(50),
		@FQN nvarchar(50),
		@SourceName varchar(254),
		@SourceImage image,				
		@SourceTypeCode varchar(50),
		@LastAccessDate datetime, 
		@CreateDate datetime, 
		@LastWriteTime datetime,
		@DataSourceOwnerUserID varchar(50),
        @VersionNbr int
AS
set nocount on
	INSERT INTO [DataSource] (
		SourceGuid,
		FQN,
		SourceName,
		SourceImage,				
		SourceTypeCode,
		LastAccessDate,
		CreateDate,
		LastWriteTime, 
		DataSourceOwnerUserID,
	    VersionNbr
)
	VALUES (
		@SourceGuid,
		@FQN,
		@SourceName,
		@SourceImage,				
		@SourceTypeCode,
		@LastAccessDate, 
		@CreateDate , 
		@LastWriteTime,
		@DataSourceOwnerUserID,
		@VersionNbr
)
RETURN

/****** Object:  StoredProcedure [dbo].[EditAlbum]    Script Date: 03/18/2007 17:30:39 ******/
SET ANSI_NULLS ON


GO
/****** Object:  StoredProcedure [dbo].[InsertGenerator]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[InsertGenerator]
(@tableName varchar(100)) as
--Declare a cursor to retrieve column specific information 
--for the specified table
DECLARE cursCol CURSOR FAST_FORWARD FOR 
SELECT column_name,data_type FROM information_schema.columns 
    WHERE table_name = @tableName
OPEN cursCol
DECLARE @string nvarchar(3000) --for storing the first half 
                               --of INSERT statement
DECLARE @stringData nvarchar(3000) --for storing the data 
                                   --(VALUES) related statement
DECLARE @dataType nvarchar(1000) --data types returned 
                                 --for respective columns
SET @string='INSERT '+@tableName+'('
SET @stringData=''

DECLARE @colName nvarchar(50)

FETCH NEXT FROM cursCol INTO @colName,@dataType

IF @@fetch_status<>0
    begin
    print 'Table '+@tableName+' not found, processing skipped.'
    close curscol
    deallocate curscol
    return
END

WHILE @@FETCH_STATUS=0
BEGIN
IF @dataType in ('varchar','char','nchar','nvarchar')
BEGIN
    SET @stringData=@stringData+'''''''''+
            isnull('+@colName+','''')+'''''',''+'
END
ELSE
if @dataType in ('text','ntext') --if the datatype 
                                 --is text or something else 
BEGIN
    SET @stringData=@stringData+'''''''''+
          isnull(cast('+@colName+' as varchar(2000)),'''')+'''''',''+'
END
ELSE
IF @dataType = 'money' --because money doesn't get converted 
                       --from varchar implicitly
BEGIN
    SET @stringData=@stringData+'''convert(money,''''''+
        isnull(cast('+@colName+' as varchar(200)),''0.0000'')+''''''),''+'
END
ELSE 
IF @dataType='datetime'
BEGIN
    SET @stringData=@stringData+'''convert(datetime,''''''+
        isnull(cast('+@colName+' as varchar(200)),''0'')+''''''),''+'
END
ELSE 
IF @dataType='image' 
BEGIN
    SET @stringData=@stringData+'''''''''+
       isnull(cast(convert(varbinary,'+@colName+') 
       as varchar(6)),''0'')+'''''',''+'
END
ELSE --presuming the data type is int,bit,numeric,decimal 
BEGIN
    SET @stringData=@stringData+'''''''''+
          isnull(cast('+@colName+' as varchar(200)),''0'')+'''''',''+'
END

SET @string=@string+@colName+','

FETCH NEXT FROM cursCol INTO @colName,@dataType
END
DECLARE @Query nvarchar(4000) -- provide for the whole query, 
                              -- you may increase the size

SET @query ='SELECT '''+substring(@string,0,len(@string)) + ') 
    VALUES(''+ ' + substring(@stringData,0,len(@stringData)-2)+'''+'')'' 
    FROM '+@tableName
exec sp_executesql @query --load and run the built query 
CLOSE cursCol
DEALLOCATE cursCol

GO
/****** Object:  StoredProcedure [dbo].[IssueSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
 * PROCEDURE: IssueSelProc 
 */

CREATE PROCEDURE [dbo].[IssueSelProc]
(
    @IssueTitle           nvarchar(400))
AS
BEGIN
    SELECT CategoryName,
           IssueDescription,
           EntryDate,
           SeverityCode,
           StatusCode,
           EMail,
           IssueTitle,
           LastUpdate,
           CreateDate
      FROM Issue
     WHERE IssueTitle = @IssueTitle

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[JargonWordsSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: JargonWordsSelProc 
 */

CREATE PROCEDURE [dbo].[JargonWordsSelProc]
(
    @tgtWord        nvarchar(50),
    @JargonCode     nvarchar(50))
AS
BEGIN
    SELECT tgtWord,
           jDesc,
           CreateDate,
           JargonCode
      FROM JargonWords
     WHERE tgtWord    = @tgtWord
       AND JargonCode = @JargonCode

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[LibDirectorySelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: LibDirectorySelProc 
 */

CREATE PROCEDURE [dbo].[LibDirectorySelProc]
(
    @DirectoryName     nvarchar(18),
    @UserID            nvarchar(50),
    @LibraryName       nvarchar(80))
AS
BEGIN
    SELECT DirectoryName,
           UserID,
           LibraryName
      FROM LibDirectory
     WHERE DirectoryName = @DirectoryName
       AND UserID        = @UserID
       AND LibraryName   = @LibraryName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[LibEmailSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[LibEmailSelProc]
(
    @EmailFolderEntryID     nvarchar(200),
    @UserID                 nvarchar(50),
    @LibraryName            nvarchar(80))
AS
BEGIN
    SELECT EmailFolderEntryID,
           UserID,
           LibraryName,
           FolderName
      FROM LibEmail
     WHERE EmailFolderEntryID = @EmailFolderEntryID
       AND UserID             = @UserID
       AND LibraryName        = @LibraryName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[LibraryItemsSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[LibraryItemsSelProc]
(
    @LibraryItemGuid           nvarchar(50),
    @LibraryOwnerUserID        nvarchar(50),
    @LibraryName               nvarchar(80))
AS
BEGIN
    SELECT SourceGuid,
           ItemTitle,
           ItemType,
           LibraryItemGuid,
           DataSourceOwnerUserID,
           LibraryOwnerUserID,
           LibraryName,
           AddedByUserGuidId
      FROM LibraryItems
     WHERE LibraryItemGuid    = @LibraryItemGuid
       AND LibraryOwnerUserID = @LibraryOwnerUserID
       AND LibraryName        = @LibraryName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[LibrarySelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[LibrarySelProc]
(
    @UserID          nvarchar(50),
    @LibraryName     nvarchar(80))
AS
BEGIN
    SELECT UserID,
           LibraryName,
           isPublic
      FROM Library
     WHERE UserID      = @UserID
       AND LibraryName = @LibraryName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[LibraryUsersSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[LibraryUsersSelProc]
(
    @UserID                 nvarchar(50),
    @LibraryOwnerUserID     nvarchar(50),
    @LibraryName            nvarchar(80))
AS
BEGIN
    SELECT ReadOnly,
           CreateAccess,
           UpdateAccess,
           DeleteAccess,
           UserID,
           LibraryOwnerUserID,
           LibraryName
      FROM LibraryUsers
     WHERE UserID             = @UserID
       AND LibraryOwnerUserID = @LibraryOwnerUserID
       AND LibraryName        = @LibraryName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[LoadProfileItemSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: LoadProfileItemSelProc 
 */

CREATE PROCEDURE [dbo].[LoadProfileItemSelProc]
(
    @ProfileName        nvarchar(50),
    @SourceTypeCode     nvarchar(50))
AS
BEGIN
    SELECT ProfileName,
           SourceTypeCode
      FROM LoadProfileItem
     WHERE ProfileName    = @ProfileName
       AND SourceTypeCode = @SourceTypeCode

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[LoadProfileSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: LoadProfileSelProc 
 */

CREATE PROCEDURE [dbo].[LoadProfileSelProc]
(
    @ProfileName     nvarchar(50))
AS
BEGIN
    SELECT ProfileName,
           ProfileDesc
      FROM LoadProfile
     WHERE ProfileName = @ProfileName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[MachineRegisteredSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* 
 * PROCEDURE: MachineRegisteredSelProc 
 */

CREATE PROCEDURE [dbo].[MachineRegisteredSelProc]
(
    @MachineGuid            uniqueidentifier)
AS
BEGIN
    SELECT MachineGuid,
           MachineName,
           NetWorkName,
           CreateDate,
           LastUpdate,
           HiveConnectionName,
           HiveActive,
           RepoSvrName,
           RowCreationDate,
           RowLastModDate,
           RepoName
      FROM MachineRegistered
     WHERE MachineGuid = @MachineGuid

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[MachineSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/* 
 * PROCEDURE: MachineSelProc 
 */

CREATE PROCEDURE [dbo].[MachineSelProc]
(
    @UserID                 nvarchar(50),
    @ContentGuid            nvarchar(50),
    @ContentTypeCode        nchar(1),
    @MachineGuid            uniqueidentifier)
AS
BEGIN
    SELECT CreateDate,
           LastUpdate,
           UserID,
           HiveConnectionName,
           HiveActive,
           RepoSvrName,
           RowCreationDate,
           RowLastModDate,
           RepoName,
           RowGuid,
           ContentGuid,
           ContentTypeCode,
           MachineGuid
      FROM Machine
     WHERE UserID          = @UserID
       AND ContentGuid     = @ContentGuid
       AND ContentTypeCode = @ContentTypeCode
       AND MachineGuid     = @MachineGuid

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[OutlookFromSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[OutlookFromSelProc]
(
    @FromEmailAddr     nvarchar(254),
    @SenderName        varchar(254),
    @UserID            varchar(25))
AS
BEGIN
    SELECT FromEmailAddr,
           SenderName,
           UserID,
           Verified
      FROM OutlookFrom
     WHERE FromEmailAddr = @FromEmailAddr
       AND SenderName    = @SenderName
       AND UserID        = @UserID

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[OwnerHistorySelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[OwnerHistorySelProc]
(
    @RowId                   int)
AS
BEGIN
    SELECT PreviousOwnerUserID,
           RowId,
           CurrentOwnerUserID,
           CreateDate
      FROM OwnerHistory
     WHERE RowId = @RowId

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[ProcessFileAsSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[ProcessFileAsSelProc]
(
    @ExtCode            nvarchar(50))
AS
BEGIN
    SELECT ExtCode,
           ProcessExtCode,
           Applied
      FROM ProcessFileAs
     WHERE ExtCode = @ExtCode

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[procGetContentData]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Procedure [dbo].[procGetContentData]
	@SqlStmt VarChar(4000)
AS
	Exec (@SqlStmt);


GO
/****** Object:  StoredProcedure [dbo].[ProdCaptureItemsSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: ProdCaptureItemsSelProc 
 */

CREATE PROCEDURE [dbo].[ProdCaptureItemsSelProc]
(
    @CaptureItemsCode     nvarchar(50),
    @ContainerType        nvarchar(25),
    @CorpFuncName         nvarchar(80),
    @CorpName             nvarchar(50))
AS
BEGIN
    SELECT CaptureItemsCode,
           SendAlert,
           ContainerType,
           CorpFuncName,
           CorpName
      FROM ProdCaptureItems
     WHERE CaptureItemsCode = @CaptureItemsCode
       AND ContainerType    = @ContainerType
       AND CorpFuncName     = @CorpFuncName
       AND CorpName         = @CorpName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[QtyDocsSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: QtyDocsSelProc 
 */

CREATE PROCEDURE [dbo].[QtyDocsSelProc]
(
    @QtyDocCode      nvarchar(10))
AS
BEGIN
    SELECT QtyDocCode,
           Description,
           CreateDate
      FROM QtyDocs
     WHERE QtyDocCode = @QtyDocCode

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[QuickDirectorySelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[QuickDirectorySelProc]
(
    @UserID             nvarchar(50),
    @FQN                varchar(254))
AS
BEGIN
    SELECT UserID,
           IncludeSubDirs,
           FQN,
           DB_ID,
           VersionFiles,
           ckMetaData,
           ckPublic,
           ckDisableDir,
           QuickRefEntry
      FROM QuickDirectory
     WHERE UserID = @UserID
       AND FQN    = @FQN

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[QuickRefItemsSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[QuickRefItemsSelProc]
(
    @QuickRefItemGuid          nvarchar(50))
AS
BEGIN
    SELECT QuickRefIdNbr,
           FQN,
           QuickRefItemGuid,
           SourceGuid,
           DataSourceOwnerUserID,
           Author,
           Description,
           Keywords,
           FileName,
           DirName,
           MarkedForDeletion
      FROM QuickRefItems
     WHERE QuickRefItemGuid = @QuickRefItemGuid

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[QuickRefSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[QuickRefSelProc]
(
    @QuickRefIdNbr     int)
AS
BEGIN
    SELECT UserID,
           QuickRefName,
           QuickRefIdNbr
      FROM QuickRef
     WHERE QuickRefIdNbr = @QuickRefIdNbr

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[RecipientsSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[RecipientsSelProc]
(
    @Recipient     nvarchar(254),
    @EmailGuid     nvarchar(50))
AS
BEGIN
    SELECT Recipient,
           EmailGuid,
           TypeRecp
      FROM Recipients
     WHERE Recipient = @Recipient
       AND EmailGuid = @EmailGuid

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[RepeatDataSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: RepeatDataSelProc 
 */

CREATE PROCEDURE [dbo].[RepeatDataSelProc]
(
    @RepeatDataCode     nvarchar(50))
AS
BEGIN
    SELECT RepeatDataCode,
           RepeatDataDesc
      FROM RepeatData
     WHERE RepeatDataCode = @RepeatDataCode

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[ResponseSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
 * PROCEDURE: ResponseSelProc 
 */

CREATE PROCEDURE [dbo].[ResponseSelProc]
(
    @ResponseID       int,
    @EMail            nvarchar(100),
    @IssueTitle       nvarchar(400))
AS
BEGIN
    SELECT Response,
           ResponseDate,
           StatusCode,
           ResponseID,
           LastUpdate,
           CreateDate,
           EMail,
           IssueTitle
      FROM Response
     WHERE ResponseID = @ResponseID
       AND EMail      = @EMail
       AND IssueTitle = @IssueTitle

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[RetentionSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: RetentionSelProc 
 */

CREATE PROCEDURE [dbo].[RetentionSelProc]
(
    @RetentionCode     nvarchar(50))
AS
BEGIN
    SELECT RetentionCode,
           RetentionDesc
      FROM Retention
     WHERE RetentionCode = @RetentionCode

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[RunParmsSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[RunParmsSelProc]
(
    @Parm          nvarchar(50),
    @UserID        nvarchar(50))
AS
BEGIN
    SELECT Parm,
           ParmValue,
           UserID
      FROM RunParms
     WHERE Parm   = @Parm
       AND UserID = @UserID

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[SeveritySelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
 * PROCEDURE: SeveritySelProc 
 */

CREATE PROCEDURE [dbo].[SeveritySelProc]
(
    @SeverityCode     nvarchar(50))
AS
BEGIN
    SELECT SeverityCode,
           CodeDesc
      FROM Severity
     WHERE SeverityCode = @SeverityCode

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[SkipWordsSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: SkipWordsSelProc 
 */

CREATE PROCEDURE [dbo].[SkipWordsSelProc]
(
    @tgtWord     nvarchar(18))
AS
BEGIN
    SELECT tgtWord
      FROM SkipWords
     WHERE tgtWord = @tgtWord

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[SourceAttr_01282009011746006]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: SourceAttributeSelProc 
 */

CREATE PROCEDURE [dbo].[SourceAttr_01282009011746006]
(
    @AttributeName      nvarchar(50),
    @SourceGuid         nvarchar(50))
AS
BEGIN
    SELECT AttributeValue,
           AttributeName,
           SourceGuid
      FROM SourceAttribute
     WHERE AttributeName = @AttributeName
       AND SourceGuid    = @SourceGuid

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[SourceAttributeSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: SourceAttributeSelProc 
 */

CREATE PROCEDURE [dbo].[SourceAttributeSelProc]
(
    @AttributeName      nvarchar(50),
    @SourceGuid         nvarchar(50))
AS
BEGIN
    SELECT AttributeValue,
           AttributeName,
           SourceGuid
      FROM SourceAttribute
     WHERE AttributeName = @AttributeName
       AND SourceGuid    = @SourceGuid

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[SourceContainerSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: SourceContainerSelProc 
 */

CREATE PROCEDURE [dbo].[SourceContainerSelProc]
(
    @ContainerType     nvarchar(25))
AS
BEGIN
    SELECT ContainerType,
           ContainerDesc,
           CreateDate
      FROM SourceContainer
     WHERE ContainerType = @ContainerType

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[SourceType_04012008185317004]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: SourceTypeSelProc 
 */

CREATE PROCEDURE [dbo].[SourceType_04012008185317004]
(
    @SourceTypeCode     nvarchar(50))
AS
BEGIN
    SELECT SourceTypeCode,
           SourceTypeDesc
      FROM SourceType
     WHERE SourceTypeCode = @SourceTypeCode

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[SourceTypeSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: SourceTypeSelProc 
 */

CREATE PROCEDURE [dbo].[SourceTypeSelProc]
(
    @SourceTypeCode     nvarchar(50))
AS
BEGIN
    SELECT SourceTypeCode,
           SourceTypeDesc
      FROM SourceType
     WHERE SourceTypeCode = @SourceTypeCode

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[sp_CalcRetentionDateDS]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP TRIGGER trgUpdtCalcRetentionDateDS
CREATE Procedure [dbo].[sp_CalcRetentionDateDS] @SourceGuid nvarchar(50)
AS
	Declare @RetentionCode nvarchar(50), @RetentionPeriod nvarchar(50), @RetentionUnits int, @rDate datetime

	set @RetentionCode = (Select RetentionCode from DataSource where SourceGuid = @SourceGuid) 
	set @RetentionPeriod = (Select RetentionPeriod from Retention where Retention.RetentionCode = @RetentionCode) 
	set @RetentionUnits = (Select RetentionUnits from Retention where Retention.RetentionCode = @RetentionCode) 

	if @RetentionPeriod is null Begin
		set @RetentionPeriod = (SELECT MAX(RetentionUnits) from Retention where RetentionPeriod = 'Year')
	END

	--print '- ' + @RetentionPeriod + ' -'
	--print @RetentionUnits 
	--print 'Start'
	--print @SourceGuid
	if @RetentionPeriod = 'Day' begin
		update DataSource set RetentionDate = DATEADD(day,@RetentionUnits,getdate()) 
		WHERE DataSource.Sourceguid = @SourceGuid;
		--set @rDate = (Select RetentionDate from DataSource  where SourceGuid = @SourceGuid)
		--print @rDate 
	END
	if @RetentionPeriod = 'Month' begin
		update DataSource set RetentionDate = DATEADD(month,@RetentionUnits,getdate()) 
		WHERE DataSource.Sourceguid = @SourceGuid;
		--set @rDate = (Select RetentionDate from DataSource  where SourceGuid = @SourceGuid)
		--print  @rDate
	END
	if @RetentionPeriod = 'Year' begin
		--print 'YEAR-2'
		update DataSource set RetentionDate = DATEADD(year,@RetentionUnits,getdate()) 
		WHERE DataSource.Sourceguid = @SourceGuid;
		--set @rDate = (Select RetentionDate from DataSource  where SourceGuid = @SourceGuid)
		--print @rDate
	END



GO
/****** Object:  StoredProcedure [dbo].[sp_CalcTableSpace]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_CalcTableSpace] as 
--SQL Server 2005
--Here is another version of this same process.  
--The overall process is the same, but it uses 
--the new tables in SQL Server 2005.  It also 
--uses the Try Catch processing which was discussed 
--in this previous tip, SQL Server 2005 - Try Catch 
--Exception Handling. Both of the examples will 
--produce the same ouput.
BEGIN try 
DECLARE @table_name VARCHAR(500) ; 
DECLARE @schema_name VARCHAR(500) ; 
DECLARE @tab1 TABLE(
        tablename VARCHAR (500) collate database_default
,       schemaname VARCHAR(500) collate database_default
); 
DECLARE  @temp_table TABLE (    
        tablename sysname
,       row_count INT
,       reserved VARCHAR(50) collate database_default
,       data VARCHAR(50) collate database_default
,       index_size VARCHAR(50) collate database_default
,       unused VARCHAR(50) collate database_default 
); 

INSERT INTO @tab1 
SELECT t1.name
,       t2.name 
FROM sys.tables t1 
INNER JOIN sys.schemas t2 ON ( t1.schema_id = t2.schema_id );   

DECLARE c1 CURSOR FOR 
SELECT t2.name + '.' + t1.name  
FROM sys.tables t1 
INNER JOIN sys.schemas t2 ON ( t1.schema_id = t2.schema_id );   

OPEN c1; 
FETCH NEXT FROM c1 INTO @table_name;
WHILE @@FETCH_STATUS = 0 
BEGIN  
        SET @table_name = REPLACE(@table_name, '[',''); 
        SET @table_name = REPLACE(@table_name, ']',''); 

        -- make sure the object exists before calling sp_spacedused
        IF EXISTS(SELECT OBJECT_ID FROM sys.objects WHERE OBJECT_ID = OBJECT_ID(@table_name))
        BEGIN
                INSERT INTO @temp_table EXEC sp_spaceused @table_name, false ;
        END
        
        FETCH NEXT FROM c1 INTO @table_name; 
END; 
CLOSE c1; 
DEALLOCATE c1; 
SELECT t1.*
,       t2.schemaname 
FROM @temp_table t1 
INNER JOIN @tab1 t2 ON (t1.tablename = t2.tablename )
ORDER BY  schemaname,tablename;
END try 
BEGIN catch 
SELECT -100 AS l1
,       ERROR_NUMBER() AS tablename
,       ERROR_SEVERITY() AS row_count
,       ERROR_STATE() AS reserved
,       ERROR_MESSAGE() AS data
,       1 AS index_size, 1 AS unused, 1 AS schemaname 
END catch


GO
/****** Object:  StoredProcedure [dbo].[sp_CleanTxTimes]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_CleanTxTimes] as 
DECLARE @BatchSize INT,
       @Criteria DATETIME,
       @RowCount INT
SET @BatchSize = 1000
SET @Criteria = getdate()-60
SET @RowCount = 1000
SET ROWCOUNT @BatchSize
WHILE @RowCount > 0
BEGIN
   DELETE
   FROM txTimes
   WHERE CreateDate < @Criteria
   SELECT @RowCount = @@rowcount
END
SET ROWCOUNT 0


GO
/****** Object:  StoredProcedure [dbo].[sp_compare]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_compare] (
        @srcdb varchar(92), @destdb varchar(92)
)
AS
/********************************************************************************/
/*	Created BY :	W. Dale Miller				*/
/*	Created ON :	June 6, 2009     			*/
/*	Description:	This stored PROCEDURE generates a simple report that	*/
/*			compares 2 databases ON same server or different servers*/
/*                      1) set concat_null_yields_null off                      */
/*                      2) Column names for identifiers should be made as 128   */
/*                      characters in length                                    */
/********************************************************************************/

IF OBJECT_ID( 'tempdb..objects' ) IS NOT NULL
        DROP TABLE tempdb..objects
IF OBJECT_ID( 'tempdb..columns' ) IS NOT NULL
        DROP TABLE tempdb..columns
IF OBJECT_ID( 'tempdb..changed_tables_cols' ) IS NOT NULL
        DROP TABLE tempdb..changed_tables_cols
DECLARE @db1 varchar(61), @db2 varchar(61),
	@sp1 varchar(92), @sp2 varchar(92),
	@server1 varchar(92), @server2 varchar(92),
	@db1command varchar(255), @db2command varchar(255),
	@objselect varchar(255), @table varchar(32), @sp varchar(62), @colselectsp varchar(62),
	@mesg varchar(255), @count int
SET NOCOUNT ON
-- SQL70 setting to be enabled for proper working of this SP:
-- SET CONCAT_NULL_YIELDS_NULL OFF
SELECT @db1 = CASE WHEN @srcdb LIKE '%.%' 
		THEN reverse(substring(reverse(@srcdb), 1, charindex('.', reverse(@srcdb)) - 1)) 
		ELSE @srcdb
              END ,
	@db2 = CASE WHEN @destdb LIKE '%.%' 
		THEN reverse(substring(reverse(@destdb), 1, charindex('.', reverse(@destdb)) - 1)) 
		ELSE @destdb
	       END ,
	@server1 = CASE WHEN @srcdb LIKE '%.%'
			THEN substring(@srcdb, 1, charindex('.', @srcdb))
			ELSE NULL
	           END ,
	@server2 = CASE WHEN @destdb LIKE '%.%'
			THEN substring(@destdb, 1, charindex('.', @destdb))
			ELSE NULL
	           END,
	@objselect = 'select name, object_type = CASE type WHEN ''U'' THEN ''table'' ' + 
			'when ''P'' THEN ''stored procedure'' when ''V'' then ''view'' END ' +
			'from sysobjects WHERE type IN (''U'', ''V'', ''P'')',
	@sp = 'master..sp_sqlexec',
	@colselectsp = 'exec sp_columns'
SELECT	@db1command = stuff(@objselect, charindex('sysobjects', @objselect), 
				datalength('sysobjects'), @db1 + '..sysobjects'),
	@db2command = stuff(@objselect, charindex('sysobjects', @objselect), 
			datalength('sysobjects'), @db2 + '..sysobjects'),
	@sp1 =	@server1 + @sp, @sp2 = @server2 + @sp
SELECT	@db1command = stuff(@db1command, charindex('name', @db1command),
			datalength('name') , '''' + @srcdb + ''', name'),
	@db2command = stuff(@db2command, charindex('name', @db2command),
				datalength('name') , '''' + @destdb + ''', name')
-- SQL70:
-- CREATE TABLE #objects (db_name varchar(128), name varchar(128), object_type varchar(30))
CREATE TABLE #objects (db_name varchar(61), name varchar(30), object_type varchar(30))
INSERT #objects EXEC @sp1 @db1command
INSERT #objects EXEC @sp2 @db2command
DELETE #objects WHERE name IN ('objects', 'columns', 'changed_tables_cols', 'upgrade_status')
SELECT @mesg = '1. Tables present ONLY IN database: ' + @srcdb
PRINT @mesg
SELECT name FROM #objects
 WHERE object_type = 'table' AND db_name = @srcdb and 
	name NOT IN (select name FROM #objects WHERE object_type = 'table' AND db_name = @destdb)
 ORDER BY name
PRINT ''
SELECT @mesg = '2. Tables present ONLY IN database: ' + @destdb
PRINT @mesg
SELECT name FROM #objects
 WHERE object_type = 'table' AND db_name = @destdb and 
	name NOT IN (select name FROM #objects WHERE object_type = 'table' AND db_name = @srcdb)
 ORDER BY name
PRINT ''
SELECT @mesg = 'Upgrade status table:'
PRINT @mesg
PRINT 'create TABLE upgrade_status'
PRINT '('
PRINT 'name varchar(30) NOT null,'
PRINT 'status varchar(10) NOT NULL
	CHECK (status IN (''INCOMPLETE'', ''COMPLETE'')) DEFAULT ''INCOMPLETE'''
PRINT ')'
PRINT 'go'
PRINT @mesg
SELECT @mesg = 'insert upgrade_status select name, ''INCOMPLETE'' FROM sysobjects ' +
		'where type = ''U'' AND name NOT IN (''upgrade_status'')'
PRINT @mesg
PRINT ''
SELECT @mesg = 'Drop statements FOR the tables IN the database: ' + @destdb
PRINT @mesg
DECLARE drop_tables CURSOR FOR
SELECT name FROM #objects
 WHERE object_type = 'table' AND db_name = @destdb and 
	name NOT IN (select name FROM #objects WHERE object_type = 'table' AND db_name = @srcdb)
 ORDER BY name
OPEN drop_tables
WHILE( 'FETCH IS OK' = 'FETCH IS OK' )
BEGIN
    	FETCH NEXT FROM drop_tables INTO @table
    	IF @@FETCH_STATUS < 0 BREAK
    	SELECT @mesg = 'print ''Dropping TABLE ' + @table + '..'''
    	PRINT @mesg
    	PRINT 'begin tran'
    	SELECT @mesg = 'if EXISTS (select name FROM upgrade_status WHERE name = ''' + @table +
    			''' AND status = ''INCOMPLETE'')'
    	PRINT @mesg
    	PRINT 'begin'
    	SELECT @mesg = ' DROP TABLE ' + @table
    	PRINT @mesg
    	PRINT ' IF @@error <> 0'
    	PRINT ' begin'
    	PRINT ' IF @@trancount > 0'
    	PRINT 'rollback tran'
    	PRINT ' end'
    	PRINT ' else'
    	PRINT ' begin'
    	SELECT @mesg = ' UPDATE upgrade_status SET status = ''COMPLETE'' WHERE name = ''' +
    			@table + ''''
    	PRINT @mesg
    	PRINT ' COMMIT tran'
    	PRINT ' end'
    	PRINT 'end'
    	PRINT ''
END
CLOSE drop_tables
DEALLOCATE drop_tables
PRINT ''
-- goto END_LABEL
SELECT @mesg = '3. Analyzing tables...'
PRINT @mesg
PRINT ''
-- SQL70:
/*
CREATE TABLE #columns (
        TABLE_QUALIFIER	varchar(128) NULL, TABLE_OWNER varchar(128),
        TABLE_NAME varchar(128), COLUMN_NAME varchar(128),
        DATA_TYPE smallint NULL, TYPE_NAME varchar(128), PREC int,
        LENGTH int, SCALE smallint NULL, RADIX smallint NULL,
        NULLABLE smallint, REMARKS varchar(254) NULL,
        COLUMN_DEF varchar(8000) NULL, SQL_DATA_TYPE smallint,
        SQL_DATETIME_SUB smallint NULL, CHAR_OCTET_LENGTH int NULL,
        ORDINAL_POSITION int, IS_NULLABLE varchar(254), SS_DATA_TYPE tinyint
)
*/
CREATE TABLE #columns (
        TABLE_QUALIFIER	varchar(32) NULL, TABLE_OWNER varchar(32),
        TABLE_NAME varchar(32), COLUMN_NAME varchar(32),
        DATA_TYPE smallint  NULL, TYPE_NAME varchar(13), PREC int,
        LENGTH int, SCALE smallint NULL, RADIX smallint NULL,
        NULLABLE smallint, REMARKS varchar(254)  NULL, 
        COLUMN_DEF varchar(254) NULL, SQL_DATA_TYPE smallint,
        SQL_DATETIME_SUB smallint NULL, CHAR_OCTET_LENGTH int NULL,
        ORDINAL_POSITION int, IS_NULLABLE varchar(254), SS_DATA_TYPE tinyint
)
DECLARE common_tables scroll CURSOR FOR
	SELECT name FROM #objects WHERE object_type = 'table'
	GROUP BY name HAVING count(name) = 2
OPEN common_tables
WHILE( 'FETCH IS OK' = 'FETCH IS OK' )
BEGIN
    	FETCH NEXT FROM common_tables INTO @table
        IF @@FETCH_STATUS < 0 BREAK
    	SELECT	@db1command = 'use' + space(1) + @db1 + space(1) + @colselectsp + space(1) + @table,
    		@db2command = 'use' + space(1) + @db2 + space(1) + @colselectsp + space(1) + @table
    	INSERT #columns EXEC @sp1 @db1command
    	INSERT #columns EXEC @sp2 @db2command
END
CLOSE common_tables
DEALLOCATE common_tables
SELECT space(128) AS TABLE_QUALIFIER, TABLE_NAME, COLUMN_NAME, space(128) AS TYPE_NAME 
  INTO #changed_tables_cols
  FROM #columns
 GROUP BY TABLE_NAME, COLUMN_NAME
HAVING COUNT(*) = 1

UPDATE c1
 SET c1.TABLE_QUALIFIER = c2.TABLE_QUALIFIER
FROM #changed_tables_cols c1, #columns c2
WHERE c1.TABLE_NAME = c2.TABLE_NAME AND c1.COLUMN_NAME = c2.COLUMN_NAME

SELECT @count = 1
DECLARE changed_tables CURSOR FOR
	SELECT DISTINCT TABLE_NAME FROM #changed_tables_cols
OPEN changed_tables
WHILE('FETCH IS OK' = 'FETCH IS OK')
BEGIN
    	FETCH NEXT FROM changed_tables INTO @table
    	IF @@fetch_status < 0 BREAK

    	SELECT @count = @count + 1,
    		@mesg = ltrim(str(@count)) + ') Table: ' + @table
    	PRINT @mesg
    	SELECT @mesg = 'Database: ' + @db1
    	IF EXISTS(SELECT COLUMN_NAME FROM #changed_tables_cols
    		   WHERE TABLE_NAME = @table AND TABLE_QUALIFIER = @db1)
    	BEGIN
    		PRINT @mesg
    		SELECT c.COLUMN_NAME, c.TYPE_NAME, c.LENGTH, c.IS_NULLABLE, c.COLUMN_DEF
    		  FROM #columns c, #changed_tables_cols c1
    		 WHERE c1.TABLE_NAME = @table AND c1.TABLE_QUALIFIER = @db1
    			AND c1.TABLE_NAME = c.TABLE_NAME
    			AND c1.TABLE_QUALIFIER = c.TABLE_QUALIFIER
    			AND c1.COLUMN_NAME = c.COLUMN_NAME
    		PRINT ''
    	END
    	SELECT @mesg = 'Database: ' + @db2
    	IF EXISTS(SELECT COLUMN_NAME FROM #changed_tables_cols
    		   WHERE TABLE_NAME = @table AND TABLE_QUALIFIER = @db2)
    	BEGIN
    		PRINT @mesg
    		SELECT c.COLUMN_NAME, c.TYPE_NAME, c.LENGTH, c.IS_NULLABLE, c.COLUMN_DEF
    		FROM #columns c, #changed_tables_cols c1
    		WHERE c1.TABLE_NAME = @table AND c1.TABLE_QUALIFIER = @db2
    			AND c1.TABLE_NAME = c.TABLE_NAME
    			AND c1.TABLE_QUALIFIER = c.TABLE_QUALIFIER
    			AND c1.COLUMN_NAME = c.COLUMN_NAME
    		PRINT ''
    	END
    	FETCH NEXT FROM changed_tables INTO @table
END
CLOSE changed_tables
DEALLOCATE changed_tables
/*
-- get the other datatype changes.
INSERT #changed_tables_cols
SELECT space(32) AS TABLE_QUALIFIER, TABLE_NAME, COLUMN_NAME , 
TYPE_NAME
 FROM #columns GROUP BY TABLE_NAME, COLUMN_NAME, TYPE_NAME HAVING 
COUNT(*) = 1
UPDATE c1
 SET c1.TABLE_QUALIFIER = c2.TABLE_QUALIFIER
FROM #changed_tables_cols c1, #columns c2
WHERE c1.TABLE_NAME = c2.TABLE_NAME AND c1.COLUMN_NAME = c2.COLUMN_NAME 
and
	c1.TYPE_NAME = c2.TYPE_NAME
DELETE #changed_tables_cols WHERE TYPE_NAME IS NOT NULL AND COLUMN_NAME
IN ('mod_date', 'mod_user')
*/
SELECT @mesg = '4. Stored procedures present ONLY IN database: ' + @srcdb
PRINT @mesg
SELECT name FROM #objects
 WHERE object_type = 'stored procedure' AND db_name = @srcdb and 
	name NOT IN (select name FROM #objects
			WHERE object_type = 'stored procedure' AND db_name = @destdb)
PRINT ''
SELECT @mesg = '5. Stored procedures present ONLY IN database: ' + @destdb
PRINT @mesg
SELECT name FROM #objects
 WHERE object_type = 'stored procedure' AND db_name = @destdb and 
	name NOT IN (select name FROM #objects
			WHERE object_type = 'stored procedure' AND db_name = @destdb)
PRINT ''
SELECT * INTO tempdb..objects FROM #objects
SELECT * INTO tempdb..columns FROM #columns
SELECT * INTO tempdb..changed_tables_cols FROM #changed_tables_cols
END_LABEL:
PRINT 'Comparison of the databases completed.'


GO
/****** Object:  StoredProcedure [dbo].[sp_EcmUpdateDB]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  Procedure [dbo].[sp_EcmUpdateDB]
	@pSql nVarChar(max)
AS
Exec sp_executesql @pSql


GO
/****** Object:  StoredProcedure [dbo].[sp_fulltext_load_thesaurus_fileV2]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[sp_fulltext_load_thesaurus_fileV2]
    @lcid int,
    @loadOnlyIfNotLoaded bit = 0
AS
BEGIN
    SET NOCOUNT ON
    SET IMPLICIT_TRANSACTIONS OFF

    -- sp_fulltext_load_thesaurus_files will run under read committed isolation level
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED

    -- CHECK PERMISSIONS (must be serveradmin)
    if (is_srvrolemember('serveradmin') = 0)
    begin
        raiserror(15247,-1,-1)
        return 1
    end

    -- Disallow user transaction on this sp
    --
    if @@trancount > 0
    begin
        raiserror(15002,-1,-1,'sys.sp_fulltext_load_thesaurus_file')
        return 1
    end

    BEGIN TRY

    BEGIN TRAN

    DECLARE @thesaurusFilePath nvarchar(260)
    SELECT @thesaurusFilePath = NULL
    SELECT @thesaurusFilePath = thesaurus_file_path 
    FROM sys.fn_ft_thesaurus_files()
    WHERE lcid = @lcid

    -- raiserror if @filePath is NULL
    --
    IF (@thesaurusFilePath IS NULL)
    BEGIN
        RAISERROR(30048, 16, 1, @lcid) 
    END
 
    -- load the XML thesaurus file into an xml datatype variable, thereby ensuring that the XML is well formed
    -- Note: the XML is not validated against a schema, since there are issues with the Yukon XML files
    --
    DECLARE @thesaurus xml
    DECLARE @sqlString nvarchar(1024)
    SELECT @sqlString=N'SELECT @thesaurusOut=X.root FROM OPENROWSET(BULK N' + QUOTENAME(@thesaurusFilePath, '''') + N', SINGLE_BLOB) AS X(root)'
    EXECUTE sp_executesql @sqlString, N'@thesaurusOut xml OUTPUT', @thesaurusOut = @thesaurus OUTPUT;

    DECLARE @diacritics_sensitive bit
    SELECT @diacritics_sensitive = 0
    SELECT @diacritics_sensitive = Thesaurus.d_s.value('.', 'bit') 
    FROM @thesaurus.nodes(N'declare namespace PD="x-schema:tsSchema.xml";/XML/PD:thesaurus/PD:diacritics_sensitive') AS Thesaurus(d_s)

    -- This takes a lock on the lcid row
    -- All codepaths accessing the state table, phrase table serialize on the lcid row in this table
    BEGIN TRY
       INSERT tempdb.sys.fulltext_thesaurus_metadata_table VALUES(@lcid, @diacritics_sensitive)
    END TRY
    BEGIN CATCH
       DECLARE @error int
       SELECT @error = ERROR_NUMBER()
       IF (@error = 2601)
       BEGIN
          IF (@loadOnlyIfNotLoaded = 0)
          BEGIN
             -- This means this is a user explicitly calling sp_fulltext_load_thesaurus_file and hence we should
             -- load the thesaurus file again
             -- Note that no code path deletes rows from this table, hence there is no race condition here
             -- 
             UPDATE tempdb.sys.fulltext_thesaurus_metadata_table 
             SET diacritics_sensitive=@diacritics_sensitive
             WHERE lcid=@lcid
          END
          ELSE
          BEGIN
             COMMIT TRAN

             -- this means the engine is trying to load the thesaurus file as part of query
             -- and so we dont need to load the thesaurus file again
             RETURN 0
          END
       END
    END CATCH

    -- deleting existing entries for this lcid from phrase table
    --
    DELETE tempdb.sys.fulltext_thesaurus_phrase_table 
    WHERE lcid = @lcid;

    -- insert expansions and replacements
    -- Note the cast to 513 below. The max string we allow is 512 characters. If there is a phrase 
    -- longer than 512 in the file, it will get truncated to 513 length below but the word breaker fn will ex_raise
    -- it. If we make it 512 below, then the string will get silently truncated which we dont want to happen
    -- We can change to nvarchar(max) also below, but I am keeping it nvarchar(513) for perf reasons
    --
    with xmlnamespaces (N'x-schema:tsSchema.xml' as PD)
    INSERT INTO tempdb.sys.fulltext_thesaurus_phrase_table (groupid, isExpansion, isLHSOfReplacement, lcid, terms)
    SELECT X.rowid AS GroupId, 
           X.isexp AS IsExpansion, 
           Sub.Val.value('if (local-name(.) eq "pat") then 1 else 0', 'int') AS isLHSOfReplacement,
           @lcid,
           WordBrokenPhrase.concatenated_terms
    FROM
    (
    SELECT T2.exp.query('.'), 
           T2.exp.value('if (local-name(.) eq "expansion") then 1 else 0', 'int') isexp, 
           row_number() over (order by T3.DummyOrderingColumn) rowid
    FROM @thesaurus.nodes(N'(/XML/PD:thesaurus/PD:expansion, /XML/PD:thesaurus/PD:replacement)') AS T2(exp)
         -- this CROSS APPLY is needed since order by T2.exp is not a supported feature (even though it works)
         -- There is a light weight improvement that exposes ordpaths and when that gets done, one could potentially
         -- directly order by the ordpath above
         --
         CROSS APPLY (SELECT 1 AS DummyOrderingColumn) T3
    ) X(exprep, isexp, rowid)
    CROSS APPLY 
    X.exprep.nodes(N'(/PD:expansion/PD:sub, /PD:replacement/PD:pat, /PD:replacement/PD:sub)') AS Sub(Val)
    CROSS APPLY 
    sys.fn_ft_wordbreaker(@lcid, @diacritics_sensitive, Sub.Val.value('.', 'nvarchar(513)')) AS WordBrokenPhrase

    -- Update state table corresponding to phrase table
    --
    EXEC sys.sp_fulltext_thesaurus_update @lcid

    -- We need to bump up the version of the thesaurus for this lcid --
    -- This will cause a recompile on any query using an older thesaurus version -- 
    DBCC CALLFULLTEXT(23, 1, @lcid)

    COMMIT TRAN

    RETURN 0

    END TRY
    BEGIN CATCH
       IF (XACT_STATE() <> 0)
       BEGIN
          ROLLBACK TRAN
       END
       
       DECLARE @errorNumber int
       EXEC @errorNumber=sys.sp_fulltext_rethrow_error
       RETURN @errorNumber
    END CATCH
END


GO
/****** Object:  StoredProcedure [dbo].[sp_GetMetaData]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[sp_GetMetaData] @SourceGuid nvarchar(50)
 AS
 select AttributeName, AttributeValue 
 from SourceAttribute
 where [SourceGuid] = @SourceGuid
 order by [AttributeName]


GO
/****** Object:  StoredProcedure [dbo].[sp_GetRepoCount]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_GetRepoCount]
as
select count(*) + 5288113 as NumberOfEmail from email
select count(*) + 8117443 as NumberOfDocument from datasource
select count(*) + 16117443 as NbrEmailAttachment  from EmailAttachment


GO
/****** Object:  StoredProcedure [dbo].[sp_InsertGenerator]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[sp_InsertGenerator]
(@tableName varchar(100)) as
--Declare a cursor to retrieve column specific information 
--for the specified table
DECLARE cursCol CURSOR FAST_FORWARD FOR 
SELECT column_name,data_type FROM information_schema.columns 
    WHERE table_name = @tableName
OPEN cursCol
DECLARE @string nvarchar(3000) --for storing the first half 
                               --of INSERT statement
DECLARE @stringData nvarchar(3000) --for storing the data 
                                   --(VALUES) related statement
DECLARE @dataType nvarchar(1000) --data types returned 
                                 --for respective columns
SET @string='INSERT '+@tableName+'('
SET @stringData=''

DECLARE @colName nvarchar(50)

FETCH NEXT FROM cursCol INTO @colName,@dataType

IF @@fetch_status<>0
    begin
    print 'Table '+@tableName+' not found, processing skipped.'
    close curscol
    deallocate curscol
    return
END

WHILE @@FETCH_STATUS=0
BEGIN
IF @dataType in ('varchar','char','nchar','nvarchar')
BEGIN
    SET @stringData=@stringData+'''''''''+
            isnull('+@colName+','''')+'''''',''+'
END
ELSE
if @dataType in ('text','ntext') --if the datatype 
                                 --is text or something else 
BEGIN
    SET @stringData=@stringData+'''''''''+
          isnull(cast('+@colName+' as varchar(2000)),'''')+'''''',''+'
END
ELSE
IF @dataType = 'money' --because money doesn't get converted 
                       --from varchar implicitly
BEGIN
    SET @stringData=@stringData+'''convert(money,''''''+
        isnull(cast('+@colName+' as varchar(200)),''0.0000'')+''''''),''+'
END
ELSE 
IF @dataType='datetime'
BEGIN
    SET @stringData=@stringData+'''convert(datetime,''''''+
        isnull(cast('+@colName+' as varchar(200)),''0'')+''''''),''+'
END
ELSE 
IF @dataType='image' 
BEGIN
    SET @stringData=@stringData+'''''''''+
       isnull(cast(convert(varbinary,'+@colName+') 
       as varchar(6)),''0'')+'''''',''+'
END
ELSE --presuming the data type is int,bit,numeric,decimal 
BEGIN
    SET @stringData=@stringData+'''''''''+
          isnull(cast('+@colName+' as varchar(200)),''0'')+'''''',''+'
END

SET @string=@string+@colName+','

FETCH NEXT FROM cursCol INTO @colName,@dataType
END
DECLARE @Query nvarchar(4000) -- provide for the whole query, 
                              -- you may increase the size

SET @query ='SELECT '''+substring(@string,0,len(@string)) + ') 
    VALUES(''+ ' + substring(@stringData,0,len(@stringData)-2)+'''+'')'' 
    FROM '+@tableName
exec sp_executesql @query --load and run the built query 
CLOSE cursCol
DEALLOCATE cursCol

GO
/****** Object:  StoredProcedure [dbo].[sp_ListAllStoredProcedures]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_ListAllStoredProcedures]
as
DECLARE @procName VARCHAR(100)
 DECLARE @getprocName CURSOR
 SET @getprocName = CURSOR FOR
 SELECT Name = '[' + SCHEMA_NAME(SCHEMA_ID) + '].[' + Name + ']'
 FROM sys.all_objects WHERE TYPE = 'P' AND is_ms_shipped = 1
 OPEN @getprocName
 FETCH NEXT
 FROM @getprocName INTO @procName
 WHILE @@FETCH_STATUS = 0
 BEGIN
 PRINT 'sp_HelpText ' + @procName
 EXEC sp_HelpText @procName
 FETCH NEXT FROM @getprocName INTO @procName
 END
 CLOSE @getprocName
 DEALLOCATE @getprocName


GO
/****** Object:  StoredProcedure [dbo].[SP_PrimeNumbers]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SP_PrimeNumbers]
as
DECLARE
    @i INT,
    @a INT,
    @count INT

SET @i = 1
WHILE (@i <= 500)
    BEGIN
        SET @count = 0

        SET @a = 1

        WHILE (@a <= @i)
            BEGIN
                IF (@i % @a = 0) 
                    SET @count = @count + 1

                SET @a = @a + 1
            END

        IF (@count = 2) 
            PRINT @i

        SET @i = @i + 1
    END 

GO
/****** Object:  StoredProcedure [dbo].[sp_Remove_Expired_Content]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_Remove_Expired_Content]
as
delete from SourceAttribute where SourceGuid in 
(select sourceguid from DataSource where RetentionExpirationDate <= GETDATE())

delete from SourceAttribute where SourceGuid in 
(select sourceguid from DataSource where RetentionExpirationDate <= GETDATE())

delete from DataSource where RetentionExpirationDate <= GETDATE()

delete from EmailAttachment where EmailGuid in 
(select EmailGuid from Email where RetentionExpirationDate <= GETDATE())


GO
/****** Object:  StoredProcedure [dbo].[SP_SDA_LibraryItemsInsert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select top 1000 * from LibraryItems

CREATE PROCEDURE [dbo].[SP_SDA_LibraryItemsInsert]
(
	@SourceGuid nvarchar(50),
	@ItemTitle nvarchar(254),
	@ItemType nvarchar(50),
	@LibraryItemGuid nvarchar(50),
	@DataSourceOwnerUserID nvarchar(50),
	@LibraryOwnerUserID nvarchar(50),
	@LibraryName nvarchar(80),
	@AddedByUserGuidId nvarchar(50)
)
AS

IF EXISTS(SELECT 1 FROM LibraryItems WHERE SourceGuid = @SourceGuid AND LibraryName = @LibraryName)
BEGIN
	RETURN 0
END


INSERT INTO [LibraryItems]
( [SourceGuid], [ItemTitle], [ItemType], [LibraryItemGuid], [DataSourceOwnerUserID], [LibraryOwnerUserID], [LibraryName], [AddedByUserGuidId]
)
VALUES
( @SourceGuid, @ItemTitle, @ItemType, @LibraryItemGuid, @DataSourceOwnerUserID, @LibraryOwnerUserID, @LibraryName, @AddedByUserGuidId
)

RETURN 1


GO
/****** Object:  StoredProcedure [dbo].[sp_VerifyRetentionDates]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[sp_VerifyRetentionDates]
as
begin
update DataSource set 
RetentionExpirationDate = getdate() + (select retentionYears from Retention where RetentionCode = DataSource.RetentionCode) * 365.255
where RetentionExpirationDate < GETDATE() - 25 * 365.55;

update email set
RetentionExpirationDate = getdate() + (select retentionYears from Retention where RetentionCode = email.RetentionCode) * 365.255
where RetentionExpirationDate < GETDATE() - 25 * 365.55;

update EmailAttachment set 
RetentionExpirationDate = getdate() + (select retentionYears from Retention where RetentionCode = EmailAttachment.RetentionCode) * 365.255
where RetentionExpirationDate < GETDATE() - 25 * 365.55;
end


GO
/****** Object:  StoredProcedure [dbo].[spCalcEmailAttachmentSpace]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Stored Procedure

CREATE procedure [dbo].[spCalcEmailAttachmentSpace]
as
update EmailAttachment 
set RecLen = 
 len (EmailGuid)   
      + DATALENGTH ( Attachment )
      + len ( ISNULL ( AttachmentName, 0 ) )
      + len ( ISNULL ( EmailGuid, 0 ) )
      + len ( ISNULL ( AttachmentCode, 0 ) )
      + len ( ISNULL ( RowID, 0 ) )
      + len ( ISNULL ( AttachmentType, 0 ) )
      + len ( ISNULL ( UserID, 0 ) )
      + len ( ISNULL ( isZipFileEntry, 0 ) )
      + len ( ISNULL ( OcrText, 0 ) )
      + len ( ISNULL ( isPublic, 0 ) )
      + len ( ISNULL ( AttachmentLength, 0 ) )
      + len ( ISNULL ( OriginalFileTypeCode, 0 ) )
      + len ( ISNULL ( HiveConnectionName, 0 ) )
      + len ( ISNULL ( HiveActive, 0 ) )
      + len ( ISNULL ( RepoSvrName, 0 ) )
      + len ( ISNULL ( RowCreationDate, 0 ) )
      + len ( ISNULL ( RowLastModDate, 0 ) )
Where RecLen is null


GO
/****** Object:  StoredProcedure [dbo].[spContentContainervalidate]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spContentContainervalidate]
as
INSERT INTO ContentContainer (ContentUserRowGuid, ContainerGuid)
SELECT   distinct   ContentUser.ContentUserRowGuid, Container.ContainerGuid
FROM         Container INNER JOIN
                      DataSource ON Container.ContainerName = DataSource.FileDirectory INNER JOIN
                      ContentUser ON DataSource.SourceGuid = ContentUser.ContentGuid
where   ContentUserRowGuid not in (select   ContentUserRowGuid from ContentContainer)  

GO
/****** Object:  StoredProcedure [dbo].[spEXECsp_RECOMPILE]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--exec spEXECsp_RECOMPILE
CREATE PROCEDURE [dbo].[spEXECsp_RECOMPILE] AS 
/*
----------------------------------------------------------------------------
-- Object Name: dbo.spEXECsp_RECOMPILE 
-- Project: SQL Server 2005/2008Database Maintenance
-- Purpose: Execute sp_recompile for all tables in a database
-- Detailed Description: Execute sp_recompile for all tables in a database
-- Database: Admin
-- Dependent Objects: None
-- Called By: TBD
-- Upstream Systems: None
-- Downstream Systems: None
-- W. Dale Miller
*/ 

SET NOCOUNT ON 

-- 1a - Declaration statements for all variables
DECLARE @TableName varchar(128)
DECLARE @OwnerName varchar(128)
DECLARE @CMD1 varchar(8000)
DECLARE @TableListLoop int
DECLARE @TableListTable table
(UIDTableList int IDENTITY (1,1),
OwnerName varchar(128),
TableName varchar(128))

-- 2a - Outer loop for populating the database names
INSERT INTO @TableListTable(OwnerName, TableName)
SELECT u.[Name], o.[Name]
FROM dbo.sysobjects o
	INNER JOIN dbo.sysusers u
	ON o.uid = u.uid
	WHERE o.Type = 'U'
	ORDER BY o.[Name]

-- 2b - Determine the highest UIDDatabaseList to loop through the records
SELECT @TableListLoop = MAX(UIDTableList) FROM @TableListTable

-- 2c - While condition for looping through the database records
WHILE @TableListLoop > 0
BEGIN

	-- 2d - Set the @DatabaseName parameter
	SELECT @TableName = TableName,
	@OwnerName = OwnerName
	FROM @TableListTable
	WHERE UIDTableList = @TableListLoop

	-- 3f - String together the final backup command
	SELECT @CMD1 = 'EXEC sp_recompile ' + '[' + @OwnerName + '.' + @TableName + ']' + char(13)

	-- 3g - Execute the final string to complete the backups
	-- SELECT @CMD1
	EXEC (@CMD1)

	-- 2h - Descend through the database list
	SELECT @TableListLoop = @TableListLoop - 1

END

SET NOCOUNT OFF


GO
/****** Object:  StoredProcedure [dbo].[spGetAllDBStats2]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[spGetAllDBStats2]
AS
BEGIN
   ----------------------------------------------------------------
   -- Purpose:
   --    This SP Returns Data and Log File Sizes For all Databases,
   --    Along With Percent Capacity Used.
   --    Uses a Bunch of Dynamic SQL and DBCC Calls.
   -- 
   --  LIMITATIONS: For Databases With Multiple FILEGROUPS,
   --               it will only list information on one (the last)
   --               FILEGROUP!
   --
   -- Database:  (All)
   --
   -- History:
   --  
   --   Who       When      What
   --   ---       --------  ----------------------------------
   --   WDM       6.8.04    Created SP  
   ----------------------------------------------------------------

   DECLARE @buf     VARCHAR(512)
   DECLARE @db_name VARCHAR(80)

   SET NOCOUNT ON

   -- Create Two Temporary Tables
   CREATE TABLE #T
   (
      _DBName           VARCHAR(80) NOT NULL,

      _LogSizeMB        FLOAT           NULL,
      _LogSpaceUsedPct  FLOAT           NULL,          
      _LogFileName      VARCHAR(255)    NULL,
      _LogTotalExtents  INT             NULL,
      _LogUsedExtents   INT             NULL,

      _DataSizeMB       FLOAT           NULL,
      _DataFileName     VARCHAR(255)    NULL,
      _DataTotalExtents INT             NULL,
      _DataUsedExtents  INT             NULL,
      _DataSpaceUsedPct FLOAT           NULL, 

      _Status           INT             NULL
   )

   CREATE TABLE #T2
   (_Fileid INT, _FileGroup INT, _TotalExtents INT, _UsedExtents INT, _Name VARCHAR(255), _FileName VARCHAR(255))

   -- PHASE I -- Run DBCC SQLPERF(Logspace)
   INSERT INTO #T(_DBName, _LogSizeMB, _LogSpaceUsedPct, _Status)
      EXEC('DBCC SQLPERF(LOGSPACE)')

   -- PHASE II -- 
   -- Create cursor for cycling through databases
   DECLARE MyCursor CURSOR FOR
      SELECT _DBName FROM #T

   -- Execute the cursor
   OPEN MyCursor
   FETCH NEXT FROM MyCursor INTO @db_name 

   -- Do Until All Databases Exhausted...
   WHILE (@@fetch_status <> -1)
   BEGIN
      -- Query To Get Log File and Size Info
      SELECT @buf = "UPDATE #T"
                  + " SET _LogFileName = X.[filename], _LogTotalExtents = X.[size]"            
                  + " FROM #T,"
                  + " (SELECT '" + @db_name + "' AS 'DBName'," 
                  + " fileid, [filename], [size] FROM "
                  + @db_name + ".dbo.sysfiles WHERE (status & 0x40 <> 0)) X"
                  + " WHERE X.DBName = #T._DBName"
      --PRINT @buf
      EXEC(@buf)

      -- "DBCC showfilestats" Query To Get Data File and Size Info
      DELETE FROM #T2
      SELECT @buf = 'INSERT INTO #T2'
                  + '(_Fileid, _FileGroup, _TotalExtents, _UsedExtents, _Name, _FileName)'
                  + " EXEC ('USE " + @db_name + "; DBCC showfilestats')"
      -- PRINT @buf
      EXEC(@buf)

      -- Update the Data Info., and Calculate the Remaining Entities
      UPDATE #T 
      SET _DataFileName     = #T2._FileName, 
          _DataTotalExtents = #T2._TotalExtents, 
          _DataUsedExtents  = #T2._UsedExtents,
          _LogUsedExtents   = CONVERT(INT, (_LogSpaceUsedPct * _LogTotalExtents / 100.0)),
          _DataSpaceUsedPct = 100.0 * CONVERT(FLOAT, #T2._UsedExtents) / CONVERT(FLOAT, #T2._TotalExtents),
          _DataSizeMB       = CONVERT(FLOAT, #T2._TotalExtents) / 16.0
      FROM #T, #T2
      WHERE _DBName = @db_name
             
      -- Go to Next Cursor Row
      FETCH NEXT FROM MyCursor INTO @db_name 
   END

   -- Close Cursor
   CLOSE      MyCursor
   DEALLOCATE MyCursor

   -- Return Results to User
   SELECT 
      _DBName                                                             ,

      _LogFileName                                                        , 
      _LogSizeMB                                                          ,
      _LogTotalExtents                                                    ,
      _LogUsedExtents                                                     ,
      CONVERT(DECIMAL(6, 2), _LogSpaceUsedPct)  AS '_PercentLogSpaceUsed' ,            

      _DataFileName                                                       ,
      _DataSizeMB                                                         ,
      _DataTotalExtents                                                   ,
      _DataUsedExtents                                                    ,
      CONVERT(DECIMAL(6, 2), _DataSpaceUsedPct) AS '_PercentDataSpaceUsed'  
       
   FROM #T 
   ORDER BY _DBName

   -- Clean Up
   DROP TABLE #T
   DROP TABLE #T2
END


GO
/****** Object:  StoredProcedure [dbo].[spGetAllTableSizes]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create PROCEDURE [dbo].[spGetAllTableSizes]
AS
/*
    Obtains spaced used data for ALL user tables in the database
*/
DECLARE @TableName VARCHAR(100)    --For storing values in the cursor

--Cursor to get the name of all user tables from the sysobjects listing
DECLARE tableCursor CURSOR
FOR 
select [name]
from dbo.sysobjects 
where  OBJECTPROPERTY(id, N'IsUserTable') = 1
FOR READ ONLY

--A procedure level temp table to store the results
CREATE TABLE #TempTable
(
    tableName varchar(100),
    numberofRows varchar(100),
    reservedSize varchar(50),
    dataSize varchar(50),
    indexSize varchar(50),
    unusedSize varchar(50)
)

--Open the cursor
OPEN tableCursor

--Get the first table name from the cursor
FETCH NEXT FROM tableCursor INTO @TableName

--Loop until the cursor was not able to fetch
WHILE (@@Fetch_Status >= 0)
BEGIN
    --Dump the results of the sp_spaceused query to the temp table
    INSERT  #TempTable
        EXEC sp_spaceused @TableName

    --Get the next table name
    FETCH NEXT FROM tableCursor INTO @TableName
END

--Get rid of the cursor
CLOSE tableCursor
DEALLOCATE tableCursor

--Select all records so we can use the reults
SELECT * 
FROM #TempTable

--Final cleanup!
DROP TABLE #TempTable


GO
/****** Object:  StoredProcedure [dbo].[spIndexUsage]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/**
*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
IndexUsage
By W. Dale Miller

Reports index stats, index size+rows, member seek + include columns as two comma separated output columns, and index usage 
stats for one or more tables and/or schemas.  Flexible parameterized sorting.
Has all the output of Util_ListIndexes plus the usage stats.

Required Input Parameters
	none

Optional
	@SchemaName sysname=''		Filters schemas.  Can use LIKE wildcards.  All schemas if blank.  Accepts LIKE 

Wildcards.
	@TableName sysname=''		Filters tables.  Can use LIKE wildcards.  All tables if blank.  Accepts LIKE 

Wildcards.
	@Sort Tinyint=5				Determines what to sort the results by:
									Value	Sort Columns
									1		Score DESC, user_seeks DESC, 

user_scans DESC
									2		Score ASC, user_seeks ASC, 

user_scans ASC
									3		SchemaName ASC, TableName ASC, 

IndexName ASC
									4		SchemaName ASC, TableName ASC, 

Score DESC
									5		SchemaName ASC, TableName ASC, 

Score ASC
	@Delimiter VarChar(1)=','	Delimiter for the horizontal delimited seek and include column listings.

Usage:
	EXECUTE Util_IndexUsage 'dbo', 'order%', 5, '|'

Copyright:
	Licensed under the L-GPL - a weak copyleft license - you are permitted to use this as a component of a proprietary 

database and call this from proprietary software.
	Copyleft lets you do anything you want except plagarize, conceal the source, proprietarize modifications, or 

prohibit copying & re-distribution of this script/proc.

	This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser General Public License for more details.

    see <http://www.fsf.org/licensing/licenses/lgpl.html> for the license text.

*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=
**/

CREATE PROCEDURE [dbo].[spIndexUsage]
	@SchemaName SysName='',
	@TableName SysName='',
	@Sort tinyint=5,
	@Delimiter VarChar(1)=','
AS

SELECT
	sys.schemas.schema_id, sys.schemas.name AS schema_name,
	sys.objects.object_id, sys.objects.name AS object_name,
	sys.indexes.index_id, ISNULL(sys.indexes.name, '---') AS index_name,
	partitions.Rows, partitions.SizeMB, IndexProperty(sys.objects.object_id,
	sys.indexes.name, 'IndexDepth') AS IndexDepth,
	sys.indexes.type, sys.indexes.type_desc, sys.indexes.fill_factor,
	sys.indexes.is_unique, sys.indexes.is_primary_key, sys.indexes.is_unique_constraint,
	ISNULL(Index_Columns.index_columns_key, '---') AS index_columns_key,
	ISNULL(Index_Columns.index_columns_include, '---') AS index_columns_include,
	ISNULL(sys.dm_db_index_usage_stats.user_seeks,0) AS user_seeks,
	ISNULL(sys.dm_db_index_usage_stats.user_scans,0) AS user_scans,
	ISNULL(sys.dm_db_index_usage_stats.user_lookups,0) AS user_lookups,
	ISNULL(sys.dm_db_index_usage_stats.user_updates,0) AS user_updates,
	sys.dm_db_index_usage_stats.last_user_seek, sys.dm_db_index_usage_stats.last_user_scan,
	sys.dm_db_index_usage_stats.last_user_lookup, sys.dm_db_index_usage_stats.last_user_update,
	ISNULL(sys.dm_db_index_usage_stats.system_seeks,0) AS system_seeks,
	ISNULL(sys.dm_db_index_usage_stats.system_scans,0) AS system_scans,
	ISNULL(sys.dm_db_index_usage_stats.system_lookups,0) AS system_lookups,
	ISNULL(sys.dm_db_index_usage_stats.system_updates,0) AS system_updates,
	sys.dm_db_index_usage_stats.last_system_seek, sys.dm_db_index_usage_stats.last_system_scan,
	sys.dm_db_index_usage_stats.last_system_lookup, sys.dm_db_index_usage_stats.last_system_update,
	(
		(
			(CONVERT(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.user_seeks,0))+CONVERT(Numeric(19,6), 

ISNULL(sys.dm_db_index_usage_stats.system_seeks,0)))*10
			+ CASE WHEN sys.indexes.type=2 THEN (CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.user_scans,0))+CONVERT(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.system_scans,0)))*1 

ELSE 0 END
			+ 1
		)
		/CASE WHEN sys.indexes.type=2 THEN (CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.user_updates,0))+CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.system_updates,0))+1) ELSE 1 END
	) AS Score
FROM
	sys.objects
	JOIN sys.schemas ON sys.objects.schema_id=sys.schemas.schema_id
	JOIN sys.indexes ON sys.indexes.object_id=sys.objects.object_id
	JOIN (
		SELECT
			object_id, index_id, SUM(row_count) AS Rows,
			CONVERT(numeric(19,3), CONVERT(numeric(19,3), SUM(in_row_reserved_page_count

+lob_reserved_page_count+row_overflow_reserved_page_count))/CONVERT(numeric(19,3), 128)) AS SizeMB
		FROM sys.dm_db_partition_stats
		GROUP BY object_id, index_id
	) AS partitions ON sys.indexes.object_id=partitions.object_id AND sys.indexes.index_id=partitions.index_id
	CROSS APPLY (
		SELECT
			LEFT(index_columns_key, LEN(index_columns_key)-1) AS index_columns_key,
			LEFT(index_columns_include, LEN(index_columns_include)-1) AS index_columns_include
		FROM
			(
				SELECT
					(
						SELECT sys.columns.name + @Delimiter + ' '
						FROM
							sys.index_columns
							JOIN sys.columns ON
								sys.index_columns.column_id=sys.columns.column_id
								AND sys.index_columns.object_id=sys.columns.object_id
						WHERE
							sys.index_columns.is_included_column=0
							AND sys.indexes.object_id=sys.index_columns.object_id
							AND sys.indexes.index_id=sys.index_columns.index_id
						ORDER BY key_ordinal
						FOR XML PATH('')
					) AS index_columns_key,
					(
						SELECT sys.columns.name + @Delimiter + ' '
						FROM
							sys.index_columns
							JOIN sys.columns ON
								sys.index_columns.column_id=sys.columns.column_id
								AND sys.index_columns.object_id=sys.columns.object_id
						WHERE
							sys.index_columns.is_included_column=1
							AND sys.indexes.object_id=sys.index_columns.object_id
							AND sys.indexes.index_id=sys.index_columns.index_id
						ORDER BY index_column_id
						FOR XML PATH('')
					) AS index_columns_include
			) AS Index_Columns
	) AS Index_Columns
	LEFT OUTER JOIN sys.dm_db_index_usage_stats ON
		sys.indexes.index_id=sys.dm_db_index_usage_stats.index_id
		AND sys.indexes.object_id=sys.dm_db_index_usage_stats.object_id
		AND sys.dm_db_index_usage_stats.database_id=DB_ID()
WHERE
	sys.objects.type='u'
	AND sys.schemas.name LIKE CASE WHEN @SchemaName='' THEn sys.schemas.name ELSE @SchemaName END
	AND sys.objects.name LIKE CASE WHEN @TableName='' THEn sys.objects.name ELSE @TableName END
ORDER BY
	CASE @Sort
		WHEN 1 THEN
			(
				(
					(CONVERT(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.user_seeks,0))+CONVERT

(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.system_seeks,0)))*10
					+ CASE WHEN sys.indexes.type=2 THEN (CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.user_scans,0))+CONVERT(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.system_scans,0)))*1 

ELSE 0 END
					+ 1
				)
				/CASE WHEN sys.indexes.type=2 THEN (CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.user_updates,0))+CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.system_updates,0))+1) ELSE 1 END
			)*-1
		WHEN 2 THEN
			(
				(
					(CONVERT(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.user_seeks,0))+CONVERT

(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.system_seeks,0)))*10
					+ CASE WHEN sys.indexes.type=2 THEN (CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.user_scans,0))+CONVERT(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.system_scans,0)))*1 

ELSE 0 END
					+ 1
				)
				/CASE WHEN sys.indexes.type=2 THEN (CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.user_updates,0))+CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.system_updates,0))+1) ELSE 1 END
			)
		ELSE NULL
	END,
	CASE @Sort
		WHEN 3 THEN sys.schemas.name
		WHEN 4 THEN sys.schemas.name
		WHEN 5 THEN sys.schemas.name
		ELSE NULL
	END,
	CASE @Sort
		WHEN 1 THEN CONVERT(VarChar(10), sys.dm_db_index_usage_stats.user_seeks*-1)
		WHEN 2 THEN CONVERT(VarChar(10), sys.dm_db_index_usage_stats.user_seeks)
		ELSE NULL
	END,
	CASE @Sort
		WHEN 3 THEN sys.objects.name
		WHEN 4 THEN sys.objects.name
		WHEN 5 THEN sys.objects.name
		ELSE NULL
	END,
	CASE @Sort
		WHEN 1 THEN sys.dm_db_index_usage_stats.user_scans*-1
		WHEN 2 THEN sys.dm_db_index_usage_stats.user_scans
		WHEN 4 THEN
			(
				(
					(CONVERT(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.user_seeks,0))+CONVERT

(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.system_seeks,0)))*10
					+ CASE WHEN sys.indexes.type=2 THEN (CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.user_scans,0))+CONVERT(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.system_scans,0)))*1 

ELSE 0 END
					+ 1
				)
				/CASE WHEN sys.indexes.type=2 THEN (CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.user_updates,0))+CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.system_updates,0))+1) ELSE 1 END
			)*-1
		WHEN 5 THEN
			(
				(
					(CONVERT(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.user_seeks,0))+CONVERT

(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.system_seeks,0)))*10
					+ CASE WHEN sys.indexes.type=2 THEN (CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.user_scans,0))+CONVERT(Numeric(19,6), ISNULL(sys.dm_db_index_usage_stats.system_scans,0)))*1 

ELSE 0 END
					+ 1
				)
				/CASE WHEN sys.indexes.type=2 THEN (CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.user_updates,0))+CONVERT(Numeric(19,6), ISNULL

(sys.dm_db_index_usage_stats.system_updates,0))+1) ELSE 1 END
			)
		ELSE NULL
	END,
	CASE @Sort
		WHEN 3 THEN sys.indexes.name
		ELSE NULL
	END


GO
/****** Object:  StoredProcedure [dbo].[spSaveClickStat]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[spSaveClickStat] @LocationID int , @UID nvarchar(50)
as
begin
	insert into StatsClick (LocationID, UserID) values(@LocationID,@UID)	
end


GO
/****** Object:  StoredProcedure [dbo].[spSaveWordStat]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spSaveWordStat] @Word nvarchar(100) , @UID nvarchar(50), @TypeSearch char(1)
as
begin
	declare @i int
	if not exists(select WordID from StatWord where Word = @word)
	Begin
		insert into StatWord (word) values(@word)
	END
	set @i = (select WordID from StatWord where Word = @word)
	Insert into StatSearch (WordID, UserID, TypeSearch) values (@i,@UID, @TypeSearch)
end


GO
/****** Object:  StoredProcedure [dbo].[spTest]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[spTest] 
AS 
BEGIN
        DECLARE @counter int = 0;  
        WHILE (@counter <= 100)
        BEGIN
            SET @counter = @counter + 1; 
            IF @counter % 10 = 0 
            BEGIN 
                PRINT @counter; 
            END 
        END      
END        

GO
/****** Object:  StoredProcedure [dbo].[spUpdateEmailMsg]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*CurrentUser, ReceivedByName As String, ReceivedTime As DateTime, SenderEmailAddress As String, SenderName As String, SentOn As DateTime*/
create PROCEDURE [dbo].[spUpdateEmailMsg]		
		@EmailGuid nvarchar(50),
		@EmailImage image
AS
set nocount on
	Update [Email]	set [EmailImage] = @EmailImage where [EmailGuid] = @EmailGuid

RETURN

/****** Object:  StoredProcedure [dbo].[EditAlbum]    Script Date: 03/18/2007 17:30:39 ******/
SET ANSI_NULLS ON


GO
/****** Object:  StoredProcedure [dbo].[spUpdateTicketIimage]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  create PROCEDURE [dbo].[spUpdateTicketIimage]		
		@TicketNumber nvarchar(50),
		@EventID nvarchar(50),		
		@TicketImage image
AS
set nocount on
	Update [Tickets] set [TicketImage] = @TicketImage where [TicketNumber] = @TicketNumber and EventID = @EventID

RETURN

GO
/****** Object:  StoredProcedure [dbo].[spUpdateTicketImage]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
create PROCEDURE [dbo].[spUpdateTicketImage]		
		@TicketNumber nvarchar(50),
		@EventID nvarchar(50),		
		@TicketImage image
AS
set nocount on
	Update [Tickets] set [TicketImage] = @TicketImage where [TicketNumber] = @TicketNumber and EventID = @EventID

RETURN

GO
/****** Object:  StoredProcedure [dbo].[StatusSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/* 
 * PROCEDURE: StatusSelProc 
 */

CREATE PROCEDURE [dbo].[StatusSelProc]
(
    @StatusCode     nvarchar(50))
AS
BEGIN
    SELECT StatusCode,
           CodeDesc
      FROM Status
     WHERE StatusCode = @StatusCode

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[StorageSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: StorageSelProc 
 */

CREATE PROCEDURE [dbo].[StorageSelProc]
(
    @StoreCode      nvarchar(50))
AS
BEGIN
    SELECT StoreCode,
           StoreDesc,
           CreateDate
      FROM Storage
     WHERE StoreCode = @StoreCode

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[SubDirSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SubDirSelProc]
(
    @UserID           nvarchar(50),
    @SUBFQN           nvarchar(254),
    @FQN              varchar(254))
AS
BEGIN
    SELECT UserID,
           SUBFQN,
           FQN,
           ckPublic,
           ckDisableDir
      FROM SubDir
     WHERE UserID = @UserID
       AND SUBFQN = @SUBFQN
       AND FQN    = @FQN

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[SubLibrarySelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SubLibrarySelProc]
(
    @UserID             nvarchar(50),
    @SubUserID          nvarchar(50),
    @LibraryName        nvarchar(80),
    @SubLibraryName     nvarchar(80))
AS
BEGIN
    SELECT UserID,
           SubUserID,
           LibraryName,
           SubLibraryName
      FROM SubLibrary
     WHERE UserID         = @UserID
       AND SubUserID      = @SubUserID
       AND LibraryName    = @LibraryName
       AND SubLibraryName = @SubLibraryName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[UD_QtySelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: UD_QtySelProc 
 */

CREATE PROCEDURE [dbo].[UD_QtySelProc]
(
    @Code            char(10))
AS
BEGIN
    SELECT Code,
           Description
      FROM UD_Qty
     WHERE Code = @Code

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[UpdateDataSourceImage]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateDataSourceImage]		
		@SourceGuid nvarchar(50),		 
		@SourceImage image,						 
		@LastAccessDate datetime, 		 
		@LastWriteTime datetime,		
        @VersionNbr int
AS

set nocount on
	update [DataSource] 		
		set SourceImage = @SourceImage,						 
		LastAccessDate = @LastAccessDate,		
		LastWriteTime = @LastWriteTime, 
	    VersionNbr = @VersionNbr
where SourceGuid = @SourceGuid

RETURN


GO
/****** Object:  StoredProcedure [dbo].[UpdateEmailAttachmentFilestream]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[UpdateEmailAttachmentFilestream]		
		@EmailGuid nvarchar(50),
		@Attachment varbinary(max),
		@AttachmentName nvarchar(254)
AS
set nocount on
	Update [EmailAttachment] 
		set Attachment = @Attachment 
		Where EmailGuid = @EmailGuid
		and AttachmentName = @AttachmentName
		
RETURN

/****** Object:  StoredProcedure [dbo].[EditAlbum]    Script Date: 03/18/2007 17:30:39 ******/
SET ANSI_NULLS ON


GO
/****** Object:  StoredProcedure [dbo].[UpdateEmailAttachmentFilestreamV2]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[UpdateEmailAttachmentFilestreamV2]		
		@RowGuid nvarchar(50),
		@Attachment varbinary(max)		
AS
set nocount on
	Update [EmailAttachment] 
		set Attachment = @Attachment 
		Where RowGuid = @RowGuid
		
RETURN

/****** Object:  StoredProcedure [dbo].[EditAlbum]    Script Date: 03/18/2007 17:30:39 ******/
SET ANSI_NULLS ON




GO
/****** Object:  StoredProcedure [dbo].[UpdateEmailFilestream]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[UpdateEmailFilestream]		
		@EmailGuid nvarchar(50),
		@EmailImage varbinary(max)
AS
set nocount on
	Update [EMail] 
		set EmailImage = @EmailImage 
		Where EmailGuid = @EmailGuid
		
RETURN

/****** Object:  StoredProcedure [dbo].[EditAlbum]    Script Date: 03/18/2007 17:30:39 ******/
SET ANSI_NULLS ON


GO
/****** Object:  StoredProcedure [dbo].[UpdateSourceFilestream]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[UpdateSourceFilestream]		
		@SourceGuid nvarchar(50),
		@SourceImage varbinary(max)
AS
set nocount on
	Update [DataSource] 
		set SourceImage = @SourceImage 
		Where SourceGuid = @SourceGuid
		
RETURN

/****** Object:  StoredProcedure [dbo].[EditAlbum]    Script Date: 03/18/2007 17:30:39 ******/
SET ANSI_NULLS ON


GO
/****** Object:  StoredProcedure [dbo].[UserGroupSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[UserGroupSelProc]
(
    @GroupOwnerUserID     nvarchar(50),
    @GroupName            nvarchar(80))
AS
BEGIN
    SELECT GroupOwnerUserID,
           GroupName
      FROM UserGroup
     WHERE GroupOwnerUserID = @GroupOwnerUserID
       AND GroupName        = @GroupName

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[UsersSelPr_01282009011743004]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: UsersSelProc 
 */

CREATE PROCEDURE [dbo].[UsersSelPr_01282009011743004]
(
    @UserID           nvarchar(50))
AS
BEGIN
    SELECT UserID,
           UserPassword
      FROM Users
     WHERE UserID = @UserID

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[UsersSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: UsersSelProc 
 */

CREATE PROCEDURE [dbo].[UsersSelProc]
(
    @UserID           nvarchar(50))
AS
BEGIN
    SELECT UserID,
           UserPassword
      FROM Users
     WHERE UserID = @UserID

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[usp_FindYourMissingTable]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[usp_FindYourMissingTable]
    @TableName VARCHAR(256)
AS

DECLARE @DBName VARCHAR(256)
DECLARE @varSQL VARCHAR(512)
DECLARE @getDBName CURSOR
SET @getDBName = CURSOR FOR
    SELECT name
    FROM sys.databases
    CREATE TABLE #TmpTable (DBName VARCHAR(256),
    SchemaName VARCHAR(256),
    TableName VARCHAR(256))
    OPEN @getDBName
FETCH NEXT
FROM @getDBName INTO @DBName
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @varSQL = 'USE ' + @DBName + ';
    INSERT INTO #TmpTable
    SELECT '''+ @DBName + ''' AS DBName,
    SCHEMA_NAME(schema_id) AS SchemaName,
    name AS TableName
    FROM sys.tables
    WHERE name LIKE ''%' + @TableName + '%'''
    EXEC (@varSQL)
    FETCH NEXT
    FROM @getDBName INTO @DBName
END
CLOSE @getDBName
DEALLOCATE @getDBName
SELECT * FROM #TmpTable
DROP TABLE #TmpTable


GO
/****** Object:  StoredProcedure [dbo].[VolitilitySelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/* 
 * PROCEDURE: VolitilitySelProc 
 */

CREATE PROCEDURE [dbo].[VolitilitySelProc]
(
    @VolitilityCode     nvarchar(50))
AS
BEGIN
    SELECT VolitilityCode,
           VolitilityDesc,
           CreateDate
      FROM Volitility
     WHERE VolitilityCode = @VolitilityCode

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[WebSourceSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[WebSourceSelProc]
(
    @SourceGuid                  nvarchar(50))
AS
BEGIN
    SELECT SourceGuid,
           CreateDate,
           SourceName,
           SourceImage,
           SourceTypeCode,
           FileLength,
           LastWriteTime,
           RetentionExpirationDate,
           Description,
           KeyWords,
           Notes,
           CreationDate
      FROM WebSource
     WHERE SourceGuid = @SourceGuid

    RETURN(0)
END


GO
/****** Object:  StoredProcedure [dbo].[ZippedFilesSelProc]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[ZippedFilesSelProc]
(
    @ContentGUID               nvarchar(50))
AS
BEGIN
    SELECT ContentGUID,
           SourceTypeCode,
           SourceImage,
           SourceGuid,
           DataSourceOwnerUserID
      FROM ZippedFiles
     WHERE ContentGUID = @ContentGUID

    RETURN(0)
END


GO
/****** Object:  UserDefinedFunction [dbo].[BinToBase64]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create function [dbo].[BinToBase64](@Bin varbinary(max)) returns varchar(max) 
as begin   
	return CAST(N'' AS XML).value('xs:base64Binary(xs:hexBinary(sql:variable("@Bin")))', 'VARCHAR(MAX)') 
end


GO
/****** Object:  UserDefinedFunction [dbo].[CalcRetentionDate]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[CalcRetentionDate] (@SourceGuid nvarchar(50), @RetentionCode nvarchar(50), @StartDate datetime)
returns datetime
AS
begin
	Declare @RetentionPeriod nvarchar(50), @RetentionUnits int, @CalcDate datetime

	set @RetentionPeriod = (Select RetentionPeriod from Retention where Retention.RetentionCode = @RetentionCode) 
	set @RetentionUnits = (Select RetentionUnits from Retention where Retention.RetentionCode = @RetentionCode) 

	if @RetentionPeriod is null Begin
		set @RetentionPeriod = (SELECT MAX(RetentionUnits) from Retention where RetentionPeriod = 'Year')
	END

	if @RetentionPeriod = 'Day' begin
		set @CalcDate = DATEADD(day,@RetentionUnits,getdate()) 		
	END
	if @RetentionPeriod = 'Month' begin
		set @CalcDate = DATEADD(month,@RetentionUnits,getdate()) 		
	END
	if @RetentionPeriod = 'Year' begin
		set @CalcDate = DATEADD(year,@RetentionUnits,getdate()) 		
	END
	return (@CalcDate) ;
END

GO
/****** Object:  UserDefinedFunction [dbo].[IsGuid]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
create function [dbo].[IsGuid] ( @testString varchar(38))
returns int
as
begin
    declare @ret int
    select  @ret = 0,
            @testString = replace(replace(@testString, '{', ''), '}', '')
    if len(isnull(@testString, '')) = 36 and
       @testString NOT LIKE '%[^0-9A-Fa-f-]%' and
       -- check for proper positions of hyphens (-)  
       charindex('-', @testString) = 9 and 
       charindex('-', @testString, 10) = 14 and 
       charindex('-', @testString, 15) = 19 and 
       charindex('-', @testString, 20) = 24 and 
       charindex('-', @testString, 25) = 0
          set @ret = 1
    
    return @ret
end


GO
/****** Object:  UserDefinedFunction [dbo].[sp_ecmGenHashString]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE function [dbo].[sp_ecmGenHashString] (@StringToHash nvarchar)
returns nvarchar(50)
as
begin
	DECLARE @HashVal nvarchar(50)
	DECLARE @hash varbinary(max)
	SELECT @hash = HashBytes('SHA1', @StringToHash)
    set @HashVal = SUBSTRING(master.dbo.fn_varbintohexstr(HashBytes('SHA1', @StringToHash)), 3, 50) 
    set @HashVal = master.dbo.fn_varbintohexsubstring(0,@hash,0,0)
    return @HashVal
end


GO
/****** Object:  UserDefinedFunction [dbo].[sp_genHashString]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE function [dbo].[sp_genHashString] (@StringToHash nvarchar)
returns nvarchar
as
begin
	return SUBSTRING(master.dbo.fn_varbintohexstr(HashBytes('SHA1', @StringToHash)), 3, 50) 
end


GO
/****** Object:  UserDefinedFunction [dbo].[sp_GetContent]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[sp_GetContent](@SourceGuid nvarchar)
RETURNS varbinary(MAX)
AS
BEGIN
DECLARE @Source varbinary(max)
SELECT @Source = SourceImage
FROM DataSource
WHERE SourceGuid = @SourceGuid
RETURN @Source
END


GO
/****** Object:  UserDefinedFunction [dbo].[sp_GetSourceContent]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[sp_GetSourceContent](@SourceGuid nvarchar)
RETURNS varbinary(MAX)
AS
BEGIN
DECLARE @Source varbinary(max)
SELECT @Source = SourceImage
FROM DataSource
WHERE SourceGuid = @SourceGuid
RETURN @Source
END


GO
/****** Object:  UserDefinedFunction [dbo].[spEcmDateConvert]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[spEcmDateConvert]
(
	@Date datetime,
	@fORMAT VARCHAR(80)
)
RETURNS NVARCHAR(80)
AS
BEGIN
	DECLARE @nDateFmt INT
	DECLARE @vcReturnDte VARCHAR(80)
	DECLARE @TwelveHourClock INT
	DECLARE @Before INT
	DECLARE @pos INT
	DECLARE @Escape INT 
-- (c) Dale Miller 2010
SELECT @vcReturnDte='error! unrecognised format '+@format
SELECT @nDateFmt=CASE @format
	WHEN 'mmm dd yyyy hh:mm AM/PM' THEN 100
	WHEN 'mm/dd/yy' THEN 1
	WHEN 'mm/dd/yyyy' THEN 101
	WHEN 'yy.mm.dd' THEN 2
	WHEN 'dd/mm/yy' THEN 3
	WHEN 'dd.mm.yy' THEN 4
	WHEN 'dd-mm-yy' THEN 5
	WHEN 'dd Mmm yy' THEN 6
	WHEN 'Mmm dd, yy' THEN 7
	WHEN 'hh:mm:ss' THEN 8
	WHEN 'yyyy.mm.dd' THEN 102
	WHEN 'dd/mm/yyyy' THEN 103
	WHEN 'dd.mm.yyyy' THEN 104
	WHEN 'dd-mm-yyyy' THEN 105
	WHEN 'dd Mmm yyyy' THEN 106
	WHEN 'Mmm dd, yyyy' THEN 107
	WHEN 'Mmm dd yyyy hh:mm:ss:ms AM/PM' THEN 9
	WHEN 'Mmm dd yyyy hh:mi:ss:mmm AM/PM' THEN 9
	WHEN 'Mmm dd yy hh:mm:ss:ms AM/PM' THEN 109
	WHEN 'mm-dd-yy' THEN 10
	WHEN 'mm-dd-yyyy' THEN 110
	WHEN 'yy/mm/dd' THEN 11
	WHEN 'yyyy/mm/dd' THEN 111
	WHEN 'yymmdd' THEN 12
	WHEN 'yyyymmdd' THEN 112
	WHEN 'dd Mmm yyyy hh:mm:ss:Ms' THEN 113
	WHEN 'hh:mm:ss:Ms' THEN 14
	WHEN 'yyyy-mm-dd hh:mm:ss' THEN 120
	WHEN 'yyyy-mm-dd hh:mm:ss.Ms' THEN 121
	WHEN 'yyyy-mm-ddThh:mm:ss.Ms' THEN 126
	WHEN 'dd Mmm yyyy hh:mm:ss:ms AM/PM' THEN 130
	WHEN 'dd/mm/yy hh:mm:ss:ms AM/PM' THEN 131
	WHEN 'RFC822' THEN 2
	WHEN 'dd Mmm yyyy hh:mm' THEN 4
ELSE 1 END

SELECT @vcReturnDte='error! unrecognised format ' +@format+CONVERT(VARCHAR(10),@nDateFmt)
IF @nDateFmt>=0
	SELECT @vcReturnDte=CONVERT(VARCHAR(80),@Date,@nDateFmt)
	--check for favurite and custom formats that can be done quickly
ELSE IF @nDateFmt=-2--then it is RFC822 format
	SELECT @vcReturnDte=LEFT(DATENAME(dw, @Date),3) + ', ' + STUFF(CONVERT(NVARCHAR,@Date,113),21,4,' GMT')
ELSE IF @nDateFmt=-4--then it is european day format with minutes
	SELECT @vcReturnDte=CONVERT(CHAR(17),@Date,113)
ELSE
BEGIN
	SELECT @Before=LEN(@format)
	SELECT @Format=REPLACE(REPLACE(REPLACE( @Format,'AM/PM','#'),'AM','#'),'PM','#')
	SELECT @TwelveHourClock=CASE WHEN @Before >LEN(@format) THEN 109 ELSE 113 END, @vcReturnDte=''
	WHILE (1=1)--forever
	BEGIN
		SELECT @pos=PATINDEX('%[yqmidwhs:#]%',@format+' ')
		IF @pos=0--no more date format strings
		BEGIN
		SELECT @vcReturnDte=@vcReturnDte+@format
		BREAK
	END
	IF @pos>1--some stuff to pass through first
	BEGIN
		SELECT @escape=CHARINDEX ('\',@Format+'\') --is it a literal character that is escaped?
		IF @escape<@pos BEGIN
		SET @vcReturnDte=@vcReturnDte+SUBSTRING(@Format,1,@escape-1) +SUBSTRING(@format,@escape+1,1)
		SET @format=RTRIM(SUBSTRING(@Format,@Escape+2,80))
		CONTINUE
	END
	SET @vcReturnDte=@vcReturnDte+SUBSTRING(@Format,1,@pos-1)
	SET @format=RTRIM(SUBSTRING(@Format,@pos,80))
	END
	
	SELECT @pos=PATINDEX('%[^yqmidwhs:#]%',@format+' ')--get the end
	SELECT @vcReturnDte=@vcReturnDte+--'('+substring(@Format,1,@pos-1)+')'+

	CASE SUBSTRING(@Format,1,@pos-1)
		--Mmmths as 1--12
		WHEN 'M' THEN CONVERT(VARCHAR(2),DATEPART(MONTH,@Date))
		--Mmmths as 01--12
		WHEN 'Mm' THEN CONVERT(CHAR(2),@Date,101)
		--Mmmths as Jan--Dec
		WHEN 'Mmm' THEN CONVERT(CHAR(3),DATENAME(MONTH,@Date))
		--Mmmths as January--December
		WHEN 'Mmmm' THEN DATENAME(MONTH,@Date)
		--Mmmths as the first letter of the Mmmth
		WHEN 'Mmmmm' THEN CONVERT(CHAR(1),DATENAME(MONTH,@Date))
		--Days as 1--31
		WHEN 'D' THEN CONVERT(VARCHAR(2),DATEPART(DAY,@Date))
		--Days as 01--31
		WHEN 'Dd' THEN CONVERT(CHAR(2),@date,103)
		--Days as Sun--Sat
		WHEN 'Ddd' THEN CONVERT(CHAR(3),DATENAME(weekday,@Date))
		--Days as Sunday--Saturday
		WHEN 'Dddd' THEN DATENAME(weekday,@Date)
		--Years as 00--99
		WHEN 'Yy' THEN CONVERT(CHAR(2),@Date,12)
		--Years as 1900--9999
		WHEN 'Yyyy' THEN DATENAME(YEAR,@Date)
		WHEN 'hh:mm:ss' THEN SUBSTRING(CONVERT(CHAR(30),@date,@TwelveHourClock),13,8)
		WHEN 'hh:mm:ss:ms' THEN SUBSTRING(CONVERT(CHAR(30),@date,@TwelveHourClock),13,12)
		WHEN 'h:mm:ss' THEN SUBSTRING(CONVERT(CHAR(30),@date,@TwelveHourClock),13,8)
		--tthe SQL Server BOL syntax, for compatibility
		WHEN 'hh:mi:ss:mmm' THEN SUBSTRING(CONVERT(CHAR(30),@date,@TwelveHourClock),13,12)
		WHEN 'h:mm:ss:ms' THEN SUBSTRING(CONVERT(CHAR(30),@date,@TwelveHourClock),13,12)
		WHEN 'H:m:s' THEN SUBSTRING(REPLACE(':'+SUBSTRING(CONVERT(CHAR(30), @Date,@TwelveHourClock),13,8),':0',':'),2,30)
		WHEN 'H:m:s:ms' THEN SUBSTRING(REPLACE(':'+SUBSTRING(CONVERT(CHAR(30), @Date,@TwelveHourClock),13,12),':0',':'),2,30)
		--Hours as 00--23
		WHEN 'hh' THEN REPLACE(SUBSTRING(CONVERT(CHAR(30), @Date,@TwelveHourClock),13,2),' ','0')
		--Hours as 0--23
		WHEN 'h' THEN LTRIM(SUBSTRING(CONVERT(CHAR(30), @Date,@TwelveHourClock),13,2))
		--Minutes as 00--59
		WHEN 'Mi' THEN DATENAME(minute,@date)
		WHEN 'mm' THEN DATENAME(minute,@date)
		WHEN 'm' THEN CONVERT(VARCHAR(2),DATEPART(minute,@date))
		--Seconds as 0--59
		WHEN 'ss' THEN DATENAME(second,@date)
		--Seconds as 0--59
		WHEN 'S' THEN CONVERT(VARCHAR(2),DATEPART(second,@date))
		--AM/PM
		WHEN 'ms' THEN DATENAME(millisecond,@date)
		WHEN 'mmm' THEN DATENAME(millisecond,@date)
		WHEN 'dy' THEN DATENAME(dy,@date)
		WHEN 'qq' THEN DATENAME(qq,@date)
		WHEN 'ww' THEN DATENAME(ww,@date)
		WHEN '#' THEN REVERSE(SUBSTRING(REVERSE(CONVERT(CHAR(26), @date,109)),1,2))
	ELSE
		SUBSTRING(@Format,1,@pos-1)
	END
	SET @format=RTRIM(SUBSTRING(@Format,@pos,80))
	END
END
RETURN @vcReturnDte
END


GO
/****** Object:  UserDefinedFunction [dbo].[spGetDateOnly]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[spGetDateOnly] ()
RETURNS DATETIME
BEGIN
	declare  @pInputDate    DATETIME ;
	set @pInputDate = getdate()
    RETURN CAST(CAST(YEAR(@pInputDate) AS VARCHAR(4)) + '/' +
                CAST(MONTH(@pInputDate) AS VARCHAR(2)) + '/' +
                CAST(DAY(@pInputDate) AS VARCHAR(2)) AS DATETIME)

END


GO
/****** Object:  UserDefinedFunction [dbo].[spTBL_RowCOUNT]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[spTBL_RowCOUNT] (
 
         @sTableName sysname  -- Table to retrieve Row Count
         )
 
     RETURNS INT -- Row count of the table, NULL if not found.
 
 /*
 * Returns the row count for a table by examining sysindexes.
 * This function must be run in the same database as the table.
 *
 * Common Usage:   
 SELECT dbo.udf_Tbl_RowCOUNT ('')
 
 * Test   
  PRINT 'Test 1 Bad table ' + CASE WHEN SELECT 
        dbo.udf_Tbl_RowCOUNT ('foobar') is NULL
         THEN 'Worked' ELSE 'Error' END
         
 * © Copyright 2004 W. Dale Miller dm@DmaChicago.com, all rights reserved.
 ***************************************************************/
 
 AS BEGIN
     
     DECLARE @nRowCount INT -- the rows
     DECLARE @nObjectID int -- Object ID
 
     SET @nObjectID = OBJECT_ID(@sTableName)
 
     -- Object might not be found
     IF @nObjectID is null RETURN NULL
 
     SELECT TOP 1 @nRowCount = rows 
         FROM sysindexes 
         WHERE id = @nObjectID AND indid < 2
 
     RETURN @nRowCount
 END


GO
/****** Object:  Table [dbo].[ActiveDirUser]    Script Date: 10/15/2015 7:35:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActiveDirUser](
	[AdUserLoginID] [nvarchar](50) NOT NULL,
	[AdUserName] [nvarchar](80) NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ActiveSearchGuids]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActiveSearchGuids](
	[UserID] [nvarchar](50) NOT NULL,
	[DocGuid] [nvarchar](50) NOT NULL,
	[SeqNO] [int] IDENTITY(1,1) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ActiveSession]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActiveSession](
	[SessionGuid] [uniqueidentifier] NOT NULL,
	[Parm] [nvarchar](50) NOT NULL,
	[InitDate] [datetime] NOT NULL,
	[ParmVal] [nvarchar](2000) NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AlertContact]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlertContact](
	[ContactEmail] [nvarchar](80) NOT NULL,
	[ContactIM] [nvarchar](50) NULL,
	[ContactName] [nvarchar](50) NULL,
	[Carrier] [nvarchar](75) NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AlertHistory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlertHistory](
	[AlertWord] [nvarchar](100) NOT NULL,
	[ByUserID] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AlertWord]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlertWord](
	[AlertWord] [nvarchar](50) NOT NULL,
	[ExpirationDate] [datetime] NOT NULL,
	[CreateDate] [datetime] NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ArchiveFrom]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ArchiveFrom](
	[FromEmailAddr] [nvarchar](254) NOT NULL,
	[SenderName] [varchar](254) NOT NULL,
	[UserID] [varchar](25) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK39] PRIMARY KEY NONCLUSTERED 
(
	[FromEmailAddr] ASC,
	[SenderName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ArchiveHist]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArchiveHist](
	[ArchiveID] [nvarchar](50) NOT NULL,
	[ArchiveDate] [datetime] NULL,
	[NbrFilesArchived] [int] NULL,
	[UserGuid] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK110] PRIMARY KEY CLUSTERED 
(
	[ArchiveID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ArchiveHistContentType]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArchiveHistContentType](
	[ArchiveID] [nvarchar](50) NOT NULL,
	[Directory] [nvarchar](254) NOT NULL,
	[FileType] [nvarchar](50) NOT NULL,
	[NbrFilesArchived] [int] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK111] PRIMARY KEY NONCLUSTERED 
(
	[ArchiveID] ASC,
	[Directory] ASC,
	[FileType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ArchiveStats]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArchiveStats](
	[ArchiveStartDate] [datetime] NULL,
	[Status] [nvarchar](50) NOT NULL,
	[Successful] [nchar](1) NULL,
	[ArchiveType] [nvarchar](50) NOT NULL,
	[TotalEmailsInRepository] [int] NULL,
	[TotalContentInRepository] [int] NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[ArchiveEndDate] [datetime] NULL,
	[StatGuid] [nvarchar](50) NOT NULL,
	[EntrySeq] [int] IDENTITY(1,1) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AssignableUserParameters]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AssignableUserParameters](
	[ParmName] [nchar](50) NOT NULL,
	[isPerm] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AttachmentType]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttachmentType](
	[AttachmentCode] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](254) NULL,
	[isZipFormat] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK29] PRIMARY KEY CLUSTERED 
(
	[AttachmentCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AttributeDatatype]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AttributeDatatype](
	[AttributeDataType] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK109] PRIMARY KEY CLUSTERED 
(
	[AttributeDataType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Attributes]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Attributes](
	[AttributeName] [nvarchar](50) NOT NULL,
	[AttributeDataType] [nvarchar](50) NOT NULL,
	[AttributeDesc] [nvarchar](2000) NULL,
	[AssoApplication] [nvarchar](50) NULL,
	[AllowedValues] [nvarchar](254) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK36] PRIMARY KEY CLUSTERED 
(
	[AttributeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AvailFileTypes]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AvailFileTypes](
	[ExtCode] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PKI7] PRIMARY KEY CLUSTERED 
(
	[ExtCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AvailFileTypesUndefined]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AvailFileTypesUndefined](
	[FileType] [nvarchar](50) NOT NULL,
	[SubstituteType] [nvarchar](50) NULL,
	[Applied] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BusinessFunctionJargon]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BusinessFunctionJargon](
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[WordID] [int] IDENTITY(1,1) NOT NULL,
	[JargonWords_tgtWord] [nvarchar](50) NOT NULL,
	[JargonCode] [nvarchar](50) NOT NULL,
	[CorpName] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK23] PRIMARY KEY NONCLUSTERED 
(
	[CorpFuncName] ASC,
	[WordID] ASC,
	[JargonWords_tgtWord] ASC,
	[JargonCode] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BusinessJargonCode]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BusinessJargonCode](
	[JargonCode] [nvarchar](50) NOT NULL,
	[JargonDesc] [nvarchar](18) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK11] PRIMARY KEY CLUSTERED 
(
	[JargonCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CaptureItems]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CaptureItems](
	[CaptureItemsCode] [nvarchar](50) NOT NULL,
	[CaptureItemsDesc] [nvarchar](18) NULL,
	[CreateDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK20] PRIMARY KEY CLUSTERED 
(
	[CaptureItemsCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CLC_DIR]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLC_DIR](
	[UserID] [nvarchar](50) NOT NULL,
	[DirName] [nvarchar](50) NOT NULL,
	[FullPath] [nvarchar](4000) NOT NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CLC_Download]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CLC_Download](
	[UserID] [nvarchar](50) NOT NULL,
	[ContentTable] [nvarchar](50) NOT NULL,
	[ContentGuid] [varchar](50) NOT NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CLC_Preview]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CLC_Preview](
	[UserID] [nvarchar](50) NOT NULL,
	[ContentTable] [nvarchar](50) NOT NULL,
	[ContentGuid] [varchar](50) NOT NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CLCState]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLCState](
	[CLCInstalled] [bit] NULL,
	[CLCActive] [bit] NULL,
	[MachineID] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](80) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConnectionStrings]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConnectionStrings](
	[DBMS] [nvarchar](100) NOT NULL,
	[ConnStr] [nvarchar](254) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConnectionStringsRegistered]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConnectionStringsRegistered](
	[ConnName] [nvarchar](100) NOT NULL,
	[ConnStr] [nvarchar](254) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConnectionStringsSaved]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConnectionStringsSaved](
	[ConnstrName] [nvarchar](100) NOT NULL,
	[ConnStr] [nvarchar](2000) NOT NULL,
	[TypeDB] [nvarchar](15) NULL,
	[CustomColSelectionSQL] [nvarchar](max) NULL,
	[CustomTableDataSQL] [nvarchar](max) NULL,
	[SelectedColumns] [nvarchar](max) NULL,
	[Schedule] [nvarchar](2000) NULL,
	[TableName] [nvarchar](2000) NULL,
	[LastArchiveDate] [datetime] NULL,
	[Library] [nvarchar](50) NULL,
	[LibraryOwnerGuid] [nvarchar](50) NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[CombinedSql] [nvarchar](max) NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ContactFrom]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ContactFrom](
	[FromEmailAddr] [nvarchar](254) NOT NULL,
	[SenderName] [varchar](254) NOT NULL,
	[UserID] [varchar](25) NOT NULL,
	[Verified] [int] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [ContactFrom_PK] PRIMARY KEY NONCLUSTERED 
(
	[FromEmailAddr] ASC,
	[SenderName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContactsArchive]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactsArchive](
	[Email1Address] [nvarchar](80) NOT NULL,
	[FullName] [nvarchar](80) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[Account] [nvarchar](4000) NULL,
	[Anniversary] [nvarchar](4000) NULL,
	[Application] [nvarchar](4000) NULL,
	[AssistantName] [nvarchar](4000) NULL,
	[AssistantTelephoneNumber] [nvarchar](4000) NULL,
	[BillingInformation] [nvarchar](4000) NULL,
	[Birthday] [nvarchar](4000) NULL,
	[Business2TelephoneNumber] [nvarchar](4000) NULL,
	[BusinessAddress] [nvarchar](4000) NULL,
	[BusinessAddressCity] [nvarchar](4000) NULL,
	[BusinessAddressCountry] [nvarchar](4000) NULL,
	[BusinessAddressPostalCode] [nvarchar](4000) NULL,
	[BusinessAddressPostOfficeBox] [nvarchar](4000) NULL,
	[BusinessAddressState] [nvarchar](4000) NULL,
	[BusinessAddressStreet] [nvarchar](4000) NULL,
	[BusinessCardType] [nvarchar](4000) NULL,
	[BusinessFaxNumber] [nvarchar](4000) NULL,
	[BusinessHomePage] [nvarchar](4000) NULL,
	[BusinessTelephoneNumber] [nvarchar](4000) NULL,
	[CallbackTelephoneNumber] [nvarchar](4000) NULL,
	[CarTelephoneNumber] [nvarchar](4000) NULL,
	[Categories] [nvarchar](4000) NULL,
	[Children] [nvarchar](4000) NULL,
	[xClass] [nvarchar](4000) NULL,
	[Companies] [nvarchar](4000) NULL,
	[CompanyName] [nvarchar](4000) NULL,
	[ComputerNetworkName] [nvarchar](4000) NULL,
	[Conflicts] [nvarchar](4000) NULL,
	[ConversationTopic] [nvarchar](4000) NULL,
	[CreationTime] [nvarchar](4000) NULL,
	[CustomerID] [nvarchar](4000) NULL,
	[Department] [nvarchar](4000) NULL,
	[Email1AddressType] [nvarchar](4000) NULL,
	[Email1DisplayName] [nvarchar](4000) NULL,
	[Email1EntryID] [nvarchar](4000) NULL,
	[Email2Address] [nvarchar](4000) NULL,
	[Email2AddressType] [nvarchar](4000) NULL,
	[Email2DisplayName] [nvarchar](4000) NULL,
	[Email2EntryID] [nvarchar](4000) NULL,
	[Email3Address] [nvarchar](4000) NULL,
	[Email3AddressType] [nvarchar](4000) NULL,
	[Email3DisplayName] [nvarchar](4000) NULL,
	[Email3EntryID] [nvarchar](4000) NULL,
	[FileAs] [nvarchar](4000) NULL,
	[FirstName] [nvarchar](4000) NULL,
	[FTPSite] [nvarchar](4000) NULL,
	[Gender] [nvarchar](4000) NULL,
	[GovernmentIDNumber] [nvarchar](4000) NULL,
	[Hobby] [nvarchar](4000) NULL,
	[Home2TelephoneNumber] [nvarchar](4000) NULL,
	[HomeAddress] [nvarchar](4000) NULL,
	[HomeAddressCountry] [nvarchar](4000) NULL,
	[HomeAddressPostalCode] [nvarchar](4000) NULL,
	[HomeAddressPostOfficeBox] [nvarchar](4000) NULL,
	[HomeAddressState] [nvarchar](4000) NULL,
	[HomeAddressStreet] [nvarchar](4000) NULL,
	[HomeFaxNumber] [nvarchar](4000) NULL,
	[HomeTelephoneNumber] [nvarchar](4000) NULL,
	[IMAddress] [nvarchar](4000) NULL,
	[Importance] [nvarchar](4000) NULL,
	[Initials] [nvarchar](4000) NULL,
	[InternetFreeBusyAddress] [nvarchar](4000) NULL,
	[JobTitle] [nvarchar](4000) NULL,
	[Journal] [nvarchar](4000) NULL,
	[Language] [nvarchar](4000) NULL,
	[LastModificationTime] [nvarchar](4000) NULL,
	[LastName] [nvarchar](4000) NULL,
	[LastNameAndFirstName] [nvarchar](4000) NULL,
	[MailingAddress] [nvarchar](4000) NULL,
	[MailingAddressCity] [nvarchar](4000) NULL,
	[MailingAddressCountry] [nvarchar](4000) NULL,
	[MailingAddressPostalCode] [nvarchar](4000) NULL,
	[MailingAddressPostOfficeBox] [nvarchar](4000) NULL,
	[MailingAddressState] [nvarchar](4000) NULL,
	[MailingAddressStreet] [nvarchar](4000) NULL,
	[ManagerName] [nvarchar](4000) NULL,
	[MiddleName] [nvarchar](4000) NULL,
	[Mileage] [nvarchar](4000) NULL,
	[MobileTelephoneNumber] [nvarchar](4000) NULL,
	[NetMeetingAlias] [nvarchar](4000) NULL,
	[NetMeetingServer] [nvarchar](4000) NULL,
	[NickName] [nvarchar](4000) NULL,
	[Title] [nvarchar](4000) NULL,
	[Body] [nvarchar](4000) NULL,
	[OfficeLocation] [nvarchar](4000) NULL,
	[Subject] [nvarchar](4000) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK45] PRIMARY KEY NONCLUSTERED 
(
	[Email1Address] ASC,
	[FullName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Container]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Container](
	[ContainerGuid] [uniqueidentifier] NOT NULL,
	[ContainerName] [nvarchar](449) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK193] PRIMARY KEY CLUSTERED 
(
	[ContainerGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [PI_Container01] UNIQUE NONCLUSTERED 
(
	[ContainerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ContainerStorage]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContainerStorage](
	[StoreCode] [nvarchar](50) NOT NULL,
	[ContainerType] [nvarchar](25) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK18] PRIMARY KEY NONCLUSTERED 
(
	[StoreCode] ASC,
	[ContainerType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ContentContainer]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContentContainer](
	[ContentUserRowGuid] [uniqueidentifier] NOT NULL,
	[ContainerGuid] [uniqueidentifier] NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK194] PRIMARY KEY NONCLUSTERED 
(
	[ContentUserRowGuid] ASC,
	[ContainerGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ContentUser]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContentUser](
	[ContentTypeCode] [nchar](1) NOT NULL,
	[ContentGuid] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NULL,
	[NbrOccurances] [int] NOT NULL,
	[ContentUserRowGuid] [uniqueidentifier] NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK187] PRIMARY KEY NONCLUSTERED 
(
	[ContentUserRowGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_ContentUserIdx] UNIQUE CLUSTERED 
(
	[ContentGuid] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ConvertedDocs]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConvertedDocs](
	[FQN] [nvarchar](254) NOT NULL,
	[FileName] [nvarchar](254) NULL,
	[XMLName] [nvarchar](254) NULL,
	[XMLDIr] [nvarchar](254) NULL,
	[FileDir] [nvarchar](254) NULL,
	[CorpName] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK25] PRIMARY KEY CLUSTERED 
(
	[FQN] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CoOwner]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CoOwner](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[CurrentOwnerUserID] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[PreviousOwnerUserID] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK76_1] PRIMARY KEY NONCLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CorpContainer]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CorpContainer](
	[ContainerType] [nvarchar](25) NOT NULL,
	[QtyDocCode] [nvarchar](10) NOT NULL,
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[CorpName] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK2] PRIMARY KEY NONCLUSTERED 
(
	[ContainerType] ASC,
	[CorpFuncName] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CorpFunction]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CorpFunction](
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[CorpFuncDesc] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NULL,
	[CorpName] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK1] PRIMARY KEY NONCLUSTERED 
(
	[CorpFuncName] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Corporation]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Corporation](
	[CorpName] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK26] PRIMARY KEY CLUSTERED 
(
	[CorpName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[CS]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CS](
	[ConnectionString] [varchar](300) NOT NULL,
	[ConnectionType] [nchar](25) NOT NULL,
	[ConnectionName] [nvarchar](50) NOT NULL,
	[SharePointURL] [nvarchar](500) NULL,
	[LoginID] [nvarchar](80) NULL,
	[LoginPW] [nvarchar](80) NULL,
	[ID_NBR] [varchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[CS_SharePoint]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[CS_SharePoint](
	[SP_ConnectionString] [varchar](300) NOT NULL,
	[ECM_ConnectionString] [varchar](300) NOT NULL,
	[ConnectionName] [nvarchar](50) NOT NULL,
	[isPublic] [bit] NULL,
	[LibraryName] [nvarchar](80) NULL,
	[LoginID] [nvarchar](80) NULL,
	[LoginPW] [nvarchar](80) NULL,
	[ID_NBR] [varchar](50) NULL,
	[ID_NBR_ECM] [varchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DatabaseFiles]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DatabaseFiles](
	[file_id] [int] NOT NULL,
	[file_guid] [uniqueidentifier] NULL,
	[type] [tinyint] NOT NULL,
	[type_desc] [nvarchar](60) NULL,
	[data_space_id] [int] NOT NULL,
	[name] [sysname] NOT NULL,
	[physical_name] [nvarchar](260) NOT NULL,
	[state] [tinyint] NULL,
	[state_desc] [nvarchar](60) NULL,
	[size] [int] NOT NULL,
	[max_size] [int] NOT NULL,
	[growth] [int] NOT NULL,
	[is_media_read_only] [bit] NOT NULL,
	[is_read_only] [bit] NOT NULL,
	[is_sparse] [bit] NOT NULL,
	[is_percent_growth] [bit] NOT NULL,
	[is_name_reserved] [bit] NOT NULL,
	[create_lsn] [numeric](25, 0) NULL,
	[drop_lsn] [numeric](25, 0) NULL,
	[read_only_lsn] [numeric](25, 0) NULL,
	[read_write_lsn] [numeric](25, 0) NULL,
	[differential_base_lsn] [numeric](25, 0) NULL,
	[differential_base_guid] [uniqueidentifier] NULL,
	[differential_base_time] [datetime] NULL,
	[redo_start_lsn] [numeric](25, 0) NULL,
	[redo_start_fork_guid] [uniqueidentifier] NULL,
	[redo_target_lsn] [numeric](25, 0) NULL,
	[redo_target_fork_guid] [uniqueidentifier] NULL,
	[backup_lsn] [numeric](25, 0) NULL,
	[CreationDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Databases]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Databases](
	[DB_ID] [nvarchar](50) NOT NULL,
	[DB_CONN_STR] [nvarchar](254) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK6Databases] PRIMARY KEY CLUSTERED 
(
	[DB_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DataOwners]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataOwners](
	[PrimaryOwner] [bit] NULL,
	[OwnerTypeCode] [nvarchar](50) NULL,
	[FullAccess] [bit] NULL,
	[ReadOnly] [bit] NULL,
	[DeleteAccess] [bit] NULL,
	[Searchable] [bit] NULL,
	[SourceGuid] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[GroupOwnerUserID] [nvarchar](50) NOT NULL,
	[GroupName] [nvarchar](80) NOT NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK42] PRIMARY KEY NONCLUSTERED 
(
	[SourceGuid] ASC,
	[UserID] ASC,
	[GroupOwnerUserID] ASC,
	[GroupName] ASC,
	[DataSourceOwnerUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DataSource]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DataSource](
	[RowGuid] [uniqueidentifier] NOT NULL,
	[SourceGuid] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[SourceName] [nvarchar](254) NULL,
	[SourceImage] [varbinary](max) NULL,
	[SourceTypeCode] [nvarchar](50) NOT NULL,
	[FQN] [varchar](712) NULL,
	[VersionNbr] [int] NOT NULL,
	[LastAccessDate] [datetime] NULL,
	[FileLength] [int] NULL,
	[LastWriteTime] [datetime] NULL,
	[UserID] [nvarchar](50) NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NOT NULL,
	[isPublic] [nchar](1) NULL,
	[FileDirectory] [nvarchar](300) NULL,
	[OriginalFileType] [nvarchar](50) NULL,
	[RetentionExpirationDate] [datetime] NULL,
	[IsPublicPreviousState] [nchar](1) NULL,
	[isAvailable] [nchar](1) NULL,
	[isContainedWithinZipFile] [nchar](1) NULL,
	[IsZipFile] [nchar](1) NULL,
	[DataVerified] [bit] NULL,
	[ZipFileGuid] [nvarchar](50) NULL,
	[ZipFileFQN] [varchar](712) NULL,
	[Description] [nvarchar](max) NULL,
	[KeyWords] [nvarchar](2000) NULL,
	[Notes] [nvarchar](2000) NULL,
	[isPerm] [nchar](1) NULL,
	[isMaster] [nchar](1) NULL,
	[CreationDate] [datetime] NULL,
	[OcrPerformed] [nchar](1) NULL,
	[isGraphic] [nchar](1) NULL,
	[GraphicContainsText] [nchar](1) NULL,
	[OcrText] [nvarchar](max) NULL,
	[ImageHiddenText] [nvarchar](max) NULL,
	[isWebPage] [nchar](1) NULL,
	[ParentGuid] [nvarchar](50) NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[MachineID] [nvarchar](250) NULL,
	[CRC] [nvarchar](50) NULL,
	[SharePoint] [bit] NULL,
	[SharePointDoc] [bit] NULL,
	[SharePointList] [bit] NULL,
	[SharePointListItem] [bit] NULL,
	[StructuredData] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[ContainedWithin] [nvarchar](50) NULL,
	[RecLen] [float] NULL,
	[RecHash] [varchar](50) NULL,
	[OriginalSize] [int] NULL,
	[CompressedSize] [int] NULL,
	[txStartTime] [datetime] NULL,
	[txEndTime] [datetime] NULL,
	[txTotalTime] [float] NULL,
	[TransmitTime] [float] NULL,
	[FileAttached] [bit] NULL,
	[BPS] [float] NULL,
	[RepoName] [nvarchar](50) NULL,
	[HashFile] [nvarchar](50) NULL,
	[HashName] [nvarchar](50) NULL,
	[OcrSuccessful] [char](1) NULL,
	[OcrPending] [char](1) NULL,
	[PdfIsSearchable] [char](1) NULL,
	[PdfOcrRequired] [char](1) NULL,
	[PdfOcrSuccess] [char](1) NULL,
	[PdfOcrTextExtracted] [char](1) NULL,
	[PdfPages] [int] NULL,
	[PdfImages] [int] NULL,
	[RequireOcr] [bit] NULL,
	[RssLinkFlg] [bit] NULL,
	[RssLinkGuid] [nvarchar](50) NULL,
	[PageURL] [nvarchar](4000) NULL,
	[RetentionDate] [datetime] NULL,
	[URLHash] [nvarchar](50) NULL,
	[WebPagePublishDate] [nvarchar](50) NULL,
	[SapData] [bit] NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DataSourceCheckOut]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSourceCheckOut](
	[SourceGuid] [nvarchar](50) NOT NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NOT NULL,
	[CheckedOutByUserID] [nvarchar](50) NOT NULL,
	[isReadOnly] [bit] NULL,
	[isForUpdate] [bit] NULL,
	[checkOutDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK82] PRIMARY KEY NONCLUSTERED 
(
	[CheckedOutByUserID] ASC,
	[SourceGuid] ASC,
	[DataSourceOwnerUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DataSourceChildren]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSourceChildren](
	[ParentSourceGuid] [nchar](50) NOT NULL,
	[ChildSourceGuid] [nchar](50) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DataSourceOwner]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSourceOwner](
	[SourceGuid] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DataSourceRestoreHistory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataSourceRestoreHistory](
	[SourceGuid] [nvarchar](50) NOT NULL,
	[RestoredToMachine] [nvarchar](50) NULL,
	[RestoreUserName] [nvarchar](50) NULL,
	[RestoreUserID] [nvarchar](50) NULL,
	[RestoreUserDomain] [nvarchar](254) NULL,
	[RestoreDate] [datetime] NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NOT NULL,
	[SeqNo] [int] IDENTITY(1,1) NOT NULL,
	[TypeContentCode] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[DocumentName] [nvarchar](254) NULL,
	[FQN] [nvarchar](500) NULL,
	[VerifiedData] [nchar](1) NULL,
	[OrigCrc] [nvarchar](50) NULL,
	[RestoreCrc] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK83] PRIMARY KEY CLUSTERED 
(
	[SeqNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DataTypeCodes]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataTypeCodes](
	[FileType] [nvarchar](255) NULL,
	[VerNbr] [nvarchar](255) NULL,
	[Publisher] [nvarchar](255) NULL,
	[Definition] [nvarchar](255) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DB_UpdateHist]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_UpdateHist](
	[CreateDate] [datetime] NOT NULL,
	[FixID] [int] NOT NULL,
	[DBName] [nvarchar](50) NULL,
	[CompanyID] [nvarchar](50) NULL,
	[MachineName] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DB_Updates]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DB_Updates](
	[SqlStmt] [nvarchar](max) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[FixID] [int] NOT NULL,
	[FixDescription] [nvarchar](4000) NULL,
	[DBName] [nvarchar](50) NULL,
	[CompanyID] [nvarchar](50) NULL,
	[MachineName] [nvarchar](50) NULL,
	[AppliedDate] [datetime] NULL,
	[Applied] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DeleteFrom]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DeleteFrom](
	[FromEmailAddr] [nvarchar](254) NOT NULL,
	[SenderName] [varchar](254) NOT NULL,
	[UserID] [varchar](25) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK40] PRIMARY KEY NONCLUSTERED 
(
	[FromEmailAddr] ASC,
	[SenderName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DirArchLib]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirArchLib](
	[DirOwnerUserID] [nvarchar](50) NOT NULL,
	[LibOwnerUserID] [nvarchar](50) NOT NULL,
	[FQN] [nvarchar](254) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Directory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Directory](
	[UserID] [nvarchar](50) NOT NULL,
	[IncludeSubDirs] [char](1) NULL,
	[FQN] [varchar](254) NOT NULL,
	[DB_ID] [nvarchar](50) NOT NULL,
	[VersionFiles] [char](1) NULL,
	[ckMetaData] [nchar](1) NULL,
	[ckPublic] [nchar](1) NULL,
	[ckDisableDir] [nchar](1) NULL,
	[QuickRefEntry] [char](10) NULL,
	[isSysDefault] [bit] NULL,
	[OcrDirectory] [nchar](1) NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[isServerDirectory] [bit] NULL,
	[isMappedDrive] [bit] NULL,
	[isNetworkDrive] [bit] NULL,
	[RequiresAuthentication] [bit] NULL,
	[AdminDisabled] [bit] NULL,
	[ArchiveSkipBit] [bit] NULL,
	[ListenForChanges] [bit] NULL,
	[ListenDirectory] [bit] NULL,
	[ListenSubDirectory] [bit] NULL,
	[DirGuid] [uniqueidentifier] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[OcrPdf] [nchar](1) NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[DeleteOnArchive] [nchar](1) NULL,
 CONSTRAINT [PKII2] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[FQN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DirectoryGuids]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DirectoryGuids](
	[DirFQN] [varchar](800) NOT NULL,
	[DirGuid] [nchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DirectoryListener]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirectoryListener](
	[UserID] [nvarchar](50) NOT NULL,
	[AdminDisabled] [bit] NULL,
	[ListenerLoaded] [bit] NULL,
	[ListenerActive] [bit] NULL,
	[ListenerPaused] [bit] NULL,
	[ListenDirectory] [bit] NULL,
	[ListenSubDirectory] [bit] NULL,
	[DirGuid] [uniqueidentifier] NOT NULL,
	[MachineName] [nvarchar](80) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DirectoryListenerFiles]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DirectoryListenerFiles](
	[DirGuid] [nvarchar](50) NOT NULL,
	[SourceFile] [varchar](720) NOT NULL,
	[Archived] [bit] NOT NULL,
	[EntryDate] [date] NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[MachineName] [varchar](80) NOT NULL,
	[NameHash] [decimal](15, 8) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DirectoryLongName]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DirectoryLongName](
	[DIRHASH] [varchar](50) NOT NULL,
	[DirLongName] [nvarchar](max) NOT NULL,
	[DirLongNameID] [varchar](50) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DirectoryMonitorLog]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirectoryMonitorLog](
	[AccessedBy] [nvarchar](50) NULL,
	[DirFQN] [nvarchar](2000) NULL,
	[TypeAccess] [nvarchar](20) NULL,
	[AccessDate] [datetime] NULL,
	[FileFQN] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
	[RepoName] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DirectoryTemp]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DirectoryTemp](
	[DirFQN] [nvarchar](300) NOT NULL,
	[CurrUserGuidId] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NULL,
	[SkipDir] [char](1) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DirProfiles]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DirProfiles](
	[ProfileName] [nvarchar](50) NOT NULL,
	[Parms] [nvarchar](max) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[DuplicateContent]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[DuplicateContent](
	[HashID] [nvarchar](50) NULL,
	[ContentUniqueName] [varchar](900) NULL,
	[Occurances] [int] NULL,
	[Guids] [varchar](max) NULL,
	[ContentType] [char](1) NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [UK_Dups] UNIQUE NONCLUSTERED 
(
	[ContentUniqueName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EcmUser]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EcmUser](
	[EMail] [nvarchar](50) NOT NULL,
	[PhoneNumber] [nvarchar](20) NULL,
	[YourName] [nvarchar](100) NULL,
	[YourCompany] [nvarchar](50) NULL,
	[PassWord] [nvarchar](50) NULL,
	[Authority] [nchar](1) NULL,
	[CreateDate] [datetime] NULL,
	[CompanyID] [nvarchar](50) NULL,
	[LastUpdate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK8] PRIMARY KEY CLUSTERED 
(
	[EMail] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Email]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Email](
	[EmailGuid] [nvarchar](50) NOT NULL,
	[SUBJECT] [nvarchar](2000) NULL,
	[SentTO] [nvarchar](max) NULL,
	[Body] [text] NULL,
	[Bcc] [nvarchar](max) NULL,
	[BillingInformation] [nvarchar](200) NULL,
	[CC] [nvarchar](max) NULL,
	[Companies] [nvarchar](2000) NULL,
	[CreationTime] [datetime] NULL,
	[ReadReceiptRequested] [nvarchar](50) NULL,
	[ReceivedByName] [nvarchar](80) NOT NULL,
	[ReceivedTime] [datetime] NOT NULL,
	[AllRecipients] [nvarchar](max) NULL,
	[UserID] [nvarchar](80) NOT NULL,
	[SenderEmailAddress] [nvarchar](80) NOT NULL,
	[SenderName] [nvarchar](100) NOT NULL,
	[Sensitivity] [nvarchar](50) NULL,
	[SentOn] [datetime] NOT NULL,
	[MsgSize] [int] NULL,
	[DeferredDeliveryTime] [datetime] NULL,
	[EntryID] [varchar](150) NULL,
	[ExpiryTime] [datetime] NULL,
	[LastModificationTime] [datetime] NULL,
	[EmailImage] [varbinary](max) NULL,
	[Accounts] [nvarchar](2000) NULL,
	[ShortSubj] [nvarchar](250) NULL,
	[SourceTypeCode] [nvarchar](50) NULL,
	[OriginalFolder] [nvarchar](254) NULL,
	[StoreID] [varchar](750) NULL,
	[isPublic] [nchar](1) NULL,
	[RetentionExpirationDate] [datetime] NULL,
	[IsPublicPreviousState] [nchar](1) NULL,
	[isAvailable] [nchar](1) NULL,
	[CurrMailFolderID] [nvarchar](300) NULL,
	[isPerm] [nchar](1) NULL,
	[isMaster] [nchar](1) NULL,
	[CreationDate] [datetime] NULL,
	[NbrAttachments] [int] NULL,
	[CRC] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[KeyWords] [nvarchar](2000) NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[EmailIdentifier] [nvarchar](450) NULL,
	[ConvertEmlToMSG] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[UIDL] [int] NULL,
	[RecLen] [float] NULL,
	[RecHash] [nvarchar](50) NOT NULL,
	[OriginalSize] [int] NULL,
	[CompressedSize] [int] NULL,
	[txStartTime] [datetime] NULL,
	[txEndTime] [datetime] NULL,
	[txTotalTime] [float] NULL,
	[TransmitTime] [float] NULL,
	[FileAttached] [bit] NULL,
	[BPS] [float] NULL,
	[RepoName] [nvarchar](50) NULL,
	[HashFile] [nvarchar](50) NULL,
	[HashName] [nvarchar](50) NULL,
	[ContainsAttachment] [char](1) NULL,
	[NbrAttachment] [int] NULL,
	[NbrZipFiles] [int] NULL,
	[NbrZipFilesCnt] [int] NULL,
	[PdfIsSearchable] [char](1) NULL,
	[PdfOcrRequired] [char](1) NULL,
	[PdfOcrSuccess] [char](1) NULL,
	[PdfOcrTextExtracted] [char](1) NULL,
	[PdfPages] [int] NULL,
	[PdfImages] [int] NULL,
	[MachineID] [nvarchar](50) NULL,
	[notes] [nvarchar](4000) NULL,
	[NbrOccurances] [int] NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[EmailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmailArchParms]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmailArchParms](
	[UserID] [nvarchar](50) NOT NULL,
	[ArchiveEmails] [char](1) NULL,
	[RemoveAfterArchive] [char](1) NULL,
	[SetAsDefaultFolder] [char](1) NULL,
	[ArchiveAfterXDays] [char](1) NULL,
	[RemoveAfterXDays] [char](1) NULL,
	[RemoveXDays] [int] NULL,
	[ArchiveXDays] [int] NULL,
	[FolderName] [nvarchar](254) NOT NULL,
	[DB_ID] [nvarchar](50) NOT NULL,
	[ArchiveOnlyIfRead] [nchar](1) NULL,
	[isSysDefault] [bit] NULL,
	[ContainerName] [nvarchar](80) NULL,
	[MachineName] [nvarchar](80) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[nRowID] [int] IDENTITY(1,1) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmailAttachment]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmailAttachment](
	[RowGuid] [uniqueidentifier] NOT NULL,
	[Attachment] [varbinary](max) NULL,
	[AttachmentName] [nvarchar](254) NULL,
	[EmailGuid] [nvarchar](50) NOT NULL,
	[AttachmentCode] [nvarchar](50) NULL,
	[AttachmentType] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[isZipFileEntry] [bit] NULL,
	[OcrText] [nvarchar](max) NULL,
	[isPublic] [char](1) NULL,
	[AttachmentLength] [int] NULL,
	[OriginalFileTypeCode] [nvarchar](20) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RecLen] [float] NULL,
	[RecHash] [varchar](50) NULL,
	[OriginalSize] [int] NULL,
	[CompressedSize] [int] NULL,
	[txStartTime] [datetime] NULL,
	[txEndTime] [datetime] NULL,
	[txTotalTime] [float] NULL,
	[TransmitTime] [float] NULL,
	[FileAttached] [bit] NULL,
	[BPS] [float] NULL,
	[RepoName] [nvarchar](50) NULL,
	[CRC] [nvarchar](50) NULL,
	[OcrSuccessful] [char](1) NULL,
	[OcrPending] [char](1) NULL,
	[PdfIsSearchable] [char](1) NULL,
	[PdfOcrRequired] [char](1) NULL,
	[PdfOcrSuccess] [char](1) NULL,
	[PdfOcrTextExtracted] [char](1) NULL,
	[PdfPages] [int] NULL,
	[PdfImages] [int] NULL,
	[OcrPerformed] [char](1) NULL,
	[RetentionExpirationDate] [datetime] NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[MachineID] [nvarchar](50) NULL,
	[ParentGuid] [nvarchar](50) NULL,
	[RequireOcr] [bit] NULL,
	[CreateDate] [datetime] NOT NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RowGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmailAttachmentSearchList]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailAttachmentSearchList](
	[UserID] [nvarchar](50) NOT NULL,
	[EmailGuid] [nvarchar](50) NOT NULL,
	[Weight] [int] NULL,
	[RowID] [int] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmailFolder]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmailFolder](
	[UserID] [nvarchar](50) NOT NULL,
	[FolderName] [varchar](450) NULL,
	[ParentFolderName] [varchar](200) NULL,
	[FolderID] [varchar](100) NOT NULL,
	[ParentFolderID] [varchar](100) NULL,
	[SelectedForArchive] [char](1) NULL,
	[StoreID] [varchar](600) NOT NULL,
	[isSysDefault] [bit] NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[ContainerName] [varchar](80) NULL,
	[MachineName] [nvarchar](80) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[nRowID] [int] IDENTITY(1,1) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmailFolder_BAK]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmailFolder_BAK](
	[UserID] [nvarchar](50) NOT NULL,
	[FolderName] [varchar](450) NULL,
	[ParentFolderName] [varchar](200) NULL,
	[FolderID] [varchar](100) NOT NULL,
	[ParentFolderID] [varchar](100) NOT NULL,
	[SelectedForArchive] [char](1) NULL,
	[StoreID] [varchar](600) NOT NULL,
	[isSysDefault] [bit] NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[ContainerName] [varchar](80) NULL,
	[MachineName] [nvarchar](80) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[nRowID] [int] IDENTITY(1,1) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmailFolder_BAK2]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmailFolder_BAK2](
	[UserID] [nvarchar](50) NOT NULL,
	[FolderName] [varchar](450) NULL,
	[ParentFolderName] [varchar](200) NULL,
	[FolderID] [varchar](100) NOT NULL,
	[ParentFolderID] [varchar](100) NOT NULL,
	[SelectedForArchive] [char](1) NULL,
	[StoreID] [varchar](600) NOT NULL,
	[isSysDefault] [bit] NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[ContainerName] [varchar](80) NULL,
	[MachineName] [nvarchar](80) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[nRowID] [int] IDENTITY(1,1) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmailRunningTotal]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmailRunningTotal](
	[Ord] [int] IDENTITY(1,1) NOT NULL,
	[YR] [int] NULL,
	[Period] [varchar](50) NULL,
	[PeriodVal] [float] NULL,
	[Total] [float] NULL,
	[RunningTotal] [float] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EmailToDelete]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EmailToDelete](
	[EmailGuid] [nvarchar](50) NOT NULL,
	[StoreID] [nvarchar](500) NOT NULL,
	[UserID] [nvarchar](100) NOT NULL,
	[MessageID] [nchar](100) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ErrorLogs]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorLogs](
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[LogName] [nvarchar](50) NOT NULL,
	[LoggedMessage] [nvarchar](4000) NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[EntryUserID] [nvarchar](50) NOT NULL,
	[Severity] [nvarchar](10) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExcgKey]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ExcgKey](
	[MailKey] [varchar](500) NOT NULL,
	[InsertDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ExchangeHostPop]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExchangeHostPop](
	[HostNameIp] [nvarchar](100) NOT NULL,
	[UserLoginID] [nvarchar](80) NOT NULL,
	[LoginPw] [nvarchar](50) NOT NULL,
	[SSL] [bit] NULL,
	[PortNbr] [int] NULL,
	[DeleteAfterDownload] [bit] NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[IMap] [bit] NULL,
	[Userid] [nvarchar](50) NULL,
	[FolderName] [nvarchar](80) NULL,
	[isPublic] [bit] NULL,
	[LibraryName] [nvarchar](80) NULL,
	[DaysToHold] [int] NULL,
	[strReject] [nvarchar](250) NULL,
	[ConvertEmlToMSG] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExchangeHostSmtp]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExchangeHostSmtp](
	[HostNameIp] [nvarchar](100) NOT NULL,
	[UserLoginID] [nvarchar](80) NOT NULL,
	[LoginPw] [nvarchar](50) NOT NULL,
	[DisplayName] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ExcludedFiles]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ExcludedFiles](
	[UserID] [nvarchar](50) NOT NULL,
	[ExtCode] [nvarchar](50) NOT NULL,
	[FQN] [varchar](254) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PKII4] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[ExtCode] ASC,
	[FQN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ExcludeFrom]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ExcludeFrom](
	[FromEmailAddr] [nvarchar](254) NOT NULL,
	[SenderName] [varchar](254) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_ExcludeFrom] PRIMARY KEY NONCLUSTERED 
(
	[FromEmailAddr] ASC,
	[SenderName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FileKey]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileKey](
	[FileKey] [nvarchar](300) NOT NULL,
	[SourceGuid] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FileKeyMachine]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileKeyMachine](
	[Machine] [nvarchar](80) NOT NULL,
	[FileKey] [nvarchar](300) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FileKeyMachineDir]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileKeyMachineDir](
	[Machine] [nvarchar](80) NOT NULL,
	[Dir] [nvarchar](254) NOT NULL,
	[FileKey] [nvarchar](300) NOT NULL,
	[HashKey] [nvarchar](100) NOT NULL,
	[FileKeyMachineDirGuid] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FilesToDelete]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FilesToDelete](
	[UserID] [nvarchar](50) NULL,
	[MachineName] [nvarchar](100) NULL,
	[FQN] [nvarchar](254) NULL,
	[PendingDelete] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FileType]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FileType](
	[FileExt] [nvarchar](50) NULL,
	[Description] [nvarchar](255) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FUncSkipWords]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FUncSkipWords](
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[tgtWord] [nvarchar](18) NOT NULL,
	[CorpName] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK24] PRIMARY KEY NONCLUSTERED 
(
	[CorpFuncName] ASC,
	[tgtWord] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FunctionProdJargon]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FunctionProdJargon](
	[KeyFlag] [binary](50) NULL,
	[RepeatDataCode] [nvarchar](50) NOT NULL,
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[JargonCode] [nvarchar](50) NOT NULL,
	[CorpName] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK13] PRIMARY KEY NONCLUSTERED 
(
	[CorpFuncName] ASC,
	[JargonCode] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GlobalAsso]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GlobalAsso](
	[LocationID] [uniqueidentifier] NOT NULL,
	[MachineID] [uniqueidentifier] NOT NULL,
	[DirID] [uniqueidentifier] NOT NULL,
	[FileID] [uniqueidentifier] NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GlobalDirectory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GlobalDirectory](
	[HashCode] [varchar](40) NOT NULL,
	[GuidID] [uniqueidentifier] NOT NULL,
	[ShortName] [nvarchar](250) NULL,
	[LongName] [nvarchar](2000) NULL,
	[LocatorID] [int] IDENTITY(1,1) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GlobalEmail]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GlobalEmail](
	[HashCode] [varchar](40) NOT NULL,
	[GuidID] [uniqueidentifier] NOT NULL,
	[ShortName] [nvarchar](250) NULL,
	[LongName] [nvarchar](2000) NULL,
	[LocatorID] [int] IDENTITY(1,1) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GlobalFile]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GlobalFile](
	[HashCode] [varchar](40) NOT NULL,
	[GuidID] [uniqueidentifier] NOT NULL,
	[ShortName] [nvarchar](250) NULL,
	[LongName] [nvarchar](2000) NULL,
	[LocatorID] [int] IDENTITY(1,1) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GlobalLocation]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GlobalLocation](
	[HashCode] [varchar](40) NOT NULL,
	[GuidID] [uniqueidentifier] NOT NULL,
	[ShortName] [nvarchar](250) NULL,
	[LongName] [nvarchar](2000) NULL,
	[LocatorID] [int] IDENTITY(1,1) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GlobalMachine]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GlobalMachine](
	[HashCode] [varchar](40) NOT NULL,
	[GuidID] [uniqueidentifier] NOT NULL,
	[ShortName] [nvarchar](250) NULL,
	[LongName] [nvarchar](2000) NULL,
	[LocatorID] [int] IDENTITY(1,1) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GlobalSeachResults]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GlobalSeachResults](
	[ContentTitle] [nvarchar](254) NULL,
	[ContentAuthor] [nvarchar](254) NULL,
	[ContentType] [nvarchar](50) NULL,
	[CreateDate] [nvarchar](50) NULL,
	[ContentExt] [nvarchar](50) NULL,
	[ContentGuid] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[FileName] [nvarchar](254) NULL,
	[FileSize] [int] NULL,
	[NbrOfAttachments] [int] NULL,
	[FromEmailAddress] [nvarchar](254) NULL,
	[AllRecipiants] [nvarchar](max) NULL,
	[Weight] [int] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GraphicFileType]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GraphicFileType](
	[GraphicFileTypeExt] [nvarchar](50) NOT NULL,
 CONSTRAINT [pkGraphicFileType] PRIMARY KEY CLUSTERED 
(
	[GraphicFileTypeExt] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GroupLibraryAccess]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupLibraryAccess](
	[UserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[GroupOwnerUserID] [nvarchar](50) NOT NULL,
	[GroupName] [nvarchar](80) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK70] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[LibraryName] ASC,
	[GroupOwnerUserID] ASC,
	[GroupName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[GroupUsers]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupUsers](
	[UserID] [nvarchar](50) NOT NULL,
	[FullAccess] [bit] NULL,
	[ReadOnlyAccess] [bit] NULL,
	[DeleteAccess] [bit] NULL,
	[Searchable] [bit] NULL,
	[GroupOwnerUserID] [nvarchar](50) NOT NULL,
	[GroupName] [nvarchar](80) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK44] PRIMARY KEY NONCLUSTERED 
(
	[GroupName] ASC,
	[UserID] ASC,
	[GroupOwnerUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HashDir]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HashDir](
	[Hash] [decimal](18, 0) NULL,
	[HashedString] [varchar](max) NULL,
	[HashID] [varchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HashFile]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HashFile](
	[Hash] [decimal](18, 0) NULL,
	[HashedString] [varchar](max) NULL,
	[HashID] [varchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HelpInfo]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HelpInfo](
	[HelpName] [nvarchar](50) NOT NULL,
	[HelpEmailAddr] [nvarchar](50) NOT NULL,
	[HelpPhone] [nvarchar](50) NOT NULL,
	[AreaOfFocus] [nvarchar](50) NULL,
	[HoursAvail] [nvarchar](50) NULL,
	[EmailNotification] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HelpText]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HelpText](
	[ScreenName] [nvarchar](100) NOT NULL,
	[HelpText] [nvarchar](max) NULL,
	[WidgetName] [nvarchar](100) NOT NULL,
	[WidgetText] [nvarchar](254) NULL,
	[DisplayHelpText] [bit] NULL,
	[LastUpdate] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HelpTextUser]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HelpTextUser](
	[UserID] [nvarchar](50) NOT NULL,
	[ScreenName] [nvarchar](100) NOT NULL,
	[HelpText] [nvarchar](max) NULL,
	[WidgetName] [nvarchar](100) NOT NULL,
	[WidgetText] [nvarchar](254) NULL,
	[DisplayHelpText] [bit] NULL,
	[CompanyID] [nvarchar](50) NULL,
	[LastUpdate] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HiveServers]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HiveServers](
	[SeverAlias] [nvarchar](100) NOT NULL,
	[ServerInstance] [nvarchar](100) NULL,
	[isHiveserver] [bit] NULL,
	[isLInked] [bit] NULL,
	[LinkedDate] [datetime] NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ImageTypeCodes]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ImageTypeCodes](
	[ImageTypeCode] [nvarchar](50) NULL,
	[ImageTypeCodeDesc] [nvarchar](250) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IncludedFiles]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IncludedFiles](
	[UserID] [nvarchar](50) NOT NULL,
	[ExtCode] [nvarchar](50) NOT NULL,
	[FQN] [nvarchar](254) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PKI3] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[ExtCode] ASC,
	[FQN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IncludeImmediate]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IncludeImmediate](
	[FromEmailAddr] [nvarchar](254) NOT NULL,
	[SenderName] [varchar](254) NOT NULL,
	[UserID] [varchar](25) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_IncludeImmediate] PRIMARY KEY NONCLUSTERED 
(
	[FromEmailAddr] ASC,
	[SenderName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InformationProduct]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[InformationProduct](
	[CreateDate] [datetime] NULL,
	[Code] [char](10) NOT NULL,
	[RetentionCode] [nvarchar](50) NOT NULL,
	[VolitilityCode] [nvarchar](50) NOT NULL,
	[ContainerType] [nvarchar](25) NOT NULL,
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[InfoTypeCode] [nvarchar](50) NOT NULL,
	[CorpName] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK5] PRIMARY KEY NONCLUSTERED 
(
	[ContainerType] ASC,
	[CorpFuncName] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[InformationType]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InformationType](
	[CreateDate] [datetime] NULL,
	[InfoTypeCode] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](4000) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK6] PRIMARY KEY NONCLUSTERED 
(
	[InfoTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Inventory](
	[DirFqn] [varchar](720) NULL,
	[FQN] [varchar](100) NULL,
	[FileSize] [int] NULL,
	[ExistInRepo] [bit] NULL,
	[UserLogin] [nvarchar](50) NULL,
	[DirHash] [numeric](18, 5) NULL,
	[FileHash] [numeric](18, 5) NULL,
	[CombinedHash] [varchar](50) NULL,
	[MachineName] [varbinary](80) NULL,
	[Verified] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[IP]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IP](
	[HostName] [nvarchar](150) NOT NULL,
	[AccessingIP] [nvarchar](50) NOT NULL,
	[AccessCnt] [int] NULL,
	[BlockIP] [bit] NULL,
	[SearchCnt] [int] NULL,
	[FirstAccessDate] [datetime] NULL,
	[LastAccessDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[JargonWords]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JargonWords](
	[tgtWord] [nvarchar](50) NOT NULL,
	[jDesc] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NULL,
	[JargonCode] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK12] PRIMARY KEY CLUSTERED 
(
	[JargonCode] ASC,
	[tgtWord] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[KTBL]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[KTBL](
	[KID] [int] IDENTITY(1,1) NOT NULL,
	[KGUID] [uniqueidentifier] NOT NULL,
	[KIV] [uniqueidentifier] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_NewTable] PRIMARY KEY NONCLUSTERED 
(
	[KID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = OFF, ALLOW_PAGE_LOCKS = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LibDirectory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LibDirectory](
	[DirectoryName] [nvarchar](254) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[IncludeSubDirs] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK98] PRIMARY KEY CLUSTERED 
(
	[DirectoryName] ASC,
	[UserID] ASC,
	[LibraryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LibEmail]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LibEmail](
	[EmailFolderEntryID] [nvarchar](200) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[FolderName] [nvarchar](250) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK99] PRIMARY KEY CLUSTERED 
(
	[EmailFolderEntryID] ASC,
	[UserID] ASC,
	[LibraryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Library]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Library](
	[UserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[isPublic] [nchar](1) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK52] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[LibraryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LibraryItems]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LibraryItems](
	[SourceGuid] [nvarchar](50) NOT NULL,
	[ItemTitle] [nvarchar](254) NULL,
	[ItemType] [nvarchar](50) NULL,
	[LibraryItemGuid] [nvarchar](50) NOT NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NULL,
	[LibraryOwnerUserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[AddedByUserGuidId] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK89] PRIMARY KEY NONCLUSTERED 
(
	[LibraryOwnerUserID] ASC,
	[LibraryName] ASC,
	[LibraryItemGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LibraryUsers]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LibraryUsers](
	[ReadOnly] [bit] NULL,
	[CreateAccess] [bit] NULL,
	[UpdateAccess] [bit] NULL,
	[DeleteAccess] [bit] NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[LibraryOwnerUserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[NotAddedAsGroupMember] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[SingleUser] [bit] NULL,
	[GroupUser] [bit] NULL,
	[GroupCnt] [int] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK87] PRIMARY KEY NONCLUSTERED 
(
	[LibraryOwnerUserID] ASC,
	[LibraryName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[License]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[License](
	[Agreement] [nvarchar](2000) NOT NULL,
	[VersionNbr] [int] NOT NULL,
	[ActivationDate] [datetime] NOT NULL,
	[InstallDate] [datetime] NOT NULL,
	[CustomerID] [nvarchar](50) NOT NULL,
	[CustomerName] [nvarchar](254) NOT NULL,
	[LicenseID] [int] IDENTITY(1,1) NOT NULL,
	[XrtNxr1] [nvarchar](50) NULL,
	[ServerIdentifier] [varchar](100) NULL,
	[SqlInstanceIdentifier] [varchar](100) NULL,
	[MachineID] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[ServerName] [nvarchar](254) NULL,
	[SqlInstanceName] [nvarchar](254) NULL,
	[SqlServerInstanceName] [nvarchar](254) NULL,
	[SqlServerMachineName] [nvarchar](254) NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoadProfile]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoadProfile](
	[ProfileName] [nvarchar](50) NOT NULL,
	[ProfileDesc] [nvarchar](254) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK101] PRIMARY KEY CLUSTERED 
(
	[ProfileName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LoadProfileItem]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoadProfileItem](
	[ProfileName] [nvarchar](50) NOT NULL,
	[SourceTypeCode] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK102] PRIMARY KEY NONCLUSTERED 
(
	[ProfileName] ASC,
	[SourceTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LoginClient]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginClient](
	[MachineName] [nvarchar](80) NOT NULL,
	[LoginDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LoginMachine]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginMachine](
	[MachineName] [nvarchar](80) NOT NULL,
	[LoginDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LoginUser]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoginUser](
	[LoginID] [nvarchar](50) NOT NULL,
	[LoginDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Logs]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logs](
	[UID] [nvarchar](50) NULL,
	[ErrorMsg] [nvarchar](max) NULL,
	[EntryDate] [datetime] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Machine]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Machine](
	[MachineName] [nvarchar](80) NOT NULL,
	[FQN] [nvarchar](254) NULL,
	[ContentType] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdate] [datetime] NULL,
	[SourceGuid] [nvarchar](50) NULL,
	[UserID] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MachineRegistered]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MachineRegistered](
	[MachineGuid] [uniqueidentifier] NOT NULL,
	[MachineName] [nvarchar](80) NOT NULL,
	[NetWorkName] [nvarchar](80) NOT NULL,
	[CreateDate] [datetime] NULL,
	[LastUpdate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK150] PRIMARY KEY NONCLUSTERED 
(
	[MachineGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [PK_MR01] UNIQUE NONCLUSTERED 
(
	[MachineName] ASC,
	[NetWorkName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MyTempTable]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MyTempTable](
	[docid] [int] NOT NULL,
	[key] [nvarchar](100) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[docid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OutlookFrom]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[OutlookFrom](
	[FromEmailAddr] [nvarchar](254) NOT NULL,
	[SenderName] [varchar](254) NOT NULL,
	[UserID] [varchar](25) NOT NULL,
	[Verified] [int] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [OutlookFrom_PK] PRIMARY KEY NONCLUSTERED 
(
	[FromEmailAddr] ASC,
	[SenderName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[OwnerHistory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OwnerHistory](
	[PreviousOwnerUserID] [nvarchar](50) NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[CurrentOwnerUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK76] PRIMARY KEY NONCLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PgmTrace]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PgmTrace](
	[StmtID] [nvarchar](50) NULL,
	[PgmName] [nvarchar](254) NULL,
	[Stmt] [nvarchar](max) NOT NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[CreateDate] [datetime] NULL,
	[ConnectiveGuid] [nvarchar](50) NULL,
	[UserID] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProcessFileAs]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProcessFileAs](
	[ExtCode] [nvarchar](50) NOT NULL,
	[ProcessExtCode] [nvarchar](50) NOT NULL,
	[Applied] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK__ProcessFileAs__5887175A] PRIMARY KEY CLUSTERED 
(
	[ExtCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProdCaptureItems]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProdCaptureItems](
	[CaptureItemsCode] [nvarchar](50) NOT NULL,
	[SendAlert] [bit] NULL,
	[ContainerType] [nvarchar](25) NOT NULL,
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[CorpName] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK21] PRIMARY KEY NONCLUSTERED 
(
	[CaptureItemsCode] ASC,
	[ContainerType] ASC,
	[CorpFuncName] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QtyDocs]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QtyDocs](
	[QtyDocCode] [nvarchar](10) NOT NULL,
	[Description] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK9] PRIMARY KEY NONCLUSTERED 
(
	[QtyDocCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Query]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Query](
	[RowGuid] [uniqueidentifier] NOT NULL,
	[EmailGuid] [nvarchar](50) NOT NULL,
	[SUBJECT] [nvarchar](2000) NULL,
	[SentTO] [ntext] NULL,
	[Body] [text] NULL,
	[Bcc] [ntext] NULL,
	[BillingInformation] [nvarchar](200) NULL,
	[CC] [ntext] NULL,
	[Companies] [nvarchar](2000) NULL,
	[CreationTime] [datetime2](3) NULL,
	[ReadReceiptRequested] [nvarchar](50) NULL,
	[ReceivedByName] [nvarchar](80) NOT NULL,
	[ReceivedTime] [datetime2](3) NOT NULL,
	[AllRecipients] [ntext] NULL,
	[UserID] [nvarchar](80) NOT NULL,
	[SenderEmailAddress] [nvarchar](80) NOT NULL,
	[SenderName] [nvarchar](100) NOT NULL,
	[Sensitivity] [nvarchar](50) NULL,
	[SentOn] [datetime2](3) NOT NULL,
	[MsgSize] [int] NULL,
	[DeferredDeliveryTime] [datetime2](3) NULL,
	[EntryID] [varchar](150) NULL,
	[ExpiryTime] [datetime2](3) NULL,
	[LastModificationTime] [datetime2](3) NULL,
	[EmailImage] [image] NULL,
	[Accounts] [nvarchar](2000) NULL,
	[RowID] [int] NOT NULL,
	[ShortSubj] [nvarchar](250) NULL,
	[SourceTypeCode] [nvarchar](50) NULL,
	[OriginalFolder] [nvarchar](254) NULL,
	[StoreID] [varchar](750) NULL,
	[isPublic] [nchar](1) NULL,
	[RetentionExpirationDate] [datetime2](3) NULL,
	[IsPublicPreviousState] [nchar](1) NULL,
	[isAvailable] [nchar](1) NULL,
	[CurrMailFolderID] [nvarchar](300) NULL,
	[isPerm] [nchar](1) NULL,
	[isMaster] [nchar](1) NULL,
	[CreationDate] [datetime2](3) NULL,
	[NbrAttachments] [int] NULL,
	[CRC] [nvarchar](50) NULL,
	[Description] [ntext] NULL,
	[KeyWords] [nvarchar](2000) NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[EmailIdentifier] [nvarchar](450) NULL,
	[ConvertEmlToMSG] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime2](3) NULL,
	[RowLastModDate] [datetime2](3) NULL,
	[UIDL] [int] NULL,
	[RecLen] [float] NULL,
	[RecHash] [nvarchar](50) NOT NULL,
	[OriginalSize] [int] NULL,
	[CompressedSize] [int] NULL,
	[txStartTime] [datetime2](3) NULL,
	[txEndTime] [datetime2](3) NULL,
	[txTotalTime] [float] NULL,
	[TransmitTime] [float] NULL,
	[FileAttached] [bit] NULL,
	[BPS] [float] NULL,
	[RepoName] [nvarchar](50) NULL,
	[HashFile] [nvarchar](50) NULL,
	[HashName] [nvarchar](50) NULL,
	[ContainsAttachment] [char](1) NULL,
	[NbrAttachment] [int] NULL,
	[NbrZipFiles] [int] NULL,
	[NbrZipFilesCnt] [int] NULL,
	[PdfIsSearchable] [char](1) NULL,
	[PdfOcrRequired] [char](1) NULL,
	[PdfOcrSuccess] [char](1) NULL,
	[PdfOcrTextExtracted] [char](1) NULL,
	[PdfPages] [int] NULL,
	[PdfImages] [int] NULL,
	[MachineID] [nvarchar](50) NULL,
	[notes] [nvarchar](4000) NULL,
	[NbrOccurances] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[QuickDirectory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[QuickDirectory](
	[UserID] [nvarchar](50) NOT NULL,
	[IncludeSubDirs] [char](1) NULL,
	[FQN] [varchar](254) NOT NULL,
	[DB_ID] [nvarchar](50) NOT NULL,
	[VersionFiles] [char](1) NULL,
	[ckMetaData] [nchar](1) NULL,
	[ckPublic] [nchar](1) NULL,
	[ckDisableDir] [nchar](1) NULL,
	[QuickRefEntry] [bit] NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PKII2QD] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[FQN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[QuickRef]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuickRef](
	[UserID] [nvarchar](50) NOT NULL,
	[QuickRefName] [nvarchar](50) NULL,
	[QuickRefIdNbr] [int] IDENTITY(1,1) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK91] PRIMARY KEY CLUSTERED 
(
	[QuickRefIdNbr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[QuickRefItems]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuickRefItems](
	[QuickRefIdNbr] [int] NULL,
	[FQN] [nvarchar](300) NULL,
	[QuickRefItemGuid] [nvarchar](50) NOT NULL,
	[SourceGuid] [nvarchar](50) NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NULL,
	[Author] [nvarchar](300) NULL,
	[Description] [nvarchar](max) NULL,
	[Keywords] [nvarchar](2000) NULL,
	[FileName] [nvarchar](80) NULL,
	[DirName] [nvarchar](254) NULL,
	[MarkedForDeletion] [bit] NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[MetadataTag] [nvarchar](50) NULL,
	[MetadataValue] [nvarchar](50) NULL,
	[Library] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK93] PRIMARY KEY CLUSTERED 
(
	[QuickRefItemGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Recipients]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Recipients](
	[Recipient] [nvarchar](254) NOT NULL,
	[EmailGuid] [nvarchar](50) NOT NULL,
	[TypeRecp] [nchar](10) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK32A] PRIMARY KEY CLUSTERED 
(
	[Recipient] ASC,
	[EmailGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RepeatData]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RepeatData](
	[RepeatDataCode] [nvarchar](50) NOT NULL,
	[RepeatDataDesc] [nvarchar](4000) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK14] PRIMARY KEY CLUSTERED 
(
	[RepeatDataCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[reports]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reports](
	[rptDisplayname] [nvarchar](80) NOT NULL,
	[rptDesc] [nvarchar](1000) NOT NULL,
	[rptFqn] [nvarchar](254) NOT NULL,
	[rptCreatedForCustomerID] [nvarchar](50) NULL,
	[rptFqnDate] [datetime] NULL,
	[rptExists] [bit] NULL,
	[CreateDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PKreports] PRIMARY KEY CLUSTERED 
(
	[rptFqn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Repository]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Repository](
	[ConnectionName] [nvarchar](50) NOT NULL,
	[ConnectionData] [nvarchar](2000) NULL,
	[ConnectionDataThesaurus] [nvarchar](2000) NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RestorationHistory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RestorationHistory](
	[SourceType] [nvarchar](50) NOT NULL,
	[SourceGuid] [nvarchar](50) NOT NULL,
	[OriginalCrc] [nvarchar](50) NOT NULL,
	[RestoredCrc] [nvarchar](50) NOT NULL,
	[RestorationDate] [nchar](10) NOT NULL,
	[RestorationID] [int] IDENTITY(1,1) NOT NULL,
	[RestoredBy] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RestoreQueue]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[RestoreQueue](
	[ContentGuid] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[MachineID] [nvarchar](50) NOT NULL,
	[FQN] [nvarchar](2500) NULL,
	[FileSize] [int] NULL,
	[ContentType] [varchar](15) NOT NULL,
	[Preview] [bit] NULL,
	[Restore] [bit] NULL,
	[ProcessingCompleted] [bit] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[ProcessedDate] [datetime] NULL,
	[StartDownloadTime] [datetime] NULL,
	[EndDownloadTime] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RestoreQueueHistory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[RestoreQueueHistory](
	[ContentGuid] [nvarchar](50) NOT NULL,
	[UseriD] [nvarchar](50) NOT NULL,
	[MachineID] [nvarchar](50) NOT NULL,
	[FQN] [nvarchar](2500) NULL,
	[FileSize] [int] NULL,
	[ContentType] [varchar](15) NOT NULL,
	[Preview] [bit] NULL,
	[Restore] [bit] NULL,
	[ProcessingCompleted] [bit] NOT NULL,
	[EntryDate] [datetime] NOT NULL,
	[ProcessedDate] [datetime] NULL,
	[StartDownloadTime] [datetime] NULL,
	[EndDownloadTime] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Retention]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Retention](
	[RetentionCode] [nvarchar](50) NOT NULL,
	[RetentionDesc] [nvarchar](max) NULL,
	[RetentionUnits] [int] NOT NULL,
	[RetentionAction] [nvarchar](50) NOT NULL,
	[ManagerID] [nvarchar](50) NULL,
	[ManagerName] [nvarchar](200) NULL,
	[DaysWarning] [int] NULL,
	[ResponseRequired] [char](1) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RetentionPeriod] [nvarchar](10) NULL,
 CONSTRAINT [PK16] PRIMARY KEY CLUSTERED 
(
	[RetentionCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RetentionTemp]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RetentionTemp](
	[UserID] [nvarchar](50) NOT NULL,
	[ContentGuid] [nvarchar](50) NOT NULL,
	[TypeContent] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RiskLevel]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RiskLevel](
	[RiskCode] [char](10) NULL,
	[Description] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RSSChildren]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RSSChildren](
	[RssRowGuid] [nchar](50) NOT NULL,
	[SourceGuid] [nchar](50) NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RssPull]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RssPull](
	[RssName] [nvarchar](80) NULL,
	[RssUrl] [nvarchar](400) NULL,
	[UserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[isPublic] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RunParms]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RunParms](
	[Parm] [nvarchar](250) NOT NULL,
	[ParmValue] [nvarchar](50) NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[ParmDesc] [nvarchar](500) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PKI8] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[Parm] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RuntimeErrors]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RuntimeErrors](
	[ErrorMsg] [nvarchar](max) NULL,
	[StackTrace] [nvarchar](max) NULL,
	[EntryDate] [datetime] NULL,
	[IdNbr] [nvarchar](50) NULL,
	[EntrySeq] [int] IDENTITY(1,1) NOT NULL,
	[ConnectiveGuid] [nvarchar](50) NULL,
	[UserID] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SavedItems]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SavedItems](
	[Userid] [nvarchar](50) NOT NULL,
	[SaveName] [nvarchar](50) NOT NULL,
	[SaveTypeCode] [nvarchar](50) NOT NULL,
	[ValName] [nvarchar](50) NOT NULL,
	[ValValue] [nvarchar](254) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SearchHistory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchHistory](
	[SearchSql] [nvarchar](max) NULL,
	[SearchDate] [datetime] NULL,
	[UserID] [nvarchar](50) NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ReturnedRows] [int] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[CalledFrom] [nvarchar](50) NULL,
	[TypeSearch] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[SearchParms] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SearchSchedule]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchSchedule](
	[SearchName] [nvarchar](50) NOT NULL,
	[NotificationSMS] [nvarchar](20) NULL,
	[SearchDesc] [nvarchar](2000) NOT NULL,
	[OwnerID] [nvarchar](50) NOT NULL,
	[SearchQuery] [nvarchar](max) NOT NULL,
	[SendToEmail] [nvarchar](2000) NULL,
	[ScheduleUnit] [nchar](10) NOT NULL,
	[ScheduleHour] [nchar](10) NULL,
	[ScheduleDaysOfWeek] [nchar](50) NULL,
	[ScheduleDaysOfMonth] [nchar](70) NULL,
	[ScheduleMonthOfQtr] [nchar](10) NULL,
	[StartToRunDate] [datetime] NULL,
	[EndRunDate] [datetime] NULL,
	[SearchParameters] [nvarchar](4000) NULL,
	[LastRunDate] [datetime] NULL,
	[NumberOfExecutions] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastModDate] [datetime] NOT NULL,
	[ScheduleHourInterval] [int] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[Carrier] [nvarchar](75) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SearchUser]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearchUser](
	[SearchName] [nvarchar](75) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[SearchParms] [nvarchar](max) NOT NULL,
	[RowGuid] [uniqueidentifier] NOT NULL,
	[CreateDate] [datetime] NULL,
	[LastUsedDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SearhParmsHistory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SearhParmsHistory](
	[UserID] [nvarchar](50) NOT NULL,
	[SearchDate] [datetime] NOT NULL,
	[Screen] [nvarchar](50) NOT NULL,
	[QryParms] [nvarchar](max) NOT NULL,
	[EntryID] [int] IDENTITY(1,1) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ServiceActivity]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ServiceActivity](
	[StmtID] [int] NOT NULL,
	[Msg] [varchar](max) NOT NULL,
	[EntryTime] [datetime] NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SessionID]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SessionID](
	[UserID] [nvarchar](100) NOT NULL,
	[SessionID] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime2](7) NOT NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_SessionID] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[SessionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SessionVar]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SessionVar](
	[SessionGuid] [varchar](50) NOT NULL,
	[SessionVar] [varchar](50) NOT NULL,
	[SessionVarVal] [nvarchar](254) NULL,
	[CreateDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SkipWords]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SkipWords](
	[tgtWord] [nvarchar](18) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK22] PRIMARY KEY NONCLUSTERED 
(
	[tgtWord] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SourceAttribute]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SourceAttribute](
	[AttributeValue] [nvarchar](254) NULL,
	[AttributeName] [nvarchar](50) NOT NULL,
	[SourceGuid] [nvarchar](50) NOT NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NOT NULL,
	[SourceTypeCode] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK35] PRIMARY KEY NONCLUSTERED 
(
	[AttributeName] ASC,
	[SourceGuid] ASC,
	[DataSourceOwnerUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SourceContainer]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SourceContainer](
	[ContainerType] [nvarchar](25) NOT NULL,
	[ContainerDesc] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK3] PRIMARY KEY NONCLUSTERED 
(
	[ContainerType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SourceInjector]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SourceInjector](
	[ClassName] [varchar](80) NOT NULL,
	[FuncName] [varchar](80) NULL,
	[LineID] [int] NOT NULL,
	[LastExecDate] [datetime] NULL,
	[Executed] [bit] NULL,
	[NbrExecutions] [int] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK192] PRIMARY KEY CLUSTERED 
(
	[LineID] ASC,
	[ClassName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SourceType]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SourceType](
	[SourceTypeCode] [nvarchar](50) NOT NULL,
	[StoreExternal] [bit] NULL,
	[SourceTypeDesc] [nvarchar](254) NULL,
	[Indexable] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK34] PRIMARY KEY CLUSTERED 
(
	[SourceTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SqlDataTypes]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SqlDataTypes](
	[_nvarchar] [nchar](10) NULL,
	[_bigint] [bigint] NULL,
	[_binary] [binary](50) NULL,
	[_bit] [bit] NULL,
	[_char] [char](10) NULL,
	[_datetime] [datetime] NULL,
	[_datetimeoffset] [datetimeoffset](7) NULL,
	[_decimal] [decimal](18, 2) NULL,
	[_float] [float] NULL,
	[_geography] [geography] NULL,
	[_geometry] [geometry] NULL,
	[_hierarchyid] [hierarchyid] NULL,
	[_image] [image] NULL,
	[_int] [int] NULL,
	[_money] [money] NULL,
	[_nchar] [nchar](10) NULL,
	[_ntext] [ntext] NULL,
	[_numeric] [numeric](18, 2) NULL,
	[_nvarchar_max] [nvarchar](max) NULL,
	[_real] [real] NULL,
	[_smalldatetime] [smalldatetime] NULL,
	[_smallint] [smallint] NULL,
	[_smallmoney] [smallmoney] NULL,
	[_sql_variant] [sql_variant] NULL,
	[_text] [text] NULL,
	[_time7] [time](7) NULL,
	[_timestamp] [timestamp] NULL,
	[_tinyint] [tinyint] NULL,
	[_uniqueidentifier] [uniqueidentifier] NULL,
	[_varbinary] [varbinary](50) NULL,
	[_varchar] [varchar](50) NULL,
	[_varcharMAX] [varchar](max) NULL,
	[_xml] [xml] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StagedSQL]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StagedSQL](
	[ExecutionID] [varchar](50) NOT NULL,
	[SqlStmt] [nvarchar](max) NOT NULL,
	[EntryTime] [datetime] NULL,
	[StmtID] [int] IDENTITY(1,1) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StatsClick]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatsClick](
	[LocationID] [int] NOT NULL,
	[ClickDate] [datetime] NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[ClickID] [int] IDENTITY(1,1) NOT NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL,
 CONSTRAINT [PK_StatsClick] PRIMARY KEY CLUSTERED 
(
	[ClickID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StatSearch]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[StatSearch](
	[WordID] [int] NOT NULL,
	[SearchDate] [datetime] NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[TypeSearch] [char](1) NOT NULL,
	[ClickID] [int] IDENTITY(1,1) NOT NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL,
 CONSTRAINT [PK_StatSearch] PRIMARY KEY CLUSTERED 
(
	[ClickID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[StatWord]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatWord](
	[WordID] [int] IDENTITY(1,1) NOT NULL,
	[Word] [nvarchar](100) NOT NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL,
 CONSTRAINT [PK_StatWord] PRIMARY KEY CLUSTERED 
(
	[Word] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Storage]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Storage](
	[StoreCode] [nvarchar](50) NOT NULL,
	[StoreDesc] [nvarchar](18) NULL,
	[CreateDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK17] PRIMARY KEY CLUSTERED 
(
	[StoreCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StructuredData]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StructuredData](
	[SourceGuid] [nvarchar](50) NOT NULL,
	[ColumnName] [nvarchar](120) NOT NULL,
	[ColVal] [nvarchar](50) NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[StructuredDataProcessed]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StructuredDataProcessed](
	[EcmGuid] [nvarchar](50) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SubDir]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SubDir](
	[UserID] [nvarchar](50) NOT NULL,
	[SUBFQN] [nvarchar](254) NOT NULL,
	[FQN] [varchar](254) NOT NULL,
	[ckPublic] [nchar](1) NULL,
	[ckDisableDir] [nchar](1) NULL,
	[OcrDirectory] [nchar](1) NULL,
	[VersionFiles] [nchar](1) NULL,
	[isSysDefault] [bit] NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PKI14] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[FQN] ASC,
	[SUBFQN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SubLibrary]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubLibrary](
	[UserID] [nvarchar](50) NOT NULL,
	[SubUserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[SubLibraryName] [nvarchar](80) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK90] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[LibraryName] ASC,
	[SubUserID] ASC,
	[SubLibraryName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SystemMessage]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemMessage](
	[UserID] [nvarchar](50) NULL,
	[EntryDate] [datetime] NULL,
	[EntryGuid] [nvarchar](50) NULL,
	[EntryMsg] [nvarchar](max) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SystemParms]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SystemParms](
	[SysParm] [nvarchar](50) NULL,
	[SysParmDesc] [nvarchar](250) NULL,
	[SysParmVal] [nvarchar](250) NULL,
	[flgActive] [nchar](1) NULL,
	[isDirectory] [nchar](1) NULL,
	[isEmailFolder] [nchar](1) NULL,
	[flgAllSubDirs] [nchar](1) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TempUserLibItems]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempUserLibItems](
	[UserID] [nvarchar](50) NOT NULL,
	[SourceGuid] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TestTbl]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TestTbl](
	[TestCol] [varchar](50) NULL,
	[iCol] [int] IDENTITY(1,1) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Trace]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trace](
	[EntryDate] [datetime] NOT NULL,
	[LogEntry] [nvarchar](max) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[txTimes]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[txTimes](
	[StmtID] [int] NOT NULL,
	[txTime] [decimal](12, 4) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UD_Qty]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UD_Qty](
	[Code] [char](10) NOT NULL,
	[Description] [char](10) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK4] PRIMARY KEY NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[upgrade_status]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[upgrade_status](
	[name] [varchar](30) NOT NULL,
	[status] [varchar](10) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UrlList]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UrlList](
	[URL] [nvarchar](425) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UrlRejection]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UrlRejection](
	[RejectionPattern] [nvarchar](50) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserCurrParm]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserCurrParm](
	[UserID] [nvarchar](50) NOT NULL,
	[ParmName] [nvarchar](50) NOT NULL,
	[ParmVal] [nvarchar](2000) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserGridState]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserGridState](
	[UserID] [nvarchar](50) NOT NULL,
	[ScreenName] [nvarchar](50) NOT NULL,
	[GridName] [nvarchar](50) NOT NULL,
	[ColName] [nvarchar](50) NULL,
	[ColOrder] [int] NULL,
	[ColWidth] [int] NULL,
	[ColVisible] [bit] NULL,
	[ColReadOnly] [bit] NULL,
	[ColSortOrder] [int] NULL,
	[ColSortAsc] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserGroup]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserGroup](
	[GroupOwnerUserID] [nvarchar](50) NOT NULL,
	[GroupName] [nvarchar](80) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK43] PRIMARY KEY CLUSTERED 
(
	[GroupOwnerUserID] ASC,
	[GroupName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserReassignHist]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserReassignHist](
	[PrevUserID] [nvarchar](50) NOT NULL,
	[PrevUserName] [nvarchar](50) NULL,
	[PrevEmailAddress] [nvarchar](254) NULL,
	[PrevUserPassword] [nvarchar](254) NULL,
	[PrevAdmin] [nchar](1) NULL,
	[PrevisActive] [nchar](1) NULL,
	[PrevUserLoginID] [nvarchar](50) NOT NULL,
	[ReassignedUserID] [nvarchar](50) NULL,
	[ReassignedUserName] [nvarchar](50) NOT NULL,
	[ReassignedEmailAddress] [nvarchar](254) NULL,
	[ReassignedUserPassword] [nvarchar](254) NULL,
	[ReassignedAdmin] [nchar](1) NULL,
	[ReassignedisActive] [nchar](1) NULL,
	[ReassignedUserLoginID] [nvarchar](50) NULL,
	[ReassignmentDate] [datetime] NOT NULL,
	[RowID] [uniqueidentifier] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [nvarchar](50) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[EmailAddress] [nvarchar](254) NULL,
	[UserPassword] [nvarchar](254) NULL,
	[Admin] [nchar](1) NULL,
	[isActive] [nchar](1) NULL,
	[UserLoginID] [nvarchar](50) NULL,
	[ClientOnly] [bit] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[ActiveGuid] [uniqueidentifier] NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK41] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserScreenState]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserScreenState](
	[ScreenName] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[ParmName] [nvarchar](50) NOT NULL,
	[ParmVal] [nvarchar](2000) NULL,
	[ParmDataType] [nvarchar](15) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserSearchState]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserSearchState](
	[SearchID] [int] NOT NULL,
	[ScreenName] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[ParmName] [nvarchar](50) NOT NULL,
	[ParmVal] [nvarchar](2000) NULL,
	[ParmDataType] [nvarchar](2000) NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RowNbr] [int] IDENTITY(1,1) NOT NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[VersionInfo]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VersionInfo](
	[Product] [nvarchar](50) NOT NULL,
	[ProductVersion] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Volitility]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Volitility](
	[VolitilityCode] [nvarchar](50) NOT NULL,
	[VolitilityDesc] [nvarchar](18) NULL,
	[CreateDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK19] PRIMARY KEY CLUSTERED 
(
	[VolitilityCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WebScreen]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WebScreen](
	[WebScreen] [nvarchar](80) NULL,
	[WebUrl] [nvarchar](400) NULL,
	[UserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[isPublic] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WebSite]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[WebSite](
	[WebSite] [nvarchar](80) NULL,
	[WebUrl] [nvarchar](400) NULL,
	[UserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[RowGuid] [uniqueidentifier] NULL,
	[RepoName] [nvarchar](50) NULL,
	[Depth] [int] NULL,
	[Width] [int] NULL,
	[RetentionCode] [nvarchar](50) NULL,
	[isPublic] [char](1) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[WebSource]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WebSource](
	[SourceGuid] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[SourceName] [nvarchar](254) NULL,
	[SourceImage] [image] NULL,
	[SourceTypeCode] [nvarchar](50) NOT NULL,
	[FileLength] [int] NULL,
	[LastWriteTime] [datetime] NULL,
	[RetentionExpirationDate] [datetime] NULL,
	[Description] [nvarchar](max) NULL,
	[KeyWords] [nvarchar](2000) NULL,
	[Notes] [nvarchar](2000) NULL,
	[CreationDate] [datetime] NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK_WebSource] PRIMARY KEY NONCLUSTERED 
(
	[SourceGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ZippedFiles]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ZippedFiles](
	[ContentGUID] [nvarchar](50) NOT NULL,
	[SourceTypeCode] [nvarchar](50) NULL,
	[SourceImage] [image] NULL,
	[SourceGuid] [nvarchar](50) NOT NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NOT NULL,
	[HiveConnectionName] [nvarchar](50) NULL,
	[HiveActive] [bit] NULL,
	[RepoSvrName] [nvarchar](254) NULL,
	[RowCreationDate] [datetime] NULL,
	[RowLastModDate] [datetime] NULL,
	[RepoName] [nvarchar](50) NULL,
	[RowGuid] [uniqueidentifier] NULL,
 CONSTRAINT [PK88] PRIMARY KEY CLUSTERED 
(
	[ContentGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  View [dbo].[gv_ActiveSearchGuids]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ActiveSearchGuids]
AS
/*
** Select all rows from the ActiveSearchGuids table
** and the lookup expressions defined for associated tables
*/
SELECT [ActiveSearchGuids].* FROM [ActiveSearchGuids]


GO
/****** Object:  View [dbo].[gv_ArchiveFrom]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ArchiveFrom]
AS
/*
** Select all rows from the ArchiveFrom table
** and the lookup expressions defined for associated tables
*/
SELECT [ArchiveFrom].* FROM [ArchiveFrom]


GO
/****** Object:  View [dbo].[gv_ArchiveHist]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ArchiveHist]
AS
/*
** Select all rows from the ArchiveHist table
** and the lookup expressions defined for associated tables
*/
SELECT [ArchiveHist].* FROM [ArchiveHist]


GO
/****** Object:  View [dbo].[gv_ArchiveHistContentType]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ArchiveHistContentType]
AS
/*
** Select all rows from the ArchiveHistContentType table
** and the lookup expressions defined for associated tables
*/
SELECT [ArchiveHistContentType].* FROM [ArchiveHistContentType]


GO
/****** Object:  View [dbo].[gv_ArchiveStats]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ArchiveStats]
AS
/*
** Select all rows from the ArchiveStats table
** and the lookup expressions defined for associated tables
*/
SELECT [ArchiveStats].* FROM [ArchiveStats]


GO
/****** Object:  View [dbo].[gv_AssignableUserParameters]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_AssignableUserParameters]
AS
/*
** Select all rows from the AssignableUserParameters table
** and the lookup expressions defined for associated tables
*/
SELECT [AssignableUserParameters].* FROM [AssignableUserParameters]


GO
/****** Object:  View [dbo].[gv_AttachmentType]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_AttachmentType]
AS
/*
** Select all rows from the AttachmentType table
** and the lookup expressions defined for associated tables
*/
SELECT [AttachmentType].* FROM [AttachmentType]


GO
/****** Object:  View [dbo].[gv_AttributeDatatype]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_AttributeDatatype]
AS
/*
** Select all rows from the AttributeDatatype table
** and the lookup expressions defined for associated tables
*/
SELECT [AttributeDatatype].* FROM [AttributeDatatype]


GO
/****** Object:  View [dbo].[gv_Attributes]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Attributes]
AS
/*
** Select all rows from the Attributes table
** and the lookup expressions defined for associated tables
*/
SELECT [Attributes].* FROM [Attributes]


GO
/****** Object:  View [dbo].[gv_AvailFileTypes]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_AvailFileTypes]
AS
/*
** Select all rows from the AvailFileTypes table
** and the lookup expressions defined for associated tables
*/
SELECT [AvailFileTypes].* FROM [AvailFileTypes]


GO
/****** Object:  View [dbo].[gv_AvailFileTypesUndefined]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_AvailFileTypesUndefined]
AS
/*
** Select all rows from the AvailFileTypesUndefined table
** and the lookup expressions defined for associated tables
*/
SELECT [AvailFileTypesUndefined].* FROM [AvailFileTypesUndefined]


GO
/****** Object:  View [dbo].[gv_BusinessFunctionJargon]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_BusinessFunctionJargon]
AS
/*
** Select all rows from the BusinessFunctionJargon table
** and the lookup expressions defined for associated tables
*/
SELECT [BusinessFunctionJargon].* FROM [BusinessFunctionJargon]


GO
/****** Object:  View [dbo].[gv_BusinessJargonCode]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_BusinessJargonCode]
AS
/*
** Select all rows from the BusinessJargonCode table
** and the lookup expressions defined for associated tables
*/
SELECT [BusinessJargonCode].* FROM [BusinessJargonCode]


GO
/****** Object:  View [dbo].[gv_CaptureItems]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_CaptureItems]
AS
/*
** Select all rows from the CaptureItems table
** and the lookup expressions defined for associated tables
*/
SELECT [CaptureItems].* FROM [CaptureItems]


GO
/****** Object:  View [dbo].[gv_ContactFrom]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ContactFrom]
AS
/*
** Select all rows from the ContactFrom table
** and the lookup expressions defined for associated tables
*/
SELECT [ContactFrom].* FROM [ContactFrom]


GO
/****** Object:  View [dbo].[gv_ContactsArchive]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ContactsArchive]
AS
/*
** Select all rows from the ContactsArchive table
** and the lookup expressions defined for associated tables
*/
SELECT [ContactsArchive].* FROM [ContactsArchive]


GO
/****** Object:  View [dbo].[gv_ContainerStorage]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ContainerStorage]
AS
/*
** Select all rows from the ContainerStorage table
** and the lookup expressions defined for associated tables
*/
SELECT [ContainerStorage].* FROM [ContainerStorage]


GO
/****** Object:  View [dbo].[gv_ConvertedDocs]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ConvertedDocs]
AS
/*
** Select all rows from the ConvertedDocs table
** and the lookup expressions defined for associated tables
*/
SELECT [ConvertedDocs].* FROM [ConvertedDocs]


GO
/****** Object:  View [dbo].[gv_CoOwner]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_CoOwner]
AS
/*
** Select all rows from the CoOwner table
** and the lookup expressions defined for associated tables
*/
SELECT [CoOwner].* FROM [CoOwner]


GO
/****** Object:  View [dbo].[gv_CorpContainer]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_CorpContainer]
AS
/*
** Select all rows from the CorpContainer table
** and the lookup expressions defined for associated tables
*/
SELECT [CorpContainer].* FROM [CorpContainer]


GO
/****** Object:  View [dbo].[gv_CorpFunction]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_CorpFunction]
AS
/*
** Select all rows from the CorpFunction table
** and the lookup expressions defined for associated tables
*/
SELECT [CorpFunction].* FROM [CorpFunction]


GO
/****** Object:  View [dbo].[gv_Corporation]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Corporation]
AS
/*
** Select all rows from the Corporation table
** and the lookup expressions defined for associated tables
*/
SELECT [Corporation].* FROM [Corporation]


GO
/****** Object:  View [dbo].[gv_Databases]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Databases]
AS
/*
** Select all rows from the Databases table
** and the lookup expressions defined for associated tables
*/
SELECT [Databases].* FROM [Databases]


GO
/****** Object:  View [dbo].[gv_DataOwners]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_DataOwners]
AS
/*
** Select all rows from the DataOwners table
** and the lookup expressions defined for associated tables
*/
SELECT [DataOwners].* FROM [DataOwners]


GO
/****** Object:  View [dbo].[gv_DataSourceCheckOut]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_DataSourceCheckOut]
AS
/*
** Select all rows from the DataSourceCheckOut table
** and the lookup expressions defined for associated tables
*/
SELECT [DataSourceCheckOut].* FROM [DataSourceCheckOut]


GO
/****** Object:  View [dbo].[gv_DataSourceRestoreHistory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_DataSourceRestoreHistory]
AS
/*
** Select all rows from the DataSourceRestoreHistory table
** and the lookup expressions defined for associated tables
*/
SELECT [DataSourceRestoreHistory].* FROM [DataSourceRestoreHistory]


GO
/****** Object:  View [dbo].[gv_DataTypeCodes]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_DataTypeCodes]
AS
/*
** Select all rows from the DataTypeCodes table
** and the lookup expressions defined for associated tables
*/
SELECT [DataTypeCodes].* FROM [DataTypeCodes]


GO
/****** Object:  View [dbo].[gv_DB_UpdateHist]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_DB_UpdateHist]
AS
/*
** Select all rows from the DB_UpdateHist table
** and the lookup expressions defined for associated tables
*/
SELECT [DB_UpdateHist].* FROM [DB_UpdateHist]


GO
/****** Object:  View [dbo].[gv_DB_Updates]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_DB_Updates]
AS
/*
** Select all rows from the DB_Updates table
** and the lookup expressions defined for associated tables
*/
SELECT [DB_Updates].* FROM [DB_Updates]


GO
/****** Object:  View [dbo].[gv_DeleteFrom]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_DeleteFrom]
AS
/*
** Select all rows from the DeleteFrom table
** and the lookup expressions defined for associated tables
*/
SELECT [DeleteFrom].* FROM [DeleteFrom]


GO
/****** Object:  View [dbo].[gv_Directory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Directory]
AS
/*
** Select all rows from the Directory table
** and the lookup expressions defined for associated tables
*/
SELECT [Directory].* FROM [Directory]


GO
/****** Object:  View [dbo].[gv_EcmUser]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_EcmUser]
AS
/*
** Select all rows from the EcmUser table
** and the lookup expressions defined for associated tables
*/
SELECT [EcmUser].* FROM [EcmUser]


GO
/****** Object:  View [dbo].[gv_EmailArchParms]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_EmailArchParms]
AS
/*
** Select all rows from the EmailArchParms table
** and the lookup expressions defined for associated tables
*/
SELECT [EmailArchParms].* FROM [EmailArchParms]


GO
/****** Object:  View [dbo].[gv_EmailAttachmentSearchList]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_EmailAttachmentSearchList]
AS
/*
** Select all rows from the EmailAttachmentSearchList table
** and the lookup expressions defined for associated tables
*/
SELECT [EmailAttachmentSearchList].* FROM [EmailAttachmentSearchList]


GO
/****** Object:  View [dbo].[gv_EmailFolder]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_EmailFolder]
AS
/*
** Select all rows from the EmailFolder table
** and the lookup expressions defined for associated tables
*/
SELECT [EmailFolder].* FROM [EmailFolder]


GO
/****** Object:  View [dbo].[gv_EmailToDelete]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_EmailToDelete]
AS
/*
** Select all rows from the EmailToDelete table
** and the lookup expressions defined for associated tables
*/
SELECT [EmailToDelete].* FROM [EmailToDelete]


GO
/****** Object:  View [dbo].[gv_ExcludedFiles]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ExcludedFiles]
AS
/*
** Select all rows from the ExcludedFiles table
** and the lookup expressions defined for associated tables
*/
SELECT [ExcludedFiles].* FROM [ExcludedFiles]


GO
/****** Object:  View [dbo].[gv_ExcludeFrom]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ExcludeFrom]
AS
/*
** Select all rows from the ExcludeFrom table
** and the lookup expressions defined for associated tables
*/
SELECT [ExcludeFrom].* FROM [ExcludeFrom]


GO
/****** Object:  View [dbo].[gv_FilesToDelete]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_FilesToDelete]
AS
/*
** Select all rows from the FilesToDelete table
** and the lookup expressions defined for associated tables
*/
SELECT [FilesToDelete].* FROM [FilesToDelete]


GO
/****** Object:  View [dbo].[gv_FUncSkipWords]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_FUncSkipWords]
AS
/*
** Select all rows from the FUncSkipWords table
** and the lookup expressions defined for associated tables
*/
SELECT [FUncSkipWords].* FROM [FUncSkipWords]


GO
/****** Object:  View [dbo].[gv_FunctionProdJargon]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_FunctionProdJargon]
AS
/*
** Select all rows from the FunctionProdJargon table
** and the lookup expressions defined for associated tables
*/
SELECT [FunctionProdJargon].* FROM [FunctionProdJargon]


GO
/****** Object:  View [dbo].[gv_GlobalSeachResults]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_GlobalSeachResults]
AS
/*
** Select all rows from the GlobalSeachResults table
** and the lookup expressions defined for associated tables
*/
SELECT [GlobalSeachResults].* FROM [GlobalSeachResults]


GO
/****** Object:  View [dbo].[gv_GroupLibraryAccess]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_GroupLibraryAccess]
AS
/*
** Select all rows from the GroupLibraryAccess table
** and the lookup expressions defined for associated tables
*/
SELECT [GroupLibraryAccess].* FROM [GroupLibraryAccess]


GO
/****** Object:  View [dbo].[gv_GroupUsers]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_GroupUsers]
AS
/*
** Select all rows from the GroupUsers table
** and the lookup expressions defined for associated tables
*/
SELECT [GroupUsers].* FROM [GroupUsers]


GO
/****** Object:  View [dbo].[gv_HelpText]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_HelpText]
AS
/*
** Select all rows from the HelpText table
** and the lookup expressions defined for associated tables
*/
SELECT [HelpText].* FROM [HelpText]


GO
/****** Object:  View [dbo].[gv_HelpTextUser]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_HelpTextUser]
AS
/*
** Select all rows from the HelpTextUser table
** and the lookup expressions defined for associated tables
*/
SELECT [HelpTextUser].* FROM [HelpTextUser]


GO
/****** Object:  View [dbo].[gv_ImageTypeCodes]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ImageTypeCodes]
AS
/*
** Select all rows from the ImageTypeCodes table
** and the lookup expressions defined for associated tables
*/
SELECT [ImageTypeCodes].* FROM [ImageTypeCodes]


GO
/****** Object:  View [dbo].[gv_IncludedFiles]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_IncludedFiles]
AS
/*
** Select all rows from the IncludedFiles table
** and the lookup expressions defined for associated tables
*/
SELECT [IncludedFiles].* FROM [IncludedFiles]


GO
/****** Object:  View [dbo].[gv_IncludeImmediate]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_IncludeImmediate]
AS
/*
** Select all rows from the IncludeImmediate table
** and the lookup expressions defined for associated tables
*/
SELECT [IncludeImmediate].* FROM [IncludeImmediate]


GO
/****** Object:  View [dbo].[gv_InformationProduct]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_InformationProduct]
AS
/*
** Select all rows from the InformationProduct table
** and the lookup expressions defined for associated tables
*/
SELECT [InformationProduct].* FROM [InformationProduct]


GO
/****** Object:  View [dbo].[gv_InformationType]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_InformationType]
AS
/*
** Select all rows from the InformationType table
** and the lookup expressions defined for associated tables
*/
SELECT [InformationType].* FROM [InformationType]


GO
/****** Object:  View [dbo].[gv_JargonWords]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_JargonWords]
AS
/*
** Select all rows from the JargonWords table
** and the lookup expressions defined for associated tables
*/
SELECT [JargonWords].* FROM [JargonWords]


GO
/****** Object:  View [dbo].[gv_LibDirectory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_LibDirectory]
AS
/*
** Select all rows from the LibDirectory table
** and the lookup expressions defined for associated tables
*/
SELECT [LibDirectory].* FROM [LibDirectory]


GO
/****** Object:  View [dbo].[gv_LibEmail]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_LibEmail]
AS
/*
** Select all rows from the LibEmail table
** and the lookup expressions defined for associated tables
*/
SELECT [LibEmail].* FROM [LibEmail]


GO
/****** Object:  View [dbo].[gv_Library]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Library]
AS
/*
** Select all rows from the Library table
** and the lookup expressions defined for associated tables
*/
SELECT [Library].* FROM [Library]


GO
/****** Object:  View [dbo].[gv_LibraryItems]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_LibraryItems]
AS
/*
** Select all rows from the LibraryItems table
** and the lookup expressions defined for associated tables
*/
SELECT [LibraryItems].* FROM [LibraryItems]


GO
/****** Object:  View [dbo].[gv_LibraryUsers]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_LibraryUsers]
AS
/*
** Select all rows from the LibraryUsers table
** and the lookup expressions defined for associated tables
*/
SELECT [LibraryUsers].* FROM [LibraryUsers]


GO
/****** Object:  View [dbo].[gv_License]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_License]
AS
/*
** Select all rows from the License table
** and the lookup expressions defined for associated tables
*/
SELECT [License].* FROM [License]


GO
/****** Object:  View [dbo].[gv_LoadProfile]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_LoadProfile]
AS
/*
** Select all rows from the LoadProfile table
** and the lookup expressions defined for associated tables
*/
SELECT [LoadProfile].* FROM [LoadProfile]


GO
/****** Object:  View [dbo].[gv_LoadProfileItem]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_LoadProfileItem]
AS
/*
** Select all rows from the LoadProfileItem table
** and the lookup expressions defined for associated tables
*/
SELECT [LoadProfileItem].* FROM [LoadProfileItem]


GO
/****** Object:  View [dbo].[gv_Machine]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Machine]
AS
/*
** Select all rows from the Machine table
** and the lookup expressions defined for associated tables
*/
SELECT [Machine].* FROM [Machine]


GO
/****** Object:  View [dbo].[gv_MyTempTable]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_MyTempTable]
AS
/*
** Select all rows from the MyTempTable table
** and the lookup expressions defined for associated tables
*/
SELECT [MyTempTable].* FROM [MyTempTable]


GO
/****** Object:  View [dbo].[gv_OutlookFrom]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_OutlookFrom]
AS
/*
** Select all rows from the OutlookFrom table
** and the lookup expressions defined for associated tables
*/
SELECT [OutlookFrom].* FROM [OutlookFrom]


GO
/****** Object:  View [dbo].[gv_OwnerHistory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_OwnerHistory]
AS
/*
** Select all rows from the OwnerHistory table
** and the lookup expressions defined for associated tables
*/
SELECT [OwnerHistory].* FROM [OwnerHistory]


GO
/****** Object:  View [dbo].[gv_PgmTrace]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_PgmTrace]
AS
/*
** Select all rows from the PgmTrace table
** and the lookup expressions defined for associated tables
*/
SELECT [PgmTrace].* FROM [PgmTrace]


GO
/****** Object:  View [dbo].[gv_ProcessFileAs]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ProcessFileAs]
AS
/*
** Select all rows from the ProcessFileAs table
** and the lookup expressions defined for associated tables
*/
SELECT [ProcessFileAs].* FROM [ProcessFileAs]


GO
/****** Object:  View [dbo].[gv_ProdCaptureItems]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ProdCaptureItems]
AS
/*
** Select all rows from the ProdCaptureItems table
** and the lookup expressions defined for associated tables
*/
SELECT [ProdCaptureItems].* FROM [ProdCaptureItems]


GO
/****** Object:  View [dbo].[gv_QtyDocs]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_QtyDocs]
AS
/*
** Select all rows from the QtyDocs table
** and the lookup expressions defined for associated tables
*/
SELECT [QtyDocs].* FROM [QtyDocs]


GO
/****** Object:  View [dbo].[gv_QuickDirectory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_QuickDirectory]
AS
/*
** Select all rows from the QuickDirectory table
** and the lookup expressions defined for associated tables
*/
SELECT [QuickDirectory].* FROM [QuickDirectory]


GO
/****** Object:  View [dbo].[gv_QuickRef]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_QuickRef]
AS
/*
** Select all rows from the QuickRef table
** and the lookup expressions defined for associated tables
*/
SELECT [QuickRef].* FROM [QuickRef]


GO
/****** Object:  View [dbo].[gv_QuickRefItems]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_QuickRefItems]
AS
/*
** Select all rows from the QuickRefItems table
** and the lookup expressions defined for associated tables
*/
SELECT [QuickRefItems].* FROM [QuickRefItems]


GO
/****** Object:  View [dbo].[gv_Recipients]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Recipients]
AS
/*
** Select all rows from the Recipients table
** and the lookup expressions defined for associated tables
*/
SELECT [Recipients].* FROM [Recipients]


GO
/****** Object:  View [dbo].[gv_RepeatData]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_RepeatData]
AS
/*
** Select all rows from the RepeatData table
** and the lookup expressions defined for associated tables
*/
SELECT [RepeatData].* FROM [RepeatData]


GO
/****** Object:  View [dbo].[gv_RestorationHistory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_RestorationHistory]
AS
/*
** Select all rows from the RestorationHistory table
** and the lookup expressions defined for associated tables
*/
SELECT [RestorationHistory].* FROM [RestorationHistory]


GO
/****** Object:  View [dbo].[gv_Retention]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Retention]
AS
/*
** Select all rows from the Retention table
** and the lookup expressions defined for associated tables
*/
SELECT [Retention].* FROM [Retention]


GO
/****** Object:  View [dbo].[gv_RetentionTemp]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_RetentionTemp]
AS
/*
** Select all rows from the RetentionTemp table
** and the lookup expressions defined for associated tables
*/
SELECT [RetentionTemp].* FROM [RetentionTemp]


GO
/****** Object:  View [dbo].[gv_RiskLevel]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_RiskLevel]
AS
/*
** Select all rows from the RiskLevel table
** and the lookup expressions defined for associated tables
*/
SELECT [RiskLevel].* FROM [RiskLevel]


GO
/****** Object:  View [dbo].[gv_RunParms]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_RunParms]
AS
/*
** Select all rows from the RunParms table
** and the lookup expressions defined for associated tables
*/
SELECT [RunParms].* FROM [RunParms]


GO
/****** Object:  View [dbo].[gv_RuntimeErrors]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_RuntimeErrors]
AS
/*
** Select all rows from the RuntimeErrors table
** and the lookup expressions defined for associated tables
*/
SELECT [RuntimeErrors].* FROM [RuntimeErrors]


GO
/****** Object:  View [dbo].[gv_SavedItems]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_SavedItems]
AS
/*
** Select all rows from the SavedItems table
** and the lookup expressions defined for associated tables
*/
SELECT [SavedItems].* FROM [SavedItems]


GO
/****** Object:  View [dbo].[gv_SearchHistory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_SearchHistory]
AS
/*
** Select all rows from the SearchHistory table
** and the lookup expressions defined for associated tables
*/
SELECT [SearchHistory].* FROM [SearchHistory]


GO
/****** Object:  View [dbo].[gv_SearhParmsHistory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_SearhParmsHistory]
AS
/*
** Select all rows from the SearhParmsHistory table
** and the lookup expressions defined for associated tables
*/
SELECT [SearhParmsHistory].* FROM [SearhParmsHistory]


GO
/****** Object:  View [dbo].[gv_SkipWords]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_SkipWords]
AS
/*
** Select all rows from the SkipWords table
** and the lookup expressions defined for associated tables
*/
SELECT [SkipWords].* FROM [SkipWords]


GO
/****** Object:  View [dbo].[gv_SourceAttribute]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_SourceAttribute]
AS
/*
** Select all rows from the SourceAttribute table
** and the lookup expressions defined for associated tables
*/
SELECT [SourceAttribute].* FROM [SourceAttribute]


GO
/****** Object:  View [dbo].[gv_SourceContainer]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_SourceContainer]
AS
/*
** Select all rows from the SourceContainer table
** and the lookup expressions defined for associated tables
*/
SELECT [SourceContainer].* FROM [SourceContainer]


GO
/****** Object:  View [dbo].[gv_SourceType]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_SourceType]
AS
/*
** Select all rows from the SourceType table
** and the lookup expressions defined for associated tables
*/
SELECT [SourceType].* FROM [SourceType]


GO
/****** Object:  View [dbo].[gv_Storage]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Storage]
AS
/*
** Select all rows from the Storage table
** and the lookup expressions defined for associated tables
*/
SELECT [Storage].* FROM [Storage]


GO
/****** Object:  View [dbo].[gv_SubDir]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_SubDir]
AS
/*
** Select all rows from the SubDir table
** and the lookup expressions defined for associated tables
*/
SELECT [SubDir].* FROM [SubDir]


GO
/****** Object:  View [dbo].[gv_SubLibrary]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_SubLibrary]
AS
/*
** Select all rows from the SubLibrary table
** and the lookup expressions defined for associated tables
*/
SELECT [SubLibrary].* FROM [SubLibrary]


GO
/****** Object:  View [dbo].[gv_SystemParms]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_SystemParms]
AS
/*
** Select all rows from the SystemParms table
** and the lookup expressions defined for associated tables
*/
SELECT [SystemParms].* FROM [SystemParms]


GO
/****** Object:  View [dbo].[gv_UD_Qty]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_UD_Qty]
AS
/*
** Select all rows from the UD_Qty table
** and the lookup expressions defined for associated tables
*/
SELECT [UD_Qty].* FROM [UD_Qty]


GO
/****** Object:  View [dbo].[gv_upgrade_status]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_upgrade_status]
AS
/*
** Select all rows from the upgrade_status table
** and the lookup expressions defined for associated tables
*/
SELECT [upgrade_status].* FROM [upgrade_status]


GO
/****** Object:  View [dbo].[gv_UrlList]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_UrlList]
AS
/*
** Select all rows from the UrlList table
** and the lookup expressions defined for associated tables
*/
SELECT [UrlList].* FROM [UrlList]


GO
/****** Object:  View [dbo].[gv_UrlRejection]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_UrlRejection]
AS
/*
** Select all rows from the UrlRejection table
** and the lookup expressions defined for associated tables
*/
SELECT [UrlRejection].* FROM [UrlRejection]


GO
/****** Object:  View [dbo].[gv_UserCurrParm]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_UserCurrParm]
AS
/*
** Select all rows from the UserCurrParm table
** and the lookup expressions defined for associated tables
*/
SELECT [UserCurrParm].* FROM [UserCurrParm]


GO
/****** Object:  View [dbo].[gv_UserGroup]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_UserGroup]
AS
/*
** Select all rows from the UserGroup table
** and the lookup expressions defined for associated tables
*/
SELECT [UserGroup].* FROM [UserGroup]


GO
/****** Object:  View [dbo].[gv_UserReassignHist]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_UserReassignHist]
AS
/*
** Select all rows from the UserReassignHist table
** and the lookup expressions defined for associated tables
*/
SELECT [UserReassignHist].* FROM [UserReassignHist]


GO
/****** Object:  View [dbo].[gv_Users]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Users]
AS
/*
** Select all rows from the Users table
** and the lookup expressions defined for associated tables
*/
SELECT [Users].* FROM [Users]


GO
/****** Object:  View [dbo].[gv_Volitility]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_Volitility]
AS
/*
** Select all rows from the Volitility table
** and the lookup expressions defined for associated tables
*/
SELECT [Volitility].* FROM [Volitility]


GO
/****** Object:  View [dbo].[gv_WebSource]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_WebSource]
AS
/*
** Select all rows from the WebSource table
** and the lookup expressions defined for associated tables
*/
SELECT [WebSource].* FROM [WebSource]


GO
/****** Object:  View [dbo].[gv_ZippedFiles]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[gv_ZippedFiles]
AS
/*
** Select all rows from the ZippedFiles table
** and the lookup expressions defined for associated tables
*/
SELECT [ZippedFiles].* FROM [ZippedFiles]


GO
/****** Object:  View [dbo].[vExchangeHostPop]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vExchangeHostPop] as 
SELECT [HostNameIp],[UserLoginID],[LoginPw],[PortNbr],[DeleteAfterDownload],[RetentionCode], SSL, IMAP, FolderName, LibraryName, isPublic, DaysToHold, strReject, ConvertEmlToMSG FROM [ExchangeHostPop]


GO
/****** Object:  View [dbo].[vFileDirectory]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vFileDirectory]
as 
SELECT DISTINCT Container.ContainerName, ContentUser.UserID, ContentUser.ContentTypeCode
FROM         Container INNER JOIN
                      ContentContainer ON Container.ContainerGuid = ContentContainer.ContainerGuid INNER JOIN
                      ContentUser ON ContentContainer.ContentUserRowGuid = ContentUser.ContentUserRowGuid
where ContentUser.ContentTypeCode = 'C'                      
GROUP BY Container.ContainerName, ContentUser.UserID, ContentUser.ContentTypeCode 


GO
/****** Object:  View [dbo].[vLibraryStats]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vLibraryStats] as
 select LibraryName, isPublic, 
 (select COUNT(*) from LibraryItems where LibraryItems.LibraryName = Library.LibraryName) as Items,
 (select COUNT(*) from LibraryUsers where LibraryUsers.LibraryName = Library.LibraryName) as Members, 
 UserID
 from Library


GO
/****** Object:  View [dbo].[vLibraryUsers]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vLibraryUsers]
as
SELECT     LibraryUsers.UserID, LibraryUsers.LibraryName, LibraryUsers.LibraryOwnerUserID, Users.UserName
FROM         LibraryUsers INNER JOIN
                      Users ON LibraryUsers.UserID = Users.UserID


GO
/****** Object:  View [dbo].[vMigrateUsers]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vMigrateUsers] as
Select UserName as ECM_UserName, 
		UserLoginID as ECM_UserID, 
		UserPassword as ECM_UserPW, 
		EmailAddress as ECM_UserEmail,
		'xx' as ECM_GroupName, 
		'LL' as ECM_Library, 
		'U' as ECM_Authority,
		ClientOnly as ECM_ClientOnly
		from Users


GO
/****** Object:  View [dbo].[vReassignedTable]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[vReassignedTable]  AS
SELECT [PrevUserName]
,[ReassignedUserName]
      ,[PrevUserLoginID] 
,[ReassignedUserLoginID]
      ,[PrevUserID]
,[ReassignedUserID]
      ,[PrevEmailAddress]
      ,[PrevUserPassword]
      ,[PrevAdmin]
      ,[PrevisActive]          
      ,[ReassignedEmailAddress]
      ,[ReassignedUserPassword]
      ,[ReassignedAdmin]
      ,[ReassignedisActive]      
      ,[ReassignmentDate]
FROM [UserReassignHist]


GO
/****** Object:  View [dbo].[vUserGrid]    Script Date: 10/15/2015 7:35:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vUserGrid] as
SELECT [UserID]
      ,[UserName]
      ,[EmailAddress]
      ,[Admin]
      ,[isActive]
      ,[UserLoginID]
      ,[ClientOnly]
      ,[HiveConnectionName]
      ,[HiveActive]
      ,[RepoSvrName]
      ,[RowCreationDate]
      ,[RowLastModDate]
  FROM [Users]


GO
ALTER TABLE [dbo].[ActiveDirUser] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ActiveSearchGuids] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ActiveSession] ADD  CONSTRAINT [DF_ActiveSession_InitDate]  DEFAULT (getdate()) FOR [InitDate]
GO
ALTER TABLE [dbo].[ActiveSession] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[AlertContact] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[AlertHistory] ADD  CONSTRAINT [DF_AlertWord2_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[AlertHistory] ADD  CONSTRAINT [DF_AlertWord2_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[AlertWord] ADD  CONSTRAINT [DF_AlertWord_ExpirationDate]  DEFAULT (getdate()+(90)) FOR [ExpirationDate]
GO
ALTER TABLE [dbo].[AlertWord] ADD  CONSTRAINT [DF_AlertWord_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[AlertWord] ADD  CONSTRAINT [DF_AlertWord_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ArchiveFrom] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ArchiveHist] ADD  CONSTRAINT [DF__ArchiveHi__Archi__1D864D1D]  DEFAULT (getdate()) FOR [ArchiveDate]
GO
ALTER TABLE [dbo].[ArchiveHist] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ArchiveHistContentType] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ArchiveStats] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[AssignableUserParameters] ADD  CONSTRAINT [DF_AssignableUserParameters_isPerm]  DEFAULT ((0)) FOR [isPerm]
GO
ALTER TABLE [dbo].[AssignableUserParameters] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[AttachmentType] ADD  CONSTRAINT [DF_AttachmentType_isZipFormat]  DEFAULT ((0)) FOR [isZipFormat]
GO
ALTER TABLE [dbo].[AttachmentType] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[AttributeDatatype] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Attributes] ADD  CONSTRAINT [DF_Attributes_AttributeDataType]  DEFAULT ('nvarchar') FOR [AttributeDataType]
GO
ALTER TABLE [dbo].[Attributes] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[AvailFileTypes] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[AvailFileTypesUndefined] ADD  CONSTRAINT [DF_AvailFileTypesUndefined_Applied]  DEFAULT ((0)) FOR [Applied]
GO
ALTER TABLE [dbo].[AvailFileTypesUndefined] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[BusinessFunctionJargon] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[BusinessJargonCode] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[CaptureItems] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[CLC_DIR] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[CLC_Download] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[CLC_Preview] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[CLCState] ADD  CONSTRAINT [DF_CLCState_CLCInstalled]  DEFAULT ((0)) FOR [CLCInstalled]
GO
ALTER TABLE [dbo].[CLCState] ADD  CONSTRAINT [DF_CLCState_CLCActive]  DEFAULT ((0)) FOR [CLCActive]
GO
ALTER TABLE [dbo].[CLCState] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ConnectionStrings] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ConnectionStringsRegistered] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ConnectionStringsSaved] ADD  CONSTRAINT [DF_ConnectionStringsSaved_LastArchiveDate]  DEFAULT ('01/01/1920') FOR [LastArchiveDate]
GO
ALTER TABLE [dbo].[ConnectionStringsSaved] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ContactFrom] ADD  CONSTRAINT [DF_ContactFrom_Verified]  DEFAULT ((1)) FOR [Verified]
GO
ALTER TABLE [dbo].[ContactFrom] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ContactsArchive] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Container] ADD  DEFAULT (newid()) FOR [ContainerGuid]
GO
ALTER TABLE [dbo].[Container] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ContainerStorage] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ContentContainer] ADD  DEFAULT (newid()) FOR [ContentUserRowGuid]
GO
ALTER TABLE [dbo].[ContentContainer] ADD  DEFAULT (newid()) FOR [ContainerGuid]
GO
ALTER TABLE [dbo].[ContentContainer] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ContentUser] ADD  DEFAULT ((1)) FOR [NbrOccurances]
GO
ALTER TABLE [dbo].[ContentUser] ADD  DEFAULT (newid()) FOR [ContentUserRowGuid]
GO
ALTER TABLE [dbo].[ContentUser] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ConvertedDocs] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[CoOwner] ADD  CONSTRAINT [DF__CoOwner__CreateD__36F11965]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[CoOwner] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[CorpContainer] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[CorpFunction] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Corporation] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[CS] ADD  CONSTRAINT [DF_CS_ConnectionType]  DEFAULT ('ECMLIB') FOR [ConnectionType]
GO
ALTER TABLE [dbo].[CS] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[CS_SharePoint] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DatabaseFiles] ADD  DEFAULT (getdate()) FOR [CreationDate]
GO
ALTER TABLE [dbo].[DatabaseFiles] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Databases] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DataOwners] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DataSourceCheckOut] ADD  CONSTRAINT [DF__DataSourc__check__74EE4BDE]  DEFAULT (getdate()) FOR [checkOutDate]
GO
ALTER TABLE [dbo].[DataSourceCheckOut] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DataSourceOwner] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DataSourceRestoreHistory] ADD  CONSTRAINT [DF__DataSourc__Resto__7E77B618]  DEFAULT (getdate()) FOR [RestoreDate]
GO
ALTER TABLE [dbo].[DataSourceRestoreHistory] ADD  CONSTRAINT [DF__DataSourc__Creat__7F6BDA51]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DataSourceRestoreHistory] ADD  CONSTRAINT [DF_DataSourceRestoreHistory_VerifiedData]  DEFAULT ('N') FOR [VerifiedData]
GO
ALTER TABLE [dbo].[DataSourceRestoreHistory] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DataTypeCodes] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DB_UpdateHist] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DB_Updates] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DeleteFrom] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DirArchLib] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Directory] ADD  CONSTRAINT [DF_Directory_ckMetaData]  DEFAULT ('N') FOR [ckMetaData]
GO
ALTER TABLE [dbo].[Directory] ADD  CONSTRAINT [DF_Directory_ckDisableDir]  DEFAULT ('N') FOR [ckDisableDir]
GO
ALTER TABLE [dbo].[Directory] ADD  CONSTRAINT [DF_Directory_QuickRefEntry]  DEFAULT ((0)) FOR [QuickRefEntry]
GO
ALTER TABLE [dbo].[Directory] ADD  CONSTRAINT [DF_Directory_isSysDefault]  DEFAULT ((0)) FOR [isSysDefault]
GO
ALTER TABLE [dbo].[Directory] ADD  DEFAULT (newid()) FOR [DirGuid]
GO
ALTER TABLE [dbo].[Directory] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Directory] ADD  DEFAULT ('N') FOR [DeleteOnArchive]
GO
ALTER TABLE [dbo].[DirectoryGuids] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DirectoryListener] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DirectoryListenerFiles] ADD  CONSTRAINT [DF_DirectoryListenerFiles_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[DirectoryListenerFiles] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DirectoryLongName] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DirectoryMonitorLog] ADD  CONSTRAINT [DF_DirectoryMonitorLog_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[DirectoryMonitorLog] ADD  CONSTRAINT [DF_DirectoryMonitorLog_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DirectoryTemp] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DirProfiles] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[DuplicateContent] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[EcmUser] ADD  CONSTRAINT [UserAuthority]  DEFAULT ('U') FOR [Authority]
GO
ALTER TABLE [dbo].[EcmUser] ADD  CONSTRAINT [DF_EcmUser_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[EcmUser] ADD  CONSTRAINT [DF__EcmUser__LastUpd__31B762FC]  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[EcmUser] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[EmailArchParms] ADD  CONSTRAINT [DF_EmailArchParms_ArchiveOnlyIfRead]  DEFAULT ('N') FOR [ArchiveOnlyIfRead]
GO
ALTER TABLE [dbo].[EmailArchParms] ADD  CONSTRAINT [DF_EmailArchParms_RowCreationDate]  DEFAULT (getdate()) FOR [RowCreationDate]
GO
ALTER TABLE [dbo].[EmailArchParms] ADD  CONSTRAINT [DF_EmailArchParms_RowLastModDate]  DEFAULT (getdate()) FOR [RowLastModDate]
GO
ALTER TABLE [dbo].[EmailArchParms] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[EmailAttachment] ADD  CONSTRAINT [DF_EmailAttachment_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[EmailAttachmentSearchList] ADD  CONSTRAINT [DF_EmailAttachmentSearchList_RowCreationDate]  DEFAULT (getdate()) FOR [RowCreationDate]
GO
ALTER TABLE [dbo].[EmailAttachmentSearchList] ADD  CONSTRAINT [DF_EmailAttachmentSearchList_RowLastModDate]  DEFAULT (getdate()) FOR [RowLastModDate]
GO
ALTER TABLE [dbo].[EmailAttachmentSearchList] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[EmailFolder] ADD  CONSTRAINT [DF_EmailFolder_isSysDefulat]  DEFAULT ((0)) FOR [isSysDefault]
GO
ALTER TABLE [dbo].[EmailFolder] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[EmailRunningTotal] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[EmailToDelete] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ErrorLogs] ADD  CONSTRAINT [DF_ErrorLogs_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[ErrorLogs] ADD  CONSTRAINT [DF_ErrorLogs_Severity]  DEFAULT (N'ERROR') FOR [Severity]
GO
ALTER TABLE [dbo].[ErrorLogs] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ExcgKey] ADD  CONSTRAINT [DF_ExcgKey_InsertDate]  DEFAULT (getdate()) FOR [InsertDate]
GO
ALTER TABLE [dbo].[ExcgKey] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ExchangeHostPop] ADD  CONSTRAINT [DF_ExchangeHostPop_SSL]  DEFAULT ((0)) FOR [SSL]
GO
ALTER TABLE [dbo].[ExchangeHostPop] ADD  CONSTRAINT [DF_ExchangeHostPop_PortNbr]  DEFAULT ((-1)) FOR [PortNbr]
GO
ALTER TABLE [dbo].[ExchangeHostPop] ADD  CONSTRAINT [DF_ExchangeHostPop_DeleteAfterDownload]  DEFAULT ((0)) FOR [DeleteAfterDownload]
GO
ALTER TABLE [dbo].[ExchangeHostPop] ADD  CONSTRAINT [DF_ExchangeHostPop_IMap]  DEFAULT ((0)) FOR [IMap]
GO
ALTER TABLE [dbo].[ExchangeHostPop] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ExchangeHostSmtp] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ExcludedFiles] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ExcludeFrom] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[FileKey] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[FileKeyMachine] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[FileKeyMachineDir] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[FilesToDelete] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[FileType] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[FUncSkipWords] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[FunctionProdJargon] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[GlobalAsso] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[GlobalDirectory] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[GlobalEmail] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[GlobalFile] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[GlobalLocation] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[GlobalMachine] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[GlobalSeachResults] ADD  CONSTRAINT [DF_GlobalSeachResults_Weight]  DEFAULT ((0)) FOR [Weight]
GO
ALTER TABLE [dbo].[GlobalSeachResults] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[GroupLibraryAccess] ADD  CONSTRAINT [DF_GroupLibraryAccess_HiveActive]  DEFAULT ((0)) FOR [HiveActive]
GO
ALTER TABLE [dbo].[GroupLibraryAccess] ADD  CONSTRAINT [DF_GroupLibraryAccess_RepoSvrName]  DEFAULT (@@servername) FOR [RepoSvrName]
GO
ALTER TABLE [dbo].[GroupLibraryAccess] ADD  CONSTRAINT [DF_GroupLibraryAccess_RowCreationDate]  DEFAULT (getdate()) FOR [RowCreationDate]
GO
ALTER TABLE [dbo].[GroupLibraryAccess] ADD  CONSTRAINT [DF_GroupLibraryAccess_RowLastModDate]  DEFAULT (getdate()) FOR [RowLastModDate]
GO
ALTER TABLE [dbo].[GroupLibraryAccess] ADD  CONSTRAINT [DF_GroupLibraryAccess_RepoName]  DEFAULT (db_name()) FOR [RepoName]
GO
ALTER TABLE [dbo].[GroupLibraryAccess] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[GroupUsers] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[HashDir] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[HashFile] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[HelpInfo] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[HelpText] ADD  CONSTRAINT [DF_HelpText_DisplayHelpText]  DEFAULT ((1)) FOR [DisplayHelpText]
GO
ALTER TABLE [dbo].[HelpText] ADD  CONSTRAINT [DF_HelpText_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[HelpText] ADD  CONSTRAINT [DF_HelpText_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[HelpText] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[HelpTextUser] ADD  CONSTRAINT [DF_HelpText_DisplayHelpTextUsers]  DEFAULT ((1)) FOR [DisplayHelpText]
GO
ALTER TABLE [dbo].[HelpTextUser] ADD  CONSTRAINT [DF_HelpTextUser_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]
GO
ALTER TABLE [dbo].[HelpTextUser] ADD  CONSTRAINT [DF_HelpTextUser_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[HelpTextUser] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[HiveServers] ADD  CONSTRAINT [DF_HiveServers_LinkedDate]  DEFAULT (getdate()) FOR [LinkedDate]
GO
ALTER TABLE [dbo].[HiveServers] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ImageTypeCodes] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[IncludedFiles] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[IncludeImmediate] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[InformationProduct] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[InformationType] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Inventory] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[IP] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[JargonWords] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[KTBL] ADD  CONSTRAINT [DF_dbo_KTBL_KGUID]  DEFAULT (newid()) FOR [KGUID]
GO
ALTER TABLE [dbo].[KTBL] ADD  CONSTRAINT [DF_dbo_KTBL_KIV]  DEFAULT (newid()) FOR [KIV]
GO
ALTER TABLE [dbo].[KTBL] ADD  CONSTRAINT [DF_dbo_KTBL_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[KTBL] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[LibDirectory] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[LibEmail] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Library] ADD  CONSTRAINT [DF_Library_isPublic]  DEFAULT ('N') FOR [isPublic]
GO
ALTER TABLE [dbo].[Library] ADD  CONSTRAINT [DF_Library_RepoSvrName]  DEFAULT (@@servername) FOR [RepoSvrName]
GO
ALTER TABLE [dbo].[Library] ADD  CONSTRAINT [DF_Library_RepoName]  DEFAULT (db_name()) FOR [RepoName]
GO
ALTER TABLE [dbo].[Library] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[LibraryItems] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[LibraryUsers] ADD  CONSTRAINT [DF__LibraryUs__ReadO__1FD8A9E3]  DEFAULT ((0)) FOR [ReadOnly]
GO
ALTER TABLE [dbo].[LibraryUsers] ADD  CONSTRAINT [DF__LibraryUs__Creat__20CCCE1C]  DEFAULT ((0)) FOR [CreateAccess]
GO
ALTER TABLE [dbo].[LibraryUsers] ADD  CONSTRAINT [DF__LibraryUs__Updat__21C0F255]  DEFAULT ((1)) FOR [UpdateAccess]
GO
ALTER TABLE [dbo].[LibraryUsers] ADD  CONSTRAINT [DF__LibraryUs__Delet__22B5168E]  DEFAULT ((0)) FOR [DeleteAccess]
GO
ALTER TABLE [dbo].[LibraryUsers] ADD  CONSTRAINT [DF_LibraryUsers_RepoSvrName]  DEFAULT (@@servername) FOR [RepoSvrName]
GO
ALTER TABLE [dbo].[LibraryUsers] ADD  CONSTRAINT [DF_LibraryUsers_RepoName]  DEFAULT (db_name()) FOR [RepoName]
GO
ALTER TABLE [dbo].[LibraryUsers] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[License] ADD  CONSTRAINT [DF_License_ActivationDate]  DEFAULT (getdate()) FOR [ActivationDate]
GO
ALTER TABLE [dbo].[License] ADD  CONSTRAINT [DF_License_InstallDate]  DEFAULT (getdate()) FOR [InstallDate]
GO
ALTER TABLE [dbo].[License] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[LoadProfile] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[LoadProfileItem] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[LoginClient] ADD  CONSTRAINT [DF_LoginClient_LoginDate]  DEFAULT (getdate()) FOR [LoginDate]
GO
ALTER TABLE [dbo].[LoginClient] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[LoginMachine] ADD  CONSTRAINT [DF_LoginMachine_LoginDate]  DEFAULT (getdate()) FOR [LoginDate]
GO
ALTER TABLE [dbo].[LoginMachine] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[LoginUser] ADD  CONSTRAINT [DF_LoginUser_LoginDate]  DEFAULT (getdate()) FOR [LoginDate]
GO
ALTER TABLE [dbo].[LoginUser] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Logs] ADD  CONSTRAINT [DF_Logs_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[Logs] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Machine] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[MachineRegistered] ADD  DEFAULT (newid()) FOR [MachineGuid]
GO
ALTER TABLE [dbo].[MachineRegistered] ADD  CONSTRAINT [DF_MachineRegistered_NetWorkName]  DEFAULT ('NA') FOR [NetWorkName]
GO
ALTER TABLE [dbo].[MachineRegistered] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[MyTempTable] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[OutlookFrom] ADD  CONSTRAINT [DF_OutlookFrom_Verified]  DEFAULT ((1)) FOR [Verified]
GO
ALTER TABLE [dbo].[OutlookFrom] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[OwnerHistory] ADD  CONSTRAINT [DF__OwnerHist__Creat__2D67AF2B]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[OwnerHistory] ADD  CONSTRAINT [DF_OwnerHistory_RowCreationDate]  DEFAULT (getdate()) FOR [RowCreationDate]
GO
ALTER TABLE [dbo].[OwnerHistory] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[PgmTrace] ADD  CONSTRAINT [DF_PgmTrace_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[PgmTrace] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ProcessFileAs] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ProdCaptureItems] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[QtyDocs] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[QuickDirectory] ADD  CONSTRAINT [QDF_Directory_ckMetaData]  DEFAULT ('N') FOR [ckMetaData]
GO
ALTER TABLE [dbo].[QuickDirectory] ADD  CONSTRAINT [QDF_Directory_ckDisableDir]  DEFAULT ('N') FOR [ckDisableDir]
GO
ALTER TABLE [dbo].[QuickDirectory] ADD  CONSTRAINT [QDF_Directory_QuickRefEntry]  DEFAULT ((1)) FOR [QuickRefEntry]
GO
ALTER TABLE [dbo].[QuickDirectory] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[QuickRef] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[QuickRefItems] ADD  CONSTRAINT [DF_QuickRefItems_MarkedForDeletion]  DEFAULT ((0)) FOR [MarkedForDeletion]
GO
ALTER TABLE [dbo].[QuickRefItems] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Recipients] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[RepeatData] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[reports] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Repository] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[RestorationHistory] ADD  CONSTRAINT [DF_RestorationHistory_RestorationDate]  DEFAULT (getdate()) FOR [RestorationDate]
GO
ALTER TABLE [dbo].[RestorationHistory] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[RestoreQueue] ADD  CONSTRAINT [DF_RestoreQueue_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[RestoreQueue] ADD  CONSTRAINT [DF_RestoreQueue_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[RestoreQueueHistory] ADD  CONSTRAINT [DF_RestoreQueueHistory_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[RestoreQueueHistory] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Retention] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Retention] ADD  DEFAULT ('Year') FOR [RetentionPeriod]
GO
ALTER TABLE [dbo].[RetentionTemp] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[RiskLevel] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[RssPull] ADD  CONSTRAINT [DF_RssPull_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[RssPull] ADD  CONSTRAINT [DF_RssPull_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[RssPull] ADD  DEFAULT ('Y') FOR [isPublic]
GO
ALTER TABLE [dbo].[RunParms] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[RuntimeErrors] ADD  CONSTRAINT [DF_RuntimeErrors_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[RuntimeErrors] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SavedItems] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SearchHistory] ADD  CONSTRAINT [DF_SearchHistory_SearchDate]  DEFAULT (getdate()) FOR [SearchDate]
GO
ALTER TABLE [dbo].[SearchHistory] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SearchSchedule] ADD  CONSTRAINT [DF_SearchSchedule_NumberOfExecutions]  DEFAULT ((0)) FOR [NumberOfExecutions]
GO
ALTER TABLE [dbo].[SearchSchedule] ADD  CONSTRAINT [DF_SearchSchedule_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[SearchSchedule] ADD  CONSTRAINT [DF_SearchSchedule_LastModDate]  DEFAULT (getdate()) FOR [LastModDate]
GO
ALTER TABLE [dbo].[SearchSchedule] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SearchUser] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SearchUser] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[SearchUser] ADD  DEFAULT (getdate()) FOR [LastUsedDate]
GO
ALTER TABLE [dbo].[SearhParmsHistory] ADD  CONSTRAINT [DF_SearhParmsHistory_SearchDate]  DEFAULT (getdate()) FOR [SearchDate]
GO
ALTER TABLE [dbo].[SearhParmsHistory] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ServiceActivity] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SessionID] ADD  CONSTRAINT [DF_SessionID_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[SessionVar] ADD  CONSTRAINT [DF_SessionVar_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[SessionVar] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SkipWords] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SourceAttribute] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SourceContainer] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SourceInjector] ADD  DEFAULT ('01-01-1960') FOR [LastExecDate]
GO
ALTER TABLE [dbo].[SourceInjector] ADD  DEFAULT ((0)) FOR [NbrExecutions]
GO
ALTER TABLE [dbo].[SourceInjector] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SourceType] ADD  CONSTRAINT [FALSE]  DEFAULT ((0)) FOR [StoreExternal]
GO
ALTER TABLE [dbo].[SourceType] ADD  CONSTRAINT [TRUE]  DEFAULT ((1)) FOR [Indexable]
GO
ALTER TABLE [dbo].[SourceType] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SqlDataTypes] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[StagedSQL] ADD  CONSTRAINT [DF_StagedSQL_EntryTime]  DEFAULT (getdate()) FOR [EntryTime]
GO
ALTER TABLE [dbo].[StagedSQL] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[StatsClick] ADD  CONSTRAINT [DF_Table_1_ClickDate]  DEFAULT (getdate()) FOR [ClickDate]
GO
ALTER TABLE [dbo].[StatsClick] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[StatSearch] ADD  CONSTRAINT [DF_StatSearch_SearchDate]  DEFAULT (getdate()) FOR [SearchDate]
GO
ALTER TABLE [dbo].[StatSearch] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[StatWord] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Storage] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[StructuredData] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[StructuredDataProcessed] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SubDir] ADD  CONSTRAINT [DF_SubDir_ckDisableDir]  DEFAULT ('N') FOR [ckDisableDir]
GO
ALTER TABLE [dbo].[SubDir] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SubLibrary] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SystemMessage] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[SystemParms] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[TempUserLibItems] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[TestTbl] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Trace] ADD  CONSTRAINT [DF_Trace_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
GO
ALTER TABLE [dbo].[Trace] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[txTimes] ADD  CONSTRAINT [DF_txTimes_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[txTimes] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[UD_Qty] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[upgrade_status] ADD  DEFAULT ('INCOMPLETE') FOR [status]
GO
ALTER TABLE [dbo].[upgrade_status] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[UrlList] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[UrlRejection] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[UserCurrParm] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[UserGridState] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[UserGroup] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[UserReassignHist] ADD  CONSTRAINT [DF_UserReassignHist_ReassignmentDate]  DEFAULT (getdate()) FOR [ReassignmentDate]
GO
ALTER TABLE [dbo].[UserReassignHist] ADD  CONSTRAINT [DF_UserReassignHist_RowID]  DEFAULT (newid()) FOR [RowID]
GO
ALTER TABLE [dbo].[UserReassignHist] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_Admin]  DEFAULT ('U') FOR [Admin]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_isActive]  DEFAULT ('Y') FOR [isActive]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_ActiveGuid]  DEFAULT (newid()) FOR [ActiveGuid]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[UserScreenState] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[UserSearchState] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[VersionInfo] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[Volitility] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[WebScreen] ADD  CONSTRAINT [DF_WebScreen_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[WebScreen] ADD  CONSTRAINT [DF_WebScreen_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[WebScreen] ADD  DEFAULT ('Y') FOR [isPublic]
GO
ALTER TABLE [dbo].[WebSite] ADD  CONSTRAINT [DF_WebSite_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[WebSite] ADD  CONSTRAINT [DF_WebSite_RowGuid]  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[WebSite] ADD  DEFAULT ((0)) FOR [Depth]
GO
ALTER TABLE [dbo].[WebSite] ADD  DEFAULT ((0)) FOR [Width]
GO
ALTER TABLE [dbo].[WebSite] ADD  DEFAULT ('Y') FOR [isPublic]
GO
ALTER TABLE [dbo].[WebSource] ADD  CONSTRAINT [CURRDATE_WebSource]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[WebSource] ADD  CONSTRAINT [DF_WebSource_RetentionExpirationDate]  DEFAULT (getdate()+(3650)) FOR [RetentionExpirationDate]
GO
ALTER TABLE [dbo].[WebSource] ADD  CONSTRAINT [DF_WebSource_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
GO
ALTER TABLE [dbo].[WebSource] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[ZippedFiles] ADD  DEFAULT (newid()) FOR [RowGuid]
GO
ALTER TABLE [dbo].[BusinessFunctionJargon]  WITH CHECK ADD  CONSTRAINT [RefCorpFunction30] FOREIGN KEY([CorpFuncName], [CorpName])
REFERENCES [dbo].[CorpFunction] ([CorpFuncName], [CorpName])
GO
ALTER TABLE [dbo].[BusinessFunctionJargon] CHECK CONSTRAINT [RefCorpFunction30]
GO
ALTER TABLE [dbo].[BusinessFunctionJargon]  WITH CHECK ADD  CONSTRAINT [RefJargonWords33] FOREIGN KEY([JargonCode], [JargonWords_tgtWord])
REFERENCES [dbo].[JargonWords] ([JargonCode], [tgtWord])
GO
ALTER TABLE [dbo].[BusinessFunctionJargon] CHECK CONSTRAINT [RefJargonWords33]
GO
ALTER TABLE [dbo].[ContainerStorage]  WITH CHECK ADD  CONSTRAINT [RefSourceContainer18] FOREIGN KEY([ContainerType])
REFERENCES [dbo].[SourceContainer] ([ContainerType])
GO
ALTER TABLE [dbo].[ContainerStorage] CHECK CONSTRAINT [RefSourceContainer18]
GO
ALTER TABLE [dbo].[ContainerStorage]  WITH CHECK ADD  CONSTRAINT [RefStorage17] FOREIGN KEY([StoreCode])
REFERENCES [dbo].[Storage] ([StoreCode])
GO
ALTER TABLE [dbo].[ContainerStorage] CHECK CONSTRAINT [RefStorage17]
GO
ALTER TABLE [dbo].[ContentContainer]  WITH CHECK ADD  CONSTRAINT [RefContainer76] FOREIGN KEY([ContainerGuid])
REFERENCES [dbo].[Container] ([ContainerGuid])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContentContainer] CHECK CONSTRAINT [RefContainer76]
GO
ALTER TABLE [dbo].[ContentContainer]  WITH CHECK ADD  CONSTRAINT [RefContentUser75] FOREIGN KEY([ContentUserRowGuid])
REFERENCES [dbo].[ContentUser] ([ContentUserRowGuid])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContentContainer] CHECK CONSTRAINT [RefContentUser75]
GO
ALTER TABLE [dbo].[ContentUser]  WITH CHECK ADD  CONSTRAINT [RefUsers64] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ContentUser] CHECK CONSTRAINT [RefUsers64]
GO
ALTER TABLE [dbo].[ConvertedDocs]  WITH CHECK ADD  CONSTRAINT [RefCorporation38] FOREIGN KEY([CorpName])
REFERENCES [dbo].[Corporation] ([CorpName])
GO
ALTER TABLE [dbo].[ConvertedDocs] CHECK CONSTRAINT [RefCorporation38]
GO
ALTER TABLE [dbo].[CoOwner]  WITH CHECK ADD  CONSTRAINT [RefUsers86] FOREIGN KEY([PreviousOwnerUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[CoOwner] CHECK CONSTRAINT [RefUsers86]
GO
ALTER TABLE [dbo].[CoOwner]  WITH CHECK ADD  CONSTRAINT [RefUsers87] FOREIGN KEY([CurrentOwnerUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[CoOwner] CHECK CONSTRAINT [RefUsers87]
GO
ALTER TABLE [dbo].[CorpContainer]  WITH CHECK ADD  CONSTRAINT [RefCorpFunction24] FOREIGN KEY([CorpFuncName], [CorpName])
REFERENCES [dbo].[CorpFunction] ([CorpFuncName], [CorpName])
GO
ALTER TABLE [dbo].[CorpContainer] CHECK CONSTRAINT [RefCorpFunction24]
GO
ALTER TABLE [dbo].[CorpContainer]  WITH CHECK ADD  CONSTRAINT [RefQtyDocs10] FOREIGN KEY([QtyDocCode])
REFERENCES [dbo].[QtyDocs] ([QtyDocCode])
GO
ALTER TABLE [dbo].[CorpContainer] CHECK CONSTRAINT [RefQtyDocs10]
GO
ALTER TABLE [dbo].[CorpContainer]  WITH CHECK ADD  CONSTRAINT [RefSourceContainer2] FOREIGN KEY([ContainerType])
REFERENCES [dbo].[SourceContainer] ([ContainerType])
GO
ALTER TABLE [dbo].[CorpContainer] CHECK CONSTRAINT [RefSourceContainer2]
GO
ALTER TABLE [dbo].[CorpFunction]  WITH CHECK ADD  CONSTRAINT [RefCorporation37] FOREIGN KEY([CorpName])
REFERENCES [dbo].[Corporation] ([CorpName])
GO
ALTER TABLE [dbo].[CorpFunction] CHECK CONSTRAINT [RefCorporation37]
GO
ALTER TABLE [dbo].[DataSourceCheckOut]  WITH CHECK ADD  CONSTRAINT [RefUsers90] FOREIGN KEY([CheckedOutByUserID])
REFERENCES [dbo].[Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[DataSourceCheckOut] CHECK CONSTRAINT [RefUsers90]
GO
ALTER TABLE [dbo].[Directory]  WITH CHECK ADD  CONSTRAINT [RefUsers3] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Directory] CHECK CONSTRAINT [RefUsers3]
GO
ALTER TABLE [dbo].[EmailArchParms]  WITH CHECK ADD  CONSTRAINT [RefDatabases8] FOREIGN KEY([DB_ID])
REFERENCES [dbo].[Databases] ([DB_ID])
GO
ALTER TABLE [dbo].[EmailArchParms] CHECK CONSTRAINT [RefDatabases8]
GO
ALTER TABLE [dbo].[EmailArchParms]  WITH CHECK ADD  CONSTRAINT [RefUsers4] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[EmailArchParms] CHECK CONSTRAINT [RefUsers4]
GO
ALTER TABLE [dbo].[EmailAttachmentSearchList]  WITH CHECK ADD  CONSTRAINT [RefUsers82] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[EmailAttachmentSearchList] CHECK CONSTRAINT [RefUsers82]
GO
ALTER TABLE [dbo].[FUncSkipWords]  WITH CHECK ADD  CONSTRAINT [RefCorpFunction34] FOREIGN KEY([CorpFuncName], [CorpName])
REFERENCES [dbo].[CorpFunction] ([CorpFuncName], [CorpName])
GO
ALTER TABLE [dbo].[FUncSkipWords] CHECK CONSTRAINT [RefCorpFunction34]
GO
ALTER TABLE [dbo].[FUncSkipWords]  WITH CHECK ADD  CONSTRAINT [RefSkipWords35] FOREIGN KEY([tgtWord])
REFERENCES [dbo].[SkipWords] ([tgtWord])
GO
ALTER TABLE [dbo].[FUncSkipWords] CHECK CONSTRAINT [RefSkipWords35]
GO
ALTER TABLE [dbo].[FunctionProdJargon]  WITH CHECK ADD  CONSTRAINT [RefBusinessJargonCode29] FOREIGN KEY([JargonCode])
REFERENCES [dbo].[BusinessJargonCode] ([JargonCode])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[FunctionProdJargon] CHECK CONSTRAINT [RefBusinessJargonCode29]
GO
ALTER TABLE [dbo].[FunctionProdJargon]  WITH CHECK ADD  CONSTRAINT [RefCorpFunction28] FOREIGN KEY([CorpFuncName], [CorpName])
REFERENCES [dbo].[CorpFunction] ([CorpFuncName], [CorpName])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[FunctionProdJargon] CHECK CONSTRAINT [RefCorpFunction28]
GO
ALTER TABLE [dbo].[FunctionProdJargon]  WITH CHECK ADD  CONSTRAINT [RefRepeatData15] FOREIGN KEY([RepeatDataCode])
REFERENCES [dbo].[RepeatData] ([RepeatDataCode])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[FunctionProdJargon] CHECK CONSTRAINT [RefRepeatData15]
GO
ALTER TABLE [dbo].[GroupLibraryAccess]  WITH NOCHECK ADD  CONSTRAINT [RefUserGroup64] FOREIGN KEY([GroupOwnerUserID], [GroupName])
REFERENCES [dbo].[UserGroup] ([GroupOwnerUserID], [GroupName])
GO
ALTER TABLE [dbo].[GroupLibraryAccess] CHECK CONSTRAINT [RefUserGroup64]
GO
ALTER TABLE [dbo].[GroupUsers]  WITH CHECK ADD  CONSTRAINT [RefUsers52] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[GroupUsers] CHECK CONSTRAINT [RefUsers52]
GO
ALTER TABLE [dbo].[InformationProduct]  WITH CHECK ADD  CONSTRAINT [RefCorpContainer25] FOREIGN KEY([ContainerType], [CorpFuncName], [CorpName])
REFERENCES [dbo].[CorpContainer] ([ContainerType], [CorpFuncName], [CorpName])
GO
ALTER TABLE [dbo].[InformationProduct] CHECK CONSTRAINT [RefCorpContainer25]
GO
ALTER TABLE [dbo].[InformationProduct]  WITH CHECK ADD  CONSTRAINT [RefInformationType36] FOREIGN KEY([InfoTypeCode])
REFERENCES [dbo].[InformationType] ([InfoTypeCode])
GO
ALTER TABLE [dbo].[InformationProduct] CHECK CONSTRAINT [RefInformationType36]
GO
ALTER TABLE [dbo].[InformationProduct]  WITH CHECK ADD  CONSTRAINT [RefRetention16] FOREIGN KEY([RetentionCode])
REFERENCES [dbo].[Retention] ([RetentionCode])
GO
ALTER TABLE [dbo].[InformationProduct] CHECK CONSTRAINT [RefRetention16]
GO
ALTER TABLE [dbo].[InformationProduct]  WITH CHECK ADD  CONSTRAINT [RefUD_Qty7] FOREIGN KEY([Code])
REFERENCES [dbo].[UD_Qty] ([Code])
GO
ALTER TABLE [dbo].[InformationProduct] CHECK CONSTRAINT [RefUD_Qty7]
GO
ALTER TABLE [dbo].[InformationProduct]  WITH CHECK ADD  CONSTRAINT [RefVolitility19] FOREIGN KEY([VolitilityCode])
REFERENCES [dbo].[Volitility] ([VolitilityCode])
GO
ALTER TABLE [dbo].[InformationProduct] CHECK CONSTRAINT [RefVolitility19]
GO
ALTER TABLE [dbo].[JargonWords]  WITH CHECK ADD  CONSTRAINT [RefBusinessJargonCode27] FOREIGN KEY([JargonCode])
REFERENCES [dbo].[BusinessJargonCode] ([JargonCode])
GO
ALTER TABLE [dbo].[JargonWords] CHECK CONSTRAINT [RefBusinessJargonCode27]
GO
ALTER TABLE [dbo].[LibDirectory]  WITH NOCHECK ADD  CONSTRAINT [RefLibrary124] FOREIGN KEY([UserID], [LibraryName])
REFERENCES [dbo].[Library] ([UserID], [LibraryName])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LibDirectory] CHECK CONSTRAINT [RefLibrary124]
GO
ALTER TABLE [dbo].[LibEmail]  WITH NOCHECK ADD  CONSTRAINT [RefLibrary123] FOREIGN KEY([UserID], [LibraryName])
REFERENCES [dbo].[Library] ([UserID], [LibraryName])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LibEmail] CHECK CONSTRAINT [RefLibrary123]
GO
ALTER TABLE [dbo].[Library]  WITH NOCHECK ADD  CONSTRAINT [FK__Library__UserID__1BB31344] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Library] CHECK CONSTRAINT [FK__Library__UserID__1BB31344]
GO
ALTER TABLE [dbo].[LibraryUsers]  WITH CHECK ADD  CONSTRAINT [RefUsers99] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[LibraryUsers] CHECK CONSTRAINT [RefUsers99]
GO
ALTER TABLE [dbo].[LoadProfileItem]  WITH CHECK ADD  CONSTRAINT [RefLoadProfile1271] FOREIGN KEY([ProfileName])
REFERENCES [dbo].[LoadProfile] ([ProfileName])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LoadProfileItem] CHECK CONSTRAINT [RefLoadProfile1271]
GO
ALTER TABLE [dbo].[LoadProfileItem]  WITH CHECK ADD  CONSTRAINT [RefSourceType1281] FOREIGN KEY([SourceTypeCode])
REFERENCES [dbo].[SourceType] ([SourceTypeCode])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[LoadProfileItem] CHECK CONSTRAINT [RefSourceType1281]
GO
ALTER TABLE [dbo].[ProdCaptureItems]  WITH CHECK ADD  CONSTRAINT [RefCaptureItems22] FOREIGN KEY([CaptureItemsCode])
REFERENCES [dbo].[CaptureItems] ([CaptureItemsCode])
GO
ALTER TABLE [dbo].[ProdCaptureItems] CHECK CONSTRAINT [RefCaptureItems22]
GO
ALTER TABLE [dbo].[ProdCaptureItems]  WITH CHECK ADD  CONSTRAINT [RefInformationProduct21] FOREIGN KEY([ContainerType], [CorpFuncName], [CorpName])
REFERENCES [dbo].[InformationProduct] ([ContainerType], [CorpFuncName], [CorpName])
GO
ALTER TABLE [dbo].[ProdCaptureItems] CHECK CONSTRAINT [RefInformationProduct21]
GO
ALTER TABLE [dbo].[QuickRef]  WITH CHECK ADD  CONSTRAINT [RefUsers112] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[QuickRef] CHECK CONSTRAINT [RefUsers112]
GO
ALTER TABLE [dbo].[QuickRefItems]  WITH CHECK ADD  CONSTRAINT [RefQuickRef115] FOREIGN KEY([QuickRefIdNbr])
REFERENCES [dbo].[QuickRef] ([QuickRefIdNbr])
GO
ALTER TABLE [dbo].[QuickRefItems] CHECK CONSTRAINT [RefQuickRef115]
GO
ALTER TABLE [dbo].[RssPull]  WITH CHECK ADD  CONSTRAINT [RssPullCascadeDelete] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RssPull] CHECK CONSTRAINT [RssPullCascadeDelete]
GO
ALTER TABLE [dbo].[SubDir]  WITH CHECK ADD  CONSTRAINT [RefDirectory15] FOREIGN KEY([UserID], [FQN])
REFERENCES [dbo].[Directory] ([UserID], [FQN])
GO
ALTER TABLE [dbo].[SubDir] CHECK CONSTRAINT [RefDirectory15]
GO
ALTER TABLE [dbo].[SubLibrary]  WITH CHECK ADD  CONSTRAINT [FK__SubLibrary__4BB72C21] FOREIGN KEY([SubUserID], [SubLibraryName])
REFERENCES [dbo].[Library] ([UserID], [LibraryName])
GO
ALTER TABLE [dbo].[SubLibrary] CHECK CONSTRAINT [FK__SubLibrary__4BB72C21]
GO
ALTER TABLE [dbo].[SubLibrary]  WITH CHECK ADD  CONSTRAINT [FK__SubLibrary__4CAB505A] FOREIGN KEY([UserID], [LibraryName])
REFERENCES [dbo].[Library] ([UserID], [LibraryName])
GO
ALTER TABLE [dbo].[SubLibrary] CHECK CONSTRAINT [FK__SubLibrary__4CAB505A]
GO
ALTER TABLE [dbo].[UserGroup]  WITH CHECK ADD  CONSTRAINT [FK__UserGroup__Group__2077C861] FOREIGN KEY([GroupOwnerUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[UserGroup] CHECK CONSTRAINT [FK__UserGroup__Group__2077C861]
GO
ALTER TABLE [dbo].[WebScreen]  WITH CHECK ADD  CONSTRAINT [WebScreenCascadeDelete] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebScreen] CHECK CONSTRAINT [WebScreenCascadeDelete]
GO
ALTER TABLE [dbo].[WebSite]  WITH CHECK ADD  CONSTRAINT [WebSiteCascadeDelete] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WebSite] CHECK CONSTRAINT [WebSiteCascadeDelete]
GO
ALTER TABLE [dbo].[upgrade_status]  WITH CHECK ADD CHECK  (([status]='COMPLETE' OR [status]='INCOMPLETE'))
GO
ALTER TABLE [dbo].[upgrade_status]  WITH CHECK ADD CHECK  (([status]='COMPLETE' OR [status]='INCOMPLETE'))
GO
ALTER TABLE [dbo].[upgrade_status]  WITH CHECK ADD CHECK  (([status]='COMPLETE' OR [status]='INCOMPLETE'))
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'This is a list of ASSIGNABLE user parameters - it takes admin authority to assign these.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AssignableUserParameters', @level2type=N'COLUMN',@level2name=N'ParmName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'If set to "Y", then all emails after download will be deleted from the exchange server.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'ExchangeHostPop', @level2type=N'COLUMN',@level2name=N'DeleteAfterDownload'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Library Name must be unique not just to the user, but across the organization. This allows public access for adding items to the library yet maintining owneraship by the creating user.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Library'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'LibraryItems is intentionally NOT linked to an owner through the user guid so that others can place content and emails into the library. The owner is determined by a lookup on the unique library name.

SourceGuid, in this case, can be either a content or email giud as both can live within a library.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LibraryItems'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Library Name must be unique not just to the user, but across the organization. This allows public access for adding items to the library yet maintining owneraship by the creating user.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SubLibrary'
GO

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

-- W. Dale Miller
-- DMA, Limited
-- Offered under GNU License
-- July 26, 2016

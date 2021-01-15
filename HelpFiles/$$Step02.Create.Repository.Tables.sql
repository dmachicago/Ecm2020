/****** Object:  FullTextCatalog [ECM.CONTENT.CAT]    Script Date: 07/20/2009 10:50:36 ******/
IF NOT EXISTS (SELECT * FROM sysfulltextcatalogs ftc WHERE ftc.name = N'ECM.CONTENT.CAT')
CREATE FULLTEXT CATALOG [ECM.CONTENT.CAT]WITH ACCENT_SENSITIVITY = ON
AS DEFAULT
AUTHORIZATION [dbo]
GO
/****** Object:  FullTextCatalog [ECM.EMAIL.CAT]    Script Date: 07/20/2009 10:50:36 ******/
IF NOT EXISTS (SELECT * FROM sysfulltextcatalogs ftc WHERE ftc.name = N'ECM.EMAIL.CAT')
CREATE FULLTEXT CATALOG [ECM.EMAIL.CAT]WITH ACCENT_SENSITIVITY = ON
AUTHORIZATION [dbo]
GO
/****** Object:  FullTextCatalog [ftCatalog]    Script Date: 07/20/2009 10:50:36 ******/
IF NOT EXISTS (SELECT * FROM sysfulltextcatalogs ftc WHERE ftc.name = N'ftCatalog')
CREATE FULLTEXT CATALOG [ftCatalog]WITH ACCENT_SENSITIVITY = ON
AUTHORIZATION [dbo]
GO
/****** Object:  FullTextCatalog [ftEmailCatalog]    Script Date: 07/20/2009 10:50:36 ******/
IF NOT EXISTS (SELECT * FROM sysfulltextcatalogs ftc WHERE ftc.name = N'ftEmailCatalog')
CREATE FULLTEXT CATALOG [ftEmailCatalog]WITH ACCENT_SENSITIVITY = ON
AUTHORIZATION [dbo]
GO
/****** Object:  Table [dbo].[ArchiveHistContentType]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveHistContentType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ArchiveHistContentType](
	[ArchiveID] [nvarchar](50) NOT NULL,
	[Directory] [nvarchar](254) NOT NULL,
	[FileType] [nvarchar](50) NOT NULL,
	[NbrFilesArchived] [int] NULL,
 CONSTRAINT [PK111] PRIMARY KEY NONCLUSTERED 
(
	[ArchiveID] ASC,
	[Directory] ASC,
	[FileType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  StoredProcedure [dbo].[CorporationSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CorporationSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[CorporationInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CorporationInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: CorporationInsProc 
 */

CREATE PROCEDURE [dbo].[CorporationInsProc]
(
    @CorpName     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Corporation(CorpName)
    VALUES(@CorpName)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''CorporationInsProc: Cannot insert because primary key value not found in Corporation ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[CorporationDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CorporationDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: CorporationDelProc 
 */

CREATE PROCEDURE [dbo].[CorporationDelProc]
(
    @CorpName     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Corporation
     WHERE CorpName = @CorpName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''CorporationDelProc: Cannot delete because foreign keys still exist in Corporation ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  Table [dbo].[CorpFunction]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CorpFunction]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CorpFunction](
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[CorpFuncDesc] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NULL,
	[CorpName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK1] PRIMARY KEY NONCLUSTERED 
(
	[CorpFuncName] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [CorpFunctionInsTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[CorpFunctionInsTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: CorpFunctionInsTrig 
 */

CREATE TRIGGER [dbo].[CorpFunctionInsTrig] ON [dbo].[CorpFunction]
FOR INSERT AS
BEGIN
    DECLARE
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Child Insert: RESTRICT

    IF ((SELECT COUNT(*)
         FROM Corporation pr, inserted
         WHERE pr.CorpName = inserted.CorpName) != @Rows)
    BEGIN
        RAISERROR 30000 ''CorpFunctionInsTrigCannot insert because primary key value not found in Corporation''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Table [dbo].[Corporation]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Corporation]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Corporation](
	[CorpName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK26] PRIMARY KEY CLUSTERED 
(
	[CorpName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ConvertedDocs]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConvertedDocs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ConvertedDocs](
	[FQN] [nvarchar](254) NOT NULL,
	[FileName] [nvarchar](254) NULL,
	[XMLName] [nvarchar](254) NULL,
	[XMLDIr] [nvarchar](254) NULL,
	[FileDir] [nvarchar](254) NULL,
	[CorpName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK25] PRIMARY KEY CLUSTERED 
(
	[FQN] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [ConvertedDocsUpdTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[ConvertedDocsUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: ConvertedDocsUpdTrig 
 */

CREATE TRIGGER [dbo].[ConvertedDocsUpdTrig] ON [dbo].[ConvertedDocs]
FOR UPDATE AS
BEGIN
    DECLARE
        @FQN nvarchar(254),
        @CorpName nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Child Update: RESTRICT

    IF (UPDATE(CorpName))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM Corporation pr, inserted
          WHERE pr.CorpName = inserted.CorpName) != @Rows)
        BEGIN
            RAISERROR 30001 ''ConvertedDocsUpdTrigCannot update because primary key value not found in Corporation''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [ConvertedDocsInsTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[ConvertedDocsInsTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: ConvertedDocsInsTrig 
 */

CREATE TRIGGER [dbo].[ConvertedDocsInsTrig] ON [dbo].[ConvertedDocs]
FOR INSERT AS
BEGIN
    DECLARE
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Child Insert: RESTRICT

    IF ((SELECT COUNT(*)
         FROM Corporation pr, inserted
         WHERE pr.CorpName = inserted.CorpName) != @Rows)
    BEGIN
        RAISERROR 30000 ''ConvertedDocsInsTrigCannot insert because primary key value not found in Corporation''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Table [dbo].[SourceAttribute]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceAttribute]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SourceAttribute](
	[AttributeValue] [nvarchar](254) NULL,
	[AttributeName] [nvarchar](50) NOT NULL,
	[SourceGuid] [nvarchar](50) NOT NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NOT NULL,
	[SourceTypeCode] [nvarchar](50) NULL,
 CONSTRAINT [PK35] PRIMARY KEY NONCLUSTERED 
(
	[AttributeName] ASC,
	[SourceGuid] ASC,
	[DataSourceOwnerUserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DataSource]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataSource]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DataSource](
	[SourceGuid] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[SourceName] [nvarchar](254) NULL,
	[SourceImage] [image] NULL,
	[SourceTypeCode] [nvarchar](50) NOT NULL,
	[FQN] [nvarchar](254) NULL,
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
	[ZipFileFQN] [nvarchar](254) NULL,
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
 CONSTRAINT [PK33_04012008185318001] PRIMARY KEY NONCLUSTERED 
(
	[SourceGuid] ASC,
	[DataSourceOwnerUserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = ON, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DataSource]') AND name = N'_dta_index_DataSource_11_773577794__K1_K3_2_5_6_7_8_9_10_12_13_14')
CREATE NONCLUSTERED INDEX [_dta_index_DataSource_11_773577794__K1_K3_2_5_6_7_8_9_10_12_13_14] ON [dbo].[DataSource] 
(
	[SourceGuid] ASC,
	[SourceName] ASC
)
INCLUDE ( [CreateDate],
[SourceTypeCode],
[FQN],
[VersionNbr],
[LastAccessDate],
[FileLength],
[LastWriteTime],
[DataSourceOwnerUserID],
[isPublic],
[FileDirectory]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DataSource]') AND name = N'PI_DIR')
CREATE NONCLUSTERED INDEX [PI_DIR] ON [dbo].[DataSource] 
(
	[DataSourceOwnerUserID] ASC,
	[FileDirectory] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DataSource]') AND name = N'PI_FQN_USERID')
CREATE NONCLUSTERED INDEX [PI_FQN_USERID] ON [dbo].[DataSource] 
(
	[FQN] ASC,
	[DataSourceOwnerUserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DataSource]') AND name = N'UI_DataSource_01')
CREATE UNIQUE NONCLUSTERED INDEX [UI_DataSource_01] ON [dbo].[DataSource] 
(
	[FQN] ASC,
	[VersionNbr] ASC,
	[DataSourceOwnerUserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DataSource]') AND name = N'UKI_Documents')
CREATE UNIQUE NONCLUSTERED INDEX [UKI_Documents] ON [dbo].[DataSource] 
(
	[SourceGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF not EXISTS (SELECT * FROM sys.fulltext_indexes fti WHERE fti.object_id = OBJECT_ID(N'[dbo].[DataSource]'))
CREATE FULLTEXT INDEX ON [dbo].[DataSource](
[Description] LANGUAGE [English], 
[KeyWords] LANGUAGE [English], 
[Notes] LANGUAGE [English], 
[OcrText] LANGUAGE [English], 
[SourceImage] TYPE COLUMN [SourceTypeCode] LANGUAGE [English], 
[SourceName] LANGUAGE [English])
KEY INDEX [UKI_Documents]ON ([ftCatalog], FILEGROUP [PRIMARY])
WITH (CHANGE_TRACKING = AUTO, STOPLIST = SYSTEM)
GO
/****** Object:  Table [dbo].[DataSourceRestoreHistory]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataSourceRestoreHistory]') AND type in (N'U'))
BEGIN
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
 CONSTRAINT [PK83] PRIMARY KEY CLUSTERED 
(
	[SeqNo] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DataSourceRestoreHistory]') AND name = N'PI01_RestoreHist')
CREATE NONCLUSTERED INDEX [PI01_RestoreHist] ON [dbo].[DataSourceRestoreHistory] 
(
	[DataSourceOwnerUserID] ASC,
	[TypeContentCode] ASC,
	[VerifiedData] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[InformationProductUpdProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InformationProductUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: InformationProductUpdProc 
 */

CREATE PROCEDURE [dbo].[InformationProductUpdProc]
(
    @CreateDate         datetime                = NULL,
    @Code               char(10),
    @RetentionCode      nvarchar(50),
    @VolitilityCode     nvarchar(50),
    @ContainerType      nvarchar(25),
    @CorpFuncName       nvarchar(80),
    @InfoTypeCode       nvarchar(50),
    @CorpName           nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    UPDATE InformationProduct
       SET CreateDate          = @CreateDate,
           Code                = @Code,
           RetentionCode       = @RetentionCode,
           VolitilityCode      = @VolitilityCode,
           InfoTypeCode        = @InfoTypeCode
     WHERE ContainerType = @ContainerType
       AND CorpFuncName  = @CorpFuncName
       AND CorpName      = @CorpName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''InformationProductUpdProc: Cannot update  in InformationProduct ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[InformationProductSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InformationProductSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[InformationProductInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InformationProductInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: InformationProductInsProc 
 */

CREATE PROCEDURE [dbo].[InformationProductInsProc]
(
    @CreateDate         datetime                = NULL,
    @Code               char(10),
    @RetentionCode      nvarchar(50),
    @VolitilityCode     nvarchar(50),
    @ContainerType      nvarchar(25),
    @CorpFuncName       nvarchar(80),
    @InfoTypeCode       nvarchar(50),
    @CorpName           nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO InformationProduct(CreateDate,
                                   Code,
                                   RetentionCode,
                                   VolitilityCode,
                                   ContainerType,
                                   CorpFuncName,
                                   InfoTypeCode,
                                   CorpName)
    VALUES(@CreateDate,
           @Code,
           @RetentionCode,
           @VolitilityCode,
           @ContainerType,
           @CorpFuncName,
           @InfoTypeCode,
           @CorpName)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''InformationProductInsProc: Cannot insert because primary key value not found in InformationProduct ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[InformationProductDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InformationProductDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: InformationProductDelProc 
 */

CREATE PROCEDURE [dbo].[InformationProductDelProc]
(
    @ContainerType      nvarchar(25),
    @CorpFuncName       nvarchar(80),
    @CorpName           nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM InformationProduct
     WHERE ContainerType = @ContainerType
       AND CorpFuncName  = @CorpFuncName
       AND CorpName      = @CorpName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''InformationProductDelProc: Cannot delete because foreign keys still exist in InformationProduct ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  Table [dbo].[CorpContainer]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CorpContainer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CorpContainer](
	[ContainerType] [nvarchar](25) NOT NULL,
	[QtyDocCode] [nvarchar](10) NOT NULL,
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[CorpName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK2] PRIMARY KEY NONCLUSTERED 
(
	[ContainerType] ASC,
	[CorpFuncName] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CorpContainer]') AND name = N'Ref32')
CREATE NONCLUSTERED INDEX [Ref32] ON [dbo].[CorpContainer] 
(
	[ContainerType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Trigger [CorpContainerDelTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[CorpContainerDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: CorpContainerDelTrig 
 */

CREATE TRIGGER [dbo].[CorpContainerDelTrig] ON [dbo].[CorpContainer]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM InformationProduct ch, deleted
         WHERE ch.CorpFuncName = deleted.CorpFuncName AND
           ch.ContainerType = deleted.ContainerType AND
           ch.CorpName = deleted.CorpName) != 0)
    BEGIN
        RAISERROR 30002 ''CorpContainerDelTrigCannot delete because foreign keys still exist in InformationProduct''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Table [dbo].[InformationProduct]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InformationProduct]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InformationProduct](
	[CreateDate] [datetime] NULL,
	[Code] [char](10) NOT NULL,
	[RetentionCode] [nvarchar](50) NOT NULL,
	[VolitilityCode] [nvarchar](50) NOT NULL,
	[ContainerType] [nvarchar](25) NOT NULL,
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[InfoTypeCode] [nvarchar](50) NOT NULL,
	[CorpName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK5] PRIMARY KEY NONCLUSTERED 
(
	[ContainerType] ASC,
	[CorpFuncName] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[InformationProduct]') AND name = N'Ref47')
CREATE NONCLUSTERED INDEX [Ref47] ON [dbo].[InformationProduct] 
(
	[Code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Volitility]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Volitility]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Volitility](
	[VolitilityCode] [nvarchar](50) NOT NULL,
	[VolitilityDesc] [nvarchar](18) NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK19] PRIMARY KEY CLUSTERED 
(
	[VolitilityCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [VolitilityUpdTrig]    Script Date: 07/20/2009 10:50:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[VolitilityUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: VolitilityUpdTrig 
 */

CREATE TRIGGER [dbo].[VolitilityUpdTrig] ON [dbo].[Volitility]
FOR UPDATE AS
BEGIN
    DECLARE
        @VolitilityCode nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: RESTRICT

    IF (UPDATE(VolitilityCode))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM InformationProduct ch, deleted
          WHERE ch.VolitilityCode = deleted.VolitilityCode) != 0)
        BEGIN
            RAISERROR 30001 ''VolitilityUpdTrigCannot update because foreign keys still exist in InformationProduct''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [VolitilityDelTrig]    Script Date: 07/20/2009 10:50:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[VolitilityDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: VolitilityDelTrig 
 */

CREATE TRIGGER [dbo].[VolitilityDelTrig] ON [dbo].[Volitility]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM InformationProduct ch, deleted
         WHERE ch.VolitilityCode = deleted.VolitilityCode) != 0)
    BEGIN
        RAISERROR 30002 ''VolitilityDelTrigCannot delete because foreign keys still exist in InformationProduct''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  StoredProcedure [dbo].[VolitilityUpdProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VolitilityUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: VolitilityUpdProc 
 */

CREATE PROCEDURE [dbo].[VolitilityUpdProc]
(
    @VolitilityCode     nvarchar(50),
    @VolitilityDesc     nvarchar(18)            = NULL,
    @CreateDate         datetime                = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE Volitility
       SET VolitilityDesc      = @VolitilityDesc,
           CreateDate          = @CreateDate
     WHERE VolitilityCode = @VolitilityCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''VolitilityUpdProc: Cannot update  in Volitility ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[VolitilitySelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VolitilitySelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[VolitilityInsProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VolitilityInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: VolitilityInsProc 
 */

CREATE PROCEDURE [dbo].[VolitilityInsProc]
(
    @VolitilityCode     nvarchar(50),
    @VolitilityDesc     nvarchar(18)            = NULL,
    @CreateDate         datetime                = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Volitility(VolitilityCode,
                           VolitilityDesc,
                           CreateDate)
    VALUES(@VolitilityCode,
           @VolitilityDesc,
           @CreateDate)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''VolitilityInsProc: Cannot insert because primary key value not found in Volitility ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[VolitilityDelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[VolitilityDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: VolitilityDelProc 
 */

CREATE PROCEDURE [dbo].[VolitilityDelProc]
(
    @VolitilityCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Volitility
     WHERE VolitilityCode = @VolitilityCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''VolitilityDelProc: Cannot delete because foreign keys still exist in Volitility ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  Table [dbo].[ZippedFiles]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZippedFiles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ZippedFiles](
	[ContentGUID] [nvarchar](50) NOT NULL,
	[SourceTypeCode] [nvarchar](50) NULL,
	[SourceImage] [image] NULL,
	[SourceGuid] [nvarchar](50) NOT NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK88] PRIMARY KEY CLUSTERED 
(
	[ContentGUID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Users]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Users](
	[UserID] [nvarchar](50) NOT NULL,
	[UserName] [nvarchar](50) NOT NULL,
	[EmailAddress] [nvarchar](254) NULL,
	[UserPassword] [nvarchar](254) NULL,
	[Admin] [nchar](1) NULL,
	[isActive] [nchar](1) NULL,
	[UserLoginID] [nvarchar](50) NULL,
 CONSTRAINT [PK41] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND name = N'UK_LoginID')
CREATE UNIQUE NONCLUSTERED INDEX [UK_LoginID] ON [dbo].[Users] 
(
	[UserLoginID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserGroup]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserGroup](
	[GroupOwnerUserID] [nvarchar](50) NOT NULL,
	[GroupName] [nvarchar](80) NOT NULL,
 CONSTRAINT [PK43] PRIMARY KEY CLUSTERED 
(
	[GroupOwnerUserID] ASC,
	[GroupName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[UserGroup]') AND name = N'UI_UserGroup')
CREATE UNIQUE NONCLUSTERED INDEX [UI_UserGroup] ON [dbo].[UserGroup] 
(
	[GroupName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmailAttachmentSearchList]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailAttachmentSearchList]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EmailAttachmentSearchList](
	[UserID] [nvarchar](50) NOT NULL,
	[EmailGuid] [nvarchar](50) NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EmailAttachmentSearchList]') AND name = N'PK_EmailAttachmentSearchList')
CREATE CLUSTERED INDEX [PK_EmailAttachmentSearchList] ON [dbo].[EmailAttachmentSearchList] 
(
	[EmailGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EmailAttachmentSearchList]') AND name = N'PI_01_AttchSearch')
CREATE NONCLUSTERED INDEX [PI_01_AttchSearch] ON [dbo].[EmailAttachmentSearchList] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmailArchParms]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailArchParms]') AND type in (N'U'))
BEGIN
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
 CONSTRAINT [PK5EmailArchParms] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[FolderName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Databases]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Databases]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Databases](
	[DB_ID] [nvarchar](50) NOT NULL,
	[DB_CONN_STR] [nvarchar](254) NULL,
 CONSTRAINT [PK6Databases] PRIMARY KEY CLUSTERED 
(
	[DB_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Directory]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Directory]') AND type in (N'U'))
BEGIN
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
 CONSTRAINT [PKII2] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[FQN] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DataSourceCheckOut]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataSourceCheckOut]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DataSourceCheckOut](
	[SourceGuid] [nvarchar](50) NOT NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NOT NULL,
	[CheckedOutByUserID] [nvarchar](50) NOT NULL,
	[isReadOnly] [bit] NULL,
	[isForUpdate] [bit] NULL,
	[checkOutDate] [datetime] NULL,
 CONSTRAINT [PK82] PRIMARY KEY NONCLUSTERED 
(
	[CheckedOutByUserID] ASC,
	[SourceGuid] ASC,
	[DataSourceOwnerUserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CoOwner]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CoOwner]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CoOwner](
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[CurrentOwnerUserID] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
	[PreviousOwnerUserID] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK76_1] PRIMARY KEY NONCLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CoOwner]') AND name = N'UK_CoOwner')
CREATE UNIQUE NONCLUSTERED INDEX [UK_CoOwner] ON [dbo].[CoOwner] 
(
	[CurrentOwnerUserID] ASC,
	[PreviousOwnerUserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UD_Qty]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UD_Qty]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UD_Qty](
	[Code] [char](10) NOT NULL,
	[Description] [char](10) NULL,
 CONSTRAINT [PK4] PRIMARY KEY NONCLUSTERED 
(
	[Code] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [UD_QtyUpdTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[UD_QtyUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: UD_QtyUpdTrig 
 */

CREATE TRIGGER [dbo].[UD_QtyUpdTrig] ON [dbo].[UD_Qty]
FOR UPDATE AS
BEGIN
    DECLARE
        @Code char(10),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: RESTRICT

    IF (UPDATE(Code))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM InformationProduct ch, deleted
          WHERE ch.Code = deleted.Code) != 0)
        BEGIN
            RAISERROR 30001 ''UD_QtyUpdTrigCannot update because foreign keys still exist in InformationProduct''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [UD_QtyDelTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[UD_QtyDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: UD_QtyDelTrig 
 */

CREATE TRIGGER [dbo].[UD_QtyDelTrig] ON [dbo].[UD_Qty]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM InformationProduct ch, deleted
         WHERE ch.Code = deleted.Code) != 0)
    BEGIN
        RAISERROR 30002 ''UD_QtyDelTrigCannot delete because foreign keys still exist in InformationProduct''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Table [dbo].[SubDir]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SubDir]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SubDir](
	[UserID] [nvarchar](50) NOT NULL,
	[SUBFQN] [nvarchar](254) NOT NULL,
	[FQN] [varchar](254) NOT NULL,
	[ckPublic] [nchar](1) NULL,
	[ckDisableDir] [nchar](1) NULL,
	[OcrDirectory] [nchar](1) NULL,
	[VersionFiles] [nchar](1) NULL,
	[isSysDefault] [bit] NULL,
 CONSTRAINT [PKI14] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[FQN] ASC,
	[SUBFQN] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[SourceContainerUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceContainerUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: SourceContainerUpdProc 
 */

CREATE PROCEDURE [dbo].[SourceContainerUpdProc]
(
    @ContainerType     nvarchar(25),
    @ContainerDesc     nvarchar(4000)            = NULL,
    @CreateDate        datetime                  = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE SourceContainer
       SET ContainerDesc      = @ContainerDesc,
           CreateDate         = @CreateDate
     WHERE ContainerType = @ContainerType

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''SourceContainerUpdProc: Cannot update  in SourceContainer ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SourceContainerSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceContainerSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SourceContainerInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceContainerInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: SourceContainerInsProc 
 */

CREATE PROCEDURE [dbo].[SourceContainerInsProc]
(
    @ContainerType     nvarchar(25),
    @ContainerDesc     nvarchar(4000)            = NULL,
    @CreateDate        datetime                  = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO SourceContainer(ContainerType,
                                ContainerDesc,
                                CreateDate)
    VALUES(@ContainerType,
           @ContainerDesc,
           @CreateDate)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''SourceContainerInsProc: Cannot insert because primary key value not found in SourceContainer ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SourceContainerDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceContainerDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: SourceContainerDelProc 
 */

CREATE PROCEDURE [dbo].[SourceContainerDelProc]
(
    @ContainerType     nvarchar(25))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM SourceContainer
     WHERE ContainerType = @ContainerType

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''SourceContainerDelProc: Cannot delete because foreign keys still exist in SourceContainer ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  Table [dbo].[SourceType]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SourceType](
	[SourceTypeCode] [nvarchar](50) NOT NULL,
	[StoreExternal] [bit] NULL,
	[SourceTypeDesc] [nvarchar](254) NULL,
	[Indexable] [bit] NULL,
 CONSTRAINT [PK34] PRIMARY KEY CLUSTERED 
(
	[SourceTypeCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[LoadProfileItem]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadProfileItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LoadProfileItem](
	[ProfileName] [nvarchar](50) NOT NULL,
	[SourceTypeCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK102] PRIMARY KEY NONCLUSTERED 
(
	[ProfileName] ASC,
	[SourceTypeCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[LibraryUsers]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibraryUsers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LibraryUsers](
	[ReadOnly] [bit] NULL,
	[CreateAccess] [bit] NULL,
	[UpdateAccess] [bit] NULL,
	[DeleteAccess] [bit] NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[LibraryOwnerUserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
 CONSTRAINT [PK87] PRIMARY KEY NONCLUSTERED 
(
	[LibraryOwnerUserID] ASC,
	[LibraryName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LibraryUsers]') AND name = N'PI01_LibUsers')
CREATE NONCLUSTERED INDEX [PI01_LibUsers] ON [dbo].[LibraryUsers] 
(
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LibraryUsers]') AND name = N'PI02_LibUers')
CREATE NONCLUSTERED INDEX [PI02_LibUers] ON [dbo].[LibraryUsers] 
(
	[LibraryName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Library]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Library]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Library](
	[UserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[isPublic] [nchar](1) NOT NULL,
 CONSTRAINT [PK52] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[LibraryName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Library]') AND name = N'CI01_Library')
CREATE NONCLUSTERED INDEX [CI01_Library] ON [dbo].[Library] 
(
	[UserID] ASC,
	[LibraryName] ASC,
	[isPublic] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Library]') AND name = N'UI_LibraryName')
CREATE UNIQUE NONCLUSTERED INDEX [UI_LibraryName] ON [dbo].[Library] 
(
	[LibraryName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'Library', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Library Name must be unique not just to the user, but across the organization. This allows public access for adding items to the library yet maintining owneraship by the creating user.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Library'
GO
/****** Object:  Table [dbo].[SubLibrary]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SubLibrary]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SubLibrary](
	[UserID] [nvarchar](50) NOT NULL,
	[SubUserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[SubLibraryName] [nvarchar](80) NOT NULL,
 CONSTRAINT [PK90] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[LibraryName] ASC,
	[SubUserID] ASC,
	[SubLibraryName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'SubLibrary', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The Library Name must be unique not just to the user, but across the organization. This allows public access for adding items to the library yet maintining owneraship by the creating user.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SubLibrary'
GO
/****** Object:  Table [dbo].[GroupLibraryAccess]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GroupLibraryAccess]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GroupLibraryAccess](
	[UserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[GroupOwnerUserID] [nvarchar](50) NOT NULL,
	[GroupName] [nvarchar](80) NOT NULL,
 CONSTRAINT [PK70] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[LibraryName] ASC,
	[GroupOwnerUserID] ASC,
	[GroupName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[GroupLibraryAccess]') AND name = N'PI01_GroupLibAccess')
CREATE NONCLUSTERED INDEX [PI01_GroupLibAccess] ON [dbo].[GroupLibraryAccess] 
(
	[UserID] ASC,
	[LibraryName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LibEmail]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibEmail]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LibEmail](
	[EmailFolderEntryID] [nvarchar](200) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[FolderName] [nvarchar](250) NULL,
 CONSTRAINT [PK99] PRIMARY KEY CLUSTERED 
(
	[EmailFolderEntryID] ASC,
	[UserID] ASC,
	[LibraryName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LibEmail]') AND name = N'PI01_LibEmail')
CREATE NONCLUSTERED INDEX [PI01_LibEmail] ON [dbo].[LibEmail] 
(
	[EmailFolderEntryID] ASC,
	[FolderName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LibDirectory]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibDirectory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LibDirectory](
	[DirectoryName] [nvarchar](254) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
 CONSTRAINT [PK98] PRIMARY KEY CLUSTERED 
(
	[DirectoryName] ASC,
	[UserID] ASC,
	[LibraryName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[InformationType]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InformationType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InformationType](
	[CreateDate] [datetime] NULL,
	[InfoTypeCode] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](4000) NULL,
 CONSTRAINT [PK6] PRIMARY KEY NONCLUSTERED 
(
	[InfoTypeCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [InformationTypeUpdTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[InformationTypeUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: InformationTypeUpdTrig 
 */

CREATE TRIGGER [dbo].[InformationTypeUpdTrig] ON [dbo].[InformationType]
FOR UPDATE AS
BEGIN
    DECLARE
        @InfoTypeCode nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: RESTRICT

    IF (UPDATE(InfoTypeCode))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM InformationProduct ch, deleted
          WHERE ch.InfoTypeCode = deleted.InfoTypeCode) != 0)
        BEGIN
            RAISERROR 30001 ''InformationTypeUpdTrigCannot update because foreign keys still exist in InformationProduct''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [InformationTypeDelTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[InformationTypeDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: InformationTypeDelTrig 
 */

CREATE TRIGGER [dbo].[InformationTypeDelTrig] ON [dbo].[InformationType]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM InformationProduct ch, deleted
         WHERE ch.InfoTypeCode = deleted.InfoTypeCode) != 0)
    BEGIN
        RAISERROR 30002 ''InformationTypeDelTrigCannot delete because foreign keys still exist in InformationProduct''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Table [dbo].[GroupUsers]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GroupUsers]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GroupUsers](
	[UserID] [nvarchar](50) NOT NULL,
	[FullAccess] [bit] NULL,
	[ReadOnlyAccess] [bit] NULL,
	[DeleteAccess] [bit] NULL,
	[Searchable] [bit] NULL,
	[GroupOwnerUserID] [nvarchar](50) NOT NULL,
	[GroupName] [nvarchar](80) NOT NULL,
 CONSTRAINT [PK44] PRIMARY KEY NONCLUSTERED 
(
	[GroupName] ASC,
	[UserID] ASC,
	[GroupOwnerUserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[GroupUsers]') AND name = N'PI_GroupUsers')
CREATE NONCLUSTERED INDEX [PI_GroupUsers] ON [dbo].[GroupUsers] 
(
	[GroupOwnerUserID] ASC,
	[GroupName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[GroupUsers]') AND name = N'PI01_GroupUser')
CREATE NONCLUSTERED INDEX [PI01_GroupUser] ON [dbo].[GroupUsers] 
(
	[UserID] ASC,
	[GroupName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuickRef]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuickRef]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QuickRef](
	[UserID] [nvarchar](50) NOT NULL,
	[QuickRefName] [nvarchar](50) NULL,
	[QuickRefIdNbr] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK91] PRIMARY KEY CLUSTERED 
(
	[QuickRefIdNbr] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[QuickRef]') AND name = N'UK_QuickRef')
CREATE UNIQUE NONCLUSTERED INDEX [UK_QuickRef] ON [dbo].[QuickRef] 
(
	[UserID] ASC,
	[QuickRefName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuickRefItems]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuickRefItems]') AND type in (N'U'))
BEGIN
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
 CONSTRAINT [PK93] PRIMARY KEY CLUSTERED 
(
	[QuickRefItemGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[QuickRefItems]') AND name = N'PI01_QuickRef')
CREATE NONCLUSTERED INDEX [PI01_QuickRef] ON [dbo].[QuickRefItems] 
(
	[FQN] ASC,
	[DataSourceOwnerUserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[QuickRefItems]') AND name = N'PI02_QuickRef')
CREATE NONCLUSTERED INDEX [PI02_QuickRef] ON [dbo].[QuickRefItems] 
(
	[DirName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[QuickRefItems]') AND name = N'UK_QuickRef01')
CREATE UNIQUE NONCLUSTERED INDEX [UK_QuickRef01] ON [dbo].[QuickRefItems] 
(
	[QuickRefIdNbr] ASC,
	[FQN] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OwnerHistory]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OwnerHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OwnerHistory](
	[PreviousOwnerUserID] [nvarchar](50) NULL,
	[RowId] [int] IDENTITY(1,1) NOT NULL,
	[CurrentOwnerUserID] [nvarchar](50) NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK76] PRIMARY KEY NONCLUSTERED 
(
	[RowId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Email]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Email]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Email](
	[EmailGuid] [nvarchar](50) NOT NULL,
	[SUBJECT] [nvarchar](2000) NULL,
	[SentTO] [nvarchar](2000) NULL,
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
	[EmailImage] [image] NULL,
	[Accounts] [nvarchar](2000) NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL,
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
	[CRC] [varchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[KeyWords] [nvarchar](2000) NULL,
 CONSTRAINT [PK27] PRIMARY KEY CLUSTERED 
(
	[EmailGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = ON, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Email]') AND name = N'_dta_index_Email_11_1253579504__K1')
CREATE NONCLUSTERED INDEX [_dta_index_Email_11_1253579504__K1] ON [dbo].[Email] 
(
	[EmailGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Email]') AND name = N'_dta_index_Email_11_1253579504__K15_K16')
CREATE NONCLUSTERED INDEX [_dta_index_Email_11_1253579504__K15_K16] ON [dbo].[Email] 
(
	[SenderEmailAddress] ASC,
	[SenderName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Email]') AND name = N'_dta_index_Email_11_1253579504__K29_9')
CREATE NONCLUSTERED INDEX [_dta_index_Email_11_1253579504__K29_9] ON [dbo].[Email] 
(
	[OriginalFolder] ASC
)
INCLUDE ( [CreationTime]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Email]') AND name = N'FULL_UI_EMAIL')
CREATE UNIQUE NONCLUSTERED INDEX [FULL_UI_EMAIL] ON [dbo].[Email] 
(
	[ReceivedByName] ASC,
	[ReceivedTime] ASC,
	[SenderEmailAddress] ASC,
	[SenderName] ASC,
	[SentOn] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Email]') AND name = N'PI_EMAIL_01')
CREATE NONCLUSTERED INDEX [PI_EMAIL_01] ON [dbo].[Email] 
(
	[ReceivedTime] ASC,
	[SentOn] ASC,
	[ShortSubj] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Email]') AND name = N'PI_EmailSearch')
CREATE NONCLUSTERED INDEX [PI_EmailSearch] ON [dbo].[Email] 
(
	[SenderEmailAddress] ASC,
	[SentOn] ASC,
	[ShortSubj] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Email]') AND name = N'PI_OriginalFolder')
CREATE NONCLUSTERED INDEX [PI_OriginalFolder] ON [dbo].[Email] 
(
	[OriginalFolder] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Email]') AND name = N'PI_ReceivedByName')
CREATE NONCLUSTERED INDEX [PI_ReceivedByName] ON [dbo].[Email] 
(
	[ReceivedByName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Email]') AND name = N'PI_SenderEmailAddress')
CREATE NONCLUSTERED INDEX [PI_SenderEmailAddress] ON [dbo].[Email] 
(
	[SenderEmailAddress] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Email]') AND name = N'PI_SenderName')
CREATE NONCLUSTERED INDEX [PI_SenderName] ON [dbo].[Email] 
(
	[SenderName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Email]') AND name = N'PI_Storeid')
CREATE NONCLUSTERED INDEX [PI_Storeid] ON [dbo].[Email] 
(
	[EntryID] ASC,
	[StoreID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Email]') AND name = N'PI01_EmailAttach')
CREATE NONCLUSTERED INDEX [PI01_EmailAttach] ON [dbo].[Email] 
(
	[EmailGuid] ASC,
	[NbrAttachments] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Email]') AND name = N'PI02_EmailAttach')
CREATE NONCLUSTERED INDEX [PI02_EmailAttach] ON [dbo].[Email] 
(
	[EmailGuid] ASC,
	[NbrAttachments] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Email]') AND name = N'UK_EMAIL')
CREATE UNIQUE NONCLUSTERED INDEX [UK_EMAIL] ON [dbo].[Email] 
(
	[RowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF not EXISTS (SELECT * FROM sys.fulltext_indexes fti WHERE fti.object_id = OBJECT_ID(N'[dbo].[Email]'))
CREATE FULLTEXT INDEX ON [dbo].[Email](
[Body] LANGUAGE [English], 
[Description] LANGUAGE [English], 
[KeyWords] LANGUAGE [English], 
[SUBJECT] LANGUAGE [English])
KEY INDEX [PK27]ON ([ftEmailCatalog], FILEGROUP [PRIMARY])
WITH (CHANGE_TRACKING = AUTO, STOPLIST = SYSTEM)
GO
/****** Object:  Table [dbo].[Recipients]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Recipients]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Recipients](
	[Recipient] [nvarchar](254) NOT NULL,
	[EmailGuid] [nvarchar](50) NOT NULL,
	[TypeRecp] [nchar](10) NULL,
 CONSTRAINT [PK32A] PRIMARY KEY CLUSTERED 
(
	[Recipient] ASC,
	[EmailGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Retention]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Retention]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Retention](
	[RetentionCode] [nvarchar](50) NOT NULL,
	[RetentionDesc] [nvarchar](18) NULL,
 CONSTRAINT [PK16] PRIMARY KEY CLUSTERED 
(
	[RetentionCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [RetentionUpdTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[RetentionUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: RetentionUpdTrig 
 */

CREATE TRIGGER [dbo].[RetentionUpdTrig] ON [dbo].[Retention]
FOR UPDATE AS
BEGIN
    DECLARE
        @RetentionCode nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: RESTRICT

    IF (UPDATE(RetentionCode))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM InformationProduct ch, deleted
          WHERE ch.RetentionCode = deleted.RetentionCode) != 0)
        BEGIN
            RAISERROR 30001 ''RetentionUpdTrigCannot update because foreign keys still exist in InformationProduct''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [RetentionDelTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[RetentionDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: RetentionDelTrig 
 */

CREATE TRIGGER [dbo].[RetentionDelTrig] ON [dbo].[Retention]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM InformationProduct ch, deleted
         WHERE ch.RetentionCode = deleted.RetentionCode) != 0)
    BEGIN
        RAISERROR 30002 ''RetentionDelTrigCannot delete because foreign keys still exist in InformationProduct''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Table [dbo].[RestorationHistory]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RestorationHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RestorationHistory](
	[SourceType] [nvarchar](50) NOT NULL,
	[SourceGuid] [nvarchar](50) NOT NULL,
	[OriginalCrc] [nvarchar](50) NOT NULL,
	[RestoredCrc] [nvarchar](50) NOT NULL,
	[RestorationDate] [nchar](10) NOT NULL,
	[RestorationID] [int] IDENTITY(1,1) NOT NULL,
	[RestoredBy] [nvarchar](50) NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RestorationHistory]') AND name = N'PI01_RestorationHistoryGuid')
CREATE NONCLUSTERED INDEX [PI01_RestorationHistoryGuid] ON [dbo].[RestorationHistory] 
(
	[SourceGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RestorationHistory]') AND name = N'PI02_RestorationHistory')
CREATE NONCLUSTERED INDEX [PI02_RestorationHistory] ON [dbo].[RestorationHistory] 
(
	[RestoredBy] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RestorationHistory]') AND name = N'PI03_RestorationHistory')
CREATE NONCLUSTERED INDEX [PI03_RestorationHistory] ON [dbo].[RestorationHistory] 
(
	[OriginalCrc] ASC,
	[RestoredCrc] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RestorationHistory]') AND name = N'PI04_RestorationHistory')
CREATE NONCLUSTERED INDEX [PI04_RestorationHistory] ON [dbo].[RestorationHistory] 
(
	[RestoredBy] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[ResponseUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ResponseUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: ResponseUpdProc 
 */

CREATE PROCEDURE [dbo].[ResponseUpdProc]
(
    @Response         nvarchar(max)            = NULL,
    @ResponseDate     datetime,
    @StatusCode       nvarchar(50),
    @ResponseID       int,
    @LastUpdate       datetime                 = NULL,
    @CreateDate       datetime                 = NULL,
    @EMail            nvarchar(100),
    @IssueTitle       nvarchar(400))
AS
BEGIN
    BEGIN TRAN

    UPDATE Response
       SET Response          = @Response,
           ResponseDate      = @ResponseDate,
           StatusCode        = @StatusCode,
           LastUpdate        = @LastUpdate,
           CreateDate        = @CreateDate
     WHERE ResponseID = @ResponseID
       AND EMail      = @EMail
       AND IssueTitle = @IssueTitle

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''ResponseUpdProc: Cannot update  in Response ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ResponseSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ResponseSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ResponseInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ResponseInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: ResponseInsProc 
 */

CREATE PROCEDURE [dbo].[ResponseInsProc]
(
    @Response         nvarchar(max)            = NULL,
    @ResponseDate     datetime,
    @StatusCode       nvarchar(50),
    @LastUpdate       datetime                 = NULL,
    @CreateDate       datetime                 = NULL,
    @EMail            nvarchar(100),
    @IssueTitle       nvarchar(400))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Response(Response,
                         ResponseDate,
                         StatusCode,
                         LastUpdate,
                         CreateDate,
                         EMail,
                         IssueTitle)
    VALUES(@Response,
           @ResponseDate,
           @StatusCode,
           @LastUpdate,
           @CreateDate,
           @EMail,
           @IssueTitle)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''ResponseInsProc: Cannot insert because primary key value not found in Response ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[ResponseDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ResponseDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: ResponseDelProc 
 */

CREATE PROCEDURE [dbo].[ResponseDelProc]
(
    @ResponseID       int,
    @EMail            nvarchar(100),
    @IssueTitle       nvarchar(400))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Response
     WHERE ResponseID = @ResponseID
       AND EMail      = @EMail
       AND IssueTitle = @IssueTitle

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''ResponseDelProc: Cannot delete because foreign keys still exist in Response ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  Table [dbo].[RetentionTemp]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RetentionTemp]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RetentionTemp](
	[UserID] [nvarchar](50) NOT NULL,
	[ContentGuid] [nvarchar](50) NOT NULL,
	[TypeContent] [nvarchar](50) NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RetentionTemp]') AND name = N'PK_RetentionTemp')
CREATE UNIQUE CLUSTERED INDEX [PK_RetentionTemp] ON [dbo].[RetentionTemp] 
(
	[ContentGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RetentionTemp]') AND name = N'PI01_RetentionTemp')
CREATE NONCLUSTERED INDEX [PI01_RetentionTemp] ON [dbo].[RetentionTemp] 
(
	[UserID] ASC,
	[TypeContent] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RiskLevel]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RiskLevel]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RiskLevel](
	[RiskCode] [char](10) NULL,
	[Description] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[SeverityUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SeverityUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: SeverityUpdProc 
 */

CREATE PROCEDURE [dbo].[SeverityUpdProc]
(
    @SeverityCode     nvarchar(50),
    @CodeDesc         nvarchar(18)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE Severity
       SET CodeDesc          = @CodeDesc
     WHERE SeverityCode = @SeverityCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''SeverityUpdProc: Cannot update  in Severity ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[SeveritySelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SeveritySelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[SeverityInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SeverityInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: SeverityInsProc 
 */

CREATE PROCEDURE [dbo].[SeverityInsProc]
(
    @SeverityCode     nvarchar(50),
    @CodeDesc         nvarchar(18)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Severity(SeverityCode,
                         CodeDesc)
    VALUES(@SeverityCode,
           @CodeDesc)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''SeverityInsProc: Cannot insert because primary key value not found in Severity ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[SeverityDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SeverityDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: SeverityDelProc 
 */

CREATE PROCEDURE [dbo].[SeverityDelProc]
(
    @SeverityCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Severity
     WHERE SeverityCode = @SeverityCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''SeverityDelProc: Cannot delete because foreign keys still exist in Severity ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  Table [dbo].[SearhParmsHistory]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearhParmsHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SearhParmsHistory](
	[UserID] [nvarchar](50) NOT NULL,
	[SearchDate] [datetime] NOT NULL,
	[Screen] [nvarchar](50) NOT NULL,
	[QryParms] [nvarchar](max) NOT NULL,
	[EntryID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SearhParmsHistory]') AND name = N'PI_SearhParms')
CREATE NONCLUSTERED INDEX [PI_SearhParms] ON [dbo].[SearhParmsHistory] 
(
	[UserID] ASC,
	[Screen] ASC,
	[EntryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PgmTrace]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PgmTrace]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PgmTrace](
	[StmtID] [nvarchar](50) NULL,
	[PgmName] [nvarchar](254) NULL,
	[Stmt] [nvarchar](max) NOT NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[CreateDate] [datetime] NULL,
	[ConnectiveGuid] [nvarchar](50) NULL,
	[UserID] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[PgmTrace]') AND name = N'PI01_PgmTrace')
CREATE NONCLUSTERED INDEX [PI01_PgmTrace] ON [dbo].[PgmTrace] 
(
	[ConnectiveGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProcessFileAs]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProcessFileAs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProcessFileAs](
	[ExtCode] [nvarchar](50) NOT NULL,
	[ProcessExtCode] [nvarchar](50) NOT NULL,
	[Applied] [bit] NULL,
 CONSTRAINT [PK__ProcessFileAs__5887175A] PRIMARY KEY CLUSTERED 
(
	[ExtCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ProcessFileAs]') AND name = N'PK_00_ProcessFileAs')
CREATE UNIQUE NONCLUSTERED INDEX [PK_00_ProcessFileAs] ON [dbo].[ProcessFileAs] 
(
	[ExtCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Trigger [InformationProductDelTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[InformationProductDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: InformationProductDelTrig 
 */

CREATE TRIGGER [dbo].[InformationProductDelTrig] ON [dbo].[InformationProduct]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM ProdCaptureItems ch, deleted
         WHERE ch.CorpFuncName = deleted.CorpFuncName AND
           ch.CorpName = deleted.CorpName AND
           ch.ContainerType = deleted.ContainerType) != 0)
    BEGIN
        RAISERROR 30002 ''InformationProductDelTrigCannot delete because foreign keys still exist in ProdCaptureItems''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Table [dbo].[ProdCaptureItems]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProdCaptureItems]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProdCaptureItems](
	[CaptureItemsCode] [nvarchar](50) NOT NULL,
	[SendAlert] [bit] NULL,
	[ContainerType] [nvarchar](25) NOT NULL,
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[CorpName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK21] PRIMARY KEY NONCLUSTERED 
(
	[CaptureItemsCode] ASC,
	[ContainerType] ASC,
	[CorpFuncName] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[CaptureItems]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CaptureItems]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CaptureItems](
	[CaptureItemsCode] [nvarchar](50) NOT NULL,
	[CaptureItemsDesc] [nvarchar](18) NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK20] PRIMARY KEY CLUSTERED 
(
	[CaptureItemsCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [CaptureItemsUpdTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[CaptureItemsUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: CaptureItemsUpdTrig 
 */

CREATE TRIGGER [dbo].[CaptureItemsUpdTrig] ON [dbo].[CaptureItems]
FOR UPDATE AS
BEGIN
    DECLARE
        @CaptureItemsCode nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: RESTRICT

    IF (UPDATE(CaptureItemsCode))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM ProdCaptureItems ch, deleted
          WHERE ch.CaptureItemsCode = deleted.CaptureItemsCode) != 0)
        BEGIN
            RAISERROR 30001 ''CaptureItemsUpdTrigCannot update because foreign keys still exist in ProdCaptureItems''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [CaptureItemsDelTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[CaptureItemsDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: CaptureItemsDelTrig 
 */

CREATE TRIGGER [dbo].[CaptureItemsDelTrig] ON [dbo].[CaptureItems]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM ProdCaptureItems ch, deleted
         WHERE ch.CaptureItemsCode = deleted.CaptureItemsCode) != 0)
    BEGIN
        RAISERROR 30002 ''CaptureItemsDelTrigCannot delete because foreign keys still exist in ProdCaptureItems''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  StoredProcedure [dbo].[procGetContentData]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[procGetContentData]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'Create Procedure [dbo].[procGetContentData]
	@SqlStmt VarChar(4000)
AS
	Exec (@SqlStmt);

' 
END
GO
/****** Object:  Table [dbo].[QuickDirectory]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuickDirectory]') AND type in (N'U'))
BEGIN
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
 CONSTRAINT [PKII2QD] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[FQN] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [UsersDelTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[UsersDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: UsersDelTrig 
 */

CREATE TRIGGER [dbo].[UsersDelTrig] ON [dbo].[Users]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM GroupUsers ch, deleted
         WHERE ch.UserID = deleted.UserID) != 0)
    BEGIN
        RAISERROR 30002 ''UsersDelTrigCannot delete because foreign keys still exist in GroupUsers''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Table [dbo].[GlobalSeachResults]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GlobalSeachResults]') AND type in (N'U'))
BEGIN
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
	[Weight] [int] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[GlobalSeachResults]') AND name = N'PK_GlobalSearch')
CREATE UNIQUE NONCLUSTERED INDEX [PK_GlobalSearch] ON [dbo].[GlobalSeachResults] 
(
	[ContentGuid] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[GetAllTableSizes]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetAllTableSizes]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GetAllTableSizes]
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
where  OBJECTPROPERTY(id, N''IsUserTable'') = 1
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
DROP TABLE #TempTable' 
END
GO
/****** Object:  Table [dbo].[HelpText]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HelpText]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HelpText](
	[ScreenName] [nvarchar](100) NOT NULL,
	[HelpText] [nvarchar](max) NULL,
	[WidgetName] [nvarchar](100) NOT NULL,
	[WidgetText] [nvarchar](254) NULL,
	[DisplayHelpText] [bit] NULL,
	[LastUpdate] [datetime] NULL,
	[CreateDate] [datetime] NULL,
	[UpdatedBy] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[HelpText]') AND name = N'PK_HelpText')
CREATE UNIQUE CLUSTERED INDEX [PK_HelpText] ON [dbo].[HelpText] 
(
	[ScreenName] ASC,
	[WidgetName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IncludedFiles]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IncludedFiles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IncludedFiles](
	[UserID] [nvarchar](50) NOT NULL,
	[ExtCode] [nvarchar](50) NOT NULL,
	[FQN] [nvarchar](254) NOT NULL,
 CONSTRAINT [PKI3] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[ExtCode] ASC,
	[FQN] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ImageTypeCodes]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ImageTypeCodes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ImageTypeCodes](
	[ImageTypeCode] [nvarchar](50) NULL,
	[ImageTypeCodeDesc] [nvarchar](250) NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ImageTypeCodes]') AND name = N'PK_ImageTypeCode')
CREATE UNIQUE CLUSTERED INDEX [PK_ImageTypeCode] ON [dbo].[ImageTypeCodes] 
(
	[ImageTypeCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HelpTextUser]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HelpTextUser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[HelpTextUser](
	[UserID] [nvarchar](50) NOT NULL,
	[ScreenName] [nvarchar](100) NOT NULL,
	[HelpText] [nvarchar](max) NULL,
	[WidgetName] [nvarchar](100) NOT NULL,
	[WidgetText] [nvarchar](254) NULL,
	[DisplayHelpText] [bit] NULL,
	[CompanyID] [nvarchar](50) NULL,
	[LastUpdate] [datetime] NULL,
	[CreateDate] [datetime] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[IncludeImmediate]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IncludeImmediate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[IncludeImmediate](
	[FromEmailAddr] [nvarchar](254) NOT NULL,
	[SenderName] [varchar](254) NOT NULL,
	[UserID] [varchar](25) NOT NULL,
 CONSTRAINT [PK_IncludeImmediate] PRIMARY KEY NONCLUSTERED 
(
	[FromEmailAddr] ASC,
	[SenderName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[IssueUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IssueUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: IssueUpdProc 
 */

CREATE PROCEDURE [dbo].[IssueUpdProc]
(
    @CategoryName         nvarchar(50),
    @IssueDescription     nvarchar(max)            = NULL,
    @EntryDate            datetime                 = NULL,
    @SeverityCode         nvarchar(50)             = NULL,
    @StatusCode           nvarchar(50)             = NULL,
    @EMail                nvarchar(100),
    @IssueTitle           nvarchar(400),
    @LastUpdate           datetime                 = NULL,
    @CreateDate           datetime                 = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE Issue
       SET CategoryName          = @CategoryName,
           IssueDescription      = @IssueDescription,
           EntryDate             = @EntryDate,
           SeverityCode          = @SeverityCode,
           StatusCode            = @StatusCode,
           EMail                 = @EMail,
           LastUpdate            = @LastUpdate,
           CreateDate            = @CreateDate
     WHERE IssueTitle = @IssueTitle

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''IssueUpdProc: Cannot update  in Issue ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[IssueSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IssueSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[IssueInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IssueInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: IssueInsProc 
 */

CREATE PROCEDURE [dbo].[IssueInsProc]
(
    @CategoryName         nvarchar(50),
    @IssueDescription     nvarchar(max)            = NULL,
    @EntryDate            datetime                 = NULL,
    @SeverityCode         nvarchar(50)             = NULL,
    @StatusCode           nvarchar(50)             = NULL,
    @EMail                nvarchar(100),
    @IssueTitle           nvarchar(400),
    @LastUpdate           datetime                 = NULL,
    @CreateDate           datetime                 = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Issue(CategoryName,
                      IssueDescription,
                      EntryDate,
                      SeverityCode,
                      StatusCode,
                      EMail,
                      IssueTitle,
                      LastUpdate,
                      CreateDate)
    VALUES(@CategoryName,
           @IssueDescription,
           @EntryDate,
           @SeverityCode,
           @StatusCode,
           @EMail,
           @IssueTitle,
           @LastUpdate,
           @CreateDate)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''IssueInsProc: Cannot insert because primary key value not found in Issue ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[IssueDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IssueDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: IssueDelProc 
 */

CREATE PROCEDURE [dbo].[IssueDelProc]
(
    @IssueTitle           nvarchar(400))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Issue
     WHERE IssueTitle = @IssueTitle

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''IssueDelProc: Cannot delete because foreign keys still exist in Issue ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  UserDefinedFunction [dbo].[IsGuid]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IsGuid]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'create function [dbo].[IsGuid] ( @testString varchar(38))
returns int
as
begin
    declare @ret int
    select  @ret = 0,
            @testString = replace(replace(@testString, ''{'', ''''), ''}'', '''')
    if len(isnull(@testString, '''')) = 36 and
       @testString NOT LIKE ''%[^0-9A-Fa-f-]%'' and
       -- check for proper positions of hyphens (-)  
       charindex(''-'', @testString) = 9 and 
       charindex(''-'', @testString, 10) = 14 and 
       charindex(''-'', @testString, 15) = 19 and 
       charindex(''-'', @testString, 20) = 24 and 
       charindex(''-'', @testString, 25) = 0
          set @ret = 1
    
    return @ret
end' 
END
GO
/****** Object:  Trigger [LibraryDelTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[LibraryDelTrig]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[LibraryDelTrig] ON [dbo].[Library]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: CASCADE

    DELETE LibEmail
        FROM LibEmail ch, deleted
        WHERE ch.LibraryName = deleted.LibraryName AND
           ch.UserID = deleted.UserID
-- Parent Delete: CASCADE

    DELETE LibDirectory
        FROM LibDirectory ch, deleted
        WHERE ch.LibraryName = deleted.LibraryName AND
           ch.UserID = deleted.UserID

END'
GO
/****** Object:  Table [dbo].[LibraryItems]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibraryItems]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LibraryItems](
	[SourceGuid] [nvarchar](50) NULL,
	[ItemTitle] [nvarchar](254) NULL,
	[ItemType] [nvarchar](50) NULL,
	[LibraryItemGuid] [nvarchar](50) NOT NULL,
	[DataSourceOwnerUserID] [nvarchar](50) NULL,
	[LibraryOwnerUserID] [nvarchar](50) NOT NULL,
	[LibraryName] [nvarchar](80) NOT NULL,
	[AddedByUserGuidId] [nvarchar](50) NULL,
 CONSTRAINT [PK89] PRIMARY KEY NONCLUSTERED 
(
	[LibraryOwnerUserID] ASC,
	[LibraryName] ASC,
	[LibraryItemGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LibraryItems]') AND name = N'PI01_LibItems')
CREATE NONCLUSTERED INDEX [PI01_LibItems] ON [dbo].[LibraryItems] 
(
	[ItemTitle] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[LibraryItems]') AND name = N'UK_LibItems')
CREATE UNIQUE NONCLUSTERED INDEX [UK_LibItems] ON [dbo].[LibraryItems] 
(
	[LibraryItemGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'LibraryItems', NULL,NULL))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'LibraryItems is intentionally NOT linked to an owner through the user guid so that others can place content and emails into the library. The owner is determined by a lookup on the unique library name.

SourceGuid, in this case, can be either a content or email giud as both can live within a library.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'LibraryItems'
GO
/****** Object:  Table [dbo].[License]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[License]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[License](
	[Agreement] [nvarchar](2000) NOT NULL,
	[VersionNbr] [int] NOT NULL,
	[ActivationDate] [datetime] NOT NULL,
	[InstallDate] [datetime] NOT NULL,
	[CustomerID] [nvarchar](50) NOT NULL,
	[CustomerName] [nvarchar](254) NOT NULL,
	[LicenseID] [int] IDENTITY(1,1) NOT NULL,
	[XrtNxr1] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[License]') AND name = N'PK_License')
CREATE UNIQUE NONCLUSTERED INDEX [PK_License] ON [dbo].[License] 
(
	[LicenseID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LoadProfile]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadProfile]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LoadProfile](
	[ProfileName] [nvarchar](50) NOT NULL,
	[ProfileDesc] [nvarchar](254) NULL,
 CONSTRAINT [PK101] PRIMARY KEY CLUSTERED 
(
	[ProfileName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [LoadProfileUpdTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[LoadProfileUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: LoadProfileUpdTrig 
 */

CREATE TRIGGER [dbo].[LoadProfileUpdTrig] ON [dbo].[LoadProfile]
FOR UPDATE AS
BEGIN
    DECLARE
        @ProfileName nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: CASCADE

    IF (UPDATE(ProfileName))
    BEGIN
        SELECT @ProfileName = ProfileName
        FROM inserted

        UPDATE LoadProfileItem
          SET ProfileName = @ProfileName
        FROM LoadProfileItem ch, deleted
        WHERE
            ch.ProfileName = deleted.ProfileName
    END

END'
GO
/****** Object:  Trigger [LoadProfileDelTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[LoadProfileDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: LoadProfileDelTrig 
 */

CREATE TRIGGER [dbo].[LoadProfileDelTrig] ON [dbo].[LoadProfile]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: CASCADE

    DELETE LoadProfileItem
        FROM LoadProfileItem ch, deleted
        WHERE ch.ProfileName = deleted.ProfileName

END'
GO
/****** Object:  Table [dbo].[Machine]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Machine]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Machine](
	[MachineName] [nvarchar](254) NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Machine]') AND name = N'PK_Machine')
CREATE UNIQUE CLUSTERED INDEX [PK_Machine] ON [dbo].[Machine] 
(
	[MachineName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MyTempTable]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MyTempTable]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MyTempTable](
	[docid] [int] NOT NULL,
	[key] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[docid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[OutlookFrom]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OutlookFrom]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OutlookFrom](
	[FromEmailAddr] [nvarchar](254) NOT NULL,
	[SenderName] [varchar](254) NOT NULL,
	[UserID] [varchar](25) NOT NULL,
	[Verified] [int] NULL,
 CONSTRAINT [OutlookFrom_PK] PRIMARY KEY NONCLUSTERED 
(
	[FromEmailAddr] ASC,
	[SenderName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RunParms]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RunParms]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RunParms](
	[Parm] [nvarchar](50) NOT NULL,
	[ParmValue] [nvarchar](50) NULL,
	[UserID] [nvarchar](50) NOT NULL,
 CONSTRAINT [PKI8] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[Parm] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[RuntimeErrors]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RuntimeErrors]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RuntimeErrors](
	[ErrorMsg] [nvarchar](max) NULL,
	[StackTrace] [nvarchar](max) NULL,
	[EntryDate] [datetime] NULL,
	[IdNbr] [nvarchar](50) NULL,
	[EntrySeq] [int] IDENTITY(1,1) NOT NULL,
	[ConnectiveGuid] [nvarchar](50) NULL,
	[UserID] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RuntimeErrors]') AND name = N'PI01_RuntimeErrrors')
CREATE NONCLUSTERED INDEX [PI01_RuntimeErrrors] ON [dbo].[RuntimeErrors] 
(
	[ConnectiveGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SavedItems]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SavedItems]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SavedItems](
	[Userid] [nvarchar](50) NOT NULL,
	[SaveName] [nvarchar](50) NOT NULL,
	[SaveTypeCode] [nvarchar](50) NOT NULL,
	[ValName] [nvarchar](50) NOT NULL,
	[ValValue] [nvarchar](254) NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SavedItems]') AND name = N'PK_SavedItems')
CREATE UNIQUE NONCLUSTERED INDEX [PK_SavedItems] ON [dbo].[SavedItems] 
(
	[Userid] ASC,
	[SaveName] ASC,
	[SaveTypeCode] ASC,
	[ValName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SearchHistory]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchHistory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SearchHistory](
	[SearchSql] [nvarchar](max) NULL,
	[SearchDate] [datetime] NULL,
	[UserID] [nvarchar](50) NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ReturnedRows] [int] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[CalledFrom] [nvarchar](50) NULL,
	[TypeSearch] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SearchHistory]') AND name = N'PK_SearchHist')
CREATE UNIQUE CLUSTERED INDEX [PK_SearchHist] ON [dbo].[SearchHistory] 
(
	[RowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Attributes]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Attributes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Attributes](
	[AttributeName] [nvarchar](50) NOT NULL,
	[AttributeDataType] [nvarchar](50) NOT NULL,
	[AttributeDesc] [nvarchar](2000) NULL,
	[AssoApplication] [nvarchar](50) NULL,
	[AllowedValues] [nvarchar](254) NULL,
 CONSTRAINT [PK36] PRIMARY KEY CLUSTERED 
(
	[AttributeName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [AttributesUpdTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[AttributesUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: AttributesUpdTrig 
 */

CREATE TRIGGER [dbo].[AttributesUpdTrig] ON [dbo].[Attributes]
FOR UPDATE AS
BEGIN
    DECLARE
        @AttributeName nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: CASCADE

    IF (UPDATE(AttributeName))
    BEGIN
        SELECT @AttributeName = AttributeName
        FROM inserted

        UPDATE SourceAttribute
          SET AttributeName = @AttributeName
        FROM SourceAttribute ch, deleted
        WHERE
            ch.AttributeName = deleted.AttributeName
    END

END'
GO
/****** Object:  Trigger [AttributesDelTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[AttributesDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: AttributesDelTrig 
 */

CREATE TRIGGER [dbo].[AttributesDelTrig] ON [dbo].[Attributes]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: CASCADE

    DELETE SourceAttribute
        FROM SourceAttribute ch, deleted
        WHERE ch.AttributeName = deleted.AttributeName

END'
GO
/****** Object:  Trigger [DataSourceUpdTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[DataSourceUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: DataSourceUpdTrig 
 */

CREATE TRIGGER [dbo].[DataSourceUpdTrig] ON [dbo].[DataSource]
FOR UPDATE AS
BEGIN
    DECLARE
        @SourceGuid nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: RESTRICT

    IF (UPDATE(SourceGuid))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM SourceAttribute ch, deleted
          WHERE ch.SourceGuid = deleted.SourceGuid) != 0)
        BEGIN
            RAISERROR 30001 ''DataSourceUpdTrigCannot update because foreign keys still exist in SourceAttribute''
            ROLLBACK TRAN
        END
    END
-- Child Update: RESTRICT

    IF (UPDATE(SourceTypeCode))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM SourceType pr, inserted
          WHERE pr.SourceTypeCode = inserted.SourceTypeCode) != @Rows)
        BEGIN
            RAISERROR 30001 ''DataSourceUpdTrigCannot update because primary key value not found in SourceType''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [DataSourceInsTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[DataSourceInsTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: DataSourceInsTrig 
 */

CREATE TRIGGER [dbo].[DataSourceInsTrig] ON [dbo].[DataSource]
FOR INSERT AS
BEGIN
    DECLARE
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Child Insert: RESTRICT

    IF ((SELECT COUNT(*)
         FROM SourceType pr, inserted
         WHERE pr.SourceTypeCode = inserted.SourceTypeCode) != @Rows)
    BEGIN
        RAISERROR 30000 ''DataSourceInsTrigCannot insert because primary key value not found in SourceType''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Table [dbo].[SourceContainer]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceContainer]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SourceContainer](
	[ContainerType] [nvarchar](25) NOT NULL,
	[ContainerDesc] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK3] PRIMARY KEY NONCLUSTERED 
(
	[ContainerType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ContainerStorage]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContainerStorage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ContainerStorage](
	[StoreCode] [nvarchar](50) NOT NULL,
	[ContainerType] [nvarchar](25) NOT NULL,
 CONSTRAINT [PK18] PRIMARY KEY NONCLUSTERED 
(
	[StoreCode] ASC,
	[ContainerType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [ContainerStorageUpdTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[ContainerStorageUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: ContainerStorageUpdTrig 
 */

CREATE TRIGGER [dbo].[ContainerStorageUpdTrig] ON [dbo].[ContainerStorage]
FOR UPDATE AS
BEGIN
    DECLARE
        @StoreCode nvarchar(50),
        @ContainerType nvarchar(25),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Child Update: RESTRICT

    IF (UPDATE(StoreCode))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM Storage pr, inserted
          WHERE pr.StoreCode = inserted.StoreCode) != @Rows)
        BEGIN
            RAISERROR 30001 ''ContainerStorageUpdTrigCannot update because primary key value not found in Storage''
            ROLLBACK TRAN
        END
    END
-- Child Update: RESTRICT

    IF (UPDATE(ContainerType))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM SourceContainer pr, inserted
          WHERE pr.ContainerType = inserted.ContainerType) != @Rows)
        BEGIN
            RAISERROR 30001 ''ContainerStorageUpdTrigCannot update because primary key value not found in SourceContainer''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [ContainerStorageInsTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[ContainerStorageInsTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: ContainerStorageInsTrig 
 */

CREATE TRIGGER [dbo].[ContainerStorageInsTrig] ON [dbo].[ContainerStorage]
FOR INSERT AS
BEGIN
    DECLARE
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Child Insert: RESTRICT

    IF ((SELECT COUNT(*)
         FROM Storage pr, inserted
         WHERE pr.StoreCode = inserted.StoreCode) != @Rows)
    BEGIN
        RAISERROR 30000 ''ContainerStorageInsTrigCannot insert because primary key value not found in Storage''
        ROLLBACK TRAN
    END
-- Child Insert: RESTRICT

    IF ((SELECT COUNT(*)
         FROM SourceContainer pr, inserted
         WHERE pr.ContainerType = inserted.ContainerType) != @Rows)
    BEGIN
        RAISERROR 30000 ''ContainerStorageInsTrigCannot insert because primary key value not found in SourceContainer''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  StoredProcedure [dbo].[StatusUpdProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StatusUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: StatusUpdProc 
 */

CREATE PROCEDURE [dbo].[StatusUpdProc]
(
    @StatusCode     nvarchar(50),
    @CodeDesc       nvarchar(18)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE Status
       SET CodeDesc        = @CodeDesc
     WHERE StatusCode = @StatusCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''StatusUpdProc: Cannot update  in Status ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[StatusSelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StatusSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[StatusInsProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StatusInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: StatusInsProc 
 */

CREATE PROCEDURE [dbo].[StatusInsProc]
(
    @StatusCode     nvarchar(50),
    @CodeDesc       nvarchar(18)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Status(StatusCode,
                       CodeDesc)
    VALUES(@StatusCode,
           @CodeDesc)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''StatusInsProc: Cannot insert because primary key value not found in Status ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[StatusDelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StatusDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: StatusDelProc 
 */

CREATE PROCEDURE [dbo].[StatusDelProc]
(
    @StatusCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Status
     WHERE StatusCode = @StatusCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''StatusDelProc: Cannot delete because foreign keys still exist in Status ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_EcmUpdateDB]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_EcmUpdateDB]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE  Procedure [dbo].[sp_EcmUpdateDB]
	@pSql nVarChar(max)
AS
Exec sp_executesql @pSql' 
END
GO
/****** Object:  StoredProcedure [dbo].[SourceAttribute_BACKUPInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceAttribute_BACKUPInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SourceAttribute_BACKUPInsProc]
(
    @AttributeValue            nvarchar(254)            = NULL,
    @AttributeName             nvarchar(50),
    @SourceGuid                nvarchar(50),
    @DataSourceOwnerUserID     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO SourceAttribute_BACKUP(AttributeValue,
                                       AttributeName,
                                       SourceGuid,
                                       DataSourceOwnerUserID)
    VALUES(@AttributeValue,
           @AttributeName,
           @SourceGuid,
           @DataSourceOwnerUserID)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''SourceAttribute_BACKUPInsProc: Cannot insert because primary key value not found in SourceAttribute_BACKUP ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  Table [dbo].[SystemParms]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemParms]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SystemParms](
	[SysParm] [nvarchar](50) NULL,
	[SysParmDesc] [nvarchar](250) NULL,
	[SysParmVal] [nvarchar](250) NULL,
	[flgActive] [nchar](1) NULL,
	[isDirectory] [nchar](1) NULL,
	[isEmailFolder] [nchar](1) NULL,
	[flgAllSubDirs] [nchar](1) NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SystemParms]') AND name = N'PK_SystemParms')
CREATE UNIQUE NONCLUSTERED INDEX [PK_SystemParms] ON [dbo].[SystemParms] 
(
	[SysParm] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserCurrParm]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserCurrParm]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserCurrParm](
	[UserID] [nvarchar](50) NOT NULL,
	[ParmName] [nvarchar](50) NOT NULL,
	[ParmVal] [nvarchar](2000) NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[UserCurrParm]') AND name = N'PI_UserCurrParm')
CREATE NONCLUSTERED INDEX [PI_UserCurrParm] ON [dbo].[UserCurrParm] 
(
	[UserID] ASC,
	[ParmName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UrlRejection]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UrlRejection]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UrlRejection](
	[RejectionPattern] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[UrlRejection]') AND name = N'PK_UrlRejection')
CREATE UNIQUE CLUSTERED INDEX [PK_UrlRejection] ON [dbo].[UrlRejection] 
(
	[RejectionPattern] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UrlList]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UrlList]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UrlList](
	[URL] [nvarchar](425) NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[UrlList]') AND name = N'PK_UrlList')
CREATE UNIQUE CLUSTERED INDEX [PK_UrlList] ON [dbo].[UrlList] 
(
	[URL] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[upgrade_status]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[upgrade_status]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[upgrade_status](
	[name] [varchar](30) NOT NULL,
	[status] [varchar](10) NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[UserReassignHist]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserReassignHist]') AND type in (N'U'))
BEGIN
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
	[RowID] [uniqueidentifier] NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[WebSource]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebSource]') AND type in (N'U'))
BEGIN
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
 CONSTRAINT [PK_WebSource] PRIMARY KEY NONCLUSTERED 
(
	[SourceGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[FunctionProdJargon]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FunctionProdJargon]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FunctionProdJargon](
	[KeyFlag] [binary](50) NULL,
	[RepeatDataCode] [nvarchar](50) NOT NULL,
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[JargonCode] [nvarchar](50) NOT NULL,
	[CorpName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK13] PRIMARY KEY NONCLUSTERED 
(
	[CorpFuncName] ASC,
	[JargonCode] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RepeatData]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RepeatData]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RepeatData](
	[RepeatDataCode] [nvarchar](50) NOT NULL,
	[RepeatDataDesc] [nvarchar](4000) NULL,
 CONSTRAINT [PK14] PRIMARY KEY CLUSTERED 
(
	[RepeatDataCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [RepeatDataUpdTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[RepeatDataUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: RepeatDataUpdTrig 
 */

CREATE TRIGGER [dbo].[RepeatDataUpdTrig] ON [dbo].[RepeatData]
FOR UPDATE AS
BEGIN
    DECLARE
        @RepeatDataCode nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: CASCADE

    IF (UPDATE(RepeatDataCode))
    BEGIN
        SELECT @RepeatDataCode = RepeatDataCode
        FROM inserted

        UPDATE FunctionProdJargon
          SET RepeatDataCode = @RepeatDataCode
        FROM FunctionProdJargon ch, deleted
        WHERE
            ch.RepeatDataCode = deleted.RepeatDataCode
    END

END'
GO
/****** Object:  Trigger [RepeatDataDelTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[RepeatDataDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: RepeatDataDelTrig 
 */

CREATE TRIGGER [dbo].[RepeatDataDelTrig] ON [dbo].[RepeatData]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM FunctionProdJargon ch, deleted
         WHERE ch.RepeatDataCode = deleted.RepeatDataCode) != 0)
    BEGIN
        RAISERROR 30002 ''RepeatDataDelTrigCannot delete because foreign keys still exist in FunctionProdJargon''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Table [dbo].[BusinessJargonCode]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusinessJargonCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusinessJargonCode](
	[JargonCode] [nvarchar](50) NOT NULL,
	[JargonDesc] [nvarchar](18) NULL,
 CONSTRAINT [PK11] PRIMARY KEY CLUSTERED 
(
	[JargonCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [BusinessJargonCodeUpdTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BusinessJargonCodeUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: BusinessJargonCodeUpdTrig 
 */

CREATE TRIGGER [dbo].[BusinessJargonCodeUpdTrig] ON [dbo].[BusinessJargonCode]
FOR UPDATE AS
BEGIN
    DECLARE
        @JargonCode nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: RESTRICT

    IF (UPDATE(JargonCode))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM JargonWords ch, deleted
          WHERE ch.JargonCode = deleted.JargonCode) != 0)
        BEGIN
            RAISERROR 30001 ''BusinessJargonCodeUpdTrigCannot update because foreign keys still exist in JargonWords''
            ROLLBACK TRAN
        END
    END
-- Parent Update: CASCADE

    IF (UPDATE(JargonCode))
    BEGIN
        SELECT @JargonCode = JargonCode
        FROM inserted

        UPDATE FunctionProdJargon
          SET JargonCode = @JargonCode
        FROM FunctionProdJargon ch, deleted
        WHERE
            ch.JargonCode = deleted.JargonCode
    END

END'
GO
/****** Object:  Trigger [BusinessJargonCodeDelTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BusinessJargonCodeDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: BusinessJargonCodeDelTrig 
 */

CREATE TRIGGER [dbo].[BusinessJargonCodeDelTrig] ON [dbo].[BusinessJargonCode]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM JargonWords ch, deleted
         WHERE ch.JargonCode = deleted.JargonCode) != 0)
    BEGIN
        RAISERROR 30002 ''BusinessJargonCodeDelTrigCannot delete because foreign keys still exist in JargonWords''
        ROLLBACK TRAN
    END
-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM FunctionProdJargon ch, deleted
         WHERE ch.JargonCode = deleted.JargonCode) != 0)
    BEGIN
        RAISERROR 30002 ''BusinessJargonCodeDelTrigCannot delete because foreign keys still exist in FunctionProdJargon''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  StoredProcedure [dbo].[GraphicsUpdProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GraphicsUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: GraphicsUpdProc 
 */

CREATE PROCEDURE [dbo].[GraphicsUpdProc]
(
    @GraphicID      int,
    @Graphic        image                    = NULL,
    @ResponseID     int,
    @EMail          nvarchar(100),
    @IssueTitle     nvarchar(400))
AS
BEGIN
    BEGIN TRAN

    UPDATE Graphics
       SET Graphic         = @Graphic,
           ResponseID      = @ResponseID,
           EMail           = @EMail
     WHERE GraphicID  = @GraphicID
       AND IssueTitle = @IssueTitle

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''GraphicsUpdProc: Cannot update  in Graphics ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[GraphicsSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GraphicsSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[GraphicsInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GraphicsInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: GraphicsInsProc 
 */

CREATE PROCEDURE [dbo].[GraphicsInsProc]
(
    @Graphic        image                    = NULL,
    @ResponseID     int,
    @EMail          nvarchar(100),
    @IssueTitle     nvarchar(400))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Graphics(Graphic,
                         ResponseID,
                         EMail,
                         IssueTitle)
    VALUES(@Graphic,
           @ResponseID,
           @EMail,
           @IssueTitle)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''GraphicsInsProc: Cannot insert because primary key value not found in Graphics ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[GraphicsDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GraphicsDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: GraphicsDelProc 
 */

CREATE PROCEDURE [dbo].[GraphicsDelProc]
(
    @GraphicID      int,
    @IssueTitle     nvarchar(400))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Graphics
     WHERE GraphicID  = @GraphicID
       AND IssueTitle = @IssueTitle

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''GraphicsDelProc: Cannot delete because foreign keys still exist in Graphics ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  Table [dbo].[FUncSkipWords]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FUncSkipWords]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FUncSkipWords](
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[tgtWord] [nvarchar](18) NOT NULL,
	[CorpName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK24] PRIMARY KEY NONCLUSTERED 
(
	[CorpFuncName] ASC,
	[tgtWord] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SkipWords]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SkipWords]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SkipWords](
	[tgtWord] [nvarchar](18) NOT NULL,
 CONSTRAINT [PK22] PRIMARY KEY NONCLUSTERED 
(
	[tgtWord] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [SkipWordsUpdTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[SkipWordsUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: SkipWordsUpdTrig 
 */

CREATE TRIGGER [dbo].[SkipWordsUpdTrig] ON [dbo].[SkipWords]
FOR UPDATE AS
BEGIN
    DECLARE
        @tgtWord nvarchar(18),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: RESTRICT

    IF (UPDATE(tgtWord))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM FUncSkipWords ch, deleted
          WHERE ch.tgtWord = deleted.tgtWord) != 0)
        BEGIN
            RAISERROR 30001 ''SkipWordsUpdTrigCannot update because foreign keys still exist in FUncSkipWords''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [SkipWordsDelTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[SkipWordsDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: SkipWordsDelTrig 
 */

CREATE TRIGGER [dbo].[SkipWordsDelTrig] ON [dbo].[SkipWords]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM FUncSkipWords ch, deleted
         WHERE ch.tgtWord = deleted.tgtWord) != 0)
    BEGIN
        RAISERROR 30002 ''SkipWordsDelTrigCannot delete because foreign keys still exist in FUncSkipWords''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  StoredProcedure [dbo].[funcEcmUpdateDB]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[funcEcmUpdateDB]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create Procedure [dbo].[funcEcmUpdateDB]
	@pSql nVarChar(max)
AS
Exec sp_executesql @pSql
' 
END
GO
/****** Object:  StoredProcedure [dbo].[sp_fulltext_load_thesaurus_fileV2]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_fulltext_load_thesaurus_fileV2]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'create PROC [dbo].[sp_fulltext_load_thesaurus_fileV2]
    @lcid int,
    @loadOnlyIfNotLoaded bit = 0
AS
BEGIN
    SET NOCOUNT ON
    SET IMPLICIT_TRANSACTIONS OFF

    -- sp_fulltext_load_thesaurus_files will run under read committed isolation level
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED

    -- CHECK PERMISSIONS (must be serveradmin)
    if (is_srvrolemember(''serveradmin'') = 0)
    begin
        raiserror(15247,-1,-1)
        return 1
    end

    -- Disallow user transaction on this sp
    --
    if @@trancount > 0
    begin
        raiserror(15002,-1,-1,''sys.sp_fulltext_load_thesaurus_file'')
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
    SELECT @sqlString=N''SELECT @thesaurusOut=X.root FROM OPENROWSET(BULK N'' + QUOTENAME(@thesaurusFilePath, '''''''') + N'', SINGLE_BLOB) AS X(root)''
    EXECUTE sp_executesql @sqlString, N''@thesaurusOut xml OUTPUT'', @thesaurusOut = @thesaurus OUTPUT;

    DECLARE @diacritics_sensitive bit
    SELECT @diacritics_sensitive = 0
    SELECT @diacritics_sensitive = Thesaurus.d_s.value(''.'', ''bit'') 
    FROM @thesaurus.nodes(N''declare namespace PD="x-schema:tsSchema.xml";/XML/PD:thesaurus/PD:diacritics_sensitive'') AS Thesaurus(d_s)

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
    with xmlnamespaces (N''x-schema:tsSchema.xml'' as PD)
    INSERT INTO tempdb.sys.fulltext_thesaurus_phrase_table (groupid, isExpansion, isLHSOfReplacement, lcid, terms)
    SELECT X.rowid AS GroupId, 
           X.isexp AS IsExpansion, 
           Sub.Val.value(''if (local-name(.) eq "pat") then 1 else 0'', ''int'') AS isLHSOfReplacement,
           @lcid,
           WordBrokenPhrase.concatenated_terms
    FROM
    (
    SELECT T2.exp.query(''.''), 
           T2.exp.value(''if (local-name(.) eq "expansion") then 1 else 0'', ''int'') isexp, 
           row_number() over (order by T3.DummyOrderingColumn) rowid
    FROM @thesaurus.nodes(N''(/XML/PD:thesaurus/PD:expansion, /XML/PD:thesaurus/PD:replacement)'') AS T2(exp)
         -- this CROSS APPLY is needed since order by T2.exp is not a supported feature (even though it works)
         -- There is a light weight improvement that exposes ordpaths and when that gets done, one could potentially
         -- directly order by the ordpath above
         --
         CROSS APPLY (SELECT 1 AS DummyOrderingColumn) T3
    ) X(exprep, isexp, rowid)
    CROSS APPLY 
    X.exprep.nodes(N''(/PD:expansion/PD:sub, /PD:replacement/PD:pat, /PD:replacement/PD:sub)'') AS Sub(Val)
    CROSS APPLY 
    sys.fn_ft_wordbreaker(@lcid, @diacritics_sensitive, Sub.Val.value(''.'', ''nvarchar(513)'')) AS WordBrokenPhrase

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
' 
END
GO
/****** Object:  Table [dbo].[FilesToDelete]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FilesToDelete]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FilesToDelete](
	[UserID] [nvarchar](50) NULL,
	[MachineName] [nvarchar](100) NULL,
	[FQN] [nvarchar](254) NULL,
	[PendingDelete] [bit] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[FilesToDelete]') AND name = N'PK_FileToDelete')
CREATE UNIQUE CLUSTERED INDEX [PK_FileToDelete] ON [dbo].[FilesToDelete] 
(
	[UserID] ASC,
	[MachineName] ASC,
	[FQN] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmailFolder]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailFolder]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EmailFolder](
	[UserID] [nvarchar](80) NOT NULL,
	[FolderName] [nvarchar](254) NULL,
	[ParentFolderName] [nvarchar](254) NULL,
	[FolderID] [nvarchar](100) NOT NULL,
	[ParentFolderID] [nvarchar](100) NULL,
	[SelectedForArchive] [char](1) NULL,
	[StoreID] [nvarchar](500) NULL,
	[isSysDefault] [bit] NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EmailFolder]') AND name = N'PK_EmailFolder')
CREATE UNIQUE CLUSTERED INDEX [PK_EmailFolder] ON [dbo].[EmailFolder] 
(
	[UserID] ASC,
	[FolderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EmailFolder]') AND name = N'IDX_FolderName')
CREATE NONCLUSTERED INDEX [IDX_FolderName] ON [dbo].[EmailFolder] 
(
	[UserID] ASC,
	[FolderName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EmailFolder]') AND name = N'UI_EmailFolder')
CREATE UNIQUE NONCLUSTERED INDEX [UI_EmailFolder] ON [dbo].[EmailFolder] 
(
	[UserID] ASC,
	[FolderName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EmailToDelete]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailToDelete]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EmailToDelete](
	[EmailGuid] [nvarchar](50) NOT NULL,
	[StoreID] [nvarchar](500) NOT NULL,
	[UserID] [nvarchar](100) NOT NULL,
	[MessageID] [nchar](100) NULL
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ExcludedFiles]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExcludedFiles]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ExcludedFiles](
	[UserID] [nvarchar](50) NOT NULL,
	[ExtCode] [nvarchar](50) NOT NULL,
	[FQN] [varchar](254) NOT NULL,
 CONSTRAINT [PKII4] PRIMARY KEY NONCLUSTERED 
(
	[UserID] ASC,
	[ExtCode] ASC,
	[FQN] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ExcludeFrom]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExcludeFrom]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ExcludeFrom](
	[FromEmailAddr] [nvarchar](254) NOT NULL,
	[SenderName] [varchar](254) NOT NULL,
	[UserID] [varchar](25) NOT NULL,
 CONSTRAINT [PK_ExcludeFrom] PRIMARY KEY NONCLUSTERED 
(
	[FromEmailAddr] ASC,
	[SenderName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ExcludeFrom]') AND name = N'Pi01_ExcludeFrom')
CREATE NONCLUSTERED INDEX [Pi01_ExcludeFrom] ON [dbo].[ExcludeFrom] 
(
	[FromEmailAddr] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[EmailImageTypeUpdProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailImageTypeUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: EmailImageTypeUpdProc 
 */

CREATE PROCEDURE [dbo].[EmailImageTypeUpdProc]
(
    @ImageTypeCode     nvarchar(50),
    @Description       nvarchar(254)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE EmailImageType
       SET Description        = @Description
     WHERE ImageTypeCode = @ImageTypeCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''EmailImageTypeUpdProc: Cannot update  in EmailImageType ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[EmailImageTypeSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailImageTypeSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[EmailImageTypeInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailImageTypeInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: EmailImageTypeInsProc 
 */

CREATE PROCEDURE [dbo].[EmailImageTypeInsProc]
(
    @ImageTypeCode     nvarchar(50),
    @Description       nvarchar(254)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO EmailImageType(ImageTypeCode,
                               Description)
    VALUES(@ImageTypeCode,
           @Description)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''EmailImageTypeInsProc: Cannot insert because primary key value not found in EmailImageType ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[EmailImageTypeDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailImageTypeDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: EmailImageTypeDelProc 
 */

CREATE PROCEDURE [dbo].[EmailImageTypeDelProc]
(
    @ImageTypeCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM EmailImageType
     WHERE ImageTypeCode = @ImageTypeCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''EmailImageTypeDelProc: Cannot delete because foreign keys still exist in EmailImageType ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[EmailImageUpdProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailImageUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: EmailImageUpdProc 
 */

CREATE PROCEDURE [dbo].[EmailImageUpdProc]
(
    @emailImage        image                   = NULL,
    @EmailGuid         nvarchar(50),
    @ImageTypeCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    UPDATE EmailImage
       SET emailImage         = @emailImage
     WHERE EmailGuid     = @EmailGuid
       AND ImageTypeCode = @ImageTypeCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''EmailImageUpdProc: Cannot update  in EmailImage ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[EmailImageSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailImageSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[EmailImageInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailImageInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: EmailImageInsProc 
 */

CREATE PROCEDURE [dbo].[EmailImageInsProc]
(
    @emailImage        image                   = NULL,
    @EmailGuid         nvarchar(50),
    @ImageTypeCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO EmailImage(emailImage,
                           EmailGuid,
                           ImageTypeCode)
    VALUES(@emailImage,
           @EmailGuid,
           @ImageTypeCode)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''EmailImageInsProc: Cannot insert because primary key value not found in EmailImage ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[EmailImageDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailImageDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: EmailImageDelProc 
 */

CREATE PROCEDURE [dbo].[EmailImageDelProc]
(
    @EmailGuid         nvarchar(50),
    @ImageTypeCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM EmailImage
     WHERE EmailGuid     = @EmailGuid
       AND ImageTypeCode = @ImageTypeCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''EmailImageDelProc: Cannot delete because foreign keys still exist in EmailImage ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  Table [dbo].[DataOwners]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataOwners]') AND type in (N'U'))
BEGIN
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
 CONSTRAINT [PK42] PRIMARY KEY NONCLUSTERED 
(
	[SourceGuid] ASC,
	[UserID] ASC,
	[GroupOwnerUserID] ASC,
	[GroupName] ASC,
	[DataSourceOwnerUserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [SourceTypeUpdTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[SourceTypeUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: SourceTypeUpdTrig 
 */

CREATE TRIGGER [dbo].[SourceTypeUpdTrig] ON [dbo].[SourceType]
FOR UPDATE AS
BEGIN
    DECLARE
        @SourceTypeCode nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: RESTRICT

    IF (UPDATE(SourceTypeCode))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM DataSource ch, deleted
          WHERE ch.SourceTypeCode = deleted.SourceTypeCode) != 0)
        BEGIN
            RAISERROR 30001 ''SourceTypeUpdTrigCannot update because foreign keys still exist in DataSource''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [SourceTypeDelTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[SourceTypeDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: SourceTypeDelTrig 
 */

CREATE TRIGGER [dbo].[SourceTypeDelTrig] ON [dbo].[SourceType]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM DataSource ch, deleted
         WHERE ch.SourceTypeCode = deleted.SourceTypeCode) != 0)
    BEGIN
        RAISERROR 30002 ''SourceTypeDelTrigCannot delete because foreign keys still exist in DataSource''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Trigger [DataSourceDelTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[DataSourceDelTrig]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[DataSourceDelTrig] ON [dbo].[DataSource]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: CASCADE

    DELETE DataSourceCheckOut
        FROM DataSourceCheckOut ch, deleted
        WHERE ch.SourceGuid = deleted.SourceGuid AND
           ch.DataSourceOwnerUserID = deleted.DataSourceOwnerUserID
-- Parent Delete: CASCADE

    DELETE SourceAttribute
        FROM SourceAttribute ch, deleted
        WHERE ch.DataSourceOwnerUserID = deleted.DataSourceOwnerUserID AND
           ch.SourceGuid = deleted.SourceGuid

END
'
GO
/****** Object:  Table [dbo].[DeleteFrom]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteFrom]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DeleteFrom](
	[FromEmailAddr] [nvarchar](254) NOT NULL,
	[SenderName] [varchar](254) NOT NULL,
	[UserID] [varchar](25) NOT NULL,
 CONSTRAINT [PK40] PRIMARY KEY NONCLUSTERED 
(
	[FromEmailAddr] ASC,
	[SenderName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[DB_Updates]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DB_Updates]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DB_Updates](
	[SqlStmt] [nvarchar](max) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[FixID] [int] NOT NULL,
	[FixDescription] [nvarchar](4000) NULL,
	[DBName] [nvarchar](50) NULL,
	[CompanyID] [nvarchar](50) NULL,
	[MachineName] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DB_Updates]') AND name = N'UK_Db_Updates')
CREATE UNIQUE NONCLUSTERED INDEX [UK_Db_Updates] ON [dbo].[DB_Updates] 
(
	[FixID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DB_UpdateHist]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DB_UpdateHist]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DB_UpdateHist](
	[CreateDate] [datetime] NOT NULL,
	[FixID] [int] NOT NULL,
	[DBName] [nvarchar](50) NULL,
	[CompanyID] [nvarchar](50) NULL,
	[MachineName] [nvarchar](50) NULL,
	[Status] [nvarchar](50) NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DB_UpdateHist]') AND name = N'UI_UpdateHistory')
CREATE UNIQUE NONCLUSTERED INDEX [UI_UpdateHistory] ON [dbo].[DB_UpdateHist] 
(
	[FixID] ASC,
	[CompanyID] ASC,
	[MachineName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DB_UpdateHist]') AND name = N'UK_UpdateHist')
CREATE UNIQUE NONCLUSTERED INDEX [UK_UpdateHist] ON [dbo].[DB_UpdateHist] 
(
	[FixID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DataTypeCodes]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypeCodes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DataTypeCodes](
	[FileType] [nvarchar](255) NULL,
	[VerNbr] [nvarchar](255) NULL,
	[Publisher] [nvarchar](255) NULL,
	[Definition] [nvarchar](255) NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DataTypeCodes]') AND name = N'PK_DataTypeCodes')
CREATE UNIQUE CLUSTERED INDEX [PK_DataTypeCodes] ON [dbo].[DataTypeCodes] 
(
	[FileType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[DeleteFromInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteFromInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DeleteFromInsProc]
(
    @FromEmailAddr     nvarchar(254),
    @SenderName        varchar(254),
    @UserID            varchar(25))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO DeleteFrom(FromEmailAddr,
                           SenderName,
                           UserID)
    VALUES(@FromEmailAddr,
           @SenderName,
           @UserID)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''DeleteFromInsProc: Cannot insert because primary key value not found in DeleteFrom ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  Trigger [DatabasesDelTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[DatabasesDelTrig]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[DatabasesDelTrig] ON [dbo].[Databases]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM Directory ch, deleted
         WHERE ch.DB_ID = deleted.DB_ID) != 0)
    BEGIN
        RAISERROR 30002 ''DatabasesDelTrigCannot delete because foreign keys still exist in Directory''
        ROLLBACK TRAN
    END
-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM EmailArchParms ch, deleted
         WHERE ch.DB_ID = deleted.DB_ID) != 0)
    BEGIN
        RAISERROR 30002 ''DatabasesDelTrigCannot delete because foreign keys still exist in EmailArchParms''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Table [dbo].[EcmUser]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EcmUser]') AND type in (N'U'))
BEGIN
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
 CONSTRAINT [PK8] PRIMARY KEY CLUSTERED 
(
	[EMail] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  StoredProcedure [dbo].[EcmResponseUpdProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EcmResponseUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: EcmResponseUpdProc 
 */

CREATE PROCEDURE [dbo].[EcmResponseUpdProc]
(
    @IssueTitle      nvarchar(250),
    @Response        nvarchar(max)            = NULL,
    @CreateDate      nvarchar(50)             = NULL,
    @LastModDate     datetime                 = NULL,
    @ResponseID      int)
AS
BEGIN
    BEGIN TRAN

    UPDATE EcmResponse
       SET Response         = @Response,
           CreateDate       = @CreateDate,
           LastModDate      = @LastModDate
     WHERE IssueTitle = @IssueTitle
       AND ResponseID = @ResponseID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''EcmResponseUpdProc: Cannot update  in EcmResponse ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[EcmResponseSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EcmResponseSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[EcmResponseInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EcmResponseInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: EcmResponseInsProc 
 */

CREATE PROCEDURE [dbo].[EcmResponseInsProc]
(
    @IssueTitle      nvarchar(250),
    @Response        nvarchar(max)            = NULL,
    @CreateDate      nvarchar(50)             = NULL,
    @LastModDate     datetime                 = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO EcmResponse(IssueTitle,
                            Response,
                            CreateDate,
                            LastModDate 
                            )
    VALUES(@IssueTitle,
           @Response,
           @CreateDate,
           @LastModDate 
           )

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''EcmResponseInsProc: Cannot insert because primary key value not found in EcmResponse ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[EcmResponseDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EcmResponseDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: EcmResponseDelProc 
 */

CREATE PROCEDURE [dbo].[EcmResponseDelProc]
(
    @IssueTitle      nvarchar(250),
    @ResponseID      int)
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM EcmResponse
     WHERE IssueTitle = @IssueTitle
       AND ResponseID = @ResponseID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''EcmResponseDelProc: Cannot delete because foreign keys still exist in EcmResponse ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[EcmIssueUpdProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EcmIssueUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: EcmIssueUpdProc 
 */

CREATE PROCEDURE [dbo].[EcmIssueUpdProc]
(
    @IssueTitle           nvarchar(250),
    @IssueDescription     nvarchar(max)            = NULL,
    @CreationDate         nvarchar(50)             = NULL,
    @StatusCode           nvarchar(50),
    @SeverityCode         nvarchar(50),
    @CategoryName         nvarchar(50),
    @EMail                nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    UPDATE EcmIssue
       SET IssueDescription      = @IssueDescription,
           CreationDate          = @CreationDate,
           StatusCode            = @StatusCode,
           SeverityCode          = @SeverityCode,
           CategoryName          = @CategoryName,
           EMail                 = @EMail
     WHERE IssueTitle = @IssueTitle

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''EcmIssueUpdProc: Cannot update  in EcmIssue ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[EcmIssueSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EcmIssueSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[EcmIssueInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EcmIssueInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: EcmIssueInsProc 
 */

CREATE PROCEDURE [dbo].[EcmIssueInsProc]
(
    @IssueTitle           nvarchar(250),
    @IssueDescription     nvarchar(max)            = NULL,
    @CreationDate         nvarchar(50)             = NULL,
    @StatusCode           nvarchar(50),
    @SeverityCode         nvarchar(50),
    @CategoryName         nvarchar(50),
    @EMail                nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO EcmIssue(IssueTitle,
                         IssueDescription,
                         CreationDate,
                         StatusCode,
                         SeverityCode,
                         CategoryName,
                         EMail)
    VALUES(@IssueTitle,
           @IssueDescription,
           @CreationDate,
           @StatusCode,
           @SeverityCode,
           @CategoryName,
           @EMail)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''EcmIssueInsProc: Cannot insert because primary key value not found in EcmIssue ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[EcmIssueDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EcmIssueDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: EcmIssueDelProc 
 */

CREATE PROCEDURE [dbo].[EcmIssueDelProc]
(
    @IssueTitle           nvarchar(250))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM EcmIssue
     WHERE IssueTitle = @IssueTitle

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''EcmIssueDelProc: Cannot delete because foreign keys still exist in EcmIssue ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  Table [dbo].[EmailAttachment]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailAttachment]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[EmailAttachment](
	[Attachment] [image] NULL,
	[AttachmentName] [nvarchar](254) NULL,
	[EmailGuid] [nvarchar](50) NOT NULL,
	[AttachmentCode] [nvarchar](50) NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[AttachmentType] [nvarchar](50) NOT NULL,
	[UserID] [nvarchar](50) NOT NULL,
	[isZipFileEntry] [bit] NULL,
	[OcrText] [nvarchar](max) NULL,
	[isPublic] [char](1) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EmailAttachment]') AND name = N'_dta_index_EmailAttachment_11_1429580131__K3')
CREATE NONCLUSTERED INDEX [_dta_index_EmailAttachment_11_1429580131__K3] ON [dbo].[EmailAttachment] 
(
	[EmailGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EmailAttachment]') AND name = N'_dta_index_EmailAttachment_11_1429580131__K5_3_7')
CREATE NONCLUSTERED INDEX [_dta_index_EmailAttachment_11_1429580131__K5_3_7] ON [dbo].[EmailAttachment] 
(
	[RowID] ASC
)
INCLUDE ( [EmailGuid],
[UserID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[EmailAttachment]') AND name = N'UK_EMAILATTACHMENT')
CREATE UNIQUE NONCLUSTERED INDEX [UK_EMAILATTACHMENT] ON [dbo].[EmailAttachment] 
(
	[RowID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = ON, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF not EXISTS (SELECT * FROM sys.fulltext_indexes fti WHERE fti.object_id = OBJECT_ID(N'[dbo].[EmailAttachment]'))
CREATE FULLTEXT INDEX ON [dbo].[EmailAttachment](
[Attachment] TYPE COLUMN [AttachmentCode] LANGUAGE [English], 
[OcrText] LANGUAGE [English])
KEY INDEX [UK_EMAILATTACHMENT]ON ([ftEmailCatalog], FILEGROUP [PRIMARY])
WITH (CHANGE_TRACKING = AUTO, STOPLIST = SYSTEM)
GO
/****** Object:  Table [dbo].[AttachmentType]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttachmentType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AttachmentType](
	[AttachmentCode] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](254) NULL,
	[isZipFormat] [bit] NULL,
 CONSTRAINT [PK29] PRIMARY KEY CLUSTERED 
(
	[AttachmentCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [AttachmentTypeUpdTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[AttachmentTypeUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: AttachmentTypeUpdTrig 
 */

CREATE TRIGGER [dbo].[AttachmentTypeUpdTrig] ON [dbo].[AttachmentType]
FOR UPDATE AS
BEGIN
    DECLARE
        @AttachmentCode nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: RESTRICT

    IF (UPDATE(AttachmentCode))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM EmailAttachment ch, deleted
          WHERE ch.AttachmentCode = deleted.AttachmentCode) != 0)
        BEGIN
            RAISERROR 30001 ''AttachmentTypeUpdTrigCannot update because foreign keys still exist in EmailAttachment''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [AttachmentTypeDelTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[AttachmentTypeDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: AttachmentTypeDelTrig 
 */

CREATE TRIGGER [dbo].[AttachmentTypeDelTrig] ON [dbo].[AttachmentType]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM EmailAttachment ch, deleted
         WHERE ch.AttachmentCode = deleted.AttachmentCode) != 0)
    BEGIN
        RAISERROR 30002 ''AttachmentTypeDelTrigCannot delete because foreign keys still exist in EmailAttachment''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Table [dbo].[Storage]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Storage]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Storage](
	[StoreCode] [nvarchar](50) NOT NULL,
	[StoreDesc] [nvarchar](18) NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK17] PRIMARY KEY CLUSTERED 
(
	[StoreCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [StorageUpdTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[StorageUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: StorageUpdTrig 
 */

CREATE TRIGGER [dbo].[StorageUpdTrig] ON [dbo].[Storage]
FOR UPDATE AS
BEGIN
    DECLARE
        @StoreCode nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: RESTRICT

    IF (UPDATE(StoreCode))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM ContainerStorage ch, deleted
          WHERE ch.StoreCode = deleted.StoreCode) != 0)
        BEGIN
            RAISERROR 30001 ''StorageUpdTrigCannot update because foreign keys still exist in ContainerStorage''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [StorageDelTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[StorageDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: StorageDelTrig 
 */

CREATE TRIGGER [dbo].[StorageDelTrig] ON [dbo].[Storage]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM ContainerStorage ch, deleted
         WHERE ch.StoreCode = deleted.StoreCode) != 0)
    BEGIN
        RAISERROR 30002 ''StorageDelTrigCannot delete because foreign keys still exist in ContainerStorage''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  StoredProcedure [dbo].[CompanyUpdProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CompanyUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: CompanyUpdProc 
 */

CREATE PROCEDURE [dbo].[CompanyUpdProc]
(
    @CompanyID       nvarchar(50),
    @CompanyName     nvarchar(18))
AS
BEGIN
    BEGIN TRAN

    UPDATE Company
       SET CompanyName      = @CompanyName
     WHERE CompanyID = @CompanyID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''CompanyUpdProc: Cannot update  in Company ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[CompanySelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CompanySelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[CompanyInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CompanyInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: CompanyInsProc 
 */

CREATE PROCEDURE [dbo].[CompanyInsProc]
(
    @CompanyID       nvarchar(50),
    @CompanyName     nvarchar(18))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Company(CompanyID,
                        CompanyName)
    VALUES(@CompanyID,
           @CompanyName)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''CompanyInsProc: Cannot insert because primary key value not found in Company ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[CompanyDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CompanyDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: CompanyDelProc 
 */

CREATE PROCEDURE [dbo].[CompanyDelProc]
(
    @CompanyID       nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Company
     WHERE CompanyID = @CompanyID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''CompanyDelProc: Cannot delete because foreign keys still exist in Company ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[CategoryUpdProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CategoryUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: CategoryUpdProc 
 */

CREATE PROCEDURE [dbo].[CategoryUpdProc]
(
    @CategoryName     nvarchar(50),
    @Description      nvarchar(1000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE Category
       SET Description       = @Description
     WHERE CategoryName = @CategoryName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''CategoryUpdProc: Cannot update  in Category ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[CategorySelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CategorySelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[CategoryInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CategoryInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: CategoryInsProc 
 */

CREATE PROCEDURE [dbo].[CategoryInsProc]
(
    @CategoryName     nvarchar(50),
    @Description      nvarchar(1000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Category(CategoryName,
                         Description)
    VALUES(@CategoryName,
           @Description)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''CategoryInsProc: Cannot insert because primary key value not found in Category ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[CategoryDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CategoryDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: CategoryDelProc 
 */

CREATE PROCEDURE [dbo].[CategoryDelProc]
(
    @CategoryName     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Category
     WHERE CategoryName = @CategoryName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''CategoryDelProc: Cannot delete because foreign keys still exist in Category ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  Table [dbo].[ContactsArchive]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactsArchive]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ContactsArchive](
	[Email1Address] [nvarchar](80) NOT NULL,
	[FullName] [nvarchar](80) NOT NULL,
	[UserID] [char](25) NOT NULL,
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
 CONSTRAINT [PK45] PRIMARY KEY NONCLUSTERED 
(
	[Email1Address] ASC,
	[FullName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ContactFrom]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactFrom]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ContactFrom](
	[FromEmailAddr] [nvarchar](254) NOT NULL,
	[SenderName] [varchar](254) NOT NULL,
	[UserID] [varchar](25) NOT NULL,
	[Verified] [int] NULL,
 CONSTRAINT [ContactFrom_PK] PRIMARY KEY NONCLUSTERED 
(
	[FromEmailAddr] ASC,
	[SenderName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [FUncSkipWordsUpdTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[FUncSkipWordsUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: FUncSkipWordsUpdTrig 
 */

CREATE TRIGGER [dbo].[FUncSkipWordsUpdTrig] ON [dbo].[FUncSkipWords]
FOR UPDATE AS
BEGIN
    DECLARE
        @CorpFuncName nvarchar(80),
        @tgtWord nvarchar(18),
        @CorpName nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Child Update: RESTRICT

    IF (UPDATE(CorpFuncName) OR
        UPDATE(CorpName))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM CorpFunction pr, inserted
          WHERE pr.CorpFuncName = inserted.CorpFuncName AND
             pr.CorpName = inserted.CorpName) != @Rows)
        BEGIN
            RAISERROR 30001 ''FUncSkipWordsUpdTrigCannot update because primary key value not found in CorpFunction''
            ROLLBACK TRAN
        END
    END
-- Child Update: RESTRICT

    IF (UPDATE(tgtWord))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM SkipWords pr, inserted
          WHERE pr.tgtWord = inserted.tgtWord) != @Rows)
        BEGIN
            RAISERROR 30001 ''FUncSkipWordsUpdTrigCannot update because primary key value not found in SkipWords''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [FUncSkipWordsInsTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[FUncSkipWordsInsTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: FUncSkipWordsInsTrig 
 */

CREATE TRIGGER [dbo].[FUncSkipWordsInsTrig] ON [dbo].[FUncSkipWords]
FOR INSERT AS
BEGIN
    DECLARE
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Child Insert: RESTRICT

    IF ((SELECT COUNT(*)
         FROM CorpFunction pr, inserted
         WHERE pr.CorpFuncName = inserted.CorpFuncName AND
           pr.CorpName = inserted.CorpName) != @Rows)
    BEGIN
        RAISERROR 30000 ''FUncSkipWordsInsTrigCannot insert because primary key value not found in CorpFunction''
        ROLLBACK TRAN
    END
-- Child Insert: RESTRICT

    IF ((SELECT COUNT(*)
         FROM SkipWords pr, inserted
         WHERE pr.tgtWord = inserted.tgtWord) != @Rows)
    BEGIN
        RAISERROR 30000 ''FUncSkipWordsInsTrigCannot insert because primary key value not found in SkipWords''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Trigger [CorporationUpdTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[CorporationUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: CorporationUpdTrig 
 */

CREATE TRIGGER [dbo].[CorporationUpdTrig] ON [dbo].[Corporation]
FOR UPDATE AS
BEGIN
    DECLARE
        @CorpName nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: RESTRICT

    IF (UPDATE(CorpName))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM CorpFunction ch, deleted
          WHERE ch.CorpName = deleted.CorpName) != 0)
        BEGIN
            RAISERROR 30001 ''CorporationUpdTrigCannot update because foreign keys still exist in CorpFunction''
            ROLLBACK TRAN
        END
    END
-- Parent Update: RESTRICT

    IF (UPDATE(CorpName))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM ConvertedDocs ch, deleted
          WHERE ch.CorpName = deleted.CorpName) != 0)
        BEGIN
            RAISERROR 30001 ''CorporationUpdTrigCannot update because foreign keys still exist in ConvertedDocs''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [CorporationDelTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[CorporationDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: CorporationDelTrig 
 */

CREATE TRIGGER [dbo].[CorporationDelTrig] ON [dbo].[Corporation]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM CorpFunction ch, deleted
         WHERE ch.CorpName = deleted.CorpName) != 0)
    BEGIN
        RAISERROR 30002 ''CorporationDelTrigCannot delete because foreign keys still exist in CorpFunction''
        ROLLBACK TRAN
    END
-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM ConvertedDocs ch, deleted
         WHERE ch.CorpName = deleted.CorpName) != 0)
    BEGIN
        RAISERROR 30002 ''CorporationDelTrigCannot delete because foreign keys still exist in ConvertedDocs''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Trigger [CorpContainerUpdTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[CorpContainerUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: CorpContainerUpdTrig 
 */

CREATE TRIGGER [dbo].[CorpContainerUpdTrig] ON [dbo].[CorpContainer]
FOR UPDATE AS
BEGIN
    DECLARE
        @ContainerType nvarchar(25),
        @CorpFuncName nvarchar(80),
        @CorpName nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: RESTRICT

    IF (UPDATE(CorpFuncName) OR
        UPDATE(ContainerType) OR
        UPDATE(CorpName))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM InformationProduct ch, deleted
          WHERE ch.CorpFuncName = deleted.CorpFuncName AND
           ch.ContainerType = deleted.ContainerType AND
           ch.CorpName = deleted.CorpName) != 0)
        BEGIN
            RAISERROR 30001 ''CorpContainerUpdTrigCannot update because foreign keys still exist in InformationProduct''
            ROLLBACK TRAN
        END
    END
-- Child Update: RESTRICT

    IF (UPDATE(ContainerType))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM SourceContainer pr, inserted
          WHERE pr.ContainerType = inserted.ContainerType) != @Rows)
        BEGIN
            RAISERROR 30001 ''CorpContainerUpdTrigCannot update because primary key value not found in SourceContainer''
            ROLLBACK TRAN
        END
    END
-- Child Update: RESTRICT

    IF (UPDATE(QtyDocCode))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM QtyDocs pr, inserted
          WHERE pr.QtyDocCode = inserted.QtyDocCode) != @Rows)
        BEGIN
            RAISERROR 30001 ''CorpContainerUpdTrigCannot update because primary key value not found in QtyDocs''
            ROLLBACK TRAN
        END
    END
-- Child Update: RESTRICT

    IF (UPDATE(CorpFuncName) OR
        UPDATE(CorpName))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM CorpFunction pr, inserted
          WHERE pr.CorpFuncName = inserted.CorpFuncName AND
             pr.CorpName = inserted.CorpName) != @Rows)
        BEGIN
            RAISERROR 30001 ''CorpContainerUpdTrigCannot update because primary key value not found in CorpFunction''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [CorpContainerInsTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[CorpContainerInsTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: CorpContainerInsTrig 
 */

CREATE TRIGGER [dbo].[CorpContainerInsTrig] ON [dbo].[CorpContainer]
FOR INSERT AS
BEGIN
    DECLARE
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Child Insert: RESTRICT

    IF ((SELECT COUNT(*)
         FROM SourceContainer pr, inserted
         WHERE pr.ContainerType = inserted.ContainerType) != @Rows)
    BEGIN
        RAISERROR 30000 ''CorpContainerInsTrigCannot insert because primary key value not found in SourceContainer''
        ROLLBACK TRAN
    END
-- Child Insert: RESTRICT

    IF ((SELECT COUNT(*)
         FROM QtyDocs pr, inserted
         WHERE pr.QtyDocCode = inserted.QtyDocCode) != @Rows)
    BEGIN
        RAISERROR 30000 ''CorpContainerInsTrigCannot insert because primary key value not found in QtyDocs''
        ROLLBACK TRAN
    END
-- Child Insert: RESTRICT

    IF ((SELECT COUNT(*)
         FROM CorpFunction pr, inserted
         WHERE pr.CorpFuncName = inserted.CorpFuncName AND
           pr.CorpName = inserted.CorpName) != @Rows)
    BEGIN
        RAISERROR 30000 ''CorpContainerInsTrigCannot insert because primary key value not found in CorpFunction''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Table [dbo].[JargonWords]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[JargonWords]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[JargonWords](
	[tgtWord] [nvarchar](50) NOT NULL,
	[jDesc] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NULL,
	[JargonCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK12] PRIMARY KEY CLUSTERED 
(
	[JargonCode] ASC,
	[tgtWord] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[BusinessFunctionJargon]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusinessFunctionJargon]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[BusinessFunctionJargon](
	[CorpFuncName] [nvarchar](80) NOT NULL,
	[WordID] [int] IDENTITY(1,1) NOT NULL,
	[JargonWords_tgtWord] [nvarchar](50) NOT NULL,
	[JargonCode] [nvarchar](50) NOT NULL,
	[CorpName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK23] PRIMARY KEY NONCLUSTERED 
(
	[CorpFuncName] ASC,
	[WordID] ASC,
	[JargonWords_tgtWord] ASC,
	[JargonCode] ASC,
	[CorpName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [BusinessFunctionJargonUpdTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BusinessFunctionJargonUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: BusinessFunctionJargonUpdTrig 
 */

CREATE TRIGGER [dbo].[BusinessFunctionJargonUpdTrig] ON [dbo].[BusinessFunctionJargon]
FOR UPDATE AS
BEGIN
    DECLARE
        @CorpFuncName nvarchar(80),
        @JargonWords_tgtWord nvarchar(50),
        @JargonCode nvarchar(50),
        @WordID int,
        @CorpName nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Child Update: RESTRICT

    IF (UPDATE(CorpFuncName) OR
        UPDATE(CorpName))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM CorpFunction pr, inserted
          WHERE pr.CorpFuncName = inserted.CorpFuncName AND
             pr.CorpName = inserted.CorpName) != @Rows)
        BEGIN
            RAISERROR 30001 ''BusinessFunctionJargonUpdTrigCannot update because primary key value not found in CorpFunction''
            ROLLBACK TRAN
        END
    END
-- Child Update: RESTRICT

    IF (UPDATE(JargonWords_tgtWord) OR
        UPDATE(JargonCode))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM JargonWords pr, inserted
          WHERE pr.tgtWord = inserted.JargonWords_tgtWord AND
             pr.JargonCode = inserted.JargonCode) != @Rows)
        BEGIN
            RAISERROR 30001 ''BusinessFunctionJargonUpdTrigCannot update because primary key value not found in JargonWords''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [BusinessFunctionJargonInsTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[BusinessFunctionJargonInsTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: BusinessFunctionJargonInsTrig 
 */

CREATE TRIGGER [dbo].[BusinessFunctionJargonInsTrig] ON [dbo].[BusinessFunctionJargon]
FOR INSERT AS
BEGIN
    DECLARE
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Child Insert: RESTRICT

    IF ((SELECT COUNT(*)
         FROM CorpFunction pr, inserted
         WHERE pr.CorpFuncName = inserted.CorpFuncName AND
           pr.CorpName = inserted.CorpName) != @Rows)
    BEGIN
        RAISERROR 30000 ''BusinessFunctionJargonInsTrigCannot insert because primary key value not found in CorpFunction''
        ROLLBACK TRAN
    END
-- Child Insert: RESTRICT

    IF ((SELECT COUNT(*)
         FROM JargonWords pr, inserted
         WHERE pr.tgtWord = inserted.JargonWords_tgtWord AND
           pr.JargonCode = inserted.JargonCode) != @Rows)
    BEGIN
        RAISERROR 30000 ''BusinessFunctionJargonInsTrigCannot insert because primary key value not found in JargonWords''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Trigger [SourceContainerUpdTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[SourceContainerUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: SourceContainerUpdTrig 
 */

CREATE TRIGGER [dbo].[SourceContainerUpdTrig] ON [dbo].[SourceContainer]
FOR UPDATE AS
BEGIN
    DECLARE
        @ContainerType nvarchar(25),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: RESTRICT

    IF (UPDATE(ContainerType))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM CorpContainer ch, deleted
          WHERE ch.ContainerType = deleted.ContainerType) != 0)
        BEGIN
            RAISERROR 30001 ''SourceContainerUpdTrigCannot update because foreign keys still exist in CorpContainer''
            ROLLBACK TRAN
        END
    END
-- Parent Update: RESTRICT

    IF (UPDATE(ContainerType))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM ContainerStorage ch, deleted
          WHERE ch.ContainerType = deleted.ContainerType) != 0)
        BEGIN
            RAISERROR 30001 ''SourceContainerUpdTrigCannot update because foreign keys still exist in ContainerStorage''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [SourceContainerDelTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[SourceContainerDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: SourceContainerDelTrig 
 */

CREATE TRIGGER [dbo].[SourceContainerDelTrig] ON [dbo].[SourceContainer]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM CorpContainer ch, deleted
         WHERE ch.ContainerType = deleted.ContainerType) != 0)
    BEGIN
        RAISERROR 30002 ''SourceContainerDelTrigCannot delete because foreign keys still exist in CorpContainer''
        ROLLBACK TRAN
    END
-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM ContainerStorage ch, deleted
         WHERE ch.ContainerType = deleted.ContainerType) != 0)
    BEGIN
        RAISERROR 30002 ''SourceContainerDelTrigCannot delete because foreign keys still exist in ContainerStorage''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Table [dbo].[QtyDocs]    Script Date: 07/20/2009 10:50:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QtyDocs]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QtyDocs](
	[QtyDocCode] [nvarchar](10) NOT NULL,
	[Description] [nvarchar](4000) NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK9] PRIMARY KEY NONCLUSTERED 
(
	[QtyDocCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [QtyDocsUpdTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[QtyDocsUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: QtyDocsUpdTrig 
 */

CREATE TRIGGER [dbo].[QtyDocsUpdTrig] ON [dbo].[QtyDocs]
FOR UPDATE AS
BEGIN
    DECLARE
        @QtyDocCode nvarchar(10),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: RESTRICT

    IF (UPDATE(QtyDocCode))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM CorpContainer ch, deleted
          WHERE ch.QtyDocCode = deleted.QtyDocCode) != 0)
        BEGIN
            RAISERROR 30001 ''QtyDocsUpdTrigCannot update because foreign keys still exist in CorpContainer''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [QtyDocsDelTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[QtyDocsDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: QtyDocsDelTrig 
 */

CREATE TRIGGER [dbo].[QtyDocsDelTrig] ON [dbo].[QtyDocs]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM CorpContainer ch, deleted
         WHERE ch.QtyDocCode = deleted.QtyDocCode) != 0)
    BEGIN
        RAISERROR 30002 ''QtyDocsDelTrigCannot delete because foreign keys still exist in CorpContainer''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Trigger [JargonWordsInsTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[JargonWordsInsTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: JargonWordsInsTrig 
 */

CREATE TRIGGER [dbo].[JargonWordsInsTrig] ON [dbo].[JargonWords]
FOR INSERT AS
BEGIN
    DECLARE
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Child Insert: RESTRICT

    IF ((SELECT COUNT(*)
         FROM BusinessJargonCode pr, inserted
         WHERE pr.JargonCode = inserted.JargonCode) != @Rows)
    BEGIN
        RAISERROR 30000 ''JargonWordsInsTrigCannot insert because primary key value not found in BusinessJargonCode''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Trigger [FunctionProdJargonUpdTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[FunctionProdJargonUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: FunctionProdJargonUpdTrig 
 */

CREATE TRIGGER [dbo].[FunctionProdJargonUpdTrig] ON [dbo].[FunctionProdJargon]
FOR UPDATE AS
BEGIN
    DECLARE
        @CorpFuncName nvarchar(80),
        @JargonCode nvarchar(50),
        @CorpName nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Child Update: RESTRICT

    IF (UPDATE(RepeatDataCode))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM RepeatData pr, inserted
          WHERE pr.RepeatDataCode = inserted.RepeatDataCode) != @Rows)
        BEGIN
            RAISERROR 30001 ''FunctionProdJargonUpdTrigCannot update because primary key value not found in RepeatData''
            ROLLBACK TRAN
        END
    END
-- Child Update: RESTRICT

    IF (UPDATE(CorpFuncName) OR
        UPDATE(CorpName))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM CorpFunction pr, inserted
          WHERE pr.CorpFuncName = inserted.CorpFuncName AND
             pr.CorpName = inserted.CorpName) != @Rows)
        BEGIN
            RAISERROR 30001 ''FunctionProdJargonUpdTrigCannot update because primary key value not found in CorpFunction''
            ROLLBACK TRAN
        END
    END
-- Child Update: RESTRICT

    IF (UPDATE(JargonCode))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM BusinessJargonCode pr, inserted
          WHERE pr.JargonCode = inserted.JargonCode) != @Rows)
        BEGIN
            RAISERROR 30001 ''FunctionProdJargonUpdTrigCannot update because primary key value not found in BusinessJargonCode''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [FunctionProdJargonInsTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[FunctionProdJargonInsTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: FunctionProdJargonInsTrig 
 */

CREATE TRIGGER [dbo].[FunctionProdJargonInsTrig] ON [dbo].[FunctionProdJargon]
FOR INSERT AS
BEGIN
    DECLARE
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Child Insert: RESTRICT

    IF ((SELECT COUNT(*)
         FROM RepeatData pr, inserted
         WHERE pr.RepeatDataCode = inserted.RepeatDataCode) != @Rows)
    BEGIN
        RAISERROR 30000 ''FunctionProdJargonInsTrigCannot insert because primary key value not found in RepeatData''
        ROLLBACK TRAN
    END
-- Child Insert: RESTRICT

    IF ((SELECT COUNT(*)
         FROM CorpFunction pr, inserted
         WHERE pr.CorpFuncName = inserted.CorpFuncName AND
           pr.CorpName = inserted.CorpName) != @Rows)
    BEGIN
        RAISERROR 30000 ''FunctionProdJargonInsTrigCannot insert because primary key value not found in CorpFunction''
        ROLLBACK TRAN
    END
-- Child Insert: RESTRICT

    IF ((SELECT COUNT(*)
         FROM BusinessJargonCode pr, inserted
         WHERE pr.JargonCode = inserted.JargonCode) != @Rows)
    BEGIN
        RAISERROR 30000 ''FunctionProdJargonInsTrigCannot insert because primary key value not found in BusinessJargonCode''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Table [dbo].[AvailFileTypesUndefined]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AvailFileTypesUndefined]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AvailFileTypesUndefined](
	[FileType] [nvarchar](50) NOT NULL,
	[SubstituteType] [nvarchar](50) NULL,
	[Applied] [bit] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AvailFileTypesUndefined]') AND name = N'PK_AFTU')
CREATE UNIQUE NONCLUSTERED INDEX [PK_AFTU] ON [dbo].[AvailFileTypesUndefined] 
(
	[FileType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Trigger [ProdCaptureItemsUpdTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[ProdCaptureItemsUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: ProdCaptureItemsUpdTrig 
 */

CREATE TRIGGER [dbo].[ProdCaptureItemsUpdTrig] ON [dbo].[ProdCaptureItems]
FOR UPDATE AS
BEGIN
    DECLARE
        @CaptureItemsCode nvarchar(50),
        @ContainerType nvarchar(25),
        @CorpFuncName nvarchar(80),
        @CorpName nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Child Update: RESTRICT

    IF (UPDATE(CorpFuncName) OR
        UPDATE(CorpName) OR
        UPDATE(ContainerType))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM InformationProduct pr, inserted
          WHERE pr.CorpFuncName = inserted.CorpFuncName AND
             pr.CorpName = inserted.CorpName AND
             pr.ContainerType = inserted.ContainerType) != @Rows)
        BEGIN
            RAISERROR 30001 ''ProdCaptureItemsUpdTrigCannot update because primary key value not found in InformationProduct''
            ROLLBACK TRAN
        END
    END
-- Child Update: RESTRICT

    IF (UPDATE(CaptureItemsCode))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM CaptureItems pr, inserted
          WHERE pr.CaptureItemsCode = inserted.CaptureItemsCode) != @Rows)
        BEGIN
            RAISERROR 30001 ''ProdCaptureItemsUpdTrigCannot update because primary key value not found in CaptureItems''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [ProdCaptureItemsInsTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[ProdCaptureItemsInsTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: ProdCaptureItemsInsTrig 
 */

CREATE TRIGGER [dbo].[ProdCaptureItemsInsTrig] ON [dbo].[ProdCaptureItems]
FOR INSERT AS
BEGIN
    DECLARE
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Child Insert: RESTRICT

    IF ((SELECT COUNT(*)
         FROM InformationProduct pr, inserted
         WHERE pr.CorpFuncName = inserted.CorpFuncName AND
           pr.CorpName = inserted.CorpName AND
           pr.ContainerType = inserted.ContainerType) != @Rows)
    BEGIN
        RAISERROR 30000 ''ProdCaptureItemsInsTrigCannot insert because primary key value not found in InformationProduct''
        ROLLBACK TRAN
    END
-- Child Insert: RESTRICT

    IF ((SELECT COUNT(*)
         FROM CaptureItems pr, inserted
         WHERE pr.CaptureItemsCode = inserted.CaptureItemsCode) != @Rows)
    BEGIN
        RAISERROR 30000 ''ProdCaptureItemsInsTrigCannot insert because primary key value not found in CaptureItems''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  StoredProcedure [dbo].[sp_compare]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_compare]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[sp_compare] (
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

IF OBJECT_ID( ''tempdb..objects'' ) IS NOT NULL
        DROP TABLE tempdb..objects
IF OBJECT_ID( ''tempdb..columns'' ) IS NOT NULL
        DROP TABLE tempdb..columns
IF OBJECT_ID( ''tempdb..changed_tables_cols'' ) IS NOT NULL
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
SELECT @db1 = CASE WHEN @srcdb LIKE ''%.%'' 
		THEN reverse(substring(reverse(@srcdb), 1, charindex(''.'', reverse(@srcdb)) - 1)) 
		ELSE @srcdb
              END ,
	@db2 = CASE WHEN @destdb LIKE ''%.%'' 
		THEN reverse(substring(reverse(@destdb), 1, charindex(''.'', reverse(@destdb)) - 1)) 
		ELSE @destdb
	       END ,
	@server1 = CASE WHEN @srcdb LIKE ''%.%''
			THEN substring(@srcdb, 1, charindex(''.'', @srcdb))
			ELSE NULL
	           END ,
	@server2 = CASE WHEN @destdb LIKE ''%.%''
			THEN substring(@destdb, 1, charindex(''.'', @destdb))
			ELSE NULL
	           END,
	@objselect = ''select name, object_type = CASE type WHEN ''''U'''' THEN ''''table'''' '' + 
			''when ''''P'''' THEN ''''stored procedure'''' when ''''V'''' then ''''view'''' END '' +
			''from sysobjects WHERE type IN (''''U'''', ''''V'''', ''''P'''')'',
	@sp = ''master..sp_sqlexec'',
	@colselectsp = ''exec sp_columns''
SELECT	@db1command = stuff(@objselect, charindex(''sysobjects'', @objselect), 
				datalength(''sysobjects''), @db1 + ''..sysobjects''),
	@db2command = stuff(@objselect, charindex(''sysobjects'', @objselect), 
			datalength(''sysobjects''), @db2 + ''..sysobjects''),
	@sp1 =	@server1 + @sp, @sp2 = @server2 + @sp
SELECT	@db1command = stuff(@db1command, charindex(''name'', @db1command),
			datalength(''name'') , '''''''' + @srcdb + '''''', name''),
	@db2command = stuff(@db2command, charindex(''name'', @db2command),
				datalength(''name'') , '''''''' + @destdb + '''''', name'')
-- SQL70:
-- CREATE TABLE #objects (db_name varchar(128), name varchar(128), object_type varchar(30))
CREATE TABLE #objects (db_name varchar(61), name varchar(30), object_type varchar(30))
INSERT #objects EXEC @sp1 @db1command
INSERT #objects EXEC @sp2 @db2command
DELETE #objects WHERE name IN (''objects'', ''columns'', ''changed_tables_cols'', ''upgrade_status'')
SELECT @mesg = ''1. Tables present ONLY IN database: '' + @srcdb
PRINT @mesg
SELECT name FROM #objects
 WHERE object_type = ''table'' AND db_name = @srcdb and 
	name NOT IN (select name FROM #objects WHERE object_type = ''table'' AND db_name = @destdb)
 ORDER BY name
PRINT ''''
SELECT @mesg = ''2. Tables present ONLY IN database: '' + @destdb
PRINT @mesg
SELECT name FROM #objects
 WHERE object_type = ''table'' AND db_name = @destdb and 
	name NOT IN (select name FROM #objects WHERE object_type = ''table'' AND db_name = @srcdb)
 ORDER BY name
PRINT ''''
SELECT @mesg = ''Upgrade status table:''
PRINT @mesg
PRINT ''create TABLE upgrade_status''
PRINT ''(''
PRINT ''name varchar(30) NOT null,''
PRINT ''status varchar(10) NOT NULL
	CHECK (status IN (''''INCOMPLETE'''', ''''COMPLETE'''')) DEFAULT ''''INCOMPLETE''''''
PRINT '')''
PRINT ''go''
PRINT @mesg
SELECT @mesg = ''insert upgrade_status select name, ''''INCOMPLETE'''' FROM sysobjects '' +
		''where type = ''''U'''' AND name NOT IN (''''upgrade_status'''')''
PRINT @mesg
PRINT ''''
SELECT @mesg = ''Drop statements FOR the tables IN the database: '' + @destdb
PRINT @mesg
DECLARE drop_tables CURSOR FOR
SELECT name FROM #objects
 WHERE object_type = ''table'' AND db_name = @destdb and 
	name NOT IN (select name FROM #objects WHERE object_type = ''table'' AND db_name = @srcdb)
 ORDER BY name
OPEN drop_tables
WHILE( ''FETCH IS OK'' = ''FETCH IS OK'' )
BEGIN
    	FETCH NEXT FROM drop_tables INTO @table
    	IF @@FETCH_STATUS < 0 BREAK
    	SELECT @mesg = ''print ''''Dropping TABLE '' + @table + ''..''''''
    	PRINT @mesg
    	PRINT ''begin tran''
    	SELECT @mesg = ''if EXISTS (select name FROM upgrade_status WHERE name = '''''' + @table +
    			'''''' AND status = ''''INCOMPLETE'''')''
    	PRINT @mesg
    	PRINT ''begin''
    	SELECT @mesg = '' DROP TABLE '' + @table
    	PRINT @mesg
    	PRINT '' IF @@error <> 0''
    	PRINT '' begin''
    	PRINT '' IF @@trancount > 0''
    	PRINT ''rollback tran''
    	PRINT '' end''
    	PRINT '' else''
    	PRINT '' begin''
    	SELECT @mesg = '' UPDATE upgrade_status SET status = ''''COMPLETE'''' WHERE name = '''''' +
    			@table + ''''''''
    	PRINT @mesg
    	PRINT '' COMMIT tran''
    	PRINT '' end''
    	PRINT ''end''
    	PRINT ''''
END
CLOSE drop_tables
DEALLOCATE drop_tables
PRINT ''''
-- goto END_LABEL
SELECT @mesg = ''3. Analyzing tables...''
PRINT @mesg
PRINT ''''
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
	SELECT name FROM #objects WHERE object_type = ''table''
	GROUP BY name HAVING count(name) = 2
OPEN common_tables
WHILE( ''FETCH IS OK'' = ''FETCH IS OK'' )
BEGIN
    	FETCH NEXT FROM common_tables INTO @table
        IF @@FETCH_STATUS < 0 BREAK
    	SELECT	@db1command = ''use'' + space(1) + @db1 + space(1) + @colselectsp + space(1) + @table,
    		@db2command = ''use'' + space(1) + @db2 + space(1) + @colselectsp + space(1) + @table
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
WHILE(''FETCH IS OK'' = ''FETCH IS OK'')
BEGIN
    	FETCH NEXT FROM changed_tables INTO @table
    	IF @@fetch_status < 0 BREAK

    	SELECT @count = @count + 1,
    		@mesg = ltrim(str(@count)) + '') Table: '' + @table
    	PRINT @mesg
    	SELECT @mesg = ''Database: '' + @db1
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
    		PRINT ''''
    	END
    	SELECT @mesg = ''Database: '' + @db2
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
    		PRINT ''''
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
IN (''mod_date'', ''mod_user'')
*/
SELECT @mesg = ''4. Stored procedures present ONLY IN database: '' + @srcdb
PRINT @mesg
SELECT name FROM #objects
 WHERE object_type = ''stored procedure'' AND db_name = @srcdb and 
	name NOT IN (select name FROM #objects
			WHERE object_type = ''stored procedure'' AND db_name = @destdb)
PRINT ''''
SELECT @mesg = ''5. Stored procedures present ONLY IN database: '' + @destdb
PRINT @mesg
SELECT name FROM #objects
 WHERE object_type = ''stored procedure'' AND db_name = @destdb and 
	name NOT IN (select name FROM #objects
			WHERE object_type = ''stored procedure'' AND db_name = @destdb)
PRINT ''''
SELECT * INTO tempdb..objects FROM #objects
SELECT * INTO tempdb..columns FROM #columns
SELECT * INTO tempdb..changed_tables_cols FROM #changed_tables_cols
END_LABEL:
PRINT ''Comparison of the databases completed.''
' 
END
GO
/****** Object:  Table [dbo].[AvailFileTypes]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AvailFileTypes]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AvailFileTypes](
	[ExtCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PKI7] PRIMARY KEY CLUSTERED 
(
	[ExtCode] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [JargonWordsUpdTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[JargonWordsUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: JargonWordsUpdTrig 
 */

CREATE TRIGGER [dbo].[JargonWordsUpdTrig] ON [dbo].[JargonWords]
FOR UPDATE AS
BEGIN
    DECLARE
        @JargonCode nvarchar(50),
        @tgtWord nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: RESTRICT

    IF (UPDATE(tgtWord) OR
        UPDATE(JargonCode))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM BusinessFunctionJargon ch, deleted
          WHERE ch.JargonWords_tgtWord = deleted.tgtWord AND
           ch.JargonCode = deleted.JargonCode) != 0)
        BEGIN
            RAISERROR 30001 ''JargonWordsUpdTrigCannot update because foreign keys still exist in BusinessFunctionJargon''
            ROLLBACK TRAN
        END
    END
-- Child Update: RESTRICT

    IF (UPDATE(JargonCode))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM BusinessJargonCode pr, inserted
          WHERE pr.JargonCode = inserted.JargonCode) != @Rows)
        BEGIN
            RAISERROR 30001 ''JargonWordsUpdTrigCannot update because primary key value not found in BusinessJargonCode''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [JargonWordsDelTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[JargonWordsDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: JargonWordsDelTrig 
 */

CREATE TRIGGER [dbo].[JargonWordsDelTrig] ON [dbo].[JargonWords]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM BusinessFunctionJargon ch, deleted
         WHERE ch.JargonWords_tgtWord = deleted.tgtWord AND
           ch.JargonCode = deleted.JargonCode) != 0)
    BEGIN
        RAISERROR 30002 ''JargonWordsDelTrigCannot delete because foreign keys still exist in BusinessFunctionJargon''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  Trigger [CorpFunctionUpdTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[CorpFunctionUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: CorpFunctionUpdTrig 
 */

CREATE TRIGGER [dbo].[CorpFunctionUpdTrig] ON [dbo].[CorpFunction]
FOR UPDATE AS
BEGIN
    DECLARE
        @CorpFuncName nvarchar(80),
        @CorpName nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: RESTRICT

    IF (UPDATE(CorpFuncName) OR
        UPDATE(CorpName))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM CorpContainer ch, deleted
          WHERE ch.CorpFuncName = deleted.CorpFuncName AND
           ch.CorpName = deleted.CorpName) != 0)
        BEGIN
            RAISERROR 30001 ''CorpFunctionUpdTrigCannot update because foreign keys still exist in CorpContainer''
            ROLLBACK TRAN
        END
    END
-- Parent Update: CASCADE

    IF (UPDATE(CorpFuncName) OR
        UPDATE(CorpName))
    BEGIN
        SELECT @CorpFuncName = CorpFuncName, @CorpName = CorpName
        FROM inserted

        UPDATE FunctionProdJargon
          SET CorpFuncName = @CorpFuncName, CorpName = @CorpName
        FROM FunctionProdJargon ch, deleted
        WHERE
            ch.CorpFuncName = deleted.CorpFuncName AND
            ch.CorpName = deleted.CorpName
    END
-- Parent Update: RESTRICT

    IF (UPDATE(CorpFuncName) OR
        UPDATE(CorpName))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM BusinessFunctionJargon ch, deleted
          WHERE ch.CorpFuncName = deleted.CorpFuncName AND
           ch.CorpName = deleted.CorpName) != 0)
        BEGIN
            RAISERROR 30001 ''CorpFunctionUpdTrigCannot update because foreign keys still exist in BusinessFunctionJargon''
            ROLLBACK TRAN
        END
    END
-- Parent Update: RESTRICT

    IF (UPDATE(CorpFuncName) OR
        UPDATE(CorpName))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM FUncSkipWords ch, deleted
          WHERE ch.CorpFuncName = deleted.CorpFuncName AND
           ch.CorpName = deleted.CorpName) != 0)
        BEGIN
            RAISERROR 30001 ''CorpFunctionUpdTrigCannot update because foreign keys still exist in FUncSkipWords''
            ROLLBACK TRAN
        END
    END
-- Child Update: RESTRICT

    IF (UPDATE(CorpName))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM Corporation pr, inserted
          WHERE pr.CorpName = inserted.CorpName) != @Rows)
        BEGIN
            RAISERROR 30001 ''CorpFunctionUpdTrigCannot update because primary key value not found in Corporation''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [CorpFunctionDelTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[CorpFunctionDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: CorpFunctionDelTrig 
 */

CREATE TRIGGER [dbo].[CorpFunctionDelTrig] ON [dbo].[CorpFunction]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM CorpContainer ch, deleted
         WHERE ch.CorpFuncName = deleted.CorpFuncName AND
           ch.CorpName = deleted.CorpName) != 0)
    BEGIN
        RAISERROR 30002 ''CorpFunctionDelTrigCannot delete because foreign keys still exist in CorpContainer''
        ROLLBACK TRAN
    END
-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM FunctionProdJargon ch, deleted
         WHERE ch.CorpFuncName = deleted.CorpFuncName AND
           ch.CorpName = deleted.CorpName) != 0)
    BEGIN
        RAISERROR 30002 ''CorpFunctionDelTrigCannot delete because foreign keys still exist in FunctionProdJargon''
        ROLLBACK TRAN
    END
-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM BusinessFunctionJargon ch, deleted
         WHERE ch.CorpFuncName = deleted.CorpFuncName AND
           ch.CorpName = deleted.CorpName) != 0)
    BEGIN
        RAISERROR 30002 ''CorpFunctionDelTrigCannot delete because foreign keys still exist in BusinessFunctionJargon''
        ROLLBACK TRAN
    END
-- Parent Delete: RESTRICT

    IF ((SELECT COUNT(*)
         FROM FUncSkipWords ch, deleted
         WHERE ch.CorpFuncName = deleted.CorpFuncName AND
           ch.CorpName = deleted.CorpName) != 0)
    BEGIN
        RAISERROR 30002 ''CorpFunctionDelTrigCannot delete because foreign keys still exist in FUncSkipWords''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  StoredProcedure [dbo].[AppliedDbUpdatesUpdProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AppliedDbUpdatesUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: AppliedDbUpdatesUpdProc 
 */

CREATE PROCEDURE [dbo].[AppliedDbUpdatesUpdProc]
(
    @CompanyID     nvarchar(50),
    @FixID         nvarchar(50),
    @Status        nvarchar(50)              = NULL,
    @ReturnMsg     nvarchar(2000)            = NULL,
    @ApplyDate     datetime                  = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE AppliedDbUpdates
       SET Status         = @Status,
           ReturnMsg      = @ReturnMsg,
           ApplyDate      = @ApplyDate
     WHERE CompanyID = @CompanyID
       AND FixID     = @FixID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''AppliedDbUpdatesUpdProc: Cannot update  in AppliedDbUpdates ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[AppliedDbUpdatesSelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AppliedDbUpdatesSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[AppliedDbUpdatesInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AppliedDbUpdatesInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: AppliedDbUpdatesInsProc 
 */

CREATE PROCEDURE [dbo].[AppliedDbUpdatesInsProc]
(
    @CompanyID     nvarchar(50),
    @FixID         nvarchar(50),
    @Status        nvarchar(50)              = NULL,
    @ReturnMsg     nvarchar(2000)            = NULL,
    @ApplyDate     datetime                  = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO AppliedDbUpdates(CompanyID,
                                 FixID,
                                 Status,
                                 ReturnMsg,
                                 ApplyDate)
    VALUES(@CompanyID,
           @FixID,
           @Status,
           @ReturnMsg,
           @ApplyDate)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''AppliedDbUpdatesInsProc: Cannot insert because primary key value not found in AppliedDbUpdates ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[AppliedDbUpdatesDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AppliedDbUpdatesDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: AppliedDbUpdatesDelProc 
 */

CREATE PROCEDURE [dbo].[AppliedDbUpdatesDelProc]
(
    @CompanyID     nvarchar(50),
    @FixID         nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM AppliedDbUpdates
     WHERE CompanyID = @CompanyID
       AND FixID     = @FixID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''AppliedDbUpdatesDelProc: Cannot delete because foreign keys still exist in AppliedDbUpdates ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  Table [dbo].[ArchiveHist]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveHist]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ArchiveHist](
	[ArchiveID] [nvarchar](50) NOT NULL,
	[ArchiveDate] [datetime] NULL,
	[NbrFilesArchived] [int] NULL,
	[UserGuid] [nvarchar](50) NULL,
 CONSTRAINT [PK110] PRIMARY KEY CLUSTERED 
(
	[ArchiveID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [ArchiveHistUpdTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveHistUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: ArchiveHistUpdTrig 
 */

CREATE TRIGGER [dbo].[ArchiveHistUpdTrig] ON [dbo].[ArchiveHist]
FOR UPDATE AS
BEGIN
    DECLARE
        @ArchiveID nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: CASCADE

    IF (UPDATE(ArchiveID))
    BEGIN
        SELECT @ArchiveID = ArchiveID
        FROM inserted

        UPDATE ArchiveHistContentType
          SET ArchiveID = @ArchiveID
        FROM ArchiveHistContentType ch, deleted
        WHERE
            ch.ArchiveID = deleted.ArchiveID
    END

END'
GO
/****** Object:  Trigger [ArchiveHistDelTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveHistDelTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: ArchiveHistDelTrig 
 */

CREATE TRIGGER [dbo].[ArchiveHistDelTrig] ON [dbo].[ArchiveHist]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: CASCADE

    DELETE ArchiveHistContentType
        FROM ArchiveHistContentType ch, deleted
        WHERE ch.ArchiveID = deleted.ArchiveID

END'
GO
/****** Object:  Table [dbo].[ArchiveFrom]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveFrom]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ArchiveFrom](
	[FromEmailAddr] [nvarchar](254) NOT NULL,
	[SenderName] [varchar](254) NOT NULL,
	[UserID] [varchar](25) NOT NULL,
 CONSTRAINT [PK39] PRIMARY KEY NONCLUSTERED 
(
	[FromEmailAddr] ASC,
	[SenderName] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Trigger [EmailAttachmentUpdTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[EmailAttachmentUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: EmailAttachmentUpdTrig 
 */

CREATE TRIGGER [dbo].[EmailAttachmentUpdTrig] ON [dbo].[EmailAttachment]
FOR UPDATE AS
BEGIN
    DECLARE
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Child Update: RESTRICT

    IF (UPDATE(EmailGuid))
    BEGIN
        SELECT @NullRows = COUNT(*)
          FROM inserted
          WHERE  inserted.EmailGuid IS NULL

        SELECT @ValidRows = COUNT(*)
          FROM Email pr, inserted
          WHERE pr.EmailGuid = inserted.EmailGuid

        IF (@NullRows + @ValidRows <> @Rows)
        BEGIN
            RAISERROR 30001 ''EmailAttachmentUpdTrigCannot update because primary key value not found in Email''
            ROLLBACK TRAN
        END
    END
-- Child Update: RESTRICT

    IF (UPDATE(AttachmentCode))
    BEGIN
        SELECT @NullRows = COUNT(*)
          FROM inserted
          WHERE  inserted.AttachmentCode IS NULL

        SELECT @ValidRows = COUNT(*)
          FROM AttachmentType pr, inserted
          WHERE pr.AttachmentCode = inserted.AttachmentCode

        IF (@NullRows + @ValidRows <> @Rows)
        BEGIN
            RAISERROR 30001 ''EmailAttachmentUpdTrigCannot update because primary key value not found in AttachmentType''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [EmailAttachmentInsTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[EmailAttachmentInsTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: EmailAttachmentInsTrig 
 */

CREATE TRIGGER [dbo].[EmailAttachmentInsTrig] ON [dbo].[EmailAttachment]
FOR INSERT AS
BEGIN
    DECLARE
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Child Insert: RESTRICT

    SELECT @NullRows = COUNT(*)
        FROM inserted
        WHERE  inserted.EmailGuid IS NULL

    SELECT @ValidRows = COUNT(*)
        FROM Email pr, inserted
        WHERE pr.EmailGuid = inserted.EmailGuid

    IF (@NullRows + @ValidRows <> @Rows)
    BEGIN
        RAISERROR 30000 ''EmailAttachmentInsTrigCannot insert because primary key value not found in Email''
        ROLLBACK TRAN
    END
-- Child Insert: RESTRICT

    SELECT @NullRows = COUNT(*)
        FROM inserted
        WHERE  inserted.AttachmentCode IS NULL

    SELECT @ValidRows = COUNT(*)
        FROM AttachmentType pr, inserted
        WHERE pr.AttachmentCode = inserted.AttachmentCode

    IF (@NullRows + @ValidRows <> @Rows)
    BEGIN
        RAISERROR 30000 ''EmailAttachmentInsTrigCannot insert because primary key value not found in AttachmentType''
        ROLLBACK TRAN
    END

END'
GO
/****** Object:  StoredProcedure [dbo].[AtributeUpdProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AtributeUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: AtributeUpdProc 
 */

CREATE PROCEDURE [dbo].[AtributeUpdProc]
(
    @AttributeName         nvarchar(50),
    @AttributeDataType     nvarchar(50)              = NULL,
    @AttributeDesc         nvarchar(2000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE Atribute
       SET AttributeDataType      = @AttributeDataType,
           AttributeDesc          = @AttributeDesc
     WHERE AttributeName = @AttributeName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''AtributeUpdProc: Cannot update  in Atribute ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[AtributeSelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AtributeSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[AtributeInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AtributeInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: AtributeInsProc 
 */

CREATE PROCEDURE [dbo].[AtributeInsProc]
(
    @AttributeName         nvarchar(50),
    @AttributeDataType     nvarchar(50)              = NULL,
    @AttributeDesc         nvarchar(2000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Atribute(AttributeName,
                         AttributeDataType,
                         AttributeDesc)
    VALUES(@AttributeName,
           @AttributeDataType,
           @AttributeDesc)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''AtributeInsProc: Cannot insert because primary key value not found in Atribute ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[AtributeDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AtributeDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: AtributeDelProc 
 */

CREATE PROCEDURE [dbo].[AtributeDelProc]
(
    @AttributeName         nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Atribute
     WHERE AttributeName = @AttributeName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''AtributeDelProc: Cannot delete because foreign keys still exist in Atribute ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  Table [dbo].[ArchiveStats]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveStats]') AND type in (N'U'))
BEGIN
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
	[EntrySeq] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveStats]') AND name = N'PI01_ArchiveStats')
CREATE CLUSTERED INDEX [PI01_ArchiveStats] ON [dbo].[ArchiveStats] 
(
	[Status] ASC,
	[ArchiveType] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveStats]') AND name = N'PI02_ArchiveStats')
CREATE NONCLUSTERED INDEX [PI02_ArchiveStats] ON [dbo].[ArchiveStats] 
(
	[Status] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveStats]') AND name = N'PI03_ArchiveStats')
CREATE NONCLUSTERED INDEX [PI03_ArchiveStats] ON [dbo].[ArchiveStats] 
(
	[ArchiveStartDate] ASC,
	[ArchiveType] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveStats]') AND name = N'PI04_ArchiveStats')
CREATE NONCLUSTERED INDEX [PI04_ArchiveStats] ON [dbo].[ArchiveStats] 
(
	[ArchiveType] ASC,
	[UserID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveStats]') AND name = N'PI05_ArchiveStats')
CREATE UNIQUE NONCLUSTERED INDEX [PI05_ArchiveStats] ON [dbo].[ArchiveStats] 
(
	[EntrySeq] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveStats]') AND name = N'PK_ArchiveStats')
CREATE UNIQUE NONCLUSTERED INDEX [PK_ArchiveStats] ON [dbo].[ArchiveStats] 
(
	[StatGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ActiveSearchGuids]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActiveSearchGuids]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ActiveSearchGuids](
	[UserID] [nvarchar](50) NOT NULL,
	[DocGuid] [nvarchar](50) NOT NULL,
	[SeqNO] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ActiveSearchGuids]') AND name = N'PK_ActiveSearchGuids')
CREATE UNIQUE CLUSTERED INDEX [PK_ActiveSearchGuids] ON [dbo].[ActiveSearchGuids] 
(
	[UserID] ASC,
	[DocGuid] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ActiveSearchGuids]') AND name = N'PI01_ActiveSearchGuids')
CREATE UNIQUE NONCLUSTERED INDEX [PI01_ActiveSearchGuids] ON [dbo].[ActiveSearchGuids] 
(
	[UserID] ASC,
	[SeqNO] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AssignableUserParameters]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssignableUserParameters]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AssignableUserParameters](
	[ParmName] [nchar](50) NOT NULL,
	[isPerm] [bit] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AssignableUserParameters]') AND name = N'PK_AssignableUserParameters')
CREATE UNIQUE NONCLUSTERED INDEX [PK_AssignableUserParameters] ON [dbo].[AssignableUserParameters] 
(
	[ParmName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM ::fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'AssignableUserParameters', N'COLUMN',N'ParmName'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'This is a list of ASSIGNABLE user parameters - it takes admin authority to assign these.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AssignableUserParameters', @level2type=N'COLUMN',@level2name=N'ParmName'
GO
/****** Object:  StoredProcedure [dbo].[AttachmentTypeUpdProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttachmentTypeUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: AttachmentTypeUpdProc 
 */

CREATE PROCEDURE [dbo].[AttachmentTypeUpdProc]
(
    @AttachmentCode     nvarchar(50),
    @Description        nvarchar(254)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE AttachmentType
       SET Description         = @Description
     WHERE AttachmentCode = @AttachmentCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''AttachmentTypeUpdProc: Cannot update  in AttachmentType ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[AttachmentTypeSelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttachmentTypeSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[AttachmentTypeInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttachmentTypeInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: AttachmentTypeInsProc 
 */

CREATE PROCEDURE [dbo].[AttachmentTypeInsProc]
(
    @AttachmentCode     nvarchar(50),
    @Description        nvarchar(254)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO AttachmentType(AttachmentCode,
                               Description)
    VALUES(@AttachmentCode,
           @Description)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''AttachmentTypeInsProc: Cannot insert because primary key value not found in AttachmentType ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[AttachmentTypeDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttachmentTypeDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: AttachmentTypeDelProc 
 */

CREATE PROCEDURE [dbo].[AttachmentTypeDelProc]
(
    @AttachmentCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM AttachmentType
     WHERE AttachmentCode = @AttachmentCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''AttachmentTypeDelProc: Cannot delete because foreign keys still exist in AttachmentType ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ArchiveStatsInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveStatsInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ArchiveStatsInsProc]
(
    @ArchiveStartDate             datetime                = NULL,
    @Status                       nvarchar(50),
    @Successful                   nchar(1)                = NULL,
    @ArchiveType                  nvarchar(50),
    @TotalEmailsInRepository      int                     = NULL,
    @TotalContentInRepository     int                     = NULL,
    @UserID                       nvarchar(50),
    @ArchiveEndDate               datetime                = NULL,
    @StatGuid                     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ArchiveStats(ArchiveStartDate,
                             Status,
                             Successful,
                             ArchiveType,
                             TotalEmailsInRepository,
                             TotalContentInRepository,
                             UserID,
                             ArchiveEndDate,
                             StatGuid 
                             )
    VALUES(@ArchiveStartDate,
           @Status,
           @Successful,
           @ArchiveType,
           @TotalEmailsInRepository,
           @TotalContentInRepository,
           @UserID,
           @ArchiveEndDate,
           @StatGuid 
           )

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''ArchiveStatsInsProc: Cannot insert because primary key value not found in ArchiveStats ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ActiveLicenseInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActiveLicenseInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ActiveLicenseInsProc]
(
    @License         nvarchar(2000),
    @InstallDate     datetime)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ActiveLicense(License,
                              InstallDate 
                              )
    VALUES(@License,
           @InstallDate 
           )

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''ActiveLicenseInsProc: Cannot insert because primary key value not found in ActiveLicense ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ArchiveHistUpdProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveHistUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: ArchiveHistUpdProc 
 */

CREATE PROCEDURE [dbo].[ArchiveHistUpdProc]
(
    @ArchiveID            nvarchar(50),
    @ArchiveDate          datetime                = NULL,
    @NbrFilesArchived     int                     = NULL,
    @UserGuid             nvarchar(50)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE ArchiveHist
       SET ArchiveDate           = @ArchiveDate,
           NbrFilesArchived      = @NbrFilesArchived,
           UserGuid              = @UserGuid
     WHERE ArchiveID = @ArchiveID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''ArchiveHistUpdProc: Cannot update  in ArchiveHist ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ArchiveHistSelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveHistSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ArchiveHistInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveHistInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: ArchiveHistInsProc 
 */

CREATE PROCEDURE [dbo].[ArchiveHistInsProc]
(
    @ArchiveID            nvarchar(50),
    @ArchiveDate          datetime                = NULL,
    @NbrFilesArchived     int                     = NULL,
    @UserGuid             nvarchar(50)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ArchiveHist(ArchiveID,
                            ArchiveDate,
                            NbrFilesArchived,
                            UserGuid)
    VALUES(@ArchiveID,
           @ArchiveDate,
           @NbrFilesArchived,
           @UserGuid)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''ArchiveHistInsProc: Cannot insert because primary key value not found in ArchiveHist ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[AssignableUserParametersInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AssignableUserParametersInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[AssignableUserParametersInsProc]
(
    @ParmName     nchar(50),
    @isPerm       bit                  = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO AssignableUserParameters(ParmName,
                                         isPerm)
    VALUES(@ParmName,
           @isPerm)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''AssignableUserParametersInsProc: Cannot insert because primary key value not found in AssignableUserParameters ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ArchiveHistDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveHistDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: ArchiveHistDelProc 
 */

CREATE PROCEDURE [dbo].[ArchiveHistDelProc]
(
    @ArchiveID            nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM ArchiveHist
     WHERE ArchiveID = @ArchiveID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''ArchiveHistDelProc: Cannot delete because foreign keys still exist in ArchiveHist ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ArchiveHistContentTypeUpdProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveHistContentTypeUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: ArchiveHistContentTypeUpdProc 
 */

CREATE PROCEDURE [dbo].[ArchiveHistContentTypeUpdProc]
(
    @ArchiveID            nvarchar(50),
    @Directory            nvarchar(254),
    @FileType             nvarchar(50),
    @NbrFilesArchived     int                      = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE ArchiveHistContentType
       SET NbrFilesArchived      = @NbrFilesArchived
     WHERE ArchiveID = @ArchiveID
       AND Directory = @Directory
       AND FileType  = @FileType

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''ArchiveHistContentTypeUpdProc: Cannot update  in ArchiveHistContentType ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ArchiveHistContentTypeSelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveHistContentTypeSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ArchiveHistContentTypeInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveHistContentTypeInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: ArchiveHistContentTypeInsProc 
 */

CREATE PROCEDURE [dbo].[ArchiveHistContentTypeInsProc]
(
    @ArchiveID            nvarchar(50),
    @Directory            nvarchar(254),
    @FileType             nvarchar(50),
    @NbrFilesArchived     int                      = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ArchiveHistContentType(ArchiveID,
                                       Directory,
                                       FileType,
                                       NbrFilesArchived)
    VALUES(@ArchiveID,
           @Directory,
           @FileType,
           @NbrFilesArchived)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''ArchiveHistContentTypeInsProc: Cannot insert because primary key value not found in ArchiveHistContentType ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ArchiveHistContentTypeDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveHistContentTypeDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: ArchiveHistContentTypeDelProc 
 */

CREATE PROCEDURE [dbo].[ArchiveHistContentTypeDelProc]
(
    @ArchiveID            nvarchar(50),
    @Directory            nvarchar(254),
    @FileType             nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM ArchiveHistContentType
     WHERE ArchiveID = @ArchiveID
       AND Directory = @Directory
       AND FileType  = @FileType

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''ArchiveHistContentTypeDelProc: Cannot delete because foreign keys still exist in ArchiveHistContentType ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ActiveSearchGuidsInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ActiveSearchGuidsInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ActiveSearchGuidsInsProc]
(
    @UserID      nvarchar(50),
    @DocGuid     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ActiveSearchGuids(UserID,
                                  DocGuid 
                                  )
    VALUES(@UserID,
           @DocGuid 
           )

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''ActiveSearchGuidsInsProc: Cannot insert because primary key value not found in ActiveSearchGuids ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  Table [dbo].[AttributeDatatype]    Script Date: 07/20/2009 10:50:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeDatatype]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AttributeDatatype](
	[AttributeDataType] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK109] PRIMARY KEY CLUSTERED 
(
	[AttributeDataType] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Trigger [AttributeDatatypeUpdTrig]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[AttributeDatatypeUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: AttributeDatatypeUpdTrig 
 */

CREATE TRIGGER [dbo].[AttributeDatatypeUpdTrig] ON [dbo].[AttributeDatatype]
FOR UPDATE AS
BEGIN
    DECLARE
        @AttributeDataType nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: CASCADE

    IF (UPDATE(AttributeDataType))
    BEGIN
        SELECT @AttributeDataType = AttributeDataType
        FROM inserted

        UPDATE Attributes
          SET AttributeDataType = @AttributeDataType
        FROM Attributes ch, deleted
        WHERE
            ch.AttributeDataType = deleted.AttributeDataType
    END

END'
GO
/****** Object:  StoredProcedure [dbo].[AttributeDatatypeSelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeDatatypeSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[AttributeDatatypeInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeDatatypeInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[AttributeDatatypeInsProc]
(
    @AttributeDataType     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO AttributeDatatype(AttributeDataType)
    VALUES(@AttributeDataType)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''AttributeDatatypeInsProc: Cannot insert because primary key value not found in AttributeDatatype ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[AttributeDatatypeDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributeDatatypeDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[AttributeDatatypeDelProc]
(
    @AttributeDataType     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM AttributeDatatype
     WHERE AttributeDataType = @AttributeDataType

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''AttributeDatatypeDelProc: Cannot delete because foreign keys still exist in AttributeDatatype ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[AvailFileTypesUndefinedInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AvailFileTypesUndefinedInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[AvailFileTypesUndefinedInsProc]
(
    @FileType           nvarchar(50),
    @SubstituteType     nvarchar(50)            = NULL,
    @Applied            bit                     = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO AvailFileTypesUndefined(FileType,
                                        SubstituteType,
                                        Applied)
    VALUES(@FileType,
           @SubstituteType,
           @Applied)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''AvailFileTypesUndefinedInsProc: Cannot insert because primary key value not found in AvailFileTypesUndefined ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[BusinessJargonCodeUpdProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusinessJargonCodeUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: BusinessJargonCodeUpdProc 
 */

CREATE PROCEDURE [dbo].[BusinessJargonCodeUpdProc]
(
    @JargonCode     nvarchar(50),
    @JargonDesc     nvarchar(18)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE BusinessJargonCode
       SET JargonDesc      = @JargonDesc
     WHERE JargonCode = @JargonCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''BusinessJargonCodeUpdProc: Cannot update  in BusinessJargonCode ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[BusinessJargonCodeSelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusinessJargonCodeSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[BusinessJargonCodeInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusinessJargonCodeInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: BusinessJargonCodeInsProc 
 */

CREATE PROCEDURE [dbo].[BusinessJargonCodeInsProc]
(
    @JargonCode     nvarchar(50),
    @JargonDesc     nvarchar(18)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO BusinessJargonCode(JargonCode,
                                   JargonDesc)
    VALUES(@JargonCode,
           @JargonDesc)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''BusinessJargonCodeInsProc: Cannot insert because primary key value not found in BusinessJargonCode ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[BusinessJargonCodeDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusinessJargonCodeDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: BusinessJargonCodeDelProc 
 */

CREATE PROCEDURE [dbo].[BusinessJargonCodeDelProc]
(
    @JargonCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM BusinessJargonCode
     WHERE JargonCode = @JargonCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''BusinessJargonCodeDelProc: Cannot delete because foreign keys still exist in BusinessJargonCode ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[BusinessFunctionJargonSelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusinessFunctionJargonSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[AvailFileTypesSelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AvailFileTypesSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[AvailFileTypesSelProc]
(
    @ExtCode     nvarchar(50))
AS
BEGIN
    SELECT ExtCode
      FROM AvailFileTypes
     WHERE ExtCode = @ExtCode

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[AvailFileTypesInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AvailFileTypesInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[AvailFileTypesInsProc]
(
    @ExtCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO AvailFileTypes(ExtCode)
    VALUES(@ExtCode)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''AvailFileTypesInsProc: Cannot insert because primary key value not found in AvailFileTypes ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[AvailFileTypesDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AvailFileTypesDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[AvailFileTypesDelProc]
(
    @ExtCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM AvailFileTypes
     WHERE ExtCode = @ExtCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''AvailFileTypesDelProc: Cannot delete because foreign keys still exist in AvailFileTypes ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[BusinessFunctionJargonInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusinessFunctionJargonInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: BusinessFunctionJargonInsProc 
 */

CREATE PROCEDURE [dbo].[BusinessFunctionJargonInsProc]
(
    @CorpFuncName            nvarchar(80),
    @JargonWords_tgtWord     nvarchar(50),
    @JargonCode              nvarchar(50),
    @CorpName                nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO BusinessFunctionJargon(CorpFuncName,
                                       JargonWords_tgtWord,
                                       JargonCode,
                                       CorpName)
    VALUES(@CorpFuncName,
           @JargonWords_tgtWord,
           @JargonCode,
           @CorpName)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''BusinessFunctionJargonInsProc: Cannot insert because primary key value not found in BusinessFunctionJargon ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[BusinessFunctionJargonDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[BusinessFunctionJargonDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: BusinessFunctionJargonDelProc 
 */

CREATE PROCEDURE [dbo].[BusinessFunctionJargonDelProc]
(
    @CorpFuncName            nvarchar(80),
    @WordID                  int,
    @JargonWords_tgtWord     nvarchar(50),
    @JargonCode              nvarchar(50),
    @CorpName                nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM BusinessFunctionJargon
     WHERE CorpFuncName        = @CorpFuncName
       AND WordID              = @WordID
       AND JargonWords_tgtWord = @JargonWords_tgtWord
       AND JargonCode          = @JargonCode
       AND CorpName            = @CorpName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''BusinessFunctionJargonDelProc: Cannot delete because foreign keys still exist in BusinessFunctionJargon ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[CorpFunctionUpdProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CorpFunctionUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: CorpFunctionUpdProc 
 */

CREATE PROCEDURE [dbo].[CorpFunctionUpdProc]
(
    @CorpFuncName     nvarchar(80),
    @CorpFuncDesc     nvarchar(4000)            = NULL,
    @CreateDate       datetime                  = NULL,
    @CorpName         nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    UPDATE CorpFunction
       SET CorpFuncDesc      = @CorpFuncDesc,
           CreateDate        = @CreateDate
     WHERE CorpFuncName = @CorpFuncName
       AND CorpName     = @CorpName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''CorpFunctionUpdProc: Cannot update  in CorpFunction ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[CorpFunctionSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CorpFunctionSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[CorpFunctionInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CorpFunctionInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: CorpFunctionInsProc 
 */

CREATE PROCEDURE [dbo].[CorpFunctionInsProc]
(
    @CorpFuncName     nvarchar(80),
    @CorpFuncDesc     nvarchar(4000)            = NULL,
    @CreateDate       datetime                  = NULL,
    @CorpName         nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO CorpFunction(CorpFuncName,
                             CorpFuncDesc,
                             CreateDate,
                             CorpName)
    VALUES(@CorpFuncName,
           @CorpFuncDesc,
           @CreateDate,
           @CorpName)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''CorpFunctionInsProc: Cannot insert because primary key value not found in CorpFunction ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[CorpFunctionDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CorpFunctionDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: CorpFunctionDelProc 
 */

CREATE PROCEDURE [dbo].[CorpFunctionDelProc]
(
    @CorpFuncName     nvarchar(80),
    @CorpName         nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM CorpFunction
     WHERE CorpFuncName = @CorpFuncName
       AND CorpName     = @CorpName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''CorpFunctionDelProc: Cannot delete because foreign keys still exist in CorpFunction ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[CorpContainerUpdProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CorpContainerUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: CorpContainerUpdProc 
 */

CREATE PROCEDURE [dbo].[CorpContainerUpdProc]
(
    @ContainerType     nvarchar(25),
    @QtyDocCode        nvarchar(10),
    @CorpFuncName      nvarchar(80),
    @CorpName          nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    UPDATE CorpContainer
       SET QtyDocCode         = @QtyDocCode
     WHERE ContainerType = @ContainerType
       AND CorpFuncName  = @CorpFuncName
       AND CorpName      = @CorpName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''CorpContainerUpdProc: Cannot update  in CorpContainer ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[CorpContainerSelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CorpContainerSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[CorpContainerInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CorpContainerInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: CorpContainerInsProc 
 */

CREATE PROCEDURE [dbo].[CorpContainerInsProc]
(
    @ContainerType     nvarchar(25),
    @QtyDocCode        nvarchar(10),
    @CorpFuncName      nvarchar(80),
    @CorpName          nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO CorpContainer(ContainerType,
                              QtyDocCode,
                              CorpFuncName,
                              CorpName)
    VALUES(@ContainerType,
           @QtyDocCode,
           @CorpFuncName,
           @CorpName)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''CorpContainerInsProc: Cannot insert because primary key value not found in CorpContainer ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[CorpContainerDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CorpContainerDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: CorpContainerDelProc 
 */

CREATE PROCEDURE [dbo].[CorpContainerDelProc]
(
    @ContainerType     nvarchar(25),
    @CorpFuncName      nvarchar(80),
    @CorpName          nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM CorpContainer
     WHERE ContainerType = @ContainerType
       AND CorpFuncName  = @CorpFuncName
       AND CorpName      = @CorpName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''CorpContainerDelProc: Cannot delete because foreign keys still exist in CorpContainer ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ConvertedDocsUpdProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConvertedDocsUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: ConvertedDocsUpdProc 
 */

CREATE PROCEDURE [dbo].[ConvertedDocsUpdProc]
(
    @FQN          nvarchar(254),
    @FileName     nvarchar(254)            = NULL,
    @XMLName      nvarchar(254)            = NULL,
    @XMLDIr       nvarchar(254)            = NULL,
    @FileDir      nvarchar(254)            = NULL,
    @CorpName     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    UPDATE ConvertedDocs
       SET FileName      = @FileName,
           XMLName       = @XMLName,
           XMLDIr        = @XMLDIr,
           FileDir       = @FileDir
     WHERE FQN      = @FQN
       AND CorpName = @CorpName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''ConvertedDocsUpdProc: Cannot update  in ConvertedDocs ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ConvertedDocsSelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConvertedDocsSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[CoOwnerUpdProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CoOwnerUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CoOwnerUpdProc]
(
    @RowId                   int,
    @CurrentOwnerUserID      nvarchar(50),
    @CreateDate              datetime                = NULL,
    @PreviousOwnerUserID     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    UPDATE CoOwner
       SET CurrentOwnerUserID       = @CurrentOwnerUserID,
           CreateDate               = @CreateDate,
           PreviousOwnerUserID      = @PreviousOwnerUserID
     WHERE RowId = @RowId

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''CoOwnerUpdProc: Cannot update  in CoOwner ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[CoOwnerSelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CoOwnerSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CoOwnerSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[CoOwnerInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CoOwnerInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CoOwnerInsProc]
(
    @CurrentOwnerUserID      nvarchar(50),
    @CreateDate              datetime                = NULL,
    @PreviousOwnerUserID     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO CoOwner(CurrentOwnerUserID,
                        CreateDate,
                        PreviousOwnerUserID)
    VALUES(@CurrentOwnerUserID,
           @CreateDate,
           @PreviousOwnerUserID)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''CoOwnerInsProc: Cannot insert because primary key value not found in CoOwner ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[CoOwnerDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CoOwnerDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[CoOwnerDelProc]
(
    @RowId                   int)
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM CoOwner
     WHERE RowId = @RowId

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''CoOwnerDelProc: Cannot delete because foreign keys still exist in CoOwner ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[CaptureItemsUpdProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CaptureItemsUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: CaptureItemsUpdProc 
 */

CREATE PROCEDURE [dbo].[CaptureItemsUpdProc]
(
    @CaptureItemsCode     nvarchar(50),
    @CaptureItemsDesc     nvarchar(18)            = NULL,
    @CreateDate           datetime                = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE CaptureItems
       SET CaptureItemsDesc      = @CaptureItemsDesc,
           CreateDate            = @CreateDate
     WHERE CaptureItemsCode = @CaptureItemsCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''CaptureItemsUpdProc: Cannot update  in CaptureItems ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[CaptureItemsSelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CaptureItemsSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[CaptureItemsInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CaptureItemsInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: CaptureItemsInsProc 
 */

CREATE PROCEDURE [dbo].[CaptureItemsInsProc]
(
    @CaptureItemsCode     nvarchar(50),
    @CaptureItemsDesc     nvarchar(18)            = NULL,
    @CreateDate           datetime                = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO CaptureItems(CaptureItemsCode,
                             CaptureItemsDesc,
                             CreateDate)
    VALUES(@CaptureItemsCode,
           @CaptureItemsDesc,
           @CreateDate)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''CaptureItemsInsProc: Cannot insert because primary key value not found in CaptureItems ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ConvertedDocsInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConvertedDocsInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: ConvertedDocsInsProc 
 */

CREATE PROCEDURE [dbo].[ConvertedDocsInsProc]
(
    @FQN          nvarchar(254),
    @FileName     nvarchar(254)            = NULL,
    @XMLName      nvarchar(254)            = NULL,
    @XMLDIr       nvarchar(254)            = NULL,
    @FileDir      nvarchar(254)            = NULL,
    @CorpName     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ConvertedDocs(FQN,
                              FileName,
                              XMLName,
                              XMLDIr,
                              FileDir,
                              CorpName)
    VALUES(@FQN,
           @FileName,
           @XMLName,
           @XMLDIr,
           @FileDir,
           @CorpName)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''ConvertedDocsInsProc: Cannot insert because primary key value not found in ConvertedDocs ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ConvertedDocsDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConvertedDocsDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: ConvertedDocsDelProc 
 */

CREATE PROCEDURE [dbo].[ConvertedDocsDelProc]
(
    @FQN          nvarchar(254),
    @CorpName     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM ConvertedDocs
     WHERE FQN      = @FQN
       AND CorpName = @CorpName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''ConvertedDocsDelProc: Cannot delete because foreign keys still exist in ConvertedDocs ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ContainerStorageSelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContainerStorageSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ContainerStorageInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContainerStorageInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: ContainerStorageInsProc 
 */

CREATE PROCEDURE [dbo].[ContainerStorageInsProc]
(
    @StoreCode         nvarchar(50),
    @ContainerType     nvarchar(25))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ContainerStorage(StoreCode,
                                 ContainerType)
    VALUES(@StoreCode,
           @ContainerType)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''ContainerStorageInsProc: Cannot insert because primary key value not found in ContainerStorage ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ContainerStorageDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContainerStorageDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: ContainerStorageDelProc 
 */

CREATE PROCEDURE [dbo].[ContainerStorageDelProc]
(
    @StoreCode         nvarchar(50),
    @ContainerType     nvarchar(25))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM ContainerStorage
     WHERE StoreCode     = @StoreCode
       AND ContainerType = @ContainerType

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''ContainerStorageDelProc: Cannot delete because foreign keys still exist in ContainerStorage ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[CaptureItemsDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CaptureItemsDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: CaptureItemsDelProc 
 */

CREATE PROCEDURE [dbo].[CaptureItemsDelProc]
(
    @CaptureItemsCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM CaptureItems
     WHERE CaptureItemsCode = @CaptureItemsCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''CaptureItemsDelProc: Cannot delete because foreign keys still exist in CaptureItems ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[EmailArchParmsUpdProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailArchParmsUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EmailArchParmsUpdProc]
(
    @UserID                 nvarchar(50),
    @ArchiveEmails          char(1)                  = NULL,
    @RemoveAfterArchive     char(1)                  = NULL,
    @SetAsDefaultFolder     char(1)                  = NULL,
    @ArchiveAfterXDays      char(1)                  = NULL,
    @RemoveAfterXDays       char(1)                  = NULL,
    @RemoveXDays            int                      = NULL,
    @ArchiveXDays           int                      = NULL,
    @FolderName             nvarchar(254),
    @DB_ID                  nvarchar(50),
    @ArchiveOnlyIfRead      nchar(1)                 = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE EmailArchParms
       SET ArchiveEmails           = @ArchiveEmails,
           RemoveAfterArchive      = @RemoveAfterArchive,
           SetAsDefaultFolder      = @SetAsDefaultFolder,
           ArchiveAfterXDays       = @ArchiveAfterXDays,
           RemoveAfterXDays        = @RemoveAfterXDays,
           RemoveXDays             = @RemoveXDays,
           ArchiveXDays            = @ArchiveXDays,
           DB_ID                   = @DB_ID,
           ArchiveOnlyIfRead       = @ArchiveOnlyIfRead
     WHERE UserID     = @UserID
       AND FolderName = @FolderName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''EmailArchParmsUpdProc: Cannot update  in EmailArchParms ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[EmailArchParmsSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailArchParmsSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EmailArchParmsSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[EmailArchParmsInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailArchParmsInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EmailArchParmsInsProc]
(
    @UserID                 nvarchar(50),
    @ArchiveEmails          char(1)                  = NULL,
    @RemoveAfterArchive     char(1)                  = NULL,
    @SetAsDefaultFolder     char(1)                  = NULL,
    @ArchiveAfterXDays      char(1)                  = NULL,
    @RemoveAfterXDays       char(1)                  = NULL,
    @RemoveXDays            int                      = NULL,
    @ArchiveXDays           int                      = NULL,
    @FolderName             nvarchar(254),
    @DB_ID                  nvarchar(50),
    @ArchiveOnlyIfRead      nchar(1)                 = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO EmailArchParms(UserID,
                               ArchiveEmails,
                               RemoveAfterArchive,
                               SetAsDefaultFolder,
                               ArchiveAfterXDays,
                               RemoveAfterXDays,
                               RemoveXDays,
                               ArchiveXDays,
                               FolderName,
                               DB_ID,
                               ArchiveOnlyIfRead)
    VALUES(@UserID,
           @ArchiveEmails,
           @RemoveAfterArchive,
           @SetAsDefaultFolder,
           @ArchiveAfterXDays,
           @RemoveAfterXDays,
           @RemoveXDays,
           @ArchiveXDays,
           @FolderName,
           @DB_ID,
           @ArchiveOnlyIfRead)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''EmailArchParmsInsProc: Cannot insert because primary key value not found in EmailArchParms ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[EmailArchParmsDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailArchParmsDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EmailArchParmsDelProc]
(
    @UserID                 nvarchar(50),
    @FolderName             nvarchar(254))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM EmailArchParms
     WHERE UserID     = @UserID
       AND FolderName = @FolderName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''EmailArchParmsDelProc: Cannot delete because foreign keys still exist in EmailArchParms ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[EcmUserUpdProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EcmUserUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: EcmUserUpdProc 
 */

CREATE PROCEDURE [dbo].[EcmUserUpdProc]
(
    @EMail           nvarchar(50),
    @PhoneNumber     nvarchar(20)             = NULL,
    @YourName        nvarchar(100)            = NULL,
    @YourCompany     nvarchar(50)             = NULL,
    @PassWord        nvarchar(50)             = NULL,
    @Authority       nchar(1)                 = NULL,
    @CreateDate      datetime                 = NULL,
    @CompanyID       nvarchar(50)             = NULL,
    @LastUpdate      datetime                 = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE EcmUser
       SET PhoneNumber      = @PhoneNumber,
           YourName         = @YourName,
           YourCompany      = @YourCompany,
           PassWord         = @PassWord,
           Authority        = @Authority,
           CreateDate       = @CreateDate,
           CompanyID        = @CompanyID,
           LastUpdate       = @LastUpdate
     WHERE EMail = @EMail

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''EcmUserUpdProc: Cannot update  in EcmUser ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[EcmUserSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EcmUserSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[EcmUserInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EcmUserInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: EcmUserInsProc 
 */

CREATE PROCEDURE [dbo].[EcmUserInsProc]
(
    @EMail           nvarchar(50),
    @PhoneNumber     nvarchar(20)             = NULL,
    @YourName        nvarchar(100)            = NULL,
    @YourCompany     nvarchar(50)             = NULL,
    @PassWord        nvarchar(50)             = NULL,
    @Authority       nchar(1)                 = NULL,
    @CreateDate      datetime                 = NULL,
    @CompanyID       nvarchar(50)             = NULL,
    @LastUpdate      datetime                 = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO EcmUser(EMail,
                        PhoneNumber,
                        YourName,
                        YourCompany,
                        PassWord,
                        Authority,
                        CreateDate,
                        CompanyID,
                        LastUpdate)
    VALUES(@EMail,
           @PhoneNumber,
           @YourName,
           @YourCompany,
           @PassWord,
           @Authority,
           @CreateDate,
           @CompanyID,
           @LastUpdate)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''EcmUserInsProc: Cannot insert because primary key value not found in EcmUser ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[EcmUserDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EcmUserDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: EcmUserDelProc 
 */

CREATE PROCEDURE [dbo].[EcmUserDelProc]
(
    @EMail           nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM EcmUser
     WHERE EMail = @EMail

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''EcmUserDelProc: Cannot delete because foreign keys still exist in EcmUser ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[DirectoryUpdProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DirectoryUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DirectoryUpdProc]
(
    @UserID             nvarchar(50),
    @IncludeSubDirs     char(1)                 = NULL,
    @FQN                varchar(254),
    @DB_ID              nvarchar(50),
    @VersionFiles       char(1)                 = NULL,
    @ckMetaData         nchar(1)                = NULL,
    @ckPublic           nchar(1)                = NULL,
    @ckDisableDir       nchar(1)                = NULL,
    @QuickRefEntry      char(10)                = NULL,
    @isSysDefault       bit                     = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE Directory
       SET IncludeSubDirs      = @IncludeSubDirs,
           DB_ID               = @DB_ID,
           VersionFiles        = @VersionFiles,
           ckMetaData          = @ckMetaData,
           ckPublic            = @ckPublic,
           ckDisableDir        = @ckDisableDir,
           QuickRefEntry       = @QuickRefEntry,
           isSysDefault        = @isSysDefault
     WHERE UserID = @UserID
       AND FQN    = @FQN

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''DirectoryUpdProc: Cannot update  in Directory ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DirectorySelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DirectorySelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DirectorySelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DirectoryInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DirectoryInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DirectoryInsProc]
(
    @UserID             nvarchar(50),
    @IncludeSubDirs     char(1)                 = NULL,
    @FQN                varchar(254),
    @DB_ID              nvarchar(50),
    @VersionFiles       char(1)                 = NULL,
    @ckMetaData         nchar(1)                = NULL,
    @ckPublic           nchar(1)                = NULL,
    @ckDisableDir       nchar(1)                = NULL,
    @QuickRefEntry      char(10)                = NULL,
    @isSysDefault       bit                     = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Directory(UserID,
                          IncludeSubDirs,
                          FQN,
                          DB_ID,
                          VersionFiles,
                          ckMetaData,
                          ckPublic,
                          ckDisableDir,
                          QuickRefEntry,
                          isSysDefault)
    VALUES(@UserID,
           @IncludeSubDirs,
           @FQN,
           @DB_ID,
           @VersionFiles,
           @ckMetaData,
           @ckPublic,
           @ckDisableDir,
           @QuickRefEntry,
           @isSysDefault)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''DirectoryInsProc: Cannot insert because primary key value not found in Directory ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DirectoryDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DirectoryDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DirectoryDelProc]
(
    @UserID             nvarchar(50),
    @FQN                varchar(254))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Directory
     WHERE UserID = @UserID
       AND FQN    = @FQN

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''DirectoryDelProc: Cannot delete because foreign keys still exist in Directory ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteFromSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteFromSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DeleteFromSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DeleteFromDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteFromDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DeleteFromDelProc]
(
    @FromEmailAddr     nvarchar(254),
    @SenderName        varchar(254),
    @UserID            varchar(25))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM DeleteFrom
     WHERE FromEmailAddr = @FromEmailAddr
       AND SenderName    = @SenderName
       AND UserID        = @UserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''DeleteFromDelProc: Cannot delete because foreign keys still exist in DeleteFrom ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataTypeCodesInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataTypeCodesInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DataTypeCodesInsProc]
(
    @FileType       nvarchar(255)            = NULL,
    @VerNbr         nvarchar(255)            = NULL,
    @Publisher      nvarchar(255)            = NULL,
    @Definition     nvarchar(255)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO DataTypeCodes(FileType,
                              VerNbr,
                              Publisher,
                              Definition)
    VALUES(@FileType,
           @VerNbr,
           @Publisher,
           @Definition)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''DataTypeCodesInsProc: Cannot insert because primary key value not found in DataTypeCodes ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DB_UpdatesUpdProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DB_UpdatesUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: DB_UpdatesUpdProc 
 */

CREATE PROCEDURE [dbo].[DB_UpdatesUpdProc]
(
    @SqlStmt            nvarchar(max),
    @CreateDate         datetime,
    @FixID              nvarchar(50),
    @FixDescription     nvarchar(4000)            = NULL,
    @DBName             nvarchar(50)              = NULL,
    @CompanyID          nvarchar(50)              = NULL,
    @MachineName        nvarchar(50)              = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE DB_Updates
       SET SqlStmt             = @SqlStmt,
           CreateDate          = @CreateDate,
           FixDescription      = @FixDescription,
           DBName              = @DBName,
           CompanyID           = @CompanyID,
           MachineName         = @MachineName
     WHERE FixID = @FixID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''DB_UpdatesUpdProc: Cannot update  in DB_Updates ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[DB_UpdatesSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DB_UpdatesSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[DB_UpdatesInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DB_UpdatesInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: DB_UpdatesInsProc 
 */

CREATE PROCEDURE [dbo].[DB_UpdatesInsProc]
(
    @SqlStmt            nvarchar(max),
    @CreateDate         datetime,
    @FixID              nvarchar(50),
    @FixDescription     nvarchar(4000)            = NULL,
    @DBName             nvarchar(50)              = NULL,
    @CompanyID          nvarchar(50)              = NULL,
    @MachineName        nvarchar(50)              = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO DB_Updates(SqlStmt,
                           CreateDate,
                           FixID,
                           FixDescription,
                           DBName,
                           CompanyID,
                           MachineName)
    VALUES(@SqlStmt,
           @CreateDate,
           @FixID,
           @FixDescription,
           @DBName,
           @CompanyID,
           @MachineName)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''DB_UpdatesInsProc: Cannot insert because primary key value not found in DB_Updates ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[DB_UpdatesDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DB_UpdatesDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'

/* 
 * PROCEDURE: DB_UpdatesDelProc 
 */

CREATE PROCEDURE [dbo].[DB_UpdatesDelProc]
(
    @FixID              nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM DB_Updates
     WHERE FixID = @FixID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''DB_UpdatesDelProc: Cannot delete because foreign keys still exist in DB_Updates ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END
' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataSourceUpdProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataSourceUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: DataSourceUpdProc 
 */

CREATE PROCEDURE [dbo].[DataSourceUpdProc]
(
    @SourceGuid         nvarchar(50),
    @CreateDate         datetime                 = NULL,
    @SourceName         nvarchar(254)            = NULL,
    @SourceImage        image                    = NULL,
    @SourceTypeCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    UPDATE DataSource
       SET CreateDate          = @CreateDate,
           SourceName          = @SourceName,
           SourceImage         = @SourceImage,
           SourceTypeCode      = @SourceTypeCode
     WHERE SourceGuid = @SourceGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''DataSourceUpdProc: Cannot update  in DataSource ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataSourceSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataSourceSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataSourceRestoreHistoryUpdProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataSourceRestoreHistoryUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DataSourceRestoreHistoryUpdProc]
(
    @SourceGuid                nvarchar(50),
    @RestoredToMachine         nvarchar(50)             = NULL,
    @RestoreUserName           nvarchar(50)             = NULL,
    @RestoreUserID             nvarchar(50)             = NULL,
    @RestoreUserDomain         nvarchar(254)            = NULL,
    @RestoreDate               datetime                 = NULL,
    @DataSourceOwnerUserID     nvarchar(50),
    @SeqNo                     int,
    @TypeContentCode           nvarchar(50)             = NULL,
    @CreateDate                datetime                 = NULL,
    @DocumentName              nvarchar(254)            = NULL,
    @FQN                       nvarchar(500)            = NULL,
    @VerifiedData              nchar(1)                 = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE DataSourceRestoreHistory
       SET SourceGuid                 = @SourceGuid,
           RestoredToMachine          = @RestoredToMachine,
           RestoreUserName            = @RestoreUserName,
           RestoreUserID              = @RestoreUserID,
           RestoreUserDomain          = @RestoreUserDomain,
           RestoreDate                = @RestoreDate,
           DataSourceOwnerUserID      = @DataSourceOwnerUserID,
           TypeContentCode            = @TypeContentCode,
           CreateDate                 = @CreateDate,
           DocumentName               = @DocumentName,
           FQN                        = @FQN,
           VerifiedData               = @VerifiedData
     WHERE SeqNo = @SeqNo

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''DataSourceRestoreHistoryUpdProc: Cannot update  in DataSourceRestoreHistory ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataSourceRestoreHistorySelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataSourceRestoreHistorySelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DataSourceRestoreHistorySelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataSourceRestoreHistoryInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataSourceRestoreHistoryInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DataSourceRestoreHistoryInsProc]
(
    @SourceGuid                nvarchar(50),
    @RestoredToMachine         nvarchar(50)             = NULL,
    @RestoreUserName           nvarchar(50)             = NULL,
    @RestoreUserID             nvarchar(50)             = NULL,
    @RestoreUserDomain         nvarchar(254)            = NULL,
    @RestoreDate               datetime                 = NULL,
    @DataSourceOwnerUserID     nvarchar(50),
    @TypeContentCode           nvarchar(50)             = NULL,
    @CreateDate                datetime                 = NULL,
    @DocumentName              nvarchar(254)            = NULL,
    @FQN                       nvarchar(500)            = NULL,
    @VerifiedData              nchar(1)                 = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO DataSourceRestoreHistory(SourceGuid,
                                         RestoredToMachine,
                                         RestoreUserName,
                                         RestoreUserID,
                                         RestoreUserDomain,
                                         RestoreDate,
                                         DataSourceOwnerUserID,
                                         TypeContentCode,
                                         CreateDate,
                                         DocumentName,
                                         FQN,
                                         VerifiedData)
    VALUES(@SourceGuid,
           @RestoredToMachine,
           @RestoreUserName,
           @RestoreUserID,
           @RestoreUserDomain,
           @RestoreDate,
           @DataSourceOwnerUserID,
           @TypeContentCode,
           @CreateDate,
           @DocumentName,
           @FQN,
           @VerifiedData)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''DataSourceRestoreHistoryInsProc: Cannot insert because primary key value not found in DataSourceRestoreHistory ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataSourceRestoreHistoryDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataSourceRestoreHistoryDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DataSourceRestoreHistoryDelProc]
(
    @SeqNo                     int)
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM DataSourceRestoreHistory
     WHERE SeqNo = @SeqNo

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''DataSourceRestoreHistoryDelProc: Cannot delete because foreign keys still exist in DataSourceRestoreHistory ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataSourceInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataSourceInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: DataSourceInsProc 
 */

CREATE PROCEDURE [dbo].[DataSourceInsProc]
(
    @SourceGuid         nvarchar(50),
    @CreateDate         datetime                 = NULL,
    @SourceName         nvarchar(254)            = NULL,
    @SourceImage        image                    = NULL,
    @SourceTypeCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO DataSource(SourceGuid,
                           CreateDate,
                           SourceName,
                           SourceImage,
                           SourceTypeCode)
    VALUES(@SourceGuid,
           @CreateDate,
           @SourceName,
           @SourceImage,
           @SourceTypeCode)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''DataSourceInsProc: Cannot insert because primary key value not found in DataSource ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DatabasesDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DatabasesDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DatabasesDelProc]
(
    @DB_ID           nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Databases
     WHERE DB_ID = @DB_ID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''DatabasesDelProc: Cannot delete because foreign keys still exist in Databases ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataSourceDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataSourceDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: DataSourceDelProc 
 */

CREATE PROCEDURE [dbo].[DataSourceDelProc]
(
    @SourceGuid         nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM DataSource
     WHERE SourceGuid = @SourceGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''DataSourceDelProc: Cannot delete because foreign keys still exist in DataSource ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataSourceCheckOutUpdProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataSourceCheckOutUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DataSourceCheckOutUpdProc]
(
    @SourceGuid                nvarchar(50),
    @DataSourceOwnerUserID     nvarchar(50),
    @CheckedOutByUserID        nvarchar(50),
    @isReadOnly                bit                     = NULL,
    @isForUpdate               bit                     = NULL,
    @checkOutDate              datetime                = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE DataSourceCheckOut
       SET isReadOnly                 = @isReadOnly,
           isForUpdate                = @isForUpdate,
           checkOutDate               = @checkOutDate
     WHERE SourceGuid            = @SourceGuid
       AND DataSourceOwnerUserID = @DataSourceOwnerUserID
       AND CheckedOutByUserID    = @CheckedOutByUserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''DataSourceCheckOutUpdProc: Cannot update  in DataSourceCheckOut ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataSourceCheckOutSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataSourceCheckOutSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DataSourceCheckOutSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataSourceCheckOutInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataSourceCheckOutInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DataSourceCheckOutInsProc]
(
    @SourceGuid                nvarchar(50),
    @DataSourceOwnerUserID     nvarchar(50),
    @CheckedOutByUserID        nvarchar(50),
    @isReadOnly                bit                     = NULL,
    @isForUpdate               bit                     = NULL,
    @checkOutDate              datetime                = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO DataSourceCheckOut(SourceGuid,
                                   DataSourceOwnerUserID,
                                   CheckedOutByUserID,
                                   isReadOnly,
                                   isForUpdate,
                                   checkOutDate)
    VALUES(@SourceGuid,
           @DataSourceOwnerUserID,
           @CheckedOutByUserID,
           @isReadOnly,
           @isForUpdate,
           @checkOutDate)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''DataSourceCheckOutInsProc: Cannot insert because primary key value not found in DataSourceCheckOut ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataSourceCheckOutDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataSourceCheckOutDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DataSourceCheckOutDelProc]
(
    @SourceGuid                nvarchar(50),
    @DataSourceOwnerUserID     nvarchar(50),
    @CheckedOutByUserID        nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM DataSourceCheckOut
     WHERE SourceGuid            = @SourceGuid
       AND DataSourceOwnerUserID = @DataSourceOwnerUserID
       AND CheckedOutByUserID    = @CheckedOutByUserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''DataSourceCheckOutDelProc: Cannot delete because foreign keys still exist in DataSourceCheckOut ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataSource_04012008185318007]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataSource_04012008185318007]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: DataSourceUpdProc 
 */

CREATE PROCEDURE [dbo].[DataSource_04012008185318007]
(
    @SourceGuid         nvarchar(50),
    @CreateDate         datetime                 = NULL,
    @SourceName         nvarchar(254)            = NULL,
    @SourceImage        image                    = NULL,
    @SourceTypeCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    UPDATE DataSource
       SET CreateDate          = @CreateDate,
           SourceName          = @SourceName,
           SourceImage         = @SourceImage,
           SourceTypeCode      = @SourceTypeCode
     WHERE SourceGuid = @SourceGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''DataSourceUpdProc: Cannot update  in DataSource ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataSource_04012008185318006]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataSource_04012008185318006]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: DataSourceSelProc 
 */

CREATE PROCEDURE [dbo].[DataSource_04012008185318006]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataSource_04012008185318005]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataSource_04012008185318005]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: DataSourceInsProc 
 */

CREATE PROCEDURE [dbo].[DataSource_04012008185318005]
(
    @SourceGuid         nvarchar(50),
    @CreateDate         datetime                 = NULL,
    @SourceName         nvarchar(254)            = NULL,
    @SourceImage        image                    = NULL,
    @SourceTypeCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO DataSource(SourceGuid,
                           CreateDate,
                           SourceName,
                           SourceImage,
                           SourceTypeCode)
    VALUES(@SourceGuid,
           @CreateDate,
           @SourceName,
           @SourceImage,
           @SourceTypeCode)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''DataSourceInsProc: Cannot insert because primary key value not found in DataSource ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataSource_04012008185318004]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataSource_04012008185318004]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: DataSourceDelProc 
 */

CREATE PROCEDURE [dbo].[DataSource_04012008185318004]
(
    @SourceGuid         nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM DataSource
     WHERE SourceGuid = @SourceGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''DataSourceDelProc: Cannot delete because foreign keys still exist in DataSource ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataOwnersUpdProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataOwnersUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DataOwnersUpdProc]
(
    @PrimaryOwner              bit                     = NULL,
    @OwnerTypeCode             nvarchar(50)            = NULL,
    @FullAccess                bit                     = NULL,
    @ReadOnly                  bit                     = NULL,
    @DeleteAccess              bit                     = NULL,
    @Searchable                bit                     = NULL,
    @SourceGuid                nvarchar(50),
    @UserID                    nvarchar(50),
    @GroupOwnerUserID          nvarchar(50),
    @GroupName                 nvarchar(80),
    @DataSourceOwnerUserID     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    UPDATE DataOwners
       SET PrimaryOwner               = @PrimaryOwner,
           OwnerTypeCode              = @OwnerTypeCode,
           FullAccess                 = @FullAccess,
           ReadOnly                   = @ReadOnly,
           DeleteAccess               = @DeleteAccess,
           Searchable                 = @Searchable
     WHERE SourceGuid            = @SourceGuid
       AND UserID                = @UserID
       AND GroupOwnerUserID      = @GroupOwnerUserID
       AND GroupName             = @GroupName
       AND DataSourceOwnerUserID = @DataSourceOwnerUserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''DataOwnersUpdProc: Cannot update  in DataOwners ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataOwnersSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataOwnersSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DataOwnersSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataOwnersInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataOwnersInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DataOwnersInsProc]
(
    @PrimaryOwner              bit                     = NULL,
    @OwnerTypeCode             nvarchar(50)            = NULL,
    @FullAccess                bit                     = NULL,
    @ReadOnly                  bit                     = NULL,
    @DeleteAccess              bit                     = NULL,
    @Searchable                bit                     = NULL,
    @SourceGuid                nvarchar(50),
    @UserID                    nvarchar(50),
    @GroupOwnerUserID          nvarchar(50),
    @GroupName                 nvarchar(80),
    @DataSourceOwnerUserID     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO DataOwners(PrimaryOwner,
                           OwnerTypeCode,
                           FullAccess,
                           ReadOnly,
                           DeleteAccess,
                           Searchable,
                           SourceGuid,
                           UserID,
                           GroupOwnerUserID,
                           GroupName,
                           DataSourceOwnerUserID)
    VALUES(@PrimaryOwner,
           @OwnerTypeCode,
           @FullAccess,
           @ReadOnly,
           @DeleteAccess,
           @Searchable,
           @SourceGuid,
           @UserID,
           @GroupOwnerUserID,
           @GroupName,
           @DataSourceOwnerUserID)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''DataOwnersInsProc: Cannot insert because primary key value not found in DataOwners ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DataOwnersDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DataOwnersDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DataOwnersDelProc]
(
    @SourceGuid                nvarchar(50),
    @UserID                    nvarchar(50),
    @GroupOwnerUserID          nvarchar(50),
    @GroupName                 nvarchar(80),
    @DataSourceOwnerUserID     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM DataOwners
     WHERE SourceGuid            = @SourceGuid
       AND UserID                = @UserID
       AND GroupOwnerUserID      = @GroupOwnerUserID
       AND GroupName             = @GroupName
       AND DataSourceOwnerUserID = @DataSourceOwnerUserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''DataOwnersDelProc: Cannot delete because foreign keys still exist in DataOwners ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DatabasesUpdProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DatabasesUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DatabasesUpdProc]
(
    @DB_ID           nvarchar(50),
    @DB_CONN_STR     nvarchar(254)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE Databases
       SET DB_CONN_STR      = @DB_CONN_STR
     WHERE DB_ID = @DB_ID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''DatabasesUpdProc: Cannot update  in Databases ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DatabasesSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DatabasesSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DatabasesSelProc]
(
    @DB_ID           nvarchar(50))
AS
BEGIN
    SELECT DB_ID,
           DB_CONN_STR
      FROM Databases
     WHERE DB_ID = @DB_ID

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[DatabasesInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DatabasesInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[DatabasesInsProc]
(
    @DB_ID           nvarchar(50),
    @DB_CONN_STR     nvarchar(254)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Databases(DB_ID,
                          DB_CONN_STR)
    VALUES(@DB_ID,
           @DB_CONN_STR)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''DatabasesInsProc: Cannot insert because primary key value not found in Databases ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  View [dbo].[CoutOfEmails]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[CoutOfEmails]'))
EXEC dbo.sp_executesql @statement = N'Create View [dbo].[CoutOfEmails]
as
select COUNT(*) + 2500000 as Rows from email '
GO
/****** Object:  View [dbo].[CountOfContent]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[CountOfContent]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[CountOfContent]
as
select COUNT(*) + 1000000 as Rows from DataSource'
GO
/****** Object:  StoredProcedure [dbo].[EmailFolderInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailFolderInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EmailFolderInsProc]
(
    @UserID                 nvarchar(80),
    @FolderName             nvarchar(254)            = NULL,
    @ParentFolderName       nvarchar(254)            = NULL,
    @FolderID               nvarchar(100),
    @ParentFolderID         nvarchar(100)            = NULL,
    @SelectedForArchive     char(1)                  = NULL,
    @StoreID                nvarchar(500)            = NULL,
    @isSysDefault           bit                      = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO EmailFolder(UserID,
                            FolderName,
                            ParentFolderName,
                            FolderID,
                            ParentFolderID,
                            SelectedForArchive,
                            StoreID,
                            isSysDefault)
    VALUES(@UserID,
           @FolderName,
           @ParentFolderName,
           @FolderID,
           @ParentFolderID,
           @SelectedForArchive,
           @StoreID,
           @isSysDefault)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''EmailFolderInsProc: Cannot insert because primary key value not found in EmailFolder ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[EmailAttachmentSearchListInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailAttachmentSearchListInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EmailAttachmentSearchListInsProc]
(
    @UserID        nvarchar(50),
    @EmailGuid     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO EmailAttachmentSearchList(UserID,
                                          EmailGuid)
    VALUES(@UserID,
           @EmailGuid)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''EmailAttachmentSearchListInsProc: Cannot insert because primary key value not found in EmailAttachmentSearchList ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[EmailAttachmentInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailAttachmentInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: EmailAttachmentInsProc 
 */

CREATE PROCEDURE [dbo].[EmailAttachmentInsProc]
(
    @Attachment         image                    = NULL,
    @AttachmentName     nvarchar(254)            = NULL,
    @EmailGuid          nvarchar(50)             = NULL,
    @AttachmentCode     nvarchar(50)             = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO EmailAttachment(Attachment,
                                AttachmentName,
                                EmailGuid,
                                AttachmentCode)
    VALUES(@Attachment,
           @AttachmentName,
           @EmailGuid,
           @AttachmentCode)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''EmailAttachmentInsProc: Cannot insert because primary key value not found in EmailAttachment ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ExcludedFilesSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExcludedFilesSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ExcludedFilesSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ExcludedFilesInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExcludedFilesInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ExcludedFilesInsProc]
(
    @UserID      nvarchar(50),
    @ExtCode     nvarchar(50),
    @FQN         varchar(254))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ExcludedFiles(UserID,
                              ExtCode,
                              FQN)
    VALUES(@UserID,
           @ExtCode,
           @FQN)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''ExcludedFilesInsProc: Cannot insert because primary key value not found in ExcludedFiles ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ExcludedFilesDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExcludedFilesDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ExcludedFilesDelProc]
(
    @UserID      nvarchar(50),
    @ExtCode     nvarchar(50),
    @FQN         varchar(254))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM ExcludedFiles
     WHERE UserID  = @UserID
       AND ExtCode = @ExtCode
       AND FQN     = @FQN

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''ExcludedFilesDelProc: Cannot delete because foreign keys still exist in ExcludedFiles ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[EmailSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EmailSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[EmailInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EmailInsProc]
(
    @EmailGuid                   nvarchar(50),
    @SUBJECT                     nvarchar(2000)            = NULL,
    @SentTO                      nvarchar(2000)            = NULL,
    @Body                        text                      = NULL,
    @Bcc                         nvarchar(max)             = NULL,
    @BillingInformation          nvarchar(200)             = NULL,
    @CC                          nvarchar(max)             = NULL,
    @Companies                   nvarchar(2000)            = NULL,
    @CreationTime                datetime                  = NULL,
    @ReadReceiptRequested        nvarchar(50)              = NULL,
    @ReceivedByName              nvarchar(80),
    @ReceivedTime                datetime,
    @AllRecipients               nvarchar(max)             = NULL,
    @UserID                      nvarchar(80),
    @SenderEmailAddress          nvarchar(80),
    @SenderName                  nvarchar(100),
    @Sensitivity                 nvarchar(50)              = NULL,
    @SentOn                      datetime,
    @MsgSize                     int                       = NULL,
    @DeferredDeliveryTime        datetime                  = NULL,
    @EntryID                     varchar(150)              = NULL,
    @ExpiryTime                  datetime                  = NULL,
    @LastModificationTime        datetime                  = NULL,
    @EmailImage                  image                     = NULL,
    @Accounts                    nvarchar(2000)            = NULL,
    @ShortSubj                   nvarchar(250)             = NULL,
    @SourceTypeCode              nvarchar(50)              = NULL,
    @OriginalFolder              nvarchar(254)             = NULL,
    @StoreID                     varchar(750)              = NULL,
    @isPublic                    nchar(1)                  = NULL,
    @RetentionExpirationDate     datetime                  = NULL,
    @IsPublicPreviousState       nchar(1)                  = NULL,
    @isAvailable                 nchar(1)                  = NULL,
    @CurrMailFolderID            nvarchar(300)             = NULL,
    @isPerm                      nchar(1)                  = NULL,
    @isMaster                    nchar(1)                  = NULL,
    @CreationDate                datetime                  = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Email(EmailGuid,
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
                      CreationDate)
    VALUES(@EmailGuid,
           @SUBJECT,
           @SentTO,
           @Body,
           @Bcc,
           @BillingInformation,
           @CC,
           @Companies,
           @CreationTime,
           @ReadReceiptRequested,
           @ReceivedByName,
           @ReceivedTime,
           @AllRecipients,
           @UserID,
           @SenderEmailAddress,
           @SenderName,
           @Sensitivity,
           @SentOn,
           @MsgSize,
           @DeferredDeliveryTime,
           @EntryID,
           @ExpiryTime,
           @LastModificationTime,
           @EmailImage,
           @Accounts,
           @ShortSubj,
           @SourceTypeCode,
           @OriginalFolder,
           @StoreID,
           @isPublic,
           @RetentionExpirationDate,
           @IsPublicPreviousState,
           @isAvailable,
           @CurrMailFolderID,
           @isPerm,
           @isMaster,
           @CreationDate)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''EmailInsProc: Cannot insert because primary key value not found in Email ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[EmailDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: EmailDelProc 
 */

CREATE PROCEDURE [dbo].[EmailDelProc]
(
    @EmailGuid                nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Email
     WHERE EmailGuid = @EmailGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''EmailDelProc: Cannot delete because foreign keys still exist in Email ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[GlobalSeachResultsInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GlobalSeachResultsInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GlobalSeachResultsInsProc]
(
    @ContentTitle         nvarchar(254)            = NULL,
    @ContentAuthor        nvarchar(254)            = NULL,
    @ContentType          nvarchar(50)             = NULL,
    @CreateDate           nvarchar(50)             = NULL,
    @ContentExt           nvarchar(50)             = NULL,
    @ContentGuid          nvarchar(50),
    @UserID               nvarchar(50),
    @FileName             nvarchar(254)            = NULL,
    @FileSize             int                      = NULL,
    @NbrOfAttachments     int                      = NULL,
    @FromEmailAddress     nvarchar(254)            = NULL,
    @AllRecipiants        nvarchar(max)            = NULL,
    @Weight               int                      = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO GlobalSeachResults(ContentTitle,
                                   ContentAuthor,
                                   ContentType,
                                   CreateDate,
                                   ContentExt,
                                   ContentGuid,
                                   UserID,
                                   FileName,
                                   FileSize,
                                   NbrOfAttachments,
                                   FromEmailAddress,
                                   AllRecipiants,
                                   Weight)
    VALUES(@ContentTitle,
           @ContentAuthor,
           @ContentType,
           @CreateDate,
           @ContentExt,
           @ContentGuid,
           @UserID,
           @FileName,
           @FileSize,
           @NbrOfAttachments,
           @FromEmailAddress,
           @AllRecipiants,
           @Weight)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''GlobalSeachResultsInsProc: Cannot insert because primary key value not found in GlobalSeachResults ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[FunctionProdJargonInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FunctionProdJargonInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: FunctionProdJargonInsProc 
 */

CREATE PROCEDURE [dbo].[FunctionProdJargonInsProc]
(
    @KeyFlag            binary(50)              = NULL,
    @RepeatDataCode     nvarchar(50),
    @CorpFuncName       nvarchar(80),
    @JargonCode         nvarchar(50),
    @CorpName           nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO FunctionProdJargon(KeyFlag,
                                   RepeatDataCode,
                                   CorpFuncName,
                                   JargonCode,
                                   CorpName)
    VALUES(@KeyFlag,
           @RepeatDataCode,
           @CorpFuncName,
           @JargonCode,
           @CorpName)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''FunctionProdJargonInsProc: Cannot insert because primary key value not found in FunctionProdJargon ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[FunctionProdJargonDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FunctionProdJargonDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: FunctionProdJargonDelProc 
 */

CREATE PROCEDURE [dbo].[FunctionProdJargonDelProc]
(
    @CorpFuncName       nvarchar(80),
    @JargonCode         nvarchar(50),
    @CorpName           nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM FunctionProdJargon
     WHERE CorpFuncName = @CorpFuncName
       AND JargonCode   = @JargonCode
       AND CorpName     = @CorpName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''FunctionProdJargonDelProc: Cannot delete because foreign keys still exist in FunctionProdJargon ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[FUncSkipWordsSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FUncSkipWordsSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[FUncSkipWordsInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FUncSkipWordsInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: FUncSkipWordsInsProc 
 */

CREATE PROCEDURE [dbo].[FUncSkipWordsInsProc]
(
    @CorpFuncName     nvarchar(80),
    @tgtWord          nvarchar(18),
    @CorpName         nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO FUncSkipWords(CorpFuncName,
                              tgtWord,
                              CorpName)
    VALUES(@CorpFuncName,
           @tgtWord,
           @CorpName)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''FUncSkipWordsInsProc: Cannot insert because primary key value not found in FUncSkipWords ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[FUncSkipWordsDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FUncSkipWordsDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: FUncSkipWordsDelProc 
 */

CREATE PROCEDURE [dbo].[FUncSkipWordsDelProc]
(
    @CorpFuncName     nvarchar(80),
    @tgtWord          nvarchar(18),
    @CorpName         nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM FUncSkipWords
     WHERE CorpFuncName = @CorpFuncName
       AND tgtWord      = @tgtWord
       AND CorpName     = @CorpName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''FUncSkipWordsDelProc: Cannot delete because foreign keys still exist in FUncSkipWords ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[EmailUpdProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EmailUpdProc]
(
    @EmailGuid                   nvarchar(50),
    @SUBJECT                     nvarchar(2000)            = NULL,
    @SentTO                      nvarchar(2000)            = NULL,
    @Body                        text                      = NULL,
    @Bcc                         nvarchar(max)             = NULL,
    @BillingInformation          nvarchar(200)             = NULL,
    @CC                          nvarchar(max)             = NULL,
    @Companies                   nvarchar(2000)            = NULL,
    @CreationTime                datetime                  = NULL,
    @ReadReceiptRequested        nvarchar(50)              = NULL,
    @ReceivedByName              nvarchar(80),
    @ReceivedTime                datetime,
    @AllRecipients               nvarchar(max)             = NULL,
    @UserID                      nvarchar(80),
    @SenderEmailAddress          nvarchar(80),
    @SenderName                  nvarchar(100),
    @Sensitivity                 nvarchar(50)              = NULL,
    @SentOn                      datetime,
    @MsgSize                     int                       = NULL,
    @DeferredDeliveryTime        datetime                  = NULL,
    @EntryID                     varchar(150)              = NULL,
    @ExpiryTime                  datetime                  = NULL,
    @LastModificationTime        datetime                  = NULL,
    @EmailImage                  image                     = NULL,
    @Accounts                    nvarchar(2000)            = NULL,
    @RowID                       int,
    @ShortSubj                   nvarchar(250)             = NULL,
    @SourceTypeCode              nvarchar(50)              = NULL,
    @OriginalFolder              nvarchar(254)             = NULL,
    @StoreID                     varchar(750)              = NULL,
    @isPublic                    nchar(1)                  = NULL,
    @RetentionExpirationDate     datetime                  = NULL,
    @IsPublicPreviousState       nchar(1)                  = NULL,
    @isAvailable                 nchar(1)                  = NULL,
    @CurrMailFolderID            nvarchar(300)             = NULL,
    @isPerm                      nchar(1)                  = NULL,
    @isMaster                    nchar(1)                  = NULL,
    @CreationDate                datetime                  = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE Email
       SET SUBJECT                      = @SUBJECT,
           SentTO                       = @SentTO,
           Body                         = @Body,
           Bcc                          = @Bcc,
           BillingInformation           = @BillingInformation,
           CC                           = @CC,
           Companies                    = @Companies,
           CreationTime                 = @CreationTime,
           ReadReceiptRequested         = @ReadReceiptRequested,
           ReceivedByName               = @ReceivedByName,
           ReceivedTime                 = @ReceivedTime,
           AllRecipients                = @AllRecipients,
           UserID                       = @UserID,
           SenderEmailAddress           = @SenderEmailAddress,
           SenderName                   = @SenderName,
           Sensitivity                  = @Sensitivity,
           SentOn                       = @SentOn,
           MsgSize                      = @MsgSize,
           DeferredDeliveryTime         = @DeferredDeliveryTime,
           EntryID                      = @EntryID,
           ExpiryTime                   = @ExpiryTime,
           LastModificationTime         = @LastModificationTime,
           EmailImage                   = @EmailImage,
           Accounts                     = @Accounts,
           ShortSubj                    = @ShortSubj,
           SourceTypeCode               = @SourceTypeCode,
           OriginalFolder               = @OriginalFolder,
           StoreID                      = @StoreID,
           isPublic                     = @isPublic,
           RetentionExpirationDate      = @RetentionExpirationDate,
           IsPublicPreviousState        = @IsPublicPreviousState,
           isAvailable                  = @isAvailable,
           CurrMailFolderID             = @CurrMailFolderID,
           isPerm                       = @isPerm,
           isMaster                     = @isMaster,
           CreationDate                 = @CreationDate
     WHERE EmailGuid = @EmailGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''EmailUpdProc: Cannot update  in Email ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ZippedFilesUpdProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZippedFilesUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ZippedFilesUpdProc]
(
    @ContentGUID               nvarchar(50),
    @SourceTypeCode            nvarchar(50)            = NULL,
    @SourceImage               image                   = NULL,
    @SourceGuid                nvarchar(50),
    @DataSourceOwnerUserID     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    UPDATE ZippedFiles
       SET SourceTypeCode             = @SourceTypeCode,
           SourceImage                = @SourceImage,
           SourceGuid                 = @SourceGuid,
           DataSourceOwnerUserID      = @DataSourceOwnerUserID
     WHERE ContentGUID = @ContentGUID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''ZippedFilesUpdProc: Cannot update  in ZippedFiles ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ZippedFilesSelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZippedFilesSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ZippedFilesSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ZippedFilesInsProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZippedFilesInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ZippedFilesInsProc]
(
    @ContentGUID               nvarchar(50),
    @SourceTypeCode            nvarchar(50)            = NULL,
    @SourceImage               image                   = NULL,
    @SourceGuid                nvarchar(50),
    @DataSourceOwnerUserID     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ZippedFiles(ContentGUID,
                            SourceTypeCode,
                            SourceImage,
                            SourceGuid,
                            DataSourceOwnerUserID)
    VALUES(@ContentGUID,
           @SourceTypeCode,
           @SourceImage,
           @SourceGuid,
           @DataSourceOwnerUserID)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''ZippedFilesInsProc: Cannot insert because primary key value not found in ZippedFiles ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ZippedFilesDelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ZippedFilesDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ZippedFilesDelProc]
(
    @ContentGUID               nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM ZippedFiles
     WHERE ContentGUID = @ContentGUID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''ZippedFilesDelProc: Cannot delete because foreign keys still exist in ZippedFiles ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  View [dbo].[vReassignedTable]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vReassignedTable]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vReassignedTable]  AS
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
FROM [DMA.UD].[dbo].[UserReassignHist]'
GO
/****** Object:  StoredProcedure [dbo].[WebSourceUpdProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebSourceUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[WebSourceUpdProc]
(
    @SourceGuid                  nvarchar(50),
    @CreateDate                  datetime                  = NULL,
    @SourceName                  nvarchar(254)             = NULL,
    @SourceImage                 image                     = NULL,
    @SourceTypeCode              nvarchar(50),
    @FileLength                  int                       = NULL,
    @LastWriteTime               datetime                  = NULL,
    @RetentionExpirationDate     datetime                  = NULL,
    @Description                 nvarchar(max)             = NULL,
    @KeyWords                    nvarchar(2000)            = NULL,
    @Notes                       nvarchar(2000)            = NULL,
    @CreationDate                datetime                  = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE WebSource
       SET CreateDate                   = @CreateDate,
           SourceName                   = @SourceName,
           SourceImage                  = @SourceImage,
           SourceTypeCode               = @SourceTypeCode,
           FileLength                   = @FileLength,
           LastWriteTime                = @LastWriteTime,
           RetentionExpirationDate      = @RetentionExpirationDate,
           Description                  = @Description,
           KeyWords                     = @KeyWords,
           Notes                        = @Notes,
           CreationDate                 = @CreationDate
     WHERE SourceGuid = @SourceGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''WebSourceUpdProc: Cannot update  in WebSource ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[WebSourceSelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebSourceSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[WebSourceSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[WebSourceInsProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebSourceInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[WebSourceInsProc]
(
    @SourceGuid                  nvarchar(50),
    @CreateDate                  datetime                  = NULL,
    @SourceName                  nvarchar(254)             = NULL,
    @SourceImage                 image                     = NULL,
    @SourceTypeCode              nvarchar(50),
    @FileLength                  int                       = NULL,
    @LastWriteTime               datetime                  = NULL,
    @RetentionExpirationDate     datetime                  = NULL,
    @Description                 nvarchar(max)             = NULL,
    @KeyWords                    nvarchar(2000)            = NULL,
    @Notes                       nvarchar(2000)            = NULL,
    @CreationDate                datetime                  = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO WebSource(SourceGuid,
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
                          CreationDate)
    VALUES(@SourceGuid,
           @CreateDate,
           @SourceName,
           @SourceImage,
           @SourceTypeCode,
           @FileLength,
           @LastWriteTime,
           @RetentionExpirationDate,
           @Description,
           @KeyWords,
           @Notes,
           @CreationDate)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''WebSourceInsProc: Cannot insert because primary key value not found in WebSource ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[WebSourceDelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebSourceDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[WebSourceDelProc]
(
    @SourceGuid                  nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM WebSource
     WHERE SourceGuid = @SourceGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''WebSourceDelProc: Cannot delete because foreign keys still exist in WebSource ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[UsersUpdProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsersUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: UsersUpdProc 
 */

CREATE PROCEDURE [dbo].[UsersUpdProc]
(
    @UserID           nvarchar(50),
    @UserPassword     nvarchar(50)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE Users
       SET UserPassword      = @UserPassword
     WHERE UserID = @UserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''UsersUpdProc: Cannot update  in Users ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[UsersUpdPr_01282009011743005]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsersUpdPr_01282009011743005]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: UsersUpdProc 
 */

CREATE PROCEDURE [dbo].[UsersUpdPr_01282009011743005]
(
    @UserID           nvarchar(50),
    @UserPassword     nvarchar(50)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE Users
       SET UserPassword      = @UserPassword
     WHERE UserID = @UserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''UsersUpdProc: Cannot update  in Users ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[UsersSelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsersSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[UsersSelPr_01282009011743004]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsersSelPr_01282009011743004]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[UsersInsProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsersInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: UsersInsProc 
 */

CREATE PROCEDURE [dbo].[UsersInsProc]
(
    @UserID           nvarchar(50),
    @UserPassword     nvarchar(50)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Users(UserID,
                      UserPassword)
    VALUES(@UserID,
           @UserPassword)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''UsersInsProc: Cannot insert because primary key value not found in Users ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[UsersInsPr_01282009011743003]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsersInsPr_01282009011743003]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: UsersInsProc 
 */

CREATE PROCEDURE [dbo].[UsersInsPr_01282009011743003]
(
    @UserID           nvarchar(50),
    @UserPassword     nvarchar(50)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Users(UserID,
                      UserPassword)
    VALUES(@UserID,
           @UserPassword)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''UsersInsProc: Cannot insert because primary key value not found in Users ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  View [dbo].[View_SenderEmailAddress]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[View_SenderEmailAddress]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[View_SenderEmailAddress]
AS
SELECT     TOP (100) PERCENT SenderEmailAddress
FROM         dbo.Email
ORDER BY SenderEmailAddress'
GO
/****** Object:  View [dbo].[vDocSearch]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vDocSearch]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vDocSearch]  AS
SELECT
[SourceName] ,
[CreateDate]  ,
[VersionNbr] 	 ,
[LastAccessDate]  ,
[FileLength]  ,
[LastWriteTime]  ,
[SourceTypeCode] 		 ,
[isPublic]  ,
[FQN]  ,
[SourceGuid]  ,
[DataSourceOwnerUserID]
FROM [DataSource]'
GO
/****** Object:  View [dbo].[vDataTypeStorage]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vDataTypeStorage]'))
EXEC dbo.sp_executesql @statement = N'CREATE VIEW [dbo].[vDataTypeStorage]  AS
SELECT DISTINCT DataSource.SourceTypeCode, SUM(CAST(SourceAttribute.AttributeValue AS INT)) AS FILESIZE
FROM         DataSource INNER JOIN
                      SourceAttribute ON DataSource.SourceGuid = SourceAttribute.SourceGuid
WHERE     (SourceAttribute.AttributeName = N''FILESIZE'')
group by DataSource.SourceTypeCode'
GO
/****** Object:  View [dbo].[vDataSourceTypeTot]    Script Date: 07/20/2009 10:50:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vDataSourceTypeTot]'))
EXEC dbo.sp_executesql @statement = N'create view [dbo].[vDataSourceTypeTot] as
select distinct SourceTypeCode, count(*) as Totals 
from datasource 
group by SourceTypeCode
'
GO
/****** Object:  StoredProcedure [dbo].[UsersDelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsersDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: UsersDelProc 
 */

CREATE PROCEDURE [dbo].[UsersDelProc]
(
    @UserID           nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Users
     WHERE UserID = @UserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''UsersDelProc: Cannot delete because foreign keys still exist in Users ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[UsersDelPr_01282009011743002]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UsersDelPr_01282009011743002]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: UsersDelProc 
 */

CREATE PROCEDURE [dbo].[UsersDelPr_01282009011743002]
(
    @UserID           nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Users
     WHERE UserID = @UserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''UsersDelProc: Cannot delete because foreign keys still exist in Users ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[UD_QtyDelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UD_QtyDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: UD_QtyDelProc 
 */

CREATE PROCEDURE [dbo].[UD_QtyDelProc]
(
    @Code            char(10))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM UD_Qty
     WHERE Code = @Code

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''UD_QtyDelProc: Cannot delete because foreign keys still exist in UD_Qty ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[UserGroupSelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserGroupSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[UserGroupSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[UserGroupInsProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserGroupInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[UserGroupInsProc]
(
    @GroupOwnerUserID     nvarchar(50),
    @GroupName            nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO UserGroup(GroupOwnerUserID,
                          GroupName)
    VALUES(@GroupOwnerUserID,
           @GroupName)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''UserGroupInsProc: Cannot insert because primary key value not found in UserGroup ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[UserGroupDelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserGroupDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[UserGroupDelProc]
(
    @GroupOwnerUserID     nvarchar(50),
    @GroupName            nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM UserGroup
     WHERE GroupOwnerUserID = @GroupOwnerUserID
       AND GroupName        = @GroupName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''UserGroupDelProc: Cannot delete because foreign keys still exist in UserGroup ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[UpdateDataSourceImage]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateDataSourceImage]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[UpdateDataSourceImage]		
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

' 
END
GO
/****** Object:  StoredProcedure [dbo].[UserReassignHistInsProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserReassignHistInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[UserReassignHistInsProc]
(
    @PrevUserID                 nvarchar(50),
    @PrevUserName               nvarchar(50)                = NULL,
    @PrevEmailAddress           nvarchar(254)               = NULL,
    @PrevUserPassword           nvarchar(254)               = NULL,
    @PrevAdmin                  nchar(1)                    = NULL,
    @PrevisActive               nchar(1)                    = NULL,
    @PrevUserLoginID            nvarchar(50),
    @ReassignedUserID           nvarchar(50)                = NULL,
    @ReassignedUserName         nvarchar(50),
    @ReassignedEmailAddress     nvarchar(254)               = NULL,
    @ReassignedUserPassword     nvarchar(254)               = NULL,
    @ReassignedAdmin            nchar(1)                    = NULL,
    @ReassignedisActive         nchar(1)                    = NULL,
    @ReassignedUserLoginID      nvarchar(50)                = NULL,
    @ReassignmentDate           datetime,
    @RowID                      uniqueidentifier            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO UserReassignHist(PrevUserID,
                                 PrevUserName,
                                 PrevEmailAddress,
                                 PrevUserPassword,
                                 PrevAdmin,
                                 PrevisActive,
                                 PrevUserLoginID,
                                 ReassignedUserID,
                                 ReassignedUserName,
                                 ReassignedEmailAddress,
                                 ReassignedUserPassword,
                                 ReassignedAdmin,
                                 ReassignedisActive,
                                 ReassignedUserLoginID,
                                 ReassignmentDate,
                                 RowID)
    VALUES(@PrevUserID,
           @PrevUserName,
           @PrevEmailAddress,
           @PrevUserPassword,
           @PrevAdmin,
           @PrevisActive,
           @PrevUserLoginID,
           @ReassignedUserID,
           @ReassignedUserName,
           @ReassignedEmailAddress,
           @ReassignedUserPassword,
           @ReassignedAdmin,
           @ReassignedisActive,
           @ReassignedUserLoginID,
           @ReassignmentDate,
           @RowID)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''UserReassignHistInsProc: Cannot insert because primary key value not found in UserReassignHist ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[UD_QtyUpdProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UD_QtyUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: UD_QtyUpdProc 
 */

CREATE PROCEDURE [dbo].[UD_QtyUpdProc]
(
    @Code            char(10),
    @Description     char(10)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE UD_Qty
       SET Description      = @Description
     WHERE Code = @Code

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''UD_QtyUpdProc: Cannot update  in UD_Qty ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[UD_QtySelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UD_QtySelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[UD_QtyInsProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UD_QtyInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: UD_QtyInsProc 
 */

CREATE PROCEDURE [dbo].[UD_QtyInsProc]
(
    @Code            char(10),
    @Description     char(10)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO UD_Qty(Code,
                       Description)
    VALUES(@Code,
           @Description)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''UD_QtyInsProc: Cannot insert because primary key value not found in UD_Qty ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SubLibrarySelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SubLibrarySelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SubLibrarySelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SubLibraryInsProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SubLibraryInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SubLibraryInsProc]
(
    @UserID             nvarchar(50),
    @SubUserID          nvarchar(50),
    @LibraryName        nvarchar(80),
    @SubLibraryName     nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO SubLibrary(UserID,
                           SubUserID,
                           LibraryName,
                           SubLibraryName)
    VALUES(@UserID,
           @SubUserID,
           @LibraryName,
           @SubLibraryName)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''SubLibraryInsProc: Cannot insert because primary key value not found in SubLibrary ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SubLibraryDelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SubLibraryDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SubLibraryDelProc]
(
    @UserID             nvarchar(50),
    @SubUserID          nvarchar(50),
    @LibraryName        nvarchar(80),
    @SubLibraryName     nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM SubLibrary
     WHERE UserID         = @UserID
       AND SubUserID      = @SubUserID
       AND LibraryName    = @LibraryName
       AND SubLibraryName = @SubLibraryName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''SubLibraryDelProc: Cannot delete because foreign keys still exist in SubLibrary ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SystemParmsInsProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemParmsInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SystemParmsInsProc]
(
    @SysParm         nvarchar(50)             = NULL,
    @SysParmDesc     nvarchar(250)            = NULL,
    @SysParmVal      nvarchar(250)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO SystemParms(SysParm,
                            SysParmDesc,
                            SysParmVal)
    VALUES(@SysParm,
           @SysParmDesc,
           @SysParmVal)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''SystemParmsInsProc: Cannot insert because primary key value not found in SystemParms ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SubDirUpdProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SubDirUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SubDirUpdProc]
(
    @UserID           nvarchar(50),
    @SUBFQN           nvarchar(254),
    @FQN              varchar(254),
    @ckPublic         nchar(1)                 = NULL,
    @ckDisableDir     nchar(1)                 = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE SubDir
       SET ckPublic          = @ckPublic,
           ckDisableDir      = @ckDisableDir
     WHERE UserID = @UserID
       AND SUBFQN = @SUBFQN
       AND FQN    = @FQN

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''SubDirUpdProc: Cannot update  in SubDir ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SubDirSelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SubDirSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SubDirSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SubDirInsProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SubDirInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SubDirInsProc]
(
    @UserID           nvarchar(50),
    @SUBFQN           nvarchar(254),
    @FQN              varchar(254),
    @ckPublic         nchar(1)                 = NULL,
    @ckDisableDir     nchar(1)                 = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO SubDir(UserID,
                       SUBFQN,
                       FQN,
                       ckPublic,
                       ckDisableDir)
    VALUES(@UserID,
           @SUBFQN,
           @FQN,
           @ckPublic,
           @ckDisableDir)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''SubDirInsProc: Cannot insert because primary key value not found in SubDir ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SubDirDelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SubDirDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SubDirDelProc]
(
    @UserID           nvarchar(50),
    @SUBFQN           nvarchar(254),
    @FQN              varchar(254))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM SubDir
     WHERE UserID = @UserID
       AND SUBFQN = @SUBFQN
       AND FQN    = @FQN

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''SubDirDelProc: Cannot delete because foreign keys still exist in SubDir ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[StorageUpdProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StorageUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: StorageUpdProc 
 */

CREATE PROCEDURE [dbo].[StorageUpdProc]
(
    @StoreCode      nvarchar(50),
    @StoreDesc      nvarchar(18)            = NULL,
    @CreateDate     datetime                = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE Storage
       SET StoreDesc       = @StoreDesc,
           CreateDate      = @CreateDate
     WHERE StoreCode = @StoreCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''StorageUpdProc: Cannot update  in Storage ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[StorageSelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StorageSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[StorageInsProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StorageInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: StorageInsProc 
 */

CREATE PROCEDURE [dbo].[StorageInsProc]
(
    @StoreCode      nvarchar(50),
    @StoreDesc      nvarchar(18)            = NULL,
    @CreateDate     datetime                = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Storage(StoreCode,
                        StoreDesc,
                        CreateDate)
    VALUES(@StoreCode,
           @StoreDesc,
           @CreateDate)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''StorageInsProc: Cannot insert because primary key value not found in Storage ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[StorageDelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StorageDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: StorageDelProc 
 */

CREATE PROCEDURE [dbo].[StorageDelProc]
(
    @StoreCode      nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Storage
     WHERE StoreCode = @StoreCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''StorageDelProc: Cannot delete because foreign keys still exist in Storage ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SourceTypeUpdProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceTypeUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: SourceTypeUpdProc 
 */

CREATE PROCEDURE [dbo].[SourceTypeUpdProc]
(
    @SourceTypeCode     nvarchar(50),
    @SourceTypeDesc     nvarchar(18)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE SourceType
       SET SourceTypeDesc      = @SourceTypeDesc
     WHERE SourceTypeCode = @SourceTypeCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''SourceTypeUpdProc: Cannot update  in SourceType ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SourceTypeSelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceTypeSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SourceTypeInsProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceTypeInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: SourceTypeInsProc 
 */

CREATE PROCEDURE [dbo].[SourceTypeInsProc]
(
    @SourceTypeCode     nvarchar(50),
    @SourceTypeDesc     nvarchar(18)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO SourceType(SourceTypeCode,
                           SourceTypeDesc)
    VALUES(@SourceTypeCode,
           @SourceTypeDesc)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''SourceTypeInsProc: Cannot insert because primary key value not found in SourceType ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SourceTypeDelProc]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceTypeDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: SourceTypeDelProc 
 */

CREATE PROCEDURE [dbo].[SourceTypeDelProc]
(
    @SourceTypeCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM SourceType
     WHERE SourceTypeCode = @SourceTypeCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''SourceTypeDelProc: Cannot delete because foreign keys still exist in SourceType ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SourceType_04012008185317005]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceType_04012008185317005]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: SourceTypeUpdProc 
 */

CREATE PROCEDURE [dbo].[SourceType_04012008185317005]
(
    @SourceTypeCode     nvarchar(50),
    @SourceTypeDesc     nvarchar(18)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE SourceType
       SET SourceTypeDesc      = @SourceTypeDesc
     WHERE SourceTypeCode = @SourceTypeCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''SourceTypeUpdProc: Cannot update  in SourceType ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SourceType_04012008185317004]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceType_04012008185317004]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SourceType_04012008185317003]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceType_04012008185317003]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: SourceTypeInsProc 
 */

CREATE PROCEDURE [dbo].[SourceType_04012008185317003]
(
    @SourceTypeCode     nvarchar(50),
    @SourceTypeDesc     nvarchar(18)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO SourceType(SourceTypeCode,
                           SourceTypeDesc)
    VALUES(@SourceTypeCode,
           @SourceTypeDesc)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''SourceTypeInsProc: Cannot insert because primary key value not found in SourceType ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SourceType_04012008185317002]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceType_04012008185317002]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: SourceTypeDelProc 
 */

CREATE PROCEDURE [dbo].[SourceType_04012008185317002]
(
    @SourceTypeCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM SourceType
     WHERE SourceTypeCode = @SourceTypeCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''SourceTypeDelProc: Cannot delete because foreign keys still exist in SourceType ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[spUpdateEmailMsg]    Script Date: 07/20/2009 10:50:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spUpdateEmailMsg]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*CurrentUser, ReceivedByName As String, ReceivedTime As DateTime, SenderEmailAddress As String, SenderName As String, SentOn As DateTime*/
create PROCEDURE [dbo].[spUpdateEmailMsg]		
		@EmailGuid nvarchar(50),
		@EmailImage image
AS
set nocount on
	Update [Email]	set [EmailImage] = @EmailImage where [EmailGuid] = @EmailGuid

RETURN

/****** Object:  StoredProcedure [dbo].[EditAlbum]    Script Date: 03/18/2007 17:30:39 ******/
SET ANSI_NULLS ON' 
END
GO
/****** Object:  StoredProcedure [dbo].[SourceAttributeUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceAttributeUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: SourceAttributeUpdProc 
 */

CREATE PROCEDURE [dbo].[SourceAttributeUpdProc]
(
    @AttributeValue     nvarchar(254)            = NULL,
    @AttributeName      nvarchar(50),
    @SourceGuid         nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    UPDATE SourceAttribute
       SET AttributeValue      = @AttributeValue
     WHERE AttributeName = @AttributeName
       AND SourceGuid    = @SourceGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''SourceAttributeUpdProc: Cannot update  in SourceAttribute ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SourceAttributeSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceAttributeSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SourceAttributeInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceAttributeInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: SourceAttributeInsProc 
 */

CREATE PROCEDURE [dbo].[SourceAttributeInsProc]
(
    @AttributeValue     nvarchar(254)            = NULL,
    @AttributeName      nvarchar(50),
    @SourceGuid         nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO SourceAttribute(AttributeValue,
                                AttributeName,
                                SourceGuid)
    VALUES(@AttributeValue,
           @AttributeName,
           @SourceGuid)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''SourceAttributeInsProc: Cannot insert because primary key value not found in SourceAttribute ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SourceAttributeDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceAttributeDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: SourceAttributeDelProc 
 */

CREATE PROCEDURE [dbo].[SourceAttributeDelProc]
(
    @AttributeName      nvarchar(50),
    @SourceGuid         nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM SourceAttribute
     WHERE AttributeName = @AttributeName
       AND SourceGuid    = @SourceGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''SourceAttributeDelProc: Cannot delete because foreign keys still exist in SourceAttribute ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SourceAttr_01282009011746007]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceAttr_01282009011746007]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: SourceAttributeUpdProc 
 */

CREATE PROCEDURE [dbo].[SourceAttr_01282009011746007]
(
    @AttributeValue     nvarchar(254)            = NULL,
    @AttributeName      nvarchar(50),
    @SourceGuid         nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    UPDATE SourceAttribute
       SET AttributeValue      = @AttributeValue
     WHERE AttributeName = @AttributeName
       AND SourceGuid    = @SourceGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''SourceAttributeUpdProc: Cannot update  in SourceAttribute ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SourceAttr_01282009011746006]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceAttr_01282009011746006]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SourceAttr_01282009011746005]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceAttr_01282009011746005]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: SourceAttributeInsProc 
 */

CREATE PROCEDURE [dbo].[SourceAttr_01282009011746005]
(
    @AttributeValue     nvarchar(254)            = NULL,
    @AttributeName      nvarchar(50),
    @SourceGuid         nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO SourceAttribute(AttributeValue,
                                AttributeName,
                                SourceGuid)
    VALUES(@AttributeValue,
           @AttributeName,
           @SourceGuid)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''SourceAttributeInsProc: Cannot insert because primary key value not found in SourceAttribute ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SourceAttr_01282009011746004]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SourceAttr_01282009011746004]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: SourceAttributeDelProc 
 */

CREATE PROCEDURE [dbo].[SourceAttr_01282009011746004]
(
    @AttributeName      nvarchar(50),
    @SourceGuid         nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM SourceAttribute
     WHERE AttributeName = @AttributeName
       AND SourceGuid    = @SourceGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''SourceAttributeDelProc: Cannot delete because foreign keys still exist in SourceAttribute ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SkipWordsSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SkipWordsSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SkipWordsInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SkipWordsInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: SkipWordsInsProc 
 */

CREATE PROCEDURE [dbo].[SkipWordsInsProc]
(
    @tgtWord     nvarchar(18))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO SkipWords(tgtWord)
    VALUES(@tgtWord)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''SkipWordsInsProc: Cannot insert because primary key value not found in SkipWords ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SkipWordsDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SkipWordsDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: SkipWordsDelProc 
 */

CREATE PROCEDURE [dbo].[SkipWordsDelProc]
(
    @tgtWord     nvarchar(18))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM SkipWords
     WHERE tgtWord = @tgtWord

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''SkipWordsDelProc: Cannot delete because foreign keys still exist in SkipWords ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SavedItemsInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SavedItemsInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SavedItemsInsProc]
(
    @Userid           nvarchar(50),
    @SaveName         nvarchar(50),
    @SaveTypeCode     nvarchar(50),
    @ValName          nvarchar(50),
    @ValValue         nvarchar(254))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO SavedItems(Userid,
                           SaveName,
                           SaveTypeCode,
                           ValName,
                           ValValue)
    VALUES(@Userid,
           @SaveName,
           @SaveTypeCode,
           @ValName,
           @ValValue)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''SavedItemsInsProc: Cannot insert because primary key value not found in SavedItems ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[RuntimeErrorsInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RuntimeErrorsInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[RuntimeErrorsInsProc]
(
    @ErrorMsg           nvarchar(max)            = NULL,
    @StackTrace         nvarchar(max)            = NULL,
    @EntryDate          datetime                 = NULL,
    @IdNbr              nvarchar(50)             = NULL,
    @ConnectiveGuid     nvarchar(50)             = NULL,
    @UserID             nvarchar(50)             = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO RuntimeErrors(ErrorMsg,
                              StackTrace,
                              EntryDate,
                              IdNbr,
                              ConnectiveGuid,
                              UserID)
    VALUES(@ErrorMsg,
           @StackTrace,
           @EntryDate,
           @IdNbr,
           @ConnectiveGuid,
           @UserID)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''RuntimeErrorsInsProc: Cannot insert because primary key value not found in RuntimeErrors ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[RunParmsUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RunParmsUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[RunParmsUpdProc]
(
    @Parm          nvarchar(50),
    @ParmValue     nvarchar(50)            = NULL,
    @UserID        nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    UPDATE RunParms
       SET ParmValue      = @ParmValue
     WHERE Parm   = @Parm
       AND UserID = @UserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''RunParmsUpdProc: Cannot update  in RunParms ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[RunParmsSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RunParmsSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[RunParmsSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[RunParmsInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RunParmsInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[RunParmsInsProc]
(
    @Parm          nvarchar(50),
    @ParmValue     nvarchar(50)            = NULL,
    @UserID        nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO RunParms(Parm,
                         ParmValue,
                         UserID)
    VALUES(@Parm,
           @ParmValue,
           @UserID)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''RunParmsInsProc: Cannot insert because primary key value not found in RunParms ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[RunParmsDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RunParmsDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[RunParmsDelProc]
(
    @Parm          nvarchar(50),
    @UserID        nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM RunParms
     WHERE Parm   = @Parm
       AND UserID = @UserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''RunParmsDelProc: Cannot delete because foreign keys still exist in RunParms ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[RiskLevelInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RiskLevelInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: RiskLevelInsProc 
 */

CREATE PROCEDURE [dbo].[RiskLevelInsProc]
(
    @RiskCode        char(10)                  = NULL,
    @Description     nvarchar(4000)            = NULL,
    @CreateDate      datetime                  = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO RiskLevel(RiskCode,
                          Description,
                          CreateDate)
    VALUES(@RiskCode,
           @Description,
           @CreateDate)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''RiskLevelInsProc: Cannot insert because primary key value not found in RiskLevel ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[MachineInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MachineInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[MachineInsProc]
(
    @MachineName     nvarchar(254))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Machine(MachineName)
    VALUES(@MachineName)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''MachineInsProc: Cannot insert because primary key value not found in Machine ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LoadProfileUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadProfileUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: LoadProfileUpdProc 
 */

CREATE PROCEDURE [dbo].[LoadProfileUpdProc]
(
    @ProfileName     nvarchar(50),
    @ProfileDesc     nvarchar(18)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE LoadProfile
       SET ProfileDesc      = @ProfileDesc
     WHERE ProfileName = @ProfileName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''LoadProfileUpdProc: Cannot update  in LoadProfile ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LoadProfileSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadProfileSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LoadProfileItemSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadProfileItemSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LoadProfileItemInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadProfileItemInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: LoadProfileItemInsProc 
 */

CREATE PROCEDURE [dbo].[LoadProfileItemInsProc]
(
    @ProfileName        nvarchar(50),
    @SourceTypeCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO LoadProfileItem(ProfileName,
                                SourceTypeCode)
    VALUES(@ProfileName,
           @SourceTypeCode)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''LoadProfileItemInsProc: Cannot insert because primary key value not found in LoadProfileItem ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LoadProfileItemDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadProfileItemDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: LoadProfileItemDelProc 
 */

CREATE PROCEDURE [dbo].[LoadProfileItemDelProc]
(
    @ProfileName        nvarchar(50),
    @SourceTypeCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM LoadProfileItem
     WHERE ProfileName    = @ProfileName
       AND SourceTypeCode = @SourceTypeCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''LoadProfileItemDelProc: Cannot delete because foreign keys still exist in LoadProfileItem ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LoadProfileDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadProfileDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: LoadProfileDelProc 
 */

CREATE PROCEDURE [dbo].[LoadProfileDelProc]
(
    @ProfileName     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM LoadProfile
     WHERE ProfileName = @ProfileName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''LoadProfileDelProc: Cannot delete because foreign keys still exist in LoadProfile ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LibraryDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibraryDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LibraryDelProc]
(
    @UserID          nvarchar(50),
    @LibraryName     nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Library
     WHERE UserID      = @UserID
       AND LibraryName = @LibraryName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''LibraryDelProc: Cannot delete because foreign keys still exist in Library ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LoadProfileInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LoadProfileInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: LoadProfileInsProc 
 */

CREATE PROCEDURE [dbo].[LoadProfileInsProc]
(
    @ProfileName     nvarchar(50),
    @ProfileDesc     nvarchar(18)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO LoadProfile(ProfileName,
                            ProfileDesc)
    VALUES(@ProfileName,
           @ProfileDesc)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''LoadProfileInsProc: Cannot insert because primary key value not found in LoadProfile ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LicenseInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LicenseInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LicenseInsProc]
(
    @Agreement          nvarchar(2000),
    @VersionNbr         int,
    @ActivationDate     datetime,
    @InstallDate        datetime,
    @CustomerID         nvarchar(50),
    @CustomerName       nvarchar(254),
    @XrtNxr1            nvarchar(50)              = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO License(Agreement,
                        VersionNbr,
                        ActivationDate,
                        InstallDate,
                        CustomerID,
                        CustomerName,
                        XrtNxr1)
    VALUES(@Agreement,
           @VersionNbr,
           @ActivationDate,
           @InstallDate,
           @CustomerID,
           @CustomerName,
           @XrtNxr1)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''LicenseInsProc: Cannot insert because primary key value not found in License ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LibraryUsersUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibraryUsersUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LibraryUsersUpdProc]
(
    @ReadOnly               bit                     = NULL,
    @CreateAccess           bit                     = NULL,
    @UpdateAccess           bit                     = NULL,
    @DeleteAccess           bit                     = NULL,
    @UserID                 nvarchar(50),
    @LibraryOwnerUserID     nvarchar(50),
    @LibraryName            nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    UPDATE LibraryUsers
       SET ReadOnly                = @ReadOnly,
           CreateAccess            = @CreateAccess,
           UpdateAccess            = @UpdateAccess,
           DeleteAccess            = @DeleteAccess
     WHERE UserID             = @UserID
       AND LibraryOwnerUserID = @LibraryOwnerUserID
       AND LibraryName        = @LibraryName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''LibraryUsersUpdProc: Cannot update  in LibraryUsers ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LibraryUsersSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibraryUsersSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LibraryUsersSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LibraryUsersInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibraryUsersInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LibraryUsersInsProc]
(
    @ReadOnly               bit                     = NULL,
    @CreateAccess           bit                     = NULL,
    @UpdateAccess           bit                     = NULL,
    @DeleteAccess           bit                     = NULL,
    @UserID                 nvarchar(50),
    @LibraryOwnerUserID     nvarchar(50),
    @LibraryName            nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO LibraryUsers(ReadOnly,
                             CreateAccess,
                             UpdateAccess,
                             DeleteAccess,
                             UserID,
                             LibraryOwnerUserID,
                             LibraryName)
    VALUES(@ReadOnly,
           @CreateAccess,
           @UpdateAccess,
           @DeleteAccess,
           @UserID,
           @LibraryOwnerUserID,
           @LibraryName)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''LibraryUsersInsProc: Cannot insert because primary key value not found in LibraryUsers ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LibraryUsersDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibraryUsersDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LibraryUsersDelProc]
(
    @UserID                 nvarchar(50),
    @LibraryOwnerUserID     nvarchar(50),
    @LibraryName            nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM LibraryUsers
     WHERE UserID             = @UserID
       AND LibraryOwnerUserID = @LibraryOwnerUserID
       AND LibraryName        = @LibraryName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''LibraryUsersDelProc: Cannot delete because foreign keys still exist in LibraryUsers ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LibraryInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibraryInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LibraryInsProc]
(
    @UserID          nvarchar(50),
    @LibraryName     nvarchar(80),
    @isPublic        nchar(1))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Library(UserID,
                        LibraryName,
                        isPublic)
    VALUES(@UserID,
           @LibraryName,
           @isPublic)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''LibraryInsProc: Cannot insert because primary key value not found in Library ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LibraryUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibraryUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LibraryUpdProc]
(
    @UserID          nvarchar(50),
    @LibraryName     nvarchar(80),
    @isPublic        nchar(1))
AS
BEGIN
    BEGIN TRAN

    UPDATE Library
       SET isPublic         = @isPublic
     WHERE UserID      = @UserID
       AND LibraryName = @LibraryName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''LibraryUpdProc: Cannot update  in Library ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LibrarySelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibrarySelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LibrarySelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LibraryItemsUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibraryItemsUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LibraryItemsUpdProc]
(
    @SourceGuid                nvarchar(50)             = NULL,
    @ItemTitle                 nvarchar(254)            = NULL,
    @ItemType                  nvarchar(50)             = NULL,
    @LibraryItemGuid           nvarchar(50),
    @DataSourceOwnerUserID     nvarchar(50)             = NULL,
    @LibraryOwnerUserID        nvarchar(50),
    @LibraryName               nvarchar(80),
    @AddedByUserGuidId         nvarchar(50)             = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE LibraryItems
       SET SourceGuid                 = @SourceGuid,
           ItemTitle                  = @ItemTitle,
           ItemType                   = @ItemType,
           DataSourceOwnerUserID      = @DataSourceOwnerUserID,
           AddedByUserGuidId          = @AddedByUserGuidId
     WHERE LibraryItemGuid    = @LibraryItemGuid
       AND LibraryOwnerUserID = @LibraryOwnerUserID
       AND LibraryName        = @LibraryName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''LibraryItemsUpdProc: Cannot update  in LibraryItems ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LibraryItemsSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibraryItemsSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LibraryItemsSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LibraryItemsInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibraryItemsInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LibraryItemsInsProc]
(
    @SourceGuid                nvarchar(50)             = NULL,
    @ItemTitle                 nvarchar(254)            = NULL,
    @ItemType                  nvarchar(50)             = NULL,
    @LibraryItemGuid           nvarchar(50),
    @DataSourceOwnerUserID     nvarchar(50)             = NULL,
    @LibraryOwnerUserID        nvarchar(50),
    @LibraryName               nvarchar(80),
    @AddedByUserGuidId         nvarchar(50)             = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO LibraryItems(SourceGuid,
                             ItemTitle,
                             ItemType,
                             LibraryItemGuid,
                             DataSourceOwnerUserID,
                             LibraryOwnerUserID,
                             LibraryName,
                             AddedByUserGuidId)
    VALUES(@SourceGuid,
           @ItemTitle,
           @ItemType,
           @LibraryItemGuid,
           @DataSourceOwnerUserID,
           @LibraryOwnerUserID,
           @LibraryName,
           @AddedByUserGuidId)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''LibraryItemsInsProc: Cannot insert because primary key value not found in LibraryItems ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LibraryItemsDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibraryItemsDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LibraryItemsDelProc]
(
    @LibraryItemGuid           nvarchar(50),
    @LibraryOwnerUserID        nvarchar(50),
    @LibraryName               nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM LibraryItems
     WHERE LibraryItemGuid    = @LibraryItemGuid
       AND LibraryOwnerUserID = @LibraryOwnerUserID
       AND LibraryName        = @LibraryName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''LibraryItemsDelProc: Cannot delete because foreign keys still exist in LibraryItems ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LibEmailUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibEmailUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LibEmailUpdProc]
(
    @EmailFolderEntryID     nvarchar(200),
    @UserID                 nvarchar(50),
    @LibraryName            nvarchar(80),
    @FolderName             nvarchar(250)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE LibEmail
       SET FolderName              = @FolderName
     WHERE EmailFolderEntryID = @EmailFolderEntryID
       AND UserID             = @UserID
       AND LibraryName        = @LibraryName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''LibEmailUpdProc: Cannot update  in LibEmail ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LibEmailSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibEmailSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LibEmailSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LibEmailInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibEmailInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LibEmailInsProc]
(
    @EmailFolderEntryID     nvarchar(200),
    @UserID                 nvarchar(50),
    @LibraryName            nvarchar(80),
    @FolderName             nvarchar(250)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO LibEmail(EmailFolderEntryID,
                         UserID,
                         LibraryName,
                         FolderName)
    VALUES(@EmailFolderEntryID,
           @UserID,
           @LibraryName,
           @FolderName)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''LibEmailInsProc: Cannot insert because primary key value not found in LibEmail ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LibEmailDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibEmailDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[LibEmailDelProc]
(
    @EmailFolderEntryID     nvarchar(200),
    @UserID                 nvarchar(50),
    @LibraryName            nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM LibEmail
     WHERE EmailFolderEntryID = @EmailFolderEntryID
       AND UserID             = @UserID
       AND LibraryName        = @LibraryName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''LibEmailDelProc: Cannot delete because foreign keys still exist in LibEmail ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LibDirectorySelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibDirectorySelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LibDirectoryInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibDirectoryInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: LibDirectoryInsProc 
 */

CREATE PROCEDURE [dbo].[LibDirectoryInsProc]
(
    @DirectoryName     nvarchar(18),
    @UserID            nvarchar(50),
    @LibraryName       nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO LibDirectory(DirectoryName,
                             UserID,
                             LibraryName)
    VALUES(@DirectoryName,
           @UserID,
           @LibraryName)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''LibDirectoryInsProc: Cannot insert because primary key value not found in LibDirectory ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[LibDirectoryDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LibDirectoryDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: LibDirectoryDelProc 
 */

CREATE PROCEDURE [dbo].[LibDirectoryDelProc]
(
    @DirectoryName     nvarchar(18),
    @UserID            nvarchar(50),
    @LibraryName       nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM LibDirectory
     WHERE DirectoryName = @DirectoryName
       AND UserID        = @UserID
       AND LibraryName   = @LibraryName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''LibDirectoryDelProc: Cannot delete because foreign keys still exist in LibDirectory ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[JargonWordsUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[JargonWordsUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: JargonWordsUpdProc 
 */

CREATE PROCEDURE [dbo].[JargonWordsUpdProc]
(
    @tgtWord        nvarchar(50),
    @jDesc          nvarchar(4000)            = NULL,
    @CreateDate     datetime                  = NULL,
    @JargonCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    UPDATE JargonWords
       SET jDesc           = @jDesc,
           CreateDate      = @CreateDate
     WHERE tgtWord    = @tgtWord
       AND JargonCode = @JargonCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''JargonWordsUpdProc: Cannot update  in JargonWords ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[JargonWordsSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[JargonWordsSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[JargonWordsInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[JargonWordsInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: JargonWordsInsProc 
 */

CREATE PROCEDURE [dbo].[JargonWordsInsProc]
(
    @tgtWord        nvarchar(50),
    @jDesc          nvarchar(4000)            = NULL,
    @CreateDate     datetime                  = NULL,
    @JargonCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO JargonWords(tgtWord,
                            jDesc,
                            CreateDate,
                            JargonCode)
    VALUES(@tgtWord,
           @jDesc,
           @CreateDate,
           @JargonCode)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''JargonWordsInsProc: Cannot insert because primary key value not found in JargonWords ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[JargonWordsDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[JargonWordsDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: JargonWordsDelProc 
 */

CREATE PROCEDURE [dbo].[JargonWordsDelProc]
(
    @tgtWord        nvarchar(50),
    @JargonCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM JargonWords
     WHERE tgtWord    = @tgtWord
       AND JargonCode = @JargonCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''JargonWordsDelProc: Cannot delete because foreign keys still exist in JargonWords ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[InformationTypeDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InformationTypeDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: InformationTypeDelProc 
 */

CREATE PROCEDURE [dbo].[InformationTypeDelProc]
(
    @InfoTypeCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM InformationType
     WHERE InfoTypeCode = @InfoTypeCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''InformationTypeDelProc: Cannot delete because foreign keys still exist in InformationType ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[InformationTypeUpdProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InformationTypeUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: InformationTypeUpdProc 
 */

CREATE PROCEDURE [dbo].[InformationTypeUpdProc]
(
    @CreateDate       datetime                  = NULL,
    @InfoTypeCode     nvarchar(50),
    @Description      nvarchar(4000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE InformationType
       SET CreateDate        = @CreateDate,
           Description       = @Description
     WHERE InfoTypeCode = @InfoTypeCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''InformationTypeUpdProc: Cannot update  in InformationType ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[InformationTypeSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InformationTypeSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[InformationTypeInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InformationTypeInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: InformationTypeInsProc 
 */

CREATE PROCEDURE [dbo].[InformationTypeInsProc]
(
    @CreateDate       datetime                  = NULL,
    @InfoTypeCode     nvarchar(50),
    @Description      nvarchar(4000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO InformationType(CreateDate,
                                InfoTypeCode,
                                Description)
    VALUES(@CreateDate,
           @InfoTypeCode,
           @Description)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''InformationTypeInsProc: Cannot insert because primary key value not found in InformationType ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[InsertDataSource]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertDataSource]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/*
''Dim file_DirName$ = FileAttributes(0)
          ''Dim file_SourceName$ = FileAttributes(1)
          ''Dim file_FullName$ = FileAttributes(2)
          ''Dim file_Length$ = FileAttributes(3)
          ''Dim file_SourceTypeCode$ = FileAttributes(4)
          ''Dim file_LastAccessDate$ = FileAttributes(5)
          ''Dim file_CreateDate$ = FileAttributes(6)
          ''Dim file_LastWriteTime$ = FileAttributes(7)
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
' 
END
GO
/****** Object:  StoredProcedure [dbo].[InsertAttachment]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InsertAttachment]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'
CREATE PROCEDURE [dbo].[InsertAttachment]		
		@EmailGuid nvarchar(50),
		@Attachment image,		
		@AttachmentName varchar(254),
		@AttachmentCode varchar(50),
		@UserID varchar(50)
AS
set nocount on
	INSERT INTO [EmailAttachment] (
		[Attachment],
		[AttachmentName],
		[EmailGuid],
		[AttachmentCode],
	    [UserID]
)
	VALUES (
		@Attachment,
		@AttachmentName,
		@EmailGuid,
		@AttachmentCode,
	    @UserID	    
)
RETURN

/****** Object:  StoredProcedure [dbo].[EditAlbum]    Script Date: 03/18/2007 17:30:39 ******/
SET ANSI_NULLS ON


' 
END
GO
/****** Object:  StoredProcedure [dbo].[IncludedFilesSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IncludedFilesSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[IncludedFilesSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[IncludedFilesInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IncludedFilesInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[IncludedFilesInsProc]
(
    @UserID      nvarchar(50),
    @ExtCode     nvarchar(50),
    @FQN         nvarchar(254))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO IncludedFiles(UserID,
                              ExtCode,
                              FQN)
    VALUES(@UserID,
           @ExtCode,
           @FQN)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''IncludedFilesInsProc: Cannot insert because primary key value not found in IncludedFiles ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[IncludedFilesDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IncludedFilesDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[IncludedFilesDelProc]
(
    @UserID      nvarchar(50),
    @ExtCode     nvarchar(50),
    @FQN         nvarchar(254))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM IncludedFiles
     WHERE UserID  = @UserID
       AND ExtCode = @ExtCode
       AND FQN     = @FQN

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''IncludedFilesDelProc: Cannot delete because foreign keys still exist in IncludedFiles ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[HelpTextInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[HelpTextInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[HelpTextInsProc]
(
    @ScreenName     nvarchar(100),
    @HelpText       nvarchar(max)            = NULL,
    @WidgetName     nvarchar(100))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO HelpText(ScreenName,
                         HelpText,
                         WidgetName)
    VALUES(@ScreenName,
           @HelpText,
           @WidgetName)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''HelpTextInsProc: Cannot insert because primary key value not found in HelpText ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[GroupUsersUpdProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GroupUsersUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GroupUsersUpdProc]
(
    @UserID               nvarchar(50),
    @FullAccess           bit                     = NULL,
    @ReadOnlyAccess       bit                     = NULL,
    @DeleteAccess         bit                     = NULL,
    @Searchable           bit                     = NULL,
    @GroupOwnerUserID     nvarchar(50),
    @GroupName            nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    UPDATE GroupUsers
       SET FullAccess            = @FullAccess,
           ReadOnlyAccess        = @ReadOnlyAccess,
           DeleteAccess          = @DeleteAccess,
           Searchable            = @Searchable
     WHERE UserID           = @UserID
       AND GroupOwnerUserID = @GroupOwnerUserID
       AND GroupName        = @GroupName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''GroupUsersUpdProc: Cannot update  in GroupUsers ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[GroupUsersSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GroupUsersSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GroupUsersSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[GroupUsersInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GroupUsersInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GroupUsersInsProc]
(
    @UserID               nvarchar(50),
    @FullAccess           bit                     = NULL,
    @ReadOnlyAccess       bit                     = NULL,
    @DeleteAccess         bit                     = NULL,
    @Searchable           bit                     = NULL,
    @GroupOwnerUserID     nvarchar(50),
    @GroupName            nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO GroupUsers(UserID,
                           FullAccess,
                           ReadOnlyAccess,
                           DeleteAccess,
                           Searchable,
                           GroupOwnerUserID,
                           GroupName)
    VALUES(@UserID,
           @FullAccess,
           @ReadOnlyAccess,
           @DeleteAccess,
           @Searchable,
           @GroupOwnerUserID,
           @GroupName)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''GroupUsersInsProc: Cannot insert because primary key value not found in GroupUsers ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[GroupUsersDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GroupUsersDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GroupUsersDelProc]
(
    @UserID               nvarchar(50),
    @GroupOwnerUserID     nvarchar(50),
    @GroupName            nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM GroupUsers
     WHERE UserID           = @UserID
       AND GroupOwnerUserID = @GroupOwnerUserID
       AND GroupName        = @GroupName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''GroupUsersDelProc: Cannot delete because foreign keys still exist in GroupUsers ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[FunctionProdJargonUpdProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FunctionProdJargonUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: FunctionProdJargonUpdProc 
 */

CREATE PROCEDURE [dbo].[FunctionProdJargonUpdProc]
(
    @KeyFlag            binary(50)              = NULL,
    @RepeatDataCode     nvarchar(50),
    @CorpFuncName       nvarchar(80),
    @JargonCode         nvarchar(50),
    @CorpName           nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    UPDATE FunctionProdJargon
       SET KeyFlag             = @KeyFlag,
           RepeatDataCode      = @RepeatDataCode
     WHERE CorpFuncName = @CorpFuncName
       AND JargonCode   = @JargonCode
       AND CorpName     = @CorpName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''FunctionProdJargonUpdProc: Cannot update  in FunctionProdJargon ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[FunctionProdJargonSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FunctionProdJargonSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[GroupLibraryAccessSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GroupLibraryAccessSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GroupLibraryAccessSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[GroupLibraryAccessInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GroupLibraryAccessInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GroupLibraryAccessInsProc]
(
    @UserID               nvarchar(50),
    @LibraryName          nvarchar(80),
    @GroupOwnerUserID     nvarchar(50),
    @GroupName            nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO GroupLibraryAccess(UserID,
                                   LibraryName,
                                   GroupOwnerUserID,
                                   GroupName)
    VALUES(@UserID,
           @LibraryName,
           @GroupOwnerUserID,
           @GroupName)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''GroupLibraryAccessInsProc: Cannot insert because primary key value not found in GroupLibraryAccess ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[GroupLibraryAccessDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GroupLibraryAccessDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[GroupLibraryAccessDelProc]
(
    @UserID               nvarchar(50),
    @LibraryName          nvarchar(80),
    @GroupOwnerUserID     nvarchar(50),
    @GroupName            nvarchar(80))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM GroupLibraryAccess
     WHERE UserID           = @UserID
       AND LibraryName      = @LibraryName
       AND GroupOwnerUserID = @GroupOwnerUserID
       AND GroupName        = @GroupName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''GroupLibraryAccessDelProc: Cannot delete because foreign keys still exist in GroupLibraryAccess ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[QuickRefInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuickRefInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[QuickRefInsProc]
(
    @UserID            nvarchar(50),
    @QuickRefName      nvarchar(50)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO QuickRef(UserID,
                         QuickRefName 
                         )
    VALUES(@UserID,
           @QuickRefName 
           )

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''QuickRefInsProc: Cannot insert because primary key value not found in QuickRef ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[QuickRefDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuickRefDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[QuickRefDelProc]
(
    @QuickRefIdNbr     int)
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM QuickRef
     WHERE QuickRefIdNbr = @QuickRefIdNbr

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''QuickRefDelProc: Cannot delete because foreign keys still exist in QuickRef ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[QuickDirectoryUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuickDirectoryUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[QuickDirectoryUpdProc]
(
    @UserID             nvarchar(50),
    @IncludeSubDirs     char(1)                 = NULL,
    @FQN                varchar(254),
    @DB_ID              nvarchar(50),
    @VersionFiles       char(1)                 = NULL,
    @ckMetaData         nchar(1)                = NULL,
    @ckPublic           nchar(1)                = NULL,
    @ckDisableDir       nchar(1)                = NULL,
    @QuickRefEntry      bit                     = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE QuickDirectory
       SET IncludeSubDirs      = @IncludeSubDirs,
           DB_ID               = @DB_ID,
           VersionFiles        = @VersionFiles,
           ckMetaData          = @ckMetaData,
           ckPublic            = @ckPublic,
           ckDisableDir        = @ckDisableDir,
           QuickRefEntry       = @QuickRefEntry
     WHERE UserID = @UserID
       AND FQN    = @FQN

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''QuickDirectoryUpdProc: Cannot update  in QuickDirectory ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[QuickDirectorySelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuickDirectorySelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[QuickDirectorySelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[QuickDirectoryInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuickDirectoryInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[QuickDirectoryInsProc]
(
    @UserID             nvarchar(50),
    @IncludeSubDirs     char(1)                 = NULL,
    @FQN                varchar(254),
    @DB_ID              nvarchar(50),
    @VersionFiles       char(1)                 = NULL,
    @ckMetaData         nchar(1)                = NULL,
    @ckPublic           nchar(1)                = NULL,
    @ckDisableDir       nchar(1)                = NULL,
    @QuickRefEntry      bit                     = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO QuickDirectory(UserID,
                               IncludeSubDirs,
                               FQN,
                               DB_ID,
                               VersionFiles,
                               ckMetaData,
                               ckPublic,
                               ckDisableDir,
                               QuickRefEntry)
    VALUES(@UserID,
           @IncludeSubDirs,
           @FQN,
           @DB_ID,
           @VersionFiles,
           @ckMetaData,
           @ckPublic,
           @ckDisableDir,
           @QuickRefEntry)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''QuickDirectoryInsProc: Cannot insert because primary key value not found in QuickDirectory ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[QuickDirectoryDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuickDirectoryDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[QuickDirectoryDelProc]
(
    @UserID             nvarchar(50),
    @FQN                varchar(254))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM QuickDirectory
     WHERE UserID = @UserID
       AND FQN    = @FQN

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''QuickDirectoryDelProc: Cannot delete because foreign keys still exist in QuickDirectory ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[QtyDocsUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QtyDocsUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: QtyDocsUpdProc 
 */

CREATE PROCEDURE [dbo].[QtyDocsUpdProc]
(
    @QtyDocCode      nvarchar(10),
    @Description     nvarchar(4000)            = NULL,
    @CreateDate      datetime                  = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE QtyDocs
       SET Description      = @Description,
           CreateDate       = @CreateDate
     WHERE QtyDocCode = @QtyDocCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''QtyDocsUpdProc: Cannot update  in QtyDocs ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[QtyDocsSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QtyDocsSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[QtyDocsInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QtyDocsInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: QtyDocsInsProc 
 */

CREATE PROCEDURE [dbo].[QtyDocsInsProc]
(
    @QtyDocCode      nvarchar(10),
    @Description     nvarchar(4000)            = NULL,
    @CreateDate      datetime                  = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO QtyDocs(QtyDocCode,
                        Description,
                        CreateDate)
    VALUES(@QtyDocCode,
           @Description,
           @CreateDate)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''QtyDocsInsProc: Cannot insert because primary key value not found in QtyDocs ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ProdCaptureItemsUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProdCaptureItemsUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: ProdCaptureItemsUpdProc 
 */

CREATE PROCEDURE [dbo].[ProdCaptureItemsUpdProc]
(
    @CaptureItemsCode     nvarchar(50),
    @SendAlert            bit                     = NULL,
    @ContainerType        nvarchar(25),
    @CorpFuncName         nvarchar(80),
    @CorpName             nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    UPDATE ProdCaptureItems
       SET SendAlert             = @SendAlert
     WHERE CaptureItemsCode = @CaptureItemsCode
       AND ContainerType    = @ContainerType
       AND CorpFuncName     = @CorpFuncName
       AND CorpName         = @CorpName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''ProdCaptureItemsUpdProc: Cannot update  in ProdCaptureItems ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ProdCaptureItemsSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProdCaptureItemsSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ProdCaptureItemsInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProdCaptureItemsInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: ProdCaptureItemsInsProc 
 */

CREATE PROCEDURE [dbo].[ProdCaptureItemsInsProc]
(
    @CaptureItemsCode     nvarchar(50),
    @SendAlert            bit                     = NULL,
    @ContainerType        nvarchar(25),
    @CorpFuncName         nvarchar(80),
    @CorpName             nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ProdCaptureItems(CaptureItemsCode,
                                 SendAlert,
                                 ContainerType,
                                 CorpFuncName,
                                 CorpName)
    VALUES(@CaptureItemsCode,
           @SendAlert,
           @ContainerType,
           @CorpFuncName,
           @CorpName)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''ProdCaptureItemsInsProc: Cannot insert because primary key value not found in ProdCaptureItems ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ProdCaptureItemsDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProdCaptureItemsDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: ProdCaptureItemsDelProc 
 */

CREATE PROCEDURE [dbo].[ProdCaptureItemsDelProc]
(
    @CaptureItemsCode     nvarchar(50),
    @ContainerType        nvarchar(25),
    @CorpFuncName         nvarchar(80),
    @CorpName             nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM ProdCaptureItems
     WHERE CaptureItemsCode = @CaptureItemsCode
       AND ContainerType    = @ContainerType
       AND CorpFuncName     = @CorpFuncName
       AND CorpName         = @CorpName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''ProdCaptureItemsDelProc: Cannot delete because foreign keys still exist in ProdCaptureItems ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ProcessFileAsUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProcessFileAsUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ProcessFileAsUpdProc]
(
    @ExtCode            nvarchar(50),
    @ProcessExtCode     nvarchar(50),
    @Applied            bit                     = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE ProcessFileAs
       SET ProcessExtCode      = @ProcessExtCode,
           Applied             = @Applied
     WHERE ExtCode = @ExtCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''ProcessFileAsUpdProc: Cannot update  in ProcessFileAs ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ProcessFileAsSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProcessFileAsSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ProcessFileAsSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ProcessFileAsInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProcessFileAsInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ProcessFileAsInsProc]
(
    @ExtCode            nvarchar(50),
    @ProcessExtCode     nvarchar(50),
    @Applied            bit                     = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ProcessFileAs(ExtCode,
                              ProcessExtCode,
                              Applied)
    VALUES(@ExtCode,
           @ProcessExtCode,
           @Applied)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''ProcessFileAsInsProc: Cannot insert because primary key value not found in ProcessFileAs ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ProcessFileAsDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProcessFileAsDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ProcessFileAsDelProc]
(
    @ExtCode            nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM ProcessFileAs
     WHERE ExtCode = @ExtCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''ProcessFileAsDelProc: Cannot delete because foreign keys still exist in ProcessFileAs ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[PgmTraceInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PgmTraceInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[PgmTraceInsProc]
(
    @StmtID             nvarchar(50)             = NULL,
    @PgmName            nvarchar(254)            = NULL,
    @Stmt               nvarchar(max),
    @CreateDate         datetime                 = NULL,
    @ConnectiveGuid     nvarchar(50)             = NULL,
    @UserID             nvarchar(50)             = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO PgmTrace(StmtID,
                         PgmName,
                         Stmt,
                         CreateDate,
                         ConnectiveGuid,
                         UserID)
    VALUES(@StmtID,
           @PgmName,
           @Stmt,
           @CreateDate,
           @ConnectiveGuid,
           @UserID)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''PgmTraceInsProc: Cannot insert because primary key value not found in PgmTrace ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[OwnerHistoryUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OwnerHistoryUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[OwnerHistoryUpdProc]
(
    @PreviousOwnerUserID     nvarchar(50)            = NULL,
    @RowId                   int,
    @CurrentOwnerUserID      nvarchar(50)            = NULL,
    @CreateDate              datetime                = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE OwnerHistory
       SET PreviousOwnerUserID      = @PreviousOwnerUserID,
           CurrentOwnerUserID       = @CurrentOwnerUserID,
           CreateDate               = @CreateDate
     WHERE RowId = @RowId

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''OwnerHistoryUpdProc: Cannot update  in OwnerHistory ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[OwnerHistorySelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OwnerHistorySelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[OwnerHistorySelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[OwnerHistoryInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OwnerHistoryInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[OwnerHistoryInsProc]
(
    @PreviousOwnerUserID     nvarchar(50)            = NULL,
    @CurrentOwnerUserID      nvarchar(50)            = NULL,
    @CreateDate              datetime                = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO OwnerHistory(PreviousOwnerUserID,
                             CurrentOwnerUserID,
                             CreateDate)
    VALUES(@PreviousOwnerUserID,
           @CurrentOwnerUserID,
           @CreateDate)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''OwnerHistoryInsProc: Cannot insert because primary key value not found in OwnerHistory ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[OwnerHistoryDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OwnerHistoryDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[OwnerHistoryDelProc]
(
    @RowId                   int)
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM OwnerHistory
     WHERE RowId = @RowId

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''OwnerHistoryDelProc: Cannot delete because foreign keys still exist in OwnerHistory ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[SearchHistoryInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SearchHistoryInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[SearchHistoryInsProc]
(
    @SearchSql      nvarchar(max)            = NULL,
    @SearchDate     datetime                 = NULL,
    @UserID         nvarchar(50)             = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO SearchHistory(SearchSql,
                              SearchDate,
                              UserID 
                              )
    VALUES(@SearchSql,
           @SearchDate,
           @UserID 
           )

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''SearchHistoryInsProc: Cannot insert because primary key value not found in SearchHistory ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[RetentionUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RetentionUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: RetentionUpdProc 
 */

CREATE PROCEDURE [dbo].[RetentionUpdProc]
(
    @RetentionCode     nvarchar(50),
    @RetentionDesc     nvarchar(18)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE Retention
       SET RetentionDesc      = @RetentionDesc
     WHERE RetentionCode = @RetentionCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''RetentionUpdProc: Cannot update  in Retention ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[RetentionSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RetentionSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[RetentionInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RetentionInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: RetentionInsProc 
 */

CREATE PROCEDURE [dbo].[RetentionInsProc]
(
    @RetentionCode     nvarchar(50),
    @RetentionDesc     nvarchar(18)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Retention(RetentionCode,
                          RetentionDesc)
    VALUES(@RetentionCode,
           @RetentionDesc)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''RetentionInsProc: Cannot insert because primary key value not found in Retention ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[RetentionDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RetentionDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: RetentionDelProc 
 */

CREATE PROCEDURE [dbo].[RetentionDelProc]
(
    @RetentionCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Retention
     WHERE RetentionCode = @RetentionCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''RetentionDelProc: Cannot delete because foreign keys still exist in Retention ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[RepeatDataUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RepeatDataUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: RepeatDataUpdProc 
 */

CREATE PROCEDURE [dbo].[RepeatDataUpdProc]
(
    @RepeatDataCode     nvarchar(50),
    @RepeatDataDesc     nvarchar(4000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE RepeatData
       SET RepeatDataDesc      = @RepeatDataDesc
     WHERE RepeatDataCode = @RepeatDataCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''RepeatDataUpdProc: Cannot update  in RepeatData ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[RepeatDataSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RepeatDataSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[RepeatDataInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RepeatDataInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: RepeatDataInsProc 
 */

CREATE PROCEDURE [dbo].[RepeatDataInsProc]
(
    @RepeatDataCode     nvarchar(50),
    @RepeatDataDesc     nvarchar(4000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO RepeatData(RepeatDataCode,
                           RepeatDataDesc)
    VALUES(@RepeatDataCode,
           @RepeatDataDesc)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''RepeatDataInsProc: Cannot insert because primary key value not found in RepeatData ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[RepeatDataDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RepeatDataDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: RepeatDataDelProc 
 */

CREATE PROCEDURE [dbo].[RepeatDataDelProc]
(
    @RepeatDataCode     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM RepeatData
     WHERE RepeatDataCode = @RepeatDataCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''RepeatDataDelProc: Cannot delete because foreign keys still exist in RepeatData ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[QtyDocsDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QtyDocsDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: QtyDocsDelProc 
 */

CREATE PROCEDURE [dbo].[QtyDocsDelProc]
(
    @QtyDocCode      nvarchar(10))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM QtyDocs
     WHERE QtyDocCode = @QtyDocCode

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''QtyDocsDelProc: Cannot delete because foreign keys still exist in QtyDocs ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  Trigger [EmailUpdTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[EmailUpdTrig]'))
EXEC dbo.sp_executesql @statement = N'/* 
 * TRIGGER: EmailUpdTrig 
 */

CREATE TRIGGER [dbo].[EmailUpdTrig] ON [dbo].[Email]
FOR UPDATE AS
BEGIN
    DECLARE
        @EmailGuid nvarchar(50),
        @Rows      int,
        @NullRows  int,
        @ValidRows int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Update: RESTRICT

    IF (UPDATE(EmailGuid))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM EmailAttachment ch, deleted
          WHERE ch.EmailGuid = deleted.EmailGuid) != 0)
        BEGIN
            RAISERROR 30001 ''EmailUpdTrigCannot update because foreign keys still exist in EmailAttachment''
            ROLLBACK TRAN
        END
    END
-- Parent Update: RESTRICT

    IF (UPDATE(EmailGuid))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM EmailImage ch, deleted
          WHERE ch.EmailGuid = deleted.EmailGuid) != 0)
        BEGIN
            RAISERROR 30001 ''EmailUpdTrigCannot update because foreign keys still exist in EmailImage''
            ROLLBACK TRAN
        END
    END
-- Parent Update: RESTRICT

    IF (UPDATE(EmailGuid))
    BEGIN
        IF ((SELECT COUNT(*)
          FROM Recipients ch, deleted
          WHERE ch.EmailGuid = deleted.EmailGuid) != 0)
        BEGIN
            RAISERROR 30001 ''EmailUpdTrigCannot update because foreign keys still exist in Recipients''
            ROLLBACK TRAN
        END
    END

END'
GO
/****** Object:  Trigger [EmailDelTrig]    Script Date: 07/20/2009 10:50:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[EmailDelTrig]'))
EXEC dbo.sp_executesql @statement = N'CREATE TRIGGER [dbo].[EmailDelTrig] ON [dbo].[Email]
FOR DELETE AS
BEGIN
    DECLARE
        @Rows      int

    SELECT @Rows = @@rowcount
    IF @Rows = 0
        RETURN

-- Parent Delete: CASCADE

    DELETE EmailAttachment
        FROM EmailAttachment ch, deleted
        WHERE ch.EmailGuid = deleted.EmailGuid
-- Parent Delete: CASCADE

    DELETE Recipients
        FROM Recipients ch, deleted
        WHERE ch.EmailGuid = deleted.EmailGuid
-- Parent Delete: CASCADE

    DELETE EmailAttachmentSearchList
        FROM EmailAttachmentSearchList ch, deleted
        WHERE ch.EmailGuid = deleted.EmailGuid

END
'
GO
/****** Object:  StoredProcedure [dbo].[QuickRefUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuickRefUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[QuickRefUpdProc]
(
    @UserID            nvarchar(50),
    @QuickRefName      nvarchar(50)            = NULL,
    @QuickRefIdNbr     int)
AS
BEGIN
    BEGIN TRAN

    UPDATE QuickRef
       SET UserID             = @UserID,
           QuickRefName       = @QuickRefName
     WHERE QuickRefIdNbr = @QuickRefIdNbr

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''QuickRefUpdProc: Cannot update  in QuickRef ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[QuickRefSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuickRefSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[QuickRefSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[QuickRefItemsUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuickRefItemsUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[QuickRefItemsUpdProc]
(
    @QuickRefIdNbr             int                       = NULL,
    @FQN                       nvarchar(300)             = NULL,
    @QuickRefItemGuid          nvarchar(50),
    @SourceGuid                nvarchar(50)              = NULL,
    @DataSourceOwnerUserID     nvarchar(50)              = NULL,
    @Author                    nvarchar(300)             = NULL,
    @Description               nvarchar(max)             = NULL,
    @Keywords                  nvarchar(2000)            = NULL,
    @FileName                  nvarchar(80)              = NULL,
    @DirName                   nvarchar(254)             = NULL,
    @MarkedForDeletion         bit                       = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE QuickRefItems
       SET QuickRefIdNbr              = @QuickRefIdNbr,
           FQN                        = @FQN,
           SourceGuid                 = @SourceGuid,
           DataSourceOwnerUserID      = @DataSourceOwnerUserID,
           Author                     = @Author,
           Description                = @Description,
           Keywords                   = @Keywords,
           FileName                   = @FileName,
           DirName                    = @DirName,
           MarkedForDeletion          = @MarkedForDeletion
     WHERE QuickRefItemGuid = @QuickRefItemGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''QuickRefItemsUpdProc: Cannot update  in QuickRefItems ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[QuickRefItemsSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuickRefItemsSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[QuickRefItemsSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[QuickRefItemsInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuickRefItemsInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[QuickRefItemsInsProc]
(
    @QuickRefIdNbr             int                       = NULL,
    @FQN                       nvarchar(300)             = NULL,
    @QuickRefItemGuid          nvarchar(50),
    @SourceGuid                nvarchar(50)              = NULL,
    @DataSourceOwnerUserID     nvarchar(50)              = NULL,
    @Author                    nvarchar(300)             = NULL,
    @Description               nvarchar(max)             = NULL,
    @Keywords                  nvarchar(2000)            = NULL,
    @FileName                  nvarchar(80)              = NULL,
    @DirName                   nvarchar(254)             = NULL,
    @MarkedForDeletion         bit                       = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO QuickRefItems(QuickRefIdNbr,
                              FQN,
                              QuickRefItemGuid,
                              SourceGuid,
                              DataSourceOwnerUserID,
                              Author,
                              Description,
                              Keywords,
                              FileName,
                              DirName,
                              MarkedForDeletion)
    VALUES(@QuickRefIdNbr,
           @FQN,
           @QuickRefItemGuid,
           @SourceGuid,
           @DataSourceOwnerUserID,
           @Author,
           @Description,
           @Keywords,
           @FileName,
           @DirName,
           @MarkedForDeletion)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''QuickRefItemsInsProc: Cannot insert because primary key value not found in QuickRefItems ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[QuickRefItemsDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QuickRefItemsDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[QuickRefItemsDelProc]
(
    @QuickRefItemGuid          nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM QuickRefItems
     WHERE QuickRefItemGuid = @QuickRefItemGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''QuickRefItemsDelProc: Cannot delete because foreign keys still exist in QuickRefItems ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[RecipientsUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RecipientsUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[RecipientsUpdProc]
(
    @Recipient     nvarchar(254),
    @EmailGuid     nvarchar(50),
    @TypeRecp      nchar(10)                = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE Recipients
       SET TypeRecp       = @TypeRecp
     WHERE Recipient = @Recipient
       AND EmailGuid = @EmailGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''RecipientsUpdProc: Cannot update  in Recipients ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[RecipientsSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RecipientsSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[RecipientsSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[RecipientsInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RecipientsInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: RecipientsInsProc 
 */

CREATE PROCEDURE [dbo].[RecipientsInsProc]
(
    @Recipient     nvarchar(254)            = NULL,
    @EmailGuid     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Recipients(Recipient,
                           EmailGuid)
    VALUES(@Recipient,
           @EmailGuid)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''RecipientsInsProc: Cannot insert because primary key value not found in Recipients ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[RecipientsDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RecipientsDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[RecipientsDelProc]
(
    @Recipient     nvarchar(254),
    @EmailGuid     nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Recipients
     WHERE Recipient = @Recipient
       AND EmailGuid = @EmailGuid

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''RecipientsDelProc: Cannot delete because foreign keys still exist in Recipients ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[OutlookFromUpdProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OutlookFromUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[OutlookFromUpdProc]
(
    @FromEmailAddr     nvarchar(254),
    @SenderName        varchar(254),
    @UserID            varchar(25),
    @Verified          int                      = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE OutlookFrom
       SET Verified           = @Verified
     WHERE FromEmailAddr = @FromEmailAddr
       AND SenderName    = @SenderName
       AND UserID        = @UserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''OutlookFromUpdProc: Cannot update  in OutlookFrom ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[OutlookFromSelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OutlookFromSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[OutlookFromSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[OutlookFromInsProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OutlookFromInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[OutlookFromInsProc]
(
    @FromEmailAddr     nvarchar(254),
    @SenderName        varchar(254),
    @UserID            varchar(25),
    @Verified          int                      = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO OutlookFrom(FromEmailAddr,
                            SenderName,
                            UserID,
                            Verified)
    VALUES(@FromEmailAddr,
           @SenderName,
           @UserID,
           @Verified)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''OutlookFromInsProc: Cannot insert because primary key value not found in OutlookFrom ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[OutlookFromDelProc]    Script Date: 07/20/2009 10:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OutlookFromDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[OutlookFromDelProc]
(
    @FromEmailAddr     nvarchar(254),
    @SenderName        varchar(254),
    @UserID            varchar(25))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM OutlookFrom
     WHERE FromEmailAddr = @FromEmailAddr
       AND SenderName    = @SenderName
       AND UserID        = @UserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''OutlookFromDelProc: Cannot delete because foreign keys still exist in OutlookFrom ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[IncludeImmediateSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IncludeImmediateSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[IncludeImmediateSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[IncludeImmediateInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IncludeImmediateInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[IncludeImmediateInsProc]
(
    @FromEmailAddr     nvarchar(254),
    @SenderName        varchar(254),
    @UserID            varchar(25))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO IncludeImmediate(FromEmailAddr,
                                 SenderName,
                                 UserID)
    VALUES(@FromEmailAddr,
           @SenderName,
           @UserID)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''IncludeImmediateInsProc: Cannot insert because primary key value not found in IncludeImmediate ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[IncludeImmediateDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[IncludeImmediateDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[IncludeImmediateDelProc]
(
    @FromEmailAddr     nvarchar(254),
    @SenderName        varchar(254),
    @UserID            varchar(25))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM IncludeImmediate
     WHERE FromEmailAddr = @FromEmailAddr
       AND SenderName    = @SenderName
       AND UserID        = @UserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''IncludeImmediateDelProc: Cannot delete because foreign keys still exist in IncludeImmediate ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[EmailToDeleteInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[EmailToDeleteInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[EmailToDeleteInsProc]
(
    @EmailGuid     nvarchar(50),
    @StoreID       nvarchar(500),
    @UserID        nvarchar(100),
    @MessageID     nchar(100)               = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO EmailToDelete(EmailGuid,
                              StoreID,
                              UserID,
                              MessageID)
    VALUES(@EmailGuid,
           @StoreID,
           @UserID,
           @MessageID)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''EmailToDeleteInsProc: Cannot insert because primary key value not found in EmailToDelete ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ExcludeFromSelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExcludeFromSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ExcludeFromSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ExcludeFromInsProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExcludeFromInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ExcludeFromInsProc]
(
    @FromEmailAddr     nvarchar(254),
    @SenderName        varchar(254),
    @UserID            varchar(25))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ExcludeFrom(FromEmailAddr,
                            SenderName,
                            UserID)
    VALUES(@FromEmailAddr,
           @SenderName,
           @UserID)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''ExcludeFromInsProc: Cannot insert because primary key value not found in ExcludeFrom ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ExcludeFromDelProc]    Script Date: 07/20/2009 10:50:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExcludeFromDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ExcludeFromDelProc]
(
    @FromEmailAddr     nvarchar(254),
    @SenderName        varchar(254),
    @UserID            varchar(25))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM ExcludeFrom
     WHERE FromEmailAddr = @FromEmailAddr
       AND SenderName    = @SenderName
       AND UserID        = @UserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''ExcludeFromDelProc: Cannot delete because foreign keys still exist in ExcludeFrom ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ContactsArchiveUpdProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactsArchiveUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ContactsArchiveUpdProc]
(
    @Email1Address                    nvarchar(80),
    @FullName                         nvarchar(80),
    @UserID                           char(25),
    @Account                          nvarchar(4000)            = NULL,
    @Anniversary                      nvarchar(4000)            = NULL,
    @Application                      nvarchar(4000)            = NULL,
    @AssistantName                    nvarchar(4000)            = NULL,
    @AssistantTelephoneNumber         nvarchar(4000)            = NULL,
    @BillingInformation               nvarchar(4000)            = NULL,
    @Birthday                         nvarchar(4000)            = NULL,
    @Business2TelephoneNumber         nvarchar(4000)            = NULL,
    @BusinessAddress                  nvarchar(4000)            = NULL,
    @BusinessAddressCity              nvarchar(4000)            = NULL,
    @BusinessAddressCountry           nvarchar(4000)            = NULL,
    @BusinessAddressPostalCode        nvarchar(4000)            = NULL,
    @BusinessAddressPostOfficeBox     nvarchar(4000)            = NULL,
    @BusinessAddressState             nvarchar(4000)            = NULL,
    @BusinessAddressStreet            nvarchar(4000)            = NULL,
    @BusinessCardType                 nvarchar(4000)            = NULL,
    @BusinessFaxNumber                nvarchar(4000)            = NULL,
    @BusinessHomePage                 nvarchar(4000)            = NULL,
    @BusinessTelephoneNumber          nvarchar(4000)            = NULL,
    @CallbackTelephoneNumber          nvarchar(4000)            = NULL,
    @CarTelephoneNumber               nvarchar(4000)            = NULL,
    @Categories                       nvarchar(4000)            = NULL,
    @Children                         nvarchar(4000)            = NULL,
    @xClass                           nvarchar(4000)            = NULL,
    @Companies                        nvarchar(4000)            = NULL,
    @CompanyName                      nvarchar(4000)            = NULL,
    @ComputerNetworkName              nvarchar(4000)            = NULL,
    @Conflicts                        nvarchar(4000)            = NULL,
    @ConversationTopic                nvarchar(4000)            = NULL,
    @CreationTime                     nvarchar(4000)            = NULL,
    @CustomerID                       nvarchar(4000)            = NULL,
    @Department                       nvarchar(4000)            = NULL,
    @Email1AddressType                nvarchar(4000)            = NULL,
    @Email1DisplayName                nvarchar(4000)            = NULL,
    @Email1EntryID                    nvarchar(4000)            = NULL,
    @Email2Address                    nvarchar(4000)            = NULL,
    @Email2AddressType                nvarchar(4000)            = NULL,
    @Email2DisplayName                nvarchar(4000)            = NULL,
    @Email2EntryID                    nvarchar(4000)            = NULL,
    @Email3Address                    nvarchar(4000)            = NULL,
    @Email3AddressType                nvarchar(4000)            = NULL,
    @Email3DisplayName                nvarchar(4000)            = NULL,
    @Email3EntryID                    nvarchar(4000)            = NULL,
    @FileAs                           nvarchar(4000)            = NULL,
    @FirstName                        nvarchar(4000)            = NULL,
    @FTPSite                          nvarchar(4000)            = NULL,
    @Gender                           nvarchar(4000)            = NULL,
    @GovernmentIDNumber               nvarchar(4000)            = NULL,
    @Hobby                            nvarchar(4000)            = NULL,
    @Home2TelephoneNumber             nvarchar(4000)            = NULL,
    @HomeAddress                      nvarchar(4000)            = NULL,
    @HomeAddressCountry               nvarchar(4000)            = NULL,
    @HomeAddressPostalCode            nvarchar(4000)            = NULL,
    @HomeAddressPostOfficeBox         nvarchar(4000)            = NULL,
    @HomeAddressState                 nvarchar(4000)            = NULL,
    @HomeAddressStreet                nvarchar(4000)            = NULL,
    @HomeFaxNumber                    nvarchar(4000)            = NULL,
    @HomeTelephoneNumber              nvarchar(4000)            = NULL,
    @IMAddress                        nvarchar(4000)            = NULL,
    @Importance                       nvarchar(4000)            = NULL,
    @Initials                         nvarchar(4000)            = NULL,
    @InternetFreeBusyAddress          nvarchar(4000)            = NULL,
    @JobTitle                         nvarchar(4000)            = NULL,
    @Journal                          nvarchar(4000)            = NULL,
    @Language                         nvarchar(4000)            = NULL,
    @LastModificationTime             nvarchar(4000)            = NULL,
    @LastName                         nvarchar(4000)            = NULL,
    @LastNameAndFirstName             nvarchar(4000)            = NULL,
    @MailingAddress                   nvarchar(4000)            = NULL,
    @MailingAddressCity               nvarchar(4000)            = NULL,
    @MailingAddressCountry            nvarchar(4000)            = NULL,
    @MailingAddressPostalCode         nvarchar(4000)            = NULL,
    @MailingAddressPostOfficeBox      nvarchar(4000)            = NULL,
    @MailingAddressState              nvarchar(4000)            = NULL,
    @MailingAddressStreet             nvarchar(4000)            = NULL,
    @ManagerName                      nvarchar(4000)            = NULL,
    @MiddleName                       nvarchar(4000)            = NULL,
    @Mileage                          nvarchar(4000)            = NULL,
    @MobileTelephoneNumber            nvarchar(4000)            = NULL,
    @NetMeetingAlias                  nvarchar(4000)            = NULL,
    @NetMeetingServer                 nvarchar(4000)            = NULL,
    @NickName                         nvarchar(4000)            = NULL,
    @Title                            nvarchar(4000)            = NULL,
    @Body                             nvarchar(4000)            = NULL,
    @OfficeLocation                   nvarchar(4000)            = NULL,
    @Subject                          nvarchar(4000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE ContactsArchive
       SET Account                           = @Account,
           Anniversary                       = @Anniversary,
           Application                       = @Application,
           AssistantName                     = @AssistantName,
           AssistantTelephoneNumber          = @AssistantTelephoneNumber,
           BillingInformation                = @BillingInformation,
           Birthday                          = @Birthday,
           Business2TelephoneNumber          = @Business2TelephoneNumber,
           BusinessAddress                   = @BusinessAddress,
           BusinessAddressCity               = @BusinessAddressCity,
           BusinessAddressCountry            = @BusinessAddressCountry,
           BusinessAddressPostalCode         = @BusinessAddressPostalCode,
           BusinessAddressPostOfficeBox      = @BusinessAddressPostOfficeBox,
           BusinessAddressState              = @BusinessAddressState,
           BusinessAddressStreet             = @BusinessAddressStreet,
           BusinessCardType                  = @BusinessCardType,
           BusinessFaxNumber                 = @BusinessFaxNumber,
           BusinessHomePage                  = @BusinessHomePage,
           BusinessTelephoneNumber           = @BusinessTelephoneNumber,
           CallbackTelephoneNumber           = @CallbackTelephoneNumber,
           CarTelephoneNumber                = @CarTelephoneNumber,
           Categories                        = @Categories,
           Children                          = @Children,
           xClass                            = @xClass,
           Companies                         = @Companies,
           CompanyName                       = @CompanyName,
           ComputerNetworkName               = @ComputerNetworkName,
           Conflicts                         = @Conflicts,
           ConversationTopic                 = @ConversationTopic,
           CreationTime                      = @CreationTime,
           CustomerID                        = @CustomerID,
           Department                        = @Department,
           Email1AddressType                 = @Email1AddressType,
           Email1DisplayName                 = @Email1DisplayName,
           Email1EntryID                     = @Email1EntryID,
           Email2Address                     = @Email2Address,
           Email2AddressType                 = @Email2AddressType,
           Email2DisplayName                 = @Email2DisplayName,
           Email2EntryID                     = @Email2EntryID,
           Email3Address                     = @Email3Address,
           Email3AddressType                 = @Email3AddressType,
           Email3DisplayName                 = @Email3DisplayName,
           Email3EntryID                     = @Email3EntryID,
           FileAs                            = @FileAs,
           FirstName                         = @FirstName,
           FTPSite                           = @FTPSite,
           Gender                            = @Gender,
           GovernmentIDNumber                = @GovernmentIDNumber,
           Hobby                             = @Hobby,
           Home2TelephoneNumber              = @Home2TelephoneNumber,
           HomeAddress                       = @HomeAddress,
           HomeAddressCountry                = @HomeAddressCountry,
           HomeAddressPostalCode             = @HomeAddressPostalCode,
           HomeAddressPostOfficeBox          = @HomeAddressPostOfficeBox,
           HomeAddressState                  = @HomeAddressState,
           HomeAddressStreet                 = @HomeAddressStreet,
           HomeFaxNumber                     = @HomeFaxNumber,
           HomeTelephoneNumber               = @HomeTelephoneNumber,
           IMAddress                         = @IMAddress,
           Importance                        = @Importance,
           Initials                          = @Initials,
           InternetFreeBusyAddress           = @InternetFreeBusyAddress,
           JobTitle                          = @JobTitle,
           Journal                           = @Journal,
           Language                          = @Language,
           LastModificationTime              = @LastModificationTime,
           LastName                          = @LastName,
           LastNameAndFirstName              = @LastNameAndFirstName,
           MailingAddress                    = @MailingAddress,
           MailingAddressCity                = @MailingAddressCity,
           MailingAddressCountry             = @MailingAddressCountry,
           MailingAddressPostalCode          = @MailingAddressPostalCode,
           MailingAddressPostOfficeBox       = @MailingAddressPostOfficeBox,
           MailingAddressState               = @MailingAddressState,
           MailingAddressStreet              = @MailingAddressStreet,
           ManagerName                       = @ManagerName,
           MiddleName                        = @MiddleName,
           Mileage                           = @Mileage,
           MobileTelephoneNumber             = @MobileTelephoneNumber,
           NetMeetingAlias                   = @NetMeetingAlias,
           NetMeetingServer                  = @NetMeetingServer,
           NickName                          = @NickName,
           Title                             = @Title,
           Body                              = @Body,
           OfficeLocation                    = @OfficeLocation,
           Subject                           = @Subject
     WHERE Email1Address = @Email1Address
       AND FullName      = @FullName
       AND UserID        = @UserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''ContactsArchiveUpdProc: Cannot update  in ContactsArchive ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ContactsArchiveSelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactsArchiveSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ContactsArchiveSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ContactsArchiveInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactsArchiveInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ContactsArchiveInsProc]
(
    @Email1Address                    nvarchar(80),
    @FullName                         nvarchar(80),
    @UserID                           char(25),
    @Account                          nvarchar(4000)            = NULL,
    @Anniversary                      nvarchar(4000)            = NULL,
    @Application                      nvarchar(4000)            = NULL,
    @AssistantName                    nvarchar(4000)            = NULL,
    @AssistantTelephoneNumber         nvarchar(4000)            = NULL,
    @BillingInformation               nvarchar(4000)            = NULL,
    @Birthday                         nvarchar(4000)            = NULL,
    @Business2TelephoneNumber         nvarchar(4000)            = NULL,
    @BusinessAddress                  nvarchar(4000)            = NULL,
    @BusinessAddressCity              nvarchar(4000)            = NULL,
    @BusinessAddressCountry           nvarchar(4000)            = NULL,
    @BusinessAddressPostalCode        nvarchar(4000)            = NULL,
    @BusinessAddressPostOfficeBox     nvarchar(4000)            = NULL,
    @BusinessAddressState             nvarchar(4000)            = NULL,
    @BusinessAddressStreet            nvarchar(4000)            = NULL,
    @BusinessCardType                 nvarchar(4000)            = NULL,
    @BusinessFaxNumber                nvarchar(4000)            = NULL,
    @BusinessHomePage                 nvarchar(4000)            = NULL,
    @BusinessTelephoneNumber          nvarchar(4000)            = NULL,
    @CallbackTelephoneNumber          nvarchar(4000)            = NULL,
    @CarTelephoneNumber               nvarchar(4000)            = NULL,
    @Categories                       nvarchar(4000)            = NULL,
    @Children                         nvarchar(4000)            = NULL,
    @xClass                           nvarchar(4000)            = NULL,
    @Companies                        nvarchar(4000)            = NULL,
    @CompanyName                      nvarchar(4000)            = NULL,
    @ComputerNetworkName              nvarchar(4000)            = NULL,
    @Conflicts                        nvarchar(4000)            = NULL,
    @ConversationTopic                nvarchar(4000)            = NULL,
    @CreationTime                     nvarchar(4000)            = NULL,
    @CustomerID                       nvarchar(4000)            = NULL,
    @Department                       nvarchar(4000)            = NULL,
    @Email1AddressType                nvarchar(4000)            = NULL,
    @Email1DisplayName                nvarchar(4000)            = NULL,
    @Email1EntryID                    nvarchar(4000)            = NULL,
    @Email2Address                    nvarchar(4000)            = NULL,
    @Email2AddressType                nvarchar(4000)            = NULL,
    @Email2DisplayName                nvarchar(4000)            = NULL,
    @Email2EntryID                    nvarchar(4000)            = NULL,
    @Email3Address                    nvarchar(4000)            = NULL,
    @Email3AddressType                nvarchar(4000)            = NULL,
    @Email3DisplayName                nvarchar(4000)            = NULL,
    @Email3EntryID                    nvarchar(4000)            = NULL,
    @FileAs                           nvarchar(4000)            = NULL,
    @FirstName                        nvarchar(4000)            = NULL,
    @FTPSite                          nvarchar(4000)            = NULL,
    @Gender                           nvarchar(4000)            = NULL,
    @GovernmentIDNumber               nvarchar(4000)            = NULL,
    @Hobby                            nvarchar(4000)            = NULL,
    @Home2TelephoneNumber             nvarchar(4000)            = NULL,
    @HomeAddress                      nvarchar(4000)            = NULL,
    @HomeAddressCountry               nvarchar(4000)            = NULL,
    @HomeAddressPostalCode            nvarchar(4000)            = NULL,
    @HomeAddressPostOfficeBox         nvarchar(4000)            = NULL,
    @HomeAddressState                 nvarchar(4000)            = NULL,
    @HomeAddressStreet                nvarchar(4000)            = NULL,
    @HomeFaxNumber                    nvarchar(4000)            = NULL,
    @HomeTelephoneNumber              nvarchar(4000)            = NULL,
    @IMAddress                        nvarchar(4000)            = NULL,
    @Importance                       nvarchar(4000)            = NULL,
    @Initials                         nvarchar(4000)            = NULL,
    @InternetFreeBusyAddress          nvarchar(4000)            = NULL,
    @JobTitle                         nvarchar(4000)            = NULL,
    @Journal                          nvarchar(4000)            = NULL,
    @Language                         nvarchar(4000)            = NULL,
    @LastModificationTime             nvarchar(4000)            = NULL,
    @LastName                         nvarchar(4000)            = NULL,
    @LastNameAndFirstName             nvarchar(4000)            = NULL,
    @MailingAddress                   nvarchar(4000)            = NULL,
    @MailingAddressCity               nvarchar(4000)            = NULL,
    @MailingAddressCountry            nvarchar(4000)            = NULL,
    @MailingAddressPostalCode         nvarchar(4000)            = NULL,
    @MailingAddressPostOfficeBox      nvarchar(4000)            = NULL,
    @MailingAddressState              nvarchar(4000)            = NULL,
    @MailingAddressStreet             nvarchar(4000)            = NULL,
    @ManagerName                      nvarchar(4000)            = NULL,
    @MiddleName                       nvarchar(4000)            = NULL,
    @Mileage                          nvarchar(4000)            = NULL,
    @MobileTelephoneNumber            nvarchar(4000)            = NULL,
    @NetMeetingAlias                  nvarchar(4000)            = NULL,
    @NetMeetingServer                 nvarchar(4000)            = NULL,
    @NickName                         nvarchar(4000)            = NULL,
    @Title                            nvarchar(4000)            = NULL,
    @Body                             nvarchar(4000)            = NULL,
    @OfficeLocation                   nvarchar(4000)            = NULL,
    @Subject                          nvarchar(4000)            = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ContactsArchive(Email1Address,
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
                                Subject)
    VALUES(@Email1Address,
           @FullName,
           @UserID,
           @Account,
           @Anniversary,
           @Application,
           @AssistantName,
           @AssistantTelephoneNumber,
           @BillingInformation,
           @Birthday,
           @Business2TelephoneNumber,
           @BusinessAddress,
           @BusinessAddressCity,
           @BusinessAddressCountry,
           @BusinessAddressPostalCode,
           @BusinessAddressPostOfficeBox,
           @BusinessAddressState,
           @BusinessAddressStreet,
           @BusinessCardType,
           @BusinessFaxNumber,
           @BusinessHomePage,
           @BusinessTelephoneNumber,
           @CallbackTelephoneNumber,
           @CarTelephoneNumber,
           @Categories,
           @Children,
           @xClass,
           @Companies,
           @CompanyName,
           @ComputerNetworkName,
           @Conflicts,
           @ConversationTopic,
           @CreationTime,
           @CustomerID,
           @Department,
           @Email1AddressType,
           @Email1DisplayName,
           @Email1EntryID,
           @Email2Address,
           @Email2AddressType,
           @Email2DisplayName,
           @Email2EntryID,
           @Email3Address,
           @Email3AddressType,
           @Email3DisplayName,
           @Email3EntryID,
           @FileAs,
           @FirstName,
           @FTPSite,
           @Gender,
           @GovernmentIDNumber,
           @Hobby,
           @Home2TelephoneNumber,
           @HomeAddress,
           @HomeAddressCountry,
           @HomeAddressPostalCode,
           @HomeAddressPostOfficeBox,
           @HomeAddressState,
           @HomeAddressStreet,
           @HomeFaxNumber,
           @HomeTelephoneNumber,
           @IMAddress,
           @Importance,
           @Initials,
           @InternetFreeBusyAddress,
           @JobTitle,
           @Journal,
           @Language,
           @LastModificationTime,
           @LastName,
           @LastNameAndFirstName,
           @MailingAddress,
           @MailingAddressCity,
           @MailingAddressCountry,
           @MailingAddressPostalCode,
           @MailingAddressPostOfficeBox,
           @MailingAddressState,
           @MailingAddressStreet,
           @ManagerName,
           @MiddleName,
           @Mileage,
           @MobileTelephoneNumber,
           @NetMeetingAlias,
           @NetMeetingServer,
           @NickName,
           @Title,
           @Body,
           @OfficeLocation,
           @Subject)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''ContactsArchiveInsProc: Cannot insert because primary key value not found in ContactsArchive ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ContactsArchiveDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactsArchiveDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ContactsArchiveDelProc]
(
    @Email1Address                    nvarchar(80),
    @FullName                         nvarchar(80),
    @UserID                           char(25))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM ContactsArchive
     WHERE Email1Address = @Email1Address
       AND FullName      = @FullName
       AND UserID        = @UserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''ContactsArchiveDelProc: Cannot delete because foreign keys still exist in ContactsArchive ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ContactFromUpdProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactFromUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ContactFromUpdProc]
(
    @FromEmailAddr     nvarchar(254),
    @SenderName        varchar(254),
    @UserID            varchar(25),
    @Verified          int                      = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE ContactFrom
       SET Verified           = @Verified
     WHERE FromEmailAddr = @FromEmailAddr
       AND SenderName    = @SenderName
       AND UserID        = @UserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''ContactFromUpdProc: Cannot update  in ContactFrom ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ContactFromSelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactFromSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ContactFromSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ContactFromInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactFromInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ContactFromInsProc]
(
    @FromEmailAddr     nvarchar(254),
    @SenderName        varchar(254),
    @UserID            varchar(25),
    @Verified          int                      = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ContactFrom(FromEmailAddr,
                            SenderName,
                            UserID,
                            Verified)
    VALUES(@FromEmailAddr,
           @SenderName,
           @UserID,
           @Verified)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''ContactFromInsProc: Cannot insert because primary key value not found in ContactFrom ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ContactFromDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ContactFromDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ContactFromDelProc]
(
    @FromEmailAddr     nvarchar(254),
    @SenderName        varchar(254),
    @UserID            varchar(25))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM ContactFrom
     WHERE FromEmailAddr = @FromEmailAddr
       AND SenderName    = @SenderName
       AND UserID        = @UserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''ContactFromDelProc: Cannot delete because foreign keys still exist in ContactFrom ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[AttributesDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributesDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: AttributesDelProc 
 */

CREATE PROCEDURE [dbo].[AttributesDelProc]
(
    @AttributeName         nvarchar(50))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM Attributes
     WHERE AttributeName = @AttributeName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''AttributesDelProc: Cannot delete because foreign keys still exist in Attributes ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[AttributesUpdProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributesUpdProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: AttributesUpdProc 
 */

CREATE PROCEDURE [dbo].[AttributesUpdProc]
(
    @AttributeName         nvarchar(50),
    @AttributeDataType     nvarchar(50),
    @AttributeDesc         nvarchar(2000)            = NULL,
    @AssoApplication       nvarchar(50)              = NULL)
AS
BEGIN
    BEGIN TRAN

    UPDATE Attributes
       SET AttributeDataType      = @AttributeDataType,
           AttributeDesc          = @AttributeDesc,
           AssoApplication        = @AssoApplication
     WHERE AttributeName = @AttributeName

    IF (@@error!=0)
    BEGIN
        RAISERROR  20001 ''AttributesUpdProc: Cannot update  in Attributes ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[AttributesSelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributesSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[AttributesInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AttributesInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'/* 
 * PROCEDURE: AttributesInsProc 
 */

CREATE PROCEDURE [dbo].[AttributesInsProc]
(
    @AttributeName         nvarchar(50),
    @AttributeDataType     nvarchar(50),
    @AttributeDesc         nvarchar(2000)            = NULL,
    @AssoApplication       nvarchar(50)              = NULL)
AS
BEGIN
    BEGIN TRAN

    INSERT INTO Attributes(AttributeName,
                           AttributeDataType,
                           AttributeDesc,
                           AssoApplication)
    VALUES(@AttributeName,
           @AttributeDataType,
           @AttributeDesc,
           @AssoApplication)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''AttributesInsProc: Cannot insert because primary key value not found in Attributes ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ArchiveFromSelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveFromSelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ArchiveFromSelProc]
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
END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ArchiveFromInsProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveFromInsProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ArchiveFromInsProc]
(
    @FromEmailAddr     nvarchar(254),
    @SenderName        varchar(254),
    @UserID            varchar(25))
AS
BEGIN
    BEGIN TRAN

    INSERT INTO ArchiveFrom(FromEmailAddr,
                            SenderName,
                            UserID)
    VALUES(@FromEmailAddr,
           @SenderName,
           @UserID)

    IF (@@error!=0)
    BEGIN
        RAISERROR  20000 ''ArchiveFromInsProc: Cannot insert because primary key value not found in ArchiveFrom ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

END' 
END
GO
/****** Object:  StoredProcedure [dbo].[ArchiveFromDelProc]    Script Date: 07/20/2009 10:50:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ArchiveFromDelProc]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[ArchiveFromDelProc]
(
    @FromEmailAddr     nvarchar(254),
    @SenderName        varchar(254),
    @UserID            varchar(25))
AS
BEGIN
    BEGIN TRAN

    DELETE
      FROM ArchiveFrom
     WHERE FromEmailAddr = @FromEmailAddr
       AND SenderName    = @SenderName
       AND UserID        = @UserID

    IF (@@error!=0)
    BEGIN
        RAISERROR  20002 ''ArchiveFromDelProc: Cannot delete because foreign keys still exist in ArchiveFrom ''
        ROLLBACK TRAN
        RETURN(1)
    
    END

    COMMIT TRAN

    RETURN(0)
END' 
END
GO
/****** Object:  Default [DF__ArchiveHi__Archi__1D864D1D]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__ArchiveHi__Archi__1D864D1D]') AND parent_object_id = OBJECT_ID(N'[dbo].[ArchiveHist]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__ArchiveHi__Archi__1D864D1D]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ArchiveHist] ADD  CONSTRAINT [DF__ArchiveHi__Archi__1D864D1D]  DEFAULT (getdate()) FOR [ArchiveDate]
END


End
GO
/****** Object:  Default [DF_AssignableUserParameters_isPerm]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_AssignableUserParameters_isPerm]') AND parent_object_id = OBJECT_ID(N'[dbo].[AssignableUserParameters]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AssignableUserParameters_isPerm]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AssignableUserParameters] ADD  CONSTRAINT [DF_AssignableUserParameters_isPerm]  DEFAULT ((0)) FOR [isPerm]
END


End
GO
/****** Object:  Default [DF_AttachmentType_isZipFormat]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_AttachmentType_isZipFormat]') AND parent_object_id = OBJECT_ID(N'[dbo].[AttachmentType]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AttachmentType_isZipFormat]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AttachmentType] ADD  CONSTRAINT [DF_AttachmentType_isZipFormat]  DEFAULT ((0)) FOR [isZipFormat]
END


End
GO
/****** Object:  Default [DF_Attributes_AttributeDataType]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Attributes_AttributeDataType]') AND parent_object_id = OBJECT_ID(N'[dbo].[Attributes]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Attributes_AttributeDataType]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Attributes] ADD  CONSTRAINT [DF_Attributes_AttributeDataType]  DEFAULT ('nvarchar') FOR [AttributeDataType]
END


End
GO
/****** Object:  Default [DF_AvailFileTypesUndefined_Applied]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_AvailFileTypesUndefined_Applied]') AND parent_object_id = OBJECT_ID(N'[dbo].[AvailFileTypesUndefined]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_AvailFileTypesUndefined_Applied]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[AvailFileTypesUndefined] ADD  CONSTRAINT [DF_AvailFileTypesUndefined_Applied]  DEFAULT ((0)) FOR [Applied]
END


End
GO
/****** Object:  Default [DF_ContactFrom_Verified]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_ContactFrom_Verified]') AND parent_object_id = OBJECT_ID(N'[dbo].[ContactFrom]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_ContactFrom_Verified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[ContactFrom] ADD  CONSTRAINT [DF_ContactFrom_Verified]  DEFAULT ((1)) FOR [Verified]
END


End
GO
/****** Object:  Default [DF__CoOwner__CreateD__36F11965]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__CoOwner__CreateD__36F11965]') AND parent_object_id = OBJECT_ID(N'[dbo].[CoOwner]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__CoOwner__CreateD__36F11965]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CoOwner] ADD  CONSTRAINT [DF__CoOwner__CreateD__36F11965]  DEFAULT (getdate()) FOR [CreateDate]
END


End
GO
/****** Object:  Default [CURRDATE_04012008185318003]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CURRDATE_04012008185318003]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSource]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[CURRDATE_04012008185318003]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [CURRDATE_04012008185318003]  DEFAULT (getdate()) FOR [CreateDate]
END


End
GO
/****** Object:  Default [DF_DataSource_VersionNbr]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_DataSource_VersionNbr]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSource]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_DataSource_VersionNbr]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [DF_DataSource_VersionNbr]  DEFAULT ((0)) FOR [VersionNbr]
END


End
GO
/****** Object:  Default [DF_DataSource_Public]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_DataSource_Public]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSource]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_DataSource_Public]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [DF_DataSource_Public]  DEFAULT ('N') FOR [isPublic]
END


End
GO
/****** Object:  Default [DF_DataSource_RetentionExpirationDate]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_DataSource_RetentionExpirationDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSource]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_DataSource_RetentionExpirationDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [DF_DataSource_RetentionExpirationDate]  DEFAULT (getdate()+(3650)) FOR [RetentionExpirationDate]
END


End
GO
/****** Object:  Default [DF_DataSource_isUnavailable]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_DataSource_isUnavailable]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSource]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_DataSource_isUnavailable]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [DF_DataSource_isUnavailable]  DEFAULT ('Y') FOR [isAvailable]
END


End
GO
/****** Object:  Default [DF_DataSource_isContainedWithinZipFile]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_DataSource_isContainedWithinZipFile]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSource]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_DataSource_isContainedWithinZipFile]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [DF_DataSource_isContainedWithinZipFile]  DEFAULT ('N') FOR [isContainedWithinZipFile]
END


End
GO
/****** Object:  Default [DF_DataSource_IsZipFile]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_DataSource_IsZipFile]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSource]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_DataSource_IsZipFile]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [DF_DataSource_IsZipFile]  DEFAULT ('N') FOR [IsZipFile]
END


End
GO
/****** Object:  Default [DF_DataSource_DataVerified]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_DataSource_DataVerified]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSource]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_DataSource_DataVerified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [DF_DataSource_DataVerified]  DEFAULT ((0)) FOR [DataVerified]
END


End
GO
/****** Object:  Default [DF_DataSource_isPerm]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_DataSource_isPerm]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSource]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_DataSource_isPerm]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [DF_DataSource_isPerm]  DEFAULT ('N') FOR [isPerm]
END


End
GO
/****** Object:  Default [DF_DataSource_isMaster]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_DataSource_isMaster]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSource]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_DataSource_isMaster]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [DF_DataSource_isMaster]  DEFAULT ('N') FOR [isMaster]
END


End
GO
/****** Object:  Default [DF_DataSource_CreationDate]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_DataSource_CreationDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSource]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_DataSource_CreationDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [DF_DataSource_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
END


End
GO
/****** Object:  Default [DF_DataSource_isGraphic]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_DataSource_isGraphic]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSource]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_DataSource_isGraphic]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [DF_DataSource_isGraphic]  DEFAULT ('N') FOR [isGraphic]
END


End
GO
/****** Object:  Default [DF_DataSource_isWebPage]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_DataSource_isWebPage]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSource]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_DataSource_isWebPage]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DataSource] ADD  CONSTRAINT [DF_DataSource_isWebPage]  DEFAULT ('N') FOR [isWebPage]
END


End
GO
/****** Object:  Default [DF__DataSourc__check__74EE4BDE]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__DataSourc__check__74EE4BDE]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSourceCheckOut]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__DataSourc__check__74EE4BDE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DataSourceCheckOut] ADD  CONSTRAINT [DF__DataSourc__check__74EE4BDE]  DEFAULT (getdate()) FOR [checkOutDate]
END


End
GO
/****** Object:  Default [DF__DataSourc__Resto__7E77B618]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__DataSourc__Resto__7E77B618]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSourceRestoreHistory]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__DataSourc__Resto__7E77B618]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DataSourceRestoreHistory] ADD  CONSTRAINT [DF__DataSourc__Resto__7E77B618]  DEFAULT (getdate()) FOR [RestoreDate]
END


End
GO
/****** Object:  Default [DF__DataSourc__Creat__7F6BDA51]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__DataSourc__Creat__7F6BDA51]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSourceRestoreHistory]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__DataSourc__Creat__7F6BDA51]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DataSourceRestoreHistory] ADD  CONSTRAINT [DF__DataSourc__Creat__7F6BDA51]  DEFAULT (getdate()) FOR [CreateDate]
END


End
GO
/****** Object:  Default [DF_DataSourceRestoreHistory_VerifiedData]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_DataSourceRestoreHistory_VerifiedData]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSourceRestoreHistory]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_DataSourceRestoreHistory_VerifiedData]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[DataSourceRestoreHistory] ADD  CONSTRAINT [DF_DataSourceRestoreHistory_VerifiedData]  DEFAULT ('N') FOR [VerifiedData]
END


End
GO
/****** Object:  Default [DF_Directory_ckMetaData]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Directory_ckMetaData]') AND parent_object_id = OBJECT_ID(N'[dbo].[Directory]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Directory_ckMetaData]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Directory] ADD  CONSTRAINT [DF_Directory_ckMetaData]  DEFAULT ('N') FOR [ckMetaData]
END


End
GO
/****** Object:  Default [DF_Directory_ckDisableDir]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Directory_ckDisableDir]') AND parent_object_id = OBJECT_ID(N'[dbo].[Directory]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Directory_ckDisableDir]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Directory] ADD  CONSTRAINT [DF_Directory_ckDisableDir]  DEFAULT ('N') FOR [ckDisableDir]
END


End
GO
/****** Object:  Default [DF_Directory_QuickRefEntry]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Directory_QuickRefEntry]') AND parent_object_id = OBJECT_ID(N'[dbo].[Directory]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Directory_QuickRefEntry]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Directory] ADD  CONSTRAINT [DF_Directory_QuickRefEntry]  DEFAULT ((0)) FOR [QuickRefEntry]
END


End
GO
/****** Object:  Default [DF_Directory_isSysDefault]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Directory_isSysDefault]') AND parent_object_id = OBJECT_ID(N'[dbo].[Directory]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Directory_isSysDefault]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Directory] ADD  CONSTRAINT [DF_Directory_isSysDefault]  DEFAULT ((0)) FOR [isSysDefault]
END


End
GO
/****** Object:  Default [UserAuthority]    Script Date: 07/20/2009 10:50:33 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[UserAuthority]') AND parent_object_id = OBJECT_ID(N'[dbo].[EcmUser]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[UserAuthority]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[EcmUser] ADD  CONSTRAINT [UserAuthority]  DEFAULT ('U') FOR [Authority]
END


End
GO
/****** Object:  Default [DF_EcmUser_CreateDate]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_EcmUser_CreateDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[EcmUser]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_EcmUser_CreateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[EcmUser] ADD  CONSTRAINT [DF_EcmUser_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
END


End
GO
/****** Object:  Default [DF__EcmUser__LastUpd__31B762FC]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__EcmUser__LastUpd__31B762FC]') AND parent_object_id = OBJECT_ID(N'[dbo].[EcmUser]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__EcmUser__LastUpd__31B762FC]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[EcmUser] ADD  CONSTRAINT [DF__EcmUser__LastUpd__31B762FC]  DEFAULT (getdate()) FOR [LastUpdate]
END


End
GO
/****** Object:  Default [DF_Email_isPublic]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Email_isPublic]') AND parent_object_id = OBJECT_ID(N'[dbo].[Email]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Email_isPublic]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Email] ADD  CONSTRAINT [DF_Email_isPublic]  DEFAULT ('N') FOR [isPublic]
END


End
GO
/****** Object:  Default [DF_Email_RetentionExpirationDate]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Email_RetentionExpirationDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[Email]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Email_RetentionExpirationDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Email] ADD  CONSTRAINT [DF_Email_RetentionExpirationDate]  DEFAULT (getdate()+(8000)) FOR [RetentionExpirationDate]
END


End
GO
/****** Object:  Default [DF_Email_isAvailable]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Email_isAvailable]') AND parent_object_id = OBJECT_ID(N'[dbo].[Email]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Email_isAvailable]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Email] ADD  CONSTRAINT [DF_Email_isAvailable]  DEFAULT ('Y') FOR [isAvailable]
END


End
GO
/****** Object:  Default [DF_Email_isPerm]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Email_isPerm]') AND parent_object_id = OBJECT_ID(N'[dbo].[Email]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Email_isPerm]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Email] ADD  CONSTRAINT [DF_Email_isPerm]  DEFAULT ('N') FOR [isPerm]
END


End
GO
/****** Object:  Default [DF_Email_isMaster]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Email_isMaster]') AND parent_object_id = OBJECT_ID(N'[dbo].[Email]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Email_isMaster]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Email] ADD  CONSTRAINT [DF_Email_isMaster]  DEFAULT ('N') FOR [isMaster]
END


End
GO
/****** Object:  Default [DF_Email_CreationDate]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Email_CreationDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[Email]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Email_CreationDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Email] ADD  CONSTRAINT [DF_Email_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
END


End
GO
/****** Object:  Default [DF_EmailArchParms_ArchiveOnlyIfRead]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_EmailArchParms_ArchiveOnlyIfRead]') AND parent_object_id = OBJECT_ID(N'[dbo].[EmailArchParms]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_EmailArchParms_ArchiveOnlyIfRead]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[EmailArchParms] ADD  CONSTRAINT [DF_EmailArchParms_ArchiveOnlyIfRead]  DEFAULT ('N') FOR [ArchiveOnlyIfRead]
END


End
GO
/****** Object:  Default [DF_EmailAttachment_AttachmentType]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_EmailAttachment_AttachmentType]') AND parent_object_id = OBJECT_ID(N'[dbo].[EmailAttachment]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_EmailAttachment_AttachmentType]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[EmailAttachment] ADD  CONSTRAINT [DF_EmailAttachment_AttachmentType]  DEFAULT ('.msg') FOR [AttachmentType]
END


End
GO
/****** Object:  Default [DF_EmailFolder_isSysDefulat]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_EmailFolder_isSysDefulat]') AND parent_object_id = OBJECT_ID(N'[dbo].[EmailFolder]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_EmailFolder_isSysDefulat]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[EmailFolder] ADD  CONSTRAINT [DF_EmailFolder_isSysDefulat]  DEFAULT ((0)) FOR [isSysDefault]
END


End
GO
/****** Object:  Default [DF_GlobalSeachResults_Weight]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_GlobalSeachResults_Weight]') AND parent_object_id = OBJECT_ID(N'[dbo].[GlobalSeachResults]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_GlobalSeachResults_Weight]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[GlobalSeachResults] ADD  CONSTRAINT [DF_GlobalSeachResults_Weight]  DEFAULT ((0)) FOR [Weight]
END


End
GO
/****** Object:  Default [DF_HelpText_DisplayHelpText]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_HelpText_DisplayHelpText]') AND parent_object_id = OBJECT_ID(N'[dbo].[HelpText]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HelpText_DisplayHelpText]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HelpText] ADD  CONSTRAINT [DF_HelpText_DisplayHelpText]  DEFAULT ((1)) FOR [DisplayHelpText]
END


End
GO
/****** Object:  Default [DF_HelpText_LastUpdate]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_HelpText_LastUpdate]') AND parent_object_id = OBJECT_ID(N'[dbo].[HelpText]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HelpText_LastUpdate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HelpText] ADD  CONSTRAINT [DF_HelpText_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]
END


End
GO
/****** Object:  Default [DF_HelpText_CreateDate]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_HelpText_CreateDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[HelpText]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HelpText_CreateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HelpText] ADD  CONSTRAINT [DF_HelpText_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
END


End
GO
/****** Object:  Default [DF_HelpText_DisplayHelpTextUsers]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_HelpText_DisplayHelpTextUsers]') AND parent_object_id = OBJECT_ID(N'[dbo].[HelpTextUser]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HelpText_DisplayHelpTextUsers]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HelpTextUser] ADD  CONSTRAINT [DF_HelpText_DisplayHelpTextUsers]  DEFAULT ((1)) FOR [DisplayHelpText]
END


End
GO
/****** Object:  Default [DF_HelpTextUser_LastUpdate]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_HelpTextUser_LastUpdate]') AND parent_object_id = OBJECT_ID(N'[dbo].[HelpTextUser]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HelpTextUser_LastUpdate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HelpTextUser] ADD  CONSTRAINT [DF_HelpTextUser_LastUpdate]  DEFAULT (getdate()) FOR [LastUpdate]
END


End
GO
/****** Object:  Default [DF_HelpTextUser_CreateDate]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_HelpTextUser_CreateDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[HelpTextUser]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_HelpTextUser_CreateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[HelpTextUser] ADD  CONSTRAINT [DF_HelpTextUser_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
END


End
GO
/****** Object:  Default [DF_Library_isPublic]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Library_isPublic]') AND parent_object_id = OBJECT_ID(N'[dbo].[Library]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Library_isPublic]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Library] ADD  CONSTRAINT [DF_Library_isPublic]  DEFAULT ('N') FOR [isPublic]
END


End
GO
/****** Object:  Default [DF__LibraryUs__ReadO__1FD8A9E3]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__LibraryUs__ReadO__1FD8A9E3]') AND parent_object_id = OBJECT_ID(N'[dbo].[LibraryUsers]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__LibraryUs__ReadO__1FD8A9E3]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[LibraryUsers] ADD  CONSTRAINT [DF__LibraryUs__ReadO__1FD8A9E3]  DEFAULT ((0)) FOR [ReadOnly]
END


End
GO
/****** Object:  Default [DF__LibraryUs__Creat__20CCCE1C]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__LibraryUs__Creat__20CCCE1C]') AND parent_object_id = OBJECT_ID(N'[dbo].[LibraryUsers]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__LibraryUs__Creat__20CCCE1C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[LibraryUsers] ADD  CONSTRAINT [DF__LibraryUs__Creat__20CCCE1C]  DEFAULT ((0)) FOR [CreateAccess]
END


End
GO
/****** Object:  Default [DF__LibraryUs__Updat__21C0F255]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__LibraryUs__Updat__21C0F255]') AND parent_object_id = OBJECT_ID(N'[dbo].[LibraryUsers]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__LibraryUs__Updat__21C0F255]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[LibraryUsers] ADD  CONSTRAINT [DF__LibraryUs__Updat__21C0F255]  DEFAULT ((1)) FOR [UpdateAccess]
END


End
GO
/****** Object:  Default [DF__LibraryUs__Delet__22B5168E]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__LibraryUs__Delet__22B5168E]') AND parent_object_id = OBJECT_ID(N'[dbo].[LibraryUsers]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__LibraryUs__Delet__22B5168E]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[LibraryUsers] ADD  CONSTRAINT [DF__LibraryUs__Delet__22B5168E]  DEFAULT ((0)) FOR [DeleteAccess]
END


End
GO
/****** Object:  Default [DF_License_ActivationDate]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_License_ActivationDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[License]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_License_ActivationDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[License] ADD  CONSTRAINT [DF_License_ActivationDate]  DEFAULT (getdate()) FOR [ActivationDate]
END


End
GO
/****** Object:  Default [DF_License_InstallDate]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_License_InstallDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[License]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_License_InstallDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[License] ADD  CONSTRAINT [DF_License_InstallDate]  DEFAULT (getdate()) FOR [InstallDate]
END


End
GO
/****** Object:  Default [DF_OutlookFrom_Verified]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_OutlookFrom_Verified]') AND parent_object_id = OBJECT_ID(N'[dbo].[OutlookFrom]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_OutlookFrom_Verified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OutlookFrom] ADD  CONSTRAINT [DF_OutlookFrom_Verified]  DEFAULT ((1)) FOR [Verified]
END


End
GO
/****** Object:  Default [DF__OwnerHist__Creat__2D67AF2B]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__OwnerHist__Creat__2D67AF2B]') AND parent_object_id = OBJECT_ID(N'[dbo].[OwnerHistory]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__OwnerHist__Creat__2D67AF2B]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OwnerHistory] ADD  CONSTRAINT [DF__OwnerHist__Creat__2D67AF2B]  DEFAULT (getdate()) FOR [CreateDate]
END


End
GO
/****** Object:  Default [DF_PgmTrace_CreateDate]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_PgmTrace_CreateDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[PgmTrace]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_PgmTrace_CreateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[PgmTrace] ADD  CONSTRAINT [DF_PgmTrace_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
END


End
GO
/****** Object:  Default [QDF_Directory_ckMetaData]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[QDF_Directory_ckMetaData]') AND parent_object_id = OBJECT_ID(N'[dbo].[QuickDirectory]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[QDF_Directory_ckMetaData]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[QuickDirectory] ADD  CONSTRAINT [QDF_Directory_ckMetaData]  DEFAULT ('N') FOR [ckMetaData]
END


End
GO
/****** Object:  Default [QDF_Directory_ckDisableDir]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[QDF_Directory_ckDisableDir]') AND parent_object_id = OBJECT_ID(N'[dbo].[QuickDirectory]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[QDF_Directory_ckDisableDir]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[QuickDirectory] ADD  CONSTRAINT [QDF_Directory_ckDisableDir]  DEFAULT ('N') FOR [ckDisableDir]
END


End
GO
/****** Object:  Default [QDF_Directory_QuickRefEntry]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[QDF_Directory_QuickRefEntry]') AND parent_object_id = OBJECT_ID(N'[dbo].[QuickDirectory]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[QDF_Directory_QuickRefEntry]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[QuickDirectory] ADD  CONSTRAINT [QDF_Directory_QuickRefEntry]  DEFAULT ((1)) FOR [QuickRefEntry]
END


End
GO
/****** Object:  Default [DF_QuickRefItems_MarkedForDeletion]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_QuickRefItems_MarkedForDeletion]') AND parent_object_id = OBJECT_ID(N'[dbo].[QuickRefItems]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_QuickRefItems_MarkedForDeletion]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[QuickRefItems] ADD  CONSTRAINT [DF_QuickRefItems_MarkedForDeletion]  DEFAULT ((0)) FOR [MarkedForDeletion]
END


End
GO
/****** Object:  Default [DF_RestorationHistory_RestorationDate]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_RestorationHistory_RestorationDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[RestorationHistory]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_RestorationHistory_RestorationDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[RestorationHistory] ADD  CONSTRAINT [DF_RestorationHistory_RestorationDate]  DEFAULT (getdate()) FOR [RestorationDate]
END


End
GO
/****** Object:  Default [DF_RuntimeErrors_EntryDate]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_RuntimeErrors_EntryDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[RuntimeErrors]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_RuntimeErrors_EntryDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[RuntimeErrors] ADD  CONSTRAINT [DF_RuntimeErrors_EntryDate]  DEFAULT (getdate()) FOR [EntryDate]
END


End
GO
/****** Object:  Default [DF_SearchHistory_SearchDate]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_SearchHistory_SearchDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[SearchHistory]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SearchHistory_SearchDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SearchHistory] ADD  CONSTRAINT [DF_SearchHistory_SearchDate]  DEFAULT (getdate()) FOR [SearchDate]
END


End
GO
/****** Object:  Default [DF_SearhParmsHistory_SearchDate]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_SearhParmsHistory_SearchDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[SearhParmsHistory]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SearhParmsHistory_SearchDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SearhParmsHistory] ADD  CONSTRAINT [DF_SearhParmsHistory_SearchDate]  DEFAULT (getdate()) FOR [SearchDate]
END


End
GO
/****** Object:  Default [FALSE]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[FALSE]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceType]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[FALSE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SourceType] ADD  CONSTRAINT [FALSE]  DEFAULT ((0)) FOR [StoreExternal]
END


End
GO
/****** Object:  Default [TRUE]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[TRUE]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceType]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[TRUE]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SourceType] ADD  CONSTRAINT [TRUE]  DEFAULT ((1)) FOR [Indexable]
END


End
GO
/****** Object:  Default [DF_SubDir_ckDisableDir]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_SubDir_ckDisableDir]') AND parent_object_id = OBJECT_ID(N'[dbo].[SubDir]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SubDir_ckDisableDir]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SubDir] ADD  CONSTRAINT [DF_SubDir_ckDisableDir]  DEFAULT ('N') FOR [ckDisableDir]
END


End
GO
/****** Object:  Default [DF__upgrade_s__statu__5CCD74E1]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF__upgrade_s__statu__5CCD74E1]') AND parent_object_id = OBJECT_ID(N'[dbo].[upgrade_status]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__upgrade_s__statu__5CCD74E1]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[upgrade_status] ADD  DEFAULT ('INCOMPLETE') FOR [status]
END


End
GO
/****** Object:  Default [DF_UserReassignHist_ReassignmentDate]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_UserReassignHist_ReassignmentDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserReassignHist]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_UserReassignHist_ReassignmentDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[UserReassignHist] ADD  CONSTRAINT [DF_UserReassignHist_ReassignmentDate]  DEFAULT (getdate()) FOR [ReassignmentDate]
END


End
GO
/****** Object:  Default [DF_UserReassignHist_RowID]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_UserReassignHist_RowID]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserReassignHist]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_UserReassignHist_RowID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[UserReassignHist] ADD  CONSTRAINT [DF_UserReassignHist_RowID]  DEFAULT (newid()) FOR [RowID]
END


End
GO
/****** Object:  Default [DF_Users_Admin]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Users_Admin]') AND parent_object_id = OBJECT_ID(N'[dbo].[Users]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Users_Admin]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_Admin]  DEFAULT ('U') FOR [Admin]
END


End
GO
/****** Object:  Default [DF_Users_isActive]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_Users_isActive]') AND parent_object_id = OBJECT_ID(N'[dbo].[Users]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Users_isActive]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_isActive]  DEFAULT ('Y') FOR [isActive]
END


End
GO
/****** Object:  Default [CURRDATE_WebSource]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CURRDATE_WebSource]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebSource]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[CURRDATE_WebSource]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WebSource] ADD  CONSTRAINT [CURRDATE_WebSource]  DEFAULT (getdate()) FOR [CreateDate]
END


End
GO
/****** Object:  Default [DF_WebSource_RetentionExpirationDate]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_WebSource_RetentionExpirationDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebSource]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_WebSource_RetentionExpirationDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WebSource] ADD  CONSTRAINT [DF_WebSource_RetentionExpirationDate]  DEFAULT (getdate()+(3650)) FOR [RetentionExpirationDate]
END


End
GO
/****** Object:  Default [DF_WebSource_CreationDate]    Script Date: 07/20/2009 10:50:34 ******/
IF Not EXISTS (SELECT * FROM sys.default_constraints WHERE object_id = OBJECT_ID(N'[dbo].[DF_WebSource_CreationDate]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebSource]'))
Begin
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_WebSource_CreationDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WebSource] ADD  CONSTRAINT [DF_WebSource_CreationDate]  DEFAULT (getdate()) FOR [CreationDate]
END


End
GO
/****** Object:  Check [CK__upgrade_s__statu__5BD950A8]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE object_id = OBJECT_ID(N'[dbo].[CK__upgrade_s__statu__5BD950A8]') AND parent_object_id = OBJECT_ID(N'[dbo].[upgrade_status]'))
ALTER TABLE [dbo].[upgrade_status]  WITH CHECK ADD CHECK  (([status]='COMPLETE' OR [status]='INCOMPLETE'))
GO
/****** Object:  ForeignKey [RefArchiveHist130]    Script Date: 07/20/2009 10:50:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefArchiveHist130]') AND parent_object_id = OBJECT_ID(N'[dbo].[ArchiveHistContentType]'))
ALTER TABLE [dbo].[ArchiveHistContentType]  WITH NOCHECK ADD  CONSTRAINT [RefArchiveHist130] FOREIGN KEY([ArchiveID])
REFERENCES [dbo].[ArchiveHist] ([ArchiveID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefArchiveHist130]') AND parent_object_id = OBJECT_ID(N'[dbo].[ArchiveHistContentType]'))
ALTER TABLE [dbo].[ArchiveHistContentType] CHECK CONSTRAINT [RefArchiveHist130]
GO
/****** Object:  ForeignKey [RefAttributeDatatype129]    Script Date: 07/20/2009 10:50:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefAttributeDatatype129]') AND parent_object_id = OBJECT_ID(N'[dbo].[Attributes]'))
ALTER TABLE [dbo].[Attributes]  WITH CHECK ADD  CONSTRAINT [RefAttributeDatatype129] FOREIGN KEY([AttributeDataType])
REFERENCES [dbo].[AttributeDatatype] ([AttributeDataType])
ON UPDATE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefAttributeDatatype129]') AND parent_object_id = OBJECT_ID(N'[dbo].[Attributes]'))
ALTER TABLE [dbo].[Attributes] CHECK CONSTRAINT [RefAttributeDatatype129]
GO
/****** Object:  ForeignKey [RefCorpFunction30]    Script Date: 07/20/2009 10:50:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCorpFunction30]') AND parent_object_id = OBJECT_ID(N'[dbo].[BusinessFunctionJargon]'))
ALTER TABLE [dbo].[BusinessFunctionJargon]  WITH CHECK ADD  CONSTRAINT [RefCorpFunction30] FOREIGN KEY([CorpFuncName], [CorpName])
REFERENCES [dbo].[CorpFunction] ([CorpFuncName], [CorpName])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCorpFunction30]') AND parent_object_id = OBJECT_ID(N'[dbo].[BusinessFunctionJargon]'))
ALTER TABLE [dbo].[BusinessFunctionJargon] CHECK CONSTRAINT [RefCorpFunction30]
GO
/****** Object:  ForeignKey [RefJargonWords33]    Script Date: 07/20/2009 10:50:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefJargonWords33]') AND parent_object_id = OBJECT_ID(N'[dbo].[BusinessFunctionJargon]'))
ALTER TABLE [dbo].[BusinessFunctionJargon]  WITH CHECK ADD  CONSTRAINT [RefJargonWords33] FOREIGN KEY([JargonCode], [JargonWords_tgtWord])
REFERENCES [dbo].[JargonWords] ([JargonCode], [tgtWord])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefJargonWords33]') AND parent_object_id = OBJECT_ID(N'[dbo].[BusinessFunctionJargon]'))
ALTER TABLE [dbo].[BusinessFunctionJargon] CHECK CONSTRAINT [RefJargonWords33]
GO
/****** Object:  ForeignKey [RefSourceContainer18]    Script Date: 07/20/2009 10:50:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSourceContainer18]') AND parent_object_id = OBJECT_ID(N'[dbo].[ContainerStorage]'))
ALTER TABLE [dbo].[ContainerStorage]  WITH CHECK ADD  CONSTRAINT [RefSourceContainer18] FOREIGN KEY([ContainerType])
REFERENCES [dbo].[SourceContainer] ([ContainerType])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSourceContainer18]') AND parent_object_id = OBJECT_ID(N'[dbo].[ContainerStorage]'))
ALTER TABLE [dbo].[ContainerStorage] CHECK CONSTRAINT [RefSourceContainer18]
GO
/****** Object:  ForeignKey [RefStorage17]    Script Date: 07/20/2009 10:50:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefStorage17]') AND parent_object_id = OBJECT_ID(N'[dbo].[ContainerStorage]'))
ALTER TABLE [dbo].[ContainerStorage]  WITH CHECK ADD  CONSTRAINT [RefStorage17] FOREIGN KEY([StoreCode])
REFERENCES [dbo].[Storage] ([StoreCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefStorage17]') AND parent_object_id = OBJECT_ID(N'[dbo].[ContainerStorage]'))
ALTER TABLE [dbo].[ContainerStorage] CHECK CONSTRAINT [RefStorage17]
GO
/****** Object:  ForeignKey [RefCorporation38]    Script Date: 07/20/2009 10:50:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCorporation38]') AND parent_object_id = OBJECT_ID(N'[dbo].[ConvertedDocs]'))
ALTER TABLE [dbo].[ConvertedDocs]  WITH CHECK ADD  CONSTRAINT [RefCorporation38] FOREIGN KEY([CorpName])
REFERENCES [dbo].[Corporation] ([CorpName])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCorporation38]') AND parent_object_id = OBJECT_ID(N'[dbo].[ConvertedDocs]'))
ALTER TABLE [dbo].[ConvertedDocs] CHECK CONSTRAINT [RefCorporation38]
GO
/****** Object:  ForeignKey [RefUsers86]    Script Date: 07/20/2009 10:50:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUsers86]') AND parent_object_id = OBJECT_ID(N'[dbo].[CoOwner]'))
ALTER TABLE [dbo].[CoOwner]  WITH CHECK ADD  CONSTRAINT [RefUsers86] FOREIGN KEY([PreviousOwnerUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUsers86]') AND parent_object_id = OBJECT_ID(N'[dbo].[CoOwner]'))
ALTER TABLE [dbo].[CoOwner] CHECK CONSTRAINT [RefUsers86]
GO
/****** Object:  ForeignKey [RefUsers87]    Script Date: 07/20/2009 10:50:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUsers87]') AND parent_object_id = OBJECT_ID(N'[dbo].[CoOwner]'))
ALTER TABLE [dbo].[CoOwner]  WITH CHECK ADD  CONSTRAINT [RefUsers87] FOREIGN KEY([CurrentOwnerUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUsers87]') AND parent_object_id = OBJECT_ID(N'[dbo].[CoOwner]'))
ALTER TABLE [dbo].[CoOwner] CHECK CONSTRAINT [RefUsers87]
GO
/****** Object:  ForeignKey [RefCorpFunction24]    Script Date: 07/20/2009 10:50:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCorpFunction24]') AND parent_object_id = OBJECT_ID(N'[dbo].[CorpContainer]'))
ALTER TABLE [dbo].[CorpContainer]  WITH CHECK ADD  CONSTRAINT [RefCorpFunction24] FOREIGN KEY([CorpFuncName], [CorpName])
REFERENCES [dbo].[CorpFunction] ([CorpFuncName], [CorpName])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCorpFunction24]') AND parent_object_id = OBJECT_ID(N'[dbo].[CorpContainer]'))
ALTER TABLE [dbo].[CorpContainer] CHECK CONSTRAINT [RefCorpFunction24]
GO
/****** Object:  ForeignKey [RefQtyDocs10]    Script Date: 07/20/2009 10:50:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefQtyDocs10]') AND parent_object_id = OBJECT_ID(N'[dbo].[CorpContainer]'))
ALTER TABLE [dbo].[CorpContainer]  WITH CHECK ADD  CONSTRAINT [RefQtyDocs10] FOREIGN KEY([QtyDocCode])
REFERENCES [dbo].[QtyDocs] ([QtyDocCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefQtyDocs10]') AND parent_object_id = OBJECT_ID(N'[dbo].[CorpContainer]'))
ALTER TABLE [dbo].[CorpContainer] CHECK CONSTRAINT [RefQtyDocs10]
GO
/****** Object:  ForeignKey [RefSourceContainer2]    Script Date: 07/20/2009 10:50:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSourceContainer2]') AND parent_object_id = OBJECT_ID(N'[dbo].[CorpContainer]'))
ALTER TABLE [dbo].[CorpContainer]  WITH CHECK ADD  CONSTRAINT [RefSourceContainer2] FOREIGN KEY([ContainerType])
REFERENCES [dbo].[SourceContainer] ([ContainerType])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSourceContainer2]') AND parent_object_id = OBJECT_ID(N'[dbo].[CorpContainer]'))
ALTER TABLE [dbo].[CorpContainer] CHECK CONSTRAINT [RefSourceContainer2]
GO
/****** Object:  ForeignKey [RefCorporation37]    Script Date: 07/20/2009 10:50:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCorporation37]') AND parent_object_id = OBJECT_ID(N'[dbo].[CorpFunction]'))
ALTER TABLE [dbo].[CorpFunction]  WITH CHECK ADD  CONSTRAINT [RefCorporation37] FOREIGN KEY([CorpName])
REFERENCES [dbo].[Corporation] ([CorpName])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCorporation37]') AND parent_object_id = OBJECT_ID(N'[dbo].[CorpFunction]'))
ALTER TABLE [dbo].[CorpFunction] CHECK CONSTRAINT [RefCorporation37]
GO
/****** Object:  ForeignKey [RefDataSource89]    Script Date: 07/20/2009 10:50:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefDataSource89]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSourceCheckOut]'))
ALTER TABLE [dbo].[DataSourceCheckOut]  WITH CHECK ADD  CONSTRAINT [RefDataSource89] FOREIGN KEY([SourceGuid], [DataSourceOwnerUserID])
REFERENCES [dbo].[DataSource] ([SourceGuid], [DataSourceOwnerUserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefDataSource89]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSourceCheckOut]'))
ALTER TABLE [dbo].[DataSourceCheckOut] CHECK CONSTRAINT [RefDataSource89]
GO
/****** Object:  ForeignKey [RefUsers90]    Script Date: 07/20/2009 10:50:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUsers90]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSourceCheckOut]'))
ALTER TABLE [dbo].[DataSourceCheckOut]  WITH CHECK ADD  CONSTRAINT [RefUsers90] FOREIGN KEY([CheckedOutByUserID])
REFERENCES [dbo].[Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUsers90]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSourceCheckOut]'))
ALTER TABLE [dbo].[DataSourceCheckOut] CHECK CONSTRAINT [RefUsers90]
GO
/****** Object:  ForeignKey [RefDataSource91]    Script Date: 07/20/2009 10:50:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefDataSource91]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSourceRestoreHistory]'))
ALTER TABLE [dbo].[DataSourceRestoreHistory]  WITH CHECK ADD  CONSTRAINT [RefDataSource91] FOREIGN KEY([SourceGuid], [DataSourceOwnerUserID])
REFERENCES [dbo].[DataSource] ([SourceGuid], [DataSourceOwnerUserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefDataSource91]') AND parent_object_id = OBJECT_ID(N'[dbo].[DataSourceRestoreHistory]'))
ALTER TABLE [dbo].[DataSourceRestoreHistory] CHECK CONSTRAINT [RefDataSource91]
GO
/****** Object:  ForeignKey [RefDatabases5]    Script Date: 07/20/2009 10:50:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefDatabases5]') AND parent_object_id = OBJECT_ID(N'[dbo].[Directory]'))
ALTER TABLE [dbo].[Directory]  WITH CHECK ADD  CONSTRAINT [RefDatabases5] FOREIGN KEY([DB_ID])
REFERENCES [dbo].[Databases] ([DB_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefDatabases5]') AND parent_object_id = OBJECT_ID(N'[dbo].[Directory]'))
ALTER TABLE [dbo].[Directory] CHECK CONSTRAINT [RefDatabases5]
GO
/****** Object:  ForeignKey [RefUsers3]    Script Date: 07/20/2009 10:50:33 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUsers3]') AND parent_object_id = OBJECT_ID(N'[dbo].[Directory]'))
ALTER TABLE [dbo].[Directory]  WITH CHECK ADD  CONSTRAINT [RefUsers3] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUsers3]') AND parent_object_id = OBJECT_ID(N'[dbo].[Directory]'))
ALTER TABLE [dbo].[Directory] CHECK CONSTRAINT [RefUsers3]
GO
/****** Object:  ForeignKey [RefDatabases8]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefDatabases8]') AND parent_object_id = OBJECT_ID(N'[dbo].[EmailArchParms]'))
ALTER TABLE [dbo].[EmailArchParms]  WITH CHECK ADD  CONSTRAINT [RefDatabases8] FOREIGN KEY([DB_ID])
REFERENCES [dbo].[Databases] ([DB_ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefDatabases8]') AND parent_object_id = OBJECT_ID(N'[dbo].[EmailArchParms]'))
ALTER TABLE [dbo].[EmailArchParms] CHECK CONSTRAINT [RefDatabases8]
GO
/****** Object:  ForeignKey [RefUsers4]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUsers4]') AND parent_object_id = OBJECT_ID(N'[dbo].[EmailArchParms]'))
ALTER TABLE [dbo].[EmailArchParms]  WITH CHECK ADD  CONSTRAINT [RefUsers4] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUsers4]') AND parent_object_id = OBJECT_ID(N'[dbo].[EmailArchParms]'))
ALTER TABLE [dbo].[EmailArchParms] CHECK CONSTRAINT [RefUsers4]
GO
/****** Object:  ForeignKey [RefEmail66]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefEmail66]') AND parent_object_id = OBJECT_ID(N'[dbo].[EmailAttachment]'))
ALTER TABLE [dbo].[EmailAttachment]  WITH CHECK ADD  CONSTRAINT [RefEmail66] FOREIGN KEY([EmailGuid])
REFERENCES [dbo].[Email] ([EmailGuid])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefEmail66]') AND parent_object_id = OBJECT_ID(N'[dbo].[EmailAttachment]'))
ALTER TABLE [dbo].[EmailAttachment] CHECK CONSTRAINT [RefEmail66]
GO
/****** Object:  ForeignKey [RefUsers84]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUsers84]') AND parent_object_id = OBJECT_ID(N'[dbo].[EmailAttachment]'))
ALTER TABLE [dbo].[EmailAttachment]  WITH CHECK ADD  CONSTRAINT [RefUsers84] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUsers84]') AND parent_object_id = OBJECT_ID(N'[dbo].[EmailAttachment]'))
ALTER TABLE [dbo].[EmailAttachment] CHECK CONSTRAINT [RefUsers84]
GO
/****** Object:  ForeignKey [RefEmail69]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefEmail69]') AND parent_object_id = OBJECT_ID(N'[dbo].[EmailAttachmentSearchList]'))
ALTER TABLE [dbo].[EmailAttachmentSearchList]  WITH CHECK ADD  CONSTRAINT [RefEmail69] FOREIGN KEY([EmailGuid])
REFERENCES [dbo].[Email] ([EmailGuid])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefEmail69]') AND parent_object_id = OBJECT_ID(N'[dbo].[EmailAttachmentSearchList]'))
ALTER TABLE [dbo].[EmailAttachmentSearchList] CHECK CONSTRAINT [RefEmail69]
GO
/****** Object:  ForeignKey [RefUsers82]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUsers82]') AND parent_object_id = OBJECT_ID(N'[dbo].[EmailAttachmentSearchList]'))
ALTER TABLE [dbo].[EmailAttachmentSearchList]  WITH CHECK ADD  CONSTRAINT [RefUsers82] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUsers82]') AND parent_object_id = OBJECT_ID(N'[dbo].[EmailAttachmentSearchList]'))
ALTER TABLE [dbo].[EmailAttachmentSearchList] CHECK CONSTRAINT [RefUsers82]
GO
/****** Object:  ForeignKey [RefCorpFunction34]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCorpFunction34]') AND parent_object_id = OBJECT_ID(N'[dbo].[FUncSkipWords]'))
ALTER TABLE [dbo].[FUncSkipWords]  WITH CHECK ADD  CONSTRAINT [RefCorpFunction34] FOREIGN KEY([CorpFuncName], [CorpName])
REFERENCES [dbo].[CorpFunction] ([CorpFuncName], [CorpName])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCorpFunction34]') AND parent_object_id = OBJECT_ID(N'[dbo].[FUncSkipWords]'))
ALTER TABLE [dbo].[FUncSkipWords] CHECK CONSTRAINT [RefCorpFunction34]
GO
/****** Object:  ForeignKey [RefSkipWords35]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSkipWords35]') AND parent_object_id = OBJECT_ID(N'[dbo].[FUncSkipWords]'))
ALTER TABLE [dbo].[FUncSkipWords]  WITH CHECK ADD  CONSTRAINT [RefSkipWords35] FOREIGN KEY([tgtWord])
REFERENCES [dbo].[SkipWords] ([tgtWord])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSkipWords35]') AND parent_object_id = OBJECT_ID(N'[dbo].[FUncSkipWords]'))
ALTER TABLE [dbo].[FUncSkipWords] CHECK CONSTRAINT [RefSkipWords35]
GO
/****** Object:  ForeignKey [RefBusinessJargonCode29]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefBusinessJargonCode29]') AND parent_object_id = OBJECT_ID(N'[dbo].[FunctionProdJargon]'))
ALTER TABLE [dbo].[FunctionProdJargon]  WITH CHECK ADD  CONSTRAINT [RefBusinessJargonCode29] FOREIGN KEY([JargonCode])
REFERENCES [dbo].[BusinessJargonCode] ([JargonCode])
ON UPDATE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefBusinessJargonCode29]') AND parent_object_id = OBJECT_ID(N'[dbo].[FunctionProdJargon]'))
ALTER TABLE [dbo].[FunctionProdJargon] CHECK CONSTRAINT [RefBusinessJargonCode29]
GO
/****** Object:  ForeignKey [RefCorpFunction28]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCorpFunction28]') AND parent_object_id = OBJECT_ID(N'[dbo].[FunctionProdJargon]'))
ALTER TABLE [dbo].[FunctionProdJargon]  WITH CHECK ADD  CONSTRAINT [RefCorpFunction28] FOREIGN KEY([CorpFuncName], [CorpName])
REFERENCES [dbo].[CorpFunction] ([CorpFuncName], [CorpName])
ON UPDATE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCorpFunction28]') AND parent_object_id = OBJECT_ID(N'[dbo].[FunctionProdJargon]'))
ALTER TABLE [dbo].[FunctionProdJargon] CHECK CONSTRAINT [RefCorpFunction28]
GO
/****** Object:  ForeignKey [RefRepeatData15]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefRepeatData15]') AND parent_object_id = OBJECT_ID(N'[dbo].[FunctionProdJargon]'))
ALTER TABLE [dbo].[FunctionProdJargon]  WITH CHECK ADD  CONSTRAINT [RefRepeatData15] FOREIGN KEY([RepeatDataCode])
REFERENCES [dbo].[RepeatData] ([RepeatDataCode])
ON UPDATE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefRepeatData15]') AND parent_object_id = OBJECT_ID(N'[dbo].[FunctionProdJargon]'))
ALTER TABLE [dbo].[FunctionProdJargon] CHECK CONSTRAINT [RefRepeatData15]
GO
/****** Object:  ForeignKey [LibraryOwnerUserID]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[LibraryOwnerUserID]') AND parent_object_id = OBJECT_ID(N'[dbo].[GroupLibraryAccess]'))
ALTER TABLE [dbo].[GroupLibraryAccess]  WITH CHECK ADD  CONSTRAINT [LibraryOwnerUserID] FOREIGN KEY([UserID], [LibraryName])
REFERENCES [dbo].[Library] ([UserID], [LibraryName])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[LibraryOwnerUserID]') AND parent_object_id = OBJECT_ID(N'[dbo].[GroupLibraryAccess]'))
ALTER TABLE [dbo].[GroupLibraryAccess] CHECK CONSTRAINT [LibraryOwnerUserID]
GO
/****** Object:  ForeignKey [RefUserGroup64]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUserGroup64]') AND parent_object_id = OBJECT_ID(N'[dbo].[GroupLibraryAccess]'))
ALTER TABLE [dbo].[GroupLibraryAccess]  WITH CHECK ADD  CONSTRAINT [RefUserGroup64] FOREIGN KEY([GroupOwnerUserID], [GroupName])
REFERENCES [dbo].[UserGroup] ([GroupOwnerUserID], [GroupName])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUserGroup64]') AND parent_object_id = OBJECT_ID(N'[dbo].[GroupLibraryAccess]'))
ALTER TABLE [dbo].[GroupLibraryAccess] CHECK CONSTRAINT [RefUserGroup64]
GO
/****** Object:  ForeignKey [RefUsers52]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUsers52]') AND parent_object_id = OBJECT_ID(N'[dbo].[GroupUsers]'))
ALTER TABLE [dbo].[GroupUsers]  WITH CHECK ADD  CONSTRAINT [RefUsers52] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUsers52]') AND parent_object_id = OBJECT_ID(N'[dbo].[GroupUsers]'))
ALTER TABLE [dbo].[GroupUsers] CHECK CONSTRAINT [RefUsers52]
GO
/****** Object:  ForeignKey [RefCorpContainer25]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCorpContainer25]') AND parent_object_id = OBJECT_ID(N'[dbo].[InformationProduct]'))
ALTER TABLE [dbo].[InformationProduct]  WITH CHECK ADD  CONSTRAINT [RefCorpContainer25] FOREIGN KEY([ContainerType], [CorpFuncName], [CorpName])
REFERENCES [dbo].[CorpContainer] ([ContainerType], [CorpFuncName], [CorpName])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCorpContainer25]') AND parent_object_id = OBJECT_ID(N'[dbo].[InformationProduct]'))
ALTER TABLE [dbo].[InformationProduct] CHECK CONSTRAINT [RefCorpContainer25]
GO
/****** Object:  ForeignKey [RefInformationType36]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefInformationType36]') AND parent_object_id = OBJECT_ID(N'[dbo].[InformationProduct]'))
ALTER TABLE [dbo].[InformationProduct]  WITH CHECK ADD  CONSTRAINT [RefInformationType36] FOREIGN KEY([InfoTypeCode])
REFERENCES [dbo].[InformationType] ([InfoTypeCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefInformationType36]') AND parent_object_id = OBJECT_ID(N'[dbo].[InformationProduct]'))
ALTER TABLE [dbo].[InformationProduct] CHECK CONSTRAINT [RefInformationType36]
GO
/****** Object:  ForeignKey [RefRetention16]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefRetention16]') AND parent_object_id = OBJECT_ID(N'[dbo].[InformationProduct]'))
ALTER TABLE [dbo].[InformationProduct]  WITH CHECK ADD  CONSTRAINT [RefRetention16] FOREIGN KEY([RetentionCode])
REFERENCES [dbo].[Retention] ([RetentionCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefRetention16]') AND parent_object_id = OBJECT_ID(N'[dbo].[InformationProduct]'))
ALTER TABLE [dbo].[InformationProduct] CHECK CONSTRAINT [RefRetention16]
GO
/****** Object:  ForeignKey [RefUD_Qty7]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUD_Qty7]') AND parent_object_id = OBJECT_ID(N'[dbo].[InformationProduct]'))
ALTER TABLE [dbo].[InformationProduct]  WITH CHECK ADD  CONSTRAINT [RefUD_Qty7] FOREIGN KEY([Code])
REFERENCES [dbo].[UD_Qty] ([Code])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUD_Qty7]') AND parent_object_id = OBJECT_ID(N'[dbo].[InformationProduct]'))
ALTER TABLE [dbo].[InformationProduct] CHECK CONSTRAINT [RefUD_Qty7]
GO
/****** Object:  ForeignKey [RefVolitility19]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefVolitility19]') AND parent_object_id = OBJECT_ID(N'[dbo].[InformationProduct]'))
ALTER TABLE [dbo].[InformationProduct]  WITH CHECK ADD  CONSTRAINT [RefVolitility19] FOREIGN KEY([VolitilityCode])
REFERENCES [dbo].[Volitility] ([VolitilityCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefVolitility19]') AND parent_object_id = OBJECT_ID(N'[dbo].[InformationProduct]'))
ALTER TABLE [dbo].[InformationProduct] CHECK CONSTRAINT [RefVolitility19]
GO
/****** Object:  ForeignKey [RefBusinessJargonCode27]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefBusinessJargonCode27]') AND parent_object_id = OBJECT_ID(N'[dbo].[JargonWords]'))
ALTER TABLE [dbo].[JargonWords]  WITH CHECK ADD  CONSTRAINT [RefBusinessJargonCode27] FOREIGN KEY([JargonCode])
REFERENCES [dbo].[BusinessJargonCode] ([JargonCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefBusinessJargonCode27]') AND parent_object_id = OBJECT_ID(N'[dbo].[JargonWords]'))
ALTER TABLE [dbo].[JargonWords] CHECK CONSTRAINT [RefBusinessJargonCode27]
GO
/****** Object:  ForeignKey [RefLibrary124]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefLibrary124]') AND parent_object_id = OBJECT_ID(N'[dbo].[LibDirectory]'))
ALTER TABLE [dbo].[LibDirectory]  WITH CHECK ADD  CONSTRAINT [RefLibrary124] FOREIGN KEY([UserID], [LibraryName])
REFERENCES [dbo].[Library] ([UserID], [LibraryName])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefLibrary124]') AND parent_object_id = OBJECT_ID(N'[dbo].[LibDirectory]'))
ALTER TABLE [dbo].[LibDirectory] CHECK CONSTRAINT [RefLibrary124]
GO
/****** Object:  ForeignKey [RefLibrary123]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefLibrary123]') AND parent_object_id = OBJECT_ID(N'[dbo].[LibEmail]'))
ALTER TABLE [dbo].[LibEmail]  WITH CHECK ADD  CONSTRAINT [RefLibrary123] FOREIGN KEY([UserID], [LibraryName])
REFERENCES [dbo].[Library] ([UserID], [LibraryName])
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefLibrary123]') AND parent_object_id = OBJECT_ID(N'[dbo].[LibEmail]'))
ALTER TABLE [dbo].[LibEmail] CHECK CONSTRAINT [RefLibrary123]
GO
/****** Object:  ForeignKey [FK__Library__UserID__1BB31344]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Library__UserID__1BB31344]') AND parent_object_id = OBJECT_ID(N'[dbo].[Library]'))
ALTER TABLE [dbo].[Library]  WITH CHECK ADD  CONSTRAINT [FK__Library__UserID__1BB31344] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__Library__UserID__1BB31344]') AND parent_object_id = OBJECT_ID(N'[dbo].[Library]'))
ALTER TABLE [dbo].[Library] CHECK CONSTRAINT [FK__Library__UserID__1BB31344]
GO
/****** Object:  ForeignKey [RefUsers99]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUsers99]') AND parent_object_id = OBJECT_ID(N'[dbo].[LibraryUsers]'))
ALTER TABLE [dbo].[LibraryUsers]  WITH CHECK ADD  CONSTRAINT [RefUsers99] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUsers99]') AND parent_object_id = OBJECT_ID(N'[dbo].[LibraryUsers]'))
ALTER TABLE [dbo].[LibraryUsers] CHECK CONSTRAINT [RefUsers99]
GO
/****** Object:  ForeignKey [RefLoadProfile1271]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefLoadProfile1271]') AND parent_object_id = OBJECT_ID(N'[dbo].[LoadProfileItem]'))
ALTER TABLE [dbo].[LoadProfileItem]  WITH CHECK ADD  CONSTRAINT [RefLoadProfile1271] FOREIGN KEY([ProfileName])
REFERENCES [dbo].[LoadProfile] ([ProfileName])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefLoadProfile1271]') AND parent_object_id = OBJECT_ID(N'[dbo].[LoadProfileItem]'))
ALTER TABLE [dbo].[LoadProfileItem] CHECK CONSTRAINT [RefLoadProfile1271]
GO
/****** Object:  ForeignKey [RefSourceType1281]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSourceType1281]') AND parent_object_id = OBJECT_ID(N'[dbo].[LoadProfileItem]'))
ALTER TABLE [dbo].[LoadProfileItem]  WITH CHECK ADD  CONSTRAINT [RefSourceType1281] FOREIGN KEY([SourceTypeCode])
REFERENCES [dbo].[SourceType] ([SourceTypeCode])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefSourceType1281]') AND parent_object_id = OBJECT_ID(N'[dbo].[LoadProfileItem]'))
ALTER TABLE [dbo].[LoadProfileItem] CHECK CONSTRAINT [RefSourceType1281]
GO
/****** Object:  ForeignKey [CurrentOwnerUserID]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[CurrentOwnerUserID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OwnerHistory]'))
ALTER TABLE [dbo].[OwnerHistory]  WITH CHECK ADD  CONSTRAINT [CurrentOwnerUserID] FOREIGN KEY([CurrentOwnerUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[CurrentOwnerUserID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OwnerHistory]'))
ALTER TABLE [dbo].[OwnerHistory] CHECK CONSTRAINT [CurrentOwnerUserID]
GO
/****** Object:  ForeignKey [PreviousOwnerUserID]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[PreviousOwnerUserID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OwnerHistory]'))
ALTER TABLE [dbo].[OwnerHistory]  WITH CHECK ADD  CONSTRAINT [PreviousOwnerUserID] FOREIGN KEY([PreviousOwnerUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[PreviousOwnerUserID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OwnerHistory]'))
ALTER TABLE [dbo].[OwnerHistory] CHECK CONSTRAINT [PreviousOwnerUserID]
GO
/****** Object:  ForeignKey [RefCaptureItems22]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCaptureItems22]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProdCaptureItems]'))
ALTER TABLE [dbo].[ProdCaptureItems]  WITH CHECK ADD  CONSTRAINT [RefCaptureItems22] FOREIGN KEY([CaptureItemsCode])
REFERENCES [dbo].[CaptureItems] ([CaptureItemsCode])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefCaptureItems22]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProdCaptureItems]'))
ALTER TABLE [dbo].[ProdCaptureItems] CHECK CONSTRAINT [RefCaptureItems22]
GO
/****** Object:  ForeignKey [RefInformationProduct21]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefInformationProduct21]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProdCaptureItems]'))
ALTER TABLE [dbo].[ProdCaptureItems]  WITH CHECK ADD  CONSTRAINT [RefInformationProduct21] FOREIGN KEY([ContainerType], [CorpFuncName], [CorpName])
REFERENCES [dbo].[InformationProduct] ([ContainerType], [CorpFuncName], [CorpName])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefInformationProduct21]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProdCaptureItems]'))
ALTER TABLE [dbo].[ProdCaptureItems] CHECK CONSTRAINT [RefInformationProduct21]
GO
/****** Object:  ForeignKey [RefUsers112]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUsers112]') AND parent_object_id = OBJECT_ID(N'[dbo].[QuickRef]'))
ALTER TABLE [dbo].[QuickRef]  WITH CHECK ADD  CONSTRAINT [RefUsers112] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefUsers112]') AND parent_object_id = OBJECT_ID(N'[dbo].[QuickRef]'))
ALTER TABLE [dbo].[QuickRef] CHECK CONSTRAINT [RefUsers112]
GO
/****** Object:  ForeignKey [RefQuickRef115]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefQuickRef115]') AND parent_object_id = OBJECT_ID(N'[dbo].[QuickRefItems]'))
ALTER TABLE [dbo].[QuickRefItems]  WITH CHECK ADD  CONSTRAINT [RefQuickRef115] FOREIGN KEY([QuickRefIdNbr])
REFERENCES [dbo].[QuickRef] ([QuickRefIdNbr])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefQuickRef115]') AND parent_object_id = OBJECT_ID(N'[dbo].[QuickRefItems]'))
ALTER TABLE [dbo].[QuickRefItems] CHECK CONSTRAINT [RefQuickRef115]
GO
/****** Object:  ForeignKey [RefEmail42]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefEmail42]') AND parent_object_id = OBJECT_ID(N'[dbo].[Recipients]'))
ALTER TABLE [dbo].[Recipients]  WITH CHECK ADD  CONSTRAINT [RefEmail42] FOREIGN KEY([EmailGuid])
REFERENCES [dbo].[Email] ([EmailGuid])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefEmail42]') AND parent_object_id = OBJECT_ID(N'[dbo].[Recipients]'))
ALTER TABLE [dbo].[Recipients] CHECK CONSTRAINT [RefEmail42]
GO
/****** Object:  ForeignKey [RefAtribute45]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefAtribute45]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceAttribute]'))
ALTER TABLE [dbo].[SourceAttribute]  WITH NOCHECK ADD  CONSTRAINT [RefAtribute45] FOREIGN KEY([AttributeName])
REFERENCES [dbo].[Attributes] ([AttributeName])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefAtribute45]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceAttribute]'))
ALTER TABLE [dbo].[SourceAttribute] CHECK CONSTRAINT [RefAtribute45]
GO
/****** Object:  ForeignKey [RefDirectory15]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefDirectory15]') AND parent_object_id = OBJECT_ID(N'[dbo].[SubDir]'))
ALTER TABLE [dbo].[SubDir]  WITH CHECK ADD  CONSTRAINT [RefDirectory15] FOREIGN KEY([UserID], [FQN])
REFERENCES [dbo].[Directory] ([UserID], [FQN])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefDirectory15]') AND parent_object_id = OBJECT_ID(N'[dbo].[SubDir]'))
ALTER TABLE [dbo].[SubDir] CHECK CONSTRAINT [RefDirectory15]
GO
/****** Object:  ForeignKey [FK__SubLibrary__4BB72C21]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SubLibrary__4BB72C21]') AND parent_object_id = OBJECT_ID(N'[dbo].[SubLibrary]'))
ALTER TABLE [dbo].[SubLibrary]  WITH CHECK ADD  CONSTRAINT [FK__SubLibrary__4BB72C21] FOREIGN KEY([SubUserID], [SubLibraryName])
REFERENCES [dbo].[Library] ([UserID], [LibraryName])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SubLibrary__4BB72C21]') AND parent_object_id = OBJECT_ID(N'[dbo].[SubLibrary]'))
ALTER TABLE [dbo].[SubLibrary] CHECK CONSTRAINT [FK__SubLibrary__4BB72C21]
GO
/****** Object:  ForeignKey [FK__SubLibrary__4CAB505A]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SubLibrary__4CAB505A]') AND parent_object_id = OBJECT_ID(N'[dbo].[SubLibrary]'))
ALTER TABLE [dbo].[SubLibrary]  WITH CHECK ADD  CONSTRAINT [FK__SubLibrary__4CAB505A] FOREIGN KEY([UserID], [LibraryName])
REFERENCES [dbo].[Library] ([UserID], [LibraryName])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__SubLibrary__4CAB505A]') AND parent_object_id = OBJECT_ID(N'[dbo].[SubLibrary]'))
ALTER TABLE [dbo].[SubLibrary] CHECK CONSTRAINT [FK__SubLibrary__4CAB505A]
GO
/****** Object:  ForeignKey [FK__UserGroup__Group__2077C861]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__UserGroup__Group__2077C861]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserGroup]'))
ALTER TABLE [dbo].[UserGroup]  WITH CHECK ADD  CONSTRAINT [FK__UserGroup__Group__2077C861] FOREIGN KEY([GroupOwnerUserID])
REFERENCES [dbo].[Users] ([UserID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK__UserGroup__Group__2077C861]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserGroup]'))
ALTER TABLE [dbo].[UserGroup] CHECK CONSTRAINT [FK__UserGroup__Group__2077C861]
GO
/****** Object:  ForeignKey [RefDataSource100]    Script Date: 07/20/2009 10:50:34 ******/
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefDataSource100]') AND parent_object_id = OBJECT_ID(N'[dbo].[ZippedFiles]'))
ALTER TABLE [dbo].[ZippedFiles]  WITH CHECK ADD  CONSTRAINT [RefDataSource100] FOREIGN KEY([SourceGuid], [DataSourceOwnerUserID])
REFERENCES [dbo].[DataSource] ([SourceGuid], [DataSourceOwnerUserID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefDataSource100]') AND parent_object_id = OBJECT_ID(N'[dbo].[ZippedFiles]'))
ALTER TABLE [dbo].[ZippedFiles] CHECK CONSTRAINT [RefDataSource100]
GO


IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[RefAtribute45]') AND parent_object_id = OBJECT_ID(N'[dbo].[SourceAttribute]'))
ALTER TABLE [dbo].[SourceAttribute] DROP CONSTRAINT [RefAtribute45]
GO



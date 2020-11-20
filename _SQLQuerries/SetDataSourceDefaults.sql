--select top 10 * from DataSOurce;

ALTER TABLE Datasource ADD CONSTRAINT def_CreationDate DEFAULT GETDATE() FOR CreationDate
go
ALTER TABLE Datasource ADD CONSTRAINT def_VersionNbr DEFAULT 4 FOR [VersionNbr]
go
ALTER TABLE Datasource ADD CONSTRAINT def_IsPublicPreviousState DEFAULT 'Y' FOR [IsPublicPreviousState]
go
ALTER TABLE Datasource ADD CONSTRAINT def_isAvailable DEFAULT 'Y' FOR isAvailable
go
ALTER TABLE Datasource ADD CONSTRAINT def_isContainedWithinZipFile DEFAULT 'N' FOR isContainedWithinZipFile
go
ALTER TABLE Datasource ADD CONSTRAINT def_DataVerified DEFAULT 0 FOR DataVerified
go
ALTER TABLE Datasource ADD CONSTRAINT def_SharePoint DEFAULT 0 FOR SharePoint
go
ALTER TABLE Datasource ADD CONSTRAINT def_SharePointDoc DEFAULT 0 FOR SharePointDoc
go
ALTER TABLE Datasource ADD CONSTRAINT def_SharePointList DEFAULT 0 FOR SharePointList
go
ALTER TABLE Datasource ADD CONSTRAINT def_SharePointListItem DEFAULT 0 FOR SharePointListItem
go
ALTER TABLE Datasource ADD CONSTRAINT def_StructuredData DEFAULT 0 FOR StructuredData
go
ALTER TABLE Datasource ADD CONSTRAINT def_HiveConnectionName DEFAULT 'NA' FOR HiveConnectionName
go
ALTER TABLE Datasource ADD CONSTRAINT def_HiveActive DEFAULT 0 FOR HiveActive
go
ALTER TABLE Datasource ADD CONSTRAINT def_RepoSvrName DEFAULT @@ServerName FOR RepoSvrName
go
ALTER TABLE Datasource ADD CONSTRAINT def_ContainedWithin DEFAULT 'NA' FOR ContainedWithin
go
ALTER TABLE Datasource ADD CONSTRAINT def_StructuredData DEFAULT 0 FOR StructuredData
go
ALTER TABLE Datasource ADD CONSTRAINT def_RepoName DEFAULT @@ServerName FOR RepoName
go
ALTER TABLE Datasource ADD CONSTRAINT def_HashName DEFAULT 'SHA512' FOR HashName
go
ALTER TABLE Datasource ADD CONSTRAINT def_isPublic DEFAULT 'N' FOR isPublic
GO
ALTER TABLE Datasource ADD CONSTRAINT def_IsPublicPreviousState DEFAULT 'N' FOR IsPublicPreviousState
GO
ALTER TABLE Datasource ADD CONSTRAINT def_isAvailable DEFAULT 'N' FOR isAvailable
GO
ALTER TABLE Datasource ADD CONSTRAINT def_isContainedWithinZipFile DEFAULT 'N' FOR isContainedWithinZipFile
GO
ALTER TABLE Datasource ADD CONSTRAINT def_IsZipFile DEFAULT 'N' FOR IsZipFile
GO
ALTER TABLE Datasource ADD CONSTRAINT def_isPerm DEFAULT 'N' FOR isPerm
GO
ALTER TABLE Datasource ADD CONSTRAINT def_isMaster DEFAULT 'N' FOR isMaster
GO
ALTER TABLE Datasource ADD CONSTRAINT def_OcrPerformed DEFAULT 'N' FOR OcrPerformed
GO
ALTER TABLE Datasource ADD CONSTRAINT def_isGraphic DEFAULT 'N' FOR isGraphic
GO
ALTER TABLE Datasource ADD CONSTRAINT def_GraphicContainsText DEFAULT 'N' FOR GraphicContainsText
GO
ALTER TABLE Datasource ADD CONSTRAINT def_isWebPage DEFAULT 'N' FOR isWebPage
GO
ALTER TABLE Datasource ADD CONSTRAINT def_OcrSuccessful DEFAULT 'N' FOR OcrSuccessful
GO
ALTER TABLE Datasource ADD CONSTRAINT def_OcrPending DEFAULT 'N' FOR OcrPending
GO
ALTER TABLE Datasource ADD CONSTRAINT def_PdfIsSearchable DEFAULT 'N' FOR PdfIsSearchable
GO
ALTER TABLE Datasource ADD CONSTRAINT def_PdfOcrRequired DEFAULT 'N' FOR PdfOcrRequired
GO
ALTER TABLE Datasource ADD CONSTRAINT def_PdfOcrSuccess DEFAULT 'N' FOR PdfOcrSuccess
GO
ALTER TABLE Datasource ADD CONSTRAINT def_PdfOcrTextExtracted DEFAULT 'N' FOR PdfOcrTextExtracted
GO
ALTER TABLE Datasource ADD CONSTRAINT def_CreateDate DEFAULT getdate() FOR CreateDate
GO
ALTER TABLE Datasource ADD CONSTRAINT def_LastAccessDate DEFAULT getdate() FOR LastAccessDate
GO
ALTER TABLE Datasource ADD CONSTRAINT def_LastWriteTime DEFAULT getdate() FOR LastWriteTime
GO
ALTER TABLE Datasource ADD CONSTRAINT def_RetentionExpirationDate DEFAULT getdate() FOR RetentionExpirationDate
GO
ALTER TABLE Datasource ADD CONSTRAINT def_CreationDate DEFAULT getdate() FOR CreationDate
GO
ALTER TABLE Datasource ADD CONSTRAINT def_RowCreationDate DEFAULT getdate() FOR RowCreationDate
GO
ALTER TABLE Datasource ADD CONSTRAINT def_RowLastModDate DEFAULT getdate() FOR RowLastModDate
GO
ALTER TABLE Datasource ADD CONSTRAINT def_txStartTime DEFAULT getdate() FOR txStartTime
GO
ALTER TABLE Datasource ADD CONSTRAINT def_txEndTime DEFAULT getdate() FOR txEndTime
GO
ALTER TABLE Datasource ADD CONSTRAINT def_RetentionDate DEFAULT getdate() FOR RetentionDate
GO
ALTER TABLE Datasource ADD CONSTRAINT def_RecTimeStamp DEFAULT getdate() FOR RecTimeStamp
GO
ALTER TABLE Datasource ADD CONSTRAINT def_DataVerified DEFAULT 0 FOR DataVerified
GO
ALTER TABLE Datasource ADD CONSTRAINT def_SharePoint DEFAULT 0 FOR SharePoint
GO
ALTER TABLE Datasource ADD CONSTRAINT def_SharePointDoc DEFAULT 0 FOR SharePointDoc
GO
ALTER TABLE Datasource ADD CONSTRAINT def_SharePointList DEFAULT 0 FOR SharePointList
GO
ALTER TABLE Datasource ADD CONSTRAINT def_SharePointListItem DEFAULT 0 FOR SharePointListItem
GO
ALTER TABLE Datasource ADD CONSTRAINT def_StructuredData DEFAULT 0 FOR StructuredData
GO
ALTER TABLE Datasource ADD CONSTRAINT def_HiveActive DEFAULT 0 FOR HiveActive
GO
ALTER TABLE Datasource ADD CONSTRAINT def_FileAttached DEFAULT 0 FOR FileAttached
GO
ALTER TABLE Datasource ADD CONSTRAINT def_RequireOcr DEFAULT 0 FOR RequireOcr
GO
ALTER TABLE Datasource ADD CONSTRAINT def_RssLinkFlg DEFAULT 0 FOR RssLinkFlg
GO
ALTER TABLE Datasource ADD CONSTRAINT def_SapData DEFAULT 0 FOR SapData
GO
ALTER TABLE Datasource ADD CONSTRAINT def_VersionNbr DEFAULT 0 FOR VersionNbr
GO
ALTER TABLE Datasource ADD CONSTRAINT def_FileLength DEFAULT 0 FOR FileLength
GO
ALTER TABLE Datasource ADD CONSTRAINT def_RecLen DEFAULT 0 FOR RecLen
GO
ALTER TABLE Datasource ADD CONSTRAINT def_OriginalSize DEFAULT 0 FOR OriginalSize
GO
ALTER TABLE Datasource ADD CONSTRAINT def_CompressedSize DEFAULT 0 FOR CompressedSize
GO
ALTER TABLE Datasource ADD CONSTRAINT def_txTotalTime DEFAULT 0 FOR txTotalTime
GO
ALTER TABLE Datasource ADD CONSTRAINT def_TransmitTime DEFAULT 0 FOR TransmitTime
GO
ALTER TABLE Datasource ADD CONSTRAINT def_BPS DEFAULT 0 FOR BPS
GO
ALTER TABLE Datasource ADD CONSTRAINT def_PdfPages DEFAULT 0 FOR PdfPages
GO
ALTER TABLE Datasource ADD CONSTRAINT def_PdfImages DEFAULT 0 FOR PdfImages
GO
ALTER TABLE Datasource ADD CONSTRAINT def_RowID DEFAULT 0 FOR RowID
GO
ALTER TABLE Datasource ADD CONSTRAINT def_ImageLen DEFAULT 0 FOR ImageLen
GO
ALTER TABLE Datasource ADD CONSTRAINT def_SourceGuid DEFAULT 'NA' FOR SourceGuid
GO
ALTER TABLE Datasource ADD CONSTRAINT def_SourceName DEFAULT 'NA' FOR SourceName
GO
ALTER TABLE Datasource ADD CONSTRAINT def_SourceTypeCode DEFAULT 'NA' FOR SourceTypeCode
GO
ALTER TABLE Datasource ADD CONSTRAINT def_UserID DEFAULT 'NA' FOR UserID
GO
ALTER TABLE Datasource ADD CONSTRAINT def_DataSourceOwnerUserID DEFAULT 'NA' FOR DataSourceOwnerUserID
GO
ALTER TABLE Datasource ADD CONSTRAINT def_FileDirectory DEFAULT 'NA' FOR FileDirectory
GO
ALTER TABLE Datasource ADD CONSTRAINT def_OriginalFileType DEFAULT 'NA' FOR OriginalFileType
GO
ALTER TABLE Datasource ADD CONSTRAINT def_ZipFileGuid DEFAULT 'NA' FOR ZipFileGuid
GO
ALTER TABLE Datasource ADD CONSTRAINT def_Description DEFAULT 'NA' FOR Description
GO
ALTER TABLE Datasource ADD CONSTRAINT def_KeyWords DEFAULT 'NA' FOR KeyWords
GO
ALTER TABLE Datasource ADD CONSTRAINT def_Notes DEFAULT 'NA' FOR Notes
GO
ALTER TABLE Datasource ADD CONSTRAINT def_OcrText DEFAULT 'NA' FOR OcrText
GO
ALTER TABLE Datasource ADD CONSTRAINT def_ImageHiddenText DEFAULT 'NA' FOR ImageHiddenText
GO
ALTER TABLE Datasource ADD CONSTRAINT def_ParentGuid DEFAULT 'NA' FOR ParentGuid
GO
ALTER TABLE Datasource ADD CONSTRAINT def_RetentionCode DEFAULT 'NA' FOR RetentionCode
GO
ALTER TABLE Datasource ADD CONSTRAINT def_MachineID DEFAULT 'NA' FOR MachineID
GO
ALTER TABLE Datasource ADD CONSTRAINT def_CRC DEFAULT 'NA' FOR CRC
GO
ALTER TABLE Datasource ADD CONSTRAINT def_HiveConnectionName DEFAULT 'NA' FOR HiveConnectionName
GO
ALTER TABLE Datasource ADD CONSTRAINT def_RepoSvrName DEFAULT 'NA' FOR RepoSvrName
GO
ALTER TABLE Datasource ADD CONSTRAINT def_ContainedWithin DEFAULT 'NA' FOR ContainedWithin
GO
ALTER TABLE Datasource ADD CONSTRAINT def_RecHash DEFAULT 'NA' FOR RecHash
GO
ALTER TABLE Datasource ADD CONSTRAINT def_RepoName DEFAULT 'NA' FOR RepoName
GO
ALTER TABLE Datasource ADD CONSTRAINT def_HashFile DEFAULT 'NA' FOR HashFile
GO
ALTER TABLE Datasource ADD CONSTRAINT def_HashName DEFAULT 'NA' FOR HashName
GO
ALTER TABLE Datasource ADD CONSTRAINT def_RssLinkGuid DEFAULT 'NA' FOR RssLinkGuid
GO
ALTER TABLE Datasource ADD CONSTRAINT def_PageURL DEFAULT 'NA' FOR PageURL
GO
ALTER TABLE Datasource ADD CONSTRAINT def_URLHash DEFAULT 'NA' FOR URLHash
GO
ALTER TABLE Datasource ADD CONSTRAINT def_WebPagePublishDate DEFAULT 'NA' FOR WebPagePublishDate
GO
ALTER TABLE Datasource ADD CONSTRAINT def_Imagehash DEFAULT 'NA' FOR Imagehash
GO
ALTER TABLE Datasource ADD CONSTRAINT def_FileDirectoryName DEFAULT 'NA' FOR FileDirectoryName
GO
ALTER TABLE Datasource ADD CONSTRAINT def_FqnHASH DEFAULT 'NA' FOR FqnHASH
GO
ALTER TABLE Datasource ADD CONSTRAINT def_SourceImageOrigin DEFAULT 'NA' FOR SourceImageOrigin
GO
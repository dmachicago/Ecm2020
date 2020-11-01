Public Class DS_EmailAttachments
    Public AttachmentName As String
    Public RowID As Integer
    Public EmailGuid As String
End Class

Public Class DS_ZipFiles
    Public SourceName As String
    Public isParent As Boolean
    Public SourceGuid As String
End Class

Public Class struct_LibUsers

    Public LibraryName As String

    Public UserName As String

    Public OwnerName As String

    Public UserGuid As String

    Public OwnerGuid As String

    Public UserLoginID As String

    Public OwnerLoginID As String

End Class

Public Class struct_ActiveSearchGuids

    Public TgtGuid As String

    Public TgtUserID As String

    Public OwnerName As String

    Public UserGuid As String

    Public OwnerGuid As String

    Public UserLoginID As String

    Public OwnerLoginID As String

End Class

Public Class struct_ArchiveFolderId

    Public ContainerName As String

    Public FolderName As String

    Public FolderID As String

    Public storeid As String

End Class

Public Class struct_Dg

    Public C1 As String

    Public C2 As String

    Public C3 As String

    Public C4 As String

    Public C5 As String

    Public C6 As String

    Public C7 As String

    Public C8 As String

    Public C9 As String

    Public C10 As String

    Public C11 As String

    Public C12 As String

    Public C13 As String

    Public C14 As String

    Public C15 As String

    Public C16 As String

    Public C17 As String

    Public C18 As String

    Public C19 As String

    Public C20 As String

    Public C21 As String

    Public C22 As String

    Public C23 As String

    Public C24 As String

    Public C25 As String

    Public C26 As String

    Public C27 As String

    Public C28 As String

    Public C29 As String

    Public C30 As String

End Class

Public Class DS_EmailNoWeight

    Public SentOn As Date

    Public ShortSubj As String

    Public SenderEmailAddress As String

    Public SenderName As String

    Public SentTO As String

    Public Body As String

    Public CC As String

    Public Bcc As String

    Public CreationTime As Date

    Public AllRecipients As String

    Public ReceivedByName As String

    Public ReceivedTime As Date

    Public MsgSize As Integer

    Public SUBJECT As String

    Public OriginalFolder As String

    Public EmailGuid As String

    Public RetentionExpirationDate As Date

    Public isPublic As String

    Public UserID As String

    Public SourceTypeCode As String

    Public NbrAttachments As Integer

    Public RID As String

    Public RepoSvrName As String

    Public ROWID As String

End Class

Public Class DS_EMAIL

    Public RANK As Integer

    Public SentOn As Date

    Public ShortSubj As String

    Public SenderEmailAddress As String

    Public SenderName As String

    Public SentTO As String

    Public Body As String

    Public CC As String

    Public Bcc As String

    Public CreationTime As Date

    Public AllRecipients As String

    Public ReceivedByName As String

    Public ReceivedTime As Date

    Public MsgSize As Integer

    Public SUBJECT As String

    Public OriginalFolder As String

    Public EmailGuid As String

    Public RetentionExpirationDate As Date

    Public isPublic As String

    Public UserID As String

    Public SourceTypeCode As String

    Public NbrAttachments As Integer

    Public RID As String

    Public RepoSvrName As String

    Public ROWID As String

    Public FoundInAttach As Boolean

End Class

Public Class DS_CONTENT

    Public CreateDate As DateTime
    Public DataSourceOwnerUserID As String
    Public Description As String
    Public FileDirectory As String
    Public FileLength As Integer
    Public FQN As String
    Public isPublic As String
    Public isWebPage As String
    Public LastAccessDate As DateTime
    Public LastWriteTime As DateTime
    Public RepoSvrName As String
    Public RetentionExpirationDate As DateTime
    Public RssLinkFlg As Boolean
    Public SourceGuid As String
    Public SourceName As String
    Public SourceTypeCode As String
    Public StructuredData As Boolean
    Public VersionNbr As Integer

End Class

Public Class DS_License

    Public LicenseNbr As Integer

    Public CompanyID As String

    Public MachineID As String

    Public LicenseID As String

    Public Applied As String

    Public PurchasedMachines As String

    Public PurchasedUsers As String

    Public SupportActive As String

    Public SupportActiveDate As String

    Public SupportInactiveDate As String

    Public LicenseText As String

    Public LicenseTypeCode As String

    Public EncryptedLicense As String

    Public ServerNAME As String

    Public SqlInstanceName As String

End Class

Public Class DS_ErrorLogs

    Public Severity As String

    Public LoggedMessage As String

    Public EntryDate As DateTime

    Public LogName As String

    Public EntryUserID As String

End Class

Public Class DS_USERSCREENSTATE

    Public ScreenName As String

    Public UserID As String

    Public ParmName As String

    Public ParmVal As String

    Public ParmDataType As String

    Public HiveConnectionName As String

    Public HiveActive As Boolean

    Public RepoSvrName As String

    Public RowCreationDate As Date

    Public RowLastModDate As Date

    Public RowNbr As Integer

End Class

Public Class DS_USERSEARCHSTATE

    Public SearchID As Integer

    Public ScreenName As String

    Public UserID As String

    Public ParmName As String

    Public ParmVal As String

    Public ParmDataType As String

    Public HiveConnectionName As String

    Public HiveActive As Boolean

    Public RepoSvrName As String

    Public RowCreationDate As Date

    Public RowLastModDate As Date

    Public RowNbr As Integer

End Class

Public Class DS_clsUSERGRIDSTATE

    Public UserID As String

    Public ScreenName As String

    Public GridName As String

    Public ColName As String

    Public ColOrder As Integer

    Public ColWidth As Integer

    Public ColVisible As Boolean

    Public ColReadOnly As Boolean

    Public ColSortOrder As Integer

    Public ColSortAsc As Boolean

    Public HiveConnectionName As String

    Public HiveActive As Boolean

    Public RepoSvrName As String

    Public RowCreationDate As Date

    Public RowLastModDate As Date

    Public RowNbr As Integer

End Class

Public Class DS_SearchTerms

    Public SearchTypeCode As String

    Public Term As String

    Public TermVal As String

    Public TermDatatype As String

End Class

Public Class DS_SYSTEMPARMS

    Public SysParm As String

    Public SysParmDesc As String

    Public SysParmVal As String

    Public flgActive As String

    Public isDirectory As String

    Public isEmailFolder As String

    Public flgAllSubDirs As String

    Public HiveConnectionName As String

    Public HiveActive As Boolean

    Public RepoSvrName As String

    Public RowCreationDate As Date

    Public RowLastModDate As Date

End Class

Public Class DS_VLibraryStats

    Public LibraryName As String

    Public isPublic As String

    Public Items As Integer

    Public Members As Integer

End Class

Public Class DS_dgGrpUsers

    Public UserName As String

    Public UserID As String

End Class

Public Class DS_DgAssigned

    Public GroupName As String

    Public GroupOwnerUserID As String

End Class

Public Class DS_LibItems

    Public ItemTitle As String

    Public ItemType As String

    Public LibraryName As String

    Public LibraryOwnerUserID As String

    Public AddedByUserGuidId As String

    Public DataSourceOwnerUserID As String

    Public SourceGuid As String

    Public LibraryItemGuid As String

End Class

Public Class DS_DgGroupUsers

    Public UserName As String

    Public UserID As String

    Public FullAccess As Boolean

    Public ReadOnlyAccess As Boolean

    Public DeleteAccess As Boolean

    Public Searchable As Boolean

End Class

Public Class DS_VUserGrid

    Public UserID As String

    Public UserName As String

    Public EmailAddress As String

    Public Admin As String

    Public isActive As String

    Public UserLoginID As String

    Public ClientOnly As Boolean

    Public HiveConnectionName As String

    Public HiveActive As Boolean

    Public RepoSvrName As String

    Public RowCreationDate As Date

    Public RowLastModDate As Date

End Class

Public Class DS_CoOwner

    Public CoOwnerName As String

    Public CoOwnerID As String

    Public RowID As Integer

End Class

Public Class DS_VLibraryUsers

    Public UserID As String

    Public LibraryName As String

    Public LibraryOwnerUserID As String

    Public UserName As String

End Class

Public Class DS_SEARCHSCHEDULE

    Public SearchName As String

    Public NotificationSMS As String

    Public SearchDesc As String

    Public OwnerID As String

    Public SearchQuery As String

    Public SendToEmail As String

    Public ScheduleUnit As String

    Public ScheduleHour As String

    Public ScheduleDaysOfWeek As String

    Public ScheduleDaysOfMonth As String

    Public ScheduleMonthOfQtr As String

    Public StartToRunDate As Date

    Public EndRunDate As Date

    Public SearchParameters As String

    Public LastRunDate As Date

    Public NumberOfExecutions As Integer

    Public CreateDate As Date

    Public LastModDate As Date

    Public ScheduleHourInterval As Integer

    Public RepoName As String

End Class

Public Class DS_ListOfStrings01

    Public strItem As String

End Class

Public Class DS_ListOfStrings02

    Public strItem As String

End Class

Public Class DS_ListOfStrings03

    Public strItem As String

End Class

Public Class DS_ListOfStrings04

    Public strItem As String

End Class

Public Class DS_RESTOREQUEUE

    Public ContentGuid As String

    Public UserID As String

    Public MachineID As String

    Public FQN As String

    Public FileSize As Integer

    Public ContentType As String

    Public Preview As Boolean

    Public Restore As Boolean

    Public ProcessingCompleted As Boolean

    Public EntryDate As Date

    Public ProcessedDate As Date

    Public StartDownloadTime As Date

    Public EndDownloadTime As Date

    Public RepoName As String

    Public RowGuid As Guid

End Class

Public Class DS_Metadata

    Public AttributeName As String

    Public AttributeValue As String

End Class
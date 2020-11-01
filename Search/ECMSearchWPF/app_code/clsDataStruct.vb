'<System.Runtime.Serialization.DataContract()>
Public Class struct_LibUsers
    '<System.Runtime.Serialization.DataMember()>
    Public LibraryName As String

    '<System.Runtime.Serialization.DataMember()>
    Public UserName As String

    '<System.Runtime.Serialization.DataMember()>
    Public OwnerName As String

    '<System.Runtime.Serialization.DataMember()>
    Public UserGuid As String

    '<System.Runtime.Serialization.DataMember()>
    Public OwnerGuid As String

    '<System.Runtime.Serialization.DataMember()>
    Public UserLoginID As String

    '<System.Runtime.Serialization.DataMember()>
    Public OwnerLoginID As String
End Class

'<System.Runtime.Serialization.DataContract()>
Public Class struct_ActiveSearchGuids
    '<System.Runtime.Serialization.DataMember()>
    Public TgtGuid As String

    '<System.Runtime.Serialization.DataMember()>
    Public TgtUserID As String

    '<System.Runtime.Serialization.DataMember()>
    Public OwnerName As String

    '<System.Runtime.Serialization.DataMember()>
    Public UserGuid As String

    '<System.Runtime.Serialization.DataMember()>
    Public OwnerGuid As String

    '<System.Runtime.Serialization.DataMember()>
    Public UserLoginID As String

    '<System.Runtime.Serialization.DataMember()>
    Public OwnerLoginID As String
End Class

'<System.Runtime.Serialization.DataContract()>
Public Class struct_ArchiveFolderId
    '<System.Runtime.Serialization.DataMember()>
    Public ContainerName As String

    '<System.Runtime.Serialization.DataMember()>
    Public FolderName As String

    '<System.Runtime.Serialization.DataMember()>
    Public FolderID As String

    '<System.Runtime.Serialization.DataMember()>
    Public storeid As String
End Class

'<System.Runtime.Serialization.DataContract()>
Public Class struct_Dg
    '<System.Runtime.Serialization.DataMember()>
    Public C1 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C2 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C3 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C4 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C5 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C6 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C7 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C8 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C9 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C10 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C11 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C12 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C13 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C14 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C15 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C16 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C17 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C18 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C19 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C20 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C21 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C22 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C23 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C24 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C25 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C26 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C27 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C28 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C29 As String

    '<System.Runtime.Serialization.DataMember()>
    Public C30 As String

End Class

'<System.Runtime.Serialization.DataContract()>
Public Class DS_EmailNoWeight
    '<System.Runtime.Serialization.DataMember()>
    Public SentOn As Date

    '<System.Runtime.Serialization.DataMember()>
    Public ShortSubj As String

    '<System.Runtime.Serialization.DataMember()>
    Public SenderEmailAddress As String

    '<System.Runtime.Serialization.DataMember()>
    Public SenderName As String

    '<System.Runtime.Serialization.DataMember()>
    Public SentTO As String

    '<System.Runtime.Serialization.DataMember()>
    Public Body As String

    '<System.Runtime.Serialization.DataMember()>
    Public CC As String

    '<System.Runtime.Serialization.DataMember()>
    Public Bcc As String

    '<System.Runtime.Serialization.DataMember()>
    Public CreationTime As Date

    '<System.Runtime.Serialization.DataMember()>
    Public AllRecipients As String

    '<System.Runtime.Serialization.DataMember()>
    Public ReceivedByName As String

    '<System.Runtime.Serialization.DataMember()>
    Public ReceivedTime As Date

    '<System.Runtime.Serialization.DataMember()>
    Public MsgSize As Integer

    '<System.Runtime.Serialization.DataMember()>
    Public SUBJECT As String

    '<System.Runtime.Serialization.DataMember()>
    Public OriginalFolder As String

    '<System.Runtime.Serialization.DataMember()>
    Public EmailGuid As String

    '<System.Runtime.Serialization.DataMember()>
    Public RetentionExpirationDate As Date

    '<System.Runtime.Serialization.DataMember()>
    Public isPublic As String

    '<System.Runtime.Serialization.DataMember()>
    Public UserID As String

    '<System.Runtime.Serialization.DataMember()>
    Public SourceTypeCode As String

    '<System.Runtime.Serialization.DataMember()>
    Public NbrAttachments As Integer

    '<System.Runtime.Serialization.DataMember()>
    Public RID As String

    '<System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    '<System.Runtime.Serialization.DataMember()>
    Public ROWID As String
End Class

'<System.Runtime.Serialization.DataContract()>
Public Class DS_EMAIL
    '<System.Runtime.Serialization.DataMember()>
    Public RANK As Integer

    '<System.Runtime.Serialization.DataMember()>
    Public SentOn As Date

    '<System.Runtime.Serialization.DataMember()>
    Public ShortSubj As String

    '<System.Runtime.Serialization.DataMember()>
    Public SenderEmailAddress As String

    '<System.Runtime.Serialization.DataMember()>
    Public SenderName As String

    '<System.Runtime.Serialization.DataMember()>
    Public SentTO As String

    '<System.Runtime.Serialization.DataMember()>
    Public Body As String

    '<System.Runtime.Serialization.DataMember()>
    Public CC As String

    '<System.Runtime.Serialization.DataMember()>
    Public Bcc As String

    '<System.Runtime.Serialization.DataMember()>
    Public CreationTime As Date

    '<System.Runtime.Serialization.DataMember()>
    Public AllRecipients As String

    '<System.Runtime.Serialization.DataMember()>
    Public ReceivedByName As String

    '<System.Runtime.Serialization.DataMember()>
    Public ReceivedTime As Date

    '<System.Runtime.Serialization.DataMember()>
    Public MsgSize As Integer

    '<System.Runtime.Serialization.DataMember()>
    Public SUBJECT As String

    '<System.Runtime.Serialization.DataMember()>
    Public OriginalFolder As String

    '<System.Runtime.Serialization.DataMember()>
    Public EmailGuid As String

    '<System.Runtime.Serialization.DataMember()>
    Public RetentionExpirationDate As Date

    '<System.Runtime.Serialization.DataMember()>
    Public isPublic As String

    '<System.Runtime.Serialization.DataMember()>
    Public UserID As String

    '<System.Runtime.Serialization.DataMember()>
    Public SourceTypeCode As String

    '<System.Runtime.Serialization.DataMember()>
    Public NbrAttachments As Integer

    '<System.Runtime.Serialization.DataMember()>
    Public RID As String

    '<System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    '<System.Runtime.Serialization.DataMember()>
    Public ROWID As String

    '<System.Runtime.Serialization.DataMember()>
    Public FoundInAttach As Boolean

End Class
''<System.Runtime.Serialization.DataContract()>
'Public Class DS_CONTENT
'    '<System.Runtime.Serialization.DataMember()>
'    Public SourceName As String

'    '<System.Runtime.Serialization.DataMember()>
'    Public CreateDate As Date

'    '<System.Runtime.Serialization.DataMember()>
'    Public VersionNbr As Integer

'    '<System.Runtime.Serialization.DataMember()>
'    Public LastAccessDate As Date

'    '<System.Runtime.Serialization.DataMember()>
'    Public FileLength As Integer

'    '<System.Runtime.Serialization.DataMember()>
'    Public LastWriteTime As Date

'    '<System.Runtime.Serialization.DataMember()>
'    Public SourceTypeCode As String

'    '<System.Runtime.Serialization.DataMember()>
'    Public isPublic As String

'    '<System.Runtime.Serialization.DataMember()>
'    Public FQN As String

'    '<System.Runtime.Serialization.DataMember()>
'    Public SourceGuid As String

'    '<System.Runtime.Serialization.DataMember()>
'    Public DataSourceOwnerUserID As String

'    '<System.Runtime.Serialization.DataMember()>
'    Public FileDirectory As String

'    '<System.Runtime.Serialization.DataMember()>
'    Public StructuredData As Boolean

'    '<System.Runtime.Serialization.DataMember()>
'    Public RepoSvrName As String

'    '<System.Runtime.Serialization.DataMember()>
'    Public ROWID As String

'    '<System.Runtime.Serialization.DataMember()>
'    Public RANK As Integer

'End Class

'<System.Runtime.Serialization.DataContract()>
Public Class DS_CONTENT
    '<System.Runtime.Serialization.DataMember()>
    Public RANK As Integer

    '<System.Runtime.Serialization.DataMember()>
    Public SourceName As String

    '<System.Runtime.Serialization.DataMember()>
    Public CreateDate As Date

    '<System.Runtime.Serialization.DataMember()>
    Public VersionNbr As Integer

    '<System.Runtime.Serialization.DataMember()>
    Public LastAccessDate As Date

    '<System.Runtime.Serialization.DataMember()>
    Public FileLength As Integer

    '<System.Runtime.Serialization.DataMember()>
    Public LastWriteTime As Date

    '<System.Runtime.Serialization.DataMember()>
    Public OriginalFileType As String

    '<System.Runtime.Serialization.DataMember()>
    Public isPublic As String

    '<System.Runtime.Serialization.DataMember()>
    Public FQN As String

    '<System.Runtime.Serialization.DataMember()>
    Public SourceGuid As String

    '<System.Runtime.Serialization.DataMember()>
    Public DataSourceOwnerUserID As String

    '<System.Runtime.Serialization.DataMember()>
    Public FileDirectory As String

    '<System.Runtime.Serialization.DataMember()>
    Public RetentionExpirationDate As Date

    '<System.Runtime.Serialization.DataMember()>
    Public isMaster As String

    '<System.Runtime.Serialization.DataMember()>
    Public StructuredData As Boolean

    '<System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    '<System.Runtime.Serialization.DataMember()>
    Public ROWID As String

    '<System.Runtime.Serialization.DataMember()>
    Public Description As String

    '<System.Runtime.Serialization.DataMember()>
    Public RssLinkFlg As Boolean

    '<System.Runtime.Serialization.DataMember()>
    Public isWebPage As String

End Class

'<System.Runtime.Serialization.DataContract()>
Public Class DS_License
    '<System.Runtime.Serialization.DataMember()>
    Public LicenseNbr As Integer

    '<System.Runtime.Serialization.DataMember()>
    Public CompanyID As String

    '<System.Runtime.Serialization.DataMember()>
    Public MachineID As String

    '<System.Runtime.Serialization.DataMember()>
    Public LicenseID As String

    '<System.Runtime.Serialization.DataMember()>
    Public Applied As String

    '<System.Runtime.Serialization.DataMember()>
    Public PurchasedMachines As String

    '<System.Runtime.Serialization.DataMember()>
    Public PurchasedUsers As String

    '<System.Runtime.Serialization.DataMember()>
    Public SupportActive As String

    '<System.Runtime.Serialization.DataMember()>
    Public SupportActiveDate As String

    '<System.Runtime.Serialization.DataMember()>
    Public SupportInactiveDate As String

    '<System.Runtime.Serialization.DataMember()>
    Public LicenseText As String

    '<System.Runtime.Serialization.DataMember()>
    Public LicenseTypeCode As String

    '<System.Runtime.Serialization.DataMember()>
    Public EncryptedLicense As String

    '<System.Runtime.Serialization.DataMember()>
    Public ServerNAME As String

    '<System.Runtime.Serialization.DataMember()>
    Public SqlInstanceName As String

End Class

'<System.Runtime.Serialization.DataContract()>
Public Class DS_ErrorLogs
    '<System.Runtime.Serialization.DataMember()>
    Public Severity As String

    '<System.Runtime.Serialization.DataMember()>
    Public LoggedMessage As String

    '<System.Runtime.Serialization.DataMember()>
    Public EntryDate As DateTime

    '<System.Runtime.Serialization.DataMember()>
    Public LogName As String

    '<System.Runtime.Serialization.DataMember()>
    Public EntryUserID As String
End Class


'<System.Runtime.Serialization.DataContract()>
Public Class DS_USERSCREENSTATE
    '<System.Runtime.Serialization.DataMember()>
    Public ScreenName As String

    '<System.Runtime.Serialization.DataMember()>
    Public UserID As String

    '<System.Runtime.Serialization.DataMember()>
    Public ParmName As String

    '<System.Runtime.Serialization.DataMember()>
    Public ParmVal As String

    '<System.Runtime.Serialization.DataMember()>
    Public ParmDataType As String

    '<System.Runtime.Serialization.DataMember()>
    Public HiveConnectionName As String

    '<System.Runtime.Serialization.DataMember()>
    Public HiveActive As Boolean

    '<System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    '<System.Runtime.Serialization.DataMember()>
    Public RowCreationDate As Date

    '<System.Runtime.Serialization.DataMember()>
    Public RowLastModDate As Date

    '<System.Runtime.Serialization.DataMember()>
    Public RowNbr As Integer

End Class

'<System.Runtime.Serialization.DataContract()>
Public Class DS_USERSEARCHSTATE
    '<System.Runtime.Serialization.DataMember()>
    Public SearchID As Integer

    '<System.Runtime.Serialization.DataMember()>
    Public ScreenName As String

    '<System.Runtime.Serialization.DataMember()>
    Public UserID As String

    '<System.Runtime.Serialization.DataMember()>
    Public ParmName As String

    '<System.Runtime.Serialization.DataMember()>
    Public ParmVal As String

    '<System.Runtime.Serialization.DataMember()>
    Public ParmDataType As String

    '<System.Runtime.Serialization.DataMember()>
    Public HiveConnectionName As String

    '<System.Runtime.Serialization.DataMember()>
    Public HiveActive As Boolean

    '<System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    '<System.Runtime.Serialization.DataMember()>
    Public RowCreationDate As Date

    '<System.Runtime.Serialization.DataMember()>
    Public RowLastModDate As Date

    '<System.Runtime.Serialization.DataMember()>
    Public RowNbr As Integer

End Class

'<System.Runtime.Serialization.DataContract()>
Public Class DS_clsUSERGRIDSTATE
    '<System.Runtime.Serialization.DataMember()>
    Public UserID As String

    '<System.Runtime.Serialization.DataMember()>
    Public ScreenName As String

    '<System.Runtime.Serialization.DataMember()>
    Public GridName As String

    '<System.Runtime.Serialization.DataMember()>
    Public ColName As String

    '<System.Runtime.Serialization.DataMember()>
    Public ColOrder As Integer

    '<System.Runtime.Serialization.DataMember()>
    Public ColWidth As Integer

    '<System.Runtime.Serialization.DataMember()>
    Public ColVisible As Boolean

    '<System.Runtime.Serialization.DataMember()>
    Public ColReadOnly As Boolean

    '<System.Runtime.Serialization.DataMember()>
    Public ColSortOrder As Integer

    '<System.Runtime.Serialization.DataMember()>
    Public ColSortAsc As Boolean

    '<System.Runtime.Serialization.DataMember()>
    Public HiveConnectionName As String

    '<System.Runtime.Serialization.DataMember()>
    Public HiveActive As Boolean

    '<System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    '<System.Runtime.Serialization.DataMember()>
    Public RowCreationDate As Date

    '<System.Runtime.Serialization.DataMember()>
    Public RowLastModDate As Date

    '<System.Runtime.Serialization.DataMember()>
    Public RowNbr As Integer

End Class

'<System.Runtime.Serialization.DataContract()>
Public Class DS_SearchTerms
    '<System.Runtime.Serialization.DataMember()>
    Public SearchTypeCode As String

    '<System.Runtime.Serialization.DataMember()>
    Public Term As String

    '<System.Runtime.Serialization.DataMember()>
    Public TermVal As String

    '<System.Runtime.Serialization.DataMember()>
    Public TermDatatype As String
End Class

'<System.Runtime.Serialization.DataContract()>
Public Class DS_SYSTEMPARMS
    '<System.Runtime.Serialization.DataMember()>
    Public SysParm As String

    '<System.Runtime.Serialization.DataMember()>
    Public SysParmDesc As String

    '<System.Runtime.Serialization.DataMember()>
    Public SysParmVal As String

    '<System.Runtime.Serialization.DataMember()>
    Public flgActive As String

    '<System.Runtime.Serialization.DataMember()>
    Public isDirectory As String

    '<System.Runtime.Serialization.DataMember()>
    Public isEmailFolder As String

    '<System.Runtime.Serialization.DataMember()>
    Public flgAllSubDirs As String

    '<System.Runtime.Serialization.DataMember()>
    Public HiveConnectionName As String

    '<System.Runtime.Serialization.DataMember()>
    Public HiveActive As Boolean

    '<System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    '<System.Runtime.Serialization.DataMember()>
    Public RowCreationDate As Date

    '<System.Runtime.Serialization.DataMember()>
    Public RowLastModDate As Date

End Class

'<System.Runtime.Serialization.DataContract()>
Public Class DS_ZipFiles
    '<System.Runtime.Serialization.DataMember()>
    Public SourceName As String

    '<System.Runtime.Serialization.DataMember()>
    Public isParent As Boolean

    '<System.Runtime.Serialization.DataMember()>
    Public SourceGuid As String

End Class


'<System.Runtime.Serialization.DataContract()>
Public Class DS_Attachments
    '<System.Runtime.Serialization.DataMember()>
    Public AttachmentName As String

    '<System.Runtime.Serialization.DataMember()>
    Public RowID As Integer

    '<System.Runtime.Serialization.DataMember()>
    Public EmailGuid As String
End Class

'<System.Runtime.Serialization.DataContract()>
Public Class DS_VLibraryStats
    '<System.Runtime.Serialization.DataMember()>
    Public LibraryName As String

    '<System.Runtime.Serialization.DataMember()>
    Public isPublic As String

    '<System.Runtime.Serialization.DataMember()>
    Public Items As Integer

    '<System.Runtime.Serialization.DataMember()>
    Public Members As Integer

End Class

'<System.Runtime.Serialization.DataContract()>
Public Class DS_dgGrpUsers
    '<System.Runtime.Serialization.DataMember()>
    Public UserName As String

    '<System.Runtime.Serialization.DataMember()>
    Public UserID As String
End Class

'<System.Runtime.Serialization.DataContract()>
Public Class DS_DgAssigned
    '<System.Runtime.Serialization.DataMember()>
    Public GroupName As String

    '<System.Runtime.Serialization.DataMember()>
    Public GroupOwnerUserID As String
End Class

'<System.Runtime.Serialization.DataContract()>
Public Class DS_LibItems
    '<System.Runtime.Serialization.DataMember()>
    Public ItemTitle As String

    '<System.Runtime.Serialization.DataMember()>
    Public ItemType As String

    '<System.Runtime.Serialization.DataMember()>
    Public LibraryName As String

    '<System.Runtime.Serialization.DataMember()>
    Public LibraryOwnerUserID As String

    '<System.Runtime.Serialization.DataMember()>
    Public AddedByUserGuidId As String

    '<System.Runtime.Serialization.DataMember()>
    Public DataSourceOwnerUserID As String

    '<System.Runtime.Serialization.DataMember()>
    Public SourceGuid As String

    '<System.Runtime.Serialization.DataMember()>
    Public LibraryItemGuid As String
End Class
'<System.Runtime.Serialization.DataContract()>
Public Class DS_DgGroupUsers
    '<System.Runtime.Serialization.DataMember()>
    Public UserName As String

    '<System.Runtime.Serialization.DataMember()>
    Public UserID As String

    '<System.Runtime.Serialization.DataMember()>
    Public FullAccess As Boolean

    '<System.Runtime.Serialization.DataMember()>
    Public ReadOnlyAccess As Boolean

    '<System.Runtime.Serialization.DataMember()>
    Public DeleteAccess As Boolean

    '<System.Runtime.Serialization.DataMember()>
    Public Searchable As Boolean
End Class
'<System.Runtime.Serialization.DataContract()>
Public Class DS_VUserGrid
    '<System.Runtime.Serialization.DataMember()>
    Public UserID As String

    '<System.Runtime.Serialization.DataMember()>
    Public UserName As String

    '<System.Runtime.Serialization.DataMember()>
    Public EmailAddress As String

    '<System.Runtime.Serialization.DataMember()>
    Public Admin As String

    '<System.Runtime.Serialization.DataMember()>
    Public isActive As String

    '<System.Runtime.Serialization.DataMember()>
    Public UserLoginID As String

    '<System.Runtime.Serialization.DataMember()>
    Public ClientOnly As Boolean

    '<System.Runtime.Serialization.DataMember()>
    Public HiveConnectionName As String

    '<System.Runtime.Serialization.DataMember()>
    Public HiveActive As Boolean

    '<System.Runtime.Serialization.DataMember()>
    Public RepoSvrName As String

    '<System.Runtime.Serialization.DataMember()>
    Public RowCreationDate As Date

    '<System.Runtime.Serialization.DataMember()>
    Public RowLastModDate As Date

End Class
'<System.Runtime.Serialization.DataContract()>
Public Class DS_CoOwner
    '<System.Runtime.Serialization.DataMember()>
    Public CoOwnerName As String

    '<System.Runtime.Serialization.DataMember()>
    Public CoOwnerID As String

    '<System.Runtime.Serialization.DataMember()>
    Public RowID As Integer
End Class
'<System.Runtime.Serialization.DataContract()>
Public Class DS_VLibraryUsers
    '<System.Runtime.Serialization.DataMember()>
    Public UserID As String

    '<System.Runtime.Serialization.DataMember()>
    Public LibraryName As String

    '<System.Runtime.Serialization.DataMember()>
    Public LibraryOwnerUserID As String

    '<System.Runtime.Serialization.DataMember()>
    Public UserName As String

End Class

'<System.Runtime.Serialization.DataContract()>
Public Class DS_SEARCHSCHEDULE
    '<System.Runtime.Serialization.DataMember()>
    Public SearchName As String

    '<System.Runtime.Serialization.DataMember()>
    Public NotificationSMS As String

    '<System.Runtime.Serialization.DataMember()>
    Public SearchDesc As String

    '<System.Runtime.Serialization.DataMember()>
    Public OwnerID As String

    '<System.Runtime.Serialization.DataMember()>
    Public SearchQuery As String

    '<System.Runtime.Serialization.DataMember()>
    Public SendToEmail As String

    '<System.Runtime.Serialization.DataMember()>
    Public ScheduleUnit As String

    '<System.Runtime.Serialization.DataMember()>
    Public ScheduleHour As String

    '<System.Runtime.Serialization.DataMember()>
    Public ScheduleDaysOfWeek As String

    '<System.Runtime.Serialization.DataMember()>
    Public ScheduleDaysOfMonth As String

    '<System.Runtime.Serialization.DataMember()>
    Public ScheduleMonthOfQtr As String

    '<System.Runtime.Serialization.DataMember()>
    Public StartToRunDate As Date

    '<System.Runtime.Serialization.DataMember()>
    Public EndRunDate As Date

    '<System.Runtime.Serialization.DataMember()>
    Public SearchParameters As String

    '<System.Runtime.Serialization.DataMember()>
    Public LastRunDate As Date

    '<System.Runtime.Serialization.DataMember()>
    Public NumberOfExecutions As Integer

    '<System.Runtime.Serialization.DataMember()>
    Public CreateDate As Date

    '<System.Runtime.Serialization.DataMember()>
    Public LastModDate As Date

    '<System.Runtime.Serialization.DataMember()>
    Public ScheduleHourInterval As Integer

    '<System.Runtime.Serialization.DataMember()>
    Public RepoName As String

End Class

'<System.Runtime.Serialization.DataContract()>
Public Class DS_ListOfStrings01
    '<System.Runtime.Serialization.DataMember()>
    Public strItem As String
End Class
'<System.Runtime.Serialization.DataContract()>
Public Class DS_ListOfStrings02
    '<System.Runtime.Serialization.DataMember()>
    Public strItem As String
End Class
'<System.Runtime.Serialization.DataContract()>
Public Class DS_ListOfStrings03
    '<System.Runtime.Serialization.DataMember()>
    Public strItem As String
End Class
'<System.Runtime.Serialization.DataContract()>
Public Class DS_ListOfStrings04
    '<System.Runtime.Serialization.DataMember()>
    Public strItem As String
End Class
'<System.Runtime.Serialization.DataContract()>
Public Class DS_RESTOREQUEUE
    '<System.Runtime.Serialization.DataMember()>
    Public ContentGuid As String

    '<System.Runtime.Serialization.DataMember()>
    Public UserID As String

    '<System.Runtime.Serialization.DataMember()>
    Public MachineID As String

    '<System.Runtime.Serialization.DataMember()>
    Public FQN As String

    '<System.Runtime.Serialization.DataMember()>
    Public FileSize As Integer

    '<System.Runtime.Serialization.DataMember()>
    Public ContentType As String

    '<System.Runtime.Serialization.DataMember()>
    Public Preview As Boolean

    '<System.Runtime.Serialization.DataMember()>
    Public Restore As Boolean

    '<System.Runtime.Serialization.DataMember()>
    Public ProcessingCompleted As Boolean

    '<System.Runtime.Serialization.DataMember()>
    Public EntryDate As Date

    '<System.Runtime.Serialization.DataMember()>
    Public ProcessedDate As Date

    '<System.Runtime.Serialization.DataMember()>
    Public StartDownloadTime As Date

    '<System.Runtime.Serialization.DataMember()>
    Public EndDownloadTime As Date

    '<System.Runtime.Serialization.DataMember()>
    Public RepoName As String

    '<System.Runtime.Serialization.DataMember()>
    Public RowGuid As Guid

End Class
'<System.Runtime.Serialization.DataContract()>
Public Class DS_Metadata
    '<System.Runtime.Serialization.DataMember()>
    Public AttributeName As String

    '<System.Runtime.Serialization.DataMember()>
    Public AttributeValue As String
End Class
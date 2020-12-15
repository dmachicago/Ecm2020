' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 07-16-2020
' ***********************************************************************
' <copyright file="dataStructures.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
''' <summary>
''' Class DS_EmailAttachments.
''' </summary>
Public Class DS_EmailAttachments
    ''' <summary>
    ''' The attachment name
    ''' </summary>
    Public AttachmentName As String
    ''' <summary>
    ''' The row identifier
    ''' </summary>
    Public RowID As Integer
    ''' <summary>
    ''' The email unique identifier
    ''' </summary>
    Public EmailGuid As String
End Class

''' <summary>
''' Class DS_ZipFiles.
''' </summary>
Public Class DS_ZipFiles
    ''' <summary>
    ''' The source name
    ''' </summary>
    Public SourceName As String
    ''' <summary>
    ''' The is parent
    ''' </summary>
    Public isParent As Boolean
    ''' <summary>
    ''' The source unique identifier
    ''' </summary>
    Public SourceGuid As String
End Class

''' <summary>
''' Class struct_LibUsers.
''' </summary>
Public Class struct_LibUsers

    ''' <summary>
    ''' The library name
    ''' </summary>
    Public LibraryName As String

    ''' <summary>
    ''' The user name
    ''' </summary>
    Public UserName As String

    ''' <summary>
    ''' The owner name
    ''' </summary>
    Public OwnerName As String

    ''' <summary>
    ''' The user unique identifier
    ''' </summary>
    Public UserGuid As String

    ''' <summary>
    ''' The owner unique identifier
    ''' </summary>
    Public OwnerGuid As String

    ''' <summary>
    ''' The user login identifier
    ''' </summary>
    Public UserLoginID As String

    ''' <summary>
    ''' The owner login identifier
    ''' </summary>
    Public OwnerLoginID As String

End Class

''' <summary>
''' Class struct_ActiveSearchGuids.
''' </summary>
Public Class struct_ActiveSearchGuids

    ''' <summary>
    ''' The TGT unique identifier
    ''' </summary>
    Public TgtGuid As String

    ''' <summary>
    ''' The TGT user identifier
    ''' </summary>
    Public TgtUserID As String

    ''' <summary>
    ''' The owner name
    ''' </summary>
    Public OwnerName As String

    ''' <summary>
    ''' The user unique identifier
    ''' </summary>
    Public UserGuid As String

    ''' <summary>
    ''' The owner unique identifier
    ''' </summary>
    Public OwnerGuid As String

    ''' <summary>
    ''' The user login identifier
    ''' </summary>
    Public UserLoginID As String

    ''' <summary>
    ''' The owner login identifier
    ''' </summary>
    Public OwnerLoginID As String

End Class

''' <summary>
''' Class struct_ArchiveFolderId.
''' </summary>
Public Class struct_ArchiveFolderId

    ''' <summary>
    ''' The container name
    ''' </summary>
    Public ContainerName As String

    ''' <summary>
    ''' The folder name
    ''' </summary>
    Public FolderName As String

    ''' <summary>
    ''' The folder identifier
    ''' </summary>
    Public FolderID As String

    ''' <summary>
    ''' The storeid
    ''' </summary>
    Public storeid As String

End Class

''' <summary>
''' Class struct_Dg.
''' </summary>
Public Class struct_Dg

    ''' <summary>
    ''' The c1
    ''' </summary>
    Public C1 As String

    ''' <summary>
    ''' The c2
    ''' </summary>
    Public C2 As String

    ''' <summary>
    ''' The c3
    ''' </summary>
    Public C3 As String

    ''' <summary>
    ''' The c4
    ''' </summary>
    Public C4 As String

    ''' <summary>
    ''' The c5
    ''' </summary>
    Public C5 As String

    ''' <summary>
    ''' The c6
    ''' </summary>
    Public C6 As String

    ''' <summary>
    ''' The c7
    ''' </summary>
    Public C7 As String

    ''' <summary>
    ''' The c8
    ''' </summary>
    Public C8 As String

    ''' <summary>
    ''' The c9
    ''' </summary>
    Public C9 As String

    ''' <summary>
    ''' The C10
    ''' </summary>
    Public C10 As String

    ''' <summary>
    ''' The C11
    ''' </summary>
    Public C11 As String

    ''' <summary>
    ''' The C12
    ''' </summary>
    Public C12 As String

    ''' <summary>
    ''' The C13
    ''' </summary>
    Public C13 As String

    ''' <summary>
    ''' The C14
    ''' </summary>
    Public C14 As String

    ''' <summary>
    ''' The C15
    ''' </summary>
    Public C15 As String

    ''' <summary>
    ''' The C16
    ''' </summary>
    Public C16 As String

    ''' <summary>
    ''' The C17
    ''' </summary>
    Public C17 As String

    ''' <summary>
    ''' The C18
    ''' </summary>
    Public C18 As String

    ''' <summary>
    ''' The C19
    ''' </summary>
    Public C19 As String

    ''' <summary>
    ''' The C20
    ''' </summary>
    Public C20 As String

    ''' <summary>
    ''' The C21
    ''' </summary>
    Public C21 As String

    ''' <summary>
    ''' The C22
    ''' </summary>
    Public C22 As String

    ''' <summary>
    ''' The C23
    ''' </summary>
    Public C23 As String

    ''' <summary>
    ''' The C24
    ''' </summary>
    Public C24 As String

    ''' <summary>
    ''' The C25
    ''' </summary>
    Public C25 As String

    ''' <summary>
    ''' The C26
    ''' </summary>
    Public C26 As String

    ''' <summary>
    ''' The C27
    ''' </summary>
    Public C27 As String

    ''' <summary>
    ''' The C28
    ''' </summary>
    Public C28 As String

    ''' <summary>
    ''' The C29
    ''' </summary>
    Public C29 As String

    ''' <summary>
    ''' The C30
    ''' </summary>
    Public C30 As String

End Class

''' <summary>
''' Class DS_EmailNoWeight.
''' </summary>
Public Class DS_EmailNoWeight

    ''' <summary>
    ''' The sent on
    ''' </summary>
    Public SentOn As Date

    ''' <summary>
    ''' The short subj
    ''' </summary>
    Public ShortSubj As String

    ''' <summary>
    ''' The sender email address
    ''' </summary>
    Public SenderEmailAddress As String

    ''' <summary>
    ''' The sender name
    ''' </summary>
    Public SenderName As String

    ''' <summary>
    ''' The sent to
    ''' </summary>
    Public SentTO As String

    ''' <summary>
    ''' The body
    ''' </summary>
    Public Body As String

    ''' <summary>
    ''' The cc
    ''' </summary>
    Public CC As String

    ''' <summary>
    ''' The BCC
    ''' </summary>
    Public Bcc As String

    ''' <summary>
    ''' The creation time
    ''' </summary>
    Public CreationTime As Date

    ''' <summary>
    ''' All recipients
    ''' </summary>
    Public AllRecipients As String

    ''' <summary>
    ''' The received by name
    ''' </summary>
    Public ReceivedByName As String

    ''' <summary>
    ''' The received time
    ''' </summary>
    Public ReceivedTime As Date

    ''' <summary>
    ''' The MSG size
    ''' </summary>
    Public MsgSize As Integer

    ''' <summary>
    ''' The subject
    ''' </summary>
    Public SUBJECT As String

    ''' <summary>
    ''' The original folder
    ''' </summary>
    Public OriginalFolder As String

    ''' <summary>
    ''' The email unique identifier
    ''' </summary>
    Public EmailGuid As String

    ''' <summary>
    ''' The retention expiration date
    ''' </summary>
    Public RetentionExpirationDate As Date

    ''' <summary>
    ''' The is public
    ''' </summary>
    Public isPublic As String

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    Public UserID As String

    ''' <summary>
    ''' The source type code
    ''' </summary>
    Public SourceTypeCode As String

    ''' <summary>
    ''' The NBR attachments
    ''' </summary>
    Public NbrAttachments As Integer

    ''' <summary>
    ''' The rid
    ''' </summary>
    Public RID As String

    ''' <summary>
    ''' The repo SVR name
    ''' </summary>
    Public RepoSvrName As String

    ''' <summary>
    ''' The rowid
    ''' </summary>
    Public ROWID As String

End Class

''' <summary>
''' Class DS_EMAIL.
''' </summary>
Public Class DS_EMAIL

    ''' <summary>
    ''' The rank
    ''' </summary>
    Public RANK As Integer

    ''' <summary>
    ''' The sent on
    ''' </summary>
    Public SentOn As Date

    ''' <summary>
    ''' The short subj
    ''' </summary>
    Public ShortSubj As String

    ''' <summary>
    ''' The sender email address
    ''' </summary>
    Public SenderEmailAddress As String

    ''' <summary>
    ''' The sender name
    ''' </summary>
    Public SenderName As String

    ''' <summary>
    ''' The sent to
    ''' </summary>
    Public SentTO As String

    ''' <summary>
    ''' The body
    ''' </summary>
    Public Body As String

    ''' <summary>
    ''' The cc
    ''' </summary>
    Public CC As String

    ''' <summary>
    ''' The BCC
    ''' </summary>
    Public Bcc As String

    ''' <summary>
    ''' The creation time
    ''' </summary>
    Public CreationTime As Date

    ''' <summary>
    ''' All recipients
    ''' </summary>
    Public AllRecipients As String

    ''' <summary>
    ''' The received by name
    ''' </summary>
    Public ReceivedByName As String

    ''' <summary>
    ''' The received time
    ''' </summary>
    Public ReceivedTime As Date

    ''' <summary>
    ''' The MSG size
    ''' </summary>
    Public MsgSize As Integer

    ''' <summary>
    ''' The subject
    ''' </summary>
    Public SUBJECT As String

    ''' <summary>
    ''' The original folder
    ''' </summary>
    Public OriginalFolder As String

    ''' <summary>
    ''' The email unique identifier
    ''' </summary>
    Public EmailGuid As String

    ''' <summary>
    ''' The retention expiration date
    ''' </summary>
    Public RetentionExpirationDate As Date

    ''' <summary>
    ''' The is public
    ''' </summary>
    Public isPublic As String

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    Public UserID As String

    ''' <summary>
    ''' The source type code
    ''' </summary>
    Public SourceTypeCode As String

    ''' <summary>
    ''' The NBR attachments
    ''' </summary>
    Public NbrAttachments As Integer

    ''' <summary>
    ''' The rid
    ''' </summary>
    Public RID As String

    ''' <summary>
    ''' The repo SVR name
    ''' </summary>
    Public RepoSvrName As String

    ''' <summary>
    ''' The rowid
    ''' </summary>
    Public ROWID As String

    ''' <summary>
    ''' The found in attach
    ''' </summary>
    Public FoundInAttach As Boolean

End Class

''' <summary>
''' Class DS_CONTENT.
''' </summary>
Public Class DS_CONTENT

    ''' <summary>
    ''' The create date
    ''' </summary>
    Public CreateDate As DateTime
    ''' <summary>
    ''' The data source owner user identifier
    ''' </summary>
    Public DataSourceOwnerUserID As String
    ''' <summary>
    ''' The description
    ''' </summary>
    Public Description As String
    ''' <summary>
    ''' The file directory
    ''' </summary>
    Public FileDirectory As String
    ''' <summary>
    ''' The file length
    ''' </summary>
    Public FileLength As Integer
    ''' <summary>
    ''' The FQN
    ''' </summary>
    Public FQN As String
    ''' <summary>
    ''' The is public
    ''' </summary>
    Public isPublic As String
    ''' <summary>
    ''' The is web page
    ''' </summary>
    Public isWebPage As String
    ''' <summary>
    ''' The last access date
    ''' </summary>
    Public LastAccessDate As DateTime
    ''' <summary>
    ''' The last write time
    ''' </summary>
    Public LastWriteTime As DateTime
    ''' <summary>
    ''' The repo SVR name
    ''' </summary>
    Public RepoSvrName As String
    ''' <summary>
    ''' The retention expiration date
    ''' </summary>
    Public RetentionExpirationDate As DateTime
    ''' <summary>
    ''' The RSS link FLG
    ''' </summary>
    Public RssLinkFlg As Boolean
    ''' <summary>
    ''' The source unique identifier
    ''' </summary>
    Public SourceGuid As String
    ''' <summary>
    ''' The source name
    ''' </summary>
    Public SourceName As String
    ''' <summary>
    ''' The source type code
    ''' </summary>
    Public SourceTypeCode As String
    ''' <summary>
    ''' The structured data
    ''' </summary>
    Public StructuredData As Boolean
    ''' <summary>
    ''' The version NBR
    ''' </summary>
    Public VersionNbr As Integer

End Class

''' <summary>
''' Class DS_License.
''' </summary>
Public Class DS_License

    ''' <summary>
    ''' The license NBR
    ''' </summary>
    Public LicenseNbr As Integer

    ''' <summary>
    ''' The company identifier
    ''' </summary>
    Public CompanyID As String

    ''' <summary>
    ''' The machine identifier
    ''' </summary>
    Public MachineID As String

    ''' <summary>
    ''' The license identifier
    ''' </summary>
    Public LicenseID As String

    ''' <summary>
    ''' The applied
    ''' </summary>
    Public Applied As String

    ''' <summary>
    ''' The purchased machines
    ''' </summary>
    Public PurchasedMachines As String

    ''' <summary>
    ''' The purchased users
    ''' </summary>
    Public PurchasedUsers As String

    ''' <summary>
    ''' The support active
    ''' </summary>
    Public SupportActive As String

    ''' <summary>
    ''' The support active date
    ''' </summary>
    Public SupportActiveDate As String

    ''' <summary>
    ''' The support inactive date
    ''' </summary>
    Public SupportInactiveDate As String

    ''' <summary>
    ''' The license text
    ''' </summary>
    Public LicenseText As String

    ''' <summary>
    ''' The license type code
    ''' </summary>
    Public LicenseTypeCode As String

    ''' <summary>
    ''' The encrypted license
    ''' </summary>
    Public EncryptedLicense As String

    ''' <summary>
    ''' The server name
    ''' </summary>
    Public ServerNAME As String

    ''' <summary>
    ''' The SQL instance name
    ''' </summary>
    Public SqlInstanceName As String

End Class

''' <summary>
''' Class DS_ErrorLogs.
''' </summary>
Public Class DS_ErrorLogs

    ''' <summary>
    ''' The severity
    ''' </summary>
    Public Severity As String

    ''' <summary>
    ''' The logged message
    ''' </summary>
    Public LoggedMessage As String

    ''' <summary>
    ''' The entry date
    ''' </summary>
    Public EntryDate As DateTime

    ''' <summary>
    ''' The log name
    ''' </summary>
    Public LogName As String

    ''' <summary>
    ''' The entry user identifier
    ''' </summary>
    Public EntryUserID As String

End Class

''' <summary>
''' Class DS_USERSCREENSTATE.
''' </summary>
Public Class DS_USERSCREENSTATE

    ''' <summary>
    ''' The screen name
    ''' </summary>
    Public ScreenName As String

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    Public UserID As String

    ''' <summary>
    ''' The parm name
    ''' </summary>
    Public ParmName As String

    ''' <summary>
    ''' The parm value
    ''' </summary>
    Public ParmVal As String

    ''' <summary>
    ''' The parm data type
    ''' </summary>
    Public ParmDataType As String

    ''' <summary>
    ''' The hive connection name
    ''' </summary>
    Public HiveConnectionName As String

    ''' <summary>
    ''' The hive active
    ''' </summary>
    Public HiveActive As Boolean

    ''' <summary>
    ''' The repo SVR name
    ''' </summary>
    Public RepoSvrName As String

    ''' <summary>
    ''' The row creation date
    ''' </summary>
    Public RowCreationDate As Date

    ''' <summary>
    ''' The row last mod date
    ''' </summary>
    Public RowLastModDate As Date

    ''' <summary>
    ''' The row NBR
    ''' </summary>
    Public RowNbr As Integer

End Class

''' <summary>
''' Class DS_USERSEARCHSTATE.
''' </summary>
Public Class DS_USERSEARCHSTATE

    ''' <summary>
    ''' The search identifier
    ''' </summary>
    Public SearchID As Integer

    ''' <summary>
    ''' The screen name
    ''' </summary>
    Public ScreenName As String

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    Public UserID As String

    ''' <summary>
    ''' The parm name
    ''' </summary>
    Public ParmName As String

    ''' <summary>
    ''' The parm value
    ''' </summary>
    Public ParmVal As String

    ''' <summary>
    ''' The parm data type
    ''' </summary>
    Public ParmDataType As String

    ''' <summary>
    ''' The hive connection name
    ''' </summary>
    Public HiveConnectionName As String

    ''' <summary>
    ''' The hive active
    ''' </summary>
    Public HiveActive As Boolean

    ''' <summary>
    ''' The repo SVR name
    ''' </summary>
    Public RepoSvrName As String

    ''' <summary>
    ''' The row creation date
    ''' </summary>
    Public RowCreationDate As Date

    ''' <summary>
    ''' The row last mod date
    ''' </summary>
    Public RowLastModDate As Date

    ''' <summary>
    ''' The row NBR
    ''' </summary>
    Public RowNbr As Integer

End Class

''' <summary>
''' Class DS_clsUSERGRIDSTATE.
''' </summary>
Public Class DS_clsUSERGRIDSTATE

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    Public UserID As String

    ''' <summary>
    ''' The screen name
    ''' </summary>
    Public ScreenName As String

    ''' <summary>
    ''' The grid name
    ''' </summary>
    Public GridName As String

    ''' <summary>
    ''' The col name
    ''' </summary>
    Public ColName As String

    ''' <summary>
    ''' The col order
    ''' </summary>
    Public ColOrder As Integer

    ''' <summary>
    ''' The col width
    ''' </summary>
    Public ColWidth As Integer

    ''' <summary>
    ''' The col visible
    ''' </summary>
    Public ColVisible As Boolean

    ''' <summary>
    ''' The col read only
    ''' </summary>
    Public ColReadOnly As Boolean

    ''' <summary>
    ''' The col sort order
    ''' </summary>
    Public ColSortOrder As Integer

    ''' <summary>
    ''' The col sort asc
    ''' </summary>
    Public ColSortAsc As Boolean

    ''' <summary>
    ''' The hive connection name
    ''' </summary>
    Public HiveConnectionName As String

    ''' <summary>
    ''' The hive active
    ''' </summary>
    Public HiveActive As Boolean

    ''' <summary>
    ''' The repo SVR name
    ''' </summary>
    Public RepoSvrName As String

    ''' <summary>
    ''' The row creation date
    ''' </summary>
    Public RowCreationDate As Date

    ''' <summary>
    ''' The row last mod date
    ''' </summary>
    Public RowLastModDate As Date

    ''' <summary>
    ''' The row NBR
    ''' </summary>
    Public RowNbr As Integer

End Class

''' <summary>
''' Class DS_SearchTerms.
''' </summary>
Public Class DS_SearchTerms

    ''' <summary>
    ''' The search type code
    ''' </summary>
    Public SearchTypeCode As String

    ''' <summary>
    ''' The term
    ''' </summary>
    Public Term As String

    ''' <summary>
    ''' The term value
    ''' </summary>
    Public TermVal As String

    ''' <summary>
    ''' The term datatype
    ''' </summary>
    Public TermDatatype As String

End Class

''' <summary>
''' Class DS_SYSTEMPARMS.
''' </summary>
Public Class DS_SYSTEMPARMS

    ''' <summary>
    ''' The system parm
    ''' </summary>
    Public SysParm As String

    ''' <summary>
    ''' The system parm desc
    ''' </summary>
    Public SysParmDesc As String

    ''' <summary>
    ''' The system parm value
    ''' </summary>
    Public SysParmVal As String

    ''' <summary>
    ''' The FLG active
    ''' </summary>
    Public flgActive As String

    ''' <summary>
    ''' The is directory
    ''' </summary>
    Public isDirectory As String

    ''' <summary>
    ''' The is email folder
    ''' </summary>
    Public isEmailFolder As String

    ''' <summary>
    ''' The FLG all sub dirs
    ''' </summary>
    Public flgAllSubDirs As String

    ''' <summary>
    ''' The hive connection name
    ''' </summary>
    Public HiveConnectionName As String

    ''' <summary>
    ''' The hive active
    ''' </summary>
    Public HiveActive As Boolean

    ''' <summary>
    ''' The repo SVR name
    ''' </summary>
    Public RepoSvrName As String

    ''' <summary>
    ''' The row creation date
    ''' </summary>
    Public RowCreationDate As Date

    ''' <summary>
    ''' The row last mod date
    ''' </summary>
    Public RowLastModDate As Date

End Class

''' <summary>
''' Class DS_VLibraryStats.
''' </summary>
Public Class DS_VLibraryStats

    ''' <summary>
    ''' The library name
    ''' </summary>
    Public LibraryName As String

    ''' <summary>
    ''' The is public
    ''' </summary>
    Public isPublic As String

    ''' <summary>
    ''' The items
    ''' </summary>
    Public Items As Integer

    ''' <summary>
    ''' The members
    ''' </summary>
    Public Members As Integer

End Class

''' <summary>
''' Class DS_dgGrpUsers.
''' </summary>
Public Class DS_dgGrpUsers

    ''' <summary>
    ''' The user name
    ''' </summary>
    Public UserName As String

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    Public UserID As String

End Class

''' <summary>
''' Class DS_DgAssigned.
''' </summary>
Public Class DS_DgAssigned

    ''' <summary>
    ''' The group name
    ''' </summary>
    Public GroupName As String

    ''' <summary>
    ''' The group owner user identifier
    ''' </summary>
    Public GroupOwnerUserID As String

End Class

''' <summary>
''' Class DS_LibItems.
''' </summary>
Public Class DS_LibItems

    ''' <summary>
    ''' The item title
    ''' </summary>
    Public ItemTitle As String

    ''' <summary>
    ''' The item type
    ''' </summary>
    Public ItemType As String

    ''' <summary>
    ''' The library name
    ''' </summary>
    Public LibraryName As String

    ''' <summary>
    ''' The library owner user identifier
    ''' </summary>
    Public LibraryOwnerUserID As String

    ''' <summary>
    ''' The added by user unique identifier identifier
    ''' </summary>
    Public AddedByUserGuidId As String

    ''' <summary>
    ''' The data source owner user identifier
    ''' </summary>
    Public DataSourceOwnerUserID As String

    ''' <summary>
    ''' The source unique identifier
    ''' </summary>
    Public SourceGuid As String

    ''' <summary>
    ''' The library item unique identifier
    ''' </summary>
    Public LibraryItemGuid As String

End Class

''' <summary>
''' Class DS_DgGroupUsers.
''' </summary>
Public Class DS_DgGroupUsers

    ''' <summary>
    ''' The user name
    ''' </summary>
    Public UserName As String

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    Public UserID As String

    ''' <summary>
    ''' The full access
    ''' </summary>
    Public FullAccess As Boolean

    ''' <summary>
    ''' The read only access
    ''' </summary>
    Public ReadOnlyAccess As Boolean

    ''' <summary>
    ''' The delete access
    ''' </summary>
    Public DeleteAccess As Boolean

    ''' <summary>
    ''' The searchable
    ''' </summary>
    Public Searchable As Boolean

End Class

''' <summary>
''' Class DS_VUserGrid.
''' </summary>
Public Class DS_VUserGrid

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    Public UserID As String

    ''' <summary>
    ''' The user name
    ''' </summary>
    Public UserName As String

    ''' <summary>
    ''' The email address
    ''' </summary>
    Public EmailAddress As String

    ''' <summary>
    ''' The admin
    ''' </summary>
    Public Admin As String

    ''' <summary>
    ''' The is active
    ''' </summary>
    Public isActive As String

    ''' <summary>
    ''' The user login identifier
    ''' </summary>
    Public UserLoginID As String

    ''' <summary>
    ''' The client only
    ''' </summary>
    Public ClientOnly As Boolean

    ''' <summary>
    ''' The hive connection name
    ''' </summary>
    Public HiveConnectionName As String

    ''' <summary>
    ''' The hive active
    ''' </summary>
    Public HiveActive As Boolean

    ''' <summary>
    ''' The repo SVR name
    ''' </summary>
    Public RepoSvrName As String

    ''' <summary>
    ''' The row creation date
    ''' </summary>
    Public RowCreationDate As Date

    ''' <summary>
    ''' The row last mod date
    ''' </summary>
    Public RowLastModDate As Date

End Class

''' <summary>
''' Class DS_CoOwner.
''' </summary>
Public Class DS_CoOwner

    ''' <summary>
    ''' The co owner name
    ''' </summary>
    Public CoOwnerName As String

    ''' <summary>
    ''' The co owner identifier
    ''' </summary>
    Public CoOwnerID As String

    ''' <summary>
    ''' The row identifier
    ''' </summary>
    Public RowID As Integer

End Class

''' <summary>
''' Class DS_VLibraryUsers.
''' </summary>
Public Class DS_VLibraryUsers

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    Public UserID As String

    ''' <summary>
    ''' The library name
    ''' </summary>
    Public LibraryName As String

    ''' <summary>
    ''' The library owner user identifier
    ''' </summary>
    Public LibraryOwnerUserID As String

    ''' <summary>
    ''' The user name
    ''' </summary>
    Public UserName As String

End Class

''' <summary>
''' Class DS_SEARCHSCHEDULE.
''' </summary>
Public Class DS_SEARCHSCHEDULE

    ''' <summary>
    ''' The search name
    ''' </summary>
    Public SearchName As String

    ''' <summary>
    ''' The notification SMS
    ''' </summary>
    Public NotificationSMS As String

    ''' <summary>
    ''' The search desc
    ''' </summary>
    Public SearchDesc As String

    ''' <summary>
    ''' The owner identifier
    ''' </summary>
    Public OwnerID As String

    ''' <summary>
    ''' The search query
    ''' </summary>
    Public SearchQuery As String

    ''' <summary>
    ''' The send to email
    ''' </summary>
    Public SendToEmail As String

    ''' <summary>
    ''' The schedule unit
    ''' </summary>
    Public ScheduleUnit As String

    ''' <summary>
    ''' The schedule hour
    ''' </summary>
    Public ScheduleHour As String

    ''' <summary>
    ''' The schedule days of week
    ''' </summary>
    Public ScheduleDaysOfWeek As String

    ''' <summary>
    ''' The schedule days of month
    ''' </summary>
    Public ScheduleDaysOfMonth As String

    ''' <summary>
    ''' The schedule month of QTR
    ''' </summary>
    Public ScheduleMonthOfQtr As String

    ''' <summary>
    ''' The start to run date
    ''' </summary>
    Public StartToRunDate As Date

    ''' <summary>
    ''' The end run date
    ''' </summary>
    Public EndRunDate As Date

    ''' <summary>
    ''' The search parameters
    ''' </summary>
    Public SearchParameters As String

    ''' <summary>
    ''' The last run date
    ''' </summary>
    Public LastRunDate As Date

    ''' <summary>
    ''' The number of executions
    ''' </summary>
    Public NumberOfExecutions As Integer

    ''' <summary>
    ''' The create date
    ''' </summary>
    Public CreateDate As Date

    ''' <summary>
    ''' The last mod date
    ''' </summary>
    Public LastModDate As Date

    ''' <summary>
    ''' The schedule hour interval
    ''' </summary>
    Public ScheduleHourInterval As Integer

    ''' <summary>
    ''' The repo name
    ''' </summary>
    Public RepoName As String

End Class

''' <summary>
''' Class DS_ListOfStrings01.
''' </summary>
Public Class DS_ListOfStrings01

    ''' <summary>
    ''' The string item
    ''' </summary>
    Public strItem As String

End Class

''' <summary>
''' Class DS_ListOfStrings02.
''' </summary>
Public Class DS_ListOfStrings02

    ''' <summary>
    ''' The string item
    ''' </summary>
    Public strItem As String

End Class

''' <summary>
''' Class DS_ListOfStrings03.
''' </summary>
Public Class DS_ListOfStrings03

    ''' <summary>
    ''' The string item
    ''' </summary>
    Public strItem As String

End Class

''' <summary>
''' Class DS_ListOfStrings04.
''' </summary>
Public Class DS_ListOfStrings04

    ''' <summary>
    ''' The string item
    ''' </summary>
    Public strItem As String

End Class

''' <summary>
''' Class DS_RESTOREQUEUE.
''' </summary>
Public Class DS_RESTOREQUEUE

    ''' <summary>
    ''' The content unique identifier
    ''' </summary>
    Public ContentGuid As String

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    Public UserID As String

    ''' <summary>
    ''' The machine identifier
    ''' </summary>
    Public MachineID As String

    ''' <summary>
    ''' The FQN
    ''' </summary>
    Public FQN As String

    ''' <summary>
    ''' The file size
    ''' </summary>
    Public FileSize As Integer

    ''' <summary>
    ''' The content type
    ''' </summary>
    Public ContentType As String

    ''' <summary>
    ''' The preview
    ''' </summary>
    Public Preview As Boolean

    ''' <summary>
    ''' The restore
    ''' </summary>
    Public Restore As Boolean

    ''' <summary>
    ''' The processing completed
    ''' </summary>
    Public ProcessingCompleted As Boolean

    ''' <summary>
    ''' The entry date
    ''' </summary>
    Public EntryDate As Date

    ''' <summary>
    ''' The processed date
    ''' </summary>
    Public ProcessedDate As Date

    ''' <summary>
    ''' The start download time
    ''' </summary>
    Public StartDownloadTime As Date

    ''' <summary>
    ''' The end download time
    ''' </summary>
    Public EndDownloadTime As Date

    ''' <summary>
    ''' The repo name
    ''' </summary>
    Public RepoName As String

    ''' <summary>
    ''' The row unique identifier
    ''' </summary>
    Public RowGuid As Guid

End Class

''' <summary>
''' Class DS_Metadata.
''' </summary>
Public Class DS_Metadata

    ''' <summary>
    ''' The attribute name
    ''' </summary>
    Public AttributeName As String

    ''' <summary>
    ''' The attribute value
    ''' </summary>
    Public AttributeValue As String

End Class
Imports System
Imports System.Data.Entity
Imports System.ComponentModel.DataAnnotations.Schema
Imports System.Linq

Partial Public Class ERD
    Inherits DbContext

    Public Sub New()
        MyBase.New("name=ERD")
    End Sub

    Public Overridable Property ArchiveFroms As DbSet(Of ArchiveFrom)
    Public Overridable Property ArchiveHists As DbSet(Of ArchiveHist)
    Public Overridable Property ArchiveHistContentTypes As DbSet(Of ArchiveHistContentType)
    Public Overridable Property AttachmentTypes As DbSet(Of AttachmentType)
    Public Overridable Property AttributeDatatypes As DbSet(Of AttributeDatatype)
    Public Overridable Property Attributes As DbSet(Of Attribute)
    Public Overridable Property AvailFileTypes As DbSet(Of AvailFileType)
    Public Overridable Property BusinessFunctionJargons As DbSet(Of BusinessFunctionJargon)
    Public Overridable Property BusinessJargonCodes As DbSet(Of BusinessJargonCode)
    Public Overridable Property CaptureItems As DbSet(Of CaptureItem)
    Public Overridable Property ContactFroms As DbSet(Of ContactFrom)
    Public Overridable Property ContactsArchives As DbSet(Of ContactsArchive)
    Public Overridable Property Containers As DbSet(Of Container)
    Public Overridable Property ContainerStorages As DbSet(Of ContainerStorage)
    Public Overridable Property ContentContainers As DbSet(Of ContentContainer)
    Public Overridable Property ContentUsers As DbSet(Of ContentUser)
    Public Overridable Property ConvertedDocs As DbSet(Of ConvertedDoc)
    Public Overridable Property CoOwners As DbSet(Of CoOwner)
    Public Overridable Property CorpContainers As DbSet(Of CorpContainer)
    Public Overridable Property CorpFunctions As DbSet(Of CorpFunction)
    Public Overridable Property Corporations As DbSet(Of Corporation)
    Public Overridable Property Databases As DbSet(Of Databas)
    Public Overridable Property DataOwners As DbSet(Of DataOwner)
    Public Overridable Property DataSourceCheckOuts As DbSet(Of DataSourceCheckOut)
    Public Overridable Property DataSourceRestoreHistories As DbSet(Of DataSourceRestoreHistory)
    Public Overridable Property DeleteFroms As DbSet(Of DeleteFrom)
    Public Overridable Property Directories As DbSet(Of Directory)
    Public Overridable Property EcmUsers As DbSet(Of EcmUser)
    Public Overridable Property Emails As DbSet(Of Email)
    Public Overridable Property EmailAttachments As DbSet(Of EmailAttachment)
    Public Overridable Property ExcludedFiles As DbSet(Of ExcludedFile)
    Public Overridable Property ExcludeFroms As DbSet(Of ExcludeFrom)
    Public Overridable Property FUncSkipWords As DbSet(Of FUncSkipWord)
    Public Overridable Property FunctionProdJargons As DbSet(Of FunctionProdJargon)
    Public Overridable Property GraphicFileTypes As DbSet(Of GraphicFileType)
    Public Overridable Property GroupLibraryAccesses As DbSet(Of GroupLibraryAccess)
    Public Overridable Property GroupUsers As DbSet(Of GroupUser)
    Public Overridable Property IncludedFiles As DbSet(Of IncludedFile)
    Public Overridable Property IncludeImmediates As DbSet(Of IncludeImmediate)
    Public Overridable Property InformationProducts As DbSet(Of InformationProduct)
    Public Overridable Property InformationTypes As DbSet(Of InformationType)
    Public Overridable Property JargonWords As DbSet(Of JargonWord)
    Public Overridable Property KTBLs As DbSet(Of KTBL)
    Public Overridable Property LibDirectories As DbSet(Of LibDirectory)
    Public Overridable Property LibEmails As DbSet(Of LibEmail)
    Public Overridable Property Libraries As DbSet(Of Library)
    Public Overridable Property LibraryItems As DbSet(Of LibraryItem)
    Public Overridable Property LibraryUsers As DbSet(Of LibraryUser)
    Public Overridable Property LoadProfiles As DbSet(Of LoadProfile)
    Public Overridable Property LoadProfileItems As DbSet(Of LoadProfileItem)
    Public Overridable Property MachineRegistereds As DbSet(Of MachineRegistered)
    Public Overridable Property MyTempTables As DbSet(Of MyTempTable)
    Public Overridable Property OutlookFroms As DbSet(Of OutlookFrom)
    Public Overridable Property OwnerHistories As DbSet(Of OwnerHistory)
    Public Overridable Property ProcessFileAs As DbSet(Of ProcessFileA)
    Public Overridable Property ProdCaptureItems As DbSet(Of ProdCaptureItem)
    Public Overridable Property QtyDocs As DbSet(Of QtyDoc)
    Public Overridable Property QuickDirectories As DbSet(Of QuickDirectory)
    Public Overridable Property QuickRefs As DbSet(Of QuickRef)
    Public Overridable Property QuickRefItems As DbSet(Of QuickRefItem)
    Public Overridable Property Recipients As DbSet(Of Recipient)
    Public Overridable Property RepeatDatas As DbSet(Of RepeatData)
    Public Overridable Property reports As DbSet(Of report)
    Public Overridable Property Retentions As DbSet(Of Retention)
    Public Overridable Property RunParms As DbSet(Of RunParm)
    Public Overridable Property SearchGuids As DbSet(Of SearchGuid)
    Public Overridable Property SessionIDs As DbSet(Of SessionID)
    Public Overridable Property SkipWords As DbSet(Of SkipWord)
    Public Overridable Property SourceAttributes As DbSet(Of SourceAttribute)
    Public Overridable Property SourceContainers As DbSet(Of SourceContainer)
    Public Overridable Property SourceInjectors As DbSet(Of SourceInjector)
    Public Overridable Property SourceTypes As DbSet(Of SourceType)
    Public Overridable Property StatsClicks As DbSet(Of StatsClick)
    Public Overridable Property StatSearches As DbSet(Of StatSearch)
    Public Overridable Property StatWords As DbSet(Of StatWord)
    Public Overridable Property Storages As DbSet(Of Storage)
    Public Overridable Property SubDirs As DbSet(Of SubDir)
    Public Overridable Property SubLibraries As DbSet(Of SubLibrary)
    Public Overridable Property UD_Qty As DbSet(Of UD_Qty)
    Public Overridable Property UserGroups As DbSet(Of UserGroup)
    Public Overridable Property Users As DbSet(Of User)
    Public Overridable Property Volitilities As DbSet(Of Volitility)
    Public Overridable Property WebSources As DbSet(Of WebSource)
    Public Overridable Property ZippedFiles As DbSet(Of ZippedFile)
    Public Overridable Property ActiveDirUsers As DbSet(Of ActiveDirUser)
    Public Overridable Property ActiveSearchGuids As DbSet(Of ActiveSearchGuid)
    Public Overridable Property ActiveSessions As DbSet(Of ActiveSession)
    Public Overridable Property AlertContacts As DbSet(Of AlertContact)
    Public Overridable Property AlertHistories As DbSet(Of AlertHistory)
    Public Overridable Property AlertWords As DbSet(Of AlertWord)
    Public Overridable Property ArchiveStats As DbSet(Of ArchiveStat)
    Public Overridable Property AssignableUserParameters As DbSet(Of AssignableUserParameter)
    Public Overridable Property AvailFileTypesUndefineds As DbSet(Of AvailFileTypesUndefined)
    Public Overridable Property CLC_DIR As DbSet(Of CLC_DIR)
    Public Overridable Property CLC_Download As DbSet(Of CLC_Download)
    Public Overridable Property CLC_Preview As DbSet(Of CLC_Preview)
    Public Overridable Property CLCStates As DbSet(Of CLCState)
    Public Overridable Property ConnectionStrings As DbSet(Of ConnectionString)
    Public Overridable Property ConnectionStringsRegistereds As DbSet(Of ConnectionStringsRegistered)
    Public Overridable Property ConnectionStringsSaveds As DbSet(Of ConnectionStringsSaved)
    Public Overridable Property CS As DbSet(Of C)
    Public Overridable Property CS_SharePoint As DbSet(Of CS_SharePoint)
    Public Overridable Property DatabaseFiles As DbSet(Of DatabaseFile)
    Public Overridable Property DataSources As DbSet(Of DataSource)
    Public Overridable Property DataSourceChildrens As DbSet(Of DataSourceChildren)
    Public Overridable Property DataSourceOwners As DbSet(Of DataSourceOwner)
    Public Overridable Property DB_UpdateHist As DbSet(Of DB_UpdateHist)
    Public Overridable Property DB_Updates As DbSet(Of DB_Updates)
    Public Overridable Property DirArchLibs As DbSet(Of DirArchLib)
    Public Overridable Property DirectoryGuids As DbSet(Of DirectoryGuid)
    Public Overridable Property DirectoryListeners As DbSet(Of DirectoryListener)
    Public Overridable Property DirectoryListenerFiles As DbSet(Of DirectoryListenerFile)
    Public Overridable Property DirectoryLongNames As DbSet(Of DirectoryLongName)
    Public Overridable Property DirectoryMonitorLogs As DbSet(Of DirectoryMonitorLog)
    Public Overridable Property DirectoryTemps As DbSet(Of DirectoryTemp)
    Public Overridable Property DirProfiles As DbSet(Of DirProfile)
    Public Overridable Property EmailArchParms As DbSet(Of EmailArchParm)
    Public Overridable Property EmailAttachmentSearchLists As DbSet(Of EmailAttachmentSearchList)
    Public Overridable Property EmailFolders As DbSet(Of EmailFolder)
    Public Overridable Property EmailFolder_BAK As DbSet(Of EmailFolder_BAK)
    Public Overridable Property EmailFolder_BAK2 As DbSet(Of EmailFolder_BAK2)
    Public Overridable Property EmailRunningTotals As DbSet(Of EmailRunningTotal)
    Public Overridable Property EmailToDeletes As DbSet(Of EmailToDelete)
    Public Overridable Property ErrorLogs As DbSet(Of ErrorLog)
    Public Overridable Property ExcgKeys As DbSet(Of ExcgKey)
    Public Overridable Property ExchangeHostPops As DbSet(Of ExchangeHostPop)
    Public Overridable Property ExchangeHostSmtps As DbSet(Of ExchangeHostSmtp)
    Public Overridable Property FileKeys As DbSet(Of FileKey)
    Public Overridable Property FileKeyMachines As DbSet(Of FileKeyMachine)
    Public Overridable Property FileKeyMachineDirs As DbSet(Of FileKeyMachineDir)
    Public Overridable Property GlobalAssoes As DbSet(Of GlobalAsso)
    Public Overridable Property GlobalDirectories As DbSet(Of GlobalDirectory)
    Public Overridable Property GlobalEmails As DbSet(Of GlobalEmail)
    Public Overridable Property GlobalFiles As DbSet(Of GlobalFile)
    Public Overridable Property GlobalLocations As DbSet(Of GlobalLocation)
    Public Overridable Property GlobalMachines As DbSet(Of GlobalMachine)
    Public Overridable Property GlobalSeachResults As DbSet(Of GlobalSeachResult)
    Public Overridable Property HashDirs As DbSet(Of HashDir)
    Public Overridable Property HashFiles As DbSet(Of HashFile)
    Public Overridable Property HelpInfoes As DbSet(Of HelpInfo)
    Public Overridable Property HelpTexts As DbSet(Of HelpText)
    Public Overridable Property HelpTextUsers As DbSet(Of HelpTextUser)
    Public Overridable Property HiveServers As DbSet(Of HiveServer)
    Public Overridable Property IPs As DbSet(Of IP)
    Public Overridable Property Licenses As DbSet(Of License)
    Public Overridable Property LoginClients As DbSet(Of LoginClient)
    Public Overridable Property LoginMachines As DbSet(Of LoginMachine)
    Public Overridable Property LoginUsers As DbSet(Of LoginUser)
    Public Overridable Property Logs As DbSet(Of Log)
    Public Overridable Property Machines As DbSet(Of Machine)
    Public Overridable Property PgmTraces As DbSet(Of PgmTrace)
    Public Overridable Property Queries As DbSet(Of Query)
    Public Overridable Property Repositories As DbSet(Of Repository)
    Public Overridable Property RestorationHistories As DbSet(Of RestorationHistory)
    Public Overridable Property RestoreQueues As DbSet(Of RestoreQueue)
    Public Overridable Property RestoreQueueHistories As DbSet(Of RestoreQueueHistory)
    Public Overridable Property RetentionTemps As DbSet(Of RetentionTemp)
    Public Overridable Property RSSChildrens As DbSet(Of RSSChildren)
    Public Overridable Property RuntimeErrors As DbSet(Of RuntimeError)
    Public Overridable Property SavedItems As DbSet(Of SavedItem)
    Public Overridable Property SearchHistories As DbSet(Of SearchHistory)
    Public Overridable Property SearchSchedules As DbSet(Of SearchSchedule)
    Public Overridable Property SearchUsers As DbSet(Of SearchUser)
    Public Overridable Property SearhParmsHistories As DbSet(Of SearhParmsHistory)
    Public Overridable Property ServiceActivities As DbSet(Of ServiceActivity)
    Public Overridable Property SessionVars As DbSet(Of SessionVar)
    Public Overridable Property StagedSQLs As DbSet(Of StagedSQL)
    Public Overridable Property StructuredDatas As DbSet(Of StructuredData)
    Public Overridable Property StructuredDataProcesseds As DbSet(Of StructuredDataProcessed)
    Public Overridable Property TempUserLibItems As DbSet(Of TempUserLibItem)
    Public Overridable Property TestTbls As DbSet(Of TestTbl)
    Public Overridable Property Traces As DbSet(Of Trace)
    Public Overridable Property txTimes As DbSet(Of txTime)
    Public Overridable Property upgrade_status As DbSet(Of upgrade_status)
    Public Overridable Property UserCurrParms As DbSet(Of UserCurrParm)
    Public Overridable Property UserGridStates As DbSet(Of UserGridState)
    Public Overridable Property UserReassignHists As DbSet(Of UserReassignHist)
    Public Overridable Property UserScreenStates As DbSet(Of UserScreenState)
    Public Overridable Property UserSearchStates As DbSet(Of UserSearchState)
    Public Overridable Property VersionInfoes As DbSet(Of VersionInfo)
    Public Overridable Property gv_ActiveSearchGuids As DbSet(Of gv_ActiveSearchGuids)
    Public Overridable Property gv_Archive_07202017134452007 As DbSet(Of gv_Archive_07202017134452007)
    Public Overridable Property gv_ArchiveFrom As DbSet(Of gv_ArchiveFrom)
    Public Overridable Property gv_ArchiveHist As DbSet(Of gv_ArchiveHist)
    Public Overridable Property gv_ArchiveHistContentType As DbSet(Of gv_ArchiveHistContentType)
    Public Overridable Property gv_ArchiveStats As DbSet(Of gv_ArchiveStats)
    Public Overridable Property gv_AssignableUserParameters As DbSet(Of gv_AssignableUserParameters)
    Public Overridable Property gv_AttachmentType As DbSet(Of gv_AttachmentType)
    Public Overridable Property gv_AttributeDatatype As DbSet(Of gv_AttributeDatatype)
    Public Overridable Property gv_Attributes As DbSet(Of gv_Attributes)
    Public Overridable Property gv_AvailFileTypes As DbSet(Of gv_AvailFileTypes)
    Public Overridable Property gv_AvailFileTypesUndefined As DbSet(Of gv_AvailFileTypesUndefined)
    Public Overridable Property gv_BusinessFunctionJargon As DbSet(Of gv_BusinessFunctionJargon)
    Public Overridable Property gv_BusinessJargonCode As DbSet(Of gv_BusinessJargonCode)
    Public Overridable Property gv_CaptureItems As DbSet(Of gv_CaptureItems)
    Public Overridable Property gv_Contact_07202017134458008 As DbSet(Of gv_Contact_07202017134458008)
    Public Overridable Property gv_ContactFrom As DbSet(Of gv_ContactFrom)
    Public Overridable Property gv_ContactsArchive As DbSet(Of gv_ContactsArchive)
    Public Overridable Property gv_ContainerStorage As DbSet(Of gv_ContainerStorage)
    Public Overridable Property gv_ConvertedDocs As DbSet(Of gv_ConvertedDocs)
    Public Overridable Property gv_CoOwner As DbSet(Of gv_CoOwner)
    Public Overridable Property gv_CorpContainer As DbSet(Of gv_CorpContainer)
    Public Overridable Property gv_CorpFunction As DbSet(Of gv_CorpFunction)
    Public Overridable Property gv_Corporation As DbSet(Of gv_Corporation)
    Public Overridable Property gv_Databases As DbSet(Of gv_Databases)
    Public Overridable Property gv_DataOwners As DbSet(Of gv_DataOwners)
    Public Overridable Property gv_DataSourceCheckOut As DbSet(Of gv_DataSourceCheckOut)
    Public Overridable Property gv_DataSourceRestoreHistory As DbSet(Of gv_DataSourceRestoreHistory)
    Public Overridable Property gv_DB_UpdateHist As DbSet(Of gv_DB_UpdateHist)
    Public Overridable Property gv_DeleteF_07202017134505007 As DbSet(Of gv_DeleteF_07202017134505007)
    Public Overridable Property gv_DeleteFrom As DbSet(Of gv_DeleteFrom)
    Public Overridable Property gv_Directory As DbSet(Of gv_Directory)
    Public Overridable Property gv_EcmUser As DbSet(Of gv_EcmUser)
    Public Overridable Property gv_EmailArchParms As DbSet(Of gv_EmailArchParms)
    Public Overridable Property gv_EmailAttachmentSearchList As DbSet(Of gv_EmailAttachmentSearchList)
    Public Overridable Property gv_EmailFolder As DbSet(Of gv_EmailFolder)
    Public Overridable Property gv_EmailToDelete As DbSet(Of gv_EmailToDelete)
    Public Overridable Property gv_ExcludedFiles As DbSet(Of gv_ExcludedFiles)
    Public Overridable Property gv_ExcludeFrom As DbSet(Of gv_ExcludeFrom)
    Public Overridable Property gv_FUncSkipWords As DbSet(Of gv_FUncSkipWords)
    Public Overridable Property gv_FunctionProdJargon As DbSet(Of gv_FunctionProdJargon)
    Public Overridable Property gv_GlobalSeachResults As DbSet(Of gv_GlobalSeachResults)
    Public Overridable Property gv_GroupLibraryAccess As DbSet(Of gv_GroupLibraryAccess)
    Public Overridable Property gv_GroupUsers As DbSet(Of gv_GroupUsers)
    Public Overridable Property gv_HelpText As DbSet(Of gv_HelpText)
    Public Overridable Property gv_HelpTextUser As DbSet(Of gv_HelpTextUser)
    Public Overridable Property gv_Include_07202017134438007 As DbSet(Of gv_Include_07202017134438007)
    Public Overridable Property gv_IncludedFiles As DbSet(Of gv_IncludedFiles)
    Public Overridable Property gv_IncludeImmediate As DbSet(Of gv_IncludeImmediate)
    Public Overridable Property gv_InformationProduct As DbSet(Of gv_InformationProduct)
    Public Overridable Property gv_InformationType As DbSet(Of gv_InformationType)
    Public Overridable Property gv_JargonWords As DbSet(Of gv_JargonWords)
    Public Overridable Property gv_LibDirectory As DbSet(Of gv_LibDirectory)
    Public Overridable Property gv_LibEmail As DbSet(Of gv_LibEmail)
    Public Overridable Property gv_Library As DbSet(Of gv_Library)
    Public Overridable Property gv_LibraryItems As DbSet(Of gv_LibraryItems)
    Public Overridable Property gv_LibraryUsers As DbSet(Of gv_LibraryUsers)
    Public Overridable Property gv_License As DbSet(Of gv_License)
    Public Overridable Property gv_LoadProfile As DbSet(Of gv_LoadProfile)
    Public Overridable Property gv_LoadProfileItem As DbSet(Of gv_LoadProfileItem)
    Public Overridable Property gv_Machine As DbSet(Of gv_Machine)
    Public Overridable Property gv_MyTempTable As DbSet(Of gv_MyTempTable)
    Public Overridable Property gv_Outlook_07202017134444008 As DbSet(Of gv_Outlook_07202017134444008)
    Public Overridable Property gv_OutlookFrom As DbSet(Of gv_OutlookFrom)
    Public Overridable Property gv_OwnerHistory As DbSet(Of gv_OwnerHistory)
    Public Overridable Property gv_PgmTrace As DbSet(Of gv_PgmTrace)
    Public Overridable Property gv_ProcessFileAs As DbSet(Of gv_ProcessFileAs)
    Public Overridable Property gv_ProdCaptureItems As DbSet(Of gv_ProdCaptureItems)
    Public Overridable Property gv_QtyDocs As DbSet(Of gv_QtyDocs)
    Public Overridable Property gv_QuickDirectory As DbSet(Of gv_QuickDirectory)
    Public Overridable Property gv_QuickRef As DbSet(Of gv_QuickRef)
    Public Overridable Property gv_QuickRefItems As DbSet(Of gv_QuickRefItems)
    Public Overridable Property gv_Recipients As DbSet(Of gv_Recipients)
    Public Overridable Property gv_RepeatData As DbSet(Of gv_RepeatData)
    Public Overridable Property gv_RestorationHistory As DbSet(Of gv_RestorationHistory)
    Public Overridable Property gv_Retention As DbSet(Of gv_Retention)
    Public Overridable Property gv_RetentionTemp As DbSet(Of gv_RetentionTemp)
    Public Overridable Property gv_RunParms As DbSet(Of gv_RunParms)
    Public Overridable Property gv_RuntimeErrors As DbSet(Of gv_RuntimeErrors)
    Public Overridable Property gv_SavedItems As DbSet(Of gv_SavedItems)
    Public Overridable Property gv_SearchHistory As DbSet(Of gv_SearchHistory)
    Public Overridable Property gv_SearhParmsHistory As DbSet(Of gv_SearhParmsHistory)
    Public Overridable Property gv_SkipWords As DbSet(Of gv_SkipWords)
    Public Overridable Property gv_SourceAttribute As DbSet(Of gv_SourceAttribute)
    Public Overridable Property gv_SourceContainer As DbSet(Of gv_SourceContainer)
    Public Overridable Property gv_SourceType As DbSet(Of gv_SourceType)
    Public Overridable Property gv_Storage As DbSet(Of gv_Storage)
    Public Overridable Property gv_SubDir As DbSet(Of gv_SubDir)
    Public Overridable Property gv_SubLibrary As DbSet(Of gv_SubLibrary)
    Public Overridable Property gv_UD_Qty As DbSet(Of gv_UD_Qty)
    Public Overridable Property gv_upgrade_status As DbSet(Of gv_upgrade_status)
    Public Overridable Property gv_UserCurrParm As DbSet(Of gv_UserCurrParm)
    Public Overridable Property gv_UserGroup As DbSet(Of gv_UserGroup)
    Public Overridable Property gv_UserReassignHist As DbSet(Of gv_UserReassignHist)
    Public Overridable Property gv_Users As DbSet(Of gv_Users)
    Public Overridable Property gv_Volitility As DbSet(Of gv_Volitility)
    Public Overridable Property gv_WebSource As DbSet(Of gv_WebSource)
    Public Overridable Property gv_ZippedFiles As DbSet(Of gv_ZippedFiles)
    Public Overridable Property vExchangeHostPops As DbSet(Of vExchangeHostPop)
    Public Overridable Property vFileDirectories As DbSet(Of vFileDirectory)
    Public Overridable Property vLibraryStats As DbSet(Of vLibraryStat)
    Public Overridable Property vLibraryUsers As DbSet(Of vLibraryUser)
    Public Overridable Property vMigrateUsers As DbSet(Of vMigrateUser)
    Public Overridable Property vReassignedTables As DbSet(Of vReassignedTable)
    Public Overridable Property vUserGrids As DbSet(Of vUserGrid)

    Protected Overrides Sub OnModelCreating(ByVal modelBuilder As DbModelBuilder)
        modelBuilder.Entity(Of ArchiveFrom)() _
            .Property(Function(e) e.SenderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of BusinessJargonCode)() _
            .HasMany(Function(e) e.JargonWords) _
            .WithRequired(Function(e) e.BusinessJargonCode) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of BusinessJargonCode)() _
            .HasMany(Function(e) e.FunctionProdJargons) _
            .WithRequired(Function(e) e.BusinessJargonCode) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of CaptureItem)() _
            .HasMany(Function(e) e.ProdCaptureItems) _
            .WithRequired(Function(e) e.CaptureItem) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of ContactFrom)() _
            .Property(Function(e) e.SenderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of ContentUser)() _
            .Property(Function(e) e.ContentTypeCode) _
            .IsFixedLength()

        modelBuilder.Entity(Of CorpContainer)() _
            .HasOptional(Function(e) e.InformationProduct) _
            .WithRequired(Function(e) e.CorpContainer)

        modelBuilder.Entity(Of CorpFunction)() _
            .HasMany(Function(e) e.BusinessFunctionJargons) _
            .WithRequired(Function(e) e.CorpFunction) _
            .HasForeignKey(Function(e) New With {e.CorpFuncName, e.CorpName}) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of CorpFunction)() _
            .HasMany(Function(e) e.CorpContainers) _
            .WithRequired(Function(e) e.CorpFunction) _
            .HasForeignKey(Function(e) New With {e.CorpFuncName, e.CorpName}) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of CorpFunction)() _
            .HasMany(Function(e) e.FunctionProdJargons) _
            .WithRequired(Function(e) e.CorpFunction) _
            .HasForeignKey(Function(e) New With {e.CorpFuncName, e.CorpName}) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of CorpFunction)() _
            .HasMany(Function(e) e.FUncSkipWords) _
            .WithRequired(Function(e) e.CorpFunction) _
            .HasForeignKey(Function(e) New With {e.CorpFuncName, e.CorpName}) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of Corporation)() _
            .HasMany(Function(e) e.ConvertedDocs) _
            .WithRequired(Function(e) e.Corporation) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of Corporation)() _
            .HasMany(Function(e) e.CorpFunctions) _
            .WithRequired(Function(e) e.Corporation) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of Databas)() _
            .HasMany(Function(e) e.EmailArchParms) _
            .WithRequired(Function(e) e.Databas) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of DataSourceRestoreHistory)() _
            .Property(Function(e) e.VerifiedData) _
            .IsFixedLength()

        modelBuilder.Entity(Of DeleteFrom)() _
            .Property(Function(e) e.SenderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of Directory)() _
            .Property(Function(e) e.IncludeSubDirs) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of Directory)() _
            .Property(Function(e) e.FQN) _
            .IsUnicode(False)

        modelBuilder.Entity(Of Directory)() _
            .Property(Function(e) e.VersionFiles) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of Directory)() _
            .Property(Function(e) e.ckMetaData) _
            .IsFixedLength()

        modelBuilder.Entity(Of Directory)() _
            .Property(Function(e) e.ckPublic) _
            .IsFixedLength()

        modelBuilder.Entity(Of Directory)() _
            .Property(Function(e) e.ckDisableDir) _
            .IsFixedLength()

        modelBuilder.Entity(Of Directory)() _
            .Property(Function(e) e.QuickRefEntry) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of Directory)() _
            .Property(Function(e) e.OcrDirectory) _
            .IsFixedLength()

        modelBuilder.Entity(Of Directory)() _
            .Property(Function(e) e.OcrPdf) _
            .IsFixedLength()

        modelBuilder.Entity(Of Directory)() _
            .Property(Function(e) e.DeleteOnArchive) _
            .IsFixedLength()

        modelBuilder.Entity(Of Directory)() _
            .HasMany(Function(e) e.SubDirs) _
            .WithRequired(Function(e) e.Directory) _
            .HasForeignKey(Function(e) New With {e.UserID, e.FQN}) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of EcmUser)() _
            .Property(Function(e) e.Authority) _
            .IsFixedLength()

        modelBuilder.Entity(Of Email)() _
            .Property(Function(e) e.Body) _
            .IsUnicode(False)

        modelBuilder.Entity(Of Email)() _
            .Property(Function(e) e.EntryID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of Email)() _
            .Property(Function(e) e.StoreID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of Email)() _
            .Property(Function(e) e.isPublic) _
            .IsFixedLength()

        modelBuilder.Entity(Of Email)() _
            .Property(Function(e) e.IsPublicPreviousState) _
            .IsFixedLength()

        modelBuilder.Entity(Of Email)() _
            .Property(Function(e) e.isAvailable) _
            .IsFixedLength()

        modelBuilder.Entity(Of Email)() _
            .Property(Function(e) e.isPerm) _
            .IsFixedLength()

        modelBuilder.Entity(Of Email)() _
            .Property(Function(e) e.isMaster) _
            .IsFixedLength()

        modelBuilder.Entity(Of Email)() _
            .Property(Function(e) e.ContainsAttachment) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of Email)() _
            .Property(Function(e) e.PdfIsSearchable) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of Email)() _
            .Property(Function(e) e.PdfOcrRequired) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of Email)() _
            .Property(Function(e) e.PdfOcrSuccess) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of Email)() _
            .Property(Function(e) e.PdfOcrTextExtracted) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailAttachment)() _
            .Property(Function(e) e.isPublic) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailAttachment)() _
            .Property(Function(e) e.RecHash) _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailAttachment)() _
            .Property(Function(e) e.OcrSuccessful) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailAttachment)() _
            .Property(Function(e) e.OcrPending) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailAttachment)() _
            .Property(Function(e) e.PdfIsSearchable) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailAttachment)() _
            .Property(Function(e) e.PdfOcrRequired) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailAttachment)() _
            .Property(Function(e) e.PdfOcrSuccess) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailAttachment)() _
            .Property(Function(e) e.PdfOcrTextExtracted) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailAttachment)() _
            .Property(Function(e) e.OcrPerformed) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of ExcludedFile)() _
            .Property(Function(e) e.FQN) _
            .IsUnicode(False)

        modelBuilder.Entity(Of ExcludeFrom)() _
            .Property(Function(e) e.SenderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of ExcludeFrom)() _
            .Property(Function(e) e.UserID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of FunctionProdJargon)() _
            .Property(Function(e) e.KeyFlag) _
            .IsFixedLength()

        modelBuilder.Entity(Of IncludeImmediate)() _
            .Property(Function(e) e.SenderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of InformationProduct)() _
            .Property(Function(e) e.Code) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of InformationProduct)() _
            .HasMany(Function(e) e.ProdCaptureItems) _
            .WithRequired(Function(e) e.InformationProduct) _
            .HasForeignKey(Function(e) New With {e.ContainerType, e.CorpFuncName, e.CorpName}) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of InformationType)() _
            .HasMany(Function(e) e.InformationProducts) _
            .WithRequired(Function(e) e.InformationType) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of JargonWord)() _
            .HasMany(Function(e) e.BusinessFunctionJargons) _
            .WithRequired(Function(e) e.JargonWord) _
            .HasForeignKey(Function(e) New With {e.JargonWords_tgtWord, e.JargonCode}) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of Library)() _
            .Property(Function(e) e.isPublic) _
            .IsFixedLength()

        modelBuilder.Entity(Of Library)() _
            .HasMany(Function(e) e.LibDirectories) _
            .WithRequired(Function(e) e.Library) _
            .HasForeignKey(Function(e) New With {e.UserID, e.LibraryName})

        modelBuilder.Entity(Of Library)() _
            .HasMany(Function(e) e.LibEmails) _
            .WithRequired(Function(e) e.Library) _
            .HasForeignKey(Function(e) New With {e.UserID, e.LibraryName})

        modelBuilder.Entity(Of Library)() _
            .HasMany(Function(e) e.SubLibraries) _
            .WithRequired(Function(e) e.Library) _
            .HasForeignKey(Function(e) New With {e.SubUserID, e.SubLibraryName}) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of Library)() _
            .HasMany(Function(e) e.SubLibraries1) _
            .WithRequired(Function(e) e.Library1) _
            .HasForeignKey(Function(e) New With {e.UserID, e.LibraryName}) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of OutlookFrom)() _
            .Property(Function(e) e.SenderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of QtyDoc)() _
            .HasMany(Function(e) e.CorpContainers) _
            .WithRequired(Function(e) e.QtyDoc) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of QuickDirectory)() _
            .Property(Function(e) e.IncludeSubDirs) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of QuickDirectory)() _
            .Property(Function(e) e.FQN) _
            .IsUnicode(False)

        modelBuilder.Entity(Of QuickDirectory)() _
            .Property(Function(e) e.VersionFiles) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of QuickDirectory)() _
            .Property(Function(e) e.ckMetaData) _
            .IsFixedLength()

        modelBuilder.Entity(Of QuickDirectory)() _
            .Property(Function(e) e.ckPublic) _
            .IsFixedLength()

        modelBuilder.Entity(Of QuickDirectory)() _
            .Property(Function(e) e.ckDisableDir) _
            .IsFixedLength()

        modelBuilder.Entity(Of Recipient)() _
            .Property(Function(e) e.TypeRecp) _
            .IsFixedLength()

        modelBuilder.Entity(Of RepeatData)() _
            .HasMany(Function(e) e.FunctionProdJargons) _
            .WithRequired(Function(e) e.RepeatData) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of Retention)() _
            .Property(Function(e) e.ResponseRequired) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of Retention)() _
            .HasMany(Function(e) e.InformationProducts) _
            .WithRequired(Function(e) e.Retention) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of SkipWord)() _
            .HasMany(Function(e) e.FUncSkipWords) _
            .WithRequired(Function(e) e.SkipWord) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of SourceContainer)() _
            .HasMany(Function(e) e.ContainerStorages) _
            .WithRequired(Function(e) e.SourceContainer) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of SourceContainer)() _
            .HasMany(Function(e) e.CorpContainers) _
            .WithRequired(Function(e) e.SourceContainer) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of SourceInjector)() _
            .Property(Function(e) e.ClassName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of SourceInjector)() _
            .Property(Function(e) e.FuncName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of StatSearch)() _
            .Property(Function(e) e.TypeSearch) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of Storage)() _
            .HasMany(Function(e) e.ContainerStorages) _
            .WithRequired(Function(e) e.Storage) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of SubDir)() _
            .Property(Function(e) e.FQN) _
            .IsUnicode(False)

        modelBuilder.Entity(Of SubDir)() _
            .Property(Function(e) e.ckPublic) _
            .IsFixedLength()

        modelBuilder.Entity(Of SubDir)() _
            .Property(Function(e) e.ckDisableDir) _
            .IsFixedLength()

        modelBuilder.Entity(Of SubDir)() _
            .Property(Function(e) e.OcrDirectory) _
            .IsFixedLength()

        modelBuilder.Entity(Of SubDir)() _
            .Property(Function(e) e.VersionFiles) _
            .IsFixedLength()

        modelBuilder.Entity(Of UD_Qty)() _
            .Property(Function(e) e.Code) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of UD_Qty)() _
            .Property(Function(e) e.Description) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of UD_Qty)() _
            .HasMany(Function(e) e.InformationProducts) _
            .WithRequired(Function(e) e.UD_Qty) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of UserGroup)() _
            .HasMany(Function(e) e.GroupLibraryAccesses) _
            .WithRequired(Function(e) e.UserGroup) _
            .HasForeignKey(Function(e) New With {e.GroupOwnerUserID, e.GroupName}) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of User)() _
            .Property(Function(e) e.Admin) _
            .IsFixedLength()

        modelBuilder.Entity(Of User)() _
            .Property(Function(e) e.isActive) _
            .IsFixedLength()

        modelBuilder.Entity(Of User)() _
            .HasMany(Function(e) e.ContentUsers) _
            .WithOptional(Function(e) e.User) _
            .WillCascadeOnDelete()

        modelBuilder.Entity(Of User)() _
            .HasMany(Function(e) e.CoOwners) _
            .WithRequired(Function(e) e.User) _
            .HasForeignKey(Function(e) e.PreviousOwnerUserID) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of User)() _
            .HasMany(Function(e) e.CoOwners1) _
            .WithRequired(Function(e) e.User1) _
            .HasForeignKey(Function(e) e.CurrentOwnerUserID) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of User)() _
            .HasMany(Function(e) e.DataSourceCheckOuts) _
            .WithRequired(Function(e) e.User) _
            .HasForeignKey(Function(e) e.CheckedOutByUserID)

        modelBuilder.Entity(Of User)() _
            .HasMany(Function(e) e.Directories) _
            .WithRequired(Function(e) e.User) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of User)() _
            .HasMany(Function(e) e.GroupUsers) _
            .WithRequired(Function(e) e.User) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of User)() _
            .HasMany(Function(e) e.Libraries) _
            .WithRequired(Function(e) e.User) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of User)() _
            .HasMany(Function(e) e.LibraryUsers) _
            .WithRequired(Function(e) e.User) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of User)() _
            .HasMany(Function(e) e.QuickRefs) _
            .WithRequired(Function(e) e.User) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of User)() _
            .HasMany(Function(e) e.UserGroups) _
            .WithRequired(Function(e) e.User) _
            .HasForeignKey(Function(e) e.GroupOwnerUserID) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of User)() _
            .HasMany(Function(e) e.EmailArchParms) _
            .WithRequired(Function(e) e.User) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of Volitility)() _
            .HasMany(Function(e) e.InformationProducts) _
            .WithRequired(Function(e) e.Volitility) _
            .WillCascadeOnDelete(False)

        modelBuilder.Entity(Of ArchiveStat)() _
            .Property(Function(e) e.Successful) _
            .IsFixedLength()

        modelBuilder.Entity(Of AssignableUserParameter)() _
            .Property(Function(e) e.ParmName) _
            .IsFixedLength()

        modelBuilder.Entity(Of CLC_Download)() _
            .Property(Function(e) e.ContentGuid) _
            .IsUnicode(False)

        modelBuilder.Entity(Of CLC_Preview)() _
            .Property(Function(e) e.ContentGuid) _
            .IsUnicode(False)

        modelBuilder.Entity(Of C)() _
            .Property(Function(e) e.ConnectionString) _
            .IsUnicode(False)

        modelBuilder.Entity(Of C)() _
            .Property(Function(e) e.ConnectionType) _
            .IsFixedLength()

        modelBuilder.Entity(Of C)() _
            .Property(Function(e) e.ID_NBR) _
            .IsUnicode(False)

        modelBuilder.Entity(Of CS_SharePoint)() _
            .Property(Function(e) e.SP_ConnectionString) _
            .IsUnicode(False)

        modelBuilder.Entity(Of CS_SharePoint)() _
            .Property(Function(e) e.ECM_ConnectionString) _
            .IsUnicode(False)

        modelBuilder.Entity(Of CS_SharePoint)() _
            .Property(Function(e) e.ID_NBR) _
            .IsUnicode(False)

        modelBuilder.Entity(Of CS_SharePoint)() _
            .Property(Function(e) e.ID_NBR_ECM) _
            .IsUnicode(False)

        modelBuilder.Entity(Of DatabaseFile)() _
            .Property(Function(e) e.create_lsn) _
            .HasPrecision(25, 0)

        modelBuilder.Entity(Of DatabaseFile)() _
            .Property(Function(e) e.drop_lsn) _
            .HasPrecision(25, 0)

        modelBuilder.Entity(Of DatabaseFile)() _
            .Property(Function(e) e.read_only_lsn) _
            .HasPrecision(25, 0)

        modelBuilder.Entity(Of DatabaseFile)() _
            .Property(Function(e) e.read_write_lsn) _
            .HasPrecision(25, 0)

        modelBuilder.Entity(Of DatabaseFile)() _
            .Property(Function(e) e.differential_base_lsn) _
            .HasPrecision(25, 0)

        modelBuilder.Entity(Of DatabaseFile)() _
            .Property(Function(e) e.redo_start_lsn) _
            .HasPrecision(25, 0)

        modelBuilder.Entity(Of DatabaseFile)() _
            .Property(Function(e) e.redo_target_lsn) _
            .HasPrecision(25, 0)

        modelBuilder.Entity(Of DatabaseFile)() _
            .Property(Function(e) e.backup_lsn) _
            .HasPrecision(25, 0)

        modelBuilder.Entity(Of DataSource)() _
            .Property(Function(e) e.FQN) _
            .IsUnicode(False)

        modelBuilder.Entity(Of DataSource)() _
            .Property(Function(e) e.isPublic) _
            .IsFixedLength()

        modelBuilder.Entity(Of DataSource)() _
            .Property(Function(e) e.IsPublicPreviousState) _
            .IsFixedLength()

        modelBuilder.Entity(Of DataSource)() _
            .Property(Function(e) e.isAvailable) _
            .IsFixedLength()

        modelBuilder.Entity(Of DataSource)() _
            .Property(Function(e) e.isContainedWithinZipFile) _
            .IsFixedLength()

        modelBuilder.Entity(Of DataSource)() _
            .Property(Function(e) e.IsZipFile) _
            .IsFixedLength()

        modelBuilder.Entity(Of DataSource)() _
            .Property(Function(e) e.ZipFileFQN) _
            .IsUnicode(False)

        modelBuilder.Entity(Of DataSource)() _
            .Property(Function(e) e.isPerm) _
            .IsFixedLength()

        modelBuilder.Entity(Of DataSource)() _
            .Property(Function(e) e.isMaster) _
            .IsFixedLength()

        modelBuilder.Entity(Of DataSource)() _
            .Property(Function(e) e.OcrPerformed) _
            .IsFixedLength()

        modelBuilder.Entity(Of DataSource)() _
            .Property(Function(e) e.isGraphic) _
            .IsFixedLength()

        modelBuilder.Entity(Of DataSource)() _
            .Property(Function(e) e.GraphicContainsText) _
            .IsFixedLength()

        modelBuilder.Entity(Of DataSource)() _
            .Property(Function(e) e.isWebPage) _
            .IsFixedLength()

        modelBuilder.Entity(Of DataSource)() _
            .Property(Function(e) e.RecHash) _
            .IsUnicode(False)

        modelBuilder.Entity(Of DataSource)() _
            .Property(Function(e) e.OcrSuccessful) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of DataSource)() _
            .Property(Function(e) e.OcrPending) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of DataSource)() _
            .Property(Function(e) e.PdfIsSearchable) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of DataSource)() _
            .Property(Function(e) e.PdfOcrRequired) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of DataSource)() _
            .Property(Function(e) e.PdfOcrSuccess) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of DataSource)() _
            .Property(Function(e) e.PdfOcrTextExtracted) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of DataSourceChildren)() _
            .Property(Function(e) e.ParentSourceGuid) _
            .IsFixedLength()

        modelBuilder.Entity(Of DataSourceChildren)() _
            .Property(Function(e) e.ChildSourceGuid) _
            .IsFixedLength()

        modelBuilder.Entity(Of DirectoryGuid)() _
            .Property(Function(e) e.DirFQN) _
            .IsUnicode(False)

        modelBuilder.Entity(Of DirectoryGuid)() _
            .Property(Function(e) e.DirGuid) _
            .IsFixedLength()

        modelBuilder.Entity(Of DirectoryListenerFile)() _
            .Property(Function(e) e.SourceFile) _
            .IsUnicode(False)

        modelBuilder.Entity(Of DirectoryListenerFile)() _
            .Property(Function(e) e.MachineName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of DirectoryListenerFile)() _
            .Property(Function(e) e.NameHash) _
            .HasPrecision(15, 8)

        modelBuilder.Entity(Of DirectoryLongName)() _
            .Property(Function(e) e.DIRHASH) _
            .IsUnicode(False)

        modelBuilder.Entity(Of DirectoryLongName)() _
            .Property(Function(e) e.DirLongNameID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of DirectoryTemp)() _
            .Property(Function(e) e.SkipDir) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailArchParm)() _
            .Property(Function(e) e.ArchiveEmails) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailArchParm)() _
            .Property(Function(e) e.RemoveAfterArchive) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailArchParm)() _
            .Property(Function(e) e.SetAsDefaultFolder) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailArchParm)() _
            .Property(Function(e) e.ArchiveAfterXDays) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailArchParm)() _
            .Property(Function(e) e.RemoveAfterXDays) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailArchParm)() _
            .Property(Function(e) e.ArchiveOnlyIfRead) _
            .IsFixedLength()

        modelBuilder.Entity(Of EmailFolder)() _
            .Property(Function(e) e.FolderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailFolder)() _
            .Property(Function(e) e.ParentFolderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailFolder)() _
            .Property(Function(e) e.FolderID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailFolder)() _
            .Property(Function(e) e.ParentFolderID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailFolder)() _
            .Property(Function(e) e.SelectedForArchive) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailFolder)() _
            .Property(Function(e) e.StoreID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailFolder)() _
            .Property(Function(e) e.ContainerName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailFolder_BAK)() _
            .Property(Function(e) e.FolderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailFolder_BAK)() _
            .Property(Function(e) e.ParentFolderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailFolder_BAK)() _
            .Property(Function(e) e.FolderID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailFolder_BAK)() _
            .Property(Function(e) e.ParentFolderID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailFolder_BAK)() _
            .Property(Function(e) e.SelectedForArchive) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailFolder_BAK)() _
            .Property(Function(e) e.StoreID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailFolder_BAK)() _
            .Property(Function(e) e.ContainerName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailFolder_BAK2)() _
            .Property(Function(e) e.FolderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailFolder_BAK2)() _
            .Property(Function(e) e.ParentFolderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailFolder_BAK2)() _
            .Property(Function(e) e.FolderID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailFolder_BAK2)() _
            .Property(Function(e) e.ParentFolderID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailFolder_BAK2)() _
            .Property(Function(e) e.SelectedForArchive) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailFolder_BAK2)() _
            .Property(Function(e) e.StoreID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailFolder_BAK2)() _
            .Property(Function(e) e.ContainerName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailRunningTotal)() _
            .Property(Function(e) e.Period) _
            .IsUnicode(False)

        modelBuilder.Entity(Of EmailToDelete)() _
            .Property(Function(e) e.MessageID) _
            .IsFixedLength()

        modelBuilder.Entity(Of ExcgKey)() _
            .Property(Function(e) e.MailKey) _
            .IsUnicode(False)

        modelBuilder.Entity(Of GlobalDirectory)() _
            .Property(Function(e) e.HashCode) _
            .IsUnicode(False)

        modelBuilder.Entity(Of GlobalEmail)() _
            .Property(Function(e) e.HashCode) _
            .IsUnicode(False)

        modelBuilder.Entity(Of GlobalFile)() _
            .Property(Function(e) e.HashCode) _
            .IsUnicode(False)

        modelBuilder.Entity(Of GlobalLocation)() _
            .Property(Function(e) e.HashCode) _
            .IsUnicode(False)

        modelBuilder.Entity(Of GlobalMachine)() _
            .Property(Function(e) e.HashCode) _
            .IsUnicode(False)

        modelBuilder.Entity(Of HashDir)() _
            .Property(Function(e) e.Hash) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of HashDir)() _
            .Property(Function(e) e.HashedString) _
            .IsUnicode(False)

        modelBuilder.Entity(Of HashDir)() _
            .Property(Function(e) e.HashID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of HashFile)() _
            .Property(Function(e) e.Hash) _
            .HasPrecision(18, 0)

        modelBuilder.Entity(Of HashFile)() _
            .Property(Function(e) e.HashedString) _
            .IsUnicode(False)

        modelBuilder.Entity(Of HashFile)() _
            .Property(Function(e) e.HashID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of License)() _
            .Property(Function(e) e.ServerIdentifier) _
            .IsUnicode(False)

        modelBuilder.Entity(Of License)() _
            .Property(Function(e) e.SqlInstanceIdentifier) _
            .IsUnicode(False)

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.Body) _
            .IsUnicode(False)

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.CreationTime) _
            .HasPrecision(3)

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.ReceivedTime) _
            .HasPrecision(3)

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.SentOn) _
            .HasPrecision(3)

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.DeferredDeliveryTime) _
            .HasPrecision(3)

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.EntryID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.ExpiryTime) _
            .HasPrecision(3)

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.LastModificationTime) _
            .HasPrecision(3)

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.StoreID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.isPublic) _
            .IsFixedLength()

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.RetentionExpirationDate) _
            .HasPrecision(3)

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.IsPublicPreviousState) _
            .IsFixedLength()

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.isAvailable) _
            .IsFixedLength()

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.isPerm) _
            .IsFixedLength()

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.isMaster) _
            .IsFixedLength()

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.CreationDate) _
            .HasPrecision(3)

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.RowCreationDate) _
            .HasPrecision(3)

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.RowLastModDate) _
            .HasPrecision(3)

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.txStartTime) _
            .HasPrecision(3)

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.txEndTime) _
            .HasPrecision(3)

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.ContainsAttachment) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.PdfIsSearchable) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.PdfOcrRequired) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.PdfOcrSuccess) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of Query)() _
            .Property(Function(e) e.PdfOcrTextExtracted) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of RestorationHistory)() _
            .Property(Function(e) e.RestorationDate) _
            .IsFixedLength()

        modelBuilder.Entity(Of RestoreQueue)() _
            .Property(Function(e) e.ContentType) _
            .IsUnicode(False)

        modelBuilder.Entity(Of RestoreQueueHistory)() _
            .Property(Function(e) e.ContentType) _
            .IsUnicode(False)

        modelBuilder.Entity(Of RSSChildren)() _
            .Property(Function(e) e.RssRowGuid) _
            .IsFixedLength()

        modelBuilder.Entity(Of RSSChildren)() _
            .Property(Function(e) e.SourceGuid) _
            .IsFixedLength()

        modelBuilder.Entity(Of SearchSchedule)() _
            .Property(Function(e) e.ScheduleUnit) _
            .IsFixedLength()

        modelBuilder.Entity(Of SearchSchedule)() _
            .Property(Function(e) e.ScheduleHour) _
            .IsFixedLength()

        modelBuilder.Entity(Of SearchSchedule)() _
            .Property(Function(e) e.ScheduleDaysOfWeek) _
            .IsFixedLength()

        modelBuilder.Entity(Of SearchSchedule)() _
            .Property(Function(e) e.ScheduleDaysOfMonth) _
            .IsFixedLength()

        modelBuilder.Entity(Of SearchSchedule)() _
            .Property(Function(e) e.ScheduleMonthOfQtr) _
            .IsFixedLength()

        modelBuilder.Entity(Of ServiceActivity)() _
            .Property(Function(e) e.Msg) _
            .IsUnicode(False)

        modelBuilder.Entity(Of SessionVar)() _
            .Property(Function(e) e.SessionGuid) _
            .IsUnicode(False)

        modelBuilder.Entity(Of SessionVar)() _
            .Property(Function(e) e.SessionVar1) _
            .IsUnicode(False)

        modelBuilder.Entity(Of StagedSQL)() _
            .Property(Function(e) e.ExecutionID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of TestTbl)() _
            .Property(Function(e) e.TestCol) _
            .IsUnicode(False)

        modelBuilder.Entity(Of txTime)() _
            .Property(Function(e) e.txTime1) _
            .HasPrecision(12, 4)

        modelBuilder.Entity(Of upgrade_status)() _
            .Property(Function(e) e.name) _
            .IsUnicode(False)

        modelBuilder.Entity(Of upgrade_status)() _
            .Property(Function(e) e.status) _
            .IsUnicode(False)

        modelBuilder.Entity(Of UserReassignHist)() _
            .Property(Function(e) e.PrevAdmin) _
            .IsFixedLength()

        modelBuilder.Entity(Of UserReassignHist)() _
            .Property(Function(e) e.PrevisActive) _
            .IsFixedLength()

        modelBuilder.Entity(Of UserReassignHist)() _
            .Property(Function(e) e.ReassignedAdmin) _
            .IsFixedLength()

        modelBuilder.Entity(Of UserReassignHist)() _
            .Property(Function(e) e.ReassignedisActive) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_Archive_07202017134452007)() _
            .Property(Function(e) e.SenderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_ArchiveFrom)() _
            .Property(Function(e) e.SenderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_ArchiveStats)() _
            .Property(Function(e) e.Successful) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_AssignableUserParameters)() _
            .Property(Function(e) e.ParmName) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_Contact_07202017134458008)() _
            .Property(Function(e) e.SenderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_ContactFrom)() _
            .Property(Function(e) e.SenderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_DataSourceRestoreHistory)() _
            .Property(Function(e) e.VerifiedData) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_DeleteF_07202017134505007)() _
            .Property(Function(e) e.SenderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_DeleteFrom)() _
            .Property(Function(e) e.SenderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_Directory)() _
            .Property(Function(e) e.IncludeSubDirs) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_Directory)() _
            .Property(Function(e) e.FQN) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_Directory)() _
            .Property(Function(e) e.VersionFiles) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_Directory)() _
            .Property(Function(e) e.ckMetaData) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_Directory)() _
            .Property(Function(e) e.ckPublic) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_Directory)() _
            .Property(Function(e) e.ckDisableDir) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_Directory)() _
            .Property(Function(e) e.QuickRefEntry) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_Directory)() _
            .Property(Function(e) e.OcrDirectory) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_Directory)() _
            .Property(Function(e) e.OcrPdf) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_Directory)() _
            .Property(Function(e) e.DeleteOnArchive) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_EcmUser)() _
            .Property(Function(e) e.Authority) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_EmailArchParms)() _
            .Property(Function(e) e.ArchiveEmails) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_EmailArchParms)() _
            .Property(Function(e) e.RemoveAfterArchive) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_EmailArchParms)() _
            .Property(Function(e) e.SetAsDefaultFolder) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_EmailArchParms)() _
            .Property(Function(e) e.ArchiveAfterXDays) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_EmailArchParms)() _
            .Property(Function(e) e.RemoveAfterXDays) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_EmailArchParms)() _
            .Property(Function(e) e.ArchiveOnlyIfRead) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_EmailFolder)() _
            .Property(Function(e) e.FolderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_EmailFolder)() _
            .Property(Function(e) e.ParentFolderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_EmailFolder)() _
            .Property(Function(e) e.FolderID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_EmailFolder)() _
            .Property(Function(e) e.ParentFolderID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_EmailFolder)() _
            .Property(Function(e) e.SelectedForArchive) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_EmailFolder)() _
            .Property(Function(e) e.StoreID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_EmailFolder)() _
            .Property(Function(e) e.ContainerName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_EmailToDelete)() _
            .Property(Function(e) e.MessageID) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_ExcludedFiles)() _
            .Property(Function(e) e.FQN) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_ExcludeFrom)() _
            .Property(Function(e) e.SenderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_ExcludeFrom)() _
            .Property(Function(e) e.UserID) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_FunctionProdJargon)() _
            .Property(Function(e) e.KeyFlag) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_Include_07202017134438007)() _
            .Property(Function(e) e.SenderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_IncludeImmediate)() _
            .Property(Function(e) e.SenderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_InformationProduct)() _
            .Property(Function(e) e.Code) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_Library)() _
            .Property(Function(e) e.isPublic) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_License)() _
            .Property(Function(e) e.ServerIdentifier) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_License)() _
            .Property(Function(e) e.SqlInstanceIdentifier) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_Outlook_07202017134444008)() _
            .Property(Function(e) e.SenderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_OutlookFrom)() _
            .Property(Function(e) e.SenderName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_QuickDirectory)() _
            .Property(Function(e) e.IncludeSubDirs) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_QuickDirectory)() _
            .Property(Function(e) e.FQN) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_QuickDirectory)() _
            .Property(Function(e) e.VersionFiles) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_QuickDirectory)() _
            .Property(Function(e) e.ckMetaData) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_QuickDirectory)() _
            .Property(Function(e) e.ckPublic) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_QuickDirectory)() _
            .Property(Function(e) e.ckDisableDir) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_Recipients)() _
            .Property(Function(e) e.TypeRecp) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_RestorationHistory)() _
            .Property(Function(e) e.RestorationDate) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_Retention)() _
            .Property(Function(e) e.ResponseRequired) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_SubDir)() _
            .Property(Function(e) e.FQN) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_SubDir)() _
            .Property(Function(e) e.ckPublic) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_SubDir)() _
            .Property(Function(e) e.ckDisableDir) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_SubDir)() _
            .Property(Function(e) e.OcrDirectory) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_SubDir)() _
            .Property(Function(e) e.VersionFiles) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_UD_Qty)() _
            .Property(Function(e) e.Code) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_UD_Qty)() _
            .Property(Function(e) e.Description) _
            .IsFixedLength() _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_upgrade_status)() _
            .Property(Function(e) e.name) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_upgrade_status)() _
            .Property(Function(e) e.status) _
            .IsUnicode(False)

        modelBuilder.Entity(Of gv_UserReassignHist)() _
            .Property(Function(e) e.PrevAdmin) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_UserReassignHist)() _
            .Property(Function(e) e.PrevisActive) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_UserReassignHist)() _
            .Property(Function(e) e.ReassignedAdmin) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_UserReassignHist)() _
            .Property(Function(e) e.ReassignedisActive) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_Users)() _
            .Property(Function(e) e.Admin) _
            .IsFixedLength()

        modelBuilder.Entity(Of gv_Users)() _
            .Property(Function(e) e.isActive) _
            .IsFixedLength()

        modelBuilder.Entity(Of vFileDirectory)() _
            .Property(Function(e) e.ContentTypeCode) _
            .IsFixedLength()

        modelBuilder.Entity(Of vLibraryStat)() _
            .Property(Function(e) e.isPublic) _
            .IsFixedLength()

        modelBuilder.Entity(Of vMigrateUser)() _
            .Property(Function(e) e.ECM_GroupName) _
            .IsUnicode(False)

        modelBuilder.Entity(Of vMigrateUser)() _
            .Property(Function(e) e.ECM_Library) _
            .IsUnicode(False)

        modelBuilder.Entity(Of vMigrateUser)() _
            .Property(Function(e) e.ECM_Authority) _
            .IsUnicode(False)

        modelBuilder.Entity(Of vReassignedTable)() _
            .Property(Function(e) e.PrevAdmin) _
            .IsFixedLength()

        modelBuilder.Entity(Of vReassignedTable)() _
            .Property(Function(e) e.PrevisActive) _
            .IsFixedLength()

        modelBuilder.Entity(Of vReassignedTable)() _
            .Property(Function(e) e.ReassignedAdmin) _
            .IsFixedLength()

        modelBuilder.Entity(Of vReassignedTable)() _
            .Property(Function(e) e.ReassignedisActive) _
            .IsFixedLength()

        modelBuilder.Entity(Of vUserGrid)() _
            .Property(Function(e) e.Admin) _
            .IsFixedLength()

        modelBuilder.Entity(Of vUserGrid)() _
            .Property(Function(e) e.isActive) _
            .IsFixedLength()
    End Sub
End Class

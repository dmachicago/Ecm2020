' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 07-16-2020
' ***********************************************************************
' <copyright file="MainPage.xaml.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports System.Collections.ObjectModel
Imports System.ComponentModel
Imports System.Data
Imports System.Data.SqlClient
Imports System.IO
Imports System.Linq
Imports System.Web.Script.Serialization
Imports System.Windows.Controls.Primitives
Imports ECMEncryption
Imports Microsoft.Win32

''' <summary>
''' Class MainPage.
''' Implements the <see cref="System.Windows.Controls.Page" />
''' Implements the <see cref="System.Windows.Markup.IComponentConnector" />
''' </summary>
''' <seealso cref="System.Windows.Controls.Page" />
''' <seealso cref="System.Windows.Markup.IComponentConnector" />
Class MainPage

    'Private WithEvents btnPlus As Button
    'Private WithEvents btnMinus As Button

    ''' <summary>
    ''' The dscontent
    ''' </summary>
    Dim DSCONTENT As New DataSet
    ''' <summary>
    ''' The dsemail
    ''' </summary>
    Dim DSEMAIL As New DataSet

    ''' <summary>
    ''' The content cols
    ''' </summary>
    Dim CONTENT_COLS As New Dictionary(Of String, Integer)
    ''' <summary>
    ''' The email cols
    ''' </summary>
    Dim EMAIL_COLS As New Dictionary(Of String, Integer)

    ''' <summary>
    ''' The do not show SQL
    ''' </summary>
    Dim DoNotShowSQL As Boolean = False
    ''' <summary>
    ''' The enc
    ''' </summary>
    Dim ENC As New ECMEncrypt
    ''' <summary>
    ''' The do not do this
    ''' </summary>
    Dim DoNotDoThis As Boolean = False
    ''' <summary>
    ''' The CLC URL
    ''' </summary>
    Dim ClcURL As String = ""
    ''' <summary>
    ''' The archiver URL
    ''' </summary>
    Dim ArchiverURL As String = ""

    ''' <summary>
    ''' The log
    ''' </summary>
    Dim LOG As New clsLogMain
    ''' <summary>
    ''' The dload
    ''' </summary>
    Dim DLOAD As New clsDLMaster
    ''' <summary>
    ''' The DSMGT
    ''' </summary>
    Dim DSMGT As clsDatasetMgt = New clsDatasetMgt()

    ''' <summary>
    ''' The b quick search recall
    ''' </summary>
    Dim bQuickSearchRecall As Boolean = True
    ''' <summary>
    ''' The b quick search recall2
    ''' </summary>
    Dim bQuickSearchRecall2 As Boolean = False
    ''' <summary>
    ''' The NBR executed searches
    ''' </summary>
    Dim nbrExecutedSearches As Integer = 0

    ''' <summary>
    ''' The PRM
    ''' </summary>
    Dim PRM As New clsParms
    ''' <summary>
    ''' The curr search count
    ''' </summary>
    Dim currSearchCnt As Integer = 0
    ''' <summary>
    ''' The use iso
    ''' </summary>
    Dim UseISO As Boolean = False

    ''' <summary>
    ''' The do not apply quick search
    ''' </summary>
    Dim DoNotApplyQuickSearch As Boolean = False
    ''' <summary>
    ''' The selected grid
    ''' </summary>
    Dim SelectedGrid As String = ""

    ''' <summary>
    ''' The do not show MSG box
    ''' </summary>
    Dim DoNotShowMsgBox As Boolean = False
    ''' <summary>
    ''' The i total to process
    ''' </summary>
    Dim iTotalToProcess As Integer = 0
    ''' <summary>
    ''' The i total processed
    ''' </summary>
    Dim iTotalProcessed As Integer = 0

    ''' <summary>
    ''' The b spell check loaded
    ''' </summary>
    Dim bSpellCheckLoaded As Boolean = False

    'Dim proxy As New SVCSearch.Service1Client
    ''' <summary>
    ''' The proxy2
    ''' </summary>
    Dim proxy2 As New SVCSearch.Service1Client

    'Dim clsGVAR As App = App.Current

    ''' <summary>
    ''' The previous list of content count
    ''' </summary>
    Dim PrevListOfContentCnt As Integer = 0
    ''' <summary>
    ''' The previous list of email count
    ''' </summary>
    Dim PrevListOfEmailCnt As Integer = 0

    ''' <summary>
    ''' The b ghost fetch active
    ''' </summary>
    Dim bGhostFetchActive As Boolean = False
    ''' <summary>
    ''' The button bounce
    ''' </summary>
    Dim ButtonBounce As Integer = 0
    ''' <summary>
    ''' The executing search
    ''' </summary>
    Dim ExecutingSearch As Boolean = False

    'Dim EP As New clsEndPoint
    ''' <summary>
    ''' The en c2
    ''' </summary>
    Dim ENC2 As New ECMEncrypt()

    ''' <summary>
    ''' The d save
    ''' </summary>
    Dim dSave As New SaveFileDialog

    '******** DICTIONARIES: Grid Sort and Display Order ********
    ''' <summary>
    ''' The dictionary email grid col display order
    ''' </summary>
    Dim dictEmailGridColDisplayOrder As New Dictionary(Of Integer, String)

    ''' <summary>
    ''' The dictionary email grid col sort order
    ''' </summary>
    Dim dictEmailGridColSortOrder As New Dictionary(Of Integer, String)
    ''' <summary>
    ''' The dictionary content grid col display order
    ''' </summary>
    Dim dictContentGridColDisplayOrder As New Dictionary(Of Integer, String)
    ''' <summary>
    ''' The dictionary content grid col sort order
    ''' </summary>
    Dim dictContentGridColSortOrder As New Dictionary(Of Integer, String)

    ''' <summary>
    ''' The dictionary screen controls
    ''' </summary>
    Dim dictScreenControls As New Dictionary(Of String, String)
    ''' <summary>
    ''' The dictionary grid parms email
    ''' </summary>
    Dim dictGridParmsEmail As New Dictionary(Of String, String)
    ''' <summary>
    ''' The dictionary grid parms content
    ''' </summary>
    Dim dictGridParmsContent As New Dictionary(Of String, String)



    ''' <summary>
    ''' The list of quick search
    ''' </summary>
    Dim ListOfQuickSearch As New List(Of String)
    ''' <summary>
    ''' The maximum quick search entry
    ''' </summary>
    Dim MaxQuickSearchEntry As Integer = 50

    ''' <summary>
    ''' The dictionary guids
    ''' </summary>
    Dim DictGuids As New Dictionary(Of String, Integer)
    '******** END OF Grid Sort and Display Order ********

    ''' <summary>
    ''' The top row
    ''' </summary>
    Dim TopRow As Integer = 0
    ''' <summary>
    ''' The email trigger row
    ''' </summary>
    Dim EmailTriggerRow As Integer = 0
    ''' <summary>
    ''' The content trigger row
    ''' </summary>
    Dim ContentTriggerRow As Integer = 0
    ''' <summary>
    ''' The b new rows
    ''' </summary>
    Dim bNewRows As Boolean = False
    ''' <summary>
    ''' The b first content search submit
    ''' </summary>
    Dim bFirstContentSearchSubmit As Boolean = False
    ''' <summary>
    ''' The b first email search submit
    ''' </summary>
    Dim bFirstEmailSearchSubmit As Boolean = False

    ''' <summary>
    ''' The email search count
    ''' </summary>
    Dim EmailSearchCnt As Integer = 0
    ''' <summary>
    ''' The content search count
    ''' </summary>
    Dim ContentSearchCnt As Integer = 0

    ''' <summary>
    ''' The previous top row
    ''' </summary>
    Dim PrevTopRow As Integer = 0
    ''' <summary>
    ''' The b start new search
    ''' </summary>
    Dim bStartNewSearch As Boolean = True
    ''' <summary>
    ''' The g secure identifier
    ''' </summary>
    Dim gSecureID As String = gSecureID
    ''' <summary>
    ''' The parm name
    ''' </summary>
    Dim ParmName As String = ""
    ''' <summary>
    ''' The curr session unique identifier
    ''' </summary>
    Dim CurrSessionGuid As Guid = Nothing
    ''' <summary>
    ''' The login identifier
    ''' </summary>
    Dim LoginID As String = ""
    ''' <summary>
    ''' The company identifier
    ''' </summary>
    Dim CompanyID As String = ""
    ''' <summary>
    ''' The repo identifier
    ''' </summary>
    Dim RepoID As String = ""
    ''' <summary>
    ''' The encrypt pw
    ''' </summary>
    Dim EncryptPW As String = ""

    ''' <summary>
    ''' The b email row height set
    ''' </summary>
    Dim bEmailRowHeightSet As Boolean = False
    ''' <summary>
    ''' The b setting email row height
    ''' </summary>
    Dim bSettingEmailRowHeight As Boolean = False
    ''' <summary>
    ''' The b email scrolling
    ''' </summary>
    Dim bEmailScrolling As Boolean = False
    ''' <summary>
    ''' The b content scrolling
    ''' </summary>
    Dim bContentScrolling As Boolean = False

    ''' <summary>
    ''' The generated SQL
    ''' </summary>
    Dim GeneratedSql As String = ""

    ''' <summary>
    ''' The start row
    ''' </summary>
    Dim _startRow As Integer = 0
    ''' <summary>
    ''' The page size
    ''' </summary>
    Dim _pageSize As Integer = 20
    ''' <summary>
    ''' The loading
    ''' </summary>
    Dim _loading As Boolean = Nothing

    ''' <summary>
    ''' The previous text
    ''' </summary>
    Dim PrevText As String = ""
    ''' <summary>
    ''' The iso
    ''' </summary>
    Dim ISO As New clsIsolatedStorage

    ''' <summary>
    ''' The rid
    ''' </summary>
    Dim RID As Integer = 0

    ''' <summary>
    ''' The file preview name
    ''' </summary>
    Dim filePreviewName As String = ""

    ''' <summary>
    ''' The search history
    ''' </summary>
    Dim SearchHistory As List(Of SVCSearch.DS_USERSEARCHSTATE)

    ''' <summary>
    ''' The curr attachment row identifier
    ''' </summary>
    Dim CurrAttachmentRowID As String = ""
    ''' <summary>
    ''' The current document page
    ''' </summary>
    Dim CurrentDocPage As Integer = 1
    ''' <summary>
    ''' The current email page
    ''' </summary>
    Dim CurrentEmailPage As Integer = 1

    ''' <summary>
    ''' The b save searches to database
    ''' </summary>
    Dim bSaveSearchesToDB As Boolean = False
    ''' <summary>
    ''' The repo table name
    ''' </summary>
    Dim RepoTableName As String = ""
    ''' <summary>
    ''' The current unique identifier
    ''' </summary>
    Dim CurrentGuid As String = ""
    ''' <summary>
    ''' The clip board SQL
    ''' </summary>
    Dim ClipBoardSql As String = ""
    ''' <summary>
    ''' The current search identifier high
    ''' </summary>
    Dim CurrentSearchIdHigh As Integer
    ''' <summary>
    ''' The list of libraries
    ''' </summary>
    Dim ListOfLibraries As New List(Of String)
    ''' <summary>
    ''' The list of grid cols
    ''' </summary>
    Dim ListOfGridCols As New List(Of String)
    'Dim ObjListOfGridCols As Object = Nothing

    ''' <summary>
    ''' The library owner unique identifier
    ''' </summary>
    Dim LibraryOwnerGuid As String = ""

    ''' <summary>
    ''' The return MSG
    ''' </summary>
    Dim returnMsg As String = ""
    ''' <summary>
    ''' The rc
    ''' </summary>
    Dim RC As Boolean = False

    ''' <summary>
    ''' The i search count
    ''' </summary>
    Dim iSearchCnt As Integer = 0
    ''' <summary>
    ''' The i maximum search count
    ''' </summary>
    Dim iMaxSearchCnt As Integer = 0
    ''' <summary>
    ''' The gm
    ''' </summary>
    Dim GM As New clsGridMgt
    ''' <summary>
    ''' The common
    ''' </summary>
    Dim COMMON As New clsCommonFunctions

    ''' <summary>
    ''' The b wait to apply attachment weight
    ''' </summary>
    Dim bWaitToApplyAttachmentWeight As Boolean = False
    ''' <summary>
    ''' The author
    ''' </summary>
    Dim Author As String = ""
    ''' <summary>
    ''' The ts
    ''' </summary>
    Dim TS As TimeSpan = Nothing
    ''' <summary>
    ''' The q start time
    ''' </summary>
    Dim qStartTime As DateTime = Now
    ''' <summary>
    ''' The q end time
    ''' </summary>
    Dim qEndTime As DateTime = Now

    ''' <summary>
    ''' The get datasource parm source unique identifier
    ''' </summary>
    Dim getDatasourceParmSourceGuid As String = ""
    ''' <summary>
    ''' The get datasource parm source type code
    ''' </summary>
    Dim getDatasourceParmSourceTypeCode As String = ""
    ''' <summary>
    ''' The get datasource parm source create date
    ''' </summary>
    Dim getDatasourceParmSourceCreateDate As String
    ''' <summary>
    ''' The get datasource parm source allrecipiants
    ''' </summary>
    Dim getDatasourceParmSourceAllrecipiants As String
    ''' <summary>
    ''' The get datasource parm source FQN
    ''' </summary>
    Dim getDatasourceParmSourceFQN As String
    ''' <summary>
    ''' The get datasource parm source file length
    ''' </summary>
    Dim getDatasourceParmSourceFileLength As String
    ''' <summary>
    ''' The get datasource parm source weight
    ''' </summary>
    Dim getDatasourceParmSourceWeight As String

    ''' <summary>
    ''' The LST search history
    ''' </summary>
    Dim lstSearchHistory As New List(Of String)

    ''' <summary>
    ''' The string author
    ''' </summary>
    Dim strAuthor As String = ""
    ''' <summary>
    ''' The string title
    ''' </summary>
    Dim strTitle As String = ""

    ''' <summary>
    ''' The do not get search history
    ''' </summary>
    Dim DoNotGetSearchHistory As Boolean = False

    ''' <summary>
    ''' The getting author
    ''' </summary>
    Dim gettingAuthor As Boolean = False
    ''' <summary>
    ''' The getting title
    ''' </summary>
    Dim gettingTitle As Boolean = False

    ''' <summary>
    ''' The dma
    ''' </summary>
    Dim DMA As New clsDma
    ''' <summary>
    ''' The utility
    ''' </summary>
    Dim UTIL As New clsUtility
    ''' <summary>
    ''' The uparm
    ''' </summary>
    Dim UPARM As New clsgetUserParm

    'Dim USERPARMS As New clsUserParms
    ''' <summary>
    ''' The gs
    ''' </summary>
    Dim GS As New clsGLOBALSEACHRESULTS

    ''' <summary>
    ''' The sqlgen
    ''' </summary>
    Dim SQLGEN As New clsSql

    'Dim PROC As New clsProcess
    'Dim SPELL As New clsSpelling
    'Dim SPARMS As New clsSEARHPARMSHISTORY
    'Dim DB As New clsDatabase
    'Dim DG As New clsDataGrid
    'Dim LM As New clsLicenseMgt
    'Dim APPS As New clsAppParms
    'Dim GRP As New clsUSERGROUP
    'Dim LI As New clsLIBRARYITEMS
    'Dim GS As New clsGLOBALSEACHRESULTS
    'Dim RESTORE As New clsRestore
    'Dim CP As New clsProcess
    'Dim DRHIST As New clsDATASOURCERESTOREHISTORY
    'Dim ARCH As New clsArchiver
    'Dim ASG As New clsACTIVESEARCHGUIDS
    ''' <summary>
    ''' The shist
    ''' </summary>
    Dim SHIST As New clsSEARCHHISTORY

    ''' <summary>
    ''' The automatic gen SQL
    ''' </summary>
    Dim AutoGenSql As String = ""
    ''' <summary>
    ''' The NBR docs loaded
    ''' </summary>
    Dim NbrDocsLoaded As Integer = 0
    ''' <summary>
    ''' The gen email SQL
    ''' </summary>
    Dim GenEmailSql As String = ""
    ''' <summary>
    ''' The gen document SQL
    ''' </summary>
    Dim GenDocSql As String = ""
    ''' <summary>
    ''' The currently selected email column
    ''' </summary>
    Dim CurrentlySelectedEmailColumn As Integer = -1
    ''' <summary>
    ''' The currently selected content column
    ''' </summary>
    Dim CurrentlySelectedContentColumn As Integer = -1

    ''' <summary>
    ''' The attachment weights
    ''' </summary>
    Dim AttachmentWeights As New Dictionary(Of String, Integer)
    ''' <summary>
    ''' The getting get attachment weights
    ''' </summary>
    Dim gettingGetAttachmentWeights As Boolean = False

    ''' <summary>
    ''' The minimum weight
    ''' </summary>
    Dim MinWeight As Integer = 0
    ''' <summary>
    ''' The gen SQL only
    ''' </summary>
    Dim GenSqlOnly As Boolean = False
    ''' <summary>
    ''' The cb SQL
    ''' </summary>
    Dim CB_SQL As String = ""
    ''' <summary>
    ''' The q start
    ''' </summary>
    Dim qStart As Date = Now
    ''' <summary>
    ''' The q end
    ''' </summary>
    Dim qEnd As Date = Now

    ''' <summary>
    ''' The row changed
    ''' </summary>
    Dim RowChanged As Boolean = False
    ''' <summary>
    ''' The x email qry
    ''' </summary>
    Dim xEmailQry As String = ""
    ''' <summary>
    ''' The x document qry
    ''' </summary>
    Dim xDocQry As String = ""
    ''' <summary>
    ''' The total emails
    ''' </summary>
    Dim TotalEmails As Integer = 0
    ''' <summary>
    ''' The total docs
    ''' </summary>
    Dim TotalDocs As Integer = 0

    ''' <summary>
    ''' The b initialize page data needed
    ''' </summary>
    Dim bInitPageDataNeeded As Boolean = True
    ''' <summary>
    ''' The b use page data
    ''' </summary>
    Dim bUsePageData As String = "0"

    ''' <summary>
    ''' The b need row count
    ''' </summary>
    Dim bNeedRowCount As Boolean = False
    ''' <summary>
    ''' The b email search requested
    ''' </summary>
    Dim bEmailSearchRequested As Boolean = False
    ''' <summary>
    ''' The b document search requested
    ''' </summary>
    Dim bDocSearchRequested As Boolean = False
    ''' <summary>
    ''' The b nav button pushed
    ''' </summary>
    Dim bNavButtonPushed As Boolean = False

    ''' <summary>
    ''' The total email pages
    ''' </summary>
    Dim TotalEmailPages As Integer = 0
    ''' <summary>
    ''' The total email rows
    ''' </summary>
    Dim TotalEmailRows As Integer = 0
    ''' <summary>
    ''' The total document pages
    ''' </summary>
    Dim TotalDocPages As Integer = 0
    ''' <summary>
    ''' The total document rows
    ''' </summary>
    Dim TotalDocRows As Integer = 0

    ''' <summary>
    ''' The email grid has focus
    ''' </summary>
    Dim EmailGridHasFocus As Boolean = False
    ''' <summary>
    ''' The document grid has focus
    ''' </summary>
    Dim DocGridHasFocus As Boolean = False

    ''' <summary>
    ''' The previous email row
    ''' </summary>
    Dim PrevEmailRow As Integer = -1
    ''' <summary>
    ''' The previous content row
    ''' </summary>
    Dim PrevContentRow As Integer = -1
    ''' <summary>
    ''' The currently selected grid
    ''' </summary>
    Dim CurrentlySelectedGrid As String = ""
    ''' <summary>
    ''' The use fast method
    ''' </summary>
    Dim UseFastMethod As Boolean = False

    ''' <summary>
    ''' The b grid cols retrieved
    ''' </summary>
    Dim bGridColsRetrieved As Boolean = False
    ''' <summary>
    ''' The skip existing files
    ''' </summary>
    Private SkipExistingFiles As Boolean = False
    ''' <summary>
    ''' The overwrite existing files
    ''' </summary>
    Private OverwriteExistingFiles As Boolean = False
    ''' <summary>
    ''' The do this for all files
    ''' </summary>
    Private doThisForAllFiles As Boolean = False
    ''' <summary>
    ''' The version files
    ''' </summary>
    Private VersionFiles As Boolean = False

    ''' <summary>
    ''' The search history list
    ''' </summary>
    Dim SearchHistoryList As New List(Of String)
    ''' <summary>
    ''' The search history array list
    ''' </summary>
    Dim SearchHistoryArrayList() As String
    ''' <summary>
    ''' The loading history search
    ''' </summary>
    Dim LoadingHistorySearch As Boolean = False

    ''' <summary>
    ''' The form loaded
    ''' </summary>
    Dim FormLoaded As Boolean = False
    ''' <summary>
    ''' The docs SQL
    ''' </summary>
    Dim DocsSql As String = ""
    ''' <summary>
    ''' The email SQL
    ''' </summary>
    Dim EmailSql As String = ""
    ''' <summary>
    ''' The x wc
    ''' </summary>
    Dim xWC As String = ""
    ''' <summary>
    ''' The curr user unique identifier identifier
    ''' </summary>
    Dim CurrUserGuidID As String = gCurrLogin
    ''' <summary>
    ''' The curr login identifier
    ''' </summary>
    Dim CurrLoginID As String = gCurrLogin

    ''' <summary>
    ''' The i curr row minimum
    ''' </summary>
    Dim iCurrRowMin As Integer = 0
    ''' <summary>
    ''' The i curr row maximum
    ''' </summary>
    Dim iCurrRowMax As Integer = PageRowLimit

    ''' <summary>
    ''' The e p1
    ''' </summary>
    Dim EP1 As String = ISO.SetCLC_State2(CurrLoginID, "IDENTIFIED", CompanyID, RepoID)
    ''' <summary>
    ''' The e p2
    ''' </summary>
    Dim EP2 As String = ISO.SetSAAS_State(UserGuid, "ACTIVE", CompanyID, RepoID)

    'Dim MD As SpellDictionary = _c1SpellChecker.MainDictionary
    'Dim UD As UserDictionary = _c1SpellChecker.UserDictionary
    'Dim DictUri As New Uri("./SpellCheck/C1Spell_en-US.dct", UriKind.RelativeOrAbsolute)
    'Dim tPAth As String = Application.Current.Host.Source.LocalPath

    'Dim SpellDLG As C1.Silverlight.SpellChecker.ISpellDialog
    'Dim _c1SpellChecker As New C1.Silverlight.SpellChecker.C1SpellChecker

    '** System parms MUST b loaded at startup time - we need a "Startup"
    'splash screen that can be used for rebranding and loading all the
    'intialization parameters.

    ''' <summary>
    ''' Initializes a new instance of the <see cref="MainPage"/> class.
    ''' </summary>
    Public Sub New()
        InitializeComponent()

        Dim sddebug As String = System.Configuration.ConfigurationManager.AppSettings("DebugON")
        If sddebug.Equals(1) Then
            gDebug = True
        Else
            gDebug = False
        End If

        setAuthority()

        button.Visibility = Visibility.Hidden

        '*** Reset these later
        PB.Visibility = Windows.Visibility.Collapsed
        ckMasterOnly.Visibility = Visibility.Collapsed

        PB.Visibility = Windows.Visibility.Visible
        ckMasterOnly.Visibility = Visibility.Visible

        gSecureID = gSecureID
        CurrSessionGuid = SessionGuid

        getStaticVars()

        Dim BB As Boolean = ProxySearch.SetSAASState(_SecureID, _UserGuid, "SAAS_STATE", "ACTIVE")
        client_SetSAASState(BB)

        If Me.Resources.Contains("SessionGuid") Then
            CurrSessionGuid = Me.Resources.Item("SessionGuid")
        End If

        If Me.Resources.Contains("CompanyID") Then
            CompanyID = Me.Resources.Item("CompanyID")
        End If
        If Me.Resources.Contains("RepoID") Then
            RepoID = Me.Resources.Item("RepoID")
        End If
        If Me.Resources.Contains("UserID") Then
            RepoID = Me.Resources.Item("UserID")
        End If

        nbrDocRows.Text = PageRowLimit.ToString
        nbrEmailRows.Text = PageRowLimit.ToString

        Dim HideStuff As Boolean = False
        If HideStuff Then
            SetInactiveStateOfForm()
        End If

        If HideStuff Then
            lblIsPublicShow.Visibility = Windows.Visibility.Collapsed
            LblIsWebShow.Visibility = Windows.Visibility.Collapsed
            LblCkIsMasterShow.Visibility = Windows.Visibility.Collapsed
            lblRssPull.Visibility = Windows.Visibility.Collapsed

            gridPreview.Visibility = Windows.Visibility.Collapsed
            gridTabs.Visibility = Windows.Visibility.Collapsed

            SetFilterVisibility()
        End If

        LoadSystemParameters()
        getServerInstanceName()
        getServerMachineName()
        getLoggedInUser()
        getAttachedMachineName()
        populateLibraryComboBox()

        SetDefaultScreen()

        ISO.DeleteDetailSearchParms("EMAIL")
        ISO.DeleteDetailSearchParms("CONTENT")

        ISO.PreviewFileInit(CompanyID, RepoID, "NONE SUPPLIED")
        ISO.initFileRestoreData()
        ISO.initFilePreviewData()

        dgAttachments.Visibility = Windows.Visibility.Collapsed

        Console.WriteLine("EP1: " + EP1)

        COMMON.SaveClick(10, UserGuid)

        'AddHandler Application.Current.Exit, AddressOf App_Exit

        dgContent.RowHeight = 10
        dgContent.ItemsSource = Nothing
        dgContent.ItemsSource = gListOfContent
        dgContent.Items.Refresh()

        dgEmails.RowHeight = 10
        dgEmails.ItemsSource = Nothing
        dgEmails.ItemsSource = gListOfEmails
        dgEmails.Items.Refresh()

        Console.WriteLine("EP2: " + EP2)

        getArchiverURL()
        getClcURL()

        SearchHistoryReload()
        getSavedContentGridColumnsDisplayOrder()
        getSavedEmailGridColumnsDisplayOrder()

        lblUserID.Content = UserID
        gDownloadDIR = System.Configuration.ConfigurationManager.AppSettings("DownloadDIR")

        If Not Directory.Exists(gDownloadDIR) Then
            Directory.CreateDirectory(gDownloadDIR)
        End If
        initDataTableEmail()

        setTabsOpenClosed()

        btnOpenRestoreScreen.Visibility = Visibility.Hidden
        cbSearchIdx.Visibility = Visibility.Hidden

        ckFilters.IsChecked = True
        ckFilters.IsChecked = False
        hlFindCLC.Visibility = Visibility.Collapsed

        dgContent.EnableRowVirtualization = True
        dgEmails.EnableRowVirtualization = True

    End Sub

    ''' <summary>
    ''' Gens the search SQL.
    ''' </summary>
    Public Sub genSearchSql()
        'GenSqlOnly = True
        'btnSubmit_Click(Nothing, Nothing)
        Dim S As String = ""
        Dim TypeSQL As String = ""
        'Dim SearchParmList As New System.Collections.Generic.List(Of SVCSearch.DS_SearchTerms)
        Dim SecureID As Integer = 0

        Me.Cursor = Cursors.Wait

        dictMasterSearch.Clear()
        BuildSearchParameters()
        'SearchParmList = ListOfSearchTerms

        If rbAll.IsChecked Then
            TypeSQL = "C"
            Dim S1 As String = proxy2.GenerateSQL(dictMasterSearch, SecureID, TypeSQL)
            TypeSQL = "E"
            Dim S2 As String = proxy2.GenerateSQL(dictMasterSearch, SecureID, TypeSQL)
            S = S1 + vbCrLf
            S += S1 + "--***************************************************" + vbCrLf
            S += S2 + vbCrLf
        ElseIf rbContent.IsChecked Then
            TypeSQL = "C"
            S = proxy2.GenerateSQL(dictMasterSearch, SecureID, TypeSQL)
        ElseIf rbEmails.IsChecked Then
            TypeSQL = "E"
            S = proxy2.GenerateSQL(dictMasterSearch, SecureID, TypeSQL)
        End If

        Me.Cursor = Cursors.Arrow

        If DoNotShowMsgBox.Equals(False) Then
            Clipboard.Clear()
            Clipboard.SetText(S)
            MessageBox.Show("The generated sql is in the clipboard...")
            GeneratedSql = S
        Else
            GeneratedSql = S
            DoNotShowMsgBox = False
        End If
    End Sub
    ''' <summary>
    ''' Gets the archiver URL.
    ''' </summary>
    Sub getArchiverURL()
        'AddHandler ProxySearch.getArchiverURLCompleted, AddressOf client_ArchiverURL
        Dim SS As String = ProxySearch.getArchiverURL()
        client_ArchiverURL(SS)
    End Sub

    ''' <summary>
    ''' Clients the archiver URL.
    ''' </summary>
    ''' <param name="SS">The ss.</param>
    Sub client_ArchiverURL(SS As String)
        If SS.Length > 0 Then
            ArchiverURL = SS
        Else
            ArchiverURL = "http://www.EcmLibrary.com/ECMSaaS/ArchiverCLC/publish.htm"
        End If
        'RemoveHandler ProxySearch.getArchiverURLCompleted, AddressOf client_ArchiverURL
    End Sub

    ''' <summary>
    ''' Gets the CLC URL.
    ''' </summary>
    Sub getClcURL()
        'AddHandler ProxySearch.getClcURLCompleted, AddressOf client_ClcURL
        Dim SS As String = ProxySearch.getClcURL()
        client_ClcURL(SS)
    End Sub

    ''' <summary>
    ''' Clients the CLC URL.
    ''' </summary>
    ''' <param name="SS">The ss.</param>
    Sub client_ClcURL(SS As String)
        'This is the Downloader install URL
        If SS.Length > 0 Then
            ClcURL = SS
        Else
            ClcURL = "http://www.EcmLibrary.com/ECMSaaS/ClcDownloader/publish.htm"
        End If
    End Sub

    ''' <summary>
    ''' Gets the affinity.
    ''' </summary>
    Sub getAffinity()
        'AddHandler ProxySearch.getAffinitydelayCompleted, AddressOf client_getAffinity
        Dim II As Integer = ProxySearch.getAffinitydelay()
        client_getAffinity(II)
    End Sub

    ''' <summary>
    ''' Clients the get affinity.
    ''' </summary>
    ''' <param name="II">The ii.</param>
    Sub client_getAffinity(II As Integer)
        If II > 0 Then
            AffinityDelay = II
        Else
            AffinityDelay = 25
        End If
    End Sub

    ''' <summary>
    ''' Loads the system parameters.
    ''' </summary>
    Sub LoadSystemParameters()
        'AddHandler ProxySearch.getSystemParmCompleted, AddressOf client_LoadSystemParameters
        ProxySearch.getSystemParm(gSecureID, gSystemParms)
        client_LoadSystemParameters()
    End Sub

    ''' <summary>
    ''' Clients the load system parameters.
    ''' </summary>
    Sub client_LoadSystemParameters()
        If RC Then
            Dim tKey As String = ""
            Dim tVAl As String = ""
            Dim II As Integer = gSystemParms.Count
            For Each tKey In gSystemParms.Keys
                tVAl = gSystemParms.Item(tKey)
                If Not gSystemParms.ContainsKey(tKey) Then
                    gSystemParms.Add(tKey, tVAl)
                End If
            Next
            SB.Text = "System Parms Loaded: " & gSystemParms.Count & " and DB Connection good."
            Console.WriteLine(gSystemParms.Count)
        Else
            SB.Text = "System Parms failed to Load / DB Failed to attach."
        End If
        'RemoveHandler ProxySearch.getSystemParmCompleted, AddressOf client_LoadSystemParameters
    End Sub

    ''' <summary>
    ''' Determines whether [is key word] [the specified kw].
    ''' </summary>
    ''' <param name="KW">The kw.</param>
    ''' <returns><c>true</c> if [is key word] [the specified kw]; otherwise, <c>false</c>.</returns>
    Function isKeyWord(ByVal KW As String) As Boolean
        Dim B As Boolean = False
        KW = UCase(KW)
        Select Case KW
            Case "AND"
                Return True
            Case "OR"
                Return True
            Case "NOT"
                Return True
            Case "NEAR"
                Return True
            Case "AND"
                Return True
            Case "FORMSOF"
                Return True
        End Select
        Return B
    End Function

    ''' <summary>
    ''' Cks for near clause.
    ''' </summary>
    ''' <param name="sText">The s text.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function CkForNearClause(ByVal sText As String) As Boolean

        Dim I As Integer = 0
        Dim B As Boolean = False
        Dim Words() As String
        Words = sText.Split(" ")
        Dim PWord As String = ""
        Dim CWord As String = ""
        For Each CWord In Words
            If CWord.ToUpper.Equals("NEAR") Then
                If isKeyWord(PWord) Then
                    B = True
                    Exit For
                End If
            End If
            PWord = CWord
        Next

        Return B
    End Function

    ''' <summary>
    ''' Handles the Click event of the btnSubmit control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnSubmit.Click
        If bQuickSearchRecall2 Then
            Return
        End If
        Dim bProb As Boolean = CkForNearClause(txtSearch.Text.Trim)
        If bProb Then
            MessageBox.Show("The word 'NEAR' maybe preceeded by a keyword, this may cause this search to fail.")
        End If

        nbrExecutedSearches += 1

        currSearchCnt = 0
        bFirstEmailSearchSubmit = True
        bFirstContentSearchSubmit = True

        QuickSearchAdd()

        ButtonBounce = 0
        DictGuids.Clear()
        bEmailScrolling = False
        bContentScrolling = False

        EmailSearchCnt = 0
        ContentSearchCnt = 0

        PageRowLimit = CInt(nbrEmailRows.Text)

        SB.Text = "Starting the search @ " + Now.ToShortTimeString

        '*****************************************************************
        'Dim TS As TimeSpan = Nothing
        Dim SWatch As Stopwatch = New Stopwatch
        SWatch.Start()
        '*****************************************************************
        dgContent.Opacity = 0.5
        dgEmails.Opacity = 0.5
        '------------------------------------------------------------------------------------
        PerformSearch(True)
        '------------------------------------------------------------------------------------
        dgContent.Opacity = 100
        dgEmails.Opacity = 100
        '*****************************************************************
        SWatch.Stop()
        TS = SWatch.Elapsed
        Dim elapsedTime As String = String.Format("{0:00}:{1:00}:{2:00}.{3:00}",
            TS.Hours, TS.Minutes, TS.Seconds,
            TS.Milliseconds / 10)

        SBMsg.Text = "Search Elapsed Time: " + elapsedTime
        '*****************************************************************

        Console.WriteLine("Search completed...")

        btnSubmit.Visibility = Visibility.Visible

        setEmailColumnWidths()

        Dim cCnt As Integer = dgContent.Items.Count
        Dim eCnt As Integer = dgEmails.Items.Count

        If gDebug Then Console.WriteLine("Rows returned: " + cCnt.ToString)

        If rbAll.IsChecked Then
            SBDoc.Text = "Rows returned: " + cCnt.ToString
            SBEmail.Text = "Rows returned: " + eCnt.ToString
        End If
        If rbContent.IsChecked Then
            SBDoc.Text = "Rows returned: " + cCnt.ToString
        End If
        If rbEmails.IsChecked Then
            SBEmail.Text = "Rows returned: " + eCnt.ToString
        End If

    End Sub

    ''' <summary>
    ''' Handles the closed event of the Handler_frmSearchAsst control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
    Sub Handler_frmSearchAsst_closed(ByVal sender As Object, ByVal e As EventArgs)
        Dim NewSearchCriteria As String = ""
        Dim lw As frmSearchAsst = DirectCast(sender, frmSearchAsst)
        If lw.DialogResult = True Then
            NewSearchCriteria = lw.SearchCriteria
            txtSearch.Text = NewSearchCriteria
        End If

        'Dim A() As String = Split(txtSearch.Text, " ")

        'UpdateSearchDict("asst.txtAllOfTheseWords", txtAllOfTheseWords.Text.Trim)
        'UpdateSearchDict("asst.ckPhrase", ckPhrase.ToString)
        'UpdateSearchDict("asst.ckNear", ckNear.ToString)
        'UpdateSearchDict("asst.ckNone", ckNone.ToString)
        'UpdateSearchDict("asst.ckInflection", ckPhrase.ToString)
        'UpdateSearchDict("asst.ckClassonomy", ckPhrase.ToString)
        'UpdateSearchDict("asst.txtExactPhrase", txtExactPhrase.Text.Trim)
        'UpdateSearchDict("asst.txtAnyOfThese", txtAnyOfThese.Text.Trim)
        'UpdateSearchDict("asst.txtNear", txtNear.Text.Trim)
        'UpdateSearchDict("asst.txtNoneOfThese", txtNoneOfThese.Text.Trim)
        'UpdateSearchDict("asst.txtInflection", txtInflection.Text.Trim)
        'UpdateSearchDict("asst.txtMsThesuarus", txtMsThesuarus.Text.Trim)
        'UpdateSearchDict("asst.txtEcmThesaurus", txtEcmThesaurus.Text.Trim)
        'UpdateSearchDict("asst.cbAvailThesauri", cbAvailThesauri.Text.Trim)
        'UpdateSearchDict("asst.cbSelectedThesauri", cbSelectedThesauri.Text.Trim)

        'UpdateSearchDict("asst.cbDateRange", cbDateRange.Text.Trim)
        'UpdateSearchDict("asst.dtStart", dtStart.SelectedDate.ToString)
        'UpdateSearchDict("asst.dtEnd", dtEnd.SelectedDate.ToString)
    End Sub

    'Private Sub SubMenuContent_Click(ByVal sender As System.Object, ByVal e As RoutedEventArgs) Handles SubMenuContent.Click
    '    SB.Text = "Content SubMenuContent Clicked"
    '    MessageBox.Show("SubMenuContent Pressed")
    'End Sub

    'Private Sub SubMenuEmail_Click(ByVal sender As System.Object, ByVal e As RoutedEventArgs) Handles SubMenuEmail.Click
    '    SB.Text = "Content SubMenuEmail Clicked"
    '    MessageBox.Show("SubMenuEmail Pressed")
    'End Sub

    ''' <summary>
    ''' Handles the Click event of the btnReset control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnReset_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnReset.Click
        If bQuickSearchRecall2 Then
            Return
        End If
        txtSearch.Text = ""
        ckShowDetails.IsChecked = False
        ckMyContent.IsChecked = False
        ckMasterOnly.IsChecked = False
        nbrWeightMin.Text = "0"
        rbContent.IsChecked = False
        rbEmails.IsChecked = False
        rbAll.IsChecked = False
        ckLimitToLib.IsChecked = False
        ckFilters.IsChecked = False
        'dgEmails.ItemsSource = Nothing
        'dgContent.ItemsSource = Nothing
        PB.Visibility = Windows.Visibility.Collapsed
        SB.Text = ""
    End Sub

    ''' <summary>
    ''' Handles the MouseRightButtonDown event of the txtSearch control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Input.MouseButtonEventArgs"/> instance containing the event data.</param>
    Private Sub txtSearch_MouseRightButtonDown(ByVal sender As System.Object, ByVal e As System.Windows.Input.MouseButtonEventArgs)
        SB.Text = "Search Assistant"
        Dim NextPage As New frmSearchAsst(gSecureID)
        NextPage.ShowDialog()
    End Sub

    ''' <summary>
    ''' Sets the filter visibility.
    ''' </summary>
    Sub SetFilterVisibility()
        If ckFilters.IsChecked Then
            ckLimitToLib.Visibility = Windows.Visibility.Visible
            cbLibrary.Visibility = Windows.Visibility.Visible
            rbAll.Visibility = Windows.Visibility.Visible
            rbEmails.Visibility = Windows.Visibility.Visible
            rbContent.Visibility = Windows.Visibility.Visible
            ckMyContent.Visibility = Windows.Visibility.Visible
            ckWeights.Visibility = Windows.Visibility.Visible
            ckMasterOnly.Visibility = Windows.Visibility.Visible
            nbrWeightMin.Visibility = Windows.Visibility.Visible
            btnLibrary.Visibility = Windows.Visibility.Visible

            btnReset.Visibility = Visibility.Visible
            ckShowDetails.Visibility = Visibility.Visible

            If _isAdmin Then
                hlScheduleSearch.Visibility = Visibility.Visible
                hlAlerts.Visibility = Visibility.Visible
            Else
                hlScheduleSearch.Visibility = Visibility.Collapsed
                hlAlerts.Visibility = Visibility.Collapsed
            End If
        Else
            ckLimitToLib.Visibility = Windows.Visibility.Collapsed
            cbLibrary.Visibility = Windows.Visibility.Collapsed
            rbAll.Visibility = Windows.Visibility.Collapsed
            rbEmails.Visibility = Windows.Visibility.Collapsed
            rbContent.Visibility = Windows.Visibility.Collapsed
            ckMyContent.Visibility = Windows.Visibility.Collapsed
            ckWeights.Visibility = Windows.Visibility.Collapsed
            ckMasterOnly.Visibility = Windows.Visibility.Collapsed
            nbrWeightMin.Visibility = Windows.Visibility.Collapsed
            btnLibrary.Visibility = Windows.Visibility.Collapsed

            btnReset.Visibility = Visibility.Collapsed
            ckShowDetails.Visibility = Visibility.Collapsed
            hlScheduleSearch.Visibility = Visibility.Collapsed
            hlAlerts.Visibility = Visibility.Collapsed

            hlScheduleSearch.Visibility = Windows.Visibility.Collapsed
        End If

    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the ckFilters control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckFilters_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckFilters.Unchecked
        If bQuickSearchRecall2 Then
            Return
        End If
        SetFilterVisibility()
        UdpateSearchTerm("ALL", "ckFilters", ckFilters.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnOpenRestoreScreen control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnOpenRestoreScreen_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnOpenRestoreScreen.Click
        If bQuickSearchRecall2 Then
            Return
        End If
        COMMON.SaveClick(1000, gCurrUserGuidID)
        If RepoTableName.Equals("EmailAttachment") Then
            MessageBox.Show("Sorry, an attachment is an 'embedded' component of an email." + vbCrLf + "Therefore, the entire email must be restored - not just the attachment.")
            Return
        End If

        btnOpenRestoreScreen.Visibility = Windows.Visibility.Visible

        SB.Text = "Download Requested: " + Now.ToString
        'Dim ISO As New clsIsolatedStorage
        Dim NextPage As New frmContentRestore(RepoTableName, dgEmails, dgAttachments, dgContent)
        NextPage.Show()

    End Sub

    ''' <summary>
    ''' Cks the CLC active.
    ''' </summary>
    Sub ckClcActive()

        Dim bIgnore = True

        If bIgnore Then
            Return
        End If
        Dim bClcRuning As Boolean = ISO.isClcActive(CurrUserGuidID)
        If Not bClcRuning Then
            SB.Text = "Downloader Not running - preview and restore are disabled."
            'lblClcState.Visibility = Windows.Visibility.Visible
            lblClcState.Content = "Downloader Not running"
            btnOpenRestoreScreen.Visibility = Windows.Visibility.Collapsed
        Else
            lblClcState.Visibility = Windows.Visibility.Collapsed
            btnOpenRestoreScreen.Visibility = Windows.Visibility.Visible
        End If
    End Sub

    ''' <summary>
    ''' Gets the attachment weights.
    ''' </summary>
    Sub GetAttachmentWeights()

        gettingGetAttachmentWeights = True
        ''Dim proxy As New SVCSearch.Service1Client
        'AddHandler ProxySearch.getAttachmentWeightsCompleted, AddressOf client_getAttachmentWeights
        ProxySearch.getAttachmentWeights(gSecureID, AttachmentWeights, CurrUserGuidID)
        client_getAttachmentWeights()

        gettingGetAttachmentWeights = False

    End Sub

    ''' <summary>
    ''' Clients the get attachment weights.
    ''' </summary>
    Sub client_getAttachmentWeights()
        If RC Then
            ApplyAttachmentWeights()
            FormLoaded = True
        Else
            AttachmentWeights = Nothing
        End If
    End Sub

    ''' <summary>
    ''' Applies the attachment weights.
    ''' </summary>
    Sub ApplyAttachmentWeights()

        If AttachmentWeights Is Nothing Then
            Return
        End If

        Dim iCnt As Integer = 0
        iCnt = dgEmails.Items.Count

        If iCnt = 0 Then
            bWaitToApplyAttachmentWeight = True
            Return
        End If

        Dim colidx As Integer = getColIdx(dgEmails, "EmailGuid")
        Dim IX As Integer = dgEmails.Columns(colidx).DisplayIndex
        colidx = getColIdx(dgEmails, "Rank")
        Dim iRank As Integer = dgEmails.Columns(colidx).DisplayIndex

        For i As Integer = 0 To iCnt - 1
            Dim emailguid As String = dgEmails.Items(i).cells(IX).ToString
            If AttachmentWeights.Keys.Contains(emailguid) Then
                Try
                    Dim iKey As Integer = CInt(AttachmentWeights.Item(emailguid))
                    Dim II As Integer = AttachmentWeights.Values(iKey)

                    Dim KK As Integer = CInt(dgEmails.Items(i).cells(iRank))
                    If II > KK Then
                        dgEmails.Items(i).cells(iRank) = II
                    End If
                Catch ex As Exception
                    LOG.WriteToSqlLog("INFO ApplyAttachmentWeights 001-1: " + ex.Message + vbCrLf + " I = " + i.ToString + " of " + dgEmails.Items.Count.ToString)
                End Try

            End If
        Next

    End Sub

    ''' <summary>
    ''' Gets the attachment count.
    ''' </summary>
    ''' <returns>System.Int32.</returns>
    Function GetAttachmentCount() As Integer
        Dim iCnt As Integer = 0
        Try
            Dim colidx As Integer = getColIdx(dgEmails, "FoundInAttachment")
            Dim iCol As Integer = dgEmails.Columns(colidx).DisplayIndex
            For i As Integer = 0 To dgEmails.Items.Count - 1
                Dim CH As String = dgEmails.Items(i).Cells(iCol).ToString
                If CH.Equals("Y") Then
                    iCnt += 1
                End If
            Next
        Catch ex As Exception
            iCnt = 0
        End Try

        Return iCnt
    End Function

    ''' <summary>
    ''' Executes the search.
    ''' </summary>
    ''' <param name="bGenSqlOnly">if set to <c>true</c> [b gen SQL only].</param>
    ''' <param name="CallLocation">The call location.</param>
    Sub ExecuteSearch(ByVal bGenSqlOnly As Boolean, CallLocation As String)

        PB.IsIndeterminate = True
        PB.Visibility = Visibility.Visible

        If rbAll.IsChecked Then
            TabContent.Visibility = Visibility.Visible
            TabEmail.Visibility = Visibility.Visible
        ElseIf rbEmails.IsChecked Then
            TabContent.Visibility = Visibility.Collapsed
            TabEmail.Visibility = Visibility.Visible
        ElseIf rbContent.IsChecked Then
            TabContent.Visibility = Visibility.Visible
            TabEmail.Visibility = Visibility.Collapsed
        End If

        dgAttachments.Visibility = Windows.Visibility.Collapsed

        ButtonBounce += 1
        Console.WriteLine("ButtonBounce 01 = " & ButtonBounce)

        ExecutingSearch = False     'WDMXX Remove after testing
        If ExecutingSearch Then
            PB.IsIndeterminate = True
            PB.Visibility = Visibility.Hidden
            Return
        End If

        ExecutingSearch = True
        If ckLimitToLib.IsChecked Then
            If cbLibrary.SelectedItem Is Nothing Then
                MessageBox.Show("You have selected to limit the search to one library and failed to pick which one, returning.")
                PB.IsIndeterminate = True
                PB.Visibility = Visibility.Hidden
                Return
            End If
        End If

        Cursor = Cursors.Wait

        qStartTime = Now

        btnSubmit.IsEnabled = False

        If nbrWeightMin.Text.Trim.Length = 0 Then
            nbrWeightMin.Text = "0"
        End If

        Dim LowerPageNumber As Integer = 0
        Dim UpperPageNumber As Integer = PageRowLimit
        Dim AutoSql As String = ""

        Dim SearchText As String = txtSearch.Text.Trim

        Dim bNeedRowCount As Boolean = True
        'bStartNewSearch = True
        If bStartNewSearch Then
            UdpateSearchTerm("ALL", "isSuperAdmin", _isSuperAdmin.ToString, "B")
            UdpateSearchTerm("ALL", "isAdmin", _isAdmin.ToString, "B")
            UdpateSearchTerm("ALL", "isGlobalSearcher", _isGlobalSearcher.ToString, "B")

            UdpateSearchTerm("ALL", "CalledFromScreen", Me.Title, "S")
            UdpateSearchTerm("ALL", "UID", CurrUserGuidID, "S")

            UdpateSearchTerm("ALL", "CurrUserGuidID", CurrUserGuidID.Trim, "S")
            UdpateSearchTerm("ALL", "CurrLoginID", CurrLoginID.Trim, "S")
            UdpateSearchTerm("ALL", "UID", CurrUserGuidID.Trim, "S")

            UdpateSearchTerm("ALL", "txtSearch", SearchText.Trim, "S")
            UdpateSearchTerm("ALL", "bNeedRowCount", bNeedRowCount.ToString, "B")
            UdpateSearchTerm("ALL", "rbAll", rbAll.IsChecked.ToString, "B")
            UdpateSearchTerm("ALL", "rbEmails", rbEmails.IsChecked.ToString, "B")
            UdpateSearchTerm("ALL", "rbContent", rbContent.IsChecked.ToString, "B")
            UdpateSearchTerm("ALL", "ckWeights", ckWeights.IsChecked.ToString, "B")
            UdpateSearchTerm("ALL", "ckLimitToLib", ckLimitToLib.IsChecked.ToString, "B")
            UdpateSearchTerm("ALL", "cbLibrary", cbLibrary.SelectedItem, "S")
            UdpateSearchTerm("ALL", "MinWeight", nbrWeightMin.Text, "I")
            UdpateSearchTerm("ALL", "LowerPageNbr", LowerPageNumber.ToString, "I")
            UdpateSearchTerm("ALL", "UpperPageNbr", UpperPageNumber.ToString, "I")
            UdpateSearchTerm("ALL", "GeneratedSql", AutoSql, "S")
            UdpateSearchTerm("ALL", "CurrentDocPage", CurrentDocPage.ToString, "I")
            UdpateSearchTerm("ALL", "CurrentEmailPage", CurrentEmailPage.ToString, "I")
            UdpateSearchTerm("ALL", "StartingEmailRow", "0", "I")
            UdpateSearchTerm("ALL", "EndingEmailRow", UpperPageNumber.ToString, "I")
            UdpateSearchTerm("ALL", "StartingContentRow", "0", "I")
            UdpateSearchTerm("ALL", "EndingContentRow", UpperPageNumber.ToString, "I")

            UpdateState(True, 0, PageRowLimit, 0, PageRowLimit)
        Else

            UdpateSearchTerm("ALL", "CurrUserGuidID", CurrUserGuidID.Trim, "S")
            UdpateSearchTerm("ALL", "CurrLoginID", CurrLoginID.Trim, "S")
            UdpateSearchTerm("ALL", "UID", CurrUserGuidID.Trim, "S")

            UdpateSearchTerm("ALL", "isSuperAdmin", _isSuperAdmin.ToString, "B")
            UdpateSearchTerm("ALL", "isAdmin", _isAdmin.ToString, "B")
            UdpateSearchTerm("ALL", "isGlobalSearcher", _isGlobalSearcher.ToString, "B")

            UdpateSearchTerm("ALL", "txtSearch", SearchText.Trim, "S")
            UdpateSearchTerm("ALL", "ckWeights", ckWeights.IsChecked.ToString, "B")

            LowerPageNumber += PageRowLimit
            UpperPageNumber += PageRowLimit
            UdpateSearchTerm("ALL", "LowerPageNbr", LowerPageNumber.ToString, "I")
            UdpateSearchTerm("ALL", "UpperPageNbr", UpperPageNumber.ToString, "I")

            If bEmailScrolling Then
                UpdateState(True, dgEmails.Items.Count, dgEmails.Items.Count + PageRowLimit, dgContent.Items.Count, dgContent.Items.Count)
                UdpateSearchTerm("ALL", "rbAll", "False", "B")
                UdpateSearchTerm("ALL", "rbEmails", "True", "B")
                UdpateSearchTerm("ALL", "rbContent", "False", "B")
            ElseIf bContentScrolling Then
                UpdateState(True, dgEmails.Items.Count, dgEmails.Items.Count, dgContent.Items.Count, dgContent.Items.Count + PageRowLimit)
                UdpateSearchTerm("ALL", "rbAll", "False", "B")
                UdpateSearchTerm("ALL", "rbEmails", "False", "B")
                UdpateSearchTerm("ALL", "rbContent", "True", "B")
            Else
                UpdateState(True, dgEmails.Items.Count, dgEmails.Items.Count + PageRowLimit, dgContent.Items.Count, dgContent.Items.Count + PageRowLimit)
                UdpateSearchTerm("ALL", "rbAll", rbAll.IsChecked.ToString, "B")
                UdpateSearchTerm("ALL", "rbEmails", rbEmails.IsChecked.ToString, "B")
                UdpateSearchTerm("ALL", "rbContent", rbContent.IsChecked.ToString, "B")
            End If

            Dim iEmailStart As Integer = dgEmails.Items.Count
            Dim iContentStart As Integer = dgContent.Items.Count
            Dim iEmailEnd As Integer = iEmailStart + 50
            Dim iContentEnd As Integer = iContentStart + 50

            UdpateSearchTerm("ALL", "StartingEmailRow", iEmailStart.ToString, "I")
            UdpateSearchTerm("ALL", "EndingEmailRow", UpperPageNumber.ToString, "I")
            UdpateSearchTerm("ALL", "StartingContentRow", iContentStart.ToString, "I")
            UdpateSearchTerm("ALL", "EndingContentRow", UpperPageNumber.ToString, "I")

        End If

        'bFirstEmailSearchSubmit = True
        'bFirstContentSearchSubmit = True

        Dim xSql As String = GeneratedSql

        'dgContent.ItemsSource = Nothing
        'dgEmails.ItemsSource = Nothing

        Dim iMaxRows As Integer = 0
        If DocUpperPageNbr > EmailUpperPageNbr Then
            iMaxRows = DocUpperPageNbr
        Else
            iMaxRows = EmailUpperPageNbr
        End If
        If iMaxRows = 0 Then
            iMaxRows = PageRowLimit
        End If

        Console.WriteLine("Called From: " + CallLocation)
        'AddHandler ProxySearch.ExecuteSearchCompleted, AddressOf client_ApplyReturnedSearchData
        Try
            If ProxySearch Is Nothing Then
                'Dim proxy As New SVCSearch.Service1Client
            End If
            'If ListOfSearchTerms Is Nothing Then
            '    ListOfSearchTerms = New System.Collections.Generic.List(Of SVCSearch.DS_SearchTerms)
            'End If
            If gListOfEmailsTemp Is Nothing Then
                gListOfEmailsTemp = New System.Collections.Generic.List(Of SVCSearch.DS_EMAIL)
            End If
            If gListOfContentTemp Is Nothing Then
                gListOfContentTemp = New System.Collections.Generic.List(Of SVCSearch.DS_CONTENT)
            End If

            Dim strListOEmailRows As String = ""
            Dim strListOfContentRows As String = ""

            'Dim SearchParmsJson As String = Newtonsoft.Json.JsonConvert.SerializeObject(ListOfSearchTerms)

            For Each sSS As String In dictMasterSearch.Keys
                If dictMasterSearch.ContainsKey(sSS) Then
                    Console.WriteLine(sSS + " :" + dictMasterSearch(sSS))
                Else
                    Console.WriteLine(sSS + " : missing ")
                End If
            Next

            Dim SearchParmsJson As String = Newtonsoft.Json.JsonConvert.SerializeObject(dictMasterSearch)
            Console.WriteLine("Start Search: " + Now.ToString)
            Dim RetDict As Dictionary(Of String, String) = New Dictionary(Of String, String)

            Dim EmailGuidID As String = ""
            Dim ContentGuidID As String = ""

            If rbAll.IsChecked Or rbContent.IsChecked Then
                ContentGuidID = ProxySearch.ExecuteSearchContent(gSecureID,
                                 currSearchCnt,
                                 bGenSqlOnly,
                                 SearchParmsJson,
                                 bFirstContentSearchSubmit,
                                 ContentSearchCnt)

            End If

            If rbAll.IsChecked Or rbEmails.IsChecked Then
                EmailGuidID = ProxySearch.ExecuteSearchEmail(gSecureID,
                                 currSearchCnt,
                                 bGenSqlOnly,
                                 SearchParmsJson,
                                 bFirstEmailSearchSubmit,
                                 EmailSearchCnt)
            End If

            RetDict.Add("ContentGuidID", ContentGuidID)
            RetDict.Add("EmailGuidID", EmailGuidID)

            Console.WriteLine("End Search: " + Now.ToString)
            Console.WriteLine("Start client Search: " + Now.ToString)

            client_ApplyReturnedSearchData(gSecureID,
                                 bFirstEmailSearchSubmit,
                                 bFirstContentSearchSubmit,
                                 RetDict)

            Console.WriteLine("END client Search: " + Now.ToString)
            Console.WriteLine(" ")
        Catch ex As Exception
            Dim errmsg As String = ex.Message
            Dim stack As String = ex.StackTrace.ToString
            Clipboard.Clear()
            Clipboard.SetText(errmsg + vbCrLf + vbCrLf + stack)
        End Try

        btnSubmit.IsEnabled = True
        bIncludeLibraryFilesInSearch = False
        gListOfEmailsTemp = Nothing
        gListOfContentTemp = Nothing

        If rbAll.IsChecked Then
            TabContent.Visibility = Visibility.Visible
            TabEmail.Visibility = Visibility.Visible
        ElseIf rbEmails.IsChecked Then
            TabContent.Visibility = Visibility.Collapsed
            TabEmail.Visibility = Visibility.Visible
        ElseIf rbContent.IsChecked Then
            TabContent.Visibility = Visibility.Visible
            TabEmail.Visibility = Visibility.Collapsed
        End If

        PB.IsIndeterminate = False
        PB.Visibility = Visibility.Hidden
        btnSubmit.Visibility = Visibility.Visible
        btnSubmit.IsEnabled = True
        Me.Cursor = Cursors.Arrow

    End Sub

    ''' <summary>
    ''' Clients the apply returned search data.
    ''' </summary>
    ''' <param name="gSecureID">The g secure identifier.</param>
    ''' <param name="bFirstEmailSearchSubmit">if set to <c>true</c> [b first email search submit].</param>
    ''' <param name="bFirstContentSearchSubmit">if set to <c>true</c> [b first content search submit].</param>
    ''' <param name="RetDict">The ret dictionary.</param>
    Sub client_ApplyReturnedSearchData(
            gSecureID As Integer,
            bFirstEmailSearchSubmit As Boolean,
            bFirstContentSearchSubmit As Boolean,
            RetDict As Dictionary(Of String, String))

        Dim EmailRowCnt As Integer = 0
        Dim ContentRowCnt As Integer = 0
        Dim ListOEmailRows As List(Of SVCSearch.DS_EMAIL) = New List(Of SVCSearch.DS_EMAIL)()
        Dim ListOfContentRows As List(Of SVCSearch.DS_CONTENT) = New List(Of SVCSearch.DS_CONTENT)()

        Dim jss = New JavaScriptSerializer()

        Dim ContentGuidID As String = RetDict("ContentGuidID")
        Dim EmailGuidID As String = RetDict("EmailGuidID")

        Dim ContentJson As String = proxy2.getJsonData(ContentGuidID)
        Dim EmailJson As String = proxy2.getJsonData(EmailGuidID)

        If gDebug Then Console.WriteLine("ContentJson Length: " + ContentJson.Length.ToString)
        If gDebug Then Console.WriteLine("EmailJson Length: " + EmailJson.Length.ToString)

        Dim ObjContent As Object = jss.Deserialize(Of SVCSearch.DS_CONTENT())(ContentJson)
        Dim ObjEmail As Object = jss.Deserialize(Of SVCSearch.DS_EMAIL())(EmailJson)

        If ContentJson.Trim.Length > 0 Then
            DSCONTENT = DSMGT.ConvertObjContentToDataset(ObjContent)
        End If
        If EmailJson.Trim.Length > 0 Then
            DSEMAIL = DSMGT.ConvertObjEmailToDataset(ObjEmail)
        End If
        If ContentJson.Trim.Length = 0 Then
            dgContent.ItemsSource = Nothing
        End If
        If EmailJson.Trim.Length = 0 Then
            dgEmails.ItemsSource = Nothing
        End If

        If ContentJson.Trim.Length >= 1 And (rbAll.IsChecked Or rbContent.IsChecked) Then
            'Dim ListOfContent As New List(Of SVCSearch.DS_CONTENT)
            'dgContent.ItemsSource = Nothing
            'For Each O In ObjContent
            '    ListOfContent.Add(O)
            '    dgContent.Items.Add(O)
            'Next

            Dim rCnt As Integer = DSCONTENT.Tables(0).Rows.Count
            Try
                dgContent.ItemsSource = Nothing
                dgContent.ItemsSource = New DataView(DSCONTENT.Tables(0))
                dgContent.Items.Refresh()
            Catch ex As Exception
                Dim smsg As String = "ERROR (Content) client_ApplyReturnedSearchData: " + ex.Message + vbCrLf + vbCrLf + ex.InnerException.ToString
                Console.WriteLine(smsg)
            End Try

        End If
        If EmailJson.Trim.Length >= 1 And (rbAll.IsChecked Or rbEmails.IsChecked) Then
            Try
                dgEmails.ItemsSource = Nothing
                dgEmails.ItemsSource = New DataView(DSEMAIL.Tables(0))
                dgEmails.Items.Refresh()
            Catch ex As Exception
                Dim smsg As String = "ERROR (Email) client_ApplyReturnedSearchData: " + ex.Message + vbCrLf + vbCrLf + ex.InnerException.ToString
                Console.WriteLine(smsg)
            End Try

        End If

        dgContent.Items.Refresh()
        dgEmails.Items.Refresh()



        PB.IsIndeterminate = False
        PB.Visibility = Visibility.Hidden

        Return

        If EmailRowCnt > 0 Then
            For Each Obj As SVCSearch.DS_EMAIL In ObjEmail
                ListOEmailRows.Add(Obj)
            Next
        End If
        If ContentRowCnt > 0 Then
            Dim DS As DataSet = DSMGT.ConvertObjContentToDataset(ObjContent)
            dgContent.ItemsSource = Nothing
            dgContent.ItemsSource = New DataView(DS.Tables(0))
            dgContent.Items.Refresh()

            'For Each Obj As SVCSearch.DS_CONTENT In ObjContent
            '    ListOfContentRows.Add(Obj)
            'Next
        End If

        dgContent.ItemsSource = Nothing
        If ContentRowCnt > 0 Then
            dgContent.RowHeight = 10
            dgContent.ItemsSource = ListOfContentRows
            dgContent.Visibility = Windows.Visibility.Visible
        End If
        dgContent.Items.Refresh()

        dgEmails.ItemsSource = Nothing
        If EmailRowCnt > 0 Then
            dgEmails.RowHeight = 10
            dgEmails.ItemsSource = ListOEmailRows
            dgEmails.Visibility = Windows.Visibility.Visible
        End If
        dgEmails.Items.Refresh()

    End Sub

    ''' <summary>
    ''' Sets the height of the email g rid row.
    ''' </summary>
    Sub setEmailGRidRowHeight()
        If bEmailRowHeightSet = True Then
            'Return
        End If
        bSettingEmailRowHeight = True
        For i As Integer = 0 To dgEmails.Items.Count - 1
            Dim DR As DataGridRow = grid.GetRow(dgEmails, i)
            DR.Height = 25
        Next
        Dim cw As String = "250"
        For I As Integer = 0 To dgEmails.Columns.Count - 1
            Dim ColName As String = dgEmails.Columns(I).Header
            Dim ColOrder As Integer = I
            Dim ColWidth As Integer = 0
            If dgEmails.Columns(I).Width.ToString.Equals("Auto") Then
                ColWidth = -1
            Else
                ColWidth = CInt(dgEmails.Columns(I).Width.ToString)
            End If
            If ColName.ToUpper.Equals("BODY") Then
                dgEmails.Columns(I).Width = cw
            End If
            If ColName.ToUpper.Equals("CC") Then
                dgEmails.Columns(I).Width = cw
            End If
            If ColName.ToUpper.Equals("ALLRECIPIENTS") Then
                dgEmails.Columns(I).Width = cw
            End If
            'ColVisible = dgEmails.Columns(I).Visibility
            'ColReadOnly = dgEmails.Columns(I).IsReadOnly

            'ProxySearch.saveGridLayout(gSecureID, UserID, ScreenName, GridName, ColName, ColOrder, ColWidth, ColVisible, ColReadOnly, ColSortOrder, ColSortAsc, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate, RowNbr, RC, rMsg)
            'client_saveGridLayout(RC, rMsg)
        Next

        grid.SelectRowByIndex(dgEmails, TopRow)
        bSettingEmailRowHeight = False
        bEmailRowHeightSet = True
    End Sub

    'Sub SearchEmails(ByVal Calledfrom As String, ByVal SearchString As String, ByVal ZeroizeGrid As Boolean, ByVal bIncludeAllLibs As Boolean, ByVal IncludeWeights As Boolean, ByVal IsUserAdmin As Boolean, ByVal ckLimitToLib As Boolean, ByVal LibraryName As String)
    '    Dim BB As Boolean = False
    '    Dim AutoGeneratedSQL As String = ""
    '    Dim StartTime As Date = Now

    ' SQLGEN.pTxtSearch = SearchString.Trim SQLGEN.pCkBusiness = False 'Me.ckBusiness.isChecked
    ' SQLGEN.pGetCountOnly = False '**Me.ckCountOnly.isChecked SQLGEN.pUseExistingRecordsOnly = False
    ' 'Me.ckLimitToExisting.isChecked SQLGEN.pCkWeighted = IncludeWeights SQLGEN.pGeneratedSQL =
    ' AutoGeneratedSQL SQLGEN.pIsAdmin = IsUserAdmin SQLGEN.pCkBusiness = False 'ckBusiness.isChecked

    ' Dim MinWeight As Integer = Val(nbrWeightMin.Text) Dim bCkLimitToExisting As Boolean = False Dim
    ' bCkBusiness As Boolean = False Dim GeneratedSQL As String = ""

    ' '********************************************************************************************************************************************************************************************************
    ' ZeroizeGrid = False If ZeroizeGrid = False Then AutoGeneratedSQL =
    ' SQLGEN.GenEmailGeneratedSQL(bCkLimitToExisting, "", "", IncludeWeights, bCkBusiness,
    ' SearchString, ckLimitToLib, LibraryName, MinWeight, bIncludeAllLibs, False, False,
    ' GeneratedSQL) xEmailQry = AutoGeneratedSQL Else AutoGeneratedSQL = "Select * from DataSource
    ' where 1 = 2" End If

    ' '*******************************************************************************************************************************************************************************************************

    ' If bIncludeLibraryFilesInSearch = True Then Dim a$() a = AutoGeneratedSQL.Split(vbCrLf)
    ' AutoGeneratedSQL = "" For ii As Integer = 0 To UBound(a) If a(ii).Trim.Length = 0 Then Else
    ' AutoGeneratedSQL += a(ii).Trim + vbCrLf End If Next End If

    ' 'PopulateEmailGrid(AutoGeneratedSQL) Dim SSX$ = AutoGeneratedSQL AutoGeneratedSQL = SSX If
    ' gPaginateData = True Then If bNeedRowCount = True Then

    ' 'TotalEmailRows = DB.iCountContent(AutoGeneratedSQL) 'Dim proxy As New SVCSearch.Service1Client
    ' AddHandler ProxySearch.iCountContentCompleted, AddressOf client_iCountContent ProxySearch.iCountContentAsync(AutoGeneratedSQL)

    ' End If

    ' Dim SQLCls As New clsSql SQLCls.AddPaging(EmailLowerPageNbr, EmailUpperPageNbr,
    ' AutoGeneratedSQL, bIncludeLibraryFilesInSearch) SQLCls = Nothing

    ' '** Now at this point today, there is a rogue ORDER BY clause in the email paging query. '** Of
    ' course, it has to be removed or in this case, commented out '** I do not want to troubleshoot
    ' the generator, I will just do it in a simplistic manner. AutoGeneratedSQL =
    ' AutoGeneratedSQL.Replace("order by [ShortSubj]", "/*order by [ShortSubj]*/")
    ' Console.WriteLine("Replaced Order by here") End If

    ' UTIL.ckSqlQryForDoubleKeyWords(AutoGeneratedSQL)

    ' If gHiveEnabled = True Then If gHiveServersList.Count > 0 Then
    ' UTIL.AddHiveSearch(AutoGeneratedSQL, gHiveServersList) End If End If

    ' If GenSqlOnly = True Then CB_SQL$ = CB_SQL$ + AutoGeneratedSQL + vbCrLf + "/****** END OF EMAIL
    ' QUERY ******/" AutoGeneratedSQL += vbCrLf + "/****** END OF EMAIL QUERY ******/"
    ' Clipboard.SetText(AutoGeneratedSQL) Return End If

    ' '*************************************************** Dim SS As String =
    ' AutoGeneratedSQL.Replace(",", "," + vbCrLf) 'Dim SS As String = "" 'Dim AA() As String =
    ' AutoGeneratedSQL.Split(",") 'For II As Integer = 0 To UBound(AA) - 1 ' If AA(II).Trim.Length >
    ' 0 Then ' SS += AA(II) + "," + vbCrLf ' End If

    ' 'Next '*************************************************** 'AutoGeneratedSQL = SS Clipboard.SetText(SS)

    ' If IncludeWeights Then BB = PopulateEmailGridWeights(AutoGeneratedSQL) Else BB =
    ' PopulateEmailGridNoWeights(AutoGeneratedSQL) End If

    'End Sub

    ''' <summary>
    ''' Clients the content of the i count.
    ''' </summary>
    ''' <param name="iCount">The i count.</param>
    Sub client_iCountContent(iCount As Integer)
        If RC Then
            TotalEmailRows = iCount
            TotalEmailPages = Math.Floor(TotalEmailRows / PageRowLimit) + 1
        Else
            TotalEmailRows = -1
        End If
    End Sub

    ''' <summary>
    ''' Clients the get datasource parm author.
    ''' </summary>
    ''' <param name="Author">The author.</param>
    Sub client_getDatasourceParmAuthor(Author As String)

        If Author.Trim.Length = 0 Then
            Author = CurrLoginID
        Else
            Author = "Unknown"
        End If

        'Dim proxy2 As New SVCSearch.Service1Client
        'AddHandler proxy2.getDatasourceParmCompleted, AddressOf client_getDatasourceParmTitle
        Dim SS As String = proxy2.getDatasourceParm(gSecureID, "Title", getDatasourceParmSourceGuid)
        client_getDatasourceParmTitle(SS)
        gettingAuthor = False
    End Sub

    ''' <summary>
    ''' Clients the get datasource parm title.
    ''' </summary>
    ''' <param name="SS">The ss.</param>
    Sub client_getDatasourceParmTitle(SS As String)
        If SS.Length > 0 Then
            Dim Title As String = SS
            If Title.Length = 0 Then
                Title = "None Supplied"
            End If
        Else
            Title = "None Supplied"
        End If

        GS.setContentauthor(strAuthor)
        GS.setContentext(getDatasourceParmSourceTypeCode)
        GS.setContentguid(getDatasourceParmSourceGuid)
        GS.setContenttitle(Title)
        GS.setContenttype("Content")
        GS.setCreatedate(getDatasourceParmSourceCreateDate)
        GS.setUserid(CurrUserGuidID)
        'GS.setUserid(DataSourceOwnerUserID as string)
        GS.setAllrecipiants(getDatasourceParmSourceAllrecipiants)
        GS.setFilename(getDatasourceParmSourceFQN)
        GS.setFilesize(getDatasourceParmSourceFileLength)
        GS.setFromemailaddress("")
        GS.setNbrofattachments("0")
        GS.setWeight(getDatasourceParmSourceWeight)

        Dim b As Boolean = GS.Add
        If Not b Then
            LOG.WriteToSqlLog("frmQuickSearch:LoadDocSearchResultsV2 - Failed to save search results for Content ID '" + getDatasourceParmSourceGuid + "'")
        End If

        gettingTitle = False
    End Sub

    ''** Use the new storage type found in silverlight here clsIsolatedStorage
    ''' <summary>
    ''' Sorts the grid.
    ''' </summary>
    ''' <param name="GridToSort">The grid to sort.</param>
    Sub SortGrid(ByVal GridToSort As String)

        Dim bEnable As Boolean = False

        If Not bEnable Then
            Return
        End If

        Dim SortCol As String = ""
        Dim SortType As String = ""
        Dim RC As Boolean = False
        If GridToSort.ToUpper.Equals("BOTH") Then
            'Dim ISO As New clsIsolatedStorage
            Try
                ISO.getGridSortCol(Me.Title, "dgEmail", SortCol, SortType, CurrUserGuidID, RC)
                SortEmailGrid(SortCol, SortType)
                ISO.getGridSortCol(Me.Title, "dgContent", SortCol, SortType, CurrUserGuidID, RC)
                SortContentGrid(SortCol, SortType)
            Catch ex As Exception
                LOG.WriteToSqlLog("ERROR: frmQuickSearch:SortGrid 100 - " + ex.Message)
            Finally
                ''ISO = Nothing
            End Try
        ElseIf GridToSort.ToUpper.Equals("EMAIL") Then
            'Dim ISO As New clsIsolatedStorage
            Try
                ISO.getGridSortCol(Me.Title, "dgEmail", SortCol, SortType, CurrUserGuidID, RC)
                SortEmailGrid(SortCol, SortType)
            Catch ex As Exception
                LOG.WriteToSqlLog("ERROR: frmQuickSearch:SortGrid 100 - " + ex.Message)
            Finally
                ''ISO = Nothing
            End Try
        Else
            'Dim ISO As New clsIsolatedStorage
            Try
                ISO.getGridSortCol(Me.Title, "dgContent", SortCol, SortType, CurrUserGuidID, RC)
                SortContentGrid(SortCol, SortType)
            Catch ex As Exception
                LOG.WriteToSqlLog("ERROR: frmQuickSearch:SortGrid 200 - " + ex.Message)
            Finally
                ''ISO = Nothing
            End Try
        End If

    End Sub

    ''' <summary>
    ''' Saves the grid sort col.
    ''' </summary>
    Sub saveGridSortCol()

        If CurrentlySelectedGrid.Equals("EMAIL") Then
            'Dim ISO As New clsIsolatedStorage
            Try
                Dim iRow As Integer = dgEmails.SelectedIndex
                'Dim iCol As Integer = dgEmails.Columns.Selected(0).Index
                Dim iCol As Integer = dgEmails.SelectedCells(0).Column.DisplayIndex
                Dim AscendingOrder As Boolean = True
                Dim ColName$ = dgEmails.Columns(iCol).Header
                Dim msg$ = "Do you want to sort column " + ColName$ + " in ascending order?"
                Dim result As MessageBoxResult = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel)

                If result = MessageBoxResult.OK Then
                    SB.Text = "Save cancelled."
                    AscendingOrder = True
                Else
                    AscendingOrder = False
                End If
                ISO.saveGridSortCol(Me.Title, "dgEmail", ColName, AscendingOrder.ToString, CurrUserGuidID)
            Catch ex As Exception
                LOG.WriteToSqlLog("ERROR saveGridSortCol 100.1: Search Save Sort Col: " + ex.Message)
                SB.Text = "Failed to save sort column"
            Finally
                ''ISO = Nothing
            End Try
        Else
            'Dim ISO As New clsIsolatedStorage
            Try
                Dim iRow As Integer = dgContent.SelectedIndex
                'Dim iCol As Integer = dgContent.Columns.Selected(0).Index
                Dim iCol As Integer = dgContent.SelectedCells(0).Column.DisplayIndex
                Dim AscendingOrder As Boolean = True
                Dim ColName As String = dgContent.Columns(iCol).Header
                Dim msg$ = "Do you want to sort column " + ColName$ + " in ascending order?"
                Dim result As MessageBoxResult = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel)

                If result = MessageBoxResult.OK Then
                    SB.Text = "Save cancelled."
                    AscendingOrder = True
                Else
                    AscendingOrder = False
                End If
                ISO.saveGridSortCol(Me.Title, "dgContent", ColName, AscendingOrder.ToString, CurrUserGuidID)
            Catch ex As Exception
                LOG.WriteToSqlLog("ERROR saveGridSortCol 100.2: Search Save Sort Col: " + ex.Message)
                SB.Text = "Failed to save sort column"
            Finally
                ''ISO = Nothing
            End Try
        End If

        GC.Collect()

    End Sub

    ''' <summary>
    ''' Saves the grid column order.
    ''' </summary>
    Sub saveGridColumnOrder()
        Dim ValName As String = ""
        Dim ValValue As String = ""
        Dim IndexKey As Integer = 0
        Dim ScreenName As String = Me.Title
        Dim SaveTypeCode As String = "GridColOrder"

        If CurrentlySelectedGrid.Equals("EMAIL") Then
            GM.SaveGridState(CurrUserGuidID, Me.Title, dgEmails, dictEmailGridColDisplayOrder)
        Else
            GM.SaveGridState(CurrUserGuidID, Me.Title, dgContent, dictContentGridColDisplayOrder)
        End If

        GC.Collect()
        bGridColsRetrieved = False
    End Sub

    ''' <summary>
    ''' Gets the saved email grid columns display order.
    ''' </summary>
    Sub getSavedEmailGridColumnsDisplayOrder()
        GM.getGridState(Me.Title, dgEmails.Name, CurrUserGuidID, dictEmailGridColDisplayOrder)

        If dictEmailGridColDisplayOrder.Count = 0 Then
            GetEmailGridLayout(dictGridParmsEmail, dgEmails)
        End If

        ReorderEmailGridCols()
    End Sub

    ''' <summary>
    ''' Gets the saved content grid columns display order.
    ''' </summary>
    Sub getSavedContentGridColumnsDisplayOrder()
        Console.WriteLine("Trace:100")
        GM.getGridState(Me.Title, dgContent.Name, CurrUserGuidID, dictContentGridColDisplayOrder)

        If dictContentGridColDisplayOrder.Count = 0 Then
            GetContentGridLayout(dictGridParmsContent, dgContent)
        End If
        Console.WriteLine("Trace:105")
        ReorderContentGridCols()
    End Sub

    '*********************************************************************************

    ''' <summary>
    ''' Clients the load user search history.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="SearchHistoryArrayList">The search history array list.</param>
    Sub client_LoadUserSearchHistory(RC As Boolean, SearchHistoryArrayList As String())
        If RC Then
            DoNotGetSearchHistory = False
            FormLoaded = True
        Else
            SearchHistoryArrayList = Nothing
        End If
    End Sub

    '*********************************************************************************

    ''' <summary>
    ''' Zeroizes the global search.
    ''' </summary>
    Sub ZeroizeGlobalSearch()
        ''Dim proxy As New SVCSearch.Service1Client
        'AddHandler ProxySearch.ZeroizeGlobalSearchCompleted, AddressOf client_ZeroizeGlobalSearch
        Dim BB As Boolean = ProxySearch.ZeroizeGlobalSearch(gSecureID)
        client_ZeroizeGlobalSearch(BB)

    End Sub

    ''' <summary>
    ''' Clients the zeroize global search.
    ''' </summary>
    ''' <param name="BB">if set to <c>true</c> [bb].</param>
    Sub client_ZeroizeGlobalSearch(BB As Boolean)
        If Not BB Then
            SB.Text = "NOTICE: Failed to zeroize global search parms."
            LOG.WriteToSqlLog("ERROR client_ZeroizeGlobalSearch: ")
        End If
    End Sub

    '*********************************************************************************

    ''' <summary>
    ''' Saves the search parm parms.
    ''' </summary>
    ''' <param name="IndexKey">The index key.</param>
    Sub SaveSearchParmParms(ByVal IndexKey As Integer)

        If bSaveSearchesToDB Then
            SaveSearchHistory()
        End If

        dictScreenControls.Clear()

        'Dim ISO As New clsIsolatedStorage

        Dim ScreenName = "frmQuickSearch"
        Dim SaveTypeCode$ = "QUICKSEARCH"
        Dim UID As String = CurrUserGuidID
        Dim ValName As String = ""
        Dim ValValue As String = ""
        Dim B As Boolean = True

        Dim txtSelDir As String = "??"
        Dim ckShowDetails As Boolean = False
        Dim ckCountOnly As Boolean = False
        Dim ckLimitToExisting As Boolean = False
        Dim ckBusiness As Boolean = False
        Dim rbToDefaultDir As Boolean = False
        Dim rbToOriginalDir As Boolean = False
        Dim rbToSelDir As Boolean = False
        Dim ckOverWrite As Boolean = False

        ISO.ZeroizeSaveFormData(IndexKey, ScreenName, SaveTypeCode, UID, ValName, ValValue)

        SaveTypeCode = "QUICKSEARCH"

        ValName = "txtSearch"
        ValValue = txtSearch.Text.Trim
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "txtSelDir"
        'ValValue = txtSelDir
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "cbLibrary"
        ValValue = cbLibrary.SelectedItem
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "nbrWeightMin"
        ValValue = nbrWeightMin.Text
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "rbAll"
        ValValue = rbAll.IsChecked.ToString
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "rbContent"
        ValValue = rbContent.IsChecked.ToString
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "rbEmails"
        ValValue = rbEmails.IsChecked.ToString
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        'ValName = "ckShowDetails"
        'ValValue = ckShowDetails.IsChecked.ToString
        'ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "ckLimitToLib"
        ValValue = ckLimitToLib.IsChecked.ToString
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        'ValName = "ckCountOnly"
        'ValValue = ckCountOnly.IsChecked.ToString
        'ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "ckMyContent"
        ValValue = ckMyContent.IsChecked.ToString
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "ckMasterOnly"
        ValValue = ckMasterOnly.IsChecked.ToString
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        'ValName = "ckLimitToExisting"
        'ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "ckWeights"
        ValValue = ckWeights.IsChecked.ToString
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        'ValName = "ckBusiness"
        'ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        'ValName = "rbToDefaultDir"
        'ValValue = rbToDefaultDir.IsChecked.ToString
        'ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        'ValName = "rbToOriginalDir"
        'ValValue = rbToOriginalDir.IsChecked.ToString
        'ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        'ValName = "rbToSelDir"
        'ValValue = rbToSelDir.IsChecked.ToString
        'ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        'ValName = "ckOverWrite"
        'ValValue = ckOverWrite.IsChecked.ToString
        'ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValValue = lblMain.Content
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "ckFilters"
        ValValue = ckFilters.IsChecked.ToString
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "SBEmail"
        ValValue = SBEmail.Text
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "SBDoc"
        ValValue = SBDoc.Text
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "SB"
        ValValue = SB.Text
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ''ISO = Nothing

    End Sub



    ''' <summary>
    ''' Saves the search.
    ''' </summary>
    ''' <param name="IndexKey">The index key.</param>
    Sub SaveSearch(ByVal IndexKey As Integer)

        If bSaveSearchesToDB Then
            SaveSearchHistory()
        End If

        dictScreenControls.Clear()

        'Dim ISO As New clsIsolatedStorage

        Dim ScreenName = "frmQuickSearch"
        Dim SaveTypeCode$ = "QUICKSEARCH"
        Dim UID As String = CurrUserGuidID
        Dim ValName As String = ""
        Dim ValValue As String = ""
        Dim B As Boolean = True

        Dim txtSelDir As String = "??"
        Dim ckShowDetails As Boolean = False
        Dim ckCountOnly As Boolean = False
        Dim ckLimitToExisting As Boolean = False
        Dim ckBusiness As Boolean = False
        Dim rbToDefaultDir As Boolean = False
        Dim rbToOriginalDir As Boolean = False
        Dim rbToSelDir As Boolean = False
        Dim ckOverWrite As Boolean = False

        ISO.ZeroizeSaveFormData(IndexKey, ScreenName, SaveTypeCode, UID, ValName, ValValue)

        SaveTypeCode = "QUICKSEARCH"

        ValName = "txtSearch"
        ValValue = txtSearch.Text.Trim
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "txtSelDir"
        'ValValue = txtSelDir
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "cbLibrary"
        ValValue = cbLibrary.SelectedItem
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "nbrWeightMin"
        ValValue = nbrWeightMin.Text
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "rbAll"
        ValValue = rbAll.IsChecked.ToString
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "rbContent"
        ValValue = rbContent.IsChecked.ToString
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "rbEmails"
        ValValue = rbEmails.IsChecked.ToString
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        'ValName = "ckShowDetails"
        'ValValue = ckShowDetails.IsChecked.ToString
        'ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "ckLimitToLib"
        ValValue = ckLimitToLib.IsChecked.ToString
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        'ValName = "ckCountOnly"
        'ValValue = ckCountOnly.IsChecked.ToString
        'ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "ckMyContent"
        ValValue = ckMyContent.IsChecked.ToString
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "ckMasterOnly"
        ValValue = ckMasterOnly.IsChecked.ToString
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        'ValName = "ckLimitToExisting"
        'ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "ckWeights"
        ValValue = ckWeights.IsChecked.ToString
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        'ValName = "ckBusiness"
        'ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        'ValName = "rbToDefaultDir"
        'ValValue = rbToDefaultDir.IsChecked.ToString
        'ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        'ValName = "rbToOriginalDir"
        'ValValue = rbToOriginalDir.IsChecked.ToString
        'ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        'ValName = "rbToSelDir"
        'ValValue = rbToSelDir.IsChecked.ToString
        'ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        'ValName = "ckOverWrite"
        'ValValue = ckOverWrite.IsChecked.ToString
        'ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "lblMain"
        ValValue = lblMain.Content
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "ckFilters"
        ValValue = ckFilters.IsChecked.ToString
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "SBEmail"
        ValValue = SBEmail.Text
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "SBDoc"
        ValValue = SBDoc.Text
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ValName = "SB"
        ValValue = SB.Text
        ISO.SaveFormData(dictScreenControls, IndexKey, ScreenName, UID, ValName$, ValValue)

        ''ISO = Nothing

    End Sub

    ''' <summary>
    ''' Loads the state of the selected screen.
    ''' </summary>
    ''' <param name="IndexKey">The index key.</param>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function LoadSelectedScreenState(ByVal IndexKey As Integer) As Boolean

        Dim B As Boolean = True
        'Dim ISO As New clsIsolatedStorage

        Dim tgtValue As String = ""
        Dim ValName As String = ""
        Dim ValValue As String = ""
        Dim ScreenName = "frmQuickSearch"
        Dim SaveTypeCode As String = "QUICKSEARCH"
        Dim UID As String = CurrUserGuidID

        Dim txtSelDir As String = "??"
        Dim ckShowDetails As Boolean = False
        Dim ckCountOnly As Boolean = False
        Dim ckLimitToExisting As Boolean = False
        Dim ckBusiness As Boolean = False
        Dim rbToDefaultDir As Boolean = False
        Dim rbToOriginalDir As Boolean = False
        Dim rbToSelDir As Boolean = False
        Dim ckOverWrite As Boolean = False

        B = ISO.ReadFormData(dictScreenControls, IndexKey, ScreenName, UID)
        If Not B Then
            Return False
        End If

        For Each tKey As String In dictScreenControls.Keys
            ValValue = dictScreenControls.Item(tKey)
            Select Case tKey
                Case "ckFilters"
                    If ValValue.ToUpper.Equals("TRUE") Then
                        ckFilters.IsChecked = True
                    Else
                        ckFilters.IsChecked = False
                    End If
                Case "txtSearch"
                    txtSearch.Text = ValValue
                Case "txtSelDir"
                    txtSelDir = ValValue
                Case "cbLibrary"
                    cbLibrary.SelectedItem = ValValue
                Case "nbrWeightMin"
                    nbrWeightMin.Text = ValValue
                Case "rbAll"
                    If ValValue.ToUpper.Equals("TRUE") Then
                        rbAll.IsChecked = True
                    Else
                        rbAll.IsChecked = False
                    End If
                Case "rbDocs"
                    If ValValue.ToUpper.Equals("TRUE") Then
                        rbContent.IsChecked = True
                    Else
                        rbContent.IsChecked = False
                    End If
                Case "rbEmails"
                    If ValValue.ToUpper.Equals("TRUE") Then
                        rbEmails.IsChecked = True
                    Else
                        rbEmails.IsChecked = False
                    End If
                Case "ckShowDetails"
                    If ValValue.ToUpper.Equals("TRUE") Then
                        ckShowDetails = True
                    Else
                        ckShowDetails = False
                    End If
                Case "ckLimitToLib"
                    If ValValue.ToUpper.Equals("TRUE") Then
                        ckLimitToLib.IsChecked = True
                    Else
                        ckLimitToLib.IsChecked = False
                    End If
                Case "ckCountOnly"
                    If ValValue.ToUpper.Equals("TRUE") Then
                        ckCountOnly = True
                    Else
                        ckCountOnly = False
                    End If
                Case "ckMyContentOnly"
                    If ValValue.ToUpper.Equals("TRUE") Then
                        ckMyContent.IsChecked = True
                    Else
                        ckMyContent.IsChecked = False
                    End If
                Case "ckLimitToExisting"
                    If ValValue.ToUpper.Equals("TRUE") Then
                        ckLimitToExisting = True
                    Else
                        ckLimitToExisting = False
                    End If
                Case "ckWeighted"
                    If ValValue.ToUpper.Equals("TRUE") Then
                        ckWeights.IsChecked = True
                    Else
                        ckWeights.IsChecked = False
                    End If
                Case "ckBusiness"
                    If ValValue.ToUpper.Equals("TRUE") Then
                        ckBusiness = True
                    Else
                        ckBusiness = False
                    End If
                Case "rbToDefaultDir"
                    If ValValue.ToUpper.Equals("TRUE") Then
                        rbToDefaultDir = True
                    Else
                        rbToDefaultDir = False
                    End If
                Case "rbToOriginalDir"
                    If ValValue.ToUpper.Equals("TRUE") Then
                        rbToOriginalDir = True
                    Else
                        rbToOriginalDir = False
                    End If
                Case "rbToSelDir"
                    If ValValue.ToUpper.Equals("TRUE") Then
                        rbToSelDir = True
                    Else
                        rbToSelDir = False
                    End If

                Case "ckOverWrite"
                    If ValValue.ToUpper.Equals("TRUE") Then
                        ckOverWrite = True
                    Else
                        ckOverWrite = False
                    End If
            End Select
        Next

        For Each tKey As String In dictScreenControls.Keys
            ValValue = dictScreenControls.Item(tKey)
            Select Case tKey
                Case "ckFilters"
                    If ValValue.ToUpper.Equals("TRUE") Then
                        ckFilters.IsChecked = True
                    Else
                        ckFilters.IsChecked = False
                    End If
            End Select
        Next

        ''ISO = Nothing

        Return B

    End Function

    ''' <summary>
    ''' Sorts the email grid.
    ''' </summary>
    ''' <param name="ColName">Name of the col.</param>
    ''' <param name="SortType">Type of the sort.</param>
    Private Sub SortEmailGrid(ByVal ColName As String, ByVal SortType As String)

        If ColName.Trim.Length = 0 Then
            Return
        End If
        'Dim dataView As ICollectionView = System.Windows.Data.CollectionViewSource.GetDefaultView(dgEmails.ItemsSource)
        Dim dataView As ICollectionView = dgEmails.ItemsSource
        dataView.SortDescriptions.Clear()
        Dim sd As New SortDescription(ColName, SortType)
        dataView.SortDescriptions.Add(sd)
        dataView.Refresh()

    End Sub

    ''' <summary>
    ''' Sorts the content grid.
    ''' </summary>
    ''' <param name="ColName">Name of the col.</param>
    ''' <param name="SortType">Type of the sort.</param>
    Private Sub SortContentGrid(ByVal ColName As String, ByVal SortType As String)
        If ColName.Trim.Length = 0 Then
            Return
        End If
        Dim dataView As ICollectionView = dgContent.ItemsSource
        dataView.SortDescriptions.Clear()
        Dim sd As New SortDescription(ColName, SortType)
        dataView.SortDescriptions.Add(sd)
        dataView.Refresh()
    End Sub

    ''' <summary>
    ''' Gets the name of the server instance.
    ''' </summary>
    Sub getServerInstanceName()
        ''Dim proxy As New SVCSearch.Service1Client
        'AddHandler ProxySearch.getServerInstanceNameCompleted, AddressOf client_getServerInstanceName
        gServerInstanceName = ProxySearch.getServerInstanceName(gSecureID)
        lblDbInstance.Content = gServerInstanceName
    End Sub

    'Sub client_getServerInstanceName(ByVal sender As Object, ByVal e As SVCSearch.getServerInstanceNameCompletedEventArgs)
    '    If RC Then
    '        gServerInstanceName = e.Result
    '        lblDbInstance.Content = gServerInstanceName
    '    Else
    '        gServerInstanceName = "Unknown"
    '    End If
    '    'RemoveHandler ProxySearch.getServerInstanceNameCompleted, AddressOf client_getServerInstanceName
    'End Sub
    ''' <summary>
    ''' Gets the name of the server machine.
    ''' </summary>
    Sub getServerMachineName()
        ''Dim proxy As New SVCSearch.Service1Client
        'AddHandler ProxySearch.getServerMachineNameCompleted, AddressOf client_getServerMachineName
        gServerMachineName = ProxySearch.getServerMachineName(gSecureID)
        lblDbInstance.Content = gServerInstanceName + " / " + gServerMachineName
    End Sub

    'Sub client_getServerMachineName()
    '    If RC Then
    '        gServerMachineName = e.Result
    '        lblDbInstance.Content = gServerInstanceName + " / " + gServerMachineName
    '    Else
    '        gServerMachineName = "Unknown"
    '    End If
    '    'RemoveHandler ProxySearch.getServerMachineNameCompleted, AddressOf client_getServerMachineName
    'End Sub

    ''' <summary>
    ''' Handles the MouseEnter event of the dgEmails control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Input.MouseEventArgs"/> instance containing the event data.</param>
    Private Sub dgEmails_MouseEnter(ByVal sender As System.Object, ByVal e As System.Windows.Input.MouseEventArgs) Handles dgEmails.MouseEnter

        lblDbInstance.Content = gServerInstanceName + " / " + gServerMachineName
        SBEmailPage.Text = "Rows:1 thru " & dgEmails.Items.Count
        SBDocPage.Text = "Rows:1 thru " & dgContent.Items.Count

        SelectedGrid = "dgEmails"

    End Sub

    ''' <summary>
    ''' Gets the logged in user.
    ''' </summary>
    Sub getLoggedInUser()
        ''Dim proxy As New SVCSearch.Service1Client
        'AddHandler ProxySearch.getLoggedInUserCompleted, AddressOf client_getLoggedInUser
        Dim SS As String = ProxySearch.getLoggedInUser(gSecureID)
        client_getLoggedInUser(SS)
    End Sub

    ''' <summary>
    ''' Clients the get logged in user.
    ''' </summary>
    ''' <param name="SS">The ss.</param>
    Sub client_getLoggedInUser(SS As String)
        If SS.Length > 0 Then
            CurrLoginID = SS
            lblDbInstance.Content = CurrLoginID + " / " + gServerMachineName

            Dim B As Boolean = ISO.isClcInstalled()
            If B Then
                lblClcState.Visibility = Windows.Visibility.Collapsed
            Else
                'lblClcState.Visibility = Windows.Visibility.Visible
            End If
        Else
            CurrLoginID = "Unknown"
        End If
        'RemoveHandler ProxySearch.getLoggedInUserCompleted, AddressOf client_getLoggedInUser
    End Sub

    ''' <summary>
    ''' Gets the name of the attached machine.
    ''' </summary>
    Sub getAttachedMachineName()
        If _SecureID > 0 Then
            'AddHandler ProxySearch.getAttachedMachineNameCompleted, AddressOf client_getAttachedMachineName
            Dim SS As String = ProxySearch.getAttachedMachineName(_SecureID)
            client_getAttachedMachineName(SS)
        End If
    End Sub

    ''' <summary>
    ''' Clients the name of the get attached machine.
    ''' </summary>
    ''' <param name="SS">The ss.</param>
    Sub client_getAttachedMachineName(SS As String)
        If SS.Length > 0 Then
            gServerMachineName = SS
            lblDbInstance.Content = gServerInstanceName + " / " + gServerMachineName
        Else
            gServerMachineName = "Unknown"
        End If
        gServerMachineName = "Unknown"
        'RemoveHandler ProxySearch.getAttachedMachineNameCompleted, AddressOf client_getAttachedMachineName
    End Sub

    ''' <summary>
    ''' Handles the PageIndexChanged event of the dpDocuments control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
    Private Sub dpDocuments_PageIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        DocLowerPageNbr += PageRowLimit
        DocUpperPageNbr += PageRowLimit
        btnSubmit_Click(Nothing, Nothing)
    End Sub

    ''' <summary>
    ''' Handles the PageIndexChanged event of the dpEmails control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
    Private Sub dpEmails_PageIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        EmailLowerPageNbr += PageRowLimit
        EmailUpperPageNbr += PageRowLimit
        btnSubmit_Click(Nothing, Nothing)
    End Sub

    ''' <summary>
    ''' Clients the get email attachments.
    ''' </summary>
    ''' <param name="ObjListOfRows">The object list of rows.</param>
    ''' <param name="DownLoadFiles">if set to <c>true</c> [down load files].</param>
    Sub client_GetEmailAttachments(ObjListOfRows As String, Optional DownLoadFiles As Boolean = False)

        Dim jss = New JavaScriptSerializer()
        Dim ObjContent = jss.Deserialize(Of DS_EmailAttachments())(ObjListOfRows)

        'Dim DSMGT As clsDatasetMgt = New clsDatasetMgt()
        Dim DS As New DataSet
        DS = DSMGT.ConvertObjToEmailAttachmentDS(ObjContent)

        Dim ListOfRows As New System.Collections.ObjectModel.ObservableCollection(Of DS_EmailAttachments)
        For Each O As Object In ObjContent
            ListOfRows.Add(O)
        Next

        Dim bFileExists As Boolean = False
        Dim RowID As Integer = -1
        Dim eguid As String = ""
        Dim AttachmentName As String = ""

        dgAttachments.ItemsSource = Nothing
        dgAttachments.Items.Refresh()

        dgAttachments.ItemsSource = New DataView(DS.Tables(0))
        dgAttachments.Items.Refresh()

        If DownLoadFiles.Equals(False) Then
            dgAttachments.ItemsSource = New DataView(DS.Tables(0))
            dgAttachments.Visibility = Visibility.Visible
            dgAttachments.Items.Refresh()
            Return
        End If

        'wdmxx
        For Each item As DS_EmailAttachments In ListOfRows
            RowID = item.RowID
            eguid = item.EmailGuid
            AttachmentName = item.AttachmentName
            Try
                Dim filedata As Byte() = proxy2.GetAttachmentFromDB(gSecureID, eguid)
                Dim tgtdir As String = gDownloadDIR
                Dim FQN As String = gDownloadDIR + AttachmentName

                Dim oFileStream As System.IO.FileStream
                oFileStream = New System.IO.FileStream(FQN, System.IO.FileMode.Create)
                oFileStream.Write(filedata, 0, filedata.Length)
                oFileStream.Close()

                bFileExists = True
            Catch ex As Exception

            End Try
        Next

        If bFileExists Then
            Process.Start(gDownloadDIR)
        End If

    End Sub

    'Private Sub nbrDocRows_ValueChanged(ByVal sender As System.Object, ByVal e As C1.Silverlight.PropertyChangedEventArgs(Of System.Double)) Handles nbrDocRows.ValueChanged
    '    PageRowLimit = CInt(nbrDocRows.text)
    '    DocLowerPageNbr = 0
    '    DocUpperPageNbr = PageRowLimit
    'End Sub

    ''' <summary>
    ''' Handles the Click event of the btnEmailPagePack control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnEmailPagePack_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnEmailPagePack.Click
        If bQuickSearchRecall2 Then
            Return
        End If
        COMMON.SaveClick(1030, gCurrUserGuidID)
        CurrentEmailPage -= 1
        If CurrentEmailPage < 0 Then
            CurrentEmailPage = 1
            SBEmailPage.Text = "Rows:1 thru " & dgEmails.Items.Count
            SBDocPage.Text = "Rows:1 thru " & dgContent.Items.Count
        End If
        EmailLowerPageNbr -= CInt(nbrDocRows.Text)
        EmailUpperPageNbr -= CInt(nbrDocRows.Text)
        If EmailLowerPageNbr <= 0 Then
            SBEmailPage.Text = "Rows:1 thru " & dgEmails.Items.Count
            SBDocPage.Text = "Rows:1 thru " & dgContent.Items.Count
            EmailLowerPageNbr = 0
        End If
        If EmailUpperPageNbr < PageRowLimit Then
            EmailUpperPageNbr = PageRowLimit
        End If
        btnSubmit_Click(Nothing, Nothing)
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnEmailPageForward control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnEmailPageForward_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnEmailPageForward.Click
        If bQuickSearchRecall2 Then
            Return
        End If
        COMMON.SaveClick(1031, gCurrUserGuidID)
        CurrentEmailPage += 1
        EmailLowerPageNbr += CInt(nbrDocRows.Text)
        EmailUpperPageNbr += CInt(nbrDocRows.Text)
        btnSubmit_Click(Nothing, Nothing)
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnDocPagePack control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnDocPagePack_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnDocPagePack.Click
        If bQuickSearchRecall2 Then
            Return
        End If
        COMMON.SaveClick(1020, gCurrUserGuidID)
        CurrentDocPage -= 1
        If CurrentDocPage <= 0 Then
            CurrentDocPage = 1
            SBEmailPage.Text = "Rows:1 thru " & dgEmails.Items.Count
            SBDocPage.Text = "Rows:1 thru " & dgContent.Items.Count
        End If
        DocLowerPageNbr -= CInt(nbrDocRows.Text)
        DocUpperPageNbr -= CInt(nbrDocRows.Text)
        If DocLowerPageNbr < 0 Then
            SBEmailPage.Text = "Rows:1 thru " & dgEmails.Items.Count
            SBDocPage.Text = "Rows:1 thru " & dgContent.Items.Count
            DocLowerPageNbr = 0
        End If
        If DocUpperPageNbr < PageRowLimit Then
            SBEmailPage.Text = "Rows:1 thru " & dgEmails.Items.Count
            SBDocPage.Text = "Rows:1 thru " & dgContent.Items.Count
            DocUpperPageNbr = PageRowLimit
        End If
        btnSubmit_Click(Nothing, Nothing)
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnDocPageForward control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnDocPageForward_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnDocPageForward.Click
        If bQuickSearchRecall2 Then
            Return
        End If
        COMMON.SaveClick(1021, gCurrUserGuidID)
        CurrentDocPage += 1
        DocLowerPageNbr += CInt(nbrDocRows.Text)
        DocUpperPageNbr += CInt(nbrDocRows.Text)
        btnSubmit_Click(Nothing, Nothing)
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the SBEmailPage control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub SBEmailPage_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles SBEmailPage.TextChanged

    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the SBDocPage control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub SBDocPage_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs)

    End Sub

    ''' <summary>
    ''' Handles the MouseLeave event of the dgContent control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Input.MouseEventArgs"/> instance containing the event data.</param>
    Private Sub dgContent_MouseLeave(ByVal sender As System.Object, ByVal e As System.Windows.Input.MouseEventArgs)

    End Sub

    ''' <summary>
    ''' Handles the LoadedRows event of the dgEmails control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
    Private Sub dgEmails_LoadedRows(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles dgEmails.Loaded
        If gDebug Then
            Console.WriteLine("-------------------- dgEmails_LoadedRows --------------------------------------")
            For Each col As DataGridColumn In dgEmails.Columns
                Dim tgt As String = col.Header.ToString
                Console.WriteLine(", " + tgt)
            Next
            If gDebug Then Console.WriteLine("----------------------------------------------------------")
        End If

        If bWaitToApplyAttachmentWeight = False Then
            If ckWeights.IsChecked Then
                ApplyAttachmentWeights()
            End If
        End If
        'GetEmailGridLayout(dictGridParmsEmail, dgEmails)
        getSavedEmailGridColumnsDisplayOrder()

    End Sub

    ''' <summary>
    ''' Handles the GotFocus event of the dgEmails control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub dgEmails_GotFocus(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles dgEmails.GotFocus
        If bQuickSearchRecall2 Then
            Return
        End If
        If bWaitToApplyAttachmentWeight = False Then
            If ckWeights.IsChecked Then
                ApplyAttachmentWeights()
            End If
        End If
        ckClcActive()
    End Sub

    ''' <summary>
    ''' Handles the Loaded event of the Page control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub Page_Loaded(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles MyBase.Loaded
        Console.WriteLine("Trace:00")
        If DoNotDoThis Then
            Return
        End If

    End Sub

    ''' <summary>
    ''' Calls the preview.
    ''' </summary>
    Sub callPreview()

        RepoTableName = RepoTableName.ToUpper
        Dim bPreview As Boolean = True
        Dim bRestore As Boolean = True

        Dim RetMsg As String = ""
        Dim MachineID As String = ""
        Dim FQN As String = "NA"
        Dim iCnt As Integer = 0

        If RepoTableName.ToUpper.Equals("EMAILATTACHMENT") Then
            iCnt = dgAttachments.SelectedItems.Count
        ElseIf RepoTableName.ToUpper.Equals("EMAIL") Then
            iCnt = dgEmails.SelectedItems.Count
        ElseIf RepoTableName.ToUpper.Equals("DATASOURCE") Then
            iCnt = dgContent.SelectedItems.Count
        Else
            SB.Text = "WARNING: No restore table selected 100."
            Return
        End If

        If iCnt = 1 Then
            If RepoTableName.Equals("DATASOURCE") Then
                Dim IX As Integer = dgContent.SelectedIndex
                'CurrentGuid = grid.GetCellValueAsString(dgContent, IX, "SourceGuid").ToString
                CurrentGuid = fetchCellValue(dgContent, "SourceGuid")
                'CurrentGuid = dgContent(IX, "SourceGuid")
                'FQN = dgContent(IX, "FQN")
                FQN = grid.GetCellValueAsString(dgContent, IX, "FQN ").ToString

                If UseISO Then
                    ISO.SaveFilePreviewGuid(CurrUserGuidID, RepoTableName.ToUpper, CurrentGuid, FQN)
                Else
                    'AddHandler ProxySearch.scheduleFileDownLoadCompleted, AddressOf client_scheduleFileDownLoad
                    'ProxySearch.scheduleFileDownLoadAsync()
                    'ProxySearch.saveRestoreFileAsync(_SecureID, "DataSource", CurrentGuid, bPreview, bRestore, _UserGuid, _MachineID, RC, RetMsg)
                    Dim BB As Boolean = ProxySearch.scheduleFileDownLoad(_SecureID, CurrentGuid, _UserID, "CONTENT", 1, 0)
                    client_scheduleFileDownLoad(BB)
                End If
            ElseIf RepoTableName.Equals("EMAIL") Then
                Dim IX As Integer = dgEmails.SelectedIndex
                'CurrentGuid = dgEmails(IX, "EmailGuid")
                'FQN = dgEmails(IX, "SourceTypeCode")
                'CurrentGuid = grid.GetCellValueAsString(dgContent, IX, "EmailGuid").ToString
                CurrentGuid = fetchCellValue(dgContent, "EmailGuid")
                'FQN = grid.GetCellValueAsString(dgContent, IX, "SourceTypeCode").ToString
                FQN = fetchCellValue(dgContent, "SourceTypeCode")

                If UseISO Then
                    ISO.SaveFilePreviewGuid(CurrUserGuidID, RepoTableName.ToUpper, CurrentGuid, FQN)
                Else
                    'ProxySearch.saveRestoreFileAsync(_SecureID, "Email", CurrentGuid, bPreview, bRestore, _UserGuid, _MachineID, RC, RetMsg)
                    Dim BB As Boolean = ProxySearch.scheduleFileDownLoad(_SecureID, CurrentGuid, _UserID, "EMAIL", 1, 0)
                    client_scheduleFileDownLoad(BB)
                End If
            ElseIf RepoTableName.Equals("EMAILATTACHMENT") Then
                If SelectedGrid = "dgEmails" Then
                    If UseISO Then
                        ISO.SaveFilePreviewGuid(CurrUserGuidID, RepoTableName.ToUpper, CurrAttachmentRowID, FQN)
                    Else
                        CurrentGuid = fetchCellValue(dgAttachments, "EmailGuid")
                        Dim Obj As Object = ProxySearch.GetEmailAttachments(gSecureID, CurrentGuid)
                        client_GetEmailAttachments(Obj, True)
                        'Dim BB As Boolean = ProxySearch.scheduleFileDownLoad(_SecureID, CurrAttachmentRowID, _UserID, "EMAILATTACHMENT", 1, 0)
                        'client_scheduleFileDownLoad(BB)
                    End If
                End If
                If SelectedGrid = "dgContent" Then
                    MessageBox.Show("Fix This")
                End If
            End If

        End If

    End Sub

    ''' <summary>
    ''' Clients the get files in zip detail.
    ''' </summary>
    ''' <param name="strListOfRows">The string list of rows.</param>
    Sub client_GetFilesInZipDetail(strListOfRows As String)

        If strListOfRows Is Nothing Then
            Return
        End If

        Dim ListOfRows As New System.Collections.ObjectModel.ObservableCollection(Of DS_ZipFiles)

        Dim jss = New JavaScriptSerializer()
        Dim ObjContent = jss.Deserialize(Of DS_ZipFiles())(strListOfRows)

        If ListOfRows.Count = 0 Then
            GetMetaData(CurrentGuid)
        Else
            dgAttachments.ItemsSource = ListOfRows
            dgAttachments.Visibility = Visibility.Visible
        End If
    End Sub

    ''' <summary>
    ''' Clients the schedule file down load.
    ''' </summary>
    ''' <param name="BB">if set to <c>true</c> [bb].</param>
    Sub client_scheduleFileDownLoad(BB As Boolean)
        If BB Then
            If BB Then
                SB.Text = "Preview Record inserted."
            Else
                MessageBox.Show("ERROR: failed to set content for retrieval.")
            End If
        Else
            MessageBox.Show("ERROR: scheduleFileDown 100a - ")
        End If

        ''RemoveHandler ProxySearch.saveRestoreFileCompleted, AddressOf client_saveRestoreFile

    End Sub

    ''' <summary>
    ''' Clients the save restore file.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    Sub client_saveRestoreFile(RC As Boolean)
        If RC Then
        Else
            MessageBox.Show("Failed to Restore.")
            SB.Text = "Failed to Restore."
        End If

        ''RemoveHandler ProxySearch.saveRestoreFileCompleted, AddressOf client_saveRestoreFile

    End Sub

    ''' <summary>
    ''' Saves the screen dictionary.
    ''' </summary>
    ''' <param name="ControlName">Name of the control.</param>
    ''' <param name="ControlValue">The control value.</param>
    Sub SaveScreenDictionary(ByVal ControlName As String, ByVal ControlValue As String)
        If dictScreenControls.ContainsKey(ControlName) Then
            dictScreenControls.Item(ControlName) = ControlValue
        Else
            dictScreenControls.Add(ControlName, ControlValue)
        End If
    End Sub

    ''' <summary>
    ''' Reorders the email grid cols.
    ''' </summary>
    ''' <param name="ColName">Name of the col.</param>
    ''' <param name="ColDisplayOrder">The col display order.</param>
    Sub ReorderEmailGridCols(ByVal ColName As String, ByVal ColDisplayOrder As Integer)

        Dim col As DataGridColumn = dgEmails.Columns(ColName)
        dgEmails.Columns.Remove(col)
        dgEmails.Columns.Insert(ColDisplayOrder, col)

    End Sub

    ''' <summary>
    ''' Saves the grid column order.
    ''' </summary>
    ''' <param name="DG">The dg.</param>
    ''' <param name="DICT">The dictionary.</param>
    Sub SaveGridColumnOrder(ByVal DG As DataGrid, ByRef DICT As Dictionary(Of Integer, String))
        GM.SaveGridState(CurrUserGuidID, Me.Title, DG, DICT)
    End Sub

    ''' <summary>
    ''' All items stored in dictScreenControls will be added to the database basd on the assigned SearchID
    ''' </summary>
    Sub SaveSearchHistory()
        Dim SearchID As Integer = CurrentSearchIdHigh
        SaveSearchParmParms(SearchID)
        ProxySearch.saveSearchState(gSecureID, SearchID, CurrUserGuidID, Me.Title, dictScreenControls, returnMsg, RC, HiveConnectionName, HiveActive, RepoSvrName)
        client_saveSearchState(RC, returnMsg)
    End Sub

    ''' <summary>
    ''' Clients the state of the save search.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="returnMsg">The return MSG.</param>
    Sub client_saveSearchState(RC As Boolean, returnMsg As String)
        SB.Text = returnMsg
    End Sub

    ''' <summary>
    ''' Gets the search history.
    ''' </summary>
    ''' <param name="SearchID">The search identifier.</param>
    Sub GetSearchHistory(ByVal SearchID As Integer)

        Dim SaveTypeCode As String = ""
        Dim B As Boolean = False
        B = LoadSelectedScreenState(SearchID)

        If B Then
            SB.Text = "Search History found for ID# " + SearchID.ToString + "."
            Return
        Else
            SB.Text = "End of search history."
        End If

        If bSaveSearchesToDB Then
            PB.IsIndeterminate = True
            ''Dim proxy As New SVCSearch.Service1Client
            'AddHandler ProxySearch.getSearchStateCompleted, AddressOf

            'WDMXX
            Dim ObjListOfRows As Object = ProxySearch.getSearchState(gSecureID, SearchID, CurrUserGuidID, Title, dictScreenControls, returnMsg, RC, HiveConnectionName, HiveActive, RepoSvrName)
            client_getSearchState(ObjListOfRows, returnMsg)
        End If

    End Sub

    ''' <summary>
    ''' Clients the state of the get search.
    ''' </summary>
    ''' <param name="ObjListOfRows">The object list of rows.</param>
    ''' <param name="returnMsg">The return MSG.</param>
    Sub client_getSearchState(ObjListOfRows As Object, returnMsg As String)

        Dim ListOfRows As New System.Collections.ObjectModel.ObservableCollection(Of SVCSearch.DS_USERSEARCHSTATE)
        ListOfRows = ObjListOfRows

        If ListOfRows.Count = 0 Then
            PB.IsIndeterminate = False
            SB.Text = "No DB search history found."
            Return
        End If
        If ListOfRows.Count > 0 Then
            SearchHistory = ListOfRows.ToList
            Dim RowsReturned As Integer = SearchHistory.Count
            Dim O As Object = SearchHistory.Item(0).ParmName
            SB.Text = returnMsg
        Else
            SB.Text = returnMsg
        End If
        PB.IsIndeterminate = False
    End Sub

    ''' <summary>
    ''' Reorders the grid.
    ''' </summary>
    ''' <param name="DG">The dg.</param>
    ''' <param name="DICT">The dictionary.</param>
    Sub ReorderGrid(ByVal DG As DataGrid, ByVal DICT As Dictionary(Of Integer, String))

        For Each iKey As Integer In DICT.Keys
            Dim ColName As String = DICT.Item(iKey)
            Dim col As DataGridColumn = dgEmails.Columns(ColName)
            dgEmails.Columns.Remove(col)
            dgEmails.Columns.Insert(iKey, col)
        Next

    End Sub

    ''' <summary>
    ''' Saves the grid layout to database.
    ''' </summary>
    ''' <param name="DG">The dg.</param>
    Sub SaveGridLayoutToDB(ByVal DG As DataGrid)

        Dim UserID As String = CurrUserGuidID
        Dim ScreenName As String = Me.Title
        Dim GridName As String = DG.Name
        Dim ColName As String = ""
        Dim ColOrder As Integer = -1
        Dim ColWidth As Integer = 0
        Dim ColVisible As Boolean = False
        Dim ColReadOnly As Boolean = False
        Dim ColSortOrder As Integer = -1
        Dim ColSortAsc As Boolean = False
        Dim HiveConnectionName As String = "-*-"
        Dim HiveActive As Boolean = False
        Dim RepoSvrName As String = "-*-"
        Dim RowCreationDate As Date = Now
        Dim RowLastModDate As Date = Now
        Dim RowNbr As Integer = 0

        Dim rMsg As String = ""
        For I As Integer = 0 To DG.Columns.Count - 1
            ColName = DG.Columns(I).Header
            ColOrder = I
            If DG.Columns(I).Width.ToString.Equals("Auto") Then
                ColWidth = -1
            Else
                ColWidth = CInt(DG.Columns(I).Width.ToString)
            End If

            ColVisible = DG.Columns(I).Visibility
            ColReadOnly = DG.Columns(I).IsReadOnly

            ProxySearch.saveGridLayout(gSecureID, UserID, ScreenName, GridName, ColName, ColOrder, ColWidth, ColVisible, ColReadOnly, ColSortOrder, ColSortAsc, HiveConnectionName, HiveActive, RepoSvrName, RowCreationDate, RowLastModDate, RowNbr, RC, rMsg)
            client_saveGridLayout(RC, rMsg)
        Next
    End Sub

    ''' <summary>
    ''' Clients the save grid layout.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="rMsg">The r MSG.</param>
    Sub client_saveGridLayout(RC As Boolean, rMsg As String)

        If RC Then
            SB.Text = "System Grid Parms saved."
        Else
            SB.Text = "System Grid Parms failed to save / DB Failed to attach - " + rMsg
        End If

    End Sub

    ''' <summary>
    ''' Gets the email grid layout.
    ''' </summary>
    ''' <param name="DICT">The dictionary.</param>
    ''' <param name="DG">The dg.</param>
    Sub GetEmailGridLayout(ByRef DICT As Dictionary(Of String, String), ByRef DG As DataGrid)

        Dim HiveConnectionName As String = ""
        Dim HiveActive As Boolean = False
        Dim RepoSvrName As String = ""
        Dim rMsg As String = ""
        Dim RC As Boolean = False
        Dim GridName As String = "dgEmail"

        ''Dim proxy As New SVCSearch.Service1Client
        'AddHandler ProxySearch.getGridLayoutCompleted, AddressOf client_getEmailGridLayout
        Dim ObjListOfRows As Object = ProxySearch.getGridLayout(gSecureID, CurrUserGuidID, Me.Title, GridName, DICT, rMsg, RC, HiveConnectionName, HiveActive, RepoSvrName)

        client_getEmailGridLayout(ObjListOfRows, rMsg)

    End Sub

    ''' <summary>
    ''' Clients the get email grid layout.
    ''' </summary>
    ''' <param name="ObjListOfRows">The object list of rows.</param>
    ''' <param name="rMsg">The r MSG.</param>
    Sub client_getEmailGridLayout(ObjListOfRows As Object, rMsg As String)

        Dim Obj As SVCSearch.DS_clsUSERGRIDSTATE = New SVCSearch.DS_clsUSERGRIDSTATE()

        dictEmailGridColDisplayOrder.Clear()
        Dim I As Integer = 0
        For Each Obj In ObjListOfRows

            Dim gCols As New GridCols
            'Dim cCols As New ContentGridCols

            Dim ScreenName As String = Obj.ScreenName
            Dim GridName As String = Obj.GridName
            Dim ColName As String = Obj.ColName
            Dim ColOrder As Integer = Obj.ColOrder
            If dictEmailGridColDisplayOrder.ContainsKey(ColOrder) Then
                dictEmailGridColDisplayOrder.Item(ColOrder) = ColName
            Else
                dictEmailGridColDisplayOrder.Add(ColOrder, ColName)
            End If
            Dim ColReadOnly As Boolean = Obj.ColReadOnly
            Dim ColVisible As Boolean = Obj.ColVisible
            Dim W As Integer = Obj.ColWidth

            gCols.GridName = GridName
            gCols.Colname = ColName
            gCols.ColOrd = ColOrder
            gCols.Visible = ColVisible
            gCols.bReadOnly = ColReadOnly
            gCols.Width = W

            Dim col As DataGridColumn = dgEmails.Columns(ColName)
            dgEmails.Columns.Remove(col)
            dgEmails.Columns.Insert(I, col)
            If W < 0 Then
                col.Width = DataGridLength.Auto
            Else
                Dim O As Object = W
                col.Width = CType(O, DataGridLength)
            End If
            col.Visibility = ColVisible
            col.IsReadOnly = ColReadOnly
            I += 1
        Next
        SB.Text = "System Grid Parms Loaded: " & gSystemParms.Count & " and DB Connection good."
    End Sub

    ''' <summary>
    ''' Gets the content grid layout.
    ''' </summary>
    ''' <param name="DICT">The dictionary.</param>
    ''' <param name="DG">The dg.</param>
    Sub GetContentGridLayout(ByRef DICT As Dictionary(Of String, String), ByRef DG As DataGrid)
        Console.WriteLine("Trace:101")
        Dim HiveConnectionName As String = ""
        Dim HiveActive As Boolean = False
        Dim RepoSvrName As String = ""
        Dim rMsg As String = ""
        Dim RC As Boolean = False
        Dim GridName As String = "dgContent"

        Console.WriteLine("Trace:102")
        Dim ObjListOfRows As Object = ProxySearch.getGridLayout(gSecureID, CurrUserGuidID, Me.Title, GridName, DICT, rMsg, RC, HiveConnectionName, HiveActive, RepoSvrName)
        Console.WriteLine("Trace:103")
        client_getContentGridLayout(ObjListOfRows)
    End Sub

    ''' <summary>
    ''' Clients the get content grid layout.
    ''' </summary>
    ''' <param name="ObjListOfRows">The object list of rows.</param>
    Sub client_getContentGridLayout(ObjListOfRows As Object)
        Console.WriteLine("Trace:104")
        Dim RowOfData As SVCSearch.DS_clsUSERGRIDSTATE = New SVCSearch.DS_clsUSERGRIDSTATE()

        dictEmailGridColDisplayOrder.Clear()
        Dim I As Integer = 0
        For Each RowOfData In ObjListOfRows

            Dim gCols As New GridCols

            Dim ScreenName As String = RowOfData.ScreenName
            Dim GridName As String = RowOfData.GridName
            Dim ColName As String = RowOfData.ColName
            Dim ColOrder As Integer = RowOfData.ColOrder
            If dictEmailGridColDisplayOrder.ContainsKey(ColOrder) Then
                dictEmailGridColDisplayOrder.Item(ColOrder) = ColName
            Else
                dictEmailGridColDisplayOrder.Add(ColOrder, ColName)
            End If
            Dim ColReadOnly As Boolean = RowOfData.ColReadOnly
            Dim ColVisible As Boolean = RowOfData.ColVisible
            Dim W As Integer = RowOfData.ColWidth

            gCols.GridName = GridName
            gCols.Colname = ColName
            gCols.ColOrd = ColOrder
            gCols.Visible = ColVisible
            gCols.bReadOnly = ColReadOnly
            gCols.Width = W

            Dim col As DataGridColumn = dgContent.Columns(ColName)
            dgContent.Columns.Remove(col)
            dgContent.Columns.Insert(I, col)
            If W < 0 Then
                col.Width = DataGridLength.Auto
            Else
                Dim O As Object = W
                col.Width = CType(O, DataGridLength)
            End If
            col.Visibility = ColVisible
            col.IsReadOnly = ColReadOnly
            I += 1

        Next
        SB.Text = "System Grid Parms Loaded: " & gSystemParms.Count & " and DB Connection good."
    End Sub

    ''' <summary>
    ''' Populates the library ComboBox.
    ''' </summary>
    Sub populateLibraryComboBox()

        System.Threading.Thread.Sleep(AffinityDelay)
        'AddHandler ProxySearch.PopulateGroupUserLibComboCompleted, AddressOf client_PopulateGroupUserLibCombo
        Dim AvailLibs As String = ""
        ProxySearch.PopulateGroupUserLibCombo(gSecureID, CurrUserGuidID, AvailLibs)
        client_PopulateGroupUserLibCombo(AvailLibs)
    End Sub

    ''' <summary>
    ''' Clients the populate group user library combo.
    ''' </summary>
    ''' <param name="AvailLibs">The avail libs.</param>
    Sub client_PopulateGroupUserLibCombo(AvailLibs As String)

        Dim Libraries() As String = AvailLibs.Split("|")

        If Libraries.Count > 0 Then
            cbLibrary.Items.Clear()
            For Each S As String In Libraries
                S = S.Trim
                If S.Length > 0 Then
                    cbLibrary.Items.Add(S)
                End If
            Next
        Else
            'MessageBox.Show("Failed to Load user Libraries." + vbCrLf + e.Error.Message)
            SB.Text = "Failed to Load user Libraries."
        End If

        'RemoveHandler ProxySearch.PopulateGroupUserLibComboCompleted, AddressOf client_PopulateGroupUserLibCombo

    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnLibrary control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnLibrary_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnLibrary.Click
        If bQuickSearchRecall2 Then
            Return
        End If
        If LibraryOwnerGuid.Trim.Length = 0 Then
            MessageBox.Show("The LIBRARY owner cannot be established, please reselect the library again. Returning.")
            Return
        End If
        If CurrentlySelectedGrid.Equals("EMAIL") Then
            AddLibraryItems(dgEmails, CurrUserGuidID, LibraryOwnerGuid)
        Else
            AddLibraryItems(dgContent, CurrUserGuidID, LibraryOwnerGuid)
        End If
    End Sub

    ''' <summary>
    ''' Adds the library items.
    ''' </summary>
    ''' <param name="TDG">The TDG.</param>
    ''' <param name="AddedByUserGuidId">The added by user unique identifier identifier.</param>
    ''' <param name="strLibraryOwnerGuid">The string library owner unique identifier.</param>
    Sub AddLibraryItems(ByVal TDG As DataGrid, ByVal AddedByUserGuidId As String, ByVal strLibraryOwnerGuid As String)

        COMMON.SaveClick(1002, gCurrUserGuidID)

        Dim I As Integer = 0

        I = TDG.SelectedItems.Count

        'For Each O As Object In TDG.SelectedItems
        '    I += 1
        'Next

        If I = 0 Then
            MessageBox.Show("You have selected NO items to add to the library, " + vbCrLf + "you must select at least one item.")
            Return
        End If

        Dim SelectedLib As String = cbLibrary.SelectedItem
        If SelectedLib.Length = 0 Then
            MessageBox.Show("You must first select a library, returning...")
            Return
        End If

        Dim msg$ = "This will add " + I.ToString + " items to library, '" + SelectedLib$ + "', are you sure?"
        Dim result As MessageBoxResult = MessageBox.Show(msg, "Add to Library", MessageBoxButton.OKCancel)
        If result = MessageBoxResult.OK Then
        Else
            SB.Text = "Add to library cancelled."
            Return
        End If

        Dim iAdded As Integer = 0
        Dim iSkipped As Integer = 0
        Dim UserGuidID As String = ""

        'Try
        '    'RemoveHandler ProxySearch.AddLibraryItemsCompleted, AddressOf client_AddLibraryItems
        'Catch ex As Exception
        '    Console.WriteLine("XXX-1245")
        'End Try

        iTotalToProcess = 0

        'AddHandler ProxySearch.AddLibraryItemsCompleted, AddressOf client_AddLibraryItems

        Dim iSelectedCnt As Integer = TDG.SelectedItems.Count
        Try
            For Each item As DataRowView In TDG.SelectedItems
                iTotalToProcess += 1
                Dim SourceGuid As String = ""
                Dim cell As DataGridCell = Nothing
                Dim idx As Integer = TDG.SelectedIndex

                If CurrentlySelectedGrid.Equals("EMAIL") Then
                    SourceGuid = item("SourceGuid")
                Else
                    SourceGuid = item("SourceGuid")
                End If

                Dim Subject As String = ""
                If CurrentlySelectedGrid.Equals("EMAIL") Then
                    Subject = item("ShortSubj")
                Else
                    Subject = item("SourceName")
                End If

                If CurrentlySelectedGrid.Equals("EMAIL") Then
                    UserGuidID = item("UserID")
                Else
                    UserGuidID = item("DataSourceOwnerUserID")
                End If

                Subject = Mid(Subject, 1, 80).Trim
                Dim ContentExt As String = ""
                Try
                    If CurrentlySelectedGrid.Equals("EMAIL") Then
                        ContentExt = item("OriginalFileType")
                    Else
                        ContentExt = item("SourceTypeCode")
                    End If
                Catch ex As Exception

                End Try

                Dim NewGuid As String = System.Guid.NewGuid.ToString()
                Dim rMsg As String = ""

                ProxySearch.AddLibraryItems(_SecureID, SourceGuid, Subject, ContentExt, NewGuid, UserGuidID, strLibraryOwnerGuid, SelectedLib, AddedByUserGuidId, RC, rMsg)
                client_AddLibraryItems(RC, rMsg)
            Next
        Catch ex As Exception
            MessageBox.Show("ERROR: MainPage/AddLibraryItem: " + ex.Message)
        End Try
        SB.Text = iAdded.ToString + " items added, " + iSkipped.ToString + " items skipped."
        MessageBox.Show("Total Items added to library: " + iTotalToProcess.ToString)
    End Sub

    ''' <summary>
    ''' Clients the add library items.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="rMsg">The r MSG.</param>
    Sub client_AddLibraryItems(RC As Boolean, rMsg As String)
        If RC Then
            If Not RC Then
                SB.Text = "Failed to Load library item: " + rMsg
            Else
                SB.Text = iTotalToProcess.ToString + " items added to library " + cbLibrary.SelectedItem + "."
            End If
        Else
            SB.Text = "Failed to Load library item: " + rMsg
            MessageBox.Show("Failed to Load library item: " + rMsg)
        End If

    End Sub

    ''' <summary>
    ''' Clients the name of the get library owner by.
    ''' </summary>
    ''' <param name="S">The s.</param>
    Sub client_GetLibOwnerByName(S As String)
        If S.Length > 0 Then
            LibraryOwnerGuid = S
        Else
            LibraryOwnerGuid = ""
            SB.Text = "Failed to Load library owner GUID."
        End If
        'RemoveHandler ProxySearch.GetLibOwnerByNameCompleted, AddressOf client_GetLibOwnerByName
    End Sub

    ''' <summary>
    ''' Handles the KeyDown event of the txtSearch control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Input.KeyEventArgs"/> instance containing the event data.</param>
    Private Sub txtSearch_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Input.KeyEventArgs)
        If e.Key = Key.Enter Then
            btnSubmit_Click(Nothing, Nothing)
        End If
    End Sub

    ''' <summary>
    ''' Handles the SelectionChanged event of the dgContent control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub dgContent_SelectionChanged(sender As Object, e As SelectionChangedEventArgs) Handles dgContent.SelectionChanged

        CurrentlySelectedGrid = "CONTENT"

        Dim q As Integer = getColIdx(dgContent, "SourceGuid")
        Dim sguid As String = fetchCellValue(dgContent, "SourceGuid")

        Dim DictVal As Dictionary(Of String, String) = LoadCellValue(dgContent)
        sguid = DictVal("SourceGuid")

        txtDescription.Text = fetchCellValue(dgContent, "Description")
        Dim iCnt As Integer = dgContent.SelectedItems.Count
        If iCnt > 0 Then
            btnOpenRestoreScreen.Visibility = Windows.Visibility.Visible
        Else
            btnOpenRestoreScreen.Visibility = Windows.Visibility.Collapsed
        End If
        If iCnt = 1 Then

            'Dim DictVal As Dictionary(Of String, String) = LoadCellValue(dgContent)

            'Dim DR As Object = dgContent.SelectedItems(0)
            'Dim IX As Integer = dgContent.SelectedIndex

            Dim VAL As String = DictVal("isPublic")
            If VAL.ToUpper.Equals("Y") Then
                'If DR.isPublic.ToString.ToUpper.Equals("Y") Then
                lblIsPublicShow.Visibility = Visibility.Visible
            Else
                lblIsPublicShow.Visibility = Visibility.Collapsed
            End If

            If DictVal.ContainsKey("StructuredData") Then
                VAL = DictVal("StructuredData")
                If VAL.ToUpper.Equals("TRUE") Then
                    lblStructuredData.Visibility = Visibility.Visible
                Else
                    lblStructuredData.Visibility = Visibility.Collapsed
                End If
            End If

            If DictVal.ContainsKey("isWebPage") Then
                VAL = DictVal("isWebPage")
                If VAL.ToUpper.Equals("Y") Then
                    LblIsWebShow.Visibility = Visibility.Visible
                Else
                    LblIsWebShow.Visibility = Visibility.Collapsed
                End If
            End If

            If DictVal.ContainsKey("Description") Then
                VAL = DictVal("Description")
                If VAL.Trim.Length > 0 Then
                    txtDescription.Text = VAL
                Else
                    txtDescription.Text = ""
                End If
            End If

            If DictVal.ContainsKey("RssLinkFlg") Then
                VAL = DictVal("RssLinkFlg")
                If VAL.ToUpper.Equals("Y") Then
                    LblIsWebShow.Visibility = Visibility.Visible
                Else
                    LblIsWebShow.Visibility = Visibility.Collapsed
                End If
            End If

            'If DR.isMaster.ToString.ToUpper.Equals("N") Then
            '    LblCkIsMasterShow.Visibility = Visibility.Collapsed
            'Else
            '    LblCkIsMasterShow.Visibility = Visibility.Visible
            'End If
            'If DR.SharePoint.ToString.ToUpper.Equals("TRUE") Then
            '    lblSharePoint.Visibility = Visibility.Visible
            'Else
            '    lblSharePoint.Visibility = Visibility.Collapsed
            'End If
            'If DR.SapData.ToString.ToUpper.Equals("TRUE") Then
            '    lblSap.Visibility = Visibility.Visible
            'Else
            '    lblSap.Visibility = Visibility.Collapsed
            'End If

            VAL = DictVal("SourceGuid")
            CurrentGuid = VAL
            RepoTableName = "DataSource"
            '** Get any metadata
            If iCnt = 1 Then
                Dim II As Integer = dgContent.SelectedIndex
                'Dim ParentGuid As String = DR.ParentGuid")
                RepoTableName = "DataSource"
                Dim FoundInAttachment As Boolean = False
                'Dim IsZipFile As String = DR.IsZipFile")
                'Dim IsConatinedWithinZipFile As String = DR.IsConatinedWithinZipFile")
                Dim SD, SP, SAP, bMaster, RSS, WEB, PUB As Boolean

                Dim jsonListOfRows As String = ProxySearch.GetFilesInZipDetail(gSecureID, CurrentGuid, RC)
                client_GetFilesInZipDetail(jsonListOfRows)

                ProxySearch.ckContentFlags(gSecureID, CurrentGuid, SD, SP, SAP, bMaster, RSS, WEB, PUB)
                client_ckContentFlagsCompleted(gSecureID, CurrentGuid, SD, SP, SAP, bMaster, RSS, WEB, PUB)
            Else
                GetMetaData(CurrentGuid)
            End If

        End If
        If contentSearchParmsSet() Then
            lblContentSearchParms.Visibility = Visibility.Visible
        Else
            lblContentSearchParms.Visibility = Visibility.Collapsed
        End If
    End Sub

    ''' <summary>
    ''' Gets the meta data.
    ''' </summary>
    ''' <param name="SourceGuid">The source unique identifier.</param>
    Sub GetMetaData(ByVal SourceGuid As String)
        Cursor = Cursors.Wait
        Dim S As String = "Select AttributeName, AttributeValue" + Environment.NewLine
        S = S + " FROM [SourceAttribute]" + Environment.NewLine
        S = S + " where [SourceGuid] = '" + SourceGuid + "'" + Environment.NewLine
        S = S + " order by [AttributeName]"

        'AddHandler ProxySearch.GetContentMetaDataCompleted, AddressOf client_GetContentMetaData
        Dim strDS_Metadata As String = ProxySearch.GetContentMetaData(_SecureID, SourceGuid)
        client_GetContentMetaData(strDS_Metadata)
    End Sub

    ''' <summary>
    ''' Clients the get content meta data.
    ''' </summary>
    ''' <param name="strDS_Metadata">The string ds metadata.</param>
    Sub client_GetContentMetaData(strDS_Metadata As String)

        Dim ListOfRows As New System.Collections.ObjectModel.ObservableCollection(Of DS_Metadata)
        Dim jss = New JavaScriptSerializer()
        Dim ObjContent = jss.Deserialize(Of DS_Metadata())(strDS_Metadata)
        Dim Z As Integer = ObjContent.Count
        For Each Obj As DS_Metadata In ObjContent
            ListOfRows.Add(Obj)
        Next

        If ListOfRows.Count > 0 Then
            dgAttachments.ItemsSource = ListOfRows
            dgAttachments.Visibility = Visibility.Visible
            FormLoaded = True
        Else
            dgAttachments.ItemsSource = Nothing
            dgAttachments.Visibility = Visibility.Visible
        End If
        'RemoveHandler ProxySearch.GetContentMetaDataCompleted, AddressOf client_GetContentMetaData
        Cursor = Cursors.Arrow
    End Sub

    ''' <summary>
    ''' Handles the LoadedRows event of the dgContent control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.EventArgs"/> instance containing the event data.</param>
    Private Sub dgContent_LoadedRows(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles dgContent.Loaded

        getSavedContentGridColumnsDisplayOrder()
    End Sub

    ''' <summary>
    ''' Handles the DoubleClick event of the dgEmails control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Input.MouseButtonEventArgs"/> instance containing the event data.</param>
    Private Sub dgEmails_DoubleClick(ByVal sender As System.Object, ByVal e As System.Windows.Input.MouseButtonEventArgs) Handles dgEmails.MouseDoubleClick

        btnOpenRestoreScreen.Visibility = Windows.Visibility.Visible

        callPreview()
        SB.Text = "Preview Requested: " + Now.ToString

    End Sub

    ''' <summary>
    ''' Handles the DoubleClick event of the dgContent control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Input.MouseButtonEventArgs"/> instance containing the event data.</param>
    Private Sub dgContent_DoubleClick(ByVal sender As System.Object, ByVal e As System.Windows.Input.MouseButtonEventArgs) Handles dgContent.MouseDoubleClick
        COMMON.SaveClick(900, gCurrUserGuidID)
        btnOpenRestoreScreen.Visibility = Windows.Visibility.Visible

        callPreview()

    End Sub

    'Sub client_DbWriteToFile(ByVal sender As Object, ByVal e As SVCSearch.DbWriteToFileCompletedEventArgs)

    '    If RC Then
    '        Dim fName As String = e.FileName
    '        Dim b As Boolean = e.Result
    '        If b Then
    '            System.Windows.Browser.HtmlPage.PopupWindow(New Uri("http://localhost:9854/TempContent/" + fName), "_blank", Nothing)
    '            filePreviewName = fName
    '        Else
    '            MessageBox.Show("Cannot open document.")
    '        End If
    '    Else
    '        SB.Text = "ERROR: Failed to process preview request."
    '    End If
    'End Sub



    ''' <summary>
    ''' Handles the Unchecked event of the rbEmails control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub rbEmails_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles rbEmails.Unchecked
        Console.WriteLine("Trace:01")
        'If DoNotDoThis Then
        '    Return
        'End If
        TabContent.Visibility = Visibility.Visible
    End Sub

    ''' <summary>
    ''' Sets the tabs open closed.
    ''' </summary>
    Sub setTabsOpenClosed()
        Try
            If rbAll.IsChecked Then
                TabContent.Visibility = Visibility.Visible
                TabEmail.Visibility = Visibility.Visible
                TabContent_GotFocus(Nothing, Nothing)
                TabEmail_GotFocus(Nothing, Nothing)
                TabContent.IsSelected = True

            ElseIf rbEmails.IsChecked Then
                TabContent.Visibility = Visibility.Collapsed
                TabEmail_GotFocus(Nothing, Nothing)
                TabEmail.IsSelected = True
                TabEmail.Visibility = Visibility.Visible
            ElseIf rbContent.IsChecked Then
                TabContent_GotFocus(Nothing, Nothing)
                TabContent.Visibility = Visibility.Visible
                TabContent.IsSelected = True
                TabEmail.Visibility = Visibility.Collapsed
            Else
                TabContent.Visibility = Visibility.Visible
                TabEmail.Visibility = Visibility.Visible
                TabContent_GotFocus(Nothing, Nothing)
                TabEmail_GotFocus(Nothing, Nothing)
                TabContent.IsSelected = True
            End If

            UdpateSearchTerm("ALL", "rbAll", rbAll.IsChecked, "B")
            UdpateSearchTerm("ALL", "rbEmails", rbEmails.IsChecked, "B")
            UdpateSearchTerm("ALL", "rbContent", rbContent.IsChecked, "B")
        Catch ex As Exception
            Console.WriteLine("ERROR: setTabsOpenClosed 221q : " + ex.Message)
        End Try

    End Sub

    ''' <summary>
    ''' Handles the Checked event of the rbAll control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub rbAll_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles rbAll.Checked
        Console.WriteLine("Trace:02")
        'If DoNotDoThis Then
        '    Return
        'End If
        setTabsOpenClosed()
    End Sub

    ''' <summary>
    ''' Handles the Checked event of the rbContent control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub rbContent_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs)
        Console.WriteLine("Trace:03")
        'If DoNotDoThis Then
        '    Return
        'End If
        TabEmail.Visibility = Visibility.Collapsed
    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the rbContent control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub rbContent_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs)
        TabEmail.Visibility = Visibility.Visible
        If bQuickSearchRecall2 Then
            Return
        End If
        UdpateSearchTerm("ALL", "rbContent", rbContent.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Sets the inactive state of form.
    ''' </summary>
    Sub SetInactiveStateOfForm()

        Dim iOpacity As Double = 0.25
        Dim DOW As String = Now.DayOfWeek.ToString

        'If DOW.Equals("Monday") Then
        '    imageMain.Source = New BitmapImage(New Uri("images/Monday.jpg", UriKind.RelativeOrAbsolute))
        '    imageMain.Stretch = Stretch.Fill
        '    imageMain.Opacity = iOpacity
        'ElseIf DOW.Equals("Tuesday") Then
        '    imageMain.Source = New BitmapImage(New Uri("images/Tuesday.jpg", UriKind.RelativeOrAbsolute))
        '    imageMain.Stretch = Stretch.Fill
        '    imageMain.Opacity = iOpacity
        'ElseIf DOW.Equals("Wednesday") Then
        '    imageMain.Source = New BitmapImage(New Uri("images/Wednesday.jpg", UriKind.RelativeOrAbsolute))
        '    imageMain.Stretch = Stretch.Fill
        '    imageMain.Opacity = iOpacity
        'ElseIf DOW.Equals("Thursday") Then
        '    imageMain.Source = New BitmapImage(New Uri("images/Thursday.jpg", UriKind.RelativeOrAbsolute))
        '    imageMain.Stretch = Stretch.Fill
        '    imageMain.Opacity = iOpacity
        'ElseIf DOW.Equals("Friday") Then
        '    imageMain.Source = New BitmapImage(New Uri("images/Friday.jpg", UriKind.RelativeOrAbsolute))
        '    imageMain.Stretch = Stretch.Fill
        '    imageMain.Opacity = iOpacity
        'ElseIf DOW.Equals("Saturday") Then
        '    imageMain.Source = New BitmapImage(New Uri("images/Saturday.jpg", UriKind.RelativeOrAbsolute))
        '    'imageMain.Source = New BitmapImage(New Uri("images/ARDEC-medium2.png", UriKind.RelativeOrAbsolute))
        '    imageMain.Stretch = Stretch.Fill
        '    imageMain.Opacity = iOpacity
        'ElseIf DOW.Equals("Sunday") Then
        '    imageMain.Source = New BitmapImage(New Uri("images/Sunday.jpg", UriKind.RelativeOrAbsolute))
        '    'imageMain.Source = New BitmapImage(New Uri("images/ARDEC-medium2.png", UriKind.RelativeOrAbsolute))
        '    imageMain.Stretch = Stretch.Fill
        '    imageMain.Opacity = iOpacity
        'Else
        '    imageMain.Source = New BitmapImage(New Uri("images/CubeAnalysis.jpg", UriKind.RelativeOrAbsolute))
        '    imageMain.Stretch = Stretch.Fill
        '    imageMain.Opacity = iOpacity
        'End If

        tabSearch.Visibility = Visibility.Collapsed

        btnOpenRestoreScreen.Visibility = Visibility.Collapsed
        btnReset.Visibility = Visibility.Collapsed
        ckShowDetails.Visibility = Visibility.Collapsed
        hlScheduleSearch.Visibility = Visibility.Collapsed
        hlAlerts.Visibility = Visibility.Collapsed

        gridPreview.Visibility = Windows.Visibility.Collapsed
        gridTabs.Visibility = Windows.Visibility.Collapsed

        dgAttachments.Visibility = Visibility.Collapsed

        Dim HideTabs As Boolean = False
        If HideTabs.Equals(True) Then
            tabSearch.Visibility = Visibility.Collapsed
            TabEmail.Visibility = Visibility.Collapsed
            TabContent.Visibility = Visibility.Collapsed
        Else
            tabSearch.Visibility = Visibility.Visible
            TabEmail.Visibility = Visibility.Visible
            TabContent.Visibility = Visibility.Visible
        End If
        'ckFilters.IsChecked = False

        ckFilters.Visibility = Visibility.Visible

    End Sub

    ''' <summary>
    ''' Sets the active state of form.
    ''' </summary>
    Sub SetActiveStateOfForm()

        'imageMain.Visibility = Visibility.Collapsed

        tabSearch.Visibility = Visibility.Visible
        TabEmail.Visibility = Visibility.Visible
        TabContent.Visibility = Visibility.Visible
        ckFilters.Visibility = Visibility.Visible

        gridPreview.Visibility = Windows.Visibility.Visible
        gridTabs.Visibility = Windows.Visibility.Visible

    End Sub

    'Private Sub LayoutRoot_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Input.KeyEventArgs) Handles LayoutRoot.KeyDown
    '    If e.Key = Key.F1 Then
    '        Dim cw As New popupHelp()
    '        cw.Show()
    '    End If
    'End Sub

    ''' <summary>
    ''' Handles the Click event of the hlScheduleSearch control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub hlScheduleSearch_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlScheduleSearch.Click
        If bQuickSearchRecall2 Then
            Return
        End If

        If Not _isAdmin Then
            MessageBox.Show("Admin rights required to execute this function, please get an ADMIN to set this up.")
            Return
        End If

        Dim cw As New popupScheduelSearch()
        cw.Show()
    End Sub

    ''' <summary>
    ''' Handles the KeyDown event of the dgEmails control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Input.KeyEventArgs"/> instance containing the event data.</param>
    Private Sub dgEmails_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Input.KeyEventArgs) Handles dgEmails.KeyDown
        If e.Key = Key.F9 Then
            PopulateDictMasterSearch()
            Dim cw As New popupEmailSearchParms(gSecureID)
            AddHandler cw.Closed, AddressOf handler_PopulateEmailSearchDetailParms_Closed
            cw.Show()
        End If
    End Sub

    ''' <summary>
    ''' Handles the Closed event of the handler_PopulateEmailSearchDetailParms control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
    Private Sub handler_PopulateEmailSearchDetailParms_Closed(ByVal sender As Object, ByVal e As EventArgs)
        Dim dlg As popupEmailSearchParms = DirectCast(sender, popupEmailSearchParms)
        Dim result As System.Nullable(Of Boolean) = dlg.DialogResult
        If result = True Then
            PopulateEmailSearchDetailParms()
        End If
        ''RemoveHandler handler_PopulateEmailSearchDetailParms_Closed
    End Sub

    ''' <summary>
    ''' Handles the Closed event of the handler_PopulateDictMasterSearch control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
    Private Sub handler_PopulateDictMasterSearch_Closed(ByVal sender As Object, ByVal e As EventArgs)
        Dim dlg As popupContentSearchParms = DirectCast(sender, popupContentSearchParms)
        Dim result As System.Nullable(Of Boolean) = dlg.DialogResult
        If result = True Then
            PopulateContentSearchDetailParms()
        End If
    End Sub

    ''' <summary>
    ''' Handles the 1 event of the txtSearch_KeyDown control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Input.KeyEventArgs"/> instance containing the event data.</param>
    Private Sub txtSearch_KeyDown_1(ByVal sender As System.Object, ByVal e As System.Windows.Input.KeyEventArgs) Handles txtSearch.KeyDown
        If e.Key = Key.F11 Then
            GenSqlOnly = True
            'btnSubmit_Click(Nothing, Nothing)
            genSearchSql()
            Return
        End If
        If e.Key = Key.F12 Then
            GenSqlOnly = True
            'btnSubmit_Click(Nothing, Nothing)
            genSearchSql()
            Return
        End If
        If e.Key = Key.F9 Then
            Dim cw As New frmSearchAsst(gSecureID)
            cw.GeneratedSearch = ""
            cw.ShowDialog()
            If cw.GeneratedSearch.Trim.Length > 0 Then
                txtSearch.Text = cw.GeneratedSearch.Trim
            End If
            Return
        End If
        If e.Key = Key.Enter Then
            btnSubmit_Click(Nothing, Nothing)
        End If
    End Sub

    ''' <summary>
    ''' Handles the GotFocus event of the TabContent control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub TabContent_GotFocus(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles TabContent.GotFocus
        gSelectedGrid = "dgContent"
        COMMON.SaveClick(600, gCurrUserGuidID)
        dgAttachments.Visibility = Windows.Visibility.Collapsed
    End Sub

    ''' <summary>
    ''' Handles the GotFocus event of the TabEmail control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub TabEmail_GotFocus(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles TabEmail.GotFocus
        gSelectedGrid = "dgEmail"
        COMMON.SaveClick(700, gCurrUserGuidID)
        dgAttachments.Visibility = Windows.Visibility.Visible
    End Sub

    ''' <summary>
    ''' Handles the DoubleClick event of the dgAttachments control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Input.MouseButtonEventArgs"/> instance containing the event data.</param>
    Private Sub dgAttachments_DoubleClick(ByVal sender As System.Object, ByVal e As System.Windows.Input.MouseButtonEventArgs) Handles dgAttachments.MouseDoubleClick

        COMMON.SaveClick(800, gCurrUserGuidID)
        RepoTableName = "EMAILATTACHMENT"

        callPreview()


        SB.Text = "Preview Requested: " + Now.ToString
    End Sub

    ''' <summary>
    ''' Handles the MouseEnter event of the dgAttachments control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Input.MouseEventArgs"/> instance containing the event data.</param>
    Private Sub dgAttachments_MouseEnter(ByVal sender As System.Object, ByVal e As System.Windows.Input.MouseEventArgs) Handles dgAttachments.MouseEnter
        SB.Text = "Found in Attachment ?"

        Try
            If SelectedGrid = "dgEmails" Then
                Dim I As Integer = 0
                Dim DT As DataTable = grid.ConvertDataGridToDataTable(dgAttachments)
                For Each DR As DataRow In DT.Rows
                    'Dim col As DataColumn
                    Dim iRowID As Integer = DR("RowID")
                    If iRowID = RID Then
                        dgAttachments.SelectedIndex = I
                        dgAttachments.Items(I).Selected = True
                        SB.Text = "Found in Attachment #" + RID.ToString
                        Exit For
                    End If
                    I = I + 1
                Next
            End If
        Catch ex As Exception
            SB.Text = "Could not determine attachment."
        End Try

    End Sub

    ''' <summary>
    ''' Handles the MouseLeave event of the dgAttachments control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Input.MouseEventArgs"/> instance containing the event data.</param>
    Private Sub dgAttachments_MouseLeave(ByVal sender As System.Object, ByVal e As System.Windows.Input.MouseEventArgs) Handles dgAttachments.MouseLeave
        If SelectedGrid = "dgEmails" Then
            Try
                dgAttachments.SelectedItems.Clear()
            Catch ex As Exception
                SB.Text = "Could not set Attachment Grid."
            End Try
        End If
    End Sub

    ''' <summary>
    ''' Populates the dictionary master search.
    ''' </summary>
    Sub PopulateDictMasterSearch()
        'dictMasterSearch
        Dim ScreenName = "frmQuickSearch"
        Dim SaveTypeCode$ = "QUICKSEARCH"
        Dim UID As String = CurrUserGuidID
        Dim ValName As String = ""
        Dim ValValue As String = ""
        Dim B As Boolean = True

        Dim txtSelDir As String = "??"
        Dim ckShowDetails As Boolean = False
        Dim ckCountOnly As Boolean = False
        Dim ckLimitToExisting As Boolean = False
        Dim ckBusiness As Boolean = False
        Dim rbToDefaultDir As Boolean = False
        Dim rbToOriginalDir As Boolean = False
        Dim rbToSelDir As Boolean = False
        Dim ckOverWrite As Boolean = False

        PopulateEmailSearchDetailParms()
        PopulateContentSearchDetailParms()

        For Each ValName In dictEmailSearch.Keys
            ValValue = dictEmailSearch.Item(ValName)
            AddDictMasterSearch(ValName, ValValue)
        Next
        For Each ValName In dictContentSearch.Keys
            ValValue = dictContentSearch.Item(ValName)
            AddDictMasterSearch(ValName, ValValue)
        Next

        AddDictMasterSearch("CurrUserGuidID", CurrUserGuidID)
        AddDictMasterSearch("CurrLoginID", CurrLoginID)

        ValName = "txtSearch"
        ValValue = txtSearch.Text.Trim
        AddDictMasterSearch(ValName, ValValue)

        ValName = "txtSelDir"
        'ValValue = txtSelDir
        AddDictMasterSearch(ValName, ValValue)

        ValName = "cbLibrary"
        ValValue = cbLibrary.SelectedItem
        AddDictMasterSearch(ValName, ValValue)

        ValName = "nbrWeightMin"
        ValValue = nbrWeightMin.Text
        AddDictMasterSearch(ValName, ValValue)

        ValName = "rbAll"
        ValValue = rbAll.IsChecked.ToString
        AddDictMasterSearch(ValName, ValValue)

        ValName = "rbContent"
        ValValue = rbContent.IsChecked.ToString
        AddDictMasterSearch(ValName, ValValue)

        ValName = "rbEmails"
        ValValue = rbEmails.IsChecked.ToString
        AddDictMasterSearch(ValName, ValValue)

        ValName = "ckLimitToLib"
        ValValue = ckLimitToLib.IsChecked.ToString
        AddDictMasterSearch(ValName, ValValue)

        ValName = "ckMyContent"
        ValValue = ckMyContent.IsChecked.ToString
        AddDictMasterSearch(ValName, ValValue)

        ValName = "ckMasterOnly"
        ValValue = ckMasterOnly.IsChecked.ToString
        AddDictMasterSearch(ValName, ValValue)

        ValName = "ckWeights"
        ValValue = ckWeights.IsChecked.ToString
        AddDictMasterSearch(ValName, ValValue)

        ValName = "lblMain"
        ValValue = lblMain.Content
        AddDictMasterSearch(ValName, ValValue)

        ValName = "ckFilters"
        ValValue = ckFilters.IsChecked.ToString
        AddDictMasterSearch(ValName, ValValue)

        ValName = "SBEmail"
        ValValue = SBEmail.Text
        AddDictMasterSearch(ValName, ValValue)

        ValName = "SBDoc"
        ValValue = SBDoc.Text
        AddDictMasterSearch(ValName, ValValue)

        ValName = "SB"
        ValValue = SB.Text
        AddDictMasterSearch(ValName, ValValue)
    End Sub

    ''' <summary>
    ''' Adds the dictionary master search.
    ''' </summary>
    ''' <param name="tKey">The t key.</param>
    ''' <param name="tVal">The t value.</param>
    Sub AddDictMasterSearch(ByVal tKey As String, ByVal tVal As String)
        If dictMasterSearch.ContainsKey(tKey) Then
            dictMasterSearch.Item(tKey) = tVal
        Else
            dictMasterSearch.Add(tKey, tVal)
        End If
    End Sub

    ''' <summary>
    ''' Populates the email search detail parms.
    ''' </summary>
    Sub PopulateEmailSearchDetailParms()
        ''Dim B As Boolean = ISO.ReadDetailSearchParms("EMAIL", dictEmailSearch)
        ''If Not B Then
        ''    SB.Text = "ERROR PopulateEmailSearchDetailParms: failed to load email detailed search parms"
        ''Else
        'For Each sKey As String In dictMasterSearch.Keys
        '    Dim tKey As String = sKey
        '    Dim tVal As String = ""
        '    'tVal = dictEmailSearch.Item(sKey).ToString
        '    tVal = dictMasterSearch.Item(sKey).ToString
        '    UdpateSearchTerm("EPARM", tKey, tVal, "S")
        'Next
        ''End If
        For I As Integer = 0 To dictMasterSearch.Count - 1
            'Dim tKey As String = sKey
            Dim tKey As String = dictMasterSearch.Keys(I)
            Dim tVal As String = dictMasterSearch.Item(tKey)
            'tVal = dictMasterSearch.Item(sKey).ToString
            UdpateSearchTerm("EPARM", tKey, tVal, "S")
        Next
    End Sub

    ''' <summary>
    ''' Populates the content search detail parms.
    ''' </summary>
    Sub PopulateContentSearchDetailParms()
        'Dim B As Boolean = ISO.ReadDetailSearchParms("CONTENT", dictContentSearch)
        'If Not B Then
        '    SB.Text = "ERROR PopulateContentSearchDetailParms: failed to load content detailed search parms"
        'Else
        'For Each sKey As String In dictMasterSearch.Keys
        For I As Integer = 0 To dictMasterSearch.Count - 1
            'Dim tKey As String = sKey
            Dim tKey As String = dictMasterSearch.Keys(I)
            Dim tVal As String = dictMasterSearch.Item(tKey)
            'tVal = dictMasterSearch.Item(sKey).ToString
            UdpateSearchTerm("CPARM", tKey, tVal, "S")
        Next
        'End If
    End Sub

    ''' <summary>
    ''' Handles the Unloaded event of the Page control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub Page_Unloaded(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles MyBase.Unloaded

        'SearchHistorySave()

        Dim BB As Boolean = ProxySearch.SetSAASState(_SecureID, _UserGuid, "SAAS_STATE", "INACTIVE")
        client_SetSAASState(BB)

        ISO.PreviewFileZeroize()
        'Dim B As Boolean = ISO.DeleteClcReadyStatus()
        'If B Then
        '    Console.WriteLine("RDY Status removed.")
        'Else
        '    Console.WriteLine("Failed to removed RDY Status .")
        'End If
        COMMON.SaveClick(999991, _UserGuid)
    End Sub

    ''' <summary>
    ''' Handles the GotFocus event of the Page control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub Page_GotFocus(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles MyBase.GotFocus
        'ISO.SetCLC_State2(CurrLoginID, "IDENTIFIED")
    End Sub

    ''' <summary>
    ''' Handles the GotFocus event of the dgContent control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub dgContent_GotFocus(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles dgContent.GotFocus
        Console.WriteLine("Trace:04")
        If DoNotDoThis Then
            Return
        End If
        ckClcActive()
    End Sub

    ''' <summary>
    ''' Handles the Exit event of the App control.
    ''' </summary>
    ''' <param name="o">The source of the event.</param>
    ''' <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
    Private Sub App_Exit(ByVal o As Object, ByVal e As EventArgs) Handles Me.Unloaded
        '************************************************
        ' The application is about to stop running.
        ' Perform needed cleanup.
        '************************************************
        Dim bDeleteRdyStatus As Boolean = False
        If bDeleteRdyStatus Then
            Dim B As Boolean = ISO.DeleteClcReadyStatus()
            If B Then
                Console.WriteLine("RDY Status removed.")
            Else
                Console.WriteLine("Failed to removed RDY Status .")
            End If
        End If
    End Sub

    ''' <summary>
    ''' Handles the MouseEnter event of the imgDbInfo control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Input.MouseEventArgs"/> instance containing the event data.</param>
    Private Sub imgDbInfo_MouseEnter(ByVal sender As System.Object, ByVal e As System.Windows.Input.MouseEventArgs) Handles imgDbInfo.MouseEnter
        PrevText = ""
        PrevText = SB.Text
        SB.Text = lblDbInstance.Content

        'AddHandler ProxySearch.getServerDatabaseNameCompleted, AddressOf client_getServerDatabaseName
        Dim SS As String = ProxySearch.getServerDatabaseName(gSecureID)
        client_getServerDatabaseName(SS)
    End Sub

    ''' <summary>
    ''' Clients the name of the get server database.
    ''' </summary>
    ''' <param name="SS">The ss.</param>
    Sub client_getServerDatabaseName(SS As String)
        If SS.Length > 0 Then
            SB.Text = SS + " / " + _UserGuid
        Else
            SB.Text += " no db name found / " + _UserGuid
        End If
    End Sub

    ''' <summary>
    ''' Handles the MouseLeave event of the imgDbInfo control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Input.MouseEventArgs"/> instance containing the event data.</param>
    Private Sub imgDbInfo_MouseLeave(ByVal sender As System.Object, ByVal e As System.Windows.Input.MouseEventArgs) Handles imgDbInfo.MouseLeave
        SB.Text = PrevText
    End Sub

    ''' <summary>
    ''' Handles the Click event of the hlGenSql control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub hlGenSql_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlGenSql.Click
        Console.WriteLine("Trace:05")
        If DoNotDoThis Then
            Return
        End If

        BuildSearchParameters()

        Dim cw As New popupReviewSearchParms()
        cw.Show()

    End Sub

    ''' <summary>
    ''' Shows the content search parms.
    ''' </summary>
    Sub ShowContentSearchParms()
        Dim Msg As String = ""
        Dim sVal As String = ""
        For Each S As String In dictContentSearch.Keys
            Msg += S + " : " + dictContentSearch.Item(S) + vbCrLf
        Next
        MessageBox.Show(Msg, "Content Search Parms", MessageBoxButton.OK)
    End Sub

    ''' <summary>
    ''' Shows the email search parms.
    ''' </summary>
    Sub ShowEmailSearchParms()
        Dim Msg As String = ""
        Dim sVal As String = ""
        For Each S As String In dictEmailSearch.Keys
            Msg += S + " : " + dictEmailSearch.Item(S) + vbCrLf
        Next
        MessageBox.Show(Msg, "Email Search Parms", MessageBoxButton.OK)
    End Sub

    ''' <summary>
    ''' Handles the Click event of the HyperlinkButton2 control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub HyperlinkButton2_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles HyperlinkButton2.Click
        Console.WriteLine("Trace:06")
        If DoNotDoThis Then
            Return
        End If

        RunExporter()
    End Sub

    ''' <summary>
    ''' Runs the exporter.
    ''' </summary>
    Sub RunExporter()
        If CurrentlySelectedGrid.ToUpper.Equals("CONTENT") Then
            Dim cw As New popupExportSearchGrid(dgContent)
            cw.Show()
        Else
            Dim cw As New popupExportSearchGrid(dgEmails)
            cw.Show()
        End If
    End Sub

    'Private Sub hlDownLoadCLC_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlDownLoadCLC.Click
    '    Dim msg As String = DLOAD.DownLoadSelectedItems(dgContent, dgEmails)
    '    MessageBox.Show(msg, "DOWNLOADED FILES")
    'End Sub

    ''' <summary>
    ''' Gets the static vars.
    ''' </summary>
    Sub getStaticVars()

        gSecureID = _SecureID
        CompanyID = _CompanyID
        RepoID = _RepoID
        gCurrUserGuidID = _UserID
        CurrSessionGuid = _ActiveGuid
        EncryptPW = _EncryptPW

    End Sub

    ''' <summary>
    ''' Saves the active parm.
    ''' </summary>
    ''' <param name="ParmName">Name of the parm.</param>
    ''' <param name="ParmVal">The parm value.</param>
    Sub SaveActiveParm(ByVal ParmName As String, ByVal ParmVal As String)
        'AddHandler ProxySearch.ActiveSessionCompleted, AddressOf client_ActiveSession
        Dim BB As Boolean = ProxySearch.ActiveSession(gSecureID, CurrSessionGuid, ParmName, ParmVal)
        client_ActiveSession(BB)
    End Sub

    ''' <summary>
    ''' Clients the active session.
    ''' </summary>
    ''' <param name="BB">if set to <c>true</c> [bb].</param>
    Sub client_ActiveSession(BB As Boolean)
        If Not BB Then
            SB.Text = "Failure to save " + ParmName
        End If
    End Sub

    ''' <summary>
    ''' Gets the global vars.
    ''' </summary>
    Sub GetGlobalVars()
        getActiveSessionGetVal("CompanyID")
        getActiveSessionGetVal("RepoID")
        getActiveSessionGetVal("LoginID")
        getActiveSessionGetVal("EncryptPW")
    End Sub

    ''' <summary>
    ''' Gets the active session get value.
    ''' </summary>
    ''' <param name="ParmName">Name of the parm.</param>
    Sub getActiveSessionGetVal(ByVal ParmName As String)
        'AddHandler ProxySearch.ActiveSessionGetValCompleted, AddressOf client_ActiveSessionGetVal
        Dim SS As String = ProxySearch.ActiveSessionGetVal(gSecureID, CurrSessionGuid, ParmName)
        client_ActiveSessionGetVal(SS, ParmName)
    End Sub

    ''' <summary>
    ''' Clients the active session get value.
    ''' </summary>
    ''' <param name="SS">The ss.</param>
    ''' <param name="ParmName">Name of the parm.</param>
    Sub client_ActiveSessionGetVal(SS As String, ParmName As String)
        Dim pVal As String = ""
        Dim pName As String = ""
        If SS.Length > 0 Then
            pVal = SS
            pName = ParmName
            If pName.Equals("CompanyID") Then
                CompanyID = pVal
            End If
            If pName.Equals("RepoID") Then
                RepoID = pVal
            End If
            If pName.Equals("LoginID") Then
                LoginID = pVal
            End If
            If pName.Equals("EncryptPW") Then
                EncryptPW = pVal
            End If
        Else
            SB.Text = "failed to get: " + ParmName
        End If
    End Sub

    ''' <summary>
    ''' Handles the Click event of the HyperlinkButton3 control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub HyperlinkButton3_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles HyperlinkButton3.Click

        Dim msg As String = "In order to Archive content, you will need access to the Archive Application, contact your admin."
        MessageBox.Show(msg)

    End Sub

    ''' <summary>
    ''' Handles the ScrollPositionChanging event of the dgContent control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="ScrollChangedEventArgs"/> instance containing the event data.</param>
    Private Sub dgContent_ScrollPositionChanging(ByVal sender As System.Object, ByVal e As ScrollChangedEventArgs)

        If bGhostFetchActive Then
            Return
        End If

        'Dim scrollview As ScrollViewer = FindVisualChild < ScrollViewer > (dgContent)
        Dim nTotalCount As Integer = dgContent.Items.Count
        Dim nFirstVisibleRow As Integer = e.HorizontalChange
        Dim nLastVisibleRow As Integer = nFirstVisibleRow + nTotalCount - e.ViewportHeight

        If e.VerticalChange <> 0 Then
            'If dgContent.ViewRange.TopRow < ContentTriggerRow Then
            If nFirstVisibleRow < ContentTriggerRow Then
                Return
            End If

            bEmailScrolling = False
            bContentScrolling = True

            EmailLowerPageNbr += CInt(nbrDocRows.Text)
            EmailUpperPageNbr += CInt(nbrDocRows.Text)
            DocLowerPageNbr += CInt(nbrDocRows.Text)
            DocUpperPageNbr += CInt(nbrDocRows.Text)

            bStartNewSearch = False

            Dim sbar As ScrollBar = grid.GetScrollbar(dgContent, "dgContent")
            Dim CurrPos As Double = grid.getScrollBarCurrentPosition(dgContent, "dgContent")

            'Dim TopRow As Integer = dgContent.ViewRange.TopRow
            Dim VPH As Double = e.ViewportHeight
            Dim OS As Double = e.VerticalOffset
            TopRow = CurrPos
            Dim BottomRow As Integer = dgContent.Items.Count
            Dim CurrRow As Double = OS + VPH

            'Dim PctLocation As Double = (1 - (CurrRow / BottomRow)) * 100

            Dim PctLocation As Double = grid.getScrollBarCurrentPct(dgContent, "dgContent")

            SBDocPage.Text = "Rows " & TopRow & " - " & BottomRow

            Dim TotalRows As Integer = dgContent.Items.Count
            'If TopRow > TotalRows - (TotalRows - 30) Then
            If PctLocation > 80 Then
                SB.Text = "Fetching more documents..."
                ExecuteSearch(False, "ScrollChange")
                bGhostFetchActive = True
            Else
                SB.Text = "Content: " + CurrRow.ToString + " : " + PctLocation.ToString
            End If
        End If

    End Sub

    ''' <summary>
    ''' Handles the Click event of the hlFindCLC control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub hlFindCLC_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlFindCLC.Click
        Console.WriteLine("Trace:07")
        If DoNotDoThis Then
            Return
        End If

        btnOpenRestoreScreen.Visibility = Windows.Visibility.Visible

    End Sub

    ''' <summary>
    ''' Handles the Click event of the hlUsers control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub hlUsers_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlUsers.Click
        Console.WriteLine("Trace:08")
        If DoNotDoThis Then
            Return
        End If

        COMMON.SaveClick(400, gCurrUserGuidID)
        Dim NextPage As New PageUsers
        'NextPage.show
        NextPage.Show()
    End Sub

    ''' <summary>
    ''' Handles the Click event of the hlGroups control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub hlGroups_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlGroups.Click
        Console.WriteLine("Trace:09")
        If DoNotDoThis Then
            Return
        End If

        COMMON.SaveClick(500, _UserGuid)
        Dim NextPage As New PageGroup()
        'NextPage.show
        NextPage.Show()
    End Sub

    ''' <summary>
    ''' Performs the search.
    ''' </summary>
    ''' <param name="bStartNewSearch">if set to <c>true</c> [b start new search].</param>
    Sub PerformSearch(ByVal bStartNewSearch As Boolean)

        'mainPage.Cursor = CursorType.Wait

        COMMON.SaveClick(200, _UserGuid)

        bStartNewSearch = True

        SetActiveStateOfForm()
        gListOfContent.Clear()
        gListOfEmails.Clear()

        'dgContent.ItemsSource = Nothing
        'dgEmails.ItemsSource = Nothing

        dgEmails.Opacity = 0.5

        btnSubmit.Visibility = Visibility.Collapsed
        PB.Visibility = Visibility.Visible
        PB.IsIndeterminate = True

        Dim TempStr As String = txtSearch.Text

        UTIL.RemoveUnwantedCharacters(txtSearch.Text)
        txtSearch.Text = UTIL.RemoveSingleQuotes(txtSearch.Text, ckWeights.IsChecked)

        If ckLimitToLib.IsChecked And cbLibrary.SelectedValue = "" Then
            ckLimitToLib.IsChecked = False
        End If

        qStart = Now

        bIncludeLibraryFilesInSearch = False
        'ZeroizeGlobalSearch()

        '*************************************************************
        CurrentSearchIdHigh += 1
        DoNotGetSearchHistory = True
        'lblMain.Content = CurrentSearchIdHigh
        If CurrentSearchIdHigh > PageRowLimit Then
            CurrentSearchIdHigh = 1
            lblMain.Content = "1"
        End If
        DoNotGetSearchHistory = False
        If CurrentSearchIdHigh > PageRowLimit Then
            CurrentSearchIdHigh = 1
            lblMain.Content = "1"
        End If

        If Not GenSqlOnly Then
            SaveSearchParmParms(CurrentSearchIdHigh)
        End If

        '*************************************************************
        ExecuteSearch(GenSqlOnly, "PerformSearch")
        '**********************************

        bGridColsRetrieved = False

        If ckWeights.IsChecked Then
            GetAttachmentWeights()
        End If

        Dim AttachmentCount As Integer = GetAttachmentCount()

        qEnd = Now

        SortGrid(True)

        CB_SQL = ""

        SBEmailPage.Text = "Rows:" & EmailLowerPageNbr & " thru " & dgEmails.Items.Count
        SBDocPage.Text = "Rows:" & DocLowerPageNbr & " thru " & dgContent.Items.Count

    End Sub

    ''' <summary>
    ''' Creates the email grid columns.
    ''' </summary>
    Sub CreateEmailGridColumns()
        If dgEmails.Columns.Count = 0 Then
            AddEmailGridColumn("AllRecipients")
            AddEmailGridColumn("Bcc")
            AddEmailGridColumn("Body")
            AddEmailGridColumn("CC")
            AddEmailGridColumn("CreationTime")
            AddEmailGridColumn("EmailGuid")
            AddEmailGridColumn("FoundInAttach")
            AddEmailGridColumn("isPublic")
            AddEmailGridColumn("MsgSize")
            AddEmailGridColumn("NbrAttachments")
            AddEmailGridColumn("OriginalFolder")
            AddEmailGridColumn("RANK")
            AddEmailGridColumn("ReceivedByName")
            AddEmailGridColumn("ReceivedTime")
            AddEmailGridColumn("RepoSvrName")
            AddEmailGridColumn("RetentionExpirationDate")
            AddEmailGridColumn("RID")
            AddEmailGridColumn("ROWID")
            AddEmailGridColumn("SenderEmailAddress")
            AddEmailGridColumn("SenderName")
            AddEmailGridColumn("SentOn")
            AddEmailGridColumn("SentTO")
            AddEmailGridColumn("ShortSubj")
            AddEmailGridColumn("SourceTypeCode")
            AddEmailGridColumn("SUBJECT")
            AddEmailGridColumn("UserID")
        End If
    End Sub

    ''' <summary>
    ''' Adds the email grid column.
    ''' </summary>
    ''' <param name="ColName">Name of the col.</param>
    Sub AddEmailGridColumn(ByVal ColName As String)
        Dim NewCol As DataGridColumn = Nothing
        NewCol.Header = ColName
        dgEmails.Columns.Add(NewCol)
    End Sub

    ''' <summary>
    ''' Creates the content grid columns.
    ''' </summary>
    Sub CreateContentGridColumns()
        If dgContent.Columns.Count = 0 Then
            AddContentGridColumn("CreateDate")
            AddContentGridColumn("DataSourceOwnerUserID")
            AddContentGridColumn("FileDirectory")
            AddContentGridColumn("FileLength")
            AddContentGridColumn("FQN")
            AddContentGridColumn("isMaster")
            AddContentGridColumn("isPublic")
            AddContentGridColumn("LastAccessDate")
            AddContentGridColumn("LastWriteTime")
            AddContentGridColumn("OriginalFileType")
            AddContentGridColumn("RANK")
            AddContentGridColumn("RepoSvrName")
            AddContentGridColumn("RetentionExpirationDate")
            AddContentGridColumn("ROWID")
            AddContentGridColumn("SourceGuid")
            AddContentGridColumn("SourceName")
            AddContentGridColumn("StructuredData")
            AddContentGridColumn("VersionNbr")
        End If
    End Sub

    ''' <summary>
    ''' Adds the content grid column.
    ''' </summary>
    ''' <param name="ColName">Name of the col.</param>
    Sub AddContentGridColumn(ByVal ColName As String)
        Dim NewCol As DataGridColumn = Nothing
        NewCol.Header = ColName
        dgContent.Columns.Add(NewCol)
    End Sub

    ''' <summary>
    ''' Updates the state.
    ''' </summary>
    ''' <param name="loading">if set to <c>true</c> [loading].</param>
    ''' <param name="EmailStartRow">The email start row.</param>
    ''' <param name="EmailEndRow">The email end row.</param>
    ''' <param name="ContentStartRow">The content start row.</param>
    ''' <param name="ContentEndRow">The content end row.</param>
    Private Sub UpdateState(ByVal loading As Boolean, ByVal EmailStartRow As Integer, ByVal EmailEndRow As Integer, ByVal ContentStartRow As Integer, ByVal ContentEndRow As Integer)
        If loading Then
            'SBEmail.Text = String.Format("Retrieving rows {0} to {1}...", EmailStartRow, EmailEndRow)
            'SBDoc.Text = String.Format("Retrieving rows {0} to {1}...", ContentStartRow, ContentEndRow)

            SBEmail.Text = String.Format("Retrieving rows {0} to {1}...", EmailStartRow, EmailStartRow + 25)
            SBDoc.Text = String.Format("Retrieving rows {0} to {1}...", ContentStartRow, ContentStartRow + 25)

            SB.Text = "Fetching data"
            _loading = True
        Else
            _loading = False
            SBEmail.Text = "Ready"
            SBDoc.Text = "Ready"
            SB.Text = "Ready"
        End If
    End Sub

    ''' <summary>
    ''' Handles the MouseEnter event of the dgContent control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Input.MouseEventArgs"/> instance containing the event data.</param>
    Private Sub dgContent_MouseEnter(ByVal sender As System.Object, ByVal e As System.Windows.Input.MouseEventArgs) Handles dgContent.MouseEnter
        'SBEmailPage.Text = "Rows:1 thru " & dgEmails.Items.Count
        'SBDocPage.Text = "Rows:1 thru " & dgContent.Items.Count
        SelectedGrid = "dgContent"
    End Sub

    ''' <summary>
    ''' Sets the authority.
    ''' </summary>
    Sub setAuthority()

        'AddHandler ProxySearch.getUserAuthCompleted, AddressOf client_getUserAuth
        Dim SS As String = ProxySearch.getUserAuth(gSecureID, UserID)
        client_getUserAuth(SS)
    End Sub

    ''' <summary>
    ''' Clients the get user authentication.
    ''' </summary>
    ''' <param name="SS">The ss.</param>
    Sub client_getUserAuth(SS As String)

        _isAdmin = False
        _isSuperAdmin = False
        _isGlobalSearcher = False

        If SS.Length > 0 Then
            Dim Auth As String = SS.ToUpper
            If Auth.Equals("A") Then
                _isAdmin = True
                _isGlobalSearcher = True
            Else
                _isSuperAdmin = False
                _isAdmin = False
            End If
            If Auth.Equals("S") Then
                _isSuperAdmin = True
                _isAdmin = True
                _isGlobalSearcher = True
            Else
                _isSuperAdmin = False
            End If
            If Auth.Equals("G") Then
                _isGlobalSearcher = True
                _isAdmin = False
                _isSuperAdmin = False
            End If
        Else
            SB.Text = "FAILED to get client auth 100x"
        End If

        UdpateSearchTerm("ALL", "isSuperAdmin", _isSuperAdmin.ToString, "B")
        UdpateSearchTerm("ALL", "isAdmin", _isAdmin.ToString, "B")
        UdpateSearchTerm("ALL", "isGlobalSearcher", _isGlobalSearcher.ToString, "B")

        If _isAdmin = True Then
            linkGenSql.Visibility = Windows.Visibility.Visible
        Else
            linkGenSql.Visibility = Windows.Visibility.Collapsed
        End If

    End Sub

    ''' <summary>
    ''' Clients the state of the set saas.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    Sub client_SetSAASState(RC As Boolean)
        If RC Then
            SB.Text = "SAAS State Set."
        Else
            SB.Text = "Failed to set SAAS State."
        End If
    End Sub

    ''' <summary>
    ''' Allows an object to try to free resources and perform other cleanup operations before it is reclaimed by garbage collection.
    ''' </summary>
    Protected Overrides Sub Finalize()
        'SB.Text = "Standby, securing connection closure."
        '_c1SpellChecker.UserDictionary.SaveToIsolatedStorage("Custom.dct")

        MyBase.Finalize()      'define the destructor
        'RemoveHandler ProxySearch.getSystemParmCompleted, AddressOf client_LoadSystemParameters
        ''RemoveHandler Application.Current.Exit, AddressOf App_Exit
        'RemoveHandler ProxySearch.getAttachmentWeightsCompleted, AddressOf client_getAttachmentWeights
        'RemoveHandler ProxySearch.ExecuteSearchCompleted, AddressOf client_ApplyReturnedSearchData
        'RemoveHandler proxy2.getDatasourceParmCompleted, AddressOf client_getDatasourceParmTitle
        'RemoveHandler ProxySearch.GetEmailAttachmentsCompleted, AddressOf client_GetEmailAttachments
        'RemoveHandler ProxySearch.saveSearchStateCompleted, AddressOf client_saveSearchState
        'RemoveHandler ProxySearch.getSearchStateCompleted, AddressOf client_getSearchState
        'RemoveHandler ProxySearch.saveGridLayoutCompleted, AddressOf client_saveGridLayout
        'RemoveHandler ProxySearch.getGridLayoutCompleted, AddressOf client_getEmailGridLayout
        'RemoveHandler ProxySearch.getGridLayoutCompleted, AddressOf client_getContentGridLayout
        'RemoveHandler ProxySearch.getGridLayoutCompleted, AddressOf client_getContentGridLayout
        'RemoveHandler ProxySearch.SetSAASStateCompleted, AddressOf client_SetSAASState
        ''RemoveHandler ProxySearch.saveRestoreFileCompleted, AddressOf client_saveRestoreFile
        'RemoveHandler ProxySearch.scheduleFileDownLoadCompleted, AddressOf client_scheduleFileDownLoad
        'RemoveHandler ProxySearch.GetFilesInZipCompleted, AddressOf client_GetFilesInZip
        'RemoveHandler ProxySearch.PopulateGroupUserLibComboCompleted, AddressOf client_PopulateGroupUserLibCombo
        Try
            'RemoveHandler ProxySearch.AddLibraryItemsCompleted, AddressOf client_AddLibraryItems
        Catch ex As Exception
            Console.WriteLine("XXX-1245")
        End Try
        'RemoveHandler ProxySearch.SaveUserSearchCompleted, AddressOf client_SearchHistorySave
        'RemoveHandler ProxySearch.ckContentFlagsCompleted, AddressOf client_ckContentFlagsCompleted
        GC.Collect()
        GC.WaitForPendingFinalizers()

    End Sub

    ''' <summary>
    ''' Handles the ContentSearchParms event of the click control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub click_ContentSearchParms(ByVal sender As Object, ByVal e As RoutedEventArgs)
        PopulateDictMasterSearch()
        Dim cw As New popupContentSearchParms(gSecureID, dictMasterSearch)
        AddHandler cw.Closed, AddressOf handler_PopulateDictMasterSearch_Closed
        cw.Show()
    End Sub

    ''' <summary>
    ''' Handles the EmailSearchParms event of the click control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub click_EmailSearchParms(ByVal sender As Object, ByVal e As RoutedEventArgs)
        PopulateDictMasterSearch()
        Dim cw As New popupEmailSearchParms(gSecureID)
        AddHandler cw.Closed, AddressOf handler_PopulateEmailSearchDetailParms_Closed
        cw.Show()
    End Sub

    ''' <summary>
    ''' Handles the EmailColDisplayOrder event of the click control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub click_EmailColDisplayOrder(ByVal sender As Object, ByVal e As RoutedEventArgs)

        SaveGridColumnOrder(dgEmails, dictEmailGridColDisplayOrder)

        SaveGridLayoutToDB(dgEmails)
        SaveGridLayoutToDB(dgContent)

    End Sub

    ''' <summary>
    ''' Handles the ContentColDisplayOrder event of the click control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub click_ContentColDisplayOrder(ByVal sender As Object, ByVal e As RoutedEventArgs)

        SaveGridColumnOrder(dgContent, dictContentGridColDisplayOrder)

        SaveGridLayoutToDB(dgContent)
        SaveGridLayoutToDB(dgEmails)

    End Sub

    ''' <summary>
    ''' Copies the stream.
    ''' </summary>
    ''' <param name="loadStream">The load stream.</param>
    ''' <param name="saveStream">The save stream.</param>
    Private Sub CopyStream(ByVal loadStream As Stream, ByVal saveStream As Stream)
        Const bufferSize As Integer = 1024 * 1024
        Dim buffer As Byte() = New Byte(bufferSize - 1) {}
        Dim count As Integer = 0
        While count = loadStream.Read(buffer, 0, bufferSize) > 0
            saveStream.Write(buffer, 0, count)
        End While
    End Sub

    ''' <summary>
    ''' Handles the EmailPrint event of the click control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub click_EmailPrint(ByVal sender As Object, ByVal e As RoutedEventArgs)

        RunExporter()
        GC.Collect()

    End Sub

    ''' <summary>
    ''' Handles the EmailColSortOrder event of the click control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub click_EmailColSortOrder(ByVal sender As Object, ByVal e As RoutedEventArgs)
        SaveGridColumnOrder(dgEmails, dictEmailGridColDisplayOrder)
        'SaveGridLayoutToDB(dgEmails)
    End Sub

    ''' <summary>
    ''' Handles the ContentColSortOrder event of the click control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub click_ContentColSortOrder(ByVal sender As Object, ByVal e As RoutedEventArgs)
        SaveGridColumnOrder(dgContent, dictContentGridColDisplayOrder)
        'SaveGridLayoutToDB(dgEmails)
    End Sub

    ''' <summary>
    ''' Handles the ExportSearchResults event of the click control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub click_ExportSearchResults(ByVal sender As Object, ByVal e As RoutedEventArgs)
        RunExporter()
        GC.Collect()
    End Sub

    ''' <summary>
    ''' Handles the EmailPreview event of the click control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub click_EmailPreview(ByVal sender As Object, ByVal e As RoutedEventArgs)
        btnOpenRestoreScreen.Visibility = Windows.Visibility.Visible

        callPreview()
        SB.Text = "Preview Requested: " + Now.ToString
    End Sub

    ''' <summary>
    ''' Handles the EmailRestore event of the click control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub click_EmailRestore(ByVal sender As Object, ByVal e As RoutedEventArgs)

        COMMON.SaveClick(10001, gCurrUserGuidID)
        If RepoTableName.Equals("EmailAttachment") Then
            MessageBox.Show("Sorry, an attachment is an 'embedded' component of an email." + vbCrLf + "Therefore, the entire email must be restored - not just the attachment.")
            Return
        End If

        btnOpenRestoreScreen.Visibility = Windows.Visibility.Visible

        SB.Text = "Download Requested: " + Now.ToString
        'Dim ISO As New clsIsolatedStorage
        Dim NextPage As New frmContentRestore(RepoTableName, dgEmails, dgAttachments, dgContent)
        NextPage.Show()
    End Sub

    'Private Sub click_DictLoadCompleted(ByVal sender As Object, ByVal e As OpenReadCompletedEventArgs)
    '    If RC Then
    '        SB.Text = "Dictionary Loaded: " & _c1SpellChecker.MainDictionary.WordCount & " words."
    '        Console.WriteLine("Dictionary Loaded: " & _c1SpellChecker.MainDictionary.WordCount & " words.")
    '    Else
    '        Console.WriteLine("Failed to load spell check dictionary." + vbCrLf + vbCrLf + e.Error.Message)
    '    End If
    'End Sub

    ''' <summary>
    ''' Handles the SearchAsst event of the click control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub click_SearchAsst(ByVal sender As Object, ByVal e As RoutedEventArgs)
        SB.Text = "Search Assistant"
        Dim NextPage As New frmSearchAsst(_SecureID)
        'AddHandler NextPage.Closed, AddressOf Handler_frmSearchAsst_closed
        NextPage.GeneratedSearch = ""
        NextPage.ShowDialog()
        txtSearch.Text = NextPage.GeneratedSearch
    End Sub

    'Private Sub click_SpellCheck(ByVal sender As Object, ByVal e As RoutedEventArgs)
    '    AddHandler _c1SpellChecker.CheckControlCompleted, AddressOf SpellCK_Completed
    '    _c1SpellChecker.CheckControlAsync(txtSearch, False, SpellDLG)
    'End Sub

    '********************************************************************************************************
    '********************************************************************************************************
    ''' <summary>
    ''' Handles the GenContentSQL event of the click control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Sub click_GenContentSQL(ByVal sender As Object, ByVal e As RoutedEventArgs)

        UdpateSearchTerm("ALL", "isSuperAdmin", _isSuperAdmin.ToString, "B")
        UdpateSearchTerm("ALL", "isAdmin", _isAdmin.ToString, "B")
        UdpateSearchTerm("ALL", "isGlobalSearcher", _isGlobalSearcher.ToString, "B")

        UdpateSearchTerm("ALL", "CalledFromScreen", Me.Title, "S")
        UdpateSearchTerm("ALL", "UID", CurrUserGuidID, "S")

        UdpateSearchTerm("ALL", "CurrUserGuidID", CurrUserGuidID.Trim, "S")
        UdpateSearchTerm("ALL", "CurrLoginID", CurrLoginID.Trim, "S")
        UdpateSearchTerm("ALL", "UID", CurrUserGuidID.Trim, "S")

        UdpateSearchTerm("ALL", "txtSearch", txtSearch.Text.Trim, "S")
        UdpateSearchTerm("ALL", "bNeedRowCount", bNeedRowCount.ToString, "B")
        UdpateSearchTerm("ALL", "rbAll", rbAll.IsChecked.ToString, "B")
        UdpateSearchTerm("ALL", "rbEmails", rbEmails.IsChecked.ToString, "B")
        UdpateSearchTerm("ALL", "rbContent", rbContent.IsChecked.ToString, "B")
        UdpateSearchTerm("ALL", "ckWeights", ckWeights.IsChecked.ToString, "B")
        UdpateSearchTerm("ALL", "ckLimitToLib", ckLimitToLib.IsChecked.ToString, "B")
        UdpateSearchTerm("ALL", "cbLibrary", cbLibrary.SelectedItem, "S")
        UdpateSearchTerm("ALL", "MinWeight", MinWeight.ToString, "I")
        UdpateSearchTerm("ALL", "CurrentDocPage", CurrentDocPage.ToString, "I")
        UdpateSearchTerm("ALL", "CurrentEmailPage", CurrentEmailPage.ToString, "I")
        UdpateSearchTerm("ALL", "StartingEmailRow", "0", "I")
        UdpateSearchTerm("ALL", "StartingContentRow", "0", "I")

        Dim SelectedLib As String = ""
        If cbLibrary.SelectedIndex > -0 Then
            SelectedLib = cbLibrary.SelectedValue.ToString()
        End If

        Dim iMaxRows As Integer = 0
        If DocUpperPageNbr > EmailUpperPageNbr Then
            iMaxRows = DocUpperPageNbr
        Else
            iMaxRows = EmailUpperPageNbr
        End If
        If iMaxRows = 0 Then
            iMaxRows = PageRowLimit
        End If

        'AddHandler ProxySearch.GenContentSearchSQLCompleted, AddressOf client_GenDocSearchSql
        Dim MySql As String = ProxySearch.GenContentSearchSQL(gCurrUserGuidID, ListOfSearchTerms.ToArray, gSecureID, _UserGuid, txtSearch.Text, False, "", "", ckLimitToLib.IsChecked, SelectedLib, ckWeights.IsChecked)
        client_GenDocSearchSql(MySql)

    End Sub

    ''' <summary>
    ''' Clients the gen document search SQL.
    ''' </summary>
    ''' <param name="MySql">My SQL.</param>
    Sub client_GenDocSearchSql(MySql As String)
        If MySql.Length > 0 Then
            Dim cw As New popSqlStmt(MySql)
            cw.Show()
        Else
            MessageBox.Show("Error generating SQL : " + MySql)
        End If
        'RemoveHandler ProxySearch.GenContentSearchSQLCompleted, AddressOf client_GenDocSearchSql
    End Sub

    '********************************************************************************************************
    ''' <summary>
    ''' Handles the GenEmailSQLStmt event of the click control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Sub click_GenEmailSQLStmt(ByVal sender As Object, ByVal e As RoutedEventArgs)

        UdpateSearchTerm("ALL", "isSuperAdmin", _isSuperAdmin.ToString, "B")
        UdpateSearchTerm("ALL", "isAdmin", _isAdmin.ToString, "B")
        UdpateSearchTerm("ALL", "isGlobalSearcher", _isGlobalSearcher.ToString, "B")

        UdpateSearchTerm("ALL", "CalledFromScreen", Me.Title, "S")
        UdpateSearchTerm("ALL", "UID", CurrUserGuidID, "S")

        UdpateSearchTerm("ALL", "CurrUserGuidID", CurrUserGuidID.Trim, "S")
        UdpateSearchTerm("ALL", "CurrLoginID", CurrLoginID.Trim, "S")
        UdpateSearchTerm("ALL", "UID", CurrUserGuidID.Trim, "S")

        UdpateSearchTerm("ALL", "txtSearch", txtSearch.Text.Trim, "S")
        UdpateSearchTerm("ALL", "bNeedRowCount", bNeedRowCount.ToString, "B")
        UdpateSearchTerm("ALL", "rbAll", rbAll.IsChecked.ToString, "B")
        UdpateSearchTerm("ALL", "rbEmails", rbEmails.IsChecked.ToString, "B")
        UdpateSearchTerm("ALL", "rbContent", rbContent.IsChecked.ToString, "B")
        UdpateSearchTerm("ALL", "ckWeights", ckWeights.IsChecked.ToString, "B")
        UdpateSearchTerm("ALL", "ckLimitToLib", ckLimitToLib.IsChecked.ToString, "B")
        UdpateSearchTerm("ALL", "cbLibrary", cbLibrary.SelectedItem, "S")
        UdpateSearchTerm("ALL", "MinWeight", MinWeight.ToString, "I")
        UdpateSearchTerm("ALL", "CurrentDocPage", CurrentDocPage.ToString, "I")
        UdpateSearchTerm("ALL", "CurrentEmailPage", CurrentEmailPage.ToString, "I")
        UdpateSearchTerm("ALL", "StartingEmailRow", "0", "I")
        UdpateSearchTerm("ALL", "StartingContentRow", "0", "I")

        Dim SelectedLib As String = ""
        If cbLibrary.SelectedIndex > -0 Then
            SelectedLib = cbLibrary.SelectedValue.ToString()
        End If

        Dim iMaxRows As Integer = 0
        If DocUpperPageNbr > EmailUpperPageNbr Then
            iMaxRows = DocUpperPageNbr
        Else
            iMaxRows = EmailUpperPageNbr
        End If
        If iMaxRows = 0 Then
            iMaxRows = PageRowLimit
        End If

        'AddHandler ProxySearch.GenEmailGeneratedSQLCompleted, AddressOf client_GenEmailGeneratedSQL
        Dim SS As String = ProxySearch.GenEmailGeneratedSQL(gCurrUserGuidID, ListOfSearchTerms.ToArray, gSecureID)
        client_GenEmailGeneratedSQL(SS)
    End Sub

    ''' <summary>
    ''' Clients the gen email generated SQL.
    ''' </summary>
    ''' <param name="SS">The ss.</param>
    Sub client_GenEmailGeneratedSQL(SS As String)
        If SS.Length > 0 Then
            Dim cw As New popSqlStmt(SS)
            cw.Show()
        Else
            MessageBox.Show("Error generating SQL : " + SS)
        End If
        'RemoveHandler ProxySearch.GenEmailGeneratedSQLCompleted, AddressOf client_GenEmailGeneratedSQL
    End Sub

    '********************************************************************************************************
    ''' <summary>
    ''' Handles the GenAttachmentSQL event of the click control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub click_GenAttachmentSQL(ByVal sender As Object, ByVal e As RoutedEventArgs)
        Dim ContainsClause As String = ""
        Dim isEmail As Boolean = True
        'AddHandler ProxySearch.GenEmailAttachmentsGeneratedSQLCompleted, AddressOf client_GenEmailAttachmentsSQL
        Dim SS As String = ProxySearch.GenEmailAttachmentsSQL(_UserGuid, ListOfSearchTerms.ToArray, gSecureID, txtSearch.Text, False, ckWeights.IsChecked, isEmail, False, Nothing, "", "", "MainPage")
        client_GenEmailAttachmentsSQL(SS)
    End Sub

    ''' <summary>
    ''' Clients the gen email attachments SQL.
    ''' </summary>
    ''' <param name="SS">The ss.</param>
    Sub client_GenEmailAttachmentsSQL(SS As String)
        If SS.Length > 0 Then
            Dim cw As New popSqlStmt(SS)
            cw.Show()
        Else
            MessageBox.Show("Error generating SQL : " + SS)
        End If
        'RemoveHandler ProxySearch.GenEmailAttachmentsGeneratedSQLCompleted, AddressOf client_GenEmailAttachmentsSQL
    End Sub

    '********************************************************************************************************
    ''' <summary>
    ''' Handles the ReviewSearchParms event of the click control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub click_ReviewSearchParms(ByVal sender As Object, ByVal e As RoutedEventArgs)
        Dim S As String = ""
        Dim tKey As String = ""
        Dim tVal As String = ""

        For Each sKey As String In dictMasterSearch.Keys
            tKey = sKey
            If dictMasterSearch.ContainsKey(tKey) Then
                tVal = dictMasterSearch.Item(tKey)
            Else
                dictMasterSearch.Add(tKey, tVal)
            End If

            S += tKey + " / " + tVal + vbCrLf
        Next

        'For I As Integer = 0 To ListOfSearchTerms.Count - 1
        '    tKey = ListOfSearchTerms.Item(I).Term
        '    tVal = ListOfSearchTerms.Item(I).TermVal
        '    S += tKey + " / " + tVal + vbCrLf
        'Next
        Dim cw As New popSqlStmt(S)
        cw.Show()
    End Sub

    '********************************************************************************************************
    '********************************************************************************************************

    'Private Sub SpellCK_Completed(ByVal sender As Object, ByVal e As CheckControlCompletedEventArgs)
    '    Console.WriteLine("Spell check completed: {0} errors found.", e.ErrorCount)
    '    SB.Text = "Spell check completed: " & e.ErrorCount & " errors found - State: " & _c1SpellChecker.MainDictionary.State & "."
    '    Dim xTxt As String = SB.Text
    '    If e.Cancelled Then
    '        SB.Text = "Spell check cancelled."
    '    End If
    '    'RemoveHandler _c1SpellChecker.CheckControlCompleted, AddressOf SpellCK_Completed
    'End Sub

    ''' <summary>
    ''' Handles the SelectionChanged event of the cbLibrary control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub cbLibrary_SelectionChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.SelectionChangedEventArgs) Handles cbLibrary.SelectionChanged
        COMMON.SaveClick(10002, gCurrUserGuidID)
        Dim LibraryName As String = cbLibrary.SelectedItem
        Console.WriteLine("Trace:10")
        If DoNotDoThis Then
            Return
        End If

        UdpateSearchTerm("ALL", "LibraryName", LibraryName, "S")

        'AddHandler ProxySearch.GetLibOwnerByNameCompleted, AddressOf client_GetLibOwnerByName
        LibraryOwnerGuid = ProxySearch.GetLibOwnerByName(gSecureID, LibraryName)
        client_GetLibOwnerByName(LibraryOwnerGuid)
    End Sub

    ''' <summary>
    ''' Reorders the email grid cols.
    ''' </summary>
    Sub ReorderEmailGridCols()

        Dim QuestionNumber As Integer = 0
        Dim QuestionText As String = ""
        Dim QuestionID As Integer = 0
        Dim TestTitle As String = ""
        Dim MultipleChoice As Boolean = False
        Dim CorrectAnswer As Integer = 0
        Dim CreateDate As Date = Nothing
        Dim LastModifiedDate As Date = Nothing
        Dim RowGuid As String = "" '** Default

        For iRows As Integer = 0 To dictEmailGridColDisplayOrder.Count - 1
            If dictEmailGridColDisplayOrder.ContainsKey(iRows) Then
                Dim iDisplayOrder As Integer = dictEmailGridColDisplayOrder.Keys(iRows)
                Dim ColumnName As String = dictEmailGridColDisplayOrder.Item(iDisplayOrder)
                ReorderDgEmailsCols(ColumnName, iDisplayOrder)
            End If
        Next

    End Sub

    ''' <summary>
    ''' Reorders the dg emails cols.
    ''' </summary>
    ''' <param name="ColName">Name of the col.</param>
    ''' <param name="ColDisplayOrder">The col display order.</param>
    Sub ReorderDgEmailsCols(ByVal ColName As String, ByVal ColDisplayOrder As Integer)

        'If gDebug Then
        '    Console.WriteLine("******************* ReorderDgEmailsCols *******************")
        '    For Each col As DataGridColumn In dgEmails.Columns
        '        Dim tgt As String = col.Header.ToString
        '        Console.WriteLine(", " + tgt)
        '    Next
        '    Console.WriteLine("******************* END OF LIST *******************")
        'End If


        Try
            Dim ColIdx As Integer = getColIdx(dgEmails, ColName)
            If ColIdx >= 0 Then
                Dim col As DataGridColumn = dgEmails.Columns(ColIdx)
                dgEmails.Columns.Remove(col)
                dgEmails.Columns.Insert(ColDisplayOrder, col)
            End If
        Catch ex As Exception
            SB.Text = ex.Message
        End Try

    End Sub

    ''' <summary>
    ''' Reorders the content grid cols.
    ''' </summary>
    Sub ReorderContentGridCols()
        Console.WriteLine("Trace:106")
        Dim QuestionNumber As Integer = 0
        Dim QuestionText As String = ""
        Dim QuestionID As Integer = 0
        Dim TestTitle As String = ""
        Dim MultipleChoice As Boolean = False
        Dim CorrectAnswer As Integer = 0
        Dim CreateDate As Date = Nothing
        Dim LastModifiedDate As Date = Nothing
        Dim RowGuid As String = "" '** Default

        For iRows As Integer = 0 To dictContentGridColDisplayOrder.Count - 1
            If dictContentGridColDisplayOrder.ContainsKey(iRows) Then
                Dim iDisplayOrder As Integer = dictContentGridColDisplayOrder.Keys(iRows)
                Dim ColumnName As String = dictContentGridColDisplayOrder.Item(iDisplayOrder)
                ReorderDgContentCols(ColumnName, iDisplayOrder)
            End If
        Next
    End Sub

    ''' <summary>
    ''' Reorders the dg content cols.
    ''' </summary>
    ''' <param name="ColName">Name of the col.</param>
    ''' <param name="ColDisplayOrder">The col display order.</param>
    Sub ReorderDgContentCols(ByVal ColName As String, ByVal ColDisplayOrder As Integer)
        Console.WriteLine("Trace:107")
        Try
            Dim ColIdx As Integer = getColIdx(dgContent, ColName)
            Dim col As DataGridColumn = dgContent.Columns(ColIdx)
            Console.WriteLine("Trace:107A")
            dgContent.Columns.Remove(col)
            dgContent.Columns.Insert(ColDisplayOrder, col)
        Catch ex As Exception
            Console.WriteLine("Trace:107B")
            SB.Text = ex.Message
        End Try

    End Sub

    ''' <summary>
    ''' Handles the Loaded event of the dgContent control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub dgContent_Loaded(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles dgContent.Loaded
        Console.WriteLine("Trace:11")

        For Each col As DataGridColumn In dgContent.Columns
            Dim tgt As String = col.Header.ToString
            Console.WriteLine(", " + tgt)
        Next
        If DoNotDoThis Then
            Return
        End If
        ReorderContentGridCols()
        getSavedContentGridColumnsDisplayOrder()
    End Sub

    ''' <summary>
    ''' Handles the Loaded event of the dgEmails control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub dgEmails_Loaded(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles dgEmails.Loaded
        Console.WriteLine("Trace:11A")
        If gDebug Then
            Console.WriteLine("************** dgEmails_Loaded ***************************")
            For Each col As DataGridColumn In dgEmails.Columns
                Dim tgt As String = col.Header.ToString
                Console.WriteLine(", " + tgt)
            Next
            Console.WriteLine("************** END OF LIST ***************************")
        End If



        ReorderEmailGridCols()
        getSavedEmailGridColumnsDisplayOrder()

        setEmailColumnWidths()

    End Sub

    ''' <summary>
    ''' Handles the Unloaded event of the LayoutRoot control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub LayoutRoot_Unloaded(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles LayoutRoot.Unloaded
        Console.WriteLine("Trace:12")
        If DoNotDoThis Then
            Return
        End If

        SaveGridColumnOrder(dgEmails, dictEmailGridColDisplayOrder)
        SaveGridColumnOrder(dgContent, dictEmailGridColDisplayOrder)

        SaveGridLayoutToDB(dgContent)
        SaveGridLayoutToDB(dgEmails)
    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the ckMyContent control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckMyContent_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckMyContent.Unchecked
        Console.WriteLine("Trace:13")
        If DoNotDoThis Then
            Return
        End If

        UdpateSearchTerm("ALL", "ckMyContent", ckMyContent.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the ckMasterOnly control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckMasterOnly_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckMasterOnly.Unchecked
        Console.WriteLine("Trace:14")
        If DoNotDoThis Then
            Return
        End If

        UdpateSearchTerm("ALL", "ckMasterOnly", ckMasterOnly.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the nbrWeightMin control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub nbrWeightMin_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles nbrWeightMin.TextChanged
        Console.WriteLine("Trace:15")
        If DoNotDoThis Then
            Return
        End If

        UdpateSearchTerm("ALL", "nbrWeightMin", nbrWeightMin.Text, "S")
    End Sub

    ''' <summary>
    ''' Handles the Checked event of the ckMasterOnly control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckMasterOnly_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckMasterOnly.Checked
        Console.WriteLine("Trace:16")
        If DoNotDoThis Then
            Return
        End If

        UdpateSearchTerm("ALL", "ckMasterOnly", ckMasterOnly.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the Checked event of the ckMyContent control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckMyContent_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckMyContent.Checked
        Console.WriteLine("Trace:17")
        If DoNotDoThis Then
            Return
        End If

        UdpateSearchTerm("ALL", "ckMyContent", ckMyContent.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the 1 event of the rbEmails_Checked control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub rbEmails_Checked_1(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles rbEmails.Checked
        Console.WriteLine("Trace:18")
        If DoNotDoThis Then
            Return
        End If

        setTabsOpenClosed()

    End Sub

    ''' <summary>
    ''' Handles the 1 event of the rbContent_Checked control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub rbContent_Checked_1(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles rbContent.Checked
        Console.WriteLine("Trace:19")
        If DoNotDoThis Then
            Return
        End If

        setTabsOpenClosed()

    End Sub

    ''' <summary>
    ''' Handles the Checked event of the ckWeights control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckWeights_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckWeights.Checked
        Console.WriteLine("Trace:20")
        If DoNotDoThis Then
            Return
        End If

        UdpateSearchTerm("ALL", "ckWeights", ckWeights.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the Checked event of the ckLimitToLib control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckLimitToLib_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckLimitToLib.Checked

        Console.WriteLine("Trace:21")
        If DoNotDoThis Then
            Return
        End If
        ckMyContent.IsChecked = False
        ckMasterOnly.IsChecked = False
        ckMyContent.IsEnabled = False
        ckMasterOnly.IsEnabled = False
        UdpateSearchTerm("ALL", "ckLimitToLib", ckLimitToLib.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the 1 event of the ckFilters_Checked control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckFilters_Checked_1(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckFilters.Checked
        Console.WriteLine("Trace:22")
        'If DoNotDoThis Then
        '    SetFilterVisibility()
        '    Return
        'End If

        'populateLibraryComboBox

        UdpateSearchTerm("ALL", "ckFilters", ckFilters.IsChecked, "B")
        COMMON.SaveClick(10003, gCurrUserGuidID)
        SetFilterVisibility()
    End Sub

    ''' <summary>
    ''' Handles the Checked event of the ckSetEmailPublic control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckSetEmailPublic_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckSetEmailPublic.Checked
        Console.WriteLine("Trace:23")
        If DoNotDoThis Then
            Return
        End If

        UdpateSearchTerm("ALL", "ckSetEmailPublic", ckSetEmailPublic.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the ckSetEmailPublic control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckSetEmailPublic_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckSetEmailPublic.Unchecked
        Console.WriteLine("Trace:24")
        If DoNotDoThis Then
            Return
        End If

        UdpateSearchTerm("ALL", "ckSetEmailPublic", ckSetEmailPublic.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the txtSearch control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub txtSearch_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtSearch.TextChanged
        Console.WriteLine("Trace:25")
        If DoNotDoThis Then
            Return
        End If

        UdpateSearchTerm("ALL", "txtSearch", txtSearch.Text, "S")
    End Sub

    ''' <summary>
    ''' Handles the Checked event of the ckShowDetails control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckShowDetails_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckShowDetails.Checked
        Console.WriteLine("Trace:26")
        If DoNotDoThis Then
            Return
        End If

        UdpateSearchTerm("ALL", "ckShowDetails", ckShowDetails.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the ckShowDetails control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckShowDetails_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckShowDetails.Unchecked
        Console.WriteLine("Trace:27")
        If DoNotDoThis Then
            Return
        End If

        UdpateSearchTerm("ALL", "ckShowDetails", ckShowDetails.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the SBDoc control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub SBDoc_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles SBDoc.TextChanged
        Console.WriteLine("Trace:28")
        If DoNotDoThis Then
            Return
        End If

        UdpateSearchTerm("ALL", "SBDoc", SBDoc.Text, "S")
    End Sub

    ''' <summary>
    ''' Contents the search parms set.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function contentSearchParmsSet() As Boolean
        Dim B As Boolean = False
        For Each sVal As String In dictMasterSearch.Values
            If InStr(sVal, "content.", Microsoft.VisualBasic.CompareMethod.Text) > 0 Then
                B = True
                Exit For
            End If
        Next
        Return B
    End Function

    ''' <summary>
    ''' Emails the search parms set.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Function emailSearchParmsSet() As Boolean
        Dim B As Boolean = False
        For Each sVal As String In dictMasterSearch.Values
            If InStr(sVal, "email.", Microsoft.VisualBasic.CompareMethod.Text) > 0 Then
                B = True
                Exit For
            End If
        Next
        Return B
    End Function

    ''' <summary>
    ''' Handles the Click event of the hlAlerts control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub hlAlerts_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlAlerts.Click
        Console.WriteLine("Trace:29")
        If DoNotDoThis Then
            Return
        End If

        If Not _isAdmin Then
            MessageBox.Show("Admin rights required to execute this function, please get an ADMIN to set this up.")
            Return
        End If

        Dim cw As New popupAlerts
        cw.Show()
    End Sub

    ''' <summary>
    ''' Sets the notification flags.
    ''' </summary>
    Sub setNotificationFlags()
        lblIsPublicShow.Visibility = Visibility.Visible
        LblIsWebShow.Visibility = Visibility.Visible
        LblCkIsMasterShow.Visibility = Visibility.Visible
        lblStructuredData.Visibility = Visibility.Visible
        lblSharePoint.Visibility = Visibility.Visible
        lblSap.Visibility = Visibility.Visible
    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the ckWeights control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckWeights_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs)
        Console.WriteLine("Trace:30")
        If DoNotDoThis Then
            Return
        End If

        UdpateSearchTerm("ALL", "ckWeights", ckWeights.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the 1 event of the rbContent_Unchecked control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub rbContent_Unchecked_1(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs)
        Console.WriteLine("Trace:31")
        If DoNotDoThis Then
            Return
        End If

        UdpateSearchTerm("ALL", "rbContent", rbContent.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the rbAll control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub rbAll_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles rbAll.Unchecked
        Console.WriteLine("Trace:32")
        If DoNotDoThis Then
            Return
        End If

        UdpateSearchTerm("ALL", "rbAll", rbAll.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the 2 event of the rbContent_Unchecked control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub rbContent_Unchecked_2(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles rbContent.Unchecked
        Console.WriteLine("Trace:33")
        If DoNotDoThis Then
            Return
        End If
        UdpateSearchTerm("ALL", "rbContent", rbContent.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the 1 event of the ckWeights_Unchecked control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckWeights_Unchecked_1(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs)
        Console.WriteLine("Trace:34")
        If DoNotDoThis Then
            Return
        End If
        UdpateSearchTerm("ALL", "ckWeights", ckWeights.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the ckLimitToLib control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckLimitToLib_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckLimitToLib.Unchecked

        Console.WriteLine("Trace:35")
        If DoNotDoThis Then
            Return
        End If
        ckMyContent.IsEnabled = True
        ckMasterOnly.IsEnabled = True
        UdpateSearchTerm("ALL", "ckLimitToLib", ckLimitToLib.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the 2 event of the ckWeights_Unchecked control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckWeights_Unchecked_2(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckWeights.Unchecked
        Console.WriteLine("Trace:36")
        If DoNotDoThis Then
            Return
        End If
        UdpateSearchTerm("ALL", "ckWeights", ckWeights.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Exports the search to file to CSV.
    ''' </summary>
    Sub ExportSearchToFileToCsv()
        'Dim path As String = _UserID + ".Export.csv"
        'dgContent.Save(_UserID + ".Export", C1.Silverlight.FlexGrid.FileFormat.Csv)
        Dim msg As String = grid.ExportGridToCSV(dgContent, UserID)
        MessageBox.Show(msg)
    End Sub

    ''' <summary>
    ''' Exports the search to file to HTML.
    ''' </summary>
    Sub ExportSearchToFileToHtml()
        Console.WriteLine("Trace:37")
        If DoNotDoThis Then
            Return
        End If
        Dim msg As String = grid.ExportGridToHTML(dgContent, UserID)
        MessageBox.Show(msg)
    End Sub

    ''' <summary>
    ''' Exports the search to file to text.
    ''' </summary>
    Sub ExportSearchToFileToText()
        Console.WriteLine("Trace:38")
        If DoNotDoThis Then
            Return
        End If
        Dim msg As String = grid.ExportGridToTEXT(dgContent, UserID)
        MessageBox.Show(msg)
    End Sub

    ''' <summary>
    ''' Handles the Click event of the HyperlinkButton1 control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub HyperlinkButton1_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles HyperlinkButton1.Click
        Console.WriteLine("Trace:39")
        If DoNotDoThis Then
            Return
        End If
        ISO.RequestMoreIso()
    End Sub

    ''' <summary>
    ''' Handles the 1 event of the hlLibrary_Click control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub hlLibrary_Click_1(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlLibrary.Click
        Console.WriteLine("Trace:40")
        If DoNotDoThis Then
            Return
        End If

        COMMON.SaveClick(10004, gCurrUserGuidID)
        Dim NextPage As New PageLibrary()
        'NextPage.show

        NextPage.Show()

    End Sub

    ''' <summary>
    ''' Handles the Click event of the hlSaveSearch control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub hlSaveSearch_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlSaveSearch.Click
        Console.WriteLine("Trace:41")
        If DoNotDoThis Then
            Return
        End If

        Dim cw As New popupSaveSearch()
        'Me.Content = cw
        cw.ShowDialog()

    End Sub

    ''' <summary>
    ''' Handles the Closed event of the popupSaveSearch control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
    Private Sub popupSaveSearch_Closed(ByVal sender As System.Object, ByVal e As EventArgs)
        Dim lw As popupSaveSearch = CType(sender, popupSaveSearch)

        If ApplyRecalledSearch = True Then
            SB.Text = "Recall of saved search applied."
            QuickSearchRecall(0, True)
        Else
            SB.Text = "Recall of saved search cancelled."
        End If

        GC.Collect()
        GC.WaitForPendingFinalizers()

    End Sub

    ''' <summary>
    ''' Handles the Click event of the hlHelp control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub hlHelp_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlHelp.Click
        Console.WriteLine("Trace:42")
        If DoNotDoThis Then
            Return
        End If
        Dim HelpURL As String = "HTTP://www.EcmLibrary.com/HelpSaas/EcmSaasIndex.htm"
        'HtmlPage.Window.Navigate(New Uri(HelpURL, UriKind.Absolute), "_blank")
        Process.Start(HelpURL)

    End Sub

    ''' <summary>
    ''' Quicks the search add.
    ''' </summary>
    Sub QuickSearchAdd()

        Dim SearchParms As String = PRM.BuildParmString(dictMasterSearch)

        Dim CurrentQuickSearch As Integer = ListOfQuickSearch.Count
        If CurrentQuickSearch >= MaxQuickSearchEntry Then
            ListOfQuickSearch.RemoveAt(0)
            ListOfQuickSearch.Add(SearchParms)
        Else
            ListOfQuickSearch.Add(SearchParms)
        End If

        DoNotApplyQuickSearch = True

        lblMain.Content = CurrentQuickSearch

        If nbrExecutedSearches >= 2 Then
            'SearchHistorySave()
            nbrExecutedSearches = 1
        End If

        DoNotApplyQuickSearch = False

    End Sub

    ''' <summary>
    ''' Quicks the search recall.
    ''' </summary>
    ''' <param name="IdNumber">The identifier number.</param>
    ''' <param name="bRetrieveSavedSearch">if set to <c>true</c> [b retrieve saved search].</param>
    Sub QuickSearchRecall(ByVal IdNumber As Integer, ByVal bRetrieveSavedSearch As Boolean)
        Console.WriteLine("Trace:43")
        If DoNotDoThis Then
            Return
        End If

        If IdNumber >= ListOfQuickSearch.Count Then
            SB.Text = "There are no more items in the SEARCH history list."
            Return
        End If

        bQuickSearchRecall = True

        Dim SearchParms As String = ""
        Dim sVal As String = ""
        Dim ItemFound As Boolean = False
        Dim TempDict As Dictionary(Of String, String) = dictMasterSearch
        If Not bRetrieveSavedSearch Then
            If ListOfQuickSearch.Count >= IdNumber Then
                SearchParms = ListOfQuickSearch(IdNumber)
            Else
                SB.Text = "No previous search exists for item #:" + IdNumber.ToString
                lblMain.Content = lblMain.Content - 1
            End If
            PRM.ReBuildParmDist(SearchParms, dictMasterSearch)
        End If
        Try
            For Each sKey As String In TempDict.Keys
                Try
                    sVal = TempDict.Item(sKey)
                    ItemFound = True
                Catch ex As Exception
                    ItemFound = False
                End Try
                If ItemFound Then

                    If sKey.Equals("DocLowerPageNbr") Then
                        DocLowerPageNbr = CInt(sVal)
                    End If
                    If sKey.Equals("DocUpperPageNbr") Then
                        DocUpperPageNbr = CInt(sVal)
                    End If
                    If sKey.Equals("EmailLowerPageNbr") Then
                        EmailLowerPageNbr = CInt(sVal)
                    End If
                    If sKey.Equals("EmailUpperPageNbr") Then
                        EmailUpperPageNbr = CInt(sVal)
                    End If
                    If sKey.Equals("txtSearch") Then
                        txtSearch.Text = sVal
                    End If
                    'If sKey.Equals("txtSelDir") Then
                    '    txtSelDir = sVal
                    'End If
                    If sKey.Equals("cbLibrary") Then
                        Try
                            cbLibrary.SelectedItem = sVal
                        Catch ex As Exception
                            Console.WriteLine("Exception xx1a: " + ex.Message)
                        End Try
                    End If
                    If sKey.Equals("nbrWeightMin") Then
                        nbrWeightMin.Text = sVal
                    End If
                    If sKey.Equals("rbAll") Then
                        If sVal.Equals("True") Then
                            rbAll.IsChecked = True
                        Else
                            rbAll.IsChecked = False
                        End If
                    End If
                    If sKey.Equals("rbContent") Then
                        If sVal.Equals("True") Then
                            rbContent.IsChecked = True
                        Else
                            rbContent.IsChecked = False
                        End If
                    End If
                    If sKey.Equals("rbEmails") Then
                        If sVal.Equals("True") Then
                            rbEmails.IsChecked = True
                        Else
                            rbEmails.IsChecked = False
                        End If
                    End If
                    If sKey.Equals("ckLimitToLib") Then
                        If sVal.Equals("True") Then
                            ckLimitToLib.IsChecked = True
                        Else
                            ckLimitToLib.IsChecked = False
                        End If
                    End If
                    If sKey.Equals("ckMyContent") Then
                        If sVal.Equals("True") Then
                            ckMyContent.IsChecked = True
                        Else
                            ckMyContent.IsChecked = False
                        End If
                    End If
                    If sKey.Equals("ckMasterOnly") Then
                        If sVal.Equals("True") Then
                            ckMasterOnly.IsChecked = True
                        Else
                            ckMasterOnly.IsChecked = False
                        End If
                    End If
                    If sKey.Equals("ckWeights") Then
                        If sVal.Equals("True") Then
                            ckWeights.IsChecked = True
                        Else
                            ckWeights.IsChecked = False
                        End If
                    End If
                    'If sKey.Equals("ckWeights") Then
                    '    If sVal.Equals("True") Then
                    '        ckWeights.IsChecked = True
                    '    Else
                    '        ckWeights.IsChecked = False
                    '    End If
                    'End If
                    'ValName = "lblMain"
                    If sKey.Equals("ckFilters") Then
                        If sVal.Equals("True") Then
                            ckFilters.IsChecked = True
                        Else
                            ckFilters.IsChecked = False
                        End If
                    End If
                    If sKey.Equals("SBEmail") Then
                        SBEmail.Text = sVal
                    End If
                    If sKey.Equals("SBDoc") Then
                        SBDoc.Text = sVal
                    End If
                    If sKey.Equals("SB") Then
                        SB.Text = sVal
                    End If
                End If
            Next
        Catch ex As Exception
            Console.WriteLine("ERROR XXX1 - " + ex.Message)
        End Try
        bQuickSearchRecall = False
    End Sub

    ''' <summary>
    ''' Searches the history save.
    ''' </summary>
    Sub SearchHistorySave()

        Dim SearchName As String = _UserID + "-$$QuickSearch"
        Dim QuickSearchHistory As String = ""

        For Each S As String In ListOfQuickSearch
            QuickSearchHistory += S + ChrW(252)
        Next
        QuickSearchHistory = QuickSearchHistory.Replace("'", "''")

        ProxySearch.SaveUserSearchAsync(_SecureID, SearchName, _UserID, QuickSearchHistory)

    End Sub

    ''' <summary>
    ''' Clients the ck content flags completed.
    ''' </summary>
    ''' <param name="gSecureID">The g secure identifier.</param>
    ''' <param name="CurrentGuid">The current unique identifier.</param>
    ''' <param name="SD">if set to <c>true</c> [sd].</param>
    ''' <param name="SP">if set to <c>true</c> [sp].</param>
    ''' <param name="SAP">if set to <c>true</c> [sap].</param>
    ''' <param name="bMaster">if set to <c>true</c> [b master].</param>
    ''' <param name="RSS">if set to <c>true</c> [RSS].</param>
    ''' <param name="WEB">if set to <c>true</c> [web].</param>
    ''' <param name="PUB">if set to <c>true</c> [pub].</param>
    Sub client_ckContentFlagsCompleted(gSecureID As Integer, CurrentGuid As String, SD As Boolean, SP As Boolean, SAP As Boolean, bMaster As Boolean, RSS As Boolean, WEB As Boolean, PUB As Boolean)
        bQuickSearchRecall = True
        Dim RC As Boolean = True
        If RC Then
            If bMaster Then
                LblCkIsMasterShow.Visibility = Windows.Visibility.Visible
                ckMakeMasterDoc.IsChecked = True
            Else
                LblCkIsMasterShow.Visibility = Windows.Visibility.Collapsed
                ckMakeMasterDoc.IsChecked = False
            End If
            If RSS Then
                lblRssPull.Visibility = Windows.Visibility.Visible
            Else
                lblRssPull.Visibility = Windows.Visibility.Collapsed
            End If
            If SAP Then
                lblSap.Visibility = Windows.Visibility.Visible
            Else
                lblSap.Visibility = Windows.Visibility.Collapsed
            End If
            If SD Then
                lblStructuredData.Visibility = Windows.Visibility.Visible
            Else
                lblStructuredData.Visibility = Windows.Visibility.Collapsed
            End If
            If SP Then
                lblSharePoint.Visibility = Windows.Visibility.Visible
            Else
                lblSharePoint.Visibility = Windows.Visibility.Collapsed
            End If
            If WEB Then
                LblIsWebShow.Visibility = Windows.Visibility.Visible
            Else
                LblIsWebShow.Visibility = Windows.Visibility.Collapsed
            End If
            If PUB Then
                lblIsPublicShow.Visibility = Windows.Visibility.Visible
                ckMakeIsPublic.IsChecked = True
            Else
                ckMakeIsPublic.IsChecked = False
                lblIsPublicShow.Visibility = Windows.Visibility.Collapsed
            End If
        Else
            LblCkIsMasterShow.Visibility = Windows.Visibility.Collapsed
            lblRssPull.Visibility = Windows.Visibility.Collapsed
            lblSap.Visibility = Windows.Visibility.Collapsed
            lblStructuredData.Visibility = Windows.Visibility.Collapsed
            lblSharePoint.Visibility = Windows.Visibility.Collapsed
            LblIsWebShow.Visibility = Windows.Visibility.Collapsed
            lblIsPublicShow.Visibility = Windows.Visibility.Collapsed
            ckMakeIsPublic.IsChecked = False
            ckMakeMasterDoc.IsChecked = False
        End If
        bQuickSearchRecall = False
    End Sub

    ''' <summary>
    ''' Clients the search history save.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    Sub client_SearchHistorySave(RC As Boolean)
        If RC Then
            SB.Text = "Your search has been saved."
            FormLoaded = True
        Else
            AttachmentWeights = Nothing
        End If
        ''RemoveHandler ProxySearch.SaveUserSearchCompleted, AddressOf client_SearchHistorySave
    End Sub

    ''' <summary>
    ''' Searches the history reload.
    ''' </summary>
    Sub SearchHistoryReload()

        Dim SearchName As String = _UserID + "-$$QuickSearch"
        Dim SearchParms As String = ""

        'AddHandler ProxySearch.RecallUserSearchCompleted, AddressOf client_RecallSearch
        Dim BB As Boolean = ProxySearch.RecallUserSearch(_SecureID, SearchName, _UserID, SearchParms)
        client_RecallSearch(BB, SearchParms)

    End Sub

    ''' <summary>
    ''' Clients the recall search.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="strSearches">The string searches.</param>
    Sub client_RecallSearch(RC As Boolean, strSearches As String)
        If RC Then
            If RC Then
                If strSearches.Length > 0 Then
                    DoNotApplyQuickSearch = True
                    ListOfQuickSearch.Clear()
                    Dim SearchParms() As String = Nothing
                    Dim QuickSearchHistory As String = strSearches
                    SearchParms = QuickSearchHistory.Split(ChrW(252))
                    For Each sSearch As String In SearchParms
                        ListOfQuickSearch.Add(sSearch)
                    Next
                    'QuickSearchRecall(9999, True)
                    lblMain.Content = (ListOfQuickSearch.Count - 1).ToString
                Else
                    lblMain.Content = 0
                End If
            Else
                SB.Text = "Failed to save your search."
            End If
            FormLoaded = True
        Else
            AttachmentWeights = Nothing
        End If
        DoNotApplyQuickSearch = False
        'RemoveHandler ProxySearch.RecallUserSearchCompleted, AddressOf client_RecallSearch
    End Sub

    ''' <summary>
    ''' Handles the Checked event of the ckSetEmailAsDefault control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckSetEmailAsDefault_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckSetEmailAsDefault.Checked
        Console.WriteLine("Trace:44")
        If DoNotDoThis Then
            Return
        End If

        Dim S As String = ""

        S += "if not exists (Select ParmName from UserCurrParm where UserID = '" + _UserID + "' and ParmName = 'uDefaultScreen')" + vbCrLf
        S += "INSERT INTO [UserCurrParm]" + vbCrLf
        S += "           ([UserID]" + vbCrLf
        S += "           ,[ParmName]" + vbCrLf
        S += "           ,[ParmVal]" + vbCrLf
        S += "           )" + vbCrLf
        S += "     VALUES" + vbCrLf
        S += "           ('" + _UserID + "'" + vbCrLf
        S += "           ,'uDefaultScreen'" + vbCrLf
        S += "           ,'EMAIL'" + vbCrLf
        S += "           )" + vbCrLf
        S += "ELSE" + vbCrLf
        S += "UPDATE [UserCurrParm]" + vbCrLf
        S += "   SET " + vbCrLf
        S += "      [ParmVal] = 'EMAIL'" + vbCrLf
        S += " WHERE [UserID] = '" + _UserID + "'" + vbCrLf
        S += "       and [ParmName] = 'uDefaultScreen'" + vbCrLf

        If ContractID.Length > 0 Then
            Try
                S = ENC.AES256EncryptString(S)
                Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(gSecureID, S, _UserID, ContractID)
                client_ExecuteSqlSelectScreen(BB, ENC.AES256DecryptString(S))
            Catch ex As Exception
                Console.WriteLine("ERROR - ckSetEmailAsDefault_Checked 222a: " + ex.Message)
            End Try

        End If
    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the ckSetEmailAsDefault control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckSetEmailAsDefault_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckSetEmailAsDefault.Unchecked
        Console.WriteLine("Trace:45")
        If DoNotDoThis Then
            Return
        End If

        Dim S As String = ""

        S += "if not exists (Select ParmName from UserCurrParm where UserID = '" + _UserID + "' and ParmName = 'uDefaultScreen')" + vbCrLf
        S += "INSERT INTO [UserCurrParm]" + vbCrLf
        S += "           ([UserID]" + vbCrLf
        S += "           ,[ParmName]" + vbCrLf
        S += "           ,[ParmVal]" + vbCrLf
        S += "           )" + vbCrLf
        S += "     VALUES" + vbCrLf
        S += "           ('" + _UserID + "'" + vbCrLf
        S += "           ,'uDefaultScreen'" + vbCrLf
        S += "           ,'CONTENT'" + vbCrLf
        S += "           )" + vbCrLf
        S += "ELSE" + vbCrLf
        S += "UPDATE [UserCurrParm]" + vbCrLf
        S += "   SET " + vbCrLf
        S += "      [ParmVal] = 'CONTENT'" + vbCrLf
        S += " WHERE [UserID] = '" + _UserID + "'" + vbCrLf
        S += "       and [ParmName] = 'uDefaultScreen'" + vbCrLf

        If ContractID.Length > 0 Then
            Try
                S = ENC.AES256EncryptString(S)
                Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(gSecureID, S, _UserID, ContractID)
                client_ExecuteSqlSelectScreen(BB, ENC.AES256DecryptString(S))
            Catch ex As Exception
                Console.WriteLine("ERROR ckSetEmailAsDefault_Unchecked 231s: " + ex.Message)
            End Try


        End If
    End Sub

    ''' <summary>
    ''' Clients the execute SQL select screen.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="S">The s.</param>
    Sub client_ExecuteSqlSelectScreen(RC As Boolean, S As String)

        If RC Then
            SB.Text = "Successful execution"
            SetDefaultScreen()
        Else
            SB.Text = "Unsuccessful execution"
            gErrorCount += 1
            LOG.WriteToSqlLog("ERROR 240.99.1 ExecuteSql: " + S)
        End If
        ''RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlSelectScreen
    End Sub

    ''' <summary>
    ''' Sets the default screen.
    ''' </summary>
    Sub SetDefaultScreen()

        'AddHandler ProxySearch.getDefaultScreenCompleted, AddressOf client_getDefaultScreen
        Dim SS As String = ProxySearch.getDefaultScreen(_SecureID, _UserID)
        client_getDefaultScreen(SS)

    End Sub

    ''' <summary>
    ''' Clients the get default screen.
    ''' </summary>
    ''' <param name="SS">The ss.</param>
    Sub client_getDefaultScreen(SS As String)

        If RC Then
            Dim DefaultScreen As String = SS.ToUpper
            If DefaultScreen.Equals("EMAIL") Then
                TabEmail.IsSelected = True
            Else
                TabContent.IsSelected = True
            End If
        Else
            SB.Text = "Could not set the default screen"
            gErrorCount += 1

        End If

        'RemoveHandler ProxySearch.getDefaultScreenCompleted, AddressOf client_getDefaultScreen

    End Sub

    ''' <summary>
    ''' Handles the MouseEnter event of the lblUserID control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Input.MouseEventArgs"/> instance containing the event data.</param>
    Private Sub lblUserID_MouseEnter(ByVal sender As System.Object, ByVal e As System.Windows.Input.MouseEventArgs) Handles lblUserID.MouseEnter
        lblUserID.Content = _UserGuid
    End Sub

    ''' <summary>
    ''' Handles the 1 event of the lblUserID_MouseLeave control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Input.MouseEventArgs"/> instance containing the event data.</param>
    Private Sub lblUserID_MouseLeave_1(ByVal sender As System.Object, ByVal e As System.Windows.Input.MouseEventArgs) Handles lblUserID.MouseLeave
        lblUserID.Content = _UserID
    End Sub

    ''' <summary>
    ''' Handles the Checked event of the ckMakeIsPublic control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckMakeIsPublic_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckMakeIsPublic.Checked
        Console.WriteLine("Trace:46")
        If DoNotDoThis Then
            Return
        End If

        Dim S As String = "Update DataSource set isPublic = 'Y' where SourceGuid = '" + CurrentGuid + "' "
        S = ENC.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, _UserID, ContractID)
        gLogSQL(BB, ENC.AES256DecryptString(S))

        UdpateSearchTerm("ALL", "ckMakeIsPublic", ckMakeIsPublic.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the UnChecked event of the ckMakeIsPublic control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckMakeIsPublic_UnChecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckMakeIsPublic.Unchecked
        Console.WriteLine("Trace:47")
        If DoNotDoThis Then
            Return
        End If

        Dim S As String = "Update DataSource set isPublic = 'N' where SourceGuid = '" + CurrentGuid + "' "
        S = ENC.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, _UserID, ContractID)
        gLogSQL(BB, ENC.AES256DecryptString(S))

        UdpateSearchTerm("ALL", "ckMakeIsPublic", ckMakeIsPublic.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the Checked event of the ckMakeMasterDoc control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckMakeMasterDoc_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckMakeMasterDoc.Checked
        Console.WriteLine("Trace:48")
        If DoNotDoThis Then
            Return
        End If

        Dim S As String = "Update DataSource set isMaster = 'Y' where SourceGuid = '" + CurrentGuid + "' "
        S = ENC.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, _UserID, ContractID)
        gLogSQL(BB, ENC.AES256DecryptString(S))

        UdpateSearchTerm("ALL", "ckMakeMasterDoc", ckMakeMasterDoc.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the ckMakeMasterDoc control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckMakeMasterDoc_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckMakeMasterDoc.Unchecked

        Console.WriteLine("Trace:49")
        If DoNotDoThis Then
            Return
        End If

        Dim S As String = "Update DataSource set isMaster = 'N' where SourceGuid = '" + CurrentGuid + "' "
        S = ENC.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, _UserID, ContractID)
        gLogSQL(BB, ENC.AES256DecryptString(S))

        UdpateSearchTerm("ALL", "ckMakeMasterDoc", ckMakeMasterDoc.IsChecked, "B")
    End Sub

    ''' <summary>
    ''' Handles the MouseEnter event of the HyperlinkButton3 control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="MouseEventArgs"/> instance containing the event data.</param>
    Private Sub HyperlinkButton3_MouseEnter(sender As Object, e As MouseEventArgs) Handles HyperlinkButton3.MouseEnter
        SB.Text = "In order to Archive content, you will need access to the Archive Application"
    End Sub

    ''' <summary>
    ''' Handles the MouseLeave event of the HyperlinkButton3 control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="MouseEventArgs"/> instance containing the event data.</param>
    Private Sub HyperlinkButton3_MouseLeave(sender As Object, e As MouseEventArgs) Handles HyperlinkButton3.MouseLeave
        SB.Text = " "
    End Sub

    'Private Sub hlDownLoadCLC_MouseEnter(sender As Object, e As MouseEventArgs) Handles hlDownLoadCLC.MouseEnter
    '    SB.Text = ClcURL
    'End Sub

    'Private Sub hlDownLoadCLC_MouseLeave(sender As Object, e As MouseEventArgs) Handles hlDownLoadCLC.MouseLeave
    '    SB.Text = " "
    'End Sub

    ''' <summary>
    ''' Builds the search parameters.
    ''' </summary>
    Sub BuildSearchParameters()

        Dim SearchText As String = txtSearch.Text.Trim
        Dim LowerPageNumber As Integer = 0
        Dim UpperPageNumber As Integer = PageRowLimit
        Dim iWeightMin As Integer = CInt(nbrWeightMin.Text)
        Dim AutoSql As String = ""

        bStartNewSearch = False

        If bStartNewSearch Then
            UdpateSearchTerm("ALL", "isSuperAdmin", _isSuperAdmin.ToString, "B")
            UdpateSearchTerm("ALL", "isAdmin", _isAdmin.ToString, "B")
            UdpateSearchTerm("ALL", "isGlobalSearcher", _isGlobalSearcher.ToString, "B")

            UdpateSearchTerm("ALL", "CalledFromScreen", Me.Title, "S")
            UdpateSearchTerm("ALL", "UID", CurrUserGuidID, "S")

            UdpateSearchTerm("ALL", "CurrUserGuidID", CurrUserGuidID.Trim, "S")
            UdpateSearchTerm("ALL", "CurrLoginID", CurrLoginID.Trim, "S")
            UdpateSearchTerm("ALL", "UID", CurrUserGuidID.Trim, "S")

            UdpateSearchTerm("ALL", "txtSearch", SearchText.Trim, "S")
            UdpateSearchTerm("ALL", "bNeedRowCount", bNeedRowCount.ToString, "B")
            UdpateSearchTerm("ALL", "rbAll", rbAll.IsChecked.ToString, "B")
            UdpateSearchTerm("ALL", "rbEmails", rbEmails.IsChecked.ToString, "B")
            UdpateSearchTerm("ALL", "rbContent", rbContent.IsChecked.ToString, "B")
            UdpateSearchTerm("ALL", "ckWeights", ckWeights.IsChecked.ToString, "B")
            UdpateSearchTerm("ALL", "ckLimitToLib", ckLimitToLib.IsChecked.ToString, "B")
            UdpateSearchTerm("ALL", "cbLibrary", cbLibrary.SelectedItem, "S")
            UdpateSearchTerm("ALL", "MinWeight", iWeightMin.ToString, "I")
            UdpateSearchTerm("ALL", "LowerPageNbr", LowerPageNumber.ToString, "I")
            UdpateSearchTerm("ALL", "UpperPageNbr", UpperPageNumber.ToString, "I")
            UdpateSearchTerm("ALL", "GeneratedSql", AutoSql, "S")
            UdpateSearchTerm("ALL", "CurrentDocPage", CurrentDocPage.ToString, "I")
            UdpateSearchTerm("ALL", "CurrentEmailPage", CurrentEmailPage.ToString, "I")
            UdpateSearchTerm("ALL", "StartingEmailRow", "0", "I")
            UdpateSearchTerm("ALL", "EndingEmailRow", UpperPageNumber.ToString, "I")
            UdpateSearchTerm("ALL", "StartingContentRow", "0", "I")
            UdpateSearchTerm("ALL", "EndingContentRow", UpperPageNumber.ToString, "I")

            UpdateState(True, 0, PageRowLimit, 0, PageRowLimit)
        Else

            UdpateSearchTerm("ALL", "CurrUserGuidID", CurrUserGuidID.Trim, "S")
            UdpateSearchTerm("ALL", "CurrLoginID", CurrLoginID.Trim, "S")
            UdpateSearchTerm("ALL", "UID", CurrUserGuidID.Trim, "S")

            UdpateSearchTerm("ALL", "isSuperAdmin", _isSuperAdmin.ToString, "B")
            UdpateSearchTerm("ALL", "isAdmin", _isAdmin.ToString, "B")
            UdpateSearchTerm("ALL", "isGlobalSearcher", _isGlobalSearcher.ToString, "B")

            UdpateSearchTerm("ALL", "txtSearch", SearchText.Trim, "S")
            UdpateSearchTerm("ALL", "ckWeights", ckWeights.IsChecked.ToString, "B")

            LowerPageNumber += PageRowLimit
            UpperPageNumber += PageRowLimit
            UdpateSearchTerm("ALL", "LowerPageNbr", LowerPageNumber.ToString, "I")
            UdpateSearchTerm("ALL", "UpperPageNbr", UpperPageNumber.ToString, "I")

            If bEmailScrolling Then
                UpdateState(True, dgEmails.Items.Count, dgEmails.Items.Count + PageRowLimit, dgContent.Items.Count, dgContent.Items.Count)
                UdpateSearchTerm("ALL", "rbAll", "False", "B")
                UdpateSearchTerm("ALL", "rbEmails", "True", "B")
                UdpateSearchTerm("ALL", "rbContent", "False", "B")
            ElseIf bContentScrolling Then
                UpdateState(True, dgEmails.Items.Count, dgEmails.Items.Count, dgContent.Items.Count, dgContent.Items.Count + PageRowLimit)
                UdpateSearchTerm("ALL", "rbAll", "False", "B")
                UdpateSearchTerm("ALL", "rbEmails", "False", "B")
                UdpateSearchTerm("ALL", "rbContent", "True", "B")
            Else
                UpdateState(True, dgEmails.Items.Count, dgEmails.Items.Count + PageRowLimit, dgContent.Items.Count, dgContent.Items.Count + PageRowLimit)
                UdpateSearchTerm("ALL", "rbAll", rbAll.IsChecked.ToString, "B")
                UdpateSearchTerm("ALL", "rbEmails", rbEmails.IsChecked.ToString, "B")
                UdpateSearchTerm("ALL", "rbContent", rbContent.IsChecked.ToString, "B")
            End If

            Dim iEmailStart As Integer = dgEmails.Items.Count
            Dim iContentStart As Integer = dgContent.Items.Count
            Dim iEmailEnd As Integer = iEmailStart + 50
            Dim iContentEnd As Integer = iContentStart + 50

            UdpateSearchTerm("ALL", "StartingEmailRow", iEmailStart.ToString, "I")
            UdpateSearchTerm("ALL", "EndingEmailRow", UpperPageNumber.ToString, "I")
            UdpateSearchTerm("ALL", "StartingContentRow", iContentStart.ToString, "I")
            UdpateSearchTerm("ALL", "EndingContentRow", UpperPageNumber.ToString, "I")

        End If

    End Sub

    ''' <summary>
    ''' Generates the SQL.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Private Function GenerateSQL() As String
        Dim S As String = ""
        Dim TypeSQL As String = ""
        'Dim SearchParmList As New System.Collections.Generic.List(Of SVCSearch.DS_SearchTerms)
        Dim SecureID As Integer = 0

        dictMasterSearch.Clear()
        BuildSearchParameters()
        'SearchParmList = ListOfSearchTerms
        Dim weight As String = ""
        If ckWeights.IsChecked Then
            weight = nbrWeightMin.Text
        Else
            weight = 0
        End If


        If rbAll.IsChecked Then
            TypeSQL = "C"
            Dim S1 As String = proxy2.GenerateSQL(dictMasterSearch, SecureID, TypeSQL)
            TypeSQL = "E"
            Dim S2 As String = proxy2.GenerateSQL(dictMasterSearch, SecureID, TypeSQL)
            S = S1 + vbCrLf
            S += S1 + "--***************************************************" + vbCrLf
            S += S2 + vbCrLf
        ElseIf rbContent.IsChecked Then
            TypeSQL = "C"
            S = proxy2.GenerateSQL(dictMasterSearch, SecureID, TypeSQL)
        ElseIf rbEmails.IsChecked Then
            TypeSQL = "E"
            S = proxy2.GenerateSQL(dictMasterSearch, SecureID, TypeSQL)
        End If

        Return S
    End Function

    ''' <summary>
    ''' Handles the Click event of the linkGenSql control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub linkGenSql_Click(sender As Object, e As RoutedEventArgs) Handles linkGenSql.Click

        GeneratedSql = GenerateSQL()
        Clipboard.Clear()
        Clipboard.SetText(GeneratedSql)


        MessageBox.Show("The generated sql is in the clipboard...")

        DoNotShowMsgBox = False
    End Sub

    ''' <summary>
    ''' Handles the Click event of the Button control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub Button_Click(sender As Object, e As RoutedEventArgs)
        Dim ES As String = ENC.AES256EncryptString("DALE MILLER")
        Dim DS As String = ENC.AES256DecryptString(ES)
    End Sub

    'Private Sub hlDownLoadCLC_Copy_Click(sender As Object, e As RoutedEventArgs) Handles hlDownLoadCLC_Copy.Click

    '    Process.Start(gDownloadDIR)

    'End Sub

    ''' <summary>
    ''' Gets the dictionary value.
    ''' </summary>
    ''' <param name="DR">The dr.</param>
    ''' <param name="dKey">The d key.</param>
    ''' <param name="DictVal">The dictionary value.</param>
    ''' <returns>System.String.</returns>
    Private Function getDictVal(DR As Object, dKey As String, DictVal As Dictionary(Of String, String)) As String

        Dim VAL As String = ""

        If DictVal.ContainsKey(dKey) Then
            VAL = DictVal(dKey)
        End If

        Return VAL

    End Function

    ''' <summary>
    ''' Sets the email column widths.
    ''' </summary>
    Private Sub setEmailColumnWidths()
        For Each col As DataGridColumn In dgEmails.Columns
            Dim name As String = col.Header
            Select Case name
                Case "ExtensionData"
                    col.Width = 0
                    col.Visibility = Visibility.Collapsed
                Case "AllRecipients"
                    col.Width = 100
                Case "Bcc"      '=2
                    col.Width = 100
                Case "Body"      '=3
                    col.Width = 450
                Case "CC"      '=4
                    col.Width = 100
                Case "CreationTime"      '=5
                    col.Width = 100
                Case "EmailGuid"      '=6
                    col.Width = 100
                Case "FoundInAttach"      '=7
                    col.Width = 25
                Case "MsgSize"      '=8
                    col.Width = 50
                Case "NbrAttachments"      '=9
                    col.Width = 25
                Case "OriginalFolder"      '=10
                    col.Width = 100
                Case "RANK"      '=11
                    col.Width = 25
                Case "RID"      '=12
                    col.Width = 10
                Case "ROWID"      '=13
                    col.Width = 20
                Case "ReceivedByName"      '=14
                    col.Width = 100
                Case "ReceivedTime"      '=15
                    col.Width = 100
                Case "RepoSvrName"      '=16
                    col.Width = 100
                Case "RetentionExpirationDate"      '=17
                    col.Width = 100
                Case "SUBJECT"      '=18
                    col.Width = 250
                Case "SenderEmailAddress"      '=19
                    col.Width = 100
                Case "SenderName"      '=20
                    col.Width = 100
                Case "SentOn"      '=21
                    col.Width = 100
                Case "SentTO"      '=22
                    col.Width = 100
                Case "ShortSubj"      '=23
                    col.Width = 100
                Case "SourceTypeCode"      '=24
                    col.Width = 50
                Case "UserID"      '=25
                    col.Width = 100
                Case "isPublic"      '=26
                    col.Width = 20
            End Select
        Next
    End Sub

    ''' <summary>
    ''' Handles the SelectionChanged event of the dgEmails control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub dgEmails_SelectionChanged(sender As Object, e As SelectionChangedEventArgs) Handles dgEmails.SelectionChanged

        CurrentlySelectedGrid = "EMAIL"

        Dim DictVal As Dictionary(Of String, String) = LoadCellValue(dgEmails)

        txtDescription.Text = ""
        Dim iCnt As Integer = dgEmails.SelectedItems.Count
        If iCnt > 0 Then
            btnOpenRestoreScreen.Visibility = Windows.Visibility.Visible
        Else
            btnOpenRestoreScreen.Visibility = Windows.Visibility.Collapsed
        End If

        Dim eBody As String = ""
        Dim eSubj As String = ""


        Dim DR As Object = dgEmails.SelectedItems(0)
        Dim IX As Integer = dgEmails.SelectedIndex

        Dim SentOn As String = fetchCellValue(dgEmails, "SentOn")
        Dim ShortSubj As String = fetchCellValue(dgEmails, "ShortSubj")
        Dim SenderEmailAddress As String = fetchCellValue(dgEmails, "SenderEmailAddress")
        Dim SenderName As String = fetchCellValue(dgEmails, "SenderName")
        Dim SentTO As String = fetchCellValue(dgEmails, "SentTO")
        Dim Body As String = fetchCellValue(dgEmails, "Body")
        Dim CC As String = fetchCellValue(dgEmails, "CC")
        Dim Bcc As String = fetchCellValue(dgEmails, "Bcc")
        Dim CreationTime As String = fetchCellValue(dgEmails, "CreationTime")
        Dim AllRecipients As String = fetchCellValue(dgEmails, "AllRecipients")
        Dim ReceivedByName As String = fetchCellValue(dgEmails, "ReceivedByName")
        Dim ReceivedTime As String = fetchCellValue(dgEmails, "MsgSize")
        Dim MsgSize As String = fetchCellValue(dgEmails, "MsgSize")
        Dim SUBJECT As String = fetchCellValue(dgEmails, "SUBJECT")
        Dim OriginalFolder As String = fetchCellValue(dgEmails, "OriginalFolder")
        Dim EmailGuid As String = fetchCellValue(dgEmails, "EmailGuid")
        Dim RetentionExpirationDate = fetchCellValue(dgEmails, "RetentionExpirationDate")
        Dim UserID = fetchCellValue(dgEmails, "UserID")
        Dim SourceTypeCode = fetchCellValue(dgEmails, "SourceTypeCode")
        Dim NbrAttachments = fetchCellValue(dgEmails, "NbrAttachments")
        Dim RID = fetchCellValue(dgEmails, "RID")
        Dim RepoSvrName = fetchCellValue(dgEmails, "RepoSvrName")
        Dim RANK As String = fetchCellValue(dgEmails, "RANK")
        Dim dKey As String = ""
        Dim isPublic As String = fetchCellValue(dgEmails, "isPublic")

        If isPublic IsNot Nothing Then
            If isPublic.Equals("Y") Then
                lblIsPublicShow.Visibility = Visibility.Visible
            Else
                lblIsPublicShow.Visibility = Visibility.Collapsed
            End If
        Else
            lblIsPublicShow.Visibility = Visibility.Collapsed
        End If


        CurrentlySelectedGrid = "EMAIL"
        SelectedGrid = "dgEmails"

        If iCnt = 0 Then
            Return
        End If

        If iCnt > 0 Then
            btnOpenRestoreScreen.Visibility = Windows.Visibility.Visible
        Else
            btnOpenRestoreScreen.Visibility = Windows.Visibility.Collapsed
        End If
        RID = -1

        If iCnt = 1 Then

            Dim DisplayMsg As String = ""
            If SenderName IsNot Nothing Then
                If SenderName.Length > 0 Then
                    DisplayMsg = "From: " + SenderName + " - "
                End If
            End If

            If SUBJECT IsNot Nothing Then
                If SUBJECT.Length > 0 Then
                    DisplayMsg += SUBJECT + vbCrLf
                End If
            End If

            If Body IsNot Nothing Then
                If Body.Length > 0 Then
                    DisplayMsg = DisplayMsg + Body
                End If
            End If

            txtDescription.Text = DisplayMsg.Trim
            'IX = dgEmails.SelectedIndex

            If isPublic IsNot Nothing Then
                If isPublic.ToUpper.Equals("Y") Then
                    lblIsPublicShow.Visibility = Visibility.Visible
                Else
                    lblIsPublicShow.Visibility = Visibility.Collapsed
                End If
            Else
                lblIsPublicShow.Visibility = Visibility.Visible
            End If

            Dim FoundInAttachment As Boolean = False
            Dim StrBB As String = fetchCellValue(dgEmails, "FoundInAttach")
            If NbrAttachments = 0 Then
                FoundInAttachment = False
            ElseIf StrBB.ToUpper.Equals("FALSE") Then
                FoundInAttachment = False
            Else
                FoundInAttachment = True
            End If

            'Dim sRid As String = grid.GetCellValueAsString(dgEmails, dgEmails.SelectedIndex, "RID")
            Dim sRid As String = RID
            sRid = sRid.Trim
            If sRid.Length = 0 Then
                RID = -1
            Else
                RID = CInt(sRid)
            End If

            If NbrAttachments > 0 Then
                dgAttachments.ItemsSource = Nothing
                dgAttachments.Visibility = Windows.Visibility.Hidden
                Dim Obj As Object = ProxySearch.GetEmailAttachments(gSecureID, EmailGuid)
                client_GetEmailAttachments(Obj)
                dgAttachments.Items.Refresh()
            Else
                dgAttachments.Visibility = Windows.Visibility.Collapsed
            End If
        Else
            dgAttachments.Visibility = Windows.Visibility.Collapsed
        End If
        If emailSearchParmsSet() Then
            lblEmailSearchParms.Visibility = Visibility.Visible
        Else
            lblEmailSearchParms.Visibility = Visibility.Collapsed
        End If

    End Sub

    ''' <summary>
    ''' Handles the KeyDown event of the dgContent control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="KeyEventArgs"/> instance containing the event data.</param>
    Private Sub dgContent_KeyDown(sender As Object, e As KeyEventArgs) Handles dgContent.KeyDown
        If e.Key = Key.F12 Then
            Dim cm As ContextMenu = FindResource("PopupContent")
            cm.IsOpen = True
            'PopupContent.IsSubmenuOpen = True
        End If
    End Sub

    ''' <summary>
    ''' Handles the KeyDown event of the nbrSearchHist control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="KeyEventArgs"/> instance containing the event data.</param>
    Private Sub nbrSearchHist_KeyDown(sender As Object, e As KeyEventArgs) Handles lblMain.KeyDown

        Dim CurrSearchId As Double = Convert.ToDouble(lblMain.Content)

        If e.Key = Key.Enter Then
            Dim SearchID As Integer = Convert.ToInt32(lblMain.Content)

            SetActiveStateOfForm()
            GetSearchHistory(SearchID)

            lblMain.Content = CurrSearchId.ToString

            'System.Windows.Browser.HtmlPage.Plugin.Focus()
            btnSubmit.Focus()

        End If
    End Sub

    ''' <summary>
    ''' Handles the ScrollPositionChanging event of the dgEmails control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.ScrollChangedEventArgs"/> instance containing the event data.</param>
    Private Sub dgEmails_ScrollPositionChanging(ByVal sender As System.Object, ByVal e As System.Windows.Controls.ScrollChangedEventArgs)

        If bGhostFetchActive Then
            Return
        End If

        If bSettingEmailRowHeight Then
            Return
        End If

        Dim pct As Double = grid.getScrollBarCurrentPct(dgEmails, "emailScrollbar")
        Dim currRow As Double = grid.getScrollBarMaxPosition(dgEmails, "emailScrollbar") * pct

        'If currRow < EmailTriggerRow Then
        If pct < 0.85 Then
            Return
        End If

        bEmailScrolling = True
        bContentScrolling = False

        'EmailLowerPageNbr += CInt(nbrDocRows.Text)
        'EmailUpperPageNbr += CInt(nbrDocRows.Text)
        'DocLowerPageNbr += CInt(nbrDocRows.Text)
        'DocUpperPageNbr += CInt(nbrDocRows.Text)

        bStartNewSearch = False

        'Dim TopRow As Integer = dgEmails.ViewRange.TopRow
        TopRow = grid.getScrollBarCurrentPosition(dgEmails, "verticalScrollBar")
        Dim BottomRow As Integer = dgEmails.Items.Count
        'Dim CurrRow As Double = dgEmails.ViewRange.BottomRow
        currRow = grid.getScrollBarMaxPosition(dgEmails, "verticalScrollBar")
        Dim PctLocation As Double = grid.getScrollBarCurrentPct(dgEmails, "emailScrollbar")
        Dim TotalRows As Integer = dgEmails.Items.Count

        If PrevTopRow.Equals(TopRow) Then
            Return
        End If
        PrevTopRow = TopRow
        SBEmailPage.Text = "Rows " & TopRow & " - " & BottomRow

        'If BottomRow > TotalRows - (TopRow - 30) Then
        If PctLocation > 80 Then
            EmailLowerPageNbr += PageRowLimit
            EmailUpperPageNbr += PageRowLimit
            SB.Text = "Fetching more emails"
            ExecuteSearch(False, "dgEmailScroll")
            bGhostFetchActive = True
        Else
            SB.Text = "EMail: " + currRow.ToString + " : " + PctLocation.ToString
        End If
        SB.Text = "EMail: % " + PctLocation.ToString
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the nbrEmailRows control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub nbrEmailRows_TextChanged(sender As Object, e As TextChangedEventArgs) Handles nbrEmailRows.TextChanged
        PageRowLimit = Convert.ToInt32(nbrEmailRows.Text)
        nbrDocRows.Text = nbrEmailRows.Text
        EmailLowerPageNbr = 0
        EmailUpperPageNbr = PageRowLimit
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the nbrDocRows control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub nbrDocRows_TextChanged(sender As Object, e As TextChangedEventArgs) Handles nbrDocRows.TextChanged
        PageRowLimit = CInt(nbrDocRows.Text)
        DocLowerPageNbr = 0
        DocUpperPageNbr = PageRowLimit
    End Sub

    ''' <summary>
    ''' Handles the SelectionChanged event of the dgAttachments control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub dgAttachments_SelectionChanged(sender As Object, e As SelectionChangedEventArgs) Handles dgAttachments.SelectionChanged

        If SelectedGrid.Equals("dgEmails") Then

            Dim iCnt As Integer = dgAttachments.SelectedItems.Count
            If Not iCnt.Equals(1) Then
                Return
            End If

            Dim EmailGuid As String = ""
            Dim AttachmentName As String = ""

            If iCnt > 0 Then
                btnOpenRestoreScreen.Visibility = Windows.Visibility.Visible
            Else
                btnOpenRestoreScreen.Visibility = Windows.Visibility.Collapsed
            End If

            Dim idx As Integer = dgAttachments.SelectedIndex

            AttachmentName = fetchCellValue(dgAttachments, "AttachmentName")
            EmailGuid = fetchCellValue(dgAttachments, "EmailGuid")
            CurrAttachmentRowID = fetchCellValue(dgAttachments, "RowID")
            RepoTableName = "EmailAttachment"

            If iCnt = 1 Then
                CurrentGuid = EmailGuid
                SB.Text = "Selected Attachment ID: " + CurrAttachmentRowID
            Else
                CurrentGuid = ""
            End If
        End If
    End Sub

    ''' <summary>
    ''' Handles the ColumnReordered event of the dgEmails control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="DataGridColumnEventArgs"/> instance containing the event data.</param>
    Private Sub dgEmails_ColumnReordered(sender As Object, e As DataGridColumnEventArgs) Handles dgEmails.ColumnReordered
        SaveGridColumnOrder(dgEmails, dictEmailGridColDisplayOrder)
    End Sub

    ''' <summary>
    ''' Handles the ColumnReordered event of the dgContent control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="DataGridColumnEventArgs"/> instance containing the event data.</param>
    Private Sub dgContent_ColumnReordered(sender As Object, e As DataGridColumnEventArgs) Handles dgContent.ColumnReordered
        SaveGridColumnOrder(dgContent, dictContentGridColDisplayOrder)
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnPlus control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnPlus_Click(sender As Object, e As RoutedEventArgs) Handles btnPlus.Click
        If DoNotApplyQuickSearch Then
            Return
        End If
        QuickSearchRecall(CInt(lblMain.Content), False)
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnMinus control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnMinus_Click(sender As Object, e As RoutedEventArgs) Handles btnMinus.Click
        If DoNotApplyQuickSearch Then
            Return
        End If
        QuickSearchRecall(CInt(lblMain.Content), False)
    End Sub

    ''' <summary>
    ''' Handles the Checked event of the ckShowAll control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckShowAll_Checked(sender As Object, e As RoutedEventArgs) Handles ckShowAll.Checked

        If gSelectedGrid.Equals("dgEmail") Then
            SB.Text = "Email selected..."
        Else
            SB.Text = "Content selected..."
        End If

        If ckShowAll.IsChecked Then
            ShowAllContentColumns()
            ShowAllEmailColumns()
        Else
            HideAllContentColumns()
            HideAllEmailColumns()
            ShowBasicEmailColumns()
            ShowBasicContentColumns()
        End If

        setEmailGRidRowHeight()

    End Sub

    ''' <summary>
    ''' Hides all content columns.
    ''' </summary>
    Private Sub HideAllContentColumns()
        Dim columns As ObservableCollection(Of DataGridColumn) = dgContent.Columns

        For Each col As DataGridColumn In columns
            col.Visibility = Visibility.Collapsed
        Next
    End Sub
    ''' <summary>
    ''' Hides all email columns.
    ''' </summary>
    Private Sub HideAllEmailColumns()
        Dim columns As ObservableCollection(Of DataGridColumn) = dgEmails.Columns

        For Each col As DataGridColumn In columns
            col.Visibility = Visibility.Collapsed
        Next
    End Sub
    ''' <summary>
    ''' Shows all email columns.
    ''' </summary>
    Private Sub ShowAllEmailColumns()
        Dim columns As ObservableCollection(Of DataGridColumn) = dgEmails.Columns

        For Each col As DataGridColumn In columns
            col.Visibility = Visibility.Visible
        Next
    End Sub
    ''' <summary>
    ''' Shows all content columns.
    ''' </summary>
    Private Sub ShowAllContentColumns()
        Dim columns As ObservableCollection(Of DataGridColumn) = dgContent.Columns

        For Each col As DataGridColumn In columns
            col.Visibility = Visibility.Visible
        Next
    End Sub
    ''' <summary>
    ''' Shows the basic email columns.
    ''' </summary>
    Private Sub ShowBasicEmailColumns()
        Dim columns As ObservableCollection(Of DataGridColumn) = dgEmails.Columns
        For Each col As DataGridColumn In columns
            col.Visibility = Visibility.Collapsed
        Next
        For Each col As DataGridColumn In columns

            Select Case col.Header.ToString()
                Case "RANK"
                    col.Visibility = Visibility.Visible
                Case "SentOn"
                    col.Visibility = Visibility.Visible
                Case "ShortSubj"
                    col.Visibility = Visibility.Visible
                Case "SenderEmailAddress"
                    col.Visibility = Visibility.Visible
                'Case "SenderName"
                '    col.Visibility = Visibility.Visible
                Case "SentTO"
                    col.Visibility = Visibility.Visible
                Case "Body"
                    col.Visibility = Visibility.Visible
                'Case "CC"
                '    col.Visibility = Visibility.Visible
                'Case "Bcc"
                '    col.Visibility = Visibility.Visible
                Case "CreationTime"
                    col.Visibility = Visibility.Visible
                'Case "AllRecipients"
                '    col.Visibility = Visibility.Visible
                'Case "ReceivedByName"
                '    col.Visibility = Visibility.Visible
                Case "ReceivedTime"
                    col.Visibility = Visibility.Visible
                'Case "MsgSize"
                '    col.Visibility = Visibility.Visible
                Case "SUBJECT"
                    col.Visibility = Visibility.Visible
                'Case "OriginalFolder"
                '    col.Visibility = Visibility.Visible
                Case "EmailGuid"
                    col.Visibility = Visibility.Visible
                Case "RetentionExpirationDate"
                    col.Visibility = Visibility.Visible
                'Case "isPublic"
                '    col.Visibility = Visibility.Visible
                'Case "UserID"
                '    col.Visibility = Visibility.Visible
                'Case "SourceTypeCode"
                '    col.Visibility = Visibility.Visible
                Case "NbrAttachments"
                    col.Visibility = Visibility.Visible
                'Case "RID"
                '    col.Visibility = Visibility.Visible
                'Case "RepoSvrName"
                '    col.Visibility = Visibility.Visible
                Case "ROWID"
                    col.Visibility = Visibility.Visible
                Case "FoundInAttach"
                    col.Visibility = Visibility.Visible
            End Select
        Next
    End Sub

    ''' <summary>
    ''' Populates the master search dictionary.
    ''' </summary>
    Public Sub PopulateMasterSearchDict()

        Dim AutoSql As String = ""
        Dim ValName As String = ""
        Dim ValValue As String = ""
        Dim LowerPageNumber As Integer = 0
        Dim UpperPageNumber As Integer = PageRowLimit

        dictMasterSearch.Clear()

        ValName = "DocLowerPageNbr"
        ValValue = DocLowerPageNbr.ToString
        AddMasterSearchItem(ValName, ValValue)

        ValName = "DocUpperPageNbr"
        ValValue = DocUpperPageNbr.ToString
        AddMasterSearchItem(ValName, ValValue)

        ValName = "EmailLowerPageNbr"
        ValValue = EmailLowerPageNbr.ToString
        AddMasterSearchItem(ValName, ValValue)

        ValName = "EmailUpperPageNbr"
        ValValue = EmailUpperPageNbr.ToString
        AddMasterSearchItem(ValName, ValValue)

        ValName = "txtSearch"
        ValValue = txtSearch.Text.Trim
        AddMasterSearchItem(ValName, ValValue)

        ValName = "txtSelDir"
        'ValValue = txtSelDir
        AddMasterSearchItem(ValName, ValValue)

        ValName = "cbLibrary"
        ValValue = cbLibrary.SelectedItem
        AddMasterSearchItem(ValName, ValValue)

        ValName = "nbrWeightMin"
        ValValue = nbrWeightMin.Text
        AddMasterSearchItem(ValName, ValValue)

        ValName = "rbAll"
        ValValue = rbAll.IsChecked.ToString
        AddMasterSearchItem(ValName, ValValue)

        ValName = "rbContent"
        ValValue = rbContent.IsChecked.ToString
        AddMasterSearchItem(ValName, ValValue)

        ValName = "rbEmails"
        ValValue = rbEmails.IsChecked.ToString
        AddMasterSearchItem(ValName, ValValue)

        ValName = "ckLimitToLib"
        ValValue = ckLimitToLib.IsChecked.ToString
        AddMasterSearchItem(ValName, ValValue)

        ValName = "ckMyContent"
        ValValue = ckMyContent.IsChecked.ToString
        AddMasterSearchItem(ValName, ValValue)

        ValName = "ckMasterOnly"
        ValValue = ckMasterOnly.IsChecked.ToString
        AddMasterSearchItem(ValName, ValValue)

        ValName = "ckWeights"
        ValValue = ckWeights.IsChecked.ToString
        AddMasterSearchItem(ValName, ValValue)

        ValName = "lblMain"
        ValValue = gNbrSearches.ToString
        AddMasterSearchItem(ValName, ValValue)

        ValName = "ckFilters"
        ValValue = ckFilters.IsChecked.ToString
        AddMasterSearchItem(ValName, ValValue)

        ValName = "SBEmail"
        ValValue = SBEmail.Text
        AddMasterSearchItem(ValName, ValValue)

        ValName = "SBDoc"
        ValValue = SBDoc.Text
        AddMasterSearchItem(ValName, ValValue)

        ValName = "SB"
        ValValue = SB.Text
        AddMasterSearchItem(ValName, ValValue)

        AddMasterSearchItem("CalledFromScreen", Me.Title)
        AddMasterSearchItem("UID", gCurrLoginID)
        AddMasterSearchItem("gCurrLoginID", gCurrLoginID)
        AddMasterSearchItem("bNeedRowCount", bNeedRowCount.ToString)
        AddMasterSearchItem("rbAll", rbAll.IsChecked.ToString)
        AddMasterSearchItem("rbEmails", rbEmails.IsChecked.ToString)
        AddMasterSearchItem("rbContent", rbContent.IsChecked.ToString)
        AddMasterSearchItem("ckWeights", ckWeights.IsChecked.ToString)
        AddMasterSearchItem("ckLimitToLib", ckLimitToLib.IsChecked.ToString)
        AddMasterSearchItem("LowerPageNbr", LowerPageNumber.ToString)
        AddMasterSearchItem("UpperPageNbr", UpperPageNumber.ToString)
        AddMasterSearchItem("GeneratedSql", AutoSql)
        AddMasterSearchItem("CurrentDocPage", CurrentDocPage.ToString)
        AddMasterSearchItem("CurrentEmailPage", CurrentEmailPage.ToString)

        For Each sKey As String In dictEmailSearch.Keys
            Dim sVal As String = dictEmailSearch.Item(sKey)
            AddMasterSearchItem(sKey, sVal)
        Next

        For Each sKey As String In dictContentSearch.Keys
            Dim sVal As String = dictContentSearch.Item(sKey)
            AddMasterSearchItem(sKey, sVal)
        Next

    End Sub

    ''' <summary>
    ''' Shows the basic content columns.
    ''' </summary>
    Private Sub ShowBasicContentColumns()
        Dim columns As ObservableCollection(Of DataGridColumn) = dgContent.Columns
        For Each col As DataGridColumn In columns
            col.Visibility = Visibility.Collapsed
        Next

        For Each col As DataGridColumn In columns

            Select Case col.Header.ToString()
                Case "RANK"
                    col.Visibility = Visibility.Visible
                Case "SourceName"
                    col.Visibility = Visibility.Visible
                Case "CreateDate"
                    col.Visibility = Visibility.Visible
                Case "VersionNbr"
                    col.Visibility = Visibility.Visible
                Case "LastAccessDate"
                    col.Visibility = Visibility.Visible
                Case "FileLength"
                    col.Visibility = Visibility.Visible
                Case "LastWriteTime"
                    col.Visibility = Visibility.Visible
                Case "OriginalFileType"
                    col.Visibility = Visibility.Visible
                Case "isPublic"
                    col.Visibility = Visibility.Visible
                'Case "FQN"
                '    col.Visibility = Visibility.Visible
                Case "SourceGuid"
                    col.Visibility = Visibility.Visible
                'Case "DataSourceOwnerUserID"
                '    col.Visibility = Visibility.Visible
                'Case "FileDirectory"
                '    col.Visibility = Visibility.Visible
                Case "RetentionExpirationDate"
                    col.Visibility = Visibility.Visible
                Case "isMaster"
                    col.Visibility = Visibility.Visible
                'Case "StructuredData"
                '    col.Visibility = Visibility.Visible
                'Case "RepoSvrName"
                '    col.Visibility = Visibility.Visible
                'Case "ROWID"
                '    col.Visibility = Visibility.Visible
                Case "Description"
                    col.Visibility = Visibility.Visible
                    'Case "RssLinkFlg"
                    '    col.Visibility = Visibility.Visible
                    'Case "isWebPage"
                    '    col.Visibility = Visibility.Visible

            End Select
        Next
    End Sub

    ''' <summary>
    ''' Handles the SelectionChanged event of the tabSearch control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub tabSearch_SelectionChanged(sender As Object, e As SelectionChangedEventArgs) Handles tabSearch.SelectionChanged

    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnDownload control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnDownload_Click(sender As Object, e As RoutedEventArgs) Handles btnDownload.Click
        Dim msg As String = DLOAD.DownLoadSelectedItems(dgContent, dgEmails)
        MessageBox.Show(msg, "DOWNLOADED FILES")
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnViewDL control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnViewDL_Click(sender As Object, e As RoutedEventArgs) Handles btnViewDL.Click

        Process.Start(gDownloadDIR)

    End Sub

    ''' <summary>
    ''' Handles the GotFocus event of the btnOpenRestoreScreen control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnOpenRestoreScreen_GotFocus(sender As Object, e As RoutedEventArgs) Handles btnOpenRestoreScreen.GotFocus

    End Sub

    ''' <summary>
    ''' Handles the Click event of the BtnGetCount control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub BtnGetCount_Click(sender As Object, e As RoutedEventArgs) Handles btnGetCount.Click

        If rbAll.IsChecked Then
            MessageBox.Show("Either a Content or Email search must be selected, not both (ALL)... returning")
            Return
        End If

        Me.Cursor = Cursors.Wait
        DoNotShowMsgBox = True

        GeneratedSql = GenerateSQL()

        Dim i As Integer = proxy2.iCountContent(0, GeneratedSql)
        Me.Cursor = Cursors.Arrow

        DoNotShowMsgBox = False

        If rbContent.IsChecked Then
            MessageBox.Show("This search will return " + i.ToString + " rows/documents...")
        End If
        If rbEmails.IsChecked Then
            MessageBox.Show("This search will return " + i.ToString + " rows/Emails...")
        End If

    End Sub

    ''' <summary>
    ''' Handles the 1 event of the Button_Click control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub Button_Click_1(sender As Object, e As RoutedEventArgs) Handles button.Click

        'Dim L As New List(Of String)
        'Dim T As Type = GetType(SVCSearch.DS_clsUSERGRIDSTATE)
        ''L = DSMGT.ListClassProperties(O)
        'DSMGT.ListClassProperties(T)
        'Debug.WriteLine(L)

        Dim SourceGuid As String = "00a8a846-71f5-433f-904f-221235d37cdb"
        Dim SourceType As String = "C"  'Use an "A" for email attachments and it will return the same, or a "C" for documents and other content
        Dim iFileLen As Int64 = proxy2.getSourceLength(SourceGuid, SourceType)    'This function can be used as verification that all expected bytes were received in the DownloadImage call
        Dim Sourcename As String = proxy2.getSourceName(SourceGuid, SourceType)
        Dim DocImage As Byte() = proxy2.DownLoadDocument(SourceType, SourceGuid)
        'At this point, you have the DocImage as a stream of bytes and you can do whatever is needed with that stream
        Console.WriteLine("DocImage: " + Sourcename + " @ " + DocImage.Length.ToString + " bytes")



    End Sub

    ''' <summary>
    ''' Handles the AutoGeneratingColumn event of the DgContent control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="DataGridAutoGeneratingColumnEventArgs"/> instance containing the event data.</param>
    Private Sub DgContent_AutoGeneratingColumn(sender As Object, e As DataGridAutoGeneratingColumnEventArgs) Handles dgContent.AutoGeneratingColumn

    End Sub

    ''' <summary>
    ''' Handles the Loaded event of the TabEmail control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub TabEmail_Loaded(sender As Object, e As RoutedEventArgs) Handles TabEmail.Loaded

    End Sub

    ''' <summary>
    ''' Handles the AutoGeneratedColumns event of the DgContent control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
    Private Sub DgContent_AutoGeneratedColumns(sender As Object, e As EventArgs) Handles dgContent.AutoGeneratedColumns

        Console.WriteLine("dgContent Columns ******************************************")
        If gDebug Then LOG.WriteToTraceLog("dgContent Columns ******************************************")
        For Each col As DataGridColumn In dgContent.Columns
            Dim tgt As String = col.Header.ToString
            Dim II As Integer = dgContent.Columns.IndexOf(dgContent.Columns.FirstOrDefault(Function(c) c.Header = tgt))
            CONTENT_COLS.Add(tgt, II)
            Console.WriteLine(", " + tgt + "     idx=" + II.ToString)
            If gDebug Then LOG.WriteToTraceLog(", " + tgt + "     idx=" + II.ToString)
        Next
    End Sub

    ''' <summary>
    ''' Handles the AutoGeneratedColumns event of the DgEmails control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="EventArgs"/> instance containing the event data.</param>
    Private Sub DgEmails_AutoGeneratedColumns(sender As Object, e As EventArgs) Handles dgEmails.AutoGeneratedColumns

        If gDebug Then
            Console.WriteLine("************** DgEmails_AutoGeneratedColumns ***************************")
            For Each col As DataGridColumn In dgEmails.Columns
                Dim tgt As String = col.Header.ToString
                Dim II As Integer = dgEmails.Columns.IndexOf(dgEmails.Columns.FirstOrDefault(Function(c) c.Header = tgt))
                EMAIL_COLS.Add(tgt, II)
                Console.WriteLine(", " + tgt + "     idx=" + II.ToString)
                If gDebug Then LOG.WriteToTraceLog(", " + tgt + "     idx=" + II.ToString)
            Next
            Console.WriteLine("************** END DgEmails_AutoGeneratedColumns ***************************")
        End If
        setEmailColumnWidths()
    End Sub

    ''' <summary>
    ''' Handles the SizeChanged event of the GridLayoutDocs control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="SizeChangedEventArgs"/> instance containing the event data.</param>
    Private Sub GridLayoutDocs_SizeChanged(sender As Object, e As SizeChangedEventArgs) Handles gridLayoutDocs.SizeChanged

    End Sub

    ''' <summary>
    ''' Handles the Click event of the BtnRefresh control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub BtnRefresh_Click(sender As Object, e As RoutedEventArgs) Handles btnRefresh.Click

    End Sub
End Class

''' <summary>
''' Class GridCols.
''' </summary>
Public Class GridCols
    ''' <summary>
    ''' The col ord
    ''' </summary>
    Public ColOrd As Integer
    ''' <summary>
    ''' The colname
    ''' </summary>
    Public Colname As String
    ''' <summary>
    ''' The width
    ''' </summary>
    Public Width As Integer
    ''' <summary>
    ''' The b read only
    ''' </summary>
    Public bReadOnly As Boolean
    ''' <summary>
    ''' The visible
    ''' </summary>
    Public Visible As Boolean
    ''' <summary>
    ''' The grid name
    ''' </summary>
    Public GridName As String
End Class

''' <summary>
''' Class DS_ContentDS.
''' </summary>
Public Class DS_ContentDS
    ''' <summary>
    ''' Gets or sets the content ds.
    ''' </summary>
    ''' <value>The content ds.</value>
    Public Property ContentDS As DataTable
End Class
''' <summary>
''' Class DS_ImageData.
''' </summary>
Public Class DS_ImageData
    ''' <summary>
    ''' Gets or sets the name of the source.
    ''' </summary>
    ''' <value>The name of the source.</value>
    Public Property SourceName As String
    ''' <summary>
    ''' Gets or sets the length of the file.
    ''' </summary>
    ''' <value>The length of the file.</value>
    Public Property FileLength As String
    ''' <summary>
    ''' Gets or sets the source image.
    ''' </summary>
    ''' <value>The source image.</value>
    Public Property SourceImage As Byte()
End Class
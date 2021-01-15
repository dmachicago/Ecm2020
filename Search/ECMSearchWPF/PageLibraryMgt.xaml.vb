Imports System.Data
Imports System.Web.Script.Serialization
Imports ECMEncryption
Public Class PageLibraryMgt
    'Inherits Page

    Dim DelCounter As Integer = 0
    Dim DelCount As Integer = 0

    Dim UTIL As New clsUtility
    Dim DMA As New clsDma
    Dim LOG As New clsLogMain
    Dim ISO As New clsIsolatedStorage
    Dim COMMON As New clsCommonFunctions
    Dim DRHIST As New clsDATASOURCERESTOREHISTORY
    'Dim EP As New clsEndPoint
    Dim ENC2 As New ECMEncrypt()
    Dim XLOG As New clsLoggingExtended
    Dim DSMGT As clsDatasetMgt = New clsDatasetMgt()

    Dim bPopulateGroupUsers As Boolean = False
    Dim bPopulateAssignedUsers As Boolean = False
    Dim bPopulateLibItems As Boolean = False
    Dim bDeleteGroupAccess As Boolean = False
    Dim CurrSelectedLibName As String = ""

    Dim iTotalToProcess As Integer = 0
    Dim iTotalProcessed As Integer = 0

    'Dim GVAR As App = App.Current
    Dim UserID As String = ""
    Dim isAdmin As Boolean = False
    'Dim ListOfItems As New System.Collections.ObjectModel.ObservableCollection(Of String)
    Dim ListOfItems() As String = Nothing
    Dim RC As Boolean = False
    Dim RetMsg As String = ""
    Dim FormLoaded As Boolean = False
    Dim LibraryName As String = ""
    Dim sddebug As String = System.Configuration.ConfigurationManager.AppSettings("DebugON")
    Dim ddebug As Boolean = False
    'Dim proxy As New SVCSearch.Service1Client

    Public Sub New()
        InitializeComponent()

        If sddebug = "1" Then ddebug = True

        If ddebug Then If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt - PageLibraryMgt 00: ")
        '** Set global variables
        UserID = _UserID
        'gCurrLoginID = gCurrLoginID

        COMMON.SaveClick(5500, UserID)

        isAdmin = _isAdmin

        PopulateLibraryComboBox()
        PopulateGroupCombo()

        SB.Text = ""

        btnRestore.Visibility = Visibility.Hidden

    End Sub

    Private Sub hlHome_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlHome.Click
        Me.Close()
    End Sub

    Private Sub hyperlinkButton1_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hyperlinkButton1.Click
        Dim NextPage As New PageLibrary
        NextPage.Show()
    End Sub



    Private Sub hlLibUsers_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlLibUsers.Click
        Dim NextPage As New PageGrantContentToUsers
        NextPage.Show()
    End Sub

    Private Sub hlNewGroup_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlNewGroup.Click
        Dim NextPage As New PageGroup
        NextPage.Show()
    End Sub

    Sub PopulateGroupUserLibCombo(ByVal GroupName As String)
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt - PopulateGroupUserLibCombo 300: ")
        Dim S As String = ""
        Dim strListOfItems As String = ""
        Try
            S = S + " SELECT     Users.UserName, GroupUsers.UserID"
            S = S + " FROM         GroupUsers INNER JOIN"
            S = S + " Users ON GroupUsers.UserID = Users.UserID"
            S = S + " WHERE     (GroupUsers.GroupName = '" + GroupName + "') "
            S = S + " order by Users.UserName"

            S = ENC2.AES256EncryptString(S)
            Dim BB As Boolean = ProxySearch.getListOfStrings4(_SecureID, strListOfItems, S, RC, RetMsg, _UserID, ContractID)
            client_PopulateGroupUserLibCombo4(BB, strListOfItems, RetMsg)

        Catch ex As Exception
            SB.Text = "ERROR 33.44.1 - " + ex.Message + " / " + S
        End Try
    End Sub
    Sub client_PopulateGroupUserLibCombo4(RC As Boolean, strListOfItems As String, RetMsg As String)
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt - client_PopulateGroupUserLibCombo4 300: ")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        Dim ListOfItems As String() = strListOfItems.Split("|")

        If RC Then
            For Each S As String In ListOfItems
                cbLibrary.Items.Add(S)
            Next
        Else
            gErrorCount += 1
            If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt - ERROR client_PopulateLibraryCombo 100: " + RetMsg)
            SB.Text = ("Error loading the drop down box, please review the error log.")
        End If
        'RemoveHandler ProxySearch.getListOfStrings4Completed, AddressOf client_PopulateGroupUserLibCombo4
    End Sub

    Sub PopulateLibraryComboBox()

        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:PopulateLibraryComboBox - ERROR client_PopulateLibraryCombo 500: ")

        Dim S As String = ""
        cbLibrary.Items.Clear()
        If _isAdmin Then
            S = ""
            S = S + "Select [LibraryName] FROM [Library] order by [LibraryName]"
        Else
            S = ""
            S = S + "Select distinct LibraryName from GroupLibraryAccess " + Environment.NewLine
            S = S + " where GroupName in " + Environment.NewLine
            S = S + " (select distinct GroupName from GroupUsers where UserID = '" + gCurrLoginID + "')" + Environment.NewLine
            S = S + "             union " + Environment.NewLine
            S = S + " select distinct LibraryName from LibraryUsers where UserID = '" + gCurrLoginID + "'" + Environment.NewLine
            S = S + " and LibraryName in (select LibraryName from Library)" + Environment.NewLine
            S = S + "             union " + Environment.NewLine
            S = S + " select LibraryName from Library where UserID = '" + gCurrLoginID + "'" + Environment.NewLine
        End If

        Dim strListOfItems As String = ""
        'AddHandler ProxySearch.getListOfStrings2Completed, AddressOf client_PopulateLibraryCombo2
        'EP.setSearchSvcEndPoint(proxy)
        S = ENC2.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.getListOfStrings2(_SecureID, strListOfItems, S, RC, RetMsg, _UserID, ContractID)
        'Dim strListOfItems As String = ""
        ListOfItems = strListOfItems.Split("|")


        client_PopulateLibraryCombo2(BB, ListOfItems, RetMsg)
    End Sub
    Sub client_PopulateLibraryCombo2(RC As Boolean, ListOfItems As String(), RetMsg As String)

        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:client_PopulateLibraryCombo2 - ERROR client_PopulateLibraryCombo 501: ")

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If RC Then
            For Each S As String In ListOfItems
                cbLibrary.Items.Add(S)
            Next
        Else
            gErrorCount += 1
            If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:client_PopulateLibraryCombo2 - ERROR client_PopulateLibraryCombo 100: " + RetMsg)
            SB.Text = ("Error loading the drop down box, please review the error log.")
        End If
        'RemoveHandler ProxySearch.getListOfStrings2Completed, AddressOf client_PopulateLibraryCombo2
        FormLoaded = True
    End Sub
    Sub PopulateGroupCombo()

        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:PopulateGroupCombo - ERROR client_PopulateLibraryCombo 503: " + RetMsg)
        Me.cbGroups.Items.Clear()
        Dim S As String = ""

        If _isAdmin Then
            S = "Select [GroupName] FROM  [UserGroup]" + Environment.NewLine
            If ckMyGroupOnly.IsChecked Then
                S += "Where GroupOwnerUserID = '" + gCurrLoginID + "' "
                SB.Text = "Showing only your groups"
            Else
                SB.Text = "Admin is shown all groups in System."
            End If
            S += "order by GroupName "

        Else
            S = "WITH GroupsContainingUser (GroupName) AS"
            S = S + " ("
            S = S + "    select GroupName from GroupUsers G1 where userid = '" + gCurrLoginID + "' "
            S = S + " )"
            S = S + " Select [GroupName]"
            S = S + " FROM  [UserGroup]"
            S = S + " where GroupOwnerUserID = '" + gCurrLoginID + "'"
            S = S + " or GroupName in (select GroupName from GroupsContainingUser)"
            S = S + " order by GroupName"
            SB.Text = "All groups you own or are a member of..."
        End If

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        Dim strListOfItems As String = ""

        'S = ENC2.AES256EncryptString(S)
        ProxySearch.getListOfStrings1(_SecureID, strListOfItems, S, RC, RetMsg, _UserID, ContractID)

        If ListOfItems.Length > 0 Then
            'ListOfItems = strListOfItems.Split("|")
            client_PopulateGroupCombo1(ListOfItems, RetMsg)
        End If

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Hidden

    End Sub

    Sub client_PopulateGroupCombo1(ListOfItems As String(), RetMsg As String)

        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:client_PopulateGroupCombo1 - ERROR client_PopulateLibraryCombo 504: " + RetMsg)
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If ListOfItems.Count > 0 Then
            cbGroups.Items.Clear()
            For Each S As String In ListOfItems
                cbGroups.Items.Add(S)
            Next
        Else
            gErrorCount += 1
            If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt - NO ITEMS FOUND client_PopulateGroupCombo 100: " + RetMsg)
            SB.Text = "NO group ITEMS FOUND "
        End If
        'RemoveHandler ProxySearch.getListOfStrings1Completed, AddressOf client_PopulateGroupCombo1
    End Sub

    Sub PreviewFile()
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:client_PopulateGroupCombo1 - ERROR client_PopulateLibraryCombo 505: ")
        Dim BytesToRestore As Double = 0
        Dim bDoNotOverwriteExistingFile As Boolean = False
        Dim bOverwriteExistingFile As Boolean = True
        Dim bRestoreToOriginalDirectory As Boolean = False
        Dim bRestoreToMyDocuments As Boolean = True
        Dim bCreateOriginalDirIfMissing As Boolean = False
        Dim RepoTableName As String = ""
        Dim CurrentGuid As String = ""
        Dim ISO As New clsIsolatedStorage

        Dim L As New List(Of String)
        Dim bGoodTableName As Boolean = True

        Dim FQN As String = "NA"
        Dim iCnt As Integer = 0

        iCnt = 0
        Dim S As String = ""
        Dim DR As DataGridRow = Nothing
        Dim idx As Integer = -1
        For Each DR In dgLibItems.SelectedItems
            idx += 1
            CurrentGuid = grid.GetCellValueAsString(dgLibItems, idx, "SourceGuid")
            Dim ItemType As String = grid.GetCellValueAsString(dgLibItems, idx, "ItemType")
            ItemType = ItemType.ToUpper
            If ItemType.Equals(".MSG") Then
                RepoTableName = "Email"
                bGoodTableName = True
            ElseIf ItemType.Equals("MSG") Then
                RepoTableName = "Email"
                bGoodTableName = True
            ElseIf ItemType.Equals(".EML") Then
                RepoTableName = "Email"
                bGoodTableName = True
            ElseIf ItemType.Equals("EML") Then
                RepoTableName = "Email"
                bGoodTableName = True
            Else
                RepoTableName = "DataSource"
                bGoodTableName = True
            End If
            If RepoTableName.Equals("Email") Then
                iCnt += 1
                Dim TypeEmail As String = grid.GetCellValueAsString(dgLibItems, idx, "ItemType")
                If InStr(TypeEmail, ".") = 0 Then
                    TypeEmail = "." + TypeEmail
                End If
                Dim FileLength As String = grid.GetCellValueAsString(dgLibItems, idx, "fsize")
                BytesToRestore = BytesToRestore + CInt(FileLength)
                S = ""
                S += RepoTableName.ToUpper
                S += ChrW(254) + CurrentGuid
                S += ChrW(254) + TypeEmail
                S += ChrW(254) + "-"
                S += ChrW(254) + bDoNotOverwriteExistingFile.ToString
                S += ChrW(254) + bOverwriteExistingFile.ToString
                S += ChrW(254) + bRestoreToOriginalDirectory.ToString
                S += ChrW(254) + bRestoreToMyDocuments.ToString
                S += ChrW(254) + bCreateOriginalDirIfMissing.ToString
                L.Add(S)
            End If
            If RepoTableName.Equals("DataSource") Then
                iCnt += 1
                Dim FileExt As String = grid.GetCellValueAsString(dgLibItems, idx, "ItemType")
                If InStr(FileExt, ".") = 0 Then
                    FileExt = "." + FileExt
                End If
                Dim FileFQN As String = grid.GetCellValueAsString(dgLibItems, idx, "SourceName")
                Dim FileLength As String = grid.GetCellValueAsString(dgLibItems, idx, "fsize")
                BytesToRestore = BytesToRestore + CInt(FileLength)
                If InStr(FileExt, ".") = 0 Then
                    FileExt = "." + FileExt
                End If
                S = ""
                S += RepoTableName.ToUpper
                S += ChrW(254) + CurrentGuid
                S += ChrW(254) + FileExt
                S += ChrW(254) + FileFQN
                S += ChrW(254) + bDoNotOverwriteExistingFile.ToString
                S += ChrW(254) + bOverwriteExistingFile.ToString
                S += ChrW(254) + bRestoreToOriginalDirectory.ToString
                S += ChrW(254) + bRestoreToMyDocuments.ToString
                S += ChrW(254) + bCreateOriginalDirIfMissing.ToString
                L.Add(S)
            End If
        Next

        ISO.SaveFilePreviewGuid(gCurrLoginID, RepoTableName.ToUpper, CurrentGuid, FQN)
        ISO = Nothing
        GC.Collect()
        SB.Text = "Preview Requested " + Now.ToString

    End Sub

    Sub PopulateLibItemsGrid(ByVal LibraryName As String)
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:PopulateLibItemsGrid - PLM 99")
        If FormLoaded = False Then
            Return
        End If
        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        'AddHandler ProxySearch.PopulateLibItemsGridCompleted, AddressOf client_PopulateLibItemsGrid
        'EP.setSearchSvcEndPoint(proxy)
        Dim ObjListOfRows As String = ProxySearch.PopulateLibItemsGrid(_SecureID, LibraryName, gCurrLoginID)
        client_PopulateLibItemsGrid(ObjListOfRows)

    End Sub
    Sub client_PopulateLibItemsGrid(ObjListOfRows As String)
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:client_PopulateLibItemsGrid - PLM 100")

        Try
            dgLibItems.ItemsSource = Nothing
            dgLibItems.Items.Refresh()

            Dim ListOfRows As New System.Collections.ObjectModel.ObservableCollection(Of DS_LibItems)
            Dim jss = New JavaScriptSerializer()
            Dim ObjContent = jss.Deserialize(Of DS_LibItems())(ObjListOfRows)
            Dim Z As Integer = ObjContent.Count
            If Z < 1 Then
                SB.Text = ("No library items found for this Library.")
                Return
            End If
            For Each Obj As DS_LibItems In ObjContent
                ListOfRows.Add(Obj)
            Next

            If Z >= 1 Then
                dgLibItems.ItemsSource = ListOfRows
                'New DataView(DS.Tables(0))
            Else
                gErrorCount += 1
                XLOG.WriteTraceLog("PageLibraryMgt:client_PopulateLibItemsGrid - ERROR client_PopulateLibItemsGrid 100: ")

                MessageBox.Show("ERROR client_PopulateLibItemsGrid 100: ")
                SB.Text = ("Error loading the library items, please review the error log.")
            End If
        Catch ex As Exception

        End Try

        'RemoveHandler ProxySearch.PopulateLibItemsGridCompleted, AddressOf client_PopulateLibItemsGrid
    End Sub

    Sub PopulateLibraryGroupsGrid(ByVal LibraryName As String)
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:PopulateLibraryGroupsGrid 600: ")
        If FormLoaded = False Then
            Return
        End If
        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        PopulateDgAssigned(LibraryName)
    End Sub

    Sub PopulateGroupUserGrid(ByVal GroupName As String)
        If FormLoaded = False Then
            Return
        End If
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:PopulateGroupUserGrid 601: ")
        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        'AddHandler ProxySearch.PopulateGroupUserGridCompleted, AddressOf client_PopulateGroupUserGrid
        'EP.setSearchSvcEndPoint(proxy)
        Dim ObjListOfRows As String = ProxySearch.PopulateGroupUserGrid(_SecureID, GroupName)
        client_PopulateGroupUserGrid(ObjListOfRows)
    End Sub
    Sub client_PopulateGroupUserGrid(ObjListOfRows As String)

        If ObjListOfRows.Length <= 3 Then
            PB.IsIndeterminate = False
            PB.Visibility = Windows.Visibility.Collapsed
            Return
        End If

        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:client_PopulateGroupUserGrid 601: ")
        Dim ListOfRows As New System.Collections.ObjectModel.ObservableCollection(Of DS_dgGrpUsers)
        Dim jss = New JavaScriptSerializer()
        Dim ObjContent = jss.Deserialize(Of DS_dgGrpUsers())(ObjListOfRows)
        Dim Z As Integer = ObjContent.Count
        Dim DS As DataSet = Nothing
        Dim DT As DataTable = Nothing

        For Each Obj As DS_dgGrpUsers In ObjContent
            ListOfRows.Add(Obj)
        Next

        DS = DSMGT.ConvertObjGroupUserGridDataset(ObjContent)

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If ListOfRows.Count > 0 Then
            dgGrpUsers.ItemsSource = New DataView(DS.Tables(0))
            'dgGrpUsers.ItemsSource = ListOfRows
            dgGrpUsers.Items.Refresh()
            'dgGrpUsers.ItemsSource = DS.Tables(0)
        Else
            gErrorCount += 1
            If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:client_PopulateGroupUserGrid - ERROR client_PopulateGroupUserGrid 100: ")
            Clipboard.Clear()
            Clipboard.SetText("PageLibraryMgt - ERROR client_PopulateGroupUserGrid 100:")
            MessageBox.Show("ERROR client_PopulateGroupUserGrid 100: (error msg in clipboard)")
            SB.Text = ("Error loading group users, please review the error log.")
        End If
        PB.IsIndeterminate = False
    End Sub

    Sub RemoveSelectedLibraryItems()
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:RemoveSelectedLibraryItems 601: ")
        Me.Cursor = Cursors.Wait
        'gCurrLoginID = gCurrLoginID
        Dim ItemsRemoved As Boolean = False
        Dim LibItemOwner As String = ""

        DelCounter = 0
        DelCount = dgLibItems.SelectedItems.Count

        Dim DR As New DataGridRow
        Dim items = dgLibItems.SelectedItems

        Try
            Dim S As String = " "
            Dim idx As Integer = -1
            For Each item As DataRowView In items
                idx += 1
                iTotalProcessed += 1
                Dim LibraryItemGuid As String = item("LibraryItemGuid")
                LibItemOwner = item("LibraryOwnerUserID")
                If LibItemOwner.ToUpper.Equals(gCurrLoginID.ToUpper) Then
                    S = "Delete from LibraryItems where LibraryItemGuid  = '" + LibraryItemGuid + "'" + Environment.NewLine

                    PB.IsIndeterminate = True
                    PB.Visibility = Windows.Visibility.Visible

                    S = ENC2.AES256EncryptString(S)
                    Dim BB As Boolean = ProxySearch.ExecuteSqlNewConn1(_SecureID, S, _UserID, ContractID)
                    If BB Then
                        DelCounter += 1
                        gLogSQL(BB, ENC2.AES256DecryptString(S))
                    End If
                Else
                    SB.Text = "It appears you are not the Library owner, some items not removed."
                End If
            Next
        Catch ex As Exception
            Me.Cursor = Cursors.Arrow
            SB.Text = ex.Message.ToString
        End Try
        Me.Cursor = Cursors.Arrow
    End Sub

    Sub RestoreFiles()
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:RestoreFiles 601: ")
        Dim BytesToRestore As Double = 0
        Dim bDoNotOverwriteExistingFile As Boolean = False
        Dim bOverwriteExistingFile As Boolean = True
        Dim bRestoreToOriginalDirectory As Boolean = False
        Dim bRestoreToMyDocuments As Boolean = True
        Dim bCreateOriginalDirIfMissing As Boolean = False
        Dim RepoTableName As String = ""
        Dim CurrentGuid As String = ""
        Dim ISO As New clsIsolatedStorage

        Dim L As New List(Of String)
        Dim bGoodTableName As Boolean = True

        Dim FQN As String = "NA"
        Dim iCnt As Integer = 0

        iCnt = 0
        Dim S As String = ""
        Dim DR As DataGridRow = Nothing
        Dim DataSourceOwnerUserID As String = ""
        Dim RowIdx As Integer = -1
        For Each DR In dgLibItems.SelectedItems
            RowIdx += 1
            CurrentGuid = grid.GetCellValueAsString(dgLibItems, RowIdx, "SourceGuid")
            DataSourceOwnerUserID = grid.GetCellValueAsString(dgLibItems, RowIdx, "DataSourceOwnerUserID")
            Dim ItemType As String = grid.GetCellValueAsString(dgLibItems, RowIdx, "ItemType")
            ItemType = ItemType.ToUpper
            If ItemType.Equals(".MSG") Then
                RepoTableName = "Email"
                bGoodTableName = True
            ElseIf ItemType.Equals("MSG") Then
                RepoTableName = "Email"
                bGoodTableName = True
            ElseIf ItemType.Equals(".eml") Then
                RepoTableName = "Email"
                bGoodTableName = True
            ElseIf ItemType.Equals("EML") Then
                RepoTableName = "Email"
                bGoodTableName = True
            Else
                RepoTableName = "DataSource"
                bGoodTableName = True
            End If
            If RepoTableName.Equals("Email") Then
                iCnt += 1
                Dim TypeEmail As String = grid.GetCellValueAsString(dgLibItems, RowIdx, "ItemType")
                If InStr(TypeEmail, ".") = 0 Then
                    TypeEmail = "." + TypeEmail
                End If
                Dim FileLength As String = grid.GetCellValueAsString(dgLibItems, RowIdx, "fsize")
                BytesToRestore = BytesToRestore + CInt(FileLength)
                S = ""
                S += RepoTableName.ToUpper
                S += ChrW(254) + CurrentGuid
                S += ChrW(254) + TypeEmail
                S += ChrW(254) + "-"
                S += ChrW(254) + bDoNotOverwriteExistingFile.ToString
                S += ChrW(254) + bOverwriteExistingFile.ToString
                S += ChrW(254) + bRestoreToOriginalDirectory.ToString
                S += ChrW(254) + bRestoreToMyDocuments.ToString
                S += ChrW(254) + bCreateOriginalDirIfMissing.ToString
                L.Add(S)
                SaveRestoreHistory(ItemType, DataSourceOwnerUserID, CurrentGuid)
            End If
            If RepoTableName.Equals("DataSource") Then
                DataSourceOwnerUserID = grid.GetCellValueAsString(dgLibItems, RowIdx, "DataSourceOwnerUserID")
                iCnt += 1
                Dim FileExt As String = grid.GetCellValueAsString(dgLibItems, RowIdx, "ItemType")
                If InStr(FileExt, ".") = 0 Then
                    FileExt = "." + FileExt
                End If
                Dim FileFQN As String = grid.GetCellValueAsString(dgLibItems, RowIdx, "ItemTitle")
                Dim FileLength As String = grid.GetCellValueAsString(dgLibItems, RowIdx, "fsize")
                BytesToRestore = BytesToRestore + CInt(FileLength)
                If InStr(FileExt, ".") = 0 Then
                    FileExt = "." + FileExt
                End If
                S = ""
                S += RepoTableName.ToUpper
                S += ChrW(254) + CurrentGuid
                S += ChrW(254) + FileExt
                S += ChrW(254) + FileFQN
                S += ChrW(254) + bDoNotOverwriteExistingFile.ToString
                S += ChrW(254) + bOverwriteExistingFile.ToString
                S += ChrW(254) + bRestoreToOriginalDirectory.ToString
                S += ChrW(254) + bRestoreToMyDocuments.ToString
                S += ChrW(254) + bCreateOriginalDirIfMissing.ToString
                L.Add(S)
                SaveRestoreHistory(ItemType, DataSourceOwnerUserID, CurrentGuid)
            End If
        Next

        ISO.SaveFileRestoreData(gCurrLoginID, L)
        ISO = Nothing

        GC.Collect()
        GC.WaitForPendingFinalizers()
        MessageBox.Show("Restore request posted for " + iCnt.ToString + " files / Total Bytes: " + BytesToRestore.ToString)

    End Sub
    Sub SaveRestoreHistory(ByVal setTypecontentcode As String, ByVal OwnerID As String, ByVal SourceGuid As String)
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:SaveRestoreHistory 601: ")
        DRHIST.setRestoreuserid(_UserID)
        DRHIST.setRestoreusername(_UserID)
        DRHIST.setRestoredtomachine(DMA.GetCurrMachineName)
        DRHIST.setRestoreuserdomain(System.Environment.OSVersion.ToString)
        DRHIST.setTypecontentcode(setTypecontentcode)
        DRHIST.setSourceguid(SourceGuid)
        DRHIST.setDatasourceowneruserid(OwnerID)
        Dim BBB As Boolean = DRHIST.Insert

        setDataSourceRestoreHistoryParms()

    End Sub


    Private Sub btnRemoveItem_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnRemoveItem.Click
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:btnRemoveItem_Click 601: ")
        RemoveSelectedLibraryItems()
    End Sub

    Private Sub btnRestore_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnRestore.Click
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:btnRestore_Click 601: ")
        RestoreFiles()
    End Sub


    Private Sub dgAssigned_SelectionChanged(ByVal sender As System.Object, ByVal e As SelectionChangedEventArgs) Handles dgAssigned.SelectionChanged
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:dgAssigned_SelectionChanged 601: ")
        Dim GroupName As String = grid.GetCellValueAsString(dgAssigned, dgAssigned.SelectedIndex, "GroupName")

        cbGroups.Text = GroupName
        PopulateGroupUserGrid(GroupName)

    End Sub

    Sub client_AddLibraryGroupUser(RC As Boolean)

        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:client_AddLibraryGroupUser 601: ")

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If RC Then
            Dim B As Boolean = RC
            If B Then
                Console.WriteLine("Success: client_AddLibraryGroupUser")

                PopulateDgAssigned(cbLibrary.Text)
                PopulateGroupUserGrid(cbGroups.Text)

            Else
                If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:client_AddLibraryGroupUser - ERROR client_AddLibraryGroupUser: 10: FAILED TO EXECUTE.")
            End If
        Else
            If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:client_AddLibraryGroupUser - ERROR client_AddLibraryGroupUser: 100")
        End If
        'RemoveHandler ProxySearch.AddLibraryGroupUserCompleted, AddressOf client_AddLibraryGroupUser
    End Sub

    Sub PopulateDgAssigned(ByVal LibraryName As String)
        'gCurrLoginID = gCurrLoginID
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:PopulateDgAssigned 601: ")
        cbLibrary.IsEnabled = False
        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        'AddHandler ProxySearch.PopulateDgAssignedCompleted, AddressOf client_PopulateDgAssigned
        'EP.setSearchSvcEndPoint(proxy)
        'Dim ObjListOfRows As Object = ProxySearch.PopulateDgAssigned(_SecureID, LibraryName, gCurrLoginID)
        Dim json As String = ProxySearch.PopulateDgAssigned(_SecureID, LibraryName, gCurrLoginID)
        client_PopulateDgAssigned(json)
    End Sub
    Sub client_PopulateDgAssigned(json As String)
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:client_PopulateDgAssigned - client_PopulateDgAssigned 300: ")
        Dim L As Integer = 0
        Try
            Dim ListOfRows As New System.Collections.ObjectModel.ObservableCollection(Of DS_DgAssigned) : L = 1
            Dim jss = New JavaScriptSerializer() : L = 2
            Dim ObjContent = jss.Deserialize(Of DS_DgAssigned())(json) : L = 3
            Dim Z As Integer = ObjContent.Count : L = 4

            dgAssigned.ItemsSource = Nothing : L = 5
            dgAssigned.Items.Refresh() : L = 6

            If Z < 1 Then
                Return
            End If

            Dim DS As DataSet : L = 7
            DS = DSMGT.ConvertObjToDgAssignedDataset(ObjContent) : L = 8

            If DS.Tables(0).Rows.Count > 0 Then
                dgAssigned.ItemsSource = New DataView(DS.Tables(0))
                dgAssigned.Items.Refresh() : L = 13
            Else
                gErrorCount += 1
                If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt - ERROR: client_PopulateDgAssigned 101 - Line# " + L.ToString)
                MessageBox.Show("ERROR: client_PopulateDgAssigned 101 - Line# " + L.ToString)
            End If
        Catch ex As Exception
            If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt - ERROR: client_PopulateDgAssigned 101B -  - Line# " + L.ToString + Environment.NewLine + ex.Message)
            MessageBox.Show("PageLibraryMgt - ERROR: client_PopulateDgAssigned 101B -  - Line# " + L.ToString + Environment.NewLine + ex.Message)
        End Try

        'RemoveHandler ProxySearch.PopulateDgAssignedCompleted, AddressOf client_PopulateDgAssigned
        cbLibrary.IsEnabled = True
        PB.IsIndeterminate = False
        PB.Visibility = Visibility.Hidden
    End Sub

    Sub setDataSourceRestoreHistoryParms()
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:setDataSourceRestoreHistoryParms 300: ")
        Dim S As String = ""
        Dim B As Boolean = False
        'gCurrLoginID = gCurrLoginID
        Dim EncString = ""
        S = S + " update DataSourceRestoreHistory  "
        S = S + " set  DocumentName = (select SourceName from DataSource "
        S = S + " where DataSource.SourceGuid = DataSourceRestoreHistory.SourceGuid) "
        S = S + " where VerifiedData = 'N' "
        S = S + " and TypeContentCode <> '.msg' "
        S = S + " and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + gCurrLoginID + "'"
        'AddHandler ProxySearch.ExecuteSqlNewConn1Completed, AddressOf client_ExecuteSqlNewConn1
        'EP.setSearchSvcEndPoint(proxy)

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        S = ENC2.AES256EncryptString(S)
        B = ProxySearch.ExecuteSqlNewConn1(_SecureID, S, _UserID, ContractID)
        gLogSQL(B, ENC2.AES256DecryptString(S))

        S = " update DataSourceRestoreHistory  "
        S = S + " set  FQN = (select FQN from DataSource "
        S = S + " where DataSource.SourceGuid = DataSourceRestoreHistory.SourceGuid) "
        S = S + " where VerifiedData = 'N' "
        S = S + " and TypeContentCode <> '.msg' "
        S = S + " and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + gCurrLoginID + "'"
        'AddHandler ProxySearch.ExecuteSqlNewConn2Completed, AddressOf client_ExecuteSqlNewConn2
        'EP.setSearchSvcEndPoint(proxy)


        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        S = ENC2.AES256EncryptString(S)
        B = ProxySearch.ExecuteSqlNewConn2(_SecureID, S, _UserID, ContractID)
        gLogSQL(B, ENC2.AES256DecryptString(S))

        S = " update DataSourceRestoreHistory "
        S = S + " set  DocumentName = (select ShortSubj from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)"
        S = S + " where VerifiedData = 'N' and TypeContentCode = '.msg' and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + gCurrLoginID + "'"
        'AddHandler ProxySearch.ExecuteSqlNewConn3Completed, AddressOf client_ExecuteSqlNewConn3
        'EP.setSearchSvcEndPoint(proxy)


        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        S = ENC2.AES256EncryptString(S)
        B = ProxySearch.ExecuteSqlNewConn3(_SecureID, S, _UserID, ContractID)
        gLogSQL(B, ENC2.AES256DecryptString(S))

        S = "update DataSourceRestoreHistory "
        S = S + " set  FQN = (select 'EMAIL' from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)"
        S = S + " where VerifiedData = 'N' and TypeContentCode = '.msg'  and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + gCurrLoginID + "'"
        'AddHandler ProxySearch.ExecuteSqlNewConn4Completed, AddressOf client_ExecuteSqlNewConn4
        'EP.setSearchSvcEndPoint(proxy)


        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        S = ENC2.AES256EncryptString(S)
        B = ProxySearch.ExecuteSqlNewConn4(_SecureID, S, _UserID, ContractID)
        gLogSQL(B, ENC2.AES256DecryptString(S))

        S = "update DataSourceRestoreHistory "
        S = S + " set  FQN = (select 'EMAIL' from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)"
        S = S + " where VerifiedData = 'N' and TypeContentCode = '.eml'  and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + gCurrLoginID + "'"
        'AddHandler ProxySearch.ExecuteSqlNewConn5Completed, AddressOf client_ExecuteSqlNewConn5
        'EP.setSearchSvcEndPoint(proxy)


        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        S = ENC2.AES256EncryptString(S)
        B = ProxySearch.ExecuteSqlNewConn1(_SecureID, S, _UserID, ContractID)
        gLogSQL(B, ENC2.AES256DecryptString(S))

        S = " update DataSourceRestoreHistory "
        S = S + " set  VerifiedData = (select 'Y' from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)"
        S = S + " where VerifiedData = 'N'  and TypeContentCode = '.msg' and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + gCurrLoginID + "'"
        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn2_9_10_816
        'EP.setSearchSvcEndPoint(proxy)

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        S = ENC2.AES256EncryptString(S)
        B = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, _UserID, ContractID)
        gLogSQL(B, ENC2.AES256DecryptString(S))

        S = " update DataSourceRestoreHistory "
        S = S + " set  VerifiedData = (select 'Y' from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)"
        S = S + " where VerifiedData = 'N'  and TypeContentCode = '.eml' and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + gCurrLoginID + "'"
        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn_11_10_753
        'EP.setSearchSvcEndPoint(proxy)

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        S = ENC2.AES256EncryptString(S)
        B = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, _UserID, ContractID)
        gLogSQL(B, ENC2.AES256DecryptString(S))

        S = " Update DataSourceRestoreHistory "
        S = S + " set  VerifiedData = (select 'Y' from DataSource where DataSource.SourceGuid = DataSourceRestoreHistory.SourceGuid)"
        S = S + " where VerifiedData = 'N'  and TypeContentCode <> '.msg' and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + gCurrLoginID + "'"
        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn_11_25_201
        'EP.setSearchSvcEndPoint(proxy)

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        S = ENC2.AES256EncryptString(S)
        B = ProxySearch.ExecuteSqlNewConn4(_SecureID, S, _UserID, ContractID)
        gLogSQL(B, ENC2.AES256DecryptString(S))

    End Sub

    Sub client_ResetLibraryUsersCount(RC As Boolean)
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:client_ResetLibraryUsersCount 300: ")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        Dim TrackingNbr As Integer = 0
        Me.Cursor = Cursors.Arrow
        If Not RC Then
            gErrorCount += 1
            If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt:client_ResetLibraryUsersCount - ERROR 166.92: client_ResetLibraryUsersCount 101 - ")
            MessageBox.Show("ERROR 166.92:client_ResetLibraryUsersCount101 - ")
        End If

    End Sub
    Sub client_DeleteLibraryGroupUser(RC As Boolean)

        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt: client_DeleteLibraryGroupUser 101")

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        Dim TrackingNbr As Integer = 0
        If Not RC Then
            gErrorCount += 1
            If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt - NOTICE: client_DeleteLibraryGroupUser 101 - failed to remove group users - ")
            MessageBox.Show("NOTICE: client_DeleteLibraryGroupUser 101 - failed to remove group users - ")
        End If
    End Sub

    Sub gLogSQL(RC As Boolean, S As String)

        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt: gLogSQL 101")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        Dim TrackingNbr As Integer = 0
        If RC Then
            If bPopulateGroupUsers Then
                bPopulateGroupUsers = False
                PopulateDgAssigned(CurrSelectedLibName)
                'AddHandler ProxySearch.ResetLibraryUsersCountCompleted, AddressOf client_ResetLibraryUsersCount
                'EP.setSearchSvcEndPoint(proxy)
                ProxySearch.ResetLibraryUsersCount(_SecureID, RC)
                client_ResetLibraryUsersCount(RC)
            End If
            If bPopulateAssignedUsers Then
                bPopulateAssignedUsers = False
                PopulateDgAssigned(CurrSelectedLibName)
                'AddHandler ProxySearch.ResetLibraryUsersCountCompleted, AddressOf client_ResetLibraryUsersCount
                'EP.setSearchSvcEndPoint(proxy)
                ProxySearch.ResetLibraryUsersCount(_SecureID, RC)
                client_ResetLibraryUsersCount(RC)
            End If
            If bDeleteGroupAccess Then
                bDeleteGroupAccess = False
                PopulateDgAssigned(CurrSelectedLibName)
                'AddHandler ProxySearch.ResetLibraryUsersCountCompleted, AddressOf client_ResetLibraryUsersCount
                'EP.setSearchSvcEndPoint(proxy)
                ProxySearch.ResetLibraryUsersCount(_SecureID, RC)
                client_ResetLibraryUsersCount(RC)
            End If
        Else
            gErrorCount += 1
            If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt - ERROR clsSql 100: ")
        End If
        'RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
    End Sub


    Protected Overrides Sub Finalize()
        Try
            If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt: Finalize 101")
        Finally
            MyBase.Finalize()      'define the destructor
            ''RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
            ''RemoveHandler ProxySearch.ExecuteSqlNewConn1Completed, AddressOf client_ExecuteSqlNewConn1
            ''RemoveHandler ProxySearch.ExecuteSqlNewConn2Completed, AddressOf client_ExecuteSqlNewConn2
            ''RemoveHandler ProxySearch.ExecuteSqlNewConn3Completed, AddressOf client_ExecuteSqlNewConn3
            ''RemoveHandler ProxySearch.ExecuteSqlNewConn4Completed, AddressOf client_ExecuteSqlNewConn4
            ''RemoveHandler ProxySearch.ExecuteSqlNewConn5Completed, AddressOf client_ExecuteSqlNewConn5

            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub

    Private Sub hlRefreshGRps_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlRefreshGRps.Click
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt: hlRefreshGRps_Click 101")
        PopulateDgAssigned(cbLibrary.Text)
        PopulateGroupCombo()

    End Sub

    Private Sub hlRemoveGroup_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlRemoveGroup.Click
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt: hlRemoveGroup_Click 101")
        Me.Cursor = Cursors.Wait
        Dim RC As Boolean = False
        bPopulateGroupUsers = True
        bPopulateAssignedUsers = True

        LibraryName = cbLibrary.Text.Trim
        CurrSelectedLibName = LibraryName
        Dim Proceed As Boolean = False

        hlRemoveGroup.IsEnabled = False

        Dim msg As String = "This will remove this group and all associated users - cannot be undone, ARE YOU SURE?"
        Dim result As MessageBoxResult = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel)

        If result = MessageBoxResult.Cancel Then
            SB.Text = "Cancelled group delete."
            hlRemoveGroup.IsEnabled = True
            Return
        End If

        Dim items = dgAssigned.SelectedItems

        For Each item As DataRowView In items
            Dim GroupName As String = item("GroupName")
            bPopulateGroupUsers = True
            'AddHandler ProxySearch.DeleteLibraryGroupUserCompleted, AddressOf client_DeleteLibraryGroupUser
            'EP.setSearchSvcEndPoint(proxy)

            ProxySearch.DeleteLibraryGroupUser(_SecureID, GroupName, LibraryName, RC)
            client_DeleteLibraryGroupUser(RC)

            Dim S As String = " "
            LibraryName = UTIL.RemoveSingleQuotes(LibraryName)
            GroupName = UTIL.RemoveSingleQuotes(GroupName)

            bDeleteGroupAccess = True
            S = "delete FROM GroupLibraryAccess where GroupName = '" + GroupName + "' and LibraryName = '" + LibraryName + "'"

            'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn_54_28_857
            'EP.setSearchSvcEndPoint(proxy)
            S = ENC2.AES256EncryptString(S)
            Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, _UserID, ContractID)
            gLogSQL(BB, ENC2.AES256DecryptString(S))
        Next

        hlRemoveGroup.IsEnabled = True

        Me.Cursor = Cursors.Arrow

        SB.Text = "Removal complete."
    End Sub

    Private Sub hlAssignGroup_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlAssignGroup.Click
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt: hlAssignGroup_Click 101")
        Dim GroupName As String = cbGroups.SelectedItem
        Dim LibraryName As String = cbLibrary.SelectedItem

        'AddHandler ProxySearch.AddGroupLibraryAccessCompleted, AddressOf client_AddGroupLibraryAccess
        'EP.setSearchSvcEndPoint(proxy)
        's = ENC2.AES256EncryptString(s)
        ProxySearch.AddGroupLibraryAccess(_SecureID, _UserID, LibraryName, GroupName, _UserID, RC, _UserID, ContractID, "SRCH")
        client_AddGroupLibraryAccess(RC)

    End Sub
    Sub client_AddGroupLibraryAccess(RC As Boolean)

        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt: client_AddGroupLibraryAccess 101")

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If RC Then
            PopulateDgAssigned(cbLibrary.Text)
            SB.Text = "Added group."
            'AddHandler ProxySearch.AddLibraryGroupUserCompleted, AddressOf client_AddLibraryGroupUser
            'EP.setSearchSvcEndPoint(proxy)
            ProxySearch.AddLibraryGroupUser(_SecureID, cbGroups.Text, RC, RC, _UserID, ContractID)
            client_AddLibraryGroupUser(RC)
        Else
            If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt - NOTICE client_AddGroupLibraryAccess 'Group Already exists, skipped' - A")
            SB.Text = "Notice: group not added."
        End If
        'RemoveHandler ProxySearch.AddGroupLibraryAccessCompleted, AddressOf client_AddGroupLibraryAccess
    End Sub


    Sub PopulateSelectedLibraryItems()
        If FormLoaded = False Then
            Return
        End If
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt: PopulateSelectedLibraryItems 101")
        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        Me.Cursor = Cursors.Wait
        LibraryName = cbLibrary.SelectedItem

        If LibraryName.Trim.Length = 0 Then
            Me.Cursor = Cursors.Arrow
            SB.Text = "Select a library..."
            Return
        End If

        LibraryName = UTIL.RemoveSingleQuotes(LibraryName)

        PopulateLibItemsGrid(LibraryName)
        PopulateDgAssigned(cbLibrary.Text)
        'PopulateLibraryGroupsGrid(LibraryName)

        LibraryName = UTIL.RemoveMultiSingleQuotes(LibraryName)

        Me.Cursor = Cursors.Arrow
        SB.Text = "Current library: " + LibraryName + ", contains " + Me.dgLibItems.Items.Count.ToString + " items."
        PB.IsIndeterminate = False
        PB.Visibility = Visibility.Hidden
    End Sub

    Private Sub dgLibItems_MouseEnter(ByVal sender As System.Object, ByVal e As System.Windows.Input.MouseEventArgs) Handles dgLibItems.MouseEnter
        SB.Text = "Current library: " + cbLibrary.Text + ", contains " + Me.dgLibItems.Items.Count.ToString + " items."
    End Sub

    Private Sub hlValidate_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlValidate.Click
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt: hlValidate_Click 101")
        Dim S As String = ""
        S = " delete from LibraryItems" + Environment.NewLine
        S += " where SourceGuid not in (Select SourceGuid from datasource) " + Environment.NewLine
        S += " and SourceGuid not in (Select EmailGuid from Email)" + Environment.NewLine

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        S = ENC2.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConn1(_SecureID, S, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256DecryptString(S))

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Hidden

    End Sub

    Private Sub ckMyGroupOnly_Checked(sender As Object, e As RoutedEventArgs) Handles ckMyGroupOnly.Checked

    End Sub

    Private Sub dgLibItems_MouseDoubleClick(sender As Object, e As MouseButtonEventArgs) Handles dgLibItems.MouseDoubleClick
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt: dgLibItems_MouseDoubleClick 101")
        Dim TempDir As String = System.IO.Path.GetTempPath

        Dim SourceWorkingDirectory As String = TempDir
        Dim EmailWorkingDirectory As String = TempDir

        Dim iSelected As Integer = dgLibItems.SelectedItems.Count
        If iSelected < 1 Then
            SB.Text = "One or more rows must be selected for restore, returning."
            Return
        End If

        PreviewFile()

        PB.Value = 0
    End Sub

    Private Sub cbLibrary_SelectionChanged(sender As Object, e As SelectionChangedEventArgs) Handles cbLibrary.SelectionChanged
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt: cbLibrary_SelectionChanged 101")
        PopulateSelectedLibraryItems()
    End Sub

    Private Sub cbGroups_SelectionChanged(sender As Object, e As SelectionChangedEventArgs) Handles cbGroups.SelectionChanged
        If FormLoaded = False Then
            Return
        End If
        If ddebug Then XLOG.WriteTraceLog("PageLibraryMgt: cbGroups_SelectionChanged 101")
        dgAssigned.Visibility = Visibility.Visible
        dgGrpUsers.Visibility = Visibility.Visible

        Dim Groupname = cbGroups.Text
        Groupname = Groupname.Replace("''", "'")

        If Groupname.Length = 0 Then
            SB.Text = "Pick a group please..."
            Return
        End If

        Dim groupowneruserid As String = gCurrLoginID
        PopulateGroupUserGrid(cbGroups.Text)
        PopulateDgAssigned(cbGroups.Text)

    End Sub
End Class

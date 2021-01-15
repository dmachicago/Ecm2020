﻿Imports System.Data
Imports System.Web.Script.Serialization
Imports ECMEncryption

Public Class PageLibrary
    'Inherits Page

    Dim ENC As New ECMEncrypt
    Dim COMMON As New clsCommonFunctions
    Dim UTIL As New clsUtility
    Dim HIVE As New clsHive
    Dim LOG As New clsLogMain
    Dim LU As New clsLIBRARYUSERS
    Dim DSMGT As clsDatasetMgt = New clsDatasetMgt()
    Dim XLOG As clsLoggingExtended = New clsLoggingExtended

    Dim gSecureID As String = -1
    Dim bPopulateLibraries As Boolean = False
    Dim LibraryName As String = ""
    Dim isPublic As String = ""
    Dim ListBoxItems As New System.Collections.ObjectModel.ObservableCollection(Of String)

    Dim UserID As String = ""
    Dim FormLoaded As Boolean = False


    Public Sub New()
        InitializeComponent()

        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 01")
        gSecureID = _SecureID

        '** Set global variables
        UserID = gCurrLoginID
        'gCurrLoginid = gCurrLoginid

        PopulateLibraryGrid()

        COMMON.SaveClick(5500, UserID)

        SB.Text = ""

        hlLibMgt.Visibility = Visibility.Hidden
        hlHome.Visibility = Visibility.Hidden

    End Sub

    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnDelete.Click
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 02")
        bPopulateLibraries = True

        Dim II As Integer = dgLibrary.SelectedIndex
        If II < 0 Then
            MessageBox.Show("An item in the list must be selected, returning.")
            Return
        End If

        Dim msg As String = "This will delete the selected Library, user associations, and ALL of the associated content, ARE YOU SURE?"
        Dim dlgRes As MessageBoxResult = MessageBox.Show(msg, "Remove Library", MessageBoxButton.OKCancel)
        If dlgRes = MessageBoxResult.No Then
            Return
        End If

        Dim tLib As String = fetchCellValue(dgLibrary, "LibraryName")
        tLib = tLib.Replace("'", "''")

        Dim LibName As String = tLib

        If LibName.Trim.Length = 0 Then
            MessageBox.Show("User Library name must be supplied, aborting delete.")
            Return
        End If

        Dim iRow As Integer = dgLibrary.SelectedIndex
        Dim SelectedLibraryName As String = grid.GetCellValueAsString(dgLibrary, "LibraryName")
        LibName = SelectedLibraryName.Replace("'", "''")
        Dim SS As String = ""
        Dim BB As Boolean = False

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        SS = "delete from GroupLibraryAccess where LibraryName = '" + LibName + "'"
        Dim EncString As String = ENC.AES256EncryptString(SS)
        BB = ProxySearch.ExecuteSqlNewConn1(_SecureID, EncString, gCurrLoginID, ContractID)
        gLogSQL(BB, ENC.AES256EncryptString(EncString))

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        SS = "delete from LibraryUsers where LibraryName = '" + LibName + "'"
        SS = ENC.AES256EncryptString(SS)
        BB = ProxySearch.ExecuteSqlNewConn2(_SecureID, SS, gCurrLoginID, ContractID)
        gLogSQL(BB, ENC.AES256DecryptString(SS))

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        SS = "delete from LibraryItems where LibraryName = '" + LibName + "'"
        SS = ENC.AES256EncryptString(SS)
        BB = ProxySearch.ExecuteSqlNewConn3(_SecureID, SS, gCurrLoginID, ContractID)
        gLogSQL(BB, ENC.AES256DecryptString(SS))

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        SS = "delete from Library  where LibraryName = '" + LibName + "'"
        SS = ENC.AES256EncryptString(SS)
        BB = ProxySearch.ExecuteSqlNewConn4(_SecureID, SS, gCurrLoginID, ContractID)
        gLogSQL(BB, ENC.AES256DecryptString(SS))

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        Dim DelSql As String = "Delete from Library Where LibraryName = '" + LibName + "' and   UserID = '" + gCurrLoginID + "'"
        DelSql = ENC.AES256EncryptString(DelSql)
        BB = ProxySearch.ExecuteSqlNewConn5(_SecureID, DelSql, gCurrLoginID, ContractID)
        gLogSQL(BB, ENC.AES256EncryptString(DelSql))

        PB.IsIndeterminate = False
        PB.Visibility = Visibility.Hidden

        cleanUpLibraryItems()
        PopulateLibraryGrid()

    End Sub

    Public Sub cleanUpLibraryItems()
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 03")
        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        'Dim proxy As New SVCSearch.Service1Client

        Dim S As String = ""
        S = S + " delete from LibraryItems where " + Environment.NewLine
        S = S + " SourceGuid not in (select emailguid as TgtGuid from Email" + Environment.NewLine
        S = S + " union " + Environment.NewLine
        S = S + " select sourceguid as TgtGuid from DataSource)"

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn_3_34_42
        'EP.setSearchSvcEndPoint(proxy)
        S = ENC.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, gCurrLoginID, ContractID)
        gLogSQL(BB, ENC.AES256EncryptString(S))

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        'AddHandler ProxySearch.ExecuteSqlNewConn1Completed, AddressOf client_ExecuteSqlNewConn1
        'EP.setSearchSvcEndPoint(proxy)
        S = "delete FROM LibraryItems where LibraryName not in  (select LibraryName from Library)"
        S = ENC.AES256EncryptString(S)
        BB = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, gCurrLoginID, ContractID)
        gLogSQL(BB, ENC.AES256EncryptString(S))

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        'AddHandler ProxySearch.ExecuteSqlNewConn2Completed, AddressOf client_ExecuteSqlNewConn2
        'EP.setSearchSvcEndPoint(proxy)
        S = "delete from LibraryUsers where LibraryName not in  (select LibraryName from Library)"
        S = ENC.AES256EncryptString(S)
        BB = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, gCurrLoginID, ContractID)
        gLogSQL(BB, ENC.AES256EncryptString(S))

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        'AddHandler ProxySearch.ExecuteSqlNewConn3Completed, AddressOf client_ExecuteSqlNewConn3
        'EP.setSearchSvcEndPoint(proxy)
        S = "delete from LibraryUsers where UserID not in  (select userid from users)"

        S = ENC.AES256EncryptString(S)
        BB = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, gCurrLoginID, ContractID)
        gLogSQL(BB, ENC.AES256EncryptString(S))

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        'AddHandler ProxySearch.ExecuteSqlNewConn4Completed, AddressOf client_ExecuteSqlNewConn4
        'EP.setSearchSvcEndPoint(proxy)
        S = "delete from GroupUsers where UserID not in (select userid from users) "

        S = ENC.AES256EncryptString(S)
        BB = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, gCurrLoginID, ContractID)
        gLogSQL(BB, ENC.AES256EncryptString(S))

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        'AddHandler ProxySearch.ExecuteSqlNewConn5Completed, AddressOf client_ExecuteSqlNewConn5
        'EP.setSearchSvcEndPoint(proxy)
        S = "delete from GroupUsers where GroupName not in (select GroupName from UserGroup) "

        S = ENC.AES256EncryptString(S)
        BB = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, gCurrLoginID, ContractID)
        gLogSQL(BB, ENC.AES256EncryptString(S))

    End Sub

    Sub client_ExecuteSqlNewConn_3_34_42(RC As Boolean, S As String)
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 04")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If Not RC Then
            Dim ErrSql As String = S
            LOG.WriteToSqlLog("ERROR client_ExecuteSqlNewConn_3_34_42: 3_34_42" + S)
        End If
        'RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn_3_34_42
    End Sub

    Private Sub BtnAdd_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles BtnAdd.Click

        'gCurrLoginid = gCurrLoginid
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 05")
        Dim UserLibrary As String = txtLibrary.Text.Trim
        UserLibrary = UserLibrary.Replace("'", "''")

        If UserLibrary.Trim.Length = 0 Then
            MessageBox.Show("User Library name must be supplied, aborting insert.")
            Return
        End If

        AddLibrary()
        PopulateLibraryGrid()
    End Sub

    Sub AddLibrary()
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 06")
        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        Dim LibraryName As String = txtLibrary.Text
        LibraryName = LibraryName.Replace("'", "''")
        Dim S As String = "Select count(*) from Library where LibraryName = '" + LibraryName + "'"

        'AddHandler ProxySearch.iCountCompleted, AddressOf client_iCountLibrary
        'EP.setSearchSvcEndPoint(proxy)
        Dim II As Integer = ProxySearch.iCount(_SecureID, S)
        client_iCountLibrary(II)

    End Sub

    Sub client_iCountLibrary(I As Integer)
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 07")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        'gCurrLoginid = gCurrLoginid
        If I = 1 Then
            If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 07A")
            Dim YesNo As String = ""
            If ckNewLibPublic.IsChecked Then
                YesNo = "Y"
            Else
                YesNo = "N"
            End If

            Dim LibName As String = txtLibrary.Text.Trim
            LibName = LibName.Replace("'", "''")

            Dim s As String = ""
            s = s + " update Library set "
            s = s + "isPublic = '" + YesNo + "' "
            s = s + "where UserID = '" + gCurrLoginID + "' and LIbraryName = '" + LibName + "' "

            PB.IsIndeterminate = True
            PB.Visibility = Windows.Visibility.Visible

            'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn_58_42_742
            'EP.setSearchSvcEndPoint(proxy)
            s = ENC.AES256EncryptString(s)
            Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, s, gCurrLoginID, ContractID)
            gLogSQL(BB, ENC.AES256EncryptString(s))

        End If
        If I = 0 Then
            If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 07B")
            Dim YesNo As String = ""
            If ckNewLibPublic.IsChecked Then
                YesNo = "Y"
            Else
                YesNo = "N"
            End If

            Dim LibName As String = txtLibrary.Text.Trim
            LibName = LibName.Replace("'", "''")

            Dim s As String = ""
            s = s + " INSERT INTO Library("
            s = s + "UserID,"
            s = s + "LibraryName,"
            s = s + "isPublic) values ("
            s = s + "'" + gCurrLoginID + "'" + ","
            s = s + "'" + LibName + "'" + ","
            s = s + "'" + YesNo + "'" + ")"

            PB.IsIndeterminate = True
            PB.Visibility = Windows.Visibility.Visible

            'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn_58_42_742
            'EP.setSearchSvcEndPoint(proxy)
            s = ENC.AES256EncryptString(s)
            Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, s, gCurrLoginID, ContractID)
            gLogSQL(BB, ENC.AES256EncryptString(s))

            LU.setDeleteaccess("1")
            LU.setCreateaccess("1")
            LU.setLibraryname(LibName)
            LU.setLibraryowneruserid(gCurrLoginID)
            LU.setReadonly("0")
            LU.setUpdateaccess("1")
            LU.setUserid(gCurrLoginID)
            LU.Insert(1, 1, Nothing)

            UpdateHiveNames()
            SB.Text = "Library added."
        ElseIf I < 0 Then
            SB.Text = "Failed insert..."
        Else
            SB.Text = "Library already exists, choose a different name."
        End If

        'RemoveHandler ProxySearch.iCountCompleted, AddressOf client_iCountLibrary

    End Sub

    Sub client_ExecuteSqlNewConn_58_42_742(RC As Boolean, S As String)
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 08")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If RC Then
            Dim B As Boolean = RC
            If Not B Then
                LOG.WriteToSqlLog("ERROR SQL: client_ExecuteSqlNewConn_58_42_742: " + S)
            Else
                PopulateLibraryGrid()
            End If
        Else
            LOG.WriteToSqlLog("ERROR client_ExecuteSqlNewConn_58_42_742: 58_42_742" + S)
        End If
        'RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn_58_42_742
    End Sub

    Sub UpdateHiveNames()
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 09")
        HIVE.updateHiveRepoName("Library")
        HIVE.updateHiveRepoName("LibraryItems")
        HIVE.updateHiveRepoName("LibraryUsers")
        HIVE.updateHiveRepoName("LibEmail")
        HIVE.updateHiveRepoName("LibDirectory")

        HIVE.updateHiveServerName("Library")
        HIVE.updateHiveServerName("LibraryItems")
        HIVE.updateHiveServerName("LibraryUsers")
        HIVE.updateHiveServerName("LibEmail")
        HIVE.updateHiveServerName("LibDirectory")

    End Sub

    Sub PopulateLibraryGrid()
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 10")
        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        dgLibrary.ItemsSource = Nothing

        Dim MySql As String = "Select [LibraryName] FROM [Library] where [UserID] = '" + gCurrLoginID + "' order by LibraryName"
        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        'AddHandler ProxySearch.PopulateLibraryGridCompleted, AddressOf client_PopulateGrid
        'EP.setSearchSvcEndPoint(proxy)
        Dim ObjListOfRows As String = ProxySearch.PopulateLibraryGrid(gSecureID, gCurrLoginID)

        Dim DS As DataSet = DSMGT.ConvertObjToLibraryDataset(ObjListOfRows)
        dgLibrary.ItemsSource = Nothing
        dgLibrary.ItemsSource = New DataView(DS.Tables(0))
        dgLibrary.Items.Refresh()

        PB.IsIndeterminate = False
        PB.Visibility = Visibility.Hidden

        'client_PopulateGrid(ObjListOfRows)
    End Sub

    Sub client_PopulateGrid(ObjListOfRows As Object)
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 11")
        Dim ListOfRows As New System.Collections.ObjectModel.ObservableCollection(Of DS_VLibraryStats)
        Dim jss = New JavaScriptSerializer()
        Dim ObjContent = jss.Deserialize(Of DS_VLibraryStats())(ObjListOfRows)
        Dim Z As Integer = ObjContent.Count
        For Each Obj As DS_VLibraryStats In ObjContent
            ListOfRows.Add(Obj)
        Next

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        Dim RC As Boolean = False
        Dim RetMsg As String = ""
        dgLibrary.ItemsSource = Nothing
        If ListOfRows.Count > 0 Then
            dgLibrary.ItemsSource = ListOfRows
            dgLibrary.Items.Refresh()
            SB.Text = ListOfRows.Count.ToString + " libraries found."
        Else
            If ListOfRows.Count.Equals(0) Then
                MessageBox.Show("No Libraries defined.")
            End If
            LOG.WriteToSqlLog("ERROR PageLibrary 200: No Libraries defined")
            dgLibrary.ItemsSource = Nothing
            gErrorCount += 1
        End If
        PB.IsIndeterminate = False
        'RemoveHandler ProxySearch.PopulateLibraryGridCompleted, AddressOf client_PopulateGrid
        dgLibrary.IsEnabled = True
    End Sub

    Private Sub hlHome_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlHome.Click
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 11")
        'Dim NextPage As New MainPage()
        'NextPage.show
        Me.Close()
    End Sub

    Private Sub hlLibMgt_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlLibMgt.Click
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 12")
        Dim NextPage As New PageLibraryMgt
        NextPage.Show()
    End Sub

    Private Sub hlLibUsers_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlLibUsers.Click
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 13")
        Dim NextPage As New PageGrantContentToUsers
        NextPage.Show()
    End Sub

    Private Sub hlGroups_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlGroups.Click
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 14")
        Dim NextPage As New PageGroup
        NextPage.Show()
    End Sub

    Private Sub dt_ScrollChanged(sender As Object, e As ScrollChangedEventArgs)
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 15")
        If (e.VerticalChange <> 0) Then
            FormLoaded = False

            Dim I As Integer = dgLibrary.SelectedIndex
            txtLibrary.Text = grid.GetCellValueAsString(dgLibrary, I, "LibraryName")

            Dim bPublic As Boolean = False
            Dim C As String = grid.GetCellValueAsString(dgLibrary, I, "isPublic")
            If C.ToUpper.Equals("Y") Then
                bPublic = True
            Else
                bPublic = False
            End If

            ckIsPublic.IsChecked = bPublic

            FormLoaded = True

        End If
    End Sub

    Private Sub ckIsPublic_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckIsPublic.Checked
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 16")
        If Not FormLoaded Then
            Return
        End If
        'gCurrLoginid = gCurrLoginid
        Dim LibName As String = txtLibrary.Text.Replace("'", "''")
        Dim II As Integer = dgLibrary.SelectedIndex
        If II < 0 Then
            MessageBox.Show("An item in the list must be selected, returning.")
            Return
        End If

        Dim S As String = "Update Library set isPublic = 'Y' where Userid = '" + gCurrLoginID + "' and LibraryName = '" + LibName + "' "

        'Dim proxy As New SVCSearch.Service1Client

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn_1_43_344
        'EP.setSearchSvcEndPoint(proxy)

        S = ENC.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, gCurrLoginID, ContractID)
        gLogSQL(BB, ENC.AES256EncryptString(S))

    End Sub

    Sub client_ExecuteSqlNewConn_1_43_344(RC As Boolean, S As String)
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 17")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed
        If RC Then
            PopulateLibraryGrid()
        Else
            LOG.WriteToSqlLog("ERROR client_ExecuteSqlNewConn_1_43_344: 1_43_344" + S)
        End If
        'RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn_1_43_344
    End Sub

    Private Sub ckIsPublic_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckIsPublic.Unchecked
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 18")
        If Not FormLoaded Then
            Return
        End If
        'gCurrLoginid = gCurrLoginid
        Dim LibName As String = txtLibrary.Text.Replace("'", "''")
        Dim II As Integer = dgLibrary.SelectedIndex
        If II < 0 Then
            MessageBox.Show("An item in the list must be selected, returning.")
            Return
        End If

        Dim S As String = "Update Library set isPublic = 'N' where Userid = '" + gCurrLoginID + "' and LibraryName = '" + LibName + "' "

        S = ENC.AES256EncryptString(S)
        ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, gCurrLoginID, ContractID)
    End Sub

    Sub client_ExecuteSqlNewConn_3_5_577(RC As Boolean, S As String)
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 19")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If Not RC Then
            LOG.WriteToSqlLog("ERROR client_ExecuteSqlNewConn_3_5_577: 3_5_577" + S)
        End If
        'RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn_3_5_577
    End Sub

    Sub gLogSQL(RC As Boolean, S As String)
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 20")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If Not RC Then
            LOG.WriteToSqlLog("ERROR PageLibrary 100: " + S)
        End If
        'RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
    End Sub


    Protected Overrides Sub Finalize()
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 21")
        Try
        Finally
            MyBase.Finalize()      'define the destructor
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub

    Private Sub hlRefreshLibs_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlRefreshLibs.Click
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 22")
        PopulateLibraryGrid()
    End Sub

    Private Sub Page_Unloaded(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles MyBase.Unloaded
        'Application.Current.RootVisual.SetValue(Control.IsEnabledProperty, True)
        If gDebug Then XLOG.WriteTraceLog("PageLib  Trace 23")
    End Sub

    Private Sub DgLibrary_SelectionChanged(sender As Object, e As SelectionChangedEventArgs) Handles dgLibrary.SelectionChanged
        For Each col As DataGridColumn In dgLibrary.Columns
            Console.WriteLine(col.Header)
        Next
    End Sub


End Class
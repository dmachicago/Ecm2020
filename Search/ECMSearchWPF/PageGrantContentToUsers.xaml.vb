Imports ECMEncryption

Public Class PageGrantContentToUsers

    Dim ListOfUsers As New System.Collections.ObjectModel.ObservableCollection(Of String)
    Dim ListOfItems() As String = Nothing

    Dim LOG As New clsLogMain
    Dim XLOG As New clsLoggingExtended
    Dim COMMON As New clsCommonFunctions
    Dim ENC2 As New ECMEncrypt()
    Dim UserID As String = """"
    Dim CurrUserGuidID
    Dim InsertCnt As Integer = 0
    Dim CurrCnt As Integer = 0

    Public Sub New()
        InitializeComponent()
        If gDebug.Equals(True) Then XLOG.WriteTraceLog("PageGrantContentToUsers: 00")
        'EP.setSearchSvcEndPoint(proxy)

        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
        'AddHandler ProxySearch.getListOfStringsCompleted, AddressOf client_PopulateLibraryComboBox
        'AddHandler ProxySearch.PopulateLibraryUsersGridCompleted, AddressOf client_PopulateLibraryUsersGrid

        '** Set global variables
        UserID = _UserID
        CurrUserGuidID = gCurrLoginID

        ckMyLibsOnly.IsEnabled = False
        If _isAdmin Then
            ckMyLibsOnly.IsEnabled = True
        End If
        If _isGlobalSearcher Then
            ckMyLibsOnly.IsEnabled = True
        End If
        If _isSuperAdmin Then
            ckMyLibsOnly.IsEnabled = True
        End If

        COMMON.SaveClick(7450, UserID)

        PopulateLibraryComboBox()
        PopulateUserListbox()


    End Sub

    Private Sub hlHome_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlHome.Click
        If gDebug.Equals(True) Then XLOG.WriteTraceLog("PageGrantContentToUsers: 00")
        Me.Close()
        'Dim NextPage As New MainPage()
        'NextPage.show
    End Sub

    Private Sub hlLibraryMgt_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlLibraryMgt.Click
        If gDebug.Equals(True) Then XLOG.WriteTraceLog("PageGrantContentToUsers: 01")
        Dim NextPage As New PageLibraryMgt
        NextPage.Show()
    End Sub

    Private Sub hyperlinkButton1_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hyperlinkButton1.Click
        If gDebug.Equals(True) Then XLOG.WriteTraceLog("PageGrantContentToUsers: 02")
        Dim NextPage As New PageLibrary
        NextPage.Show()
    End Sub

    Sub PopulateLibraryComboBox()
        If gDebug.Equals(True) Then XLOG.WriteTraceLog("PageGrantContentToUsers: 03")
        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        Dim S As String = ""
        If _isAdmin Then
            If ckMyLibsOnly.IsChecked Then
                S = "SELECT [LibraryName] + ' / ' + UserID FROM [dbo].[Library] where UserID = '" + gCurrLoginID + "' order by LibraryName "
            Else
                S = "SELECT [LibraryName]  + ' / ' + UserID FROM [dbo].[Library] order by LibraryName "
            End If
        Else
            S = "SELECT [LibraryName]  + ' / ' + UserID  FROM [dbo].[Library] where UserID = '" + gCurrLoginID + "' order by LibraryName "
        End If

        Clipboard.Clear()
        Clipboard.SetText(S)

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        'AddHandler ProxySearch.getListOfStrings2Completed, AddressOf client_PopulateLibraryComboBox
        'EP.setSearchSvcEndPoint(proxy)
        Dim strListOfItems As String = ""
        'S = ENC2.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.getListOfStrings(_SecureID, strListOfItems, S, RC, RetMsg)
        'Dim strListOfItems As String = ""
        ListOfItems = strListOfItems.Split("|")
        client_PopulateLibraryComboBox(BB, ListOfItems, RetMsg)

    End Sub

    Sub client_PopulateLibraryComboBox(RC As Boolean, ListOfItems As String(), RetMsg As String)
        If gDebug.Equals(True) Then XLOG.WriteTraceLog("PageGrantContentToUsers: 04")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If ListOfItems.Count > 0 Then
            cbLibrary.Items.Clear()
            For Each S As String In ListOfItems
                cbLibrary.Items.Add(S)
            Next
            cbLibrary.Items.Refresh()
        Else
            gErrorCount += 1
            MessageBox.Show("ERROR client_PopulateLibraryComboBox 100: " + RetMsg)
            XLOG.WriteTraceLog("ERROR client_PopulateLibraryComboBox 100: " + RetMsg)
        End If
        'RemoveHandler ProxySearch.getListOfStrings2Completed, AddressOf client_PopulateLibraryComboBox

    End Sub

    Sub PopulateUserListbox()
        If gDebug.Equals(True) Then XLOG.WriteTraceLog("PageGrantContentToUsers: 05")
        'If cbLibrary.SelectedItem Is Nothing Then
        '    Return
        'End If

        Dim RC As Boolean = True
        Dim RetMsg As String = ""
        Dim SSID As Integer = 0
        'Dim ListOfItems As New System.Collections.ObjectModel.ObservableCollection(Of String)
        Dim ListOfItems() As String = Nothing

        'Dim tLib As String = cbLibrary.SelectedItem.ToString
        'tLib = tLib.Replace("'", "''")

        Dim S As String = ""
        S += "SELECT  UserName + ' / ' + UserID As UserID from Users order by UserName " + Environment.NewLine
        'S += "FROM    LibraryUsers INNER JOIN" + Environment.NewLine
        'S += "Users ON LibraryUsers.UserID = Users.UserID" + Environment.NewLine
        'S += "where LibraryUsers.LibraryName = '" + tLib + "'" + Environment.NewLine
        'S += "ORDER BY LibraryUsers.LibraryName" + Environment.NewLine

        'AddHandler ProxySearch.getListOfStrings3Completed, AddressOf client_PopulateUserListbox
        'EP.setSearchSvcEndPoint(proxy)

        Dim strListOfItems As String = ""
        S = ENC2.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.getListOfStrings3(_SecureID, strListOfItems, S, RC, RetMsg, _UserID, ContractID)
        'Dim strListOfItems As String = ""
        ListOfItems = strListOfItems.Split("|")

        client_PopulateUserListbox(BB, ListOfItems, RetMsg)

        ListOfItems = Nothing
        GC.Collect()
    End Sub
    Sub client_PopulateUserListbox(RC As Boolean, ListOfItems As String(), RetMsg As String)
        If gDebug.Equals(True) Then XLOG.WriteTraceLog("PageGrantContentToUsers: 06")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        Dim SSID As Integer = 0

        lbUsers.Items.Clear()
        If ListOfItems.Count > 0 Then
            For Each S As String In ListOfItems
                lbUsers.Items.Add(S)
                If Not ListOfUsers.Contains(S) Then
                    ListOfUsers.Add(S)
                End If
            Next
        Else
            gErrorCount += 1
            Sb.Text = "ERROR client_PopulateUserListbox 100: " + RetMsg

            XLOG.WriteTraceLog("ERROR client_PopulateUserListbox 100: " + RetMsg)
        End If
        'RemoveHandler ProxySearch.getListOfStrings3Completed, AddressOf client_PopulateUserListbox

    End Sub
    Sub RepopulateUsersListBox()
        If gDebug.Equals(True) Then XLOG.WriteTraceLog("PageGrantContentToUsers: 07")
        lbUsers.Items.Clear()
        For Each S As String In ListOfUsers
            If lbLibUsers.Items.Contains(S) Then
            Else
                lbUsers.Items.Add(S)
            End If

        Next
    End Sub
    Sub PopulateLibraryUserListbox()

        Sb.Text = ""
        If gDebug.Equals(True) Then XLOG.WriteTraceLog("PageGrantContentToUsers: 08")
        Dim RC As Boolean = True
        Dim RetMsg As String = ""
        Dim SSID As Integer = 0
        'Dim ListOfItems As New System.Collections.ObjectModel.ObservableCollection(Of String)
        Dim ListOfItems() As String = Nothing

        Dim LibName As String = cbLibrary.SelectedItem.ToString
        Dim A1() As String = LibName.Split("/")
        LibName = A1(0).Trim
        Dim LibraryOwnerUserID As String = A1(1).Trim

        LibName = LibName.Replace("'", "''")
        LibraryOwnerUserID = LibraryOwnerUserID.Replace("'", "''")

        Dim Mysql As String = ""
        Mysql += "SELECT     Users.UserName + ' / ' + LibraryUsers.UserID as UserID" + Environment.NewLine
        Mysql += "FROM         LibraryUsers INNER JOIN" + Environment.NewLine
        Mysql += "Users ON LibraryUsers.UserID = Users.UserID" + Environment.NewLine
        Mysql += "WHERE     (LibraryUsers.LibraryName = '" + LibName + "') AND (LibraryUsers.LibraryOwnerUserID = '" + LibraryOwnerUserID + "')" + Environment.NewLine
        Mysql += "Order by Users.UserName" + Environment.NewLine

        'AddHandler ProxySearch.getListOfStrings1Completed, AddressOf client_PopulateLibraryUserListbox
        'EP.setSearchSvcEndPoint(proxy)

        Dim strListOfItems As String = ""
        'Mysql = ENC2.AES256EncryptString(Mysql)
        Dim BB As Boolean = ProxySearch.getListOfStrings1(_SecureID, strListOfItems, Mysql, RC, RetMsg, _UserID, ContractID)
        If strListOfItems Is Nothing Then
            Sb.Text = "No users defined to this library."
            Return
        End If
        ListOfItems = strListOfItems.Split("|")
        If ListOfItems Is Nothing Then
            Sb.Text = "No defined users for this library' "
            Return
        Else
            client_PopulateLibraryUserListbox(BB, ListOfItems, RetMsg)
        End If

        ListOfItems = Nothing
        GC.Collect()
    End Sub
    Sub client_PopulateLibraryUserListbox(RC As Boolean, ListOfItems As String(), RetMsg As String)
        If gDebug.Equals(True) Then XLOG.WriteTraceLog("PageGrantContentToUsers: 09")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        Dim SSID As Integer = 0

        lbLibUsers.Items.Clear()
        If RC Then
            For Each S As String In ListOfItems
                lbLibUsers.Items.Add(S)
            Next
        Else
            gErrorCount += 1
            Sb.Text = "ERROR client_PopulateLibraryUserListbox 100: " + RetMsg
            XLOG.WriteTraceLog("ERROR client_PopulateLibraryUserListbox 100: " + RetMsg)
        End If
        'RemoveHandler ProxySearch.getListOfStrings1Completed, AddressOf client_PopulateLibraryUserListbox

        RepopulateUsersListBox()

    End Sub

    'Sub PopulateLibraryUserListbox()
    '    Dim SLib As String = cbLibrary.SelectedItem
    '    SLib = SLib.Replace("'", "''")

    '    AddHandler ProxySearch.PopulateLibraryUsersGridCompleted, AddressOf client_PopulateLibraryUsersGrid
    '    ProxySearch.PopulateLibraryUsersGridAsync(_SecureID, SLib, ckLibUsersOnly.IsChecked)
    'End Sub
    'Sub client_PopulateLibraryUsersGrid(ByVal sender As Object, ByVal e As SVCSearch.PopulateLibraryUsersGridCompletedEventArgs)
    '    If RC Then
    '        dgUsers.ItemsSource = e.Result
    '    Else
    '        gErrorCount += 1
    '        XLOG.WriteTraceLog("ERROR client_PopulateLibraryUsersGrid 100: " + e.Error.Message)
    '    End If
    '    'RemoveHandler ProxySearch.PopulateLibraryUsersGridCompleted, AddressOf client_PopulateLibraryUsersGrid
    'End Sub

    Private Sub btnGrant_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnGrant.Click
        '** Assign All selected users to selected library
        If gDebug.Equals(True) Then XLOG.WriteTraceLog("PageGrantContentToUsers: 10")

        Dim LibName As String = cbLibrary.SelectedItem.ToString
        Dim A1() As String = LibName.Split("/")
        LibName = A1(0).Trim
        Dim LibraryOwnerUserID As String = A1(1).Trim
        Dim S As String = ""
        Dim BB As Boolean = False
        If InStr(LibName, "''") > 0 Then
        Else
            LibName = LibName.Replace("'", "''")
        End If

        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn_15_46_224
        'EP.setSearchSvcEndPoint(proxy)
        InsertCnt = lbUsers.SelectedItems.Count
        CurrCnt = 0

        For Each S In lbUsers.SelectedItems
            Dim A() As String = S.Split("/")

            Dim UID As String = A(1).Trim

            CurrCnt += 1

            COMMON.RemoveSingleQuotes(LibName)
            COMMON.RemoveSingleQuotes(UID)
            COMMON.RemoveSingleQuotes(LibraryOwnerUserID)

            S = ""
            S += "if not exists (Select Userid from LibraryUsers where UserID = '@UserID' and LibraryOwnerUserID = '@LibraryOwnerUserID' and LibraryName = '@LibraryName')" + Environment.NewLine
            S += "BEGIN" + Environment.NewLine
            S += " INSERT INTO [LibraryUsers]" + Environment.NewLine
            S += " ([UserID]" + Environment.NewLine
            S += " ,[LibraryOwnerUserID]" + Environment.NewLine
            S += " ,[LibraryName]" + Environment.NewLine
            S += " ,[RowCreationDate]" + Environment.NewLine
            S += " ,[RowLastModDate]" + Environment.NewLine
            S += " ,RepoSvrName" + Environment.NewLine
            S += " ,[RepoName])" + Environment.NewLine
            S += " VALUES " + Environment.NewLine
            S += " ('@UserID'" + Environment.NewLine
            S += " ,'@LibraryOwnerUserID'" + Environment.NewLine
            S += " ,'@LibraryName'" + Environment.NewLine
            S += " ,GETDATE()" + Environment.NewLine
            S += " ,GETDATE()" + Environment.NewLine
            S += " ,@@SERVERNAME" + Environment.NewLine
            S += " ,DB_NAME())" + Environment.NewLine
            S += "END" + Environment.NewLine

            S = S.Replace("@UserID", UID)
            S = S.Replace("@LibraryOwnerUserID", LibraryOwnerUserID)
            S = S.Replace("@LibraryName", LibName)

            PB.IsIndeterminate = True
            PB.Visibility = Windows.Visibility.Visible

            S = ENC2.AES256EncryptString(S)
            BB = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, _UserID, ContractID)
            If Not BB Then
                LOG.WriteToTraceLog("ERROR btnGrant_Click: " + S)
            End If
        Next
        client_ExecuteSqlNewConn_15_46_224(BB, S)
    End Sub
    Sub client_ExecuteSqlNewConn_15_46_224(RC As Boolean, S As String)

        S = ENC2.AES256DecryptString(S)

        If gDebug.Equals(True) Then XLOG.WriteTraceLog("PageGrantContentToUsers: 11")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If RC Then
            Dim B As Boolean = RC
            If B Then
                XLOG.WriteTraceLog("Success: client_ExecuteSqlNewConn_25_27_432")
            Else
                Dim XSql As String = S
                XSql = XSql.Replace("'", "`")
                XLOG.WriteTraceLog("ERROR: client_ExecuteSqlNewConn_25_27_432 - " + XSql)
            End If
        Else
            Dim ErrSql As String = S
            XLOG.WriteTraceLog("ERROR client_ExecuteSqlNewConn_15_46_224: 15_46_224" + S)
        End If
        If CurrCnt >= InsertCnt Then
            ''RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn_15_46_224
            PopulateLibraryUserListbox()
            CurrCnt = 0
        End If
    End Sub

    Private Sub btnRemove_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnRemove.Click
        '** Remove All selected users from selected library
        If gDebug.Equals(True) Then XLOG.WriteTraceLog("PageGrantContentToUsers: 12")
        InsertCnt = lbLibUsers.SelectedItems.Count
        CurrCnt = 0
        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn_7_12_501
        'EP.setSearchSvcEndPoint(proxy)
        Dim BB As Boolean = False
        For Each S As String In lbLibUsers.SelectedItems

            Dim A() As String = S.Split("/")
            Dim UID As String = A(1).Trim

            Dim LibName As String = cbLibrary.SelectedItem.ToString
            Dim A1() As String = LibName.Split("/")
            LibName = A1(0).Trim
            Dim LibraryOwnerUserID As String = A1(1).Trim

            COMMON.RemoveSingleQuotes(LibName)
            COMMON.RemoveSingleQuotes(UID)

            Dim MySql As String = "Delete from LibraryUsers where LibraryName = '" + LibName + "' and UserID = '" + UID + "' "
            PB.IsIndeterminate = True
            PB.Visibility = Windows.Visibility.Visible
            MySql = ENC2.AES256EncryptString(MySql)
            BB = ProxySearch.ExecuteSqlNewConn1(_SecureID, MySql, gCurrLoginID, ContractID)
            If BB Then
                CurrCnt += 1
            Else
                MySql = ENC2.AES256DecryptString(MySql)
                LOG.WriteToTraceLog("ERROR Remove 221: " + MySql)
                Sb.Text = "REVIEW ERROR LOG..."
            End If
        Next

        If CurrCnt > 0 Then
            BB = True
            client_ExecuteSqlNewConn_7_12_501(BB)
        End If

    End Sub
    Sub client_ExecuteSqlNewConn_7_12_501(RC As Boolean)
        If gDebug.Equals(True) Then XLOG.WriteTraceLog("PageGrantContentToUsers: 13")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If RC Then
            Dim B As Boolean = RC
            If Not B Then
                XLOG.WriteTraceLog("ERROR SQL: client_ExecuteSqlNewConn_7_12_501: ")
            End If
        Else
            XLOG.WriteTraceLog("ERROR client_ExecuteSqlNewConn_7_12_501: 7_12_501")
        End If
        If CurrCnt >= InsertCnt Then
            ''RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn_7_12_501
            RepopulateUsersListBox()
            PopulateLibraryUserListbox()
            CurrCnt = 0
        End If

    End Sub

    Protected Overrides Sub Finalize()
        Try
            If gDebug.Equals(True) Then XLOG.WriteTraceLog("PageGrantContentToUsers: 14")
        Finally
            MyBase.Finalize()      'define the destructor
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub

    Private Sub hlRefresh_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlRefresh.Click
        PopulateLibraryComboBox()
    End Sub

    Private Sub ckMyLibsOnly_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckMyLibsOnly.Checked
        If gDebug.Equals(True) Then XLOG.WriteTraceLog("PageGrantContentToUsers: 15")
        PopulateLibraryComboBox()
    End Sub

    Private Sub ckMyLibsOnly_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckMyLibsOnly.Unchecked
        If gDebug.Equals(True) Then XLOG.WriteTraceLog("PageGrantContentToUsers: 16")
        PopulateLibraryComboBox()
    End Sub

    Private Sub Page_Unloaded(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles MyBase.Unloaded
        If gDebug.Equals(True) Then XLOG.WriteTraceLog("PageGrantContentToUsers: 17")
        ''Application.Current.RootVisual.SetValue(Control.IsEnabledProperty, True)
    End Sub

    Private Sub cbLibrary_SelectionChanged(sender As Object, e As SelectionChangedEventArgs) Handles cbLibrary.SelectionChanged
        If gDebug.Equals(True) Then XLOG.WriteTraceLog("PageGrantContentToUsers: 18")
        PopulateLibraryUserListbox()
    End Sub
End Class

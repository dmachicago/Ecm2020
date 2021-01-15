Imports System.Web.Script.Serialization
Imports ECMEncryption
Public Class PageUsers
    'Inherits Page

    Dim GridGols As Dictionary(Of String, Integer) = New Dictionary(Of String, Integer)
    Dim RowVals As Dictionary(Of String, String) = New Dictionary(Of String, String)

    Dim LOG As New clsLogMain
    Dim ENC2 As New ECMEncrypt()
    Dim gSecureID As String
    Dim UserID As String = ""
    Dim COMMON As New clsCommonFunctions

    Dim CurrSelectedUserGuid As String = ""
    Dim SelectedUserID As String = ""
    Dim SelectedUserName As String = ""
    Dim SelectedEmailAddress As String = ""
    Dim SelectedUserPassword As String = ""
    Dim SelectedAdmin As String = ""
    Dim SelectedIsActive As String = ""
    Dim Formloaded As Boolean = False
    Dim SelectedCOUserID As String = ""
    Dim SelectedCOUserName As String = ""
    Dim CoOwnerRowID As String = ""
    Dim CurrentlySelectedUserGridRow As Integer = 0
    Dim bHelpLoaded As Boolean = False
    Dim bGridLoaded As Boolean = False

    Public Sub New()
        InitializeComponent()
        Console.WriteLine("PU Trace 00")
        'EP.setSearchSvcEndPoint(proxy)

        If _isAdmin Then
            btnAdd.Visibility = Visibility.Visible
        Else
            btnAdd.Visibility = Visibility.Collapsed
            btnDelete.Visibility = Visibility.Collapsed
            Label7.Visibility = Visibility.Collapsed
            Label8.Visibility = Visibility.Collapsed
            Label9.Visibility = Visibility.Collapsed
            cbCurrentOwner.Visibility = Visibility.Collapsed
            cbRefactoredOwner.Visibility = Visibility.Collapsed
            btnRefactor.Visibility = Visibility.Collapsed
            ckActive.Visibility = Visibility.Collapsed
            ckClientOnly.Visibility = Visibility.Collapsed
            cbUserType.IsEnabled = False
        End If

        Formloaded = False
        '** Set global variables
        UserID = _UserID
        gCurrUserGuidID = _UserGuid

        COMMON.SaveClick(6500, UserID)

        'AddHandler ProxySearch.ExecuteSqlNewConn1Completed, AddressOf client_ExecuteSqlNewConn1
        'AddHandler ProxySearch.ExecuteSqlNewConn2Completed, AddressOf client_ExecuteSqlNewConn2
        'AddHandler ProxySearch.ExecuteSqlNewConn3Completed, AddressOf client_ExecuteSqlNewConn3
        'AddHandler ProxySearch.ExecuteSqlNewConn4Completed, AddressOf client_ExecuteSqlNewConn4
        'AddHandler ProxySearch.ExecuteSqlNewConn5Completed, AddressOf client_ExecuteSqlNewConn5
        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL

        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_changeOwnership

        PopulateUserGrid()
        PopUserCombo()

        Formloaded = True

    End Sub

    Sub GetSelectedRowData()
        Console.WriteLine("PU Trace 01")
        Try

            'Dim iRows As Integer = dgUsers.SelectedItems.count
            'If iRows <> 1 Then
            '    Return
            'End If

            'Dim DR As C1.Silverlight.FlexGrid.Row
            Dim iRow As Integer = dgUsers.SelectedIndex

            'DR = dgUsers.SelectedItems(iRow)

            CurrentlySelectedUserGridRow = iRow
            CurrSelectedUserGuid = grid.GetCellValueAsString(dgUsers, iRow, "UserLoginID")
            SelectedUserID = grid.GetCellValueAsString(dgUsers, iRow, "UserLoginID")
            SelectedUserName = grid.GetCellValueAsString(dgUsers, iRow, "UserName")
            SelectedEmailAddress = grid.GetCellValueAsString(dgUsers, iRow, "EmailAddress")
            'SelectedUserPassword = grid.GetCellValueAsString(dgUsers,  iRow,"UserPassword")
            SelectedUserPassword = ""

            Dim CurrentlySelectedUserGuid$ = ""
            If _isAdmin = False Then
                If CurrSelectedUserGuid <> gCurrUserGuidID Then
                    btnAdd.IsEnabled = False
                    btnUpdate.IsEnabled = False
                    btnDelete.IsEnabled = False
                    cbUserType.IsEnabled = False
                    ckActive.IsEnabled = False
                    txtPassword.IsEnabled = False
                    btnMakePublic.IsEnabled = False
                Else
                    btnAdd.IsEnabled = False
                    btnUpdate.IsEnabled = True
                    btnDelete.IsEnabled = False
                    cbUserType.IsEnabled = False
                    ckActive.IsEnabled = False
                    txtPassword.IsEnabled = True
                    btnMakePublic.IsEnabled = True
                End If
            Else
                btnAdd.IsEnabled = True
                btnUpdate.IsEnabled = True
                btnDelete.IsEnabled = True
                cbUserType.IsEnabled = True
                ckActive.IsEnabled = True
                txtPassword.IsEnabled = True
                btnMakePublic.IsEnabled = True
            End If

            'Try
            '    Dim SS$ = ENC2.AES256EncryptString(SelectedUserPassword)
            '    'messagebox.show(SS)
            '    SB.Text = "Decrypted password: " + SS
            '    SelectedUserPassword = SS
            'Catch ex As Exception
            '    SelectedUserPassword = ""
            'End Try

            Dim SelectedAdmin As String = grid.GetCellValueAsString(dgUsers, "Admin")
            Dim SelectedIsActive As String = grid.GetCellValueAsString(dgUsers, "isActive")

            Me.txtEmail.Text = SelectedEmailAddress
            Me.txtPassword.Password = SelectedUserPassword
            Me.txtUserID.Text = SelectedUserID
            Me.txtUserName.Text = SelectedUserName

            If SelectedAdmin.Equals("A") Then
                Me.cbUserType.SelectedValue = "Administrator"
            ElseIf SelectedAdmin.Equals("S") Then
                Me.cbUserType.SelectedValue = "Super Administrator"
            ElseIf SelectedAdmin.Equals("G") Then
                Me.cbUserType.SelectedValue = "Global Searcher"
            Else
                Me.cbUserType.SelectedValue = "User - Standard"
            End If

            If SelectedIsActive$.Equals("Y") Then
                Me.ckActive.IsChecked = True
            Else
                Me.ckActive.IsChecked = False
            End If

            Dim sClientOnly = grid.GetCellValueAsString(dgUsers, "ClientOnly")
            If sClientOnly.Equals("Y") Then
                Me.ckClientOnly.IsChecked = True
            Else
                Me.ckClientOnly.IsChecked = False
            End If

            PopulateCoOwnerGrid(CurrSelectedUserGuid)

        Catch ex As Exception
            SB.Text = ex.Message
        End Try
    End Sub
    Private Sub setColOrder()
        Console.WriteLine("PU Trace 02")
        ReorderDgContentCols("UserLoginID", 0)
        ReorderDgContentCols("UserName", 1)
        ReorderDgContentCols("isActive", 2)
    End Sub
    Private Sub ReorderDgContentCols(ByVal ColName As String, ByVal ColDisplayOrder As Integer)
        Console.WriteLine("PU Trace 03")
        Try
            'Dim I As Integer = grid.getColumnIndexByName(dgUsers, ColName)
            'Dim col As DataGridColumn = dgUsers.Columns(I)                        
            'dgUsers.Columns.Remove(col)
            'dgUsers.Columns.Insert(ColDisplayOrder, col)
            dgUsers.Columns(0).DisplayIndex = ColDisplayOrder
        Catch ex As Exception
            SB.Text = ex.Message
        End Try

    End Sub
    Private Sub hlHome_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlHome.Click
        Console.WriteLine("PU Trace 04")
        Dim NextPage As New MainPage()

    End Sub

    Private Sub dt_ScrollChanged(sender As Object, e As ScrollChangedEventArgs)
        Console.WriteLine("PU Trace 05")
        If (e.VerticalChange <> 0) Then
            Formloaded = False
            GetSelectedRowData()
            Formloaded = True
        End If
    End Sub

    Private Sub btnRemoveCoowner_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnRemoveCoowner.Click
        Console.WriteLine("PU Trace 05")
        Formloaded = False
        If Me.dgCoOwner.SelectedItems.Count = 0 Then
            MessageBox.Show("You must select a co-owner to delete...")
            Return
        End If

        Dim msg$ = "This will remove the selected Co-Owner , are you sure? "
        Dim result As MessageBoxResult = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel)
        If result = MessageBoxResult.Cancel Then
            Return
        End If

        GetSelectedCoOwnerRowData()
        Dim S As String = "delete from CoOwner where Rowid = " + CoOwnerRowID
        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_RemoveCoowner
        'EP.setSearchSvcEndPoint(proxy)
        S = ENC2.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(S))

    End Sub
    Sub client_RemoveCoowner(RC As Boolean, S As String)
        Console.WriteLine("PU Trace 06")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If RC Then
            PopulateCoOwnerGrid(CurrSelectedUserGuid)
        Else
            MessageBox.Show("Delete failed.")
            LOG.WriteToSqlLog("ERROR 100 client_RemoveCoOwner: " + S)
        End If
        'RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_RemoveCoowner
    End Sub

    Private Sub btnRefactor_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnRefactor.Click
        Console.WriteLine("PU Trace 07")
        If Not _isAdmin Then
            MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.")
            Return
        End If

        Dim PreviousOwner As String = SelectedUserID
        Dim NewOwner As String = cbRefactoredOwner.SelectedItem
        Dim TransferDate As Date = Now

        Dim msg$ = "This will CHANGE content ownership and CANNOT be reversed. " + Environment.NewLine + "It is a VERY long running process and will use ALL available server resources." + Environment.NewLine + "Are you sure? "
        Dim result As MessageBoxResult = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel)
        If result = MessageBoxResult.Cancel Then
            Return
        End If
        '*************************
        Refactor()
        SB.Text = "Refactoring in progress - please check the log and correct any errors."
        '*************************

    End Sub

    Sub client_InsertCoOwner(RC As Boolean)
        Console.WriteLine("PU Trace 08")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If RC Then
            PopulateCoOwnerGrid(CurrSelectedUserGuid)
        Else
            MessageBox.Show("ERROR 100 client_InsertCoOwner: FAILED")
            LOG.WriteToSqlLog("ERROR 100 client_InsertCoOwner: ")
        End If
        'RemoveHandler ProxySearch.InsertCoOwnerCompleted, AddressOf client_InsertCoOwner
    End Sub
    Private Sub btnMakePublic_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnMakePublic.Click
        Console.WriteLine("PU Trace 09")
        If Not _isAdmin Then
            MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.")
            Return
        End If

        Dim iRow As Integer = Me.dgUsers.SelectedItems.Count
        If iRow <> 1 Then
            MessageBox.Show("Please select ONE USER row...")
            Return
        End If

        Dim msg$ = "This will set ALL of this user's content to PUBLIC, are you sure?"
        Dim result As MessageBoxResult = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel)
        If result = MessageBoxResult.Cancel Then
            Return
        End If

        Dim iSelected = dgUsers.SelectedIndex
        dgUsers.Items(iRow).Selected = True
        CurrSelectedUserGuid = grid.GetCellValueAsString(dgUsers, iSelected, "UserLoginID")
        SelectedUserID = grid.GetCellValueAsString(dgUsers, iSelected, "UserLoginID")
        SelectedUserName = grid.GetCellValueAsString(dgUsers, iSelected, "UserName")
        SelectedEmailAddress = grid.GetCellValueAsString(dgUsers, iSelected, "EmailAddress")
        'SelectedUserPassword = grid.GetCellValueAsString(dgUsers iSelected, "UserPassword")

        msg = "This will set all of the selected USER's CONTENT and EMAILS to 'PUBLIC', Are you really sure? "
        result = MessageBox.Show(msg, "CANNOT BE REVERSED", MessageBoxButton.OKCancel)
        If result = MessageBoxResult.Cancel Then
            Return
        End If

        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        'AddHandler ProxySearch.ChangeUserContentPublicCompleted, AddressOf client_ChangeUserContentPublic
        'EP.setSearchSvcEndPoint(proxy)
        ProxySearch.ChangeUserContentPublic(_SecureID, CurrSelectedUserGuid, "Y", RC, RetMsg)
        client_ChangeUserContentPublic(RC, RetMsg)

        SB.Text = "All Content converted to public."
    End Sub

    Private Sub btnAdd_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnAdd.Click
        Console.WriteLine("PU Trace 10")
        If txtPassword.Password.Length = 0 Then
            Dim msg$ = "The PASSWORD field was left blank, the password will be set to 'ecmuser' - is that OK?"
            Dim result As MessageBoxResult = MessageBox.Show(msg, "Default Password Setting", MessageBoxButton.OKCancel)
            If result = MessageBoxResult.Cancel Then
                Return
            End If
            txtPassword.Password = "ecmuser"
            txtPassword2.Password = "ecmuser"
        End If

        Formloaded = False
        Dim AdminOn$ = ""
        Dim UserTypeChar$ = ""

        If cbUserType.Text.Trim.Length = 0 Then
            SB.Text = "Please select a user type."
            Formloaded = True
            Return
        Else
            UserTypeChar$ = Mid(cbUserType.Text.Trim, 1, 1).ToUpper
        End If
        AdminOn$ = UserTypeChar$

        Dim PW1 As String = txtPassword.Password
        Dim PW2 As String = txtPassword2.Password

        If PW1.Equals(PW2) Then
        Else
            MessageBox.Show("The passwords DO NOT match, please verify - returning.")
            Return
        End If

        '*****************************************************************************
        Dim UserGuid$ = System.Guid.NewGuid.ToString()
        UserGuid$ = Me.txtUserID.Text.ToUpper.Trim
        '*****************************************************************************
        Dim RC As Boolean = False
        Dim UserID As String = Me.txtUserID.Text.Trim
        Dim UserName As String = txtUserName.Text
        Dim EmailAddress As String = Me.txtEmail.Text.Trim

        Dim UserPassword As String = ""
        If PW1.Length > 0 Then
            UserPassword = ENC2.AES256EncryptString(PW1)
        End If

        Dim Admin As String = AdminOn$
        Dim isActive As String = ""
        If ckActive.IsChecked Then
            isActive = "Y"
        Else
            isActive = "N"
        End If
        Dim UserLoginID As String = Me.txtUserID.Text.Trim
        Dim ClientOnly As Boolean = False
        If ckClientOnly.IsChecked Then
            ClientOnly = True
        End If
        Dim HiveConnectionName As String = "NA"
        Dim HiveActive As Boolean = False
        Dim RepoSvrName As String = ""
        Dim RowCreationDate As Date = Now
        Dim RowLastModDate As Date = Now
        Dim ActiveGuid As String = Guid.NewGuid.ToString
        Dim RepoName As String = "NA"

        Dim RetMsg As String = ""

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        Cursor = Cursors.Wait
        'AddHandler ProxySearch.SaveUSerCompleted, AddressOf client_SaveUser
        'EP.setSearchSvcEndPoint(proxy)
        Dim BB As Boolean = ProxySearch.SaveUSer(_SecureID, UserID, UserName, EmailAddress,
                       UserPassword, Admin, isActive,
                       UserLoginID, ClientOnly, HiveConnectionName,
                       HiveActive, RepoSvrName, RowCreationDate, RowLastModDate,
                       ActiveGuid, RepoName, RC, RetMsg)

        client_SaveUser(BB, RetMsg)

        PB.IsIndeterminate = False
        PB.Visibility = Visibility.Hidden

        Formloaded = True
    End Sub

    Sub client_SaveUser(rc As Boolean, retmsg As String)
        Console.WriteLine("PU Trace 11")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        Cursor = Cursors.Arrow
        If rc Then
            SB.Text = "User added"
            RefreshUserGrid()
            PopUserCombo()
        Else
            LOG.WriteToSqlLog("ERROR 100 client_PopulateUserGrid: " + retmsg)
        End If
        'RemoveHandler ProxySearch.SaveUSerCompleted, AddressOf client_SaveUser
    End Sub
    Private Sub btnUpdate_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnUpdate.Click
        Console.WriteLine("PU Trace 11")
        Formloaded = False
        Dim AdminOn As String = ""
        Dim UserTypeChar As String = ""

        If cbUserType.Text.Trim.Length = 0 Then
            SB.Text = "Please select a user type."
            Formloaded = True
            Return
        Else
            UserTypeChar = Mid(cbUserType.Text.Trim, 1, 1).ToUpper
        End If
        AdminOn = UserTypeChar

        Dim PW1 As String = txtPassword.Password
        Dim PW2 As String = txtPassword2.Password

        If PW1.Equals(PW2) Then
        Else
            MessageBox.Show("The passwords DO NOT match, please verify - returning.")
            Return
        End If

        If PW1.Length = 0 Then
            PW1 = ""
            PW2 = ""
        End If

        '*****************************************************************************
        Dim UserGuid$ = System.Guid.NewGuid.ToString()
        UserGuid$ = Me.txtUserID.Text.ToUpper.Trim
        '*****************************************************************************
        Dim RC As Boolean = False
        Dim UserID As String = Me.txtUserID.Text.Trim
        Dim UserName As String = txtUserName.Text
        Dim EmailAddress As String = Me.txtEmail.Text.Trim

        Dim UserPassword As String = ""
        If PW1.Length = 0 Then
            UserPassword = ""
        Else
            UserPassword = ENC2.AES256EncryptString(PW1)
        End If

        Dim Admin As String = AdminOn
        Dim isActive As String = ""
        If ckActive.IsChecked Then
            isActive = "Y"
        Else
            isActive = "N"
        End If
        Dim UserLoginID As String = Me.txtUserID.Text.Trim
        Dim ClientOnly As Boolean = False
        If ckClientOnly.IsChecked Then
            ClientOnly = True
        End If
        Dim HiveConnectionName As String = "NA"
        Dim HiveActive As Boolean = False
        Dim RepoSvrName As String = ""
        Dim RowCreationDate As Date = Now
        Dim RowLastModDate As Date = Now
        Dim ActiveGuid As String = Guid.NewGuid.ToString
        Dim RepoName As String = "NA"

        Dim RetMsg As String = ""

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        Cursor = Cursors.Wait
        'AddHandler ProxySearch.SaveUSerCompleted, AddressOf client_SaveUser
        'EP.setSearchSvcEndPoint(proxy)
        ProxySearch.SaveUSer(_SecureID, UserID, UserName, EmailAddress,
                       UserPassword, Admin, isActive,
                       UserLoginID, ClientOnly, HiveConnectionName,
                       HiveActive, RepoSvrName, RowCreationDate, RowLastModDate,
                       ActiveGuid, RepoName, RC, RetMsg)

        client_SaveUser(RC, RetMsg)

        Formloaded = True


    End Sub

    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnDelete.Click
        Console.WriteLine("PU Trace 12")

        Formloaded = False
        Formloaded = False
        Dim iRow As Integer = Me.dgUsers.SelectedItems.Count
        If iRow < 0 Then
            Formloaded = True
            MessageBox.Show("Please select a USER row...")
            Return
        End If

        SelectedUserID = grid.GetCellValueAsString(dgUsers, "UserLoginID")

        Dim msg$ = "This will remove the selected USER , are you sure? If there is associated emails or content, the user cannot be removed. "
        Dim result As MessageBoxResult = MessageBox.Show(msg, "CANNOT BE UNDONE", MessageBoxButton.OKCancel)
        If result = MessageBoxResult.Cancel Then
            Return
        End If

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        Cursor = Cursors.Wait
        Dim RetMsg As String = ""
        'AddHandler ProxySearch.DeleteUserCompleted, AddressOf client_DeleteUser
        'EP.setSearchSvcEndPoint(proxy)
        Dim BB As Boolean = ProxySearch.DeleteUser(_SecureID, SelectedUserID, RetMsg)
        client_DeleteUser(BB, RetMsg)

        RefreshUserGrid()
        PopUserCombo()

        Formloaded = True
    End Sub
    Sub client_DeleteUser(RC As Boolean, RetMsg As String)
        Console.WriteLine("PU Trace 13")

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        Cursor = Cursors.Arrow
        If RC Then
            If RetMsg.Length > 0 Then
                MessageBox.Show(RetMsg)
            End If
            Dim B As Boolean = RC
            If B Then
                SB.Text = "User successfully deleted"
                PopulateUserGrid()
            Else
                MessageBox.Show("User not removed: " + RetMsg)
                SB.Text = RetMsg
            End If
        Else
            LOG.WriteToSqlLog("ERROR 100 client_DeleteUser: " + RetMsg)
        End If
        'RemoveHandler ProxySearch.DeleteUserCompleted, AddressOf client_DeleteUser
    End Sub

    Sub RefreshUserGrid()
        Console.WriteLine("PU Trace 14")

        PopulateUserGrid()
    End Sub

    Sub PopulateUserGrid()
        Console.WriteLine("PU Trace 15")
        bGridLoaded = False
        'AddHandler ProxySearch.PopulateUserGridCompleted, AddressOf client_PopulateUserGrid
        'EP.setSearchSvcEndPoint(proxy)
        Dim row As SVCSearch.DS_VUserGrid
        Dim ListOfRows As New System.Collections.ObjectModel.ObservableCollection(Of SVCSearch.DS_VUserGrid)
        Dim ObjListOfRows As Object = ProxySearch.PopulateUserGrid(_SecureID, _UserGuid, _isAdmin)
        For Each row In ObjListOfRows
            row.ExtensionData = Nothing
            ListOfRows.Add(row)
        Next
        Try
            dgUsers.ItemsSource = ListOfRows
            dgUsers.Items.Refresh()
            Dim idx As Integer = 0
            For Each col As DataGridColumn In dgUsers.Columns
                idx += 1
                Dim tgt As String = col.Header.ToString
                If tgt.Equals("ExtensionData") Then
                    dgUsers.Columns(idx).Visibility = Visibility.Hidden
                End If
            Next
            setColOrder()
        Catch ex As Exception
            LOG.WriteToSqlLog("ERROR 100 client_PopulateUserGrid: " + ex.Message)
            Console.WriteLine("ERROR 100 client_PopulateUserGrid: " + ex.Message)
        End Try
        'client_PopulateUserGrid(ObjListOfRows)
    End Sub
    Sub client_PopulateUserGrid(ObjListOfRows As Object)
        Console.WriteLine("PU Trace 16")

        Dim ListOfRows As New System.Collections.ObjectModel.ObservableCollection(Of SVCSearch.DS_VUserGrid)
        ListOfRows = ObjListOfRows

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If ListOfRows.Count > 0 Then
            dgUsers.ItemsSource = ListOfRows
            dgUsers.Items.Refresh()
            setColOrder()
        Else
            LOG.WriteToSqlLog("ERROR 100 client_PopulateUserGrid: ")
        End If
        'RemoveHandler ProxySearch.PopulateUserGridCompleted, AddressOf client_PopulateUserGrid
        bGridLoaded = True
    End Sub
    Sub PopulateCoOwnerGrid(ByVal UID As String)
        Console.WriteLine("PU Trace 17")

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        dgCoOwner.ItemsSource = Nothing
        'AddHandler ProxySearch.PopulateCoOwnerGridCompleted, AddressOf client_PopulateCoOwnerGrid
        'EP.setSearchSvcEndPoint(proxy)
        Dim ObjListOfRows As String = ProxySearch.PopulateCoOwnerGrid(_SecureID, UID)
        client_PopulateCoOwnerGrid(ObjListOfRows)

    End Sub
    Sub client_PopulateCoOwnerGrid(ObjListOfRows As String)
        Console.WriteLine("PU Trace 18")

        Dim ListOfRows As New System.Collections.ObjectModel.ObservableCollection(Of DS_CoOwner)
        Dim jss = New JavaScriptSerializer()
        Dim ObjContent = jss.Deserialize(Of DS_CoOwner())(ObjListOfRows)
        Dim Z As Integer = ObjContent.Count
        For Each Obj As DS_CoOwner In ObjContent
            ListOfRows.Add(Obj)
        Next

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If ListOfRows.Count > 0 Then
            dgCoOwner.ItemsSource = ListOfRows
        Else
            LOG.WriteToSqlLog("ERROR 100 client_PopulateCoOwnerGrid: ")
        End If
        'RemoveHandler ProxySearch.PopulateCoOwnerGridCompleted, AddressOf client_PopulateCoOwnerGrid
    End Sub

    Sub client_changeOwnership(RC As Boolean, S As String)
        Console.WriteLine("PU Trace 19")

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If Not RC Then
            LOG.WriteToSqlLog("ERROR 100.2 client_changeOwnership: ID =" + gRowID.ToString + " / " + S)
        End If

    End Sub
    Sub GetSelectedCoOwnerRowData()
        Console.WriteLine("PU Trace 20")

        Try
            Dim iRow As Integer = Me.dgCoOwner.SelectedIndex
            SelectedCOUserID$ = grid.GetCellValueAsString(dgCoOwner, iRow, "COOwnerID")
            SelectedCOUserName$ = grid.GetCellValueAsString(dgCoOwner, iRow, "CoOwnerName")
            CoOwnerRowID = grid.GetCellValueAsString(dgCoOwner, iRow, "RowID")
        Catch ex As Exception
            SB.Text = ex.Message
        End Try
    End Sub

    Sub Refactor()
        Console.WriteLine("PU Trace 21")
        Dim iRow As Integer = Me.dgUsers.SelectedItems.Count
        If iRow < 0 Then
            MessageBox.Show("Please select ONE USER row...")
            Return
        End If

        Dim B As Boolean = False

        CurrentlySelectedUserGridRow = iRow
        Dim IDX As Integer = dgUsers.SelectedIndex

        'SelectedUserID$ = dgUsers(IDX, "UserLoginID").ToString
        'SelectedUserName$ = dgUsers(IDX, "UserName").ToString
        'SelectedEmailAddress$ = dgUsers(IDX, "EmailAddress").ToString
        'SelectedUserPassword$ = dgUsers(IDX, "UserPassword").ToString

        Dim msg$ = "This will set all of the selected USER's CONTENT and EMAILS to the new owner, are you sure? "
        Dim result As MessageBoxResult = MessageBox.Show(msg, "Reassignment of Ownership - Are You Sure", MessageBoxButton.OKCancel)
        If result = MessageBoxResult.Cancel Then
            Return
        End If

        Dim RefactorUserID As String = cbCurrentOwner.Text

        Dim NewOwnerID$ = cbRefactoredOwner.SelectedItem
        Dim OldOwnerID$ = cbCurrentOwner.SelectedItem

        If NewOwnerID$.Trim.Length = 0 Then
            MessageBox.Show("A new owner must be selected...")
            Return
        End If

        If OldOwnerID$.Trim.Length = 0 Then
            MessageBox.Show("A current owner must be selected...")
            Return
        End If

        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        'AddHandler ProxySearch.RefactorCompleted, AddressOf client_Refactor
        'EP.setSearchSvcEndPoint(proxy)
        ProxySearch.Refactor(_SecureID, NewOwnerID, OldOwnerID, RC, RetMsg)
        client_Refactor(RC, RetMsg)

    End Sub
    Sub client_Refactor(RC As Boolean, RetMsg As String)
        Console.WriteLine("PU Trace 22")

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If RC Then
            MessageBox.Show("Refactored owner completed.")
        Else
            MessageBox.Show("ERROR client_Refactor: " + RetMsg)
            LOG.WriteToSqlLog("ERROR client_Refactor: " + RetMsg)
            LOG.WriteToSqlLog("ERROR client_Refactor: " + RetMsg)
        End If
        'RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn_27_20_524
    End Sub

    Private Sub hlRefreshCoOwner_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlRefreshCoOwner.Click
        Console.WriteLine("PU Trace 23")
        PopulateCoOwnerGrid(CurrSelectedUserGuid)
    End Sub

    Private Sub hlRefreshUsers_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlRefreshUsers.Click
        Console.WriteLine("PU Trace 24")
        RefreshUserGrid()
    End Sub

    Sub PopUserCombo()
        Console.WriteLine("PU Trace 25")

        'Dim ListOfUsers As New System.Collections.ObjectModel.ObservableCollection(Of String)
        Dim ListOfUsers() As String = Nothing
        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        Dim S As String = ""
        S = S + " SELECT [UserLoginID]"
        S = S + " FROM  [Users]"
        S = S + " order by [UserLoginID]"

        Dim strListOfItems As String = ""

        'S = ENC2.AES256EncryptString(S)
        RC = ProxySearch.getListOfStrings(_SecureID, strListOfItems, S, RC, RetMsg)
        'Dim strListOfItems As String = ""
        ListOfUsers = strListOfItems.Split("|")
        client_cbNewOwner(RC, ListOfUsers, RetMsg)

        ListOfUsers = Nothing
        GC.Collect()

    End Sub
    Sub client_cbNewOwner(RC As Boolean, ListOfUsers As String(), RetMsg As String)
        Console.WriteLine("PU Trace 26")

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        cbNewOwner.Items.Clear()
        cbCurrentOwner.Items.Clear()
        cbRefactoredOwner.Items.Clear()
        If RC Then
            For Each s As String In ListOfUsers
                cbNewOwner.Items.Add(s)
                cbCurrentOwner.Items.Add(s)
                cbRefactoredOwner.Items.Add(s)
            Next
        Else
            LOG.WriteToSqlLog("ERROR 100 client_cbNewOwner: " + RetMsg)
        End If

        GC.Collect()

    End Sub


    Protected Overrides Sub Finalize()
        Console.WriteLine("PU Trace 27")

        Try

        Finally
            MyBase.Finalize()      'define the destructor
            ''RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
            ''RemoveHandler ProxySearch.ExecuteSqlNewConn1Completed, AddressOf client_ExecuteSqlNewConn1
            ''RemoveHandler ProxySearch.ExecuteSqlNewConn2Completed, AddressOf client_ExecuteSqlNewConn2
            ''RemoveHandler ProxySearch.ExecuteSqlNewConn3Completed, AddressOf client_ExecuteSqlNewConn3
            ''RemoveHandler ProxySearch.ExecuteSqlNewConn4Completed, AddressOf client_ExecuteSqlNewConn4
            ''RemoveHandler ProxySearch.ExecuteSqlNewConn5Completed, AddressOf client_ExecuteSqlNewConn5

            ''RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_changeOwnership

            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub

    Private Sub btnAddCowner1_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnAddCowner1.Click
        Console.WriteLine("PU Trace 28")

        Dim PreviousOwner As String = CurrSelectedUserGuid
        Dim NewOwner As String = cbNewOwner.Text.Trim
        Dim TransferDate As Date = Now

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        'AddHandler ProxySearch.InsertCoOwnerCompleted, AddressOf client_InsertCoOwner
        'EP.setSearchSvcEndPoint(proxy)
        Dim BB As Boolean = ProxySearch.InsertCoOwner(_SecureID, PreviousOwner, NewOwner)
        client_InsertCoOwner(BB)
    End Sub

    Private Sub btnPrivate_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnPrivate.Click
        Console.WriteLine("PU Trace 29")
        If Not _isAdmin Then
            MessageBox.Show("Admin authority required to open this set of screens, please get an admin to assist you.")
            Return
        End If

        Dim iRow As Integer = Me.dgUsers.SelectedItems.Count
        If iRow <> 1 Then
            MessageBox.Show("Please select ONE USER row...")
            Return
        End If

        Dim msg As String = "This will set ALL of this user's content to PRIVATE, are you sure?"
        Dim result As MessageBoxResult = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel)
        If result = MessageBoxResult.Cancel Then
            Return
        End If

        Dim iSelected = dgUsers.SelectedIndex
        dgUsers.Items(iRow).Selected = True
        CurrSelectedUserGuid = grid.GetCellValueAsString(dgUsers, "UserLoginID")
        SelectedUserID = grid.GetCellValueAsString(dgUsers, "UserLoginID")
        SelectedUserName = grid.GetCellValueAsString(dgUsers, "UserName")
        SelectedEmailAddress = grid.GetCellValueAsString(dgUsers, "EmailAddress")
        'SelectedUserPassword = grid.GetCellValueAsString(dgUsers "UserPassword")

        msg = "This will set all of the selected USER's CONTENT and EMAILS to 'PUBLIC', Are you really sure? "
        result = MessageBox.Show(msg, "CANNOT BE REVERSED", MessageBoxButton.OKCancel)
        If result = MessageBoxResult.Cancel Then
            Return
        End If

        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        'AddHandler ProxySearch.ChangeUserContentPublicCompleted, AddressOf client_ChangeUserContentPublic
        'EP.setSearchSvcEndPoint(proxy)
        ProxySearch.ChangeUserContentPublic(_SecureID, CurrSelectedUserGuid, "N", RC, RetMsg)
        client_ChangeUserContentPublic(RC, RetMsg)
    End Sub
    Sub client_ChangeUserContentPublic(RC As Boolean, RetMsg As String)
        Console.WriteLine("PU Trace 30")

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If RC Then
            Dim B As Boolean = RC
            If Not B Then
                MessageBox.Show("Content NOT reset.")
            Else
                MessageBox.Show("Content reset.")
            End If
        Else
            LOG.WriteToSqlLog("ERROR 100 client_ChangeUserContentPublic: " + RetMsg)
        End If
        'RemoveHandler ProxySearch.ChangeUserContentPublicCompleted, AddressOf client_ChangeUserContentPublic
    End Sub

    Private Sub ckClientOnly_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckClientOnly.Checked
        Console.WriteLine("PU Trace 31")
        If Not bGridLoaded Then
            Return
        End If
        bGridLoaded = False
        Dim S As String = ""

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        S = "UPDATE [dbo].[Users] SET [ClientOnly] = 1 WHERE [UserID] = '" + CurrSelectedUserGuid + "'"
        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
        'EP.setSearchSvcEndPoint(proxy)
        S = ENC2.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(S))

        SB.Text = "Set to Client only"
    End Sub

    Private Sub ckClientOnly_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckClientOnly.Unchecked
        Console.WriteLine("PU Trace 32")
        If Not bGridLoaded Then
            Return
        End If
        bGridLoaded = False
        Dim S As String = ""
        S = "UPDATE [dbo].[Users] SET [ClientOnly] = 0 WHERE [UserID] = '" + CurrSelectedUserGuid + "'"
        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
        'EP.setSearchSvcEndPoint(proxy)
        S = ENC2.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(S))

        SB.Text = "Set NOT Client only"
    End Sub

    Private Sub ckActive_Unchecked_1(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckActive.Unchecked
        Console.WriteLine("PU Trace 33")
        If Not bGridLoaded Then
            Return
        End If
        bGridLoaded = False
        Dim S As String = ""
        S = "UPDATE [dbo].[Users] SET [isActive] = 'N' WHERE [UserID] = '" + CurrSelectedUserGuid + "'"
        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
        'EP.setSearchSvcEndPoint(proxy)
        S = ENC2.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(S))

        SB.Text = "Set to INACTIVE"
    End Sub

    Private Sub ckActive_Checked_1(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckActive.Checked
        Console.WriteLine("PU Trace 34")
        If Not bGridLoaded Then
            Return
        End If
        bGridLoaded = False
        Dim S As String = ""
        S = "UPDATE [dbo].[Users] SET [isActive] = 'Y' WHERE [UserID] = '" + CurrSelectedUserGuid + "'"
        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
        'EP.setSearchSvcEndPoint(proxy)

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        S = ENC2.AES256EncryptString(S)
        'ProxySearch.ExecuteSqlNewConnSecure(_SecureID, gRowID, S, _UserID, ContractID)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(S))

        SB.Text = "Set to ACTIVE"
    End Sub

    Private Sub dt_CoOwnerChanged(sender As Object, e As SelectionChangedEventArgs) Handles dgCoOwner.SelectionChanged
        Console.WriteLine("PU Trace 35")
        GetSelectedCoOwnerRowData()
    End Sub

    Private Sub DgUsers_SelectionChanged(sender As Object, e As SelectionChangedEventArgs) Handles dgUsers.SelectionChanged
        Dim idx As Integer = 0
        Dim SelRow As DataGridRow = GetSelectedRow(dgUsers)
        Dim item As Object = dgUsers.SelectedItem
        Dim str As String = ""
        Dim RowIdx As Integer = SelRow.GetIndex
        RowVals.Clear()
        idx = -1
        For Each col As DataGridColumn In dgUsers.Columns
            Dim tgt As String = col.Header.ToString
            idx = getColIdx(dgUsers, tgt)
            str = getCellValue(dgUsers, tgt)
            RowVals.Add(tgt, str)
            Console.WriteLine(tgt + " : " + str)
        Next

        Try
            If RowVals.ContainsKey("Admin") Then
                str = RowVals("Admin")
                If str.Equals("A") Then
                    Me.cbUserType.Text = "Administrator"
                ElseIf str.Equals("S") Then
                    Me.cbUserType.Text = "Super Administrator"
                ElseIf str.Equals("G") Then
                    Me.cbUserType.Text = "Global Searcher"
                Else
                    Me.cbUserType.Text = "User - Standard"
                End If
            End If
            If RowVals.ContainsKey("ClientOnly") Then
                str = RowVals("ClientOnly")
            End If
            If RowVals.ContainsKey("EmailAddress") Then
                str = RowVals("EmailAddress")
                txtEmail.Text = str
            End If
            If RowVals.ContainsKey("HiveActive") Then
                str = RowVals("HiveActive")
            End If
            If RowVals.ContainsKey("HiveConnectionName") Then
                str = RowVals("HiveConnectionName")
            End If
            If RowVals.ContainsKey("RepoSvrName") Then
                str = RowVals("RepoSvrName")
            End If
            If RowVals.ContainsKey("RowCreationDate") Then
                str = RowVals("RepoSvrName")
            End If
            If RowVals.ContainsKey("RowLastModDate") Then
                str = RowVals("RowLastModDate")
            End If
            If RowVals.ContainsKey("UserID") Then
                str = RowVals("UserID")
                txtUserID.Text = str
            End If
            If RowVals.ContainsKey("UserLoginID") Then
                str = RowVals("UserLoginID")
            End If
            If RowVals.ContainsKey("UserName") Then
                str = RowVals("UserName")
                txtUserName.Text = str
            End If
            If RowVals.ContainsKey("ClientOnly") Then
                str = RowVals("ClientOnly")
                If str.ToLower.Equals("y") Then
                    ckClientOnly.IsChecked = True
                Else
                    ckClientOnly.IsChecked = False
                End If
            End If
            If RowVals.ContainsKey("isActive") Then
                str = RowVals("isActive")
                If str.ToLower.Equals("y") Then
                    ckActive.IsChecked = True
                Else
                    ckActive.IsChecked = False
                End If
            End If
        Catch ex As Exception

        End Try



    End Sub

    Private Sub LayoutRoot_Loaded(sender As Object, e As RoutedEventArgs) Handles LayoutRoot.Loaded
        HideGridColumn(dgUsers, "ExtensionData")
        If Not cbUserType.Items.Contains("Super Administrator") Then
            cbUserType.Items.Add("Super Administrator")
        End If
    End Sub


End Class

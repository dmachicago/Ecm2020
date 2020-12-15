' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 07-16-2020
' ***********************************************************************
' <copyright file="popupGroupLibraries.xaml.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports ECMEncryption

''' <summary>
''' Class popupGroupLibraries.
''' Implements the <see cref="System.Windows.Window" />
''' Implements the <see cref="System.Windows.Markup.IComponentConnector" />
''' </summary>
''' <seealso cref="System.Windows.Window" />
''' <seealso cref="System.Windows.Markup.IComponentConnector" />
Public Class popupGroupLibraries
    'Inherits ChildWindow

    'Dim GVAR As App = App.Current
    ''' <summary>
    ''' The common
    ''' </summary>
    Dim COMMON As New clsCommonFunctions

    'Dim EP As New clsEndPoint
    ''' <summary>
    ''' The utility
    ''' </summary>
    Dim UTIL As New clsUtility

    'Dim proxy As New SVCSearch.Service1Client
    ''' <summary>
    ''' The userid
    ''' </summary>
    Dim Userid As String

    ''' <summary>
    ''' The log
    ''' </summary>
    Dim LOG As New clsLoggingExtended
    ''' <summary>
    ''' The en c2
    ''' </summary>
    Dim ENC2 As New ECMEncrypt()

    ''' <summary>
    ''' The list of assigned users
    ''' </summary>
    Dim ListOfAssignedUsers As New ArrayList()
    ''' <summary>
    ''' The object list of assigned users
    ''' </summary>
    Dim ObjListOfAssignedUsers As Object = Nothing
    ''' <summary>
    ''' The group name
    ''' </summary>
    Dim GroupName As String = ""

    ''' <summary>
    ''' The group owner user identifier
    ''' </summary>
    Dim GroupOwnerUserID As String = ""
    ''' <summary>
    ''' The library owner user identifier
    ''' </summary>
    Dim LibOwnerUserID As String = ""
    ''' <summary>
    ''' The curr library name
    ''' </summary>
    Dim CurrLibName As String = ""

    ''' <summary>
    ''' The b group library access insert
    ''' </summary>
    Dim bGroupLibraryAccessInsert As Boolean = False

    ''' <summary>
    ''' Initializes a new instance of the <see cref="popupGroupLibraries"/> class.
    ''' </summary>
    ''' <param name="_GrpName">Name of the GRP.</param>
    Public Sub New(ByVal _GrpName As String)
        InitializeComponent()
        'EP.setSearchSvcEndPoint(proxy)

        COMMON.SaveClick(6800, Userid)

        GroupName = _GrpName
        Userid = _UserID

        'AddHandler ProxySearch.getGroupOwnerGuidByGroupNameCompleted, AddressOf client_getGroupOwnerGuidByGroupName
        'EP.setSearchSvcEndPoint(proxy)
        Dim SS As String = ProxySearch.getGroupOwnerGuidByGroupName(_SecureID, GroupName)
        client_getGroupOwnerGuidByGroupName(SS)

        If _isAdmin Then
            ckShowAllLibs.Visibility = Windows.Visibility.Visible
        Else
            ckShowAllLibs.Visibility = Windows.Visibility.Collapsed
        End If

        lblGroup.Content = "Group '" + GroupName + "' assigned libraries."
        lblCurrGroup.Content = GroupName

        PopulateLibraryListBox()
        PopulateLibraryComboBox()

        btnRemoveGroupFromLibrary.Visibility = Visibility.Collapsed

    End Sub

    ''' <summary>
    ''' Clients the name of the get group owner unique identifier by group.
    ''' </summary>
    ''' <param name="SS">The ss.</param>
    Sub client_getGroupOwnerGuidByGroupName(SS As String)
        If SS.Length > 0 Then
            GroupOwnerUserID = SS
        Else
            gErrorCount += 1
            LOG.WriteTraceLog("PU GroupLibraries ERROR client_getGroupOwnerGuidByGroupName 100: ")
        End If
        'RemoveHandler ProxySearch.getGroupOwnerGuidByGroupNameCompleted, AddressOf client_getGroupOwnerGuidByGroupName
    End Sub

    ''' <summary>
    ''' Handles the Click event of the OKButton control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub OKButton_Click(ByVal sender As Object, ByVal e As RoutedEventArgs) Handles OKButton.Click
        Me.DialogResult = True
    End Sub

    ''' <summary>
    ''' Handles the Click event of the CancelButton control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub CancelButton_Click(ByVal sender As Object, ByVal e As RoutedEventArgs) Handles CancelButton.Click
        Me.DialogResult = False
    End Sub

    ''' <summary>
    ''' Clients the name of the get library owner by.
    ''' </summary>
    ''' <param name="SS">The ss.</param>
    Sub client_GetLibOwnerByName(SS As String)
        CurrLibName = cbLibrary.Text
        If SS.Length > 0 Then
            LibOwnerUserID = SS
            Try
                If GroupOwnerUserID.Length = 0 Then
                    MessageBox.Show("Could not determine owner of Group '" + GroupName + "', returning.")
                    Return
                End If
                If LibOwnerUserID.Length = 0 Then
                    MessageBox.Show("Could not determine owner of Library '" + CurrLibName + "', returning.")
                    Return
                End If

                bGroupLibraryAccessInsert = True
                GroupLibraryAccessInsert(CurrLibName)
            Catch ex As Exception
                MessageBox.Show("ERROR: client_GetLibOwnerByName 200 - " + ex.Message)
            End Try
        Else
            LibOwnerUserID = ""
            gErrorCount += 1
            LOG.WriteTraceLog("PU GroupLibraries ERROR client_GetLibOwnerByName 100: ")
        End If

        'RemoveHandler ProxySearch.GetLibOwnerByNameCompleted, AddressOf client_GetLibOwnerByName

    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnAddGroupToLibrary control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnAddGroupToLibrary_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnAddGroupToLibrary.Click

        ListOfAssignedUsers.Clear()

        CurrLibName = cbLibrary.Text

        If CurrLibName.Length = 0 Then
            MessageBox.Show("Both a Group and Library must be selected... returning.")
            Return
        End If

        'AddHandler ProxySearch.GetLibOwnerByNameCompleted, AddressOf client_GetLibOwnerByName
        'EP.setSearchSvcEndPoint(proxy)
        Dim SS As String = ProxySearch.GetLibOwnerByName(_SecureID, CurrLibName)
        client_GetLibOwnerByName(SS)

        btnRemoveGroupFromLibrary.Visibility = Visibility.Collapsed

    End Sub

    ''' <summary>
    ''' Groups the library access insert.
    ''' </summary>
    ''' <param name="LibraryName">Name of the library.</param>
    Sub GroupLibraryAccessInsert(ByVal LibraryName As String)
        bGroupLibraryAccessInsert = True
        Dim s As String = ""
        s = s + "if not exists (select GroupName from GroupLibraryAccess where GroupName = '" + GroupName + "' and GroupOwnerUserID = '" + GroupOwnerUserID + "' and LibraryName = '" + LibraryName + "' and UserID = '" + _UserGuid + "')"
        s = s + "BEGIN"
        s = s + " INSERT INTO GroupLibraryAccess("
        s = s + "UserID,"
        s = s + "LibraryName,"
        s = s + "GroupOwnerUserID,"
        s = s + "GroupName) values ("
        s = s + "'" + _UserGuid + "'" + ","
        s = s + "'" + LibraryName + "'" + ","
        s = s + "'" + GroupOwnerUserID + "'" + ","
        s = s + "'" + GroupName + "'" + ")"
        s = s + "END"

        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
        'EP.setSearchSvcEndPoint(proxy)
        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))
    End Sub

    ''' <summary>
    ''' gs the log SQL.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="S">The s.</param>
    Sub gLogSQL(RC As Boolean, S As String)

        Dim RetMsg As String = ""
        Dim SSID As Integer = 0

        If RC Then
            If bGroupLibraryAccessInsert Then
                bGroupLibraryAccessInsert = False
                'AddHandler ProxySearch.getGroupUsersCompleted, AddressOf client_getGroupUsers
                'EP.setSearchSvcEndPoint(proxy)
                ProxySearch.getGroupUsers(_SecureID, lblCurrGroup.Content, ObjListOfAssignedUsers, RC, RetMsg)
                client_getGroupUsers(RC, RetMsg)
                PopulateLibraryListBox()
            End If
        Else
            gErrorCount += 1
            LOG.WriteTraceLog("PU GroupLibraries ERROR clsSql 100: " + S)
        End If
        'RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnRemoveGroupFromLibrary control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnRemoveGroupFromLibrary_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnRemoveGroupFromLibrary.Click
        ListOfAssignedUsers.Clear()

        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        Dim iCnt As Integer = lbAssignedLibs.SelectedItems.Count
        If iCnt <> 1 Then
            MessageBox.Show("One and only one LIBRARY must be selected... returning.")
            Return
        End If

        iCnt = lbAssignedLibs.SelectedIndex
        Dim LibName As String = lbAssignedLibs.SelectedItem

        Dim msg$ = "This will remove the selected LIBRARY from the GROUP, are you sure?"
        Dim result As MessageBoxResult = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel)
        If result = MessageBoxResult.Cancel Then
            SB.Text = "delete cancelled."
            Return
        End If

        Dim S As String = "Delete from GroupLibraryAccess Where GroupName = '" + GroupName + "' and   GroupOwnerUserID = '" + GroupOwnerUserID + "' and   LibraryName = '" + LibName + "' and   UserID = '" + Userid + "'"

        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_DeleteGroupLibraryAccess
        'EP.setSearchSvcEndPoint(proxy)
        S = ENC2.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, S, _UserID, ContractID)
        client_DeleteGroupLibraryAccess(BB, ENC2.AES256EncryptString(S))

    End Sub

    ''' <summary>
    ''' Clients the delete group library access.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="S">The s.</param>
    Sub client_DeleteGroupLibraryAccess(RC As Boolean, S As String)
        ListOfAssignedUsers.Clear()
        If RC Then
            Dim RetMsg As String = ""

            'AddHandler ProxySearch.getGroupUsersCompleted, AddressOf client_getGroupUsers
            'EP.setSearchSvcEndPoint(proxy)
            ProxySearch.getGroupUsers(_SecureID, GroupName, ObjListOfAssignedUsers, RC, RetMsg)
            client_getGroupUsers(RC, RetMsg)

            PopulateLibraryListBox()
        Else
            LOG.WriteTraceLog("PU GroupLibraries ERROR client_DeleteGroupLibraryAccess 100: failed to delete group: " + S)
            SB.Text = "ERROR client_DeleteGroupLibraryAccess 100: failed to delete group."
        End If
        'RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_DeleteGroupLibraryAccess
    End Sub

    ''' <summary>
    ''' Clients the get group users.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    Sub client_getGroupUsers(RC As Boolean, RetMsg As String)
        ListOfAssignedUsers.Clear()

        If RC Then

            ProxySearch.cleanUpLibraryItems(_SecureID, _UserGuid)

            'AddHandler ProxySearch.AddLibraryGroupUserCompleted, AddressOf client_AddLibraryGroupUser
            'EP.setSearchSvcEndPoint(proxy)
            ProxySearch.AddLibraryGroupUser(_SecureID, GroupName, RC, RC, _UserID, ContractID)
            client_AddLibraryGroupUser(RC)
        Else
            LOG.WriteTraceLog("PU GroupLibraries ERROR client_getGroupUsers 200: " + RetMsg)
        End If

        'RemoveHandler ProxySearch.getGroupUsersCompleted, AddressOf client_getGroupUsers

    End Sub

    ''' <summary>
    ''' Clients the add library group user.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    Sub client_AddLibraryGroupUser(RC As Boolean)
        Dim RetMsg As String = ""
        If RC Then
            'AddHandler ProxySearch.ResetLibraryUsersCountCompleted, AddressOf client_ResetLibraryUsersCount
            'EP.setSearchSvcEndPoint(proxy)
            ProxySearch.ResetLibraryUsersCount(_SecureID, RC)
            client_ResetLibraryUsersCount(RC)
            Me.Cursor = Cursors.Arrow
        Else
            LOG.WriteTraceLog("PU GroupLibraries ERROR client_AddLibraryGroupUser 200: ")
        End If
        'RemoveHandler ProxySearch.AddLibraryGroupUserCompleted, AddressOf client_AddLibraryGroupUser
    End Sub

    ''' <summary>
    ''' Clients the reset library users count.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    Sub client_ResetLibraryUsersCount(RC As Boolean)
        Dim SSID As Integer = 0
        Dim RetMsg As String = ""
        If RC Then
            SB.Text = "Reset Library Users Count successful."
        Else
            LOG.WriteTraceLog("PU GroupLibraries ERROR client_AddLibraryGroupUser 200: ")
        End If
        'RemoveHandler ProxySearch.ResetLibraryUsersCountCompleted, AddressOf client_ResetLibraryUsersCount
    End Sub

    ''' <summary>
    ''' Populates the library ListBox.
    ''' </summary>
    Sub PopulateLibraryListBox()

        Dim RC As Boolean = True
        Dim RetMsg As String = ""
        Dim SSID As Integer = 0
        Dim ListOfItems As New System.Collections.ObjectModel.ObservableCollection(Of String)
        Dim S As String = ""

        Dim CurrGroup As String = UTIL.RemoveSingleQuotes(lblCurrGroup.Content)

        If CurrGroup.Trim.Length = 0 Then
            Return
        End If

        CurrGroup = UTIL.RemoveSingleQuotes(CurrGroup)

        S = "select LibraryName from GroupLibraryAccess Where GroupName = '" + CurrGroup + "'"

        'AddHandler ProxySearch.getListOfStrings01Completed, AddressOf client_PopulateLibraryListBox
        'EP.setSearchSvcEndPoint(proxy)
        S = ENC2.AES256EncryptString(S)
        Dim ObjListOfRows As Object = ProxySearch.getListOfStrings01(_SecureID, S, RC, RetMsg, _UserID, ContractID)
        client_PopulateLibraryListBox(ObjListOfRows, RC, RetMsg)

    End Sub

    ''' <summary>
    ''' Clients the populate library ListBox.
    ''' </summary>
    ''' <param name="ObjListOfRows">The object list of rows.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="retmsg">The retmsg.</param>
    Sub client_PopulateLibraryListBox(ObjListOfRows As Object, RC As Boolean, retmsg As String)

        Dim ListOfRows As New System.Collections.ObjectModel.ObservableCollection(Of SVCSearch.DS_ListOfStrings02)
        ListOfRows = ObjListOfRows


        lbAssignedLibs.Items.Clear()
        If ListOfRows.Count > 0 Then
            For I As Integer = 0 To ListOfRows.Count - 1
                Dim VDS As New SVCSearch.DS_ListOfStrings02
                VDS = ListOfRows(I)
                lbAssignedLibs.Items.Add(VDS.strItem)
            Next
        Else
            gErrorCount += 1
            SB.Text = "ERROR client_PopulateLibraryComboBox 100: " + retmsg
            LOG.WriteTraceLog("PU GroupLibraries ERROR client_PopulateLibraryComboBox 100: " + retmsg)
        End If
        'RemoveHandler ProxySearch.getListOfStringsCompleted, AddressOf client_PopulateLibraryComboBox
    End Sub

    ''' <summary>
    ''' Populates the library ComboBox.
    ''' </summary>
    Sub PopulateLibraryComboBox()

        Dim RC As Boolean = True
        Dim RetMsg As String = ""
        Dim SSID As Integer = 0
        Dim ListOfItems As New List(Of String)
        Dim ObjListOfItems As String() = Nothing
        Dim S As String = ""

        If ckShowAllLibs.IsChecked Then
            S = "SELECT [LibraryName] FROM [Library] order by LibraryName"
        Else
            S = "SELECT [LibraryName] FROM [Library] where [UserID] = '" + _UserGuid + "' order by LibraryName"
        End If

        Dim strListOfItems As String = ""
        S = ENC2.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.getListOfStrings(_SecureID, strListOfItems, S, RC, RetMsg)
        ObjListOfItems = strListOfItems.Split("|")

        client_PopulateLibraryComboBox(ObjListOfItems, RC, RetMsg)

    End Sub

    ''' <summary>
    ''' Clients the populate library ComboBox.
    ''' </summary>
    ''' <param name="ObjListOfItems">The object list of items.</param>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    Sub client_PopulateLibraryComboBox(ObjListOfItems As String(), RC As Boolean, RetMsg As String)

        cbLibrary.Items.Clear()
        If ObjListOfItems.Count > 0 Then
            For Each S As String In ObjListOfItems
                cbLibrary.Items.Add(S)
            Next
        Else
            gErrorCount += 1
            SB.Text = "ERROR client_PopulateLibraryComboBox 100: " + RetMsg
            LOG.WriteTraceLog("PU GroupLibraries ERROR client_PopulateLibraryComboBox 100: " + RetMsg)
        End If
        'RemoveHandler ProxySearch.getListOfStringsCompleted, AddressOf client_PopulateLibraryComboBox
    End Sub

    ''' <summary>
    ''' Handles the SelectionChanged event of the lbAssignedLibs control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub lbAssignedLibs_SelectionChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.SelectionChangedEventArgs) Handles lbAssignedLibs.SelectionChanged

        CurrLibName = lbAssignedLibs.SelectedValue
        btnRemoveGroupFromLibrary.Visibility = Visibility.Visible

    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnRefresh control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnRefresh_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnRefresh.Click
        PopulateLibraryComboBox()
    End Sub

    ''' <summary>
    ''' Handles the Unloaded event of the popupGroupLibraries control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub popupGroupLibraries_Unloaded(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles MyBase.Unloaded
        ''Application.Current.RootVisual.SetValue(Control.IsEnabledProperty, True)
    End Sub

End Class
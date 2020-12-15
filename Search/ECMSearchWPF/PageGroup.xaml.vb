' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 07-16-2020
' ***********************************************************************
' <copyright file="PageGroup.xaml.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports System.Data
Imports System.Web.Script.Serialization
Imports ECMEncryption

''' <summary>
''' Class PageGroup.
''' Implements the <see cref="System.Windows.Window" />
''' Implements the <see cref="System.Windows.Markup.IComponentConnector" />
''' </summary>
''' <seealso cref="System.Windows.Window" />
''' <seealso cref="System.Windows.Markup.IComponentConnector" />
Public Class PageGroup

    ''' <summary>
    ''' The dt
    ''' </summary>
    Dim DT As DataTable = New DataTable("GroupUsers")
    'Dim GVAR As App = App.Current
    ''' <summary>
    ''' The log
    ''' </summary>
    Dim LOG As New clsLogMain
    ''' <summary>
    ''' The dma
    ''' </summary>
    Dim DMA As New clsDma
    ''' <summary>
    ''' The common
    ''' </summary>
    Dim COMMON As New clsCommonFunctions
    ''' <summary>
    ''' The utility
    ''' </summary>
    Dim UTIL As New clsUtility
    ''' <summary>
    ''' The xlog
    ''' </summary>
    Dim XLOG As New clsLoggingExtended

    ''' <summary>
    ''' The user identifier
    ''' </summary>
    Dim UserID As String = ""
    ''' <summary>
    ''' The ret MSG
    ''' </summary>
    Dim RetMsg As String = ""
    ''' <summary>
    ''' The rc
    ''' </summary>
    Dim RC As Boolean = False

    ''' <summary>
    ''' The current group name
    ''' </summary>
    Dim CurrentGroupName As String = ""
    ''' <summary>
    ''' The group owner unique identifier
    ''' </summary>
    Dim GroupOwnerGuid As String = ""
    ''' <summary>
    ''' The assigned users
    ''' </summary>
    Dim AssignedUsers As New List(Of String)

    ''' <summary>
    ''' The sddebug
    ''' </summary>
    Dim sddebug As String = System.Configuration.ConfigurationManager.AppSettings("DebugON")
    ''' <summary>
    ''' The ddebug
    ''' </summary>
    Dim ddebug As Boolean = False

    'Dim proxy As New SVCSearch.Service1Client
    ''' <summary>
    ''' The SLQ dictionary
    ''' </summary>
    Dim SlqDict As New System.Collections.Generic.Dictionary(Of Integer, String)

    'Dim EP As New clsEndPoint
    ''' <summary>
    ''' The en c2
    ''' </summary>
    Dim ENC2 As New ECMEncrypt()

    ''' <summary>
    ''' Initializes a new instance of the <see cref="PageGroup"/> class.
    ''' </summary>
    Public Sub New()
        InitializeComponent()

        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 00")
        'EP.setSearchSvcEndPoint(proxy)

        If sddebug = "1" Then ddebug = True

        '** Set global variables
        UserID = _UserID

        If ddebug Then Debug.Print("gCurrUserGuidID : " + gCurrUserGuidID)

        If _isAdmin Then
            BtnAdd.Visibility = Visibility.Visible
            btnDelete.Visibility = Visibility.Visible
        Else
            BtnAdd.Visibility = Visibility.Hidden
            btnDelete.Visibility = Visibility.Hidden
        End If

        DT.Columns.Add("Username")
        DT.Columns.Add("UserID")

        PopulateGroupListbox()

    End Sub

    ''' <summary>
    ''' Handles the Click event of the hlGroupLibs control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub hlGroupLibs_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlGroupLibs.Click
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 01")
        Dim cw As New popupGroupLibraries(CurrentGroupName)
        cw.Show()
    End Sub

    ''' <summary>
    ''' Handles the Click event of the hlHome control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub hlHome_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlHome.Click
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 02")
        'Dim NextPage As New MainPage()
        Me.Close()
    End Sub

    ''' <summary>
    ''' Handles the Click event of the hlLibMgt control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub hlLibMgt_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlLibMgt.Click
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 03")
        Dim NextPage As New PageLibrary
        NextPage.Show()
    End Sub

    ''' <summary>
    ''' Handles the Click event of the BtnAdd control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub BtnAdd_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles BtnAdd.Click
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 04")
        DMA.ReplaceSingleTick(txtUserGroup.Text)
        Dim GroupName As String = txtUserGroup.Text.Trim
        If GroupName$.Trim.Length = 0 Then
            MessageBox.Show("The group name appears to be blank, it cannot be blank.")
            Return
        End If

        CurrentGroupName = GroupName

        Dim tGroupName As String = txtUserGroup.Text.Trim
        GroupName = UTIL.RemoveSingleQuotes(GroupName)

        Dim S As String = "Select count(*) from UserGroup where GroupName = '" + GroupName$ + "'"
        'AddHandler ProxySearch.iCountCompleted, AddressOf client_GroupIcount

        Dim I As Integer = ProxySearch.iCount(_SecureID, S)
        client_GroupIcount(I)

    End Sub

    ''' <summary>
    ''' Clients the group icount.
    ''' </summary>
    ''' <param name="I">The i.</param>
    Sub client_GroupIcount(I As Integer)
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 05")
        Dim RC As Integer = 0
        Dim SSID As Integer = 0
        Dim RetMsg As String = ""

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        CurrentGroupName = UTIL.RemoveSingleQuotes(CurrentGroupName)

        If I = 0 Then
            Dim s As String = ""
            s = s + " INSERT INTO UserGroup("
            s = s + " GroupOwnerUserID,"
            s = s + " GroupName) values ("
            s = s + " '" + gCurrLoginID + "'" + ","
            s = s + " '" + CurrentGroupName + "'" + ")"

            'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecInsertGroup
            'EP.setSearchSvcEndPoint(proxy)
            's = ENC2.AES256EncryptString(s)
            PB.IsIndeterminate = True
            PB.Visibility = Windows.Visibility.Visible
            s = ENC2.AES256EncryptString(s)
            Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, s, _UserID, ContractID)
            client_ExecInsertGroup(BB, s)
        Else
            MessageBox.Show("The group name '" + txtUserGroup.Text.Trim + "' has already been used. " + vbCrLf + "Names must be unique across the organization. Please pick another.")
            Return
        End If
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Hidden
    End Sub

    ''' <summary>
    ''' Clients the insert group.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="S">The s.</param>
    Sub client_InsertGroup(RC As Boolean, S As String)
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 06")
        Dim I As Integer = 0
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If RC Then
            SB.Text = "Group created."
            PopulateGroupListbox()
        Else
            LOG.WriteToSqlLog("ERROR client_InsertGroup 100: ERRR - " + " : ")
        End If
        'RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecInsertGroup
    End Sub

    ''' <summary>
    ''' Clients the execute insert group.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="S">The s.</param>
    Sub client_ExecInsertGroup(RC As Boolean, S As String)
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 07")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If RC Then
            SB.Text = "Successful insert..."
            PopulateGroupListbox()
        Else
            SB.Text = "Failed insert..." + S
        End If
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnDelete control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnDelete.Click
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 08")
        Dim B As Boolean = False
        Dim II As Integer = Me.lbGroups.SelectedIndex
        If II < 0 Then
            MessageBox.Show("An item in the list must be selected, returning.")
            Return
        End If

        Dim UserGroup As String = lbGroups.SelectedValue
        Dim tUserGroup As String = UserGroup

        If UserGroup.Trim.Length = 0 Then
            MessageBox.Show("User group name must be supplied, aborting insert.")
            Return
        End If

        UserGroup = UTIL.RemoveSingleQuotes(UserGroup)

        Dim msg$ = "This will delete the selected GROUP, group users and all group library access, are you sure?"
        Dim result As MessageBoxResult = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel)
        If result = MessageBoxResult.Cancel Then
            SB.Text = "delete cancelled."
            Return
        End If

        For i As Integer = 0 To lbGrpUsers.Items.Count - 1
            lbGrpUsers.Items(i).Selected = True
        Next
        DeleteSelectedUsers()

        SlqDict.Clear()
        Try
            Dim s As String = "delete FROM [GroupUsers] where [GroupName] = '" + UserGroup + "'"
            SlqDict.Add(0, s)

            s = "delete from [GroupLibraryAccess] where GroupName = '" + UserGroup + "'"
            SlqDict.Add(1, s)

            s = "delete FROM [UserGroup] where [GroupName] = '" + UserGroup + "'"
            SlqDict.Add(2, s)

            UserGroupDelete(tUserGroup, gCurrUserGuidID)
        Catch ex As Exception
            MessageBox.Show("ERROR Group may be corrupt, please have an ADMIN clean out the group." + vbCrLf + ex.Message)
            Return
        End Try

        GC.Collect()
        GC.WaitForPendingFinalizers()

        Try
            Me.Cursor = Cursors.Wait
            '** WDM Removed 5/15/2010
            If B Then
                SB.Text = "Successful delete of group " + UserGroup + "."
                ' CKAT.NotifyGroupAssigments(tUserGroup$, AssignedUsers, "Remove")
                PopulateGroupListbox()
            Else
                SB.Text = "Failed delete..."
            End If
        Catch ex As Exception
            Me.Cursor = Cursors.Arrow
        End Try
        Me.Cursor = Cursors.Arrow
    End Sub

    ''' <summary>
    ''' Users the group delete.
    ''' </summary>
    ''' <param name="GroupName">Name of the group.</param>
    ''' <param name="GroupOwnerUserID">The group owner user identifier.</param>
    Sub UserGroupDelete(ByVal GroupName As String, ByVal GroupOwnerUserID As String)
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 09")
        Dim b As Boolean = False

        Dim s As String = " Delete from UserGroup Where GroupName = '" + GroupName + "' and   GroupOwnerUserID = '" + GroupOwnerUserID + "'"
        SlqDict.Add(3, s)

        'AddHandler ProxySearch.ExecuteSqlStackCompleted, AddressOf client_ExecuteSqlStack
        'EP.setSearchSvcEndPoint(proxy)
        Dim BB As Boolean = ProxySearch.ExecuteSqlStack(_SecureID, SlqDict, _UserID, ContractID, "SRCH")
        client_ExecuteSqlStack(BB)

    End Sub

    ''' <summary>
    ''' Clients the execute SQL stack.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    Sub client_ExecuteSqlStack(RC As Boolean)
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 10")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        Dim SSID As Integer = 0
        Dim RetMsg As String = ""
        If RC Then
            SB.Text = ""
            SB.Text = "Group and all associated members removed."
            PopulateGroupListbox()
        Else
            SB.Text = "ERROR client_ExecuteSqlStack Group not removed 100: "
            LOG.WriteToSqlLog("ERROR client_ExecuteSqlStack 100: ")
            MessageBox.Show("ERROR client_ExecuteSqlStack Group not removed 100: ")
        End If
        'RemoveHandler ProxySearch.AddLibraryGroupUserCompleted, AddressOf client_AddLibraryGroupUser

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        PopulateUserLB(lbGroups.SelectedValue)
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnAddToGroup control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnAddToGroup_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnAddToGroup.Click
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 11")

        AssignedUsers.Clear()
        If lbGroups.SelectedItems.Count = 0 Then
            SB.Text = "You must select a group from the list, returning..."
            Return
        End If
        Dim iAdded As Integer = 0
        Dim iSkipped As Integer = 0

        Dim B As Boolean = False
        Dim GroupName As String = lbGroups.SelectedValue

        If GroupName$.Trim.Length = 0 Then
            SB.Text = "You must select a group from the list, returning..."
            Return
        End If

        Dim UserName As String = ""
        Dim UID As String = ""
        Dim FullAccess As String = ""
        Dim ReadOnlyAccess As String = ""
        Dim DeleteAccess As String = ""
        Dim Searchable As String = ""

        Dim I As Integer = lbGrpUsers.SelectedItems.Count

        If I = 0 Then
            MessageBox.Show("A user must be selected to add... please select a user.")
            Return
        End If

        Dim drow As String

        For Each drow In lbGrpUsers.SelectedItems
            'I = drow.Index
            Dim ar() As String = drow.Split(":")
            UserName = ar(0).Trim
            UID = ar(1).Trim
            Dim userinfo As String = UserName + "  :  " + UID
            FullAccess = True
            ReadOnlyAccess = True
            DeleteAccess = True
            Searchable = True

            InsertGroupUser(GroupName, gCurrUserGuidID, UID, FullAccess, ReadOnlyAccess, DeleteAccess, Searchable)
            lbGrpUsers.Items.Add(userinfo)
        Next

        Try
            'CKAT.NotifyGroupAssigments(GroupName$, AssignedUsers, "Assigned")
            SB.Text = iAdded.ToString + " users added, " + iSkipped.ToString + " skipped."
        Catch ex As Exception
            SB.Text = "ERROR: did not add " + iAdded.ToString + " users, " + iSkipped.ToString + " skipped."
        End Try

        'AddHandler ProxySearch.AddLibraryGroupUserCompleted, AddressOf client_AddLibraryGroupUser
        'EP.setSearchSvcEndPoint(proxy)
        'AddLibraryGroupUser(ByRef gSecureID As string, ByVal GroupName As String, ByRef RC As Boolean, CurrUserID As String, SessionID  )
        ProxySearch.AddLibraryGroupUser(_SecureID, GroupName, RC, _UserID, ContractID, "SRCH")
        client_AddLibraryGroupUser(RC)

        'ckBoxShowAllUsers.IsChecked = False
    End Sub

    ''' <summary>
    ''' Clients the add library group user.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    Sub client_AddLibraryGroupUser(RC As Boolean)
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 12")
        Dim SSID As Integer = 0
        Dim RetMsg As String = ""
        If RC Then
            SB.Text = "Library group users added."
            MessageBox.Show("Library group users added.")
        Else
            SB.Text = "ERROR client_AddLibraryGroupUser 100: "
            LOG.WriteToSqlLog("ERROR client_AddLibraryGroupUser 100: ")
            MessageBox.Show("ERROR client_AddLibraryGroupUser 100: ")
        End If
        'RemoveHandler ProxySearch.AddLibraryGroupUserCompleted, AddressOf client_AddLibraryGroupUser
        PopulateUserLB(lbGroups.SelectedValue)
    End Sub

    ''' <summary>
    ''' Inserts the group user.
    ''' </summary>
    ''' <param name="GroupName">Name of the group.</param>
    ''' <param name="GroupOwnerUserID">The group owner user identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="FullAccess">The full access.</param>
    ''' <param name="ReadOnlyAccess">The read only access.</param>
    ''' <param name="DeleteAccess">The delete access.</param>
    ''' <param name="Searchable">The searchable.</param>
    Public Sub InsertGroupUser(ByVal GroupName As String,
                                    ByVal GroupOwnerUserID As String,
                                    ByVal UserID As String,
                                    ByVal FullAccess As String,
                                    ByVal ReadOnlyAccess As String,
                                    ByVal DeleteAccess As String,
                                    ByVal Searchable As String)

        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 13")
        Dim b As Boolean = False
        Dim s As String = ""

        If Searchable.ToUpper = "TRUE" Then
            Searchable = "1"
        Else
            Searchable = "0"
        End If
        If DeleteAccess.ToUpper = "TRUE" Then
            DeleteAccess = "1"
        Else
            DeleteAccess = "0"
        End If
        If ReadOnlyAccess.ToUpper = "TRUE" Then
            ReadOnlyAccess = "1"
        Else
            ReadOnlyAccess = "0"
        End If
        If FullAccess.ToUpper = "TRUE" Then
            FullAccess = "1"
        Else
            FullAccess = "0"
        End If

        'AddGroupUser(gSecureID As string, SessionID As String, UserID As String, FullAccess As String, ReadOnlyAccess As String, DeleteAccess As String, Searchable As String, GroupOwnerUserID As String, GroupName  )

        'Dim EncString As String = ENC2.AES256EncryptString(UserID)
        Dim BB As Boolean = ProxySearch.AddGroupUser(_SecureID, ContractID, _UserID, UserID, FullAccess, ReadOnlyAccess, DeleteAccess, Searchable, GroupOwnerGuid, GroupName, "SRCH")

        client_AddGroupUser(BB)

    End Sub

    ''' <summary>
    ''' Clients the add group user.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    Sub client_AddGroupUser(RC As Boolean)
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 14")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If RC Then
            SB.Text = "Successfully added."
        Else
            MessageBox.Show("FAILED to add user(s).")
        End If

        'RemoveHandler ProxySearch.AddGroupUserCompleted, AddressOf client_AddGroupUser

    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnRemove control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnRemove_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnRemove.Click
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 15")
        AssignedUsers.Clear()
        Dim GroupName As String = ""
        'Dim DR As DataRowView
        Dim iDeleted As Integer = 0
        Dim iSkipped As Integer = 0

        If lbGroups.SelectedItems.Count = 1 Then
            GroupName = lbGroups.SelectedValue
        Else
            SB.Text = "ONLY ONE GROUP MUST BE SELECTED, returning."
            Return
        End If

        Dim II As Integer = Me.lbGrpUsers.SelectedItems.Count

        If II = 0 Then
            MessageBox.Show("A user must be selected in order to remove... please select a user.")
            Return
        End If

        Dim msg As String = "This will delete the selected user(s) from the GROUP '" + GroupName + "', are you sure?"
        Dim result As MessageBoxResult = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel)
        If result = MessageBoxResult.Cancel Then
            SB.Text = "delete cancelled."
            Return
        End If

        DeleteSelectedUsers()

        Try
            'CKAT.NotifyGroupAssigments(GroupName, AssignedUsers, "Remove")
        Catch ex As Exception
            SB.Text = "Failed to notify users."
        End Try

        SB.Text = "User(s) removed from group, " + iSkipped.ToString + " users skipped."

        ProxySearch.cleanUpLibraryItems(_SecureID, _UserGuid)

        'AddHandler ProxySearch.ResetLibraryUsersCountCompleted, AddressOf client_ResetLibraryUsersCount
        'EP.setSearchSvcEndPoint(proxy)
        ProxySearch.ResetLibraryUsersCount(_SecureID, RC)
        client_ResetLibraryUsersCount(RC)
    End Sub

    ''' <summary>
    ''' Clients the reset library users count.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    Sub client_ResetLibraryUsersCount(RC As Boolean)
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 16")
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        Dim SSID As Integer = 0
        Dim RetMsg As String = ""
        If RC Then
            SB.Text = "Library items Count Reset."
        Else
            SB.Text = "ERROR client_ResetLibraryUsersCount 100: "
            LOG.WriteToSqlLog("ERROR client_ResetLibraryUsersCount 100: ")
        End If
        'RemoveHandler ProxySearch.ResetLibraryUsersCountCompleted, AddressOf client_ResetLibraryUsersCount
    End Sub

    ''' <summary>
    ''' Adds the owner to group.
    ''' </summary>
    ''' <param name="GroupName">Name of the group.</param>
    Sub AddOwnerToGroup(ByVal GroupName As String)
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 17")
        'Dim GroupName$ = txtUserGroup.Text.Trim
        If GroupName$.Length = 0 Then
            MessageBox.Show("No group name was suppleid, returning.")
            Return
        End If

        Dim UID$ = _UserGuid
        Dim FullAccess$ = "0"
        Dim ReadOnlyAccess$ = "0"
        Dim DeleteAccess$ = "0"
        Dim Searchable$ = "0"

        InsertGroupUser(GroupName, GroupOwnerGuid, gCurrUserGuidID, FullAccess, ReadOnlyAccess, DeleteAccess, Searchable)
        AssignedUsers.Add(UID)
        PopulateUserLB(GroupName)

    End Sub

    ''' <summary>
    ''' Populates the user lb.
    ''' </summary>
    ''' <param name="GroupName">Name of the group.</param>
    Sub PopulateUserLB(ByVal GroupName As String)
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 18")
        If lbGroups.SelectedItems.Count <> 1 Then
            PB.IsIndeterminate = False
            PB.Visibility = Windows.Visibility.Collapsed
            SB.Text = "One and only one group must be selected."
            Return
        End If

        If GroupName.Length = 0 Then
            GroupName = "!@#$"
        End If
        GroupName = lbGroups.SelectedItem

        Dim S As String = ""
        S = S + " SELECT   distinct  Users.UserName, Users.UserID AS UserID, GroupUsers.FullAccess, GroupUsers.ReadOnlyAccess, GroupUsers.DeleteAccess, GroupUsers.Searchable" + vbCrLf
        S = S + " FROM         GroupUsers RIGHT OUTER JOIN" + vbCrLf
        S = S + "           Users ON GroupUsers.UserID = Users.UserID" + vbCrLf
        S = S + " WHERE     (GroupUsers.GroupOwnerUserID = '" + gCurrUserGuidID + "') AND (GroupUsers.GroupName = '" + GroupName + "')" + vbCrLf
        S = S + " order by Users.UserName"

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        'AddHandler ProxySearch.PopulateGroupUserGridCompleted, AddressOf client_PopulateGroupUserGrid
        'EP.setSearchSvcEndPoint(proxy)
        Dim strDS_dgGrpUsers As Object = ProxySearch.PopulateGroupUserGrid(_SecureID, GroupName)
        client_PopulateGroupUserGrid(strDS_dgGrpUsers)


        PB.IsIndeterminate = False
        PB.Visibility = Visibility.Hidden

    End Sub

    ''' <summary>
    ''' Clients the populate group user grid.
    ''' </summary>
    ''' <param name="strDS_dgGrpUsers">The string ds dg GRP users.</param>
    Sub client_PopulateGroupUserGrid(strDS_dgGrpUsers As String)
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 19")
        Dim ListOfRows As New System.Collections.ObjectModel.ObservableCollection(Of DS_dgGrpUsers)
        Dim jss = New JavaScriptSerializer()
        Dim ObjContent = jss.Deserialize(Of DS_dgGrpUsers())(strDS_dgGrpUsers)
        Dim Z As Integer = ObjContent.Count
        Dim userinfo As String = ""
        Dim uid As String = ""

        DT.Rows.Clear()

        lbGrpUsers.Items.Clear()

        For Each Obj As DS_dgGrpUsers In ObjContent
            userinfo = Obj.UserName + "  :  " + Obj.UserID
            lbGrpUsers.Items.Add(userinfo)
        Next

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        'RemoveHandler ProxySearch.PopulateGroupUserGridCompleted, AddressOf client_PopulateGroupUserGrid
    End Sub

    ''' <summary>
    ''' Deletes the selected users.
    ''' </summary>
    Sub DeleteSelectedUsers()
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 20")
        Dim GroupName As String = ""
        Dim iDeleted As Integer = 0
        Dim iSkipped As Integer = 0
        'Dim drow As C1.Silverlight.FlexGrid.Row

        If lbGroups.SelectedItems.Count <> 1 Then
            MessageBox.Show("One and only one group must be selected, returning.")
            Return
        Else
            Dim IX As Integer = lbGroups.SelectedIndex
            GroupName = lbGroups.SelectedItems(0)
            CurrentGroupName = GroupName
        End If

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        'AddHandler ProxySearch.getGroupOwnerGuidByGroupNameCompleted, AddressOf client_DeleteGroupMembersByOwnerGuid
        'EP.setSearchSvcEndPoint(proxy)
        Dim OwnerGuid As String = ProxySearch.getGroupOwnerGuidByGroupName(_SecureID, GroupName)
        client_DeleteGroupMembersByOwnerGuid(gCurrLogin)

    End Sub

    ''' <summary>
    ''' Clients the delete group members by owner unique identifier.
    ''' </summary>
    ''' <param name="OwnerGuid">The owner unique identifier.</param>
    Sub client_DeleteGroupMembersByOwnerGuid(OwnerGuid As String)
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 21")
        'Try
        '    'RemoveHandler ProxySearch.DeleteGroupUsersCompleted, AddressOf client_DeleteGroupUsers
        'Catch ex As Exception
        '    Console.WriteLine(ex.Message)
        'End Try
        Dim RetMsg As String = ""
        Dim SelectedUserIDs As String = ""

        Dim TrackingNbr As Integer = 0
        If OwnerGuid.Length > 0 Then

            'AddHandler ProxySearch.DeleteGroupUsersCompleted, AddressOf client_DeleteGroupUsers
            'EP.setSearchSvcEndPoint(proxy)
            Dim UidToRemove As String = lbGrpUsers.SelectedValue
            For Each drow As String In Me.lbGrpUsers.SelectedItems
                Dim AR() As String = drow.Split(":")
                Dim UserIdCol As Integer = 1
                Dim UserName = AR(0).Trim
                Dim UID As String = AR(1).Trim
                If UID.Equals(OwnerGuid) Then
                    GoTo SKIPIT
                End If

                SelectedUserIDs = UID + ";"

SKIPIT:
            Next
        Else
            gErrorCount += 1
            LOG.WriteToSqlLog("ERROR client_DeleteGroupMembersByOwnerGuid 100: ")
        End If

        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        Dim iDeleted As Integer = 0
        Dim BB As Boolean = ProxySearch.DeleteGroupUsers(_SecureID, CurrentGroupName, OwnerGuid, SelectedUserIDs, iDeleted, RetMsg)
        client_DeleteGroupUsers(BB, iDeleted, RetMsg)

        'RemoveHandler ProxySearch.getGroupOwnerGuidByGroupNameCompleted, AddressOf client_DeleteGroupMembersByOwnerGuid

    End Sub

    ''' <summary>
    ''' Clients the delete group users.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="iDeleted">The i deleted.</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    Sub client_DeleteGroupUsers(RC As Boolean, iDeleted As Integer, RetMsg As String)
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 22")
        Dim TrackingNbr As Integer = 0
        Dim RemovedUsers As Integer = 0

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If RC Then
            lbGrpUsers.Items.Clear()
            PopulateUserLB(lbGroups.SelectedValue)
            Dim B As Boolean = RC
            RemovedUsers = iDeleted
            If Not B Then
                MessageBox.Show("Failed to remove all selected group members: " + RetMsg)
            Else
                MessageBox.Show("Members removed.")
            End If
        Else
            gErrorCount += 1
            LOG.WriteToSqlLog("ERROR client_DeleteGroupUsers 100: " + RetMsg)
        End If
        ''RemoveHandler ProxySearch.DeleteGroupUsersCompleted, AddressOf client_DeleteGroupUsers
    End Sub

    ''' <summary>
    ''' Populates the group listbox.
    ''' </summary>
    Sub PopulateGroupListbox()
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 23 in")
        Dim RC As Boolean = True
        Dim RetMsg As String = ""
        Dim SSID As Integer = 0
        'Dim ListOfItems As New System.Collections.Generic.List(Of String)
        Dim ListOfItems() As String = Nothing
        Dim L As Integer = 0
        Try
            gCurrUserGuidID = getUserGuidID(gCurrLoginID) : L = 1

            Dim S As String = "Select [GroupName] FROM [UserGroup] where [GroupOwnerUserID] = '" + gCurrUserGuidID + "' order by GroupName" : L = 2

            'AddHandler ProxySearch.getListOfStringsCompleted, AddressOf client_RepopulateGroupListbox
            'EP.setSearchSvcEndPoint(proxy)

            Dim strListOfItems As String = "" : L = 3
            'S = ENC2.AES256EncryptString(S)

            Dim BB As Boolean = ProxySearch.getListOfStrings(_SecureID, strListOfItems, S, RC, RetMsg) : L = 4

            If strListOfItems.Trim.Length > 0 And BB.Equals(True) Then : L = 5
                ListOfItems = strListOfItems.Split("|") : L = 6
                client_RepopulateGroupListbox(BB, ListOfItems, RetMsg) : L = 7
                ListOfItems = Nothing : L = 8
            Else
                SB.Text = "No groups found... for: " + gCurrUserGuidID : L = 9
            End If
        Catch ex As Exception
            If ddebug Then XLOG.WriteTraceLog("PageGroup Trace ERROR 23: @ line# " + L.ToString + vbCrLf + ex.Message)
            SB.Text = "PageGroup Trace ERROR 23: No groups found... for: " + gCurrUserGuidID
        End Try


        GC.Collect()

        '** Called by a popup screen
        'PopulateLibCombo()
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 23 out")
    End Sub

    ''' <summary>
    ''' Clients the repopulate group listbox.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="ListOfItems">The list of items.</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    Sub client_RepopulateGroupListbox(RC As Boolean, ListOfItems As String(), RetMsg As String)
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 24")
        Dim SSID As Integer = 0

        Try
            lbGroups.Items.Clear()
            If RC Then
                For Each S As String In ListOfItems
                    lbGroups.Items.Add(S)
                Next
            Else
                gErrorCount += 1
                SB.Text = "ERROR client_RepopulateGroupListbox 100: " + RetMsg
                LOG.WriteToSqlLog("ERROR client_RepopulateGroupListbox 100: " + RetMsg)
            End If
        Catch ex As Exception
            If ddebug Then XLOG.WriteTraceLog("PageGroup Trace ERROR 24: " + ex.Message)
        End Try

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed
    End Sub

    ''' <summary>
    ''' Cks the user exists elsewhere.
    ''' </summary>
    ''' <param name="TcbLibraryName">Name of the TCB library.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <param name="UserName">Name of the user.</param>
    Sub ckUserExistsElsewhere(ByVal TcbLibraryName As String, ByVal UserID As String, ByVal UserName As String)
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 25")
        Dim S As String = ""

        Try
            TcbLibraryName$ = UTIL.RemoveSingleQuotes(TcbLibraryName)
            S = S + " select COUNT (*) from libraryusers where UserID = '" + UserID$ + "' "
            S = S + " and LibraryName = '" + TcbLibraryName$ + "'"

            'AddHandler ProxySearch.iCountCompleted, AddressOf client_UserExistsElsewhereCount
            'EP.setSearchSvcEndPoint(proxy)
            Dim II As Integer = ProxySearch.iCountContent(_SecureID, S)
            client_UserExistsElsewhereCount(II)
        Catch ex As Exception
            If ddebug Then XLOG.WriteTraceLog("PageGroup Trace ERROR 25: " + ex.Message)
        End Try


    End Sub

    ''' <summary>
    ''' Clients the user exists elsewhere count.
    ''' </summary>
    ''' <param name="II">The ii.</param>
    Sub client_UserExistsElsewhereCount(II As Integer)
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 26")
        If II > 0 Then
            MessageBox.Show("Warning - This user still has access to this library through a group entry.")
        Else
            SB.Text = "ERROR client_UserExistsElsewhereCount 26: "
            LOG.WriteToSqlLog("ERROR client_UserExistsElsewhereCount 26: ")
        End If
        'RemoveHandler ProxySearch.iCountCompleted, AddressOf client_UserExistsElsewhereCount
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed
    End Sub

    ''' <summary>
    ''' Handles the SelectionChanged event of the lbGroups control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub lbGroups_SelectionChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.SelectionChangedEventArgs) Handles lbGroups.SelectionChanged
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 27")
        Try
            If lbGroups.SelectedItems.Count = 1 Then
                CurrentGroupName = lbGroups.SelectedValue.ToString
            End If

            PB.IsIndeterminate = True
            PB.Visibility = Windows.Visibility.Visible

            PopulateUserLB(CurrentGroupName)

            PB.IsIndeterminate = False
            PB.Visibility = Visibility.Hidden
        Catch ex As Exception
            If ddebug Then XLOG.WriteTraceLog("ERROR PageGroup Trace 27 " + ex.Message)
            SB.Text = "ERROR PageGroup Trace 27: " + ex.Message
        End Try


    End Sub

    ''' <summary>
    ''' Handles the Click event of the HyperlinkButton3 control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub HyperlinkButton3_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles HyperlinkButton3.Click
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 28")
        Dim BlankGroupName As String = ""
        Try
            Dim ObjListOfRows As Object = ProxySearch.PopulateGroupUserGrid(_SecureID, BlankGroupName)
            client_PopulateGroupUserGrid(ObjListOfRows)
        Catch ex As Exception
            If ddebug Then XLOG.WriteTraceLog("ERROR PageGroup Trace 28 " + ex.Message)
        End Try


    End Sub

    ''' <summary>
    ''' Handles the Click event of the HyperlinkButton1 control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub HyperlinkButton1_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles HyperlinkButton1.Click
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 29")
        Dim RC As Boolean = True
        Dim RetMsg As String = ""
        Dim SSID As Integer = 0
        Dim ListOfItems As String() = Nothing

        If _isAdmin Then
            Dim S As String = "Select [GroupName] FROM [UserGroup] order by GroupName"

            Dim strListOfItems As String = ""

            'AddHandler ProxySearch.getListOfStringsCompleted, AddressOf client_RepopulateGroupListbox
            'S = ENC2.AES256EncryptString(S)

            Dim BB As Boolean = ProxySearch.getListOfStrings(_SecureID, strListOfItems, S, RC, RetMsg)
            'Dim strListOfItems As String = ""
            ListOfItems = strListOfItems.Split("|")

            client_RepopulateGroupListbox(BB, ListOfItems, RetMsg)

            ListOfItems = Nothing
            GC.Collect()
        Else
            PopulateGroupListbox()
        End If
    End Sub

    ''' <summary>
    ''' Handles the Click event of the HyperlinkButton2 control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub HyperlinkButton2_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles HyperlinkButton2.Click
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 30")
        PopulateGroupListbox()
    End Sub

    ''' <summary>
    ''' Handles the 1 event of the HyperlinkButton4_Click control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub HyperlinkButton4_Click_1(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles HyperlinkButton4.Click
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 31")
        If lbGroups.SelectedItems.Count = 0 Then
            SB.Text = "One group must be selected!"
            Return
        End If
        CurrentGroupName = lbGroups.SelectedItem
        PopulateUserLB(CurrentGroupName)
    End Sub

    ''' <summary>
    ''' Allows an object to try to free resources and perform other cleanup operations before it is reclaimed by garbage collection.
    ''' </summary>
    Protected Overrides Sub Finalize()
        If ddebug Then XLOG.WriteTraceLog("PageGroup Trace 32 Final step")
        Try
        Finally
            MyBase.Finalize()      'define the destructor

            'RemoveHandler ProxySearch.iCountCompleted, AddressOf client_GroupIcount
            'RemoveHandler ProxySearch.getGroupOwnerGuidByGroupNameCompleted, AddressOf client_DeleteGroupMembersByOwnerGuid
            'RemoveHandler ProxySearch.DeleteGroupUsersCompleted, AddressOf client_DeleteGroupUsers
            'RemoveHandler ProxySearch.iCountCompleted, AddressOf client_UserExistsElsewhereCount
            'RemoveHandler ProxySearch.PopulateGroupUserGridCompleted, AddressOf client_PopulateGroupUserGrid
            'RemoveHandler ProxySearch.getListOfStringsCompleted, AddressOf client_RepopulateGroupListbox

            'RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
            'RemoveHandler ProxySearch.ExecuteSqlNewConn1Completed, AddressOf client_ExecuteSqlNewConn1
            'RemoveHandler ProxySearch.ExecuteSqlNewConn2Completed, AddressOf client_ExecuteSqlNewConn2
            'RemoveHandler ProxySearch.ExecuteSqlNewConn3Completed, AddressOf client_ExecuteSqlNewConn3
            'RemoveHandler ProxySearch.ExecuteSqlNewConn4Completed, AddressOf client_ExecuteSqlNewConn4
            'RemoveHandler ProxySearch.ExecuteSqlNewConn5Completed, AddressOf client_ExecuteSqlNewConn5
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub

End Class

''' <summary>
''' Class GroupUsers.
''' </summary>
Public Class GroupUsers
    ''' <summary>
    ''' Gets or sets the name of the user.
    ''' </summary>
    ''' <value>The name of the user.</value>
    Public Property UserName As String
    ''' <summary>
    ''' Gets or sets the user identifier.
    ''' </summary>
    ''' <value>The user identifier.</value>
    Public Property UserID As String
End Class
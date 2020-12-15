' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 07-16-2020
' ***********************************************************************
' <copyright file="PageLibraryAssignment.xaml.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************ip
Imports ECMEncryption
''' <summary>
''' Class PageLibraryAssignment.
''' Implements the <see cref="System.Windows.Window" />
''' Implements the <see cref="System.Windows.Markup.IComponentConnector" />
''' </summary>
''' <seealso cref="System.Windows.Window" />
''' <seealso cref="System.Windows.Markup.IComponentConnector" />
Public Class PageLibraryAssignment


    ''' <summary>
    ''' The log
    ''' </summary>
    Dim LOG As New clsLoggingExtended
    ''' <summary>
    ''' The email library
    ''' </summary>
    Dim EmailLib As New clsLIBEMAIL
    ''' <summary>
    ''' The content library
    ''' </summary>
    Dim ContentLib As New clsLIBDIRECTORY
    ''' <summary>
    ''' The utility
    ''' </summary>
    Dim UTIL As New clsUtility
    ''' <summary>
    ''' The common
    ''' </summary>
    Dim COMMON As New clsCommonFunctions
    'Dim EP As New clsEndPoint
    ''' <summary>
    ''' The en c2
    ''' </summary>
    Dim ENC2 As New ECMEncrypt()

    ''' <summary>
    ''' The curr library name
    ''' </summary>
    Dim CurrLibName As String = ""
    ''' <summary>
    ''' The curr assign library name
    ''' </summary>
    Dim CurrAssignLibName As String = ""
    ''' <summary>
    ''' The curr user unique identifier identifier
    ''' </summary>
    Dim CurrUserGuidID As String = ""

    'Dim GVAR As App = App.Current
    ''' <summary>
    ''' The user identifier
    ''' </summary>
    Dim UserID As String = ""
    'Dim ListOfLibs As System.Collections.ObjectModel.ObservableCollection(Of String)
    ''' <summary>
    ''' The list of libs
    ''' </summary>
    Dim ListOfLibs() As String = Nothing
    'Dim ListOfAssignedLibs As System.Collections.ObjectModel.ObservableCollection(Of String)
    ''' <summary>
    ''' The list of assigned libs
    ''' </summary>
    Dim ListOfAssignedLibs() As String = Nothing

    ''' <summary>
    ''' The folder name
    ''' </summary>
    Public FolderName As String = ""
    ''' <summary>
    ''' The folder identifier
    ''' </summary>
    Dim FolderID As String = ""
    ''' <summary>
    ''' The TGT library name
    ''' </summary>
    Dim tgtLibName As String = ""
    ''' <summary>
    ''' The type library
    ''' </summary>
    Dim TypeLibrary As String = ""
    ''' <summary>
    ''' The is email
    ''' </summary>
    Dim isEmail As Boolean = False

    ''' <summary>
    ''' The rc
    ''' </summary>
    Dim RC As Boolean = False
    ''' <summary>
    ''' The ret MSG
    ''' </summary>
    Dim RetMsg As String = ""

    'Dim proxy As New SVCSearch.Service1Client

    ''' <summary>
    ''' Initializes a new instance of the <see cref="PageLibraryAssignment"/> class.
    ''' </summary>
    Public Sub New()
        InitializeComponent()
        'EP.setSearchSvcEndPoint(proxy)

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        '** Set global variables
        UserID = _UserID
        CurrUserGuidID = _UserGuid
        COMMON.SaveClick(5500, UserID)
        PB.Value = 0

    End Sub

    ''' <summary>
    ''' Sets the type library.
    ''' </summary>
    ''' <param name="LibType">Type of the library.</param>
    Public Sub setTypeLibrary(ByVal LibType As String)
        TypeLibrary = LibType
        If TypeLibrary.ToUpper.Equals("EMAIL") Then
            txtTypeLibrary.Text = LibType
            isEmail = True
        Else
            txtTypeLibrary.Text = LibType
            isEmail = False
        End If
    End Sub
    ''' <summary>
    ''' Sets the name of the library.
    ''' </summary>
    ''' <param name="LibName">Name of the library.</param>
    Public Sub setLibraryName(ByVal LibName As String)
        tgtLibName = LibName
        lbLibrary.SelectedItem = tgtLibName
    End Sub
    ''' <summary>
    ''' Sets the folder identifier.
    ''' </summary>
    ''' <param name="MailFolderID">The mail folder identifier.</param>
    Public Sub setFolderID(ByVal MailFolderID As String)
        FolderID = MailFolderID$
    End Sub
    ''' <summary>
    ''' Sets the name of the folder.
    ''' </summary>
    ''' <param name="tFolderName">Name of the t folder.</param>
    Public Sub setFolderName(ByVal tFolderName As String)
        txtFolderName.Text = tFolderName$.Trim
        FolderName$ = tFolderName$.Trim
    End Sub

    ''' <summary>
    ''' Handles the Click event of the hlHome control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub hlHome_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hlHome.Click
        Dim NextPage As New MainPage()
        'NextPage.show
    End Sub

    ''' <summary>
    ''' Handles the Click event of the hyperlinkButton1 control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub hyperlinkButton1_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles hyperlinkButton1.Click
        Dim NextPage As New PageLibrary
        NextPage.Show()
    End Sub

    ''' <summary>
    ''' Populates the library combo.
    ''' </summary>
    Sub PopulateLibraryCombo()

        _UserID = _UserGuid

        Try
            Dim S As String = ""

            S = S + " SELECT [LibraryName]"
            S = S + " FROM  [Library]"
            S = S + " where userid = '" + _UserID + "'"
            S = S + " order by [LibraryName]"

            Dim strListOfItems As String = ""
            'AddHandler ProxySearch.getListOfStringsCompleted, AddressOf client_PopulateLibraryCombo
            'EP.setSearchSvcEndPoint(proxy)
            S = ENC2.AES256EncryptString(S)
            Dim BB As Boolean = ProxySearch.getListOfStrings(_SecureID, strListOfItems, S, RC, RetMsg)
            'Dim strListOfItems As String = ""
            ListOfLibs = strListOfItems.Split("|")

            client_PopulateLibraryCombo(BB, ListOfLibs)

        Catch ex As Exception
            SB.Text = "Failed to load Libraries."
        End Try

    End Sub
    ''' <summary>
    ''' Clients the populate library combo.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="ListOfLibs">The list of libs.</param>
    Sub client_PopulateLibraryCombo(RC As Boolean, ListOfLibs As String())
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If RC Then
            lbLibrary.Items.Clear()
            For Each S As String In ListOfLibs
                lbLibrary.Items.Add(S)
            Next
        Else
            gErrorCount += 1
            LOG.WriteTraceLog("ERROR client_PopulateLibraryCombo 100: ")
        End If
        'RemoveHandler ProxySearch.getListOfStringsCompleted, AddressOf client_PopulateLibraryCombo
    End Sub

    ''' <summary>
    ''' Populates the assigned library combo.
    ''' </summary>
    Public Sub PopulateAssignedLibraryCombo()
        Dim S As String = ""
        lbAssignedLibs.Items.Clear()

        If isEmail Then
            S = S + " SELECT  [LibraryName]"
            S = S + " FROM  [LibEmail]"
            S = S + " where [FolderName] = '" + FolderName + "'"
        Else
            S = S + " SELECT  [LibraryName]"
            S = S + " FROM  [LibDirectory]"
            S = S + " where [DirectoryName] = '" + FolderName + "'"
        End If


        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible

        Dim strListOfAssignedLibs As String = ""
        'AddHandler ProxySearch.getListOfStringsCompleted, AddressOf client_PopulateAssignedLibraryCombo
        'EP.setSearchSvcEndPoint(proxy)
        S = ENC2.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.getListOfStrings(_SecureID, strListOfAssignedLibs, S, RC, RetMsg)
        'Dim strListOfItems As String = ""
        ListOfAssignedLibs = strListOfAssignedLibs.Split("|")

        client_PopulateAssignedLibraryCombo(BB, ListOfAssignedLibs)

    End Sub
    ''' <summary>
    ''' Clients the populate assigned library combo.
    ''' </summary>
    ''' <param name="BB">if set to <c>true</c> [bb].</param>
    ''' <param name="ListOfLibs">The list of libs.</param>
    Sub client_PopulateAssignedLibraryCombo(BB As Boolean, ListOfLibs As String())
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If RC Then
            lbAssignedLibs.Items.Clear()
            For Each S As String In ListOfLibs
                lbAssignedLibs.Items.Add(S)
            Next
        Else
            gErrorCount += 1
            LOG.WriteTraceLog("ERROR client_PopulateLibraryCombo 100: ")
        End If
        'RemoveHandler ProxySearch.getListOfStringsCompleted, AddressOf client_PopulateAssignedLibraryCombo
    End Sub

    'Sub client_iCountLibrary(ByVal sender As Object, ByVal e As SVCSearch.iCountCompletedEventArgs)
    '    PB.IsIndeterminate = False
    '    PB.Visibility = Windows.Visibility.Collapsed

    '    If RC Then

    '    Else
    '        gErrorCount += 1
    '        LOG.WriteTraceLog("ERROR client_iCountLibrary 100: " + e.Error.Message)
    '    End If
    'End Sub

    ''' <summary>
    ''' Assigns the library.
    ''' </summary>
    Sub AssignLibrary()

        _UserID = _UserGuid
        Dim RecordsAdded As Integer = 0
        Dim LibToAdd As String = lbLibrary.SelectedItem
        FolderName = txtFolderName.Text.Trim

        If isEmail Then
            If FolderID.Length = 0 Then
                MessageBox.Show("FolderID MISSING for Mailbox " + FolderName + " , returning.")
                Return
            End If
            EmailLib.setEmailfolderentryid(FolderID)
            EmailLib.setLibraryname(LibToAdd)
            EmailLib.setUserid(_UserID)
            EmailLib.setFoldername(FolderName)
            '***************************************
            Dim b As Boolean = EmailLib.Insert
            '***************************************
            If b Then
                PopulateAssignedLibraryCombo()
                PB.IsIndeterminate = True
                PB.Visibility = Windows.Visibility.Visible
                'AddHandler ProxySearch.AddLibraryEmailCompleted, AddressOf client_AddLibraryEmail
                'EP.setSearchSvcEndPoint(proxy)
                ProxySearch.AddLibraryEmail(_SecureID, FolderName, CurrLibName, _UserID, RecordsAdded, RC, RetMsg)
                client_AddLibraryEmail(RecordsAdded)

                Dim tMsg As String = "User '" + _UserID + "' assigned EMAIL Folder '" + Me.txtFolderName.Text.Trim + "' to library '" + LibToAdd$ + "' on " + Now.ToString + "."
                ProxySearch.AddSysMsg(_SecureID, _UserID, tMsg, RC)

                LOG.WriteTraceLog(tMsg)
                SB.Text = "Added email folder to library..."
            Else
                MessageBox.Show("ERROR: DID NOT Add email folder to library...")
                Dim LID As String = _UserID
                Dim tMsg As String = "ERROR: 3302.1.y - User '" + LID + "' failed to assign EMAIL Folder '" + Me.txtFolderName.Text.Trim + "' to library '" + LibToAdd$ + "' on " + Now.ToString + "."
                ProxySearch.AddSysMsg(_SecureID, _UserID, tMsg, RC)
                LOG.WriteTraceLog(tMsg)
            End If
        Else
            ContentLib.setDirectoryname(Me.txtFolderName.Text.Trim)
            ContentLib.setLibraryname(LibToAdd)
            ContentLib.setUserid(_UserID)
            '*******************************************
            Dim b As Boolean = ContentLib.Insert
            '*******************************************

            PopulateAssignedLibraryCombo()

            PB.IsIndeterminate = True
            PB.Visibility = Windows.Visibility.Visible

            ProxySearch.AddLibraryDirectory(_SecureID, Me.txtFolderName.Text.Trim, LibToAdd$, _UserID, RecordsAdded, RC, RetMsg)

            Dim LID As String = _UserID
            Dim tMsg As String = "User '" + LID + "' assigned directory '" + Me.txtFolderName.Text.Trim + "' to library '" + LibToAdd$ + "' on " + Now.ToString + "."

            PB.IsIndeterminate = True
            PB.Visibility = Windows.Visibility.Visible

            ProxySearch.AddSysMsg(_SecureID, _UserID, tMsg, RC)

            LOG.WriteTraceLog(tMsg)
        End If

        SB.Text = "Library assignment complete."
    End Sub

    ''' <summary>
    ''' Clients the add library email.
    ''' </summary>
    ''' <param name="RecordsAdded">The records added.</param>
    Sub client_AddLibraryEmail(RecordsAdded As Integer)
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        Dim I As Integer = 0

        If RC Then
            I = RecordsAdded
        Else
            LOG.WriteTraceLog("ERROR client_AddLibraryEmail 3321: ")
        End If
        'RemoveHandler ProxySearch.AddLibraryEmailCompleted, AddressOf client_AddLibraryEmail
    End Sub

    ''' <summary>
    ''' Removes the library.
    ''' </summary>
    Sub RemoveLibrary()

        _UserID = _UserGuid

        Dim iSelected As Integer = lbAssignedLibs.SelectedItems.Count
        If iSelected = 0 Then
            Return
        End If

        Dim LibToRemove As String = lbAssignedLibs.Items(iSelected)
        LibToRemove = LibToRemove.Replace("'", "''")

        For I As Integer = 0 To iSelected - 1

            If isEmail Then
                FolderName = UTIL.RemoveSingleQuotes(FolderName)

                Dim Mysql As String = ""
                Mysql = "delete from LibEmail where LibraryName = '" + LibToRemove + "' and EmailFolderEntryID = '" + FolderID + "' "

                PB.IsIndeterminate = True
                PB.Visibility = Windows.Visibility.Visible

                'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
                'EP.setSearchSvcEndPoint(proxy)
                Mysql = ENC2.AES256EncryptString(Mysql)
                Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, Mysql, _UserID, ContractID)
                gLogSQL(BB, ENC2.AES256EncryptString(Mysql))

                PB.IsIndeterminate = True
                PB.Visibility = Windows.Visibility.Visible
                MessageBox.Show("Removed email folder from library... applying changes across the repository, this can take a long while.")
                ProxySearch.RemoveLibraryEmails(_SecureID, FolderName, LibToRemove, _UserID, RC, RetMsg)


                Dim LID As String = _UserID
                Dim tMsg As String = "Notice: 3302.2.y - User '" + LID + "' removed EMAIL Folder '" + Me.txtFolderName.Text.Trim + "' from library '" + LibToRemove + "' on " + Now.ToString + "."
                ProxySearch.AddSysMsg(_SecureID, _UserID, tMsg$, RC)

                PopulateAssignedLibraryCombo()
            Else
                Dim wc As String = ContentLib.wc_PK98(Me.txtFolderName.Text.Trim, LibToRemove, _UserID)
                Dim b As Boolean = ContentLib.Delete(wc)

                Dim DirName As String = txtFolderID.Text.Trim

                MessageBox.Show("Removed content folder from library... applying changes across the repository, this can take a long while.")

                PB.IsIndeterminate = True
                PB.Visibility = Windows.Visibility.Visible
                'AddHandler ProxySearch.RemoveLibraryDirectoriesCompleted, AddressOf client_RemoveLibraryDirectories
                'EP.setSearchSvcEndPoint(proxy)
                ProxySearch.RemoveLibraryDirectories(_SecureID, _UserID, DirName, LibToRemove, RC, RetMsg)
                client_RemoveLibraryDirectories(RC, RetMsg)


                PB.IsIndeterminate = True
                PB.Visibility = Windows.Visibility.Visible
                Dim LID As String = _UserID
                Dim tMsg As String = "Notice: 3303.2.y - User '" + LID + "' assigned Content Folder '" + Me.txtFolderName.Text.Trim + "' from library '" + LibToRemove + "' on " + Now.ToString + "."
                ProxySearch.AddSysMsg(_SecureID, _UserID, tMsg$, RC)
                LOG.WriteTraceLog(tMsg)

                PopulateAssignedLibraryCombo()

            End If
        Next


        PB.IsIndeterminate = True
        PB.Visibility = Windows.Visibility.Visible
        ProxySearch.cleanUpLibraryItems(_SecureID, _UserID)


    End Sub

    ''' <summary>
    ''' Clients the remove library directories.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    Sub client_RemoveLibraryDirectories(RC As Boolean, RetMsg As String)
        PB.IsIndeterminate = False
        PB.Visibility = Windows.Visibility.Collapsed

        If RC Then
            SB.Text = "Library removed."

        Else
            gErrorCount += 1
            LOG.WriteTraceLog("ERROR client_PopulateLibraryCombo 100: " + RetMsg)
            SB.Text = "Library NOT removed : " + RetMsg
        End If
        'RemoveHandler ProxySearch.RemoveLibraryDirectoriesCompleted, AddressOf client_RemoveLibraryDirectories
    End Sub

    ''' <summary>
    ''' Handles the SelectionChanged event of the lbLibrary control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub lbLibrary_SelectionChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.SelectionChangedEventArgs) Handles lbLibrary.SelectionChanged
        Dim I As Integer = lbLibrary.SelectedIndex
        CurrLibName = lbLibrary.SelectedItem(I)
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnAssign control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnAssign_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnAssign.Click
        AssignLibrary()
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnRemove control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnRemove_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnRemove.Click

        If lbAssignedLibs.SelectedItems.Count <> 1 Then
            MessageBox.Show("One and only one library can be selected for removal, please select just one.")
            Return
        End If

        RemoveLibrary()
    End Sub

    ''' <summary>
    ''' Handles the Unloaded event of the PageLibraryAssignment control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub PageLibraryAssignment_Unloaded(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs)
        'Application.Current.RootVisual.SetValue(Control.IsEnabledProperty, True)
    End Sub

    ''' <summary>
    ''' Handles the 1 event of the PageLibraryAssignment_Unloaded control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub PageLibraryAssignment_Unloaded_1(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles MyBase.Unloaded
        'Application.Current.RootVisual.SetValue(Control.IsEnabledProperty, True)
    End Sub


End Class

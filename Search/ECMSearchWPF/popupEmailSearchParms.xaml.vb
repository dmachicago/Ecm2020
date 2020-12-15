' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="popupEmailSearchParms.xaml.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************ht

''' <summary>
''' Class popupEmailSearchParms.
''' Implements the <see cref="System.Windows.Window" />
''' Implements the <see cref="System.Windows.Markup.IComponentConnector" />
''' </summary>
''' <seealso cref="System.Windows.Window" />
''' <seealso cref="System.Windows.Markup.IComponentConnector" />
Partial Public Class popupEmailSearchParms
    'Inherits ChildWindow

    'Dim proxy As New SVCSearch.Service1Client
    'Dim EP As New clsEndPoint

    'Dim GVAR As App = App.Current
    ''' <summary>
    ''' The common
    ''' </summary>
    Dim COMMON As New clsCommonFunctions
    ''' <summary>
    ''' The userid
    ''' </summary>
    Dim Userid As String

    ''' <summary>
    ''' The utility
    ''' </summary>
    Dim UTIL As New clsUtility
    ''' <summary>
    ''' The iso
    ''' </summary>
    Dim ISO As New clsIsolatedStorage
    ''' <summary>
    ''' The current combo
    ''' </summary>
    Dim CurrentCombo As String = ""
    ''' <summary>
    ''' The combo items
    ''' </summary>
    Dim ComboItems() As String = Nothing
    'Dim DICT As New Dictionary(Of String, String)
    ''' <summary>
    ''' The b my emails
    ''' </summary>
    Dim bMyEmails As Boolean = False
    ''' <summary>
    ''' The user unique identifier identifier
    ''' </summary>
    Dim UserGuidID As String = ""
    ''' <summary>
    ''' The text filter
    ''' </summary>
    Dim txtFilter As String = ""
    ''' <summary>
    ''' The form loaded
    ''' </summary>
    Dim formLoaded As Boolean = False
    ''' <summary>
    ''' The g secure identifier
    ''' </summary>
    Dim gSecureID As String = -1

    ''' <summary>
    ''' Initializes a new instance of the <see cref="popupEmailSearchParms"/> class.
    ''' </summary>
    ''' <param name="iSecureID">The i secure identifier.</param>
    Public Sub New(ByVal iSecureID As Integer)
        InitializeComponent()

        'EP.setSearchSvcEndPoint(proxy)

        Userid = _UserID
        COMMON.SaveClick(6930, Userid)

        gSecureID = iSecureID
        formLoaded = False

        'DICT = SearchDICT

        Dim sKey As String = ""
        Dim sVal As String = ""
        If dictMasterSearch IsNot Nothing Then
            For Each sKey In dictMasterSearch.Keys
                sVal = dictMasterSearch.Item(sKey)
                If sKey.Equals("CurrentGuid") Then
                    UserGuidID = dictMasterSearch.Item(sKey)
                ElseIf sKey.Equals("ckMyContent") Then
                    If sVal.Equals("True") Then
                        bMyEmails = True
                    Else
                        bMyEmails = False
                    End If
                ElseIf sKey.Equals("email.cbDateSelection") Then
                    If sVal IsNot Nothing Then
                        cbDateSelection.Text = sVal
                    End If
                ElseIf sKey.Equals("email.calStart") Then
                    If sVal IsNot Nothing Then
                        If sVal.Length > 0 Then
                            calStart.SelectedDate = CDate(sVal)
                        End If
                    End If
                ElseIf sKey.Equals("email.calEnd") Then
                    If sVal IsNot Nothing Then
                        If sVal.Length > 0 Then
                            calEnd.SelectedDate = CDate(sVal)
                        End If
                    End If
                ElseIf sKey.Equals("email.dtMailDateStart") Then
                    dtMailDateStart.Text = sVal
                ElseIf sKey.Equals("email.dtMailDateEnd") Then
                    dtMailDateEnd.Text = sVal
                ElseIf sKey.Equals("email.cbFromAddr") Then
                    If sVal IsNot Nothing Then
                        cbFromAddr.Text = sVal
                        txtcbFromAddr.Text = sVal
                    End If
                ElseIf sKey.Equals("email.cbToAddr") Then
                    If sVal IsNot Nothing Then
                        cbToAddr.Text = sVal
                        txtcbToAddr.Text = sVal
                    End If
                ElseIf sKey.Equals("email.cbFromName") Then
                    If sVal IsNot Nothing Then
                        cbFromName.Text = sVal
                        txtcbFromName.Text = sVal
                    End If
                ElseIf sKey.Equals("email.cbToName") Then
                    If sVal IsNot Nothing Then
                        cbToName.Text = sVal
                        txtcbToName.Text = sVal
                    End If
                ElseIf sKey.Equals("email.cbFolderFilter") Then
                    If sVal IsNot Nothing Then
                        cbFolderFilter.Text = sVal
                    End If
                ElseIf sKey.Equals("email.cbCCaddr") Then
                    If sVal IsNot Nothing Then
                        cbCCaddr.Text = sVal
                        txtcbCCaddr.Text = sVal
                    End If
                ElseIf sKey.Equals("email.txtSubject") Then
                    txtSubject.Text = sVal
                ElseIf sKey.Equals("email.txtCCPhrase") Then
                    txtCCPhrase.Text = sVal
                End If
            Next
        End If
        formLoaded = True
    End Sub

    ''' <summary>
    ''' Handles the Click event of the OKButton control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub OKButton_Click(ByVal sender As Object, ByVal e As RoutedEventArgs) Handles OKButton.Click

        'ISO.SaveDetailSearchParms("EMAIL", dictMasterSearch)

        Me.DialogResult = True
        Me.Close()

    End Sub

    ''' <summary>
    ''' Handles the Click event of the CancelButton control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub CancelButton_Click(ByVal sender As Object, ByVal e As RoutedEventArgs) Handles CancelButton.Click
        'ISO.DeleteDetailSearchParms("EMAIL")
        'For Each sKey As String In dictMasterSearch.Keys
        '    If InStr(sKey, "email.", CompareMethod.Text) > 0 Then
        '        dictMasterSearch.Item(sKey) = ""
        '    End If
        'Next
        Me.DialogResult = False
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnReset control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnReset_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnReset.Click
        cbDateSelection.SelectedItem = Nothing
        cbDateSelection.SelectedItem = "OFF"
        dtMailDateStart.Text = ""
        dtMailDateEnd.Text = ""
        calStart.SelectedDate = Nothing
        calEnd.SelectedDate = Nothing

        txtSubject.Text = ""
        txtCCPhrase.Text = ""
        cbFromAddr.SelectedItem = Nothing
        cbToAddr.SelectedItem = Nothing
        cbFromName.SelectedItem = Nothing
        cbToName.SelectedItem = Nothing
        cbFolderFilter.SelectedItem = Nothing
        cbCCaddr.SelectedItem = Nothing

        cbFromAddr.Text = ""
        cbToAddr.Text = ""
        cbFromName.Text = ""
        cbToName.Text = ""
        cbFolderFilter.Text = ""
        cbCCaddr.Text = ""

    End Sub

    ''' <summary>
    ''' Updates the search dictionary.
    ''' </summary>
    ''' <param name="tKey">The t key.</param>
    ''' <param name="tValue">The t value.</param>
    Sub UpdateSearchDict(ByVal tKey As String, ByVal tValue As String)
        If Not formLoaded Then
            Return
        End If
        If dictMasterSearch.ContainsKey(tKey) Then
            dictMasterSearch.Item(tKey) = tValue
            SB.Text = tKey + " updated"
        Else
            dictMasterSearch.Add(tKey, tValue)
            SB.Text = tKey + " added"
        End If
    End Sub



    ''' <summary>
    ''' Handles the SelectedDatesChanged event of the calStart control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub calStart_SelectedDatesChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.SelectionChangedEventArgs) Handles calStart.SelectedDatesChanged
        If Not formLoaded Then
            Return
        End If
        If calStart.SelectedDate IsNot Nothing Then
            UpdateSearchDict("email.calStart", calStart.SelectedDate.ToString)
            dtMailDateStart.Text = calStart.SelectedDate.ToString
        Else
            UpdateSearchDict("email.calStart", "")
            dtMailDateStart.Text = ""
        End If

    End Sub

    ''' <summary>
    ''' Handles the SelectedDatesChanged event of the calEnd control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub calEnd_SelectedDatesChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.SelectionChangedEventArgs) Handles calEnd.SelectedDatesChanged
        If Not formLoaded Then
            Return
        End If
        If calEnd.SelectedDate IsNot Nothing Then
            UpdateSearchDict("email.calEnd", calEnd.SelectedDate.ToString)
            dtMailDateEnd.Text = calEnd.SelectedDate.ToString
        Else
            UpdateSearchDict("email.calEnd", "")
            dtMailDateEnd.Text = ""
        End If

    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the txtEnd control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub txtEnd_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles dtMailDateEnd.TextChanged
        If Not formLoaded Then
            Return
        End If
        UpdateSearchDict("email.dtMailDateEnd", dtMailDateEnd.Text.Trim)
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the txtStart control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub txtStart_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles dtMailDateStart.TextChanged
        If Not formLoaded Then
            Return
        End If
        UpdateSearchDict("email.dtMailDateStart", dtMailDateStart.Text.Trim)
    End Sub

    ''' <summary>
    ''' Handles the SelectionChanged event of the cbFromName control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub cbFromName_SelectionChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.SelectionChangedEventArgs)
        If Not formLoaded Then
            Return
        End If
        UpdateSearchDict("email.cbFromName", cbFromName.SelectedItem.ToString)
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the txtSubject control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub txtSubject_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtSubject.TextChanged
        If Not formLoaded Then
            Return
        End If
        UpdateSearchDict("email.txtSubject", txtSubject.Text.Trim)
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the txtCCPhrase control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub txtCCPhrase_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtCCPhrase.TextChanged
        If Not formLoaded Then
            Return
        End If
        UpdateSearchDict("email.txtCCPhrase", txtCCPhrase.Text.Trim)
    End Sub

    ''' <summary>
    ''' Pops the cb from addr.
    ''' </summary>
    Sub Pop_cbFromAddr()

        txtFilter = txtcbFromAddr.Text.Trim
        Dim Filter As String = UTIL.RemoveSingleQuotes(txtcbFromAddr.Text.Trim)

        Dim S As String = ""
        If bMyEmails Then
            If txtFilter.Trim.Length = 0 Then
                S = "Select distinct [SenderEmailAddress] FROM [Email] where UserID = '" + UserGuidID + "' and SenderEmailAddress is not null order by [SenderEmailAddress]"
            Else
                S = "Select distinct [SenderEmailAddress] FROM [Email] where UserID = '" + UserGuidID + "' and SenderEmailAddress like '" + UTIL.RemoveSingleQuotes(Filter) + "' order by [SenderEmailAddress]"
            End If
        Else
            If txtFilter.Trim.Length = 0 Then
                S = "Select distinct [SenderEmailAddress] FROM [Email] where SenderEmailAddress is not null order by [SenderEmailAddress]"
            Else
                S = "Select distinct [SenderEmailAddress] FROM [Email] where SenderEmailAddress like '" + UTIL.RemoveSingleQuotes(Filter) + "' order by [SenderEmailAddress]"
            End If
        End If

        PopulateComboBox("cbFromAddr", "SenderEmailAddress", S)

    End Sub

    ''' <summary>
    ''' Pops the cb to addr.
    ''' </summary>
    Sub Pop_cbToAddr()

        txtFilter = txtcbToAddr.Text.Trim
        Dim Filter As String = UTIL.RemoveSingleQuotes(txtcbToAddr.Text.Trim)
        Dim Recpt$ = ""

        Recpt = UTIL.RemoveSingleQuotes(Filter)

        Dim S As String = ""
        If bMyEmails Then
            If Filter.Trim.Length = 0 Then
                S = "Select     distinct Recipients.Recipient"
                S = S + " FROM         Recipients INNER JOIN"
                S = S + " Email ON Recipients.EmailGuid = Email.EmailGuid"
                S = S + " where Email.UserID = '" + UserGuidID + "'"
                S = S + " and Recipients.Recipient  IS NOT NULL "
                S = S + " order by Recipients.Recipient"
            Else
                S = "Select     distinct Recipients.Recipient"
                S = S + " FROM         Recipients INNER JOIN"
                S = S + " Email ON Recipients.EmailGuid = Email.EmailGuid"
                S = S + " where Email.UserID = '" + UserGuidID + "'"
                S = S + " and Recipients.Recipient like '" + Recpt + "'"
                S = S + " order by Recipients.Recipient"
            End If

        Else
            If Filter.Trim.Length = 0 Then
                S = "Select     distinct Recipients.Recipient"
                S = S + " FROM         Recipients INNER JOIN"
                S = S + " Email ON Recipients.EmailGuid = Email.EmailGuid"
                S = S + " where Recipients.Recipient IS NOT NULL "
                S = S + " order by Recipients.Recipient"
            Else
                S = "Select     distinct Recipients.Recipient"
                S = S + " FROM         Recipients INNER JOIN"
                S = S + " Email ON Recipients.EmailGuid = Email.EmailGuid"
                S = S + " where Recipients.Recipient like '" + Recpt + "'"
                S = S + " order by Recipients.Recipient"
            End If

        End If
        PopulateComboBox("cbToAddr", "Recipient", S)
    End Sub
    ''' <summary>
    ''' Pops the name of the cb from.
    ''' </summary>
    Sub Pop_cbFromName()

        txtFilter = txtcbFromName.Text.Trim
        Dim Filter As String = UTIL.RemoveSingleQuotes(txtcbFromName.Text.Trim)

        Dim S As String = ""
        If bMyEmails Then
            If Filter.Length = 0 Then
                S = "Select distinct [SenderName] FROM [Email] where SenderName IS NOT NULL and UserID = '" + UserGuidID + "' order by [SenderName]"
            Else
                S = "Select distinct [SenderName] FROM [Email] where SenderName like '" + Filter + "' and UserID = '" + UserGuidID + "' order by [SenderName]"
            End If
        Else
            If Filter.Length = 0 Then
                S = "Select distinct [SenderName] FROM [Email] where SenderName IS NOT NULL order by [SenderName]"
            Else
                S = "Select distinct [SenderName] FROM [Email] where SenderName like '" + Filter + "' order by [SenderName]"
            End If

        End If
        PopulateComboBox("cbFromName", "SenderName", S)

    End Sub
    ''' <summary>
    ''' Pops the name of the cb to.
    ''' </summary>
    Sub Pop_cbToName()

        txtFilter = txtcbToName.Text.Trim
        Dim Filter As String = UTIL.RemoveSingleQuotes(txtcbToName.Text.Trim)

        Dim ReceivedByName As String = Filter
        ReceivedByName = UTIL.RemoveSingleQuotes(Filter)

        Dim S As String = ""
        If bMyEmails Then
            If Filter.Length = 0 Then
                S = "Select distinct [ReceivedByName] FROM [Email] where ReceivedByName IS NOT NULL AND UserID = '" + UserGuidID + "' order by [ReceivedByName]"
            Else
                S = "Select distinct [ReceivedByName] FROM [Email] where ReceivedByName like '" + ReceivedByName + "' AND UserID = '" + UserGuidID + "' order by [ReceivedByName]"
            End If
        Else
            If Filter.Length = 0 Then
                S = "Select distinct [ReceivedByName] FROM [Email] where ReceivedByName IS NOT NULL order by [ReceivedByName]"
            Else
                S = "Select distinct [ReceivedByName] FROM [Email] where ReceivedByName like '" + ReceivedByName + "' order by [ReceivedByName]"
            End If
        End If
        PopulateComboBox("cbToName", "ReceivedByName", S)

    End Sub
    ''' <summary>
    ''' Pops the cb folder filter.
    ''' </summary>
    Sub Pop_cbFolderFilter()

        txtFilter = txtcbFolderFilter.Text.Trim
        Dim Filter As String = UTIL.RemoveSingleQuotes(txtcbFolderFilter.Text.Trim)

        Dim FolderName As String = Filter

        Dim S As String = ""
        If bMyEmails Then
            If Filter.Trim.Length = 0 Then
                S = "Select distinct OriginalFolder FROM [Email] where OriginalFolder IS NOT NULL and UserID = '" + UserGuidID + "' order by OriginalFolder"
            Else
                S = "Select distinct OriginalFolder FROM [Email] where OriginalFolder like '" + FolderName + "' and UserID = '" + UserGuidID + "' order by OriginalFolder"
            End If

        Else
            If Filter.Trim.Length = 0 Then
                S = "Select distinct OriginalFolder FROM [Email] where OriginalFolder IS NOT NULL order by OriginalFolder"
            Else
                S = "Select distinct OriginalFolder FROM [Email] where OriginalFolder like '" + FolderName + "' order by OriginalFolder"
            End If

        End If
        PopulateComboBox("cbFolderFilter", "OriginalFolder", S)

    End Sub
    ''' <summary>
    ''' Pops the cb c caddr.
    ''' </summary>
    Sub Pop_cbCCaddr()

        txtFilter = txtcbCCaddr.Text.Trim
        Dim Filter As String = UTIL.RemoveSingleQuotes(txtcbCCaddr.Text.Trim)

        Dim ReceivedByName As String = Filter
        Dim S As String = ""
        If bMyEmails Then
            If Filter.Length = 0 Then
                S = ""
                S = S + " SELECT     distinct Recipients.Recipient"
                S = S + " FROM         Recipients INNER JOIN"
                S = S + "              Email ON Recipients.EmailGuid = Email.EmailGuid"
                S = S + " where Email.UserID = '" + UserGuidID + "'"
                S = S + " and TypeRecp = 'CC'"
                S = S + " and  Recipients.Recipient IS NOT NULL "
                S = S + " order by Recipients.Recipient"
            Else
                S = ""
                S = S + " SELECT     distinct Recipients.Recipient"
                S = S + " FROM         Recipients INNER JOIN"
                S = S + "              Email ON Recipients.EmailGuid = Email.EmailGuid"
                S = S + " where Email.UserID = '" + UserGuidID + "'"
                S = S + " and TypeRecp = 'CC'"
                S = S + " and  Recipients.Recipient like '" + ReceivedByName + "' "
                S = S + " order by Recipients.Recipient"
            End If

        Else
            If Filter.Length = 0 Then
                S = ""
                S = S + " SELECT     distinct Recipients.Recipient"
                S = S + " FROM         Recipients INNER JOIN"
                S = S + "              Email ON Recipients.EmailGuid = Email.EmailGuid"
                S = S + " where TypeRecp = 'CC'"
                S = S + " and  Recipients.Recipient IS NOT NULL "
                S = S + " order by Recipients.Recipient"
            Else
                S = ""
                S = S + " SELECT     distinct Recipients.Recipient"
                S = S + " FROM         Recipients INNER JOIN"
                S = S + "              Email ON Recipients.EmailGuid = Email.EmailGuid"
                S = S + " where TypeRecp = 'CC'"
                S = S + " and  Recipients.Recipient like '" + ReceivedByName + "' "
                S = S + " order by Recipients.Recipient"
            End If
        End If
        PopulateComboBox("cbCCaddr", "Recipient", S)

    End Sub

    ''' <summary>
    ''' Populates the ComboBox.
    ''' </summary>
    ''' <param name="ComboName">Name of the combo.</param>
    ''' <param name="TblColName">Name of the table col.</param>
    ''' <param name="MySql">My SQL.</param>
    Sub PopulateComboBox(ByVal ComboName As String, ByVal TblColName As String, ByVal MySql As String)

        PB.Visibility = Windows.Visibility.Visible
        PB.IsIndeterminate = True
        CurrentCombo = ComboName

        'AddHandler ProxySearch.PopulateComboBoxCompleted, AddressOf client_PopulateComboBox
        'EP.setSearchSvcEndPoint(proxy)
        ProxySearch.PopulateComboBox(gSecureID, ComboItems, TblColName, MySql)
        client_PopulateComboBox(ComboItems)

    End Sub

    ''' <summary>
    ''' Clients the populate ComboBox.
    ''' </summary>
    ''' <param name="CB">The cb.</param>
    Sub client_PopulateComboBox(CB As String())

        If CB.Count > 0 Then
            If CurrentCombo.Equals("cbCCaddr") Then
                cbCCaddr.ItemsSource = CB
            End If
            If CurrentCombo.Equals("cbFolderFilter") Then
                cbFolderFilter.ItemsSource = CB
            End If
            If CurrentCombo.Equals("cbFromAddr") Then
                cbFromAddr.ItemsSource = CB
            End If
            If CurrentCombo.Equals("cbFromName") Then
                cbFromName.ItemsSource = CB
            End If
            If CurrentCombo.Equals("cbToAddr") Then
                cbToAddr.ItemsSource = CB
            End If
            If CurrentCombo.Equals("cbToName") Then
                cbToName.ItemsSource = CB
            End If
            SB.Text = "Items Found: " + CB.Count.ToString
        Else
            MessageBox.Show("ERROR loading combo: 221B ")
        End If

        OKButton.Visibility = Windows.Visibility.Visible
        CancelButton.Visibility = Windows.Visibility.Visible

        btnSearchFrom.Visibility = Windows.Visibility.Visible
        Button1.Visibility = Windows.Visibility.Visible
        Button3.Visibility = Windows.Visibility.Visible
        Button4.Visibility = Windows.Visibility.Visible
        Button5.Visibility = Windows.Visibility.Visible
        Button6.Visibility = Windows.Visibility.Visible

        PB.Visibility = Windows.Visibility.Collapsed
        PB.IsIndeterminate = False

        'RemoveHandler ProxySearch.PopulateComboBoxCompleted, AddressOf client_PopulateComboBox

    End Sub


    ''' <summary>
    ''' Handles the LostFocus event of the cbFromAddr control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub cbFromAddr_LostFocus(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs)
        UpdateSearchDict("email.cbFromAddr", cbFromAddr.SelectedItem.ToString)
    End Sub

    ''' <summary>
    ''' Handles the 1 event of the cbFromName_SelectionChanged control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub cbFromName_SelectionChanged_1(sender As Object, e As SelectionChangedEventArgs) Handles cbFromName.SelectionChanged
        If Not formLoaded Then
            Return
        End If
        txtcbFromName.Text = cbFromName.SelectedItem.ToString
        UpdateSearchDict("email.cbFromName", cbFromName.SelectedItem.ToString)
    End Sub


    ''' <summary>
    ''' Handles the KeyDown event of the cbToAddr control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Input.KeyEventArgs"/> instance containing the event data.</param>
    Private Sub cbToAddr_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Input.KeyEventArgs) Handles cbToAddr.KeyDown
        If cbToAddr.SelectedItem IsNot Nothing Then
            UpdateSearchDict("email.cbToAddr", cbToAddr.SelectedItem.ToString)
        End If
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnSearchFrom control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnSearchFrom_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnSearchFrom.Click

        If txtcbFromAddr.Text.Trim.Length = 0 Then
            MessageBox.Show("You must supply a name, returning.")
            Return
        End If

        OKButton.Visibility = Windows.Visibility.Collapsed
        CancelButton.Visibility = Windows.Visibility.Collapsed

        btnSearchFrom.Visibility = Windows.Visibility.Collapsed
        Button1.Visibility = Windows.Visibility.Collapsed
        Button3.Visibility = Windows.Visibility.Collapsed
        Button4.Visibility = Windows.Visibility.Collapsed
        Button5.Visibility = Windows.Visibility.Collapsed
        Button6.Visibility = Windows.Visibility.Collapsed

        Pop_cbFromAddr()

    End Sub

    ''' <summary>
    ''' Handles the Click event of the Button1 control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles Button1.Click
        If txtcbToAddr.Text.Trim.Length = 0 Then
            MessageBox.Show("You must supply a name, returning.")
            Return
        End If

        btnSearchFrom.Visibility = Windows.Visibility.Collapsed
        Button1.Visibility = Windows.Visibility.Collapsed
        Button3.Visibility = Windows.Visibility.Collapsed
        Button4.Visibility = Windows.Visibility.Collapsed
        Button5.Visibility = Windows.Visibility.Collapsed
        Button6.Visibility = Windows.Visibility.Collapsed

        OKButton.Visibility = Windows.Visibility.Collapsed
        CancelButton.Visibility = Windows.Visibility.Collapsed

        Pop_cbToAddr()
    End Sub

    ''' <summary>
    ''' Handles the Click event of the Button3 control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles Button3.Click
        If txtcbFromName.Text.Trim.Length = 0 Then
            MessageBox.Show("You must supply a name, returning.")
            Return
        End If

        btnSearchFrom.Visibility = Windows.Visibility.Collapsed
        Button1.Visibility = Windows.Visibility.Collapsed
        Button3.Visibility = Windows.Visibility.Collapsed
        Button4.Visibility = Windows.Visibility.Collapsed
        Button5.Visibility = Windows.Visibility.Collapsed
        Button6.Visibility = Windows.Visibility.Collapsed

        OKButton.Visibility = Windows.Visibility.Collapsed
        CancelButton.Visibility = Windows.Visibility.Collapsed

        Pop_cbFromName()
    End Sub

    ''' <summary>
    ''' Handles the Click event of the Button4 control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub Button4_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles Button4.Click
        If txtcbToName.Text.Trim.Length = 0 Then
            MessageBox.Show("You must supply a name, returning.")
            Return
        End If

        btnSearchFrom.Visibility = Windows.Visibility.Collapsed
        Button1.Visibility = Windows.Visibility.Collapsed
        Button3.Visibility = Windows.Visibility.Collapsed
        Button4.Visibility = Windows.Visibility.Collapsed
        Button5.Visibility = Windows.Visibility.Collapsed
        Button6.Visibility = Windows.Visibility.Collapsed

        OKButton.Visibility = Windows.Visibility.Collapsed
        CancelButton.Visibility = Windows.Visibility.Collapsed
        Pop_cbToName()
    End Sub

    ''' <summary>
    ''' Handles the Click event of the Button5 control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub Button5_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles Button5.Click
        If txtcbFolderFilter.Text.Trim.Length = 0 Then
            MessageBox.Show("You must supply a name, returning.")
            Return
        End If

        btnSearchFrom.Visibility = Windows.Visibility.Collapsed
        Button1.Visibility = Windows.Visibility.Collapsed
        Button3.Visibility = Windows.Visibility.Collapsed
        Button4.Visibility = Windows.Visibility.Collapsed
        Button5.Visibility = Windows.Visibility.Collapsed
        Button6.Visibility = Windows.Visibility.Collapsed

        OKButton.Visibility = Windows.Visibility.Collapsed
        CancelButton.Visibility = Windows.Visibility.Collapsed
        Pop_cbFolderFilter()
    End Sub

    ''' <summary>
    ''' Handles the Click event of the Button6 control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub Button6_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles Button6.Click
        If txtcbCCaddr.Text.Trim.Length = 0 Then
            MessageBox.Show("You must supply a name, returning.")
            Return
        End If

        btnSearchFrom.Visibility = Windows.Visibility.Collapsed
        Button1.Visibility = Windows.Visibility.Collapsed
        Button3.Visibility = Windows.Visibility.Collapsed
        Button4.Visibility = Windows.Visibility.Collapsed
        Button5.Visibility = Windows.Visibility.Collapsed
        Button6.Visibility = Windows.Visibility.Collapsed

        OKButton.Visibility = Windows.Visibility.Collapsed
        CancelButton.Visibility = Windows.Visibility.Collapsed
        Pop_cbCCaddr()
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the txtcbFromAddr control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub txtcbFromAddr_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtcbFromAddr.TextChanged
        UpdateSearchDict("email.cbFromAddr", txtcbFromAddr.Text)
        If txtcbFromAddr.Text.Length > 0 Then
            cbFromAddr.Visibility = Windows.Visibility.Visible
            btnSearchFrom.Visibility = Windows.Visibility.Visible
        Else
            cbFromAddr.Visibility = Windows.Visibility.Collapsed
            btnSearchFrom.Visibility = Windows.Visibility.Collapsed
        End If
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the txtcbToAddr control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub txtcbToAddr_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtcbToAddr.TextChanged
        UpdateSearchDict("email.cbToAddr", txtcbToAddr.Text)
        If txtcbToAddr.Text.Length > 0 Then
            cbToAddr.Visibility = Windows.Visibility.Visible
            Button1.Visibility = Windows.Visibility.Visible
        Else
            cbToAddr.Visibility = Windows.Visibility.Collapsed
            Button1.Visibility = Windows.Visibility.Collapsed
        End If
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the txtcbFromName control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub txtcbFromName_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtcbFromName.TextChanged
        UpdateSearchDict("email.cbFromName", txtcbFromName.Text)
        If txtcbFromName.Text.Length > 0 Then
            cbFromName.Visibility = Windows.Visibility.Visible
            Button3.Visibility = Windows.Visibility.Visible
        Else
            cbFromName.Visibility = Windows.Visibility.Collapsed
            Button3.Visibility = Windows.Visibility.Collapsed
        End If
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the txtcbToName control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub txtcbToName_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtcbToName.TextChanged
        UpdateSearchDict("email.cbToName", txtcbToName.Text)
        If txtcbToName.Text.Length > 0 Then
            cbToName.Visibility = Windows.Visibility.Visible
            Button4.Visibility = Windows.Visibility.Visible
        Else
            cbToName.Visibility = Windows.Visibility.Collapsed
            Button4.Visibility = Windows.Visibility.Collapsed
        End If
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the txtcbFolderFilter control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub txtcbFolderFilter_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtcbFolderFilter.TextChanged
        UpdateSearchDict("email.cbFolderFilter", txtcbFolderFilter.Text)
        If txtcbFolderFilter.Text.Length > 0 Then
            cbFolderFilter.Visibility = Windows.Visibility.Visible
            Button5.Visibility = Windows.Visibility.Visible
        Else
            cbFolderFilter.Visibility = Windows.Visibility.Collapsed
            Button5.Visibility = Windows.Visibility.Collapsed
        End If
    End Sub

    ''' <summary>
    ''' Handles the TextChanged event of the txtcbCCaddr control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.TextChangedEventArgs"/> instance containing the event data.</param>
    Private Sub txtcbCCaddr_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtcbCCaddr.TextChanged
        UpdateSearchDict("email.cbCCaddr", txtcbCCaddr.Text)
        If txtcbCCaddr.Text.Length > 0 Then
            cbCCaddr.Visibility = Windows.Visibility.Visible
            Button6.Visibility = Windows.Visibility.Visible
        Else
            cbCCaddr.Visibility = Windows.Visibility.Collapsed
            Button6.Visibility = Windows.Visibility.Collapsed
        End If
    End Sub

    'Private Sub cbToName_SelectedItemChanged(ByVal sender As System.Object, ByVal e As C1.Silverlight.PropertyChangedEventArgs(Of System.Object)) Handles cbToName.SelectedItemChanged
    '    txtcbToName.Text = cbToName.Text
    'End Sub

    'Private Sub cbFolderFilter_SelectedItemChanged(ByVal sender As System.Object, ByVal e As C1.Silverlight.PropertyChangedEventArgs(Of System.Object)) Handles cbFolderFilter.SelectedItemChanged
    '    txtcbFolderFilter.Text = cbFolderFilter.Text
    'End Sub

    'Private Sub cbCCaddr_SelectedItemChanged(ByVal sender As System.Object, ByVal e As C1.Silverlight.PropertyChangedEventArgs(Of System.Object)) Handles cbCCaddr.SelectedItemChanged
    '    txtcbCCaddr.Text = cbCCaddr.Text
    'End Sub

    'Private Sub cbDateSelection_SelectedItemChanged(ByVal sender As System.Object, ByVal e As C1.Silverlight.PropertyChangedEventArgs(Of System.Object)) Handles cbDateSelection.SelectedItemChanged
    '   DateChanged
    'End Sub

    ''' <summary>
    ''' Dates the changed.
    ''' </summary>
    Sub DateChanged()
        Dim sDateFilter As String = cbDateSelection.Text
        If sDateFilter IsNot Nothing Then
            UpdateSearchDict("email.cbDateSelection", sDateFilter)
        Else
            UpdateSearchDict("email.cbDateSelection", "")
        End If
        If sDateFilter.Equals("OFF") Then
            'FadeBoth.Begin()
            calStart.Opacity = 0.1
            calEnd.Opacity = 0.1
            dtMailDateStart.Opacity = 0.1
            dtMailDateEnd.Opacity = 0.1
        End If
        If sDateFilter.Equals("Between") Then
            'ShowBoth.Begin()
            calStart.Opacity = 1
            calEnd.Opacity = 1
            dtMailDateStart.Opacity = 1
            dtMailDateEnd.Opacity = 1
        End If
        If sDateFilter.Equals("Not Between") Then
            'ShowBoth.Begin()
            calStart.Opacity = 1
            calEnd.Opacity = 1
            dtMailDateStart.Opacity = 1
            dtMailDateEnd.Opacity = 1
        End If
        If sDateFilter.Equals("Before") Then
            'ShowLeft.Begin()
            'FadeRight.Begin()
            calStart.Opacity = 1
            calEnd.Opacity = 0.1
            dtMailDateStart.Opacity = 1
            dtMailDateEnd.Opacity = 0.1
        End If
        If sDateFilter.Equals("After") Then
            'ShowRight.Begin()
            'FadeLeft.Begin()
            calStart.Opacity = 0.1
            calEnd.Opacity = 1
            dtMailDateStart.Opacity = 0.1
            dtMailDateEnd.Opacity = 1
        End If
        If sDateFilter.Equals("On") Then
            calStart.Opacity = 1
            calEnd.Opacity = 0.1
            dtMailDateStart.Opacity = 1
            dtMailDateEnd.Opacity = 0.1
        End If
        SB.Text = "Date Filter changed to : " + sDateFilter
    End Sub

    ''' <summary>
    ''' Handles the SelectedItemChanged event of the cbToAddr control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub cbToAddr_SelectedItemChanged(ByVal sender As System.Object, ByVal e As SelectionChangedEventArgs) Handles cbToAddr.SelectionChanged
        txtcbToAddr.Text = cbToAddr.Text
    End Sub

    ''' <summary>
    ''' Handles the SelectedIndexChanged event of the cbDateSelection control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub cbDateSelection_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As SelectionChangedEventArgs) Handles cbDateSelection.SelectionChanged
        DateChanged()
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnAutoFill control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnAutoFill_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnAutoFill.Click

        cbDateSelection.SelectedItem = "Between"
        cbDateSelection.Text = "Between"
        calStart.SelectedDate = #7/26/2000#
        calEnd.SelectedDate = #8/20/2011#
        txtcbFromAddr.Text = "txtcbFromAddr <from email>"
        txtcbToAddr.Text = "txtcbToAddr <to email>"
        txtSubject.Text = "txtSubject <Subject>"
        txtCCPhrase.Text = "txtCCPhrase <CC/BCC phrase>"
        txtcbFromName.Text = "txtcbFromName <From Name>"
        txtcbToName.Text = "txtcbToName <email acct>"
        txtcbFolderFilter.Text = "txtcbFolderFilter <dir>"
        txtcbCCaddr.Text = "txtcbCCaddr <CC/BCC>"

    End Sub

    ''' <summary>
    ''' Handles the 1 event of the cbFromAddr_SelectionChanged control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub cbFromAddr_SelectionChanged_1(sender As Object, e As SelectionChangedEventArgs) Handles cbFromAddr.SelectionChanged
        txtcbFromAddr.Text = cbFromAddr.Text
        txtcbFromName.Text = cbFromName.SelectedItem.ToString
        If Not formLoaded Then
            Return
        End If
        If cbFromAddr.SelectedItem IsNot Nothing Then
            UpdateSearchDict("email.cbFromAddr", cbFromAddr.SelectedItem.ToString)
        Else
            UpdateSearchDict("email.cbFromAddr", "")
        End If
    End Sub

    ''' <summary>
    ''' Handles the 1 event of the cbToAddr_SelectionChanged control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub cbToAddr_SelectionChanged_1(sender As Object, e As SelectionChangedEventArgs) Handles cbToAddr.SelectionChanged
        If Not formLoaded Then
            Return
        End If
        If cbToAddr.SelectedItem IsNot Nothing Then
            UpdateSearchDict("email.cbToAddr", cbToAddr.SelectedItem.ToString)
        Else
            UpdateSearchDict("email.cbToAddr", "")
        End If
    End Sub

    ''' <summary>
    ''' Handles the 1 event of the cbCCaddr_SelectionChanged control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub cbCCaddr_SelectionChanged_1(sender As Object, e As SelectionChangedEventArgs) Handles cbCCaddr.SelectionChanged
        If Not formLoaded Then
            Return
        End If
        UpdateSearchDict("email.cbCCaddr", cbCCaddr.SelectedItem.ToString)
    End Sub

    ''' <summary>
    ''' Handles the 1 event of the cbFolderFilter_SelectionChanged control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub cbFolderFilter_SelectionChanged_1(sender As Object, e As SelectionChangedEventArgs) Handles cbFolderFilter.SelectionChanged
        If Not formLoaded Then
            Return
        End If
        If cbFolderFilter.SelectedItem IsNot Nothing Then
            UpdateSearchDict("email.cbFolderFilter", cbFolderFilter.SelectedItem.ToString)
        Else
            UpdateSearchDict("email.cbFolderFilter", "")
        End If

    End Sub

    ''' <summary>
    ''' Handles the 1 event of the cbToName_SelectionChanged control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub cbToName_SelectionChanged_1(sender As Object, e As SelectionChangedEventArgs) Handles cbToName.SelectionChanged
        If Not formLoaded Then
            Return
        End If
        If cbToName.SelectedItem IsNot Nothing Then
            UpdateSearchDict("email.cbToName", cbToName.SelectedItem.ToString)
        Else
            UpdateSearchDict("email.cbToName", "")
        End If

    End Sub

    ''' <summary>
    ''' Handles the 1 event of the cbDateSelection_SelectionChanged control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub cbDateSelection_SelectionChanged_1(sender As Object, e As SelectionChangedEventArgs) Handles cbDateSelection.SelectionChanged
        If Not formLoaded Then
            Return
        End If
        Dim S As String = cbDateSelection.SelectedItem.ToString
        If cbDateSelection.SelectedValue IsNot Nothing Then
            UpdateSearchDict("email.cbDateSelection", cbDateSelection.SelectedValue.ToString)
        Else
            UpdateSearchDict("email.cbDateSelection", "")
        End If
        If cbDateSelection.SelectedValue.ToString.Equals("OFF") Then
            calStart.Opacity = 0.1
            calEnd.Opacity = 0.1
            dtMailDateStart.Opacity = 0.1
            dtMailDateEnd.Opacity = 0.1
        End If
        If cbDateSelection.SelectedValue.ToString.Equals("Between") Then
            calStart.Opacity = 1
            calEnd.Opacity = 1
            dtMailDateStart.Opacity = 1
            dtMailDateEnd.Opacity = 1
        End If
        If cbDateSelection.SelectedValue.ToString.Equals("Not Between") Then
            calStart.Opacity = 1
            calEnd.Opacity = 1
            dtMailDateStart.Opacity = 1
            dtMailDateEnd.Opacity = 1
        End If
        If cbDateSelection.SelectedValue.ToString.Equals("Before") Then
            calStart.Opacity = 1
            calEnd.Opacity = 0.1
            dtMailDateStart.Opacity = 1
            dtMailDateEnd.Opacity = 0.1
        End If
        If cbDateSelection.SelectedValue.ToString.Equals("After") Then
            calStart.Opacity = 0.1
            calEnd.Opacity = 1
            dtMailDateStart.Opacity = 0.1
            dtMailDateEnd.Opacity = 1
        End If
        SB.Text = "Date Filter changed to : " + cbDateSelection.SelectedValue.ToString
    End Sub
End Class

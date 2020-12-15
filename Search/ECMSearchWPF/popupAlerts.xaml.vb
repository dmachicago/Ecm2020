' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 07-16-2020
' ***********************************************************************
' <copyright file="popupAlerts.xaml.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports ECMEncryption
''' <summary>
''' Class popupAlerts.
''' Implements the <see cref="System.Windows.Window" />
''' Implements the <see cref="System.Windows.Markup.IComponentConnector" />
''' </summary>
''' <seealso cref="System.Windows.Window" />
''' <seealso cref="System.Windows.Markup.IComponentConnector" />
Partial Public Class popupAlerts

    'Dim GVAR As App = App.Current
    ''' <summary>
    ''' The utility
    ''' </summary>
    Dim UTIL As New clsUtility
    ''' <summary>
    ''' The log
    ''' </summary>
    Dim LOG As New clsLogMain
    ''' <summary>
    ''' The SMS
    ''' </summary>
    Dim SMS As New clsSMS
    'Dim EP As New clsEndPoint
    ''' <summary>
    ''' The en c2
    ''' </summary>
    Dim ENC2 As New ECMEncrypt()

    'Dim proxy As New SVCSearch.Service1Client
    'Dim ListOfAlerts As New System.Collections.ObjectModel.ObservableCollection(Of String)
    'Dim ListOfContacts As New System.Collections.ObjectModel.ObservableCollection(Of String)

    ''' <summary>
    ''' The list of alerts
    ''' </summary>
    Dim ListOfAlerts() As String = Nothing
    ''' <summary>
    ''' The list of contacts
    ''' </summary>
    Dim ListOfContacts() As String = Nothing

    ''' <summary>
    ''' The current object
    ''' </summary>
    Dim CurrentObject As String = ""

    ''' <summary>
    ''' Initializes a new instance of the <see cref="popupAlerts"/> class.
    ''' </summary>
    Public Sub New()
        InitializeComponent()

        'EP.setSearchSvcEndPoint(proxy)

        populateAlertCombo()
        populateNotificationCombo()

        SMS.LoadCarriers(cbCarrier)

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
    ''' Saves the notify.
    ''' </summary>
    Sub SaveNotify()

        Dim ContactEmail As String = txtEmail.Text.Trim
        Dim ContactIM As String = txtSms.Text.Trim
        Dim ContactName As String = txtName.Text.Trim
        ContactName = UTIL.RemoveSingleQuotes(ContactName)
        ContactEmail = UTIL.RemoveSingleQuotes(ContactEmail)

        CurrentObject = ContactName

        Dim s As String = ""
        s += " if not exists(select ContactEmail from AlertContact where ContactEmail = '" + ContactEmail + "')"
        s += " begin"
        s += " 	insert into [AlertContact] (ContactEmail, ContactIM, ContactName) values ('" + ContactEmail + "','" + ContactIM + "', '" + ContactName + "')"
        s += " end"
        s += " else"
        s += " begin"
        s += " 	update [AlertContact] set ContactIM = '" + ContactIM + "', ContactName = '" + ContactName + "'  where ContactEmail = '" + ContactEmail + "'"
        s += " end"

        'AddHandler ProxySearch.ExecuteSqlNewConn1Completed, AddressOf ApplySearchResults
        'EP.setSearchSvcEndPoint(proxy)

        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConn1(_SecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))

    End Sub

    ''' <summary>
    ''' Deletes the notify.
    ''' </summary>
    Sub deleteNotify()

        Dim ContactEmail As String = txtEmail.Text.Trim
        Dim ContactIM As String = txtSms.Text.Trim
        Dim ContactName As String = txtName.Text.Trim
        ContactName = UTIL.RemoveSingleQuotes(ContactName)
        ContactEmail = UTIL.RemoveSingleQuotes(ContactEmail)

        CurrentObject = ContactName

        Dim s As String = ""
        s += " delete from AlertContact where ContactEmail = '" + ContactEmail + "' "

        'AddHandler ProxySearch.ExecuteSqlNewConn1Completed, AddressOf ApplySearchResults
        'EP.setSearchSvcEndPoint(proxy)

        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConn1(_SecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))

    End Sub

    ''' <summary>
    ''' Saves the alert.
    ''' </summary>
    Sub SaveAlert()

        Dim AlertWord As String = txtAlertWord.Text
        Dim xDate As String = dteExpire.SelectedDate.ToString
        AlertWord = UTIL.RemoveSingleQuotes(AlertWord)

        If AlertWord.Contains(" ") Then
            MessageBox.Show("Sorry, ALERT words cannot contain blanks. They have to be separate words.")
            Return
        End If

        CurrentObject = AlertWord

        Dim s As String = ""
        s += " if not exists(select AlertWord from AlertWord where AlertWord = '" + AlertWord + "')" + vbCrLf
        s += " begin" + vbCrLf
        s += " 	insert into [AlertWord] (AlertWord, ExpirationDate) values ('" + AlertWord + "','" + xDate + "')" + vbCrLf
        s += " end" + vbCrLf
        s += " else" + vbCrLf
        s += " begin" + vbCrLf
        s += " 	update [AlertWord] set ExpirationDate = '" + xDate + "' where AlertWord = '" + AlertWord + "' " + vbCrLf
        s += " end" + vbCrLf

        'AddHandler ProxySearch.ExecuteSqlNewConn1Completed, AddressOf ApplySearchResults
        'EP.setSearchSvcEndPoint(proxy)

        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConn1(_SecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))
    End Sub

    ''' <summary>
    ''' Deletes the alert.
    ''' </summary>
    Sub DeleteAlert()

        Dim AlertWord As String = txtAlertWord.Text
        AlertWord = UTIL.RemoveSingleQuotes(AlertWord)

        CurrentObject = AlertWord

        Dim s As String = ""
        s += " delete from AlertWord where AlertWord = '" + AlertWord + "'" + vbCrLf

        'AddHandler ProxySearch.ExecuteSqlNewConn1Completed, AddressOf client_ExecuteDelete
        'EP.setSearchSvcEndPoint(proxy)

        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConn1(_SecureID, s, _UserID, ContractID)
        client_ExecuteDelete(BB)
    End Sub
    ''' <summary>
    ''' Clients the execute delete.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    Sub client_ExecuteDelete(RC As Boolean)
        Dim LL As Integer = 0

        If RC Then
            populateAlertCombo()
            populateNotificationCombo()
        Else
            MessageBox.Show("Failed Delete '" + CurrentObject + "'.")
        End If
        'RemoveHandler ProxySearch.ExecuteSqlNewConn1Completed, AddressOf ApplySearchResults
    End Sub

    ''' <summary>
    ''' Populates the alert combo.
    ''' </summary>
    Sub populateAlertCombo()
        Dim S As String = ""
        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        S = S + " SELECT  AlertWord + ' / ' + cast(ExpirationDate as varchar) " + vbCrLf
        S = S + " FROM  [AlertWord]" + vbCrLf
        S = S + " Order by AlertWord " + vbCrLf

        Dim strListOfItems As String = ""
        'AddHandler ProxySearch.getListOfStringsCompleted, AddressOf client_PopulateAlertCombo
        'EP.setSearchSvcEndPoint(proxy)
        S = ENC2.AES256EncryptString(S)
        Dim BB As Boolean = ProxySearch.getListOfStrings(_SecureID, strListOfItems, S, RC, RetMsg)
        'Dim strListOfItems As String = ""
        ListOfAlerts = strListOfItems.Split("|")

        client_PopulateAlertCombo(RC, ListOfAlerts, RetMsg)

    End Sub
    ''' <summary>
    ''' Clients the populate alert combo.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="ListOfItems">The list of items.</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    Sub client_PopulateAlertCombo(RC As Boolean, ListOfItems As String(), RetMsg As String)

        If RC Then
            lbAlerts.Items.Clear()
            For Each S As String In ListOfItems
                lbAlerts.Items.Add(S)
            Next
        Else
            gErrorCount += 1
            LOG.WriteToSqlLog("ERROR client_PopulateAlertCombo 100: " + RetMsg)
        End If
        'RemoveHandler ProxySearch.getListOfStringsCompleted, AddressOf client_PopulateAlertCombo
    End Sub

    ''' <summary>
    ''' Populates the notification combo.
    ''' </summary>
    Sub populateNotificationCombo()
        Dim S As String = ""
        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        S = S + " SELECT  ContactName + ' / ' + ContactEmail + ' / ' + ContactIM " + vbCrLf
        S = S + " FROM  [AlertContact]" + vbCrLf
        S = S + " Order by ContactName " + vbCrLf

        'AddHandler ProxySearch.getListOfStrings01Completed, AddressOf client_PopulateNotificationCombo
        'EP.setSearchSvcEndPoint(proxy)
        S = ENC2.AES256EncryptString(S)
        Dim ObjListOfRows As Object = ProxySearch.getListOfStrings01(_SecureID, S, RC, RetMsg, _UserID, ContractID)
        client_PopulateNotificationCombo(RC, RetMsg, ObjListOfRows)

    End Sub
    ''' <summary>
    ''' Clients the populate notification combo.
    ''' </summary>
    ''' <param name="RC">if set to <c>true</c> [rc].</param>
    ''' <param name="RetMsg">The ret MSG.</param>
    ''' <param name="ObjListOfRows">The object list of rows.</param>
    Sub client_PopulateNotificationCombo(RC As Boolean, RetMsg As String, ObjListOfRows As Object)

        Dim ListOfRows As New System.Collections.ObjectModel.ObservableCollection(Of SVCSearch.DS_ListOfStrings02)
        ListOfRows = ObjListOfRows

        Try
            If ListOfRows.Count > 0 Then
                lbAlertContact.Items.Clear()
                For Each ListItems In ListOfRows
                    Dim sItem As String = ListItems.strItem
                    lbAlertContact.Items.Add(sItem)
                Next
            Else
                gErrorCount += 1
                LOG.WriteToSqlLog("ERROR client_PopulateAlertCombo 100: " + RetMsg)
                lblPopup.Content = "ERROR 100 - No alerts found:"
            End If
        Catch ex As Exception
            LOG.WriteToSqlLog("ERROR client_PopulateAlertCombo 101: " + RetMsg)
            lblPopup.Content = "ERROR 101 - No alerts found:"
        End Try

        'RemoveHandler ProxySearch.getListOfStrings01Completed, AddressOf client_PopulateNotificationCombo
    End Sub
    ''' <summary>
    ''' Handles the Click event of the btnSave control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnSave.Click
        SaveAlert()
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnDelete control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnDelete.Click
        DeleteAlert()
    End Sub

    ''' <summary>
    ''' Handles the SelectionChanged event of the lbAlertContact control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub lbAlertContact_SelectionChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.SelectionChangedEventArgs) Handles lbAlertContact.SelectionChanged
        Dim I As Integer = lbAlertContact.SelectedIndex

        If I < 0 Then
            Return
        End If

        Dim S As String = lbAlertContact.Items(I)
        Dim A() As String = S.Split("/")

        txtName.Text = A(0).Trim
        txtEmail.Text = A(1).Trim
        txtSms.Text = A(2).Trim

    End Sub

    ''' <summary>
    ''' Handles the SelectionChanged event of the lbAlerts control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.Controls.SelectionChangedEventArgs"/> instance containing the event data.</param>
    Private Sub lbAlerts_SelectionChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.SelectionChangedEventArgs) Handles lbAlerts.SelectionChanged
        Dim I As Integer = lbAlerts.SelectedIndex

        If I < 0 Then
            Return
        End If

        Dim S As String = lbAlerts.Items(I)
        Dim A() As String = S.Split("/")

        txtAlertWord.Text = A(0)
        dteExpire.SelectedDate = CDate(A(1))

    End Sub

    ''' <summary>
    ''' Handles the Click event of the Button1 control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles Button1.Click

        If txtEmail.Text.Trim.Length = 0 Then
            MessageBox.Show("An EMAIL notification address must be supplied, returning.")
            Return
        End If
        If txtName.Text.Trim.Length = 0 Then
            MessageBox.Show("A NAME must be supplied, returning.")
            Return
        End If

        SaveNotify()
    End Sub

    ''' <summary>
    ''' Handles the Click event of the Button2 control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles Button2.Click
        deleteNotify()
    End Sub


End Class

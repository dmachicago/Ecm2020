Imports ECMEncryption
Partial Public Class popupAlerts

    'Dim GVAR As App = App.Current
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogMain
    Dim SMS As New clsSMS
    'Dim EP As New clsEndPoint
    Dim ENC2 As New ECMEncrypt()

    'Dim proxy As New SVCSearch.Service1Client
    'Dim ListOfAlerts As New System.Collections.ObjectModel.ObservableCollection(Of String)
    'Dim ListOfContacts As New System.Collections.ObjectModel.ObservableCollection(Of String)

    Dim ListOfAlerts() As String = Nothing
    Dim ListOfContacts() As String = Nothing

    Dim CurrentObject As String = ""

    Public Sub New()
        InitializeComponent()

        'EP.setSearchSvcEndPoint(proxy)

        populateAlertCombo()
        populateNotificationCombo()

        SMS.LoadCarriers(cbCarrier)

    End Sub

    Private Sub OKButton_Click(ByVal sender As Object, ByVal e As RoutedEventArgs) Handles OKButton.Click
        Me.DialogResult = True
    End Sub

    Private Sub CancelButton_Click(ByVal sender As Object, ByVal e As RoutedEventArgs) Handles CancelButton.Click
        Me.DialogResult = False
    End Sub

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
        s += " if not exists(select AlertWord from AlertWord where AlertWord = '" + AlertWord + "')" + Environment.NewLine
        s += " begin" + Environment.NewLine
        s += " 	insert into [AlertWord] (AlertWord, ExpirationDate) values ('" + AlertWord + "','" + xDate + "')" + Environment.NewLine
        s += " end" + Environment.NewLine
        s += " else" + Environment.NewLine
        s += " begin" + Environment.NewLine
        s += " 	update [AlertWord] set ExpirationDate = '" + xDate + "' where AlertWord = '" + AlertWord + "' " + Environment.NewLine
        s += " end" + Environment.NewLine

        'AddHandler ProxySearch.ExecuteSqlNewConn1Completed, AddressOf ApplySearchResults
        'EP.setSearchSvcEndPoint(proxy)

        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConn1(_SecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))
    End Sub

    Sub DeleteAlert()

        Dim AlertWord As String = txtAlertWord.Text
        AlertWord = UTIL.RemoveSingleQuotes(AlertWord)

        CurrentObject = AlertWord

        Dim s As String = ""
        s += " delete from AlertWord where AlertWord = '" + AlertWord + "'" + Environment.NewLine

        'AddHandler ProxySearch.ExecuteSqlNewConn1Completed, AddressOf client_ExecuteDelete
        'EP.setSearchSvcEndPoint(proxy)

        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConn1(_SecureID, s, _UserID, ContractID)
        client_ExecuteDelete(BB)
    End Sub
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

    Sub populateAlertCombo()
        Dim S As String = ""
        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        S = S + " SELECT  AlertWord + ' / ' + cast(ExpirationDate as varchar) " + Environment.NewLine
        S = S + " FROM  [AlertWord]" + Environment.NewLine
        S = S + " Order by AlertWord " + Environment.NewLine

        Dim strListOfItems As String = ""
        'AddHandler ProxySearch.getListOfStringsCompleted, AddressOf client_PopulateAlertCombo
        'EP.setSearchSvcEndPoint(proxy)
        S = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.getListOfStrings(_SecureID, strListOfItems, S, RC, RetMsg)
        'Dim strListOfItems As String = ""
        ListOfAlerts = strListOfItems.Split("|")

        client_PopulateAlertCombo(RC, ListOfAlerts, RetMsg)

    End Sub
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

    Sub populateNotificationCombo()
        Dim S As String = ""
        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        S = S + " SELECT  ContactName + ' / ' + ContactEmail + ' / ' + ContactIM " + Environment.NewLine
        S = S + " FROM  [AlertContact]" + Environment.NewLine
        S = S + " Order by ContactName " + Environment.NewLine

        'AddHandler ProxySearch.getListOfStrings01Completed, AddressOf client_PopulateNotificationCombo
        'EP.setSearchSvcEndPoint(proxy)
        S = ENC2.AES256EncryptString(s)
        Dim ObjListOfRows As Object = ProxySearch.getListOfStrings01(_SecureID, S, RC, RetMsg, _UserID, ContractID)
        client_PopulateNotificationCombo(RC, RetMsg, ObjListOfRows)

    End Sub
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
    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnSave.Click
        SaveAlert()
    End Sub

    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnDelete.Click
        DeleteAlert()
    End Sub

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

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles Button2.Click
        deleteNotify()
    End Sub


End Class

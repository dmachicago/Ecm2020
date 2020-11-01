Imports ECMEncryption

Public Class popupSaveSearch

    'Dim proxy As New SVCSearch.Service1Client

    Dim PARMS As New clsParms

    'Dim EP As New clsEndPoint
    Dim ENC2 As New ECMEncrypt()

    'Dim GVAR As App = App.Current
    Dim PRM As New clsParms

    Dim SearchParms As String = ""
    Dim ListOfQuickSearch As New List(Of String)

    Public Sub New()
        'InitializeComponent()
        'EP.setSearchSvcEndPoint(proxy)

        ApplyRecalledSearch = False

        For Each S As String In dictMasterSearch.Keys
            SearchParms = SearchParms + S + ChrW(253) + dictMasterSearch.Item(S) + ChrW(254)
        Next

        SearchParms = PARMS.BuildParmString(dictMasterSearch)
        SearchParms = SearchParms.Replace("'", "`")

    End Sub

    Private Sub CancelButton_Click(ByVal sender As Object, ByVal e As RoutedEventArgs) Handles CancelButton.Click
        ApplyRecalledSearch = False
    End Sub

    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnSave.Click
        Dim SearchName As String = txtSearchName.Text
        If SearchName.Trim.Length = 0 Then
            MessageBox.Show("Please supply a Search Name, returning.")
            Return
        End If

        SearchName = SearchName.Replace("'", "`")
        SearchSave(SearchName)

    End Sub

    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnDelete.Click

        Dim SearchName As String = cbUserSearch.Text
        If SearchName.Trim.Length = 0 Then
            MessageBox.Show("Please SELECT a Search Name, returning.")
            Return
        End If

        Dim msg$ = "This will REMOVE the selected search - " + SearchName
        Dim result As MessageBoxResult = MessageBox.Show(msg, "Are You Sure", MessageBoxButton.OKCancel)

        If result = MessageBoxResult.OK Then
        Else
            SB.Text = "Delete cancelled."
            Return
        End If

        SearchName = SearchName.Replace("''", "'")
        SearchName = SearchName.Replace("'", "''")
        Dim MySql As String = "Delete  SearchParms from SearchUser where SearchName = '" + SearchName + "' and UserID = '" + _UserID + "'"

        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
        'EP.setSearchSvcEndPoint(proxy)

        MySql = ENC2.AES256EncryptString(Mysql)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, MySql, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(Mysql))
    End Sub

    Private Sub btnRecall_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnRecall.Click
        Dim SearchName As String = cbUserSearch.Text
        If SearchName.Trim.Length = 0 Then
            MessageBox.Show("Please SELECT a Search Name, returning.")
            Return
        End If

        SearchReload(SearchName)

    End Sub

    Private Sub ChildWindow_Unloaded(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles MyBase.Unloaded
        ''Application.Current.RootVisual.SetValue(Control.IsEnabledProperty, True)
        'RemoveHandler ProxySearch.SaveUserSearchCompleted, AddressOf client_SearchHistorySave
    End Sub

    Sub SearchSave(ByVal SearchName As String)

        SearchName = SearchName.Replace("'", "''")
        Dim SearchParms As String = PRM.BuildParmString(dictMasterSearch)

        'AddHandler ProxySearch.SaveUserSearchCompleted, AddressOf client_SearchHistorySave
        'EP.setSearchSvcEndPoint(proxy)
        Dim BB As Boolean = ProxySearch.SaveUserSearch(_SecureID, SearchName, _UserID, SearchParms)
        client_SearchHistorySave(BB)

    End Sub

    Sub client_SearchHistorySave(BB As Boolean)
        If BB Then
        Else
            SB.Text = "Your search has NOT been saved."
        End If
        'RemoveHandler ProxySearch.SaveUserSearchCompleted, AddressOf client_SearchHistorySave
    End Sub

    Sub SearchReload(ByVal SearchName As String)
        SearchName = SearchName.Replace("'", "''")
        Dim SearchParms As String = ""

        'AddHandler ProxySearch.RecallUserSearchCompleted, AddressOf client_RecallUserSearch
        'EP.setSearchSvcEndPoint(proxy)
        Dim BB As Boolean = ProxySearch.RecallUserSearch(_SecureID, SearchName, _UserID, SearchParms)
        client_RecallUserSearch(BB, SearchParms)

    End Sub

    Sub client_RecallUserSearch(BB As Boolean, StrParms As String)
        If BB Then

            ApplyRecalledSearch = True
            dictMasterSearch.Clear()
            ListOfQuickSearch.Clear()
            Dim SearchParms() As String = Nothing
            Dim A() As String = Nothing
            Dim sKey As String = Nothing
            Dim sVal As String = Nothing
            Dim QuickSearchHistory As String = StrParms
            SearchParms = QuickSearchHistory.Split(ChrW(254))
            For Each S As String In SearchParms
                A = S.Split(ChrW(253))
                sKey = A(0)
                sVal = A(1)
                If Not dictMasterSearch.ContainsKey(sKey) Then
                    dictMasterSearch.Add(sKey, sVal)
                End If
            Next
            MessageBox.Show("Search '" + cbUserSearch.Text + "' reloaded, press OK to apply or Cancel to just return.")

        End If
        'RemoveHandler ProxySearch.RecallUserSearchCompleted, AddressOf client_RecallUserSearch
    End Sub

End Class
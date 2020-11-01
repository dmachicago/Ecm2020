Imports System.Windows.Media
Imports System.Windows.Media.Imaging

Partial Public Class popupContentSearchParms
    'Inherits ChildWindow

    'Dim proxy As New SVCSearch.Service1Client

    'Dim EP As New clsEndPoint

    Dim FormLoaded As Boolean = False

    'Dim GVAR As App = App.Current
    Dim COMMON As New clsCommonFunctions
    Dim Userid As String

    Dim UTIL As New clsUtility
    Dim ISO As New clsIsolatedStorage
    Dim CurrentCombo As String = ""
    'Dim ComboItems As New System.Collections.ObjectModel.ObservableCollection(Of String)
    Dim ComboItems() As String = Nothing
    'Dim dictMasterSearch As New Dictionary(Of String, String)
    Dim bMyEmails As Boolean = False
    Dim UserGuidID As String = ""
    Dim txtFilter As String = ""
    'Dim formLoaded As Boolean = False
    Dim gSecureID As string = -1
    'dictMasterSearch As New Dictionary(Of String, String)

    Public Sub New(ByVal iSecureID As Integer, ByRef SearchDICT As Dictionary(Of String, String))
        InitializeComponent()

        'EP.setSearchSvcEndPoint(proxy)


        Userid = _UserID
        COMMON.SaveClick(6930, Userid)

        gSecureID = iSecureID
        'dictMasterSearch = SearchDICT

        Dim sKey As String = ""
        Dim sVal As String = ""
        If dictMasterSearch IsNot Nothing Then
            For Each sKey In dictMasterSearch.Keys
                If dictMasterSearch.ContainsKey(sKey) Then

                    sVal = dictMasterSearch.Item(sKey)
                    If sKey.Equals("content.cbFileTypes") Then
                        If sVal IsNot Nothing Then
                            cbFileTypes.Text = sVal
                            cbFilename.Text = sVal
                        End If
                    ElseIf sKey.Equals("content.txtFileName") Then
                        txtFileName.Text = sVal
                        cbFilename.Text = sVal
                    ElseIf sKey.Equals("content.txtFileTypes") Then
                        txtFileTypes.Text = sVal
                        cbFileTypes.Text = sVal
                    ElseIf sKey.Equals("content.txtDirectory") Then
                        txtDirectory.Text = sVal
                        cbDirs.Text = sVal
                    ElseIf sKey.Equals("content.ckDays") Then
                        If sVal.Equals("true") Then
                            ckDays.IsChecked = True
                        Else
                            ckDays.IsChecked = False
                        End If
                        txtDirectory.Text = sVal
                    ElseIf sKey.Equals("content.nbrDays") Then
                        nbrDays.Text = sVal
                    ElseIf sKey.Equals("content.cbMeta1") Then
                        If sVal IsNot Nothing Then
                            cbMeta1.Text = sVal
                        End If
                    ElseIf sKey.Equals("content.cbMeta2") Then
                        If sVal IsNot Nothing Then
                            cbMeta2.Text = sVal
                        End If
                    ElseIf sKey.Equals("content.txtMetaSearch1") Then
                        txtMetaSearch1.Text = sVal
                    ElseIf sKey.Equals("content.txtMetaSearch2") Then
                        txtMetaSearch2.Text = sVal
                    ElseIf sKey.Equals("content.txtdtCreateDateStart") Then
                        If sVal IsNot Nothing Then
                            If sVal.Length = 0 Then
                                txtdtCreateDateStart.Text = ""
                                dtCreateDateStart.SelectedDate = Nothing
                            Else
                                txtdtCreateDateStart.Text = sVal
                                dtCreateDateStart.SelectedDate = CDate(sVal)
                            End If
                        End If
                    ElseIf sKey.Equals("content.txtdtCreateDateEnd") Then
                        If sVal IsNot Nothing Then
                            If sVal.Length = 0 Then
                                txtdtCreateDateEnd.Text = ""
                                dtCreateDateEnd.SelectedDate = Nothing
                            Else
                                txtdtCreateDateEnd.Text = sVal
                                dtCreateDateEnd.SelectedDate = CDate(sVal)
                            End If
                        End If

                    ElseIf sKey.Equals("content.cbEvalCreateTime") Then
                        If sVal IsNot Nothing Then
                            If sVal.Length = 0 Then
                                cbEvalCreateTime.Text = ""
                            Else
                                cbEvalCreateTime.Text = sVal
                            End If
                        End If
                    ElseIf sKey.Equals("content.cbEvalWriteTime") Then
                        If sVal IsNot Nothing Then
                            If sVal.Length = 0 Then
                                cbEvalWriteTime.Text = ""
                            Else
                                cbEvalWriteTime.Text = sVal
                            End If
                        End If
                    ElseIf sKey.Equals("content.txtdtLastWriteStart") Then
                        If sVal IsNot Nothing Then
                            If sVal.Length = 0 Then
                                txtdtLastWriteStart.Text = ""
                                dtLastWriteStart.SelectedDate = Nothing
                            Else
                                txtdtLastWriteStart.Text = sVal
                                dtLastWriteStart.SelectedDate = CDate(sVal)
                            End If
                        End If
                    ElseIf sKey.Equals("content.txtdtLastWriteEnd") Then
                        If sVal IsNot Nothing Then
                            If sVal.Length = 0 Then
                                txtdtLastWriteEnd.Text = ""
                                dtLastWriteEnd.SelectedDate = Nothing
                            Else
                                txtdtLastWriteEnd.Text = sVal
                                dtLastWriteEnd.SelectedDate = CDate(sVal)
                            End If

                        End If
                    ElseIf sKey.Equals("content.dtLastWriteStart") Then
                        If sVal IsNot Nothing Then
                            If sVal.Length = 0 Then
                                dtLastWriteStart.SelectedDate = Nothing
                            Else
                                dtLastWriteStart.SelectedDate = CDate(sVal)
                            End If

                        End If
                    End If
                End If
            Next
        End If

        FormLoaded = True

    End Sub

    Sub PopulateComboBoxMetadata1()

        Dim ComboName As String = "cbData1"
        Dim TblColName As String = "AttributeName"
        Dim MySql As String = "Select distinct [AttributeName] FROM [Attributes] ORDER BY [AttributeName]"
        Dim tVar As String = cbMeta1.Text
        tVar = UTIL.RemoveSingleQuotes(tVar)

        If cbMeta1.Text.Equals("*") Then
            MySql = "Select distinct [AttributeName] FROM [Attributes] ORDER BY [AttributeName]"
        Else
            MySql = "Select distinct [AttributeName] FROM [Attributes] where AttributeName like '" + tVar + "' ORDER BY [AttributeName]"
        End If

        PopulateComboBox1(ComboName, TblColName, MySql)

    End Sub

    Sub PopulateComboBoxMetadata2()

        Dim ComboName As String = "cbData2"
        Dim TblColName As String = "AttributeName"
        Dim MySql As String = "Select distinct [AttributeName] FROM [Attributes] ORDER BY [AttributeName]"
        Dim tVar As String = cbMeta2.Text
        tVar = UTIL.RemoveSingleQuotes(tVar)

        If cbMeta1.Text.Equals("*") Then
            MySql = "Select distinct [AttributeName] FROM [Attributes] ORDER BY [AttributeName]"
        Else
            MySql = "Select distinct [AttributeName] FROM [Attributes] where AttributeName like '" + tVar + "' ORDER BY [AttributeName]"
        End If


        PopulateComboBox2(ComboName, TblColName, MySql)

    End Sub

    Private Sub CancelButton_Click(ByVal sender As Object, ByVal e As RoutedEventArgs) Handles CancelButton.Click
        'ISO.DeleteDetailSearchParms("CONTENT")

        For Each sKey As String In dictMasterSearch.Keys
            If InStr(sKey, "content.", CompareMethod.Text) > 0 Then
                dictMasterSearch.Item(sKey) = ""
            End If
        Next

        Me.DialogResult = False
        Me.Close()
    End Sub

    Private Sub ckDays_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckDays.Checked

        'RotateXDaysChecked.Begin()

        dtLastWriteStart.SelectedDate = Nothing
        dtLastWriteEnd.SelectedDate = Nothing
        txtdtLastWriteStart.Text = ""
        txtdtLastWriteEnd.Text = ""

        'nbrDays.Opacity = 1
        nbrDays.Opacity = 30

        UpdateSearchDict("content.ckDays", ckDays.IsChecked.ToString)
    End Sub

    Private Sub ckDays_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckDays.Unchecked
        'RotateXDaysUnchecked.Begin()
        nbrDays.Opacity = 0.1
        UpdateSearchDict("content.ckDays", ckDays.IsChecked.ToString)
    End Sub

    Sub UpdateSearchDict(ByVal tKey As String, ByVal tValue As String)
        If Not FormLoaded Then
            Return
        End If

        If InStr(tKey, "content.", CompareMethod.Text) = 0 Then
            tKey = "content." + tKey
        End If

        If dictMasterSearch.ContainsKey(tKey) Then
            dictMasterSearch.Item(tKey) = tValue
            SB.Text = tKey + " updated"
        Else
            dictMasterSearch.Add(tKey, tValue)
            SB.Text = tKey + " added"
        End If
    End Sub

    Private Sub txtFileName_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtFileName.TextChanged
        UpdateSearchDict("content.txtFileName", txtFileName.Text.Trim)
        If txtFileName.Text.Length > 0 Then
            cbFilename.Opacity = 1
            btnGetFileNames.Opacity = 1
        Else
            cbFilename.Opacity = 0.1
            btnGetFileNames.Opacity = 0.1
        End If
    End Sub

    Private Sub txtDirectory_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtDirectory.TextChanged
        UpdateSearchDict("content.txtDirectory", txtDirectory.Text.Trim)
        If txtFileName.Text.Length > 0 Then
            cbDirs.Opacity = 1
            btnLoadFileDirs.Opacity = 1
        Else
            cbDirs.Opacity = 0.1
            btnLoadFileDirs.Opacity = 0.1
        End If
    End Sub

    Private Sub cbFileTypes_SelectionChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.SelectionChangedEventArgs)
        UpdateSearchDict("content.cbFileTypes", cbFileTypes.SelectedItem.ToString)
    End Sub

    Private Sub txtMetaSearch1_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs)
        UpdateSearchDict("content.txtMetaSearch1", txtMetaSearch1.Text.Trim)
    End Sub

    Private Sub txtMetaSearch2_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs)
        UpdateSearchDict("content.txtMetaSearch2", txtMetaSearch2.Text.Trim)
    End Sub

    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnSave.Click
        UpdateSearchDict("content.cbMeta1", cbMeta1.Text)
        UpdateSearchDict("content.cbMeta2", cbMeta2.Text)
        'For Each sKey As String In dictMasterSearch.Keys
        '    If InStr(sKey, "content.", CompareMethod.Text) > 0 Then
        '        dictMasterSearch.Item(sKey) = ""
        '    End If
        'Next

        Me.DialogResult = True
        Me.Close()
    End Sub

    Sub PopulateComboBox1(ByVal ComboName As String, ByVal TblColName As String, ByVal MySql As String)
        CurrentCombo = ComboName
        'AddHandler ProxySearch.PopulateComboBoxCompleted, AddressOf client_PopulateComboBox1
        'EP.setSearchSvcEndPoint(proxy)
        ProxySearch.PopulateComboBox(_SecureID, ComboItems, TblColName, MySql)
        client_PopulateComboBox1(ComboItems)

    End Sub
    Sub client_PopulateComboBox1(CB As String())
        If CB.Count > 0 Then
            If CurrentCombo.Equals("cbFileTypes") Then
                cbFileTypes.ItemsSource = CB
            End If
            If CurrentCombo.Equals("cbMeta1") Then
                cbMeta1.ItemsSource = CB
            End If
            If CurrentCombo.Equals("cbMeta2") Then
                cbMeta2.ItemsSource = CB
            End If
        End If
        'RemoveHandler ProxySearch.PopulateComboBoxCompleted, AddressOf client_PopulateComboBox1
    End Sub

    Sub PopulateComboBox2(ByVal ComboName As String, ByVal TblColName As String, ByVal MySql As String)
        CurrentCombo = ComboName
        'AddHandler ProxySearch.PopulateComboBoxCompleted, AddressOf client_PopulateComboBox2
        'EP.setSearchSvcEndPoint(proxy)
        ProxySearch.PopulateComboBox(_SecureID, ComboItems, TblColName, MySql)
        client_PopulateComboBox1(ComboItems)
    End Sub


    Private Sub dtLastWriteStart_SelectedDatesChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.SelectionChangedEventArgs)
        Dim S As String = dtLastWriteStart.SelectedDate.ToString
        UpdateSearchDict("content.dtLastWriteStart", S)
        txtdtLastWriteStart.Text = S
    End Sub

    Private Sub dtLastWriteEnd_SelectedDatesChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.SelectionChangedEventArgs) Handles dtLastWriteEnd.SelectedDatesChanged
        Dim S As String = dtLastWriteEnd.SelectedDate.ToString
        UpdateSearchDict("content.dtLastWriteEnd", S)
        txtdtLastWriteEnd.Text = S
    End Sub

    Private Sub dtCreateDateStart_SelectedDatesChanged_1(ByVal sender As System.Object, ByVal e As System.Windows.Controls.SelectionChangedEventArgs) Handles dtCreateDateStart.SelectedDatesChanged
        Dim S As String = dtCreateDateStart.SelectedDate.ToString
        UpdateSearchDict("content.dtCreateDateStart", S)
        txtdtCreateDateStart.Text = S
    End Sub

    Private Sub dtCreateDateEnd_SelectedDatesChanged_1(ByVal sender As System.Object, ByVal e As System.Windows.Controls.SelectionChangedEventArgs) Handles dtCreateDateEnd.SelectedDatesChanged
        Dim S As String = dtCreateDateEnd.SelectedDate.ToString
        UpdateSearchDict("content.dtCreateDateEnd", S)
        txtdtCreateDateEnd.Text = S
    End Sub

    Private Sub dtLastWriteStart_SelectedDatesChanged_1(ByVal sender As System.Object, ByVal e As System.Windows.Controls.SelectionChangedEventArgs) Handles dtLastWriteStart.SelectedDatesChanged
        Dim S As String = dtLastWriteStart.SelectedDate.ToString
        UpdateSearchDict("content.dtLastWriteStart", S)
        txtdtLastWriteStart.Text = S
    End Sub

    Private Sub txtdtCreateDateStart_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtdtCreateDateStart.TextChanged
        UpdateSearchDict("content.txtdtCreateDateStart", txtdtCreateDateStart.Text)
    End Sub

    Private Sub txtdtCreateDateEnd_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtdtCreateDateEnd.TextChanged
        UpdateSearchDict("content.txtdtCreateDateEnd", txtdtCreateDateEnd.Text)
    End Sub

    Private Sub txtdtLastWriteStart_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtdtLastWriteStart.TextChanged
        UpdateSearchDict("content.txtdtLastWriteStart", txtdtLastWriteStart.Text)
    End Sub

    Private Sub txtdtLastWriteEnd_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtdtLastWriteEnd.TextChanged
        UpdateSearchDict("content.txtdtLastWriteEnd", txtdtLastWriteEnd.Text)
    End Sub

    Private Sub txtMetaSearch1_TextChanged_1(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtMetaSearch1.TextChanged
        UpdateSearchDict("content.txtMetaSearch1", txtMetaSearch1.Text)
    End Sub

    Private Sub txtMetaSearch2_TextChanged_1(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtMetaSearch2.TextChanged
        UpdateSearchDict("content.txtMetaSearch2", txtMetaSearch2.Text)
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles Button1.Click

        txtFileTypes.Text = "<txtFileTypes>"
        txtFileName.Text = "<txtFileName>"
        txtDirectory.Text = "<txtDirectory>"
        txtDirectory.Text = "<txtDirectory>"
        cbMeta1.Text = "<cbMeta1>"
        txtMetaSearch1.Text = "<txtMetaSearch1>"
        cbMeta2.Text = "<cbMeta2>"
        ckDays.IsChecked = True
        nbrDays.Text = "360"
        txtMetaSearch2.Text = "<txtMetaSearch2>"
        cbEvalCreateTime.Text = "Between"
        cbEvalWriteTime.Text = "Between"

        cbEvalCreateTime.SelectedItem = "Between"
        cbEvalWriteTime.SelectedItem = "Between"

        dtCreateDateStart.SelectedDate = #8/11/2005#
        dtCreateDateEnd.SelectedDate = #8/11/2011#
        dtLastWriteStart.SelectedDate = #8/11/2007#
        dtLastWriteEnd.SelectedDate = #8/21/2011#

    End Sub

    Private Sub BtnCbMeta1_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles BtnCbMeta1.Click
        PopulateComboBoxMetadata1()
    End Sub

    Private Sub BtnCbMeta2_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles BtnCbMeta2.Click
        PopulateComboBoxMetadata2()
    End Sub

    Sub PopulateCbFilename()
        Dim MySql As String = "Select distinct [SourceName] FROM [DataSource] where SourceName like '" + txtFileName.Text.Trim + "' ORDER BY [SourceName]"
        'AddHandler ProxySearch.PopulateComboBoxCompleted, AddressOf client_PopulateCbFilename
        'EP.setSearchSvcEndPoint(proxy)
        ProxySearch.PopulateComboBox(_SecureID, ComboItems, "SourceName", MySql)
        client_PopulateCbFilename(ComboItems)
    End Sub
    Sub client_PopulateCbFilename(CB As String())
        If CB.Count > 1 Then
            cbFilename.ItemsSource = CB
        End If
        'RemoveHandler ProxySearch.PopulateComboBoxCompleted, AddressOf client_PopulateComboBox1
    End Sub
    Private Sub btnGetFileNames_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnGetFileNames.Click
        PopulateCbFilename()
    End Sub

    Sub PopulateCbDirs()
        Dim MySql As String = "Select distinct [FileDirectory] FROM [DataSource] where FileDirectory like '" + txtDirectory.Text.Trim + "' ORDER BY [FileDirectory]"
        'AddHandler ProxySearch.PopulateComboBoxCompleted, AddressOf client_PopulateCbDirs
        'EP.setSearchSvcEndPoint(proxy)
        ProxySearch.PopulateComboBox(_SecureID, ComboItems, "FileDirectory", MySql)
        client_PopulateCbDirs(ComboItems)
    End Sub
    Sub client_PopulateCbDirs(cb As String())
        If cb.Count > 0 Then
            cbDirs.ItemsSource = cb
        End If
        'RemoveHandler ProxySearch.PopulateComboBoxCompleted, AddressOf client_PopulateComboBox1
    End Sub
    Private Sub btnLoadFileDirs_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnLoadFileDirs.Click
        PopulateCbDirs()
    End Sub


    Sub PopulateCbFileTypes()
        Dim MySql As String = ""
        If IsNothing(cbFileTypes.Text) Then
            cbFileTypes.Text = "*"
        End If
        If cbFileTypes.Text.Trim.Equals("*") Then
            MySql = "Select distinct [OriginalFileType] FROM [DataSource] ORDER BY [OriginalFileType]"
        Else
            MySql = "Select distinct [OriginalFileType] FROM [DataSource] where OriginalFileType like '" + txtFileTypes.Text.Trim + "' ORDER BY [OriginalFileType]"
        End If

        'AddHandler ProxySearch.PopulateComboBoxCompleted, AddressOf client_PopulateCbFileTypes
        'EP.setSearchSvcEndPoint(proxy)
        ProxySearch.PopulateComboBox(_SecureID, ComboItems, "OriginalFileType", MySql)
        client_PopulateCbFileTypes(ComboItems)
    End Sub
    Sub client_PopulateCbFileTypes(CB As String())
        If CB.Count > 0 Then
            cbFileTypes.ItemsSource = CB
        End If
        'RemoveHandler ProxySearch.PopulateComboBoxCompleted, AddressOf client_PopulateComboBox1
    End Sub

    Private Sub btnGetFileTypes_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnGetFileTypes.Click
        PopulateCbFileTypes()
    End Sub

    Private Sub btnreset_Click(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles btnreset.Click

        txtFileName.Text = ""
        txtDirectory.Text = ""
        cbFilename.Text = ""
        cbDirs.Text = ""
        txtFileTypes.Text = ""
        cbFileTypes.Text = ""
        ckDays.IsChecked = False
        nbrDays.Text = "0"
        cbMeta1.Text = ""
        txtMetaSearch1.Text = ""
        cbMeta2.Text = ""
        txtMetaSearch2.Text = ""
        cbEvalCreateTime.Text = "OFF"
        cbEvalWriteTime.Text = "OFF"
        dtCreateDateStart.SelectedDate = Nothing
        dtCreateDateEnd.SelectedDate = Nothing
        dtLastWriteStart.SelectedDate = Nothing
        dtLastWriteEnd.SelectedDate = Nothing

    End Sub

    Private Sub txtFileTypes_TextChanged(ByVal sender As System.Object, ByVal e As System.Windows.Controls.TextChangedEventArgs) Handles txtFileTypes.TextChanged
        UpdateSearchDict("content.txtFileTypes", txtFileTypes.Text.Trim)
        If txtFileTypes.Text.Length > 0 Then
            cbFileTypes.Opacity = 1
            btnGetFileTypes.Opacity = 1
        Else
            cbFileTypes.Opacity = 0.1
            btnGetFileTypes.Opacity = 0.1
        End If
    End Sub


    Private Sub nbrDays_TextChanged(sender As Object, e As TextChangedEventArgs) Handles nbrDays.TextChanged
        UpdateSearchDict("content.nbrDays", nbrDays.Text)
    End Sub

    Private Sub cbFileTypes_SelectionChanged_1(sender As Object, e As SelectionChangedEventArgs) Handles cbFileTypes.SelectionChanged
        txtFileTypes.Text = cbFileTypes.Text
    End Sub

    Private Sub cbFilename_SelectionChanged(sender As Object, e As SelectionChangedEventArgs) Handles cbFilename.SelectionChanged
        txtFileName.Text = cbFilename.Text
    End Sub

    Private Sub cbDirs_SelectionChanged(sender As Object, e As SelectionChangedEventArgs) Handles cbDirs.SelectionChanged
        txtDirectory.Text = cbDirs.Text
    End Sub

    Private Sub cbEvalCreateTime_SelectionChanged_1(sender As Object, e As SelectionChangedEventArgs) Handles cbEvalCreateTime.SelectionChanged
        UpdateSearchDict("content.cbEvalCreateTime", cbEvalCreateTime.SelectedItem.ToString)

        Dim sDateFilter As String = cbEvalCreateTime.Text
        If sDateFilter IsNot Nothing Then
            UpdateSearchDict("content.cbEvalCreateTime", sDateFilter)
        Else
            UpdateSearchDict("content.cbEvalCreateTime", "")
        End If

        ckDays.IsChecked = False
        nbrDays.Text = "0"

        If sDateFilter.Equals("OFF") Then
            dtCreateDateStart.SelectedDate = Nothing
            dtCreateDateEnd.SelectedDate = Nothing
            txtdtCreateDateStart.Text = ""
            txtdtCreateDateEnd.Text = ""

            dtCreateDateStart.Opacity = 0.1
            dtCreateDateEnd.Opacity = 0.1
            txtdtCreateDateStart.Opacity = 0.1
            txtdtCreateDateEnd.Opacity = 0.1
        End If
        If sDateFilter.Equals("Between") Then
            dtCreateDateStart.Opacity = 1
            dtCreateDateEnd.Opacity = 1
            txtdtCreateDateStart.Opacity = 1
            txtdtCreateDateEnd.Opacity = 1

            dtCreateDateStart.SelectedDate = Nothing
            dtCreateDateEnd.SelectedDate = Nothing
            txtdtCreateDateStart.Text = ""
            txtdtCreateDateEnd.Text = ""

        End If
        If sDateFilter.Equals("Not Between") Then
            dtCreateDateStart.Opacity = 1
            dtCreateDateEnd.Opacity = 1
            txtdtCreateDateStart.Opacity = 1
            txtdtCreateDateEnd.Opacity = 1

            dtCreateDateStart.SelectedDate = Nothing
            dtCreateDateEnd.SelectedDate = Nothing
            txtdtCreateDateStart.Text = ""
            txtdtCreateDateEnd.Text = ""
        End If
        If sDateFilter.Equals("Before") Then
            dtCreateDateStart.Opacity = 1
            dtCreateDateEnd.Opacity = 0.1
            txtdtCreateDateStart.Opacity = 1
            txtdtCreateDateEnd.Opacity = 0.1

            dtCreateDateStart.SelectedDate = Nothing
            dtCreateDateEnd.SelectedDate = Nothing
            txtdtCreateDateStart.Text = ""
            txtdtCreateDateEnd.Text = ""
        End If
        If sDateFilter.Equals("After") Then
            dtCreateDateStart.Opacity = 0.1
            dtCreateDateEnd.Opacity = 1
            txtdtCreateDateStart.Opacity = 0.1
            txtdtCreateDateEnd.Opacity = 1

            dtCreateDateStart.SelectedDate = Nothing
            dtCreateDateEnd.SelectedDate = Nothing
            txtdtCreateDateStart.Text = ""
            txtdtCreateDateEnd.Text = ""
        End If
        If sDateFilter.Equals("On") Then
            dtCreateDateStart.Opacity = 1
            dtCreateDateEnd.Opacity = 0.1
            txtdtCreateDateStart.Opacity = 1
            txtdtCreateDateEnd.Opacity = 0.1

            dtCreateDateStart.SelectedDate = Nothing
            dtCreateDateEnd.SelectedDate = Nothing
            txtdtCreateDateStart.Text = ""
            txtdtCreateDateEnd.Text = ""
        End If

        SB.Text = "Date Filter changed to : " + sDateFilter
    End Sub

    Private Sub cbEvalWriteTime_SelectionChanged_1(sender As Object, e As SelectionChangedEventArgs) Handles cbEvalWriteTime.SelectionChanged
        UpdateSearchDict("content.cbEvalWriteTime", cbEvalWriteTime.SelectedItem.ToString)

        Dim sDateFilter As String = cbEvalWriteTime.Text
        If sDateFilter IsNot Nothing Then
            UpdateSearchDict("content.cbEvalWriteTime", sDateFilter)
        Else
            UpdateSearchDict("content.cbEvalWriteTime", "")
        End If

        ckDays.IsChecked = False
        nbrDays.Text = "0"

        dtLastWriteStart.SelectedDate = Nothing
        dtLastWriteEnd.SelectedDate = Nothing
        txtdtLastWriteStart.Text = ""
        txtdtLastWriteEnd.Text = ""

        If sDateFilter.Equals("OFF") Then
            dtLastWriteStart.Opacity = 0.1
            dtLastWriteEnd.Opacity = 0.1
            txtdtLastWriteStart.Opacity = 0.1
            txtdtLastWriteEnd.Opacity = 0.1
        End If
        If sDateFilter.Equals("Between") Then
            dtLastWriteStart.Opacity = 1
            dtLastWriteEnd.Opacity = 1
            txtdtLastWriteStart.Opacity = 1
            txtdtLastWriteEnd.Opacity = 1
        End If
        If sDateFilter.Equals("Not Between") Then
            dtLastWriteStart.Opacity = 1
            dtLastWriteEnd.Opacity = 1
            txtdtLastWriteStart.Opacity = 1
            txtdtLastWriteEnd.Opacity = 1
        End If
        If sDateFilter.Equals("Before") Then
            dtLastWriteStart.Opacity = 1
            dtLastWriteEnd.Opacity = 0.1
            txtdtLastWriteStart.Opacity = 1
            txtdtLastWriteEnd.Opacity = 0.1
        End If
        If sDateFilter.Equals("After") Then
            dtLastWriteStart.Opacity = 0.1
            dtLastWriteEnd.Opacity = 1
            txtdtLastWriteStart.Opacity = 0.1
            txtdtLastWriteEnd.Opacity = 1
        End If
        If sDateFilter.Equals("On") Then
            dtLastWriteStart.Opacity = 1
            dtLastWriteEnd.Opacity = 0.1
            txtdtLastWriteStart.Opacity = 1
            txtdtLastWriteEnd.Opacity = 0.1
        End If
        SB.Text = "Date Filter changed to : " + sDateFilter
    End Sub

    Private Sub cbMeta1_SelectionChanged_1(sender As Object, e As SelectionChangedEventArgs) Handles cbMeta1.SelectionChanged
        UpdateSearchDict("content.cbMeta1", cbMeta1.SelectedItem.ToString)
    End Sub

    Private Sub cbMeta2_SelectionChanged_1(sender As Object, e As SelectionChangedEventArgs) Handles cbMeta2.SelectionChanged
        UpdateSearchDict("content.cbMeta2", cbMeta2.SelectedItem.ToString)
    End Sub
End Class

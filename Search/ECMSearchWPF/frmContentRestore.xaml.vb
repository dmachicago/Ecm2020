' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 06-28-2020
'
' Last Modified By : wdale
' Last Modified On : 06-28-2020
' ***********************************************************************
' <copyright file="frmContentRestore.xaml.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
''' <summary>
''' Class frmContentRestore.
''' Implements the <see cref="System.Windows.Window" />
''' Implements the <see cref="System.Windows.Markup.IComponentConnector" />
''' </summary>
''' <seealso cref="System.Windows.Window" />
''' <seealso cref="System.Windows.Markup.IComponentConnector" />
Public Class frmContentRestore

    ''' <summary>
    ''' The use iso
    ''' </summary>
    Dim UseISO As Boolean = False

    'Dim proxy As New SVCSearch.Service1Client
    'Dim EP As New clsEndPoint

    ''' <summary>
    ''' The common
    ''' </summary>
    Dim COMMON As New clsCommonFunctions
    'Dim GVAR As App = App.Current
    ''' <summary>
    ''' The user identifier
    ''' </summary>
    Dim UserID As String = ""

    ''' <summary>
    ''' The b do not overwrite existing file
    ''' </summary>
    Public bDoNotOverwriteExistingFile As Boolean = True
    ''' <summary>
    ''' The b overwrite existing file
    ''' </summary>
    Public bOverwriteExistingFile As Boolean = False
    ''' <summary>
    ''' The b restore to original directory
    ''' </summary>
    Public bRestoreToOriginalDirectory As Boolean = False
    ''' <summary>
    ''' The b restore to my documents
    ''' </summary>
    Public bRestoreToMyDocuments As Boolean = True
    ''' <summary>
    ''' The b create original dir if missing
    ''' </summary>
    Public bCreateOriginalDirIfMissing As Boolean = True

    ''' <summary>
    ''' The p repo table name
    ''' </summary>
    Dim pRepoTableName As String = ""
    ''' <summary>
    ''' The dg emails
    ''' </summary>
    Dim dgEmails As DataGrid
    ''' <summary>
    ''' The dg email attachment
    ''' </summary>
    Dim dgEmailAttachment As DataGrid
    ''' <summary>
    ''' The dg content
    ''' </summary>
    Dim dgContent As DataGrid

    ''' <summary>
    ''' Initializes a new instance of the <see cref="frmContentRestore"/> class.
    ''' </summary>
    ''' <param name="RepoTableName">Name of the repo table.</param>
    ''' <param name="gEmails">The g emails.</param>
    ''' <param name="gEmailAttachment">The g email attachment.</param>
    ''' <param name="gContent">Content of the g.</param>
    Public Sub New(ByVal RepoTableName As String, ByVal gEmails As DataGrid, ByVal gEmailAttachment As DataGrid, ByVal gContent As DataGrid)
        'InitializeComponent()

        'EP.setSearchSvcEndPoint(proxy)

        UserID = _UserID
        gCurrUserGuidID = _UserGuid
        COMMON.SaveClick(3300, UserID)

        pRepoTableName = RepoTableName
        dgEmails = gEmails
        dgEmailAttachment = gEmailAttachment
        dgContent = gContent

        getRestoreStats()

    End Sub

    ''' <summary>
    ''' Handles the Click event of the OKButton control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub OKButton_Click(ByVal sender As Object, ByVal e As RoutedEventArgs) Handles OKButton.Click
        Me.DialogResult = True
        SaveRestoreFiles()
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
    ''' Handles the Checked event of the rbToOriginalDir control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub rbToOriginalDir_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs)
        bRestoreToOriginalDirectory = True
        bRestoreToMyDocuments = False
    End Sub

    ''' <summary>
    ''' Handles the Checked event of the rbToSelDir control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub rbToSelDir_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles rbToSelDir.Checked
        bRestoreToOriginalDirectory = False
        bRestoreToMyDocuments = True
        ckCreateMissing.IsChecked = False
    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the rbToSelDir control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub rbToSelDir_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs)
        bRestoreToOriginalDirectory = True
        bRestoreToMyDocuments = False
    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the rbToOriginalDir control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub rbToOriginalDir_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs)
        bRestoreToOriginalDirectory = False
        bRestoreToMyDocuments = True
    End Sub

    ''' <summary>
    ''' Handles the 1 event of the rbToSelDir_Unchecked control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub rbToSelDir_Unchecked_1(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles rbToSelDir.Unchecked
        bRestoreToOriginalDirectory = False
        bRestoreToMyDocuments = True
    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the ckOverWrite control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckOverWrite_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckOverWrite.Unchecked
        bDoNotOverwriteExistingFile = False
    End Sub

    ''' <summary>
    ''' Handles the Checked event of the ckOverWrite control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckOverWrite_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckOverWrite.Checked
        bDoNotOverwriteExistingFile = True
    End Sub
    ''' <summary>
    ''' Saves the restore files.
    ''' </summary>
    Sub SaveRestoreFiles()

        Dim CurrentGuid As String = ""
        Dim ISO As New clsIsolatedStorage

        Dim L As New List(Of String)


        Dim FQN As String = "NA"
        Dim iCnt As Integer = 0
        If pRepoTableName.ToUpper.Equals("EMAILATTACHMENT") Then
            iCnt = dgEmailAttachment.SelectedItems.Count
            'For Each O As Object In dgEmails.SelectedItems
            '    iCnt += 1
            'Next
        End If
        If pRepoTableName.ToUpper.Equals("EMAIL") Then
            iCnt = dgEmails.SelectedItems.Count
            'For Each O As Object In dgEmails.SelectedItems
            '    iCnt += 1
            'Next
        End If
        If pRepoTableName.ToUpper.Equals("DATASOURCE") Then
            iCnt = dgContent.SelectedItems.Count
            'For Each O As Object In dgContent.SelectedItems
            '    iCnt += 1
            'Next
        End If
        If iCnt = 0 Then
            MessageBox.Show("To perform a restore, one or more rows must be selected, returning.")
            Return
        End If
        iCnt = 0
        Dim S As String = ""
        If pRepoTableName.Equals("Email") Then
            Dim R As DataGridRow
            For Each R In dgEmails.SelectedItems
                iCnt += 1
                'CurrentGuid = R("EmailGuid")
                CurrentGuid = grid.GetCell(dgEmails, R, "EmailGuid").ToString
                'Dim TypeEmail As String = R("SourceTypeCode")
                Dim TypeEmail As String = grid.GetCell(dgEmails, R, "SourceTypeCode").ToString
                S = ""
                S += pRepoTableName.ToUpper
                S += ChrW(254) + CurrentGuid
                S += ChrW(254) + TypeEmail
                S += ChrW(254) + "-"
                S += ChrW(254) + bDoNotOverwriteExistingFile.ToString
                S += ChrW(254) + bOverwriteExistingFile.ToString
                S += ChrW(254) + bRestoreToOriginalDirectory.ToString
                S += ChrW(254) + bRestoreToMyDocuments.ToString
                S += ChrW(254) + bCreateOriginalDirIfMissing.ToString
                L.Add(S)
                If Not UseISO Then
                    ProxySearch.scheduleFileDownLoadAsync(_SecureID, CurrentGuid, _UserID, "EMAIL", 0, 1)
                End If
            Next
        End If
        If pRepoTableName.Equals("DataSource") Then
            Dim R As DataGridRow
            For Each R In dgContent.SelectedItems
                iCnt += 1
                CurrentGuid = grid.GetCell(dgEmails, R, "SourceGuid").ToString()
                Dim FileExt As String = grid.GetCell(dgEmails, R, "OriginalFileType").ToString()
                Dim FileFQN As String = grid.GetCell(dgEmails, R, "FQN").ToString()
                Dim FileLength As String = grid.GetCell(dgEmails, R, "FileLength").ToString()
                If InStr(FileExt, ".") = 0 Then
                    FileExt = "." + FileExt
                End If
                S = ""
                S += pRepoTableName.ToUpper
                S += ChrW(254) + CurrentGuid
                S += ChrW(254) + FileExt
                S += ChrW(254) + FileFQN
                S += ChrW(254) + bDoNotOverwriteExistingFile.ToString
                S += ChrW(254) + bOverwriteExistingFile.ToString
                S += ChrW(254) + bRestoreToOriginalDirectory.ToString
                S += ChrW(254) + bRestoreToMyDocuments.ToString
                S += ChrW(254) + bCreateOriginalDirIfMissing.ToString
                L.Add(S)
                If Not UseISO Then
                    ProxySearch.scheduleFileDownLoadAsync(_SecureID, CurrentGuid, _UserID, "CONTENT", 0, 1)
                End If
            Next
        End If
        If pRepoTableName.Equals("EmailAttachment") Then
            Dim R As DataGridRow
            Dim Rowid As String
            For Each R In dgContent.SelectedItems
                iCnt += 1
                Rowid = grid.GetCell(dgContent, R, "RowID").ToString()
                Dim FileExt As String = grid.GetCell(dgContent, R, "OriginalFileType").ToString()
                Dim FileFQN As String = grid.GetCell(dgContent, R, "FQN").ToString()
                Dim FileLength As String = grid.GetCell(dgContent, R, "FileLength").ToString()
                If InStr(FileExt, ".") = 0 Then
                    FileExt = "." + FileExt
                End If
                S = ""
                S += pRepoTableName.ToUpper
                S += ChrW(254) + Rowid
                S += ChrW(254) + FileExt
                S += ChrW(254) + FileFQN
                S += ChrW(254) + bDoNotOverwriteExistingFile.ToString
                S += ChrW(254) + bOverwriteExistingFile.ToString
                S += ChrW(254) + bRestoreToOriginalDirectory.ToString
                S += ChrW(254) + bRestoreToMyDocuments.ToString
                S += ChrW(254) + bCreateOriginalDirIfMissing.ToString
                If Not UseISO Then
                    ProxySearch.scheduleFileDownLoadAsync(_SecureID, Rowid, _UserID, "EMAILATTACHMENT", 0, 1)
                End If
            Next
        End If

        If UseISO Then
            ISO.SaveFileRestoreData(gCurrUserGuidID, L)
        End If

        MessageBox.Show("Restore request posted for " + iCnt.ToString + " files.")

        ISO = Nothing
    End Sub

    ''' <summary>
    ''' Gets the restore stats.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Function getRestoreStats() As String

        Dim CurrentGuid As String = ""
        Dim ISO As New clsIsolatedStorage

        Dim L As New List(Of String)


        Dim FQN As String = "NA"
        Dim iCnt As Integer = 0
        If pRepoTableName.Equals("EmailAttachment") Then
            iCnt = dgEmailAttachment.SelectedItems.Count
        End If
        If pRepoTableName.Equals("Email") Then
            iCnt = dgEmails.SelectedItems.Count
        End If
        If pRepoTableName.Equals("DataSource") Then
            iCnt = dgContent.SelectedItems.Count
        End If
        If iCnt = 0 Then
            MessageBox.Show("To perform a restore, one or more rows must be selected, returning.")
            Return False
        End If
        Dim iSize As Decimal = 0
        Dim S As String = ""
        Dim Unit As String = ""
        Dim Msg As String = ""
        If pRepoTableName.Equals("Email") Then
            Dim R As DataGridRow
            Dim idx As Integer = dgEmails.SelectedIndex
            For Each R In dgEmails.SelectedItems
                Dim sMsgSize As String = grid.GetCellValueAsString(dgEmails, idx, "MsgSize")
                Dim TypeEmail As String = grid.GetCellValueAsString(dgEmails, idx, "SourceTypeCode")
                iSize += CInt(sMsgSize)
                idx += 1
            Next

            setUnits(iSize, Unit)
            Msg = "Emails: " + iCnt.ToString + " - Size: " + iSize.ToString + " " + Unit
            SB.Content = Msg
        End If
        If pRepoTableName.Equals("DataSource") Then
            Dim R As DataGridRow
            Dim idx As Integer = dgContent.SelectedIndex
            For Each R In dgContent.SelectedItems
                Dim FileLength As String = grid.GetCellValueAsString(dgContent, idx, "FileLength")
                iSize += CInt(FileLength)
                idx += 1
            Next
            setUnits(iSize, Unit)
            Msg = "Files: " + iCnt.ToString + " - Size: " + iSize.ToString + " " + Unit
            SB.Content = Msg
        End If
        If pRepoTableName.Equals("EmailAttachment") Then
            Dim R As DataGridRow
            Dim idx As Integer = dgContent.SelectedIndex
            For Each R In dgContent.SelectedItems
                iCnt += 1
                Dim FileLength As String = grid.GetCellValueAsString(dgContent, idx, "FileLength")
                iSize += CInt(FileLength)
                idx += 1
            Next
            setUnits(iSize, Unit)
            Msg = "Files: " + iCnt.ToString + " - Size: " + iSize.ToString + " " + Unit
            SB.Content = Msg
        End If

        ISO.SaveFileRestoreData(gCurrUserGuidID, L)
        ISO = Nothing

        Return Msg

    End Function
    ''' <summary>
    ''' Sets the units.
    ''' </summary>
    ''' <param name="iSize">Size of the i.</param>
    ''' <param name="Unit">The unit.</param>
    Sub setUnits(ByRef iSize As Decimal, ByRef Unit As String)
        If iSize > 100000000000 Then
            Unit = "TB"
            iSize = iSize / 1000000000
            iSize = CDec(iSize.ToString("#0.00"))
            Return
        End If
        If iSize > 1000000000 And iSize < 100000000000 Then
            Unit = "GB"
            iSize = iSize / 1000000000
            iSize = CDec(iSize.ToString("#0.00"))
            Return
        End If
        If iSize > 1000000 And iSize < 1000000000 Then
            Unit = "MB"
            iSize = iSize / 1000000
            iSize = CDec(iSize.ToString("#0.00"))
            Return
        End If
        If iSize < 1000000 Then
            Unit = "KB"
            iSize = iSize / 1000
            iSize = CDec(iSize.ToString("#0.00"))
            Return
        End If
        If iSize < 9999 Then
            Unit = "Bytes"
        End If

    End Sub
    ''' <summary>
    ''' Handles the Checked event of the ckCreateMissing control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckCreateMissing_Checked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckCreateMissing.Checked
        bCreateOriginalDirIfMissing = True
    End Sub

    ''' <summary>
    ''' Handles the Unchecked event of the ckCreateMissing control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub ckCreateMissing_Unchecked(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles ckCreateMissing.Unchecked
        bCreateOriginalDirIfMissing = False
    End Sub

    ''' <summary>
    ''' Handles the 1 event of the rbToOriginalDir_Unchecked control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub rbToOriginalDir_Unchecked_1(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles rbToOriginalDir.Unchecked
        ckCreateMissing.Visibility = Visibility.Collapsed
        bRestoreToOriginalDirectory = False
        ckCreateMissing.IsChecked = False
    End Sub

    ''' <summary>
    ''' Handles the 1 event of the rbToOriginalDir_Checked control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.Windows.RoutedEventArgs"/> instance containing the event data.</param>
    Private Sub rbToOriginalDir_Checked_1(ByVal sender As System.Object, ByVal e As System.Windows.RoutedEventArgs) Handles rbToOriginalDir.Checked
        bRestoreToOriginalDirectory = True
        ckCreateMissing.Visibility = Visibility.Visible
        bRestoreToMyDocuments = False
    End Sub
End Class

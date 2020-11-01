Imports System.IO

Public Class frmPstLoader

    Dim LOG As New clsLogging
    Dim PST As New clsPst
    Dim DBLocal As New clsDbLocal

    Dim ArchiveEmails As Boolean = False

    Public UID As String = ""
    Public Shared CurrIdNbr As Integer = 1000000
    Public Shared FoldersToProcess() As ProcessFolders

    'Sub New(ByVal UserGuidID As String)
    '    UID = UserGuidID
    'End Sub

    Public Structure ProcessFolders
        Dim oFolder As Microsoft.Office.Interop.Outlook.MAPIFolder
        Dim iKey As Integer
    End Structure

    Private Sub btnSelectFile_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSelectFile.Click
        SB.Visible = False
        lbMsg.Visible = False
        btnLoad.Visible = False
        Label2.Visible = False
        txtFoldersProcessed.Visible = False
        Label3.Visible = False
        txtEmailsProcessed.Visible = False
        btnArchive.Visible = False
        Label4.Visible = False
        cbRetention.Visible = False

        OpenFileDialog1.ShowDialog()
        txtPstFqn.Text = OpenFileDialog1.FileName
    End Sub

    Private Sub btnLoad_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLoad.Click
        Try
            lbMsg.Visible = True
            btnLoad.Visible = True
            Label2.Visible = False
            txtFoldersProcessed.Visible = False
            Label3.Visible = False
            txtEmailsProcessed.Visible = False
            btnArchive.Visible = True
            Label4.Visible = True
            cbRetention.Visible = True

            ArchiveEmails = False
Dim pName AS String  = "Test" 
Dim PstFQN AS String  = txtPstFqn.Text.Trim 
            Dim F As File
            If Not F.Exists(PstFQN ) Then
                messagebox.show("Cannot find file '" + PstFQN  + "', aborting load.")
                Return
            End If

            PST.PstStats(Me.lbMsg, PstFQN, pName , ArchiveEmails)

        Catch ex As Exception
            messagebox.show("Error: PST Load error - " + ex.Message)
            log.WriteToArchiveLog("Error: PST Load error - " + ex.Message)
        End Try

    End Sub

    Private Sub btnArchive_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnArchive.Click
        If cbLibrary.Text.Trim.Length = 0 Then
            messagebox.show("In order to ARCHIVE a PST file, a library must be selected, returning.")
            Return
        End If
        If cbRetention.Text.Trim.Length = 0 Then
            messagebox.show("Please select a retention period, returning.")
            Return
        End If

        lbMsg.Visible = True
        btnLoad.Visible = True
        Label2.Visible = True
        txtFoldersProcessed.Visible = True
        Label3.Visible = True
        txtEmailsProcessed.Visible = True
        btnArchive.Visible = True

Dim PstFQN AS String  = Me.txtPstFqn.Text.Trim 
Dim RetentionCode AS String  

        If lbMsg.SelectedItems.Count = 0 Then
            messagebox.show("Cannot process without FOLDERS being selected, returning.")
            Return
        End If
        If PstFQN .Length = 0 Then
            messagebox.show("Cannot process without a PST file being selected, returning.")
            Return
        End If

Dim rCode AS String  = cbRetention.Text.Trim 
        '***************************************************************
        Dim bUseQuickSearch As Boolean = False
        Dim DBARCH As New clsDatabaseARCH
        Dim NbrOfIds As Integer = DBARCH.getCountStoreIdByFolder()
        Dim slStoreId As New SortedList
        If NbrOfIds <= 5000000 Then
            bUseQuickSearch = True
        Else
            bUseQuickSearch = False
        End If
        If bUseQuickSearch Then
            DBLocal.getCE_EmailIdentifiers(slStoreId)
        Else
            slStoreId.Clear()
        End If
        '***************************************************************
        PST.ArchiveSelectedFolders(UID, Me.lbMsg, PstFQN, rCode, cbLibrary.Text, slStoreId)

        frmMain.SB.Text = "Done"
        SB.Text = "Done"

    End Sub

    Private Sub frmPstLoader_Deactivate(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Deactivate
        'PST.RemoveStores()
    End Sub

    Private Sub frmPstLoader_Disposed(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Disposed
        PST.RemoveStores()
    End Sub

    Private Sub frmPstLoader_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        lbMsg.Visible = False
        btnLoad.Visible = False
        Label2.Visible = False
        txtFoldersProcessed.Visible = False
        Label3.Visible = False
        txtEmailsProcessed.Visible = False
        btnArchive.Visible = False
        Label4.Visible = False
        cbRetention.Visible = False

        Dim ARCH As New clsArchiver
        ARCH.LoadRetentionCodes(cbRetention)
        ARCH = Nothing

        If cbRetention.Items.Count > 0 Then
            cbRetention.Text = cbRetention.Items(0)
        End If
        PopulateLibrary()
    End Sub

    Private Sub txtPstFqn_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtPstFqn.TextChanged
        lbMsg.Visible = False
        btnLoad.Visible = True
        Label2.Visible = False
        txtFoldersProcessed.Visible = False
        Label3.Visible = False
        txtEmailsProcessed.Visible = False
        btnArchive.Visible = False
        SB.Visible = True
    End Sub
    Sub PopulateLibrary()
        Dim DBARCH As New clsDatabaseARCH
        Me.Cursor = Cursors.WaitCursor
        DBARCH.PopulateGroupUserLibCombo(Me.cbLibrary)
        Me.Cursor = Cursors.Default
        DBARCH = Nothing
    End Sub

    Private Sub btnRemove_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRemove.Click
        PST.RemoveStores()
    End Sub
End Class

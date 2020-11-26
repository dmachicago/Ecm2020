Imports System.Data.SqlClient


Public Class frmSenderMgt
    Dim ARCH As New clsArchiver
Dim UserID AS String  = "" 
Dim MySql AS String  = "" 
    Dim DMA As New clsDma

    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim DBARCH As New clsDatabaseARCH
    Dim ds As New DataSet
    Dim cn As New SqlConnection
    Dim EF As New clsEXCLUDEFROM
    Dim bHelpLoaded As Boolean = False
    Dim Formloaded As Boolean = False
    Private Sub frmSenderMgt_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Formloaded = False
        GetLocation(Me)

        If HelpOn Then
            DBARCH.getFormTooltips(Me, TT, True)
            TT.Active = True
            bHelpLoaded = True
        Else
            TT.Active = False
        End If
        Timer1.Enabled = True
        Timer1.Interval = 5000

        'Dim bGetScreenObjects As Boolean = True
        'If bGetScreenObjects Then DMA.getFormWidgets(Me)

        ''TODO: This line of code loads data into the '_DMA_UDDataSet3.ArchiveFrom' table. You can move, or remove it, as needed.
        'Me.ArchiveFromTableAdapter.Fill(Me._DMA_UDDataSet3.ArchiveFrom)
        ''TODO: This line of code loads data into the '_DMA_UDDataSet.ExcludeFrom' table. You can move, or remove it, as needed.
        'Me.ExcludeFromTableAdapter.Fill(Me._DMA_UDDataSet.ExcludeFrom)
        'MySql  = ""
        'MySql  = MySql  + " SELECT [FromEmailAddr] "
        'MySql  = MySql  + " ,[SenderName] "
        'MySql  = MySql  + " ,[UserID] "
        'MySql  = MySql  + " FROM  [ExcludeFrom] "
        'MySql  = MySql  + " where [UserID] = '" + gCurrUserGuidID + "' "
        'MySql  = MySql  + " order by  "
        'MySql  = MySql  + " FromEmailAddr "
        'MySql  = MySql  + " ,[SenderName] "
        'MySql  = MySql  + " ,[UserID] "

        'Dim qConnStr  = DBARCH.getConnStr

        'cn.ConnectionString = qConnStr 
        'cn.Open()

        'Dim dscmd As New SqlDataAdapter(MySql, cn)

        'dscmd.Fill(ds, "Senders")
        'dgExcludedSenders.DataSource = ds.DefaultViewManager

        ARCH.getOutlookParentFolderNames(Me.cbOutlookFOlder)

        TT.SetToolTip(btnRemoveExcluded, "Press this button to remove the selected address from the 'exclude list'.")
        TT.Active = True

        ARCH.PopulateExcludedSendersFromTbl(dgExcludedSenders)
        Formloaded = True
    End Sub

    Private Sub btnRemoveExcluded_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRemoveExcluded.Click
        Dim II As Integer = 0
        For II = 0 To dgExcludedSenders.RowCount - 1

            If dgExcludedSenders.Rows(II).Selected Then

                Dim SenderEmailAddress As String = dgExcludedSenders.Item(0, II).Value.ToString
                Dim SenderName As String = dgExcludedSenders.Item(1, II).Value.ToString
                Dim UID As String = dgExcludedSenders.Item(2, II).Value.ToString

                SenderEmailAddress = UTIL.RemoveSingleQuotes(SenderEmailAddress)
                SenderName = UTIL.RemoveSingleQuotes(SenderName)
                UID = UTIL.RemoveSingleQuotes(UID)

                Dim S As String = "Select count(*) "
                S = S + " FROM  [ExcludeFrom]"
                S = S + " where [FromEmailAddr] = '" + SenderEmailAddress + "'"
                S = S + " and [SenderName] = '" + SenderName + "'"
                S = S + " and [UserID] = '" + UID + "'"
                Dim K As Integer = DBARCH.iDataExist(S)
                If K = 1 Then
                    S = "delete "
                    S = S + " FROM  [ExcludeFrom]"
                    S = S + " where [FromEmailAddr] = '" + SenderEmailAddress + "'"
                    S = S + " and [SenderName] = '" + SenderName + "'"
                    S = S + " and [UserID] = '" + UID + "'"
                    Dim BB As Boolean = DBARCH.ExecuteSqlNewConn(S, False)
                    If Not BB Then
                        MessageBox.Show("Error 243.1: Delete failed - " + Environment.NewLine + S)
                    End If
                End If
            End If
        Next
        ARCH.PopulateExcludedSendersFromTbl(dgExcludedSenders)
        DBARCH.getExcludedEmails(gCurrUserGuidID)
    End Sub
    Private Sub btnRemoveIncluded_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)

    End Sub
    Private Sub btnInclSender_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)

    End Sub
    Private Sub btnExclSender_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExclSender.Click
        Dim II As Integer = 0
        For II = 0 To dgEmailSenders.RowCount - 1
            If dgEmailSenders.Rows(II).Selected Then

                Dim SenderEmailAddress As String = dgEmailSenders.Item(0, II).Value.ToString
                Dim SenderName As String = dgEmailSenders.Item(1, II).Value.ToString
                Dim UID As String = dgEmailSenders.Item(2, II).Value.ToString

                SenderEmailAddress = UTIL.RemoveSingleQuotes(SenderEmailAddress)
                SenderName = UTIL.RemoveSingleQuotes(SenderName)
                UID = UTIL.RemoveSingleQuotes(UID)

                Dim S As String = "Select count(*)"
                S = S + " FROM  [ExcludeFrom]"
                S = S + " where [FromEmailAddr] = '" + SenderEmailAddress + "'"
                S = S + " and [SenderName] = '" + SenderName + "'"
                S = S + " and [UserID] = '" + UID + "'"
                Dim K As Integer = DBARCH.iDataExist(S)
                If K = 0 Then
                    EF.setFromemailaddr(SenderEmailAddress)
                    EF.setSendername(SenderName)
                    EF.setUserid(UID)

                    Dim BB As Boolean = EF.Insert()
                    If Not BB Then
                        MessageBox.Show("Error 243.1: Insert failed - " + Environment.NewLine + S)
                    End If
                End If
            End If
        Next
        ARCH.PopulateExcludedSendersFromTbl(dgExcludedSenders)
        DBARCH.getExcludedEmails(gCurrUserGuidID)
    End Sub
    Private Sub rbArchive_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rbArchive.CheckedChanged
        If rbArchive.Checked = True Then
            Dim S As String = ""
            S = "Select distinct [SenderEmailAddress]"
            S = S + " ,[SenderName]      "
            S = S + " FROM [Email]"
            S = S + " order by [SenderEmailAddress]"
            S = S + " ,[SenderName]      "

            ARCH.PopulateContactGrid(dgEmailSenders, S)

        End If
    End Sub

    Private Sub rbContacts_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rbContacts.CheckedChanged
        If rbContacts.Checked = True Then
            'MySql  = ""
            'MySql  = MySql  + " SELECT [FromEmailAddr] "
            'MySql  = MySql  + " ,[SenderName] "
            'MySql  = MySql  + " ,[UserID] "
            'MySql  = MySql  + " FROM  [ContactFrom] "
            'MySql  = MySql  + " where [UserID] = '" + gCurrUserGuidID + "' "
            'MySql  = MySql  + " order by  "
            'MySql  = MySql  + " FromEmailAddr "
            'MySql  = MySql  + " ,[SenderName] "
            'MySql  = MySql  + " ,[UserID] "

            Dim S As String = ""
            S = S + " SELECT FromEmailAddr ,[SenderName]   "
            S = S + " FROM  [ContactFrom]  "
            S = S + " order by FromEmailAddr ,[SenderName]  "

            ARCH.PopulateContactGrid(dgEmailSenders, S)
        End If
    End Sub

    Private Sub ExcludeFromBindingSource_CurrentChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)

    End Sub

    Private Sub rbInbox_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rbInbox.CheckedChanged

        If rbInbox.Checked Then
            'MySql  = ""
            'MySql  = MySql  + " SELECT [FromEmailAddr] "
            'MySql  = MySql  + " ,[SenderName] "
            'MySql  = MySql  + " ,[UserID] "
            'MySql  = MySql  + " FROM  [OutlookFrom] "
            'MySql  = MySql  + " where [UserID] = '" + gCurrUserGuidID + "' "
            'MySql  = MySql  + " order by  "
            'MySql  = MySql  + " FromEmailAddr "
            'MySql  = MySql  + " ,[SenderName] "
            'MySql  = MySql  + " ,[UserID] "

            Dim S As String = ""
            S = "Select FromEmailAddr ,[SenderName]"
            S = S + " FROM  [OutlookFrom]  "
            S = S + " order by FromEmailAddr ,[SenderName]"

            ARCH.PopulateContactGrid(dgEmailSenders, S)
        End If

    End Sub

    Private Sub btnRefresh_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRefresh.Click

        Dim FileDirectory As String = cbOutlookFOlder.Text

        If rbInbox.Checked Then

            If cbOutlookFOlder.Text.Trim.Length = 0 Then
                MessageBox.Show("Please select an OUTLOOK mailbox first.")
                Return
            End If

            Dim SL As New SortedList
            Dim TopFolder As String = cbOutlookFOlder.Text

            Dim LB As New ListBox

            Dim SenderFrom As String = ""
            Dim SenderName As String = ""
            Dim k As Integer = 0

            MySql = MySql + " Update  [OutlookFrom]"
            MySql = MySql + " set [Verified] = 0 "
            MySql = MySql + " where "
            MySql = MySql + " UserID = '" + gCurrUserGuidID + "'"
            Dim bSuccess As Boolean = DBARCH.ExecuteSqlNewConn(MySql, False)
            If Not bSuccess Then
                Debug.Print("Update failed:" + Environment.NewLine + MySql)
            End If
            ARCH.ProcessOutlookFolderNames(FileDirectory, TopFolder, LB)
            'ARCH.GetActiveEmailSenders(gCurrUserGuidID, MailboxName )
            'ARCH.PopulateContactGridOutlookFromTbl(dgEmailSenders)

        End If

        If rbArchive.Checked = True Then
            Dim S As String = ""
            S = "Select distinct [SenderEmailAddress]"
            S = S + " ,[SenderName]      "
            S = S + " FROM [Email]"
            S = S + " order by [SenderEmailAddress]"
            S = S + " ,[SenderName]      "

            ARCH.PopulateContactGrid(dgEmailSenders, S)
        End If

        If rbContacts.Checked = True Then
            MySql = MySql + " Update  [ContactFrom]"
            MySql = MySql + " set [Verified] = 0 "
            MySql = MySql + " where "
            MySql = MySql + " UserID = '" + gCurrUserGuidID + "'"
            Dim bSuccess As Boolean = DBARCH.ExecuteSqlNewConn(MySql, False)
            If Not bSuccess Then
                Debug.Print("Update failed:" + Environment.NewLine + MySql)
            End If

            ARCH.RetrieveContactEmailInfo(dgEmailSenders, gCurrUserGuidID)
            ARCH.PopulateContactGridContactFromTbl(dgEmailSenders)
            'ARCH.GetActiveEmailSenders(gCurrUserGuidID, "Personal Folders")
        End If
        DBARCH.getExcludedEmails(gCurrUserGuidID)
    End Sub

    Private Sub Timer1_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Timer1.Tick

        'If HelpOn Then
        '    If bHelpLoaded Then
        '        TT.Active = True
        '    Else
        '        DBARCH.getFormTooltips(Me, TT, True)
        '        TT.Active = True
        '        bHelpLoaded = True
        '    End If
        'Else
        '    TT.Active = False
        'End If
        'Application.DoEvents()
    End Sub

    Private Sub frmSenderMgt_Resize(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Resize

        If formloaded = false then return 
        ResizeControls(me)

    End Sub
End Class

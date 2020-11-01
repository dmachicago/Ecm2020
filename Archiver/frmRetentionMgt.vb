Imports System.Data.SqlClient
Imports System.IO

Public Class frmRetentionMgt
    'Dim SHIST As New clsSEARCHHISTORY
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim DG As New clsDataGrid
    Dim bHelpLoaded As Boolean = False
    Dim FormLoaded As Boolean = False

    Dim LOG As New clsLogging

    Private Sub ToolTip1_Popup(ByVal sender As System.Object, ByVal e As System.Windows.Forms.PopupEventArgs) Handles TT.Popup

    End Sub

    Private Sub frmRetentionMgt_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
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

        btnRecall.Enabled = False
        btnRecall.Text = "Load Marked EMAIL Retention Items"

    End Sub
    Sub PopulateGrid(ByVal MySql As String)
        Dim StartTime As Date = Now

        'System.Windows.Forms.DataGridViewCellEventArgs
        Try
            SB.Text = ""
            Dim BS As New BindingSource

            Dim CS As String = DBARCH.setConnStr()
            Dim sqlcn As New SqlConnection(CS)
            Dim sadapt As New SqlDataAdapter(MySql, sqlcn)
            Dim ds As DataSet = New DataSet

            'Me.DsDocumentSearch.Reset()

            If sqlcn.State = ConnectionState.Closed Then
                sqlcn.Open()
            End If

            sadapt.Fill(ds, "DataSource")
            SB.Text = "Returned Items: " + ds.Tables("DataSource").Rows.Count.ToString

            dgItems.DataSource = Nothing
            dgItems.DataSource = ds.Tables("DataSource")

            'SHIST.setCalledfrom(Me.Name)
            'SHIST.setEndtime(Now.ToString)
            'SHIST.setReturnedrows(Me.dgItems.RowCount)
            'SHIST.setTypesearch("PopulateGrid")
            'SHIST.setStarttime(StartTime.ToString)
            'SHIST.setSearchdate(Now.ToString)
            'SHIST.setSearchsql(MySql )
            'SHIST.setUserid(gCurrUserGuidID)
            'Dim b As Boolean = SHIST.Insert
            'If Not b Then
            '    Debug.Print("Error 1943.23b - Failed to save history of search.")
            'End If

        Catch ex As Exception
            MsgBox("Search Error 165.4x: " + ex.Message)
            LOG.WriteToSqlLog("Search Error 165.4: " + ex.Message + vbCrLf + MySql)
        End Try


    End Sub

    Private Sub btnExecuteExpire_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExecuteExpire.Click
        Dim S As String = ""
        Dim UnitQty As Integer = Val(txtExpireUnit.Text)
        Dim Unit As String = cbExpireUnits.Text
        Dim CurrDate As Date = Now
        Dim FutureDate As Date

        If rbEmails.Checked = True Then
            S = S + " SELECT "
            S = S + " [SentOn] " + vbCrLf
            S = S + " ,[ShortSubj]" + vbCrLf
            S = S + " ,[SenderEmailAddress]" + vbCrLf
            S = S + " ,[SenderName]" + vbCrLf
            S = S + " ,[SentTO]" + vbCrLf
            S = S + " ,[Body] " + vbCrLf
            S = S + " ,[CC] " + vbCrLf
            S = S + " ,[Bcc] " + vbCrLf
            S = S + " ,[CreationTime]" + vbCrLf
            S = S + " ,[AllRecipients]" + vbCrLf
            S = S + " ,[ReceivedByName]" + vbCrLf
            S = S + " ,[ReceivedTime] " + vbCrLf
            S = S + " ,[MsgSize]" + vbCrLf
            S = S + " ,[SUBJECT]" + vbCrLf
            S = S + " ,[OriginalFolder] " + vbCrLf
            S = S + " ,[EmailGuid], RetentionExpirationDate, isPublic, UserID " + vbCrLf
            S = S + " FROM EMAIL " + vbCrLf
        Else
            S = ""
            S = S + "Select " + vbCrLf
            S += vbTab + "[SourceName] 	" + vbCrLf
            S += vbTab + ",[CreateDate] " + vbCrLf
            S += vbTab + ",[VersionNbr] 	" + vbCrLf
            S += vbTab + ",[LastAccessDate] " + vbCrLf
            S += vbTab + ",[FileLength] " + vbCrLf
            S += vbTab + ",[LastWriteTime] " + vbCrLf
            S += vbTab + ",[OriginalFileType] 		" + vbCrLf
            S += vbTab + ",[isPublic] " + vbCrLf
            S += vbTab + ",[FQN] " + vbCrLf
            S += vbTab + ",[SourceGuid] " + vbCrLf
            S += vbTab + ",[DataSourceOwnerUserID], FileDirectory, RetentionExpirationDate, isMaster " + vbCrLf
            S += "FROM DataSource " + vbCrLf
        End If

        If Unit.Equals("Months") Then
            FutureDate = CurrDate.AddMonths(UnitQty)
        ElseIf Unit.Equals("Days") Then
            FutureDate = CurrDate.AddDays(UnitQty)
        ElseIf Unit.Equals("Years") Then
            FutureDate = CurrDate.AddYears(UnitQty)
        Else
            Return
        End If
        Dim WC As String = " where RetentionExpirationDate <= '" + CDate(FutureDate.ToString) + "'"
        S = S + WC
        Me.PopulateGrid(S)

    End Sub

    Private Sub btnExecuteAge_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExecuteAge.Click

        Dim S As String = ""

        Dim UnitQty As Integer = Val(txtExpireUnit.Text)
        Dim Unit As String = cbExpireUnits.Text
        Dim CurrDate As Date = Now
        Dim PastDate As Date

        If rbEmails.Checked = True Then
            S = S + " SELECT "
            S = S + " [SentOn] " + vbCrLf
            S = S + " ,[ShortSubj]" + vbCrLf
            S = S + " ,[SenderEmailAddress]" + vbCrLf
            S = S + " ,[SenderName]" + vbCrLf
            S = S + " ,[SentTO]" + vbCrLf
            S = S + " ,[Body] " + vbCrLf
            S = S + " ,[CC] " + vbCrLf
            S = S + " ,[Bcc] " + vbCrLf
            S = S + " ,[CreationTime]" + vbCrLf
            S = S + " ,[AllRecipients]" + vbCrLf
            S = S + " ,[ReceivedByName]" + vbCrLf
            S = S + " ,[ReceivedTime] " + vbCrLf
            S = S + " ,[MsgSize]" + vbCrLf
            S = S + " ,[SUBJECT]" + vbCrLf
            S = S + " ,[OriginalFolder] " + vbCrLf
            S = S + " ,[EmailGuid], RetentionExpirationDate, isPublic, UserID " + vbCrLf
            S = S + " FROM EMAIL " + vbCrLf
        Else
            S = ""
            S = S + "Select " + vbCrLf
            S += vbTab + "[SourceName] 	" + vbCrLf
            S += vbTab + ",[CreateDate] " + vbCrLf
            S += vbTab + ",[VersionNbr] 	" + vbCrLf
            S += vbTab + ",[LastAccessDate] " + vbCrLf
            S += vbTab + ",[FileLength] " + vbCrLf
            S += vbTab + ",[LastWriteTime] " + vbCrLf
            S += vbTab + ",[OriginalFileType] 		" + vbCrLf
            S += vbTab + ",[isPublic] " + vbCrLf
            S += vbTab + ",[FQN] " + vbCrLf
            S += vbTab + ",[SourceGuid] " + vbCrLf
            S += vbTab + ",[DataSourceOwnerUserID], FileDirectory, RetentionExpirationDate, isMaster " + vbCrLf
            S += "FROM DataSource " + vbCrLf
        End If

        If Unit.Equals("Months") Then
            Dim TotalDays As Integer = 30 * UnitQty
            Dim Days As New TimeSpan(TotalDays, 0, 0, 0)
            PastDate = CurrDate.Subtract(Days)
        ElseIf Unit.Equals("Days") Then
            Dim TotalDays As Integer = 1 * UnitQty
            Dim Days As New TimeSpan(TotalDays, 0, 0, 0)
            PastDate = CurrDate.Subtract(Days)
        ElseIf Unit.Equals("Years") Then
            Dim TotalDays As Integer = 365.25 * UnitQty
            Dim Days As New TimeSpan(TotalDays, 0, 0, 0)
            PastDate = CurrDate.Subtract(Days)
        Else
            Return
        End If
        Dim WC As String = " where CreationDate <= '" + CDate(PastDate.ToString) + "'"
        S = S + WC
        Me.PopulateGrid(S)
    End Sub

    Private Sub btnSelectExpired_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSelectExpired.Click
        Dim S As String = ""
        Dim UnitQty As Integer = Val(txtExpireUnit.Text)
        Dim Unit As String = cbExpireUnits.Text
        Dim CurrDate As Date = Now
        Dim FutureDate As Date = Now

        If rbEmails.Checked = True Then
            S = S + " SELECT "
            S = S + " [SentOn] " + vbCrLf
            S = S + " ,[ShortSubj]" + vbCrLf
            S = S + " ,[SenderEmailAddress]" + vbCrLf
            S = S + " ,[SenderName]" + vbCrLf
            S = S + " ,[SentTO]" + vbCrLf
            S = S + " ,[Body] " + vbCrLf
            S = S + " ,[CC] " + vbCrLf
            S = S + " ,[Bcc] " + vbCrLf
            S = S + " ,[CreationTime]" + vbCrLf
            S = S + " ,[AllRecipients]" + vbCrLf
            S = S + " ,[ReceivedByName]" + vbCrLf
            S = S + " ,[ReceivedTime] " + vbCrLf
            S = S + " ,[MsgSize]" + vbCrLf
            S = S + " ,[SUBJECT]" + vbCrLf
            S = S + " ,[OriginalFolder] " + vbCrLf
            S = S + " ,[EmailGuid], RetentionExpirationDate, isPublic, UserID " + vbCrLf
            S = S + " FROM EMAIL " + vbCrLf
        Else
            S = ""
            S = S + "Select " + vbCrLf
            S += vbTab + "[SourceName] 	" + vbCrLf
            S += vbTab + ",[CreateDate] " + vbCrLf
            S += vbTab + ",[VersionNbr] 	" + vbCrLf
            S += vbTab + ",[LastAccessDate] " + vbCrLf
            S += vbTab + ",[FileLength] " + vbCrLf
            S += vbTab + ",[LastWriteTime] " + vbCrLf
            S += vbTab + ",[OriginalFileType] 		" + vbCrLf
            S += vbTab + ",[isPublic] " + vbCrLf
            S += vbTab + ",[FQN] " + vbCrLf
            S += vbTab + ",[SourceGuid] " + vbCrLf
            S += vbTab + ",[DataSourceOwnerUserID], FileDirectory, RetentionExpirationDate, isMaster " + vbCrLf
            S += "FROM DataSource " + vbCrLf
        End If

        Dim WC As String = " where RetentionExpirationDate <= '" + CDate(Now.ToString) + "'"
        S = S + WC
        Me.PopulateGrid(S)
    End Sub

    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        Dim msg As String = "This will delete the selected items, are you sure, really sure?"
        Dim dlgRes As DialogResult = MessageBox.Show(msg, "UNDOABLE DELETE of Content", MessageBoxButtons.YesNo)
        If dlgRes = Windows.Forms.DialogResult.No Then
            Return
        End If

        PB.Value = 0
        PB.Maximum = dgItems.SelectedRows.Count + 1
        Dim II As Integer = 0

        Dim SuccessfulDelete As Integer = 0
        Dim FailedDelete As Integer = 0

        Dim uidList As New ArrayList
        Dim DR As DataRow = Nothing
        Dim CurrGuid As String = ""
        Dim S As String = ""
        Dim B As Boolean = False
        For Each DR In dgItems.SelectedRows
            II += 1
            PB.Value = II
            PB.Refresh()
            System.Windows.Forms.Application.DoEvents()
            If rbEmails.Checked = True Then
                CurrGuid = DR.Item("EmailGuid").ToString
                uidList.Add(CurrGuid)
            Else
                CurrGuid = DR.Item("SourceGuid").ToString
                uidList.Add(CurrGuid)
            End If
        Next

        For i As Integer = 0 To uidList.Count - 1
            If rbEmails.Checked = True Then
                CurrGuid = uidList(i).ToString
                S = "delete from emailattachment where EmailGuid = '" + CurrGuid + "'"
                B = DBARCH.ExecuteSqlNewConn(S, False)

                S = "delete from Recipients where EmailGuid = '" + CurrGuid + "'"
                B = DBARCH.ExecuteSqlNewConn(S, False)

                S = "delete from email  where EmailGuid = '" + CurrGuid + "'"
                B = DBARCH.ExecuteSqlNewConn(S, False)
                If B Then
                    SuccessfulDelete += 1
                Else
                    FailedDelete += 1
                End If
            Else

                CurrGuid = uidList(i).ToString
                S = "DELETE from SourceAttribute where SourceGuid = '" + CurrGuid + "'"
                B = DBARCH.ExecuteSqlNewConn(S, False)

                S = "DELETE from DataSource where SourceGuid = '" + CurrGuid + "'"
                B = DBARCH.ExecuteSqlNewConn(S, False)
                If B Then
                    SuccessfulDelete += 1
                Else
                    FailedDelete += 1
                End If
            End If
        Next
        PB.Value = 0
        SB.Text = "Deleted = " + SuccessfulDelete.ToString + " - A12 Failed to delete = " + FailedDelete.ToString
    End Sub

    Private Sub btnMove_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnMove.Click
        MsgBox("This item is in a future release...")
    End Sub

    Private Sub btnExtend_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExtend.Click
        Dim SuccessfulDelete As Integer = 0
        Dim FailedDelete As Integer = 0

        Dim uidList As New ArrayList
        Dim DR As DataGridViewRow = Nothing
        Dim CurrGuid As String = ""
        Dim S As String = ""
        Dim B As Boolean = False
        Dim NewDate As Date = CDate(dtExtendDate.Value.ToLongDateString)
        Dim iSelected As Integer = dgItems.SelectedRows.Count
        If iSelected = 0 Then
            MsgBox("One or more items must be selected to extend, returning.")
            Return
        End If
        For Each DR In dgItems.SelectedRows
            If rbEmails.Checked = True Then
                CurrGuid = DR.Cells("EmailGuid").Value.ToString
                uidList.Add(CurrGuid)
            Else
                CurrGuid = DR.Cells("SourceGuid").Value.ToString
                uidList.Add(CurrGuid)
            End If
        Next

        For i As Integer = 0 To uidList.Count - 1
            If rbEmails.Checked = True Then
                CurrGuid = uidList(i).ToString
                S = "update email set  RetentionExpirationDate = '" + NewDate.ToString + "' where EmailGuid = '" + CurrGuid + "'"
                B = DBARCH.ExecuteSqlNewConn(S, False)
                If B Then
                    SuccessfulDelete += 1
                Else
                    FailedDelete += 1
                End If
            Else
                CurrGuid = uidList(i).ToString
                S = "update DataSource set  RetentionExpirationDate = '" + NewDate.ToString + "' where SourceGuid = '" + CurrGuid + "'"
                B = DBARCH.ExecuteSqlNewConn(S, False)
                If B Then
                    SuccessfulDelete += 1
                Else
                    FailedDelete += 1
                End If
            End If
        Next
        SB.Text = "Updated = " + SuccessfulDelete.ToString + " - Failed to update = " + FailedDelete.ToString
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
        'System.Windows.Forms.Application.DoEvents()
    End Sub

    Private Sub btnRecall_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRecall.Click
        Dim S As String = ""

        Dim UnitQty As Integer = Val(txtExpireUnit.Text)
        Dim Unit As String = cbExpireUnits.Text
        Dim CurrDate As Date = Now
        'Dim PastDate As Date

        Dim WC As String = ""

        If rbEmails.Checked = True Then
            S = S + " SELECT "
            S = S + " [SentOn] " + vbCrLf
            S = S + " ,[ShortSubj]" + vbCrLf
            S = S + " ,[SenderEmailAddress]" + vbCrLf
            S = S + " ,[SenderName]" + vbCrLf
            S = S + " ,[SentTO]" + vbCrLf
            S = S + " ,[Body] " + vbCrLf
            S = S + " ,[CC] " + vbCrLf
            S = S + " ,[Bcc] " + vbCrLf
            S = S + " ,[CreationTime]" + vbCrLf
            S = S + " ,[AllRecipients]" + vbCrLf
            S = S + " ,[ReceivedByName]" + vbCrLf
            S = S + " ,[ReceivedTime] " + vbCrLf
            S = S + " ,[MsgSize]" + vbCrLf
            S = S + " ,[SUBJECT]" + vbCrLf
            S = S + " ,[OriginalFolder] " + vbCrLf
            S = S + " ,[EmailGuid], RetentionExpirationDate, isPublic, UserID " + vbCrLf
            S = S + " FROM EMAIL " + vbCrLf

            WC = " where EmailGuid in (select [ContentGuid] from [RetentionTemp] where [TypeContent] = 'EMAIL' and [UserID] = '" + gCurrUserGuidID + "')"

        Else
            S = ""
            S = S + "Select " + vbCrLf
            S += vbTab + "[SourceName] 	" + vbCrLf
            S += vbTab + ",[CreateDate] " + vbCrLf
            S += vbTab + ",[VersionNbr] 	" + vbCrLf
            S += vbTab + ",[LastAccessDate] " + vbCrLf
            S += vbTab + ",[FileLength] " + vbCrLf
            S += vbTab + ",[LastWriteTime] " + vbCrLf
            S += vbTab + ",[OriginalFileType] 		" + vbCrLf
            S += vbTab + ",[isPublic] " + vbCrLf
            S += vbTab + ",[FQN] " + vbCrLf
            S += vbTab + ",[SourceGuid] " + vbCrLf
            S += vbTab + ",[DataSourceOwnerUserID], FileDirectory, RetentionExpirationDate, isMaster " + vbCrLf
            S += "FROM DataSource " + vbCrLf

            WC = " where SourceGuid in (select [ContentGuid] from [RetentionTemp] where [TypeContent] = 'CONTENT' and [UserID] = '" + gCurrUserGuidID + "')"

        End If

        S = S + WC
        Me.PopulateGrid(S)
    End Sub

    Private Sub rbContent_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rbContent.CheckedChanged
        If rbContent.Checked Then
            Dim iCnt As Integer = DBARCH.RetentionTempCountType("CONTENT", gCurrUserGuidID)
            If iCnt > 0 Then
                btnRecall.Enabled = True
                'btnRecall.Visible = True
                btnRecall.Text = "Load Marked CONTENT Retention Items"
            Else
                btnRecall.Enabled = False
                'btnRecall.Visible = True
                btnRecall.Text = "Load Marked CONTENT Retention Items"
            End If
        End If
    End Sub

    Private Sub rbEmails_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rbEmails.CheckedChanged
        If rbEmails.Checked Then
            Dim iCnt As Integer = DBARCH.RetentionTempCountType("EMAIL", gCurrUserGuidID)
            If iCnt > 0 Then
                btnRecall.Enabled = True
                'btnRecall.Visible = True
                btnRecall.Text = "Load Marked EMAIL Retention Items"
            Else
                btnRecall.Enabled = False
                'btnRecall.Visible = True
                btnRecall.Text = "Load Marked EMAIL Retention Items"
            End If
        End If
    End Sub

    Private Sub frmRetentionMgt_Resize(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Resize

        If formloaded = false then return 
        ResizeControls(me)

    End Sub
End Class

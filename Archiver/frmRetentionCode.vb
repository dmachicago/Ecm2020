Public Class frmRetentionCode

    Dim DBARCH As New clsDatabaseARCH
    Dim RC As Boolean = False

    ''' <summary>
    ''' Handles the Load event of the frmRetentionCode control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.EventArgs" /> instance containing the event data.</param>
    Private Sub frmRetentionCode_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load
        GetRetentionCodes()
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnSave control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.EventArgs" /> instance containing the event data.</param>
    Private Sub btnSave_Click(sender As System.Object, e As System.EventArgs) Handles btnSave.Click

        Dim RetentionCode = txtRetentionCode.Text
        Dim RetentionDesc = txtDesc.Text
        Dim ManagerID As String = txtManagerID.Text
        Dim RetentionUnits As Integer = nbrRetentionUnits.Value
        Dim DaysWarning As Integer = nbrDaysWarning.Value
        Dim RetentionPeriod As String = cbRetentionPeriod.Text
        Dim RetentionAction As String = cbRetentionAction.Text
        Dim ResponseRequired As String = ""
        If ckResponseRequired.Checked Then
            ResponseRequired = "Y"
        Else
            ResponseRequired = "N"
        End If

        Dim B As Boolean = DBARCH.Save_RetentionCode(gGateWayID,
                                       RetentionCode,
                                       RetentionDesc,
                                       RetentionUnits,
                                       RetentionAction,
                                       ManagerID,
                                       DaysWarning,
                                       ResponseRequired,
                                       RetentionPeriod,
                                       RC)

        If B Then
            SB.Text = RetentionCode + " Saved."
            GetRetentionCodes()
        Else
            SB.Text = RetentionCode + " NOT Saved."
        End If

    End Sub

    ''' <summary>
    ''' Gets the retention codes.
    ''' </summary>
    Sub GetRetentionCodes()

        Dim RC As Boolean = True

        Dim RssBindingSource As New BindingSource
        RssBindingSource.DataSource = DBARCH.GET_RetentionCodes(gGateWayID, RC)
        dgRetention.DataSource = RssBindingSource

    End Sub


    ''' <summary>
    ''' Handles the SelectionChanged event of the dgRetention control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.EventArgs" /> instance containing the event data.</param>
    Private Sub dgRetention_SelectionChanged(sender As System.Object, e As System.EventArgs) Handles dgRetention.SelectionChanged
        Dim I As Integer = dgRetention.SelectedRows.Count
        If I = 1 Then
            Dim DR As DataGridViewRow = dgRetention.SelectedRows(0)
            txtRetentionCode.Text = DR.Cells("RetentionCode").Value.ToString
            txtDesc.Text = DR.Cells("RetentionDesc").Value.ToString
            nbrRetentionUnits.Value = DR.Cells("RetentionUnits").Value.ToString
            If DR.Cells("DaysWarning").Value Is Nothing Then
                nbrDaysWarning.Value = 14
            Else
                Try
                    nbrDaysWarning.Value = DR.Cells("DaysWarning").Value
                Catch ex As Exception
                    nbrDaysWarning.Value = 15
                End Try
            End If

            txtManagerID.Text = DR.Cells("ManagerID").Value.ToString
            cbRetentionPeriod.Text = DR.Cells("RetentionPeriod").Value.ToString
            cbRetentionAction.Text = DR.Cells("RetentionAction").Value.ToString
            Dim ResponseRequired As String = DR.Cells("ResponseRequired").Value.ToString
            If ckResponseRequired.ToString.Equals("Y") Then
                ckResponseRequired.Checked = True
            Else
                ckResponseRequired.Checked = False
            End If
        Else
            SB.Text = "Only one row can be selected."
        End If
    End Sub

    ''' <summary>
    ''' Handles the Click event of the btnDelete control.
    ''' </summary>
    ''' <param name="sender">The source of the event.</param>
    ''' <param name="e">The <see cref="System.EventArgs" /> instance containing the event data.</param>
    Private Sub btnDelete_Click(sender As System.Object, e As System.EventArgs) Handles btnDelete.Click

        Dim I As Integer = dgRetention.SelectedRows.Count
        If I <> 1 Then
            MessageBox.Show("One and only one row must be selected.")
            Return
        End If

        Dim RetentionCode As String = txtRetentionCode.Text

        Dim MySql As String = "delete from Retention where RetentionCode = '" + RetentionCode + "' "

        RC = DBARCH.ExecuteSqlNewConn(90000, MySql)

        If RC Then
            GetRetentionCodes()
        Else
            MessageBox.Show("A11 Failed to DELETE Retention Code : " + RetentionCode)
        End If
    End Sub

End Class

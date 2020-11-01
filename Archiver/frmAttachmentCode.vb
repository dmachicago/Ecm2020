Imports System.Data.SqlClient
Imports ECMEncryption

Public Class frmAttachmentCode
    Inherits System.Windows.Forms.Form

    Public ProcessID As String = ""
    Dim FormLoaded As Boolean = False
    Public TBL As String = ""
    Public S As String = ""
    Public winTitle As String = ""

    Dim ENC As New ECMEncrypt
    Dim da As SqlDataAdapter
    Dim SqlCommand1 As SqlCommand
    Dim DS As DataSet
    Dim cb As SqlCommandBuilder
    Dim Cn As SqlConnection
    Dim ddebug As Boolean = True
    Dim DMA As New clsDma
    Dim DBARCH As New clsDatabaseARCH

    Dim LOG As New clsLogging
    Dim UTIL As New clsUtility

    Dim bHelpLoaded As Boolean = False

    Sub New()
        'LOG.WriteToArchiveLog("Starting: frmAttachmentCode")
        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

    End Sub

    Private Sub frmAttachmentCode_Deactivate(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Deactivate
        If Me.Text.ToUpper.Equals("POP/IMAP EXCHANGE SERVER SETTINGS") Then
            DBARCH.SetExchangeDefaultRetentionCode()
        End If
    End Sub

    Private Sub frmAttachmentCode_Disposed(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Disposed
        If Me.Text.ToUpper.Equals("POP/IMAP EXCHANGE SERVER SETTINGS") Then
            DBARCH.SetExchangeDefaultRetentionCode()
        End If
    End Sub

    Private Sub frmAttachmentCode_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        FormLoaded = False

        'Dim bGetScreenObjects As Boolean = True
        'If bGetScreenObjects Then DMA.getFormWidgets(Me)

        If HelpOn Then
            DBARCH.getFormTooltips(Me, TT, True)
            TT.Active = True
            bHelpLoaded = True
        Else
            TT.Active = False
        End If

        'Dim ConnStr  = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
        Dim ConnStr As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID)
        UTIL.setConnectionStringTimeout(ConnStr)
        Cn = New SqlConnection(ConnStr)

        If winTitle.Length = 0 Then
            Me.Text = "Administrator Data Maintenance"
        Else
            Me.Text = winTitle
        End If

        ' Sql Query
        If S.Length = 0 Then
            S = "Select * FROM " + TBL
        End If

        DS = New DataSet
        ' Create a Command
        SqlCommand1 = New SqlCommand(S, Cn)

        ' Create SqlDataAdapter
        da = New SqlDataAdapter
        da.SelectCommand = SqlCommand1

        ' Create SqlCommandBuildser object
        cb = New SqlCommandBuilder(da)

        ' Fill Dataset
        da.Fill(DS, TBL)

        ' Bind the data to the grid at runtime
        dgAttachmentCode.DataSource = DS
        dgAttachmentCode.DataMember = TBL

        If Me.Text.ToUpper.Equals("POP/IMAP EXCHANGE SERVER SETTINGS") Then
            btnEncrypt.Visible = True
            Label1.Visible = True
            cbRetention.Visible = True
            btnApplyRetentionRule.Visible = True
            DBARCH.LoadRetentionCodes(Me.cbRetention)
            Return
        Else
            btnEncrypt.Visible = False
            Label1.Visible = False
            cbRetention.Visible = False
            btnApplyRetentionRule.Visible = False
            Return
        End If
        If Me.Text.ToUpper.Equals("SMTP EXCHANGE SERVER SETTINGS") Then
            btnEncrypt.Visible = True
            Label1.Visible = True
            cbRetention.Visible = True
            btnApplyRetentionRule.Visible = True
            DBARCH.LoadRetentionCodes(Me.cbRetention)
            Return
        Else
            btnEncrypt.Visible = False
            Label1.Visible = False
            cbRetention.Visible = False
            btnApplyRetentionRule.Visible = False
            Return
        End If
        FormLoaded = True

        Me.Text += "          (frmAttachmentCode)"

    End Sub

    Private Sub btnUpdate_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        Dim S As String = ""
        Try
            If ProcessID.Equals("UserRuntimeParameters") Then
                For I As Integer = 0 To dgAttachmentCode.RowCount - 2
                    Dim Parm As String = dgAttachmentCode.Rows(I).Cells("Parm").Value.ToString
                    Dim UID As String = dgAttachmentCode.Rows(I).Cells("UserID").Value.ToString
                    Dim ParmValue As String = dgAttachmentCode.Rows(I).Cells("ParmValue").Value.ToString
                    Parm = UTIL.RemoveSingleQuotes(Parm)
                    ParmValue = UTIL.RemoveSingleQuotes(ParmValue)

                    S = "update RunParms set ParmValue = '" + ParmValue + "' where UserID = '" + UID + "' and Parm = '" + Parm + "' "
                    Dim b As Boolean = DBARCH.ExecuteSqlNewConn(90000, S)
                    If Not b Then
                        LOG.WriteToArchiveLog("ERROR: 22.11.341 - Could not update user parm." + vbCrLf + S)
                        MessageBox.Show("Failed to update user parm.")
                    End If
                Next

                Return
            End If
            da.Update(DS, TBL)
        Catch ex As Exception
            MessageBox.Show(ex.Message + vbCrLf + S)
        End Try
    End Sub

    Private Sub Timer1_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Timer1.Tick

        If HelpOn Then
            If bHelpLoaded Then
                TT.Active = True
            Else
                DBARCH.getFormTooltips(Me, TT, True)
                TT.Active = True
                bHelpLoaded = True
            End If
        Else
            TT.Active = False
        End If
        Application.DoEvents()

    End Sub

    Private Sub dgAttachmentCode_CellContentClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgAttachmentCode.CellContentClick
        If Me.Text.ToUpper.Equals("POP/IMAP EXCHANGE SERVER SETTINGS") Then
            btnEncrypt.Visible = True
            Return
        Else
            btnEncrypt.Visible = False
            Return
        End If
        If Me.Text.ToUpper.Equals("SMTP EXCHANGE SERVER SETTINGS") Then
            btnEncrypt.Visible = True
            Return
        Else
            btnEncrypt.Visible = False
            Return
        End If
    End Sub

    Private Sub btnEncrypt_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEncrypt.Click

        Dim iCnt As Integer = Me.dgAttachmentCode.SelectedRows.Count

        If iCnt <> 1 Then
            MessageBox.Show("Please select one and only one row to update, thank you - returning.")
            Return
        End If

        Dim HostNameIp = Me.dgAttachmentCode.SelectedRows(0).Cells("HostNameIp").Value.ToString
        Dim UserLoginID = Me.dgAttachmentCode.SelectedRows(0).Cells("UserLoginID").Value.ToString
        Dim PW As String = Me.dgAttachmentCode.SelectedRows(0).Cells("LoginPw").Value.ToString
        Dim EncPW As String = ENC.AES256EncryptString(PW)
        Dim S As String = ""

        If Me.Text.ToUpper.Equals("POP/IMAP EXCHANGE SERVER SETTINGS") Then
            Me.dgAttachmentCode.SelectedRows(0).Cells("LoginPw").Value = EncPW

            S = "Update [ExchangeHostPop] set LoginPW = '" + EncPW + "' where [HostNameIp] = '" + HostNameIp + "' and [UserLoginID] = '" + UserLoginID + "'"
            DBARCH.ExecuteSqlNewConn(90000, S)

            GC.Collect()
            GC.WaitForFullGCComplete()
        End If
        If Me.Text.ToUpper.Equals("SMTP EXCHANGE SERVER SETTINGS") Then
            Me.dgAttachmentCode.SelectedRows(0).Cells("LoginPw").Value = EncPW

            S = "Update [ExchangeHostSmtp] set LoginPW = '" + EncPW + "' where [HostNameIp] = '" + HostNameIp + "' and [UserLoginID] = '" + UserLoginID + "'"
            DBARCH.ExecuteSqlNewConn(90000, S)

            GC.Collect()
            GC.WaitForFullGCComplete()
        End If
        ENC = Nothing
    End Sub

    Private Sub btnApplyRetentionRule_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnApplyRetentionRule.Click
        Dim iCnt As Integer = Me.dgAttachmentCode.SelectedRows.Count

        If iCnt <> 1 Then
            MessageBox.Show("Please select one and only one row to update, thank you - returning.")
            Return
        End If

        Dim RetentionCode As String = cbRetention.Text.Trim

        If RetentionCode.Length = 0 Then
            MessageBox.Show("Please select a retention rule.")
            Return
        End If

        Dim HostNameIp = Me.dgAttachmentCode.SelectedRows(0).Cells("HostNameIp").Value.ToString
        Dim UserLoginID = Me.dgAttachmentCode.SelectedRows(0).Cells("UserLoginID").Value.ToString
        Dim S As String = ""

        If Me.Text.ToUpper.Equals("POP/IMAP EXCHANGE SERVER SETTINGS") Then
            Me.dgAttachmentCode.SelectedRows(0).Cells("RetentionCode").Value = RetentionCode

            S = "Update [ExchangeHostPop] set RetentionCode = '" + RetentionCode + "' where [HostNameIp] = '" + HostNameIp + "' and [UserLoginID] = '" + UserLoginID + "'"
            DBARCH.ExecuteSqlNewConn(90000, S)

            GC.Collect()
            GC.WaitForFullGCComplete()
        End If
        If Me.Text.ToUpper.Equals("SMTP EXCHANGE SERVER SETTINGS") Then
            Me.dgAttachmentCode.SelectedRows(0).Cells("RetentionCode").Value = RetentionCode

            S = "Update [ExchangeHostSmtp] set RetentionCode = '" + RetentionCode + "' where [HostNameIp] = '" + HostNameIp + "' and [UserLoginID] = '" + UserLoginID + "'"
            DBARCH.ExecuteSqlNewConn(90000, S)

            GC.Collect()
            GC.WaitForFullGCComplete()
        End If

    End Sub

    Private Sub frmAttachmentCode_Resize(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Resize
        If FormLoaded = False Then
            Return
        End If
        ResizeControls(Me)
    End Sub

End Class
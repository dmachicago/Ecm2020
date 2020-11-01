Imports ECMEncryption

Public Class frmExhangeMail

    Dim FormLoaded As Boolean = False
    Dim POP As New clsEXCHANGEHOSTPOP
    Dim DMA As New clsDma

    Dim ENC As New ECMEncrypt

    Dim DBARCH As New clsDatabaseARCH
    Dim DG As New clsDataGrid

    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim HostNameIp As String = ""
    Dim UserLoginID As String = ""
    Dim LoginPw As String = ""
    Dim SSL As String = ""
    Dim PortNbr As String = ""
    Dim DeleteAfterDownload As String = ""
    Dim RetentionCode As String = ""
    Dim IMap As String = ""
    Dim Userid As String = ""
    Dim FolderName As String = ""
    Dim LibraryName As String = ""
    Dim DaysToHold As Integer
    Dim RedemptionDllExists As Boolean = False

    Private Sub frmExhangeMail_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        FormLoaded = False

        RedemptionDllExists = ckDLLAvailable("redemption.dll")

        PopulateExchangeGrid()
        DBARCH.LoadRetentionCodes(cbRetention)

        PopUserCombo()
        PopulateLibraryCombo()

        If RedemptionDllExists = True Then
            ckConvertEmlToMsg.Enabled = True
            SB.Text = "Note: Available"
        Else
            ckConvertEmlToMsg.Enabled = False
            SB.Text = "Note: Required DLL missing"
        End If

        ResetScreenWidgets()

        FormLoaded = True
    End Sub
    Sub ResetScreenWidgets()

        FormLoaded = False

        txtUserLoginID.Text = ""
        txtPw.Text = ""
        cbHostName.Text = ""
        txtPortNumber.Text = ""
        ckSSL.Checked = False
        ckIMap.Checked = False
        ckDeleteAfterDownload.Checked = False
        txtPortNumber.Text = ""
        txtFolderName.Text = ""
        cbRetention.Text = ""
        cbUsers.Text = ""
        cbLibrary.Text = ""
        ckPublic.Checked = False
        ckConvertEmlToMsg.Checked = False
        SB.Text = ""
        txtUserID.Text = ""

        FormLoaded = True
    End Sub
    Sub PopulateLibraryCombo()

        'DBARCH.PopulateLibCombo(cbLibrary)
        Me.Cursor = Cursors.WaitCursor
        DBARCH.PopulateGroupUserLibCombo(Me.cbLibrary)
        Me.Cursor = Cursors.Default

    End Sub
    Sub PopUserCombo()
        Dim S As String = ""
        S = S + " SELECT [UserLoginID]"
        S = S + "FROM  [Users]"
        S = S + "order by [UserLoginID]"
        DBARCH.PopulateComboBox(Me.cbUsers, "UserLoginID", S)
    End Sub
    Sub ShowAll()

        If Not isAdmin Then
            SB.Text = "You must be an ADMIN to execute this function."
            Return
        End If

        Dim S As String = ""

        S = S + " SELECT [HostNameIp]"
        S = S + " ,[UserLoginID]"
        S = S + " ,[LoginPw]"
        S = S + " ,[SSL]"
        S = S + " ,[PortNbr]"
        S = S + " ,[DeleteAfterDownload]"
        S = S + " ,[RetentionCode]"
        S = S + " ,[IMap]"
        S = S + " ,[Userid], FolderName, LibraryName, DaysToHold, StrReject, ConvertEmlToMSG "
        S = S + " FROM [ExchangeHostPop] "
        S = S + " order by [HostNameIp]"


        DG.PopulateGrid("ExchangeHostPop", S, dgExchange)
    End Sub
    Sub PopulateExchangeGrid()
        Dim S As String = ""
        If gCurrLoginID.ToUpper.Equals("SERVICEMANAGER") Then
            S = S + " SELECT [HostNameIp]"
            S = S + " ,[UserLoginID]"
            S = S + " ,[LoginPw]"
            S = S + " ,[SSL]"
            S = S + " ,[PortNbr]"
            S = S + " ,[DeleteAfterDownload]"
            S = S + " ,[RetentionCode]"
            S = S + " ,[IMap]"
            S = S + " ,[Userid], FolderName, LibraryName, DaysToHold, StrReject, ConvertEmlToMSG"
            S = S + " FROM [ExchangeHostPop] "
            S = S + " where UserID = '" + gCurrUserGuidID + "'"
            S = S + " order by [HostNameIp]"
            'ElseIf isAdmin Then
            '    S = S + " SELECT [HostNameIp]"
            '    S = S + " ,[UserLoginID]"
            '    S = S + " ,[LoginPw]"
            '    S = S + " ,[SSL]"
            '    S = S + " ,[PortNbr]"
            '    S = S + " ,[DeleteAfterDownload]"
            '    S = S + " ,[RetentionCode]"
            '    S = S + " ,[IMap]"
            '    S = S + " ,[Userid], FolderName, LibraryName, DaysToHold, StrReject, ConvertEmlToMSG "
            '    S = S + " FROM [ExchangeHostPop] "
            '    S = S + " order by [HostNameIp]"
        Else
            S = S + " SELECT [HostNameIp]"
            S = S + " ,[UserLoginID]"
            S = S + " ,[LoginPw]"
            S = S + " ,[SSL]"
            S = S + " ,[PortNbr]"
            S = S + " ,[DeleteAfterDownload]"
            S = S + " ,[RetentionCode]"
            S = S + " ,[IMap]"
            S = S + " ,[Userid], FolderName, LibraryName, DaysToHold, StrReject, ConvertEmlToMSG"
            S = S + " FROM [ExchangeHostPop] "
            S = S + " where UserID = '" + gCurrUserGuidID + "'"
            S = S + " order by [HostNameIp]"
        End If

        DG.PopulateGrid("ExchangeHostPop", S, dgExchange)

    End Sub
    Sub PopulateExchangeComboBox()
        Dim S As String = ""
        If isAdmin Then
            S = S + " SELECT distinct [HostNameIp] FROM [ExchangeHostPop]         "
            S = S + " order by [HostNameIp]"
        Else
            S = S + " SELECT distinct [HostNameIp] FROM [ExchangeHostPop]         "
            S = S + " where UserID = '" + gCurrUserGuidID + "'"
            S = S + " order by [HostNameIp]"
        End If
        DBARCH.PopulateComboBox(cbHostName, "HostNameIp", S)
    End Sub

    Private Sub btnAdd_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        Try
            If cbHostName.Text.Trim.Length = 0 Then
                MessageBox.Show("Please supply a Host Name or IP.")
                Return
            End If
            If Me.cbRetention.Text.Trim.Length = 0 Then
                MessageBox.Show("Please supply a Retention Code.")
                Return
            End If
            If txtPw.Text.Trim.Length = 0 Then
                MessageBox.Show("Please supply a password.")
                Return
            End If
            If Me.txtUserLoginID.Text.Trim.Length = 0 Then
                MessageBox.Show("Please supply a user login ID.")
                Return
            End If
            If txtReject.Text.Trim.Length > 0 Then
                Dim sReject As String = txtReject.Text.Trim
                sReject = UTIL.RemoveSingleQuotes(sReject)

            End If

            POP.setReject(txtReject.Text.Trim)
            POP.setUserid(gCurrUserGuidID)
            If ckDeleteAfterDownload.Checked = True Then
                POP.setDeleteafterdownload("1")
            Else
                POP.setDeleteafterdownload("0")
            End If

            POP.setHostnameip(cbHostName.Text)
            If ckIMap.Checked = True Then
                POP.setImap("1")
            Else
                POP.setImap("0")
            End If

            POP.setLibrary(ckPublic.Checked)
            POP.setLibrary(cbLibrary.Text)
            POP.setLoginpw(txtPw.Text.Trim)
            POP.setPortnbr(txtPortNumber.Text.Trim)
            POP.setRetentioncode(Me.cbRetention.Text)
            POP.setDaysToHold(nbrDaysToRetain.Value)

            If Me.ckSSL.Checked = True Then
                POP.setSsl("1")
            Else
                POP.setSsl("0")
            End If

            Dim tUserID As String = DBARCH.getUserGuidID(Me.cbUsers.Text)
            If tUserID.Trim.Length = 0 Then
                tUserID = gCurrUserGuidID
            End If
            POP.setUserid(tUserID)

            If Me.txtFolderName.Text.Trim.Length = 0 Then
                Me.txtFolderName.Text = "NA"
            End If

            POP.setFolderName(Me.txtFolderName.Text.Trim)
            POP.setUserloginid(Me.txtUserLoginID.Text.Trim)

            POP.setConvertEmlToMsg(ckConvertEmlToMsg.Checked)

            Dim b As Boolean = POP.Insert
            If Not b Then
                SB.Text = "Failed to add new Exchange record."
            Else
                SB.Text = "Added new Exchange record."
                PopulateExchangeGrid()
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR frmExhangeMail:btnAdd_Click - " + ex.Message)
        End Try

    End Sub

    Private Sub dgExchange_CellContentClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgExchange.CellContentClick
        getGridData()
    End Sub

    Private Sub dgExchange_MouseDown(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles dgExchange.MouseDown
        If e.Button = MouseButtons.Right Then
            If e.Button = MouseButtons.Right Then
                'ContextHandler(Me.dgDoc, e)
                Dim PNT As New System.Drawing.Point
                PNT.X = e.X
                PNT.Y = e.Y
                Dim X As Integer = e.X
                Dim Y As Integer = e.Y
                Debug.Print(X.ToString + "," + Y.ToString)
                'ContextMenuStrip1.Show(Me, PNT)
                'ContextMenuStrip1.Show(Me, 100, 100)
                ContextMenuStrip1.Show(Me.dgExchange, X, Y)
            End If
        End If
    End Sub

    Private Sub dgExchange_SelectionChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgExchange.SelectionChanged
        getGridData()
    End Sub

    Private Sub btnUpdate_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnUpdate.Click
        Dim icnt As Integer = dgExchange.SelectedRows.Count
        If icnt <> 1 Then
            MessageBox.Show("Please select one and only one item to update.")
            Return
        End If
        If cbHostName.Text.Trim.Length = 0 Then
            MessageBox.Show("Please supply a Host Name or IP.")
            Return
        End If
        If Me.cbRetention.Text.Trim.Length = 0 Then
            MessageBox.Show("Please supply a Retention Code.")
            Return
        End If
        If txtPw.Text.Trim.Length = 0 Then
            MessageBox.Show("Please supply a password.")
            Return
        End If
        If Me.txtUserLoginID.Text.Trim.Length = 0 Then
            MessageBox.Show("Please supply a user login ID.")
            Return
        End If

        POP.setReject(txtReject.Text.Trim)
        POP.setDaysToHold(nbrDaysToRetain.Value)
        POP.setUserid(Me.txtUserID.Text)

        If ckDeleteAfterDownload.Checked = True Then
            POP.setDeleteafterdownload("1")
        Else
            POP.setDeleteafterdownload("0")
        End If

        POP.setHostnameip(cbHostName.Text)
        If ckIMap.Checked = True Then
            POP.setImap("1")
        Else
            POP.setImap("0")
        End If
        POP.setLoginpw(txtPw.Text.Trim)
        POP.setPortnbr(txtPortNumber.Text.Trim)
        POP.setRetentioncode(Me.cbRetention.Text)
        If Me.ckSSL.Checked = True Then
            POP.setSsl("1")
        Else
            POP.setSsl("0")
        End If

        Dim tUserID As String = DBARCH.getUserGuidID(Me.cbUsers.Text)
        If tUserID.Trim.Length = 0 Then
            tUserID = gCurrUserGuidID
        End If
        POP.setUserid(gCurrUserGuidID)

        POP.setUserloginid(Me.txtUserLoginID.Text.Trim)

        Userid = txtUserID.Text

        POP.setFolderName(Me.txtFolderName.Text.Trim)
        POP.setLibrary(ckPublic.Checked)
        POP.setLibrary(cbLibrary.Text)

        POP.setConvertEmlToMsg(ckConvertEmlToMsg.Checked)


        Dim b As Boolean = POP.Update(HostNameIp, Userid, UserLoginID)
        If Not b Then
            SB.Text = "Failed to update Exchange record."
        Else
            SB.Text = "Updated Exchange record."
            PopulateExchangeGrid()
        End If
    End Sub

    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        Dim icnt As Integer = dgExchange.SelectedRows.Count
        If icnt <> 1 Then
            MessageBox.Show("Please select one and only one item to update.")
            Return
        End If
        If cbHostName.Text.Trim.Length = 0 Then
            MessageBox.Show("Please supply a Host Name or IP.")
            Return
        End If
        If Me.cbRetention.Text.Trim.Length = 0 Then
            MessageBox.Show("Please supply a Retention Code.")
            Return
        End If
        If txtPw.Text.Trim.Length = 0 Then
            MessageBox.Show("Please supply a password.")
            Return
        End If
        If Me.txtUserLoginID.Text.Trim.Length = 0 Then
            MessageBox.Show("Please supply a user login ID.")
            Return
        End If
        POP.setUserid(gCurrUserGuidID)
        If ckDeleteAfterDownload.Checked = True Then
            POP.setDeleteafterdownload("1")
        Else
            POP.setDeleteafterdownload("0")
        End If

        POP.setHostnameip(cbHostName.Text)
        If ckIMap.Checked = True Then
            POP.setImap("1")
        Else
            POP.setImap("0")
        End If
        POP.setLoginpw(txtPw.Text.Trim)
        POP.setPortnbr(txtPortNumber.Text.Trim)
        POP.setRetentioncode(Me.cbRetention.Text)
        If Me.ckSSL.Checked = True Then
            POP.setSsl("1")
        Else
            POP.setSsl("0")
        End If
        POP.setUserid(gCurrUserGuidID)
        POP.setUserloginid(Me.txtUserLoginID.Text.Trim)

        Dim WC As String = POP.wc_PK_ExchangeHostPop(HostNameIp, Userid, UserLoginID)

        Dim b As Boolean = POP.Delete(WC)
        If Not b Then
            SB.Text = "Failed to delete record A5."
        Else
            SB.Text = "Deleted Exchange record A6."
            PopulateExchangeGrid()
        End If
    End Sub
    Sub getGridData()

        Try
            Dim iRow As Integer = dgExchange.CurrentRow.Index
            Dim iCnt As Integer = dgExchange.SelectedRows.Count
            If iCnt = 0 Then
                Return
            End If
            If iCnt > 1 Then
                Return
            End If

            HostNameIp = dgExchange.SelectedRows(0).Cells("HostNameIp").Value.ToString
            UserLoginID = dgExchange.SelectedRows(0).Cells("UserLoginID").Value.ToString
            SSL = dgExchange.SelectedRows(0).Cells("SSL").Value.ToString
            PortNbr = dgExchange.SelectedRows(0).Cells("PortNbr").Value.ToString
            DeleteAfterDownload = dgExchange.SelectedRows(0).Cells("DeleteAfterDownload").Value.ToString
            RetentionCode = dgExchange.SelectedRows(0).Cells("RetentionCode").Value.ToString
            IMap = dgExchange.SelectedRows(0).Cells("IMap").Value.ToString
            Userid = dgExchange.SelectedRows(0).Cells("Userid").Value.ToString
            LoginPw = dgExchange.SelectedRows(0).Cells("LoginPw").Value.ToString
            FolderName = dgExchange.SelectedRows(0).Cells("FolderName").Value.ToString
            LibraryName = dgExchange.SelectedRows(0).Cells("LibraryName").Value.ToString
            DaysToHold = Val(dgExchange.SelectedRows(0).Cells("DaysToHold").Value.ToString)
            txtReject.Text = dgExchange.SelectedRows(0).Cells("strReject").Value.ToString

            Dim tUserLoginID As String = DBARCH.getUserLoginByUserid(Userid)
            SB.Text = "Execution ID: " + tUserLoginID
            '
            Dim tVal As String = dgExchange.SelectedRows(0).Cells("ConvertEmlToMSG").Value.ToString
            If tVal.ToUpper.Equals("TRUE") Then
                ckConvertEmlToMsg.Checked = True
            Else
                ckConvertEmlToMsg.Checked = False
            End If

            If IMap.ToUpper.Equals("TRUE") Then
                ckIMap.Checked = True
            Else
                ckIMap.Checked = False
            End If
            If SSL.ToUpper.Equals("TRUE") Then
                ckSSL.Checked = True
            Else
                ckSSL.Checked = False
            End If

            Me.cbHostName.Text = HostNameIp
            Me.txtUserLoginID.Text = UserLoginID
            'Me.ckSSL.Checked = Val(SSL)
            Me.txtPortNumber.Text = PortNbr
            If DeleteAfterDownload = True Then
                Me.ckDeleteAfterDownload.Checked = True
            Else
                Me.ckDeleteAfterDownload.Checked = False
            End If

            Me.cbRetention.Text = RetentionCode
            'Me.ckIMap.Checked = Val(IMap)
            Me.cbUsers.Text = DBARCH.getUserLoginByUserid(Userid)
            Me.txtPw.Text = LoginPw

            Me.txtUserID.Text = Userid
            Me.txtFolderName.Text = FolderName.Trim

            cbLibrary.Text = LibraryName
            nbrDaysToRetain.Value = DaysToHold

        Catch ex As Exception
            SB.Text = ex.Message
        End Try


    End Sub

    Private Sub btnEncrypt_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEncrypt.Click
        If txtPw.Text.Trim.Length = 0 Then
            MessageBox.Show("Please supply a password.")
            Return
        End If
        Dim tPw As String = txtPw.Text.Trim
        txtPw.Text = ENC.AES256EncryptString(tPw)

    End Sub

    Private Sub ExchnageJournalingToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ExchnageJournalingToolStripMenuItem.Click
        'Exchange2003Journaling.htm
        System.Diagnostics.Process.Start("http://www.ecmlibrary.com/_helpfiles/Exchange2003Journaling.htm")
    End Sub

    Private Sub Exchange2007Vs2003ToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Exchange2007Vs2003ToolStripMenuItem.Click
        'Microsoft Exchange Server 2007 Compliance Tour.htm
        System.Diagnostics.Process.Start("http://www.ecmlibrary.com/_helpfiles/Microsoft Exchange Server 2007 Compliance Tour.htm")
    End Sub

    Private Sub ECMLibraryExchangeInterfaceToolStripMenuItem1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ECMLibraryExchangeInterfaceToolStripMenuItem1.Click
        'ECM Library Exchange Server Journaling Interface.htm
        System.Diagnostics.Process.Start("http://www.ecmlibrary.com/_helpfiles/ECM Library Exchange Server Journaling Interface.htm")
    End Sub

    Private Sub ckIMap_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckIMap.CheckedChanged
        If ckIMap.Checked Then
            txtFolderName.Enabled = True
        Else
            txtFolderName.Enabled = False
        End If
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnTest.Click
        If btnTest.Text.Equals("Show All") Then
            ShowAll()
            btnTest.Text = "Show Mine"
        Else
            PopulateExchangeGrid()
            btnTest.Text = "Show All"
        End If

    End Sub

    Private Sub btnReset_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnReset.Click
        ResetScreenWidgets()
    End Sub

    Private Sub ckExcg2007_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckExcg2007.CheckedChanged
        If ckExcg2007.Checked Then

            Me.ckPlainText.Checked = False
            Me.ckPlainText.Enabled = False

            Me.ckRtfFormat.Checked = False
            Me.ckRtfFormat.Enabled = False

            ckEnvelope.Checked = True

        Else
            Me.ckPlainText.Checked = False
            Me.ckPlainText.Enabled = True

            Me.ckRtfFormat.Checked = False
            Me.ckRtfFormat.Enabled = True

            ckEnvelope.Checked = True
        End If
    End Sub

    Private Sub ckExcg2003_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckExcg2003.CheckedChanged
        If ckExcg2003.Checked = True Then
            Me.ckPlainText.Checked = False
            Me.ckPlainText.Enabled = True

            Me.ckRtfFormat.Checked = False
            Me.ckRtfFormat.Enabled = True

            ckEnvelope.Checked = True
        End If
    End Sub

    Private Sub ckDeleteAfterDownload_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckDeleteAfterDownload.CheckedChanged
        If ckDeleteAfterDownload.Checked Then
            'Label9.Visible = False
            nbrDaysToRetain.Enabled = False
            nbrDaysToRetain.Value = 0
        Else
            Label9.Visible = True
            nbrDaysToRetain.Visible = True
            nbrDaysToRetain.Enabled = True
        End If
    End Sub

    Private Sub btnShoaAllLib_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnShoaAllLib.Click
        If isAdmin Then
            DBARCH.PopulateAllUserLibCombo(Me.cbLibrary)
        Else
            SB.Text = "Admin authority required for this function."
        End If
    End Sub

    Private Sub btnTestConnection_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnTestConnection.Click

        Dim EM As New clsEmailFunctions
        Dim MailServerAddr As String = cbHostName.Text
        Dim Portnbr As Integer = Val(txtPortNumber.Text)
        Dim UserLoginID As String = txtUserLoginID.Text
        Dim LoginPassWord As String = txtPw.Text
        Dim Msg As String = ""
        Dim B As Boolean = False

        If ckSSL.Checked = True And ckIMap.Checked = True Then
            B = EM.ckImapSSLConnection(MailServerAddr, Portnbr, UserLoginID, LoginPassWord)
            If B Then
                Msg = "Successful login to: " + MailServerAddr
            Else
                Msg = "FAILED login to: " + MailServerAddr
            End If
        ElseIf ckSSL.Checked = False And ckIMap.Checked = True Then
            B = EM.clIMapConnection(MailServerAddr, Portnbr, UserLoginID, LoginPassWord)
            If B Then
                Msg = "Successful login to: " + MailServerAddr
            Else
                Msg = "FAILED login to: " + MailServerAddr
            End If
        ElseIf ckSSL.Checked = True And ckIMap.Checked = False Then
            Dim iCnt As Integer = EM.ckPopSSL(MailServerAddr, Portnbr, UserLoginID, LoginPassWord)
            If iCnt >= 0 Then
                Msg = "Successful login to: " + MailServerAddr + " : " + iCnt.ToString + " emails on server."
            Else
                Msg = "FAILED login to: " + MailServerAddr
            End If
        Else
            Dim iCnt As Integer = EM.ckPopConnection(MailServerAddr, Portnbr, UserLoginID, LoginPassWord)
            If iCnt >= 0 Then
                Msg = "Successful login to: " + MailServerAddr + " : " + iCnt.ToString + " emails on server."
            Else
                Msg = "FAILED login to: " + MailServerAddr
            End If
        End If

        EM = Nothing


        SB.Text = Msg


    End Sub

    Private Sub SampleIMAPSSLScreenToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SampleIMAPSSLScreenToolStripMenuItem.Click
        cbHostName.Text = "imap.gmail.com"
        txtUserLoginID.Text = "xxx@gmail.com"
        txtPw.Text = "<password>"
        ckSSL.Checked = True
        ckIMap.Checked = True
        nbrDaysToRetain.Value = 5
        txtPortNumber.Text = 465
        txtFolderName.Text = "xxx@gmail.com"

    End Sub

    Private Sub SampleIMAPScreenToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SampleIMAPScreenToolStripMenuItem.Click
        cbHostName.Text = "imap.aol.com"
        txtUserLoginID.Text = "xxx@aol.com"
        txtPw.Text = "<password>"
        ckSSL.Checked = False
        ckIMap.Checked = True
        nbrDaysToRetain.Value = 5
        txtPortNumber.Text = 143
        txtFolderName.Text = "xxx@aol.com"
    End Sub

    Private Sub SamplePOPMailScreenToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SamplePOPMailScreenToolStripMenuItem.Click
        cbHostName.Text = "pop.gmail.com"
        txtUserLoginID.Text = "xxx@gmail.com"
        txtPw.Text = "<password>"
        ckSSL.Checked = False
        ckIMap.Checked = False
        nbrDaysToRetain.Value = 5
        txtPortNumber.Text = 995
        txtFolderName.Text = "xxx@gmail.com"
    End Sub

    Private Sub SamplePOPSSLMailScreenToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SamplePOPSSLMailScreenToolStripMenuItem.Click
        cbHostName.Text = "pop.gmail.com"
        txtUserLoginID.Text = "xxx@gmail.com"
        txtPw.Text = "<password>"
        ckSSL.Checked = True
        ckIMap.Checked = False
        nbrDaysToRetain.Value = 5
        txtPortNumber.Text = 110
        txtFolderName.Text = "xxx@gmail.com"
    End Sub

    Private Sub SampleCorporateEmailScreenToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SampleCorporateEmailScreenToolStripMenuItem.Click
        cbHostName.Text = "pop.secureserver.net"
        txtUserLoginID.Text = "xUser@EcmLibrary.com"
        txtPw.Text = "<password>"
        ckSSL.Checked = False
        ckIMap.Checked = False
        nbrDaysToRetain.Value = 2
        txtPortNumber.Text = 110
        txtFolderName.Text = "xxx@gmail.com"
    End Sub

    Private Sub HelpToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles HelpToolStripMenuItem.Click

    End Sub

    Private Sub ComplianceOverviewToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ComplianceOverviewToolStripMenuItem.Click
        'Microsoft Exchange Server 2007 Compliance Tour.htm
        System.Diagnostics.Process.Start("http://www.ecmlibrary.com/_helpfiles/Microsoft Exchange Server 2007 Compliance Tour.htm")
    End Sub

    Private Sub ExchangeJournalingToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ExchangeJournalingToolStripMenuItem.Click
        'Exchange2003Journaling.htm
        System.Diagnostics.Process.Start("http://www.ecmlibrary.com/_helpfiles/Exchange2003Journaling.htm")
    End Sub

    Private Sub POPMailToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles POPMailToolStripMenuItem.Click
        cbHostName.Text = "pop.gmail.com"
        txtUserLoginID.Text = "xxx@gmail.com"
        txtPw.Text = "<password>"
        ckSSL.Checked = False
        ckIMap.Checked = False
        nbrDaysToRetain.Value = 5
        txtPortNumber.Text = 995
        txtFolderName.Text = "xxx@gmail.com"
    End Sub

    Private Sub IMAPSSLToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles IMAPSSLToolStripMenuItem.Click
        cbHostName.Text = "imap.gmail.com"
        txtUserLoginID.Text = "xxx@gmail.com"
        txtPw.Text = "<password>"
        ckSSL.Checked = True
        ckIMap.Checked = True
        nbrDaysToRetain.Value = 5
        txtPortNumber.Text = 465
        txtFolderName.Text = "INBOX"
    End Sub

    Private Sub IMAPToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles IMAPToolStripMenuItem.Click
        cbHostName.Text = "imap.aol.com"
        txtUserLoginID.Text = "xxx@aol.com"
        txtPw.Text = "<password>"
        ckSSL.Checked = False
        ckIMap.Checked = True
        nbrDaysToRetain.Value = 5
        txtPortNumber.Text = 143
        txtFolderName.Text = "INBOX"
    End Sub

    Private Sub POPSSLToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles POPSSLToolStripMenuItem.Click
        cbHostName.Text = "pop.gmail.com"
        txtUserLoginID.Text = "xxx@gmail.com"
        txtPw.Text = "<password>"
        ckSSL.Checked = True
        ckIMap.Checked = False
        nbrDaysToRetain.Value = 5
        txtPortNumber.Text = 110
        txtFolderName.Text = "xxx@gmail.com"
    End Sub

    Private Sub StandardCoporateToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles StandardCoporateToolStripMenuItem.Click
        cbHostName.Text = "pop.secureserver.net"
        txtUserLoginID.Text = "xUser@EcmLibrary.com"
        txtPw.Text = "<password>"
        ckSSL.Checked = False
        ckIMap.Checked = False
        nbrDaysToRetain.Value = 2
        txtPortNumber.Text = 110
        txtFolderName.Text = "xxx@gmail.com"
    End Sub
End Class

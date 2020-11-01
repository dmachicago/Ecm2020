Public Class frmLicense

    Dim bFormLoaded As Boolean = False

    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma

    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim LM As New clsLicenseMgt
    Dim RS As New clsRemoteSupport
    Dim LIC As New clsLICENSE

    Dim bHelpLoaded As Boolean = False
    Dim bLicenseLoaded As Boolean = False
    Dim bApplied As Boolean = False

    Dim xCompanyID As String = ""
    Dim xMachineID = ""
    Dim xLicenseID As String = ""
    Dim xApplied As String = ""
    Dim xLicenseTypeCode As String = ""
    Dim xEncryptedLicense As String = ""
    Dim CurrServerName As String = ""

    Dim ExistingVersionNbr As String = ""
    Dim ExistingActivationDate As String = ""
    Dim ExistingInstallDate As String = ""
    Dim ExistingCustomerID As String = ""
    Dim ExistingCustomerName As String = ""
    Dim ExistingLicenseID As String = ""
    Dim ExistingXrtNxr1 As String = ""
    Dim ExistingServerIdentifier As String = ""
    Dim ExistingSqlInstanceIdentifier As String = ""

    Private Sub btnGetfile_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnGetfile.Click
        OpenFileDialog1.ShowDialog()
        Dim FQN As String = OpenFileDialog1.FileName
        txtFqn.Text = FQN
    End Sub

    Private Sub btnLoadFile_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLoadFile.Click
        Dim CustomerID As String = txtCompanyID.Text.Trim
        bApplied = False
        If CustomerID.Length = 0 Then
            MessageBox.Show("Customer ID required: " + vbCrLf + "If you do not know your Customer ID, " + vbCrLf + "please contact ECM Support or your ECM administrator.")
            Return
        End If
        Dim SelectedServer As String = txtServers.Text.Trim
        If SelectedServer.Length = 0 Then
            MessageBox.Show("Please select the Server to which this license applies." + vbCrLf + "The server name and must match that contained within the license.")
            Return
        End If
        Dim FQN As String = txtFqn.Text
        OpenFileDialog1.ShowDialog()
        FQN = OpenFileDialog1.FileName
        Dim S As String = DMA.LoadLicenseFile(FQN)
        If S.Length = 0 Then
            SB.Text = "Failed to load license."
        Else
            SB.Text = "Loaded license."
            txtLicense.Text = S
            btnPasteLicense_Click(Nothing, Nothing)
        End If
    End Sub

    Private Sub btnPasteLicense_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnPasteLicense.Click
        Dim CustomerID As String = txtCompanyID.Text.Trim
        bApplied = False
        If CustomerID.Length = 0 Then
            MessageBox.Show("Customer ID required: " + vbCrLf + "If you do not know your Customer ID, " + vbCrLf + "please contact ECM Support or your ECM administrator.")
            Return
        End If
        Dim SelectedServer As String = txtServers.Text.Trim
        If SelectedServer.Length = 0 Then
            MessageBox.Show("Please select the Server to which this license applies." + vbCrLf + "The server name and must match that contained within the license.")
            Return
        End If
        Dim bCustIdGood = RS.ckCompanyID(CustomerID)
        If bCustIdGood = False Then
            MessageBox.Show("Could not connect to the ECM customer database. Continuing without confirmation")
            'Return
        End If
        Dim B As Boolean = DBARCH.saveLicenseCutAndPaste(txtLicense.Text, CustomerID, SelectedServer)
        If Not B Then
            SB.Text = "Failed to save license."
        Else
            SB.Text = "Saved license."
            bApplied = True
        End If
    End Sub

    Private Sub frmLicense_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        bFormLoaded = False
        bInetAvailable = DMA.isConnected
        'Dim bGetScreenObjects As Boolean = True
        'If bGetScreenObjects Then DMA.getFormWidgets(Me)

        If bInetAvailable = True Then
            SB.Text = ("Internet available for license download.")
            btnRemote.Enabled = True
        Else
            SB.Text = ("Internet NOT available for license download.")
            btnRemote.Enabled = False
        End If

        If HelpOn Then
            DBARCH.getFormTooltips(Me, TT, True)
            TT.Active = True
            bHelpLoaded = True
        Else
            TT.Active = False
        End If
        Timer1.Enabled = True
        Timer1.Interval = 5000

        AddTwoNewFields()

        bFormLoaded = True
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

    Private Sub btnDisplay_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDisplay.Click
        Dim LT As String = DBARCH.GetXrt(gCustomerName, gCustomerID)
        LM.ParseLic(LT, True)
    End Sub

    Private Sub btnRemote_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnRemote.Click
        bFormLoaded = False
        Dim repoServer As String = txtServers.Text.Trim
        Dim CompanyID As String = txtCompanyID.Text.Trim

        Dim SqlServerInstanceNameX As String = txtServers.Text
        Dim SqlServerMachineName As String = txtSqlServerMachineName.Text

        If CompanyID.Length = 0 Then
            MessageBox.Show("You must supply your Company ID to access the server, returning.")
            Return
        End If

        Try
            If repoServer.Length = 0 Then
                MessageBox.Show("You must select a Repository Server, returning.")
                Return
            End If
            '**
            Dim bFetch As Boolean = RS.getClientLicenses(CompanyID, Me.dgLicense)
            If bFetch Then
                SB.Text = "Successfully retrieved license."
                bLicenseLoaded = True
            Else
                bLicenseLoaded = False
                SB.Text = "Failed to retrieve license."
            End If
        Catch ex As Exception
            LOG.WriteToArchiveLog("Trace 23.11.24: License failed to download for: " + DBARCH.getUserLoginByUserid(gCurrUserGuidID) + " : " + ex.Message)
            LOG.WriteToTraceLog("Trace 23.11.24: License failed to download for: " + DBARCH.getUserLoginByUserid(gCurrUserGuidID) + " : " + ex.Message)
        End Try
        bFormLoaded = True
    End Sub

    Private Sub dgLicense_CellContentClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgLicense.CellContentClick
        GetGridData()
    End Sub
    Sub GetGridData()
        If bFormLoaded = False Then
            Return
        End If
        btnApplySelLic.Enabled = False
        Dim I As Integer = Me.dgLicense.SelectedRows.Count

        If I > 1 Or I = 0 Then
            MessageBox.Show("Please select one and only one license please.")
            Return
        End If

        Dim LL As Integer = 1
        Try
            Dim iCells As Integer = Me.dgLicense.SelectedRows(0).Cells.Count - 1
            LL = 2
            xCompanyID = Me.dgLicense.SelectedRows(0).Cells("CompanyID").Value.ToString
            LL = 3
            xMachineID = Me.dgLicense.SelectedRows(0).Cells("MachineID").Value.ToString
            LL = 4
            xLicenseID = Me.dgLicense.SelectedRows(0).Cells("LicenseID").Value.ToString
            LL = 5
            xApplied = Me.dgLicense.SelectedRows(0).Cells("Applied").Value.ToString
            LL = 6
            xLicenseTypeCode = Me.dgLicense.SelectedRows(0).Cells("LicenseTypeCode").Value.ToString
            LL = 7
            'xEncryptedLicense  = Me.dgLicense.SelectedRows(0).Cells("EncryptedLicense").Value.ToString
            xEncryptedLicense = Me.dgLicense.SelectedRows(0).Cells(iCells).Value.ToString
            LL = 8
            'txtLicense.Text = xEncryptedLicense

            btnApplySelLic.Enabled = True
            LL = 9
            SB.Text = "License data ready to apply."
            LL = 10
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: frmLicense:GetGridData 100 - LL = " + LL.ToString + vbCrLf + ex.Message)
        End Try

    End Sub

    Private Sub dgLicense_SelectionChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgLicense.SelectionChanged
        GetGridData()
    End Sub

    Private Sub btnApplySelLic_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnApplySelLic.Click

        Dim ServerName As String = Me.dgLicense.SelectedRows(0).Cells("ServerName").Value.ToString
        Dim SqlInstanceName As String = Me.dgLicense.SelectedRows(0).Cells("SqlInstanceName").Value.ToString
        Dim xEncryptedLicense As String = Me.dgLicense.SelectedRows(0).Cells("EncryptedLicense").Value.ToString

        bLicenseLoaded = False

        CurrServerName = DBARCH.getServerMachineName
        Dim CurrInstanceName As String = DBARCH.getServerInstanceName

        '** Now, I have the license data - what do I do with it?

        '** Check to see if the Applied Bit is set to true
        If xApplied.Equals("1") Then
            '** If so, display a message box and return
            MessageBox.Show("This license has already been applied and can be reapplied ONLY to the assigned server.")
        End If
        Dim CustomerID As String = txtCompanyID.Text.Trim
        If CustomerID.Length = 0 Then
            MessageBox.Show("Customer ID required: " + vbCrLf + "If you do not know your Customer ID, " + vbCrLf + "please contact ECM Support or your ECM administrator.")
            Return
        End If
        Dim SelectedServer As String = txtServers.Text.Trim
        If SelectedServer.Length = 0 Then
            MessageBox.Show("Please select the Server to which this license applies." + vbCrLf + "The server name and must match that contained within the license.")
            Return
        End If
        Dim bCustIdGood = RS.ckCompanyID(CustomerID)
        If bCustIdGood = False Then
            MessageBox.Show("Could not find the supplied Customer ID in the ECM database. Please verify... returning")
            Return
        End If

        Dim BBB As Boolean = RS.getLicenseServerName(CustomerID, ServerName, SqlInstanceName)

        If xMachineID.Equals("ECMNEWXX") Then
            Dim msg As String = "This is a new license and can be applied to the currently attached repository." + vbCrLf
            msg = msg + " Do you wish to apply the license to server '" + CurrServerName + "' ?" + vbCrLf
            Dim dlgRes As DialogResult = MessageBox.Show(msg, "License Installation", MessageBoxButtons.YesNo)
            If dlgRes = Windows.Forms.DialogResult.No Then
                Return
            End If
            '** Apply the license to the server, Update the ECM License DBARCH, and show a message
            If xLicenseID.Trim.Length = 0 Then
                xLicenseID = "1"
            End If
            Dim iCnt As Integer = LIC.cnt_PK_License(xLicenseID)
            If iCnt = 0 Then

                LIC.setActivationdate(Now.ToString)
                LIC.setAgreement(xEncryptedLicense)
                LIC.setCustomerid(xCompanyID)
                LIC.setCustomername("NA")
                LIC.setInstalldate(Now.ToString)
                LIC.setVersionnbr(xLicenseID)
                LIC.setServeridentifier(SelectedServer)
                LIC.setSqlinstanceidentifier(SelectedServer)

                bApplied = False

                Dim BB As Boolean = True
                Dim bApplyNewWay As Boolean = True
                If bApplyNewWay Then
                    bApplied = False
                    txtLicense.Text = xEncryptedLicense
                    btnPasteLicense_Click(Nothing, Nothing)
                    txtLicense.Text = ""
                    '** bApplied is set within CALL to btnPasteLicense_Click
                    BB = bApplied
                Else
                    BB = LIC.Insert
                    bApplied = BB
                End If

                If Not BB Then
                    MessageBox.Show("ERROR: 12.12.3 - Failed to insert license.")
                    LOG.WriteToTraceLog("ERROR: 12.12.3 - Failed to insert license.")
                    bLicenseLoaded = False
                Else
                    DBARCH.UpdateRemoteMachine(CustomerID, CurrServerName, "1", xLicenseID)
                    Me.dgLicense.SelectedRows(0).Cells("MachineID").Value = SelectedServer
                    SB.Text = Now.ToString + " : License successfully applied."
                    bLicenseLoaded = True
                    txtLicense.Text = xEncryptedLicense
                    btnPasteLicense_Click(Nothing, Nothing)
                    txtLicense.Text = ""
                End If
            Else
                LIC.setActivationdate(Now.ToString)
                LIC.setAgreement(xEncryptedLicense)
                LIC.setCustomerid(xCompanyID)
                LIC.setCustomername("NA")
                LIC.setInstalldate(Now.ToString)
                LIC.setVersionnbr(xLicenseID)
                LIC.setServeridentifier(SelectedServer)
                LIC.setSqlinstanceidentifier(SelectedServer)
                Dim WC As String = LIC.wc_PK_License(xLicenseID)
                Dim BB As Boolean = LIC.Update(WC)
                If Not BB Then
                    MessageBox.Show("ERROR: 12.12.3a - Failed to update license.")
                    LOG.WriteToTraceLog("ERROR: 12.12.3a - Failed to update license.")
                    bLicenseLoaded = False
                Else
                    DBARCH.UpdateRemoteMachine(CustomerID, CurrServerName, "1", xLicenseID)
                    Me.dgLicense.SelectedRows(0).Cells("MachineID").Value = SelectedServer
                    SB.Text = Now.ToString + " : License updated."
                    bLicenseLoaded = True
                    txtLicense.Text = xEncryptedLicense
                    btnPasteLicense_Click(Nothing, Nothing)
                    txtLicense.Text = ""
                End If
            End If
        Else
            If CurrServerName.Equals(ServerName) And CurrInstanceName.Equals(SqlInstanceName) Then
                '** See if the current server has an existing license
                '** If not, add this one and transmit back the Server Name to the ECM server
                '** If So, update the existing license.
                Dim bLicenseExists As Boolean = DBARCH.LicenseExists()
                If bLicenseExists = True Then
                    Dim S As String = "Truncate Table License"
                    BBB = DBARCH.ExecuteSqlNewConn(90000, S)
                    If BBB Then
                        bLicenseExists = False
                    End If
                End If
                If bLicenseExists = False Then
                    Dim VersionNbr As String = xLicenseID
                    Dim bVersion As Boolean = DBARCH.LicenseVersionExist(VersionNbr)
                    If bVersion = False Then
                        '** Add the new version
                        LIC.setActivationdate(Now.ToString)
                        LIC.setAgreement(xEncryptedLicense)
                        LIC.setCustomerid(xCompanyID)
                        LIC.setInstalldate(Now.ToString)
                        LIC.setCustomername(xCompanyID)
                        LIC.setVersionnbr(xLicenseID)
                        'LIC.setXrtnxr1()
                        Dim B As Boolean = LIC.Insert
                        If B = False Then
                            MessageBox.Show("ERROR: Failed to insert license.")
                            SB.Text = "ERROR: Failed to insert license."
                            bLicenseLoaded = False
                        Else
                            DBARCH.UpdateRemoteMachine(CustomerID, CurrServerName, "1", xLicenseID)
                            Me.dgLicense.SelectedRows(0).Cells("MachineID").Value = SelectedServer
                            SB.Text = Now.ToString + " : License added."
                            bLicenseLoaded = True
                            txtLicense.Text = xEncryptedLicense
                            btnPasteLicense_Click(Nothing, Nothing)
                            txtLicense.Text = ""
                            SB.Text = "License APPLIED."
                            btnDisplay_Click(Nothing, Nothing)
                        End If
                    Else
                        '** Update the current license
                        ' Damn - what here ???
                        LIC.setActivationdate(Now.ToString)
                        LIC.setAgreement(xEncryptedLicense)
                        LIC.setCustomerid(xCompanyID)
                        LIC.setInstalldate(Now.ToString)
                        LIC.setCustomername(xCompanyID)
                        LIC.setVersionnbr(xLicenseID)
                        'LIC.setXrtnxr1()
                        Dim WC As String = LIC.wc_PK_License(xLicenseID)
                        Dim B As Boolean = LIC.Update(WC)
                        If B = False Then
                            MessageBox.Show("ERROR: Failed to update existing license.")
                        Else
                            DBARCH.UpdateRemoteMachine(CustomerID, CurrServerName, "1", xLicenseID)
                            Me.dgLicense.SelectedRows(0).Cells("MachineID").Value = SelectedServer
                            SB.Text = Now.ToString + " : Failed to update existing license."
                            bLicenseLoaded = True
                            txtLicense.Text = xEncryptedLicense
                            btnPasteLicense_Click(Nothing, Nothing)
                            txtLicense.Text = ""
                            SB.Text = "License UPDATED."
                            btnDisplay_Click(Nothing, Nothing)
                        End If
                    End If
                Else
                    MessageBox.Show("002 - This license does not belong to the current Server '" + CurrServerName + "'. It cannot be applied.")
                    Return
                End If
            Else
                MessageBox.Show("001 - This license does not belong to the current Server '" + CurrServerName + "'. It cannot be applied.")
                Return
            End If
        End If
        '** If not,
        '** Check to see if the target server has an existing repository license.
        '**

    End Sub

    Private Sub btnShowCurrentDB_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnShowCurrentDB.Click
        Dim tMsg As String = ""
        tMsg += "User   Conn Str: " + My.Settings("UserDefaultConnString") + vbCrLf
        tMsg += "Config Conn Str: " + System.Configuration.ConfigurationManager.AppSettings("ECMREPO") + vbCrLf
        MessageBox.Show(tMsg)
    End Sub

    Private Sub btnSetEqual_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSetEqual.Click

        My.Settings("UserDefaultConnString") = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
        'My.Settings.Reset()
        'My.Settings("UserDefaultConnString") = "?"
        My.Settings.Save()
        SB.Text = "Settings saved to: " + My.Settings("UserDefaultConnString")
    End Sub

    Private Sub btnGetCustID_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnGetCustID.Click
        Dim LT As String = DBARCH.GetXrt(gCustomerName, gCustomerID)
        txtCompanyID.Text = LM.ParseLicCustomerID(LT, True)
    End Sub

    Sub AddTwoNewFields()

        Dim B As Boolean = False
        Dim ID As Integer = 240
        Dim S As String = ""

        S = S + " ALter table License Add SqlServerInstanceName nvarchar(254)"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        If B Then
            Console.WriteLine("GOOD")
        Else
            Console.WriteLine("BAD")
        End If

        S = " ALter table License Add SqlServerMachineName nvarchar(254)"
        B = DBARCH.ExecuteSqlNewConn(S, False)
        If B Then
            Console.WriteLine("GOOD")
        Else
            Console.WriteLine("BAD")
        End If

    End Sub

End Class
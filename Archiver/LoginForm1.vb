Imports System.Collections
Imports System.Collections.Generic

Imports System.IO
Imports ECMEncryption

Public Class LoginForm1

    Dim TRACEFLOW As String = System.Configuration.ConfigurationManager.AppSettings("TRACEFLOW")
    Dim CurrGatewaySvr As String = ""
    Dim AutoLoginSecs As Integer = 10
    Dim CurrLoginSecs As Integer = 0
    Dim LOG As New clsLogging
    Dim ISO As New clsIsolatedStorage
    Dim DBARCH As New clsDatabaseARCH
    Dim ENC As New ECMEncrypt
    Dim DMA As New clsDma
    Dim bHelpLoaded As Boolean = False
    Dim bAttached As Boolean = False
    Dim bPopulateComboBusy As Boolean = False
    Dim AutoSecs As Integer = 1
    Dim Tries As Integer = 1

    Public bGoodLogin As Boolean = False
    Public UID As String = ""

    Dim CurrSessionGuid As Guid = Guid.NewGuid

    Dim SecureID As Integer = -1

    Dim ListOfRepoIS As New System.Collections.Generic.List(Of String)
    Dim strRepos As String = ""
    Private osInfo As OperatingSystem

    Dim FQN As String = ""
    Dim CurrUserName As String = ""
    Dim dDebug As String = System.Configuration.ConfigurationManager.AppSettings("debug_frmReconMain")

    Private Sub LoginForm1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load


        If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9900, "LoginIn001", "00")

        lblExecTime.Visible = False
        btnStopExec.Visible = False

        Me.TopMost = False

        'InitPersistData()

        If TRACEFLOW.Equals(1) Then
            LOG.WriteToTraceLog("**********************************************************************")
            LOG.WriteToTraceLog("Start of Trace for LoginForm" + Now.ToString)
        End If

        Dim OSVersion As String = Environment.OSVersion.ToString()
        Dim OSVersionMajor As String = Environment.OSVersion.Version.Major.ToString
        Dim OSVersionMinor As String = Environment.OSVersion.Version.Minor.ToString
        Dim OSVersionMinorRev As String = Environment.OSVersion.Version.MinorRevision.ToString

        AddTemDir()

        If dDebug.Equals("1") Then
            LOG.WriteToTraceLog(Now.ToString + "Step 01 :Added the temp directory")
        End If

        If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9900, "LoginIn001", "01")


        If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9900, "LoginIn002", "02")
        CurrUserName = Environment.UserName

        If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9900, "LoginIn003", "03")

        getPersitData()
        If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9900, "LoginIn004", "04")

        lblAttachedMachineName.Text = LOG.getEnvVarMachineName
        lblNetworkID.Text = LOG.getEnvVarNetworkID

        If TRACEFLOW = 1 Then DBARCH.RemoteTrace(9900, "LoginIn005", "05")
        bRunnner = False

        If (UseDirectoryListener.Equals(0)) Then
            ckDisableListener.Visible = False
        End If

        'DBARCH.ckUpdateTbl()

    End Sub

    Private Sub OK_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles OK.Click

        Timer2.Enabled = False
        Timer3.Enabled = False

        If PasswordTextBox.Text.ToUpper.Equals("PASSWORD") Then
            If txtLoginID.Text.Length = 0 Then
                MessageBox.Show("Please enter your USERID into the Login ID field.")
                Return
            End If
            frmPasswordChange.ShowDialog()
            SB.Text = "Please login using your new credentials, thank you."
            Return
        End If

        If txtLoginID.Text.Length = 0 Then
            MessageBox.Show("Your user Login ID is required.")
            Return
        End If
        If PasswordTextBox.Text.Length = 0 Then
            MessageBox.Show("Your user Login Password is required.")
            Return
        End If

        lblAttachedMachineName.Text = gAttachedMachineName
        lblCurrUserGuidID.Text = txtLoginID.Text
        lblLocalIP.Text = gLocalMachineIP
        lblServerInstanceName.Text = gServerInstanceName
        lblServerMachineName.Text = gServerMachineName
        lblCurrUserGuidID.Text = txtLoginID.Text

        gCurrUserGuidID = txtLoginID.Text

        '*************************
        SaveStaticVars()
        '*************************
        SB.Text = "Logging in, standby."
        SB.Refresh()
        Application.DoEvents()

        Dim LoginID As String = txtLoginID.Text.Trim
        Dim PW As String = PasswordTextBox.Text.Trim
        Dim DecryptedPassword As String = ""
        Dim EncryptedPassword As String = ""
        Dim RetCode As Boolean = False

        Dim DHX As Integer = 99
        Dim ix As Integer = 0
        Dim rMsg As String = ""

        DHX = DBARCH.ckUserLoginExists(LoginID, RetCode, rMsg)
        ix = DHX

        If ix < 1 And rMsg.Length > 0 Then
            MessageBox.Show("FAILED TO ATTACH USER: " + rMsg)
        ElseIf ix < 1 Then
            MessageBox.Show("ERROR 01Q: FAILED TO ATTACH USER - verify your ID and password ")
        End If

        If ix = 1 Then
            Dim tpw As String = DBARCH.getBinaryPassword(LoginID)
            'MessageBox.Show("REMOVE THIS: TPW=" + tpw.ToString)
            If tpw.Trim.Length > 0 Then
                If tpw.ToUpper.Equals("PASSWORD") Then
                    If LoginID.ToUpper.Equals("ADMIN") Then
                        Dim Msg As String = ""
                        Msg = "It appears that this may be the first time into the system." + Environment.NewLine
                        Msg += "As an ADMIN, you will be required to change your " + Environment.NewLine + "current password of 'password' and," + Environment.NewLine
                        Msg += "any users will have to be added to the system if they" + Environment.NewLine + "are allowed to access ECM Library." + Environment.NewLine + Environment.NewLine
                        Msg += "Thank you for using ECM Library."
                        MessageBox.Show(Msg)
                    End If
PWOVER:
                    frmPasswordChange.ShowDialog()
                    Dim NewPw As String = frmPasswordChange.PW1
                    Dim NewPw2 As String = frmPasswordChange.PW2
                    NewPw = NewPw.Trim
                    NewPw2 = NewPw2.Trim
                    If NewPw.Equals(NewPw2) Then
                        Dim epw As String = ENC.AES256EncryptString(NewPw2)
                        Dim sEnc As String = "Update users set UserPassword = '" + epw + "' where UserLoginID = '" + LoginID + "' "
                        Dim BB2 As Boolean = DBARCH.ExecuteSqlNewConn(sEnc, False)
                        If BB2 Then
                            MessageBox.Show("Your password has been changed, for future logins, please use your new password.")
                            PW = NewPw
                        Else
                            MessageBox.Show("Your password failed to update, please cntact an administrator or try to login again, closing down.")
                            End
                        End If
                    Else
                        Tries += 1
                        If Tries >= 3 Then
                            MessageBox.Show("Too many tries, try logging in again from the start, closing down.")
                            End
                        End If
                        MessageBox.Show("The passwords do not equal each other, please reenter.")
                        GoTo PWOVER
                    End If
                End If
            End If
        Else
            MessageBox.Show("Your user login ID has not been defined to the system, please contact an administrator, closing down.")
            GoTo SKIPOUT
        End If

        frmPasswordChange.Dispose()

        EncryptedPassword = ENC.AES256EncryptString(PW)

        'MessageBox.Show("Remove this later WDM")

        Dim UPW As String = DBARCH.getPw(LoginID)
        If UPW.Equals(EncryptedPassword) Then
            UID = LoginID
            bGoodLogin = True
            Timer2.Enabled = False

            Me.Hide()

            Dim MainPage As frmMain = New frmMain
            MainPage.Show()

            Return
        Else
            UID = ""
            bGoodLogin = False
            MessageBox.Show("ERROR A12: Failed to login, please verify your User ID and password! ")
            Tries += 1
            If Tries >= 3 Then
                MessageBox.Show("Too many tries, try logging in again from the start, closing down.")
                End
            End If
        End If
SKIPOUT:
    End Sub

    Private Sub Cancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Cancel.Click
        bRunnner = False
        Me.Close()
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

    Private Sub ckSaveAsDefaultLogin_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckSaveAsDefaultLogin.CheckedChanged
        If ckSaveAsDefaultLogin.Checked Then
            'Write the info (encrypted) out to a file for use during the next login.
            SavePersist()
        Else
            'Remove the login file if it exists.
        End If
    End Sub

    Sub SaveStaticVars()

        If SecureID >= 0 Then
            gGateWayID = SecureID
            gSecureID = SecureID
        End If

        gUserID = txtLoginID.Text
        gActiveGuid = CurrSessionGuid
        gSessionGuid = CurrSessionGuid

        SavePersist()

    End Sub

    ''' <summary>
    ''' Saves the active parm.
    ''' </summary>
    ''' <param name="ParmName">Name of the parm.</param>
    ''' <param name="ParmVal"> The parm value.</param>
    'Sub SaveActiveParm(ByVal ParmName As String, ByVal ParmVal As String)
    '    If Not bAttached Then
    '        Return
    '    End If

    '    ProxySearch.ActiveSession(SecureID, CurrSessionGuid, ParmName, ParmVal)

    'End Sub

    Sub InitPersistData()
        ISO.PersistDataInit("CurrSessionGuid", "")
        ISO.PersistDataSave("CompanyID", "")
        ISO.PersistDataSave("RepoID", "")
        ISO.PersistDataSave("LoginID", "")
        ISO.PersistDataSave("EncryptPW", "")
        ISO.PersistDataSave("UPW", "")
        ISO.PersistDataSave("EOD", "***")
    End Sub

    Sub RemovePersist()
        ISO.PersistDataInit("NA", "NA")
    End Sub

    Sub SavePersist()
        'EncryptPhrase
        ISO.PersistDataInit("CurrSessionGuid", CurrSessionGuid.ToString)
        ISO.PersistDataSave("LoginID", txtLoginID.Text)
        TPW = ENC.AES256EncryptString(PasswordTextBox.Text.Trim)
        ISO.PersistDataSave("EncryptPW", TPW)

        ISO.PersistDataSave("AutoExecute", ckAutoExecute.Checked.ToString)

        Dim UPW As String = PasswordTextBox.Text.Trim
        UPW = ENC.AES256EncryptString(UPW)
        ISO.PersistDataSave("UPW", UPW)

        ISO.PersistDataSave("EOD", "***")
    End Sub

    Sub getPersitData()

        Dim SID As String = ISO.PersistDataRead("SecureID")
        If SID.Length > 0 Then
            SecureID = CInt(SID)
            gSecureID = SecureID
            gGateWayID = SecureID
        End If

        Dim strAutoExec As String = ISO.PersistDataRead("AutoExecute")
        If strAutoExec.ToUpper.Equals("TRUE") Then
            gAutoExec = True
            ckAutoExecute.Checked = True
            ckAutoExecute.CheckState = 1
            Timer3.Enabled = True
            btnStopExec.Visible = True
            lblExecTime.Visible = True
        Else
            gAutoExec = False
            ckAutoExecute.Checked = False
            ckAutoExecute.CheckState = 0
            Timer3.Enabled = False
            btnStopExec.Visible = False
            lblExecTime.Visible = False
        End If

        txtLoginID.Text = ISO.PersistDataRead("LoginID")

        Dim UPW As String = ISO.PersistDataRead("UPW")
        PasswordTextBox.Text = ENC.AES256DecryptString(UPW)

        Dim sCurrSessionGuid As String = ISO.PersistDataRead("CurrSessionGuid")
        If sCurrSessionGuid.Length > 0 Then
            CurrSessionGuid = New Guid(sCurrSessionGuid)
        Else
            CurrSessionGuid = New Guid()
        End If

    End Sub

    Private Sub Timer2_Tick(sender As System.Object, e As System.EventArgs) Handles Timer2.Tick
        If (ckCancelAutoLogin.Checked = True) Then
            Timer2.Enabled = False
        End If
        CurrLoginSecs += 1
        Dim i As Integer = AutoLoginSecs - CurrLoginSecs
        If CurrLoginSecs = AutoLoginSecs Then
            lblMsg.Text = "Logging in..."""
            OK_Click(Nothing, Nothing)
        Else
            lblMsg.Text = "SECS to Login: " + i.ToString
        End If

    End Sub

    Private Sub AddTemDir()
        If Not Directory.Exists("c:\TempUploads") Then
            Directory.CreateDirectory("c:\TempUploads")
        End If
    End Sub

    Private Sub cbRepoID_SelectedIndexChanged(sender As Object, e As EventArgs)
        'ISO.PersistDataSave("CompanyID", txtCompanyID.Text)
        'ISO.PersistDataSave("RepoID", cbRepoID.Text)

        'gCustomerID = txtCompanyID.Text
        'gRepoID = cbRepoID.Text

        'setGatewayEndpoints()
        Timer2.Enabled = False
    End Sub

    Private Sub txtCompanyID_TextChanged(sender As Object, e As EventArgs)
        Timer2.Enabled = False
    End Sub

    Private Sub ckCancelAutoLogin_CheckedChanged(sender As Object, e As EventArgs) Handles ckCancelAutoLogin.CheckedChanged

    End Sub

    Private Sub PictureBox1_MouseEnter(sender As Object, e As EventArgs) Handles PictureBox1.MouseEnter
        SB.Text = "D. Miller & Asso., LTD., Chicago, IL."
    End Sub

    Private Sub PictureBox1_MouseLeave(sender As Object, e As EventArgs) Handles PictureBox1.MouseLeave
        SB.Text = ""
    End Sub

    Private Sub btnChgPW_Click(sender As Object, e As EventArgs) Handles btnChgPW.Click

    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        Dim LoginID As String = txtLoginID.Text.Trim
        Dim UPW As String = DBARCH.getPw(LoginID)
        Dim EncPassword = ENC.AES256EncryptString(UPW)
        If UPW.Equals(EncPassword) Then
            MessageBox.Show("Password is good")
        Else
            MessageBox.Show("Password is BAD: " + UPW + " : " + EncPassword)
        End If
    End Sub

    Private Sub ckAutoExecute_CheckedChanged(sender As Object, e As EventArgs) Handles ckAutoExecute.CheckedChanged
        If ckAutoExecute.Checked And Not ckSaveAsDefaultLogin.Checked Then
            If gAutoExec.Equals(False) Then
                MessageBox.Show("Auto Execute cannot be set until Save As Default Login is set and checked... returning.")
            End If
        End If
        If ckAutoExecute.Checked And ckSaveAsDefaultLogin.Checked Then
            SavePersist()
        End If


    End Sub

    Private Sub btnStopExec_Click(sender As Object, e As EventArgs) Handles btnStopExec.Click
        Timer3.Enabled = False
        SB.Text = "Auto Execute Cancelled"
        gAutoExec = False
        btnStopExec.Visible = False
        lblExecTime.Visible = False
    End Sub

    Private Sub Timer3_Tick(sender As Object, e As EventArgs) Handles Timer3.Tick
        AutoSecs += 1
        lblExecTime.Text = "Executing in " + (10 - AutoSecs).ToString + " Secs."
        lblExecTime.Refresh()
        If AutoSecs.Equals(10) Then
            Console.WriteLine("Auto-execution started")
            OK.PerformClick()
        End If
    End Sub

    Private Sub ckDisableListener_CheckedChanged(sender As Object, e As EventArgs) Handles ckDisableListener.CheckedChanged
        If ckDisableListener.Checked Then
            gTempDisableDirListener = True
        Else
            gTempDisableDirListener = False
        End If
    End Sub
End Class
Imports ECMEncryption

Public Class frmMain

    Dim ENC As New ECMEncrypt

    Dim defaultNonsecureConnStr As String = "Data Source=@SERVER\@INSTANCE;Initial Catalog=@DB;Integrated Security=True; Connect Timeout = 30"
    Dim defaultConnStr As String = "Data Source=@SERVER\@INSTANCE;Initial Catalog=@DB;Persist Security Info=True;User ID=@UID;Password=@PW; Connect Timeout = 30"
    Dim defaultConfigKeyStringSecure As String = "<add key=`@KEY` value=`Data Source=@SERVER/@INSTANCE;Initial Catalog=@DB;Persist Security Info=True;User ID=@UID;Password=@PW; Connect Timeout = 15`/>"
    Dim ConfigKeyStringEnc As String = "<add key=`@KEY` value=`@ENCCS`/>"

    Dim AttachCurrConnStr As String = ""
    Dim CurrConnStr As String = ""
    Dim CompanyID As String = ""
    Dim EncPW As String = ""
    Dim RepoID As String = ""
    Dim bDisabled As Boolean = False
    Dim SvrName As String = ""
    Dim InstanceName As String = ""
    Dim SqlSvrLoginID As String = ""
    Dim SqlServerLoginPW As String = ""
    Dim ConnStr As String = ""
    Dim EncryptedCS As String = ""
    Dim DbName As String = ""

    Dim CurrColName As String = ""

    Dim ProxyGW As New SVCGateway.Service1Client()

    Private Sub btnAttach_Click(sender As Object, e As EventArgs) Handles btnAttach.Click
        Attach()
    End Sub

    Sub Attach()

        txtRemoteCS.Text = GenConnStr()

        gvar.gSVCGateway_CS = gvar.gCSGateWay

        If txtRemoteCS.Text.Length = 0 Then
            Return
        End If

        Dim RC As Boolean = False
        Dim RtnMsg As String = ""
        Dim EP As String = ProxyGW.Endpoint.ToString
        Dim B As Boolean = ProxyGW.AttachToSecureLoginDB(txtRemoteCS.Text, RC, RtnMsg)

        If B Then
            SB.Text = "Successfully attached to Secure Login Server."
            ckAttachedToSecureLoginMgr.Checked = True

            Label1.Visible = True
            cbCompanyID.Visible = True
            Label2.Visible = True
            txtEncPW.Visible = True
            Label3.Visible = True
            txtRepoID.Visible = True
            btnSave.Visible = True
            btnDelete.Visible = True
            'Label4.visible = true
            ckDisabled.Visible = True
            Label11.Visible = True
            txtConnStr.Visible = True
            Label10.Visible = True
            txtEncCS.Visible = True
            btnFetch.Visible = True
            dgConnStr.Visible = True
            txtRemoteCS.Visible = True
            hlGenConnectionString.Visible = True
            hlGenConfigKey.Visible = True
            hlTestDecryption.Visible = True

            btnTest.Visible = True
            btnEncrypt.Visible = True
            btnClipBoard.Visible = True
            btnShowRepo.Visible = True
            ckSuccess.Visible = True
            ckThesaurus.Visible = True
            btnTestGetCS.Visible = True

            btnEdit.Visible = True
            btnReorder.Visible = True

            gFunc.PopulateGrid(dgConnStr, txtRemoteCS.Text, cbCompanyID.Text.Trim, txtEncPW.Text, 0)
            gFunc.PopulateCombo(cbCompanyID, txtRemoteCS.Text, cbCompanyID.Text.Trim, txtEncPW.Text)

            'cbDatabase.Text.trim = ""
        Else
            MessageBox.Show("Failed to Attach: " + RtnMsg)
            ckAttachedToSecureLoginMgr.Checked = False

            btnEdit.Visible = False
            btnReorder.Visible = False

            Label1.Visible = False
            cbCompanyID.Visible = False
            Label2.Visible = False
            txtEncPW.Visible = False
            Label3.Visible = False
            txtRepoID.Visible = False
            btnSave.Visible = False
            btnDelete.Visible = False
            'Label4.visible = false
            ckDisabled.Visible = False
            Label11.Visible = False
            txtConnStr.Visible = False
            Label10.Visible = False
            txtEncCS.Visible = False
            btnFetch.Visible = False
            dgConnStr.Visible = False
            txtRemoteCS.Visible = False
            hlGenConnectionString.Visible = False
            hlGenConfigKey.Visible = False
            hlTestDecryption.Visible = False

            btnTest.Visible = False
            btnEncrypt.Visible = False
            btnClipBoard.Visible = False
            btnShowRepo.Visible = False
            ckSuccess.Visible = False
            ckThesaurus.Visible = False
            btnTestGetCS.Visible = False

        End If

    End Sub

    Function GenConnStr() As String
        Dim XConnStr As String = ""
        '"<add key=`@KEY` value=`Data Source=@SERVER\@INSTANCE;Initial Catalog=@DB;Persist Security Info=True;User ID=@UID;Password=@PW; Connect Timeout = 45`/>"

        Dim bAllDataSupplied As Boolean = True
        Dim ErrMsg As String = "Missing Login Data:" + vbCrLf

        CompanyID = cbCompanyID.Text.Trim
        EncPW = txtEncPW.Text
        RepoID = txtRepoID.Text
        bDisabled = ckDisabled.Checked
        SvrName = cbServers.Text.Trim
        InstanceName = cbInstance.Text.Trim
        SqlSvrLoginID = txtSSLoginID.Text
        SqlServerLoginPW = txtSSLoginPW.Text
        DbName = cbDatabase.Text.Trim

        If SvrName.Trim.Length = 0 Then
            bAllDataSupplied = False
            ErrMsg += "Sql Server SvrName" + vbCrLf
        End If
        If SqlSvrLoginID.Trim.Length = 0 Then
            bAllDataSupplied = False
            ErrMsg += "Sql Server Login ID" + vbCrLf
        End If
        If DbName.Trim.Length = 0 Then
            bAllDataSupplied = False
            ErrMsg += "Database Name" + vbCrLf
        End If
        If SqlServerLoginPW.Trim.Length = 0 Then
            bAllDataSupplied = False
            ErrMsg += "Sql Server Login Password" + vbCrLf
        End If

        If Not bAllDataSupplied Then
            MessageBox.Show(ErrMsg)
            Return ""
        End If

        Dim tConnStr = defaultConnStr

        If txtSSLoginID.Text.Length = 0 Then
            tConnStr = defaultNonsecureConnStr
        Else
            tConnStr = defaultConnStr
        End If

        If InstanceName.Length = 0 Then
            tConnStr = tConnStr.Replace("@SERVER\", SvrName)
            tConnStr = tConnStr.Replace("@INSTANCE", "")
        Else
            tConnStr = tConnStr.Replace("@SERVER", SvrName)
            tConnStr = tConnStr.Replace("@INSTANCE", InstanceName)
        End If

        tConnStr = tConnStr.Replace("@DB", DbName)
        tConnStr = tConnStr.Replace("@UID", SqlSvrLoginID)
        tConnStr = tConnStr.Replace("@PW", SqlServerLoginPW)
        tConnStr = tConnStr.Replace("`", Chr(34))

        XConnStr = tConnStr

        Dim ddbug As Boolean = False
        If ddbug.Equals(True) Then
            MessageBox.Show("CS: " + XConnStr)
        End If
        Return XConnStr

    End Function

    Private Sub frmMain_Load(sender As Object, e As EventArgs) Handles MyBase.Load

    End Sub

    Private Sub btnTest_Click(sender As Object, e As EventArgs) Handles btnTest.Click
        TestConnection()
    End Sub

    Sub TestConnection()
        txtConnStr.Text = GenConnStr()
        Dim RC As Boolean = False
        Dim RtnMsg As String = ""

        Dim B As Boolean = ProxyGW.AttachToSecureLoginDB(txtConnStr.Text, RC, RtnMsg)
        If B Then
            ckAttachedToSecureLoginMgr.Checked = True
            SB.Text = "Successfully attached to Repository: " + cbDatabase.Text.Trim
            btnSave.Visible = True
            ckSuccess.Checked = True
            If B = False Then
                MsgBox("You are not currently attached to the Secure Login Server")
                'btnSave.Visible = True
            Else
                'gFunc.PopulateCombo(cbCompanyID, txtRemoteCS.Text, cbCompanyID.Text.trim, txtEncPW.Text)
                MsgBox("TEST SUCCESSSFUL - You can attach to the Secure Attach Server")
            End If
        Else
            MessageBox.Show("ERROR: Failed to attach to Secure Attach Server: " + cbDatabase.Text.Trim + vbCrLf + RtnMsg)
            'btnSave.Visible = False
            ckSuccess.Checked = False
        End If
    End Sub

    Function EncryptCS() As String
        Dim S As String = ""
        Try
            S = ENC.EncryptPhrase(txtConnStr.Text, "")
        Catch ex As Exception
            S = ""
            MessageBox.Show("Failed to encrypt connection string." + vbCrLf + ex.Message)
        End Try
        Return S
    End Function

    Sub SaveConnection()

        'If ckAttachedToSecureLoginMgr.Checked = False Then
        '    MsgBox("You are not currently attached to the Secure Login Server")
        '    btnSave.Visible = True
        '    Return
        'End If

        'Dim RC As Boolean = True
        'Dim RtnMsg As String = ""
        'Dim Disabled As Boolean = ckDisabled.Checked
        'Dim S As String = GenConnStr()
        'txtEncCS.Text = ENC.EncryptPhrase(S)
        'Dim EncCS As String = txtEncCS.Text
        'Dim SecureDBcs As String = txtRemoteCS.Text

        'CompanyID = cbCompanyID.Text.trim
        'If CompanyID.Length = 0 Then
        '    MessageBox.Show("Company ID is required, returning.")
        '    Return
        'End If
        'If CompanyID.Length = 0 Then
        '    MessageBox.Show("Company ID is required, returning.")
        '    Return
        'End If
        'If txtEncPW.Text.Length = 0 Then
        '    MessageBox.Show("Encryption Password is required, returning.")
        '    Return
        'End If
        'EncPW = ENC.EncryptPhrase(txtEncPW.Text)

        'If txtRepoID.Text.Length = 0 Then
        '    MessageBox.Show("The Repository ID is required, returning.")
        '    Return
        'End If

        'RepoID = txtRepoID.Text.Trim

        'Dim SecureLoginConnStr As String = txtRemoteCS.Text
        'Dim isThsaurus As Boolean = ckThesaurus.Checked
        'Dim B As Boolean = ProxyGW.saveConnection(SecureLoginConnStr, CompanyID, EncPW, RepoID, EncCS, Disabled, isThsaurus, RC, RtnMsg)
        'If B Then
        '    SB.Text = "Successfully processed the Repository: " + cbDatabase.Text.trim
        '    btnSave.Visible = True
        '    ckSuccess.Checked = True
        '    gFunc.PopulateGrid(dgConnStr, txtRemoteCS.Text, cbCompanyID.Text.trim, txtEncPW.Text)

        '    'Dim ProxyGW2 As New SVC_Gateway.Service1Client
        '    'Dim GatewayUserId As String = ENC.EncryptPhrase(txtSSLoginID.Text)
        '    'Dim encCompanyid As String = ENC.EncryptPhrase(CompanyID)
        '    'Dim encRepoID As String = ENC.EncryptPhrase(RepoID)
        '    'Dim RetMsg As String = ""
        '    ''wdm - see which fields are encrypted
        '    'ProxyGW2.saveAttach(EncCS, EncPW, encCompanyid, encRepoID, GatewayUserId, "1", RC, RetMsg)
        '    'ProxyGW2 = Nothing
        'Else
        '    MessageBox.Show("Failed to process the Repository: " + cbDatabase.Text.trim + vbCrLf + RtnMsg)
        '    btnSave.Visible = False
        '    ckSuccess.Checked = False
        'End If
    End Sub

    Sub ClipBoardCS()
        Try
        Catch ex As Exception

        End Try
    End Sub

    Sub DisableConnection()
        Try
        Catch ex As Exception

        End Try
    End Sub

    Sub GenConnStrKeyString()

        '"<add key=`@KEY` value=`Data Source=@SERVER/@INSTANCE;Initial Catalog=@DB;Persist Security Info=True;User ID=@UID;Password=@PW; Connect Timeout = 45`/>"
        CompanyID = cbCompanyID.Text.Trim
        EncPW = txtEncPW.Text
        RepoID = txtRepoID.Text
        bDisabled = ckDisabled.Checked
        SvrName = cbServers.Text.Trim
        InstanceName = cbInstance.Text.Trim
        SqlSvrLoginID = txtSSLoginID.Text
        SqlServerLoginPW = txtSSLoginPW.Text
        DbName = cbDatabase.Text.Trim

        Dim tConnStr = defaultConnStr

        If InstanceName.Length = 0 Then
            tConnStr = tConnStr.Replace("@SERVER/", SvrName)
            tConnStr = tConnStr.Replace("@INSTANCE", "")
        Else
            tConnStr = tConnStr.Replace("@SERVER", SvrName)
            tConnStr = tConnStr.Replace("@INSTANCE", InstanceName)
        End If

        tConnStr = tConnStr.Replace("@DB", DbName)
        tConnStr = tConnStr.Replace("@UID", SqlSvrLoginID)
        tConnStr = tConnStr.Replace("@PW", SqlServerLoginPW)
        tConnStr = tConnStr.Replace("`", Chr(34))

        Clipboard.Clear()
        Clipboard.SetText(tConnStr)
        MessageBox.Show("The Config Key is in the clipboard.")

    End Sub

    Private Sub Button1_Click(sender As Object, e As EventArgs) Handles Button1.Click
        cbServers.Text = "SVR2016"
        cbDatabase.Text = "ECM.SecureLogin"
        txtSSLoginID.Text = "ecmlibrary"
        txtSSLoginPW.Text = "Junebug1"
    End Sub

    Private Sub btnFetch_Click(sender As Object, e As EventArgs) Handles btnFetch.Click
        fetchAttaches()
    End Sub

    Sub fetchAttaches()
        If ckAttachedToSecureLoginMgr.Checked = False Then
            MsgBox("You are not currently attached to the Secure Login Server")
            btnSave.Visible = True
            Return
        End If

        Dim RC As Boolean = True
        Dim RtnMsg As String = ""
        Dim Disabled As Boolean = ckDisabled.Checked
        Dim S As String = GenConnStr()
        txtEncCS.Text = ENC.EncryptPhrase(S, "")
        Dim EncCS As String = txtEncCS.Text
        Dim SecureDBcs As String = txtRemoteCS.Text

        CompanyID = cbCompanyID.Text.Trim
        If CompanyID.Length = 0 Then
            MessageBox.Show("Company ID is required, returning.")
            Return
        End If

        If CompanyID = "*ALL" Then
            gFunc.PopulateGrid(dgConnStr, txtRemoteCS.Text, cbCompanyID.Text.Trim, txtEncPW.Text, 0)
        Else
            gFunc.PopulateGrid(dgConnStr, txtRemoteCS.Text, cbCompanyID.Text.Trim, txtEncPW.Text, 1)
        End If

    End Sub

    Private Sub btnShowRepo_Click(sender As Object, e As EventArgs) Handles btnShowRepo.Click
        Dim Msg As String = ""
        Dim ConnStr As String = ""
        Dim CID As String = cbCompanyID.Text.Trim
        Dim RC As Boolean = False
        Dim RetTxt As String = ""

        Dim S As String = ProxyGW.PopulateRepoCombo(ConnStr, CompanyID, RC, RetTxt)
        If S.Length > 0 Then
            Dim A() As String = S.Split("|")
            For I As Integer = 0 To A.Length - 1
                Msg = Msg + A(I) + vbCrLf
            Next
            MessageBox.Show(Msg)
        End If
    End Sub

    Private Sub btnDelete_Click(sender As Object, e As EventArgs) Handles btnDelete.Click
        deleteCompany()
    End Sub

    Private Sub deleteCompany()
        Dim CID As String = cbCompanyID.Text.Trim
        Dim SVR As String = cbServers.Text.Trim
        Dim DBID As String = cbDatabase.Text.Trim
        Dim InstanceID = cbInstance.Text.Trim
        If InstanceID.Length = 0 Or InstanceID.ToUpper.Trim.Equals("NA") Then
            InstanceID = ""
        End If
        Dim RC As Boolean = True
        Dim RtnMsg As String = ""
        Dim tdict As Dictionary(Of String, String) = New Dictionary(Of String, String)
        tdict.Add("CompanyID", CID)
        tdict.Add("SvrName", SVR)
        tdict.Add("DBName", DBID)
        tdict.Add("InstanceID", InstanceID)
        Dim B As Boolean = gvar.gProxyGW.DeleteExistingConnection(gvar.gSVCGateway_CS, tdict, RC, RtnMsg)
        If B = True Then
            fetchAttaches()
            MessageBox.Show("Successful delete")
        Else
            MessageBox.Show("Failed to delete")
        End If
    End Sub

    Private Sub btnEncrypt_Click(sender As Object, e As EventArgs) Handles btnEncrypt.Click
        Dim S As String = ""
        S = EncryptCS()
        txtEncCS.Text = S
    End Sub

    Private Sub btnClipBoard_Click(sender As Object, e As EventArgs) Handles btnClipBoard.Click
        Dim tConnStr As String = GenConnStr()
        Clipboard.Clear()
        Clipboard.SetText(tConnStr)
        MessageBox.Show("The Config Key is in the clipboard.")
    End Sub

    Private Sub btnTestGetCS_Click(sender As Object, e As EventArgs) Handles btnTestGetCS.Click
        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        CompanyID = cbCompanyID.Text.Trim
        RepoID = txtRepoID.Text

        If CompanyID.Length = 0 Or RepoID.Length = 0 Then
            MessageBox.Show("Both a company id and a repo id muct be supplied.")
            Return
        End If

        Dim EncS As String = ProxyGW.getConnection(CompanyID, RepoID, RC, RetMsg)

        If EncS.Length > 0 Then
            Dim S As String = ENC.AES256DecryptString(EncS)
            txtConnStr.Text = S
            txtEncCS.Text = EncS
        Else
            MessageBox.Show("ERROR: " + RetMsg)
        End If
    End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        SaveConnection()
    End Sub

    Private Sub btnEdit_Click(sender As Object, e As EventArgs) Handles btnEdit.Click
        gvar.gDataGrid = dgConnStr
        Dim NewWindow As frmDetail = New frmDetail()
        NewWindow.Show()
    End Sub

    Private Sub btnReorder_Click(sender As Object, e As EventArgs) Handles btnReorder.Click
        gFunc.setDefaultColOrder(dgConnStr)
    End Sub

    Private Sub btnDuplicate_Click(sender As Object, e As EventArgs) Handles btnDuplicate.Click

        Dim I As Integer = dgConnStr.CurrentCell.RowIndex

        If I < 0 Then
            MessageBox.Show("Please select a ROW to duplicate... returning")
            Return
        End If

        Dim tDict As Dictionary(Of String, String) = New Dictionary(Of String, String)
        tDict = grid.GetRowCellValues(dgConnStr, I)
        Dim CS As String = tDict("EncPW")
        Dim B As Boolean = ProxyGW.duplicateEntry(CS, tDict)

        If (B.Equals(True)) Then
            fetchAttaches()
        End If
    End Sub

    Private Sub btnSyncUsers_Click(sender As Object, e As EventArgs) Handles btnSyncUsers.Click
        syncusers()
    End Sub

    Public Sub syncusers()
        Cursor = Cursors.AppStarting
        Dim CID As String = cbCompanyID.Text.Trim
        Dim RID As String = txtRepoID.Text
        Console.WriteLine("CID:", CID)
        Console.WriteLine("RID:", RID)
        Dim syncusers As String = ProxyGW.updateRepoUsers(CID, RID)
        Cursor = Cursors.Arrow
    End Sub

    Private Sub hlGenConnectionString_Click(sender As Object, e As EventArgs) Handles hlGenConnectionString.Click
        txtConnStr.Text = GenConnStr()
    End Sub

    Private Sub hlGenConfigKey_Click(sender As Object, e As EventArgs) Handles hlGenConfigKey.Click

        '"<add key=`@KEY` value=`@ENCCS`/>"
        Dim S As String = txtEncCS.Text
        Dim S2 As String = ConfigKeyStringEnc
        S2 = S2.Replace("@KEY", txtRepoID.Text.Trim)
        S2 = S2.Replace("@ENCCS", S)
        S2.Replace("`", ChrW(34))
        Clipboard.Clear()
        Clipboard.SetText(S2.Trim)
        MessageBox.Show("Config KEY string in the clipboard.")

    End Sub

    Private Sub hlTestDecryption_Click(sender As Object, e As EventArgs) Handles hlTestDecryption.Click
        Dim tCompanyID = cbCompanyID.Text.Trim
        Dim tRepoID = txtRepoID.Text
        Dim LoginPassword = txtEncPW.Text
        LoginPassword = ENC.EncryptPhrase(LoginPassword, "")
        Dim RC As Boolean = False
        Dim RetMsg As String = ""

        Dim EncryptedString As String = ""
        Dim DecryptedString As String = ""
        EncryptedString = ProxyGW.getSecureKey(tCompanyID, tRepoID, LoginPassword, RC, RetMsg)
        DecryptedString = ENC.AES256DecryptString(EncryptedString)

        MessageBox.Show(DecryptedString)
    End Sub

    Private Function setDictItems() As Dictionary(Of String, String)
        Dim tDict As Dictionary(Of String, String) = New Dictionary(Of String, String)

        Dim val As String = ""


        val = cbServers.Text.Trim
        val = ENC.EncryptPhrase(val, "")
        tDict.Add("SvrName", val)

        val = cbDatabase.Text.Trim
        val = ENC.EncryptPhrase(val, "")
        tDict.Add("DBName", val)

        val = cbInstance.Text.Trim
        val = ENC.EncryptPhrase(val, "")
        tDict.Add("InstanceName", val)

        val = txtSSLoginID.Text
        val = ENC.EncryptPhrase(val, "")
        tDict.Add("LoginID", val)

        val = txtSSLoginPW.Text
        val = ENC.EncryptPhrase(val, "")
        tDict.Add("LoginPW", val)

        '**** ABOVE HERE IS NEW ****

        val = ckDisabled.Checked.ToString
        val = ENC.EncryptPhrase(val, "")
        tDict.Add("Disabled", val)


        val = ckThesaurus.Checked.ToString
        val = ENC.EncryptPhrase(val, "")
        tDict.Add("isThesaurus", val)

        val = txtRepoID.Text
        val = ENC.EncryptPhrase(val, "")
        tDict.Add("RepoID", val)

        val = cbCompanyID.Text.Trim
        val = ENC.EncryptPhrase(val, "")
        tDict.Add("CompanyID", val)


        val = cbCompanyID.Text.Trim
        val = ENC.EncryptPhrase(val, "")
        tDict.Add("CompanyID", val)

        val = txtEncPW.Text
        val = ENC.EncryptPhrase(val, "")
        tDict.Add("EncPW", val)


        'Cs = tDict("Cs")
        'CSThesaurus = tDict("CSThesaurus")
        'CSHive = tDict("CSHive")
        'CSRepo = tDict("CSRepo")
        'CSDMALicense = tDict("CSDMALicense")
        'CSGateWay = tDict("CSGateWay")
        'CSTDR = tDict("CSTDR")
        'CSKBase = tDict("CSKBase")

        'gSVCFS_Endpoint = tDict("SVCFS_Endpoint")
        'gSVCFS_Endpoint = ENC.AES256DecryptString(gSVCFS_Endpoint, RC, RetMsg)

        'gSVCGateway_Endpoint = tDict("SVCGateway_Endpoint")
        'gSVCGateway_Endpoint = ENC.AES256DecryptString(gSVCGateway_Endpoint, RC, RetMsg)

        'gSVCCLCArchive_Endpoint = tDict("SVCCLCArchive_Endpoint")
        'gSVCCLCArchive_Endpoint = ENC.AES256DecryptString(gSVCCLCArchive_Endpoint, RC, RetMsg)

        'gSVCSearch_Endpoint = tDict("SVCSearch_Endpoint")
        'gSVCSearch_Endpoint = ENC.AES256DecryptString(gSVCSearch_Endpoint, RC, RetMsg)

        'gSVCDownload_Endpoint = tDict("SVCDownload_Endpoint")
        'gSVCDownload_Endpoint = ENC.AES256DecryptString(gSVCDownload_Endpoint, RC, RetMsg)

        'gvar.gCreateDate = tDict("CreateDate")
        'gvar.gLastModDate = tDict("LastModDate")

        ''gvar.gDisabled = False
        ''gvar.gThesaurus = False

        'gvar.gRowID = tDict("RowID")

        'gvar.gRepoID = tDict("RepoID")
        'gvar.gCompanyID = tDict("CompanyID")
        'gvar.gEncPW = ENC.AES256DecryptString(tDict("EncPW"))
        'gvar.gCs = ENC.AES256DecryptString(tDict("CS"))
        'gvar.gCSThesaurus = ENC.AES256DecryptString(tDict("CSThesaurus"))
        'gvar.gCSHive = ENC.AES256DecryptString(tDict("CSHive"))
        'gvar.gCSRepo = ENC.AES256DecryptString(tDict("CSRepo"))
        'gvar.gCSDMALicense = ENC.AES256DecryptString(tDict("CSDMALicense"))
        'gvar.gCSGateWay = ENC.AES256DecryptString(tDict("CSGateWay"))
        'gvar.gCSTDR = ENC.AES256DecryptString(tDict("CSTDR"))
        'gvar.gCSKBase = ENC.AES256DecryptString(tDict("CSKBase"))

        'gvar.gSVCFS_Endpoint = tDict("SVCFS_Endpoint")
        'gvar.gSVCGateway_Endpoint = tDict("SVCGateway_Endpoint")
        'gvar.gSVCCLCArchive_Endpoint = tDict("SVCCLCArchive_Endpoint")
        'gvar.gSVCSearch_Endpoint = tDict("SVCSearch_Endpoint")
        'gvar.gSVCDownload_Endpoint = tDict("SVCDownload_Endpoint")

        Return tDict
    End Function

    Private Sub dgConnStr_SelectionChanged(sender As Object, e As EventArgs) Handles dgConnStr.SelectionChanged
        If dgConnStr.SelectedRows.Count() = 0 Then
            Return
        End If

        Dim I As Integer = dgConnStr.CurrentCell.RowIndex
        If I < 0 Then
            Return
        End If

        Dim tDict As Dictionary(Of String, String) = New Dictionary(Of String, String)
        tDict = grid.GetRowCellValues(dgConnStr, I)

        gvar.gCreateDate = tDict("CreateDate")
        gvar.gLastModDate = tDict("LastModDate")

        'gvar.gDisabled = False
        'gvar.gThesaurus = False

        gvar.gRowID = tDict("RowID")

        gvar.gRepoID = tDict("RepoID")
        gvar.gCompanyID = tDict("CompanyID")
        gvar.gEncPW = ENC.AES256DecryptString(tDict("EncPW"))
        gvar.gCS = ENC.AES256DecryptString(tDict("CS"))
        gvar.gCSThesaurus = ENC.AES256DecryptString(tDict("CSThesaurus"))
        gvar.gCSHive = ENC.AES256DecryptString(tDict("CSHive"))
        gvar.gCSRepo = ENC.AES256DecryptString(tDict("CSRepo"))
        gvar.gCSDMALicense = ENC.AES256DecryptString(tDict("CSDMALicense"))
        gvar.gCSGateWay = ENC.AES256DecryptString(tDict("CSGateWay"))
        gvar.gCSTDR = ENC.AES256DecryptString(tDict("CSTDR"))
        gvar.gCSKBase = ENC.AES256DecryptString(tDict("CSKBase"))

        gvar.gSVCFS_Endpoint = tDict("SVCFS_Endpoint")
        gvar.gSVCGateway_Endpoint = tDict("SVCGateway_Endpoint")
        gvar.gSVCCLCArchive_Endpoint = tDict("SVCCLCArchive_Endpoint")
        gvar.gSVCSearch_Endpoint = tDict("SVCSearch_Endpoint")
        gvar.gSVCDownload_Endpoint = tDict("SVCDownload_Endpoint")

        Console.WriteLine("done")

        'Dim iCol As Integer = 0

        'iCol = grid.getColumnIndexByName(dgConnStr, "EncPW")
        'Dim strEnc As String = tDict("EncPW")

        cbCompanyID.Text = gvar.gCompanyID
        txtEncPW.Text = gvar.gEncPW
        txtRepoID.Text = gvar.gRepoID
        txtEncCS.Text = tDict("CS")
        Dim encCS As String = tDict("CS")
        txtConnStr.Text = gvar.gCS

        'syncusers()
    End Sub
End Class
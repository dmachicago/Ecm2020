
Imports System.Data.SqlClient
Imports ECMEncryption

Public Class frmDetail

    Dim ENC As New ECMEncrypt
    Dim UM As New clsUserMgt
    Dim RC As Boolean = True
    Dim RtnMsg As String = ""
    Dim SelWidget As String = ""
    Dim ConnStr As String = ""

    Sub New()

        ' This call is required by the designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        ResetScreen()
        ConnStr = getConnStr()
        getCompanyID()
    End Sub

    Private Sub btntest_Click(sender As Object, e As EventArgs) Handles btntest.Click
        If cbInstance.Text.ToUpper.Equals("NA") Then
            cbInstance.Text = ""
        End If
        GenConnStr()
        Dim CS As String = txtGenCS.Text.Trim
        If (CS.Length = 0) Then
            GenConnStr()
            CS = txtGenCS.Text.Trim
        End If

        If (CS.Length = 0) Then
            MessageBox.Show("Please build a connection string to test... aborting.")
            Return
        End If

        TestConnection(CS)
    End Sub


    Sub GenConnStr()

        If cbInstance.Text.ToUpper.Equals("NA") Then
            cbInstance.Text = ""
        End If

        Dim XConnStr As String = ""
        '"<add key=`@KEY` value=`Data Source=@SERVER\@INSTANCE;Initial Catalog=@DB;Persist Security Info=True;User ID=@UID;Password=@PW; Connect Timeout = 45`/>"
        '<add key="ECM_ThesaurusConnectionString" value="Data Source=SVR2016; Initial Catalog=ECM.Thesaurus; Integrated Security=True;  Connect Timeout = 10;" />
        '<add key="ECMSecureLogin" value="Data Source=108.60.211.158;Initial Catalog=ECM.SecureLogin;Persist Security Info=True;User ID=ecmlibrary;Password=@@PW@@; Timeout=30;"/>
        'Data Source=ecmadmin.db.3591434.hostedresource.com; Initial Catalog=ecmadmin; User ID=ecmadmin; Password='Junebug1';
        Dim bAllDataSupplied As Boolean = True
        Dim ErrMsg As String = "Missing Login Data:" + vbCrLf

        Dim CompanyID As String = cbCompanyID.Text.Trim
        Dim EncPW As String = txtEncPW.Text
        Dim RepoID As String = txtRepoID.Text
        Dim bDisabled As String = ckDisabled.Checked
        Dim SvrName As String = cbServers.Text.Trim
        Dim InstanceName As String = cbInstance.Text.Trim
        If InstanceName.Trim.Equals("NA") Then
            InstanceName = ""
        End If
        Dim SqlSvrLoginID As String = txtSSLoginID.Text
        Dim SqlServerLoginPW As String = txtSSLoginPW.Text
        Dim DbName As String = cbDatabase.Text.Trim
        Dim bWindowsAUth As Boolean = ckWinAuth.Checked

        If (InstanceName.Trim.ToUpper.Equals("NA")) Then
            InstanceName = ""
        End If

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
            Return
        End If

        Dim tConnStr = "Data Source=" + SvrName.Trim

        If cbInstance.Text.Trim.Length > 0 Then
            tConnStr += "\" + cbInstance.Text.Trim
        End If

        tConnStr += ";"

        tConnStr += "Initial Catalog=" + cbDatabase.Text.Trim + ";"
        If ckWinAuth.Checked Then
            tConnStr += "Integrated Security=True; "
        Else
            tConnStr += "Persist Security Info=True; User ID = " + txtSSLoginID.Text + "; Password = " + txtSSLoginPW.Text.Trim + ";"
        End If

        If txtConnTimeout.Text.Trim.Length > 0 Then
            tConnStr += "Connect Timeout=" + txtConnTimeout.Text.Trim + ";"
        End If

        txtGenCS.Text = tConnStr
    End Sub

    Sub TestConnection(CS As String)
        If cbInstance.Text.ToUpper.Equals("NA") Then
            cbInstance.Text = ""
        End If
        If (CS.Length = 0) Then
            MessageBox.Show("A connection string is required, returning.")
            Return
        End If
        Dim RC As Boolean = False
        Dim RtnMsg As String = ""

        Dim B As Boolean = gvar.gProxyGW.AttachToSecureLoginDB(CS, RC, RtnMsg)
        If B Then
            MessageBox.Show("Successfully attached to Repository: " + CS)
        Else
            MessageBox.Show("Failed to attach to : " + CS)
        End If
    End Sub

    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles btnGenerate.Click
        If cbInstance.Text.ToUpper.Equals("NA") Then
            cbInstance.Text = ""
        End If
        GenConnStr()
    End Sub

    Private Sub btnCopy_Click(sender As Object, e As EventArgs) Handles btnCopy.Click
        GenConnStr()
        Dim S As String = txtGenCS.Text.Trim
        Clipboard.Clear()
        Clipboard.SetText(S)
        MessageBox.Show("Connection string in the clipboard.")
    End Sub


    Private Sub lblCSThesaurus_Click(sender As Object, e As EventArgs) Handles lblCSThesaurus.Click
        TestConnection(txtCSThesaurus.Text)
    End Sub

    Private Sub lblCSHive_Click(sender As Object, e As EventArgs) Handles lblCSHive.Click
        TestConnection(txtCSHive.Text)
    End Sub

    Private Sub lblCSRepo_Click(sender As Object, e As EventArgs) Handles lblCSRepo.Click
        TestConnection(txtCSRepo.Text)
    End Sub

    Private Sub lblCSDMALicense_Click(sender As Object, e As EventArgs) Handles lblCSDMALicense.Click
        TestConnection(txtCSDMALicense.Text)
    End Sub

    Private Sub lblCSGateWay_Click(sender As Object, e As EventArgs) Handles lblCSGateWay.Click
        TestConnection(txtCSGateWay.Text)
    End Sub

    Private Sub lblCSTDR_Click(sender As Object, e As EventArgs) Handles lblCSTDR.Click
        MessageBox.Show("Coming in a future release...")
        'TestConnection(txtCSTDR.Text)
    End Sub

    Private Sub lblCSKBase_Click(sender As Object, e As EventArgs) Handles lblCSKBase.Click
        TestConnection(txtCSKBase.Text)
    End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click

        If txtRepoID.Text.Trim.Length = 0 Then
            MessageBox.Show("A Repo Location must be provided, returning...")
            Return
        End If
        SetVars()

        Dim GCS As String = ENC.AES256EncryptString(getConnStr())

        Dim B As Boolean = gvar.gProxyGW.saveConnection(GCS, gFunc.gDict, RC, RtnMsg)
        If B = True Then
            MessageBox.Show("Successful save")
        Else
            MessageBox.Show("Failed to save")
        End If
    End Sub

    Function getTxtCode(S As String) As String

        Dim X As Integer = 0
        Dim c As String = ""

        For index As Integer = 0 To S.Length - 1
            c = S.Substring(index, 1)
            Select Case c
                Case "0"
                    X += 2
                Case "1"
                    X += 2
                Case "2"
                    X += 3
                Case "3"
                    X += 4
                Case "4"
                    X += 5
                Case "5"
                    X += 6
                Case "6"
                    X += 7
                Case "7"
                    X += 8
                Case "8"
                    X += 9
                Case "9"
                    X += 10
                Case "A"
                    X += 11
                Case "B"
                    X += 12
                Case "C"
                    X += 13
                Case "D"
                    X += 14
                Case "E"
                    X += 15
                Case "F"
                    X += 16
                Case "G"
                    X += 17
                Case "H"
                    X += 18
                Case "I"
                    X += 19
                Case "J"
                    X += 20
                Case "K"
                    X += 22
                Case "L"
                    X += 23
                Case "M"
                    X += 24
                Case "N"
                    X += 25
                Case "O"
                    X += 26
                Case "P"
                    X += 27
                Case "Q"
                    X += 28
                Case "R"
                    X += 29
                Case "S"
                    X += 30
                Case "T"
                    X += 31
                Case "U"
                    X += 32
                Case "V"
                    X += 33
                Case "W"
                    X += 34
                Case "X"
                    X += 35
                Case "Y"
                    X += 36
                Case "Z"
                    X += 37
                Case Else
                    X += 38
            End Select
        Next

        Return X.ToString

    End Function

    Private Sub setRepoID()

        Dim DoThis As Boolean = False
        If DoThis Then
            Dim CompanyID As String = cbCompanyID.Text.Trim.ToUpper
            Dim gSvrName As String = cbServers.Text.Trim.ToUpper
            Dim gDBName As String = cbDatabase.Text.Trim.ToUpper
            Dim gInstanceName As String = cbInstance.Text.Trim.ToUpper
            Dim RepoID As String = CompanyID + gSvrName + gDBName + gInstanceName
            CompanyID = CompanyID + "-" + getTxtCode(RepoID)
            txtRepoID.Text = CompanyID
        End If
    End Sub


    Private Sub EncryptVars()

        gFunc.LoadDictVals("CompanyID", ENC.AES256EncryptString(gvar.gCompanyID))
        gFunc.LoadDictVals("EncPW", ENC.AES256EncryptString(gvar.gEncPW))
        gFunc.LoadDictVals("RepoID", ENC.AES256EncryptString(gvar.gRepoID))
        gFunc.LoadDictVals("CS", ENC.AES256EncryptString(gvar.gCS))
        gFunc.LoadDictVals("Disabled", ENC.AES256EncryptString(gvar.gDisabled))
        gFunc.LoadDictVals("RowID", ENC.AES256EncryptString(gvar.gRowID))
        gFunc.LoadDictVals("isThesaurus", ENC.AES256EncryptString(gvar.gisThesaurus))
        gFunc.LoadDictVals("CSRepo", ENC.AES256EncryptString(gvar.gCSRepo))
        gFunc.LoadDictVals("CSThesaurus", ENC.AES256EncryptString(gvar.gCSThesaurus))
        gFunc.LoadDictVals("CSHive", ENC.AES256EncryptString(gvar.gCSHive))
        gFunc.LoadDictVals("CSDMALicense", ENC.AES256EncryptString(gvar.gCSDMALicense))
        gFunc.LoadDictVals("CSGateWay", ENC.AES256EncryptString(gvar.gCSGateWay))
        gFunc.LoadDictVals("CSTDR", ENC.AES256EncryptString(gvar.gCSTDR))
        gFunc.LoadDictVals("CSKBase", ENC.AES256EncryptString(gvar.gCSKBase))
        gFunc.LoadDictVals("CreateDate", ENC.AES256EncryptString(gvar.gCreateDate))
        gFunc.LoadDictVals("LastModDate", ENC.AES256EncryptString(gvar.gLastModDate))
        gFunc.LoadDictVals("SVCFS_Endpoint", ENC.AES256EncryptString(gvar.gSVCFS_Endpoint))
        gFunc.LoadDictVals("SVCGateway_Endpoint", ENC.AES256EncryptString(gvar.gSVCGateway_Endpoint))
        gFunc.LoadDictVals("SVCCLCArchive_Endpoint", ENC.AES256EncryptString(gvar.gSVCCLCArchive_Endpoint))
        gFunc.LoadDictVals("SVCSearch_Endpoint", ENC.AES256EncryptString(gvar.gSVCSearch_Endpoint))
        gFunc.LoadDictVals("SVCDownload_Endpoint", ENC.AES256EncryptString(gvar.gSVCDownload_Endpoint))
        gFunc.LoadDictVals("SVCFS_CS", ENC.AES256EncryptString(gvar.gSVCFS_CS))
        gFunc.LoadDictVals("SVCGateway_CS", ENC.AES256EncryptString(gvar.gSVCGateway_CS))
        gFunc.LoadDictVals("SVCSearch_CS", ENC.AES256EncryptString(gvar.gSVCSearch_CS))
        gFunc.LoadDictVals("SVCDownload_CS", ENC.AES256EncryptString(gvar.gSVCDownload_CS))
        gFunc.LoadDictVals("SVCThesaurus_CS", ENC.AES256EncryptString(gvar.gSVCThesaurus_CS))


        gFunc.LoadDictVals("SvrName", ENC.AES256EncryptString(gvar.gSvrName))
        gFunc.LoadDictVals("DBName", ENC.AES256EncryptString(gvar.gDBName))
        gFunc.LoadDictVals("InstanceName", ENC.AES256EncryptString(gvar.gInstanceName))

        gFunc.LoadDictVals("LoginID", ENC.AES256EncryptString(gvar.gLoginID))
        gFunc.LoadDictVals("LoginPW", ENC.AES256EncryptString(gvar.gLoginPW))
        gFunc.LoadDictVals("ConnTimeout", ENC.AES256EncryptString(gvar.gConnTimeout))
        gFunc.LoadDictVals("ckWinAuth", gvar.gckWinAuth)
        gFunc.LoadDictVals("GateWayServerCS", ENC.AES256EncryptString(getConnStr()))

    End Sub

    Private Sub SetVars()

        'ENC.AES256DecryptString(tDict("CS"))
        'gvar.gCreateDate = Now
        gvar.gLastModDate = Now
        If ckDisabled.Checked Then
            gvar.gDisabled = "1"
        Else
            gvar.gDisabled = "0"
        End If

        If isThesaurus.Checked Then
            gvar.gisThesaurus = "1"
        Else
            gvar.gisThesaurus = "0"
        End If


        gvar.gckWinAuth = ckWinAuth.Checked.ToString
        gvar.gEncPW = txtSSLoginPW.Text
        gvar.gConnTimeout = txtConnTimeout.Text.Trim
        gvar.gSvrName = cbServers.Text.Trim
        gvar.gDBName = cbDatabase.Text.Trim
        gvar.gInstanceName = cbInstance.Text.Trim

        gvar.gLoginID = txtSSLoginID.Text.Trim
        gvar.gLoginPW = txtSSLoginPW.Text.Trim

        gvar.gRepoID = txtRepoID.Text.Trim
        gvar.gCompanyID = cbCompanyID.Text.Trim
        gvar.gEncPW = txtEncPW.Text.Trim
        gvar.gSVCGateway_CS = txtCSGateWay.Text.Trim
        gvar.gCSThesaurus = txtCSThesaurus.Text.Trim
        gvar.gCSHive = txtCSHive.Text.Trim
        gvar.gCSRepo = txtCSRepo.Text.Trim
        gvar.gCSDMALicense = txtCSDMALicense.Text.Trim
        gvar.gCSGateWay = getConnStr()
        gvar.gCSTDR = txtCSTDR.Text.Trim
        gvar.gCSKBase = txtCSKBase.Text.Trim
        gvar.gSVCFS_Endpoint = txtSVCFS_Endpoint.Text.Trim
        gvar.gSVCGateway_Endpoint = txtSVCGateway_Endpoint.Text.Trim
        gvar.gSVCCLCArchive_Endpoint = txtSVCCLCArchive_Endpoint.Text.Trim
        gvar.gSVCSearch_Endpoint = txtSVCSearch_Endpoint.Text.Trim
        gvar.gSVCDownload_Endpoint = txtSVCDownload_Endpoint.Text.Trim

        gvar.gCompanyID = cbCompanyID.Text.Trim
        gvar.gEncPW = txtEncPW.Text.Trim
        gvar.gRepoID = txtRepoID.Text.Trim
        gvar.gCS = txtGenCS.Text.Trim
        gvar.gDisabled = ckDisabled.Checked.ToString
        gvar.gRowID = ""    'RowID.Text.trim
        gvar.gisThesaurus = isThesaurus.Checked.ToString
        gvar.gCSRepo = txtCSRepo.Text.Trim
        gvar.gCSThesaurus = txtCSThesaurus.Text.Trim
        gvar.gCSHive = txtCSHive.Text.Trim
        gvar.gCSDMALicense = ""     'CSDMALicense.Text.trim
        gvar.gCSGateWay = getConnStr()
        gvar.gCSTDR = txtCSTDR.Text.Trim
        gvar.gCSKBase = txtCSKBase.Text.Trim
        gvar.gCreateDate = DateTime.Now
        gvar.gLastModDate = DateTime.Now
        gvar.gSVCFS_Endpoint = txtSVCFS_Endpoint.Text.Trim
        gvar.gSVCGateway_Endpoint = txtSVCGateway_Endpoint.Text.Trim
        gvar.gSVCCLCArchive_Endpoint = txtSVCCLCArchive_Endpoint.Text.Trim
        gvar.gSVCSearch_Endpoint = txtSVCSearch_Endpoint.Text.Trim
        gvar.gSVCDownload_Endpoint = txtSVCDownload_Endpoint.Text.Trim
        gvar.gSVCFS_CS = txtGenCS.Text.Trim
        gvar.gSVCGateway_CS = txtCSGateWay.Text.Trim
        gvar.gSVCSearch_CS = txtCSRepo.Text.Trim
        gvar.gSVCDownload_CS = txtCs.Text.Trim
        gvar.gSVCThesaurus_CS = txtCSThesaurus.Text.Trim
        gvar.gSvrName = cbServers.Text.Trim
        gvar.gDBName = cbDatabase.Text.Trim
        gvar.gInstanceName = cbInstance.Text.Trim
        gvar.gLoginID = txtSSLoginID.Text.Trim
        gvar.gLoginPW = txtSSLoginPW.Text.Trim
        gvar.gConnTimeout = txtConnTimeout.Text.Trim
        gvar.gckWinAuth = ckWinAuth.Checked.ToString

        EncryptVars()

        Dim ddebug As Boolean = False
        If ddebug.Equals(True) Then
            Dim str As String = ""
            For Each pair As KeyValuePair(Of String, String) In gFunc.gDict
                str = str & pair.Key & " " & pair.Value & vbCrLf
            Next
            MessageBox.Show(str)
        End If

    End Sub

    Private Sub btnDelete_Click(sender As Object, e As EventArgs) Handles btnDelete.Click
        'SetVars()
        Dim CID As String = cbCompanyID.Text.Trim
        Dim RID As String = txtRepoID.Text

        Dim tdict As Dictionary(Of String, String) = New Dictionary(Of String, String)
        tdict.Add("CompanyID", CID)
        tdict.Add("RepoID", RID)
        tdict.Add("RowID", gvar.gRowID)
        Dim B As Boolean = gvar.gProxyGW.DeleteExistingConnection(gvar.gCSGateWay, tdict, RC, RtnMsg)
        If B = True Then
            MessageBox.Show("Successful delete")
        Else
            MessageBox.Show("Failed to delete")
        End If
    End Sub

    Private Sub btnReset_Click(sender As Object, e As EventArgs) Handles btnReset.Click
        ResetScreen()
    End Sub
    Private Sub ResetScreen()

        lblCreateDateVal.Text = gvar.gCreateDate
        lblLastModifiedDateVal.Text = gvar.gLastModDate

        'gvar.gDisabled = False
        'gvar.gThesaurus = False

        lblRowIDValue.Text = gvar.gRowID

        txtRepoID.Text = gvar.gRepoID
        cbCompanyID.Text = gvar.gCompanyID
        txtEncPW.Text = gvar.gEncPW
        txtCs.Text = gvar.gSVCGateway_CS
        txtCSThesaurus.Text = gvar.gCSThesaurus
        txtCSHive.Text = gvar.gCSHive
        txtCSRepo.Text = gvar.gCSRepo
        txtCSDMALicense.Text = gvar.gCSDMALicense
        txtCSGateWay.Text =
        txtCSTDR.Text = gvar.gCSTDR
        txtCSKBase.Text = gvar.gCSKBase
        txtSVCFS_Endpoint.Text = gvar.gSVCFS_Endpoint
        txtSVCGateway_Endpoint.Text = gvar.gSVCGateway_Endpoint
        txtSVCCLCArchive_Endpoint.Text = gvar.gSVCCLCArchive_Endpoint
        txtSVCSearch_Endpoint.Text = gvar.gSVCSearch_Endpoint
        txtSVCDownload_Endpoint.Text = gvar.gSVCDownload_Endpoint

    End Sub

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        Me.Close()
    End Sub

    Private Sub btnClose_Click(sender As Object, e As EventArgs) Handles btnClose.Click
        SetVars()
        Me.Close()
    End Sub

    Private Sub txtCSThesaurus_Enter(sender As Object, e As EventArgs) Handles txtCSThesaurus.Enter
        lblCurrSel.Text = "txtCSThesaurus"
        SelWidget = "txtCSThesaurus"
        ParseCs(txtCSThesaurus.Text.Trim)
    End Sub


    Private Function getCSToken(token As String, CS As String) As String
        Dim S As String = ""
        Dim TempCS As String = CS.Trim.ToUpper
        token = token.ToUpper
        Dim j As Integer = 0
        Dim K As Integer = 0
        Dim I As Integer = TempCS.IndexOf(token)
        If I >= 0 Then
            j = TempCS.IndexOf("=", I)
            If j > 0 Then
                K = TempCS.IndexOf(";", j)
                If K >= 0 Then
                    S = CS.Substring(j + 1, K - j - 1)
                Else
                    S = CS.Substring(j + 1)
                End If
            End If
        End If
        Return S.Trim
    End Function

    Private Sub ParseCs(CS As String)
        '<add key="ECM_ThesaurusConnectionString" value="Data Source=SVR2016; Initial Catalog=ECM.Thesaurus; Integrated Security=True;  Connect Timeout = 10;" />
        '<add key="ECMSecureLogin" value="Data Source=108.60.211.158;Initial Catalog=ECM.SecureLogin;Persist Security Info=True;User ID=ecmlibrary;Password=@@PW@@; Timeout=30;"/>
        Dim Server As String = ""
        Dim InitCat As String = ""
        Dim InstanceName As String = ""
        Dim IntegratedSec As String = ""
        Dim PersistSec As String = ""
        Dim ConnTimeOUT As String = ""
        Dim PW As String = ""
        Dim PersistSecurityInfo As String = ""
        Dim UserID As String = ""
        'Data Source=97.76.174.190;Initial Catalog=ECM.Hive;Persist Security Info=True;User ID=sa;Password=Junebug1; Connect Timeout =  45;

        Server = getCSToken("Data Source", CS)
        cbServers.Text = Server

        If Server.Contains("\") Then
            Dim I As Integer = Server.IndexOf("\")
            InstanceName = Server.Substring(I + 1)
            Server = Server.Substring(0, I)
            cbServers.Text = Server
        End If

        cbInstance.Text = InstanceName

        InitCat = getCSToken("Initial Catalog", CS)
        cbDatabase.Text = InitCat

        IntegratedSec = getCSToken("Integrated Security Info", CS)
        PersistSec = getCSToken("Persist Security Info", CS)
        If IntegratedSec.Length > 0 Then
            ckWinAuth.Checked = True
        End If
        If PersistSec.Length > 0 Then
            ckWinAuth.Checked = False
            UserID = getCSToken("User ID", CS)
            txtSSLoginID.Text = UserID
            PW = getCSToken("Password", CS)
            txtSSLoginPW.Text = PW
        End If

        ConnTimeOUT = getCSToken("Connect Timeout", CS)
        txtConnTimeout.Text = ConnTimeOUT

    End Sub

    Private Sub txtCSHive_Enter(sender As Object, e As EventArgs) Handles txtCSHive.Enter
        lblCurrSel.Text = "txtCSHive"
        SelWidget = "txtCSHive"
        ParseCs(txtCSHive.Text.Trim)
    End Sub

    Private Sub txtCSRepo_Enter(sender As Object, e As EventArgs) Handles txtCSRepo.Enter
        lblCurrSel.Text = "txtCSRepo"
        SelWidget = "txtCSRepo"
        ParseCs(txtCSRepo.Text.Trim)
    End Sub

    Private Sub txtCSDMALicense_Enter(sender As Object, e As EventArgs) Handles txtCSDMALicense.Enter
        lblCurrSel.Text = "txtCSDMALicense"
        SelWidget = "txtCSDMALicense"
        ParseCs(txtCSDMALicense.Text.Trim)
    End Sub

    Private Sub txtCSGateWay_Enter(sender As Object, e As EventArgs) Handles txtCSGateWay.Enter
        lblCurrSel.Text = "txtCSGateWay"
        SelWidget = "txtCSGateWay"
        ParseCs(txtCSGateWay.Text.Trim)
    End Sub

    Private Sub txtCSTDR_Enter(sender As Object, e As EventArgs)
        lblCurrSel.Text = "txtCSTDR"
        SelWidget = "txtCSTDR"
        ParseCs(txtCSTDR.Text.Trim)
    End Sub

    Private Sub txtCSTDR_Enter_1(sender As Object, e As EventArgs) Handles txtCSTDR.Enter
        lblCurrSel.Text = "txtCSTDR"
        SelWidget = "txtCSTDR"
        ParseCs(txtCSTDR.Text.Trim)
    End Sub

    Private Sub txtCSKBase_Enter(sender As Object, e As EventArgs) Handles txtCSKBase.Enter
        lblCurrSel.Text = "txtCSKBase"
        SelWidget = "txtCSKBase"
        ParseCs(txtCSKBase.Text.Trim)
    End Sub

    Private Sub isThesaurus_CheckedChanged(sender As Object, e As EventArgs) Handles isThesaurus.CheckedChanged

    End Sub

    Private Sub ckDisabled_CheckedChanged(sender As Object, e As EventArgs) Handles ckDisabled.CheckedChanged

    End Sub

    Private Sub getCompanyID()
        cbCompanyID.Items.Clear()
        'Dim MyList As List(Of String) = New List(Of String)()
        Dim MyList As String
        MyList = gvar.gProxyGW.getCompanyID(ConnStr).ToString
        Dim words As String() = MyList.Split(New Char() {"|"c})
        Dim word As String
        For Each word In words
            cbCompanyID.Items.Add(word)
            If words.Count = 1 Then
                cbCompanyID.Text = word.Trim
            End If
        Next

    End Sub
    Private Sub getServers()
        Dim CompanyID As String = cbCompanyID.Text.Trim
        cbServers.Items.Clear()
        'Dim MyList As List(Of String) = New List(Of String)()
        Dim MyList As String
        MyList = gvar.gProxyGW.getServers(ConnStr, CompanyID)
        Dim words As String() = MyList.Split(New Char() {"|"c})
        Dim word As String
        For Each word In words
            cbServers.Items.Add(word)
            If words.Count = 1 Then
                cbServers.Text = word
            End If
        Next
    End Sub
    Private Sub getDatabases()
        Dim CompanyID As String = cbCompanyID.Text.Trim
        Dim SvrName As String = cbServers.Text.Trim
        cbDatabase.Items.Clear()
        Dim MyList As String
        MyList = gvar.gProxyGW.getDatabases(ConnStr, CompanyID, SvrName)
        Dim words As String() = MyList.Split(New Char() {"|"c})
        Dim word As String
        For Each word In words
            cbDatabase.Items.Add(word)
            If words.Count = 1 Then
                cbDatabase.Text = word
            End If
        Next
    End Sub
    Private Sub getInstance()
        Dim CompanyID As String = cbCompanyID.Text.Trim
        Dim SvrName As String = cbServers.Text.Trim
        Dim DBName As String = cbDatabase.Text.Trim
        cbInstance.Items.Clear()
        Dim MyList As String
        MyList = gvar.gProxyGW.getInstance(ConnStr, CompanyID, SvrName, DBName)
        Dim words As String() = MyList.Split(New Char() {"|"c})
        Dim word As String
        Dim tgtWord As String = ""
        For Each word In words
            If (word.ToUpper.Equals("NA")) Then
                word = ""
            End If

            If word.Length > 0 Then
                cbInstance.Items.Add(word)
                tgtWord = word
            End If

        Next
        If words.Count = 1 And tgtWord.Length > 0 Then
            cbInstance.Text = tgtWord
        End If
    End Sub

    Private Function getConnStr() As String
        Dim CS As String = ""
        Dim reader As New System.Configuration.AppSettingsReader
        CS = reader.GetValue("GateWayServerCS", GetType(String))
        Return CS
    End Function

    Private Sub cbCompanyID_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cbCompanyID.SelectedIndexChanged
        getServers()
    End Sub

    Private Sub cbCompanyID_SelectedValueChanged(sender As Object, e As EventArgs) Handles cbCompanyID.SelectedValueChanged
        getServers()
    End Sub

    Private Sub cbServers_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cbServers.SelectedIndexChanged
        getDatabases()
    End Sub

    Private Sub cbDatabase_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cbDatabase.SelectedIndexChanged
        getInstance()
    End Sub

    Private Sub btnFetch_Click(sender As Object, e As EventArgs) Handles btnFetch.Click
        Dim MyList As String
        Dim CompanyID As String = cbCompanyID.Text.Trim
        Dim SvrName As String = cbServers.Text.Trim
        Dim DBName As String = cbDatabase.Text.Trim
        Dim InstanceName As String = cbInstance.Text.Trim

        MyList = gvar.gProxyGW.getAttachData(ConnStr, CompanyID, SvrName, DBName, InstanceName)
        Dim tDict As Dictionary(Of String, String) = New Dictionary(Of String, String)()
        Dim val As String = ""
        Dim words As String() = MyList.Split(New Char() {"|"c})
        Dim word As String
        For Each word In words
            word = word.Replace("[", "")
            word = word.Replace("]", "")
            Dim vars As String() = word.Split(New Char() {","c})
            If word.Length > 0 Then
                tDict.Add(vars(0).Trim, vars(1).Trim)
            End If
        Next

        cbCompanyID.Text = tDict("CompanyID")

        val = tDict("EncPW")

        txtRepoID.Text = tDict("RepoID")
        val = tDict("CS")

        Dim ConnTimeout As String = ENC.AES256DecryptString(tDict("ConnTimeout"))
        txtConnTimeout.Text = ConnTimeout

        If tDict("ckWinAuth").Equals(True) Then
            ckWinAuth.Checked = 1
        Else
            ckWinAuth.Checked = 0
        End If
        If tDict("Disabled").Equals(True) Then
            ckDisabled.Checked = True
        Else
            ckDisabled.Checked = False
        End If
        If tDict("isThesaurus").Equals("True") Then
            isThesaurus.Checked = True
        Else
            isThesaurus.Checked = False
        End If

        val = tDict("RowID")

        txtCSRepo.Text = ENC.AES256DecryptString(tDict("CSRepo"))

        txtCSThesaurus.Text = ENC.AES256DecryptString(tDict("CSThesaurus"))
        txtCSHive.Text = ENC.AES256DecryptString(tDict("CSHive"))
        'txtCSDMALicense.Text = ENC.AES256DecryptString(tDict("CSDMALicense"),"")
        txtCSDMALicense.Text = ""
        txtCSGateWay.Text = ENC.AES256DecryptString(tDict("CSGateWay"))
        txtCSTDR.Text = ENC.AES256DecryptString(tDict("CSTDR"))
        txtCSKBase.Text = ENC.AES256DecryptString(tDict("CSKBase"))

        lblCreateDateVal.Text = tDict("CreateDate")
        lblLastModifiedDateVal.Text = tDict("LastModDate")

        txtSVCFS_Endpoint.Text = ENC.AES256DecryptString(tDict("SVCFS_Endpoint"))
        txtSVCGateway_Endpoint.Text = ENC.AES256DecryptString(tDict("SVCGateway_Endpoint"))
        txtSVCCLCArchive_Endpoint.Text = ENC.AES256DecryptString(tDict("SVCCLCArchive_Endpoint"))
        txtSVCSearch_Endpoint.Text = ENC.AES256DecryptString(tDict("SVCSearch_Endpoint"))
        txtSVCDownload_Endpoint.Text = ENC.AES256DecryptString(tDict("SVCDownload_Endpoint"))

        val = tDict("SVCFS_CS")
        val = tDict("SVCGateway_CS")
        val = tDict("SVCSearch_CS")
        val = tDict("SVCDownload_CS")
        val = tDict("SVCThesaurus_CS")

        cbServers.Text = tDict("SvrName")
        cbDatabase.Text = tDict("DBName")
        cbInstance.Text = tDict("InstanceName")

        txtSSLoginID.Text = ENC.AES256DecryptString(tDict("LoginID"))
        txtSSLoginPW.Text = ENC.AES256DecryptString(tDict("LoginPW"))

    End Sub

    Private Function replaceDb(S As String, DBName As String) As String
        If S.Length = 0 Then
            MessageBox.Show("Missing COnn string, please retry...")
            Return "-"
        End If
        Dim tgtstr As String = ""
        Dim s1 As String = ""
        Dim s2 As String = ""
        Dim i As Integer = 0
        Dim j As Integer = 0
        i = S.IndexOf("Catalog")
        j = S.IndexOf("=", i)
        i = j + 1
        s1 = S.Substring(0, i)
        j = S.IndexOf(";", i)
        s2 = S.Substring(j)
        tgtstr = s1 + DBName + s2
        Return tgtstr
    End Function

    Private Sub btnPromote_Click(sender As Object, e As EventArgs) Handles btnPromote.Click
        'Data Source=ECM2016;Initial Catalog=ECM.Library.FS;Persist Security Info=True; User ID = sa; Password = Junebug1;

        If MessageBox.Show("This will ALTER all connection strings, ARE YOU SURE", "Set All Connection Strings", MessageBoxButtons.YesNo) = Windows.Forms.DialogResult.No Then
            Return
        End If

        txtCSRepo.Text = ""
        txtCSHive.Text = ""
        txtCSHive.Text = ""
        txtCSKBase.Text = ""
        txtCSGateWay.Text = ""
        txtCSThesaurus.Text = ""
        txtSVCFS_Endpoint.Text = ""
        txtSVCGateway_Endpoint.Text = ""
        txtSVCCLCArchive_Endpoint.Text = ""
        txtSVCSearch_Endpoint.Text = ""
        txtSVCDownload_Endpoint.Text = ""


        If cbInstance.Text.ToUpper.Trim.Equals("NA") Then
            cbInstance.Text = ""
        End If
        GenConnStr()

        Dim S As String = txtGenCS.Text
        Dim tgtstr As String = ""

        txtCSRepo.Text = S

        tgtstr = replaceDb(S, "TDR")
        txtCSTDR.Text = tgtstr

        tgtstr = replaceDb(S, "ECM.Hive")
        txtCSHive.Text = tgtstr

        tgtstr = replaceDb(S, "ECM.Language")
        txtCSKBase.Text = tgtstr

        tgtstr = replaceDb(S, "ECM.SecureLogin")
        txtCSGateWay.Text = tgtstr

        tgtstr = replaceDb(S, "ECM.Thesaurus")
        txtCSThesaurus.Text = tgtstr

        Dim var As String = ""
        Dim DB As String = cbDatabase.Text.Trim

        var = "http://" + DB + "/ECMSaas/SearchSvc/SearchSVC.svc"
        txtSVCFS_Endpoint.Text = var
        var = "http://" + DB + "/ECMSaas/SecureSvc/SearchSVC.svc"
        txtSVCGateway_Endpoint.Text = var
        var = "http//ECM.SecureLogin/SecureSVC.svc"
        txtSVCCLCArchive_Endpoint.Text = var
        var = "http//" + DB + "/ECMSaas/Search/Search.svc"
        txtSVCSearch_Endpoint.Text = var
        var = "http//" + DB + "/ECMSaas/SVCclcDownload/DownloadSVC.svc"
        txtSVCDownload_Endpoint.Text = var

    End Sub

    Private Sub btnUsers_Click(sender As Object, e As EventArgs) Handles btnUsers.Click
        UM.setGuids()
        UM.SyncPW()
        UM.getActiveUsers()
        GC.Collect()
        GC.WaitForPendingFinalizers()
        MessageBox.Show("Users pulled into Gateway - please open User Mgt screen for details.")

    End Sub

    Private Sub cbInstance_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cbInstance.SelectedIndexChanged
        If cbInstance.Text.Trim.ToUpper.Equals("NA") Then
            cbInstance.Text = ""
        End If
    End Sub

    Private Sub cbInstance_SelectedValueChanged(sender As Object, e As EventArgs) Handles cbInstance.SelectedValueChanged
        If cbInstance.Text.Trim.ToUpper.Equals("NA") Then
            cbInstance.Text = ""
        End If
    End Sub

    Private Sub cbInstance_TextChanged(sender As Object, e As EventArgs) Handles cbInstance.TextChanged
        If cbInstance.Text.Trim.ToUpper.Equals("NA") Then
            cbInstance.Text = ""
        End If
        setRepoID()
    End Sub

    Private Sub cbCompanyID_TextChanged(sender As Object, e As EventArgs) Handles cbCompanyID.TextChanged
        setRepoID()
    End Sub

    Private Sub cbServers_TextChanged(sender As Object, e As EventArgs) Handles cbServers.TextChanged
        setRepoID()
    End Sub

    Private Sub cbDatabase_TextChanged(sender As Object, e As EventArgs) Handles cbDatabase.TextChanged
        setRepoID()
    End Sub

    Private Sub btnUserMgt_Click(sender As Object, e As EventArgs) Handles btnUserMgt.Click
        UM.setGuids()
        gCompanyID = cbCompanyID.Text
        gSvrName = cbServers.Text
        gDBName = cbDatabase.Text
        gInstanceName = cbInstance.Text
        gRepoID = txtRepoID.Text

        gGatewayCS = txtCSGateWay.Text
        gRepoCS = txtCSRepo.Text


        Dim NewWindow As frmUser = New frmUser()
        NewWindow.Show()

    End Sub
End Class

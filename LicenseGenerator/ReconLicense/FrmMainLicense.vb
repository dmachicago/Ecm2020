Imports System.IO
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Configuration.ConfigurationSettings
Imports ECMEncryption
Imports System.Net.Mail

Public Class FrmMainLicense

    Dim ENC As New ECMEncrypt
    Dim LIC As New clsLICENSE
    Dim DMA As New clsDma
    Dim DB As New clsDatabase
    Dim RL As New clsRemoteLICENSE

    Dim SqlInstanceName As String = ""
    Dim ServerName As String = " "
    Dim LicenseData$ = ""

    Private Sub FrmMainLicense_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'TODO: This line of code loads data into the '_DMA_UD_LicenseDataSet.License' table. You can move, or remove it, as needed.
        'Me.LicenseTableAdapter.Fill(Me._DMA_UD_LicenseDataSet.License)

        Dim CS As String = ""

        Dim reader As New System.Configuration.AppSettingsReader
        CS = reader.GetValue("DMA_UD_License", GetType(String))

        PopulateGrid()

        dtExpire.Enabled = False

        gCurrServerType = "local"

    End Sub
    Function AppendData(ByVal Key$, ByVal tVal$) As String
        Dim S = ""
        DMA.ReplaceSingleQuotes(tVal)
        DMA.ReplaceVerticalBar(tVal)
        LicenseData$ = LicenseData$ & "|" & Key$ & "|" & tVal
        Debug.Print("Length = " + LicenseData$.Length.ToString)
        Return LicenseData$
    End Function

    Private Sub btnGenerateLicense_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnGenerateLicense.Click
        ServerName = txtServerName.Text.Trim
        SqlInstanceName = txtSSINstance.Text.Trim
        'If ServerName.Length = 0  Then
        '    MsgBox("Server name  must be supplied, returning.")
        '    Return
        'End If

        If cbLicenseType.Text.Trim.Length = 0 Then
            MsgBox("Please select the License Type, returning.", MsgBoxStyle.Critical, "Required Data Missing")
            Return
        End If

        GenLicense()
        setDictVars()

        Dim B As Boolean = False

        LIC.setCompanyresetid(txtCompanyResetID.Text.Trim)
        LIC.setCustomerid(txtCustID.Text.Trim)
        LIC.setCustomername(txtCustName.Text.Trim)
        LIC.setLicense(txtLicense.Text)
        LIC.setLicenseexpiredate(CDate(dtExpire.Text).ToString)
        LIC.setLicensegendate(Now.ToString)
        If Not IsNumeric(txtVersionNbr.Text) Then
            MsgBox("Version Number MUST be numeric, aborting.")
            Return
        End If
        LIC.setLicenseid(txtVersionNbr.Text)
        LIC.setMasterpw(txtMstrPw.Text.Trim)
        If Not IsNumeric(txtNbrSeats.Text) Then
            MsgBox("Number of seats MUST be numeric, aborting.")
            Return
        End If
        LIC.setNbrseats(txtNbrSeats.Text)
        If Not IsNumeric(txtNbrSeats.Text) Then
            MsgBox("Number of seats MUST be numeric, aborting.")
            Return
        End If

        LIC.setCompanycountry(Me.txtCustCountry.Text)
        LIC.setCompanycity(txtCity.Text.Trim)
        LIC.setNbrsimlusers(txtNbrSimlSeats.Text.Trim)
        LIC.setContactname(txtContactName.Text.Trim)
        LIC.setContactemail(txtContactEmail.Text.Trim)
        LIC.setContactphonenbr(txtContactPhone.Text.Trim)
        LIC.setCompanystreetaddress(txtCustAddr.Text.Trim)
        LIC.setCompanystate(cbState.Text)
        LIC.setCompanyzip(txtZip.Text)
        LIC.setMaintexpiredate(CDate(dtMaintExpire.Text).ToString)
        LIC.setLicenseTypeCode(cbLicenseType.Text.Trim)
        LIC.setSdk(ckSdk.Checked)
        LIC.setLease(ckLease.Checked)

        If Not IsNumeric(txtMaxClients.Text) Then
            MsgBox("Only numeric data allowed in Max Clients.")
            Return
        End If
        LIC.setMaxClients(txtMaxClients.Text)

        If Not IsNumeric(txtSharePointNbr.Text) Then
            MsgBox("Only numeric data allowed in Max SharePoint DBs.")
            Return
        End If
        LIC.setSharePointNbr(Me.txtSharePointNbr.Text)

        Dim iCnt As Integer = LIC.cnt_PK_License(txtCustName.Text, txtCustID.Text.Trim)
        If iCnt > 0 Then
            MsgBox("This account already exists... check your data.")
            Return
        End If

        B = LIC.Insert(ServerName, SqlInstanceName)

        If Not B Then
            MsgBox("Failed to add new license... aborting.")
            Return
        Else

            UpdateGateway()

            Dim S = ""
            If ckSdk.Checked Then
                S = "Update License set ckSdk = 1 where CustomerID = '" + txtCustID.Text.Trim + "' "
            Else
                S = "Update License set ckSdk = 0 where CustomerID = '" + txtCustID.Text.Trim + "' "

            End If
            B = DB.ExecuteSqlNewConn(S)
            If B Then
                SB.Text = "Customer Information Set."
            End If

            S = ""
            If ckLease.Checked Then
                S = "Update License set ckLease = 1 where CustomerID = '" + txtCustID.Text.Trim + "' "
            Else
                S = "Update License set ckLease = 0 where CustomerID = '" + txtCustID.Text.Trim + "' "
            End If
            B = DB.ExecuteSqlNewConn(S)
            If B Then
                SB.Text = "Customer Information Set."
            End If


            SB.Text = "License data written to database."
        End If

        If ckToFile.Checked Then
            Dim FQN As String = ""
            txtCustID.Text = DMA.RemoveSingleQuotes(txtCustID.Text.Trim)

            Dim tFile As String = DMA.CheckFileName(txtCustID.Text.Trim)
            FQN = "C:\temp\" + txtCustID.Text.Trim + "." + txtVersionNbr.Text.Trim + ".lic"
            B = SaveTextToFile(Me.txtLicense.Text, FQN)
            If Not B Then
                MsgBox("Failed to write " + FQN)
            Else
                MsgBox("License written to:" + vbCrLf + vbCrLf + FQN)
            End If
        End If

        If ckToEmail.Checked Then
            MsgBox("EMAIL is not implemented to date...")
        End If
        If ckToClipboard.Checked Then
            Clipboard.SetText(Me.txtLicense.Text)
        End If
        PopulateGrid()

    End Sub

    Private Sub btnViewLicense_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnWriteToFile.Click
        setDictVars()

        ServerName = txtServerName.Text.Trim
        SqlInstanceName = txtSSINstance.Text.Trim
        If ServerName.Length = 0 Then
            MsgBox("The SERVER name must be supplied, returning.")
            Return
        End If

        Dim FQN As String = ""
        Dim B As Boolean = False

        txtCustID.Text = DMA.RemoveSingleQuotes(txtCustID.Text.Trim)

        Dim tFile As String = DMA.CheckFileName(txtCustID.Text.Trim)
        FQN = "C:\temp\LicenseFile." + txtCustID.Text.Trim + "." + txtVersionNbr.Text.Trim + ".lic"
        B = SaveTextToFile(Me.txtLicense.Text, FQN)
        If Not B Then
            MsgBox("Failed to write " + FQN)
        Else
            MsgBox("License written to:" + vbCrLf + vbCrLf + FQN)
        End If
    End Sub

    Function GenLicense() As String

        Dim EncryptedLicense As String = ""
        Dim LicenseData As String = ""
        ServerName = txtServerName.Text.Trim
        SqlInstanceName = txtSSINstance.Text.Trim
        If ServerName.Length = 0 Then
            MsgBox("The SERVER name must be supplied, returning.")
            Return ""
        End If

        If cbLicenseType.Text.Trim.Length = 0 Then
            MsgBox("You must define the TYPE OF LICENSE, returning.")
            Return ""
        End If
        Try

            LicenseData = AppendData("cbLicenseType", cbLicenseType.Text.Trim)
            LicenseData = AppendData("txtCustName", txtCustName.Text.Trim)
            LicenseData = AppendData("txtCustAddr", txtCustAddr.Text.Trim)
            LicenseData = AppendData("txtCustCountry", txtCustCountry.Text.Trim)
            LicenseData = AppendData("cbState", cbState.Text.Trim)
            LicenseData = AppendData("txtZip", txtZip.Text.Trim)
            LicenseData = AppendData("txtCustID", txtCustID.Text.Trim)
            LicenseData = AppendData("dtExpire", dtExpire.Text.Trim)
            LicenseData = AppendData("txtNbrSeats", txtNbrSeats.Text.Trim)
            LicenseData = AppendData("txtNbrSimlSeats", txtNbrSimlSeats.Text.Trim)
            LicenseData = AppendData("txtCompanyResetID", txtCompanyResetID.Text.Trim)
            LicenseData = AppendData("txtMstrPw", txtMstrPw.Text.Trim)
            LicenseData = AppendData("txtLicenGenDate", Now.ToString)
            LicenseData = AppendData("dtMaintExpire", dtMaintExpire.Text.Trim)
            LicenseData = AppendData("rbEnterpriseLicense", rbEnterpriseLicense.Checked.ToString)
            LicenseData = AppendData("rbStdLicense", rbStdLicense.Checked.ToString)
            LicenseData = AppendData("rbDemoLicense", rbDemoLicense.Checked.ToString)

            LicenseData = AppendData("ckSdk", ckSdk.Checked.ToString)
            LicenseData = AppendData("ckLease", ckLease.Checked.ToString)

            LicenseData = AppendData("txtMaxClients", txtMaxClients.Text)
            LicenseData = AppendData("txtSharePointNbr", txtSharePointNbr.Text)

            LicenseData = AppendData("ckToClipboard", ckToClipboard.Checked.ToString)
            LicenseData = AppendData("ckToFile", ckToFile.Checked.ToString)
            LicenseData = AppendData("ckToEmail", ckToEmail.Checked.ToString)
            LicenseData = AppendData("txtContactName", txtContactName.Text.Trim)
            LicenseData = AppendData("txtContactPhone", txtContactPhone.Text.Trim)
            LicenseData = AppendData("txtContactEmail", txtContactEmail.Text.Trim)
            LicenseData = AppendData("txtVersionNbr", txtVersionNbr.Text.Trim)
            LicenseData = AppendData("txtCity", txtCity.Text.Trim)

            LicenseData = AppendData("txtServerName", txtServerName.Text.Trim)
            LicenseData = AppendData("txtSSINstance", txtSSINstance.Text.Trim)

            LicenseData = AppendData("EndOfLicense", "EOL")

            Debug.Print(LicenseData.Length)

            EncryptedLicense = ENC.AES256EncryptString(LicenseData)
            txtLicense.Text = EncryptedLicense
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
        Return EncryptedLicense
    End Function

    Private Sub btnEncrypt_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEncrypt.Click
        Dim enclic As String = GenLicense()
        setDictVars()

        txtLicense.Text = enclic
        SB.Text = "Data just encrypted and displayed NOT added to database."
    End Sub

    Private Sub btnDecrypt_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDecrypt.Click

        Dim S As String = ENC.AES256DecryptString(Me.txtLicense.Text)
        Dim A$() = Split(S, "|")
        Debug.Print(S)
        S = ""
        ZeroScreenValues()
        Dim tKey$ = ""
        Dim tVal$ = ""
        For i As Integer = 1 To UBound(A)
            If i = 46 Then
                Debug.Print("here")
            End If
            Debug.Print(i.ToString + " : " + A(i))
            S += i.ToString + " : " + A(i) + vbCrLf

            If i Mod 2 <> 0 Then
                tKey = A(i).ToString.Trim
            Else
                tVal = A(i).ToString.Trim
            End If
            If i Mod 2 = 0 Then
                SetDecryptedValues(tKey$, tVal$)
                tKey$ = ""
                tVal$ = ""
            End If
        Next
        Clipboard.SetText(S)
        'SetDecryptedValues(tKey$, tVal$)
        'MsgBox(S)

    End Sub
    Sub initTest()
        Dim NewDT As Date = Now
        NewDT = NewDT.AddYears(1)

        txtCustName.Text = "DMA, Limited of Chicsgo"
        txtCustAddr.Text = "742 Laurel Ave"
        txtCustCountry.Text = "USA"
        cbState.Text = "IL"
        txtZip.Text = "60035"
        txtCustID.Text = "DMA-000-1"
        dtExpire.Text = NewDT
        txtNbrSeats.Text = "10"
        txtNbrSimlSeats.Text = "10"
        txtCompanyResetID.Text = "DMA-000-100"
        txtMstrPw.Text = "wdmsdm"
        txtLicenGenDate.Text = Now

        txtVersionNbr.Text = 1


        dtMaintExpire.Text = NewDT
        rbEnterpriseLicense.Checked = True
        'LicenseData$ += AppendData("rbSimultaneousUsers", rbSimultaneousUsers.Checked.ToString)
        'LicenseData$ += AppendData("rbNbrOfSeats", rbNbrOfSeats.Checked.ToString)
        'LicenseData$ += AppendData("rbNbrOfUsers", rbNbrOfUsers.Checked.ToString)
        'LicenseData$ += AppendData("ckToClipboard", ckToClipboard.Checked.ToString)
        'LicenseData$ += AppendData("ckToFile", ckToFile.Checked.ToString)
        'LicenseData$ += AppendData("ckToEmail", ckToEmail.Checked.ToString)
        txtContactName.Text = "Susan Miller"
        txtContactPhone.Text = "847-274-6622"
        txtContactEmail.Text = "dm@dmachicago.com"
    End Sub

    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        ZeroScreenValues()
    End Sub
    Sub ZeroScreenValues()

        txtCustName.Text = ""
        txtCustAddr.Text = ""
        txtCustCountry.Text = ""
        cbState.Text = ""
        txtZip.Text = ""
        txtCustID.Text = ""
        dtExpire.Text = ""
        txtNbrSeats.Text = ""
        txtNbrSimlSeats.Text = ""
        txtCompanyResetID.Text = ""
        txtMstrPw.Text = ""
        txtLicenGenDate.Text = ""
        txtLicenGenDate.Text = ""
        dtMaintExpire.Text = ""
        rbEnterpriseLicense.Checked = False
        rbStdLicense.Checked = False

        ckSdk.Checked = False
        ckLease.Checked = False

        rbDemoLicense.Checked = False
        ckToClipboard.Checked = False
        ckToFile.Checked = False
        ckToEmail.Checked = False
        txtContactName.Text = ""
        txtContactPhone.Text = ""
        txtContactEmail.Text = ""
        txtVersionNbr.Text = "0"
        txtCity.Text = ""

    End Sub

    Sub SetDecryptedValues(ByVal iKey$, ByVal tVal$)
        If iKey.Equals("txtVersionNbr") Then
            txtVersionNbr.Text = tVal.Trim
        End If
        If iKey.Equals("txtCity") Then
            txtCity.Text = tVal.Trim
        End If
        If iKey.Equals("txtCustName") Then
            txtCustName.Text = tVal.Trim
        End If
        If iKey.Equals("txtCustAddr") Then
            txtCustAddr.Text = tVal.Trim
        End If
        If iKey.Equals("txtCustCountry") Then
            txtCustCountry.Text = tVal.Trim
        End If
        If iKey.Equals("cbState") Then
            cbState.Text = tVal.Trim
        End If
        If iKey.Equals("txtZip") Then
            txtZip.Text = tVal.Trim
        End If
        If iKey.Equals("txtCustID") Then
            txtCustID.Text = tVal.Trim
        End If
        If iKey.Equals("dtExpire") Then
            dtExpire.Text = tVal.Trim
        End If
        If iKey.Equals("txtNbrSeats") Then
            txtNbrSeats.Text = tVal.Trim
        End If
        If iKey.Equals("txtNbrSimlSeats") Then
            txtNbrSimlSeats.Text = tVal.Trim
        End If
        If iKey.Equals("txtCompanyResetID") Then
            txtCompanyResetID.Text = tVal.Trim
        End If
        If iKey.Equals("txtMstrPw") Then
            txtMstrPw.Text = tVal.Trim
        End If
        If iKey.Equals("txtLicenGenDate") Then
            txtLicenGenDate.Text = tVal.Trim
        End If
        If iKey.Equals("txtLicenGenDate") Then
            txtLicenGenDate.Text = tVal.Trim
        End If
        If iKey.Equals("dtMaintExpire") Then
            dtMaintExpire.Text = tVal.Trim
        End If
        If iKey.Equals("rbEnterpriseLicense") Then
            rbEnterpriseLicense.Checked = CBool(tVal.Trim)
        End If
        If iKey.Equals("rbStdLicense") Then
            rbStdLicense.Checked = CBool(tVal.Trim)
        End If
        If iKey.Equals("rbDemoLicense") Then
            rbDemoLicense.Checked = CBool(tVal.Trim)
        End If

        If iKey.Equals("ckSdk") Then
            ckSdk.Checked = CBool(tVal.Trim)
        End If
        If iKey.Equals("ckLease") Then
            ckLease.Checked = CBool(tVal.Trim)
        End If

        If iKey.Equals("rbDemoLicense") Then
            rbDemoLicense.Checked = CBool(tVal.Trim)
        End If
        If iKey.Equals("ckToClipboard") Then
            ckToClipboard.Checked = CBool(tVal.Trim)
        End If
        If iKey.Equals("ckToFile") Then
            ckToFile.Checked = CBool(tVal.Trim)
        End If
        If iKey.Equals("ckToEmail") Then
            ckToEmail.Checked = CBool(tVal.Trim)
        End If
        If iKey.Equals("txtContactName") Then
            txtContactName.Text = tVal.Trim
        End If
        If iKey.Equals("txtContactPhone") Then
            txtContactPhone.Text = tVal.Trim
        End If
        If iKey.Equals("txtContactEmail") Then
            txtContactEmail.Text = tVal.Trim
        End If

    End Sub
    Public Function SaveTextToFile(ByVal strData As String, ByVal FQN As String) As Boolean

        'Dim Contents As String
        Dim bAns As Boolean = False
        Dim objReader As StreamWriter
        Try
            objReader = New StreamWriter(FQN)
            objReader.Write(strData)
            objReader.Close()
            bAns = True
        Catch Ex As Exception
            MsgBox("Failed to write License text file: " + vbCrLf + vbCrLf + Ex.Message)
        End Try
        Return bAns
    End Function
    Sub PopulateGrid()
        'System.Windows.Forms.DataGridViewCellEventArgs
        Dim MySql As String = "SELECT [CustomerName]"
        MySql = MySql + " ,[CustomerID]"
        MySql = MySql + " ,[LicenseID]"
        MySql = MySql + " ,[ServerName]"
        MySql = MySql + " ,[SqlInstanceName]"
        MySql = MySql + " FROM [License]"
        MySql = MySql + " order by "
        MySql = MySql + " [CustomerName], [LicenseID]"
        Try

            Dim CS As String = DB.getConnStr
            Dim sqlcn As New SqlConnection(CS)

            sqlcn.Open()

            Dim sadapt As New SqlDataAdapter(MySql, sqlcn)
            Dim ds As DataSet = New DataSet

            'Me.DsDocumentSearch.Reset()

            If sqlcn.State = ConnectionState.Closed Then
                sqlcn.Open()
            End If

            sadapt.Fill(ds, "DataSource")
            SB.Text = "Total Licenses = " & ds.Tables("DataSource").Rows.Count.ToString

            Me.dgLicense.DataSource = Nothing
            dgLicense.DataSource = ds.Tables("DataSource")

        Catch ex As Exception
            MsgBox("Search Error 165.4: " + ex.Message)
        End Try

    End Sub

    Private Sub dgLicense_CellContentClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles dgLicense.CellContentClick

    End Sub

    Private Sub dgLicense_SelectionChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles dgLicense.SelectionChanged

        Dim iRow As Integer = Me.dgLicense.CurrentRow.Index
        Dim CustomerName As String = Me.dgLicense.CurrentRow.Cells("CustomerName").Value.ToString
        Dim CustomerID As String = Me.dgLicense.CurrentRow.Cells("CustomerID").Value.ToString
        Dim LicenseID As String = Me.dgLicense.CurrentRow.Cells("LicenseID").Value.ToString

        Dim LicenseExpireDate As String = ""
        Dim NbrSeats As String = ""
        Dim NbrSimlUsers As String = ""
        Dim CompanyResetID As String = ""
        Dim MasterPW As String = ""
        Dim LicenseGenDate As String = ""
        Dim License As String = ""
        Dim ContactName As String = ""
        Dim ContactEmail As String = ""
        Dim ContactPhoneNbr As String = ""
        Dim CompanyStreetAddress As String = ""
        Dim CompanyCity As String = ""
        Dim CompanyState As String = ""
        Dim CompanyZip As String = ""
        Dim MaintExpireDate As String = ""
        Dim CompanyCountry As String = ""
        Dim LicenseTypeCode As String = ""
        Dim isCkSdk As String = ""
        Dim isCkLease As String = ""

        Dim MySql As String = "SELECT [CustomerName]"
        MySql = MySql + " ,[CustomerID]"
        MySql = MySql + "       ,[LicenseExpireDate]"
        MySql = MySql + " ,[NbrSeats]"
        MySql = MySql + " ,[NbrSimlUsers]"
        MySql = MySql + " ,[CompanyResetID]"
        MySql = MySql + " ,[MasterPW]"
        MySql = MySql + " ,[LicenseGenDate]"
        MySql = MySql + " ,[License]"
        MySql = MySql + " ,[LicenseID]"
        MySql = MySql + " ,[ContactName]"
        MySql = MySql + " ,[ContactEmail]"
        MySql = MySql + " ,[ContactPhoneNbr]"
        MySql = MySql + " ,[CompanyStreetAddress]"
        MySql = MySql + " ,[CompanyCity]"
        MySql = MySql + " ,[CompanyState]"
        MySql = MySql + " ,[CompanyZip]"
        MySql = MySql + " ,[MaintExpireDate], CompanyCountry, LicenseTypeCode, ckSdk, ckLease, MaxClients, MaxSharePoint, ServerName, SqlInstanceName "
        MySql = MySql + " FROM [DMA.UD.License].[dbo].[License]"
        MySql = MySql + " where [CustomerID] = '" + CustomerID + "'"
        MySql = MySql + " and [LicenseID] = '" + LicenseID + "'"

        'Clipboard.Clear()
        'Clipboard.SetText(MySql)

        Dim rsColInfo As SqlDataReader = Nothing
        'rsColInfo = SqlQryNo'Session(S)
        rsColInfo = DB.SqlQry(MySql)

        If rsColInfo.HasRows Then
            Do While rsColInfo.Read()
                ZeroScreenValues()
                CustomerName = rsColInfo.GetValue(0).ToString
                CustomerID = rsColInfo.GetValue(1).ToString
                LicenseExpireDate = rsColInfo.GetValue(2).ToString
                NbrSeats = rsColInfo.GetValue(3).ToString
                NbrSimlUsers = rsColInfo.GetValue(4).ToString
                CompanyResetID = rsColInfo.GetValue(5).ToString
                MasterPW = rsColInfo.GetValue(6).ToString
                LicenseGenDate = rsColInfo.GetValue(7).ToString
                License = rsColInfo.GetValue(8).ToString
                LicenseID = rsColInfo.GetValue(9).ToString
                ContactName = rsColInfo.GetValue(10).ToString
                ContactEmail = rsColInfo.GetValue(11).ToString
                ContactPhoneNbr = rsColInfo.GetValue(12).ToString
                CompanyStreetAddress = rsColInfo.GetValue(13).ToString
                CompanyCity = rsColInfo.GetValue(14).ToString
                CompanyState = rsColInfo.GetValue(15).ToString
                CompanyZip = rsColInfo.GetValue(16).ToString
                MaintExpireDate = rsColInfo.GetValue(17).ToString
                CompanyCountry = rsColInfo.GetValue(18).ToString
                LicenseTypeCode = rsColInfo.GetValue(19).ToString
                isCkSdk = rsColInfo.GetValue(20).ToString
                isCkLease = rsColInfo.GetValue(21).ToString

                Dim strMaxClients$ = rsColInfo.GetValue(22).ToString
                Dim strSharePointNbr = rsColInfo.GetValue(23).ToString

                ServerName = rsColInfo.GetValue(24).ToString
                SqlInstanceName = rsColInfo.GetValue(25).ToString

                txtServerName.Text = ServerName
                txtSSINstance.Text = SqlInstanceName

                If strMaxClients$.Length = 0 Then
                    strMaxClients$ = "0"
                End If
                txtMaxClients.Text = strMaxClients

                If strSharePointNbr.Length = 0 Then
                    strSharePointNbr = "0"
                End If
                Me.txtSharePointNbr.Text = strSharePointNbr

                If isCkSdk.ToUpper.Equals("TRUE") Then
                    ckSdk.Checked = True
                Else
                    ckSdk.Checked = False
                End If
                If isCkLease.ToUpper.Equals("TRUE") Then
                    ckLease.Checked = True
                Else
                    ckLease.Checked = False
                End If

                txtCustName.Text = CustomerName
                txtCustID.Text = CustomerID
                dtExpire.Text = LicenseExpireDate

                'MessageBox.Show(dtExpire.Text.ToString)

                txtNbrSeats.Text = NbrSeats
                txtNbrSimlSeats.Text = NbrSimlUsers
                txtCompanyResetID.Text = CompanyResetID
                txtMstrPw.Text = MasterPW
                txtLicenGenDate.Text = LicenseGenDate
                txtLicense.Text = License
                txtVersionNbr.Text = LicenseID
                txtContactName.Text = ContactName
                txtContactEmail.Text = ContactEmail
                txtContactPhone.Text = ContactPhoneNbr
                txtCustAddr.Text = CompanyStreetAddress
                txtCity.Text = CompanyCity
                cbState.Text = CompanyState
                txtZip.Text = CompanyZip
                dtMaintExpire.Text = MaintExpireDate
                'MessageBox.Show(dtMaintExpire.Text)

                txtCustCountry.Text = CompanyCountry
                Me.cbLicenseType.Text = LicenseTypeCode
            Loop
        Else
            ZeroScreenValues()
            SB.Text = "Customer record not found..."
        End If
        rsColInfo.Close()
        rsColInfo = Nothing

        SetRadioButtons()

        dtExpire.Text = LicenseExpireDate
        dtMaintExpire.Text = MaintExpireDate

    End Sub

    Private Sub btnOverwrite_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnOverwrite.Click

        ServerName = txtServerName.Text.Trim
        SqlInstanceName = txtSSINstance.Text.Trim
        If ServerName.Length = 0 Then
            MsgBox("The SERVER name must be supplied, returning.")
            Return
        End If


        '** The following required on the Remote Server
        'insert into LicenseType (LicenseTypeCode,Description) values ('Roaming','Users can log in from any machine.')
        'insert into LicenseType (LicenseTypeCode,Description) values ('Seat','Users can log in only from designated machines.')
        'insert into LicenseType (LicenseTypeCode,Description) values ('User','Users require a password, from any machine.')
        'insert into LicenseType (LicenseTypeCode,Description) values ('Client','LLimited to number of client licenses purchsed.')
        'insert into LicenseType (LicenseTypeCode,Description) values ('SQLExpress','Can only run against a SQL Express DB.')
        'insert into LicenseType (LicenseTypeCode,Description) values ('SDK','Purchased for the SDK only.')

        GenLicense()
        setDictVars()

        If cbLicenseType.Text.Trim.Length = 0 Then
            MsgBox("Please select a License Type, returning.")
            Return
        End If
        Dim B As Boolean = False

        Dim MachineID$ = ServerName

        LIC.setCompanyresetid(txtCompanyResetID.Text.Trim)
        LIC.setCustomerid(txtCustID.Text.Trim)
        LIC.setCustomername(txtCustName.Text.Trim)
        LIC.setLicense(txtLicense.Text)
        LIC.setLicenseexpiredate(CDate(dtExpire.Text).ToString)
        LIC.setLicensegendate(Now.ToString)
        If Not IsNumeric(txtVersionNbr.Text) Then
            MsgBox("Version Number MUST be numeric, aborting.")
            Return
        End If
        LIC.setLicenseid(txtVersionNbr.Text)
        LIC.setMasterpw(txtMstrPw.Text.Trim)
        If Not IsNumeric(txtNbrSeats.Text) Then
            MsgBox("Number of seats MUST be numeric, aborting.")
            Return
        End If
        LIC.setNbrseats(txtNbrSeats.Text)
        If Not IsNumeric(txtNbrSeats.Text) Then
            MsgBox("Number of simultaneous MUST be numeric, aborting.")
            Return
        End If
        LIC.setCompanycountry(Me.txtCustCountry.Text)
        LIC.setCompanycity(txtCity.Text.Trim)
        LIC.setNbrsimlusers(txtNbrSimlSeats.Text.Trim)
        LIC.setContactname(txtContactName.Text.Trim)
        LIC.setContactemail(txtContactEmail.Text.Trim)
        LIC.setContactphonenbr(txtContactPhone.Text.Trim)
        LIC.setCompanystreetaddress(txtCustAddr.Text.Trim)
        LIC.setCompanystate(cbState.Text)
        LIC.setCompanyzip(txtZip.Text)
        LIC.setMaintexpiredate(CDate(dtMaintExpire.Text).ToString)
        LIC.setLicenseTypeCode(cbLicenseType.Text.Trim)

        LIC.setSdk(ckSdk.Checked)
        LIC.setLease(ckLease.Checked)

        If Not IsNumeric(txtMaxClients.Text) Then
            MsgBox("Only numeric data allowed in Max Clients.")
            Return
        End If
        LIC.setMaxClients(Me.txtMaxClients.Text)

        If Not IsNumeric(Me.txtSharePointNbr.Text) Then
            MsgBox("Only numeric data allowed in Max SharePoint Databases.")
            Return
        End If
        LIC.setSharePointNbr(Me.txtSharePointNbr.Text)

        Dim iCnt As Integer = LIC.cnt_PK_License(txtCustName.Text, txtCustID.Text.Trim)
        If iCnt = 0 Then
            MsgBox("Account cannot be found... check your data.")
            Return
        End If

        Dim WC As String = LIC.wc_PK_License(txtCustName.Text, txtCustID.Text.Trim)

        B = LIC.Update(WC, ServerName, SqlInstanceName)

        If Not B Then
            MsgBox("Failed to add new license... aborting.")
            Return
        Else
            SB.Text = "License data UPDATED in the database."
        End If

        If ckToFile.Checked Then
            Dim FQN As String = ""
            Dim tFile As String = DMA.CheckFileName(txtCustID.Text.Trim)
            FQN = "C:\temp\LicenseFile." + txtCustID.Text.Trim + "." + txtVersionNbr.Text.Trim + ".lic"
            B = SaveTextToFile(Me.txtLicense.Text, FQN)
            If Not B Then
                MsgBox("Failed to write " + FQN)
            End If
        End If
        If ckToEmail.Checked Then
            MsgBox("EMAIL is not implemented to date...")
        End If
        If ckToClipboard.Checked Then
            Clipboard.SetText(Me.txtLicense.Text)
        End If
        'PopulateGrid()
        If Not B Then
            MsgBox("Failed to add new license... aborting.")
            Return
        Else
            btnUploadLicense_Click(Nothing, Nothing)
            'MsgBox("Remember to UPLOAD the license to the Server.")
            SB.Text = "License data UPDATED in the database."
            UpdateGateway()
        End If
    End Sub

    Private Sub btnParse_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnParse.Click

        Dim S = Me.txtLicense.Text
        ParseLic(S, True)

    End Sub
    Function ParseLic(ByVal S As String, ByVal DisplayMsgBox As Boolean) As Boolean

        Dim tKey$ = ""
        Dim tVal$ = ""
        Dim A As New SortedList(Of String, String)
        Dim S1$ = ""
        A = ENC.xt001trc(S)
        Dim I As Integer = 0

        S1 = ""
        For Each sKey As String In A.Keys
            I = A.IndexOfKey(sKey)
            S1 += sKey + " : " + A.Values(I) + vbCrLf
        Next

        If DisplayMsgBox Then MsgBox(S1)


    End Function
    Function getEncryptedValue(ByVal iKey$, ByVal A As SortedList(Of String, String)) As String
        Dim tVal$ = ""
        Dim iDx As Integer = A.IndexOfKey(iKey)
        'iDx = A.ContainsValue(iKey)
        If iDx > 0 Then
            tVal$ = A.Values(iDx).ToString
        Else
            tVal = ""
        End If
        Return tVal
    End Function

    Private Sub btnLoadLicenseFile_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLoadLicenseFile.Click
        Dim FQN$ = OpenFileDialog1.ShowDialog
        FQN$ = OpenFileDialog1.FileName
        DB.LoadLicenseFile(FQN$)
    End Sub

    Private Sub btnClipboard_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnClipboard.Click
        Clipboard.Clear()
        Clipboard.SetText(txtLicense.Text.Trim)
        SB.Text = "License in clipboard."
    End Sub

    Private Sub btnUploadLicense_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnUploadLicense.Click
        setDictVars()

        Dim MachineID As String = txtServerName.Text
        Dim MaintExpireDate As String = dtMaintExpire.Text
        Dim LicenseExpireDate As String = dtExpire.Text
        ServerName = txtServerName.Text.Trim
        SqlInstanceName = txtSSINstance.Text.Trim
        If ServerName.Length = 0 Then
            MsgBox("Server name  must be supplied, returning.")
            Return
        End If

        If cbLicenseType.Text.Trim.Length = 0 Then
            MsgBox("Please select the License Type, returning.", MsgBoxStyle.Critical, "Reuqired Data Missing")
            Return
        End If

        Dim CompanyResetID = txtCompanyResetID.Text
        Dim MasterPW = txtMstrPw.Text
        Dim License As String = txtLicense.Text

        'wdmxx

        Dim CustomerName As String = txtCustName.Text.Trim
        Dim CustomerID As String = txtCustID.Text.Trim
        Dim LicenseID As String = Me.dgLicense.CurrentRow.Cells("LicenseID").Value.ToString

        Dim PurchasedMachines As String = txtNbrSeats.Text
        Dim PurchasedUsers As String = txtNbrSimlSeats.Text
        Dim SupportActive As String = "Y"
        Dim SupportActiveDate As String = Now.ToString
        Dim SupportInactiveDate As String = dtMaintExpire.Text.ToString
        Dim LicenseType As String = ""
        Dim WC As String = ""

        LicenseType = cbLicenseType.Text
        If LicenseType.Trim.Length = 0 Then
            MsgBox("You must CHECK the type of license. Bottom left, radio buttons.")
            Return
        End If

        Dim xLicense As String = GenLicense()
        setDictVars()

        Clipboard.Clear()
        Clipboard.SetText(xLicense)
        Console.WriteLine(xLicense)


        Try
            Dim iCnt As Integer = RL.cnt_PK19(CustomerID, LicenseID)
            If iCnt > 0 Then
                '** We have to update the license.
                WC = RL.wc_PK19(CustomerID, LicenseID)
                RL.setEncryptedlicense(xLicense)
                RL.setPurchasedmachines(PurchasedMachines)
                RL.setPurchasedusers(PurchasedUsers)
                RL.setSupportactive(SupportActive)
                RL.setLicensetypecode(LicenseType)
                RL.setInstalleddate(Now.ToString)
                RL.setLastupdate(Now.ToString)

                Dim B As Boolean = RL.UpdateLicense("L", WC, CustomerName, CustomerID, ServerName, SqlInstanceName, LicenseExpireDate, MaintExpireDate, MachineID)

                If B Then
                    SB.Text = txtCustID.Text + ": License updated on remote server."
                    If gCurrServerType = "local" Then
                        MsgBox(txtCustID.Text + ": License updated on LOCAL server.")
                    Else
                        MsgBox(txtCustID.Text + ": License updated on REMOTE server.")
                    End If

                Else
                    SB.Text = txtCustID.Text + ": ERROR: License NOT updated on remote server."
                End If


            Else
                '** We have to add the record
                RL.setCompanyid(CustomerID)
                RL.setLicenseid(LicenseID)
                RL.setMachineid(ServerName)
                'RL.setLicensetypecode(cbLicenseType.Text.Trim)
                RL.setEncryptedlicense(xLicense)
                RL.setPurchasedmachines(PurchasedMachines)
                RL.setPurchasedusers(PurchasedUsers)
                RL.setSupportactive(SupportActive)
                RL.setLicensetypecode(LicenseType)
                RL.setInstalleddate(Now.ToString)
                RL.setLastupdate(Now.ToString)

                Dim B As Boolean = RL.Insert("L", CustomerID, ServerName, SqlInstanceName, CustomerName, CompanyResetID, MasterPW, License, LicenseExpireDate, MaintExpireDate, MachineID)

                If Not B Then
                    MsgBox(MsgBox("Failed insert of license to remote."))
                Else
                    SB.Text = "Added License for: " + CustomerID + " : " + CustomerName
                    MsgBox("Uploaded License for: " + CustomerID + " : " + CustomerName)
                End If
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try

    End Sub

    Private Sub cbLicenseType_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbLicenseType.SelectedIndexChanged
        ''        Enterprise
        ''        Standard
        ''Single User
        ''        Remote Office
        ''        Demo
        'If cbLicenseType.Text = "Enterprise" Then
        '    rbEnterpriseLicense.Checked = True
        'End If
        'If cbLicenseType.Text = "Standard" Then
        '    rbStdLicense.Checked = True
        'End If
        'If cbLicenseType.Text = "Single User" Then
        '    rbUserLicense.Checked = True
        'End If
        'If cbLicenseType.Text = "Remote Office" Then
        '    rbStdLicense.Checked = True
        'End If
        'If cbLicenseType.Text = "Demo" Then
        '    rbDemoLicense.Checked = True
        'End If
    End Sub

    Private Sub LicenseBindingSource_CurrentChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LicenseBindingSource.CurrentChanged

    End Sub

    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click

        If cbLicenseType.Text.Trim.Length = 0 Then
            MsgBox("Please select the License Type, returning.", MsgBoxStyle.Critical, "Reuqired Data Missing")
            Return
        End If

        GenLicense()
        setDictVars()

        Dim B As Boolean = False

        LIC.setCompanyresetid(txtCompanyResetID.Text.Trim)
        LIC.setCustomerid(txtCustID.Text.Trim)
        LIC.setCustomername(txtCustName.Text.Trim)
        LIC.setLicense(txtLicense.Text)
        LIC.setLicenseexpiredate(CDate(dtExpire.Text).ToString)
        LIC.setLicensegendate(Now.ToString)
        If Not IsNumeric(txtVersionNbr.Text) Then
            MsgBox("Version Number MUST be numeric, aborting.")
            Return
        End If
        LIC.setLicenseid(txtVersionNbr.Text)
        LIC.setMasterpw(txtMstrPw.Text.Trim)
        If Not IsNumeric(txtNbrSeats.Text) Then
            MsgBox("Number of seats MUST be numeric, aborting.")
            Return
        End If
        LIC.setNbrseats(txtNbrSeats.Text)
        If Not IsNumeric(txtNbrSeats.Text) Then
            MsgBox("Number of simultaneous MUST be numeric, aborting.")
            Return
        End If
        LIC.setCompanycountry(Me.txtCustCountry.Text)
        LIC.setCompanycity(txtCity.Text.Trim)
        LIC.setNbrsimlusers(txtNbrSimlSeats.Text.Trim)
        LIC.setContactname(txtContactName.Text.Trim)
        LIC.setContactemail(txtContactEmail.Text.Trim)
        LIC.setContactphonenbr(txtContactPhone.Text.Trim)
        LIC.setCompanystreetaddress(txtCustAddr.Text.Trim)
        LIC.setCompanystate(cbState.Text)
        LIC.setCompanyzip(txtZip.Text)
        LIC.setMaintexpiredate(CDate(dtMaintExpire.Text).ToString)
        LIC.setLicenseTypeCode(cbLicenseType.Text.Trim)

        Dim iCnt As Integer = LIC.cnt_PK_License(txtCustName.Text, txtCustID.Text.Trim)
        If iCnt = 0 Then
            MsgBox("This account DOES NOT exists... check your data.")
            Return
        End If

        Dim WC As String = LIC.wc_PK_License(txtCustName.Text, txtCustID.Text.Trim)
        B = LIC.Delete(WC)

        If Not B Then
            MsgBox("Failed to DEKETE license... aborting.")
        Else
            SB.Text = "License deleted from local DB."
        End If

        '**********************************************************************
        Dim MachineID$ = ServerName
        Dim EncryptedLicense As String = ""
        Dim CustomerName As String = Me.dgLicense.CurrentRow.Cells("CustomerName").Value.ToString
        Dim CustomerID As String = Me.dgLicense.CurrentRow.Cells("CustomerID").Value.ToString
        Dim LicenseID As String = Me.dgLicense.CurrentRow.Cells("LicenseID").Value.ToString

        Dim PurchasedMachines$ = txtNbrSeats.Text
        Dim PurchasedUsers$ = txtNbrSimlSeats.Text
        Dim SupportActive$ = "Y"
        Dim SupportActiveDate$ = Now.ToString
        Dim SupportInactiveDate$ = dtMaintExpire.Text.ToString
        Dim LicenseType$ = ""

        Try
            iCnt = RL.cnt_PK19(CustomerID, LicenseID)
            If iCnt > 0 Then
                '** We have to update the license.
                WC = RL.wc_PK19(CustomerID, LicenseID)
                RL.setEncryptedlicense(EncryptedLicense)
                RL.setPurchasedmachines(PurchasedMachines$)
                RL.setPurchasedusers(PurchasedUsers$)
                RL.setSupportactive(SupportActive)
                'RL.setLicensetypecode(LicenseType$)
                RL.setInstalleddate(Now.ToString)
                RL.setLastupdate(Now.ToString)
                B = RL.Delete(WC)
                If B Then
                    SB.Text = txtCustID.Text + ": License DELETED on remote server."
                    MsgBox(txtCustID.Text + ": License DELETED on remote server.")
                Else
                    SB.Text = txtCustID.Text + ": ERROR: License NOT DELETED on remote server."
                End If
            Else
                SB.Text = "License for: " + CustomerID + " : " + CustomerName + " NOT FOUND."
                MsgBox("License for: " + CustomerID + " : " + CustomerName + " NOT FOUND.")
            End If
            PopulateGrid()
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Sub SetRadioButtons()

        Dim S = Me.txtLicense.Text

        Dim tKey$ = ""
        Dim tVal$ = ""
        Dim A As New SortedList(Of String, String)
        Dim S1$ = ""
        Try
            A = ENC.xt001trc(S)
            Dim I As Integer = 0

            'S1 = ""
            'For Each sKey As String In A.Keys
            '    I = A.IndexOfKey(sKey)
            '    S1 += sKey + " : " + A.Values(I) + vbCrLf
            'Next

            I = A.IndexOfKey("rbEnterpriseLicense")
            If I >= 0 Then
                tVal = A.Values(I)
                If (tVal.Equals("True")) Then
                    rbEnterpriseLicense.Checked = True
                Else
                    rbEnterpriseLicense.Checked = False
                End If

            Else
                    rbEnterpriseLicense.Checked = False
            End If
            rbEnterpriseLicense.Refresh()

            I = A.IndexOfKey("rbStdLicense")
            If I >= 0 Then
                tVal = A.Values(I)
                If (tVal.Equals("True")) Then
                    rbStdLicense.Checked = True
                Else
                    rbStdLicense.Checked = False
                End If
            Else
                    rbStdLicense.Checked = False
            End If
            rbStdLicense.Refresh()

            I = A.IndexOfKey("rbDemoLicense")
            If I >= 0 Then
                tVal = A.Values(I)
                If (tVal.Equals("True")) Then
                    If (tVal.Equals("True")) Then
                        rbDemoLicense.Checked = True
                    Else
                        rbDemoLicense.Checked = False

                    End If
                End If
            Else
                rbDemoLicense.Checked = False
            End If
            rbDemoLicense.Refresh()

            I = A.IndexOfKey("rb180")
            If I >= 0 Then
                tVal = A.Values(I)
                If (tVal.Equals("True")) Then
                    If (tVal.Equals("True")) Then
                        rb180.Checked = True
                    Else
                        rb180.Checked = False

                    End If
                End If
            Else
                rb180.Checked = False
            End If
            rb180.Refresh()


        Catch ex As Exception
            Console.WriteLine("ERROR 21X: " + ex.Message)
        End Try




    End Sub

    Private Sub txtMaxClients_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtMaxClients.TextChanged
        If Not IsNumeric(txtMaxClients.Text) Then
            MsgBox("Only numeric data allowed in this box.")
            Return
        End If
    End Sub

    Private Sub ckLease_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ckLease.CheckedChanged
        If ckLease.Checked Then
            dtExpire.Enabled = True
        Else
            dtExpire.Enabled = False
        End If
    End Sub

    Private Sub txtSharePointNbr_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtSharePointNbr.TextChanged
        If Not IsNumeric(txtSharePointNbr.Text) Then
            MsgBox("Only numeric data allowed in this box.")
            Return
        End If
    End Sub

    Private Sub btnPull_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnPull.Click

        Dim CurrServerType As String = gCurrServerType
        gCurrServerType = "remote"


        Dim S = ""

        Dim CustomerName As String
        Dim CustomerID As String
        Dim LicenseExpireDate As String
        Dim NbrSeats As String
        Dim NbrSimlUsers As String
        Dim CompanyResetID As String
        Dim MasterPW As String
        Dim LicenseGenDate As String
        Dim License As String
        Dim LicenseID As String
        Dim ContactName As String
        Dim ContactEmail As String
        Dim ContactPhoneNbr As String
        Dim CompanyStreetAddress As String
        Dim CompanyCity As String
        Dim CompanyState As String
        Dim CompanyZip As String
        Dim MaintExpireDate As String
        Dim CompanyCountry As String
        Dim MachineID As String
        Dim LicenseTypeCode As String
        Dim ckSdk As String
        Dim ckLease As String
        Dim MaxClients As String
        Dim MaxSharePoint As String
        Dim ServerName As String
        Dim SqlInstanceName As String
        Dim StorageAllotment As String
        Dim RecNbr As String
        Dim Applied As String
        Dim EncryptedLicense As String
        Dim LastUpdate As String
        Dim LicenseType As String

        ServerName = txtServerName.Text.Trim
        SqlInstanceName = txtSSINstance.Text.Trim
        If ServerName.Length = 0 Then
            gCurrServerType = CurrServerType
            MsgBox("Server name  must be supplied, returning.")
            Return
        End If


        Dim ExistingLicenses As New List(Of String)

        For K As Integer = 0 To dgLicense.Rows.Count - 1
            Try
                CustomerID = dgLicense.Rows(K).Cells("CustomerID").Value.ToString
                ExistingLicenses.Add(CustomerID)
            Catch ex As Exception
                Console.WriteLine(ex.Message)
            End Try
        Next
        S = ""
        S = S + "SELECT 
                CustomerName,
                CustomerID,
                LicenseExpireDate,
                NbrSeats,
                NbrSimlUsers,
                CompanyResetID,
                MasterPW,
                LicenseGenDate,
                License,
                LicenseID,
                ContactName,
                ContactEmail,
                ContactPhoneNbr,
                CompanyStreetAddress,
                CompanyCity,
                CompanyState,
                CompanyZip,
                MaintExpireDate,
                CompanyCountry,
                MachineID,
                LicenseTypeCode,
                ckSdk,
                ckLease,
                MaxClients,
                MaxSharePoint,
                ServerName,
                SqlInstanceName,
                StorageAllotment,
                RecNbr,
                Applied,
                EncryptedLicense,
                LastUpdate,
                LicenseType
                FROM License;"

        RL.PopulateRemoteGrid(dgRemote, S)

        For i As Integer = 0 To dgRemote.Rows.Count - 1


            Try
                CustomerID = dgRemote.Rows(i).Cells("CustomerID").Value.ToString
            Catch ex As Exception
                Console.WriteLine(ex.Message)
                Exit For
            End Try
            If ExistingLicenses.Contains(CustomerID) Then
                '** Skip it, it already exists in the DB
            Else
                CustomerName = dgRemote.Rows(i).Cells("CustomerName").Value.ToString
                CustomerID = dgRemote.Rows(i).Cells("CustomerID").Value.ToString
                LicenseExpireDate = dgRemote.Rows(i).Cells("LicenseExpireDate").Value.ToString
                NbrSeats = dgRemote.Rows(i).Cells("NbrSeats").Value.ToString
                NbrSimlUsers = dgRemote.Rows(i).Cells("NbrSimlUsers").Value.ToString
                CompanyResetID = dgRemote.Rows(i).Cells("CompanyResetID").Value.ToString
                MasterPW = dgRemote.Rows(i).Cells("MasterPW").Value.ToString
                LicenseGenDate = dgRemote.Rows(i).Cells("LicenseGenDate").Value.ToString
                License = dgRemote.Rows(i).Cells("License").Value.ToString
                LicenseID = dgRemote.Rows(i).Cells("LicenseID").Value.ToString
                ContactName = dgRemote.Rows(i).Cells("ContactName").Value.ToString
                ContactEmail = dgRemote.Rows(i).Cells("ContactEmail").Value.ToString
                ContactPhoneNbr = dgRemote.Rows(i).Cells("ContactPhoneNbr").Value.ToString
                CompanyStreetAddress = dgRemote.Rows(i).Cells("CompanyStreetAddress").Value.ToString
                CompanyCity = dgRemote.Rows(i).Cells("CompanyCity").Value.ToString
                CompanyState = dgRemote.Rows(i).Cells("CompanyState").Value.ToString
                CompanyZip = dgRemote.Rows(i).Cells("CompanyZip").Value.ToString
                MaintExpireDate = dgRemote.Rows(i).Cells("MaintExpireDate").Value.ToString
                CompanyCountry = dgRemote.Rows(i).Cells("CompanyCountry").Value.ToString
                MachineID = dgRemote.Rows(i).Cells("MachineID").Value.ToString
                LicenseTypeCode = dgRemote.Rows(i).Cells("LicenseTypeCode").Value.ToString
                ckSdk = dgRemote.Rows(i).Cells("ckSdk").Value.ToString
                ckLease = dgRemote.Rows(i).Cells("ckLease").Value.ToString
                MaxClients = dgRemote.Rows(i).Cells("MaxClients").Value.ToString
                MaxSharePoint = dgRemote.Rows(i).Cells("MaxSharePoint").Value.ToString
                ServerName = dgRemote.Rows(i).Cells("ServerName").Value.ToString
                SqlInstanceName = dgRemote.Rows(i).Cells("SqlInstanceName").Value.ToString
                StorageAllotment = dgRemote.Rows(i).Cells("StorageAllotment").Value.ToString
                RecNbr = dgRemote.Rows(i).Cells("RecNbr").Value.ToString
                Applied = dgRemote.Rows(i).Cells("Applied").Value.ToString
                EncryptedLicense = dgRemote.Rows(i).Cells("EncryptedLicense").Value.ToString
                LastUpdate = dgRemote.Rows(i).Cells("LastUpdate").Value.ToString
                LicenseType = dgRemote.Rows(i).Cells("LicenseType").Value.ToString

                LIC.setCustomername(CustomerID)
                LIC.setCompanyresetid("ECM")
                LIC.setCustomerid(CustomerID)
                LIC.setLicense(EncryptedLicense)
                LIC.setLicenseexpiredate(Now)
                LIC.setLicensegendate(Now.ToString)
                LIC.setLicenseid("0")
                LIC.setMasterpw("ECMXX001")
                LIC.setNbrseats("0")

                LIC.setCompanycountry("UKN")
                LIC.setCompanycity("UKN")
                LIC.setNbrsimlusers("0")
                LIC.setContactname("UKN")
                LIC.setContactemail("UKN")
                LIC.setContactphonenbr("UKN")
                LIC.setCompanystreetaddress("UKN")
                LIC.setCompanystate("UKN")
                LIC.setCompanyzip("UKN")
                LIC.setMaintexpiredate(Now)
                LIC.setLicenseTypeCode("UKN")
                LIC.setSdk("0")
                LIC.setLease("0")

                'If Not IsNumeric(txtMaxClients.Text) Then
                '    MsgBox("Only numeric data allowed in Max Clients.")
                '    Return
                'End If
                LIC.setMaxClients("0")

                'If Not IsNumeric(txtSharePointNbr.Text) Then
                '    MsgBox("Only numeric data allowed in Max SharePoint DBs.")
                '    Return
                'End If
                LIC.setSharePointNbr("0")

                Dim iCnt As Integer = LIC.cnt_PK_License(txtCustName.Text, txtCustID.Text.Trim)
                If iCnt > 0 Then
                    Console.WriteLine("This account already exists... check your data.")
                End If

                Dim B As Boolean = LIC.Insert(ServerName, SqlInstanceName)

                If B = False Then
                    MsgBox("Failed to insert License KeyID: " + CustomerID)
                End If
            End If
        Next

        gCurrServerType = CurrServerType

    End Sub

    Private Sub rbDemoLicense_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rbDemoLicense.CheckedChanged
        If rbDemoLicense.Checked Then
            dtExpire.Text = Now.AddDays(90).ToString
            dtMaintExpire.Text = Now.AddDays(90).ToString
        End If
    End Sub

    Private Sub rb180_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rb180.CheckedChanged
        If rb180.Checked Then
            dtExpire.Text = Now.AddDays(180).ToString
            dtMaintExpire.Text = Now.AddDays(180).ToString
        End If
    End Sub

    Sub UpdateGateway()

        Dim DoNotDoThis As Boolean = True
        If DoNotDoThis Then
            Return
        End If

        Dim Proxy As New SVC_Gateway.Service1Client

        Dim RC As Boolean = False
        Dim RetMsg As String = ""
        Dim CustomerID As String = txtCustID.Text
        Dim RepoID As String = txtSSINstance.Text
        Dim GatewayPassword As String = ENC.AES256EncryptString(txtMstrPw.Text)
        Dim GatewayUserID As String = txtServerName.Text

        Dim GateWayCS As String = ""
        Dim reader As New System.Configuration.AppSettingsReader
        GateWayCS = reader.GetValue("ECMSecureLogin", GetType(String))

        Dim EncPW As String = ""
        EncPW = reader.GetValue("EncPW", GetType(String))
        EncPW = ENC.AES256DecryptString(EncPW)

        Dim GeneratedConnectionString As String = ""

        CustomerID = ENC.AES256EncryptString(CustomerID)
        RepoID = ENC.AES256EncryptString(RepoID)
        GatewayUserID = ENC.AES256EncryptString(GatewayUserID)
        Try
            RC = Proxy.saveConnection(GateWayCS, CustomerID, EncPW, RepoID, GeneratedConnectionString, False, False, RC, RetMsg)
        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try


        If RC Then
            MessageBox.Show("Gateway updated successfully.")
        Else
            MessageBox.Show("Gateway failed to update.")
        End If

        Proxy = Nothing
        GC.Collect()

    End Sub

    Private Sub Button2_Click(sender As Object, e As EventArgs) Handles Button2.Click
        setDictVars()
        Try
            Dim SmtpServer As New SmtpClient()
            Dim mail As New MailMessage()
            SmtpServer.Credentials = New Net.NetworkCredential("wdalemiller@gmail.com", "Copper@01")
            SmtpServer.Port = 587
            SmtpServer.Host = "smtp.gmail.com"
            mail = New MailMessage()
            mail.From = New MailAddress("wdalemiller@gmail.com")
            mail.To.Add(txtContactEmail.Text)
            mail.Subject = "ECM License"
            mail.Body = txtLicense.Text
            SmtpServer.Send(mail)
            MsgBox("mail send")
        Catch ex As Exception
            MsgBox(ex.ToString)
        End Try
        'Try
        '    Dim SmtpServer As New SmtpClient()
        '    Dim mail As New MailMessage()
        '    SmtpServer.Credentials = New Net.NetworkCredential("support@ecmlibrary.com", "CopperGold01")
        '    SmtpServer.Port = 465
        '    SmtpServer.Host = "smtpout.secureserver.net"
        '    mail = New MailMessage()
        '    mail.From = New MailAddress("support@ecmlibrary.com")
        '    mail.To.Add(txtContactEmail.Text)
        '    mail.Subject = "ECM License"
        '    mail.Body = txtLicense.Text
        '    SmtpServer.Send(mail)
        '    MsgBox("mail sent")
        'Catch ex As Exception
        '    MsgBox(ex.ToString)
        'End Try
    End Sub

    Private Sub btnSync_Click(sender As Object, e As EventArgs) Handles btnSync.Click

    End Sub

    Private Sub setDictVars()
        dictVars.Clear()
        Dim X As String = ""

        dictVars.Add("CustomerName", txtContactName.Text)
        dictVars.Add("CustomerID", txtCustID.Text)
        dictVars.Add("LicenseExpireDate", dtExpire.Text)
        dictVars.Add("NbrSeats", txtNbrSeats.Text)
        dictVars.Add("NbrSimlUsers", txtNbrSimlSeats.Text)
        dictVars.Add("CompanyResetID", txtCompanyResetID.Text)
        dictVars.Add("MasterPW", txtMstrPw.Text)
        dictVars.Add("LicenseGenDate", txtLicenGenDate.Text)
        dictVars.Add("License", txtLicense.Text)
        dictVars.Add("LicenseType", cbLicenseType.Text)
        dictVars.Add("LicenseID", txtVersionNbr.Text)
        dictVars.Add("ContactName", txtContactName.Text)
        dictVars.Add("ContactEmail", txtContactEmail.Text)
        dictVars.Add("ContactPhoneNbr", txtContactPhone.Text)
        dictVars.Add("CompanyStreetAddress", txtCustAddr.Text)
        dictVars.Add("CompanyCity", txtCity.Text)
        dictVars.Add("CompanyState", cbState.Text)
        dictVars.Add("CompanyZip", txtZip.Text)
        dictVars.Add("MaintExpireDate", dtMaintExpire.Text)
        dictVars.Add("CompanyCountry", txtCustCountry.Text)
        dictVars.Add("MachineID", txtServerName.Text)
        dictVars.Add("LicenseTypeCode", cbLicenseType.Text)
        If ckSdk.Checked Then
            dictVars.Add("ckSdk", "1")
        Else
            dictVars.Add("ckSdk", "0")
        End If
        If ckLease.Checked Then
            dictVars.Add("ckLease", "1")
        Else
            dictVars.Add("ckLease", "0")
        End If
        dictVars.Add("MaxClients", txtMaxClients.Text)
        dictVars.Add("MaxSharePoint", txtSharePointNbr.Text)
        dictVars.Add("ServerName", txtServerName.Text)
        dictVars.Add("SqlInstanceName", txtSSINstance.Text)
        dictVars.Add("StorageAllotment", TextBox1.Text)
        dictVars.Add("Applied", "0")
        dictVars.Add("EncryptedLicense", txtLicense.Text)
        dictVars.Add("LastUpdate", Now())


    End Sub

    Private Sub CheckBox1_CheckedChanged(sender As Object, e As EventArgs) Handles CheckBox1.CheckedChanged
        setDictVars()

        If CheckBox1.Checked Then
            gCurrServerType = "remote"
            btnUploadLicense.Text = "Upload License to REMOTE Server"
            btnUploadLicense.BackColor = Color.DarkRed
            btnUploadLicense.ForeColor = Color.Yellow
        Else
            gCurrServerType = "local"
            btnUploadLicense.Text = "Upload License to Server"
            btnUploadLicense.BackColor = Color.LightYellow
            btnUploadLicense.ForeColor = Color.Black
        End If
    End Sub

    Private Sub Panel1_Paint(sender As Object, e As PaintEventArgs) Handles Panel1.Paint

    End Sub

    Function getUDLicenseSql() As String

        Dim Sdk As String = ckSdk.CheckState.ToString
        Dim Lease As String = ckLease.CheckState.ToString
        Dim LicenseID As String = "1"
        Dim LicType As String = ""
        If rbEnterpriseLicense.Checked Then LicType = "ENTERPRISE"
        If rbStdLicense.Checked Then LicType = "STANDARD"
        If rbDemoLicense.Checked Then LicType = "DEMO"
        If rb180.Checked Then LicType = "180Days"

        If Lease.Equals("Checked") Then
            Lease = "1"
        Else
            Lease = "0"
        End If
        If Sdk.Equals("Checked") Then
            Sdk = "1"
        Else
            Sdk = "0"
        End If

        Dim S As String = ""
        S += "USE [DMA.UD.License] " + vbCrLf
        S += "GO" + vbCrLf
        S += "delete from [dbo].[License] where CustomerID = '" + txtCustID.Text + "'" + vbCrLf
        S += "GO" + vbCrLf

        S += "INSERT INTO [dbo].[License]
           ([CustomerName]
           ,[CustomerID]
           ,[LicenseExpireDate]
           ,[NbrSeats]
           ,[NbrSimlUsers]
           ,[CompanyResetID]
           ,[MasterPW]
           ,[LicenseGenDate]
           ,[License]
           ,[LicenseID]
           ,[ContactName]
           ,[ContactEmail]
           ,[ContactPhoneNbr]
           ,[CompanyStreetAddress]
           ,[CompanyCity]
           ,[CompanyState]
           ,[CompanyZip]
           ,[MaintExpireDate]
           ,[CompanyCountry]
           ,[MachineID]
           ,[LicenseTypeCode]
           ,[ckSdk]
           ,[ckLease]
           ,[MaxClients]
           ,[MaxSharePoint]
           ,[ServerName]
           ,[SqlInstanceName]
           ,[StorageAllotment]
           ,[EncryptedLicense]
           ,[applied]
           ,[LastUpdate]
           ,[LicenseType])
     VALUES
           ("
        S += "'" + txtCustName.Text + "'" + vbCrLf
        S += ",'" + txtCustID.Text + "'" + vbCrLf
        S += ",'" + dtExpire.Value.ToString + "'" + vbCrLf
        S += ",'" + txtNbrSeats.Text + "' " + vbCrLf
        S += ",'" + txtNbrSimlSeats.Text + "' " + vbCrLf
        S += ",'" + txtCompanyResetID.Text + "' " + vbCrLf
        S += ",'" + txtMstrPw.Text + "' " + vbCrLf
        S += ",'" + txtLicenGenDate.Text + "' " + vbCrLf
        S += ",'" + txtLicense.Text + "' " + vbCrLf
        S += "," + LicenseID + " " + vbCrLf
        S += ",'" + txtContactName.Text + "' " + vbCrLf
        S += ",'" + txtContactEmail.Text + "' " + vbCrLf
        S += ",'" + txtContactPhone.Text + "' " + vbCrLf
        S += ",'" + txtCustAddr.Text + "' " + vbCrLf
        S += ",'" + txtCity.Text + "' " + vbCrLf
        S += ",'" + cbState.Text + "' " + vbCrLf
        S += ",'" + txtZip.Text + "' " + vbCrLf
        S += ",'" + dtMaintExpire.Value.ToString + "'" + vbCrLf
        S += ",'" + txtCustCountry.Text + "' " + vbCrLf
        S += ",'" + txtServerName.Text + "' " + vbCrLf
        S += ",'" + LicType + "'" + vbCrLf
        S += "," + Sdk + vbCrLf
        S += "," + Lease + vbCrLf
        S += ",'" + txtMaxClients.Text + "' " + vbCrLf
        S += ",'" + txtSharePointNbr.Text + "' " + vbCrLf
        S += ",'" + txtServerName.Text + "' " + vbCrLf
        S += ",'" + txtSSINstance.Text + "' " + vbCrLf
        S += "," + TextBox1.Text + " " + vbCrLf
        S += ",'" + txtLicense.Text + "' " + vbCrLf
        S += "," + "1" + vbCrLf
        S += ",getdate()" + vbCrLf
        S += ",'" + LicType + "')"
        Return S
    End Function

    Private Sub btnGenUpdtSQL_Click(sender As Object, e As EventArgs) Handles btnGenUpdtSQL.Click
        Dim S As String = ""

        LIC.setCompanyresetid(txtCompanyResetID.Text.Trim)
        LIC.setCustomerid(txtCustID.Text.Trim)
        LIC.setCustomername(txtCustName.Text.Trim)
        LIC.setLicense(txtLicense.Text)
        LIC.setLicenseexpiredate(CDate(dtExpire.Text).ToString)
        LIC.setLicensegendate(Now.ToString)
        If Not IsNumeric(txtVersionNbr.Text) Then
            MsgBox("Version Number MUST be numeric, aborting.")
            Return
        End If
        LIC.setLicenseid(txtVersionNbr.Text)
        LIC.setMasterpw(txtMstrPw.Text.Trim)
        If Not IsNumeric(txtNbrSeats.Text) Then
            MsgBox("Number of seats MUST be numeric, aborting.")
            Return
        End If
        LIC.setNbrseats(txtNbrSeats.Text)
        If Not IsNumeric(txtNbrSeats.Text) Then
            MsgBox("Number of seats MUST be numeric, aborting.")
            Return
        End If

        LIC.setCompanycountry(Me.txtCustCountry.Text)
        LIC.setCompanycity(txtCity.Text.Trim)
        LIC.setNbrsimlusers(txtNbrSimlSeats.Text.Trim)
        LIC.setContactname(txtContactName.Text.Trim)
        LIC.setContactemail(txtContactEmail.Text.Trim)
        LIC.setContactphonenbr(txtContactPhone.Text.Trim)
        LIC.setCompanystreetaddress(txtCustAddr.Text.Trim)
        LIC.setCompanystate(cbState.Text)
        LIC.setCompanyzip(txtZip.Text)
        LIC.setMaintexpiredate(CDate(dtMaintExpire.Text).ToString)
        LIC.setLicenseTypeCode(cbLicenseType.Text.Trim)
        LIC.setSdk(ckSdk.Checked)
        LIC.setLease(ckLease.Checked)

        If Not IsNumeric(txtMaxClients.Text) Then
            MsgBox("Only numeric data allowed in Max Clients.")
            Return
        End If
        LIC.setMaxClients(txtMaxClients.Text)

        If Not IsNumeric(txtSharePointNbr.Text) Then
            MsgBox("Only numeric data allowed in Max SharePoint DBs.")
            Return
        End If
        LIC.setSharePointNbr(Me.txtSharePointNbr.Text)

        S = ""
        S += "USE [ECM.Library.FS] " + vbCrLf
        S += "GO" + vbCrLf
        S += "IF EXISTS (Select 1 from dbo.license where [CustomerName] = '" + txtCustName.Text + "' and CustomerID = '" + txtCustID.Text + "' )" + Environment.NewLine
        S += "begin" + Environment.NewLine
        S += "    update [dbo].[License] 
                     set [Agreement] = '" + txtLicense.Text + "' 
                      where CustomerID = '" + txtCustID.Text + "' " + Environment.NewLine
        S += "END" + Environment.NewLine
        S += "ELSE" + Environment.NewLine
        S += "BEGIN" + Environment.NewLine
        S += LIC.genInsertSQL(txtServerName.Text, txtSSINstance.Text) + Environment.NewLine
        S += "END" + Environment.NewLine
        S += " " + Environment.NewLine
        S += "-- ***************************************************" + Environment.NewLine
        S += getUDLicenseSql() + Environment.NewLine

        Clipboard.Clear()
        Clipboard.SetText(S)

        MessageBox.Show("Update SQL is in the clipboard...")

    End Sub

    Private Sub btnGenInsertSQL_Click(sender As Object, e As EventArgs) Handles btnGenInsertSQL.Click
        Dim S As String = ""

        LIC.setCompanyresetid(txtCompanyResetID.Text.Trim)
        LIC.setCustomerid(txtCustID.Text.Trim)
        LIC.setCustomername(txtCustName.Text.Trim)
        LIC.setLicense(txtLicense.Text)
        LIC.setLicenseexpiredate(CDate(dtExpire.Text).ToString)
        LIC.setLicensegendate(Now.ToString)
        If Not IsNumeric(txtVersionNbr.Text) Then
            MsgBox("Version Number MUST be numeric, aborting.")
            Return
        End If
        LIC.setLicenseid(txtVersionNbr.Text)
        LIC.setMasterpw(txtMstrPw.Text.Trim)
        If Not IsNumeric(txtNbrSeats.Text) Then
            MsgBox("Number of seats MUST be numeric, aborting.")
            Return
        End If
        LIC.setNbrseats(txtNbrSeats.Text)
        If Not IsNumeric(txtNbrSeats.Text) Then
            MsgBox("Number of seats MUST be numeric, aborting.")
            Return
        End If

        LIC.setCompanycountry(Me.txtCustCountry.Text)
        LIC.setCompanycity(txtCity.Text.Trim)
        LIC.setNbrsimlusers(txtNbrSimlSeats.Text.Trim)
        LIC.setContactname(txtContactName.Text.Trim)
        LIC.setContactemail(txtContactEmail.Text.Trim)
        LIC.setContactphonenbr(txtContactPhone.Text.Trim)
        LIC.setCompanystreetaddress(txtCustAddr.Text.Trim)
        LIC.setCompanystate(cbState.Text)
        LIC.setCompanyzip(txtZip.Text)
        LIC.setMaintexpiredate(CDate(dtMaintExpire.Text).ToString)
        LIC.setLicenseTypeCode(cbLicenseType.Text.Trim)
        LIC.setSdk(ckSdk.Checked)
        LIC.setLease(ckLease.Checked)

        If Not IsNumeric(txtMaxClients.Text) Then
            MsgBox("Only numeric data allowed in Max Clients.")
            Return
        End If
        LIC.setMaxClients(txtMaxClients.Text)

        If Not IsNumeric(txtSharePointNbr.Text) Then
            MsgBox("Only numeric data allowed in Max SharePoint DBs.")
            Return
        End If
        LIC.setSharePointNbr(Me.txtSharePointNbr.Text)

        S = "USE [ECM.Library.FS] " + vbCrLf
        S += "GO" + vbCrLf
        S += "INSERT INTO [dbo].[License]
           ([Agreement]
           ,[VersionNbr]
           ,[ActivationDate]
           ,[InstallDate]
           ,[CustomerID]
           ,[CustomerName]
           ,[XrtNxr1]
           ,[ServerIdentifier]
           ,[SqlInstanceIdentifier]
           ,[MachineID]
           ,[HiveConnectionName]
           ,[HiveActive]
           ,[RepoSvrName]
           ,[RowCreationDate]
           ,[RowLastModDate]
           ,[ServerName]
           ,[SqlInstanceName]
           ,[SqlServerInstanceName]
           ,[SqlServerMachineName]
           ,[RepoName]
           ,[RowGuid])
     VALUES
           ("
        S = S + "'" + txtLicense.Text + "'" + "," + vbCrLf      'Agreement
        S = S + "'" + txtVersionNbr.Text + "'" + "," + vbCrLf    'VersionNbr
        S = S + "'" + Now.ToString + "'" + "," + vbCrLf         'ActivationDate
        S = S + "'" + Now.ToString + "'" + "," + vbCrLf         'InstallDate
        S = S + "'" + txtCustID.Text.Trim + "'" + "," + vbCrLf   'CustomerID
        S = S + "'" + txtCustName.Text.Trim + "'" + "," + vbCrLf 'CustomerName
        S = S + "'" + "XX" + "'" + "," + vbCrLf         'XrtNxr1
        S = S + "'" + ServerName + "'" + "," + vbCrLf 'ServerIdentifier
        S = S + "'" + SqlInstanceName + "'" + "," + vbCrLf  'SqlInstanceIdentifier
        S = S + "'" + ServerName + "'" + "," + vbCrLf    'MachineID
        S = S + "'NA'" + "," + vbCrLf                       'HiveConnectionName
        S = S + "0," + vbCrLf                            'HiveActive
        S = S + "'" + ServerName + "'" + "," + vbCrLf    'RepoSvrName
        S = S + "getdate()," + vbCrLf                    'RowCreationDate
        S = S + "getdate()," + vbCrLf                    'RowLastModDate
        S = S + "'" + ServerName + "'" + ","    'ServerName
        S = S + "'" + ServerName + "'" + ","    'SqlInstanceName
        S = S + "'" + SqlInstanceName + "'" + ","    'SqlServerInstanceName
        S = S + "'" + ServerName + "'" + ","    'SqlServerMachineName
        S = S + "'ECM.Library.FS'" + ","        'RepoName
        S = S + "'" + Guid.NewGuid().ToString() + "'" + ")"        'RowGuid        

        'Dim RemoteSql As New clsLICENSE()
        'S = RemoteSql.genInsertSQLClient(ServerName, SqlInstanceName, txtLicenGenDate.Text)
        'RemoteSql = Nothing

        S += " " + vbCrLf
        S += "---------------------------------------------------------------------------------------"
        S += " " + vbCrLf
        S += "Use ECM.Library.FS" + vbCrLf
        S += "GO" + vbCrLf
        S += " " + vbCrLf
        S += "Update [dbo].[License] " + vbCrLf
        S += "Set [CustomerName] = '" + txtCustName.Text.Trim + "'" + vbCrLf
        S += ",[Agreement] = '" + txtLicense.Text.Trim + "'" + vbCrLf      '<License, nvarchar(max),>
        S += ",[InstallDate] = '" + Now.ToString + "'" + vbCrLf  'LicenseExpireDate, datetime,>
        S += ",[RowLastModDate] = '" + Now.ToString + "'" + vbCrLf  'LicenseExpireDate, datetime,>
        S += ",[ServerName] = '" + txtServerName.Text.Trim + "'" + vbCrLf      '<CompanyResetID, nvarchar(50),>
        S += ",[SQLInstanceName] = '" + txtSSINstance.Text.Trim + "'" + vbCrLf      '<CompanyResetID, nvarchar(50),>
        S += ",[MachineID] = @@SERVERNAME" + vbCrLf      '<CompanyResetID, nvarchar(50),>
        S += ",[RepoSvrName] = @@SERVERNAME" + vbCrLf      '<CompanyResetID, nvarchar(50),>
        S += ",[RepoName] = @@SERVERNAME" + vbCrLf      '<CompanyResetID, nvarchar(50),>
        S += "WHERE CustomerID = '" + txtCustID.Text.Trim + "'" + vbCrLf

        S += " " + Environment.NewLine
        S += "-- ***************************************************" + Environment.NewLine
        S += getUDLicenseSql() + Environment.NewLine

        Clipboard.Clear()
        Clipboard.SetText(S)

        MessageBox.Show("Update SQL is in the clipboard...")
    End Sub
End Class

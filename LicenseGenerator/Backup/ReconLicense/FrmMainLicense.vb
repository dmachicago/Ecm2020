Imports System.IO
Imports System.Data.Sql
Imports System.Data.SqlClient
Imports System.Configuration
Imports System.Configuration.ConfigurationSettings


Public Class FrmMainLicense
    Dim ENC As New clsEncrypt
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

        Dim CS$ = System.Configuration.ConfigurationManager.AppSettings("DMA_UD_License")

        PopulateGrid()

        dtExpire.Enabled = False


    End Sub
    Function AppendData(ByVal Key$, ByVal tVal$) As String
        Dim S$ = ""
        DMA.ReplaceSingleQuotes(tVal)
        DMA.ReplaceVerticalBar(tVal)
        LicenseData$ = LicenseData$ & "|" & Key$ & "|" & tVal
        Debug.Print("Length = " + LicenseData$.Length.ToString)
        Return LicenseData$
    End Function

    Private Sub btnGenerateLicense_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnGenerateLicense.Click

        ServerName = txtServerName.Text.Trim
        SqlInstanceName = txtSSINstance.Text.Trim
        If ServerName.Length = 0 Or SqlInstanceName.Length = 0 Then
            MsgBox("Both the SERVER name and the SQL Server Instance name must be supplied, returning.")
            Return
        End If

        If cbLicenseType.Text.Trim.Length = 0 Then
            MsgBox("Please select the License Type, returning.", MsgBoxStyle.Critical, "Required Data Missing")
            Return
        End If

        GenLicense()

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

        Dim iCnt As Integer = LIC.cnt_PK_License(txtCustID.Text.Trim, Val(txtVersionNbr.Text))
        If iCnt > 0 Then
            MsgBox("This account already exists... check your data.")
            Return
        End If

        B = LIC.Insert(ServerName, SqlInstanceName)

        If Not B Then
            MsgBox("Failed to add new license... aborting.")
            Return
        Else


            Dim S$ = ""
            If ckSdk.Checked Then
                S$ = "Update License set ckSdk = 1 where CustomerID = '" + txtCustID.Text.Trim + "' "
            Else
                S$ = "Update License set ckSdk = 0 where CustomerID = '" + txtCustID.Text.Trim + "' "
            End If
            B = DB.ExecuteSqlNewConn(S)
            If B Then
                SB.Text = "Customer Information Set."
            End If

            S$ = ""
            If ckLease.Checked Then
                S$ = "Update License set ckLease = 1 where CustomerID = '" + txtCustID.Text.Trim + "' "
            Else
                S$ = "Update License set ckLease = 0 where CustomerID = '" + txtCustID.Text.Trim + "' "
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

        ServerName = txtServerName.Text.Trim
        SqlInstanceName = txtSSINstance.Text.Trim
        If ServerName.Length = 0 Or SqlInstanceName.Length = 0 Then
            MsgBox("Both the SERVER name and the SQL Server Instance name must be supplied, returning.")
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

    Sub GenLicense()

        ServerName = txtServerName.Text.Trim
        SqlInstanceName = txtSSINstance.Text.Trim
        If ServerName.Length = 0 Or SqlInstanceName.Length = 0 Then
            MsgBox("Both the SERVER name and the SQL Server Instance name must be supplied, returning.")
            Return
        End If

        If cbLicenseType.Text.Trim.Length = 0 Then
            MsgBox("You must define the TYPE OF LICENSE, returning.")
            Return
        End If
        Try
            LicenseData$ = ""
            LicenseData$ = AppendData("cbLicenseType", cbLicenseType.Text.Trim)
            LicenseData$ = AppendData("txtCustName", txtCustName.Text.Trim)
            LicenseData$ = AppendData("txtCustAddr", txtCustAddr.Text.Trim)
            LicenseData$ = AppendData("txtCustCountry", txtCustCountry.Text.Trim)
            LicenseData$ = AppendData("cbState", cbState.Text.Trim)
            LicenseData$ = AppendData("txtZip", txtZip.Text.Trim)
            LicenseData$ = AppendData("txtCustID", txtCustID.Text.Trim)
            LicenseData$ = AppendData("dtExpire", dtExpire.Text.Trim)
            LicenseData$ = AppendData("txtNbrSeats", txtNbrSeats.Text.Trim)
            LicenseData$ = AppendData("txtNbrSimlSeats", txtNbrSimlSeats.Text.Trim)
            LicenseData$ = AppendData("txtCompanyResetID", txtCompanyResetID.Text.Trim)
            LicenseData$ = AppendData("txtMstrPw", txtMstrPw.Text.Trim)
            LicenseData$ = AppendData("txtLicenGenDate", Now.ToString)
            LicenseData$ = AppendData("dtMaintExpire", dtMaintExpire.Text.Trim)
            LicenseData$ = AppendData("rbEnterpriseLicense", rbEnterpriseLicense.Checked.ToString)
            LicenseData$ = AppendData("rbStdLicense", rbStdLicense.Checked.ToString)
            LicenseData$ = AppendData("rbDemoLicense", rbDemoLicense.Checked.ToString)

            LicenseData$ = AppendData("ckSdk", ckSdk.Checked.ToString)
            LicenseData$ = AppendData("ckLease", ckLease.Checked.ToString)

            LicenseData$ = AppendData("txtMaxClients", txtMaxClients.Text)
            LicenseData$ = AppendData("txtSharePointNbr", txtSharePointNbr.Text)

            LicenseData$ = AppendData("ckToClipboard", ckToClipboard.Checked.ToString)
            LicenseData$ = AppendData("ckToFile", ckToFile.Checked.ToString)
            LicenseData$ = AppendData("ckToEmail", ckToEmail.Checked.ToString)
            LicenseData$ = AppendData("txtContactName", txtContactName.Text.Trim)
            LicenseData$ = AppendData("txtContactPhone", txtContactPhone.Text.Trim)
            LicenseData$ = AppendData("txtContactEmail", txtContactEmail.Text.Trim)
            LicenseData$ = AppendData("txtVersionNbr", txtVersionNbr.Text.Trim)
            LicenseData$ = AppendData("txtCity", txtCity.Text.Trim)

            LicenseData$ = AppendData("txtServerName", txtServerName.Text.Trim)
            LicenseData$ = AppendData("txtSSINstance", txtSSINstance.Text.Trim)

            LicenseData$ = AppendData("EndOfLicense", "EOL")

            Debug.Print(LicenseData$.Length)

            Dim EncryptedLicense$ = ENC.AES256EncryptString(LicenseData$)
            txtLicense.Text = EncryptedLicense$
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try

    End Sub

    Private Sub btnEncrypt_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEncrypt.Click
        GenLicense()
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

            Dim CS$ = DB.getConnStr

            Dim sqlcn As New SqlConnection(CS)
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

        Clipboard.Clear()
        Clipboard.SetText(MySql)

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

    End Sub

    Private Sub btnOverwrite_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnOverwrite.Click

        ServerName = txtServerName.Text.Trim
        SqlInstanceName = txtSSINstance.Text.Trim
        If ServerName.Length = 0 Or SqlInstanceName.Length = 0 Then
            MsgBox("Both the SERVER name and the SQL Server Instance name must be supplied, returning.")
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

        Dim iCnt As Integer = LIC.cnt_PK_License(txtCustID.Text.Trim, Val(txtVersionNbr.Text))
        If iCnt = 0 Then
            MsgBox("Account cannot be found... check your data.")
            Return
        End If

        Dim WC$ = LIC.wc_PK_License(txtCustID.Text.Trim, Val(txtVersionNbr.Text))

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
        End If
    End Sub

    Private Sub btnParse_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnParse.Click

        Dim S$ = Me.txtLicense.Text
        ParseLic(S$, True)

    End Sub
    Function ParseLic(ByVal S$, ByVal DisplayMsgBox As Boolean) As Boolean

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

        ServerName = txtServerName.Text.Trim
        SqlInstanceName = txtSSINstance.Text.Trim
        If ServerName.Length = 0 Or SqlInstanceName.Length = 0 Then
            MsgBox("Both the SERVER name and the SQL Server Instance name must be supplied, returning.")
            Return
        End If

        If cbLicenseType.Text.Trim.Length = 0 Then
            MsgBox("Please select the License Type, returning.", MsgBoxStyle.Critical, "Reuqired Data Missing")
            Return
        End If

        Dim MachineID$ = ServerName
        Dim EncryptedLicense$ = ""
        Dim CustomerName As String = Me.dgLicense.CurrentRow.Cells("CustomerName").Value.ToString
        Dim CustomerID As String = Me.dgLicense.CurrentRow.Cells("CustomerID").Value.ToString
        Dim LicenseID As String = Me.dgLicense.CurrentRow.Cells("LicenseID").Value.ToString

        Dim PurchasedMachines$ = txtNbrSeats.Text
        Dim PurchasedUsers$ = txtNbrSimlSeats.Text
        Dim SupportActive$ = "Y"
        Dim SupportActiveDate$ = Now.ToString
        Dim SupportInactiveDate$ = dtMaintExpire.Text.ToString
        Dim LicenseType$ = ""

        LicenseType$ = cbLicenseType.Text
        If LicenseType$.Trim.Length = 0 Then
            MsgBox("You must CHECK the type of license. Bottom left, radio buttons.")
            Return
        End If

        GenLicense()
        EncryptedLicense$ = txtLicense.Text.Trim

        'Dim BB As Boolean = DB.UploadLicense(CustomerID, LicenseID$, MachineID$, EncryptedLicense$)

        Try
            Dim iCnt As Integer = RL.cnt_PK19(CustomerID, LicenseID)
            If iCnt > 0 Then
                '** We have to update the license.
                Dim WC$ = RL.wc_PK19(CustomerID, LicenseID)
                RL.setEncryptedlicense(EncryptedLicense$)
                RL.setPurchasedmachines(PurchasedMachines$)
                RL.setPurchasedusers(PurchasedUsers$)
                RL.setSupportactive(SupportActive)
                RL.setLicensetypecode(LicenseType$)
                RL.setInstalleddate(Now.ToString)
                RL.setLastupdate(Now.ToString)
                Dim B As Boolean = RL.UpdateLicense(WC, CustomerID, ServerName, SqlInstanceName)
                If B Then
                    SB.Text = txtCustID.Text + ": License updated on remote server."
                    MsgBox(txtCustID.Text + ": License updated on remote server.")
                Else
                    SB.Text = txtCustID.Text + ": ERROR: License NOT updated on remote server."
                End If
            Else
                '** We have to add the record
                RL.setCompanyid(CustomerID)
                RL.setLicenseid(LicenseID)
                RL.setMachineid(ServerName)
                'RL.setLicensetypecode(cbLicenseType.Text.Trim)
                RL.setEncryptedlicense(EncryptedLicense$)
                RL.setPurchasedmachines(PurchasedMachines$)
                RL.setPurchasedusers(PurchasedUsers$)
                RL.setSupportactive(SupportActive)
                RL.setLicensetypecode(LicenseType$)
                RL.setInstalleddate(Now.ToString)
                RL.setLastupdate(Now.ToString)

                Dim B As Boolean = RL.Insert(CustomerID, ServerName, SqlInstanceName)
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

        Dim iCnt As Integer = LIC.cnt_PK_License(txtCustID.Text.Trim, Val(txtVersionNbr.Text))
        If iCnt = 0 Then
            MsgBox("This account DOES NOT exists... check your data.")
            Return
        End If

        Dim WC$ = LIC.wc_PK_License(txtCustID.Text.Trim, Val(txtVersionNbr.Text))
        B = LIC.Delete(WC)

        If Not B Then
            MsgBox("Failed to DEKETE license... aborting.")
        Else
            SB.Text = "License deleted from local DB."
        End If

        '**********************************************************************
        Dim MachineID$ = ServerName
        Dim EncryptedLicense$ = ""
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
                WC$ = RL.wc_PK19(CustomerID, LicenseID)
                RL.setEncryptedlicense(EncryptedLicense$)
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

        Dim S$ = Me.txtLicense.Text

        Dim tKey$ = ""
        Dim tVal$ = ""
        Dim A As New SortedList(Of String, String)
        Dim S1$ = ""
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
            rbEnterpriseLicense.Checked = CBool(tVal.Trim)
        Else
            rbEnterpriseLicense.Checked = False
        End If
        
        I = A.IndexOfKey("rbStdLicense")
        If I >= 0 Then
            tVal = A.Values(I)
            rbStdLicense.Checked = CBool(tVal.Trim)
        Else
            rbStdLicense.Checked = False
        End If
        

        I = A.IndexOfKey("rbDemoLicense")
        If I >= 0 Then
            tVal = A.Values(I)
            rbDemoLicense.Checked = CBool(tVal.Trim)
        Else
            rbDemoLicense.Checked = False
        End If
        

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

        ServerName = txtServerName.Text.Trim
        SqlInstanceName = txtSSINstance.Text.Trim
        If ServerName.Length = 0 Or SqlInstanceName.Length = 0 Then
            MsgBox("Both the SERVER name and the SQL Server Instance name must be supplied, returning.")
            Return
        End If

        Dim S$ = ""

        Dim CompanyID$ = ""
        Dim LicenseID$ = ""
        Dim PurchasedMachines$ = ""
        Dim PurchasedUsers$ = ""
        Dim SupportActive$ = ""
        Dim SupportActiveDate$ = ""
        Dim SupportInactiveDate$ = ""
        Dim LicenseText$ = ""
        Dim LicenseTypeCode$ = ""
        Dim MachineID$ = ""
        Dim Applied$ = ""
        Dim EncryptedLicense$ = ""
        Dim InstalledDate$ = ""
        Dim LastUpdate$ = ""

        Dim ExistingLicenses As New List(Of String)

        For K As Integer = 0 To dgLicense.Rows.Count - 1
            Try
                CompanyID = dgLicense.Rows(K).Cells("CustomerID").Value.ToString
                ExistingLicenses.Add(CompanyID)
            Catch ex As Exception

            End Try
        Next

        S = S + "   select "
        S = S + " 	CompanyID,"
        S = S + " 	LicenseID,"
        S = S + " 	PurchasedMachines,"
        S = S + " 	PurchasedUsers,"
        S = S + " 	SupportActive,"
        S = S + " 	SupportActiveDate,"
        S = S + " 	SupportInactiveDate,"
        S = S + " 	LicenseText,"
        S = S + " 	LicenseTypeCode,"
        S = S + " 	MachineID,"
        S = S + " 	Applied,"
        S = S + " 	EncryptedLicense,"
        S = S + " 	InstalledDate,"
        S = S + " 	LastUpdate, ServerName, SqlInstanceName"
        S = S + " from License"

        RL.PopulateRemoteGrid(dgRemote, S)

        For i As Integer = 0 To dgRemote.Rows.Count - 1


            Try
                CompanyID = dgRemote.Rows(i).Cells("CompanyID").Value.ToString
            Catch ex As Exception
                Exit For
            End Try
            If ExistingLicenses.Contains(CompanyID) Then
                '** Skip it, it already exists in the DB
            Else
                LicenseID = dgRemote.Rows(i).Cells("LicenseID").Value.ToString
                PurchasedMachines = dgRemote.Rows(i).Cells("PurchasedMachines").Value.ToString
                PurchasedUsers = dgRemote.Rows(i).Cells("PurchasedUsers").Value.ToString
                SupportActive = dgRemote.Rows(i).Cells("SupportActive").Value.ToString
                SupportActiveDate = dgRemote.Rows(i).Cells("SupportActiveDate").Value.ToString
                SupportInactiveDate = dgRemote.Rows(i).Cells("SupportInactiveDate").Value.ToString
                LicenseText = dgRemote.Rows(i).Cells("LicenseText").Value.ToString
                LicenseTypeCode = dgRemote.Rows(i).Cells("LicenseTypeCode").Value.ToString
                MachineID = dgRemote.Rows(i).Cells("MachineID").Value.ToString
                Applied = dgRemote.Rows(i).Cells("Applied").Value.ToString
                EncryptedLicense = dgRemote.Rows(i).Cells("EncryptedLicense").Value.ToString
                InstalledDate = dgRemote.Rows(i).Cells("InstalledDate").Value.ToString
                LastUpdate = dgRemote.Rows(i).Cells("LastUpdate").Value.ToString

                ServerName = dgRemote.Rows(i).Cells("ServerName").Value.ToString
                SqlInstanceName = dgRemote.Rows(i).Cells("SqlInstanceName").Value.ToString

                LIC.setCustomername(CompanyID)
                LIC.setCompanyresetid("ECM")
                LIC.setCustomerid(CompanyID)
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

                Dim iCnt As Integer = LIC.cnt_PK_License(CompanyID, "0")
                If iCnt > 0 Then
                    Console.WriteLine("This account already exists... check your data.")
                End If

                Dim B As Boolean = LIC.Insert(ServerName, SqlInstanceName)

                If B = False Then
                    MsgBox("Failed to insert License KeyID: " + CompanyID)
                End If
            End If
        Next
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

End Class

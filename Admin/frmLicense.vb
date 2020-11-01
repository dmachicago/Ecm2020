Imports System.Data
Imports System.Data.Sql
Imports System.Data.SqlClient

Public Class frmLicense
    Private XX1 As String = ""

    Dim ENC As New clsEncrypt

    Private Sub btnClose_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnClose.Click
        Me.Close()
    End Sub

    Private Sub frmLicense_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        XX1 = txtCurrConnStr.Text
        If InStr(txtCurrConnStr.Text, "Password", CompareMethod.Text) > 0 Then
            txtCurrConnStr.Text = Mid(txtCurrConnStr.Text, 1, InStr(txtCurrConnStr.Text, "Password", CompareMethod.Text) - 1)
        End If
    End Sub

    Private Sub btnApply_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnApply.Click
        Dim CustomerID As String = txtCompanyID.Text.Trim
        If CustomerID$.Length = 0 Then
            MsgBox("Customer ID required: " + vbCrLf + "If you do not know your Customer ID, " + vbCrLf + "please contact ECM Support or your ECM administrator.")
            Return
        End If
        Dim SelectedServer As String = txtServer.Text
        If SelectedServer$.Length = 0 Then
            MsgBox("Please select the Server to which this license applies." + vbCrLf + "The server name and must match that contained within the license.")
            Return
        End If
        Dim B As Boolean = saveLicenseCutAndPaste(txtLicense.Text, CustomerID, SelectedServer)
        If Not B Then
            SB.Text = "Failed to save license."
        Else
            SB.Text = "Saved license."
        End If
    End Sub

    Function saveLicenseCutAndPaste(ByVal LS As String, ByVal CustomerID As String, ByVal MachineID As String) As Boolean

        Dim B As Boolean = False
        Dim I As Integer
        Dim S As String = "delete from License "

        Dim iCnt As Integer = 0
        Dim sLic As String = ""

        Dim CONN As New SqlConnection(XX1)

        Try
            If CONN.State = ConnectionState.Closed Then
                CONN.Open()
            End If
            Dim CMD As New SqlCommand(S)
            CMD.Connection = CONN
            I = CMD.ExecuteNonQuery

            sLic = ""
            sLic = sLic + "INSERT INTO [License]"
            sLic = sLic + "([Agreement]"
            sLic = sLic + ",[VersionNbr]"
            sLic = sLic + ",[ActivationDate]"
            sLic = sLic + ",[InstallDate]"
            sLic = sLic + ",[CustomerID]"
            sLic = sLic + ",[CustomerName]"
            sLic = sLic + ",[XrtNxr1], MachineID)"
            sLic = sLic + "VALUES "
            sLic = sLic + "('" + LS + "'"
            sLic = sLic + ",1"
            sLic = sLic + ",GETDATE()"
            sLic = sLic + ",GETDATE()"
            sLic = sLic + ",'" + CustomerID + "'"
            sLic = sLic + ",'XX'"
            sLic = sLic + ",'XX', '" + MachineID + "')"

            CMD.CommandText = sLic
            I = CMD.ExecuteNonQuery

        Catch ex As Exception
            MessageBox.Show("LIcense Error: " + ex.Message)
            B = False
        Finally
            B = True
            If CONN IsNot Nothing Then
                CONN.Dispose()
            End If
        End Try

        Return B
    End Function

    Private Sub btnShowRules_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnShowRules.Click
        Dim LT$ = GetXrt()
        ParseLic(LT$, True)
    End Sub
    Function GetXrt() As String
        Dim S As String = "Select Agreement from License where [LicenseID] = (SELECT max([LicenseID]) FROM [License])"
        Try
            Dim tCnt$ = ""
            Dim RSData As SqlDataReader = Nothing
            Dim CS$ = XX1
            Dim CONN As New SqlConnection(CS)
            CONN.Open()
            Dim command As New SqlCommand(S, CONN)
            RSData = command.ExecuteReader()
            If RSData.HasRows Then
                Do While RSData.Read()
                    S = RSData.GetValue(0).ToString
                    Application.DoEvents()
                Loop
            End If
            RSData.Close()
            RSData = Nothing

            Return S
        Catch ex As Exception
            MessageBox.Show("ERROR could not acquire license: " + ex.Message)
            S = ""
            Return S
        End Try
    End Function
    Function ParseLic(ByVal S as string, byval ShowLicRules As Boolean) As Boolean

        Dim tKey$ = ""
        Dim tVal$ = ""
        Dim I As Integer = 0
        Dim B As Boolean = False
        Dim xTrv1 As Boolean = True
        Try
            Dim LicList As SortedList(Of String, String) = ENC.xt001trc(S)
            B = True
            If xTrv1 Then
                Dim cbLicenseType$ = getEncryptedValue("cbLicenseType", LicList)
                Dim cbState$ = getEncryptedValue("cbState", LicList)
                Dim ckToClipboard$ = getEncryptedValue("ckToClipboard", LicList)
                Dim ckToEmail$ = getEncryptedValue("ckToEmail", LicList)
                Dim ckToFile$ = getEncryptedValue("ckToFile", LicList)
                Dim dtExpire$ = getEncryptedValue("dtExpire", LicList)
                Dim dtMaintExpire$ = getEncryptedValue("dtMaintExpire", LicList)
                Dim EndOfLicense$ = getEncryptedValue("EndOfLicense", LicList)
                Dim rbNbrOfSeats$ = getEncryptedValue("rbNbrOfSeats", LicList)
                Dim rbNbrOfUsers$ = getEncryptedValue("rbNbrOfUsers", LicList)
                Dim rbSimultaneousUsers$ = getEncryptedValue("rbSimultaneousUsers", LicList)
                Dim rbStandardLicense$ = getEncryptedValue("rbStandardLicense", LicList)
                Dim txtCity$ = getEncryptedValue("txtCity", LicList)
                Dim txtCompanyResetID$ = getEncryptedValue("txtCompanyResetID", LicList)
                Dim txtContactEmail$ = getEncryptedValue("txtContactEmail", LicList)
                Dim txtContactName$ = getEncryptedValue("txtContactName", LicList)
                Dim txtContactPhone$ = getEncryptedValue("txtContactPhone", LicList)
                Dim txtCustAddr$ = getEncryptedValue("txtCustAddr", LicList)
                Dim txtCustCountry$ = getEncryptedValue("txtCustCountry", LicList)
                Dim txtCustID$ = getEncryptedValue("txtCustID", LicList)
                Dim txtCustName$ = getEncryptedValue("txtCustName", LicList)
                Dim txtLicenGenDate$ = getEncryptedValue("txtLicenGenDate", LicList)
                'Dim txtMstrPw$ = getEncryptedValue("txtMstrPw", LicList)
                Dim txtNbrSeats$ = getEncryptedValue("txtNbrSeats", LicList)
                Dim txtNbrSimlSeats$ = getEncryptedValue("txtNbrSimlSeats", LicList)
                Dim txtVersionNbr$ = getEncryptedValue("txtVersionNbr", LicList)
                Dim txtZip$ = getEncryptedValue("txtZip", LicList)
                Dim Sdk$ = getEncryptedValue("ckSdk", LicList)
                Dim ServerName As String = getEncryptedValue("txtServerName", LicList)
                txtServerName.Text = ServerName
                Dim SSINstance As String = getEncryptedValue("txtSSINstance", LicList)
                txtServer.Text = SSINstance
                If Sdk$.Length = 0 Then
                    Sdk$ = "False"
                End If
                Dim Lease$ = getEncryptedValue("ckLease", LicList)
                If Lease.Length = 0 Then
                    Lease = "False"
                End If

                Dim MaxClients$ = getEncryptedValue("txtMaxClients", LicList)

                If ShowLicRules = True Then
                    Dim Msg$ = ""
                    Msg = Msg + "License Type:" + cbLicenseType$ + vbCrLf
                    Msg = Msg + "State: " + cbState$ + vbCrLf
                    'Msg = Msg + " ckToClipboard$: " + ckToClipboard$ + vbCrLf
                    'Msg = Msg + " ckToEmail$: " + ckToEmail$ + vbCrLf
                    'Msg = Msg + " ckToFile$: " + ckToFile$ + vbCrLf
                    Msg = Msg + "License Expires: " + dtExpire$ + vbCrLf
                    Msg = Msg + "Maint Expires  : " + dtMaintExpire$ + vbCrLf
                    'Msg = Msg + " EndOfLicense: " + EndOfLicense$ + vbCrLf
                    'Msg = Msg + " rbNbrOfSeats: " + rbNbrOfSeats$ + vbCrLf
                    'Msg = Msg + " rbNbrOfUsers: " + rbNbrOfUsers$ + vbCrLf
                    'Msg = Msg + " rbSimultaneousUsers: " + rbSimultaneousUsers$ + vbCrLf
                    'Msg = Msg + " rbStandardLicense: " + rbStandardLicense$ + vbCrLf
                    Msg = Msg + "City: " + txtCity$ + vbCrLf
                    'Msg = Msg + " txtCompanyResetID: " + txtCompanyResetID$ + vbCrLf
                    Msg = Msg + "Contact Email: " + txtContactEmail$ + vbCrLf
                    Msg = Msg + "Contact Name: " + txtContactName$ + vbCrLf
                    Msg = Msg + "Contact Phone: " + txtContactPhone$ + vbCrLf
                    Msg = Msg + "Cust Addr: " + txtCustAddr$ + vbCrLf
                    Msg = Msg + "Cust Country: " + txtCustCountry$ + vbCrLf
                    Msg = Msg + "Cust ID: " + txtCustID$ + vbCrLf
                    Msg = Msg + "Cust Name: " + txtCustName$ + vbCrLf
                    Msg = Msg + "License Gen Date: " + txtLicenGenDate$ + vbCrLf
                    'Dim txtMstrPw$ = getEncryptedValue("txtMstrPw", LicList)
                    Msg = Msg + "Nbr Seats: " + txtNbrSeats$ + vbCrLf
                    Msg = Msg + "Nbr Siml Seats: " + txtNbrSimlSeats$ + vbCrLf
                    Msg = Msg + "Version Nbr: " + txtVersionNbr$ + vbCrLf
                    Msg = Msg + "Type License: " + cbLicenseType$ + vbCrLf
                    Msg = Msg + "SDK: " + Sdk + vbCrLf
                    Msg = Msg + "Lease: " + Lease + vbCrLf
                    If MaxClients.Equals("0") Then
                        MaxClients = "Unlimited"
                    End If
                    Msg = Msg + "MaxClients: " + MaxClients + vbCrLf
                    Msg = Msg + "Server Name: " + ServerName + vbCrLf
                    Msg = Msg + "SQL Server/Instance: " + SSINstance + vbCrLf
                    MsgBox(Msg)
                End If

            End If
        Catch ex As Exception
            MsgBox("Error 53.25.1: failed to Parse License." + vbCrLf + vbCrLf + ex.Message)
        End Try
        Return B
    End Function
    Public Function getEncryptedValue(ByVal iKey as string, byval A As SortedList(Of String, String)) As String
        Dim tVal$ = ""

        'For I As Integer = 0 To A.Count - 1
        '    Console.WriteLine(A.Values(I).ToString + " : " + A.Keys(I).ToString)
        'Next

        Dim iDx As Integer = A.IndexOfKey(iKey)
        'iDx = A.ContainsValue(iKey)
        If iDx >= 0 Then
            tVal$ = A.Values(iDx).ToString
        Else
            tVal = ""
        End If
        Return tVal
    End Function

    Private Sub btnGetCurrLicense_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnGetCurrLicense.Click

        Dim repoServer As String = txtServerName.Text.Trim
        Dim CompanyID As String = txtCompanyID.Text.Trim

        Dim SqlServerInstanceNameX As String = txtServer.Text
        Dim SqlServerMachineName As String = txtServerName.Text

        If CompanyID.Length = 0 Then
            MsgBox("You must supply your Company ID to access the server, returning.")
            Return
        End If

        Try
            If repoServer$.Length = 0 Then
                MsgBox("You must select a Repository Server, returning.")
                Return
            End If
            '** 
            Dim bFetch As Boolean = getClientLicenses(CompanyID)
            If bFetch Then
                SB.Text = "Successfully retrieved license."
            Else
                SB.Text = "Failed to retrieve license."
            End If
        Catch ex As Exception
            MessageBox.Show("LIcense Recall Error: " + ex.Message.ToString)
        End Try

    End Sub
    Function getClientLicenses(ByVal CompanyID as string) As Boolean
        Dim ClientLicenseServer$ = ""
        Dim isApplied As Boolean = False
        Dim B As Boolean = False

        Dim CS As String = XX1
        Dim LicenseID$ = ""
        Dim MachineID$ = ""
        Dim LicenseTypeCode$ = ""
        Dim Applied$ = ""
        Dim EncryptedLicense$ = ""
        Dim SupportActiveDate$ = ""
        Dim SupportInactiveDate$ = ""
        Dim PurchasedMachines$ = ""
        Dim PurchasedUsers$ = ""
        Dim SupportActive$ = ""
        Dim LicenseText$ = ""

        Dim ServerNAME As String = ""
        Dim SqlInstanceName As String = ""

        Try
            Dim S$ = "select Agreement from License"
            Dim I As Integer = 0
            Dim rsColInfo As SqlDataReader = Nothing
            rsColInfo = SqlQryNewConn(S, CS)

            If rsColInfo.HasRows Then
                Do While rsColInfo.Read()
                    EncryptedLicense$ = rsColInfo.GetValue(0).ToString
                    txtLicense.Text = EncryptedLicense
                    txtServerName.Text = ServerNAME
                    txtServer.Text = SqlInstanceName
                Loop
            Else
                MsgBox("License not found, please insure the required Company ID and other information is correct.")
            End If

            If Not rsColInfo.IsClosed Then
                rsColInfo.Close()
            End If
            If Not rsColInfo Is Nothing Then
                rsColInfo = Nothing
            End If
            GC.Collect()
            GC.WaitForFullGCApproach()

            B = True
        Catch ex As Exception
            MessageBox.Show("getClientLicenses: Failed to retrieve Server data:" + vbCrLf + ex.Message)
            B = False
        End Try

        Return B

    End Function
    Public Function SqlQryNewConn(ByVal sql As String, ByVal ConnectionString As String) As SqlDataReader
        ''Session("ActiveError") = False
        Dim dDebug As Boolean = False
        Dim queryString As String = sql
        Dim rc As Boolean = False
        Dim rsDataQry As SqlDataReader = Nothing

        Dim CN As New SqlConnection(ConnectionString)

        If CN.State = ConnectionState.Closed Then
            CN.Open()
        End If

        Dim command As New SqlCommand(sql, CN)

        Try
            rsDataQry = command.ExecuteReader()
        Catch ex As Exception
            MessageBox.Show("clsDatabase : SqlQryNewConn : 1368bb : " + sql)
        End Try

        command.Dispose()
        command = Nothing

        Return rsDataQry
    End Function

    Private Sub txtCompanyID_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtCompanyID.TextChanged
        txtLicense.Visible = True
        btnApply.Visible = True
        btnClose.Visible = True
        btnShowRules.Visible = True
        btnGetCurrLicense.Visible = True
    End Sub
End Class
Imports System.Data.SqlClient

Public Class clsRemoteLICENSE
    Dim gConnStr As String = ""
    Dim gRemoteConnStr As String = ""
    Dim gConn As SqlConnection
    Dim gRemoteConn As SqlConnection

    '** DIM the selected table columns
    Dim DB As New clsDatabase

    Dim DMA As New clsDma
    'DIM DG as new clsDataGrid

    Dim CustomerID As String = ""
    Dim LicenseID As String = ""
    Dim PurchasedMachines As String = ""
    Dim PurchasedUsers As String = ""
    Dim SupportActive As String = ""
    Dim SupportActiveDate As String = ""
    Dim SupportInactiveDate As String = ""
    Dim LicenseText As String = ""
    Dim LicenseTypeCode As String = ""
    Dim MachineID As String = ""
    Dim Applied As String = ""
    Dim EncryptedLicense As String = ""
    Dim InstalledDate As String = ""
    Dim LastUpdate As String = ""

    Dim CustomerName As String = ""
    Dim CompanyResetID As String = ""
    Dim MasterPW As String = ""
    Dim License As String = ""

    Dim RemoteConnectionString As String = ""

    Sub New()
        Dim reader As New System.Configuration.AppSettingsReader
        RemoteConnectionString = reader.GetValue("DMA_UD_License", GetType(String))
    End Sub

    '** Generate the SET methods
    Public Sub setCompanyid(ByRef val$)
        If Len(val) = 0 Then
            MsgBox("SET: Field 'CustomerID' cannot be NULL.")
            Return
        End If
        val = DMA.RemoveSingleQuotes(val)
        CustomerID = val
    End Sub

    Public Sub setLicenseid(ByRef val$)
        If Len(val) = 0 Then
            MsgBox("SET: Field 'Licenseid' cannot be NULL.")
            Return
        End If
        val = DMA.RemoveSingleQuotes(val)
        LicenseID = val
    End Sub

    Public Sub setPurchasedmachines(ByRef val$)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = DMA.RemoveSingleQuotes(val)
        PurchasedMachines = val
    End Sub

    Public Sub setPurchasedusers(ByRef val$)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = DMA.RemoveSingleQuotes(val)
        PurchasedUsers = val
    End Sub

    Public Sub setSupportactive(ByRef val$)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = DMA.RemoveSingleQuotes(val)
        SupportActive = val
    End Sub

    Public Sub setSupportactivedate(ByRef val$)
        val = DMA.RemoveSingleQuotes(val)
        SupportActiveDate = val
    End Sub

    Public Sub setSupportinactivedate(ByRef val$)
        val = DMA.RemoveSingleQuotes(val)
        SupportInactiveDate = val
    End Sub

    Public Sub setLicensetext(ByRef val$)
        val = DMA.RemoveSingleQuotes(val)
        LicenseText = val
    End Sub

    Public Sub setLicensetypecode(ByRef val$)
        If Len(val) = 0 Then
            MsgBox("SET: Field 'Licensetypecode' cannot be NULL.")
            Return
        End If
        val = DMA.RemoveSingleQuotes(val)
        LicenseTypeCode = val
    End Sub

    Public Sub setMachineid(ByRef val$)
        val = DMA.RemoveSingleQuotes(val)
        MachineID = val
    End Sub

    Public Sub setApplied(ByRef val$)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = DMA.RemoveSingleQuotes(val)
        Applied = val
    End Sub

    Public Sub setEncryptedlicense(ByRef val$)
        val = DMA.RemoveSingleQuotes(val)
        EncryptedLicense = val
    End Sub

    Public Sub setInstalleddate(ByRef val$)
        val = DMA.RemoveSingleQuotes(val)
        InstalledDate = val
    End Sub

    Public Sub setLastupdate(ByRef val$)
        val = DMA.RemoveSingleQuotes(val)
        LastUpdate = val
    End Sub

    '** Generate the GET methods
    Public Function getCompanyid() As String
        If Len(CustomerID) = 0 Then
            MsgBox("GET: Field 'CustomerID' cannot be NULL.")
            Return ""
        End If
        Return DMA.RemoveSingleQuotes(CustomerID)
    End Function

    Public Function getLicenseid() As String
        If Len(LicenseID) = 0 Then
            MsgBox("GET: Field 'Licenseid' cannot be NULL.")
            Return ""
        End If
        Return DMA.RemoveSingleQuotes(LicenseID)
    End Function

    Public Function getPurchasedmachines() As String
        If Len(PurchasedMachines) = 0 Then
            PurchasedMachines = "null"
        End If
        Return PurchasedMachines
    End Function

    Public Function getPurchasedusers() As String
        If Len(PurchasedUsers) = 0 Then
            PurchasedUsers = "null"
        End If
        Return PurchasedUsers
    End Function

    Public Function getSupportactive() As String
        If Len(SupportActive) = 0 Then
            SupportActive = "null"
        End If
        Return SupportActive
    End Function

    Public Function getSupportactivedate() As String
        Return DMA.RemoveSingleQuotes(SupportActiveDate)
    End Function

    Public Function getSupportinactivedate() As String
        Return DMA.RemoveSingleQuotes(SupportInactiveDate)
    End Function

    Public Function getLicensetext() As String
        Return DMA.RemoveSingleQuotes(LicenseText)
    End Function

    Public Function getLicensetypecode() As String
        If Len(LicenseTypeCode) = 0 Then
            MsgBox("GET: Field 'Licensetypecode' cannot be NULL.")
            Return ""
        End If
        Return DMA.RemoveSingleQuotes(LicenseTypeCode)
    End Function

    Public Function getMachineid() As String
        Return DMA.RemoveSingleQuotes(MachineID)
    End Function

    Public Function getApplied() As String
        If Len(Applied) = 0 Then
            Applied = "null"
        End If
        Return Applied
    End Function

    Public Function getEncryptedlicense() As String
        Return DMA.RemoveSingleQuotes(EncryptedLicense)
    End Function

    Public Function getInstalleddate() As String
        Return DMA.RemoveSingleQuotes(InstalledDate)
    End Function

    Public Function getLastupdate() As String
        Return DMA.RemoveSingleQuotes(LastUpdate)
    End Function

    '** Generate the Required Fields Validation method
    Public Function ValidateReqData() As Boolean
        If CustomerID.Length = 0 Then Return False
        If LicenseID.Length = 0 Then Return False
        If LicenseTypeCode.Length = 0 Then Return False
        Return True
    End Function

    '** Generate the Validation method
    Public Function ValidateData() As Boolean
        If CustomerID.Length = 0 Then Return False
        If LicenseID.Length = 0 Then Return False
        If LicenseTypeCode.Length = 0 Then Return False
        Return True
    End Function

    '** Generate the INSERT method
    Public Function Insert(ServerLocation As String,
                           ByVal ServerName As String,
                           ByVal SqlInstanceName As String,
                           ByVal CustomerID As String,
                           ByVal CustomerName As String,
                           ByVal CompanyResetID As String,
                           ByVal MasterPW As String,
                           ByVal License As String,
                           ByVal LicenseExpireDate As String,
                           ByVal MaintExpireDate As String,
                           MachineID As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO [dbo].[License]
           ([CustomerName]
            ,[CustomerID]
            ,[LicenseExpireDate]
            ,[NbrSeats]
            ,[NbrSimlUsers]
            ,[CompanyResetID]
            ,[MasterPW]
            ,[LicenseGenDate]
            ,[License]
            ,LicenseType
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
            ,[Applied]
            ,[EncryptedLicense]
            ,[LastUpdate])
        values (" + vbCrLf
        s = s + "'" + dictVars("CustomerName") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("CustomerID") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("LicenseExpireDate") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("NbrSeats") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("NbrSimlUsers") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("CompanyResetID") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("MasterPW") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("LicenseGenDate") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("License") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("LicenseType") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("LicenseID") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("ContactName") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("ContactEmail") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("ContactPhoneNbr") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("CompanyStreetAddress") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("CompanyCity") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("CompanyState") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("CompanyZip") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("MaintExpireDate") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("CompanyCountry") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("MachineID") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("LicenseTypeCode") + "'" + "," + vbCrLf
        s = s + dictVars("ckSdk") + "," + vbCrLf
        s = s + dictVars("ckLease") + "," + vbCrLf
        s = s + "'" + dictVars("MaxClients") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("MaxSharePoint") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("ServerName") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("SqlInstanceName") + "'" + "," + vbCrLf
        s = s + dictVars("StorageAllotment") + "," + vbCrLf
        s = s + "'" + dictVars("Applied") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("EncryptedLicense") + "'" + "," + vbCrLf
        s = s + "'" + dictVars("LastUpdate") + "'" + ")" + vbCrLf

        Clipboard.Clear()
        Clipboard.SetText(s)

        Return ExecuteSql(s)


    End Function

    '** Generate the UPDATE method
    Public Function Update(ByVal WhereClause$, ByVal CustomerID As String, ByVal ServerName As String, ByVal SqlInstanceName As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then
            Return False
        End If

        s = s + " Update License set "
        s = s + "CustomerName = '" + dictVars("CustomerName") + "'," + vbCrLf
        s = s + "CustomerID = '" + dictVars("CustomerID") + "'," + vbCrLf
        s = s + "LicenseExpireDate = '" + dictVars("LicenseExpireDate") + "'," + vbCrLf
        s = s + "NbrSeats = " + dictVars("NbrSeats") + "," + vbCrLf
        s = s + "NbrSimlUsers = " + dictVars("NbrSimlUsers") + "," + vbCrLf
        s = s + "CompanyResetID = '" + dictVars("CompanyResetID") + "'," + vbCrLf
        s = s + "MasterPW = '" + dictVars("MasterPW") + "'," + vbCrLf
        s = s + "LicenseGenDate = '" + dictVars("LicenseGenDate") + "'," + vbCrLf
        s = s + "License = '" + dictVars("License") + "'," + vbCrLf
        s = s + "LicenseID = '" + dictVars("LicenseID") + "'," + vbCrLf
        s = s + "ContactName = '" + dictVars("ContactName") + "'," + vbCrLf
        s = s + "ContactEmail = '" + dictVars("ContactEmail") + "'," + vbCrLf
        s = s + "ContactPhoneNbr = '" + dictVars("ContactPhoneNbr") + "'," + vbCrLf
        s = s + "CompanyStreetAddress = '" + dictVars("CompanyStreetAddress") + "'," + vbCrLf
        s = s + "CompanyCity = '" + dictVars("CompanyCity") + "'," + vbCrLf
        s = s + "CompanyState = '" + dictVars("CompanyState") + "'," + vbCrLf
        s = s + "CompanyZip = '" + dictVars("CompanyZip") + "'," + vbCrLf
        s = s + "MaintExpireDate = '" + dictVars("MaintExpireDate") + "'," + vbCrLf
        s = s + "CompanyCountry = '" + dictVars("CompanyCountry") + "'," + vbCrLf
        s = s + "MachineID = '" + dictVars("MachineID") + "'," + vbCrLf
        s = s + "LicenseTypeCode = '" + dictVars("LicenseTypeCode") + "'," + vbCrLf
        s = s + "ckSdk = " + dictVars("ckSdk") + "," + vbCrLf
        s = s + "ckLease = " + dictVars("ckLease") + "," + vbCrLf
        s = s + "MaxClients = '" + dictVars("MaxClients") + "'," + vbCrLf
        s = s + "MaxSharePoint = '" + dictVars("MaxSharePoint") + "'," + vbCrLf
        s = s + "ServerName = '" + dictVars("ServerName") + "'," + vbCrLf
        s = s + "SqlInstanceName = '" + dictVars("SqlInstanceName") + "'," + vbCrLf
        s = s + "StorageAllotment = " + dictVars("StorageAllotment") + "," + vbCrLf
        's = s + "RecNbr = '" + dictVars("RecNbr") + "'," + vbCrLf
        s = s + "Applied = " + dictVars("Applied") + "," + vbCrLf
        s = s + "EncryptedLicense = '" + dictVars("EncryptedLicense") + "'," + vbCrLf
        s = s + "LastUpdate = '" + dictVars("LastUpdate") + "'," + vbCrLf
        s = s + "LicenseType = '" + dictVars("LicenseType") + "'," + vbCrLf
        WhereClause = " " + WhereClause
        s = s + WhereClause
        Return ExecuteSql(s)
    End Function

    Public Function UpdateLicense(ServerLocation As String, ByVal WhereClause As String, ByVal CustomerName As String, ByVal CustomerID As String, ByVal ServerName As String, ByVal SqlInstanceName As String,
                                  LicenseExpireDate As String, MaintExpireDate As String, MachineID As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " Update License set "

        s = s + "CustomerName = '" + CustomerName + "'," + vbCrLf

        s = s + "CustomerID = '" + CustomerID + "'," + vbCrLf
        s = s + "LicenseExpireDate = '" + dictVars("LicenseExpireDate") + "'," + vbCrLf
        s = s + "NbrSeats = " + dictVars("NbrSeats") + "," + vbCrLf
        s = s + "NbrSimlUsers = " + dictVars("NbrSimlUsers") + "," + vbCrLf
        s = s + "CompanyResetID = '" + dictVars("CompanyResetID") + "'," + vbCrLf
        s = s + "MasterPW = '" + dictVars("MasterPW") + "'," + vbCrLf
        s = s + "LicenseGenDate = '" + dictVars("LicenseGenDate") + "'," + vbCrLf
        s = s + "License = '" + dictVars("License") + "'," + vbCrLf
        s = s + "LicenseID = '" + dictVars("LicenseID") + "'," + vbCrLf
        s = s + "ContactName = '" + dictVars("ContactName") + "'," + vbCrLf
        s = s + "ContactEmail = '" + dictVars("ContactEmail") + "'," + vbCrLf
        s = s + "ContactPhoneNbr = '" + dictVars("ContactPhoneNbr") + "'," + vbCrLf
        s = s + "CompanyStreetAddress = '" + dictVars("CompanyStreetAddress") + "'," + vbCrLf
        s = s + "CompanyCity = '" + dictVars("CompanyCity") + "'," + vbCrLf
        s = s + "CompanyState = '" + dictVars("CompanyState") + "'," + vbCrLf
        s = s + "CompanyZip = '" + dictVars("CompanyZip") + "'," + vbCrLf
        s = s + "MaintExpireDate = '" + dictVars("MaintExpireDate") + "'," + vbCrLf
        s = s + "CompanyCountry = '" + dictVars("CompanyCountry") + "'," + vbCrLf
        s = s + "MachineID = '" + dictVars("MachineID") + "'," + vbCrLf
        s = s + "LicenseTypeCode = '" + dictVars("LicenseTypeCode") + "'," + vbCrLf
        s = s + "ckSdk = " + dictVars("ckSdk") + "," + vbCrLf
        s = s + "ckLease = " + dictVars("ckLease") + "," + vbCrLf
        s = s + "MaxClients = '" + dictVars("MaxClients") + "'," + vbCrLf
        s = s + "MaxSharePoint = '" + dictVars("MaxSharePoint") + "'," + vbCrLf
        s = s + "ServerName = '" + dictVars("ServerName") + "'," + vbCrLf
        s = s + "SqlInstanceName = '" + dictVars("SqlInstanceName") + "'," + vbCrLf
        s = s + "StorageAllotment = " + dictVars("StorageAllotment") + "," + vbCrLf
        's = s + "RecNbr = '" + dictVars("RecNbr") + "'," + vbCrLf
        s = s + "Applied = " + dictVars("Applied") + "," + vbCrLf
        s = s + "EncryptedLicense = '" + dictVars("EncryptedLicense") + "'," + vbCrLf
        s = s + "LastUpdate = '" + dictVars("LastUpdate") + "'," + vbCrLf
        s = s + "LicenseType = '" + dictVars("LicenseType") + "'" + vbCrLf
        s = s + WhereClause

        My.Computer.Clipboard.SetText(s)

        b = ExecuteSql(s)
        Return b

    End Function

    '** Generate the SELECT method
    Public Function SelectRecs() As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "CustomerID,"
        s = s + "LicenseID,"
        s = s + "PurchasedMachines,"
        s = s + "PurchasedUsers,"
        s = s + "SupportActive,"
        s = s + "SupportActiveDate,"
        s = s + "SupportInactiveDate,"
        s = s + "LicenseText,"
        s = s + "LicenseTypeCode,"
        s = s + "MachineID,"
        s = s + "Applied,"
        s = s + "EncryptedLicense,"
        s = s + "InstalledDate,"
        s = s + "LastUpdate "
        s = s + " FROM License"
        '** s=s+ "ORDERBY xxxx"
        rsData = SqlQry(s)
        Return rsData
    End Function

    '** Generate the Select One Row method
    Public Function SelectOne(ByVal WhereClause$) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "CustomerID,"
        s = s + "LicenseID,"
        s = s + "PurchasedMachines,"
        s = s + "PurchasedUsers,"
        s = s + "SupportActive,"
        s = s + "SupportActiveDate,"
        s = s + "SupportInactiveDate,"
        s = s + "LicenseText,"
        s = s + "LicenseTypeCode,"
        s = s + "MachineID,"
        s = s + "Applied,"
        s = s + "EncryptedLicense,"
        s = s + "InstalledDate,"
        s = s + "LastUpdate "
        s = s + " FROM License"
        s = s + WhereClause
        '** s=s+ "ORDERBY xxxx"
        rsData = SqlQry(s)
        Return rsData
    End Function

    '** Generate the DELETE method
    Public Function Delete(ByVal WhereClause$) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        WhereClause = " " + WhereClause

        s = " Delete from License"
        s = s + WhereClause

        b = ExecuteSql(s)
        Return b

    End Function

    '** Generate the Zeroize Table method
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from License"

        b = ExecuteSql(s)
        Return b

    End Function

    '** Generate Index Queries
    Public Function cnt_PK19(ByVal CustomerID As String, ByVal LicenseID As String) As Integer

        Dim B As Integer = 0
        Dim TBL As String = "License"
        Dim WC As String = "Where CustomerID = '" + CustomerID + "' and   LicenseID = '" + LicenseID + "'"

        B = iGetRowCount(TBL, WC)

        Return B
    End Function     '** cnt_PK19

    Public Function cnt_UI_CompanyMachine(ByVal CustomerID As String, ByVal MachineID As String) As Integer

        Dim B As Integer = 0
        Dim TBL$ = "License"
        Dim WC as string = "Where CustomerID = '" + CustomerID + "' and   MachineID = '" + MachineID + "'"

        B = iGetRowCount(TBL$, WC)

        Return B
    End Function     '** cnt_UI_CompanyMachine

    '** Generate Index ROW Queries
    Public Function getRow_PK19(ByVal CustomerID As String, ByVal LicenseID As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL$ = "License"
        Dim WC as string = "Where CustomerID = '" + CustomerID + "' and   LicenseID = '" + LicenseID + "'"

        rsData = GetRowByKey(TBL$, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK19

    Public Function getRow_UI_CompanyMachine(ByVal CustomerID As String, ByVal MachineID As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL$ = "License"
        Dim WC as string = "Where CustomerID = '" + CustomerID + "' and   MachineID = '" + MachineID + "'"

        rsData = GetRowByKey(TBL$, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_UI_CompanyMachine

    ''' Build Index Where Caluses
    Public Function wc_PK19(ByVal CustomerID As String, ByVal LicenseID As String) As String

        Dim WC As String = "Where CustomerID = '" + CustomerID + "' and   LicenseID = '" + LicenseID + "'"

        Return WC
    End Function     '** wc_PK19

    Public Function wc_UI_CompanyMachine(ByVal CustomerID As String, ByVal MachineID As String) As String

        Dim WC as string = "Where CustomerID = '" + CustomerID + "' and   MachineID = '" + MachineID + "'"

        Return WC
    End Function     '** wc_UI_CompanyMachine

    '** Generate the SET methods
    Public Function GetRowByKey(ByVal TBL$, ByVal WC As String) As SqlDataReader
        Try
            Dim Auth$ = ""
            Dim s As String = "select * from " + TBL + " " + WC
            Dim rsData As SqlDataReader = Nothing
            Dim b As Boolean = False
            rsData = SqlQry(s)
            If rsData.HasRows Then
                rsData.Read()
                Auth = rsData.GetValue(0).ToString
                Return rsData
            Else
                Return Nothing
            End If
        Catch ex As Exception
            Debug.Print(ex.Message)
            Return Nothing
        End Try

    End Function

    Public Function SqlQry(ByVal sql As String) As SqlDataReader
        ''Session("ActiveError") = False
        Dim dDebug As Boolean = False
        Dim queryString As String = sql
        Dim rc As Boolean = False
        Dim rsDataQry As SqlDataReader = Nothing

        CkConn()

        'If gConn.State = Data.ConnectionState.Open Then
        '    gConn.Close()
        'End If

        'CkConn()

        Dim command As New SqlCommand(sql, gConn)

        Try
            rsDataQry = command.ExecuteReader()
        Catch ex As Exception
            MessageBox.Show(ex.Message)

            ''Session("ActiveError") = True
            ''Session("ErrMsg") = ex.Message
            ''Session("ErrStack") = ex.StackTrace + vbCrLf + vbCrLf + sql
            DB.xTrace(1001, "clsDataBase:SqlQry", ex.Message)
            DB.xTrace(1002, "clsDataBase:SqlQry", ex.StackTrace)
            DB.xTrace(1003, "clsDataBase:SqlQry", sql)
        End Try

        If dDebug Then DB.WriteToLog("SQLQRY Ended: " + Now)
        If dDebug Then Console.WriteLine("SQLQRY Ended: " + Now)
        command.Dispose()
        command = Nothing

        Return rsDataQry
    End Function

    Public Sub CkConn()

        If Not gConn Is Nothing Then
            gConn = Nothing
        End If
        If gConn Is Nothing Then
            Try
                gConn = New SqlConnection
                gConn.ConnectionString = getConnStr()
                gConn.Open()
            Catch ex As Exception
                Console.WriteLine("Error 121.21")
                Console.WriteLine(ex.Source)
                Console.WriteLine(ex.StackTrace)
                Console.WriteLine(ex.Message)
            End Try
        End If
        If gConn.State = Data.ConnectionState.Closed Then
            Try
                gConn.ConnectionString = getConnStr()
                gConn.Open()
            Catch ex As Exception
                Console.WriteLine("Error 121.21")
                Console.WriteLine(ex.Source)
                Console.WriteLine(ex.StackTrace)
                Console.WriteLine(ex.Message)
            End Try
        End If
    End Sub

    Public Function getConnStr() As String
        setConnStr()
        'End If
        Return gConnStr
    End Function

    Public Sub setConnStr()
        Dim S = ""
        Dim reader As New System.Configuration.AppSettingsReader
        If gCurrServerType.Equals("local") Then
            S = reader.GetValue("DMA_UD_License", GetType(String))
        ElseIf gCurrServerType.Equals("remote") Then
            S = reader.GetValue("LicenseServer", GetType(String))
        Else
            S = reader.GetValue("DMA_UD_License", GetType(String))
        End If

            gConnStr = S
    End Sub

    Public Sub setRemoteConnStr()
        Dim S = ""
        Dim reader As New System.Configuration.AppSettingsReader
        S = reader.GetValue("LicenseServer", GetType(String))
        gRemoteConnStr = S
    End Sub
    Public Function getRemoteConnStr() As String
        setRemoteConnStr()
        'End If
        Return gConnStr
    End Function

    Public Function ExecuteSql(ByVal sql As String) As Boolean

        Dim rc As Boolean = False
        CkConn()
        Using gConn
            Dim dbCmd As SqlCommand = gConn.CreateCommand()
            ' Must assign both transaction object and connection to dbCmd object for a pending local transaction.
            dbCmd.Connection = gConn
            Try
                dbCmd.CommandText = sql
                dbCmd.ExecuteNonQuery()
                rc = True
            Catch ex As Exception
                rc = False
                If InStr(ex.Message, "The DELETE statement conflicted with the REFERENCE", CompareMethod.Text) > 0 Then
                    MsgBox("It appears this user has DATA within the repository associated with them and cannot be deleted." + vbCrLf + vbCrLf + ex.Message)
                ElseIf InStr(ex.Message, "duplicate key row", CompareMethod.Text) > 0 Then
                    Return False
                Else
                    'MsgBox("Execute SQL: " + ex.Message + vbCrLf + "Please review the trace log." + vbCrLf + sql)
                    Clipboard.SetText(sql)
                End If
                DB.xTrace(39901, "ExecuteSqlNoTx: ", ex.Message.ToString)
                DB.xTrace(39901, "ExecuteSqlNoTx: ", Mid(sql, 1, 2000))
            End Try
        End Using

        Return rc
    End Function


    Public Function iGetRowCount(ByVal TBL As String, ByVal WhereClause As String) As Integer

        Dim cnt As Integer = -1

        Try
            Dim tQuery As String = ""
            Dim s As String = ""

            s = "select count(*) as CNT from " + TBL + " " + WhereClause
            CkConn()

            Using gConn
                'Dim command As New SqlCommand(s, gConn)
                Dim rsCnt As SqlDataReader = Nothing
                rsCnt = SqlQry(s)
                If (rsCnt.HasRows) Then
                    rsCnt.Read()
                    cnt = rsCnt.GetInt32(0)
                End If
                rsCnt.Close()
                rsCnt = Nothing
                'command.Connection.Close()
                GC.Collect()
                GC.WaitForFullGCApproach()
            End Using
        Catch ex As Exception
            MsgBox("Error 3932.11a: " + ex.Message)
            Debug.Print("Error 3932.11b: " + ex.Message)
            cnt = 1
        End Try

        Return cnt

    End Function

    Sub PopulateRemoteGrid(ByRef DG As DataGridView, ByVal tSql As String)

        Try
            CkConn()

            If gConn.State = Data.ConnectionState.Open Then
                    gConn.Close()
                End If

                Dim CS = getConnStr()

                Dim sqlcn As New SqlConnection(CS)
                Dim sadapt As New SqlDataAdapter(tSql, gConn)
                Dim ds As DataSet = New DataSet

                If sqlcn.State = ConnectionState.Closed Then
                    sqlcn.Open()
                End If

                sadapt.Fill(ds, "DataSource")
                Console.WriteLine("Total Licenses = " & ds.Tables("DataSource").Rows.Count.ToString)

                DG.DataSource = Nothing
                DG.DataSource = ds.Tables("DataSource")

                Console.WriteLine("DG Licenses = " & DG.Rows.Count.ToString)
        Catch ex As Exception
            MsgBox("PopulateRemoteGrid Error 100: " + ex.Message)
        End Try

    End Sub

End Class
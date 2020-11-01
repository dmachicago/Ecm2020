Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsRemoteLICENSE
    Dim gConnStr$ = ""
    Dim gConn As SqlConnection

    '** DIM the selected table columns 
    Dim DB As New clsDatabase
    Dim DMA As New clsDma
    'DIM DG as new clsDataGrid

    Dim CompanyID As String = ""
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

    Dim RemoteConnectionString$ = ""

    Sub New()
        RemoteConnectionString$ = System.Configuration.ConfigurationManager.AppSettings("LicenseServer").ToString
    End Sub
    '** Generate the SET methods 
    Public Sub setCompanyid(ByRef val$)
        If Len(val) = 0 Then
            MsgBox("SET: Field 'Companyid' cannot be NULL.")
            Return
        End If
        val = DMA.RemoveSingleQuotes(val)
        CompanyID = val
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
        If Len(CompanyID) = 0 Then
            MsgBox("GET: Field 'Companyid' cannot be NULL.")
            Return ""
        End If
        Return DMA.RemoveSingleQuotes(CompanyID)
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
        If CompanyID.Length = 0 Then Return False
        If LicenseID.Length = 0 Then Return False
        If LicenseTypeCode.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If CompanyID.Length = 0 Then Return False
        If LicenseID.Length = 0 Then Return False
        If LicenseTypeCode.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the INSERT method 
    Public Function Insert(ByVal ServerName As String, ByVal SqlInstanceName As String, ByVal CustomerID As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO License(" + vbCrLf
        s = s + "CompanyID," + vbCrLf
        s = s + "LicenseID," + vbCrLf
        's = s + "PurchasedMachines,"
        's = s + "PurchasedUsers,"
        's = s + "SupportActive,"
        's = s + "SupportActiveDate,"
        's = s + "SupportInactiveDate,"
        's = s + "LicenseText,"
        s = s + "LicenseTypeCode," + vbCrLf
        s = s + "MachineID," + vbCrLf
        s = s + "Applied," + vbCrLf
        s = s + "EncryptedLicense," + vbCrLf
        s = s + "InstalledDate," + vbCrLf
        s = s + "LastUpdate," + vbCrLf
        s = s + "CustomerID," + vbCrLf
        s = s + "ServerName," + vbCrLf
        s = s + "SqlInstanceName) values (" + vbCrLf
        s = s + "'" + CompanyID + "'" + "," + vbCrLf
        s = s + "'" + LicenseID + "'" + "," + vbCrLf
        's = s + PurchasedMachines + ","
        's = s + PurchasedUsers + ","
        's = s + SupportActive + ","
        's = s + "'" + SupportActiveDate + "'" + ","
        's = s + "'" + SupportInactiveDate + "'" + ","
        's = s + "'" + LicenseText + "'" + ","
        s = s + "'" + LicenseTypeCode + "'" + "," + vbCrLf
        s = s + "'" + MachineID + "'" + "," + vbCrLf
        s = s + "0" + "," + vbCrLf
        s = s + "'" + EncryptedLicense + "'" + "," + vbCrLf
        s = s + " getdate() " + "," + vbCrLf
        s = s + "'" + Now.ToString + "'" + "," + vbCrLf
        s = s + "'" + CustomerID + "'" + "," + vbCrLf
        s = s + "'" + ServerName + "'" + "," + vbCrLf
        s = s + "'" + SqlInstanceName + "'" + ")"
        Return ExecuteSql(s)

    End Function

    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause$, ByVal CustomerID As String, ByVal ServerName As String, ByVal SqlInstanceName As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update License set "
        s = s + "CompanyID = '" + getCompanyid() + "'" + ", "
        s = s + "LicenseID = '" + getLicenseid() + "'" + ", "
        s = s + "PurchasedMachines = " + getPurchasedmachines() + ", "
        s = s + "PurchasedUsers = " + getPurchasedusers() + ", "
        s = s + "SupportActive = " + getSupportactive() + ", "
        s = s + "SupportActiveDate = '" + getSupportactivedate() + "'" + ", "
        s = s + "SupportInactiveDate = '" + getSupportinactivedate() + "'" + ", "
        s = s + "LicenseText = '" + getLicensetext() + "'" + ", "
        s = s + "LicenseTypeCode = '" + getLicensetypecode() + "'" + ", "
        s = s + "MachineID = '" + getMachineid() + "'" + ", "
        s = s + "Applied = " + getApplied() + ", "
        s = s + "EncryptedLicense = '" + getEncryptedlicense() + "'" + ", "
        s = s + "InstalledDate = '" + getInstalleddate() + "'" + ", "
        s = s + "LastUpdate = '" + getLastupdate() + "',"
        s = s + "CustomerID = '" + CustomerID + "',"
        s = s + "ServerName = '" + ServerName + "',"
        s = s + "SqlInstanceName = '" + SqlInstanceName + "'"
        WhereClause = " " + WhereClause
        s = s + WhereClause
        Return ExecuteSql(s)
    End Function
    Public Function UpdateLicense(ByVal WhereClause$, ByVal CustomerID As String, ByVal ServerName As String, ByVal SqlInstanceName As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update License set "
        's = s + "CompanyID = '" + getCompanyid() + "'" + ", "
        's = s + "LicenseID = '" + getLicenseid() + "'" + ", "
        's = s + "PurchasedMachines = " + getPurchasedmachines() + ", "
        's = s + "PurchasedUsers = " + getPurchasedusers() + ", "
        's = s + "SupportActive = " + getSupportactive() + ", "
        's = s + "SupportActiveDate = '" + getSupportactivedate() + "'" + ", "
        's = s + "SupportInactiveDate = '" + getSupportinactivedate() + "'" + ", "
        's = s + "LicenseText = null " + ", "
        s = s + "LicenseTypeCode = '" + LicenseTypeCode + "', "
        's = s + "MachineID = '" + getMachineid() + "'" + ", "
        s = s + "Applied = 0, "
        s = s + "EncryptedLicense = '" + getEncryptedlicense() + "'" + ", "
        's = s + "InstalledDate = '" + getInstalleddate() + "'" + ", "
        s = s + "LastUpdate = '" + Now.ToString + "',"
        s = s + "CustomerID = '" + CustomerID + "',"
        s = s + "ServerName = '" + ServerName + "',"
        s = s + "SqlInstanceName = '" + SqlInstanceName + "'"
        WhereClause = " " + WhereClause
        s = s + WhereClause
        Return ExecuteSql(s)
    End Function

    '** Generate the SELECT method 
    Public Function SelectRecs() As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "CompanyID,"
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
        s = s + "CompanyID,"
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
    Public Function cnt_PK19(ByVal CompanyID As String, ByVal LicenseID As String) As Integer

        Dim B As Integer = 0
        Dim TBL$ = "License"
        Dim WC$ = "Where CompanyID = '" + CompanyID + "' and   LicenseID = '" + LicenseID + "'"

        B = iGetRowCount(TBL$, WC)

        Return B
    End Function     '** cnt_PK19
    Public Function cnt_UI_CompanyMachine(ByVal CompanyID As String, ByVal MachineID As String) As Integer

        Dim B As Integer = 0
        Dim TBL$ = "License"
        Dim WC$ = "Where CompanyID = '" + CompanyID + "' and   MachineID = '" + MachineID + "'"

        B = iGetRowCount(TBL$, WC)

        Return B
    End Function     '** cnt_UI_CompanyMachine

    '** Generate Index ROW Queries 
    Public Function getRow_PK19(ByVal CompanyID As String, ByVal LicenseID As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL$ = "License"
        Dim WC$ = "Where CompanyID = '" + CompanyID + "' and   LicenseID = '" + LicenseID + "'"

        rsData = GetRowByKey(TBL$, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK19
    Public Function getRow_UI_CompanyMachine(ByVal CompanyID As String, ByVal MachineID As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL$ = "License"
        Dim WC$ = "Where CompanyID = '" + CompanyID + "' and   MachineID = '" + MachineID + "'"

        rsData = GetRowByKey(TBL$, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_UI_CompanyMachine

    ''' Build Index Where Caluses 
    '''
    Public Function wc_PK19(ByVal CompanyID As String, ByVal LicenseID As String) As String

        Dim WC$ = "Where CompanyID = '" + CompanyID + "' and   LicenseID = '" + LicenseID + "'"

        Return WC
    End Function     '** wc_PK19
    Public Function wc_UI_CompanyMachine(ByVal CompanyID As String, ByVal MachineID As String) As String

        Dim WC$ = "Where CompanyID = '" + CompanyID + "' and   MachineID = '" + MachineID + "'"

        Return WC
    End Function     '** wc_UI_CompanyMachine

    '** Generate the SET methods 
    Public Function GetRowByKey(ByVal TBL$, ByVal WC$) As SqlDataReader
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

        If gConn.State = Data.ConnectionState.Open Then
            gConn.Close()
        End If

        CkConn()

        Dim command As New SqlCommand(sql, gConn)

        Try
            rsDataQry = command.ExecuteReader()
        Catch ex As Exception
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
        'If gConnStr = "" Then
        setConnStr()
        'End If
        Return gConnStr
    End Function
    Public Sub setConnStr()
        Dim S$ = ""
        S$ = System.Configuration.ConfigurationManager.AppSettings("LicenseServer").ToString
        gConnStr = S
    End Sub
    Public Function ExecuteSql(ByVal sql As String) As Boolean

        Dim rc As Boolean = False
        CkConn()
        Using gConn
            Dim dbCmd As SqlCommand = gConn.CreateCommand()
            ' Must assign both transaction object and connection
            ' to dbCmd object for a pending local transaction.
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
    Public Function iGetRowCount(ByVal TBL$, ByVal WhereClause$) As Integer

        Dim cnt As Integer = -1

        Try
            Dim tQuery As String = ""
            Dim s As String = ""

            s = "select count(*) as CNT from " + TBL + " " + WhereClause

            Using gConn
                'Dim command As New SqlCommand(s, gConn)
                Dim rsCnt As SqlDataReader = Nothing
                rsCnt = SqlQry(s)
                rsCnt.Read()
                cnt = rsCnt.GetInt32(0)
                rsCnt.Close()
                rsCnt = Nothing
                'command.Connection.Close()
                GC.Collect()
                GC.WaitForFullGCApproach()
            End Using
        Catch ex As Exception
            MsgBox("Error 3932.11: " + ex.Message)
            Debug.Print("Error 3932.11: " + ex.Message)
            cnt = 1
        End Try


        Return cnt

    End Function

    Sub PopulateRemoteGrid(ByRef DG As DataGridView, ByVal tSql$)

        Try

            CkConn()

            If gConn.State = Data.ConnectionState.Open Then
                gConn.Close()
            End If

            Dim CS$ = getConnStr()

            Dim sqlcn As New SqlConnection(CS)
            Dim sadapt As New SqlDataAdapter(tSql$, gConn)
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

Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsLICENSE

    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim DG As New clsDataGrid

    Dim Agreement As String = ""
    Dim VersionNbr As String = ""
    Dim ActivationDate As String = ""
    Dim InstallDate As String = ""
    Dim CustomerID As String = ""
    Dim CustomerName As String = ""
    Dim LicenseID As String = ""
    Dim XrtNxr1 As String = ""
    Dim SqlServerInstanceNameX As String = ""
    Dim SqlServerMachineName As String = ""


    '** Generate the SET methods 
    Public Sub setAgreement(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Agreement' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        Agreement = val
    End Sub

    Public Sub setVersionnbr(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Versionnbr' cannot be NULL.")
            Return
        End If
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        VersionNbr = val
    End Sub

    Public Sub setActivationdate(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Activationdate' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        ActivationDate = val
    End Sub

    Public Sub setInstalldate(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Installdate' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        InstallDate = val
    End Sub

    Public Sub setCustomerid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Customerid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        CustomerID = val
    End Sub

    Public Sub setCustomername(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Customername' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        CustomerName = val
    End Sub

    Public Sub setXrtnxr1(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        XrtNxr1 = val
    End Sub

    Public Sub setServeridentifier(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        SqlServerInstanceNameX = val
    End Sub

    Public Sub setSqlinstanceidentifier(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        SqlServerMachineName = val
    End Sub



    '** Generate the GET methods 
    Public Function getAgreement() As String
        If Len(Agreement) = 0 Then
            MessageBox.Show("GET: Field 'Agreement' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(Agreement)
    End Function

    Public Function getVersionnbr() As String
        If Len(VersionNbr) = 0 Then
            MessageBox.Show("GET: Field 'Versionnbr' cannot be NULL.")
            Return ""
        End If
        If Len(VersionNbr) = 0 Then
            VersionNbr = "null"
        End If
        Return VersionNbr
    End Function

    Public Function getActivationdate() As String
        If Len(ActivationDate) = 0 Then
            MessageBox.Show("GET: Field 'Activationdate' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(ActivationDate)
    End Function

    Public Function getInstalldate() As String
        If Len(InstallDate) = 0 Then
            MessageBox.Show("GET: Field 'Installdate' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(InstallDate)
    End Function

    Public Function getCustomerid() As String
        If Len(CustomerID) = 0 Then
            MessageBox.Show("GET: Field 'Customerid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(CustomerID)
    End Function

    Public Function getCustomername() As String
        If Len(CustomerName) = 0 Then
            MessageBox.Show("GET: Field 'Customername' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(CustomerName)
    End Function

    Public Function getLicenseid() As String
        If Len(LicenseID) = 0 Then
            MessageBox.Show("GET: Field 'Licenseid' cannot be NULL.")
            Return ""
        End If
        If Len(LicenseID) = 0 Then
            LicenseID = "null"
        End If
        Return LicenseID
    End Function

    Public Function getXrtnxr1() As String
        Return UTIL.RemoveSingleQuotes(XrtNxr1)
    End Function

    Public Function getServeridentifier() As String
        Return UTIL.RemoveSingleQuotes(SqlServerInstanceNameX)
    End Function

    Public Function getSqlinstanceidentifier() As String
        Return UTIL.RemoveSingleQuotes(SqlServerMachineName)
    End Function



    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If Agreement.Length = 0 Then Return False
        If VersionNbr.Length = 0 Then Return False
        If ActivationDate.Length = 0 Then Return False
        If InstallDate.Length = 0 Then Return False
        If CustomerID.Length = 0 Then Return False
        If CustomerName.Length = 0 Then Return False
        If LicenseID.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If Agreement.Length = 0 Then Return False
        If VersionNbr.Length = 0 Then Return False
        If ActivationDate.Length = 0 Then Return False
        If InstallDate.Length = 0 Then Return False
        If CustomerID.Length = 0 Then Return False
        If CustomerName.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO License(" + Environment.NewLine
        s = s + "Agreement," + Environment.NewLine
        s = s + "VersionNbr," + Environment.NewLine
        s = s + "ActivationDate," + Environment.NewLine
        s = s + "InstallDate," + Environment.NewLine
        s = s + "CustomerID," + Environment.NewLine
        s = s + "CustomerName," + Environment.NewLine
        s = s + "XrtNxr1," + Environment.NewLine
        s = s + "SqlServerInstanceName," + Environment.NewLine
        s = s + "SqlServerMachineName) values (" + Environment.NewLine
        s = s + "'" + Agreement + "'" + "," + Environment.NewLine
        s = s + VersionNbr + "," + Environment.NewLine
        s = s + "'" + ActivationDate + "'" + "," + Environment.NewLine
        s = s + "'" + InstallDate + "'" + "," + Environment.NewLine
        s = s + "'" + CustomerID + "'" + "," + Environment.NewLine
        s = s + "'" + CustomerName + "'" + "," + Environment.NewLine
        s = s + "'" + XrtNxr1 + "'" + "," + Environment.NewLine
        s = s + "'" + SqlServerInstanceNameX + "'" + "," + Environment.NewLine
        s = s + "'" + SqlServerMachineName + "'" + ")"
        Return DBARCH.ExecuteSqlNewConn(s, False)

    End Function


    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update License set "
        s = s + "Agreement = '" + getAgreement() + "'" + ", "
        s = s + "VersionNbr = " + getVersionnbr() + ", "
        s = s + "ActivationDate = '" + getActivationdate() + "'" + ", "
        s = s + "InstallDate = '" + getInstalldate() + "'" + ", "
        s = s + "CustomerID = '" + getCustomerid() + "'" + ", "
        s = s + "CustomerName = '" + getCustomername() + "'" + ", "
        s = s + "XrtNxr1 = '" + getXrtnxr1() + "'" + ", "
        s = s + "SqlServerInstanceNameX = '" + getServeridentifier() + "'" + ", "
        s = s + "SqlServerMachineName = '" + getSqlinstanceidentifier() + "'"
        WhereClause = " " + WhereClause
        s = s + WhereClause
        Return DBARCH.ExecuteSqlNewConn(s, False)
    End Function


    '** Generate the SELECT method 
    Public Function SelectRecs() As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "Agreement,"
        s = s + "VersionNbr,"
        s = s + "ActivationDate,"
        s = s + "InstallDate,"
        s = s + "CustomerID,"
        s = s + "CustomerName,"
        s = s + "LicenseID,"
        s = s + "XrtNxr1,"
        s = s + "SqlServerInstanceNameX,"
        s = s + "SqlServerMachineName "
        s = s + " FROM License"
        '** s=s+ "ORDERBY xxxx"
        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function


    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "Agreement,"
        s = s + "VersionNbr,"
        s = s + "ActivationDate,"
        s = s + "InstallDate,"
        s = s + "CustomerID,"
        s = s + "CustomerName,"
        s = s + "LicenseID,"
        s = s + "XrtNxr1,"
        s = s + "SqlServerInstanceNameX,"
        s = s + "SqlServerMachineName "
        s = s + " FROM License"
        s = s + WhereClause
        '** s=s+ "ORDERBY xxxx"
        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function


    '** Generate the DELETE method 
    Public Function Delete(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        WhereClause = " " + WhereClause

        s = " Delete from License"
        s = s + WhereClause

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from License"

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate Index Queries 
    Public Function cnt_PK_License(ByVal LicenseID As String) As Integer

        Dim B As Integer = 0
        Dim TBL As String = "License"
        Dim WC As String = "Where LicenseID = " & LicenseID

        B = DBARCH.iGetRowCount(TBL, WC)

        Return B
    End Function     '** cnt_PK_License

    '** Generate Index ROW Queries 
    Public Function getRow_PK_License(ByVal LicenseID As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "License"
        Dim WC As String = "Where LicenseID = " & LicenseID

        rsData = DBARCH.GetRowByKey(TBL, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK_License

    ''' Build Index Where Caluses 
    '''
    Public Function wc_PK_License(ByVal LicenseID AS String ) As String

Dim WC AS String  = "Where LicenseID = " & LicenseID 

        Return WC
    End Function     '** wc_PK_License

    '** Generate the SET methods 

End Class

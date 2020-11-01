Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsEXCHANGEHOSTSMTP

    '** DIM the selected table columns 

    Dim ConnStr As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID)

    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma

    Dim LOG As New clsLogging
    Dim UTIL As New clsUtility

    Dim DG As New clsDataGrid

    Dim HostNameIp As String = ""
    Dim UserLoginID As String = ""
    Dim LoginPw As String = ""
    Dim DisplayName As String = ""


    '** Generate the SET methods 
    Public Sub setHostnameip(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Hostnameip' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        HostNameIp = val
    End Sub

    Public Sub setUserloginid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Userloginid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        UserLoginID = val
    End Sub

    Public Sub setLoginpw(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Loginpw' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        LoginPw = val
    End Sub

    Public Sub setDisplayname(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Displayname' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        DisplayName = val
    End Sub



    '** Generate the GET methods 
    Public Function getHostnameip() As String
        If Len(HostNameIp) = 0 Then
            MessageBox.Show("GET: Field 'Hostnameip' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(HostNameIp)
    End Function

    Public Function getUserloginid() As String
        If Len(UserLoginID) = 0 Then
            MessageBox.Show("GET: Field 'Userloginid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(UserLoginID)
    End Function

    Public Function getLoginpw() As String
        If Len(LoginPw) = 0 Then
            MessageBox.Show("GET: Field 'Loginpw' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(LoginPw)
    End Function

    Public Function getDisplayname() As String
        If Len(DisplayName) = 0 Then
            MessageBox.Show("GET: Field 'Displayname' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(DisplayName)
    End Function



    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If HostNameIp.Length = 0 Then Return False
        If UserLoginID.Length = 0 Then Return False
        If LoginPw.Length = 0 Then Return False
        If DisplayName.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If HostNameIp.Length = 0 Then Return False
        If UserLoginID.Length = 0 Then Return False
        If LoginPw.Length = 0 Then Return False
        If DisplayName.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO ExchangeHostSmtp("
        s = s + "HostNameIp,"
        s = s + "UserLoginID,"
        s = s + "LoginPw,"
        s = s + "DisplayName) values ("
        s = s + "'" + HostNameIp + "'" + ","
        s = s + "'" + UserLoginID + "'" + ","
        s = s + "'" + LoginPw + "'" + ","
        s = s + "'" + DisplayName + "'" + ")"
        Return DBARCH.ExecuteSql(s, ConnStr, False)

    End Function


    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update ExchangeHostSmtp set "
        s = s + "HostNameIp = '" + getHostnameip() + "'" + ", "
        s = s + "UserLoginID = '" + getUserloginid() + "'" + ", "
        s = s + "LoginPw = '" + getLoginpw() + "'" + ", "
        s = s + "DisplayName = '" + getDisplayname() + "'"
        WhereClause = " " + WhereClause
        s = s + WhereClause
        Return DBARCH.ExecuteSql(s, ConnStr, False)
    End Function


    '** Generate the SELECT method 
    Public Function SelectRecs() As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "HostNameIp,"
        s = s + "UserLoginID,"
        s = s + "LoginPw,"
        s = s + "DisplayName "
        s = s + " FROM ExchangeHostSmtp"
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
        s = s + "HostNameIp,"
        s = s + "UserLoginID,"
        s = s + "LoginPw,"
        s = s + "DisplayName "
        s = s + " FROM ExchangeHostSmtp"
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

        s = " Delete from ExchangeHostSmtp"
        s = s + WhereClause

        b = DBARCH.ExecuteSql(s, ConnStr, False)
        Return b

    End Function


    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from ExchangeHostSmtp"

        b = DBARCH.ExecuteSql(s, ConnStr, False)
        Return b

    End Function


    '** Generate Index Queries 
    Public Function cnt_PK_ExchangeHostSmtp(ByVal HostNameIp As String, ByVal UserLoginID As String) As Integer

        Dim B As Integer = 0
        Dim TBL As String = "ExchangeHostSmtp"
        Dim WC As String = "Where HostNameIp = '" + HostNameIp + "' and   UserLoginID = '" + UserLoginID + "'"

        B = DBARCH.iGetRowCount(TBL, WC)

        Return B
    End Function     '** cnt_PK_ExchangeHostSmtp

    '** Generate Index ROW Queries 
    Public Function getRow_PK_ExchangeHostSmtp(ByVal HostNameIp As String, ByVal UserLoginID As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "ExchangeHostSmtp"
        Dim WC As String = "Where HostNameIp = '" + HostNameIp + "' and   UserLoginID = '" + UserLoginID + "'"

        rsData = DBARCH.GetRowByKey(TBL, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK_ExchangeHostSmtp

    ''' Build Index Where Caluses 
    '''
    Public Function wc_PK_ExchangeHostSmtp(ByVal HostNameIp As String, ByVal UserLoginID As String) As String

Dim WC AS String  = "Where HostNameIp = '" + HostNameIp + "' and   UserLoginID = '" + UserLoginID + "'" 

        Return WC
    End Function     '** wc_PK_ExchangeHostSmtp

    '** Generate the SET methods 

End Class

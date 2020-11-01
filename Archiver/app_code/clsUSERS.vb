Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql


Public Class clsUSERS


    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging



    Dim UserID As String = ""
    Dim UserName As String = ""
    Dim EmailAddress As String = ""
    Dim UserPassword As String = ""
    Dim Admin As String = ""
    Dim isActive As String = ""
    Dim UserLoginID As String = ""




    '** Generate the SET methods 
    Public Sub setUserid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        UserID = val
    End Sub


    Public Sub setUsername(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Username' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        UserName = val
    End Sub


    Public Sub setEmailaddress(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        EmailAddress = val
    End Sub


    Public Sub setUserpassword(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        UserPassword = val
    End Sub


    Public Sub setAdmin(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Admin = val
    End Sub


    Public Sub setIsactive(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        isActive = val
    End Sub


    Public Sub setUserloginid(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        UserLoginID = val
    End Sub






    '** Generate the GET methods 
    Public Function getUserid() As String
        If Len(UserID) = 0 Then
            MessageBox.Show("GET: Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(UserID)
    End Function


    Public Function getUsername() As String
        If Len(UserName) = 0 Then
            MessageBox.Show("GET: Field 'Username' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(UserName)
    End Function


    Public Function getEmailaddress() As String
        Return UTIL.RemoveSingleQuotes(EmailAddress)
    End Function


    Public Function getUserpassword() As String
        Return UTIL.RemoveSingleQuotes(UserPassword)
    End Function


    Public Function getAdmin() As String
        Return UTIL.RemoveSingleQuotes(Admin)
    End Function


    Public Function getIsactive() As String
        Return UTIL.RemoveSingleQuotes(isActive)
    End Function


    Public Function getUserloginid() As String
        Return UTIL.RemoveSingleQuotes(UserLoginID)
    End Function






    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If UserID.Length = 0 Then Return False
        If UserName.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If UserID.Length = 0 Then Return False
        If UserName.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO Users("
        s = s + "UserID,"
        s = s + "UserName,"
        s = s + "EmailAddress,"
        s = s + "UserPassword,"
        s = s + "Admin,"
        s = s + "isActive,"
        s = s + "UserLoginID) values ("
        s = s + "'" + UserID + "'" + ","
        s = s + "'" + UserName + "'" + ","
        s = s + "'" + EmailAddress + "'" + ","
        s = s + "'" + UserPassword + "'" + ","
        s = s + "'" + Admin + "'" + ","
        s = s + "'" + isActive + "'" + ","
        s = s + "'" + UserLoginID + "'" + ")"
        Return DBARCH.ExecuteSqlNewConn(s, False)


    End Function




    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        s = s + " update Users set "
        s = s + "UserID = '" + getUserid() + "'" + ", "
        s = s + "UserName = '" + getUsername() + "'" + ", "
        s = s + "EmailAddress = '" + getEmailaddress() + "'" + ", "
        s = s + "UserPassword = '" + getUserpassword() + "'" + ", "
        s = s + "Admin = '" + getAdmin() + "'" + ", "
        s = s + "isActive = '" + getIsactive() + "'" + ", "
        s = s + "UserLoginID = '" + getUserloginid() + "'"
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
        s = s + "UserID,"
        s = s + "UserName,"
        s = s + "EmailAddress,"
        s = s + "UserPassword,"
        s = s + "Admin,"
        s = s + "isActive,"
        s = s + "UserLoginID "
        s = s + " FROM Users"

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function




    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "UserID,"
        s = s + "UserName,"
        s = s + "EmailAddress,"
        s = s + "UserPassword,"
        s = s + "Admin,"
        s = s + "isActive,"
        s = s + "UserLoginID "
        s = s + " FROM Users"
        s = s + WhereClause

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function




    '** Generate the DELETE method 
    Public Function Delete(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        WhereClause = " " + WhereClause


        s = " Delete from Users"
        s = s + WhereClause


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        s = s + " Delete from Users"


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate Index Queries 
    Public Function cnt_PK41(ByVal UserID As String) As Integer


        Dim B As Integer = 0
        Dim TBL As String = "Users"
        Dim WC As String = "Where UserID = '" + UserID + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_PK41
    Public Function cnt_UK_LoginID(ByVal UserLoginID As String) As Integer


        Dim B As Integer = 0
        Dim TBL As String = "Users"
        Dim WC As String = "Where UserLoginID = '" + UserLoginID + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_UK_LoginID


    '** Generate Index ROW Queries 
    Public Function getRow_PK41(ByVal UserID As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "Users"
        Dim WC As String = "Where UserID = '" + UserID + "'"


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK41
    Public Function getRow_UK_LoginID(ByVal UserLoginID As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "Users"
        Dim WC As String = "Where UserLoginID = '" + UserLoginID + "'"


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_UK_LoginID


    ''' Build Index Where Caluses 
    '''
    Public Function wc_PK41(ByVal UserID As String) As String


Dim WC AS String  = "Where UserID = '" + UserID + "'" 


        Return WC
    End Function     '** wc_PK41
    Public Function wc_UK_LoginID(ByVal UserLoginID As String) As String


Dim WC AS String  = "Where UserLoginID = '" + UserLoginID + "'" 


        Return WC
    End Function     '** wc_UK_LoginID


    '** Generate the SET methods 


End Class

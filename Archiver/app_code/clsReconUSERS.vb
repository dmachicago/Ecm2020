Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql


Public Class clsReconUSERS

    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim UserID As String = ""




    '** Generate the SET methods 
    Public Sub setUserid(ByVal val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        UserID = val
    End Sub






    '** Generate the GET methods 
    Public Function getUserid() As String
        If Len(UserID) = 0 Then
            MessageBox.Show("GET: Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(UserID)
    End Function


    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If UserID.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If UserID.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO Users("
        s = s + "UserID,UserName,UserLoginID,UserPassword) values ("
        s = s + "'" + UserID + "', " + " '" + UserID + "', '" + UserID + "', 'password' )"
        Return DBARCH.ExecuteSqlNewConn(s, False)


    End Function


    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        s = s + " update Users set "
        s = s + "UserID = '" + getUserid() + "'"
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
        s = s + "UserID "
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
        s = s + "UserID "
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
    Public Function Zeroize(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        s = s + " Delete from Users"


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function


End Class

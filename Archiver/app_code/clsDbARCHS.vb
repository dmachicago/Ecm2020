Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql

Public Class clsDbARCHS

    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging


    Dim DB_ID As String = ""
    Dim DB_CONN_STR As String = ""


    '** Generate the SET methods 
    Public Sub setDb_id(ByVal val As String)
        If Len(val) = 0 Then
            val = "ECM.Library"
            'messagebox.show("SET: Field 'Db_id' cannot be NULL.")
            'Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        DB_ID = val
    End Sub

    Public Sub setDb_conn_str(ByVal val As String)
        val = UTIL.RemoveSingleQuotes(val)
        DB_CONN_STR = val
    End Sub



    '** Generate the GET methods 
    Public Function getDb_id() As String
        If Len(DB_ID) = 0 Then
            'messagebox.show("GET: Field 'Db_id' cannot be NULL.")
            Return "ECM.Library"
        End If
        Return UTIL.RemoveSingleQuotes(DB_ID)
    End Function

    Public Function getDb_conn_str() As String
        Return UTIL.RemoveSingleQuotes(DB_CONN_STR)
    End Function



    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If DB_ID.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If DB_ID.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO Databases("
        s = s + "DB_ID,"
        s = s + "DB_CONN_STR) values ("
        s = s + "'" + DB_ID + "'" + ","
        s = s + "'" + DB_CONN_STR + "'" + ")"
        Return DBARCH.ExecuteSqlNewConn(s, False)

    End Function


    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update Databases set "
        s = s + "DB_ID = '" + getDb_id() + "'" + ", "
        s = s + "DB_CONN_STR = '" + getDb_conn_str() + "'"
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
        s = s + "DB_ID,"
        s = s + "DB_CONN_STR "
        s = s + " FROM Databases"

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function


    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "DB_ID,"
        s = s + "DB_CONN_STR "
        s = s + " FROM Databases"
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

        s = " Delete from Databases"
        s = s + WhereClause

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate the Zeroize Table method 
    Public Function Zeroize(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from Databases"

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function

End Class

Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql


Public Class clsRUNPARMS


    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging



    Dim Parm As String = ""
    Dim ParmValue As String = ""
    Dim UserID As String = ""




    '** Generate the SET methods 
    Public Sub setParm(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Parm' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        Parm = val
    End Sub


    Public Sub setParmvalue(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ParmValue = val
    End Sub


    Public Sub setUserid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        UserID = val
    End Sub






    '** Generate the GET methods 
    Public Function getParm() As String
        If Len(Parm) = 0 Then
            MessageBox.Show("GET: Field 'Parm' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(Parm)
    End Function


    Public Function getParmvalue() As String
        Return UTIL.RemoveSingleQuotes(ParmValue)
    End Function


    Public Function getUserid() As String
        If Len(UserID) = 0 Then
            MessageBox.Show("GET: Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(UserID)
    End Function






    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If Parm.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If Parm.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO RunParms("
        s = s + "Parm,"
        s = s + "ParmValue,"
        s = s + "UserID) values ("
        s = s + "'" + getParm() + "'" + ","
        s = s + "'" + getParmvalue() + "'" + ","
        s = s + "'" + UserID + "'" + ")"
        Return DBARCH.ExecuteSqlNewConn(s, False)


    End Function




    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        s = s + " update RunParms set "
        's = s + "Parm = '" + getParm() + "'" + ", "
        s = s + "ParmValue = '" + getParmvalue() + "'" + ", "
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
        s = s + "Parm,"
        s = s + "ParmValue,"
        s = s + "UserID "
        s = s + " FROM RunParms"

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function




    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "Parm,"
        s = s + "ParmValue,"
        s = s + "UserID "
        s = s + " FROM RunParms "
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


        s = " Delete from RunParms "
        s = s + WhereClause


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        s = s + " Delete from RunParms "


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate Index Queries 
    Public Function cnt_PKI8(ByVal Parm As String, ByVal UserID As String) As Integer


        Dim B As Integer = 0
        Dim TBL As String = "RunParms"
        Dim WC As String = "Where Parm = '" + Parm + "' and   UserID = '" + UserID + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_PKI8


    '** Generate Index ROW Queries 
    Public Function getRow_PKI8(ByVal Parm As String, ByVal UserID As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "RunParms"
        Dim WC As String = "Where Parm = '" + Parm + "' and   UserID = '" + UserID + "'"

        rsData = DBARCH.GetRowByKey(TBL, WC)
        If rsData Is Nothing Then
            Return Nothing
        End If
        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PKI8


    ''' Build Index Where Caluses 
    '''
    Public Function wc_PKI8(ByVal Parm As String, ByVal UserID As String) As String


Dim WC AS String  = "Where Parm = '" + Parm + "' and   UserID = '" + UserID + "'" 


        Return WC
    End Function     '** wc_PKI8


    '** Generate the SET methods 


End Class

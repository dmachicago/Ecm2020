Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsAVAILFILETYPES

    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging


    Dim ExtCode As String = ""


    '** Generate the SET methods 
    Public Sub setExtcode(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Extcode' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        ExtCode = val
    End Sub



    '** Generate the GET methods 
    Public Function getExtcode() As String
        If Len(ExtCode) = 0 Then
            MessageBox.Show("GET: Field 'Extcode' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(ExtCode)
    End Function



    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If ExtCode.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If ExtCode.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO AvailFileTypes("
        s = s + "ExtCode) values ("
        s = s + "'" + ExtCode + "'" + ")"
        Return DBARCH.ExecuteSqlNewConn(s, False)

    End Function


    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update AvailFileTypes set "
        s = s + "ExtCode = '" + getExtcode() + "'"
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
        s = s + "ExtCode "
        s = s + " FROM AvailFileTypes"

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function


    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "ExtCode "
        s = s + " FROM AvailFileTypes"
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

        s = " Delete from AvailFileTypes"
        s = s + WhereClause

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from AvailFileTypes"

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate Index Queries 
    Public Function cnt_PKI7(ByVal ExtCode As String) As Integer

        Dim B As Integer = 0
        Dim TBL As String = "AvailFileTypes"
        Dim WC As String = "Where ExtCode = '" + ExtCode + "'"

        B = DBARCH.iGetRowCount(TBL, WC)

        Return B
    End Function     '** cnt_PKI7

    '** Generate Index ROW Queries 
    Public Function getRow_PKI7(ByVal ExtCode As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "AvailFileTypes"
        Dim WC As String = "Where ExtCode = '" + ExtCode + "'"

        rsData = DBARCH.GetRowByKey(TBL, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PKI7

    ''' Build Index Where Caluses 
    '''
    Public Function wc_PKI7(ByVal ExtCode As String) As String

Dim WC AS String  = "Where ExtCode = '" + ExtCode + "'" 

        Return WC
    End Function     '** wc_PKI7

    '** Generate the SET methods 

End Class

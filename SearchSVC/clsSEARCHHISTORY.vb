Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsSEARCHHISTORY

    '** DIM the selected table columns 
    Dim DB As New clsDatabaseSVR
    Dim DMA As New clsDmaSVR
    Dim UTIL As New clsUtilitySVR
    Dim LOG As New clsLogging

    Dim SearchSql As String = ""
    Dim SearchDate As String = ""
    Dim UserID As String = ""
    Dim RowID As String = ""
    Dim ReturnedRows As String = ""
    Dim StartTime As String = ""
    Dim EndTime As String = ""
    Dim CalledFrom As String = ""
    Dim TypeSearch As String = ""

    Dim SecureID As Integer = -1

    Sub New(ByVal iSecureID As Integer)
        SecureID = iSecureID
    End Sub


    '** Generate the SET methods 
    Public Sub setSearchsql(ByRef val as string)
        val = UTIL.RemoveSingleQuotes(val)
        SearchSql = val
    End Sub

    Public Sub setSearchdate(ByRef val as string)
        val = UTIL.RemoveSingleQuotes(val)
        SearchDate = val
    End Sub

    Public Sub setUserid(ByRef val as string)
        val = UTIL.RemoveSingleQuotes(val)
        UserID = val
    End Sub

    Public Sub setReturnedrows(ByRef val as string)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        ReturnedRows = val
    End Sub

    Public Sub setStarttime(ByRef val as string)
        val = UTIL.RemoveSingleQuotes(val)
        StartTime = val
    End Sub

    Public Sub setEndtime(ByRef val as string)
        val = UTIL.RemoveSingleQuotes(val)
        EndTime = val
    End Sub

    Public Sub setCalledfrom(ByRef val as string)
        val = UTIL.RemoveSingleQuotes(val)
        CalledFrom = val
    End Sub

    Public Sub setTypesearch(ByRef val as string)
        val = UTIL.RemoveSingleQuotes(val)
        TypeSearch = val
    End Sub



    '** Generate the GET methods 
    Public Function getSearchsql() As String
        Return UTIL.RemoveSingleQuotes(SearchSql)
    End Function

    Public Function getSearchdate() As String
        Return UTIL.RemoveSingleQuotes(SearchDate)
    End Function

    Public Function getUserid() As String
        Return UTIL.RemoveSingleQuotes(UserID)
    End Function

    'Public Function getRowid() As String
    '    If Len(RowID) = 0 Then
    '        MsgBox("GET: Field 'Rowid' cannot be NULL.")
    '        Return ""
    '    End If
    '    If Len(RowID) = 0 Then
    '        RowID = "null"
    '    End If
    '    Return RowID
    'End Function

    Public Function getReturnedrows() As String
        If Len(ReturnedRows) = 0 Then
            ReturnedRows = "null"
        End If
        Return ReturnedRows
    End Function

    Public Function getStarttime() As String
        Return UTIL.RemoveSingleQuotes(StartTime)
    End Function

    Public Function getEndtime() As String
        Return UTIL.RemoveSingleQuotes(EndTime)
    End Function

    Public Function getCalledfrom() As String
        Return UTIL.RemoveSingleQuotes(CalledFrom)
    End Function

    Public Function getTypesearch() As String
        Return UTIL.RemoveSingleQuotes(TypeSearch)
    End Function



    '** Generate the Required Fields Validation AS string 
    'Public Function ValidateReqData() As Boolean
    '    If RowID.Length = 0 Then Return false
    '    Return True
    'End Function


    '** Generate the Validation AS string 
    Public Function ValidateData() As Boolean
        Return True
    End Function


    '** Generate the INSERT AS string 
    Public Function Insert() As Boolean

        If SearchSql = "" Then
            Return True
        End If

        Dim SearchSqlCopy As String = SearchSql
        SearchSqlCopy.Replace("'", "`")
        If InStr(SearchSqlCopy, "'") > 0 Then
            For II As Integer = 1 To SearchSqlCopy.Length
                Dim CH As String = Mid(SearchSqlCopy, II, 1)
                If CH.Equals("'") Then
                    Mid(SearchSqlCopy, II, 1) = "`"
                End If
            Next
        End If
        Dim b As Boolean = false
        Dim s As String = ""
        If ReturnedRows.Length = 0 Then
            ReturnedRows = "-1"
        End If
        s = s + " INSERT INTO SearchHistory("
        s = s + "SearchSql,"
        s = s + "SearchDate,"
        s = s + "UserID,"
        s = s + "ReturnedRows,"
        s = s + "StartTime,"
        s = s + "EndTime,"
        s = s + "CalledFrom,"
        s = s + "TypeSearch) values ("
        s = s + "'" + SearchSqlCopy + "'" + ","
        s = s + "getdate()" + ","
        s = s + "'" + UserID + "'" + ","
        's = s + RowID + ","
        s = s + ReturnedRows + ","
        s = s + "'" + StartTime + "'" + ","
        s = s + "'" + EndTime + "'" + ","
        s = s + "'" + CalledFrom + "'" + ","
        s = s + "'" + TypeSearch + "'" + ")"
        b = DB.DBExecuteSql(SecureID, s)
        If b = False Then
            Console.WriteLine("Error clsSearchHistory Insert")
        End If
        Return b

    End Function


    '** Generate the UPDATE AS string 
    Public Function Update(ByVal WhereClause as string) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update SearchHistory set "
        s = s + "SearchSql = '" + getSearchsql() + "'" + ", "
        s = s + "SearchDate = '" + getSearchdate() + "'" + ", "
        s = s + "UserID = '" + getUserid() + "'" + ", "
        s = s + "ReturnedRows = " + getReturnedrows() + ", "
        s = s + "StartTime = '" + getStarttime() + "'" + ", "
        s = s + "EndTime = '" + getEndtime() + "'" + ", "
        s = s + "CalledFrom = '" + getCalledfrom() + "'" + ", "
        s = s + "TypeSearch = '" + getTypesearch() + "'"
        WhereClause = " " + WhereClause
        s = s + WhereClause
        Return DB.DBExecuteSql(SecureID, s)
    End Function


    '** Generate the SELECT AS string 
    Public Function SelectRecs(ByVal SecureID As Integer) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "SearchSql,"
        s = s + "SearchDate,"
        s = s + "UserID,"
        s = s + "RowID,"
        s = s + "ReturnedRows,"
        s = s + "StartTime,"
        s = s + "EndTime,"
        s = s + "CalledFrom,"
        s = s + "TypeSearch "
        s = s + " FROM SearchHistory"
        '** s=s+ "ORDERBY xxxx"
        Dim CS$ = DBgetConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function


    '** Generate the Select One Row AS string 
    Public Function SelectOne(ByVal SecureID As Integer, ByVal WhereClause as string) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "SearchSql,"
        s = s + "SearchDate,"
        s = s + "UserID,"
        s = s + "RowID,"
        s = s + "ReturnedRows,"
        s = s + "StartTime,"
        s = s + "EndTime,"
        s = s + "CalledFrom,"
        s = s + "TypeSearch "
        s = s + " FROM SearchHistory"
        s = s + WhereClause
        '** s=s+ "ORDERBY xxxx"
        Dim CS$ = DBgetConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function


    '** Generate the DELETE AS string 
    Public Function Delete(ByVal WhereClause as string) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        WhereClause = " " + WhereClause

        s = " Delete from SearchHistory"
        s = s + WhereClause

        b = DB.DBExecuteSql(SecureID, s)
        Return b

    End Function


    '** Generate the Zeroize Table AS string 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from SearchHistory"

        b = DB.DBExecuteSql(SecureID, s)
        Return b

    End Function


    '** Generate Index Queries 
    Public Function cnt_PK_SearchHist(ByVal RowID As Integer) As Integer

        Dim B As Integer = 0
        Dim TBL$ = "SearchHistory"
        Dim WC$ = "Where RowID = " & RowID

        B = DB.iGetRowCount(TBL$, WC)

        Return B
    End Function     '** cnt_PK_SearchHist

    '** Generate Index ROW Queries 
    Public Function getRow_PK_SearchHist(ByVal SecureID As Integer, ByVal RowID As Integer) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL$ = "SearchHistory"
        Dim WC$ = "Where RowID = " & RowID

        rsData = DB.GetRowByKey(SecureID, TBL$, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK_SearchHist

    ''' Build Index Where Caluses 
    '''
    Public Function wc_PK_SearchHist(ByVal RowID As Integer) As String

        Dim WC$ = "Where RowID = " & RowID

        Return WC
    End Function     '** wc_PK_SearchHist

    '** Generate the SET methods 

End Class

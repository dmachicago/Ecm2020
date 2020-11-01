Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsAVAILFILETYPESUNDEFINED
    Inherits clsDatabaseARCH
    '** DIM the selected table columns 
    'Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging


    Dim FileType As String = ""
    Dim SubstituteType As String = ""
    Dim Applied As String = ""


    '** Generate the SET methods 
    Public Sub setFiletype(ByRef val AS String )
        If Len(val) = 0 Then
            messagebox.show("SET: Field 'Filetype' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        FileType = val
    End Sub

    Public Sub setSubstitutetype(ByRef val AS String )
        val = UTIL.RemoveSingleQuotes(val)
        SubstituteType = val
    End Sub

    Public Sub setApplied(ByRef val AS String )
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        Applied = val
    End Sub



    '** Generate the GET methods 
    Public Function getFiletype() As String
        If Len(FileType) = 0 Then
            messagebox.show("GET: Field 'Filetype' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(FileType)
    End Function

    Public Function getSubstitutetype() As String
        Return UTIL.RemoveSingleQuotes(SubstituteType)
    End Function

    Public Function getApplied() As String
        If Len(Applied) = 0 Then
            Applied = "null"
        End If
        Return Applied
    End Function



    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If FileType.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If FileType.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO AvailFileTypesUndefined("
        s = s + "FileType,"
        s = s + "SubstituteType,"
        s = s + "Applied) values ("
        s = s + "'" + FileType + "'" + ","
        s = s + "'" + SubstituteType + "'" + ","
        s = s + Applied + ")"
        Return ExecuteSqlNewConn(s, False)

    End Function


    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause AS String ) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update AvailFileTypesUndefined set "
        s = s + "FileType = '" + getFiletype() + "'" + ", "
        s = s + "SubstituteType = '" + getSubstitutetype() + "'" + ", "
        s = s + "Applied = " + getApplied()
        WhereClause = " " + WhereClause
        s = s + WhereClause
        Return ExecuteSqlNewConn(s, False)
    End Function


    '** Generate the SELECT method 
    Public Function SelectRecs() As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "FileType,"
        s = s + "SubstituteType,"
        s = s + "Applied "
        s = s + " FROM AvailFileTypesUndefined"

        Dim CS As String = setConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader() 
        Return rsData
    End Function


    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause AS String ) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "FileType,"
        s = s + "SubstituteType,"
        s = s + "Applied "
        s = s + " FROM AvailFileTypesUndefined"
        s = s + WhereClause

        Dim CS As String = setConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader() 
        Return rsData
    End Function


    '** Generate the DELETE method 
    Public Function Delete(ByVal WhereClause AS String ) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        WhereClause = " " + WhereClause

        s = " Delete from AvailFileTypesUndefined"
        s = s + WhereClause

        b = ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from AvailFileTypesUndefined"

        b = ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate Index Queries 
    Public Function cnt_PK_AFTU(ByVal FileType As String) As Integer

        Dim B As Integer = 0
Dim TBL AS String  = "AvailFileTypesUndefined" 
Dim WC AS String  = "Where FileType = '" + FileType + "'"

        B = iGetRowCount(TBL, WC)

        Return B
    End Function     '** cnt_PK_AFTU

    '** Generate Index ROW Queries 
    Public Function getRow_PK_AFTU(ByVal FileType As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
Dim TBL AS String  = "AvailFileTypesUndefined" 
Dim WC AS String  = "Where FileType = '" + FileType + "'"

        rsData = GetRowByKey(TBL, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK_AFTU

    ''' Build Index Where Caluses 
    '''
    Public Function wc_PK_AFTU(ByVal FileType As String) As String

Dim WC AS String  = "Where FileType = '" + FileType + "'" 

        Return WC
    End Function     '** wc_PK_AFTU
End Class

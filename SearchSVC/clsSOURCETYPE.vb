Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql


Public Class clsSOURCETYPE


    '** DIM the selected table columns 
    Dim DB As New clsDatabaseSVR
    Dim DMA As New clsDmaSVR
    Dim UTIL As New clsUtilitySVR
    Dim LOG As New clsLogging



    Dim SourceTypeCode As String = ""
    Dim StoreExternal As String = ""
    Dim SourceTypeDesc As String = ""
    Dim Indexable As String = ""


    Dim SecureID As Integer = -1

    Sub New(ByVal iSecureID As Integer)
        SecureID = iSecureID
    End Sub


    '** Generate the SET methods 
    Public Sub setSourcetypecode(ByRef val as string)
        If Len(val) = 0 Then
            MsgBox("SET: Field 'Sourcetypecode' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        SourceTypeCode = val
    End Sub


    Public Sub setStoreexternal(ByRef val as string)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        StoreExternal = val
    End Sub


    Public Sub setSourcetypedesc(ByRef val as string)
        val = UTIL.RemoveSingleQuotes(val)
        SourceTypeDesc = val
    End Sub


    Public Sub setIndexable(ByRef val as string)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        Indexable = val
    End Sub






    '** Generate the GET methods 
    Public Function getSourcetypecode() As String
        If Len(SourceTypeCode) = 0 Then
            MsgBox("GET: Field 'Sourcetypecode' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(SourceTypeCode)
    End Function


    Public Function getStoreexternal() As String
        If Len(StoreExternal) = 0 Then
            StoreExternal = "null"
        End If
        Return StoreExternal
    End Function


    Public Function getSourcetypedesc() As String
        Return UTIL.RemoveSingleQuotes(SourceTypeDesc)
    End Function


    Public Function getIndexable() As String
        If Len(Indexable) = 0 Then
            Indexable = "null"
        End If
        Return Indexable
    End Function






    '** Generate the Required Fields Validation AS string 
    Public Function ValidateReqData() As Boolean
        If SourceTypeCode.Length = 0 Then Return false
        Return True
    End Function




    '** Generate the Validation AS string 
    Public Function ValidateData() As Boolean
        If SourceTypeCode.Length = 0 Then Return false
        Return True
    End Function




    '** Generate the INSERT AS string 
    Public Function Insert() As Boolean
        Dim b As Boolean = false
        Dim s As String = ""
        s = s + " INSERT INTO SourceType("
        s = s + "SourceTypeCode,"
        s = s + "StoreExternal,"
        s = s + "SourceTypeDesc,"
        s = s + "Indexable) values ("
        s = s + "'" + SourceTypeCode + "'" + ","
        s = s + StoreExternal + ","
        s = s + "'" + SourceTypeDesc + "'" + ","
        s = s + Indexable + ")"

        b = DB.DBExecuteSql(SecureID, S, False)
        If Not b Then
            'WriteTraceLog("clsSOURCETYPE : Insert : 01 : " + "ERROR: An unknown file type was NOT inserted. The SQL is: " + s)
            log.WriteToSqlLog("clsSOURCETYPE : Insert : 01 : " + "ERROR: An unknown file type was NOT inserted. The SQL is: " + s)
        End If
        Return b


    End Function




    '** Generate the UPDATE AS string 
    Public Function Update(ByVal WhereClause as string) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        s = s + " update SourceType set "
        's = s + "SourceTypeCode = '" + getSourcetypecode() + "'" + ", "
        s = s + "StoreExternal = " + getStoreexternal() + ", "
        s = s + "SourceTypeDesc = '" + getSourcetypedesc() + "'" + ", "
        s = s + "Indexable = " + getIndexable()
        WhereClause = " " + WhereClause
        s = s + WhereClause
        Return DB.DBExecuteSql(SecureID, S, False)
    End Function




    '** Generate the SELECT AS string 
    Public Function SelectRecs(ByVal SecureID As Integer) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "SourceTypeCode,"
        s = s + "StoreExternal,"
        s = s + "SourceTypeDesc,"
        s = s + "Indexable "
        s = s + " FROM SourceType"

        Dim CS$ = DBgetConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function




    '** Generate the Select One Row AS string 
    Public Function SelectOne(ByVal SecureID As Integer, ByVal WhereClause as string) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "SourceTypeCode,"
        s = s + "StoreExternal,"
        s = s + "SourceTypeDesc,"
        s = s + "Indexable "
        s = s + " FROM SourceType"
        s = s + WhereClause

        Dim CS$ = DBgetConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function




    '** Generate the DELETE AS string 
    Public Function Delete(ByVal WhereClause as string) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        WhereClause = " " + WhereClause


        s = " Delete from SourceType"
        s = s + WhereClause


        b = DB.DBExecuteSql(SecureID, S, False)
        Return b


    End Function




    '** Generate the Zeroize Table AS string 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        s = s + " Delete from SourceType"


        b = DB.DBExecuteSql(SecureID, S, False)
        Return b


    End Function




    '** Generate Index Queries 
    Public Function cnt_PK34(ByVal SourceTypeCode As String) As Integer


        Dim B As Integer = 0
        Dim TBL$ = "SourceType"
        Dim WC$ = "Where SourceTypeCode = '" + SourceTypeCode + "'"


        B = DB.iGetRowCount(TBL$, WC)


        Return B
    End Function     '** cnt_PK34


    '** Generate Index ROW Queries 
    Public Function getRow_PK34(ByVal SourceTypeCode As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL$ = "SourceType"
        Dim WC$ = "Where SourceTypeCode = '" + SourceTypeCode + "'"


        rsData = DB.GetRowByKey(SecureID, TBL$, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK34


    ''' Build Index Where Caluses 
    '''
    Public Function wc_PK34(ByVal SourceTypeCode As String) As String


        Dim WC$ = "Where SourceTypeCode = '" + SourceTypeCode + "'"


        Return WC
    End Function     '** wc_PK34
End Class

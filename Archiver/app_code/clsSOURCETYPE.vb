Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql


Public Class clsSOURCETYPE


    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim SourceTypeCode As String = ""
    Dim StoreExternal As String = ""
    Dim SourceTypeDesc As String = ""
    Dim Indexable As String = ""




    '** Generate the SET methods 
    Public Sub setSourcetypecode(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Sourcetypecode' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        SourceTypeCode = val
    End Sub


    Public Sub setStoreexternal(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        StoreExternal = val
    End Sub


    Public Sub setSourcetypedesc(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        SourceTypeDesc = val
    End Sub


    Public Sub setIndexable(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        Indexable = val
    End Sub






    '** Generate the GET methods 
    Public Function getSourcetypecode() As String
        If Len(SourceTypeCode) = 0 Then
            MessageBox.Show("GET: Field 'Sourcetypecode' cannot be NULL.")
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






    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If SourceTypeCode.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If SourceTypeCode.Length = 0 Then Return False
        Return True
    End Function

    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
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

        b = DBARCH.ExecuteSqlNewConn(s, False)
        If Not b Then
            LOG.WriteToArchiveLog("clsSOURCETYPE : Insert : 01 : " + "ERROR: An unknown file type was NOT inserted. The SQL is: " + s)
            LOG.WriteToArchiveLog("clsSOURCETYPE : Insert : 01 : " + "ERROR: An unknown file type was NOT inserted. The SQL is: " + s)
        End If
        Return b


    End Function


    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
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
        Return DBARCH.ExecuteSqlNewConn(s, False)
    End Function




    '** Generate the SELECT method 
    Public Function SelectRecs() As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "SourceTypeCode,"
        s = s + "StoreExternal,"
        s = s + "SourceTypeDesc,"
        s = s + "Indexable "
        s = s + " FROM SourceType"

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function




    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
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

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function




    '** Generate the DELETE method 
    Public Function Delete(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        WhereClause = " " + WhereClause


        s = " Delete from SourceType"
        s = s + WhereClause


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        s = s + " Delete from SourceType"


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate Index Queries 
    Public Function cnt_PK34(ByVal SourceTypeCode As String) As Integer


        Dim B As Integer = 0
        Dim TBL As String = "SourceType"
        Dim WC As String = "Where SourceTypeCode = '" + SourceTypeCode + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_PK34


    '** Generate Index ROW Queries 
    Public Function getRow_PK34(ByVal SourceTypeCode As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "SourceType"
        Dim WC As String = "Where SourceTypeCode = '" + SourceTypeCode + "'"


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK34


    ''' Build Index Where Caluses 
    '''
    Public Function wc_PK34(ByVal SourceTypeCode As String) As String


Dim WC AS String  = "Where SourceTypeCode = '" + SourceTypeCode + "'" 


        Return WC
    End Function     '** wc_PK34
End Class

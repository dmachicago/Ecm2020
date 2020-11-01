Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql

Public Class clsATTRIBUTES

    '** DIM the selected table columns
    Dim DBARCH As New clsDatabaseARCH

    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim AttributeName As String = ""
    Dim AttributeDataType As String = ""
    Dim AttributeDesc As String = ""
    Dim AssoApplication As String = ""
    Dim AllowedValues As String = ""

    '** Generate the SET methods
    Public Sub setAttributename(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Attributename' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        AttributeName = val
    End Sub

    Public Sub setAttributedatatype(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Attributedatatype' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        AttributeDataType = val
    End Sub

    Public Sub setAttributedesc(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        AttributeDesc = val
    End Sub

    Public Sub setAssoapplication(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        AssoApplication = val
    End Sub

    Public Sub setAllowedvalues(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        AllowedValues = val
    End Sub

    '** Generate the GET methods
    Public Function getAttributename() As String
        If Len(AttributeName) = 0 Then
            MessageBox.Show("GET: Field 'Attributename' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(AttributeName)
    End Function

    Public Function getAttributedatatype() As String
        If Len(AttributeDataType) = 0 Then
            MessageBox.Show("GET: Field 'Attributedatatype' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(AttributeDataType)
    End Function

    Public Function getAttributedesc() As String
        Return UTIL.RemoveSingleQuotes(AttributeDesc)
    End Function

    Public Function getAssoapplication() As String
        Return UTIL.RemoveSingleQuotes(AssoApplication)
    End Function

    Public Function getAllowedvalues() As String
        Return UTIL.RemoveSingleQuotes(AllowedValues)
    End Function

    '** Generate the Required Fields Validation method
    Public Function ValidateReqData() As Boolean
        If AttributeName.Length = 0 Then Return False
        If AttributeDataType.Length = 0 Then Return False
        Return True
    End Function

    '** Generate the Validation method
    Public Function ValidateData() As Boolean
        If AttributeName.Length = 0 Then Return False
        If AttributeDataType.Length = 0 Then Return False
        Return True
    End Function

    '** Generate the INSERT method
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO Attributes("
        s = s + "AttributeName,"
        s = s + "AttributeDataType,"
        s = s + "AttributeDesc,"
        s = s + "AssoApplication,"
        s = s + "AllowedValues) values ("
        s = s + "'" + AttributeName + "'" + ","
        s = s + "'" + AttributeDataType + "'" + ","
        s = s + "'" + AttributeDesc + "'" + ","
        s = s + "'" + AssoApplication + "'" + ","
        s = s + "'" + AllowedValues + "'" + ")"
        Return DBARCH.ExecuteSqlNewConn(s, False)

    End Function

    '** Generate the UPDATE method
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update Attributes set "
        's = s + "AttributeName = '" + getAttributename() + "'" + ", "
        s = s + "AttributeDataType = '" + getAttributedatatype() + "'" + ", "
        s = s + "AttributeDesc = '" + getAttributedesc() + "'" + ", "
        s = s + "AssoApplication = '" + getAssoapplication() + "'" + ", "
        s = s + "AllowedValues = '" + getAllowedvalues() + "'"
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
        s = s + "AttributeName,"
        s = s + "AttributeDataType,"
        s = s + "AttributeDesc,"
        s = s + "AssoApplication,"
        s = s + "AllowedValues "
        s = s + " FROM Attributes"
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
        s = s + "AttributeName,"
        s = s + "AttributeDataType,"
        s = s + "AttributeDesc,"
        s = s + "AssoApplication,"
        s = s + "AllowedValues "
        s = s + " FROM Attributes"
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

        s = " Delete from Attributes"
        s = s + WhereClause

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function

    '** Generate the Zeroize Table method
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from Attributes"

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function

    '** Generate Index Queries
    Public Function cnt_PK36(ByVal AttributeName As String) As Integer

        Dim B As Integer = 0
        Dim TBL As String = "Attributes"
        Dim WC As String = "Where AttributeName = '" + AttributeName + "'"

        B = DBARCH.iGetRowCount(TBL, WC)

        Return B
    End Function     '** cnt_PK36

    '** Generate Index ROW Queries
    Public Function getRow_PK36(ByVal AttributeName As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "Attributes"
        Dim WC As String = "Where AttributeName = '" + AttributeName + "'"

        rsData = DBARCH.GetRowByKey(TBL, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK36

    ''' Build Index Where Caluses
    Public Function wc_PK36(ByVal AttributeName As String) As String

        Dim WC As String = "Where AttributeName = '" + AttributeName + "'"

        Return WC
    End Function     '** wc_PK36

    '** Generate the SET methods

End Class
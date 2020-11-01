Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsATTACHMENTTYPE

    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma

    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging


    Dim AttachmentCode As String = ""
    Dim Description As String = ""
    Dim isZipFormat As String = ""


    '** Generate the SET methods 
    Public Sub setAttachmentcode(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Attachmentcode' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        AttachmentCode = val
    End Sub

    Public Sub setDescription(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        Description = val
    End Sub

    Public Sub setIszipformat(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        isZipFormat = val
    End Sub



    '** Generate the GET methods 
    Public Function getAttachmentcode() As String
        If Len(AttachmentCode) = 0 Then
            MessageBox.Show("GET: Field 'Attachmentcode' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(AttachmentCode)
    End Function

    Public Function getDescription() As String
        Return UTIL.RemoveSingleQuotes(Description)
    End Function

    Public Function getIszipformat() As String
        If Len(isZipFormat) = 0 Then
            isZipFormat = "null"
        End If
        Return isZipFormat
    End Function



    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If AttachmentCode.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If AttachmentCode.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If AttachmentCode.Trim.Length > 10 Then
            AttachmentCode = "UKN"
            Description = "Unknown Attachment Type"
        End If

        If isZipFormat.Length = 0 Then
            isZipFormat = "0"
        End If

        s = s + " INSERT INTO AttachmentType("
        s = s + "AttachmentCode,"
        s = s + "Description,"
        s = s + "isZipFormat) values ("
        s = s + "'" + AttachmentCode + "'" + ","
        s = s + "'" + Description + "'" + ","
        s = s + isZipFormat + ")"
        Return DBARCH.ExecuteSqlNewConn(s, False)

    End Function


    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update AttachmentType set "
        's = s + "AttachmentCode = '" + getAttachmentcode() + "'" + ", "
        s = s + "Description = '" + getDescription() + "'" + ", "
        s = s + "isZipFormat = " + getIszipformat()
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
        s = s + "AttachmentCode,"
        s = s + "Description,"
        s = s + "isZipFormat "
        s = s + " FROM AttachmentType"

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function


    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "AttachmentCode,"
        s = s + "Description,"
        s = s + "isZipFormat "
        s = s + " FROM AttachmentType"
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

        s = " Delete from AttachmentType"
        s = s + WhereClause

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from AttachmentType"

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate Index Queries 
    Public Function cnt_PK29(ByVal AttachmentCode As String) As Integer

        Dim B As Integer = 0
        Dim TBL As String = "AttachmentType"
        Dim WC As String = "Where AttachmentCode = '" + AttachmentCode + "'"

        B = DBARCH.iGetRowCount(TBL, WC)

        Return B
    End Function     '** cnt_PK29

    '** Generate Index ROW Queries 
    Public Function getRow_PK29(ByVal AttachmentCode As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "AttachmentType"
        Dim WC As String = "Where AttachmentCode = '" + AttachmentCode + "'"

        rsData = DBARCH.GetRowByKey(TBL, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK29

    ''' Build Index Where Caluses 
    '''
    Public Function wc_PK29(ByVal AttachmentCode As String) As String

Dim WC AS String  = "Where AttachmentCode = '" + AttachmentCode + "'" 

        Return WC
    End Function     '** wc_PK29

    '** Generate the SET methods 

End Class

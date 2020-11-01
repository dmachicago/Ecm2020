Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsATTACHMENTTYPE

    '** DIM the selected table columns 
    Dim DB As New clsDatabaseSVR

    Dim DMA As New clsDmaSVR

    Dim UTIL As New clsUtilitySVR
    Dim LOG As New clsLogging


    Dim AttachmentCode As String = ""
    Dim Description As String = ""
    Dim isZipFormat As String = ""

    Dim SecureID As Integer = -1

    Sub New(ByVal iSecureID As Integer)
        SecureID = iSecureID
    End Sub


    '** Generate the SET methods 
    Public Sub setAttachmentcode(ByRef val as string)
        If Len(val) = 0 Then
            MsgBox("SET: Field 'Attachmentcode' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        AttachmentCode = val
    End Sub

    Public Sub setDescription(ByRef val as string)
        val = UTIL.RemoveSingleQuotes(val)
        Description = val
    End Sub

    Public Sub setIszipformat(ByRef val as string)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        isZipFormat = val
    End Sub



    '** Generate the GET methods 
    Public Function getAttachmentcode() As String
        If Len(AttachmentCode) = 0 Then
            MsgBox("GET: Field 'Attachmentcode' cannot be NULL.")
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



    '** Generate the Required Fields Validation AS string 
    Public Function ValidateReqData() As Boolean
        If AttachmentCode.Length = 0 Then Return false
        Return True
    End Function


    '** Generate the Validation AS string 
    Public Function ValidateData() As Boolean
        If AttachmentCode.Length = 0 Then Return false
        Return True
    End Function


    '** Generate the INSERT AS string 
    Public Function Insert() As Boolean
        Dim b As Boolean = false
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
        Return DB.DBExecuteSql(SecureID, S, False)

    End Function


    '** Generate the UPDATE AS string 
    Public Function Update(ByVal WhereClause as string) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update AttachmentType set "
        's = s + "AttachmentCode = '" + getAttachmentcode() + "'" + ", "
        s = s + "Description = '" + getDescription() + "'" + ", "
        s = s + "isZipFormat = " + getIszipformat()
        WhereClause = " " + WhereClause
        s = s + WhereClause
        Return DB.DBExecuteSql(SecureID, S, False)
    End Function


    '** Generate the SELECT AS string 
    Public Function SelectRecs() As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "AttachmentCode,"
        s = s + "Description,"
        s = s + "isZipFormat "
        s = s + " FROM AttachmentType"

        Dim CS$ = DBgetConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function


    '** Generate the Select One Row AS string 
    Public Function SelectOne(ByVal WhereClause as string) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "AttachmentCode,"
        s = s + "Description,"
        s = s + "isZipFormat "
        s = s + " FROM AttachmentType"
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

        s = " Delete from AttachmentType"
        s = s + WhereClause

        b = DB.DBExecuteSql(SecureID, S, False)
        Return b

    End Function


    '** Generate the Zeroize Table AS string 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from AttachmentType"

        b = DB.DBExecuteSql(SecureID, S, False)
        Return b

    End Function


    '** Generate Index Queries 
    Public Function cnt_PK29(ByVal AttachmentCode As String) As Integer

        Dim B As Integer = 0
        Dim TBL$ = "AttachmentType"
        Dim WC$ = "Where AttachmentCode = '" + AttachmentCode + "'"

        B = DB.iGetRowCount(TBL$, WC)

        Return B
    End Function     '** cnt_PK29

    '** Generate Index ROW Queries 
    Public Function getRow_PK29(ByVal AttachmentCode As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL$ = "AttachmentType"
        Dim WC$ = "Where AttachmentCode = '" + AttachmentCode + "'"

        rsData = DB.GetRowByKey(SecureID, TBL$, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK29

    ''' Build Index Where Caluses 
    '''
    Public Function wc_PK29(ByVal AttachmentCode As String) As String

        Dim WC$ = "Where AttachmentCode = '" + AttachmentCode + "'"

        Return WC
    End Function     '** wc_PK29

    '** Generate the SET methods 

End Class

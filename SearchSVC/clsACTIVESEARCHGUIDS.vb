Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsACTIVESEARCHGUIDS

    '** DIM the selected table columns 
    Dim DB As New clsDatabaseSVR
    Dim DMA As New clsDmaSVR

    Dim UTIL As New clsUtilitySVR
    Dim LOG As New clsLogging

    Dim UserID As String = ""
    Dim DocGuid As String = ""
    Dim SeqNO As String = ""

    Dim SecureID As Integer = -1

    Sub New(ByVal iSecureID As Integer)
        SecureID = iSecureID
    End Sub

    '** Generate the SET methods 
    Public Sub setUserid(ByRef val as string)
        If Len(val) = 0 Then
            MsgBox("SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        UserID = val
    End Sub

    Public Sub setDocguid(ByRef val as string)
        If Len(val) = 0 Then
            MsgBox("SET: Field 'Docguid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        DocGuid = val
    End Sub



    '** Generate the GET methods 
    Public Function getUserid() As String
        If Len(UserID) = 0 Then
            MsgBox("GET: Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(UserID)
    End Function

    Public Function getDocguid() As String
        If Len(DocGuid) = 0 Then
            MsgBox("GET: Field 'Docguid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(DocGuid)
    End Function

    Public Function getSeqno() As String
        If Len(SeqNO) = 0 Then
            MsgBox("GET: Field 'Seqno' cannot be NULL.")
            Return ""
        End If
        If Len(SeqNO) = 0 Then
            SeqNO = "null"
        End If
        Return SeqNO
    End Function



    '** Generate the Required Fields Validation AS string 
    Public Function ValidateReqData() As Boolean
        If UserID.Length = 0 Then Return false
        If DocGuid.Length = 0 Then Return false
        If SeqNO.Length = 0 Then Return false
        Return True
    End Function


    '** Generate the Validation AS string 
    Public Function ValidateData() As Boolean
        If UserID.Length = 0 Then Return false
        If DocGuid.Length = 0 Then Return false
        Return True
    End Function


    '** Generate the INSERT AS string 
    Public Function Insert() As Boolean
        Dim b As Boolean = false
        Dim s As String = ""
        s = s + " INSERT INTO ActiveSearchGuids("
        s = s + "UserID,"
        s = s + "DocGuid) values ("
        s = s + "'" + UserID + "'" + ","
        s = s + "'" + DocGuid + "'" + ")"        
        Return DB.DBExecuteSql(SecureID, s)

    End Function


    '** Generate the UPDATE AS string 
    Public Function Update(ByVal WhereClause as string) As Boolean
        Dim b As Boolean = false
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return false

        s = s + " update ActiveSearchGuids set "
        s = s + "UserID = '" + getUserid() + "'" + ", "
        s = s + "DocGuid = '" + getDocguid() + "'" + ", "
        WhereClause = " " + WhereClause
        s = s + WhereClause
        Return DB.DBExecuteSql(SecureID, s, False)
    End Function


    '** Generate the SELECT AS string 
    Public Function SelectRecs(ByVal SecureID As Integer) As SqlDataReader
        Dim b As Boolean = false
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "UserID,"
        s = s + "DocGuid,"
        s = s + "SeqNO "
        s = s + " FROM ActiveSearchGuids"

        Dim CS$ = DBgetConnStr()
        Dim CONN As New SqlConnection(CS)
        CONN.Open()
        Dim command As New SqlCommand(s, CONN)
        rsData = command.ExecuteReader()

        Return rsData
    End Function


    '** Generate the Select One Row AS string 
    Public Function SelectOne(ByVal SecureID As Integer, ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "UserID,"
        s = s + "DocGuid,"
        s = s + "SeqNO "
        s = s + " FROM ActiveSearchGuids"
        s = s + WhereClause

        Dim CS$ = DBgetConnStr()
        Dim CONN As New SqlConnection(CS)
        CONN.Open()
        Dim command As New SqlCommand(s, CONN)
        rsData = command.ExecuteReader()

        Return rsData
    End Function


    '** Generate the DELETE AS string 
    Public Function Delete(ByVal WhereClause as string) As Boolean
        Dim b As Boolean = false
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return false

        WhereClause = " " + WhereClause

        s = " Delete from ActiveSearchGuids"
        s = s + WhereClause

        b = DB.DBExecuteSql(SecureID, s, False)
        Return b

    End Function


    '** Generate the Zeroize Table AS string 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = false
        Dim s As String = ""

        s = s + " Delete from ActiveSearchGuids"

        b = DB.DBExecuteSql(SecureID, s, False)
        Return b

    End Function


    '** Generate Index Queries 
    Public Function cnt_PI01_ActiveSearchGuids(ByVal SeqNO As Integer, ByVal UserID As String) As Integer

        Dim B As Integer = 0
        Dim TBL$ = "ActiveSearchGuids"
        Dim WC$ = "Where SeqNO = " & SeqNO & " and   UserID = '" + UserID + "'"

        B = DB.iGetRowCount(TBL$, WC)

        Return B
    End Function     '** cnt_PI01_ActiveSearchGuids
    Public Function cnt_PK_ActiveSearchGuids(ByVal DocGuid As String, ByVal UserID As String) As Integer

        Dim B As Integer = 0
        Dim TBL$ = "ActiveSearchGuids"
        Dim WC$ = "Where DocGuid = '" + DocGuid + "' and   UserID = '" + UserID + "'"

        B = DB.iGetRowCount(TBL$, WC)

        Return B
    End Function     '** cnt_PK_ActiveSearchGuids

    '** Generate Index ROW Queries 
    Public Function getRow_PI01_ActiveSearchGuids(ByVal SeqNO As Integer, ByVal UserID As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL$ = "ActiveSearchGuids"
        Dim WC$ = "Where SeqNO = " & SeqNO & " and   UserID = '" + UserID + "'"

        rsData = DB.GetRowByKey(SecureID, TBL$, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PI01_ActiveSearchGuids
    Public Function getRow_PK_ActiveSearchGuids(ByVal DocGuid As String, ByVal UserID As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL$ = "ActiveSearchGuids"
        Dim WC$ = "Where DocGuid = '" + DocGuid + "' and   UserID = '" + UserID + "'"

        rsData = DB.GetRowByKey(SecureID, TBL$, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK_ActiveSearchGuids

    ''' Build Index Where Caluses 
    '''
    Public Function wc_PI01_ActiveSearchGuids(ByVal SeqNO As Integer, ByVal UserID As String) As String

        Dim WC$ = "Where SeqNO = " & SeqNO & " and   UserID = '" + UserID + "'"

        Return WC
    End Function     '** wc_PI01_ActiveSearchGuids
    Public Function wc_PK_ActiveSearchGuids(ByVal DocGuid As String, ByVal UserID As String) As String

        Dim WC$ = "Where DocGuid = '" + DocGuid + "' and   UserID = '" + UserID + "'"

        Return WC
    End Function     '** wc_PK_ActiveSearchGuids

    '** Generate the SET methods 

End Class

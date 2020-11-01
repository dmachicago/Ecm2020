Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsACTIVESEARCHGUIDS

    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma

    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim UserID As String = ""
    Dim DocGuid As String = ""
    Dim SeqNO As String = ""


    '** Generate the SET methods 
    Public Sub setUserid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        UserID = val
    End Sub

    Public Sub setDocguid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Docguid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        DocGuid = val
    End Sub



    '** Generate the GET methods 
    Public Function getUserid() As String
        If Len(UserID) = 0 Then
            MessageBox.Show("GET: Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(UserID)
    End Function

    Public Function getDocguid() As String
        If Len(DocGuid) = 0 Then
            MessageBox.Show("GET: Field 'Docguid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(DocGuid)
    End Function

    Public Function getSeqno() As String
        If Len(SeqNO) = 0 Then
            MessageBox.Show("GET: Field 'Seqno' cannot be NULL.")
            Return ""
        End If
        If Len(SeqNO) = 0 Then
            SeqNO = "null"
        End If
        Return SeqNO
    End Function



    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If UserID.Length = 0 Then Return False
        If DocGuid.Length = 0 Then Return False
        If SeqNO.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If UserID.Length = 0 Then Return False
        If DocGuid.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO ActiveSearchGuids("
        s = s + "UserID,"
        s = s + "DocGuid) values ("
        s = s + "'" + UserID + "'" + ","
        s = s + "'" + DocGuid + "'" + ")"
        Return DBARCH.ExecuteSqlNewConn(s, False)

    End Function


    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update ActiveSearchGuids set "
        s = s + "UserID = '" + getUserid() + "'" + ", "
        s = s + "DocGuid = '" + getDocguid() + "'" + ", "
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
        s = s + "UserID,"
        s = s + "DocGuid,"
        s = s + "SeqNO "
        s = s + " FROM ActiveSearchGuids"

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID)
        Dim CONN As New SqlConnection(CS)
        CONN.Open()
        Dim command As New SqlCommand(s, CONN)
        rsData = command.ExecuteReader()

        Return rsData
    End Function


    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "UserID,"
        s = s + "DocGuid,"
        s = s + "SeqNO "
        s = s + " FROM ActiveSearchGuids"
        s = s + WhereClause

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID)
        Dim CONN As New SqlConnection(CS)
        CONN.Open()
        Dim command As New SqlCommand(s, CONN)
        rsData = command.ExecuteReader()

        Return rsData
    End Function


    '** Generate the DELETE method 
    Public Function Delete(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        WhereClause = " " + WhereClause

        s = " Delete from ActiveSearchGuids"
        s = s + WhereClause

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from ActiveSearchGuids"

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate Index Queries 
    Public Function cnt_PI01_ActiveSearchGuids(ByVal SeqNO As Integer, ByVal UserID As String) As Integer

        Dim B As Integer = 0
        Dim TBL As String = "ActiveSearchGuids"
        Dim WC As String = "Where SeqNO = " & SeqNO & " and   UserID = '" + UserID + "'"

        B = DBARCH.iGetRowCount(TBL, WC)

        Return B
    End Function     '** cnt_PI01_ActiveSearchGuids
    Public Function cnt_PK_ActiveSearchGuids(ByVal DocGuid As String, ByVal UserID As String) As Integer

        Dim B As Integer = 0
        Dim TBL As String = "ActiveSearchGuids"
        Dim WC As String = "Where DocGuid = '" + DocGuid + "' and   UserID = '" + UserID + "'"

        B = DBARCH.iGetRowCount(TBL, WC)

        Return B
    End Function     '** cnt_PK_ActiveSearchGuids

    '** Generate Index ROW Queries 
    Public Function getRow_PI01_ActiveSearchGuids(ByVal SeqNO As Integer, ByVal UserID As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "ActiveSearchGuids"
        Dim WC As String = "Where SeqNO = " & SeqNO & " and   UserID = '" + UserID + "'"

        rsData = DBARCH.GetRowByKey(TBL, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PI01_ActiveSearchGuids
    Public Function getRow_PK_ActiveSearchGuids(ByVal DocGuid As String, ByVal UserID As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "ActiveSearchGuids"
        Dim WC As String = "Where DocGuid = '" + DocGuid + "' and   UserID = '" + UserID + "'"

        rsData = DBARCH.GetRowByKey(TBL, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK_ActiveSearchGuids

    ''' Build Index Where Caluses 
    '''
    Public Function wc_PI01_ActiveSearchGuids(ByVal SeqNO As Integer, ByVal UserID As String) As String

Dim WC AS String  = "Where SeqNO = " & SeqNO & " and   UserID = '" + UserID + "'" 

        Return WC
    End Function     '** wc_PI01_ActiveSearchGuids
    Public Function wc_PK_ActiveSearchGuids(ByVal DocGuid As String, ByVal UserID As String) As String

Dim WC AS String  = "Where DocGuid = '" + DocGuid + "' and   UserID = '" + UserID + "'" 

        Return WC
    End Function     '** wc_PK_ActiveSearchGuids

    '** Generate the SET methods 

End Class

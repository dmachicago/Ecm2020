Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql


Public Class clsRECIPIENTS


    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging



    Dim Recipient As String = ""
    Dim EmailGuid As String = ""
    Dim TypeRecp As String = ""




    '** Generate the SET methods 
    Public Sub setRecipient(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Recipient' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        Recipient = val
    End Sub


    Public Sub setEmailguid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Emailguid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        EmailGuid = val
    End Sub


    Public Sub setTyperecp(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        TypeRecp = val
    End Sub






    '** Generate the GET methods 
    Public Function getRecipient() As String
        If Len(Recipient) = 0 Then
            MessageBox.Show("GET: Field 'Recipient' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(Recipient)
    End Function


    Public Function getEmailguid() As String
        If Len(EmailGuid) = 0 Then
            MessageBox.Show("GET: Field 'Emailguid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(EmailGuid)
    End Function


    Public Function getTyperecp() As String
        Return UTIL.RemoveSingleQuotes(TypeRecp)
    End Function






    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If Recipient.Length = 0 Then Return False
        If EmailGuid.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If Recipient.Length = 0 Then Return False
        If EmailGuid.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO Recipients("
        s = s + "Recipient,"
        s = s + "EmailGuid,"
        s = s + "TypeRecp) values ("
        s = s + "'" + Recipient + "'" + ","
        s = s + "'" + EmailGuid + "'" + ","
        s = s + "'" + TypeRecp + "'" + ")"
        Return DBARCH.ExecuteSqlNewConn(s, False)


    End Function




    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        s = s + " update Recipients set "
        s = s + "Recipient = '" + getRecipient() + "'" + ", "
        s = s + "EmailGuid = '" + getEmailguid() + "'" + ", "
        s = s + "TypeRecp = '" + getTyperecp() + "'"
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
        s = s + "Recipient,"
        s = s + "EmailGuid,"
        s = s + "TypeRecp "
        s = s + " FROM Recipients"

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function




    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "Recipient,"
        s = s + "EmailGuid,"
        s = s + "TypeRecp "
        s = s + " FROM Recipients"
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


        s = " Delete from Recipients"
        s = s + WhereClause


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        s = s + " Delete from Recipients"


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate Index Queries 
    Public Function cnt_PK32A(ByVal EmailGuid As String, ByVal Recipient As String) As Integer


        Recipient = UTIL.RemoveSingleQuotes(Recipient)


        Dim B As Integer = 0
        Dim TBL As String = "Recipients"
        Dim WC As String = "Where EmailGuid = '" + EmailGuid + "' and   Recipient = '" + Recipient + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_PK32A


    '** Generate Index ROW Queries 
    Public Function getRow_PK32A(ByVal EmailGuid As String, ByVal Recipient As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "Recipients"
        Dim WC As String = "Where EmailGuid = '" + EmailGuid + "' and   Recipient = '" + Recipient + "'"


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK32A


    ''' Build Index Where Caluses 
    '''
    Public Function wc_PK32A(ByVal EmailGuid As String, ByVal Recipient As String) As String


Dim WC AS String  = "Where EmailGuid = '" + EmailGuid + "' and   Recipient = '" + Recipient + "'" 


        Return WC
    End Function     '** wc_PK32A
End Class

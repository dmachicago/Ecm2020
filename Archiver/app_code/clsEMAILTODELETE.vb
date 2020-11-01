Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql


Public Class clsEMAILTODELETE


    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim EmailGuid As String = ""
    Dim StoreID As String = ""
    Dim UserID As String = ""
    Dim MessageID As String = ""




    '** Generate the SET methods 
    Public Sub setEmailguid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Emailguid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        EmailGuid = val
    End Sub


    Public Sub setStoreid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Storeid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        StoreID = val
    End Sub


    Public Sub setUserid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        UserID = val
    End Sub


    Public Sub setMessageid(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        MessageID = val
    End Sub






    '** Generate the GET methods 
    Public Function getEmailguid() As String
        If Len(EmailGuid) = 0 Then
            MessageBox.Show("GET: Field 'Emailguid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(EmailGuid)
    End Function


    Public Function getStoreid() As String
        If Len(StoreID) = 0 Then
            MessageBox.Show("GET: Field 'Storeid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(StoreID)
    End Function


    Public Function getUserid() As String
        If Len(UserID) = 0 Then
            MessageBox.Show("GET: Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(UserID)
    End Function


    Public Function getMessageid() As String
        Return UTIL.RemoveSingleQuotes(MessageID)
    End Function






    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If EmailGuid.Length = 0 Then Return False
        If StoreID.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If EmailGuid.Length = 0 Then Return False
        If StoreID.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO EmailToDelete("
        s = s + "EmailGuid,"
        s = s + "StoreID,"
        s = s + "UserID,"
        s = s + "MessageID) values ("
        s = s + "'" + EmailGuid + "'" + ","
        s = s + "'" + StoreID + "'" + ","
        s = s + "'" + UserID + "'" + ","
        s = s + "'" + MessageID + "'" + ")"

        'log.WriteToArchiveLog("clsEMAILTODELETE: Insert : Marked for delete email '" + EmailGuid + "'")

        Return DBARCH.ExecuteSqlNewConn(s, False)


    End Function




    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        s = s + " update EmailToDelete set "
        s = s + "EmailGuid = '" + getEmailguid() + "'" + ", "
        s = s + "StoreID = '" + getStoreid() + "'" + ", "
        s = s + "UserID = '" + getUserid() + "'" + ", "
        s = s + "MessageID = '" + getMessageid() + "'"
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
        s = s + "EmailGuid,"
        s = s + "StoreID,"
        s = s + "UserID,"
        s = s + "MessageID "
        s = s + " FROM EmailToDelete"

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function




    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "EmailGuid,"
        s = s + "StoreID,"
        s = s + "UserID,"
        s = s + "MessageID "
        s = s + " FROM EmailToDelete"
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


        s = " Delete from EmailToDelete"
        s = s + WhereClause


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        s = s + " Delete from EmailToDelete"


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate Index Queries 


    '** Generate Index ROW Queries 


    ''' Build Index Where Caluses 
    '''
End Class

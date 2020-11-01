Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql


Public Class clsEXCLUDEFROM


    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging



    Dim FromEmailAddr As String = ""
    Dim SenderName As String = ""
    Dim UserID As String = ""




    '** Generate the SET methods 
    Public Sub setFromemailaddr(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Fromemailaddr' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        FromEmailAddr = val
    End Sub


    Public Sub setSendername(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Sendername' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        SenderName = val
    End Sub


    Public Sub setUserid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        UserID = val
    End Sub






    '** Generate the GET methods 
    Public Function getFromemailaddr() As String
        If Len(FromEmailAddr) = 0 Then
            MessageBox.Show("GET: Field 'Fromemailaddr' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(FromEmailAddr)
    End Function


    Public Function getSendername() As String
        If Len(SenderName) = 0 Then
            MessageBox.Show("GET: Field 'Sendername' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(SenderName)
    End Function


    Public Function getUserid() As String
        If Len(UserID) = 0 Then
            MessageBox.Show("GET: Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(UserID)
    End Function






    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If FromEmailAddr.Length = 0 Then Return False
        If SenderName.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If FromEmailAddr.Length = 0 Then Return False
        If SenderName.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO ExcludeFrom("
        s = s + "FromEmailAddr,"
        s = s + "SenderName,"
        s = s + "UserID) values ("
        s = s + "'" + FromEmailAddr + "'" + ","
        s = s + "'" + SenderName + "'" + ","
        s = s + "'" + UserID + "'" + ")"
        Return DBARCH.ExecuteSqlNewConn(s, False)


    End Function




    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        s = s + " update ExcludeFrom set "
        s = s + "FromEmailAddr = '" + getFromemailaddr() + "'" + ", "
        s = s + "SenderName = '" + getSendername() + "'" + ", "
        s = s + "UserID = '" + getUserid() + "'"
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
        s = s + "FromEmailAddr,"
        s = s + "SenderName,"
        s = s + "UserID "
        s = s + " FROM ExcludeFrom"

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function




    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "FromEmailAddr,"
        s = s + "SenderName,"
        s = s + "UserID "
        s = s + " FROM ExcludeFrom"
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


        s = " Delete from ExcludeFrom"
        s = s + WhereClause


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        s = s + " Delete from ExcludeFrom"


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate Index Queries 
    Public Function cnt_Pi01_ExcludeFrom(ByVal FromEmailAddr As String, ByVal UserID As String) As Integer


        Dim B As Integer = 0
        Dim TBL As String = "ExcludeFrom"
        Dim WC As String = "Where FromEmailAddr = '" + FromEmailAddr + "' and   UserID = '" + UserID + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_Pi01_ExcludeFrom
    Public Function cnt_PK_ExcludeFrom(ByVal FromEmailAddr As String, ByVal SenderName As String, ByVal UserID As String) As Integer


        Dim B As Integer = 0
        Dim TBL As String = "ExcludeFrom"
        Dim WC As String = "Where FromEmailAddr = '" + FromEmailAddr + "' and   SenderName = '" + SenderName + "' and   UserID = '" + UserID + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_PK_ExcludeFrom


    '** Generate Index ROW Queries 
    Public Function getRow_Pi01_ExcludeFrom(ByVal FromEmailAddr As String, ByVal UserID As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "ExcludeFrom"
        Dim WC As String = "Where FromEmailAddr = '" + FromEmailAddr + "' and   UserID = '" + UserID + "'"


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_Pi01_ExcludeFrom
    Public Function getRow_PK_ExcludeFrom(ByVal FromEmailAddr As String, ByVal SenderName As String, ByVal UserID As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "ExcludeFrom"
        Dim WC As String = "Where FromEmailAddr = '" + FromEmailAddr + "' and   SenderName = '" + SenderName + "' and   UserID = '" + UserID + "'"


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK_ExcludeFrom


    ''' Build Index Where Caluses 
    '''
    Public Function wc_Pi01_ExcludeFrom(ByVal FromEmailAddr As String, ByVal UserID As String) As String


Dim WC AS String  = "Where FromEmailAddr = '" + FromEmailAddr + "' and   UserID = '" + UserID + "'" 


        Return WC
    End Function     '** wc_Pi01_ExcludeFrom
    Public Function wc_PK_ExcludeFrom(ByVal FromEmailAddr As String, ByVal SenderName As String, ByVal UserID As String) As String


Dim WC AS String  = "Where FromEmailAddr = '" + FromEmailAddr + "' and   SenderName = '" + SenderName + "' and   UserID = '" + UserID + "'" 


        Return WC
    End Function     '** wc_PK_ExcludeFrom
End Class

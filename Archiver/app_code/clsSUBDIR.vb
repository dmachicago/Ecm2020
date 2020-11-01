Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql


Public Class clsSUBDIR


    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim UserID As String = ""
    Dim SUBFQN As String = ""
    Dim FQN As String = ""
    Dim ckPublic As String = ""
    Dim ckDisableDir As String = ""
    Dim OcrDirectory As String = ""




    '** Generate the SET methods 
    Public Sub setOcrDirectory(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        OcrDirectory = val
    End Sub


    Public Sub setUserid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        UserID = val
    End Sub


    Public Sub setSubfqn(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Subfqn' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        SUBFQN = val
    End Sub


    Public Sub setFqn(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Fqn' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        FQN = val
    End Sub


    Public Sub setCkpublic(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ckPublic = val
    End Sub


    Public Sub setCkdisabledir(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ckDisableDir = val
    End Sub






    '** Generate the GET methods 
    Public Function getUserid() As String
        If Len(UserID) = 0 Then
            MessageBox.Show("GET: Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(UserID)
    End Function


    Public Function getSubfqn() As String
        If Len(SUBFQN) = 0 Then
            MessageBox.Show("GET: Field 'Subfqn' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(SUBFQN)
    End Function


    Public Function getFqn() As String
        If Len(FQN) = 0 Then
            MessageBox.Show("GET: Field 'Fqn' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(FQN)
    End Function


    Public Function getCkpublic() As String
        Return UTIL.RemoveSingleQuotes(ckPublic)
    End Function


    Public Function getCkdisabledir() As String
        Return UTIL.RemoveSingleQuotes(ckDisableDir)
    End Function






    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If UserID.Length = 0 Then Return False
        If SUBFQN.Length = 0 Then Return False
        If FQN.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If UserID.Length = 0 Then Return False
        If SUBFQN.Length = 0 Then Return False
        If FQN.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        If OcrDirectory.Length = 0 Then
            MessageBox.Show("OcrDirectory  must be set to either Y or N")
        End If
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO SubDir("
        s = s + "UserID,"
        s = s + "SUBFQN,"
        s = s + "FQN,"
        s = s + "ckPublic,"
        s = s + "ckDisableDir,OcrDirectory) values ("
        s = s + "'" + UserID + "'" + ","
        s = s + "'" + SUBFQN + "'" + ","
        s = s + "'" + FQN + "'" + ","
        s = s + "'" + ckPublic + "'" + ","
        s = s + "'" + ckDisableDir + "'" + ","
        s = s + "'" + OcrDirectory + "'" + ")"
        Return DBARCH.ExecuteSqlNewConn(s, False)


    End Function




    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If OcrDirectory.Length = 0 Then
            MessageBox.Show("OcrDirectory  must be set to either Y or N")
        End If
        If Len(WhereClause) = 0 Then Return False


        s = s + " update SubDir set "
        s = s + "UserID = '" + getUserid() + "'" + ", "
        s = s + "SUBFQN = '" + getSubfqn() + "'" + ", "
        s = s + "FQN = '" + getFqn() + "'" + ", "
        s = s + "ckPublic = '" + getCkpublic() + "'" + ", "
        s = s + "ckDisableDir = '" + getCkdisabledir() + "'"
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
        s = s + "SUBFQN,"
        s = s + "FQN,"
        s = s + "ckPublic,"
        s = s + "ckDisableDir "
        s = s + " FROM SubDir"

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function




    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "UserID,"
        s = s + "SUBFQN,"
        s = s + "FQN,"
        s = s + "ckPublic,"
        s = s + "ckDisableDir "
        s = s + " FROM SubDir"
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


        s = " Delete from SubDir"
        s = s + WhereClause


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        s = s + " Delete from SubDir"


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate Index Queries 
    Public Function cnt_PKI14(ByVal FQN As String, ByVal SUBFQN As String, ByVal UserID As String) As Integer


        Dim B As Integer = 0
        Dim TBL As String = "SubDir"
        Dim WC As String = "Where FQN = '" + FQN + "' and   SUBFQN = '" + SUBFQN + "' and   UserID = '" + UserID + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_PKI14


    '** Generate Index ROW Queries 
    Public Function getRow_PKI14(ByVal FQN As String, ByVal SUBFQN As String, ByVal UserID As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "SubDir"
        Dim WC As String = "Where FQN = '" + FQN + "' and   SUBFQN = '" + SUBFQN + "' and   UserID = '" + UserID + "'"


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PKI14


    ''' Build Index Where Caluses 
    '''
    Public Function wc_PKI14(ByVal FQN As String, ByVal SUBFQN As String, ByVal UserID As String) As String


Dim WC AS String  = "Where FQN = '" + FQN + "' and   SUBFQN = '" + SUBFQN + "' and   UserID = '" + UserID + "'" 


        Return WC
    End Function     '** wc_PKI14
End Class

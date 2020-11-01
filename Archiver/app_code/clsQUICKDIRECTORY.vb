Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql


Public Class clsQUICKDIRECTORY


    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim UserID As String = ""
    Dim IncludeSubDirs As String = ""
    Dim FQN As String = ""
    Dim DB_ID As String = ""
    Dim VersionFiles As String = ""
    Dim ckMetaData As String = ""
    Dim ckPublic As String = ""
    Dim ckDisableDir As String = ""
    Dim QuickRefEntry As String = ""




    '** Generate the SET methods 
    Public Sub setUserid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        UserID = val
    End Sub


    Public Sub setIncludesubdirs(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        IncludeSubDirs = val
    End Sub


    Public Sub setFqn(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Fqn' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        FQN = val
    End Sub


    Public Sub setDb_id(ByRef val As String)
        If Len(val) = 0 Then
            val = "ECM.Library"
            'messagebox.show("SET: Field 'Db_id' cannot be NULL.")
            'Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        DB_ID = val
    End Sub


    Public Sub setVersionfiles(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        VersionFiles = val
    End Sub


    Public Sub setCkmetadata(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ckMetaData = val
    End Sub


    Public Sub setCkpublic(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ckPublic = val
    End Sub


    Public Sub setCkdisabledir(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ckDisableDir = val
    End Sub


    Public Sub setQuickrefentry(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        QuickRefEntry = val
    End Sub






    '** Generate the GET methods 
    Public Function getUserid() As String
        If Len(UserID) = 0 Then
            MessageBox.Show("GET: Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(UserID)
    End Function


    Public Function getIncludesubdirs() As String
        Return UTIL.RemoveSingleQuotes(IncludeSubDirs)
    End Function


    Public Function getFqn() As String
        If Len(FQN) = 0 Then
            MessageBox.Show("GET: Field 'Fqn' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(FQN)
    End Function


    Public Function getDb_id() As String
        If Len(DB_ID) = 0 Then
            'messagebox.show("GET: Field 'Db_id' cannot be NULL.")
            Return "ECM.Library"
        End If
        Return UTIL.RemoveSingleQuotes(DB_ID)
    End Function


    Public Function getVersionfiles() As String
        Return UTIL.RemoveSingleQuotes(VersionFiles)
    End Function


    Public Function getCkmetadata() As String
        Return UTIL.RemoveSingleQuotes(ckMetaData)
    End Function


    Public Function getCkpublic() As String
        Return UTIL.RemoveSingleQuotes(ckPublic)
    End Function


    Public Function getCkdisabledir() As String
        Return UTIL.RemoveSingleQuotes(ckDisableDir)
    End Function


    Public Function getQuickrefentry() As String
        If Len(QuickRefEntry) = 0 Then
            QuickRefEntry = "null"
        End If
        Return QuickRefEntry
    End Function






    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If UserID.Length = 0 Then Return False
        If FQN.Length = 0 Then Return False
        If DB_ID.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If UserID.Length = 0 Then Return False
        If FQN.Length = 0 Then Return False
        If DB_ID.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO QuickDirectory("
        s = s + "UserID,"
        s = s + "IncludeSubDirs,"
        s = s + "FQN,"
        s = s + "DB_ID,"
        s = s + "VersionFiles,"
        s = s + "ckMetaData,"
        s = s + "ckPublic,"
        s = s + "ckDisableDir,"
        s = s + "QuickRefEntry) values ("
        s = s + "'" + UserID + "'" + ","
        s = s + "'" + IncludeSubDirs + "'" + ","
        s = s + "'" + FQN + "'" + ","
        s = s + "'" + DB_ID + "'" + ","
        s = s + "'" + VersionFiles + "'" + ","
        s = s + "'" + ckMetaData + "'" + ","
        s = s + "'" + ckPublic + "'" + ","
        s = s + "'" + ckDisableDir + "'" + ","
        s = s + QuickRefEntry + ")"
        Return DBARCH.ExecuteSqlNewConn(s, False)


    End Function




    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        s = s + " update QuickDirectory set "
        s = s + "UserID = '" + getUserid() + "'" + ", "
        s = s + "IncludeSubDirs = '" + getIncludesubdirs() + "'" + ", "
        s = s + "FQN = '" + getFqn() + "'" + ", "
        s = s + "DB_ID = '" + getDb_id() + "'" + ", "
        s = s + "VersionFiles = '" + getVersionfiles() + "'" + ", "
        s = s + "ckMetaData = '" + getCkmetadata() + "'" + ", "
        s = s + "ckPublic = '" + getCkpublic() + "'" + ", "
        s = s + "ckDisableDir = '" + getCkdisabledir() + "'" + ", "
        s = s + "QuickRefEntry = " + getQuickrefentry()
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
        s = s + "IncludeSubDirs,"
        s = s + "FQN,"
        s = s + "DB_ID,"
        s = s + "VersionFiles,"
        s = s + "ckMetaData,"
        s = s + "ckPublic,"
        s = s + "ckDisableDir,"
        s = s + "QuickRefEntry "
        s = s + " FROM QuickDirectory"

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
        s = s + "IncludeSubDirs,"
        s = s + "FQN,"
        s = s + "DB_ID,"
        s = s + "VersionFiles,"
        s = s + "ckMetaData,"
        s = s + "ckPublic,"
        s = s + "ckDisableDir,"
        s = s + "QuickRefEntry "
        s = s + " FROM QuickDirectory"
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


        s = " Delete from QuickDirectory"
        s = s + WhereClause


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        s = s + " Delete from QuickDirectory"


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate Index Queries 
    Public Function cnt_PKII2QD(ByVal FQN As String, ByVal UserID As String) As Integer


        Dim B As Integer = 0
        Dim TBL As String = "QuickDirectory"
        Dim WC As String = "Where FQN = '" + FQN + "' and   UserID = '" + UserID + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_PKII2QD


    '** Generate Index ROW Queries 
    Public Function getRow_PKII2QD(ByVal FQN As String, ByVal UserID As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "QuickDirectory"
        Dim WC As String = "Where FQN = '" + FQN + "' and   UserID = '" + UserID + "'"


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PKII2QD


    ''' Build Index Where Caluses 
    '''
    Public Function wc_PKII2QD(ByVal FQN As String, ByVal UserID As String) As String


Dim WC AS String  = "Where FQN = '" + FQN + "' and   UserID = '" + UserID + "'" 


        Return WC
    End Function     '** wc_PKII2QD


    '** Generate the SET methods 


End Class

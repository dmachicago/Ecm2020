Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql


Public Class clsEMAILARCHPARMS


    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma

    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim UserID As String = ""
    Dim ArchiveEmails As String = ""
    Dim RemoveAfterArchive As String = ""
    Dim SetAsDefaultFolder As String = ""
    Dim ArchiveAfterXDays As String = ""
    Dim RemoveAfterXDays As String = ""
    Dim RemoveXDays As String = ""
    Dim ArchiveXDays As String = ""
    Dim FolderName As String = ""
    Dim DB_ID As String = ""
    Dim ArchiveOnlyIfRead As String = ""
    Dim isSysDefault As String = ""




    '** Generate the SET methods 
    Public Sub setUserid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        UserID = val
    End Sub

    Public Sub setIsSysDefault(ByVal Val As String)
        Val = UTIL.RemoveSingleQuotes(Val)
        isSysDefault = Val
    End Sub

    Public Sub setArchiveemails(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ArchiveEmails = val
    End Sub


    Public Sub setRemoveafterarchive(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        RemoveAfterArchive = val
    End Sub


    Public Sub setSetasdefaultfolder(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        SetAsDefaultFolder = val
    End Sub


    Public Sub setArchiveafterxdays(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ArchiveAfterXDays = val
    End Sub


    Public Sub setRemoveafterxdays(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        RemoveAfterXDays = val
    End Sub


    Public Sub setRemovexdays(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        RemoveXDays = val
    End Sub


    Public Sub setArchivexdays(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        ArchiveXDays = val
    End Sub


    Public Sub setFoldername(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Foldername' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        FolderName = val
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


    Public Sub setArchiveonlyifread(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ArchiveOnlyIfRead = val
    End Sub






    '** Generate the GET methods 
    Public Function getUserid() As String
        If Len(UserID) = 0 Then
            MessageBox.Show("GET: Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(UserID)
    End Function


    Public Function getArchiveemails() As String
        Return UTIL.RemoveSingleQuotes(ArchiveEmails)
    End Function


    Public Function getRemoveafterarchive() As String
        Return UTIL.RemoveSingleQuotes(RemoveAfterArchive)
    End Function


    Public Function getSetasdefaultfolder() As String
        Return UTIL.RemoveSingleQuotes(SetAsDefaultFolder)
    End Function


    Public Function getArchiveafterxdays() As String
        Return UTIL.RemoveSingleQuotes(ArchiveAfterXDays)
    End Function


    Public Function getRemoveafterxdays() As String
        Return UTIL.RemoveSingleQuotes(RemoveAfterXDays)
    End Function


    Public Function getRemovexdays() As String
        If Len(RemoveXDays) = 0 Then
            RemoveXDays = "null"
        End If
        Return RemoveXDays
    End Function


    Public Function getArchivexdays() As String
        If Len(ArchiveXDays) = 0 Then
            ArchiveXDays = "null"
        End If
        Return ArchiveXDays
    End Function


    Public Function getFoldername() As String
        If Len(FolderName) = 0 Then
            MessageBox.Show("GET: Field 'Foldername' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(FolderName)
    End Function


    Public Function getDb_id() As String
        If Len(DB_ID) = 0 Then
            'messagebox.show("GET: Field 'Db_id' cannot be NULL.")
            Return "ECM.Library"
        End If
        Return UTIL.RemoveSingleQuotes(DB_ID)
    End Function


    Public Function getArchiveonlyifread() As String
        Return UTIL.RemoveSingleQuotes(ArchiveOnlyIfRead)
    End Function






    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If UserID.Length = 0 Then Return False
        If FolderName.Length = 0 Then Return False
        If DB_ID.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If UserID.Length = 0 Then Return False
        If FolderName.Length = 0 Then Return False
        If DB_ID.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the INSERT method 
    Public Function Insert(ByVal FileDirectory As String) As Boolean

        FileDirectory = UTIL.RemoveSingleQuotes(FileDirectory)

        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO EmailArchParms("
        s = s + "UserID,"
        s = s + "ArchiveEmails,"
        s = s + "RemoveAfterArchive,"
        s = s + "SetAsDefaultFolder,"
        s = s + "ArchiveAfterXDays,"
        s = s + "RemoveAfterXDays,"
        s = s + "RemoveXDays,"
        s = s + "ArchiveXDays,"
        s = s + "FolderName,"
        s = s + "DB_ID,"
        s = s + "ArchiveOnlyIfRead,isSysDefault, FileDirectory) values ("
        s = s + "'" + UserID + "'" + ","
        s = s + "'" + ArchiveEmails + "'" + ","
        s = s + "'" + RemoveAfterArchive + "'" + ","
        s = s + "'" + SetAsDefaultFolder + "'" + ","
        s = s + "'" + ArchiveAfterXDays + "'" + ","
        s = s + "'" + RemoveAfterXDays + "'" + ","
        s = s + RemoveXDays + ","
        If ArchiveXDays.Trim.Length = 0 Then
            ArchiveXDays = "30"
        End If
        s = s + ArchiveXDays + ","
        s = s + "'" + FolderName + "'" + ","
        s = s + "'" + DB_ID + "'" + ","
        s = s + "'" + ArchiveOnlyIfRead + "', "
        s = s + isSysDefault + ", "
        s = s + "'" + FileDirectory + "')"
        Return DBARCH.ExecuteSqlNewConn(s, False)


    End Function




    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        s = s + " update EmailArchParms set "
        s = s + "UserID = '" + getUserid() + "'" + ", "
        s = s + "ArchiveEmails = '" + getArchiveemails() + "'" + ", "
        s = s + "RemoveAfterArchive = '" + getRemoveafterarchive() + "'" + ", "
        s = s + "SetAsDefaultFolder = '" + getSetasdefaultfolder() + "'" + ", "
        s = s + "ArchiveAfterXDays = '" + getArchiveafterxdays() + "'" + ", "
        s = s + "RemoveAfterXDays = '" + getRemoveafterxdays() + "'" + ", "
        s = s + "RemoveXDays = " + getRemovexdays() + ", "
        s = s + "ArchiveXDays = " + getArchivexdays() + ", "
        s = s + "FolderName = '" + getFoldername() + "'" + ", "
        s = s + "DB_ID = '" + getDb_id() + "'" + ", "
        s = s + "ArchiveOnlyIfRead = '" + getArchiveonlyifread() + "', "
        s = s + "isSysDefault = " + isSysDefault + " "
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
        s = s + "ArchiveEmails,"
        s = s + "RemoveAfterArchive,"
        s = s + "SetAsDefaultFolder,"
        s = s + "ArchiveAfterXDays,"
        s = s + "RemoveAfterXDays,"
        s = s + "RemoveXDays,"
        s = s + "ArchiveXDays,"
        s = s + "FolderName,"
        s = s + "DB_ID,"
        s = s + "ArchiveOnlyIfRead "
        s = s + " FROM EmailArchParms"

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
        s = s + "ArchiveEmails,"
        s = s + "RemoveAfterArchive,"
        s = s + "SetAsDefaultFolder,"
        s = s + "ArchiveAfterXDays,"
        s = s + "RemoveAfterXDays,"
        s = s + "RemoveXDays,"
        s = s + "ArchiveXDays,"
        s = s + "FolderName,"
        s = s + "DB_ID,"
        s = s + "ArchiveOnlyIfRead "
        s = s + " FROM EmailArchParms"
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


        s = " Delete from EmailArchParms"
        s = s + WhereClause


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        s = s + " Delete from EmailArchParms"


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate Index Queries 
    Public Function cnt_PK5EmailArchParms(ByVal FolderName As String, ByVal UserID As String) As Integer


        Dim B As Integer = 0
        Dim TBL As String = "EmailArchParms"
        Dim WC As String = "Where FolderName = '" + FolderName + "' and   UserID = '" + UserID + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_PK5EmailArchParms


    '** Generate Index ROW Queries 
    Public Function getRow_PK5EmailArchParms(ByVal FolderName As String, ByVal UserID As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "EmailArchParms"
        Dim WC As String = "Where FolderName = '" + FolderName + "' and   UserID = '" + UserID + "'"


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK5EmailArchParms


    ''' Build Index Where Caluses 
    '''
    Public Function wc_PK5EmailArchParms(ByVal FolderName As String, ByVal UserID As String) As String


Dim WC AS String  = "Where FolderName = '" + FolderName + "' and   UserID = '" + UserID + "'" 


        Return WC
    End Function     '** wc_PK5EmailArchParms
End Class

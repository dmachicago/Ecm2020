Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsDIRECTORY

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
    Dim QuickRefEntry As String = "0"
    Dim OcrDirectory As String = ""
    Dim OcrPdf As String = ""
    Dim ArchiveBit As Boolean = False
    Dim DeleteOnArchive As String = ""

    'DeleteOnArchive
    '** Generate the SET methods 
    Public Sub setDeleteOnArchive(ByRef val As String)
        DeleteOnArchive = val
    End Sub
    Public Sub setSkipIfArchiveBit(ByRef val As String)
        If val.ToUpper.Equals("TRUE") Then
            ArchiveBit = True
        Else
            ArchiveBit = False
        End If
    End Sub
    Public Sub setOcrPdf(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        OcrPdf = val
    End Sub
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
    Public Sub setQuickRefEntry(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        QuickRefEntry = val
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



    '** Generate the GET methods 
    Public Function getUserid() As String
        If Len(UserID) = 0 Then
            MessageBox.Show("GET: Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(UserID)
    End Function

    Public Function getIncludesubdirs() As String
        If IncludeSubDirs.ToUpper.Equals("TRUE") Then
            IncludeSubDirs = "Y"
        End If
        If IncludeSubDirs.ToUpper.Equals("FALSE") Then
            IncludeSubDirs = "N"
        End If
        If IncludeSubDirs.ToUpper.Equals("1") Then
            IncludeSubDirs = "Y"
        End If
        If IncludeSubDirs.ToUpper.Equals("0") Then
            IncludeSubDirs = "N"
        End If

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
        If VersionFiles.ToUpper.Equals("TRUE") Then
            VersionFiles = "Y"
        End If
        If VersionFiles.ToUpper.Equals("FALSE") Then
            VersionFiles = "N"
        End If
        If VersionFiles.ToUpper.Equals("1") Then
            VersionFiles = "Y"
        End If
        If VersionFiles.ToUpper.Equals("0") Then
            VersionFiles = "N"
        End If

        Return UTIL.RemoveSingleQuotes(VersionFiles)
    End Function

    Public Function getCkmetadata() As String
        If ckMetaData.ToUpper.Equals("TRUE") Then
            ckMetaData = "Y"
        End If
        If ckMetaData.ToUpper.Equals("FALSE") Then
            ckMetaData = "N"
        End If
        If ckMetaData.ToUpper.Equals("1") Then
            ckMetaData = "Y"
        End If
        If ckMetaData.ToUpper.Equals("0") Then
            ckMetaData = "N"
        End If
        Return UTIL.RemoveSingleQuotes(ckMetaData)
    End Function

    Public Function getCkpublic() As String
        If ckPublic.ToUpper.Equals("TRUE") Then
            ckPublic = "Y"
        End If
        If ckPublic.ToUpper.Equals("FALSE") Then
            ckPublic = "N"
        End If
        If ckPublic.ToUpper.Equals("1") Then
            ckPublic = "Y"
        End If
        If ckPublic.ToUpper.Equals("0") Then
            ckPublic = "N"
        End If

        Return UTIL.RemoveSingleQuotes(ckPublic)
    End Function

    Public Function getCkdisabledir() As String
        Return UTIL.RemoveSingleQuotes(ckDisableDir)
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

        If QuickRefEntry.Length = 0 Then
            QuickRefEntry = "0"
        End If
        If OcrDirectory.Length = 0 Then
            MessageBox.Show("OcrDirectory must be set to either Y or N")
        End If

        FQN = FQN.Replace("'", "`")

        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO Directory("
        s = s + "UserID,"
        s = s + "IncludeSubDirs,"
        s = s + "FQN,"
        s = s + "DB_ID,"
        s = s + "VersionFiles,"
        s = s + "ckMetaData,"
        s = s + "ckPublic,"
        s = s + "ckDisableDir, QuickRefEntry, OcrDirectory, OcrPdf, ArchiveSkipBit, DeleteOnArchive) values ("
        s = s + "'" + UserID + "'" + ","
        s = s + "'" + IncludeSubDirs + "'" + ","
        s = s + "'" + FQN + "'" + ","
        s = s + "'" + DB_ID + "'" + ","
        s = s + "'" + VersionFiles + "'" + ","
        s = s + "'" + ckMetaData + "'" + ","
        s = s + "'" + ckPublic + "'" + ","
        s = s + "'" + ckDisableDir + "'" + ","
        s = s + "'" + QuickRefEntry + "'" + ","
        s = s + "'" + OcrDirectory + "'" + ","
        s = s + "'" + OcrPdf + "'" + ","
        If ArchiveBit = True Then
            s = s + "1" + ","
        Else
            s = s + "0" + ","
        End If
        s = s + "'" + DeleteOnArchive + "')"

        Return DBARCH.ExecuteSqlNewConn(s, False)

    End Function


    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String, ByVal OcrDirectory As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If OcrDirectory.Length = 0 Then
            MessageBox.Show("OcrDirectory must be set to either Y or N")
        End If

        If Len(WhereClause) = 0 Then Return False

        Dim ckDisableDir As String = getCkdisabledir()
        If ckDisableDir.ToUpper = "TRUE" Then
            ckDisableDir = "Y"
        End If
        If ckDisableDir.ToUpper = "FALSE" Then
            ckDisableDir = "N"
        End If
        If ckDisableDir.ToUpper = "1" Then
            ckDisableDir = "Y"
        End If
        If ckDisableDir.ToUpper = "0" Then
            ckDisableDir = "N"
        End If

        s = ""
        s = s + " update Directory set "
        s = s + "UserID = '" + getUserid() + "'" + ", "
        s = s + "IncludeSubDirs = '" + getIncludesubdirs() + "'" + ", "
        s = s + "FQN = '" + getFqn() + "'" + ", "
        s = s + "VersionFiles = '" + getVersionfiles() + "'" + ", "
        s = s + "ckMetaData = '" + getCkmetadata() + "'" + ", "
        s = s + "ckPublic = '" + getCkpublic() + "'" + ", "
        s = s + "ckDisableDir = '" + ckDisableDir + "',"
        s = s + "OcrDirectory = '" + OcrDirectory + "',"
        s = s + "OcrPdf = '" + OcrPdf + "',"
        If ArchiveBit = True Then
            s = s + "ArchiveSkipBit = 1, "
        Else
            s = s + "ArchiveSkipBit = 0, "
        End If
        s = s + "DeleteOnArchive = '" + DeleteOnArchive + "'"


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
        s = s + "ckDisableDir "
        s = s + " FROM Directory"

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
        s = s + "ckDisableDir "
        s = s + " FROM Directory"
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

        s = " Delete from Directory"
        s = s + WhereClause

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from Directory"

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate Index Queries 
    Public Function cnt_PKII2(ByVal FQN As String, ByVal UserID As String) As Integer

        Dim B As Integer = 0
        Dim TBL As String = "Directory"
        Dim WC As String = "Where FQN = '" + FQN + "' and   UserID = '" + UserID + "'"

        B = DBARCH.iGetRowCount(TBL, WC)

        Return B
    End Function     '** cnt_PKII2

    '** Generate Index ROW Queries 
    Public Function getRow_PKII2(ByVal FQN As String, ByVal UserID As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "Directory"
        Dim WC As String = "Where FQN = '" + FQN + "' and   UserID = '" + UserID + "'"

        rsData = DBARCH.GetRowByKey(TBL, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PKII2

    ''' Build Index Where Caluses 
    '''
    Public Function wc_PKII2(ByVal FQN As String, ByVal UserID As String) As String

Dim WC AS String  = "Where FQN = '" + FQN + "' and   UserID = '" + UserID + "'" 

        Return WC
    End Function     '** wc_PKII2
End Class

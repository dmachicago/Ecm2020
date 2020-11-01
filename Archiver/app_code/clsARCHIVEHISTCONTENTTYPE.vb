Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsARCHIVEHISTCONTENTTYPE

    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging


    Dim ArchiveID As String = ""
    Dim Directory As String = ""
    Dim FileType As String = ""
    Dim NbrFilesArchived As String = ""


    '** Generate the SET methods 
    Public Sub setArchiveid(ByRef val As String)
        If val.Length = 0 Then
            val = Guid.NewGuid.ToString
        End If
        If Len(val) = 0 Then
            If gRunUnattended = False Then MessageBox.Show("SET: Field 'Archiveid' cannot be NULL: 2100.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        ArchiveID = val
    End Sub

    Public Sub setDirectory(ByRef val As String)
        If Len(val) = 0 Then
            If gRunUnattended = False Then MessageBox.Show("SET: Field 'Directory' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        Directory = val
    End Sub

    Public Sub setFiletype(ByRef val As String)
        If Len(val) = 0 Then
            If gRunUnattended = False Then MessageBox.Show("SET: Field 'Filetype' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        FileType = val
    End Sub

    Public Sub setNbrfilesarchived(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        NbrFilesArchived = val
    End Sub



    '** Generate the GET methods 
    Public Function getArchiveid() As String
        If Len(ArchiveID) = 0 Then
            If gRunUnattended = False Then MessageBox.Show("GET: Field 'Archiveid' cannot be NULL: 2200.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(ArchiveID)
    End Function

    Public Function getDirectory() As String
        If Len(Directory) = 0 Then
            If gRunUnattended = False Then MessageBox.Show("GET: Field 'Directory' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(Directory)
    End Function

    Public Function getFiletype() As String
        If Len(FileType) = 0 Then
            If gRunUnattended = False Then MessageBox.Show("GET: Field 'Filetype' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(FileType)
    End Function

    Public Function getNbrfilesarchived() As String
        If Len(NbrFilesArchived) = 0 Then
            NbrFilesArchived = "null"
        End If
        Return NbrFilesArchived
    End Function



    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If ArchiveID.Length = 0 Then Return False
        If Directory.Length = 0 Then Return False
        If FileType.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If ArchiveID.Length = 0 Then Return False
        If Directory.Length = 0 Then Return False
        If FileType.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO ArchiveHistContentType("
        s = s + "ArchiveID,"
        s = s + "Directory,"
        s = s + "FileType,"
        s = s + "NbrFilesArchived) values ("
        s = s + "'" + ArchiveID + "'" + ","
        s = s + "'" + Directory + "'" + ","
        s = s + "'" + FileType + "'" + ","
        s = s + NbrFilesArchived + ")"
        Return DBARCH.ExecuteSqlNewConn(s, False)

    End Function


    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update ArchiveHistContentType set "
        s = s + "ArchiveID = '" + getArchiveid() + "'" + ", "
        s = s + "Directory = '" + getDirectory() + "'" + ", "
        s = s + "FileType = '" + getFiletype() + "'" + ", "
        s = s + "NbrFilesArchived = " + getNbrfilesarchived()
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
        s = s + "ArchiveID,"
        s = s + "Directory,"
        s = s + "FileType,"
        s = s + "NbrFilesArchived "
        s = s + " FROM ArchiveHistContentType"

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function


    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "ArchiveID,"
        s = s + "Directory,"
        s = s + "FileType,"
        s = s + "NbrFilesArchived "
        s = s + " FROM ArchiveHistContentType"
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

        s = " Delete from ArchiveHistContentType"
        s = s + WhereClause

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from ArchiveHistContentType"

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate Index Queries 
    Public Function cnt_PK111(ByVal ArchiveID As String, ByVal Directory As String, ByVal FileType As String) As Integer

        Dim B As Integer = 0
        Dim TBL As String = "ArchiveHistContentType"
        Dim WC As String = "Where ArchiveID = '" + ArchiveID + "' and   Directory = '" + Directory + "' and   FileType = '" + FileType + "'"

        B = DBARCH.iGetRowCount(TBL, WC)

        Return B
    End Function     '** cnt_PK111

    '** Generate Index ROW Queries 
    Public Function getRow_PK111(ByVal ArchiveID As String, ByVal Directory As String, ByVal FileType As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "ArchiveHistContentType"
        Dim WC As String = "Where ArchiveID = '" + ArchiveID + "' and   Directory = '" + Directory + "' and   FileType = '" + FileType + "'"

        rsData = DBARCH.GetRowByKey(TBL, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK111

    ''' Build Index Where Caluses 
    '''
    Public Function wc_PK111(ByVal ArchiveID As String, ByVal Directory As String, ByVal FileType As String) As String

Dim WC AS String  = "Where ArchiveID = '" + ArchiveID + "' and   Directory = '" + Directory + "' and   FileType = '" + FileType + "'" 

        Return WC
    End Function     '** wc_PK111

    '** Generate the SET methods 

End Class

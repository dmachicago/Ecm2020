Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsARCHIVEHIST

    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim LOG As New clsLogging
    Dim UTIL As New clsUtility

    Dim ArchiveID As String = ""
    Dim ArchiveDate As String = ""
    Dim NbrFilesArchived As String = ""
    Dim UserGuid As String = ""


    '** Generate the SET methods 
    Public Sub setArchiveid(ByRef val As String)
        If val.Length = 0 Then
            val = Guid.NewGuid.ToString
        End If
        If Len(val) = 0 Then
            MessageBox.Show("SET: Field 'Archiveid' cannot be NULL.: 2300")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        ArchiveID = val
    End Sub

    Public Sub setArchivedate(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        ArchiveDate = val
    End Sub

    Public Sub setNbrfilesarchived(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        NbrFilesArchived = val
    End Sub

    Public Sub setUserguid(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        UserGuid = val
    End Sub



    '** Generate the GET methods 
    Public Function getArchiveid() As String
        If Len(ArchiveID) = 0 Then
            MessageBox.Show("GET: Field 'Archiveid' cannot be NULL: 2400.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(ArchiveID)
    End Function

    Public Function getArchivedate() As String
        Return UTIL.RemoveSingleQuotes(ArchiveDate)
    End Function

    Public Function getNbrfilesarchived() As String
        If Len(NbrFilesArchived) = 0 Then
            NbrFilesArchived = "null"
        End If
        Return NbrFilesArchived
    End Function

    Public Function getUserguid() As String
        Return UTIL.RemoveSingleQuotes(UserGuid)
    End Function



    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If ArchiveID.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If ArchiveID.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO ArchiveHist("
        s = s + "ArchiveID,"
        s = s + "ArchiveDate,"
        s = s + "NbrFilesArchived,"
        s = s + "UserGuid) values ("
        s = s + "'" + ArchiveID + "'" + ","
        s = s + "'" + ArchiveDate + "'" + ","
        s = s + NbrFilesArchived + ","
        s = s + "'" + UserGuid + "'" + ")"
        Return DBARCH.ExecuteSqlNewConn(s, False)

    End Function


    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update ArchiveHist set "
        s = s + "ArchiveID = '" + getArchiveid() + "'" + ", "
        s = s + "ArchiveDate = '" + getArchivedate() + "'" + ", "
        s = s + "NbrFilesArchived = " + getNbrfilesarchived() + ", "
        s = s + "UserGuid = '" + getUserguid() + "'"
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
        s = s + "ArchiveDate,"
        s = s + "NbrFilesArchived,"
        s = s + "UserGuid "
        s = s + " FROM ArchiveHist"

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
        s = s + "ArchiveDate,"
        s = s + "NbrFilesArchived,"
        s = s + "UserGuid "
        s = s + " FROM ArchiveHist"
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

        s = " Delete from ArchiveHist"
        s = s + WhereClause

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from ArchiveHist"

        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate Index Queries 
    Public Function cnt_PK110(ByVal ArchiveID As String) As Integer

        Dim B As Integer = 0
        Dim TBL As String = "ArchiveHist"
        Dim WC As String = "Where ArchiveID = '" + ArchiveID + "'"

        B = DBARCH.iGetRowCount(TBL, WC)

        Return B
    End Function     '** cnt_PK110

    '** Generate Index ROW Queries 
    Public Function getRow_PK110(ByVal ArchiveID As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "ArchiveHist"
        Dim WC As String = "Where ArchiveID = '" + ArchiveID + "'"

        rsData = DBARCH.GetRowByKey(TBL, WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK110

    ''' Build Index Where Caluses 
    '''
    Public Function wc_PK110(ByVal ArchiveID As String) As String

Dim WC AS String  = "Where ArchiveID = '" + ArchiveID + "'" 

        Return WC
    End Function     '** wc_PK110

    '** Generate the SET methods 

End Class

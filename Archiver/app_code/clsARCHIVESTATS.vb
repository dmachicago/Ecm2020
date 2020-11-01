Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql
 
Public Class clsARCHIVESTATS
    Inherits clsDatabaseARCH
    '** DIM the selected table columns 
    'Dim DBARCH As New clsDatabaseARCH

    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging

    Dim ArchiveStartDate As String = ""
    Dim Status As String = ""
    Dim Successful As String = ""
    Dim ArchiveType As String = ""
    Dim TotalEmailsInRepository As String = ""
    Dim TotalContentInRepository As String = ""
    Dim UserID As String = ""
    Dim ArchiveEndDate As String = ""
    Dim StatGuid As String = ""
    Dim EntrySeq As String = ""


    '** Generate the SET methods 
    Public Sub setArchivestartdate(ByRef val AS String )
        val = UTIL.RemoveSingleQuotes(val)
        ArchiveStartDate = val
    End Sub

    Public Sub setStatus(ByRef val AS String )
        If Len(val) = 0 Then
            messagebox.show("SET: Field 'Status' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        Status = val
    End Sub

    Public Sub setSuccessful(ByRef val AS String )
        val = UTIL.RemoveSingleQuotes(val)
        Successful = val
    End Sub

    Public Sub setArchivetype(ByRef val AS String )
        If Len(val) = 0 Then
            messagebox.show("SET: Field 'Archivetype' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        ArchiveType = val
    End Sub

    Public Sub setTotalemailsinrepository(ByRef val AS String )
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        TotalEmailsInRepository = val
    End Sub

    Public Sub setTotalcontentinrepository(ByRef val AS String )
        If Len(val) = 0 Then
            val = "null"
        End If
        val = UTIL.RemoveSingleQuotes(val)
        TotalContentInRepository = val
    End Sub

    Public Sub setUserid(ByRef val AS String )
        If Len(val) = 0 Then
            messagebox.show("SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        UserID = val
    End Sub

    Public Sub setArchiveenddate(ByRef val AS String )
        val = UTIL.RemoveSingleQuotes(val)
        ArchiveEndDate = val
    End Sub

    Public Sub setStatguid(ByRef val AS String )
        If Len(val) = 0 Then
            messagebox.show("SET: Field 'Statguid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        StatGuid = val
    End Sub



    '** Generate the GET methods 
    Public Function getArchivestartdate() As String
        Return UTIL.RemoveSingleQuotes(ArchiveStartDate)
    End Function

    Public Function getStatus() As String
        If Len(Status) = 0 Then
            messagebox.show("GET: Field 'Status' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(Status)
    End Function

    Public Function getSuccessful() As String
        Return UTIL.RemoveSingleQuotes(Successful)
    End Function

    Public Function getArchivetype() As String
        If Len(ArchiveType) = 0 Then
            messagebox.show("GET: Field 'Archivetype' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(ArchiveType)
    End Function

    Public Function getTotalemailsinrepository() As String
        If Len(TotalEmailsInRepository) = 0 Then
            TotalEmailsInRepository = "null"
        End If
        Return TotalEmailsInRepository
    End Function

    Public Function getTotalcontentinrepository() As String
        If Len(TotalContentInRepository) = 0 Then
            TotalContentInRepository = "null"
        End If
        Return TotalContentInRepository
    End Function

    Public Function getUserid() As String
        If Len(UserID) = 0 Then
            messagebox.show("GET: Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(UserID)
    End Function

    Public Function getArchiveenddate() As String
        Return UTIL.RemoveSingleQuotes(ArchiveEndDate)
    End Function

    Public Function getStatguid() As String
        If Len(StatGuid) = 0 Then
            messagebox.show("GET: Field 'Statguid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(StatGuid)
    End Function

    Public Function getEntryseq() As String
        If Len(EntrySeq) = 0 Then
            messagebox.show("GET: Field 'Entryseq' cannot be NULL.")
            Return ""
        End If
        If Len(EntrySeq) = 0 Then
            EntrySeq = "null"
        End If
        Return EntrySeq
    End Function



    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If Status.Length = 0 Then Return False
        If ArchiveType.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        If StatGuid.Length = 0 Then Return False
        If EntrySeq.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If Status.Length = 0 Then Return False
        If ArchiveType.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        If StatGuid.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO ArchiveStats("
        s = s + "ArchiveStartDate,"
        s = s + "Status,"
        s = s + "Successful,"
        s = s + "ArchiveType,"
        s = s + "TotalEmailsInRepository,"
        s = s + "TotalContentInRepository,"
        s = s + "UserID,"
        s = s + "ArchiveEndDate,"
        s = s + "StatGuid) VALUES ("
        s = s + "'" + ArchiveStartDate + "'" + ","
        s = s + "'" + Status + "'" + ","
        s = s + "'" + Successful + "'" + ","
        s = s + "'" + ArchiveType + "'" + ","
        s = s + TotalEmailsInRepository + ","
        s = s + TotalContentInRepository + ","
        s = s + "'" + UserID + "'" + ","
        s = s + "'" + ArchiveEndDate + "'" + ","
        s = s + "'" + StatGuid + "'"
        s = s + EntrySeq + ")"
        Return ExecuteSqlNewConn(s, False)

    End Function


    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause AS String ) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update ArchiveStats set "
        s = s + "ArchiveStartDate = '" + getArchivestartdate() + "'" + ", "
        s = s + "Status = '" + getStatus() + "'" + ", "
        s = s + "Successful = '" + getSuccessful() + "'" + ", "
        s = s + "ArchiveType = '" + getArchivetype() + "'" + ", "
        s = s + "TotalEmailsInRepository = " + getTotalemailsinrepository() + ", "
        s = s + "TotalContentInRepository = " + getTotalcontentinrepository() + ", "
        s = s + "UserID = '" + getUserid() + "'" + ", "
        s = s + "ArchiveEndDate = '" + getArchiveenddate() + "'" + ", "
        s = s + "StatGuid = '" + getStatguid() + "'" + " "
        WhereClause = " " + WhereClause
        s = s + WhereClause
        Return ExecuteSqlNewConn(s, False)
    End Function


    '** Generate the SELECT method 
    Public Function SelectRecs() As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "ArchiveStartDate,"
        s = s + "Status,"
        s = s + "Successful,"
        s = s + "ArchiveType,"
        s = s + "TotalEmailsInRepository,"
        s = s + "TotalContentInRepository,"
        s = s + "UserID,"
        s = s + "ArchiveEndDate,"
        s = s + "StatGuid,"
        s = s + "EntrySeq "
        s = s + " FROM ArchiveStats"

        Dim CS As String = setConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function


    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "ArchiveStartDate,"
        s = s + "Status,"
        s = s + "Successful,"
        s = s + "ArchiveType,"
        s = s + "TotalEmailsInRepository,"
        s = s + "TotalContentInRepository,"
        s = s + "UserID,"
        s = s + "ArchiveEndDate,"
        s = s + "StatGuid,"
        s = s + "EntrySeq "
        s = s + " FROM ArchiveStats"
        s = s + WhereClause

        Dim CS As String = setConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader() 
        Return rsData
    End Function


    '** Generate the DELETE method 
    Public Function Delete(ByVal WhereClause AS String ) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        WhereClause = " " + WhereClause

        s = " Delete from ArchiveStats"
        s = s + WhereClause

        b = ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from ArchiveStats"

        b = ExecuteSqlNewConn(s, False)
        Return b

    End Function


    '** Generate Index Queries 
    Public Function cnt_PI01_ArchiveStats(ByVal ArchiveType As String, ByVal Status As String, ByVal UserID As String) As Integer

        Dim B As Integer = 0
Dim TBL AS String  = "ArchiveStats" 
Dim WC AS String  = "Where ArchiveType = '" + ArchiveType + "' and   Status = '" + Status + "' and   UserID = '" + UserID + "'" 

        B = iGetRowCount(TBL , WC)

        Return B
    End Function     '** cnt_PI01_ArchiveStats
    Public Function cnt_PI02_ArchiveStats(ByVal Status As String, ByVal UserID As String) As Integer

        Dim B As Integer = 0
Dim TBL AS String  = "ArchiveStats" 
Dim WC AS String  = "Where Status = '" + Status + "' and   UserID = '" + UserID + "'" 

        B = iGetRowCount(TBL , WC)

        Return B
    End Function     '** cnt_PI02_ArchiveStats
    Public Function cnt_PI03_ArchiveStats(ByVal ArchiveStartDate As DateTime, ByVal ArchiveType As String, ByVal UserID As String) As Integer

        Dim B As Integer = 0
Dim TBL AS String  = "ArchiveStats" 
Dim WC AS String  = "Where ArchiveStartDate = '" + ArchiveStartDate + "' and   ArchiveType = '" + ArchiveType + "' and   UserID = '" + UserID + "'" 

        B = iGetRowCount(TBL , WC)

        Return B
    End Function     '** cnt_PI03_ArchiveStats
    Public Function cnt_PI04_ArchiveStats(ByVal ArchiveType As String, ByVal UserID As String) As Integer

        Dim B As Integer = 0
Dim TBL AS String  = "ArchiveStats" 
Dim WC AS String  = "Where ArchiveType = '" + ArchiveType + "' and   UserID = '" + UserID + "'" 

        B = iGetRowCount(TBL , WC)

        Return B
    End Function     '** cnt_PI04_ArchiveStats
    Public Function cnt_PI05_ArchiveStats(ByVal EntrySeq As Integer) As Integer

        Dim B As Integer = 0
Dim TBL AS String  = "ArchiveStats" 
Dim WC AS String  = "Where EntrySeq = " & EntrySeq 

        B = iGetRowCount(TBL , WC)

        Return B
    End Function     '** cnt_PI05_ArchiveStats
    Public Function cnt_PK_ArchiveStats(ByVal StatGuid As String) As Integer

        Dim B As Integer = 0
Dim TBL AS String  = "ArchiveStats" 
Dim WC AS String  = "Where StatGuid = '" + StatGuid + "'" 

        B = iGetRowCount(TBL , WC)

        Return B
    End Function     '** cnt_PK_ArchiveStats

    '** Generate Index ROW Queries 
    Public Function getRow_PI01_ArchiveStats(ByVal ArchiveType As String, ByVal Status As String, ByVal UserID As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
Dim TBL AS String  = "ArchiveStats" 
Dim WC AS String  = "Where ArchiveType = '" + ArchiveType + "' and   Status = '" + Status + "' and   UserID = '" + UserID + "'" 

        rsData = GetRowByKey(TBL , WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PI01_ArchiveStats
    Public Function getRow_PI02_ArchiveStats(ByVal Status As String, ByVal UserID As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
Dim TBL AS String  = "ArchiveStats" 
Dim WC AS String  = "Where Status = '" + Status + "' and   UserID = '" + UserID + "'" 

        rsData = GetRowByKey(TBL , WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PI02_ArchiveStats
    Public Function getRow_PI03_ArchiveStats(ByVal ArchiveStartDate As DateTime, ByVal ArchiveType As String, ByVal UserID As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
Dim TBL AS String  = "ArchiveStats" 
Dim WC AS String  = "Where ArchiveStartDate = '" + ArchiveStartDate + "' and   ArchiveType = '" + ArchiveType + "' and   UserID = '" + UserID + "'" 

        rsData = GetRowByKey(TBL , WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PI03_ArchiveStats
    Public Function getRow_PI04_ArchiveStats(ByVal ArchiveType As String, ByVal UserID As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
Dim TBL AS String  = "ArchiveStats" 
Dim WC AS String  = "Where ArchiveType = '" + ArchiveType + "' and   UserID = '" + UserID + "'" 

        rsData = GetRowByKey(TBL , WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PI04_ArchiveStats
    Public Function getRow_PI05_ArchiveStats(ByVal EntrySeq As Integer) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
Dim TBL AS String  = "ArchiveStats" 
Dim WC AS String  = "Where EntrySeq = " & EntrySeq 

        rsData = GetRowByKey(TBL , WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PI05_ArchiveStats
    Public Function getRow_PK_ArchiveStats(ByVal StatGuid As String) As SqlDataReader

        Dim rsData As SqlDataReader = Nothing
Dim TBL AS String  = "ArchiveStats" 
Dim WC AS String  = "Where StatGuid = '" + StatGuid + "'" 

        rsData = GetRowByKey(TBL , WC)

        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK_ArchiveStats

    ''' Build Index Where Caluses 
    '''
    Public Function wc_PI01_ArchiveStats(ByVal ArchiveType As String, ByVal Status As String, ByVal UserID As String) As String

Dim WC AS String  = "Where ArchiveType = '" + ArchiveType + "' and   Status = '" + Status + "' and   UserID = '" + UserID + "'" 

        Return WC
    End Function     '** wc_PI01_ArchiveStats
    Public Function wc_PI02_ArchiveStats(ByVal Status As String, ByVal UserID As String) As String

Dim WC AS String  = "Where Status = '" + Status + "' and   UserID = '" + UserID + "'" 

        Return WC
    End Function     '** wc_PI02_ArchiveStats
    Public Function wc_PI03_ArchiveStats(ByVal ArchiveStartDate As DateTime, ByVal ArchiveType As String, ByVal UserID As String) As String

Dim WC AS String  = "Where ArchiveStartDate = '" + ArchiveStartDate + "' and   ArchiveType = '" + ArchiveType + "' and   UserID = '" + UserID + "'" 

        Return WC
    End Function     '** wc_PI03_ArchiveStats
    Public Function wc_PI04_ArchiveStats(ByVal ArchiveType As String, ByVal UserID As String) As String

Dim WC AS String  = "Where ArchiveType = '" + ArchiveType + "' and   UserID = '" + UserID + "'" 

        Return WC
    End Function     '** wc_PI04_ArchiveStats
    Public Function wc_PI05_ArchiveStats(ByVal EntrySeq As Integer) As String

Dim WC AS String  = "Where EntrySeq = " & EntrySeq 

        Return WC
    End Function     '** wc_PI05_ArchiveStats
    Public Function wc_PK_ArchiveStats(ByVal StatGuid As String) As String

Dim WC AS String  = "Where StatGuid = '" + StatGuid + "'" 

        Return WC
    End Function     '** wc_PK_ArchiveStats
End Class

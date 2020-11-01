Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports System.Data.Sql


Public Class clsLIBDIRECTORY


    '** DIM the selected table columns 
    Dim DBARCH As New clsDatabaseARCH
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging



    Dim DirectoryName As String = ""
    Dim UserID As String = ""
    Dim LibraryName As String = ""




    '** Generate the SET methods 
    Public Sub setDirectoryname(ByRef val As String)
        If Len(val) = 0 Then
            If gRunUnattended = False Then MessageBox.Show("SET: Field 'Directoryname' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        DirectoryName = val
    End Sub


    Public Sub setUserid(ByRef val As String)
        If Len(val) = 0 Then
            If gRunUnattended = False Then MessageBox.Show("SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        UserID = val
    End Sub


    Public Sub setLibraryname(ByRef val As String)
        If Len(val) = 0 Then
            If gRunUnattended = False Then MessageBox.Show("SET: Field 'Libraryname' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        LibraryName = val
    End Sub

    '** Generate the GET methods 
    Public Function getDirectoryname() As String
        If Len(DirectoryName) = 0 Then
            If gRunUnattended = False Then If gRunUnattended = False Then MessageBox.Show("GET: Field 'Directoryname' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(DirectoryName)
    End Function


    Public Function getUserid() As String
        If Len(UserID) = 0 Then
            If gRunUnattended = False Then If gRunUnattended = False Then MessageBox.Show("GET: Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(UserID)
    End Function


    Public Function getLibraryname() As String
        If Len(LibraryName) = 0 Then
            If gRunUnattended = False Then If gRunUnattended = False Then MessageBox.Show("GET: Field 'Libraryname' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(LibraryName)
    End Function






    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If DirectoryName.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        If LibraryName.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If DirectoryName.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        If LibraryName.Length = 0 Then Return False
        Return True
    End Function




    '** Generate the INSERT method 
    Public Function Insert() As Boolean

        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO LibDirectory("
        s = s + "DirectoryName,"
        s = s + "UserID,"
        s = s + "LibraryName) values ("
        s = s + "'" + DirectoryName + "'" + ","
        s = s + "'" + UserID + "'" + ","
        s = s + "'" + LibraryName + "'" + ")"
        Return DBARCH.ExecuteSqlNewConn(s, False)


    End Function




    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        s = s + " update LibDirectory set "
        s = s + "DirectoryName = '" + getDirectoryname() + "'" + ", "
        s = s + "UserID = '" + getUserid() + "'" + ", "
        s = s + "LibraryName = '" + getLibraryname() + "'"
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
        s = s + "DirectoryName,"
        s = s + "UserID,"
        s = s + "LibraryName "
        s = s + " FROM LibDirectory"

        Dim CS As String = DBARCH.setConnStr()     'DBARCH.getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(s, CONN) : rsData = command.ExecuteReader()
        Return rsData
    End Function




    '** Generate the Select One Row method 
    Public Function SelectOne(ByVal WhereClause As String) As SqlDataReader
        Dim b As Boolean = False
        Dim s As String = ""
        Dim rsData As SqlDataReader
        s = s + " SELECT "
        s = s + "DirectoryName,"
        s = s + "UserID,"
        s = s + "LibraryName "
        s = s + " FROM LibDirectory"
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


        s = " Delete from LibDirectory"
        s = s + WhereClause


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        s = s + " Delete from LibDirectory"


        b = DBARCH.ExecuteSqlNewConn(s, False)
        Return b


    End Function




    '** Generate Index Queries 
    Public Function cnt_PK98(ByVal DirectoryName As String, ByVal LibraryName As String, ByVal UserID As String) As Integer


        Dim B As Integer = 0
        Dim TBL As String = "LibDirectory"
        Dim WC As String = "Where DirectoryName = '" + DirectoryName + "' and   LibraryName = '" + LibraryName + "' and   UserID = '" + UserID + "'"


        B = DBARCH.iGetRowCount(TBL, WC)


        Return B
    End Function     '** cnt_PK98


    '** Generate Index ROW Queries 
    Public Function getRow_PK98(ByVal DirectoryName As String, ByVal LibraryName As String, ByVal UserID As String) As SqlDataReader


        Dim rsData As SqlDataReader = Nothing
        Dim TBL As String = "LibDirectory"
        Dim WC As String = "Where DirectoryName = '" + DirectoryName + "' and   LibraryName = '" + LibraryName + "' and   UserID = '" + UserID + "'"


        rsData = DBARCH.GetRowByKey(TBL, WC)


        If rsData.HasRows Then
            Return rsData
        Else
            Return Nothing
        End If
    End Function     '** getRow_PK98


    ''' Build Index Where Caluses 
    '''
    Public Function wc_PK98(ByVal DirectoryName As String, ByVal LibraryName As String, ByVal UserID As String) As String


        'Dim WC  = "Where DirectoryName = '" + DirectoryName + "' and   LibraryName = '" + LibraryName + "' and   UserID = '" + UserID + "'"
Dim WC AS String  = "Where DirectoryName = '" + DirectoryName + "' and   LibraryName = '" + LibraryName + "' " 


        Return WC
    End Function     '** wc_PK98


    '** Generate the SET methods 


End Class

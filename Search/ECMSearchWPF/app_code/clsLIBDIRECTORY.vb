Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
'Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports ECMEncryption

Public Class clsLIBDIRECTORY


    'Dim proxy As New SVCSearch.Service1Client
    'Dim EP As New clsEndPoint
    '** DIM the selected table columns 
    'Dim DB As New clsDatabase
    'Dim DMA As New clsDma
    'Dim UTIL As New clsUtility
    Dim LOG As New clsLogMain
    Dim ENC2 As New ECMEncrypt()

    Dim DirectoryName As String = ""
    Dim UserID As String = ""
    Dim LibraryName As String = ""
    Dim gSecureID As String = -1

    Sub New()

        gSecureID = _SecureID
        ''AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
        'EP.setSearchSvcEndPoint(proxy)

    End Sub

    '** Generate the SET methods 
    Public Sub setDirectoryname(ByRef val As String)
        If Len(val) = 0 Then
            If gRunUnattended = False Then MessageBox.Show("SET: clsLIBDIRECTORYField 'Directoryname' cannot be NULL.")
            Return
        End If
        val = val.Replace("''", "'")
        val = val.Replace("'", "''")
        DirectoryName = val
    End Sub


    Public Sub setUserid(ByRef val As String)
        If Len(val) = 0 Then
            If gRunUnattended = False Then MessageBox.Show("SET: clsLIBDIRECTORYField 'Userid' cannot be NULL.")
            Return
        End If
        val = val.Replace("''", "'")
        val = val.Replace("'", "''")
        UserID = val
    End Sub


    Public Sub setLibraryname(ByRef val As String)
        If Len(val) = 0 Then
            If gRunUnattended = False Then MessageBox.Show("SET: clsLIBDIRECTORYField 'Libraryname' cannot be NULL.")
            Return
        End If
        val = val.Replace("''", "'")
        val = val.Replace("'", "''")
        LibraryName = val
    End Sub

    '** Generate the GET methods 
    Public Function getDirectoryname() As String
        If Len(DirectoryName) = 0 Then
            If gRunUnattended = False Then If gRunUnattended = False Then MessageBox.Show("GET: clsLIBDIRECTORYField Field 'Directoryname' cannot be NULL.")
            Return ""
        End If
        Return DirectoryName.Replace("''", "'")
    End Function


    Public Function getUserid() As String
        If Len(UserID) = 0 Then
            If gRunUnattended = False Then If gRunUnattended = False Then MessageBox.Show("GET: clsLIBDIRECTORYField Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UserID.Replace("''", "'")
    End Function


    Public Function getLibraryname() As String
        If Len(LibraryName) = 0 Then
            If gRunUnattended = False Then If gRunUnattended = False Then MessageBox.Show("GET: clsLIBDIRECTORYField Field 'Libraryname' cannot be NULL.")
            Return ""
        End If
        Return LibraryName.Replace("''", "'")
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

        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(gSecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))
        Return True

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

        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(gSecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))
        Return True

    End Function




    ''** Generate the SELECT method 
    'Public Function SelectRecs() As SqlDataReader
    '    Dim b As Boolean = False
    '    Dim s As String = ""
    '    Dim rsData As SqlDataReader
    '    s = s + " SELECT "
    '    s = s + "DirectoryName,"
    '    s = s + "UserID,"
    '    s = s + "LibraryName "
    '    s = s + " FROM LibDirectory"

    '    Dim CS$ = db.getConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata = command.ExecuteReader()
    '    Return rsData
    'End Function




    ''** Generate the Select One Row method 
    'Public Function SelectOne(ByVal WhereClause as string) As SqlDataReader
    '    Dim b As Boolean = False
    '    Dim s As String = ""
    '    Dim rsData As SqlDataReader
    '    s = s + " SELECT "
    '    s = s + "DirectoryName,"
    '    s = s + "UserID,"
    '    s = s + "LibraryName "
    '    s = s + " FROM LibDirectory"
    '    s = s + WhereClause

    '    Dim CS$ = db.getConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata = command.ExecuteReader()
    '    Return rsData
    'End Function




    '** Generate the DELETE method 
    Public Function Delete(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return False


        WhereClause = " " + WhereClause


        s = " Delete from LibDirectory"
        s = s + WhereClause

        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(gSecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))
        Return True


    End Function




    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""


        s = s + " Delete from LibDirectory"

        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(gSecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))
        Return True


    End Function




    ''** Generate Index Queries 
    'Public Function cnt_PK98(ByVal DirectoryName As String, ByVal LibraryName As String, ByVal UserID As String) As Integer


    '    Dim B As Integer = 0
    '    Dim TBL$ = "LibDirectory"
    '    Dim WC$ = "Where DirectoryName = '" + DirectoryName + "' and   LibraryName = '" + LibraryName + "' and   UserID = '" + UserID + "'"


    '    B = DB.iGetRowCount(TBL$, WC)


    '    Return B
    'End Function     '** cnt_PK98


    ''** Generate Index ROW Queries 
    'Public Function getRow_PK98(ByVal DirectoryName As String, ByVal LibraryName As String, ByVal UserID As String) As SqlDataReader


    '    Dim rsData As SqlDataReader = Nothing
    '    Dim TBL$ = "LibDirectory"
    '    Dim WC$ = "Where DirectoryName = '" + DirectoryName + "' and   LibraryName = '" + LibraryName + "' and   UserID = '" + UserID + "'"


    '    rsData = DB.GetRowByKey(TBL$, WC)


    '    If rsData.HasRows Then
    '        Return rsData
    '    Else
    '        Return Nothing
    '    End If
    'End Function     '** getRow_PK98


    ''' Build Index Where Caluses 
    '''
    Public Function wc_PK98(ByVal DirectoryName As String, ByVal LibraryName As String, ByVal UserID As String) As String


        'Dim WC$ = "Where DirectoryName = '" + DirectoryName + "' and   LibraryName = '" + LibraryName + "' and   UserID = '" + UserID + "'"
        Dim WC$ = "Where DirectoryName = '" + DirectoryName + "' and   LibraryName = '" + LibraryName + "' "


        Return WC
    End Function     '** wc_PK98


    Protected Overrides Sub Finalize()
        Try

        Finally
            MyBase.Finalize()      'define the destructor
            ''RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub

    Private Sub setXXSearchSvcEndPoint()

        If (SearchEndPoint.Length = 0) Then
            Return
        End If

        Dim ServiceUri As New Uri(SearchEndPoint)
        Dim EPA As New System.ServiceModel.EndpointAddress(ServiceUri)

        ProxySearch.Endpoint.Address = EPA
        GC.Collect()
        GC.WaitForPendingFinalizers()
    End Sub

End Class

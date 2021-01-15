Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
'Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports ECMEncryption


Public Class clsLIBRARYUSERS


    'Dim proxy As New SVCSearch.Service1Client

    '** DIM the selected table columns 
    'Dim DMA As New clsDma
    'Dim UTIL As New clsUtility
    Dim LOG As New clsLogMain
    'Dim EP As New clsEndPoint
    Dim ENC2 As New ECMEncrypt()
    'Dim DG As New clsDataGrid

    Dim SingleUser As Integer = 0
    Dim isReadOnly As String = ""
    Dim CreateAccess As String = ""
    Dim UpdateAccess As String = ""
    Dim DeleteAccess As String = ""
    Dim LibraryOwnerUserID As String = ""
    Dim LibraryName As String = ""
    Dim UserID As String = ""




    '** Generate the SET methods 
    Public Sub setReadonly(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = val.Replace("'", "''")
        isReadOnly = val
    End Sub


    Public Sub setCreateaccess(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = val.Replace("'", "''")
        CreateAccess = val
    End Sub


    Public Sub setUpdateaccess(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = val.Replace("'", "''")
        UpdateAccess = val
    End Sub


    Public Sub setDeleteaccess(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = val.Replace("'", "''")
        DeleteAccess = val
    End Sub


    Public Sub setLibraryowneruserid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("clsLibraryUsers - SET: Field 'Libraryowneruserid' cannot be NULL.")
            Return
        End If
        val = val.Replace("'", "''")
        LibraryOwnerUserID = val
    End Sub


    Public Sub setLibraryname(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("clsLibraryUsers - SET: Field 'Libraryname' cannot be NULL.")
            Return
        End If
        val = val.Replace("'", "''")
        LibraryName = val
    End Sub


    Public Sub setUserid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("clsLibraryUsers - SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = val.Replace("'", "''")
        UserID = val
    End Sub

    Public Sub setIsSingleUser(ByRef val As Integer)
        SingleUser = val
    End Sub

    '** Generate the GET methods 
    Public Function getReadonly() As String
        If Len(isReadOnly) = 0 Then
            isReadOnly = "null"
        End If
        Return isReadOnly
    End Function


    Public Function getCreateaccess() As String
        If Len(CreateAccess) = 0 Then
            CreateAccess = "null"
        End If
        Return CreateAccess
    End Function


    Public Function getUpdateaccess() As String
        If Len(UpdateAccess) = 0 Then
            UpdateAccess = "null"
        End If
        Return UpdateAccess
    End Function


    Public Function getDeleteaccess() As String
        If Len(DeleteAccess) = 0 Then
            DeleteAccess = "null"
        End If
        Return DeleteAccess
    End Function


    Public Function getLibraryowneruserid() As String
        If Len(LibraryOwnerUserID) = 0 Then
            MessageBox.Show("clsLibraryUsers - GET: Field 'Libraryowneruserid' cannot be NULL.")
            Return ""
        End If
        Return LibraryOwnerUserID.Replace("''", "'")
    End Function


    Public Function getLibraryname() As String
        If Len(LibraryName) = 0 Then
            MessageBox.Show("clsLibraryUsers - GET: Field 'Libraryname' cannot be NULL.")
            Return ""
        End If
        Return LibraryName.Replace("''", "'")
    End Function


    Public Function getUserid() As String
        If Len(UserID) = 0 Then
            MessageBox.Show("clsLibraryUsers - GET: Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UserID.Replace("''", "'")
    End Function

    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If LibraryOwnerUserID.Length = 0 Then Return False
        If LibraryName.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        Return True
    End Function

    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If LibraryOwnerUserID.Length = 0 Then Return False
        If LibraryName.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        Return True
    End Function

    '** Generate the INSERT method 
    Public Sub Insert(ByVal NotAddedAsGroupMember As Integer, ByVal SingleUser As Integer, ByVal GroupUser As Integer)
        Dim b As Boolean = False
        Dim s As String = ""
        Dim sSingleUser As String = ""
        Dim sGroupUser As String = ""

        If SingleUser = Nothing Then
            sSingleUser = Nothing
        Else
            sSingleUser = SingleUser.ToString
        End If
        If GroupUser = Nothing Then
            sGroupUser = Nothing
        Else
            sGroupUser = GroupUser.ToString
        End If

        s = s + " INSERT INTO LibraryUsers("
        s = s + "ReadOnly,"
        s = s + "CreateAccess,"
        s = s + "UpdateAccess,"
        s = s + "DeleteAccess,"
        s = s + "LibraryOwnerUserID,"
        s = s + "LibraryName,"
        s = s + "UserID, NotAddedAsGroupMember, SingleUser) values ("
        s = s + isReadOnly + ","
        s = s + CreateAccess + ","
        s = s + UpdateAccess + ","
        s = s + DeleteAccess + ","
        s = s + "'" + LibraryOwnerUserID + "'" + ","
        s = s + "'" + LibraryName + "'" + ","
        s = s + "'" + UserID + "'" + ", "
        s = s + NotAddedAsGroupMember.ToString + ","
        If sSingleUser IsNot Nothing Then
            s = s + sSingleUser.ToString
        End If
        If sGroupUser IsNot Nothing Then
            s = s + sGroupUser.ToString
        End If
        s = s + ")"

        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
        'EP.setSearchSvcEndPoint(proxy)
        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))



    End Sub




    '** Generate the UPDATE method 
    Public Sub Update(ByVal WhereClause As String, ByVal NotAddedAsGroupMember As Integer, ByVal SingleUser As Integer, ByVal GroupUser As Integer)
        Dim b As Boolean = False
        Dim s As String = ""

        Dim sSingleUser As String = ""
        Dim sGroupUser As String = ""

        If SingleUser = Nothing Then
            sSingleUser = Nothing
        Else
            sSingleUser = SingleUser.ToString
        End If
        If GroupUser = Nothing Then
            sGroupUser = Nothing
        Else
            sGroupUser = GroupUser.ToString
        End If


        If Len(WhereClause) = 0 Then Return


        s = s + " update LibraryUsers set " + Environment.NewLine
        s = s + "ReadOnly = " + getReadonly() + ", " + Environment.NewLine
        s = s + "CreateAccess = " + getCreateaccess() + ", " + Environment.NewLine
        s = s + "UpdateAccess = " + getUpdateaccess() + ", " + Environment.NewLine
        s = s + "DeleteAccess = " + getDeleteaccess() + ", " + Environment.NewLine
        s = s + "LibraryOwnerUserID = '" + getLibraryowneruserid() + "'" + ", " + Environment.NewLine
        s = s + "LibraryName = '" + getLibraryname() + "'" + ", " + Environment.NewLine
        s = s + "UserID = '" + getUserid() + "'," + Environment.NewLine
        s = s + "NotAddedAsGroupMember = " + NotAddedAsGroupMember.ToString + "," + Environment.NewLine
        If sSingleUser IsNot Nothing Then
            s = s + "SingleUser = " + SingleUser.ToString + "," + Environment.NewLine
        End If
        If sGroupUser IsNot Nothing Then
            s = s + "GroupUser = " + GroupUser.ToString + Environment.NewLine
        End If

        WhereClause = " " + WhereClause
        s = s + WhereClause

        'AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
        'EP.setSearchSvcEndPoint(proxy)
        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))


    End Sub




    ''** Generate the SELECT method 
    'Public Function SelectRecs() As SqlDataReader
    '    Dim b As Boolean = False
    '    Dim s As String = ""
    '    Dim rsData As SqlDataReader
    '    s = s + " SELECT "
    '    s = s + "ReadOnly,"
    '    s = s + "CreateAccess,"
    '    s = s + "UpdateAccess,"
    '    s = s + "DeleteAccess,"
    '    s = s + "LibraryOwnerUserID,"
    '    s = s + "LibraryName,"
    '    s = s + "UserID "
    '    s = s + " FROM LibraryUsers"

    '    Dim CS$ = db.getConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata = command.ExecuteReader()
    '    Return rsData
    'End Function




    ''** Generate the Select One Row method 
    'Public Function SelectOne(ByVal WhereClause as string) As SqlDataReader
    '    Dim b As Boolean = False
    '    Dim s As String = ""
    '    Dim rsData As SqlDataReader
    '    s = s + " SELECT "
    '    s = s + "ReadOnly,"
    '    s = s + "CreateAccess,"
    '    s = s + "UpdateAccess,"
    '    s = s + "DeleteAccess,"
    '    s = s + "LibraryOwnerUserID,"
    '    s = s + "LibraryName,"
    '    s = s + "UserID "
    '    s = s + " FROM LibraryUsers"
    '    s = s + WhereClause

    '    Dim CS$ = db.getConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata = command.ExecuteReader()
    '    Return rsData
    'End Function




    '** Generate the DELETE method 
    Public Sub Delete(ByVal WhereClause As String)
        Dim b As Boolean = False
        Dim s As String = ""


        If Len(WhereClause) = 0 Then Return


        WhereClause = " " + WhereClause


        s = " Delete from LibraryUsers"
        s = s + WhereClause

        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))



    End Sub




    '** Generate the Zeroize Table method 
    Public Sub Zeroize()
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from LibraryUsers"

        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))


    End Sub




    ''** Generate Index Queries 
    'Public Function cnt_PK87(ByVal LibraryName As String, ByVal LibraryOwnerUserID As String, ByVal UserID As String) As Integer


    '    Dim B As Integer = 0
    '    Dim TBL$ = "LibraryUsers"
    '    Dim WC$ = "Where LibraryName = '" + LibraryName + "' and   LibraryOwnerUserID = '" + LibraryOwnerUserID + "' and   UserID = '" + UserID + "'"


    '    B = DB.iGetRowCount(TBL$, WC)


    '    Return B
    'End Function     '** cnt_PK87


    ''** Generate Index ROW Queries 
    'Public Function getRow_PK87(ByVal LibraryName As String, ByVal LibraryOwnerUserID As String, ByVal UserID As String) As SqlDataReader


    '    Dim rsData As SqlDataReader = Nothing
    '    Dim TBL$ = "LibraryUsers"
    '    Dim WC$ = "Where LibraryName = '" + LibraryName + "' and   LibraryOwnerUserID = '" + LibraryOwnerUserID + "' and   UserID = '" + UserID + "'"


    '    rsData = DB.GetRowByKey(TBL$, WC)


    '    If rsData.HasRows Then
    '        Return rsData
    '    Else
    '        Return Nothing
    '    End If
    'End Function     '** getRow_PK87


    ''' Build Index Where Caluses 
    '''
    Public Function wc_PK87(ByVal LibraryName As String, ByVal LibraryOwnerUserID As String, ByVal UserID As String) As String


        Dim WC$ = "Where LibraryName = '" + LibraryName + "' and   LibraryOwnerUserID = '" + LibraryOwnerUserID + "' and   UserID = '" + UserID + "'"


        Return WC
    End Function     '** wc_PK87

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

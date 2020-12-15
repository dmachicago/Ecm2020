' ***********************************************************************
' Assembly         : ECMSearchWPF
' Author           : wdale
' Created          : 07-16-2020
'
' Last Modified By : wdale
' Last Modified On : 07-16-2020
' ***********************************************************************
' <copyright file="clsLIBRARYUSERS.vb" company="D. Miller and Associates, Limited">
'     Copyright @ DMA Ltd 2020 all rights reserved.
' </copyright>
' <summary></summary>
' ***********************************************************************
Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
'Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports ECMEncryption


''' <summary>
''' Class clsLIBRARYUSERS.
''' </summary>
Public Class clsLIBRARYUSERS


    'Dim proxy As New SVCSearch.Service1Client

    '** DIM the selected table columns 
    'Dim DMA As New clsDma
    'Dim UTIL As New clsUtility
    ''' <summary>
    ''' The log
    ''' </summary>
    Dim LOG As New clsLogMain
    'Dim EP As New clsEndPoint
    ''' <summary>
    ''' The en c2
    ''' </summary>
    Dim ENC2 As New ECMEncrypt()
    'Dim DG As New clsDataGrid

    ''' <summary>
    ''' The single user
    ''' </summary>
    Dim SingleUser As Integer = 0
    ''' <summary>
    ''' The is read only
    ''' </summary>
    Dim isReadOnly As String = ""
    ''' <summary>
    ''' The create access
    ''' </summary>
    Dim CreateAccess As String = ""
    ''' <summary>
    ''' The update access
    ''' </summary>
    Dim UpdateAccess As String = ""
    ''' <summary>
    ''' The delete access
    ''' </summary>
    Dim DeleteAccess As String = ""
    ''' <summary>
    ''' The library owner user identifier
    ''' </summary>
    Dim LibraryOwnerUserID As String = ""
    ''' <summary>
    ''' The library name
    ''' </summary>
    Dim LibraryName As String = ""
    ''' <summary>
    ''' The user identifier
    ''' </summary>
    Dim UserID As String = ""




    '** Generate the SET methods 
    ''' <summary>
    ''' Sets the readonly.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setReadonly(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = val.Replace("'", "''")
        isReadOnly = val
    End Sub


    ''' <summary>
    ''' Sets the createaccess.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setCreateaccess(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = val.Replace("'", "''")
        CreateAccess = val
    End Sub


    ''' <summary>
    ''' Sets the updateaccess.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setUpdateaccess(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = val.Replace("'", "''")
        UpdateAccess = val
    End Sub


    ''' <summary>
    ''' Sets the deleteaccess.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setDeleteaccess(ByRef val As String)
        If Len(val) = 0 Then
            val = "null"
        End If
        val = val.Replace("'", "''")
        DeleteAccess = val
    End Sub


    ''' <summary>
    ''' Sets the libraryowneruserid.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setLibraryowneruserid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("clsLibraryUsers - SET: Field 'Libraryowneruserid' cannot be NULL.")
            Return
        End If
        val = val.Replace("'", "''")
        LibraryOwnerUserID = val
    End Sub


    ''' <summary>
    ''' Sets the libraryname.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setLibraryname(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("clsLibraryUsers - SET: Field 'Libraryname' cannot be NULL.")
            Return
        End If
        val = val.Replace("'", "''")
        LibraryName = val
    End Sub


    ''' <summary>
    ''' Sets the userid.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setUserid(ByRef val As String)
        If Len(val) = 0 Then
            MessageBox.Show("clsLibraryUsers - SET: Field 'Userid' cannot be NULL.")
            Return
        End If
        val = val.Replace("'", "''")
        UserID = val
    End Sub

    ''' <summary>
    ''' Sets the is single user.
    ''' </summary>
    ''' <param name="val">The value.</param>
    Public Sub setIsSingleUser(ByRef val As Integer)
        SingleUser = val
    End Sub

    '** Generate the GET methods 
    ''' <summary>
    ''' Gets the readonly.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getReadonly() As String
        If Len(isReadOnly) = 0 Then
            isReadOnly = "null"
        End If
        Return isReadOnly
    End Function


    ''' <summary>
    ''' Gets the createaccess.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getCreateaccess() As String
        If Len(CreateAccess) = 0 Then
            CreateAccess = "null"
        End If
        Return CreateAccess
    End Function


    ''' <summary>
    ''' Gets the updateaccess.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getUpdateaccess() As String
        If Len(UpdateAccess) = 0 Then
            UpdateAccess = "null"
        End If
        Return UpdateAccess
    End Function


    ''' <summary>
    ''' Gets the deleteaccess.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getDeleteaccess() As String
        If Len(DeleteAccess) = 0 Then
            DeleteAccess = "null"
        End If
        Return DeleteAccess
    End Function


    ''' <summary>
    ''' Gets the libraryowneruserid.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getLibraryowneruserid() As String
        If Len(LibraryOwnerUserID) = 0 Then
            MessageBox.Show("clsLibraryUsers - GET: Field 'Libraryowneruserid' cannot be NULL.")
            Return ""
        End If
        Return LibraryOwnerUserID.Replace("''", "'")
    End Function


    ''' <summary>
    ''' Gets the libraryname.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getLibraryname() As String
        If Len(LibraryName) = 0 Then
            MessageBox.Show("clsLibraryUsers - GET: Field 'Libraryname' cannot be NULL.")
            Return ""
        End If
        Return LibraryName.Replace("''", "'")
    End Function


    ''' <summary>
    ''' Gets the userid.
    ''' </summary>
    ''' <returns>System.String.</returns>
    Public Function getUserid() As String
        If Len(UserID) = 0 Then
            MessageBox.Show("clsLibraryUsers - GET: Field 'Userid' cannot be NULL.")
            Return ""
        End If
        Return UserID.Replace("''", "'")
    End Function

    '** Generate the Required Fields Validation method 
    ''' <summary>
    ''' Validates the req data.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ValidateReqData() As Boolean
        If LibraryOwnerUserID.Length = 0 Then Return False
        If LibraryName.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        Return True
    End Function

    '** Generate the Validation method 
    ''' <summary>
    ''' Validates the data.
    ''' </summary>
    ''' <returns><c>true</c> if XXXX, <c>false</c> otherwise.</returns>
    Public Function ValidateData() As Boolean
        If LibraryOwnerUserID.Length = 0 Then Return False
        If LibraryName.Length = 0 Then Return False
        If UserID.Length = 0 Then Return False
        Return True
    End Function

    '** Generate the INSERT method 
    ''' <summary>
    ''' Inserts the specified not added as group member.
    ''' </summary>
    ''' <param name="NotAddedAsGroupMember">The not added as group member.</param>
    ''' <param name="SingleUser">The single user.</param>
    ''' <param name="GroupUser">The group user.</param>
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
    ''' <summary>
    ''' Updates the specified where clause.
    ''' </summary>
    ''' <param name="WhereClause">The where clause.</param>
    ''' <param name="NotAddedAsGroupMember">The not added as group member.</param>
    ''' <param name="SingleUser">The single user.</param>
    ''' <param name="GroupUser">The group user.</param>
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


        s = s + " update LibraryUsers set " + vbCrLf
        s = s + "ReadOnly = " + getReadonly() + ", " + vbCrLf
        s = s + "CreateAccess = " + getCreateaccess() + ", " + vbCrLf
        s = s + "UpdateAccess = " + getUpdateaccess() + ", " + vbCrLf
        s = s + "DeleteAccess = " + getDeleteaccess() + ", " + vbCrLf
        s = s + "LibraryOwnerUserID = '" + getLibraryowneruserid() + "'" + ", " + vbCrLf
        s = s + "LibraryName = '" + getLibraryname() + "'" + ", " + vbCrLf
        s = s + "UserID = '" + getUserid() + "'," + vbCrLf
        s = s + "NotAddedAsGroupMember = " + NotAddedAsGroupMember.ToString + "," + vbCrLf
        If sSingleUser IsNot Nothing Then
            s = s + "SingleUser = " + SingleUser.ToString + "," + vbCrLf
        End If
        If sGroupUser IsNot Nothing Then
            s = s + "GroupUser = " + GroupUser.ToString + vbCrLf
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
    ''' <summary>
    ''' Deletes the specified where clause.
    ''' </summary>
    ''' <param name="WhereClause">The where clause.</param>
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
    ''' <summary>
    ''' Zeroizes this instance.
    ''' </summary>
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


    ''' <summary>
    ''' Wcs the p K87.
    ''' </summary>
    ''' <param name="LibraryName">Name of the library.</param>
    ''' <param name="LibraryOwnerUserID">The library owner user identifier.</param>
    ''' <param name="UserID">The user identifier.</param>
    ''' <returns>System.String.</returns>
    ''' Build Index Where Caluses
    Public Function wc_PK87(ByVal LibraryName As String, ByVal LibraryOwnerUserID As String, ByVal UserID As String) As String


        Dim WC$ = "Where LibraryName = '" + LibraryName + "' and   LibraryOwnerUserID = '" + LibraryOwnerUserID + "' and   UserID = '" + UserID + "'"


        Return WC
    End Function     '** wc_PK87

    ''' <summary>
    ''' Allows an object to try to free resources and perform other cleanup operations before it is reclaimed by garbage collection.
    ''' </summary>
    Protected Overrides Sub Finalize()
        Try

        Finally
            MyBase.Finalize()      'define the destructor
            ''RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL

            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub

    ''' <summary>
    ''' Sets the xx search SVC end point.
    ''' </summary>
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

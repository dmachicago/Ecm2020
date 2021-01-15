Imports Microsoft.VisualBasic
Imports System.Configuration
Imports System
'Imports System.Data.SqlClient
Imports System.Collections
Imports System.IO
Imports ECMEncryption

Public Class clsDATASOURCERESTOREHISTORY

    Dim COMMON As New clsCommonFunctions
    'Dim EP As New clsEndPoint
    Dim ENC2 As New ECMEncrypt()


    'Dim proxy As New SVCSearch.Service1Client

    '** DIM the selected table columns 
    'Dim DB As New clsDatabase
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogMain


    Dim SourceGuid As String = ""
    Dim RestoredToMachine As String = ""
    Dim RestoreUserName As String = ""
    Dim RestoreUserID As String = ""
    Dim RestoreUserDomain As String = ""
    Dim RestoreDate As String = ""
    Dim DataSourceOwnerUserID As String = ""
    Dim SeqNo As String = ""
    Dim TypeContentCode As String = ""
    Dim CreateDate As String = ""
    Dim DocumentName As String = ""
    Dim FQN As String = ""
    Dim VerifiedData As String = ""
    Dim OrigCrc As String = ""
    Dim RestoreCrc As String = ""

    Dim HandlerAdded As Boolean = False
    Sub New()

    End Sub
    '** Generate the SET methods 
    Public Sub setSourceguid(ByRef val As String)
        If Len(val) = 0 Then
            messagebox.show("clsDATASOURCERESTOREHISTORY - SET: Field 'Sourceguid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        SourceGuid = val
    End Sub

    Public Sub setRestoredtomachine(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        RestoredToMachine = val
    End Sub

    Public Sub setRestoreusername(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        RestoreUserName = val
    End Sub

    Public Sub setRestoreuserid(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        RestoreUserID = val
    End Sub

    Public Sub setRestoreuserdomain(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        RestoreUserDomain = val
    End Sub

    Public Sub setRestoredate(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        RestoreDate = val
    End Sub

    Public Sub setDatasourceowneruserid(ByRef val As String)
        If Len(val) = 0 Then
            messagebox.show("clsDATASOURCERESTOREHISTORY - SET: Field 'Datasourceowneruserid' cannot be NULL.")
            Return
        End If
        val = UTIL.RemoveSingleQuotes(val)
        DataSourceOwnerUserID = val
    End Sub

    Public Sub setTypecontentcode(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        TypeContentCode = val
    End Sub

    Public Sub setCreatedate(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        CreateDate = val
    End Sub

    Public Sub setDocumentname(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        DocumentName = val
    End Sub

    Public Sub setFqn(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        FQN = val
    End Sub

    Public Sub setVerifieddata(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        VerifiedData = val
    End Sub

    Public Sub setOrigcrc(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        OrigCrc = val
    End Sub

    Public Sub setRestorecrc(ByRef val As String)
        val = UTIL.RemoveSingleQuotes(val)
        RestoreCrc = val
    End Sub



    '** Generate the GET methods 
    Public Function getSourceguid() As String
        If Len(SourceGuid) = 0 Then
            messagebox.show("clsDATASOURCERESTOREHISTORY - GET: Field 'Sourceguid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(SourceGuid)
    End Function

    Public Function getRestoredtomachine() As String
        Return UTIL.RemoveSingleQuotes(RestoredToMachine)
    End Function

    Public Function getRestoreusername() As String
        Return UTIL.RemoveSingleQuotes(RestoreUserName)
    End Function

    Public Function getRestoreuserid() As String
        Return UTIL.RemoveSingleQuotes(RestoreUserID)
    End Function

    Public Function getRestoreuserdomain() As String
        Return UTIL.RemoveSingleQuotes(RestoreUserDomain)
    End Function

    Public Function getRestoredate() As String
        Return UTIL.RemoveSingleQuotes(RestoreDate)
    End Function

    Public Function getDatasourceowneruserid() As String
        If Len(DataSourceOwnerUserID) = 0 Then
            messagebox.show("clsDATASOURCERESTOREHISTORY - GET: Field 'Datasourceowneruserid' cannot be NULL.")
            Return ""
        End If
        Return UTIL.RemoveSingleQuotes(DataSourceOwnerUserID)
    End Function

    Public Function getSeqno() As String
        If Len(SeqNo) = 0 Then
            messagebox.show("clsDATASOURCERESTOREHISTORY - GET: Field 'Seqno' cannot be NULL.")
            Return ""
        End If
        If Len(SeqNo) = 0 Then
            SeqNo = "null"
        End If
        Return SeqNo
    End Function

    Public Function getTypecontentcode() As String
        Return UTIL.RemoveSingleQuotes(TypeContentCode)
    End Function

    Public Function getCreatedate() As String
        Return UTIL.RemoveSingleQuotes(CreateDate)
    End Function

    Public Function getDocumentname() As String
        Return UTIL.RemoveSingleQuotes(DocumentName)
    End Function

    Public Function getFqn() As String
        Return UTIL.RemoveSingleQuotes(FQN)
    End Function

    Public Function getVerifieddata() As String
        Return UTIL.RemoveSingleQuotes(VerifiedData)
    End Function

    Public Function getOrigcrc() As String
        Return UTIL.RemoveSingleQuotes(OrigCrc)
    End Function

    Public Function getRestorecrc() As String
        Return UTIL.RemoveSingleQuotes(RestoreCrc)
    End Function



    '** Generate the Required Fields Validation method 
    Public Function ValidateReqData() As Boolean
        If SourceGuid.Length = 0 Then Return False
        If DataSourceOwnerUserID.Length = 0 Then Return False
        If SeqNo.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the Validation method 
    Public Function ValidateData() As Boolean
        If SourceGuid.Length = 0 Then Return False
        If DataSourceOwnerUserID.Length = 0 Then Return False
        Return True
    End Function


    '** Generate the INSERT method 
    Public Function Insert() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""
        s = s + " INSERT INTO DataSourceRestoreHistory(" + Environment.NewLine
        s = s + "SourceGuid," + Environment.NewLine
        s = s + "RestoredToMachine," + Environment.NewLine
        s = s + "RestoreUserName," + Environment.NewLine
        s = s + "RestoreUserID," + Environment.NewLine
        s = s + "RestoreUserDomain," + Environment.NewLine
        s = s + "RestoreDate," + Environment.NewLine
        s = s + "DataSourceOwnerUserID," + Environment.NewLine
        s = s + "TypeContentCode," + Environment.NewLine
        s = s + "CreateDate)" + Environment.NewLine
        s = s + " values (" + Environment.NewLine
        s = s + "'" + SourceGuid + "'" + "," + Environment.NewLine
        s = s + "'" + RestoredToMachine + "'" + "," + Environment.NewLine
        s = s + "'" + RestoreUserName + "'" + "," + Environment.NewLine
        s = s + "'" + RestoreUserID + "'" + "," + Environment.NewLine
        s = s + "'" + RestoreUserDomain + "'" + "," + Environment.NewLine
        s = s + "'" + Now.ToString + "'" + "," + Environment.NewLine
        s = s + "'" + DataSourceOwnerUserID + "'" + "," + Environment.NewLine
        s = s + "'" + TypeContentCode + "'" + "," + Environment.NewLine
        s = s + "'" + Now.ToString + "')" + Environment.NewLine

        If Not HandlerAdded Then
            ''AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
            'EP.setSearchSvcEndPoint(proxy)
        End If
        s = ENC2.AES256EncryptString(s)
        Dim rc As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, s, _UserID, ContractID)
        gLogSQL(rc, ENC2.AES256EncryptString(s))

        Return True

    End Function


    '** Generate the UPDATE method 
    Public Function Update(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        s = s + " update DataSourceRestoreHistory set "
        s = s + "SourceGuid = '" + getSourceguid() + "'" + ", "
        s = s + "RestoredToMachine = '" + getRestoredtomachine() + "'" + ", "
        s = s + "RestoreUserName = '" + getRestoreusername() + "'" + ", "
        s = s + "RestoreUserID = '" + getRestoreuserid() + "'" + ", "
        s = s + "RestoreUserDomain = '" + getRestoreuserdomain() + "'" + ", "
        s = s + "RestoreDate = '" + getRestoredate() + "'" + ", "
        s = s + "DataSourceOwnerUserID = '" + getDatasourceowneruserid() + "'" + ", "
        s = s + "TypeContentCode = '" + getTypecontentcode() + "'" + ", "
        s = s + "CreateDate = '" + getCreatedate() + "'" + ", "
        s = s + "DocumentName = '" + getDocumentname() + "'" + ", "
        s = s + "FQN = '" + getFqn() + "'" + ", "
        s = s + "VerifiedData = '" + getVerifieddata() + "'" + ", "
        s = s + "OrigCrc = '" + getOrigcrc() + "'" + ", "
        s = s + "RestoreCrc = '" + getRestorecrc() + "'"
        WhereClause = " " + WhereClause
        s = s + WhereClause
        If Not HandlerAdded Then
            ''AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
            'EP.setSearchSvcEndPoint(proxy)
        End If

        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))
        Return True
    End Function




    '** Generate the DELETE method 
    Public Function Delete(ByVal WhereClause As String) As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        If Len(WhereClause) = 0 Then Return False

        WhereClause = " " + WhereClause

        s = " Delete from DataSourceRestoreHistory"
        s = s + WhereClause

        If Not HandlerAdded Then
            ''AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
            'EP.setSearchSvcEndPoint(proxy)
        End If

        s = ENC2.AES256EncryptString(s)
        Dim bb As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, s, _UserID, ContractID)
        gLogSQL(bb, ENC2.AES256EncryptString(s))

        Return True

    End Function


    '** Generate the Zeroize Table method 
    Public Function Zeroize() As Boolean
        Dim b As Boolean = False
        Dim s As String = ""

        s = s + " Delete from DataSourceRestoreHistory"

        If Not HandlerAdded Then
            ''AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
            'EP.setSearchSvcEndPoint(proxy)
        End If

        s = ENC2.AES256EncryptString(s)
        Dim BB As Boolean = ProxySearch.ExecuteSqlNewConnSecure(_SecureID, s, _UserID, ContractID)
        gLogSQL(BB, ENC2.AES256EncryptString(s))
        Return True

    End Function



    Protected Overrides Sub Finalize()
        Try

        Finally
            MyBase.Finalize()      'define the destructor
            HandlerAdded = False
            ''RemoveHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf gLogSQL
            GC.Collect()
            GC.WaitForPendingFinalizers()
        End Try
    End Sub


End Class

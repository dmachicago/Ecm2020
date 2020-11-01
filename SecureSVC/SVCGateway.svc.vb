' NOTE: You can use the "Rename" command on the context menu to change the class name "Service1" in
'       code, svc and config file together.
Public Class SVCGateway
    Implements IService1

    Dim SL As New clsSecureLogin


    Public Sub New()
    End Sub

    Function getUserCompanies(UserID As String, PW As String) As String Implements IService1.getUserCompanies
        Return SL.getUserCompanies(UserID, PW)
    End Function

    Function getAttachData(CS As String, CompanyID As String, SvrName As String, DBName As String, InstanceName As String) As String Implements IService1.getAttachData
        Dim S As String = SL.getAttachData(CS, CompanyID, SvrName, DBName, InstanceName)
        Return S
    End Function
    Function getCompanyID(CS As String) As String Implements IService1.getCompanyID
        Return SL.getCompanyID(CS)
    End Function
    Function getServers(CS As String, CompanyID As String) As String Implements IService1.getServers
        Return SL.getServers(CS, CompanyID)
    End Function
    Function getDatabases(CS As String, CompanyID As String, SvrName As String) As String Implements IService1.getDatabases
        Return SL.getDatabases(CS, CompanyID, SvrName)
    End Function
    Function getInstance(CS As String, CompanyID As String, SvrName As String, DBName As String) As String Implements IService1.getInstance
        Return SL.getInstance(CS, CompanyID, SvrName, DBName)
    End Function

    Function ckServerRunning() As Boolean Implements IService1.ckServerRunning
        Return True
    End Function

    Function duplicateEntry(ByVal ConnStr As String, tDict As Dictionary(Of String, String)) As Boolean Implements IService1.duplicateEntry
        Return SL.duplicateEntry(ConnStr, tDict)
    End Function
    Function getSessionID() As String Implements IService1.getSessionID
        Dim strSession As String
        'strSession = HttpContext.Current.Session.SessionID
        strSession = System.Guid.NewGuid.ToString()
        Return strSession
    End Function

    Function getServiceVersion() As String Implements IService1.getServiceVersion
        Return "18.1.05"
    End Function

    Function updateRepoUsers(CompanyID As String, RepoID As String) As String Implements IService1.updateRepoUsers
        Dim RetMsg As String = SL.updateRepoUsers(CompanyID, RepoID)
        Return RetMsg
    End Function

    Function validateAttachSecureLogin(gSecureID As Integer, gCompanyID As String, gRepoID As String, LoginID As String, EPW As String) As Integer Implements IService1.validateAttachSecureLogin
        Dim RC As Integer = 0
        RC = SL.validateAttachSecureLogin(gSecureID, gCompanyID, gRepoID, LoginID, EPW)
        Return RC
    End Function

    Function getGatewayCS(gSecureID As Integer, gCompanyID As String, gRepoID As String, EPW As String) As String Implements IService1.getGatewayCS
        Dim items As String = SL.getGatewayCS(gSecureID, gCompanyID, gRepoID, EPW)
        Return items
    End Function

    Function getEndPoints(ByVal CompanyID As String, RepoID As String) As String Implements IService1.getEndPoints
        Dim items As String = SL.getEndPoints(CompanyID, RepoID)
        Return items
    End Function

    Function PopulateGatewayLoginCB(ByVal CS As String, ByVal CompanyID As String) As String Implements IService1.PopulateGatewayLoginCB
        Dim items As String = SL.PopulateGatewayLoginCB(CS, CompanyID)
        Return items
    End Function

    Public Function getSecureID(CompanyID As String, RepoID As String) As Integer Implements IService1.getSecureID
        Dim I As Integer = SL.getSecureID(CompanyID, RepoID)
        Return I
    End Function

    Public Function getCS(ByVal gSecureID As Integer) As String Implements IService1.getCS
        Dim S As String = SL.getCS(gSecureID)
        Return S
    End Function

    Public Function getRepoCS(ByVal gSecureID As Integer) As String Implements IService1.getRepoCS
        Dim S As String = SL.getRepoCS(gSecureID)
        Return S
    End Function

    Public Function getConnection(ByVal CompanyID As String, ByVal RepoID As String, ByRef RC As Boolean, ByRef RetMsg As String) As String Implements IService1.getConnection
        Dim S As String = SL.getConnection(CompanyID, RepoID, RC, RetMsg)
        Return S
    End Function

    Public Function ValidateUserLogin(ByVal UID As String, ByVal EncPW As String) As Boolean Implements IService1.ValidateUserLogin
        Dim B As Boolean = SL.ValidateUserLogin(UID, EncPW)
        Return B
    End Function

    Public Function ValidateGatewayLogin(ByVal CompanyID As String, ByVal RepoID As String, ByVal EncPW As String, ByRef RC As Boolean, ByRef RtnMsg As String) As Boolean Implements IService1.ValidateGatewayLogin
        Dim B As Boolean = SL.ValidateGatewayLogin(CompanyID, RepoID, EncPW, RC, RtnMsg)
        Return B
    End Function

    Public Function getSecureKey(ByVal CompanyID As String, ByVal RepoID As String, ByVal LoginPassword As String, ByRef RC As Boolean, ByRef RetMsg As String) As String Implements IService1.getSecureKey
        Dim SecureKey As String = ""
        SecureKey = SL.getSecureKey(CompanyID, RepoID, LoginPassword, RC, RetMsg)
        Return SecureKey
    End Function

    Public Function PopulateCompanyComboSecure(ByVal CS As String, ByVal CompanyID As String, ByVal EncryptedPW As String, ByRef RC As Boolean, ByRef RetTxt As String) As String Implements IService1.PopulateCompanyComboSecure
        Dim S As String = SL.PopulateCompanyComboSecure(CS, CompanyID, EncryptedPW, RC, RetTxt)
        Return S
    End Function

    Public Function PopulateCombo(ByVal CS As String, ByVal CompanyID As String, ByRef RC As Boolean, ByRef RetTxt As String) As String Implements IService1.PopulateCombo
        Dim S As String = SL.PopulateCombo(CS, CompanyID, RC, RetTxt)
        Return S
    End Function

    Public Function PopulateRepoSecure(ByVal CS As String, ByVal CompanyID As String, ByVal EncryptedPW As String, ByRef RC As Boolean, ByRef RetTxt As String) As String Implements IService1.PopulateRepoSecure
        Dim S As String = SL.PopulateRepoSecure(CS, CompanyID, EncryptedPW, RC, RetTxt)
        Return S
    End Function

    Public Function PopulateRepoCombo(ByVal CS As String, ByVal CompanyID As String, ByRef RC As Boolean, ByRef RetTxt As String) As String Implements IService1.PopulateRepoCombo
        Dim S As String = SL.PopulateRepoCombo(CS, CompanyID, RC, RetTxt)
        Return S
    End Function

    Public Function PopulateGrid(ByVal CS As String, ByVal CompanyID As String, ByVal EncPW As String, ByRef RC As Boolean, ByRef RetTxt As String, LimitToCompany As Integer) As List(Of DS_SecureAttach) Implements IService1.PopulateGrid
        Dim LI As New List(Of DS_SecureAttach)
        LI = SL.PopulateGrid(CS, CompanyID, EncPW, RC, RetTxt, LimitToCompany)
        Return LI
    End Function

    Public Function SaveConnection(ByVal ConnStr As String,
                              tDict As Dictionary(Of String, String),
                              ByRef RC As Boolean, ByRef RtnMsg As String) As Boolean Implements IService1.saveConnection

        Dim B As Boolean = SL.SaveConnection(ConnStr, tDict, RC, RtnMsg)

        Return B
    End Function

    Public Function DeleteExistingConnection(ByVal ConnStr As String,
                              tDict As Dictionary(Of String, String),
                              ByRef RC As Boolean, ByRef RtnMsg As String) As Boolean Implements IService1.DeleteExistingConnection

        Dim B As Boolean = SL.DeleteExistingConnection(ConnStr, tDict, RC, RtnMsg)

        Return B
    End Function

    Public Function AttachToSecureLoginDB(ByVal ConnStr As String, ByRef RC As Boolean, ByRef RtnMsg As String) As Boolean Implements IService1.AttachToSecureLoginDB
        'Data Source=hp8gb;Initial Catalog=;Persist Security Info=True;User ID=ecmlibrary;Password=Jxxxxxxx; Connect Timeout = 45
        Dim B As Boolean = SL.AttachToSecureLoginDB(ConnStr, RC, RtnMsg)
        Return B
    End Function

    Public Function GetData(ByVal value As Integer) As String Implements IService1.GetData
        Return String.Format("You entered: {0}", value)
    End Function

    Public Function GetDataUsingDataContract(ByVal composite As CompositeType) As CompositeType Implements IService1.GetDataUsingDataContract
        If composite Is Nothing Then
            Throw New ArgumentNullException("composite")
        End If
        If composite.BoolValue Then
            composite.StringValue &= "Suffix"
        End If
        Return composite
    End Function

End Class
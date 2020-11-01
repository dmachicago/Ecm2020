' NOTE: You can use the "Rename" command on the context menu to change the interface name "IService1"
'       in both code and config file together.
<ServiceContract()>
Public Interface IService1



    <OperationContract>
    Function getUserCompanies(UserID As String, PW As String) As String

    <OperationContract>
    Function getAttachData(CS As String, CompanyID As String, SvrName As String, DBName As String, InstanceName As String) As String

    <OperationContract>
    Function getCompanyID(CS As String) As String

    <OperationContract>
    Function getServers(CS As String, CompanyID As String) As String

    <OperationContract>
    Function getDatabases(CS As String, CompanyID As String, ServerID As String) As String

    <OperationContract>
    Function getInstance(CS As String, CompanyID As String, ServerID As String, DBName As String) As String


    <OperationContract>
    Function ckServerRunning() As Boolean

    <OperationContract>
    Function duplicateEntry(ByVal ConnStr As String, tDict As Dictionary(Of String, String)) As Boolean

    <OperationContract()>
    Function getSessionID() As String

    <OperationContract()>
    Function getServiceVersion() As String

    <OperationContract()>
    Function updateRepoUsers(CompanyID As String, RepoID As String) As String

    <OperationContract()>
    Function validateAttachSecureLogin(gSecureID As Integer, gCompanyID As String, gRepoID As String, LoginID As String, EPW As String) As Integer

    <OperationContract()>
    Function getGatewayCS(gSecureID As Integer, gCompanyID As String, gRepoID As String, EPW As String) As String

    <OperationContract()>
    Function getEndPoints(ByVal CompanyID As String, RepoID As String) As String

    <OperationContract()>
    Function PopulateGatewayLoginCB(ByVal CS As String, ByVal CompanyID As String) As String

    <OperationContract()>
    Function getSecureID(CompanyID As String, RepoID As String) As Integer

    <OperationContract()>
    Function getCS(ByVal gSecureID As Integer) As String

    <OperationContract()>
    Function getRepoCS(ByVal gSecureID As Integer) As String

    <OperationContract()>
    Function getConnection(ByVal CompanyID As String, ByVal RepoID As String, ByRef RC As Boolean, ByRef RetMsg As String) As String

    <OperationContract()>
    Function ValidateUserLogin(ByVal UID As String, ByVal EncPW As String) As Boolean

    <OperationContract()>
    Function ValidateGatewayLogin(ByVal CompanyID As String, ByVal RepoID As String, ByVal EncPW As String, ByRef RC As Boolean, ByRef RtnMsg As String) As Boolean

    <OperationContract()>
    Function getSecureKey(ByVal CompanyID As String, ByVal RepoID As String, ByVal LoginPassword As String, ByRef RC As Boolean, ByRef RetMsg As String) As String

    <OperationContract()>
    Function PopulateCombo(ByVal CS As String, ByVal CompanyID As String, ByRef RC As Boolean, ByRef RetTxt As String) As String

    <OperationContract()>
    Function PopulateCompanyComboSecure(ByVal CS As String, ByVal CompanyID As String, ByVal EncryptedPW As String, ByRef RC As Boolean, ByRef RetTxt As String) As String

    <OperationContract()>
    Function PopulateRepoCombo(ByVal CS As String, ByVal CompanyID As String, ByRef RC As Boolean, ByRef RetTxt As String) As String

    <OperationContract()>
    Function PopulateRepoSecure(ByVal CS As String, ByVal CompanyID As String, ByVal EncryptedPW As String, ByRef RC As Boolean, ByRef RetTxt As String) As String

    <OperationContract()>
    Function DeleteExistingConnection(ByVal ConnStr As String, tDict As Dictionary(Of String, String), ByRef RC As Boolean, ByRef RtnMsg As String) As Boolean

    <OperationContract()>
    Function PopulateGrid(ByVal CS As String, ByVal CompanyID As String, ByVal EncPW As String, ByRef RC As Boolean, ByRef RetTxt As String, LimitToCompany As Integer) As List(Of DS_SecureAttach)

    <OperationContract()>
    Function saveConnection(ByVal ConnStr As String, tDict As Dictionary(Of String, String), ByRef RC As Boolean, ByRef RtnMsg As String) As Boolean

    <OperationContract()>
    Function AttachToSecureLoginDB(ByVal ConnStr As String, ByRef RC As Boolean, ByRef RtnMsg As String) As Boolean

    <OperationContract()>
    Function GetData(ByVal value As Integer) As String

    <OperationContract()>
    Function GetDataUsingDataContract(ByVal composite As CompositeType) As CompositeType

    ' TODO: Add your service operations here

End Interface

' Use a data contract as illustrated in the sample below to add composite types to service operations.

<DataContract()>
Public Class CompositeType

    <DataMember()>
    Public Property BoolValue() As Boolean

    <DataMember()>
    Public Property StringValue() As String

End Class

Public Class DS_SecureAttach

    <DataMember()>
    Public CompanyID As String

    <DataMember()>
    Public EncPW As String

    <DataMember()>
    Public RepoID As String

    <DataMember()>
    Public CS As String

    <DataMember()>
    Public Disabled As Integer

    <DataMember()>
    Public RowID As Integer

    <DataMember()>
    Public isThesaurus As Integer

    <DataMember()>
    Public CSRepo As String

    <DataMember()>
    Public CSThesaurus As String

    <DataMember()>
    Public CSHive As String

    <DataMember()>
    Public CSDMALicense As String

    <DataMember()>
    Public CSGateWay As String

    <DataMember()>
    Public CSTDR As String

    <DataMember()>
    Public CSKBase As String

    <DataMember()>
    Public CreateDate As Date

    <DataMember()>
    Public LastModDate As Date

    <DataMember()>
    Public SVCFS_Endpoint As String

    <DataMember()>
    Public SVCGateway_Endpoint As String

    <DataMember()>
    Public SVCCLCArchive_Endpoint As String

    <DataMember()>
    Public SVCSearch_Endpoint As String

    <DataMember()>
    Public SVCDownload_Endpoint As String

    <DataMember()>
    Public SVCFS_CS As String

    <DataMember()>
    Public SVCGateway_CS As String

    <DataMember()>
    Public SVCSearch_CS As String

    <DataMember()>
    Public SVCDownload_CS As String

    <DataMember()>
    Public SVCThesaurus_CS As String

End Class

<System.Runtime.Serialization.DataContract()>
Public Class DS_Combo

    <System.Runtime.Serialization.DataMember()>
    Public CompanyID As String

End Class
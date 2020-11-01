' NOTE: You can use the "Rename" command on the context menu to change the interface name "IService1" in both code and config file together.
<ServiceContract()>
Public Interface IService1

    <OperationContract()>
    Function ExecuteSqlNewConn(ByVal LocationID As Integer, ByVal UserGuidID As String, ByVal MySql As String, ByRef RetMsg As String) As Boolean

    <OperationContract()>
    Sub getFileParameters(ByVal EncCS As String, ByVal TgtGuid As String, ByRef FileName As String, ByRef fExt As String, ByVal TgtTable As String, ByRef RC As Boolean)

    <OperationContract()>
    Sub getRestoreFileSourceGuid(ByVal EncCS As String, ByVal UserID As String, ByRef RetGuids As Dictionary(Of String, String), ByRef RC As Boolean)

    <OperationContract()>
    Sub getPreviewFileSourceGuid(ByVal EncCS As String, ByVal UserID As String, ByRef RetGuids As Dictionary(Of String, String), ByRef RC As Boolean)

    <OperationContract()>
    Function ckRestoreFilesToProcess(ByVal EncCS As String, ByVal UserID As String, ByRef RC As Boolean) As Integer

    <OperationContract()>
    Function ckPreviewFileToProcess(ByVal EncCS As String, ByVal UserID As String, ByRef RC As Boolean) As Integer

    <OperationContract()>
    Sub writeImageSourceDataFromDbWriteToFile(ByVal EncCS As String, ByVal SourceGuid As String, ByRef FQN As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean, ByRef rMsg As String)

    <OperationContract()>
    Sub writeAttachmentFromDbWriteToFile(ByVal EncCS As String, ByVal RowID As String, ByRef FQN As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean, ByRef rMsg As String)

    <OperationContract()>
    Sub writeEmailFromDbToFile(ByVal EncCS As String, ByVal EmailGuid As String, ByRef SourceTypeCode As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean, ByRef rMsg As String)

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

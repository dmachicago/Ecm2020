Imports System.IO

' NOTE: You can use the "Rename" command on the context menu to change the interface name "IService1" in both code and config file together.
<ServiceContract()>
Public Interface IService1

    <OperationContract()>
    Function GetData(ByVal value As Integer) As String

    <OperationContract()>
    Function GetDataUsingDataContract(ByVal composite As CompositeType) As CompositeType

    ' TODO: Add your service operations here

    <OperationContract()> _
    Sub UploadFile(ByVal fileData As Stream)

    <OperationContract()>
    Sub RemoteFileUpload(ByVal request As RemoteFileUploadMsg)

    <OperationContract()> _
    Sub UploadZippedFile(ByVal data As FileStream)

End Interface

' Use a data contract as illustrated in the sample below to add composite types to service operations.

<DataContract()>
Public Class CompositeType

    <DataMember()>
    Public Property BoolValue() As Boolean

    <DataMember()>
    Public Property StringValue() As String

End Class

<MessageContract()>
Public Class RemoteFileUploadMsg

    <MessageHeader()>
    Public FileGuid As String

    <MessageHeader()>
    Public FileType As String

    <MessageHeader()>
    Public FileName As String

    <MessageHeader()>
    Public FileLength As Long

    <MessageHeader()>
    Public FileCrc As String

    <MessageHeader()>
    Public bCompressed As Boolean

    <MessageHeader()>
    Public UID As String

    <MessageBodyMember()>
    Public data As Stream


    'Protected Overrides Sub Dispose(ByVal disposing As Boolean)
    '    If disposing Then
    '        foo.Dispose()
    '        ' OR HERE ? '         
    '        bar.Dispose()
    '    End If
    '    MyBase.Dispose(disposing)
    'End Sub


    
End Class

' NOTE: You can use the "Rename" command on the context menu to change the class name "Service1" in code, svc and config file together.
Public Class SVCclcDownload
    Implements IService1

    Dim DB As New clsDatabase

    Public Function ExecuteSqlNewConn(ByVal LocationID As Integer, ByVal UserGuidID As String, ByVal MySql As String, ByRef RetMsg As String) As Boolean Implements IService1.ExecuteSqlNewConn
        Return DB.ExecuteSqlNewConn(LocationID, UserGuidID, MySql, RetMsg)
    End Function

    Public Sub getFileParameters(ByVal EncCS As String, ByVal TgtGuid As String, ByRef FileName As String, ByRef fExt As String, ByVal TgtTable As String, ByRef RC As Boolean) Implements IService1.getFileParameters
        DB.getFileParameters(EncCS, TgtGuid, FileName, fExt, TgtTable, RC)
    End Sub

    Public Sub getRestoreFileSourceGuid(ByVal EncCS As String, ByVal UserID As String, ByRef RetGuids As Dictionary(Of String, String), ByRef RC As Boolean) Implements IService1.getRestoreFileSourceGuid
        DB.getRestoreFileSourceGuid(EncCS, UserID, RetGuids, RC)
    End Sub

    Public Sub getPreviewFileSourceGuid(ByVal EncCS As String, ByVal UserID As String, ByRef RetGuids As Dictionary(Of String, String), ByRef RC As Boolean) Implements IService1.getPreviewFileSourceGuid
        DB.getPreviewFileSourceGuid(EncCS, UserID, RetGuids, RC)
    End Sub

    Public Function ckRestoreFilesToProcess(ByVal EncCS As String, ByVal UserID As String, ByRef RC As Boolean) As Integer Implements IService1.ckRestoreFilesToProcess
        Return DB.ckRestoreFilesToProcess(EncCS, UserID, RC)
    End Function

    Public Function ckPreviewFileToProcess(ByVal EncCS As String, ByVal UserID As String, ByRef RC As Boolean) As Integer Implements IService1.ckPreviewFileToProcess
        Return DB.ckPreviewFileToProcess(EncCS, UserID, RC)
    End Function

    ''' <summary>
    ''' 
    ''' </summary>
    ''' <param name="SourceGuid"></param>
    ''' <param name="FQN"></param>
    ''' <param name="CompressedDataBuffer"></param>
    ''' <param name="OriginalSize"></param>
    ''' <param name="CompressedSize"></param>
    ''' <param name="RC"></param>
    ''' <param name="rMsg"></param>
    ''' <remarks></remarks>
    Public Sub writeImageSourceDataFromDbWriteToFile(ByVal EncCS As String, ByVal SourceGuid As String, ByRef FQN As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean, ByRef rMsg As String) Implements IService1.writeImageSourceDataFromDbWriteToFile
        DB.writeImageSourceDataFromDbWriteToFile(EncCS, SourceGuid, FQN, CompressedDataBuffer, OriginalSize, CompressedSize, RC, rMsg)
    End Sub

    Public Sub writeAttachmentFromDbWriteToFile(ByVal EncCS As String, ByVal RowID As String, ByRef FQN As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean, ByRef rMsg As String) Implements IService1.writeAttachmentFromDbWriteToFile
        DB.writeAttachmentFromDbWriteToFile(EncCS, RowID, FQN, CompressedDataBuffer, OriginalSize, CompressedSize, RC, rMsg)
    End Sub

    Public Sub writeEmailFromDbToFile(ByVal EncCS As String, ByVal EmailGuid As String, ByRef SourceTypeCode As String, ByRef CompressedDataBuffer() As Byte, ByRef OriginalSize As Integer, ByRef CompressedSize As Integer, ByRef RC As Boolean, ByRef rMsg As String) Implements IService1.writeEmailFromDbToFile
        DB.writeEmailFromDbToFile(EncCS, EmailGuid, SourceTypeCode, CompressedDataBuffer, OriginalSize, CompressedSize, RC, rMsg)
    End Sub

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

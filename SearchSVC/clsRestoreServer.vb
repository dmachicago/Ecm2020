Public Class clsRestoreServer

    Public Function getPendingPreview(ByVal UserID As String) As Integer

        Dim iCnt As Integer

        Return iCnt

    End Function

    Public Function getPendingRestore(ByVal UserID As String, ByRef RC As Boolean) As list(Of DS_RestoreQueue)

        Dim ListOfItems As New DS_RestoreQueue
        Dim ContentGuid As String = ""
        Dim UseriD As String = ""
        Dim MachineID As String = ""
        Dim FQN As String = ""
        Dim FileSize As Integer = 0
        Dim ContentType As String = "" '** Default
        Dim Preview As Boolean = false
        Dim Restore As Boolean = false
        Dim ProcessingCompleted As Boolean = false
        Dim EntryDate As String = "" '** Default
        Dim ProcessedDate As String = "" '** Default
        Dim StartDownloadTime As String = "" '** Default
        Dim EndDownloadTime As String = "" '** Default
        Dim LocalIsoDir As String = ""

        Dim iCnt As Integer

        Return ListOfItems

    End Function


End Class

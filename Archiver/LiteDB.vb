
Module liteDB

    Public Class Zip_Store
        Dim RowNbr As Integer
        Dim DirID As Int32
        Dim FileID As Int32
        Dim FQN As String
        Dim EmailAttachment As Boolean
        Dim SuccessfullyProcessed As Boolean
        Dim fSize As Int64
        Dim CreateDate As DateTime
        Dim LastAccessDate As DateTime
        Dim NumberOfZipFiles As Integer
        Dim ParentGuid As String
        Dim InWork As Boolean
        Dim FileHash As String
    End Class


    Public Class DirFilesID_Store
        Dim FQN As String
        Dim LastArchiveDate As DateTime
        Dim FileLength As Int64
        Dim LastModDate As DateTime
    End Class

    Public Class Directory_Store
        Dim DirName As String
        Dim DirID As Integer
        Dim UseArchiveBit As Boolean
        Dim DirHash As String
        Dim LastArchiveDate As DateTime
    End Class

    Public Class Exts_Storage
        Dim Extension As String
        Dim Verified As Integer
    End Class

    Public Class FileNeedProcessing_Storage
        Dim RowID As Integer
        Dim FQN As String
        Dim LineID As Integer
        Dim LastProcessDate As DateTime
        Dim FileCompleted As Integer
    End Class

    Public Class Files_Storage
        Dim FileID As Integer
        Dim FileName As String
        Dim FileHash As String
    End Class

    Public Class Inventory_Storage
        Dim InvID As Integer
        Dim DirID As Integer
        Dim FileID As Integer
        Dim FileExist As Boolean
        Dim FileSize As Int64
        Dim CreateDate As DateTime
        Dim LastUpdate As DateTime
        Dim LastArchiveUpdate As DateTime
        Dim ArchiveBit As Boolean
        Dim NeedsArchive As Boolean
        Dim FileHash As String
    End Class

    Public Class ZipFile_Storage
        Dim RowNbr As Integer
        Dim DirID As Int32
        Dim FileID As Int32
        Dim FQN As String
        Dim EmailAttachment As Boolean
        Dim SuccessfullyProcessed As Boolean
        Dim fSize As Int64
        Dim CreateDate As DateTime
        Dim LastAccessDate As DateTime
        Dim NumberOfZipFiles As Integer
        Dim ParentGuid As String
        Dim InWork As Boolean
        Dim FileHash As String
    End Class

    Public Class Outlook_Store
        Dim RowID As Int32
        Dim sKey As String
        Dim KeyExists As Boolean
    End Class

    Public Class ContactsArchive_Store
        Dim RowID As Integer
        Dim Email1Address As String
        Dim FullName As String
    End Class

    '**********************************************

    Public Class DirListener_Store
        Dim RowID As Integer
        Dim ListenerFileName As String
        Dim LastIdProcessed As Integer
        Dim LastProcessDate As DateTime
        Dim FileCanBeDropped As Integer
        Dim RowCreateDate As DateTime
    End Class

    Public Class FileNeedProcessing_Store
        Dim RowID As Integer
        Dim ContainingFile As String
        Dim FQN As String
        Dim LineID As Integer
        Dim LastProcessDate As DateTime
        Dim FileApplied As Integer
        Dim RowCreateDate As DateTime
    End Class

    Public Class ProcessedListenerFiles_sTORE
        Dim RowID As Integer
        Dim ListenerFileName As String
        Dim RowCreateDate As DateTime
    End Class



End Module



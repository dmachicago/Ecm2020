'Imports System.Windows.Browser.HtmlPage
Imports System
Imports System.IO
Imports System.IO.IsolatedStorage
Imports System.IO.IsolatedStorage.IsolatedStorageFile
Imports System.IO.IsolatedStorage.IsolatedStorageFileStream

Public Class clsIsolatedStorage

    Public AppDir As String = Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)
    Public dirPersist As String = AppDir + "\" + "EcmPersistantData"
    Public dirAttachInfo As String = AppDir + "\" + "EcmAttachInfo"
    Public dirFormData As String = AppDir + "\" + "EcmForm"
    Public dirTempData As String = AppDir + "\" + "EcmTemp"
    Public dirLogData As String = AppDir + "\" + "EcmLogs"
    Public dirSaveData As String = AppDir + "\" + "EcmSavedData"

    'Public bDoNotOverwriteExistingFile As Boolean = True
    'Public bOverwriteExistingFile As Boolean = False
    'Public bRestoreToOriginalDirectory As Boolean = False
    'Public bRestoreToMyDocuments As Boolean = False
    'Public bCreateOriginalDirIfMissing As Boolean = True

    Sub New()

        'Dim store = IsolatedStorageFile.GetUserStoreForApplication()
        'isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User Or IsolatedStorageScope.Assembly Or IsolatedStorageScope.Domain, Nothing, Nothing)
        'Try
        '    store.CreateDirectory(dirAttachInfo)
        'Catch ex As Exception
        '    Console.WriteLine(ex.Message)
        'End Try

    End Sub

    Public Sub PersistDataInit(ByVal tKey As String, ByVal tData As String)

        Dim FQN As String = System.IO.Path.Combine(dirPersist, "Persist.dat")
        Dim Buffer() As Byte
        Dim tgtLine As String = tKey + "|" + tData + Environment.NewLine

        Try
            If Not Directory.Exists(dirPersist) Then
                Directory.CreateDirectory(dirPersist)
            End If

            Buffer = StrToByteArray(tgtLine)
            Dim isoStream2 As New StreamWriter(FQN, False)
            isoStream2.WriteLine(tgtLine)
            isoStream2.Close()
        Catch ex As IsolatedStorageException
            MessageBox.Show("Error SaveFormData 700: saving data: " + ex.Message)
        End Try
    End Sub

    Public Sub PersistDataSave(ByVal tKey As String, ByVal tData As String)

        'Dim dirFormData As String = "EcmTemp"
        Dim FQN As String = System.IO.Path.Combine(dirPersist, "Persist.dat")
        'Dim isoStore As IsolatedStorageFile
        'isoStore = IsolatedStorageFile.GetUserStoreForApplication
        Dim Buffer() As Byte
        Dim tgtLine As String = tKey + "|" + tData + Environment.NewLine
        Try
            'Using store = IsolatedStorageFile.GetUserStoreForApplication()
            If Not Directory.Exists(dirPersist) Then
                Directory.CreateDirectory(dirPersist)
            End If

            Buffer = StrToByteArray(tgtLine)
            Dim isoStream2 As New StreamWriter(FQN, True)
            isoStream2.Write(tgtLine)
            isoStream2.Close()

            'End Using
        Catch ex As IsolatedStorageException
            MessageBox.Show("Error SaveFormData 657: saving data: " + ex.Message)
        End Try
    End Sub

    Public Function PersistDataRead(ByVal tKey As String) As String

        Dim FQN As String = System.IO.Path.Combine(dirPersist, "Persist.dat")
        Dim ValName As String = ""
        Dim tgtVal As String = ""
        Dim RetVal As String = ""

        'Dim isoStore As IsolatedStorageFile
        'isoStore = IsolatedStorageFile.GetUserStoreForApplication
        'Using isoStore
        If File.Exists(FQN) Then
            Using sr As StreamReader = New StreamReader(FQN)
                RetVal = ""
                tgtVal = sr.ReadLine()
                Do While Not sr.EndOfStream
                    Dim A() As String = tgtVal.Split("|")
                    If A(0).Equals(tKey) Then
                        RetVal = A(1)
                        Exit Do
                    End If
                    tgtVal = sr.ReadLine()
                Loop
                sr.Close()
            End Using
        End If

        'End Using

        Return RetVal

    End Function

    Function readIsoFile(ByVal Filename As String) As String
        'If Not File.Exists(Filename) Then
        '    Return ""
        'End If
        Dim InputText As String = ""
        Try
            Dim isolatedStore As IsolatedStorageFile = IsolatedStorageFile.GetStore(IsolatedStorageScope.User Or IsolatedStorageScope.Assembly, Nothing, Nothing)
            Dim isolatedStream As New IsolatedStorageFileStream(Filename, FileMode.Open, isolatedStore)
            Dim reader As New StreamReader(isolatedStream)
            InputText = reader.ReadToEnd
            reader.Close()
        Catch ex As Exception
            If Not gRunUnattended Then
                Console.WriteLine("Notice: Failed to READ data from isolated storage #122." + ex.Message)
            End If
        End Try

        Return InputText
    End Function

    Public Sub saveIsoFile(ByVal FileName As String, ByVal sLine As String)
        Try
            Dim isolatedStore As IsolatedStorageFile = IsolatedStorageFile.GetStore(IsolatedStorageScope.User Or IsolatedStorageScope.Assembly, Nothing, Nothing)
            Dim isoStream As New IsolatedStorageFileStream(FileName, FileMode.Append, FileAccess.Write, isolatedStore)

            Dim writer As New StreamWriter(isoStream)
            writer.WriteLine(sLine)
            writer.Close()
        Catch ex As Exception
            If Not gRunUnattended Then
                MessageBox.Show("Notice: Failed to save data to isolated storage #121." + ex.Message)
            End If
        End Try
    End Sub
    Public Sub saveIsoFileZeroize(ByVal FileName As String, ByVal sLine As String)
        Try
            Dim isolatedStore As IsolatedStorageFile = IsolatedStorageFile.GetStore(IsolatedStorageScope.User Or IsolatedStorageScope.Assembly, Nothing, Nothing)
            Dim isoStream As New IsolatedStorageFileStream(FileName, FileMode.Create, FileAccess.Write, isolatedStore)

            Dim writer As New StreamWriter(isoStream)
            writer.WriteLine(sLine)
            writer.Close()

        Catch ex As Exception
            If Not gRunUnattended Then
                MessageBox.Show("Notice: Failed to save data to isolated storage #121." + ex.Message)
            End If
        End Try
    End Sub

    Public Shared Function StrToByteArray(ByVal str As String) As Byte()
        Dim encoding As New System.Text.UTF8Encoding()
        Return encoding.GetBytes(str)
    End Function 'StrToByteArray

    Public Function isoDirExist() As Boolean
        'Using store = IsolatedStorageFile.GetUserStoreForApplication()
        Using isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User Or IsolatedStorageScope.Assembly Or IsolatedStorageScope.Domain, Nothing, Nothing)
            For Each dName As String In isoStore.GetDirectoryNames(dirAttachInfo)
                If dName.Equals(dirAttachInfo) Then
                    Return True
                End If
            Next
        End Using
        Return False
    End Function
    Public Function isoFileExist() As Boolean
        If isoDirExist() Then
            Dim FormDataFileName As String = "AttachInfo.dat"
            Dim FQN As String = System.IO.Path.Combine(dirAttachInfo, FormDataFileName)
            Using isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User Or IsolatedStorageScope.Assembly Or IsolatedStorageScope.Domain, Nothing, Nothing)
                For Each fName As String In isoStore.GetFileNames(FQN)
                    If fName.Equals("AttachInfo.dat") Then
                        Return True
                    End If
                Next
            End Using
        End If
        Return False
    End Function

    Public Sub ZeroizeAttachData()
        Dim FormDataFileName As String = "AttachInfo.dat"
        Dim FQN As String = System.IO.Path.Combine(dirAttachInfo, FormDataFileName)

        Try
            If isoDirExist() Then
                Using isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User Or IsolatedStorageScope.Assembly Or IsolatedStorageScope.Domain, Nothing, Nothing)
                    isoStore.DeleteDirectory(dirAttachInfo)
                End Using
            End If
        Catch ex As IsolatedStorageException
            Console.WriteLine("Error SaveFormData 100: saving data: " + ex.Message)
        End Try
    End Sub

    Public Sub SaveAttachData(ByVal CompanyID As String, ByVal RepoID As String)

        Dim FormDataFileName As String = "AttachInfo.dat"
        Dim FQN As String = System.IO.Path.Combine(dirAttachInfo, FormDataFileName)
        Dim tgtLine As String = CompanyID + "|" + RepoID

        Dim isoStore As IsolatedStorageFile
        isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User Or IsolatedStorageScope.Assembly Or IsolatedStorageScope.Domain, Nothing, Nothing)

        If Not isoDirExist() Then
            isoStore.CreateDirectory(dirAttachInfo)
        End If

        Try
            ' Declare a new StreamWriter.
            Dim writer As StreamWriter = Nothing
            ' Assign the writer to the store and the file TestStore.
            writer = New StreamWriter(New IsolatedStorageFileStream(FQN, FileMode.Create, isoStore))
            writer.WriteLine(tgtLine + Environment.NewLine)
            writer.Close()
            writer.Dispose()
            writer = Nothing
        Catch ex As IsolatedStorageException
            Console.WriteLine("Error SaveFormData 200: saving data: " + ex.Message)
        End Try
        isoStore.Dispose()

    End Sub

    Public Function ReadAttachData(ByRef CompanyID As String, ByRef RepoID As String) As Boolean

        If Not Me.isoFileExist Then
            Return False
        End If

        CompanyID = ""
        RepoID = ""

        Dim isoStore As IsolatedStorageFile
        Dim B As Boolean = True
        Dim FormDataFileName As String = "AttachInfo.dat"
        Dim FQN As String = System.IO.Path.Combine(dirAttachInfo, FormDataFileName)
        Dim tgtLine As String = ""

        isoStore = IsolatedStorageFile.GetStore(IsolatedStorageScope.User Or IsolatedStorageScope.Assembly Or IsolatedStorageScope.Domain, Nothing, Nothing)
        Dim reader As New StreamReader(New IsolatedStorageFileStream(FQN, FileMode.Open, isoStore))
        Using isoStore
            Dim fLen As Integer = 0
            Using reader
                Try
                    tgtLine = reader.ReadLine()
                Catch ex As Exception
                    Return False
                End Try
                Dim A() As String = tgtLine.Split("|")
                CompanyID = A(0)
                RepoID = A(1)
                reader.Close()
                reader.Dispose()
            End Using
        End Using
        isoStore.Dispose()
        Return B

    End Function
    Private Function FileExists(FQN As String, storeFile As IsolatedStorageFile) As Boolean

        Dim fileString As String = Path.GetFileName(FQN)

        Dim files() As String
        files = storeFile.GetFileNames(FQN)

        Dim fileList As ArrayList = New ArrayList(files)

        If fileList.Count > 0 Then
            Return True
        Else
            Return False
        End If
      

    End Function


End Class



Imports System.IO
Imports System.Data.SqlClient
Imports C1.C1Zip

Public Class clsFiles

    Dim LOG As New clsLogging
    Dim COMP As New clsCompression
    Dim DB As New clsDbARCH

    Public Function UploadRemoteFile(ByVal tDict As Dictionary(Of String, String)) As String

        '** Check to see if this file requires OCR or PDF processing here
        '** If so, copy it to the Processing directory and let the command line utiltiy process it

        Dim bLoadFileToDB As Boolean = False
        Dim ErrMsg As String = ""
        Dim UploadPath As String = System.Configuration.ConfigurationManager.AppSettings("UploadPath")
        Dim EmailUploadPath As String = UploadPath + "\Email"
        Dim EmailAttachmentUploadPath As String = UploadPath + "\EmailAttachment"
        Dim ContentUploadPath As String = UploadPath + "\DataSource"

        Dim result As String = ""

        Dim tgtGuid As String = tDict("FileGuid")
        Dim FileLength As Long = tDict("FileLength")
        Dim FileName As String = tDict("FileName")
        Dim RepositoryTable As String = tDict("FileType").ToUpper
        Dim CRC As String = tDict("FileCrc")
        Dim UID As String = tDict("UID")
        Dim RetMsg As String = ""

        Dim FQN2Upload As String = UploadPath + "\" + FileName
        Dim FQN2Remove As String = UploadPath + "\" + FileName

        'FileName += ".NotReady"

        Dim filePath As String = Path.Combine(UploadPath, FileName)

        If Not Directory.Exists(UploadPath) Then
            Directory.CreateDirectory(UploadPath)
            LOG.WriteToArchiveFileTraceLog("Directory Not Found Creating", False)
        End If

        Dim S As String = ""
        If RepositoryTable.Equals("EMAIL") Then
            S = "Update EMAIL set FileAttached = 0, CRC = '" + CRC + "' where EmailGuid = '" + tgtGuid + "'"
        ElseIf RepositoryTable.Equals("EMAILATTACHMENT") Then
            S = "Update EmailAttachment set FileAttached = 0, CRC = '" + CRC + "' where RowGuid = '" + tgtGuid + "'"
        ElseIf RepositoryTable.Equals("DATASOURCE") Then
            S = "Update DataSource set FileAttached = 0, CRC = '" + CRC + "' where SourceGuid = '" + tgtGuid + "'"
        End If

        Dim B As Boolean = DB.ExecuteSqlNewConn(200920, UID, S, RetMsg)

        Dim iLoop As Integer = 0

        Try
            Dim outstream As Stream = File.Open(filePath, FileMode.Create, FileAccess.Write)
            Const bufferLen As Integer = 65536
            Dim buffer(bufferLen) As Byte
            Dim count As Integer = 0
            count = fStream.Read(buffer, 0, bufferLen)
            While (count > 0)
                iLoop += 1
                outstream.Write(buffer, 0, count)
                count = tDict.data.Read(buffer, 0, bufferLen)
            End While
            outstream.Close()
            tDict.data.Close()
            bLoadFileToDB = True
        Catch ex As IOException
            bLoadFileToDB = False
            LOG.WriteToArchiveFileTraceLog([String].Format("An exception was thrown while opening or writing to file {0}", filePath), False)
            LOG.WriteToArchiveFileTraceLog("ERROR UploadRemoteFile 100: " + ex.Message + vbCrLf + "FileName: " + FileName + vbCrLf + "FileLength: " + FileLength.ToString, False)
            ErrMsg = ex.Message
        End Try

        '** now is the time to decompress and add the file to the DB
        If bLoadFileToDB Then
            '** Decompress
            Dim A As System.Reflection.Assembly = Me.GetType.Assembly
            Dim fStream As Stream = a.GetManifestResourceStream(FQN2Upload)
            Dim myZip As New C1.C1Zip.C1ZipFile
            Try
                '*********************************************************
                '** Decompress Zip File
                '********************************************************
                If Not Directory.Exists(EmailUploadPath) Then
                    Directory.CreateDirectory(EmailUploadPath)
                End If
                If Not Directory.Exists(EmailAttachmentUploadPath) Then
                    Directory.CreateDirectory(EmailAttachmentUploadPath)
                End If
                If Not Directory.Exists(ContentUploadPath) Then
                    Directory.CreateDirectory(ContentUploadPath)
                End If
                myZip.Open(FQN2Upload)
                For Each zipEntry As C1.C1Zip.C1ZipEntry In myZip.Entries
                    Dim bGoodCrc As Boolean = zipEntry.CheckCRC32
                    If bGoodCrc Then
                        Dim zFilename As String = zipEntry.FileName
                        If RepositoryTable.Equals("EMAIL") Then
                            FQN2Upload = EmailUploadPath + "\" + tgtGuid + ".RDY"
                            zipEntry.Extract(FQN2Upload)
                        ElseIf RepositoryTable.Equals("EMAILATTACHMENT") Then
                            FQN2Upload = EmailAttachmentUploadPath + "\" + tgtGuid + ".RDY"
                            zipEntry.Extract(FQN2Upload)
                        ElseIf RepositoryTable.Equals("DATASOURCE") Then
                            FQN2Upload = ContentUploadPath + "\" + tgtGuid + ".RDY"
                            zipEntry.Extract(FQN2Upload)
                        End If
                    End If
                Next
            Catch ex As Exception
                MsgBox(ex.Message)
                Console.Write(ex.Message)
            Finally
                '*********************************************************
                '** Delete zip file
                '*********************************************************
                myZip.Close()
                File.Delete(FQN2Remove)
            End Try

            'Dim NullBuffer(0) As Byte
            'NullBuffer(0) = &H0
            'Dim outstream2 As Stream = File.Open(FQN2Upload, FileMode.Create, FileAccess.Write)
            'outstream2.Seek(0, SeekOrigin.End)
            'outstream2.Write(NullBuffer, 0, NullBuffer.Length)

            '**** Load a Byte Array with the just loaded file ************
            Dim oFile As System.IO.FileInfo
            oFile = New System.IO.FileInfo(FQN2Upload)
            Dim xFileStream As System.IO.FileStream = oFile.OpenRead()
            Dim lBytes As Long = xFileStream.Length
            Dim fileData(lBytes - 1) As Byte
            If (lBytes > 0) Then
                ' Read the file into a byte array
                xFileStream.Read(fileData, 0, lBytes)
                xFileStream.Close()
                xFileStream.Dispose()
            End If

            Dim SuccessfulUpload As Boolean = True
            Dim ConnStr As String = DB.set
            Dim CONN As New SqlConnection(ConnStr)
            If CONN.State = ConnectionState.Closed Then
                CONN.Open()
            End If
            Dim cmd As New SqlCommand("UpdateSourceFilestream", CONN)
            cmd.CommandType = CommandType.StoredProcedure
            Try
                Using CONN
                    Using cmd
                        cmd.Parameters.Add(New SqlParameter("@SourceGuid", tgtGuid))
                        cmd.Parameters.Add(New SqlParameter("@SourceImage", fileData))
                        cmd.ExecuteNonQuery()
                    End Using
                End Using
            Catch ex As Exception
                SuccessfulUpload = False
                MsgBox("ERROR UploadBufferedCreate 100: " + ex.Message)
            Finally
                oFile = Nothing
                fileData = Nothing
                cmd.Dispose()
                If CONN.State = ConnectionState.Open Then
                    CONN.Close()
                End If
                CONN.Dispose()
                File.Delete(FQN2Upload)

                If RepositoryTable.Equals("EMAIL") Then
                    S = "Update EMAIL set FileAttached = 1 where SourceGuid = '" + tgtGuid + "'"
                ElseIf RepositoryTable.Equals("EMAILATTACHMENT") Then
                    S = "Update EmailAttachment set FileAttached = 1 where SourceGuid = '" + tgtGuid + "'"
                ElseIf RepositoryTable.Equals("DATASOURCE") Then
                    S = "Update DataSource set FileAttached = 1 where SourceGuid = '" + tgtGuid + "'"
                End If

                B = DB.ExecuteSqlNewConn(200919, UID, S, RetMsg)

            End Try
        End If
        GC.Collect()

        Return ErrMsg

    End Function

    Public Function UploadFile(ByVal fStream As Stream) As Boolean

        '** Check to see if this file requires OCR or PDF processing here
        '** If so, copy it to the Processing directory and let the command line utiltiy process it

        Dim UploadPath As String = System.Configuration.ConfigurationManager.AppSettings("UploadPath")

        'this implementation places the uploaded file
        'in the current directory and calls it "uploadedfile"
        'with no file extension
        'Dim filePath As String = Path.Combine(System.Environment.CurrentDirectory, "uploadedfile")
        Dim filePath2 As String = Path.Combine(System.Environment.CurrentDirectory, "uploadedfile")
        Dim filePath As String = Path.Combine(UploadPath, "uploadedfile")

        If Not Directory.Exists(UploadPath) Then
            Directory.CreateDirectory(UploadPath)
        End If

        Try

            Console.WriteLine("Saving to file {0}", filePath)
            Dim outstream As Stream = File.Open(filePath, FileMode.Create, FileAccess.Write)
            'read from the input stream in 4K chunks
            'and save to output stream
            Const bufferLen As Integer = 4096
            Dim buffer(bufferLen) As Byte
            Dim count As Integer = 0
            count = fStream.Read(buffer, 0, bufferLen)
            While (count > 0)

                Console.Write(".")
                outstream.Write(buffer, 0, count)
                count = fStream.Read(buffer, 0, bufferLen)

            End While
            outstream.Close()
            fStream.Close()
            Console.WriteLine()
            Console.WriteLine("File {0} saved", filePath)

            Return True

        Catch ex As IOException

            Console.WriteLine([String].Format("An exception was thrown while opening or writing to file {0}", filePath))
            Console.WriteLine("Exception is: ")
            Console.WriteLine(ex.ToString())
            Throw ex

        End Try

    End Function

    Public Function UploadZippedFile(ByVal fStream As FileStream) As Boolean

        '** Check to see if this file requires OCR or PDF processing here
        '** If so, copy it to the Processing directory and let the command line utiltiy process it

        Dim B As Boolean = True

        Dim UploadPath As String = System.Configuration.ConfigurationManager.AppSettings("UploadPath")

        'this implementation places the uploaded file
        'in the current directory and calls it "uploadedfile"
        'with no file extension
        'Dim filePath As String = Path.Combine(System.Environment.CurrentDirectory, "uploadedfile")
        Dim filePath2 As String = Path.Combine(System.Environment.CurrentDirectory, "uploadedfile")
        Dim filePath As String = Path.Combine(UploadPath, "uploadedfile")

        If Not Directory.Exists(UploadPath) Then
            Directory.CreateDirectory(UploadPath)
        End If

        Dim CodedFileName As String = COMP.UnZipFile(UploadPath, filePath)

        Try

            Console.WriteLine("Saving to file {0}", filePath)
            Dim outstream As FileStream = File.Open(filePath, FileMode.Create, FileAccess.Write)
            'read from the input stream in 4K chunks
            'and save to output stream
            Const bufferLen As Integer = 4096
            Dim buffer(bufferLen) As Byte
            Dim count As Integer = 0
            count = fStream.Read(buffer, 0, bufferLen)
            While (count > 0)

                Console.Write(".")
                outstream.Write(buffer, 0, count)
                count = fStream.Read(buffer, 0, bufferLen)

            End While
            outstream.Close()
            fStream.Close()
            Console.WriteLine()
            Console.WriteLine("File {0} saved", filePath)

            Return True

        Catch ex As IOException

            Console.WriteLine([String].Format("An exception was thrown while opening or writing to file {0}", filePath))
            Console.WriteLine("Exception is: ")
            Console.WriteLine(ex.ToString())
            Throw ex

        End Try

        MarkFileAsReadyToInsertIntoDB(CodedFileName)

    End Function

    Function MarkFileAsReadyToInsertIntoDB(ByVal FQN As String) As Boolean
        Dim B As Boolean = True
        Dim NewName As String = ""
        If InStr(FQN, ".NotReady", CompareMethod.Text) > 0 Then
            NewName = Mid(FQN, 1, FQN.Length - 9)
        End If
        Try
            My.Computer.FileSystem.RenameFile(FQN, NewName)
            B = True
        Catch ex As Exception
            B = False
        End Try


        Return B
    End Function
End Class

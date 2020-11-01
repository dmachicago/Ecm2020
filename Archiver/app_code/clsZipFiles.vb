#Const RemoteOcr = 0

Imports System.Data.SqlClient
Imports System.IO
Imports Outlook = Microsoft.Office.Interop.Outlook
Imports System.Reflection
Imports System.Data.Sql
Imports System.Configuration
Imports System.Configuration.AppSettingsReader
Imports System.Configuration.ConfigurationSettings
Imports System.Security.Principal
Imports ECMEncryption

Public Class clsZipFiles

    Dim TotalFilesEvaluated As Integer = 0

    Dim WithEvents zip As New Chilkat.Zip
    Dim DMA As New clsDma
    Dim UTIL As New clsUtility
    Dim LOG As New clsLogging
    Dim ENC As new ECMEncrypt

    Dim ISO As New clsIsolatedStorage
    Dim ZDS As New clsZIPDATASOURCE
    Dim DBARCH As New clsDatabaseARCH
    Dim UNASGND As New clsAVAILFILETYPESUNDEFINED
    Dim SRCATTR As New clsSOURCEATTRIBUTE
    'Dim CMODI As New clsModi
    Dim ddebug As Boolean = True
    Public ExcludedTypes As New ArrayList
    Public IncludedTypes As New ArrayList

    Function getZipPassword() As String
        Dim S As String = ""
        S += "X"
        S += "@"
        S += "v"
        S += "1"
        S += "3"
        S += "r"
        Return S
    End Function

    Public Function UploadZipFile(ByVal UID As String,
                                  ByVal MachineID As String,
                                  ByVal FQN As String,
                                  ByVal ParentZipGuid As String,
                                  ByVal SkipIfAlreadyArchived As Boolean,
                                  ByVal bThisIsAnEmail As Boolean,
                                  ByVal RetentionCode As String,
                                  ByVal isPublic As String,
                                  ByVal StackLevel As Integer,
                                  ByRef ListOfFiles As Dictionary(Of String, Integer)) As Boolean

        If gTraceFunctionCalls.Equals(1) Then
            LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodInfo.GetCurrentMethod().ToString)
        End If

        Dim ExplodeContentZip As String = DBARCH.getSystemParm("ExplodeContentZip")
        If (ExplodeContentZip.Equals("N")) Then
            Return True
        End If
        ' ExplodeEmailAttachment()
        ' ExplodeEmailZip()
        ' ExplodeContentZip()

        'Check to see if the "EXPLODE ZIP FILE flag is true and if so, just return true.

        StackLevel += 1
        Dim isArchiveBitOn As Boolean = DMA.isArchiveBitOn(FQN)
        Dim bIsArchivedAlready As Boolean = DMA.isFileArchiveAttributeSet(FQN)
        Dim ZipProcessingDir As String = UTIL.getTempProcessingDir
        ZipProcessingDir = ZipProcessingDir + "TempZip" + Guid.NewGuid.ToString
        ZipProcessingDir = ZipProcessingDir.Replace("\\", "\")

        If Not Directory.Exists(ZipProcessingDir) Then
            Try
                Directory.CreateDirectory(ZipProcessingDir)
            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR UploadZipFile 100: Failed to create temporary unzip directory, " + ZipProcessingDir + ", aborting.")
                Return False
            End Try
        End If

        Dim fExt$ = UTIL.getFileSuffix(FQN)
        Dim B As Boolean = False

        fExt = fExt.ToUpper
        If UCase(fExt).Equals("ZIP") Then
            B = UnZip(FQN, ZipProcessingDir)
            If B Then
                If Not bThisIsAnEmail Then
                    UnzipAndLoadContent(UID, MachineID, ZipProcessingDir, ParentZipGuid, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ListOfFiles)
                Else
                    UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, ParentZipGuid, Nothing, StackLevel, ListOfFiles)
                End If
            Else
                If Not bThisIsAnEmail Then
                    DBARCH.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: UploadZipFile -  The ZIP file '" + FQN + "' failed to extract and load.")
                Else
                    DBARCH.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: UploadZipFile -  The ZIP file '" + FQN + "' failed to extract and load.")
                End If

            End If
            DMA.ToggleArchiveBit(FQN)

        ElseIf fExt.Equals("ISO") _
                Or fExt.Equals("ARJ") _
                Or fExt.Equals("CAB") _
                Or fExt.Equals("CHM") _
                Or fExt.Equals("CPIO") _
                Or fExt.Equals("CramFS") _
                Or fExt.Equals("DEB") _
                Or fExt.Equals("DMG") _
                Or fExt.Equals("FAT") _
                Or fExt.Equals("HFS") _
                Or fExt.Equals("LZH") _
                Or fExt.Equals("LZMA") _
                Or fExt.Equals("MBR") _
                Or fExt.Equals("MSI") _
                Or fExt.Equals("NSIS") _
                Or fExt.Equals("NTFS") _
                Or fExt.Equals("RPM") _
                Or fExt.Equals("SquashFS") _
                Or fExt.Equals("UDF") _
                Or fExt.Equals("VHD") _
                Or fExt.Equals("WIM") _
                Or fExt.Equals("XAR") _
                Then

            B = Un7zip(FQN$, ZipProcessingDir)
            'WDMXXXX
            If B Then
                If Not bThisIsAnEmail Then
                    UnzipAndLoadContent(UID, MachineID, ZipProcessingDir, ParentZipGuid, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ListOfFiles)
                Else
                    UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, ParentZipGuid, Nothing, StackLevel, ListOfFiles)
                End If
            Else
                If Not bThisIsAnEmail Then
                    DBARCH.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: UploadZipFile -  The " + fExt + " file '" + FQN + "' failed to extract and load.")
                Else
                    DBARCH.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: UploadZipFile -  The " + fExt + " file '" + FQN + "' failed to extract and load.")
                End If
            End If
            'Dim TheFileIsArchived As Boolean = True
            'DMA.setFileArchiveAttributeSet(FQN, TheFileIsArchived)
            DMA.ToggleArchiveBit(FQN)
        ElseIf UCase(fExt).Equals("RAR") Then
            B = UnRar(FQN$)
            If B Then
                If Not bThisIsAnEmail Then
                    UnzipAndLoadContent(UID, MachineID, ZipProcessingDir, ParentZipGuid, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ListOfFiles)
                Else
                    UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, ParentZipGuid, Nothing, StackLevel, ListOfFiles)
                End If
            Else
                If Not bThisIsAnEmail Then
                    DBARCH.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: UploadZipFile -  The RAR file '" + FQN + "' failed to extract and load.")
                Else
                    DBARCH.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: UploadZipFile -  The RAR file '" + FQN + "' failed to extract and load.")
                End If
            End If
            'Dim TheFileIsArchived As Boolean = True
            'DMA.setFileArchiveAttributeSet(FQN, TheFileIsArchived)
            DMA.ToggleArchiveBit(FQN)
        ElseIf UCase(fExt).Equals("GZ") Then
            B = UntarGZarchive(FQN$)
            If B Then
                If Not bThisIsAnEmail Then
                    UnzipAndLoadContent(UID, MachineID, ZipProcessingDir, ParentZipGuid, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ListOfFiles)
                Else
                    UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, ParentZipGuid, Nothing, StackLevel, ListOfFiles)
                End If
            Else
                If Not bThisIsAnEmail Then
                    DBARCH.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: UploadZipFile -  The GZ file '" + FQN + "' failed to extract and load.")
                Else
                    DBARCH.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: UploadZipFile -  The GZ file '" + FQN + "' failed to extract and load.")
                End If
            End If
            'Dim TheFileIsArchived As Boolean = True
            'DMA.setFileArchiveAttributeSet(FQN, TheFileIsArchived)
            DMA.ToggleArchiveBit(FQN)
        ElseIf UCase(fExt).Equals("Z") Then
            B = Me.UntarZarchive(FQN$)
            If B Then
                If Not bThisIsAnEmail Then
                    UnzipAndLoadContent(UID, MachineID, ZipProcessingDir, ParentZipGuid, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ListOfFiles)
                Else
                    UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, ParentZipGuid, Nothing, StackLevel, ListOfFiles)
                End If
            Else
                If Not bThisIsAnEmail Then
                    DBARCH.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: UploadZipFile -  The Z-ZIP file '" + FQN + "' failed to extract and load.")
                Else
                    DBARCH.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: UploadZipFile -  The Z-ZIP file '" + FQN + "' failed to extract and load.")
                End If
            End If
            'Dim TheFileIsArchived As Boolean = True
            'DMA.setFileArchiveAttributeSet(FQN, TheFileIsArchived)
            DMA.ToggleArchiveBit(FQN)
        ElseIf UCase(fExt).Equals("TAR") Then
            B = UnTarArchive(FQN$)
            If B Then
                If Not bThisIsAnEmail Then
                    UnzipAndLoadContent(UID, MachineID, ZipProcessingDir, ParentZipGuid, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ListOfFiles)
                Else
                    UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, ParentZipGuid, Nothing, StackLevel, ListOfFiles)
                End If
            Else
                If Not bThisIsAnEmail Then
                    DBARCH.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: UploadZipFile -  The TAR file '" + FQN + "' failed to extract and load.")
                Else
                    DBARCH.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: UploadZipFile -  The TAR file '" + FQN + "' failed to extract and load.")
                End If
            End If
            'Dim TheFileIsArchived As Boolean = True
            'DMA.setFileArchiveAttributeSet(FQN, TheFileIsArchived)
            DMA.ToggleArchiveBit(FQN)
        End If

    End Function

    Sub UnzipAndLoadContent(ByVal UID As String,
                            ByVal MachineID As String,
                            ByVal ZipProcessingDir As String,
                            ByVal ParentSourceGuid As String,
                            ByVal bThisIsAnEmail As Boolean,
                            ByVal RetentionCode As String,
                            ByVal isPublic As String,
                            ByVal StackLevel As Integer,
                            ByRef ListOfFiles As Dictionary(Of String, Integer))

        Dim ExplodeContentZip As String = DBARCH.getSystemParm("ExplodeContentZip")
        If (ExplodeContentZip.Equals("N")) Then
            Return
        End If
        ' ExplodeEmailAttachment()
        ' ExplodeEmailZip()
        ' ExplodeContentZip()
        'Check to see if the "EXPLODE ZIP FILE flag is true and if so, just return true.

        Dim DirFiles As New List(Of String)
        Dim DirFiles2 As New List(Of String)

        Dim LibraryList As New List(Of String)

        Dim NewSourceGuid As String = System.Guid.NewGuid.ToString()

        IncludedTypes = DBARCH.GetAllIncludedFiletypes(ZipProcessingDir, "N")
        ExcludedTypes = DBARCH.GetAllExcludedFiletypes(ZipProcessingDir, "N")

        If IncludedTypes.Count = 0 Then
            IncludedTypes.Add("*")
        End If

        Dim bChanged As Boolean = False
        '** Get all of the files in this folder

        Dim DirectoryList As New ArrayList

        GetDirectories(ZipProcessingDir, DirectoryList)

        Dim ii As Integer = 0

        If DirectoryList.Count > 0 Then
            For X As Integer = 0 To DirectoryList.Count - 1
                Dim tDir$ = DirectoryList(X)
                Try
                    ii += DMA.getFilesInDir(tDir$, DirFiles, IncludedTypes, ExcludedTypes, False)
                Catch ex As Exception
                    LOG.WriteToArchiveLog("clsZipFiles : LoadUnzippedFiles : 62 : " + ex.Message)
                    Return
                End Try
            Next
        End If

        ii = DMA.getFilesInDir(ZipProcessingDir, DirFiles2, IncludedTypes, ExcludedTypes, False)

        For Each SS As String In DirFiles2
            DirFiles.Add(SS)
        Next

        If ii = 0 Then
            Return
        End If
        For K As Integer = 0 To DirFiles.Count - 1
            TotalFilesEvaluated = TotalFilesEvaluated + 1

            NewSourceGuid = System.Guid.NewGuid.ToString()

            Dim FileAttributes() As String = DirFiles(K).Split("|")
            Dim file_FullName As String = FileAttributes(1)
            Dim file_SourceName As String = FileAttributes(0)

            Dim iExist As Integer = 0
            iExist = DBARCH.iCount("select COUNT(*) from DataSource where SourceName = '" + UTIL.RemoveSingleQuotes(file_SourceName) + "' and SourceGuid = '" + ParentSourceGuid + "'")
            If iExist = 0 Then
                iExist = DBARCH.iCount("select COUNT(*) from EmailAttachment where AttachmentName = '" + UTIL.RemoveSingleQuotes(file_SourceName) + "' and EmailGuid = '" + ParentSourceGuid + "'")
            End If

            If iExist > 0 Then
                GoTo NextFile
            End If

            Dim CrcHash As String = ENC.GenerateSHA512HashFromFile(file_FullName)

            If ListOfFiles.Keys.Contains(file_FullName) Then
                Dim Level As Integer = ListOfFiles.Item(file_FullName)
                If Level <= StackLevel Then
                    GoTo NextFile
                End If
            Else
                ListOfFiles.Add(file_FullName, StackLevel)
            End If

            Application.DoEvents()
            Dim file_Length$ = FileAttributes(2)
            If gMaxSize > 0 Then
                If Val(file_Length) > gMaxSize Then
                    LOG.WriteToArchiveLog("Notice: file '" + file_FullName$ + "' exceed the allowed file upload size, skipped.")
                    GoTo NextFile
                End If
            End If
            Dim iLen As Double = CDbl(file_Length$)
            frmNotify.lblFileSpec.Text = "ZIP Load: " + (K + 1).ToString + " of " + DirFiles.Count.ToString + " / " + (iLen / 1000).ToString + "/kb" + " : " + file_SourceName$
            frmNotify.Refresh()

            Dim file_DirName$ = DMA.GetFilePath(file_FullName$)

            '** WDMXX
            DBARCH.GetDirectoryLibraries(file_DirName$, LibraryList)

            Dim file_SourceTypeCode$ = FileAttributes(3)
            Dim file_LastAccessDate$ = FileAttributes(4)
            Dim file_CreateDate$ = FileAttributes(5)
            Dim file_LastWriteTime$ = FileAttributes(6)
            Dim OriginalFileType$ = file_SourceTypeCode$

            Dim bcnt As Integer = DBARCH.iGetRowCount("SourceType", "where SourceTypeCode = '" + file_SourceTypeCode$ + "'")
            If bcnt = 0 Then
                Dim SubstituteFileType$ = DBARCH.getProcessFileAsExt(file_SourceTypeCode$)
                If SubstituteFileType$ = Nothing Then
                    Dim MSG$ = "The file type '" + file_SourceTypeCode$ + "' is undefined." + vbCrLf + "DO YOU WISH TO AUTOMATICALLY DEFINE IT?" + vbCrLf + "This will allow content to be archived, but not searched."
                    'Dim dlgRes As DialogResult = 'MessageBox.Show(MSG, "Filetype Undefined", MessageBoxButtons.YesNo)

                    UNASGND.setApplied("0")
                    UNASGND.setFiletype(file_SourceTypeCode$)
                    Dim iCnt As Integer = UNASGND.cnt_PK_AFTU(file_SourceTypeCode$)
                    If iCnt = 0 Then
                        UNASGND.Insert()
                    End If

                    Dim ST As New clsSOURCETYPE
                    ST.setSourcetypecode(file_SourceTypeCode$)
                    ST.setSourcetypedesc("Extension " + file_SourceTypeCode$ + " AUTO ADDED")
                    ST.setIndexable("0")
                    ST.setStoreexternal(0)
                    ST.Insert()
                Else
                    file_SourceTypeCode$ = SubstituteFileType$
                End If
            End If

            Dim StoredExternally As String = "N"
            Dim iDatasourceCnt As Integer = DBARCH.getCountDataSourceFiles(file_SourceName, CrcHash)
            If (iDatasourceCnt = 0) Then
                DBARCH.saveContentOwner(NewSourceGuid, gCurrUserGuidID, "C", file_DirName, gMachineID, gNetworkID)
            End If


            Dim SkipIfAlreadyArchived As Boolean = True

            If iDatasourceCnt = 0 Then
                '*******************************************
                '* File does not exist in REPO, Add it
                '*******************************************
                Dim LastVerNbr As Integer = 99
                Dim BB As Boolean = False

                Try
                    If file_SourceTypeCode.ToUpper.Equals(".MSG") Then
                        Dim EMX As New clsEmailFunctions
                        Dim xAttachedFiles As New List(Of String)
                        If File.Exists(file_FullName) Then
                            EMX.LoadMsgFile(UID, file_FullName, gMachineID, "CONTENT-ZIP-FILE", "", RetentionCode$, "UNKNOWN", "", xAttachedFiles, False, NewSourceGuid$, "FOUND IN CONTENT ZIP FILE:" + file_FullName.Replace("'", "`"))
                        End If
                        EMX = Nothing
                    Else

                        Dim AttachmentCode As String = "C"
                        'Dim CrcHash As String = ENC.getCountDataSourceFiles(file_FullName)

                        BB = DBARCH.AddSourceToRepo(UID, MachineID, gNetworkID, NewSourceGuid$, file_FullName, file_SourceName, file_SourceTypeCode, file_LastAccessDate$, file_CreateDate$, file_LastWriteTime$, gCurrUserGuidID, LastVerNbr, RetentionCode, isPublic, CrcHash, file_DirName$)
                        If BB Then
                            Dim BBX As Boolean = DBARCH.ExecuteSqlNewConn(90000, "Update DataSource set ParentGuid = '" + ParentSourceGuid + "' where SourceGuid = '" + NewSourceGuid$ + "' ")
                        End If
                    End If
                Catch ex As Exception
                    LOG.WriteToArchiveLog("ERROR DBARCH.AddSourceToRepo 300a " + ex.Message)
                    BB = False
                End Try

                If BB Then
                    If isZipFile(file_FullName) Then
                        Dim RC As Boolean = UploadZipFile(UID, MachineID, file_FullName, ParentSourceGuid, SkipIfAlreadyArchived, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ListOfFiles)
                    End If

                    If LibraryList.Count > 0 Then
                        For III As Integer = 0 To LibraryList.Count - 1
                            Dim LibraryName$ = LibraryList(III)
                            Dim ARCH As New clsArchiver
                            ARCH.AddLibraryItem(NewSourceGuid$, file_SourceName, file_SourceTypeCode, LibraryName$)
                            ARCH = Nothing
                            GC.Collect()
                            GC.WaitForPendingFinalizers()
                        Next
                    End If
                    Application.DoEvents()

                    DBARCH.UpdateDocFqn(NewSourceGuid$, file_FullName)
                    DBARCH.UpdateDocSize(NewSourceGuid$, file_Length$)
                    DBARCH.UpdateDocDir(NewSourceGuid$, file_FullName)
                    DBARCH.UpdateDocOriginalFileType(NewSourceGuid$, OriginalFileType$)
                    DBARCH.UpdateZipFileIndicator(NewSourceGuid$, False)
                    DBARCH.UpdateIsContainedWithinZipFile(NewSourceGuid$)
                    Dim ZipFileFqn$ = DBARCH.getFqnFromGuid(ParentSourceGuid)
                    DBARCH.UpdateZipFileOwnerGuid(ParentSourceGuid, NewSourceGuid$, ZipFileFqn$)

                    Application.DoEvents()
                    InsertSrcAttrib(NewSourceGuid$, "FILENAME", file_SourceName, OriginalFileType$)
                    InsertSrcAttrib(NewSourceGuid$, "CreateDate", file_CreateDate$, OriginalFileType$)
                    InsertSrcAttrib(NewSourceGuid$, "FILESIZE", file_Length$, OriginalFileType$)
                    InsertSrcAttrib(NewSourceGuid$, "ChangeDate", file_LastAccessDate, OriginalFileType$)
                    InsertSrcAttrib(NewSourceGuid$, "WriteDate", file_LastWriteTime$, OriginalFileType$)

                End If
                'Else
                '    Dim FOLDER_VersionFiles$ = "Y"  '** This is a ZIPPED file, version it right upfront
                '    If UCase(FOLDER_VersionFiles$).Equals("Y") Then
                '        '** Get the last version number of this file in the repository,
                '        Dim LastVerNbr As Integer = DBARCH.GetMaxDataSourceVersionNbr(gCurrUserGuidID, file_FullName$)
                '        Dim NextVersionNbr As Integer = LastVerNbr + 1
                '        '** See if this version has been changed

                '        Dim AttachmentCode As String = "C"
                '        'Dim CrcHash As String = ENC.getCountDataSourceFiles(file_SourceName$)

                '        bChanged = DBARCH.isSourcefileOlderThanLastEntry(file_SourceName$, CrcHash)
                '        '** If it has, add it to the repository
                '        If bChanged Then

                '            Dim BB As Boolean = False
                '            Try
                '                BB = DBARCH.AddSourceToRepo(UID, MachineID, gNetworkID, NewSourceGuid$, _
                '                                     file_FullName, _
                '                                     file_SourceName, _
                '                                     file_SourceTypeCode, _
                '                                     file_LastAccessDate$, _
                '                                     file_CreateDate$, _
                '                                     file_LastWriteTime$, gCurrUserGuidID, NextVersionNbr, RetentionCode, isPublic, CrcHash, file_DirName$)

                '                If BB Then
                '                    Dim BBX As Boolean = DBARCH.ExecuteSqlNewConn("Update DataSource set ParentGuid = '" + ParentSourceGuid + "' where SourceGuid = '" + NewSourceGuid$ + "' ")
                '                End If

                '                If LibraryList.Count > 0 Then
                '                    For III As Integer = 0 To LibraryList.Count - 1
                '                        Dim LibraryName$ = LibraryList(III)
                '                        DBARCH.AddLibraryItem(NewSourceGuid$, file_SourceName, file_SourceTypeCode, LibraryName$)
                '                    Next
                '                End If

                '                'Dim VersionNbr As String = "0"

                '                DBARCH.UpdateDocFqn(NewSourceGuid$, file_FullName)
                '                DBARCH.UpdateDocSize(NewSourceGuid$, file_Length$)
                '                DBARCH.UpdateDocDir(NewSourceGuid$, file_FullName)
                '                DBARCH.UpdateDocOriginalFileType(NewSourceGuid$, OriginalFileType$)
                '                DBARCH.UpdateZipFileIndicator(NewSourceGuid$, False)
                '                DBARCH.UpdateIsContainedWithinZipFile(NewSourceGuid$)
                '                Dim ZipFileFqn$ = DBARCH.getFqnFromGuid(ParentSourceGuid)
                '                DBARCH.UpdateZipFileOwnerGuid(ParentSourceGuid, NewSourceGuid$, ZipFileFqn$)

                '                'DBARCH.delFileParms(NewSourceGuid$)
                '                InsertSrcAttrib(NewSourceGuid$, "FILENAME", file_SourceName, OriginalFileType$)
                '                InsertSrcAttrib(NewSourceGuid$, "CreateDate", file_CreateDate$, OriginalFileType$)
                '                InsertSrcAttrib(NewSourceGuid$, "FILESIZE", file_Length$, OriginalFileType$)
                '                InsertSrcAttrib(NewSourceGuid$, "ChangeDate", file_LastAccessDate, OriginalFileType$)
                '                InsertSrcAttrib(NewSourceGuid$, "WriteDate", file_LastWriteTime$, OriginalFileType$)

                '            Catch ex As Exception
                '                LOG.WriteToArchiveLog("ERROR DBARCH.AddSourceToRepo 200 " + ex.Message)
                '                BB = False
                '            End Try
                '        End If

                '    Else
                '        '** The document has changed, but versioning is not on...
                '        '** Delete and re-add.
                '        '** If zero add
                '        '** if 1, see if changed and if so, update, if not skip it   
                '        Dim LastVerNbr As Integer = DBARCH.GetMaxDataSourceVersionNbr(gCurrUserGuidID, file_FullName$)
                '        Dim AttachmentCode As String = "C"

                '        bChanged = DBARCH.isSourcefileOlderThanLastEntry(file_SourceName$, CrcHash)
                '        '** If it has, add it to the repository
                '        If bChanged Then
                '            Dim BB As Boolean = False

                '            Dim OriginalFileName As String = DMA.getFileName(file_FullName)
                '            BB = DBARCH.UpdateSourceImageInRepo(OriginalFileName, UID, MachineID, NewSourceGuid$, file_LastAccessDate$, file_CreateDate$, file_LastWriteTime$, LastVerNbr, file_FullName, RetentionCode, isPublic, CrcHash)
                '            If Not BB Then
                '                Dim MySql$ = "Delete from DataSource where SourceGuid = '" + NewSourceGuid$ + "'"
                '                DBARCH.ExecuteSqlNewConn(MySql)
                '                LOG.WriteToArchiveLog("Fatal Error - removed file '" + file_FullName + "' from the repository.")
                '            Else
                '                Dim BBX As Boolean = DBARCH.ExecuteSqlNewConn("Update DataSource set ParentGuid = '" + ParentSourceGuid + "' where SourceGuid = '" + NewSourceGuid$ + "' ")
                '            End If

                '            If LibraryList.Count > 0 Then
                '                For III As Integer = 0 To LibraryList.Count - 1
                '                    Dim LibraryName$ = LibraryList(III)
                '                    DBARCH.AddLibraryItem(NewSourceGuid$, file_SourceName, file_SourceTypeCode, LibraryName$)
                '                Next
                '            End If

                '            DBARCH.UpdateDocFqn(NewSourceGuid$, file_FullName)
                '            DBARCH.UpdateDocSize(NewSourceGuid$, file_Length$)
                '            DBARCH.UpdateDocOriginalFileType(NewSourceGuid$, OriginalFileType$)
                '            DBARCH.UpdateZipFileIndicator(NewSourceGuid$, "N")
                '            DBARCH.UpdateIsContainedWithinZipFile(NewSourceGuid$)
                '            DBARCH.UpdateZipFileOwnerGuid(ParentSourceGuid, NewSourceGuid$, file_FullName)

                '            DBARCH.UpdateDocDir(NewSourceGuid$, file_FullName)

                '            If (LCase(file_SourceTypeCode).Equals(".doc") Or LCase(file_SourceTypeCode).Equals(".docx")) Then
                '                GetWordDocMetadata(file_FullName, NewSourceGuid$, OriginalFileType$)
                '            End If
                '            If (file_SourceTypeCode.Equals(".xls") _
                '                        Or file_SourceTypeCode.Equals(".xlsx") Or file_SourceTypeCode.Equals(".xlsm")) Then
                '                Me.GetExcelMetaData(file_FullName, NewSourceGuid$, OriginalFileType$)
                '            End If
                '        Else
                '            If ddebug Then Debug.Print("Document " + file_FullName + " has not changed, SKIPPING.")
                '        End If

                '    End If
            End If
NextFile:
        Next

        For Each S As String In DirFiles
            Try
                Dim FileAttributes$() = S.Split("|")
                Dim file_FullName$ = FileAttributes(1)
                'ISO.saveIsoFile("$FilesToDelete.dat", file_FullName$ + "|")
                Try
                    File.Delete(file_FullName$)
                Catch ex As Exception
                    Console.WriteLine("Failed to delete A2: " + S)
                End Try

            Catch ex As Exception
                Console.WriteLine("Failed to delete A3: " + S)
            End Try
        Next

        frmMain.SB2.Text = ""
    End Sub

    Sub ZeroizeDirectory(ByVal DirectoryFQN As String)
        Dim strFileSize As String = ""
        Dim di As New IO.DirectoryInfo(DirectoryFQN$)
        Dim aryFi As IO.FileInfo() = di.GetFiles("*.*")
        Dim fi As IO.FileInfo

        For Each fi In aryFi
            fi.Delete()
        Next
    End Sub

    Sub ValidateExtExists(ByVal FQN As String)
        Dim ATYPE As New clsATTACHMENTTYPE
        Dim FileExt$ = "." + UTIL.getFileSuffix(FQN$)
        Dim bCnt As Integer = ATYPE.cnt_PK29(FileExt)
        If bCnt = 0 Then
            ATYPE.setDescription("Auto added this code.")
            ATYPE.setAttachmentcode(FileExt)
            ATYPE.Insert()
        End If
        ATYPE = Nothing
    End Sub

    Sub UnzipAndLoadEmailAttachment(ByVal UID As String,
                                    ByVal MachineID As String,
                                    ByVal TemporaryZipDirectory As String,
                                    ByVal EmailGuid As String,
                                    ByVal ZipFileFQN As String,
                                    ByVal StackLevel As Integer,
                                    ByRef ListOfFiles As Dictionary(Of String, Integer))

        Dim ExplodeEmailAttachment As String = DBARCH.getSystemParm("ExplodeEmailAttachment")
        If (ExplodeEmailAttachment.Equals("N")) Then
            Return
        End If
        ' ExplodeEmailAttachment()
        ' ExplodeEmailZip()
        ' ExplodeContentZip()
        'Check to see if the "EXPLODE ZIP FILE flag is true and if so, just return true.

        StackLevel += 1
        Dim RetentionCode As String = "Retain 10"
        Dim ispublic As String = "N"

        Dim TempZipFilesList As New List(Of String)
        TempZipFilesList = DMA.GetFilesRecursive(TemporaryZipDirectory)

        Dim strFileSize As String = ""
        Dim KK As Integer = 0
        Dim fSize As Double = 0

        For Each FQN As String In TempZipFilesList

            If ListOfFiles.Keys.Contains(FQN) Then
                Dim Level As Integer = ListOfFiles.Item(FQN)
                If Level <= StackLevel Then
                    GoTo SkipToNextFile
                End If
            Else
                ListOfFiles.Add(FQN, StackLevel)
            End If

            Dim FI As New FileInfo(FQN)
            fSize = FI.Length / 1000
            KK += 1
            Dim AttachmentFileName As String = FI.FullName
            Dim FileNameOnly As String = FI.Name
            Dim FileExt As String = FI.Extension
            Dim fDir As String = FI.DirectoryName

            ValidateExtExists(AttachmentFileName)
            Dim Sha1Hash As String = ENC.GenerateSHA512HashFromFile(FQN)
            Dim bbx As Boolean = DBARCH.InsertAttachmentFqn(gCurrUserGuidID, AttachmentFileName, EmailGuid, FileNameOnly$, FileExt$, gCurrUserGuidID, RetentionCode, Sha1Hash, ispublic, fDir)

            frmNotify2.lblMsg2.Text = String.Format("Attachment: " + KK.ToString + " of " + TempZipFilesList.Count.ToString + " / {1:F}/kb : {2} ", fSize, FileNameOnly)
            frmNotify.Refresh()
            Application.DoEvents()
            If bbx Then
                Dim MySql$ = "Update EmailAttachment set isZipFileEntry = 1 where EmailGuid = '" + EmailGuid + "' and AttachmentName = '" + FileNameOnly$ + "'"
                DBARCH.ExecuteSqlNewConn(MySql, False)

                If isZipFile(FileNameOnly$) Then
                    Dim SkipIfAlreadyArchived As Boolean = False
                    ProcessEmailZipFile(gMachineID, EmailGuid, FileNameOnly, gCurrUserGuidID, SkipIfAlreadyArchived, AttachmentFileName, StackLevel, ListOfFiles)
                End If

            Else
                If ddebug Then Debug.Print("Error 743.21a - Failed to save attachment: " + TemporaryZipDirectory + "/" + FileNameOnly$)
            End If
SkipToNextFile:
        Next

        For Each S In TempZipFilesList
            Try
                'ISO.saveIsoFile("$FilesToDelete.dat", S + "|")
                If File.Exists(S) Then
                    File.Delete(S)
                End If

            Catch ex As Exception
                Console.WriteLine("Failed to delete A4: " + S)
            End Try
        Next
        frmNotify2.lblMsg2.Text = ""
        frmNotify.Refresh()
        Application.DoEvents()
    End Sub

    Public Function ProcessEmailZipFile(ByVal MachineID As String,
                                        ByVal EmailGuid As String,
                                        ByVal FQN As String,
                                        ByVal OwnerGCurrUserID As String,
                                        ByVal SkipIfAlreadyArchived As Boolean,
                                        ByVal ZipFileFQN As String,
                                        ByVal StackLevel As Integer,
                                    ByRef ListOfFiles As Dictionary(Of String, Integer)) As Boolean

        Dim ExplodeEmailZip As String = DBARCH.getSystemParm("ExplodeEmailZip")
        If (ExplodeEmailZip.Equals("N")) Then
            Return True
        End If
        ' ExplodeEmailAttachment()
        ' ExplodeEmailZip()
        ' ExplodeContentZip()
        'Check to see if the "EXPLODE ZIP FILE flag is true and if so, just return true.

        Dim UID As String = OwnerGCurrUserID
        Dim isArchiveBitOn As Boolean = DMA.isArchiveBitOn(FQN)
        Dim bIsArchivedAlready As Boolean = DMA.isFileArchiveAttributeSet(FQN)
        If bIsArchivedAlready = False And SkipIfAlreadyArchived = True Then
            Return True
        End If

        Dim ZipProcessingDir As String = UTIL.getTempProcessingDir
        ZipProcessingDir = ZipProcessingDir + "TempZip" + "." + Guid.NewGuid.ToString
        ZipProcessingDir = ZipProcessingDir.Replace("\\", "\")

        If Not Directory.Exists(ZipProcessingDir) Then
            Try
                Directory.CreateDirectory(ZipProcessingDir)
            Catch ex As Exception
                LOG.WriteToArchiveLog("ERROR: Failed to create Temp ZIP unload Directory" + ZipProcessingDir + ", aborting.")
                Return False
            End Try
        End If

        Dim fExt$ = UTIL.getFileSuffix(FQN)
        fExt = fExt.ToUpper
        Dim B As Boolean = False

        If UCase(fExt).Equals("ZIP") Then
            B = UnZip(FQN, ZipProcessingDir)
            If B Then
                UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, EmailGuid$, ZipFileFQN, StackLevel, ListOfFiles)
            Else
                DBARCH.addDocSourceError("EMAIL", OwnerGCurrUserID$, "ERROR: The ZIP file '" + FQN + "' failed to extract and load.")
            End If
            DMA.ToggleArchiveBit(FQN)
        ElseIf UCase(fExt).Equals("ISO") Or fExt.Equals("ARJ") _
                            Or fExt.Equals("CAB") _
                            Or fExt.Equals("CHM") _
                            Or fExt.Equals("CPIO") _
                            Or fExt.Equals("CramFS") _
                            Or fExt.Equals("DEB") _
                            Or fExt.Equals("DMG") _
                            Or fExt.Equals("FAT") _
                            Or fExt.Equals("HFS") _
                            Or fExt.Equals("LZH") _
                            Or fExt.Equals("LZMA") _
                            Or fExt.Equals("MBR") _
                            Or fExt.Equals("MSI") _
                            Or fExt.Equals("NSIS") _
                            Or fExt.Equals("NTFS") _
                            Or fExt.Equals("RAR") _
                            Or fExt.Equals("RPM") _
                            Or fExt.Equals("SquashFS") _
                            Or fExt.Equals("UDF") _
                            Or fExt.Equals("VHD") _
                            Or fExt.Equals("WIM") _
                            Or fExt.Equals("XAR") _
                            Or fExt.Equals("Z") Then
            B = Un7zip(FQN$, ZipProcessingDir)

            If B Then
                UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, EmailGuid$, ZipFileFQN, StackLevel, ListOfFiles)
            Else
                DBARCH.addDocSourceError("EMAIL", OwnerGCurrUserID$, "ERROR: The RAR file '" + FQN + "' failed to extract and load.")
            End If
            DMA.ToggleArchiveBit(FQN)
        ElseIf UCase(fExt).Equals("GZ") Then
            B = UntarGZarchive(FQN$)
            If B Then
                UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, EmailGuid$, ZipFileFQN, StackLevel, ListOfFiles)
            Else
                DBARCH.addDocSourceError("EMAIL", OwnerGCurrUserID$, "ERROR: The GZ file '" + FQN + "' failed to extract and load.")
            End If
            DMA.ToggleArchiveBit(FQN)
        ElseIf UCase(fExt).Equals("Z") Then
            B = Me.UntarZarchive(FQN$)
            If B Then
                UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, EmailGuid$, ZipFileFQN, StackLevel, ListOfFiles)
            Else
                DBARCH.addDocSourceError("EMAIL", OwnerGCurrUserID$, "ERROR: The 'Z' ZIP file '" + FQN + "' failed to extract and load.")
            End If
            DMA.ToggleArchiveBit(FQN)
        ElseIf UCase(fExt).Equals("TAR") Then
            B = UnTarArchive(FQN$)
            If B Then
                UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, EmailGuid$, ZipFileFQN, StackLevel, ListOfFiles)
            Else
                DBARCH.addDocSourceError("EMAIL", OwnerGCurrUserID$, "ERROR: The TAR file '" + FQN + "' failed to extract and load.")
            End If
            DMA.ToggleArchiveBit(FQN)
        End If

    End Function

    ''' <summary>
    ''' This is a recursive routine that takes the top direcotry as the starting path and 
    ''' will return all directories and subdirectories of subdirectoriDB.
    ''' </summary>
    ''' <param name="StartPath">The top level directory to search</param>
    ''' <param name="DirectoryList">An array list object that will be populated with all subdirectoriDB.</param>
    ''' <remarks></remarks>
    Sub GetDirectories(ByVal StartPath As String, ByRef DirectoryList As ArrayList)
        Try
            Dim Dirs() As String = Directory.GetDirectories(StartPath)
            DirectoryList.AddRange(Dirs)
            For Each Dir As String In Dirs
                GetDirectories(Dir, DirectoryList)
            Next
        Catch ex As Exception
            DBARCH.xTrace(443276, "GetDirectories", ex.Message.ToString)
            LOG.WriteToArchiveLog("clsZipFiles : GetDirectories : 184 : " + ex.Message)
        End Try


    End Sub
    ''' <summary>
    ''' This is a routine that calls the recursive routine GetDirectoriDB. It gets all directories within the top directory,
    ''' marks all files within each directory as "normal"
    ''' and then deletes each file within the directory.
    ''' </summary>
    ''' <param name="DirPath">Top level directory to delete.</param>
    ''' <remarks></remarks>
    Sub RemoveAllDirFiles(ByVal DirPath As String)
        Dim DirList As New ArrayList
        GetDirectories(DirPath$, DirList)
        For i As Integer = 0 To DirList.Count - 1
            Dim dName$ = DirList(i)
            Try
                Dim f As IO.FileInfo
                Dim dir As New IO.DirectoryInfo(dName$)


                For Each f In dir.GetFiles
                    f.Attributes = IO.FileAttributes.Normal
                    If ddebug Then Console.WriteLine(f.Name)
                    f.Delete()
                Next
            Catch ex As Exception
                Debug.Print(ex.Message)
                LOG.WriteToArchiveLog("clsZipFiles : RemoveAllDirFiles : 197 : " + ex.Message)
            End Try


        Next
    End Sub
    Function GetUnZipDir() As String

        Dim dirPath As String = UTIL.getTempProcessingDir

        dirPath = dirPath + "TempZip" + "." + Guid.NewGuid.ToString

        If Directory.Exists(dirPath) Then
        Else
            Directory.CreateDirectory(dirPath)
        End If

        Return dirPath

    End Function
    Function GetEmailUnZipDir() As String

        Dim dirPath As String = UTIL.getTempProcessingDir

        dirPath = dirPath + "TempEmailZip"

        If Directory.Exists(dirPath) Then
        Else
            Directory.CreateDirectory(dirPath)
        End If

        RemoveAllDirFiles(dirPath)
        Dim B As Boolean = False
        Try
            System.IO.Directory.Delete(dirPath, True)
        Catch ex As Exception
            Console.WriteLine(ex.ToString)
            LOG.WriteToArchiveLog("clsZipFiles : GetUnZipDir : 207 : " + ex.Message)
        Finally
            Beep()
        End Try


        If System.IO.Directory.Exists(dirPath) Then
            B = True
        End If
        If B Then
            Dim s As String
            For Each s In System.IO.Directory.GetFiles(dirPath)
                Try
                    System.IO.File.Delete(s)
                Catch ex As Exception
                    Debug.Print(ex.Message)
                    Dim dName$ = dirPath
                    Try
                        Dim f As IO.FileInfo
                        Dim dir As New IO.DirectoryInfo(dName$)
                        For Each f In dir.GetFiles
                            f.Attributes = IO.FileAttributes.Normal
                            Debug.Print(f.Name)
                            f.Delete()
                        Next
                    Catch ex2 As Exception
                        Debug.Print(ex2.Message)
                        LOG.WriteToArchiveLog("clsZipFiles : GetUnZipDir : 226 : " + ex2.Message)
                    End Try
                End Try
            Next s
        Else
            System.IO.Directory.CreateDirectory(dirPath)
        End If
        Return dirPath
    End Function

    Function UnZip(ByVal FQN As String, ByVal ZipProcessingDir As String) As Boolean

        Dim ExplodeContentZip As String = DBARCH.getSystemParm("ExplodeContentZip")
        If (ExplodeContentZip.Equals("N")) Then
            Return True
        End If
        ' ExplodeEmailAttachment()
        ' ExplodeEmailZip()
        ' ExplodeContentZip()
        'Check to see if the "EXPLODE ZIP FILE flag is true and if so, just return true.

        FQN = UTIL.ReplaceSingleQuotes(FQN)

        If Not File.Exists(FQN) Then
            LOG.WriteToArchiveLog("ERROR: UnZip 151.1 - ZIP file not found : " + FQN)
            Return False
        End If

        Dim B As Boolean = True
        ' This must be called once at the beginning of your program.
        zip.UnlockComponent("DMACHIZIP_YDZk6Rmz3Ivf")
        ' Don't forget to enable events.
        zip.EnableEvents = True

        Try
            ' Open a zip archive.
            Dim success As Boolean
            success = zip.OpenZip(FQN)
            If (Not success) Then
                MessageBox.Show(zip.LastErrorText)
                Exit Function
            End If

            'Dim UnzipDirectory As String = GetUnZipDir()
            Dim numFilesUnzipped As Integer = 0

            ' Unzip to a sub-directory relative to the current working directory
            ' of the calling process.  If the myZip directory does not exist,
            ' it is automatically created.
            numFilesUnzipped = zip.Unzip(ZipProcessingDir)
            If (numFilesUnzipped < 0) Then
                'MessageBox.Show(zip.LastErrorText)
                DBARCH.xTrace(221975, "clsZipFiles:UnZip", "Failed for: " + zip.LastErrorText + " : " + gCurrUserGuidID)
                LOG.WriteToArchiveLog("ERROR: UnZip 151.3 - Failed for: " + zip.LastErrorText + " : " + gCurrUserGuidID)
                Return False
            End If

            zip.CloseZip()
        Catch ex As Exception
            LOG.WriteToArchiveLog("ERROR: UnZip 151.2 - ZIP file not found : " + ex.Message.ToString)
        End Try


        Return B
    End Function
    Function UnRar(ByVal FQN As String) As Boolean


        Dim rar As New Chilkat.Rar()
        Dim dirPath As String = GetUnZipDir()

        Dim success As Boolean

        success = rar.Open(FQN)
        Dim iFiles As Integer = rar.NumEntries
        If (success <> True) Then
            MessageBox.Show(rar.LastErrorText)
            Exit Function
        End If

        success = rar.Unrar(dirPath)
        If (success <> True) Then
            'messagebox.show(rar.LastErrorText)
            DBARCH.xTrace(221975, "clsZipFiles:UnRar", "Failed for: " + rar.LastErrorText + " : " + gCurrUserGuidID)
            Return False
        Else
            'messagebox.show("Success.")
            Return True
        End If

    End Function

    Function Un7zip(ByVal FQN As String, ByRef UnzipDir As String) As Boolean

        Dim success As Boolean = True

        UnzipDir = UnzipDir.Replace("\\", "\")

        Dim Z7Path As String = ""
        Dim Zip7Executable As String = Application.ExecutablePath
        Dim FI As New FileInfo(Zip7Executable)
        Zip7Executable = FI.DirectoryName
        Z7Path = FI.DirectoryName
        FI = Nothing
        GC.Collect()

        Zip7Executable = Zip7Executable + "\Z7\7z.exe"

        Try
            Dim ProcessLine As String = "x -o" + UnzipDir + " " + Chr(34) + FQN + Chr(34)
            'Process.Start(Zip7Executable, ProcessLine)
            Dim ProcessProperties As New ProcessStartInfo
            ProcessProperties.WorkingDirectory = UnzipDir
            ProcessProperties.FileName = Zip7Executable
            ProcessProperties.Arguments = ProcessLine
            ProcessProperties.WindowStyle = ProcessWindowStyle.Minimized
            Dim myProcess As Process = Process.Start(ProcessProperties)
            myProcess.WaitForExit()
            'You can even start a hidden process ... 
            'ProcessProperties.WindowStyle = ProcessWindowStyle.Hidden
            myProcess.Dispose()
            GC.Collect()
            GC.WaitForPendingFinalizers()
        Catch ex As Exception
            success = False
            DBARCH.xTrace(221975, "clsZipFiles:Un7zip", "Failed for: " + FQN + " / " + ex.Message + " : " + gCurrUserGuidID)
        End Try

        Return success

    End Function
    Function UntarGZarchive(ByVal FQN As String) As Boolean


        Dim dirPath As String = GetUnZipDir()
        Dim fName$ = DMA.getFileName(FQN)


        ' The Chilkat.Gzip class is included with the "Chilkat Zip" license.
        Dim gz As New Chilkat.Gzip()
        gz.UnlockComponent("DMACHITarArch_XqG3YzDa5MA0")


        Dim bNoAbsolute As Boolean
        Dim untarRoot As String


        ' bNoAbsolute controls whether leading '/' or '\' are automatically
        ' removed from filepaths to ensure that all files are untarred to
        ' a directory beneath the untarRoot.
        bNoAbsolute = True
        untarRoot = dirPath


        ' The UnTarZ method is streaming. Files of any size
        ' may be uncompressed and untarred.  No temporary files are produced.
        Dim success As Boolean
        success = gz.UnTarGz(fName$, untarRoot, bNoAbsolute)
        If (Not success) Then
            'MessageBox.Show(gz.LastErrorText)
            DBARCH.xTrace(221975, "clsZipFiles:UntarGZarchive", "Failed for: " + gz.LastErrorText + " : " + gCurrUserGuidID)
            Return False
        End If


        Return True


    End Function


    Function UntarZarchive(ByVal FQN As String) As Boolean


        Dim dirPath As String = GetUnZipDir()
        Dim fName$ = DMA.getFileName(FQN)


        ' The Chilkat.UnixCompress class is included with the "Chilkat Zip" license.
        Dim z As New Chilkat.UnixCompress()
        z.UnlockComponent("DMACHITarArch_XqG3YzDa5MA0")


        Dim bNoAbsolute As Boolean
        Dim untarRoot As String


        ' bNoAbsolute controls whether leading '/' or '\' are automatically
        ' removed from filepaths to ensure that all files are untarred to
        ' a directory beneath the untarRoot.
        bNoAbsolute = True
        untarRoot = dirPath


        ' The UnTarZ method is streaming. Files of any size
        ' may be uncompressed and untarred.  No temporary files are produced.
        Dim success As Boolean
        success = z.UnTarZ(fName$, untarRoot, bNoAbsolute)
        If (Not success) Then
            'MessageBox.Show(z.LastErrorText)
            DBARCH.xTrace(221975, "clsZipFiles:UntarZarchive", "Failed for: " + z.LastErrorText + " : " + gCurrUserGuidID)
            Return False
        End If
        Return True
    End Function


    Function UnTarArchive(ByVal FQN As String) As Boolean
        Try
            Dim dirPath As String = GetUnZipDir()
            Dim fName$ = DMA.getFileName(FQN)


            ' The Chilkat.UnixCompress class is included with the "Chilkat Zip" license.
            'Dim z As New Chilkat.UnixCompress()
            'z.UnlockComponent("DMACHITarArch_XqG3YzDa5MA0")


            ' The Chilkat.Tar class is a free Chilkat.NET class.
            Dim tar As New Chilkat.Tar


            ' Remove leading '/' or '\' characters when
            ' untarring so that the directories created are 
            ' relative to the untar root directory.
            tar.NoAbsolutePaths = True


            ' Set our untar root directory.
            tar.UntarFromDir = dirPath


            ' Untar into the UntarFromDir,
            ' the directory tree (if it exists) is
            ' re-created at the UntarFromDir
            Dim B As Boolean = tar.Untar(fName$)
            Return B
        Catch ex As Exception
            'messagebox.show(ex.Message)
            DBARCH.xTrace(221975, "clsZipFiles:UnTarArchive", "Failed for: " + ex.Message + " : " + gCurrUserGuidID)
            LOG.WriteToArchiveLog("clsZipFiles : UnTarArchive : 293 : " + ex.Message)
            Return False
        End Try


    End Function

    Public Function isZipFile(ByVal FQN As String) As Boolean

        Dim fExt$ = UTIL.getFileSuffix(FQN).ToUpper
        Dim B As Boolean = False

        If UCase(fExt).Equals("ZIP") Then
            B = True
        ElseIf UCase(fExt).Equals("RAR") Then
            B = True
        ElseIf UCase(fExt).Equals("GZ") Then
            B = True
        ElseIf UCase(fExt).Equals("ISO") Then
            B = True
        ElseIf UCase(fExt).Equals("TAR") Then
            B = True
        ElseIf UCase(fExt).Equals("ARJ") Then
            B = True
        ElseIf UCase(fExt).Equals("CAB") Then
            B = True
        ElseIf UCase(fExt).Equals("CHM") Then
            B = True
        ElseIf UCase(fExt).Equals("CPIO") Then
            B = True
        ElseIf UCase(fExt).Equals("CramFS") Then
            B = True
        ElseIf UCase(fExt).Equals("DEB") Then
            B = True
        ElseIf UCase(fExt).Equals("DMG") Then
            B = True
        ElseIf UCase(fExt).Equals("FAT") Then
            B = True
        ElseIf UCase(fExt).Equals("HFS") Then
            B = True
        ElseIf UCase(fExt).Equals("LZH") Then
            B = True
        ElseIf UCase(fExt).Equals("LZMA") Then
            B = True
        ElseIf UCase(fExt).Equals("MBR") Then
            B = True
        ElseIf UCase(fExt).Equals("MSI") Then
            B = True
        ElseIf UCase(fExt).Equals("NSIS") Then
            B = True
        ElseIf UCase(fExt).Equals("NTFS") Then
            B = True
        ElseIf UCase(fExt).Equals("RPM") Then
            B = True
        ElseIf UCase(fExt).Equals("SquashFS") Then
            B = True
        ElseIf UCase(fExt).Equals("UDF") Then
            B = True
        ElseIf UCase(fExt).Equals("VHD") Then
            B = True
        ElseIf UCase(fExt).Equals("WIM") Then
            B = True
        ElseIf UCase(fExt).Equals("XAR") Then
            B = True
        ElseIf UCase(fExt).Equals("Z") Then
            B = True
        End If
        Return B

    End Function


    Sub InsertSrcAttrib(ByVal SGCurrUserID As String, ByVal aName As String, ByVal aVal As String, ByVal OriginalFileType As String)
        SRCATTR.setSourceguid(SGCurrUserID)
        SRCATTR.setAttributename(aName)
        SRCATTR.setAttributevalue(aVal)
        SRCATTR.setDatasourceowneruserid(gCurrUserGuidID)
        SRCATTR.setSourcetypecode(OriginalFileType$)

        Dim iCnt As Integer = SRCATTR.cnt_PK35(aName, gCurrUserGuidID, SGCurrUserID)
        If iCnt > 0 Then
            Dim WC$ = SRCATTR.wc_PK35(aName, gCurrUserGuidID, SGCurrUserID)
            SRCATTR.Update(WC$)
        Else
            SRCATTR.Insert()
        End If

    End Sub
    Sub GetWordDocMetadata(ByVal FQN As String, ByVal SourceGCurrUserID As String, ByVal OriginalFileType As String)


        Dim TempDir$ = UTIL.getTempProcessingDir
        Dim fName$ = DMA.getFileName(FQN)
        Dim NewFqn$ = TempDir + fName


        File.Copy(FQN, NewFqn, True)


        Dim WDOC As New clsMsWord
        WDOC.initWordDocMetaData(NewFqn, SourceGCurrUserID$, OriginalFileType$)

        ISO.saveIsoFile("$FilesToDelete.dat", NewFqn$ + "|")
        'File.Delete(NewFqn$)


    End Sub
    Sub GetExcelMetaData(ByVal FQN As String, ByVal SourceGCurrUserID As String, ByVal OriginalFileType As String)


        Dim TempDir$ = UTIL.getTempProcessingDir
        Dim fName$ = DMA.getFileName(FQN)
        Dim NewFqn$ = TempDir + fName


        File.Copy(FQN, NewFqn, True)


        Dim WDOC As New clsMsWord
        WDOC.initExcelMetaData(NewFqn$, SourceGCurrUserID$, OriginalFileType$)

        ISO.saveIsoFile("$FilesToDelete.dat", NewFqn$ + "|")
        'File.Delete(NewFqn$)


    End Sub
    Function isExtIncluded(ByVal fExt As String) As Boolean


        Dim B As Boolean = False
        For i As Integer = 0 To IncludedTypes.Count - 1
            Dim tExtension$ = IncludedTypes.Item(i).ToString
            If UCase(tExtension).Equals(UCase(fExt)) Then
                B = True
                Exit For
            ElseIf UCase(tExtension).Equals("*") Then
                B = True
                Exit For
            End If
        Next
        Return B


    End Function
    Function isExtExcluded(ByVal fExt As String) As Boolean


        Dim B As Boolean = False
        For i As Integer = 0 To ExcludedTypes.Count - 1
            Dim tExtension$ = ExcludedTypes.Item(i).ToString
            If UCase(tExtension).Equals(UCase(fExt)) Then
                B = True
                Exit For
            ElseIf UCase(tExtension).Equals("*") Then
                B = True
                Exit For
            End If
        Next
        Return B
    End Function

    'Public Function ProcessEmailZipFileXX(ByVal EmailGuid$, _
    '                                    ByVal FQN$, _
    '                                    ByVal OwnerGCurrUserID$, _
    '                                    ByVal SkipIfAlreadyArchived As Boolean, _
    '                                    ByVal AName$, _
    '                                    ByRef AttachmentsLoaded As Boolean, _
    '                                    ByVal StackLevel As Integer, _
    '                                ByRef ListOfFiles As Dictionary(Of String, Integer)) As Boolean

    '    Dim isArchiveBitOn As Boolean = UTIL.isArchiveBitOn(FQN)
    '    Dim bIsArchivedAlready As Boolean = UTIL.isFileArchiveAttributeSet(FQN)
    '    If bIsArchivedAlready = False And SkipIfAlreadyArchived = True Then
    '        Return True
    '    End If

    '    Dim ZipProcessingDir As String = UTIL.getTempProcessingDir
    '    ZipProcessingDir = ZipProcessingDir + "TempZip" + "." + EmailGuid$
    '    ZipProcessingDir = ZipProcessingDir.Replace("\\", "\")

    '    Dim fExt$ = UTIL.getFileSuffix(FQN)
    '    fExt = fExt.ToUpper
    '    Dim B As Boolean = False

    '    If UCase(fExt).Equals("ZIP") Then
    '        B = UnZip(FQN, ZipProcessingDir)
    '        If B Then
    '            UnzipAndLoadEmailAttachment(OwnerGCurrUserID, gMachineID, ZipProcessingDir, EmailGuid, ZipProcessingDir, StackLevel, ListOfFiles)
    '        Else
    '            DBARCH.addDocSourceError(OwnerGCurrUserID$, "ERROR: The ZIP file '" + FQN + "' failed to extract and load.")
    '            If Not bThisIsAnEmail Then
    '                DBARCH.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: The TAR file '" + FQN + "' failed to extract and load.")
    '            Else
    '                DBARCH.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: The TAR file '" + FQN + "' failed to extract and load.")
    '            End If
    '        End If
    '        UTIL.TurnOffArchiveBit(FQN)
    '    ElseIf UCase(fExt).Equals("RAR") Then
    '        B = UnRar(FQN$)
    '        If B Then
    '            UnzipAndLoadEmailAttachment(OwnerGCurrUserID, gMachineID, ZipProcessingDir, EmailGuid, ZipProcessingDir, StackLevel, ListOfFiles)
    '        Else
    '            DBARCH.addDocSourceError(OwnerGCurrUserID$, "ERROR: The RAR file '" + FQN + "' failed to extract and load.")
    '        End If
    '        UTIL.TurnOffArchiveBit(FQN)
    '    ElseIf UCase(fExt).Equals("GZ") Then
    '        B = UntarGZarchive(FQN$)
    '        If B Then
    '            UnzipAndLoadEmailAttachment(OwnerGCurrUserID, gMachineID, ZipProcessingDir, EmailGuid, ZipProcessingDir, StackLevel, ListOfFiles)
    '        Else
    '            DBARCH.addDocSourceError(OwnerGCurrUserID$, "ERROR: The GZ file '" + FQN + "' failed to extract and load.")
    '        End If
    '        UTIL.TurnOffArchiveBit(FQN)
    '    ElseIf UCase(fExt).Equals("Z") Then
    '        B = Me.UntarZarchive(FQN$)
    '        If B Then
    '            UnzipAndLoadEmailAttachment(OwnerGCurrUserID, gMachineID, ZipProcessingDir, EmailGuid, ZipProcessingDir, StackLevel, ListOfFiles)
    '        Else
    '            DBARCH.addDocSourceError(OwnerGCurrUserID$, "ERROR: The 'Z' ZIP file '" + FQN + "' failed to extract and load.")
    '        End If
    '        UTIL.TurnOffArchiveBit(FQN)
    '    ElseIf UCase(fExt).Equals("TAR") Then
    '        B = UnTarArchive(FQN$)
    '        If B Then
    '            UnzipAndLoadEmailAttachment(OwnerGCurrUserID, gMachineID, ZipProcessingDir, EmailGuid, ZipProcessingDir, StackLevel, ListOfFiles)
    '        Else
    '            DBARCH.addDocSourceError(OwnerGCurrUserID$, "ERROR: The TAR file '" + FQN + "' failed to extract and load.")
    '        End If
    '        UTIL.TurnOffArchiveBit(FQN)
    '    End If
    '    Return True
    'End Function

    Sub UnzipAndLoadEmailAttachment(ByVal DirectoryFQN As String, ByVal EmailGuid As String, ByVal AttachmentName As String, ByRef AttachmentsLoaded As Boolean)

        Dim ExplodeEmailZip As String = DBARCH.getSystemParm("ExplodeEmailZip")
        If (ExplodeEmailZip.Equals("N")) Then
            Return
        End If
        ' ExplodeEmailAttachment()
        ' ExplodeEmailZip()
        ' ExplodeContentZip()
        'Check to see if the "EXPLODE ZIP FILE flag is true and if so, just return true.

        Dim RetentionCode As String = "Retain 10"
        Dim ispublic As String = "N"

        Dim DirFiles As New List(Of String)
        DirFiles = DMA.GetFilesRecursive(DirectoryFQN$)

        Dim strFileSize As String = ""
        Dim di As New IO.DirectoryInfo(DirectoryFQN$)
        Dim aryFi As IO.FileInfo() = di.GetFiles("*.*")
        Dim fi As IO.FileInfo

        For Each FN As String In DirFiles
            Dim filename As String = FN
            Dim FileNameOnly As String = System.IO.Path.GetFileName(FN)
            Dim FileExt$ = System.IO.Path.GetExtension(FN)
            ValidateExtExists(filename$)

            Dim fDir As String = DirectoryFQN$ + AttachmentName$
            Dim Sha1Hash As String = ENC.GenerateSHA512HashFromFile(filename)
            Dim bbx As Boolean = DBARCH.InsertAttachmentFqn(gCurrUserGuidID, filename$, EmailGuid$, FileNameOnly$, FileExt$, gCurrUserGuidID, RetentionCode, Sha1Hash, ispublic, fDir)
            If bbx Then
                Dim MySql$ = "Update EmailAttachment set isZipFileEntry = 1 where EmailGuid = '" + EmailGuid$ + "' and AttachmentName = '" + FileNameOnly$ + "'"
                DBARCH.ExecuteSqlNewConn(MySql, False)
                Try
                    Kill(filename)
                Catch ex As Exception
                    Console.WriteLine(ex.Message)
                End Try

            Else
                If ddebug Then Debug.Print("Error 743.21a - Failed to save attachment: " + AttachmentName + "/" + FileNameOnly$)
            End If
        Next

        fi = Nothing
        GC.Collect()
        GC.WaitForPendingFinalizers()

    End Sub

End Class

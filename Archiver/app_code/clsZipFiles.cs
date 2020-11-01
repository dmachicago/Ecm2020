/* TODO ERROR: Skipped DefineDirectiveTrivia */
using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using global::System.IO;
using System.Linq;
using global::System.Reflection;
using System.Windows.Forms;
using global::ECMEncryption;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsZipFiles
    {
        public clsZipFiles()
        {
            zip = new Chilkat.Zip();
        }

        private int TotalFilesEvaluated = 0;
        private Chilkat.Zip zip;
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private ECMEncrypt ENC = new ECMEncrypt();
        private clsIsolatedStorage ISO = new clsIsolatedStorage();
        private clsZIPDATASOURCE ZDS = new clsZIPDATASOURCE();
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsAVAILFILETYPESUNDEFINED UNASGND = new clsAVAILFILETYPESUNDEFINED();
        private clsSOURCEATTRIBUTE SRCATTR = new clsSOURCEATTRIBUTE();
        // Dim CMODI As New clsModi
        private bool ddebug = true;
        public ArrayList ExcludedTypes = new ArrayList();
        public ArrayList IncludedTypes = new ArrayList();

        public string getZipPassword()
        {
            string S = "";
            S += "X";
            S += "@";
            S += "v";
            S += "1";
            S += "3";
            S += "r";
            return S;
        }

        public bool UploadZipFile(string UID, string MachineID, string FQN, string ParentZipGuid, bool SkipIfAlreadyArchived, bool bThisIsAnEmail, string RetentionCode, string isPublic, int StackLevel, ref Dictionary<string, int> ListOfFiles)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string ExplodeContentZip = DBARCH.getSystemParm("ExplodeContentZip");
            if (ExplodeContentZip.Equals("N"))
            {
                return true;
            }
            // ExplodeEmailAttachment()
            // ExplodeEmailZip()
            // ExplodeContentZip()

            // Check to see if the "EXPLODE ZIP FILE flag is true and if so, just return true.

            StackLevel += 1;
            bool isArchiveBitOn = DMA.isArchiveBitOn(FQN);
            bool bIsArchivedAlready = DMA.isFileArchiveAttributeSet(FQN);
            string ZipProcessingDir = UTIL.getTempProcessingDir();
            ZipProcessingDir = ZipProcessingDir + "TempZip" + Guid.NewGuid().ToString();
            ZipProcessingDir = ZipProcessingDir.Replace(@"\\", @"\");
            if (!Directory.Exists(ZipProcessingDir))
            {
                try
                {
                    Directory.CreateDirectory(ZipProcessingDir);
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("ERROR UploadZipFile 100: Failed to create temporary unzip directory, " + ZipProcessingDir + ", aborting.");
                    return false;
                }
            }

            string fExt = UTIL.getFileSuffix(FQN);
            bool B = false;
            fExt = fExt.ToUpper();
            if (Strings.UCase(fExt).Equals("ZIP"))
            {
                B = UnZip(FQN, ZipProcessingDir);
                if (B)
                {
                    if (!bThisIsAnEmail)
                    {
                        UnzipAndLoadContent(UID, MachineID, ZipProcessingDir, ParentZipGuid, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
                    }
                    else
                    {
                        UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, ParentZipGuid, null, StackLevel, ref ListOfFiles);
                    }
                }
                else if (!bThisIsAnEmail)
                {
                    DBARCH.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: UploadZipFile -  The ZIP file '" + FQN + "' failed to extract and load.");
                }
                else
                {
                    DBARCH.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: UploadZipFile -  The ZIP file '" + FQN + "' failed to extract and load.");
                }

                DMA.ToggleArchiveBit(FQN);
            }
            else if (fExt.Equals("ISO") | fExt.Equals("ARJ") | fExt.Equals("CAB") | fExt.Equals("CHM") | fExt.Equals("CPIO") | fExt.Equals("CramFS") | fExt.Equals("DEB") | fExt.Equals("DMG") | fExt.Equals("FAT") | fExt.Equals("HFS") | fExt.Equals("LZH") | fExt.Equals("LZMA") | fExt.Equals("MBR") | fExt.Equals("MSI") | fExt.Equals("NSIS") | fExt.Equals("NTFS") | fExt.Equals("RPM") | fExt.Equals("SquashFS") | fExt.Equals("UDF") | fExt.Equals("VHD") | fExt.Equals("WIM") | fExt.Equals("XAR"))





















            {
                B = Un7zip(FQN, ref ZipProcessingDir);
                // WDMXXXX
                if (B)
                {
                    if (!bThisIsAnEmail)
                    {
                        UnzipAndLoadContent(UID, MachineID, ZipProcessingDir, ParentZipGuid, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
                    }
                    else
                    {
                        UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, ParentZipGuid, null, StackLevel, ref ListOfFiles);
                    }
                }
                else if (!bThisIsAnEmail)
                {
                    DBARCH.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: UploadZipFile -  The " + fExt + " file '" + FQN + "' failed to extract and load.");
                }
                else
                {
                    DBARCH.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: UploadZipFile -  The " + fExt + " file '" + FQN + "' failed to extract and load.");
                }
                // Dim TheFileIsArchived As Boolean = True
                // DMA.setFileArchiveAttributeSet(FQN, TheFileIsArchived)
                DMA.ToggleArchiveBit(FQN);
            }
            else if (Strings.UCase(fExt).Equals("RAR"))
            {
                B = UnRar(FQN);
                if (B)
                {
                    if (!bThisIsAnEmail)
                    {
                        UnzipAndLoadContent(UID, MachineID, ZipProcessingDir, ParentZipGuid, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
                    }
                    else
                    {
                        UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, ParentZipGuid, null, StackLevel, ref ListOfFiles);
                    }
                }
                else if (!bThisIsAnEmail)
                {
                    DBARCH.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: UploadZipFile -  The RAR file '" + FQN + "' failed to extract and load.");
                }
                else
                {
                    DBARCH.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: UploadZipFile -  The RAR file '" + FQN + "' failed to extract and load.");
                }
                // Dim TheFileIsArchived As Boolean = True
                // DMA.setFileArchiveAttributeSet(FQN, TheFileIsArchived)
                DMA.ToggleArchiveBit(FQN);
            }
            else if (Strings.UCase(fExt).Equals("GZ"))
            {
                B = UntarGZarchive(FQN);
                if (B)
                {
                    if (!bThisIsAnEmail)
                    {
                        UnzipAndLoadContent(UID, MachineID, ZipProcessingDir, ParentZipGuid, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
                    }
                    else
                    {
                        UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, ParentZipGuid, null, StackLevel, ref ListOfFiles);
                    }
                }
                else if (!bThisIsAnEmail)
                {
                    DBARCH.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: UploadZipFile -  The GZ file '" + FQN + "' failed to extract and load.");
                }
                else
                {
                    DBARCH.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: UploadZipFile -  The GZ file '" + FQN + "' failed to extract and load.");
                }
                // Dim TheFileIsArchived As Boolean = True
                // DMA.setFileArchiveAttributeSet(FQN, TheFileIsArchived)
                DMA.ToggleArchiveBit(FQN);
            }
            else if (Strings.UCase(fExt).Equals("Z"))
            {
                B = UntarZarchive(FQN);
                if (B)
                {
                    if (!bThisIsAnEmail)
                    {
                        UnzipAndLoadContent(UID, MachineID, ZipProcessingDir, ParentZipGuid, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
                    }
                    else
                    {
                        UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, ParentZipGuid, null, StackLevel, ref ListOfFiles);
                    }
                }
                else if (!bThisIsAnEmail)
                {
                    DBARCH.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: UploadZipFile -  The Z-ZIP file '" + FQN + "' failed to extract and load.");
                }
                else
                {
                    DBARCH.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: UploadZipFile -  The Z-ZIP file '" + FQN + "' failed to extract and load.");
                }
                // Dim TheFileIsArchived As Boolean = True
                // DMA.setFileArchiveAttributeSet(FQN, TheFileIsArchived)
                DMA.ToggleArchiveBit(FQN);
            }
            else if (Strings.UCase(fExt).Equals("TAR"))
            {
                B = UnTarArchive(FQN);
                if (B)
                {
                    if (!bThisIsAnEmail)
                    {
                        UnzipAndLoadContent(UID, MachineID, ZipProcessingDir, ParentZipGuid, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
                    }
                    else
                    {
                        UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, ParentZipGuid, null, StackLevel, ref ListOfFiles);
                    }
                }
                else if (!bThisIsAnEmail)
                {
                    DBARCH.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: UploadZipFile -  The TAR file '" + FQN + "' failed to extract and load.");
                }
                else
                {
                    DBARCH.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: UploadZipFile -  The TAR file '" + FQN + "' failed to extract and load.");
                }
                // Dim TheFileIsArchived As Boolean = True
                // DMA.setFileArchiveAttributeSet(FQN, TheFileIsArchived)
                DMA.ToggleArchiveBit(FQN);
            }

            return default;
        }

        public void UnzipAndLoadContent(string UID, string MachineID, string ZipProcessingDir, string ParentSourceGuid, bool bThisIsAnEmail, string RetentionCode, string isPublic, int StackLevel, ref Dictionary<string, int> ListOfFiles)
        {
            string ExplodeContentZip = DBARCH.getSystemParm("ExplodeContentZip");
            if (ExplodeContentZip.Equals("N"))
            {
                return;
            }
            // ExplodeEmailAttachment()
            // ExplodeEmailZip()
            // ExplodeContentZip()
            // Check to see if the "EXPLODE ZIP FILE flag is true and if so, just return true.

            var DirFiles = new List<string>();
            var DirFiles2 = new List<string>();
            var LibraryList = new List<string>();
            string NewSourceGuid = Guid.NewGuid().ToString();
            IncludedTypes = DBARCH.GetAllIncludedFiletypes(ZipProcessingDir, "N");
            ExcludedTypes = DBARCH.GetAllExcludedFiletypes(ZipProcessingDir, "N");
            if (IncludedTypes.Count == 0)
            {
                IncludedTypes.Add("*");
            }

            bool bChanged = false;
            // ** Get all of the files in this folder

            var DirectoryList = new ArrayList();
            GetDirectories(ZipProcessingDir, ref DirectoryList);
            int ii = 0;
            if (DirectoryList.Count > 0)
            {
                for (int X = 0, loopTo = DirectoryList.Count - 1; X <= loopTo; X++)
                {
                    string tDir = Conversions.ToString(DirectoryList[X]);
                    try
                    {
                        ii += DMA.getFilesInDir(tDir, ref DirFiles, IncludedTypes, ExcludedTypes, false);
                    }
                    catch (Exception ex)
                    {
                        LOG.WriteToArchiveLog("clsZipFiles : LoadUnzippedFiles : 62 : " + ex.Message);
                        return;
                    }
                }
            }

            ii = DMA.getFilesInDir(ZipProcessingDir, ref DirFiles2, IncludedTypes, ExcludedTypes, false);
            foreach (string SS in DirFiles2)
                DirFiles.Add(SS);
            if (ii == 0)
            {
                return;
            }

            for (int K = 0, loopTo1 = DirFiles.Count - 1; K <= loopTo1; K++)
            {
                TotalFilesEvaluated = TotalFilesEvaluated + 1;
                NewSourceGuid = Guid.NewGuid().ToString();
                var FileAttributes = DirFiles[K].Split('|');
                string file_FullName = FileAttributes[1];
                string file_SourceName = FileAttributes[0];
                int iExist = 0;
                iExist = DBARCH.iCount("select COUNT(*) from DataSource where SourceName = '" + UTIL.RemoveSingleQuotes(file_SourceName) + "' and SourceGuid = '" + ParentSourceGuid + "'");
                if (iExist == 0)
                {
                    iExist = DBARCH.iCount("select COUNT(*) from EmailAttachment where AttachmentName = '" + UTIL.RemoveSingleQuotes(file_SourceName) + "' and EmailGuid = '" + ParentSourceGuid + "'");
                }

                if (iExist > 0)
                {
                    goto NextFile;
                }

                string CrcHash = ENC.GenerateSHA512HashFromFile(file_FullName);
                if (ListOfFiles.Keys.Contains(file_FullName))
                {
                    int Level = ListOfFiles[file_FullName];
                    if (Level <= StackLevel)
                    {
                        goto NextFile;
                    }
                }
                else
                {
                    ListOfFiles.Add(file_FullName, StackLevel);
                }

                Application.DoEvents();
                string file_Length = FileAttributes[2];
                if (modGlobals.gMaxSize > 0d)
                {
                    if (Conversion.Val(file_Length) > modGlobals.gMaxSize)
                    {
                        LOG.WriteToArchiveLog("Notice: file '" + file_FullName + "' exceed the allowed file upload size, skipped.");
                        goto NextFile;
                    }
                }

                double iLen = Conversions.ToDouble(file_Length);
                My.MyProject.Forms.frmNotify.lblFileSpec.Text = "ZIP Load: " + (K + 1).ToString() + " of " + DirFiles.Count.ToString() + " / " + (iLen / 1000d).ToString() + "/kb" + " : " + file_SourceName;
                My.MyProject.Forms.frmNotify.Refresh();
                string file_DirName = DMA.GetFilePath(file_FullName);

                // ** WDMXX
                DBARCH.GetDirectoryLibraries(file_DirName, ref LibraryList);
                string file_SourceTypeCode = FileAttributes[3];
                string file_LastAccessDate = FileAttributes[4];
                string file_CreateDate = FileAttributes[5];
                string file_LastWriteTime = FileAttributes[6];
                string OriginalFileType = file_SourceTypeCode;
                int bcnt = DBARCH.iGetRowCount("SourceType", "where SourceTypeCode = '" + file_SourceTypeCode + "'");
                if (bcnt == 0)
                {
                    string SubstituteFileType = DBARCH.getProcessFileAsExt(file_SourceTypeCode);
                    if (SubstituteFileType == null)
                    {
                        string MSG = "The file type '" + file_SourceTypeCode + "' is undefined." + Constants.vbCrLf + "DO YOU WISH TO AUTOMATICALLY DEFINE IT?" + Constants.vbCrLf + "This will allow content to be archived, but not searched.";
                        // Dim dlgRes As DialogResult = 'MessageBox.Show(MSG, "Filetype Undefined", MessageBoxButtons.YesNo)

                        string argval = "0";
                        UNASGND.setApplied(ref argval);
                        UNASGND.setFiletype(ref file_SourceTypeCode);
                        int iCnt = UNASGND.cnt_PK_AFTU(file_SourceTypeCode);
                        if (iCnt == 0)
                        {
                            UNASGND.Insert();
                        }

                        var ST = new clsSOURCETYPE();
                        ST.setSourcetypecode(ref file_SourceTypeCode);
                        string argval1 = "Extension " + file_SourceTypeCode + " AUTO ADDED";
                        ST.setSourcetypedesc(ref argval1);
                        string argval2 = "0";
                        ST.setIndexable(ref argval2);
                        string argval3 = 0.ToString();
                        ST.setStoreexternal(ref argval3);
                        ST.Insert();
                    }
                    else
                    {
                        file_SourceTypeCode = SubstituteFileType;
                    }
                }

                string StoredExternally = "N";
                int iDatasourceCnt = DBARCH.getCountDataSourceFiles(file_SourceName, CrcHash);
                if (iDatasourceCnt == 0)
                {
                    DBARCH.saveContentOwner(NewSourceGuid, modGlobals.gCurrUserGuidID, "C", file_DirName, modGlobals.gMachineID, modGlobals.gNetworkID);
                }

                bool SkipIfAlreadyArchived = true;
                if (iDatasourceCnt == 0)
                {
                    // *******************************************
                    // * File does not exist in REPO, Add it
                    // *******************************************
                    int LastVerNbr = 99;
                    bool BB = false;
                    try
                    {
                        if (file_SourceTypeCode.ToUpper().Equals(".MSG"))
                        {
                            var EMX = new clsEmailFunctions();
                            var xAttachedFiles = new List<string>();
                            if (File.Exists(file_FullName))
                            {
                                string argBody = "";
                                string argEmailDescription = "FOUND IN CONTENT ZIP FILE:" + file_FullName.Replace("'", "`");
                                EMX.LoadMsgFile(UID, file_FullName, modGlobals.gMachineID, "CONTENT-ZIP-FILE", "", RetentionCode, "UNKNOWN", ref argBody, ref xAttachedFiles, false, NewSourceGuid, ref argEmailDescription);
                            }

                            EMX = null;
                        }
                        else
                        {
                            string AttachmentCode = "C";
                            // Dim CrcHash As String = ENC.getCountDataSourceFiles(file_FullName)

                            BB = DBARCH.AddSourceToRepo(UID, MachineID, modGlobals.gNetworkID, NewSourceGuid, file_FullName, file_SourceName, file_SourceTypeCode, file_LastAccessDate, file_CreateDate, file_LastWriteTime, modGlobals.gCurrUserGuidID, LastVerNbr, RetentionCode, isPublic, CrcHash, file_DirName);
                            if (BB)
                            {
                                bool BBX = DBARCH.ExecuteSqlNewConn(90000, "Update DataSource set ParentGuid = '" + ParentSourceGuid + "' where SourceGuid = '" + NewSourceGuid + "' ");
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        LOG.WriteToArchiveLog("ERROR DBARCH.AddSourceToRepo 300a " + ex.Message);
                        BB = false;
                    }

                    if (BB)
                    {
                        if (isZipFile(file_FullName))
                        {
                            bool RC = UploadZipFile(UID, MachineID, file_FullName, ParentSourceGuid, SkipIfAlreadyArchived, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
                        }

                        if (LibraryList.Count > 0)
                        {
                            for (int III = 0, loopTo2 = LibraryList.Count - 1; III <= loopTo2; III++)
                            {
                                string LibraryName = LibraryList[III];
                                var ARCH = new clsArchiver();
                                ARCH.AddLibraryItem(NewSourceGuid, file_SourceName, file_SourceTypeCode, LibraryName);
                                ARCH = null;
                                GC.Collect();
                                GC.WaitForPendingFinalizers();
                            }
                        }

                        Application.DoEvents();
                        DBARCH.UpdateDocFqn(NewSourceGuid, file_FullName);
                        DBARCH.UpdateDocSize(NewSourceGuid, file_Length);
                        DBARCH.UpdateDocDir(NewSourceGuid, file_FullName);
                        DBARCH.UpdateDocOriginalFileType(NewSourceGuid, OriginalFileType);
                        DBARCH.UpdateZipFileIndicator(NewSourceGuid, false);
                        DBARCH.UpdateIsContainedWithinZipFile(NewSourceGuid);
                        string ZipFileFqn = DBARCH.getFqnFromGuid(ParentSourceGuid);
                        DBARCH.UpdateZipFileOwnerGuid(ParentSourceGuid, NewSourceGuid, ZipFileFqn);
                        Application.DoEvents();
                        InsertSrcAttrib(NewSourceGuid, "FILENAME", file_SourceName, OriginalFileType);
                        InsertSrcAttrib(NewSourceGuid, "CreateDate", file_CreateDate, OriginalFileType);
                        InsertSrcAttrib(NewSourceGuid, "FILESIZE", file_Length, OriginalFileType);
                        InsertSrcAttrib(NewSourceGuid, "ChangeDate", file_LastAccessDate, OriginalFileType);
                        InsertSrcAttrib(NewSourceGuid, "WriteDate", file_LastWriteTime, OriginalFileType);
                    }
                    // Else
                    // Dim FOLDER_VersionFiles$ = "Y"  '** This is a ZIPPED file, version it right upfront
                    // If UCase(FOLDER_VersionFiles$).Equals("Y") Then
                    // '** Get the last version number of this file in the repository,
                    // Dim LastVerNbr As Integer = DBARCH.GetMaxDataSourceVersionNbr(gCurrUserGuidID, file_FullName$)
                    // Dim NextVersionNbr As Integer = LastVerNbr + 1
                    // '** See if this version has been changed

                    // Dim AttachmentCode As String = "C"
                    // 'Dim CrcHash As String = ENC.getCountDataSourceFiles(file_SourceName$)

                    // bChanged = DBARCH.isSourcefileOlderThanLastEntry(file_SourceName$, CrcHash)
                    // '** If it has, add it to the repository
                    // If bChanged Then

                    // Dim BB As Boolean = False
                    // Try
                    // BB = DBARCH.AddSourceToRepo(UID, MachineID, gNetworkID, NewSourceGuid$, _
                    // file_FullName, _
                    // file_SourceName, _
                    // file_SourceTypeCode, _
                    // file_LastAccessDate$, _
                    // file_CreateDate$, _
                    // file_LastWriteTime$, gCurrUserGuidID, NextVersionNbr, RetentionCode, isPublic, CrcHash, file_DirName$)

                    // If BB Then
                    // Dim BBX As Boolean = DBARCH.ExecuteSqlNewConn("Update DataSource set ParentGuid = '" + ParentSourceGuid + "' where SourceGuid = '" + NewSourceGuid$ + "' ")
                    // End If

                    // If LibraryList.Count > 0 Then
                    // For III As Integer = 0 To LibraryList.Count - 1
                    // Dim LibraryName$ = LibraryList(III)
                    // DBARCH.AddLibraryItem(NewSourceGuid$, file_SourceName, file_SourceTypeCode, LibraryName$)
                    // Next
                    // End If

                    // 'Dim VersionNbr As String = "0"

                    // DBARCH.UpdateDocFqn(NewSourceGuid$, file_FullName)
                    // DBARCH.UpdateDocSize(NewSourceGuid$, file_Length$)
                    // DBARCH.UpdateDocDir(NewSourceGuid$, file_FullName)
                    // DBARCH.UpdateDocOriginalFileType(NewSourceGuid$, OriginalFileType$)
                    // DBARCH.UpdateZipFileIndicator(NewSourceGuid$, False)
                    // DBARCH.UpdateIsContainedWithinZipFile(NewSourceGuid$)
                    // Dim ZipFileFqn$ = DBARCH.getFqnFromGuid(ParentSourceGuid)
                    // DBARCH.UpdateZipFileOwnerGuid(ParentSourceGuid, NewSourceGuid$, ZipFileFqn$)

                    // 'DBARCH.delFileParms(NewSourceGuid$)
                    // InsertSrcAttrib(NewSourceGuid$, "FILENAME", file_SourceName, OriginalFileType$)
                    // InsertSrcAttrib(NewSourceGuid$, "CreateDate", file_CreateDate$, OriginalFileType$)
                    // InsertSrcAttrib(NewSourceGuid$, "FILESIZE", file_Length$, OriginalFileType$)
                    // InsertSrcAttrib(NewSourceGuid$, "ChangeDate", file_LastAccessDate, OriginalFileType$)
                    // InsertSrcAttrib(NewSourceGuid$, "WriteDate", file_LastWriteTime$, OriginalFileType$)

                    // Catch ex As Exception
                    // LOG.WriteToArchiveLog("ERROR DBARCH.AddSourceToRepo 200 " + ex.Message)
                    // BB = False
                    // End Try
                    // End If

                    // Else
                    // '** The document has changed, but versioning is not on...
                    // '** Delete and re-add.
                    // '** If zero add
                    // '** if 1, see if changed and if so, update, if not skip it   
                    // Dim LastVerNbr As Integer = DBARCH.GetMaxDataSourceVersionNbr(gCurrUserGuidID, file_FullName$)
                    // Dim AttachmentCode As String = "C"

                    // bChanged = DBARCH.isSourcefileOlderThanLastEntry(file_SourceName$, CrcHash)
                    // '** If it has, add it to the repository
                    // If bChanged Then
                    // Dim BB As Boolean = False

                    // Dim OriginalFileName As String = DMA.getFileName(file_FullName)
                    // BB = DBARCH.UpdateSourceFileImage(OriginalFileName, UID, MachineID, NewSourceGuid$, file_LastAccessDate$, file_CreateDate$, file_LastWriteTime$, LastVerNbr, file_FullName, RetentionCode, isPublic, CrcHash)
                    // If Not BB Then
                    // Dim MySql$ = "Delete from DataSource where SourceGuid = '" + NewSourceGuid$ + "'"
                    // DBARCH.ExecuteSqlNewConn(MySql)
                    // LOG.WriteToArchiveLog("Fatal Error - removed file '" + file_FullName + "' from the repository.")
                    // Else
                    // Dim BBX As Boolean = DBARCH.ExecuteSqlNewConn("Update DataSource set ParentGuid = '" + ParentSourceGuid + "' where SourceGuid = '" + NewSourceGuid$ + "' ")
                    // End If

                    // If LibraryList.Count > 0 Then
                    // For III As Integer = 0 To LibraryList.Count - 1
                    // Dim LibraryName$ = LibraryList(III)
                    // DBARCH.AddLibraryItem(NewSourceGuid$, file_SourceName, file_SourceTypeCode, LibraryName$)
                    // Next
                    // End If

                    // DBARCH.UpdateDocFqn(NewSourceGuid$, file_FullName)
                    // DBARCH.UpdateDocSize(NewSourceGuid$, file_Length$)
                    // DBARCH.UpdateDocOriginalFileType(NewSourceGuid$, OriginalFileType$)
                    // DBARCH.UpdateZipFileIndicator(NewSourceGuid$, "N")
                    // DBARCH.UpdateIsContainedWithinZipFile(NewSourceGuid$)
                    // DBARCH.UpdateZipFileOwnerGuid(ParentSourceGuid, NewSourceGuid$, file_FullName)

                    // DBARCH.UpdateDocDir(NewSourceGuid$, file_FullName)

                    // If (LCase(file_SourceTypeCode).Equals(".doc") Or LCase(file_SourceTypeCode).Equals(".docx")) Then
                    // GetWordDocMetadata(file_FullName, NewSourceGuid$, OriginalFileType$)
                    // End If
                    // If (file_SourceTypeCode.Equals(".xls") _
                    // Or file_SourceTypeCode.Equals(".xlsx") Or file_SourceTypeCode.Equals(".xlsm")) Then
                    // Me.GetExcelMetaData(file_FullName, NewSourceGuid$, OriginalFileType$)
                    // End If
                    // Else
                    // If ddebug Then Debug.Print("Document " + file_FullName + " has not changed, SKIPPING.")
                    // End If

                    // End If
                }

                NextFile:
                ;
            }

            foreach (string S in DirFiles)
            {
                try
                {
                    var FileAttributes = S.Split('|');
                    string file_FullName = FileAttributes[1];
                    // ISO.saveIsoFile("$FilesToDelete.dat", file_FullName$ + "|")
                    try
                    {
                        File.Delete(file_FullName);
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("Failed to delete A2: " + S);
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Failed to delete A3: " + S);
                }
            }

            My.MyProject.Forms.frmMain.SB2.Text = "";
        }

        public void ZeroizeDirectory(string DirectoryFQN)
        {
            string strFileSize = "";
            var di = new DirectoryInfo(DirectoryFQN);
            var aryFi = di.GetFiles("*.*");
            foreach (var fi in aryFi)
                fi.Delete();
        }

        public void ValidateExtExists(string FQN)
        {
            var ATYPE = new clsATTACHMENTTYPE();
            string FileExt = "." + UTIL.getFileSuffix(FQN);
            int bCnt = ATYPE.cnt_PK29(FileExt);
            if (bCnt == 0)
            {
                string argval = "Auto added this code.";
                ATYPE.setDescription(ref argval);
                ATYPE.setAttachmentcode(ref FileExt);
                ATYPE.Insert();
            }

            ATYPE = null;
        }

        public void UnzipAndLoadEmailAttachment(string UID, string MachineID, string TemporaryZipDirectory, string EmailGuid, string ZipFileFQN, int StackLevel, ref Dictionary<string, int> ListOfFiles)
        {
            string ExplodeEmailAttachment = DBARCH.getSystemParm("ExplodeEmailAttachment");
            if (ExplodeEmailAttachment.Equals("N"))
            {
                return;
            }
            // ExplodeEmailAttachment()
            // ExplodeEmailZip()
            // ExplodeContentZip()
            // Check to see if the "EXPLODE ZIP FILE flag is true and if so, just return true.

            StackLevel += 1;
            string RetentionCode = "Retain 10";
            string ispublic = "N";
            var TempZipFilesList = new List<string>();
            TempZipFilesList = DMA.GetFilesRecursive(TemporaryZipDirectory);
            string strFileSize = "";
            int KK = 0;
            double fSize = 0d;
            foreach (string FQN in TempZipFilesList)
            {
                if (ListOfFiles.Keys.Contains(FQN))
                {
                    int Level = ListOfFiles[FQN];
                    if (Level <= StackLevel)
                    {
                        goto SkipToNextFile;
                    }
                }
                else
                {
                    ListOfFiles.Add(FQN, StackLevel);
                }

                var FI = new FileInfo(FQN);
                fSize = FI.Length / 1000d;
                KK += 1;
                string AttachmentFileName = FI.FullName;
                string FileNameOnly = FI.Name;
                string FileExt = FI.Extension;
                string fDir = FI.DirectoryName;
                ValidateExtExists(AttachmentFileName);
                string Sha1Hash = ENC.GenerateSHA512HashFromFile(FQN);
                bool bbx = DBARCH.InsertAttachmentFqn(modGlobals.gCurrUserGuidID, AttachmentFileName, EmailGuid, FileNameOnly, FileExt, modGlobals.gCurrUserGuidID, RetentionCode, Sha1Hash, ispublic, fDir);
                My.MyProject.Forms.frmNotify2.lblMsg2.Text = string.Format("Attachment: " + KK.ToString() + " of " + TempZipFilesList.Count.ToString() + " / {1:F}/kb : {2} ", fSize, FileNameOnly);
                My.MyProject.Forms.frmNotify.Refresh();
                Application.DoEvents();
                if (bbx)
                {
                    string MySql = "Update EmailAttachment set isZipFileEntry = 1 where EmailGuid = '" + EmailGuid + "' and AttachmentName = '" + FileNameOnly + "'";
                    DBARCH.ExecuteSqlNewConn(MySql, false);
                    if (isZipFile(FileNameOnly))
                    {
                        bool SkipIfAlreadyArchived = false;
                        ProcessEmailZipFile(modGlobals.gMachineID, EmailGuid, FileNameOnly, modGlobals.gCurrUserGuidID, SkipIfAlreadyArchived, AttachmentFileName, StackLevel, ref ListOfFiles);
                    }
                }
                else if (ddebug)
                    Debug.Print("Error 743.21a - Failed to save attachment: " + TemporaryZipDirectory + "/" + FileNameOnly);
                SkipToNextFile:
                ;
            }

            foreach (var S in TempZipFilesList)
            {
                try
                {
                    // ISO.saveIsoFile("$FilesToDelete.dat", S + "|")
                    if (File.Exists(S))
                    {
                        File.Delete(S);
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Failed to delete A4: " + S);
                }
            }

            My.MyProject.Forms.frmNotify2.lblMsg2.Text = "";
            My.MyProject.Forms.frmNotify.Refresh();
            Application.DoEvents();
        }

        public bool ProcessEmailZipFile(string MachineID, string EmailGuid, string FQN, string OwnerGCurrUserID, bool SkipIfAlreadyArchived, string ZipFileFQN, int StackLevel, ref Dictionary<string, int> ListOfFiles)
        {
            string ExplodeEmailZip = DBARCH.getSystemParm("ExplodeEmailZip");
            if (ExplodeEmailZip.Equals("N"))
            {
                return true;
            }
            // ExplodeEmailAttachment()
            // ExplodeEmailZip()
            // ExplodeContentZip()
            // Check to see if the "EXPLODE ZIP FILE flag is true and if so, just return true.

            string UID = OwnerGCurrUserID;
            bool isArchiveBitOn = DMA.isArchiveBitOn(FQN);
            bool bIsArchivedAlready = DMA.isFileArchiveAttributeSet(FQN);
            if (bIsArchivedAlready == false & SkipIfAlreadyArchived == true)
            {
                return true;
            }

            string ZipProcessingDir = UTIL.getTempProcessingDir();
            ZipProcessingDir = ZipProcessingDir + "TempZip" + "." + Guid.NewGuid().ToString();
            ZipProcessingDir = ZipProcessingDir.Replace(@"\\", @"\");
            if (!Directory.Exists(ZipProcessingDir))
            {
                try
                {
                    Directory.CreateDirectory(ZipProcessingDir);
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("ERROR: Failed to create Temp ZIP unload Directory" + ZipProcessingDir + ", aborting.");
                    return false;
                }
            }

            string fExt = UTIL.getFileSuffix(FQN);
            fExt = fExt.ToUpper();
            bool B = false;
            if (Strings.UCase(fExt).Equals("ZIP"))
            {
                B = UnZip(FQN, ZipProcessingDir);
                if (B)
                {
                    UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, EmailGuid, ZipFileFQN, StackLevel, ref ListOfFiles);
                }
                else
                {
                    DBARCH.addDocSourceError("EMAIL", OwnerGCurrUserID, "ERROR: The ZIP file '" + FQN + "' failed to extract and load.");
                }

                DMA.ToggleArchiveBit(FQN);
            }
            else if (Strings.UCase(fExt).Equals("ISO") | fExt.Equals("ARJ") | fExt.Equals("CAB") | fExt.Equals("CHM") | fExt.Equals("CPIO") | fExt.Equals("CramFS") | fExt.Equals("DEB") | fExt.Equals("DMG") | fExt.Equals("FAT") | fExt.Equals("HFS") | fExt.Equals("LZH") | fExt.Equals("LZMA") | fExt.Equals("MBR") | fExt.Equals("MSI") | fExt.Equals("NSIS") | fExt.Equals("NTFS") | fExt.Equals("RAR") | fExt.Equals("RPM") | fExt.Equals("SquashFS") | fExt.Equals("UDF") | fExt.Equals("VHD") | fExt.Equals("WIM") | fExt.Equals("XAR") | fExt.Equals("Z"))





















            {
                B = Un7zip(FQN, ref ZipProcessingDir);
                if (B)
                {
                    UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, EmailGuid, ZipFileFQN, StackLevel, ref ListOfFiles);
                }
                else
                {
                    DBARCH.addDocSourceError("EMAIL", OwnerGCurrUserID, "ERROR: The RAR file '" + FQN + "' failed to extract and load.");
                }

                DMA.ToggleArchiveBit(FQN);
            }
            else if (Strings.UCase(fExt).Equals("GZ"))
            {
                B = UntarGZarchive(FQN);
                if (B)
                {
                    UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, EmailGuid, ZipFileFQN, StackLevel, ref ListOfFiles);
                }
                else
                {
                    DBARCH.addDocSourceError("EMAIL", OwnerGCurrUserID, "ERROR: The GZ file '" + FQN + "' failed to extract and load.");
                }

                DMA.ToggleArchiveBit(FQN);
            }
            else if (Strings.UCase(fExt).Equals("Z"))
            {
                B = UntarZarchive(FQN);
                if (B)
                {
                    UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, EmailGuid, ZipFileFQN, StackLevel, ref ListOfFiles);
                }
                else
                {
                    DBARCH.addDocSourceError("EMAIL", OwnerGCurrUserID, "ERROR: The 'Z' ZIP file '" + FQN + "' failed to extract and load.");
                }

                DMA.ToggleArchiveBit(FQN);
            }
            else if (Strings.UCase(fExt).Equals("TAR"))
            {
                B = UnTarArchive(FQN);
                if (B)
                {
                    UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, EmailGuid, ZipFileFQN, StackLevel, ref ListOfFiles);
                }
                else
                {
                    DBARCH.addDocSourceError("EMAIL", OwnerGCurrUserID, "ERROR: The TAR file '" + FQN + "' failed to extract and load.");
                }

                DMA.ToggleArchiveBit(FQN);
            }

            return default;
        }

        /// <summary>
    /// This is a recursive routine that takes the top direcotry as the starting path and
    /// will return all directories and subdirectories of subdirectoriDB.
    /// </summary>
    /// <param name="StartPath">The top level directory to search</param>
    /// <param name="DirectoryList">An array list object that will be populated with all subdirectoriDB.</param>
    /// <remarks></remarks>
        public void GetDirectories(string StartPath, ref ArrayList DirectoryList)
        {
            try
            {
                var Dirs = Directory.GetDirectories(StartPath);
                DirectoryList.AddRange(Dirs);
                foreach (string Dir in Dirs)
                    GetDirectories(Dir, ref DirectoryList);
            }
            catch (Exception ex)
            {
                DBARCH.xTrace(443276, "GetDirectories", ex.Message.ToString());
                LOG.WriteToArchiveLog("clsZipFiles : GetDirectories : 184 : " + ex.Message);
            }
        }
        /// <summary>
    /// This is a routine that calls the recursive routine GetDirectoriDB. It gets all directories within the top directory,
    /// marks all files within each directory as "normal"
    /// and then deletes each file within the directory.
    /// </summary>
    /// <param name="DirPath">Top level directory to delete.</param>
    /// <remarks></remarks>
        public void RemoveAllDirFiles(string DirPath)
        {
            var DirList = new ArrayList();
            GetDirectories(DirPath, ref DirList);
            for (int i = 0, loopTo = DirList.Count - 1; i <= loopTo; i++)
            {
                string dName = Conversions.ToString(DirList[i]);
                try
                {
                    var dir = new DirectoryInfo(dName);
                    foreach (var f in dir.GetFiles())
                    {
                        f.Attributes = FileAttributes.Normal;
                        if (ddebug)
                            Console.WriteLine(f.Name);
                        f.Delete();
                    }
                }
                catch (Exception ex)
                {
                    Debug.Print(ex.Message);
                    LOG.WriteToArchiveLog("clsZipFiles : RemoveAllDirFiles : 197 : " + ex.Message);
                }
            }
        }

        public string GetUnZipDir()
        {
            string dirPath = UTIL.getTempProcessingDir();
            dirPath = dirPath + "TempZip" + "." + Guid.NewGuid().ToString();
            if (Directory.Exists(dirPath))
            {
            }
            else
            {
                Directory.CreateDirectory(dirPath);
            }

            return dirPath;
        }

        public string GetEmailUnZipDir()
        {
            string dirPath = UTIL.getTempProcessingDir();
            dirPath = dirPath + "TempEmailZip";
            if (Directory.Exists(dirPath))
            {
            }
            else
            {
                Directory.CreateDirectory(dirPath);
            }

            RemoveAllDirFiles(dirPath);
            bool B = false;
            try
            {
                Directory.Delete(dirPath, true);
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
                LOG.WriteToArchiveLog("clsZipFiles : GetUnZipDir : 207 : " + ex.Message);
            }
            finally
            {
                Interaction.Beep();
            }

            if (Directory.Exists(dirPath))
            {
                B = true;
            }

            if (B)
            {
                foreach (var s in Directory.GetFiles(dirPath))
                {
                    try
                    {
                        File.Delete(s);
                    }
                    catch (Exception ex)
                    {
                        Debug.Print(ex.Message);
                        string dName = dirPath;
                        try
                        {
                            var dir = new DirectoryInfo(dName);
                            foreach (var f in dir.GetFiles())
                            {
                                f.Attributes = FileAttributes.Normal;
                                Debug.Print(f.Name);
                                f.Delete();
                            }
                        }
                        catch (Exception ex2)
                        {
                            Debug.Print(ex2.Message);
                            LOG.WriteToArchiveLog("clsZipFiles : GetUnZipDir : 226 : " + ex2.Message);
                        }
                    }
                }
            }
            else
            {
                Directory.CreateDirectory(dirPath);
            }

            return dirPath;
        }

        public bool UnZip(string FQN, string ZipProcessingDir)
        {
            string ExplodeContentZip = DBARCH.getSystemParm("ExplodeContentZip");
            if (ExplodeContentZip.Equals("N"))
            {
                return true;
            }
            // ExplodeEmailAttachment()
            // ExplodeEmailZip()
            // ExplodeContentZip()
            // Check to see if the "EXPLODE ZIP FILE flag is true and if so, just return true.

            FQN = UTIL.ReplaceSingleQuotes(FQN);
            if (!File.Exists(FQN))
            {
                LOG.WriteToArchiveLog("ERROR: UnZip 151.1 - ZIP file not found : " + FQN);
                return false;
            }

            bool B = true;
            // This must be called once at the beginning of your program.
            zip.UnlockComponent("DMACHIZIP_YDZk6Rmz3Ivf");
            // Don't forget to enable events.
            zip.EnableEvents = true;
            try
            {
                // Open a zip archive.
                bool success;
                success = zip.OpenZip(FQN);
                if (!success)
                {
                    MessageBox.Show(zip.LastErrorText);
                    return default;
                }

                // Dim UnzipDirectory As String = GetUnZipDir()
                int numFilesUnzipped = 0;

                // Unzip to a sub-directory relative to the current working directory
                // of the calling process.  If the myZip directory does not exist,
                // it is automatically created.
                numFilesUnzipped = zip.Unzip(ZipProcessingDir);
                if (numFilesUnzipped < 0)
                {
                    // MessageBox.Show(zip.LastErrorText)
                    DBARCH.xTrace(221975, "clsZipFiles:UnZip", "Failed for: " + zip.LastErrorText + " : " + modGlobals.gCurrUserGuidID);
                    LOG.WriteToArchiveLog("ERROR: UnZip 151.3 - Failed for: " + zip.LastErrorText + " : " + modGlobals.gCurrUserGuidID);
                    return false;
                }

                zip.CloseZip();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: UnZip 151.2 - ZIP file not found : " + ex.Message.ToString());
            }

            return B;
        }

        public bool UnRar(string FQN)
        {
            var rar = new Chilkat.Rar();
            string dirPath = GetUnZipDir();
            bool success;
            success = rar.Open(FQN);
            int iFiles = rar.NumEntries;
            if (success != true)
            {
                MessageBox.Show(rar.LastErrorText);
                return default;
            }

            success = rar.Unrar(dirPath);
            if (success != true)
            {
                // messagebox.show(rar.LastErrorText)
                DBARCH.xTrace(221975, "clsZipFiles:UnRar", "Failed for: " + rar.LastErrorText + " : " + modGlobals.gCurrUserGuidID);
                return false;
            }
            else
            {
                // messagebox.show("Success.")
                return true;
            }
        }

        public bool Un7zip(string FQN, ref string UnzipDir)
        {
            bool success = true;
            UnzipDir = UnzipDir.Replace(@"\\", @"\");
            string Z7Path = "";
            string Zip7Executable = Application.ExecutablePath;
            var FI = new FileInfo(Zip7Executable);
            Zip7Executable = FI.DirectoryName;
            Z7Path = FI.DirectoryName;
            FI = null;
            GC.Collect();
            Zip7Executable = Zip7Executable + @"\Z7\7z.exe";
            try
            {
                string ProcessLine = "x -o" + UnzipDir + " " + Conversions.ToString('"') + FQN + Conversions.ToString('"');
                // Process.Start(Zip7Executable, ProcessLine)
                var ProcessProperties = new ProcessStartInfo();
                ProcessProperties.WorkingDirectory = UnzipDir;
                ProcessProperties.FileName = Zip7Executable;
                ProcessProperties.Arguments = ProcessLine;
                ProcessProperties.WindowStyle = ProcessWindowStyle.Minimized;
                var myProcess = Process.Start(ProcessProperties);
                myProcess.WaitForExit();
                // You can even start a hidden process ... 
                // ProcessProperties.WindowStyle = ProcessWindowStyle.Hidden
                myProcess.Dispose();
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }
            catch (Exception ex)
            {
                success = false;
                DBARCH.xTrace(221975, "clsZipFiles:Un7zip", "Failed for: " + FQN + " / " + ex.Message + " : " + modGlobals.gCurrUserGuidID);
            }

            return success;
        }

        public bool UntarGZarchive(string FQN)
        {
            string dirPath = GetUnZipDir();
            string fName = DMA.getFileName(FQN);


            // The Chilkat.Gzip class is included with the "Chilkat Zip" license.
            var gz = new Chilkat.Gzip();
            gz.UnlockComponent("DMACHITarArch_XqG3YzDa5MA0");
            bool bNoAbsolute;
            string untarRoot;


            // bNoAbsolute controls whether leading '/' or '\' are automatically
            // removed from filepaths to ensure that all files are untarred to
            // a directory beneath the untarRoot.
            bNoAbsolute = true;
            untarRoot = dirPath;


            // The UnTarZ method is streaming. Files of any size
            // may be uncompressed and untarred.  No temporary files are produced.
            bool success;
            success = gz.UnTarGz(fName, untarRoot, bNoAbsolute);
            if (!success)
            {
                // MessageBox.Show(gz.LastErrorText)
                DBARCH.xTrace(221975, "clsZipFiles:UntarGZarchive", "Failed for: " + gz.LastErrorText + " : " + modGlobals.gCurrUserGuidID);
                return false;
            }

            return true;
        }

        public bool UntarZarchive(string FQN)
        {
            string dirPath = GetUnZipDir();
            string fName = DMA.getFileName(FQN);


            // The Chilkat.UnixCompress class is included with the "Chilkat Zip" license.
            var z = new Chilkat.UnixCompress();
            z.UnlockComponent("DMACHITarArch_XqG3YzDa5MA0");
            bool bNoAbsolute;
            string untarRoot;


            // bNoAbsolute controls whether leading '/' or '\' are automatically
            // removed from filepaths to ensure that all files are untarred to
            // a directory beneath the untarRoot.
            bNoAbsolute = true;
            untarRoot = dirPath;


            // The UnTarZ method is streaming. Files of any size
            // may be uncompressed and untarred.  No temporary files are produced.
            bool success;
            success = z.UnTarZ(fName, untarRoot, bNoAbsolute);
            if (!success)
            {
                // MessageBox.Show(z.LastErrorText)
                DBARCH.xTrace(221975, "clsZipFiles:UntarZarchive", "Failed for: " + z.LastErrorText + " : " + modGlobals.gCurrUserGuidID);
                return false;
            }

            return true;
        }

        public bool UnTarArchive(string FQN)
        {
            try
            {
                string dirPath = GetUnZipDir();
                string fName = DMA.getFileName(FQN);


                // The Chilkat.UnixCompress class is included with the "Chilkat Zip" license.
                // Dim z As New Chilkat.UnixCompress()
                // z.UnlockComponent("DMACHITarArch_XqG3YzDa5MA0")


                // The Chilkat.Tar class is a free Chilkat.NET class.
                var tar = new Chilkat.Tar();


                // Remove leading '/' or '\' characters when
                // untarring so that the directories created are 
                // relative to the untar root directory.
                tar.NoAbsolutePaths = true;


                // Set our untar root directory.
                tar.UntarFromDir = dirPath;


                // Untar into the UntarFromDir,
                // the directory tree (if it exists) is
                // re-created at the UntarFromDir
                bool B = Conversions.ToBoolean(tar.Untar(fName));
                return B;
            }
            catch (Exception ex)
            {
                // messagebox.show(ex.Message)
                DBARCH.xTrace(221975, "clsZipFiles:UnTarArchive", "Failed for: " + ex.Message + " : " + modGlobals.gCurrUserGuidID);
                LOG.WriteToArchiveLog("clsZipFiles : UnTarArchive : 293 : " + ex.Message);
                return false;
            }
        }

        public bool isZipFile(string FQN)
        {
            string fExt = UTIL.getFileSuffix(FQN).ToUpper();
            bool B = false;
            if (Strings.UCase(fExt).Equals("ZIP"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("RAR"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("GZ"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("ISO"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("TAR"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("ARJ"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("CAB"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("CHM"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("CPIO"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("CramFS"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("DEB"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("DMG"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("FAT"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("HFS"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("LZH"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("LZMA"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("MBR"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("MSI"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("NSIS"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("NTFS"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("RPM"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("SquashFS"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("UDF"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("VHD"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("WIM"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("XAR"))
            {
                B = true;
            }
            else if (Strings.UCase(fExt).Equals("Z"))
            {
                B = true;
            }

            return B;
        }

        public void InsertSrcAttrib(string SGCurrUserID, string aName, string aVal, string OriginalFileType)
        {
            SRCATTR.setSourceguid(ref SGCurrUserID);
            SRCATTR.setAttributename(ref aName);
            SRCATTR.setAttributevalue(ref aVal);
            SRCATTR.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
            SRCATTR.setSourcetypecode(ref OriginalFileType);
            int iCnt = SRCATTR.cnt_PK35(aName, modGlobals.gCurrUserGuidID, SGCurrUserID);
            if (iCnt > 0)
            {
                string WC = SRCATTR.wc_PK35(aName, modGlobals.gCurrUserGuidID, SGCurrUserID);
                SRCATTR.Update(WC);
            }
            else
            {
                SRCATTR.Insert();
            }
        }

        public void GetWordDocMetadata(string FQN, string SourceGCurrUserID, string OriginalFileType)
        {
            string TempDir = UTIL.getTempProcessingDir();
            string fName = DMA.getFileName(FQN);
            string NewFqn = TempDir + fName;
            File.Copy(FQN, NewFqn, true);
            var WDOC = new clsMsWord();
            WDOC.initWordDocMetaData(NewFqn, SourceGCurrUserID, OriginalFileType);
            ISO.saveIsoFile("$FilesToDelete.dat", NewFqn + "|");
            // File.Delete(NewFqn$)


        }

        public void GetExcelMetaData(string FQN, string SourceGCurrUserID, string OriginalFileType)
        {
            string TempDir = UTIL.getTempProcessingDir();
            string fName = DMA.getFileName(FQN);
            string NewFqn = TempDir + fName;
            File.Copy(FQN, NewFqn, true);
            var WDOC = new clsMsWord();
            WDOC.initExcelMetaData(NewFqn, SourceGCurrUserID, OriginalFileType);
            ISO.saveIsoFile("$FilesToDelete.dat", NewFqn + "|");
            // File.Delete(NewFqn$)


        }

        public bool isExtIncluded(string fExt)
        {
            bool B = false;
            for (int i = 0, loopTo = IncludedTypes.Count - 1; i <= loopTo; i++)
            {
                string tExtension = IncludedTypes[i].ToString();
                if (Strings.UCase(tExtension).Equals(Strings.UCase(fExt)))
                {
                    B = true;
                    break;
                }
                else if (Strings.UCase(tExtension).Equals("*"))
                {
                    B = true;
                    break;
                }
            }

            return B;
        }

        public bool isExtExcluded(string fExt)
        {
            bool B = false;
            for (int i = 0, loopTo = ExcludedTypes.Count - 1; i <= loopTo; i++)
            {
                string tExtension = ExcludedTypes[i].ToString();
                if (Strings.UCase(tExtension).Equals(Strings.UCase(fExt)))
                {
                    B = true;
                    break;
                }
                else if (Strings.UCase(tExtension).Equals("*"))
                {
                    B = true;
                    break;
                }
            }

            return B;
        }

        // Public Function ProcessEmailZipFileXX(ByVal EmailGuid$, _
        // ByVal FQN$, _
        // ByVal OwnerGCurrUserID$, _
        // ByVal SkipIfAlreadyArchived As Boolean, _
        // ByVal AName$, _
        // ByRef AttachmentsLoaded As Boolean, _
        // ByVal StackLevel As Integer, _
        // ByRef ListOfFiles As Dictionary(Of String, Integer)) As Boolean

        // Dim isArchiveBitOn As Boolean = UTIL.isArchiveBitOn(FQN)
        // Dim bIsArchivedAlready As Boolean = UTIL.isFileArchiveAttributeSet(FQN)
        // If bIsArchivedAlready = False And SkipIfAlreadyArchived = True Then
        // Return True
        // End If

        // Dim ZipProcessingDir As String = UTIL.getTempProcessingDir
        // ZipProcessingDir = ZipProcessingDir + "TempZip" + "." + EmailGuid$
        // ZipProcessingDir = ZipProcessingDir.Replace("\\", "\")

        // Dim fExt$ = UTIL.getFileSuffix(FQN)
        // fExt = fExt.ToUpper
        // Dim B As Boolean = False

        // If UCase(fExt).Equals("ZIP") Then
        // B = UnZip(FQN, ZipProcessingDir)
        // If B Then
        // UnzipAndLoadEmailAttachment(OwnerGCurrUserID, gMachineID, ZipProcessingDir, EmailGuid, ZipProcessingDir, StackLevel, ListOfFiles)
        // Else
        // DBARCH.addDocSourceError(OwnerGCurrUserID$, "ERROR: The ZIP file '" + FQN + "' failed to extract and load.")
        // If Not bThisIsAnEmail Then
        // DBARCH.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: The TAR file '" + FQN + "' failed to extract and load.")
        // Else
        // DBARCH.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: The TAR file '" + FQN + "' failed to extract and load.")
        // End If
        // End If
        // UTIL.TurnOffArchiveBit(FQN)
        // ElseIf UCase(fExt).Equals("RAR") Then
        // B = UnRar(FQN$)
        // If B Then
        // UnzipAndLoadEmailAttachment(OwnerGCurrUserID, gMachineID, ZipProcessingDir, EmailGuid, ZipProcessingDir, StackLevel, ListOfFiles)
        // Else
        // DBARCH.addDocSourceError(OwnerGCurrUserID$, "ERROR: The RAR file '" + FQN + "' failed to extract and load.")
        // End If
        // UTIL.TurnOffArchiveBit(FQN)
        // ElseIf UCase(fExt).Equals("GZ") Then
        // B = UntarGZarchive(FQN$)
        // If B Then
        // UnzipAndLoadEmailAttachment(OwnerGCurrUserID, gMachineID, ZipProcessingDir, EmailGuid, ZipProcessingDir, StackLevel, ListOfFiles)
        // Else
        // DBARCH.addDocSourceError(OwnerGCurrUserID$, "ERROR: The GZ file '" + FQN + "' failed to extract and load.")
        // End If
        // UTIL.TurnOffArchiveBit(FQN)
        // ElseIf UCase(fExt).Equals("Z") Then
        // B = Me.UntarZarchive(FQN$)
        // If B Then
        // UnzipAndLoadEmailAttachment(OwnerGCurrUserID, gMachineID, ZipProcessingDir, EmailGuid, ZipProcessingDir, StackLevel, ListOfFiles)
        // Else
        // DBARCH.addDocSourceError(OwnerGCurrUserID$, "ERROR: The 'Z' ZIP file '" + FQN + "' failed to extract and load.")
        // End If
        // UTIL.TurnOffArchiveBit(FQN)
        // ElseIf UCase(fExt).Equals("TAR") Then
        // B = UnTarArchive(FQN$)
        // If B Then
        // UnzipAndLoadEmailAttachment(OwnerGCurrUserID, gMachineID, ZipProcessingDir, EmailGuid, ZipProcessingDir, StackLevel, ListOfFiles)
        // Else
        // DBARCH.addDocSourceError(OwnerGCurrUserID$, "ERROR: The TAR file '" + FQN + "' failed to extract and load.")
        // End If
        // UTIL.TurnOffArchiveBit(FQN)
        // End If
        // Return True
        // End Function

        public void UnzipAndLoadEmailAttachment(string DirectoryFQN, string EmailGuid, string AttachmentName, ref bool AttachmentsLoaded)
        {
            string ExplodeEmailZip = DBARCH.getSystemParm("ExplodeEmailZip");
            if (ExplodeEmailZip.Equals("N"))
            {
                return;
            }
            // ExplodeEmailAttachment()
            // ExplodeEmailZip()
            // ExplodeContentZip()
            // Check to see if the "EXPLODE ZIP FILE flag is true and if so, just return true.

            string RetentionCode = "Retain 10";
            string ispublic = "N";
            var DirFiles = new List<string>();
            DirFiles = DMA.GetFilesRecursive(DirectoryFQN);
            string strFileSize = "";
            var di = new DirectoryInfo(DirectoryFQN);
            var aryFi = di.GetFiles("*.*");
            FileInfo fi;
            foreach (string FN in DirFiles)
            {
                string filename = FN;
                string FileNameOnly = Path.GetFileName(FN);
                string FileExt = Path.GetExtension(FN);
                ValidateExtExists(filename);
                string fDir = DirectoryFQN + AttachmentName;
                string Sha1Hash = ENC.GenerateSHA512HashFromFile(filename);
                bool bbx = DBARCH.InsertAttachmentFqn(modGlobals.gCurrUserGuidID, filename, EmailGuid, FileNameOnly, FileExt, modGlobals.gCurrUserGuidID, RetentionCode, Sha1Hash, ispublic, fDir);
                if (bbx)
                {
                    string MySql = "Update EmailAttachment set isZipFileEntry = 1 where EmailGuid = '" + EmailGuid + "' and AttachmentName = '" + FileNameOnly + "'";
                    DBARCH.ExecuteSqlNewConn(MySql, false);
                    try
                    {
                        FileSystem.Kill(filename);
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine(ex.Message);
                    }
                }
                else if (ddebug)
                    Debug.Print("Error 743.21a - Failed to save attachment: " + AttachmentName + "/" + FileNameOnly);
            }

            fi = null;
            GC.Collect();
            GC.WaitForPendingFinalizers();
        }
    }
}
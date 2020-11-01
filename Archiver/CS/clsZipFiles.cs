#define RemoteOcr
// VBConversions Note: VB project level imports
using System.Collections.Generic;
using System;
using System.Drawing;
using System.Linq;
using System.Diagnostics;
using System.Data;
using Microsoft.VisualBasic;
using MODI;
using System.Xml.Linq;
using System.Collections;
using System.Windows.Forms;
// End of VB project level imports

using System.Data.SqlClient;
using System.IO;
using Outlook = Microsoft.Office.Interop.Outlook;
using System.Reflection;
using System.Data.Sql;
using System.Configuration;
//using System.Configuration.AppSettingsReader;
//using System.Configuration.ConfigurationSettings;
using System.Security.Principal;




namespace EcmArchiveClcSetup
{
	public class clsZipFiles
	{
		
		int TotalFilesEvaluated = 0;
		
		Chilkat.Zip zip = new Chilkat.Zip();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		clsEncrypt ENC = new clsEncrypt();
		
		clsIsolatedStorage ISO = new clsIsolatedStorage();
		clsZIPDATASOURCE ZDS = new clsZIPDATASOURCE();
		clsDatabase DB = new clsDatabase();
		clsAVAILFILETYPESUNDEFINED UNASGND = new clsAVAILFILETYPESUNDEFINED();
		clsSOURCEATTRIBUTE SRCATTR = new clsSOURCEATTRIBUTE();
		//Dim CMODI As New clsModi
		bool dDebug = true;
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
			
			StackLevel++;
			bool isArchiveBitOn = DMA.isArchiveBitOn(FQN);
			bool bIsArchivedAlready = DMA.isFileArchiveAttributeSet(FQN);
			string ZipProcessingDir = UTIL.getTempProcessingDir();
			ZipProcessingDir = ZipProcessingDir + "TempZip" + Guid.NewGuid().ToString();
			ZipProcessingDir = ZipProcessingDir.Replace("\\\\", "\\");
			
			if (! Directory.Exists(ZipProcessingDir))
			{
				try
				{
					Directory.CreateDirectory(ZipProcessingDir);
				}
				catch (Exception)
				{
					LOG.WriteToArchiveLog("ERROR UploadZipFile 100: Failed to create temporary unzip directory, " + ZipProcessingDir + ", aborting.");
					return false;
				}
			}
			
			var fExt = UTIL.getFileSuffix(FQN);
			bool B = false;
			
			fExt = fExt.ToUpper();
			if (fExt.ToUpper().Equals("ZIP"))
			{
				B = UnZip(FQN, ZipProcessingDir);
				if (B)
				{
					if (! bThisIsAnEmail)
					{
						UnzipAndLoadContent(UID, MachineID, ZipProcessingDir, ParentZipGuid, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
					}
					else
					{
						UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, ParentZipGuid, null, StackLevel, ref ListOfFiles);
					}
				}
				else
				{
					if (! bThisIsAnEmail)
					{
						DB.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: UploadZipFile -  The ZIP file \'" + FQN + "\' failed to extract and load.");
					}
					else
					{
						DB.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: UploadZipFile -  The ZIP file \'" + FQN + "\' failed to extract and load.");
					}
					
				}
				DMA.ToggleArchiveBit(FQN);
				
			}
			else if (fExt.Equals("ISO") || fExt.Equals("ARJ") || fExt.Equals("CAB") || fExt.Equals("CHM") || fExt.Equals("CPIO") || fExt.Equals("CramFS") || fExt.Equals("DEB") || fExt.Equals("DMG") || fExt.Equals("FAT") || fExt.Equals("HFS") || fExt.Equals("LZH") || fExt.Equals("LZMA") || fExt.Equals("MBR") || fExt.Equals("MSI") || fExt.Equals("NSIS") || fExt.Equals("NTFS") || fExt.Equals("RPM") || fExt.Equals("SquashFS") || fExt.Equals("UDF") || fExt.Equals("VHD") || fExt.Equals("WIM") || fExt.Equals("XAR"))
			{
				
				B = Un7zip(FQN, ref ZipProcessingDir);
				//WDMXXXX
				if (B)
				{
					if (! bThisIsAnEmail)
					{
						UnzipAndLoadContent(UID, MachineID, ZipProcessingDir, ParentZipGuid, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
					}
					else
					{
						UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, ParentZipGuid, null, StackLevel, ref ListOfFiles);
					}
				}
				else
				{
					if (! bThisIsAnEmail)
					{
						DB.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: UploadZipFile -  The " + fExt + " file \'" + FQN + "\' failed to extract and load.");
					}
					else
					{
						DB.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: UploadZipFile -  The " + fExt + " file \'" + FQN + "\' failed to extract and load.");
					}
				}
				//Dim TheFileIsArchived As Boolean = True
				//DMA.setFileArchiveAttributeSet(FQN, TheFileIsArchived)
				DMA.ToggleArchiveBit(FQN);
			}
			else if (fExt.ToUpper().Equals("RAR"))
			{
				B = UnRar(FQN);
				if (B)
				{
					if (! bThisIsAnEmail)
					{
						UnzipAndLoadContent(UID, MachineID, ZipProcessingDir, ParentZipGuid, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
					}
					else
					{
						UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, ParentZipGuid, null, StackLevel, ref ListOfFiles);
					}
				}
				else
				{
					if (! bThisIsAnEmail)
					{
						DB.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: UploadZipFile -  The RAR file \'" + FQN + "\' failed to extract and load.");
					}
					else
					{
						DB.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: UploadZipFile -  The RAR file \'" + FQN + "\' failed to extract and load.");
					}
				}
				//Dim TheFileIsArchived As Boolean = True
				//DMA.setFileArchiveAttributeSet(FQN, TheFileIsArchived)
				DMA.ToggleArchiveBit(FQN);
			}
			else if (fExt.ToUpper().Equals("GZ"))
			{
				B = UntarGZarchive(FQN);
				if (B)
				{
					if (! bThisIsAnEmail)
					{
						UnzipAndLoadContent(UID, MachineID, ZipProcessingDir, ParentZipGuid, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
					}
					else
					{
						UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, ParentZipGuid, null, StackLevel, ref ListOfFiles);
					}
				}
				else
				{
					if (! bThisIsAnEmail)
					{
						DB.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: UploadZipFile -  The GZ file \'" + FQN + "\' failed to extract and load.");
					}
					else
					{
						DB.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: UploadZipFile -  The GZ file \'" + FQN + "\' failed to extract and load.");
					}
				}
				//Dim TheFileIsArchived As Boolean = True
				//DMA.setFileArchiveAttributeSet(FQN, TheFileIsArchived)
				DMA.ToggleArchiveBit(FQN);
			}
			else if (fExt.ToUpper().Equals("Z"))
			{
				B = this.UntarZarchive(FQN);
				if (B)
				{
					if (! bThisIsAnEmail)
					{
						UnzipAndLoadContent(UID, MachineID, ZipProcessingDir, ParentZipGuid, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
					}
					else
					{
						UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, ParentZipGuid, null, StackLevel, ref ListOfFiles);
					}
				}
				else
				{
					if (! bThisIsAnEmail)
					{
						DB.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: UploadZipFile -  The Z-ZIP file \'" + FQN + "\' failed to extract and load.");
					}
					else
					{
						DB.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: UploadZipFile -  The Z-ZIP file \'" + FQN + "\' failed to extract and load.");
					}
				}
				//Dim TheFileIsArchived As Boolean = True
				//DMA.setFileArchiveAttributeSet(FQN, TheFileIsArchived)
				DMA.ToggleArchiveBit(FQN);
			}
			else if (fExt.ToUpper().Equals("TAR"))
			{
				B = UnTarArchive(FQN);
				if (B)
				{
					if (! bThisIsAnEmail)
					{
						UnzipAndLoadContent(UID, MachineID, ZipProcessingDir, ParentZipGuid, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
					}
					else
					{
						UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, ParentZipGuid, null, StackLevel, ref ListOfFiles);
					}
				}
				else
				{
					if (! bThisIsAnEmail)
					{
						DB.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: UploadZipFile -  The TAR file \'" + FQN + "\' failed to extract and load.");
					}
					else
					{
						DB.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: UploadZipFile -  The TAR file \'" + FQN + "\' failed to extract and load.");
					}
				}
				//Dim TheFileIsArchived As Boolean = True
				//DMA.setFileArchiveAttributeSet(FQN, TheFileIsArchived)
				DMA.ToggleArchiveBit(FQN);
			}
			
		}
		
		public void UnzipAndLoadContent(string UID, string MachineID, string ZipProcessingDir, string ParentSourceGuid, bool bThisIsAnEmail, string RetentionCode, string isPublic, int StackLevel, ref Dictionary<string, int> ListOfFiles)
		{
			
			List<string> DirFiles = new List<string>();
			List<string> DirFiles2 = new List<string>();
			
			List<string> LibraryList = new List<string>();
			
			string NewSourceGuid = System.Guid.NewGuid().ToString();
			
			DB.GetAllIncludedFiletypes(ZipProcessingDir, IncludedTypes, "N");
			DB.GetAllExcludedFiletypes(ZipProcessingDir, ExcludedTypes, "N");
			
			if (IncludedTypes.Count == 0)
			{
				IncludedTypes.Add("*");
			}
			
			bool bChanged = false;
			//** Get all of the files in this folder
			
			ArrayList DirectoryList = new ArrayList();
			
			GetDirectories(ZipProcessingDir, ref DirectoryList);
			
			int ii = 0;
			
			if (DirectoryList.Count > 0)
			{
				for (int X = 0; X <= DirectoryList.Count - 1; X++)
				{
					var tDir = DirectoryList[X];
					try
					{
						ii += DMA.getFilesInDir(tDir, DirFiles, IncludedTypes, ExcludedTypes, false);
					}
					catch (Exception ex)
					{
						LOG.WriteToArchiveLog((string) ("clsZipFiles : LoadUnzippedFiles : 62 : " + ex.Message));
						return;
					}
				}
			}
			
			ii = DMA.getFilesInDir(ZipProcessingDir, DirFiles2, IncludedTypes, ExcludedTypes, false);
			
			foreach (string SS in DirFiles2)
			{
				DirFiles.Add(SS);
			}
			
			if (ii == 0)
			{
				return;
			}
			for (int K = 0; K <= DirFiles.Count - 1; K++)
			{
				TotalFilesEvaluated++;
				
				NewSourceGuid = System.Guid.NewGuid().ToString();
				
				string[] FileAttributes = DirFiles(K).Split("|");
				string file_FullName = FileAttributes[1];
				string file_SourceName = FileAttributes[0];
				
				int iExist = 0;
				iExist = DB.iCount("select COUNT(*) from DataSource where SourceName = \'" + UTIL.RemoveSingleQuotes(file_SourceName) + "\' and SourceGuid = \'" + ParentSourceGuid + "\'");
				if (iExist == 0)
				{
					iExist = DB.iCount("select COUNT(*) from EmailAttachment where AttachmentName = \'" + UTIL.RemoveSingleQuotes(file_SourceName) + "\' and EmailGuid = \'" + ParentSourceGuid + "\'");
				}
				
				if (iExist > 0)
				{
					goto NextFile;
				}
				
				string CrcHash = ENC.getSha1HashFromFile(file_FullName);
				
				if (ListOfFiles.Keys.Contains(file_FullName))
				{
					int Level = System.Convert.ToInt32(ListOfFiles.Item(file_FullName));
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
				var file_Length = FileAttributes[2];
				if (modGlobals.gMaxSize > 0)
				{
					if (val[file_Length] > modGlobals.gMaxSize)
					{
						LOG.WriteToArchiveLog("Notice: file \'" + file_FullName + "\' exceed the allowed file upload size, skipped.");
						goto NextFile;
					}
				}
				double iLen = double.Parse(file_Length);
				frmNotify.Default.lblFileSpec.Text = (string) ("ZIP Load: " + (K + 1).ToString() + " of " + DirFiles.Count.ToString() + " / " + (iLen / 1000).ToString() + "/kb" + " : " + file_SourceName);
				frmNotify.Default.Refresh();
				
				var file_DirName = DMA.GetFilePath(file_FullName);
				
				//** WDMXX
				DB.GetDirectoryLibraries(file_DirName, LibraryList);
				
				var file_SourceTypeCode = FileAttributes[3];
				var file_LastAccessDate = FileAttributes[4];
				var file_CreateDate = FileAttributes[5];
				var file_LastWriteTime = FileAttributes[6];
				var OriginalFileType = file_SourceTypeCode;
				
				int bcnt = DB.iGetRowCount("SourceType", "where SourceTypeCode = \'" + file_SourceTypeCode + "\'");
				if (bcnt == 0)
				{
					var SubstituteFileType = DB.getProcessFileAsExt(file_SourceTypeCode);
					if (SubstituteFileType == null)
					{
						var MSG = "The file type \'" + file_SourceTypeCode + "\' is undefined." + "\r\n" + "DO YOU WISH TO AUTOMATICALLY DEFINE IT?" + "\r\n" + "This will allow content to be archived, but not searched.";
						//Dim dlgRes As DialogResult = 'MessageBox.Show(MSG, "Filetype Undefined", MessageBoxButtons.YesNo)
						
						UNASGND.setApplied("0");
						UNASGND.setFiletype(ref file_SourceTypeCode);
						int iCnt = UNASGND.cnt_PK_AFTU(file_SourceTypeCode);
						if (iCnt == 0)
						{
							UNASGND.Insert();
						}
						
						clsSOURCETYPE ST = new clsSOURCETYPE();
						ST.setSourcetypecode(ref file_SourceTypeCode);
						ST.setSourcetypedesc("Extension " + file_SourceTypeCode + " AUTO ADDED");
						ST.setIndexable("0");
						ST.setStoreexternal(0);
						ST.Insert();
					}
					else
					{
						file_SourceTypeCode = SubstituteFileType;
					}
				}
				
				string StoredExternally = "N";
				int iDatasourceCnt = DB.getCountDataSourceFiles(file_SourceName, CrcHash);
				if (iDatasourceCnt == 0)
				{
					DB.saveContentOwner(NewSourceGuid, modGlobals.gCurrUserGuidID, "C", file_DirName, modGlobals.gMachineID, modGlobals.gNetworkID);
				}
				
				
				bool SkipIfAlreadyArchived = true;
				
				if (iDatasourceCnt == 0)
				{
					//*******************************************
					//* File does not exist in REPO, Add it
					//*******************************************
					int LastVerNbr = 99;
					bool BB = false;
					
					try
					{
						if (file_SourceTypeCode.ToUpper().Equals(".MSG"))
						{
							clsEmailFunctions EMX = new clsEmailFunctions();
							List<string> xAttachedFiles = new List<string>();
							if (File.Exists(file_FullName))
							{
								EMX.LoadMsgFile(UID, file_FullName, modGlobals.gMachineID, "CONTENT-ZIP-FILE", "", RetentionCode, "UNKNOWN", "", ref xAttachedFiles, false, NewSourceGuid, "FOUND IN CONTENT ZIP FILE:" + file_FullName.Replace("\'", "`"));
							}
							EMX = null;
						}
						else
						{
							
							string AttachmentCode = "C";
							//Dim CrcHash As String = ENC.getSha1HashFromFile(file_FullName)
							
							BB = DB.InsertSourcefile(UID, MachineID, modGlobals.gNetworkID, NewSourceGuid, file_FullName, file_SourceName, file_SourceTypeCode, file_LastAccessDate, file_CreateDate, file_LastWriteTime, modGlobals.gCurrUserGuidID, LastVerNbr, RetentionCode, isPublic, CrcHash, file_DirName);
							if (BB)
							{
								bool BBX = DB.ExecuteSqlNewConn("Update DataSource set ParentGuid = \'" + ParentSourceGuid + "\' where SourceGuid = \'" + NewSourceGuid + "\' ");
							}
						}
					}
					catch (Exception ex)
					{
						LOG.WriteToArchiveLog((string) ("ERROR DB.InsertSourcefile 300a " + ex.Message));
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
							for (int III = 0; III <= LibraryList.Count - 1; III++)
							{
								var LibraryName = LibraryList(III);
								clsArchiver ARCH = new clsArchiver();
								ARCH.AddLibraryItem(NewSourceGuid, file_SourceName, file_SourceTypeCode, LibraryName);
								ARCH = null;
								GC.Collect();
								GC.WaitForPendingFinalizers();
							}
						}
						Application.DoEvents();
						
						DB.UpdateDocFqn(NewSourceGuid, file_FullName);
						DB.UpdateDocSize(NewSourceGuid, file_Length);
						DB.UpdateDocDir(NewSourceGuid, file_FullName);
						DB.UpdateDocOriginalFileType(NewSourceGuid, OriginalFileType);
						DB.UpdateZipFileIndicator(NewSourceGuid, false);
						DB.UpdateIsContainedWithinZipFile(NewSourceGuid);
						var ZipFileFqn = DB.getFqnFromGuid(ParentSourceGuid);
						DB.UpdateZipFileOwnerGuid(ParentSourceGuid, NewSourceGuid, ZipFileFqn);
						
						Application.DoEvents();
						InsertSrcAttrib(NewSourceGuid, "FILENAME", file_SourceName, OriginalFileType);
						InsertSrcAttrib(NewSourceGuid, "CreateDate", file_CreateDate, OriginalFileType);
						InsertSrcAttrib(NewSourceGuid, "FILESIZE", file_Length, OriginalFileType);
						InsertSrcAttrib(NewSourceGuid, "ChangeDate", file_LastAccessDate, OriginalFileType);
						InsertSrcAttrib(NewSourceGuid, "WriteDate", file_LastWriteTime, OriginalFileType);
						
					}
					//Else
					//    Dim FOLDER_VersionFiles$ = "Y"  '** This is a ZIPPED file, version it right upfront
					//    If UCase(FOLDER_VersionFiles$).Equals("Y") Then
					//        '** Get the last version number of this file in the repository,
					//        Dim LastVerNbr As Integer = DB.GetMaxDataSourceVersionNbr(gCurrUserGuidID, file_FullName$)
					//        Dim NextVersionNbr As Integer = LastVerNbr + 1
					//        '** See if this version has been changed
					
					//        Dim AttachmentCode As String = "C"
					//        'Dim CrcHash As String = ENC.getSha1HashFromFile(file_SourceName$)
					
					//        bChanged = DB.isSourcefileOlderThanLastEntry(file_SourceName$, CrcHash)
					//        '** If it has, add it to the repository
					//        If bChanged Then
					
					//            Dim BB As Boolean = False
					//            Try
					//                BB = DB.InsertSourcefile(UID, MachineID, gNetworkID, NewSourceGuid$, _
					//                                     file_FullName, _
					//                                     file_SourceName, _
					//                                     file_SourceTypeCode, _
					//                                     file_LastAccessDate$, _
					//                                     file_CreateDate$, _
					//                                     file_LastWriteTime$, gCurrUserGuidID, NextVersionNbr, RetentionCode, isPublic, CrcHash, file_DirName$)
					
					//                If BB Then
					//                    Dim BBX As Boolean = DB.ExecuteSqlNewConn("Update DataSource set ParentGuid = '" + ParentSourceGuid + "' where SourceGuid = '" + NewSourceGuid$ + "' ")
					//                End If
					
					//                If LibraryList.Count > 0 Then
					//                    For III As Integer = 0 To LibraryList.Count - 1
					//                        Dim LibraryName$ = LibraryList(III)
					//                        DB.AddLibraryItem(NewSourceGuid$, file_SourceName, file_SourceTypeCode, LibraryName$)
					//                    Next
					//                End If
					
					//                'Dim VersionNbr As String = "0"
					
					//                DB.UpdateDocFqn(NewSourceGuid$, file_FullName)
					//                DB.UpdateDocSize(NewSourceGuid$, file_Length$)
					//                DB.UpdateDocDir(NewSourceGuid$, file_FullName)
					//                DB.UpdateDocOriginalFileType(NewSourceGuid$, OriginalFileType$)
					//                DB.UpdateZipFileIndicator(NewSourceGuid$, False)
					//                DB.UpdateIsContainedWithinZipFile(NewSourceGuid$)
					//                Dim ZipFileFqn$ = DB.getFqnFromGuid(ParentSourceGuid)
					//                DB.UpdateZipFileOwnerGuid(ParentSourceGuid, NewSourceGuid$, ZipFileFqn$)
					
					//                'DB.delFileParms(NewSourceGuid$)
					//                InsertSrcAttrib(NewSourceGuid$, "FILENAME", file_SourceName, OriginalFileType$)
					//                InsertSrcAttrib(NewSourceGuid$, "CreateDate", file_CreateDate$, OriginalFileType$)
					//                InsertSrcAttrib(NewSourceGuid$, "FILESIZE", file_Length$, OriginalFileType$)
					//                InsertSrcAttrib(NewSourceGuid$, "ChangeDate", file_LastAccessDate, OriginalFileType$)
					//                InsertSrcAttrib(NewSourceGuid$, "WriteDate", file_LastWriteTime$, OriginalFileType$)
					
					//            Catch ex As Exception
					//                LOG.WriteToArchiveLog("ERROR DB.InsertSourcefile 200 " + ex.Message)
					//                BB = False
					//            End Try
					//        End If
					
					//    Else
					//        '** The document has changed, but versioning is not on...
					//        '** Delete and re-add.
					//        '** If zero add
					//        '** if 1, see if changed and if so, update, if not skip it
					//        Dim LastVerNbr As Integer = DB.GetMaxDataSourceVersionNbr(gCurrUserGuidID, file_FullName$)
					//        Dim AttachmentCode As String = "C"
					
					//        bChanged = DB.isSourcefileOlderThanLastEntry(file_SourceName$, CrcHash)
					//        '** If it has, add it to the repository
					//        If bChanged Then
					//            Dim BB As Boolean = False
					
					//            Dim OriginalFileName As String = DMA.getFileName(file_FullName)
					//            BB = DB.UpdateSourceImage(OriginalFileName, UID, MachineID, NewSourceGuid$, file_LastAccessDate$, file_CreateDate$, file_LastWriteTime$, LastVerNbr, file_FullName, RetentionCode, isPublic, CrcHash)
					//            If Not BB Then
					//                Dim MySql$ = "Delete from DataSource where SourceGuid = '" + NewSourceGuid$ + "'"
					//                DB.ExecuteSqlNewConn(MySql)
					//                LOG.WriteToArchiveLog("Fatal Error - removed file '" + file_FullName + "' from the repository.")
					//            Else
					//                Dim BBX As Boolean = DB.ExecuteSqlNewConn("Update DataSource set ParentGuid = '" + ParentSourceGuid + "' where SourceGuid = '" + NewSourceGuid$ + "' ")
					//            End If
					
					//            If LibraryList.Count > 0 Then
					//                For III As Integer = 0 To LibraryList.Count - 1
					//                    Dim LibraryName$ = LibraryList(III)
					//                    DB.AddLibraryItem(NewSourceGuid$, file_SourceName, file_SourceTypeCode, LibraryName$)
					//                Next
					//            End If
					
					//            DB.UpdateDocFqn(NewSourceGuid$, file_FullName)
					//            DB.UpdateDocSize(NewSourceGuid$, file_Length$)
					//            DB.UpdateDocOriginalFileType(NewSourceGuid$, OriginalFileType$)
					//            DB.UpdateZipFileIndicator(NewSourceGuid$, "N")
					//            DB.UpdateIsContainedWithinZipFile(NewSourceGuid$)
					//            DB.UpdateZipFileOwnerGuid(ParentSourceGuid, NewSourceGuid$, file_FullName)
					
					//            DB.UpdateDocDir(NewSourceGuid$, file_FullName)
					
					//            If (LCase(file_SourceTypeCode).Equals(".doc") Or LCase(file_SourceTypeCode).Equals(".docx")) Then
					//                GetWordDocMetadata(file_FullName, NewSourceGuid$, OriginalFileType$)
					//            End If
					//            If (file_SourceTypeCode.Equals(".xls") _
					//                        Or file_SourceTypeCode.Equals(".xlsx") Or file_SourceTypeCode.Equals(".xlsm")) Then
					//                Me.GetExcelMetaData(file_FullName, NewSourceGuid$, OriginalFileType$)
					//            End If
					//        Else
					//            If dDebug Then Debug.Print("Document " + file_FullName + " has not changed, SKIPPING.")
					//        End If
					
					//    End If
				}
NextFile:
				1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
			}
			
			foreach (string S in DirFiles)
			{
				try
				{
					object[] FileAttributes = S.Split("|".ToCharArray());
					var file_FullName = FileAttributes[1];
					//ISO.saveIsoFile("$FilesToDelete.dat", file_FullName$ + "|")
					try
					{
						File.Delete(file_FullName);
					}
					catch (Exception)
					{
						Console.WriteLine("Failed to delete 01: " + S);
					}
					
				}
				catch (Exception)
				{
					Console.WriteLine("Failed to delete 02: " + S);
				}
			}
			
			frmMain.Default.SB2.Text = "";
		}
		
		public void ZeroizeDirectory(string DirectoryFQN)
		{
			string strFileSize = "";
			System.IO.DirectoryInfo di = new System.IO.DirectoryInfo(DirectoryFQN);
			System.IO.FileInfo[] aryFi = di.GetFiles("*.*");
			
			
			foreach (System.IO.FileInfo fi in aryFi)
			{
				fi.Delete();
			}
		}
		
		public void ValidateExtExists(string FQN)
		{
			clsATTACHMENTTYPE ATYPE = new clsATTACHMENTTYPE();
			var FileExt = "." + UTIL.getFileSuffix(FQN);
			int bCnt = ATYPE.cnt_PK29(FileExt);
			if (bCnt == 0)
			{
				ATYPE.setDescription("Auto added this code.");
				ATYPE.setAttachmentcode(ref FileExt);
				ATYPE.Insert();
			}
			ATYPE = null;
		}
		
		public void UnzipAndLoadEmailAttachment(string UID, string MachineID, string TemporaryZipDirectory, string EmailGuid, string ZipFileFQN, int StackLevel, ref Dictionary<string, int> ListOfFiles)
		{
			
			StackLevel++;
			string RetentionCode = "Retain 10";
			string ispublic = "N";
			
			List<string> TempZipFilesList = new List<string>();
			TempZipFilesList = DMA.GetFilesRecursive(TemporaryZipDirectory);
			
			string strFileSize = "";
			int KK = 0;
			double fSize = 0;
			
			foreach (string FQN in TempZipFilesList)
			{
				
				if (ListOfFiles.Keys.Contains(FQN))
				{
					int Level = System.Convert.ToInt32(ListOfFiles.Item(FQN));
					if (Level <= StackLevel)
					{
						goto SkipToNextFile;
					}
				}
				else
				{
					ListOfFiles.Add(FQN, StackLevel);
				}
				
				FileInfo FI = new FileInfo(FQN);
				fSize = FI.Length / 1000;
				KK++;
				string AttachmentFileName = FI.FullName;
				string FileNameOnly = FI.Name;
				string FileExt = FI.Extension;
				string fDir = FI.DirectoryName;
				
				ValidateExtExists(AttachmentFileName);
				string Sha1Hash = ENC.getSha1HashFromFile(FQN);
				bool bbx = DB.InsertAttachmentFqn(modGlobals.gCurrUserGuidID, AttachmentFileName, EmailGuid, FileNameOnly, FileExt, modGlobals.gCurrUserGuidID, RetentionCode, Sha1Hash, ispublic, fDir);
				
				frmNotify2.Default.lblMsg2.Text = string.Format("Attachment: " + KK.ToString() + " of " + TempZipFilesList.Count.ToString() + " / {1:F}/kb : {2} ", fSize.ToString(), FileNameOnly);
				frmNotify.Default.Refresh();
				Application.DoEvents();
				if (bbx)
				{
					var MySql = "Update EmailAttachment set isZipFileEntry = 1 where EmailGuid = \'" + EmailGuid + "\' and AttachmentName = \'" + FileNameOnly + "\'";
					DB.ExecuteSqlNewConn(MySql, false);
					
					if (isZipFile(FileNameOnly))
					{
						bool SkipIfAlreadyArchived = false;
						ProcessEmailZipFile(modGlobals.gMachineID, EmailGuid, FileNameOnly, modGlobals.gCurrUserGuidID, SkipIfAlreadyArchived, AttachmentFileName, StackLevel, ref ListOfFiles);
					}
					
				}
				else
				{
					if (dDebug)
					{
						Debug.Print((string) ("Error 743.21a - Failed to save attachment: " + TemporaryZipDirectory + "/" + FileNameOnly));
					}
				}
SkipToNextFile:
				1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
			}
			
			foreach (var S in TempZipFilesList)
			{
				try
				{
					//ISO.saveIsoFile("$FilesToDelete.dat", S + "|")
					if (File.Exists(S.ToString()))
					{
						File.Delete(S.ToString());
					}
					
				}
				catch (Exception)
				{
					Console.WriteLine("Failed to delete: " + S);
				}
			}
			frmNotify2.Default.lblMsg2.Text = "";
			frmNotify.Default.Refresh();
			Application.DoEvents();
		}
		
		public bool ProcessEmailZipFile(string MachineID, string EmailGuid, string FQN, string OwnerGCurrUserID, bool SkipIfAlreadyArchived, string ZipFileFQN, int StackLevel, ref Dictionary<string, int> ListOfFiles)
		{
			
			string UID = OwnerGCurrUserID;
			bool isArchiveBitOn = DMA.isArchiveBitOn(FQN);
			bool bIsArchivedAlready = DMA.isFileArchiveAttributeSet(FQN);
			if (bIsArchivedAlready == false && SkipIfAlreadyArchived == true)
			{
				return true;
			}
			
			string ZipProcessingDir = UTIL.getTempProcessingDir();
			ZipProcessingDir = ZipProcessingDir + "TempZip" + "." + Guid.NewGuid().ToString();
			ZipProcessingDir = ZipProcessingDir.Replace("\\\\", "\\");
			
			if (! Directory.Exists(ZipProcessingDir))
			{
				try
				{
					Directory.CreateDirectory(ZipProcessingDir);
				}
				catch (Exception)
				{
					LOG.WriteToArchiveLog("ERROR: Failed to create Temp ZIP unload Directory" + ZipProcessingDir + ", aborting.");
					return false;
				}
			}
			
			var fExt = UTIL.getFileSuffix(FQN);
			fExt = fExt.ToUpper();
			bool B = false;
			
			if (fExt.ToUpper().Equals("ZIP"))
			{
				B = UnZip(FQN, ZipProcessingDir);
				if (B)
				{
					UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, EmailGuid, ZipFileFQN, StackLevel, ref ListOfFiles);
				}
				else
				{
					DB.addDocSourceError("EMAIL", OwnerGCurrUserID, "ERROR: The ZIP file \'" + FQN + "\' failed to extract and load.");
				}
				DMA.ToggleArchiveBit(FQN);
			}
			else if (fExt.ToUpper().Equals("ISO") || fExt.Equals("ARJ") || fExt.Equals("CAB") || fExt.Equals("CHM") || fExt.Equals("CPIO") || fExt.Equals("CramFS") || fExt.Equals("DEB") || fExt.Equals("DMG") || fExt.Equals("FAT") || fExt.Equals("HFS") || fExt.Equals("LZH") || fExt.Equals("LZMA") || fExt.Equals("MBR") || fExt.Equals("MSI") || fExt.Equals("NSIS") || fExt.Equals("NTFS") || fExt.Equals("RAR") || fExt.Equals("RPM") || fExt.Equals("SquashFS") || fExt.Equals("UDF") || fExt.Equals("VHD") || fExt.Equals("WIM") || fExt.Equals("XAR") || fExt.Equals("Z"))
			{
				B = Un7zip(FQN, ref ZipProcessingDir);
				if (B)
				{
					UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, EmailGuid, ZipFileFQN, StackLevel, ref ListOfFiles);
				}
				else
				{
					DB.addDocSourceError("EMAIL", OwnerGCurrUserID, "ERROR: The RAR file \'" + FQN + "\' failed to extract and load.");
				}
				DMA.ToggleArchiveBit(FQN);
			}
			else if (fExt.ToUpper().Equals("GZ"))
			{
				B = UntarGZarchive(FQN);
				if (B)
				{
					UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, EmailGuid, ZipFileFQN, StackLevel, ref ListOfFiles);
				}
				else
				{
					DB.addDocSourceError("EMAIL", OwnerGCurrUserID, "ERROR: The GZ file \'" + FQN + "\' failed to extract and load.");
				}
				DMA.ToggleArchiveBit(FQN);
			}
			else if (fExt.ToUpper().Equals("Z"))
			{
				B = this.UntarZarchive(FQN);
				if (B)
				{
					UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, EmailGuid, ZipFileFQN, StackLevel, ref ListOfFiles);
				}
				else
				{
					DB.addDocSourceError("EMAIL", OwnerGCurrUserID, "ERROR: The \'Z\' ZIP file \'" + FQN + "\' failed to extract and load.");
				}
				DMA.ToggleArchiveBit(FQN);
			}
			else if (fExt.ToUpper().Equals("TAR"))
			{
				B = UnTarArchive(FQN);
				if (B)
				{
					UnzipAndLoadEmailAttachment(UID, MachineID, ZipProcessingDir, EmailGuid, ZipFileFQN, StackLevel, ref ListOfFiles);
				}
				else
				{
					DB.addDocSourceError("EMAIL", OwnerGCurrUserID, "ERROR: The TAR file \'" + FQN + "\' failed to extract and load.");
				}
				DMA.ToggleArchiveBit(FQN);
			}
			
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
				string[] Dirs = Directory.GetDirectories(StartPath);
				DirectoryList.AddRange(Dirs);
				foreach (string Dir in Dirs)
				{
					GetDirectories(Dir, ref DirectoryList);
				}
			}
			catch (Exception ex)
			{
				DB.xTrace(443276, "clsZipFiles", "GetDirectories", ex);
				LOG.WriteToArchiveLog((string) ("clsZipFiles : GetDirectories : 184 : " + ex.Message));
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
			ArrayList DirList = new ArrayList();
			GetDirectories(DirPath, ref DirList);
			for (int i = 0; i <= DirList.Count - 1; i++)
			{
				var dName = DirList[i];
				try
				{
					
					System.IO.DirectoryInfo dir = new System.IO.DirectoryInfo(dName);
					
					
					foreach (System.IO.FileInfo f in dir.GetFiles())
					{
						f.Attributes = System.IO.FileAttributes.Normal;
						if (dDebug)
						{
							Console.WriteLine(f.Name);
						}
						f.Delete();
					}
				}
				catch (Exception ex)
				{
					Debug.Print(ex.Message);
					LOG.WriteToArchiveLog((string) ("clsZipFiles : RemoveAllDirFiles : 197 : " + ex.Message));
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
				System.IO.Directory.Delete(dirPath, true);
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.ToString());
				LOG.WriteToArchiveLog((string) ("clsZipFiles : GetUnZipDir : 207 : " + ex.Message));
			}
			finally
			{
				Interaction.Beep();
			}
			
			
			if (System.IO.Directory.Exists(dirPath))
			{
				B = true;
			}
			if (B)
			{
				string s;
				foreach (string tempLoopVar_s in System.IO.Directory.GetFiles(dirPath))
				{
					s = tempLoopVar_s;
					try
					{
						System.IO.File.Delete(s);
					}
					catch (Exception ex)
					{
						Debug.Print(ex.Message);
						var dName = dirPath;
						try
						{
							
							System.IO.DirectoryInfo dir = new System.IO.DirectoryInfo(dName);
							foreach (System.IO.FileInfo f in dir.GetFiles())
							{
								f.Attributes = System.IO.FileAttributes.Normal;
								Debug.Print(f.Name);
								f.Delete();
							}
						}
						catch (Exception ex2)
						{
							Debug.Print(ex2.Message);
							LOG.WriteToArchiveLog((string) ("clsZipFiles : GetUnZipDir : 226 : " + ex2.Message));
						}
					}
				}
			}
			else
			{
				System.IO.Directory.CreateDirectory(dirPath);
			}
			return dirPath;
		}
		
		public bool UnZip(string FQN, string ZipProcessingDir)
		{
			
			FQN = UTIL.ReplaceSingleQuotes(FQN);
			
			if (! File.Exists(FQN))
			{
				LOG.WriteToArchiveLog((string) ("ERROR: UnZip 151.1 - ZIP file not found : " + FQN));
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
				success = System.Convert.ToBoolean(zip.OpenZip(FQN));
				if (! success)
				{
					MessageBox.Show((string) zip.LastErrorText);
					return false;
				}
				
				//Dim UnzipDirectory As String = GetUnZipDir()
				int numFilesUnzipped = 0;
				
				// Unzip to a sub-directory relative to the current working directory
				// of the calling process.  If the myZip directory does not exist,
				// it is automatically created.
				numFilesUnzipped = System.Convert.ToInt32(zip.Unzip(ZipProcessingDir));
				if (numFilesUnzipped < 0)
				{
					//MessageBox.Show(zip.LastErrorText)
					DB.xTrace(221975, "clsZipFiles:UnZip", (string) ("Failed for: " + zip.LastErrorText + " : " + modGlobals.gCurrUserGuidID));
					LOG.WriteToArchiveLog((string) ("ERROR: UnZip 151.3 - Failed for: " + zip.LastErrorText + " : " + modGlobals.gCurrUserGuidID));
					return false;
				}
				
				zip.CloseZip();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: UnZip 151.2 - ZIP file not found : " + ex.Message.ToString()));
			}
			
			
			return B;
		}
		public bool UnRar(string FQN)
		{
			
			
			Chilkat.Rar rar = new Chilkat.Rar();
			string dirPath = GetUnZipDir();
			
			bool success;
			
			success = System.Convert.ToBoolean(rar.Open(FQN));
			int iFiles = System.Convert.ToInt32(rar.NumEntries);
			if (success != true)
			{
				MessageBox.Show((string) rar.LastErrorText);
				return false;
			}
			
			success = System.Convert.ToBoolean(rar.Unrar(dirPath));
			if (success != true)
			{
				//messagebox.show(rar.LastErrorText)
				DB.xTrace(221975, "clsZipFiles:UnRar", (string) ("Failed for: " + rar.LastErrorText + " : " + modGlobals.gCurrUserGuidID));
				return false;
			}
			else
			{
				//messagebox.show("Success.")
				return true;
			}
			
		}
		
		public bool Un7zip(string FQN, ref string UnzipDir)
		{
			
			bool success = true;
			
			UnzipDir = UnzipDir.Replace("\\\\", "\\");
			
			string Z7Path = "";
			string Zip7Executable = Application.ExecutablePath;
			FileInfo FI = new FileInfo(Zip7Executable);
			Zip7Executable = FI.DirectoryName;
			Z7Path = FI.DirectoryName;
			FI = null;
			GC.Collect();
			
			Zip7Executable = Zip7Executable + "\\Z7\\7z.exe";
			
			try
			{
				string ProcessLine = (string) ("x -o" + UnzipDir + " " + '\u0022' + FQN + '\u0022');
				//Process.Start(Zip7Executable, ProcessLine)
				ProcessStartInfo ProcessProperties = new ProcessStartInfo();
				ProcessProperties.WorkingDirectory = UnzipDir;
				ProcessProperties.FileName = Zip7Executable;
				ProcessProperties.Arguments = ProcessLine;
				ProcessProperties.WindowStyle = ProcessWindowStyle.Minimized;
				Process myProcess = Process.Start(ProcessProperties);
				myProcess.WaitForExit();
				//You can even start a hidden process ...
				//ProcessProperties.WindowStyle = ProcessWindowStyle.Hidden
				myProcess.Dispose();
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			catch (Exception ex)
			{
				success = false;
				DB.xTrace(221975, "clsZipFiles:Un7zip", (string) ("Failed for: " + FQN + " / " + ex.Message + " : " + modGlobals.gCurrUserGuidID));
			}
			
			return success;
			
		}
		public bool UntarGZarchive(string FQN)
		{
			
			
			string dirPath = GetUnZipDir();
			var fName = DMA.getFileName(FQN);
			
			
			// The Chilkat.Gzip class is included with the "Chilkat Zip" license.
			Chilkat.Gzip gz = new Chilkat.Gzip();
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
			success = System.Convert.ToBoolean(gz.UnTarGz(fName, untarRoot, bNoAbsolute));
			if (! success)
			{
				//MessageBox.Show(gz.LastErrorText)
				DB.xTrace(221975, "clsZipFiles:UntarGZarchive", (string) ("Failed for: " + gz.LastErrorText + " : " + modGlobals.gCurrUserGuidID));
				return false;
			}
			
			
			return true;
			
			
		}
		
		
		public bool UntarZarchive(string FQN)
		{
			
			
			string dirPath = GetUnZipDir();
			var fName = DMA.getFileName(FQN);
			
			
			// The Chilkat.UnixCompress class is included with the "Chilkat Zip" license.
			Chilkat.UnixCompress z = new Chilkat.UnixCompress();
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
			success = System.Convert.ToBoolean(z.UnTarZ(fName, untarRoot, bNoAbsolute));
			if (! success)
			{
				//MessageBox.Show(z.LastErrorText)
				DB.xTrace(221975, "clsZipFiles:UntarZarchive", (string) ("Failed for: " + z.LastErrorText + " : " + modGlobals.gCurrUserGuidID));
				return false;
			}
			return true;
		}
		
		
		public bool UnTarArchive(string FQN)
		{
			try
			{
				string dirPath = GetUnZipDir();
				var fName = DMA.getFileName(FQN);
				
				
				// The Chilkat.UnixCompress class is included with the "Chilkat Zip" license.
				//Dim z As New Chilkat.UnixCompress()
				//z.UnlockComponent("DMACHITarArch_XqG3YzDa5MA0")
				
				
				// The Chilkat.Tar class is a free Chilkat.NET class.
				Chilkat.Tar tar = new Chilkat.Tar();
				
				
				// Remove leading '/' or '\' characters when
				// untarring so that the directories created are
				// relative to the untar root directory.
				tar.NoAbsolutePaths = true;
				
				
				// Set our untar root directory.
				tar.UntarFromDir = dirPath;
				
				
				// Untar into the UntarFromDir,
				// the directory tree (if it exists) is
				// re-created at the UntarFromDir
				bool B = System.Convert.ToBoolean(tar.Untar(fName));
				return B;
			}
			catch (Exception ex)
			{
				//messagebox.show(ex.Message)
				DB.xTrace(221975, "clsZipFiles:UnTarArchive", (string) ("Failed for: " + ex.Message + " : " + modGlobals.gCurrUserGuidID));
				LOG.WriteToArchiveLog((string) ("clsZipFiles : UnTarArchive : 293 : " + ex.Message));
				return false;
			}
			
			
		}
		
		public bool isZipFile(string FQN)
		{
			
			var fExt = UTIL.getFileSuffix(FQN).ToUpper();
			bool B = false;
			
			if (fExt.ToUpper().Equals("ZIP"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("RAR"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("GZ"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("ISO"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("TAR"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("ARJ"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("CAB"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("CHM"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("CPIO"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("CramFS"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("DEB"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("DMG"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("FAT"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("HFS"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("LZH"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("LZMA"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("MBR"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("MSI"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("NSIS"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("NTFS"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("RPM"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("SquashFS"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("UDF"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("VHD"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("WIM"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("XAR"))
			{
				B = true;
			}
			else if (fExt.ToUpper().Equals("Z"))
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
				var WC = SRCATTR.wc_PK35(aName, modGlobals.gCurrUserGuidID, SGCurrUserID);
				SRCATTR.Update(WC);
			}
			else
			{
				SRCATTR.Insert();
			}
			
		}
		public void GetWordDocMetadata(string FQN, string SourceGCurrUserID, string OriginalFileType)
		{
			
			
			var TempDir = UTIL.getTempProcessingDir();
			var fName = DMA.getFileName(FQN);
			var NewFqn = TempDir + fName;
			
			
			File.Copy(FQN, NewFqn, true);
			
			
			clsMsWord WDOC = new clsMsWord();
			WDOC.initWordDocMetaData(NewFqn, SourceGCurrUserID, OriginalFileType);
			
			ISO.saveIsoFile("$FilesToDelete.dat", NewFqn + "|");
			//File.Delete(NewFqn$)
			
			
		}
		public void GetExcelMetaData(string FQN, string SourceGCurrUserID, string OriginalFileType)
		{
			
			
			var TempDir = UTIL.getTempProcessingDir();
			var fName = DMA.getFileName(FQN);
			var NewFqn = TempDir + fName;
			
			
			File.Copy(FQN, NewFqn, true);
			
			
			clsMsWord WDOC = new clsMsWord();
			WDOC.initExcelMetaData(NewFqn, SourceGCurrUserID, OriginalFileType);
			
			ISO.saveIsoFile("$FilesToDelete.dat", NewFqn + "|");
			//File.Delete(NewFqn$)
			
			
		}
		public bool isExtIncluded(string fExt)
		{
			
			
			bool B = false;
			for (int i = 0; i <= IncludedTypes.Count - 1; i++)
			{
				var tExtension = IncludedTypes[i].ToString();
				if (Strings.UCase((string) tExtension).Equals(fExt.ToUpper()))
				{
					B = true;
					break;
				}
				else if (Strings.UCase((string) tExtension).Equals("*"))
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
			for (int i = 0; i <= ExcludedTypes.Count - 1; i++)
			{
				var tExtension = ExcludedTypes[i].ToString();
				if (Strings.UCase((string) tExtension).Equals(fExt.ToUpper()))
				{
					B = true;
					break;
				}
				else if (Strings.UCase((string) tExtension).Equals("*"))
				{
					B = true;
					break;
				}
			}
			return B;
		}
		
		//Public Function ProcessEmailZipFileXX(ByVal EmailGuid$, _
		//                                    ByVal FQN$, _
		//                                    ByVal OwnerGCurrUserID$, _
		//                                    ByVal SkipIfAlreadyArchived As Boolean, _
		//                                    ByVal AName$, _
		//                                    ByRef AttachmentsLoaded As Boolean, _
		//                                    ByVal StackLevel As Integer, _
		//                                ByRef ListOfFiles As Dictionary(Of String, Integer)) As Boolean
		
		//    Dim isArchiveBitOn As Boolean = UTIL.isArchiveBitOn(FQN)
		//    Dim bIsArchivedAlready As Boolean = UTIL.isFileArchiveAttributeSet(FQN)
		//    If bIsArchivedAlready = False And SkipIfAlreadyArchived = True Then
		//        Return True
		//    End If
		
		//    Dim ZipProcessingDir As String = UTIL.getTempProcessingDir
		//    ZipProcessingDir = ZipProcessingDir + "TempZip" + "." + EmailGuid$
		//    ZipProcessingDir = ZipProcessingDir.Replace("\\", "\")
		
		//    Dim fExt$ = UTIL.getFileSuffix(FQN)
		//    fExt = fExt.ToUpper
		//    Dim B As Boolean = False
		
		//    If UCase(fExt).Equals("ZIP") Then
		//        B = UnZip(FQN, ZipProcessingDir)
		//        If B Then
		//            UnzipAndLoadEmailAttachment(OwnerGCurrUserID, gMachineID, ZipProcessingDir, EmailGuid, ZipProcessingDir, StackLevel, ListOfFiles)
		//        Else
		//            DB.addDocSourceError(OwnerGCurrUserID$, "ERROR: The ZIP file '" + FQN + "' failed to extract and load.")
		//            If Not bThisIsAnEmail Then
		//                DB.addDocSourceError("EMAIL", ParentZipGuid, "ERROR: The TAR file '" + FQN + "' failed to extract and load.")
		//            Else
		//                DB.addDocSourceError("CONTENT", ParentZipGuid, "ERROR: The TAR file '" + FQN + "' failed to extract and load.")
		//            End If
		//        End If
		//        UTIL.TurnOffArchiveBit(FQN)
		//    ElseIf UCase(fExt).Equals("RAR") Then
		//        B = UnRar(FQN$)
		//        If B Then
		//            UnzipAndLoadEmailAttachment(OwnerGCurrUserID, gMachineID, ZipProcessingDir, EmailGuid, ZipProcessingDir, StackLevel, ListOfFiles)
		//        Else
		//            DB.addDocSourceError(OwnerGCurrUserID$, "ERROR: The RAR file '" + FQN + "' failed to extract and load.")
		//        End If
		//        UTIL.TurnOffArchiveBit(FQN)
		//    ElseIf UCase(fExt).Equals("GZ") Then
		//        B = UntarGZarchive(FQN$)
		//        If B Then
		//            UnzipAndLoadEmailAttachment(OwnerGCurrUserID, gMachineID, ZipProcessingDir, EmailGuid, ZipProcessingDir, StackLevel, ListOfFiles)
		//        Else
		//            DB.addDocSourceError(OwnerGCurrUserID$, "ERROR: The GZ file '" + FQN + "' failed to extract and load.")
		//        End If
		//        UTIL.TurnOffArchiveBit(FQN)
		//    ElseIf UCase(fExt).Equals("Z") Then
		//        B = Me.UntarZarchive(FQN$)
		//        If B Then
		//            UnzipAndLoadEmailAttachment(OwnerGCurrUserID, gMachineID, ZipProcessingDir, EmailGuid, ZipProcessingDir, StackLevel, ListOfFiles)
		//        Else
		//            DB.addDocSourceError(OwnerGCurrUserID$, "ERROR: The 'Z' ZIP file '" + FQN + "' failed to extract and load.")
		//        End If
		//        UTIL.TurnOffArchiveBit(FQN)
		//    ElseIf UCase(fExt).Equals("TAR") Then
		//        B = UnTarArchive(FQN$)
		//        If B Then
		//            UnzipAndLoadEmailAttachment(OwnerGCurrUserID, gMachineID, ZipProcessingDir, EmailGuid, ZipProcessingDir, StackLevel, ListOfFiles)
		//        Else
		//            DB.addDocSourceError(OwnerGCurrUserID$, "ERROR: The TAR file '" + FQN + "' failed to extract and load.")
		//        End If
		//        UTIL.TurnOffArchiveBit(FQN)
		//    End If
		//    Return True
		//End Function
		
		public void UnzipAndLoadEmailAttachment(string DirectoryFQN, string EmailGuid, string AttachmentName, bool AttachmentsLoaded)
		{
			
			string RetentionCode = "Retain 10";
			string ispublic = "N";
			
			List<string> DirFiles = new List<string>();
			DirFiles = DMA.GetFilesRecursive(DirectoryFQN);
			
			string strFileSize = "";
			System.IO.DirectoryInfo di = new System.IO.DirectoryInfo(DirectoryFQN);
			System.IO.FileInfo[] aryFi = di.GetFiles("*.*");
			System.IO.FileInfo fi;
			
			foreach (string FN in DirFiles)
			{
				string filename = FN;
				string FileNameOnly = System.IO.Path.GetFileName(FN);
				var FileExt = System.IO.Path.GetExtension(FN);
				ValidateExtExists(filename);
				
				string fDir = DirectoryFQN + AttachmentName;
				string Sha1Hash = ENC.getSha1HashFromFile(filename);
				bool bbx = DB.InsertAttachmentFqn(modGlobals.gCurrUserGuidID, filename, EmailGuid, FileNameOnly, FileExt, modGlobals.gCurrUserGuidID, RetentionCode, Sha1Hash, ispublic, fDir);
				if (bbx)
				{
					var MySql = "Update EmailAttachment set isZipFileEntry = 1 where EmailGuid = \'" + EmailGuid + "\' and AttachmentName = \'" + FileNameOnly + "\'";
					DB.ExecuteSqlNewConn(MySql, false);
					try
					{
						Kill(filename);
					}
					catch (Exception ex)
					{
						Console.WriteLine(ex.Message);
					}
					
				}
				else
				{
					if (dDebug)
					{
						Debug.Print((string) ("Error 743.21a - Failed to save attachment: " + AttachmentName + "/" + FileNameOnly));
					}
				}
			}
			
			fi = null;
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
		}
		
	}
	
}

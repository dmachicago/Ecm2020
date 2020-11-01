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

using Outlook = Microsoft.Office.Interop.Outlook;
using System.Reflection;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Configuration;
//using System.Configuration.AppSettingsReader;
//using System.Configuration.ConfigurationSettings;
using System.Security.Principal;
using System.IO;
using System.Threading;
using System.Runtime.InteropServices;
using Microsoft.VisualBasic.CompilerServices;

//** This constant, EnableSingleSource, currently DISABLES the
//** Single Source capability until we can figure out exactly
//** how to incorporate it into a search.

//#Const Office2007 = 0
//Imports Microsoft.Office.Interop.Outlook.ApplicationClass

/// <summary>
/// This service runs in background and archives selected emails to a
/// common archive database. The database is a SQL Server DB and allows
/// for full text search of archived emails.
/// </summary>
/// <remarks></remarks>
namespace EcmArchiveClcSetup
{
	public class clsArchiver : clsDatabase
	{
		
		clsEncrypt ENC = new clsEncrypt();
		clsIsolatedStorage ISO = new clsIsolatedStorage();
		clsRSS RSS = new clsRSS();
		clsLogging LOG = new clsLogging();
		clsCompression COMP = new clsCompression();
		clsUtility UTIL = new clsUtility();
		clsGlobalEntity GE = new clsGlobalEntity();
		
		string WorkingDir; // VBConversions Note: Initial value of "System.Configuration.ConfigurationManager.AppSettings["WEBProcessingDir"]" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		
		//**WDM Dim PDF As New clsPdfAnalyzer
		SVCCLCArchive.Service1Client Proxy = new SVCCLCArchive.Service1Client();
		clsDbLocal DBLocal = new clsDbLocal();
		public string EmailLibrary = "";
		
		
		bool bAddThisFileAsNewVersion = false;
		SortedList<string, string> ChildFoldersList = new SortedList<string, string>();
		int TotalFilesArchived = 0;
		
		[DllImport("shell32.dll",EntryPoint="ShellExecuteA", ExactSpelling=true, CharSet=CharSet.Ansi, SetLastError=true)]
		private static extern long ShellExecute(long hwnd, string lpOperation, string lpFile, string lpParameters, string lpDirectory, long nShowCmd);
		
		public bool xDebug = false;
		
		[DllImport("user32", ExactSpelling=true, CharSet=CharSet.Ansi, SetLastError=true)]
		private static extern long GetDesktopWindow();
		
		public ArrayList IncludedTypes = new ArrayList();
		public ArrayList ExcludedTypes = new ArrayList();
		public ArrayList ZipFiles = new ArrayList();
		int FilesBackedUp = 0;
		int FilesSkipped = 0;
		
		clsMP3 MP3 = new clsMP3();
		
		clsDataGrid DGV = new clsDataGrid();
		//Dim KAT As New clsChilKat
		// Create Outlook application.
		//Dim xDebug As Boolean = False
		clsEMAILFOLDER EMF = new clsEMAILFOLDER();
		clsEMAILTODELETE EM2D = new clsEMAILTODELETE();
		string FQN = "YourPath";
		int folderCount;
		int fileCount;
		clsATTACHMENTTYPE ATYPE = new clsATTACHMENTTYPE();
		clsQUICKDIRECTORY QDIR = new clsQUICKDIRECTORY();
		clsAVAILFILETYPESUNDEFINED UNASGND = new clsAVAILFILETYPESUNDEFINED();
		clsSOURCEATTRIBUTE SRCATTR = new clsSOURCEATTRIBUTE();
		clsZipFiles ZF = new clsZipFiles();
		//Dim DB As New clsDatabase
		
		bool bParseDir = false;
		string DirToParse = "";
		//Dim Redeem As New clsRedeem
		string ParseArchiveFolder = "";
		string ArchiveSentMail = "";
		string ArchiveInbox = "";
		
		int MaxDaysBeforeArchive = 0;
		clsEMAIL EMAIL = new clsEMAIL();
		clsRECIPIENTS RECIPS = new clsRECIPIENTS();
		clsDma DMA = new clsDma();
		clsCONTACTSARCHIVE CNTCT = new clsCONTACTSARCHIVE();
		
		SortedList SL = new SortedList();
		SortedList SL2 = new SortedList();
		
		public Outlook.NameSpace g_nspNameSpace;
		public Outlook.Application g_olApp;
		
		string OcrTextBack = "";
		string OcrText = "";
		
		public clsArchiver()
		{
			// VBConversions Note: Non-static class variable initialization is below.  Class variables cannot be initially assigned non-static values in C#.
			WorkingDir = System.Configuration.ConfigurationManager.AppSettings["WEBProcessingDir"];
			
			
			string sDebug = getUserParm("debug_clsArchive");
			if (sDebug.Equals("1"))
			{
				xDebug = true;
			}
			else
			{
				xDebug = false;
			}
			
		}
		
		public void setChildFoldersList(SortedList<string, string> CFL)
		{
			
			foreach (string sKey in CFL.Keys)
			{
				ChildFoldersList.Add(sKey, sKey);
			}
			
		}
		
		
		//Public Sub xArchiveStart(ByVal T As Timer)
		//    ' Add code here to start your service. This method should set things
		//    ' in motion so your service can do its work.
		
		//    '** Get the polling interval
		//    Dim PollingInterval As Integer = Val(System.Configuration.ConfigurationManager.AppSettings("PollIntervalMinutes"))
		//    '** Convert the MINUTES to Milliseconds.
		//    T.Interval = PollingInterval * 60000
		
		//End Sub
		public bool RestoreFolderExists(Outlook.MAPIFolder CurrFolder)
		{
			
			string FolderKeyName = "";
			//        Dim SubFolder As Outlook.MAPIFolder = olfolder
			int II = CurrFolder.Items.Count;
			int JJ = CurrFolder.Folders.Count;
			
			if (JJ > 0)
			{
				if (xDebug)
				{
					LOG.WriteToArchiveLog(CurrFolder.Name);
				}
				if (xDebug)
				{
					LOG.WriteToArchiveLog(CurrFolder.Items.Count.ToString());
				}
				if (xDebug)
				{
					LOG.WriteToArchiveLog(CurrFolder.Folders.Count.ToString());
				}
				//FolderKeyName  = FolderKeyName  + CurrFolder.Name
				FolderKeyName = CurrFolder.Name;
				for (int I = 1; I <= JJ; I++)
				{
					Outlook.MAPIFolder tFolder = CurrFolder.Folders[I];
					if (FolderKeyName.Equals(tFolder.Name))
					{
						return true;
					}
				}
				//            ProcessAllFolders(CurrFolder)
			}
			return false;
		}
		
		// VBConversions Note: Former VB local static variables moved to class level.
		static string ProcessAllFolders_FolderKeyName;
		
		public void ProcessAllFolders(string UID, string TopFolderName, Outlook.MAPIFolder CurrFolder, bool DeleteFile, string ArchiveEmails, string RemoveAfterArchive, string SetAsDefaultFolder, string ArchiveAfterXDays, string RemoveAfterXDays, string RemoveXDays, string ArchiveXDays, string DB_ID, string UserID, string ArchiveOnlyIfRead, int RetentionYears, string RetentionCode, bool ProcessingPstFile, string PstFQN, string ParentFolderID, SortedList slStoreId, string ispublic)
		{
			
			// static string FolderKeyName; VBConversions Note: Static variable moved to class level and renamed ProcessAllFolders_FolderKeyName. Local static variables are not supported in C#.
			string StoreID = CurrFolder.StoreID;
			
			//        Dim SubFolder As Outlook.MAPIFolder = olfolder
			int II = CurrFolder.Items.Count;
			int JJ = CurrFolder.Folders.Count;
			
			//Dim oApp As New Outlook.Application
			//Dim oNS As Outlook.NameSpace = oApp.GetNamespace("mapi")
			//Dim oTgtFolder As Outlook.MAPIFolder = oNS.Folders("Personal Folder").
			
			if (JJ > 0)
			{
				if (xDebug)
				{
					LOG.WriteToArchiveLog(CurrFolder.Name);
				}
				if (xDebug)
				{
					LOG.WriteToArchiveLog(CurrFolder.FolderPath);
				}
				
				GetFolderByPath(CurrFolder.FolderPath.ToString());
				if (xDebug)
				{
					LOG.WriteToArchiveLog(CurrFolder.Items.Count.ToString());
				}
				if (xDebug)
				{
					LOG.WriteToArchiveLog(CurrFolder.Folders.Count.ToString());
				}
				//FolderKeyName  = FolderKeyName  + CurrFolder.Name
				ProcessAllFolders_FolderKeyName = CurrFolder.Name;
				for (int I = 1; I <= JJ; I++)
				{
					Outlook.MAPIFolder tFolder = CurrFolder.Folders[I];
					string FID = tFolder.EntryID;
					
					ProcessAllFolders_FolderKeyName = TopFolderName + "|" + tFolder.Name;
					
					int BB = ckArchEmailFolder(ProcessAllFolders_FolderKeyName, UserID);
					if (BB == 0)
					{
						return;
					}
					
					if (xDebug)
					{
						LOG.WriteToArchiveLog(ProcessAllFolders_FolderKeyName);
					}
					ProcessAllFolders(UID, TopFolderName, tFolder, DeleteFile, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, UserID, ArchiveOnlyIfRead, RetentionYears, RetentionCode, ProcessingPstFile, PstFQN, ParentFolderID, slStoreId, ispublic);
				}
				//            ProcessAllFolders(CurrFolder)
			}
			else
			{
				if (xDebug)
				{
					LOG.WriteToArchiveLog(CurrFolder.Name);
				}
				if (xDebug)
				{
					LOG.WriteToArchiveLog(CurrFolder.FolderPath);
				}
				//GetFolderByPath(CurrFolder.FolderPath.ToString)
				if (xDebug)
				{
					LOG.WriteToArchiveLog(CurrFolder.Items.Count.ToString());
				}
				ProcessAllFolders_FolderKeyName = CurrFolder.Name;
				if (xDebug)
				{
					LOG.WriteToArchiveLog(ProcessAllFolders_FolderKeyName);
				}
				
				string FID = CurrFolder.EntryID;
				int BB = ckArchEmailFolder(ProcessAllFolders_FolderKeyName, UserID);
				if (BB == 0)
				{
					return;
				}
				
				AddPstFolder(StoreID, TopFolderName, ParentFolderID, ProcessAllFolders_FolderKeyName, FID, PstFQN, RetentionCode);
				
				DBLocal.setOutlookMissing();
				
				ArchiveEmailsInFolder(UID, TopFolderName, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, CurrFolder, StoreID, ArchiveOnlyIfRead, RetentionYears, RetentionCode, ProcessAllFolders_FolderKeyName, slStoreId, ispublic);
			}
			
		}
		// VBConversions Note: Former VB local static variables moved to class level.
		static string ProcessAllFolderSenders_FolderKeyName;
		
		public void ProcessAllFolderSenders(string UID, string FolderName, Outlook.MAPIFolder CurrFolder, bool DeleteFile, string ArchiveEmails, string RemoveAfterArchive, string SetAsDefaultFolder, string ArchiveAfterXDays, string RemoveAfterXDays, string RemoveXDays, string ArchiveXDays, string ContainerName)
		{
			
			Outlook.MAPIFolder tFolder = null;
			// static string FolderKeyName; VBConversions Note: Static variable moved to class level and renamed ProcessAllFolderSenders_FolderKeyName. Local static variables are not supported in C#.
			//        Dim SubFolder As Outlook.MAPIFolder = olfolder
			int II = CurrFolder.Items.Count;
			int CountOfSubfolders = CurrFolder.Folders.Count;
			bool ParentAlreadyProcessed = false;
			bool B = false;
			
			if (xDebug)
			{
				LOG.WriteToArchiveLog((string) ("Parent Folder: " + FolderName));
			}
			if (xDebug)
			{
				LOG.WriteToArchiveLog(CurrFolder.Name);
			}
			
			if (CountOfSubfolders == 0)
			{
				if (xDebug)
				{
					LOG.WriteToArchiveLog((string) ("CurrFolder.Items.Count: " + CurrFolder.Items.Count.ToString()));
				}
				ProcessAllFolderSenders_FolderKeyName = CurrFolder.Name;
				B = ckFolderExists(modGlobals.gCurrUserGuidID, ProcessAllFolderSenders_FolderKeyName, ContainerName);
				if (B)
				{
					if (xDebug)
					{
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("Processing Folder: " + ProcessAllFolderSenders_FolderKeyName));
						}
					}
					ArchiveEmailsInFolderenders(ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, CurrFolder, DeleteFile);
				}
				ParentAlreadyProcessed = true;
				return;
			}
			else
			{
				if (xDebug)
				{
					if (xDebug)
					{
						LOG.WriteToArchiveLog((string) ("Parent SUBFolder: " + FolderName));
					}
				}
				return;
			}
			
			if (CountOfSubfolders > 0)
			{
				if (xDebug)
				{
					LOG.WriteToArchiveLog(CurrFolder.Name);
				}
				if (xDebug)
				{
					LOG.WriteToArchiveLog(CurrFolder.Items.Count.ToString());
				}
				if (xDebug)
				{
					LOG.WriteToArchiveLog(CurrFolder.Folders.Count.ToString());
				}
				//FolderKeyName  = FolderKeyName  + CurrFolder.Name
				//Dim tFolderKeyName  = CurrFolder.Name
				B = ckFolderExists(modGlobals.gCurrUserGuidID, ProcessAllFolderSenders_FolderKeyName, ContainerName);
				if (B)
				{
					for (int I = 1; I <= CountOfSubfolders; I++)
					{
						tFolder = CurrFolder.Folders[I];
						int FolderID = int.Parse(CurrFolder.EntryID);
						if (xDebug)
						{
							LOG.WriteToArchiveLog("FolderID = " + CurrFolder.EntryID);
						}
						ProcessAllFolderSenders_FolderKeyName = ProcessAllFolderSenders_FolderKeyName + "->" + tFolder.Name;
						if (xDebug)
						{
							LOG.WriteToArchiveLog("Location clsArchiver:ProcessAllFolderSenders 0011: \'" + tFolder.Name + "\'.");
						}
						if (ProcessAllFolderSenders_FolderKeyName.Equals(FolderName))
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog(ProcessAllFolderSenders_FolderKeyName);
							}
							B = ckFolderExists(modGlobals.gCurrUserGuidID, ProcessAllFolderSenders_FolderKeyName, ContainerName);
							if (B)
							{
								ProcessAllFolderSenders(UID, FolderName, tFolder, DeleteFile, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, ContainerName);
							}
						}
						else
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("Skipping folder: " + ProcessAllFolderSenders_FolderKeyName));
							}
						}
						
					}
				}
				
			}
			else
			{
				if (! ParentAlreadyProcessed)
				{
					if (xDebug)
					{
						LOG.WriteToArchiveLog(CurrFolder.Name);
					}
					if (xDebug)
					{
						LOG.WriteToArchiveLog(CurrFolder.Items.Count.ToString());
					}
					ProcessAllFolderSenders_FolderKeyName = CurrFolder.Name;
					if (ProcessAllFolderSenders_FolderKeyName.Equals(FolderName))
					{
						B = ckFolderExists(modGlobals.gCurrUserGuidID, ProcessAllFolderSenders_FolderKeyName, ContainerName);
						if (B)
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("Processing Folder: " + ProcessAllFolderSenders_FolderKeyName));
							}
							ArchiveEmailsInFolderenders(ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, CurrFolder, DeleteFile);
						}
					}
					else
					{
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("Skipping folder: " + ProcessAllFolderSenders_FolderKeyName));
						}
					}
				}
				
			}
			
		}
		public void getSubFolderEmails(string UID, string TopFolderName, string MailboxName, string FolderName, bool DeleteFile, string ArchiveEmails, string RemoveAfterArchive, string SetAsDefaultFolder, string ArchiveAfterXDays, string RemoveAfterXDays, string RemoveXDays, string ArchiveXDays, string DB_ID, string UserID, string ArchiveOnlyIfRead, string FilterDate, int RetentionYears, string RetentionCode, bool ProcessPstFile, string PstFQN, string ParentFolderID, SortedList slStoreId)
		{
			
			Outlook.Application oApp = new Outlook.Application();
			string sBuild = oApp.Version.Substring(0, oApp.Version.IndexOf(".") + 2);
			Outlook.NameSpace oNS = oApp.GetNamespace("mapi");
			
			//******************
			string isPublic = "N";
			
			
			try
			{
				//Now that we have the MAPI namespace, we can log on using using:
				//<mapinamespace>.Logon(object Profile, object Password, object ShowDialog, object NewSession)
				//Profile: This is a string value that indicates what MAPI profile to use for logging on.
				//    Set this to null if using the currently logged on user, or set to an empty string ("")
				//    if you wish to use the default Outlook Profile.
				//Password: The password for the indicated profile. Set to null if using the currently
				//    logged on user, or set to an empty string ("") if you wish to use the default Outlook Profile password.
				//ShowDialog: Set to True to display the Outlook Profile dialog box.
				
				//oNS.Logon("OUTLOOK", Missing.Value, True, True)
				oNS.Logon(Missing.Value, Missing.Value, true, true);
				
				//Dim oMAPI As Outlook._NameSpace
				Outlook.MAPIFolder oParentFolder;
				
				
				oParentFolder = oNS.Folders[MailboxName];
				
				//Dim FLDR As Outlook.Folder
				//For Each FLDR In oParentFolder.Folders
				//    if xDebug then log.WriteToArchiveLog(FLDR.Name)
				//Next
				
				// Get Messages collection of Inbox.
				
				
				Outlook.MAPIFolder SFolder = null;
				
				foreach (Outlook.MAPIFolder SubFolder in oParentFolder.Folders)
				{
					ProcessAllFolders(UID, TopFolderName, SubFolder, DeleteFile, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, UserID, ArchiveOnlyIfRead, RetentionYears, RetentionCode, false, "", ParentFolderID, slStoreId, isPublic);
					
				}
				
			}
			catch (Exception ex)
			{
				MessageBox.Show(ex.Message);
			}
			finally
			{
				// In any case please remember to turn on Outlook Security after your code, since now it is very easy to switch it off! :-)
				//SecurityManager.DisableOOMWarnings = False
				oApp = null;
				oNS = null;
				
				GC.Collect();
			}
			
		}
		
		public void getSubFolderEmailsSenders(string UID, string MailboxName, string FolderName, bool DeleteFile, string ArchiveEmails, string RemoveAfterArchive, string SetAsDefaultFolder, string ArchiveAfterXDays, string RemoveAfterXDays, string RemoveXDays, string ArchiveXDays, string ContainerName)
		{
			
			int LL = 0;
			
			LL = 1784;
			Outlook.Application oApp = new Outlook.Application();
			LL = 1785;
			string sBuild = oApp.Version.Substring(0, oApp.Version.IndexOf(".") + 2);
			LL = 1786;
			
			LL = 1787;
			Outlook.NameSpace oNS = oApp.GetNamespace("mapi");
			LL = 6;
			try
			{
				LL = 7;
				//Now that we have the MAPI namespace, we can log on using using:
				LL = 8;
				//<mapinamespace>.Logon(object Profile, object Password, object ShowDialog, object NewSession)
				LL = 9;
				//Profile: This is a string value that indicates what MAPI profile to use for logging on.
				LL = 10;
				//    Set this to null if using the currently logged on user, or set to an empty string ("")
				LL = 11;
				//    if you wish to use the default Outlook Profile.
				LL = 12;
				//Password: The password for the indicated profile. Set to null if using the currently
				LL = 13;
				//    logged on user, or set to an empty string ("") if you wish to use the default Outlook Profile password.
				LL = 14;
				//ShowDialog: Set to True to display the Outlook Profile dialog box.
				LL = 15;
				
				LL = 16;
				//oNS.Logon("OUTLOOK", Missing.Value, True, True)
				LL = 17;
				oNS.Logon(Missing.Value, Missing.Value, true, true);
				LL = 18;
				
				LL = 19;
				//Dim oMAPI As Outlook._NameSpace
				LL = 20;
				Outlook.MAPIFolder OutlookFolders;
				LL = 21;
				
				LL = 22;
				
				LL = 23;
				OutlookFolders = oNS.Folders[MailboxName];
				LL = 24;
				
				LL = 25;
				// Get Messages collection of Inbox.
				LL = 26;
				
				LL = 27;
				
				LL = 28;
				Outlook.MAPIFolder SFolder = null;
				LL = 29;
				
				LL = 30;
				foreach (Outlook.MAPIFolder Folder in OutlookFolders.Folders)
				{
					LL = 31;
					if (xDebug)
					{
						LOG.WriteToArchiveLog((string) ("Folder Name: " + OutlookFolders.Name));
					}
					LL = 32;
					if (xDebug)
					{
						LOG.WriteToArchiveLog((string) ("Folder Name: " + FolderName));
					}
					LL = 33;
					if (xDebug)
					{
						LOG.WriteToArchiveLog((string) ("Folder  : " + Folder.Name));
					}
					LL = 34;
					
					LL = 35;
					GetFolderByPath(Folder.FolderPath);
					LL = 36;
					
					LL = 37;
					if (xDebug)
					{
						LOG.WriteToArchiveLog("Folder Items# : " + Folder.Items.Count);
					}
					LL = 38;
					if (xDebug)
					{
						LOG.WriteToArchiveLog("Folder# : " + Folder.Folders.Count);
					}
					LL = 39;
					if (xDebug)
					{
						LOG.WriteToArchiveLog("_____________");
					}
					LL = 40;
					//If FolderName .Equals(Folder.Name) Then
					LL = 41;
					ProcessAllFolderSenders(UID, FolderName, Folder, DeleteFile, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, ContainerName);
					LL = 48;
					//End If
					LL = 49;
				}
				LL = 50;
				
				LL = 51;
				
				LL = 52;
			}
			catch (Exception ex)
			{
				LL = 53;
				MessageBox.Show(ex.Message);
				LL = 54;
			}
			finally
			{
				LL = 55;
				// In any case please remember to turn on Outlook Security after your code, since now it is very easy to switch it off! :-)
				LL = 56;
				//SecurityManager.DisableOOMWarnings = False
				LL = 57;
				oApp = null;
				LL = 58;
				oNS = null;
				LL = 59;
				GC.Collect();
				LL = 60;
			}
			LL = 61;
			if (xDebug)
			{
				LOG.WriteToArchiveLog("Exiting...");
			}
			LL = 62;
		}
		
		
		public void ArchiveEmailsInFolder(string UID, string TopFolder, string ArchiveEmails, string RemoveAfterArchive, string SetAsDefaultFolder, string ArchiveAfterXDays, string RemoveAfterXDays, string RemoveXDays, string ArchiveXDays, string DB_ID, Outlook.MAPIFolder CurrOutlookSubFolder, string StoreID, string ArchiveOnlyIfRead, int RetentionYears, string RetentionCode, string tgtFolderName, SortedList slStoreId, string isPublic)
		{
			
			int StackLevel = 0;
			Dictionary<string, int> ListOfFiles = new Dictionary<string, int>();
			
			int ID = 5555;
			int PauseThreadMS = 0;
			try
			{
				PauseThreadMS = int.Parse(getUserParm("UserContent_Pause"));
			}
			catch (Exception)
			{
				PauseThreadMS = 0;
			}
			
			double LL = 459;
			string EmailIdentifier = "";
			string Subject = "";
			LL = 464;
			
			LL = 465;
			string LastEmailArchRunDate = UserParmRetrive("LastEmailArchRunDate", modGlobals.gCurrUserGuidID);
			LL = 466;
			if (LastEmailArchRunDate.Trim().Length == 0)
			{
				LL = 467;
				LastEmailArchRunDate = "1/1/1950";
				LL = 468;
			}
			LL = 469;
			frmMain.Default.SB2.Text = (string) ("Last Email Archive run date was " + LastEmailArchRunDate);
			LL = 470;
			string UseLastFilterDate = UserParmRetrive("ckUseLastProcessDateAsCutoff", modGlobals.gCurrUserGuidID);
			LL = 471;
			bool bUseCutOffDate = false;
			LL = 472;
			DateTime CutOffDate = null;
			LL = 473;
			
			LL = 474;
			if (UseLastFilterDate.ToUpper().Equals("TRUE"))
			{
				LL = 475;
				bUseCutOffDate = true;
				LL = 476;
			}
			else
			{
				LL = 477;
				bUseCutOffDate = false;
				LL = 478;
			}
			LL = 479;
			
			DateTime rightNow = DateTime.Now;
			LL = 481;
			if (RetentionYears == 0)
			{
				LL = 482;
				RetentionYears = int.Parse(val[getSystemParm("RETENTION YEARS")]);
				LL = 483;
			}
			LL = 484;
			rightNow = rightNow.AddYears(RetentionYears);
			LL = 485;
			
			LL = 486;
			string RetentionExpirationDate = rightNow.ToString();
			LL = 487;
			
			LL = 488;
			bool bMoveIt = true;
			LL = 489;
			
			LL = 490;
			var oApp = new Outlook.Application();
			LL = 491;
			Outlook.NameSpace oNS = oApp.GetNamespace("MAPI");
			LL = 492;
			
			LL = 493;
			//** Set up so that deleted items can be moved into the deleted items folder.
			LL = 494;
			Outlook.MAPIFolder oDeletedItems = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderDeletedItems);
			LL = 495;
			
			LL = 496;
			bool DeleteMsg = false;
			LL = 497;
			DateTime CurrDateTime = DateTime.Now;
			LL = 498;
			int ArchiveAge = 0;
			LL = 499;
			int RemoveAge = 0;
			LL = 500;
			int XDaysArchive = 0;
			LL = 501;
			int XDaysRemove = 0;
			LL = 502;
			string CurrMailFolderID = CurrOutlookSubFolder.EntryID;
			LL = 503;
			string EmailFQN = "";
			LL = 504;
			bool bRemoveAfterArchive = false;
			LL = 505;
			bool bMsgUnopened = false;
			LL = 506;
			string CurrMailFolderName = "";
			LL = 507;
			DateTime MinProcessDate = DateTime.Parse("01/1/1910");
			LL = 508;
			string CurrName = CurrOutlookSubFolder.Name;
			LL = 509;
			string ArchiveMsg = CurrName + ": ";
			LL = 510;
			
			LL = 511;
			//Console.WriteLine("Archiving CurrName  = " + CurrName )
			LL = 512;
			//Console.WriteLine("Should be Archiving CurrName  = " + tgtFolderName)
			LL = 513;
			
			LL = 514;
			//** WDM REMOVE THIS SECTION OF CODE AFTER ONE RUN
			LL = 515;
			string EmailFolderFQN = TopFolder + "|" + CurrName;
			LL = 516;
			
			LL = 517;
			EmailFolderFQN = UTIL.RemoveSingleQuotes(EmailFolderFQN);
			LL = 518;
			
			LL = 519;
			if (tgtFolderName.Length > 0)
			{
				LL = 520;
				EmailFolderFQN = tgtFolderName;
				LL = 521;
			}
			else
			{
				LL = 522;
				EmailFolderFQN = TopFolder + "|" + CurrName;
				LL = 523;
			}
			LL = 524;
			
			LL = 525;
			if (xDebug)
			{
				LOG.WriteToArchiveLog((string) ("ArchiveEmailsInFolder 100 EmailFolderFQN: " + EmailFolderFQN));
			}
			LL = 526;
			
			LL = 527;
			bool RunThisCode = false;
			LL = 528;
			if (RunThisCode)
			{
				LL = 529;
				
				LL = 530;
				string S = "Update EMAIL set CurrMailFolderID = \'" + CurrMailFolderID + "\' where OriginalFolder = \'" + EmailFolderFQN + "\' and CurrMailFolderID is null ";
				LL = 531;
				bool bExec = ExecuteSqlNewConn(S, false);
				LL = 532;
				if (! bExec)
				{
					LL = 533;
					LOG.WriteToArchiveLog("ERROR: 1234.99");
					LL = 534;
				}
				LL = 535;
			}
			LL = 537;
			bool bUseQuickSearch = false;
			LL = 538;
			//Dim NbrOfIds As Integer = getCountStoreIdByFolder()
			LL = 539;
			if (slStoreId.Count > 0)
			{
				bUseQuickSearch = true;
			}
			else
			{
				bUseQuickSearch = false;
			}
			LL = 550;
			if (ArchiveEmails.Length == 0)
			{
				LL = 551;
				frmNotify2.Default.Close();
				return;
//				LL = 552;
			}
			LL = 553;
			string DB_ConnectionString = "";
			LL = 554;
			
			LL = 555;
			if (ArchiveEmails.Equals("N") && ArchiveAfterXDays.Equals("N") && RemoveAfterArchive.Equals("N"))
			{
				LL = 556;
				//** Then this folder really should not be in the list
				LL = 557;
				frmNotify2.Default.Close();
				return;
//				LL = 558;
			}
			LL = 559;
			if (RemoveAfterArchive.Equals("Y"))
			{
				LL = 560;
				DeleteMsg = true;
				LL = 561;
				bRemoveAfterArchive = true;
				LL = 562;
			}
			LL = 563;
			if (Information.IsNumeric(RemoveXDays))
			{
				LL = 564;
				XDaysRemove = int.Parse(val[RemoveXDays]);
				LL = 565;
			}
			LL = 566;
			if (Information.IsNumeric(ArchiveXDays))
			{
				LL = 567;
				XDaysArchive = int.Parse(val[ArchiveXDays]);
				LL = 568;
			}
			LL = 569;
			
			LL = 570;
			try
			{
				LL = 571;
				SL.Clear();
				LL = 572;
				SL2.Clear();
				LL = 573;
				Outlook.Items oItems;
				LL = 574;
				
				LL = 575;
				if (bUseCutOffDate == false)
				{
					LL = 576;
					if (xDebug)
					{
						LOG.WriteToArchiveLog((string) ("ArchiveEmailsInFolder 200: " + EmailFolderFQN));
					}
					LL = 577;
					oItems = CurrOutlookSubFolder.Items;
					LL = 578;
				}
				else
				{
					LL = 579;
					if (xDebug)
					{
						LOG.WriteToArchiveLog((string) ("ArchiveEmailsInFolder 300: " + EmailFolderFQN));
					}
					LL = 580;
					oItems = CurrOutlookSubFolder.Items;
					LL = 581;
					
				}
				LL = 619;
				//Console.WriteLine("Total for: " & CurrOutlookSubFolder.Name & " : " & oItems.Count)
				LL = 620;
				CurrMailFolderName = CurrOutlookSubFolder.Name;
				LL = 621;
				
				LL = 622;
				frmPstLoader.Default.SB.Text = CurrMailFolderName;
				//LL = 623
				frmPstLoader.Default.SB.Refresh();
				LL = 624;
				System.Windows.Forms.Application.DoEvents();
				LL = 625;
				
				LL = 626;
				if (xDebug)
				{
					LOG.WriteToArchiveLog((string) ("ArchiveEmailsInFolder 400: " + EmailFolderFQN));
				}
				LL = 627;
				
				LL = 628;
				int TotalEmails = oItems.Count;
				LL = 629;
				frmMain.Default.PBx.Maximum = TotalEmails + 1;
				LL = 630;
				//'FrmMDIMain.TSPB1.Maximum = TotalEmails + 1
				LL = 631;
				// Loop each unread message.
				LL = 632;
				Outlook.MailItem oMsg;
				LL = 633;
				int i = 0;
				LL = 634;
				
				LL = 635;
				frmMain.Default.PBx.Value = 0;
				LL = 636;
				frmMain.Default.PBx.Maximum = oItems.Count + 2;
				LL = 638;
				if (xDebug)
				{
					LOG.WriteToArchiveLog((string) ("*** 500 Folder " + TopFolder + ":" + CurrMailFolderName + " / Curr Items = " + oItems.Count.ToString()));
				}
				LL = 639;
				LOG.WriteToArchiveLog((string) ("Processing " + TotalEmails.ToString() + " emails by " + modGlobals.gCurrLoginID));
				LL = 642;
				frmNotify2.Default.Show();
				frmNotify2.Default.lblEmailMsg.Text = "Email: ";
				for (i = 1; i <= oItems.Count; i++)
				{
					Application.DoEvents();
					frmNotify2.Default.lblEmailMsg.Text = (string) ("Email: " + i.ToString() + " of " + oItems.Count.ToString());
					frmNotify2.Default.Refresh();
					Application.DoEvents();
					
					if (PauseThreadMS > 0)
					{
						System.Threading.Thread.Sleep(25);
					}
					LL = 643;
					try
					{
						Application.DoEvents();
					}
					catch (Exception ex)
					{
						frmNotify2.Default.Close();
						if (modGlobals.gRunMode.Equals("M-END"))
						{
							frmNotify2.Default.WindowState = FormWindowState.Minimized;
						}
						Console.WriteLine(ex.Message);
					}
					LL = 644;
					if (i % 50 == 0)
					{
						ExecuteSqlNewConn("checkpoint");
						GC.Collect();
						GC.WaitForPendingFinalizers();
						Application.DoEvents();
					}
					if (modGlobals.gTerminateImmediately)
					{
						LL = 650;
						frmNotify2.Default.Close();
						return;
//						LL = 651;
					}
					LL = 652;
					
					EMAIL.setStoreID(ref StoreID);
					LL = 654;
					
					LL = 655;
					frmMain.Default.PBx.Value = i;
					LL = 656;
					frmMain.Default.PBx.Refresh();
					LL = 657;
					System.Windows.Forms.Application.DoEvents();
					LL = 658;
					Application.DoEvents();
					LL = 660;
					
					try
					{
						LL = 662;
						string EmailGuid = System.Guid.NewGuid().ToString();
						LL = 663;
						
						LL = 664;
						string OriginalFolder = TopFolder + "|" + CurrOutlookSubFolder.Name;
						LL = 665;
						string FNAME = CurrOutlookSubFolder.Name;
						LL = 666;
						
						LL = 667;
						//if xDebug then log.WriteToArchiveLog("Message#: " & i)
						LL = 668;
						if (i % 2 == 0)
						{
							LL = 669;
							frmMain.Default.SB.Text = FNAME + ":" + i.ToString();
							LL = 670;
							frmMain.Default.SB.Refresh();
							LL = 671;
						}
						LL = 672;
						
						//Test to make sure item is a mail item and not a meeting request.
						string sClassComp = "IPM.Schedule.Meeting.Request";
						LL = 672.1;
						try
						{
							sClassComp = "IPM.Schedule.Meeting.Request";
							LL = 672.2;
						}
						catch (Exception ex)
						{
							LOG.WriteToArchiveLog((string) ("ERROR IPM.Schedule.Meeting.Request: " + ex.Message));
						}
						//Console.WriteLine(oItems.Item(i).MessageClass.ToString)
						//Console.WriteLine(oItems.Item(i).MessageClass)
						try
						{
							if (oItems[i].MessageClass.Equals("REPORT.IPM.Note.NDR"))
							{
								goto LabelSkipThisEmail2;
							}
							else if (oItems[i].MessageClass.Equals("IPM.Schedule.Meeting.Notification.Forward"))
							{
								goto LabelSkipThisEmail2;
							}
							else if (oItems[i].MessageClass.Equals("IPM.Document.doc_auto_file"))
							{
								goto LabelSkipThisEmail2;
							}
							else if (oItems[i].MessageClass.Equals("IPM.Post"))
							{
								goto LabelSkipThisEmail2;
							}
							else if (oItems[i].MessageClass.Equals("IPM.Schedule.Meeting.Request"))
							{
								goto LabelSkipThisEmail2;
							}
							else if (oItems[i].MessageClass.Equals("IPM.Schedule.Meeting.Resp.Pos"))
							{
								goto LabelSkipThisEmail2;
							}
							else if (oItems[i].MessageClass.Equals("IPM.Schedule.Meeting.Resp.Neg"))
							{
								goto LabelSkipThisEmail2;
								//ElseIf oItems.Item(i).MessageClass.Equals("IPM.Note") Then
								//    GoTo LabelSkipThisEmail2
							}
							else if (oItems[i].MessageClass.Equals("IPM.Note"))
							{
								//** Good - pass it thru
							}
							else if (oItems[i].MessageClass.Equals("IPM.Note.SMIME.MultipartSigned"))
							{
								//** Good - pass it thru
							}
							else if (oItems[i].MessageClass.Equals("IPM.Schedule.Meeting.Canceled"))
							{
								//** Good - pass it thru
							}
							else if (oItems[i].MessageClass.Equals("IPM.Schedule.Meeting.Notification.Forward"))
							{
								//** Good - pass it thru
							}
							else if (oItems[i].MessageClass.Equals("IPM.Sharing"))
							{
								//** Good - pass it thru
								Console.WriteLine(oItems[i].MessageClass);
								goto LabelSkipThisEmail2;
							}
							else if (oItems[i].MessageClass.Equals("IPM.Schedule.Meeting.Resp.Tent"))
							{
								//** Good - pass it thru
								Console.WriteLine(oItems[i].MessageClass);
								goto LabelSkipThisEmail2;
							}
							else if (oItems[i].MessageClass.Equals("IPM.Post.Rss"))
							{
								//** Good - pass it thru
								LOG.WriteToArchiveLog("NOTIFICATION - RSS Feeds through Outlook are not currently processed.");
								//Dim oRSS As Outlook.PostItem = oApp.CreateItem(Outlook.OlItemType.olPostItem)
								//oMsg.MessageClass = "IPM.Post.Rss"
							}
							else
							{
								Console.WriteLine(oItems[i].MessageClass.ToString());
								Console.WriteLine(oItems[i].MessageClass);
							}
							if (oItems[i].MessageClass.Equals(sClassComp) || oItems[i].MessageClass.Equals("IPM.Schedule.Meeting.Canceled"))
							{
								LL = 674;
								string oEntryID = (string) (oItems[i].EntryID);
								LL = 675;
								//Dim oStoreID As String = oItems.Item(i).StoreID
								DateTime MsgDate = oItems[i].senton;
								LL = 676;
								try
								{
									TimeSpan passed_time;
									LL = 677;
									passed_time = CurrDateTime.Subtract(MsgDate);
									LL = 678;
									int EmailDays = (int) passed_time.TotalDays;
									LL = 679;
									if (RemoveAfterXDays.Equals("Y"))
									{
										LL = 680;
										if (EmailDays >= XDaysRemove)
										{
											LL = 680;
											//oItems.Item(i).move(oEcmHistFolder)
											//oItems.Item(i).delete()
											
											LL = 681;
										}
										
										LL = 682;
										LOG.WriteToArchiveLog("Notification 01 - Item #" + i.ToString() + " in folder " + OriginalFolder + ", is a meeting request and past MOVE date - NOT PROCESSED.");
									}
									else
									{
										
										LL = 683;
										LOG.WriteToArchiveLog("Notification 02 - Item #" + i.ToString() + " in folder " + OriginalFolder + ", is a meeting request and NOT PROCESSED.");
									}
									
									LL = 684;
								}
								catch (Exception ex)
								{
									LOG.WriteToArchiveLog("Notification 03 - Item #" + i.ToString() + " in folder " + OriginalFolder + ", is a meeting request and Failed to MOVE to History.");
									Console.WriteLine(ex.Message);
								}
								
								goto LabelSkipThisEmail2;
							}
						}
						catch (Exception)
						{
							LOG.WriteToArchiveLog("ERROR ArchiveEmailsInFolder 100 - Line #" + LL.ToString() + ".");
							goto LabelSkipThisEmail2;
						}
						
						
						try
						{
							LL = 674;
							oMsg = oItems[i];
							LL = 675;
							
						}
						catch (Exception)
						{
							LL = 676;
							LOG.WriteToArchiveLog("ERROR - Item #" + i.ToString() + " in folder " + OriginalFolder + ", failed to open message of type: " + oItems[i].MessageClass.ToString() + ".");
							LL = 677;
							goto LabelSkipThisEmail2;
							LL = 678;
						}
						
						LL = 679;
						
						EmailIdentifier = UTIL.genEmailIdentifier(oMsg.CreationTime, oMsg.SenderEmailAddress, Subject);
						
						bool bMailAlreadyUploaded = false;
						
						if (bUseQuickSearch == true)
						{
							int IX = slStoreId.IndexOfKey(EmailIdentifier);
							if (IX < 0)
							{
								//** The email has NOT been archived, move on...
								//bMailAlreadyUploaded = DBLocal.addOutlook(EmailIdentifier)
								//If bMailAlreadyUploaded Then
								//    '** The key already exists, move on
								//    GoTo LabelSkipThisEmail
								//Else
								//    slStoreId.Add(EmailIdentifier, i)
								//    bMailAlreadyUploaded = False
								//End If
								frmMain.Default.SB.Text = (string) ("Insert# " + i.ToString());
								frmMain.Default.SB.Refresh();
							}
							else
							{
								frmMain.Default.EmailsSkipped++;
								goto LabelSkipThisEmail;
							}
						}
						else
						{
							bMailAlreadyUploaded = DBLocal.OutlookExists(EmailIdentifier);
							
							if (bMailAlreadyUploaded)
							{
								DBLocal.setOutlookKeyFound(EmailIdentifier);
								goto LabelSkipThisEmail;
							}
						}
						
						
						
						
						LL = 695;
						DateTime SentOn = oMsg.SentOn;
						LL = 696;
						DateTime ReceivedTime = oMsg.ReceivedTime;
						LL = 697;
						DateTime CreationTime = oMsg.CreationTime;
						LL = 699;
						if (SentOn == null)
						{
							LL = 700;
							if (CreationTime != null)
							{
								LL = 701;
								SentOn = CreationTime;
								LL = 702;
							}
							else if (ReceivedTime != null)
							{
								LL = 703;
								SentOn = CreationTime;
								LL = 704;
							}
							else
							{
								LL = 705;
								SentOn = DateTime.Now;
								LL = 706;
							}
							LL = 707;
						}
						LL = 708;
						if (ReceivedTime == null)
						{
							LL = 711;
							if (SentOn != null)
							{
								LL = 712;
								ReceivedTime = SentOn;
								LL = 713;
							}
							else if (CreationTime != null)
							{
								LL = 714;
								ReceivedTime = CreationTime;
								LL = 715;
							}
							else
							{
								LL = 716;
								ReceivedTime = DateTime.Now;
								LL = 717;
							}
							LL = 718;
						}
						LL = 719;
						
						LL = 720;
						if (CreationTime == null)
						{
							LL = 721;
							if (SentOn != null)
							{
								LL = 722;
								CreationTime = SentOn;
								LL = 723;
							}
							else if (ReceivedTime != null)
							{
								LL = 724;
								CreationTime = ReceivedTime;
								LL = 725;
							}
							else
							{
								LL = 726;
								CreationTime = DateTime.Now;
								LL = 727;
							}
							LL = 728;
						}
						LL = 729;
						if (CreationTime < DateTime.Parse("1/1/1960"))
						{
							LL = 730;
							if (SentOn != null)
							{
								LL = 731;
								CreationTime = SentOn;
								LL = 732;
							}
							else if (CreationTime != null)
							{
								LL = 733;
								CreationTime = ReceivedTime;
								LL = 734;
							}
							else
							{
								LL = 735;
								CreationTime = DateTime.Now;
								LL = 736;
							}
							LL = 737;
						}
						
						LL = 740;
						
						if (bUseCutOffDate)
						{
							LL = 741;
							bool bbb = modGlobals.compareEmailProcessDate(CurrMailFolderName, CreationTime);
							LL = 742;
							if (bbb)
							{
								LL = 743;
								frmMain.Default.EmailsSkipped++;
								LOG.WriteToArchiveLog(ArchiveMsg + " This email past the cutoff date, skipped.");
								bool BBX = ExchangeEmailExists(EmailIdentifier);
								TimeSpan passed_time;
								passed_time = CurrDateTime.Subtract(SentOn);
								if (BBX)
								{
									int EmailDays = (int) passed_time.TotalDays;
									if (RemoveAfterXDays.Equals("Y"))
									{
										if (EmailDays >= XDaysRemove)
										{
											MoveToHistoryFolder(oMsg);
										}
									}
								}
								goto LabelSkipThisEmail;
								LL = 748;
								BBX = System.Convert.ToBoolean(null);
								passed_time = null;
							}
							LL = 749;
						}
						
						modGlobals.setLastEmailDate(CurrMailFolderName, CreationTime);
						
						bool bIdExists = ExchangeEmailExists(EmailIdentifier);
						
						if (bIdExists)
						{
							//This email has already been processed, skip it.
							
							goto LabelSkipThisEmail;
						}
						
						if (bIdExists)
						{
							//** This sucker already exists, skip it.
							LL = 757;
							if (bRemoveAfterArchive == true)
							{
								LL = 758;
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 900: " + EmailFolderFQN));
								}
								LL = 759;
								if (xDebug)
								{
									LOG.WriteToArchiveLog(CurrOutlookSubFolder.Name + ": Deleted DUPLICATE email... ");
								}
								LL = 760;
								EM2D.setEmailguid(ref EmailGuid);
								LL = 761;
								EM2D.setStoreid(ref StoreID);
								LL = 762;
								EM2D.setUserid(ref modGlobals.gCurrUserGuidID);
								LL = 763;
								EM2D.setMessageid(oMsg.EntryID);
								LL = 764;
								if (bMsgUnopened == false && ArchiveOnlyIfRead == "Y")
								{
									LL = 765;
									EM2D.Insert();
									LL = 766;
									//log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #100")
									LL = 767;
								}
								else if (ArchiveOnlyIfRead == "N")
								{
									LL = 768;
									//log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #101")
									LL = 769;
									EM2D.Insert();
									LL = 770;
								}
								else
								{
									LL = 771;
									if (xDebug)
									{
										LOG.WriteToArchiveLog("No match ... ");
									}
									LL = 772;
								}
								LL = 773;
								
								LL = 774;
							}
							LL = 775;
							//GoTo LabelSkipThisEmail2
							LL = 776;
							frmMain.Default.FilesBackedUp++;
							LL = 777;
							goto LabelSkipThisEmail;
							LL = 778;
						}
						LL = 779;
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1000: " + EmailFolderFQN));
						}
						LL = 780;
						string SourceTypeCode = "";
						LL = 781;
						try
						{
							LL = 782;
							Subject = oMsg.Subject;
							LL = 783;
							//If InStr(Subject, "Accepted: ", CompareMethod.Text) > 0 Then
							//    LL = 784
							//    Console.WriteLine("Here on a calendar entry.")
							//    LL = 785
							//End If
							//LL = 786
						}
						catch (Exception ex)
						{
							LL = 787;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX Subject : " + ex.Message));
							LL = 788;
						}
						LL = 789;
						
						LL = 790;
						try
						{
							LL = 791;
							SourceTypeCode = "MSG";
							LL = 792;
						}
						catch (Exception ex)
						{
							LL = 793;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX SourceTypeCode : " + ex.Message));
							LL = 794;
						}
						LL = 795;
						
						bool bAutoForwarded = false;
						LL = 797;
						try
						{
							LL = 798;
							bAutoForwarded = oMsg.AutoForwarded;
							LL = 799;
						}
						catch (Exception ex)
						{
							LL = 800;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX bAutoForwarded As Boolean: " + ex.Message));
							LL = 801;
						}
						LL = 802;
						
						LL = 803;
						string BCC = "";
						LL = 804;
						try
						{
							LL = 805;
							BCC = oMsg.BCC;
							LL = 806;
						}
						catch (Exception ex)
						{
							LL = 807;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX BCC : " + ex.Message));
							LL = 808;
						}
						LL = 809;
						LL = 810;
						string BillingInformation = "";
						LL = 811;
						try
						{
							LL = 812;
							BillingInformation = oMsg.BillingInformation;
							LL = 813;
						}
						catch (Exception ex)
						{
							LL = 814;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX BillingInformation : " + ex.Message));
							LL = 815;
						}
						LL = 816;
						
						LL = 817;
						string EmailBody = "";
						LL = 818;
						try
						{
							LL = 819;
							EmailBody = oMsg.Body;
							LL = 820;
						}
						catch (Exception ex)
						{
							LL = 821;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX EmailBody: " + ex.Message));
							LL = 822;
						}
						LL = 823;
						if (EmailBody == null)
						{
							EmailBody = "-";
						}
						//*************** DO NOT SAVE THE WHOLE BODY, JUST THE FIRST 250 CHARACTERS *****************
						//Dim iBodyLen As Integer = CInt(My.Settings("EmailBodyLength"))
						//iBodyLen = 100000
						//EmailBody = EmailBody.Substring(0, iBodyLen)
						//*******************************************************************************************
						
						LL = 824;
						string BodyFormat = "";
						LL = 825;
						try
						{
							LL = 826;
							BodyFormat = oMsg.BodyFormat.ToString();
							LL = 827;
						}
						catch (Exception ex)
						{
							LL = 828;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX BodyFormat: " + ex.Message));
							LL = 829;
						}
						LL = 830;
						
						LL = 831;
						string Categories = "";
						LL = 832;
						try
						{
							LL = 833;
							Categories = oMsg.Categories;
							LL = 834;
						}
						catch (Exception ex)
						{
							LL = 835;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX Categories: " + ex.Message));
							LL = 836;
						}
						LL = 839;
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1000a: " + EmailFolderFQN));
						}
						LL = 840;
						
						LL = 841;
						string Companies = "";
						LL = 842;
						try
						{
							LL = 843;
							Companies = oMsg.Companies;
							LL = 844;
						}
						catch (Exception ex)
						{
							LL = 845;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX Companies : " + ex.Message));
							LL = 846;
						}
						LL = 847;
						
						LL = 848;
						
						LL = 849;
						string ConversationIndex = "";
						LL = 850;
						try
						{
							LL = 851;
							ConversationIndex = oMsg.ConversationIndex;
							LL = 852;
						}
						catch (Exception ex)
						{
							LL = 853;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX ConversationIndex : " + ex.Message));
							LL = 854;
						}
						LL = 855;
						
						LL = 856;
						string ConversationTopic = "";
						LL = 857;
						try
						{
							LL = 858;
							ConversationTopic = oMsg.ConversationTopic;
							LL = 859;
						}
						catch (Exception ex)
						{
							LL = 860;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX ConversationTopic : " + ex.Message));
							LL = 861;
						}
						LL = 862;
						
						LL = 863;
						Application.DoEvents();
						LL = 864;
						DateTime DeferredDeliveryTime = null;
						LL = 865;
						try
						{
							LL = 866;
							DeferredDeliveryTime = oMsg.DeferredDeliveryTime;
							LL = 867;
						}
						catch (Exception ex)
						{
							LL = 868;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX DeferredDeliveryTime As Date: " + ex.Message));
							LL = 869;
						}
						LL = 870;
						
						LL = 871;
						string DownloadState = "";
						LL = 872;
						try
						{
							LL = 873;
							DownloadState = oMsg.DownloadState.ToString();
							LL = 874;
						}
						catch (Exception ex)
						{
							LL = 875;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX DownloadState : " + ex.Message));
							LL = 876;
						}
						LL = 877;
						
						LL = 878;
						Application.DoEvents();
						LL = 879;
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1000b: " + EmailFolderFQN));
						}
						LL = 880;
						
						LL = 881;
						DateTime ExpiryTime = null;
						LL = 882;
						try
						{
							LL = 883;
							ExpiryTime = oMsg.ExpiryTime;
							LL = 884;
						}
						catch (Exception ex)
						{
							LL = 885;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX ExpiryTime As Date: " + ex.Message));
							LL = 886;
						}
						LL = 887;
						
						LL = 888;
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1000b1: " + EmailFolderFQN));
						}
						LL = 889;
						
						LL = 890;
						string HTMLBody = "";
						LL = 891;
						try
						{
							LL = 892;
							HTMLBody = oMsg.HTMLBody;
							LL = 893;
						}
						catch (Exception ex)
						{
							LL = 894;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX HTMLBody : " + ex.Message));
							LL = 895;
						}
						LL = 896;
						
						LL = 897;
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1000b2: " + EmailFolderFQN));
						}
						LL = 898;
						
						LL = 899;
						string Importance = "";
						LL = 900;
						try
						{
							LL = 901;
							Importance = oMsg.Importance;
							LL = 902;
						}
						catch (Exception ex)
						{
							LL = 903;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX Importance : " + ex.Message));
							LL = 904;
						}
						LL = 905;
						
						LL = 906;
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1000b3: " + EmailFolderFQN));
						}
						LL = 907;
						
						LL = 908;
						//** ERROR HERE
						LL = 909;
						bool IsMarkedAsTask = false;
						LL = 910;
						try
						{
							LL = 911;
							IsMarkedAsTask = oMsg.IsMarkedAsTask;
							LL = 912;
						}
						catch (Exception ex)
						{
							LL = 913;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX IsMarkedAsTask As Boolean: " + ex.Message));
							LL = 914;
						}
						LL = 915;
						
						LL = 916;
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1000b4: " + EmailFolderFQN));
						}
						LL = 917;
						
						LL = 918;
						DateTime LastModificationTime = null;
						LL = 919;
						try
						{
							LL = 920;
							LastModificationTime = oMsg.LastModificationTime;
							LL = 921;
						}
						catch (Exception ex)
						{
							LL = 922;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX LastModificationTime As Date: " + ex.Message));
							LL = 923;
						}
						LL = 924;
						
						LL = 925;
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1000b5: " + EmailFolderFQN));
						}
						LL = 926;
						
						LL = 927;
						string MessageClass = "";
						LL = 928;
						try
						{
							LL = 929;
							MessageClass = oMsg.MessageClass;
							LL = 930;
						}
						catch (Exception ex)
						{
							LL = 931;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX MessageClass : " + ex.Message));
							LL = 932;
						}
						LL = 933;
						
						LL = 934;
						
						LL = 935;
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1000c: " + EmailFolderFQN));
						}
						LL = 936;
						
						LL = 937;
						string Mileage = "";
						LL = 938;
						try
						{
							LL = 939;
							Mileage = oMsg.Mileage;
							LL = 940;
						}
						catch (Exception ex)
						{
							LL = 941;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX Mileage : " + ex.Message));
							LL = 942;
						}
						LL = 943;
						
						LL = 944;
						bool OriginatorDeliveryReportRequested = System.Convert.ToBoolean(null);
						LL = 945;
						try
						{
							LL = 946;
							OriginatorDeliveryReportRequested = oMsg.OriginatorDeliveryReportRequested;
							LL = 947;
						}
						catch (Exception ex)
						{
							LL = 948;
							LOG.WriteToArchiveLog((string) ("ERROR OriginatorDeliveryReportRequested " + ex.Message));
							LL = 949;
						}
						LL = 950;
						
						LL = 951;
						string OutlookInternalVersion = "";
						LL = 952;
						try
						{
							LL = 953;
							OutlookInternalVersion = oMsg.OutlookInternalVersion.ToString();
							LL = 954;
						}
						catch (Exception ex)
						{
							LL = 955;
							LOG.WriteToArchiveLog((string) ("ERROR OutlookInternalVersion  " + ex.Message));
							LL = 956;
						}
						LL = 957;
						
						LL = 958;
						bool ReadReceiptRequested = System.Convert.ToBoolean(null);
						LL = 959;
						try
						{
							LL = 960;
							ReadReceiptRequested = oMsg.ReadReceiptRequested;
							LL = 961;
						}
						catch (Exception ex)
						{
							LL = 962;
							LOG.WriteToArchiveLog((string) ("ERROR ReadReceiptRequested  " + ex.Message));
							LL = 963;
						}
						LL = 964;
						
						LL = 965;
						string ReceivedByEntryID = "";
						LL = 966;
						try
						{
							LL = 967;
							ReceivedByEntryID = oMsg.ReceivedByEntryID;
							LL = 968;
						}
						catch (Exception ex)
						{
							LL = 969;
							LOG.WriteToArchiveLog((string) ("ERROR ReceivedByEntryID   " + ex.Message));
							LL = 970;
						}
						LL = 971;
						
						LL = 972;
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("ERROR: XXX ** ArchiveEmailsInFolder 1000d: " + EmailFolderFQN));
						}
						LL = 973;
						
						LL = 974;
						string ReceivedByName = "";
						LL = 975;
						try
						{
							LL = 976;
							ReceivedByName = oMsg.ReceivedByName;
							LL = 977;
						}
						catch (Exception ex)
						{
							LL = 978;
							LOG.WriteToArchiveLog((string) ("ERROR ReceivedByName    " + ex.Message));
							LL = 979;
						}
						LL = 980;
						
						string SenderEmailAddress = "";
						LL = 983;
						try
						{
							LL = 984;
							SenderEmailAddress = oMsg.SenderEmailAddress;
							LL = 985;
						}
						catch (Exception ex)
						{
							LL = 986;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX SenderEmailAddress : " + ex.Message));
							LL = 987;
						}
						LL = 988;
						
						if (ReceivedByName == null)
						{
							LL = 992;
							ReceivedByName = "Unknown";
							LL = 993;
						}
						else if (ReceivedByName.Length == 0)
						{
							LL = 994;
							ReceivedByName = "Unknown";
							LL = 995;
						}
						LL = 996;
						
						LL = 997;
						string ReceivedOnBehalfOfName = "";
						LL = 998;
						try
						{
							LL = 999;
							ReceivedOnBehalfOfName = oMsg.ReceivedOnBehalfOfName;
							LL = 1000;
						}
						catch (Exception ex)
						{
							LL = 1001;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX ReceivedOnBehalfOfName : " + ex.Message));
							LL = 1002;
						}
						LL = 1003;
						
						LL = 1004;
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1000e: " + EmailFolderFQN));
						}
						LL = 1005;
						
						LL = 1006;
						object Recipients = null;
						LL = 1007;
						try
						{
							LL = 1008;
							Recipients = oMsg.Recipients;
							LL = 1009;
						}
						catch (Exception ex)
						{
							LL = 1010;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX Recipients As Object: " + ex.Message));
							LL = 1011;
						}
						LL = 1012;
						
						LL = 1013;
						int KK = 0;
						LL = 1014;
						
						LL = 1015;
						string AllRecipients = "";
						LL = 1016;
						try
						{
							LL = 1017;
							for (KK = 1; KK <= oMsg.Recipients.Count; KK++)
							{
								Application.DoEvents();
								LL = 1018;
								//if xDebug then log.WriteToArchiveLog("Recipients: " + oMsg.Recipients.Item(KK).Address)
								LL = 1019;
								if (xDebug)
								{
									if (xDebug)
									{
										LOG.WriteToArchiveLog((string) ("Recipients: " + oMsg.Recipients[KK].Name + " : " + oMsg.Recipients.Count));
									}
								}
								LL = 1020;
								AllRecipients = AllRecipients + "; " + oMsg.Recipients[KK].Address;
								LL = 1021;
								AddRecipToList(EmailGuid, oMsg.Recipients[KK].Address, "RECIP");
								LL = 1022;
							}
							LL = 1023;
						}
						catch (Exception ex)
						{
							LL = 1024;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX AllRecipients  : " + ex.Message));
							LL = 1025;
						}
						
						LL = 1029;
						if (AllRecipients.Length > 0)
						{
							LL = 1030;
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1000g: " + EmailFolderFQN));
							}
							LL = 1031;
							string ch = AllRecipients.Substring(0, 1);
							LL = 1032;
							if (ch.Equals(";"))
							{
								LL = 1033;
								StringType.MidStmtStr(ref AllRecipients, 1, 1, " ");
								LL = 1034;
								AllRecipients = AllRecipients.Trim;
								LL = 1035;
							}
							LL = 1036;
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1000h: " + EmailFolderFQN));
							}
							LL = 1037;
						}
						LL = 1038;
						
						LL = 1039;
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1001: " + EmailFolderFQN));
						}
						LL = 1040;
						
						LL = 1041;
						bool ReminderSet = System.Convert.ToBoolean(null);
						LL = 1042;
						try
						{
							LL = 1043;
							ReminderSet = oMsg.ReminderSet;
							LL = 1044;
						}
						catch (Exception ex)
						{
							LL = 1045;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX ReminderSet As Boolean: " + ex.Message));
							LL = 1046;
						}
						LL = 1047;
						
						LL = 1048;
						DateTime ReminderTime = null;
						LL = 1049;
						try
						{
							LL = 1050;
							ReminderTime = oMsg.ReminderTime;
							LL = 1051;
						}
						catch (Exception ex)
						{
							LL = 1052;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX ReminderTime As Date: " + ex.Message));
							LL = 1053;
						}
						LL = 1054;
						
						LL = 1055;
						object ReplyRecipientNames = null;
						LL = 1056;
						try
						{
							LL = 1057;
							ReplyRecipientNames = oMsg.ReplyRecipientNames;
							LL = 1058;
						}
						catch (Exception ex)
						{
							LL = 1059;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX ReplyRecipientNames As Object: " + ex.Message));
							LL = 1060;
						}
						LL = 1061;
						
						LL = 1062;
						if (ReplyRecipientNames != null)
						{
							LL = 1063;
							//For Each R In ReplyRecipientNames
							LL = 1064;
							if (xDebug)
							{
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("ReplyRecipientNames: " + ReplyRecipientNames));
								}
							}
							LL = 1065;
							//Next
							LL = 1066;
						}
						LL = 1067;
						string SenderEmailType = "";
						LL = 1068;
						try
						{
							LL = 1069;
							SenderEmailType = oMsg.SenderEmailType;
							LL = 1070;
						}
						catch (Exception ex)
						{
							LL = 1071;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX SenderEmailType : " + ex.Message));
							LL = 1072;
						}
						LL = 1073;
						
						LL = 1074;
						//Dim SendUsingAccount  = oMsg.SendUsingAccount
						LL = 1075;
						string Sensitivity = "";
						LL = 1076;
						try
						{
							LL = 1077;
							Sensitivity = oMsg.Sensitivity;
							LL = 1078;
						}
						catch (Exception ex)
						{
							LL = 1079;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX Sensitivity : " + ex.Message));
							LL = 1080;
						}
						LL = 1081;
						
						LL = 1082;
						string SentOnBehalfOfName = "";
						LL = 1083;
						try
						{
							LL = 1084;
							SentOnBehalfOfName = oMsg.SentOnBehalfOfName;
							LL = 1085;
						}
						catch (Exception ex)
						{
							LL = 1086;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX SentOnBehalfOfName : " + ex.Message));
							LL = 1087;
						}
						LL = 1088;
						
						LL = 1089;
						int EmailSize = 0;
						LL = 1090;
						try
						{
							LL = 1091;
							//String.Format("{1:F}", price
							EmailSize = oMsg.Size / 1000;
							//Dim S1 As String = String.Format("{1:F}", EmailSize)
							frmNotify2.Default.lblEmailMsg.Text += (string) (" : " + EmailSize.ToString() + "/Kb - " + oMsg.Attachments.Count.ToString());
							frmNotify2.Default.Refresh();
							LL = 1092;
						}
						catch (Exception ex)
						{
							LL = 1093;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX EmailSize As Integer: " + ex.Message));
							LL = 1094;
						}
						ArchiveMsg = ArchiveMsg + " : " + Subject;
						LL = 1098;
						
						LL = 1099;
						DateTime TaskCompletedDate = null;
						LL = 1100;
						try
						{
							LL = 1101;
							TaskCompletedDate = oMsg.TaskCompletedDate;
							LL = 1102;
						}
						catch (Exception ex)
						{
							LL = 1103;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX TaskCompletedDate As Date: " + ex.Message));
							LL = 1104;
						}
						LL = 1105;
						
						LL = 1106;
						DateTime TaskDueDate = null;
						LL = 1107;
						try
						{
							LL = 1108;
							TaskDueDate = oMsg.TaskDueDate;
							LL = 1109;
						}
						catch (Exception ex)
						{
							LL = 1110;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX TaskDueDate As Date: " + ex.Message));
							LL = 1111;
						}
						LL = 1112;
						
						LL = 1113;
						string TaskSubject = "";
						LL = 1114;
						try
						{
							LL = 1115;
							TaskSubject = oMsg.TaskSubject;
							LL = 1116;
						}
						catch (Exception ex)
						{
							LL = 1117;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX TaskSubject : " + ex.Message));
							LL = 1118;
						}
						LL = 1119;
						
						LL = 1120;
						string SentTo = "";
						LL = 1121;
						try
						{
							LL = 1122;
							SentTo = oMsg.To;
							LL = 1123;
						}
						catch (Exception ex)
						{
							LL = 1124;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX SentTo : " + ex.Message));
							LL = 1125;
						}
						LL = 1126;
						if (SentTo == null)
						{
							LL = 1128;
							SentTo = "UKN";
							LL = 1129;
						}
						LL = 1130;
						if (SentTo.Trim.Length == 0)
						{
							LL = 1131;
							SentTo = "UKN";
							LL = 1132;
						}
						LL = 1133;
						
						LL = 1134;
						string VotingOptions = "";
						LL = 1135;
						try
						{
							LL = 1136;
							VotingOptions = oMsg.VotingOptions;
							LL = 1137;
						}
						catch (Exception ex)
						{
							LL = 1138;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX VotingOptions : " + ex.Message));
							LL = 1139;
						}
						LL = 1140;
						
						LL = 1141;
						string VotingResponse = "";
						LL = 1142;
						try
						{
							LL = 1143;
							VotingResponse = oMsg.VotingResponse;
							LL = 1144;
						}
						catch (Exception ex)
						{
							LL = 1145;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX VotingResponse : " + ex.Message));
							LL = 1146;
						}
						LL = 1147;
						
						LL = 1148;
						object UserProperties = null;
						LL = 1149;
						try
						{
							LL = 1150;
							UserProperties = oMsg.UserProperties;
							LL = 1151;
						}
						catch (Exception ex)
						{
							LL = 1152;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX UserProperties As Object: " + ex.Message));
							LL = 1153;
						}
						LL = 1154;
						
						LL = 1155;
						string Accounts = "";
						LL = 1156;
						try
						{
							LL = 1157;
							Accounts = "None Supplied";
							LL = 1158;
						}
						catch (Exception ex)
						{
							LL = 1159;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX Accounts : " + ex.Message));
							LL = 1160;
						}
						LL = 1161;
						
						LL = 1162;
						string NewTime = "";
						LL = 1163;
						try
						{
							LL = 1164;
							NewTime = ReceivedTime.ToString().Replace("//", ".");
							LL = 1165;
							NewTime = ReceivedTime.ToString().Replace("/:", ".");
							LL = 1166;
							NewTime = ReceivedTime.ToString().Replace(" ", "_");
							LL = 1167;
						}
						catch (Exception ex)
						{
							LL = 1168;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX NewTime : " + ex.Message));
							LL = 1169;
						}
						LL = 1170;
						
						LL = 1171;
						string NewSubject = "";
						LL = 1172;
						try
						{
							LL = 1173;
							NewSubject = Subject.Substring(0, 200);
							LL = 1174;
						}
						catch (Exception ex)
						{
							LL = 1175;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX NewSubject : " + ex.Message));
							LL = 1176;
						}
						LL = 1177;
						
						LL = 1178;
						NewSubject = NewSubject.Replace(" ", "_");
						LL = 1179;
						ConvertName(ref NewSubject);
						LL = 1180;
						ConvertName(ref NewTime);
						LL = 1181;
						
						LL = 1182;
						bMsgUnopened = oMsg.UnRead;
						LL = 1183;
						
						LL = 1184;
						if (bMsgUnopened == true && ArchiveOnlyIfRead == "Y")
						{
							LL = 1185;
							//** The email has not been read and we have been instructed to skip it if not read...
							LL = 1186;
							DeleteMsg = false;
							LL = 1187;
							//GoTo LabelSkipThisEmail2
							LL = 1188;
						}
						LL = 1189;
						
						LL = 1190;
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1003: " + EmailFolderFQN));
						}
						LL = 1191;
						
						LL = 1192;
						bool bExcluded = System.Convert.ToBoolean(null);
						LL = 1193;
						try
						{
							LL = 1194;
							bExcluded = modGlobals.isExcludedEmail(SenderEmailAddress);
							LL = 1195;
						}
						catch (Exception ex)
						{
							LL = 1196;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX bExcluded: " + ex.Message));
							LL = 1197;
						}
						LL = 1198;
						if (bExcluded)
						{
							LL = 1199;
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("ERROR: XXX ** ArchiveEmailsInFolder 1004: " + EmailFolderFQN));
							}
							LL = 1200;
							goto LabelSkipThisEmail2;
							LL = 1201;
						}
						LL = 1202;
						try
						{
							LL = 1203;
							if (SenderEmailAddress.Length == 0)
							{
								LL = 1204;
								SenderEmailAddress = "Unknown";
								LL = 1205;
							}
						}
						catch (Exception)
						{
							SenderEmailAddress = "Unknown";
						}
						
						LL = 1207;
						string SenderName = "";
						LL = 1208;
						try
						{
							LL = 1209;
							SenderName = oMsg.SenderName;
							LL = 1210;
						}
						catch (Exception ex)
						{
							LL = 1211;
							LOG.WriteToArchiveLog((string) ("ERROR: XXX SenderName : " + ex.Message));
							LL = 1212;
						}
						LL = 1213;
						if (SenderName.Length == 0 || SenderName == null)
						{
							LL = 1215;
							SenderName = "Unknown";
							LL = 1216;
						}
						
						LL = 1219;
						
						//Dim bExists As Integer = EMAIL.cnt_FULL_UI_EMAIL(gCurrUserGuidID, ReceivedByName, ReceivedTime, SenderEmailAddress, SenderName, SentOn)
						
						LL = 1220;
						if (bMailAlreadyUploaded == true)
						{
							LL = 1221;
							if (xDebug)
							{
								LOG.WriteToArchiveLog("** ArchiveEmailsInFolder Curr Items : " + CurrMailFolderName + " : EXISTS.");
							}
							LL = 1222;
							if (RemoveAfterArchive.Equals("Y"))
							{
								LL = 1223;
								//** Remove this item from the existing folder.
								LL = 1224;
								DeleteMsg = true;
								LL = 1225;
								if (bMsgUnopened == false && ArchiveOnlyIfRead == "Y")
								{
									LL = 1226;
									DeleteMsg = true;
									LL = 1227;
								}
								else if (ArchiveOnlyIfRead == "N")
								{
									LL = 1228;
									DeleteMsg = true;
									LL = 1229;
								}
								else
								{
									LL = 1230;
									if (xDebug)
									{
										LOG.WriteToArchiveLog("No match ... ");
									}
									LL = 1231;
								}
								LL = 1232;
							}
							LL = 1233;
							frmMain.Default.FilesBackedUp++;
							LL = 1234;
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("ArchiveEmailsInFolder : found email already exists in " + tgtFolderName));
							}
							LL = 1235;
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1005: " + EmailFolderFQN));
							}
							LL = 1236;
							goto LabelSkipThisEmail;
							LL = 1237;
						}
						else
						{
							LL = 1238;
							
							LL = 1239;
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1006: " + EmailFolderFQN));
							}
							LL = 1240;
							
							LL = 1241;
							if (xDebug)
							{
								LOG.WriteToArchiveLog("** ArchiveEmailsInFolder Curr Items : " + CurrMailFolderName + " : DOES NOT EXIST.");
							}
							LL = 1242;
							//Dim IX As Integer = EMAIL.cnt_EntryID(StoreID , EntryID )
							LL = 1243;
							if (RemoveAfterArchive.Equals("Y"))
							{
								LL = 1244;
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1007: " + EmailFolderFQN));
								}
								LL = 1245;
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("ArchiveEmailsInFolder : found email needs to be removed - " + tgtFolderName));
								}
								LL = 1246;
								//** Remove this item from the existing folder.
								LL = 1247;
								DeleteMsg = false;
								LL = 1248;
								if (bMsgUnopened == false && ArchiveOnlyIfRead == "Y")
								{
									LL = 1249;
									//EM2D.Insert()
									LL = 1250;
									DeleteMsg = true;
									LL = 1251;
								}
								else if (ArchiveOnlyIfRead == "N")
								{
									LL = 1252;
									//EM2D.Insert()
									LL = 1253;
									DeleteMsg = true;
									LL = 1254;
								}
								else
								{
									LL = 1255;
									if (xDebug)
									{
										LOG.WriteToArchiveLog("No match ... ");
									}
									LL = 1256;
								}
								LL = 1257;
							}
							LL = 1258;
							
							LL = 1259;
						}
						LL = 1260;
						
						LL = 1261;
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1008: " + EmailFolderFQN));
						}
						LL = 1262;
						
						LL = 1263;
						Application.DoEvents();
						LL = 1264;
						
						LL = 1265;
						string CC = oMsg.CC;
						LL = 1266;
						Application.DoEvents();
						LL = 1267;
						//EMAIL.setStoreID(StoreID )
						LL = 1269;
						EMAIL.setEntryid(oMsg.EntryID);
						LL = 1270;
						EMAIL.setEmailguid(ref EmailGuid);
						LL = 1271;
						
						LL = 1272;
						if (BCC != null)
						{
							LL = 1273;
							AllRecipients = AllRecipients + "; " + BCC;
							LL = 1274;
						}
						LL = 1275;
						if (CC != null)
						{
							LL = 1276;
							AllRecipients = AllRecipients + "; " + CC;
							LL = 1277;
						}
						
						EMAIL.setAllrecipients(ref AllRecipients);
						LL = 1279;
						EMAIL.setBcc(ref BCC);
						LL = 1280;
						EMAIL.setBillinginformation(ref BillingInformation);
						LL = 1281;
						EMAIL.setBody(UTIL.RemoveSingleQuotesV1(EmailBody));
						LL = 1282;
						EMAIL.setCc(ref CC);
						LL = 1283;
						EMAIL.setCompanies(ref Companies);
						LL = 1284;
						EMAIL.setCreationtime(ref CreationTime);
						LL = 1285;
						EMAIL.setCurrentuser(ref modGlobals.gCurrUserGuidID);
						LL = 1286;
						EMAIL.setDeferreddeliverytime(ref DeferredDeliveryTime);
						LL = 1287;
						EMAIL.setDeferreddeliverytime(ref DeferredDeliveryTime);
						LL = 1288;
						EMAIL.setEmailguid(ref EmailGuid);
						LL = 1289;
						//EMAIL.setEmailimage()
						LL = 1290;
						Application.DoEvents();
						LL = 1291;
						EMAIL.setExpirytime(ref ExpiryTime);
						LL = 1292;
						EMAIL.setLastmodificationtime(ref LastModificationTime);
						LL = 1293;
						EMAIL.setMsgsize(EmailSize.ToString());
						LL = 1294;
						EMAIL.setReadreceiptrequested(OriginatorDeliveryReportRequested.ToString());
						LL = 1295;
						EMAIL.setReceivedbyname(ref ReceivedByName);
						LL = 1296;
						EMAIL.setReceivedtime(ref ReceivedTime);
						LL = 1297;
						
						SenderEmailAddress = SenderEmailAddress.Substring(0, 79);
						EMAIL.setSenderemailaddress(ref SenderEmailAddress);
						LL = 1298;
						
						SenderName = SenderName.Substring(0, 79);
						EMAIL.setSendername(ref SenderName);
						LL = 1299;
						
						EMAIL.setSensitivity(ref Sensitivity);
						LL = 1300;
						EMAIL.setSenton(ref SentOn);
						LL = 1301;
						EMAIL.setSourcetypecode(ref SourceTypeCode);
						LL = 1302;
						//EMAIL.setOriginalfolder(OriginalFolder )
						
						EMAIL.setOriginalfolder(ref EmailFolderFQN);
						LL = 1304;
						
						AllRecipients = AllRecipients.Trim;
						LL = 1306;
						if (SentTo.Length > 0)
						{
							LL = 1307;
							string ch = SentTo.Substring(0, 1);
							LL = 1308;
							if (ch.Equals(";"))
							{
								LL = 1309;
								StringType.MidStmtStr(ref SentTo, 1, 1, " ");
								LL = 1310;
								SentTo = SentTo.Trim();
								LL = 1311;
							}
							LL = 1312;
						}
						LL = 1313;
						EMAIL.setSentto(ref SentTo);
						LL = 1314;
						
						LL = 1315;
						EMAIL.setSubject(UTIL.RemoveSingleQuotesV1(Subject));
						LL = 1316;
						string ShortSubj = Subject.Substring(0, 240);
						LL = 1317;
						EMAIL.setShortsubj(UTIL.RemoveSingleQuotesV1(ShortSubj));
						LL = 1318;
						bool MailAdded = false;
						LL = 1319;
						
						LL = 1320;
						string TempEmailDir = UTIL.getTempProcessingDir();
						LL = 1321;
						TempEmailDir = TempEmailDir + "\\EmailUpload\\";
						TempEmailDir = TempEmailDir.Replace("\\\\", "\\");
						
						if (! Directory.Exists(TempEmailDir))
						{
							Directory.CreateDirectory(TempEmailDir);
						}
						
						EmailFQN = TempEmailDir + "\\" + EmailGuid + ".MSG";
						EmailFQN = EmailFQN.Replace("\\\\", "\\");
						
						string originalName = EmailGuid + ".MSG";
						LL = 1322;
						for (int xx = 1; xx <= EmailFQN.Length; xx++)
						{
							Application.DoEvents();
							LL = 1323;
							string ch = EmailFQN.Substring(xx - 1, 1);
							LL = 1324;
							if (ch == "@")
							{
								LL = 1325;
								StringType.MidStmtStr(ref EmailFQN, xx, 1, "_");
								LL = 1326;
							}
							LL = 1327;
							if (ch == "-")
							{
								LL = 1328;
								StringType.MidStmtStr(ref EmailFQN, xx, 1, "_");
								LL = 1329;
							}
							LL = 1330;
						}
						LL = 1331;
						
						try
						{
							//** Save the message as a file here and prepare to upload the file to the server a little later.
							oMsg.SaveAs(EmailFQN, null);
						}
						catch (Exception ex)
						{
							LOG.WriteToNoticeLog((string) ("WARNING clsArchiver : ArchiveEmailsInFolder 771-77a LL:" + LL.ToString() + " : " + ex.Message));
							LOG.WriteToNoticeLog((string) ("WARNING clsArchiver : ArchiveEmailsInFolder 771-77b LL:" + LL.ToString() + " : " + tgtFolderName));
						}
						
						LL = 1333;
						bool BB = false;
						LL = 1334;
						if (ArchiveEmails.Length == 0)
						{
							LL = 1335;
							ArchiveEmails = "Y";
							LL = 1336;
						}
						LL = 1337;
						Application.DoEvents();
						LL = 1338;
						
						LL = 1339;
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1009: " + EmailFolderFQN));
						}
						LL = 1340;
						
						UTIL.StripSemiColon(ref AllRecipients);
						UTIL.StripSingleQuotes(ref AllRecipients);
						UTIL.StripSemiColon(ref CC);
						UTIL.StripSingleQuotes(ref CC);
						UTIL.StripSemiColon(ref SenderName);
						UTIL.StripSingleQuotes(ref SenderName);
						UTIL.StripSingleQuotes(ref SentTo);
						UTIL.StripSemiColon(ref SentTo);
						UTIL.StripSingleQuotes(ref SenderEmailAddress);
						UTIL.StripSemiColon(ref SenderEmailAddress);
						UTIL.StripSemiColon(ref ReceivedByName);
						UTIL.StripSingleQuotes(ref ReceivedByName);
						UTIL.StripSemiColon(ref BCC);
						UTIL.StripSingleQuotes(ref BCC);
						
						LL = 1341;
						if (ArchiveEmails.Equals("Y"))
						{
							LL = 1342;
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1010: " + EmailFolderFQN));
							}
							LL = 1343;
							int bx = EMAIL.cnt_FULL_UI_EMAIL(EmailIdentifier);
							
							LL = 1344;
							if (bx == 0)
							{
								LL = 1345;
								
								string CRC = ENC.getSha1HashFromFile(EmailFQN);
								
								//** The EMAIL does not exist, ADD a record to the ContentUser table
								
								BB = EMAIL.InsertNewEmail(modGlobals.gMachineID, modGlobals.gNetworkID, "MSG", EmailIdentifier, CRC, EmailFolderFQN);
								LL = 1348;
								modGlobals.gEmailsAdded++;
								LL = 1349;
								if (BB)
								{
									
									bMailAlreadyUploaded = DBLocal.addOutlook(EmailIdentifier);
									if (! slStoreId.ContainsKey(EmailIdentifier))
									{
										slStoreId.Add(EmailIdentifier, i);
									}
									
									frmMain.Default.EmailsBackedUp++;
									Application.DoEvents();
									ID = (int) 5555.1;
									//*******************************************************************************
									//** Add the EMAIL as a File to the repository
									//** Call Filestream service or standard service here
									bool bMail = UpdateEmailMsg(originalName, ID, UID, EmailFQN, EmailGuid, RetentionCode, isPublic, CRC);
									//*******************************************************************************
									if (bMail == false)
									{
										LL = 1355;
										string fExt = UTIL.getFileSuffix(EmailFQN);
										if (fExt.ToUpper().Equals(".MSG") || fExt.ToUpper().Equals("MSG"))
										{
											string TempFQN = "";
											bool BBX = false;
											if (fExt.ToUpper().Equals(".MSG") || fExt.ToUpper().Equals("MSG"))
											{
												EmailFQN = EmailFQN.Substring(0, EmailFQN.IndexOf(".MSG") + 0);
												ID = (int) 5555.2;
												if (File.Exists(EmailFQN))
												{
													//*******************************************************************************
													//** Add the EMAIL as a File to the repository
													//** Call Filestream service or standard service here
													BBX = UpdateEmailMsg(originalName, ID, UID, EmailFQN, EmailGuid, RetentionCode, isPublic, CRC);
													//*******************************************************************************
													if (BBX == true)
													{
														EMAIL.setSourcetypecode("EML");
														DBLocal.addOutlook(EmailIdentifier);
													}
													else
													{
														//** It failed again, SKIP IT.
														LOG.WriteToArchiveLog((string) ("ERROR 299a: Failed to add email" + EmailFQN));
														goto LabelSkipThisEmail;
													}
												}
											}
										}
									}
									
									//************************************************
									//**  Add the key to the Local DB lookup database
									bool bExists = DBLocal.OutlookExists(EmailIdentifier);
									if (! bExists)
									{
										DBLocal.addOutlook(EmailIdentifier);
									}
									//************************************************
									
									LL = 1356;
									string sSql = "Update EMAIL set CurrMailFolderID = \'" + CurrMailFolderID + "\' where EmailGuid = \'" + EmailGuid + "\'";
									LL = 1357;
									bool bbExec = ExecuteSqlNewConn(sSql, false);
									LL = 1358;
									if (! bbExec)
									{
										LL = 1359;
										LOG.WriteToArchiveLog("ERROR: 1234.99a");
										LL = 1360;
									}
									LL = 1361;
									
									sSql = "Update EMAIL set RetentionExpirationDate = \'" + RetentionExpirationDate + "\' where EmailGuid = \'" + EmailGuid + "\'";
									LL = 1371;
									bbExec = ExecuteSqlNewConn(sSql, false);
									LL = 1372;
									if (! bbExec)
									{
										LL = 1373;
										LOG.WriteToArchiveLog("ERROR: 1234.99c");
										LL = 1374;
									}
									LL = 1375;
									sSql = "Update EMAIL set RetentionCode = \'" + RetentionCode + "\' where EmailGuid = \'" + EmailGuid + "\'";
									LL = 1376;
									bbExec = ExecuteSqlNewConn(sSql, false);
									LL = 1377;
									if (! bbExec)
									{
										LL = 1378;
										LOG.WriteToArchiveLog("ERROR: 1234.99c");
										LL = 1379;
									}
									LL = 1380;
									
									LL = 1381;
									if (xDebug)
									{
										LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1013: " + EmailFolderFQN));
									}
									LL = 1382;
									setRetentionDate(EmailGuid, RetentionCode, ".MSG");
									LL = 1383;
									
									LL = 1384;
									if (EmailLibrary.Trim().Length > 0)
									{
										LL = 1385;
										AddLibraryItem(EmailGuid, ShortSubj, ".MSG", EmailLibrary);
										LL = 1386;
									}
									LL = 1387;
									Application.DoEvents();
									LL = 1389;
									if (xDebug)
									{
										LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1014: " + EmailFolderFQN));
									}
									LL = 1390;
									
									LL = 1391;
									MailAdded = true;
									LL = 1392;
								}
								else
								{
									frmMain.Default.FilesBackedUp++;
									MailAdded = false;
									LL = 1398;
								}
								LL = 1399;
							}
							else
							{
								LL = 1400;
								BB = true;
								LL = 1401;
								MailAdded = false;
								LL = 1402;
							}
							LL = 1403;
							if (BB)
							{
								LL = 1404;
								bool bAddHash = false;
								if (bAddHash)
								{
									EmailAddHash(EmailGuid, EmailIdentifier);
								}
								LL = 1405;
								if (File.Exists(EmailFQN))
								{
									Kill(EmailFQN);
									LL = 1407;
								}
								DeleteMsg = true;
								LL = 1408;
							}
							else
							{
								LL = 1409;
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("Error 623.45 - Failed to delete temp email file : " + Subject));
								}
								LL = 1410;
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1017: " + EmailFolderFQN));
								}
								LL = 1411;
								MailAdded = false;
								LL = 1412;
								goto LabelSkipThisEmail2;
								LL = 1413;
							}
							LL = 1414;
						}
						LL = 1415;
						
						LL = 1416;
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1018: " + EmailFolderFQN));
						}
						LL = 1417;
						
						LL = 1418;
						if (ArchiveEmails.Equals("N") && ArchiveAfterXDays.Equals("Y"))
						{
							LL = 1419;
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1019: " + EmailFolderFQN));
							}
							LL = 1420;
							TimeSpan elapsed_time;
							LL = 1421;
							if (CurrName.ToUpper().Equals("SENT ITEMS"))
							{
								LL = 1422;
								elapsed_time = CurrDateTime.Subtract(SentOn);
								LL = 1423;
							}
							else
							{
								LL = 1424;
								elapsed_time = CurrDateTime.Subtract(CreationTime);
								LL = 1425;
							}
							LL = 1426;
							//elapsed_time = ReceivedTime.Subtract(CurrDateTime)
							LL = 1427;
							int ElapsedDays = (int) elapsed_time.TotalDays;
							LL = 1428;
							if (ElapsedDays >= XDaysRemove)
							{
								LL = 1429;
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1020: " + EmailFolderFQN));
								}
								LL = 1430;
								bool bx = System.Convert.ToBoolean(EMAIL.cnt_FULL_UI_EMAIL(EmailIdentifier));
								LL = 1431;
								if (bx == 0)
								{
									LL = 1432;
									if (xDebug)
									{
										LOG.WriteToArchiveLog((string) ("ArchiveEmailsInFolder 101 : added email  - " + tgtFolderName));
									}
									LL = 1433;
									//BB = ArchiveEmail(EmailFQN, EmailGuid, Subject , AllRecipients , EmailBody, BCC , BillingInformation , CC , Companies , CreationTime, ReadReceiptRequested.ToString, ReceivedByName , ReceivedTime, AllRecipients , gCurrUserGuidID, SenderEmailAddress , SenderName , Sensitivity , SentOn, EmailSize, DeferredDeliveryTime, EntryID , ExpiryTime, LastModificationTime, ShortSubj , SourceTypeCode , OriginalFolder )
									LL = 1434;
									string CRC = ENC.getSha1HashFromFile(FQN);
									BB = EMAIL.InsertNewEmail(modGlobals.gMachineID, modGlobals.gNetworkID, "MSG", EmailIdentifier, CRC, EmailFolderFQN);
									
									bMailAlreadyUploaded = DBLocal.addOutlook(EmailIdentifier);
									if (slStoreId.ContainsKey(EmailIdentifier))
									{
										slStoreId.Add(EmailIdentifier, i);
									}
									
									Application.DoEvents();
									LL = 1435;
									modGlobals.gEmailsAdded++;
									LL = 1436;
									if (BB)
									{
										LL = 1437;
										frmMain.Default.EmailsBackedUp++;
										LL = 1438;
										//InsertEmailBinary(EmailFQN, EmailGuid)
										LL = 1439;
										ID = (int) 5555.3;
										//*******************************************************************************
										//** Add the EMAIL as a File to the repository
										//** Call Filestream service or standard service here
										bool bMail = UpdateEmailMsg(originalName, ID, UID, EmailFQN, EmailGuid, RetentionCode, isPublic, CRC);
										//*******************************************************************************
										if (bMail == false)
										{
											EmailAddHash(EmailGuid, EmailIdentifier);
											string fExt = UTIL.getFileSuffix(EmailFQN);
											if (fExt.ToUpper().Equals(".MSG") || fExt.ToUpper().Equals("MSG"))
											{
												string TempFQN = "";
												bool BBX = false;
												if (fExt.ToUpper().Equals(".MSG") || fExt.ToUpper().Equals("MSG"))
												{
													EmailFQN = EmailFQN.Substring(0, EmailFQN.IndexOf(".MSG") + 0);
													ID = (int) 5555.4;
													//*******************************************************************************
													//** Add the EMAIL as a File to the repository
													//** Call Filestream service or standard service here
													BBX = UpdateEmailMsg(originalName, ID, UID, EmailFQN, EmailGuid, RetentionCode, isPublic, CRC);
													//*******************************************************************************
													if (BBX == true)
													{
														DBLocal.addOutlook(EmailIdentifier);
														EMAIL.setSourcetypecode("EML");
													}
													else
													{
														//** It failed again, SKIP IT.
														LOG.WriteToArchiveLog((string) ("ERROR 299b: Failed to add email" + EmailFQN));
														goto LabelSkipThisEmail;
													}
												}
											}
										}
										else
										{
											EmailAddHash(EmailGuid, EmailIdentifier);
										}
										
										LL = 1440;
										MailAdded = true;
										//LL = 1441
										//Dim sSql  = "Update EMAIL set CurrMailFolderID = '" + CurrMailFolderID + "' where EmailGuid = '" + EmailGuid + "'"
										//LL = 1442
										//Dim bbExec As Boolean = ExecuteSqlNewConn(sSql, False)
										//LL = 1443
										//If Not bbExec Then
										//    LL = 1444
										//    LOG.WriteToArchiveLog("ERROR: 1234.99")
										//    LL = 1445
										//End If
										//LL = 1446
										
										LL = 1447;
										string HexCrc = ENC.getSha1HashFromFile(FQN);
										LL = 1448;
										string sSql = "Update EMAIL set CRC = \'" + HexCrc + "\' where EmailGuid = \'" + EmailGuid + "\'";
										LL = 1449;
										bool bbExec = ExecuteSqlNewConn(sSql, false);
										LL = 1450;
										if (! bbExec)
										{
											LL = 1451;
											LOG.WriteToArchiveLog("ERROR: 1234.99");
											LL = 1452;
										}
										LL = 1453;
									}
									LL = 1454;
									if (BB)
									{
										LL = 1455;
										//BB = UpdateEmailMsg(EmailFQN, EmailGuid)
										LL = 1456;
										Kill(EmailFQN);
										LL = 1457;
										MailAdded = true;
										LL = 1458;
									}
									else
									{
										LL = 1459;
										if (xDebug)
										{
											LOG.WriteToArchiveLog((string) ("ArchiveEmailsInFolder 101 : failed to add email  - " + tgtFolderName));
										}
										LL = 1460;
										MailAdded = false;
										LL = 1461;
										goto LabelSkipThisEmail2;
										LL = 1462;
									}
									LL = 1463;
								}
								LL = 1464;
							}
							else
							{
								LL = 1465;
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1021: " + EmailFolderFQN));
								}
								LL = 1466;
								DeleteMsg = false;
								LL = 1467;
								MailAdded = false;
								LL = 1468;
								frmMain.Default.FilesBackedUp++;
								LL = 1469;
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("ArchiveEmailsInFolder 105 : skipped email  - " + tgtFolderName));
								}
								LL = 1470;
								goto LabelSkipThisEmail;
								LL = 1471;
							}
							LL = 1472;
						}
						LL = 1473;
						
						LL = 1474;
						Application.DoEvents();
						LL = 1475;
						
						LL = 1476;
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("** ArchiveEmailsInFolder 1022: " + EmailFolderFQN));
						}
						LL = 1477;
						
						LL = 1478;
						if (MailAdded)
						{
							LL = 1479;
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("ADDED ** ArchiveEmailsInFolder 1023: " + EmailFolderFQN));
							}
							LL = 1480;
							SL2.Clear();
							LL = 1481;
							if (CC != null)
							{
								LL = 1482;
								if (CC.Trim().Length > 0)
								{
									LL = 1483;
									string[] A = new string[1];
									LL = 1484;
									if (CC.IndexOf(";") + 1 > 0)
									{
										LL = 1485;
										A = CC.Split(';');
										LL = 1486;
									}
									else
									{
										LL = 1487;
										A[0] = CC;
										LL = 1488;
									}
									LL = 1489;
									for (KK = 0; KK <= (A.Length - 1); KK++)
									{
										LL = 1490;
										string SKEY = A[KK];
										LL = 1491;
										if (SKEY != null)
										{
											LL = 1492;
											bool BX = SL.ContainsKey(SKEY);
											LL = 1493;
											if (! BX)
											{
												LL = 1494;
												SL2.Add(SKEY, "CC");
												LL = 1495;
											}
											LL = 1496;
										}
										LL = 1497;
									}
									LL = 1498;
								}
								LL = 1499;
							}
							LL = 1500;
							if (BCC != null)
							{
								LL = 1501;
								if (BCC.Trim().Length > 0)
								{
									LL = 1502;
									string[] A = new string[1];
									LL = 1503;
									if (BCC.IndexOf(";") + 1 > 0)
									{
										LL = 1504;
										A = BCC.Split(';');
										LL = 1505;
									}
									else
									{
										LL = 1506;
										A[0] = BCC;
										LL = 1507;
									}
									LL = 1508;
									for (KK = 0; KK <= (A.Length - 1); KK++)
									{
										LL = 1509;
										string SKEY = A[KK];
										LL = 1510;
										if (SKEY != null)
										{
											LL = 1511;
											bool BX = SL.ContainsKey(SKEY);
											LL = 1512;
											if (! BX)
											{
												LL = 1513;
												SL2.Add(SKEY, "BCC");
												LL = 1514;
											}
											LL = 1515;
										}
										LL = 1516;
									}
									LL = 1517;
								}
								LL = 1518;
							}
							LL = 1519;
							
							LL = 1520;
							for (KK = 1; KK <= oMsg.Recipients.Count; KK++)
							{
								Application.DoEvents();
								LL = 1521;
								if (xDebug)
								{
									if (xDebug)
									{
										LOG.WriteToArchiveLog("Recipients Address: " + oMsg.Recipients[KK].Address);
									}
								}
								LL = 1522;
								if (xDebug)
								{
									if (xDebug)
									{
										LOG.WriteToArchiveLog("Recipients Name   : " + oMsg.Recipients[KK].Name);
									}
								}
								LL = 1523;
								string Addr = oMsg.Recipients[KK].Address.ToString();
								LL = 1524;
								RECIPS.setEmailguid(ref EmailGuid);
								LL = 1525;
								RECIPS.setRecipient(ref Addr);
								LL = 1526;
								bool BX = SL2.ContainsKey(Addr);
								LL = 1527;
								if (! BX)
								{
									LL = 1528;
									RECIPS.setTyperecp("RECIP");
									LL = 1529;
								}
								else
								{
									LL = 1530;
									int iKey = SL2.IndexOfKey(Addr);
									LL = 1531;
									string TypeCC = "";
									LL = 1532;
									TypeCC = SL2[Addr].ToString();
									LL = 1533;
									RECIPS.setTyperecp(ref TypeCC);
									LL = 1534;
								}
								LL = 1535;
								RECIPS.Insert();
								LL = 1536;
							}
							LL = 1537;
							
							LL = 1538;
							int iAtachCount = oMsg.Attachments.Count;
							LL = 1539;
							
							if (iAtachCount > 0)
							{
								Application.DoEvents();
								LL = 1540;
								Outlook.Attachment Atmt;
								LL = 1541;
								int iAcount = 0;
								string filenameToDelete = "";
								foreach (Outlook.Attachment tempLoopVar_Atmt in oMsg.Attachments)
								{
									Atmt = tempLoopVar_Atmt;
									try
									{
										LL = 1542;
										string TempDir = UTIL.getTempProcessingDir() + "\\EmailTempLoad\\";
										TempDir = TempDir.Replace("\\\\", "\\");
										
										if (! Directory.Exists(TempDir))
										{
											Directory.CreateDirectory(TempDir);
										}
										
										LL = 1544;
										string filename = TempDir + Atmt.FileName;
										filename = filename.Replace("\\\\", "\\");
										
										filenameToDelete = filename;
										filenameToDelete = filenameToDelete.Replace("//", "/");
										
										frmNotify2.Default.BackColor = Color.LightSalmon;
										frmNotify2.Default.lblMsg2.BackColor = Color.Gray;
										frmNotify2.Default.lblMsg2.Text = (string) (">> " + Atmt.FileName.ToString());
										frmNotify2.Default.lblMsg2.Refresh();
										frmNotify2.Default.Refresh();
										
										LL = 1546;
										Atmt.SaveAsFile(filename);
										LL = 1547;
										
										string FileExt = (string) ("." + UTIL.getFileSuffix(filename));
										LL = 1549;
										
										int bCnt = ATYPE.cnt_PK29(FileExt);
										LL = 1550;
										bool isZipFile = false;
										LL = 1551;
										if (bCnt == 0)
										{
											LL = 1552;
											bool B1 = ZF.isZipFile(filename);
											LL = 1553;
											if (B1)
											{
												ATYPE.setIszipformat("1");
												LL = 1555;
												isZipFile = true;
												LL = 1556;
											}
											else
											{
												LL = 1557;
												ATYPE.setIszipformat("0");
												LL = 1558;
												isZipFile = false;
												LL = 1559;
											}
											LL = 1560;
											ATYPE.setAttachmentcode(ref FileExt);
											LL = 1561;
											ATYPE.Insert();
											LL = 1562;
										}
										LL = 1563;
										bool BBB = ZF.isZipFile(filename);
										LL = 1564;
										ATYPE.setDescription("Auto added this code.");
										LL = 1565;
										if (BBB)
										{
											LL = 1566;
											ATYPE.setIszipformat("1");
											LL = 1567;
											isZipFile = true;
											LL = 1568;
										}
										else
										{
											LL = 1569;
											ATYPE.setIszipformat("0");
											LL = 1570;
											isZipFile = false;
											LL = 1571;
										}
										LL = 1572;
										if (isZipFile == true)
										{
											LL = 1573;
											//** Explode and load
											LL = 1574;
											//WDM ZIPFILE
											LL = 1575;
											string AttachmentName = Atmt.FileName;
											LL = 1576;
											bool SkipIfAlreadyArchived = false;
											DBLocal.addZipFile(filename, EmailGuid, true);
											LL = 1577;
											ListOfFiles.Clear();
											//ZF.ProcessEmailZipFile(EmailGuid, filename, gCurrUserGuidID, SkipIfAlreadyArchived, AttachmentName, StackLevel, ListOfFiles)
											ZF.ProcessEmailZipFile(modGlobals.gMachineID, EmailGuid, filename, UID, SkipIfAlreadyArchived, AttachmentName, StackLevel, ref ListOfFiles);
											LL = 1578;
										}
										else
										{
											LL = 1579;
											FileExt = (string) ("." + UTIL.getFileSuffix(filename));
											LL = 1580;
											string AttachmentName = Atmt.FileName;
											if (AttachmentName.IndexOf("dmaquestion") + 1 > 0 || AttachmentName.IndexOf("Workbook") + 1 > 0 || AttachmentName.IndexOf("girl") + 1 > 0)
											{
												Console.WriteLine("here 001xx");
											}
											
											string Sha1Hash = ENC.getSha1HashFromFile(filename);
											int iFileID = DBLocal.GetFileID(filename, Sha1Hash);
											
											if (iFileID < 0)
											{
												string strRowGuid = System.Convert.ToString(InsertAttachmentFqn(modGlobals.gCurrUserGuidID, filename, EmailGuid, AttachmentName, FileExt, modGlobals.gCurrUserGuidID, RetentionCode, Sha1Hash, isPublic, EmailFolderFQN));
											}
											LL = 1582;
											if (FileExt.IndexOf("trf") + 1 > 0)
											{
												Console.WriteLine("Here TRF");
											}
											bool bIsImage = isImageFile(FileExt);
											LL = 1583;
											
										}
										if (FileExt.ToUpper().Equals(".MSG") || FileExt.ToUpper().Equals("MSG"))
										{
											clsEmailFunctions EMX = new clsEmailFunctions();
											List<string> xAttachedFiles = new List<string>();
											File FF;
											if (FF.Exists(filename))
											{
												string EmailDescription = "";
												EMX.LoadMsgFile(UID, filename, ServerName, CurrMailFolderName, EmailLibrary, RetentionCode, Subject, ref EmailBody, ref xAttachedFiles, false, EmailGuid, ref EmailDescription);
												
												if (EmailDescription.Length > 0)
												{
													EmailDescription = UTIL.RemoveSingleQuotes(EmailDescription);
													concatEmailBody(EmailDescription, EmailGuid);
												}
												
											}
											FF = null;
											EMX = null;
											GC.Collect();
											GC.WaitForPendingFinalizers();
										}
										LL = 1596;
										frmNotify2.Default.BackColor = Color.LightGray;
										frmNotify2.Default.Refresh();
									}
									catch (Exception ex)
									{
										LOG.WriteToArchiveLog((string) ("ERROR  -   ARCHIVE OCR: 100 - " + ex.Message));
									}
									finally
									{
										try
										{
											Kill(filenameToDelete);
											frmNotify2.Default.lblMsg2.Text = DateTime.Now.ToString();
											frmNotify2.Default.lblMsg2.Refresh();
										}
										catch (Exception)
										{
											LOG.WriteToArchiveLog("Notification: " + filenameToDelete + " not deleted.");
										}
									}
								}
								GC.Collect();
								GC.WaitForPendingFinalizers();
								Application.DoEvents();
								LL = 1598;
							}
							LL = 1599;
						}
						else
						{
							LL = 1600;
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("SKIPPED ** ArchiveEmailsInFolder 1099: " + EmailFolderFQN));
							}
							LL = 1601;
						}
						LL = 1602;
						
						LL = 1603;
						Application.DoEvents();
						LL = 1604;
						
						LL = 1605;
LabelSkipThisEmail:
						LL = 1606;
						
						LL = 1607;
						Application.DoEvents();
						LL = 1608;
						//** Now, check for the processing rules ***************
						LL = 1609;
						if (RemoveAfterXDays.Equals("Y")) // And RemoveAfterArchive .Equals("N") Then
						{
							LL = 1610;
							TimeSpan elapsed_time;
							LL = 1611;
							if (CurrName.ToUpper().Equals("SENT ITEMS"))
							{
								LL = 1612;
								elapsed_time = CurrDateTime.Subtract(SentOn);
								LL = 1613;
							}
							else
							{
								LL = 1614;
								elapsed_time = CurrDateTime.Subtract(CreationTime);
								LL = 1615;
							}
							LL = 1616;
							//elapsed_time = ReceivedTime.Subtract(CurrDateTime)
							LL = 1617;
							int ElapsedDays = (int) elapsed_time.TotalDays;
							LL = 1618;
							if (ElapsedDays > 1000)
							{
								LL = 1619;
								ElapsedDays = 30;
								LL = 1620;
								SentOn = oMsg.SentOn;
								LL = 1621;
								ReceivedTime = oMsg.ReceivedTime;
								LL = 1622;
								CreationTime = oMsg.CreationTime;
								LL = 1623;
								elapsed_time = CurrDateTime.Subtract(CreationTime);
								LL = 1624;
								//elapsed_time = ReceivedTime.Subtract(CurrDateTime)
								LL = 1625;
								ElapsedDays = (int) elapsed_time.TotalDays;
								LL = 1626;
							}
							LL = 1627;
							
							LL = 1628;
							if (ElapsedDays < 0)
							{
								LL = 1629;
								ElapsedDays = 30;
								LL = 1630;
								SentOn = oMsg.SentOn;
								LL = 1631;
								ReceivedTime = oMsg.ReceivedTime;
								LL = 1632;
								CreationTime = oMsg.CreationTime;
								LL = 1633;
								elapsed_time = CurrDateTime.Subtract(CreationTime);
								LL = 1634;
								//elapsed_time = ReceivedTime.Subtract(CurrDateTime)
								LL = 1635;
								ElapsedDays = (int) elapsed_time.TotalDays;
								LL = 1636;
							}
							LL = 1637;
							
							LL = 1638;
							if (ElapsedDays >= XDaysRemove)
							{
								LL = 1639;
								if (xDebug)
								{
									LOG.WriteToArchiveLog(CurrOutlookSubFolder.Name + ": Deleted ElapsedDays email... " + i.ToString() + ":" + ElapsedDays.ToString() + " days old.");
								}
								LL = 1640;
								//oMsg.Display()
								LL = 1641;
								
								LL = 1642;
								EM2D.setEmailguid(ref EmailGuid);
								LL = 1643;
								EM2D.setStoreid(ref StoreID);
								LL = 1644;
								EM2D.setUserid(ref modGlobals.gCurrUserGuidID);
								LL = 1645;
								EM2D.setMessageid(oMsg.EntryID);
								LL = 1646;
								if (bMsgUnopened == false && ArchiveOnlyIfRead == "Y")
								{
									LL = 1647;
									//log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #102")
									LL = 1648;
									bool BK = EM2D.Insert();
									LL = 1649;
									if (BK)
									{
										LL = 1650;
										//if xDebug then log.WriteToArchiveLog("oMsg.Delete()")
										LL = 1651;
										//oMsg.Delete()
										LL = 1652;
										if (bMoveIt)
										{
											LL = 1653;
											//oMsg.Move(oDeletedItems)
											MoveToHistoryFolder(oMsg);
											LL = 1654;
											LOG.WriteToArchiveLog("clsArchiver : GetEmailFolders : Delete Performed 02");
											LL = 1655;
										}
										LL = 1656;
										
										LL = 1657;
									}
									LL = 1658;
								}
								else if (ArchiveOnlyIfRead == "N")
								{
									LL = 1659;
									bool ExecuteThis = true;
									LL = 1660;
									
									LL = 1661;
									bool BK = EM2D.Insert();
									LL = 1662;
									//log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #103")
									LL = 1663;
									if (BK)
									{
										LL = 1664;
										if (xDebug)
										{
											LOG.WriteToArchiveLog("oMsg.Delete()");
										}
										LL = 1665;
										if (ExecuteThis == true)
										{
											LL = 1666;
											if (bMoveIt)
											{
												LL = 1667;
												LOG.WriteToArchiveLog("clsArchiver : GetEmailFolders : Delete Performed 03");
												LL = 1668;
												//oMsg.Move(oDeletedItems)
												MoveToHistoryFolder(oMsg);
												LL = 1669;
											}
											LL = 1670;
										}
										LL = 1671;
									}
									LL = 1672;
								}
								else
								{
									LL = 1673;
									if (xDebug)
									{
										LOG.WriteToArchiveLog("No match ... ");
									}
									LL = 1674;
								}
								LL = 1676;
								//if xDebug then log.WriteToArchiveLog("oMsg.Delete()")
								LL = 1677;
								goto LabelSkipThisEmail2;
								LL = 1678;
							}
							LL = 1679;
						}
						LL = 1680;
						Application.DoEvents();
						LL = 1681;
						//** Delete the archived MSG from the archive directory
						LL = 1682;
						if (RemoveAfterArchive.Equals("Y") && DeleteMsg)
						{
							LL = 1683;
							if (xDebug)
							{
								LOG.WriteToArchiveLog(CurrOutlookSubFolder.Name + ": Deleted email... ");
							}
							LL = 1684;
							//oMsg.Display()
							LL = 1685;
							//If bMsgUnopened = False And ArchiveOnlyIfRead  = "Y" Then
							LL = 1686;
							EM2D.setEmailguid(ref EmailGuid);
							LL = 1687;
							EM2D.setStoreid(ref StoreID);
							LL = 1688;
							EM2D.setUserid(ref modGlobals.gCurrUserGuidID);
							LL = 1689;
							EM2D.setMessageid(oMsg.EntryID);
							LL = 1690;
							if (bMsgUnopened == false && ArchiveOnlyIfRead == "Y")
							{
								LL = 1691;
								bool BK = EM2D.Insert();
								LL = 1692;
								//log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #104")
								LL = 1693;
								if (BK)
								{
									LL = 1694;
									if (xDebug)
									{
										LOG.WriteToArchiveLog("oMsg.Delete()");
									}
									LL = 1695;
									//oMsg.Delete()
									LL = 1696;
									bool ExecuteThis = false;
									LL = 1697;
									if (ExecuteThis == true)
									{
										LL = 1698;
										if (bMoveIt)
										{
											LL = 1699;
											LOG.WriteToArchiveLog("clsArchiver : GetEmailFolders : Delete Performed 04");
											LL = 1700;
											//oMsg.Move(oDeletedItems)
											MoveToHistoryFolder(oMsg);
											LL = 1701;
										}
										LL = 1702;
									}
									LL = 1703;
								}
								LL = 1704;
							}
							else if (ArchiveOnlyIfRead == "N")
							{
								LL = 1705;
								bool BK = EM2D.Insert();
								LL = 1706;
								//log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #105")
								LL = 1707;
								if (BK)
								{
									LL = 1708;
									if (xDebug)
									{
										LOG.WriteToArchiveLog("oMsg.Delete()");
									}
									LL = 1709;
									//oMsg.Delete()
									LL = 1710;
									if (bMoveIt)
									{
										LL = 1711;
										LOG.WriteToArchiveLog("clsArchiver : GetEmailFolders : Delete Performed 05");
										LL = 1712;
										//oMsg.Move(oDeletedItems)
										MoveToHistoryFolder(oMsg);
										LL = 1713;
									}
									LL = 1715;
								}
								LL = 1716;
							}
							else
							{
								LL = 1717;
								if (xDebug)
								{
									LOG.WriteToArchiveLog("No match ... ");
								}
								LL = 1718;
							}
							LL = 1719;
							
							LL = 1720;
							//End If
							LL = 1721;
						}
						else if (bRemoveAfterArchive)
						{
							LL = 1722;
							if (xDebug)
							{
								LOG.WriteToArchiveLog(CurrOutlookSubFolder.Name + ": Deleted email... ");
							}
							LL = 1723;
							//oMsg.Display()
							LL = 1724;
							//If bMsgUnopened = False And ArchiveOnlyIfRead  = "Y" Then
							LL = 1725;
							EM2D.setEmailguid(ref EmailGuid);
							LL = 1726;
							EM2D.setStoreid(ref StoreID);
							LL = 1727;
							EM2D.setUserid(ref modGlobals.gCurrUserGuidID);
							LL = 1728;
							EM2D.setMessageid(oMsg.EntryID);
							LL = 1729;
							if (bMsgUnopened == false && ArchiveOnlyIfRead == "Y")
							{
								LL = 1730;
								bool BK = EM2D.Insert();
								LL = 1731;
								//log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #106")
								LL = 1732;
								if (BK)
								{
									LL = 1733;
									if (xDebug)
									{
										LOG.WriteToArchiveLog("oMsg.Delete()");
									}
									LL = 1734;
									//oMsg.Delete()
									LL = 1735;
									if (bMoveIt)
									{
										LL = 1736;
										LOG.WriteToArchiveLog("clsArchiver : GetEmailFolders : Delete Performed 06");
										LL = 1737;
										//oMsg.Move(oDeletedItems)
										MoveToHistoryFolder(oMsg);
										LL = 1738;
									}
									LL = 1739;
								}
								LL = 1740;
							}
							else if (ArchiveOnlyIfRead == "N")
							{
								LL = 1741;
								Application.DoEvents();
								bool BK = EM2D.Insert();
								Application.DoEvents();
								LL = 1742;
								//log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #107")
								LL = 1743;
								if (BK)
								{
									LL = 1744;
									if (xDebug)
									{
										LOG.WriteToArchiveLog("oMsg.Delete()");
									}
									LL = 1745;
									//oMsg.Delete()
									LL = 1746;
									if (bMoveIt)
									{
										LL = 1747;
										LOG.WriteToArchiveLog("clsArchiver : GetEmailFolders : Delete Performed 07");
										LL = 1748;
										oMsg.Move(oDeletedItems);
										LL = 1749;
									}
									LL = 1750;
								}
								LL = 1751;
							}
							else
							{
								LL = 1752;
								if (xDebug)
								{
									LOG.WriteToArchiveLog("No match ... ");
								}
								LL = 1753;
							}
							LL = 1754;
							
							LL = 1755;
						}
						LL = 1756;
					}
					catch (Exception ex)
					{
						frmMain.Default.EmailsSkipped++;
						Console.WriteLine(oItems[i].MessageClass.ToString());
						if (ex.Message.IndexOf("no files found matching") + 1 > 0)
						{
							Console.WriteLine("Warning - file not found LL = " + LL.ToString());
						}
						else
						{
							string tMsg = "";
							tMsg = "ERROR: " + ArchiveMsg + " SKIPPED - " + ex.Message + " LL = " + LL.ToString() + "\r\n";
							tMsg += "ERROR: Subj:" + Subject + " SKIPPED - " + ex.Message + " LL = " + LL.ToString() + "\r\n";
							tMsg += (string) ("clsArchiver : ArchiveEmailsInFolder: 99999 - item#" + i.ToString() + " : " + ex.Message + "Message Type: " + oItems[i].MessageClass.ToString() + " LL = " + LL.ToString());
							LOG.WriteToArchiveLog(tMsg);
						}
					}
					
LabelSkipThisEmail2:
					LL = 1768;
					
				}
				LL = 1769;
				
				LL = 1770;
				oItems = null;
				LL = 1771;
				oMsg = null;
				LL = 1772;
				GC.Collect();
				LL = 1773;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ArchiveEmailsInFolder 144.23.1a - " + ex.Message + " LL = " + LL.ToString()));
				LOG.WriteToArchiveLog((string) ("ArchiveEmailsInFolder 144.23.1b - " + ex.StackTrace + " LL = " + LL.ToString()));
			}
			finally
			{
				LL = 1777;
				// In any case please remember to turn on Outlook Security after your code,
				//since now it is very easy to switch it off! :-)
				LL = 1778;
				//SecurityManager.DisableOOMWarnings = False
				LL = 1779;
				frmMain.Default.PBx.Value = 0;
				LL = 1780;
				//'FrmMDIMain.TSPB1.Value = 0
				LL = 1781;
			}
			LL = 1782;
			frmNotify2.Default.Close();
		}
		
		public void ArchiveExchangeEmails(string UID, string NewGuid, string Body, string Subject, ArrayList CC, ArrayList BCC, ArrayList EmailToAddr, ArrayList Recipients, string CurrMailFolderID_ServerName, string SenderEmailAddress, string SenderName, DateTime SentOn, string ReceivedByName, DateTime ReceivedTime, DateTime CreationTime, string DB_ID, string CurrMailFolder, string Server_UserID_StoreID, int RetentionYears, string RetentionCode, int EmailSize, List<string> AttachedFiles, string EntryID, string EmailIdentifier, string EmailFQN, string LibraryName, bool isPublic, bool bEmlToMSG, ref bool AttachmentsLoaded, int DaysToRetain)
		{
			
			int StackLevel = 0;
			Dictionary<string, int> ListOfFiles = new Dictionary<string, int>();
			
			int ID = 7777;
			clsEMAIL EM = new clsEMAIL();
			
			FileInfo FI = new FileInfo(EmailFQN);
			string OriginalName = FI.Name;
			FI = null;
			
			string LastEmailArchRunDate = UserParmRetrive("LastEmailArchRunDate", modGlobals.gCurrUserGuidID);
			if (LastEmailArchRunDate.Trim().Length == 0)
			{
				LastEmailArchRunDate = "1/1/1950";
			}
			DateTime rightNow = DateTime.Now;
			if (RetentionYears == 0)
			{
				RetentionYears = int.Parse(val[getSystemParm("RETENTION YEARS")]);
			}
			rightNow = rightNow.AddYears(RetentionYears);
			string RetentionExpirationDate = rightNow.ToString();
			
			int EmailsSkipped = 0;
			bool DeleteMsg = false;
			DateTime CurrDateTime = DateTime.Now;
			int ArchiveAge = 0;
			int RemoveAge = 0;
			int XDaysArchive = 0;
			int XDaysRemove = 0;
			//Dim EmailFQN  = ""
			bool bRemoveAfterArchive = false;
			bool bMsgUnopened = false;
			string CurrMailFolderName = "";
			DateTime MinProcessDate = DateTime.Parse("01/1/1910");
			string CurrName = CurrMailFolder;
			string ArchiveMsg = CurrName + ": ";
			int DaysOld = 0;
			string DB_ConnectionString = "";
			int LL = 0;
			try
			{
				LL = 3;
				
				SL.Clear();
				LL = 5;
				SL2.Clear();
				LL = 6;
				
				CurrMailFolderName = CurrMailFolder;
				LL = 8;
				// Loop each unread message. :LL =  9
				int i = 0;
				LL = 10;
				
				EM.setStoreID(ref CurrMailFolder);
				LL = 12;
				
				try
				{
					LL = 14;
					
					string EmailGuid = NewGuid.ToString();
					string OriginalFolder = CurrMailFolder;
					LL = 16;
					string FNAME = CurrMailFolder;
					LL = 17;
					string keyEmailIdentifier = NewGuid;
					LL = 19;
					
					if (SentOn == null)
					{
						LL = 21;
						SentOn = DateTime.Parse("1/1/1899");
						LL = 22;
					}
					LL = 23;
					
					if (ReceivedTime == null)
					{
						LL = 25;
						ReceivedTime = DateTime.Parse("1/1/1899");
						LL = 26;
					}
					LL = 27;
					
					if (CreationTime == null)
					{
						LL = 29;
						CreationTime = DateTime.Parse("1/1/1970");
						LL = 30;
					}
					LL = 31;
					if (CreationTime < DateTime.Parse("1/1/1960"))
					{
						LL = 32;
						CreationTime = DateTime.Parse("1/1/1960");
						LL = 33;
					}
					LL = 34;
					
					//If frmReconMain.ckUseLastProcessDateAsCutoff.Checked Then :LL =  36
					modGlobals.setLastEmailDate(CurrMailFolderName, CreationTime);
					LL = 37;
					
					string SourceTypeCode = "EML";
					LL = 39;
					if (bEmlToMSG == true)
					{
						LL = 40;
						SourceTypeCode = "MSG";
						LL = 41;
					}
					LL = 42;
					
					bool bAutoForwarded = false;
					LL = 44;
					
					string BillingInformation = null;
					LL = 46;
					string EmailBody = Body;
					LL = 47;
					string FullBody = EmailBody;
					//*************** DO NOT SAVE THE WHOLE BODY, JUST THE FIRST 100 CHARACTERS *****************
					//EmailBody = EmailBody.Substring(0, 100)
					//*******************************************************************************************
					
					string BodyFormat = "";
					LL = 48;
					string Categories = "";
					LL = 49;
					
					string Companies = "";
					LL = 51;
					string ConversationIndex = "";
					LL = 52;
					string ConversationTopic = "";
					LL = 53;
					
					DateTime DeferredDeliveryTime = null;
					LL = 55;
					string DownloadState = "";
					LL = 56;
					
					string HTMLBody = "";
					LL = 58;
					string Importance = "";
					LL = 59;
					bool IsMarkedAsTask = false;
					LL = 60;
					DateTime LastModificationTime = DateTime.Now;
					LL = 61;
					string MessageClass = "";
					LL = 62;
					string Mileage = "";
					LL = 63;
					bool OriginatorDeliveryReportRequested = false;
					LL = 64;
					string OutlookInternalVersion = "";
					LL = 65;
					bool ReadReceiptRequested = false;
					LL = 66;
					string ReceivedByEntryID = "";
					LL = 67;
					
					if (ReceivedByName == null)
					{
						LL = 69;
						ReceivedByName = "Unknown";
						LL = 70;
					}
					else if (ReceivedByName.Length == 0)
					{
						LL = 71;
						ReceivedByName = "Unknown";
						LL = 72;
					}
					LL = 73;
					string ReceivedOnBehalfOfName = "";
					LL = 74;
					
					int KK = 0;
					LL = 76;
					string AllRecipients = "";
					LL = 77;
					for (KK = 0; KK <= Recipients.Count - 1; KK++)
					{
						LL = 78;
						AllRecipients = AllRecipients + "; " + Recipients[KK];
						LL = 79;
						AddRecipToList(EmailGuid, (string) (Recipients[KK]), "RECIP");
						LL = 80;
					}
					LL = 81;
					
					if (AllRecipients.Length > 0)
					{
						LL = 83;
						string ch = AllRecipients.Substring(0, 1);
						LL = 84;
						if (ch.Equals(";"))
						{
							LL = 85;
							StringType.MidStmtStr(ref AllRecipients, 1, 1, " ");
							LL = 86;
							AllRecipients = AllRecipients.Trim();
							LL = 87;
						}
						LL = 88;
					}
					LL = 89;
					
					bool ReminderSet = false;
					LL = 91;
					DateTime ReminderTime = null;
					LL = 92;
					object ReplyRecipientNames = null;
					LL = 93;
					string SenderEmailType = "";
					LL = 94;
					string Sensitivity = "";
					LL = 95;
					string SentOnBehalfOfName = "";
					LL = 96;
					
					ArchiveMsg = ArchiveMsg + " : " + Subject;
					LL = 98;
					
					DateTime TaskCompletedDate = null;
					LL = 100;
					DateTime TaskDueDate = DateTime.Now;
					LL = 101;
					string TaskSubject = "";
					LL = 102;
					
					string VotingOptions = "";
					LL = 104;
					string VotingResponse = "";
					LL = 105;
					object UserProperties = null;
					LL = 106;
					string Accounts = "None Supplied";
					LL = 107;
					
					string NewTime = ReceivedTime.ToString().Replace("//", ".");
					LL = 109;
					NewTime = ReceivedTime.ToString().Replace("/:", ".");
					LL = 110;
					NewTime = ReceivedTime.ToString().Replace(" ", "_");
					LL = 111;
					string NewSubject = Subject.Substring(0, 200);
					LL = 112;
					NewSubject = NewSubject.Replace(" ", "_");
					LL = 113;
					ConvertName(ref NewSubject);
					LL = 114;
					ConvertName(ref NewTime);
					LL = 115;
					
					bool bExcluded = modGlobals.isExcludedEmail(SenderEmailAddress);
					LL = 117;
					if (bExcluded)
					{
						LL = 118;
						goto LabelSkipThisEmail;
						LL = 119;
					}
					LL = 120;
					
					if (SenderEmailAddress.Length == 0 || SenderEmailAddress == null)
					{
						LL = 122;
						SenderEmailAddress = "Unknown";
						LL = 123;
					}
					LL = 124;
					
					if (SentOn == null)
					{
						LL = 126;
						SentOn = DateTime.Parse("1/1/1900");
						LL = 127;
					}
					LL = 128;
					
					if (SenderName.Length == 0 || SenderName == null)
					{
						LL = 130;
						SenderName = "Unknown";
						LL = 131;
					}
					LL = 132;
					
					int bExists = EM.cnt_FULL_UI_EMAIL(EmailIdentifier);
					LL = 134;
					if (bExists > 0)
					{
						LL = 135;
						goto LabelSkipThisEmail;
						LL = 136;
					}
					LL = 137;
					
					AllRecipients += (string) (";" + ReceivedByName);
					LL = 139;
					
					EM.setEntryid(ref EntryID);
					LL = 141;
					EM.setEmailguid(ref EmailGuid);
					LL = 142;
					
					if (BCC.Count > 0)
					{
						LL = 144;
						foreach (string sBcc in BCC)
						{
							LL = 145;
							AllRecipients = AllRecipients + "; " + sBcc;
							LL = 146;
						}
						LL = 147;
						
					}
					LL = 149;
					if (CC.Count > 0)
					{
						LL = 150;
						foreach (string sBcc in CC)
						{
							LL = 151;
							AllRecipients = AllRecipients + "; " + sBcc;
							LL = 152;
						}
						LL = 153;
					}
					LL = 154;
					
					string AllBcc = "";
					LL = 156;
					foreach (string sBcc in BCC)
					{
						LL = 157;
						AllBcc = AllBcc + "; " + sBcc;
						LL = 158;
					}
					LL = 159;
					string AllCC = "";
					LL = 160;
					foreach (string sBcc in CC)
					{
						LL = 161;
						AllCC = AllCC + "; " + sBcc;
						LL = 162;
					}
					LL = 163;
					
					EM.setAllrecipients(ref AllRecipients);
					LL = 165;
					EM.setBcc(ref AllBcc);
					LL = 166;
					EM.setBillinginformation(ref BillingInformation);
					LL = 167;
					EM.setBody(UTIL.RemoveSingleQuotes(EmailBody));
					LL = 168;
					EM.setCc(ref AllCC);
					LL = 169;
					EM.setCompanies(ref Companies);
					LL = 170;
					EM.setCreationtime(ref CreationTime);
					LL = 171;
					EM.setCurrentuser(ref modGlobals.gCurrUserGuidID);
					LL = 172;
					EM.setDeferreddeliverytime(ref DeferredDeliveryTime);
					LL = 173;
					EM.setDeferreddeliverytime(ref DeferredDeliveryTime);
					LL = 174;
					EM.setEmailguid(ref EmailGuid);
					LL = 175;
					//EM.setEmailimage() :LL =  176
					
					EM.setExpirytime(ref RetentionExpirationDate);
					LL = 178;
					EM.setLastmodificationtime(ref LastModificationTime);
					LL = 179;
					EM.setMsgsize(EmailSize.ToString());
					LL = 180;
					EM.setReadreceiptrequested(OriginatorDeliveryReportRequested.ToString());
					LL = 181;
					EM.setReceivedbyname(ref ReceivedByName);
					LL = 182;
					EM.setReceivedtime(ref ReceivedTime);
					LL = 183;
					EM.setSenderemailaddress(ref SenderEmailAddress);
					LL = 184;
					EM.setSendername(ref SenderName);
					LL = 185;
					EM.setSensitivity(ref Sensitivity);
					LL = 186;
					EM.setSenton(ref SentOn);
					LL = 187;
					if (bEmlToMSG == true)
					{
						LL = 188;
						EM.setSourcetypecode("MSG");
						LL = 189;
					}
					else
					{
						LL = 190;
						EM.setSourcetypecode(ref SourceTypeCode);
						LL = 191;
					}
					LL = 192;
					
					EM.setOriginalfolder(ref OriginalFolder);
					LL = 194;
					
					string SentTo = "";
					LL = 196;
					if (Recipients.Count > 0)
					{
						LL = 197;
						for (int iI = 0; iI <= Recipients.Count - 1; iI++)
						{
							LL = 198;
							SentTo += (string) (Recipients[iI] + ";");
							LL = 199;
						}
						LL = 200;
					}
					LL = 201;
					
					EM.setSentto(ref ReceivedByName);
					LL = 203;
					EM.setSubject(UTIL.RemoveSingleQuotes(Subject));
					LL = 204;
					string ShortSubj = Subject.Substring(0, 240);
					LL = 205;
					EM.setShortsubj(UTIL.RemoveSingleQuotes(ShortSubj));
					LL = 206;
					bool MailAdded = false;
					LL = 207;
					
					bool BB = false;
					LL = 209;
					
					int bx = EM.cnt_FULL_UI_EMAIL(EmailIdentifier);
					LL = 211;
					if (bx == 0)
					{
						LL = 212;
						//*****  *********************************************** :LL =  213
						//Convert to MSG and store the image as a MSG file :LL =  214
						string CRC = ENC.getSha1HashFromFile(FQN);
						if (bEmlToMSG == true)
						{
							LL = 215;
							BB = EM.InsertNewEmail(modGlobals.gMachineID, modGlobals.gNetworkID, "MSG", EmailIdentifier, CRC, CurrMailFolder);
							LL = 216;
						}
						else
						{
							LL = 217;
							BB = EM.InsertNewEmail(modGlobals.gMachineID, modGlobals.gNetworkID, "EML", EmailIdentifier, CRC, CurrMailFolder);
							LL = 218;
						}
						LL = 219;
						//*****  *********************************************** :LL =  220
						
						if (BB == true)
						{
							LL = 222;
							EmailAddHash(EmailGuid, EmailIdentifier);
							ID = (int) 7777.1;
							//**********************************************************************************************
							//** Call Filestream service or standard service here
							bool bFileApplied = UpdateEmailMsg(OriginalName, ID, UID, EmailFQN, EmailGuid, RetentionCode, isPublic.ToString(), CRC);
							LL = 224;
							//**********************************************************************************************
							if (bFileApplied == false && bEmlToMSG == true)
							{
								LL = 225;
								if (bEmlToMSG == true)
								{
									LL = 226;
									string TempFQN = "";
									LL = 227;
									bool BBX = false;
									LL = 228;
									string fExt = UTIL.getFileSuffix(EmailFQN);
									LL = 229;
									if (fExt.ToUpper().Equals(".MSG") || fExt.ToUpper().Equals("MSG"))
									{
										LL = 230;
										EmailFQN = EmailFQN.Substring(0, EmailFQN.IndexOf(".MSG") + 0);
										LL = 231;
										ID = (int) 7777.2;
										//**********************************************************************************************
										//** Call Filestream service or standard service here
										BBX = UpdateEmailMsg(OriginalName, ID, UID, EmailFQN, EmailGuid, RetentionCode, isPublic.ToString(), CRC);
										LL = 232;
										//**********************************************************************************************
										if (BBX == true)
										{
											LL = 233;
											bEmlToMSG = false;
											LL = 234;
											EM.setSourcetypecode("EML");
											LL = 235;
										}
										else
										{
											LL = 236;
											//** It failed again, SKIP IT. :LL =  237
											LOG.WriteToArchiveLog((string) ("ERROR 299: Failed to add email" + CurrMailFolderID_ServerName + "\r\n" + EmailFQN));
											LL = 238;
											goto LabelSkipThisEmail;
											LL = 239;
										}
										LL = 240;
									}
									LL = 241;
								}
								LL = 242;
							}
							else
							{
								LL = 243;
								//frmExchangeMonitor.lblMsg.Text = ("Added EMAIL" + Now.ToLocalTime.ToString)
								Application.DoEvents();
							}
							LL = 245;
							
							//EmailIdentifier :LL =  247
							//**WDM Removed below 3/11/2010 :LL =  248
							string sSql = "Update EMAIL set EmailIdentifier = \'" + EmailIdentifier + "\' where EmailGuid = \'" + EmailGuid + "\'";
							LL = 249;
							bool bbExec = ExecuteSqlNewConn(sSql, false);
							LL = 250;
							if (! bbExec)
							{
								LL = 251;
								LOG.WriteToArchiveLog((string) ("ERROR: 1234.99xx: " + EmailFQN + "\r\n" + sSql));
								LL = 252;
							}
							LL = 253;
							
							//LibraryName , ByVal isPublic As Boolean :LL =  255
							if (LibraryName.Trim().Length > 0)
							{
								LL = 256;
								string LibraryOwnerUserID = GetLibOwnerByName(LibraryName);
								LL = 257;
								if (LibraryOwnerUserID.Trim().Length == 0)
								{
									LOG.WriteToArchiveLog("ERROR: 300 - No Lib Owner found for LibraryName = \'" + LibraryName + "\'.");
								}
								if (LibraryOwnerUserID.Length > 0)
								{
									string tSql = "";
									LL = 258;
									clsLIBRARYITEMS LI = new clsLIBRARYITEMS();
									LL = 259;
									int iCnt = cnt_UniqueEntry(LibraryName, EmailGuid);
									LL = 260;
									if (iCnt == 0)
									{
										LL = 261;
										LI.setSourceguid(ref EmailGuid);
										LL = 262;
										LI.setItemtitle(Subject.Substring(0, 200));
										LL = 263;
										LI.setItemtype(ref SourceTypeCode);
										LL = 264;
										LI.setLibraryitemguid(Guid.NewGuid().ToString());
										LL = 265;
										LI.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
										LL = 266;
										LI.setLibraryowneruserid(ref LibraryOwnerUserID);
										LL = 267;
										LI.setLibraryname(ref LibraryName);
										LL = 268;
										LI.setAddedbyuserguidid(ref modGlobals.gCurrUserGuidID);
										LL = 269;
										bool b = LI.Insert();
										LL = 270;
										//frmExchangeMonitor.lblCnt.Text = Now.ToString
										frmExchangeMonitor.Default.Refresh();
										
										if (b == false)
										{
											LL = 271;
											LOG.WriteToArchiveLog((string) ("ERROR: 198.171.76 - Failed to add Email Library Item: " + LibraryName + " : + " + Subject));
											LL = 272;
										}
										LL = 273;
									}
									LL = 274;
									LI = null;
									LL = 275;
								}
								
								GC.Collect();
								LL = 276;
							}
							LL = 277;
							if (bEmlToMSG == true)
							{
								LL = 278;
								sSql = "Update EMAIL set ConvertEmlToMSG = 1 where EmailGuid = \'" + EmailGuid + "\'";
								LL = 279;
								bbExec = ExecuteSqlNewConn(sSql, false);
								LL = 280;
								if (! bbExec)
								{
									LL = 281;
									LOG.WriteToArchiveLog("ERROR: 1234.99zx1");
									LL = 282;
								}
								LL = 283;
							}
							LL = 284;
							if (isPublic == true)
							{
								LL = 285;
								sSql = "Update EMAIL set isPublic = 1 where EmailGuid = \'" + EmailGuid + "\'";
								LL = 286;
							}
							else
							{
								LL = 287;
								sSql = "Update EMAIL set isPublic = 0 where EmailGuid = \'" + EmailGuid + "\'";
								LL = 288;
							}
							LL = 289;
							bbExec = ExecuteSqlNewConn(sSql, false);
							LL = 290;
							if (! bbExec)
							{
								LL = 291;
								LOG.WriteToArchiveLog("ERROR: 1234.99xx2");
								LL = 292;
							}
							LL = 293;
							
							sSql = "Update EMAIL set CurrMailFolderID = \'" + CurrMailFolderID_ServerName + "\' where EmailGuid = \'" + EmailGuid + "\'";
							LL = 295;
							bbExec = ExecuteSqlNewConn(sSql, false);
							LL = 296;
							if (! bbExec)
							{
								LL = 297;
								LOG.WriteToArchiveLog("ERROR: 1234.99a");
								LL = 298;
							}
							LL = 299;
							
							sSql = "Update EMAIL set CRC = \'" + CRC + "\' where EmailGuid = \'" + EmailGuid + "\'";
							LL = 302;
							bbExec = ExecuteSqlNewConn(sSql, false);
							LL = 303;
							if (! bbExec)
							{
								LL = 304;
								LOG.WriteToArchiveLog("ERROR: 1234.99b");
								LL = 305;
							}
							LL = 306;
							
							//RetentionExpirationDate :LL =  308
							sSql = "Update EMAIL set RetentionExpirationDate = \'" + RetentionExpirationDate + "\' where EmailGuid = \'" + EmailGuid + "\'";
							LL = 309;
							bbExec = ExecuteSqlNewConn(sSql, false);
							LL = 310;
							if (! bbExec)
							{
								LL = 311;
								LOG.WriteToArchiveLog("ERROR: 1234.99c");
								LL = 312;
							}
							LL = 313;
							sSql = "Update EMAIL set RetentionCode = \'" + RetentionCode + "\' where EmailGuid = \'" + EmailGuid + "\'";
							LL = 314;
							bbExec = ExecuteSqlNewConn(sSql, false);
							LL = 315;
							if (! bbExec)
							{
								LL = 316;
								LOG.WriteToArchiveLog("ERROR: 1234.99c");
								LL = 317;
							}
							LL = 318;
							
							setRetentionDate(EmailGuid, RetentionCode, ".EML");
							LL = 320;
							
							MailAdded = true;
							LL = 322;
						}
						else
						{
							LL = 323;
							EmailAddHash(EmailGuid, EmailIdentifier);
							
							TotalFilesArchived++;
							LL = 324;
							//**WDM Removed below 3/11/2010 :LL =  325
							string sSql = "Update EMAIL set EmailIdentifier = \'" + EmailIdentifier + "\' where EmailGuid = \'" + EmailGuid + "\'";
							LL = 326;
							bool bbExec = ExecuteSqlNewConn(sSql, false);
							LL = 327;
							if (! bbExec)
							{
								LL = 328;
								LOG.WriteToArchiveLog("ERROR: 1234.99xx12");
								LL = 329;
							}
							LL = 330;
							
							if (bEmlToMSG == true)
							{
								LL = 332;
								sSql = "Update EMAIL set ConvertEmlToMSG = 1 where EmailGuid = \'" + EmailGuid + "\'";
								LL = 333;
								bbExec = ExecuteSqlNewConn(sSql, false);
								LL = 334;
							}
							LL = 335;
							
							if (LibraryName.Trim().Length > 0)
							{
								LL = 337;
								string LibraryOwnerUserID = GetLibOwnerByName(LibraryName);
								LL = 338;
								if (LibraryOwnerUserID.Trim().Length == 0)
								{
									LOG.WriteToArchiveLog("ERROR: 400 - No Lib Owner found.");
								}
								
								string tSql = "";
								LL = 339;
								clsLIBRARYITEMS LI = new clsLIBRARYITEMS();
								LL = 340;
								int iCnt = cnt_UniqueEntry(LibraryName, EmailGuid);
								LL = 341;
								if (iCnt == 0)
								{
									LL = 342;
									LI.setSourceguid(ref EmailGuid);
									LL = 343;
									LI.setItemtitle(Subject.Substring(0, 200));
									LL = 344;
									LI.setItemtype(ref SourceTypeCode);
									LL = 345;
									LI.setLibraryitemguid(Guid.NewGuid().ToString());
									LL = 346;
									LI.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
									LL = 347;
									LI.setLibraryowneruserid(ref LibraryOwnerUserID);
									LL = 348;
									LI.setLibraryname(ref LibraryName);
									LL = 349;
									LI.setAddedbyuserguidid(ref modGlobals.gCurrUserGuidID);
									LL = 350;
									bool b = LI.Insert();
									LL = 351;
									if (b == false)
									{
										LL = 352;
										LOG.WriteToArchiveLog((string) ("ERROR: 198.171.76 - Failed to add Email Library Item: " + LibraryName + " : + " + Subject));
										LL = 353;
									}
									LL = 354;
								}
								LL = 355;
								LI = null;
								LL = 356;
								GC.Collect();
								LL = 357;
							}
							LL = 358;
							
							if (isPublic == true)
							{
								LL = 360;
								sSql = "Update EMAIL set isPublic = 1 where EmailGuid = \'" + EmailGuid + "\'";
								LL = 361;
							}
							else
							{
								LL = 362;
								sSql = "Update EMAIL set isPublic = 0 where EmailGuid = \'" + EmailGuid + "\'";
								LL = 363;
							}
							LL = 364;
							bbExec = ExecuteSqlNewConn(sSql, false);
							LL = 365;
							if (! bbExec)
							{
								LL = 366;
								LOG.WriteToArchiveLog("ERROR: 1234.99xx6");
								LL = 367;
							}
							LL = 368;
							
							MailAdded = false;
							LL = 370;
							
						}
						LL = 372;
					}
					else
					{
						LL = 373;
						BB = true;
						LL = 374;
						MailAdded = false;
						LL = 375;
					}
					LL = 376;
					if (BB)
					{
						LL = 377;
						//BB = UpdateEmailMsg(EmailFQN, EmailGuid ) :LL =  378
						try
						{
							LL = 379;
							Kill(EmailFQN);
							LL = 380;
						}
						catch (System.Exception ex)
						{
							LL = 381;
							LOG.WriteToArchiveLog((string) ("ArchiveExchangeEmails 1000: " + ex.Message));
							LL = 382;
						}
						LL = 383;
						
						DeleteMsg = true;
						LL = 385;
					}
					else
					{
						LL = 386;
						MailAdded = false;
						LL = 387;
						goto LabelSkipThisEmail;
						LL = 388;
					}
					LL = 389;
					
					if (MailAdded)
					{
						LL = 391;
						SL2.Clear();
						LL = 392;
						if (AllCC != null)
						{
							LL = 393;
							if (AllCC.Trim().Length > 0)
							{
								LL = 394;
								string[] A = new string[1];
								LL = 395;
								if (AllCC.IndexOf(";") + 1 > 0)
								{
									LL = 396;
									A = AllCC.Split(';');
									LL = 397;
								}
								else
								{
									LL = 398;
									A[0] = AllCC;
									LL = 399;
								}
								LL = 400;
								for (KK = 0; KK <= (A.Length - 1); KK++)
								{
									LL = 401;
									string SKEY = A[KK];
									LL = 402;
									if (SKEY != null)
									{
										LL = 403;
										bool BXX = SL.ContainsKey(SKEY);
										LL = 404;
										if (! BXX)
										{
											LL = 405;
											SL2.Add(SKEY, "CC");
											LL = 406;
										}
										LL = 407;
									}
									LL = 408;
								}
								LL = 409;
							}
							LL = 410;
						}
						LL = 411;
						if (AllBcc != null)
						{
							LL = 412;
							if (AllBcc.Trim().Length > 0)
							{
								LL = 413;
								string[] A = new string[1];
								LL = 414;
								if (AllBcc.IndexOf(";") + 1 > 0)
								{
									LL = 415;
									A = AllBcc.Split(';');
									LL = 416;
								}
								else
								{
									LL = 417;
									A[0] = AllBcc;
									LL = 418;
								}
								LL = 419;
								for (KK = 0; KK <= (A.Length - 1); KK++)
								{
									LL = 420;
									string SKEY = A[KK];
									LL = 421;
									if (SKEY != null)
									{
										LL = 422;
										bool BXX = SL.ContainsKey(SKEY);
										LL = 423;
										if (! BXX)
										{
											LL = 424;
											SL2.Add(SKEY, "allbcc");
											LL = 425;
										}
										LL = 426;
									}
									LL = 427;
								}
								LL = 428;
							}
							LL = 429;
						}
						LL = 430;
						
						//For KK = 0 To Recipients.Count - 1 :LL =  432
						foreach (string tAddr in Recipients)
						{
							LL = 433;
							//Dim Addr  = Recipients.Item(i) :LL =  434
							string Addr = tAddr;
							LL = 435;
							RECIPS.setEmailguid(ref EmailGuid);
							LL = 436;
							RECIPS.setRecipient(ref Addr);
							LL = 437;
							bool BXX = SL2.ContainsKey(Addr);
							LL = 438;
							if (! BXX)
							{
								LL = 439;
								RECIPS.setTyperecp("RECIP");
								LL = 440;
							}
							else
							{
								LL = 441;
								int iKey = SL2.IndexOfKey(Addr);
								LL = 442;
								string TypeCC = "";
								LL = 443;
								TypeCC = SL2[Addr].ToString();
								LL = 444;
								RECIPS.setTyperecp(ref TypeCC);
								LL = 445;
							}
							LL = 446;
							RECIPS.Insert();
							LL = 447;
						}
						LL = 448;
						
						bool bWinMail = false;
						LL = 450;
						
START_WINMAIL_PROCESS:
						
						if (AttachedFiles.Count > 0)
						{
							LL = 453;
							foreach (string FileName in AttachedFiles)
							{
								LL = 454;
								//Dim TempDir  = System.IO.Path.GetTempPath :LL =  455
								//FileName  = AttachedFiles.Item(II) :LL =  456
								string FileExt = (string) ("." + UTIL.getFileSuffix(FileName));
								LL = 457;
								
								int bCnt = ATYPE.cnt_PK29(FileExt);
								LL = 459;
								bool isZipFile = false;
								LL = 460;
								
								if (FileName.IndexOf("winmail.dat") + 1 > 0)
								{
									LL = 462;
									goto SkipThisOne;
									LL = 463;
								}
								LL = 464;
								
								if (FileExt.ToUpper().Equals(".MSG") || FileExt.ToUpper().Equals("MSG"))
								{
									LL = 466;
									clsEmailFunctions EMX = new clsEmailFunctions();
									LL = 467;
									List<string> xAttachedFiles = new List<string>();
									LL = 468;
									
									if (File.Exists(FileName))
									{
										LL = 471;
										EMX.LoadMsgFile(UID, FileName, CurrMailFolderID_ServerName, CurrMailFolder, LibraryName, RetentionCode, Subject, ref EmailBody, ref xAttachedFiles, false, NewGuid, ref DaysToRetain);
										LL = 472;
									}
									LL = 473;
									
									EMX = null;
									LL = 475;
									GC.Collect();
									LL = 476;
									GC.WaitForPendingFinalizers();
									LL = 477;
									
									for (int IIX = 0; IIX <= xAttachedFiles.Count - 1; IIX++)
									{
										LL = 479;
										try
										{
											LL = 480;
											string tFqn = xAttachedFiles(IIX);
											LL = 481;
											if (! AttachedFiles.Contains(tFqn))
											{
												LL = 482;
												AttachedFiles.Add(tFqn);
												LL = 483;
											}
											LL = 484;
										}
										catch (System.Exception)
										{
											LL = 485;
											Console.WriteLine("Corrected attached file 100");
										}
										LL = 487;
									}
									LL = 488;
									for (int III = 0; III <= AttachedFiles.Count - 1; III++)
									{
										LL = 489;
										if ((AttachedFiles(III)).ToString().IndexOf("winmail.dat") + 1 > 0)
										{
											LL = 490;
											AttachedFiles(III) = "";
											LL = 491;
										}
										LL = 492;
										if (AttachedFiles(III).ToUpper.Equals(FileName.ToUpper()))
										{
											LL = 493;
											AttachedFiles(III) = "";
											LL = 494;
										}
										LL = 495;
									}
									LL = 496;
									goto START_WINMAIL_PROCESS;
									LL = 497;
								}
								LL = 498;
								
								if (bCnt == 0)
								{
									LL = 500;
									bool B1 = ZF.isZipFile(FileName);
									LL = 501;
									if (B1)
									{
										LL = 502;
										ATYPE.setIszipformat("1");
										LL = 503;
										isZipFile = true;
										LL = 504;
									}
									else
									{
										LL = 505;
										ATYPE.setIszipformat("0");
										LL = 506;
										isZipFile = false;
										LL = 507;
									}
									LL = 508;
									ATYPE.setAttachmentcode(ref FileExt);
									LL = 509;
									ATYPE.Insert();
									LL = 510;
								}
								LL = 511;
								
								bool BBB = ZF.isZipFile(FileName);
								LL = 513;
								
								ATYPE.setDescription("Auto added this code.");
								LL = 515;
								if (BBB)
								{
									LL = 516;
									ATYPE.setIszipformat("1");
									LL = 517;
									isZipFile = true;
									LL = 518;
								}
								else
								{
									LL = 519;
									ATYPE.setIszipformat("0");
									LL = 520;
									isZipFile = false;
									LL = 521;
								}
								LL = 522;
								if (isZipFile == true)
								{
									LL = 523;
									//** Explode and load :LL =  524
									string AttachmentName = FileName;
									LL = 525;
									bool SkipIfAlreadyArchived = false;
									LL = 526;
									DBLocal.addZipFile(FileName, EmailGuid, true);
									//ZF.ProcessEmailZipFile(EmailGuid, FileName , gCurrUserGuidID, SkipIfAlreadyArchived, AttachmentName, False) : LL = 527
									ZF.ProcessEmailZipFile(modGlobals.gMachineID, EmailGuid, FileName, UID, SkipIfAlreadyArchived, AttachmentName, StackLevel, ref ListOfFiles);
								}
								else
								{
									LL = 528;
									FileExt = (string) ("." + UTIL.getFileSuffix(FileName));
									LL = 529;
									string AttachmentName = FileName;
									string Sha1Hash = ENC.getSha1HashFromFile(FileName);
									bool bbx = InsertAttachmentFqn(modGlobals.gCurrUserGuidID, FileName, EmailGuid, AttachmentName, FileExt, modGlobals.gCurrUserGuidID, RetentionCode, Sha1Hash, isPublic.ToString(), OriginalFolder);
									if (bbx == false)
									{
										LOG.WriteToArchiveLog((string) ("WARNING: Failed to process attachment for " + Subject + " / " + EmailGuid));
									}
								}
								LL = 548;
SkipThisOne:
								1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
							}
							LL = 551;
						}
						LL = 552;
						
					}
					LL = 554;
					
					
LabelSkipThisEmail:
					1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
				}
				catch (System.Exception ex)
				{
					EmailsSkipped++;
					LOG.WriteToArchiveLog(ArchiveMsg + "LL: " + LL.ToString() + " -  SKIPPED - " + ex.Message);
					LOG.WriteToArchiveLog((string) ("clsArchiver : ArchiveEmailsInFolder: 100a - LL#" + LL.ToString()));
					LOG.WriteToArchiveLog((string) ("clsArchiver : ArchiveEmailsInFolder: 100b - item#" + i.ToString() + " : " + ex.Message));
				}
				
				GC.Collect();
				GC.WaitForFullGCComplete();
				
			}
			catch (System.Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("FATAL ERROR clsArchiver : ArchiveEmailsInFolder: 100-D - LL# " + LL.ToString() + " : " + ex.Message));
			}
			finally
			{
				// In any case please remember to turn on Outlook Security after your code, since now it is very easy to switch it off! :-)
				//SecurityManager.DisableOOMWarnings = False
				EM = null;
			}
			
			//UpdateAttachmentCounts()
			
			bool DoThis = false;
			if (DoThis)
			{
				if (AttachmentsLoaded == true)
				{
					AppendOcrTextEmail(NewGuid);
					AttachmentsLoaded = false;
				}
			}
			
			
			
		}
		
		public void AddRecipientsToDB()
		{
			clsRECIPIENTS R = new clsRECIPIENTS();
			int I = 0;
			for (I = 0; I <= SL.Count - 1; I++)
			{
				string S = SL.GetKey(I).ToString();
				string[] A = Strings.Split(S, Strings.Chr(254), -1, 0);
				R.setEmailguid(ref A[0]);
				R.setRecipient(ref A[1]);
				R.setTyperecp(ref A[2]);
				string[] Recips = (A[1]).Split(';');
				
				for (int k = 0; k <= (Recips.Length - 1); k++)
				{
					int II = R.cnt_PK32A(A[0], Recips[k]);
					if (II == 0)
					{
						bool b = R.Insert();
						if (! b)
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("Error 7391.2: Failed to add RECIPIENT " + A[1]));
							}
						}
					}
				}
			}
		}
		public void AddRecipToList(string sGuid, string RECIP, string TypeRecip)
		{
			RECIP = UTIL.RemoveSingleQuotes(RECIP);
			bool b = false;
			string tKey = sGuid + Strings.Chr(254) + RECIP + Strings.Chr(254) + TypeRecip;
			b = SL.Contains(tKey);
			if (! b)
			{
				try
				{
					SL.Add(tKey, TypeRecip);
				}
				catch (Exception ex)
				{
					if (xDebug)
					{
						LOG.WriteToArchiveLog((string) ("Error 66521: skiped recip list item: " + ex.Message));
					}
				}
				
			}
		}
		public void ArchiveEmailsInFolderenders(string ArchiveEmails, string RemoveAfterArchive, string SetAsDefaultFolder, string ArchiveAfterXDays, string RemoveAfterXDays, string RemoveXDays, string ArchiveXDays, Outlook.MAPIFolder CurrMailFolder, bool DeleteEmail)
		{
			
			bool DeleteMsg = false;
			DateTime CurrDateTime = DateTime.Now;
			int ArchiveAge = 0;
			int RemoveAge = 0;
			int XDaysArchive = 0;
			int XDaysRemove = 0;
			
			string DB_ConnectionString = "";
			
			if (ArchiveEmails.Equals("N") && ArchiveAfterXDays.Equals("N") && RemoveAfterArchive.Equals("N"))
			{
				//** Then this folder really should not be in the list
				return;
			}
			if (RemoveAfterArchive.Equals("Y"))
			{
				DeleteMsg = true;
			}
			if (Information.IsNumeric(RemoveXDays))
			{
				XDaysRemove = int.Parse(val[RemoveXDays]);
			}
			if (Information.IsNumeric(ArchiveXDays))
			{
				XDaysArchive = int.Parse(val[ArchiveXDays]);
			}
			
			try
			{
				
				Outlook.Items oItems = CurrMailFolder.Items;
				if (xDebug)
				{
					LOG.WriteToArchiveLog("Total : " + oItems.Count);
				}
				
				// Get unread e-mail messages.
				//oItems = oItems.Restrict("[Unread] = true")
				if (xDebug)
				{
					LOG.WriteToArchiveLog("Total Unread : " + oItems.Count);
				}
				
				// Loop each unread message.
				Outlook.MailItem oMsg;
				int i = 0;
				
				for (i = 1; i <= oItems.Count; i++)
				{
					try
					{
						if (i % 50 == 0)
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("Message#: " + i.ToString() + " of " + oItems.Count));
							}
						}
						
						oMsg = oItems[i];
						
						string SenderEmailAddress = oMsg.SenderEmailAddress;
						string SenderName = oMsg.SenderName;
						string ListKey = SenderEmailAddress.Trim() + "|" + SenderName.Trim();
						
						string MySql = "";
						MySql = MySql + " SELECT count(*) as cnt";
						MySql = MySql + " FROM  [OutlookFrom]";
						MySql = MySql + " where FromEmailAddr = \'" + SenderEmailAddress + "\'";
						MySql = MySql + " and SenderName = \'" + SenderName + "\'";
						MySql = MySql + " and UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
						
						int bb = iDataExist(MySql);
						
						if (bb > 0)
						{
							MySql = "";
							MySql = MySql + " Update  [OutlookFrom]";
							MySql = MySql + " set [Verified] = 1 ";
							MySql = MySql + " where FromEmailAddr = \'" + SenderEmailAddress + "\'";
							MySql = MySql + " and SenderName = \'" + SenderName + "\'";
							MySql = MySql + " and UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
							bool bSuccess = ExecuteSqlNewConn(MySql, false);
							if (! bSuccess)
							{
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("Update failed:" + "\r\n" + MySql));
								}
							}
						}
						else
						{
							MySql = "";
							MySql = MySql + " INSERT INTO  [OutlookFrom]";
							MySql = MySql + " ([FromEmailAddr]";
							MySql = MySql + " ,[SenderName]";
							MySql = MySql + " ,[UserID]";
							MySql = MySql + " ,[Verified])";
							MySql = MySql + " VALUES (";
							MySql = MySql + "\'" + SenderEmailAddress + "\',";
							MySql = MySql + " \'" + SenderName + "\',";
							MySql = MySql + " \'" + modGlobals.gCurrUserGuidID + "\',";
							MySql = MySql + " 1)";
							bool bSuccess = ExecuteSqlNewConn(MySql, false);
							if (! bSuccess)
							{
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("Insert failed:" + "\r\n" + MySql));
								}
							}
						}
						
						Application.DoEvents();
					}
					catch (Exception ex)
					{
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("Error: " + "\r\n" + ex.Message));
						}
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("Skipping Message# " + i.ToString()));
						}
					}
				}
				
				oItems = null;
				oMsg = null;
				GC.Collect();
			}
			catch (Exception ex)
			{
				MessageBox.Show(ex.Message);
			}
			finally
			{
				// In any case please remember to turn on Outlook Security after your code, since now it is very easy to switch it off! :-)
				//SecurityManager.DisableOOMWarnings = False
			}
			
		}
		/// <summary>
		/// This subroutine gets all fo the appointments from within the Outlook Appointment book.
		/// </summary>
		/// <remarks></remarks>
		public void getAppts()
		{
			// Create Outlook application.
			Outlook.Application oApp = new Outlook.Application();
			
			// Get NameSpace and Logon.
			Outlook.NameSpace oNS = oApp.GetNamespace("mapi");
			oNS.Logon("YourValidProfile", Missing.Value, false, true); // TODO:
			
			// Get Appointments collection from the Calendar folder.
			Outlook.MAPIFolder oCalendar = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderCalendar);
			Outlook.Items oItems = oCalendar.Items;
			
			// TODO: You may want to use Find or Restrict to retrieve the appointment that you prefer.
			// ...
			
			// Get the first AppointmentItem.
			Outlook.AppointmentItem oAppt = oItems.GetFirst();
			
			//' Display some common properties.
			//Console.WriteLine(oAppt.Organizer)
			//Console.WriteLine(oAppt.Subject)
			//Console.WriteLine(oAppt.Body)
			//Console.WriteLine(oAppt.Location)
			//Console.WriteLine(oAppt.Start.ToString())
			//Console.WriteLine(oAppt.End.ToString())
			
			// Display.
			//oAppt.Display(true)
			
			// Log off.
			oNS.Logoff();
			
			// Clean up.
			oApp = null;
			oNS = null;
			oItems = null;
			oAppt = null;
			GC.Collect();
		}
		
		/// <summary>
		/// List all the Members of a Distribution List Programmatically
		/// </summary>
		/// <remarks></remarks>
		public void DistributionList()
		{
			// Create Outlook application.
			Outlook.Application oApp = new Outlook.Application();
			
			// Get Mapi NameSpace and Logon.
			Outlook.NameSpace oNS = oApp.GetNamespace("mapi");
			oNS.Logon("YourValidProfile", Missing.Value, false, true); // TODO:
			
			// Get Global Address List.
			Outlook.AddressLists oDLs = oNS.AddressLists;
			Outlook.AddressList oGal = oDLs["Global Address List"];
			Console.WriteLine(oGal.Name);
			
			// Get a specific distribution list.
			// TODO: Replace the distribution list with a distribution list that is available to you.
			string sDL = "TestDL";
			Outlook.AddressEntries oEntries = oGal.AddressEntries;
			// No filter available to AddressEntries
			Outlook.AddressEntry oDL = oEntries[sDL];
			
			Console.WriteLine(oDL.Name);
			Console.WriteLine(oDL.Address);
			Console.WriteLine(oDL.Manager);
			
			// Get all of the members of the distribution list.
			oEntries = oDL.Members;
			Outlook.AddressEntry oEntry;
			int i;
			
			for (i = 1; i <= oEntries.Count; i++)
			{
				oEntry = oEntries[i];
				Console.WriteLine(oEntry.Name);
				// Display the Details dialog box.
				oDL.Details(Missing.Value);
			}
			
			// Log off.
			oNS.Logoff();
			
			// Clean up.
			oApp = null;
			oNS = null;
			oDLs = null;
			oGal = null;
			oEntries = null;
			oEntry = null;
			GC.Collect();
		}
		
		/// <summary>
		/// Create a meeting request
		/// </summary>
		/// <remarks></remarks>
		public void GenMeetingRequest()
		{
			// Create an Outlook application.
			Outlook.Application oApp = new Outlook.Application();
			
			// Get Mapi NameSpace and Logon.
			Outlook.NameSpace oNS = oApp.GetNamespace("mapi");
			oNS.Logon("YourValidProfile", Missing.Value, false, true); // TODO:
			
			// Create an AppointmentItem.
			Outlook._AppointmentItem oAppt = oApp.CreateItem(Outlook.OlItemType.olAppointmentItem);
			//oAppt.Display(true)  'Modal
			
			// Change AppointmentItem to a Meeting.
			oAppt.MeetingStatus = Outlook.OlMeetingStatus.olMeeting;
			
			// Set some common properties.
			oAppt.Subject = "Created using OOM in VB.NET";
			oAppt.Body = "Hello World";
			oAppt.Location = "Samm E";
			
			oAppt.Start = Convert.ToDateTime("11/30/2001 9:00:00 AM");
			oAppt.End = Convert.ToDateTime("11/30/2001 1:00:00 PM");
			
			oAppt.ReminderSet = true;
			oAppt.ReminderMinutesBeforeStart = 5;
			oAppt.BusyStatus = Outlook.OlBusyStatus.olBusy; //  olBusy
			oAppt.IsOnlineMeeting = false;
			oAppt.AllDayEvent = false;
			
			// Add attendees.
			Outlook.Recipients oRecipts = oAppt.Recipients;
			
			// Add required attendee.
			Outlook.Recipient oRecipt;
			oRecipt = oRecipts.Add("UserTest1"); // TODO:
			oRecipt.Type = Outlook.OlMeetingRecipientType.olRequired;
			
			// Add optional attendee.
			oRecipt = oRecipts.Add("UserTest2"); // TODO:
			oRecipt.Type = Outlook.OlMeetingRecipientType.olOptional;
			
			oRecipts.ResolveAll();
			
			//oAppt.Display(true)
			
			// Send out request.
			oAppt.Send();
			
			// Logoff.
			oNS.Logoff();
			
		}
		
		
		/// <summary>
		/// retrieve all contacts
		/// </summary>
		/// <remarks></remarks>
		public void ArchiveContacts()
		{
			
			bool bInstalled = true;
			
			try
			{
				Outlook.Application oAppTest = new Outlook.Application();
				bInstalled = true;
				oAppTest = null;
			}
			catch (Exception E)
			{
				LOG.WriteToArchiveLog((string) ("NOTICE: OUTLOOK does not appear to be installed - skipping archive." + "\r\n" + E.Message));
				bInstalled = false;
			}
			if (bInstalled == false)
			{
				return;
			}
			
			frmNotifyContact FrmInfo = new frmNotifyContact();
			FrmInfo.Show();
			FrmInfo.Title = "CONTACTS";
			
			FrmInfo.Text = "Outlook Contacts";
			FrmInfo.lblMsg.Text = "Contacts";
			FrmInfo.Location = new Point(25, 50);
			FrmInfo.lblMsg2.Text = "Contacts: ";
			
			DateTime SkipArchiveDate = getLastContactArchiveDate();
			
			// Create Outlook application.
			string Account = "";
			string Anniversary = "";
			string Application = "";
			string AssistantName = "";
			string AssistantTelephoneNumber = "";
			string BillingInformation = "";
			string Birthday = "";
			string Business2TelephoneNumber = "";
			string BusinessAddress = "";
			string BusinessAddressCity = "";
			string BusinessAddressCountry = "";
			string BusinessAddressPostalCode = "";
			string BusinessAddressPostOfficeBox = "";
			string BusinessAddressState = "";
			string BusinessAddressStreet = "";
			string BusinessCardType = "";
			string BusinessFaxNumber = "";
			string BusinessHomePage = "";
			string BusinessTelephoneNumber = "";
			string CallbackTelephoneNumber = "";
			string CarTelephoneNumber = "";
			string Categories = "";
			string Children = "";
			string xClass = "";
			string Companies = "";
			string CompanyName = "";
			string ComputerNetworkName = "";
			string Conflicts = "";
			string ConversationTopic = "";
			string CreationTime = "";
			string CustomerID = "";
			string Department = "";
			string Email1Address = "";
			string Email1AddressType = "";
			string Email1DisplayName = "";
			string Email1EntryID = "";
			string Email2Address = "";
			string Email2AddressType = "";
			string Email2DisplayName = "";
			string Email2EntryID = "";
			string Email3Address = "";
			string Email3AddressType = "";
			string Email3DisplayName = "";
			string Email3EntryID = "";
			string FileAs = "";
			string FirstName = "";
			string FTPSite = "";
			string FullName = "";
			string Gender = "";
			string GovernmentIDNumber = "";
			string Hobby = "";
			string Home2TelephoneNumber = "";
			string HomeAddress = "";
			string HomeAddressCountry = "";
			string HomeAddressPostalCode = "";
			string HomeAddressPostOfficeBox = "";
			string HomeAddressState = "";
			string HomeAddressStreet = "";
			string HomeFaxNumber = "";
			string HomeTelephoneNumber = "";
			string IMAddress = "";
			string Importance = "";
			string Initials = "";
			string InternetFreeBusyAddress = "";
			string JobTitle = "";
			string Journal = "";
			string Language = "";
			string LastModificationTime = "";
			string LastName = "";
			string LastNameAndFirstName = "";
			string MailingAddress = "";
			string MailingAddressCity = "";
			string MailingAddressCountry = "";
			string MailingAddressPostalCode = "";
			string MailingAddressPostOfficeBox = "";
			string MailingAddressState = "";
			string MailingAddressStreet = "";
			string ManagerName = "";
			string MiddleName = "";
			string Mileage = "";
			string MobileTelephoneNumber = "";
			string NetMeetingAlias = "";
			string NetMeetingServer = "";
			string NickName = "";
			string Title = "";
			string Body = "";
			string OfficeLocation = "";
			string Subject = "";
			
			string MySql = "";
			
			int I = 0;
			
			Outlook.Application oApp = new Outlook.Application();
			
			// Get namespace and Contacts folder reference.
			Outlook.NameSpace oNS = oApp.GetNamespace("MAPI");
			Outlook.MAPIFolder cContacts = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderContacts);
			
			// Get the first contact from the Contacts folder.
			Outlook.Items oItems = cContacts.Items;
			Outlook.ContactItem oCt;
			int K = oItems.Count;
			int iCount;
			bool bContact = false;
			
			for (I = 0; I <= K; I++)
			{
				try
				{
					System.Windows.Forms.Application.DoEvents();
					//frmReconMain.PB1.Value = I
					oCt = oItems(I);
					int II = 0;
					FrmInfo.lblMsg2.Text = (string) ("Contacts: " + I.ToString() + " of " + K.ToString());
					FrmInfo.Refresh();
					System.Windows.Forms.Application.DoEvents();
					
					Email1Address = oCt.Email1Address;
					
					if (Email1Address == null)
					{
						Email1Address = "NA";
					}
					
					Email1Address = UTIL.RemoveSingleQuotes(Email1Address);
					
					FullName = oCt.FullName;
					if (FullName.Trim().Length == 0)
					{
						LOG.WriteToArchiveLog("ERROR: Full name must be supplied for conntact, skipping EMAIL address \'" + Email1Address + "\'");
						goto SkipContact;
					}
					
					bContact = DBLocal.contactExists(UTIL.RemoveSingleQuotes(FullName), Email1Address);
					
					if (bContact)
					{
						goto SkipContact;
					}
					else
					{
						bContact = DBLocal.addContact(FullName, Email1Address);
						bool b = CNTCT.Insert();
						if (! b)
						{
							LOG.WriteToArchiveLog((string) ("ERROR 100 Contact " + (FullName + " / " + Email1Address + " not loaded.")));
						}
					}
					
					Account = oCt.Account;
					Anniversary = oCt.Anniversary;
					Application = (string) (oCt.Application.ToString());
					AssistantName = oCt.AssistantName;
					AssistantTelephoneNumber = oCt.AssistantTelephoneNumber;
					BillingInformation = oCt.BillingInformation;
					Birthday = oCt.Birthday;
					Business2TelephoneNumber = oCt.Business2TelephoneNumber;
					BusinessAddress = oCt.BusinessAddress;
					BusinessAddressCity = oCt.BusinessAddressCity;
					BusinessAddressCountry = oCt.BusinessAddressCountry;
					BusinessAddressPostalCode = oCt.BusinessAddressPostalCode;
					BusinessAddressPostOfficeBox = oCt.BusinessAddressPostOfficeBox;
					BusinessAddressState = oCt.BusinessAddressState;
					BusinessAddressStreet = oCt.BusinessAddressStreet;
					BusinessCardType = oCt.BusinessCardType;
					BusinessFaxNumber = oCt.BusinessFaxNumber;
					BusinessHomePage = oCt.BusinessHomePage;
					BusinessTelephoneNumber = oCt.BusinessTelephoneNumber;
					CallbackTelephoneNumber = oCt.CallbackTelephoneNumber;
					CarTelephoneNumber = oCt.CarTelephoneNumber;
					Categories = oCt.Categories;
					Children = oCt.Children;
					xClass = oCt.Class;
					Companies = oCt.Companies;
					CompanyName = oCt.CompanyName;
					ComputerNetworkName = oCt.ComputerNetworkName;
					Conflicts = (string) (oCt.Conflicts.ToString());
					ConversationTopic = oCt.ConversationTopic;
					CreationTime = oCt.CreationTime;
					CustomerID = oCt.CustomerID;
					Department = oCt.Department;
					
					if (Email1Address == null)
					{
						Email1Address = " ";
					}
					if (Email1Address.Trim().Length == 0 || Email1Address == null)
					{
						Email1Address = " ";
					}
					Email1AddressType = oCt.Email1AddressType;
					Email1DisplayName = oCt.Email1DisplayName;
					Email1EntryID = oCt.Email1EntryID;
					Email2Address = oCt.Email2Address;
					Email2AddressType = oCt.Email2AddressType;
					Email2DisplayName = oCt.Email2DisplayName;
					Email2EntryID = oCt.Email2EntryID;
					Email3Address = oCt.Email3Address;
					Email3AddressType = oCt.Email3AddressType;
					Email3DisplayName = oCt.Email3DisplayName;
					Email3EntryID = oCt.Email3EntryID;
					FileAs = oCt.FileAs;
					FirstName = oCt.FirstName;
					FTPSite = oCt.FTPSite;
					
					Gender = oCt.Gender;
					GovernmentIDNumber = oCt.GovernmentIDNumber;
					Hobby = oCt.Hobby;
					Home2TelephoneNumber = oCt.Home2TelephoneNumber;
					HomeAddress = oCt.HomeAddress;
					HomeAddressCountry = oCt.HomeAddressCountry;
					HomeAddressPostalCode = oCt.HomeAddressPostalCode;
					HomeAddressPostOfficeBox = oCt.HomeAddressPostOfficeBox;
					HomeAddressState = oCt.HomeAddressState;
					HomeAddressStreet = oCt.HomeAddressStreet;
					HomeFaxNumber = oCt.HomeFaxNumber;
					HomeTelephoneNumber = oCt.HomeTelephoneNumber;
					IMAddress = oCt.IMAddress;
					Importance = oCt.Importance;
					Initials = oCt.Initials;
					InternetFreeBusyAddress = oCt.InternetFreeBusyAddress;
					JobTitle = oCt.JobTitle;
					Journal = oCt.Journal.ToString();
					Language = oCt.Language;
					LastModificationTime = oCt.LastModificationTime;
					
					if (LastModificationTime > SkipArchiveDate)
					{
						//** Write out a new last mod date
						saveLastContactArchiveDate(LastModificationTime.ToString());
					}
					else
					{
						goto SkipContact;
					}
					
					LastName = oCt.LastName;
					LastNameAndFirstName = oCt.LastNameAndFirstName;
					MailingAddress = oCt.MailingAddress;
					MailingAddressCity = oCt.MailingAddressCity;
					MailingAddressCountry = oCt.MailingAddressCountry;
					MailingAddressPostalCode = oCt.MailingAddressPostalCode;
					MailingAddressPostOfficeBox = oCt.MailingAddressPostOfficeBox;
					MailingAddressState = oCt.MailingAddressState;
					MailingAddressStreet = oCt.MailingAddressStreet;
					ManagerName = oCt.ManagerName;
					MiddleName = oCt.MiddleName;
					Mileage = oCt.Mileage;
					MobileTelephoneNumber = oCt.MobileTelephoneNumber;
					NetMeetingAlias = oCt.NetMeetingAlias;
					NetMeetingServer = oCt.NetMeetingServer;
					NickName = oCt.NickName;
					Title = oCt.Title;
					Body = oCt.Body;
					OfficeLocation = oCt.OfficeLocation;
					Subject = oCt.Subject;
					
					CNTCT.setAccount(Account);
					CNTCT.setAnniversary(Anniversary);
					CNTCT.setApplication(Application);
					CNTCT.setAssistantname(AssistantName);
					CNTCT.setAssistanttelephonenumber(AssistantTelephoneNumber);
					CNTCT.setBillinginformation(BillingInformation);
					CNTCT.setBirthday(Birthday);
					CNTCT.setBusiness2telephonenumber(Business2TelephoneNumber);
					CNTCT.setBusinessaddress(BusinessAddress);
					CNTCT.setBusinessaddresscity(BusinessAddressCity);
					CNTCT.setBusinessaddresscountry(BusinessAddressCountry);
					CNTCT.setBusinessaddresspostalcode(BusinessAddressPostalCode);
					CNTCT.setBusinessaddresspostofficebox(BusinessAddressPostOfficeBox);
					CNTCT.setBusinessaddressstate(BusinessAddressState);
					CNTCT.setBusinessaddressstreet(BusinessAddressStreet);
					CNTCT.setBusinesscardtype(BusinessCardType);
					CNTCT.setBusinessfaxnumber(BusinessFaxNumber);
					CNTCT.setBusinesshomepage(BusinessHomePage);
					CNTCT.setBusinesstelephonenumber(BusinessTelephoneNumber);
					CNTCT.setCallbacktelephonenumber(CallbackTelephoneNumber);
					CNTCT.setCartelephonenumber(CarTelephoneNumber);
					CNTCT.setCategories(Categories);
					CNTCT.setChildren(Children);
					CNTCT.setXclass(xClass);
					CNTCT.setCompanies(Companies);
					CNTCT.setCompanyname(CompanyName);
					CNTCT.setComputernetworkname(ComputerNetworkName);
					CNTCT.setConflicts(Conflicts);
					CNTCT.setConversationtopic(ConversationTopic);
					CNTCT.setCreationtime(CreationTime);
					CNTCT.setCustomerid(CustomerID);
					CNTCT.setDepartment(Department);
					CNTCT.setEmail1address(Email1Address);
					CNTCT.setEmail1addresstype(Email1AddressType);
					CNTCT.setEmail1displayname(Email1DisplayName);
					CNTCT.setEmail1entryid(Email1EntryID);
					CNTCT.setEmail2address(Email2Address);
					CNTCT.setEmail2addresstype(Email2AddressType);
					CNTCT.setEmail2displayname(Email2DisplayName);
					CNTCT.setEmail2entryid(Email2EntryID);
					CNTCT.setEmail3address(Email3Address);
					CNTCT.setEmail3addresstype(Email3AddressType);
					CNTCT.setEmail3displayname(Email3DisplayName);
					CNTCT.setEmail3entryid(Email3EntryID);
					CNTCT.setFileas(FileAs);
					CNTCT.setFirstname(FirstName);
					CNTCT.setFtpsite(FTPSite);
					CNTCT.setFullname(FullName);
					CNTCT.setGender(Gender);
					CNTCT.setGovernmentidnumber(GovernmentIDNumber);
					CNTCT.setHobby(Hobby);
					CNTCT.setHome2telephonenumber(Home2TelephoneNumber);
					CNTCT.setHomeaddress(HomeAddress);
					CNTCT.setHomeaddresscountry(HomeAddressCountry);
					CNTCT.setHomeaddresspostalcode(HomeAddressPostalCode);
					CNTCT.setHomeaddresspostofficebox(HomeAddressPostOfficeBox);
					CNTCT.setHomeaddressstate(HomeAddressState);
					CNTCT.setHomeaddressstreet(HomeAddressStreet);
					CNTCT.setHomefaxnumber(HomeFaxNumber);
					CNTCT.setHometelephonenumber(HomeTelephoneNumber);
					CNTCT.setImaddress(IMAddress);
					CNTCT.setImportance(Importance);
					CNTCT.setInitials(Initials);
					CNTCT.setInternetfreebusyaddress(InternetFreeBusyAddress);
					CNTCT.setJobtitle(JobTitle);
					CNTCT.setJournal(Journal);
					CNTCT.setLanguage(Language);
					CNTCT.setLastmodificationtime(LastModificationTime);
					CNTCT.setLastname(LastName);
					CNTCT.setLastnameandfirstname(LastNameAndFirstName);
					CNTCT.setMailingaddress(MailingAddress);
					CNTCT.setMailingaddresscity(MailingAddressCity);
					CNTCT.setMailingaddresscountry(MailingAddressCountry);
					CNTCT.setMailingaddresspostalcode(MailingAddressPostalCode);
					CNTCT.setMailingaddresspostofficebox(MailingAddressPostOfficeBox);
					CNTCT.setMailingaddressstate(MailingAddressState);
					CNTCT.setMailingaddressstreet(MailingAddressStreet);
					CNTCT.setManagername(ManagerName);
					CNTCT.setMiddlename(MiddleName);
					CNTCT.setMileage(Mileage);
					CNTCT.setMobiletelephonenumber(MobileTelephoneNumber);
					CNTCT.setNetmeetingalias(NetMeetingAlias);
					CNTCT.setNetmeetingserver(NetMeetingServer);
					CNTCT.setNickname(NickName);
					CNTCT.setTitle(Title);
					CNTCT.setBody(Body);
					CNTCT.setOfficelocation(OfficeLocation);
					CNTCT.setSubject(Subject);
					if (modGlobals.gCurrUserGuidID.Trim().Length == 0)
					{
						modGlobals.gCurrUserGuidID = getUserGuidID(modGlobals.gCurrLoginID);
					}
					CNTCT.setUserid(modGlobals.gCurrUserGuidID);
					
					System.Windows.Forms.Application.DoEvents();
					
					//Email1Address = UTIL.RemoveSingleQuotes(Email1Address)
					//FullName = UTIL.RemoveSingleQuotes(FullName)
					
					//Dim bContact As Boolean = DBLocal.contactExists(FullName, Email1Address)
					
					//If bContact Then
					//    GoTo SkipContact
					//Else
					//    bContact = DBLocal.addContact(FullName, Email1Address)
					//    Dim b As Boolean = CNTCT.Insert()
					//    If Not b Then
					//        LOG.WriteToArchiveLog("ERROR 100 Contact " & FullName + " / " + Email1Address + " not loaded.")
					//    End If
					//End If
					
					
					System.Windows.Forms.Application.DoEvents();
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("Error: " + ex.Message));
					LOG.WriteToArchiveLog((string) ("Contact " + (FullName + " / " + Email1Address + " not loaded.")));
				}
				
SkipContact:
				1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
			}
			
			Console.WriteLine(iCount);
			
			// Clean up.
			FrmInfo.Close();
			FrmInfo.Dispose();
			oApp = null;
			oItems = null;
			oCt = null;
			GC.Collect();
			//frmReconMain.PB1.Value = 0
			//frmReconMain.SB.Text = "Complete, " + I.ToString + " contacts processed."
			LOG.WriteToArchiveLog("INFO: Contact archive Complete, " + I.ToString() + " contacts processed.");
		}
		
		public void RetrieveContactEmailInfo(System.Windows.Forms.DataGridView DG, string UID)
		{
			// Create Outlook application.
			Outlook.Application oApp = new Outlook.Application();
			
			// Get namespace and Contacts folder reference.
			Outlook.NameSpace oNS = oApp.GetNamespace("MAPI");
			Outlook.MAPIFolder cContacts = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderContacts);
			
			// Get the first contact from the Contacts folder.
			Outlook.Items oItems = cContacts.Items;
			Outlook.ContactItem oCt;
			int K = oItems.Count;
			int iCount;
			iCount = 0;
			try
			{
				DG.Rows.Clear();
			}
			catch (Exception)
			{
				Console.WriteLine("Moving on...");
			}
			
			DG.Columns.Add("ea", "Email Address");
			DG.Columns["ea"].Width = 150;
			DG.Columns.Add("fn", "Full Name");
			DG.Columns["fn"].Width = 250;
			DG.Columns.Add("UserID", "UserID");
			DG.Columns["UserID"].Width = 75;
			
			//DG.Columns(0).HeaderText = "Email Address"
			//DG.Columns(1).HeaderText = "Full Name"
			//DG.Columns(2).HeaderText = "UserID"
			
			for (int i = 0; i <= K - 1; i++)
			{
				try
				{
					DG.Rows.Add();
					oCt = oItems(i);
					if (i % 25 == 0)
					{
						if (xDebug)
						{
							LOG.WriteToArchiveLog("Row# " + i.ToString());
						}
					}
					//Console.WriteLine(oCt.FullName)
					//Console.WriteLine(oCt.Email1Address)
					//Console.WriteLine("ROWS = " & DG.Rows.Count)
					string SenderEmailAddress = oCt.Email1Address;
					string SenderName = oCt.FullName;
					//DG.Rows(iCount).Cells("UserID").Value = UID
					
					string MySql = "";
					MySql = MySql + " SELECT count(*) as cnt";
					MySql = MySql + " FROM  [ContactFrom]";
					MySql = MySql + " where FromEmailAddr = \'" + SenderEmailAddress + "\'";
					MySql = MySql + " and SenderName = \'" + SenderName + "\'";
					MySql = MySql + " and UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
					
					if (SenderEmailAddress.Trim().Length > 0)
					{
						int bb = iDataExist(MySql);
						
						if (bb > 0)
						{
							MySql = MySql + " Update  [ContactFrom]";
							MySql = MySql + " set [Verified] = 1 ";
							MySql = MySql + " where FromEmailAddr = \'" + SenderEmailAddress + "\'";
							MySql = MySql + " and SenderName = \'" + SenderName + "\'";
							MySql = MySql + " and UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
							bool bSuccess = ExecuteSqlNewConn(MySql, false);
							if (! bSuccess)
							{
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("Update failed:" + "\r\n" + MySql));
								}
							}
						}
						else
						{
							MySql = MySql + " INSERT INTO  [ContactFrom]";
							MySql = MySql + " ([FromEmailAddr]";
							MySql = MySql + " ,[SenderName]";
							MySql = MySql + " ,[UserID]";
							MySql = MySql + " ,[Verified])";
							MySql = MySql + " VALUES (";
							MySql = MySql + "\'" + SenderEmailAddress + "\',";
							MySql = MySql + " \'" + SenderName + "\',";
							MySql = MySql + " \'" + modGlobals.gCurrUserGuidID + "\',";
							MySql = MySql + " 1)";
							bool bSuccess = ExecuteSqlNewConn(MySql, false);
							if (! bSuccess)
							{
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("Insert failed:" + "\r\n" + MySql));
								}
							}
						}
					}
					
					Application.DoEvents();
					
					iCount++;
				}
				catch (Exception ex)
				{
					Console.WriteLine("Error: " + ex.Message);
					Console.WriteLine("Contact " + i.ToString() + " not loaded.");
				}
			}
			
			Console.WriteLine(iCount);
			
			// Clean up.
			oApp = null;
			oItems = null;
			oCt = null;
			
			GC.Collect();
			
		}
		public void PopulateExcludedSendersFromTbl(System.Windows.Forms.DataGridView DG)
		{
			
			string FromEmailAddr = "";
			string SenderName = "";
			string UserID = "";
			
			string S = "";
			S = S + " SELECT [FromEmailAddr],[SenderName],[UserID] ";
			S = S + " FROM  [ExcludeFrom]";
			S = S + " where UserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
			S = S + " order by [FromEmailAddr],[SenderName]";
			
			int iCount;
			iCount = 0;
			try
			{
				DG.Rows.Clear();
			}
			catch (Exception)
			{
				Console.WriteLine("Moving on...");
			}
			
			DG.Columns.Add("ea", "Email Address");
			DG.Columns["ea"].Width = 150;
			DG.Columns.Add("fn", "Full Name");
			DG.Columns["fn"].Width = 250;
			DG.Columns.Add("UserID", "UserID");
			DG.Columns["UserID"].Width = 75;
			
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			
			if (rsData.HasRows)
			{
				while (rsData.Read())
				{
					FromEmailAddr = rsData.GetValue(0).ToString();
					SenderName = rsData.GetValue(1).ToString();
					UserID = rsData.GetValue(2).ToString();
					try
					{
						DG.Rows.Add();
						//if xDebug then log.WriteToArchiveLog(FromEmailAddr )
						//Console.WriteLine("ROWS = " & DG.Rows.Count)
						DG.Rows[iCount].Cells["ea"].Value = FromEmailAddr;
						DG.Rows[iCount].Cells["fn"].Value = SenderName;
						DG.Rows[iCount].Cells["UserID"].Value = UserID;
						iCount++;
					}
					catch (Exception ex)
					{
						Console.WriteLine("Error: " + ex.Message);
						Console.WriteLine("Contact " + FromEmailAddr + " not loaded.");
					}
					Application.DoEvents();
				}
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			command.Dispose();
			command = null;
			
			if (CONN.State == ConnectionState.Open)
			{
				CONN.Close();
			}
			CONN.Dispose();
			
			Console.WriteLine(iCount);
			GC.Collect();
		}
		public void PopulateContactGridOutlookFromTbl(System.Windows.Forms.DataGridView DG)
		{
			
			string FromEmailAddr = "";
			string SenderName = "";
			string UserID = "";
			
			string S = "";
			S = S + " SELECT [FromEmailAddr],[SenderName],[UserID] ";
			S = S + " FROM  [OutlookFrom]";
			S = S + " where UserID = \'" + modGlobals.gCurrUserGuidID + "\' and Verified = 1 ";
			S = S + " order by [FromEmailAddr],[SenderName]";
			
			int iCount;
			iCount = 0;
			try
			{
				DG.Rows.Clear();
			}
			catch (Exception)
			{
				Console.WriteLine("Moving on...");
			}
			
			DG.Columns.Add("ea", "Email Address");
			DG.Columns["ea"].Width = 150;
			DG.Columns.Add("fn", "Full Name");
			DG.Columns["fn"].Width = 250;
			DG.Columns.Add("UserID", "UserID");
			DG.Columns["UserID"].Width = 75;
			
			SqlDataReader rsData = null;
			
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			
			if (rsData.HasRows)
			{
				while (rsData.Read())
				{
					FromEmailAddr = rsData.GetValue(0).ToString();
					SenderName = rsData.GetValue(1).ToString();
					UserID = rsData.GetValue(2).ToString();
					try
					{
						DG.Rows.Add();
						//if xDebug then log.WriteToArchiveLog(FromEmailAddr )
						//Console.WriteLine("ROWS = " & DG.Rows.Count)
						DG.Rows[iCount].Cells["ea"].Value = FromEmailAddr;
						DG.Rows[iCount].Cells["fn"].Value = SenderName;
						DG.Rows[iCount].Cells["UserID"].Value = UserID;
						iCount++;
					}
					catch (Exception ex)
					{
						Console.WriteLine("Error: " + ex.Message);
						Console.WriteLine("Contact " + FromEmailAddr + " not loaded.");
					}
					Application.DoEvents();
				}
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			command.Dispose();
			command = null;
			
			if (CONN.State == ConnectionState.Open)
			{
				CONN.Close();
			}
			CONN.Dispose();
			
			Console.WriteLine(iCount);
			GC.Collect();
		}
		
		public void PopulateContactGridContactFromTbl(System.Windows.Forms.DataGridView DG)
		{
			
			string FromEmailAddr = "";
			string SenderName = "";
			string UserID = "";
			
			string S = "";
			S = S + " SELECT [FromEmailAddr],[SenderName],[UserID] ";
			S = S + " FROM  [ContactFrom]";
			S = S + " where UserID = \'" + modGlobals.gCurrUserGuidID + "\' and Verified = 1 ";
			S = S + " order by [FromEmailAddr],[SenderName]";
			
			int iCount;
			iCount = 0;
			try
			{
				DG.Rows.Clear();
			}
			catch (Exception)
			{
				Console.WriteLine("Moving on...");
			}
			
			DG.Columns.Add("ea", "Email Address");
			DG.Columns["ea"].Width = 150;
			DG.Columns.Add("fn", "Full Name");
			DG.Columns["fn"].Width = 250;
			DG.Columns.Add("UserID", "UserID");
			DG.Columns["UserID"].Width = 75;
			
			SqlDataReader rsData = null;
			
			
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			
			if (rsData.HasRows)
			{
				while (rsData.Read())
				{
					FromEmailAddr = rsData.GetValue(0).ToString();
					SenderName = rsData.GetValue(1).ToString();
					UserID = rsData.GetValue(2).ToString();
					try
					{
						DG.Rows.Add();
						//if xDebug then log.WriteToArchiveLog(FromEmailAddr )
						//Console.WriteLine("ROWS = " & DG.Rows.Count)
						DG.Rows[iCount].Cells["ea"].Value = FromEmailAddr;
						DG.Rows[iCount].Cells["fn"].Value = SenderName;
						DG.Rows[iCount].Cells["UserID"].Value = UserID;
						iCount++;
					}
					catch (Exception ex)
					{
						Console.WriteLine("Error: " + ex.Message);
						Console.WriteLine("Contact " + FromEmailAddr + " not loaded.");
					}
					Application.DoEvents();
				}
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			command.Dispose();
			command = null;
			
			if (CONN.State == ConnectionState.Open)
			{
				CONN.Close();
			}
			CONN.Dispose();
			
			Console.WriteLine(iCount);
			GC.Collect();
		}
		
		public void PopulateContactGrid(System.Windows.Forms.DataGridView DG, string S)
		{
			
			string FromEmailAddr = "";
			string SenderName = "";
			string UserID = "";
			
			int iCount;
			iCount = 0;
			try
			{
				DG.Rows.Clear();
				DG.Columns.Clear();
			}
			catch (Exception)
			{
				Console.WriteLine("Moving on...");
			}
			
			DG.Columns.Add("ea", "Email Address");
			DG.Columns["ea"].Width = 150;
			DG.Columns.Add("fn", "Full Name");
			DG.Columns["fn"].Width = 250;
			DG.Columns.Add("UserID", "UserID");
			DG.Columns["UserID"].Width = 75;
			
			SqlDataReader rsData = null;
			
			
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			
			if (rsData.HasRows)
			{
				while (rsData.Read())
				{
					FromEmailAddr = rsData.GetValue(0).ToString();
					SenderName = rsData.GetValue(1).ToString();
					UserID = modGlobals.gCurrUserGuidID;
					try
					{
						DG.Rows.Add();
						//if xDebug then log.WriteToArchiveLog(FromEmailAddr )
						//Console.WriteLine("ROWS = " & DG.Rows.Count)
						DG.Rows[iCount].Cells["ea"].Value = FromEmailAddr;
						DG.Rows[iCount].Cells["fn"].Value = SenderName;
						DG.Rows[iCount].Cells["UserID"].Value = UserID;
						iCount++;
					}
					catch (Exception ex)
					{
						Console.WriteLine("Error: " + ex.Message);
						Console.WriteLine("Contact " + FromEmailAddr + " not loaded.");
					}
					Application.DoEvents();
				}
			}
			
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			command.Dispose();
			command = null;
			
			if (CONN.State == ConnectionState.Open)
			{
				CONN.Close();
			}
			CONN.Dispose();
			
			Console.WriteLine(iCount);
			GC.Collect();
		}
		
		/// <summary>
		/// Gets an email's attachments
		/// </summary>
		/// <param name="FolderName"></param>
		/// <remarks></remarks>
		public void GetAttachments(string FolderName)
		{
			
			string filename = "";
			Outlook.Application objOL;
			Outlook.NameSpace objNS;
			//Dim objFolder As Outlook.Folders
			//Dim Item As Object
			Outlook.Items myItems;
			short x;
			
			objOL = new Outlook.Application();
			objNS = objOL.GetNamespace("MAPI");
			
			Outlook.MAPIFolder olfolder;
			olfolder = objOL.GetNamespace("MAPI").PickFolder();
			myItems = olfolder.Items;
			
			int i = 0;
			for (x = 1; x <= myItems.Count; x++)
			{
				string EmailSenderName = (string) (myItems[x].SenderName);
				string EmailSenderEmailAddress = (string) (myItems[x].SenderEmailAddress);
				string EmailSubject = (string) (myItems[x].Subject);
				
				string EmailBody = (string) (myItems[x].Body);
				string FullBody;
				//*************** DO NOT SAVE THE WHOLE BODY, JUST THE FIRST 100 CHARACTERS *****************
				//EmailBody = EmailBody.Substring(0, 100)
				//*******************************************************************************************
				
				string EmailTo = (string) (myItems[x].to);
				string EmailReceivedByName = (string) (myItems[x].ReceivedByName);
				string EmailReceivedOnBehalfOfName = (string) (myItems[x].ReceivedOnBehalfOfName);
				string EmailReplyRecipientNames = (string) (myItems[x].ReplyRecipientNames);
				string EmailSentOnBehalfOfName = (string) (myItems[x].SentOnBehalfOfName);
				string EmailCC = (string) (myItems[x].CC);
				string EmailReceivedTime = (string) (myItems[x].ReceivedTime);
				
				Outlook.Attachment Atmt;
				foreach (Outlook.Attachment tempLoopVar_Atmt in myItems[x].Attachments)
				{
					Atmt = tempLoopVar_Atmt;
					filename = DMA.getEnvVarTempDir() + "\\" + Atmt.FileName;
					Atmt.SaveAsFile(filename);
				}
				
			}
			
		}
		public string OutlookFolderNames(string MailboxName, bool bTest)
		{
			try
			{
				//********************************************************
				//PARAMETER: MailboxName = Name of Parent Outlook Folder for
				//the current user: Usually in the form of
				//"Mailbox - Doe, John" or
				//"Public Folders
				//RETURNS: Array of SubFolders in Current User's Mailbox
				//Or unitialized array if error occurs
				//Because it returns an array, it is for VB6 only.
				//Change to return a variant or a delimited list for
				//previous versions of vb
				//EXAMPLE:
				//Dim sArray() As String
				//Dim ictr As Integer
				//sArray = OutlookFolderNames("Mailbox - Doe, John")
				//            'On Error Resume Next
				//For ictr = 0 To UBound(sArray)
				// if xDebug then log.WriteToArchiveLog sArray(ictr)
				//Next
				//*********************************************************
				Outlook.Application oOutlook;
				Outlook._NameSpace oMAPI;
				Outlook.MAPIFolder oParentFolder;
				string[] sArray;
				int i;
				int iElement = 0;
				
				oOutlook = new Outlook.Application();
				oMAPI = oOutlook.GetNamespace("MAPI");
				MailboxName = "Personal Folders";
				oParentFolder = oMAPI.Folders[MailboxName];
				
				Array.Resize(ref sArray, 1);
				
				if (oParentFolder.Folders.Count != 0)
				{
					for (i = 1; i <= oParentFolder.Folders.Count; i++)
					{
						if (Strings.Trim(oParentFolder.Folders[i].Name) != "")
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) (oParentFolder.Folders[i].Name));
							}
							//If Trim(oMAPI.GetDefaultFolder(OlDefaultFolders.olFolderInbox).Folders.Item(i).Name) <> "" Then
							//     If sArray(0) = "" Then
							//          iElement = 0
							//     Else
							//          iElement = UBound(sArray) + 1
							//     End If
							//     ReDim Preserve sArray(iElement)
							//     sArray(iElement) = oParentFolder.Folders.Item(i).Name
							//End If
						}
					}
				}
				else
				{
					sArray[0] = oParentFolder.Name;
				}
				
				
				
				//OutlookFolderNames = sArray
				oMAPI = null;
				GC.Collect();
			}
			catch (Exception ex)
			{
				MessageBox.Show(ex.Message);
			}
			GC.Collect();
			GC.WaitForFullGCComplete();
			return "";
		}
		
		public void RegisterOutlookContainer()
		{
			
			Outlook.Application oOutlook = new Outlook.Application();
			Outlook.NameSpace oMAPI = null;
			Outlook.MAPIFolder oParentFolder = null;
			Outlook.MAPIFolder oChildFolder = null;
			List<string> Containers = new List<string>();
			
			//RegisterAllContainers(Containers)
			try
			{
				oMAPI = oMAPI.GetNamespace("MAPI");
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR : RegisterOutlookContainers 200 - " + ex.Message));
				return;
			}
			
			int iFolderCount = oMAPI.Folders.Count;
			foreach (Outlook.MAPIFolder MF in oMAPI.Folders)
			{
				if (dDebug)
				{
					Console.WriteLine(MF.Name);
				}
				Containers.Add(MF.Name);
			}
			
			foreach (string Container in Containers)
			{
				//RegisterChildFolders(ByVal Container , ByVal oChildFolder As Outlook.MAPIFolder, ByVal FQN )
				try
				{
					oParentFolder = oMAPI.Folders[Container];
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("ERROR: RegisterOutlookContainers 100 - " + ex.Message));
				}
				
				foreach (Outlook.MAPIFolder tempLoopVar_oChildFolder in oParentFolder.Folders)
				{
					oChildFolder = tempLoopVar_oChildFolder;
					int K = 0;
					K = oChildFolder.Folders.Count;
					string cFolder = oChildFolder.Name.ToString();
					if (xDebug)
					{
						LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 010: \'" + cFolder + "\'.");
					}
					//LB.Items.Add(cFolder )
					if (K > 0)
					{
						RegisterChildFolders(Container, oChildFolder, cFolder);
					}
				}
			}
			
			oOutlook = null;
			oMAPI = null;
			oParentFolder = null;
			oChildFolder = null;
			Containers = null;
			
			
		}
		
		public void RegisterAllContainers(List<string> Containers)
		{
			bool bOfficeInstalled = true;
			
			bool B = false;
			
			Containers.Clear();
			
			Outlook.Application oOutlook;
			Outlook.NameSpace oMAPI = null;
			Outlook.MAPIFolder oParentFolder = null;
			Outlook.MAPIFolder oChildFolder = null;
			//Dim sArray() As String
			int i;
			int iElement = 0;
			
			oOutlook = new Outlook.Application();
			try
			{
				oMAPI = oOutlook.GetNamespace("MAPI");
			}
			catch (Exception ex)
			{
				MessageBox.Show(ex.Message);
			}
			
			int iFolderCount = oMAPI.Folders.Count;
			foreach (Outlook.MAPIFolder MF in oMAPI.Folders)
			{
				if (dDebug)
				{
					Console.WriteLine(MF.Name);
				}
				Containers.Add(MF.Name);
			}
			
			oOutlook = null;
			oMAPI = null;
			oParentFolder = null;
			oChildFolder = null;
			
		}
		
		public void GetContainerFolders(List<string> Containers, List<string> EmailFolders)
		{
			bool bOfficeInstalled = true;
			
#if Office2007
			bOfficeInstalled = UTIL.isOffice2007Installed();
#else
			bOfficeInstalled = UTIL.isOffice2003Installed();
#endif
			
			if (bOfficeInstalled == false)
			{
				return;
			}
			
			bool B = false;
			
			
			if (xDebug)
			{
				LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 001: ");
			}
			
			EmailFolders.Clear();
			
			//********************************************************
			//PARAMETER: MailboxName = Name of Parent Outlook Folder for
			//the current user: Usually in the form of
			//"Mailbox - Doe, John" or
			//"Public Folders
			//RETURNS: Array of SubFolders in Current User's Mailbox
			//Or unitialized array if error occurs
			//Because it returns an array, it is for VB6 only.
			//Change to return a variant or a delimited list for
			//previous versions of vb
			//EXAMPLE:
			//Dim sArray() As String
			//Dim ictr As Integer
			//sArray = OutlookFolderNames("Mailbox - Doe, John")
			//        'On Error Resume Next
			//For ictr = 0 To UBound(sArray)
			// if xDebug then log.WriteToArchiveLog sArray(ictr)
			//Next
			//*********************************************************
			Outlook.Application oOutlook;
			Outlook.NameSpace oMAPI = null;
			Outlook.MAPIFolder oParentFolder = null;
			Outlook.MAPIFolder oChildFolder = null;
			//Dim sArray() As String
			int i;
			int iElement = 0;
			
			oOutlook = new Outlook.Application();
			try
			{
				oMAPI = oOutlook.GetNamespace("MAPI");
			}
			catch (Exception ex)
			{
				MessageBox.Show(ex.Message);
			}
			
			foreach (string Container in Containers)
			{
				
				if (xDebug)
				{
					LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 002: \'" + Container + "\'.");
				}
				
				List<string> aFolders = new List<string>();
				int iFolderCount = oMAPI.Folders.Count;
				
				try
				{
					oParentFolder = oMAPI.Folders[Container];
					for (i = 1; i <= oParentFolder.Folders.Count; i++)
					{
						
						Console.WriteLine(oParentFolder.Folders[i].Name);
						
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("clsArchiver:getOutlookFolderNames 003: \'" + oParentFolder.Folders[i].Name));
						}
						
						bool isEmailFolder = false;
						int NbrOfItemsTested = 0;
						if (oParentFolder.Folders(i) is Outlook.MAPIFolder)
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 004: \'" + oParentFolder.Folders[i].Name);
							}
							foreach (object Obj in oParentFolder.Folders(i).Items)
							{
								NbrOfItemsTested++;
								Console.WriteLine(Obj.ToString());
								if (Obj is Outlook.MailItem)
								{
									if (xDebug)
									{
										LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 005: \'" + oParentFolder.Folders[i].Name);
									}
									isEmailFolder = true;
									break;
								}
								else
								{
									if (xDebug)
									{
										LOG.WriteToArchiveLog((string) ("clsArchiver:getOutlookFolderNames 006: \'" + oParentFolder.Folders[i].Name));
									}
									if (NbrOfItemsTested > 10)
									{
										isEmailFolder = false;
										break;
									}
								}
							}
							if (isEmailFolder == false)
							{
								LOG.WriteToArchiveLog((string) ("WARNING: THIS FOLDER COULD NOT BE VERIFIED TO BE AN EMAIL FOLDER. It will be processed as if it is as it has been selected by a user: " + oParentFolder.Folders[i].Name));
								isEmailFolder = true;
							}
						}
						else
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("clsArchiver:getOutlookFolderNames 007: \'" + oParentFolder.Folders[i].Name));
							}
						}
						
						if (NbrOfItemsTested == 0)
						{
							isEmailFolder = true;
						}
						
						if (isEmailFolder == true)
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 008: \'" + oParentFolder.Folders[i].Name + " : Appears to be an email folder.");
							}
						}
						else
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 008: \'" + oParentFolder.Folders[i].Name + " : Appears NOT to be an email folder.");
							}
							goto SkipThisNonEmailFolder;
						}
						
						//If TypeOf oParentFolder Is Outlook.MailItem Then
						//    Console.WriteLine(oParentFolder.Folders.Item(i).Name)
						//End If
						
						if (Strings.Trim(oParentFolder.Folders[i].Name) != "")
						{
							string StoreID = oParentFolder.StoreID;
#if Office2007
							string StoreName = "";
							try
							{
								StoreName = oParentFolder.Store.DisplayName.ToString();
							}
							catch (Exception)
							{
								StoreName = "Not Available";
							}
							if (xDebug)
							{
								LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 009 Office 2007: \'" + StoreName + "\'.");
							}
#else
							string StoreName = "";
							try
							{
								StoreName = oParentFolder.Name;
							}
							catch (Exception)
							{
								StoreName = "Not Available";
							}
							if (xDebug)
							{
								LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 009 Office 2003: \'" + StoreName + "\'.");
							}
#endif
							string ParentID = oParentFolder.EntryID;
							string ChildID = oParentFolder.Folders[i].EntryID;
							string tFolderName = oParentFolder.Folders[i].Name;
							if (xDebug)
							{
								LOG.WriteToArchiveLog(tFolderName);
							}
							Console.WriteLine("Folder: " + tFolderName);
							tFolderName = tFolderName.Trim();
							int II = EMF.cnt_PK_EmailFolder(ChildID, modGlobals.gCurrUserGuidID);
							II = EMF.cnt_UI_EmailFolder(Container, tFolderName, modGlobals.gCurrUserGuidID);
							
							if (II == 0)
							{
								try
								{
									EMF.setFolderid(ref ChildID);
									EMF.setFoldername(ref tFolderName);
									EMF.setParentfolderid(ref ParentID);
									EMF.setParentfoldername(oParentFolder.Name);
									EMF.setUserid(ref modGlobals.gCurrUserGuidID);
									EMF.setStoreid(ref StoreID);
									bool BB = EMF.Insert(Container);
									//If Not BB Then
									//    messagebox.show("Did not add folder " + tFolderName  + " to list of folders...")
									//End If
								}
								catch (Exception ex)
								{
									LOG.WriteToArchiveLog((string) ("ERROR: getOutlookFolderNames 100: " + ex.Message + "\r\n" + "\r\n" + ex.StackTrace));
									LOG.WriteToArchiveLog((string) ("ERROR: getOutlookFolderNames 100: tFolderName  = " + tFolderName + " : " + "oParentFolder.Name = " + oParentFolder.Name));
								}
							}
							else
							{
								string WC = EMF.wc_UI_EmailFolder(Container, tFolderName, modGlobals.gCurrUserGuidID);
								EMF.setFolderid(ref ChildID);
								EMF.setFoldername(ref tFolderName);
								EMF.setParentfolderid(ref ParentID);
								EMF.setParentfoldername(oParentFolder.Name);
								EMF.setUserid(ref modGlobals.gCurrUserGuidID);
								EMF.setStoreid(ref StoreID);
								bool BB = EMF.Insert(Container);
							}
						}
SkipThisNonEmailFolder:
						1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
					}
				}
				catch (Exception ex)
				{
					MessageBox.Show(ex.Message);
				}
			}
			
		}
		
		public bool getOutlookFolderNames(string ContainerName, ref ListBox LB)
		{
			
			bool bOfficeInstalled = true;
			
			try
			{
				bOfficeInstalled = UTIL.isOffice2007Installed();
			}
			catch (Exception)
			{
				try
				{
					bOfficeInstalled = UTIL.isOffice2003Installed();
				}
				catch (Exception)
				{
					bOfficeInstalled = false;
				}
			}
			
			if (bOfficeInstalled == false)
			{
				LB.Items.Clear();
				LB.Items.Add("**ERROR: Missing Office - may not be installed in this machine.");
				LOG.WriteToArchiveLog("**ERROR: Missing Office - may not be installed in this machine.");
			}
			
			bool B = false;
			
			try
			{
				if (xDebug)
				{
					LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 001: ");
				}
				
				LB.Items.Clear();
				
				//********************************************************
				//PARAMETER: MailboxName = Name of Parent Outlook Folder for
				//the current user: Usually in the form of
				//"Mailbox - Doe, John" or
				//"Public Folders
				//RETURNS: Array of SubFolders in Current User's Mailbox
				//Or unitialized array if error occurs
				//Because it returns an array, it is for VB6 only.
				//Change to return a variant or a delimited list for
				//previous versions of vb
				//EXAMPLE:
				//Dim sArray() As String
				//Dim ictr As Integer
				//sArray = OutlookFolderNames("Mailbox - Doe, John")
				//            'On Error Resume Next
				//For ictr = 0 To UBound(sArray)
				// if xDebug then log.WriteToArchiveLog sArray(ictr)
				//Next
				//*********************************************************
				Outlook.Application oOutlook;
				Outlook.NameSpace oMAPI = null;
				Outlook.MAPIFolder oParentFolder = null;
				
				//Dim sArray() As String
				int i;
				int iElement = 0;
				
				oOutlook = new Outlook.Application();
				try
				{
					oMAPI = oOutlook.GetNamespace("MAPI");
				}
				catch (Exception ex)
				{
					MessageBox.Show(ex.Message);
				}
				
				//Dim MailboxName  = System.Configuration.ConfigurationManager.AppSettings("EmailFolder1")
				string MailboxName = "";
				
				MailboxName = ContainerName;
				if (xDebug)
				{
					LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 002: \'" + MailboxName + "\'.");
				}
				
				List<string> OutlookContainers = new List<string>();
				int iFolderCount = oMAPI.Folders.Count;
				
				RegisterAllContainers(OutlookContainers);
				
				try
				{
					oParentFolder = oMAPI.Folders[MailboxName];
				}
				catch (Exception ex)
				{
					MessageBox.Show(ex.Message);
				}
				
				//AddChildFolders(LB, MailboxName )
				
				if (oParentFolder.Folders.Count != 0)
				{
					for (i = 1; i <= oParentFolder.Folders.Count; i++)
					{
						
						Console.WriteLine(oParentFolder.Folders[i].Name);
						
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("clsArchiver:getOutlookFolderNames 003: \'" + oParentFolder.Folders[i].Name));
						}
						
						bool isEmailFolder = false;
						int NbrOfItemsTested = 0;
						if (oParentFolder.Folders(i) is Outlook.MAPIFolder)
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 004: \'" + oParentFolder.Folders[i].Name);
							}
							foreach (object Obj in oParentFolder.Folders(i).Items)
							{
								NbrOfItemsTested++;
								Console.WriteLine(Obj.ToString());
								if (Obj is Outlook.MailItem)
								{
									if (xDebug)
									{
										LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 005: \'" + oParentFolder.Folders[i].Name);
									}
									isEmailFolder = true;
									break;
								}
								else
								{
									if (xDebug)
									{
										LOG.WriteToArchiveLog((string) ("clsArchiver:getOutlookFolderNames 006: \'" + oParentFolder.Folders[i].Name));
									}
									if (NbrOfItemsTested > 10)
									{
										isEmailFolder = false;
										break;
									}
								}
							}
							if (isEmailFolder == false)
							{
								LOG.WriteToArchiveLog((string) ("WARNING: THIS FOLDER COULD NOT BE VERIFIED TO BE AN EMAIL FOLDER. It will be processed as if it is as it has been selected by a user: " + oParentFolder.Folders[i].Name));
								isEmailFolder = true;
							}
						}
						else
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 007: \'" + oParentFolder.Folders[i].Name);
							}
						}
						
						if (NbrOfItemsTested == 0)
						{
							isEmailFolder = true;
						}
						
						if (isEmailFolder == true)
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 008: \'" + oParentFolder.Folders[i].Name + " : Appears to be an email folder.");
							}
						}
						else
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 008: \'" + oParentFolder.Folders[i].Name + " : Appears NOT to be an email folder.");
							}
							goto SkipThisNonEmailFolder;
						}
						
						//If TypeOf oParentFolder Is Outlook.MailItem Then
						//    Console.WriteLine(oParentFolder.Folders.Item(i).Name)
						//End If
						
						if (Strings.Trim(oParentFolder.Folders[i].Name) != "")
						{
							string StoreID = oParentFolder.StoreID;
#if Office2007
							string StoreName = "";
							try
							{
								StoreName = oParentFolder.Store.DisplayName.ToString();
							}
							catch (Exception)
							{
								StoreName = "Not Available";
							}
							if (xDebug)
							{
								LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 009 Office 2007: \'" + StoreName + "\'.");
							}
#else
							string StoreName = "";
							try
							{
								StoreName = oParentFolder.Name;
							}
							catch (Exception)
							{
								StoreName = "Not Available";
							}
							if (xDebug)
							{
								LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 009 Office 2003: \'" + StoreName + "\'.");
							}
#endif
							string ParentID = oParentFolder.EntryID;
							string ChildID = oParentFolder.Folders[i].EntryID;
							string tFolderName = oParentFolder.Folders[i].Name;
							if (xDebug)
							{
								LOG.WriteToArchiveLog(tFolderName);
							}
							Console.WriteLine("Folder: " + tFolderName);
							tFolderName = tFolderName.Trim();
							int II = EMF.cnt_PK_EmailFolder(ChildID, modGlobals.gCurrUserGuidID);
							II = EMF.cnt_UI_EmailFolder(ContainerName, tFolderName, modGlobals.gCurrUserGuidID);
							
							if (II == 0)
							{
								try
								{
									EMF.setFolderid(ref ChildID);
									EMF.setFoldername(ref tFolderName);
									EMF.setParentfolderid(ref ParentID);
									EMF.setParentfoldername(oParentFolder.Name);
									EMF.setUserid(ref modGlobals.gCurrUserGuidID);
									EMF.setStoreid(ref StoreID);
									EMF.setSelectedforarchive("?");
									bool BB = EMF.Insert(ContainerName);
									//If Not BB Then
									//    messagebox.show("Did not add folder " + tFolderName  + " to list of folders...")
									//End If
								}
								catch (Exception ex)
								{
									LOG.WriteToArchiveLog((string) ("ERROR: getOutlookFolderNames 100: " + ex.Message + "\r\n" + "\r\n" + ex.StackTrace));
									LOG.WriteToArchiveLog((string) ("ERROR: getOutlookFolderNames 100: tFolderName  = " + tFolderName + " : " + "oParentFolder.Name = " + oParentFolder.Name));
								}
							}
							else
							{
								string FolderFQN = oParentFolder.Name.Trim() + "|" + tFolderName.Trim();
								string WC = EMF.wc_UI_EmailFolder(ContainerName, FolderFQN, modGlobals.gCurrUserGuidID);
								EMF.setFolderid(ref ChildID);
								EMF.setFoldername(ref FolderFQN);
								EMF.setParentfolderid(ref ParentID);
								EMF.setParentfoldername(oParentFolder.Name);
								EMF.setUserid(ref modGlobals.gCurrUserGuidID);
								EMF.setStoreid(ref StoreID);
								EMF.setSelectedforarchive("?");
								bool BB = EMF.Update(WC);
								if (! BB)
								{
									LOG.WriteToArchiveLog((string) ("ERROR: 102 Failed to update Email Folder : " + ContainerName + " : " + tFolderName));
								}
							}
							LB.Items.Add(oParentFolder.Folders[i].Name);
						}
SkipThisNonEmailFolder:
						1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
					}
				}
				
				foreach (Outlook.MAPIFolder oChildFolder in oParentFolder.Folders)
				{
					int K = 0;
					K = oChildFolder.Folders.Count;
					string cFolder = oChildFolder.Name.ToString();
					if (xDebug)
					{
						LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 010: \'" + cFolder + "\'.");
					}
					//LB.Items.Add(cFolder )
					if (K > 0)
					{
						ListChildFolders(ContainerName, oChildFolder, ref LB, cFolder);
					}
				}
				oMAPI = null;
				GC.Collect();
				B = true;
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 653.21a: " + ex.Message));
				LOG.WriteToArchiveLog("ERROR 653.21a clsArchiver:getOutlookFolderNames 011: \'" + ex.Message + "\'.");
				B = false;
			}
			if (xDebug)
			{
				LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 012.");
			}
			return B;
		}
		public bool getOutlookFolderNames(string TopLevelOutlookFolderName)
		{
			
			bool B = false;
			try
			{
				if (xDebug)
				{
					LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 001: ");
				}
				
				Outlook.Application oOutlook;
				Outlook.NameSpace oMAPI = null;
				Outlook.MAPIFolder oParentFolder = null;
				
				//Dim sArray() As String
				int i;
				int iElement = 0;
				
				oOutlook = new Outlook.Application();
				try
				{
					oMAPI = oOutlook.GetNamespace("MAPI");
				}
				catch (Exception ex)
				{
					MessageBox.Show(ex.Message);
				}
				
				//Dim MailboxName  = System.Configuration.ConfigurationManager.AppSettings("EmailFolder1")
				string MailboxName = "";
				
				MailboxName = TopLevelOutlookFolderName;
				if (xDebug)
				{
					LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 002: \'" + MailboxName + "\'.");
				}
				
				List<string> aFolders = new List<string>();
				int iFolderCount = oMAPI.Folders.Count;
				foreach (Outlook.MAPIFolder MF in oMAPI.Folders)
				{
					Console.WriteLine(MF.Name);
					aFolders.Add(MF.Name);
				}
				
				try
				{
					oParentFolder = oMAPI.Folders[MailboxName];
				}
				catch (Exception ex)
				{
					MessageBox.Show(ex.Message);
				}
				
				//AddChildFolders(LB, MailboxName )
				
				if (oParentFolder.Folders.Count != 0)
				{
					for (i = 1; i <= oParentFolder.Folders.Count; i++)
					{
						
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("clsArchiver:getOutlookFolderNames V2 003: \'" + oParentFolder.Folders[i].Name));
						}
						
						bool isEmailFolder = false;
						int NbrOfItemsTested = 0;
						if (oParentFolder.Folders(i) is Outlook.MAPIFolder)
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("clsArchiver:getOutlookFolderNames V2 004: \'" + oParentFolder.Folders[i].Name));
							}
							foreach (object Obj in oParentFolder.Folders(i).Items)
							{
								NbrOfItemsTested++;
								if (Obj is Outlook.MailItem)
								{
									if (xDebug)
									{
										LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 005: \'" + oParentFolder.Folders[i].Name);
									}
									isEmailFolder = true;
									break;
								}
								else
								{
									if (xDebug)
									{
										LOG.WriteToArchiveLog((string) ("clsArchiver:getOutlookFolderNames V2 006: \'" + oParentFolder.Folders[i].Name));
									}
									if (NbrOfItemsTested > 20)
									{
										break;
									}
								}
							}
						}
						else
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("clsArchiver:getOutlookFolderNames V2 007: \'" + oParentFolder.Folders[i].Name));
							}
						}
						
						if (NbrOfItemsTested == 0)
						{
							isEmailFolder = true;
						}
						
						if (isEmailFolder == true)
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 008: \'" + oParentFolder.Folders[i].Name + " : Appears to be an email folder.");
							}
						}
						else
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 008: \'" + oParentFolder.Folders[i].Name + " : Appears NOT to be an email folder.");
							}
							goto SkipThisNonEmailFolder;
						}
						
						//If TypeOf oParentFolder Is Outlook.MailItem Then
						//    Console.WriteLine(oParentFolder.Folders.Item(i).Name)
						//End If
						
						if (Strings.Trim(oParentFolder.Folders[i].Name) != "")
						{
							string StoreID = oParentFolder.StoreID;
#if Office2007
							string StoreName = (string) (oParentFolder.Store.ToString());
							if (xDebug)
							{
								LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 009 Office 2007: \'" + StoreName + "\'.");
							}
#else
							string StoreName = oParentFolder.Name;
							if (xDebug)
							{
								LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 009 Office 2003: \'" + StoreName + "\'.");
							}
#endif
							string ParentID = oParentFolder.EntryID;
							string ChildID = oParentFolder.Folders[i].EntryID;
							string tFolderName = oParentFolder.Folders[i].Name;
							if (xDebug)
							{
								LOG.WriteToArchiveLog(tFolderName);
							}
							int II = EMF.cnt_PK_EmailFolder(ChildID, modGlobals.gCurrUserGuidID);
							II = EMF.cnt_UI_EmailFolder(TopLevelOutlookFolderName, tFolderName, modGlobals.gCurrUserGuidID);
							if (II == 0)
							{
								EMF.setFolderid(ref ChildID);
								EMF.setFoldername(ref tFolderName);
								EMF.setParentfolderid(ref ParentID);
								EMF.setParentfoldername(oParentFolder.Name);
								EMF.setUserid(ref modGlobals.gCurrUserGuidID);
								EMF.setStoreid(ref StoreID);
								bool BB = EMF.Insert(TopLevelOutlookFolderName);
								//If Not BB Then
								//    messagebox.show("Did not add folder " + tFolderName  + " to list of folders...")
								//End If
							}
						}
SkipThisNonEmailFolder:
						1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
					}
				}
				
				foreach (Outlook.MAPIFolder oChildFolder in oParentFolder.Folders)
				{
					int K = 0;
					K = oChildFolder.Folders.Count;
					string cFolder = oChildFolder.Name.ToString();
					if (xDebug)
					{
						LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 010: \'" + cFolder + "\'.");
					}
					//LB.Items.Add(cFolder )
				}
				oMAPI = null;
				GC.Collect();
				B = true;
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 653.21a2: " + ex.Message));
				LOG.WriteToArchiveLog("ERROR 653.21a2 clsArchiver:getOutlookFolderNames V2 011: \'" + ex.Message + "\'.");
				B = false;
			}
			if (xDebug)
			{
				LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 012.");
			}
			
			return B;
		}
		public bool getOutlookParentFolderNames(ComboBox CB)
		{
			int L = 0;
			bool B = false;
			try
			{
				if (xDebug)
				{
					LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 001: ");
				}
				
				CB.Items.Clear();
				L = 1;
				
				Outlook.Application oOutlook;
				L = 2;
				Outlook.NameSpace oMAPI = null;
				L = 3;
				Outlook.MAPIFolder oParentFolder = null;
				L = 4;
				Outlook.MAPIFolder oChildFolder = null;
				L = 5;
				//Dim sArray() As String
				int i;
				L = 6;
				int iElement = 0;
				L = 7;
				
				oOutlook = new Outlook.Application();
				L = 8;
				try
				{
					oMAPI = oOutlook.GetNamespace("MAPI");
					L = 9;
				}
				catch (Exception ex)
				{
					MessageBox.Show(ex.Message);
				}
				
				string MailboxName = System.Configuration.ConfigurationManager.AppSettings["EmailFolder1"];
				L = 10;
				if (xDebug)
				{
					LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 002: \'" + MailboxName + "\'.");
				}
				L = 11;
				
				List<string> aFolders = new List<string>();
				L = 12;
				int iFolderCount = oMAPI.Folders.Count;
				L = 13;
				foreach (Outlook.MAPIFolder MF in oMAPI.Folders)
				{
					L = 14;
					Console.WriteLine(MF.Name);
					L = 15;
					CB.Items.Add(MF.Name);
					L = 16;
				}
				L = 17;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("getOutlookParentFolderNames 100: L = " + L.ToString() + "\r\n" + "Failed to get the Outlook Containers." + ex.Message));
				MessageBox.Show((string) ("getOutlookParentFolderNames 100: L = " + L.ToString() + "\r\n" + "Failed to get the Outlook Containers." + ex.Message));
				B = false;
			}
			
			return B;
		}
		public ArrayList getOutlookParentFolderNames()
		{
			ArrayList AL = new ArrayList();
			
			bool B = false;
			try
			{
				if (xDebug)
				{
					LOG.WriteToArchiveLog("clsArchiver:getOutlookParentFolderNames 001: ");
				}
				
				Outlook.Application oOutlook;
				Outlook.NameSpace oMAPI = null;
				Outlook.MAPIFolder oParentFolder = null;
				Outlook.MAPIFolder oChildFolder = null;
				
				oOutlook = new Outlook.Application();
				try
				{
					oMAPI = oOutlook.GetNamespace("MAPI");
				}
				catch (Exception ex)
				{
					MessageBox.Show(ex.Message);
				}
				
				string MailboxName = System.Configuration.ConfigurationManager.AppSettings["EmailFolder1"];
				if (xDebug)
				{
					LOG.WriteToArchiveLog("clsArchiver:getOutlookParentFolderNames 002: \'" + MailboxName + "\'.");
				}
				
				List<string> aFolders = new List<string>();
				int iFolderCount = oMAPI.Folders.Count;
				foreach (Outlook.MAPIFolder MF in oMAPI.Folders)
				{
					Console.WriteLine(MF.Name);
					AL.Add(MF.Name);
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("getOutlookParentFolderNames 100: " + ex.Message));
			}
			
			return AL;
		}
		
		public void ProcessOutlookFolderNames(string ContainerName, string TopFolder, ref ListBox LB)
		{
			
			string ArchiveEmails = "";
			string RemoveAfterArchive = "";
			string SetAsDefaultFolder = "";
			string ArchiveAfterXDays = "";
			string RemoveAfterXDays = "";
			string RemoveXDays = "";
			string ArchiveXDays = "";
			string DB_ID = "";
			bool DeleteFile = false;
			
			try
			{
				LB.Items.Clear();
				
				//********************************************************
				//PARAMETER: MailboxName = Name of Parent Outlook Folder for
				//the current user: Usually in the form of
				//"Mailbox - Doe, John" or
				//"Public Folders
				//RETURNS: Array of SubFolders in Current User's Mailbox
				//Or unitialized array if error occurs
				//Because it returns an array, it is for VB6 only.
				//Change to return a variant or a delimited list for
				//previous versions of vb
				//EXAMPLE:
				//Dim sArray() As String
				//Dim ictr As Integer
				//sArray = OutlookFolderNames("Mailbox - Doe, John")
				//            'On Error Resume Next
				//For ictr = 0 To UBound(sArray)
				// if xDebug then log.WriteToArchiveLog sArray(ictr)
				//Next
				//*********************************************************
				Outlook.Application oOutlook;
				Outlook.NameSpace oMAPI = null;
				Outlook.MAPIFolder oParentFolder = null;
				
				//Dim sArray() As String
				int i;
				int iElement = 0;
				bool BB = false;
				
				oOutlook = new Outlook.Application();
				try
				{
					oMAPI = oOutlook.GetNamespace("MAPI");
				}
				catch (Exception ex)
				{
					MessageBox.Show(ex.Message);
				}
				
				string MailboxName = "Personal Folders";
				try
				{
					oParentFolder = oMAPI.Folders[MailboxName];
				}
				catch (Exception ex)
				{
					MessageBox.Show(ex.Message);
				}
				
				//AddChildFolders(LB, MailboxName )
				
				if (oParentFolder.Folders.Count != 0)
				{
					for (i = 1; i <= oParentFolder.Folders.Count; i++)
					{
						if (Strings.Trim(oParentFolder.Folders[i].Name) != "")
						{
							LB.Items.Add(oParentFolder.Folders[i].Name);
							bool B = ckFolderExists(modGlobals.gCurrUserGuidID, oParentFolder.Folders[i].Name, ContainerName);
							if (B)
							{
								Outlook.MAPIFolder CurrMailFolder = oParentFolder.Folders(i);
								if (xDebug)
								{
									LOG.WriteToArchiveLog("MUST Process folder: " + oParentFolder.Folders[i].Name);
								}
								ArchiveEmailsInFolderenders(ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, CurrMailFolder, DeleteFile);
							}
							else
							{
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("IGNORE folder: " + oParentFolder.Folders[i].Name));
								}
							}
						}
					}
				}
				
				foreach (Outlook.MAPIFolder oChildFolder in oParentFolder.Folders)
				{
					int K = 0;
					K = oChildFolder.Folders.Count;
					string cFolder = oChildFolder.Name.ToString();
					//LB.Items.Add(cFolder )
					if (K > 0)
					{
						ListChildFolders(ContainerName, TopFolder, oChildFolder, ref LB, cFolder, BB);
					}
				}
				oMAPI = null;
				GC.Collect();
			}
			catch (Exception ex)
			{
				MessageBox.Show(ex.Message);
			}
			
		}
		
		public void RegisterChildFolders(string Container, Outlook.MAPIFolder oChildFolder, string FQN)
		{
			try
			{
				
				var tFqn = FQN;
				foreach (Outlook.MAPIFolder tFolder in oChildFolder.Folders)
				{
					string ParentID = oChildFolder.EntryID;
					string ChildID = tFolder.EntryID;
					string tFolderName = tFolder.Name.ToString();
					tFqn = FQN + "->" + tFolderName;
					//If xDebug Then log.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0022: '" + tFolderName  + "'.")
					//If xDebug Then log.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0022: '" + tFqn + ":" + tFolder.EntryID)
					//LB.Items.Add(tFqn)
					int II = EMF.cnt_PK_EmailFolder(ChildID, modGlobals.gCurrUserGuidID);
					II = EMF.cnt_UI_EmailFolder(Container, tFqn, modGlobals.gCurrUserGuidID);
					if (II == 0)
					{
						string oChildFolderName = oChildFolder.Name;
						EMF.setFolderid(ref ChildID);
						EMF.setFoldername(ref tFqn);
						EMF.setParentfolderid(ref ParentID);
						EMF.setParentfoldername(ref oChildFolderName);
						EMF.setUserid(ref modGlobals.gCurrUserGuidID);
						bool BB = EMF.Insert(Container);
					}
					else
					{
						string oChildFolderName = oChildFolder.Name;
						EMF.setFolderid(ref ChildID);
						EMF.setFoldername(ref tFqn);
						EMF.setParentfolderid(ref ParentID);
						EMF.setParentfoldername(ref oChildFolderName);
						EMF.setUserid(ref modGlobals.gCurrUserGuidID);
						string WC = EMF.wc_UI_EmailFolder(Container, oChildFolderName, modGlobals.gCurrUserGuidID);
						bool BB = EMF.Update(WC);
					}
					int k = tFolder.Folders.Count;
					if (k > 0)
					{
						RegisterChildFolders(Container, tFolder, tFqn);
					}
				}
				//For i As Integer = 0 To LB.Items.Count - 1
				//    if xDebug then log.WriteToArchiveLog(LB.Items(i).ToString)
				//Next
				//if xDebug then log.WriteToArchiveLog("------------")
			}
			catch (Exception ex)
			{
				//messagebox.show("Error 932.12 - " + ex.Message)
				if (xDebug)
				{
					LOG.WriteToArchiveLog((string) ("Error 932.12 - " + ex.Message));
				}
			}
			
		}
		
		public void ListChildFolders(string ContainerName, Outlook.MAPIFolder oChildFolder, ref ListBox LB, string FQN)
		{
			try
			{
				
				var tFqn = FQN;
				foreach (Outlook.MAPIFolder tFolder in oChildFolder.Folders)
				{
					string ParentID = oChildFolder.EntryID;
					string ChildID = tFolder.EntryID;
					string tFolderName = tFolder.Name.ToString();
					tFqn = FQN + "->" + tFolderName;
					if (xDebug)
					{
						LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0022: \'" + tFolderName + "\'.");
					}
					if (xDebug)
					{
						LOG.WriteToArchiveLog((string) ("Location clsArchiver:ListChildFolders 0022: \'" + tFqn + ":" + tFolder.EntryID));
					}
					LB.Items.Add(tFqn);
					int II = EMF.cnt_PK_EmailFolder(ChildID, modGlobals.gCurrUserGuidID);
					II = EMF.cnt_UI_EmailFolder(ContainerName, tFqn, modGlobals.gCurrUserGuidID);
					string oChildFolderName = oChildFolder.Name;
					if (II == 0)
					{
						string FolderFQN = ContainerName + "|" + tFqn;
						EMF.setFolderid(ref ChildID);
						EMF.setFoldername(ref tFqn);
						EMF.setParentfolderid(ref ParentID);
						EMF.setParentfoldername(ref oChildFolderName);
						EMF.setUserid(ref modGlobals.gCurrUserGuidID);
						EMF.setSelectedforarchive("?");
						bool BB = EMF.Insert(ContainerName);
						if (! BB)
						{
							LOG.WriteToArchiveLog((string) ("ERROR: Faild to  register EMAIL folder: " + ContainerName + " : " + oChildFolderName));
						}
					}
					else
					{
						string FolderFQN = ContainerName + "|" + tFqn;
						EMF.setFolderid(ref ChildID);
						EMF.setFoldername(ref FolderFQN);
						EMF.setParentfolderid(ref ParentID);
						EMF.setParentfoldername(ref oChildFolderName);
						EMF.setUserid(ref modGlobals.gCurrUserGuidID);
						EMF.setSelectedforarchive("?");
						string WC = EMF.wc_UI_EmailFolder(ContainerName, FolderFQN, modGlobals.gCurrUserGuidID);
						bool BB = EMF.Update(WC);
						if (! BB)
						{
							LOG.WriteToArchiveLog((string) ("ERROR: Faild to update registration for EMAIL folder: " + ContainerName + " : " + tFolderName));
						}
					}
					int k = tFolder.Folders.Count;
					if (k > 0)
					{
						ListChildFolders(ContainerName, tFolder, ref LB, tFqn);
					}
				}
				//For i As Integer = 0 To LB.Items.Count - 1
				//    if xDebug then log.WriteToArchiveLog(LB.Items(i).ToString)
				//Next
				//if xDebug then log.WriteToArchiveLog("------------")
			}
			catch (Exception ex)
			{
				//messagebox.show("Error 932.12 - " + ex.Message)
				if (xDebug)
				{
					LOG.WriteToArchiveLog((string) ("Error 932.12 - " + ex.Message));
				}
			}
			
		}
		public void ListChildFolders(Outlook.MAPIFolder oChildFolder, string FQN)
		{
			try
			{
				
				var tFqn = FQN;
				foreach (Outlook.MAPIFolder tFolder in oChildFolder.Folders)
				{
					string ParentID = oChildFolder.EntryID;
					string ChildID = tFolder.EntryID;
					string tFolderName = tFolder.Name.ToString();
					tFqn = FQN + "->" + tFolderName;
					if (xDebug)
					{
						LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0033: \'" + tFolderName + "\'.");
					}
					if (xDebug)
					{
						LOG.WriteToArchiveLog((string) ("Location clsArchiver:ListChildFolders 0033: \'" + tFqn + ":" + tFolder.EntryID));
					}
					if (ChildFoldersList.ContainsKey(tFqn))
					{
					}
					else
					{
						try
						{
							ChildFoldersList.Add(tFqn, ChildID);
						}
						catch (Exception ex)
						{
							LOG.WriteToArchiveLog((string) ("NOTICE: ListChildFolders - ChildFoldersList.Add: " + ex.Message));
						}
					}
					int k = tFolder.Folders.Count;
					if (k > 0)
					{
						ListChildFolders(tFolder, tFqn);
					}
				}
				//For i As Integer = 0 To LB.Items.Count - 1
				//    if xDebug then log.WriteToArchiveLog(LB.Items(i).ToString)
				//Next
				//if xDebug then log.WriteToArchiveLog("------------")
			}
			catch (Exception ex)
			{
				//messagebox.show("Error 932.12 - " + ex.Message)
				if (xDebug)
				{
					LOG.WriteToArchiveLog((string) ("Error 932.12 - " + ex.Message));
				}
			}
			
		}
		public void ListChildFolders(string UID, string EmailFolderFQN, string TopFolder, string currFolder, Outlook.MAPIFolder oChildFolder, string FQN, SortedList slStoreId, string isPublic)
		{
			string StoreID = oChildFolder.StoreID;
			try
			{
				string FolderName = "";
				string ArchiveEmails = "";
				string RemoveAfterArchive = "";
				string SetAsDefaultFolder = "";
				string ArchiveAfterXDays = "";
				string RemoveAfterXDays = "";
				string RemoveXDays = "";
				string ArchiveXDays = "";
				string DB_ID = "";
				bool DeleteFile = false;
				clsArchiver ARCH = new clsArchiver();
				string ArchiveOnlyIfRead = "";
				
				string ParentID = "";
				string ChildID = "";
				string tFolderName = "";
				int BB = 0;
				int idx = 0;
				
				Outlook.MAPIFolder subFolder = null;
				Outlook.MAPIFolder tFolder = null;
				var tFqn = FQN;
				
				Console.WriteLine("Listing the children of: " + tFqn);
				Console.WriteLine("oChildFolder.Folders count : " + oChildFolder.Folders.Count.ToString());
				
				foreach (Outlook.MAPIFolder tempLoopVar_tFolder in oChildFolder.Folders)
				{
					tFolder = tempLoopVar_tFolder;
					
					ParentID = oChildFolder.EntryID;
					ChildID = tFolder.EntryID;
					tFolderName = tFolder.Name.ToString();
					tFqn = FQN + "->" + tFolderName;
					//Console.WriteLine("Processing Child Folder: " + tFqn)
					if (xDebug)
					{
						LOG.WriteToArchiveLog((string) ("Processing Child Folder: " + tFqn));
					}
					if (xDebug)
					{
						LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0044: \'" + tFolderName + "\'.");
					}
					if (xDebug)
					{
						LOG.WriteToArchiveLog((string) ("Location clsArchiver:ListChildFolders 0044: \'" + tFqn + ":" + tFolder.EntryID));
					}
					
					idx = ChildFoldersList.IndexOfKey(tFqn);
					if (idx >= 0)
					{
						ChildID = (string) (ChildFoldersList[tFqn]);
					}
					else
					{
						idx = ckArchEmailFolder(tFqn, modGlobals.gCurrUserGuidID);
						if (idx == 0)
						{
							ChildID = "0000";
						}
						else
						{
							ChildID = getArchEmailFolderIDByFolder(tFqn, modGlobals.gCurrUserGuidID);
						}
					}
					
					BB = ckArchChildEmailFolder(ChildID, modGlobals.gCurrUserGuidID);
					
					if (BB > 0)
					{
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("Location clsArchiver:ListChildFolders 0044a Found it: \'" + tFqn + ":" + tFolder.EntryID));
						}
						string RetentionCode = "";
						int RetentionYears = 10;
						
						RetentionCode = getArchEmailFolderRetentionCode(ChildID, modGlobals.gCurrUserGuidID);
						if (RetentionCode.Length > 0)
						{
							RetentionYears = getRetentionPeriod(RetentionCode);
						}
						
						//messagebox.show("Get the emails from " + tFolderName )
						string oChildFolderName = tFolder.Name;
						EMF.setFolderid(ref ChildID);
						EMF.setFoldername(ref tFqn);
						EMF.setParentfolderid(ref ParentID);
						EMF.setParentfoldername(ref oChildFolderName);
						EMF.setUserid(ref modGlobals.gCurrUserGuidID);
						if (xDebug)
						{
							LOG.WriteToArchiveLog(tFolderName);
						}
						//BB = ckArchEmailFolder(ChildID , gCurrUserGuidID)
						//If BB Then
						EMF.setFolderid(ref ChildID);
						EMF.setFoldername(ref tFolderName);
						EMF.setParentfolderid(ref ParentID);
						EMF.setParentfoldername(oChildFolder.Name);
						EMF.setUserid(ref modGlobals.gCurrUserGuidID);
						BB = GetEmailFolderParms(TopFolder, modGlobals.gCurrUserGuidID, tFqn, ref ArchiveEmails, ref RemoveAfterArchive, ref SetAsDefaultFolder, ref ArchiveAfterXDays, ref RemoveAfterXDays, ref RemoveXDays, ref ArchiveXDays, ref DB_ID, ref ArchiveOnlyIfRead);
						
						DBLocal.setOutlookMissing();
						
						ArchiveEmailsInFolder(UID, TopFolder, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, tFolder, StoreID, ArchiveOnlyIfRead, RetentionYears, RetentionCode, tFqn, slStoreId, isPublic);
					}
					
					
					foreach (Outlook.MAPIFolder tempLoopVar_subFolder in tFolder.Folders)
					{
						subFolder = tempLoopVar_subFolder;
						string sFqn = tFqn + "->" + subFolder.Name;
						sFqn = TopFolder + "|" + sFqn;
						ListChildFolders(UID, EmailFolderFQN, TopFolder, currFolder, subFolder, sFqn, slStoreId, isPublic);
					}
					//Dim k As Integer = tFolder.Folders.Count
					//If k > 0 Then
					//    ListChildFolders(EmailFolderFQN, TopFolder , currFolder , oChildFolder, FQN )
					//End If
				}
				
				//*******************************************************
				
				ParentID = oChildFolder.EntryID;
				ChildID = tFolder.EntryID;
				tFolderName = tFolder.Name.ToString();
				tFqn = FQN + "->" + tFolderName;
				Console.WriteLine("Processing Child Folder: " + tFqn);
				if (xDebug)
				{
					LOG.WriteToArchiveLog((string) ("Processing Child Folder: " + tFqn));
				}
				if (xDebug)
				{
					LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0044: \'" + tFolderName + "\'.");
				}
				if (xDebug)
				{
					LOG.WriteToArchiveLog((string) ("Location clsArchiver:ListChildFolders 0044: \'" + tFqn + ":" + tFolder.EntryID));
				}
				
				idx = ChildFoldersList.IndexOfKey(tFqn);
				if (idx >= 0)
				{
					ChildID = (string) (ChildFoldersList[tFqn]);
				}
				else
				{
					idx = ckArchEmailFolder(tFqn, modGlobals.gCurrUserGuidID);
					if (idx == 0)
					{
						ChildID = "0000";
					}
					else
					{
						ChildID = getArchEmailFolderIDByFolder(tFqn, modGlobals.gCurrUserGuidID);
					}
				}
				
				BB = ckArchChildEmailFolder(ChildID, modGlobals.gCurrUserGuidID);
				
				if (BB > 0)
				{
					
					string RetentionCode = "";
					int RetentionYears = 10;
					
					RetentionCode = getArchEmailFolderRetentionCode(ChildID, modGlobals.gCurrUserGuidID);
					if (RetentionCode.Length > 0)
					{
						RetentionYears = getRetentionPeriod(RetentionCode);
					}
					
					//messagebox.show("Get the emails from " + tFolderName )
					string oChildFolderName = tFolder.Name;
					EMF.setFolderid(ref ChildID);
					EMF.setFoldername(ref tFqn);
					EMF.setParentfolderid(ref ParentID);
					EMF.setParentfoldername(ref oChildFolderName);
					EMF.setUserid(ref modGlobals.gCurrUserGuidID);
					if (xDebug)
					{
						LOG.WriteToArchiveLog(tFolderName);
					}
					//BB = ckArchEmailFolder(ChildID , gCurrUserGuidID)
					//If BB Then
					EMF.setFolderid(ref ChildID);
					EMF.setFoldername(ref tFolderName);
					EMF.setParentfolderid(ref ParentID);
					EMF.setParentfoldername(oChildFolder.Name);
					EMF.setUserid(ref modGlobals.gCurrUserGuidID);
					BB = GetEmailFolderParms(TopFolder, modGlobals.gCurrUserGuidID, tFqn, ref ArchiveEmails, ref RemoveAfterArchive, ref SetAsDefaultFolder, ref ArchiveAfterXDays, ref RemoveAfterXDays, ref RemoveXDays, ref ArchiveXDays, ref DB_ID, ref ArchiveOnlyIfRead);
					
					DBLocal.setOutlookMissing();
					
					ArchiveEmailsInFolder(UID, TopFolder, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, tFolder, DeleteFile.ToString(), StoreID, int.Parse(ArchiveOnlyIfRead), RetentionYears.ToString(), RetentionCode, slStoreId, isPublic);
					
					
				}
				
				subFolder = null;
				foreach (Outlook.MAPIFolder tempLoopVar_subFolder in tFolder.Folders)
				{
					subFolder = tempLoopVar_subFolder;
					string sFqn = tFqn + "->" + subFolder.Name;
					sFqn = TopFolder + "|" + sFqn;
					ListChildFolders(UID, EmailFolderFQN, TopFolder, currFolder, subFolder, sFqn, slStoreId, isPublic);
				}
				//Dim k As Integer = tFolder.Folders.Count
				//If k > 0 Then
				//    ListChildFolders(EmailFolderFQN, TopFolder , currFolder , oChildFolder, FQN )
				//End If
				
				//*******************************************************
				
				
				
			}
			catch (Exception ex)
			{
				if (xDebug)
				{
					LOG.WriteToArchiveLog((string) ("Error 932.12a - " + ex.Message));
				}
			}
			
		}
		public void ListChildFolders(string ContainerName, string TopFolder, Outlook.MAPIFolder oChildFolder, ref ListBox LB, string FQN, bool B)
		{
			string ArchiveEmails = "";
			string RemoveAfterArchive = "";
			string SetAsDefaultFolder = "";
			string ArchiveAfterXDays = "";
			string RemoveAfterXDays = "";
			string RemoveXDays = "";
			string ArchiveXDays = "";
			string DB_ID = "";
			bool DeleteFile = false;
			string ArchiveOnlyIfRead = "";
			
			try
			{
				
				var tFqn = FQN;
				foreach (Outlook.MAPIFolder tFolder in oChildFolder.Folders)
				{
					string tFolderName = tFolder.Name.ToString();
					GetFolderByPath(tFolder.FolderPath);
					tFqn = FQN + "->" + tFolderName;
					if (xDebug)
					{
						LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0055: \'" + tFolderName + "\'.");
					}
					LB.Items.Add(tFqn);
					int k = tFolder.Folders.Count;
					if (k > 0)
					{
						ListChildFolders(ContainerName, tFolder, ref LB, tFqn);
					}
					string CurrFolderName = tFqn;
					tFqn = UTIL.RemoveSingleQuotes(tFqn);
					B = ckFolderExists(modGlobals.gCurrUserGuidID, tFqn, ContainerName);
					if (B)
					{
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("MUST Process folder: " + CurrFolderName + ", alias: " + tFolder.Name));
						}
						bool BB = GetEmailFolderParms(TopFolder, modGlobals.gCurrUserGuidID, CurrFolderName, ref ArchiveEmails, ref RemoveAfterArchive, ref SetAsDefaultFolder, ref ArchiveAfterXDays, ref RemoveAfterXDays, ref RemoveXDays, ref ArchiveXDays, ref DB_ID, ref ArchiveOnlyIfRead);
						if (BB)
						{
							ArchiveEmailsInFolderenders(ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, tFolder, DeleteFile);
						}
						
						
					}
					else
					{
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("IGNORE folder: " + CurrFolderName));
						}
					}
				}
			}
			catch (Exception ex)
			{
				if (xDebug)
				{
					LOG.WriteToArchiveLog((string) ("ERROR 1211.1 - " + ex.Message));
				}
			}
		}
		public void ProcessAllFolders(Outlook.MAPIFolder oChildFolder, ref ListBox LB, string FQN)
		{
			
			var tFqn = FQN;
			foreach (Outlook.MAPIFolder tFolder in oChildFolder.Folders)
			{
				string tFolderName = tFolder.Name.ToString();
				tFqn = FQN + "->" + tFolderName;
				if (xDebug)
				{
					LOG.WriteToArchiveLog("Location clsArchiver:ProcessAllFolders 0066 \'" + tFolderName + "\'.");
				}
				LB.Items.Add(tFqn);
				int k = tFolder.Folders.Count;
				if (k > 0)
				{
					ProcessAllFolders(tFolder, ref LB, tFqn);
				}
				else
				{
					if (xDebug)
					{
						LOG.WriteToArchiveLog((string) ("Examine Folder: " + tFolder.Name));
					}
				}
			}
			for (int i = 0; i <= LB.Items.Count - 1; i++)
			{
				if (xDebug)
				{
					LOG.WriteToArchiveLog(LB.Items[i].ToString());
				}
			}
		}
		public void AddChildFolders(ref ListBox LB, string MailboxName)
		{
			
			Outlook.Application oOutlook;
			Outlook.NameSpace oMAPI = null;
			Outlook.MAPIFolder oChildFolder = null;
			
			oOutlook = new Outlook.Application();
			
			try
			{
				oMAPI = oOutlook.GetNamespace("MAPI");
			}
			catch (Exception ex)
			{
				MessageBox.Show(ex.Message);
			}
			
			try
			{
				oChildFolder = oMAPI.Folders[MailboxName];
			}
			catch (Exception)
			{
				//messagebox.show(ex.Message)
				LB.Items.Add(MailboxName);
				return;
			}
			
			if (oChildFolder.Folders.Count == 0)
			{
				LB.Items.Add(MailboxName);
				//LB.Items.Add(oChildFolder.Folders.Item(i).Name)
			}
			else
			{
				int I = 0;
				for (I = 1; I <= oChildFolder.Folders.Count; I++)
				{
					if (Strings.Trim(oChildFolder.Folders[I].Name) != "")
					{
						string ChildFolderName = oChildFolder.Folders[I].Name.ToString();
						AddChildFolders(ref LB, ChildFolderName);
					}
				}
			}
			
		}
		public void ConvertName(ref string FQN)
		{
			for (int i = 1; i <= FQN.Length; i++)
			{
				string CH = FQN.Substring(i - 1, 1);
				int II = "abcdefghijklmnopqrstuvwxyz0123456789_.".IndexOf(CH) + 1;
				if (II == 0)
				{
					StringType.MidStmtStr(ref FQN, i, 1, "_");
				}
				//If CH = " " Then
				//    Mid(FQN, i, 1) = "_"
				//End If
				//If CH = "?" Then
				//    Mid(FQN, i, 1) = "_"
				//End If
				//If CH = "-" Then
				//    Mid(FQN, i, 1) = "_"
				//End If
				//If CH = ":" Then
				//    Mid(FQN, i, 1) = "."
				//End If
				//If CH = "/" Then
				//    Mid(FQN, i, 1) = "."
				//End If
			}
		}
		
		//Private Sub Timer1_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Timer1.Tick
		//     Try
		
		//          'Dim test1 As String = System.Configuration.ConfigurationManager.AppSettings("Test1")
		//          'Dim oConn As New SqlConnection(System.Configuration.ConfigurationManager.AppSettings("DB_CONN_STR"))
		//          If Timer1.Enabled Then
		//               '** Get the polling interval
		//               Dim PollingInterval As Integer = Val(System.Configuration.ConfigurationManager.AppSettings("PollIntervalMinutes"))
		//               '** Convert the MINUTES to Milliseconds.
		//               Timer1.Interval = PollingInterval * 60000
		
		//               Dim S  = System.Configuration.ConfigurationManager.AppSettings("ParseDirectory")
		//               If S.Equals("YES") Then
		//                    bParseDir = True
		//                    DirToParse  = System.Configuration.ConfigurationManager.AppSettings("DirectoryToParse")
		//               Else
		//                    bParseDir = False
		//               End If
		//               ParseArchiveFolder  = System.Configuration.ConfigurationManager.AppSettings("ParseArchiveFolder")
		//               ArchiveSentMail = System.Configuration.ConfigurationManager.AppSettings("ArchiveSentMail")
		//               ArchiveInbox = System.Configuration.ConfigurationManager.AppSettings("ArchiveInbox")
		//               MaxDaysBeforeArchive = Val(System.Configuration.ConfigurationManager.AppSettings("MaxDaysBeforeArchive"))
		
		//               Timer1.Enabled = False
		//               If ParseArchiveFolder .Equals("YES") Then
		//                    LoadArchiveFolder()
		//               End If
		//               If ArchiveSentMail.Equals("YES") Then
		//                    GetEmails(oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderSentMail), False)
		//               End If
		//               If bParseDir = True Then
		//                    Redeem.ProcessDir(DirToParse , "", True)
		//               End If
		//               If ArchiveInbox.Equals("YES") Then
		//                    GetEmails(oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderInbox), False)
		//               End If
		//               Timer1.Enabled = True
		//          Else
		//               if xDebug then log.WriteToArchiveLog("Timer OFF")
		//          End If
		//          'oConn.Close()
		//          'oConn = Nothing
		//     Catch ex As Exception
		//          messagebox.show(ex.Message)
		//     End Try
		//End Sub
		public void GetActiveEmailSenders(string ContainerName, string TopFolder, string UID, string MailboxName)
		{
			
			string[] ActiveFolders = new string[1];
			string FolderName = "";
			bool DeleteFile = false;
			
			string ArchiveEmails = "";
			string RemoveAfterArchive = "";
			string SetAsDefaultFolder = "";
			string ArchiveAfterXDays = "";
			string RemoveAfterXDays = "";
			string RemoveXDays = "";
			string ArchiveXDays = "";
			string DB_ID = "";
			string ArchiveOnlyIfRead = "";
			
			string[] EmailFolders = new string[1];
			
			GetEmailFolders(UID, ref EmailFolders);
			
			for (int i = 0; i <= (EmailFolders.Length - 1); i++)
			{
				FolderName = EmailFolders[i].ToString().Trim();
				if (xDebug)
				{
					LOG.WriteToArchiveLog((string) ("Folder to Process: " + FolderName));
				}
				bool B = ckFolderExists(ContainerName, UID, FolderName);
				if (B)
				{
					bool BB = GetEmailFolderParms(TopFolder, UID, FolderName, ref ArchiveEmails, ref RemoveAfterArchive, ref SetAsDefaultFolder, ref ArchiveAfterXDays, ref RemoveAfterXDays, ref RemoveXDays, ref ArchiveXDays, ref DB_ID, ref ArchiveOnlyIfRead);
					if (BB)
					{
						//ARCH.getSubFolderEmails(FolderName , bDeleteMsg)
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("Processing Senders from : " + FolderName));
						}
						getSubFolderEmailsSenders(UID, MailboxName, FolderName, DeleteFile, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, ContainerName);
						//ARCH.GetEmails(FolderName , ArchiveEmails , RemoveAfterArchive , SetAsDefaultFolder , ArchiveAfterXDays , RemoveAfterXDays , RemoveXDays , ArchiveXDays , DB_ID )
					}
				}
			}
			
		}
		public void DeleteContact(string EmailAddress, string FullName)
		{
			
			//On Error Goto Err_Handler VBConversions Warning: could not be converted to try/catch - logic too complex
			string DQ = '\u0022';
			Outlook.ContactItem olContact;
			Outlook.MAPIFolder olFolder;
			
			if (! InitializeOutlook())
			{
				MessageBox.Show("Cannot initialize Outlook");
				return;
			}
			
			olFolder = g_nspNameSpace.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderContacts);
			olContact = olFolder.Items.Find((string) ("[Email1Address] = " + DQ + EmailAddress + DQ + " AND " + ("[FullName] = " + DQ + FullName + DQ)));
			
			if (olContact != null)
			{
				olContact.Display(null);
				olContact.Delete();
				
				LOG.WriteToArchiveLog("clsArchiver : DeleteContact : Delete Performed 07");
				
			}
			else
			{
				MessageBox.Show("Cannot find contact");
			}
			
Exit_Handler:
			
			//        On Error Resume Next
			
			if (olFolder != null)
			{
				olFolder = null;
			}
			
			if (olContact != null)
			{
				olContact = null;
			}
			GC.Collect();
			return;
			
Err_Handler:
			MessageBox.Show(Information.Err().Description + " - Error No: " + Information.Err().Number);
			goto Exit_Handler;
			
		}
		
		public void DeleteEmail(string SenderEmailAddress, string ReceivedByName, string ReceivedTime, string SenderName, string SentOn)
		{
			
			//On Error Goto Err_Handler VBConversions Warning: could not be converted to try/catch - logic too complex
			string DQ = '\u0022';
#if Office2007
			Outlook.Folder olEmail;
#else
			Outlook.Folders olEmail;
#endif
			Outlook.MAPIFolder olFolder;
			
			if (! InitializeOutlook())
			{
				MessageBox.Show("Cannot initialize Outlook");
				return;
			}
			
			string S = (string) ("[SenderEmailAddress] = " + DQ + SenderEmailAddress + DQ);
			S = S + "and [ReceivedByName] = " + DQ + ReceivedByName + DQ;
			S = S + "and [ReceivedTime] = " + DQ + ReceivedTime + DQ;
			S = S + "and [ReceivedByName] = " + DQ + ReceivedByName + DQ;
			
			olFolder = g_nspNameSpace.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderInbox);
			olEmail = olFolder.Items.Find(S);
			
			if (olEmail != null)
			{
				//olEmail.Display()
				olEmail.Delete();
				if (dDebug)
				{
					LOG.WriteToArchiveLog("clsArchiver : DeleteEmail : Delete Performed 09");
				}
			}
			else
			{
				MessageBox.Show("Cannot find email: ");
			}
			
Exit_Handler:
			
			//        On Error Resume Next
			
			if (olFolder != null)
			{
				olFolder = null;
			}
			
			if (olEmail != null)
			{
				olEmail = null;
			}
			GC.Collect();
			return;
			
Err_Handler:
			MessageBox.Show(Information.Err().Description, Constants.vbExclamation + " - Error No: " + Information.Err().Number);
			goto Exit_Handler;
			
		}
		
		public void AddOutlookContact(DataGridView DG, bool SkipIfExists, bool OverwriteContact, bool AddIfMissing)
		{
			
			//Dim DR As DataGridViewRow
			
			Outlook.ContactItem olContact = null;
			Outlook.MAPIFolder olFolder = null;
			
			if (! InitializeOutlook())
			{
				Interaction.MsgBox("Cannot initialize Outlook", Constants.vbExclamation, "Automation Error");
				return;
			}
			//DGV.DisplayColNames(DG)
			DGV.ListColumnNames(DG);
			SortedList SL = new SortedList();
			DGV.DisplayColNames(DG, SL);
			try
			{
				olFolder = g_nspNameSpace.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderContacts);
				try
				{
					foreach (DataGridViewRow SelectedRow in DG.SelectedRows)
					{
						string Email1Address = SelectedRow.Cells["Email1Address"].Value.ToString();
						string FullName = SelectedRow.Cells["FullName"].Value.ToString();
						string UserID = SelectedRow.Cells["UserID"].Value.ToString();
						string Account = SelectedRow.Cells["Account"].Value.ToString();
						string Anniversary = SelectedRow.Cells["Anniversary"].Value.ToString();
						string Application = SelectedRow.Cells["Application"].Value.ToString();
						string AssistantName = SelectedRow.Cells["AssistantName"].Value.ToString();
						string AssistantTelephoneNumber = SelectedRow.Cells["AssistantTelephoneNumber"].Value.ToString();
						string BillingInformation = SelectedRow.Cells["BillingInformation"].Value.ToString();
						string Birthday = SelectedRow.Cells["Birthday"].Value.ToString();
						string Business2TelephoneNumber = SelectedRow.Cells["Business2TelephoneNumber"].Value.ToString();
						string BusinessAddress = SelectedRow.Cells["BusinessAddress"].Value.ToString();
						string BusinessAddressCity = SelectedRow.Cells["BusinessAddressCity"].Value.ToString();
						string BusinessAddressCountry = SelectedRow.Cells["BusinessAddressCountry"].Value.ToString();
						string BusinessAddressPostalCode = SelectedRow.Cells["BusinessAddressPostalCode"].Value.ToString();
						string BusinessAddressPostOfficeBox = SelectedRow.Cells["BusinessAddressPostOfficeBox"].Value.ToString();
						string BusinessAddressState = SelectedRow.Cells["BusinessAddressState"].Value.ToString();
						string BusinessAddressStreet = SelectedRow.Cells["BusinessAddressStreet"].Value.ToString();
						string BusinessCardType = SelectedRow.Cells["BusinessCardType"].Value.ToString();
						string BusinessFaxNumber = SelectedRow.Cells["BusinessFaxNumber"].Value.ToString();
						string BusinessHomePage = SelectedRow.Cells["BusinessHomePage"].Value.ToString();
						string BusinessTelephoneNumber = SelectedRow.Cells["BusinessTelephoneNumber"].Value.ToString();
						string CallbackTelephoneNumber = SelectedRow.Cells["CallbackTelephoneNumber"].Value.ToString();
						string CarTelephoneNumber = SelectedRow.Cells["CarTelephoneNumber"].Value.ToString();
						string Categories = SelectedRow.Cells["Categories"].Value.ToString();
						string Children = SelectedRow.Cells["Children"].Value.ToString();
						string XClass = SelectedRow.Cells["XClass"].Value.ToString();
						string Companies = SelectedRow.Cells["Companies"].Value.ToString();
						string CompanyName = SelectedRow.Cells["CompanyName"].Value.ToString();
						string ComputerNetworkName = SelectedRow.Cells["ComputerNetworkName"].Value.ToString();
						string Conflicts = SelectedRow.Cells["Conflicts"].Value.ToString();
						string ConversationTopic = SelectedRow.Cells["ConversationTopic"].Value.ToString();
						string CreationTime = SelectedRow.Cells["CreationTime"].Value.ToString();
						string CustomerID = SelectedRow.Cells["CustomerID"].Value.ToString();
						string Department = SelectedRow.Cells["Department"].Value.ToString();
						string Email1AddressType = SelectedRow.Cells["Email1AddressType"].Value.ToString();
						string Email1DisplayName = SelectedRow.Cells["Email1DisplayName"].Value.ToString();
						string Email1EntryID = SelectedRow.Cells["Email1EntryID"].Value.ToString();
						string Email2Address = SelectedRow.Cells["Email2Address"].Value.ToString();
						string Email2AddressType = SelectedRow.Cells["Email2AddressType"].Value.ToString();
						string Email2DisplayName = SelectedRow.Cells["Email2DisplayName"].Value.ToString();
						string Email2EntryID = SelectedRow.Cells["Email2EntryID"].Value.ToString();
						string Email3Address = SelectedRow.Cells["Email3Address"].Value.ToString();
						string Email3AddressType = SelectedRow.Cells["Email3AddressType"].Value.ToString();
						string Email3DisplayName = SelectedRow.Cells["Email3DisplayName"].Value.ToString();
						string Email3EntryID = SelectedRow.Cells["Email3EntryID"].Value.ToString();
						string FileAs = SelectedRow.Cells["FileAs"].Value.ToString();
						string FirstName = SelectedRow.Cells["FirstName"].Value.ToString();
						string FTPSite = SelectedRow.Cells["FTPSite"].Value.ToString();
						string Gender = SelectedRow.Cells["Gender"].Value.ToString();
						string GovernmentIDNumber = SelectedRow.Cells["GovernmentIDNumber"].Value.ToString();
						string Hobby = SelectedRow.Cells["Hobby"].Value.ToString();
						string Home2TelephoneNumber = SelectedRow.Cells["Home2TelephoneNumber"].Value.ToString();
						string HomeAddress = SelectedRow.Cells["HomeAddress"].Value.ToString();
						string HomeAddressCountry = SelectedRow.Cells["HomeAddressCountry"].Value.ToString();
						string HomeAddressPostalCode = SelectedRow.Cells["HomeAddressPostalCode"].Value.ToString();
						string HomeAddressPostOfficeBox = SelectedRow.Cells["HomeAddressPostOfficeBox"].Value.ToString();
						string HomeAddressState = SelectedRow.Cells["HomeAddressState"].Value.ToString();
						string HomeAddressStreet = SelectedRow.Cells["HomeAddressStreet"].Value.ToString();
						string HomeFaxNumber = SelectedRow.Cells["HomeFaxNumber"].Value.ToString();
						string HomeTelephoneNumber = SelectedRow.Cells["HomeTelephoneNumber"].Value.ToString();
						string IMAddress = SelectedRow.Cells["IMAddress"].Value.ToString();
						string Importance = SelectedRow.Cells["Importance"].Value.ToString();
						string Initials = SelectedRow.Cells["Initials"].Value.ToString();
						string InternetFreeBusyAddress = SelectedRow.Cells["InternetFreeBusyAddress"].Value.ToString();
						string JobTitle = SelectedRow.Cells["JobTitle"].Value.ToString();
						string Journal = SelectedRow.Cells["Journal"].Value.ToString();
						string Language = SelectedRow.Cells["Language"].Value.ToString();
						string LastModificationTime = SelectedRow.Cells["LastModificationTime"].Value.ToString();
						string LastName = SelectedRow.Cells["LastName"].Value.ToString();
						string LastNameAndFirstName = SelectedRow.Cells["LastNameAndFirstName"].Value.ToString();
						string MailingAddress = SelectedRow.Cells["MailingAddress"].Value.ToString();
						string MailingAddressCity = SelectedRow.Cells["MailingAddressCity"].Value.ToString();
						string MailingAddressCountry = SelectedRow.Cells["MailingAddressCountry"].Value.ToString();
						string MailingAddressPostalCode = SelectedRow.Cells["MailingAddressPostalCode"].Value.ToString();
						string MailingAddressPostOfficeBox = SelectedRow.Cells["MailingAddressPostOfficeBox"].Value.ToString();
						string MailingAddressState = SelectedRow.Cells["MailingAddressState"].Value.ToString();
						string MailingAddressStreet = SelectedRow.Cells["MailingAddressStreet"].Value.ToString();
						string ManagerName = SelectedRow.Cells["ManagerName"].Value.ToString();
						string MiddleName = SelectedRow.Cells["MiddleName"].Value.ToString();
						string Mileage = SelectedRow.Cells["Mileage"].Value.ToString();
						string MobileTelephoneNumber = SelectedRow.Cells["MobileTelephoneNumber"].Value.ToString();
						string NetMeetingAlias = SelectedRow.Cells["NetMeetingAlias"].Value.ToString();
						string NetMeetingServer = SelectedRow.Cells["NetMeetingServer"].Value.ToString();
						string NickName = SelectedRow.Cells["NickName"].Value.ToString();
						string Title = SelectedRow.Cells["Title"].Value.ToString();
						string Body = SelectedRow.Cells["Body"].Value.ToString();
						string OfficeLocation = SelectedRow.Cells["OfficeLocation"].Value.ToString();
						string Subject = SelectedRow.Cells["Subject"].Value.ToString();
						
						
						string DQ = '\u0022';
						
						olContact = olFolder.Items.Find((string) ("[Email1Address] = " + DQ + Email1Address + DQ + " AND " + ("[FullName] = " + DQ + FullName + DQ)));
						//FrmMDIMain.SB.Text = FullName
						
						if (olContact != null)
						{
							if (OverwriteContact || AddIfMissing)
							{
								olContact.Delete();
								//LOG.WriteToArchiveLog("clsArchiver : AddOutlookContact : Delete Performed 10: " + Email1Address )
								AddContactDetail(Account, Anniversary, Application, AssistantName, AssistantTelephoneNumber, BillingInformation, Birthday, Business2TelephoneNumber, BusinessAddress, BusinessAddressCity, BusinessAddressCountry, BusinessAddressPostalCode, BusinessAddressPostOfficeBox, BusinessAddressState, BusinessAddressStreet, BusinessCardType, BusinessFaxNumber, BusinessHomePage, BusinessTelephoneNumber, CallbackTelephoneNumber, CarTelephoneNumber, Categories, Children, XClass, Companies, CompanyName, ComputerNetworkName, Conflicts, ConversationTopic, CreationTime, CustomerID, Department, Email1Address, Email1AddressType, Email1DisplayName, Email1EntryID, Email2Address, Email2AddressType, Email2DisplayName, Email2EntryID, Email3Address, Email3AddressType, Email3DisplayName, Email3EntryID, FileAs, FirstName, FTPSite, FullName, Gender, GovernmentIDNumber, Hobby, Home2TelephoneNumber, HomeAddress, HomeAddressCountry, HomeAddressPostalCode, HomeAddressPostOfficeBox, HomeAddressState, HomeAddressStreet, HomeFaxNumber, HomeTelephoneNumber, IMAddress, Importance, Initials, InternetFreeBusyAddress, JobTitle, Journal, Language, LastModificationTime, LastName, LastNameAndFirstName, MailingAddress, MailingAddressCity, MailingAddressCountry, MailingAddressPostalCode, MailingAddressPostOfficeBox, MailingAddressState, MailingAddressStreet, ManagerName, MiddleName, Mileage, MobileTelephoneNumber, NetMeetingAlias, NetMeetingServer, NickName, Title, Body, OfficeLocation, Subject);
							}
							else
							{
								Console.WriteLine("Contact already exist... skipping.");
								//olContact.Display()
							}
						}
						else
						{
							AddContactDetail(Account, Anniversary, Application, AssistantName, AssistantTelephoneNumber, BillingInformation, Birthday, Business2TelephoneNumber, BusinessAddress, BusinessAddressCity, BusinessAddressCountry, BusinessAddressPostalCode, BusinessAddressPostOfficeBox, BusinessAddressState, BusinessAddressStreet, BusinessCardType, BusinessFaxNumber, BusinessHomePage, BusinessTelephoneNumber, CallbackTelephoneNumber, CarTelephoneNumber, Categories, Children, XClass, Companies, CompanyName, ComputerNetworkName, Conflicts, ConversationTopic, CreationTime, CustomerID, Department, Email1Address, Email1AddressType, Email1DisplayName, Email1EntryID, Email2Address, Email2AddressType, Email2DisplayName, Email2EntryID, Email3Address, Email3AddressType, Email3DisplayName, Email3EntryID, FileAs, FirstName, FTPSite, FullName, Gender, GovernmentIDNumber, Hobby, Home2TelephoneNumber, HomeAddress, HomeAddressCountry, HomeAddressPostalCode, HomeAddressPostOfficeBox, HomeAddressState, HomeAddressStreet, HomeFaxNumber, HomeTelephoneNumber, IMAddress, Importance, Initials, InternetFreeBusyAddress, JobTitle, Journal, Language, LastModificationTime, LastName, LastNameAndFirstName, MailingAddress, MailingAddressCity, MailingAddressCountry, MailingAddressPostalCode, MailingAddressPostOfficeBox, MailingAddressState, MailingAddressStreet, ManagerName, MiddleName, Mileage, MobileTelephoneNumber, NetMeetingAlias, NetMeetingServer, NickName, Title, Body, OfficeLocation, Subject);
						}
					}
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("AddOutlookContact: 110.11 - " + "\r\n" + ex.Message));
					LOG.WriteToArchiveLog((string) ("AddOutlookContact: 110.11 - " + "\r\n" + ex.StackTrace));
				}
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("AddOutlookContact: 110.12 - " + "\r\n" + ex.Message));
				LOG.WriteToArchiveLog((string) ("AddOutlookContact: 110.12 - " + "\r\n" + ex.StackTrace));
			}
			
			if (olFolder != null)
			{
				olFolder = null;
			}
			
			if (olContact != null)
			{
				olContact = null;
			}
			GC.Collect();
			
		}
		public void AddOutlookEmail(DataGridView DG, bool SkipIfExists, bool OverwriteContact, bool AddIfMissing)
		{
			
			//Dim DR As DataGridViewRow
			
			Outlook.MailItem olEmailItem = null;
			Outlook.MAPIFolder olFolder = null;
			
#if Office2007
			Outlook.Folder olEmail = null;
#else
			Outlook.Folders olEmail = null;
#endif
			
			
			if (! InitializeOutlook())
			{
				Interaction.MsgBox("Cannot initialize Outlook", Constants.vbExclamation, "Automation Error");
				return;
			}
			
			foreach (DataGridViewRow SelectedRow in DG.SelectedRows)
			{
				
				string SenderEmailAddress = SelectedRow.Cells["SenderEmailAddress"].Value.ToString();
				string SUBJECT = SelectedRow.Cells["SUBJECT"].Value.ToString();
				string Body = SelectedRow.Cells["Body"].Value.ToString();
				string ReceivedByName = SelectedRow.Cells["ReceivedByName"].Value.ToString();
				string ReceivedTime = SelectedRow.Cells["ReceivedTime"].Value.ToString();
				string SentTO = SelectedRow.Cells["SentTO"].Value.ToString();
				string SenderName = SelectedRow.Cells["SenderName"].Value.ToString();
				string Bcc = SelectedRow.Cells["Bcc"].Value.ToString();
				string BillingInformation = SelectedRow.Cells["BillingInformation"].Value.ToString();
				string CC = SelectedRow.Cells["CC"].Value.ToString();
				string Companies = SelectedRow.Cells["Companies"].Value.ToString();
				string CreationTime = SelectedRow.Cells["CreationTime"].Value.ToString();
				string ReadReceiptRequested = SelectedRow.Cells["ReadReceiptRequested"].Value.ToString();
				string AllRecipients = SelectedRow.Cells["AllRecipients"].Value.ToString();
				string Sensitivity = SelectedRow.Cells["Sensitivity"].Value.ToString();
				string SentOn = SelectedRow.Cells["SentOn"].Value.ToString();
				string MsgSize = SelectedRow.Cells["MsgSize"].Value.ToString();
				string DeferredDeliveryTime = SelectedRow.Cells["DeferredDeliveryTime"].Value.ToString();
				string keyEmailIdentifier = SelectedRow.Cells["EntryID"].Value.ToString();
				string ExpiryTime = SelectedRow.Cells["ExpiryTime"].Value.ToString();
				string LastModificationTime = SelectedRow.Cells["LastModificationTime"].Value.ToString();
				string EmailImage = SelectedRow.Cells["EmailImage"].Value.ToString();
				string Accounts = SelectedRow.Cells["Accounts"].Value.ToString();
				string RowID = SelectedRow.Cells["RowID"].Value.ToString();
				string ShortSubj = SelectedRow.Cells["ShortSubj"].Value.ToString();
				string SourceTypeCode = SelectedRow.Cells["SourceTypeCode"].Value.ToString();
				string UserID = SelectedRow.Cells["UserID"].Value.ToString();
				string EmailGuid = SelectedRow.Cells["EmailGuid"].Value.ToString();
				
				//On Error Goto Err_Handler VBConversions Warning: could not be converted to try/catch - logic too complex
				string DQ = '\u0022';
				
				string S = (string) ("[SenderEmailAddress] = " + DQ + SenderEmailAddress + DQ);
				S = S + "and [ReceivedByName] = " + DQ + ReceivedByName + DQ;
				S = S + "and [ReceivedTime] = " + DQ + ReceivedTime + DQ;
				S = S + "and [ReceivedByName] = " + DQ + ReceivedByName + DQ;
				
				olFolder = g_nspNameSpace.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderInbox);
				olEmail = olFolder.Items.Find(S);
				
				olEmailItem = olFolder.Items.Find(S);
				
				if (olEmailItem != null)
				{
					if (OverwriteContact || AddIfMissing)
					{
						olEmailItem.Delete();
						LOG.WriteToArchiveLog("clsArchiver : AddOutlookEmail : Delete Performed 11");
						
						//*************** DO NOT SAVE THE WHOLE BODY, JUST THE FIRST 100 CHARACTERS *****************
						Body = Body.Substring(0, 100);
						//*******************************************************************************************
						AddEmailDetail(SenderEmailAddress, SUBJECT, Body, ReceivedByName, ReceivedTime, SentTO, SenderName, Bcc, BillingInformation, CC, Companies, CreationTime, ReadReceiptRequested, AllRecipients, Sensitivity, SentOn, MsgSize, DeferredDeliveryTime, ExpiryTime, LastModificationTime, EmailImage, Accounts, ShortSubj);
					}
					else
					{
						MessageBox.Show("Contact already exist... skipping.");
						//olEmailItem.Display()
					}
				}
				else
				{
					AddEmailDetail(SenderEmailAddress, SUBJECT, Body, ReceivedByName, ReceivedTime, SentTO, SenderName, Bcc, BillingInformation, CC, Companies, CreationTime, ReadReceiptRequested, AllRecipients, Sensitivity, SentOn, MsgSize, DeferredDeliveryTime, ExpiryTime, LastModificationTime, EmailImage, Accounts, ShortSubj);
				}
				
			}
			
			
Exit_Handler:
			
			//        On Error Resume Next
			
			if (olFolder != null)
			{
				olFolder = null;
			}
			
			if (olEmailItem != null)
			{
				olEmailItem = null;
			}
			
			if (olEmail != null)
			{
				olEmail = null;
			}
			GC.Collect();
			return;
			
Err_Handler:
			Interaction.MsgBox(Information.Err().Description, Constants.vbExclamation, "Error No: " + Information.Err().Number);
			goto Exit_Handler;
			
		}
		public bool InitializeOutlook()
		{
			bool returnValue;
			//On Error Goto Err_Handler VBConversions Warning: could not be converted to try/catch - logic too complex
			if (g_olApp == null)
			{
				g_olApp = new Outlook.Application();
				g_nspNameSpace = g_olApp.GetNamespace("MAPI");
				returnValue = true;
			}
			else
			{
				returnValue = true;
			}
Exit_Handler:
			return returnValue;
Err_Handler:
			// No Error message - simply let the function return false
			goto Exit_Handler;
			return returnValue;
		}
		public void AddContactDetail(string Account, string Anniversary, string Application, string AssistantName, string AssistantTelephoneNumber, string BillingInformation, string Birthday, string Business2TelephoneNumber, string BusinessAddress, string BusinessAddressCity, string BusinessAddressCountry, string BusinessAddressPostalCode, string BusinessAddressPostOfficeBox, string BusinessAddressState, string BusinessAddressStreet, string BusinessCardType, string BusinessFaxNumber, string BusinessHomePage, string BusinessTelephoneNumber, string CallbackTelephoneNumber, string CarTelephoneNumber, string Categories, string Children, string xClass, string Companies, string CompanyName, string ComputerNetworkName, string Conflicts, string ConversationTopic, string CreationTime, string CustomerID, string Department, string Email1Address, string Email1AddressType, string Email1DisplayName, string Email1EntryID, string Email2Address, string Email2AddressType, string Email2DisplayName, string Email2EntryID, string Email3Address, string Email3AddressType, string Email3DisplayName, string Email3EntryID, string FileAs, string FirstName, string FTPSite, string FullName, string Gender, string GovernmentIDNumber, string Hobby, string Home2TelephoneNumber, string HomeAddress, string HomeAddressCountry, string HomeAddressPostalCode, string HomeAddressPostOfficeBox, string HomeAddressState, string HomeAddressStreet, string HomeFaxNumber, string HomeTelephoneNumber, string IMAddress, string Importance, string Initials, string InternetFreeBusyAddress, string JobTitle, string Journal, string Language, string LastModificationTime, string LastName, string LastNameAndFirstName, string MailingAddress, string MailingAddressCity, string MailingAddressCountry, string MailingAddressPostalCode, string MailingAddressPostOfficeBox, string MailingAddressState, string MailingAddressStreet, string ManagerName, string MiddleName, string Mileage, string MobileTelephoneNumber, string NetMeetingAlias, string NetMeetingServer, string NickName, string Title, string Body, string OfficeLocation, string Subject)
		{
			
			Outlook.Application myOutlook;
			Outlook.ContactItem myItem;
			
			myOutlook = Interaction.CreateObject("Outlook.Application", "");
			myItem = myOutlook.CreateItem(Outlook.OlItemType.olContactItem);
			try
			{
				myItem.Account = Account;
				myItem.Anniversary = Anniversary;
				//.Application = Application
				myItem.AssistantName = AssistantName;
				myItem.AssistantTelephoneNumber = AssistantTelephoneNumber;
				myItem.BillingInformation = BillingInformation;
				myItem.Birthday = Birthday;
				myItem.Business2TelephoneNumber = Business2TelephoneNumber;
				myItem.BusinessAddress = BusinessAddress;
				myItem.Save();
				myItem.BusinessAddressCity = BusinessAddressCity;
				myItem.BusinessAddressCountry = BusinessAddressCountry;
				myItem.BusinessAddressPostalCode = BusinessAddressPostalCode;
				myItem.BusinessAddressPostOfficeBox = BusinessAddressPostOfficeBox;
				myItem.BusinessAddressState = BusinessAddressState;
				myItem.Save();
				myItem.BusinessAddressStreet = BusinessAddressStreet;
				//.BusinessCardType = BusinessCardType
				myItem.BusinessFaxNumber = BusinessFaxNumber;
				myItem.BusinessHomePage = BusinessHomePage;
				myItem.BusinessTelephoneNumber = BusinessTelephoneNumber;
				myItem.CallbackTelephoneNumber = CallbackTelephoneNumber;
				myItem.CarTelephoneNumber = CarTelephoneNumber;
				myItem.Categories = Categories;
				myItem.Save();
				myItem.Children = Children;
				//.xClass = xClass
				myItem.Companies = Companies;
				myItem.CompanyName = CompanyName;
				myItem.ComputerNetworkName = ComputerNetworkName;
				//.Conflicts = Conflicts
				//.ConversationTopic = ConversationTopic
				//.CreationTime = CreationTime
				myItem.CustomerID = CustomerID;
				myItem.Save();
				myItem.Department = Department;
				myItem.Email1Address = Email1Address;
				myItem.Email1AddressType = Email1AddressType;
				myItem.Email1DisplayName = Email1DisplayName;
				//.Email1EntryID = Email1EntryID
				myItem.Email2Address = Email2Address;
				myItem.Email2AddressType = Email2AddressType;
				myItem.Email2DisplayName = Email2DisplayName;
				//.Email2EntryID = Email2EntryID
				myItem.Save();
				myItem.Email3Address = Email3Address;
				myItem.Email3AddressType = Email3AddressType;
				myItem.Email3DisplayName = Email3DisplayName;
				//.Email3EntryID = Email3EntryID
				myItem.FileAs = FileAs;
				myItem.FirstName = FirstName;
				myItem.FTPSite = FTPSite;
				myItem.FullName = FullName;
				myItem.Save();
				myItem.Gender = Gender;
				
				myItem.GovernmentIDNumber = GovernmentIDNumber;
				myItem.Hobby = Hobby;
				myItem.Home2TelephoneNumber = Home2TelephoneNumber;
				myItem.HomeAddress = HomeAddress;
				myItem.HomeAddressCountry = HomeAddressCountry;
				myItem.HomeAddressPostalCode = HomeAddressPostalCode;
				myItem.HomeAddressPostOfficeBox = HomeAddressPostOfficeBox;
				myItem.HomeAddressState = HomeAddressState;
				myItem.HomeAddressStreet = HomeAddressStreet;
				myItem.HomeFaxNumber = HomeFaxNumber;
				myItem.Save();
				myItem.HomeTelephoneNumber = HomeTelephoneNumber;
				myItem.IMAddress = IMAddress;
				myItem.Importance = Importance;
				myItem.Initials = Initials;
				myItem.InternetFreeBusyAddress = InternetFreeBusyAddress;
				myItem.JobTitle = JobTitle;
				myItem.Journal = bool.Parse(Journal);
				myItem.Language = Language;
				//.LastModificationTime = LastModificationTime
				myItem.LastName = LastName;
				myItem.Save();
				//.LastNameAndFirstName = LastNameAndFirstName
				myItem.MailingAddress = MailingAddress;
				myItem.MailingAddressCity = MailingAddressCity;
				myItem.MailingAddressCountry = MailingAddressCountry;
				myItem.MailingAddressPostalCode = MailingAddressPostalCode;
				myItem.MailingAddressPostOfficeBox = MailingAddressPostOfficeBox;
				myItem.MailingAddressState = MailingAddressState;
				myItem.Save();
				myItem.MailingAddressStreet = MailingAddressStreet;
				myItem.ManagerName = ManagerName;
				myItem.MiddleName = MiddleName;
				myItem.Mileage = Mileage;
				myItem.Save();
				myItem.MobileTelephoneNumber = MobileTelephoneNumber;
				myItem.Save();
				//'.NetMeetingAlias = NetMeetingAlias
				//.Save()
				//.NetMeetingServer = NetMeetingServer
				//.Save()
				myItem.NickName = NickName;
				myItem.Save();
				myItem.Title = Title;
				myItem.Body = Body;
				myItem.OfficeLocation = OfficeLocation;
				myItem.Subject = Subject;
				
				myItem.Save();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("AddContactDetail 1: " + ex.Message));
				LOG.WriteToArchiveLog((string) ("AddContactDetail 2: " + ex.StackTrace));
				LOG.WriteToArchiveLog((string) ("AddContactDetail 3: " + ex.InnerException.ToString()));
				LOG.WriteToArchiveLog((string) ("AddContactDetail 4: " + ex.Data.ToString()));
			}
			
			if (myOutlook != null)
			{
				myOutlook = null;
			}
			
			if (myItem != null)
			{
				myItem = null;
			}
			
		}
		
		public void AddEmailDetail(string SenderEmailAddress, string SUBJECT, string Body, string ReceivedByName, string ReceivedTime, string SentTO, string SenderName, string Bcc, string BillingInformation, string CC, string Companies, string CreationTime, string ReadReceiptRequested, string AllRecipients, string Sensitivity, string SentOn, string MsgSize, string DeferredDeliveryTime, string ExpiryTime, string LastModificationTime, string EmailImage, string Accounts, string ShortSubj)
		{
			
			Outlook.Application myOutlook;
			Outlook.ContactItem myItem;
			
			myOutlook = Interaction.CreateObject("Outlook.Application", "");
			myItem = myOutlook.CreateItem(Outlook.OlItemType.olMailItem);
			
			myItem.SenderEmailAddress = SenderEmailAddress;
			myItem.Subject = SUBJECT;
			myItem.Body = Body;
			myItem.ReceivedByName = ReceivedByName;
			myItem.ReceivedTime = ReceivedTime;
			myItem.SentTO = SentTO;
			myItem.SenderName = SenderName;
			myItem.Bcc = Bcc;
			myItem.BillingInformation = BillingInformation;
			myItem.CC = CC;
			myItem.Companies = Companies;
			//.CreationTime = CreationTime
			myItem.ReadReceiptRequested = ReadReceiptRequested;
			myItem.AllRecipients = AllRecipients;
			myItem.Sensitivity = Sensitivity;
			myItem.SentOn = SentOn;
			myItem.MsgSize = MsgSize;
			myItem.DeferredDeliveryTime = DeferredDeliveryTime;
			//.EntryID = EntryID
			myItem.ExpiryTime = ExpiryTime;
			//.LastModificationTime = LastModificationTime
			myItem.EmailImage = EmailImage;
			myItem.Accounts = Accounts;
			myItem.ShortSubj = ShortSubj;
			
			myItem.Save();
			
			if (myOutlook != null)
			{
				myOutlook = null;
			}
			
			if (myItem != null)
			{
				myItem = null;
			}
			GC.Collect();
		}
		
		public void CreateEcmHistoryFolder()
		{
			
			bool bAutoCreateRestoreFolder = false;
			
			string sDebug = getUserParm("user_CreateOutlookRestoreFolder");
			//If sDebug.Length = 0 Then
			//    bAutoCreateRestoreFolder = False
			//ElseIf sDebug.Equals("0") Then
			//    bAutoCreateRestoreFolder = False
			//Else
			//    bAutoCreateRestoreFolder = True
			//End If
			
			//If bAutoCreateRestoreFolder = False Then
			//    Return
			//End If
			
			
			try
			{
				Outlook.Application oOutlook;
				Outlook._NameSpace oMAPI;
				Outlook.MAPIFolder oParentFolder;
				
				int i;
				int iElement = 0;
				
				oOutlook = new Outlook.Application();
				oMAPI = oOutlook.GetNamespace("MAPI");
				
				ArrayList A = getOutlookParentFolderNames();
				
				string MailboxName = (string) (A[A.Count - 1]);
				
				oParentFolder = oMAPI.Folders[MailboxName];
				
				Outlook.Application oApp = new Outlook.Application();
				Outlook.NameSpace oNS = oApp.GetNamespace("mapi");
				bool B = false;
				
				if (oParentFolder.Folders.Count != 0)
				{
					for (i = 1; i <= oParentFolder.Folders.Count; i++)
					{
						if (Strings.Trim(oParentFolder.Folders[i].Name) != "")
						{
							if (oParentFolder.Folders[i].Name.Equals("Restored Emails"))
							{
								modGlobals.oHistoryEntryID = oParentFolder.Folders[i].EntryID;
								modGlobals.oHistoryStoreID = oParentFolder.Folders[i].StoreID;
								modGlobals.oEcmHistFolder = oParentFolder.Folders[i];
								B = true;
								break;
							}
						}
					}
				}
				if (! B)
				{
					oParentFolder.Folders.Add("Restored Emails", null);
					for (i = 1; i <= oParentFolder.Folders.Count; i++)
					{
						if (Strings.Trim(oParentFolder.Folders[i].Name) != "")
						{
							if (oParentFolder.Folders[i].Name.Equals("Restored Emails"))
							{
								modGlobals.oHistoryEntryID = oParentFolder.Folders[i].EntryID;
								modGlobals.oHistoryStoreID = oParentFolder.Folders[i].StoreID;
								modGlobals.oEcmHistFolder = oParentFolder.Folders[i];
								B = true;
								break;
							}
						}
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("Notice: clsArchiver:CreateRestoreFolder 100.11 - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("Notice: clsArchiver:CreateRestoreFolder 100.11 - " + ex.StackTrace));
			}
			
			
			
		}
		
		private void ProcessFolders(System.IO.DirectoryInfo directoryInfo, bool recurseFolders, int depth, int maxDepth, ref int folderCount, ref int fileCount)
		{
			
			Debug.WriteLine(string.Empty);
			Debug.WriteLine(directoryInfo.FullName);
			
			folderCount++;
			
			// Recurse to process subfolders if requested.
			if (recurseFolders)
			{
				if (depth < maxDepth)
				{
					depth++;
					foreach (System.IO.DirectoryInfo folder in directoryInfo.GetDirectories())
					{
						ProcessFolders(folder, recurseFolders, depth, maxDepth, ref folderCount, ref fileCount);
					}
				}
			}
			
			// Process file folders
			foreach (System.IO.FileInfo file in directoryInfo.GetFiles())
			{
				fileCount++;
				Debug.WriteLine(string.Format("{0} {1}, Size {2}, Create {3}, Access {4}, Update {5}, {6}", file.Name, file.Extension, file.Length, file.CreationTime, file.LastAccessTime, file.LastWriteTime, file.DirectoryName));
			}
		} //ProcessFolders
#if Office2007
		private Outlook.Folder GetFolderByPath(string folderPath)
		{
#else
			private Outlook.Folders GetFolderByPath(string folderPath)
			{
#endif
				
#if Office2007
				Outlook.Folder returnFolder = null;
#else
				Outlook.Folders returnFolder = null;
#endif
				
				try
				{
					// Remove leading "\" characters.
					folderPath = folderPath.TrimStart("\\" .ToCharArray());
					
					// Split the folder path into individual folder names.
					string[] folders = folderPath.Split("\\" .ToCharArray());
					
					// Retrieve a reference to the root folder.
					
					Outlook._NameSpace oMAPI;
					string MailboxName = folders[0];
#if Office2007
					Outlook.Folder oParentFolder = oMAPI.Folders[folders[0]];
#else
					Outlook.Folders oParentFolder = oMAPI.Folders[folders[0]];
#endif
					
					returnFolder = oParentFolder.Folders(0);
					//TryCast(Application.Session.Folders(folders(0)), Outlook.Folder)
					
					// If the root folder exists, look in subfolders.
					if (returnFolder != null)
					{
						Outlook.Folders subFolders = null;
						string folderName;
						
						// Look through folder names, skipping the first folder,
						// which you already retrieved.
						for (int i = 1; i <= folders.Length - 1; i++)
						{
							folderName = folders[i];
							subFolders = returnFolder.Folders;
#if Office2007
							returnFolder = subFolders(folderName) as Outlook.Folder;
#else
							returnFolder = subFolders(folderName) as Outlook.Folders;
#endif
						}
					}
				}
				catch (Exception)
				{
					//messagebox.show(ex.Message)
					// Do nothing at all -- just return a null reference.
					returnFolder = null;
					
				}
				return returnFolder;
			}
			public void ArchiveEmailFoldersThreaded()
			{
				Thread T = new Thread(new System.Threading.ThreadStart(ArchiveEmailFolders));
				T.IsBackground = true;
				T.TrySetApartmentState(ApartmentState.STA);
				T.Start();
			}
			public void ArchiveEmailFolders(string UID)
			{
				
				string isPublic = "N";
				
				bool bUseQuickSearch = false;
				bool ThreadingOn = true;
				int NbrOfIds = getCountStoreIdByFolder();
				
				SortedList slStoreId = new SortedList();
				
				if (NbrOfIds <= 2000000)
				{
					bUseQuickSearch = true;
				}
				else
				{
					bUseQuickSearch = false;
				}
				
				if (bUseQuickSearch)
				{
					//LoadEntryIdByUserID(slStoreId)
					DBLocal.getCE_EmailIdentifiers(slStoreId);
				}
				else
				{
					slStoreId.Clear();
				}
				//#If EnableSingleSource Then
				//        Dim tMachineGuid As Guid = GE.AddItem(gMachineID, "GlobalMachine", False)
				//#End If
				if (modGlobals.gRunMinimized == true)
				{
					frmNotify2.Default.WindowState = FormWindowState.Minimized;
				}
				else
				{
					frmNotify2.Default.Show();
				}
				
				if (modGlobals.gRunMinimized)
				{
					frmNotify2.Default.WindowState = FormWindowState.Minimized;
				}
				frmNotify2.Default.Location = new Point(25, 200);
				if (modGlobals.gRunMode.Equals("M-END"))
				{
					frmNotify2.Default.WindowState = FormWindowState.Minimized;
				}
				//If ThreadingOn Then 'FrmMDIMain.lblArchiveStatus.Text = "Archive Running"
				double L = 1;
				int iEmails = 0;
				try
				{
					L = 1;
					
					modGlobals.gEmailsBackedUp = 0;
					//Dim FolderList As New SortedList(Of String, String)
					DataGridView DGV = new DataGridView();
					L = 3;
					//"Select ContainerName, FolderName, FolderID, storeid, from EmailFolder
					try
					{
						L = 3;
						getArchiveFolderIds(ref DGV);
						L = 4;
					}
					catch (Exception ex)
					{
						L = 5;
						LOG.WriteToArchiveLog((string) ("ERROR 101.331a ArchiveEmailFolders " + ex.Message));
						MessageBox.Show((string) ("Failed at ERROR 101.331a ArchiveEmailFolders " + ex.Message));
					}
					L = 6;
					string FID = "";
					string SID = "";
					string ContainerName = "";
					L = 7;
					
					string FolderName = "";
					string ArchiveEmails = "";
					string RemoveAfterArchive = "";
					string SetAsDefaultFolder = "";
					string ArchiveAfterXDays = "";
					string RemoveAfterXDays = "";
					string RemoveXDays = "";
					string ArchiveXDays = "";
					string DB_ID = "";
					bool DeleteFile = false;
					string ArchiveOnlyIfRead = "";
					L = 8;
					
					bool BX = UTIL.isOutLookRunning();
					if (BX == true)
					{
						frmOutlookNotice.Default.Show();
					}
					
					Outlook.Application oOutlook;
					oOutlook = new Outlook.Application();
					L = 9;
					
					frmOutlookNotice.Default.Close();
					frmOutlookNotice.Default.Hide();
					
					Outlook._NameSpace oMAPI = null;
					try
					{
						oMAPI = oOutlook.GetNamespace("MAPI");
					}
					catch (Exception ex)
					{
						MessageBox.Show(ex.Message);
					}
					L = 10;
					string TopFolder = "";
					string FolderFQN = "";
					string SubFolderName = "";
					L = 11;
					int iProcessed = 0;
					L = 12;
					LOG.WriteToArchiveLog((string) ("Archive of " + DGV.Rows.Count.ToString() + " folders by " + modGlobals.gCurrLoginID));
					for (int IX = 0; IX <= DGV.Rows.Count - 1; IX++)
					{
						iEmails++;
						Application.DoEvents();
						try
						{
							SID = DGV.Rows[IX].Cells["storeid"].Value.ToString();
						}
						catch (Exception ex)
						{
							LOG.WriteToArchiveLog((string) ("Info: DVG @1 IX = " + IX.ToString() + " : " + ex.Message));
							goto SKIPTHISONE;
						}
						L = 14.1;
						try
						{
							FID = DGV.Rows[IX].Cells["FolderID"].Value.ToString();
						}
						catch (Exception ex)
						{
							//log.WriteToArchiveLog("Info: DVG @2 Line = " + L.ToString)
							LOG.WriteToArchiveLog((string) ("Informational: DVG @2 IX = " + IX.ToString() + " : " + ex.Message));
							goto SKIPTHISONE;
						}
						
						L = 15.2;
						try
						{
							ContainerName = DGV.Rows[IX].Cells["ContainerName"].Value.ToString();
						}
						catch (Exception ex)
						{
							//log.WriteToArchiveLog("Info: DVG @3 Line = " + L.ToString)
							LOG.WriteToArchiveLog((string) ("Info: DVG @3 IX = " + IX.ToString() + " : " + ex.Message));
							goto SKIPTHISONE;
						}
						L = 16.3;
						try
						{
							FolderName = DGV.Rows[IX].Cells["FolderName"].Value.ToString();
						}
						catch (Exception ex)
						{
							//log.WriteToArchiveLog("Info: DVG4 @ Line = " + L.ToString)
							LOG.WriteToArchiveLog((string) ("Info: DVG4 @ IX = " + IX.ToString() + " : " + ex.Message));
							goto SKIPTHISONE;
						}
						//messagebox.show(FolderName )
						L = 17.4;
						if (modGlobals.gTerminateImmediately)
						{
							//If ThreadingOn Then 'FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"
							frmNotify2.Default.Close();
							modGlobals.gOutlookArchiving = false;
							My.Settings.Default["LastArchiveEndTime"] = DateTime.Now;
							My.Settings.Default.Save();
							frmNotify2.Default.Close();
							return;
						}
						L = 18.5;
						iProcessed++;
						modGlobals.gEmailsBackedUp = modGlobals.gEmailsBackedUp + iProcessed;
						//FID = FolderID
						//SID = StoreID
						L = 18.9;
						//TopFolder  = getParentFolderNameById(FID)
						TopFolder = getParentFolderNameById(FID);
						
						//log.WriteToArchiveLog("*** FOLDER NOTICE TopFolder  001x - : " + TopFolder )
						
						FolderFQN = getFolderNameById(FID);
						
						//log.WriteToArchiveLog("*** FOLDER NOTICE 001a - : " + FolderFQN )
						
						string[] FolderParms = FolderFQN.Split("|".ToCharArray());
						
						TopFolder = FolderParms[0];
						SubFolderName = FolderParms[1];
						frmNotify2.Default.lblFolder.Text = SubFolderName;
						frmNotify2.Default.Refresh();
						
						L = 16;
						Outlook.Application myOlApp;
						Outlook.MAPIFolder myFolder;
						string myEntryID;
						string myStoreID;
						myOlApp = Interaction.CreateObject("Outlook.Application", "");
						
						myEntryID = FID;
						myStoreID = SID;
						
						try
						{
							myFolder = myOlApp.Session.GetFolderFromID(myEntryID, myStoreID);
						}
						catch (Exception ex)
						{
							LOG.WriteToArchiveLog((string) ("FATAL ERROR: ArchiveEmailFolders 900A - COULD NOT OPEN EMAIL FOLDER: " + ex.Message));
							LOG.WriteToArchiveLog((string) ("FATAL ERROR: ArchiveEmailFolders 900B - COULD NOT OPEN EMAIL FOLDER: " + TopFolder + " : " + SubFolderName));
							goto SKIPTHISONE;
						}
						
						int iFolders = myFolder.Folders.Count;
						Outlook.MAPIFolder oFolder = null;
						//L = 17
						
						try
						{
							L = 18;
							string FolderID = FID;
							oFolder = oMAPI.GetFolderFromID(FolderID, SID);
							L = 19;
							
							string tEmailFolderName = (string) ("EMAIL: " + oFolder.Name);
							string FolderBeingProcessed = oFolder.Name;
							//#If EnableSingleSource Then
							//                    Dim tNewGuid As Guid = GE.AddItem(tEmailFolderName, "GlobalDirectory", False)
							//#End If
							Console.WriteLine(tEmailFolderName);
							if (oFolder.Name.Trim() != "")
							{
								//If xDebug Then log.WriteToArchiveLog("Code 100 Processing email folder: " + oFolder.Name)
								string ParentID = oFolder.EntryID;
								string ChildID = oFolder.EntryID;
								string tFolderName = oFolder.Name;
								var CurrentFolder = oFolder;
								string StoreID = oFolder.StoreID;
								L = 20;
								if (tFolderName.IndexOf("_2") + 1 > 0)
								{
									Console.WriteLine("Here");
								}
								if (tFolderName.IndexOf("_system") + 1 > 0)
								{
									Console.WriteLine("Here");
								}
								
								string EmailFolderFQN = FolderFQN;
								
								string RetentionCode = "";
								int RetentionYears = 10;
								
								RetentionCode = getArchEmailFolderRetentionCode(ChildID, modGlobals.gCurrUserGuidID);
								if (RetentionCode.Length > 0)
								{
									RetentionYears = getRetentionPeriod(RetentionCode);
								}
								L = 21;
								EMF.setFolderid(ref ChildID);
								EMF.setFoldername(ref tFolderName);
								EMF.setParentfolderid(ref ParentID);
								try
								{
									EMF.setParentfoldername(ref FolderFQN);
								}
								catch (Exception)
								{
									LOG.WriteToArchiveLog((string) ("WARNING Failed to set parent folder: " + FolderFQN));
								}
								L = 22;
								EMF.setUserid(ref modGlobals.gCurrUserGuidID);
								
								//messagebox.show("TopFolder " + TopFolder  + " : " + "SubFolderName " + " : " + SubFolderName )
								bool BB = GetEmailFolderParms(TopFolder, modGlobals.gCurrUserGuidID, SubFolderName, ref ArchiveEmails, ref RemoveAfterArchive, ref SetAsDefaultFolder, ref ArchiveAfterXDays, ref RemoveAfterXDays, ref RemoveXDays, ref ArchiveXDays, ref DB_ID, ref ArchiveOnlyIfRead);
								
								//If xDebug Then log.WriteToArchiveLog("Code 200 Processing email folder: " + SubFolderName )
								
								if (BB)
								{
									L = 23;
									//If xDebug Then log.WriteToArchiveLog("Code 200a: " + SubFolderName )
									//Dim bUseQuickSearch As Boolean = False
									//Dim NbrOfIds As Integer = getCountStoreIdByFolder(EmailFolderFQN)
									//If NbrOfIds < 1000000 Then
									//   bUseQuickSearch = True
									//End If
									
									//Dim slEntryId As New SortedList
									//If bUseQuickSearch Then
									//    '** 001
									//    LoadEntryIdByFolder(EmailFolderFQN, slEntryId)
									//Else
									//    slEntryId.Clear()
									//End If
									L = 24;
									try
									{
										DBLocal.setOutlookMissing();
										//*************************************************************************************
										ArchiveEmailsInFolder(UID, TopFolder, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, CurrentFolder, StoreID, ArchiveOnlyIfRead, RetentionYears, RetentionCode, EmailFolderFQN, slStoreId, isPublic);
										//*************************************************************************************
										if (modGlobals.gTerminateImmediately)
										{
											//If ThreadingOn Then FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"
											frmNotify2.Default.Close();
											modGlobals.gOutlookArchiving = false;
											My.Settings.Default["LastArchiveEndTime"] = DateTime.Now;
											My.Settings.Default.Save();
											frmNotify2.Default.Close();
											return;
										}
										L = 25;
									}
									catch (Exception ex)
									{
										LOG.WriteToArchiveLog((string) ("ERROR 33.242.345 - " + ex.Message));
										LOG.WriteToArchiveLog((string) ("ERROR 33.242.345 - " + ex.StackTrace));
									}
									L = 26;
								}
								else
								{
									LOG.WriteToArchiveLog("ERROR 33.242.3 - Did not find \'" + TopFolder + "\' / " + "\'" + SubFolderName + ".");
								}
								L = 27;
							}
							L = 28;
						}
						catch (Exception ex)
						{
							string Msg = "ERROR:ArchiveEmailFolders 100.876.5:  Check to see the folders are defined properly. (Deactivate and reactivate). ";
							Msg = Msg + "   Check to see the folders are defined properly. (Deactivate and reactivate)." + "\r\n";
							Msg = Msg + "   There is a problem with TopFolder:\'" + TopFolder + "\'." + "\r\n";
							Msg = Msg + "        SubFolderName:\'" + SubFolderName + "\'." + "\r\n";
							Msg = Msg + "   Message: " + ex.Message;
							//frmHelp.MsgToDisplay  = Msg
							//frmHelp.CallingScreenName  = "Archive Email Folders"
							//frmHelp.CaptionName  = "EMAIL Archive Error"
							//frmHelp.Timer1.Interval = 10000
							//frmHelp.Show()
							LOG.WriteToArchiveLog(Msg);
						}
						L = 29;
SKIPTHISONE:
						1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
					}
					L = 20;
					DGV = null;
					GC.Collect();
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("ERROR: 100 ArchiveEmailFolders - " + ex.Message));
					LOG.WriteToArchiveLog((string) ("ERROR: 100 ArchiveEmailFolders - " + ex.StackTrace));
					LOG.WriteToArchiveLog((string) ("ERROR: 100 ArchiveEmailFolders - Line #" + L.ToString()));
				}
				finally
				{
					//If ThreadingOn Then FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"
				}
				
				//If ThreadingOn Then FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"
				UpdateAttachmentCounts();
				frmNotify2.Default.Close();
				modGlobals.gOutlookArchiving = false;
				
				My.Settings.Default["LastArchiveEndTime"] = DateTime.Now;
				My.Settings.Default.Save();
				
			}
			public void ArchiveSelectedOutlookFolders(string UID, string TopFolder, SortedList slStoreId)
			{
				try
				{
					frmMain.Default.EmailsBackedUp = 0;
					frmMain.Default.FilesBackedUp = 0;
					//********************************************************
					//PARAMETER: MailboxName = Name of Parent Outlook Folder for
					//the current user: Usually in the form of
					//"Mailbox - Doe, John" or
					//"Public Folders
					//RETURNS: Array of SubFolders in Current User's Mailbox
					//Or unitialized array if error occurs
					//Because it returns an array, it is for VB6 only.
					//Change to return a variant or a delimited list for
					//previous versions of vb
					//EXAMPLE:
					//Dim sArray() As String
					//Dim ictr As Integer
					//sArray = OutlookFolderNames("Mailbox - Doe, John")
					//            'On Error Resume Next
					//For ictr = 0 To UBound(sArray)
					// if xDebug then log.WriteToArchiveLog sArray(ictr)
					//Next
					//*********************************************************
					Outlook.Application oOutlook;
					Outlook._NameSpace oMAPI = null;
					Outlook.MAPIFolder oParentFolder = null;
					
					//Dim sArray() As String
					int i;
					int iElement = 0;
					
					oOutlook = new Outlook.Application();
					try
					{
						oMAPI = oOutlook.GetNamespace("MAPI");
					}
					catch (Exception ex)
					{
						MessageBox.Show(ex.Message);
					}
					
					string MailboxName = TopFolder;
					try
					{
						oParentFolder = oMAPI.GetFolderFromID(MailboxName, null);
					}
					catch (Exception ex)
					{
						//messagebox.show("ERROR 3421.45.a: could not open '" + MailboxName  + "' " + vbCrLf + ex.Message)
						LOG.WriteToArchiveLog((string) ("ERROR 3421.45.a: could not open \'" + MailboxName + "\' " + "\r\n" + ex.Message));
						LOG.WriteToArchiveLog((string) ("ERROR 3421.45.a:" + "\r\n" + ex.StackTrace));
						frmNotify2.Default.Close();
						return;
					}
					
					//AddChildFolders(LB, MailboxName )
					
					string FolderName = "";
					string ArchiveEmails = "";
					string RemoveAfterArchive = "";
					string SetAsDefaultFolder = "";
					string ArchiveAfterXDays = "";
					string RemoveAfterXDays = "";
					string RemoveXDays = "";
					string ArchiveXDays = "";
					string DB_ID = "";
					bool DeleteFile = false;
					clsArchiver ARCH = new clsArchiver();
					string ArchiveOnlyIfRead = "";
					
					//************************************
					string isPublic = "N";
					
					if (oParentFolder.Folders.Count != 0)
					{
						if (xDebug)
						{
							LOG.WriteToArchiveLog("** : " + TopFolder + " folder count = " + oParentFolder.Folders.Count.ToString() + ".");
						}
						for (i = 1; i <= oParentFolder.Folders.Count; i++)
						{
							if (i > oParentFolder.Folders.Count)
							{
								break;
							}
							if (Strings.Trim(oParentFolder.Folders[i].Name) != "")
							{
								if (xDebug)
								{
									LOG.WriteToArchiveLog("100 Processing email folder: " + oParentFolder.Folders[i].Name);
								}
								string ParentID = oParentFolder.EntryID;
								string ChildID = oParentFolder.Folders[i].EntryID;
								string tFolderName = oParentFolder.Folders[i].Name;
								var CurrentFolder = oParentFolder.Folders(i);
								string StoreID = oParentFolder.StoreID;
								
								if (tFolderName.IndexOf("_2") + 1 > 0)
								{
									Console.WriteLine("Here");
								}
								if (tFolderName.IndexOf("_system") + 1 > 0)
								{
									Console.WriteLine("Here");
								}
								
								string EmailFolderFQN = TopFolder + "|" + tFolderName;
								
								int BB = ckArchEmailFolder(EmailFolderFQN, modGlobals.gCurrUserGuidID);
								if (xDebug)
								{
									LOG.WriteToArchiveLog("** EmailFolderFQN : " + EmailFolderFQN + ".");
								}
								
								if (BB > 0)
								{
									string RetentionCode = "";
									int RetentionYears = 10;
									
									RetentionCode = getArchEmailFolderRetentionCode(ChildID, modGlobals.gCurrUserGuidID);
									if (RetentionCode.Length > 0)
									{
										RetentionYears = getRetentionPeriod(RetentionCode);
									}
									
									EMF.setFolderid(ref ChildID);
									EMF.setFoldername(ref tFolderName);
									EMF.setParentfolderid(ref ParentID);
									EMF.setParentfoldername(oParentFolder.Name);
									EMF.setUserid(ref modGlobals.gCurrUserGuidID);
									BB = GetEmailFolderParms(TopFolder, modGlobals.gCurrUserGuidID, tFolderName, ref ArchiveEmails, ref RemoveAfterArchive, ref SetAsDefaultFolder, ref ArchiveAfterXDays, ref RemoveAfterXDays, ref RemoveXDays, ref ArchiveXDays, ref DB_ID, ref ArchiveOnlyIfRead);
									
									if (BB)
									{
										
										//Dim bUseQuickSearch As Boolean = False
										//Dim NbrOfIds As Integer = getCountStoreIdByFolder(EmailFolderFQN)
										//If NbrOfIds < 1000000 Then
										//    bUseQuickSearch = True
										//End If
										
										//Dim slEntryId As New SortedList
										//If bUseQuickSearch Then
										//    '** 003
										//    LoadEntryIdByFolder(EmailFolderFQN, slEntryId, NbrOfIds)
										//Else
										//    slEntryId.Clear()
										//End If
										
										//*************************************************************************************
										DBLocal.setOutlookMissing();
										
										ARCH.ArchiveEmailsInFolder(UID, TopFolder, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, CurrentFolder, StoreID, ArchiveOnlyIfRead, RetentionYears, RetentionCode, EmailFolderFQN, slStoreId, isPublic);
										//*************************************************************************************
									}
								}
							}
GetNextParentFolder:
							1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
						}
					}
					
					
					foreach (Outlook.MAPIFolder oChildFolder in oParentFolder.Folders)
					{
						int K = 0;
						K = oChildFolder.Folders.Count;
						string pFolder = oParentFolder.Name.ToString();
						string cFolder = oChildFolder.Name.ToString();
						string EmailFolderFQN = TopFolder + "|" + cFolder;
						Console.WriteLine(pFolder + " / " + cFolder + " : " + K.ToString());
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("Examine Child Folder: " + pFolder + " / " + cFolder + " : " + K.ToString()));
						}
						if (cFolder.IndexOf("_2") + 1 > 0)
						{
							Console.WriteLine("Here");
						}
						if (cFolder.IndexOf("_system") + 1 > 0)
						{
							Console.WriteLine("Here");
						}
						int II = ckArchEmailFolder(EmailFolderFQN, modGlobals.gCurrUserGuidID);
						if (II > 0)
						{
							if (K > 0)
							{
								ListChildFolders(UID, EmailFolderFQN, TopFolder, cFolder, oChildFolder, cFolder, slStoreId, isPublic);
							}
						}
					}
					oMAPI = null;
					GC.Collect();
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("Error processing \'" + TopFolder + "\' 653.21b: " + ex.Message));
					LOG.WriteToArchiveLog((string) ("Error processing 653.21b: " + "\r\n" + ex.StackTrace));
					//messagebox.show("Error processing '" + TopFolder  + "' 653.21b: " + ex.Message)
				}
				
			}
			public bool getCurrentOutlookFolders(string TopFolder, SortedList<string, string> ChildFoldersList)
			{
				
				if (dDebug)
				{
					LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 1");
				}
				
				if (TopFolder.Trim().Length == 0)
				{
					frmNotify2.Default.Close();
					return true;
				}
				
				if (dDebug)
				{
					LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 2");
				}
				
				bool B = false;
				
				try
				{
					//********************************************************
					//PARAMETER: MailboxName = Name of Parent Outlook Folder for
					//the current user: Usually in the form of
					//"Mailbox - Doe, John" or
					//"Public Folders
					//RETURNS: Array of SubFolders in Current User's Mailbox
					//Or unitialized array if error occurs
					//Because it returns an array, it is for VB6 only.
					//Change to return a variant or a delimited list for
					//previous versions of vb
					//EXAMPLE:
					//Dim sArray() As String
					//Dim ictr As Integer
					//sArray = OutlookFolderNames("Mailbox - Doe, John")
					//            'On Error Resume Next
					//For ictr = 0 To UBound(sArray)
					// if xDebug then log.WriteToArchiveLog sArray(ictr)
					//Next
					//*********************************************************
					
					if (dDebug)
					{
						LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 3");
					}
					
					Outlook.Application oOutlook;
					if (dDebug)
					{
						LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 4");
					}
					Outlook.NameSpace oMAPI = null;
					if (dDebug)
					{
						LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 5");
					}
					Outlook.MAPIFolder oParentFolder = null;
					
					//Dim sArray() As String
					int i;
					int iElement = 0;
					
					if (dDebug)
					{
						LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 6");
					}
					oOutlook = new Outlook.Application();
					if (dDebug)
					{
						LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 7");
					}
					try
					{
						oMAPI = oOutlook.GetNamespace("MAPI");
					}
					catch (Exception ex)
					{
						LOG.WriteToArchiveLog((string) ("ERROR: getCurrentOutlookFolders 100  : " + ex.Message));
						LOG.WriteToArchiveLog((string) ("ERROR: getCurrentOutlookFolders 100a : " + ex.StackTrace));
						oParentFolder = null;
						oMAPI = null;
						oOutlook = null;
						return false;
					}
					
					string MailboxName = TopFolder;
					try
					{
						oParentFolder = oMAPI.Folders[MailboxName];
					}
					catch (Exception ex)
					{
						LOG.WriteToArchiveLog((string) ("NOTICE: getCurrentOutlookFolders 200  : " + ex.Message));
						LOG.WriteToArchiveLog((string) ("NOTICE: getCurrentOutlookFolders 200a : " + ex.StackTrace));
						oParentFolder = null;
						oMAPI = null;
						oOutlook = null;
						return false;
					}
					
					//AddChildFolders(LB, MailboxName )
					string UID = "";
					string FolderName = "";
					string ArchiveEmails = "";
					string RemoveAfterArchive = "";
					string SetAsDefaultFolder = "";
					string ArchiveAfterXDays = "";
					string RemoveAfterXDays = "";
					string RemoveXDays = "";
					string ArchiveXDays = "";
					string DB_ID = "";
					bool DeleteFile = false;
					clsArchiver ARCH = new clsArchiver();
					string ArchiveOnlyIfRead = "";
					
					if (dDebug)
					{
						LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 8");
					}
					
					ChildFoldersList.Clear();
					
					if (oParentFolder.Folders.Count > 0)
					{
						for (i = 1; i <= oParentFolder.Folders.Count; i++)
						{
							if (Strings.Trim(oParentFolder.Folders[i].Name) != "")
							{
								string ParentID = oParentFolder.EntryID;
								string ChildID = oParentFolder.Folders[i].EntryID;
								string tFolderName = oParentFolder.Folders[i].Name;
								var CurrentFolder = oParentFolder.Folders(i);
								string StoreID = oParentFolder.StoreID;
								
								if (ChildFoldersList.IndexOfKey(tFolderName) > 0)
								{
								}
								else if (ChildFoldersList.ContainsKey(tFolderName))
								{
								}
								else
								{
									try
									{
										ChildFoldersList.Add(tFolderName, ChildID);
									}
									catch (Exception ex)
									{
										LOG.WriteToArchiveLog((string) ("Warning No Load: getCurrentOutlookFolders - Name: " + tFolderName));
										LOG.WriteToArchiveLog((string) ("Warning No Load: getCurrentOutlookFolders - ChildFoldersList.Add: " + ex.Message));
									}
								}
								
							}
						}
					}
					
					foreach (Outlook.MAPIFolder oChildFolder in oParentFolder.Folders)
					{
						int K = 0;
						K = oChildFolder.Folders.Count;
						string cFolder = oChildFolder.Name.ToString();
						//Console.WriteLine("Child Folder: " + cFolder)
						if (K > 0)
						{
							ListChildFolders(oChildFolder, cFolder);
						}
					}
					if (dDebug)
					{
						LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 9");
					}
					oMAPI = null;
					GC.Collect();
					B = true;
				}
				catch (Exception ex)
				{
					if (dDebug)
					{
						LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 10");
					}
					bool bOfficeInstalled = UTIL.isOfficeInstalled();
					if (bOfficeInstalled == false)
					{
						LOG.WriteToArchiveLog("Error 653.20c: clsArchiver : getCurrentOutlookFolders - OFFICE appears not to be installed.");
						try
						{
							ChildFoldersList.Add("* MS Office not found", "* MS Office not found");
						}
						catch (Exception)
						{
							
						}
						
					}
					try
					{
						ChildFoldersList.Add("* Folders not found", "* Folders not found");
					}
					catch (Exception)
					{
						
					}
					LOG.WriteToArchiveLog((string) ("Error 653.21c: clsArchiver : getCurrentOutlookFolders - Outlook appears to be unavailable, " + ex.Message));
					B = false;
				}
				if (dDebug)
				{
					LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 11");
				}
				return B;
			}
			private void DeleteMessage(string sStoreID, string sMessageID)
			{
				// Create Outlook application.
				Outlook.Application oApp;
				oApp = new Outlook.Application();
				// Get Mapi NameSpace.
				Outlook.NameSpace oNS;
				oNS = oApp.GetNamespace("mapi");
				oNS.Logon("Outlook", null, false, true);
				//Dim oMsg As MailItem
				Outlook.MailItem oMsg;
				
				oMsg = oNS.GetItemFromID(sMessageID, sStoreID);
				oMsg.Delete();
				
				LOG.WriteToArchiveLog("clsArchiver : DeleteMessage : Delete Performed 12");
				
				// Log off.
				oNS.Logoff();
				
				// Clean up.
				oApp = null;
				oNS = null;
				//oItems = Nothing
				oMsg = null;
			}
			public void DeleteOutlookMessages(string UserID)
			{
				
				try
				{
					if (UserID.Length == 0)
					{
						if (modGlobals.gCurrLoginID.Length > 0)
						{
							modGlobals.gCurrUserGuidID = this.getUserGuidID(modGlobals.gCurrLoginID);
							if (modGlobals.gCurrUserGuidID.Length == 0)
							{
								LOG.WriteToArchiveLog("ERROR: DeleteOutlookMessages - UserID missing and CUrrent User Login ID could not be used to find it.");
								return;
							}
						}
						else
						{
							return;
						}
					}
					string S = "Select [EmailGuid],[StoreID],[UserID], [MessageID] FROM [EmailToDelete] where userid = \'" + UserID + "\'";
					
					bool b = true;
					int i = 0;
					int id = -1;
					int II = 0;
					string table_name = "";
					string column_name = "";
					string data_type = "";
					string character_maximum_length = "";
					
					// Create Outlook application.
					Outlook.Application oApp;
					oApp = new Outlook.Application();
					// Get Mapi NameSpace.
					Outlook.NameSpace oNS;
					oNS = oApp.GetNamespace("mapi");
					oNS.Logon("Outlook", null, false, true);
					//Dim oMsg As MailItem
					Outlook.MailItem oMsg;
					
					Outlook.MAPIFolder oDeletedItems = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderDeletedItems);
					
					SqlDataReader rsdata = null;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					rsdata = command.ExecuteReader();
					
					if (rsdata.HasRows)
					{
						while (rsdata.Read())
						{
							Application.DoEvents();
							string MessageID = rsdata.GetValue(3).ToString().Trim();
							string StoreID = rsdata.GetValue(1).ToString().Trim();
							try
							{
								oMsg = oNS.GetItemFromID(MessageID, StoreID);
								if (oMsg != null)
								{
									II++;
									//frmReconMain.SB.Text = "Processing Expired Email from Outlook# " & II
									//frmReconMain.SB.Refresh()
									Application.DoEvents();
									//oMsg.Delete()
									oMsg.Move(oDeletedItems);
									if (xDebug)
									{
										LOG.WriteToArchiveLog((string) ("EXPIRATION: clsArchiver:DeleteOutlookMessages : Delete Performed 15 - Message# " + II.ToString()));
									}
									Application.DoEvents();
								}
							}
							catch (Exception ex)
							{
								if (ex.Message.IndexOf("cannot be found") + 1 > 0)
								{
								}
								else
								{
									LOG.WriteToArchiveLog((string) ("ERROR 054.31: Failed to delete msg " + ex.Message.ToString()));
								}
							}
						}
					}
					else
					{
						id = -1;
					}
					
					if (! rsdata.IsClosed)
					{
						rsdata.Close();
					}
					rsdata = null;
					command.Dispose();
					command = null;
					
					if (CONN.State == ConnectionState.Open)
					{
						CONN.Close();
					}
					CONN.Dispose();
					
					oApp = null;
					oNS = null;
					oMsg = null;
					
					ZeroizeEmailToDelete(UserID);
					//frmReconMain.SB.Text = "Done..."
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("ERROR: DeleteOutlookMessages - " + ex.Message));
				}
				
			}
			
			public void UpdateMessageStoreID(string UserID)
			{
				string[] A = new string[1];
				string S = "Select [EmailGuid],[StoreID],[UserID], [MessageID] FROM  [EmailToDelete] where userid = \'" + UserID + "\'";
				
				bool b = true;
				int i = 0;
				int id = -1;
				int II = 0;
				string table_name = "";
				string column_name = "";
				string data_type = "";
				string character_maximum_length = "";
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						var EmailGuid = RSData.GetValue(0).ToString().Trim();
						string StoreID = RSData.GetValue(1).ToString().Trim();
						string MySql = "UPDATE  [Email] SET [StoreID] = \'" + StoreID + "\' WHERE [EmailGuid] = \'" + EmailGuid + "\'";
						Array.Resize(ref A, ((A.Length - 1) + 1) + 1);
						A[(A.Length - 1)] = MySql;
					}
				}
				else
				{
					id = -1;
				}
				
				RSData.Close();
				RSData = null;
				GC.Collect();
				
				for (II = 0; II <= (A.Length - 1) - 1; II++)
				{
					frmMain.Default.SB.Text = "Setting SourceID: " + II.ToString();
					frmMain.Default.SB.Refresh();
					S = A[II];
					if (S != null)
					{
						b = ExecuteSqlNewConn(S, false);
					}
					if (! b)
					{
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("Failed to update: " + S));
						}
					}
				}
				
			}
			
			public bool RestoreEmail(string EmailGuid)
			{
				
				const int olByValue = 1;
				string BccList = "";
				string CcList = "";
				string SendToAddr = "";
				string SubjLong = "";
				string Body = "";
				string SourceName = "";
				string AttachmentFQN = "";
				
				Outlook.Application oApp;
				Outlook.MailItem oEmail;
				oApp = new Outlook.Application();
				oEmail = oApp.CreateItem(Outlook.OlItemType.olMailItem);
				
				oEmail.To = SendToAddr;
				oEmail.CC = CcList;
				oEmail.BCC = BccList;
				oEmail.Subject = SubjLong;
				oEmail.BodyFormat = Outlook.OlBodyFormat.olFormatUnspecified;
				oEmail.Body = Body;
				oEmail.Importance = Outlook.OlImportance.olImportanceNormal;
				oEmail.ReadReceiptRequested = false;
				MessageBox.Show("Get each attachment here");
				oEmail.Attachments.Add(AttachmentFQN, olByValue, SourceName, null);
				oEmail.Recipients.ResolveAll();
				oEmail.Save();
				oEmail.Display(null); //Show the email message and allow for editing before sending
				//.Send 'You can automatically send the email without displaying it.
				
				oEmail = null;
				oApp.Quit();
				oApp = null;
			}
			public bool SendEmail()
			{
				const int olByValue = 1;
				string BccList = "";
				string CcList = "";
				string SendToAddr = "";
				string SubjLong = "";
				string Body = "";
				string SourceName = "";
				string AttachmentFQN = "";
				
				Outlook.Application oApp;
				Outlook.MailItem oEmail;
				oApp = new Outlook.Application();
				oEmail = oApp.CreateItem(Outlook.OlItemType.olMailItem);
				oEmail.To = SendToAddr;
				oEmail.CC = CcList;
				oEmail.BCC = BccList;
				oEmail.Subject = SubjLong;
				oEmail.BodyFormat = Outlook.OlBodyFormat.olFormatUnspecified;
				oEmail.Body = Body;
				oEmail.Importance = Outlook.OlImportance.olImportanceNormal;
				oEmail.ReadReceiptRequested = false;
				MessageBox.Show("Get each attachment here");
				oEmail.Attachments.Add(AttachmentFQN, olByValue, SourceName, null);
				oEmail.Recipients.ResolveAll();
				oEmail.Save();
				oEmail.Send(); //You can automatically send the email without displaying it.
				oEmail = null;
				oApp.Quit();
				oApp = null;
			}
			public void ShellFile(string File)
			{
				ShellExecute(0, "open", File, "0", "0", 1);
			}
			
			public void OSDisplayFile()
			{
				string sFile = "C:\\Users\\wmiller\\Documents\\Documents on Dale\'s PDA\\RENT REH.doc";
				ShellFile(sFile);
				long ln;
				long hWndDesk = GetDesktopWindow();
				
				sFile = "c:\\hpfr3420.xml";
				return;
				
//				long Scr_hDC;
//				Scr_hDC = GetDesktopWindow();
//				ln = ShellExecute(0, "", sFile, "", "", 1);
				
				
//				ln = ShellExecute(0, Constants.vbNullString, "notepad", sFile, Constants.vbNullString, Constants.vbNormalFocus);
				
//				if (xDebug)
//				{
//					LOG.WriteToArchiveLog((string) ("LN = " + ln.ToString()));
//					}
					//ShellExecute 0&, vbNullString, "notepad", "c:\test.doc", vbNullString, vbNormalFocus
//					ln = ShellExecute(0, Constants.vbNullString, sFile, Constants.vbNullString, Constants.vbNullString, Constants.vbNormalFocus);
//					if (ln < 32)
//					{
//						Interaction.Shell("rundll32.exe shell32.dll,OpenAs_RunDLL " + sFile, Constants.vbNormalFocus, 0, -1);
//						}
						//opens C:\test.doc with its default viewer. Note that if the path you pass contains spaces, you need to surround it by quotes:
					}
					public void XXX()
					{
						
						long hWndDesk = GetDesktopWindow();
						Outlook.Application oApp = new Outlook.Application();
						
						string sBuild = oApp.Version.Substring(0, oApp.Version.IndexOf(".") + 2);
						Outlook.NameSpace oNS = oApp.GetNamespace("mapi");
						
						Outlook.MailItem oItem;
						oApp = Interaction.CreateObject("Outlook.Application", "");
						oNS = oApp.GetNamespace("MAPI");
						
						//oItem = oApp.ActiveInspector.CurrentItem
						
						
						//Private Sub Command1_Click()
						string sFile = modGlobals.gTempDir + "\\Enterprise Business Alert  March Toward Mobilization.eml";
						long ln;
						ln = ShellExecute(hWndDesk, "Open", sFile, "", "", 1);
						
						if (ln < 32)
						{
							Interaction.Shell("rundll32.exe shell32.dll,OpenAs_RunDLL " + sFile, Constants.vbNormalFocus, 0, -1);
						}
						
						while (oApp.ActiveInspector() == null)
						{
							Application.DoEvents();
						}
						
						oItem = oApp.CopyFile(sFile, "Restored Emails");
						
						oItem = oApp.ActiveInspector().CurrentItem;
						oItem.Copy();
						
						
						
					}
					public void SendNow()
					{
						Outlook.Application oApp;
						//Dim oCtl As Office.CommandBarControl
						//Dim oPop As Office.CommandBarPopup
						//Dim oCB As Office.CommandBar
						Outlook.NameSpace oNS;
						object oItem;
						
						//First find and send the current item to the Outbox
						oApp = Interaction.CreateObject("Outlook.Application", "");
						oNS = oApp.GetNamespace("MAPI");
						oItem = oApp.ActiveInspector().CurrentItem;
						try
						{
							oItem.Send();
						}
						catch (Exception ex)
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog(ex.Message);
							}
						}
						
						
						
						oApp = null;
						//oCtl = Nothing
						//oPop = Nothing
						//oCB = Nothing
						oNS = null;
						oItem = null;
					}
					
					public void ArchiveRSS(string UserID)
					{
						
						bool isPublic = true;
						bool CaptureLink = true;
						string RssFQN = "";
						string RssName = "";
						string RssUrl = "";
						string OwnerID = "";
						string RetentionCode = "";
						string RowGuid = "";
						string KeyWords;
						string WhereClause = "";
						string MySql = "";
						bool RC = false;
						
						string RssTitle = "";
						string pubdate = "";
						string rlink = "";
						string desc = "";
						List<rssChannelItem> listOfRssPages = new List<rssChannelItem>();
						
						if (UserID.Equals("*"))
						{
							WhereClause = "";
						}
						else if (UserID.Length > 0)
						{
							WhereClause = " where UserID = \'" + UserID + "\'";
						}
						
						List<string> ListOfUrls = new List<string>();
						ListOfUrls = GET_RssPullData(modGlobals.gGateWayID, WhereClause, RC);
						
						frmNotify2 RssInfo = new frmNotify2();
						RssInfo.Show();
						RssInfo.Text = "RSS Archive";
						//** We have all of the registered RSS feeds
						int K = 0;
						foreach (var xStr in ListOfUrls)
						{
							K++;
							string[] S = xStr.Split("|");
							//Dim strItems = RssName + "|" + RssUrl + "|" + UserID
							RssName = S[0];
							RssUrl = S[1];
							OwnerID = S[2];
							RetentionCode = S[3];
							RowGuid = S[4];
							
							RssInfo.lblEmailMsg.Text = RssName;
							RssInfo.lblMsg2.Text = RssUrl;
							RssInfo.lblFolder.Text = K.ToString() + " of " + ListOfUrls.Count.ToString();
							RssInfo.Refresh();
							Application.DoEvents();
							
							List<rssChannelItem> ChannelItems = new List<rssChannelItem>();
							clsRSS RSS = new clsRSS();
							//ChannelItems = ReadRssDataFromSite(RssUrl As String, CaptureLink As Boolean) As List(Of rssChannelItem)
							ChannelItems = RSS.ReadRssDataFromSite(RssUrl, true);
							RSS = null;
							GC.Collect();
							GC.WaitForPendingFinalizers();
							
							int I = 0;
							foreach (rssChannelItem ChannelItem in ChannelItems)
							{
								I++;
								RssTitle = ChannelItem.title;
								pubdate = ChannelItem.pubDate;
								rlink = ChannelItem.link;
								desc = ChannelItem.description;
								RssFQN = ChannelItem.webFqn;
								KeyWords = ChannelItem.keyWords;
								
								RssInfo.lblMsg2.Text = RssTitle;
								RssInfo.lblFolder.Text = I.ToString() + " of " + ChannelItems.Count.ToString();
								RssInfo.Refresh();
								Application.DoEvents();
								
								if (RssFQN.Trim().Length > 0)
								{
									//We may want to use a CE database here to speed thing up
									ArchiveRssFeed(RowGuid, RssTitle, rlink, desc, KeyWords, RssFQN, RetentionCode, DateTime.Parse(pubdate), isPublic.ToString());
								}
							}
							
						}
						GC.Collect();
						GC.WaitForPendingFinalizers();
						RssInfo.Close();
						RssInfo.Dispose();
					}
					
					public void ArchiveRssFeed(string RssRowGuid, string RssName, string RssLink, string RssDesc, string KeyWords, string RssFQN, string RetentionCode, DateTime RssPublishDate, string isPublic)
					{
						
						if (! File.Exists(RssFQN))
						{
							MessageBox.Show((string) ("RSS Feed could not be processed: " + "\r\n" + RssFQN));
							return;
						}
						
						string FileText = ReadFileIntoString(RssFQN);
						string CrcHash = ENC.getSha1HashKey(FileText);
						
						string RssDescription = RssDesc.Replace("\'", "\'\'");
						var file_SourceName = RssFQN;
						string SourceGuid = Guid.NewGuid().ToString();
						
						string RSSProcessingDir = System.Configuration.ConfigurationManager.AppSettings["RSSProcessingDir"];
						
						if (! Directory.Exists(RSSProcessingDir))
						{
							Directory.CreateDirectory(RSSProcessingDir);
						}
						
						string ckMetaData = "N";
						int LastVerNbr = 0;
						
						FileInfo FI = new FileInfo(RssFQN);
						string OriginalFileType = FI.Extension;
						string file_SourceTypeCode = FI.Extension;
						string file_FullName = FI.Name;
						//Dim file_LastAccessDate As String = FI.LastAccessTime.ToString
						string file_LastAccessDate = FI.LastAccessTime.ToString();
						string file_CreateDate = FI.CreationTime;
						string file_LastWriteTime = RssPublishDate.ToString();
						string file_Length = FI.Length.ToString();
						FI = null;
						
						if (int.Parse(file_Length) == 0)
						{
							MessageBox.Show((string) ("Bad file: " + RssFQN));
							return;
						}
						
						GC.Collect();
						GC.WaitForPendingFinalizers();
						
						//Dim iDatasourceCnt As Integer = getCountDataSourceFiles(file_FullName, CrcHash)
						int iDatasourceCnt = getCountRssFile(file_FullName, RssPublishDate.ToString());
						if (iDatasourceCnt == 0)
						{
							saveContentOwner(SourceGuid, modGlobals.gCurrUserGuidID, "C", RSSProcessingDir, modGlobals.gMachineID, modGlobals.gNetworkID);
						}
						
						if (iDatasourceCnt == 0)
						{
							
							DateTime StartInsert = DateTime.Now;
							LOG.WriteToTimerLog("Start ArchiveRssFeed", (string) ("InsertRSSFeed:" + file_FullName), "START");
							
							bool BB = InsertSourcefile(modGlobals.gCurrUserGuidID, modGlobals.gMachineID, modGlobals.gNetworkID, SourceGuid, RssFQN, file_FullName, file_SourceTypeCode, file_LastAccessDate, file_CreateDate, file_LastWriteTime, modGlobals.gCurrUserGuidID, LastVerNbr, RetentionCode, isPublic, CrcHash, RSSProcessingDir);
							
							if (BB)
							{
								LOG.WriteToTimerLog("END ArchiveRssFeed", (string) ("InsertSourcefile" + file_FullName), "STOP", StartInsert);
							}
							else
							{
								LOG.WriteToTimerLog("FAIL ArchiveRssFeed", (string) ("InsertSourcefile" + file_FullName), "STOP", StartInsert);
							}
							
							if (BB)
							{
								
								string VersionNbr = "0";
								DateTime UpdateInsert = DateTime.Now;
								LOG.WriteToTimerLog("ArchiveRssFeed", (string) ("UpdateInsert:" + file_FullName), "STOP");
								
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("clsArchiver:ArchiveContent 1000 inserted new file " + file_FullName));
								}
								if (OcrText.Trim().Length > 0)
								{
									string SS = "";
									AppendOcrText(SourceGuid, OcrText);
								}
								
								insertrSSChild(RssRowGuid, SourceGuid);
								UpdateSourceCRC(SourceGuid, CrcHash);
								UpdateRssLinkFlgToTrue(SourceGuid);
								UpdateContentDescription(SourceGuid, RssDescription);
								UpdateContentKeyWords(SourceGuid, KeyWords);
								UpdateWebPageUrlRef(SourceGuid, RssLink);
								UpdateDocFqn(SourceGuid, file_FullName);
								UpdateDocSize(SourceGuid, file_Length);
								UpdateDocDir(SourceGuid, file_FullName);
								UpdateDocOriginalFileType(SourceGuid, OriginalFileType);
								
								UpdateWebPageUrlRef(SourceGuid, RssLink);
								UpdateWebPageHash(SourceGuid, ENC.getSha1HashKey(RssLink));
								UpdateWebPagePublishDate(SourceGuid, RssPublishDate.ToString());
								
								setRetentionDate(SourceGuid, RetentionCode, OriginalFileType);
								
								InsertSrcAttrib(SourceGuid, "FILENAME", file_SourceName, OriginalFileType);
								InsertSrcAttrib(SourceGuid, "CreateDate", file_CreateDate, OriginalFileType);
								InsertSrcAttrib(SourceGuid, "FILESIZE", file_Length, OriginalFileType);
								InsertSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessDate, OriginalFileType);
								InsertSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, OriginalFileType);
								
								if (! file_SourceTypeCode.Equals(OriginalFileType))
								{
									InsertSrcAttrib(SourceGuid, "IndexAs", file_LastWriteTime, file_SourceTypeCode);
								}
								
								LOG.WriteToTimerLog("ArchiveRssFeed", (string) ("InsertRSSFeed" + file_FullName), "STOP", UpdateInsert);
							}
							
						}
						try
						{
							File.Delete(RssFQN);
						}
						catch (Exception)
						{
							Console.WriteLine("Failed to delete " + RssFQN);
						}
						
						
					}
					
					public void ArchiveRssFeedWebPage(string RssSourceGuid, string WebPageURL, string WebPageFQN, string RetentionCode, string isPublic)
					{
						
						string CrcHash = ENC.getSha1HashFromFile(WebPageFQN);
						var file_SourceName = WebPageFQN;
						string SourceGuid = Guid.NewGuid().ToString();
						
						string WEBProcessingDir = System.Configuration.ConfigurationManager.AppSettings["WEBProcessingDir"];
						if (! Directory.Exists(WEBProcessingDir))
						{
							Directory.CreateDirectory(WEBProcessingDir);
						}
						
						string ckMetaData = "N";
						int LastVerNbr = 0;
						
						FileInfo FI = new FileInfo(WebPageFQN);
						string OriginalFileType = FI.Extension;
						string file_SourceTypeCode = FI.Extension;
						string file_FullName = FI.Name;
						string file_LastAccessDate = FI.LastAccessTime.ToString();
						string file_CreateDate = FI.CreationTime.ToString();
						string file_LastWriteTime = FI.LastWriteTime.ToString();
						string file_Length = FI.Length.ToString();
						FI = null;
						
						GC.Collect();
						GC.WaitForPendingFinalizers();
						
						
						int iDatasourceCnt = getCountDataSourceFiles(file_SourceName, CrcHash);
						if (iDatasourceCnt == 0)
						{
							saveContentOwner(SourceGuid, modGlobals.gCurrUserGuidID, "C", WEBProcessingDir, modGlobals.gMachineID, modGlobals.gNetworkID);
						}
						
						if (iDatasourceCnt == 0)
						{
							
							DateTime StartInsert = DateTime.Now;
							LOG.WriteToTimerLog("Start ArchiveRssFeedWebPage", (string) ("InsertRSSFeed:" + file_FullName), "START");
							
							bool BB = InsertSourcefile(modGlobals.gCurrUserGuidID, modGlobals.gMachineID, modGlobals.gNetworkID, SourceGuid, file_FullName, file_SourceName, file_SourceTypeCode, file_LastAccessDate, file_CreateDate, file_LastWriteTime, modGlobals.gCurrUserGuidID, LastVerNbr, RetentionCode, isPublic, CrcHash, WEBProcessingDir);
							
							if (BB)
							{
								insertSourceChild(RssSourceGuid, SourceGuid);
								LOG.WriteToTimerLog("END ArchiveRssFeedWebPage", (string) ("InsertSourcefile" + file_FullName), "STOP", StartInsert);
							}
							else
							{
								LOG.WriteToTimerLog("FAIL ArchiveRssFeedWebPage", (string) ("InsertSourcefile" + file_FullName), "STOP", StartInsert);
							}
							
							if (BB)
							{
								
								string VersionNbr = "0";
								DateTime UpdateInsert = DateTime.Now;
								LOG.WriteToTimerLog("ArchiveRssFeedWebPage", (string) ("UpdateInsert:" + file_FullName), "STOP");
								
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("clsArchiver:ArchiveContent 1000 inserted new file " + file_FullName));
								}
								if (OcrText.Trim().Length > 0)
								{
									string SS = "";
									AppendOcrText(SourceGuid, OcrText);
								}
								
								UpdateDocFqn(SourceGuid, file_FullName);
								UpdateDocSize(SourceGuid, file_Length);
								UpdateDocDir(SourceGuid, file_FullName);
								UpdateDocOriginalFileType(SourceGuid, OriginalFileType);
								setRetentionDate(SourceGuid, RetentionCode, OriginalFileType);
								
								MessageBox.Show((string) ("Mark as a WEB page here." + WebPageURL));
								
								//delFileParms(SourceGuid )
								InsertSrcAttrib(SourceGuid, "FILENAME", file_SourceName, OriginalFileType);
								InsertSrcAttrib(SourceGuid, "CreateDate", file_CreateDate, OriginalFileType);
								InsertSrcAttrib(SourceGuid, "FILESIZE", file_Length, OriginalFileType);
								InsertSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessDate, OriginalFileType);
								InsertSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, OriginalFileType);
								
								if (! file_SourceTypeCode.Equals(OriginalFileType))
								{
									InsertSrcAttrib(SourceGuid, "IndexAs", file_LastWriteTime, file_SourceTypeCode);
								}
								
								LOG.WriteToTimerLog("ArchiveRssFeedWebPage", (string) ("InsertRSSFeed" + file_FullName), "STOP", UpdateInsert);
							}
							
						}
						File.Delete(WebPageFQN);
					}
					
					public void ArchiveWebSites(string UserID)
					{
						
						clsWebPull WEB = new clsWebPull();
						
						bool isPublic = true;
						bool CaptureLink = true;
						string SiteFQN = "";
						string WebSite = "";
						string WebUrl = "";
						string Depth = "";
						string Width = "";
						string OwnerID = "";
						string RetentionCode = "";
						string RowGuid = "";
						string WhereClause = "";
						bool RC = false;
						
						string RssTitle = "";
						string pubdate = "";
						string rlink = "";
						string desc = "";
						List<dsWebSite> listOfWebSites = new List<dsWebSite>();
						
						
						if (UserID.Equals("*"))
						{
							WhereClause = "";
						}
						else if (UserID.Length > 0)
						{
							WhereClause = " where UserID = \'" + UserID + "\'";
						}
						
						List<string> ListOfUrls = new List<string>();
						ListOfUrls = GET_WebSiteData(modGlobals.gGateWayID, WhereClause, RC);
						
						frmNotify2 WebInfo = new frmNotify2();
						WebInfo.Show();
						WebInfo.Text = "RSS Archive";
						//** We have all of the registered RSS feeds
						int K = 0;
						foreach (var xStr in ListOfUrls)
						{
							K++;
							string[] S = xStr.Split("|");
							//Dim strItems = WebSite + "|" + WebUrl + "|" + UserID + "|" + Depth + "|" + Width + "|" + RetentionCode + "|" + RowGuid
							WebSite = S[0];
							WebUrl = S[1];
							OwnerID = S[2];
							Depth = S[3];
							Width = S[4];
							RetentionCode = S[5];
							RowGuid = S[6];
							
							WebInfo.lblEmailMsg.Text = WebSite;
							WebInfo.lblMsg2.Text = WebUrl;
							WebInfo.lblFolder.Text = K.ToString() + " of " + ListOfUrls.Count.ToString();
							WebInfo.Refresh();
							Application.DoEvents();
							
							spiderWeb(WebUrl, int.Parse(Depth), int.Parse(Width), isPublic.ToString(), RetentionCode);
							
						}
						WEB = null;
						GC.Collect();
						GC.WaitForPendingFinalizers();
						WebInfo.Close();
						WebInfo.Dispose();
						GC.Collect();
						GC.WaitForPendingFinalizers();
						
					}
					
					public void ArchiveSingleWebPage(string UserID)
					{
						
						clsWebPull WEB = new clsWebPull();
						
						bool isPublic = true;
						bool CaptureLink = true;
						string SiteFQN = "";
						string WebSite = "";
						string WebUrl = "";
						string Depth = "";
						string Width = "";
						string OwnerID = "";
						string RetentionCode = "";
						string RowGuid = "";
						string WhereClause = "";
						bool RC = false;
						
						string RssTitle = "";
						string pubdate = "";
						string rlink = "";
						string desc = "";
						List<dsWebSite> listOfWebSites = new List<dsWebSite>();
						
						
						if (UserID.Length > 0)
						{
							WhereClause = " where UserID = \'" + UserID + "\'";
						}
						
						List<string> ListOfUrls = new List<string>();
						ListOfUrls = GET_WebPageData(modGlobals.gGateWayID, WhereClause, RC);
						
						frmNotify2 WebInfo = new frmNotify2();
						WebInfo.Show();
						WebInfo.Text = "WEB Page Archive";
						//** We have all of the registered RSS feeds
						int K = 0;
						foreach (var xStr in ListOfUrls)
						{
							K++;
							string[] S = xStr.Split("|");
							//Dim strItems = WebSite + "|" + WebUrl + "|" + UserID + "|" + Depth + "|" + Width + "|" + RetentionCode + "|" + RowGuid
							WebSite = S[0];
							WebUrl = S[1];
							OwnerID = S[2];
							Depth = S[3];
							Width = S[4];
							RetentionCode = S[5];
							RowGuid = S[6];
							
							WebInfo.lblEmailMsg.Text = WebSite;
							WebInfo.lblMsg2.Text = WebUrl;
							WebInfo.lblFolder.Text = K.ToString() + " of " + ListOfUrls.Count.ToString();
							WebInfo.Refresh();
							Application.DoEvents();
							
							spiderWeb(WebUrl, int.Parse(Depth), int.Parse(Width), isPublic.ToString(), RetentionCode);
							
						}
						WEB = null;
						GC.Collect();
						GC.WaitForPendingFinalizers();
						WebInfo.Close();
						WebInfo.Dispose();
						GC.Collect();
						GC.WaitForPendingFinalizers();
						
					}
					
					public string ArchiveWebPage(string ParentSourceGuid, string WebpageTitle, string WebpageUrl, string WebPageFQN, string RetentionCode, string isPublic, DateTime LastAccessTime)
					{
						
						if (! File.Exists(WebPageFQN))
						{
							MessageBox.Show((string) ("WEB Page could not be found: " + "\r\n" + WebPageFQN));
							return "";
						}
						
						string FileText = ReadFileIntoString(WebPageFQN);
						string CrcHash = ENC.getSha1HashKey(FileText);
						
						var file_SourceName = WebPageFQN;
						string SourceGuid = Guid.NewGuid().ToString();
						
						string WEBProcessingDir = System.Configuration.ConfigurationManager.AppSettings["WEBProcessingDir"];
						
						if (! Directory.Exists(WEBProcessingDir))
						{
							Directory.CreateDirectory(WEBProcessingDir);
						}
						
						string ckMetaData = "N";
						int LastVerNbr = 0;
						FileInfo FI = new FileInfo(WebPageFQN);
						string OriginalFileType = FI.Extension;
						string file_SourceTypeCode = FI.Extension;
						string file_FullName = FI.Name;
						string file_LastAccessDate = FI.LastAccessTime.ToString();
						string file_CreateDate = FI.CreationTime.ToString();
						//Dim file_LastWriteTime As String = FI.LastWriteTime.ToString
						string file_LastWriteTime = LastAccessTime.ToString();
						string file_Length = FI.Length.ToString();
						FI = null;
						GC.Collect();
						GC.WaitForPendingFinalizers();
						
						if (int.Parse(file_Length) < 10)
						{
							Console.WriteLine("File " + file_FullName + " is only " + file_Length + " bytes long, skipping.");
							return "";
						}
						
						int iDatasourceCnt = getCountDataSourceFiles(file_FullName, CrcHash);
						//Dim iDatasourceCnt As Integer = getCountDataSourceFiles(file_SourceName, LastAccessTime)
						if (iDatasourceCnt > 0)
						{
							string sGuid = getSourceGuidBySourcenameCRC(file_FullName, CrcHash);
							if (sGuid.Length > 0)
							{
								saveContentOwner(sGuid, modGlobals.gCurrUserGuidID, "C", WEBProcessingDir, modGlobals.gMachineID, modGlobals.gNetworkID);
								return sGuid;
							}
							else
							{
								iDatasourceCnt = 0;
							}
						}
						
						if (iDatasourceCnt == 0)
						{
							
							DateTime StartInsert = DateTime.Now;
							LOG.WriteToTimerLog("Start ArchiveWebPage", (string) ("InsertWebPage:" + file_FullName), "START");
							
							bool BB = InsertSourcefile(modGlobals.gCurrUserGuidID, modGlobals.gMachineID, modGlobals.gNetworkID, SourceGuid, file_SourceName, file_FullName, file_SourceTypeCode, file_LastAccessDate, file_CreateDate, file_LastWriteTime, modGlobals.gCurrUserGuidID, LastVerNbr, RetentionCode, isPublic, CrcHash, WEBProcessingDir);
							
							if (BB)
							{
								if (ParentSourceGuid.Length > 0)
								{
									insertSourceChild(ParentSourceGuid, SourceGuid);
								}
								LOG.WriteToTimerLog("END ArchiveWebPage", (string) ("InsertSourcefile" + file_FullName), "STOP", StartInsert);
							}
							else
							{
								LOG.WriteToTimerLog("FAIL ArchiveWebPage", (string) ("InsertSourcefile" + file_FullName), "STOP", StartInsert);
							}
							
							if (BB)
							{
								
								string VersionNbr = "0";
								DateTime UpdateInsert = DateTime.Now;
								LOG.WriteToTimerLog("ArchiveWebPage", (string) ("UpdateInsert:" + file_FullName), "STOP");
								
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("clsArchiver:ArchiveContent 1000 inserted new file " + file_FullName));
								}
								if (OcrText.Trim().Length > 0)
								{
									string SS = "";
									AppendOcrText(SourceGuid, OcrText);
								}
								
								UpdateSourceCRC(SourceGuid, CrcHash);
								UpdateWebLinkFlgToTrue(SourceGuid);
								UpdateContentDescription(SourceGuid, WebpageTitle);
								UpdateWebPageUrlRef(SourceGuid, WebpageUrl);
								UpdateWebPageHash(SourceGuid, ENC.getSha1HashKey(WebpageUrl));
								
								UpdateDocFqn(SourceGuid, file_FullName);
								UpdateDocSize(SourceGuid, file_Length);
								if (int.Parse(file_Length) < 10)
								{
									Console.WriteLine("File " + file_FullName + " is only " + file_Length + " bytes long, skipping.");
									
								}
								UpdateDocDir(SourceGuid, file_FullName);
								UpdateDocOriginalFileType(SourceGuid, OriginalFileType);
								setRetentionDate(SourceGuid, RetentionCode, OriginalFileType);
								
								//delFileParms(SourceGuid )
								InsertSrcAttrib(SourceGuid, "FILENAME", file_SourceName, OriginalFileType);
								InsertSrcAttrib(SourceGuid, "CreateDate", file_CreateDate, OriginalFileType);
								InsertSrcAttrib(SourceGuid, "FILESIZE", file_Length, OriginalFileType);
								InsertSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessDate, OriginalFileType);
								InsertSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, OriginalFileType);
								
								if (! file_SourceTypeCode.Equals(OriginalFileType))
								{
									InsertSrcAttrib(SourceGuid, "IndexAs", file_LastWriteTime, file_SourceTypeCode);
								}
								
								LOG.WriteToTimerLog("ArchiveWebPage", (string) ("InsertWebPage" + file_FullName), "STOP", UpdateInsert);
							}
						}
						else
						{
							SourceGuid = "";
						}
						try
						{
							File.Delete(WebPageFQN);
						}
						catch (Exception)
						{
							Console.WriteLine("Failed to delete file " + WebPageFQN);
						}
						
						return SourceGuid;
					}
					
					public void ArchiveContent(string MachineID, bool InstantArchive, string UID, string FQN, string Author, string Description, string Keywords, bool isEmailAttachment, string EmailGuid = "")
					{
						
						if (xDebug)
						{
							LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 100");
						}
						
						string AttachmentCode = "";
						string CrcHash = ENC.getSha1HashFromFile(FQN);
						if (isEmailAttachment == true)
						{
							AttachmentCode = "A";
						}
						else
						{
							AttachmentCode = "C";
						}
						
						string isPublic = "N";
						
						string FolderName = DMA.GetFilePath(FQN);
						string cFolder = "";
						string pFolder = "XXX";
						List<string> DirFiles = new List<string>();
						string[] ActiveFolders = new string[1];
						
						if (InstantArchive == true)
						{
							DirFiles.Clear();
							ActiveFolders[0] = FolderName;
							DirFiles.Add(FQN);
							goto ProcessOneFileOnly;
						}
						
						FQN = UTIL.RemoveSingleQuotes(FQN);
						
						//Dim IncludedTypes As New ArrayList
						//Dim ExcludedTypes As New ArrayList
						
						string[] a = new string[1];
						
						bool DeleteFile = false;
						ActiveFolders[0] = FolderName;
						string FileName = DMA.getFileName(FQN);
						
						int iCnt = QDIR.cnt_PKII2QD(FolderName, UID);
						if (xDebug)
						{
							LOG.WriteToArchiveLog((string) ("clsArchiver:ArchiveContent 200 iCnt = " + iCnt.ToString()));
						}
						if (iCnt == 0)
						{
							QDIR.setCkdisabledir("N");
							QDIR.setCkmetadata("N");
							QDIR.setCkpublic("N");
							QDIR.setDb_id("ECM.Library");
							QDIR.setFqn(ref FolderName);
							QDIR.setIncludesubdirs("N");
							QDIR.setUserid(ref UID);
							QDIR.setVersionfiles("Y");
							QDIR.setQuickrefentry("1");
							QDIR.Insert();
							if (xDebug)
							{
								LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 300 inserted qDir");
							}
						}
						
						DateTime StepTimer = DateTime.Now;
						LOG.WriteToTimerLog("ArchiveContent01", "GetQuickArchiveFileFolders", "START");
						
						GetQuickArchiveFileFolders(UID, ref ActiveFolders, FolderName);
						
						LOG.WriteToTimerLog("ArchiveContent01", "GetQuickArchiveFileFolders", "STOP", StepTimer);
						
ProcessOneFileOnly:
						
						for (int i = 0; i <= (ActiveFolders.Length - 1); i++)
						{
							
							string FolderParmStr = ActiveFolders[i].ToString().Trim();
							string[] FolderParms = FolderParmStr.Split("|".ToCharArray());
							
							string FOLDER_FQN = FolderParms[0];
							string FOLDER_IncludeSubDirs = FolderParms[1];
							string FOLDER_DBID = FolderParms[2];
							string FOLDER_VersionFiles = FolderParms[3];
							string DisableDir = FolderParms[4];
							string RetentionCode = FolderParms[5];
							
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("clsArchiver:ArchiveContent 400: " + FOLDER_FQN));
							}
							
							FOLDER_FQN = UTIL.RemoveSingleQuotes(FOLDER_FQN);
							
							if (! Directory.Exists(FOLDER_FQN))
							{
								MessageBox.Show(FOLDER_FQN + " does not exist, returning.");
								return;
							}
							if (DisableDir.Equals("Y"))
							{
								goto NextFolder;
							}
							
							//GetIncludedFiletypes(FOLDER_FQN , IncludedTypes)
							//GetExcludedFiletypes(FOLDER_FQN , ExcludedTypes)
							
							GetAllIncludedFiletypes(FOLDER_FQN, IncludedTypes, FOLDER_IncludeSubDirs);
							GetAllExcludedFiletypes(FOLDER_FQN, ExcludedTypes, FOLDER_IncludeSubDirs);
							
							bool bChanged = false;
							
							List<string> LibraryList = new List<string>();
							
							if (FOLDER_FQN != pFolder)
							{
								
								string ParentDirForLib = "";
								bool bLikToLib = false;
								bLikToLib = isDirInLibrary(FOLDER_FQN, ref ParentDirForLib);
								
								FolderName = FOLDER_FQN;
								
								bool ThisDirIsDisabled = false;
								ThisDirIsDisabled = isParentDirDisabled(FOLDER_FQN);
								
								if (ThisDirIsDisabled == true)
								{
									LOG.WriteToArchiveLog("NOTICE: " + FOLDER_FQN + " disabled from archive.");
									goto NextFolder;
								}
								
								if (bLikToLib)
								{
									GetDirectoryLibraries(ParentDirForLib, LibraryList);
								}
								else
								{
									GetDirectoryLibraries(FOLDER_FQN, LibraryList);
								}
								
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("clsArchiver:ArchiveContent 500: " + FolderName));
								}
								
								Application.DoEvents();
								//** Verify that the DIR still exists
								if (Directory.Exists(FolderName))
								{
								}
								else
								{
									return;
								}
								
								bool FoundDir = getDirectoryParms(ref a, FolderName, modGlobals.gCurrUserGuidID);
								if (! FoundDir)
								{
									LOG.WriteToArchiveLog("clsArchiver : ArchiveContent : 00 : " + "ERROR: Folder\'" + FolderName + "\' was not registered, using default archive parameters.");
								}
								
								string IncludeSubDirs = a[0];
								string VersionFiles = a[1];
								string ckMetaData = a[2];
								string OcrDirectory = a[3];
								string RetenCode = a[4];
								if (RetenCode.Equals("?"))
								{
									RetenCode = getFirstRetentionCode();
								}
								//** Get all of the files in this folder
								
								try
								{
									if (InstantArchive == true)
									{
									}
									else
									{
										int ii = DMA.getFilesInDir(FOLDER_FQN, DirFiles, FileName);
										if (ii == 0)
										{
											if (xDebug)
											{
												LOG.WriteToArchiveLog((string) ("clsArchiver:ArchiveContent 600 NO FILES IN FOLDER: " + FolderName));
											}
											goto NextFolder;
										}
									}
									
								}
								catch (Exception)
								{
									goto NextFolder;
								}
								
								
								//** Process all of the files
								for (int K = 0; K <= DirFiles.Count - 1; K++)
								{
									StepTimer = DateTime.Now;
									LOG.WriteToTimerLog("ArchiveContent01", "ProcessFile", "STOP");
									//   [SourceGuid] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
									//	[CreateDate] [datetime] NULL CONSTRAINT [CURRDATE_04012008185318003]  DEFAULT (getdate()),
									//	[SourceName] [nvarchar](254) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
									//	[SourceImage] [image] NULL,
									//	[SourceTypeCode] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
									//	[FQN] [nvarchar](254) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
									//	[VersionNbr] [int] NULL CONSTRAINT [DF_DataSource_VersionNbr]  DEFAULT ((0)),
									//	[LastAccessDate] [datetime] NULL,
									//	[FileLength] [int] NULL,
									//	[LastWriteTime] [datetime] NULL,
									
									string SourceGuid = getGuid();
									string[] FileAttributes = DirFiles(K).Split("|");
									
									string file_FullName = FileAttributes[1];
									
									if (xDebug)
									{
										LOG.WriteToArchiveLog((string) ("clsArchiver:ArchiveContent 700 processing file: " + file_FullName));
									}
									
									string file_SourceName = FileAttributes[0];
									if (xDebug)
									{
										LOG.WriteToArchiveLog((string) ("    File: " + file_SourceName));
									}
									
									string file_Length = FileAttributes[2];
									if (modGlobals.gMaxSize > 0)
									{
										if (val[file_Length] > modGlobals.gMaxSize)
										{
											LOG.WriteToArchiveLog("Notice: file \'" + file_FullName + "\' exceed the allowed file upload size, skipped.");
											goto NextFile;
										}
									}
									
									string file_DirName = DMA.GetFilePath(file_FullName);
									string file_SourceTypeCode = FileAttributes[3];
									string file_LastAccessDate = FileAttributes[4];
									string file_CreateDate = FileAttributes[5];
									string file_LastWriteTime = FileAttributes[6];
									string OriginalFileType = file_SourceTypeCode;
									
									ckSourceTypeCode(ref file_SourceTypeCode);
									
									string StoredExternally = "N";
									
									int iDatasourceCnt = getCountDataSourceFiles(file_SourceName, CrcHash);
									if (iDatasourceCnt == 0)
									{
										saveContentOwner(SourceGuid, modGlobals.gCurrUserGuidID, "C", file_DirName, modGlobals.gMachineID, modGlobals.gNetworkID);
									}
									
									
									OcrText = "";
									string isGraphic = "N";
									
									if (iDatasourceCnt == 0)
									{
										//********************************************************************************
										//* The file DOES NOT exist in the reporsitory, add it now.
										//********************************************************************************
										Application.DoEvents();
										int LastVerNbr = 0;
										
										//********************************************************************************
										DateTime StartInsert = DateTime.Now;
										LOG.WriteToTimerLog("Start ArchiveContent01", (string) ("InsertSourcefile:" + file_FullName), "START");
										bool BB = InsertSourcefile(UID, MachineID, modGlobals.gNetworkID, SourceGuid, file_FullName, file_SourceName, file_SourceTypeCode, file_LastAccessDate, file_CreateDate, file_LastWriteTime, modGlobals.gCurrUserGuidID, LastVerNbr, RetentionCode, isPublic, CrcHash, file_DirName);
										
										string fExt = DMA.getFileExtension(file_FullName);
										if (FQN.ToUpper().Equals("ZIP"))
										{
											DBLocal.addZipFile(file_FullName, false.ToString(), bool.Parse(SourceGuid));
											int StackLevel = 0;
											Dictionary<string, int> ListOfFiles = new Dictionary<string, int>();
											ZF.UploadZipFile(modGlobals.gCurrUserGuidID, modGlobals.gMachineID, file_FullName, SourceGuid, true, false, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
											ListOfFiles = null;
											GC.Collect();
										}
										
										if (BB)
										{
											LOG.WriteToTimerLog("END ArchiveContent01", (string) ("InsertSourcefile" + file_FullName), "STOP", StartInsert);
										}
										else
										{
											LOG.WriteToTimerLog("FAIL ArchiveContent01", (string) ("InsertSourcefile" + file_FullName), "STOP", StartInsert);
										}
										
										//********************************************************************************
										
										if (BB)
										{
											
											string VersionNbr = "0";
											DateTime UpdateInsert = DateTime.Now;
											LOG.WriteToTimerLog("ArchiveContent01", (string) ("UpdateInsert:" + file_FullName), "STOP");
											
											if (xDebug)
											{
												LOG.WriteToArchiveLog((string) ("clsArchiver:ArchiveContent 1000 inserted new file " + file_FullName));
											}
											if (OcrText.Trim().Length > 0)
											{
												string SS = "";
												AppendOcrText(SourceGuid, OcrText);
											}
											
											UpdateDocFqn(SourceGuid, file_FullName);
											UpdateDocSize(SourceGuid, file_Length);
											UpdateDocDir(SourceGuid, file_FullName);
											UpdateDocOriginalFileType(SourceGuid, OriginalFileType);
											setRetentionDate(SourceGuid, RetentionCode, OriginalFileType);
											
											//delFileParms(SourceGuid )
											InsertSrcAttrib(SourceGuid, "FILENAME", file_SourceName, OriginalFileType);
											InsertSrcAttrib(SourceGuid, "CreateDate", file_CreateDate, OriginalFileType);
											InsertSrcAttrib(SourceGuid, "FILESIZE", file_Length, OriginalFileType);
											InsertSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessDate, OriginalFileType);
											InsertSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, OriginalFileType);
											
											if (! file_SourceTypeCode.Equals(OriginalFileType))
											{
												InsertSrcAttrib(SourceGuid, "IndexAs", file_LastWriteTime, file_SourceTypeCode);
											}
											if ((file_SourceTypeCode.Equals(".doc") || file_SourceTypeCode.Equals(".docx")) && ckMetaData.Equals("Y"))
											{
												if (modGlobals.gOfficeInstalled == true)
												{
													//EXTRACT WORD IMAGES HERE WDMXX
													GetWordDocMetadata(file_FullName, SourceGuid, OriginalFileType);
												}
												else
												{
													LOG.WriteToArchiveLog("WARNING 101xa: Metadata requested but office not installed.");
												}
											}
											if ((file_SourceTypeCode.Equals(".xls") || file_SourceTypeCode.Equals(".xlsx") || file_SourceTypeCode.Equals(".xlsm")) && ckMetaData.Equals("Y"))
											{
												if (modGlobals.gOfficeInstalled == true)
												{
													GetExcelMetaData(file_FullName, SourceGuid, OriginalFileType);
												}
												else
												{
													LOG.WriteToArchiveLog("WARNING 101xb: Metadata requested but office not installed.");
												}
											}
											LOG.WriteToTimerLog("ArchiveContent01", (string) ("UpdateInsert" + file_FullName), "STOP", UpdateInsert);
										}
										//Else
										//    '*****************************************
										//    '* The File Already exists in the Repository
										//    '* Just add the user to the ContentUser table
										//    '*****************************************
										//    Dim UpdateSource As Date = Now
										//    LOG.WriteToTimerLog("ArchiveContent01A", "UpdateSource" + file_FullName, "START")
										//    If UCase(FOLDER_VersionFiles ).Equals("Y") Then
										//        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 1001 files versioned" + file_FullName )
										//        '** Get the last version number of this file in the repository,
										//        Dim LastVerNbr As Integer = GetMaxDataSourceVersionNbr(UID, file_FullName )
										//        Dim NextVersionNbr As Integer = LastVerNbr + 1
										//        '** See if this version has been changed
										//        bChanged = isSourcefileOlderThanLastEntry(file_SourceName, CrcHash)
										//        '** If it has, add it to the repository
										//        If bChanged Then
										
										//            Dim fExt As String = DMA.getFileExtension(file_FullName)
										//            If FQN.ToUpper.Equals("ZIP") Then
										//                DBLocal.addZipFile(file_FullName, False, SourceGuid)
										//                Dim StackLevel As Integer = 0
										//                Dim ListOfFiles As New Dictionary(Of String, Integer)
										//                ZF.UploadZipFile(gCurrUserGuidID, gMachineID, file_FullName, SourceGuid, True, False, RetentionCode, isPublic, StackLevel, ListOfFiles)
										//                ListOfFiles = Nothing
										//                GC.Collect()
										//            End If
										
										//            '********************************************************************************************************
										//            Dim StartInsert As Date = Now
										//            LOG.WriteToTimerLog("Start ArchiveContent01", "UpdtInsertSourcefile:" + file_FullName, "START")
										//            Dim BB As Boolean = InsertSourcefile(UID, MachineID, gNetworkID, SourceGuid, _
										//                                     file_FullName, _
										//                                     file_SourceName, _
										//                                     file_SourceTypeCode, _
										//                                     file_LastAccessDate , _
										//                                     file_CreateDate , _
										//                                     file_LastWriteTime , gCurrUserGuidID, NextVersionNbr, RetentionCode, isPublic, CrcHash, file_DirName )
										
										//            If BB Then
										//                LOG.WriteToTimerLog("END ArchiveContent01B", "UpdtInsertSourcefile" + file_FullName, "STOP", StartInsert)
										//            Else
										//                LOG.WriteToTimerLog("FAIL ArchiveContent01B", "UpdtInsertSourcefile" + file_FullName, "STOP", StartInsert)
										//            End If
										//            '********************************************************************************************************
										
										//            If BB Then
										//                If LibraryList.Count > 0 Then
										//                    For II As Integer = 0 To LibraryList.Count - 1
										//                        Dim LibraryName  = LibraryList(II)
										//                        AddLibraryItem(SourceGuid, file_SourceName, file_SourceTypeCode, LibraryName )
										//                    Next
										//                End If
										//                If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 1002 file ADDED" + file_FullName )
										//            Else
										//                If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 1003 file FAILED TO ADD" + file_FullName )
										//            End If
										
										//            'Dim VersionNbr As String = "0"
										//            Dim CRC As String = DMA.CalcCRC(file_FullName)
										//            addContentHashKey(SourceGuid, NextVersionNbr, file_CreateDate , file_FullName, OriginalFileType, file_Length , CRC, MachineID)
										
										//            UpdateDocFqn(SourceGuid, file_FullName)
										//            UpdateDocSize(SourceGuid, file_Length )
										//            UpdateDocDir(SourceGuid, file_FullName)
										//            UpdateDocOriginalFileType(SourceGuid, OriginalFileType )
										//            setRetentionDate(SourceGuid , RetentionCode , OriginalFileType )
										
										//            Dim SS  = ""
										//            SS  = "update dataSource set KeyWords = '" + Keywords + "' where SourceGuid = '" + SourceGuid + "' "
										//            BB = ExecuteSqlNewConn(SS, False)
										//            SS = "update dataSource set Description = '" + Description + "' where SourceGuid = '" + SourceGuid + "' "
										//            BB = ExecuteSqlNewConn(SS, False)
										
										//            If OcrText .Trim.Length > 0 Then
										//                AppendOcrText(SourceGuid , OcrText )
										//            End If
										
										//            Dim UserGuid  = gCurrUserGuidID
										//            SS = "update QuickRefItems set SourceGuid = '" + SourceGuid + "' where DataSourceOwnerUserID = '" + UserGuid  + "' and FQN = '" + FQN + "' "
										//            BB = ExecuteSqlNewConn(SS, False)
										
										//            'delFileParms(SourceGuid )
										//            InsertSrcAttrib(SourceGuid , "FILENAME", file_SourceName, OriginalFileType )
										//            InsertSrcAttrib(SourceGuid , "CreateDate", file_CreateDate , OriginalFileType )
										//            InsertSrcAttrib(SourceGuid , "FILESIZE", file_Length , OriginalFileType )
										//            InsertSrcAttrib(SourceGuid , "ChangeDate", file_LastAccessDate, OriginalFileType )
										//            InsertSrcAttrib(SourceGuid , "WriteDate", file_LastWriteTime , OriginalFileType )
										//            InsertSrcAttrib(SourceGuid , "MD Author", Author, OriginalFileType )
										//            If Not file_SourceTypeCode .Equals(OriginalFileType ) Then
										//                InsertSrcAttrib(SourceGuid , "IndexAs", file_LastWriteTime , file_SourceTypeCode)
										//            End If
										//            If (LCase(file_SourceTypeCode).Equals(".doc") Or LCase(file_SourceTypeCode).Equals(".docx")) And ckMetaData .Equals("Y") Then
										//                GetWordDocMetadata(file_FullName, SourceGuid , OriginalFileType )
										//            End If
										//            If (file_SourceTypeCode.Equals(".xls") _
										//                        Or file_SourceTypeCode.Equals(".xlsx") Or file_SourceTypeCode.Equals(".xlsm")) And ckMetaData .Equals("Y") Then
										//                Me.GetExcelMetaData(file_FullName, SourceGuid , OriginalFileType )
										//            End If
										
										//        End If
										//        LOG.WriteToTimerLog("ArchiveContent01", "UpdateSource:1" + file_FullName, "end", UpdateSource)
										//    Else
										//        If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 1004 The document has changed, but versioning is not on" + file_FullName )
										//        '** The document has changed, but versioning is not on...
										//        '** Delete and re-add.
										//        '** If zero add
										//        '** if 1, see if changed and if so, update, if not skip it
										//        Dim LastVerNbr As Integer = GetMaxDataSourceVersionNbr(UID, _
										//                                     file_FullName )
										//        bChanged = isSourcefileOlderThanLastEntry(file_SourceName, CrcHash)
										//        '** If it has, add it to the repository
										//        If bChanged Then
										//            If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 1005 The document has changed: " + file_FullName )
										//            Dim BB As Boolean = False
										//            'Dim BB As Boolean = DeleteDocumentByName(UID, file_SourceName, SourceGuid)
										//            Dim UpdateSourceImageDte As Date = Now
										
										//            LOG.WriteToTimerLog("ArchiveContent01", "UpdateSourceImage:1" + file_FullName, "start")
										
										//            Dim CurrentVersionNbr As Integer = 0
										
										//            '********************************************************************************************************
										//            Dim StartInsert As Date = Now
										//            LOG.WriteToTimerLog("Start ArchiveContent01", "UpdtInsertSourcefile:" + file_FullName, "START")
										//            BB = UpdateSourceImage(FileName, UID, MachineID, SourceGuid, file_LastAccessDate, file_CreateDate, file_LastWriteTime, CurrentVersionNbr, FQN, RetenCode, isPublic, CrcHash)
										//            If BB Then
										//                LOG.WriteToTimerLog("END ArchiveContent01C", "UpdtInsertSourcefile" + file_FullName, "STOP", StartInsert)
										//            Else
										//                LOG.WriteToTimerLog("FAIL ArchiveContent01C", "UpdtInsertSourcefile" + file_FullName, "STOP", StartInsert)
										//            End If
										//            '********************************************************************************************************
										
										//            If Not BB Then
										//                Dim MySql  = "Delete from DataSource where SourceGuid = '" + SourceGuid + "'"
										//                ExecuteSqlNewConn(MySql)
										//                LOG.WriteToArchiveLog("Unrecoverable Error - removed file '" + file_FullName + "' from the repository.")
										//            End If
										
										//            If LibraryList.Count > 0 Then
										//                For II As Integer = 0 To LibraryList.Count - 1
										//                    Dim LibraryName  = LibraryList(II)
										//                    AddLibraryItem(SourceGuid, file_SourceName, file_SourceTypeCode, LibraryName )
										//                Next
										//            End If
										
										//            Dim DateX01 As Date = Now
										//            LOG.WriteToTimerLog("ArchiveContent01", "UpdateDocFqn" + file_FullName, "start")
										
										//            UpdateDocFqn(SourceGuid, file_FullName)
										//            UpdateDocSize(SourceGuid, file_Length )
										//            UpdateDocOriginalFileType(SourceGuid, OriginalFileType )
										//            UpdateDocDir(SourceGuid, file_FullName)
										//            setRetentionDate(SourceGuid , RetentionCode , OriginalFileType )
										
										//            LOG.WriteToTimerLog("ArchiveContent01", "UpdateDocFqn-1" + file_FullName, "end", DateX01)
										
										//            Dim SS  = ""
										//            SS  = "update dataSource set KeyWords = '" + Keywords + "' where SourceGuid = '" + SourceGuid + "' "
										//            BB = ExecuteSqlNewConn(SS, False)
										//            SS = "update dataSource set Description = '" + Description + "' where SourceGuid = '" + SourceGuid + "' "
										//            BB = ExecuteSqlNewConn(SS, False)
										//            If OcrText .Trim.Length > 0 Then
										//                AppendOcrText(SourceGuid , OcrText )
										//            End If
										//            Dim UserGuid  = gCurrUserGuidID
										//            SS = "update QuickRefItems set SourceGuid = '" + SourceGuid + "' where DataSourceOwnerUserID = '" + UserGuid  + "' and FQN = '" + FQN + "' "
										//            BB = ExecuteSqlNewConn(SS, False)
										
										//            'delFileParms(SourceGuid )
										//            InsertSrcAttrib(SourceGuid , "FILENAME", file_SourceName, OriginalFileType )
										//            InsertSrcAttrib(SourceGuid , "CreateDate", file_CreateDate , OriginalFileType )
										//            InsertSrcAttrib(SourceGuid , "FILESIZE", file_Length , OriginalFileType )
										//            InsertSrcAttrib(SourceGuid , "ChangeDate", file_LastAccessDate, OriginalFileType )
										//            InsertSrcAttrib(SourceGuid , "WriteDate", file_LastWriteTime , OriginalFileType )
										//            InsertSrcAttrib(SourceGuid , "MD Author", Author, OriginalFileType )
										//            If Not file_SourceTypeCode .Equals(OriginalFileType ) Then
										//                InsertSrcAttrib(SourceGuid , "IndexAs", file_LastWriteTime , file_SourceTypeCode)
										//            End If
										//            If (LCase(file_SourceTypeCode).Equals(".doc") Or LCase(file_SourceTypeCode).Equals(".docx")) And ckMetaData .Equals("Y") Then
										//                GetWordDocMetadata(file_FullName, SourceGuid , OriginalFileType )
										//            End If
										//            If (file_SourceTypeCode.Equals(".xls") _
										//                        Or file_SourceTypeCode.Equals(".xlsx") Or file_SourceTypeCode.Equals(".xlsm")) And ckMetaData .Equals("Y") Then
										//                Me.GetExcelMetaData(file_FullName, SourceGuid , OriginalFileType )
										//            End If
										//            If xDebug Then LOG.WriteToArchiveLog("10000 Processed " + file_FullName)
										//            LOG.WriteToTimerLog("ArchiveContent01", "UpdateDocFqn-2" + file_FullName, "end", DateX01)
										//        Else
										//            If xDebug Then LOG.WriteToArchiveLog("Document " + file_FullName + " has not changed, SKIPPING.")
										//            If xDebug Then LOG.WriteToArchiveLog("Document " + file_FullName + " has not changed, SKIPPING.")
										//        End If
										//    End If
										//    LOG.WriteToTimerLog("ArchiveContent01", "UpdateSource" + file_FullName, "STOP", UpdateSource)
									}
NextFile:
									//Me.SB.Text = "Processing document #" + K.ToString
									Application.DoEvents();
									LOG.WriteToTimerLog("ArchiveContent01", "ProcessFile", "STOP", StepTimer);
								}
							}
							else
							{
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("Duplicate Folder: " + FolderName));
								}
							}
NextFolder:
							pFolder = FolderName;
						}
						
					}
					public void InsertSrcAttrib(string SGUID, string aName, string aVal, string SourceType)
					{
						SRCATTR.setSourceguid(ref SGUID);
						SRCATTR.setAttributename(ref aName);
						SRCATTR.setAttributevalue(ref aVal);
						SRCATTR.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
						SRCATTR.setSourcetypecode(ref SourceType);
						SRCATTR.Insert();
					}
					public void GetWordDocMetadata(string FQN, string SourceGUID, string OriginalFileType)
					{
						
						string TempDir = System.IO.Path.GetTempPath();
						string fName = DMA.getFileName(FQN);
						string NewFqn = TempDir + fName;
						
						File.Copy(FQN, NewFqn, true);
						
						clsMsWord WDOC = new clsMsWord();
						WDOC.initWordDocMetaData(NewFqn, SourceGUID, OriginalFileType);
						
						//** THIS MAY NEED TO BE REMOVED
						File.Delete(NewFqn);
						
					}
					public void GetExcelMetaData(string FQN, string SourceGUID, string OriginalFileType)
					{
						
						string TempDir = System.IO.Path.GetTempPath();
						string fName = DMA.getFileName(FQN);
						string NewFqn = TempDir + fName;
						
						File.Copy(FQN, NewFqn, true);
						
						clsMsWord WDOC = new clsMsWord();
						WDOC.initExcelMetaData(NewFqn, SourceGUID, OriginalFileType);
						
						ISO.saveIsoFile(" FilesToDelete.dat", NewFqn + "|");
						//File.Delete(NewFqn )
						
					}
					
					public void setDataSourceRestoreHistoryParms()
					{
						
						string s = "";
						bool B = false;
						
						
						s = s + " update DataSourceRestoreHistory  ";
						s = s + " set  DocumentName = (select SourceName from DataSource ";
						s = s + " where DataSource.SourceGuid = DataSourceRestoreHistory.SourceGuid) ";
						s = s + " where VerifiedData = \'N\' ";
						s = s + " and TypeContentCode <> \'.msg\' ";
						s = s + " and DataSourceRestoreHistory.DataSourceOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\'";
						B = ExecuteSqlNewConn(s, false);
						
						s = " update DataSourceRestoreHistory  ";
						s = s + " set  FQN = (select FQN from DataSource ";
						s = s + " where DataSource.SourceGuid = DataSourceRestoreHistory.SourceGuid) ";
						s = s + " where VerifiedData = \'N\' ";
						s = s + " and TypeContentCode <> \'.msg\' ";
						s = s + " and DataSourceRestoreHistory.DataSourceOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\'";
						B = ExecuteSqlNewConn(s, false);
						
						s = " update DataSourceRestoreHistory ";
						s = s + " set  DocumentName = (select ShortSubj from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)";
						s = s + " where VerifiedData = \'N\' and TypeContentCode = \'.msg\' and DataSourceRestoreHistory.DataSourceOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\'";
						B = ExecuteSqlNewConn(s, false);
						
						s = "update DataSourceRestoreHistory ";
						s = s + " set  FQN = (select \'EMAIL\' from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)";
						s = s + " where VerifiedData = \'N\' and TypeContentCode = \'.msg\'  and DataSourceRestoreHistory.DataSourceOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\'";
						B = ExecuteSqlNewConn(s, false);
						
						s = "update DataSourceRestoreHistory ";
						s = s + " set  FQN = (select \'EMAIL\' from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)";
						s = s + " where VerifiedData = \'N\' and TypeContentCode = \'.eml\'  and DataSourceRestoreHistory.DataSourceOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\'";
						B = ExecuteSqlNewConn(s, false);
						
						s = " update DataSourceRestoreHistory ";
						s = s + " set  VerifiedData = (select \'Y\' from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)";
						s = s + " where VerifiedData = \'N\'  and TypeContentCode = \'.msg\' and DataSourceRestoreHistory.DataSourceOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\'";
						B = ExecuteSqlNewConn(s, false);
						
						s = " update DataSourceRestoreHistory ";
						s = s + " set  VerifiedData = (select \'Y\' from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)";
						s = s + " where VerifiedData = \'N\'  and TypeContentCode = \'.eml\' and DataSourceRestoreHistory.DataSourceOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\'";
						B = ExecuteSqlNewConn(s, false);
						
						s = " Update DataSourceRestoreHistory ";
						s = s + " set  VerifiedData = (select \'Y\' from DataSource where DataSource.SourceGuid = DataSourceRestoreHistory.SourceGuid)";
						s = s + " where VerifiedData = \'N\'  and TypeContentCode <> \'.msg\' and DataSourceRestoreHistory.DataSourceOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\'";
						B = ExecuteSqlNewConn(s, false);
						
					}
					public void ArchiveQuickRefItems(string UID, string MachineID, bool SkipIfArchiveBitIsOn, bool rbPublic, bool rbPrivate, bool rbMstrYes, bool rbMstrNot, TextBox SB, string MetadataTag, string MetadataValue, string LibraryName, ArrayList ZipFilesQuick)
					{
						
						try
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 100");
							}
							
							string UserGuid = modGlobals.gCurrUserGuidID;
							
							string S = "";
							S = S + " SELECT ";
							S = S + " [FQN]";
							S = S + " ,[DataSourceOwnerUserID]";
							S = S + " ,[Author]";
							S = S + " ,[Description]";
							S = S + " ,[Keywords]";
							S = S + " ,[FileName]";
							S = S + " ,[DirName], [QuickRefItemGuid], MetadataTag, MetadataValue, Library ";
							S = S + " FROM [QuickRefItems] ";
							S = S + " where [DataSourceOwnerUserID] = \'" + UserGuid + "\' ";
							
							string FQN = "";
							string DataSourceOwnerUserID = "";
							string Author = "";
							string Description = "";
							string Keywords = "";
							string FileName = "";
							string DirName = "";
							string sourceguid = "";
							string tMetadataTag = "";
							string tMetadataValue = "";
							string tLibraryName = "";
							string QuickRefItemGuid = "";
							
							if (xDebug)
							{
								LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 200");
							}
							
							SqlDataReader rsQuickArch = null;
							rsQuickArch = SqlQryNewConn(S);
							
							if (xDebug)
							{
								LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 300");
							}
							if (rsQuickArch == null)
							{
								return;
							}
							if (rsQuickArch.HasRows)
							{
								while (rsQuickArch.Read())
								{
									try
									{
										FQN = rsQuickArch.GetValue(0).ToString();
										if (xDebug)
										{
											LOG.WriteToArchiveLog((string) ("clsArchiver:ArchiveQuickRefItems 400" + FQN));
										}
										DataSourceOwnerUserID = rsQuickArch.GetValue(1).ToString();
										Author = rsQuickArch.GetValue(2).ToString();
										Description = rsQuickArch.GetValue(3).ToString();
										Keywords = rsQuickArch.GetValue(4).ToString();
										FileName = rsQuickArch.GetValue(5).ToString();
										DirName = rsQuickArch.GetValue(6).ToString();
										QuickRefItemGuid = rsQuickArch.GetValue(7).ToString();
										tMetadataTag = rsQuickArch.GetValue(8).ToString();
										tMetadataValue = rsQuickArch.GetValue(9).ToString();
										tLibraryName = rsQuickArch.GetValue(10).ToString();
										
										if (MetadataTag.Trim().Length > 0)
										{
											tMetadataTag = MetadataTag;
										}
										if (MetadataValue.Trim().Length > 0)
										{
											tMetadataValue = MetadataValue;
										}
										if (LibraryName.Trim().Length > 0)
										{
											tLibraryName = LibraryName;
										}
										
										LibraryName = tLibraryName;
										MetadataValue = tMetadataValue;
										MetadataTag = tMetadataTag;
										
										//FrmMDIMain.SB.Text = DirName
										
										FQN = UTIL.RemoveSingleQuotes(FQN);
										
										if (File.Exists(FQN))
										{
											
											if (xDebug)
											{
												LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 500 File exists");
											}
											
											bool bArch = DMA.isArchiveBitOn(FQN);
											//If SkipIfArchiveBitIsOn = False Then
											//    If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 600 archive bit on, processing anyway")
											//    bArch = True
											//End If
											if (bArch == false)
											{
												
												ArchiveContent(MachineID, false, DataSourceOwnerUserID, FQN, Author, Description, Keywords, false);
												
												sourceguid = getSourceGuidByFqn(FQN, UserGuid);
												S = "Update [QuickRefItems] set [SourceGuid] = \'" + sourceguid + "\' where QuickRefItemGuid = \'" + QuickRefItemGuid + "\' ";
												TgtGuid = sourceguid;
												modGlobals.gTgtGuid = sourceguid;
												bool BB = ExecuteSqlNewConn(S, true);
												modGlobals.gTgtGuid = "";
												
												
												if (! BB)
												{
													LOG.WriteToArchiveLog("Notice update skipped on Quick Reference : \'" + S + "\'.");
												}
												else
												{
													
													UpdateDataSourceDesc(QuickRefItemGuid, sourceguid);
													UpdateDataSourceKeyWords(QuickRefItemGuid, sourceguid);
													//MetadataTag , MetadataValue , Library
													if (MetadataTag.Trim().Length > 0)
													{
														UpdateDataSourceMetadata(tMetadataTag, tMetadataValue, sourceguid);
													}
													if (LibraryName.Trim().Length > 0)
													{
														UpdateDataSourceLibrary(tLibraryName, sourceguid);
													}
													SetSourceGlobalAccessFlags(sourceguid, "SRC", rbPublic, rbPrivate, rbMstrYes, rbMstrNot, SB);
												}
												//DMA.ToggleArchiveBit(FQN )
												DMA.setArchiveBitOff(FQN);
												if (xDebug)
												{
													LOG.WriteToArchiveLog((string) ("clsArchiver:ArchiveQuickRefItems 800 processed: " + FQN));
												}
												//log.WriteToArchiveLog("Notice 5543.21.2b : clsArchiver:ArchiveQuickRefItems 800 processed: " + FQN )
											}
										}
										else
										{
											//xTrace(102375, "File " + FQN + " does not exist on this machine.", "clsArchiver:ArchiveQuickRefItems")
											//** DO NOTHING - The file has been removed from the machine.
										}
										
									}
									catch (Exception ex)
									{
										Console.WriteLine("Error: " + ex.Message);
									}
									Application.DoEvents();
									if (xDebug)
									{
										LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 900 Next file.");
									}
									if (xDebug)
									{
										LOG.WriteToArchiveLog("--------------------------------------------------------------");
									}
								}
							}
							//FrmMDIMain.SB.Text = "Done..."
						}
						catch (Exception ex)
						{
							LOG.WriteToArchiveLog((string) ("ERROR 5543.21.2a : ArchiveQuickRefItems - " + ex.Message));
							//FrmMDIMain.SB.Text = "Failed to capture Quick Archive Items, please check the log file."
						}
						
					}
					public void UpdateDataSourceDesc(string QuickRefItemGuid, string SourceGuid)
					{
						string S = "update DataSource set description = ";
						S = S + " (select Description from [QuickRefItems] where [QuickRefItemGuid] = \'" + QuickRefItemGuid + "\')";
						S = S + " where SourceGuid = \'" + SourceGuid + "\'";
						
						TgtGuid = SourceGuid;
						bool B = ExecuteSqlNewConn(S, true);
						
					}
					public void UpdateDataSourceKeyWords(string QuickRefItemGuid, string SourceGuid)
					{
						string S = "update DataSource set KeyWords = ";
						S = S + " (select KeyWords from [QuickRefItems] where [QuickRefItemGuid] = \'" + QuickRefItemGuid + "\')";
						S = S + " where SourceGuid = \'" + SourceGuid + "\'";
						TgtGuid = SourceGuid;
						bool B = ExecuteSqlNewConn(S, true);
						
					}
					
					public void UpdateDataSourceMetadata(string Attribute, string Attributevalue, string SourceGuid)
					{
						clsSOURCEATTRIBUTE SRCATTR = new clsSOURCEATTRIBUTE();
						
						string WC = "";
						int iCnt = 0;
						bool B = false;
						
						string Itemtitle = getFqnFromGuid(SourceGuid);
						string Itemtype = UTIL.getFileSuffix(Itemtitle);
						string Datasourceowneruserid = getOwnerGuid(SourceGuid);
						Itemtype = (string) ("." + Itemtype);
						
						iCnt = SRCATTR.cnt_PK35(Attribute, modGlobals.gCurrUserGuidID, SourceGuid);
						if (iCnt == 0)
						{
							SRCATTR.setAttributename(ref Attribute);
							SRCATTR.setAttributevalue(ref Attributevalue);
							SRCATTR.setSourceguid(ref SourceGuid);
							SRCATTR.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
							SRCATTR.setSourcetypecode(ref Itemtype);
							B = SRCATTR.Insert();
							if (! B)
							{
								LOG.WriteToArchiveLog("clsArchiver:UpdateDataSourceMetadata - Failed to add metadata \'" + Attribute + ":" + Attributevalue + " to \'" + SourceGuid + "\'.");
							}
						}
						else
						{
							SRCATTR.setAttributename(ref Attribute);
							SRCATTR.setAttributevalue(ref Attributevalue);
							SRCATTR.setSourceguid(ref SourceGuid);
							SRCATTR.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
							SRCATTR.setSourcetypecode(ref Itemtype);
							WC = SRCATTR.wc_PK35(Attribute, modGlobals.gCurrUserGuidID, SourceGuid);
							B = SRCATTR.Update(WC);
							if (! B)
							{
								LOG.WriteToArchiveLog("clsArchiver:UpdateDataSourceMetadata - Failed to UPDATE metadata \'" + Attribute + ":" + Attributevalue + " to \'" + SourceGuid + "\'.");
							}
						}
						
						SRCATTR = null;
						
					}
					public void UpdateDataSourceLibrary(string LibraryName, string SourceGuid)
					{
						clsLIBRARYITEMS LI = new clsLIBRARYITEMS();
						
						string Libraryowneruserid = GetLibOwnerByName(LibraryName);
						string Itemtitle = getFqnFromGuid(SourceGuid);
						string Itemtype = UTIL.getFileSuffix(Itemtitle);
						string Datasourceowneruserid = getOwnerGuid(SourceGuid);
						string NewGuid = System.Guid.NewGuid().ToString();
						Itemtype = (string) ("." + Itemtype);
						
						if (Libraryowneruserid.Trim().Length == 0)
						{
							LOG.WriteToArchiveLog("ERROR - clsArchiver:UpdateDataSourceLibrary: Could not find owner of library " + LibraryName + " - userd current user ID.");
							Libraryowneruserid = modGlobals.gCurrUserGuidID;
						}
						
						string WC = "";
						int iCnt = 0;
						bool B = false;
						
						iCnt = LI.cnt_UI_LibItems(LibraryName, SourceGuid);
						if (iCnt == 0)
						{
							LI.setAddedbyuserguidid(ref modGlobals.gCurrUserGuidID);
							LI.setDatasourceowneruserid(ref Datasourceowneruserid);
							LI.setItemtitle(ref Itemtitle);
							LI.setItemtype(ref Itemtype);
							LI.setLibraryitemguid(ref NewGuid);
							LI.setLibraryname(ref LibraryName);
							LI.setLibraryowneruserid(ref Libraryowneruserid);
							LI.setSourceguid(ref SourceGuid);
							B = LI.Insert();
							if (! B)
							{
								LOG.WriteToArchiveLog("clsArchiver:UpdateDataSourceMetadata - Failed to add Library Items \'" + LibraryName + ".");
							}
						}
						else
						{
							LI.setAddedbyuserguidid(ref modGlobals.gCurrUserGuidID);
							LI.setDatasourceowneruserid(ref Datasourceowneruserid);
							LI.setItemtitle(ref Itemtitle);
							LI.setItemtype(ref Itemtype);
							LI.setLibraryitemguid(ref NewGuid);
							LI.setLibraryname(ref LibraryName);
							LI.setLibraryowneruserid(ref Libraryowneruserid);
							LI.setSourceguid(ref SourceGuid);
							
							WC = LI.wc_UI_LibItems(LibraryName, SourceGuid);
							
							B = LI.Update(WC);
							if (! B)
							{
								LOG.WriteToArchiveLog("clsArchiver:UpdateDataSourceMetadata - Failed to UPDATE Library Items \'" + LibraryName + "\'.");
							}
						}
						
						LI = null;
						
					}
					public void ckSourceTypeCode(ref string file_SourceTypeCode)
					{
						
						int bcnt = iGetRowCount("SourceType", "where SourceTypeCode = \'" + file_SourceTypeCode + "\'");
						
						string SubstituteFileType = getProcessFileAsExt(file_SourceTypeCode);
						
						if (bcnt == 0 && SubstituteFileType == "")
						{
							
							if (SubstituteFileType == null)
							{
								string MSG = "The file type \'" + file_SourceTypeCode + "\' is undefined." + "\r\n" + "DO YOU WISH TO AUTOMATICALLY DEFINE IT?" + "\r\n" + "This will allow content to be archived, but not searched.";
								//Dim dlgRes As DialogResult = MessageBox.Show(MSG, "Filetype Undefined", MessageBoxButtons.YesNo)
								
								UNASGND.setApplied("0");
								UNASGND.setFiletype(ref file_SourceTypeCode);
								int iCnt = UNASGND.cnt_PK_AFTU(file_SourceTypeCode);
								if (iCnt == 0)
								{
									UNASGND.Insert();
								}
								
								clsSOURCETYPE ST = new clsSOURCETYPE();
								ST.setSourcetypecode(ref file_SourceTypeCode);
								ST.setSourcetypedesc("NO SEARCH - AUTO ADDED by Pgm");
								ST.setIndexable("0");
								ST.setStoreexternal(0);
								
								bool B = ST.Insert();
								if (! B)
								{
									LOG.WriteToArchiveLog("clsArchiver : ckSourceTypeCode : 01");
									LOG.WriteToArchiveLog("clsArchiver : ckSourceTypeCode : 02 : " + "ERROR: An unknown file \'" + file_SourceTypeCode + "\' type was NOT inserted.");
								}
							}
							else
							{
								file_SourceTypeCode = SubstituteFileType;
							}
						}
						else
						{
							if (SubstituteFileType.Trim().Length > 0)
							{
								file_SourceTypeCode = SubstituteFileType;
							}
						}
						
					}
					
					//** WDM 7/6/2009
					//** This function is not used at this time.
					public void ArchiveAllFolderContent(string UID, string MachineID, string FolderName, bool ckSkipIfArchBitTrue, string VersionFiles, string EmailGuid, string RetentionCode, string isPublic)
					{
						
						
						int LastVerNbr = 0;
						int NextVersionNbr = 0;
						string CRC = "";
						
						//Dim IncludedTypes As New ArrayList
						//Dim ExcludedTypes As New ArrayList
						string OcrDirectory = "Y";
						string IncludeSubDirs = "N";
						string ckMetaData = "Y";
						
						bool bAddThisFileAsNewVersion = false;
						
						if (EmailGuid.Trim().Length > 0)
						{
							VersionFiles = "Y";
						}
						
						//** Designed to archive ALL files of ALL type contained within the passed in folder.
						if (xDebug)
						{
							LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8000 : trace log.");
						}
						
						DateTime rightNow = DateTime.Now;
						int RetentionYears = int.Parse(val[getSystemParm("RETENTION YEARS")]);
						rightNow = rightNow.AddYears(RetentionYears);
						string RetentionExpirationDate = rightNow.ToString();
						
						DateTime ExpiryTime = rightNow;
						
						ZipFiles.Clear();
						string[] a = new string[1];
						
						string[] ActiveFolders = new string[1];
						bool DeleteFile = false;
						
						//GetContentArchiveFileFolders(gCurrUserGuidID, ActiveFolders)
						
						ActiveFolders[0] = FolderName;
						
						string cFolder = "";
						string pFolder = "XXX";
						List<string> DirFiles = new List<string>();
						
						if (xDebug)
						{
							LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8001 : trace log.");
						}
						
						FilesBackedUp = 0;
						FilesSkipped = 0;
						
						List<string> LibraryList = new List<string>();
						
						for (int i = 0; i <= (ActiveFolders.Length - 1); i++)
						{
							
							string FolderParmStr = ActiveFolders[i].ToString().Trim();
							//Dim FolderParms() As String = FolderParmStr.Split("|")
							
							string FOLDER_FQN = FolderName;
							
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("clsArchiver: ArchiveFolderContent :8002 :FOLDER_FQN : " + FOLDER_FQN));
							}
							
							if (FOLDER_FQN.IndexOf(modGlobals.gTempDir + "") + 1 > 0)
							{
								LOG.WriteToArchiveLog("XXX3234v here");
								Application.DoEvents();
							}
							
							string FOLDER_IncludeSubDirs = "X";
							string FOLDER_DBID = "X";
							string FOLDER_VersionFiles = VersionFiles;
							string DisableDir = "N";
							
							FOLDER_FQN = UTIL.RemoveSingleQuotes(FOLDER_FQN);
							
							if (Directory.Exists(FOLDER_FQN))
							{
								//FrmMDIMain.SB.Text = "Processing Dir: " + FOLDER_FQN
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("clsArchiver: ArchiveFolderContent :8003 :FOLDER Exists: " + FOLDER_FQN));
								}
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("Archive Folder: " + FOLDER_FQN));
								}
							}
							else
							{
								//FrmMDIMain.SB.Text = FOLDER_FQN  + " does not exist, skipping."
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("clsArchiver: ArchiveFolderContent :8004 :FOLDER DOES NOT Exist: " + FOLDER_FQN));
								}
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("Archive Folder FOUND MISSING: " + FOLDER_FQN));
								}
								goto NextFolder;
							}
							if (DisableDir.Equals("Y"))
							{
								goto NextFolder;
							}
							
							//GetIncludedFiletypes(FOLDER_FQN , IncludedTypes)
							//GetExcludedFiletypes(FOLDER_FQN , ExcludedTypes)
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("clsArchiver: ArchiveFolderContent :8005 : Trace: " + FOLDER_FQN));
							}
							bool bChanged = false;
							
							if (FOLDER_FQN != pFolder)
							{
								
								string ParentDirForLib = "";
								bool bLikToLib = false;
								bLikToLib = isDirInLibrary(FOLDER_FQN, ref ParentDirForLib);
								
								Directory xDir;
								int iCount = xDir.GetFiles(FOLDER_FQN).Count;
								if (iCount == 0)
								{
									goto NextFolder;
								}
								
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("clsArchiver: ArchiveFolderContent :8006 : Folder Changed: " + FOLDER_FQN + ", " + pFolder));
								}
								FolderName = FOLDER_FQN;
								Application.DoEvents();
								//** Verify that the DIR still exists
								if (Directory.Exists(FolderName))
								{
									//FrmMDIMain.SB.Text = "Processing Dir: " + FolderName
								}
								else
								{
									//FrmMDIMain.SB.Text = FolderName + " does not exist, skipping."
									LOG.WriteToArchiveLog((string) ("clsArchiver: ArchiveFolderContent :8007 : Folder DOES NOT EXIT: " + FOLDER_FQN));
									goto NextFolder;
								}
								
								if (bLikToLib)
								{
									GetDirectoryLibraries(ParentDirForLib, LibraryList);
								}
								else
								{
									GetDirectoryLibraries(FOLDER_FQN, LibraryList);
								}
								
								//'getDirectoryParms(a , FolderName, gCurrUserGuidID)
								//'Dim IncludeSubDirs  = a(0)
								///Dim VersionFiles  = a(1)
								//'Dim ckMetaData  = a(2)
								//'OcrDirectory  = a(3)
								
								//** Get all of the files in this folder
								try
								{
									DirFiles.Clear();
									int ii = DMA.getFilesInDir(FOLDER_FQN, DirFiles, IncludedTypes, ExcludedTypes, ckSkipIfArchBitTrue);
									if (ii == 0)
									{
										if (xDebug)
										{
											LOG.WriteToArchiveLog((string) ("Archive Folder HAD NO FILES: " + FOLDER_FQN));
										}
										goto NextFolder;
									}
									ckFilesNeedUpdate(ref DirFiles, ckSkipIfArchBitTrue);
								}
								catch (Exception)
								{
									goto NextFolder;
								}
								
								//** Process all of the files
								for (int K = 0; K <= DirFiles.Count - 1; K++)
								{
									string sDir = DirFiles(K);
									sDir = DMA.getFileName(sDir);
									
									frmNotify.Default.lblFileSpec.Text = (string) ("Processing: " + sDir);
									frmNotify.Default.Refresh();
									
									//   [SourceGuid] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
									//	[CreateDate] [datetime] NULL CONSTRAINT [CURRDATE_04012008185318003]  DEFAULT (getdate()),
									//	[SourceName] [nvarchar](254) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
									//	[SourceImage] [image] NULL,
									//	[SourceTypeCode] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
									//	[FQN] [nvarchar](254) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
									//	[VersionNbr] [int] NULL CONSTRAINT [DF_DataSource_VersionNbr]  DEFAULT ((0)),
									//	[LastAccessDate] [datetime] NULL,
									//	[FileLength] [int] NULL,
									//	[LastWriteTime] [datetime] NULL,
									
									CRC = "";
									
									string SourceGuid = getGuid();
									string[] FileAttributes = DirFiles(K).Split("|");
									string file_FullName = FileAttributes[1];
									string file_SourceName = FileAttributes[0];
									string file_DirName = DMA.GetFilePath(file_FullName);
									
									if (xDebug)
									{
										LOG.WriteToArchiveLog((string) ("    File: " + file_SourceName));
									}
									
									string file_Length = FileAttributes[2];
									if (modGlobals.gMaxSize > 0)
									{
										if (val[file_Length] > modGlobals.gMaxSize)
										{
											LOG.WriteToArchiveLog("Notice: file \'" + file_FullName + "\' exceed the allowed file upload size, skipped.");
											goto NextFile;
										}
									}
									
									//**************************************************************************************************
									
									string CrcHash = ENC.getSha1HashFromFile(FQN);
									string AttachmentCode = "C";
									int iDatasourceCnt = getCountDataSourceFiles(file_SourceName, CrcHash);
									if (iDatasourceCnt == 0)
									{
										saveContentOwner(SourceGuid, modGlobals.gCurrUserGuidID, "C", file_DirName, modGlobals.gMachineID, modGlobals.gNetworkID);
									}
									
									
									//**************************************************************************************************
									
									if (K == 0 || K % 100 == 0)
									{
										if (xDebug)
										{
											LOG.WriteToArchiveLog((string) ("clsArchiver: ArchiveFolderContent :8010 : Processing files in folder: " + file_SourceName));
										}
									}
									
									bool bIsArchivedAlready = DMA.isFileArchiveAttributeSet(file_FullName);
									
									if (bIsArchivedAlready == true && ckSkipIfArchBitTrue == true)
									{
										if (xDebug)
										{
											LOG.WriteToArchiveLog("File : " + file_FullName + " archive bit was found to set TRUE, skipped file.");
										}
										goto NextFile;
									}
									
									
									string file_SourceTypeCode = FileAttributes[3];
									if (file_SourceTypeCode.Equals(".msg"))
									{
										LOG.WriteToArchiveLog("File : " + file_FullName + " was found to be a message file, skipped file.");
										
										string DisplayMsg = "A message file was encounted in a backup directory." + "\r\n";
										DisplayMsg = DisplayMsg + "It has been moved to the EMAIL Working directory." + "\r\n";
										DisplayMsg = DisplayMsg + "To archive a MSG file, it must be imported into outlook." + "\r\n";
										DisplayMsg = DisplayMsg + "This file has not been added to the CONTENT repository." + "\r\n";
										
										frmHelp.Default.MsgToDisplay = DisplayMsg;
										frmHelp.Default.CallingScreenName = "ECM Archive";
										frmHelp.Default.CaptionName = "MSG File Encounted in Content Archive";
										frmHelp.Default.Timer1.Interval = 10000;
										frmHelp.Default.Show();
										
										string EmailWorkingDirectory = getWorkingDirectory(modGlobals.gCurrUserGuidID, "EMAIL WORKING DIRECTORY");
										var EmailFQN = EmailWorkingDirectory + "\\" + file_SourceName.Trim();
										File F;
										if (F.Exists(EmailFQN))
										{
											string tMsg = (string) ("Email Encountered, already in EMAIL WORKING DIRECTORY: " + EmailFQN);
											LOG.WriteToArchiveLog(tMsg);
											xTrace(965, "ArchiveFolderContent", tMsg);
											FilesSkipped++;
										}
										else
										{
											F.Copy(file_FullName, EmailFQN);
											string tMsg = (string) ("Email Encountered, copied to EMAIL WORKING DIRECTORY: " + EmailFQN);
											LOG.WriteToArchiveLog(tMsg);
											xTrace(966, "ArchiveFolderContent", tMsg);
											FilesSkipped++;
										}
										goto NextFile;
									}
									FixFileExtension(ref file_SourceTypeCode);
									string file_LastAccessDate = FileAttributes[4];
									string file_CreateDate = FileAttributes[5];
									string file_LastWriteTime = FileAttributes[6];
									string OriginalFileType = file_SourceTypeCode;
									
									if (file_SourceTypeCode.ToLower().Equals(".exe"))
									{
										LOG.WriteToArchiveLog(file_FullName);
									}
									
									bool isZipFile = ZF.isZipFile(file_FullName);
									if (isZipFile == true)
									{
										int StackLevel = 0;
										Dictionary<string, int> ListOfFiles = new Dictionary<string, int>();
										string ExistingParentZipGuid = GetGuidByFqn(file_FullName, "0");
										if (ExistingParentZipGuid.Length > 0)
										{
											//ZipFiles.Add(file_FullName .Trim + "|" + ExistingParentZipGuid)
											DBLocal.addZipFile(file_FullName, ExistingParentZipGuid, false);
											ZF.UploadZipFile(UID, MachineID, file_FullName, ExistingParentZipGuid, true, false, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
										}
										else
										{
											//ZipFiles.Add(file_FullName .Trim + "|" + SourceGuid )
											DBLocal.addZipFile(file_FullName, SourceGuid, false);
											ZF.UploadZipFile(UID, MachineID, file_FullName, SourceGuid, true, false, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
										}
										ListOfFiles = null;
										GC.Collect();
									}
									Application.DoEvents();
									if (! isZipFile)
									{
										bool bExt = isExtExcluded(file_SourceTypeCode, true);
										if (bExt)
										{
											if (xDebug)
											{
												LOG.WriteToArchiveLog("A file of type \'" + file_SourceTypeCode + "\' has been encountered and is defined as NOT allowable. It will NOT be stored in the repository.");
											}
											if (xDebug)
											{
												LOG.WriteToArchiveLog(" ");
											}
											FilesSkipped++;
											goto NextFile;
										}
										//** See if the STAR is in the INCLUDE list, if so, all files are included
										bExt = isExtIncluded(file_SourceTypeCode, false);
										if (! bExt)
										{
											if (xDebug)
											{
												LOG.WriteToArchiveLog("A file of type \'" + file_SourceTypeCode + "\' has been encountered and is not defined as allowable. It will NOT be stored in the repository.");
											}
											if (xDebug)
											{
												LOG.WriteToArchiveLog(" ");
											}
											FilesSkipped++;
											goto NextFile;
										}
									}
									else
									{
										if (xDebug)
										{
											LOG.WriteToArchiveLog((string) ("clsArchiver: ArchiveFolderContent :8011 : Zip file encountered: " + file_SourceName));
										}
										if (xDebug)
										{
											LOG.WriteToArchiveLog("File : " + file_FullName + " was found to be a ZIP file.");
										}
									}
									
									
									string SubstituteFileType = getProcessFileAsExt(file_SourceTypeCode);
									int bcnt = iGetRowCount("SourceType", "where SourceTypeCode = \'" + file_SourceTypeCode + "\'");
									
									if (bcnt == 0 && SubstituteFileType == "")
									{
										if (SubstituteFileType == null)
										{
											string MSG = "The file type \'" + file_SourceTypeCode + "\' is undefined." + "\r\n" + "DO YOU WISH TO AUTOMATICALLY DEFINE IT?" + "\r\n" + "This will allow content to be archived, but not searched.";
											//Dim dlgRes As DialogResult = MessageBox.Show(MSG, "Filetype Undefined", MessageBoxButtons.YesNo)
											
											if (xDebug)
											{
												LOG.WriteToArchiveLog(MSG);
											}
											
											UNASGND.setApplied("0");
											UNASGND.setFiletype(ref file_SourceTypeCode);
											int iCnt = UNASGND.cnt_PK_AFTU(file_SourceTypeCode);
											if (iCnt == 0)
											{
												UNASGND.Insert();
											}
											
											clsSOURCETYPE ST = new clsSOURCETYPE();
											ST.setSourcetypecode(ref file_SourceTypeCode);
											ST.setSourcetypedesc("NO SEARCH - AUTO ADDED by Pgm");
											ST.setIndexable("0");
											ST.setStoreexternal(0);
											ST.Insert();
											
										}
										else if (SubstituteFileType.Trim().Length > 0)
										{
											file_SourceTypeCode = SubstituteFileType;
										}
									}
									else if (SubstituteFileType.Trim().Length > 0)
									{
										file_SourceTypeCode = SubstituteFileType;
									}
									
									string StoredExternally = "N";
									
									Application.DoEvents();
									//***********************************************************************'
									//** New file
									//***********************************************************************'
									if (iDatasourceCnt == 0)
									{
										Application.DoEvents();
										AttachmentCode = "C";
										
										bool BB = InsertSourcefile(UID, MachineID, modGlobals.gNetworkID, SourceGuid, file_FullName, file_SourceName, file_SourceTypeCode, file_LastAccessDate, file_CreateDate, file_LastWriteTime, modGlobals.gCurrUserGuidID, LastVerNbr, RetentionCode, isPublic, CrcHash, file_DirName);
										
										if (BB)
										{
											
											//Dim VersionNbr As String = "0"
											//Dim CRC As String = DMA.CalcCRC(file_FullName)
											//addContentHashKey(SourceGuid, "0", file_CreateDate , file_FullName, OriginalFileType, file_Length , CRC, MachineID)
											
											saveContentOwner(SourceGuid, modGlobals.gCurrUserGuidID, "C", FOLDER_FQN, MachineID, modGlobals.gNetworkID);
											
											FilesBackedUp++;
											if (xDebug)
											{
												LOG.WriteToArchiveLog("File : " + file_FullName + " was found to be NEW and was ADDED the repository.");
											}
											if (xDebug)
											{
												LOG.WriteToArchiveLog((string) ("clsArchiver: InsertSourcefile : Loading: 8012: " + file_SourceName));
											}
											
											bool bIsImageFile = isImageFile(file_FullName);
											
											UpdateCurrArchiveStats(file_FullName, file_SourceTypeCode);
											
											string sSql = "Update DataSource set RetentionExpirationDate = \'" + RetentionExpirationDate + "\' where SourceGuid = \'" + SourceGuid + "\'";
											bool bbExec = ExecuteSqlNewConn(sSql, false);
											if (! bbExec)
											{
												LOG.WriteToArchiveLog("ERROR: 1234.99c");
											}
											
										}
										else
										{
											FilesSkipped++;
											if (xDebug)
											{
												LOG.WriteToArchiveLog("ERROR File 66921x: clsArchiver : " + file_FullName + " was found to be NEW and was NOT ADDED to the repository.");
											}
											LOG.WriteToArchiveLog((string) ("FAILED TO LOAD: " + file_FullName));
											if (xDebug)
											{
												LOG.WriteToArchiveLog((string) ("clsArchiver: InsertSourcefile :FAILED TO LOAD: 8013b: " + file_SourceName));
											}
										}
										
										
										if (val[file_Length] > 1000000)
										{
											//FrmMDIMain.SB.Text = "Large file Load completed..."
											//'FrmMDIMain.SB.Refresh()
											//'DisplayActivity = False
											//'If Not ActivityThread Is Nothing Then
											//'    ActivityThread.Abort()
											//'    ActivityThread = Nothing
											//'End If
											frmMain.Default.PBx.Value = 0;
											Application.DoEvents();
										}
										if (BB)
										{
											if (xDebug)
											{
												LOG.WriteToArchiveLog("File : " + file_FullName + " metadata updated.");
											}
											if (xDebug)
											{
												LOG.WriteToArchiveLog("clsArchiver: InsertSourcefile :Success: 8014");
											}
											Application.DoEvents();
											UpdateDocFqn(SourceGuid, file_FullName);
											UpdateDocSize(SourceGuid, file_Length);
											UpdateDocDir(SourceGuid, file_FullName);
											UpdateDocOriginalFileType(SourceGuid, OriginalFileType);
											UpdateZipFileIndicator(SourceGuid, isZipFile);
											
											if (EmailGuid.Trim().Length > 0)
											{
												//VersionFiles  = "Y"
												UpdateEmailIndicator(SourceGuid, EmailGuid);
											}
											
											Application.DoEvents();
											if (xDebug)
											{
												LOG.WriteToArchiveLog("clsArchiver: InsertSourcefile :Success: 8015");
											}
											if (! isZipFile)
											{
												//Dim TheFileIsArchived As Boolean = True
												//DMA.setFileArchiveAttributeSet(file_FullName , TheFileIsArchived)
												DMA.ToggleArchiveBit(file_FullName);
											}
											
											UpdateDocCrc(SourceGuid, CrcHash);
											InsertSrcAttrib(SourceGuid, "CRC", CrcHash, OriginalFileType);
											InsertSrcAttrib(SourceGuid, "FILENAME", file_SourceName, OriginalFileType);
											InsertSrcAttrib(SourceGuid, "CreateDate", file_CreateDate, OriginalFileType);
											InsertSrcAttrib(SourceGuid, "FILESIZE", file_Length, OriginalFileType);
											InsertSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessDate, OriginalFileType);
											InsertSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, OriginalFileType);
											if (! file_SourceTypeCode.Equals(OriginalFileType))
											{
												InsertSrcAttrib(SourceGuid, "IndexAs", file_LastWriteTime, file_SourceTypeCode);
											}
											if (EmailGuid.Trim().Length > 0)
											{
												//VersionFiles  = "Y"
												InsertSrcAttrib(SourceGuid, "EMAIL_ATTACH", file_LastWriteTime, OriginalFileType);
											}
											
											if (xDebug)
											{
												LOG.WriteToArchiveLog("clsArchiver: InsertSourcefile :Success: 8016");
											}
											
											if (val[file_Length] > 1000000000)
											{
												//FrmMDIMain.SB4.Text = "Extreme File: " + file_Length  + " bytes - standby"
											}
											else if (val[file_Length] > 2000000)
											{
												//FrmMDIMain.SB4.Text = "Large File: " + file_Length  + " bytes"
												//'FrmMDIMain.SB.Refresh()
											}
											
											if (file_SourceTypeCode.IndexOf("wma") + 1 > 0 || file_SourceTypeCode.IndexOf("mp3") + 1 > 0)
											{
												Console.WriteLine("Recording here 06");
											}
											if (file_SourceTypeCode.ToLower().Equals(".mp3") || file_SourceTypeCode.ToLower().Equals(".wma") || file_SourceTypeCode.ToLower().Equals("wma"))
											{
												MP3.getRecordingMetaData(file_FullName, SourceGuid, file_SourceTypeCode);
												Application.DoEvents();
											}
											else if (file_SourceTypeCode.ToLower().Equals(".tiff") || file_SourceTypeCode.ToLower().Equals(".jpg"))
											{
												//** This functionality will be added at a later time
												//KAT.getXMPdata(file_FullName)
												Application.DoEvents();
											}
											else if (file_SourceTypeCode.ToLower().Equals(".png") || file_SourceTypeCode.ToLower().Equals(".gif"))
											{
												//** This functionality will be added at a later time
												//KAT.getXMPdata(file_FullName)
												Application.DoEvents();
											}
											else if (file_SourceTypeCode.ToLower().Equals(".wav"))
											{
												MP3.getRecordingMetaData(file_FullName, SourceGuid, file_SourceTypeCode);
											}
											else if (file_SourceTypeCode.ToLower().Equals(".tif"))
											{
												//** This functionality will be added at a later time
												//KAT.getXMPdata(file_FullName)
												Application.DoEvents();
											}
											Application.DoEvents();
											if ((file_SourceTypeCode.ToLower().Equals(".doc") || file_SourceTypeCode.ToLower().Equals(".docx")) && ckMetaData.Equals("Y"))
											{
												GetWordDocMetadata(file_FullName, SourceGuid, OriginalFileType);
											}
											if ((file_SourceTypeCode.Equals(".xls") || file_SourceTypeCode.Equals(".xlsx") || file_SourceTypeCode.Equals(".xlsm")) && ckMetaData.Equals("Y"))
											{
												GetExcelMetaData(file_FullName, SourceGuid, OriginalFileType);
											}
										}
										
									}
NextFile:
									//Me.'FrmMDIMain.SB.Text = "Processing document #" + K.ToString
									//FrmMDIMain.SB.Text = "Processing Dir: " + FolderName + " # " + K.ToString
									if (xDebug)
									{
										LOG.WriteToArchiveLog("clsArchiver: InsertSourcefile :Success: 8032");
									}
									Application.DoEvents();
									if (xDebug)
									{
										LOG.WriteToArchiveLog("============== File : " + file_FullName + " Was processed as above.");
									}
								}
							}
							else
							{
								if (xDebug)
								{
									LOG.WriteToArchiveLog((string) ("Duplicate Folder: " + FolderName));
								}
								if (xDebug)
								{
									LOG.WriteToArchiveLog("clsArchiver: InsertSourcefile :Success: 8034");
								}
							}
NextFolder:
							if (xDebug)
							{
								LOG.WriteToArchiveLog("+++++++++++++++ Getting Next Folder");
							}
							pFolder = FolderName;
						}
						if (xDebug)
						{
							LOG.WriteToArchiveLog("@@@@@@@@@@@@@@  Done with FOLDER Archive.");
						}
						
					}
					public void ProcessZipFilesX(string UID, string MachineID, bool ckSkipIfArchived, bool bThisIsAnEmail, string RetentionCode, string isPublic)
					{
						for (int i = 0; i <= ZipFiles.Count - 1; i++)
						{
							string cData = ZipFiles[i].ToString();
							string ParentGuid = "";
							string FQN = "";
							int K = cData.IndexOf("|") + 1;
							FQN = cData.Substring(0, K - 1);
							ParentGuid = cData.Substring(K + 1 - 1);
							
							int StackLevel = 0;
							Dictionary<string, int> ListOfFiles = new Dictionary<string, int>();
							ZF.UploadZipFile(UID, MachineID, FQN, ParentGuid, ckSkipIfArchived, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
							ListOfFiles = null;
							GC.Collect();
						}
					}
					public void FixFileExtension(ref string Extension)
					{
						Extension = Extension.Trim();
						Extension = Extension.ToLower();
						if (Extension.IndexOf(".") + 1 == 0)
						{
							Extension = (string) ("." + Extension);
						}
						while (Extension.IndexOf(",") + 1 > 0)
						{
							StringType.MidStmtStr(ref Extension, Extension.IndexOf(",") + 1, 1, ".");
						}
						return;
					}
					public bool isExtExcluded(string fExt, bool ExcludeAll)
					{
						
						if (ExcludeAll == false)
						{
							return ExcludeAll;
						}
						
						fExt = fExt.ToUpper();
						if (fExt.Length > 1)
						{
							fExt = fExt.ToUpper();
							if (fExt.Substring(0, 1) == ".")
							{
								StringType.MidStmtStr(ref fExt, 1, 1, " ");
								fExt = fExt.Trim();
							}
						}
						
						bool B = false;
						for (int i = 0; i <= ExcludedTypes.Count - 1; i++)
						{
							string tExtension = ExcludedTypes[i].ToString();
							if (tExtension.ToUpper().Equals(fExt.ToUpper()))
							{
								B = true;
								break;
							}
							else if (tExtension.ToUpper().Equals("*"))
							{
								B = true;
								break;
							}
						}
						return B;
						
					}
					public bool isExtIncluded(string fExt, bool IncludeAll)
					{
						
						if (IncludeAll == true)
						{
							return IncludeAll;
						}
						
						fExt = fExt.ToUpper();
						if (fExt.Length > 1)
						{
							fExt = fExt.ToUpper();
							if (fExt.Substring(0, 1) == ".")
							{
								StringType.MidStmtStr(ref fExt, 1, 1, " ");
								fExt = fExt.Trim();
							}
						}
						
						bool B = false;
						for (int i = 0; i <= IncludedTypes.Count - 1; i++)
						{
							string tExtension = IncludedTypes[i].ToString();
							if (tExtension.ToUpper().Equals(fExt.ToUpper()))
							{
								B = true;
								break;
							}
							else if (tExtension.ToUpper().Equals("*"))
							{
								B = true;
								break;
							}
						}
						return B;
						
					}
					public void UpdateSrcAttrib(string SGUID, string aName, string aVal, string SourceType)
					{
						int iCnt = SRCATTR.cnt_PK35(aName, modGlobals.gCurrUserGuidID, SGUID);
						if (iCnt == 0)
						{
							SRCATTR.setSourceguid(ref SGUID);
							SRCATTR.setAttributename(ref aName);
							SRCATTR.setAttributevalue(ref aVal);
							SRCATTR.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
							SRCATTR.setSourcetypecode(ref SourceType);
							SRCATTR.Insert();
						}
						else
						{
							string WC = SRCATTR.wc_PK35(aName, modGlobals.gCurrUserGuidID, SGUID);
							SRCATTR.setSourceguid(ref SGUID);
							SRCATTR.setAttributename(ref aName);
							SRCATTR.setAttributevalue(ref aVal);
							SRCATTR.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
							SRCATTR.setSourcetypecode(ref SourceType);
							SRCATTR.Update(WC);
						}
						
					}
					public bool OutlookFolderNames(string MailboxName)
					{
						//********************************************************
						//PARAMETER: MailboxName = Name of Parent Outlook Folder for
						//the current user: Usually in the form of
						//"Mailbox - Doe, John" or
						//"Public Folders
						//RETURNS: Array of SubFolders in Current User's Mailbox
						//Or unitialized array if error occurs
						//Because it returns an array, it is for VB6 only.
						//Change to return a variant or a delimited list for
						//previous versions of vb
						//EXAMPLE:
						//Dim sArray() As String
						//Dim ictr As Integer
						//sArray = OutlookFolderNames("Mailbox - Doe, John")
						//        'On Error Resume Next
						//For ictr = 0 To UBound(sArray)
						// log.WriteToArchiveLog sArray(ictr)
						//Next
						//*********************************************************
						Outlook.Application oOutlook;
						Outlook._NameSpace oMAPI;
						Outlook.MAPIFolder oParentFolder;
						string[] sArray;
						int i;
						int iElement;
						
						try
						{
							if (xDebug)
							{
								LOG.WriteToArchiveLog("Entry OutlookFolderNames 001");
							}
							oOutlook = new Outlook.Application();
							if (xDebug)
							{
								LOG.WriteToArchiveLog("Entry OutlookFolderNames 002");
							}
							oMAPI = oOutlook.GetNamespace("MAPI");
							if (xDebug)
							{
								LOG.WriteToArchiveLog("Entry OutlookFolderNames 003");
							}
							oParentFolder = oMAPI.Folders[MailboxName];
							if (xDebug)
							{
								LOG.WriteToArchiveLog("Entry OutlookFolderNames 004");
							}
							
							Array.Resize(ref sArray, 1);
							frmMsg.Default.Show();
							frmMsg.Default.txtMsg.Text = "Loading Outlook Folders";
							if (oParentFolder.Folders.Count != 0)
							{
								if (xDebug)
								{
									LOG.WriteToArchiveLog("Found Outlook Folders 005 Start: Count = " + oParentFolder.Folders.Count.ToString() + ".");
								}
								for (i = 1; i <= oParentFolder.Folders.Count; i++)
								{
									
									Application.DoEvents();
									try
									{
										string tName = oParentFolder.Folders[i].Name.ToString();
										if (xDebug)
										{
											LOG.WriteToArchiveLog("Entry OutlookFolderNames 005 Loop: " + tName + ".");
										}
										if (tName.Trim().Length > 0)
										{
											if (xDebug)
											{
												LOG.WriteToArchiveLog("Entry OutlookFolderNames 005a: " + tName + ".");
											}
											//If Trim(oMAPI.GetDefaultFolder(oParentFolder.olFolderInbox).Folders.Item(i).Name) <> "" Then
											if (tName != "")
											{
												if (xDebug)
												{
													LOG.WriteToArchiveLog("Entry OutlookFolderNames 005b: " + tName + ".");
												}
												if (sArray[0] == "")
												{
													if (xDebug)
													{
														LOG.WriteToArchiveLog("Entry OutlookFolderNames 005c: " + tName + ".");
													}
													iElement = 0;
												}
												else
												{
													if (xDebug)
													{
														LOG.WriteToArchiveLog("Entry OutlookFolderNames 005d: " + tName + ".");
													}
													iElement = System.Convert.ToInt32((sArray.Length - 1) + 1);
												}
												if (xDebug)
												{
													LOG.WriteToArchiveLog("Entry OutlookFolderNames 005e: " + tName + ".");
												}
												Array.Resize(ref sArray, iElement + 1);
												if (xDebug)
												{
													LOG.WriteToArchiveLog("Entry OutlookFolderNames 005f: " + tName + ".");
												}
												sArray[iElement] = oParentFolder.Folders[i].Name;
												if (xDebug)
												{
													LOG.WriteToArchiveLog("Entry OutlookFolderNames 005g: " + tName + ".");
												}
											}
										}
									}
									catch (Exception ex)
									{
										LOG.WriteToArchiveLog((string) ("NOTICE:OutlookFolderNames 005x: Item #" + i.ToString() + "\r\n" + ex.Message));
									}
								}
							}
							else
							{
								if (xDebug)
								{
									LOG.WriteToArchiveLog("Entry OutlookFolderNames 006");
								}
								sArray[0] = oParentFolder.Name;
							}
							if (xDebug)
							{
								LOG.WriteToArchiveLog("Entry OutlookFolderNames 007");
							}
							oMAPI = null;
						}
						catch (Exception ex)
						{
							LOG.WriteToArchiveLog("NOTICE 5692.13a OutlookFolderNames - Could not access Outlook. ");
							LOG.WriteToArchiveLog((string) ("NOTICE 5692.13b -" + ex.Message));
							LOG.WriteToArchiveLog((string) ("NOTICE 5692.13c -" + ex.StackTrace));
							frmMsg.Default.Close();
							frmMsg.Default.Hide();
							return false;
						}
						
						if (xDebug)
						{
							LOG.WriteToArchiveLog("Entry OutlookFolderNames 008");
						}
						frmMsg.Default.Close();
						frmMsg.Default.Hide();
						
						return true;
						
					}
					public void ArchiveAllEmail(string UID)
					{
						
						clsProcess PROC = new clsProcess();
						
						string TopLevelOutlookFolder = "";
						
						if (isArchiveDisabled("EMAIL") == true)
						{
							return;
						}
						
						ArrayList ActiveEmailFolders = new ArrayList();
						
						ActiveEmailFolders = getOutlookParentFolderNames();
						
						ActiveEmailFolders = getOutlookParentFolderNames();
						
						DateTime LastEmailArchRunDate = DateTime.Now;
						//getOutlookParentFolderNames(Me.cbParentFolders)
						string EmailFolder = "";
						for (int XX = 0; XX <= ActiveEmailFolders.Count - 1; XX++)
						{
							
							EmailFolder = ActiveEmailFolders[XX].ToString();
							
							if (EmailFolder.Trim().Length == 0)
							{
								goto NextFolder;
							}
							
							ZeroizeEmailToDelete(modGlobals.gCurrUserGuidID);
							int subFoldersToProcessCnt = setActiveEmailFolders(EmailFolder, modGlobals.gCurrUserGuidID);
							if (subFoldersToProcessCnt == 0)
							{
								goto NextFolder;
							}
							//***************************************************************
							bool bUseQuickSearch = false;
							clsDatabase DB = new clsDatabase();
							int NbrOfIds = DB.getCountStoreIdByFolder();
							SortedList slStoreId = new SortedList();
							if (NbrOfIds <= 5000000)
							{
								bUseQuickSearch = true;
							}
							else
							{
								bUseQuickSearch = false;
							}
							if (bUseQuickSearch)
							{
								DBLocal.getCE_EmailIdentifiers(slStoreId);
							}
							else
							{
								slStoreId.Clear();
							}
							//***************************************************************
							
							ArchiveSelectedOutlookFolders(UID, EmailFolder, slStoreId);
							if (xDebug)
							{
								LOG.WriteToArchiveLog((string) ("** Completed Processing folder: " + EmailFolder));
							}
							//*********************************************************************************
							UserParmInsertUpdate("LastEmailArchRunDate", modGlobals.gCurrUserGuidID, LastEmailArchRunDate);
							
							//UpdateMessageStoreID(gCurrUserGuidID)
							try
							{
								DeleteOutlookMessages(modGlobals.gCurrUserGuidID);
							}
							catch (Exception)
							{
								LOG.WriteToArchiveLog("WARNING 2005.32.1 - call DEleteOutlookMessages failed.");
							}
							
							GC.Collect();
							
							PROC.getProcessesToKill();
							PROC.KillOrphanProcesses();
NextFolder:
							1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
						}
						PROC = null;
					}
					
					public void SetNewPST(string strFileName)
					{
						Outlook.Application objOL;
						Outlook.NameSpace objNS;
						Outlook.MAPIFolder objFolder;
						
						objOL = Interaction.CreateObject("Outlook.Application", "");
						objNS = objOL.GetNamespace("MAPI");
						objNS.AddStore(strFileName);
						objFolder = objNS.Folders.GetFirst();
						while (objFolder != null)
						{
							Console.WriteLine(objFolder.Name);
							//For i As Integer = 0 To objFolder.Items.Count - 1
							//    For Each EMAIL In
							//    Next
							//    objFolder = objNS.Folders.GetNext
						}
						
						objOL = null;
						objNS = null;
						objFolder = null;
					}
					//Public Function AddLibraryItem(ByVal SourceGuid , ByVal ItemTitle , ByVal FileExt , ByVal LibraryName ) As Boolean
					
					//    ItemTitle  = UTIL.RemoveSingleQuotes(ItemTitle )
					//    LibraryName  = UTIL.RemoveSingleQuotes(LibraryName )
					
					//    Dim LibraryOwnerUserID  = gCurrUserGuidID
					//    Dim DataSourceOwnerUserID  = gCurrUserGuidID
					//    Dim LibraryItemGuid  = Guid.NewGuid.ToString
					//    Dim AddedByUserGuidId  = gCurrUserGuidID
					
					//    Dim SS  = "Select count(*) from LibraryItems where LibraryName = '" + LibraryName  + "' and SourceGuid = '" + SourceGuid  + "'"
					//    Dim iCnt As Integer = iCount(SS)
					//    If iCnt > 0 Then
					//        Return True
					//    End If
					
					//    Dim b As Boolean = False
					//    Dim s As String = ""
					//    s = s + " INSERT INTO LibraryItems("
					//    s = s + "SourceGuid,"
					//    s = s + "ItemTitle,"
					//    s = s + "ItemType,"
					//    s = s + "LibraryItemGuid,"
					//    s = s + "DataSourceOwnerUserID,"
					//    s = s + "LibraryOwnerUserID,"
					//    s = s + "LibraryName,"
					//    s = s + "AddedByUserGuidId) values ("
					//    s = s + "'" + SourceGuid + "'" + ","
					//    s = s + "'" + ItemTitle + "'" + ","
					//    s = s + "'" + FileExt  + "'" + ","
					//    s = s + "'" + LibraryItemGuid + "'" + ","
					//    s = s + "'" + DataSourceOwnerUserID + "'" + ","
					//    s = s + "'" + LibraryOwnerUserID + "'" + ","
					//    s = s + "'" + LibraryName + "'" + ","
					//    s = s + "'" + AddedByUserGuidId + "'" + ")"
					//    Application.DoEvents()
					//    Return ExecuteSqlNewConn(s, False)
					
					
					
					//End Function
					
					public string ReduceDirByOne(string DirName)
					{
						
						string CH = "";
						int I = 0;
						
						for (I = DirName.Length; I >= 1; I--)
						{
							CH = DirName.Substring(I - 1, 1);
							if (CH == "\\")
							{
								return DirName.Substring(0, I - 1);
							}
						}
						return "";
					}
					
					public bool SendHelpRequest(string CompanyID, string RequestorName, string RequestorEmail, string RequestorPhone, string RequestDesc, string FQN)
					{
						
						// Create an Outlook application.
						// Create a new MailItem.
						Outlook._Application oApp;
						oApp = new Outlook.Application();
						Outlook._MailItem oMsg;
						Outlook.Attachment oAttach;
						Outlook.Attachments oAttachs = null;
						
						string CCAddr = "";
						string HelpEmails = getHelpEmail();
						string[] Emails = HelpEmails.Split("|".ToCharArray());
						for (int I = 0; I <= (Emails.Length - 1); I++)
						{
							if (Emails[I].Trim().Length > 0)
							{
								if ((Emails[I]).IndexOf("support@ecmlibrary") + 1 == 0)
								{
									CCAddr = CCAddr + "; " + Emails[I];
								}
							}
						}
						try
						{
							if (CCAddr.Trim().Length > 0)
							{
								CCAddr = CCAddr.Trim();
								if (CCAddr.Substring(0, 1).Equals(";"))
								{
									StringType.MidStmtStr(ref CCAddr, 1, 1, " ");
									CCAddr = CCAddr.Trim();
								}
							}
							
							oMsg = oApp.CreateItem(Outlook.OlItemType.olMailItem);
							oMsg.Subject = "HELP Request";
							oMsg.Body = (string) ("From Name: " + RequestorName + Constants.vbCr + (Constants.vbCr + "Phone Number: ") + RequestorPhone + Constants.vbCr + (Constants.vbCr + "Problem description: ") + RequestDesc);
							
							// TODO: Replace with a valid e-mail address.
							oMsg.To = "support@EcmLibrary.com";
							
							oMsg.CC = CCAddr;
							
							// Add an attachment
							// TODO: Replace with a valid attachment path.
							
							string sSource = FQN;
							// TODO: Replace with attachment name
							string sDisplayName = CompanyID + " : " + RequestorName;
							
							string sBodyLen = RequestDesc.Length.ToString();
							oAttachs = oMsg.Attachments;
							oAttach = oAttachs.Add(sSource, null, sBodyLen + 1, sDisplayName);
							
							// Send
							oMsg.Send();
							
							return true;
						}
						catch (Exception ex)
						{
							LOG.WriteToArchiveLog((string) ("ERROR SendHelpRequest 100 - " + ex.Message));
							
						}
						finally
						{
							// Clean up
							oApp = null;
							oMsg = null;
							oAttach = null;
							oAttachs = null;
						}
						
						return false;
						
					}
					
					public void ArchiveSingleFile(string UID, string MachineID, string DirName, string FQN, string DirGuid, ref bool Successful)
					{
						
						string RetentionCode = "Retain 10";
						string isPublic = "N";
						
						Successful = true;
						
						File F1;
						bool bExists = false;
						if (F1.Exists(FQN))
						{
							bExists = true;
						}
						F1 = null;
						
						clsDATASOURCE_V2 DOCS = new clsDATASOURCE_V2();
						clsProcess PROC = new clsProcess();
						
						int NbrFilesInDir = 0;
						
						int LastVerNbr = 0;
						int NextVersionNbr = 0;
						
						if (isArchiveDisabled("CONTENT") == true)
						{
							DOCS = null;
							PROC = null;
							return;
						}
						
						string PrevParentDir = "";
						
						PROC.getCurrentApplications();
						
						if (dDebug)
						{
							LOG.WriteToListenLog("ArchiveSingleFile : ArchiveContent :8000 : trace log.");
						}
						
						int RetentionYears = int.Parse(val[getSystemParm("RETENTION YEARS")]);
						
						DateTime rightNow = DateTime.Now.AddYears(RetentionYears);
						string RetentionExpirationDate = rightNow.ToString();
						string EmailFQN = "";
						ZipFiles.Clear();
						string[] a = new string[1];
						
						//Dim ActiveFolders(0)
						List<string> ActiveFolders = new List<string>();
						string FolderName = "";
						bool DeleteFile = false;
						var OcrDirectory = "";
						List<string> ListOfDisabledDirs = new List<string>();
						//********************************************************************
						
						string TemporaryDirName = DirName;
						LOG.WriteToArchiveLog((string) ("Info: ArchiveSingleFile 01 - " + (DirName + ":") + modGlobals.gCurrUserGuidID + ":" + TemporaryDirName));
						
						bool AD_set = setContentArchiveFileFolder(modGlobals.gCurrUserGuidID, ActiveFolders, TemporaryDirName);
						
						string S = "";
						S = S + " SELECT count(*) ";
						S = S + " FROM  Directory ";
						S = S + " WHERE Directory.UserID = \'" + modGlobals.gCurrUserGuidID + "\' and (AdminDisabled = 0 or AdminDisabled is null) and FQN = \'" + DirName + "\' ";
						
						int icnt = iCount(S);
						
						while (AD_set == false)
						{
							if (TemporaryDirName.IndexOf("\\") + 1 > 0)
							{
								TemporaryDirName = ReduceDirByOne(TemporaryDirName);
								AD_set = setContentArchiveFileFolder(modGlobals.gCurrUserGuidID, ActiveFolders, TemporaryDirName);
							}
							else
							{
								break;
							}
						}
						//log.WriteToArchiveLog("Info: ArchiveSingleFile 05 - " & TemporaryDirName)
						if (AD_set == false)
						{
							LOG.WriteToArchiveLog("NOTIFICATION - ArchiveSingleFile 001: Did not find file \'" + DirName + " / " + FQN + "\', skipping.");
							if (bExists == false)
							{
								return;
							}
							else
							{
								//Dim FOLDER_FQN as string  = FolderParms(0)
								//Dim FOLDER_IncludeSubDirs  = FolderParms(1)
								//Dim FOLDER_DBID  = FolderParms(2)
								//Dim FOLDER_VersionFiles  = FolderParms(3)
								//Dim DisableDir  = FolderParms(4)
								//OcrDirectory = FolderParms(5)
								//Dim ParentDir = FolderParms(6)
								//Dim skipArchiveBit = FolderParms(7)
								string TempStr = "";
								TempStr += DirName + "|";
								TempStr += "N" + "|";
								TempStr += "ECMREPO" + "|";
								TempStr += "N" + "|";
								TempStr += "N" + "|";
								TempStr += "Y" + "|";
								TempStr += DirName + "|";
								TempStr += "FALSE" + "|";
								TempStr += "FALSE";
								ActiveFolders.Add(TempStr);
							}
						}
						
						if (ActiveFolders.Count == 0)
						{
							Successful = true;
							LOG.WriteToListenLog("ArchiveSingleFile : ActiveFolders was ZERO.");
							goto SKIPOUT;
						}
						if (! ActiveFolders.Contains(DirName))
						{
							ActiveFolders.Add(DirName);
						}
						getDisabledDirectories(ListOfDisabledDirs);
						//********************************************************************
						
						string cFolder = "";
						string pFolder = "XXX";
						List<string> DirFiles = new List<string>();
						string ArchiveMsg = "";
						
						if (dDebug)
						{
							LOG.WriteToListenLog("ArchiveSingleFile : ArchiveContent :8001 : trace log.");
						}
						
						FilesBackedUp = 0;
						FilesSkipped = 0;
						List<string> LibraryList = new List<string>();
						
						for (int i = 0; i <= ActiveFolders.Count - 1; i++)
						{
							
							//If gTerminateImmediately Then
							//    Return
							//End If
							
							Application.DoEvents();
							
							string FolderParmStr = (string) (ActiveFolders(i).ToString().Trim);
							string[] FolderParms = FolderParmStr.Split("|".ToCharArray());
							
							if (FolderParms.Count < 3)
							{
								LOG.WriteToListenLog("ArchiveSingleFile : FolderParms.Count < 3 .");
								goto NextFolder;
							}
							
							string FOLDER_FQN = FolderParms[0];
							
							bool bDisabled = ckFolderDisabled(modGlobals.gCurrUserGuidID, FOLDER_FQN);
							
							if (bDisabled)
							{
								LOG.WriteToArchiveLog("Notice: Folder " + FOLDER_FQN + " disabled.");
								goto NextFolder;
							}
							
							Console.WriteLine("Archiving : " + FOLDER_FQN);
							if (FOLDER_FQN.IndexOf("%userid%") + 1)
							{
								string S1 = "";
								string S2 = "";
								int iLoc = FOLDER_FQN.IndexOf("%userid%") + 1;
								S1 = FOLDER_FQN.Substring(0, iLoc - 1);
								S2 = FOLDER_FQN.Substring(iLoc + "%userid%".Length - 1);
								string UserName = System.Environment.UserName;
								FOLDER_FQN = S1 + UserName + S2;
							}
							
							if (ListOfDisabledDirs.Contains(FOLDER_FQN))
							{
								LOG.WriteToListenLog("NOTICE: Folder \'" + FOLDER_FQN + "\' is disabled from archive, skipping.");
								Successful = true;
								FQN = UTIL.RemoveSingleQuotes(FQN);
								S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = \'" + FQN + "\' and MachineName = \'" + MachineID + "\'";
								bool B = ExecuteSqlNewConn(S);
								
								goto NextFolder;
							}
							
							if (dDebug)
							{
								LOG.WriteToListenLog((string) ("ArchiveSingleFile : ArchiveContent :8002 :FOLDER_FQN : " + FOLDER_FQN));
							}
							
							//Dim FOLDER_FQN as string  = FolderParms(0)
							//Dim FOLDER_IncludeSubDirs  = FolderParms(1)
							//Dim FOLDER_DBID  = FolderParms(2)
							//Dim FOLDER_VersionFiles  = FolderParms(3)
							//Dim DisableDir  = FolderParms(4)
							//OcrDirectory = FolderParms(5)
							//Dim ParentDir = FolderParms(6)
							//Dim skipArchiveBit = FolderParms(7)
							
							string FOLDER_IncludeSubDirs = FolderParms[1];
							string FOLDER_DBID = FolderParms[2];
							string FOLDER_VersionFiles = FolderParms[3];
							string DisableDir = FolderParms[4];
							OcrDirectory = FolderParms[5];
							string ParentDir = FolderParms[6];
							string skipArchiveBit = FolderParms[7];
							bool ckSkipIfArchived = false;
							
							if (skipArchiveBit.ToUpper().Equals("TRUE"))
							{
								ckSkipIfArchived = true;
							}
							else
							{
								ckSkipIfArchived = false;
							}
							
							ckSkipIfArchived = false;
							
							FOLDER_FQN = UTIL.ReplaceSingleQuotes(FOLDER_FQN);
							
							if (Directory.Exists(FOLDER_FQN))
							{
								if (dDebug)
								{
									LOG.WriteToListenLog((string) ("ArchiveSingleFile : ArchiveContent :8003 :FOLDER Exists: " + FOLDER_FQN));
								}
								if (dDebug)
								{
									LOG.WriteToListenLog((string) ("Archive Folder: " + FOLDER_FQN));
								}
							}
							else
							{
								if (dDebug)
								{
									LOG.WriteToListenLog((string) ("WARNING - ArchiveSingleFile : ArchiveContent :8004 :FOLDER DOES NOT Exist: " + FOLDER_FQN));
								}
								if (dDebug)
								{
									LOG.WriteToListenLog((string) ("WARNING - Archive Folder FOUND MISSING: " + FOLDER_FQN));
								}
								FQN = UTIL.RemoveSingleQuotes(FQN);
								S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = \'" + FQN + "\' and MachineName = \'" + MachineID + "\'";
								bool B = ExecuteSqlNewConn(S);
								
								goto NextFolder;
							}
							if (DisableDir.Equals("Y"))
							{
								LOG.WriteToListenLog((string) ("WARNIGN - ArchiveSingleFile : Directory Archive Disabled: " + FOLDER_FQN + " skipped file " + FQN));
								FQN = UTIL.RemoveSingleQuotes(FQN);
								S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = \'" + FQN + "\' and MachineName = \'" + MachineID + "\'";
								bool B = ExecuteSqlNewConn(S);
								
								goto NextFolder;
							}
							
							if (FOLDER_FQN.IndexOf("\'") + 1 > 0)
							{
								Console.WriteLine("Single Quote found");
							}
							
							//******************************************************************************
							if (PrevParentDir != ParentDir)
							{
								GetAllIncludedFiletypes(ParentDir, IncludedTypes, FOLDER_IncludeSubDirs);
								GetAllExcludedFiletypes(ParentDir, ExcludedTypes, FOLDER_IncludeSubDirs);
							}
							if (IncludedTypes.Count == 0)
							{
								goto NextFolder;
							}
							//******************************************************************************
							PrevParentDir = ParentDir;
							if (dDebug)
							{
								LOG.WriteToListenLog((string) ("ArchiveSingleFile : ArchiveContent :8005 : Trace: " + FOLDER_FQN));
							}
							bool bChanged = false;
							
							if (FOLDER_FQN != pFolder)
							{
								
								string ParentDirForLib = "";
								bool bLikToLib = false;
								bLikToLib = isDirInLibrary(FOLDER_FQN, ref ParentDirForLib);
								
								
								if (dDebug)
								{
									LOG.WriteToListenLog((string) ("ArchiveSingleFile : ArchiveContent :8006 : Folder Changed: " + FOLDER_FQN + ", " + pFolder));
								}
								FolderName = FOLDER_FQN;
								if (dDebug)
								{
									Debug.Print((string) ("Processing Folder: " + FolderName));
								}
								if (dDebug)
								{
									LOG.WriteToListenLog((string) ("Archiving Folder: " + FolderName));
								}
								
								Application.DoEvents();
								//** Verify that the DIR still exists
								if (! Directory.Exists(FolderName))
								{
									LOG.WriteToListenLog((string) ("ArchiveSingleFile : Directory does not exist: " + FOLDER_FQN));
									FQN = UTIL.RemoveSingleQuotes(FQN);
									S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = \'" + FQN + "\' and MachineName = \'" + MachineID + "\'";
									bool B = ExecuteSqlNewConn(S);
									
									goto NextFolder;
								}
								
								if (bLikToLib)
								{
									GetDirectoryLibraries(ParentDirForLib, LibraryList);
								}
								else
								{
									GetDirectoryLibraries(FOLDER_FQN, LibraryList);
								}
								
								RetentionCode = GetDirRetentionCode(ParentDir, modGlobals.gCurrUserGuidID);
								if (RetentionCode.Length > 0)
								{
									RetentionYears = getRetentionPeriod(RetentionCode);
								}
								else
								{
									RetentionYears = int.Parse(val[getSystemParm("RETENTION YEARS")]);
								}
								
								getDirectoryParms(ref a, ParentDir, modGlobals.gCurrUserGuidID);
								
								string IncludeSubDirs = a[0];
								string VersionFiles = a[1];
								string ckMetaData = a[2];
								OcrDirectory = a[3];
								RetentionCode = a[4];
								
								//*****************************************************************************
								//** Get all of the files in this folder
								//*****************************************************************************
								try
								{
									if (dDebug)
									{
										LOG.WriteToListenLog("Starting File capture");
									}
									DirFiles.Clear();
									if (dDebug)
									{
										LOG.WriteToListenLog("Starting File capture: Init Dirfiles");
									}
									//*******************************************************************************************************************
									if (FQN.IndexOf(":") + 1 > 0)
									{
										DirFiles.Add(FQN);
									}
									else
									{
										DirFiles.Add(DirName + "\\" + FQN);
									}
									
									//NbrFilesInDir = DMA.getFilesInDir(FOLDER_FQN , DirFiles , IncludedTypes, ExcludedTypes, ckSkipIfArchived)
									NbrFilesInDir = 1;
									//*******************************************************************************************************************
									if (dDebug)
									{
										LOG.WriteToListenLog("Starting File capture: Loaded files");
									}
									if (NbrFilesInDir == 0)
									{
										if (dDebug)
										{
											LOG.WriteToListenLog((string) ("Archive Folder HAD NO FILES: " + FOLDER_FQN));
										}
										FQN = UTIL.RemoveSingleQuotes(FQN);
										S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = \'" + FQN + "\' and MachineName = \'" + MachineID + "\'";
										bool B = ExecuteSqlNewConn(S);
										
										goto NextFolder;
									}
									if (dDebug)
									{
										LOG.WriteToListenLog("Starting File capture: start ckFilesNeedUpdate");
									}
									//*******************************
									//** WDM 2/21/2010  ckFilesNeedUpdate(DirFiles , ckSkipIfArchived)
									//*******************************
									if (dDebug)
									{
										LOG.WriteToListenLog("Starting File capture: end ckFilesNeedUpdate");
									}
								}
								catch (Exception)
								{
									LOG.WriteToListenLog((string) ("ERROR Archive Folder Acquisition Failure : " + FOLDER_FQN));
									
									goto NextFolder;
								}
								
								//** Process all of the files
								for (int K = 0; K <= DirFiles.Count - 1; K++)
								{
									
									if (modGlobals.gTerminateImmediately)
									{
										DOCS = null;
										PROC = null;
										return;
									}
									
									
									Application.DoEvents();
									if (DirFiles(K) == null)
									{
										LOG.WriteToListenLog((string) ("ArchiveSingleFile : DirFiles(K) = Nothing " + FOLDER_FQN));
										goto NextFile;
									}
									
									System.IO.FileInfo fileDetail;
									
									
									string SourceGuid = getGuid();
									//Dim FileAttributes () = DirFiles(K).Split("|")
									string OriginalFileName = "";
									string file_FullName = DirFiles(0);
									bool BBB = true;
									File F;
									if (F.Exists(file_FullName))
									{
										BBB = true;
										FileInfo FI = new FileInfo(file_FullName);
										OriginalFileName = FI.Name;
										FI = null;
										GC.Collect();
									}
									else
									{
										BBB = false;
									}
									F = null;
									GC.Collect();
									if (BBB == false)
									{
										LOG.WriteToListenLog((string) ("ArchiveSingleFile :BBB file does not exist: " + file_FullName));
										Successful = true;
										FQN = UTIL.RemoveSingleQuotes(FQN);
										S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = \'" + FQN + "\' and MachineName = \'" + MachineID + "\'";
										bool B = ExecuteSqlNewConn(S);
										
										goto NextFile;
									}
									
									string file_SourceName = DMA.getFileName(file_FullName);
									if (dDebug)
									{
										Debug.Print((string) ("    File: " + file_SourceName));
									}
									
									fileDetail = (new Microsoft.VisualBasic.Devices.ServerComputer()).FileSystem.GetFileInfo(file_FullName);
									
									
									
									string file_Length = fileDetail.Length.ToString();
									if (modGlobals.gMaxSize > 0)
									{
										if (val[file_Length] > modGlobals.gMaxSize)
										{
											LOG.WriteToListenLog("Notice: file \'" + file_FullName + "\' exceed the allowed file upload size, skipped.");
											FQN = UTIL.RemoveSingleQuotes(FQN);
											S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = \'" + FQN + "\' and MachineName = \'" + MachineID + "\'";
											bool B = ExecuteSqlNewConn(S);
											
											goto NextFile;
										}
									}
									
									file_FullName = UTIL.RemoveSingleQuotes(file_FullName);
									file_SourceName = UTIL.RemoveSingleQuotes(file_SourceName);
									
									
									try
									{
										//FrmMDIMain.SB4.Text = file_SourceName
									}
									catch (Exception)
									{
										
									}
									
									
									string file_DirName = fileDetail.Directory.ToString();
									string file_SourceTypeCode = fileDetail.Extension;
									
									if (file_SourceTypeCode.Trim.Length == 0)
									{
										file_SourceTypeCode = ".UKN";
									}
									
									string CrcHash = ENC.getSha1HashFromFile(file_FullName);
									
									//** If version files is NO and already in REPO, skip it right here
									if (FOLDER_VersionFiles.ToUpper().Equals("N"))
									{
										bool bFileAlreadyExist = ckDocumentExists(file_SourceName, MachineID, CrcHash);
										if (bFileAlreadyExist == true)
										{
											LOG.WriteToListenLog((string) ("ArchiveSingleFile :If version files is NO and already in REPO, skip it right here: " + file_FullName));
											FQN = UTIL.RemoveSingleQuotes(FQN);
											S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = \'" + FQN + "\' and MachineName = \'" + MachineID + "\'";
											bool B = ExecuteSqlNewConn(S);
											
											goto NextFile;
										}
									}
									
									if (file_SourceTypeCode.Equals(".msg"))
									{
										LOG.WriteToListenLog("NOTICE: Content Archive File : " + file_FullName + " was found to be a message file, moved file.");
										string DisplayMsg = "A message file was encounted in a backup directory." + "\r\n";
										DisplayMsg = DisplayMsg + "It has been moved to the EMAIL Working directory." + "\r\n";
										DisplayMsg = DisplayMsg + "To archive a MSG file, it should be imported into outlook." + "\r\n";
										DisplayMsg = DisplayMsg + "This file has ALSO been added to the CONTENT repository." + "\r\n";
										
										if (modGlobals.gRunUnattended == false)
										{
											frmHelp.Default.MsgToDisplay = DisplayMsg;
											frmHelp.Default.CallingScreenName = "ECM Archive";
											frmHelp.Default.CaptionName = "MSG File Encounted in Content Archive";
											frmHelp.Default.Timer1.Interval = 10000;
											frmHelp.Default.Show();
										}
										
										if (modGlobals.gRunUnattended == true)
										{
											LOG.WriteToListenLog((string) ("WARNING: ArchiveContent 100: " + "\r\n" + DisplayMsg));
										}
										
										string EmailWorkingDirectory = getWorkingDirectory(modGlobals.gCurrUserGuidID, "EMAIL WORKING DIRECTORY");
										
										EmailWorkingDirectory = UTIL.RemoveSingleQuotes(EmailWorkingDirectory);
										file_SourceName = UTIL.RemoveSingleQuotes(file_SourceName);
										EmailFQN = EmailWorkingDirectory + "\\" + file_SourceName.Trim();
										
										file_FullName = UTIL.RemoveSingleQuotes(file_FullName);
										if (File.Exists(EmailFQN))
										{
											string tMsg = (string) ("Email Encountered, already in EMAIL WORKING DIRECTORY: " + EmailFQN);
											LOG.WriteToListenLog(tMsg);
											xTrace(965, "ArchiveContent", tMsg);
											//FilesSkipped += 1
										}
										else
										{
											File.Copy(file_FullName, EmailFQN);
											string tMsg = (string) ("Email File Encountered, moved to EMAIL WORKING DIRECTORY and entered into repository: " + EmailFQN);
											xTrace(966, "ArchiveContent", tMsg);
											//FilesSkipped += 1
										}
										GC.Collect();
									}
									
									string file_LastAccessDate = fileDetail.LastAccessTime;
									string file_CreateDate = fileDetail.CreationTime;
									string file_LastWriteTime = fileDetail.LastWriteTime;
									string OriginalFileType = file_SourceTypeCode;
									
									fileDetail = null;
									
									if (file_SourceTypeCode.ToLower().Equals(".exe"))
									{
										Debug.Print(file_FullName);
									}
									
									bool isZipFile = ZF.isZipFile(file_FullName);
									if (isZipFile == true)
									{
										string ExistingParentZipGuid = GetGuidByFqn(file_FullName, "0");
										int StackLevel = 0;
										Dictionary<string, int> ListOfFiles = new Dictionary<string, int>();
										if (ExistingParentZipGuid.Length > 0)
										{
											DBLocal.addZipFile(file_FullName, ExistingParentZipGuid, false);
											ZF.UploadZipFile(modGlobals.gCurrUserGuidID, modGlobals.gMachineID, file_FullName, ExistingParentZipGuid, true, false, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
										}
										else
										{
											DBLocal.addZipFile(file_FullName, SourceGuid, false);
											ZF.UploadZipFile(modGlobals.gCurrUserGuidID, modGlobals.gMachineID, file_FullName, SourceGuid, true, false, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
										}
										ListOfFiles = null;
										GC.Collect();
									}
									
									Application.DoEvents();
									
									if (! isZipFile)
									{
										bool bExt = DMA.isExtExcluded(file_SourceTypeCode, ExcludedTypes);
										if (bExt)
										{
											FilesSkipped++;
											LOG.WriteToListenLog((string) ("ArchiveSingleFile : file excluded: " + file_FullName));
											FQN = UTIL.RemoveSingleQuotes(FQN);
											S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = \'" + FQN + "\' and MachineName = \'" + MachineID + "\'";
											bool B = ExecuteSqlNewConn(S);
											
											goto NextFile;
										}
										//** See if the STAR is in the INCLUDE list, if so, all files are included
										bExt = DMA.isExtIncluded(file_SourceTypeCode, ExcludedTypes);
										if (bExt)
										{
											FilesSkipped++;
											LOG.WriteToListenLog((string) ("ArchiveSingleFile : file excluded #2: " + file_FullName));
											FQN = UTIL.RemoveSingleQuotes(FQN);
											S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = \'" + FQN + "\' and MachineName = \'" + MachineID + "\'";
											bool B = ExecuteSqlNewConn(S);
											
											goto NextFile;
										}
									}
									
									int bcnt = iGetRowCount("SourceType", "where SourceTypeCode = \'" + file_SourceTypeCode + "\'");
									string SubstituteFileType = getProcessFileAsExt(file_SourceTypeCode);
									
									if (bcnt == 0 && SubstituteFileType == null)
									{
										
										if (SubstituteFileType == null)
										{
											string MSG = "The file type \'" + file_SourceTypeCode + "\' is undefined." + "\r\n" + "DO YOU WISH TO AUTOMATICALLY DEFINE IT?" + "\r\n" + "This will allow content to be archived, but not searched.";
											//Dim dlgRes As DialogResult = MessageBox.Show(MSG, "Filetype Undefined", MessageBoxButtons.YesNo)
											
											if (dDebug)
											{
												LOG.WriteToListenLog(MSG);
											}
											
											UNASGND.setApplied("0");
											UNASGND.setFiletype(ref file_SourceTypeCode);
											int xCnt = UNASGND.cnt_PK_AFTU(file_SourceTypeCode);
											if (xCnt == 0)
											{
												UNASGND.Insert();
											}
											
											clsSOURCETYPE ST = new clsSOURCETYPE();
											ST.setSourcetypecode(ref file_SourceTypeCode);
											ST.setSourcetypedesc("NO SEARCH - AUTO ADDED by Pgm");
											ST.setIndexable("0");
											ST.setStoreexternal(0);
											ST.Insert();
											
										}
										else
										{
											file_SourceTypeCode = SubstituteFileType;
										}
									}
									else if (SubstituteFileType.Trim.Length > 0)
									{
										file_SourceTypeCode = SubstituteFileType;
									}
									
									EmailFQN = UTIL.RemoveSingleQuotes(EmailFQN);
									file_FullName = UTIL.RemoveSingleQuotes(file_FullName);
									
									string StoredExternally = "N";
									
									icnt = 0;
									
									//'If bSingleInstanceContent = True And Not FOLDER_VersionFiles .Equals("Y") Then
									//If bSingleInstanceContent = True Then
									//    CRC  = DMA.CalcCRC(file_FullName)
									//    Dim VersionNbr = 0
									//    Dim tSourceGuid  = getSSCountDataSourceFiles(file_SourceName, CRC )
									//    If tSourceGuid .Length = 0 Then
									//        '** It is new - just fall thru and let 'er rip
									//        LOG.WriteToListenLog("ArchiveSingleFile :  It is new - just fall thru: " + file_FullName )
									//        bAddThisFileAsNewVersion = True
									//        GetMaxDataSourceVersionNbr(file_SourceName, CRC , file_Length )
									//        NextVersionNbr = LastVerNbr + 1
									//        AddMachineSource(file_FullName, SourceGuid)
									
									//        saveContentOwner(SourceGuid , gCurrUserGuidID, "C", FOLDER_FQN, gMachineID, gNetworkID)
									
									//        GoTo InsertNewVersion
									//    Else
									//        '** It already exist somewhere
									//        LOG.WriteToListenLog("ArchiveSingleFile : It already exist somewhere: " + file_FullName )
									//        bAddThisFileAsNewVersion = False
									
									//        AddMachineSource(file_FullName, tSourceGuid )
									//        saveContentOwner(SourceGuid , gCurrUserGuidID, "C", FOLDER_FQN, gMachineID, gNetworkID)
									//        FQN = UTIL.RemoveSingleQuotes(FQN)
									//        S  = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = '" + FQN + "' and MachineName = '" + MachineID + "'"
									//        Dim B As Boolean = ExecuteSqlNewConn(S)
									
									//        GoTo NextFile
									//    End If
									//Else
									//    icnt = DOCS.cnt_PI_FQN_USERID(gCurrUserGuidID, file_FullName)
									//End If
									
									Application.DoEvents();
									
									//***********************************************************************'
									//** New file
									//***********************************************************************'
									bool BB = false;
									
									if (icnt == 0)
									{
										
										string AttachmentCode = "C";
										
										LOG.WriteToListenLog("File : " + file_FullName + " was found to be NEW and not in the repository.");
										//Me.SB.Text = "Loading: " + file_SourceName
										Application.DoEvents();
										LastVerNbr = 0;
										
										icnt = getCountDataSourceFiles(file_SourceName, CrcHash);
										if (icnt > 0)
										{
											LOG.WriteToListenLog("Warning File : " + file_FullName + " was found to be NEW and WAS ACTUALLY in the repository, skipped it.");
											FilesSkipped++;
											FQN = UTIL.RemoveSingleQuotes(FQN);
											S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = \'" + FQN + "\' and MachineName = \'" + MachineID + "\'";
											bool B = ExecuteSqlNewConn(S);
											
											goto NextFile;
										}
										
										if (icnt == 0)
										{
											
											//file_FullName = UTIL.RemoveSingleQuotes(file_FullName)
											//file_SourceName = UTIL.RemoveSingleQuotes(file_SourceName)
											
											DOCS.setSourceguid(ref SourceGuid);
											DOCS.setFqn(ref file_FullName);
											DOCS.setSourcename(ref file_SourceName);
											DOCS.setSourcetypecode(ref file_SourceTypeCode);
											DOCS.setLastaccessdate(ref file_LastAccessDate);
											DOCS.setCreatedate(ref file_CreateDate);
											DOCS.setCreationdate(ref file_CreateDate);
											DOCS.setLastwritetime(ref file_LastWriteTime);
											DOCS.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
											DOCS.setVersionnbr("0");
											BB = DOCS.Insert(CrcHash);
											
											if (BB)
											{
												LOG.WriteToListenLog((string) ("ArchiveSingleFile : FILE added to repo 100: " + file_FullName));
												Successful = true;
												saveContentOwner(SourceGuid, modGlobals.gCurrUserGuidID, "C", FOLDER_FQN, MachineID, modGlobals.gNetworkID);
												
												//Dim WC  = DOCS.wc_UKI_Documents(SourceGuid)
												//DOCS.ImageUpdt_SourceImage(WC, file_FullName)
												//****************************************************************************************************************************
												BB = UpdateSourceImage(file_FullName, UID, MachineID, SourceGuid, file_LastAccessDate, file_CreateDate, file_LastWriteTime, LastVerNbr, file_FullName, RetentionCode, isPublic, CrcHash);
												//****************************************************************************************************************************
												
												if (! BB)
												{
													string MySql = "Delete from DataSource where SourceGuid = \'" + SourceGuid + "\'";
													ExecuteSqlNewConn(MySql);
													LOG.WriteToErrorLog("Unrecoverable Error - removed file \'" + file_FullName + "\' from the repository.");
													
													string DisplayMsg = "A source file failed to load. Review ERROR log.";
													frmHelp.Default.MsgToDisplay = DisplayMsg;
													frmHelp.Default.CallingScreenName = "ECM Archive";
													frmHelp.Default.CaptionName = "Fatal Load Error";
													frmHelp.Default.Timer1.Interval = 10000;
													frmHelp.Default.Show();
													
												}
											}
											else
											{
												LOG.WriteToListenLog((string) ("Error 22.345.23a - Failed to add source:" + file_FullName));
												Successful = false;
											}
											
											file_FullName = UTIL.RemoveSingleQuotes(file_FullName);
											file_SourceName = UTIL.RemoveSingleQuotes(file_SourceName);
										}
										
										if (BB)
										{
											FilesBackedUp++;
											
											file_FullName = UTIL.RemoveSingleQuotes(file_FullName);
											file_SourceName = UTIL.RemoveSingleQuotes(file_SourceName);
											
											UpdateDocCrc(SourceGuid, CrcHash);
											
											bool bIsImageFile = isImageFile(file_FullName);
											
											UpdateCurrArchiveStats(file_FullName, file_SourceTypeCode);
											
										}
										else
										{
											FilesSkipped++;
											if (dDebug)
											{
												LOG.WriteToListenLog("ERROR File : " + file_FullName + " was found to be NEW and was NOT ADDED to the repository.");
											}
											if (dDebug)
											{
												LOG.WriteToListenLog("ERROR File : " + file_FullName + " was found to be NEW and was NOT ADDED to the repository.");
											}
											Debug.Print((string) ("FAILED TO LOAD: " + file_FullName));
											if (dDebug)
											{
												LOG.WriteToListenLog((string) ("ArchiveSingleFile : InsertSourcefile :FAILED TO LOAD: 8013a: " + file_SourceName));
											}
										}
										
										if (BB)
										{
											Successful = true;
											Application.DoEvents();
											UpdateDocFqn(SourceGuid, file_FullName);
											UpdateDocSize(SourceGuid, file_Length);
											UpdateDocDir(SourceGuid, file_FullName);
											UpdateDocOriginalFileType(SourceGuid, OriginalFileType);
											UpdateZipFileIndicator(SourceGuid, isZipFile);
											Application.DoEvents();
											if (dDebug)
											{
												LOG.WriteToListenLog("ArchiveSingleFile : InsertSourcefile :Success: 8015");
											}
											if (! isZipFile)
											{
												//Dim TheFileIsArchived As Boolean = True
												//DMA.setFileArchiveAttributeSet(file_FullName , TheFileIsArchived)
												DMA.setArchiveBitOff(file_FullName);
											}
											
											//delFileParms(SourceGuid )
											
											UpdateDocCrc(SourceGuid, CrcHash);
											
											//** Removed Attribution Classification by WDM 9/10/2009
											UpdateSrcAttrib(SourceGuid, "CRC", CrcHash, OriginalFileType);
											UpdateSrcAttrib(SourceGuid, "FILENAME", file_SourceName, OriginalFileType);
											UpdateSrcAttrib(SourceGuid, "CreateDate", file_CreateDate, OriginalFileType);
											UpdateSrcAttrib(SourceGuid, "FILESIZE", file_Length, OriginalFileType);
											UpdateSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessDate, OriginalFileType);
											UpdateSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, OriginalFileType);
											
											//AddMachineSource(file_FullName, SourceGuid)
											
											if (val[file_Length] > 1000000000)
											{
												try
												{
													//FrmMDIMain.SB4.Text = "Extreme File: " + file_Length  + " bytes - standby"
												}
												catch (Exception)
												{
													
												}
											}
											else if (val[file_Length] > 2000000)
											{
												try
												{
													//FrmMDIMain.SB4.Text = "Large File: " + file_Length  + " bytes"
												}
												catch (Exception)
												{
												}
											}
											if (file_SourceTypeCode.ToLower().Equals(".mp3") || file_SourceTypeCode.ToLower().Equals(".wma") || file_SourceTypeCode.ToLower().Equals("wma"))
											{
												MP3.getRecordingMetaData(file_FullName, SourceGuid, file_SourceTypeCode);
												Application.DoEvents();
											}
											else if (file_SourceTypeCode.ToLower().Equals(".tiff") || file_SourceTypeCode.ToLower().Equals(".jpg"))
											{
												//** This functionality will be added at a later time
												//KAT.getXMPdata(file_FullName)
												Application.DoEvents();
											}
											else if (file_SourceTypeCode.ToLower().Equals(".png") || file_SourceTypeCode.ToLower().Equals(".gif"))
											{
												//** This functionality will be added at a later time
												//KAT.getXMPdata(file_FullName)
												Application.DoEvents();
												//ElseIf LCase(file_SourceTypeCode).Equals(".wav") Then
												//    MP3.getRecordingMetaData(file_FullName, SourceGuid, file_SourceTypeCode)
											}
											else if (file_SourceTypeCode.ToLower().Equals(".wma"))
											{
												MP3.getRecordingMetaData(file_FullName, SourceGuid, file_SourceTypeCode);
											}
											else if (file_SourceTypeCode.ToLower().Equals(".tif"))
											{
												//** This functionality will be added at a later time
												//KAT.getXMPdata(file_FullName)
												Application.DoEvents();
											}
											Application.DoEvents();
											if ((file_SourceTypeCode.ToLower().Equals(".doc") || file_SourceTypeCode.ToLower().Equals(".docx")) && ckMetaData.Equals("Y"))
											{
												GetWordDocMetadata(file_FullName, SourceGuid, OriginalFileType);
												GC.Collect();
											}
											if ((file_SourceTypeCode.Equals(".xls") || file_SourceTypeCode.Equals(".xlsx") || file_SourceTypeCode.Equals(".xlsm")) && ckMetaData.Equals("Y"))
											{
												GetExcelMetaData(file_FullName, SourceGuid, OriginalFileType);
												GC.Collect();
											}
										}
									}
									else
									{
										//                        '***********************************************************************'
										//                        '** File Exists, has it changed
										//                        '***********************************************************************'
										//                        Successful = True
										//                        If dDebug Then LOG.WriteToListenLog("File : " + file_FullName  + " found to already EXIST in the repository.")
										//                        If dDebug Then LOG.WriteToListenLog("ArchiveSingleFile : InsertSourcefile :Success: 8020")
										//                        If UCase(FOLDER_VersionFiles ).Equals("Y") Then
										//                            If dDebug Then LOG.WriteToListenLog("File : " + file_FullName  + " Versioned.")
										//                            If dDebug Then LOG.WriteToListenLog("ArchiveSingleFile : InsertSourcefile :Success: 8021")
										//                            '** Get the last version number of this file in the repository,
										
										//                            LastVerNbr = GetMaxDataSourceVersionNbr(gCurrUserGuidID, file_FullName )
										//                            NextVersionNbr = LastVerNbr + 1
										//                            '** See if this version has been changed
										//                            Dim AttachmentCode As String = "C"
										//                            Dim CrcHash As String = ENC.getSha1HashFromFile(FQN)
										
										//                            bChanged = isSourcefileOlderThanLastEntry(file_SourceName, CrcHash)
										//                            '** If it has, add it to the repository
										//                            If bChanged Then
										//                                LOG.WriteToListenLog("File : " + file_FullName  + " is Versioned and has Changed.")
										//                                If dDebug Then LOG.WriteToListenLog("ArchiveSingleFile : InsertSourcefile :Success: 8022")
										//InsertNewVersion:
										//                                Successful = False
										
										//                                BB = InsertSourcefile(UID, MachineID, gNetworkID, SourceGuid, file_FullName, file_SourceName, file_SourceTypeCode, file_LastAccessDate , file_CreateDate , file_LastWriteTime , gCurrUserGuidID, NextVersionNbr, RetentionCode, isPublic, CrcHash, FOLDER_FQN)
										
										//                                If BB Then
										//                                    Successful = True
										//                                    saveContentOwner(SourceGuid , gCurrUserGuidID, "C", FOLDER_FQN, gMachineID, gNetworkID)
										
										//                                    'Dim VersionNbr As String = "0"
										//                                    'Dim CRC As String = DMA.CalcCRC(file_FullName)
										//                                    'addContentHashKey(SourceGuid, NextVersionNbr, file_CreateDate , file_FullName, OriginalFileType, file_Length , CRC, MachineID)
										
										//                                    If LibraryList.Count > 0 Then
										//                                        For II As Integer = 0 To LibraryList.Count - 1
										//                                            Dim LibraryName  = LibraryList(II)
										//                                            AddLibraryItem(SourceGuid, file_SourceName, file_SourceTypeCode, LibraryName )
										//                                        Next
										//                                    End If
										
										//                                    FilesBackedUp += 1
										//                                    LOG.WriteToListenLog("File : " + file_FullName  + " Change applied.")
										//                                    If dDebug Then LOG.WriteToListenLog("ArchiveSingleFile : InsertSourcefile :Success: 8023")
										
										//                                    If CRC .Length = 0 Then
										//                                        CRC  = DMA.CalcCRC(file_FullName)
										//                                    End If
										//                                    UpdateDocCrc(SourceGuid , CRC )
										
										//                                    UpdateCurrArchiveStats(file_FullName, file_SourceTypeCode)
										
										//                                Else
										//                                    '** There was an issue, remove this file.
										//                                    LOG.WriteToListenLog("ERROR 943.2188 in file '" + file_FullName  + "', did not save binary to Repository, removing from repository.")
										//                                    LOG.WriteToListenLog("ERROR 943.2188 in file '" + file_FullName  + "', did not save binary to Repository, removing from repository.")
										//                                    Dim ErrSql  = "Delete from DataSource "
										//                                    Successful = False
										//                                    FQN = UTIL.RemoveSingleQuotes(FQN)
										//                                    S  = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = '" + FQN + "' and MachineName = '" + MachineID + "'"
										//                                    Dim B As Boolean = ExecuteSqlNewConn(S)
										
										//                                    GoTo NextFile
										//                                End If
										
										//                                setRetentionDate(SourceGuid , RetentionCode , file_SourceTypeCode)
										//                                UpdateDocFqn(SourceGuid, file_FullName)
										//                                UpdateDocSize(SourceGuid, file_Length )
										//                                UpdateDocDir(SourceGuid, file_FullName)
										//                                UpdateDocOriginalFileType(SourceGuid, OriginalFileType )
										//                                UpdateZipFileIndicator(SourceGuid, isZipFile)
										
										//                                If Not isZipFile Then
										//                                    If dDebug Then LOG.WriteToListenLog("ArchiveSingleFile : InsertSourcefile :Success: 8025")
										//                                    'DMA.ToggleArchiveBit(file_FullName )
										//                                    DMA.setArchiveBitOff(file_FullName )
										//                                End If
										
										//                                'delFileParms(SourceGuid )
										
										//                                If CRC .Length = 0 Then
										//                                    CRC  = DMA.CalcCRC(file_FullName)
										//                                End If
										//                                UpdateDocCrc(SourceGuid , CRC )
										
										//                                UpdateSrcAttrib(SourceGuid , "CRC", CRC , OriginalFileType )
										//                                UpdateSrcAttrib(SourceGuid , "FILENAME", file_SourceName, OriginalFileType )
										//                                UpdateSrcAttrib(SourceGuid , "CreateDate", file_CreateDate , OriginalFileType )
										//                                UpdateSrcAttrib(SourceGuid , "FILESIZE", file_Length , OriginalFileType )
										//                                UpdateSrcAttrib(SourceGuid , "ChangeDate", file_LastAccessDate, OriginalFileType )
										//                                UpdateSrcAttrib(SourceGuid , "WriteDate", file_LastWriteTime , OriginalFileType )
										
										//                                AddMachineSource(file_FullName, SourceGuid )
										
										//                                If dDebug Then LOG.WriteToListenLog("ArchiveSingleFile : InsertSourcefile :Success: 8026")
										//                                If (LCase(file_SourceTypeCode).Equals(".mp3") Or LCase(file_SourceTypeCode).Equals(".wma") Or LCase(file_SourceTypeCode).Equals("wma")) Then
										//                                    MP3.getRecordingMetaData(file_FullName, SourceGuid, file_SourceTypeCode)
										//                                End If
										//                                If (LCase(file_SourceTypeCode).Equals(".tiff") Or LCase(file_SourceTypeCode).Equals(".jpg")) Then
										//                                    '** This functionality will be added at a later time
										//                                    'KAT.getXMPdata(file_FullName)
										//                                End If
										//                                If (LCase(file_SourceTypeCode).Equals(".png") Or LCase(file_SourceTypeCode).Equals(".gif")) Then
										//                                    '** This functionality will be added at a later time
										//                                    'KAT.getXMPdata(file_FullName)
										//                                End If
										
										//                                If (LCase(file_SourceTypeCode).Equals(".doc") Or LCase(file_SourceTypeCode).Equals(".docx")) And ckMetaData .Equals("Y") Then
										//                                    GetWordDocMetadata(file_FullName, SourceGuid , OriginalFileType )
										//                                End If
										//                                If (file_SourceTypeCode.Equals(".xls") _
										//                                            Or file_SourceTypeCode.Equals(".xlsx") Or file_SourceTypeCode.Equals(".xlsm")) And ckMetaData .Equals("Y") Then
										//                                    Me.GetExcelMetaData(file_FullName, SourceGuid , OriginalFileType )
										//                                End If
										//                                If dDebug Then LOG.WriteToListenLog("ArchiveSingleFile : InsertSourcefile :Success: 8027")
										//                            End If
										//                        Else
										//                            '** The document has changed, but versioning is not on...
										//                            '** Delete and re-add.
										//                            '** If zero add
										//                            '** if 1, see if changed and if so, update, if not skip it
										//                            LastVerNbr = GetMaxVersionNbr(file_FullName )
										
										//                            Dim AttachmentCode As String = "C"
										//                            Dim CrcHash As String = ENC.getSha1HashFromFile(FQN)
										
										//                            bChanged = isSourcefileOlderThanLastEntry(file_SourceName, CrcHash)
										//                            '** If it has, add it to the repository
										//                            If bChanged Then
										//                                LOG.WriteToListenLog("ArchiveSingleFile : FILE exists but changed - 100: " + file_FullName)
										//                                '**************************************************
										//                                '********* Set the SourceGuid to the pre-existing
										//                                SourceGuid = GetGuidByFqn(file_FullName , LastVerNbr.ToString)
										//                                '**************************************************
										
										//                                If CRC .Length = 0 Then
										//                                    CRC  = DMA.CalcCRC(file_FullName)
										//                                End If
										//                                UpdateDocCrc(SourceGuid , CRC )
										
										//                                FilesBackedUp += 1
										//                                BB = False
										//                                '****************************************************************************************************************************
										//                                BB = UpdateSourceImage(OriginalFileName, UID, MachineID, SourceGuid, file_LastAccessDate , file_CreateDate , file_LastWriteTime , LastVerNbr, file_FullName, RetentionCode, isPublic, CrcHash)
										//                                '****************************************************************************************************************************
										//                                If BB Then
										
										//                                    If LibraryList.Count > 0 Then
										//                                        For II As Integer = 0 To LibraryList.Count - 1
										//                                            Dim LibraryName  = LibraryList(II)
										//                                            AddLibraryItem(SourceGuid, file_SourceName, file_SourceTypeCode, LibraryName )
										//                                        Next
										//                                    End If
										
										//                                    LOG.WriteToListenLog("ArchiveSingleFile : update successful 100: " + file_FullName)
										//                                    UpdateCurrArchiveStats(file_FullName, file_SourceTypeCode )
										//                                    saveContentOwner(SourceGuid , gCurrUserGuidID, "C", FOLDER_FQN, gMachineID, gNetworkID)
										//                                    Successful = True
										//                                Else
										//                                    Dim MySql  = "Delete from DataSource where SourceGuid = '" + SourceGuid + "'"
										//                                    ExecuteSqlNewConn(MySql)
										//                                    LOG.WriteToErrorLog("Unrecoverable Error - removed file '" + file_FullName + "' from the repository.")
										
										//                                    Dim DisplayMsg  = "A source file failed to load. Review ERROR log."
										//                                    frmHelp.MsgToDisplay  = DisplayMsg
										//                                    frmHelp.CallingScreenName  = "ECM Archive"
										//                                    frmHelp.CaptionName  = "Fatal Load Error"
										//                                    frmHelp.Timer1.Interval = 10000
										//                                    frmHelp.Show()
										//                                    Successful = False
										//                                End If
										
										//                                UpdateDocFqn(SourceGuid, file_FullName)
										//                                UpdateDocSize(SourceGuid, file_Length )
										//                                UpdateDocOriginalFileType(SourceGuid, OriginalFileType )
										//                                UpdateZipFileIndicator(SourceGuid, isZipFile)
										//                                UpdateDocDir(SourceGuid, file_FullName)
										
										//                                'delFileParms(SourceGuid )
										//                                If CRC .Length = 0 Then
										//                                    CRC  = DMA.CalcCRC(file_FullName)
										//                                End If
										//                                UpdateDocCrc(SourceGuid , CRC )
										
										//                                UpdateSrcAttrib(SourceGuid , "CRC", CRC , OriginalFileType )
										//                                UpdateSrcAttrib(SourceGuid , "FILENAME", file_SourceName, OriginalFileType )
										//                                UpdateSrcAttrib(SourceGuid , "CreateDate", file_CreateDate , OriginalFileType )
										//                                UpdateSrcAttrib(SourceGuid , "FILESIZE", file_Length , OriginalFileType )
										//                                UpdateSrcAttrib(SourceGuid , "ChangeDate", file_LastAccessDate, OriginalFileType )
										//                                UpdateSrcAttrib(SourceGuid , "WriteDate", file_LastWriteTime , OriginalFileType )
										
										//                                AddMachineSource(file_FullName, SourceGuid )
										
										//                                If Not isZipFile Then
										//                                    'Dim TheFileIsArchived As Boolean = True
										//                                    'DMA.setFileArchiveAttributeSet(file_FullName , TheFileIsArchived)
										//                                    DMA.ToggleArchiveBit(file_FullName )
										//                                End If
										
										//                                If (LCase(file_SourceTypeCode).Equals(".doc") Or LCase(file_SourceTypeCode).Equals(".docx")) And ckMetaData .Equals("Y") Then
										//                                    GetWordDocMetadata(file_FullName, SourceGuid , OriginalFileType )
										//                                End If
										//                                If (file_SourceTypeCode.Equals(".xls") _
										//                                            Or file_SourceTypeCode.Equals(".xlsx") Or file_SourceTypeCode.Equals(".xlsm")) And ckMetaData .Equals("Y") Then
										//                                    Me.GetExcelMetaData(file_FullName, SourceGuid , OriginalFileType )
										//                                End If
										//                                If dDebug Then LOG.WriteToListenLog("ArchiveSingleFile : InsertSourcefile :Success: 8030")
										
										//                            Else
										//                                'delFileParms(SourceGuid )
										//                                FilesSkipped += 1
										//                                Successful = True
										//                                Dim ReinitMetadata As Boolean = False
										
										//                                If ReinitMetadata = True Then
										
										//                                    If CRC .Length = 0 Then
										//                                        CRC  = DMA.CalcCRC(file_FullName)
										//                                    End If
										
										//                                    UpdateDocCrc(SourceGuid , CRC )
										//                                    UpdateSrcAttrib(SourceGuid , "CRC", CRC , OriginalFileType )
										//                                    UpdateSrcAttrib(SourceGuid , "FILENAME", file_SourceName, OriginalFileType )
										//                                    UpdateSrcAttrib(SourceGuid , "CreateDate", file_CreateDate , OriginalFileType )
										//                                    UpdateSrcAttrib(SourceGuid , "FILESIZE", file_Length , OriginalFileType )
										//                                    UpdateSrcAttrib(SourceGuid , "ChangeDate", file_LastAccessDate, OriginalFileType )
										//                                    UpdateSrcAttrib(SourceGuid , "WriteDate", file_LastWriteTime , OriginalFileType )
										//                                    AddMachineSource(file_FullName, SourceGuid )
										
										//                                    GC.Collect()
										//                                End If
										//                            End If
										//                        End If
									}
NextFile:
									if (Successful == true)
									{
										FQN = UTIL.RemoveSingleQuotes(FQN);
										DirName = UTIL.RemoveSingleQuotes(DirName);
										string tFqn = DirName + "\\" + FQN;
										tFqn = UTIL.RemoveSingleQuotes(tFqn);
										S = ""; //" update DirectoryListenerFiles set Archived =  1 where DirGuid = '" + DirGuid + "' and MachineID = '" + MachineID + "' and sourceFile = '" + FQN + "' "
										//S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = '" + FQN + "' and MachineID = '" + MachineID + "'"
										DBLocal.MarkListenersProcessed(FQN);
										//Dim B As Boolean = ExecuteSqlNewConn(S)
										//If Not B Then
										//    LOG.WriteToListenLog("ERROR: ArchiveSingleFile: failed to archive: " + DirName + " \ " + FQN)
										//End If
									}
									Application.DoEvents();
									
									file_FullName = UTIL.RemoveSingleQuotes(file_FullName);
									file_SourceName = UTIL.RemoveSingleQuotes(file_SourceName);
									
									if (modGlobals.gTerminateImmediately)
									{
										DOCS = null;
										PROC = null;
										return;
									}
									
									if (ckSkipIfArchived == true && file_SourceName != null)
									{
										DMA.setArchiveBitOff(file_FullName);
									}
									
									if (Successful == true)
									{
										LOG.WriteToListenLog((string) ("SUCCCESS: ArchiveSingleFile: 01 " + DirName + " \\ " + FQN));
										FQN = UTIL.RemoveSingleQuotes(FQN);
										DirName = UTIL.RemoveSingleQuotes(DirName);
										string tFqn = DirName + "\\" + FQN;
										tFqn = UTIL.RemoveSingleQuotes(tFqn);
										S = ""; // " update DirectoryListenerFiles set Archived =  1 where DirGuid = '" + DirGuid + "' and MachineID = '" + MachineID + "' and sourceFile = '" + FQN + "' "
										S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = \'" + FQN + "\' and MachineName = \'" + MachineID + "\'";
										bool B = ExecuteSqlNewConn(S);
										if (! B)
										{
											LOG.WriteToListenLog((string) ("ERROR: ArchiveSingleFile: failed to archive: " + DirName + " \\ " + FQN));
										}
									}
									
								}
							}
							else
							{
								if (dDebug)
								{
									Debug.Print((string) ("Duplicate Folder: " + FolderName));
								}
								if (dDebug)
								{
									LOG.WriteToListenLog("ArchiveSingleFile : InsertSourcefile :Success: 8034");
								}
							}
NextFolder:
							pFolder = FolderName;
							if (modGlobals.gTerminateImmediately)
							{
								DOCS = null;
								PROC = null;
								return;
							}
							if (Successful == true)
							{
								LOG.WriteToListenLog((string) ("SUCCCESS: ArchiveSingleFile: 02 " + DirName + " \\ " + FQN));
								FQN = UTIL.RemoveSingleQuotes(FQN);
								DirName = UTIL.RemoveSingleQuotes(DirName);
								string tFqn = DirName + "\\" + FQN;
								tFqn = UTIL.RemoveSingleQuotes(tFqn);
								S = ""; // " update DirectoryListenerFiles set Archived =  1 where DirGuid = '" + DirGuid + "' and MachineID = '" + MachineID + "' and sourceFile = '" + FQN + "' "
								S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = \'" + FQN + "\' and MachineName = \'" + MachineID + "\'";
								bool B = ExecuteSqlNewConn(S);
								if (! B)
								{
									LOG.WriteToListenLog((string) ("ERROR: ArchiveSingleFile: failed to archive: " + DirName + " \\ " + FQN));
								}
							}
						}
						
						PROC.getProcessesToKill();
						PROC.KillOrphanProcesses();
						
						DOCS = null;
						PROC = null;
SKIPOUT:
						//If Successful = True Then
						//    Dim S  = " update DirectoryListenerFiles set Archived =  1 where DirGuid = '" + DirGuid + "' and MachineID = '" + MachineID + "' and sourceFile = '" + FQN + "' "
						//    Dim B As Boolean = ExecuteSqlNewConn(S)
						//    If Not B Then
						//        LOG.WriteToListenLog("ERROR: ArchiveSingleFile: failed to archive: " + DirName + " \ " + FQN)
						//    End If
						//End If
						frmNotify.Default.lblPdgPages.Text = "*";
					}
					
					public bool isDirInLibrary(string DirFQN, ref string ParentDirLibName)
					{
						string TgtLib = "";
						string TempDir = "";
						string SS = "";
						if (DirFQN.Trim().Length > 2)
						{
							if (DirFQN.Substring(0, 2) == "\\\\")
							{
								SS = "\\\\";
							}
							else
							{
								SS = "";
							}
						}
						
						List<string> DirList = new List<string>();
						string[] A = DirFQN.Split("\\".ToCharArray());
						
						for (int I = 0; I <= (A.Length - 1); I++)
						{
							TempDir = SS + TempDir + A[I];
							DirList.Add(TempDir);
							TempDir = TempDir + "\\";
						}
						
						for (int II = DirList.Count - 1; II >= 0; II--)
						{
							
							TempDir = DirList(II);
							TempDir = UTIL.RemoveSingleQuotes(TempDir);
							
							//Dim iCnt As Integer = iCount("Select COUNT(*) from LibDirectory where DirectoryName = '" + TempDir + "' and UserID = '" + gCurrUserGuidID + "'")
							string S = "Select COUNT(*) from LibDirectory where DirectoryName = \'" + TempDir + "\'";
							int iCnt = iCount(S);
							if (iCnt > 0)
							{
								ParentDirLibName = TempDir;
								return true;
							}
							TempDir = TempDir + "\\";
						}
						
						ParentDirLibName = "";
						return false;
						
					}
					
					
					public bool ExtractWinmail(string FQN, ref List<string> AttachedFiles)
					{
						try
						{
							int iCnt = 0;
							
							string AppPath = System.AppDomain.CurrentDomain.BaseDirectory;
							string WinMail = AppPath + "WINMAIL";
							string ConversionDir = LOG.getEnvVarSpecialFolderLocalApplicationData() + "\\WMCONVERT";
							Directory D;
							if (! D.Exists(ConversionDir))
							{
								D.CreateDirectory(ConversionDir);
							}
							D = null;
							
							File F;
							if (! F.Exists(FQN))
							{
								F = null;
								return false;
							}
							F = null;
							
							Process P = new Process();
							P.Start(WinMail + "\\wmopener.exe", (string) ('\u0022' + FQN + '\u0022' + " " + '\u0022' + ConversionDir + '\u0022'));
							P.WaitForExit();
							
							//ShellandWait(WinMail, ConversionDir)
							
							getDirFiles(ConversionDir, AttachedFiles);
							
							if (AttachedFiles.Count > 0)
							{
								return true;
							}
							else
							{
								return false;
							}
						}
						catch (Exception ex)
						{
							LOG.WriteToArchiveLog((string) ("ERROR: ExtractWinmail - " + ex.Message));
						}
						
						
					}
					
					public void ShellandWait(string WinMail, string ConversionDir)
					{
						
						string Executable = WinMail + "\\wmopener.exe";
						
						System.Diagnostics.Process objProcess;
						try
						{
							objProcess = new System.Diagnostics.Process();
							//objProcess.StartInfo.FileName = ProcessPath
							objProcess.StartInfo.WindowStyle = ProcessWindowStyle.Minimized;
							objProcess.Start(Executable, (string) ('\u0022' + FQN + '\u0022' + " " + '\u0022' + ConversionDir + '\u0022'));
							
							//Wait until the process passes back an exit code
							objProcess.WaitForExit();
							
							//Free resources associated with this process
							objProcess.Close();
						}
						catch
						{
							if (modGlobals.gRunUnattended == false)
							{
								MessageBox.Show((string) ("Could not start process " + (WinMail + "\\wmopener.exe")), "Error");
							}
							LOG.WriteToArchiveLog((string) ("ERROR ShellandWait " + "Could not start process " + Executable));
						}
						finally
						{
							objProcess = null;
						}
					}
					
					public void getDirFiles(string dirFqn, List<string> AttachedFiles)
					{
						
						foreach (string myFile in Directory.GetFiles(dirFqn, "*.*"))
						{
							AttachedFiles.Add(myFile);
						}
					}
					
					private void MoveItemsToFolder(Outlook.MailItem oMsg)
					{
						Outlook.Folder targetFolder;
						Outlook._NameSpace oMAPI;
						
						try
						{
							targetFolder = oMAPI.GetFolderFromID(modGlobals.oHistoryEntryID, modGlobals.oHistoryStoreID);
							oMsg.Move(targetFolder);
						}
						catch (Exception)
						{
							LOG.WriteToArchiveLog((string) ("ERROR MoveItemsToFolder 100 " + oMsg.Subject.ToString()));
						}
						finally
						{
							targetFolder = null;
							oMAPI = null;
						}
						
					}
					
					// If the folder doesn't exist, there will be an error in the next
					// line.  That error will cause the error handler to go to :handleError
					// and skip the True return value
					public bool HistoryFolderExists()
					{
						int LL = 0;
						
						try
						{
							string FolderName = "ECM_History";
							LL = 1;
							var oApp = new Outlook.Application();
							LL = 1;
							Outlook.NameSpace oNS = oApp.GetNamespace("MAPI");
							LL = 1;
							Outlook.MAPIFolder myInbox = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderInbox);
							LL = 1;
							
							myInbox = myInbox.Folders(FolderName);
							LL = 1;
							
							oApp = null;
							oNS = null;
							myInbox = null;
							
						}
						catch (Exception ex)
						{
							LOG.WriteToArchiveLog((string) ("NOTICE: HistoryFolderExists - " + LL.ToString() + " : " + ex.Message));
						}
						
					}
					
					public bool MoveToHistoryFolder(Outlook.MailItem oMsg)
					{
						
						string FolderName = "ECM_History";
						Outlook.MailItem currentMessage;
						string errorReport;
						
						var oApp = new Outlook.Application();
						Outlook.NameSpace oNS = oApp.GetNamespace("MAPI");
						Outlook.MAPIFolder myInbox = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderInbox);
						
						try
						{
							oMsg.Move(myInbox.Folders(FolderName));
							LOG.WriteToArchiveLog((string) ("Notification: Moved email to history - Subject \'" + oMsg.Subject + "\' sent on " + oMsg.SentOn.ToString()));
						}
						catch (Exception)
						{
							LOG.WriteToArchiveLog((string) ("ERROR MoveToFolder 100 " + oMsg.Subject.ToString()));
						}
						finally
						{
							oApp = null;
							oNS = null;
							myInbox = null;
						}
						
					}
					
					public DateTime getLastContactArchiveDate()
					{
						
						DateTime LastWriteDate = DateTime.Parse("1/1/1900");
						
						try
						{
							
							string cPath = LOG.getTempEnvironDir();
							string TempFolder = cPath + "\\LastContactDate";
							
							Directory D;
							if (D.Exists(TempFolder))
							{
							}
							else
							{
								D.CreateDirectory(TempFolder);
							}
							
							string FName = "LastContactArchiveDate.TXT";
							string FQN = TempFolder + "\\" + FName;
							
							File F;
							if (! F.Exists(FQN))
							{
								// Create an instance of StreamWriter to write text to a file.
								using (StreamWriter sw = new StreamWriter(FQN, false))
								{
									sw.WriteLine(LastWriteDate.ToString());
									sw.Close();
								}
								
							}
							else
							{
								using (StreamReader SR = new StreamReader(FQN))
								{
									string sLastWriteDate = "";
									sLastWriteDate = SR.ReadLine();
									LastWriteDate = DateTime.Parse(sLastWriteDate);
									SR.Close();
								}
								
								
							}
							
						}
						catch (Exception ex)
						{
							if (dDebug)
							{
								Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
							}
							LastWriteDate = DateTime.Parse("1/1/1900");
						}
						return LastWriteDate;
					}
					
					public void saveLastContactArchiveDate(string LastArchiveDate)
					{
						
						
						try
						{
							
							string cPath = LOG.getTempEnvironDir();
							string TempFolder = cPath + "\\LastContactDate";
							
							Directory D;
							if (D.Exists(TempFolder))
							{
							}
							else
							{
								D.CreateDirectory(TempFolder);
							}
							
							string FName = "LastContactArchiveDate.TXT";
							string FQN = TempFolder + "\\" + FName;
							
							using (StreamWriter sw = new StreamWriter(FQN, false))
							{
								sw.WriteLine(LastArchiveDate);
								sw.Close();
							}
							
							
						}
						catch (Exception ex)
						{
							LOG.WriteToArchiveLog((string) ("ERROR clsArchiver : Failed to save last Contact Archive Date: 688 : " + ex.Message));
						}
						
					}
					
					public void PullRssData(string RssUrl)
					{
						
						DataSet ds = new DataSet();
						ds.ReadXml(RssUrl);
						
						DataGrid dgRss;
						//Dim ds As DataSet = New DataSet()
						//ds.ReadXml(RssUrl, XmlReadMode.Auto)
						
						//Put it in a datagrid
						dgRss.DataSource = ds.Tables[0];
						dgRss.Refresh();
						
						GC.Collect();
						
					}
					private string SQLString(string strSQL, int intLength)
					{
						strSQL = strSQL.Replace("\'", "\'\'");
						if (strSQL.Length > intLength)
						{
							strSQL = strSQL.Substring(0, intLength);
						}
						return strSQL;
					}
					
					/// <summary>
					/// Gets a RSS feed.
					/// </summary>
					/// <param name="strURL">The URL of the RSS feed to be rchived.</param>
					public void getRssFeed(string strURL)
					{
						
						System.Net.WebClient client = new System.Net.WebClient();
						string RssText = "";
						Chilkat.Rss rss = new Chilkat.Rss();
						
						bool success;
						
						//  Download from the feed URL:
						//success = rss.DownloadRss("http://blog.chilkatsoft.com/?feed=rss2")
						success = System.Convert.ToBoolean(RSS.DownloadRss(strURL));
						if (success != true)
						{
							MessageBox.Show(RSS.LastErrorText);
							return;
						}
						
						
						//  Get the 1st channel.
						Chilkat.Rss rssChannel;
						
						rssChannel = RSS.GetChannel(0);
						if (rssChannel == null)
						{
							MessageBox.Show("No channel found in RSS feed.");
							return;
						}
						
						//  Display the various pieces of information about the channel:
						RssText = RssText + "Title: " + rssChannel.GetString("title") + "\r\n";
						RssText = RssText + "Link: " + rssChannel.GetString("link") + "\r\n";
						RssText = RssText + "Description: " + rssChannel.GetString("description") + "\r\n";
						
						//  For each item in the channel, display the title, link,
						//  publish date, and categories assigned to the post.
						long numItems;
						numItems = rssChannel.NumItems;
						long i;
						
						for (i = 0; i <= numItems - 1; i++)
						{
							
							Chilkat.Rss rssItem;
							rssItem = rssChannel.GetItem(i);
							
							string sTitle = (string) (rssItem.GetString("title"));
							string sLink = (string) (rssItem.GetString("link"));
							string sPubDate = (string) (rssItem.GetString("pubDate"));
							
							Console.WriteLine("sTitle: " + sTitle);
							Console.WriteLine("sLink: " + sLink);
							Console.WriteLine("sPubDate: " + sPubDate);
							
							string ScrappedData = client.DownloadString(sLink);
							//Console.WriteLine("ScrappedData: " + ScrappedData)
							
							long numCategories;
							numCategories = rssItem.GetCount("category");
							long j;
							if (numCategories > 0)
							{
								for (j = 0; j <= numCategories - 1; j++)
								{
									string SCategory = (string) (rssItem.MGetString("category", j));
									Console.WriteLine("SCategory: " + SCategory);
								}
							}
							
						}
					}
					
					public void spiderWeb(string uriString, int MaxUrlsToSpider, int MaxOutboundLinks, string isPublic, string retentionCode)
					{
						
						
						frmNotify2 SpiderInfo = new frmNotify2();
						SpiderInfo.Show();
						SpiderInfo.Text = "WEB Archiver";
						
						Chilkat.Spider spider = new Chilkat.Spider();
						
						Chilkat.StringArray seenDomains = new Chilkat.StringArray();
						Chilkat.StringArray seedUrls = new Chilkat.StringArray();
						
						string currProcessedUrl = "";
						string allProcessedUrl = "";
						
						bool ParentSourceGuidSet = false;
						string ParentSourceGuid = "";
						string ChildSourceGuid = "";
						string WebpageTitle = "";
						string WebpageUrl = "";
						string WebPageFQN = "";
						
						
						seenDomains.Unique = true;
						seedUrls.Unique = true;
						
						seedUrls.Append(uriString);
						
						//  Set outbound URL exclude patterns
						//  URLs matching any of these patterns will not be added to the
						//  collection of outbound links.
						//spider.AddAvoidOutboundLinkPattern("*?id=*")
						//spider.AddAvoidOutboundLinkPattern("*.mypages.*")
						//spider.AddAvoidOutboundLinkPattern("*.personal.*")
						//spider.AddAvoidOutboundLinkPattern("*.comcast.*")
						//spider.AddAvoidOutboundLinkPattern("*.aol.*")
						//spider.AddAvoidOutboundLinkPattern("*~*")
						
						string CacheDir = LOG.getEnvVarSpecialFolderApplicationData() + "\\SpiderCache".Replace("\\\\", "\\");
						string WEBProcessingDir = System.Configuration.ConfigurationManager.AppSettings["WEBProcessingDir"];
						
						if (! Directory.Exists(CacheDir))
						{
							Directory.CreateDirectory(CacheDir);
						}
						//  Use a cache so we don't have to re-fetch URLs previously fetched.
						//spider.CacheDir = "c:/spiderCache/"
						spider.CacheDir = CacheDir;
						spider.FetchFromCache = true;
						spider.UpdateCache = true;
						
						while (seedUrls.Count > 0)
						{
							
							string url;
							url = (string) (seedUrls.Pop());
							spider.Initialize(url);
							
							//  Spider 5 URLs of this domain.
							//  but first, save the base domain in seenDomains
							string domain;
							domain = (string) (spider.GetDomain(url));
							seenDomains.Append(spider.GetBaseDomain(domain));
							
							long i;
							bool success;
							for (i = 0; i <= MaxUrlsToSpider - 1; i++)
							{
								success = System.Convert.ToBoolean(spider.CrawlNext());
								if (success != true)
								{
									break;
								}
								
								//  Display the URL we just crawled.
								currProcessedUrl = (string) spider.LastUrl;
								allProcessedUrl += currProcessedUrl + " | ";
								
								Application.DoEvents();
								string kw = (string) spider.LastHtmlKeywords;
								string LastModDate = (string) spider.LastModDateStr;
								if (LastModDate.Length == 0)
								{
									LastModDate = "01/01/1970 12:01 AM";
								}
								else
								{
									Console.WriteLine(LastModDate);
								}
								string LastDesc = (string) spider.LastHtmlDescription;
								string PageTitle = (string) spider.LastHtmlTitle;
								string FQN = domain + "@" + PageTitle + ".HTML";
								string WebFQN = "";
								int idx = currProcessedUrl.IndexOf("//");
								if (idx > 0)
								{
									WebFQN = currProcessedUrl.Substring(idx + 2);
								}
								string PageHtml = (string) spider.LastHtml;
								int iLen = PageHtml.Trim().Length;
								
								SpiderInfo.lblEmailMsg.Text = domain;
								SpiderInfo.lblMsg2.Text = currProcessedUrl;
								double DBL = iLen / 1000;
								SpiderInfo.lblFolder.Text = (string) ("Size: " + DBL.ToString() + " Kb - " + i.ToString() + " of " + MaxUrlsToSpider.ToString());
								SpiderInfo.Refresh();
								Application.DoEvents();
								
								if (iLen > 0)
								{
									WebFQN = "";
									WebFQN = (string) (UTIL.ConvertUrlToFQN(WEBProcessingDir, currProcessedUrl, ".HTML") + WebFQN);
									
									StreamWriter outfile = new StreamWriter(WebFQN, false);
									outfile.Write(PageHtml);
									outfile.Close();
									outfile.Dispose();
									
									if (ChildSourceGuid.Trim().Length > 0 && ! ParentSourceGuidSet)
									{
										ParentSourceGuid = ChildSourceGuid;
										ParentSourceGuidSet = true;
									}
									
									if (isPublic.ToLower().Equals("true"))
									{
										isPublic = "Y";
									}
									
									ChildSourceGuid = ArchiveWebPage(ParentSourceGuid, PageTitle, currProcessedUrl, WebFQN, retentionCode, isPublic, DateTime.Parse(LastModDate));
									
									try
									{
										File.Delete(FQN);
									}
									catch (Exception)
									{
										Console.WriteLine("Failed to delete: " + FQN);
									}
									
								}
								
								//  If the last URL was retrieved from cache, we won't wait.  Otherwise we'll wait 1 second before fetching the next URL.
								if (spider.LastFromCache != true)
								{
									spider.SleepMs(500);
								}
								
							}
							
							//  Add the outbound links to seedUrls, except
							//  for the domains we've already seen.
							for (i = 0; i <= spider.NumOutboundLinks - 1; i++)
							{
								url = (string) (spider.GetOutboundLink(i));
								domain = (string) (spider.GetDomain(url));
								string baseDomain;
								baseDomain = (string) (spider.GetBaseDomain(domain));
								if (! seenDomains.Contains(baseDomain))
								{
									seedUrls.Append(url);
								}
								
								//  Don't let our list of seedUrls grow too large.
								if (seedUrls.Count > MaxOutboundLinks)
								{
									break;
								}
							}
							
						}
						
						SpiderInfo.Close();
						SpiderInfo = null;
						GC.Collect();
						GC.WaitForPendingFinalizers();
						
					}
					
					public string ReadFileIntoString(string FQN)
					{
						string S = "";
						System.IO.TextReader tr = new System.IO.StreamReader(FQN);
						S = tr.ReadToEnd();
						tr.Dispose();
						GC.Collect();
						GC.WaitForPendingFinalizers();
						return S;
					}
					
				}
				
			}

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

using Microsoft.Office.Interop.Outlook;
using System.Data.SqlClient;
using System.IO;
using System.Xml;
using System.Threading;
using Microsoft.VisualBasic.CompilerServices;



namespace EcmArchiveClcSetup
{
	public class clsPst
	{
		
		clsDbLocal DBLocal = new clsDbLocal();
		clsLogging LOG = new clsLogging();
		int currLevel = 0;
		int TotalFolders = 0;
		int TotalItems = 0;
		
		static List<string> StoresToRemove = new List<string>();
		
		frmPstLoader.ProcessFolders ProcFolders = new frmPstLoader.ProcessFolders();
		
		public void RemoveStores()
		{
			try
			{
				Microsoft.Office.Interop.Outlook.Application objOL;
				Microsoft.Office.Interop.Outlook.NameSpace objNS;
				Microsoft.Office.Interop.Outlook.MAPIFolder objFolder;
				
				objOL = Interaction.CreateObject("Outlook.Application", "");
				objNS = objOL.GetNamespace("MAPI");
				objFolder = objNS.Folders.GetLast();
				
				objNS.RemoveStore(objFolder);
				
				objOL = null;
				objNS = null;
				objFolder = null;
				
			}
			catch (System.Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("NOTICE: RemoveStores 100 - " + ex.Message));
			}
			
		}
		
		public void PstStats(ref ListBox lbMsg, string pstFQN, string pstName, bool bArchiveEmails)
		{
			try
			{
				SortedList<string, string> L = new SortedList<string, string>();
				
				if (bArchiveEmails == false)
				{
					lbMsg.Items.Clear();
				}
				
				StoresToRemove.Clear();
				
				int StoreIndexNbr = 0;
				LinkedList<string> mailItems = new LinkedList<string>();
				Microsoft.Office.Interop.Outlook.Application objOL;
				Microsoft.Office.Interop.Outlook.NameSpace objNS;
				Microsoft.Office.Interop.Outlook.MAPIFolder objFolder;
				
				objOL = Interaction.CreateObject("Outlook.Application", "");
				objNS = objOL.GetNamespace("MAPI");
				
				//** Add PST file (Outlook Data File) to Default Profile
				objNS.AddStore(pstFQN);
				
				objFolder = objNS.Folders.GetLast();
				Console.WriteLine(objFolder.Name);
				//objFolder.Name = pstName
				
				StoresToRemove.Add(objFolder.Name);
				
				string S = "";
				int iStoresCnt = objNS.Stores.Count;
				
				S = (string) ("#Stores: " + iStoresCnt.ToString());
				if (bArchiveEmails == false)
				{
					lbMsg.Items.Add(S);
				}
				
				
				for (StoreIndexNbr = iStoresCnt; StoreIndexNbr <= iStoresCnt; StoreIndexNbr++)
				{
					
					string ParentFolderName = "";
					Microsoft.Office.Interop.Outlook.MAPIFolder rootFolder = objNS.Stores(StoreIndexNbr).GetRootFolder;
					var rootFolderName = rootFolder.Name;
					int iFolderItems = rootFolder.Items.Count;
					int iFoldercnt = rootFolder.Folders.Count;
					
					ParentFolderName = rootFolderName;
					
					string ParentFolderID = rootFolder.EntryID;
					
					S = (string) ("FLDR: " + rootFolderName);
					if (bArchiveEmails == false)
					{
						lbMsg.Items.Add(S);
					}
					
					S = (string) ("     #Folders: " + iFoldercnt.ToString());
					if (bArchiveEmails == false)
					{
						lbMsg.Items.Add(S);
					}
					
					S = (string) ("     #Items: " + iFolderItems.ToString());
					if (bArchiveEmails == false)
					{
						lbMsg.Items.Add(S);
					}
					
					frmPstLoader.Default.Refresh();
					System.Windows.Forms.Application.DoEvents();
					
					//** Traverse through all folders in the PST file
					//** TODO: This is not recursive, refactor
					
					Microsoft.Office.Interop.Outlook.Folders subFolder;
					int II = 0;
					
					foreach (Microsoft.Office.Interop.Outlook.Folder Folder in rootFolder.Folders)
					{
						frmPstLoader.CurrIdNbr++;
						System.Windows.Forms.Application.DoEvents();
						
						string pName = Folder.Name;
						int iSubfolders = Folder.Folders.Count;
						
						II++;
						frmPstLoader.Default.SB.Text = pName + " : " + II.ToString();
						System.Windows.Forms.Application.DoEvents();
						
						//***************************************************************************************************
						string TopFolderName = pName;
						Microsoft.Office.Interop.Outlook.Folder CurrFolder = Folder;
						bool DeleteFile = false;
						string ArchiveEmails = "Y";
						string RemoveAfterArchive = "";
						string SetAsDefaultFolder = "";
						string ArchiveAfterXDays = "";
						string RemoveAfterXDays = "";
						string RemoveXDays = "";
						string ArchiveXDays = "";
						
						//** When we start using multiple databases, we have to replace ECMREPO with the real value.
						string DB_ID = "ECMREPO";
						
						string UserID = modGlobals.gCurrUserGuidID;
						string ArchiveOnlyIfRead;
						int RetentionYears = 20;
						string RetentionCode;
						
						S = (string) ("          SubFldr: " + Folder.Name + " : " + Folder.Folders.Count.ToString() + " : " + Folder.Items.Count.ToString() + " " + Strings.Chr(254) + frmPstLoader.CurrIdNbr.ToString() + Strings.Chr(254));
						
						//************************************************************************
						ProcFolders.oFolder = Folder;
						ProcFolders.iKey = frmPstLoader.CurrIdNbr;
						
						if (frmPstLoader.FoldersToProcess == null)
						{
							frmPstLoader.FoldersToProcess = new ProcessFolders[1];
							frmPstLoader.FoldersToProcess[0] = ProcFolders;
						}
						else
						{
							int iBound = System.Convert.ToInt32((frmPstLoader.FoldersToProcess.Length - 1) + 1);
							Array.Resize(ref frmPstLoader.FoldersToProcess, iBound + 1);
							frmPstLoader.FoldersToProcess[iBound] = ProcFolders;
						}
						//************************************************************************
						
						
						if (bArchiveEmails == false)
						{
							lbMsg.Items.Add(S);
						}
						
						if (iSubfolders > 0)
						{
							GetSubFolders(ref lbMsg, pName, Folder, ref L);
						}
						//**************************************************
						pName = "";
					} //** Folder
				} //** StoreIndexNbr
				frmPstLoader.Default.SB.Text = "Loaded.";
				//objNS.RemoveStore(pstFQN )
			}
			catch (System.Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("PstStats: ERROR 100.10 - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("PstStats: ERROR 100.10 - " + ex.StackTrace));
				frmPstLoader.Default.SB.Text = (string) ("ERROR: Check Logs: " + ex.Message);
			}
			
		}
		
		public void GetSubFolders(ref ListBox lbMsg, string CurrentFolderName, Microsoft.Office.Interop.Outlook.MAPIFolder CurrentFolder, ref SortedList<string, string> L)
		{
			
			Microsoft.Office.Interop.Outlook.MAPIFolder OrigFolder = CurrentFolder;
			string cFolder = CurrentFolder.Name;
			foreach (Microsoft.Office.Interop.Outlook.Folder Folder in CurrentFolder.Folders)
			{
				frmPstLoader.CurrIdNbr++;
				currLevel++;
				string FullFolderName = CurrentFolderName + "->" + Folder.Name + "     ";
				int iSubfolders = Folder.Folders.Count;
				//**************************************************
				if (iSubfolders > 0)
				{
					GetSubFolders(ref lbMsg, FullFolderName, Folder, ref L);
				}
				
				string S = (string) ("          SubFldr: " + FullFolderName + " : " + Folder.Name + " : " + Folder.Folders.Count.ToString() + " : " + Folder.Items.Count.ToString() + Strings.Chr(254) + frmPstLoader.CurrIdNbr.ToString() + Strings.Chr(254));
				lbMsg.Items.Add(S);
				
				//************************************************************************
				ProcFolders.oFolder = Folder;
				ProcFolders.iKey = frmPstLoader.CurrIdNbr;
				
				if (frmPstLoader.FoldersToProcess == null)
				{
					frmPstLoader.FoldersToProcess = new ProcessFolders[1];
					frmPstLoader.FoldersToProcess[0] = ProcFolders;
				}
				else
				{
					int iBound = System.Convert.ToInt32((frmPstLoader.FoldersToProcess.Length - 1) + 1);
					Array.Resize(ref frmPstLoader.FoldersToProcess, iBound + 1);
					frmPstLoader.FoldersToProcess[iBound] = ProcFolders;
				}
				//************************************************************************
				
			}
			currLevel--;
		}
		
		public void readPst(string pstFQN, string pstName)
		{
			
			int StoreIndexNbr = 0;
			LinkedList<string> mailItems = new LinkedList<string>();
			Microsoft.Office.Interop.Outlook.Application objOL;
			Microsoft.Office.Interop.Outlook.NameSpace objNS;
			Microsoft.Office.Interop.Outlook.MAPIFolder objFolder;
			
			objOL = Interaction.CreateObject("Outlook.Application", "");
			objNS = objOL.GetNamespace("MAPI");
			
			//** Add PST file (Outlook Data File) to Default Profile
			objNS.AddStore(pstFQN);
			
			objFolder = objNS.Folders.GetLast();
			objFolder.Name = pstName;
			
			int iStoresCnt = objNS.Stores.Count;
			for (StoreIndexNbr = 0; StoreIndexNbr <= iStoresCnt - 1; StoreIndexNbr++)
			{
				Microsoft.Office.Interop.Outlook.MAPIFolder rootFolder = objNS.Stores(StoreIndexNbr).GetRootFolder;
				//** Traverse through all folders in the PST file
				//** TODO: This is not recursive, refactor
				
				Microsoft.Office.Interop.Outlook.Folders subFolder;
				
				foreach (Microsoft.Office.Interop.Outlook.Folder Folder in rootFolder.Folders)
				{
					Console.WriteLine("rootFolder: " + rootFolder.Name);
					Console.WriteLine("rootFolder: " + rootFolder.EntryID);
					Console.WriteLine("Folder: " + Folder.Name);
					Console.WriteLine("Folder EntryID: " + Folder.EntryID);
					Console.WriteLine("Folder Items.Count: " + Folder.Items.Count);
					
					foreach (Microsoft.Office.Interop.Outlook.MailItem item in Folder.Items)
					{
						Console.WriteLine("Subject: " + item.Subject);
						Console.WriteLine("SentOn : " + item.SentOn.ToString());
						Console.WriteLine("Attachments.Count: " + item.Attachments.Count);
					} //** item
				} //** Folder
			} //** StoreIndexNbr
			
		}
		public void SetNewStore(string strFileName, string strDisplayName)
		{
			
			Microsoft.Office.Interop.Outlook.Application objOL;
			Microsoft.Office.Interop.Outlook.NameSpace objNS;
			Microsoft.Office.Interop.Outlook.MAPIFolder objFolder;
			
			objOL = Interaction.CreateObject("Outlook.Application", "");
			objNS = objOL.GetNamespace("MAPI");
			objNS.AddStore(strFileName);
			objFolder = objNS.Folders.GetLast();
			objFolder.Name = strDisplayName;
			
			objOL = null;
			objNS = null;
			objFolder = null;
			
		}
		
		public void ArchiveSelectedFolders(string UID, ListBox L, string PstFQN, string RetentionCode, string Library, SortedList slStoreId)
		{
			
			string isPublic = "N";
			
			SortedList<int, string> Owner = new SortedList<int, string>();
			string DB_ID = "ECMREPO";
			string UserID = modGlobals.gCurrUserGuidID;
			string ArchiveOnlyIfRead;
			int RetentionYears = 20;
			
			SortedList<int, string> KeysToProcess = new SortedList<int, string>();
			SortedList<int, string> FolderNames = new SortedList<int, string>();
			SortedList<int, string> FolderItemCount = new SortedList<int, string>();
			SortedList<int, string> TopFolder = new SortedList<int, string>();
			string OwnerFolder = "";
			
			for (int X = 0; X <= L.Items.Count - 1; X++)
			{
				string S = L.Items[X].ToString();
				string TestStr = S.Trim();
				if (TestStr.IndexOf("FLDR:") + 1 > 0)
				{
					TestStr = S.Substring(0, 5);
					if (TestStr.Equals("FLDR:"))
					{
						string[] A = S.Split(":".ToCharArray());
						OwnerFolder = A[1].Trim();
					}
				}
				if (S.IndexOf("SubFldr") + 1 > 0)
				{
					if (S.IndexOf((Strings.Chr(254)).ToString()) + 1 > 0)
					{
						string[] A = S.Split(Strings.Chr(254).ToString().ToCharArray());
						string[] B = S.Split(":".ToCharArray());
						if ((A.Length - 1) > 0)
						{
							if (A[1].Trim() != null)
							{
								if (Information.IsNumeric(A[1]))
								{
									//KeysToProcess.Add(Val(A(1)))
									if (Owner.IndexOfKey(val[A[1]]) >= 0)
									{
										Console.WriteLine("Exists");
									}
									else
									{
										try
										{
											Owner.Add(val[A[1]], OwnerFolder);
										}
										catch (System.Exception ex)
										{
											LOG.WriteToArchiveLog((string) ("OwnerFolder  100: " + ex.Message));
										}
									}
								}
							}
						}
					}
				}
			}
			
			KeysToProcess.Clear();
			FolderNames.Clear();
			
			foreach (string S in L.SelectedItems)
			{
				S = S.Trim();
				frmMain.Default.SB2.Text = (string) ("Folder: " + S);
				frmMain.Default.SB2.Refresh();
				System.Windows.Forms.Application.DoEvents();
				
				if (S.IndexOf("subfldr") + 1 > 0)
				{
					if (S.IndexOf((Strings.Chr(254)).ToString()) + 1 > 0)
					{
						string[] A = S.Split(Strings.Chr(254).ToString().ToCharArray());
						string[] B = S.Split(":".ToCharArray());
						if ((A.Length - 1) > 0)
						{
							if (A[1].Trim() != null)
							{
								if (Information.IsNumeric(A[1]))
								{
									int iLoc = int.Parse(val[A[1]]);
									if (KeysToProcess.IndexOfKey(iLoc) >= 0)
									{
									}
									else
									{
										KeysToProcess.Add(iLoc, iLoc);
									}
									if (FolderNames.IndexOfKey(iLoc) >= 0)
									{
										LOG.WriteToArchiveLog((string) ("PST Exception - IndexOfKey 1001: " + OwnerFolder + "|" + B[1]));
									}
									else
									{
										try
										{
											FolderNames.Add(iLoc, OwnerFolder + "|" + B[1]);
										}
										catch (System.Exception)
										{
											LOG.WriteToArchiveLog((string) ("PST Exception - IndexOfKey 2001: " + OwnerFolder + "|" + B[1]));
										}
									}
									if ((B[3]).IndexOf((Strings.Chr(254)).ToString()) + 1 > 0)
									{
										int II = (B[3]).IndexOf((Strings.Chr(254)).ToString()) + 1;
										B[3] = B[3].Substring(0, II - 1);
										B[3] = B[3].Trim();
									}
									if (FolderItemCount.IndexOfKey(iLoc) >= 0)
									{
									}
									else
									{
										FolderItemCount.Add(iLoc, val[B[3]]);
									}
									
									if (Owner.IndexOfKey(val[A[1]]) >= 0)
									{
										try
										{
											OwnerFolder = (string) (Owner[val[A[1]]]);
										}
										catch (System.Exception ex)
										{
											LOG.WriteToArchiveLog((string) ("OwnerFolder  200: " + ex.Message));
										}
									}
									Console.WriteLine("Processing Folder: " + OwnerFolder + " | " + B[1] + ", Emails = " + B[3] + ", Key = " + A[1] + ".");
								}
							}
						}
					}
				}
			}
			
			clsArchiver ARCH = new clsArchiver();
			
			Microsoft.Office.Interop.Outlook.Folder CurrFolder;
			int iKey = -1;
			
			//************************************************************************
			//Dim oEcmHistFolder As Outlook.MAPIFolder = Nothing
			//Dim FolderFound As Boolean = False
			//For Each oFolder In oParentFolder.Folders
			//    If oFolder.Name.ToUpper.Equals("ECM_HISTORY") Then
			//        oEcmHistFolder = oFolder
			//        FolderFound = True
			//    End If
			//Next
			//If FolderFound = False Then
			//    messagebox.show("Create folder here")
			//End If
			
			
			for (int i = 0; i <= frmPstLoader.FoldersToProcess.Count - 1; i++)
			{
				//.Text = i.ToString
				//FrmMDIMain.SB.Text = "PST Folder# " + i.ToString
				System.Windows.Forms.Application.DoEvents();
				
				CurrFolder = frmPstLoader.FoldersToProcess[i].oFolder;
				iKey = frmPstLoader.FoldersToProcess[i].iKey;
				int II = 0;
				if (KeysToProcess.IndexOfKey(iKey) >= 0)
				{
					II++;
					//FrmMDIMain.SB.Text = "PST Folder# " + i.ToString + " : " + "inserts - " + II.ToString
					frmMain.Default.SB.Text = (string) ("PST Folder# " + i.ToString() + " : " + "inserts - " + II.ToString());
					frmMain.Default.SB.Refresh();
					frmPstLoader.Default.SB.Text = (string) ("PST Folder# " + i.ToString() + " : " + "inserts - " + II.ToString());
					frmPstLoader.Default.SB.Refresh();
					System.Windows.Forms.Application.DoEvents();
					
					string DisplayName = CurrFolder.Store.DisplayName;
					
					Microsoft.Office.Interop.Outlook.Folder ParentFldr;
					ParentFldr = CurrFolder.Parent;
					string PID = ParentFldr.EntryID;
					ParentFldr = null;
					
					frmMain.Default.SB.Text = (string) ("PST Folder: " + DisplayName + i.ToString() + " : " + "inserts - " + II.ToString());
					
					int CurrentKey = System.Convert.ToInt32(KeysToProcess[iKey]);
					
					string[] A = FolderNames[iKey].Trim.Split("|");
					
					frmPstLoader.Default.SB.Text = (string) (FolderNames[iKey].Trim);
					frmPstLoader.Default.SB.Refresh();
					System.Windows.Forms.Application.DoEvents();
					
					string NewName = "";
					if ((A.Length - 1) == 1)
					{
						NewName = A[0].Trim() + "|" + A[1].Trim();
					}
					else
					{
						NewName = (string) (FolderNames[iKey].Trim);
					}
					
					string CurrentFolderName = NewName;
					int NbrOfItemsToProcess = System.Convert.ToInt32(FolderItemCount[iKey]);
					
					string StoreName = DisplayName;
					//If NbrOfItemsToProcess = 0 Then
					//    GoTo NEXTONE
					//End If
					
					//** Process this folder.
					frmPstLoader.Default.SB.Text = StoreName + " : " + CurrFolder.Name + " - " + (i + 1).ToString() + " of " + CurrFolder.Items.Count.ToString();
					frmPstLoader.Default.SB.Refresh();
					System.Windows.Forms.Application.DoEvents();
					
					LOG.WriteToArchiveLog((string) ("PST 300: " + StoreName + " : " + CurrFolder.Name + " - " + (i + 1).ToString() + " of " + CurrFolder.Items.Count.ToString()));
					
					string StoreID = CurrFolder.StoreID.ToString();
					string TopFolderName = (string) ("PST: <" + PstFQN + "> : " + StoreName);
					string ParentFolderID = PID;
					string FolderKeyName = CurrentFolderName;
					string FID = CurrFolder.EntryID;
					
					//*************************************************************************************************************
					ARCH.AddPstFolder(StoreID, TopFolderName, ParentFolderID, FolderKeyName, FID, PstFQN, RetentionCode);
					//*************************************************************************************************************
					
					string ArchiveEmails = "Y";
					string RemoveAfterArchive = "N";
					string SetAsDefaultFolder = "N";
					string ArchiveAfterXDays = "";
					string RemoveAfterXDays = "";
					string RemoveXDays = "";
					string ArchiveXDays = "";
					bool DeleteFile = false;
					
					//*************************************************************************************************************
					DBLocal.setOutlookMissing();
					ARCH.EmailLibrary = Library;
					
					ARCH.ArchiveEmailsInFolder(UID, TopFolderName, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, CurrFolder, StoreID, ArchiveOnlyIfRead, RetentionYears, RetentionCode, FolderKeyName, slStoreId, isPublic);
					//*************************************************************************************************************
				}
NEXTONE:
				1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
			}
			//************************************************************************
			
			ARCH = null;
			
		}
		
	}
	
}

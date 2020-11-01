using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Windows.Forms;
using global::Microsoft.Office.Interop.Outlook;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public class clsPst
    {
        private clsDbLocal DBLocal = new clsDbLocal();
        private clsLogging LOG = new clsLogging();
        private int currLevel = 0;
        private int TotalFolders = 0;
        private int TotalItems = 0;
        private static List<string> StoresToRemove = new List<string>();
        private frmPstLoader.ProcessFolders ProcFolders = new frmPstLoader.ProcessFolders();

        public void RemoveStores()
        {
            try
            {
                Microsoft.Office.Interop.Outlook.Application objOL;
                NameSpace objNS;
                MAPIFolder objFolder;
                objOL = (Microsoft.Office.Interop.Outlook.Application)Interaction.CreateObject("Outlook.Application");
                objNS = objOL.GetNamespace("MAPI");
                objFolder = objNS.Folders.GetLast();
                objNS.RemoveStore(objFolder);
                objOL = null;
                objNS = null;
                objFolder = null;
            }
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("NOTICE: RemoveStores 100 - " + ex.Message);
            }
        }

        public void PstStats(ref ListBox lbMsg, string pstFQN, string pstName, bool bArchiveEmails)
        {
            try
            {
                var L = new SortedList<string, string>();
                if (bArchiveEmails == false)
                {
                    lbMsg.Items.Clear();
                }

                StoresToRemove.Clear();
                int StoreIndexNbr = 0;
                var mailItems = new LinkedList<string>();
                Microsoft.Office.Interop.Outlook.Application objOL;
                NameSpace objNS;
                MAPIFolder objFolder;
                objOL = (Microsoft.Office.Interop.Outlook.Application)Interaction.CreateObject("Outlook.Application");
                objNS = objOL.GetNamespace("MAPI");

                // ** Add PST file (Outlook Data File) to Default Profile
                objNS.AddStore(pstFQN);
                objFolder = objNS.Folders.GetLast();
                Console.WriteLine(objFolder.Name);
                // objFolder.Name = pstName

                StoresToRemove.Add(objFolder.Name);
                string S = "";
                int iStoresCnt = objNS.Stores.Count;
                S = "#Stores: " + iStoresCnt.ToString();
                if (bArchiveEmails == false)
                {
                    lbMsg.Items.Add(S);
                }

                var loopTo = iStoresCnt;
                for (StoreIndexNbr = iStoresCnt; StoreIndexNbr <= loopTo; StoreIndexNbr++)
                {
                    string ParentFolderName = "";
                    var rootFolder = objNS.Stores[StoreIndexNbr].GetRootFolder();
                    string rootFolderName = rootFolder.Name;
                    int iFolderItems = rootFolder.Items.Count;
                    int iFoldercnt = rootFolder.Folders.Count;
                    ParentFolderName = rootFolderName;
                    string ParentFolderID = rootFolder.EntryID;
                    S = "FLDR: " + rootFolderName;
                    if (bArchiveEmails == false)
                    {
                        lbMsg.Items.Add(S);
                    }

                    S = "     #Folders: " + iFoldercnt.ToString();
                    if (bArchiveEmails == false)
                    {
                        lbMsg.Items.Add(S);
                    }

                    S = "     #Items: " + iFolderItems.ToString();
                    if (bArchiveEmails == false)
                    {
                        lbMsg.Items.Add(S);
                    }

                    My.MyProject.Forms.frmPstLoader.Refresh();

                    // ** Traverse through all folders in the PST file
                    // ** TODO: This is not recursive, refactor
                    System.Windows.Forms.Application.DoEvents();
                    Folders subFolder;
                    int II = 0;
                    foreach (Folder Folder in rootFolder.Folders)
                    {
                        frmPstLoader.CurrIdNbr += 1;
                        System.Windows.Forms.Application.DoEvents();
                        string pName = Folder.Name;
                        int iSubfolders = Folder.Folders.Count;
                        II += 1;
                        My.MyProject.Forms.frmPstLoader.SB.Text = pName + " : " + II.ToString();
                        System.Windows.Forms.Application.DoEvents();

                        // ***************************************************************************************************
                        string TopFolderName = pName;
                        var CurrFolder = Folder;
                        bool DeleteFile = false;
                        string ArchiveEmails = "Y";
                        string RemoveAfterArchive = "";
                        string SetAsDefaultFolder = "";
                        string ArchiveAfterXDays = "";
                        string RemoveAfterXDays = "";
                        string RemoveXDays = "";
                        string ArchiveXDays = "";

                        // ** When we start using multiple databases, we have to replace ECMREPO with the real value.
                        string DB_ID = "ECMREPO";
                        string UserID = modGlobals.gCurrUserGuidID;
                        string ArchiveOnlyIfRead;
                        int RetentionYears = 20;
                        string RetentionCode;
                        S = "          SubFldr: " + Folder.Name + " : " + Folder.Folders.Count.ToString() + " : " + Folder.Items.Count.ToString() + " " + Conversions.ToString('þ') + frmPstLoader.CurrIdNbr.ToString() + Conversions.ToString('þ');

                        // ************************************************************************
                        ProcFolders.oFolder = Folder;
                        ProcFolders.iKey = frmPstLoader.CurrIdNbr;
                        if (frmPstLoader.FoldersToProcess is null)
                        {
                            frmPstLoader.FoldersToProcess = new frmPstLoader.ProcessFolders[1];
                            frmPstLoader.FoldersToProcess[0] = ProcFolders;
                        }
                        else
                        {
                            int iBound = Information.UBound(frmPstLoader.FoldersToProcess) + 1;
                            Array.Resize(ref frmPstLoader.FoldersToProcess, iBound + 1);
                            frmPstLoader.FoldersToProcess[iBound] = ProcFolders;
                        }
                        // ************************************************************************

                        if (bArchiveEmails == false)
                        {
                            lbMsg.Items.Add(S);
                        }

                        if (iSubfolders > 0)
                        {
                            GetSubFolders(ref lbMsg, pName, Folder, ref L);
                        }
                        // **************************************************
                        pName = "";
                    }    // ** Folder
                }    // ** StoreIndexNbr

                My.MyProject.Forms.frmPstLoader.SB.Text = "Loaded.";
            }
            // objNS.RemoveStore(pstFQN )
            catch (System.Exception ex)
            {
                LOG.WriteToArchiveLog("PstStats: ERROR 100.10 - " + ex.Message);
                LOG.WriteToArchiveLog("PstStats: ERROR 100.10 - " + ex.StackTrace);
                My.MyProject.Forms.frmPstLoader.SB.Text = "ERROR: Check Logs: " + ex.Message;
            }
        }

        public void GetSubFolders(ref ListBox lbMsg, string CurrentFolderName, MAPIFolder CurrentFolder, ref SortedList<string, string> L)
        {
            var OrigFolder = CurrentFolder;
            string cFolder = CurrentFolder.Name;
            foreach (Folder Folder in CurrentFolder.Folders)
            {
                frmPstLoader.CurrIdNbr += 1;
                currLevel = currLevel + 1;
                string FullFolderName = CurrentFolderName + "->" + Folder.Name + "     ";
                int iSubfolders = Folder.Folders.Count;
                // **************************************************
                if (iSubfolders > 0)
                {
                    GetSubFolders(ref lbMsg, FullFolderName, Folder, ref L);
                }

                string S = "          SubFldr: " + FullFolderName + " : " + Folder.Name + " : " + Folder.Folders.Count.ToString() + " : " + Folder.Items.Count.ToString() + Conversions.ToString('þ') + frmPstLoader.CurrIdNbr.ToString() + Conversions.ToString('þ');
                lbMsg.Items.Add(S);

                // ************************************************************************
                ProcFolders.oFolder = Folder;
                ProcFolders.iKey = frmPstLoader.CurrIdNbr;
                if (frmPstLoader.FoldersToProcess is null)
                {
                    frmPstLoader.FoldersToProcess = new frmPstLoader.ProcessFolders[1];
                    frmPstLoader.FoldersToProcess[0] = ProcFolders;
                }
                else
                {
                    int iBound = Information.UBound(frmPstLoader.FoldersToProcess) + 1;
                    Array.Resize(ref frmPstLoader.FoldersToProcess, iBound + 1);
                    frmPstLoader.FoldersToProcess[iBound] = ProcFolders;
                }
                // ************************************************************************

            }

            currLevel = currLevel - 1;
        }

        public void readPst(string pstFQN, string pstName)
        {
            int StoreIndexNbr = 0;
            var mailItems = new LinkedList<string>();
            Microsoft.Office.Interop.Outlook.Application objOL;
            NameSpace objNS;
            MAPIFolder objFolder;
            objOL = (Microsoft.Office.Interop.Outlook.Application)Interaction.CreateObject("Outlook.Application");
            objNS = objOL.GetNamespace("MAPI");

            // ** Add PST file (Outlook Data File) to Default Profile
            objNS.AddStore(pstFQN);
            objFolder = objNS.Folders.GetLast();
            objFolder.Name = pstName;
            int iStoresCnt = objNS.Stores.Count;
            var loopTo = iStoresCnt - 1;
            for (StoreIndexNbr = 0; StoreIndexNbr <= loopTo; StoreIndexNbr++)
            {
                // ** Traverse through all folders in the PST file
                // ** TODO: This is not recursive, refactor
                var rootFolder = objNS.Stores[StoreIndexNbr].GetRootFolder();
                Folders subFolder;
                foreach (Folder Folder in rootFolder.Folders)
                {
                    Console.WriteLine("rootFolder: " + rootFolder.Name);
                    Console.WriteLine("rootFolder: " + rootFolder.EntryID);
                    Console.WriteLine("Folder: " + Folder.Name);
                    Console.WriteLine("Folder EntryID: " + Folder.EntryID);
                    Console.WriteLine(Conversions.ToDouble("Folder Items.Count: ") + Folder.Items.Count);
                    foreach (MailItem item in Folder.Items)
                    {
                        Console.WriteLine("Subject: " + item.Subject);
                        Console.WriteLine("SentOn : " + item.SentOn.ToString());
                        Console.WriteLine(Conversions.ToDouble("Attachments.Count: ") + item.Attachments.Count);
                    }    // ** item
                }    // ** Folder
            }    // ** StoreIndexNbr
        }

        public void SetNewStore(string strFileName, string strDisplayName)
        {
            Microsoft.Office.Interop.Outlook.Application objOL;
            NameSpace objNS;
            MAPIFolder objFolder;
            objOL = (Microsoft.Office.Interop.Outlook.Application)Interaction.CreateObject("Outlook.Application");
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
            var Owner = new SortedList<int, string>();
            string DB_ID = "ECMREPO";
            string UserID = modGlobals.gCurrUserGuidID;
            string ArchiveOnlyIfRead = "";
            int RetentionYears = 20;
            var KeysToProcess = new SortedList<int, string>();
            var FolderNames = new SortedList<int, string>();
            var FolderItemCount = new SortedList<int, string>();
            var TopFolder = new SortedList<int, string>();
            string OwnerFolder = "";
            for (int X = 0, loopTo = L.Items.Count - 1; X <= loopTo; X++)
            {
                string S = L.Items[X].ToString();
                string TestStr = S.Trim();
                if (Strings.InStr(TestStr, "FLDR:", CompareMethod.Text) > 0)
                {
                    TestStr = Strings.Mid(S, 1, 5);
                    if (TestStr.Equals("FLDR:"))
                    {
                        var A = S.Split(':');
                        OwnerFolder = A[1].Trim();
                    }
                }

                if (Strings.InStr(S, "SubFldr", CompareMethod.Text) > 0)
                {
                    if (Strings.InStr(S, Conversions.ToString('þ')) > 0)
                    {
                        var A = S.Split('þ');
                        var B = S.Split(':');
                        if (Information.UBound(A) > 0)
                        {
                            if (A[1].Trim() != null)
                            {
                                if (Information.IsNumeric(A[1]))
                                {
                                    // KeysToProcess.Add(Val(A(1)))
                                    if (Owner.IndexOfKey((int)Conversion.Val(A[1])) >= 0)
                                    {
                                        Console.WriteLine("Exists");
                                    }
                                    else
                                    {
                                        try
                                        {
                                            Owner.Add((int)Conversion.Val(A[1]), OwnerFolder);
                                        }
                                        catch (System.Exception ex)
                                        {
                                            LOG.WriteToArchiveLog("OwnerFolder  100: " + ex.Message);
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
                My.MyProject.Forms.frmMain.SB2.Text = "Folder: " + S;
                My.MyProject.Forms.frmMain.SB2.Refresh();
                System.Windows.Forms.Application.DoEvents();
                if (Strings.InStr(S, "subfldr", CompareMethod.Text) > 0)
                {
                    if (Strings.InStr(S, Conversions.ToString('þ'), CompareMethod.Text) > 0)
                    {
                        var A = S.Split('þ');
                        var B = S.Split(':');
                        if (Information.UBound(A) > 0)
                        {
                            if (A[1].Trim() != null)
                            {
                                if (Information.IsNumeric(A[1]))
                                {
                                    int iLoc = (int)Conversion.Val(A[1]);
                                    if (KeysToProcess.IndexOfKey(iLoc) >= 0)
                                    {
                                    }
                                    else
                                    {
                                        KeysToProcess.Add(iLoc, iLoc.ToString());
                                    }

                                    if (FolderNames.IndexOfKey(iLoc) >= 0)
                                    {
                                        LOG.WriteToArchiveLog("PST Exception - IndexOfKey 1001: " + OwnerFolder + "|" + B[1]);
                                    }
                                    else
                                    {
                                        try
                                        {
                                            FolderNames.Add(iLoc, OwnerFolder + "|" + B[1]);
                                        }
                                        catch (System.Exception ex)
                                        {
                                            LOG.WriteToArchiveLog("PST Exception - IndexOfKey 2001: " + OwnerFolder + "|" + B[1]);
                                        }
                                    }

                                    if (Strings.InStr(B[3], Conversions.ToString('þ')) > 0)
                                    {
                                        int II = Strings.InStr(B[3], Conversions.ToString('þ'));
                                        B[3] = Strings.Mid(B[3], 1, II - 1);
                                        B[3] = B[3].Trim();
                                    }

                                    if (FolderItemCount.IndexOfKey(iLoc) >= 0)
                                    {
                                    }
                                    else
                                    {
                                        FolderItemCount.Add(iLoc, Conversion.Val(B[3]).ToString());
                                    }

                                    if (Owner.IndexOfKey((int)Conversion.Val(A[1])) >= 0)
                                    {
                                        try
                                        {
                                            OwnerFolder = Owner[(int)Conversion.Val(A[1])];
                                        }
                                        catch (System.Exception ex)
                                        {
                                            LOG.WriteToArchiveLog("OwnerFolder  200: " + ex.Message);
                                        }
                                    }

                                    Console.WriteLine("Processing Folder: " + OwnerFolder + " | " + B[1] + ", Emails = " + B[3] + ", Key = " + A[1] + ".");
                                }
                            }
                        }
                    }
                }
            }

            var ARCH = new clsArchiver();
            Folder CurrFolder;
            int iKey = -1;

            // ************************************************************************
            // Dim oEcmHistFolder As Outlook.MAPIFolder = Nothing
            // Dim FolderFound As Boolean = False
            // For Each oFolder In oParentFolder.Folders
            // If oFolder.Name.ToUpper.Equals("ECM_HISTORY") Then
            // oEcmHistFolder = oFolder
            // FolderFound = True
            // End If
            // Next
            // If FolderFound = False Then
            // messagebox.show("Create folder here")
            // End If

            for (int i = 0, loopTo1 = frmPstLoader.FoldersToProcess.Count() - 1; i <= loopTo1; i++)
            {
                // .Text = i.ToString
                // FrmMDIMain.SB.Text = "PST Folder# " + i.ToString
                System.Windows.Forms.Application.DoEvents();
                CurrFolder = (Folder)frmPstLoader.FoldersToProcess[i].oFolder;
                iKey = frmPstLoader.FoldersToProcess[i].iKey;
                int II = 0;
                if (KeysToProcess.IndexOfKey(iKey) >= 0)
                {
                    II += 1;
                    // FrmMDIMain.SB.Text = "PST Folder# " + i.ToString + " : " + "inserts - " + II.ToString
                    My.MyProject.Forms.frmMain.SB.Text = "PST Folder# " + i.ToString() + " : " + "inserts - " + II.ToString();
                    My.MyProject.Forms.frmMain.SB.Refresh();
                    My.MyProject.Forms.frmPstLoader.SB.Text = "PST Folder# " + i.ToString() + " : " + "inserts - " + II.ToString();
                    My.MyProject.Forms.frmPstLoader.SB.Refresh();
                    System.Windows.Forms.Application.DoEvents();
                    string DisplayName = CurrFolder.Store.DisplayName;
                    Folder ParentFldr;
                    ParentFldr = (Folder)CurrFolder.Parent;
                    string PID = ParentFldr.EntryID;
                    ParentFldr = null;
                    My.MyProject.Forms.frmMain.SB.Text = "PST Folder: " + DisplayName + i.ToString() + " : " + "inserts - " + II.ToString();
                    int CurrentKey = Conversions.ToInteger(KeysToProcess[iKey]);
                    var A = FolderNames[iKey].Trim().Split('|');
                    My.MyProject.Forms.frmPstLoader.SB.Text = FolderNames[iKey].Trim();
                    My.MyProject.Forms.frmPstLoader.SB.Refresh();
                    System.Windows.Forms.Application.DoEvents();
                    string NewName = "";
                    if (Information.UBound(A) == 1)
                    {
                        NewName = A[0].Trim() + "|" + A[1].Trim();
                    }
                    else
                    {
                        NewName = FolderNames[iKey].Trim();
                    }

                    string CurrentFolderName = NewName;
                    int NbrOfItemsToProcess = Conversions.ToInteger(FolderItemCount[iKey]);
                    string StoreName = DisplayName;
                    // If NbrOfItemsToProcess = 0 Then
                    // GoTo NEXTONE
                    // End If

                    // ** Process this folder.
                    My.MyProject.Forms.frmPstLoader.SB.Text = StoreName + " : " + CurrFolder.Name + " - " + (i + 1).ToString() + " of " + CurrFolder.Items.Count.ToString();
                    My.MyProject.Forms.frmPstLoader.SB.Refresh();
                    System.Windows.Forms.Application.DoEvents();
                    LOG.WriteToArchiveLog("PST 300: " + StoreName + " : " + CurrFolder.Name + " - " + (i + 1).ToString() + " of " + CurrFolder.Items.Count.ToString());
                    string StoreID = CurrFolder.StoreID.ToString();
                    string TopFolderName = "PST: <" + PstFQN + "> : " + StoreName;
                    string ParentFolderID = PID;
                    string FolderKeyName = CurrentFolderName;
                    string FID = CurrFolder.EntryID;

                    // *************************************************************************************************************
                    ARCH.AddPstFolder(StoreID, TopFolderName, ParentFolderID, FolderKeyName, FID, PstFQN, RetentionCode);
                    // *************************************************************************************************************

                    string ArchiveEmails = "Y";
                    string RemoveAfterArchive = "N";
                    string SetAsDefaultFolder = "N";
                    string ArchiveAfterXDays = "";
                    string RemoveAfterXDays = "";
                    string RemoveXDays = "";
                    string ArchiveXDays = "";
                    bool DeleteFile = false;

                    // *************************************************************************************************************
                    DBLocal.setOutlookMissing();
                    ARCH.EmailLibrary = Library;
                    ARCH.ArchiveEmailsInFolder(UID, TopFolderName, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, CurrFolder, StoreID, ArchiveOnlyIfRead, RetentionYears, RetentionCode, FolderKeyName, slStoreId, isPublic);
                    // *************************************************************************************************************
                }

                NEXTONE:
                ;
            }
            // ************************************************************************

            ARCH = null;
        }
    }
}
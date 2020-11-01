/* TODO ERROR: Skipped DefineDirectiveTrivia */// ** This constant, EnableSingleSource, currently DISABLES the
// ** Single Source capability until we can figure out exactly
// ** how to incorporate it into a search.

// #Const Office2007 = 0f
// Imports Microsoft.Office.Interop.Outlook.ApplicationClass
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using global::System.Data.SqlClient;
using global::System.Diagnostics;
using System.Drawing;
using global::System.IO;
using System.Linq;
using global::System.Reflection;
using System.Runtime.InteropServices;
using global::System.Threading;
using System.Windows.Forms;
using global::ECMEncryption;
using Outlook = Microsoft.Office.Interop.Outlook;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{

    /// <summary>
/// This service runs in background and archives selected emails to a common archive database. The
/// database is a SQL Server DBARCH and allows for full text search of archived emails.
/// </summary>
/// <remarks></remarks>
    public class clsArchiver : clsDatabaseARCH
    {
        private ECMEncrypt ENC = new ECMEncrypt();
        private clsIsolatedStorage ISO = new clsIsolatedStorage();
        private clsRSS RSS = new clsRSS();
        private clsLogging LOG = new clsLogging();
        private clsCompression COMP = new clsCompression();
        private clsUtility UTIL = new clsUtility();
        private clsGlobalEntity GE = new clsGlobalEntity();
        private string WorkingDir = System.Configuration.ConfigurationManager.AppSettings["WEBProcessingDir"];

        // **WDM Dim PDF As New clsPdfAnalyzer
        // Dim Proxy As New SVCCLCArchive.Service1Client

        private clsDbLocal DBLocal = new clsDbLocal();
        public string EmailLibrary = "";
        private bool bAddThisFileAsNewVersion = false;
        private SortedList<string, string> ChildFoldersList = new SortedList<string, string>();
        private int TotalFilesArchived = 0;

        [DllImport("shell32.dll", EntryPoint = "ShellExecuteA")]
        private static extern long ShellExecute(long hwnd, string lpOperation, string lpFile, string lpParameters, string lpDirectory, long nShowCmd);

        public bool xDebug = false;

        [DllImport("user32")]
        private static extern long GetDesktopWindow();

        public ArrayList IncludedTypes = new ArrayList();
        public ArrayList ExcludedTypes = new ArrayList();
        public ArrayList ZipFiles = new ArrayList();
        private int FilesBackedUp = 0;
        private int FilesSkipped = 0;
        private clsMP3 MP3 = new clsMP3();
        private clsDataGrid DGV = new clsDataGrid();

        // Dim KAT As New clsChilKat
        // Create Outlook application.
        // Dim xDebug As Boolean = False
        private clsEMAILFOLDER EMF = new clsEMAILFOLDER();
        private clsEMAILTODELETE EM2D = new clsEMAILTODELETE();
        private string FQN = "YourPath";
        private int folderCount, fileCount;
        private clsATTACHMENTTYPE ATYPE = new clsATTACHMENTTYPE();
        private clsQUICKDIRECTORY QDIR = new clsQUICKDIRECTORY();
        private clsAVAILFILETYPESUNDEFINED UNASGND = new clsAVAILFILETYPESUNDEFINED();
        private clsSOURCEATTRIBUTE SRCATTR = new clsSOURCEATTRIBUTE();
        private clsZipFiles ZF = new clsZipFiles();
        // Dim DBARCH As New clsDatabaseARCH

        private bool bParseDir = false;
        private string DirToParse = "";

        // Dim Redeem As New clsRedeem
        private string ParseArchiveFolder = "";
        private string ArchiveSentMail = "";
        private string ArchiveInbox = "";
        private int MaxDaysBeforeArchive = 0;
        private clsEMAIL EMAIL = new clsEMAIL();
        private clsRECIPIENTS RECIPS = new clsRECIPIENTS();
        private clsDma DMA = new clsDma();
        private clsCONTACTSARCHIVE CNTCT = new clsCONTACTSARCHIVE();
        private SortedList SL = new SortedList();
        private SortedList SL2 = new SortedList();
        public Outlook.NameSpace g_nspNameSpace;
        public Outlook.Application g_olApp;
        private string OcrTextBack = "";
        private string OcrText = "";

        public clsArchiver()
        {
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
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            foreach (string sKey in CFL.Keys)
                ChildFoldersList.Add(sKey, sKey);
        }

        // Public Sub xArchiveStart(ByVal T As Timer)
        // ' Add code here to start your service. This method should set things
        // ' in motion so your service can do its work.

        // '** Get the polling interval Dim PollingInterval As Integer =
        // Val(System.Configuration.ConfigurationManager.AppSettings("PollIntervalMinutes")) '** Convert
        // the MINUTES to Milliseconds. T.Interval = PollingInterval * 60000

        // End Sub
        public bool RestoreFolderExists(Outlook.MAPIFolder CurrFolder)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string FolderKeyName = "";
            // Dim SubFolder As Outlook.MAPIFolder = olfolder
            int II = CurrFolder.Items.Count;
            int JJ = CurrFolder.Folders.Count;
            if (JJ > 0)
            {
                if (xDebug)
                    LOG.WriteToArchiveLog(CurrFolder.Name);
                if (xDebug)
                    LOG.WriteToArchiveLog(CurrFolder.Items.Count.ToString());
                if (xDebug)
                    LOG.WriteToArchiveLog(CurrFolder.Folders.Count.ToString());
                // FolderKeyName  = FolderKeyName  + CurrFolder.Name
                FolderKeyName = CurrFolder.Name;
                for (int I = 1, loopTo = JJ; I <= loopTo; I++)
                {
                    var tFolder = CurrFolder.Folders[I];
                    if (FolderKeyName.Equals(tFolder.Name))
                    {
                        return true;
                    }
                }
                // ProcessAllFolders(CurrFolder)
            }

            return false;
        }

        public void ProcessAllFolders(string UID, string TopFolderName, Outlook.MAPIFolder CurrFolder, bool DeleteFile, string ArchiveEmails, string RemoveAfterArchive, string SetAsDefaultFolder, string ArchiveAfterXDays, string RemoveAfterXDays, string RemoveXDays, string ArchiveXDays, string DB_ID, string UserID, string ArchiveOnlyIfRead, int RetentionYears, string RetentionCode, bool ProcessingPstFile, string PstFQN, string ParentFolderID, SortedList slStoreId, string ispublic)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            };
#error Cannot convert LocalDeclarationStatementSyntax - see comment for details
            /* Cannot convert LocalDeclarationStatementSyntax, System.NotSupportedException: StaticKeyword not supported!
               at ICSharpCode.CodeConverter.CSharp.SyntaxKindExtensions.ConvertToken(SyntaxKind t, TokenContext context)
               at ICSharpCode.CodeConverter.CSharp.CommonConversions.ConvertModifier(SyntaxToken m, TokenContext context)
               at ICSharpCode.CodeConverter.CSharp.CommonConversions.<ConvertModifiersCore>d__43.MoveNext()
               at System.Linq.Enumerable.<ConcatIterator>d__59`1.MoveNext()
               at System.Linq.Enumerable.WhereEnumerableIterator`1.MoveNext()
               at System.Linq.Buffer`1..ctor(IEnumerable`1 source)
               at System.Linq.OrderedEnumerable`1.<GetEnumerator>d__1.MoveNext()
               at Microsoft.CodeAnalysis.SyntaxTokenList.CreateNode(IEnumerable`1 tokens)
               at ICSharpCode.CodeConverter.CSharp.CommonConversions.ConvertModifiers(SyntaxNode node, IReadOnlyCollection`1 modifiers, TokenContext context, Boolean isVariableOrConst, SyntaxKind[] extraCsModifierKinds)
               at ICSharpCode.CodeConverter.CSharp.MethodBodyExecutableStatementVisitor.<VisitLocalDeclarationStatement>d__31.MoveNext()
            --- End of stack trace from previous location where exception was thrown ---
               at ICSharpCode.CodeConverter.CSharp.HoistedNodeStateVisitor.<AddLocalVariablesAsync>d__6.MoveNext()
            --- End of stack trace from previous location where exception was thrown ---
               at ICSharpCode.CodeConverter.CSharp.CommentConvertingMethodBodyVisitor.<DefaultVisitInnerAsync>d__3.MoveNext()

            Input:

                    Static FolderKeyName As String

             */
            string StoreID = CurrFolder.StoreID;

            // Dim SubFolder As Outlook.MAPIFolder = olfolder
            int II = CurrFolder.Items.Count;
            int JJ = CurrFolder.Folders.Count;

            // Dim oApp As New Outlook.Application
            // Dim oNS As Outlook.NameSpace = oApp.GetNamespace("mapi")
            // Dim oTgtFolder As Outlook.MAPIFolder = oNS.Folders("Personal Folder").

            if (JJ > 0)
            {
                if (xDebug)
                    LOG.WriteToArchiveLog(CurrFolder.Name);
                if (xDebug)
                    LOG.WriteToArchiveLog(CurrFolder.FolderPath);
                GetFolderByPath(CurrFolder.FolderPath.ToString());
                if (xDebug)
                    LOG.WriteToArchiveLog(CurrFolder.Items.Count.ToString());
                if (xDebug)
                    LOG.WriteToArchiveLog(CurrFolder.Folders.Count.ToString());
                // FolderKeyName  = FolderKeyName  + CurrFolder.Name
                FolderKeyName = CurrFolder.Name;
                for (int I = 1, loopTo = JJ; I <= loopTo; I++)
                {
                    var tFolder = CurrFolder.Folders[I];
                    string FID = tFolder.EntryID;
                    FolderKeyName = TopFolderName + "|" + tFolder.Name;
                    int BB = this.ckArchEmailFolder(FolderKeyName, UserID);
                    if (BB == 0)
                    {
                        return;
                    }

                    if (xDebug)
                        LOG.WriteToArchiveLog(FolderKeyName);
                    ProcessAllFolders(UID, TopFolderName, tFolder, DeleteFile, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, UserID, ArchiveOnlyIfRead, RetentionYears, RetentionCode, ProcessingPstFile, PstFQN, ParentFolderID, slStoreId, ispublic);
                }
            }
            // ProcessAllFolders(CurrFolder)
            else
            {
                if (xDebug)
                    LOG.WriteToArchiveLog(CurrFolder.Name);
                if (xDebug)
                    LOG.WriteToArchiveLog(CurrFolder.FolderPath);
                // GetFolderByPath(CurrFolder.FolderPath.ToString)
                if (xDebug)
                    LOG.WriteToArchiveLog(CurrFolder.Items.Count.ToString());
                FolderKeyName = CurrFolder.Name;
                if (xDebug)
                    LOG.WriteToArchiveLog(FolderKeyName);
                string FID = CurrFolder.EntryID;
                int BB = this.ckArchEmailFolder(FolderKeyName, UserID);
                if (BB == 0)
                {
                    return;
                }

                this.AddPstFolder(StoreID, TopFolderName, ParentFolderID, FolderKeyName, FID, PstFQN, RetentionCode);
                DBLocal.setOutlookMissing();
                this.ArchiveEmailsInFolder(UID, TopFolderName, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, CurrFolder, StoreID, ArchiveOnlyIfRead, RetentionYears, RetentionCode, FolderKeyName, slStoreId, ispublic);
            }
        }

        public void ProcessAllFolderSenders(string UID, string FolderName, Outlook.MAPIFolder CurrFolder, bool DeleteFile, string ArchiveEmails, string RemoveAfterArchive, string SetAsDefaultFolder, string ArchiveAfterXDays, string RemoveAfterXDays, string RemoveXDays, string ArchiveXDays, string FileDirectory)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Outlook.MAPIFolder tFolder = null;
            ;
            // Dim SubFolder As Outlook.MAPIFolder = olfolder
            int II = CurrFolder.Items.Count;
            int CountOfSubfolders = CurrFolder.Folders.Count;
            bool ParentAlreadyProcessed = false;
            bool B = false;
            if (xDebug)
                LOG.WriteToArchiveLog("Parent Folder: " + FolderName);
            if (xDebug)
                LOG.WriteToArchiveLog(CurrFolder.Name);
            if (CountOfSubfolders == 0)
            {
                if (xDebug)
                    LOG.WriteToArchiveLog("CurrFolder.Items.Count: " + CurrFolder.Items.Count.ToString());
                FolderKeyName = CurrFolder.Name;
                B = this.ckFolderExists(modGlobals.gCurrUserGuidID, FolderKeyName, FileDirectory);
                if (B)
                {
                    if (xDebug)
                    {
                        if (xDebug)
                            LOG.WriteToArchiveLog("Processing Folder: " + FolderKeyName);
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
                        LOG.WriteToArchiveLog("Parent SUBFolder: " + FolderName);
                }

                return;
            }

            if (CountOfSubfolders > 0)
            {
                if (xDebug)
                    LOG.WriteToArchiveLog(CurrFolder.Name);
                if (xDebug)
                    LOG.WriteToArchiveLog(CurrFolder.Items.Count.ToString());
                if (xDebug)
                    LOG.WriteToArchiveLog(CurrFolder.Folders.Count.ToString());
                // FolderKeyName  = FolderKeyName  + CurrFolder.Name
                // Dim tFolderKeyName  = CurrFolder.Name
                B = this.ckFolderExists(modGlobals.gCurrUserGuidID, FolderKeyName, FileDirectory);
                if (B)
                {
                    for (int I = 1, loopTo = CountOfSubfolders; I <= loopTo; I++)
                    {
                        tFolder = CurrFolder.Folders[I];
                        int FolderID = Conversions.ToInteger(CurrFolder.EntryID);
                        if (xDebug)
                            LOG.WriteToArchiveLog("FolderID = " + CurrFolder.EntryID);
                        FolderKeyName = FolderKeyName + "->" + tFolder.Name;
                        if (xDebug)
                            LOG.WriteToArchiveLog("Location clsArchiver:ProcessAllFolderSenders 0011: '" + tFolder.Name + "'.");
                        if (FolderKeyName.Equals(FolderName))
                        {
                            if (xDebug)
                                LOG.WriteToArchiveLog(FolderKeyName);
                            B = this.ckFolderExists(modGlobals.gCurrUserGuidID, FolderKeyName, FileDirectory);
                            if (B)
                            {
                                ProcessAllFolderSenders(UID, FolderName, tFolder, DeleteFile, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, FileDirectory);
                            }
                        }
                        else if (xDebug)
                            LOG.WriteToArchiveLog("Skipping folder: " + FolderKeyName);
                    }
                }
            }
            else if (!ParentAlreadyProcessed)
            {
                if (xDebug)
                    LOG.WriteToArchiveLog(CurrFolder.Name);
                if (xDebug)
                    LOG.WriteToArchiveLog(CurrFolder.Items.Count.ToString());
                FolderKeyName = CurrFolder.Name;
                if (FolderKeyName.Equals(FolderName))
                {
                    B = this.ckFolderExists(modGlobals.gCurrUserGuidID, FolderKeyName, FileDirectory);
                    if (B)
                    {
                        if (xDebug)
                            LOG.WriteToArchiveLog("Processing Folder: " + FolderKeyName);
                        ArchiveEmailsInFolderenders(ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, CurrFolder, DeleteFile);
                    }
                }
                else if (xDebug)
                    LOG.WriteToArchiveLog("Skipping folder: " + FolderKeyName);
            }
        }

        public void getSubFolderEmails(string UID, string TopFolderName, string MailboxName, string FolderName, bool DeleteFile, string ArchiveEmails, string RemoveAfterArchive, string SetAsDefaultFolder, string ArchiveAfterXDays, string RemoveAfterXDays, string RemoveXDays, string ArchiveXDays, string DB_ID, string UserID, string ArchiveOnlyIfRead, string FilterDate, int RetentionYears, string RetentionCode, bool ProcessPstFile, string PstFQN, string ParentFolderID, SortedList slStoreId)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var oApp = new Outlook.Application();
            string sBuild = Strings.Left(oApp.Version, Strings.InStr(1, oApp.Version, ".") + 1);
            var oNS = oApp.GetNamespace("mapi");

            // ******************
            string isPublic = "N";
            try
            {
                // Now that we have the MAPI namespace, we can log on using using:
                // <mapinamespace>.Logon(object Profile, object Password, object ShowDialog, object NewSession)
                // Profile: This is a string value that indicates what MAPI profile to use for logging on.
                // Set this to null if using the currently logged on user, or set to an empty string ("")
                // if you wish to use the default Outlook Profile.
                // Password: The password for the indicated profile. Set to null if using the currently
                // logged on user, or set to an empty string ("") if you wish to use the default Outlook Profile password.
                // ShowDialog: Set to True to display the Outlook Profile dialog box.

                // oNS.Logon("OUTLOOK", Missing.Value, True, True)
                oNS.Logon(Missing.Value, Missing.Value, true, true);

                // Dim oMAPI As Outlook._NameSpace
                Outlook.MAPIFolder oParentFolder;

                // Dim FLDR As Outlook.Folder
                // For Each FLDR In oParentFolder.Folders
                // if xDebug then log.WriteToArchiveLog(FLDR.Name)
                // Next

                // Get Messages collection of Inbox.

                oParentFolder = oNS.Folders[MailboxName];
                Outlook.MAPIFolder SFolder = null;
                foreach (Outlook.MAPIFolder SubFolder in oParentFolder.Folders)
                    ProcessAllFolders(UID, TopFolderName, SubFolder, DeleteFile, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, UserID, ArchiveOnlyIfRead, RetentionYears, RetentionCode, false, "", ParentFolderID, slStoreId, isPublic);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            finally
            {
                // In any case please remember to turn on Outlook Security after your code, since now it is very easy to switch it off! :-)
                // SecurityManager.DisableOOMWarnings = False
                oApp = null;
                oNS = null;
                GC.Collect();
            }
        }

        public void getSubFolderEmailsSenders(string UID, string MailboxName, string FolderName, bool DeleteFile, string ArchiveEmails, string RemoveAfterArchive, string SetAsDefaultFolder, string ArchiveAfterXDays, string RemoveAfterXDays, string RemoveXDays, string ArchiveXDays, string FileDirectory)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            int LL = 0;
            LL = 1784;
            var oApp = new Outlook.Application();
            LL = 1785;
            string sBuild = Strings.Left(oApp.Version, Strings.InStr(1, oApp.Version, ".") + 1);
            LL = 1786;
            LL = 1787;
            var oNS = oApp.GetNamespace("mapi");
            LL = 6;
            try
            {
                LL = 7;
                // Now that we have the MAPI namespace, we can log on using using:
                LL = 8;
                // <mapinamespace>.Logon(object Profile, object Password, object ShowDialog, object NewSession)
                LL = 9;
                // Profile: This is a string value that indicates what MAPI profile to use for logging on.
                LL = 10;
                // Set this to null if using the currently logged on user, or set to an empty string ("")
                LL = 11;
                // if you wish to use the default Outlook Profile.
                LL = 12;
                // Password: The password for the indicated profile. Set to null if using the currently
                LL = 13;
                // logged on user, or set to an empty string ("") if you wish to use the default Outlook
                // Profile password.
                LL = 14;
                // ShowDialog: Set to True to display the Outlook Profile dialog box.
                LL = 15;
                LL = 16;
                // oNS.Logon("OUTLOOK", Missing.Value, True, True)
                LL = 17;
                oNS.Logon(Missing.Value, Missing.Value, true, true);
                LL = 18;
                LL = 19;
                // Dim oMAPI As Outlook._NameSpace
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
                        LOG.WriteToArchiveLog("Folder Name: " + OutlookFolders.Name);
                    LL = 32;
                    if (xDebug)
                        LOG.WriteToArchiveLog("Folder Name: " + FolderName);
                    LL = 33;
                    if (xDebug)
                        LOG.WriteToArchiveLog("Folder  : " + Folder.Name);
                    LL = 34;
                    LL = 35;
                    GetFolderByPath(Folder.FolderPath);
                    LL = 36;
                    LL = 37;
                    if (xDebug)
                        LOG.WriteToArchiveLog("Folder Items# : " + Folder.Items.Count);
                    LL = 38;
                    if (xDebug)
                        LOG.WriteToArchiveLog("Folder# : " + Folder.Folders.Count);
                    LL = 39;
                    if (xDebug)
                        LOG.WriteToArchiveLog("_____________");
                    LL = 40;
                    // If FolderName .Equals(Folder.Name) Then
                    LL = 41;
                    ProcessAllFolderSenders(UID, FolderName, Folder, DeleteFile, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, FileDirectory);
                    LL = 48;
                    // End If
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
                // In any case please remember to turn on Outlook Security after your code, since now it
                // is very easy to switch it off! :-)
                LL = 56;
                // SecurityManager.DisableOOMWarnings = False
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
                LOG.WriteToArchiveLog("Exiting...");
            LL = 62;
        }

        public void ArchiveEmailsInFolder(string UID, string TopFolder, string ArchiveEmails, string RemoveAfterArchive, string SetAsDefaultFolder, string ArchiveAfterXDays, string RemoveAfterXDays, string RemoveXDays, string ArchiveXDays, string DB_ID, Outlook.MAPIFolder CurrOutlookSubFolder, string StoreID, string ArchiveOnlyIfRead, int RetentionYears, string RetentionCode, string tgtFolderName, SortedList slStoreId, string isPublic)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            int StackLevel = 0;
            var ListOfFiles = new Dictionary<string, int>();
            int ID = 5555;
            int PauseThreadMS = 0;
            try
            {
                PauseThreadMS = Conversions.ToInteger(getUserParm("UserContent_Pause"));
            }
            catch (Exception ex)
            {
                PauseThreadMS = 0;
            }

            double LL = 459d;
            string EmailIdentifier = "";
            string Subject = "";
            LL = 464d;
            LL = 465d;
            string LastEmailArchRunDate = UserParmRetrive("LastEmailArchRunDate", modGlobals.gCurrUserGuidID);
            LL = 466d;
            if (LastEmailArchRunDate.Trim().Length == 0)
            {
                LL = 467d;
                LastEmailArchRunDate = "1/1/1950";
                LL = 468d;
            }

            LL = 469d;
            My.MyProject.Forms.frmMain.SB2.Text = "Last Email Archive run date was " + LastEmailArchRunDate;
            LL = 470d;
            string UseLastFilterDate = UserParmRetrive("ckUseLastProcessDateAsCutoff", modGlobals.gCurrUserGuidID);
            LL = 471d;
            bool bUseCutOffDate = false;
            LL = 472d;
            DateTime CutOffDate = default;
            LL = 473d;
            LL = 474d;
            if (UseLastFilterDate.ToUpper().Equals("TRUE"))
            {
                LL = 475d;
                bUseCutOffDate = true;
                LL = 476d;
            }
            else
            {
                LL = 477d;
                bUseCutOffDate = false;
                LL = 478d;
            }

            LL = 479d;
            var rightNow = DateAndTime.Now;
            LL = 481d;
            if (RetentionYears == 0)
            {
                LL = 482d;
                RetentionYears = (int)Conversion.Val(getSystemParm("RETENTION YEARS"));
                LL = 483d;
            }

            LL = 484d;
            rightNow = rightNow.AddYears(RetentionYears);
            LL = 485d;
            LL = 486d;
            string RetentionExpirationDate = rightNow.ToString();
            LL = 487d;
            LL = 488d;
            bool bMoveIt = true;
            LL = 489d;
            LL = 490d;
            var oApp = new Outlook.Application();
            LL = 491d;
            var oNS = oApp.GetNamespace("MAPI");
            LL = 492d;
            LL = 493d;
            // ** Set up so that deleted items can be moved into the deleted items folder.
            LL = 494d;
            var oDeletedItems = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderDeletedItems);
            LL = 495d;
            LL = 496d;
            bool DeleteMsg = false;
            LL = 497d;
            var CurrDateTime = DateAndTime.Now;
            LL = 498d;
            int ArchiveAge = 0;
            LL = 499d;
            int RemoveAge = 0;
            LL = 500d;
            int XDaysArchive = 0;
            LL = 501d;
            int XDaysRemove = 0;
            LL = 502d;
            string CurrMailFolderID = CurrOutlookSubFolder.EntryID;
            LL = 503d;
            string EmailFQN = "";
            LL = 504d;
            bool bRemoveAfterArchive = false;
            LL = 505d;
            bool bMsgUnopened = false;
            LL = 506d;
            string CurrMailFolderName = "";
            LL = 507d;
            DateTime MinProcessDate = Conversions.ToDate("01/1/1910");
            LL = 508d;
            string CurrName = CurrOutlookSubFolder.Name;
            LL = 509d;
            string ArchiveMsg = CurrName + ": ";
            LL = 510d;
            LL = 511d;
            // Console.WriteLine("Archiving CurrName  = " + CurrName )
            LL = 512d;
            // Console.WriteLine("Should be Archiving CurrName  = " + tgtFolderName)
            LL = 513d;
            LL = 514d;
            // ** WDM REMOVE THIS SECTION OF CODE AFTER ONE RUN
            LL = 515d;
            string EmailFolderFQN = TopFolder + "|" + CurrName;
            LL = 516d;
            LL = 517d;
            EmailFolderFQN = UTIL.RemoveSingleQuotes(EmailFolderFQN);
            LL = 518d;
            LL = 519d;
            if (tgtFolderName.Length > 0)
            {
                LL = 520d;
                EmailFolderFQN = tgtFolderName;
                LL = 521d;
            }
            else
            {
                LL = 522d;
                EmailFolderFQN = TopFolder + "|" + CurrName;
                LL = 523d;
            }

            LL = 524d;
            LL = 525d;
            if (xDebug)
                LOG.WriteToArchiveLog("ArchiveEmailsInFolder 100 EmailFolderFQN: " + EmailFolderFQN);
            LL = 526d;
            LL = 527d;
            bool RunThisCode = false;
            LL = 528d;
            if (RunThisCode)
            {
                LL = 529d;
                LL = 530d;
                string S = "Update EMAIL set CurrMailFolderID = '" + CurrMailFolderID + "' where OriginalFolder = '" + EmailFolderFQN + "' and CurrMailFolderID is null ";
                LL = 531d;
                bool bExec = ExecuteSqlNewConn(S, false);
                LL = 532d;
                if (!bExec)
                {
                    LL = 533d;
                    LOG.WriteToArchiveLog("ERROR: 1234.99");
                    LL = 534d;
                }

                LL = 535d;
            }

            LL = 537d;
            bool bUseQuickSearch = false;
            LL = 538d;
            // Dim NbrOfIds As Integer = getCountStoreIdByFolder()
            LL = 539d;
            if (slStoreId.Count > 0)
            {
                bUseQuickSearch = true;
            }
            else
            {
                bUseQuickSearch = false;
            }

            LL = 550d;
            if (ArchiveEmails.Length == 0)
            {
                LL = 551d;
                My.MyProject.Forms.frmNotify2.Close();
                return;
                LL = 552d;
            }

            LL = 553d;
            string DB_ConnectionString = "";
            LL = 554d;
            LL = 555d;
            if (ArchiveEmails.Equals("N") & ArchiveAfterXDays.Equals("N") & RemoveAfterArchive.Equals("N"))
            {
                LL = 556d;
                // ** Then this folder really should not be in the list
                LL = 557d;
                My.MyProject.Forms.frmNotify2.Close();
                return;
                LL = 558d;
            }

            LL = 559d;
            if (RemoveAfterArchive.Equals("Y"))
            {
                LL = 560d;
                DeleteMsg = true;
                LL = 561d;
                bRemoveAfterArchive = true;
                LL = 562d;
            }

            LL = 563d;
            if (Information.IsNumeric(RemoveXDays))
            {
                LL = 564d;
                XDaysRemove = (int)Conversion.Val(RemoveXDays);
                LL = 565d;
            }

            LL = 566d;
            if (Information.IsNumeric(ArchiveXDays))
            {
                LL = 567d;
                XDaysArchive = (int)Conversion.Val(ArchiveXDays);
                LL = 568d;
            }

            LL = 569d;
            LL = 570d;
            try
            {
                LL = 571d;
                SL.Clear();
                LL = 572d;
                SL2.Clear();
                LL = 573d;
                Outlook.Items oItems;
                LL = 574d;
                LL = 575d;
                if (bUseCutOffDate == false)
                {
                    LL = 576d;
                    if (xDebug)
                        LOG.WriteToArchiveLog("ArchiveEmailsInFolder 200: " + EmailFolderFQN);
                    LL = 577d;
                    oItems = CurrOutlookSubFolder.Items;
                    LL = 578d;
                }
                else
                {
                    LL = 579d;
                    if (xDebug)
                        LOG.WriteToArchiveLog("ArchiveEmailsInFolder 300: " + EmailFolderFQN);
                    LL = 580d;
                    oItems = CurrOutlookSubFolder.Items;
                    LL = 581d;
                }

                LL = 619d;
                // Console.WriteLine("Total for: " & CurrOutlookSubFolder.Name & " : " & oItems.Count)
                LL = 620d;
                CurrMailFolderName = CurrOutlookSubFolder.Name;
                LL = 621d;
                LL = 622d;
                My.MyProject.Forms.frmPstLoader.SB.Text = CurrMailFolderName;
                // LL = 623
                My.MyProject.Forms.frmPstLoader.SB.Refresh();
                LL = 624d;
                Application.DoEvents();
                LL = 625d;
                LL = 626d;
                if (xDebug)
                    LOG.WriteToArchiveLog("ArchiveEmailsInFolder 400: " + EmailFolderFQN);
                LL = 627d;
                LL = 628d;
                int TotalEmails = oItems.Count;
                LL = 629d;
                My.MyProject.Forms.frmMain.PBx.Maximum = TotalEmails + 1;
                LL = 630d;
                // 'FrmMDIMain.TSPB1.Maximum = TotalEmails + 1
                LL = 631d;
                // Loop each unread message.
                LL = 632d;
                Outlook.MailItem oMsg;
                LL = 633d;
                int i = 0;
                LL = 634d;
                LL = 635d;
                My.MyProject.Forms.frmMain.PBx.Value = 0;
                LL = 636d;
                My.MyProject.Forms.frmMain.PBx.Maximum = oItems.Count + 2;
                LL = 638d;
                if (xDebug)
                    LOG.WriteToArchiveLog("*** 500 Folder " + TopFolder + ":" + CurrMailFolderName + " / Curr Items = " + oItems.Count.ToString());
                LL = 639d;
                LOG.WriteToArchiveLog("Processing " + TotalEmails.ToString() + " emails by " + modGlobals.gCurrLoginID);
                LL = 642d;
                My.MyProject.Forms.frmNotify2.Show();
                My.MyProject.Forms.frmNotify2.lblEmailMsg.Text = "Email: ";
                var loopTo = oItems.Count;
                for (i = 1; i <= loopTo; i++)
                {
                    Application.DoEvents();
                    My.MyProject.Forms.frmNotify2.lblEmailMsg.Text = "Email: " + i.ToString() + " of " + oItems.Count.ToString();
                    My.MyProject.Forms.frmNotify2.Refresh();
                    Application.DoEvents();
                    if (PauseThreadMS > 0)
                    {
                        Thread.Sleep(25);
                    }

                    LL = 643d;
                    try
                    {
                        Application.DoEvents();
                    }
                    catch (Exception ex)
                    {
                        My.MyProject.Forms.frmNotify2.Close();
                        if (modGlobals.gRunMode.Equals("M-END"))
                        {
                            My.MyProject.Forms.frmNotify2.WindowState = FormWindowState.Minimized;
                        }

                        Console.WriteLine(ex.Message);
                    }

                    LL = 644d;
                    if (i % 50 == 0)
                    {
                        ExecuteSqlNewConn(90201, "checkpoint");
                        GC.Collect();
                        GC.WaitForPendingFinalizers();
                        Application.DoEvents();
                    }

                    if (modGlobals.gTerminateImmediately)
                    {
                        LL = 650d;
                        My.MyProject.Forms.frmNotify2.Close();
                        return;
                        LL = 651d;
                    }

                    LL = 652d;
                    EMAIL.setStoreID(ref StoreID);
                    My.MyProject.Forms.frmMain.PBx.Value = i;
                    My.MyProject.Forms.frmMain.PBx.Refresh();
                    Application.DoEvents();
                    Application.DoEvents();
                    try
                    {
                        LL = 662d;
                        string EmailGuid = Guid.NewGuid().ToString();
                        LL = 663d;
                        LL = 664d;
                        string OriginalFolder = TopFolder + "|" + CurrOutlookSubFolder.Name;
                        LL = 665d;
                        string FNAME = CurrOutlookSubFolder.Name;
                        LL = 666d;
                        LL = 667d;
                        // if xDebug then log.WriteToArchiveLog("Message#: " & i)
                        LL = 668d;
                        if (i % 2 == 0)
                        {
                            LL = 669d;
                            My.MyProject.Forms.frmMain.SB.Text = FNAME + ":" + i;
                            LL = 670d;
                            My.MyProject.Forms.frmMain.SB.Refresh();
                            LL = 671d;
                        }

                        LL = 672d;

                        // Test to make sure item is a mail item and not a meeting request.
                        string sClassComp = "IPM.Schedule.Meeting.Request";
                        LL = 672.1d;
                        try
                        {
                            sClassComp = "IPM.Schedule.Meeting.Request";
                            LL = 672.2d;
                        }
                        catch (Exception ex)
                        {
                            LOG.WriteToArchiveLog("ERROR IPM.Schedule.Meeting.Request: " + ex.Message);
                        }
                        // Console.WriteLine(oItems.Item(i).MessageClass.ToString)
                        // Console.WriteLine(oItems.Item(i).MessageClass)
                        try
                        {
                            if (oItems[(object)i].MessageClass.Equals("REPORT.IPM.Note.NDR"))
                            {
                                goto LabelSkipThisEmail2;
                            }
                            else if (oItems[(object)i].MessageClass.Equals("IPM.Schedule.Meeting.Notification.Forward"))
                            {
                                goto LabelSkipThisEmail2;
                            }
                            else if (oItems[(object)i].MessageClass.Equals("IPM.Document.doc_auto_file"))
                            {
                                goto LabelSkipThisEmail2;
                            }
                            else if (oItems[(object)i].MessageClass.Equals("IPM.Post"))
                            {
                                goto LabelSkipThisEmail2;
                            }
                            else if (oItems[(object)i].MessageClass.Equals("IPM.Schedule.Meeting.Request"))
                            {
                                goto LabelSkipThisEmail2;
                            }
                            else if (oItems[(object)i].MessageClass.Equals("IPM.Schedule.Meeting.Resp.Pos"))
                            {
                                goto LabelSkipThisEmail2;
                            }
                            else if (oItems[(object)i].MessageClass.Equals("IPM.Schedule.Meeting.Resp.Neg"))
                            {
                                goto LabelSkipThisEmail2;
                            }
                            // ElseIf oItems.Item(i).MessageClass.Equals("IPM.Note") Then
                            // GoTo LabelSkipThisEmail2
                            else if (oItems[(object)i].MessageClass.Equals("IPM.Note"))
                            {
                            }
                            // ** Good - pass it thru
                            else if (oItems[(object)i].MessageClass.Equals("IPM.Note.SMIME.MultipartSigned"))
                            {
                            }
                            // ** Good - pass it thru
                            else if (oItems[(object)i].MessageClass.Equals("IPM.Schedule.Meeting.Canceled"))
                            {
                            }
                            // ** Good - pass it thru
                            else if (oItems[(object)i].MessageClass.Equals("IPM.Schedule.Meeting.Notification.Forward"))
                            {
                            }
                            // ** Good - pass it thru
                            else if (oItems[(object)i].MessageClass.Equals("IPM.Sharing"))
                            {
                                // ** Good - pass it thru
                                Console.WriteLine(oItems[(object)i].MessageClass);
                                goto LabelSkipThisEmail2;
                            }
                            else if (oItems[(object)i].MessageClass.Equals("IPM.Schedule.Meeting.Resp.Tent"))
                            {
                                // ** Good - pass it thru
                                Console.WriteLine(oItems[(object)i].MessageClass);
                                goto LabelSkipThisEmail2;
                            }
                            else if (oItems[(object)i].MessageClass.Equals("IPM.Post.Rss"))
                            {
                                // ** Good - pass it thru
                                LOG.WriteToArchiveLog("NOTIFICATION - RSS Feeds through Outlook are not currently processed.");
                            }
                            // Dim oRSS As Outlook.PostItem = oApp.CreateItem(Outlook.OlItemType.olPostItem)
                            // oMsg.MessageClass = "IPM.Post.Rss"
                            else
                            {
                                Console.WriteLine(oItems[(object)i].MessageClass.ToString());
                                Console.WriteLine(oItems[(object)i].MessageClass);
                            }

                            if (oItems[(object)i].MessageClass.Equals(sClassComp) | oItems[(object)i].MessageClass.Equals("IPM.Schedule.Meeting.Canceled"))
                            {
                                LL = 674d;
                                string oEntryID = Conversions.ToString(oItems[(object)i].EntryID);
                                LL = 675d;
                                // Dim oStoreID As String = oItems.Item(i).StoreID
                                DateTime MsgDate = Conversions.ToDate(oItems[(object)i].senton);
                                LL = 676d;
                                try
                                {
                                    TimeSpan passed_time;
                                    LL = 677d;
                                    passed_time = CurrDateTime.Subtract(MsgDate);
                                    LL = 678d;
                                    int EmailDays = (int)passed_time.TotalDays;
                                    LL = 679d;
                                    if (RemoveAfterXDays.Equals("Y"))
                                    {
                                        LL = 680d;
                                        if (EmailDays >= XDaysRemove)
                                        {
                                            LL = 681d;
                                            // oItems.Item(i).move(oEcmHistFolder)
                                            // oItems.Item(i).delete()
                                            LL = 681.1d;
                                        }

                                        LL = 682d;
                                        LOG.WriteToArchiveLog("Notification 01 - Item #" + i.ToString() + " in folder " + OriginalFolder + ", is a meeting request and past MOVE date - NOT PROCESSED.");
                                    }
                                    else
                                    {
                                        LL = 683d;
                                        LOG.WriteToArchiveLog("Notification 02 - Item #" + i.ToString() + " in folder " + OriginalFolder + ", is a meeting request and NOT PROCESSED.");
                                    }

                                    LL = 684d;
                                }
                                catch (Exception ex)
                                {
                                    LOG.WriteToArchiveLog("Notification 03 - Item #" + i.ToString() + " in folder " + OriginalFolder + ", is a meeting request and Failed to MOVE to History.");
                                    Console.WriteLine(ex.Message);
                                }

                                goto LabelSkipThisEmail2;
                            }
                        }
                        catch (Exception ex)
                        {
                            LOG.WriteToArchiveLog("ERROR ArchiveEmailsInFolder 100 - Line #" + LL.ToString() + ".");
                            goto LabelSkipThisEmail2;
                        }

                        try
                        {
                            LL = 674d;
                            oMsg = (Outlook.MailItem)oItems[(object)i];
                            LL = 675d;
                        }
                        catch (Exception ex)
                        {
                            LL = 676d;
                            this.LOG.WriteToArchiveLog("ERROR - Item #" + i.ToString() + " in folder " + OriginalFolder + ", failed to open message of type: " + oItems[(object)i].MessageClass.ToString() + ".");
                            LL = 677d;
                            goto LabelSkipThisEmail2;
                            LL = 678d;
                        }

                        LL = 679d;
                        EmailIdentifier = UTIL.genEmailIdentifier(oMsg.CreationTime, oMsg.SenderEmailAddress, Subject);
                        LL = 680d;
                        bool bMailAlreadyUploaded = false;
                        if (bUseQuickSearch == true)
                        {
                            LL = 681d;
                            int IX = slStoreId.IndexOfKey(EmailIdentifier);
                            LL = 682d;
                            if (IX < 0)
                            {
                                // ** The email has NOT been archived, move on...
                                // bMailAlreadyUploaded = DBLocal.addOutlook(EmailIdentifier)
                                // If bMailAlreadyUploaded Then
                                // '** The key already exists, move on
                                // GoTo LabelSkipThisEmail
                                // Else
                                // slStoreId.Add(EmailIdentifier, i)
                                // bMailAlreadyUploaded = False
                                // End If
                                LL = 683d;
                                My.MyProject.Forms.frmMain.SB.Text = "Insert# " + i.ToString();
                                My.MyProject.Forms.frmMain.SB.Refresh();
                                LL = 684d;
                            }
                            else
                            {
                                LL = 685d;
                                My.MyProject.Forms.frmMain.EmailsSkipped += 1;
                                goto LabelSkipThisEmail;
                            }
                        }
                        else
                        {
                            LL = 686d;
                            bMailAlreadyUploaded = DBLocal.OutlookExists(EmailIdentifier);
                            LL = 687d;
                            if (bMailAlreadyUploaded)
                            {
                                LL = 688d;
                                DBLocal.setOutlookKeyFound(EmailIdentifier);
                                LL = 689d;
                                goto LabelSkipThisEmail;
                            }

                            LL = 690d;
                        }

                        LL = 695d;
                        var SentOn = oMsg.SentOn;
                        LL = 696d;
                        var ReceivedTime = oMsg.ReceivedTime;
                        LL = 697d;
                        var CreationTime = oMsg.CreationTime;
                        LL = 699d;
                        if (SentOn == default)
                        {
                            LL = 700d;
                            if (CreationTime != default)
                            {
                                LL = 701d;
                                SentOn = CreationTime;
                                LL = 702d;
                            }
                            else if (ReceivedTime != default)
                            {
                                LL = 703d;
                                SentOn = CreationTime;
                                LL = 704d;
                            }
                            else
                            {
                                LL = 705d;
                                SentOn = DateAndTime.Now;
                                LL = 706d;
                            }

                            LL = 707d;
                        }

                        LL = 708d;
                        if (ReceivedTime == default)
                        {
                            LL = 711d;
                            if (SentOn != default)
                            {
                                LL = 712d;
                                ReceivedTime = SentOn;
                                LL = 713d;
                            }
                            else if (CreationTime != default)
                            {
                                LL = 714d;
                                ReceivedTime = CreationTime;
                                LL = 715d;
                            }
                            else
                            {
                                LL = 716d;
                                ReceivedTime = DateAndTime.Now;
                                LL = 717d;
                            }

                            LL = 718d;
                        }

                        LL = 719d;
                        LL = 720d;
                        if (CreationTime == default)
                        {
                            LL = 721d;
                            if (SentOn != default)
                            {
                                LL = 722d;
                                CreationTime = SentOn;
                                LL = 723d;
                            }
                            else if (ReceivedTime != default)
                            {
                                LL = 724d;
                                CreationTime = ReceivedTime;
                                LL = 725d;
                            }
                            else
                            {
                                LL = 726d;
                                CreationTime = DateAndTime.Now;
                                LL = 727d;
                            }

                            LL = 728d;
                        }

                        LL = 729d;
                        if (CreationTime < DateTime.Parse("1960-01-01"))
                        {
                            LL = 730d;
                            if (SentOn != default)
                            {
                                LL = 731d;
                                CreationTime = SentOn;
                                LL = 732d;
                            }
                            else if (CreationTime != default)
                            {
                                LL = 733d;
                                CreationTime = ReceivedTime;
                                LL = 734d;
                            }
                            else
                            {
                                LL = 735d;
                                CreationTime = DateAndTime.Now;
                                LL = 736d;
                            }

                            LL = 737d;
                        }

                        LL = 740d;
                        if (bUseCutOffDate)
                        {
                            LL = 741d;
                            bool bbb = modGlobals.compareEmailProcessDate(CurrMailFolderName, CreationTime);
                            LL = 742d;
                            if (bbb)
                            {
                                LL = 743d;
                                My.MyProject.Forms.frmMain.EmailsSkipped += 1;
                                LOG.WriteToArchiveLog(ArchiveMsg + " This email past the cutoff date, skipped.");
                                bool BBX = ExchangeEmailExists(EmailIdentifier);
                                TimeSpan passed_time;
                                passed_time = CurrDateTime.Subtract(SentOn);
                                if (BBX)
                                {
                                    int EmailDays = (int)passed_time.TotalDays;
                                    if (RemoveAfterXDays.Equals("Y"))
                                    {
                                        if (EmailDays >= XDaysRemove)
                                        {
                                            MoveToHistoryFolder(oMsg);
                                        }
                                    }
                                }

                                goto LabelSkipThisEmail;
                                LL = 748d;
                                BBX = default;
                                passed_time = default;
                            }

                            LL = 749d;
                        }

                        modGlobals.setLastEmailDate(CurrMailFolderName, CreationTime);
                        bool bIdExists = ExchangeEmailExists(EmailIdentifier);
                        if (bIdExists)
                        {
                            // This email has already been processed, skip it.

                            goto LabelSkipThisEmail;
                        }

                        if (bIdExists)
                        {
                            // ** This sucker already exists, skip it.
                            LL = 757d;
                            if (bRemoveAfterArchive == true)
                            {
                                LL = 758d;
                                if (xDebug)
                                    LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 900: " + EmailFolderFQN);
                                LL = 759d;
                                if (xDebug)
                                    LOG.WriteToArchiveLog(CurrOutlookSubFolder.Name + ": Deleted DUPLICATE email... ");
                                LL = 760d;
                                EM2D.setEmailguid(ref EmailGuid);
                                LL = 761d;
                                EM2D.setStoreid(ref StoreID);
                                LL = 762d;
                                EM2D.setUserid(ref modGlobals.gCurrUserGuidID);
                                LL = 763d;
                                string argval = oMsg.EntryID;
                                EM2D.setMessageid(ref argval);
                                oMsg.EntryID = argval;
                                LL = 764d;
                                if (bMsgUnopened == false & ArchiveOnlyIfRead == "Y")
                                {
                                    LL = 765d;
                                    EM2D.Insert();
                                    LL = 766d;
                                    // log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #100")
                                    LL = 767d;
                                }
                                else if (ArchiveOnlyIfRead == "N")
                                {
                                    LL = 768d;
                                    // log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #101")
                                    LL = 769d;
                                    EM2D.Insert();
                                    LL = 770d;
                                }
                                else
                                {
                                    LL = 771d;
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("No match ... ");
                                    LL = 772d;
                                }

                                LL = 773d;
                                LL = 774d;
                            }

                            LL = 775d;
                            // GoTo LabelSkipThisEmail2
                            LL = 776d;
                            goto LabelSkipThisEmail;
                            LL = 778d;
                        }

                        LL = 779d;
                        if (xDebug)
                            LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000: " + EmailFolderFQN);
                        LL = 780d;
                        string SourceTypeCode = "";
                        LL = 781d;
                        try
                        {
                            LL = 782d;
                            Subject = oMsg.Subject;
                            LL = 783d;
                        }
                        // If InStr(Subject, "Accepted: ", CompareMethod.Text) > 0 Then
                        // LL = 784
                        // Console.WriteLine("Here on a calendar entry.")
                        // LL = 785
                        // End If
                        // LL = 786
                        catch (Exception ex)
                        {
                            LL = 787d;
                            LOG.WriteToArchiveLog("ERROR: XXX Subject : " + ex.Message);
                            LL = 788d;
                        }

                        LL = 789d;
                        LL = 790d;
                        try
                        {
                            LL = 791d;
                            SourceTypeCode = "MSG";
                            LL = 792d;
                        }
                        catch (Exception ex)
                        {
                            LL = 793d;
                            LOG.WriteToArchiveLog("ERROR: XXX SourceTypeCode : " + ex.Message);
                            LL = 794d;
                        }

                        LL = 795d;
                        bool bAutoForwarded = false;
                        LL = 797d;
                        try
                        {
                            LL = 798d;
                            bAutoForwarded = oMsg.AutoForwarded;
                            LL = 799d;
                        }
                        catch (Exception ex)
                        {
                            LL = 800d;
                            LOG.WriteToArchiveLog("ERROR: XXX bAutoForwarded As Boolean: " + ex.Message);
                            LL = 801d;
                        }

                        LL = 802d;
                        LL = 803d;
                        string BCC = "";
                        LL = 804d;
                        try
                        {
                            LL = 805d;
                            BCC = oMsg.BCC;
                            LL = 806d;
                        }
                        catch (Exception ex)
                        {
                            LL = 807d;
                            LOG.WriteToArchiveLog("ERROR: XXX BCC : " + ex.Message);
                            LL = 808d;
                        }

                        string BillingInformation = "";
                        try
                        {
                            BillingInformation = oMsg.BillingInformation;
                        }
                        catch (Exception ex)
                        {
                            LL = 814d;
                            LOG.WriteToArchiveLog("ERROR: XXX BillingInformation : " + ex.Message);
                            LL = 815d;
                        }

                        LL = 816d;
                        LL = 817d;
                        string EmailBody = "";
                        LL = 818d;
                        try
                        {
                            LL = 819d;
                            EmailBody = oMsg.Body;
                            LL = 820d;
                        }
                        catch (Exception ex)
                        {
                            LL = 821d;
                            LOG.WriteToArchiveLog("ERROR: XXX EmailBody: " + ex.Message);
                            LL = 822d;
                        }

                        LL = 823d;
                        if (EmailBody is null)
                        {
                            EmailBody = "-";
                        }
                        // *************** DO NOT SAVE THE WHOLE BODY, JUST THE FIRST 250 CHARACTERS *****************
                        // Dim iBodyLen As Integer = CInt(My.Settings("EmailBodyLength"))
                        // iBodyLen = 100000
                        // EmailBody = EmailBody.Substring(0, iBodyLen)
                        // *******************************************************************************************

                        LL = 824d;
                        string BodyFormat = "";
                        LL = 825d;
                        try
                        {
                            LL = 826d;
                            BodyFormat = oMsg.BodyFormat.ToString();
                            LL = 827d;
                        }
                        catch (Exception ex)
                        {
                            LL = 828d;
                            LOG.WriteToArchiveLog("ERROR: XXX BodyFormat: " + ex.Message);
                            LL = 829d;
                        }

                        LL = 830d;
                        LL = 831d;
                        string Categories = "";
                        LL = 832d;
                        try
                        {
                            LL = 833d;
                            Categories = oMsg.Categories;
                            LL = 834d;
                        }
                        catch (Exception ex)
                        {
                            LL = 835d;
                            LOG.WriteToArchiveLog("ERROR: XXX Categories: " + ex.Message);
                            LL = 836d;
                        }

                        LL = 839d;
                        if (xDebug)
                            LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000a: " + EmailFolderFQN);
                        LL = 840d;
                        LL = 841d;
                        string Companies = "";
                        LL = 842d;
                        try
                        {
                            LL = 843d;
                            Companies = oMsg.Companies;
                            LL = 844d;
                        }
                        catch (Exception ex)
                        {
                            LL = 845d;
                            LOG.WriteToArchiveLog("ERROR: XXX Companies : " + ex.Message);
                            LL = 846d;
                        }

                        LL = 847d;
                        LL = 848d;
                        LL = 849d;
                        string ConversationIndex = "";
                        LL = 850d;
                        try
                        {
                            LL = 851d;
                            ConversationIndex = oMsg.ConversationIndex;
                            LL = 852d;
                        }
                        catch (Exception ex)
                        {
                            LL = 853d;
                            LOG.WriteToArchiveLog("ERROR: XXX ConversationIndex : " + ex.Message);
                            LL = 854d;
                        }

                        LL = 855d;
                        LL = 856d;
                        string ConversationTopic = "";
                        LL = 857d;
                        try
                        {
                            LL = 858d;
                            ConversationTopic = oMsg.ConversationTopic;
                            LL = 859d;
                        }
                        catch (Exception ex)
                        {
                            LL = 860d;
                            LOG.WriteToArchiveLog("ERROR: XXX ConversationTopic : " + ex.Message);
                            LL = 861d;
                        }

                        LL = 862d;
                        LL = 863d;
                        Application.DoEvents();
                        LL = 864d;
                        DateTime DeferredDeliveryTime = default;
                        LL = 865d;
                        try
                        {
                            LL = 866d;
                            DeferredDeliveryTime = oMsg.DeferredDeliveryTime;
                            LL = 867d;
                        }
                        catch (Exception ex)
                        {
                            LL = 868d;
                            LOG.WriteToArchiveLog("ERROR: XXX DeferredDeliveryTime As Date: " + ex.Message);
                            LL = 869d;
                        }

                        LL = 870d;
                        LL = 871d;
                        string DownloadState = "";
                        LL = 872d;
                        try
                        {
                            LL = 873d;
                            DownloadState = oMsg.DownloadState.ToString();
                            LL = 874d;
                        }
                        catch (Exception ex)
                        {
                            LL = 875d;
                            LOG.WriteToArchiveLog("ERROR: XXX DownloadState : " + ex.Message);
                            LL = 876d;
                        }

                        LL = 877d;
                        LL = 878d;
                        Application.DoEvents();
                        LL = 879d;
                        if (xDebug)
                            LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000b: " + EmailFolderFQN);
                        LL = 880d;
                        LL = 881d;
                        DateTime ExpiryTime = default;
                        LL = 882d;
                        try
                        {
                            LL = 883d;
                            ExpiryTime = oMsg.ExpiryTime;
                            LL = 884d;
                        }
                        catch (Exception ex)
                        {
                            LL = 885d;
                            LOG.WriteToArchiveLog("ERROR: XXX ExpiryTime As Date: " + ex.Message);
                            LL = 886d;
                        }

                        LL = 887d;
                        LL = 888d;
                        if (xDebug)
                            LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000b1: " + EmailFolderFQN);
                        LL = 889d;
                        LL = 890d;
                        string HTMLBody = "";
                        LL = 891d;
                        try
                        {
                            LL = 892d;
                            HTMLBody = oMsg.HTMLBody;
                            LL = 893d;
                        }
                        catch (Exception ex)
                        {
                            LL = 894d;
                            LOG.WriteToArchiveLog("ERROR: XXX HTMLBody : " + ex.Message);
                            LL = 895d;
                        }

                        LL = 896d;
                        LL = 897d;
                        if (xDebug)
                            LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000b2: " + EmailFolderFQN);
                        LL = 898d;
                        LL = 899d;
                        string Importance = "";
                        LL = 900d;
                        try
                        {
                            LL = 901d;
                            Importance = ((int)oMsg.Importance).ToString();
                            LL = 902d;
                        }
                        catch (Exception ex)
                        {
                            LL = 903d;
                            LOG.WriteToArchiveLog("ERROR: XXX Importance : " + ex.Message);
                            LL = 904d;
                        }

                        LL = 905d;
                        LL = 906d;
                        if (xDebug)
                            LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000b3: " + EmailFolderFQN);
                        LL = 907d;
                        LL = 908d;
                        // ** ERROR HERE
                        LL = 909d;
                        bool IsMarkedAsTask = false;
                        LL = 910d;
                        try
                        {
                            LL = 911d;
                            IsMarkedAsTask = oMsg.IsMarkedAsTask;
                            LL = 912d;
                        }
                        catch (Exception ex)
                        {
                            LL = 913d;
                            LOG.WriteToArchiveLog("ERROR: XXX IsMarkedAsTask As Boolean: " + ex.Message);
                            LL = 914d;
                        }

                        LL = 915d;
                        LL = 916d;
                        if (xDebug)
                            LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000b4: " + EmailFolderFQN);
                        LL = 917d;
                        LL = 918d;
                        DateTime LastModificationTime = default;
                        LL = 919d;
                        try
                        {
                            LL = 920d;
                            LastModificationTime = oMsg.LastModificationTime;
                            LL = 921d;
                        }
                        catch (Exception ex)
                        {
                            LL = 922d;
                            LOG.WriteToArchiveLog("ERROR: XXX LastModificationTime As Date: " + ex.Message);
                            LL = 923d;
                        }

                        LL = 924d;
                        LL = 925d;
                        if (xDebug)
                            LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000b5: " + EmailFolderFQN);
                        LL = 926d;
                        LL = 927d;
                        string MessageClass = "";
                        LL = 928d;
                        try
                        {
                            LL = 929d;
                            MessageClass = oMsg.MessageClass;
                            LL = 930d;
                        }
                        catch (Exception ex)
                        {
                            LL = 931d;
                            LOG.WriteToArchiveLog("ERROR: XXX MessageClass : " + ex.Message);
                            LL = 932d;
                        }

                        LL = 933d;
                        LL = 934d;
                        LL = 935d;
                        if (xDebug)
                            LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000c: " + EmailFolderFQN);
                        LL = 936d;
                        LL = 937d;
                        string Mileage = "";
                        LL = 938d;
                        try
                        {
                            LL = 939d;
                            Mileage = oMsg.Mileage;
                            LL = 940d;
                        }
                        catch (Exception ex)
                        {
                            LL = 941d;
                            LOG.WriteToArchiveLog("ERROR: XXX Mileage : " + ex.Message);
                            LL = 942d;
                        }

                        LL = 943d;
                        LL = 944d;
                        bool OriginatorDeliveryReportRequested = default;
                        LL = 945d;
                        try
                        {
                            LL = 946d;
                            OriginatorDeliveryReportRequested = oMsg.OriginatorDeliveryReportRequested;
                            LL = 947d;
                        }
                        catch (Exception ex)
                        {
                            LL = 948d;
                            LOG.WriteToArchiveLog("ERROR OriginatorDeliveryReportRequested " + ex.Message);
                            LL = 949d;
                        }

                        LL = 950d;
                        LL = 951d;
                        string OutlookInternalVersion = "";
                        LL = 952d;
                        try
                        {
                            LL = 953d;
                            OutlookInternalVersion = oMsg.OutlookInternalVersion.ToString();
                            LL = 954d;
                        }
                        catch (Exception ex)
                        {
                            LL = 955d;
                            LOG.WriteToArchiveLog("ERROR OutlookInternalVersion  " + ex.Message);
                            LL = 956d;
                        }

                        LL = 957d;
                        LL = 958d;
                        bool ReadReceiptRequested = default;
                        LL = 959d;
                        try
                        {
                            LL = 960d;
                            ReadReceiptRequested = oMsg.ReadReceiptRequested;
                            LL = 961d;
                        }
                        catch (Exception ex)
                        {
                            LL = 962d;
                            LOG.WriteToArchiveLog("ERROR ReadReceiptRequested  " + ex.Message);
                            LL = 963d;
                        }

                        LL = 964d;
                        LL = 965d;
                        string ReceivedByEntryID = "";
                        LL = 966d;
                        try
                        {
                            LL = 967d;
                            ReceivedByEntryID = oMsg.ReceivedByEntryID;
                            LL = 968d;
                        }
                        catch (Exception ex)
                        {
                            LL = 969d;
                            LOG.WriteToArchiveLog("ERROR ReceivedByEntryID   " + ex.Message);
                            LL = 970d;
                        }

                        LL = 971d;
                        LL = 972d;
                        if (xDebug)
                            LOG.WriteToArchiveLog("ERROR: XXX ** ArchiveEmailsInFolder 1000d: " + EmailFolderFQN);
                        LL = 973d;
                        LL = 974d;
                        string ReceivedByName = "";
                        LL = 975d;
                        try
                        {
                            LL = 976d;
                            ReceivedByName = oMsg.ReceivedByName;
                            LL = 977d;
                        }
                        catch (Exception ex)
                        {
                            LL = 978d;
                            LOG.WriteToArchiveLog("ERROR ReceivedByName    " + ex.Message);
                            LL = 979d;
                        }

                        LL = 980d;
                        string SenderEmailAddress = "";
                        LL = 983d;
                        try
                        {
                            LL = 984d;
                            SenderEmailAddress = oMsg.SenderEmailAddress;
                            LL = 985d;
                        }
                        catch (Exception ex)
                        {
                            LL = 986d;
                            LOG.WriteToArchiveLog("ERROR: XXX SenderEmailAddress : " + ex.Message);
                            LL = 987d;
                        }

                        LL = 988d;
                        if (ReceivedByName == null)
                        {
                            LL = 992d;
                            ReceivedByName = "Unknown";
                            LL = 993d;
                        }
                        else if (ReceivedByName.Length == 0)
                        {
                            LL = 994d;
                            ReceivedByName = "Unknown";
                            LL = 995d;
                        }

                        LL = 996d;
                        LL = 997d;
                        string ReceivedOnBehalfOfName = "";
                        LL = 998d;
                        try
                        {
                            LL = 999d;
                            ReceivedOnBehalfOfName = oMsg.ReceivedOnBehalfOfName;
                            LL = 1000d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1001d;
                            LOG.WriteToArchiveLog("ERROR: XXX ReceivedOnBehalfOfName : " + ex.Message);
                            LL = 1002d;
                        }

                        LL = 1003d;
                        LL = 1004d;
                        if (xDebug)
                            LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000e: " + EmailFolderFQN);
                        LL = 1005d;
                        LL = 1006d;
                        object Recipients = null;
                        LL = 1007d;
                        try
                        {
                            LL = 1008d;
                            Recipients = oMsg.Recipients;
                            LL = 1009d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1010d;
                            LOG.WriteToArchiveLog("ERROR: XXX Recipients As Object: " + ex.Message);
                            LL = 1011d;
                        }

                        LL = 1012d;
                        LL = 1013d;
                        int KK = 0;
                        LL = 1014d;
                        LL = 1015d;
                        string AllRecipients = "";
                        LL = 1016d;
                        try
                        {
                            LL = 1017d;
                            var loopTo1 = oMsg.Recipients.Count;
                            for (KK = 1; KK <= loopTo1; KK++)
                            {
                                Application.DoEvents();
                                LL = 1018d;
                                // if xDebug then log.WriteToArchiveLog("Recipients: " + oMsg.Recipients.Item(KK).Address)
                                LL = 1019d;
                                if (xDebug)
                                {
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("Recipients: " + oMsg.Recipients[KK].Name + " : " + oMsg.Recipients.Count);
                                }

                                LL = 1020d;
                                AllRecipients = AllRecipients + "; " + oMsg.Recipients[KK].Address;
                                LL = 1021d;
                                AddRecipToList(EmailGuid, oMsg.Recipients[KK].Address, "RECIP");
                                LL = 1022d;
                            }

                            LL = 1023d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1024d;
                            LOG.WriteToArchiveLog("ERROR: XXX AllRecipients  : " + ex.Message);
                            LL = 1025d;
                        }

                        LL = 1029d;
                        if (AllRecipients.Length > 0)
                        {
                            LL = 1030d;
                            if (xDebug)
                                LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000g: " + EmailFolderFQN);
                            LL = 1031d;
                            string ch = Strings.Mid(AllRecipients, 1, 1);
                            LL = 1032d;
                            if (ch.Equals(";"))
                            {
                                LL = 1033d;
                                StringType.MidStmtStr(ref AllRecipients, 1, 1, " ");
                                LL = 1034d;
                                AllRecipients = AllRecipients.Trim();
                                LL = 1035d;
                            }

                            LL = 1036d;
                            if (xDebug)
                                LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1000h: " + EmailFolderFQN);
                            LL = 1037d;
                        }

                        LL = 1038d;
                        LL = 1039d;
                        if (xDebug)
                            LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1001: " + EmailFolderFQN);
                        LL = 1040d;
                        LL = 1041d;
                        bool ReminderSet = default;
                        LL = 1042d;
                        try
                        {
                            LL = 1043d;
                            ReminderSet = oMsg.ReminderSet;
                            LL = 1044d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1045d;
                            LOG.WriteToArchiveLog("ERROR: XXX ReminderSet As Boolean: " + ex.Message);
                            LL = 1046d;
                        }

                        LL = 1047d;
                        LL = 1048d;
                        DateTime ReminderTime = default;
                        LL = 1049d;
                        try
                        {
                            LL = 1050d;
                            ReminderTime = oMsg.ReminderTime;
                            LL = 1051d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1052d;
                            LOG.WriteToArchiveLog("ERROR: XXX ReminderTime As Date: " + ex.Message);
                            LL = 1053d;
                        }

                        LL = 1054d;
                        LL = 1055d;
                        object ReplyRecipientNames = null;
                        LL = 1056d;
                        try
                        {
                            LL = 1057d;
                            ReplyRecipientNames = oMsg.ReplyRecipientNames;
                            LL = 1058d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1059d;
                            LOG.WriteToArchiveLog("ERROR: XXX ReplyRecipientNames As Object: " + ex.Message);
                            LL = 1060d;
                        }

                        LL = 1061d;
                        LL = 1062d;
                        if (Conversions.ToBoolean(Operators.ConditionalCompareObjectNotEqual(ReplyRecipientNames, null, false)))
                        {
                            LL = 1063d;
                            // For Each R In ReplyRecipientNames
                            LL = 1064d;
                            if (xDebug)
                            {
                                if (xDebug)
                                    LOG.WriteToArchiveLog(Conversions.ToString(Operators.AddObject("ReplyRecipientNames: ", ReplyRecipientNames)));
                            }

                            LL = 1065d;
                            // Next
                            LL = 1066d;
                        }

                        LL = 1067d;
                        string SenderEmailType = "";
                        LL = 1068d;
                        try
                        {
                            LL = 1069d;
                            SenderEmailType = oMsg.SenderEmailType;
                            LL = 1070d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1071d;
                            LOG.WriteToArchiveLog("ERROR: XXX SenderEmailType : " + ex.Message);
                            LL = 1072d;
                        }

                        LL = 1073d;
                        LL = 1074d;
                        // Dim SendUsingAccount  = oMsg.SendUsingAccount
                        LL = 1075d;
                        string Sensitivity = "";
                        LL = 1076d;
                        try
                        {
                            LL = 1077d;
                            Sensitivity = ((int)oMsg.Sensitivity).ToString();
                            LL = 1078d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1079d;
                            LOG.WriteToArchiveLog("ERROR: XXX Sensitivity : " + ex.Message);
                            LL = 1080d;
                        }

                        LL = 1081d;
                        LL = 1082d;
                        string SentOnBehalfOfName = "";
                        LL = 1083d;
                        try
                        {
                            LL = 1084d;
                            SentOnBehalfOfName = oMsg.SentOnBehalfOfName;
                            LL = 1085d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1086d;
                            LOG.WriteToArchiveLog("ERROR: XXX SentOnBehalfOfName : " + ex.Message);
                            LL = 1087d;
                        }

                        LL = 1088d;
                        LL = 1089d;
                        int EmailSize = 0;
                        LL = 1090d;
                        try
                        {
                            LL = 1091d;
                            // String.Format("{1:F}", price
                            EmailSize = (int)(oMsg.Size / 1000d);
                            // Dim S1 As String = String.Format("{1:F}", EmailSize)
                            My.MyProject.Forms.frmNotify2.lblEmailMsg.Text += " : " + EmailSize.ToString() + "/Kb - " + oMsg.Attachments.Count.ToString();
                            My.MyProject.Forms.frmNotify2.Refresh();
                            LL = 1092d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1093d;
                            LOG.WriteToArchiveLog("ERROR: XXX EmailSize As Integer: " + ex.Message);
                            LL = 1094d;
                        }

                        ArchiveMsg = ArchiveMsg + " : " + Subject;
                        LL = 1098d;
                        LL = 1099d;
                        DateTime TaskCompletedDate = default;
                        LL = 1100d;
                        try
                        {
                            LL = 1101d;
                            TaskCompletedDate = oMsg.TaskCompletedDate;
                            LL = 1102d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1103d;
                            LOG.WriteToArchiveLog("ERROR: XXX TaskCompletedDate As Date: " + ex.Message);
                            LL = 1104d;
                        }

                        LL = 1105d;
                        LL = 1106d;
                        DateTime TaskDueDate = default;
                        LL = 1107d;
                        try
                        {
                            LL = 1108d;
                            TaskDueDate = oMsg.TaskDueDate;
                            LL = 1109d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1110d;
                            LOG.WriteToArchiveLog("ERROR: XXX TaskDueDate As Date: " + ex.Message);
                            LL = 1111d;
                        }

                        LL = 1112d;
                        LL = 1113d;
                        string TaskSubject = "";
                        LL = 1114d;
                        try
                        {
                            LL = 1115d;
                            TaskSubject = oMsg.TaskSubject;
                            LL = 1116d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1117d;
                            LOG.WriteToArchiveLog("ERROR: XXX TaskSubject : " + ex.Message);
                            LL = 1118d;
                        }

                        LL = 1119d;
                        LL = 1120d;
                        string SentTo = "";
                        LL = 1121d;
                        try
                        {
                            LL = 1122d;
                            SentTo = oMsg.To;
                            LL = 1123d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1124d;
                            LOG.WriteToArchiveLog("ERROR: XXX SentTo : " + ex.Message);
                            LL = 1125d;
                        }

                        LL = 1126d;
                        if (SentTo == null)
                        {
                            LL = 1128d;
                            SentTo = "UKN";
                            LL = 1129d;
                        }

                        LL = 1130d;
                        if (SentTo.Trim().Length == 0)
                        {
                            LL = 1131d;
                            SentTo = "UKN";
                            LL = 1132d;
                        }

                        LL = 1133d;
                        LL = 1134d;
                        string VotingOptions = "";
                        LL = 1135d;
                        try
                        {
                            LL = 1136d;
                            VotingOptions = oMsg.VotingOptions;
                            LL = 1137d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1138d;
                            LOG.WriteToArchiveLog("ERROR: XXX VotingOptions : " + ex.Message);
                            LL = 1139d;
                        }

                        LL = 1140d;
                        LL = 1141d;
                        string VotingResponse = "";
                        LL = 1142d;
                        try
                        {
                            LL = 1143d;
                            VotingResponse = oMsg.VotingResponse;
                            LL = 1144d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1145d;
                            LOG.WriteToArchiveLog("ERROR: XXX VotingResponse : " + ex.Message);
                            LL = 1146d;
                        }

                        LL = 1147d;
                        LL = 1148d;
                        object UserProperties = null;
                        LL = 1149d;
                        try
                        {
                            LL = 1150d;
                            UserProperties = oMsg.UserProperties;
                            LL = 1151d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1152d;
                            LOG.WriteToArchiveLog("ERROR: XXX UserProperties As Object: " + ex.Message);
                            LL = 1153d;
                        }

                        LL = 1154d;
                        LL = 1155d;
                        string Accounts = "";
                        LL = 1156d;
                        try
                        {
                            LL = 1157d;
                            Accounts = "None Supplied";
                            LL = 1158d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1159d;
                            LOG.WriteToArchiveLog("ERROR: XXX Accounts : " + ex.Message);
                            LL = 1160d;
                        }

                        LL = 1161d;
                        LL = 1162d;
                        string NewTime = "";
                        LL = 1163d;
                        try
                        {
                            LL = 1164d;
                            NewTime = ReceivedTime.ToString().Replace("//", ".");
                            LL = 1165d;
                            NewTime = ReceivedTime.ToString().Replace("/:", ".");
                            LL = 1166d;
                            NewTime = ReceivedTime.ToString().Replace(" ", "_");
                            LL = 1167d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1168d;
                            LOG.WriteToArchiveLog("ERROR: XXX NewTime : " + ex.Message);
                            LL = 1169d;
                        }

                        LL = 1170d;
                        LL = 1171d;
                        string NewSubject = "";
                        LL = 1172d;
                        try
                        {
                            LL = 1173d;
                            NewSubject = Strings.Mid(Subject, 1, 200);
                            LL = 1174d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1175d;
                            LOG.WriteToArchiveLog("ERROR: XXX NewSubject : " + ex.Message);
                            LL = 1176d;
                        }

                        LL = 1177d;
                        LL = 1178d;
                        NewSubject = NewSubject.Replace(" ", "_");
                        LL = 1179d;
                        ConvertName(ref NewSubject);
                        LL = 1180d;
                        ConvertName(ref NewTime);
                        LL = 1181d;
                        LL = 1182d;
                        bMsgUnopened = oMsg.UnRead;
                        LL = 1183d;
                        LL = 1184d;
                        if (bMsgUnopened == true & ArchiveOnlyIfRead == "Y")
                        {
                            LL = 1185d;
                            // ** The email has not been read and we have been instructed to skip it if not read...
                            LL = 1186d;
                            DeleteMsg = false;
                            LL = 1187d;
                            // GoTo LabelSkipThisEmail2
                            LL = 1188d;
                        }

                        LL = 1189d;
                        LL = 1190d;
                        if (xDebug)
                            LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1003: " + EmailFolderFQN);
                        LL = 1191d;
                        LL = 1192d;
                        bool bExcluded = default;
                        LL = 1193d;
                        try
                        {
                            LL = 1194d;
                            bExcluded = modGlobals.isExcludedEmail(SenderEmailAddress);
                            LL = 1195d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1196d;
                            LOG.WriteToArchiveLog("ERROR: XXX bExcluded: " + ex.Message);
                            LL = 1197d;
                        }

                        LL = 1198d;
                        if (bExcluded)
                        {
                            LL = 1199d;
                            if (xDebug)
                                LOG.WriteToArchiveLog("ERROR: XXX ** ArchiveEmailsInFolder 1004: " + EmailFolderFQN);
                            LL = 1200d;
                            goto LabelSkipThisEmail2;
                            LL = 1201d;
                        }

                        LL = 1202d;
                        try
                        {
                            LL = 1203d;
                            if (SenderEmailAddress.Length == 0)
                            {
                                LL = 1204d;
                                SenderEmailAddress = "Unknown";
                                LL = 1205d;
                            }
                        }
                        catch (Exception ex)
                        {
                            SenderEmailAddress = "Unknown";
                        }

                        LL = 1207d;
                        string SenderName = "";
                        LL = 1208d;
                        try
                        {
                            LL = 1209d;
                            SenderName = oMsg.SenderName;
                            LL = 1210d;
                        }
                        catch (Exception ex)
                        {
                            LL = 1211d;
                            LOG.WriteToArchiveLog("ERROR: XXX SenderName : " + ex.Message);
                            LL = 1212d;
                        }

                        LL = 1213d;
                        if (SenderName.Length == 0 | SenderName == null)
                        {
                            LL = 1215d;
                            SenderName = "Unknown";
                            LL = 1216d;
                        }

                        LL = 1219d;

                        // Dim bExists As Integer = EMAIL.cnt_FULL_UI_EMAIL(gCurrUserGuidID, ReceivedByName, ReceivedTime, SenderEmailAddress, SenderName, SentOn)

                        LL = 1220d;
                        if (bMailAlreadyUploaded == true)
                        {
                            LL = 1221d;
                            if (xDebug)
                                LOG.WriteToArchiveLog("** ArchiveEmailsInFolder Curr Items : " + CurrMailFolderName + " : EXISTS.");
                            LL = 1222d;
                            if (RemoveAfterArchive.Equals("Y"))
                            {
                                LL = 1223d;
                                // ** Remove this item from the existing folder.
                                LL = 1224d;
                                DeleteMsg = true;
                                LL = 1225d;
                                if (bMsgUnopened == false & ArchiveOnlyIfRead == "Y")
                                {
                                    LL = 1226d;
                                    DeleteMsg = true;
                                    LL = 1227d;
                                }
                                else if (ArchiveOnlyIfRead == "N")
                                {
                                    LL = 1228d;
                                    DeleteMsg = true;
                                    LL = 1229d;
                                }
                                else
                                {
                                    LL = 1230d;
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("No match ... ");
                                    LL = 1231d;
                                }

                                LL = 1232d;
                            }

                            LL = 1233d;
                            if (xDebug)
                                LOG.WriteToArchiveLog("ArchiveEmailsInFolder : found email already exists in " + tgtFolderName);
                            LL = 1235d;
                            if (xDebug)
                                LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1005: " + EmailFolderFQN);
                            LL = 1236d;
                            goto LabelSkipThisEmail;
                            LL = 1237d;
                        }
                        else
                        {
                            LL = 1238d;
                            LL = 1239d;
                            if (xDebug)
                                LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1006: " + EmailFolderFQN);
                            LL = 1240d;
                            LL = 1241d;
                            if (xDebug)
                                LOG.WriteToArchiveLog("** ArchiveEmailsInFolder Curr Items : " + CurrMailFolderName + " : DOES NOT EXIST.");
                            LL = 1242d;
                            // Dim IX As Integer = EMAIL.cnt_EntryID(StoreID , EntryID )
                            LL = 1243d;
                            if (RemoveAfterArchive.Equals("Y"))
                            {
                                LL = 1244d;
                                if (xDebug)
                                    LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1007: " + EmailFolderFQN);
                                LL = 1245d;
                                if (xDebug)
                                    LOG.WriteToArchiveLog("ArchiveEmailsInFolder : found email needs to be removed - " + tgtFolderName);
                                LL = 1246d;
                                // ** Remove this item from the existing folder.
                                LL = 1247d;
                                DeleteMsg = false;
                                LL = 1248d;
                                if (bMsgUnopened == false & ArchiveOnlyIfRead == "Y")
                                {
                                    LL = 1249d;
                                    // EM2D.Insert()
                                    LL = 1250d;
                                    DeleteMsg = true;
                                    LL = 1251d;
                                }
                                else if (ArchiveOnlyIfRead == "N")
                                {
                                    LL = 1252d;
                                    // EM2D.Insert()
                                    LL = 1253d;
                                    DeleteMsg = true;
                                    LL = 1254d;
                                }
                                else
                                {
                                    LL = 1255d;
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("No match ... ");
                                    LL = 1256d;
                                }

                                LL = 1257d;
                            }

                            LL = 1258d;
                            LL = 1259d;
                        }

                        LL = 1260d;
                        LL = 1261d;
                        if (xDebug)
                            LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1008: " + EmailFolderFQN);
                        LL = 1262d;
                        LL = 1263d;
                        Application.DoEvents();
                        LL = 1264d;
                        LL = 1265d;
                        string CC = oMsg.CC;
                        LL = 1266d;
                        Application.DoEvents();
                        LL = 1267d;
                        // EMAIL.setStoreID(StoreID )
                        LL = 1269d;
                        string argval1 = oMsg.EntryID;
                        EMAIL.setEntryid(ref argval1);
                        oMsg.EntryID = argval1;
                        LL = 1270d;
                        EMAIL.setEmailguid(ref EmailGuid);
                        LL = 1271d;
                        LL = 1272d;
                        if (BCC != null)
                        {
                            LL = 1273d;
                            AllRecipients = AllRecipients + "; " + BCC;
                            LL = 1274d;
                        }

                        LL = 1275d;
                        if (CC != null)
                        {
                            LL = 1276d;
                            AllRecipients = AllRecipients + "; " + CC;
                            LL = 1277d;
                        }

                        EMAIL.setAllrecipients(ref AllRecipients);
                        LL = 1279d;
                        EMAIL.setBcc(ref BCC);
                        LL = 1280d;
                        EMAIL.setBillinginformation(ref BillingInformation);
                        LL = 1281d;
                        string argval2 = UTIL.RemoveSingleQuotesV1(EmailBody);
                        EMAIL.setBody(ref argval2);
                        LL = 1282d;
                        EMAIL.setCc(ref CC);
                        LL = 1283d;
                        EMAIL.setCompanies(ref Companies);
                        LL = 1284d;
                        string argval3 = Conversions.ToString(CreationTime);
                        EMAIL.setCreationtime(ref argval3);
                        LL = 1285d;
                        EMAIL.setCurrentuser(ref modGlobals.gCurrUserGuidID);
                        LL = 1286d;
                        string argval4 = Conversions.ToString(DeferredDeliveryTime);
                        EMAIL.setDeferreddeliverytime(ref argval4);
                        LL = 1287d;
                        string argval5 = Conversions.ToString(DeferredDeliveryTime);
                        EMAIL.setDeferreddeliverytime(ref argval5);
                        LL = 1288d;
                        EMAIL.setEmailguid(ref EmailGuid);
                        LL = 1289d;
                        // EMAIL.setEmailimage()
                        LL = 1290d;
                        Application.DoEvents();
                        LL = 1291d;
                        string argval6 = Conversions.ToString(ExpiryTime);
                        EMAIL.setExpirytime(ref argval6);
                        LL = 1292d;
                        string argval7 = Conversions.ToString(LastModificationTime);
                        EMAIL.setLastmodificationtime(ref argval7);
                        LL = 1293d;
                        EMAIL.setMsgsize(ref EmailSize.ToString());
                        LL = 1294d;
                        EMAIL.setReadreceiptrequested(ref OriginatorDeliveryReportRequested.ToString());
                        LL = 1295d;
                        EMAIL.setReceivedbyname(ref ReceivedByName);
                        LL = 1296d;
                        string argval8 = Conversions.ToString(ReceivedTime);
                        EMAIL.setReceivedtime(ref argval8);
                        LL = 1297d;
                        SenderEmailAddress = Strings.Mid(SenderEmailAddress, 1, 79);
                        EMAIL.setSenderemailaddress(ref SenderEmailAddress);
                        LL = 1298d;
                        SenderName = Strings.Mid(SenderName, 1, 79);
                        EMAIL.setSendername(ref SenderName);
                        LL = 1299d;
                        EMAIL.setSensitivity(ref Sensitivity);
                        LL = 1300d;
                        string argval9 = Conversions.ToString(SentOn);
                        EMAIL.setSenton(ref argval9);
                        LL = 1301d;
                        EMAIL.setSourcetypecode(ref SourceTypeCode);
                        LL = 1302d;
                        // EMAIL.setOriginalfolder(OriginalFolder )

                        EMAIL.setOriginalfolder(ref EmailFolderFQN);
                        LL = 1304d;
                        AllRecipients = AllRecipients.Trim();
                        LL = 1306d;
                        if (SentTo.Length > 0)
                        {
                            LL = 1307d;
                            string ch = Strings.Mid(SentTo, 1, 1);
                            LL = 1308d;
                            if (ch.Equals(";"))
                            {
                                LL = 1309d;
                                StringType.MidStmtStr(ref SentTo, 1, 1, " ");
                                LL = 1310d;
                                SentTo = SentTo.Trim();
                                LL = 1311d;
                            }

                            LL = 1312d;
                        }

                        LL = 1313d;
                        EMAIL.setSentto(ref SentTo);
                        LL = 1314d;
                        LL = 1315d;
                        string argval10 = UTIL.RemoveSingleQuotesV1(Subject);
                        EMAIL.setSubject(ref argval10);
                        LL = 1316d;
                        string ShortSubj = Strings.Mid(Subject, 1, 240);
                        LL = 1317d;
                        string argval11 = UTIL.RemoveSingleQuotesV1(ShortSubj);
                        EMAIL.setShortsubj(ref argval11);
                        LL = 1318d;
                        bool MailAdded = false;
                        LL = 1319d;
                        LL = 1320d;
                        string TempEmailDir = UTIL.getTempProcessingDir();
                        LL = 1321d;
                        TempEmailDir = TempEmailDir + @"\EmailUpload\";
                        TempEmailDir = TempEmailDir.Replace(@"\\", @"\");
                        if (!Directory.Exists(TempEmailDir))
                        {
                            Directory.CreateDirectory(TempEmailDir);
                        }

                        EmailFQN = TempEmailDir + @"\" + EmailGuid + ".MSG";
                        EmailFQN = EmailFQN.Replace(@"\\", @"\");
                        string originalName = EmailGuid + ".MSG";
                        LL = 1322d;
                        for (int xx = 1, loopTo2 = EmailFQN.Length; xx <= loopTo2; xx++)
                        {
                            Application.DoEvents();
                            LL = 1323d;
                            string ch = Strings.Mid(EmailFQN, xx, 1);
                            LL = 1324d;
                            if (ch == "@")
                            {
                                LL = 1325d;
                                StringType.MidStmtStr(ref EmailFQN, xx, 1, "_");
                                LL = 1326d;
                            }

                            LL = 1327d;
                            if (ch == "-")
                            {
                                LL = 1328d;
                                StringType.MidStmtStr(ref EmailFQN, xx, 1, "_");
                                LL = 1329d;
                            }

                            LL = 1330d;
                        }

                        LL = 1331d;
                        try
                        {
                            // ** Save the message as a file here and prepare to upload the file to the server a little later.
                            oMsg.SaveAs(EmailFQN);
                        }
                        catch (Exception ex)
                        {
                            LOG.WriteToNoticeLog("WARNING clsArchiver : ArchiveEmailsInFolder 771-77a LL:" + LL.ToString() + " : " + ex.Message);
                            LOG.WriteToNoticeLog("WARNING clsArchiver : ArchiveEmailsInFolder 771-77b LL:" + LL.ToString() + " : " + tgtFolderName);
                        }

                        LL = 1333d;
                        bool BB = false;
                        LL = 1334d;
                        if (ArchiveEmails.Length == 0)
                        {
                            LL = 1335d;
                            ArchiveEmails = "Y";
                            LL = 1336d;
                        }

                        LL = 1337d;
                        Application.DoEvents();
                        LL = 1338d;
                        LL = 1339d;
                        if (xDebug)
                            LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1009: " + EmailFolderFQN);
                        LL = 1340d;
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
                        LL = 1341d;
                        if (ArchiveEmails.Equals("Y"))
                        {
                            LL = 1342d;
                            if (xDebug)
                                LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1010: " + EmailFolderFQN);
                            LL = 1343d;
                            int bx = EMAIL.cnt_FULL_UI_EMAIL(EmailIdentifier);
                            LL = 1344d;
                            if (bx == 0)
                            {
                                LL = 1345d;
                                string CRC = ENC.GenerateSHA512HashFromFile(EmailFQN);
                                string ImageHash = ENC.GenerateSHA512HashFromFile(EmailFQN);

                                // ** The EMAIL does not exist, ADD a record to the ContentUser table

                                BB = EMAIL.InsertNewEmail(modGlobals.gMachineID, modGlobals.gNetworkID, "MSG", EmailIdentifier, CRC, EmailFolderFQN);
                                LL = 1348d;
                                modGlobals.gEmailsAdded += 1;
                                LL = 1349d;
                                if (BB)
                                {
                                    My.MyProject.Forms.frmNotify2.lblFolder.Text = Subject;
                                    bMailAlreadyUploaded = DBLocal.addOutlook(EmailIdentifier);
                                    if (!slStoreId.ContainsKey(EmailIdentifier))
                                    {
                                        slStoreId.Add(EmailIdentifier, i);
                                    }

                                    EmailsBackedUp += (object)1;
                                    Application.DoEvents();
                                    ID = 5555.1;
                                    // *******************************************************************************
                                    // ** Add the EMAIL as a File to the repository
                                    // ** Call Filestream service or standard service here
                                    bool bMail = UpdateEmailMsg(originalName, ID, UID, EmailFQN, EmailGuid, RetentionCode, isPublic, CRC, tgtFolderName);
                                    // *******************************************************************************
                                    if (bMail == false)
                                    {
                                        LL = 1355d;
                                        string fExt = UTIL.getFileSuffix(EmailFQN);
                                        if (fExt.ToUpper().Equals(".MSG") | fExt.ToUpper().Equals("MSG"))
                                        {
                                            string TempFQN = "";
                                            bool BBX = false;
                                            if (fExt.ToUpper().Equals(".MSG") | fExt.ToUpper().Equals("MSG"))
                                            {
                                                EmailFQN = Strings.Mid(EmailFQN, 1, Strings.InStr(EmailFQN, ".MSG", CompareMethod.Text) - 1);
                                                ID = 5555.2;
                                                if (File.Exists(EmailFQN))
                                                {
                                                    // *******************************************************************************
                                                    // ** Add the EMAIL as a File to the repository
                                                    // ** Call Filestream service or standard service here
                                                    BBX = UpdateEmailMsg(originalName, ID, UID, EmailFQN, EmailGuid, RetentionCode, isPublic, CRC, tgtFolderName);
                                                    // *******************************************************************************
                                                    if (BBX == true)
                                                    {
                                                        string argval12 = "EML";
                                                        EMAIL.setSourcetypecode(ref argval12);
                                                        DBLocal.addOutlook(EmailIdentifier);
                                                    }
                                                    else
                                                    {
                                                        // ** It failed again, SKIP IT.
                                                        LOG.WriteToArchiveLog("ERROR 299a: Failed to add email" + EmailFQN);
                                                        goto LabelSkipThisEmail;
                                                    }
                                                }
                                            }
                                        }
                                    }

                                    // ************************************************
                                    // **  Add the key to the Local DBARCH lookup database
                                    bool bExists = DBLocal.OutlookExists(EmailIdentifier);
                                    if (!bExists)
                                    {
                                        DBLocal.addOutlook(EmailIdentifier);
                                    }
                                    // ************************************************

                                    LL = 1356d;
                                    string sSql = "Update EMAIL set CurrMailFolderID = '" + CurrMailFolderID + "' where EmailGuid = '" + EmailGuid + "'";
                                    LL = 1357d;
                                    bool bbExec = ExecuteSqlNewConn(sSql, false);
                                    LL = 1358d;
                                    if (!bbExec)
                                    {
                                        LL = 1359d;
                                        LOG.WriteToArchiveLog("ERROR: 1234.99a");
                                        LL = 1360d;
                                    }

                                    LL = 1361d;
                                    sSql = "Update EMAIL set RetentionExpirationDate = '" + RetentionExpirationDate + "' where EmailGuid = '" + EmailGuid + "'";
                                    LL = 1371d;
                                    bbExec = ExecuteSqlNewConn(sSql, false);
                                    LL = 1372d;
                                    if (!bbExec)
                                    {
                                        LL = 1373d;
                                        LOG.WriteToArchiveLog("ERROR: 1234.99c");
                                        LL = 1374d;
                                    }

                                    LL = 1375d;
                                    sSql = "Update EMAIL set RetentionCode = '" + RetentionCode + "' where EmailGuid = '" + EmailGuid + "'";
                                    LL = 1376d;
                                    bbExec = ExecuteSqlNewConn(sSql, false);
                                    LL = 1377d;
                                    if (!bbExec)
                                    {
                                        LL = 1378d;
                                        LOG.WriteToArchiveLog("ERROR: 1234.99c");
                                        LL = 1379d;
                                    }

                                    LL = 1380d;
                                    LL = 1381d;
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1013: " + EmailFolderFQN);
                                    LL = 1382d;
                                    setRetentionDate(EmailGuid, RetentionCode, ".MSG");
                                    LL = 1383d;
                                    LL = 1384d;
                                    if (EmailLibrary.Trim().Length > 0)
                                    {
                                        LL = 1385d;
                                        AddLibraryItem(EmailGuid, ShortSubj, ".MSG", EmailLibrary);
                                        LL = 1386d;
                                    }

                                    LL = 1387d;
                                    Application.DoEvents();
                                    LL = 1389d;
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1014: " + EmailFolderFQN);
                                    LL = 1390d;
                                    LL = 1391d;
                                    MailAdded = true;
                                    LL = 1392d;
                                }
                                else
                                {
                                    MailAdded = false;
                                    LL = 1398d;
                                }

                                LL = 1399d;
                            }
                            else
                            {
                                LL = 1400d;
                                BB = true;
                                LL = 1401d;
                                MailAdded = false;
                                LL = 1402d;
                            }

                            LL = 1403d;
                            if (BB)
                            {
                                LL = 1404d;
                                bool bAddHash = false;
                                if (bAddHash)
                                {
                                    EmailAddHash(EmailGuid, EmailIdentifier);
                                }

                                LL = 1405d;
                                if (File.Exists(EmailFQN))
                                {
                                    FileSystem.Kill(EmailFQN);
                                    LL = 1407d;
                                }

                                DeleteMsg = true;
                                LL = 1408d;
                            }
                            else
                            {
                                LL = 1409d;
                                if (xDebug)
                                    LOG.WriteToArchiveLog("Error 623.45 - Failed to delete temp email file : " + Subject);
                                LL = 1410d;
                                if (xDebug)
                                    LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1017: " + EmailFolderFQN);
                                LL = 1411d;
                                MailAdded = false;
                                LL = 1412d;
                                goto LabelSkipThisEmail2;
                                LL = 1413d;
                            }

                            LL = 1414d;
                        }

                        LL = 1415d;
                        LL = 1416d;
                        if (xDebug)
                            LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1018: " + EmailFolderFQN);
                        LL = 1417d;
                        LL = 1418d;
                        if (ArchiveEmails.Equals("N") & ArchiveAfterXDays.Equals("Y"))
                        {
                            LL = 1419d;
                            if (xDebug)
                                LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1019: " + EmailFolderFQN);
                            LL = 1420d;
                            TimeSpan elapsed_time;
                            LL = 1421d;
                            if (Strings.UCase(CurrName).Equals("SENT ITEMS"))
                            {
                                LL = 1422d;
                                elapsed_time = CurrDateTime.Subtract(SentOn);
                                LL = 1423d;
                            }
                            else
                            {
                                LL = 1424d;
                                elapsed_time = CurrDateTime.Subtract(CreationTime);
                                LL = 1425d;
                            }

                            LL = 1426d;
                            // elapsed_time = ReceivedTime.Subtract(CurrDateTime)
                            LL = 1427d;
                            int ElapsedDays = (int)elapsed_time.TotalDays;
                            LL = 1428d;
                            if (ElapsedDays >= XDaysRemove)
                            {
                                LL = 1429d;
                                if (xDebug)
                                    LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1020: " + EmailFolderFQN);
                                LL = 1430d;
                                bool bx = Conversions.ToBoolean(EMAIL.cnt_FULL_UI_EMAIL(EmailIdentifier));
                                LL = 1431d;
                                if (Conversions.ToInteger(bx) == 0)
                                {
                                    LL = 1432d;
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("ArchiveEmailsInFolder 101 : added email  - " + tgtFolderName);
                                    LL = 1433d;
                                    // BB = ArchiveEmail(EmailFQN, EmailGuid, Subject , AllRecipients , EmailBody, BCC , BillingInformation , CC , Companies , CreationTime, ReadReceiptRequested.ToString, ReceivedByName , ReceivedTime, AllRecipients , gCurrUserGuidID, SenderEmailAddress , SenderName , Sensitivity , SentOn, EmailSize, DeferredDeliveryTime, EntryID , ExpiryTime, LastModificationTime, ShortSubj , SourceTypeCode , OriginalFolder )
                                    LL = 1434d;
                                    string CRC = ENC.GenerateSHA512HashFromFile(FQN);
                                    string ImageHash = ENC.GenerateSHA512HashFromFile(FQN);
                                    BB = EMAIL.InsertNewEmail(modGlobals.gMachineID, modGlobals.gNetworkID, "MSG", EmailIdentifier, CRC, EmailFolderFQN);
                                    bMailAlreadyUploaded = DBLocal.addOutlook(EmailIdentifier);
                                    if (slStoreId.ContainsKey(EmailIdentifier))
                                    {
                                        slStoreId.Add(EmailIdentifier, i);
                                    }

                                    Application.DoEvents();
                                    LL = 1435d;
                                    modGlobals.gEmailsAdded += 1;
                                    LL = 1436d;
                                    if (BB)
                                    {
                                        LL = 1437d;
                                        EmailsBackedUp += (object)1;
                                        LL = 1438d;
                                        // InsertEmailBinary(EmailFQN, EmailGuid)
                                        LL = 1439d;
                                        ID = 5555.3;
                                        // *******************************************************************************
                                        // ** Add the EMAIL as a File to the repository
                                        // ** Call Filestream service or standard service here
                                        bool bMail = UpdateEmailMsg(originalName, ID, UID, EmailFQN, EmailGuid, RetentionCode, isPublic, CRC, tgtFolderName);
                                        // *******************************************************************************
                                        if (bMail == false)
                                        {
                                            EmailAddHash(EmailGuid, EmailIdentifier);
                                            string fExt = UTIL.getFileSuffix(EmailFQN);
                                            if (fExt.ToUpper().Equals(".MSG") | fExt.ToUpper().Equals("MSG"))
                                            {
                                                string TempFQN = "";
                                                bool BBX = false;
                                                if (fExt.ToUpper().Equals(".MSG") | fExt.ToUpper().Equals("MSG"))
                                                {
                                                    EmailFQN = Strings.Mid(EmailFQN, 1, Strings.InStr(EmailFQN, ".MSG", CompareMethod.Text) - 1);
                                                    ID = 5555.4;
                                                    // *******************************************************************************
                                                    // ** Add the EMAIL as a File to the repository
                                                    // ** Call Filestream service or standard service here
                                                    BBX = UpdateEmailMsg(originalName, ID, UID, EmailFQN, EmailGuid, RetentionCode, isPublic, CRC, tgtFolderName);
                                                    // *******************************************************************************
                                                    if (BBX == true)
                                                    {
                                                        DBLocal.addOutlook(EmailIdentifier);
                                                        string argval13 = "EML";
                                                        EMAIL.setSourcetypecode(ref argval13);
                                                    }
                                                    else
                                                    {
                                                        // ** It failed again, SKIP IT.
                                                        LOG.WriteToArchiveLog("ERROR 299b: Failed to add email" + EmailFQN);
                                                        goto LabelSkipThisEmail;
                                                    }
                                                }
                                            }
                                        }
                                        else
                                        {
                                            EmailAddHash(EmailGuid, EmailIdentifier);
                                        }

                                        LL = 1440d;
                                        MailAdded = true;
                                        // LL = 1441
                                        // Dim sSql  = "Update EMAIL set CurrMailFolderID = '" + CurrMailFolderID + "' where EmailGuid = '" + EmailGuid + "'"
                                        // LL = 1442
                                        // Dim bbExec As Boolean = ExecuteSqlNewConn(sSql, False)
                                        // LL = 1443
                                        // If Not bbExec Then
                                        // LL = 1444
                                        // LOG.WriteToArchiveLog("ERROR: 1234.99")
                                        // LL = 1445
                                        // End If
                                        // LL = 1446

                                        LL = 1447d;
                                        string HexCrc = ENC.GenerateSHA512HashFromFile(FQN);
                                        ImageHash = ENC.GenerateSHA512HashFromFile(FQN);
                                        LL = 1448d;
                                        string sSql = "Update EMAIL set CRC = '" + HexCrc + "' where EmailGuid = '" + EmailGuid + "'";
                                        LL = 1449d;
                                        bool bbExec = ExecuteSqlNewConn(sSql, false);
                                        LL = 1450d;
                                        if (!bbExec)
                                        {
                                            LL = 1451d;
                                            LOG.WriteToArchiveLog("ERROR: 1234.99");
                                            LL = 1452d;
                                        }

                                        LL = 1453d;
                                    }

                                    LL = 1454d;
                                    if (BB)
                                    {
                                        LL = 1455d;
                                        // BB = UpdateEmailMsg(EmailFQN, EmailGuid)
                                        LL = 1456d;
                                        FileSystem.Kill(EmailFQN);
                                        LL = 1457d;
                                        MailAdded = true;
                                        LL = 1458d;
                                    }
                                    else
                                    {
                                        LL = 1459d;
                                        if (xDebug)
                                            LOG.WriteToArchiveLog("ArchiveEmailsInFolder 101 : failed to add email  - " + tgtFolderName);
                                        LL = 1460d;
                                        MailAdded = false;
                                        LL = 1461d;
                                        goto LabelSkipThisEmail2;
                                        LL = 1462d;
                                    }

                                    LL = 1463d;
                                }

                                LL = 1464d;
                            }
                            else
                            {
                                LL = 1465d;
                                if (xDebug)
                                    LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1021: " + EmailFolderFQN);
                                LL = 1466d;
                                DeleteMsg = false;
                                LL = 1467d;
                                MailAdded = false;
                                LL = 1468d;
                                if (xDebug)
                                    LOG.WriteToArchiveLog("ArchiveEmailsInFolder 105 : skipped email  - " + tgtFolderName);
                                LL = 1470d;
                                goto LabelSkipThisEmail;
                                LL = 1471d;
                            }

                            LL = 1472d;
                        }

                        LL = 1473d;
                        LL = 1474d;
                        Application.DoEvents();
                        LL = 1475d;
                        LL = 1476d;
                        if (xDebug)
                            LOG.WriteToArchiveLog("** ArchiveEmailsInFolder 1022: " + EmailFolderFQN);
                        LL = 1477d;
                        LL = 1478d;
                        if (MailAdded)
                        {
                            LL = 1479d;
                            if (xDebug)
                                LOG.WriteToArchiveLog("ADDED ** ArchiveEmailsInFolder 1023: " + EmailFolderFQN);
                            LL = 1480d;
                            SL2.Clear();
                            LL = 1481d;
                            if (CC is object)
                            {
                                LL = 1482d;
                                if (CC.Trim().Length > 0)
                                {
                                    LL = 1483d;
                                    var A = new string[1];
                                    LL = 1484d;
                                    if (Strings.InStr(1, CC, ";") > 0)
                                    {
                                        LL = 1485d;
                                        A = Strings.Split(CC, ";");
                                        LL = 1486d;
                                    }
                                    else
                                    {
                                        LL = 1487d;
                                        A[0] = CC;
                                        LL = 1488d;
                                    }

                                    LL = 1489d;
                                    var loopTo3 = Information.UBound(A);
                                    for (KK = 0; KK <= loopTo3; KK++)
                                    {
                                        LL = 1490d;
                                        string SKEY = A[KK];
                                        LL = 1491d;
                                        if (SKEY is object)
                                        {
                                            LL = 1492d;
                                            bool BX = SL.ContainsKey(SKEY);
                                            LL = 1493d;
                                            if (!BX)
                                            {
                                                LL = 1494d;
                                                SL2.Add(SKEY, "CC");
                                                LL = 1495d;
                                            }

                                            LL = 1496d;
                                        }

                                        LL = 1497d;
                                    }

                                    LL = 1498d;
                                }

                                LL = 1499d;
                            }

                            LL = 1500d;
                            if (BCC is object)
                            {
                                LL = 1501d;
                                if (BCC.Trim().Length > 0)
                                {
                                    LL = 1502d;
                                    var A = new string[1];
                                    LL = 1503d;
                                    if (Strings.InStr(1, BCC, ";") > 0)
                                    {
                                        LL = 1504d;
                                        A = Strings.Split(BCC, ";");
                                        LL = 1505d;
                                    }
                                    else
                                    {
                                        LL = 1506d;
                                        A[0] = BCC;
                                        LL = 1507d;
                                    }

                                    LL = 1508d;
                                    var loopTo4 = Information.UBound(A);
                                    for (KK = 0; KK <= loopTo4; KK++)
                                    {
                                        LL = 1509d;
                                        string SKEY = A[KK];
                                        LL = 1510d;
                                        if (SKEY is object)
                                        {
                                            LL = 1511d;
                                            bool BX = SL.ContainsKey(SKEY);
                                            LL = 1512d;
                                            if (!BX)
                                            {
                                                LL = 1513d;
                                                SL2.Add(SKEY, "BCC");
                                                LL = 1514d;
                                            }

                                            LL = 1515d;
                                        }

                                        LL = 1516d;
                                    }

                                    LL = 1517d;
                                }

                                LL = 1518d;
                            }

                            LL = 1519d;
                            LL = 1520d;
                            var loopTo5 = oMsg.Recipients.Count;
                            for (KK = 1; KK <= loopTo5; KK++)
                            {
                                Application.DoEvents();
                                LL = 1521d;
                                if (xDebug)
                                {
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("Recipients Address: " + oMsg.Recipients[KK].Address);
                                }

                                LL = 1522d;
                                if (xDebug)
                                {
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("Recipients Name   : " + oMsg.Recipients[KK].Name);
                                }

                                LL = 1523d;
                                string Addr = oMsg.Recipients[KK].Address.ToString();
                                try
                                {
                                    LL = 1523.1d;
                                    Addr = oMsg.Recipients[KK].Address.ToString();
                                }
                                catch (Exception ex)
                                {
                                    LL = 1523.2d;
                                    LOG.WriteToErrorLog("WARNING 1523.2 : skipped Recipient : " + ex.Message);
                                    goto SKIP2NEXT;
                                }

                                LL = 1524d;
                                RECIPS.setEmailguid(ref EmailGuid);
                                LL = 1525d;
                                RECIPS.setRecipient(ref Addr);
                                LL = 1526d;
                                bool BX = SL2.ContainsKey(Addr);
                                LL = 1527d;
                                if (!BX)
                                {
                                    LL = 1528d;
                                    string argval14 = "RECIP";
                                    RECIPS.setTyperecp(ref argval14);
                                    LL = 1529d;
                                }
                                else
                                {
                                    LL = 1530d;
                                    int iKey = SL2.IndexOfKey(Addr);
                                    LL = 1531d;
                                    string TypeCC = "";
                                    LL = 1532d;
                                    TypeCC = SL2[Addr].ToString();
                                    LL = 1533d;
                                    RECIPS.setTyperecp(ref TypeCC);
                                    LL = 1534d;
                                }

                                LL = 1535d;
                                RECIPS.Insert();
                                SKIP2NEXT:
                                ;
                                LL = 1536d;
                            }

                            LL = 1537d;
                            LL = 1538d;
                            int iAtachCount = oMsg.Attachments.Count;
                            LL = 1539d;
                            if (iAtachCount > 0)
                            {
                                Application.DoEvents();
                                LL = 1540d;
                                LL = 1541d;
                                int iAcount = 0;
                                string filenameToDelete = "";
                                foreach (Outlook.Attachment Atmt in oMsg.Attachments)
                                {
                                    try
                                    {
                                        LL = 1542d;
                                        string TempDir = UTIL.getTempProcessingDir() + @"\EmailTempLoad\";
                                        TempDir = TempDir.Replace(@"\\", @"\");
                                        if (!Directory.Exists(TempDir))
                                        {
                                            Directory.CreateDirectory(TempDir);
                                        }

                                        LL = 1544d;
                                        string filename = TempDir + Atmt.FileName;
                                        filename = filename.Replace(@"\\", @"\");
                                        filenameToDelete = filename;
                                        filenameToDelete = filenameToDelete.Replace("//", "/");
                                        My.MyProject.Forms.frmNotify2.BackColor = Color.LightSalmon;
                                        My.MyProject.Forms.frmNotify2.lblMsg2.BackColor = Color.Gray;
                                        My.MyProject.Forms.frmNotify2.lblMsg2.Text = ">> " + Atmt.FileName.ToString();
                                        My.MyProject.Forms.frmNotify2.lblMsg2.Refresh();
                                        My.MyProject.Forms.frmNotify2.Refresh();
                                        LL = 1546d;
                                        Atmt.SaveAsFile(filename);
                                        LL = 1547d;
                                        string FileExt = "." + UTIL.getFileSuffix(filename);
                                        LL = 1549d;
                                        int bCnt = ATYPE.cnt_PK29(FileExt);
                                        LL = 1550d;
                                        bool isZipFile = false;
                                        LL = 1551d;
                                        if (bCnt == 0)
                                        {
                                            LL = 1552d;
                                            bool B1 = ZF.isZipFile(filename);
                                            LL = 1553d;
                                            if (B1)
                                            {
                                                string argval15 = "1";
                                                ATYPE.setIszipformat(ref argval15);
                                                LL = 1555d;
                                                isZipFile = true;
                                                LL = 1556d;
                                            }
                                            else
                                            {
                                                LL = 1557d;
                                                string argval16 = "0";
                                                ATYPE.setIszipformat(ref argval16);
                                                LL = 1558d;
                                                isZipFile = false;
                                                LL = 1559d;
                                            }

                                            LL = 1560d;
                                            ATYPE.setAttachmentcode(ref FileExt);
                                            LL = 1561d;
                                            ATYPE.Insert();
                                            LL = 1562d;
                                        }

                                        LL = 1563d;
                                        bool BBB = ZF.isZipFile(filename);
                                        LL = 1564d;
                                        string argval17 = "Auto added this code.";
                                        ATYPE.setDescription(ref argval17);
                                        LL = 1565d;
                                        if (BBB)
                                        {
                                            LL = 1566d;
                                            string argval18 = "1";
                                            ATYPE.setIszipformat(ref argval18);
                                            LL = 1567d;
                                            isZipFile = true;
                                            LL = 1568d;
                                        }
                                        else
                                        {
                                            LL = 1569d;
                                            string argval19 = "0";
                                            ATYPE.setIszipformat(ref argval19);
                                            LL = 1570d;
                                            isZipFile = false;
                                            LL = 1571d;
                                        }

                                        LL = 1572d;
                                        if (isZipFile == true)
                                        {
                                            LL = 1573d;
                                            // ** Explode and load
                                            LL = 1574d;
                                            // WDM ZIPFILE
                                            LL = 1575d;
                                            string AttachmentName = Atmt.FileName;
                                            LL = 1576d;
                                            bool SkipIfAlreadyArchived = false;
                                            DBLocal.addZipFile(filename, EmailGuid, true);
                                            LL = 1577d;
                                            ListOfFiles.Clear();
                                            // ZF.ProcessEmailZipFile(EmailGuid, filename, gCurrUserGuidID, SkipIfAlreadyArchived, AttachmentName, StackLevel, ListOfFiles)
                                            ZF.ProcessEmailZipFile(modGlobals.gMachineID, EmailGuid, filename, UID, SkipIfAlreadyArchived, AttachmentName, StackLevel, ref ListOfFiles);
                                            LL = 1578d;
                                        }
                                        else
                                        {
                                            LL = 1579d;
                                            FileExt = "." + UTIL.getFileSuffix(filename);
                                            LL = 1580d;
                                            string AttachmentName = Atmt.FileName;
                                            if (Strings.InStr(AttachmentName, "dmaquestion") > 0 | Strings.InStr(AttachmentName, "Workbook") > 0 | Strings.InStr(AttachmentName, "girl") > 0)
                                            {
                                                Console.WriteLine("here 001xx");
                                            }

                                            string Sha1Hash = ENC.GenerateSHA512HashFromFile(filename);
                                            string ImageHash = ENC.GenerateSHA512HashFromFile(filename);
                                            int iFileID = DBLocal.GetFileID(filename, Sha1Hash);
                                            if (iFileID < 0)
                                            {
                                                string strRowGuid = Conversions.ToString(InsertAttachmentFqn(modGlobals.gCurrUserGuidID, filename, EmailGuid, AttachmentName, FileExt, modGlobals.gCurrUserGuidID, RetentionCode, Sha1Hash, isPublic, EmailFolderFQN));
                                            }

                                            LL = 1582d;
                                            if (Strings.InStr(FileExt, "trf", CompareMethod.Text) > 0)
                                            {
                                                Console.WriteLine("Here TRF");
                                            }

                                            bool bIsImage = isImageFile(FileExt);
                                            LL = 1583d;
                                        }

                                        if (FileExt.ToUpper().Equals(".MSG") | FileExt.ToUpper().Equals("MSG"))
                                        {
                                            var EMX = new clsEmailFunctions();
                                            var xAttachedFiles = new List<string>();
                                            if (File.Exists(filename))
                                            {
                                                string EmailDescription = "";
                                                EMX.LoadMsgFile(UID, filename, ServerName, CurrMailFolderName, EmailLibrary, RetentionCode, Subject, ref EmailBody, ref xAttachedFiles, false, EmailGuid, ref EmailDescription);
                                                if (EmailDescription.Length > 0)
                                                {
                                                    EmailDescription = UTIL.RemoveSingleQuotes(EmailDescription);
                                                    concatEmailBody(EmailDescription, EmailGuid);
                                                }
                                            }

                                            EMX = null;
                                            GC.Collect();
                                            GC.WaitForPendingFinalizers();
                                        }

                                        LL = 1596d;
                                        My.MyProject.Forms.frmNotify2.BackColor = Color.LightGray;
                                        My.MyProject.Forms.frmNotify2.Refresh();
                                    }

                                    // Dim bOcrNeeded As Boolean = DBARCH.ckOcrNeededFileExt
                                    // If bOcrNeeded Then
                                    // DBARCH.SetOcrProcessingParms(SourceGuid, "C", filename
                                    // End If
                                    catch (Exception ex)
                                    {
                                        LOG.WriteToArchiveLog("ERROR  -   ARCHIVE OCR: 100 - " + ex.Message);
                                    }
                                    finally
                                    {
                                        try
                                        {
                                            FileSystem.Kill(filenameToDelete);
                                            My.MyProject.Forms.frmNotify2.lblFolder.Text = "done";
                                            My.MyProject.Forms.frmNotify2.lblMsg2.Text = DateAndTime.Now.ToString();
                                            My.MyProject.Forms.frmNotify2.lblMsg2.Refresh();
                                        }
                                        catch (Exception ex)
                                        {
                                            LOG.WriteToArchiveLog("Notification: " + filenameToDelete + " not deleted.");
                                        }
                                    }
                                }

                                GC.Collect();
                                GC.WaitForPendingFinalizers();
                                Application.DoEvents();
                                LL = 1598d;
                            }

                            LL = 1599d;
                        }
                        else
                        {
                            LL = 1600d;
                            if (xDebug)
                                LOG.WriteToArchiveLog("SKIPPED ** ArchiveEmailsInFolder 1099: " + EmailFolderFQN);
                            LL = 1601d;
                        }

                        LL = 1602d;
                        LL = 1603d;
                        Application.DoEvents();
                        LL = 1604d;
                        LL = 1605d;
                        LabelSkipThisEmail:
                        ;
                        LL = 1606d;
                        LL = 1607d;
                        Application.DoEvents();
                        LL = 1608d;
                        // ** Now, check for the processing rules ***************
                        LL = 1609d;
                        if (RemoveAfterXDays.Equals("Y")) // And RemoveAfterArchive .Equals("N") Then
                        {
                            LL = 1610d;
                            TimeSpan elapsed_time;
                            LL = 1611d;
                            if (Strings.UCase(CurrName).Equals("SENT ITEMS"))
                            {
                                LL = 1612d;
                                elapsed_time = CurrDateTime.Subtract(SentOn);
                                LL = 1613d;
                            }
                            else
                            {
                                LL = 1614d;
                                elapsed_time = CurrDateTime.Subtract(CreationTime);
                                LL = 1615d;
                            }

                            LL = 1616d;
                            // elapsed_time = ReceivedTime.Subtract(CurrDateTime)
                            LL = 1617d;
                            int ElapsedDays = (int)elapsed_time.TotalDays;
                            LL = 1618d;
                            if (ElapsedDays > 1000)
                            {
                                LL = 1619d;
                                ElapsedDays = 30;
                                LL = 1620d;
                                SentOn = oMsg.SentOn;
                                LL = 1621d;
                                ReceivedTime = oMsg.ReceivedTime;
                                LL = 1622d;
                                CreationTime = oMsg.CreationTime;
                                LL = 1623d;
                                elapsed_time = CurrDateTime.Subtract(CreationTime);
                                LL = 1624d;
                                // elapsed_time = ReceivedTime.Subtract(CurrDateTime)
                                LL = 1625d;
                                ElapsedDays = (int)elapsed_time.TotalDays;
                                LL = 1626d;
                            }

                            LL = 1627d;
                            LL = 1628d;
                            if (ElapsedDays < 0)
                            {
                                LL = 1629d;
                                ElapsedDays = 30;
                                LL = 1630d;
                                SentOn = oMsg.SentOn;
                                LL = 1631d;
                                ReceivedTime = oMsg.ReceivedTime;
                                LL = 1632d;
                                CreationTime = oMsg.CreationTime;
                                LL = 1633d;
                                elapsed_time = CurrDateTime.Subtract(CreationTime);
                                LL = 1634d;
                                // elapsed_time = ReceivedTime.Subtract(CurrDateTime)
                                LL = 1635d;
                                ElapsedDays = (int)elapsed_time.TotalDays;
                                LL = 1636d;
                            }

                            LL = 1637d;
                            LL = 1638d;
                            if (ElapsedDays >= XDaysRemove)
                            {
                                LL = 1639d;
                                if (xDebug)
                                    LOG.WriteToArchiveLog(CurrOutlookSubFolder.Name + ": Deleted ElapsedDays email... " + i + ":" + ElapsedDays + " days old.");
                                LL = 1640d;
                                // oMsg.Display()
                                LL = 1641d;
                                LL = 1642d;
                                EM2D.setEmailguid(ref EmailGuid);
                                LL = 1643d;
                                EM2D.setStoreid(ref StoreID);
                                LL = 1644d;
                                EM2D.setUserid(ref modGlobals.gCurrUserGuidID);
                                LL = 1645d;
                                string argval20 = oMsg.EntryID;
                                EM2D.setMessageid(ref argval20);
                                oMsg.EntryID = argval20;
                                LL = 1646d;
                                if (bMsgUnopened == false & ArchiveOnlyIfRead == "Y")
                                {
                                    LL = 1647d;
                                    // log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #102")
                                    LL = 1648d;
                                    bool BK = EM2D.Insert();
                                    LL = 1649d;
                                    if (BK)
                                    {
                                        LL = 1650d;
                                        // if xDebug then log.WriteToArchiveLog("oMsg.Delete()")
                                        LL = 1651d;
                                        // oMsg.Delete()
                                        LL = 1652d;
                                        if (bMoveIt)
                                        {
                                            LL = 1653d;
                                            // oMsg.Move(oDeletedItems)
                                            MoveToHistoryFolder(oMsg);
                                            LL = 1654d;
                                            LOG.WriteToArchiveLog("clsArchiver : GetEmailFolders : Delete Performed 02");
                                            LL = 1655d;
                                        }

                                        LL = 1656d;
                                        LL = 1657d;
                                    }

                                    LL = 1658d;
                                }
                                else if (ArchiveOnlyIfRead == "N")
                                {
                                    LL = 1659d;
                                    bool ExecuteThis = true;
                                    LL = 1660d;
                                    LL = 1661d;
                                    bool BK = EM2D.Insert();
                                    LL = 1662d;
                                    // log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #103")
                                    LL = 1663d;
                                    if (BK)
                                    {
                                        LL = 1664d;
                                        if (xDebug)
                                            LOG.WriteToArchiveLog("oMsg.Delete()");
                                        LL = 1665d;
                                        if (ExecuteThis == true)
                                        {
                                            LL = 1666d;
                                            if (bMoveIt)
                                            {
                                                LL = 1667d;
                                                LOG.WriteToArchiveLog("clsArchiver : GetEmailFolders : Delete Performed 03");
                                                LL = 1668d;
                                                // oMsg.Move(oDeletedItems)
                                                MoveToHistoryFolder(oMsg);
                                                LL = 1669d;
                                            }

                                            LL = 1670d;
                                        }

                                        LL = 1671d;
                                    }

                                    LL = 1672d;
                                }
                                else
                                {
                                    LL = 1673d;
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("No match ... ");
                                    LL = 1674d;
                                }

                                LL = 1676d;
                                // if xDebug then log.WriteToArchiveLog("oMsg.Delete()")
                                LL = 1677d;
                                goto LabelSkipThisEmail2;
                                LL = 1678d;
                            }

                            LL = 1679d;
                        }

                        LL = 1680d;
                        Application.DoEvents();
                        LL = 1681d;
                        // ** Delete the archived MSG from the archive directory
                        LL = 1682d;
                        if (RemoveAfterArchive.Equals("Y") & DeleteMsg)
                        {
                            LL = 1683d;
                            if (xDebug)
                                LOG.WriteToArchiveLog(CurrOutlookSubFolder.Name + ": Deleted email... ");
                            LL = 1684d;
                            // oMsg.Display()
                            LL = 1685d;
                            // If bMsgUnopened = False And ArchiveOnlyIfRead  = "Y" Then
                            LL = 1686d;
                            EM2D.setEmailguid(ref EmailGuid);
                            LL = 1687d;
                            EM2D.setStoreid(ref StoreID);
                            LL = 1688d;
                            EM2D.setUserid(ref modGlobals.gCurrUserGuidID);
                            LL = 1689d;
                            string argval21 = oMsg.EntryID;
                            EM2D.setMessageid(ref argval21);
                            oMsg.EntryID = argval21;
                            LL = 1690d;
                            if (bMsgUnopened == false & ArchiveOnlyIfRead == "Y")
                            {
                                LL = 1691d;
                                bool BK = EM2D.Insert();
                                LL = 1692d;
                                // log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #104")
                                LL = 1693d;
                                if (BK)
                                {
                                    LL = 1694d;
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("oMsg.Delete()");
                                    LL = 1695d;
                                    // oMsg.Delete()
                                    LL = 1696d;
                                    bool ExecuteThis = false;
                                    LL = 1697d;
                                    if (ExecuteThis == true)
                                    {
                                        LL = 1698d;
                                        if (bMoveIt)
                                        {
                                            LL = 1699d;
                                            LOG.WriteToArchiveLog("clsArchiver : GetEmailFolders : Delete Performed 04");
                                            LL = 1700d;
                                            // oMsg.Move(oDeletedItems)
                                            MoveToHistoryFolder(oMsg);
                                            LL = 1701d;
                                        }

                                        LL = 1702d;
                                    }

                                    LL = 1703d;
                                }

                                LL = 1704d;
                            }
                            else if (ArchiveOnlyIfRead == "N")
                            {
                                LL = 1705d;
                                bool BK = EM2D.Insert();
                                LL = 1706d;
                                // log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #105")
                                LL = 1707d;
                                if (BK)
                                {
                                    LL = 1708d;
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("oMsg.Delete()");
                                    LL = 1709d;
                                    // oMsg.Delete()
                                    LL = 1710d;
                                    if (bMoveIt)
                                    {
                                        LL = 1711d;
                                        LOG.WriteToArchiveLog("clsArchiver : GetEmailFolders : Delete Performed 05");
                                        LL = 1712d;
                                        // oMsg.Move(oDeletedItems)
                                        MoveToHistoryFolder(oMsg);
                                        LL = 1713d;
                                    }

                                    LL = 1715d;
                                }

                                LL = 1716d;
                            }
                            else
                            {
                                LL = 1717d;
                                if (xDebug)
                                    LOG.WriteToArchiveLog("No match ... ");
                                LL = 1718d;
                            }

                            LL = 1719d;
                            LL = 1720d;
                            // End If
                            LL = 1721d;
                        }
                        else if (bRemoveAfterArchive)
                        {
                            LL = 1722d;
                            if (xDebug)
                                LOG.WriteToArchiveLog(CurrOutlookSubFolder.Name + ": Deleted email... ");
                            LL = 1723d;
                            // oMsg.Display()
                            LL = 1724d;
                            // If bMsgUnopened = False And ArchiveOnlyIfRead  = "Y" Then
                            LL = 1725d;
                            EM2D.setEmailguid(ref EmailGuid);
                            LL = 1726d;
                            EM2D.setStoreid(ref StoreID);
                            LL = 1727d;
                            EM2D.setUserid(ref modGlobals.gCurrUserGuidID);
                            LL = 1728d;
                            string argval22 = oMsg.EntryID;
                            EM2D.setMessageid(ref argval22);
                            oMsg.EntryID = argval22;
                            LL = 1729d;
                            if (bMsgUnopened == false & ArchiveOnlyIfRead == "Y")
                            {
                                LL = 1730d;
                                bool BK = EM2D.Insert();
                                LL = 1731d;
                                // log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #106")
                                LL = 1732d;
                                if (BK)
                                {
                                    LL = 1733d;
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("oMsg.Delete()");
                                    LL = 1734d;
                                    // oMsg.Delete()
                                    LL = 1735d;
                                    if (bMoveIt)
                                    {
                                        LL = 1736d;
                                        LOG.WriteToArchiveLog("clsArchiver : GetEmailFolders : Delete Performed 06");
                                        LL = 1737d;
                                        // oMsg.Move(oDeletedItems)
                                        MoveToHistoryFolder(oMsg);
                                        LL = 1738d;
                                    }

                                    LL = 1739d;
                                }

                                LL = 1740d;
                            }
                            else if (ArchiveOnlyIfRead == "N")
                            {
                                LL = 1741d;
                                Application.DoEvents();
                                bool BK = EM2D.Insert();
                                Application.DoEvents();
                                LL = 1742d;
                                // log.WriteToArchiveLog("clsArchiver : xGetEmails: Marked File for deletion #107")
                                LL = 1743d;
                                if (BK)
                                {
                                    LL = 1744d;
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("oMsg.Delete()");
                                    LL = 1745d;
                                    // oMsg.Delete()
                                    LL = 1746d;
                                    if (bMoveIt)
                                    {
                                        LL = 1747d;
                                        LOG.WriteToArchiveLog("clsArchiver : GetEmailFolders : Delete Performed 07");
                                        LL = 1748d;
                                        oMsg.Move(oDeletedItems);
                                        LL = 1749d;
                                    }

                                    LL = 1750d;
                                }

                                LL = 1751d;
                            }
                            else
                            {
                                LL = 1752d;
                                if (xDebug)
                                    LOG.WriteToArchiveLog("No match ... ");
                                LL = 1753d;
                            }

                            LL = 1754d;
                            LL = 1755d;
                        }

                        LL = 1756d;
                    }
                    catch (Exception ex)
                    {
                        My.MyProject.Forms.frmMain.EmailsSkipped += 1;
                        Console.WriteLine(oItems[(object)i].MessageClass.ToString());
                        if (Strings.InStr(ex.Message, "no files found matching", CompareMethod.Text) > 0)
                        {
                            Console.WriteLine("Warning - file not found LL = " + LL.ToString());
                        }
                        else
                        {
                            string tMsg = "";
                            tMsg = "ERROR: " + ArchiveMsg + " SKIPPED - " + ex.Message + " LL = " + LL.ToString() + Constants.vbCrLf;
                            tMsg += "ERROR: Subj:" + Subject + " SKIPPED - " + ex.Message + " LL = " + LL.ToString() + Constants.vbCrLf;
                            tMsg += "clsArchiver : ArchiveEmailsInFolder: 99999 - item#" + i.ToString() + " : " + ex.Message + "Message Type: " + oItems[(object)i].MessageClass.ToString() + " LL = " + LL.ToString();
                            LOG.WriteToArchiveLog(tMsg);
                        }
                    }

                    LabelSkipThisEmail2:
                    ;
                    LL = 1768d;
                    My.MyProject.Forms.frmNotify2.lblFolder.Text = modGlobals.gEmailsAdded.ToString();
                }

                LL = 1769d;
                LL = 1770d;
                oItems = null;
                LL = 1771d;
                oMsg = null;
                LL = 1772d;
                GC.Collect();
                LL = 1773d;
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ArchiveEmailsInFolder 144.23.1a - " + ex.Message + " LL = " + LL.ToString());
                LOG.WriteToArchiveLog("ArchiveEmailsInFolder 144.23.1b - " + ex.StackTrace + " LL = " + LL.ToString());
            }
            finally
            {
                LL = 1777d;
                // In any case please remember to turn on Outlook Security after your code,
                // since now it is very easy to switch it off! :-)
                LL = 1778d;
                // SecurityManager.DisableOOMWarnings = False
                LL = 1779d;
                My.MyProject.Forms.frmMain.PBx.Value = 0;
                LL = 1780d;
                // 'FrmMDIMain.TSPB1.Value = 0
                LL = 1781d;
            }

            LL = 1782d;
            My.MyProject.Forms.frmNotify2.Close();
        }

        public void ArchiveExchangeEmails(string UID, string NewGuid, string Body, string Subject, ArrayList CC, ArrayList BCC, ArrayList EmailToAddr, ArrayList Recipients, string CurrMailFolderID_ServerName, string SenderEmailAddress, string SenderName, DateTime SentOn, string ReceivedByName, DateTime ReceivedTime, DateTime CreationTime, string DB_ID, string CurrMailFolder, string Server_UserID_StoreID, int RetentionYears, string RetentionCode, int EmailSize, List<string> AttachedFiles, string EntryID, string EmailIdentifier, string EmailFQN, string LibraryName, bool isPublic, bool bEmlToMSG, ref bool AttachmentsLoaded, int DaysToRetain)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string tgtFolderName = "NA";
            int StackLevel = 0;
            var ListOfFiles = new Dictionary<string, int>();
            int ID = 7777;
            var EM = new clsEMAIL();
            var FI = new FileInfo(EmailFQN);
            string OriginalName = FI.Name;
            FI = null;
            string LastEmailArchRunDate = UserParmRetrive("LastEmailArchRunDate", modGlobals.gCurrUserGuidID);
            if (LastEmailArchRunDate.Trim().Length == 0)
            {
                LastEmailArchRunDate = "1/1/1950";
            }

            var rightNow = DateAndTime.Now;
            if (RetentionYears == 0)
            {
                RetentionYears = (int)Conversion.Val(getSystemParm("RETENTION YEARS"));
            }

            rightNow = rightNow.AddYears(RetentionYears);
            string RetentionExpirationDate = rightNow.ToString();
            int EmailsSkipped = 0;
            bool DeleteMsg = false;
            var CurrDateTime = DateAndTime.Now;
            int ArchiveAge = 0;
            int RemoveAge = 0;
            int XDaysArchive = 0;
            int XDaysRemove = 0;
            // Dim EmailFQN  = ""
            bool bRemoveAfterArchive = false;
            bool bMsgUnopened = false;
            string CurrMailFolderName = "";
            DateTime MinProcessDate = Conversions.ToDate("01/1/1910");
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
                // Loop each unread message. :LL = 9
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
                    if (SentOn == default)
                    {
                        LL = 21;
                        SentOn = DateTime.Parse("1899-01-01");
                        LL = 22;
                    }

                    LL = 23;
                    if (ReceivedTime == default)
                    {
                        LL = 25;
                        ReceivedTime = DateTime.Parse("1899-01-01");
                        LL = 26;
                    }

                    LL = 27;
                    if (CreationTime == default)
                    {
                        LL = 29;
                        CreationTime = DateTime.Parse("1970-01-01");
                        LL = 30;
                    }

                    LL = 31;
                    if (CreationTime < DateTime.Parse("1960-01-01"))
                    {
                        LL = 32;
                        CreationTime = DateTime.Parse("1960-01-01");
                        LL = 33;
                    }

                    LL = 34;

                    // If frmReconMain.ckUseLastProcessDateAsCutoff.Checked Then :LL =  36
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
                    // *************** DO NOT SAVE THE WHOLE BODY, JUST THE FIRST 100 CHARACTERS *****************
                    // EmailBody = EmailBody.Substring(0, 100)
                    // *******************************************************************************************

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
                    DateTime DeferredDeliveryTime = default;
                    LL = 55;
                    string DownloadState = "";
                    LL = 56;
                    string HTMLBody = "";
                    LL = 58;
                    string Importance = "";
                    LL = 59;
                    bool IsMarkedAsTask = false;
                    LL = 60;
                    var LastModificationTime = DateAndTime.Now;
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
                    var loopTo = Recipients.Count - 1;
                    for (KK = 0; KK <= loopTo; KK++)
                    {
                        LL = 78;
                        AllRecipients = Conversions.ToString(Operators.AddObject(AllRecipients + "; ", Recipients[KK]));
                        LL = 79;
                        AddRecipToList(EmailGuid, Conversions.ToString(Recipients[KK]), "RECIP");
                        LL = 80;
                    }

                    LL = 81;
                    if (AllRecipients.Length > 0)
                    {
                        LL = 83;
                        string ch = Strings.Mid(AllRecipients, 1, 1);
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
                    DateTime ReminderTime = default;
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
                    DateTime TaskCompletedDate = default;
                    LL = 100;
                    var TaskDueDate = DateAndTime.Now;
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
                    string NewSubject = Strings.Mid(Subject, 1, 200);
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
                    if (SenderEmailAddress.Length == 0 | SenderEmailAddress == null)
                    {
                        LL = 122;
                        SenderEmailAddress = "Unknown";
                        LL = 123;
                    }

                    LL = 124;
                    if (SentOn == default)
                    {
                        LL = 126;
                        SentOn = DateTime.Parse("1900-01-01");
                        LL = 127;
                    }

                    LL = 128;
                    if (SenderName.Length == 0 | SenderName == null)
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
                    AllRecipients += ";" + ReceivedByName;
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
                    string argval = UTIL.RemoveSingleQuotes(EmailBody);
                    EM.setBody(ref argval);
                    LL = 168;
                    EM.setCc(ref AllCC);
                    LL = 169;
                    EM.setCompanies(ref Companies);
                    LL = 170;
                    string argval1 = Conversions.ToString(CreationTime);
                    EM.setCreationtime(ref argval1);
                    LL = 171;
                    EM.setCurrentuser(ref modGlobals.gCurrUserGuidID);
                    LL = 172;
                    string argval2 = Conversions.ToString(DeferredDeliveryTime);
                    EM.setDeferreddeliverytime(ref argval2);
                    LL = 173;
                    string argval3 = Conversions.ToString(DeferredDeliveryTime);
                    EM.setDeferreddeliverytime(ref argval3);
                    LL = 174;
                    EM.setEmailguid(ref EmailGuid);
                    LL = 175;
                    // EM.setEmailimage() :LL =  176

                    EM.setExpirytime(ref RetentionExpirationDate);
                    LL = 178;
                    string argval4 = Conversions.ToString(LastModificationTime);
                    EM.setLastmodificationtime(ref argval4);
                    LL = 179;
                    EM.setMsgsize(ref EmailSize.ToString());
                    LL = 180;
                    EM.setReadreceiptrequested(ref OriginatorDeliveryReportRequested.ToString());
                    LL = 181;
                    EM.setReceivedbyname(ref ReceivedByName);
                    LL = 182;
                    string argval5 = Conversions.ToString(ReceivedTime);
                    EM.setReceivedtime(ref argval5);
                    LL = 183;
                    EM.setSenderemailaddress(ref SenderEmailAddress);
                    LL = 184;
                    EM.setSendername(ref SenderName);
                    LL = 185;
                    EM.setSensitivity(ref Sensitivity);
                    LL = 186;
                    string argval6 = Conversions.ToString(SentOn);
                    EM.setSenton(ref argval6);
                    LL = 187;
                    if (bEmlToMSG == true)
                    {
                        LL = 188;
                        string argval7 = "MSG";
                        EM.setSourcetypecode(ref argval7);
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
                        for (int iI = 0, loopTo1 = Recipients.Count - 1; iI <= loopTo1; iI++)
                        {
                            LL = 198;
                            SentTo = Conversions.ToString(SentTo + Operators.AddObject(Recipients[iI], ";"));
                            LL = 199;
                        }

                        LL = 200;
                    }

                    LL = 201;
                    EM.setSentto(ref ReceivedByName);
                    LL = 203;
                    string argval8 = UTIL.RemoveSingleQuotes(Subject);
                    EM.setSubject(ref argval8);
                    LL = 204;
                    string ShortSubj = Strings.Mid(Subject, 1, 240);
                    LL = 205;
                    string argval9 = UTIL.RemoveSingleQuotes(ShortSubj);
                    EM.setShortsubj(ref argval9);
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
                        // *****  *********************************************** :LL =  213
                        // Convert to MSG and store the image as a MSG file :LL =  214
                        string CRC = ENC.GenerateSHA512HashFromFile(FQN);
                        string ImageHash = ENC.GenerateSHA512HashFromFile(FQN);
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
                        // *****  *********************************************** :LL =  220

                        if (BB == true)
                        {
                            LL = 222;
                            EmailAddHash(EmailGuid, EmailIdentifier);
                            ID = 7777.1;
                            // **********************************************************************************************
                            // ** Call Filestream service or standard service here
                            bool bFileApplied = UpdateEmailMsg(OriginalName, ID, UID, EmailFQN, EmailGuid, RetentionCode, Conversions.ToString(isPublic), CRC, tgtFolderName);
                            // **********************************************************************************************
                            if (bFileApplied == false & bEmlToMSG == true)
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
                                    if (fExt.ToUpper().Equals(".MSG") | fExt.ToUpper().Equals("MSG"))
                                    {
                                        LL = 230;
                                        EmailFQN = Strings.Mid(EmailFQN, 1, Strings.InStr(EmailFQN, ".MSG", CompareMethod.Text) - 1);
                                        LL = 231;
                                        ID = 7777.2;
                                        // **********************************************************************************************
                                        // ** Call Filestream service or standard service here
                                        BBX = UpdateEmailMsg(OriginalName, ID, UID, EmailFQN, EmailGuid, RetentionCode, Conversions.ToString(isPublic), CRC, tgtFolderName);
                                        // **********************************************************************************************
                                        if (BBX == true)
                                        {
                                            LL = 233;
                                            bEmlToMSG = false;
                                            LL = 234;
                                            string argval10 = "EML";
                                            EM.setSourcetypecode(ref argval10);
                                            LL = 235;
                                        }
                                        else
                                        {
                                            LL = 236;
                                            // ** It failed again, SKIP IT. :LL =  237
                                            LOG.WriteToArchiveLog("ERROR 299: Failed to add email" + CurrMailFolderID_ServerName + Constants.vbCrLf + EmailFQN);
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
                                // frmExchangeMonitor.lblMsg.Text = ("Added EMAIL" + Now.ToLocalTime.ToString)
                                Application.DoEvents();
                            }

                            LL = 245;

                            // EmailIdentifier :LL =  247
                            // **WDM Removed below 3/11/2010 :LL =  248
                            string sSql = "Update EMAIL set EmailIdentifier = '" + EmailIdentifier + "' where EmailGuid = '" + EmailGuid + "'";
                            LL = 249;
                            bool bbExec = ExecuteSqlNewConn(sSql, false);
                            LL = 250;
                            if (!bbExec)
                            {
                                LL = 251;
                                LOG.WriteToArchiveLog("ERROR: 1234.99xx: " + EmailFQN + Constants.vbCrLf + sSql);
                                LL = 252;
                            }

                            LL = 253;

                            // LibraryName , ByVal isPublic As Boolean :LL =  255
                            if (LibraryName.Trim().Length > 0)
                            {
                                LL = 256;
                                string LibraryOwnerUserID = GetLibOwnerByName(LibraryName);
                                LL = 257;
                                if (LibraryOwnerUserID.Trim().Length == 0)
                                {
                                    LOG.WriteToArchiveLog("ERROR: 300 - No Lib Owner found for LibraryName = '" + LibraryName + "'.");
                                }

                                if (LibraryOwnerUserID.Length > 0)
                                {
                                    string tSql = "";
                                    LL = 258;
                                    var LI = new clsLIBRARYITEMS();
                                    LL = 259;
                                    int iCnt = cnt_UniqueEntry(LibraryName, EmailGuid);
                                    LL = 260;
                                    if (iCnt == 0)
                                    {
                                        LL = 261;
                                        LI.setSourceguid(ref EmailGuid);
                                        LL = 262;
                                        string argval11 = Strings.Mid(Subject, 1, 200);
                                        LI.setItemtitle(ref argval11);
                                        LL = 263;
                                        LI.setItemtype(ref SourceTypeCode);
                                        LL = 264;
                                        LI.setLibraryitemguid(ref Guid.NewGuid().ToString());
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
                                        // frmExchangeMonitor.lblCnt.Text = Now.ToString
                                        My.MyProject.Forms.frmExchangeMonitor.Refresh();
                                        if (b == false)
                                        {
                                            LL = 271;
                                            LOG.WriteToArchiveLog("ERROR: 198.171.76 - Failed to add Email Library Item: " + LibraryName + " : + " + Subject);
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
                                sSql = "Update EMAIL set ConvertEmlToMSG = 1 where EmailGuid = '" + EmailGuid + "'";
                                LL = 279;
                                bbExec = ExecuteSqlNewConn(sSql, false);
                                LL = 280;
                                if (!bbExec)
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
                                sSql = "Update EMAIL set isPublic = 1 where EmailGuid = '" + EmailGuid + "'";
                                LL = 286;
                            }
                            else
                            {
                                LL = 287;
                                sSql = "Update EMAIL set isPublic = 0 where EmailGuid = '" + EmailGuid + "'";
                                LL = 288;
                            }

                            LL = 289;
                            bbExec = ExecuteSqlNewConn(sSql, false);
                            LL = 290;
                            if (!bbExec)
                            {
                                LL = 291;
                                LOG.WriteToArchiveLog("ERROR: 1234.99xx2");
                                LL = 292;
                            }

                            LL = 293;
                            sSql = "Update EMAIL set CurrMailFolderID = '" + CurrMailFolderID_ServerName + "' where EmailGuid = '" + EmailGuid + "'";
                            LL = 295;
                            bbExec = ExecuteSqlNewConn(sSql, false);
                            LL = 296;
                            if (!bbExec)
                            {
                                LL = 297;
                                LOG.WriteToArchiveLog("ERROR: 1234.99a");
                                LL = 298;
                            }

                            LL = 299;
                            sSql = "Update EMAIL set CRC = convert(nvarchar(100), " + CRC + ") where EmailGuid = '" + EmailGuid + "'";
                            LL = 302;
                            bbExec = ExecuteSqlNewConn(sSql, false);
                            LL = 303;
                            if (!bbExec)
                            {
                                LL = 304;
                                LOG.WriteToArchiveLog("ERROR: 1234.99b");
                                LL = 305;
                            }

                            LL = 306;

                            // RetentionExpirationDate :LL =  308
                            sSql = "Update EMAIL set RetentionExpirationDate = '" + RetentionExpirationDate + "' where EmailGuid = '" + EmailGuid + "'";
                            LL = 309;
                            bbExec = ExecuteSqlNewConn(sSql, false);
                            LL = 310;
                            if (!bbExec)
                            {
                                LL = 311;
                                LOG.WriteToArchiveLog("ERROR: 1234.99c");
                                LL = 312;
                            }

                            LL = 313;
                            sSql = "Update EMAIL set RetentionCode = '" + RetentionCode + "' where EmailGuid = '" + EmailGuid + "'";
                            LL = 314;
                            bbExec = ExecuteSqlNewConn(sSql, false);
                            LL = 315;
                            if (!bbExec)
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
                            TotalFilesArchived += 1;
                            LL = 324;
                            // **WDM Removed below 3/11/2010 :LL =  325
                            string sSql = "Update EMAIL set EmailIdentifier = '" + EmailIdentifier + "' where EmailGuid = '" + EmailGuid + "'";
                            LL = 326;
                            bool bbExec = ExecuteSqlNewConn(sSql, false);
                            LL = 327;
                            if (!bbExec)
                            {
                                LL = 328;
                                LOG.WriteToArchiveLog("ERROR: 1234.99xx12");
                                LL = 329;
                            }

                            LL = 330;
                            if (bEmlToMSG == true)
                            {
                                LL = 332;
                                sSql = "Update EMAIL set ConvertEmlToMSG = 1 where EmailGuid = '" + EmailGuid + "'";
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
                                var LI = new clsLIBRARYITEMS();
                                LL = 340;
                                int iCnt = cnt_UniqueEntry(LibraryName, EmailGuid);
                                LL = 341;
                                if (iCnt == 0)
                                {
                                    LL = 342;
                                    LI.setSourceguid(ref EmailGuid);
                                    LL = 343;
                                    string argval12 = Strings.Mid(Subject, 1, 200);
                                    LI.setItemtitle(ref argval12);
                                    LL = 344;
                                    LI.setItemtype(ref SourceTypeCode);
                                    LL = 345;
                                    LI.setLibraryitemguid(ref Guid.NewGuid().ToString());
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
                                        LOG.WriteToArchiveLog("ERROR: 198.171.76 - Failed to add Email Library Item: " + LibraryName + " : + " + Subject);
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
                                sSql = "Update EMAIL set isPublic = 1 where EmailGuid = '" + EmailGuid + "'";
                                LL = 361;
                            }
                            else
                            {
                                LL = 362;
                                sSql = "Update EMAIL set isPublic = 0 where EmailGuid = '" + EmailGuid + "'";
                                LL = 363;
                            }

                            LL = 364;
                            bbExec = ExecuteSqlNewConn(sSql, false);
                            LL = 365;
                            if (!bbExec)
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
                        // BB = UpdateEmailMsg(EmailFQN, EmailGuid ) :LL =  378
                        try
                        {
                            LL = 379;
                            FileSystem.Kill(EmailFQN);
                            LL = 380;
                        }
                        catch (Exception ex)
                        {
                            LL = 381;
                            LOG.WriteToArchiveLog("ArchiveExchangeEmails 1000: " + ex.Message);
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
                        if (AllCC is object)
                        {
                            LL = 393;
                            if (AllCC.Trim().Length > 0)
                            {
                                LL = 394;
                                var A = new string[1];
                                LL = 395;
                                if (Strings.InStr(1, AllCC, ";") > 0)
                                {
                                    LL = 396;
                                    A = Strings.Split(AllCC, ";");
                                    LL = 397;
                                }
                                else
                                {
                                    LL = 398;
                                    A[0] = AllCC;
                                    LL = 399;
                                }

                                LL = 400;
                                var loopTo2 = Information.UBound(A);
                                for (KK = 0; KK <= loopTo2; KK++)
                                {
                                    LL = 401;
                                    string SKEY = A[KK];
                                    LL = 402;
                                    if (SKEY is object)
                                    {
                                        LL = 403;
                                        bool BXX = SL.ContainsKey(SKEY);
                                        LL = 404;
                                        if (!BXX)
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
                        if (AllBcc is object)
                        {
                            LL = 412;
                            if (AllBcc.Trim().Length > 0)
                            {
                                LL = 413;
                                var A = new string[1];
                                LL = 414;
                                if (Strings.InStr(1, AllBcc, ";") > 0)
                                {
                                    LL = 415;
                                    A = Strings.Split(AllBcc, ";");
                                    LL = 416;
                                }
                                else
                                {
                                    LL = 417;
                                    A[0] = AllBcc;
                                    LL = 418;
                                }

                                LL = 419;
                                var loopTo3 = Information.UBound(A);
                                for (KK = 0; KK <= loopTo3; KK++)
                                {
                                    LL = 420;
                                    string SKEY = A[KK];
                                    LL = 421;
                                    if (SKEY is object)
                                    {
                                        LL = 422;
                                        bool BXX = SL.ContainsKey(SKEY);
                                        LL = 423;
                                        if (!BXX)
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

                        // For KK = 0 To Recipients.Count - 1 :LL =  432
                        foreach (string tAddr in Recipients)
                        {
                            LL = 433;
                            // Dim Addr  = Recipients.Item(i) :LL =  434
                            string Addr = tAddr;
                            LL = 435;
                            RECIPS.setEmailguid(ref EmailGuid);
                            LL = 436;
                            RECIPS.setRecipient(ref Addr);
                            LL = 437;
                            bool BXX = SL2.ContainsKey(Addr);
                            LL = 438;
                            if (!BXX)
                            {
                                LL = 439;
                                string argval13 = "RECIP";
                                RECIPS.setTyperecp(ref argval13);
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
                        ;
                        if (AttachedFiles.Count > 0)
                        {
                            LL = 453;
                            foreach (string FileName in AttachedFiles)
                            {
                                LL = 454;
                                // Dim TempDir  = System.IO.Path.GetTempPath :LL =  455
                                // FileName  = AttachedFiles.Item(II) :LL =  456
                                string FileExt = "." + UTIL.getFileSuffix(FileName);
                                LL = 457;
                                int bCnt = ATYPE.cnt_PK29(FileExt);
                                LL = 459;
                                bool isZipFile = false;
                                LL = 460;
                                if (Strings.InStr(FileName, "winmail.dat", CompareMethod.Text) > 0)
                                {
                                    LL = 462;
                                    goto SkipThisOne;
                                    LL = 463;
                                }

                                LL = 464;
                                if (FileExt.ToUpper().Equals(".MSG") | FileExt.ToUpper().Equals("MSG"))
                                {
                                    LL = 466;
                                    var EMX = new clsEmailFunctions();
                                    LL = 467;
                                    var xAttachedFiles = new List<string>();
                                    LL = 468;
                                    if (File.Exists(FileName))
                                    {
                                        LL = 471;
                                        string argEmailDescription = DaysToRetain.ToString();
                                        EMX.LoadMsgFile(UID, FileName, CurrMailFolderID_ServerName, CurrMailFolder, LibraryName, RetentionCode, Subject, ref EmailBody, ref xAttachedFiles, false, NewGuid, ref argEmailDescription);
                                        LL = 472;
                                    }

                                    LL = 473;
                                    EMX = null;
                                    LL = 475;
                                    GC.Collect();
                                    LL = 476;
                                    GC.WaitForPendingFinalizers();
                                    LL = 477;
                                    for (int IIX = 0, loopTo4 = xAttachedFiles.Count - 1; IIX <= loopTo4; IIX++)
                                    {
                                        LL = 479;
                                        try
                                        {
                                            LL = 480;
                                            string tFqn = xAttachedFiles[IIX];
                                            LL = 481;
                                            if (!AttachedFiles.Contains(tFqn))
                                            {
                                                LL = 482;
                                                AttachedFiles.Add(tFqn);
                                                LL = 483;
                                            }

                                            LL = 484;
                                        }
                                        catch (Exception ex)
                                        {
                                            LL = 485;
                                            Console.WriteLine("Corrected attached file 100");
                                        }

                                        LL = 487;
                                    }

                                    LL = 488;
                                    for (int III = 0, loopTo5 = AttachedFiles.Count - 1; III <= loopTo5; III++)
                                    {
                                        LL = 489;
                                        if (Strings.InStr(AttachedFiles[III], "winmail.dat", CompareMethod.Text) > 0)
                                        {
                                            LL = 490;
                                            AttachedFiles[III] = "";
                                            LL = 491;
                                        }

                                        LL = 492;
                                        if (AttachedFiles[III].ToUpper().Equals(FileName.ToUpper()))
                                        {
                                            LL = 493;
                                            AttachedFiles[III] = "";
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
                                        string argval14 = "1";
                                        ATYPE.setIszipformat(ref argval14);
                                        LL = 503;
                                        isZipFile = true;
                                        LL = 504;
                                    }
                                    else
                                    {
                                        LL = 505;
                                        string argval15 = "0";
                                        ATYPE.setIszipformat(ref argval15);
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
                                string argval16 = "Auto added this code.";
                                ATYPE.setDescription(ref argval16);
                                LL = 515;
                                if (BBB)
                                {
                                    LL = 516;
                                    string argval17 = "1";
                                    ATYPE.setIszipformat(ref argval17);
                                    LL = 517;
                                    isZipFile = true;
                                    LL = 518;
                                }
                                else
                                {
                                    LL = 519;
                                    string argval18 = "0";
                                    ATYPE.setIszipformat(ref argval18);
                                    LL = 520;
                                    isZipFile = false;
                                    LL = 521;
                                }

                                LL = 522;
                                if (isZipFile == true)
                                {
                                    LL = 523;
                                    // ** Explode and load :LL =  524
                                    string AttachmentName = FileName;
                                    LL = 525;
                                    bool SkipIfAlreadyArchived = false;
                                    LL = 526;
                                    DBLocal.addZipFile(FileName, EmailGuid, true);
                                    // ZF.ProcessEmailZipFile(EmailGuid, FileName , gCurrUserGuidID, SkipIfAlreadyArchived, AttachmentName, False) : LL = 527
                                    ZF.ProcessEmailZipFile(modGlobals.gMachineID, EmailGuid, FileName, UID, SkipIfAlreadyArchived, AttachmentName, StackLevel, ref ListOfFiles);
                                }
                                else
                                {
                                    LL = 528;
                                    FileExt = "." + UTIL.getFileSuffix(FileName);
                                    LL = 529;
                                    string AttachmentName = FileName;
                                    string Sha1Hash = ENC.GenerateSHA512HashFromFile(FileName);
                                    string ImageHash = ENC.GenerateSHA512HashFromFile(FileName);
                                    bool bbx = InsertAttachmentFqn(modGlobals.gCurrUserGuidID, FileName, EmailGuid, AttachmentName, FileExt, modGlobals.gCurrUserGuidID, RetentionCode, Sha1Hash, Conversions.ToString(isPublic), OriginalFolder);
                                    if (bbx == false)
                                    {
                                        LOG.WriteToArchiveLog("WARNING: Failed to process attachment for " + Subject + " / " + EmailGuid);
                                    }
                                }

                                LL = 548;
                                SkipThisOne:
                                ;
                            }

                            LL = 551;
                        }

                        LL = 552;
                    }

                    LL = 554;
                    LabelSkipThisEmail:
                    ;
                }
                catch (Exception ex)
                {
                    EmailsSkipped += 1;
                    LOG.WriteToArchiveLog(ArchiveMsg + "LL: " + LL.ToString() + " -  SKIPPED - " + ex.Message);
                    LOG.WriteToArchiveLog("clsArchiver : ArchiveEmailsInFolder: 100a - LL#" + LL.ToString());
                    LOG.WriteToArchiveLog("clsArchiver : ArchiveEmailsInFolder: 100b - item#" + i.ToString() + " : " + ex.Message);
                }

                GC.Collect();
                GC.WaitForFullGCComplete();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("FATAL ERROR clsArchiver : ArchiveEmailsInFolder: 100-D - LL# " + LL.ToString() + " : " + ex.Message);
            }
            finally
            {
                // In any case please remember to turn on Outlook Security after your code, since now it is very easy to switch it off! :-)
                // SecurityManager.DisableOOMWarnings = False
                EM = null;
            }

            // UpdateAttachmentCounts()

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
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var R = new clsRECIPIENTS();
            int I = 0;
            var loopTo = SL.Count - 1;
            for (I = 0; I <= loopTo; I++)
            {
                string S = SL.GetKey(I).ToString();
                var A = Strings.Split(S, Conversions.ToString('þ'));
                R.setEmailguid(ref A[0]);
                R.setRecipient(ref A[1]);
                R.setTyperecp(ref A[2]);
                var Recips = Strings.Split(A[1], ";");
                for (int k = 0, loopTo1 = Information.UBound(Recips); k <= loopTo1; k++)
                {
                    int II = R.cnt_PK32A(A[0], Recips[k]);
                    if (II == 0)
                    {
                        bool b = R.Insert();
                        if (!b)
                        {
                            if (xDebug)
                                LOG.WriteToArchiveLog("Error 7391.2: Failed to add RECIPIENT " + A[1]);
                        }
                    }
                }
            }
        }

        public void AddRecipToList(string sGuid, string RECIP, string TypeRecip)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            RECIP = UTIL.RemoveSingleQuotes(RECIP);
            bool b = false;
            string tKey = sGuid + Conversions.ToString('þ') + RECIP + Conversions.ToString('þ') + TypeRecip;
            b = SL.Contains(tKey);
            if (!b)
            {
                try
                {
                    SL.Add(tKey, TypeRecip);
                }
                catch (Exception ex)
                {
                    if (xDebug)
                        LOG.WriteToArchiveLog("Error 66521: skiped recip list item: " + ex.Message);
                }
            }
        }

        public void ArchiveEmailsInFolderenders(string ArchiveEmails, string RemoveAfterArchive, string SetAsDefaultFolder, string ArchiveAfterXDays, string RemoveAfterXDays, string RemoveXDays, string ArchiveXDays, Outlook.MAPIFolder CurrMailFolder, bool DeleteEmail)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            bool DeleteMsg = false;
            var CurrDateTime = DateAndTime.Now;
            int ArchiveAge = 0;
            int RemoveAge = 0;
            int XDaysArchive = 0;
            int XDaysRemove = 0;
            string DB_ConnectionString = "";
            if (ArchiveEmails.Equals("N") & ArchiveAfterXDays.Equals("N") & RemoveAfterArchive.Equals("N"))
            {
                // ** Then this folder really should not be in the list
                return;
            }

            if (RemoveAfterArchive.Equals("Y"))
            {
                DeleteMsg = true;
            }

            if (Information.IsNumeric(RemoveXDays))
            {
                XDaysRemove = (int)Conversion.Val(RemoveXDays);
            }

            if (Information.IsNumeric(ArchiveXDays))
            {
                XDaysArchive = (int)Conversion.Val(ArchiveXDays);
            }

            try
            {
                var oItems = CurrMailFolder.Items;
                if (xDebug)
                    LOG.WriteToArchiveLog("Total : " + oItems.Count);

                // Get unread e-mail messages.
                // oItems = oItems.Restrict("[Unread] = true")
                if (xDebug)
                    LOG.WriteToArchiveLog("Total Unread : " + oItems.Count);

                // Loop each unread message.
                Outlook.MailItem oMsg;
                int i = 0;
                var loopTo = oItems.Count;
                for (i = 1; i <= loopTo; i++)
                {
                    try
                    {
                        if (i % 50 == 0)
                        {
                            if (xDebug)
                                LOG.WriteToArchiveLog("Message#: " + i + " of " + oItems.Count);
                        }

                        oMsg = (Outlook.MailItem)oItems[(object)i];
                        string SenderEmailAddress = oMsg.SenderEmailAddress;
                        string SenderName = oMsg.SenderName;
                        string ListKey = SenderEmailAddress.Trim() + "|" + SenderName.Trim();
                        string MySql = "";
                        MySql = MySql + " SELECT count(*) as cnt";
                        MySql = MySql + " FROM  [OutlookFrom]";
                        MySql = MySql + " where FromEmailAddr = '" + SenderEmailAddress + "'";
                        MySql = MySql + " and SenderName = '" + SenderName + "'";
                        MySql = MySql + " and UserID = '" + modGlobals.gCurrUserGuidID + "'";
                        int bb = iDataExist(MySql);
                        if (bb > 0)
                        {
                            MySql = "";
                            MySql = MySql + " Update  [OutlookFrom]";
                            MySql = MySql + " set [Verified] = 1 ";
                            MySql = MySql + " where FromEmailAddr = '" + SenderEmailAddress + "'";
                            MySql = MySql + " and SenderName = '" + SenderName + "'";
                            MySql = MySql + " and UserID = '" + modGlobals.gCurrUserGuidID + "'";
                            bool bSuccess = ExecuteSqlNewConn(MySql, false);
                            if (!bSuccess)
                            {
                                if (xDebug)
                                    LOG.WriteToArchiveLog("Update failed:" + Constants.vbCrLf + MySql);
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
                            MySql = MySql + "'" + SenderEmailAddress + "',";
                            MySql = MySql + " '" + SenderName + "',";
                            MySql = MySql + " '" + modGlobals.gCurrUserGuidID + "',";
                            MySql = MySql + " 1)";
                            bool bSuccess = ExecuteSqlNewConn(MySql, false);
                            if (!bSuccess)
                            {
                                if (xDebug)
                                    LOG.WriteToArchiveLog("Insert failed:" + Constants.vbCrLf + MySql);
                            }
                        }

                        Application.DoEvents();
                    }
                    catch (Exception ex)
                    {
                        if (xDebug)
                            LOG.WriteToArchiveLog("Error: " + Constants.vbCrLf + ex.Message);
                        if (xDebug)
                            LOG.WriteToArchiveLog("Skipping Message# " + i.ToString());
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
                // SecurityManager.DisableOOMWarnings = False
            }
        }

        /// <summary>
    /// This subroutine gets all fo the appointments from within the Outlook Appointment book.
    /// </summary>
    /// <remarks></remarks>
        public void getAppts()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            // Create Outlook application.
            var oApp = new Outlook.Application();

            // Get NameSpace and Logon.
            var oNS = oApp.GetNamespace("mapi");
            oNS.Logon("YourValidProfile", Missing.Value, false, true); // TODO:

            // Get Appointments collection from the Calendar folder.
            var oCalendar = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderCalendar);
            var oItems = oCalendar.Items;

            // TODO: You may want to use Find or Restrict to retrieve the appointment that you prefer. ...

            // Get the first AppointmentItem.
            Outlook.AppointmentItem oAppt = (Outlook.AppointmentItem)oItems.GetFirst();

            // ' Display some common properties.
            // Console.WriteLine(oAppt.Organizer)
            // Console.WriteLine(oAppt.Subject)
            // Console.WriteLine(oAppt.Body)
            // Console.WriteLine(oAppt.Location)
            // Console.WriteLine(oAppt.Start.ToString())
            // Console.WriteLine(oAppt.End.ToString())

            // Display.
            // oAppt.Display(true)

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
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            // Create Outlook application.
            var oApp = new Outlook.Application();

            // Get Mapi NameSpace and Logon.
            var oNS = oApp.GetNamespace("mapi");
            oNS.Logon("YourValidProfile", Missing.Value, false, true); // TODO:

            // Get Global Address List.
            var oDLs = oNS.AddressLists;
            var oGal = oDLs["Global Address List"];
            Console.WriteLine(oGal.Name);

            // Get a specific distribution list.
            // TODO: Replace the distribution list with a distribution list that is available to you.
            string sDL = "TestDL";
            var oEntries = oGal.AddressEntries;
            // No filter available to AddressEntries
            var oDL = oEntries[sDL];
            Console.WriteLine(oDL.Name);
            Console.WriteLine(oDL.Address);
            Console.WriteLine(oDL.Manager);

            // Get all of the members of the distribution list.
            oEntries = oDL.Members;
            Outlook.AddressEntry oEntry;
            int i;
            var loopTo = oEntries.Count;
            for (i = 1; i <= loopTo; i++)
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
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            // Create an Outlook application.
            var oApp = new Outlook.Application();

            // Get Mapi NameSpace and Logon.
            var oNS = oApp.GetNamespace("mapi");
            oNS.Logon("YourValidProfile", Missing.Value, false, true); // TODO:

            // Create an AppointmentItem.
            Outlook._AppointmentItem oAppt = (Outlook._AppointmentItem)oApp.CreateItem(Outlook.OlItemType.olAppointmentItem);
            // oAppt.Display(true)  'Modal

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
            oAppt.BusyStatus = Outlook.OlBusyStatus.olBusy;  // olBusy
            oAppt.IsOnlineMeeting = false;
            oAppt.AllDayEvent = false;

            // Add attendees.
            var oRecipts = oAppt.Recipients;

            // Add required attendee.
            Outlook.Recipient oRecipt;
            oRecipt = oRecipts.Add("UserTest1"); // TODO:
            oRecipt.Type = (int)Outlook.OlMeetingRecipientType.olRequired;

            // Add optional attendee.
            oRecipt = oRecipts.Add("UserTest2"); // TODO:
            oRecipt.Type = (int)Outlook.OlMeetingRecipientType.olOptional;
            oRecipts.ResolveAll();

            // oAppt.Display(true)

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
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Thread.BeginCriticalRegion();
            bool bInstalled = true;
            try
            {
                var oAppTest = new Outlook.Application();
                bInstalled = true;
                oAppTest = null;
            }
            catch (Exception E)
            {
                LOG.WriteToArchiveLog("NOTICE: OUTLOOK does not appear to be installed - skipping archive." + Constants.vbCrLf + E.Message);
                bInstalled = false;
            }

            if (bInstalled == false)
            {
                Thread.EndCriticalRegion();
                return;
            }

            var FrmInfo = new frmNotifyContact();
            FrmInfo.Show();
            FrmInfo.Title = "CONTACTS";
            FrmInfo.Text = "Outlook Contacts";
            FrmInfo.lblMsg.Text = "Contacts";
            FrmInfo.Location = new Point(25, 50);
            FrmInfo.lblMsg2.Text = "Contacts: ";
            var SkipArchiveDate = getLastContactArchiveDate();

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
            var oApp = new Outlook.Application();

            // Get namespace and Contacts folder reference.
            var oNS = oApp.GetNamespace("MAPI");
            var cContacts = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderContacts);

            // Get the first contact from the Contacts folder.
            var oItems = cContacts.Items;
            Outlook.ContactItem oCt;
            int K = oItems.Count;
            var iCount = default(int);
            bool bContact = false;
            var loopTo = K;
            for (I = 0; I <= loopTo; I++)
            {
                try
                {
                    System.Windows.Forms.Application.DoEvents();
                    // frmReconMain.PB1.Value = I
                    oCt = (Outlook.ContactItem)oItems[(object)I];
                    int II = 0;
                    FrmInfo.lblMsg2.Text = "Contacts: " + I + " of " + K;
                    FrmInfo.Refresh();
                    System.Windows.Forms.Application.DoEvents();
                    Email1Address = oCt.Email1Address;
                    if (Email1Address is null)
                    {
                        Email1Address = "NA";
                    }

                    Email1Address = UTIL.RemoveSingleQuotes(Email1Address);
                    FullName = oCt.FullName;
                    if (Strings.Len(FullName.Trim()) == 0)
                    {
                        LOG.WriteToArchiveLog("ERROR: Full name must be supplied for conntact, skipping EMAIL address '" + Email1Address + "'");
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
                        if (!b)
                        {
                            LOG.WriteToArchiveLog("ERROR 100 Contact " + FullName + " / " + Email1Address + " not loaded.");
                        }
                    }

                    Account = oCt.Account;
                    Anniversary = Conversions.ToString(oCt.Anniversary);
                    Application = oCt.Application.ToString();
                    AssistantName = oCt.AssistantName;
                    AssistantTelephoneNumber = oCt.AssistantTelephoneNumber;
                    BillingInformation = oCt.BillingInformation;
                    Birthday = Conversions.ToString(oCt.Birthday);
                    Business2TelephoneNumber = oCt.Business2TelephoneNumber;
                    BusinessAddress = oCt.BusinessAddress;
                    BusinessAddressCity = oCt.BusinessAddressCity;
                    BusinessAddressCountry = oCt.BusinessAddressCountry;
                    BusinessAddressPostalCode = oCt.BusinessAddressPostalCode;
                    BusinessAddressPostOfficeBox = oCt.BusinessAddressPostOfficeBox;
                    BusinessAddressState = oCt.BusinessAddressState;
                    BusinessAddressStreet = oCt.BusinessAddressStreet;
                    BusinessCardType = ((int)oCt.BusinessCardType).ToString();
                    BusinessFaxNumber = oCt.BusinessFaxNumber;
                    BusinessHomePage = oCt.BusinessHomePage;
                    BusinessTelephoneNumber = oCt.BusinessTelephoneNumber;
                    CallbackTelephoneNumber = oCt.CallbackTelephoneNumber;
                    CarTelephoneNumber = oCt.CarTelephoneNumber;
                    Categories = oCt.Categories;
                    Children = oCt.Children;
                    xClass = ((int)oCt.Class).ToString();
                    Companies = oCt.Companies;
                    CompanyName = oCt.CompanyName;
                    ComputerNetworkName = oCt.ComputerNetworkName;
                    Conflicts = oCt.Conflicts.ToString();
                    ConversationTopic = oCt.ConversationTopic;
                    CreationTime = Conversions.ToString(oCt.CreationTime);
                    CustomerID = oCt.CustomerID;
                    Department = oCt.Department;
                    if (Email1Address == null)
                    {
                        Email1Address = " ";
                    }

                    if (Strings.Len(Email1Address.Trim()) == 0 | Email1Address == null)
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
                    Gender = ((int)oCt.Gender).ToString();
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
                    Importance = ((int)oCt.Importance).ToString();
                    Initials = oCt.Initials;
                    InternetFreeBusyAddress = oCt.InternetFreeBusyAddress;
                    JobTitle = oCt.JobTitle;
                    Journal = Conversions.ToString(oCt.Journal);
                    Language = oCt.Language;
                    LastModificationTime = Conversions.ToString(oCt.LastModificationTime);
                    if (Conversions.ToDate(LastModificationTime) > SkipArchiveDate)
                    {
                        // ** Write out a new last mod date
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

                    // Email1Address = UTIL.RemoveSingleQuotes(Email1Address)
                    // FullName = UTIL.RemoveSingleQuotes(FullName)

                    // Dim bContact As Boolean = DBLocal.contactExists(FullName, Email1Address)

                    // If bContact Then
                    // GoTo SkipContact
                    // Else
                    // bContact = DBLocal.addContact(FullName, Email1Address)
                    // Dim b As Boolean = CNTCT.Insert()
                    // If Not b Then
                    // LOG.WriteToArchiveLog("ERROR 100 Contact " & FullName + " / " + Email1Address + " not loaded.")
                    // End If
                    // End If

                    System.Windows.Forms.Application.DoEvents();
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("Error: " + ex.Message);
                    LOG.WriteToArchiveLog("Contact " + FullName + " / " + Email1Address + " not loaded.");
                }

                SkipContact:
                ;
            }

            Console.WriteLine(iCount);

            // Clean up.
            FrmInfo.Close();
            FrmInfo.Dispose();
            oApp = null;
            oItems = null;
            oCt = null;
            GC.Collect();
            // frmReconMain.PB1.Value = 0
            // frmReconMain.SB.Text = "Complete, " + I.ToString + " contacts processed."
            LOG.WriteToArchiveLog("INFO: Contact archive Complete, " + I.ToString() + " contacts processed.");
            Thread.EndCriticalRegion();
        }

        public void RetrieveContactEmailInfo(DataGridView DG, string UID)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            // Create Outlook application.
            var oApp = new Outlook.Application();

            // Get namespace and Contacts folder reference.
            var oNS = oApp.GetNamespace("MAPI");
            var cContacts = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderContacts);

            // Get the first contact from the Contacts folder.
            var oItems = cContacts.Items;
            Outlook.ContactItem oCt;
            int K = oItems.Count;
            int iCount;
            iCount = 0;
            try
            {
                DG.Rows.Clear();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Moving on...");
            }

            DG.Columns.Add("ea", "Email Address");
            DG.Columns["ea"].Width = 150;
            DG.Columns.Add("fn", "Full Name");
            DG.Columns["fn"].Width = 250;
            DG.Columns.Add("UserID", "UserID");
            DG.Columns["UserID"].Width = 75;

            // DG.Columns(0).HeaderText = "Email Address"
            // DG.Columns(1).HeaderText = "Full Name"
            // DG.Columns(2).HeaderText = "UserID"

            for (int i = 0, loopTo = K - 1; i <= loopTo; i++)
            {
                try
                {
                    DG.Rows.Add();
                    oCt = (Outlook.ContactItem)oItems[(object)i];
                    if (i % 25 == 0)
                    {
                        if (xDebug)
                            LOG.WriteToArchiveLog("Row# " + i);
                    }
                    // Console.WriteLine(oCt.FullName)
                    // Console.WriteLine(oCt.Email1Address)
                    // Console.WriteLine("ROWS = " & DG.Rows.Count)
                    string SenderEmailAddress = oCt.Email1Address;
                    string SenderName = oCt.FullName;
                    // DG.Rows(iCount).Cells("UserID").Value = UID

                    string MySql = "";
                    MySql = MySql + " SELECT count(*) as cnt";
                    MySql = MySql + " FROM  [ContactFrom]";
                    MySql = MySql + " where FromEmailAddr = '" + SenderEmailAddress + "'";
                    MySql = MySql + " and SenderName = '" + SenderName + "'";
                    MySql = MySql + " and UserID = '" + modGlobals.gCurrUserGuidID + "'";
                    if (SenderEmailAddress.Trim().Length > 0)
                    {
                        int bb = iDataExist(MySql);
                        if (bb > 0)
                        {
                            MySql = MySql + " Update  [ContactFrom]";
                            MySql = MySql + " set [Verified] = 1 ";
                            MySql = MySql + " where FromEmailAddr = '" + SenderEmailAddress + "'";
                            MySql = MySql + " and SenderName = '" + SenderName + "'";
                            MySql = MySql + " and UserID = '" + modGlobals.gCurrUserGuidID + "'";
                            bool bSuccess = ExecuteSqlNewConn(MySql, false);
                            if (!bSuccess)
                            {
                                if (xDebug)
                                    LOG.WriteToArchiveLog("Update failed:" + Constants.vbCrLf + MySql);
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
                            MySql = MySql + "'" + SenderEmailAddress + "',";
                            MySql = MySql + " '" + SenderName + "',";
                            MySql = MySql + " '" + modGlobals.gCurrUserGuidID + "',";
                            MySql = MySql + " 1)";
                            bool bSuccess = ExecuteSqlNewConn(MySql, false);
                            if (!bSuccess)
                            {
                                if (xDebug)
                                    LOG.WriteToArchiveLog("Insert failed:" + Constants.vbCrLf + MySql);
                            }
                        }
                    }

                    Application.DoEvents();
                    iCount = iCount + 1;
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error: " + ex.Message);
                    Console.WriteLine("Contact " + i + " not loaded.");
                }
            }

            Console.WriteLine(iCount);

            // Clean up.
            oApp = null;
            oItems = null;
            oCt = null;
            GC.Collect();
        }

        public void PopulateExcludedSendersFromTbl(DataGridView DG)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string FromEmailAddr = "";
            string SenderName = "";
            string UserID = "";
            string S = "";
            S = S + " SELECT [FromEmailAddr],[SenderName],[UserID] ";
            S = S + " FROM  [ExcludeFrom]";
            S = S + " where UserID = '" + modGlobals.gCurrUserGuidID + "' ";
            S = S + " order by [FromEmailAddr],[SenderName]";
            int iCount;
            iCount = 0;
            try
            {
                DG.Rows.Clear();
            }
            catch (Exception ex)
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
            string CS = setConnStr();   // getGateWayConnStr(gGateWayID)
            var CONN = new SqlConnection(CS);
            CONN.Open();
            var command = new SqlCommand(S, CONN);
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
                        // if xDebug then log.WriteToArchiveLog(FromEmailAddr )
                        // Console.WriteLine("ROWS = " & DG.Rows.Count)
                        DG.Rows[iCount].Cells["ea"].Value = FromEmailAddr;
                        DG.Rows[iCount].Cells["fn"].Value = SenderName;
                        DG.Rows[iCount].Cells["UserID"].Value = UserID;
                        iCount = iCount + 1;
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("Error: " + ex.Message);
                        Console.WriteLine("Contact " + FromEmailAddr + " not loaded.");
                    }

                    Application.DoEvents();
                }
            }

            if (!rsData.IsClosed)
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

        public void PopulateContactGridOutlookFromTbl(DataGridView DG)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string FromEmailAddr = "";
            string SenderName = "";
            string UserID = "";
            string S = "";
            S = S + " SELECT [FromEmailAddr],[SenderName],[UserID] ";
            S = S + " FROM  [OutlookFrom]";
            S = S + " where UserID = '" + modGlobals.gCurrUserGuidID + "' and Verified = 1 ";
            S = S + " order by [FromEmailAddr],[SenderName]";
            int iCount;
            iCount = 0;
            try
            {
                DG.Rows.Clear();
            }
            catch (Exception ex)
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
            string CS = setConnStr();   // getGateWayConnStr(gGateWayID)
            var CONN = new SqlConnection(CS);
            CONN.Open();
            var command = new SqlCommand(S, CONN);
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
                        // if xDebug then log.WriteToArchiveLog(FromEmailAddr )
                        // Console.WriteLine("ROWS = " & DG.Rows.Count)
                        DG.Rows[iCount].Cells["ea"].Value = FromEmailAddr;
                        DG.Rows[iCount].Cells["fn"].Value = SenderName;
                        DG.Rows[iCount].Cells["UserID"].Value = UserID;
                        iCount = iCount + 1;
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("Error: " + ex.Message);
                        Console.WriteLine("Contact " + FromEmailAddr + " not loaded.");
                    }

                    Application.DoEvents();
                }
            }

            if (!rsData.IsClosed)
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

        public void PopulateContactGridContactFromTbl(DataGridView DG)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string FromEmailAddr = "";
            string SenderName = "";
            string UserID = "";
            string S = "";
            S = S + " SELECT [FromEmailAddr],[SenderName],[UserID] ";
            S = S + " FROM  [ContactFrom]";
            S = S + " where UserID = '" + modGlobals.gCurrUserGuidID + "' and Verified = 1 ";
            S = S + " order by [FromEmailAddr],[SenderName]";
            int iCount;
            iCount = 0;
            try
            {
                DG.Rows.Clear();
            }
            catch (Exception ex)
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
            string CS = setConnStr();   // getGateWayConnStr(gGateWayID)
            var CONN = new SqlConnection(CS);
            CONN.Open();
            var command = new SqlCommand(S, CONN);
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
                        // if xDebug then log.WriteToArchiveLog(FromEmailAddr )
                        // Console.WriteLine("ROWS = " & DG.Rows.Count)
                        DG.Rows[iCount].Cells["ea"].Value = FromEmailAddr;
                        DG.Rows[iCount].Cells["fn"].Value = SenderName;
                        DG.Rows[iCount].Cells["UserID"].Value = UserID;
                        iCount = iCount + 1;
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("Error: " + ex.Message);
                        Console.WriteLine("Contact " + FromEmailAddr + " not loaded.");
                    }

                    Application.DoEvents();
                }
            }

            if (!rsData.IsClosed)
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

        public void PopulateContactGrid(DataGridView DG, string S)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

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
            catch (Exception ex)
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
            string CS = setConnStr();   // getGateWayConnStr(gGateWayID)
            var CONN = new SqlConnection(CS);
            CONN.Open();
            var command = new SqlCommand(S, CONN);
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
                        // if xDebug then log.WriteToArchiveLog(FromEmailAddr )
                        // Console.WriteLine("ROWS = " & DG.Rows.Count)
                        DG.Rows[iCount].Cells["ea"].Value = FromEmailAddr;
                        DG.Rows[iCount].Cells["fn"].Value = SenderName;
                        DG.Rows[iCount].Cells["UserID"].Value = UserID;
                        iCount = iCount + 1;
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine("Error: " + ex.Message);
                        Console.WriteLine("Contact " + FromEmailAddr + " not loaded.");
                    }

                    Application.DoEvents();
                }
            }

            if (!rsData.IsClosed)
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
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string filename = "";
            Outlook.Application objOL;
            Outlook.NameSpace objNS;
            // Dim objFolder As Outlook.Folders
            // Dim Item As Object
            Outlook.Items myItems;
            short x;
            objOL = new Outlook.Application();
            objNS = objOL.GetNamespace("MAPI");
            Outlook.MAPIFolder olfolder;
            olfolder = objOL.GetNamespace("MAPI").PickFolder();
            myItems = olfolder.Items;
            int i = 0;
            var loopTo = (short)myItems.Count;
            for (x = 1; x <= loopTo; x++)
            {
                string EmailSenderName = Conversions.ToString(myItems[(object)x].SenderName);
                string EmailSenderEmailAddress = Conversions.ToString(myItems[(object)x].SenderEmailAddress);
                string EmailSubject = Conversions.ToString(myItems[(object)x].Subject);
                string EmailBody = Conversions.ToString(myItems[(object)x].Body);
                string FullBody;
                // *************** DO NOT SAVE THE WHOLE BODY, JUST THE FIRST 100 CHARACTERS *****************
                // EmailBody = EmailBody.Substring(0, 100)
                // *******************************************************************************************

                string EmailTo = Conversions.ToString(myItems[(object)x].to);
                string EmailReceivedByName = Conversions.ToString(myItems[(object)x].ReceivedByName);
                string EmailReceivedOnBehalfOfName = Conversions.ToString(myItems[(object)x].ReceivedOnBehalfOfName);
                string EmailReplyRecipientNames = Conversions.ToString(myItems[(object)x].ReplyRecipientNames);
                string EmailSentOnBehalfOfName = Conversions.ToString(myItems[(object)x].SentOnBehalfOfName);
                string EmailCC = Conversions.ToString(myItems[(object)x].CC);
                string EmailReceivedTime = Conversions.ToString(myItems[(object)x].ReceivedTime);
                foreach (Outlook.Attachment Atmt in (IEnumerable)myItems[(object)x].Attachments)
                {
                    filename = DMA.getEnvVarTempDir() + @"\" + Atmt.FileName;
                    Atmt.SaveAsFile(filename);
                }
            }
        }

        public string OutlookFolderNames(string MailboxName, bool bTest)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            try
            {
                // ********************************************************
                // PARAMETER: MailboxName = Name of Parent Outlook Folder for
                // the current user: Usually in the form of
                // "Mailbox - Doe, John" or
                // "Public Folders
                // RETURNS: Array of SubFolders in Current User's Mailbox
                // Or unitialized array if error occurs
                // Because it returns an array, it is for VB6 only.
                // Change to return a variant or a delimited list for
                // previous versions of vb
                // EXAMPLE:
                // Dim sArray() As String
                // Dim ictr As Integer
                // sArray = OutlookFolderNames("Mailbox - Doe, John")
                // 'On Error Resume Next
                // For ictr = 0 To UBound(sArray)
                // if xDebug then log.WriteToArchiveLog sArray(ictr)
                // Next
                // *********************************************************
                Outlook.Application oOutlook;
                Outlook._NameSpace oMAPI;
                Outlook.MAPIFolder oParentFolder;
                var sArray = default(string[]);
                int i;
                int iElement = 0;
                oOutlook = new Outlook.Application();
                oMAPI = oOutlook.GetNamespace("MAPI");
                MailboxName = "Personal Folders";
                oParentFolder = oMAPI.Folders[MailboxName];
                Array.Resize(ref sArray, 1);
                if (oParentFolder.Folders.Count != 0)
                {
                    var loopTo = oParentFolder.Folders.Count;
                    for (i = 1; i <= loopTo; i++)
                    {
                        if (!string.IsNullOrEmpty(Strings.Trim(oParentFolder.Folders[i].Name)))
                        {
                            if (xDebug)
                                LOG.WriteToArchiveLog(oParentFolder.Folders[i].Name);
                            // If Trim(oMAPI.GetDefaultFolder(OlDefaultFolders.olFolderInbox).Folders.Item(i).Name) <> "" Then
                            // If sArray(0) = "" Then
                            // iElement = 0
                            // Else
                            // iElement = UBound(sArray) + 1
                            // End If
                            // ReDim Preserve sArray(iElement)
                            // sArray(iElement) = oParentFolder.Folders.Item(i).Name
                            // End If
                        }
                    }
                }
                else
                {
                    sArray[0] = oParentFolder.Name;
                }

                // OutlookFolderNames = sArray
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
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var oOutlook = new Outlook.Application();
            Outlook.NameSpace oMAPI = null;
            Outlook.MAPIFolder oParentFolder = null;
            Outlook.MAPIFolder oChildFolder = null;
            var Containers = new List<string>();

            // RegisterAllContainers(Containers)
            try
            {
                oMAPI = (Outlook.NameSpace)oMAPI.GetNamespace("MAPI");
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR : RegisterOutlookContainers 200 - " + ex.Message);
                return;
            }

            int iFolderCount = oMAPI.Folders.Count;
            foreach (Outlook.MAPIFolder MF in oMAPI.Folders)
            {
                if (ddebug)
                    Console.WriteLine(MF.Name);
                Containers.Add(MF.Name);
            }

            foreach (string Container in Containers)
            {
                // RegisterChildFolders(ByVal Container , ByVal oChildFolder As Outlook.MAPIFolder, ByVal FQN )
                try
                {
                    oParentFolder = oMAPI.Folders[Container];
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("ERROR: RegisterOutlookContainers 100 - " + ex.Message);
                }

                foreach (Outlook.MAPIFolder currentOChildFolder in oParentFolder.Folders)
                {
                    oChildFolder = currentOChildFolder;
                    int K = 0;
                    K = oChildFolder.Folders.Count;
                    string cFolder = oChildFolder.Name.ToString();
                    if (xDebug)
                        LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 010: '" + cFolder + "'.");
                    // LB.Items.Add(cFolder )
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

        public void RegisterAllContainers(ref List<string> Containers)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            bool bOfficeInstalled = true;
            bool B = false;
            Containers.Clear();
            Outlook.Application oOutlook;
            Outlook.NameSpace oMAPI = null;
            Outlook.MAPIFolder oParentFolder = null;
            Outlook.MAPIFolder oChildFolder = null;
            // Dim sArray() As String
            // Dim i As Integer
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
                if (ddebug)
                    Console.WriteLine(MF.Name);
                Containers.Add(MF.Name);
            }

            oOutlook = null;
            oMAPI = null;
            oParentFolder = null;
            oChildFolder = null;
        }

        public void GetContainerFolders(List<string> Containers, ref List<string> EmailFolders)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            bool bOfficeInstalled = true;

            /* TODO ERROR: Skipped IfDirectiveTrivia *//* TODO ERROR: Skipped DisabledTextTrivia *//* TODO ERROR: Skipped ElseDirectiveTrivia */
            bOfficeInstalled = UTIL.isOffice2003Installed();
            /* TODO ERROR: Skipped EndIfDirectiveTrivia */
            if (bOfficeInstalled == false)
            {
                return;
            }

            bool B = false;
            if (xDebug)
                LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 001: ");
            EmailFolders.Clear();

            // ********************************************************
            // PARAMETER: MailboxName = Name of Parent Outlook Folder for
            // the current user: Usually in the form of
            // "Mailbox - Doe, John" or
            // "Public Folders
            // RETURNS: Array of SubFolders in Current User's Mailbox
            // Or unitialized array if error occurs
            // Because it returns an array, it is for VB6 only.
            // Change to return a variant or a delimited list for
            // previous versions of vb
            // EXAMPLE:
            // Dim sArray() As String
            // Dim ictr As Integer
            // sArray = OutlookFolderNames("Mailbox - Doe, John")
            // 'On Error Resume Next
            // For ictr = 0 To UBound(sArray)
            // if xDebug then log.WriteToArchiveLog sArray(ictr)
            // Next
            // *********************************************************
            Outlook.Application oOutlook;
            Outlook.NameSpace oMAPI = null;
            Outlook.MAPIFolder oParentFolder = null;
            Outlook.MAPIFolder oChildFolder = null;
            // Dim sArray() As String
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
                    LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 002: '" + Container + "'.");
                var aFolders = new List<string>();
                int iFolderCount = oMAPI.Folders.Count;
                try
                {
                    oParentFolder = oMAPI.Folders[Container];
                    var loopTo = oParentFolder.Folders.Count;
                    for (i = 1; i <= loopTo; i++)
                    {
                        Console.WriteLine(oParentFolder.Folders[i].Name);
                        if (xDebug)
                            LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 003: '" + oParentFolder.Folders[i].Name);
                        bool isEmailFolder = false;
                        int NbrOfItemsTested = 0;
                        if (oParentFolder.Folders[i] is Outlook.MAPIFolder)
                        {
                            if (xDebug)
                                LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 004: '" + oParentFolder.Folders[i].Name);
                            foreach (object Obj in oParentFolder.Folders[i].Items)
                            {
                                NbrOfItemsTested += 1;
                                Console.WriteLine(Obj.ToString());
                                if (Obj is Outlook.MailItem)
                                {
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 005: '" + oParentFolder.Folders[i].Name);
                                    isEmailFolder = true;
                                    break;
                                }
                                else
                                {
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 006: '" + oParentFolder.Folders[i].Name);
                                    if (NbrOfItemsTested > 10)
                                    {
                                        isEmailFolder = false;
                                        break;
                                    }
                                }
                            }

                            if (isEmailFolder == false & modGlobals.gEmailArchiveDisabled.Equals(false))
                            {
                                LOG.WriteToArchiveLog("WARNING: THIS FOLDER COULD NOT BE VERIFIED TO BE AN EMAIL FOLDER. It will be processed as if it is as it has been selected by a user: " + oParentFolder.Folders[i].Name);
                                isEmailFolder = true;
                            }
                        }
                        else if (xDebug)
                            LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 007: '" + oParentFolder.Folders[i].Name);
                        if (NbrOfItemsTested == 0)
                        {
                            isEmailFolder = true;
                        }

                        if (isEmailFolder == true)
                        {
                            if (xDebug)
                                LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 008: '" + oParentFolder.Folders[i].Name + " : Appears to be an email folder.");
                        }
                        else
                        {
                            if (xDebug)
                                LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 008: '" + oParentFolder.Folders[i].Name + " : Appears NOT to be an email folder.");
                            goto SkipThisNonEmailFolder;
                        }

                        // If TypeOf oParentFolder Is Outlook.MailItem Then
                        // Console.WriteLine(oParentFolder.Folders.Item(i).Name)
                        // End If

                        if (!string.IsNullOrEmpty(Strings.Trim(oParentFolder.Folders[i].Name)))
                        {
                            string StoreID = oParentFolder.StoreID;
                            /* TODO ERROR: Skipped IfDirectiveTrivia *//* TODO ERROR: Skipped DisabledTextTrivia *//* TODO ERROR: Skipped ElseDirectiveTrivia */
                            string StoreName = "";
                            try
                            {
                                StoreName = oParentFolder.Name;
                            }
                            catch (Exception ex)
                            {
                                StoreName = "Not Available";
                            }

                            if (xDebug)
                                LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 009 Office 2003: '" + StoreName + "'.");
                            /* TODO ERROR: Skipped EndIfDirectiveTrivia */
                            string ParentID = oParentFolder.EntryID;
                            string ChildID = oParentFolder.Folders[i].EntryID;
                            string tFolderName = oParentFolder.Folders[i].Name;
                            if (xDebug)
                                LOG.WriteToArchiveLog(tFolderName);
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
                                    string argval = oParentFolder.Name;
                                    EMF.setParentfoldername(ref argval);
                                    oParentFolder.Name = argval;
                                    EMF.setUserid(ref modGlobals.gCurrUserGuidID);
                                    EMF.setStoreid(ref StoreID);
                                    bool BB = EMF.Insert(Container);
                                }
                                // If Not BB Then
                                // messagebox.show("Did not add folder " + tFolderName  + " to list of folders...")
                                // End If
                                catch (Exception ex)
                                {
                                    LOG.WriteToArchiveLog("ERROR: getOutlookFolderNames 100: " + ex.Message + Constants.vbCrLf + Constants.vbCrLf + ex.StackTrace);
                                    LOG.WriteToArchiveLog("ERROR: getOutlookFolderNames 100: tFolderName  = " + tFolderName + " : " + "oParentFolder.Name = " + oParentFolder.Name);
                                }
                            }
                            else
                            {
                                string WC = EMF.wc_UI_EmailFolder(Container, tFolderName, modGlobals.gCurrUserGuidID);
                                EMF.setFolderid(ref ChildID);
                                EMF.setFoldername(ref tFolderName);
                                EMF.setParentfolderid(ref ParentID);
                                string argval1 = oParentFolder.Name;
                                EMF.setParentfoldername(ref argval1);
                                oParentFolder.Name = argval1;
                                EMF.setUserid(ref modGlobals.gCurrUserGuidID);
                                EMF.setStoreid(ref StoreID);
                                bool BB = EMF.Insert(Container);
                            }
                        }

                        SkipThisNonEmailFolder:
                        ;
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
        }

        public bool getOutlookFolderNames(string FileDirectory, ref ListBox LB)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            bool bOfficeInstalled = true;
            try
            {
                bOfficeInstalled = UTIL.isOffice2007Installed();
            }
            catch (Exception ex)
            {
                try
                {
                    bOfficeInstalled = UTIL.isOffice2003Installed();
                }
                catch (Exception ex2)
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
                    LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 001: ");
                LB.Items.Clear();

                // ********************************************************
                // PARAMETER: MailboxName = Name of Parent Outlook Folder for
                // the current user: Usually in the form of
                // "Mailbox - Doe, John" or
                // "Public Folders
                // RETURNS: Array of SubFolders in Current User's Mailbox
                // Or unitialized array if error occurs
                // Because it returns an array, it is for VB6 only.
                // Change to return a variant or a delimited list for
                // previous versions of vb
                // EXAMPLE:
                // Dim sArray() As String
                // Dim ictr As Integer
                // sArray = OutlookFolderNames("Mailbox - Doe, John")
                // 'On Error Resume Next
                // For ictr = 0 To UBound(sArray)
                // if xDebug then log.WriteToArchiveLog sArray(ictr)
                // Next
                // *********************************************************
                Outlook.Application oOutlook;
                Outlook.NameSpace oMAPI = null;
                Outlook.MAPIFolder oParentFolder = null;
                // Dim sArray() As String
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

                // Dim MailboxName  = System.Configuration.ConfigurationManager.AppSettings("EmailFolder1")
                string MailboxName = "";
                MailboxName = FileDirectory;
                if (xDebug)
                    LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 002: '" + MailboxName + "'.");
                var OutlookContainers = new List<string>();
                int iFolderCount = oMAPI.Folders.Count;
                RegisterAllContainers(ref OutlookContainers);
                try
                {
                    oParentFolder = oMAPI.Folders[MailboxName];
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }

                // AddChildFolders(LB, MailboxName )

                if (oParentFolder.Folders.Count != 0)
                {
                    var loopTo = oParentFolder.Folders.Count;
                    for (i = 1; i <= loopTo; i++)
                    {
                        Console.WriteLine(oParentFolder.Folders[i].Name);
                        if (xDebug)
                            LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 003: '" + oParentFolder.Folders[i].Name);
                        bool isEmailFolder = false;
                        int NbrOfItemsTested = 0;
                        if (oParentFolder.Folders[i] is Outlook.MAPIFolder)
                        {
                            if (xDebug)
                                LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 004: '" + oParentFolder.Folders[i].Name);
                            foreach (object Obj in oParentFolder.Folders[i].Items)
                            {
                                NbrOfItemsTested += 1;
                                Console.WriteLine(Obj.ToString());
                                if (Obj is Outlook.MailItem)
                                {
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 005: '" + oParentFolder.Folders[i].Name);
                                    isEmailFolder = true;
                                    break;
                                }
                                else
                                {
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 006: '" + oParentFolder.Folders[i].Name);
                                    if (NbrOfItemsTested > 10)
                                    {
                                        isEmailFolder = false;
                                        break;
                                    }
                                }
                            }

                            if (isEmailFolder == false & modGlobals.gEmailArchiveDisabled.Equals(false))
                            {
                                LOG.WriteToArchiveLog("WARNING: THIS FOLDER COULD NOT BE VERIFIED TO BE AN EMAIL FOLDER. It will be processed as if it is as it has been selected by a user: " + oParentFolder.Folders[i].Name);
                                isEmailFolder = true;
                            }
                        }
                        else if (xDebug)
                            LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 007: '" + oParentFolder.Folders[i].Name);
                        if (NbrOfItemsTested == 0)
                        {
                            isEmailFolder = true;
                        }

                        if (isEmailFolder == true)
                        {
                            if (xDebug)
                                LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 008: '" + oParentFolder.Folders[i].Name + " : Appears to be an email folder.");
                        }
                        else
                        {
                            if (xDebug)
                                LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 008: '" + oParentFolder.Folders[i].Name + " : Appears NOT to be an email folder.");
                            goto SkipThisNonEmailFolder;
                        }

                        // If TypeOf oParentFolder Is Outlook.MailItem Then
                        // Console.WriteLine(oParentFolder.Folders.Item(i).Name)
                        // End If

                        if (!string.IsNullOrEmpty(Strings.Trim(oParentFolder.Folders[i].Name)))
                        {
                            string StoreID = oParentFolder.StoreID;
                            /* TODO ERROR: Skipped IfDirectiveTrivia *//* TODO ERROR: Skipped DisabledTextTrivia *//* TODO ERROR: Skipped ElseDirectiveTrivia */
                            string StoreName = "";
                            try
                            {
                                StoreName = oParentFolder.Name;
                            }
                            catch (Exception ex)
                            {
                                StoreName = "Not Available";
                            }

                            if (xDebug)
                                LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 009 Office 2003: '" + StoreName + "'.");
                            /* TODO ERROR: Skipped EndIfDirectiveTrivia */
                            string ParentID = oParentFolder.EntryID;
                            string ChildID = oParentFolder.Folders[i].EntryID;
                            string tFolderName = oParentFolder.Folders[i].Name;
                            if (xDebug)
                                LOG.WriteToArchiveLog(tFolderName);
                            Console.WriteLine("Folder: " + tFolderName);
                            tFolderName = tFolderName.Trim();
                            int II = EMF.cnt_PK_EmailFolder(ChildID, modGlobals.gCurrUserGuidID);
                            II = EMF.cnt_UI_EmailFolder(FileDirectory, tFolderName, modGlobals.gCurrUserGuidID);
                            if (II == 0)
                            {
                                try
                                {
                                    EMF.setFolderid(ref ChildID);
                                    EMF.setFoldername(ref tFolderName);
                                    EMF.setParentfolderid(ref ParentID);
                                    string argval = oParentFolder.Name;
                                    EMF.setParentfoldername(ref argval);
                                    oParentFolder.Name = argval;
                                    EMF.setUserid(ref modGlobals.gCurrUserGuidID);
                                    EMF.setStoreid(ref StoreID);
                                    string argval1 = "?";
                                    EMF.setSelectedforarchive(ref argval1);
                                    bool BB = EMF.Insert(FileDirectory);
                                }
                                // If Not BB Then
                                // messagebox.show("Did not add folder " + tFolderName  + " to list of folders...")
                                // End If
                                catch (Exception ex)
                                {
                                    LOG.WriteToArchiveLog("ERROR: getOutlookFolderNames 100: " + ex.Message + Constants.vbCrLf + Constants.vbCrLf + ex.StackTrace);
                                    LOG.WriteToArchiveLog("ERROR: getOutlookFolderNames 100: tFolderName  = " + tFolderName + " : " + "oParentFolder.Name = " + oParentFolder.Name);
                                }
                            }
                            else
                            {
                                string FolderFQN = oParentFolder.Name.Trim() + "|" + tFolderName.Trim();
                                string WC = EMF.wc_UI_EmailFolder(FileDirectory, FolderFQN, modGlobals.gCurrUserGuidID);
                                EMF.setFolderid(ref ChildID);
                                EMF.setFoldername(ref FolderFQN);
                                EMF.setParentfolderid(ref ParentID);
                                string argval2 = oParentFolder.Name;
                                EMF.setParentfoldername(ref argval2);
                                oParentFolder.Name = argval2;
                                EMF.setUserid(ref modGlobals.gCurrUserGuidID);
                                EMF.setStoreid(ref StoreID);
                                string argval3 = "?";
                                EMF.setSelectedforarchive(ref argval3);
                                bool BB = EMF.Update(WC);
                                if (!BB)
                                {
                                    LOG.WriteToArchiveLog("ERROR: 102 Failed to update Email Folder : " + FileDirectory + " : " + tFolderName);
                                }
                            }

                            LB.Items.Add(oParentFolder.Folders[i].Name);
                        }

                        SkipThisNonEmailFolder:
                        ;
                    }
                }

                foreach (Outlook.MAPIFolder oChildFolder in oParentFolder.Folders)
                {
                    int K = 0;
                    K = oChildFolder.Folders.Count;
                    string cFolder = oChildFolder.Name.ToString();
                    if (xDebug)
                        LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 010: '" + cFolder + "'.");
                    // LB.Items.Add(cFolder )
                    if (K > 0)
                    {
                        ListChildFolders(FileDirectory, oChildFolder, ref LB, cFolder);
                    }
                }

                oMAPI = null;
                GC.Collect();
                B = true;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 653.21a: " + ex.Message);
                LOG.WriteToArchiveLog("ERROR 653.21a clsArchiver:getOutlookFolderNames 011: '" + ex.Message + "'.");
                B = false;
            }

            if (xDebug)
                LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 012.");
            return B;
        }

        public bool getOutlookFolderNames(string TopLevelOutlookFolderName)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            bool B = false;
            try
            {
                if (xDebug)
                    LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 001: ");
                Outlook.Application oOutlook;
                Outlook.NameSpace oMAPI = null;
                Outlook.MAPIFolder oParentFolder = null;
                // Dim sArray() As String
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

                // Dim MailboxName  = System.Configuration.ConfigurationManager.AppSettings("EmailFolder1")
                string MailboxName = "";
                MailboxName = TopLevelOutlookFolderName;
                if (xDebug)
                    LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 002: '" + MailboxName + "'.");
                var aFolders = new List<string>();
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

                // AddChildFolders(LB, MailboxName )

                if (oParentFolder.Folders.Count != 0)
                {
                    var loopTo = oParentFolder.Folders.Count;
                    for (i = 1; i <= loopTo; i++)
                    {
                        if (xDebug)
                            LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 003: '" + oParentFolder.Folders[i].Name);
                        bool isEmailFolder = false;
                        int NbrOfItemsTested = 0;
                        if (oParentFolder.Folders[i] is Outlook.MAPIFolder)
                        {
                            if (xDebug)
                                LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 004: '" + oParentFolder.Folders[i].Name);
                            foreach (object Obj in oParentFolder.Folders[i].Items)
                            {
                                NbrOfItemsTested += 1;
                                if (Obj is Outlook.MailItem)
                                {
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 005: '" + oParentFolder.Folders[i].Name);
                                    isEmailFolder = true;
                                    break;
                                }
                                else
                                {
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 006: '" + oParentFolder.Folders[i].Name);
                                    if (NbrOfItemsTested > 20)
                                    {
                                        break;
                                    }
                                }
                            }
                        }
                        else if (xDebug)
                            LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 007: '" + oParentFolder.Folders[i].Name);
                        if (NbrOfItemsTested == 0)
                        {
                            isEmailFolder = true;
                        }

                        if (isEmailFolder == true)
                        {
                            if (xDebug)
                                LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 008: '" + oParentFolder.Folders[i].Name + " : Appears to be an email folder.");
                        }
                        else
                        {
                            if (xDebug)
                                LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 008: '" + oParentFolder.Folders[i].Name + " : Appears NOT to be an email folder.");
                            goto SkipThisNonEmailFolder;
                        }

                        // If TypeOf oParentFolder Is Outlook.MailItem Then
                        // Console.WriteLine(oParentFolder.Folders.Item(i).Name)
                        // End If

                        if (!string.IsNullOrEmpty(Strings.Trim(oParentFolder.Folders[i].Name)))
                        {
                            string StoreID = oParentFolder.StoreID;
                            /* TODO ERROR: Skipped IfDirectiveTrivia *//* TODO ERROR: Skipped DisabledTextTrivia *//* TODO ERROR: Skipped ElseDirectiveTrivia */
                            string StoreName = oParentFolder.Name;
                            if (xDebug)
                                LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 009 Office 2003: '" + StoreName + "'.");
                            /* TODO ERROR: Skipped EndIfDirectiveTrivia */
                            string ParentID = oParentFolder.EntryID;
                            string ChildID = oParentFolder.Folders[i].EntryID;
                            string tFolderName = oParentFolder.Folders[i].Name;
                            if (xDebug)
                                LOG.WriteToArchiveLog(tFolderName);
                            int II = EMF.cnt_PK_EmailFolder(ChildID, modGlobals.gCurrUserGuidID);
                            II = EMF.cnt_UI_EmailFolder(TopLevelOutlookFolderName, tFolderName, modGlobals.gCurrUserGuidID);
                            if (II == 0)
                            {
                                EMF.setFolderid(ref ChildID);
                                EMF.setFoldername(ref tFolderName);
                                EMF.setParentfolderid(ref ParentID);
                                string argval = oParentFolder.Name;
                                EMF.setParentfoldername(ref argval);
                                oParentFolder.Name = argval;
                                EMF.setUserid(ref modGlobals.gCurrUserGuidID);
                                EMF.setStoreid(ref StoreID);
                                bool BB = EMF.Insert(TopLevelOutlookFolderName);
                                // If Not BB Then
                                // messagebox.show("Did not add folder " + tFolderName  + " to list of folders...")
                                // End If
                            }
                        }

                        SkipThisNonEmailFolder:
                        ;
                    }
                }

                foreach (Outlook.MAPIFolder oChildFolder in oParentFolder.Folders)
                {
                    int K = 0;
                    K = oChildFolder.Folders.Count;
                    string cFolder = oChildFolder.Name.ToString();
                    if (xDebug)
                        LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 010: '" + cFolder + "'.");
                    // LB.Items.Add(cFolder )
                }

                oMAPI = null;
                GC.Collect();
                B = true;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error 653.21a2: " + ex.Message);
                LOG.WriteToArchiveLog("ERROR 653.21a2 clsArchiver:getOutlookFolderNames V2 011: '" + ex.Message + "'.");
                B = false;
            }

            if (xDebug)
                LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames V2 012.");
            return B;
        }

        public bool getOutlookParentFolderNames(ref ComboBox CB)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            int L = 0;
            bool B = false;
            try
            {
                if (xDebug)
                    LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 001: ");
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
                // Dim sArray() As String
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
                    LOG.WriteToArchiveLog("clsArchiver:getOutlookFolderNames 002: '" + MailboxName + "'.");
                    L = 11;
                }

                var aFolders = new List<string>();
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
                LOG.WriteToArchiveLog("getOutlookParentFolderNames 100: L = " + L.ToString() + Constants.vbCrLf + "Failed to get the Outlook Containers." + ex.Message);
                MessageBox.Show("getOutlookParentFolderNames 100: L = " + L.ToString() + Constants.vbCrLf + "Failed to get the Outlook Containers." + ex.Message);
                B = false;
            }

            return B;
        }

        public ArrayList getOutlookParentFolderNames()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var AL = new ArrayList();
            bool B = false;
            try
            {
                if (xDebug)
                    LOG.WriteToArchiveLog("clsArchiver:getOutlookParentFolderNames 001: ");
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
                    LOG.WriteToArchiveLog("clsArchiver:getOutlookParentFolderNames 002: '" + MailboxName + "'.");
                var aFolders = new List<string>();
                int iFolderCount = oMAPI.Folders.Count;
                foreach (Outlook.MAPIFolder MF in oMAPI.Folders)
                {
                    Console.WriteLine(MF.Name);
                    AL.Add(MF.Name);
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("getOutlookParentFolderNames 100: " + ex.Message);
            }

            return AL;
        }

        public void ProcessOutlookFolderNames(string FileDirectory, string TopFolder, ref ListBox LB)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

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

                // ********************************************************
                // PARAMETER: MailboxName = Name of Parent Outlook Folder for
                // the current user: Usually in the form of
                // "Mailbox - Doe, John" or
                // "Public Folders
                // RETURNS: Array of SubFolders in Current User's Mailbox
                // Or unitialized array if error occurs
                // Because it returns an array, it is for VB6 only.
                // Change to return a variant or a delimited list for
                // previous versions of vb
                // EXAMPLE:
                // Dim sArray() As String
                // Dim ictr As Integer
                // sArray = OutlookFolderNames("Mailbox - Doe, John")
                // 'On Error Resume Next
                // For ictr = 0 To UBound(sArray)
                // if xDebug then log.WriteToArchiveLog sArray(ictr)
                // Next
                // *********************************************************
                Outlook.Application oOutlook;
                Outlook.NameSpace oMAPI = null;
                Outlook.MAPIFolder oParentFolder = null;
                // Dim sArray() As String
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

                // AddChildFolders(LB, MailboxName )

                if (oParentFolder.Folders.Count != 0)
                {
                    var loopTo = oParentFolder.Folders.Count;
                    for (i = 1; i <= loopTo; i++)
                    {
                        if (!string.IsNullOrEmpty(Strings.Trim(oParentFolder.Folders[i].Name)))
                        {
                            LB.Items.Add(oParentFolder.Folders[i].Name);
                            bool B = ckFolderExists(modGlobals.gCurrUserGuidID, oParentFolder.Folders[i].Name, FileDirectory);
                            if (B)
                            {
                                var CurrMailFolder = oParentFolder.Folders[i];
                                if (xDebug)
                                    LOG.WriteToArchiveLog("MUST Process folder: " + oParentFolder.Folders[i].Name);
                                ArchiveEmailsInFolderenders(ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, CurrMailFolder, DeleteFile);
                            }
                            else if (xDebug)
                                LOG.WriteToArchiveLog("IGNORE folder: " + oParentFolder.Folders[i].Name);
                        }
                    }
                }

                foreach (Outlook.MAPIFolder oChildFolder in oParentFolder.Folders)
                {
                    int K = 0;
                    K = oChildFolder.Folders.Count;
                    string cFolder = oChildFolder.Name.ToString();
                    // LB.Items.Add(cFolder )
                    if (K > 0)
                    {
                        ListChildFolders(FileDirectory, TopFolder, oChildFolder, ref LB, cFolder, BB);
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
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            try
            {
                string tFqn = FQN;
                foreach (Outlook.MAPIFolder tFolder in oChildFolder.Folders)
                {
                    string ParentID = oChildFolder.EntryID;
                    string ChildID = tFolder.EntryID;
                    string tFolderName = tFolder.Name.ToString();
                    tFqn = FQN + "->" + tFolderName;
                    // If xDebug Then log.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0022: '" + tFolderName  + "'.")
                    // If xDebug Then log.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0022: '" + tFqn + ":" + tFolder.EntryID)
                    // LB.Items.Add(tFqn)
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
            }
            // For i As Integer = 0 To LB.Items.Count - 1
            // if xDebug then log.WriteToArchiveLog(LB.Items(i).ToString)
            // Next
            // if xDebug then log.WriteToArchiveLog("------------")
            catch (Exception ex)
            {
                // messagebox.show("Error 932.12 - " + ex.Message)
                if (xDebug)
                    LOG.WriteToArchiveLog("Error 932.12 - " + ex.Message);
            }
        }

        public void ListChildFolders(string FileDirectory, Outlook.MAPIFolder oChildFolder, ref ListBox LB, string FQN)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            try
            {
                string tFqn = FQN;
                foreach (Outlook.MAPIFolder tFolder in oChildFolder.Folders)
                {
                    string ParentID = oChildFolder.EntryID;
                    string ChildID = tFolder.EntryID;
                    string tFolderName = tFolder.Name.ToString();
                    tFqn = FQN + "->" + tFolderName;
                    if (xDebug)
                        LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0022: '" + tFolderName + "'.");
                    if (xDebug)
                        LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0022: '" + tFqn + ":" + tFolder.EntryID);
                    LB.Items.Add(tFqn);
                    int II = EMF.cnt_PK_EmailFolder(ChildID, modGlobals.gCurrUserGuidID);
                    II = EMF.cnt_UI_EmailFolder(FileDirectory, tFqn, modGlobals.gCurrUserGuidID);
                    string oChildFolderName = oChildFolder.Name;
                    if (II == 0)
                    {
                        string FolderFQN = FileDirectory + "|" + tFqn;
                        EMF.setFolderid(ref ChildID);
                        EMF.setFoldername(ref tFqn);
                        EMF.setParentfolderid(ref ParentID);
                        EMF.setParentfoldername(ref oChildFolderName);
                        EMF.setUserid(ref modGlobals.gCurrUserGuidID);
                        string argval = "?";
                        EMF.setSelectedforarchive(ref argval);
                        bool BB = EMF.Insert(FileDirectory);
                        if (!BB)
                        {
                            LOG.WriteToArchiveLog("ERROR: Faild to  register EMAIL folder: " + FileDirectory + " : " + oChildFolderName);
                        }
                    }
                    else
                    {
                        string FolderFQN = FileDirectory + "|" + tFqn;
                        EMF.setFolderid(ref ChildID);
                        EMF.setFoldername(ref FolderFQN);
                        EMF.setParentfolderid(ref ParentID);
                        EMF.setParentfoldername(ref oChildFolderName);
                        EMF.setUserid(ref modGlobals.gCurrUserGuidID);
                        string argval1 = "?";
                        EMF.setSelectedforarchive(ref argval1);
                        string WC = EMF.wc_UI_EmailFolder(FileDirectory, FolderFQN, modGlobals.gCurrUserGuidID);
                        bool BB = EMF.Update(WC);
                        if (!BB)
                        {
                            LOG.WriteToArchiveLog("ERROR: Faild to update registration for EMAIL folder: " + FileDirectory + " : " + tFolderName);
                        }
                    }

                    int k = tFolder.Folders.Count;
                    if (k > 0)
                    {
                        ListChildFolders(FileDirectory, tFolder, ref LB, tFqn);
                    }
                }
            }
            // For i As Integer = 0 To LB.Items.Count - 1
            // if xDebug then log.WriteToArchiveLog(LB.Items(i).ToString)
            // Next
            // if xDebug then log.WriteToArchiveLog("------------")
            catch (Exception ex)
            {
                // messagebox.show("Error 932.12 - " + ex.Message)
                if (xDebug)
                    LOG.WriteToArchiveLog("Error 932.12 - " + ex.Message);
            }
        }

        public void ListChildFolders(Outlook.MAPIFolder oChildFolder, string FQN)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            try
            {
                string tFqn = FQN;
                foreach (Outlook.MAPIFolder tFolder in oChildFolder.Folders)
                {
                    string ParentID = oChildFolder.EntryID;
                    string ChildID = tFolder.EntryID;
                    string tFolderName = tFolder.Name.ToString();
                    tFqn = FQN + "->" + tFolderName;
                    if (xDebug)
                        LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0033: '" + tFolderName + "'.");
                    if (xDebug)
                        LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0033: '" + tFqn + ":" + tFolder.EntryID);
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
                            LOG.WriteToArchiveLog("NOTICE: ListChildFolders - ChildFoldersList.Add: " + ex.Message);
                        }
                    }

                    int k = tFolder.Folders.Count;
                    if (k > 0)
                    {
                        ListChildFolders(tFolder, tFqn);
                    }
                }
            }
            // For i As Integer = 0 To LB.Items.Count - 1
            // if xDebug then log.WriteToArchiveLog(LB.Items(i).ToString)
            // Next
            // if xDebug then log.WriteToArchiveLog("------------")
            catch (Exception ex)
            {
                // messagebox.show("Error 932.12 - " + ex.Message)
                if (xDebug)
                    LOG.WriteToArchiveLog("Error 932.12 - " + ex.Message);
            }
        }

        public void ListChildFolders(string UID, string EmailFolderFQN, string TopFolder, string currFolder, Outlook.MAPIFolder oChildFolder, string FQN, SortedList slStoreId, string isPublic)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

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
                var ARCH = new clsArchiver();
                string ArchiveOnlyIfRead = "";
                string ParentID = "";
                string ChildID = "";
                string tFolderName = "";
                int BB = 0;
                int idx = 0;
                Outlook.MAPIFolder subFolder = null;
                Outlook.MAPIFolder tFolder = null;
                string tFqn = FQN;
                Console.WriteLine("Listing the children of: " + tFqn);
                Console.WriteLine("oChildFolder.Folders count : " + oChildFolder.Folders.Count.ToString());
                foreach (Outlook.MAPIFolder currentTFolder in oChildFolder.Folders)
                {
                    tFolder = currentTFolder;
                    ParentID = oChildFolder.EntryID;
                    ChildID = tFolder.EntryID;
                    tFolderName = tFolder.Name.ToString();
                    tFqn = FQN + "->" + tFolderName;
                    // Console.WriteLine("Processing Child Folder: " + tFqn)
                    if (xDebug)
                        LOG.WriteToArchiveLog("Processing Child Folder: " + tFqn);
                    if (xDebug)
                        LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0044: '" + tFolderName + "'.");
                    if (xDebug)
                        LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0044: '" + tFqn + ":" + tFolder.EntryID);
                    idx = ChildFoldersList.IndexOfKey(tFqn);
                    if (idx >= 0)
                    {
                        ChildID = ChildFoldersList[tFqn];
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
                            LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0044a Found it: '" + tFqn + ":" + tFolder.EntryID);
                        string RetentionCode = "";
                        int RetentionYears = 10;
                        RetentionCode = getArchEmailFolderRetentionCode(ChildID, modGlobals.gCurrUserGuidID);
                        if (RetentionCode.Length > 0)
                        {
                            RetentionYears = getRetentionPeriod(RetentionCode);
                        }

                        // messagebox.show("Get the emails from " + tFolderName )
                        string oChildFolderName = tFolder.Name;
                        EMF.setFolderid(ref ChildID);
                        EMF.setFoldername(ref tFqn);
                        EMF.setParentfolderid(ref ParentID);
                        EMF.setParentfoldername(ref oChildFolderName);
                        EMF.setUserid(ref modGlobals.gCurrUserGuidID);
                        if (xDebug)
                            LOG.WriteToArchiveLog(tFolderName);
                        // BB = ckArchEmailFolder(ChildID , gCurrUserGuidID)
                        // If BB Then
                        EMF.setFolderid(ref ChildID);
                        EMF.setFoldername(ref tFolderName);
                        EMF.setParentfolderid(ref ParentID);
                        string argval = oChildFolder.Name;
                        EMF.setParentfoldername(ref argval);
                        oChildFolder.Name = argval;
                        EMF.setUserid(ref modGlobals.gCurrUserGuidID);
                        BB = Conversions.ToInteger(GetEmailFolderParms(TopFolder, modGlobals.gCurrUserGuidID, tFqn, ref ArchiveEmails, ref RemoveAfterArchive, ref SetAsDefaultFolder, ref ArchiveAfterXDays, ref RemoveAfterXDays, ref RemoveXDays, ref ArchiveXDays, ref DB_ID, ref ArchiveOnlyIfRead));
                        DBLocal.setOutlookMissing();
                        ArchiveEmailsInFolder(UID, TopFolder, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, tFolder, StoreID, ArchiveOnlyIfRead, RetentionYears, RetentionCode, tFqn, slStoreId, isPublic);
                    }

                    foreach (Outlook.MAPIFolder currentSubFolder in tFolder.Folders)
                    {
                        subFolder = currentSubFolder;
                        string sFqn = tFqn + "->" + subFolder.Name;
                        sFqn = TopFolder + "|" + sFqn;
                        ListChildFolders(UID, EmailFolderFQN, TopFolder, currFolder, subFolder, sFqn, slStoreId, isPublic);
                    }
                    // Dim k As Integer = tFolder.Folders.Count
                    // If k > 0 Then
                    // ListChildFolders(EmailFolderFQN, TopFolder , currFolder , oChildFolder, FQN )
                    // End If
                }

                // *******************************************************

                ParentID = oChildFolder.EntryID;
                ChildID = tFolder.EntryID;
                tFolderName = tFolder.Name.ToString();
                tFqn = FQN + "->" + tFolderName;
                Console.WriteLine("Processing Child Folder: " + tFqn);
                if (xDebug)
                    LOG.WriteToArchiveLog("Processing Child Folder: " + tFqn);
                if (xDebug)
                    LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0044: '" + tFolderName + "'.");
                if (xDebug)
                    LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0044: '" + tFqn + ":" + tFolder.EntryID);
                idx = ChildFoldersList.IndexOfKey(tFqn);
                if (idx >= 0)
                {
                    ChildID = ChildFoldersList[tFqn];
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

                    // messagebox.show("Get the emails from " + tFolderName )
                    string oChildFolderName = tFolder.Name;
                    EMF.setFolderid(ref ChildID);
                    EMF.setFoldername(ref tFqn);
                    EMF.setParentfolderid(ref ParentID);
                    EMF.setParentfoldername(ref oChildFolderName);
                    EMF.setUserid(ref modGlobals.gCurrUserGuidID);
                    if (xDebug)
                        LOG.WriteToArchiveLog(tFolderName);
                    // BB = ckArchEmailFolder(ChildID , gCurrUserGuidID)
                    // If BB Then
                    EMF.setFolderid(ref ChildID);
                    EMF.setFoldername(ref tFolderName);
                    EMF.setParentfolderid(ref ParentID);
                    string argval1 = oChildFolder.Name;
                    EMF.setParentfoldername(ref argval1);
                    oChildFolder.Name = argval1;
                    EMF.setUserid(ref modGlobals.gCurrUserGuidID);
                    BB = Conversions.ToInteger(GetEmailFolderParms(TopFolder, modGlobals.gCurrUserGuidID, tFqn, ref ArchiveEmails, ref RemoveAfterArchive, ref SetAsDefaultFolder, ref ArchiveAfterXDays, ref RemoveAfterXDays, ref RemoveXDays, ref ArchiveXDays, ref DB_ID, ref ArchiveOnlyIfRead));
                    DBLocal.setOutlookMissing();
                    ArchiveEmailsInFolder(UID, TopFolder, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, tFolder, Conversions.ToString(DeleteFile), StoreID, Conversions.ToInteger(ArchiveOnlyIfRead), RetentionYears.ToString(), RetentionCode, slStoreId, isPublic);
                }

                subFolder = null;
                foreach (Outlook.MAPIFolder currentSubFolder1 in tFolder.Folders)
                {
                    subFolder = currentSubFolder1;
                    string sFqn = tFqn + "->" + subFolder.Name;
                    sFqn = TopFolder + "|" + sFqn;
                    ListChildFolders(UID, EmailFolderFQN, TopFolder, currFolder, subFolder, sFqn, slStoreId, isPublic);
                }
            }
            // Dim k As Integer = tFolder.Folders.Count
            // If k > 0 Then
            // ListChildFolders(EmailFolderFQN, TopFolder , currFolder , oChildFolder, FQN )
            // End If

            // *******************************************************
            catch (Exception ex)
            {
                if (xDebug)
                    LOG.WriteToArchiveLog("Error 932.12a - " + ex.Message);
            }
        }

        public void ListChildFolders(string FileDirectory, string TopFolder, Outlook.MAPIFolder oChildFolder, ref ListBox LB, string FQN, bool B)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

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
                string tFqn = FQN;
                foreach (Outlook.MAPIFolder tFolder in oChildFolder.Folders)
                {
                    string tFolderName = tFolder.Name.ToString();
                    GetFolderByPath(tFolder.FolderPath);
                    tFqn = FQN + "->" + tFolderName;
                    if (xDebug)
                        LOG.WriteToArchiveLog("Location clsArchiver:ListChildFolders 0055: '" + tFolderName + "'.");
                    LB.Items.Add(tFqn);
                    int k = tFolder.Folders.Count;
                    if (k > 0)
                    {
                        ListChildFolders(FileDirectory, tFolder, ref LB, tFqn);
                    }

                    string CurrFolderName = tFqn;
                    tFqn = UTIL.RemoveSingleQuotes(tFqn);
                    B = ckFolderExists(modGlobals.gCurrUserGuidID, tFqn, FileDirectory);
                    if (B)
                    {
                        if (xDebug)
                            LOG.WriteToArchiveLog("MUST Process folder: " + CurrFolderName + ", alias: " + tFolder.Name);
                        bool BB = GetEmailFolderParms(TopFolder, modGlobals.gCurrUserGuidID, CurrFolderName, ref ArchiveEmails, ref RemoveAfterArchive, ref SetAsDefaultFolder, ref ArchiveAfterXDays, ref RemoveAfterXDays, ref RemoveXDays, ref ArchiveXDays, ref DB_ID, ref ArchiveOnlyIfRead);
                        if (BB)
                        {
                            ArchiveEmailsInFolderenders(ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, tFolder, DeleteFile);
                        }
                    }
                    else if (xDebug)
                        LOG.WriteToArchiveLog("IGNORE folder: " + CurrFolderName);
                }
            }
            catch (Exception ex)
            {
                if (xDebug)
                    LOG.WriteToArchiveLog("ERROR 1211.1 - " + ex.Message);
            }
        }

        public void ProcessAllFolders(Outlook.MAPIFolder oChildFolder, ref ListBox LB, string FQN)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string tFqn = FQN;
            foreach (Outlook.MAPIFolder tFolder in oChildFolder.Folders)
            {
                string tFolderName = tFolder.Name.ToString();
                tFqn = FQN + "->" + tFolderName;
                if (xDebug)
                    LOG.WriteToArchiveLog("Location clsArchiver:ProcessAllFolders 0066 '" + tFolderName + "'.");
                LB.Items.Add(tFqn);
                int k = tFolder.Folders.Count;
                if (k > 0)
                {
                    ProcessAllFolders(tFolder, ref LB, tFqn);
                }
                else if (xDebug)
                    LOG.WriteToArchiveLog("Examine Folder: " + tFolder.Name);
            }

            for (int i = 0, loopTo = LB.Items.Count - 1; i <= loopTo; i++)
            {
                if (xDebug)
                    LOG.WriteToArchiveLog(LB.Items[i].ToString());
            }
        }

        public void AddChildFolders(ref ListBox LB, string MailboxName)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

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
            catch (Exception ex)
            {
                // messagebox.show(ex.Message)
                LB.Items.Add(MailboxName);
                return;
            }

            if (oChildFolder.Folders.Count == 0)
            {
                LB.Items.Add(MailboxName);
            }
            // LB.Items.Add(oChildFolder.Folders.Item(i).Name)
            else
            {
                int I = 0;
                var loopTo = oChildFolder.Folders.Count;
                for (I = 1; I <= loopTo; I++)
                {
                    if (!string.IsNullOrEmpty(Strings.Trim(oChildFolder.Folders[I].Name)))
                    {
                        string ChildFolderName = oChildFolder.Folders[I].Name.ToString();
                        AddChildFolders(ref LB, ChildFolderName);
                    }
                }
            }
        }

        public void ConvertName(ref string FQN)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            for (int i = 1, loopTo = FQN.Length; i <= loopTo; i++)
            {
                string CH = Strings.Mid(FQN, i, 1);
                int II = Strings.InStr(1, "abcdefghijklmnopqrstuvwxyz0123456789_.", CH, CompareMethod.Text);
                if (II == 0)
                {
                    StringType.MidStmtStr(ref FQN, i, 1, "_");
                }
                // If CH = " " Then
                // Mid(FQN, i, 1) = "_"
                // End If
                // If CH = "?" Then
                // Mid(FQN, i, 1) = "_"
                // End If
                // If CH = "-" Then
                // Mid(FQN, i, 1) = "_"
                // End If
                // If CH = ":" Then
                // Mid(FQN, i, 1) = "."
                // End If
                // If CH = "/" Then
                // Mid(FQN, i, 1) = "."
                // End If
            }
        }

        // Private Sub Timer1_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Timer1.Tick
        // Try

        // 'Dim test1 As String = System.Configuration.ConfigurationManager.AppSettings("Test1") 'Dim
        // oConn As New
        // SqlConnection(System.Configuration.ConfigurationManager.AppSettings("DB_CONN_STR")) If
        // Timer1.Enabled Then '** Get the polling interval Dim PollingInterval As Integer =
        // Val(System.Configuration.ConfigurationManager.AppSettings("PollIntervalMinutes")) '** Convert
        // the MINUTES to Milliseconds. Timer1.Interval = PollingInterval * 60000

        // Dim S = System.Configuration.ConfigurationManager.AppSettings("ParseDirectory") If
        // S.Equals("YES") Then bParseDir = True DirToParse =
        // System.Configuration.ConfigurationManager.AppSettings("DirectoryToParse") Else bParseDir =
        // False End If ParseArchiveFolder =
        // System.Configuration.ConfigurationManager.AppSettings("ParseArchiveFolder") ArchiveSentMail =
        // System.Configuration.ConfigurationManager.AppSettings("ArchiveSentMail") ArchiveInbox =
        // System.Configuration.ConfigurationManager.AppSettings("ArchiveInbox") MaxDaysBeforeArchive = Val(System.Configuration.ConfigurationManager.AppSettings("MaxDaysBeforeArchive"))

        // Timer1.Enabled = False
        // If ParseArchiveFolder .Equals("YES") Then
        // LoadArchiveFolder()
        // End If
        // If ArchiveSentMail.Equals("YES") Then
        // GetEmails(oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderSentMail), False)
        // End If
        // If bParseDir = True Then
        // Redeem.ProcessDir(DirToParse , "", True)
        // End If
        // If ArchiveInbox.Equals("YES") Then
        // GetEmails(oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderInbox), False)
        // End If
        // Timer1.Enabled = True
        // Else
        // if xDebug then log.WriteToArchiveLog("Timer OFF")
        // End If
        // 'oConn.Close()
        // 'oConn = Nothing
        // Catch ex As Exception
        // messagebox.show(ex.Message)
        // End Try
        // End Sub
        public void GetActiveEmailSenders(string FileDirectory, string TopFolder, string UID, string MailboxName)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var ActiveFolders = new string[1];
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
            var EmailFolders = new string[1];
            GetEmailFolders(ref UID, ref EmailFolders);
            for (int i = 0, loopTo = Information.UBound(EmailFolders); i <= loopTo; i++)
            {
                FolderName = EmailFolders[i].ToString().Trim();
                if (xDebug)
                    LOG.WriteToArchiveLog("Folder to Process: " + FolderName);
                bool B = ckFolderExists(FileDirectory, UID, FolderName);
                if (B)
                {
                    bool BB = GetEmailFolderParms(TopFolder, UID, FolderName, ref ArchiveEmails, ref RemoveAfterArchive, ref SetAsDefaultFolder, ref ArchiveAfterXDays, ref RemoveAfterXDays, ref RemoveXDays, ref ArchiveXDays, ref DB_ID, ref ArchiveOnlyIfRead);
                    if (BB)
                    {
                        // ARCH.getSubFolderEmails(FolderName , bDeleteMsg)
                        if (xDebug)
                            LOG.WriteToArchiveLog("Processing Senders from : " + FolderName);
                        getSubFolderEmailsSenders(UID, MailboxName, FolderName, DeleteFile, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, FileDirectory);
                        // ARCH.GetEmails(FolderName , ArchiveEmails , RemoveAfterArchive , SetAsDefaultFolder , ArchiveAfterXDays , RemoveAfterXDays , RemoveXDays , ArchiveXDays , DB_ID )
                    }
                }
            }
        }

        public void DeleteContact(string EmailAddress, string FullName)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            };
#error Cannot convert OnErrorGoToStatementSyntax - see comment for details
            /* Cannot convert OnErrorGoToStatementSyntax, CONVERSION ERROR: Conversion for OnErrorGoToLabelStatement not implemented, please report this issue in 'On Error GoTo Err_Handler' at character 337088


            Input:

                    On Error GoTo Err_Handler

             */
            string DQ = Conversions.ToString('"');
            Outlook.ContactItem olContact;
            Outlook.MAPIFolder olFolder;
            if (!InitializeOutlook())
            {
                MessageBox.Show("Cannot initialize Outlook");
                return;
            }

            olFolder = g_nspNameSpace.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderContacts);
            olContact = (Outlook.ContactItem)olFolder.Items.Find("[Email1Address] = " + DQ + EmailAddress + DQ + " AND " + "[FullName] = " + DQ + FullName + DQ);
            if (olContact is object)
            {
                olContact.Display();
                olContact.Delete();
                LOG.WriteToArchiveLog("clsArchiver : DeleteContact : Delete Performed 07");
            }
            else
            {
                MessageBox.Show("Cannot find contact");
            }

            Exit_Handler:
            ;


            // On Error Resume Next

            if (olFolder is object)
            {
                olFolder = null;
            }

            if (olContact is object)
            {
                olContact = null;
            }

            GC.Collect();
            return;
            Err_Handler:
            ;
            MessageBox.Show(Information.Err().Description + " - Error No: " + Information.Err().Number);
            ;
#error Cannot convert ResumeStatementSyntax - see comment for details
            /* Cannot convert ResumeStatementSyntax, CONVERSION ERROR: Conversion for ResumeLabelStatement not implemented, please report this issue in 'Resume Exit_Handler' at character 338598


            Input:
                    Resume Exit_Handler

             */
        }

        public void DeleteEmail(string SenderEmailAddress, string ReceivedByName, string ReceivedTime, string SenderName, string SentOn)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            };
#error Cannot convert OnErrorGoToStatementSyntax - see comment for details
            /* Cannot convert OnErrorGoToStatementSyntax, CONVERSION ERROR: Conversion for OnErrorGoToLabelStatement not implemented, please report this issue in 'On Error GoTo Err_Handler' at character 339030


            Input:

                    On Error GoTo Err_Handler

             */
            string DQ = Conversions.ToString('"');
            /* TODO ERROR: Skipped IfDirectiveTrivia *//* TODO ERROR: Skipped DisabledTextTrivia *//* TODO ERROR: Skipped ElseDirectiveTrivia */
            Outlook.Folders olEmail;
            /* TODO ERROR: Skipped EndIfDirectiveTrivia */
            Outlook.MAPIFolder olFolder;
            if (!InitializeOutlook())
            {
                MessageBox.Show("Cannot initialize Outlook");
                return;
            }

            string S = "[SenderEmailAddress] = " + DQ + SenderEmailAddress + DQ;
            S = S + "and [ReceivedByName] = " + DQ + ReceivedByName + DQ;
            S = S + "and [ReceivedTime] = " + DQ + ReceivedTime + DQ;
            S = S + "and [ReceivedByName] = " + DQ + ReceivedByName + DQ;
            olFolder = g_nspNameSpace.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderInbox);
            olEmail = (Outlook.Folders)olFolder.Items.Find(S);
            if (olEmail is object)
            {
                // olEmail.Display()
                olEmail.Delete();
                if (ddebug)
                    LOG.WriteToArchiveLog("clsArchiver : DeleteEmail : Delete Performed 09");
            }
            else
            {
                MessageBox.Show("Cannot find email: ");
            }

            Exit_Handler:
            ;


            // On Error Resume Next

            if (olFolder is object)
            {
                olFolder = null;
            }

            if (olEmail is object)
            {
                olEmail = null;
            }

            GC.Collect();
            return;
            Err_Handler:
            ;
            MessageBox.Show(Information.Err().Description, ((double)Constants.vbExclamation + Conversions.ToDouble(" - Error No: ")).ToString() + Information.Err().Number);
            ;
#error Cannot convert ResumeStatementSyntax - see comment for details
            /* Cannot convert ResumeStatementSyntax, CONVERSION ERROR: Conversion for ResumeLabelStatement not implemented, please report this issue in 'Resume Exit_Handler' at character 340854


            Input:
                    Resume Exit_Handler

             */
        }

        public void AddOutlookContact(DataGridView DG, bool SkipIfExists, bool OverwriteContact, bool AddIfMissing)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            // Dim DR As DataGridViewRow

            Outlook.ContactItem olContact = null;
            Outlook.MAPIFolder olFolder = null;
            if (!InitializeOutlook())
            {
                Interaction.MsgBox("Cannot initialize Outlook", Constants.vbExclamation, "Automation Error");
                return;
            }
            // DGV.DisplayColNames(DG)
            DGV.ListColumnNames(DG);
            var SL = new SortedList();
            DGV.DisplayColNames(ref DG, SL);
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
                        string DQ = Conversions.ToString('"');
                        olContact = (Outlook.ContactItem)olFolder.Items.Find("[Email1Address] = " + DQ + Email1Address + DQ + " AND " + "[FullName] = " + DQ + FullName + DQ);
                        // FrmMDIMain.SB.Text = FullName

                        if (olContact is object)
                        {
                            if (OverwriteContact | AddIfMissing)
                            {
                                olContact.Delete();
                                // LOG.WriteToArchiveLog("clsArchiver : AddOutlookContact : Delete Performed 10: " + Email1Address )
                                AddContactDetail(Account, Anniversary, Application, AssistantName, AssistantTelephoneNumber, BillingInformation, Birthday, Business2TelephoneNumber, BusinessAddress, BusinessAddressCity, BusinessAddressCountry, BusinessAddressPostalCode, BusinessAddressPostOfficeBox, BusinessAddressState, BusinessAddressStreet, BusinessCardType, BusinessFaxNumber, BusinessHomePage, BusinessTelephoneNumber, CallbackTelephoneNumber, CarTelephoneNumber, Categories, Children, XClass, Companies, CompanyName, ComputerNetworkName, Conflicts, ConversationTopic, CreationTime, CustomerID, Department, Email1Address, Email1AddressType, Email1DisplayName, Email1EntryID, Email2Address, Email2AddressType, Email2DisplayName, Email2EntryID, Email3Address, Email3AddressType, Email3DisplayName, Email3EntryID, FileAs, FirstName, FTPSite, FullName, Gender, GovernmentIDNumber, Hobby, Home2TelephoneNumber, HomeAddress, HomeAddressCountry, HomeAddressPostalCode, HomeAddressPostOfficeBox, HomeAddressState, HomeAddressStreet, HomeFaxNumber, HomeTelephoneNumber, IMAddress, Importance, Initials, InternetFreeBusyAddress, JobTitle, Journal, Language, LastModificationTime, LastName, LastNameAndFirstName, MailingAddress, MailingAddressCity, MailingAddressCountry, MailingAddressPostalCode, MailingAddressPostOfficeBox, MailingAddressState, MailingAddressStreet, ManagerName, MiddleName, Mileage, MobileTelephoneNumber, NetMeetingAlias, NetMeetingServer, NickName, Title, Body, OfficeLocation, Subject);
                            }
                            else
                            {
                                Console.WriteLine("Contact already exist... skipping.");
                                // olContact.Display()
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
                    LOG.WriteToArchiveLog("AddOutlookContact: 110.11 - " + Constants.vbCrLf + ex.Message);
                    LOG.WriteToArchiveLog("AddOutlookContact: 110.11 - " + Constants.vbCrLf + ex.StackTrace);
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("AddOutlookContact: 110.12 - " + Constants.vbCrLf + ex.Message);
                LOG.WriteToArchiveLog("AddOutlookContact: 110.12 - " + Constants.vbCrLf + ex.StackTrace);
            }

            if (olFolder is object)
            {
                olFolder = null;
            }

            if (olContact is object)
            {
                olContact = null;
            }

            GC.Collect();
        }

        public void AddOutlookEmail(DataGridView DG, bool SkipIfExists, bool OverwriteContact, bool AddIfMissing)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            // Dim DR As DataGridViewRow

            Outlook.MailItem olEmailItem = null;
            Outlook.MAPIFolder olFolder = null;

            /* TODO ERROR: Skipped IfDirectiveTrivia *//* TODO ERROR: Skipped DisabledTextTrivia *//* TODO ERROR: Skipped ElseDirectiveTrivia */
            Outlook.Folders olEmail = null;
            /* TODO ERROR: Skipped EndIfDirectiveTrivia */
            if (!InitializeOutlook())
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
                ;
#error Cannot convert OnErrorGoToStatementSyntax - see comment for details
                /* Cannot convert OnErrorGoToStatementSyntax, CONVERSION ERROR: Conversion for OnErrorGoToLabelStatement not implemented, please report this issue in 'On Error GoTo Err_Handler' at character 359895


                Input:

                            On Error GoTo Err_Handler

                 */
                string DQ = Conversions.ToString('"');
                string S = "[SenderEmailAddress] = " + DQ + SenderEmailAddress + DQ;
                S = S + "and [ReceivedByName] = " + DQ + ReceivedByName + DQ;
                S = S + "and [ReceivedTime] = " + DQ + ReceivedTime + DQ;
                S = S + "and [ReceivedByName] = " + DQ + ReceivedByName + DQ;
                olFolder = g_nspNameSpace.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderInbox);
                olEmail = (Outlook.Folders)olFolder.Items.Find(S);
                olEmailItem = (Outlook.MailItem)olFolder.Items.Find(S);
                if (olEmailItem is object)
                {
                    if (OverwriteContact | AddIfMissing)
                    {
                        olEmailItem.Delete();
                        LOG.WriteToArchiveLog("clsArchiver : AddOutlookEmail : Delete Performed 11");

                        // *************** DO NOT SAVE THE WHOLE BODY, JUST THE FIRST 100 CHARACTERS *****************
                        Body = Body.Substring(0, 100);
                        // *******************************************************************************************
                        AddEmailDetail(SenderEmailAddress, SUBJECT, Body, ReceivedByName, ReceivedTime, SentTO, SenderName, Bcc, BillingInformation, CC, Companies, CreationTime, ReadReceiptRequested, AllRecipients, Sensitivity, SentOn, MsgSize, DeferredDeliveryTime, ExpiryTime, LastModificationTime, EmailImage, Accounts, ShortSubj);
                    }
                    else
                    {
                        MessageBox.Show("Contact already exist... skipping.");
                        // olEmailItem.Display()
                    }
                }
                else
                {
                    AddEmailDetail(SenderEmailAddress, SUBJECT, Body, ReceivedByName, ReceivedTime, SentTO, SenderName, Bcc, BillingInformation, CC, Companies, CreationTime, ReadReceiptRequested, AllRecipients, Sensitivity, SentOn, MsgSize, DeferredDeliveryTime, ExpiryTime, LastModificationTime, EmailImage, Accounts, ShortSubj);
                }
            }

            Exit_Handler:
            ;


            // On Error Resume Next

            if (olFolder is object)
            {
                olFolder = null;
            }

            if (olEmailItem is object)
            {
                olEmailItem = null;
            }

            if (olEmail is object)
            {
                olEmail = null;
            }

            GC.Collect();
            return;
            Err_Handler:
            ;
            Interaction.MsgBox(Information.Err().Description, Constants.vbExclamation, "Error No: " + Information.Err().Number);
            ;
#error Cannot convert ResumeStatementSyntax - see comment for details
            /* Cannot convert ResumeStatementSyntax, CONVERSION ERROR: Conversion for ResumeLabelStatement not implemented, please report this issue in 'Resume Exit_Handler' at character 362626


            Input:
                    Resume Exit_Handler

             */
        }

        public bool InitializeOutlook()
        {
            bool InitializeOutlookRet = default;
            ;
#error Cannot convert OnErrorGoToStatementSyntax - see comment for details
            /* Cannot convert OnErrorGoToStatementSyntax, CONVERSION ERROR: Conversion for OnErrorGoToLabelStatement not implemented, please report this issue in 'On Error GoTo Err_Handler' at character 362717


            Input:
                    On Error GoTo Err_Handler

             */
            if (g_olApp is null)
            {
                g_olApp = new Outlook.Application();
                g_nspNameSpace = g_olApp.GetNamespace("MAPI");
                InitializeOutlookRet = true;
            }
            else
            {
                InitializeOutlookRet = true;
            }

            Exit_Handler:
            ;
            return InitializeOutlookRet;

            // No Error message - simply let the function return false
            Err_Handler:
            ;
            ;
#error Cannot convert ResumeStatementSyntax - see comment for details
            /* Cannot convert ResumeStatementSyntax, CONVERSION ERROR: Conversion for ResumeLabelStatement not implemented, please report this issue in 'Resume Exit_Handler' at character 363163


            Input:

                    ' No Error message - simply let the function return false
                    Resume Exit_Handler

             */
        }

        public void AddContactDetail(string Account, string Anniversary, string Application, string AssistantName, string AssistantTelephoneNumber, string BillingInformation, string Birthday, string Business2TelephoneNumber, string BusinessAddress, string BusinessAddressCity, string BusinessAddressCountry, string BusinessAddressPostalCode, string BusinessAddressPostOfficeBox, string BusinessAddressState, string BusinessAddressStreet, string BusinessCardType, string BusinessFaxNumber, string BusinessHomePage, string BusinessTelephoneNumber, string CallbackTelephoneNumber, string CarTelephoneNumber, string Categories, string Children, string xClass, string Companies, string CompanyName, string ComputerNetworkName, string Conflicts, string ConversationTopic, string CreationTime, string CustomerID, string Department, string Email1Address, string Email1AddressType, string Email1DisplayName, string Email1EntryID, string Email2Address, string Email2AddressType, string Email2DisplayName, string Email2EntryID, string Email3Address, string Email3AddressType, string Email3DisplayName, string Email3EntryID, string FileAs, string FirstName, string FTPSite, string FullName, string Gender, string GovernmentIDNumber, string Hobby, string Home2TelephoneNumber, string HomeAddress, string HomeAddressCountry, string HomeAddressPostalCode, string HomeAddressPostOfficeBox, string HomeAddressState, string HomeAddressStreet, string HomeFaxNumber, string HomeTelephoneNumber, string IMAddress, string Importance, string Initials, string InternetFreeBusyAddress, string JobTitle, string Journal, string Language, string LastModificationTime, string LastName, string LastNameAndFirstName, string MailingAddress, string MailingAddressCity, string MailingAddressCountry, string MailingAddressPostalCode, string MailingAddressPostOfficeBox, string MailingAddressState, string MailingAddressStreet, string ManagerName, string MiddleName, string Mileage, string MobileTelephoneNumber, string NetMeetingAlias, string NetMeetingServer, string NickName, string Title, string Body, string OfficeLocation, string Subject)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Outlook.Application myOutlook;
            Outlook.ContactItem myItem;
            myOutlook = (Outlook.Application)Interaction.CreateObject("Outlook.Application");
            myItem = (Outlook.ContactItem)myOutlook.CreateItem(Outlook.OlItemType.olContactItem);
            try
            {
                {
                    var withBlock = myItem;
                    withBlock.Account = Account;
                    withBlock.Anniversary = Conversions.ToDate(Anniversary);
                    // .Application = Application
                    withBlock.AssistantName = AssistantName;
                    withBlock.AssistantTelephoneNumber = AssistantTelephoneNumber;
                    withBlock.BillingInformation = BillingInformation;
                    withBlock.Birthday = Conversions.ToDate(Birthday);
                    withBlock.Business2TelephoneNumber = Business2TelephoneNumber;
                    withBlock.BusinessAddress = BusinessAddress;
                    withBlock.Save();
                    withBlock.BusinessAddressCity = BusinessAddressCity;
                    withBlock.BusinessAddressCountry = BusinessAddressCountry;
                    withBlock.BusinessAddressPostalCode = BusinessAddressPostalCode;
                    withBlock.BusinessAddressPostOfficeBox = BusinessAddressPostOfficeBox;
                    withBlock.BusinessAddressState = BusinessAddressState;
                    withBlock.Save();
                    withBlock.BusinessAddressStreet = BusinessAddressStreet;
                    // .BusinessCardType = BusinessCardType
                    withBlock.BusinessFaxNumber = BusinessFaxNumber;
                    withBlock.BusinessHomePage = BusinessHomePage;
                    withBlock.BusinessTelephoneNumber = BusinessTelephoneNumber;
                    withBlock.CallbackTelephoneNumber = CallbackTelephoneNumber;
                    withBlock.CarTelephoneNumber = CarTelephoneNumber;
                    withBlock.Categories = Categories;
                    withBlock.Save();
                    withBlock.Children = Children;
                    // .xClass = xClass
                    withBlock.Companies = Companies;
                    withBlock.CompanyName = CompanyName;
                    withBlock.ComputerNetworkName = ComputerNetworkName;
                    // .Conflicts = Conflicts
                    // .ConversationTopic = ConversationTopic
                    // .CreationTime = CreationTime
                    withBlock.CustomerID = CustomerID;
                    withBlock.Save();
                    withBlock.Department = Department;
                    withBlock.Email1Address = Email1Address;
                    withBlock.Email1AddressType = Email1AddressType;
                    withBlock.Email1DisplayName = Email1DisplayName;
                    // .Email1EntryID = Email1EntryID
                    withBlock.Email2Address = Email2Address;
                    withBlock.Email2AddressType = Email2AddressType;
                    withBlock.Email2DisplayName = Email2DisplayName;
                    // .Email2EntryID = Email2EntryID
                    withBlock.Save();
                    withBlock.Email3Address = Email3Address;
                    withBlock.Email3AddressType = Email3AddressType;
                    withBlock.Email3DisplayName = Email3DisplayName;
                    // .Email3EntryID = Email3EntryID
                    withBlock.FileAs = FileAs;
                    withBlock.FirstName = FirstName;
                    withBlock.FTPSite = FTPSite;
                    withBlock.FullName = FullName;
                    withBlock.Save();
                    withBlock.Gender = (Outlook.OlGender)Conversions.ToInteger(Gender);
                    withBlock.GovernmentIDNumber = GovernmentIDNumber;
                    withBlock.Hobby = Hobby;
                    withBlock.Home2TelephoneNumber = Home2TelephoneNumber;
                    withBlock.HomeAddress = HomeAddress;
                    withBlock.HomeAddressCountry = HomeAddressCountry;
                    withBlock.HomeAddressPostalCode = HomeAddressPostalCode;
                    withBlock.HomeAddressPostOfficeBox = HomeAddressPostOfficeBox;
                    withBlock.HomeAddressState = HomeAddressState;
                    withBlock.HomeAddressStreet = HomeAddressStreet;
                    withBlock.HomeFaxNumber = HomeFaxNumber;
                    withBlock.Save();
                    withBlock.HomeTelephoneNumber = HomeTelephoneNumber;
                    withBlock.IMAddress = IMAddress;
                    withBlock.Importance = (Outlook.OlImportance)Conversions.ToInteger(Importance);
                    withBlock.Initials = Initials;
                    withBlock.InternetFreeBusyAddress = InternetFreeBusyAddress;
                    withBlock.JobTitle = JobTitle;
                    withBlock.Journal = Conversions.ToBoolean(Journal);
                    withBlock.Language = Language;
                    // .LastModificationTime = LastModificationTime
                    withBlock.LastName = LastName;
                    withBlock.Save();
                    // .LastNameAndFirstName = LastNameAndFirstName
                    withBlock.MailingAddress = MailingAddress;
                    withBlock.MailingAddressCity = MailingAddressCity;
                    withBlock.MailingAddressCountry = MailingAddressCountry;
                    withBlock.MailingAddressPostalCode = MailingAddressPostalCode;
                    withBlock.MailingAddressPostOfficeBox = MailingAddressPostOfficeBox;
                    withBlock.MailingAddressState = MailingAddressState;
                    withBlock.Save();
                    withBlock.MailingAddressStreet = MailingAddressStreet;
                    withBlock.ManagerName = ManagerName;
                    withBlock.MiddleName = MiddleName;
                    withBlock.Mileage = Mileage;
                    withBlock.Save();
                    withBlock.MobileTelephoneNumber = MobileTelephoneNumber;
                    withBlock.Save();
                    // '.NetMeetingAlias = NetMeetingAlias
                    // .Save()
                    // .NetMeetingServer = NetMeetingServer
                    // .Save()
                    withBlock.NickName = NickName;
                    withBlock.Save();
                    withBlock.Title = Title;
                    withBlock.Body = Body;
                    withBlock.OfficeLocation = OfficeLocation;
                    withBlock.Subject = Subject;
                    withBlock.Save();
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("AddContactDetail 1: " + ex.Message);
                LOG.WriteToArchiveLog("AddContactDetail 2: " + ex.StackTrace);
                LOG.WriteToArchiveLog("AddContactDetail 3: " + ex.InnerException.ToString());
                LOG.WriteToArchiveLog("AddContactDetail 4: " + ex.Data.ToString());
            }

            if (myOutlook is object)
            {
                myOutlook = null;
            }

            if (myItem is object)
            {
                myItem = null;
            }
        }

        public void AddEmailDetail(string SenderEmailAddress, string SUBJECT, string Body, string ReceivedByName, string ReceivedTime, string SentTO, string SenderName, string Bcc, string BillingInformation, string CC, string Companies, string CreationTime, string ReadReceiptRequested, string AllRecipients, string Sensitivity, string SentOn, string MsgSize, string DeferredDeliveryTime, string ExpiryTime, string LastModificationTime, string EmailImage, string Accounts, string ShortSubj)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Outlook.Application myOutlook;
            Outlook.ContactItem myItem;
            myOutlook = (Outlook.Application)Interaction.CreateObject("Outlook.Application");
            myItem = (Outlook.ContactItem)myOutlook.CreateItem(Outlook.OlItemType.olMailItem);
            {
                var withBlock = myItem;
                withBlock.SenderEmailAddress = SenderEmailAddress;
                withBlock.Subject = SUBJECT;
                withBlock.Body = Body;
                withBlock.ReceivedByName = ReceivedByName;
                withBlock.ReceivedTime = ReceivedTime;
                withBlock.SentTO = SentTO;
                withBlock.SenderName = SenderName;
                withBlock.Bcc = Bcc;
                withBlock.BillingInformation = BillingInformation;
                withBlock.CC = CC;
                withBlock.Companies = Companies;
                // .CreationTime = CreationTime
                withBlock.ReadReceiptRequested = ReadReceiptRequested;
                withBlock.AllRecipients = AllRecipients;
                withBlock.Sensitivity = (Outlook.OlSensitivity)Conversions.ToInteger(Sensitivity);
                withBlock.SentOn = SentOn;
                withBlock.MsgSize = MsgSize;
                withBlock.DeferredDeliveryTime = DeferredDeliveryTime;
                // .EntryID = EntryID
                withBlock.ExpiryTime = ExpiryTime;
                // .LastModificationTime = LastModificationTime
                withBlock.EmailImage = EmailImage;
                withBlock.Accounts = Accounts;
                withBlock.ShortSubj = ShortSubj;
                withBlock.Save();
            }

            if (myOutlook is object)
            {
                myOutlook = null;
            }

            if (myItem is object)
            {
                myItem = null;
            }

            GC.Collect();
        }

        public void CreateEcmHistoryFolder()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            bool bAutoCreateRestoreFolder = false;
            string sDebug = getUserParm("user_CreateOutlookRestoreFolder");
            // If sDebug.Length = 0 Then
            // bAutoCreateRestoreFolder = False
            // ElseIf sDebug.Equals("0") Then
            // bAutoCreateRestoreFolder = False
            // Else
            // bAutoCreateRestoreFolder = True
            // End If

            // If bAutoCreateRestoreFolder = False Then
            // Return
            // End If

            try
            {
                Outlook.Application oOutlook;
                Outlook._NameSpace oMAPI;
                Outlook.MAPIFolder oParentFolder;
                int i;
                int iElement = 0;
                oOutlook = new Outlook.Application();
                oMAPI = oOutlook.GetNamespace("MAPI");
                var A = getOutlookParentFolderNames();
                string MailboxName = Conversions.ToString(A[A.Count - 1]);
                oParentFolder = oMAPI.Folders[MailboxName];
                var oApp = new Outlook.Application();
                var oNS = oApp.GetNamespace("mapi");
                bool B = false;
                if (oParentFolder.Folders.Count != 0)
                {
                    var loopTo = oParentFolder.Folders.Count;
                    for (i = 1; i <= loopTo; i++)
                    {
                        if (!string.IsNullOrEmpty(Strings.Trim(oParentFolder.Folders[i].Name)))
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

                if (!B)
                {
                    oParentFolder.Folders.Add("Restored Emails");
                    var loopTo1 = oParentFolder.Folders.Count;
                    for (i = 1; i <= loopTo1; i++)
                    {
                        if (!string.IsNullOrEmpty(Strings.Trim(oParentFolder.Folders[i].Name)))
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
                LOG.WriteToArchiveLog("Notice: clsArchiver:CreateRestoreFolder 100.11 - " + ex.Message);
                LOG.WriteToArchiveLog("Notice: clsArchiver:CreateRestoreFolder 100.11 - " + ex.StackTrace);
            }
        }

        private void ProcessFolders(DirectoryInfo directoryInfo, bool recurseFolders, int depth, int maxDepth, ref int folderCount, ref int fileCount)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Debug.WriteLine(string.Empty);
            Debug.WriteLine(directoryInfo.FullName);
            folderCount += 1;

            // Recurse to process subfolders if requested.
            if (recurseFolders)
            {
                if (depth < maxDepth)
                {
                    depth += 1;
                    foreach (DirectoryInfo folder in directoryInfo.GetDirectories())
                        ProcessFolders(folder, recurseFolders, depth, maxDepth, ref folderCount, ref fileCount);
                }
            }

            // Process file folders
            foreach (FileInfo file in directoryInfo.GetFiles())
            {
                fileCount += 1;
                Debug.WriteLine(string.Format("{0} {1}, Size {2}, Create {3}, Access {4}, Update {5}, {6}", file.Name, file.Extension, file.Length, file.CreationTime, file.LastAccessTime, file.LastWriteTime, file.DirectoryName));
            }
        } // ProcessFolders

        /* TODO ERROR: Skipped IfDirectiveTrivia *//* TODO ERROR: Skipped DisabledTextTrivia *//* TODO ERROR: Skipped ElseDirectiveTrivia */
        private Outlook.Folders GetFolderByPath(string folderPath)
        {
            /* TODO ERROR: Skipped EndIfDirectiveTrivia */
            /* TODO ERROR: Skipped IfDirectiveTrivia *//* TODO ERROR: Skipped DisabledTextTrivia *//* TODO ERROR: Skipped ElseDirectiveTrivia */
            Outlook.Folders returnFolder = null;
            /* TODO ERROR: Skipped EndIfDirectiveTrivia */
            try
            {
                // Remove leading "\" characters.
                folderPath = folderPath.TrimStart(@"\".ToCharArray());

                // Split the folder path into individual folder names.
                var folders = folderPath.Split(@"\".ToCharArray());

                // Retrieve a reference to the root folder.

                var oMAPI = default(Outlook._NameSpace);
                string MailboxName = folders[0];
                /* TODO ERROR: Skipped IfDirectiveTrivia *//* TODO ERROR: Skipped DisabledTextTrivia *//* TODO ERROR: Skipped ElseDirectiveTrivia */
                Outlook.Folders oParentFolder = (Outlook.Folders)oMAPI.Folders[folders[0]];
                /* TODO ERROR: Skipped EndIfDirectiveTrivia */
                returnFolder = (Outlook.Folders)oParentFolder.Folders(0);
                // TryCast(Application.Session.Folders(folders(0)), Outlook.Folder)

                // If the root folder exists, look in subfolders.
                if (returnFolder is object)
                {
                    Outlook.Folders subFolders = null;
                    string folderName;

                    // Look through folder names, skipping the first folder, which you already retrieved.
                    for (int i = 1, loopTo = folders.Length - 1; i <= loopTo; i++)
                    {
                        folderName = folders[i];
                        subFolders = (Outlook.Folders)returnFolder.Folders;
                        /* TODO ERROR: Skipped IfDirectiveTrivia *//* TODO ERROR: Skipped DisabledTextTrivia *//* TODO ERROR: Skipped ElseDirectiveTrivia */
                        returnFolder = subFolders[folderName] as Outlook.Folders;
                        /* TODO ERROR: Skipped EndIfDirectiveTrivia */
                    }
                }
            }
            catch (Exception ex)
            {
                // messagebox.show(ex.Message)
                // Do nothing at all -- just return a null reference.
                returnFolder = null;
            }

            return returnFolder;
        }

        public void ArchiveEmailFoldersThreaded()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var T = new Thread((_) => this.ArchiveEmailFolders());
            T.IsBackground = true;
            T.TrySetApartmentState(ApartmentState.STA);
            T.Start();
        }

        public void ArchiveEmailFolders(string UID)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string isPublic = "N";
            bool bUseQuickSearch = false;
            bool ThreadingOn = true;
            int NbrOfIds = getCountStoreIdByFolder();
            var slStoreId = new SortedList();
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
                // LoadEntryIdByUserID(slStoreId)
                DBLocal.getCE_EmailIdentifiers(ref slStoreId);
            }
            else
            {
                slStoreId.Clear();
            }
            // #If EnableSingleSource Then
            // Dim tMachineGuid As Guid = GE.AddItem(gMachineID, "GlobalMachine", False)
            // #End If
            if (modGlobals.gRunMinimized == true)
            {
                My.MyProject.Forms.frmNotify2.WindowState = FormWindowState.Minimized;
            }
            else
            {
                My.MyProject.Forms.frmNotify2.Show();
            }

            if (modGlobals.gRunMinimized)
            {
                My.MyProject.Forms.frmNotify2.WindowState = FormWindowState.Minimized;
            }

            My.MyProject.Forms.frmNotify2.Location = new Point(25, 200);
            if (modGlobals.gRunMode.Equals("M-END"))
            {
                My.MyProject.Forms.frmNotify2.WindowState = FormWindowState.Minimized;
            }
            // If ThreadingOn Then 'FrmMDIMain.lblArchiveStatus.Text = "Archive Running"
            double L = 1d;
            int iEmails = 0;
            try
            {
                L = 1d;
                modGlobals.gEmailsBackedUp = 0;
                // Dim FolderList As New SortedList(Of String, String)
                var DGV = new DataGridView();
                L = 3d;
                // "Select FileDirectory, FolderName, FolderID, storeid, from EmailFolder
                try
                {
                    L = 3d;
                    getArchiveFolderIds(ref DGV);
                    L = 4d;
                }
                catch (Exception ex)
                {
                    L = 5d;
                    LOG.WriteToArchiveLog("ERROR 101.331a ArchiveEmailFolders " + ex.Message);
                    MessageBox.Show("Failed at ERROR 101.331a ArchiveEmailFolders " + ex.Message);
                }

                L = 6d;
                string FID = "";
                string SID = "";
                string FileDirectory = "";
                L = 7d;
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
                L = 8d;
                bool BX = UTIL.isOutLookRunning();
                if (BX == true)
                {
                    My.MyProject.Forms.frmOutlookNotice.Show();
                }

                Outlook.Application oOutlook;
                oOutlook = new Outlook.Application();
                L = 9d;
                My.MyProject.Forms.frmOutlookNotice.Close();
                My.MyProject.Forms.frmOutlookNotice.Hide();
                Outlook._NameSpace oMAPI = null;
                try
                {
                    oMAPI = oOutlook.GetNamespace("MAPI");
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }

                L = 10d;
                string TopFolder = "";
                string FolderFQN = "";
                string SubFolderName = "";
                L = 11d;
                int iProcessed = 0;
                L = 12d;
                LOG.WriteToArchiveLog("Archive of " + DGV.Rows.Count.ToString() + " folders by " + modGlobals.gCurrLoginID);
                for (int IX = 0, loopTo = DGV.Rows.Count - 1; IX <= loopTo; IX++)
                {
                    iEmails += 1;
                    Application.DoEvents();
                    try
                    {
                        SID = DGV.Rows[IX].Cells["storeid"].Value.ToString();
                    }
                    catch (Exception ex)
                    {
                        LOG.WriteToArchiveLog("Info: DVG @1 IX = " + IX.ToString() + " : " + ex.Message);
                        goto SKIPTHISONE;
                    }

                    L = 14.1d;
                    try
                    {
                        FID = DGV.Rows[IX].Cells["FolderID"].Value.ToString();
                    }
                    catch (Exception ex)
                    {
                        // log.WriteToArchiveLog("Info: DVG @2 Line = " + L.ToString)
                        LOG.WriteToArchiveLog("Informational: DVG @2 IX = " + IX.ToString() + " : " + ex.Message);
                        goto SKIPTHISONE;
                    }

                    L = 15.2d;
                    try
                    {
                        FileDirectory = DGV.Rows[IX].Cells["FileDirectory"].Value.ToString();
                    }
                    catch (Exception ex)
                    {
                        // log.WriteToArchiveLog("Info: DVG @3 Line = " + L.ToString)
                        LOG.WriteToArchiveLog("Info: DVG @3 IX = " + IX.ToString() + " : " + ex.Message);
                        goto SKIPTHISONE;
                    }

                    L = 16.3d;
                    try
                    {
                        FolderName = DGV.Rows[IX].Cells["FolderName"].Value.ToString();
                    }
                    catch (Exception ex)
                    {
                        // log.WriteToArchiveLog("Info: DVG4 @ Line = " + L.ToString)
                        LOG.WriteToArchiveLog("Info: DVG4 @ IX = " + IX.ToString() + " : " + ex.Message);
                        goto SKIPTHISONE;
                    }
                    // messagebox.show(FolderName )
                    L = 17.4d;
                    if (modGlobals.gTerminateImmediately)
                    {
                        // If ThreadingOn Then 'FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"
                        My.MyProject.Forms.frmNotify2.Close();
                        modGlobals.gOutlookArchiving = false;
                        My.MySettingsProperty.Settings["LastArchiveEndTime"] = DateAndTime.Now;
                        My.MySettingsProperty.Settings.Save();
                        My.MyProject.Forms.frmNotify2.Close();
                        return;
                    }

                    L = 18.5d;
                    iProcessed += 1;
                    modGlobals.gEmailsBackedUp = modGlobals.gEmailsBackedUp + iProcessed;
                    // FID = FolderID
                    // SID = StoreID
                    L = 18.9d;
                    // TopFolder  = getParentFolderNameById(FID)
                    TopFolder = getParentFolderNameById(FID);

                    // log.WriteToArchiveLog("*** FOLDER NOTICE TopFolder  001x - : " + TopFolder )

                    FolderFQN = getFolderNameById(FID);

                    // log.WriteToArchiveLog("*** FOLDER NOTICE 001a - : " + FolderFQN )

                    var FolderParms = FolderFQN.Split('|');
                    TopFolder = FolderParms[0];
                    SubFolderName = FolderParms[1];
                    My.MyProject.Forms.frmNotify2.lblFolder.Text = SubFolderName;
                    My.MyProject.Forms.frmNotify2.Refresh();
                    L = 16d;
                    Outlook.Application myOlApp;
                    Outlook.MAPIFolder myFolder;
                    string myEntryID;
                    string myStoreID;
                    myOlApp = (Outlook.Application)Interaction.CreateObject("Outlook.Application");
                    myEntryID = FID;
                    myStoreID = SID;
                    try
                    {
                        myFolder = myOlApp.Session.GetFolderFromID(myEntryID, myStoreID);
                    }
                    catch (Exception ex)
                    {
                        LOG.WriteToArchiveLog("FATAL ERROR: ArchiveEmailFolders 900A - COULD NOT OPEN EMAIL FOLDER: " + ex.Message);
                        LOG.WriteToArchiveLog("FATAL ERROR: ArchiveEmailFolders 900B - COULD NOT OPEN EMAIL FOLDER: " + TopFolder + " : " + SubFolderName);
                        goto SKIPTHISONE;
                    }

                    int iFolders = myFolder.Folders.Count;
                    Outlook.MAPIFolder oFolder = null;
                    // L = 17

                    try
                    {
                        L = 18d;
                        string FolderID = FID;
                        oFolder = oMAPI.GetFolderFromID(FolderID, SID);
                        L = 19d;
                        string tEmailFolderName = "EMAIL: " + oFolder.Name;
                        string FolderBeingProcessed = oFolder.Name;
                        // #If EnableSingleSource Then
                        // Dim tNewGuid As Guid = GE.AddItem(tEmailFolderName, "GlobalDirectory", False)
                        // #End If
                        Console.WriteLine(tEmailFolderName);
                        if (!string.IsNullOrEmpty(Strings.Trim(oFolder.Name)))
                        {
                            // If xDebug Then log.WriteToArchiveLog("Code 100 Processing email folder: " + oFolder.Name)
                            string ParentID = oFolder.EntryID;
                            string ChildID = oFolder.EntryID;
                            string tFolderName = oFolder.Name;
                            var CurrentFolder = oFolder;
                            string StoreID = oFolder.StoreID;
                            L = 20d;
                            if (Strings.InStr(tFolderName, "_2", CompareMethod.Text) > 0)
                            {
                                Console.WriteLine("Here");
                            }

                            if (Strings.InStr(tFolderName, "_system", CompareMethod.Text) > 0)
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

                            L = 21d;
                            EMF.setFolderid(ref ChildID);
                            EMF.setFoldername(ref tFolderName);
                            EMF.setParentfolderid(ref ParentID);
                            try
                            {
                                EMF.setParentfoldername(ref FolderFQN);
                            }
                            catch (Exception ex)
                            {
                                LOG.WriteToArchiveLog("WARNING Failed to set parent folder: " + FolderFQN);
                            }

                            L = 22d;
                            EMF.setUserid(ref modGlobals.gCurrUserGuidID);

                            // messagebox.show("TopFolder " + TopFolder  + " : " + "SubFolderName " + " : " + SubFolderName )
                            bool BB = GetEmailFolderParms(TopFolder, modGlobals.gCurrUserGuidID, SubFolderName, ref ArchiveEmails, ref RemoveAfterArchive, ref SetAsDefaultFolder, ref ArchiveAfterXDays, ref RemoveAfterXDays, ref RemoveXDays, ref ArchiveXDays, ref DB_ID, ref ArchiveOnlyIfRead);

                            // If xDebug Then log.WriteToArchiveLog("Code 200 Processing email folder: " + SubFolderName )

                            if (BB)
                            {
                                L = 23d;
                                // If xDebug Then log.WriteToArchiveLog("Code 200a: " + SubFolderName )
                                // Dim bUseQuickSearch As Boolean = False
                                // Dim NbrOfIds As Integer = getCountStoreIdByFolder(EmailFolderFQN)
                                // If NbrOfIds < 1000000 Then
                                // bUseQuickSearch = True
                                // End If

                                // Dim slEntryId As New SortedList
                                // If bUseQuickSearch Then
                                // '** 001
                                // LoadEntryIdByFolder(EmailFolderFQN, slEntryId)
                                // Else
                                // slEntryId.Clear()
                                // End If
                                L = 24d;
                                try
                                {
                                    DBLocal.setOutlookMissing();
                                    // *************************************************************************************
                                    ArchiveEmailsInFolder(UID, TopFolder, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, CurrentFolder, StoreID, ArchiveOnlyIfRead, RetentionYears, RetentionCode, EmailFolderFQN, slStoreId, isPublic);
                                    // *************************************************************************************
                                    if (modGlobals.gTerminateImmediately)
                                    {
                                        // If ThreadingOn Then FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"
                                        My.MyProject.Forms.frmNotify2.Close();
                                        modGlobals.gOutlookArchiving = false;
                                        My.MySettingsProperty.Settings["LastArchiveEndTime"] = DateAndTime.Now;
                                        My.MySettingsProperty.Settings.Save();
                                        My.MyProject.Forms.frmNotify2.Close();
                                        return;
                                    }

                                    L = 25d;
                                }
                                catch (Exception ex)
                                {
                                    LOG.WriteToArchiveLog("ERROR 33.242.345 - " + ex.Message);
                                    LOG.WriteToArchiveLog("ERROR 33.242.345 - " + ex.StackTrace);
                                }

                                L = 26d;
                            }
                            else
                            {
                                LOG.WriteToArchiveLog("ERROR 33.242.3 - Did not find '" + TopFolder + "' / " + "'" + SubFolderName + ".");
                            }

                            L = 27d;
                        }

                        L = 28d;
                    }
                    catch (Exception ex)
                    {
                        string Msg = "ERROR:ArchiveEmailFolders 100.876.5:  Check to see the folders are defined properly. (Deactivate and reactivate). ";
                        Msg = Msg + "   Check to see the folders are defined properly. (Deactivate and reactivate)." + Constants.vbCrLf;
                        Msg = Msg + "   There is a problem with TopFolder:'" + TopFolder + "'." + Constants.vbCrLf;
                        Msg = Msg + "        SubFolderName:'" + SubFolderName + "'." + Constants.vbCrLf;
                        Msg = Msg + "   Message: " + ex.Message;
                        // frmHelp.MsgToDisplay  = Msg
                        // frmHelp.CallingScreenName  = "Archive Email Folders"
                        // frmHelp.CaptionName  = "EMAIL Archive Error"
                        // frmHelp.Timer1.Interval = 10000
                        // frmHelp.Show()
                        LOG.WriteToArchiveLog(Msg);
                    }

                    L = 29d;
                    SKIPTHISONE:
                    ;
                }

                L = 20d;
                DGV = null;
                GC.Collect();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: 100 ArchiveEmailFolders - " + ex.Message);
                LOG.WriteToArchiveLog("ERROR: 100 ArchiveEmailFolders - " + ex.StackTrace);
                LOG.WriteToArchiveLog("ERROR: 100 ArchiveEmailFolders - Line #" + L.ToString());
            }
            finally
            {
                // If ThreadingOn Then FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"
            }

            // If ThreadingOn Then FrmMDIMain.lblArchiveStatus.Text = "Archive Quiet"
            UpdateAttachmentCounts();
            My.MyProject.Forms.frmNotify2.Close();
            modGlobals.gOutlookArchiving = false;
            My.MySettingsProperty.Settings["LastArchiveEndTime"] = DateAndTime.Now;
            My.MySettingsProperty.Settings.Save();
        }

        public void ArchiveSelectedOutlookFolders(string UID, string TopFolder, SortedList slStoreId)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            try
            {
                EmailsBackedUp = 0;
                FilesBackedUp = 0;
                // ********************************************************
                // PARAMETER: MailboxName = Name of Parent Outlook Folder for
                // the current user: Usually in the form of
                // "Mailbox - Doe, John" or
                // "Public Folders
                // RETURNS: Array of SubFolders in Current User's Mailbox
                // Or unitialized array if error occurs
                // Because it returns an array, it is for VB6 only.
                // Change to return a variant or a delimited list for
                // previous versions of vb
                // EXAMPLE:
                // Dim sArray() As String
                // Dim ictr As Integer
                // sArray = OutlookFolderNames("Mailbox - Doe, John")
                // 'On Error Resume Next
                // For ictr = 0 To UBound(sArray)
                // if xDebug then log.WriteToArchiveLog sArray(ictr)
                // Next
                // *********************************************************
                Outlook.Application oOutlook;
                Outlook._NameSpace oMAPI = null;
                Outlook.MAPIFolder oParentFolder = null;
                // Dim sArray() As String
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
                    oParentFolder = oMAPI.GetFolderFromID(MailboxName);
                }
                catch (Exception ex)
                {
                    // messagebox.show("ERROR 3421.45.a: could not open '" + MailboxName  + "' " + vbCrLf + ex.Message)
                    LOG.WriteToArchiveLog("ERROR 3421.45.a: could not open '" + MailboxName + "' " + Constants.vbCrLf + ex.Message);
                    LOG.WriteToArchiveLog("ERROR 3421.45.a:" + Constants.vbCrLf + ex.StackTrace);
                    My.MyProject.Forms.frmNotify2.Close();
                    return;
                }

                // AddChildFolders(LB, MailboxName )

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
                var ARCH = new clsArchiver();
                string ArchiveOnlyIfRead = "";

                // ************************************
                string isPublic = "N";
                if (oParentFolder.Folders.Count != 0)
                {
                    if (xDebug)
                        LOG.WriteToArchiveLog("** : " + TopFolder + " folder count = " + oParentFolder.Folders.Count.ToString() + ".");
                    var loopTo = oParentFolder.Folders.Count;
                    for (i = 1; i <= loopTo; i++)
                    {
                        if (i > oParentFolder.Folders.Count)
                        {
                            break;
                        }

                        if (!string.IsNullOrEmpty(Strings.Trim(oParentFolder.Folders[i].Name)))
                        {
                            if (xDebug)
                                LOG.WriteToArchiveLog("100 Processing email folder: " + oParentFolder.Folders[i].Name);
                            string ParentID = oParentFolder.EntryID;
                            string ChildID = oParentFolder.Folders[i].EntryID;
                            string tFolderName = oParentFolder.Folders[i].Name;
                            var CurrentFolder = oParentFolder.Folders[i];
                            string StoreID = oParentFolder.StoreID;
                            if (Strings.InStr(tFolderName, "_2", CompareMethod.Text) > 0)
                            {
                                Console.WriteLine("Here");
                            }

                            if (Strings.InStr(tFolderName, "_system", CompareMethod.Text) > 0)
                            {
                                Console.WriteLine("Here");
                            }

                            string EmailFolderFQN = TopFolder + "|" + tFolderName;
                            int BB = ckArchEmailFolder(EmailFolderFQN, modGlobals.gCurrUserGuidID);
                            if (xDebug)
                                LOG.WriteToArchiveLog("** EmailFolderFQN : " + EmailFolderFQN + ".");
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
                                string argval = oParentFolder.Name;
                                EMF.setParentfoldername(ref argval);
                                oParentFolder.Name = argval;
                                EMF.setUserid(ref modGlobals.gCurrUserGuidID);
                                BB = Conversions.ToInteger(GetEmailFolderParms(TopFolder, modGlobals.gCurrUserGuidID, tFolderName, ref ArchiveEmails, ref RemoveAfterArchive, ref SetAsDefaultFolder, ref ArchiveAfterXDays, ref RemoveAfterXDays, ref RemoveXDays, ref ArchiveXDays, ref DB_ID, ref ArchiveOnlyIfRead));
                                if (Conversions.ToBoolean(BB))
                                {

                                    // Dim bUseQuickSearch As Boolean = False
                                    // Dim NbrOfIds As Integer = getCountStoreIdByFolder(EmailFolderFQN)
                                    // If NbrOfIds < 1000000 Then
                                    // bUseQuickSearch = True
                                    // End If

                                    // Dim slEntryId As New SortedList
                                    // If bUseQuickSearch Then
                                    // '** 003
                                    // LoadEntryIdByFolder(EmailFolderFQN, slEntryId, NbrOfIds)
                                    // Else
                                    // slEntryId.Clear()
                                    // End If

                                    // *************************************************************************************
                                    DBLocal.setOutlookMissing();
                                    ARCH.ArchiveEmailsInFolder(UID, TopFolder, ArchiveEmails, RemoveAfterArchive, SetAsDefaultFolder, ArchiveAfterXDays, RemoveAfterXDays, RemoveXDays, ArchiveXDays, DB_ID, CurrentFolder, StoreID, ArchiveOnlyIfRead, RetentionYears, RetentionCode, EmailFolderFQN, slStoreId, isPublic);
                                    // *************************************************************************************
                                }
                            }
                        }

                        GetNextParentFolder:
                        ;
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
                        LOG.WriteToArchiveLog("Examine Child Folder: " + pFolder + " / " + cFolder + " : " + K.ToString());
                    if (Strings.InStr(cFolder, "_2", CompareMethod.Text) > 0)
                    {
                        Console.WriteLine("Here");
                    }

                    if (Strings.InStr(cFolder, "_system", CompareMethod.Text) > 0)
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
                LOG.WriteToArchiveLog("Error processing '" + TopFolder + "' 653.21b: " + ex.Message);
                LOG.WriteToArchiveLog("Error processing 653.21b: " + Constants.vbCrLf + ex.StackTrace);
                // messagebox.show("Error processing '" + TopFolder  + "' 653.21b: " + ex.Message)
            }
        }

        public bool getCurrentOutlookFolders(string TopFolder, ref SortedList<string, string> ChildFoldersList)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (ddebug)
                LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 1");
            if (TopFolder.Trim().Length == 0)
            {
                My.MyProject.Forms.frmNotify2.Close();
                return true;
            }

            if (ddebug)
                LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 2");
            bool B = false;
            try
            {
                // ********************************************************
                // PARAMETER: MailboxName = Name of Parent Outlook Folder for
                // the current user: Usually in the form of
                // "Mailbox - Doe, John" or
                // "Public Folders
                // RETURNS: Array of SubFolders in Current User's Mailbox
                // Or unitialized array if error occurs
                // Because it returns an array, it is for VB6 only.
                // Change to return a variant or a delimited list for
                // previous versions of vb
                // EXAMPLE:
                // Dim sArray() As String
                // Dim ictr As Integer
                // sArray = OutlookFolderNames("Mailbox - Doe, John")
                // 'On Error Resume Next
                // For ictr = 0 To UBound(sArray)
                // if xDebug then log.WriteToArchiveLog sArray(ictr)
                // Next
                // *********************************************************

                if (ddebug)
                    LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 3");
                Outlook.Application oOutlook;
                if (ddebug)
                    LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 4");
                Outlook.NameSpace oMAPI = null;
                if (ddebug)
                    LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 5");
                Outlook.MAPIFolder oParentFolder = null;
                // Dim sArray() As String
                int i;
                int iElement = 0;
                if (ddebug)
                    LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 6");
                oOutlook = new Outlook.Application();
                if (ddebug)
                    LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 7");
                try
                {
                    oMAPI = oOutlook.GetNamespace("MAPI");
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("ERROR: getCurrentOutlookFolders 100  : " + ex.Message);
                    LOG.WriteToArchiveLog("ERROR: getCurrentOutlookFolders 100a : " + ex.StackTrace);
                    oParentFolder = null;
                    oMAPI = null;
                    oOutlook = null;
                    return false;
                }

                string MailboxName = TopFolder;
                int iFolderCnt = oMAPI.Folders.Count;
                if (iFolderCnt > 0)
                {
                    MailboxName = oMAPI.Folders[1].Name.ToString();
                }

                try
                {
                    oParentFolder = oMAPI.Folders[MailboxName];
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("NOTICE: getCurrentOutlookFolders 200  : " + ex.Message);
                    LOG.WriteToArchiveLog("NOTICE: getCurrentOutlookFolders 200a : " + ex.StackTrace);
                    oParentFolder = null;
                    oMAPI = null;
                    oOutlook = null;
                    return false;
                }

                // AddChildFolders(LB, MailboxName )
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
                var ARCH = new clsArchiver();
                string ArchiveOnlyIfRead = "";
                if (ddebug)
                    LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 8");
                ChildFoldersList.Clear();
                if (oParentFolder.Folders.Count > 0)
                {
                    var loopTo = oParentFolder.Folders.Count;
                    for (i = 1; i <= loopTo; i++)
                    {
                        if (!string.IsNullOrEmpty(Strings.Trim(oParentFolder.Folders[i].Name)))
                        {
                            string ParentID = oParentFolder.EntryID;
                            string ChildID = oParentFolder.Folders[i].EntryID;
                            string tFolderName = oParentFolder.Folders[i].Name;
                            var CurrentFolder = oParentFolder.Folders[i];
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
                                    LOG.WriteToArchiveLog("Warning No Load: getCurrentOutlookFolders - Name: " + tFolderName);
                                    LOG.WriteToArchiveLog("Warning No Load: getCurrentOutlookFolders - ChildFoldersList.Add: " + ex.Message);
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
                    // Console.WriteLine("Child Folder: " + cFolder)
                    if (K > 0)
                    {
                        ListChildFolders(oChildFolder, cFolder);
                    }
                }

                if (ddebug)
                    LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 9");
                oMAPI = null;
                GC.Collect();
                B = true;
            }
            catch (Exception ex)
            {
                if (ddebug)
                    LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 10");
                bool bOfficeInstalled = UTIL.isOfficeInstalled();
                if (bOfficeInstalled == false)
                {
                    LOG.WriteToArchiveLog("Error 653.20c: clsArchiver : getCurrentOutlookFolders - OFFICE appears not to be installed.");
                    try
                    {
                        ChildFoldersList.Add("* MS Office not found", "* MS Office not found");
                    }
                    catch (Exception ex2)
                    {
                    }
                }

                try
                {
                    ChildFoldersList.Add("* Folders not found", "* Folders not found");
                }
                catch (Exception ex3)
                {
                }

                LOG.WriteToArchiveLog("Error 653.21c: clsArchiver : getCurrentOutlookFolders - Outlook appears to be unavailable, " + ex.Message);
                B = false;
            }

            if (ddebug)
                LOG.WriteToArchiveLog("getCurrentOutlookFolders : Step 11");
            return B;
        }

        private void DeleteMessage(string sStoreID, string sMessageID)
        {
            // Create Outlook application.
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Outlook.Application oApp;
            oApp = new Outlook.Application();
            // Get Mapi NameSpace.
            Outlook.NameSpace oNS;
            oNS = oApp.GetNamespace("mapi");
            oNS.Logon("Outlook", ShowDialog: false, NewSession: true);
            // Dim oMsg As MailItem
            Outlook.MailItem oMsg;
            oMsg = (Outlook.MailItem)oNS.GetItemFromID(sMessageID, sStoreID);
            oMsg.Delete();
            LOG.WriteToArchiveLog("clsArchiver : DeleteMessage : Delete Performed 12");

            // Log off.
            oNS.Logoff();

            // Clean up.
            oApp = null;
            oNS = null;
            // oItems = Nothing
            oMsg = null;
        }

        public void DeleteOutlookMessages(string UserID)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            try
            {
                if (UserID.Length == 0)
                {
                    if (modGlobals.gCurrLoginID.Length > 0)
                    {
                        modGlobals.gCurrUserGuidID = getUserGuidID(modGlobals.gCurrLoginID);
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

                string S = "Select [EmailGuid],[StoreID],[UserID], [MessageID] FROM [EmailToDelete] where userid = '" + UserID + "'";
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
                oNS.Logon("Outlook", ShowDialog: false, NewSession: true);
                // Dim oMsg As MailItem
                Outlook.MailItem oMsg;
                var oDeletedItems = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderDeletedItems);
                SqlDataReader rsdata = null;
                string CS = setConnStr();   // getGateWayConnStr(gGateWayID)
                var CONN = new SqlConnection(CS);
                CONN.Open();
                var command = new SqlCommand(S, CONN);
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
                            oMsg = (Outlook.MailItem)oNS.GetItemFromID(MessageID, StoreID);
                            if (oMsg is object)
                            {
                                II += 1;
                                // frmReconMain.SB.Text = "Processing Expired Email from Outlook# " & II
                                // frmReconMain.SB.Refresh()
                                Application.DoEvents();
                                // oMsg.Delete()
                                oMsg.Move(oDeletedItems);
                                if (xDebug)
                                    LOG.WriteToArchiveLog("EXPIRATION: clsArchiver:DeleteOutlookMessages : Delete Performed 15 - Message# " + II.ToString());
                                Application.DoEvents();
                            }
                        }
                        catch (Exception ex)
                        {
                            if (Strings.InStr(ex.Message, "cannot be found", CompareMethod.Text) > 0)
                            {
                            }
                            else
                            {
                                LOG.WriteToArchiveLog("ERROR 054.31: Failed to delete msg " + ex.Message.ToString());
                            }
                        }
                    }
                }
                else
                {
                    id = -1;
                }

                if (!rsdata.IsClosed)
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
            }
            // frmReconMain.SB.Text = "Done..."
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: DeleteOutlookMessages - " + ex.Message);
            }
        }

        public void UpdateMessageStoreID(string UserID)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var A = new string[1];
            string S = "Select [EmailGuid],[StoreID],[UserID], [MessageID] FROM  [EmailToDelete] where userid = '" + UserID + "'";
            bool b = true;
            int i = 0;
            int id = -1;
            int II = 0;
            string table_name = "";
            string column_name = "";
            string data_type = "";
            string character_maximum_length = "";
            SqlDataReader RSData = null;
            string CS = setConnStr();   // getGateWayConnStr(gGateWayID) :
            var CONN = new SqlConnection(CS);
            CONN.Open();
            var command = new SqlCommand(S, CONN);
            RSData = command.ExecuteReader();
            if (RSData.HasRows)
            {
                while (RSData.Read())
                {
                    string EmailGuid = RSData.GetValue(0).ToString().Trim();
                    string StoreID = RSData.GetValue(1).ToString().Trim();
                    string MySql = "UPDATE  [Email] SET [StoreID] = '" + StoreID + "' WHERE [EmailGuid] = '" + EmailGuid + "'";
                    Array.Resize(ref A, Information.UBound(A) + 1 + 1);
                    A[Information.UBound(A)] = MySql;
                }
            }
            else
            {
                id = -1;
            }

            RSData.Close();
            RSData = null;
            GC.Collect();
            var loopTo = Information.UBound(A) - 1;
            for (II = 0; II <= loopTo; II++)
            {
                My.MyProject.Forms.frmMain.SB.Text = "Setting SourceID: " + II;
                My.MyProject.Forms.frmMain.SB.Refresh();
                S = A[II];
                if (S is object)
                {
                    b = ExecuteSqlNewConn(S, false);
                }

                if (!b)
                {
                    if (xDebug)
                        LOG.WriteToArchiveLog("Failed to update: " + S);
                }
            }
        }

        public bool RestoreEmail(string EmailGuid)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

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
            oEmail = (Outlook.MailItem)oApp.CreateItem(Outlook.OlItemType.olMailItem);
            {
                var withBlock = oEmail;
                withBlock.To = SendToAddr;
                withBlock.CC = CcList;
                withBlock.BCC = BccList;
                withBlock.Subject = SubjLong;
                withBlock.BodyFormat = Outlook.OlBodyFormat.olFormatUnspecified;
                withBlock.Body = Body;
                withBlock.Importance = Outlook.OlImportance.olImportanceNormal;
                withBlock.ReadReceiptRequested = false;
                MessageBox.Show("Get each attachment here");
                withBlock.Attachments.Add(AttachmentFQN, olByValue, SourceName);
                withBlock.Recipients.ResolveAll();
                withBlock.Save();
                withBlock.Display(); // Show the email message and allow for editing before sending
                                     // .Send 'You can automatically send the email without displaying it.
            }

            oEmail = null;
            oApp.Quit();
            oApp = null;
            return default;
        }

        public bool SendEmail()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

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
            oEmail = (Outlook.MailItem)oApp.CreateItem(Outlook.OlItemType.olMailItem);
            {
                var withBlock = oEmail;
                withBlock.To = SendToAddr;
                withBlock.CC = CcList;
                withBlock.BCC = BccList;
                withBlock.Subject = SubjLong;
                withBlock.BodyFormat = Outlook.OlBodyFormat.olFormatUnspecified;
                withBlock.Body = Body;
                withBlock.Importance = Outlook.OlImportance.olImportanceNormal;
                withBlock.ReadReceiptRequested = false;
                MessageBox.Show("Get each attachment here");
                withBlock.Attachments.Add(AttachmentFQN, olByValue, SourceName);
                withBlock.Recipients.ResolveAll();
                withBlock.Save();
                withBlock.Send(); // You can automatically send the email without displaying it.
            }

            oEmail = null;
            oApp.Quit();
            oApp = null;
            return default;
        }

        public void ShellFile(string File)
        {
            string arglpOperation = "open";
            string arglpParameters = 0L.ToString();
            string arglpDirectory = 0L.ToString();
            clsArchiver.ShellExecute(0L, ref arglpOperation, ref File, ref arglpParameters, ref arglpDirectory, 1L);
        }

        public void OSDisplayFile()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string sFile = @"C:\Users\wmiller\Documents\Documents on Dale's PDA\RENT REH.doc";
            ShellFile(sFile);
            long ln;
            long hWndDesk = GetDesktopWindow();
            sFile = @"c:\hpfr3420.xml";
            return;
            long Scr_hDC;
            Scr_hDC = GetDesktopWindow();
            string arglpOperation = "";
            string arglpParameters = "";
            string arglpDirectory = "";
            ln = clsArchiver.ShellExecute(0L, ref arglpOperation, ref sFile, ref arglpParameters, ref arglpDirectory, 1L);
            string arglpFile = "notepad";
            ln = clsArchiver.ShellExecute(0L, ref Constants.vbNullString, ref arglpFile, ref sFile, ref Constants.vbNullString, (long)Constants.vbNormalFocus);
            if (xDebug)
                LOG.WriteToArchiveLog("LN = " + ln.ToString());
            // ShellExecute 0&, vbNullString, "notepad", "c:\test.doc", vbNullString, vbNormalFocus
            ln = clsArchiver.ShellExecute(0L, ref Constants.vbNullString, ref sFile, ref Constants.vbNullString, ref Constants.vbNullString, (long)Constants.vbNormalFocus);
            if (ln < 32L)
            {
                Interaction.Shell("rundll32.exe shell32.dll,OpenAs_RunDLL " + sFile, Constants.vbNormalFocus);
            }
            // opens C:\test.doc with its default viewer. Note that if the path you pass contains spaces, you need to surround it by quotes:
        }

        public void XXX()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            long hWndDesk = GetDesktopWindow();
            var oApp = new Outlook.Application();
            string sBuild = Strings.Left(oApp.Version, Strings.InStr(1, oApp.Version, ".") + 1);
            var oNS = oApp.GetNamespace("mapi");
            Outlook.MailItem oItem;
            oApp = (Outlook.Application)Interaction.CreateObject("Outlook.Application");
            oNS = oApp.GetNamespace("MAPI");

            // oItem = oApp.ActiveInspector.CurrentItem

            // Private Sub Command1_Click()
            string sFile = modGlobals.gTempDir + @"\Enterprise Business Alert  March Toward Mobilization.eml";
            long ln;
            string arglpOperation = "Open";
            string arglpParameters = "";
            string arglpDirectory = "";
            ln = clsArchiver.ShellExecute(hWndDesk, ref arglpOperation, ref sFile, ref arglpParameters, ref arglpDirectory, 1L);
            if (ln < 32L)
            {
                Interaction.Shell("rundll32.exe shell32.dll,OpenAs_RunDLL " + sFile, Constants.vbNormalFocus);
            }

            while (oApp.ActiveInspector() is null)
                Application.DoEvents();
            oItem = (Outlook.MailItem)oApp.CopyFile(sFile, "Restored Emails");
            oItem = (Outlook.MailItem)oApp.ActiveInspector().CurrentItem;
            oItem.Copy();
        }

        public void SendNow()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Outlook.Application oApp;
            // Dim oCtl As Office.CommandBarControl
            // Dim oPop As Office.CommandBarPopup
            // Dim oCB As Office.CommandBar
            Outlook.NameSpace oNS;
            object oItem;

            // First find and send the current item to the Outbox
            oApp = (Outlook.Application)Interaction.CreateObject("Outlook.Application");
            oNS = oApp.GetNamespace("MAPI");
            oItem = oApp.ActiveInspector().CurrentItem;
            try
            {
                oItem.Send();
            }
            catch (Exception ex)
            {
                if (xDebug)
                    LOG.WriteToArchiveLog(ex.Message);
            }

            oApp = null;
            // oCtl = Nothing
            // oPop = Nothing
            // oCB = Nothing
            oNS = null;
            oItem = null;
        }

        public void ArchiveRSS(string UserID)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

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
            var listOfRssPages = new List<rssChannelItem>();
            if (UserID.Equals("*"))
            {
                WhereClause = "";
            }
            else if (UserID.Length > 0)
            {
                WhereClause = " where UserID = '" + UserID + "'";
            }

            var ListOfUrls = new List<string>();
            ListOfUrls = GET_RssPullData(modGlobals.gGateWayID, WhereClause, RC);
            var RssInfo = new frmNotify2();
            RssInfo.Show();
            RssInfo.Text = "RSS Archive";
            // ** We have all of the registered RSS feeds
            int K = 0;
            foreach (var xStr in ListOfUrls)
            {
                K += 1;
                var S = xStr.Split('|');
                // Dim strItems = RssName + "|" + RssUrl + "|" + UserID
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
                var ChannelItems = new List<rssChannelItem>();
                var RSS = new clsRSS();
                // ChannelItems = ReadRssDataFromSite(RssUrl As String, CaptureLink As Boolean) As List(Of rssChannelItem)
                ChannelItems = RSS.ReadRssDataFromSite(RssUrl, true);
                RSS = null;
                GC.Collect();
                GC.WaitForPendingFinalizers();
                int I = 0;
                foreach (rssChannelItem ChannelItem in ChannelItems)
                {
                    I += 1;
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
                        // We may want to use a CE database here to speed thing up
                        ArchiveRssFeed(RowGuid, RssTitle, rlink, desc, KeyWords, RssFQN, RetentionCode, Conversions.ToDate(pubdate), Conversions.ToString(isPublic));
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
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (!File.Exists(RssFQN))
            {
                MessageBox.Show("RSS Feed could not be processed: " + Constants.vbCrLf + RssFQN);
                return;
            }

            string FileText = ReadFileIntoString(RssFQN);
            string CrcHash = ENC.getSha1HashKey(FileText);
            string RssDescription = RssDesc.Replace("'", "''");
            string file_SourceName = RssFQN;
            string SourceGuid = Guid.NewGuid().ToString();
            string RSSProcessingDir = System.Configuration.ConfigurationManager.AppSettings["RSSProcessingDir"];
            if (!Directory.Exists(RSSProcessingDir))
            {
                Directory.CreateDirectory(RSSProcessingDir);
            }

            string ckMetaData = "N";
            int LastVerNbr = 0;
            var FI = new FileInfo(RssFQN);
            string OriginalFileType = FI.Extension;
            string file_SourceTypeCode = FI.Extension;
            string file_FullName = FI.Name;
            // Dim file_LastAccessDate As String = FI.LastAccessTime.ToString
            string file_LastAccessDate = FI.LastAccessTime.ToString();
            string file_CreateDate = Conversions.ToString(FI.CreationTime);
            string file_LastWriteTime = RssPublishDate.ToString();
            string file_Length = FI.Length.ToString();
            FI = null;
            if (Conversions.ToInteger(file_Length) == 0)
            {
                MessageBox.Show("Bad file: " + RssFQN);
                return;
            }

            GC.Collect();
            GC.WaitForPendingFinalizers();

            // Dim iDatasourceCnt As Integer = getCountDataSourceFiles(file_FullName, CrcHash)
            int iDatasourceCnt = getCountRssFile(file_FullName, RssPublishDate.ToString());
            if (iDatasourceCnt == 0)
            {
                saveContentOwner(SourceGuid, modGlobals.gCurrUserGuidID, "C", RSSProcessingDir, modGlobals.gMachineID, modGlobals.gNetworkID);
            }

            int NbrDUps = ckFileExistInRepo(Environment.MachineName, file_FullName);
            if (NbrDUps > 0)
            {
                string ContentSha1Hash = ENC.GenerateSHA512HashFromFile(file_FullName);
                // ** Update the HASH and the Source Binary
                // * Get the file hash
                UpdateDataSouceHashAndBinary(Environment.MachineName, file_FullName, ContentSha1Hash);
            }

            if (iDatasourceCnt == 0)
            {
                var StartInsert = DateAndTime.Now;
                LOG.WriteToTimerLog("Start ArchiveRssFeed", "InsertRSSFeed:" + file_FullName, "START");
                bool BB = AddSourceToRepo(modGlobals.gCurrUserGuidID, modGlobals.gMachineID, modGlobals.gNetworkID, SourceGuid, RssFQN, file_FullName, file_SourceTypeCode, file_LastAccessDate, file_CreateDate, file_LastWriteTime, modGlobals.gCurrUserGuidID, LastVerNbr, RetentionCode, isPublic, CrcHash, RSSProcessingDir);
                if (BB)
                {
                    LOG.WriteToTimerLog("END ArchiveRssFeed", "AddSourceToRepo" + file_FullName, "STOP", StartInsert);
                }
                else
                {
                    LOG.WriteToTimerLog("FAIL ArchiveRssFeed", "AddSourceToRepo" + file_FullName, "STOP", StartInsert);
                }

                if (BB)
                {
                    string VersionNbr = "0";
                    var UpdateInsert = DateAndTime.Now;
                    LOG.WriteToTimerLog("ArchiveRssFeed", "UpdateInsert:" + file_FullName, "STOP");
                    if (xDebug)
                        LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 1000 inserted new file " + file_FullName);
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
                    if (!file_SourceTypeCode.Equals(OriginalFileType))
                    {
                        InsertSrcAttrib(SourceGuid, "IndexAs", file_LastWriteTime, file_SourceTypeCode);
                    }

                    LOG.WriteToTimerLog("ArchiveRssFeed", "InsertRSSFeed" + file_FullName, "STOP", UpdateInsert);
                }
            }

            try
            {
                File.Delete(RssFQN);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Failed to delete 0A " + RssFQN);
            }
        }

        public void ArchiveRssFeedWebPage(string RssSourceGuid, string WebPageURL, string WebPageFQN, string RetentionCode, string isPublic)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string CrcHash = ENC.GenerateSHA512HashFromFile(WebPageFQN);
            string ImageHash = ENC.GenerateSHA512HashFromFile(WebPageFQN);
            string file_SourceName = WebPageFQN;
            string SourceGuid = Guid.NewGuid().ToString();
            string WEBProcessingDir = System.Configuration.ConfigurationManager.AppSettings["WEBProcessingDir"];
            if (!Directory.Exists(WEBProcessingDir))
            {
                Directory.CreateDirectory(WEBProcessingDir);
            }

            string ckMetaData = "N";
            int LastVerNbr = 0;
            var FI = new FileInfo(WebPageFQN);
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
                var StartInsert = DateAndTime.Now;
                LOG.WriteToTimerLog("Start ArchiveRssFeedWebPage", "InsertRSSFeed:" + file_FullName, "START");
                bool BB = AddSourceToRepo(modGlobals.gCurrUserGuidID, modGlobals.gMachineID, modGlobals.gNetworkID, SourceGuid, file_FullName, file_SourceName, file_SourceTypeCode, file_LastAccessDate, file_CreateDate, file_LastWriteTime, modGlobals.gCurrUserGuidID, LastVerNbr, RetentionCode, isPublic, CrcHash, WEBProcessingDir);
                if (BB)
                {
                    insertSourceChild(RssSourceGuid, SourceGuid);
                    LOG.WriteToTimerLog("END ArchiveRssFeedWebPage", "AddSourceToRepo" + file_FullName, "STOP", StartInsert);
                }
                else
                {
                    LOG.WriteToTimerLog("FAIL ArchiveRssFeedWebPage", "AddSourceToRepo" + file_FullName, "STOP", StartInsert);
                }

                if (BB)
                {
                    string VersionNbr = "0";
                    var UpdateInsert = DateAndTime.Now;
                    LOG.WriteToTimerLog("ArchiveRssFeedWebPage", "UpdateInsert:" + file_FullName, "STOP");
                    if (xDebug)
                        LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 1000 inserted new file " + file_FullName);
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
                    MessageBox.Show("Mark as a WEB page here." + WebPageURL);

                    // delFileParms(SourceGuid )
                    InsertSrcAttrib(SourceGuid, "FILENAME", file_SourceName, OriginalFileType);
                    InsertSrcAttrib(SourceGuid, "CreateDate", file_CreateDate, OriginalFileType);
                    InsertSrcAttrib(SourceGuid, "FILESIZE", file_Length, OriginalFileType);
                    InsertSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessDate, OriginalFileType);
                    InsertSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, OriginalFileType);
                    if (!file_SourceTypeCode.Equals(OriginalFileType))
                    {
                        InsertSrcAttrib(SourceGuid, "IndexAs", file_LastWriteTime, file_SourceTypeCode);
                    }

                    LOG.WriteToTimerLog("ArchiveRssFeedWebPage", "InsertRSSFeed" + file_FullName, "STOP", UpdateInsert);
                }
            }

            File.Delete(WebPageFQN);
        }

        public void ArchiveWebSites(string UserID)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var WEB = new clsWebPull();
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
            var listOfWebSites = new List<dsWebSite>();
            if (UserID.Equals("*"))
            {
                WhereClause = "";
            }
            else if (UserID.Length > 0)
            {
                WhereClause = " where UserID = '" + UserID + "'";
            }

            var ListOfUrls = new List<string>();
            ListOfUrls = GET_WebSiteData(modGlobals.gGateWayID, WhereClause, RC);
            var WebInfo = new frmNotify2();
            WebInfo.Show();
            WebInfo.Text = "RSS Archive";
            // ** We have all of the registered RSS feeds
            int K = 0;
            foreach (var xStr in ListOfUrls)
            {
                K += 1;
                var S = xStr.Split('|');
                // Dim strItems = WebSite + "|" + WebUrl + "|" + UserID + "|" + Depth + "|" + Width + "|" + RetentionCode + "|" + RowGuid
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
                spiderWeb(WebUrl, Conversions.ToInteger(Depth), Conversions.ToInteger(Width), Conversions.ToString(isPublic), RetentionCode);
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
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var WEB = new clsWebPull();
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
            var listOfWebSites = new List<dsWebSite>();
            if (UserID.Length > 0)
            {
                WhereClause = " where UserID = '" + UserID + "'";
            }

            var ListOfUrls = new List<string>();
            ListOfUrls = GET_WebPageData(modGlobals.gGateWayID, WhereClause, RC);
            var WebInfo = new frmNotify2();
            WebInfo.Show();
            WebInfo.Text = "WEB Page Archive";
            // ** We have all of the registered RSS feeds
            int K = 0;
            foreach (var xStr in ListOfUrls)
            {
                K += 1;
                var S = xStr.Split('|');
                // Dim strItems = WebSite + "|" + WebUrl + "|" + UserID + "|" + Depth + "|" + Width + "|" + RetentionCode + "|" + RowGuid
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
                spiderWeb(WebUrl, Conversions.ToInteger(Depth), Conversions.ToInteger(Width), Conversions.ToString(isPublic), RetentionCode);
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
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (!File.Exists(WebPageFQN))
            {
                MessageBox.Show("WEB Page could not be found: " + Constants.vbCrLf + WebPageFQN);
                return "";
            }

            string FileText = ReadFileIntoString(WebPageFQN);
            string CrcHash = ENC.getSha1HashKey(FileText);
            string file_SourceName = WebPageFQN;
            string SourceGuid = Guid.NewGuid().ToString();
            string WEBProcessingDir = System.Configuration.ConfigurationManager.AppSettings["WEBProcessingDir"];
            if (!Directory.Exists(WEBProcessingDir))
            {
                Directory.CreateDirectory(WEBProcessingDir);
            }

            string ckMetaData = "N";
            int LastVerNbr = 0;
            var FI = new FileInfo(WebPageFQN);
            string OriginalFileType = FI.Extension;
            string file_SourceTypeCode = FI.Extension;
            string file_FullName = FI.Name;
            string file_LastAccessDate = FI.LastAccessTime.ToString();
            string file_CreateDate = FI.CreationTime.ToString();
            // Dim file_LastWriteTime As String = FI.LastWriteTime.ToString
            string file_LastWriteTime = LastAccessTime.ToString();
            string file_Length = FI.Length.ToString();
            FI = null;
            GC.Collect();
            GC.WaitForPendingFinalizers();
            if (Conversions.ToInteger(file_Length) < 10)
            {
                Console.WriteLine("File " + file_FullName + " is only " + file_Length + " bytes long, skipping.");
                return "";
            }

            int iDatasourceCnt = getCountDataSourceFiles(file_FullName, CrcHash);
            // Dim iDatasourceCnt As Integer = getCountDataSourceFiles(file_SourceName, LastAccessTime)
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
                var StartInsert = DateAndTime.Now;
                LOG.WriteToTimerLog("Start ArchiveWebPage", "InsertWebPage:" + file_FullName, "START");
                bool BB = AddSourceToRepo(modGlobals.gCurrUserGuidID, modGlobals.gMachineID, modGlobals.gNetworkID, SourceGuid, file_SourceName, file_FullName, file_SourceTypeCode, file_LastAccessDate, file_CreateDate, file_LastWriteTime, modGlobals.gCurrUserGuidID, LastVerNbr, RetentionCode, isPublic, CrcHash, WEBProcessingDir);
                if (BB)
                {
                    if (ParentSourceGuid.Length > 0)
                    {
                        insertSourceChild(ParentSourceGuid, SourceGuid);
                    }

                    LOG.WriteToTimerLog("END ArchiveWebPage", "AddSourceToRepo" + file_FullName, "STOP", StartInsert);
                }
                else
                {
                    LOG.WriteToTimerLog("FAIL ArchiveWebPage", "AddSourceToRepo" + file_FullName, "STOP", StartInsert);
                }

                if (BB)
                {
                    string VersionNbr = "0";
                    var UpdateInsert = DateAndTime.Now;
                    LOG.WriteToTimerLog("ArchiveWebPage", "UpdateInsert:" + file_FullName, "STOP");
                    if (xDebug)
                        LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 1000 inserted new file " + file_FullName);
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
                    if (Conversions.ToInteger(file_Length) < 10)
                    {
                        Console.WriteLine("File " + file_FullName + " is only " + file_Length + " bytes long, skipping.");
                    }

                    UpdateDocDir(SourceGuid, file_FullName);
                    UpdateDocOriginalFileType(SourceGuid, OriginalFileType);
                    setRetentionDate(SourceGuid, RetentionCode, OriginalFileType);

                    // delFileParms(SourceGuid )
                    InsertSrcAttrib(SourceGuid, "FILENAME", file_SourceName, OriginalFileType);
                    InsertSrcAttrib(SourceGuid, "CreateDate", file_CreateDate, OriginalFileType);
                    InsertSrcAttrib(SourceGuid, "FILESIZE", file_Length, OriginalFileType);
                    InsertSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessDate, OriginalFileType);
                    InsertSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, OriginalFileType);
                    if (!file_SourceTypeCode.Equals(OriginalFileType))
                    {
                        InsertSrcAttrib(SourceGuid, "IndexAs", file_LastWriteTime, file_SourceTypeCode);
                    }

                    LOG.WriteToTimerLog("ArchiveWebPage", "InsertWebPage" + file_FullName, "STOP", UpdateInsert);
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
            catch (Exception ex)
            {
                Console.WriteLine("Failed to delete 0B " + WebPageFQN);
            }

            return SourceGuid;
        }

        public void ArchiveContent(string MachineID, bool InstantArchive, string UID, string FQN, string Author, string Description, string Keywords, bool isEmailAttachment, string EmailGuid = "")
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (xDebug)
                LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 100");
            string AttachmentCode = "";
            string CrcHash = ENC.GenerateSHA512HashFromFile(FQN);
            string ImageHash = ENC.GenerateSHA512HashFromFile(FQN);
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
            var DirFiles = new List<string>();
            var ActiveFolders = new string[1];
            if (InstantArchive == true)
            {
                DirFiles.Clear();
                ActiveFolders[0] = FolderName;
                DirFiles.Add(FQN);
                goto ProcessOneFileOnly;
            }

            FQN = UTIL.RemoveSingleQuotes(FQN);

            // Dim IncludedTypes As New ArrayList
            // Dim ExcludedTypes As New ArrayList

            var a = Strings.Split("0|0", "|");
            bool DeleteFile = false;
            ActiveFolders[0] = FolderName;
            string FileName = DMA.getFileName(FQN);
            int iCnt = QDIR.cnt_PKII2QD(FolderName, UID);
            if (xDebug)
                LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 200 iCnt = " + iCnt.ToString());
            if (iCnt == 0)
            {
                string argval = "N";
                QDIR.setCkdisabledir(ref argval);
                string argval1 = "N";
                QDIR.setCkmetadata(ref argval1);
                string argval2 = "N";
                QDIR.setCkpublic(ref argval2);
                string argval3 = "ECM.Library";
                QDIR.setDb_id(ref argval3);
                QDIR.setFqn(ref FolderName);
                string argval4 = "N";
                QDIR.setIncludesubdirs(ref argval4);
                QDIR.setUserid(ref UID);
                string argval5 = "Y";
                QDIR.setVersionfiles(ref argval5);
                string argval6 = "1";
                QDIR.setQuickrefentry(ref argval6);
                QDIR.Insert();
                if (xDebug)
                    LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 300 inserted qDir");
            }

            var StepTimer = DateAndTime.Now;
            LOG.WriteToTimerLog("ArchiveContent01", "GetQuickArchiveFileFolders", "START");
            GetQuickArchiveFileFolders(UID, ref ActiveFolders, FolderName);
            LOG.WriteToTimerLog("ArchiveContent01", "GetQuickArchiveFileFolders", "STOP", StepTimer);
            ProcessOneFileOnly:
            ;
            for (int i = 0, loopTo = Information.UBound(ActiveFolders); i <= loopTo; i++)
            {
                string FolderParmStr = ActiveFolders[i].ToString().Trim();
                var FolderParms = FolderParmStr.Split('|');
                string FOLDER_FQN = FolderParms[0];
                string FOLDER_IncludeSubDirs = FolderParms[1];
                string FOLDER_DBID = FolderParms[2];
                string FOLDER_VersionFiles = FolderParms[3];
                string DisableDir = FolderParms[4];
                string RetentionCode = FolderParms[5];
                if (xDebug)
                    LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 400: " + FOLDER_FQN);
                FOLDER_FQN = UTIL.RemoveSingleQuotes(FOLDER_FQN);
                if (!Directory.Exists(FOLDER_FQN))
                {
                    MessageBox.Show(FOLDER_FQN + " does not exist, returning.");
                    return;
                }

                if (DisableDir.Equals("Y"))
                {
                    goto NextFolder;
                }

                // GetIncludedFiletypes(FOLDER_FQN , IncludedTypes)
                // GetExcludedFiletypes(FOLDER_FQN , ExcludedTypes)

                IncludedTypes = GetAllIncludedFiletypes(FOLDER_FQN, FOLDER_IncludeSubDirs);
                ExcludedTypes = GetAllExcludedFiletypes(FOLDER_FQN, FOLDER_IncludeSubDirs);
                bool bChanged = false;
                var LibraryList = new List<string>();
                if ((FOLDER_FQN ?? "") != (pFolder ?? ""))
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
                        GetDirectoryLibraries(ParentDirForLib, ref LibraryList);
                    }
                    else
                    {
                        GetDirectoryLibraries(FOLDER_FQN, ref LibraryList);
                    }

                    if (xDebug)
                        LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 500: " + FolderName);
                    Application.DoEvents();
                    // ** Verify that the DIR still exists
                    if (Directory.Exists(FolderName))
                    {
                    }
                    else
                    {
                        return;
                    }

                    bool FoundDir = getDirectoryParms(ref a, FolderName, modGlobals.gCurrUserGuidID);
                    if (!FoundDir)
                    {
                        LOG.WriteToArchiveLog("clsArchiver : ArchiveContent : 00 : " + "ERROR: Folder'" + FolderName + "' was not registered, using default archive parameters.");
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
                    // ** Get all of the files in this folder

                    try
                    {
                        if (InstantArchive == true)
                        {
                        }
                        else
                        {
                            int ii = DMA.getFilesInDir(FOLDER_FQN, ref DirFiles, FileName);
                            if (ii == 0)
                            {
                                if (xDebug)
                                    LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 600 NO FILES IN FOLDER: " + FolderName);
                                goto NextFolder;
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        goto NextFolder;
                    }

                    // ** Process all of the files
                    for (int K = 0, loopTo1 = DirFiles.Count - 1; K <= loopTo1; K++)
                    {
                        StepTimer = DateAndTime.Now;
                        LOG.WriteToTimerLog("ArchiveContent01", "ProcessFile", "STOP");
                        // [SourceGuid] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
                        // [CreateDate] [datetime] NULL CONSTRAINT [CURRDATE_04012008185318003] DEFAULT
                        // (getdate()), [SourceName] [nvarchar](254) COLLATE SQL_Latin1_General_CP1_CI_AS
                        // NULL, [SourceImage] [image] NULL, [SourceTypeCode] [nvarchar](50) COLLATE
                        // SQL_Latin1_General_CP1_CI_AS NOT NULL, [FQN] [nvarchar](254) COLLATE
                        // SQL_Latin1_General_CP1_CI_AS NULL, [VersionNbr] [int] NULL CONSTRAINT
                        // [DF_DataSource_VersionNbr] DEFAULT ((0)), [LastAccessDate] [datetime] NULL,
                        // [FileLength] [int] NULL, [LastWriteTime] [datetime] NULL,

                        string SourceGuid = getGuid();
                        var FileAttributes = DirFiles[K].Split('|');
                        string file_FullName = FileAttributes[1];
                        if (xDebug)
                            LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 700 processing file: " + file_FullName);
                        string file_SourceName = FileAttributes[0];
                        if (xDebug)
                            LOG.WriteToArchiveLog("    File: " + file_SourceName);
                        string file_Length = FileAttributes[2];
                        if (modGlobals.gMaxSize > 0d)
                        {
                            if (Conversion.Val(file_Length) > modGlobals.gMaxSize)
                            {
                                LOG.WriteToArchiveLog("Notice: file '" + file_FullName + "' exceed the allowed file upload size, skipped.");
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
                        bool FileNeedsUpdating = false;
                        int iDatasourceCnt = getCountDataSourceFiles(file_SourceName, CrcHash);
                        int NbrDUps = ckFileExistInRepo(Environment.MachineName, file_FullName);
                        if (NbrDUps > 0)
                        {
                            string FHASH = ENC.GenerateSHA512HashFromFile(file_FullName);
                            // ** Update the HASH and the Source Binary
                            // * Get the file hash
                            UpdateDataSouceHashAndBinary(Environment.MachineName, file_FullName, FHASH);
                        }

                        if (iDatasourceCnt == 0)
                        {
                            saveContentOwner(SourceGuid, modGlobals.gCurrUserGuidID, "C", file_DirName, modGlobals.gMachineID, modGlobals.gNetworkID);
                        }

                        OcrText = "";
                        string isGraphic = "N";
                        if (iDatasourceCnt == 0)
                        {
                            // ********************************************************************************
                            // * The file DOES NOT exist in the reporsitory, add it now.
                            // ********************************************************************************
                            Application.DoEvents();
                            int LastVerNbr = 0;

                            // ********************************************************************************
                            var StartInsert = DateAndTime.Now;
                            LOG.WriteToTimerLog("Start ArchiveContent01", "AddSourceToRepo:" + file_FullName, "START");
                            bool BB = AddSourceToRepo(UID, MachineID, modGlobals.gNetworkID, SourceGuid, file_FullName, file_SourceName, file_SourceTypeCode, file_LastAccessDate, file_CreateDate, file_LastWriteTime, modGlobals.gCurrUserGuidID, LastVerNbr, RetentionCode, isPublic, CrcHash, file_DirName);
                            string fExt = DMA.getFileExtension(file_FullName);
                            if (FQN.ToUpper().Equals("ZIP"))
                            {
                                DBLocal.addZipFile(file_FullName, Conversions.ToString(false), Conversions.ToBoolean(SourceGuid));
                                int StackLevel = 0;
                                var ListOfFiles = new Dictionary<string, int>();
                                ZF.UploadZipFile(modGlobals.gCurrUserGuidID, modGlobals.gMachineID, file_FullName, SourceGuid, true, false, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
                                ListOfFiles = null;
                                GC.Collect();
                            }

                            if (BB)
                            {
                                LOG.WriteToTimerLog("END ArchiveContent01", "AddSourceToRepo" + file_FullName, "STOP", StartInsert);
                            }
                            else
                            {
                                LOG.WriteToTimerLog("FAIL ArchiveContent01", "AddSourceToRepo" + file_FullName, "STOP", StartInsert);
                            }

                            // ********************************************************************************

                            if (BB)
                            {
                                string VersionNbr = "0";
                                var UpdateInsert = DateAndTime.Now;
                                LOG.WriteToTimerLog("ArchiveContent01", "UpdateInsert:" + file_FullName, "STOP");
                                if (xDebug)
                                    LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 1000 inserted new file " + file_FullName);
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

                                // delFileParms(SourceGuid )
                                InsertSrcAttrib(SourceGuid, "FILENAME", file_SourceName, OriginalFileType);
                                InsertSrcAttrib(SourceGuid, "CreateDate", file_CreateDate, OriginalFileType);
                                InsertSrcAttrib(SourceGuid, "FILESIZE", file_Length, OriginalFileType);
                                InsertSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessDate, OriginalFileType);
                                InsertSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, OriginalFileType);
                                if (!file_SourceTypeCode.Equals(OriginalFileType))
                                {
                                    InsertSrcAttrib(SourceGuid, "IndexAs", file_LastWriteTime, file_SourceTypeCode);
                                }

                                if ((file_SourceTypeCode.Equals(".doc") | file_SourceTypeCode.Equals(".docx")) & ckMetaData.Equals("Y"))
                                {
                                    if (modGlobals.gOfficeInstalled == true)
                                    {
                                        // EXTRACT WORD IMAGES HERE WDMXX
                                        GetWordDocMetadata(file_FullName, SourceGuid, OriginalFileType);
                                    }
                                    else
                                    {
                                        LOG.WriteToArchiveLog("WARNING 101xa: Metadata requested but office not installed.");
                                    }
                                }

                                if ((file_SourceTypeCode.Equals(".xls") | file_SourceTypeCode.Equals(".xlsx") | file_SourceTypeCode.Equals(".xlsm")) & ckMetaData.Equals("Y"))
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

                                LOG.WriteToTimerLog("ArchiveContent01", "UpdateInsert" + file_FullName, "STOP", UpdateInsert);
                            }
                            // Else
                            // '*****************************************
                            // '* The File Already exists in the Repository
                            // '* Just add the user to the ContentUser table
                            // '*****************************************
                            // Dim UpdateSource As Date = Now
                            // LOG.WriteToTimerLog("ArchiveContent01A", "UpdateSource" + file_FullName, "START")
                            // If UCase(FOLDER_VersionFiles ).Equals("Y") Then
                            // If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 1001 files versioned" + file_FullName )
                            // '** Get the last version number of this file in the repository,
                            // Dim LastVerNbr As Integer = GetMaxDataSourceVersionNbr(UID, file_FullName )
                            // Dim NextVersionNbr As Integer = LastVerNbr + 1
                            // '** See if this version has been changed
                            // bChanged = isSourcefileOlderThanLastEntry(file_SourceName, CrcHash)
                            // '** If it has, add it to the repository
                            // If bChanged Then

                            // Dim fExt As String = DMA.getFileExtension(file_FullName) If
                            // FQN.ToUpper.Equals("ZIP") Then DBLocal.addZipFile(file_FullName, False,
                            // SourceGuid) Dim StackLevel As Integer = 0 Dim ListOfFiles As New
                            // Dictionary(Of String, Integer) ZF.UploadZipFile(gCurrUserGuidID,
                            // gMachineID, file_FullName, SourceGuid, True, False, RetentionCode,
                            // isPublic, StackLevel, ListOfFiles) ListOfFiles = Nothing GC.Collect() End If

                            // '********************************************************************************************************
                            // Dim StartInsert As Date = Now LOG.WriteToTimerLog("Start ArchiveContent01",
                            // "UpdtInsertSourcefile:" + file_FullName, "START") Dim BB As Boolean =
                            // AddSourceToRepo(UID, MachineID, gNetworkID, SourceGuid, _ file_FullName, _
                            // file_SourceName, _ file_SourceTypeCode, _ file_LastAccessDate , _
                            // file_CreateDate , _ file_LastWriteTime , gCurrUserGuidID, NextVersionNbr,
                            // RetentionCode, isPublic, CrcHash, file_DirName )

                            // If BB Then LOG.WriteToTimerLog("END ArchiveContent01B",
                            // "UpdtInsertSourcefile" + file_FullName, "STOP", StartInsert) Else
                            // LOG.WriteToTimerLog("FAIL ArchiveContent01B", "UpdtInsertSourcefile" +
                            // file_FullName, "STOP", StartInsert) End If '********************************************************************************************************

                            // If BB Then If LibraryList.Count > 0 Then For II As Integer = 0 To
                            // LibraryList.Count - 1 Dim LibraryName = LibraryList(II)
                            // AddLibraryItem(SourceGuid, file_SourceName, file_SourceTypeCode,
                            // LibraryName ) Next End If If xDebug Then
                            // LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 1002 file ADDED" +
                            // file_FullName ) Else If xDebug Then
                            // LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 1003 file FAILED TO ADD"
                            // + file_FullName ) End If

                            // 'Dim VersionNbr As String = "0" Dim CRC As String =
                            // DMA.CalcCRC(file_FullName) addContentHashKey(SourceGuid, NextVersionNbr,
                            // file_CreateDate , file_FullName, OriginalFileType, file_Length , CRC, MachineID)

                            // UpdateDocFqn(SourceGuid, file_FullName) UpdateDocSize(SourceGuid,
                            // file_Length ) UpdateDocDir(SourceGuid, file_FullName)
                            // UpdateDocOriginalFileType(SourceGuid, OriginalFileType )
                            // setRetentionDate(SourceGuid , RetentionCode , OriginalFileType )

                            // Dim SS = "" SS = "update dataSource set KeyWords = '" + Keywords + "' where
                            // SourceGuid = '" + SourceGuid + "' " BB = ExecuteSqlNewConn(SS, False) SS =
                            // "update dataSource set Description = '" + Description + "' where SourceGuid
                            // = '" + SourceGuid + "' " BB = ExecuteSqlNewConn(SS, False)

                            // If OcrText .Trim.Length > 0 Then AppendOcrText(SourceGuid , OcrText ) End If

                            // Dim UserGuid = gCurrUserGuidID SS = "update QuickRefItems set SourceGuid =
                            // '" + SourceGuid + "' where DataSourceOwnerUserID = '" + UserGuid + "' and
                            // FQN = '" + FQN + "' " BB = ExecuteSqlNewConn(SS, False)

                            // 'delFileParms(SourceGuid ) InsertSrcAttrib(SourceGuid , "FILENAME",
                            // file_SourceName, OriginalFileType ) InsertSrcAttrib(SourceGuid ,
                            // "CreateDate", file_CreateDate , OriginalFileType )
                            // InsertSrcAttrib(SourceGuid , "FILESIZE", file_Length , OriginalFileType )
                            // InsertSrcAttrib(SourceGuid , "ChangeDate", file_LastAccessDate,
                            // OriginalFileType ) InsertSrcAttrib(SourceGuid , "WriteDate",
                            // file_LastWriteTime , OriginalFileType ) InsertSrcAttrib(SourceGuid , "MD
                            // Author", Author, OriginalFileType ) If Not file_SourceTypeCode
                            // .Equals(OriginalFileType ) Then InsertSrcAttrib(SourceGuid , "IndexAs",
                            // file_LastWriteTime , file_SourceTypeCode) End If If
                            // (LCase(file_SourceTypeCode).Equals(".doc") Or
                            // LCase(file_SourceTypeCode).Equals(".docx")) And ckMetaData .Equals("Y")
                            // Then GetWordDocMetadata(file_FullName, SourceGuid , OriginalFileType ) End
                            // If If (file_SourceTypeCode.Equals(".xls") _ Or
                            // file_SourceTypeCode.Equals(".xlsx") Or file_SourceTypeCode.Equals(".xlsm"))
                            // And ckMetaData .Equals("Y") Then Me.GetExcelMetaData(file_FullName,
                            // SourceGuid , OriginalFileType ) End If

                            // End If LOG.WriteToTimerLog("ArchiveContent01", "UpdateSource:1" +
                            // file_FullName, "end", UpdateSource) Else If xDebug Then
                            // LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 1004 The document has
                            // changed, but versioning is not on" + file_FullName ) '** The document has
                            // changed, but versioning is not on... '** Delete and re-add. '** If zero add
                            // '** if 1, see if changed and if so, update, if not skip it Dim LastVerNbr
                            // As Integer = GetMaxDataSourceVersionNbr(UID, _ file_FullName ) bChanged =
                            // isSourcefileOlderThanLastEntry(file_SourceName, CrcHash) '** If it has, add
                            // it to the repository If bChanged Then If xDebug Then
                            // LOG.WriteToArchiveLog("clsArchiver:ArchiveContent 1005 The document has
                            // changed: " + file_FullName ) Dim BB As Boolean = False 'Dim BB As Boolean =
                            // DeleteDocumentByName(UID, file_SourceName, SourceGuid) Dim
                            // UpdateSourceImageDte As Date = Now

                            // LOG.WriteToTimerLog("ArchiveContent01", "UpdateSourceFileImage:1" +
                            // file_FullName, "start")

                            // Dim CurrentVersionNbr As Integer = 0

                            // '********************************************************************************************************
                            // Dim StartInsert As Date = Now LOG.WriteToTimerLog("Start ArchiveContent01",
                            // "UpdtInsertSourcefile:" + file_FullName, "START") BB =
                            // UpdateSourceFileImage(FileName, UID, MachineID, SourceGuid,
                            // file_LastAccessDate, file_CreateDate, file_LastWriteTime,
                            // CurrentVersionNbr, FQN, RetenCode, isPublic, CrcHash) If BB Then
                            // LOG.WriteToTimerLog("END ArchiveContent01C", "UpdtInsertSourcefile" +
                            // file_FullName, "STOP", StartInsert) Else LOG.WriteToTimerLog("FAIL
                            // ArchiveContent01C", "UpdtInsertSourcefile" + file_FullName, "STOP",
                            // StartInsert) End If '********************************************************************************************************

                            // If Not BB Then Dim MySql = "Delete from DataSource where SourceGuid = '" +
                            // SourceGuid + "'" ExecuteSqlNewConn(MySql)
                            // LOG.WriteToArchiveLog("Unrecoverable Error - removed file '" +
                            // file_FullName + "' from the repository.") End If

                            // If LibraryList.Count > 0 Then For II As Integer = 0 To LibraryList.Count -
                            // 1 Dim LibraryName = LibraryList(II) AddLibraryItem(SourceGuid,
                            // file_SourceName, file_SourceTypeCode, LibraryName ) Next End If

                            // Dim DateX01 As Date = Now LOG.WriteToTimerLog("ArchiveContent01",
                            // "UpdateDocFqn" + file_FullName, "start")

                            // UpdateDocFqn(SourceGuid, file_FullName) UpdateDocSize(SourceGuid,
                            // file_Length ) UpdateDocOriginalFileType(SourceGuid, OriginalFileType )
                            // UpdateDocDir(SourceGuid, file_FullName) setRetentionDate(SourceGuid ,
                            // RetentionCode , OriginalFileType )

                            // LOG.WriteToTimerLog("ArchiveContent01", "UpdateDocFqn-1" + file_FullName,
                            // "end", DateX01)

                            // Dim SS = "" SS = "update dataSource set KeyWords = '" + Keywords + "' where
                            // SourceGuid = '" + SourceGuid + "' " BB = ExecuteSqlNewConn(SS, False) SS =
                            // "update dataSource set Description = '" + Description + "' where SourceGuid
                            // = '" + SourceGuid + "' " BB = ExecuteSqlNewConn(SS, False) If OcrText
                            // .Trim.Length > 0 Then AppendOcrText(SourceGuid , OcrText ) End If Dim
                            // UserGuid = gCurrUserGuidID SS = "update QuickRefItems set SourceGuid = '" +
                            // SourceGuid + "' where DataSourceOwnerUserID = '" + UserGuid + "' and FQN =
                            // '" + FQN + "' " BB = ExecuteSqlNewConn(SS, False)

                            // 'delFileParms(SourceGuid ) InsertSrcAttrib(SourceGuid , "FILENAME",
                            // file_SourceName, OriginalFileType ) InsertSrcAttrib(SourceGuid ,
                            // "CreateDate", file_CreateDate , OriginalFileType )
                            // InsertSrcAttrib(SourceGuid , "FILESIZE", file_Length , OriginalFileType )
                            // InsertSrcAttrib(SourceGuid , "ChangeDate", file_LastAccessDate,
                            // OriginalFileType ) InsertSrcAttrib(SourceGuid , "WriteDate",
                            // file_LastWriteTime , OriginalFileType ) InsertSrcAttrib(SourceGuid , "MD
                            // Author", Author, OriginalFileType ) If Not file_SourceTypeCode
                            // .Equals(OriginalFileType ) Then InsertSrcAttrib(SourceGuid , "IndexAs",
                            // file_LastWriteTime , file_SourceTypeCode) End If If
                            // (LCase(file_SourceTypeCode).Equals(".doc") Or
                            // LCase(file_SourceTypeCode).Equals(".docx")) And ckMetaData .Equals("Y")
                            // Then GetWordDocMetadata(file_FullName, SourceGuid , OriginalFileType ) End
                            // If If (file_SourceTypeCode.Equals(".xls") _ Or
                            // file_SourceTypeCode.Equals(".xlsx") Or file_SourceTypeCode.Equals(".xlsm"))
                            // And ckMetaData .Equals("Y") Then Me.GetExcelMetaData(file_FullName,
                            // SourceGuid , OriginalFileType ) End If If xDebug Then
                            // LOG.WriteToArchiveLog("10000 Processed " + file_FullName)
                            // LOG.WriteToTimerLog("ArchiveContent01", "UpdateDocFqn-2" + file_FullName,
                            // "end", DateX01) Else If xDebug Then LOG.WriteToArchiveLog("Document " +
                            // file_FullName + " has not changed, SKIPPING.") If xDebug Then
                            // LOG.WriteToArchiveLog("Document " + file_FullName + " has not changed,
                            // SKIPPING.") End If End If LOG.WriteToTimerLog("ArchiveContent01",
                            // "UpdateSource" + file_FullName, "STOP", UpdateSource)
                        }

                        NextFile:
                        ;

                        // Me.SB.Text = "Processing document #" + K.ToString
                        Application.DoEvents();
                        LOG.WriteToTimerLog("ArchiveContent01", "ProcessFile", "STOP", StepTimer);
                    }
                }
                else if (xDebug)
                    LOG.WriteToArchiveLog("Duplicate Folder: " + FolderName);
                NextFolder:
                ;
                pFolder = FolderName;
            }
        }

        public new void InsertSrcAttrib(string SGUID, string aName, string aVal, string SourceType)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            SRCATTR.setSourceguid(ref SGUID);
            SRCATTR.setAttributename(ref aName);
            SRCATTR.setAttributevalue(ref aVal);
            SRCATTR.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
            SRCATTR.setSourcetypecode(ref SourceType);
            SRCATTR.Insert();
        }

        public void GetWordDocMetadata(string FQN, string SourceGUID, string OriginalFileType)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string TempDir = Path.GetTempPath();
            string fName = DMA.getFileName(FQN);
            string NewFqn = TempDir + fName;
            File.Copy(FQN, NewFqn, true);
            var WDOC = new clsMsWord();
            WDOC.initWordDocMetaData(NewFqn, SourceGUID, OriginalFileType);

            // ** THIS MAY NEED TO BE REMOVED
            File.Delete(NewFqn);
        }

        public void GetExcelMetaData(string FQN, string SourceGUID, string OriginalFileType)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string TempDir = Path.GetTempPath();
            string fName = DMA.getFileName(FQN);
            string NewFqn = TempDir + fName;
            File.Copy(FQN, NewFqn, true);
            var WDOC = new clsMsWord();
            WDOC.initExcelMetaData(NewFqn, SourceGUID, OriginalFileType);
            ISO.saveIsoFile(" FilesToDelete.dat", NewFqn + "|");
            // File.Delete(NewFqn )

        }

        public void setDataSourceRestoreHistoryParms()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string s = "";
            bool B = false;
            s = s + " update DataSourceRestoreHistory  ";
            s = s + " set  DocumentName = (select SourceName from DataSource ";
            s = s + " where DataSource.SourceGuid = DataSourceRestoreHistory.SourceGuid) ";
            s = s + " where VerifiedData = 'N' ";
            s = s + " and TypeContentCode <> '.msg' ";
            s = s + " and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + modGlobals.gCurrUserGuidID + "'";
            B = ExecuteSqlNewConn(s, false);
            s = " update DataSourceRestoreHistory  ";
            s = s + " set  FQN = (select FQN from DataSource ";
            s = s + " where DataSource.SourceGuid = DataSourceRestoreHistory.SourceGuid) ";
            s = s + " where VerifiedData = 'N' ";
            s = s + " and TypeContentCode <> '.msg' ";
            s = s + " and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + modGlobals.gCurrUserGuidID + "'";
            B = ExecuteSqlNewConn(s, false);
            s = " update DataSourceRestoreHistory ";
            s = s + " set  DocumentName = (select ShortSubj from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)";
            s = s + " where VerifiedData = 'N' and TypeContentCode = '.msg' and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + modGlobals.gCurrUserGuidID + "'";
            B = ExecuteSqlNewConn(s, false);
            s = "update DataSourceRestoreHistory ";
            s = s + " set  FQN = (select 'EMAIL' from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)";
            s = s + " where VerifiedData = 'N' and TypeContentCode = '.msg'  and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + modGlobals.gCurrUserGuidID + "'";
            B = ExecuteSqlNewConn(s, false);
            s = "update DataSourceRestoreHistory ";
            s = s + " set  FQN = (select 'EMAIL' from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)";
            s = s + " where VerifiedData = 'N' and TypeContentCode = '.eml'  and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + modGlobals.gCurrUserGuidID + "'";
            B = ExecuteSqlNewConn(s, false);
            s = " update DataSourceRestoreHistory ";
            s = s + " set  VerifiedData = (select 'Y' from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)";
            s = s + " where VerifiedData = 'N'  and TypeContentCode = '.msg' and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + modGlobals.gCurrUserGuidID + "'";
            B = ExecuteSqlNewConn(s, false);
            s = " update DataSourceRestoreHistory ";
            s = s + " set  VerifiedData = (select 'Y' from Email where Email.EmailGuid = DataSourceRestoreHistory.SourceGuid)";
            s = s + " where VerifiedData = 'N'  and TypeContentCode = '.eml' and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + modGlobals.gCurrUserGuidID + "'";
            B = ExecuteSqlNewConn(s, false);
            s = " Update DataSourceRestoreHistory ";
            s = s + " set  VerifiedData = (select 'Y' from DataSource where DataSource.SourceGuid = DataSourceRestoreHistory.SourceGuid)";
            s = s + " where VerifiedData = 'N'  and TypeContentCode <> '.msg' and DataSourceRestoreHistory.DataSourceOwnerUserID = '" + modGlobals.gCurrUserGuidID + "'";
            B = ExecuteSqlNewConn(s, false);
        }

        public void ArchiveQuickRefItems(string UID, string MachineID, bool SkipIfArchiveBitIsOn, bool rbPublic, bool rbPrivate, bool rbMstrYes, bool rbMstrNot, TextBox SB, string MetadataTag, string MetadataValue, string LibraryName, ref ArrayList ZipFilesQuick)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            try
            {
                if (xDebug)
                    LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 100");
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
                S = S + " where [DataSourceOwnerUserID] = '" + UserGuid + "' ";
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
                    LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 200");
                SqlDataReader rsQuickArch = null;
                rsQuickArch = SqlQryNewConn(S);
                if (xDebug)
                    LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 300");
                if (rsQuickArch is null)
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
                            LOG.WriteToUploadLog("ArchiveQuickRefItems: File: " + FQN);
                            if (xDebug)
                                LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 400" + FQN);
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

                            // FrmMDIMain.SB.Text = DirName

                            FQN = UTIL.RemoveSingleQuotes(FQN);
                            if (File.Exists(FQN))
                            {
                                if (xDebug)
                                    LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 500 File exists");
                                bool bArch = DMA.isArchiveBitOn(FQN);
                                // If SkipIfArchiveBitIsOn = False Then
                                // If xDebug Then LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 600 archive bit on, processing anyway")
                                // bArch = True
                                // End If
                                if (bArch == false)
                                {
                                    ArchiveContent(MachineID, false, DataSourceOwnerUserID, FQN, Author, Description, Keywords, false);
                                    sourceguid = getSourceGuidByFqn(FQN, UserGuid);
                                    S = "Update [QuickRefItems] set [SourceGuid] = '" + sourceguid + "' where QuickRefItemGuid = '" + QuickRefItemGuid + "' ";
                                    TgtGuid = sourceguid;
                                    modGlobals.gTgtGuid = sourceguid;
                                    bool BB = ExecuteSqlNewConn(S, true);
                                    modGlobals.gTgtGuid = "";
                                    if (!BB)
                                    {
                                        LOG.WriteToArchiveLog("Notice update skipped on Quick Reference : '" + S + "'.");
                                    }
                                    else
                                    {
                                        UpdateDataSourceDesc(QuickRefItemGuid, sourceguid);
                                        UpdateDataSourceKeyWords(QuickRefItemGuid, sourceguid);
                                        // MetadataTag , MetadataValue , Library
                                        if (MetadataTag.Trim().Length > 0)
                                        {
                                            UpdateDataSourceMetadata(tMetadataTag, tMetadataValue, sourceguid);
                                        }

                                        if (LibraryName.Trim().Length > 0)
                                        {
                                            UpdateDataSourceLibrary(tLibraryName, sourceguid);
                                        }

                                        SetSourceGlobalAccessFlags(sourceguid, "SRC", rbPublic, rbPrivate, rbMstrYes, rbMstrNot, ref SB);
                                    }
                                    // DMA.ToggleArchiveBit(FQN )
                                    DMA.setArchiveBitOff(FQN);
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 800 processed: " + FQN);
                                    // log.WriteToArchiveLog("Notice 5543.21.2b : clsArchiver:ArchiveQuickRefItems 800 processed: " + FQN )
                                }
                            }
                            else
                            {
                                // xTrace(102375, "File " + FQN + " does not exist on this machine.", "clsArchiver:ArchiveQuickRefItems")
                                // ** DO NOTHING - The file has been removed from the machine.
                            }
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine("Error: " + ex.Message);
                        }

                        Application.DoEvents();
                        if (xDebug)
                            LOG.WriteToArchiveLog("clsArchiver:ArchiveQuickRefItems 900 Next file.");
                        if (xDebug)
                            LOG.WriteToArchiveLog("--------------------------------------------------------------");
                    }
                }
            }
            // FrmMDIMain.SB.Text = "Done..."
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR 5543.21.2a : ArchiveQuickRefItems - " + ex.Message);
                // FrmMDIMain.SB.Text = "Failed to capture Quick Archive Items, please check the log file."
            }
        }

        public void UpdateDataSourceDesc(string QuickRefItemGuid, string SourceGuid)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string S = "update DataSource set description = ";
            S = S + " (select Description from [QuickRefItems] where [QuickRefItemGuid] = '" + QuickRefItemGuid + "')";
            S = S + " where SourceGuid = '" + SourceGuid + "'";
            TgtGuid = SourceGuid;
            bool B = ExecuteSqlNewConn(S, true);
        }

        public void UpdateDataSourceKeyWords(string QuickRefItemGuid, string SourceGuid)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string S = "update DataSource set KeyWords = ";
            S = S + " (select KeyWords from [QuickRefItems] where [QuickRefItemGuid] = '" + QuickRefItemGuid + "')";
            S = S + " where SourceGuid = '" + SourceGuid + "'";
            TgtGuid = SourceGuid;
            bool B = ExecuteSqlNewConn(S, true);
        }

        public void UpdateDataSourceMetadata(string Attribute, string Attributevalue, string SourceGuid)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var SRCATTR = new clsSOURCEATTRIBUTE();
            string WC = "";
            int iCnt = 0;
            bool B = false;
            string Itemtitle = getFqnFromGuid(SourceGuid);
            string Itemtype = UTIL.getFileSuffix(Itemtitle);
            string Datasourceowneruserid = getOwnerGuid(SourceGuid);
            Itemtype = "." + Itemtype;
            iCnt = SRCATTR.cnt_PK35(Attribute, modGlobals.gCurrUserGuidID, SourceGuid);
            if (iCnt == 0)
            {
                SRCATTR.setAttributename(ref Attribute);
                SRCATTR.setAttributevalue(ref Attributevalue);
                SRCATTR.setSourceguid(ref SourceGuid);
                SRCATTR.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
                SRCATTR.setSourcetypecode(ref Itemtype);
                B = SRCATTR.Insert();
                if (!B)
                {
                    LOG.WriteToArchiveLog("clsArchiver:UpdateDataSourceMetadata - Failed to add metadata '" + Attribute + ":" + Attributevalue + " to '" + SourceGuid + "'.");
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
                if (!B)
                {
                    LOG.WriteToArchiveLog("clsArchiver:UpdateDataSourceMetadata - Failed to UPDATE metadata '" + Attribute + ":" + Attributevalue + " to '" + SourceGuid + "'.");
                }
            }

            SRCATTR = null;
        }

        public void UpdateDataSourceLibrary(string LibraryName, string SourceGuid)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var LI = new clsLIBRARYITEMS();
            string Libraryowneruserid = GetLibOwnerByName(LibraryName);
            string Itemtitle = getFqnFromGuid(SourceGuid);
            string Itemtype = UTIL.getFileSuffix(Itemtitle);
            string Datasourceowneruserid = getOwnerGuid(SourceGuid);
            string NewGuid = Guid.NewGuid().ToString();
            Itemtype = "." + Itemtype;
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
                if (!B)
                {
                    LOG.WriteToArchiveLog("clsArchiver:UpdateDataSourceMetadata - Failed to add Library Items '" + LibraryName + ".");
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
                if (!B)
                {
                    LOG.WriteToArchiveLog("clsArchiver:UpdateDataSourceMetadata - Failed to UPDATE Library Items '" + LibraryName + "'.");
                }
            }

            LI = null;
        }

        public void ckSourceTypeCode(ref string file_SourceTypeCode)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            int bcnt = iGetRowCount("SourceType", "where SourceTypeCode = '" + file_SourceTypeCode + "'");
            string SubstituteFileType = getProcessFileAsExt(file_SourceTypeCode);
            if (bcnt == 0 & string.IsNullOrEmpty(SubstituteFileType))
            {
                if (SubstituteFileType == null)
                {
                    string MSG = "The file type '" + file_SourceTypeCode + "' is undefined." + Constants.vbCrLf + "DO YOU WISH TO AUTOMATICALLY DEFINE IT?" + Constants.vbCrLf + "This will allow content to be archived, but not searched.";
                    // Dim dlgRes As DialogResult = MessageBox.Show(MSG, "Filetype Undefined", MessageBoxButtons.YesNo)

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
                    string argval1 = "NO SEARCH - AUTO ADDED by Pgm";
                    ST.setSourcetypedesc(ref argval1);
                    string argval2 = "0";
                    ST.setIndexable(ref argval2);
                    string argval3 = 0.ToString();
                    ST.setStoreexternal(ref argval3);
                    bool B = ST.Insert();
                    if (!B)
                    {
                        LOG.WriteToArchiveLog("clsArchiver : ckSourceTypeCode : 01");
                        LOG.WriteToArchiveLog("clsArchiver : ckSourceTypeCode : 02 : " + "ERROR: An unknown file '" + file_SourceTypeCode + "' type was NOT inserted.");
                    }
                }
                else
                {
                    file_SourceTypeCode = SubstituteFileType;
                }
            }
            else if (SubstituteFileType.Trim().Length > 0)
            {
                file_SourceTypeCode = SubstituteFileType;
            }
        }

        // ** WDM 7/6/2009
        // ** This function is not used at this time.
        public void ArchiveAllFolderContent(string UID, string MachineID, string FolderName, bool ckSkipIfArchBitTrue, string VersionFiles, string EmailGuid, string RetentionCode, string isPublic)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            int LastVerNbr = 0;
            int NextVersionNbr = 0;
            string CRC = "";
            string ImageHash = "";
            string OcrDirectory = "Y";
            string IncludeSubDirs = "N";
            string ckMetaData = "Y";
            bool bAddThisFileAsNewVersion = false;
            if (EmailGuid.Trim().Length > 0)
            {
                VersionFiles = "Y";
            }

            // ** Designed to archive ALL files of ALL type contained within the passed in folder.
            if (xDebug)
                LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8000 : trace log.");
            var rightNow = DateAndTime.Now;
            int RetentionYears = (int)Conversion.Val(getSystemParm("RETENTION YEARS"));
            rightNow = rightNow.AddYears(RetentionYears);
            string RetentionExpirationDate = rightNow.ToString();
            var ExpiryTime = rightNow;
            ZipFiles.Clear();
            var a = new string[1];
            var ActiveFolders = new string[1];
            bool DeleteFile = false;

            // GetContentArchiveFileFolders(gCurrUserGuidID, ActiveFolders)

            ActiveFolders[0] = FolderName;
            string cFolder = "";
            string pFolder = "XXX";
            var DirFiles = new List<string>();
            if (xDebug)
                LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8001 : trace log.");
            FilesBackedUp = 0;
            FilesSkipped = 0;
            var LibraryList = new List<string>();
            for (int i = 0, loopTo = Information.UBound(ActiveFolders); i <= loopTo; i++)
            {
                string FolderParmStr = ActiveFolders[i].ToString().Trim();
                // Dim FolderParms() As String = FolderParmStr.Split("|")

                string FOLDER_FQN = FolderName;
                if (xDebug)
                    LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8002 :FOLDER_FQN : " + FOLDER_FQN);
                if (Strings.InStr(FOLDER_FQN, modGlobals.gTempDir + "", CompareMethod.Text) > 0)
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
                    // FrmMDIMain.SB.Text = "Processing Dir: " + FOLDER_FQN
                    if (xDebug)
                        LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8003 :FOLDER Exists: " + FOLDER_FQN);
                    if (xDebug)
                        LOG.WriteToArchiveLog("Archive Folder: " + FOLDER_FQN);
                }
                else
                {
                    // FrmMDIMain.SB.Text = FOLDER_FQN  + " does not exist, skipping."
                    if (xDebug)
                        LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8004 :FOLDER DOES NOT Exist: " + FOLDER_FQN);
                    if (xDebug)
                        LOG.WriteToArchiveLog("Archive Folder FOUND MISSING: " + FOLDER_FQN);
                    goto NextFolder;
                }

                if (DisableDir.Equals("Y"))
                {
                    goto NextFolder;
                }

                // GetIncludedFiletypes(FOLDER_FQN , IncludedTypes)
                // GetExcludedFiletypes(FOLDER_FQN , ExcludedTypes)
                if (xDebug)
                    LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8005 : Trace: " + FOLDER_FQN);
                bool bChanged = false;
                if ((FOLDER_FQN ?? "") != (pFolder ?? ""))
                {
                    string ParentDirForLib = "";
                    bool bLikToLib = false;
                    bLikToLib = isDirInLibrary(FOLDER_FQN, ref ParentDirForLib);
                    int iCount = Directory.GetFiles(FOLDER_FQN).Count();
                    if (iCount == 0)
                    {
                        goto NextFolder;
                    }

                    if (xDebug)
                        LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8006 : Folder Changed: " + FOLDER_FQN + ", " + pFolder);
                    FolderName = FOLDER_FQN;
                    Application.DoEvents();
                    // ** Verify that the DIR still exists
                    if (Directory.Exists(FolderName))
                    {
                    }
                    // FrmMDIMain.SB.Text = "Processing Dir: " + FolderName
                    else
                    {
                        // FrmMDIMain.SB.Text = FolderName + " does not exist, skipping."
                        LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8007 : Folder DOES NOT EXIT: " + FOLDER_FQN);
                        goto NextFolder;
                    }

                    if (bLikToLib)
                    {
                        GetDirectoryLibraries(ParentDirForLib, ref LibraryList);
                    }
                    else
                    {
                        GetDirectoryLibraries(FOLDER_FQN, ref LibraryList);
                    }

                    // 'getDirectoryParms(a , FolderName, gCurrUserGuidID)
                    // 'Dim IncludeSubDirs  = a(0)
                    /// Dim VersionFiles  = a(1)
                    // 'Dim ckMetaData  = a(2)
                    // 'OcrDirectory  = a(3)

                    // ** Get all of the files in this folder
                    try
                    {
                        DirFiles.Clear();
                        int ii = DMA.getFilesInDir(FOLDER_FQN, ref DirFiles, IncludedTypes, ExcludedTypes, ckSkipIfArchBitTrue);
                        if (ii == 0)
                        {
                            if (xDebug)
                                LOG.WriteToArchiveLog("Archive Folder HAD NO FILES: " + FOLDER_FQN);
                            goto NextFolder;
                        }

                        ckFilesNeedUpdate(ref DirFiles, ckSkipIfArchBitTrue);
                    }
                    catch (Exception ex)
                    {
                        goto NextFolder;
                    }

                    // ** Process all of the files
                    for (int K = 0, loopTo1 = DirFiles.Count - 1; K <= loopTo1; K++)
                    {
                        string sDir = DirFiles[K];
                        sDir = DMA.getFileName(sDir);
                        My.MyProject.Forms.frmNotify.lblFileSpec.Text = "Processing: " + sDir;
                        My.MyProject.Forms.frmNotify.Refresh();

                        // [SourceGuid] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
                        // [CreateDate] [datetime] NULL CONSTRAINT [CURRDATE_04012008185318003] DEFAULT
                        // (getdate()), [SourceName] [nvarchar](254) COLLATE SQL_Latin1_General_CP1_CI_AS
                        // NULL, [SourceImage] [image] NULL, [SourceTypeCode] [nvarchar](50) COLLATE
                        // SQL_Latin1_General_CP1_CI_AS NOT NULL, [FQN] [nvarchar](254) COLLATE
                        // SQL_Latin1_General_CP1_CI_AS NULL, [VersionNbr] [int] NULL CONSTRAINT
                        // [DF_DataSource_VersionNbr] DEFAULT ((0)), [LastAccessDate] [datetime] NULL,
                        // [FileLength] [int] NULL, [LastWriteTime] [datetime] NULL,

                        CRC = "";
                        string SourceGuid = getGuid();
                        var FileAttributes = DirFiles[K].Split('|');
                        string file_FullName = FileAttributes[1];
                        string file_SourceName = FileAttributes[0];
                        string file_DirName = DMA.GetFilePath(file_FullName);
                        if (xDebug)
                            LOG.WriteToArchiveLog("    File: " + file_SourceName);
                        string file_Length = FileAttributes[2];
                        if (modGlobals.gMaxSize > 0d)
                        {
                            if (Conversion.Val(file_Length) > modGlobals.gMaxSize)
                            {
                                LOG.WriteToArchiveLog("Notice: file '" + file_FullName + "' exceed the allowed file upload size, skipped.");
                                goto NextFile;
                            }
                        }

                        // **************************************************************************************************

                        string CrcHash = ENC.GenerateSHA512HashFromFile(FQN);
                        ImageHash = ENC.GenerateSHA512HashFromFile(FQN);
                        string AttachmentCode = "C";
                        int iDatasourceCnt = getCountDataSourceFiles(file_SourceName, CrcHash);
                        if (iDatasourceCnt == 0)
                        {
                            saveContentOwner(SourceGuid, modGlobals.gCurrUserGuidID, "C", file_DirName, modGlobals.gMachineID, modGlobals.gNetworkID);
                        }

                        // **************************************************************************************************

                        if (K == 0 | K % 100 == 0)
                        {
                            if (xDebug)
                                LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8010 : Processing files in folder: " + file_SourceName);
                        }

                        bool bIsArchivedAlready = DMA.isFileArchiveAttributeSet(file_FullName);
                        if (bIsArchivedAlready == true & ckSkipIfArchBitTrue == true)
                        {
                            if (xDebug)
                                LOG.WriteToArchiveLog("File : " + file_FullName + " archive bit was found to set TRUE, skipped file.");
                            goto NextFile;
                        }

                        string file_SourceTypeCode = FileAttributes[3];
                        if (file_SourceTypeCode.Equals(".msg"))
                        {
                            LOG.WriteToArchiveLog("File : " + file_FullName + " was found to be a message file, skipped file.");
                            string DisplayMsg = "A message file was encounted in a backup directory." + Constants.vbCrLf;
                            DisplayMsg = DisplayMsg + "It has been moved to the EMAIL Working directory." + Constants.vbCrLf;
                            DisplayMsg = DisplayMsg + "To archive a MSG file, it must be imported into outlook." + Constants.vbCrLf;
                            DisplayMsg = DisplayMsg + "This file has not been added to the CONTENT repository." + Constants.vbCrLf;
                            My.MyProject.Forms.frmHelp.MsgToDisplay = DisplayMsg;
                            My.MyProject.Forms.frmHelp.CallingScreenName = "ECM Archive";
                            My.MyProject.Forms.frmHelp.CaptionName = "MSG File Encounted in Content Archive";
                            My.MyProject.Forms.frmHelp.Timer1.Interval = 10000;
                            My.MyProject.Forms.frmHelp.Show();
                            string EmailWorkingDirectory = getWorkingDirectory(modGlobals.gCurrUserGuidID, "EMAIL WORKING DIRECTORY");
                            string EmailFQN = EmailWorkingDirectory + @"\" + file_SourceName.Trim();
                            File F;
                            if (File.Exists(EmailFQN))
                            {
                                string tMsg = "Email Encountered, already in EMAIL WORKING DIRECTORY: " + EmailFQN;
                                LOG.WriteToArchiveLog(tMsg);
                                xTrace(965, "ArchiveFolderContent", tMsg);
                                FilesSkipped += 1;
                            }
                            else
                            {
                                File.Copy(file_FullName, EmailFQN);
                                string tMsg = "Email Encountered, copied to EMAIL WORKING DIRECTORY: " + EmailFQN;
                                LOG.WriteToArchiveLog(tMsg);
                                xTrace(966, "ArchiveFolderContent", tMsg);
                                FilesSkipped += 1;
                            }

                            goto NextFile;
                        }

                        FixFileExtension(ref file_SourceTypeCode);
                        string file_LastAccessDate = FileAttributes[4];
                        string file_CreateDate = FileAttributes[5];
                        string file_LastWriteTime = FileAttributes[6];
                        string OriginalFileType = file_SourceTypeCode;
                        if (Strings.LCase(file_SourceTypeCode).Equals(".exe"))
                        {
                            LOG.WriteToArchiveLog(file_FullName);
                        }

                        bool isZipFile = ZF.isZipFile(file_FullName);
                        if (isZipFile == true)
                        {
                            int StackLevel = 0;
                            var ListOfFiles = new Dictionary<string, int>();
                            string ExistingParentZipGuid = GetGuidByFqn(file_FullName, 0.ToString());
                            if (ExistingParentZipGuid.Length > 0)
                            {
                                // ZipFiles.Add(file_FullName .Trim + "|" + ExistingParentZipGuid)
                                DBLocal.addZipFile(file_FullName, ExistingParentZipGuid, false);
                                ZF.UploadZipFile(UID, MachineID, file_FullName, ExistingParentZipGuid, true, false, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
                                DBLocal.updateFileArchiveInfoLastArchiveDate(file_FullName);
                            }
                            else
                            {
                                // ZipFiles.Add(file_FullName .Trim + "|" + SourceGuid )
                                DBLocal.addZipFile(file_FullName, SourceGuid, false);
                                ZF.UploadZipFile(UID, MachineID, file_FullName, SourceGuid, true, false, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
                                DBLocal.updateFileArchiveInfoLastArchiveDate(file_FullName);
                            }

                            ListOfFiles = null;
                            GC.Collect();
                        }

                        Application.DoEvents();
                        if (!isZipFile)
                        {
                            bool bExt = isExtExcluded(file_SourceTypeCode, true);
                            if (bExt)
                            {
                                if (xDebug)
                                    LOG.WriteToArchiveLog("A file of type '" + file_SourceTypeCode + "' has been encountered and is defined as NOT allowable. It will NOT be stored in the repository.");
                                if (xDebug)
                                    LOG.WriteToArchiveLog(" ");
                                FilesSkipped += 1;
                                goto NextFile;
                            }
                            // ** See if the STAR is in the INCLUDE list, if so, all files are included
                            bExt = isExtIncluded(file_SourceTypeCode, false);
                            if (!bExt)
                            {
                                if (xDebug)
                                    LOG.WriteToArchiveLog("A file of type '" + file_SourceTypeCode + "' has been encountered and is not defined as allowable. It will NOT be stored in the repository.");
                                if (xDebug)
                                    LOG.WriteToArchiveLog(" ");
                                FilesSkipped += 1;
                                goto NextFile;
                            }
                        }
                        else
                        {
                            if (xDebug)
                                LOG.WriteToArchiveLog("clsArchiver: ArchiveFolderContent :8011 : Zip file encountered: " + file_SourceName);
                            if (xDebug)
                                LOG.WriteToArchiveLog("File : " + file_FullName + " was found to be a ZIP file.");
                        }

                        string SubstituteFileType = getProcessFileAsExt(file_SourceTypeCode);
                        int bcnt = iGetRowCount("SourceType", "where SourceTypeCode = '" + file_SourceTypeCode + "'");
                        if (bcnt == 0 & string.IsNullOrEmpty(SubstituteFileType))
                        {
                            if (SubstituteFileType == null)
                            {
                                string MSG = "The file type '" + file_SourceTypeCode + "' is undefined." + Constants.vbCrLf + "DO YOU WISH TO AUTOMATICALLY DEFINE IT?" + Constants.vbCrLf + "This will allow content to be archived, but not searched.";
                                // Dim dlgRes As DialogResult = MessageBox.Show(MSG, "Filetype Undefined", MessageBoxButtons.YesNo)

                                if (xDebug)
                                    LOG.WriteToArchiveLog(MSG);
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
                                string argval1 = "NO SEARCH - AUTO ADDED by Pgm";
                                ST.setSourcetypedesc(ref argval1);
                                string argval2 = "0";
                                ST.setIndexable(ref argval2);
                                string argval3 = 0.ToString();
                                ST.setStoreexternal(ref argval3);
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
                        // ***********************************************************************'
                        // ** New file
                        // ***********************************************************************'
                        if (iDatasourceCnt == 0)
                        {
                            Application.DoEvents();
                            AttachmentCode = "C";
                            bool BB = AddSourceToRepo(UID, MachineID, modGlobals.gNetworkID, SourceGuid, file_FullName, file_SourceName, file_SourceTypeCode, file_LastAccessDate, file_CreateDate, file_LastWriteTime, modGlobals.gCurrUserGuidID, LastVerNbr, RetentionCode, isPublic, CrcHash, file_DirName);
                            DBLocal.updateFileArchiveInfoLastArchiveDate(file_FullName);
                            if (BB)
                            {

                                // Dim VersionNbr As String = "0"
                                // Dim CRC As String = DMA.CalcCRC(file_FullName)
                                // addContentHashKey(SourceGuid, "0", file_CreateDate , file_FullName, OriginalFileType, file_Length , CRC, MachineID)

                                saveContentOwner(SourceGuid, modGlobals.gCurrUserGuidID, "C", FOLDER_FQN, MachineID, modGlobals.gNetworkID);
                                FilesBackedUp += 1;
                                if (xDebug)
                                    LOG.WriteToArchiveLog("File : " + file_FullName + " was found to be NEW and was ADDED the repository.");
                                if (xDebug)
                                    LOG.WriteToArchiveLog("clsArchiver: AddSourceToRepo : Loading: 8012: " + file_SourceName);
                                bool bIsImageFile = isImageFile(file_FullName);
                                UpdateCurrArchiveStats(file_FullName, file_SourceTypeCode);
                                string sSql = "Update DataSource set RetentionExpirationDate = '" + RetentionExpirationDate + "' where SourceGuid = '" + SourceGuid + "'";
                                bool bbExec = ExecuteSqlNewConn(sSql, false);
                                if (!bbExec)
                                {
                                    LOG.WriteToArchiveLog("ERROR: 1234.99c");
                                }
                            }
                            else
                            {
                                FilesSkipped += 1;
                                if (xDebug)
                                    LOG.WriteToArchiveLog("ERROR File 66921x: clsArchiver : " + file_FullName + " was found to be NEW and was NOT ADDED to the repository.");
                                LOG.WriteToArchiveLog("FAILED TO LOAD: " + file_FullName);
                                if (xDebug)
                                    LOG.WriteToArchiveLog("clsArchiver: AddSourceToRepo :FAILED TO LOAD: 8013b: " + file_SourceName);
                            }

                            if (Conversion.Val(file_Length) > 1000000d)
                            {
                                // FrmMDIMain.SB.Text = "Large file Load completed..."
                                // 'FrmMDIMain.SB.Refresh()
                                // 'DisplayActivity = False
                                // 'If Not ActivityThread Is Nothing Then
                                // '    ActivityThread.Abort()
                                // '    ActivityThread = Nothing
                                // 'End If
                                My.MyProject.Forms.frmMain.PBx.Value = 0;
                                Application.DoEvents();
                            }

                            if (BB)
                            {
                                if (xDebug)
                                    LOG.WriteToArchiveLog("File : " + file_FullName + " metadata updated.");
                                if (xDebug)
                                    LOG.WriteToArchiveLog("clsArchiver: AddSourceToRepo :Success: 8014");
                                Application.DoEvents();
                                UpdateDocFqn(SourceGuid, file_FullName);
                                UpdateDocSize(SourceGuid, file_Length);
                                UpdateDocDir(SourceGuid, file_FullName);
                                UpdateDocOriginalFileType(SourceGuid, OriginalFileType);
                                UpdateZipFileIndicator(SourceGuid, isZipFile);
                                if (EmailGuid.Trim().Length > 0)
                                {
                                    // VersionFiles  = "Y"
                                    UpdateEmailIndicator(SourceGuid, EmailGuid);
                                }

                                Application.DoEvents();
                                if (xDebug)
                                    LOG.WriteToArchiveLog("clsArchiver: AddSourceToRepo :Success: 8015");
                                if (!isZipFile)
                                {
                                    // Dim TheFileIsArchived As Boolean = True
                                    // DMA.setFileArchiveAttributeSet(file_FullName , TheFileIsArchived)
                                    DMA.ToggleArchiveBit(file_FullName);
                                }

                                UpdateDocCrc(SourceGuid, CrcHash);
                                InsertSrcAttrib(SourceGuid, "CRC", CrcHash, OriginalFileType);
                                InsertSrcAttrib(SourceGuid, "FILENAME", file_SourceName, OriginalFileType);
                                InsertSrcAttrib(SourceGuid, "CreateDate", file_CreateDate, OriginalFileType);
                                InsertSrcAttrib(SourceGuid, "FILESIZE", file_Length, OriginalFileType);
                                InsertSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessDate, OriginalFileType);
                                InsertSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, OriginalFileType);
                                if (!file_SourceTypeCode.Equals(OriginalFileType))
                                {
                                    InsertSrcAttrib(SourceGuid, "IndexAs", file_LastWriteTime, file_SourceTypeCode);
                                }

                                if (EmailGuid.Trim().Length > 0)
                                {
                                    // VersionFiles  = "Y"
                                    InsertSrcAttrib(SourceGuid, "EMAIL_ATTACH", file_LastWriteTime, OriginalFileType);
                                }

                                if (xDebug)
                                    LOG.WriteToArchiveLog("clsArchiver: AddSourceToRepo :Success: 8016");
                                if (Conversion.Val(file_Length) > 1000000000d)
                                {
                                }
                                // FrmMDIMain.SB4.Text = "Extreme File: " + file_Length  + " bytes - standby"
                                else if (Conversion.Val(file_Length) > 2000000d)
                                {
                                    // FrmMDIMain.SB4.Text = "Large File: " + file_Length  + " bytes"
                                    // 'FrmMDIMain.SB.Refresh()
                                }

                                if (Strings.InStr(file_SourceTypeCode, "wma", CompareMethod.Text) > 0 | Strings.InStr(file_SourceTypeCode, "mp3", CompareMethod.Text) > 0)
                                {
                                    Console.WriteLine("Recording here 06");
                                }

                                if (Strings.LCase(file_SourceTypeCode).Equals(".mp3") | Strings.LCase(file_SourceTypeCode).Equals(".wma") | Strings.LCase(file_SourceTypeCode).Equals("wma"))
                                {
                                    MP3.getRecordingMetaData(file_FullName, SourceGuid, file_SourceTypeCode);
                                    Application.DoEvents();
                                }
                                else if (Strings.LCase(file_SourceTypeCode).Equals(".tiff") | Strings.LCase(file_SourceTypeCode).Equals(".jpg"))
                                {
                                    // ** This functionality will be added at a later time
                                    // KAT.getXMPdata(file_FullName)
                                    Application.DoEvents();
                                }
                                else if (Strings.LCase(file_SourceTypeCode).Equals(".png") | Strings.LCase(file_SourceTypeCode).Equals(".gif"))
                                {
                                    // ** This functionality will be added at a later time
                                    // KAT.getXMPdata(file_FullName)
                                    Application.DoEvents();
                                }
                                else if (Strings.LCase(file_SourceTypeCode).Equals(".wav"))
                                {
                                    MP3.getRecordingMetaData(file_FullName, SourceGuid, file_SourceTypeCode);
                                }
                                else if (Strings.LCase(file_SourceTypeCode).Equals(".tif"))
                                {
                                    // ** This functionality will be added at a later time
                                    // KAT.getXMPdata(file_FullName)
                                    Application.DoEvents();
                                }

                                Application.DoEvents();
                                if ((Strings.LCase(file_SourceTypeCode).Equals(".doc") | Strings.LCase(file_SourceTypeCode).Equals(".docx")) & ckMetaData.Equals("Y"))

                                {
                                    GetWordDocMetadata(file_FullName, SourceGuid, OriginalFileType);
                                }

                                if ((file_SourceTypeCode.Equals(".xls") | file_SourceTypeCode.Equals(".xlsx") | file_SourceTypeCode.Equals(".xlsm")) & ckMetaData.Equals("Y"))


                                {
                                    GetExcelMetaData(file_FullName, SourceGuid, OriginalFileType);
                                }
                            }
                        }

                        NextFile:
                        ;

                        // Me.'FrmMDIMain.SB.Text = "Processing document #" + K.ToString
                        // FrmMDIMain.SB.Text = "Processing Dir: " + FolderName + " # " + K.ToString
                        if (xDebug)
                            LOG.WriteToArchiveLog("clsArchiver: AddSourceToRepo :Success: 8032");
                        Application.DoEvents();
                        if (xDebug)
                            LOG.WriteToArchiveLog("============== File : " + file_FullName + " Was processed as above.");
                    }
                }
                else
                {
                    if (xDebug)
                        LOG.WriteToArchiveLog("Duplicate Folder: " + FolderName);
                    if (xDebug)
                        LOG.WriteToArchiveLog("clsArchiver: AddSourceToRepo :Success: 8034");
                }

                NextFolder:
                ;
                if (xDebug)
                    LOG.WriteToArchiveLog("+++++++++++++++ Getting Next Folder");
                pFolder = FolderName;
            }

            if (xDebug)
                LOG.WriteToArchiveLog("@@@@@@@@@@@@@@  Done with FOLDER Archive.");
        }

        public void ProcessZipFilesX(string UID, string MachineID, bool ckSkipIfArchived, bool bThisIsAnEmail, string RetentionCode, string isPublic)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            for (int i = 0, loopTo = ZipFiles.Count - 1; i <= loopTo; i++)
            {
                string cData = ZipFiles[i].ToString();
                string ParentGuid = "";
                string FQN = "";
                int K = Strings.InStr(cData, "|");
                FQN = Strings.Mid(cData, 1, K - 1);
                ParentGuid = Strings.Mid(cData, K + 1);
                int StackLevel = 0;
                var ListOfFiles = new Dictionary<string, int>();
                ZF.UploadZipFile(UID, MachineID, FQN, ParentGuid, ckSkipIfArchived, bThisIsAnEmail, RetentionCode, isPublic, StackLevel, ref ListOfFiles);
                ListOfFiles = null;
                GC.Collect();
            }
        }

        public void FixFileExtension(ref string Extension)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Extension = Extension.Trim();
            Extension = Extension.ToLower();
            if (Strings.InStr(1, Extension, ".") == 0)
            {
                Extension = "." + Extension;
            }

            while (Strings.InStr(1, Extension, ",") > 0)
                StringType.MidStmtStr(ref Extension, Strings.InStr(1, Extension, ","), 1, ".");
            return;
        }

        public bool isExtExcluded(string fExt, bool ExcludeAll)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (ExcludeAll == false)
            {
                return ExcludeAll;
            }

            fExt = Strings.UCase(fExt);
            if (fExt.Length > 1)
            {
                fExt = Strings.UCase(fExt);
                if (Strings.Mid(fExt, 1, 1) == ".")
                {
                    StringType.MidStmtStr(ref fExt, 1, 1, " ");
                    fExt = fExt.Trim();
                }
            }

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

        public bool isExtIncluded(string fExt, bool IncludeAll)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (IncludeAll == true)
            {
                return IncludeAll;
            }

            fExt = Strings.UCase(fExt);
            if (fExt.Length > 1)
            {
                fExt = Strings.UCase(fExt);
                if (Strings.Mid(fExt, 1, 1) == ".")
                {
                    StringType.MidStmtStr(ref fExt, 1, 1, " ");
                    fExt = fExt.Trim();
                }
            }

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

        public void UpdateSrcAttrib(string SGUID, string aName, string aVal, string SourceType)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

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
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            // ********************************************************
            // PARAMETER: MailboxName = Name of Parent Outlook Folder for
            // the current user: Usually in the form of
            // "Mailbox - Doe, John" or
            // "Public Folders
            // RETURNS: Array of SubFolders in Current User's Mailbox
            // Or unitialized array if error occurs
            // Because it returns an array, it is for VB6 only.
            // Change to return a variant or a delimited list for
            // previous versions of vb
            // EXAMPLE:
            // Dim sArray() As String
            // Dim ictr As Integer
            // sArray = OutlookFolderNames("Mailbox - Doe, John")
            // 'On Error Resume Next
            // For ictr = 0 To UBound(sArray)
            // log.WriteToArchiveLog sArray(ictr)
            // Next
            // *********************************************************
            Outlook.Application oOutlook;
            Outlook._NameSpace oMAPI;
            Outlook.MAPIFolder oParentFolder;
            var sArray = default(string[]);
            int i;
            int iElement;
            try
            {
                if (xDebug)
                    LOG.WriteToArchiveLog("Entry OutlookFolderNames 001");
                oOutlook = new Outlook.Application();
                if (xDebug)
                    LOG.WriteToArchiveLog("Entry OutlookFolderNames 002");
                oMAPI = oOutlook.GetNamespace("MAPI");
                if (xDebug)
                    LOG.WriteToArchiveLog("Entry OutlookFolderNames 003");
                oParentFolder = oMAPI.Folders[MailboxName];
                if (xDebug)
                    LOG.WriteToArchiveLog("Entry OutlookFolderNames 004");
                Array.Resize(ref sArray, 1);
                My.MyProject.Forms.frmMsg.Show();
                My.MyProject.Forms.frmMsg.txtMsg.Text = "Loading Outlook Folders";
                if (oParentFolder.Folders.Count != 0)
                {
                    if (xDebug)
                        LOG.WriteToArchiveLog("Found Outlook Folders 005 Start: Count = " + oParentFolder.Folders.Count.ToString() + ".");
                    var loopTo = oParentFolder.Folders.Count;
                    for (i = 1; i <= loopTo; i++)
                    {
                        Application.DoEvents();
                        try
                        {
                            string tName = oParentFolder.Folders[i].Name.ToString();
                            if (xDebug)
                                LOG.WriteToArchiveLog("Entry OutlookFolderNames 005 Loop: " + tName + ".");
                            if (tName.Trim().Length > 0)
                            {
                                if (xDebug)
                                    LOG.WriteToArchiveLog("Entry OutlookFolderNames 005a: " + tName + ".");
                                // If Trim(oMAPI.GetDefaultFolder(oParentFolder.olFolderInbox).Folders.Item(i).Name) <> "" Then
                                if (!string.IsNullOrEmpty(tName))
                                {
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("Entry OutlookFolderNames 005b: " + tName + ".");
                                    if (string.IsNullOrEmpty(sArray[0]))
                                    {
                                        if (xDebug)
                                            LOG.WriteToArchiveLog("Entry OutlookFolderNames 005c: " + tName + ".");
                                        iElement = 0;
                                    }
                                    else
                                    {
                                        if (xDebug)
                                            LOG.WriteToArchiveLog("Entry OutlookFolderNames 005d: " + tName + ".");
                                        iElement = Information.UBound(sArray) + 1;
                                    }

                                    if (xDebug)
                                        LOG.WriteToArchiveLog("Entry OutlookFolderNames 005e: " + tName + ".");
                                    Array.Resize(ref sArray, iElement + 1);
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("Entry OutlookFolderNames 005f: " + tName + ".");
                                    sArray[iElement] = oParentFolder.Folders[i].Name;
                                    if (xDebug)
                                        LOG.WriteToArchiveLog("Entry OutlookFolderNames 005g: " + tName + ".");
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            LOG.WriteToArchiveLog("NOTICE:OutlookFolderNames 005x: Item #" + i.ToString() + Constants.vbCrLf + ex.Message);
                        }
                    }
                }
                else
                {
                    if (xDebug)
                        LOG.WriteToArchiveLog("Entry OutlookFolderNames 006");
                    sArray[0] = oParentFolder.Name;
                }

                if (xDebug)
                    LOG.WriteToArchiveLog("Entry OutlookFolderNames 007");
                oMAPI = null;
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("NOTICE 5692.13a OutlookFolderNames - Could not access Outlook. ");
                LOG.WriteToArchiveLog("NOTICE 5692.13b -" + ex.Message);
                LOG.WriteToArchiveLog("NOTICE 5692.13c -" + ex.StackTrace);
                My.MyProject.Forms.frmMsg.Close();
                My.MyProject.Forms.frmMsg.Hide();
                return false;
            }

            if (xDebug)
                LOG.WriteToArchiveLog("Entry OutlookFolderNames 008");
            My.MyProject.Forms.frmMsg.Close();
            My.MyProject.Forms.frmMsg.Hide();
            return true;
        }

        public void ArchiveAllEmail(string UID)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var PROC = new clsProcess();
            string TopLevelOutlookFolder = "";
            if (isArchiveDisabled("EMAIL") == true)
            {
                return;
            }

            var ActiveEmailFolders = new ArrayList();
            ActiveEmailFolders = getOutlookParentFolderNames();
            ActiveEmailFolders = getOutlookParentFolderNames();
            var LastEmailArchRunDate = DateAndTime.Now;
            // getOutlookParentFolderNames(Me.cbParentFolders)
            string EmailFolder = "";
            for (int XX = 0, loopTo = ActiveEmailFolders.Count - 1; XX <= loopTo; XX++)
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
                // ***************************************************************
                bool bUseQuickSearch = false;
                var DBARCH = new clsDatabaseARCH();
                int NbrOfIds = DBARCH.getCountStoreIdByFolder();
                var slStoreId = new SortedList();
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
                    DBLocal.getCE_EmailIdentifiers(ref slStoreId);
                }
                else
                {
                    slStoreId.Clear();
                }
                // ***************************************************************

                ArchiveSelectedOutlookFolders(UID, EmailFolder, slStoreId);
                if (xDebug)
                    LOG.WriteToArchiveLog("** Completed Processing folder: " + EmailFolder);
                // *********************************************************************************
                UserParmInsertUpdate("LastEmailArchRunDate", modGlobals.gCurrUserGuidID, Conversions.ToString(LastEmailArchRunDate));

                // UpdateMessageStoreID(gCurrUserGuidID)
                try
                {
                    DeleteOutlookMessages(modGlobals.gCurrUserGuidID);
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("WARNING 2005.32.1 - call DEleteOutlookMessages failed.");
                }

                GC.Collect();
                PROC.getProcessesToKill();
                PROC.KillOrphanProcesses();
                NextFolder:
                ;
            }

            PROC = null;
        }

        public void SetNewPST(string strFileName)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Outlook.Application objOL;
            Outlook.NameSpace objNS;
            Outlook.MAPIFolder objFolder;
            objOL = (Outlook.Application)Interaction.CreateObject("Outlook.Application");
            objNS = objOL.GetNamespace("MAPI");
            objNS.AddStore(strFileName);
            objFolder = objNS.Folders.GetFirst();
            while (objFolder is object)
                // For i As Integer = 0 To objFolder.Items.Count - 1
                // For Each EMAIL In
                // Next
                // objFolder = objNS.Folders.GetNext
                Console.WriteLine(objFolder.Name);
            objOL = null;
            objNS = null;
            objFolder = null;
        }

        // Public Function AddLibraryItem(ByVal SourceGuid , ByVal ItemTitle , ByVal FileExt , ByVal LibraryName ) As Boolean

        // ItemTitle = UTIL.RemoveSingleQuotes(ItemTitle ) LibraryName =
        // UTIL.RemoveSingleQuotes(LibraryName )

        // Dim LibraryOwnerUserID = gCurrUserGuidID Dim DataSourceOwnerUserID = gCurrUserGuidID Dim
        // LibraryItemGuid = Guid.NewGuid.ToString Dim AddedByUserGuidId = gCurrUserGuidID

        // Dim SS = "Select count(*) from LibraryItems where LibraryName = '" + LibraryName + "' and
        // SourceGuid = '" + SourceGuid + "'" Dim iCnt As Integer = iCount(SS) If iCnt > 0 Then Return
        // True End If

        // Dim b As Boolean = False Dim s As String = "" s = s + " INSERT INTO LibraryItems(" s = s +
        // "SourceGuid," s = s + "ItemTitle," s = s + "ItemType," s = s + "LibraryItemGuid," s = s +
        // "DataSourceOwnerUserID," s = s + "LibraryOwnerUserID," s = s + "LibraryName," s = s +
        // "AddedByUserGuidId) values (" s = s + "'" + SourceGuid + "'" + "," s = s + "'" + ItemTitle +
        // "'" + "," s = s + "'" + FileExt + "'" + "," s = s + "'" + LibraryItemGuid + "'" + "," s = s +
        // "'" + DataSourceOwnerUserID + "'" + "," s = s + "'" + LibraryOwnerUserID + "'" + "," s = s +
        // "'" + LibraryName + "'" + "," s = s + "'" + AddedByUserGuidId + "'" + ")"
        // Application.DoEvents() Return ExecuteSqlNewConn(s, False)

        // End Function

        public string ReduceDirByOne(string DirName)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string CH = "";
            int I = 0;
            for (I = DirName.Length; I >= 1; I -= 1)
            {
                CH = Strings.Mid(DirName, I, 1);
                if (CH == @"\")
                {
                    return Strings.Mid(DirName, 1, I - 1);
                }
            }

            return "";
        }

        public bool SendHelpRequest(string CompanyID, string RequestorName, string RequestorEmail, string RequestorPhone, string RequestDesc, string FQN)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            // Create an Outlook application. Create a new MailItem.
            Outlook._Application oApp;
            oApp = new Outlook.Application();
            Outlook._MailItem oMsg;
            Outlook.Attachment oAttach;
            Outlook.Attachments oAttachs = null;
            string CCAddr = "";
            string HelpEmails = getHelpEmail();
            var Emails = HelpEmails.Split('|');
            for (int I = 0, loopTo = Information.UBound(Emails); I <= loopTo; I++)
            {
                if (Emails[I].Trim().Length > 0)
                {
                    if (Strings.InStr(Emails[I], "support@ecmlibrary", CompareMethod.Text) == 0)
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
                    if (Strings.Mid(CCAddr, 1, 1).Equals(";"))
                    {
                        StringType.MidStmtStr(ref CCAddr, 1, 1, " ");
                        CCAddr = CCAddr.Trim();
                    }
                }

                oMsg = (Outlook._MailItem)oApp.CreateItem(Outlook.OlItemType.olMailItem);
                oMsg.Subject = "HELP Request";
                oMsg.Body = "From Name: " + RequestorName + Constants.vbCr + Constants.vbCr + "Phone Number: " + RequestorPhone + Constants.vbCr + Constants.vbCr + "Problem description: " + RequestDesc;

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
                oAttach = oAttachs.Add(sSource, Position: Conversions.ToDouble(sBodyLen) + 1d, DisplayName: sDisplayName);

                // Send
                oMsg.Send();
                return true;
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR SendHelpRequest 100 - " + ex.Message);
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
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string RetentionCode = "Retain 10";
            string isPublic = "N";
            Successful = true;
            FQN = FQN.Replace("''", "'");
            bool bExists = false;
            if (File.Exists(FQN))
            {
                bExists = true;
            }

            var DOCS = new clsDATASOURCE_V2();
            var PROC = new clsProcess();
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
            if (ddebug)
                LOG.WriteToListenLog("ArchiveSingleFile : ArchiveContent :8000 : trace log.");
            int RetentionYears = (int)Conversion.Val(getSystemParm("RETENTION YEARS"));
            var rightNow = DateAndTime.Now.AddYears(RetentionYears);
            string RetentionExpirationDate = rightNow.ToString();
            string EmailFQN = "";
            ZipFiles.Clear();
            var a = new string[1];

            // Dim ActiveFolders(0)
            var ActiveFolders = new List<string>();
            string FolderName = "";
            bool DeleteFile = false;
            string OcrDirectory = "";
            var ListOfDisabledDirs = new List<string>();
            // ********************************************************************

            string TemporaryDirName = DirName;
            LOG.WriteToArchiveLog("Info: ArchiveSingleFile 01 - " + DirName + ":" + modGlobals.gCurrUserGuidID + ":" + TemporaryDirName);
            bool AD_set = setContentArchiveFileFolder(modGlobals.gCurrUserGuidID, ref ActiveFolders, TemporaryDirName);
            string S = "";
            S = S + " SELECT count(*) ";
            S = S + " FROM  Directory ";
            S = S + " WHERE Directory.UserID = '" + modGlobals.gCurrUserGuidID + "' and (AdminDisabled = 0 or AdminDisabled is null) and FQN = '" + DirName + "' ";
            int icnt = iCount(S);
            while (AD_set == false)
            {
                if (Strings.InStr(TemporaryDirName, @"\") > 0)
                {
                    TemporaryDirName = ReduceDirByOne(TemporaryDirName);
                    AD_set = setContentArchiveFileFolder(modGlobals.gCurrUserGuidID, ref ActiveFolders, TemporaryDirName);
                }
                else
                {
                    break;
                }
            }
            // log.WriteToArchiveLog("Info: ArchiveSingleFile 05 - " & TemporaryDirName)
            if (AD_set == false)
            {
                LOG.WriteToArchiveLog("NOTIFICATION - ArchiveSingleFile 001: Did not find file '" + DirName + " / " + FQN + "', skipping.");
                if (bExists == false)
                {
                    return;
                }
                else
                {
                    // Dim FOLDER_FQN as string  = FolderParms(0)
                    // Dim FOLDER_IncludeSubDirs  = FolderParms(1)
                    // Dim FOLDER_DBID  = FolderParms(2)
                    // Dim FOLDER_VersionFiles  = FolderParms(3)
                    // Dim DisableDir  = FolderParms(4)
                    // OcrDirectory = FolderParms(5)
                    // Dim ParentDir = FolderParms(6)
                    // Dim skipArchiveBit = FolderParms(7)
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

            if (!ActiveFolders.Contains(DirName))
            {
                ActiveFolders.Add(DirName);
            }

            getDisabledDirectories(ref ListOfDisabledDirs);
            // ********************************************************************

            string cFolder = "";
            string pFolder = "XXX";
            var DirFiles = new List<string>();
            string ArchiveMsg = "";
            if (ddebug)
                LOG.WriteToListenLog("ArchiveSingleFile : ArchiveContent :8001 : trace log.");
            FilesBackedUp = 0;
            FilesSkipped = 0;
            var LibraryList = new List<string>();
            for (int i = 0, loopTo = ActiveFolders.Count - 1; i <= loopTo; i++)
            {

                // If gTerminateImmediately Then
                // Return
                // End If

                Application.DoEvents();
                string FolderParmStr = ActiveFolders[i].ToString().Trim();
                var FolderParms = FolderParmStr.Split('|');
                if (FolderParms.Count() < 3)
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
                if (Conversions.ToBoolean(Strings.InStr(FOLDER_FQN, "%userid%", CompareMethod.Text)))
                {
                    string S1 = "";
                    string S2 = "";
                    int iLoc = Strings.InStr(FOLDER_FQN, "%userid%", CompareMethod.Text);
                    S1 = Strings.Mid(FOLDER_FQN, 1, iLoc - 1);
                    S2 = Strings.Mid(FOLDER_FQN, iLoc + Strings.Len("%userid%"));
                    string UserName = Environment.UserName;
                    FOLDER_FQN = S1 + UserName + S2;
                }

                if (ListOfDisabledDirs.Contains(FOLDER_FQN))
                {
                    LOG.WriteToListenLog("NOTICE: Folder '" + FOLDER_FQN + "' is disabled from archive, skipping.");
                    Successful = true;
                    FQN = UTIL.RemoveSingleQuotes(FQN);
                    S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = '" + FQN + "' and MachineName = '" + MachineID + "'";
                    bool B = ExecuteSqlNewConn(90202, S);
                    goto NextFolder;
                }

                if (ddebug)
                    LOG.WriteToListenLog("ArchiveSingleFile : ArchiveContent :8002 :FOLDER_FQN : " + FOLDER_FQN);

                // Dim FOLDER_FQN as string  = FolderParms(0)
                // Dim FOLDER_IncludeSubDirs  = FolderParms(1)
                // Dim FOLDER_DBID  = FolderParms(2)
                // Dim FOLDER_VersionFiles  = FolderParms(3)
                // Dim DisableDir  = FolderParms(4)
                // OcrDirectory = FolderParms(5)
                // Dim ParentDir = FolderParms(6)
                // Dim skipArchiveBit = FolderParms(7)

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
                    if (ddebug)
                        LOG.WriteToListenLog("ArchiveSingleFile : ArchiveContent :8003 :FOLDER Exists: " + FOLDER_FQN);
                    if (ddebug)
                        LOG.WriteToListenLog("Archive Folder: " + FOLDER_FQN);
                }
                else
                {
                    if (ddebug)
                        LOG.WriteToListenLog("WARNING - ArchiveSingleFile : ArchiveContent :8004 :FOLDER DOES NOT Exist: " + FOLDER_FQN);
                    if (ddebug)
                        LOG.WriteToListenLog("WARNING - Archive Folder FOUND MISSING: " + FOLDER_FQN);
                    FQN = UTIL.RemoveSingleQuotes(FQN);
                    S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = '" + FQN + "' and MachineName = '" + MachineID + "'";
                    bool B = ExecuteSqlNewConn(90203, S);
                    goto NextFolder;
                }

                if (DisableDir.Equals("Y"))
                {
                    LOG.WriteToListenLog("WARNIGN - ArchiveSingleFile : Directory Archive Disabled: " + FOLDER_FQN + " skipped file " + FQN);
                    FQN = UTIL.RemoveSingleQuotes(FQN);
                    S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = '" + FQN + "' and MachineName = '" + MachineID + "'";
                    bool B = ExecuteSqlNewConn(90204, S);
                    goto NextFolder;
                }

                if (Strings.InStr(FOLDER_FQN, "'") > 0)
                {
                    Console.WriteLine("Single Quote found");
                }

                // ******************************************************************************
                if ((PrevParentDir ?? "") != (ParentDir ?? ""))
                {
                    IncludedTypes = GetAllIncludedFiletypes(ParentDir, FOLDER_IncludeSubDirs);
                    ExcludedTypes = GetAllExcludedFiletypes(ParentDir, FOLDER_IncludeSubDirs);
                }

                if (IncludedTypes.Count == 0)
                {
                    goto NextFolder;
                }
                // ******************************************************************************
                PrevParentDir = ParentDir;
                if (ddebug)
                    LOG.WriteToListenLog("ArchiveSingleFile : ArchiveContent :8005 : Trace: " + FOLDER_FQN);
                bool bChanged = false;
                if ((FOLDER_FQN ?? "") != (pFolder ?? ""))
                {
                    string ParentDirForLib = "";
                    bool bLikToLib = false;
                    bLikToLib = isDirInLibrary(FOLDER_FQN, ref ParentDirForLib);
                    if (ddebug)
                        LOG.WriteToListenLog("ArchiveSingleFile : ArchiveContent :8006 : Folder Changed: " + FOLDER_FQN + ", " + pFolder);
                    FolderName = FOLDER_FQN;
                    if (ddebug)
                        Debug.Print("Processing Folder: " + FolderName);
                    if (ddebug)
                        LOG.WriteToListenLog("Archiving Folder: " + FolderName);
                    Application.DoEvents();
                    // ** Verify that the DIR still exists
                    if (!Directory.Exists(FolderName))
                    {
                        LOG.WriteToListenLog("ArchiveSingleFile : Directory does not exist: " + FOLDER_FQN);
                        FQN = UTIL.RemoveSingleQuotes(FQN);
                        S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = '" + FQN + "' and MachineName = '" + MachineID + "'";
                        bool B = ExecuteSqlNewConn(90205, S);
                        goto NextFolder;
                    }

                    if (bLikToLib)
                    {
                        GetDirectoryLibraries(ParentDirForLib, ref LibraryList);
                    }
                    else
                    {
                        GetDirectoryLibraries(FOLDER_FQN, ref LibraryList);
                    }

                    RetentionCode = GetDirRetentionCode(ParentDir, modGlobals.gCurrUserGuidID);
                    if (RetentionCode.Length > 0)
                    {
                        RetentionYears = getRetentionPeriod(RetentionCode);
                    }
                    else
                    {
                        RetentionYears = (int)Conversion.Val(getSystemParm("RETENTION YEARS"));
                    }

                    getDirectoryParms(ref a, ParentDir, modGlobals.gCurrUserGuidID);
                    string IncludeSubDirs = a[0];
                    string VersionFiles = a[1];
                    string ckMetaData = a[2];
                    OcrDirectory = a[3];
                    RetentionCode = a[4];

                    // *****************************************************************************
                    // ** Get all of the files in this folder
                    // *****************************************************************************
                    try
                    {
                        if (ddebug)
                            LOG.WriteToListenLog("Starting File capture");
                        DirFiles.Clear();
                        if (ddebug)
                            LOG.WriteToListenLog("Starting File capture: Init Dirfiles");
                        // *******************************************************************************************************************
                        if (Strings.InStr(FQN, ":") > 0)
                        {
                            DirFiles.Add(FQN);
                        }
                        else
                        {
                            DirFiles.Add(DirName + @"\" + FQN);
                        }

                        // NbrFilesInDir = DMA.getFilesInDir(FOLDER_FQN , DirFiles , IncludedTypes, ExcludedTypes, ckSkipIfArchived)
                        NbrFilesInDir = 1;
                        // *******************************************************************************************************************
                        if (ddebug)
                            LOG.WriteToListenLog("Starting File capture: Loaded files");
                        if (NbrFilesInDir == 0)
                        {
                            if (ddebug)
                                LOG.WriteToListenLog("Archive Folder HAD NO FILES: " + FOLDER_FQN);
                            FQN = UTIL.RemoveSingleQuotes(FQN);
                            S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = '" + FQN + "' and MachineName = '" + MachineID + "'";
                            bool B = ExecuteSqlNewConn(90206, S);
                            goto NextFolder;
                        }

                        if (ddebug)
                            LOG.WriteToListenLog("Starting File capture: start ckFilesNeedUpdate");
                        // *******************************
                        // ** WDM 2/21/2010  ckFilesNeedUpdate(DirFiles , ckSkipIfArchived)
                        // *******************************
                        if (ddebug)
                            LOG.WriteToListenLog("Starting File capture: end ckFilesNeedUpdate");
                    }
                    catch (Exception ex)
                    {
                        LOG.WriteToListenLog("ERROR Archive Folder Acquisition Failure : " + FOLDER_FQN);
                        goto NextFolder;
                    }

                    // ** Process all of the files
                    for (int K = 0, loopTo1 = DirFiles.Count - 1; K <= loopTo1; K++)
                    {
                        if (modGlobals.gTerminateImmediately)
                        {
                            DOCS = null;
                            PROC = null;
                            return;
                        }

                        Application.DoEvents();
                        if (DirFiles[K] == null)
                        {
                            LOG.WriteToListenLog("ArchiveSingleFile : DirFiles(K) = Nothing " + FOLDER_FQN);
                            goto NextFile;
                        }

                        FileInfo fileDetail;
                        string SourceGuid = "";
                        // Dim FileAttributes () = DirFiles(K).Split("|")
                        string OriginalFileName = "";
                        string file_FullName = "";
                        bool BBB = true;
                        SourceGuid = getGuid();
                        file_FullName = DirFiles[0];
                        if (File.Exists(file_FullName))
                        {
                            BBB = true;
                            var FI = new FileInfo(file_FullName);
                            OriginalFileName = FI.Name;
                            FI = null;
                            GC.Collect();
                        }
                        else
                        {
                            BBB = false;
                        }

                        GC.Collect();
                        if (BBB == false)
                        {
                            LOG.WriteToListenLog("ArchiveSingleFile :BBB file does not exist: " + file_FullName);
                            Successful = true;
                            FQN = UTIL.RemoveSingleQuotes(FQN);
                            S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = '" + FQN + "' and MachineName = '" + MachineID + "'";
                            bool B = ExecuteSqlNewConn(90207, S);
                            goto NextFile;
                        }

                        string file_SourceName = DMA.getFileName(file_FullName);
                        if (ddebug)
                            Debug.Print("    File: " + file_SourceName);
                        fileDetail = My.MyProject.Computer.FileSystem.GetFileInfo(file_FullName);
                        string file_Length = fileDetail.Length.ToString();
                        if (modGlobals.gMaxSize > 0d)
                        {
                            if (Conversion.Val(file_Length) > modGlobals.gMaxSize)
                            {
                                LOG.WriteToListenLog("Notice: file '" + file_FullName + "' exceed the allowed file upload size, skipped.");
                                FQN = UTIL.RemoveSingleQuotes(FQN);
                                S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = '" + FQN + "' and MachineName = '" + MachineID + "'";
                                bool B = ExecuteSqlNewConn(90208, S);
                                goto NextFile;
                            }
                        }

                        file_FullName = UTIL.RemoveSingleQuotes(file_FullName);
                        file_SourceName = UTIL.RemoveSingleQuotes(file_SourceName);
                        try
                        {
                        }
                        // FrmMDIMain.SB4.Text = file_SourceName
                        catch (Exception ex)
                        {
                        }

                        string file_DirName = fileDetail.Directory.ToString();
                        string file_SourceTypeCode = fileDetail.Extension;
                        if (file_SourceTypeCode.Trim().Length == 0)
                        {
                            file_SourceTypeCode = ".UKN";
                        }

                        string CrcHash = ENC.GenerateSHA512HashFromFile(file_FullName);
                        string ImageHash = ENC.GenerateSHA512HashFromFile(file_FullName);

                        // ** If version files is NO and already in REPO, skip it right here
                        if (Strings.UCase(FOLDER_VersionFiles).Equals("N"))
                        {
                            bool bFileAlreadyExist = ckDocumentExists(file_SourceName, MachineID, CrcHash);
                            if (bFileAlreadyExist == true)
                            {
                                LOG.WriteToListenLog("ArchiveSingleFile :If version files is NO and already in REPO, skip it right here: " + file_FullName);
                                FQN = UTIL.RemoveSingleQuotes(FQN);
                                S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = '" + FQN + "' and MachineName = '" + MachineID + "'";
                                bool B = ExecuteSqlNewConn(90209, S);
                                goto NextFile;
                            }
                        }

                        if (file_SourceTypeCode.Equals(".msg"))
                        {
                            LOG.WriteToListenLog("NOTICE: Content Archive File : " + file_FullName + " was found to be a message file, moved file.");
                            string DisplayMsg = "A message file was encounted in a backup directory." + Constants.vbCrLf;
                            DisplayMsg = DisplayMsg + "It has been moved to the EMAIL Working directory." + Constants.vbCrLf;
                            DisplayMsg = DisplayMsg + "To archive a MSG file, it should be imported into outlook." + Constants.vbCrLf;
                            DisplayMsg = DisplayMsg + "This file has ALSO been added to the CONTENT repository." + Constants.vbCrLf;
                            if (modGlobals.gRunUnattended == false)
                            {
                                My.MyProject.Forms.frmHelp.MsgToDisplay = DisplayMsg;
                                My.MyProject.Forms.frmHelp.CallingScreenName = "ECM Archive";
                                My.MyProject.Forms.frmHelp.CaptionName = "MSG File Encounted in Content Archive";
                                My.MyProject.Forms.frmHelp.Timer1.Interval = 10000;
                                My.MyProject.Forms.frmHelp.Show();
                            }

                            if (modGlobals.gRunUnattended == true)
                            {
                                LOG.WriteToListenLog("WARNING: ArchiveContent 100: " + Constants.vbCrLf + DisplayMsg);
                            }

                            string EmailWorkingDirectory = getWorkingDirectory(modGlobals.gCurrUserGuidID, "EMAIL WORKING DIRECTORY");
                            EmailWorkingDirectory = UTIL.RemoveSingleQuotes(EmailWorkingDirectory);
                            file_SourceName = UTIL.RemoveSingleQuotes(file_SourceName);
                            EmailFQN = EmailWorkingDirectory + @"\" + file_SourceName.Trim();
                            file_FullName = UTIL.RemoveSingleQuotes(file_FullName);
                            if (File.Exists(EmailFQN))
                            {
                                string tMsg = "Email Encountered, already in EMAIL WORKING DIRECTORY: " + EmailFQN;
                                LOG.WriteToListenLog(tMsg);
                                xTrace(965, "ArchiveContent", tMsg);
                            }
                            // FilesSkipped += 1
                            else
                            {
                                File.Copy(file_FullName, EmailFQN);
                                string tMsg = "Email File Encountered, moved to EMAIL WORKING DIRECTORY and entered into repository: " + EmailFQN;
                                xTrace(966, "ArchiveContent", tMsg);
                                // FilesSkipped += 1
                            }

                            GC.Collect();
                        }

                        string file_LastAccessDate = Conversions.ToString(fileDetail.LastAccessTime);
                        string file_CreateDate = Conversions.ToString(fileDetail.CreationTime);
                        string file_LastWriteTime = Conversions.ToString(fileDetail.LastWriteTime);
                        string OriginalFileType = file_SourceTypeCode;
                        fileDetail = null;
                        if (Strings.LCase(file_SourceTypeCode).Equals(".exe"))
                        {
                            Debug.Print(file_FullName);
                        }

                        bool isZipFile = ZF.isZipFile(file_FullName);
                        if (isZipFile == true)
                        {
                            string ExistingParentZipGuid = GetGuidByFqn(file_FullName, 0.ToString());
                            int StackLevel = 0;
                            var ListOfFiles = new Dictionary<string, int>();
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
                        if (!isZipFile)
                        {
                            bool bExt = DMA.isExtExcluded(file_SourceTypeCode, ExcludedTypes);
                            if (bExt)
                            {
                                FilesSkipped += 1;
                                LOG.WriteToListenLog("ArchiveSingleFile : file excluded: " + file_FullName);
                                FQN = UTIL.RemoveSingleQuotes(FQN);
                                S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = '" + FQN + "' and MachineName = '" + MachineID + "'";
                                bool B = ExecuteSqlNewConn(90210, S);
                                goto NextFile;
                            }
                            // ** See if the STAR is in the INCLUDE list, if so, all files are included
                            bExt = DMA.isExtIncluded(file_SourceTypeCode, ExcludedTypes);
                            if (bExt)
                            {
                                FilesSkipped += 1;
                                LOG.WriteToListenLog("ArchiveSingleFile : file excluded #2: " + file_FullName);
                                FQN = UTIL.RemoveSingleQuotes(FQN);
                                S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = '" + FQN + "' and MachineName = '" + MachineID + "'";
                                bool B = ExecuteSqlNewConn(90211, S);
                                goto NextFile;
                            }
                        }

                        int bcnt = iGetRowCount("SourceType", "where SourceTypeCode = '" + file_SourceTypeCode + "'");
                        string SubstituteFileType = getProcessFileAsExt(file_SourceTypeCode);
                        if (bcnt == 0 & SubstituteFileType == null)
                        {
                            if (SubstituteFileType == null)
                            {
                                string MSG = "The file type '" + file_SourceTypeCode + "' is undefined." + Constants.vbCrLf + "DO YOU WISH TO AUTOMATICALLY DEFINE IT?" + Constants.vbCrLf + "This will allow content to be archived, but not searched.";
                                // Dim dlgRes As DialogResult = MessageBox.Show(MSG, "Filetype Undefined", MessageBoxButtons.YesNo)

                                if (ddebug)
                                    LOG.WriteToListenLog(MSG);
                                string argval = "0";
                                UNASGND.setApplied(ref argval);
                                UNASGND.setFiletype(ref file_SourceTypeCode);
                                int xCnt = UNASGND.cnt_PK_AFTU(file_SourceTypeCode);
                                if (xCnt == 0)
                                {
                                    UNASGND.Insert();
                                }

                                var ST = new clsSOURCETYPE();
                                ST.setSourcetypecode(ref file_SourceTypeCode);
                                string argval1 = "NO SEARCH - AUTO ADDED by Pgm";
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
                        else if (SubstituteFileType.Trim().Length > 0)
                        {
                            file_SourceTypeCode = SubstituteFileType;
                        }

                        EmailFQN = UTIL.RemoveSingleQuotes(EmailFQN);
                        file_FullName = UTIL.RemoveSingleQuotes(file_FullName);
                        string StoredExternally = "N";
                        icnt = 0;
                        Application.DoEvents();

                        // ***********************************************************************'
                        // ** New file
                        // ***********************************************************************'
                        bool BB = false;
                        string AttachmentCode = "C";
                        string ContentTypeCode = "C";
                        LOG.WriteToListenLog("File : " + file_FullName + " was found to be NEW and not in the repository.");

                        // Me.SB.Text = "Loading: " + file_SourceName
                        Application.DoEvents();
                        LastVerNbr = 0;
                        // WDMXX This is where Duplicate Content is identified.
                        icnt = getCountDataSourceFiles(file_SourceName, CrcHash);
                        if (icnt > 0)
                        {
                            // ** The file is not in the repository, add it.
                            LOG.WriteToListenLog("Warning File : " + file_FullName + " was found to be NEW and WAS ACTUALLY in the repository, skipped it.");
                            FilesSkipped += 1;
                            FQN = UTIL.RemoveSingleQuotes(FQN);
                            S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = '" + FQN + "' and MachineName = '" + MachineID + "'";
                            bool B = ExecuteSqlNewConn(90213, S);
                            string tguid = getContentGuid(FQN, CrcHash);
                            string FileDirectory = Path.GetDirectoryName(FQN);
                            BB = saveContentOwner(tguid, modGlobals.gCurrLoginID, ContentTypeCode, FileDirectory, modGlobals.gMachineID, modGlobals.gNetworkID);
                            goto NextFile;
                        }

                        if (icnt == 0)
                        {

                            // file_FullName = UTIL.RemoveSingleQuotes(file_FullName)
                            // file_SourceName = UTIL.RemoveSingleQuotes(file_SourceName)

                            DOCS.setSourceguid(ref SourceGuid);
                            DOCS.setFqn(ref file_FullName);
                            DOCS.setSourcename(ref file_SourceName);
                            DOCS.setSourcetypecode(ref file_SourceTypeCode);
                            DOCS.setLastaccessdate(ref file_LastAccessDate);
                            DOCS.setCreatedate(ref file_CreateDate);
                            DOCS.setCreationdate(ref file_CreateDate);
                            DOCS.setLastwritetime(ref file_LastWriteTime);
                            DOCS.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
                            string argval4 = "0";
                            DOCS.setVersionnbr(ref argval4);
                            BB = DOCS.Insert(SourceGuid, CrcHash);
                            if (BB)
                            {
                                LOG.WriteToListenLog("ArchiveSingleFile : FILE added to repo 100: " + file_FullName);
                                Successful = true;
                                saveContentOwner(SourceGuid, modGlobals.gCurrUserGuidID, "C", FOLDER_FQN, MachineID, modGlobals.gNetworkID);

                                // Dim WC  = DOCS.wc_UKI_Documents(SourceGuid)
                                // DOCS.ImageUpdt_SourceImage(WC, file_FullName)
                                // ****************************************************************************************************************************************************************************************************************
                                BB = UpdateSourceFileImage(file_FullName, UID, MachineID, SourceGuid, file_LastAccessDate, file_CreateDate, file_LastWriteTime, LastVerNbr, file_FullName, RetentionCode, isPublic, CrcHash);
                                // ****************************************************************************************************************************************************************************************************************

                                if (!BB)
                                {
                                    string MySql = "Delete from DataSource where SourceGuid = '" + SourceGuid + "'";
                                    ExecuteSqlNewConn(90214, MySql);
                                    LOG.WriteToErrorLog("Unrecoverable Error - removed file '" + file_FullName + "' from the repository.");
                                    string DisplayMsg = "A source file failed to load. Review ERROR log.";
                                    My.MyProject.Forms.frmHelp.MsgToDisplay = DisplayMsg;
                                    My.MyProject.Forms.frmHelp.CallingScreenName = "ECM Archive";
                                    My.MyProject.Forms.frmHelp.CaptionName = "Fatal Load Error";
                                    My.MyProject.Forms.frmHelp.Timer1.Interval = 10000;
                                    My.MyProject.Forms.frmHelp.Show();
                                }
                            }
                            else
                            {
                                LOG.WriteToListenLog("Error 22.345.23a - Failed to add source:" + file_FullName);
                                Successful = false;
                            }

                            file_FullName = UTIL.RemoveSingleQuotes(file_FullName);
                            file_SourceName = UTIL.RemoveSingleQuotes(file_SourceName);
                        }

                        if (BB)
                        {
                            FilesBackedUp += 1;
                            file_FullName = UTIL.RemoveSingleQuotes(file_FullName);
                            file_SourceName = UTIL.RemoveSingleQuotes(file_SourceName);
                            UpdateDocCrc(SourceGuid, CrcHash);
                            bool bIsImageFile = isImageFile(file_FullName);
                            UpdateCurrArchiveStats(file_FullName, file_SourceTypeCode);
                        }
                        else
                        {
                            FilesSkipped += 1;
                            if (ddebug)
                                LOG.WriteToListenLog("ERROR File : " + file_FullName + " was found to be NEW and was NOT ADDED to the repository.");
                            if (ddebug)
                                LOG.WriteToListenLog("ERROR File : " + file_FullName + " was found to be NEW and was NOT ADDED to the repository.");
                            Debug.Print("FAILED TO LOAD: " + file_FullName);
                            if (ddebug)
                                LOG.WriteToListenLog("ArchiveSingleFile : AddSourceToRepo :FAILED TO LOAD: 8013a: " + file_SourceName);
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
                            if (ddebug)
                                LOG.WriteToListenLog("ArchiveSingleFile : AddSourceToRepo :Success: 8015");
                            if (!isZipFile)
                            {
                                // Dim TheFileIsArchived As Boolean = True
                                // DMA.setFileArchiveAttributeSet(file_FullName , TheFileIsArchived)
                                DMA.setArchiveBitOff(file_FullName);
                            }

                            // delFileParms(SourceGuid )

                            UpdateDocCrc(SourceGuid, CrcHash);

                            // ** Removed Attribution Classification by WDM 9/10/2009
                            UpdateSrcAttrib(SourceGuid, "CRC", CrcHash, OriginalFileType);
                            UpdateSrcAttrib(SourceGuid, "FILENAME", file_SourceName, OriginalFileType);
                            UpdateSrcAttrib(SourceGuid, "CreateDate", file_CreateDate, OriginalFileType);
                            UpdateSrcAttrib(SourceGuid, "FILESIZE", file_Length, OriginalFileType);
                            UpdateSrcAttrib(SourceGuid, "ChangeDate", file_LastAccessDate, OriginalFileType);
                            UpdateSrcAttrib(SourceGuid, "WriteDate", file_LastWriteTime, OriginalFileType);

                            // AddMachineSource(file_FullName, SourceGuid)

                            if (Conversion.Val(file_Length) > 1000000000d)
                            {
                                try
                                {
                                }
                                // FrmMDIMain.SB4.Text = "Extreme File: " + file_Length  + " bytes - standby"
                                catch (Exception ex)
                                {
                                }
                            }
                            else if (Conversion.Val(file_Length) > 2000000d)
                            {
                                try
                                {
                                }
                                // FrmMDIMain.SB4.Text = "Large File: " + file_Length  + " bytes"
                                catch (Exception ex)
                                {
                                }
                            }

                            if (Strings.LCase(file_SourceTypeCode).Equals(".mp3") | Strings.LCase(file_SourceTypeCode).Equals(".wma") | Strings.LCase(file_SourceTypeCode).Equals("wma"))
                            {
                                MP3.getRecordingMetaData(file_FullName, SourceGuid, file_SourceTypeCode);
                                Application.DoEvents();
                            }
                            else if (Strings.LCase(file_SourceTypeCode).Equals(".tiff") | Strings.LCase(file_SourceTypeCode).Equals(".jpg"))
                            {
                                // ** This functionality will be added at a later time
                                // KAT.getXMPdata(file_FullName)
                                Application.DoEvents();
                            }
                            else if (Strings.LCase(file_SourceTypeCode).Equals(".png") | Strings.LCase(file_SourceTypeCode).Equals(".gif"))
                            {
                                // ** This functionality will be added at a later time
                                // KAT.getXMPdata(file_FullName)
                                Application.DoEvents();
                            }
                            // ElseIf LCase(file_SourceTypeCode).Equals(".wav") Then
                            // MP3.getRecordingMetaData(file_FullName, SourceGuid, file_SourceTypeCode)
                            else if (Strings.LCase(file_SourceTypeCode).Equals(".wma"))
                            {
                                MP3.getRecordingMetaData(file_FullName, SourceGuid, file_SourceTypeCode);
                            }
                            else if (Strings.LCase(file_SourceTypeCode).Equals(".tif"))
                            {
                                // ** This functionality will be added at a later time
                                // KAT.getXMPdata(file_FullName)
                                Application.DoEvents();
                            }

                            Application.DoEvents();
                            if ((Strings.LCase(file_SourceTypeCode).Equals(".doc") | Strings.LCase(file_SourceTypeCode).Equals(".docx")) & ckMetaData.Equals("Y"))

                            {
                                GetWordDocMetadata(file_FullName, SourceGuid, OriginalFileType);
                                GC.Collect();
                            }

                            if ((file_SourceTypeCode.Equals(".xls") | file_SourceTypeCode.Equals(".xlsx") | file_SourceTypeCode.Equals(".xlsm")) & ckMetaData.Equals("Y"))


                            {
                                GetExcelMetaData(file_FullName, SourceGuid, OriginalFileType);
                                GC.Collect();
                            }
                        }

                        NextFile:
                        ;
                        if (Successful == true)
                        {
                            FQN = UTIL.RemoveSingleQuotes(FQN);
                            DirName = UTIL.RemoveSingleQuotes(DirName);
                            string tFqn = DirName + @"\" + FQN;
                            tFqn = UTIL.RemoveSingleQuotes(tFqn);
                            S = "";      // " update DirectoryListenerFiles set Archived =  1 where DirGuid = '" + DirGuid + "' and MachineID = '" + MachineID + "' and sourceFile = '" + FQN + "' "
                                         // S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = '" + FQN + "' and MachineID = '" + MachineID + "'"
                            DBLocal.MarkListenersProcessed(FQN);
                            // Dim B As Boolean = ExecuteSqlNewConn(90217,S)
                            // If Not B Then
                            // LOG.WriteToListenLog("ERROR: ArchiveSingleFile: failed to archive: " + DirName + " \ " + FQN)
                            // End If
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

                        if (ckSkipIfArchived == true & file_SourceName is object)
                        {
                            DMA.setArchiveBitOff(file_FullName);
                        }

                        if (Successful == true)
                        {
                            LOG.WriteToListenLog("SUCCCESS: ArchiveSingleFile: 01 " + DirName + @" \ " + FQN);
                            FQN = UTIL.RemoveSingleQuotes(FQN);
                            DirName = UTIL.RemoveSingleQuotes(DirName);
                            string tFqn = DirName + @"\" + FQN;
                            tFqn = UTIL.RemoveSingleQuotes(tFqn);
                            S = "";         // " update DirectoryListenerFiles set Archived =  1 where DirGuid = '" + DirGuid + "' and MachineID = '" + MachineID + "' and sourceFile = '" + FQN + "' "
                            S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = '" + FQN + "' and MachineName = '" + MachineID + "'";
                            bool B = ExecuteSqlNewConn(90218, S);
                            if (!B)
                            {
                                LOG.WriteToListenLog("ERROR: ArchiveSingleFile: failed to archive: " + DirName + @" \ " + FQN);
                            }
                        }
                    }
                }
                else
                {
                    if (ddebug)
                        Debug.Print("Duplicate Folder: " + FolderName);
                    if (ddebug)
                        LOG.WriteToListenLog("ArchiveSingleFile : AddSourceToRepo :Success: 8034");
                }

                NextFolder:
                ;
                pFolder = FolderName;
                if (modGlobals.gTerminateImmediately)
                {
                    DOCS = null;
                    PROC = null;
                    return;
                }

                if (Successful == true)
                {
                    LOG.WriteToListenLog("SUCCCESS: ArchiveSingleFile: 02 " + DirName + @" \ " + FQN);
                    FQN = UTIL.RemoveSingleQuotes(FQN);
                    DirName = UTIL.RemoveSingleQuotes(DirName);
                    string tFqn = DirName + @"\" + FQN;
                    tFqn = UTIL.RemoveSingleQuotes(tFqn);
                    S = "";             // " update DirectoryListenerFiles set Archived =  1 where DirGuid = '" + DirGuid + "' and MachineID = '" + MachineID + "' and sourceFile = '" + FQN + "' "
                    S = "update [DirectoryListenerFiles] set Archived = 1 where sourcefile = '" + FQN + "' and MachineName = '" + MachineID + "'";
                    bool B = ExecuteSqlNewConn(90219, S);
                    if (!B)
                    {
                        LOG.WriteToListenLog("ERROR: ArchiveSingleFile: failed to archive: " + DirName + @" \ " + FQN);
                    }
                }
            }

            PROC.getProcessesToKill();
            PROC.KillOrphanProcesses();
            DOCS = null;
            PROC = null;
            SKIPOUT:
            ;

            // If Successful = True Then
            // Dim S  = " update DirectoryListenerFiles set Archived =  1 where DirGuid = '" + DirGuid + "' and MachineID = '" + MachineID + "' and sourceFile = '" + FQN + "' "
            // Dim B As Boolean = ExecuteSqlNewConn(90220,S)
            // If Not B Then
            // LOG.WriteToListenLog("ERROR: ArchiveSingleFile: failed to archive: " + DirName + " \ " + FQN)
            // End If
            // End If
            My.MyProject.Forms.frmNotify.lblPdgPages.Text = "*";
        }

        public bool isDirInLibrary(string DirFQN, ref string ParentDirLibName)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string TgtLib = "";
            string TempDir = "";
            string SS = "";
            if (DirFQN.Trim().Length > 2)
            {
                if (Strings.Mid(DirFQN, 1, 2) == @"\\")
                {
                    SS = @"\\";
                }
                else
                {
                    SS = "";
                }
            }

            var DirList = new List<string>();
            var A = DirFQN.Split('\\');
            for (int I = 0, loopTo = Information.UBound(A); I <= loopTo; I++)
            {
                TempDir = SS + TempDir + A[I];
                DirList.Add(TempDir);
                TempDir = TempDir + @"\";
            }

            for (int II = DirList.Count - 1; II >= 0; II -= 1)
            {
                TempDir = DirList[II];
                TempDir = UTIL.RemoveSingleQuotes(TempDir);

                // Dim iCnt As Integer = iCount("Select COUNT(*) from LibDirectory where DirectoryName = '" + TempDir + "' and UserID = '" + gCurrUserGuidID + "'")
                string S = "Select COUNT(*) from LibDirectory where DirectoryName = '" + TempDir + "'";
                int iCnt = iCount(S);
                if (iCnt > 0)
                {
                    ParentDirLibName = TempDir;
                    return true;
                }

                TempDir = TempDir + @"\";
            }

            ParentDirLibName = "";
            return false;
        }

        public bool ExtractWinmail(string FQN, ref List<string> AttachedFiles)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            try
            {
                int iCnt = 0;
                string AppPath = AppDomain.CurrentDomain.BaseDirectory;
                string WinMail = AppPath + "WINMAIL";
                string ConversionDir = LOG.getEnvVarSpecialFolderLocalApplicationData() + @"\WMCONVERT";
                if (!Directory.Exists(ConversionDir))
                {
                    Directory.CreateDirectory(ConversionDir);
                }

                if (!File.Exists(FQN))
                {
                    return false;
                }

                var P = new Process();
                Process.Start(WinMail + @"\wmopener.exe", Conversions.ToString('"') + FQN + Conversions.ToString('"') + " " + Conversions.ToString('"') + ConversionDir + Conversions.ToString('"'));
                P.WaitForExit();

                // ShellandWait(WinMail, ConversionDir)

                getDirFiles(ConversionDir, ref AttachedFiles);
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
                LOG.WriteToArchiveLog("ERROR: ExtractWinmail - " + ex.Message);
            }

            return default;
        }

        public void ShellandWait(string WinMail, string ConversionDir)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string Executable = WinMail + @"\wmopener.exe";
            Process objProcess;
            try
            {
                objProcess = new Process();
                // objProcess.StartInfo.FileName = ProcessPath
                objProcess.StartInfo.WindowStyle = ProcessWindowStyle.Minimized;
                Process.Start(Executable, Conversions.ToString('"') + FQN + Conversions.ToString('"') + " " + Conversions.ToString('"') + ConversionDir + Conversions.ToString('"'));

                // Wait until the process passes back an exit code
                objProcess.WaitForExit();

                // Free resources associated with this process
                objProcess.Close();
            }
            catch
            {
                if (modGlobals.gRunUnattended == false)
                    MessageBox.Show("Could not start process " + WinMail + @"\wmopener.exe", "Error");
                LOG.WriteToArchiveLog("ERROR ShellandWait " + "Could not start process " + Executable);
            }
            finally
            {
                objProcess = null;
            }
        }

        public void getDirFiles(string dirFqn, ref List<string> AttachedFiles)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            foreach (var myFile in Directory.GetFiles(dirFqn, "*.*"))
                AttachedFiles.Add(myFile);
        }

        private void MoveItemsToFolder(Outlook.MailItem oMsg)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            Outlook.Folder targetFolder;
            var oMAPI = default(Outlook._NameSpace);
            try
            {
                targetFolder = (Outlook.Folder)oMAPI.GetFolderFromID(modGlobals.oHistoryEntryID, modGlobals.oHistoryStoreID);
                oMsg.Move(targetFolder);
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR MoveItemsToFolder 100 " + oMsg.Subject.ToString());
            }
            finally
            {
                targetFolder = null;
                oMAPI = null;
            }
        }

        // If the folder doesn't exist, there will be an error in the next line. That error will cause the
        // error handler to go to :handleError and skip the True return value
        public bool HistoryFolderExists()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            int LL = 0;
            try
            {
                string FolderName = "ECM_History";
                LL = 1;
                var oApp = new Outlook.Application();
                LL = 1;
                var oNS = oApp.GetNamespace("MAPI");
                LL = 1;
                var myInbox = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderInbox);
                LL = 1;
                myInbox = myInbox.Folders[FolderName];
                LL = 1;
                oApp = null;
                oNS = null;
                myInbox = null;
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("NOTICE: HistoryFolderExists - " + LL.ToString() + " : " + ex.Message);
            }

            return default;
        }

        public bool MoveToHistoryFolder(Outlook.MailItem oMsg)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string FolderName = "ECM_History";
            Outlook.MailItem currentMessage;
            string errorReport;
            var oApp = new Outlook.Application();
            var oNS = oApp.GetNamespace("MAPI");
            var myInbox = oNS.GetDefaultFolder(Outlook.OlDefaultFolders.olFolderInbox);
            try
            {
                oMsg.Move(myInbox.Folders[FolderName]);
                LOG.WriteToArchiveLog("Notification: Moved email to history - Subject '" + oMsg.Subject + "' sent on " + oMsg.SentOn.ToString());
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR MoveToFolder 100 " + oMsg.Subject.ToString());
            }
            finally
            {
                oApp = null;
                oNS = null;
                myInbox = null;
            }

            return default;
        }

        public DateTime getLastContactArchiveDate()
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var LastWriteDate = DateTime.Parse("1900-01-01");
            try
            {
                string cPath = LOG.getTempEnvironDir();
                string TempFolder = cPath + @"\LastContactDate";
                if (Directory.Exists(TempFolder))
                {
                }
                else
                {
                    Directory.CreateDirectory(TempFolder);
                }

                string FName = "LastContactArchiveDate.TXT";
                string FQN = TempFolder + @"\" + FName;
                if (!File.Exists(FQN))
                {
                    // Create an instance of StreamWriter to write text to a file.
                    using (var sw = new StreamWriter(FQN, false))
                    {
                        sw.WriteLine(LastWriteDate.ToString());
                        sw.Close();
                    }
                }
                else
                {
                    using (var SR = new StreamReader(FQN))
                    {
                        string sLastWriteDate = "";
                        sLastWriteDate = SR.ReadLine();
                        LastWriteDate = Conversions.ToDate(sLastWriteDate);
                        SR.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
                LastWriteDate = DateTime.Parse("1900-01-01");
            }

            return LastWriteDate;
        }

        public void saveLastContactArchiveDate(string LastArchiveDate)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            try
            {
                string cPath = LOG.getTempEnvironDir();
                string TempFolder = cPath + @"\LastContactDate";
                if (Directory.Exists(TempFolder))
                {
                }
                else
                {
                    Directory.CreateDirectory(TempFolder);
                }

                string FName = "LastContactArchiveDate.TXT";
                string FQN = TempFolder + @"\" + FName;
                using (var sw = new StreamWriter(FQN, false))
                {
                    sw.WriteLine(LastArchiveDate);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR clsArchiver : Failed to save last Contact Archive Date: 688 : " + ex.Message);
            }
        }

        public void PullRssData(string RssUrl)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var ds = new DataSet();
            ds.ReadXml(RssUrl);
            DataGrid dgRss = null;
            // Dim ds As DataSet = New DataSet()
            // ds.ReadXml(RssUrl, XmlReadMode.Auto)

            // Put it in a datagrid
            dgRss.DataSource = ds.Tables[0];
            dgRss.Refresh();
            GC.Collect();
        }

        private string SQLString(string strSQL, int intLength)
        {
            strSQL = Strings.Replace(strSQL, "'", "''");
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
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var client = new System.Net.WebClient();
            string RssText = "";
            var rss = new Chilkat.Rss();
            bool success;

            // Download from the feed URL:
            // success = rss.DownloadRss("http://blog.chilkatsoft.com/?feed=rss2")
            success = rss.DownloadRss(strURL);
            if (success != true)
            {
                Interaction.MsgBox(rss.LastErrorText);
                return;
            }

            // Get the 1st channel.
            Chilkat.Rss rssChannel;
            rssChannel = rss.GetChannel(0);
            if (rssChannel is null)
            {
                Interaction.MsgBox("No channel found in RSS feed.");
                return;
            }

            // Display the various pieces of information about the channel:
            RssText = RssText + "Title: " + rssChannel.GetString("title") + Constants.vbCrLf;
            RssText = RssText + "Link: " + rssChannel.GetString("link") + Constants.vbCrLf;
            RssText = RssText + "Description: " + rssChannel.GetString("description") + Constants.vbCrLf;

            // For each item in the channel, display the title, link, publish date, and categories
            // assigned to the post.
            long numItems;
            numItems = rssChannel.NumItems;
            long i;
            var loopTo = numItems - 1L;
            for (i = 0L; i <= loopTo; i++)
            {
                Chilkat.Rss rssItem;
                rssItem = rssChannel.GetItem((int)i);
                string sTitle = rssItem.GetString("title");
                string sLink = rssItem.GetString("link");
                string sPubDate = rssItem.GetString("pubDate");
                Console.WriteLine("sTitle: " + sTitle);
                Console.WriteLine("sLink: " + sLink);
                Console.WriteLine("sPubDate: " + sPubDate);
                string ScrappedData = client.DownloadString(sLink);
                // Console.WriteLine("ScrappedData: " + ScrappedData)

                long numCategories;
                numCategories = rssItem.GetCount("category");
                long j;
                if (numCategories > 0L)
                {
                    var loopTo1 = numCategories - 1L;
                    for (j = 0L; j <= loopTo1; j++)
                    {
                        string SCategory = rssItem.MGetString("category", (int)j);
                        Console.WriteLine("SCategory: " + SCategory);
                    }
                }
            }
        }

        public void spiderWeb(string uriString, int MaxUrlsToSpider, int MaxOutboundLinks, string isPublic, string retentionCode)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            var SpiderInfo = new frmNotify2();
            SpiderInfo.Show();
            SpiderInfo.Text = "WEB Archiver";
            var spider = new Chilkat.Spider();
            var seenDomains = new Chilkat.StringArray();
            var seedUrls = new Chilkat.StringArray();
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

            // Set outbound URL exclude patterns
            // URLs matching any of these patterns will not be added to the
            // collection of outbound links.
            // spider.AddAvoidOutboundLinkPattern("*?id=*")
            // spider.AddAvoidOutboundLinkPattern("*.mypages.*")
            // spider.AddAvoidOutboundLinkPattern("*.personal.*")
            // spider.AddAvoidOutboundLinkPattern("*.comcast.*")
            // spider.AddAvoidOutboundLinkPattern("*.aol.*")
            // spider.AddAvoidOutboundLinkPattern("*~*")

            string CacheDir = LOG.getEnvVarSpecialFolderApplicationData() + @"\SpiderCache".Replace(@"\\", @"\");
            string WEBProcessingDir = System.Configuration.ConfigurationManager.AppSettings["WEBProcessingDir"];
            if (!Directory.Exists(CacheDir))
            {
                Directory.CreateDirectory(CacheDir);
            }
            // Use a cache so we don't have to re-fetch URLs previously fetched.
            // spider.CacheDir = "c:/spiderCache/"
            spider.CacheDir = CacheDir;
            spider.FetchFromCache = true;
            spider.UpdateCache = true;
            while (seedUrls.Count > 0)
            {
                string url;
                url = seedUrls.Pop();
                spider.Initialize(url);

                // Spider 5 URLs of this domain. but first, save the base domain in seenDomains
                string domain;
                domain = spider.GetDomain(url);
                seenDomains.Append(spider.GetBaseDomain(domain));
                long i;
                bool success;
                var loopTo = (long)(MaxUrlsToSpider - 1);
                for (i = 0L; i <= loopTo; i++)
                {
                    success = spider.CrawlNext();
                    if (success != true)
                    {
                        break;
                    }

                    // Display the URL we just crawled.
                    currProcessedUrl = spider.LastUrl;
                    allProcessedUrl += currProcessedUrl + " | ";
                    Application.DoEvents();
                    string kw = spider.LastHtmlKeywords;
                    string LastModDate = spider.LastModDateStr;
                    if (LastModDate.Length == 0)
                    {
                        LastModDate = "01/01/1970 12:01 AM";
                    }
                    else
                    {
                        Console.WriteLine(LastModDate);
                    }

                    string LastDesc = spider.LastHtmlDescription;
                    string PageTitle = spider.LastHtmlTitle;
                    string FQN = domain + "@" + PageTitle + ".HTML";
                    string WebFQN = "";
                    int idx = currProcessedUrl.IndexOf("//");
                    if (idx > 0)
                    {
                        WebFQN = currProcessedUrl.Substring(idx + 2);
                    }

                    string PageHtml = spider.LastHtml;
                    int iLen = PageHtml.Trim().Length;
                    SpiderInfo.lblEmailMsg.Text = domain;
                    SpiderInfo.lblMsg2.Text = currProcessedUrl;
                    double DBL = iLen / 1000d;
                    SpiderInfo.lblFolder.Text = "Size: " + DBL.ToString() + " Kb - " + i.ToString() + " of " + MaxUrlsToSpider.ToString();
                    SpiderInfo.Refresh();
                    Application.DoEvents();
                    if (Directory.Exists(WEBProcessingDir))
                    {
                        Console.WriteLine(WEBProcessingDir + " created and ready.");
                    }
                    else
                    {
                        Directory.CreateDirectory(WEBProcessingDir);
                    }

                    if (iLen > 0)
                    {
                        WebFQN = "";
                        WebFQN = UTIL.ConvertUrlToFQN(WEBProcessingDir, currProcessedUrl, ".HTML") + WebFQN;
                        var outfile = new StreamWriter(WebFQN, false);
                        outfile.Write(PageHtml);
                        outfile.Close();
                        outfile.Dispose();
                        if (ChildSourceGuid.Trim().Length > 0 & !ParentSourceGuidSet)
                        {
                            ParentSourceGuid = ChildSourceGuid;
                            ParentSourceGuidSet = true;
                        }

                        if (isPublic.ToLower().Equals("true"))
                        {
                            isPublic = "Y";
                        }

                        ChildSourceGuid = ArchiveWebPage(ParentSourceGuid, PageTitle, currProcessedUrl, WebFQN, retentionCode, isPublic, Conversions.ToDate(LastModDate));
                        try
                        {
                            File.Delete(FQN);
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine("Failed to delete 0C: " + FQN);
                        }
                    }

                    // If the last URL was retrieved from cache, we won't wait. Otherwise we'll wait 1
                    // second before fetching the next URL.
                    if (spider.LastFromCache != true)
                    {
                        spider.SleepMs(500);
                    }
                }

                // Add the outbound links to seedUrls, except for the domains we've already seen.
                var loopTo1 = (long)(spider.NumOutboundLinks - 1);
                for (i = 0L; i <= loopTo1; i++)
                {
                    url = spider.GetOutboundLink((int)i);
                    domain = spider.GetDomain(url);
                    string baseDomain;
                    baseDomain = spider.GetBaseDomain(domain);
                    if (!seenDomains.Contains(baseDomain))
                    {
                        seedUrls.Append(url);
                    }

                    // Don't let our list of seedUrls grow too large.
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
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + MethodBase.GetCurrentMethod().ToString());
            }

            string S = "";
            TextReader tr = new StreamReader(FQN);
            S = tr.ReadToEnd();
            tr.Dispose();
            GC.Collect();
            GC.WaitForPendingFinalizers();
            return S;
        }
    }
}
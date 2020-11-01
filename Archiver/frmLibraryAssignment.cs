using System;
using System.Windows.Forms;
using Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public partial class frmLibraryAssignment
    {
        public frmLibraryAssignment()
        {
            InitializeComponent();
            _btnAssign.Name = "btnAssign";
            _btnRemove.Name = "btnRemove";
        }

        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsLogging LOG = new clsLogging();
        private clsUtility UTIL = new clsUtility();
        private bool isEmail = false;
        private string tgtLibName = "";
        private string FolderID = "";
        private clsLIBEMAIL EmailLib = new clsLIBEMAIL();
        private clsLIBDIRECTORY ContentLib = new clsLIBDIRECTORY();
        public string FolderName = "";
        private bool bHelpLoaded = false;
        private bool formloaded = false;

        private void frmLibraryAssignment_Load(object sender, EventArgs e)
        {
            formloaded = false;
            modResizeForm.GetLocation(this);
            if (modGlobals.HelpOn)
            {
                Form argfrm = this;
                var argTT = TT;
                DBARCH.getFormTooltips(ref argfrm, ref argTT, true);
                TT = argTT;
                TT.Active = true;
                bHelpLoaded = true;
            }
            else
            {
                TT.Active = false;
            }
            // Dim bGetScreenObjects As Boolean = True
            // If bGetScreenObjects Then DMA.getFormWidgets(Me)

            PopulateLibraryCombo();
            if (FolderID.Length > 0)
            {
                FolderName = DBARCH.getFolderNameById(FolderID);
            }

            PopulateAssignedLibraryCombo();
            formloaded = true;
        }

        public void setLibraryName(string LibName)
        {
            tgtLibName = LibName;
            cbLibrary.Text = tgtLibName;
        }

        public void setFolderID(string MailFolderID)
        {
            FolderID = MailFolderID;
        }

        public void setFolderName(string tFolderName)
        {
            txtFolderName.Text = tFolderName.Trim();
            FolderName = tFolderName.Trim();
        }

        public void PopulateLibraryCombo()
        {
            try
            {
                string S = "";
                S = S + " SELECT [LibraryName]";
                S = S + " FROM  [Library]";
                S = S + " where userid = '" + modGlobals.gCurrUserGuidID + "'";
                S = S + " order by [LibraryName]";
                var argCB = cbLibrary;
                DBARCH.PopulateComboBox(ref argCB, "LibraryName", S);
                cbLibrary = argCB;
            }
            catch (Exception ex)
            {
                SB.Text = "Failed to load Libraries.";
            }
        }

        public void PopulateAssignedLibraryCombo()
        {
            string S = "";
            string FolderName = txtFolderName.Text.Trim();
            cbAssignedLibs.Items.Clear();
            cbAssignedLibs.Text = "";
            if (isEmail)
            {
                S = S + " SELECT  [LibraryName]";
                S = S + " FROM  [LibEmail]";
                S = S + " where [FolderName] = '" + FolderName + "'";
                var argCB = cbAssignedLibs;
                DBARCH.PopulateComboBox(ref argCB, "LibraryName", S);
                cbAssignedLibs = argCB;
            }
            else
            {
                S = S + " SELECT  [LibraryName]";
                S = S + " FROM  [LibDirectory]";
                S = S + " where [DirectoryName] = '" + FolderName + "'";
                var argCB1 = cbAssignedLibs;
                DBARCH.PopulateComboBox(ref argCB1, "LibraryName", S);
                cbAssignedLibs = argCB1;
            }
        }

        public void SetTypeContent(bool isDocument)
        {
            if (isDocument == true)
            {
                isEmail = false;
            }
            else
            {
                isEmail = true;
            }
        }

        private void btnAssign_Click(object sender, EventArgs e)
        {
            string LibToAdd = cbLibrary.Text;
            FolderName = txtFolderName.Text.Trim();
            int RecordsAdded = 0;
            if (isEmail)
            {
                string FolderID = DBARCH.getFolderIdByName(FolderName, modGlobals.gCurrUserGuidID);
                if (FolderID.Length == 0)
                {
                    MessageBox.Show("Could not find Mailbox " + FolderName + " as an archived folder, skipping.");
                    return;
                }

                EmailLib.setEmailfolderentryid(ref FolderID);
                EmailLib.setLibraryname(ref LibToAdd);
                EmailLib.setUserid(ref modGlobals.gCurrUserGuidID);
                EmailLib.setFoldername(ref FolderName);
                // ***************************************
                bool b = EmailLib.Insert();
                // ***************************************
                if (b)
                {
                    PopulateAssignedLibraryCombo();
                    DBARCH.AddLibraryEmail(FolderName, LibToAdd, modGlobals.gCurrUserGuidID, RecordsAdded);
                    string LID = DBARCH.getUserLoginByUserid(modGlobals.gCurrUserGuidID);
                    string tMsg = "User '" + LID + "' assigned EMAIL Folder '" + txtFolderName.Text.Trim() + "' to library '" + LibToAdd + "' on " + DateAndTime.Now.ToString() + ".";
                    DBARCH.AddSysMsg(tMsg);
                    LOG.WriteToArchiveLog(tMsg);
                    MessageBox.Show("Added email folder to library...");
                }
                else
                {
                    MessageBox.Show("ERROR: DID NOT Add email folder to library...");
                    string LID = DBARCH.getUserLoginByUserid(modGlobals.gCurrUserGuidID);
                    string tMsg = "ERROR: 3302.1.y - User '" + LID + "' failed to assign EMAIL Folder '" + txtFolderName.Text.Trim() + "' to library '" + LibToAdd + "' on " + DateAndTime.Now.ToString() + ".";
                    DBARCH.AddSysMsg(tMsg);
                    LOG.WriteToArchiveLog(tMsg);
                }
            }
            else
            {
                ContentLib.setDirectoryname(ref txtFolderName.Text.Trim());
                ContentLib.setLibraryname(ref LibToAdd);
                ContentLib.setUserid(ref modGlobals.gCurrUserGuidID);
                // *******************************************
                bool b = ContentLib.Insert();
                // *******************************************

                bool bProcessSubDirs = DBARCH.isSubDirProcessed(modGlobals.gCurrUserGuidID, txtFolderName.Text.Trim());
                if (b)
                {
                    PopulateAssignedLibraryCombo();
                    DBARCH.AddLibraryDirectory(txtFolderName.Text.Trim(), LibToAdd, modGlobals.gCurrUserGuidID, ref RecordsAdded, bProcessSubDirs);
                    string LID = DBARCH.getUserLoginByUserid(modGlobals.gCurrUserGuidID);
                    string tMsg = "User '" + LID + "' assigned directory '" + txtFolderName.Text.Trim() + "' to library '" + LibToAdd + "' on " + DateAndTime.Now.ToString() + ".";
                    DBARCH.AddSysMsg(tMsg);
                    LOG.WriteToArchiveLog(tMsg);
                }
                else
                {
                    MessageBox.Show("ERROR: DID NOT Add content folder to library...");
                    string LID = DBARCH.getUserLoginByUserid(modGlobals.gCurrUserGuidID);
                    string tMsg = "ERROR: 3302.1.x - User '" + LID + "' failed to assign directory '" + txtFolderName.Text.Trim() + "' to library '" + LibToAdd + "' on " + DateAndTime.Now.ToString() + ".";
                    LOG.WriteToArchiveLog(tMsg);
                    DBARCH.AddSysMsg(tMsg);
                }
            }

            string LibName = LibToAdd;
            LibName = UTIL.RemoveSingleQuotes(LibName);
            string S = "Select count(*) from LibraryItems where LibraryName like '" + LibName + "' ";
            int iCnt = DBARCH.iCount(S);
            SB.Text = "Records in library: " + iCnt.ToString();
        }

        private void btnRemove_Click(object sender, EventArgs e)
        {
            Cursor = Cursors.AppStarting;
            string LibToRemove = cbAssignedLibs.Text.Trim();
            LibToRemove = UTIL.RemoveSingleQuotes(LibToRemove);
            if (isEmail)
            {
                FolderName = UTIL.RemoveSingleQuotes(FolderName);
                // Dim FolderName As String = Me.txtFolderName.Text.Trim
                FolderID = DBARCH.getFolderIdByName(FolderName, modGlobals.gCurrUserGuidID);
                string wc = EmailLib.wc_PK99(FolderName, cbAssignedLibs.Text, modGlobals.gCurrUserGuidID);
                bool b = EmailLib.Delete(wc);
                int II = EmailLib.cnt_PI01_LibEmail(FolderName, LibToRemove);

                // Dim Mysql As String = ""
                // Mysql = "delete from LibEmail where LibraryName = '" + LibToRemove  + "'"
                // b = DBARCH.ExecuteSqlNewConn(Mysql)

                // Mysql = "delete from LibraryItems where LibraryName = '" + LibToRemove  + "'"
                // b = DBARCH.ExecuteSqlNewConn(Mysql)

                if (b)
                {
                    MessageBox.Show("Removed email folder from library... applying changes across the repository, this can take a long while.");
                    DBARCH.RemoveLibraryEmails(txtFolderName.Text.Trim(), LibToRemove, modGlobals.gCurrUserGuidID);
                    string LID = DBARCH.getUserLoginByUserid(modGlobals.gCurrUserGuidID);
                    string tMsg = "Notice: 3302.2.y - User '" + LID + "' removed EMAIL Folder '" + txtFolderName.Text.Trim() + "' from library '" + LibToRemove + "' on " + DateAndTime.Now.ToString() + ".";
                    DBARCH.AddSysMsg(tMsg);
                    LOG.WriteToArchiveLog(tMsg);
                    PopulateAssignedLibraryCombo();
                }
                else
                {
                    MessageBox.Show("ERROR: DID NOT Remove email folder to library...");
                    string LID = DBARCH.getUserLoginByUserid(modGlobals.gCurrUserGuidID);
                    string tMsg = "Notice: 3302.2.x - User '" + LID + "' FAILED to assign EMAIL Folder '" + txtFolderName.Text.Trim() + "' to library '" + LibToRemove + "' on " + DateAndTime.Now.ToString() + ".";
                    DBARCH.AddSysMsg(tMsg);
                    LOG.WriteToArchiveLog(tMsg);
                }
            }
            else
            {
                string wc = ContentLib.wc_PK98(txtFolderName.Text.Trim(), LibToRemove, modGlobals.gCurrUserGuidID);
                bool b = ContentLib.Delete(wc);

                // Dim Mysql As String = ""
                // Mysql = "delete from LibraryItems where LibraryName = '" + LibToRemove  + "'"
                // b = DBARCH.ExecuteSqlNewConn(Mysql)

                // Mysql = "delete from LibDirectory where LibraryName = '" + LibToRemove  + "'"
                // b = DBARCH.ExecuteSqlNewConn(Mysql)

                if (b)
                {
                    MessageBox.Show("Removed content folder from library... applying changes across the repository, this can take a long while.");
                    DBARCH.RemoveLibraryDirectories(txtFolderName.Text.Trim(), LibToRemove);
                    string LID = DBARCH.getUserLoginByUserid(modGlobals.gCurrUserGuidID);
                    string tMsg = "Notice: 3303.2.y - User '" + LID + "' assigned Content Folder '" + txtFolderName.Text.Trim() + "' from library '" + LibToRemove + "' on " + DateAndTime.Now.ToString() + ".";
                    DBARCH.AddSysMsg(tMsg);
                    LOG.WriteToArchiveLog(tMsg);
                    PopulateAssignedLibraryCombo();
                }
                else
                {
                    MessageBox.Show("ERROR: DID NOT Remove ontent folder to library...");
                    string LID = DBARCH.getUserLoginByUserid(modGlobals.gCurrUserGuidID);
                    string tMsg = "Notice: 3303.2.y - User '" + LID + "' FAILED to remove Content Folder '" + txtFolderName.Text.Trim() + "' from library '" + LibToRemove + "' on " + DateAndTime.Now.ToString() + ".";
                    DBARCH.AddSysMsg(tMsg);
                    LOG.WriteToArchiveLog(tMsg);
                }
            }

            DBARCH.cleanUpLibraryItems();
            Cursor = Cursors.Default;
        }

        private void frmLibraryAssignment_Resize(object sender, EventArgs e)
        {
            if (formloaded == false)
                return;
            Form argfrm = this;
            modResizeForm.ResizeControls(ref argfrm);
        }
    }
}
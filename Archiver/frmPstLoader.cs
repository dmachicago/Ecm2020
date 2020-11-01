using System;
using System.Collections;
using global::System.IO;
using System.Windows.Forms;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public partial class frmPstLoader
    {
        public frmPstLoader()
        {
            InitializeComponent();
            _txtPstFqn.Name = "txtPstFqn";
            _btnSelectFile.Name = "btnSelectFile";
            _btnLoad.Name = "btnLoad";
            _btnArchive.Name = "btnArchive";
            _btnRemove.Name = "btnRemove";
        }

        private clsLogging LOG = new clsLogging();
        private clsPst PST = new clsPst();
        private clsDbLocal DBLocal = new clsDbLocal();
        private bool ArchiveEmails = false;
        public string UID = "";
        public static int CurrIdNbr = 1000000;
        public static ProcessFolders[] FoldersToProcess;

        // Sub New(ByVal UserGuidID As String)
        // UID = UserGuidID
        // End Sub

        public struct ProcessFolders
        {
            public Microsoft.Office.Interop.Outlook.MAPIFolder oFolder;
            public int iKey;
        }

        private void btnSelectFile_Click(object sender, EventArgs e)
        {
            SB.Visible = false;
            lbMsg.Visible = false;
            btnLoad.Visible = false;
            Label2.Visible = false;
            txtFoldersProcessed.Visible = false;
            Label3.Visible = false;
            txtEmailsProcessed.Visible = false;
            btnArchive.Visible = false;
            Label4.Visible = false;
            cbRetention.Visible = false;
            OpenFileDialog1.ShowDialog();
            txtPstFqn.Text = OpenFileDialog1.FileName;
        }

        private void btnLoad_Click(object sender, EventArgs e)
        {
            try
            {
                lbMsg.Visible = true;
                btnLoad.Visible = true;
                Label2.Visible = false;
                txtFoldersProcessed.Visible = false;
                Label3.Visible = false;
                txtEmailsProcessed.Visible = false;
                btnArchive.Visible = true;
                Label4.Visible = true;
                cbRetention.Visible = true;
                ArchiveEmails = false;
                string pName = "Test";
                string PstFQN = txtPstFqn.Text.Trim();
                File F;
                if (!File.Exists(PstFQN))
                {
                    MessageBox.Show("Cannot find file '" + PstFQN + "', aborting load.");
                    return;
                }

                var arglbMsg = lbMsg;
                PST.PstStats(ref arglbMsg, PstFQN, pName, ArchiveEmails);
                lbMsg = arglbMsg;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error: PST Load error - " + ex.Message);
                LOG.WriteToArchiveLog("Error: PST Load error - " + ex.Message);
            }
        }

        private void btnArchive_Click(object sender, EventArgs e)
        {
            if (cbLibrary.Text.Trim().Length == 0)
            {
                MessageBox.Show("In order to ARCHIVE a PST file, a library must be selected, returning.");
                return;
            }

            if (cbRetention.Text.Trim().Length == 0)
            {
                MessageBox.Show("Please select a retention period, returning.");
                return;
            }

            lbMsg.Visible = true;
            btnLoad.Visible = true;
            Label2.Visible = true;
            txtFoldersProcessed.Visible = true;
            Label3.Visible = true;
            txtEmailsProcessed.Visible = true;
            btnArchive.Visible = true;
            string PstFQN = txtPstFqn.Text.Trim();
            string RetentionCode;
            if (lbMsg.SelectedItems.Count == 0)
            {
                MessageBox.Show("Cannot process without FOLDERS being selected, returning.");
                return;
            }

            if (PstFQN.Length == 0)
            {
                MessageBox.Show("Cannot process without a PST file being selected, returning.");
                return;
            }

            string rCode = cbRetention.Text.Trim();
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
            PST.ArchiveSelectedFolders(UID, lbMsg, PstFQN, rCode, cbLibrary.Text, slStoreId);
            My.MyProject.Forms.frmMain.SB.Text = "Done";
            SB.Text = "Done";
        }

        private void frmPstLoader_Deactivate(object sender, EventArgs e)
        {
            // PST.RemoveStores()
        }

        private void frmPstLoader_Disposed(object sender, EventArgs e)
        {
            PST.RemoveStores();
        }

        private void frmPstLoader_Load(object sender, EventArgs e)
        {
            lbMsg.Visible = false;
            btnLoad.Visible = false;
            Label2.Visible = false;
            txtFoldersProcessed.Visible = false;
            Label3.Visible = false;
            txtEmailsProcessed.Visible = false;
            btnArchive.Visible = false;
            Label4.Visible = false;
            cbRetention.Visible = false;
            var ARCH = new clsArchiver();
            var argCB = cbRetention;
            ARCH.LoadRetentionCodes(ref argCB);
            cbRetention = argCB;
            ARCH = null;
            if (cbRetention.Items.Count > 0)
            {
                cbRetention.Text = Conversions.ToString(cbRetention.Items[0]);
            }

            PopulateLibrary();
        }

        private void txtPstFqn_TextChanged(object sender, EventArgs e)
        {
            lbMsg.Visible = false;
            btnLoad.Visible = true;
            Label2.Visible = false;
            txtFoldersProcessed.Visible = false;
            Label3.Visible = false;
            txtEmailsProcessed.Visible = false;
            btnArchive.Visible = false;
            SB.Visible = true;
        }

        public void PopulateLibrary()
        {
            var DBARCH = new clsDatabaseARCH();
            Cursor = Cursors.WaitCursor;
            DBARCH.PopulateGroupUserLibCombo(cbLibrary);
            Cursor = Cursors.Default;
            DBARCH = null;
        }

        private void btnRemove_Click(object sender, EventArgs e)
        {
            PST.RemoveStores();
        }
    }
}
using System;
using System.Collections;
using System.Data;
using global::System.Data.SqlClient;
using System.Diagnostics;
using System.Windows.Forms;
using Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public partial class frmSenderMgt
    {
        public frmSenderMgt()
        {
            InitializeComponent();
            _btnRefresh.Name = "btnRefresh";
            _rbContacts.Name = "rbContacts";
            _btnExclSender.Name = "btnExclSender";
            _rbInbox.Name = "rbInbox";
            _rbArchive.Name = "rbArchive";
            _btnRemoveExcluded.Name = "btnRemoveExcluded";
        }

        private clsArchiver ARCH = new clsArchiver();
        private string UserID = "";
        private string MySql = "";
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private DataSet ds = new DataSet();
        private SqlConnection cn = new SqlConnection();
        private clsEXCLUDEFROM EF = new clsEXCLUDEFROM();
        private bool bHelpLoaded = false;
        private bool Formloaded = false;

        private void frmSenderMgt_Load(object sender, EventArgs e)
        {
            Formloaded = false;
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

            Timer1.Enabled = true;
            Timer1.Interval = 5000;

            // Dim bGetScreenObjects As Boolean = True
            // If bGetScreenObjects Then DMA.getFormWidgets(Me)

            // 'TODO: This line of code loads data into the '_DMA_UDDataSet3.ArchiveFrom' table. You can move, or remove it, as needed.
            // Me.ArchiveFromTableAdapter.Fill(Me._DMA_UDDataSet3.ArchiveFrom)
            // 'TODO: This line of code loads data into the '_DMA_UDDataSet.ExcludeFrom' table. You can move, or remove it, as needed.
            // Me.ExcludeFromTableAdapter.Fill(Me._DMA_UDDataSet.ExcludeFrom)
            // MySql  = ""
            // MySql  = MySql  + " SELECT [FromEmailAddr] "
            // MySql  = MySql  + " ,[SenderName] "
            // MySql  = MySql  + " ,[UserID] "
            // MySql  = MySql  + " FROM  [ExcludeFrom] "
            // MySql  = MySql  + " where [UserID] = '" + gCurrUserGuidID + "' "
            // MySql  = MySql  + " order by  "
            // MySql  = MySql  + " FromEmailAddr "
            // MySql  = MySql  + " ,[SenderName] "
            // MySql  = MySql  + " ,[UserID] "

            // Dim qConnStr  = DBARCH.getConnStr

            // cn.ConnectionString = qConnStr 
            // cn.Open()

            // Dim dscmd As New SqlDataAdapter(MySql, cn)

            // dscmd.Fill(ds, "Senders")
            // dgExcludedSenders.DataSource = ds.DefaultViewManager

            var argCB = cbOutlookFOlder;
            ARCH.getOutlookParentFolderNames(ref argCB);
            cbOutlookFOlder = argCB;
            TT.SetToolTip(btnRemoveExcluded, "Press this button to remove the selected address from the 'exclude list'.");
            TT.Active = true;
            ARCH.PopulateExcludedSendersFromTbl(dgExcludedSenders);
            Formloaded = true;
        }

        private void btnRemoveExcluded_Click(object sender, EventArgs e)
        {
            int II = 0;
            var loopTo = dgExcludedSenders.RowCount - 1;
            for (II = 0; II <= loopTo; II++)
            {
                if (dgExcludedSenders.Rows[II].Selected)
                {
                    string SenderEmailAddress = dgExcludedSenders[0, II].Value.ToString();
                    string SenderName = dgExcludedSenders[1, II].Value.ToString();
                    string UID = dgExcludedSenders[2, II].Value.ToString();
                    SenderEmailAddress = UTIL.RemoveSingleQuotes(SenderEmailAddress);
                    SenderName = UTIL.RemoveSingleQuotes(SenderName);
                    UID = UTIL.RemoveSingleQuotes(UID);
                    string S = "Select count(*) ";
                    S = S + " FROM  [ExcludeFrom]";
                    S = S + " where [FromEmailAddr] = '" + SenderEmailAddress + "'";
                    S = S + " and [SenderName] = '" + SenderName + "'";
                    S = S + " and [UserID] = '" + UID + "'";
                    int K = DBARCH.iDataExist(S);
                    if (K == 1)
                    {
                        S = "delete ";
                        S = S + " FROM  [ExcludeFrom]";
                        S = S + " where [FromEmailAddr] = '" + SenderEmailAddress + "'";
                        S = S + " and [SenderName] = '" + SenderName + "'";
                        S = S + " and [UserID] = '" + UID + "'";
                        bool BB = DBARCH.ExecuteSqlNewConn(S, false);
                        if (!BB)
                        {
                            MessageBox.Show("Error 243.1: Delete failed - " + Constants.vbCrLf + S);
                        }
                    }
                }
            }

            ARCH.PopulateExcludedSendersFromTbl(dgExcludedSenders);
            DBARCH.getExcludedEmails(modGlobals.gCurrUserGuidID);
        }

        private void btnRemoveIncluded_Click(object sender, EventArgs e)
        {
        }

        private void btnInclSender_Click(object sender, EventArgs e)
        {
        }

        private void btnExclSender_Click(object sender, EventArgs e)
        {
            int II = 0;
            var loopTo = dgEmailSenders.RowCount - 1;
            for (II = 0; II <= loopTo; II++)
            {
                if (dgEmailSenders.Rows[II].Selected)
                {
                    string SenderEmailAddress = dgEmailSenders[0, II].Value.ToString();
                    string SenderName = dgEmailSenders[1, II].Value.ToString();
                    string UID = dgEmailSenders[2, II].Value.ToString();
                    SenderEmailAddress = UTIL.RemoveSingleQuotes(SenderEmailAddress);
                    SenderName = UTIL.RemoveSingleQuotes(SenderName);
                    UID = UTIL.RemoveSingleQuotes(UID);
                    string S = "Select count(*)";
                    S = S + " FROM  [ExcludeFrom]";
                    S = S + " where [FromEmailAddr] = '" + SenderEmailAddress + "'";
                    S = S + " and [SenderName] = '" + SenderName + "'";
                    S = S + " and [UserID] = '" + UID + "'";
                    int K = DBARCH.iDataExist(S);
                    if (K == 0)
                    {
                        EF.setFromemailaddr(ref SenderEmailAddress);
                        EF.setSendername(ref SenderName);
                        EF.setUserid(ref UID);
                        bool BB = EF.Insert();
                        if (!BB)
                        {
                            MessageBox.Show("Error 243.1: Insert failed - " + Constants.vbCrLf + S);
                        }
                    }
                }
            }

            ARCH.PopulateExcludedSendersFromTbl(dgExcludedSenders);
            DBARCH.getExcludedEmails(modGlobals.gCurrUserGuidID);
        }

        private void rbArchive_CheckedChanged(object sender, EventArgs e)
        {
            if (rbArchive.Checked == true)
            {
                string S = "";
                S = "Select distinct [SenderEmailAddress]";
                S = S + " ,[SenderName]      ";
                S = S + " FROM [Email]";
                S = S + " order by [SenderEmailAddress]";
                S = S + " ,[SenderName]      ";
                ARCH.PopulateContactGrid(dgEmailSenders, S);
            }
        }

        private void rbContacts_CheckedChanged(object sender, EventArgs e)
        {
            if (rbContacts.Checked == true)
            {
                // MySql  = ""
                // MySql  = MySql  + " SELECT [FromEmailAddr] "
                // MySql  = MySql  + " ,[SenderName] "
                // MySql  = MySql  + " ,[UserID] "
                // MySql  = MySql  + " FROM  [ContactFrom] "
                // MySql  = MySql  + " where [UserID] = '" + gCurrUserGuidID + "' "
                // MySql  = MySql  + " order by  "
                // MySql  = MySql  + " FromEmailAddr "
                // MySql  = MySql  + " ,[SenderName] "
                // MySql  = MySql  + " ,[UserID] "

                string S = "";
                S = S + " SELECT FromEmailAddr ,[SenderName]   ";
                S = S + " FROM  [ContactFrom]  ";
                S = S + " order by FromEmailAddr ,[SenderName]  ";
                ARCH.PopulateContactGrid(dgEmailSenders, S);
            }
        }

        private void ExcludeFromBindingSource_CurrentChanged(object sender, EventArgs e)
        {
        }

        private void rbInbox_CheckedChanged(object sender, EventArgs e)
        {
            if (rbInbox.Checked)
            {
                // MySql  = ""
                // MySql  = MySql  + " SELECT [FromEmailAddr] "
                // MySql  = MySql  + " ,[SenderName] "
                // MySql  = MySql  + " ,[UserID] "
                // MySql  = MySql  + " FROM  [OutlookFrom] "
                // MySql  = MySql  + " where [UserID] = '" + gCurrUserGuidID + "' "
                // MySql  = MySql  + " order by  "
                // MySql  = MySql  + " FromEmailAddr "
                // MySql  = MySql  + " ,[SenderName] "
                // MySql  = MySql  + " ,[UserID] "

                string S = "";
                S = "Select FromEmailAddr ,[SenderName]";
                S = S + " FROM  [OutlookFrom]  ";
                S = S + " order by FromEmailAddr ,[SenderName]";
                ARCH.PopulateContactGrid(dgEmailSenders, S);
            }
        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            string FileDirectory = cbOutlookFOlder.Text;
            if (rbInbox.Checked)
            {
                if (cbOutlookFOlder.Text.Trim().Length == 0)
                {
                    MessageBox.Show("Please select an OUTLOOK mailbox first.");
                    return;
                }

                var SL = new SortedList();
                string TopFolder = cbOutlookFOlder.Text;
                var LB = new ListBox();
                string SenderFrom = "";
                string SenderName = "";
                int k = 0;
                MySql = MySql + " Update  [OutlookFrom]";
                MySql = MySql + " set [Verified] = 0 ";
                MySql = MySql + " where ";
                MySql = MySql + " UserID = '" + modGlobals.gCurrUserGuidID + "'";
                bool bSuccess = DBARCH.ExecuteSqlNewConn(MySql, false);
                if (!bSuccess)
                {
                    Debug.Print("Update failed:" + Constants.vbCrLf + MySql);
                }

                ARCH.ProcessOutlookFolderNames(FileDirectory, TopFolder, ref LB);
                // ARCH.GetActiveEmailSenders(gCurrUserGuidID, MailboxName )
                // ARCH.PopulateContactGridOutlookFromTbl(dgEmailSenders)

            }

            if (rbArchive.Checked == true)
            {
                string S = "";
                S = "Select distinct [SenderEmailAddress]";
                S = S + " ,[SenderName]      ";
                S = S + " FROM [Email]";
                S = S + " order by [SenderEmailAddress]";
                S = S + " ,[SenderName]      ";
                ARCH.PopulateContactGrid(dgEmailSenders, S);
            }

            if (rbContacts.Checked == true)
            {
                MySql = MySql + " Update  [ContactFrom]";
                MySql = MySql + " set [Verified] = 0 ";
                MySql = MySql + " where ";
                MySql = MySql + " UserID = '" + modGlobals.gCurrUserGuidID + "'";
                bool bSuccess = DBARCH.ExecuteSqlNewConn(MySql, false);
                if (!bSuccess)
                {
                    Debug.Print("Update failed:" + Constants.vbCrLf + MySql);
                }

                ARCH.RetrieveContactEmailInfo(dgEmailSenders, modGlobals.gCurrUserGuidID);
                ARCH.PopulateContactGridContactFromTbl(dgEmailSenders);
                // ARCH.GetActiveEmailSenders(gCurrUserGuidID, "Personal Folders")
            }

            DBARCH.getExcludedEmails(modGlobals.gCurrUserGuidID);
        }

        private void Timer1_Tick(object sender, EventArgs e)
        {

            // If HelpOn Then
            // If bHelpLoaded Then
            // TT.Active = True
            // Else
            // DBARCH.getFormTooltips(Me, TT, True)
            // TT.Active = True
            // bHelpLoaded = True
            // End If
            // Else
            // TT.Active = False
            // End If
            // Application.DoEvents()
        }

        private void frmSenderMgt_Resize(object sender, EventArgs e)
        {
            if (Formloaded == false)
                return;
            Form argfrm = this;
            modResizeForm.ResizeControls(ref argfrm);
        }
    }
}
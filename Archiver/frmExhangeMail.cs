using System;
using System.Diagnostics;
using System.Drawing;
using System.Windows.Forms;
using global::ECMEncryption;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public partial class frmExhangeMail
    {
        public frmExhangeMail()
        {
            InitializeComponent();
            _dgExchange.Name = "dgExchange";
            _ckDeleteAfterDownload.Name = "ckDeleteAfterDownload";
            _ckIMap.Name = "ckIMap";
            _btnAdd.Name = "btnAdd";
            _btnUpdate.Name = "btnUpdate";
            _btnDelete.Name = "btnDelete";
            _btnTest.Name = "btnTest";
            _btnTestConnection.Name = "btnTestConnection";
            _btnShoaAllLib.Name = "btnShoaAllLib";
            _btnEncrypt.Name = "btnEncrypt";
            _HelpToolStripMenuItem.Name = "HelpToolStripMenuItem";
            _ECMLibraryExchangeInterfaceToolStripMenuItem1.Name = "ECMLibraryExchangeInterfaceToolStripMenuItem1";
            _Exchange2007Vs2003ToolStripMenuItem.Name = "Exchange2007Vs2003ToolStripMenuItem";
            _ExchnageJournalingToolStripMenuItem.Name = "ExchnageJournalingToolStripMenuItem";
            _SamplePOPMailScreenToolStripMenuItem.Name = "SamplePOPMailScreenToolStripMenuItem";
            _SampleIMAPSSLScreenToolStripMenuItem.Name = "SampleIMAPSSLScreenToolStripMenuItem";
            _SampleIMAPScreenToolStripMenuItem.Name = "SampleIMAPScreenToolStripMenuItem";
            _SamplePOPSSLMailScreenToolStripMenuItem.Name = "SamplePOPSSLMailScreenToolStripMenuItem";
            _SampleCorporateEmailScreenToolStripMenuItem.Name = "SampleCorporateEmailScreenToolStripMenuItem";
            _btnReset.Name = "btnReset";
            _ckExcg2003.Name = "ckExcg2003";
            _ckExcg2007.Name = "ckExcg2007";
            _ComplianceOverviewToolStripMenuItem.Name = "ComplianceOverviewToolStripMenuItem";
            _ExchangeJournalingToolStripMenuItem.Name = "ExchangeJournalingToolStripMenuItem";
            _POPMailToolStripMenuItem.Name = "POPMailToolStripMenuItem";
            _IMAPSSLToolStripMenuItem.Name = "IMAPSSLToolStripMenuItem";
            _IMAPToolStripMenuItem.Name = "IMAPToolStripMenuItem";
            _POPSSLToolStripMenuItem.Name = "POPSSLToolStripMenuItem";
            _StandardCoporateToolStripMenuItem.Name = "StandardCoporateToolStripMenuItem";
        }

        private bool FormLoaded = false;
        private clsEXCHANGEHOSTPOP POP = new clsEXCHANGEHOSTPOP();
        private clsDma DMA = new clsDma();
        private ECMEncrypt ENC = new ECMEncrypt();
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDataGrid DG = new clsDataGrid();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private string HostNameIp = "";
        private string UserLoginID = "";
        private string LoginPw = "";
        private string SSL = "";
        private string PortNbr = "";
        private string DeleteAfterDownload = "";
        private string RetentionCode = "";
        private string IMap = "";
        private string Userid = "";
        private string FolderName = "";
        private string LibraryName = "";
        private int DaysToHold;
        private bool RedemptionDllExists = false;

        private void frmExhangeMail_Load(object sender, EventArgs e)
        {
            FormLoaded = false;
            RedemptionDllExists = modDLL.ckDLLAvailable("redemption.dll");
            PopulateExchangeGrid();
            var argCB = cbRetention;
            DBARCH.LoadRetentionCodes(ref argCB);
            cbRetention = argCB;
            PopUserCombo();
            PopulateLibraryCombo();
            if (RedemptionDllExists == true)
            {
                ckConvertEmlToMsg.Enabled = true;
                SB.Text = "Note: Available";
            }
            else
            {
                ckConvertEmlToMsg.Enabled = false;
                SB.Text = "Note: Required DLL missing";
            }

            ResetScreenWidgets();
            FormLoaded = true;
        }

        public void ResetScreenWidgets()
        {
            FormLoaded = false;
            txtUserLoginID.Text = "";
            txtPw.Text = "";
            cbHostName.Text = "";
            txtPortNumber.Text = "";
            ckSSL.Checked = false;
            ckIMap.Checked = false;
            ckDeleteAfterDownload.Checked = false;
            txtPortNumber.Text = "";
            txtFolderName.Text = "";
            cbRetention.Text = "";
            cbUsers.Text = "";
            cbLibrary.Text = "";
            ckPublic.Checked = false;
            ckConvertEmlToMsg.Checked = false;
            SB.Text = "";
            txtUserID.Text = "";
            FormLoaded = true;
        }

        public void PopulateLibraryCombo()
        {

            // DBARCH.PopulateLibCombo(cbLibrary)
            Cursor = Cursors.WaitCursor;
            DBARCH.PopulateGroupUserLibCombo(cbLibrary);
            Cursor = Cursors.Default;
        }

        public void PopUserCombo()
        {
            string S = "";
            S = S + " SELECT [UserLoginID]";
            S = S + "FROM  [Users]";
            S = S + "order by [UserLoginID]";
            var argCB = cbUsers;
            DBARCH.PopulateComboBox(ref argCB, "UserLoginID", S);
            cbUsers = argCB;
        }

        public void ShowAll()
        {
            if (!modGlobals.isAdmin)
            {
                SB.Text = "You must be an ADMIN to execute this function.";
                return;
            }

            string S = "";
            S = S + " SELECT [HostNameIp]";
            S = S + " ,[UserLoginID]";
            S = S + " ,[LoginPw]";
            S = S + " ,[SSL]";
            S = S + " ,[PortNbr]";
            S = S + " ,[DeleteAfterDownload]";
            S = S + " ,[RetentionCode]";
            S = S + " ,[IMap]";
            S = S + " ,[Userid], FolderName, LibraryName, DaysToHold, StrReject, ConvertEmlToMSG ";
            S = S + " FROM [ExchangeHostPop] ";
            S = S + " order by [HostNameIp]";
            var argDVG = dgExchange;
            DG.PopulateGrid("ExchangeHostPop", S, ref argDVG);
            dgExchange = argDVG;
        }

        public void PopulateExchangeGrid()
        {
            string S = "";
            if (modGlobals.gCurrLoginID.ToUpper().Equals("SERVICEMANAGER"))
            {
                S = S + " SELECT [HostNameIp]";
                S = S + " ,[UserLoginID]";
                S = S + " ,[LoginPw]";
                S = S + " ,[SSL]";
                S = S + " ,[PortNbr]";
                S = S + " ,[DeleteAfterDownload]";
                S = S + " ,[RetentionCode]";
                S = S + " ,[IMap]";
                S = S + " ,[Userid], FolderName, LibraryName, DaysToHold, StrReject, ConvertEmlToMSG";
                S = S + " FROM [ExchangeHostPop] ";
                S = S + " where UserID = '" + modGlobals.gCurrUserGuidID + "'";
                S = S + " order by [HostNameIp]";
            }
            // ElseIf isAdmin Then
            // S = S + " SELECT [HostNameIp]"
            // S = S + " ,[UserLoginID]"
            // S = S + " ,[LoginPw]"
            // S = S + " ,[SSL]"
            // S = S + " ,[PortNbr]"
            // S = S + " ,[DeleteAfterDownload]"
            // S = S + " ,[RetentionCode]"
            // S = S + " ,[IMap]"
            // S = S + " ,[Userid], FolderName, LibraryName, DaysToHold, StrReject, ConvertEmlToMSG "
            // S = S + " FROM [ExchangeHostPop] "
            // S = S + " order by [HostNameIp]"
            else
            {
                S = S + " SELECT [HostNameIp]";
                S = S + " ,[UserLoginID]";
                S = S + " ,[LoginPw]";
                S = S + " ,[SSL]";
                S = S + " ,[PortNbr]";
                S = S + " ,[DeleteAfterDownload]";
                S = S + " ,[RetentionCode]";
                S = S + " ,[IMap]";
                S = S + " ,[Userid], FolderName, LibraryName, DaysToHold, StrReject, ConvertEmlToMSG";
                S = S + " FROM [ExchangeHostPop] ";
                S = S + " where UserID = '" + modGlobals.gCurrUserGuidID + "'";
                S = S + " order by [HostNameIp]";
            }

            var argDVG = dgExchange;
            DG.PopulateGrid("ExchangeHostPop", S, ref argDVG);
            dgExchange = argDVG;
        }

        public void PopulateExchangeComboBox()
        {
            string S = "";
            if (modGlobals.isAdmin)
            {
                S = S + " SELECT distinct [HostNameIp] FROM [ExchangeHostPop]         ";
                S = S + " order by [HostNameIp]";
            }
            else
            {
                S = S + " SELECT distinct [HostNameIp] FROM [ExchangeHostPop]         ";
                S = S + " where UserID = '" + modGlobals.gCurrUserGuidID + "'";
                S = S + " order by [HostNameIp]";
            }

            var argCB = cbHostName;
            DBARCH.PopulateComboBox(ref argCB, "HostNameIp", S);
            cbHostName = argCB;
        }

        private void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                if (cbHostName.Text.Trim().Length == 0)
                {
                    MessageBox.Show("Please supply a Host Name or IP.");
                    return;
                }

                if (cbRetention.Text.Trim().Length == 0)
                {
                    MessageBox.Show("Please supply a Retention Code.");
                    return;
                }

                if (txtPw.Text.Trim().Length == 0)
                {
                    MessageBox.Show("Please supply a password.");
                    return;
                }

                if (txtUserLoginID.Text.Trim().Length == 0)
                {
                    MessageBox.Show("Please supply a user login ID.");
                    return;
                }

                if (txtReject.Text.Trim().Length > 0)
                {
                    string sReject = txtReject.Text.Trim();
                    sReject = UTIL.RemoveSingleQuotes(sReject);
                }

                POP.setReject(ref txtReject.Text.Trim());
                POP.setUserid(ref modGlobals.gCurrUserGuidID);
                if (ckDeleteAfterDownload.Checked == true)
                {
                    string argval = "1";
                    POP.setDeleteafterdownload(ref argval);
                }
                else
                {
                    string argval1 = "0";
                    POP.setDeleteafterdownload(ref argval1);
                }

                string argval2 = cbHostName.Text;
                POP.setHostnameip(ref argval2);
                cbHostName.Text = argval2;
                if (ckIMap.Checked == true)
                {
                    string argval3 = "1";
                    POP.setImap(ref argval3);
                }
                else
                {
                    string argval4 = "0";
                    POP.setImap(ref argval4);
                }

                bool argval5 = ckPublic.Checked;
                POP.setLibrary(ref argval5);
                ckPublic.Checked = argval5;
                string argval6 = cbLibrary.Text;
                POP.setLibrary(ref argval6);
                cbLibrary.Text = argval6;
                POP.setLoginpw(ref txtPw.Text.Trim());
                POP.setPortnbr(ref txtPortNumber.Text.Trim());
                string argval7 = cbRetention.Text;
                POP.setRetentioncode(ref argval7);
                cbRetention.Text = argval7;
                int argval8 = (int)nbrDaysToRetain.Value;
                POP.setDaysToHold(ref argval8);
                nbrDaysToRetain.Value = argval8;
                if (ckSSL.Checked == true)
                {
                    string argval9 = "1";
                    POP.setSsl(ref argval9);
                }
                else
                {
                    string argval10 = "0";
                    POP.setSsl(ref argval10);
                }

                string tUserID = DBARCH.getUserGuidID(cbUsers.Text);
                if (tUserID.Trim().Length == 0)
                {
                    tUserID = modGlobals.gCurrUserGuidID;
                }

                POP.setUserid(ref tUserID);
                if (txtFolderName.Text.Trim().Length == 0)
                {
                    txtFolderName.Text = "NA";
                }

                POP.setFolderName(ref txtFolderName.Text.Trim());
                POP.setUserloginid(ref txtUserLoginID.Text.Trim());
                bool argval11 = ckConvertEmlToMsg.Checked;
                POP.setConvertEmlToMsg(ref argval11);
                ckConvertEmlToMsg.Checked = argval11;
                bool b = POP.Insert();
                if (!b)
                {
                    SB.Text = "Failed to add new Exchange record.";
                }
                else
                {
                    SB.Text = "Added new Exchange record.";
                    PopulateExchangeGrid();
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR frmExhangeMail:btnAdd_Click - " + ex.Message);
            }
        }

        private void dgExchange_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            getGridData();
        }

        private void dgExchange_MouseDown(object sender, MouseEventArgs e)
        {
            if (e.Button == MouseButtons.Right)
            {
                if (e.Button == MouseButtons.Right)
                {
                    // ContextHandler(Me.dgDoc, e)
                    var PNT = new Point();
                    PNT.X = e.X;
                    PNT.Y = e.Y;
                    int X = e.X;
                    int Y = e.Y;
                    Debug.Print(X.ToString() + "," + Y.ToString());
                    // ContextMenuStrip1.Show(Me, PNT)
                    // ContextMenuStrip1.Show(Me, 100, 100)
                    ContextMenuStrip1.Show(dgExchange, X, Y);
                }
            }
        }

        private void dgExchange_SelectionChanged(object sender, EventArgs e)
        {
            getGridData();
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            int icnt = dgExchange.SelectedRows.Count;
            if (icnt != 1)
            {
                MessageBox.Show("Please select one and only one item to update.");
                return;
            }

            if (cbHostName.Text.Trim().Length == 0)
            {
                MessageBox.Show("Please supply a Host Name or IP.");
                return;
            }

            if (cbRetention.Text.Trim().Length == 0)
            {
                MessageBox.Show("Please supply a Retention Code.");
                return;
            }

            if (txtPw.Text.Trim().Length == 0)
            {
                MessageBox.Show("Please supply a password.");
                return;
            }

            if (txtUserLoginID.Text.Trim().Length == 0)
            {
                MessageBox.Show("Please supply a user login ID.");
                return;
            }

            POP.setReject(ref txtReject.Text.Trim());
            int argval = (int)nbrDaysToRetain.Value;
            POP.setDaysToHold(ref argval);
            nbrDaysToRetain.Value = argval;
            string argval1 = txtUserID.Text;
            POP.setUserid(ref argval1);
            txtUserID.Text = argval1;
            if (ckDeleteAfterDownload.Checked == true)
            {
                string argval2 = "1";
                POP.setDeleteafterdownload(ref argval2);
            }
            else
            {
                string argval3 = "0";
                POP.setDeleteafterdownload(ref argval3);
            }

            string argval4 = cbHostName.Text;
            POP.setHostnameip(ref argval4);
            cbHostName.Text = argval4;
            if (ckIMap.Checked == true)
            {
                string argval5 = "1";
                POP.setImap(ref argval5);
            }
            else
            {
                string argval6 = "0";
                POP.setImap(ref argval6);
            }

            POP.setLoginpw(ref txtPw.Text.Trim());
            POP.setPortnbr(ref txtPortNumber.Text.Trim());
            string argval7 = cbRetention.Text;
            POP.setRetentioncode(ref argval7);
            cbRetention.Text = argval7;
            if (ckSSL.Checked == true)
            {
                string argval8 = "1";
                POP.setSsl(ref argval8);
            }
            else
            {
                string argval9 = "0";
                POP.setSsl(ref argval9);
            }

            string tUserID = DBARCH.getUserGuidID(cbUsers.Text);
            if (tUserID.Trim().Length == 0)
            {
                tUserID = modGlobals.gCurrUserGuidID;
            }

            POP.setUserid(ref modGlobals.gCurrUserGuidID);
            POP.setUserloginid(ref txtUserLoginID.Text.Trim());
            Userid = txtUserID.Text;
            POP.setFolderName(ref txtFolderName.Text.Trim());
            bool argval10 = ckPublic.Checked;
            POP.setLibrary(ref argval10);
            ckPublic.Checked = argval10;
            string argval11 = cbLibrary.Text;
            POP.setLibrary(ref argval11);
            cbLibrary.Text = argval11;
            bool argval12 = ckConvertEmlToMsg.Checked;
            POP.setConvertEmlToMsg(ref argval12);
            ckConvertEmlToMsg.Checked = argval12;
            bool b = POP.Update(HostNameIp, Userid, UserLoginID);
            if (!b)
            {
                SB.Text = "Failed to update Exchange record.";
            }
            else
            {
                SB.Text = "Updated Exchange record.";
                PopulateExchangeGrid();
            }
        }

        private void btnDelete_Click(object sender, EventArgs e)
        {
            int icnt = dgExchange.SelectedRows.Count;
            if (icnt != 1)
            {
                MessageBox.Show("Please select one and only one item to update.");
                return;
            }

            if (cbHostName.Text.Trim().Length == 0)
            {
                MessageBox.Show("Please supply a Host Name or IP.");
                return;
            }

            if (cbRetention.Text.Trim().Length == 0)
            {
                MessageBox.Show("Please supply a Retention Code.");
                return;
            }

            if (txtPw.Text.Trim().Length == 0)
            {
                MessageBox.Show("Please supply a password.");
                return;
            }

            if (txtUserLoginID.Text.Trim().Length == 0)
            {
                MessageBox.Show("Please supply a user login ID.");
                return;
            }

            POP.setUserid(ref modGlobals.gCurrUserGuidID);
            if (ckDeleteAfterDownload.Checked == true)
            {
                string argval = "1";
                POP.setDeleteafterdownload(ref argval);
            }
            else
            {
                string argval1 = "0";
                POP.setDeleteafterdownload(ref argval1);
            }

            string argval2 = cbHostName.Text;
            POP.setHostnameip(ref argval2);
            cbHostName.Text = argval2;
            if (ckIMap.Checked == true)
            {
                string argval3 = "1";
                POP.setImap(ref argval3);
            }
            else
            {
                string argval4 = "0";
                POP.setImap(ref argval4);
            }

            POP.setLoginpw(ref txtPw.Text.Trim());
            POP.setPortnbr(ref txtPortNumber.Text.Trim());
            string argval5 = cbRetention.Text;
            POP.setRetentioncode(ref argval5);
            cbRetention.Text = argval5;
            if (ckSSL.Checked == true)
            {
                string argval6 = "1";
                POP.setSsl(ref argval6);
            }
            else
            {
                string argval7 = "0";
                POP.setSsl(ref argval7);
            }

            POP.setUserid(ref modGlobals.gCurrUserGuidID);
            POP.setUserloginid(ref txtUserLoginID.Text.Trim());
            string WC = POP.wc_PK_ExchangeHostPop(HostNameIp, Userid, UserLoginID);
            bool b = POP.Delete(WC);
            if (!b)
            {
                SB.Text = "Failed to delete record A5.";
            }
            else
            {
                SB.Text = "Deleted Exchange record A6.";
                PopulateExchangeGrid();
            }
        }

        public void getGridData()
        {
            try
            {
                int iRow = dgExchange.CurrentRow.Index;
                int iCnt = dgExchange.SelectedRows.Count;
                if (iCnt == 0)
                {
                    return;
                }

                if (iCnt > 1)
                {
                    return;
                }

                HostNameIp = dgExchange.SelectedRows[0].Cells["HostNameIp"].Value.ToString();
                UserLoginID = dgExchange.SelectedRows[0].Cells["UserLoginID"].Value.ToString();
                SSL = dgExchange.SelectedRows[0].Cells["SSL"].Value.ToString();
                PortNbr = dgExchange.SelectedRows[0].Cells["PortNbr"].Value.ToString();
                DeleteAfterDownload = dgExchange.SelectedRows[0].Cells["DeleteAfterDownload"].Value.ToString();
                RetentionCode = dgExchange.SelectedRows[0].Cells["RetentionCode"].Value.ToString();
                IMap = dgExchange.SelectedRows[0].Cells["IMap"].Value.ToString();
                Userid = dgExchange.SelectedRows[0].Cells["Userid"].Value.ToString();
                LoginPw = dgExchange.SelectedRows[0].Cells["LoginPw"].Value.ToString();
                FolderName = dgExchange.SelectedRows[0].Cells["FolderName"].Value.ToString();
                LibraryName = dgExchange.SelectedRows[0].Cells["LibraryName"].Value.ToString();
                DaysToHold = (int)Conversion.Val(dgExchange.SelectedRows[0].Cells["DaysToHold"].Value.ToString());
                txtReject.Text = dgExchange.SelectedRows[0].Cells["strReject"].Value.ToString();
                string tUserLoginID = DBARCH.getUserLoginByUserid(Userid);
                SB.Text = "Execution ID: " + tUserLoginID;
                // 
                string tVal = dgExchange.SelectedRows[0].Cells["ConvertEmlToMSG"].Value.ToString();
                if (tVal.ToUpper().Equals("TRUE"))
                {
                    ckConvertEmlToMsg.Checked = true;
                }
                else
                {
                    ckConvertEmlToMsg.Checked = false;
                }

                if (IMap.ToUpper().Equals("TRUE"))
                {
                    ckIMap.Checked = true;
                }
                else
                {
                    ckIMap.Checked = false;
                }

                if (SSL.ToUpper().Equals("TRUE"))
                {
                    ckSSL.Checked = true;
                }
                else
                {
                    ckSSL.Checked = false;
                }

                cbHostName.Text = HostNameIp;
                txtUserLoginID.Text = UserLoginID;
                // Me.ckSSL.Checked = Val(SSL)
                txtPortNumber.Text = PortNbr;
                if (Conversions.ToBoolean(DeleteAfterDownload) == true)
                {
                    ckDeleteAfterDownload.Checked = true;
                }
                else
                {
                    ckDeleteAfterDownload.Checked = false;
                }

                cbRetention.Text = RetentionCode;
                // Me.ckIMap.Checked = Val(IMap)
                cbUsers.Text = DBARCH.getUserLoginByUserid(Userid);
                txtPw.Text = LoginPw;
                txtUserID.Text = Userid;
                txtFolderName.Text = FolderName.Trim();
                cbLibrary.Text = LibraryName;
                nbrDaysToRetain.Value = DaysToHold;
            }
            catch (Exception ex)
            {
                SB.Text = ex.Message;
            }
        }

        private void btnEncrypt_Click(object sender, EventArgs e)
        {
            if (txtPw.Text.Trim().Length == 0)
            {
                MessageBox.Show("Please supply a password.");
                return;
            }

            string tPw = txtPw.Text.Trim();
            txtPw.Text = ENC.AES256EncryptString(tPw);
        }

        private void ExchnageJournalingToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Exchange2003Journaling.htm
            Process.Start("http://www.ecmlibrary.com/_helpfiles/Exchange2003Journaling.htm");
        }

        private void Exchange2007Vs2003ToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Microsoft Exchange Server 2007 Compliance Tour.htm
            Process.Start("http://www.ecmlibrary.com/_helpfiles/Microsoft Exchange Server 2007 Compliance Tour.htm");
        }

        private void ECMLibraryExchangeInterfaceToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            // ECM Library Exchange Server Journaling Interface.htm
            Process.Start("http://www.ecmlibrary.com/_helpfiles/ECM Library Exchange Server Journaling Interface.htm");
        }

        private void ckIMap_CheckedChanged(object sender, EventArgs e)
        {
            if (ckIMap.Checked)
            {
                txtFolderName.Enabled = true;
            }
            else
            {
                txtFolderName.Enabled = false;
            }
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            if (btnTest.Text.Equals("Show All"))
            {
                ShowAll();
                btnTest.Text = "Show Mine";
            }
            else
            {
                PopulateExchangeGrid();
                btnTest.Text = "Show All";
            }
        }

        private void btnReset_Click(object sender, EventArgs e)
        {
            ResetScreenWidgets();
        }

        private void ckExcg2007_CheckedChanged(object sender, EventArgs e)
        {
            if (ckExcg2007.Checked)
            {
                ckPlainText.Checked = false;
                ckPlainText.Enabled = false;
                ckRtfFormat.Checked = false;
                ckRtfFormat.Enabled = false;
                ckEnvelope.Checked = true;
            }
            else
            {
                ckPlainText.Checked = false;
                ckPlainText.Enabled = true;
                ckRtfFormat.Checked = false;
                ckRtfFormat.Enabled = true;
                ckEnvelope.Checked = true;
            }
        }

        private void ckExcg2003_CheckedChanged(object sender, EventArgs e)
        {
            if (ckExcg2003.Checked == true)
            {
                ckPlainText.Checked = false;
                ckPlainText.Enabled = true;
                ckRtfFormat.Checked = false;
                ckRtfFormat.Enabled = true;
                ckEnvelope.Checked = true;
            }
        }

        private void ckDeleteAfterDownload_CheckedChanged(object sender, EventArgs e)
        {
            if (ckDeleteAfterDownload.Checked)
            {
                // Label9.Visible = False
                nbrDaysToRetain.Enabled = false;
                nbrDaysToRetain.Value = 0m;
            }
            else
            {
                Label9.Visible = true;
                nbrDaysToRetain.Visible = true;
                nbrDaysToRetain.Enabled = true;
            }
        }

        private void btnShoaAllLib_Click(object sender, EventArgs e)
        {
            if (modGlobals.isAdmin)
            {
                DBARCH.PopulateAllUserLibCombo(cbLibrary);
            }
            else
            {
                SB.Text = "Admin authority required for this function.";
            }
        }

        private void btnTestConnection_Click(object sender, EventArgs e)
        {
            var EM = new clsEmailFunctions();
            string MailServerAddr = cbHostName.Text;
            int Portnbr = (int)Conversion.Val(txtPortNumber.Text);
            string UserLoginID = txtUserLoginID.Text;
            string LoginPassWord = txtPw.Text;
            string Msg = "";
            bool B = false;
            if (ckSSL.Checked == true & ckIMap.Checked == true)
            {
                B = EM.ckImapSSLConnection(MailServerAddr, Portnbr, UserLoginID, LoginPassWord);
                if (B)
                {
                    Msg = "Successful login to: " + MailServerAddr;
                }
                else
                {
                    Msg = "FAILED login to: " + MailServerAddr;
                }
            }
            else if (ckSSL.Checked == false & ckIMap.Checked == true)
            {
                B = EM.clIMapConnection(MailServerAddr, Portnbr, UserLoginID, LoginPassWord);
                if (B)
                {
                    Msg = "Successful login to: " + MailServerAddr;
                }
                else
                {
                    Msg = "FAILED login to: " + MailServerAddr;
                }
            }
            else if (ckSSL.Checked == true & ckIMap.Checked == false)
            {
                int iCnt = EM.ckPopSSL(MailServerAddr, Portnbr, UserLoginID, LoginPassWord);
                if (iCnt >= 0)
                {
                    Msg = "Successful login to: " + MailServerAddr + " : " + iCnt.ToString() + " emails on server.";
                }
                else
                {
                    Msg = "FAILED login to: " + MailServerAddr;
                }
            }
            else
            {
                int iCnt = EM.ckPopConnection(MailServerAddr, Portnbr, UserLoginID, LoginPassWord);
                if (iCnt >= 0)
                {
                    Msg = "Successful login to: " + MailServerAddr + " : " + iCnt.ToString() + " emails on server.";
                }
                else
                {
                    Msg = "FAILED login to: " + MailServerAddr;
                }
            }

            EM = null;
            SB.Text = Msg;
        }

        private void SampleIMAPSSLScreenToolStripMenuItem_Click(object sender, EventArgs e)
        {
            cbHostName.Text = "imap.gmail.com";
            txtUserLoginID.Text = "xxx@gmail.com";
            txtPw.Text = "<password>";
            ckSSL.Checked = true;
            ckIMap.Checked = true;
            nbrDaysToRetain.Value = 5m;
            txtPortNumber.Text = 465.ToString();
            txtFolderName.Text = "xxx@gmail.com";
        }

        private void SampleIMAPScreenToolStripMenuItem_Click(object sender, EventArgs e)
        {
            cbHostName.Text = "imap.aol.com";
            txtUserLoginID.Text = "xxx@aol.com";
            txtPw.Text = "<password>";
            ckSSL.Checked = false;
            ckIMap.Checked = true;
            nbrDaysToRetain.Value = 5m;
            txtPortNumber.Text = 143.ToString();
            txtFolderName.Text = "xxx@aol.com";
        }

        private void SamplePOPMailScreenToolStripMenuItem_Click(object sender, EventArgs e)
        {
            cbHostName.Text = "pop.gmail.com";
            txtUserLoginID.Text = "xxx@gmail.com";
            txtPw.Text = "<password>";
            ckSSL.Checked = false;
            ckIMap.Checked = false;
            nbrDaysToRetain.Value = 5m;
            txtPortNumber.Text = 995.ToString();
            txtFolderName.Text = "xxx@gmail.com";
        }

        private void SamplePOPSSLMailScreenToolStripMenuItem_Click(object sender, EventArgs e)
        {
            cbHostName.Text = "pop.gmail.com";
            txtUserLoginID.Text = "xxx@gmail.com";
            txtPw.Text = "<password>";
            ckSSL.Checked = true;
            ckIMap.Checked = false;
            nbrDaysToRetain.Value = 5m;
            txtPortNumber.Text = 110.ToString();
            txtFolderName.Text = "xxx@gmail.com";
        }

        private void SampleCorporateEmailScreenToolStripMenuItem_Click(object sender, EventArgs e)
        {
            cbHostName.Text = "pop.secureserver.net";
            txtUserLoginID.Text = "xUser@EcmLibrary.com";
            txtPw.Text = "<password>";
            ckSSL.Checked = false;
            ckIMap.Checked = false;
            nbrDaysToRetain.Value = 2m;
            txtPortNumber.Text = 110.ToString();
            txtFolderName.Text = "xxx@gmail.com";
        }

        private void HelpToolStripMenuItem_Click(object sender, EventArgs e)
        {
        }

        private void ComplianceOverviewToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Microsoft Exchange Server 2007 Compliance Tour.htm
            Process.Start("http://www.ecmlibrary.com/_helpfiles/Microsoft Exchange Server 2007 Compliance Tour.htm");
        }

        private void ExchangeJournalingToolStripMenuItem_Click(object sender, EventArgs e)
        {
            // Exchange2003Journaling.htm
            Process.Start("http://www.ecmlibrary.com/_helpfiles/Exchange2003Journaling.htm");
        }

        private void POPMailToolStripMenuItem_Click(object sender, EventArgs e)
        {
            cbHostName.Text = "pop.gmail.com";
            txtUserLoginID.Text = "xxx@gmail.com";
            txtPw.Text = "<password>";
            ckSSL.Checked = false;
            ckIMap.Checked = false;
            nbrDaysToRetain.Value = 5m;
            txtPortNumber.Text = 995.ToString();
            txtFolderName.Text = "xxx@gmail.com";
        }

        private void IMAPSSLToolStripMenuItem_Click(object sender, EventArgs e)
        {
            cbHostName.Text = "imap.gmail.com";
            txtUserLoginID.Text = "xxx@gmail.com";
            txtPw.Text = "<password>";
            ckSSL.Checked = true;
            ckIMap.Checked = true;
            nbrDaysToRetain.Value = 5m;
            txtPortNumber.Text = 465.ToString();
            txtFolderName.Text = "INBOX";
        }

        private void IMAPToolStripMenuItem_Click(object sender, EventArgs e)
        {
            cbHostName.Text = "imap.aol.com";
            txtUserLoginID.Text = "xxx@aol.com";
            txtPw.Text = "<password>";
            ckSSL.Checked = false;
            ckIMap.Checked = true;
            nbrDaysToRetain.Value = 5m;
            txtPortNumber.Text = 143.ToString();
            txtFolderName.Text = "INBOX";
        }

        private void POPSSLToolStripMenuItem_Click(object sender, EventArgs e)
        {
            cbHostName.Text = "pop.gmail.com";
            txtUserLoginID.Text = "xxx@gmail.com";
            txtPw.Text = "<password>";
            ckSSL.Checked = true;
            ckIMap.Checked = false;
            nbrDaysToRetain.Value = 5m;
            txtPortNumber.Text = 110.ToString();
            txtFolderName.Text = "xxx@gmail.com";
        }

        private void StandardCoporateToolStripMenuItem_Click(object sender, EventArgs e)
        {
            cbHostName.Text = "pop.secureserver.net";
            txtUserLoginID.Text = "xUser@EcmLibrary.com";
            txtPw.Text = "<password>";
            ckSSL.Checked = false;
            ckIMap.Checked = false;
            nbrDaysToRetain.Value = 2m;
            txtPortNumber.Text = 110.ToString();
            txtFolderName.Text = "xxx@gmail.com";
        }
    }
}
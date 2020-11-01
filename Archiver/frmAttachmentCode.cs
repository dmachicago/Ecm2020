using System;
using System.Data;
using global::System.Data.SqlClient;
using System.Windows.Forms;
using global::ECMEncryption;
using Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public partial class frmAttachmentCode : Form
    {
        public frmAttachmentCode()
        {
            // LOG.WriteToArchiveLog("Starting: frmAttachmentCode")
            // This call is required by the Windows Form Designer.
            InitializeComponent();
            _dgAttachmentCode.Name = "dgAttachmentCode";
            _btnUpdate.Name = "btnUpdate";
            _btnApplyRetentionRule.Name = "btnApplyRetentionRule";
            _btnEncrypt.Name = "btnEncrypt";

            // Add any initialization after the InitializeComponent() call.

        }

        public string ProcessID = "";
        private bool FormLoaded = false;
        public string TBL = "";
        public string S = "";
        public string winTitle = "";
        private ECMEncrypt ENC = new ECMEncrypt();
        private SqlDataAdapter da;
        private SqlCommand SqlCommand1;
        private DataSet DS;
        private SqlCommandBuilder cb;
        private SqlConnection Cn;
        private bool ddebug = true;
        private clsDma DMA = new clsDma();
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsLogging LOG = new clsLogging();
        private clsUtility UTIL = new clsUtility();
        private bool bHelpLoaded = false;

        private void frmAttachmentCode_Deactivate(object sender, EventArgs e)
        {
            if (Text.ToUpper().Equals("POP/IMAP EXCHANGE SERVER SETTINGS"))
            {
                DBARCH.SetExchangeDefaultRetentionCode();
            }
        }

        private void frmAttachmentCode_Disposed(object sender, EventArgs e)
        {
            if (Text.ToUpper().Equals("POP/IMAP EXCHANGE SERVER SETTINGS"))
            {
                DBARCH.SetExchangeDefaultRetentionCode();
            }
        }

        private void frmAttachmentCode_Load(object sender, EventArgs e)
        {
            FormLoaded = false;

            // Dim bGetScreenObjects As Boolean = True
            // If bGetScreenObjects Then DMA.getFormWidgets(Me)

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

            // Dim ConnStr  = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
            string ConnStr = DBARCH.setConnStr();     // DBARCH.getGateWayConnStr(gGateWayID)
            UTIL.setConnectionStringTimeout(ref ConnStr);
            Cn = new SqlConnection(ConnStr);
            if (winTitle.Length == 0)
            {
                Text = "Administrator Data Maintenance";
            }
            else
            {
                Text = winTitle;
            }

            // Sql Query
            if (S.Length == 0)
            {
                S = "Select * FROM " + TBL;
            }

            DS = new DataSet();
            // Create a Command
            SqlCommand1 = new SqlCommand(S, Cn);

            // Create SqlDataAdapter
            da = new SqlDataAdapter();
            da.SelectCommand = SqlCommand1;

            // Create SqlCommandBuildser object
            cb = new SqlCommandBuilder(da);

            // Fill Dataset
            da.Fill(DS, TBL);

            // Bind the data to the grid at runtime
            dgAttachmentCode.DataSource = DS;
            dgAttachmentCode.DataMember = TBL;
            if (Text.ToUpper().Equals("POP/IMAP EXCHANGE SERVER SETTINGS"))
            {
                btnEncrypt.Visible = true;
                Label1.Visible = true;
                cbRetention.Visible = true;
                btnApplyRetentionRule.Visible = true;
                var argCB = cbRetention;
                DBARCH.LoadRetentionCodes(ref argCB);
                cbRetention = argCB;
                return;
            }
            else
            {
                btnEncrypt.Visible = false;
                Label1.Visible = false;
                cbRetention.Visible = false;
                btnApplyRetentionRule.Visible = false;
                return;
            }

            if (Text.ToUpper().Equals("SMTP EXCHANGE SERVER SETTINGS"))
            {
                btnEncrypt.Visible = true;
                Label1.Visible = true;
                cbRetention.Visible = true;
                btnApplyRetentionRule.Visible = true;
                var argCB1 = cbRetention;
                DBARCH.LoadRetentionCodes(ref argCB1);
                cbRetention = argCB1;
                return;
            }
            else
            {
                btnEncrypt.Visible = false;
                Label1.Visible = false;
                cbRetention.Visible = false;
                btnApplyRetentionRule.Visible = false;
                return;
            }

            FormLoaded = true;
            Text += "          (frmAttachmentCode)";
        }

        private void btnUpdate_Click(object sender, EventArgs e)
        {
            string S = "";
            try
            {
                if (ProcessID.Equals("UserRuntimeParameters"))
                {
                    for (int I = 0, loopTo = dgAttachmentCode.RowCount - 2; I <= loopTo; I++)
                    {
                        string Parm = dgAttachmentCode.Rows[I].Cells["Parm"].Value.ToString();
                        string UID = dgAttachmentCode.Rows[I].Cells["UserID"].Value.ToString();
                        string ParmValue = dgAttachmentCode.Rows[I].Cells["ParmValue"].Value.ToString();
                        Parm = UTIL.RemoveSingleQuotes(Parm);
                        ParmValue = UTIL.RemoveSingleQuotes(ParmValue);
                        S = "update RunParms set ParmValue = '" + ParmValue + "' where UserID = '" + UID + "' and Parm = '" + Parm + "' ";
                        bool b = DBARCH.ExecuteSqlNewConn(90000, S);
                        if (!b)
                        {
                            LOG.WriteToArchiveLog("ERROR: 22.11.341 - Could not update user parm." + Constants.vbCrLf + S);
                            MessageBox.Show("Failed to update user parm.");
                        }
                    }

                    return;
                }

                da.Update(DS, TBL);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message + Constants.vbCrLf + S);
            }
        }

        private void Timer1_Tick(object sender, EventArgs e)
        {
            if (modGlobals.HelpOn)
            {
                if (bHelpLoaded)
                {
                    TT.Active = true;
                }
                else
                {
                    Form argfrm = this;
                    var argTT = TT;
                    DBARCH.getFormTooltips(ref argfrm, ref argTT, true);
                    TT = argTT;
                    TT.Active = true;
                    bHelpLoaded = true;
                }
            }
            else
            {
                TT.Active = false;
            }

            Application.DoEvents();
        }

        private void dgAttachmentCode_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (Text.ToUpper().Equals("POP/IMAP EXCHANGE SERVER SETTINGS"))
            {
                btnEncrypt.Visible = true;
                return;
            }
            else
            {
                btnEncrypt.Visible = false;
                return;
            }

            if (Text.ToUpper().Equals("SMTP EXCHANGE SERVER SETTINGS"))
            {
                btnEncrypt.Visible = true;
                return;
            }
            else
            {
                btnEncrypt.Visible = false;
                return;
            }
        }

        private void btnEncrypt_Click(object sender, EventArgs e)
        {
            int iCnt = dgAttachmentCode.SelectedRows.Count;
            if (iCnt != 1)
            {
                MessageBox.Show("Please select one and only one row to update, thank you - returning.");
                return;
            }

            string HostNameIp = dgAttachmentCode.SelectedRows[0].Cells["HostNameIp"].Value.ToString();
            string UserLoginID = dgAttachmentCode.SelectedRows[0].Cells["UserLoginID"].Value.ToString();
            string PW = dgAttachmentCode.SelectedRows[0].Cells["LoginPw"].Value.ToString();
            string EncPW = ENC.AES256EncryptString(PW);
            string S = "";
            if (Text.ToUpper().Equals("POP/IMAP EXCHANGE SERVER SETTINGS"))
            {
                dgAttachmentCode.SelectedRows[0].Cells["LoginPw"].Value = EncPW;
                S = "Update [ExchangeHostPop] set LoginPW = '" + EncPW + "' where [HostNameIp] = '" + HostNameIp + "' and [UserLoginID] = '" + UserLoginID + "'";
                DBARCH.ExecuteSqlNewConn(90000, S);
                GC.Collect();
                GC.WaitForFullGCComplete();
            }

            if (Text.ToUpper().Equals("SMTP EXCHANGE SERVER SETTINGS"))
            {
                dgAttachmentCode.SelectedRows[0].Cells["LoginPw"].Value = EncPW;
                S = "Update [ExchangeHostSmtp] set LoginPW = '" + EncPW + "' where [HostNameIp] = '" + HostNameIp + "' and [UserLoginID] = '" + UserLoginID + "'";
                DBARCH.ExecuteSqlNewConn(90000, S);
                GC.Collect();
                GC.WaitForFullGCComplete();
            }

            ENC = null;
        }

        private void btnApplyRetentionRule_Click(object sender, EventArgs e)
        {
            int iCnt = dgAttachmentCode.SelectedRows.Count;
            if (iCnt != 1)
            {
                MessageBox.Show("Please select one and only one row to update, thank you - returning.");
                return;
            }

            string RetentionCode = cbRetention.Text.Trim();
            if (RetentionCode.Length == 0)
            {
                MessageBox.Show("Please select a retention rule.");
                return;
            }

            string HostNameIp = dgAttachmentCode.SelectedRows[0].Cells["HostNameIp"].Value.ToString();
            string UserLoginID = dgAttachmentCode.SelectedRows[0].Cells["UserLoginID"].Value.ToString();
            string S = "";
            if (Text.ToUpper().Equals("POP/IMAP EXCHANGE SERVER SETTINGS"))
            {
                dgAttachmentCode.SelectedRows[0].Cells["RetentionCode"].Value = RetentionCode;
                S = "Update [ExchangeHostPop] set RetentionCode = '" + RetentionCode + "' where [HostNameIp] = '" + HostNameIp + "' and [UserLoginID] = '" + UserLoginID + "'";
                DBARCH.ExecuteSqlNewConn(90000, S);
                GC.Collect();
                GC.WaitForFullGCComplete();
            }

            if (Text.ToUpper().Equals("SMTP EXCHANGE SERVER SETTINGS"))
            {
                dgAttachmentCode.SelectedRows[0].Cells["RetentionCode"].Value = RetentionCode;
                S = "Update [ExchangeHostSmtp] set RetentionCode = '" + RetentionCode + "' where [HostNameIp] = '" + HostNameIp + "' and [UserLoginID] = '" + UserLoginID + "'";
                DBARCH.ExecuteSqlNewConn(90000, S);
                GC.Collect();
                GC.WaitForFullGCComplete();
            }
        }

        private void frmAttachmentCode_Resize(object sender, EventArgs e)
        {
            if (FormLoaded == false)
            {
                return;
            }

            Form argfrm = this;
            modResizeForm.ResizeControls(ref argfrm);
        }
    }
}
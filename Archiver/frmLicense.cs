using System;
using System.Windows.Forms;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public partial class frmLicense
    {
        public frmLicense()
        {
            InitializeComponent();
            _btnGetfile.Name = "btnGetfile";
            _btnLoadFile.Name = "btnLoadFile";
            _btnPasteLicense.Name = "btnPasteLicense";
            _btnRemote.Name = "btnRemote";
            _btnApplySelLic.Name = "btnApplySelLic";
            _btnShowCurrentDB.Name = "btnShowCurrentDB";
            _btnSetEqual.Name = "btnSetEqual";
            _btnGetCustID.Name = "btnGetCustID";
            _btnDisplay.Name = "btnDisplay";
            _dgLicense.Name = "dgLicense";
        }

        private bool bFormLoaded = false;
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private clsDma DMA = new clsDma();
        private clsUtility UTIL = new clsUtility();
        private clsLogging LOG = new clsLogging();
        private clsLicenseMgt LM = new clsLicenseMgt();
        private clsRemoteSupport RS = new clsRemoteSupport();
        private clsLICENSE LIC = new clsLICENSE();
        private bool bHelpLoaded = false;
        private bool bLicenseLoaded = false;
        private bool bApplied = false;
        private string xCompanyID = "";
        private object xMachineID = "";
        private string xLicenseID = "";
        private string xApplied = "";
        private string xLicenseTypeCode = "";
        private string xEncryptedLicense = "";
        private string CurrServerName = "";
        private string ExistingVersionNbr = "";
        private string ExistingActivationDate = "";
        private string ExistingInstallDate = "";
        private string ExistingCustomerID = "";
        private string ExistingCustomerName = "";
        private string ExistingLicenseID = "";
        private string ExistingXrtNxr1 = "";
        private string ExistingServerIdentifier = "";
        private string ExistingSqlInstanceIdentifier = "";

        private void btnGetfile_Click(object sender, EventArgs e)
        {
            OpenFileDialog1.ShowDialog();
            string FQN = OpenFileDialog1.FileName;
            txtFqn.Text = FQN;
        }

        private void btnLoadFile_Click(object sender, EventArgs e)
        {
            string CustomerID = txtCompanyID.Text.Trim();
            bApplied = false;
            if (CustomerID.Length == 0)
            {
                MessageBox.Show("Customer ID required: " + Constants.vbCrLf + "If you do not know your Customer ID, " + Constants.vbCrLf + "please contact ECM Support or your ECM administrator.");
                return;
            }

            string SelectedServer = txtServers.Text.Trim();
            if (SelectedServer.Length == 0)
            {
                MessageBox.Show("Please select the Server to which this license applies." + Constants.vbCrLf + "The server name and must match that contained within the license.");
                return;
            }

            string FQN = txtFqn.Text;
            OpenFileDialog1.ShowDialog();
            FQN = OpenFileDialog1.FileName;
            string S = DMA.LoadLicenseFile(FQN);
            if (S.Length == 0)
            {
                SB.Text = "Failed to load license.";
            }
            else
            {
                SB.Text = "Loaded license.";
                txtLicense.Text = S;
                btnPasteLicense_Click(null, null);
            }
        }

        private void btnPasteLicense_Click(object sender, EventArgs e)
        {
            string CustomerID = txtCompanyID.Text.Trim();
            bApplied = false;
            if (CustomerID.Length == 0)
            {
                MessageBox.Show("Customer ID required: " + Constants.vbCrLf + "If you do not know your Customer ID, " + Constants.vbCrLf + "please contact ECM Support or your ECM administrator.");
                return;
            }

            string SelectedServer = txtServers.Text.Trim();
            if (SelectedServer.Length == 0)
            {
                MessageBox.Show("Please select the Server to which this license applies." + Constants.vbCrLf + "The server name and must match that contained within the license.");
                return;
            }

            bool bCustIdGood = RS.ckCompanyID(CustomerID);
            if (bCustIdGood == false)
            {
                MessageBox.Show("Could not connect to the ECM customer database. Continuing without confirmation");
                // Return
            }

            bool B = DBARCH.saveLicenseCutAndPaste(txtLicense.Text, CustomerID, SelectedServer);
            if (!B)
            {
                SB.Text = "Failed to save license.";
            }
            else
            {
                SB.Text = "Saved license.";
                bApplied = true;
            }
        }

        private void frmLicense_Load(object sender, EventArgs e)
        {
            bFormLoaded = false;
            modGlobals.bInetAvailable = DMA.isConnected();
            // Dim bGetScreenObjects As Boolean = True
            // If bGetScreenObjects Then DMA.getFormWidgets(Me)

            if (modGlobals.bInetAvailable == true)
            {
                SB.Text = "Internet available for license download.";
                btnRemote.Enabled = true;
            }
            else
            {
                SB.Text = "Internet NOT available for license download.";
                btnRemote.Enabled = false;
            }

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
            AddTwoNewFields();
            bFormLoaded = true;
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

        private void btnDisplay_Click(object sender, EventArgs e)
        {
            string LT = DBARCH.GetXrt(modGlobals.gCustomerName, modGlobals.gCustomerID);
            LM.ParseLic(LT, true);
        }

        private void btnRemote_Click(object sender, EventArgs e)
        {
            bFormLoaded = false;
            string repoServer = txtServers.Text.Trim();
            string CompanyID = txtCompanyID.Text.Trim();
            string SqlServerInstanceNameX = txtServers.Text;
            string SqlServerMachineName = txtSqlServerMachineName.Text;
            if (CompanyID.Length == 0)
            {
                MessageBox.Show("You must supply your Company ID to access the server, returning.");
                return;
            }

            try
            {
                if (repoServer.Length == 0)
                {
                    MessageBox.Show("You must select a Repository Server, returning.");
                    return;
                }
                // **
                var argdg = dgLicense;
                bool bFetch = RS.getClientLicenses(CompanyID, ref argdg);
                dgLicense = argdg;
                if (bFetch)
                {
                    SB.Text = "Successfully retrieved license.";
                    bLicenseLoaded = true;
                }
                else
                {
                    bLicenseLoaded = false;
                    SB.Text = "Failed to retrieve license.";
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("Trace 23.11.24: License failed to download for: " + DBARCH.getUserLoginByUserid(modGlobals.gCurrUserGuidID) + " : " + ex.Message);
                LOG.WriteToTraceLog("Trace 23.11.24: License failed to download for: " + DBARCH.getUserLoginByUserid(modGlobals.gCurrUserGuidID) + " : " + ex.Message);
            }

            bFormLoaded = true;
        }

        private void dgLicense_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            GetGridData();
        }

        public void GetGridData()
        {
            if (bFormLoaded == false)
            {
                return;
            }

            btnApplySelLic.Enabled = false;
            int I = dgLicense.SelectedRows.Count;
            if (I > 1 | I == 0)
            {
                MessageBox.Show("Please select one and only one license please.");
                return;
            }

            int LL = 1;
            try
            {
                int iCells = dgLicense.SelectedRows[0].Cells.Count - 1;
                LL = 2;
                xCompanyID = dgLicense.SelectedRows[0].Cells["CompanyID"].Value.ToString();
                LL = 3;
                xMachineID = dgLicense.SelectedRows[0].Cells["MachineID"].Value.ToString();
                LL = 4;
                xLicenseID = dgLicense.SelectedRows[0].Cells["LicenseID"].Value.ToString();
                LL = 5;
                xApplied = dgLicense.SelectedRows[0].Cells["Applied"].Value.ToString();
                LL = 6;
                xLicenseTypeCode = dgLicense.SelectedRows[0].Cells["LicenseTypeCode"].Value.ToString();
                LL = 7;
                // xEncryptedLicense  = Me.dgLicense.SelectedRows(0).Cells("EncryptedLicense").Value.ToString
                xEncryptedLicense = dgLicense.SelectedRows[0].Cells[iCells].Value.ToString();
                LL = 8;
                // txtLicense.Text = xEncryptedLicense

                btnApplySelLic.Enabled = true;
                LL = 9;
                SB.Text = "License data ready to apply.";
                LL = 10;
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: frmLicense:GetGridData 100 - LL = " + LL.ToString() + Constants.vbCrLf + ex.Message);
            }
        }

        private void dgLicense_SelectionChanged(object sender, EventArgs e)
        {
            GetGridData();
        }

        private void btnApplySelLic_Click(object sender, EventArgs e)
        {
            string ServerName = dgLicense.SelectedRows[0].Cells["ServerName"].Value.ToString();
            string SqlInstanceName = dgLicense.SelectedRows[0].Cells["SqlInstanceName"].Value.ToString();
            string xEncryptedLicense = dgLicense.SelectedRows[0].Cells["EncryptedLicense"].Value.ToString();
            bLicenseLoaded = false;
            CurrServerName = DBARCH.getServerMachineName();
            string CurrInstanceName = DBARCH.getServerInstanceName();

            // ** Now, I have the license data - what do I do with it?

            // ** Check to see if the Applied Bit is set to true
            if (xApplied.Equals("1"))
            {
                // ** If so, display a message box and return
                MessageBox.Show("This license has already been applied and can be reapplied ONLY to the assigned server.");
            }

            string CustomerID = txtCompanyID.Text.Trim();
            if (CustomerID.Length == 0)
            {
                MessageBox.Show("Customer ID required: " + Constants.vbCrLf + "If you do not know your Customer ID, " + Constants.vbCrLf + "please contact ECM Support or your ECM administrator.");
                return;
            }

            string SelectedServer = txtServers.Text.Trim();
            if (SelectedServer.Length == 0)
            {
                MessageBox.Show("Please select the Server to which this license applies." + Constants.vbCrLf + "The server name and must match that contained within the license.");
                return;
            }

            bool bCustIdGood = RS.ckCompanyID(CustomerID);
            if (bCustIdGood == false)
            {
                MessageBox.Show("Could not find the supplied Customer ID in the ECM database. Please verify... returning");
                return;
            }

            bool BBB = RS.getLicenseServerName(CustomerID, ref ServerName, ref SqlInstanceName);
            if (xMachineID.Equals("ECMNEWXX"))
            {
                string msg = "This is a new license and can be applied to the currently attached repository." + Constants.vbCrLf;
                msg = msg + " Do you wish to apply the license to server '" + CurrServerName + "' ?" + Constants.vbCrLf;
                var dlgRes = MessageBox.Show(msg, "License Installation", MessageBoxButtons.YesNo);
                if (dlgRes == DialogResult.No)
                {
                    return;
                }
                // ** Apply the license to the server, Update the ECM License DBARCH, and show a message
                if (xLicenseID.Trim().Length == 0)
                {
                    xLicenseID = "1";
                }

                int iCnt = LIC.cnt_PK_License(xLicenseID);
                if (iCnt == 0)
                {
                    LIC.setActivationdate(ref DateAndTime.Now.ToString());
                    LIC.setAgreement(ref xEncryptedLicense);
                    LIC.setCustomerid(ref xCompanyID);
                    string argval = "NA";
                    LIC.setCustomername(ref argval);
                    LIC.setInstalldate(ref DateAndTime.Now.ToString());
                    LIC.setVersionnbr(ref xLicenseID);
                    LIC.setServeridentifier(ref SelectedServer);
                    LIC.setSqlinstanceidentifier(ref SelectedServer);
                    bApplied = false;
                    bool BB = true;
                    bool bApplyNewWay = true;
                    if (bApplyNewWay)
                    {
                        bApplied = false;
                        txtLicense.Text = xEncryptedLicense;
                        btnPasteLicense_Click(null, null);
                        txtLicense.Text = "";
                        // ** bApplied is set within CALL to btnPasteLicense_Click
                        BB = bApplied;
                    }
                    else
                    {
                        BB = LIC.Insert();
                        bApplied = BB;
                    }

                    if (!BB)
                    {
                        MessageBox.Show("ERROR: 12.12.3 - Failed to insert license.");
                        LOG.WriteToTraceLog("ERROR: 12.12.3 - Failed to insert license.");
                        bLicenseLoaded = false;
                    }
                    else
                    {
                        DBARCH.UpdateRemoteMachine(CustomerID, CurrServerName, "1", xLicenseID);
                        dgLicense.SelectedRows[0].Cells["MachineID"].Value = SelectedServer;
                        SB.Text = DateAndTime.Now.ToString() + " : License successfully applied.";
                        bLicenseLoaded = true;
                        txtLicense.Text = xEncryptedLicense;
                        btnPasteLicense_Click(null, null);
                        txtLicense.Text = "";
                    }
                }
                else
                {
                    LIC.setActivationdate(ref DateAndTime.Now.ToString());
                    LIC.setAgreement(ref xEncryptedLicense);
                    LIC.setCustomerid(ref xCompanyID);
                    string argval1 = "NA";
                    LIC.setCustomername(ref argval1);
                    LIC.setInstalldate(ref DateAndTime.Now.ToString());
                    LIC.setVersionnbr(ref xLicenseID);
                    LIC.setServeridentifier(ref SelectedServer);
                    LIC.setSqlinstanceidentifier(ref SelectedServer);
                    string WC = LIC.wc_PK_License(xLicenseID);
                    bool BB = LIC.Update(WC);
                    if (!BB)
                    {
                        MessageBox.Show("ERROR: 12.12.3a - Failed to update license.");
                        LOG.WriteToTraceLog("ERROR: 12.12.3a - Failed to update license.");
                        bLicenseLoaded = false;
                    }
                    else
                    {
                        DBARCH.UpdateRemoteMachine(CustomerID, CurrServerName, "1", xLicenseID);
                        dgLicense.SelectedRows[0].Cells["MachineID"].Value = SelectedServer;
                        SB.Text = DateAndTime.Now.ToString() + " : License updated.";
                        bLicenseLoaded = true;
                        txtLicense.Text = xEncryptedLicense;
                        btnPasteLicense_Click(null, null);
                        txtLicense.Text = "";
                    }
                }
            }
            else if (CurrServerName.Equals(ServerName) & CurrInstanceName.Equals(SqlInstanceName))
            {
                // ** See if the current server has an existing license
                // ** If not, add this one and transmit back the Server Name to the ECM server
                // ** If So, update the existing license.
                bool bLicenseExists = DBARCH.LicenseExists();
                if (bLicenseExists == true)
                {
                    string S = "Truncate Table License";
                    BBB = DBARCH.ExecuteSqlNewConn(90000, S);
                    if (BBB)
                    {
                        bLicenseExists = false;
                    }
                }

                if (bLicenseExists == false)
                {
                    string VersionNbr = xLicenseID;
                    bool bVersion = DBARCH.LicenseVersionExist(VersionNbr);
                    if (bVersion == false)
                    {
                        // ** Add the new version
                        LIC.setActivationdate(ref DateAndTime.Now.ToString());
                        LIC.setAgreement(ref xEncryptedLicense);
                        LIC.setCustomerid(ref xCompanyID);
                        LIC.setInstalldate(ref DateAndTime.Now.ToString());
                        LIC.setCustomername(ref xCompanyID);
                        LIC.setVersionnbr(ref xLicenseID);
                        // LIC.setXrtnxr1()
                        bool B = LIC.Insert();
                        if (B == false)
                        {
                            MessageBox.Show("ERROR: Failed to insert license.");
                            SB.Text = "ERROR: Failed to insert license.";
                            bLicenseLoaded = false;
                        }
                        else
                        {
                            DBARCH.UpdateRemoteMachine(CustomerID, CurrServerName, "1", xLicenseID);
                            dgLicense.SelectedRows[0].Cells["MachineID"].Value = SelectedServer;
                            SB.Text = DateAndTime.Now.ToString() + " : License added.";
                            bLicenseLoaded = true;
                            txtLicense.Text = xEncryptedLicense;
                            btnPasteLicense_Click(null, null);
                            txtLicense.Text = "";
                            SB.Text = "License APPLIED.";
                            btnDisplay_Click(null, null);
                        }
                    }
                    else
                    {
                        // ** Update the current license
                        // Damn - what here ???
                        LIC.setActivationdate(ref DateAndTime.Now.ToString());
                        LIC.setAgreement(ref xEncryptedLicense);
                        LIC.setCustomerid(ref xCompanyID);
                        LIC.setInstalldate(ref DateAndTime.Now.ToString());
                        LIC.setCustomername(ref xCompanyID);
                        LIC.setVersionnbr(ref xLicenseID);
                        // LIC.setXrtnxr1()
                        string WC = LIC.wc_PK_License(xLicenseID);
                        bool B = LIC.Update(WC);
                        if (B == false)
                        {
                            MessageBox.Show("ERROR: Failed to update existing license.");
                        }
                        else
                        {
                            DBARCH.UpdateRemoteMachine(CustomerID, CurrServerName, "1", xLicenseID);
                            dgLicense.SelectedRows[0].Cells["MachineID"].Value = SelectedServer;
                            SB.Text = DateAndTime.Now.ToString() + " : Failed to update existing license.";
                            bLicenseLoaded = true;
                            txtLicense.Text = xEncryptedLicense;
                            btnPasteLicense_Click(null, null);
                            txtLicense.Text = "";
                            SB.Text = "License UPDATED.";
                            btnDisplay_Click(null, null);
                        }
                    }
                }
                else
                {
                    MessageBox.Show("002 - This license does not belong to the current Server '" + CurrServerName + "'. It cannot be applied.");
                    return;
                }
            }
            else
            {
                MessageBox.Show("001 - This license does not belong to the current Server '" + CurrServerName + "'. It cannot be applied.");
                return;
            }
            // ** If not,
            // ** Check to see if the target server has an existing repository license.
            // **

        }

        private void btnShowCurrentDB_Click(object sender, EventArgs e)
        {
            string tMsg = "";
            tMsg = Conversions.ToString(tMsg + Operators.AddObject(Operators.AddObject("User   Conn Str: ", My.MySettingsProperty.Settings["UserDefaultConnString"]), Constants.vbCrLf));
            tMsg += "Config Conn Str: " + System.Configuration.ConfigurationManager.AppSettings["ECMREPO"] + Constants.vbCrLf;
            MessageBox.Show(tMsg);
        }

        private void btnSetEqual_Click(object sender, EventArgs e)
        {
            My.MySettingsProperty.Settings["UserDefaultConnString"] = System.Configuration.ConfigurationManager.AppSettings["ECMREPO"];
            // My.Settings.Reset()
            // My.Settings("UserDefaultConnString") = "?"
            My.MySettingsProperty.Settings.Save();
            SB.Text = Conversions.ToString(Operators.AddObject("Settings saved to: ", My.MySettingsProperty.Settings["UserDefaultConnString"]));
        }

        private void btnGetCustID_Click(object sender, EventArgs e)
        {
            string LT = DBARCH.GetXrt(modGlobals.gCustomerName, modGlobals.gCustomerID);
            txtCompanyID.Text = LM.ParseLicCustomerID(LT, true);
        }

        public void AddTwoNewFields()
        {
            bool B = false;
            int ID = 240;
            string S = "";
            S = S + " ALter table License Add SqlServerInstanceName nvarchar(254)";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            if (B)
            {
                Console.WriteLine("GOOD");
            }
            else
            {
                Console.WriteLine("BAD");
            }

            S = " ALter table License Add SqlServerMachineName nvarchar(254)";
            B = DBARCH.ExecuteSqlNewConn(S, false);
            if (B)
            {
                Console.WriteLine("GOOD");
            }
            else
            {
                Console.WriteLine("BAD");
            }
        }
    }
}
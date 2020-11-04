using System;
using global::System.Collections.Generic;
using global::System.IO;
using System.Windows.Forms;
using global::ECMEncryption;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public partial class LoginForm1
    {
        public LoginForm1()
        {
            InitializeComponent();
            _OK.Name = "OK";
            _Cancel.Name = "Cancel";
            _btnChgPW.Name = "btnChgPW";
            _ckDisableListener.Name = "ckDisableListener";
            _ckSaveAsDefaultLogin.Name = "ckSaveAsDefaultLogin";
            _ckAutoExecute.Name = "ckAutoExecute";
            _Button1.Name = "Button1";
            _ckCancelAutoLogin.Name = "ckCancelAutoLogin";
            _PictureBox1.Name = "PictureBox1";
            _btnStopExec.Name = "btnStopExec";
        }

        private string TRACEFLOW = System.Configuration.ConfigurationManager.AppSettings["TRACEFLOW"];
        private string CurrGatewaySvr = "";
        private int AutoLoginSecs = 10;
        private int CurrLoginSecs = 0;
        private clsLogging LOG = new clsLogging();
        private clsIsolatedStorage ISO = new clsIsolatedStorage();
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private ECMEncrypt ENC = new ECMEncrypt();
        private clsDma DMA = new clsDma();
        private bool bHelpLoaded = false;
        private bool bAttached = false;
        private bool bPopulateComboBusy = false;
        private int AutoSecs = 1;
        private int Tries = 1;
        public bool bGoodLogin = false;
        public string UID = "";
        private Guid CurrSessionGuid = Guid.NewGuid();
        private int SecureID = -1;
        private List<string> ListOfRepoIS = new List<string>();
        private string strRepos = "";
        private OperatingSystem osInfo;
        private string FQN = "";
        private string CurrUserName = "";
        private string dDebug = System.Configuration.ConfigurationManager.AppSettings["debug_frmReconMain"];

        private void LoginForm1_Load(object sender, EventArgs e)
        {
            if (Conversions.ToDouble(TRACEFLOW) == 1d)
                DBARCH.RemoteTrace(9900, "LoginIn001", "00");
            lblExecTime.Visible = false;
            btnStopExec.Visible = false;
            TopMost = false;

            // InitPersistData()

            if (TRACEFLOW.Equals(1))
            {
                LOG.WriteToTraceLog("**********************************************************************");
                LOG.WriteToTraceLog("Start of Trace for LoginForm" + DateAndTime.Now.ToString());
            }

            string OSVersion = Environment.OSVersion.ToString();
            string OSVersionMajor = Environment.OSVersion.Version.Major.ToString();
            string OSVersionMinor = Environment.OSVersion.Version.Minor.ToString();
            string OSVersionMinorRev = Environment.OSVersion.Version.MinorRevision.ToString();
            AddTemDir();
            if (dDebug.Equals("1"))
            {
                LOG.WriteToTraceLog(DateAndTime.Now.ToString() + "Step 01 :Added the temp directory");
            }

            if (Conversions.ToDouble(TRACEFLOW) == 1d)
                DBARCH.RemoteTrace(9900, "LoginIn001", "01");
            if (Conversions.ToDouble(TRACEFLOW) == 1d)
                DBARCH.RemoteTrace(9900, "LoginIn002", "02");
            CurrUserName = Environment.UserName;
            if (Conversions.ToDouble(TRACEFLOW) == 1d)
                DBARCH.RemoteTrace(9900, "LoginIn003", "03");
            getPersitData();
            if (Conversions.ToDouble(TRACEFLOW) == 1d)
                DBARCH.RemoteTrace(9900, "LoginIn004", "04");
            lblAttachedMachineName.Text = LOG.getEnvVarMachineName();
            lblNetworkID.Text = LOG.getEnvVarNetworkID();
            if (Conversions.ToDouble(TRACEFLOW) == 1d)
                DBARCH.RemoteTrace(9900, "LoginIn005", "05");
            modGlobals.bRunnner = false;
            if (modGlobals.UseDirectoryListener.Equals(0))
            {
                ckDisableListener.Visible = false;
            }

            DBARCH.ckUpdateTbl();
        }

        private void OK_Click(object sender, EventArgs e)
        {
            Timer2.Enabled = false;
            Timer3.Enabled = false;
            if (PasswordTextBox.Text.ToUpper().Equals("PASSWORD"))
            {
                if (txtLoginID.Text.Length == 0)
                {
                    MessageBox.Show("Please enter your USERID into the Login ID field.");
                    return;
                }

                My.MyProject.Forms.frmPasswordChange.ShowDialog();
                SB.Text = "Please login using your new credentials, thank you.";
                return;
            }

            if (txtLoginID.Text.Length == 0)
            {
                MessageBox.Show("Your user Login ID is required.");
                return;
            }

            if (PasswordTextBox.Text.Length == 0)
            {
                MessageBox.Show("Your user Login Password is required.");
                return;
            }

            lblAttachedMachineName.Text = modGlobals.gAttachedMachineName;
            lblCurrUserGuidID.Text = txtLoginID.Text;
            lblLocalIP.Text = modGlobals.gLocalMachineIP;
            lblServerInstanceName.Text = modGlobals.gServerInstanceName;
            lblServerMachineName.Text = modGlobals.gServerMachineName;
            lblCurrUserGuidID.Text = txtLoginID.Text;
            modGlobals.gCurrUserGuidID = txtLoginID.Text;

            // *************************
            SaveStaticVars();
            // *************************
            SB.Text = "Logging in, standby.";
            SB.Refresh();
            Application.DoEvents();
            string LoginID = txtLoginID.Text.Trim();
            string PW = PasswordTextBox.Text.Trim();
            string DecryptedPassword = "";
            string EncryptedPassword = "";
            bool RetCode = false;
            int DHX = 99;
            int ix = 0;
            string rMsg = "";
            DHX = DBARCH.ckUserLoginExists(LoginID, ref RetCode, ref rMsg);
            ix = DHX;
            if (ix < 1 & rMsg.Length > 0)
            {
                MessageBox.Show("FAILED TO ATTACH USER: " + rMsg);
            }
            else if (ix < 1)
            {
                MessageBox.Show("ERROR 01Q: FAILED TO ATTACH USER - verify your ID and password ");
            }

            if (ix == 1)
            {
                string tpw = DBARCH.getBinaryPassword(LoginID);
                // MessageBox.Show("REMOVE THIS: TPW=" + tpw.ToString)
                if (tpw.Trim().Length > 0)
                {
                    if (tpw.ToUpper().Equals("PASSWORD"))
                    {
                        if (LoginID.ToUpper().Equals("ADMIN"))
                        {
                            string Msg = "";
                            Msg = "It appears that this may be the first time into the system." + Constants.vbCrLf;
                            Msg += "As an ADMIN, you will be required to change your " + Constants.vbCrLf + "current password of 'password' and," + Constants.vbCrLf;
                            Msg += "any users will have to be added to the system if they" + Constants.vbCrLf + "are allowed to access ECM Library." + Constants.vbCrLf + Constants.vbCrLf;
                            Msg += "Thank you for using ECM Library.";
                            MessageBox.Show(Msg);
                        }

                        PWOVER:
                        ;
                        My.MyProject.Forms.frmPasswordChange.ShowDialog();
                        string NewPw = My.MyProject.Forms.frmPasswordChange.PW1;
                        string NewPw2 = My.MyProject.Forms.frmPasswordChange.PW2;
                        NewPw = NewPw.Trim();
                        NewPw2 = NewPw2.Trim();
                        if (NewPw.Equals(NewPw2))
                        {
                            string epw = ENC.AES256EncryptString(NewPw2);
                            string sEnc = "Update users set UserPassword = '" + epw + "' where UserLoginID = '" + LoginID + "' ";
                            bool BB2 = DBARCH.ExecuteSqlNewConn(sEnc, false);
                            if (BB2)
                            {
                                MessageBox.Show("Your password has been changed, for future logins, please use your new password.");
                                PW = NewPw;
                            }
                            else
                            {
                                MessageBox.Show("Your password failed to update, please cntact an administrator or try to login again, closing down.");
                                Environment.Exit(0);
                            }
                        }
                        else
                        {
                            Tries += 1;
                            if (Tries >= 3)
                            {
                                MessageBox.Show("Too many tries, try logging in again from the start, closing down.");
                                Environment.Exit(0);
                            }

                            MessageBox.Show("The passwords do not equal each other, please reenter.");
                            goto PWOVER;
                        }
                    }
                }
            }
            else
            {
                MessageBox.Show("Your user login ID has not been defined to the system, please contact an administrator, closing down.");
                goto SKIPOUT;
            }

            My.MyProject.Forms.frmPasswordChange.Dispose();
            EncryptedPassword = ENC.AES256EncryptString(PW);

            // MessageBox.Show("Remove this later WDM")

            string UPW = DBARCH.getPw(LoginID);
            if (UPW.Equals(EncryptedPassword))
            {
                UID = LoginID;
                bGoodLogin = true;
                Timer2.Enabled = false;
                Hide();
                var MainPage = new frmMain();
                MainPage.Show();
                return;
            }
            else
            {
                UID = "";
                bGoodLogin = false;
                MessageBox.Show("ERROR A12: Failed to login, please verify your User ID and password! ");
                Tries += 1;
                if (Tries >= 3)
                {
                    MessageBox.Show("Too many tries, try logging in again from the start, closing down.");
                    Environment.Exit(0);
                }
            }

            SKIPOUT:
            ;
        }

        private void Cancel_Click(object sender, EventArgs e)
        {
            modGlobals.bRunnner = false;
            Close();
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

        private void ckSaveAsDefaultLogin_CheckedChanged(object sender, EventArgs e)
        {
            if (ckSaveAsDefaultLogin.Checked)
            {
                // Write the info (encrypted) out to a file for use during the next login.
                SavePersist();
            }
            else
            {
                // Remove the login file if it exists.
            }
        }

        public void SaveStaticVars()
        {
            if (SecureID >= 0)
            {
                modGlobals.gGateWayID = SecureID;
                modGlobals.gSecureID = SecureID;
            }

            modGlobals.gUserID = txtLoginID.Text;
            modGlobals.gActiveGuid = CurrSessionGuid;
            modGlobals.gSessionGuid = CurrSessionGuid;
            SavePersist();
        }

        /// <summary>
    /// Saves the active parm.
    /// </summary>
    /// <param name="ParmName">Name of the parm.</param>
    /// <param name="ParmVal"> The parm value.</param>
        // Sub SaveActiveParm(ByVal ParmName As String, ByVal ParmVal As String)
        // If Not bAttached Then
        // Return
        // End If

        // ProxySearch.ActiveSession(SecureID, CurrSessionGuid, ParmName, ParmVal)

        // End Sub

        public void InitPersistData()
        {
            ISO.PersistDataInit("CurrSessionGuid", "");
            ISO.PersistDataSave("CompanyID", "");
            ISO.PersistDataSave("RepoID", "");
            ISO.PersistDataSave("LoginID", "");
            ISO.PersistDataSave("EncryptPW", "");
            ISO.PersistDataSave("UPW", "");
            ISO.PersistDataSave("EOD", "***");
        }

        public void RemovePersist()
        {
            ISO.PersistDataInit("NA", "NA");
        }

        public void SavePersist()
        {
            // EncryptPhrase
            ISO.PersistDataInit("CurrSessionGuid", CurrSessionGuid.ToString());
            ISO.PersistDataSave("LoginID", txtLoginID.Text);
            TPW = ENC.AES256EncryptString(PasswordTextBox.Text.Trim());
            ISO.PersistDataSave("EncryptPW", Conversions.ToString(TPW));
            ISO.PersistDataSave("AutoExecute", ckAutoExecute.Checked.ToString());
            string UPW = PasswordTextBox.Text.Trim();
            UPW = ENC.AES256EncryptString(UPW);
            ISO.PersistDataSave("UPW", UPW);
            ISO.PersistDataSave("EOD", "***");
        }

        public void getPersitData()
        {
            string SID = ISO.PersistDataRead("SecureID");
            if (SID.Length > 0)
            {
                SecureID = Conversions.ToInteger(SID);
                modGlobals.gSecureID = SecureID;
                modGlobals.gGateWayID = SecureID;
            }

            string strAutoExec = ISO.PersistDataRead("AutoExecute");
            if (strAutoExec.ToUpper().Equals("TRUE"))
            {
                modGlobals.gAutoExec = true;
                ckAutoExecute.Checked = true;
                ckAutoExecute.CheckState = (CheckState)1;
                Timer3.Enabled = true;
                btnStopExec.Visible = true;
                lblExecTime.Visible = true;
            }
            else
            {
                modGlobals.gAutoExec = false;
                ckAutoExecute.Checked = false;
                ckAutoExecute.CheckState = 0;
                Timer3.Enabled = false;
                btnStopExec.Visible = false;
                lblExecTime.Visible = false;
            }

            txtLoginID.Text = ISO.PersistDataRead("LoginID");
            string UPW = ISO.PersistDataRead("UPW");
            PasswordTextBox.Text = ENC.AES256DecryptString(UPW);
            string sCurrSessionGuid = ISO.PersistDataRead("CurrSessionGuid");
            if (sCurrSessionGuid.Length > 0)
            {
                CurrSessionGuid = new Guid(sCurrSessionGuid);
            }
            else
            {
                CurrSessionGuid = new Guid();
            }
        }

        private void Timer2_Tick(object sender, EventArgs e)
        {
            if (ckCancelAutoLogin.Checked == true)
            {
                Timer2.Enabled = false;
            }

            CurrLoginSecs += 1;
            int i = AutoLoginSecs - CurrLoginSecs;
            if (CurrLoginSecs == AutoLoginSecs)
            {
                lblMsg.Text = "Logging in...\"";
                OK_Click(null, null);
            }
            else
            {
                lblMsg.Text = "SECS to Login: " + i.ToString();
            }
        }

        private void AddTemDir()
        {
            if (!Directory.Exists(@"c:\TempUploads"))
            {
                Directory.CreateDirectory(@"c:\TempUploads");
            }
        }

        private void cbRepoID_SelectedIndexChanged(object sender, EventArgs e)
        {
            // ISO.PersistDataSave("CompanyID", txtCompanyID.Text)
            // ISO.PersistDataSave("RepoID", cbRepoID.Text)

            // gCustomerID = txtCompanyID.Text
            // gRepoID = cbRepoID.Text

            // setGatewayEndpoints()
            Timer2.Enabled = false;
        }

        private void txtCompanyID_TextChanged(object sender, EventArgs e)
        {
            Timer2.Enabled = false;
        }

        private void ckCancelAutoLogin_CheckedChanged(object sender, EventArgs e)
        {
        }

        private void PictureBox1_MouseEnter(object sender, EventArgs e)
        {
            SB.Text = "D. Miller & Asso., LTD., Chicago, IL.";
        }

        private void PictureBox1_MouseLeave(object sender, EventArgs e)
        {
            SB.Text = "";
        }

        private void btnChgPW_Click(object sender, EventArgs e)
        {
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            string LoginID = txtLoginID.Text.Trim();
            string UPW = DBARCH.getPw(LoginID);
            string EncPassword = ENC.AES256EncryptString(UPW);
            if (UPW.Equals(EncPassword))
            {
                MessageBox.Show("Password is good");
            }
            else
            {
                MessageBox.Show("Password is BAD: " + UPW + " : " + EncPassword);
            }
        }

        private void ckAutoExecute_CheckedChanged(object sender, EventArgs e)
        {
            if (ckAutoExecute.Checked & !ckSaveAsDefaultLogin.Checked)
            {
                if (modGlobals.gAutoExec.Equals(false))
                {
                    MessageBox.Show("Auto Execute cannot be set until Save As Default Login is set and checked... returning.");
                }
            }

            if (ckAutoExecute.Checked & ckSaveAsDefaultLogin.Checked)
            {
                SavePersist();
            }
        }

        private void btnStopExec_Click(object sender, EventArgs e)
        {
            Timer3.Enabled = false;
            SB.Text = "Auto Execute Cancelled";
            modGlobals.gAutoExec = false;
            btnStopExec.Visible = false;
            lblExecTime.Visible = false;
        }

        private void Timer3_Tick(object sender, EventArgs e)
        {
            AutoSecs += 1;
            lblExecTime.Text = "Executing in " + (10 - AutoSecs).ToString() + " Secs.";
            lblExecTime.Refresh();
            if (AutoSecs.Equals(10))
            {
                Console.WriteLine("Auto-execution started");
                OK.PerformClick();
            }
        }

        private void ckDisableListener_CheckedChanged(object sender, EventArgs e)
        {
            if (ckDisableListener.Checked)
            {
                modGlobals.TempDisableDirListener = true;
            }
            else
            {
                modGlobals.TempDisableDirListener = false;
            }
        }
    }
}
using System;
using System.Data;
using global::System.Data.SqlClient;
using System.Diagnostics;
using global::System.IO;
using System.Windows.Forms;
using global::ECMEncryption;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public partial class frmAppConfigEdit
    {
        public frmAppConfigEdit()
        {
            // This call is required by the Windows Form Designer.
            InitializeComponent();

            // Add any initialization after the InitializeComponent() call.

            Button2_Click(null, null);
            txtLoginName.Text = "";
            txtLoginName.Enabled = false;
            txtLoginName.ReadOnly = false;
            txtPw1.Text = "";
            txtPw1.Enabled = false;
            txtPw1.ReadOnly = false;
            txtPw2.Text = "";
            txtPw2.Enabled = false;
            txtPw2.ReadOnly = false;
            if (MasterLoaded)
            {
                btnLoadCombo_Click(null, null);
            }

            FormLoaded = true;
            _ckWindowsAuthentication.Name = "ckWindowsAuthentication";
            _cbSavedDefinitions.Name = "cbSavedDefinitions";
            _btnTestConnection.Name = "btnTestConnection";
            _btnSaveConn.Name = "btnSaveConn";
            _Button7.Name = "Button7";
            _Button1.Name = "Button1";
            _Button2.Name = "Button2";
            _btnResetGlobalLocationToDefault.Name = "btnResetGlobalLocationToDefault";
            _btnLoadCombo.Name = "btnLoadCombo";
            _btnLoadData.Name = "btnLoadData";
            _GotoApplicationDirectoryToolStripMenuItem.Name = "GotoApplicationDirectoryToolStripMenuItem";
            _GotoGlobalDirectoryToolStripMenuItem.Name = "GotoGlobalDirectoryToolStripMenuItem";
        }

        private bool FormLoaded = false;
        private bool MasterLoaded = false;
        private string ConnStr = "";
        private string ConnstrThesaurus = "";
        private string ConnstrRepository = "";
        private bool bRestart = false;
        public bool AutoRestore = false;
        private bool bLoadingCB = false;
        private bool bConnTested = false;
        private ECMEncrypt ENC = new ECMEncrypt();
        private string MasterConnstr = "";

        public void App_Path()
        {
            string S = AppDomain.CurrentDomain.BaseDirectory;
            Clipboard.Clear();
            Clipboard.SetText(S);
        }

        public string ReadFile(string fName)
        {
            var SR = new StreamReader(fName);
            string FullText = "";
            while (!SR.EndOfStream)
            {
                string S = SR.ReadLine();
                FullText = FullText + S + Constants.vbCrLf;
            }

            SR.Close();
            return FullText;
        }

        public void WriteFile(string FQN, string sText)
        {
            var SW = new StreamWriter(FQN);
            string S = sText.Trim();
            if (S.Length > 0)
            {
                SW.WriteLine(S);
            }

            SW.Close();
            SB.Text = "File saved...";
        }

        private void btnTestConnection_Click(object sender, EventArgs e)
        {
            bool B = false;
            SB.Text = "";
            SB.Text = "Attempting to connect";
            SB.Refresh();
            string CS = BuildConnstr();
            var CONN = new SqlConnection(CS);
            try
            {
                CONN.Open();
                SB.Text = "Connection successful for " + txtRepositoryName.Text;
                ConnstrRepository = ConnStr;
                B = true;
            }
            catch (Exception ex)
            {
                SB.Text = "Connection Failed  to " + txtRepositoryName.Text;
            }
            finally
            {
                CONN.Dispose();
                GC.Collect();
            }

            Application.DoEvents();
            if (B)
            {
                // If rbRepository.Checked Then
                // MasterConnstr = CS
                // End If
                btnSaveConn.Enabled = true;
                Button1.Enabled = true;
                bConnTested = true;
                LicenseToolStripMenuItem.Visible = true;
            }
            else
            {
                // MasterConnstr = ""
                btnSaveConn.Enabled = false;
                Button1.Enabled = false;
                bConnTested = false;
            }
        }

        private void ckWindowsAuthentication_CheckedChanged(object sender, EventArgs e)
        {
            if (ckWindowsAuthentication.Checked)
            {
                txtLoginName.Text = "";
                txtLoginName.Enabled = false;
                txtLoginName.ReadOnly = false;
                txtPw1.Text = "";
                txtPw1.Enabled = false;
                txtPw2.Text = "";
                txtPw2.Enabled = false;
            }
            else
            {
                txtLoginName.Text = "";
                txtLoginName.Enabled = true;
                txtLoginName.ReadOnly = false;
                txtPw1.Text = "";
                txtPw1.Enabled = true;
                txtPw1.ReadOnly = false;
                txtPw2.Text = "";
                txtPw2.Enabled = true;
                txtPw2.ReadOnly = false;
            }
        }

        private void Button7_Click(object sender, EventArgs e)
        {
            string DirName = "";
            FolderBrowserDialog1.ShowDialog();
            DirName = FolderBrowserDialog1.SelectedPath;
            txtGlobalFileDirectory.Text = DirName;
        }

        public string GetScreenParms()
        {
            string S = "";
            S += "txtGlobalFileDirectory" + "|" + txtGlobalFileDirectory.Text + Conversions.ToString('\u007f');
            S += "txtDBName" + "|" + txtDBName.Text + Conversions.ToString('\u007f');
            S += "txtRepositoryName" + "|" + txtRepositoryName.Text + Conversions.ToString('\u007f');
            S += "txtServerInstance" + "|" + txtServerInstance.Text + Conversions.ToString('\u007f');
            S += "ckWindowsAuthentication" + "|" + ckWindowsAuthentication.Checked.ToString() + Conversions.ToString('\u007f');
            S += "ckRepository" + "|" + rbRepository.Checked.ToString() + Conversions.ToString('\u007f');
            S += "ckThesaurus" + "|" + rbThesaurus.Checked.ToString() + Conversions.ToString('\u007f');
            S += "txtLoginName" + "|" + txtLoginName.Text + Conversions.ToString('\u007f');
            S += "txtPw1" + "|" + txtPw1.Text + Conversions.ToString('\u007f');
            S += "cbSavedDefinitions" + "|" + cbSavedDefinitions.Text + Conversions.ToString('\u007f');
            S += "ckHive" + "|" + ckHive.Checked.ToString() + Conversions.ToString('\u007f');
            return S;
        }

        public string ResetScreenParms()
        {
            string S = "";
            txtDBName.Text = "";
            txtRepositoryName.Text = "";
            txtServerInstance.Text = "";
            ckWindowsAuthentication.Checked = true;
            // rbRepository.Checked = True
            // rbThesaurus.Checked = False
            txtLoginName.Text = "";
            txtPw1.Text = "";
            txtPw2.Text = "";
            cbSavedDefinitions.Text = "";
            ckHive.Checked = false;
            return S;
        }

        private void btnSaveConn_Click(object sender, EventArgs e)
        {
            if (MasterConnstr.Trim().Length == 0)
            {
                MessageBox.Show("ERROR: the master setup has not been set, returning.");
                return;
            }

            if (!bConnTested)
            {
                MessageBox.Show("This connection has not been tested, please test the connection first.");
            }

            if (!ckWindowsAuthentication.Checked)
            {
                if (!txtPw1.Text.Equals(txtPw2.Text))
                {
                    MessageBox.Show("The passwords do not match, returning.");
                    return;
                }
            }

            string ProfileName = cbSavedDefinitions.Text;
            string S = GetScreenParms();
            string InsertSql = "";
            S = ENC.AES256EncryptString(S);
            ProfileName = ProfileName.Replace("'", "");
            int icnt = iCount("Select count(*) from Repository where ConnectionName = '" + ProfileName + "'");
            if (icnt == 0)
            {
                if (rbRepository.Checked)
                {
                    string CS = MasterConnstr;
                    InsertSql = "";
                    InsertSql = InsertSql + "INSERT INTO [Repository] ([ConnectionName],[ConnectionData])" + Constants.vbCrLf;
                    InsertSql = InsertSql + "VALUES" + Constants.vbCrLf;
                    InsertSql = InsertSql + "('" + ProfileName + "'" + Constants.vbCrLf;
                    InsertSql = InsertSql + ",'" + S + "')" + Constants.vbCrLf;
                }
                else
                {
                    InsertSql = "";
                    InsertSql = InsertSql + "INSERT INTO [Repository] ([ConnectionName],[ConnectionDataThesaurus])" + Constants.vbCrLf;
                    InsertSql = InsertSql + "VALUES" + Constants.vbCrLf;
                    InsertSql = InsertSql + "('" + ProfileName + "'" + Constants.vbCrLf;
                    InsertSql = InsertSql + ",'" + S + "')" + Constants.vbCrLf;
                }
            }
            else if (rbRepository.Checked)
            {
                string CS = MasterConnstr;
                InsertSql = "UPDATE [Repository] SET [ConnectionData] = '" + S + "' WHERE [ConnectionName] = '" + ProfileName + "'";
            }
            else
            {
                InsertSql = "UPDATE [Repository] SET [ConnectionDataThesaurus] = '" + S + "' WHERE [ConnectionName] = '" + ProfileName + "'";
            }

            bool B = ExecuteSqlNewConn(InsertSql);
            if (B)
            {
                SB.Text = "Profile '" + ProfileName + "' saved to Master Repository";
            }
            else
            {
                SB.Text = "ERROR: Profile '" + ProfileName + "' did not save.";
            }
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            if (!bConnTested)
            {
                MessageBox.Show("This connection has not been tested, please test the connection first.");
            }

            if (!ckWindowsAuthentication.Checked)
            {
                if (!txtPw1.Text.Equals(txtPw2.Text))
                {
                    MessageBox.Show("The passwords do not match, returning.");
                    return;
                }
            }

            string GlobalFileDirectory = txtGlobalFileDirectory.Text.Trim();
            string ProfileName = cbSavedDefinitions.Text;
            string S = GetScreenParms();
            if (!Directory.Exists(GlobalFileDirectory))
            {
                try
                {
                    Directory.CreateDirectory(GlobalFileDirectory);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("ERROR: Failed to create directory, choose another or contact an administrator, aborting setup." + Constants.vbCrLf + ex.Message);
                    return;
                }
            }

            string FQN = GlobalFileDirectory + GetGlobalFileName();
            bool BB = SaveGlobalParms(S, FQN);
            if (BB)
            {
                SB.Text = "Global installation parameters saved.";
            }
            else
            {
                SB.Text = "ERROR: Global installation parameters failed to save.";
            }
        }

        public string GetGlobalParms(string FQN)
        {
            if (!File.Exists(FQN))
            {
                MessageBox.Show("File '" + FQN + "', does not exist, aborting.");
                return "";
            }

            bool B = true;
            string strContents;
            StreamReader objReader;
            try
            {
                objReader = new StreamReader(FQN);
                strContents = objReader.ReadToEnd();
                objReader.Close();
                return strContents;
            }
            catch (Exception Ex)
            {
                B = false;
                MessageBox.Show("ERROR: could not read global configuration file:" + Constants.vbCrLf + Ex.Message);
            }

            return Conversions.ToString(B);
        }

        public bool SaveGlobalParms(string strData, string FQN)
        {
            strData = ENC.AES256EncryptString(strData);
            bool bAns = false;
            StreamWriter objReader;
            try
            {
                objReader = new StreamWriter(FQN, false);
                objReader.Write(strData);
                objReader.Close();
                bAns = true;
            }
            catch (Exception Ex)
            {
                MessageBox.Show("ERROR: did not save global configuration file:" + Constants.vbCrLf + Ex.Message);
            }

            return bAns;
        }

        private void Button2_Click(object sender, EventArgs e)
        {
            if (!bConnTested)
            {
                if (FormLoaded)
                {
                    MessageBox.Show("This connection has not been validated, please test the connection.");
                }
            }

            ResetScreenParms();
            string GlobalFileDirectory = txtGlobalFileDirectory.Text.Trim();
            string ProfileName = cbSavedDefinitions.Text;
            string FQN = txtGlobalFileDirectory.Text.Trim() + GetGlobalFileName();
            FQN = FQN.Replace(@"\\", @"\");
            if (!File.Exists(FQN))
            {
                if (FormLoaded)
                {
                    MessageBox.Show("ERROR: Cannot find global parameter file '" + FQN + "', aborting load.");
                }

                return;
            }

            string GlobalParms = GetGlobalParms(FQN);
            string DecryptedParms = ENC.AES256DecryptString(GlobalParms);
            var A = DecryptedParms.Split('\u007f');
            foreach (var S in A)
            {
                var Parm = S.Split('|');
                string ParmName = Parm[0];
                if (ParmName.Trim().Length > 0)
                {
                    string ParmVal = Parm[1];
                    if (ParmName.Equals("txtGlobalFileDirectory"))
                    {
                        txtGlobalFileDirectory.Text = ParmVal;
                    }
                    else if (ParmName.Equals("txtRepositoryName"))
                    {
                        txtRepositoryName.Text = ParmVal;
                    }
                    else if (ParmName.Equals("txtServerInstance"))
                    {
                        txtServerInstance.Text = ParmVal;
                    }
                    else if (ParmName.Equals("ckWindowsAuthentication"))
                    {
                        if (ParmVal.Equals("True"))
                        {
                            ckWindowsAuthentication.Checked = true;
                        }
                        else
                        {
                            ckWindowsAuthentication.Checked = false;
                        }
                    }
                    else if (ParmName.Equals("ckRepository"))
                    {
                        if (ParmVal.Equals("True"))
                        {
                            rbRepository.Checked = true;
                        }
                        else
                        {
                            rbRepository.Checked = false;
                        }
                    }
                    else if (ParmName.Equals("ckThesaurus"))
                    {
                        if (ParmVal.Equals("True"))
                        {
                            rbThesaurus.Checked = true;
                        }
                        else
                        {
                            rbThesaurus.Checked = false;
                        }
                    }
                    else if (ParmName.Equals("txtLoginName"))
                    {
                        txtLoginName.Text = ParmVal;
                    }
                    else if (ParmName.Equals("txtPw1"))
                    {
                        txtPw1.Text = ParmVal;
                        txtPw2.Text = ParmVal;
                    }
                    else if (ParmName.Equals("cbSavedDefinitions"))
                    {
                        cbSavedDefinitions.Text = ParmVal;
                    }
                    else if (ParmName.Equals("ckHive"))
                    {
                        if (ParmVal.Equals("True"))
                        {
                            ckHive.Checked = true;
                        }
                        else
                        {
                            ckHive.Checked = false;
                        }
                    }
                    else if (ParmName.Equals("txtDBName"))
                    {
                        txtDBName.Text = ParmVal;
                    }
                }
            }

            MasterLoaded = true;
            SB.Text = "Global setup parms loaded.";
            MasterConnstr = BuildConnstr();
            txtMstr.Text = MasterConnstr;
        }

        public string BuildConnstr()
        {
            string S = "";
            if (!ckWindowsAuthentication.Checked)
            {
                S = "Data Source=" + txtServerInstance.Text.Trim() + ";Initial Catalog=" + txtRepositoryName.Text.Trim() + ";Persist Security Info=True;User ID='" + txtLoginName.Text.Trim() + "';Password='" + txtPw1.Text.Trim() + "'";
            }
            else
            {
                S = "Data Source='" + txtServerInstance.Text.Trim() + "';Initial Catalog='" + txtRepositoryName.Text.Trim() + "';Integrated Security=True";
            }

            return S;
        }

        private string getConnStr()
        {
            string CS = BuildConnstr();
            return CS;
        }

        public bool ExecuteSqlNewConn(string sql)
        {
            if (MasterConnstr.Trim().Length == 0)
            {
                MessageBox.Show("Please, you must define and save the repository first, execution cancelled - returning.");
                return false;
            }

            bool rc = false;
            var CN = new SqlConnection(MasterConnstr);
            CN.Open();
            var dbCmd = CN.CreateCommand();
            bool BB = true;
            try
            {
                using (CN)
                {
                    dbCmd.Connection = CN;
                    try
                    {
                        dbCmd.CommandText = sql;
                        dbCmd.ExecuteNonQuery();
                        BB = true;
                    }
                    catch (Exception ex)
                    {
                        rc = false;
                        MessageBox.Show("ERROR SQL Execution: " + Constants.vbCrLf + Constants.vbCrLf + sql + Constants.vbCrLf + Constants.vbCrLf + ex.Message);
                    }
                }
            }
            catch (Exception ex)
            {
            }
            finally
            {
                if (CN.State == ConnectionState.Open)
                {
                    CN.Close();
                }

                CN = null;
                dbCmd = null;
                GC.Collect();
                GC.WaitForFullGCComplete();
            }

            return BB;
        }

        public int iCount(string S)
        {
            if (MasterConnstr.Trim().Length == 0)
            {
                MessageBox.Show("You must define and save the Respoitory before defining the Thesaurus.");
                return -1;
            }

            int Cnt = -1;
            SqlDataReader rsData = null;
            bool b = false;
            string CS = MasterConnstr;
            var CONN = new SqlConnection(CS);
            try
            {
                CONN.Open();
                var command = new SqlCommand(S, CONN);
                rsData = command.ExecuteReader();
                rsData.Read();
                Cnt = rsData.GetInt32(0);
                rsData.Close();
                rsData = null;
                return Cnt;
            }
            catch (Exception ex)
            {
                MessageBox.Show("clsDatabaseARCH : iCount : 2054 : " + ex.Message);
                return -1;
            }
            finally
            {
                if (rsData is object)
                {
                    if (!rsData.IsClosed)
                    {
                        rsData.Close();
                    }

                    rsData = null;
                    CONN.Dispose();
                }

                GC.Collect();
                GC.WaitForFullGCComplete();
            }

            return Cnt;
        }

        private void cbSavedDefinitions_TextChanged(object sender, EventArgs e)
        {
            cbSavedDefinitions.Text = cbSavedDefinitions.Text.Replace("'", "");
        }

        public string GetGlobalFileName()
        {
            string FN = "";
            if (rbThesaurus.Checked)
            {
                FN = @"\Thesaurus.EcmAutoInstall.dat";
            }
            else
            {
                FN = @"\Repository.EcmAutoInstall.dat";
            }

            return FN;
        }

        private void btnResetGlobalLocationToDefault_Click(object sender, EventArgs e)
        {
            txtGlobalFileDirectory.Text = @"C:\EcmLibrary\Global";
        }

        private void btnLoadCombo_Click(object sender, EventArgs e)
        {
            if (MasterConnstr.Trim().Length == 0)
            {
                MessageBox.Show("ERROR: the master setup has not been set, returning.");
                return;
            }

            bLoadingCB = true;
            int PID = 0;
            string s = "SELECT [ConnectionName] FROM [Repository] order by [ConnectionName]";
            SqlDataReader rsData = null;
            string CS = MasterConnstr;
            var CONN = new SqlConnection(CS);
            cbSavedDefinitions.Items.Clear();
            CONN.Open();
            var command = new SqlCommand(s, CONN);
            rsData = command.ExecuteReader();
            if (rsData.HasRows)
            {
                while (rsData.Read())
                {
                    string ConnectionName = rsData.GetValue(0).ToString();
                    cbSavedDefinitions.Items.Add(ConnectionName);
                }
            }

            if (rsData is object)
            {
                if (!rsData.IsClosed)
                {
                    rsData.Close();
                }

                rsData = null;
            }

            CONN.Dispose();
            GC.Collect();
            bLoadingCB = false;
        }

        private void btnLoadData_Click(object sender, EventArgs e)
        {
            if (MasterConnstr.Trim().Length == 0)
            {
                MessageBox.Show("ERROR: the master setup has not been set, returning.");
                return;
            }

            if (bLoadingCB)
            {
                return;
            }
            // ** Get the database data

            string tgtName = cbSavedDefinitions.Text.Trim();
            string CS = MasterConnstr;
            string S = "SELECT [ConnectionName] ,[ConnectionData] ,[ConnectionDataThesaurus] FROM [ECM.Library].[dbo].[Repository] where [ConnectionName] = '" + tgtName + "'";
            string ConnectionName = "";
            string ConnectionData = "";
            string ConnectionDataThesaurus = "";
            SqlDataReader rsData = null;
            var CONN = new SqlConnection(CS);
            CONN.Open();
            var command = new SqlCommand(S, CONN);
            rsData = command.ExecuteReader();
            if (rsData.HasRows)
            {
                while (rsData.Read())
                {
                    ConnectionName = rsData.GetValue(0).ToString();
                    ConnectionData = rsData.GetValue(1).ToString();
                    ConnectionDataThesaurus = rsData.GetValue(2).ToString();
                }
            }

            if (rsData is object)
            {
                if (!rsData.IsClosed)
                {
                    rsData.Close();
                }

                rsData = null;
            }

            CONN.Dispose();
            GC.Collect();
            if (rbRepository.Checked)
            {
                DecryptParmsAndApply(ConnectionData);
            }
            else if (ConnectionDataThesaurus.Length == 0)
            {
                MessageBox.Show("The thesaurus has not been established for this profile.");
            }
            else
            {
                DecryptParmsAndApply(ConnectionDataThesaurus);
            }

            bLoadingCB = false;
        }

        public void DecryptParmsAndApply(string tgtStr)
        {
            string DecryptedParms = ENC.AES256DecryptString(tgtStr);
            var A = DecryptedParms.Split('\u007f');
            foreach (var S in A)
            {
                var Parm = S.Split('|');
                string ParmName = Parm[0];
                if (ParmName.Trim().Length > 0)
                {
                    string ParmVal = Parm[1];
                    if (ParmName.Equals("txtGlobalFileDirectory"))
                    {
                        txtGlobalFileDirectory.Text = ParmVal;
                    }
                    else if (ParmName.Equals("txtRepositoryName"))
                    {
                        txtRepositoryName.Text = ParmVal;
                    }
                    else if (ParmName.Equals("txtServerInstance"))
                    {
                        txtServerInstance.Text = ParmVal;
                    }
                    else if (ParmName.Equals("ckWindowsAuthentication"))
                    {
                        if (ParmVal.Equals("True"))
                        {
                            ckWindowsAuthentication.Checked = true;
                        }
                        else
                        {
                            ckWindowsAuthentication.Checked = false;
                        }
                    }
                    else if (ParmName.Equals("ckRepository"))
                    {
                        if (ParmVal.Equals("True"))
                        {
                            rbRepository.Checked = true;
                        }
                        else
                        {
                            rbRepository.Checked = false;
                        }
                    }
                    else if (ParmName.Equals("ckThesaurus"))
                    {
                        if (ParmVal.Equals("True"))
                        {
                            rbThesaurus.Checked = true;
                        }
                        else
                        {
                            rbThesaurus.Checked = false;
                        }
                    }
                    else if (ParmName.Equals("txtLoginName"))
                    {
                        txtLoginName.Text = ParmVal;
                    }
                    else if (ParmName.Equals("txtPw1"))
                    {
                        txtPw1.Text = ParmVal;
                        txtPw2.Text = ParmVal;
                    }
                    else if (ParmName.Equals("cbSavedDefinitions"))
                    {
                        cbSavedDefinitions.Text = ParmVal;
                    }
                    else if (ParmName.Equals("ckHive"))
                    {
                        if (ParmVal.Equals("True"))
                        {
                            ckHive.Checked = true;
                        }
                        else
                        {
                            ckHive.Checked = false;
                        }
                    }
                    else if (ParmName.Equals("txtDBName"))
                    {
                        txtDBName.Text = ParmVal;
                    }
                }
            }
        }

        private void GotoGlobalDirectoryToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string AppPath = txtGlobalFileDirectory.Text;
            var procstart = new ProcessStartInfo("explorer");
            procstart.Arguments = AppPath;
            Process.Start(procstart);
        }

        private void GotoApplicationDirectoryToolStripMenuItem_Click(object sender, EventArgs e)
        {
            string AppPath = AppDomain.CurrentDomain.BaseDirectory;
            var procstart = new ProcessStartInfo("explorer");
            string winDir = Path.GetDirectoryName(AppPath);
            procstart.Arguments = AppPath;
            Process.Start(procstart);
        }

        // Private Sub LicenseToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LicenseToolStripMenuItem.Click

        // frmLicense.txtServerName.Text = txtDBName.Text
        // frmLicense.txtServer.Text = txtServerInstance.Text.Trim
        // frmLicense.txtCurrConnStr.Text = BuildConnstr()
        // frmLicense.Show()

        // End Sub
    }
}
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using ECMEncryption;
using System.IO;
using System.Configuration;
using System.Collections.Specialized;
using System.Text.RegularExpressions;
using System.Diagnostics;

namespace ConfigSetup
{
    public partial class frmMain : Form
    {
        int LastSearchRow = -1;

        ECMEncrypt ENC = new ECMEncrypt();
        int iSel = -1;
        bool busy = false;
        public frmMain()
        {
            InitializeComponent();

            ckCaseSensitive.Visible = false;
            txtToken.Visible = false;
            button2.Visible = false;

        }

        private void frmMain_Load(object sender, EventArgs e)
        {

        }

        private void btnOpen_Click(object sender, EventArgs e)
        {
            lbFileContents.Items.Clear();
            string fqn = SB.Text;
            List<string> allLinesText = File.ReadAllLines(fqn).ToList();
            foreach (string str in allLinesText)
            {
                lbFileContents.Items.Add(str);
            }

        }

        private void btnApply_Click(object sender, EventArgs e)
        {
            txtEncPW.Text = ENC.AES256EncryptString(txtPw.Text);
        }

        private void txtPw_TextChanged(object sender, EventArgs e)
        {
            txtEncPW.Text = ENC.AES256EncryptString(txtPw.Text.Trim());
        }

        private void btnGetList_Click(object sender, EventArgs e)
        {
            lbFiles.Items.Clear();
            var fbd = new FolderBrowserDialog();
            DialogResult result = fbd.ShowDialog();

            if (result == DialogResult.OK && !string.IsNullOrWhiteSpace(fbd.SelectedPath))
            {
                string[] allfiles = Directory.GetFiles(fbd.SelectedPath, "*.*", SearchOption.AllDirectories);
                foreach (var file in allfiles)
                {
                    FileInfo info = new FileInfo(file);
                    if (info.Name.ToLower().Equals("web.config"))
                    {
                        lbFiles.Items.Add(info.FullName);
                    }
                    if (info.Name.ToLower().Equals("app.config"))
                    {
                        lbFiles.Items.Add(info.FullName);
                    }
                }
                lbFiles.Sorted = true;
            }

        }

        private void lbFiles_SelectedIndexChanged(object sender, EventArgs e)
        {
            SB.Text = lbFiles.SelectedItem.ToString();
            lblCurrFile.Text = lbFiles.SelectedItem.ToString();
            btnOpen_Click(null, null);
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            string bakdir = @"C:\TEMP\ECM\Backup\Configs\";
            if (!Directory.Exists(bakdir))
            {
                Directory.CreateDirectory(bakdir);
            }
            
            string fqn = lblCurrFile.Text;
            string backupfqn = Path.GetFileNameWithoutExtension(fqn);
            backupfqn += DateTime.Now.Year.ToString() + "-" + DateTime.Now.Month.ToString() + "-" + DateTime.Now.Day.ToString() + "-" + DateTime.Now.Hour.ToString() + "-" + DateTime.Now.Minute.ToString() + "-" + DateTime.Now.Second.ToString();
            backupfqn += Path.GetExtension(fqn);
            backupfqn = bakdir + backupfqn;

            File.Copy(lblCurrFile.Text, backupfqn);

            string[] lines = lbFileContents.Items.OfType<string>().ToArray();
            System.IO.File.WriteAllLines(fqn, lines);

        }

        private void btnApplyLine_Click(object sender, EventArgs e)
        {
            if (busy == true)
            {
                return;
            }
            busy = true;
            if (txtLine.Text.Trim().Length > 0)
            {
                lbFileContents.SelectedItem = txtLine.Text;
                int idx = Convert.ToInt32(lblItemID.Text);
                lbFileContents.Items[idx] = txtLine.Text;
                lbFileContents.SetSelected(idx, true);
            }
            busy = false;
        }

        private void lbFileContents_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (busy == true)
            {
                return;
            }
            busy = true;
            string str = "";
            str = lbFileContents.SelectedItem.ToString();
            String[] items = str.Split('"');

            txtLine.Text = str;
            lblItemID.Text = lbFileContents.SelectedIndex.ToString();
            if (items.Length > 1)
            {
                string skey = items[1];
                if (skey.ToLower().Contains("encpw"))
                {
                    iSel = lbFileContents.SelectedIndex;
                    string val = items[3];
                    txtEncPW.Text = val;

                }
                if (str.ToUpper().Contains("@@PW@@"))
                {
                    string val = items[3];
                    txtEncConnstr.Text = val;

                }
            }
            busy = false;
        }

        private void btnDecrypt_Click(object sender, EventArgs e)
        {
            string str = txtEncPW.Text;
            str = ENC.AES256DecryptString(str);
            txtPw.Text = str;
        }

        private void btnTestEnc_Click(object sender, EventArgs e)
        {
            if (busy == true)
            {
                return;
            }
            busy = true;
            try
            {
                string EncodedPW = txtEncPW.Text.Trim();
                if (EncodedPW.Trim().Length == 0)
                {
                    MessageBox.Show("An encrypted password MUST be supplied, returning...");
                    return;
                }
                string PW = ENC.AES256DecryptString(EncodedPW);
                System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection();
                string cs = txtEncConnstr.Text;
                cs = cs.Replace("@@PW@@", PW);
                conn.ConnectionString = cs;
                conn.Open();
                if (conn.State.Equals(ConnectionState.Open))
                {
                    MessageBox.Show("SUCCESS: Connected");
                    conn.Close();
                    conn.Dispose();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("FAILED TO OPEN: " + Environment.NewLine + ex.Message);
            }
            busy = false;

        }

        private void btnClipboard_Click(object sender, EventArgs e)
        {
            if (busy == true)
            {
                return;
            }
            busy = true;
            string encpw = txtEncPW.Text;
            string str = "";
            str = lbFileContents.Items[iSel].ToString();
            String[] items = str.Split('"');
            txtLine.Text = str;
            string skey = items[1];
            if (skey.ToLower().Contains("encpw"))
            {
                iSel = lbFileContents.SelectedIndex;
                items[3] = encpw;
            }

            items[1] = '"' + items[1] + '"';
            items[3] = '"' + items[3] + '"';

            string newstr = "";
            foreach (string s in items)
            {
                newstr += s;
            }
            lbFileContents.Items[iSel] = newstr;
            lbFileContents.SetSelected(iSel, true);
            busy = false;
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            if (lbFiles.SelectedItems.Count == 1)
            {
                string fqn = lbFiles.SelectedItem.ToString();
                //System.Diagnostics.Process.Start("notepad.exe") fqn;
                Process.Start("notepad.exe", fqn);
            }
            else
            {
                MessageBox.Show("Please select a file to edit, returning...");
            }
            
        }

        private void button1_Click(object sender, EventArgs e)
        {
            bool bb = false;
            foreach (string fqn in lbFiles.Items)
            {
                string bakdir = @"C:\TEMP\ECM\Backup\Configs\";
                string backupfqn = Path.GetFileNameWithoutExtension(fqn);
                backupfqn += "."+DateTime.Now.Year.ToString() + "-" + DateTime.Now.Month.ToString() + "-" + DateTime.Now.Day.ToString() + "-" + DateTime.Now.Hour.ToString() + "-" + DateTime.Now.Minute.ToString() + "-" + DateTime.Now.Second.ToString();
                backupfqn += Path.GetExtension(fqn);
                backupfqn = bakdir + backupfqn;

                if (File.Exists(backupfqn))
                {
                    File.Delete(backupfqn);
                }
                File.Copy(fqn, backupfqn);

                string[] lines = File.ReadAllLines(fqn);

                for (int i = 0; i < lines.Count(); i++)
                {
                    string line = lines[i];
                    if (line.ToLower().Contains("<add key")){
                        if (line.ToLower().Contains("encpw")){
                            String[] items = line.Split('"');
                            items[1] = '"' + items[1] + "'";
                            items[3] = '"' + txtEncPW.Text + '"';

                            string newstr = "";
                            foreach (string s in items)
                            {
                                newstr += s;
                            }

                            lines[i] = newstr;
                        }
                    }
                }

                if (bb == true)
                    System.IO.File.WriteAllLines(fqn, lines);

                MessageBox.Show("Completed apply...");
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string token = txtToken.Text;
            string tgttoken = txtToken.Text;
            if (ckCaseSensitive.Checked == false)
            {
                tgttoken = tgttoken.ToLower();
            }

            foreach (string fqn in lbFiles.Items)
            {
                string bakdir = @"C:\TEMP\ECM\Backup\Configs\";
                string backupfqn = Path.GetFileNameWithoutExtension(fqn);
                backupfqn += DateTime.Now.Year.ToString() + "-" + DateTime.Now.Month.ToString() + "-" + DateTime.Now.Day.ToString() + "-" + DateTime.Now.Hour.ToString() + "-" + DateTime.Now.Minute.ToString() + "-" + DateTime.Now.Second.ToString();
                backupfqn += Path.GetExtension(fqn);
                backupfqn = bakdir + backupfqn;

                File.Copy(lblCurrFile.Text, backupfqn);

                string[] lines = File.ReadAllLines(fqn);

                for (int i = 0; i < lines.Count(); i++)
                {
                    bool b = false;
                    string line = lines[i];

                    if (ckCaseSensitive.Checked == false)
                    {
                        if (line.ToLower().Contains(tgttoken))
                            b = true;
                    }
                    else
                    {
                        if (line.Contains(token))
                            b = true;
                    }

                    if (b == true)
                        {
                        string[] items = line.Split(new Char[] { ' ', '=', '"', ',', '\\', '<', '>', '\n' });
                        //string[] items = Regex.Split(line, @" ");

                        string newstr = "";
                            foreach (string s in items)
                            {
                                newstr += s;
                            }

                            lines[i] = newstr;
                        }
                    
                }

                System.IO.File.WriteAllLines(fqn, lines);

            }
        }

        private void btnFind_Click(object sender, EventArgs e)
        {
            busy = true;
            string TypeSearch = cbLocate.Text;
            int CurrLoc = 0;
            int MaxLines = lbFileContents.Items.Count;
            string str = "";
            
            if (TypeSearch.ToLower().Equals("password"))
            {
                for (CurrLoc = LastSearchRow + 1; CurrLoc < MaxLines; CurrLoc++)
                {
                    str = lbFileContents.Items[CurrLoc].ToString();
                    if (str.ToLower().IndexOf("encpw") > 0)
                    {
                        lbFileContents.SelectedIndex = CurrLoc;
                        lbFileContents.SelectedItem = true;
                        LastSearchRow = CurrLoc;
                        break;
                    }
                }
                if (CurrLoc == MaxLines)
                {
                    LastSearchRow = -1;
                    SB.Text = "END OF SEARCH...";
                }
            }
            else
            {
                for (CurrLoc = LastSearchRow + 1; CurrLoc < MaxLines; CurrLoc++)
                {
                    str = lbFileContents.Items[CurrLoc].ToString();
                    if (str.ToLower().IndexOf(TypeSearch.ToLower()) > 0)
                    {
                        lbFileContents.SelectedIndex = CurrLoc;
                        lbFileContents.SelectedItem = true;
                        LastSearchRow = CurrLoc;
                        break;
                    }
                }
            }

            if (CurrLoc == MaxLines)
            {
                LastSearchRow = -1;
                SB.Text = "END OF SEARCH...";
            }
            busy = false;
        }
    }
}

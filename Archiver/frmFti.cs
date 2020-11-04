using System;
using global::System.IO;
using System.Windows.Forms;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public partial class frmFti
    {
        public frmFti()
        {
            InitializeComponent();
            _lbFtiLogs.Name = "lbFtiLogs";
            _btnScanGuids.Name = "btnScanGuids";
            _btnSelectAll.Name = "btnSelectAll";
            _lbOutput.Name = "lbOutput";
            _Button1.Name = "Button1";
            _btnFindItem.Name = "btnFindItem";
        }

        private clsDatabaseARCH DBArch = new clsDatabaseARCH();

        private void frmFti_Load(object sender, EventArgs e)
        {
            getFtiLogs();
        }

        public void getFtiLogs()
        {
            var files = Directory.GetFiles(modGlobals.FTILogs);
            string FName = "";
            lbFtiLogs.Items.Clear();
            foreach (string file in files)
            {
                FName = Path.GetFileName(file);
                lbFtiLogs.Items.Add(FName);
                // Dim text As String = IO.File.ReadAllText(file)
            }
        }

        private void btnSelectAll_Click(object sender, EventArgs e)
        {
            int i;
            var loopTo = lbFtiLogs.Items.Count - 1;
            for (i = 0; i <= loopTo; i++)
                lbFtiLogs.SetSelected(i, true);
        }

        private void btnScanGuids_Click(object sender, EventArgs e)
        {
            lbOutput.Items.Clear();
            string FQN = "";
            string TgtText = txtSourceGuid.Text;
            int I = 0;
            int IFound = 0;
            int MaxCnt = Convert.ToInt32(txtMaxNbr.Text);
            foreach (string S in lbFtiLogs.SelectedItems)
            {
                FQN = modGlobals.FTILogs + @"\" + S;
                var reader = My.MyProject.Computer.FileSystem.OpenTextFileReader(FQN);
                string line;
                SBFqn.Text = S;
                Cursor = Cursors.WaitCursor;
                do
                {
                    Application.DoEvents();
                    I += 1;
                    if (I >= MaxCnt)
                    {
                        break;
                    }

                    if (I % 100 == 0)
                    {
                        SB.Text = I.ToString();
                        SB.Refresh();
                    }

                    line = reader.ReadLine();
                    if (!Information.IsNothing(line))
                    {
                        if (line.Contains(TgtText))
                        {
                            lbOutput.Items.Add(line);
                            IFound += 1;
                            lblMsg.Text = "Items Found: " + IFound.ToString();
                        }
                    }
                }
                while (!(line is null));
                Cursor = Cursors.Default;
                reader.Close();
                reader.Dispose();
                SB.Text = "";
                SBFqn.Text = "";
            }
        }

        private void lbFtiLogs_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            string key = "SQLFT0001200010.LOG.4";
            string lbkey = "";
            int i;
            var loopTo = lbFtiLogs.Items.Count - 1;
            for (i = 0; i <= loopTo; i++)
                lbFtiLogs.SetSelected(i, false);
            var loopTo1 = lbFtiLogs.Items.Count - 1;
            for (i = 0; i <= loopTo1; i++)
            {
                lbkey = Conversions.ToString(lbFtiLogs.Items[i]);
                if ((lbkey ?? "") == (key ?? ""))
                {
                    lbFtiLogs.SetSelected(i, true);
                }
            }
        }

        private void lbOutput_SelectedIndexChanged(object sender, EventArgs e)
        {
            string s = Conversions.ToString(lbOutput.SelectedItems[0]);
            txtDetail.Text = s;
            string tkey = "";
            string db = "";
            int i = 0;
            int k = 0;
            try
            {
                i = s.IndexOf("view");
                if (i >= 0)
                {
                    i = s.IndexOf("'", i + 1);
                    j = s.IndexOf("'", i + 1);
                    db = s.Substring(i + 1, Conversions.ToInteger(Operators.SubtractObject(Operators.SubtractObject(j, i), 1)));
                    txtDb.Text = db;
                }

                i = s.IndexOf("key value");
                if (i >= 0)
                {
                    i = s.IndexOf("'", i + 1);
                    j = s.IndexOf("'", i + 1);
                    tkey = s.Substring(i + 1, Conversions.ToInteger(Operators.SubtractObject(Operators.SubtractObject(j, i), 1)));
                    txtKeyGuid.Text = tkey;
                }
            }
            catch (Exception ex)
            {
                SB.Text = "ERROR: " + ex.Message;
            }
        }

        private void btnFindItem_Click(object sender, EventArgs e)
        {
            string fqn = "";
            string db = txtDb.Text.ToUpper();
            int i = db.IndexOf("EMAILATTACHMENT");
            int j = db.IndexOf("DataSource");
            if (i >= 0)
            {
                fqn = DBArch.getFqnFromGuid(txtSourceGuid.Text, "EmailAttachment");
                SBFqn.Text = fqn;
                SB.Text = Path.GetFileName(fqn);
            }
            else if (j >= 0)
            {
                fqn = DBArch.getFqnFromGuid(txtSourceGuid.Text);
                SBFqn.Text = fqn;
                SB.Text = Path.GetFileName(fqn);
            }
            else
            {
                SB.Text = "NOTICE: Cannot retrieve data from this information.";
            }
        }
    }
}
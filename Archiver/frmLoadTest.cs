using System;
using global::System.IO;
using System.Windows.Forms;
using MODI;

namespace EcmArchiver
{
    public partial class frmLoadTest
    {
        public frmLoadTest()
        {
            InitializeComponent();
            _lbFiles.Name = "lbFiles";
            _lbDirs.Name = "lbDirs";
            _btnRun.Name = "btnRun";
            _btnDir.Name = "btnDir";
            _Button1.Name = "Button1";
        }

        private void lbFiles_SelectedIndexChanged(object sender, EventArgs e)
        {
        }

        private void frmLoadTest_Load(object sender, EventArgs e)
        {
        }

        private void btnDir_Click(object sender, EventArgs e)
        {
            var result = FolderBrowserDialog1.ShowDialog();

            // Test result.
            if (result == DialogResult.OK)
            {
                txtDir.Text = FolderBrowserDialog1.SelectedPath;
            }
        }

        private void btnRun_Click(object sender, EventArgs e)
        {
            var dir = new DirectoryInfo(txtDir.Text);
            lbDirs.Items.Clear();
            lbDirs.Items.Add(dir);
            lbDirs.Sorted = true;
            foreach (DirectoryInfo dirItem in dir.GetDirectories())
                lbDirs.Items.Add(dirItem.FullName);
        }

        private void lbDirs_SelectedIndexChanged(object sender, EventArgs e)
        {
            string targetDirectory = "";
            targetDirectory = lbDirs.SelectedItems[0].ToString();
            string[] txtFilesArray = null;
            if (ckSubdir.Checked)
            {
                txtFilesArray = Directory.GetFiles(targetDirectory, "*.*", SearchOption.AllDirectories);
            }
            else
            {
                txtFilesArray = Directory.GetFiles(targetDirectory, "*.*", SearchOption.TopDirectoryOnly);
            }

            lbFiles.Items.Clear();
            lbFiles.Sorted = true;
            foreach (string fname in txtFilesArray)
                lbFiles.Items.Add(fname);
        }

        private void Button1_Click(object sender, EventArgs e)
        {
            string SearchTgt = txtSearch.Text.ToLower();
            string S = "";
            int J = 0;
            int iCnt = 0;
            lbFiles.SelectedItems.Clear();
            for (int I = 0, loopTo = lbFiles.Items.Count - 1; I <= loopTo; I++)
            {
                S = lbFiles.Items[I].ToString().ToLower();
                J = S.IndexOf(SearchTgt);
                if (J >= 0)
                {
                    lbFiles.SetSelected(I, true);
                    iCnt += 1;
                }
            }

            MessageBox.Show("Items Found: " + iCnt.ToString());
        }
    }
}
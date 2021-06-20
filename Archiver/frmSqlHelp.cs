using System;
using System.Windows.Forms;
using Microsoft.VisualBasic.CompilerServices;
using MODI;

namespace EcmArchiver
{
    public partial class frmSqlHelp
    {
        public frmSqlHelp()
        {
            InitializeComponent();
            _cbDirectory.Name = "cbDirectory";
            _btnOpenFile.Name = "btnOpenFile";
            _btnAddFile.Name = "btnAddFile";
            _btnCopy.Name = "btnCopy";
            _rtbFile.Name = "rtbFile";
        }

        private void RichTextBox1_TextChanged(object sender, EventArgs e)
        {
        }

        private void cbDirectory_SelectedIndexChanged(object sender, EventArgs e)
        {
            string DIR = "";
            string FN = "";
            try
            {
                int idx = cbDirectory.SelectedIndex;
                if (cbDirectory.Items[idx].ToString().Equals("Fulltext Index Routines"))
                {
                    DIR = My.MyProject.Application.Info.DirectoryPath + @"\_FTI";
                    var files = System.IO.Directory.GetFiles(DIR);
                    lbFiles.Items.Clear();
                    foreach (string file in files)
                    {
                        FN = System.IO.Path.GetFileName(file);
                        lbFiles.Items.Add(FN);
                        // Dim text As String = IO.File.ReadAllText(file)
                    }
                }
                else if (cbDirectory.Items[idx].ToString().Equals("SQL Routines"))
                {
                    DIR = My.MyProject.Application.Info.DirectoryPath + @"\_SQL_Query";
                    var files = System.IO.Directory.GetFiles(DIR);
                    lbFiles.Items.Clear();
                    foreach (string file in files)
                    {
                        FN = System.IO.Path.GetFileName(file);
                        lbFiles.Items.Add(FN);
                        // Dim text As String = IO.File.ReadAllText(file)
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Oh No! Something went wrong..." + Environment.NewLine + ex.Message);
            }
        }

        private void btnOpenFile_Click(object sender, EventArgs e)
        {
            try
            {
                string DIR = "";
                string FileName = "";
                string FQN = "";
                int idx = cbDirectory.SelectedIndex;
                if (cbDirectory.Items[idx].ToString().Equals("Fulltext Index Routines"))
                {
                    DIR = My.MyProject.Application.Info.DirectoryPath + @"\_FTI";
                    FileName = Conversions.ToString(lbFiles.SelectedItems[0]);
                    FQN = DIR + @"\" + FileName;
                }
                else if (cbDirectory.Items[idx].ToString().Equals("SQL Routines"))
                {
                    DIR = My.MyProject.Application.Info.DirectoryPath + @"\_SQL_Query";
                    FileName = Conversions.ToString(lbFiles.SelectedItems[0]);
                    FQN = DIR + @"\" + FileName;
                }

                rtbFile.Text = Microsoft.VisualBasic.FileIO.FileSystem.ReadAllText(FQN);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Oh No! Something went wrong..." + Environment.NewLine + ex.Message);
            }
        }

        private void btnCopy_Click(object sender, EventArgs e)
        {
            try
            {
                string txt = "";
                txt = rtbFile.Text;
                Clipboard.Clear();
                Clipboard.SetText(txt);
                MessageBox.Show("File text is in the Clipboard...");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Oh No! Something went wrong..." + Environment.NewLine + ex.Message);
            }
        }

        private void btnAddFile_Click(object sender, EventArgs e)
        {
            try
            {
                string DIR = "";
                string FQN = "";
                int Idx = cbDirectory.SelectedIndex;
                if (cbDirectory.Items[Idx].ToString().Equals("Fulltext Index Routines"))
                {
                    DIR = My.MyProject.Application.Info.DirectoryPath + @"\_FTI";
                }
                else if (cbDirectory.Items[Idx].ToString().Equals("SQL Routines"))
                {
                    DIR = My.MyProject.Application.Info.DirectoryPath + @"\_SQL_Query";
                }

                string NewFile = "";
                string FileName = "";
                var result = OpenFileDialog1.ShowDialog();
                if (result == DialogResult.OK)
                {
                    NewFile = OpenFileDialog1.FileName;
                    FileName = System.IO.Path.GetFileName(NewFile);
                    FQN = DIR + @"\" + FileName;
                    My.MyProject.Computer.FileSystem.CopyFile(NewFile, FQN, overwrite: false);
                    MessageBox.Show("File copied...");
                    cbDirectory_SelectedIndexChanged(null, null);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Oh No! Something went wrong..." + Environment.NewLine + ex.Message);
            }
        }
    }
}
using global::System;
using global::System.IO;
using global::System.Windows.Forms;
using Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public partial class FrmListenerTest
    {
        public FrmListenerTest()
        {
            InitializeComponent();
            if (File.Exists(@"C:\_ChangeLogs\FileChanges.dat"))
            {
                File.Delete(@"C:\_ChangeLogs\FileChanges.dat");
            }

            _Button1.Name = "Button1";
            _Button2.Name = "Button2";
            _btnViewLog.Name = "btnViewLog";
        }

        private FileSystemWatcher watchfolder = new FileSystemWatcher();

        private void Button1_Click(object sender, EventArgs e)
        {
            var dlg = new FolderBrowserDialog();
            if (dlg.ShowDialog() == DialogResult.OK)
            {
                txtDir.Text = dlg.SelectedPath;
            }
        }

        private void Button2_Click(object sender, EventArgs e)
        {
            StartLIstener2();
        }

        public void StartLIstener2()
        {

            // Dim watchfolder As = New System.IO.FileSystemWatcher()

            // this is the path we want to monitor
            watchfolder.Path = txtDir.Text;

            // Add a list of Filter we want to specify
            // make sure you use OR for each Filter as we need to
            // all of those 

            // watchfolder.NotifyFilter = IO.NotifyFilters.DirectoryName
            watchfolder.NotifyFilter = watchfolder.NotifyFilter | NotifyFilters.FileName;
            watchfolder.NotifyFilter = watchfolder.NotifyFilter | NotifyFilters.Attributes;

            // add the handler to each event
            watchfolder.Changed += logchange;
            watchfolder.Created += logchange;
            watchfolder.Deleted += logchange;

            // add the rename handler as the signature is different
            watchfolder.Renamed += logrename;

            // Set this property to true to start watching
            watchfolder.EnableRaisingEvents = true;
            Button2.Enabled = false;
            ckStop.Enabled = true;

            // End of code for btn_start_click
        }

        public void StopListener()
        {
            if (ckStop.Checked.Equals(true))
            {
                watchfolder.EnableRaisingEvents = false;
                Button2.Enabled = true;
                ckStop.Enabled = false;
            }
        }

        private void logchange(object source, FileSystemEventArgs e)
        {
            string Msg = "";
            if (e.ChangeType == WatcherChangeTypes.Changed)
            {
                Msg = "U|" + e.FullPath + "|";
                SaveChanges(Msg);
            }

            if (e.ChangeType == WatcherChangeTypes.Created)
            {
                Msg = "C|" + e.FullPath + "|";
                SaveChanges(Msg);
            }

            if (e.ChangeType == WatcherChangeTypes.Deleted)
            {
                Msg = "D|" + e.FullPath + "|";
                SaveChanges(Msg);
            }
        }

        public void logrename(object source, RenamedEventArgs e)
        {
            string Msg = "";
            Msg = "R|" + e.OldName + "|" + e.Name;
            SaveChanges(Msg);
        }

        private void SaveChanges(string Msg)
        {
            string TS = DateAndTime.Now.Ticks.ToString();
            string T = DateAndTime.Now.ToLongDateString().ToString();
            Msg = T + "|" + TS + "|" + Msg;
            if (!Directory.Exists(@"C:\_ChangeLogs"))
            {
                Directory.CreateDirectory(@"C:\_ChangeLogs");
            }

            string FQN = @"C:\_ChangeLogs\FileChanges.dat";
            try
            {
                using (var SW = new StreamWriter(FQN, true))
                {
                    SW.WriteLine(Msg);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Could not store data into file " + FQN + Constants.vbCrLf + ex.Message + ". Program terminating.", "Error", MessageBoxButtons.OK);
            }
        }

        private void btnViewLog_Click(object sender, EventArgs e)
        {
            string FQN = @"C:\_ChangeLogs\FileChanges.dat";
            try
            {
                lbOutput.Items.Clear();
                var reader = My.MyProject.Computer.FileSystem.OpenTextFileReader(FQN);
                string a;
                do
                {
                    a = reader.ReadLine();
                    lbOutput.Items.Add(a);
                }
                while (!(a is null));
                reader.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Could not store data into file " + FQN + ". Program terminating.", "Error", MessageBoxButtons.OK);
            }
        }
    }
}
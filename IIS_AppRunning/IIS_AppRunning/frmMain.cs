using System;
using System.IO;
using System.Net;
using System.Windows.Forms;

namespace IIS_AppRunning
{
    public partial class frmMain : Form
    {

        string fqn = @"c:/temp/urls/ListOfUrls.dat";

        public frmMain ()
        {
            InitializeComponent ();
            loadUrls ();
        }

        private void btnCkService_Click (object sender, EventArgs e)
        {
            ckUrl ();
        }

        private void ckUrl ()
        {
            string url = txtUrl.Text;
            try
            {
                var myRequest = (HttpWebRequest)WebRequest.Create (url);
                var response = (HttpWebResponse)myRequest.GetResponse ();

                if (response.StatusCode == HttpStatusCode.OK)
                {
                    // it's at least in some way responsive but may be internally broken as you could
                    // find out if you called one of the methods for real
                    MessageBox.Show ("Available: " + url + Environment.NewLine + response.StatusDescription);
                }
                else
                {
                    // well, at least it returned...
                    MessageBox.Show ("ISSUE: " + response.StatusDescription);
                }
            }
            catch (Exception ex)
            {
                // not available at all, for some reason
                MessageBox.Show (string.Format ("{0} unavailable: {1}", url, ex.Message));
            }
        }

        private void loadUrls ()
        {
            if (!Directory.Exists (@"c:/temp/urls"))
            {
                Directory.CreateDirectory (@"c:/temp/urls");
            }

            if (!File.Exists (fqn))
                return;


            string line = "";
            lbUrls.Items.Clear ();

            System.IO.StreamReader file = new System.IO.StreamReader (fqn);
            while ((line = file.ReadLine ()) != null)
            {
                lbUrls.Items.Add (line);
            }
            file.Close ();
        }

        private void btnSave_Click (object sender, EventArgs e)
        {
            if (!Directory.Exists (@"c:/temp/urls"))
            {
                Directory.CreateDirectory (@"c:/temp/urls");
            }

            if (File.Exists (fqn))
                File.Delete (fqn);

            using (StreamWriter sw = File.CreateText (fqn))
            {
                foreach (string s in lbUrls.Items)
                {
                    sw.WriteLine (s);
                }
            }
            loadUrls ();
        }

        private void btnRemove_Click (object sender, EventArgs e)
        {
            if (!Directory.Exists (@"c:/temp/urls"))
            {
                Directory.CreateDirectory (@"c:/temp/urls");
            }

            if (File.Exists (fqn))
                File.Delete (fqn);

            string omit = lbUrls.SelectedItem.ToString ();
            
            using (StreamWriter sw = File.CreateText (fqn))
            {
                foreach (string s in lbUrls.Items)
                {
                    if (!s.Equals (omit))
                        sw.WriteLine (s);
                }
            }
            loadUrls ();
        }
    }
}
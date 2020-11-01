using System;
using MODI;

namespace EcmArchiver
{
    public partial class frmHelp
    {
        public string MsgToDisplay = "";
        public string CallingScreenName = "";
        public string CaptionName = "";

        public frmHelp()
        {
            // This call is required by the Windows Form Designer.
            InitializeComponent();

            // Add any initialization after the InitializeComponent() call.

        }

        private void frmHelp_Load(object sender, EventArgs e)
        {
            rtbText.Text = MsgToDisplay;
            lblScreenName.Text = CallingScreenName;
            lblObject.Text = CaptionName;
        }

        private void Timer1_Tick(object sender, EventArgs e)
        {
            Close();
        }
    }
}
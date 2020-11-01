using System;
using Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public partial class frmOutlookNotice
    {
        public frmOutlookNotice()
        {
            InitializeComponent();
            _btnTerminate.Name = "btnTerminate";
        }

        private clsUtility UTIL = new clsUtility();
        private int iSec = 1;

        private void btnTerminate_Click(object sender, EventArgs e)
        {
            UTIL.KillOutlookRunning();
        }

        private void Timer1_Tick(object sender, EventArgs e)
        {
            statElapsedTime.Text = DateAndTime.TimeOfDay.Second.ToString();
            if (iSec > 60)
            {
                iSec = 1;
            }

            PB.Value = iSec;
        }

        private void frmOutlookNotice_Load(object sender, EventArgs e)
        {
            PB.Minimum = 0;
            PB.Maximum = 60;
        }
    }
}
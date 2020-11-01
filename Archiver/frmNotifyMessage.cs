using System;
using System.Windows.Forms;
using MODI;

namespace EcmArchiver
{
    public partial class frmNotifyMessage
    {
        private int TimerCount = 0;
        public string MsgToDisplay = "";

        public frmNotifyMessage()
        {
            InitializeComponent();
            if (modGlobals.gNotifyMsg.Length.Equals(0))
            {
                Close();
                return;
            }

            txtMsg.Text = modGlobals.gNotifyMsg;
            T1_Tick(null, null);
        }

        private void T1_Tick(object sender, EventArgs e)
        {
            TimerCount += 1;
            txtMsg.Text = modGlobals.gNotifyMsg;
            Refresh();
            Application.DoEvents();
            if (TimerCount >= 6)
            {
                Close();
            }
        }
    }
}
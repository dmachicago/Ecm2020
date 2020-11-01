using System;
using Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public partial class frmNotify2
    {
        public frmNotify2()
        {
            InitializeComponent();
        }

        public string Title = "";

        private void frmNotify2_Load(object sender, EventArgs e)
        {
            lblEmailMsg.Text = DateAndTime.Now.ToString();
        }
    }
}
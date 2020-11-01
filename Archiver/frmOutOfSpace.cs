using System;
using Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public partial class frmOutOfSpace
    {
        public frmOutOfSpace()
        {
            InitializeComponent();
            _btnStopExecution.Name = "btnStopExecution";
        }

        private void btnStopExecution_Click(object sender, EventArgs e)
        {
            FileSystem.Reset();
            Environment.Exit(0);
        }
    }
}
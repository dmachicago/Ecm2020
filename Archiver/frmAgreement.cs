using System;
using MODI;

namespace EcmArchiver
{
    public partial class frmAgreement
    {
        public frmAgreement()
        {
            InitializeComponent();
            _ckAgree.Name = "ckAgree";
            _ckDisagree.Name = "ckDisagree";
            _btnProcess.Name = "btnProcess";
        }

        private void btnProcess_Click(object sender, EventArgs e)
        {
            Dispose();
        }

        private void ckAgree_CheckedChanged(object sender, EventArgs e)
        {
            if (ckAgree.Checked == true)
            {
                modGlobals.gLegalAgree = true;
                ckDisagree.Checked = false;
            }
        }

        private void ckDisagree_CheckedChanged(object sender, EventArgs e)
        {
            if (ckDisagree.Checked == true)
            {
                modGlobals.gLegalAgree = false;
                ckAgree.Checked = false;
            }
        }

        private void frmAgreement_Load(object sender, EventArgs e)
        {
            ckDisagree.Checked = true;
        }
    }
}
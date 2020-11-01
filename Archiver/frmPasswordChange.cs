using System;
using MODI;

namespace EcmArchiver
{
    public partial class frmPasswordChange
    {
        public frmPasswordChange()
        {
            InitializeComponent();
            _btnEnter.Name = "btnEnter";
        }

        public string PW1 = "";
        public string PW2 = "";

        private void btnEnter_Click(object sender, EventArgs e)
        {
            if (txtPw2.Text.Equals(txtPw1.Text.Trim()))
            {
                PW1 = txtPw1.Text.Trim();
                PW2 = txtPw2.Text.Trim();
                SB.Text = "Successful.";
                Close();
            }
            else
            {
                SB.Text = "Passwords do not match.";
            }
        }
    }
}
using System;
using System.Windows.Forms;
using global::ECMEncryption;
using MODI;

namespace EcmArchiver
{
    public partial class frmEncryptString
    {
        public frmEncryptString()
        {
            InitializeComponent();
            _btnEncrypt.Name = "btnEncrypt";
            _btnCopy.Name = "btnCopy";
        }

        private ECMEncrypt ENC = new ECMEncrypt();

        private void btnEncrypt_Click(object sender, EventArgs e)
        {
            string S = txtUnencrypted.Text.Trim();
            S = ENC.AES256EncryptString(S);
            txtEncrypted.Text = S;
        }

        private void btnCopy_Click(object sender, EventArgs e)
        {
            Clipboard.Clear();
            Clipboard.SetText(txtEncrypted.Text);
            MessageBox.Show("The encrypted string is in the clipboard.");
        }
    }
}
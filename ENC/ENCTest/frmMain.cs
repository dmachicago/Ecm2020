using ECMEncryption;
using System;
using System.Windows.Forms;

namespace ENCTest
{
    public partial class frmMain : Form
    {
        //private SHA3Crypto SHA3 = new SHA3Crypto();
        private ECMEncrypt ENC = new ECMEncrypt ();
        private bool bEncrypt = false;

        public frmMain ()
        {
            InitializeComponent ();
        }

        private void testEncryption ()
        {
            string Phrase = txtPhrase.Text;
            string pw = txtPassword.Text;

            if (ckAES256.Checked)
            {
                txtEncrypted.Text = "";
                string str = ENC.AES256EncryptString(Phrase);
                txtEncrypted.Text = str;
                return;
            }
            if (ckAES3.Checked)
            {
                txtEncrypted.Text = "";
                string str = ENC.aesEncrypt(Phrase);
                txtEncrypted.Text = str;
                return;
            }
            if (ckSha3.Checked)
            {
                txtEncrypted.Text = "";
                txtEncrypted.Text = ENC.SHA3Encrypt(Phrase);
                return;
            }
            if (ckFips.Checked)
            {
                txtEncrypted.Text = "";
                txtEncrypted.Text = ENC.aesEncrypt(Phrase);
            }
            if (ckAes.Checked)
            {
                txtEncrypted.Text = "";
                txtEncrypted.Text= ENC.AESEncryptPhrase (Phrase, pw);
            }
            if (ckDecryptStd.Checked && txtPassword.Text.Length.Equals(0)) {
                txtEncrypted.Text = "";
                txtEncrypted.Text = ENC.EncryptPhrase(Phrase);
            }
            if (ckDecryptStd.Checked && txtPassword.Text.Length>0)
            {
                txtEncrypted.Text = ENC.EncryptPhrase (Phrase,pw);
            }
            if (ckTripleDes.Checked && txtPassword.Text.Length > 0)
            {
                txtEncrypted.Text = ENC.AES256DecryptString(Phrase);
            }
            if (ckTripleDes.Checked && txtPassword.Text.Length.Equals(0))
            {
                txtEncrypted.Text = ENC.AES256DecryptString (Phrase);
            }
        }

        private void testDecryption ()
        {
            string Phrase = txtEncrypted.Text;
            string pw = txtPassword.Text;

            if (ckAES256.Checked)
            {
                txtPlain.Text = "";
                string str = ENC.AES256DecryptString(Phrase);
                txtPlain.Text = str;
                return;
            }
            if (ckAES3.Checked)
            {
                txtPlain.Text = "";
                string str = ENC.aesDecrypt(Phrase);
                txtPlain.Text = str;
                return;
            }
            if (ckSha3.Checked)
            {
                txtPlain.Text = "";
                txtPlain.Text = ENC.SHA3Decrypt(Phrase);
                return;
            }
            if (ckFips.Checked)
            {
                txtPlain.Text = ENC.aesDecrypt(Phrase);
            }
            if (ckAes.Checked) {
                txtPlain.Text = ENC.AESDecryptPhrase(Phrase, pw);
            }
            if (ckDecryptStd.Checked && txtPassword.Text.Length.Equals (0))
            {
                txtPlain.Text = ENC.DecryptPhrase (Phrase);
            }
            if (ckDecryptStd.Checked && txtPassword.Text.Length > 0)
            {
                txtPlain.Text = ENC.DecryptPhrase (Phrase, pw);
            }
            if (ckTripleDes.Checked && txtPassword.Text.Length > 0)
            {
                txtPlain.Text = ENC.AES256DecryptString (Phrase);
            }
            if (ckTripleDes.Checked && txtPassword.Text.Length.Equals(0))
            {
                txtPlain.Text = ENC.AES256DecryptString (Phrase);
            }
        }

        private void ExecEnc ()
        {
            if (bEncrypt)
            {
                testEncryption ();
            }
            else
            {
                testDecryption ();
            }
        }

        private void btnEncrypt_Click (object sender, EventArgs e)
        {
            bEncrypt = true;
            testEncryption();
            //ExecEnc ();
        }

        private void btnDecrypt_Click (object sender, EventArgs e)
        {
            bEncrypt = false;
            testDecryption();
            //ExecEnc ();
        }

        private void btnClipboard_Click (object sender, EventArgs e)
        {
            Clipboard.Clear ();
            Clipboard.SetText (txtEncrypted.Text);
            MessageBox.Show ("Encrypted text in clipboard.");
        }
    }
}
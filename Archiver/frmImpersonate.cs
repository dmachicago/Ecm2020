using System;
using global::System.IO;
using System.Windows.Forms;
using global::ECMEncryption;
using Microsoft.VisualBasic;
using MODI;

namespace EcmArchiver
{
    public partial class frmImpersonate
    {
        public frmImpersonate()
        {
            InitializeComponent();
            _btnAssign.Name = "btnAssign";
            _btnCancel.Name = "btnCancel";
            _btnRemoveAssignment.Name = "btnRemoveAssignment";
        }

        private clsUtility UTIL = new clsUtility();
        private clsDatabaseARCH DBARCH = new clsDatabaseARCH();
        private ECMEncrypt ENC = new ECMEncrypt();

        private void btnAssign_Click(object sender, EventArgs e)
        {
            if (txtPw1.Text.Equals(txtPw2.Text))
            {
            }
            else
            {
                MessageBox.Show("The passwords do not match, returning.");
                return;
            }

            string EPW = ENC.AES256EncryptString(txtPw1.Text);
            int I = -1;
            I = DBARCH.ValidateUserByUid(txtUserID.Text.Trim(), EPW);
            if (I <= 0)
            {
                MessageBox.Show("This user id or password is incorrect, please verify.");
                return;
            }

            string msg = "This sets the defined user as the default login for this machine.  " + Constants.vbCrLf + " There is the possibility that this offers security risks." + Constants.vbCrLf + " In assigning this user, you and your organization accept all the potential risks.";
            var dlgRes = MessageBox.Show(msg, "Set Default Login", MessageBoxButtons.YesNo);
            if (dlgRes == DialogResult.No)
            {
                return;
            }

            My.MySettingsProperty.Settings.DefaultLoginID = txtUserID.Text.Trim();
            My.MySettingsProperty.Settings.DefaultLoginPW = EPW;
            My.MySettingsProperty.Settings.Save();
            string FQN = "";
            UTIL.getImpersonateFileName(ref FQN);
            try
            {
                var objWriter = new StreamWriter(FQN, false);
                objWriter.Write(txtUserID.Text);
                objWriter.Close();
                objWriter.Dispose();
                MessageBox.Show("Success: user ID " + txtUserID.Text + " will be used as the default login for this machine.");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Fatal ERROR: Failed to create the file, please ensure you have the required authority." + Constants.vbCrLf + ex.Message);
                return;
            }
        }

        private void btnRemoveAssignment_Click(object sender, EventArgs e)
        {
            string msg = "This removes the default impersonation for this machine - Are you sure.  ";
            var dlgRes = MessageBox.Show(msg, "Remove Impersonation", MessageBoxButtons.YesNo);
            if (dlgRes == DialogResult.No)
            {
                return;
            }

            My.MySettingsProperty.Settings.DefaultLoginID = "";
            My.MySettingsProperty.Settings.DefaultLoginPW = "";
            My.MySettingsProperty.Settings.Save();
            string FQN = "";
            UTIL.getImpersonateFileName(ref FQN);
            try
            {
                File.Delete(FQN);
                MessageBox.Show("Success: impersonation removed.");
            }
            catch (Exception ex)
            {
                MessageBox.Show("Fatal ERROR: Failed to remove impersonation." + Constants.vbCrLf + ex.Message);
                return;
            }
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
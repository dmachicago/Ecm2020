// VBConversions Note: VB project level imports
using System.Collections.Generic;
using System;
using System.Drawing;
using System.Linq;
using System.Diagnostics;
using System.Data;
using Microsoft.VisualBasic;
using MODI;
using System.Xml.Linq;
using System.Collections;
using System.Windows.Forms;
// End of VB project level imports

using System.IO;


namespace EcmArchiveClcSetup
{
	public partial class frmImpersonate
	{
		public frmImpersonate()
		{
			InitializeComponent();
			
			//Added to support default instance behavour in C#
			if (defaultInstance == null)
				defaultInstance = this;
		}
		
#region Default Instance
		
		private static frmImpersonate defaultInstance;
		
		/// <summary>
		/// Added by the VB.Net to C# Converter to support default instance behavour in C#
		/// </summary>
		public static frmImpersonate Default
		{
			get
			{
				if (defaultInstance == null)
				{
					defaultInstance = new frmImpersonate();
					defaultInstance.FormClosed += new FormClosedEventHandler(defaultInstance_FormClosed);
				}
				
				return defaultInstance;
			}
		}
		
		static void defaultInstance_FormClosed(object sender, FormClosedEventArgs e)
		{
			defaultInstance = null;
		}
		
#endregion
		
		clsUtility UTIL = new clsUtility();
		clsDatabase DB = new clsDatabase();
		clsEncrypt ENC = new clsEncrypt();
		
		public void btnAssign_Click(System.Object sender, System.EventArgs e)
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
			I = DB.ValidateUserByUid(txtUserID.Text.Trim(), EPW);
			
			if (I <= 0)
			{
				MessageBox.Show("This user id or password is incorrect, please verify.");
				return;
			}
			
			string msg = "This sets the defined user as the default login for this machine.  " + "\r\n" + " There is the possibility that this offers security risks." + "\r\n" + " In assigning this user, you and your organization accept all the potential risks.";
			DialogResult dlgRes = MessageBox.Show(msg, "Set Default Login", MessageBoxButtons.YesNo);
			if (dlgRes == System.Windows.Forms.DialogResult.No)
			{
				return;
			}
			
			My.Settings.Default.DefaultLoginID = txtUserID.Text.Trim();
			My.Settings.Default.DefaultLoginPW = EPW;
			My.Settings.Default.Save();
			
			string FQN = "";
			UTIL.getImpersonateFileName(ref FQN);
			
			try
			{
				System.IO.StreamWriter objWriter = new System.IO.StreamWriter(FQN, false);
				objWriter.Write(txtUserID.Text);
				objWriter.Close();
				objWriter.Dispose();
				MessageBox.Show("Success: user ID " + txtUserID.Text + " will be used as the default login for this machine.");
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Fatal ERROR: Failed to create the file, please ensure you have the required authority." + "\r\n" + ex.Message));
				return;
			}
			
		}
		
		public void btnRemoveAssignment_Click(System.Object sender, System.EventArgs e)
		{
			string msg = "This removes the default impersonation for this machine - Are you sure.  ";
			DialogResult dlgRes = MessageBox.Show(msg, "Remove Impersonation", MessageBoxButtons.YesNo);
			if (dlgRes == System.Windows.Forms.DialogResult.No)
			{
				return;
			}
			
			
			My.Settings.Default.DefaultLoginID = "";
			My.Settings.Default.DefaultLoginPW = "";
			My.Settings.Default.Save();
			
			string FQN = "";
			UTIL.getImpersonateFileName(ref FQN);
			
			try
			{
				File.Delete(FQN);
				MessageBox.Show("Success: impersonation removed.");
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Fatal ERROR: Failed to remove impersonation." + "\r\n" + ex.Message));
				return;
			}
		}
		
		public void btnCancel_Click(System.Object sender, System.EventArgs e)
		{
			this.Close();
		}
	}
	
}

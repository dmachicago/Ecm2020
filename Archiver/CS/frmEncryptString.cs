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


namespace EcmArchiveClcSetup
{
	public partial class frmEncryptString
	{
		public frmEncryptString()
		{
			InitializeComponent();
			
			//Added to support default instance behavour in C#
			if (defaultInstance == null)
				defaultInstance = this;
		}
		
#region Default Instance
		
		private static frmEncryptString defaultInstance;
		
		/// <summary>
		/// Added by the VB.Net to C# Converter to support default instance behavour in C#
		/// </summary>
		public static frmEncryptString Default
		{
			get
			{
				if (defaultInstance == null)
				{
					defaultInstance = new frmEncryptString();
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
		
		clsEncrypt ENC = new clsEncrypt();
		
		public void btnEncrypt_Click(System.Object sender, System.EventArgs e)
		{
			string S = txtUnencrypted.Text.Trim();
			S = ENC.AES256EncryptString(S);
			txtEncrypted.Text = S;
		}
		
		public void btnCopy_Click(System.Object sender, System.EventArgs e)
		{
			Clipboard.Clear();
			Clipboard.SetText(txtEncrypted.Text);
			MessageBox.Show("The encrypted string is in the clipboard.");
		}
	}
	
}

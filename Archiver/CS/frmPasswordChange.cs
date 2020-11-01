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
	public partial class frmPasswordChange
	{
		public frmPasswordChange()
		{
			InitializeComponent();
			
			//Added to support default instance behavour in C#
			if (defaultInstance == null)
				defaultInstance = this;
		}
		
#region Default Instance
		
		private static frmPasswordChange defaultInstance;
		
		/// <summary>
		/// Added by the VB.Net to C# Converter to support default instance behavour in C#
		/// </summary>
		public static frmPasswordChange Default
		{
			get
			{
				if (defaultInstance == null)
				{
					defaultInstance = new frmPasswordChange();
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
		
		public string PW1 = "";
		public string PW2 = "";
		
		public void btnEnter_Click(System.Object sender, System.EventArgs e)
		{
			if (txtPw2.Text.Equals(txtPw1.Text.Trim()))
			{
				PW1 = txtPw1.Text.Trim();
				PW2 = txtPw2.Text.Trim();
				SB.Text = "Successful.";
				this.Close();
			}
			else
			{
				SB.Text = "Passwords do not match.";
			}
		}
	}
	
}

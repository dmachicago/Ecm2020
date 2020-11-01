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
	public partial class frmHelp
	{
		
#region Default Instance
		
		private static frmHelp defaultInstance;
		
		/// <summary>
		/// Added by the VB.Net to C# Converter to support default instance behavour in C#
		/// </summary>
		public static frmHelp Default
		{
			get
			{
				if (defaultInstance == null)
				{
					defaultInstance = new frmHelp();
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
		public string MsgToDisplay = "";
		public string CallingScreenName = "";
		public string CaptionName = "";
		
		
		public frmHelp()
		{
			// This call is required by the Windows Form Designer.
			InitializeComponent();
			
			//Added to support default instance behavour in C#
			if (defaultInstance == null)
				defaultInstance = this;
			
			// Add any initialization after the InitializeComponent() call.
			
		}
		public void frmHelp_Load(System.Object sender, System.EventArgs e)
		{
			rtbText.Text = MsgToDisplay;
			this.lblScreenName.Text = CallingScreenName;
			this.lblObject.Text = CaptionName;
		}
		
		public void Timer1_Tick(System.Object sender, System.EventArgs e)
		{
			this.Close();
		}
	}
	
}

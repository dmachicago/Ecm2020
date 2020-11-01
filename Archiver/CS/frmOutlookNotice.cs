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
	public partial class frmOutlookNotice
	{
		public frmOutlookNotice()
		{
			InitializeComponent();
			
			//Added to support default instance behavour in C#
			if (defaultInstance == null)
				defaultInstance = this;
		}
		
#region Default Instance
		
		private static frmOutlookNotice defaultInstance;
		
		/// <summary>
		/// Added by the VB.Net to C# Converter to support default instance behavour in C#
		/// </summary>
		public static frmOutlookNotice Default
		{
			get
			{
				if (defaultInstance == null)
				{
					defaultInstance = new frmOutlookNotice();
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
		
		int iSec = 1;
		
		public void btnTerminate_Click(System.Object sender, System.EventArgs e)
		{
			UTIL.KillOutlookRunning();
		}
		
		public void Timer1_Tick(System.Object sender, System.EventArgs e)
		{
			statElapsedTime.Text = DateAndTime.TimeOfDay.Second.ToString();
			if (iSec > 60)
			{
				iSec = 1;
			}
			PB.Value = iSec;
		}
		
		public void frmOutlookNotice_Load(System.Object sender, System.EventArgs e)
		{
			PB.Minimum = 0;
			PB.Maximum = 60;
		}
		
	}
	
}

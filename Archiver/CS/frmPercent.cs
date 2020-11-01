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
	public partial class frmPercent
	{
		
#region Default Instance
		
		private static frmPercent defaultInstance;
		
		/// <summary>
		/// Added by the VB.Net to C# Converter to support default instance behavour in C#
		/// </summary>
		public static frmPercent Default
		{
			get
			{
				if (defaultInstance == null)
				{
					defaultInstance = new frmPercent();
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
		
		public double fSize = 0;
		
		public frmPercent()
		{
			// This call is required by the designer.
			InitializeComponent();
			
			//Added to support default instance behavour in C#
			if (defaultInstance == null)
				defaultInstance = this;
			
			// Add any initialization after the InitializeComponent() call.
			
			if (fSize == 0)
			{
				this.Label1.Visible = false;
			}
			else
			{
				this.Label1.Text = "Loading File of Size: " + fSize.ToString();
			}
			
		}
		
	}
	
}

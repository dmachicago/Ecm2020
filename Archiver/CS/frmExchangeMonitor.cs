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
	public partial class frmExchangeMonitor
	{
		public frmExchangeMonitor()
		{
			InitializeComponent();
			
			//Added to support default instance behavour in C#
			if (defaultInstance == null)
				defaultInstance = this;
		}
		
#region Default Instance
		
		private static frmExchangeMonitor defaultInstance;
		
		/// <summary>
		/// Added by the VB.Net to C# Converter to support default instance behavour in C#
		/// </summary>
		public static frmExchangeMonitor Default
		{
			get
			{
				if (defaultInstance == null)
				{
					defaultInstance = new frmExchangeMonitor();
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
		
	}
	
}

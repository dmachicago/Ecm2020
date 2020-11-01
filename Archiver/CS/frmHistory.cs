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
	public partial class frmHistory
	{
		public frmHistory()
		{
			InitializeComponent();
			
			//Added to support default instance behavour in C#
			if (defaultInstance == null)
				defaultInstance = this;
		}
		
#region Default Instance
		
		private static frmHistory defaultInstance;
		
		/// <summary>
		/// Added by the VB.Net to C# Converter to support default instance behavour in C#
		/// </summary>
		public static frmHistory Default
		{
			get
			{
				if (defaultInstance == null)
				{
					defaultInstance = new frmHistory();
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
		
		public void frmHistory_Load(System.Object sender, System.EventArgs e)
		{
			AddHistoryItems();
		}
		public void AddHistoryItems()
		{
			
			lbHistory.Items.Clear();
			lbHistory.Items.Add("2010.12.27 - Force a backup of contacts if outlook is installed. (ECM)");
			lbHistory.Items.Add("2010.12.07 - Added the PDF OCR Extraction and text extraction functionality back into the standard license. (ECM)");
			lbHistory.Items.Add("2010.12.07 - Removed all references to Crystal Reports as Microsoft sold the rights. (ECM)");
			lbHistory.Items.Add("2010.11.30 - Allowed the EMAIL folder display window to expand. (Advent)");
			lbHistory.Items.Add("2010.11.25 - Created as a standalone applciation. (ECM)");
			
		}
		
		
		public void lbHistory_SelectedIndexChanged(System.Object sender, System.EventArgs e)
		{
			
		}
	}
	
}

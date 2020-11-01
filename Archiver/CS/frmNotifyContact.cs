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
	public partial class frmNotifyContact
	{
		public frmNotifyContact()
		{
			InitializeComponent();
		}
		public string Title = "CONTACTS";
		
		public void frmNotifyContact_Load(System.Object sender, System.EventArgs e)
		{
			this.Text = Title;
		}
		
	}
	
}

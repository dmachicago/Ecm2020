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
	public sealed partial class AboutBox1
	{
		public AboutBox1()
		{
			InitializeComponent();
			
			//Added to support default instance behavour in C#
			if (defaultInstance == null)
				defaultInstance = this;
		}
		
#region Default Instance
		
		private static AboutBox1 defaultInstance;
		
		/// <summary>
		/// Added by the VB.Net to C# Converter to support default instance behavour in C#
		/// </summary>
		public static AboutBox1 Default
		{
			get
			{
				if (defaultInstance == null)
				{
					defaultInstance = new AboutBox1();
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
		
		public void AboutBox1_Load(System.Object sender, System.EventArgs e)
		{
			// Set the title of the form.
			string CurrBuildID = System.Configuration.ConfigurationManager.AppSettings["ArchiverBuildID"];
			string ApplicationTitle;
			if ((new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).Info.Title != "")
			{
				ApplicationTitle = (new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).Info.Title;
			}
			else
			{
				ApplicationTitle = System.IO.Path.GetFileNameWithoutExtension((new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).Info.AssemblyName);
			}
			this.Text = string.Format("About {0}", ApplicationTitle);
			// Initialize all of the text displayed on the About Box.
			// TODO: Customize the application's assembly information in the "Application" pane of the project
			//    properties dialog (under the "Project" menu).
			this.LabelProductName.Text = (new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).Info.ProductName;
			this.LabelVersion.Text = string.Format("Version {0}", (new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).Info.Version.ToString());
			this.LabelCopyright.Text = (new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).Info.Copyright;
			this.LabelCompanyName.Text = (new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).Info.CompanyName;
			this.TextBoxDescription.Text = (new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).Info.Description + "\r\n" + "\r\n" + "Build ID: " + CurrBuildID;
			
			
		}
		
		public void OKButton_Click(System.Object sender, System.EventArgs e)
		{
			this.Close();
		}
		
	}
	
}

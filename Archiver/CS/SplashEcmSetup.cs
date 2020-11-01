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
	public sealed partial class SplashEcmSetup
	{
		public SplashEcmSetup()
		{
			InitializeComponent();
		}
		
		//TODO: This form can easily be set as the splash screen for the application by going to the "Application" tab
		//  of the Project Designer ("Properties" under the "Project" menu).
		
		
		public void SplashEcmSetup_Load(object sender, System.EventArgs e)
		{
			//Set up the dialog text at runtime according to the application's assembly information.
			
			//TODO: Customize the application's assembly information in the "Application" pane of the project
			//  properties dialog (under the "Project" menu).
			
			//Application title
			if ((new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).Info.Title != "")
			{
				ApplicationTitle.Text = (new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).Info.Title;
			}
			else
			{
				//If the application title is missing, use the application name, without the extension
				ApplicationTitle.Text = System.IO.Path.GetFileNameWithoutExtension((new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).Info.AssemblyName);
			}
			
			//Format the version information using the text set into the Version control at design time as the
			//  formatting string.  This allows for effective localization if desired.
			//  Build and revision information could be included by using the following code and changing the
			//  Version control's designtime text to "Version {0}.{1:00}.{2}.{3}" or something similar.  See
			//  String.Format() in Help for more information.
			//
			//    Version.Text = System.String.Format(Version.Text, My.Application.Info.Version.Major, My.Application.Info.Version.Minor, My.Application.Info.Version.Build, My.Application.Info.Version.Revision)
			
			Version.Text = System.String.Format(Version.Text, (new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).Info.Version.Major, (new Microsoft.VisualBasic.ApplicationServices.WindowsFormsApplicationBase()).Info.Version.Minor);
			
			//Copyright info
			Copyright.Text = "Copyright @ECM Library, 11-01-2010.";
		}
		
	}
	
}

// VBConversions Note: VB project level imports
using System.Windows.Input;
using System.Windows.Data;
using System.Windows.Documents;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Windows.Navigation;
using System.Windows.Media.Imaging;
using System.Windows;
using Microsoft.VisualBasic;
using System.Windows.Media;
using System.Collections;
using System;
using System.Windows.Shapes;
using System.Windows.Controls;
using System.Threading.Tasks;
using System.Linq;
using System.Diagnostics;
// End of VB project level imports



namespace ECMSearchWPF
{
	public class clsPreviewContent
	{
		public void PreviewDoc()
		{
			//Dim uri As Uri = New Uri("http://www.ecmlibrary/$Preview/LCSE-900010Firmware Support Manual.PDF", UriKind.RelativeOrAbsolute)
			try
			{
				System.Diagnostics.Process.Start("http://www.ecmlibrary/$Preview/LCSE-900010Firmware Support Manual.PDF");
			}
			catch
			{
				//Code to handle the error.
			}
			
		}
	}
	
}

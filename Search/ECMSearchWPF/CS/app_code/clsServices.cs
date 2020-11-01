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
	public class clsgetUserParm
	{
		
		
		public string tVal = "";
		string SecureID = "-1";
		
		//Dim EP As New clsEndPoint
		
		//Dim proxy As New SVCSearch.Service1Client
		
		public clsgetUserParm()
		{
			SecureID = GLOBALS._SecureID.ToString();
		}
		public string tVar
		{
			get
			{
				return tVal;
			}
			set
			{
				tVal = value;
			}
		} // Hour
		
		public void getUserVar(string VariableID, string ReturnedValue)
		{
			//"user_MaxRecordsToFetch"
			
			GLOBALS.ProxySearch.getUserParmCompleted += new System.EventHandler(client_getUserParm);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.getUserParm(SecureID, VariableID, ReturnedValue);
		}
		
		public void client_getUserParm(object sender, SVCSearch.getUserParmCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				tVal = (string) e.sVariable;
			}
			else
			{
				tVal = "";
			}
			GLOBALS.ProxySearch.getUserParmCompleted -= new System.EventHandler(client_getUserParm);
		}
		private void setXXSearchSvcEndPoint()
		{
			
			if (GLOBALS.SearchEndPoint.Length == 0)
			{
				return;
			}
			
			Uri ServiceUri = new Uri(GLOBALS.SearchEndPoint);
			System.ServiceModel.EndpointAddress EPA = new System.ServiceModel.EndpointAddress(ServiceUri, null);
			
			GLOBALS.ProxySearch.Endpoint.Address = EPA;
			GC.Collect();
			GC.WaitForPendingFinalizers();
		}
		
	}
	
	
}

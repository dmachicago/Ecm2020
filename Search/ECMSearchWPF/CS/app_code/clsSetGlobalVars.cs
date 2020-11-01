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
	public class clsSetGlobalVars
	{
		
		
		//Dim proxy As New SVCSearch.Service1Client
		//Dim EP As New clsEndPoint
		
		string SecureID;
		public clsSetGlobalVars(int iSecureID)
		{
			SecureID = iSecureID.ToString();
		}
		
		public void setUserVariables(string CurrUserGuidID)
		{
			getIsAdmin(CurrUserGuidID);
			getIsGlobalSearcher(CurrUserGuidID);
		}
		
		public void getIsAdmin(string CurrUserGuidID)
		{
			
			GLOBALS.ProxySearch.DBisAdminCompleted += new System.EventHandler(client_getIsAdmin);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.DBisAdmin(SecureID, CurrUserGuidID);
		}
		//Sub client_getIsAdmin(ByVal sender As Object, ByVal e As SVCSearch.DBisAdminCompletedEventArgs)
		public void client_getIsAdmin(object sender, SVCSearch.DBisAdminCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gIsAdmin = System.Convert.ToBoolean(e.Result);
				GLOBALS._isAdmin = System.Convert.ToBoolean(e.Result);
			}
			else
			{
				modGlobals.gIsAdmin = false;
				GLOBALS._isAdmin = false;
			}
			GLOBALS.ProxySearch.DBisAdminCompleted -= new System.EventHandler(client_getIsAdmin);
		}
		
		public void getIsGlobalSearcher(string CurrUserGuidID)
		{
			GLOBALS.ProxySearch.DBisGlobalSearcherCompleted += new System.EventHandler(client_getIsGlobalSearcher);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.DBisGlobalSearcherAsync(SecureID, CurrUserGuidID);
		}
		
		public void client_getIsGlobalSearcher(object sender, SVCSearch.DBisGlobalSearcherCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gIsGlobalSearcher = System.Convert.ToBoolean(e.Result);
			}
			else
			{
				modGlobals.gIsGlobalSearcher = false;
			}
			GLOBALS.ProxySearch.DBisGlobalSearcherCompleted -= new System.EventHandler(client_getIsGlobalSearcher);
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

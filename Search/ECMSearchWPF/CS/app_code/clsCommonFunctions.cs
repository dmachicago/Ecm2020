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
	public class clsCommonFunctions
	{
		
		
		//Dim proxy As New SVCSearch.Service1Client
		clsLogging LOG = new clsLogging();
		string SecureID;
		//Dim EP As New clsEndPoint
		
		public void RemoveSingleQuotes(ref string tVal)
		{
			tVal = tVal.Replace("\'\'", "\'");
			tVal = tVal.Replace("\'", "\'\'");
		}
		
		public clsCommonFunctions()
		{
			SecureID = GLOBALS._SecureID.ToString();
		}
		
		public void SaveClick(int ID, string UID)
		{
			bool RC = true;
			GLOBALS.ProxySearch.SaveClickStatsCompleted += new System.EventHandler(client_SaveClickStats);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.SaveClickStatsAsync(GLOBALS._SecureID, ID, UID, RC);
		}
		
		public void client_SaveClickStats(object sender, SVCSearch.SaveClickStatsCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				bool RC = System.Convert.ToBoolean(e.RC);
				if (! RC)
				{
					LOG.WriteToSqlLog("ERROR client_SaveClickStats: Failed to update.");
				}
			}
			else
			{
				LOG.WriteToSqlLog((string) ("ERROR 100 client_SaveClickStats: " + e.Error.Message));
			}
			GLOBALS.ProxySearch.SaveClickStatsCompleted -= new System.EventHandler(client_SaveClickStats);
		}
		public void RecordGrowth()
		{
			bool RC = false;
			
			GLOBALS.ProxySearch.RecordGrowthCompleted += new System.EventHandler(client_RecordGrowth);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.RecordGrowthAsync(SecureID, RC);
			
		}
		public void client_RecordGrowth(object sender, SVCSearch.RecordGrowthCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				bool RC = System.Convert.ToBoolean(e.RC);
				if (! RC)
				{
					LOG.WriteToSqlLog("ERROR client_RecordGrowth: Failed to update the associated DB Growthss.");
				}
			}
			else
			{
				LOG.WriteToSqlLog("ERROR 100 client_RecordGrowth: Failed to update the associated DB Growth.");
			}
			GLOBALS.ProxySearch.RecordGrowthCompleted -= new System.EventHandler(client_RecordGrowth);
		}
		
		public void resetMissingEmailIds()
		{
			bool RC = false;
			
			GLOBALS.ProxySearch.resetMissingEmailIdsCompleted += new System.EventHandler(client_resetMissingEmailIds);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.resetMissingEmailIdsAsync(SecureID, modGlobals.gCurrUserGuidID, RC);
			
		}
		public void client_resetMissingEmailIds(object sender, SVCSearch.resetMissingEmailIdsCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				bool RC = System.Convert.ToBoolean(e.RC);
				if (! RC)
				{
					LOG.WriteToSqlLog("ERROR client_resetMissingEmailIds: Failed to update the associated record(s).");
				}
			}
			else
			{
				LOG.WriteToSqlLog("ERROR 100 client_resetMissingEmailIds: Failed to update the associated  record(s).");
			}
			GLOBALS.ProxySearch.resetMissingEmailIdsCompleted -= new System.EventHandler(client_resetMissingEmailIds);
		}
		
	}
	
}

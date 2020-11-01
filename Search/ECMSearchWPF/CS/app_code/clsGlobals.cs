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

using System.Threading;

//Imports System.Runtime.InteropServices.Automation

namespace ECMSearchWPF
{
	public class clsGlobals
	{
		string LT = "";
		
		//Dim proxy As New SVCSearch.Service1Client
		string TgtEndPoint = "";
		
		public string SecureID = "-1";
		
		public clsGlobals()
		{
			SecureID = GLOBALS._SecureID.ToString();
		}
		
		public void getUserVariables(string UserID)
		{
			
			getUserGuidID(UserID);
			
		}
		
		public void getSystemVariables(int iSecureID)
		{
			SecureID = GLOBALS._SecureID.ToString();
			getLicense();
		}
		
		public void getLicense()
		{
			
			bool RC = false;
			string RetMsg = "";
			
			GLOBALS.ProxySearch.GetXrtCompleted += new System.EventHandler(StepGetLicense);
			//'EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.GetXrtAsync(SecureID, RC, RetMsg);
		}
		
		public void StepGetLicense(object sender, SVCSearch.GetXrtCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gEncLicense = (string) e.Result;
			}
			else
			{
				modGlobals.gEncLicense = "";
			}
			
			GLOBALS.ProxySearch.GetXrtCompleted -= new System.EventHandler(StepGetLicense);
			
			GLOBALS.ProxySearch.ParseLicDictionaryCompleted += new System.EventHandler(StepParseLicDictionary);
			//'EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.ParseLicDictionaryAsync(SecureID, modGlobals.gEncLicense, modGlobals.gLicenseItems);
			
		}
		public void StepParseLicDictionary(object sender, SVCSearch.ParseLicDictionaryCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gLicenseItems = e.D;
			}
			else
			{
				modGlobals.gMaxClients = -1;
			}
			
			GLOBALS.ProxySearch.ParseLicDictionaryCompleted -= new System.EventHandler(StepParseLicDictionary);
			
			ProcessDates();
			LT = modGlobals.gEncLicense;
			getLicenseVars();
			SetDateFormats();
			getSqlServerVersion();
			
			getAttachedMachineName();
			GetNbrMachineAll();
			getLocalMachineIpAddr();
			
			isLicenseValid(modGlobals.gServerValText, modGlobals.gInstanceValText);
			
			getNbrOfRegisteredUsers();
			
			GetNbrMachine(SecureID, modGlobals.gMachineID);
			
			GetNbrMachineAll();
			
			getMaxClients();
			
			LicenseType();
			
		}
		public void getAttachedMachineName()
		{
			if (GLOBALS._SecureID > 0)
			{
				GLOBALS.ProxySearch.getAttachedMachineNameCompleted += new System.EventHandler(client_getAttachedMachineName);
				//'EP.setSearchSvcEndPoint(proxy)
				GLOBALS.ProxySearch.getAttachedMachineNameAsync(GLOBALS._SecureID);
			}
		}
		public void client_getAttachedMachineName(object sender, SVCSearch.getAttachedMachineNameCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gAttachedMachineName = (string) e.Result;
				modGlobals.gMachineID = (string) e.Result;
			}
			else
			{
				modGlobals.gAttachedMachineName = "Unknown";
				modGlobals.gMachineID = "Unknown";
			}
			GLOBALS.ProxySearch.getAttachedMachineNameCompleted -= new System.EventHandler(client_getAttachedMachineName);
		}
		
		public void LicenseType()
		{
			
			bool RC = false;
			string RetMsg = "";
			
			GLOBALS.ProxySearch.LicenseTypeCompleted += new System.EventHandler(step_LicenseType);
			//'EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.getMaxClientsAsync(SecureID, RC, RetMsg);
		}
		public void step_LicenseType(object sender, SVCSearch.LicenseTypeCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gLicenseType = (string) e.Result;
			}
			else
			{
				modGlobals.gLicenseType = "-1";
			}
			
			GLOBALS.ProxySearch.LicenseTypeCompleted -= new System.EventHandler(step_LicenseType);
		}
		
		public void getMaxClients()
		{
			
			bool RC = false;
			string RetMsg = "";
			
			GLOBALS.ProxySearch.getMaxClientsCompleted += new System.EventHandler(step_getMaxClients);
			//'EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.getMaxClientsAsync(SecureID, RC, RetMsg);
		}
		public void step_getMaxClients(object sender, SVCSearch.getMaxClientsCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gMaxClients = System.Convert.ToInt32(e.Result);
			}
			else
			{
				modGlobals.gMaxClients = -1;
			}
			GLOBALS.MaxClients = modGlobals.gMaxClients.ToString();
			GLOBALS.ProxySearch.getMaxClientsCompleted -= new System.EventHandler(step_getMaxClients);
		}
		
		public void getNbrOfRegisteredUsers()
		{
			
			GLOBALS.ProxySearch.GetNbrUsersCompleted += new System.EventHandler(step_CurrNbrOfUsers);
			//'EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.GetNbrUsersAsync(SecureID);
		}
		public void step_CurrNbrOfUsers(object sender, SVCSearch.GetNbrUsersCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gNbrOfRegisteredUsers = System.Convert.ToInt32(e.Result);
			}
			else
			{
				modGlobals.gNbrOfUsers = -1;
			}
			GLOBALS.RegisteredUsers = modGlobals.gNbrOfUsers.ToString();
			GLOBALS.ProxySearch.GetNbrUsersCompleted -= new System.EventHandler(step_CurrNbrOfUsers);
		}
		
		public void SetDateFormats()
		{
			
			//Dim dateString, format As String
			//Dim result As Date
			
			System.Globalization.DateTimeFormatInfo Info;
			Info = System.Globalization.CultureInfo.CurrentUICulture.DateTimeFormat;
			
			//Dim S As String = ""
			//'gDateSeparator = Info.DateSeparator
			//'gTimeSeparator = Info.TimeSeparator
			modGlobals.gShortDatePattern = Info.ShortDatePattern;
			modGlobals.gShortTimePattern = Info.ShortTimePattern;
			
			string Ch = "";
			for (int i = 1; i <= modGlobals.gShortDatePattern.Length; i++)
			{
				Ch = modGlobals.gShortDatePattern.Substring(i, 1);
				if ("/-.".Contains(Ch))
				{
					modGlobals.gDateSeparator = Ch;
					break;
				}
			}
			for (int i = 1; i <= modGlobals.gShortTimePattern.Length; i++)
			{
				Ch = modGlobals.gShortTimePattern.Substring(i, 1);
				if (":/-.".Contains(Ch))
				{
					modGlobals.gTimeSeparator = Ch;
					break;
				}
			}
			
		}
		public void getUserGuidID(string UserID)
		{
			
			GLOBALS.ProxySearch.getUserGuidIDCompleted += new System.EventHandler(step_getUserGuidID);
			//'EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.getUserGuidID(SecureID, UserID);
		}
		public void step_getUserGuidID(object sender, SVCSearch.getUserGuidIDCompletedEventArgs e)
		{
			
			if (e.Error == null)
			{
				modGlobals.gCurrUserGuidID = (string) e.Result;
			}
			else
			{
				modGlobals.gCurrUserGuidID = null;
			}
			
			GLOBALS.ProxySearch.GetNbrUsersCompleted -= new System.EventHandler(step_CurrNbrOfUsers);
			
			clsSetGlobalVars SETGV = new clsSetGlobalVars(int.Parse(SecureID));
			SETGV.setUserVariables(modGlobals.gCurrUserGuidID);
			SETGV = null;
			
		}
		
		public void ProcessDates()
		{
			
			GLOBALS.ProxySearch.ProcessDatesCompleted += new System.EventHandler(step_ProcessDates);
			//'EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.ProcessDatesAsync(SecureID);
		}
		public void step_ProcessDates(object sender, SVCSearch.ProcessDatesCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gProcessDates = e.Result;
			}
			else
			{
				modGlobals.gProcessDates = null;
			}
			GLOBALS.ProxySearch.ProcessDatesCompleted -= new System.EventHandler(step_ProcessDates);
		}
		
		public void getSqlServerVersion()
		{
			
			GLOBALS.ProxySearch.getSqlServerVersionCompleted += new System.EventHandler(step_getSqlServerVersion);
			//'EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.getSqlServerVersionAsync(SecureID);
		}
		public void step_getSqlServerVersion(object sender, SVCSearch.getSqlServerVersionCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gServerVersion = (string) e.Result;
			}
			else
			{
				modGlobals.gServerVersion = "Unknown";
			}
			GLOBALS.SqlSvrVersion = modGlobals.gServerVersion.ToString();
			GLOBALS.ProxySearch.getSqlServerVersionCompleted -= new System.EventHandler(step_getSqlServerVersion);
		}
		
		public void GetNbrMachineAll()
		{
			
			GLOBALS.ProxySearch.GetNbrMachineAllCompleted += new System.EventHandler(step_GetNbrMachineAll);
			//'EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.GetNbrMachineAllAsync(SecureID);
		}
		public void step_GetNbrMachineAll(object sender, SVCSearch.GetNbrMachineAllCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gNumberOfRegisterdMachines = System.Convert.ToInt32(e.Result);
			}
			else
			{
				modGlobals.gNumberOfRegisterdMachines = 0;
			}
			
			GLOBALS.ProxySearch.GetNbrMachineAllCompleted -= new System.EventHandler(step_GetNbrMachineAll);
		}
		
		public void GetNbrMachine(string SecureID, string MachineName)
		{
			
			GLOBALS.ProxySearch.GetNbrMachineCompleted += new System.EventHandler(step_GetNbrMachine);
			//'EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.GetNbrMachineAsync(SecureID, MachineName);
		}
		
		public void step_GetNbrMachine(object sender, SVCSearch.GetNbrMachineCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gNumberOfRegisterdMachines = System.Convert.ToInt32(e.Result);
			}
			else
			{
				modGlobals.gNumberOfRegisterdMachines = 0;
			}
			GLOBALS.NbrRegisteredMachines = modGlobals.gNumberOfRegisterdMachines.ToString();
			GLOBALS.ProxySearch.GetNbrMachineCompleted -= new System.EventHandler(step_GetNbrMachine);
		}
		
		/// <summary>
		/// A license MUST be matched to the server running SQL Server and the Instance Name of SQL Server housing the repository.
		/// Without this match, the license is considered invalid.
		/// </summary>
		/// <param name="ServerValText">sets the value gServerValText</param>
		/// <param name="InstanceValText">sets the value gInstanceValText</param>
		/// <remarks></remarks>
		public void isLicenseValid(string ServerValText, string InstanceValText)
		{
			
			bool RC = false;
			string RetMsg = "";
			
			GLOBALS.ProxySearch.isLicenseLocatedOnAssignedMachineCompleted += new System.EventHandler(step_isLicenseValid);
			//'EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.isLicenseLocatedOnAssignedMachineAsync(SecureID, ServerValText, InstanceValText, RC, RetMsg);
		}
		public void step_isLicenseValid(object sender, SVCSearch.isLicenseLocatedOnAssignedMachineCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gServerValText = (string) e.ServerValText;
				modGlobals.gInstanceValText = (string) e.InstanceValText;
				modGlobals.gIsLicenseValid = System.Convert.ToBoolean(e.Result);
			}
			else
			{
				modGlobals.gIsLicenseValid = false;
			}
			GLOBALS.LicenseValid = modGlobals.gIsLicenseValid.ToString();
			GLOBALS.ProxySearch.isLicenseLocatedOnAssignedMachineCompleted -= new System.EventHandler(step_isLicenseValid);
		}
		
		public void getLicenseVars()
		{
			clsLogging LOG = new clsLogging();
			clsUtility UTIL = new clsUtility();
			int LL = 0;
			try
			{
				modGlobals.gCustomerID = UTIL.ParseLic("txtCustID");
				LL = 1;
				modGlobals.gNbrOfUsers = int.Parse(UTIL.ParseLic("txtNbrSimlSeats"));
				LL = 3;
				modGlobals.gNbrOfSeats = int.Parse(UTIL.ParseLic("txtNbrSeats"));
				LL = 4;
				modGlobals.gMaintExpire = DateTime.Parse(UTIL.ParseLic("dtMaintExpire"));
				LL = 5;
				string dtExpire = UTIL.ParseLic("dtExpire");
				string EndOfLicense = UTIL.ParseLic("EndOfLicense");
				
				GLOBALS.CustomerID = modGlobals.gCustomerID;
				GLOBALS.MaintExpire = UTIL.ParseLic("dtMaintExpire");
				GLOBALS.LicenseExpire = UTIL.ParseLic("dtExpire");
				GLOBALS.NbrOfSeats = modGlobals.gNbrOfSeats.ToString();
				GLOBALS.RegisteredUsers = modGlobals.gNbrOfUsers.ToString();
			}
			catch (Exception ex)
			{
				Console.WriteLine("ERROR: getLicenseVars - " + LL.ToString() + " / " + ex.Message);
			}
			finally
			{
				LOG = null;
				UTIL = null;
				GC.Collect();
			}
		}
		
		public void getGlobalVariables()
		{
			
			Step1gv(); //set the logged in user ID
			
		}
		
		public void Step1gv()
		{
			
			GLOBALS.ProxySearch.getUserGuidIDCompleted += new System.EventHandler(Step1);
			//'EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.getUserGuidID(SecureID, modGlobals.gCurrLoginID);
		}
		public void Step1(object sender, SVCSearch.getUserGuidIDCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gCurrUserGuidID = (string) e.Result;
				modGlobals.gLoggedInUser = modGlobals.gCurrLoginID;
			}
			else
			{
				modGlobals.gLoggedInUser = "Unknown";
				modGlobals.gCurrUserGuidID = "Unknown";
			}
			GLOBALS.ProxySearch.getUserGuidIDCompleted -= new System.EventHandler(Step1);
			Step2gv();
		}
		public void Step2gv()
		{
			
			GLOBALS.ProxySearch.getDBSIZEMBCompleted += new System.EventHandler(Step2);
			//'EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.getDBSIZEMBAsync(SecureID);
		}
		public void Step2(object sender, SVCSearch.getDBSIZEMBCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gCurrDbSize = System.Convert.ToDouble(e.Result);
			}
			else
			{
				modGlobals.gCurrDbSize = -1;
			}
			GLOBALS.ProxySearch.getDBSIZEMBCompleted -= new System.EventHandler(Step2);
		}
		
		/// <summary>
		/// Because of Silverlight's limited ability to process with speed and it's inability to process ASYNC calls, all existing
		/// runtime parameters are loaded at once into a global/static dictionary and then called as needed.
		/// </summary>
		/// <param name="Userid"></param>
		/// <remarks></remarks>
		public void loadUserParms(string Userid)
		{
			
			GLOBALS.ProxySearch.getUserParmsCompleted += new System.EventHandler(client_getUserParms);
			//'EP.setSearchSvcEndPoint(proxy)
			Thread.Sleep(GLOBALS.AffinityDelay);
			GLOBALS.ProxySearch.getUserParmsAsync(GLOBALS._SecureID, Userid, modGlobals.gUserParms);
		}
		public void client_getUserParms(object sender, SVCSearch.getUserParmsCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gUserParms = e.UserParms;
			}
			else
			{
				modGlobals.gUserParms = null;
			}
			GLOBALS.ProxySearch.getUserParmsCompleted -= new System.EventHandler(client_getUserParms);
		}
		public string getUserParameter(string tKey)
		{
			string S = "";
			if (modGlobals.gUserParms.ContainsKey(tKey))
			{
				S = modGlobals.gUserParms[tKey];
			}
			else
			{
				S = "";
			}
			return S;
		}
		/// <summary>
		/// There are many instances when a user runtime parameter will be added or modified. This will add or modify a user execution parameter.
		/// </summary>
		/// <param name="Userid"></param>
		/// <remarks></remarks>
		public void saveAllUserParm(string Userid)
		{
			foreach (string tKey in modGlobals.gUserParms.Keys)
			{
				string tVal = modGlobals.gUserParms[tKey];
				saveUserParmToDb(modGlobals.gCurrUserGuidID, tKey, tVal);
			}
		}
		public void saveSingleUserParm(string Userid, string tKey, string tVal)
		{
			saveUserParmToDb(modGlobals.gCurrUserGuidID, tKey, tVal);
		}
		public void saveUserParmToDb(string Userid, string tKey, string tValue)
		{
			
			GLOBALS.ProxySearch.SaveRunParmCompleted += new System.EventHandler(client_saveUserParmToDb);
			//'EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.SaveRunParmAsync(SecureID, Userid, tKey, tValue);
		}
		public void client_saveUserParmToDb(object sender, SVCSearch.SaveRunParmCompletedEventArgs e)
		{
			clsLogging LOG = new clsLogging();
			clsUtility UTIL = new clsUtility();
			bool B = true;
			if (e.Error == null)
			{
				B = System.Convert.ToBoolean(e.Result);
				if (! B)
				{
					string K = (string) e.ParmID;
					string V = (string) e.ParmVal;
					K = UTIL.RemoveSingleQuotes(K);
					V = UTIL.RemoveSingleQuotes(V);
					LOG.WriteToSqlLog("ERROR: failed to add/update userparameter - \'" + K + "\', value \'" + V + "\'.");
				}
			}
			else
			{
				modGlobals.gUserParms = null;
			}
			LOG = null;
			UTIL = null;
			GLOBALS.ProxySearch.SaveRunParmCompleted -= new System.EventHandler(client_saveUserParmToDb);
		}
		
		//*********************************************************************************
		public void updateIp(int iCode)
		{
			bool RC = false;
			
			GLOBALS.ProxySearch.updateIpCompleted += new System.EventHandler(client_updateIp);
			//'EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.updateIpAsync(SecureID, modGlobals.gMachineID, modGlobals.gIpAddr, 0, RC);
			
		}
		public void client_updateIp(object sender, SVCSearch.updateIpCompletedEventArgs e)
		{
			clsLogging LOG = new clsLogging();
			clsUtility UTIL = new clsUtility();
			if (e.Error != null)
			{
				LOG.WriteToSqlLog("ERROR client_updateIp: Failed to update the associated IP address.");
			}
			else
			{
				bool RC = System.Convert.ToBoolean(e.RC);
				if (RC)
				{
				}
				else
				{
					LOG.WriteToSqlLog("ERROR 100 client_updateIp: Failed to update the associated IP address.");
				}
			}
			LOG = null;
			UTIL = null;
			GLOBALS.ProxySearch.updateIpCompleted -= new System.EventHandler(client_updateIp);
		}
		//***********************************************************************
		public void getLocalMachineIpAddr()
		{
			
			if (modGlobals.gLocalMachineIP == "")
			{
				
				GLOBALS.ProxySearch.GetMachineIPCompleted += new System.EventHandler(client_GetMachineIPAddr);
				//'EP.setSearchSvcEndPoint(proxy)
				GLOBALS.ProxySearch.GetMachineIPAsync(SecureID);
			}
		}
		public void client_GetMachineIPAddr(object sender, SVCSearch.GetMachineIPCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gLocalMachineIP = (string) e.Result;
			}
			else
			{
				modGlobals.gLocalMachineIP = "NOT FOUND";
			}
			GLOBALS.ProxySearch.GetMachineIPCompleted -= new System.EventHandler(client_GetMachineIPAddr);
		}
		//***********************************************************************
		
		~clsGlobals()
		{
			try
			{
			}
			finally
			{
				base.Finalize(); //define the destructor
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
		}
		
		private void setXXSearchSvcEndPoint()
		{
			
			string CurrEndPoint = (string) (GLOBALS.ProxySearch.Endpoint.Address.ToString());
			
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

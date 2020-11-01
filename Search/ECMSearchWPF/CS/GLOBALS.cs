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
	sealed class GLOBALS
	{
		
		public static SVCSearch.Service1Client ProxySearch = new SVCSearch.Service1Client();
		public static SVCGateway.Service1Client ProxyGateway = new SVCGateway.Service1Client();
		
		public static string gCSRepo = "";
		public static string gCSThesaurus = "";
		public static string gCSHive = "";
		public static string gCSDMALicense = "";
		public static string gCSGateWay = "";
		public static string gCSTDR = "";
		public static string gCSKBase = "";
		
		
		public static string gRowID = "";
		public static int gIntRowID = -1;
		
		public static string gSVCGateway_Endpoint = "";
		public static string gSVCSearch_Endpoint = "";
		public static string gSVCDownload_Endpoint = "";
		
		public static System.Data.DataTable gEmailDT = new System.Data.DataTable();
		public static List<SVCSearch.DS_EMAIL> gListOfEmails = new List<SVCSearch.DS_EMAIL>();
		public static List<SVCSearch.DS_CONTENT> gListOfContent = new List<SVCSearch.DS_CONTENT>();
		public static System.Collections.Generic.List<SVCSearch.DS_EMAIL> gListOfEmailsTemp = new System.Collections.Generic.List<SVCSearch.DS_EMAIL>();
		public static System.Collections.Generic.List<SVCSearch.DS_CONTENT> gListOfContentTemp = new System.Collections.Generic.List<SVCSearch.DS_CONTENT>();
		
		public static string _SqlSvrVersion = string.Empty;
		public static string _NbrOfSeats = string.Empty;
		public static string _RegisteredUsers = string.Empty;
		public static string _CustomerID = string.Empty;
		public static string _MaxClients = string.Empty;
		public static string _LicenseValid = string.Empty;
		public static string _MaintExpire = string.Empty;
		public static string _LicenseExpire = string.Empty;
		public static string _NbrRegisteredMachines = string.Empty;
		
		public static string UserID = string.Empty;
		public static string UserGuid = string.Empty;
		public static string CompanyID = string.Empty;
		public static string MachineID = string.Empty;
		public static string RepoID = string.Empty;
		public static string SecureID = "0";
		public static Guid ActiveGuid;
		public static string EncryptPW = "";
		public static string CurrRepoCS = "";
		public static Guid SessionGuid;
		public static bool isAdmin = false;
		public static bool isSuperAdmin = false;
		public static bool isGlobalSearcher = false;
		public static bool _ApplyRecalledSearch = false;
		public static Dictionary<string, string> _dictMasterSearch = new Dictionary<string, string>();
		public static int _AffinityDelay = 0;
		public static int gLocalDebug = 0;
		public static string gContractID = "";
		public static string gSearchEndPoint = string.Empty;
		public static string gGatewayEndPoint = string.Empty;
		public static string gDownloadEndPoint = string.Empty;
		public static string gENCGWCS = string.Empty;
		public static string gCurrSessionGuid = "";
		public static string gCurrLogin = "";
		
		static public string NCGWCS
		{
			get
			{
				return gENCGWCS;
			}
			set
			{
				gENCGWCS = value;
			}
		}
		static public string GatewayEndPoint
		{
			get
			{
				return gGatewayEndPoint;
			}
			set
			{
				gGatewayEndPoint = value;
			}
		}
		static public string DownloadEndPoint
		{
			get
			{
				return gDownloadEndPoint;
			}
			set
			{
				gDownloadEndPoint = value;
			}
		}
		static public string ContractID
		{
			get
			{
				return gContractID;
			}
			set
			{
				gContractID = value;
			}
		}
		
		static public bool LocalDebug
		{
			get
			{
				return gLocalDebug;
			}
			set
			{
				gLocalDebug = value;
			}
		}
		
		static public string SearchEndPoint
		{
			get
			{
				return gSearchEndPoint;
			}
			set
			{
				gSearchEndPoint = value;
			}
		}
		
		static public int AffinityDelay
		{
			get
			{
				return _AffinityDelay;
			}
			set
			{
				_AffinityDelay = value;
			}
		}
		static public bool ApplyRecalledSearch
		{
			get
			{
				return _ApplyRecalledSearch;
			}
			set
			{
				_ApplyRecalledSearch = value;
			}
		}
		static public string NbrRegisteredMachines
		{
			get
			{
				return _NbrRegisteredMachines;
			}
			set
			{
				_NbrRegisteredMachines = value;
			}
		}
		static public string SqlSvrVersion
		{
			get
			{
				return _SqlSvrVersion;
			}
			set
			{
				_SqlSvrVersion = value;
			}
		}
		static public string NbrOfSeats
		{
			get
			{
				return _NbrOfSeats;
			}
			set
			{
				_NbrOfSeats = value;
			}
		}
		static public string RegisteredUsers
		{
			get
			{
				return _RegisteredUsers;
			}
			set
			{
				_RegisteredUsers = value;
			}
		}
		static public string CustomerID
		{
			get
			{
				return _CustomerID;
			}
			set
			{
				_CustomerID = value;
			}
		}
		static public string MaxClients
		{
			get
			{
				return _MaxClients;
			}
			set
			{
				_MaxClients = value;
			}
		}
		static public string LicenseValid
		{
			get
			{
				return _LicenseValid;
			}
			set
			{
				_LicenseValid = value;
			}
		}
		static public string MaintExpire
		{
			get
			{
				return _MaintExpire;
			}
			set
			{
				_MaintExpire = value;
			}
		}
		static public string LicenseExpire
		{
			get
			{
				return _LicenseExpire;
			}
			set
			{
				_LicenseExpire = value;
			}
		}
		
		static public string _MachineID
		{
			get
			{
				return MachineID;
			}
			set
			{
				MachineID = value;
			}
		}
		
		static public void SearchDictAdd(string sKey, string sVal)
		{
			if (_dictMasterSearch.ContainsKey(sKey))
			{
				_dictMasterSearch[sKey] = sVal;
			}
			else
			{
				_dictMasterSearch.Add(sKey, sVal);
			}
		}
		
		static public Dictionary<string, string> dictMasterSearch
		{
			get
			{
				return _dictMasterSearch;
			}
			set
			{
				_dictMasterSearch = _dictMasterSearch;
			}
		}
		
		static public bool _isAdmin
		{
			get
			{
				return isAdmin;
			}
			set
			{
				isAdmin = value;
			}
		}
		
		static public bool _isSuperAdmin
		{
			get
			{
				return isSuperAdmin;
			}
			set
			{
				isSuperAdmin = value;
			}
		}
		static public bool _isGlobalSearcher
		{
			get
			{
				return isGlobalSearcher;
			}
			set
			{
				isGlobalSearcher = value;
			}
		}
		
		static public string _UserGuid
		{
			get
			{
				return UserGuid;
			}
			set
			{
				UserGuid = value;
			}
		}
		
		static public Guid _SessionGuid
		{
			get
			{
				return SessionGuid;
			}
			set
			{
				SessionGuid = value;
			}
		}
		
		static public string _CurrRepoCS
		{
			get
			{
				return CurrRepoCS;
			}
			set
			{
				CurrRepoCS = value;
			}
		}
		
		static public string _EncryptPW
		{
			get
			{
				return EncryptPW;
			}
			set
			{
				EncryptPW = value;
			}
		}
		static public Guid _ActiveGuid
		{
			get
			{
				return ActiveGuid;
			}
			set
			{
				ActiveGuid = value;
			}
		}
		public static int _SecureID
		{
			get
			{
				return SecureID;
			}
			set
			{
				SecureID = value.ToString();
			}
		}
		static public string _CompanyID
		{
			get
			{
				return CompanyID;
			}
			set
			{
				CompanyID = value;
			}
		}
		static public string _RepoID
		{
			get
			{
				return RepoID;
			}
			set
			{
				RepoID = value;
			}
		}
		
		static public string _UserID
		{
			get
			{
				return UserID;
			}
			set
			{
				UserID = value;
			}
		}
		
		//Public Sub ExecuteSQL(ByRef MySql As String)
		
		//    AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSql
		//    ProxySearch.ExecuteSqlNewConnSecureAsync(MySql)
		//End Sub
		
		private static bool bUpdatingLog = false;
		
		/// <summary>
		/// RSQ = RemoveSingleQuote
		/// </summary>
		/// <param name="tVal">Value to be checked for single quotes</param>
		/// <remarks></remarks>
		private static void RSQ(ref string tVal)
		{
			string S = tVal;
			if (S.IndexOf("\'") + 1 == 0)
			{
				return;
			}
			S = S.Replace("\'\'", "\'");
			tVal = S;
		}
		
		/// <summary>
		/// REPLSQ - Replace single quotes with the reverse tick "`" char.
		/// </summary>
		/// <param name="tVal"></param>
		/// <remarks></remarks>
		private static void REPLSQ(ref string tVal)
		{
			string S = tVal;
			if (S.IndexOf("\'") + 1 == 0)
			{
				return;
			}
			S = S.Replace("\'\'", "`");
			tVal = S;
		}
		
		public static void UserParmInsertUpdate(string ParmName, string UserID, string ParmVal)
		{
			bool RC = false;
			//Dim proxy As New SVCSearch.Service1Client
			ProxySearch.UserParmInsertUpdateCompleted += new System.EventHandler(client_UserParmInsertUpdate);
			ProxySearch.UserParmInsertUpdateAsync(SecureID, ParmName, UserID, ParmVal, RC);
			
		}
		
		//Private Sub client_UserParmInsertUpdate(ByVal sender As Object, ByVal e As ProxySearch.UserParmInsertUpdateCompletedEventArgs)
		private static void client_UserParmInsertUpdate(object sender, SVCSearch.UserParmInsertUpdateCompletedEventArgs e)
		{
			bool RC = false;
			if (e.Error == null)
			{
				RC = System.Convert.ToBoolean(e.RC);
				if (! RC)
				{
					
				}
			}
			else
			{
				
			}
			
		}
		
		public static void WriteToLog(string LogName, string LoggedMessage, string Severity)
		{
			
			if (LoggedMessage.Trim().Length > 4000)
			{
				LoggedMessage = LoggedMessage.Substring(1, 3999);
			}
			
			string EntryUserID = modGlobals.gCurrUserGuidID;
			RSQ(ref LogName);
			RSQ(ref LoggedMessage);
			RSQ(ref EntryUserID);
			RSQ(ref Severity);
			
			if (Severity.Trim().Length == 0)
			{
				Severity = "ERROR";
			}
			string S = "";
			S += " INSERT INTO [ErrorLogs]" + "\r\n";
			S += " ([LogName]" + "\r\n";
			S += " ,[LoggedMessage]" + "\r\n";
			S += " ,[EntryUserID]" + "\r\n";
			S += " ,Severity)" + "\r\n";
			S += " VALUES( " + "\r\n";
			S += " \'" + LogName + "\'" + "\r\n";
			S += " ,\'" + LoggedMessage + "\'" + "\r\n";
			S += " ,\'" + EntryUserID + "\'" + "\r\n";
			S += " ,\'" + Severity + "\'" + "\r\n";
			S += " )";
			
			modGlobals.ExecuteSql(SecureID, S);
			
		}
		
		//Private Sub client_ExecuteSql(ByVal sender As Object, ByVal e As SVCSearch.ExecuteSqlNewConnCompletedEventArgs)
		private static void client_ExecuteSql(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			string LoggedMessage = "??";
			string Severity = "ERROR";
			if (e.Error != null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				LoggedMessage = (string) e.MySql;
				REPLSQ(ref LoggedMessage);
				if (bUpdatingLog)
				{
					bUpdatingLog = false;
				}
				else
				{
					WriteToLog("Sql", LoggedMessage, Severity);
				}
				modGlobals.gErrorCount++;
			}
		}
		
		public static void addDataTableEmail(Dictionary<string, string> EmailData)
		{
			
			System.Data.DataRow drNewRow = gEmailDT.NewRow();
			int I = 0;
			foreach (string sKey in EmailData.Keys)
			{
				string tVal = System.Convert.ToString(EmailData(sKey));
				drNewRow[sKey] = tVal;
				I++;
			}
			if (I > 0)
			{
				gEmailDT.Rows.Add(drNewRow);
				gEmailDT.AcceptChanges();
			}
			//Dim AllRecipients As String = EmailData("AllRecipients")
			//Dim Bcc As String = EmailData("Bcc")
			//Dim Body As String = EmailData("Body")
			//Dim CC As String = EmailData("CC")
			//Dim CreationTime As String = EmailData("CreationTime")
			//Dim EmailGuid As String = EmailData("EmailGuid")
			//Dim FoundInAttach As String = EmailData("FoundInAttach")
			//Dim isPublic As String = EmailData("isPublic")
			//Dim MsgSize As String = EmailData("MsgSize")
			//Dim NbrAttachments As String = EmailData("NbrAttachments")
			//Dim OriginalFolder As String = EmailData("OriginalFolder")
			//Dim RANK As String = EmailData("RANK")
			//Dim ReceivedByName As String = EmailData("ReceivedByName")
			//Dim ReceivedTime As String = EmailData("ReceivedTime")
			//Dim RepoSvrName As String = EmailData("RepoSvrName")
			//Dim RetentionExpirationDate As String = EmailData("RetentionExpirationDate")
			//Dim RID As String = EmailData("RID")
			//Dim ROWID As String = EmailData("ROWID")
			//Dim SenderEmailAddress As String = EmailData("SenderEmailAddress")
			//Dim SenderName As String = EmailData("SenderName")
			//Dim SentOn As String = EmailData("SentOn")
			//Dim SentTO As String = EmailData("SentTO")
			//Dim ShortSubj As String = EmailData("ShortSubj")
			//Dim SourceTypeCode As String = EmailData("SourceTypeCode")
			//Dim SUBJECT As String = EmailData("SUBJECT")
			//Dim UserID As String = EmailData("UserID")
			// gEmailDT.Rows.Add(AllRecipients, Bcc, Body, CC, CreationTime, EmailGuid, FoundInAttach, isPublic, MsgSize, NbrAttachments, OriginalFolder, RANK, ReceivedByName, ReceivedTime, RepoSvrName, RetentionExpirationDate, RID, ROWID, SenderEmailAddress, SenderName, SentOn, SentTO, ShortSubj, SourceTypeCode, SUBJECT, UserID)
			
		}
		public static void initDataTableEmail()
		{
			
			gEmailDT.Columns.Add("AllRecipients", typeof(string));
			gEmailDT.Columns.Add("Bcc", typeof(string));
			gEmailDT.Columns.Add("Body", typeof(string));
			gEmailDT.Columns.Add("CC", typeof(string));
			gEmailDT.Columns.Add("CreationTime", typeof(string));
			gEmailDT.Columns.Add("EmailGuid", typeof(string));
			gEmailDT.Columns.Add("FoundInAttach", typeof(string));
			gEmailDT.Columns.Add("isPublic", typeof(string));
			gEmailDT.Columns.Add("MsgSize", typeof(string));
			gEmailDT.Columns.Add("NbrAttachments", typeof(string));
			gEmailDT.Columns.Add("OriginalFolder", typeof(string));
			gEmailDT.Columns.Add("RANK", typeof(string));
			gEmailDT.Columns.Add("ReceivedByName", typeof(string));
			gEmailDT.Columns.Add("ReceivedTime", typeof(string));
			gEmailDT.Columns.Add("RepoSvrName", typeof(string));
			gEmailDT.Columns.Add("RetentionExpirationDate", typeof(string));
			gEmailDT.Columns.Add("RID", typeof(string));
			gEmailDT.Columns.Add("ROWID", typeof(string));
			gEmailDT.Columns.Add("SenderEmailAddress", typeof(string));
			gEmailDT.Columns.Add("SenderName", typeof(string));
			gEmailDT.Columns.Add("SentOn", typeof(string));
			gEmailDT.Columns.Add("SentTO", typeof(string));
			gEmailDT.Columns.Add("ShortSubj", typeof(string));
			gEmailDT.Columns.Add("SourceTypeCode", typeof(string));
			gEmailDT.Columns.Add("SUBJECT", typeof(string));
			gEmailDT.Columns.Add("UserID", typeof(string));
			
		}
		
	}
	
}

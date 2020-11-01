// VBConversions Note: VB project level imports
using System.Data;
using System.Web.UI.HtmlControls;
using System.ServiceModel.Web;
using System.Web.UI.WebControls.WebParts;
using System.Diagnostics;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Runtime.Serialization;
using System.Collections.Specialized;
using System.Web.Profile;
using Microsoft.VisualBasic;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Collections;
using System;
using System.Web;
using System.Web.UI;
using System.Web.SessionState;
using System.ServiceModel;
using System.Text;
using System.Web.Caching;
using System.Web.Security;
//using System.Linq;
	// End of VB project level imports
	
	using System.Data.SqlClient;


namespace EcmSecureAttachWCF2
{
	public class clsSecureLogin
	{
		
		public string updateRepoUsers(string CompanyID, string RepoID)
		{
			
			int RC = 0;
			if (CompanyID.Length == 0)
			{
				return "ERROR: Must select a company";
			}
			if (RepoID.Length == 0)
			{
				return "ERROR: Must select a RepoID";
			}
			Console.WriteLine("XX001");
			string CS = System.Configuration.ConfigurationManager.AppSettings["ECMSecureLogin"];
			string TS = XXI();
			CS = CS.Replace("@@PW@@", TS);
			
			string rowid = getRepoID(CompanyID, RepoID);
			string RetTxt = "";
			int I = 0;
			string action = "";
			string mysql = "";
			Console.WriteLine("XX003");
			string RepoCS = getRepoCS(CompanyID, RepoID);
			Console.WriteLine("XX004");
			Dictionary<string, string> tdict = getRepoUsers(RepoCS);
			Console.WriteLine("XX005");
			List<string> tlist = getSecureAttachUsers(CS, rowid);
			Console.WriteLine("XX006");
			Dictionary<string, string> dictusers =  (System.Collections.Generic.Dictionary<string,string>) (validateRepoUsers(tlist, tdict));
			Console.WriteLine("XX007");
			string tpw = "";
			
			SqlConnection CONN = new SqlConnection();
			SqlCommand command = new SqlCommand();
			
			try
			{
				CONN.ConnectionString = CS;
				CONN.Open();
				command.Connection = CONN;
				
				foreach (string uid in dictusers.Keys)
				{
					action = dictusers[uid];
					if (action.Equals("D"))
					{
						mysql = (string) ("delete from [User] where UserID = \'" + uid + "\' and CurrRepoID = " + rowid);
						command.CommandText = mysql;
						I = command.ExecuteNonQuery();
					}
					if (action.Equals("I"))
					{
						string sGUID;
						sGUID = System.Guid.NewGuid().ToString();
						tpw = dictusers[uid];
						mysql = "insert into [User] (UserID, UserPW, CurrRepoId) Values (\'" + uid + "\',\'" + sGUID + "\'," + rowid + ")";
						//mysql = "insert into [User] (UserID, UserPW) Values ('" + uid + "','" + sGUID + "')"
						command.CommandText = mysql;
						I = command.ExecuteNonQuery();
					}
					Console.WriteLine("XX008", mysql);
				}
				RetTxt = (string) ("Users validated for " + CompanyID + " / " + RepoID);
				Console.WriteLine("XX009", RetTxt);
			}
			catch (Exception ex)
			{
				RetTxt = (string) ("ERROR: " + ex.Message);
			}
			finally
			{
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return RetTxt;
			
		}
		
		public object validateRepoUsers(List<string> SecureUsers, Dictionary<string, string> RepoUsers)
		{
			
			Dictionary<string, string> ValidUsers = new Dictionary<string, string>();
			
			
			
			foreach (string ruser in RepoUsers.Keys)
			{
				if (SecureUsers.Contains(ruser))
				{
					ValidUsers.Add(ruser, "K");
				}
				else
				{
					ValidUsers.Add(ruser, "I");
				}
			}
			foreach (string suser in SecureUsers)
			{
				if (! RepoUsers.ContainsKey(suser))
				{
					if (ValidUsers.ContainsKey(suser))
					{
						ValidUsers[suser] = "D";
					}
					else
					{
						ValidUsers.Add(suser, "D");
					}
				}
			}
			
			return ValidUsers;
			
		}
		
		public Dictionary<string, string> getRepoUsers(string CS)
		{
			
			string S = "";
			S += " SELECT UserID, UserPassword " + "\r\n";
			S += " FROM [Users] " + "\r\n";
			
			string usr = "";
			string usrpw = "";
			Dictionary<string, string> tdict = new Dictionary<string, string>();
			
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection();
			SqlCommand command = new SqlCommand();
			
			try
			{
				CONN.ConnectionString = CS;
				CONN.Open();
				command.Connection = CONN;
				command.CommandText = S;
				RSData = command.ExecuteReader();
				
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						usr = RSData.GetValue(0).ToString();
						usrpw = RSData.GetValue(1).ToString();
						tdict.Add(usr, usrpw);
					}
				}
			}
			catch (Exception ex)
			{
				CS = (string) ("ERROR: " + ex.Message);
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
				
			}
			
			return tdict;
			
		}
		
		public List<string> getSecureAttachUsers(string CS, string CurrRepoID)
		{
			
			string S = "";
			S += " SELECT UserID " + "\r\n";
			S += " FROM [User] " + "\r\n";
			S += " where CurrRepoID = " + CurrRepoID + "\r\n";
			
			string usr = "";
			string usrpw = "";
			List<string> tlist = new List<string>();
			
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection();
			SqlCommand command = new SqlCommand();
			
			try
			{
				CONN.ConnectionString = CS;
				CONN.Open();
				command.Connection = CONN;
				command.CommandText = S;
				RSData = command.ExecuteReader();
				
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						usr = RSData.GetValue(0).ToString();
						tlist.Add(usr);
					}
				}
			}
			catch (Exception ex)
			{
				CS = (string) ("ERROR: " + ex.Message);
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
				
			}
			
			return tlist;
			
		}
		
		public string getRepoID(string CompanyID, string RepoID)
		{
			bool RC = true;
			string RetMsg = "";
			string RowID = "";
			string S = "";
			S += " SELECT RowID " + "\r\n";
			S += " FROM SecureAttach " + "\r\n";
			S += " where CompanyID = \'" + CompanyID + "\' and RepoID = \'" + RepoID + "\' " + "\r\n";
			
			string ConnStr = System.Configuration.ConfigurationManager.AppSettings["ECMSecureLogin"];
			string TS = XXI();
			ConnStr = ConnStr.Replace("@@PW@@", TS);
			
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection();
			SqlCommand command = new SqlCommand();
			
			try
			{
				CONN.ConnectionString = ConnStr;
				CONN.Open();
				command.Connection = CONN;
				command.CommandText = S;
				RSData = command.ExecuteReader();
				
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						RowID = RSData.GetValue(0).ToString();
					}
				}
			}
			catch (Exception)
			{
				RowID = "-99";
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
				
			}
			
			return RowID;
			
		}
		
		public string getRepoCS(string CompanyID, string RepoID)
		{
			bool RC = true;
			string RetMsg = "";
			string cs = "";
			string S = "";
			S += " SELECT CSRepo " + "\r\n";
			S += " FROM SecureAttach " + "\r\n";
			S += " where CompanyID = \'" + CompanyID + "\' and RepoID = \'" + RepoID + "\' " + "\r\n";
			
			string ConnStr = System.Configuration.ConfigurationManager.AppSettings["ECMSecureLogin"];
			string TS = XXI();
			ConnStr = ConnStr.Replace("@@PW@@", TS);
			
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection();
			SqlCommand command = new SqlCommand();
			
			try
			{
				CONN.ConnectionString = ConnStr;
				CONN.Open();
				command.Connection = CONN;
				command.CommandText = S;
				RSData = command.ExecuteReader();
				
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						cs = RSData.GetValue(0).ToString();
					}
				}
				
				clsEncrypt ENC = new clsEncrypt();
				cs = ENC.AES256DecryptString(cs, ref RC, ref RetMsg);
				ENC = null;
			}
			catch (Exception ex)
			{
				cs = (string) ("ERROR: " + ex.Message);
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
				
			}
			
			return cs;
			
		}
		
		public void logit(string msg)
		{
			string path = "c:\\temp\\DEBUG_LOG.txt";
			
			// This text is added only once to the file.
			if (! System.IO.File.Exists(path))
			{
				// Create a file to write to.
				using (System.IO.StreamWriter sw = System.IO.File.CreateText(path))
				{
					sw.WriteLine(msg);
				}
				
			}
			
			// This text is always added, making the file longer over time if it is not deleted.
			using (System.IO.StreamWriter sw = System.IO.File.AppendText(path))
			{
				sw.WriteLine(msg);
			}
			
			
		}
		
		public bool AttachToSecureLoginDB(string ConnStr, ref bool RC, ref string RtnMsg)
		{
			
			//Data Source=HP8GB\ECMLIBRARY;Initial Catalog=ECM.SecureLogin;Persist Security Info=True;User ID=ecmlibrary;Password=Jxxxxxxx
			//Data Source=hp8gb\ECMlibrary;Initial Catalog=ECM.SecureAttach;Persist Security Info=True;User ID=ecmlibrary;Password=Jxxxxxxx; Connect Timeout = 15
			
			logit("001 Into AttachToSecureLoginDB");
			
			bool B = true;
			RC = true;
			SqlConnection CN = new SqlConnection();
			
			logit("002 Into AttachToSecureLoginDB");
			
			try
			{
				CN.ConnectionString = ConnStr;
				CN.Open();
				RtnMsg = "Connected to SecureServer";
				logit(RtnMsg);
			}
			catch (Exception ex)
			{
				RtnMsg = (string) ("CONNECTION ERROR: " + ex.Message);
				logit(RtnMsg);
				B = false;
				RC = false;
				if (CN.State == ConnectionState.Open)
				{
					CN.Close();
				}
				CN.Dispose();
			}
			GC.Collect();
			logit("003 Exiting AttachToSecureLoginDB");
			return B;
		}
		
		public string XXI()
		{
			bool RC = true;
			string RetMsg = "";
			string XI = System.Configuration.ConfigurationManager.AppSettings["EncPW"];
			clsEncrypt ENC = new clsEncrypt();
			XI = ENC.AES256DecryptString(XI, ref RC, ref RetMsg);
			ENC = null;
			GC.Collect();
			return XI;
		}
		
		public bool ValidateGatewayLogin(string CompanyID, string RepoID, string EncPW, ref bool RC, ref string RtnMsg)
		{
			
			bool B = false;
			string MySql = "select COUNT(*) from SecureAttach where CompanyID = \'" + CompanyID + "\' and RepoID = \'" + RepoID + "\' and EncPW = \'" + EncPW + "\'";
			string Connstr = "";
			Connstr = System.Configuration.ConfigurationManager.AppSettings["ECMSecureLogin"];
			string TS = XXI();
			Connstr = Connstr.Replace("@@PW@@", TS);
			
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection(Connstr);
			CONN.Open();
			SqlCommand command = new SqlCommand(MySql, CONN);
			
			command.Parameters.AddWithValue("@CompanyID", CompanyID);
			command.Parameters.AddWithValue("@RepoID", RepoID);
			
			RSData = command.ExecuteReader();
			int iCnt = 0;
			try
			{
				if (RSData.HasRows)
				{
					RSData.Read();
					iCnt = RSData.GetInt32(0);
					if (iCnt > 0)
					{
						B = true;
					}
					else
					{
						B = false;
					}
				}
				else
				{
					B = false;
					iCnt = 0;
				}
			}
			catch (Exception ex)
			{
				B = false;
				RC = false;
				RtnMsg = ex.Message.ToString();
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return B;
			
		}
		
		public bool ValidateUserLogin(string UID, string EncPW)
		{
			
			bool RC = false;
			string RetMsg = "";
			
			clsEncrypt ENC = new clsEncrypt();
			EncPW = ENC.AES256DecryptString(EncPW, ref RC, ref RetMsg);
			ENC = null;
			
			bool B = false;
			string MySql = "select COUNT(*) from User where Userid  = \'" + UID + "\' and UserPW = \'" + EncPW + "\' ";
			string Connstr = "";
			
			Connstr = System.Configuration.ConfigurationManager.AppSettings["ECMSecureLogin"];
			string TS = XXI();
			Connstr = Connstr.Replace("@@PW@@", TS);
			
			int iCnt = 0;
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection(Connstr);
			CONN.Open();
			SqlCommand command = new SqlCommand(MySql, CONN);
			
			RSData = command.ExecuteReader();
			
			try
			{
				if (RSData.HasRows)
				{
					RSData.Read();
					iCnt = RSData.GetInt32(0);
					if (iCnt > 0)
					{
						B = true;
					}
					else
					{
						B = false;
					}
				}
				else
				{
					B = false;
					iCnt = 0;
				}
			}
			catch (Exception)
			{
				B = false;
				RC = false;
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return B;
			
		}
		
		public bool SaveConnection(string ConnStr, Dictionary<string, string> tDict, ref bool RC, ref string RtnMsg)
		{
			
			clsEncrypt ENC = new clsEncrypt();
			string RetMsg = "";
			
			string CreateDate = "";
			string LastModDate = "";
			string Disabled = "";
			string isThesaurus = "";
			string RowID = "";
			string RepoID = "";
			string CompanyID = "";
			string EncPW = "";
			string Cs = "";
			string CSThesaurus = "";
			string CSHive = "";
			string CSRepo = "";
			string CSDMALicense = "";
			string CSGateWay = "";
			string CSTDR = "";
			string CSKBase = "";
			
			string gSVCFS_Endpoint = "";
			string gSVCGateway_Endpoint = "";
			string gSVCCLCArchive_Endpoint = "";
			string gSVCSearch_Endpoint = "";
			string gSVCDownload_Endpoint = "";
			
			//CreateDate = tDict("CreateDate")
			//LastModDate = tDict("LastModDate")
			Disabled = System.Convert.ToString(tDict["Disabled"]);
			Disabled = ENC.AES256DecryptString(Disabled, ref RC, ref RetMsg);
			
			isThesaurus = System.Convert.ToString(tDict["isThesaurus"]);
			isThesaurus = ENC.AES256DecryptString(isThesaurus, ref RC, ref RetMsg);
			//wdmxx
			
			RepoID = System.Convert.ToString(tDict["RepoID"]);
			RepoID = ENC.AES256DecryptString(RepoID, ref RC, ref RetMsg);
			
			CompanyID = System.Convert.ToString(tDict["CompanyID"]);
			CompanyID = ENC.AES256DecryptString(CompanyID, ref RC, ref RetMsg);
			
			EncPW = System.Convert.ToString(tDict["EncPW"]);
			Cs = System.Convert.ToString(tDict["Cs"]);
			CSThesaurus = System.Convert.ToString(tDict["CSThesaurus"]);
			CSHive = System.Convert.ToString(tDict["CSHive"]);
			CSRepo = System.Convert.ToString(tDict["CSRepo"]);
			CSDMALicense = System.Convert.ToString(tDict["CSDMALicense"]);
			CSGateWay = System.Convert.ToString(tDict["CSGateWay"]);
			CSTDR = System.Convert.ToString(tDict["CSTDR"]);
			CSKBase = System.Convert.ToString(tDict["CSKBase"]);
			
			gSVCFS_Endpoint = System.Convert.ToString(tDict["SVCFS_Endpoint"]);
			gSVCFS_Endpoint = ENC.AES256DecryptString(gSVCFS_Endpoint, ref RC, ref RetMsg);
			
			gSVCGateway_Endpoint = System.Convert.ToString(tDict["SVCGateway_Endpoint"]);
			gSVCGateway_Endpoint = ENC.AES256DecryptString(gSVCGateway_Endpoint, ref RC, ref RetMsg);
			
			gSVCCLCArchive_Endpoint = System.Convert.ToString(tDict["SVCCLCArchive_Endpoint"]);
			gSVCCLCArchive_Endpoint = ENC.AES256DecryptString(gSVCCLCArchive_Endpoint, ref RC, ref RetMsg);
			
			gSVCSearch_Endpoint = System.Convert.ToString(tDict["SVCSearch_Endpoint"]);
			gSVCSearch_Endpoint = ENC.AES256DecryptString(gSVCSearch_Endpoint, ref RC, ref RetMsg);
			
			gSVCDownload_Endpoint = System.Convert.ToString(tDict["SVCDownload_Endpoint"]);
			gSVCDownload_Endpoint = ENC.AES256DecryptString(gSVCDownload_Endpoint, ref RC, ref RetMsg);
			
			bool B = true;
			string MySql = "Select count(*) from SecureAttach " + "\r\n";
			MySql += "where CompanyID = @CompanyID and RepoID = @RepoID";
			
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection(ConnStr);
			CONN.Open();
			SqlCommand command = new SqlCommand(MySql, CONN);
			
			command.Parameters.AddWithValue("@CompanyID", CompanyID);
			command.Parameters.AddWithValue("@RepoID", RepoID);
			
			RSData = command.ExecuteReader();
			int iCnt = 0;
			try
			{
				if (RSData.HasRows)
				{
					RSData.Read();
					iCnt = RSData.GetInt32(0);
				}
				else
				{
					iCnt = 0;
				}
			}
			catch (Exception ex)
			{
				B = false;
				RC = false;
				RtnMsg = ex.Message;
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			if (B)
			{
				if (iCnt == 0)
				{
					B = AddNewConnection(ConnStr, tDict, ref RC, ref RtnMsg);
					if (B == true)
					{
						B = UpdateExistingConnection(ConnStr, tDict, ref RC, ref RtnMsg);
					}
				}
				else
				{
					B = UpdateExistingConnection(ConnStr, tDict, ref RC, ref RtnMsg);
				}
			}
			
			return B;
		}
		
		public bool AddNewConnection(string ConnStr, Dictionary<string, string> tDict, ref bool RC, ref string RtnMsg)
		{
			
			//Dim CreateDate As String = tDict("CreateDate")
			//Dim LastModDate As String = tDict("LastModDate")
			string Disabled = System.Convert.ToString(tDict["Disabled"]);
			string isThesaurus = System.Convert.ToString(tDict["isThesaurus"]);
			string RowID = System.Convert.ToString(tDict["RepoID"]);
			string RepoID = System.Convert.ToString(tDict["RepoID"]);
			string CompanyID = System.Convert.ToString(tDict["CompanyID"]);
			string EncPW = System.Convert.ToString(tDict["EncPW"]);
			string Cs = System.Convert.ToString(tDict["Cs"]);
			string CSThesaurus = System.Convert.ToString(tDict["CSThesaurus"]);
			string CSHive = System.Convert.ToString(tDict["CSHive"]);
			string CSRepo = System.Convert.ToString(tDict["CSRepo"]);
			string CSDMALicense = System.Convert.ToString(tDict["CSDMALicense"]);
			string CSGateWay = System.Convert.ToString(tDict["CSGateWay"]);
			string CSTDR = System.Convert.ToString(tDict["CSTDR"]);
			string CSKBase = System.Convert.ToString(tDict["CSKBase"]);
			
			string SVCFS_Endpoint = System.Convert.ToString(tDict["SVCFS_Endpoint"]);
			string SVCGateway_Endpoint = System.Convert.ToString(tDict["SVCGateway_Endpoint"]);
			string SVCCLCArchive_Endpoint = System.Convert.ToString(tDict["SVCCLCArchive_Endpoint"]);
			string SVCSearch_Endpoint = System.Convert.ToString(tDict["SVCSearch_Endpoint"]);
			string SVCDownload_Endpoint = System.Convert.ToString(tDict["SVCDownload_Endpoint"]);
			
			bool B = true;
			SqlConnection CN = new SqlConnection();
			RtnMsg = "";
			RC = true;
			
			string MySql = "";
			MySql += " INSERT INTO SecureAttach" + "\r\n";
			MySql += " (CompanyID" + "\r\n";
			MySql += " ,EncPW" + "\r\n";
			MySql += " ,RepoID" + "\r\n";
			MySql += " ,CS" + "\r\n";
			MySql += " ,Disabled" + "\r\n";
			MySql += " ,isThesaurus)" + "\r\n";
			MySql += " VALUES " + "\r\n";
			MySql += " (@CompanyID" + "\r\n";
			MySql += " ,@EncPW" + "\r\n";
			MySql += " ,@RepoID" + "\r\n";
			MySql += " ,@CS" + "\r\n";
			MySql += " ,@isThesaurus" + "\r\n";
			MySql += " ,@Disabled)" + "\r\n";
			
			try
			{
				B = true;
				CN.ConnectionString = ConnStr;
				CN.Open();
				
				using (CN)
				{
					using (SqlCommand command = new SqlCommand(MySql, CN))
					{
						command.CommandType = CommandType.Text;
						command.Parameters.AddWithValue("@CompanyID", CompanyID);
						command.Parameters.AddWithValue("@EncPW", EncPW);
						command.Parameters.AddWithValue("@RepoID", RepoID);
						command.Parameters.AddWithValue("@CS", Cs);
						command.Parameters.AddWithValue("@Disabled", Disabled);
						command.Parameters.AddWithValue("@isThesaurus", isThesaurus);
						
						command.ExecuteNonQuery();
						command.Dispose();
					}
					
				}
				
			}
			catch (Exception ex)
			{
				B = false;
				RC = false;
				RtnMsg = ex.Message.ToString();
			}
			finally
			{
				CN.Close();
				CN.Dispose();
				GC.Collect();
			}
			
			return B;
		}
		
		public bool duplicateEntryx(string ConnStr, Dictionary<string, string> tDict)
		{
			
			clsEncrypt ENC = new clsEncrypt();
			
			bool B = true;
			SqlConnection CN = new SqlConnection();
			string RetMsg = "";
			
			string CreateDate = "";
			string LastModDate = DateTime.Now.ToString();
			string Disabled = "";
			string isThesaurus = "";
			string RowID = "";
			string RepoID = "";
			string CompanyID = "";
			string EncPW = "";
			string Cs = "";
			string CSThesaurus = "";
			string CSHive = "";
			string CSRepo = "";
			string CSDMALicense = "";
			string CSGateWay = "";
			string CSTDR = "";
			string CSKBase = "";
			
			string gSVCFS_Endpoint = "";
			string gSVCGateway_Endpoint = "";
			string gSVCCLCArchive_Endpoint = "";
			string gSVCSearch_Endpoint = "";
			string gSVCDownload_Endpoint = "";
			
			string MySql = "Update SecureAttach " + "\r\n";
			MySql += "SET" + "\r\n";
			MySql += " EncPW = @EncPW " + "\r\n";
			MySql += ", CS = @CS " + "\r\n";
			MySql += ", Disabled = @Disabled " + "\r\n";
			MySql += ", isThesaurus = @isThesaurus " + "\r\n";
			MySql += ", CSRepo = @CSRepo " + "\r\n";
			MySql += ", CSThesaurus = @CSThesaurus " + "\r\n";
			MySql += ", CSHive = @CSHive " + "\r\n";
			MySql += ", CSDMALicense = @CSDMALicense " + "\r\n";
			MySql += ", CSGateWay = @CSGateWay " + "\r\n";
			MySql += ", CSTDR = @CSTDR " + "\r\n";
			MySql += ", CSKBase = @CSKBase " + "\r\n";
			MySql += ", LastModDate = @LastModDate " + "\r\n";
			MySql += ", SVCFS_Endpoint = @SVCFS_Endpoint " + "\r\n";
			MySql += ", SVCGateway_Endpoint = @SVCGateway_Endpoint " + "\r\n";
			MySql += ", SVCCLCArchive_Endpoint = @SVCCLCArchive_Endpoint " + "\r\n";
			MySql += ", SVCSearch_Endpoint = @SVCSearch_Endpoint " + "\r\n";
			MySql += ", SVCDownload_Endpoint = @SVCDownload_Endpoint " + "\r\n";
			MySql += "where CompanyID = @CompanyID and RepoID = @RepoID";
			
			try
			{
				B = true;
				CN.ConnectionString = ConnStr;
				CN.Open();
				
				using (CN)
				{
					using (SqlCommand command = new SqlCommand(MySql, CN))
					{
						command.CommandType = CommandType.Text;
						command.Parameters.AddWithValue("@CompanyID", CompanyID);
						command.Parameters.AddWithValue("@RepoID", RepoID);
						command.Parameters.AddWithValue("@EncPW", EncPW);
						command.Parameters.AddWithValue("@CS", Cs);
						command.Parameters.AddWithValue("@Disabled", Disabled);
						command.Parameters.AddWithValue("@isThesaurus", isThesaurus);
						
						command.Parameters.AddWithValue("@CSRepo", CSRepo);
						command.Parameters.AddWithValue("@CSThesaurus", CSThesaurus);
						command.Parameters.AddWithValue("@CSHive", CSHive);
						command.Parameters.AddWithValue("@CSDMALicense", CSDMALicense);
						command.Parameters.AddWithValue("@CSGateWay", CSGateWay);
						command.Parameters.AddWithValue("@CSTDR", CSTDR);
						command.Parameters.AddWithValue("@CSKBase", CSKBase);
						command.Parameters.AddWithValue("@LastModDate", LastModDate);
						command.Parameters.AddWithValue("@SVCFS_Endpoint", gSVCFS_Endpoint);
						command.Parameters.AddWithValue("@SVCGateway_Endpoint", gSVCGateway_Endpoint);
						command.Parameters.AddWithValue("@SVCCLCArchive_Endpoint", gSVCCLCArchive_Endpoint);
						command.Parameters.AddWithValue("@SVCSearch_Endpoint", gSVCSearch_Endpoint);
						command.Parameters.AddWithValue("@SVCDownload_Endpoint", gSVCDownload_Endpoint);
						
						command.ExecuteNonQuery();
						command.Dispose();
					}
					
				}
				
			}
			catch (Exception)
			{
				B = false;
			}
			finally
			{
				CN.Close();
				CN.Dispose();
				GC.Collect();
			}
			
			return B;
		}
		
		public bool DeleteExistingConnection(string ConnStr, Dictionary<string, string> tDict, ref bool RC, ref string RtnMsg)
		{
			
			string RepoID = System.Convert.ToString(tDict["RepoID"]);
			string CompanyID = System.Convert.ToString(tDict["CompanyID"]);
			string RowID = System.Convert.ToString(tDict["RowID"]);
			
			bool B = true;
			SqlConnection CN = new SqlConnection();
			RtnMsg = "";
			RC = true;
			
			string MySql = "delete from SecureAttach " + "\r\n";
			MySql += "where CompanyID = @CompanyID and RepoID = @RepoID";
			
			try
			{
				B = true;
				CN.ConnectionString = ConnStr;
				CN.Open();
				
				using (CN)
				{
					using (SqlCommand command = new SqlCommand(MySql, CN))
					{
						command.CommandType = CommandType.Text;
						command.Parameters.AddWithValue("@CompanyID", CompanyID);
						command.Parameters.AddWithValue("@RepoID", RepoID);
						command.ExecuteNonQuery();
						command.Dispose();
					}
					
					MySql = "delete from [user] " + "\r\n";
					MySql += "where CurrRepoID = @CurrRepoID";
					using (SqlCommand command2 = new SqlCommand(MySql, CN))
					{
						command2.CommandType = CommandType.Text;
						command2.Parameters.AddWithValue("@CurrRepoID", RowID);
						command2.ExecuteNonQuery();
						command2.Dispose();
					}
					
				}
				
			}
			catch (Exception ex)
			{
				B = false;
				RC = false;
				RtnMsg = ex.Message.ToString();
			}
			finally
			{
				CN.Close();
				CN.Dispose();
				GC.Collect();
			}
			
			return B;
		}
		
		public List<DS_SecureAttach> PopulateGrid(string CS, string CompanyID, string EncPW, ref bool RC, ref string RetTxt, int LimitToCompany)
		{
			
			List<DS_SecureAttach> ListOfItems = new List<DS_SecureAttach>();
			RC = true;
			RetTxt = "";
			
			string sCompanyID = "";
			string sEncPW = "";
			string sRepoID = "";
			string sCS = "";
			int Disabled = 0;
			
			int RowID = System.Convert.ToInt32(null);
			int isThesaurus = 0;
			string CSRepo = "";
			string CSThesaurus = "";
			string CSHive = "";
			string CSDMALicense = "";
			string CSGateWay = "";
			string CSTDR = "";
			string CSKBase = "";
			DateTime CreateDate = Convert.ToDateTime(null);
			DateTime LastModDate = Convert.ToDateTime(null);
			string SVCFS_Endpoint = "";
			string SVCGateway_Endpoint = "";
			string SVCCLCArchive_Endpoint = "";
			string SVCSearch_Endpoint = "";
			string SVCDownload_Endpoint = "";
			string SVCFS_CS = "";
			string SVCGateway_CS = "";
			string SVCSearch_CS = "";
			string SVCDownload_CS = "";
			string SVCThesaurus_CS = "";
			string S = "";
			
			S += " Select CompanyID" + "\r\n";
			S += " ,EncPW" + "\r\n";
			S += " ,RepoID" + "\r\n";
			S += " ,CS" + "\r\n";
			S += " ,Disabled" + "\r\n";
			S += " ,RowID" + "\r\n";
			S += " ,isThesaurus" + "\r\n";
			S += " ,CSRepo" + "\r\n";
			S += " ,CSThesaurus" + "\r\n";
			S += " ,CSHive" + "\r\n";
			S += " ,CSDMALicense" + "\r\n";
			S += " ,CSGateWay" + "\r\n";
			S += " ,CSTDR" + "\r\n";
			S += " ,CSKBase" + "\r\n";
			S += " ,CreateDate" + "\r\n";
			S += " ,LastModDate" + "\r\n";
			S += " ,SVCFS_Endpoint" + "\r\n";
			S += " ,SVCGateway_Endpoint" + "\r\n";
			S += " ,SVCCLCArchive_Endpoint" + "\r\n";
			S += " ,SVCSearch_Endpoint" + "\r\n";
			S += " ,SVCDownload_Endpoint" + "\r\n";
			S += " ,SVCFS_CS" + "\r\n";
			S += " ,SVCGateway_CS" + "\r\n";
			S += " ,SVCSearch_CS" + "\r\n";
			S += " ,SVCDownload_CS" + "\r\n";
			S += " ,SVCThesaurus_CS" + "\r\n";
			S += " FROM SecureAttach";
			
			if (LimitToCompany > 0)
			{
				S += " Where CompanyID = \'" + CompanyID + "\'" + "\r\n";
			}
			
			S += " order by CompanyID, RepoID" + "\r\n";
			
			bool ddebug = true;
			if (ddebug.Equals(true))
			{
				Debug.Print((string) ("01x SQL: " + "\r\n" + S));
			}
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			
			RSData = command.ExecuteReader();
			
			try
			{
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						try
						{
							sCompanyID = RSData.GetValue(0).ToString();
						}
						catch (Exception)
						{
							sCompanyID = "";
						}
						try
						{
							sEncPW = RSData.GetValue(1).ToString();
						}
						catch (Exception)
						{
							sEncPW = "";
						}
						try
						{
							sRepoID = RSData.GetValue(2).ToString();
						}
						catch (Exception)
						{
							sRepoID = "";
						}
						try
						{
							sCS = RSData.GetValue(3).ToString();
						}
						catch (Exception)
						{
							sCS = "";
						}
						try
						{
							Disabled = System.Convert.ToInt32(RSData.GetBoolean(4));
						}
						catch (Exception)
						{
							Disabled = 0;
						}
						try
						{
							RowID = RSData.GetInt32(5);
						}
						catch (Exception)
						{
							RowID = -1;
						}
						try
						{
							isThesaurus = System.Convert.ToInt32(RSData.GetBoolean(6));
						}
						catch (Exception)
						{
							isThesaurus = 0;
						}
						try
						{
							CSRepo = RSData.GetString(7);
						}
						catch (Exception)
						{
							CSRepo = "";
						}
						try
						{
							CSThesaurus = RSData.GetString(8);
						}
						catch (Exception)
						{
							CSThesaurus = "";
						}
						try
						{
							CSHive = RSData.GetString(9);
						}
						catch (Exception)
						{
							CSHive = "";
						}
						try
						{
							CSDMALicense = RSData.GetString(10);
						}
						catch (Exception)
						{
							CSDMALicense = "";
						}
						try
						{
							CSGateWay = RSData.GetString(11);
						}
						catch (Exception)
						{
							CSGateWay = "";
						}
						try
						{
							CSTDR = RSData.GetString(12);
						}
						catch (Exception)
						{
							CSTDR = "";
						}
						try
						{
							CSKBase = RSData.GetString(13);
						}
						catch (Exception)
						{
							CSKBase = "";
						}
						try
						{
							CreateDate = RSData.GetDateTime(14);
						}
						catch (Exception)
						{
							CreateDate = Convert.ToDateTime(null);
						}
						try
						{
							LastModDate = RSData.GetDateTime(15);
						}
						catch (Exception)
						{
							LastModDate = Convert.ToDateTime(null);
						}
						try
						{
							SVCFS_Endpoint = RSData.GetString(16);
						}
						catch (Exception)
						{
							SVCFS_Endpoint = "";
						}
						try
						{
							SVCGateway_Endpoint = RSData.GetString(17);
						}
						catch (Exception)
						{
							SVCGateway_Endpoint = "";
						}
						try
						{
							SVCCLCArchive_Endpoint = RSData.GetString(18);
						}
						catch (Exception)
						{
							SVCCLCArchive_Endpoint = "";
						}
						try
						{
							SVCSearch_Endpoint = RSData.GetString(19);
						}
						catch (Exception)
						{
							SVCSearch_Endpoint = "";
						}
						try
						{
							SVCDownload_Endpoint = RSData.GetString(20);
						}
						catch (Exception)
						{
							SVCDownload_Endpoint = "";
						}
						try
						{
							SVCFS_CS = RSData.GetString(21);
						}
						catch (Exception)
						{
							SVCFS_CS = "";
						}
						try
						{
							SVCGateway_CS = RSData.GetString(22);
						}
						catch (Exception)
						{
							SVCGateway_CS = "";
						}
						try
						{
							SVCSearch_CS = RSData.GetString(23);
						}
						catch (Exception)
						{
							SVCSearch_CS = "";
						}
						try
						{
							SVCDownload_CS = RSData.GetString(24);
						}
						catch (Exception)
						{
							SVCDownload_CS = "";
						}
						try
						{
							SVCThesaurus_CS = RSData.GetString(25);
						}
						catch (Exception)
						{
							SVCThesaurus_CS = "";
						}
						
						DS_SecureAttach LI = new DS_SecureAttach();
						LI.CompanyID = sCompanyID;
						LI.EncPW = sEncPW;
						LI.RepoID = sRepoID;
						LI.CS = sCS;
						LI.Disabled = Disabled;
						LI.RowID = RowID;
						LI.isThesaurus = isThesaurus;
						LI.CSRepo = CSRepo;
						LI.CSThesaurus = CSThesaurus;
						LI.CSHive = CSHive;
						LI.CSDMALicense = CSDMALicense;
						LI.CSGateWay = CSGateWay;
						LI.CSTDR = CSTDR;
						LI.CSKBase = CSKBase;
						LI.CreateDate = CreateDate;
						LI.LastModDate = LastModDate;
						LI.SVCFS_Endpoint = SVCFS_Endpoint;
						LI.SVCGateway_Endpoint = SVCGateway_Endpoint;
						LI.SVCCLCArchive_Endpoint = SVCCLCArchive_Endpoint;
						LI.SVCSearch_Endpoint = SVCSearch_Endpoint;
						LI.SVCDownload_Endpoint = SVCDownload_Endpoint;
						LI.SVCFS_CS = SVCFS_CS;
						LI.SVCGateway_CS = SVCGateway_CS;
						LI.SVCSearch_CS = SVCSearch_CS;
						LI.SVCDownload_CS = SVCDownload_CS;
						LI.SVCThesaurus_CS = SVCThesaurus_CS;
						
						ListOfItems.Add(LI);
					}
				}
				else
				{
					ListOfItems = null;
				}
			}
			catch (Exception ex)
			{
				RC = false;
				RetTxt = ex.Message;
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return ListOfItems;
			
		}
		
		/// <summary>
		/// </summary>
		/// <param name="CS">
		/// Leave the connection string blank to use the locally defined CONFIG connection string
		/// </param>
		/// <param name="CompanyID"></param>
		/// <param name="RC">       </param>
		/// <param name="RetTxt">   </param>
		/// <returns></returns>
		/// <remarks></remarks>
		public string PopulateCombo(string CS, string CompanyID, ref bool RC, ref string RetTxt)
		{
			
			if (CS.Length == 0)
			{
				
				CS = System.Configuration.ConfigurationManager.AppSettings["ECMSecureLogin"];
				string TS = XXI();
				CS = CS.Replace("@@PW@@", TS);
			}
			
			string lItems = "";
			RC = true;
			RetTxt = "";
			
			string sCompanyID = "";
			string sEncPW = "";
			string sRepoID = "";
			//Dim sCS As String = ""
			bool Disabled = System.Convert.ToBoolean(null);
			
			string S = "";
			S += " SELECT distinct CompanyID" + "\r\n";
			S += " FROM SecureAttach " + "\r\n";
			S += " order by CompanyID" + "\r\n";
			
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection();
			SqlCommand command = new SqlCommand();
			
			try
			{
				CONN.ConnectionString = CS;
				CONN.Open();
				command.Connection = CONN;
				command.CommandText = S;
				RSData = command.ExecuteReader();
				
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						DS_Combo LI = new DS_Combo();
						sCompanyID = RSData.GetValue(0).ToString();
						lItems += sCompanyID + "|";
					}
				}
				RetTxt = lItems;
			}
			catch (Exception ex)
			{
				RC = false;
				RetTxt = ex.Message;
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return lItems;
			
		}
		
		public int getSecureID(string CompanyID, string RepoID)
		{
			
			string CS = System.Configuration.ConfigurationManager.AppSettings["ECMSecureLogin"];
			string TS = XXI();
			CS = CS.Replace("@@PW@@", TS);
			
			string ListOfItems = "";
			int rid = -1;
			
			string sCompanyID = "";
			string sEncPW = "";
			string sRepoID = "";
			//Dim sCS As String = ""
			bool Disabled = System.Convert.ToBoolean(null);
			string SVCFS_Endpoint = "";
			string SVCGateway_Endpoint = "";
			string SVCCLCArchive_Endpoint = "";
			string SVCSearch_Endpoint = "";
			string SVCDownload_Endpoint = "";
			
			string S = "";
			S += " Select RowID ";
			S += " From [dbo].[SecureAttach] ";
			S += " Where [CompanyID] = \'" + CompanyID + "\' ";
			S += " And [RepoID] = \'" + RepoID + "\' ";
			
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection();
			SqlCommand command = new SqlCommand();
			
			try
			{
				CONN.ConnectionString = CS;
				CONN.Open();
				command.Connection = CONN;
				command.CommandText = S;
				RSData = command.ExecuteReader();
				
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						rid = RSData.GetInt32(0);
					}
				}
			}
			catch (Exception)
			{
				rid = -1;
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return rid;
			
		}
		
		public string getEndPoints(string CompanyID, string RepoID)
		{
			
			//'*************************************** DEBUG SETUP FOR ENDPOINTS *******************************************
			//update [ECM.SecureLogin].[dbo].[SecureAttach]
			//set [SVCCLCArchive_Endpoint] = 'http://108.60.211.158/archive/SVCCLCArchive.svc'
			//where RowID = 23
			
			//update [ECM.SecureLogin].[dbo].[SecureAttach]
			//set [SVCCLCArchive_Endpoint] = 'http://localhost:53407/SVCCLCArchive.svc'
			//where RowID = 23
			//'*************************************************************************************************************
			
			string CS = System.Configuration.ConfigurationManager.AppSettings["ECMSecureLogin"];
			string TS = XXI();
			CS = CS.Replace("@@PW@@", TS);
			
			string ListOfItems = "";
			var RC = true;
			var RetTxt = "";
			
			string sCompanyID = "";
			string sEncPW = "";
			string sRepoID = "";
			//Dim sCS As String = ""
			bool Disabled = System.Convert.ToBoolean(null);
			string SVCFS_Endpoint = "";
			string SVCGateway_Endpoint = "";
			string SVCCLCArchive_Endpoint = "";
			string SVCSearch_Endpoint = "";
			string SVCDownload_Endpoint = "";
			
			string S = "";
			S += " Select SVCFS_Endpoint, [SVCGateway_Endpoint],[SVCCLCArchive_Endpoint],[SVCSearch_Endpoint],[SVCDownload_Endpoint] ";
			S += " From [dbo].[SecureAttach] ";
			S += " Where [CompanyID] = \'" + CompanyID + "\' ";
			S += " And [RepoID] = \'" + RepoID + "\' ";
			
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection();
			SqlCommand command = new SqlCommand();
			
			try
			{
				CONN.ConnectionString = CS;
				CONN.Open();
				command.Connection = CONN;
				command.CommandText = S;
				RSData = command.ExecuteReader();
				
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						SVCFS_Endpoint = RSData.GetValue(0).ToString();
						SVCGateway_Endpoint = RSData.GetValue(1).ToString();
						SVCCLCArchive_Endpoint = RSData.GetValue(2).ToString();
						SVCSearch_Endpoint = RSData.GetValue(3).ToString();
						SVCDownload_Endpoint = RSData.GetValue(4).ToString();
						ListOfItems += SVCFS_Endpoint + "|";
						ListOfItems += SVCGateway_Endpoint + "|";
						ListOfItems += SVCCLCArchive_Endpoint + "|";
						ListOfItems += SVCSearch_Endpoint + "|";
						ListOfItems += SVCDownload_Endpoint;
					}
				}
				RetTxt = ListOfItems;
			}
			catch (Exception ex)
			{
				RC = false;
				RetTxt = ex.Message;
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return ListOfItems;
		}
		
		public string getCS(int gSecureID)
		{
			string CS = "";
			CS = System.Configuration.ConfigurationManager.AppSettings["ECMSecureLogin"];
			string TS = XXI();
			CS = CS.Replace("@@PW@@", TS);
			
			string lItems = "";
			string sEncPW = "";
			string sRepoID = "";
			bool Disabled = System.Convert.ToBoolean(null);
			
			string S = "";
			S += (string) (" SELECT CS FROM [dbo].[SecureAttach] where [RowID] = " + gSecureID.ToString());
			
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection();
			SqlCommand command = new SqlCommand();
			
			try
			{
				CONN.ConnectionString = CS;
				CONN.Open();
				command.Connection = CONN;
				command.CommandText = S;
				RSData = command.ExecuteReader();
				
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						DS_Combo LI = new DS_Combo();
						lItems = RSData.GetValue(0).ToString();
					}
				}
			}
			catch (Exception)
			{
				return "";
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return lItems;
		}
		
		public string getRepoCS(int gSecureID)
		{
			string CS = "";
			CS = System.Configuration.ConfigurationManager.AppSettings["ECMSecureLogin"];
			string TS = XXI();
			CS = CS.Replace("@@PW@@", TS);
			
			string lItems = "";
			string sEncPW = "";
			string sRepoID = "";
			bool Disabled = System.Convert.ToBoolean(null);
			
			string S = "";
			S += (string) (" SELECT CSRepo FROM [dbo].[SecureAttach] where [RowID] = " + gSecureID.ToString());
			
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection();
			SqlCommand command = new SqlCommand();
			
			try
			{
				CONN.ConnectionString = CS;
				CONN.Open();
				command.Connection = CONN;
				command.CommandText = S;
				RSData = command.ExecuteReader();
				
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						DS_Combo LI = new DS_Combo();
						lItems = RSData.GetValue(0).ToString();
					}
				}
			}
			catch (Exception)
			{
				return "";
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return lItems;
		}
		
		public int validateAttachSecureLogin(int gSecureID, string gCompanyID, string gRepoID, string LoginID, string EPW)
		{
			
			string RepoCS = getCS(gSecureID);
			if (RepoCS.Length <= 0)
			{
				return -100;
			}
			int RC = 0;
			
			string S = "";
			S = "SELECT count(*) FROM [Users] where UserID = \'" + LoginID + "\' and UserPassword = \'" + EPW + "\' ";
			
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection();
			SqlCommand command = new SqlCommand();
			
			try
			{
				CONN.ConnectionString = RepoCS;
				CONN.Open();
				command.Connection = CONN;
				command.CommandText = S;
				RSData = command.ExecuteReader();
				
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						RC = RSData.GetInt32(0);
					}
				}
			}
			catch (Exception)
			{
				return -1;
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return RC;
		}
		
		public string getGatewayCS(int gSecureID, string gCompanyID, string gRepoID, string EPW)
		{
			
			string CS = "";
			CS = System.Configuration.ConfigurationManager.AppSettings["ECMSecureLogin"];
			string TS = XXI();
			CS = CS.Replace("@@PW@@", TS);
			
			string lItems = "";
			string sEncPW = "";
			string sRepoID = "";
			bool Disabled = System.Convert.ToBoolean(null);
			
			string S = "";
			S += " SELECT CS FROM [dbo].[SecureAttach] where [CompanyID] = \'" + gCompanyID + "\' and RepoID = \'" + gRepoID + "\' and EncPW = \'" + EPW + "\' ";
			
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection();
			SqlCommand command = new SqlCommand();
			
			try
			{
				CONN.ConnectionString = CS;
				CONN.Open();
				command.Connection = CONN;
				command.CommandText = S;
				RSData = command.ExecuteReader();
				
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						DS_Combo LI = new DS_Combo();
						lItems = RSData.GetValue(0).ToString();
					}
				}
			}
			catch (Exception)
			{
				return "";
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return lItems;
		}
		
		public string PopulateGatewayLoginCB(string CS, string CompanyID)
		{
			
			if (CS.Length == 0)
			{
				
				CS = System.Configuration.ConfigurationManager.AppSettings["ECMSecureLogin"];
				string TS = XXI();
				CS = CS.Replace("@@PW@@", TS);
			}
			
			string lItems = "";
			string sCompanyID = "";
			string sEncPW = "";
			string sRepoID = "";
			bool Disabled = System.Convert.ToBoolean(null);
			
			string S = "";
			S += " SELECT RepoID FROM [dbo].[SecureAttach] where [CompanyID] = \'" + CompanyID + "\' order by RepoID ";
			
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection();
			SqlCommand command = new SqlCommand();
			
			try
			{
				CONN.ConnectionString = CS;
				CONN.Open();
				command.Connection = CONN;
				command.CommandText = S;
				RSData = command.ExecuteReader();
				
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						DS_Combo LI = new DS_Combo();
						sCompanyID = RSData.GetValue(0).ToString();
						lItems += sCompanyID + "|";
					}
				}
			}
			catch (Exception)
			{
				return "";
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return lItems;
		}
		
		public string PopulateCompanyComboSecure(string CS, string CompanyID, string EncryptedPW, ref bool RC, ref string RetTxt)
		{
			
			//Dim ENC As New clsEncrypt
			//Try
			//    EncryptedPW = ENC.AES256DecryptString(EncryptedPW, RC, RetTxt)
			//Catch ex As Exception
			//    ENC = Nothing
			//    RC = False
			//    RetTxt = "ERROR: PopulateCompanyComboSecure 100 - " + ex.Message
			//    Return ""
			//End Try
			//ENC = Nothing
			//GC.Collect()
			
			if (CS.Length == 0)
			{
				
				CS = System.Configuration.ConfigurationManager.AppSettings["ECMSecureLogin"];
				string TS = XXI();
				CS = CS.Replace("@@PW@@", TS);
			}
			
			string lItems = "";
			RC = true;
			RetTxt = "";
			
			string sCompanyID = "";
			string sEncPW = "";
			string sRepoID = "";
			//Dim sCS As String = ""
			bool Disabled = System.Convert.ToBoolean(null);
			
			string S = "";
			S += " SELECT distinct CompanyID" + "\r\n";
			S += " FROM SecureAttach where EncPW = \'" + EncryptedPW + "\' " + "\r\n";
			S += " order by CompanyID" + "\r\n";
			
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection();
			SqlCommand command = new SqlCommand();
			
			try
			{
				CONN.ConnectionString = CS;
				CONN.Open();
				command.Connection = CONN;
				command.CommandText = S;
				RSData = command.ExecuteReader();
				
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						DS_Combo LI = new DS_Combo();
						sCompanyID = RSData.GetValue(0).ToString();
						lItems += sCompanyID + "|";
					}
				}
				RetTxt = lItems;
			}
			catch (Exception ex)
			{
				RC = false;
				RetTxt = ex.Message;
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return lItems;
			
		}
		
		public string PopulateRepoSecure(string CS, string CompanyID, string EncryptedPW, ref bool RC, ref string RetTxt)
		{
			
			if (CS.Length == 0)
			{
				CS = System.Configuration.ConfigurationManager.AppSettings["ECMSecureLogin"];
				string TS = XXI();
				CS = CS.Replace("@@PW@@", TS);
			}
			
			bool bGoodPW = false;
			string lItems = "";
			RC = true;
			RetTxt = "";
			
			string sCompanyID = "";
			string sEncPW = "";
			string sRepoID = "";
			//Dim sCS As String = ""
			bool Disabled = System.Convert.ToBoolean(null);
			
			string S = "";
			S += " SELECT distinct CompanyID" + "\r\n";
			S += " FROM SecureAttach where EncPW = \'" + EncryptedPW + "\' " + "\r\n";
			S += " order by CompanyID" + "\r\n";
			
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection();
			SqlCommand command = new SqlCommand();
			
			try
			{
				CONN.ConnectionString = CS;
				CONN.Open();
				command.Connection = CONN;
				command.CommandText = S;
				RSData = command.ExecuteReader();
				
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						bGoodPW = true;
					}
				}
				RetTxt = lItems;
			}
			catch (Exception ex)
			{
				bGoodPW = false;
				RC = false;
				RetTxt = ex.Message;
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
			}
			
			if (bGoodPW)
			{
				lItems = PopulateRepoCombo(CS, CompanyID, ref RC, ref RetTxt);
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return lItems;
			
		}
		
		/// <summary>
		/// Get a list of REPO ids set for a given company.
		/// </summary>
		/// <param name="Connstr">
		/// Leave this NULL in order to use the locally CONFIG defined connection string. Pass in a conn
		/// str to use any gateway.
		/// </param>
		/// <param name="CompanyID"></param>
		/// <param name="RC">       </param>
		/// <param name="RetTxt">   </param>
		/// <returns>A delimited list of repo IDs for a given company</returns>
		/// <remarks></remarks>
		public string PopulateRepoCombo(string Connstr, string CompanyID, ref bool RC, ref string RetTxt)
		{
			
			if (Connstr.Length == 0)
			{
				Connstr = System.Configuration.ConfigurationManager.AppSettings["ECMSecureLogin"];
				string TS = XXI();
				Connstr = Connstr.Replace("@@PW@@", TS);
			}
			
			string lItems = "";
			RC = true;
			RetTxt = "";
			
			string sRepoID = "";
			string sEncPW = "";
			string sCS = "";
			bool Disabled = System.Convert.ToBoolean(null);
			
			string S = "";
			S += " SELECT RepoID" + "\r\n";
			S += " FROM SecureAttach " + "\r\n";
			S += " Where CompanyID = \'" + CompanyID + "\' " + "\r\n";
			S += " order by RepoID" + "\r\n";
			
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection(Connstr);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			
			RSData = command.ExecuteReader();
			
			try
			{
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						DS_Combo LI = new DS_Combo();
						sRepoID = RSData.GetValue(0).ToString();
						lItems += sRepoID + "|";
					}
				}
			}
			catch (Exception ex)
			{
				RC = false;
				RetTxt = ex.Message;
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return lItems;
			
		}
		
		public string getSecureKey(string CompanyID, string RepoID, string LoginPassword, ref bool RC, ref string RetMsg)
		{
			string S = "";
			string SKey = "";
			
			clsEncrypt ENC = new clsEncrypt();
			
			string Connstr = "";
			Connstr = System.Configuration.ConfigurationManager.AppSettings["ECMSecureLogin"];
			string TS = XXI();
			Connstr = Connstr.Replace("@@PW@@", TS);
			
			if (Connstr.Length == 0)
			{
				RetMsg = "ERROR: Failed to retrieve connection string.";
				RC = false;
				return "";
			}
			
			S += " SELECT distinct CS" + "\r\n";
			S += " FROM SecureAttach " + "\r\n";
			S += " Where CompanyID = \'" + CompanyID + "\'" + "\r\n";
			S += " and RepoID = \'" + RepoID + "\' " + "\r\n";
			S += " and EncPW = \'" + LoginPassword + "\' " + "\r\n";
			
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection(Connstr);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			
			RSData = command.ExecuteReader();
			
			try
			{
				if (RSData.HasRows)
				{
					RSData.Read();
					DS_Combo LI = new DS_Combo();
					SKey = RSData.GetValue(0).ToString();
				}
			}
			catch (Exception ex)
			{
				RC = false;
				RetMsg = ex.Message;
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
			}
			
			ENC = null;
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return SKey;
		}
		
		public string getConnection(string CompanyID, string RepoID, ref bool RC, ref string RetMsg)
		{
			
			bool B = false;
			string MySql = "select CS from SecureAttach where CompanyID = @CompanyID and RepoID = @RepoID ";
			
			string Connstr = "";
			Connstr = System.Configuration.ConfigurationManager.AppSettings["ECMSecureLogin"];
			string TS = XXI();
			Connstr = Connstr.Replace("@@PW@@", TS);
			
			SqlDataReader RSData = null;
			SqlConnection CONN = new SqlConnection(Connstr);
			CONN.Open();
			SqlCommand command = new SqlCommand(MySql, CONN);
			string CS = "";
			
			command.Parameters.AddWithValue("@CompanyID", CompanyID);
			command.Parameters.AddWithValue("@RepoID", RepoID);
			
			RSData = command.ExecuteReader();
			int iCnt = 0;
			try
			{
				if (RSData.HasRows)
				{
					RSData.Read();
					CS = RSData.GetValue(0).ToString();
				}
				else
				{
					CS = "";
					B = false;
					iCnt = 0;
				}
			}
			catch (Exception ex)
			{
				B = false;
				RC = false;
				RetMsg = ex.Message.ToString();
			}
			finally
			{
				if (RSData.IsClosed)
				{
				}
				else
				{
					RSData.Close();
				}
				RSData = null;
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				command.Dispose();
			}
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return CS;
			
		}
		
		public bool UpdateExistingConnection(string ConnStr, Dictionary<string, string> tDict, ref bool RC, ref string RtnMsg)
		{
			
			clsEncrypt ENC = new clsEncrypt();
			
			bool B = true;
			SqlConnection CN = new SqlConnection();
			RtnMsg = "";
			RC = true;
			string RetMsg = "";
			
			string CreateDate = "";
			string LastModDate = DateTime.Now.ToString();
			string Disabled = "";
			string isThesaurus = "";
			string RowID = "";
			string RepoID = "";
			string CompanyID = "";
			string EncPW = "";
			string Cs = "";
			string CSThesaurus = "";
			string CSHive = "";
			string CSRepo = "";
			string CSDMALicense = "";
			string CSGateWay = "";
			string CSTDR = "";
			string CSKBase = "";
			
			string gSVCFS_Endpoint = "";
			string gSVCGateway_Endpoint = "";
			string gSVCCLCArchive_Endpoint = "";
			string gSVCSearch_Endpoint = "";
			string gSVCDownload_Endpoint = "";
			
			Disabled = System.Convert.ToString(tDict["Disabled"]);
			Disabled = ENC.AES256DecryptString(Disabled, ref RC, ref RetMsg);
			
			isThesaurus = System.Convert.ToString(tDict["isThesaurus"]);
			isThesaurus = ENC.AES256DecryptString(isThesaurus, ref RC, ref RetMsg);
			
			RepoID = System.Convert.ToString(tDict["RepoID"]);
			RepoID = ENC.AES256DecryptString(RepoID, ref RC, ref RetMsg);
			
			CompanyID = System.Convert.ToString(tDict["CompanyID"]);
			CompanyID = ENC.AES256DecryptString(CompanyID, ref RC, ref RetMsg);
			
			EncPW = System.Convert.ToString(tDict["EncPW"]);
			Cs = System.Convert.ToString(tDict["Cs"]);
			CSThesaurus = System.Convert.ToString(tDict["CSThesaurus"]);
			CSHive = System.Convert.ToString(tDict["CSHive"]);
			CSRepo = System.Convert.ToString(tDict["CSRepo"]);
			CSDMALicense = System.Convert.ToString(tDict["CSDMALicense"]);
			CSGateWay = System.Convert.ToString(tDict["CSGateWay"]);
			CSTDR = System.Convert.ToString(tDict["CSTDR"]);
			CSKBase = System.Convert.ToString(tDict["CSKBase"]);
			
			gSVCFS_Endpoint = System.Convert.ToString(tDict["SVCFS_Endpoint"]);
			gSVCFS_Endpoint = ENC.AES256DecryptString(gSVCFS_Endpoint, ref RC, ref RetMsg);
			
			gSVCGateway_Endpoint = System.Convert.ToString(tDict["SVCGateway_Endpoint"]);
			gSVCGateway_Endpoint = ENC.AES256DecryptString(gSVCGateway_Endpoint, ref RC, ref RetMsg);
			
			gSVCCLCArchive_Endpoint = System.Convert.ToString(tDict["SVCCLCArchive_Endpoint"]);
			gSVCCLCArchive_Endpoint = ENC.AES256DecryptString(gSVCCLCArchive_Endpoint, ref RC, ref RetMsg);
			
			gSVCSearch_Endpoint = System.Convert.ToString(tDict["SVCSearch_Endpoint"]);
			gSVCSearch_Endpoint = ENC.AES256DecryptString(gSVCSearch_Endpoint, ref RC, ref RetMsg);
			
			gSVCDownload_Endpoint = System.Convert.ToString(tDict["SVCDownload_Endpoint"]);
			gSVCDownload_Endpoint = ENC.AES256DecryptString(gSVCDownload_Endpoint, ref RC, ref RetMsg);
			
			string MySql = "Update SecureAttach " + "\r\n";
			MySql += "SET" + "\r\n";
			MySql += " EncPW = @EncPW " + "\r\n";
			MySql += ", CS = @CS " + "\r\n";
			MySql += ", Disabled = @Disabled " + "\r\n";
			MySql += ", isThesaurus = @isThesaurus " + "\r\n";
			MySql += ", CSRepo = @CSRepo " + "\r\n";
			MySql += ", CSThesaurus = @CSThesaurus " + "\r\n";
			MySql += ", CSHive = @CSHive " + "\r\n";
			MySql += ", CSDMALicense = @CSDMALicense " + "\r\n";
			MySql += ", CSGateWay = @CSGateWay " + "\r\n";
			MySql += ", CSTDR = @CSTDR " + "\r\n";
			MySql += ", CSKBase = @CSKBase " + "\r\n";
			MySql += ", LastModDate = @LastModDate " + "\r\n";
			MySql += ", SVCFS_Endpoint = @SVCFS_Endpoint " + "\r\n";
			MySql += ", SVCGateway_Endpoint = @SVCGateway_Endpoint " + "\r\n";
			MySql += ", SVCCLCArchive_Endpoint = @SVCCLCArchive_Endpoint " + "\r\n";
			MySql += ", SVCSearch_Endpoint = @SVCSearch_Endpoint " + "\r\n";
			MySql += ", SVCDownload_Endpoint = @SVCDownload_Endpoint " + "\r\n";
			MySql += "where CompanyID = @CompanyID and RepoID = @RepoID";
			
			try
			{
				B = true;
				CN.ConnectionString = ConnStr;
				CN.Open();
				
				using (CN)
				{
					using (SqlCommand command = new SqlCommand(MySql, CN))
					{
						command.CommandType = CommandType.Text;
						command.Parameters.AddWithValue("@CompanyID", CompanyID);
						command.Parameters.AddWithValue("@RepoID", RepoID);
						command.Parameters.AddWithValue("@EncPW", EncPW);
						command.Parameters.AddWithValue("@CS", Cs);
						command.Parameters.AddWithValue("@Disabled", Disabled);
						command.Parameters.AddWithValue("@isThesaurus", isThesaurus);
						
						command.Parameters.AddWithValue("@CSRepo", CSRepo);
						command.Parameters.AddWithValue("@CSThesaurus", CSThesaurus);
						command.Parameters.AddWithValue("@CSHive", CSHive);
						command.Parameters.AddWithValue("@CSDMALicense", CSDMALicense);
						command.Parameters.AddWithValue("@CSGateWay", CSGateWay);
						command.Parameters.AddWithValue("@CSTDR", CSTDR);
						command.Parameters.AddWithValue("@CSKBase", CSKBase);
						command.Parameters.AddWithValue("@LastModDate", LastModDate);
						command.Parameters.AddWithValue("@SVCFS_Endpoint", gSVCFS_Endpoint);
						command.Parameters.AddWithValue("@SVCGateway_Endpoint", gSVCGateway_Endpoint);
						command.Parameters.AddWithValue("@SVCCLCArchive_Endpoint", gSVCCLCArchive_Endpoint);
						command.Parameters.AddWithValue("@SVCSearch_Endpoint", gSVCSearch_Endpoint);
						command.Parameters.AddWithValue("@SVCDownload_Endpoint", gSVCDownload_Endpoint);
						
						command.ExecuteNonQuery();
						command.Dispose();
					}
					
				}
				
			}
			catch (Exception ex)
			{
				B = false;
				RC = false;
				RtnMsg = ex.Message.ToString();
			}
			finally
			{
				CN.Close();
				CN.Dispose();
				GC.Collect();
			}
			
			return B;
		}
		
		public bool duplicateEntry(string ConnStr, Dictionary<string, string> tDict)
		{
			
			ConnStr = System.Configuration.ConfigurationManager.AppSettings["ECMSecureLogin"];
			string TS = XXI();
			ConnStr = ConnStr.Replace("@@PW@@", TS);
			
			int I = 0;
			string ExtensionData = "";
			string CS = "";
			string CSDMALicense = "";
			string CSGateWay = "";
			string CSHive = "";
			string CSKBase = "";
			string CSRepo = "";
			string CSTDR = "";
			string CSThesaurus = "";
			string CompanyID = "";
			string CreateDate = "";
			string Disabled = "";
			string EncPW = "";
			string LastModDate = "";
			string RepoID = "";
			string RowID = "";
			string SVCCLCArchive_Endpoint = "";
			string SVCDownload_CS = "";
			string SVCDownload_Endpoint = "";
			string SVCFS_CS = "";
			string SVCFS_Endpoint = "";
			string SVCGateway_CS = "";
			string SVCGateway_Endpoint = "";
			string SVCSearch_CS = "";
			string SVCSearch_Endpoint = "";
			string SVCThesaurus_CS = "";
			string isThesaurus = "";
			
			bool B = true;
			
			string S1 = "insert into SecureAttach (" + "\r\n";
			
			
			foreach (string colname in tDict.Keys)
			{
				if (colname == "ExtensionData")
				{
					ExtensionData = System.Convert.ToString(tDict["ExtensionData"]);
				}
				if (colname == "CS")
				{
					CS = System.Convert.ToString(tDict["CS"]);
				}
				if (colname == "CSDMALicense")
				{
					CSDMALicense = System.Convert.ToString(tDict["CSDMALicense"]);
				}
				if (colname == "CSGateWay")
				{
					CSGateWay = System.Convert.ToString(tDict["CSGateWay"]);
				}
				if (colname == "CSHive")
				{
					CSHive = System.Convert.ToString(tDict["CSHive"]);
				}
				if (colname == "CSKBase")
				{
					CSKBase = System.Convert.ToString(tDict["CSKBase"]);
				}
				if (colname == "CSRepo")
				{
					CSRepo = System.Convert.ToString(tDict["CSRepo"]);
				}
				if (colname == "CSTDR")
				{
					CSTDR = System.Convert.ToString(tDict["CSTDR"]);
				}
				if (colname == "CSThesaurus")
				{
					CSThesaurus = System.Convert.ToString(tDict["CSThesaurus"]);
				}
				if (colname == "CompanyID")
				{
					CompanyID = System.Convert.ToString(tDict["CompanyID"]);
				}
				if (colname == "CreateDate")
				{
					CreateDate = DateAndTime.Today.ToString();
				}
				if (colname == "Disabled")
				{
					Disabled = System.Convert.ToString(tDict["Disabled"]);
				}
				if (colname == "EncPW")
				{
					EncPW = System.Convert.ToString(tDict["EncPW"]);
				}
				if (colname == "LastModDate")
				{
					LastModDate = DateAndTime.Today.ToString();
				}
				if (colname == "RepoID")
				{
					RepoID = System.Convert.ToString(tDict["RepoID"]);
					RepoID = RepoID + "_Copy";
				}
				if (colname == "RowID")
				{
					RowID = System.Convert.ToString(tDict["RowID"]);
				}
				if (colname == "SVCCLCArchive_Endpoint")
				{
					SVCCLCArchive_Endpoint = System.Convert.ToString(tDict["SVCCLCArchive_Endpoint"]);
				}
				if (colname == "SVCDownload_CS")
				{
					SVCDownload_CS = System.Convert.ToString(tDict["SVCDownload_CS"]);
				}
				if (colname == "SVCDownload_Endpoint")
				{
					SVCDownload_Endpoint = System.Convert.ToString(tDict["SVCDownload_Endpoint"]);
				}
				if (colname == "SVCFS_CS")
				{
					SVCFS_CS = System.Convert.ToString(tDict["SVCFS_CS"]);
				}
				if (colname == "SVCFS_Endpoint")
				{
					SVCFS_Endpoint = System.Convert.ToString(tDict["SVCFS_Endpoint"]);
				}
				if (colname == "SVCGateway_CS")
				{
					SVCGateway_CS = System.Convert.ToString(tDict["SVCGateway_CS"]);
				}
				if (colname == "SVCGateway_Endpoint")
				{
					SVCGateway_Endpoint = System.Convert.ToString(tDict["SVCGateway_Endpoint"]);
				}
				if (colname == "SVCSearch_CS")
				{
					SVCSearch_CS = System.Convert.ToString(tDict["SVCSearch_CS"]);
				}
				if (colname == "SVCSearch_Endpoint")
				{
					SVCSearch_Endpoint = System.Convert.ToString(tDict["SVCSearch_Endpoint"]);
				}
				if (colname == "SVCThesaurus_CS")
				{
					SVCThesaurus_CS = System.Convert.ToString(tDict["SVCThesaurus_CS"]);
				}
				if (colname == "isThesaurus")
				{
					isThesaurus = System.Convert.ToString(tDict["isThesaurus"]);
				}
			}
			
			string MySql = "";
			MySql = "insert into SecureAttach (";
			//MySql += "ExtensionData,"
			MySql += "CS,";
			MySql += "CSDMALicense,";
			MySql += "CSGateWay,";
			MySql += "CSHive,";
			MySql += "CSKBase,";
			MySql += "CSRepo,";
			MySql += "CSTDR,";
			MySql += "CSThesaurus,";
			MySql += "CompanyID,";
			MySql += "CreateDate,";
			MySql += "Disabled,";
			MySql += "EncPW,";
			MySql += "LastModDate,";
			MySql += "RepoID,";
			//MySql += "RowID,"
			MySql += "SVCCLCArchive_Endpoint,";
			MySql += "SVCDownload_CS,";
			MySql += "SVCDownload_Endpoint,";
			MySql += "SVCFS_CS,";
			MySql += "SVCFS_Endpoint,";
			MySql += "SVCGateway_CS,";
			MySql += "SVCGateway_Endpoint,";
			MySql += "SVCSearch_CS,";
			MySql += "SVCSearch_Endpoint,";
			MySql += "SVCThesaurus_CS,";
			MySql += "isThesaurus";
			MySql += ")" + "\r\n";
			MySql += " values (";
			//MySql += "@ExtensionData,"
			MySql += "@CS,";
			MySql += "@CSDMALicense,";
			MySql += "@CSGateWay,";
			MySql += "@CSHive,";
			MySql += "@CSKBase,";
			MySql += "@CSRepo,";
			MySql += "@CSTDR,";
			MySql += "@CSThesaurus,";
			MySql += "@CompanyID,";
			MySql += "@CreateDate,";
			MySql += "@Disabled,";
			MySql += "@EncPW,";
			MySql += "@LastModDate,";
			MySql += "@RepoID,";
			//MySql += "@RowID,"
			MySql += "@SVCCLCArchive_Endpoint,";
			MySql += "@SVCDownload_CS,";
			MySql += "@SVCDownload_Endpoint,";
			MySql += "@SVCFS_CS,";
			MySql += "@SVCFS_Endpoint,";
			MySql += "@SVCGateway_CS,";
			MySql += "@SVCGateway_Endpoint,";
			MySql += "@SVCSearch_CS,";
			MySql += "@SVCSearch_Endpoint,";
			MySql += "@SVCThesaurus_CS,";
			MySql += "@isThesaurus";
			MySql += ")";
			
			SqlConnection NewCN = new SqlConnection(ConnStr);
			NewCN.Open();
			SqlCommand command = new SqlCommand(MySql, NewCN);
			
			try
			{
				using (NewCN)
				{
					using (command)
					{
						command.CommandType = CommandType.Text;
						
						//command.Parameters.AddWithValue("@ExtensionData", ExtensionData)
						command.Parameters.AddWithValue("@CS", CS);
						command.Parameters.AddWithValue("@CSDMALicense", CSDMALicense);
						command.Parameters.AddWithValue("@CSGateWay", CSGateWay);
						command.Parameters.AddWithValue("@CSHive", CSHive);
						command.Parameters.AddWithValue("@CSKBase", CSKBase);
						command.Parameters.AddWithValue("@CSRepo", CSRepo);
						command.Parameters.AddWithValue("@CSTDR", CSTDR);
						command.Parameters.AddWithValue("@CSThesaurus", CSThesaurus);
						command.Parameters.AddWithValue("@CompanyID", CompanyID);
						command.Parameters.AddWithValue("@CreateDate", CreateDate);
						command.Parameters.AddWithValue("@Disabled", Disabled);
						command.Parameters.AddWithValue("@EncPW", EncPW);
						command.Parameters.AddWithValue("@LastModDate", LastModDate);
						command.Parameters.AddWithValue("@RepoID", RepoID);
						//command.Parameters.AddWithValue("@RowID", RowID)
						command.Parameters.AddWithValue("@SVCCLCArchive_Endpoint", SVCCLCArchive_Endpoint);
						command.Parameters.AddWithValue("@SVCDownload_CS", SVCDownload_CS);
						command.Parameters.AddWithValue("@SVCDownload_Endpoint", SVCDownload_Endpoint);
						command.Parameters.AddWithValue("@SVCFS_CS", SVCFS_CS);
						command.Parameters.AddWithValue("@SVCFS_Endpoint", SVCFS_Endpoint);
						command.Parameters.AddWithValue("@SVCGateway_CS", SVCGateway_CS);
						command.Parameters.AddWithValue("@SVCGateway_Endpoint", SVCGateway_Endpoint);
						command.Parameters.AddWithValue("@SVCSearch_CS", SVCSearch_CS);
						command.Parameters.AddWithValue("@SVCSearch_Endpoint", SVCSearch_Endpoint);
						command.Parameters.AddWithValue("@SVCThesaurus_CS", SVCThesaurus_CS);
						command.Parameters.AddWithValue("@isThesaurus", isThesaurus);
						
						command.ExecuteNonQuery();
						//command.Dispose()
					}
					
				}
				
			}
			catch (Exception)
			{
				B = false;
			}
			finally
			{
				if (NewCN.State == ConnectionState.Open)
				{
					NewCN.Close();
					NewCN.Dispose();
				}
				GC.Collect();
			}
			
			return B;
		}
		
	}
}

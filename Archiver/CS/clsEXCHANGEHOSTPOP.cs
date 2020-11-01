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

using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Data.Sql;


namespace EcmArchiveClcSetup
{
	public class clsEXCHANGEHOSTPOP
	{
		public clsEXCHANGEHOSTPOP()
		{
			// VBConversions Note: Non-static class variable initialization is below.  Class variables cannot be initially assigned non-static values in C#.
			ConnStr = DB.getGateWayConnStr(-1);
			
		}
		
		//** DIM the selected table columns
		
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		clsDataGrid DG = new clsDataGrid();
		
		string HostNameIp = "";
		string UserLoginID = "";
		string LoginPw = "";
		string SSL = "";
		string PortNbr = "";
		string DeleteAfterDownload = "";
		string RetentionCode = "";
		string IMap = "";
		string Userid = "";
		string FolderName = "";
		string LibraryName = "";
		bool isPublic = false;
		int DaysToHold = 0;
		string strReject = "";
		bool ckConvertEmlToMsg = false;
		
		string ConnStr; // VBConversions Note: Initial value of "DB.getGateWayConnStr(-1)" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		
		//** Generate the SET methods
		public void setConvertEmlToMsg(bool val)
		{
			ckConvertEmlToMsg = val;
		}
		public void setReject(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			strReject = val;
		}
		public void setDaysToHold(int val)
		{
			DaysToHold = val;
		}
		public void setLibrary(bool val)
		{
			isPublic = val;
		}
		public void setLibrary(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			LibraryName = val;
		}
		public void setFolderName(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			FolderName = val;
		}
		
		public void setHostnameip(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Hostnameip\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			HostNameIp = val;
		}
		
		public void setUserloginid(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Userloginid\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			UserLoginID = val;
		}
		
		public void setLoginpw(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Loginpw\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			LoginPw = val;
		}
		
		public void setSsl(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = UTIL.RemoveSingleQuotes(val);
			SSL = val;
		}
		
		public void setPortnbr(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = UTIL.RemoveSingleQuotes(val);
			PortNbr = val;
		}
		
		public void setDeleteafterdownload(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = UTIL.RemoveSingleQuotes(val);
			DeleteAfterDownload = val;
		}
		
		public void setRetentioncode(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			RetentionCode = val;
		}
		
		public void setImap(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = UTIL.RemoveSingleQuotes(val);
			IMap = val;
		}
		
		public void setUserid(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Userid = val;
		}
		
		
		
		//** Generate the GET methods
		public string getFolderName()
		{
			return UTIL.RemoveSingleQuotes(FolderName);
		}
		public string getHostnameip()
		{
			if (HostNameIp.Length == 0)
			{
				MessageBox.Show("GET: Field \'Hostnameip\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(HostNameIp);
		}
		
		public string getUserloginid()
		{
			if (UserLoginID.Length == 0)
			{
				MessageBox.Show("GET: Field \'Userloginid\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(UserLoginID);
		}
		
		public string getLoginpw()
		{
			if (LoginPw.Length == 0)
			{
				MessageBox.Show("GET: Field \'Loginpw\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(LoginPw);
		}
		
		public string getSsl()
		{
			if (SSL.Length == 0)
			{
				SSL = "null";
			}
			return SSL;
		}
		
		public string getPortnbr()
		{
			if (PortNbr.Length == 0)
			{
				PortNbr = "null";
			}
			return PortNbr;
		}
		
		public string getDeleteafterdownload()
		{
			if (DeleteAfterDownload.Length == 0)
			{
				DeleteAfterDownload = "null";
			}
			return DeleteAfterDownload;
		}
		
		public string getRetentioncode()
		{
			return UTIL.RemoveSingleQuotes(RetentionCode);
		}
		
		public string getImap()
		{
			if (IMap.Length == 0)
			{
				IMap = "null";
			}
			return IMap;
		}
		
		public string getUserid()
		{
			return UTIL.RemoveSingleQuotes(Userid);
		}
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (HostNameIp.Length == 0)
			{
				return false;
			}
			if (UserLoginID.Length == 0)
			{
				return false;
			}
			if (LoginPw.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			if (HostNameIp.Length == 0)
			{
				return false;
			}
			if (UserLoginID.Length == 0)
			{
				return false;
			}
			if (LoginPw.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		//** Generate the INSERT method
		public bool Insert()
		{
			bool b = false;
			string s = "";
			s = s + " INSERT INTO ExchangeHostPop(";
			s = s + "HostNameIp,";
			s = s + "UserLoginID,";
			s = s + "LoginPw,";
			s = s + "SSL,";
			s = s + "PortNbr,";
			s = s + "DeleteAfterDownload,";
			s = s + "RetentionCode,";
			s = s + "IMap,";
			s = s + "Userid, FolderName, LibraryName, isPublic, DaysToHold, strReject, ConvertEmlToMSG) values (";
			s = s + "\'" + HostNameIp + "\'" + ",";
			s = s + "\'" + UserLoginID + "\'" + ",";
			s = s + "\'" + LoginPw + "\'" + ",";
			s = s + SSL + ",";
			s = s + PortNbr + ",";
			s = s + DeleteAfterDownload + ",";
			s = s + "\'" + RetentionCode + "\'" + ",";
			s = s + IMap + ",";
			s = s + "\'" + Userid + "\'" + ",";
			s = s + "\'" + FolderName + "\'" + ",";
			s = s + "\'" + LibraryName + "\'" + ",";
			if (isPublic == true)
			{
				s = s + "1,";
			}
			else
			{
				s = s + "0,";
			}
			s = s + DaysToHold.ToString() + ", ";
			s = s + "\'" + strReject + "\', ";
			if (ckConvertEmlToMsg == true)
			{
				s = s + "1) ";
			}
			else
			{
				s = s + "0) ";
			}
			//log.WriteToArchiveLog("INFO: " + vbCrLf + s)
			return DB.ExecuteSql(s, ConnStr, false);
			
		}
		
		
		//** Generate the UPDATE method
		public bool Update(string Host, string UserID, string UserLogin)
		{
			bool b = false;
			string s = "";
			
			s = s + " update ExchangeHostPop set ";
			//s = s + "HostNameIp = '" + getHostnameip() + "'" + ", "
			//s = s + "UserLoginID = '" + getUserloginid() + "'" + ", "
			s = s + "LoginPw = \'" + getLoginpw() + "\'" + ", ";
			s = s + "SSL = " + getSsl() + ", ";
			s = s + "PortNbr = " + getPortnbr() + ", ";
			s = s + "DeleteAfterDownload = " + getDeleteafterdownload() + ", ";
			s = s + "RetentionCode = \'" + getRetentioncode() + "\'" + ", ";
			s = s + "IMap = " + getImap() + ", ";
			s = s + "FolderName = \'" + this.getFolderName() + "\', ";
			s = s + "LibraryName = \'" + LibraryName + "\', ";
			if (isPublic == true)
			{
				s = s + "isPublic = 1, ";
			}
			else
			{
				s = s + "isPublic = 0, ";
			}
			s = s + "DaysToHold = " + DaysToHold.ToString() + ", ";
			s = s + "strReject = \'" + strReject + "\', ";
			
			if (ckConvertEmlToMsg == true)
			{
				s = s + "ConvertEmlToMSG = 1 ";
			}
			else
			{
				s = s + "ConvertEmlToMSG = 0 ";
			}
			
			s = s + " Where ";
			s = s + " HostNameIp = \'" + Host + "\' ";
			s = s + " and   Userid = \'" + UserID + "\'";
			s = s + " and [UserLoginID] = \'" + UserLogin + "\'";
			
			return DB.ExecuteSql(s, ConnStr, false);
		}
		
		
		//** Generate the SELECT method
		public SqlDataReader SelectRecs()
		{
			bool b = false;
			string s = "";
			SqlDataReader rsData;
			s = s + " SELECT ";
			s = s + "HostNameIp,";
			s = s + "UserLoginID,";
			s = s + "LoginPw,";
			s = s + "SSL,";
			s = s + "PortNbr,";
			s = s + "DeleteAfterDownload,";
			s = s + "RetentionCode,";
			s = s + "IMap,";
			s = s + "Userid ";
			s = s + " FROM ExchangeHostPop";
			//** s=s+ "ORDERBY xxxx"
			string CS = DB.getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			return rsData;
		}
		
		
		//** Generate the Select One Row method
		public SqlDataReader SelectOne(string WhereClause)
		{
			bool b = false;
			string s = "";
			SqlDataReader rsData;
			s = s + " SELECT ";
			s = s + "HostNameIp,";
			s = s + "UserLoginID,";
			s = s + "LoginPw,";
			s = s + "SSL,";
			s = s + "PortNbr,";
			s = s + "DeleteAfterDownload,";
			s = s + "RetentionCode,";
			s = s + "IMap,";
			s = s + "Userid ";
			s = s + " FROM ExchangeHostPop";
			s = s + WhereClause;
			//** s=s+ "ORDERBY xxxx"
			string CS = DB.getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			return rsData;
		}
		
		
		//** Generate the DELETE method
		public bool Delete(string WhereClause)
		{
			bool b = false;
			string s = "";
			
			if (WhereClause.Length == 0)
			{
				return false;
			}
			
			WhereClause = (string) (" " + WhereClause);
			
			s = " Delete from ExchangeHostPop";
			s = s + WhereClause;
			
			b = DB.ExecuteSql(s, ConnStr, false);
			return b;
			
		}
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			s = s + " Delete from ExchangeHostPop";
			
			b = DB.ExecuteSql(s, ConnStr, false);
			return b;
			
		}
		
		
		//** Generate Index Queries
		public int cnt_PK_ExchangeHostPop(string HostNameIp, string Userid, string UserLoginID)
		{
			
			int B = 0;
			string TBL = "ExchangeHostPop";
			string WC = "Where HostNameIp = \'" + HostNameIp + "\' and   Userid = \'" + Userid + "\' and   UserLoginID = \'" + UserLoginID + "\'";
			
			B = DB.iGetRowCount(TBL, WC);
			
			return B;
		} //** cnt_PK_ExchangeHostPop
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PK_ExchangeHostPop(string HostNameIp, string Userid, string UserLoginID)
		{
			
			SqlDataReader rsData = null;
			string TBL = "ExchangeHostPop";
			string WC = "Where HostNameIp = \'" + HostNameIp + "\' and   Userid = \'" + Userid + "\' and   UserLoginID = \'" + UserLoginID + "\'";
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PK_ExchangeHostPop
		
		/// Build Index Where Caluses
		///
		public string wc_PK_ExchangeHostPop(string HostNameIp, string Userid, string UserLoginID)
		{
			
			string WC = "Where HostNameIp = \'" + HostNameIp + "\' and   Userid = \'" + Userid + "\' and   UserLoginID = \'" + UserLoginID + "\'";
			
			return WC;
		} //** wc_PK_ExchangeHostPop
		
		//** Generate the SET methods
		
	}
	
}

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
	public class clsEXCHANGEHOSTSMTP
	{
		public clsEXCHANGEHOSTSMTP()
		{
			// VBConversions Note: Non-static class variable initialization is below.  Class variables cannot be initially assigned non-static values in C#.
			ConnStr = DB.getGateWayConnStr(-1);
			
		}
		
		//** DIM the selected table columns
		
		string ConnStr; // VBConversions Note: Initial value of "DB.getGateWayConnStr(-1)" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		
		clsLogging LOG = new clsLogging();
		clsUtility UTIL = new clsUtility();
		
		clsDataGrid DG = new clsDataGrid();
		
		string HostNameIp = "";
		string UserLoginID = "";
		string LoginPw = "";
		string DisplayName = "";
		
		
		//** Generate the SET methods
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
		
		public void setDisplayname(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Displayname\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			DisplayName = val;
		}
		
		
		
		//** Generate the GET methods
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
		
		public string getDisplayname()
		{
			if (DisplayName.Length == 0)
			{
				MessageBox.Show("GET: Field \'Displayname\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(DisplayName);
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
			if (DisplayName.Length == 0)
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
			if (DisplayName.Length == 0)
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
			s = s + " INSERT INTO ExchangeHostSmtp(";
			s = s + "HostNameIp,";
			s = s + "UserLoginID,";
			s = s + "LoginPw,";
			s = s + "DisplayName) values (";
			s = s + "\'" + HostNameIp + "\'" + ",";
			s = s + "\'" + UserLoginID + "\'" + ",";
			s = s + "\'" + LoginPw + "\'" + ",";
			s = s + "\'" + DisplayName + "\'" + ")";
			return DB.ExecuteSql(s, ConnStr, false);
			
		}
		
		
		//** Generate the UPDATE method
		public bool Update(string WhereClause)
		{
			bool b = false;
			string s = "";
			
			if (WhereClause.Length == 0)
			{
				return false;
			}
			
			s = s + " update ExchangeHostSmtp set ";
			s = s + "HostNameIp = \'" + getHostnameip() + "\'" + ", ";
			s = s + "UserLoginID = \'" + getUserloginid() + "\'" + ", ";
			s = s + "LoginPw = \'" + getLoginpw() + "\'" + ", ";
			s = s + "DisplayName = \'" + getDisplayname() + "\'";
			WhereClause = (string) (" " + WhereClause);
			s = s + WhereClause;
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
			s = s + "DisplayName ";
			s = s + " FROM ExchangeHostSmtp";
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
			s = s + "DisplayName ";
			s = s + " FROM ExchangeHostSmtp";
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
			
			s = " Delete from ExchangeHostSmtp";
			s = s + WhereClause;
			
			b = DB.ExecuteSql(s, ConnStr, false);
			return b;
			
		}
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			s = s + " Delete from ExchangeHostSmtp";
			
			b = DB.ExecuteSql(s, ConnStr, false);
			return b;
			
		}
		
		
		//** Generate Index Queries
		public int cnt_PK_ExchangeHostSmtp(string HostNameIp, string UserLoginID)
		{
			
			int B = 0;
			string TBL = "ExchangeHostSmtp";
			string WC = "Where HostNameIp = \'" + HostNameIp + "\' and   UserLoginID = \'" + UserLoginID + "\'";
			
			B = DB.iGetRowCount(TBL, WC);
			
			return B;
		} //** cnt_PK_ExchangeHostSmtp
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PK_ExchangeHostSmtp(string HostNameIp, string UserLoginID)
		{
			
			SqlDataReader rsData = null;
			string TBL = "ExchangeHostSmtp";
			string WC = "Where HostNameIp = \'" + HostNameIp + "\' and   UserLoginID = \'" + UserLoginID + "\'";
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PK_ExchangeHostSmtp
		
		/// Build Index Where Caluses
		///
		public string wc_PK_ExchangeHostSmtp(string HostNameIp, string UserLoginID)
		{
			
			string WC = "Where HostNameIp = \'" + HostNameIp + "\' and   UserLoginID = \'" + UserLoginID + "\'";
			
			return WC;
		} //** wc_PK_ExchangeHostSmtp
		
		//** Generate the SET methods
		
	}
	
}

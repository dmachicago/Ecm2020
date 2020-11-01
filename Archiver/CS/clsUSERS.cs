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
	public class clsUSERS
	{
		
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		
		
		string UserID = "";
		string UserName = "";
		string EmailAddress = "";
		string UserPassword = "";
		string Admin = "";
		string isActive = "";
		string UserLoginID = "";
		
		
		
		
		//** Generate the SET methods
		public void setUserid(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Userid\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			UserID = val;
		}
		
		
		public void setUsername(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Username\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			UserName = val;
		}
		
		
		public void setEmailaddress(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			EmailAddress = val;
		}
		
		
		public void setUserpassword(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			UserPassword = val;
		}
		
		
		public void setAdmin(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Admin = val;
		}
		
		
		public void setIsactive(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			isActive = val;
		}
		
		
		public void setUserloginid(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			UserLoginID = val;
		}
		
		
		
		
		
		
		//** Generate the GET methods
		public string getUserid()
		{
			if (UserID.Length == 0)
			{
				MessageBox.Show("GET: Field \'Userid\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(UserID);
		}
		
		
		public string getUsername()
		{
			if (UserName.Length == 0)
			{
				MessageBox.Show("GET: Field \'Username\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(UserName);
		}
		
		
		public string getEmailaddress()
		{
			return UTIL.RemoveSingleQuotes(EmailAddress);
		}
		
		
		public string getUserpassword()
		{
			return UTIL.RemoveSingleQuotes(UserPassword);
		}
		
		
		public string getAdmin()
		{
			return UTIL.RemoveSingleQuotes(Admin);
		}
		
		
		public string getIsactive()
		{
			return UTIL.RemoveSingleQuotes(isActive);
		}
		
		
		public string getUserloginid()
		{
			return UTIL.RemoveSingleQuotes(UserLoginID);
		}
		
		
		
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (UserID.Length == 0)
			{
				return false;
			}
			if (UserName.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			if (UserID.Length == 0)
			{
				return false;
			}
			if (UserName.Length == 0)
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
			s = s + " INSERT INTO Users(";
			s = s + "UserID,";
			s = s + "UserName,";
			s = s + "EmailAddress,";
			s = s + "UserPassword,";
			s = s + "Admin,";
			s = s + "isActive,";
			s = s + "UserLoginID) values (";
			s = s + "\'" + UserID + "\'" + ",";
			s = s + "\'" + UserName + "\'" + ",";
			s = s + "\'" + EmailAddress + "\'" + ",";
			s = s + "\'" + UserPassword + "\'" + ",";
			s = s + "\'" + Admin + "\'" + ",";
			s = s + "\'" + isActive + "\'" + ",";
			s = s + "\'" + UserLoginID + "\'" + ")";
			return DB.ExecuteSqlNewConn(s, false);
			
			
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
			
			
			s = s + " update Users set ";
			s = s + "UserID = \'" + getUserid() + "\'" + ", ";
			s = s + "UserName = \'" + getUsername() + "\'" + ", ";
			s = s + "EmailAddress = \'" + getEmailaddress() + "\'" + ", ";
			s = s + "UserPassword = \'" + getUserpassword() + "\'" + ", ";
			s = s + "Admin = \'" + getAdmin() + "\'" + ", ";
			s = s + "isActive = \'" + getIsactive() + "\'" + ", ";
			s = s + "UserLoginID = \'" + getUserloginid() + "\'";
			WhereClause = (string) (" " + WhereClause);
			s = s + WhereClause;
			return DB.ExecuteSqlNewConn(s, false);
		}
		
		
		
		
		//** Generate the SELECT method
		public SqlDataReader SelectRecs()
		{
			bool b = false;
			string s = "";
			SqlDataReader rsData;
			s = s + " SELECT ";
			s = s + "UserID,";
			s = s + "UserName,";
			s = s + "EmailAddress,";
			s = s + "UserPassword,";
			s = s + "Admin,";
			s = s + "isActive,";
			s = s + "UserLoginID ";
			s = s + " FROM Users";
			
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
			s = s + "UserID,";
			s = s + "UserName,";
			s = s + "EmailAddress,";
			s = s + "UserPassword,";
			s = s + "Admin,";
			s = s + "isActive,";
			s = s + "UserLoginID ";
			s = s + " FROM Users";
			s = s + WhereClause;
			
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
			
			
			s = " Delete from Users";
			s = s + WhereClause;
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			
			s = s + " Delete from Users";
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate Index Queries
		public int cnt_PK41(string UserID)
		{
			
			
			int B = 0;
			string TBL = "Users";
			string WC = "Where UserID = \'" + UserID + "\'";
			
			
			B = DB.iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_PK41
		public int cnt_UK_LoginID(string UserLoginID)
		{
			
			
			int B = 0;
			string TBL = "Users";
			string WC = "Where UserLoginID = \'" + UserLoginID + "\'";
			
			
			B = DB.iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_UK_LoginID
		
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PK41(string UserID)
		{
			
			
			SqlDataReader rsData = null;
			string TBL = "Users";
			string WC = "Where UserID = \'" + UserID + "\'";
			
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PK41
		public SqlDataReader getRow_UK_LoginID(string UserLoginID)
		{
			
			
			SqlDataReader rsData = null;
			string TBL = "Users";
			string WC = "Where UserLoginID = \'" + UserLoginID + "\'";
			
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_UK_LoginID
		
		
		/// Build Index Where Caluses
		///
		public string wc_PK41(string UserID)
		{
			
			
			string WC = "Where UserID = \'" + UserID + "\'";
			
			
			return WC;
		} //** wc_PK41
		public string wc_UK_LoginID(string UserLoginID)
		{
			
			
			string WC = "Where UserLoginID = \'" + UserLoginID + "\'";
			
			
			return WC;
		} //** wc_UK_LoginID
		
		
		//** Generate the SET methods
		
		
	}
	
}

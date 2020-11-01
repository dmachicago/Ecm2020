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
	public class clsEXCLUDEFROM
	{
		
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		
		
		string FromEmailAddr = "";
		string SenderName = "";
		string UserID = "";
		
		
		
		
		//** Generate the SET methods
		public void setFromemailaddr(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Fromemailaddr\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			FromEmailAddr = val;
		}
		
		
		public void setSendername(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Sendername\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			SenderName = val;
		}
		
		
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
		
		
		
		
		
		
		//** Generate the GET methods
		public string getFromemailaddr()
		{
			if (FromEmailAddr.Length == 0)
			{
				MessageBox.Show("GET: Field \'Fromemailaddr\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(FromEmailAddr);
		}
		
		
		public string getSendername()
		{
			if (SenderName.Length == 0)
			{
				MessageBox.Show("GET: Field \'Sendername\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(SenderName);
		}
		
		
		public string getUserid()
		{
			if (UserID.Length == 0)
			{
				MessageBox.Show("GET: Field \'Userid\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(UserID);
		}
		
		
		
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (FromEmailAddr.Length == 0)
			{
				return false;
			}
			if (SenderName.Length == 0)
			{
				return false;
			}
			if (UserID.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			if (FromEmailAddr.Length == 0)
			{
				return false;
			}
			if (SenderName.Length == 0)
			{
				return false;
			}
			if (UserID.Length == 0)
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
			s = s + " INSERT INTO ExcludeFrom(";
			s = s + "FromEmailAddr,";
			s = s + "SenderName,";
			s = s + "UserID) values (";
			s = s + "\'" + FromEmailAddr + "\'" + ",";
			s = s + "\'" + SenderName + "\'" + ",";
			s = s + "\'" + UserID + "\'" + ")";
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
			
			
			s = s + " update ExcludeFrom set ";
			s = s + "FromEmailAddr = \'" + getFromemailaddr() + "\'" + ", ";
			s = s + "SenderName = \'" + getSendername() + "\'" + ", ";
			s = s + "UserID = \'" + getUserid() + "\'";
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
			s = s + "FromEmailAddr,";
			s = s + "SenderName,";
			s = s + "UserID ";
			s = s + " FROM ExcludeFrom";
			
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
			s = s + "FromEmailAddr,";
			s = s + "SenderName,";
			s = s + "UserID ";
			s = s + " FROM ExcludeFrom";
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
			
			
			s = " Delete from ExcludeFrom";
			s = s + WhereClause;
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			
			s = s + " Delete from ExcludeFrom";
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate Index Queries
		public int cnt_Pi01_ExcludeFrom(string FromEmailAddr, string UserID)
		{
			
			
			int B = 0;
			string TBL = "ExcludeFrom";
			string WC = "Where FromEmailAddr = \'" + FromEmailAddr + "\' and   UserID = \'" + UserID + "\'";
			
			
			B = DB.iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_Pi01_ExcludeFrom
		public int cnt_PK_ExcludeFrom(string FromEmailAddr, string SenderName, string UserID)
		{
			
			
			int B = 0;
			string TBL = "ExcludeFrom";
			string WC = "Where FromEmailAddr = \'" + FromEmailAddr + "\' and   SenderName = \'" + SenderName + "\' and   UserID = \'" + UserID + "\'";
			
			
			B = DB.iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_PK_ExcludeFrom
		
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_Pi01_ExcludeFrom(string FromEmailAddr, string UserID)
		{
			
			
			SqlDataReader rsData = null;
			string TBL = "ExcludeFrom";
			string WC = "Where FromEmailAddr = \'" + FromEmailAddr + "\' and   UserID = \'" + UserID + "\'";
			
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_Pi01_ExcludeFrom
		public SqlDataReader getRow_PK_ExcludeFrom(string FromEmailAddr, string SenderName, string UserID)
		{
			
			
			SqlDataReader rsData = null;
			string TBL = "ExcludeFrom";
			string WC = "Where FromEmailAddr = \'" + FromEmailAddr + "\' and   SenderName = \'" + SenderName + "\' and   UserID = \'" + UserID + "\'";
			
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PK_ExcludeFrom
		
		
		/// Build Index Where Caluses
		///
		public string wc_Pi01_ExcludeFrom(string FromEmailAddr, string UserID)
		{
			
			
			string WC = "Where FromEmailAddr = \'" + FromEmailAddr + "\' and   UserID = \'" + UserID + "\'";
			
			
			return WC;
		} //** wc_Pi01_ExcludeFrom
		public string wc_PK_ExcludeFrom(string FromEmailAddr, string SenderName, string UserID)
		{
			
			
			string WC = "Where FromEmailAddr = \'" + FromEmailAddr + "\' and   SenderName = \'" + SenderName + "\' and   UserID = \'" + UserID + "\'";
			
			
			return WC;
		} //** wc_PK_ExcludeFrom
	}
	
}

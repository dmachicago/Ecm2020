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
	public class clsEMAILTODELETE
	{
		
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		string EmailGuid = "";
		string StoreID = "";
		string UserID = "";
		string MessageID = "";
		
		
		
		
		//** Generate the SET methods
		public void setEmailguid(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Emailguid\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			EmailGuid = val;
		}
		
		
		public void setStoreid(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Storeid\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			StoreID = val;
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
		
		
		public void setMessageid(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			MessageID = val;
		}
		
		
		
		
		
		
		//** Generate the GET methods
		public string getEmailguid()
		{
			if (EmailGuid.Length == 0)
			{
				MessageBox.Show("GET: Field \'Emailguid\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(EmailGuid);
		}
		
		
		public string getStoreid()
		{
			if (StoreID.Length == 0)
			{
				MessageBox.Show("GET: Field \'Storeid\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(StoreID);
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
		
		
		public string getMessageid()
		{
			return UTIL.RemoveSingleQuotes(MessageID);
		}
		
		
		
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (EmailGuid.Length == 0)
			{
				return false;
			}
			if (StoreID.Length == 0)
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
			if (EmailGuid.Length == 0)
			{
				return false;
			}
			if (StoreID.Length == 0)
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
			s = s + " INSERT INTO EmailToDelete(";
			s = s + "EmailGuid,";
			s = s + "StoreID,";
			s = s + "UserID,";
			s = s + "MessageID) values (";
			s = s + "\'" + EmailGuid + "\'" + ",";
			s = s + "\'" + StoreID + "\'" + ",";
			s = s + "\'" + UserID + "\'" + ",";
			s = s + "\'" + MessageID + "\'" + ")";
			
			//log.WriteToArchiveLog("clsEMAILTODELETE: Insert : Marked for delete email '" + EmailGuid + "'")
			
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
			
			
			s = s + " update EmailToDelete set ";
			s = s + "EmailGuid = \'" + getEmailguid() + "\'" + ", ";
			s = s + "StoreID = \'" + getStoreid() + "\'" + ", ";
			s = s + "UserID = \'" + getUserid() + "\'" + ", ";
			s = s + "MessageID = \'" + getMessageid() + "\'";
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
			s = s + "EmailGuid,";
			s = s + "StoreID,";
			s = s + "UserID,";
			s = s + "MessageID ";
			s = s + " FROM EmailToDelete";
			
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
			s = s + "EmailGuid,";
			s = s + "StoreID,";
			s = s + "UserID,";
			s = s + "MessageID ";
			s = s + " FROM EmailToDelete";
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
			
			
			s = " Delete from EmailToDelete";
			s = s + WhereClause;
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			
			s = s + " Delete from EmailToDelete";
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate Index Queries
		
		
		//** Generate Index ROW Queries
		
		
		/// Build Index Where Caluses
		///
	}
	
}

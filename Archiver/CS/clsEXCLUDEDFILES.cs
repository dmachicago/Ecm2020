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
	public class clsEXCLUDEDFILES
	{
		
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		
		string UserID = "";
		string ExtCode = "";
		string FQN = "";
		
		
		
		
		//** Generate the SET methods
		public void setUserid(string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Userid\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			UserID = val;
		}
		
		
		public void setExtcode(string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Extcode\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			ExtCode = val;
		}
		
		
		public void setFqn(string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Fqn\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			FQN = val;
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
		
		
		public string getExtcode()
		{
			if (ExtCode.Length == 0)
			{
				MessageBox.Show("GET: Field \'Extcode\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(ExtCode);
		}
		
		
		public string getFqn()
		{
			if (FQN.Length == 0)
			{
				MessageBox.Show("GET: Field \'Fqn\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(FQN);
		}
		
		
		
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (UserID.Length == 0)
			{
				return false;
			}
			if (ExtCode.Length == 0)
			{
				return false;
			}
			if (FQN.Length == 0)
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
			if (ExtCode.Length == 0)
			{
				return false;
			}
			if (FQN.Length == 0)
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
			s = s + " INSERT INTO ExcludedFiles(";
			s = s + "UserID,";
			s = s + "ExtCode,";
			s = s + "FQN) values (";
			s = s + "\'" + UserID + "\'" + ",";
			s = s + "\'" + ExtCode + "\'" + ",";
			s = s + "\'" + FQN + "\'" + ")";
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
			
			
			s = s + " update ExcludedFiles set ";
			s = s + "UserID = \'" + getUserid() + "\'" + ", ";
			s = s + "ExtCode = \'" + getExtcode() + "\'" + ", ";
			s = s + "FQN = \'" + getFqn() + "\'";
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
			s = s + "ExtCode,";
			s = s + "FQN ";
			s = s + " FROM ExcludedFiles";
			
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
			s = s + "ExtCode,";
			s = s + "FQN ";
			s = s + " FROM ExcludedFiles";
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
			
			
			s = " Delete from ExcludedFiles";
			s = s + WhereClause;
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize(string WhereClause)
		{
			bool b = false;
			string s = "";
			
			
			s = s + " Delete from ExcludedFiles";
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		public bool DeleteExisting(string UID, string FQN)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			bool b = false;
			string s = "";
			s = s + " delete from ExcludedFiles ";
			s = s + " where [UserID] = \'" + UID + "\'  and [FQN] = \'" + FQN + "\' ";
			return DB.ExecuteSqlNewConn(s, false);
			
			
		}
		public bool DeleteExisting(string UID, string FQN, string ExtCode)
		{
			
			
			FQN = UTIL.RemoveSingleQuotes(FQN);
			bool b = false;
			string s = "";
			s = s + " delete FROM [ExcludedFiles]";
			s = s + " where [UserID] = \'" + UID + "\'";
			s = s + " and  [ExtCode] = \'" + ExtCode + "\'";
			s = s + " and [FQN] = \'" + FQN + "\'";
			
			
			return DB.ExecuteSqlNewConn(s, false);
			
			
		}
		
		
	}
	
}

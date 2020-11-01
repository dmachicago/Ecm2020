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
	public class clsAVAILFILETYPES
	{
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		
		string ExtCode = "";
		
		
		//** Generate the SET methods
		public void setExtcode(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Extcode\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			ExtCode = val;
		}
		
		
		
		//** Generate the GET methods
		public string getExtcode()
		{
			if (ExtCode.Length == 0)
			{
				MessageBox.Show("GET: Field \'Extcode\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(ExtCode);
		}
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (ExtCode.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			if (ExtCode.Length == 0)
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
			s = s + " INSERT INTO AvailFileTypes(";
			s = s + "ExtCode) values (";
			s = s + "\'" + ExtCode + "\'" + ")";
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
			
			s = s + " update AvailFileTypes set ";
			s = s + "ExtCode = \'" + getExtcode() + "\'";
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
			s = s + "ExtCode ";
			s = s + " FROM AvailFileTypes";
			
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
			s = s + "ExtCode ";
			s = s + " FROM AvailFileTypes";
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
			
			s = " Delete from AvailFileTypes";
			s = s + WhereClause;
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			s = s + " Delete from AvailFileTypes";
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate Index Queries
		public int cnt_PKI7(string ExtCode)
		{
			
			int B = 0;
			string TBL = "AvailFileTypes";
			string WC = "Where ExtCode = \'" + ExtCode + "\'";
			
			B = DB.iGetRowCount(TBL, WC);
			
			return B;
		} //** cnt_PKI7
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PKI7(string ExtCode)
		{
			
			SqlDataReader rsData = null;
			string TBL = "AvailFileTypes";
			string WC = "Where ExtCode = \'" + ExtCode + "\'";
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PKI7
		
		/// Build Index Where Caluses
		///
		public string wc_PKI7(string ExtCode)
		{
			
			string WC = "Where ExtCode = \'" + ExtCode + "\'";
			
			return WC;
		} //** wc_PKI7
		
		//** Generate the SET methods
		
	}
	
}

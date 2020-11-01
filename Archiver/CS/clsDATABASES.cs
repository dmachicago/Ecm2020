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
	public class clsDATABASES
	{
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		
		string DB_ID = "";
		string DB_CONN_STR = "";
		
		
		//** Generate the SET methods
		public void setDb_id(string val)
		{
			if (val.Length == 0)
			{
				val = "ECM.Library";
				//messagebox.show("SET: Field 'Db_id' cannot be NULL.")
				//Return
			}
			val = UTIL.RemoveSingleQuotes(val);
			DB_ID = val;
		}
		
		public void setDb_conn_str(string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			DB_CONN_STR = val;
		}
		
		
		
		//** Generate the GET methods
		public string getDb_id()
		{
			if (DB_ID.Length == 0)
			{
				//messagebox.show("GET: Field 'Db_id' cannot be NULL.")
				return "ECM.Library";
			}
			return UTIL.RemoveSingleQuotes(DB_ID);
		}
		
		public string getDb_conn_str()
		{
			return UTIL.RemoveSingleQuotes(DB_CONN_STR);
		}
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (DB_ID.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			if (DB_ID.Length == 0)
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
			s = s + " INSERT INTO Databases(";
			s = s + "DB_ID,";
			s = s + "DB_CONN_STR) values (";
			s = s + "\'" + DB_ID + "\'" + ",";
			s = s + "\'" + DB_CONN_STR + "\'" + ")";
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
			
			s = s + " update Databases set ";
			s = s + "DB_ID = \'" + getDb_id() + "\'" + ", ";
			s = s + "DB_CONN_STR = \'" + getDb_conn_str() + "\'";
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
			s = s + "DB_ID,";
			s = s + "DB_CONN_STR ";
			s = s + " FROM Databases";
			
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
			s = s + "DB_ID,";
			s = s + "DB_CONN_STR ";
			s = s + " FROM Databases";
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
			
			s = " Delete from Databases";
			s = s + WhereClause;
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize(string WhereClause)
		{
			bool b = false;
			string s = "";
			
			s = s + " Delete from Databases";
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
	}
	
}

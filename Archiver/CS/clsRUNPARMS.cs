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
	public class clsRUNPARMS
	{
		
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		
		
		string Parm = "";
		string ParmValue = "";
		string UserID = "";
		
		
		
		
		//** Generate the SET methods
		public void setParm(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Parm\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			Parm = val;
		}
		
		
		public void setParmvalue(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			ParmValue = val;
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
		public string getParm()
		{
			if (Parm.Length == 0)
			{
				MessageBox.Show("GET: Field \'Parm\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(Parm);
		}
		
		
		public string getParmvalue()
		{
			return UTIL.RemoveSingleQuotes(ParmValue);
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
			if (Parm.Length == 0)
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
			if (Parm.Length == 0)
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
			s = s + " INSERT INTO RunParms(";
			s = s + "Parm,";
			s = s + "ParmValue,";
			s = s + "UserID) values (";
			s = s + "\'" + getParm() + "\'" + ",";
			s = s + "\'" + getParmvalue() + "\'" + ",";
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
			
			
			s = s + " update RunParms set ";
			//s = s + "Parm = '" + getParm() + "'" + ", "
			s = s + "ParmValue = \'" + getParmvalue() + "\'" + ", ";
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
			s = s + "Parm,";
			s = s + "ParmValue,";
			s = s + "UserID ";
			s = s + " FROM RunParms";
			
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
			s = s + "Parm,";
			s = s + "ParmValue,";
			s = s + "UserID ";
			s = s + " FROM RunParms ";
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
			
			
			s = " Delete from RunParms ";
			s = s + WhereClause;
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			
			s = s + " Delete from RunParms ";
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate Index Queries
		public int cnt_PKI8(string Parm, string UserID)
		{
			
			
			int B = 0;
			string TBL = "RunParms";
			string WC = "Where Parm = \'" + Parm + "\' and   UserID = \'" + UserID + "\'";
			
			
			B = DB.iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_PKI8
		
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PKI8(string Parm, string UserID)
		{
			
			SqlDataReader rsData = null;
			string TBL = "RunParms";
			string WC = "Where Parm = \'" + Parm + "\' and   UserID = \'" + UserID + "\'";
			
			rsData = DB.GetRowByKey(TBL, WC);
			if (rsData == null)
			{
				return null;
			}
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PKI8
		
		
		/// Build Index Where Caluses
		///
		public string wc_PKI8(string Parm, string UserID)
		{
			
			
			string WC = "Where Parm = \'" + Parm + "\' and   UserID = \'" + UserID + "\'";
			
			
			return WC;
		} //** wc_PKI8
		
		
		//** Generate the SET methods
		
		
	}
	
}

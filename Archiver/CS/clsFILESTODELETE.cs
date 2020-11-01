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
	public class clsFILESTODELETE
	{
		
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		
		clsDataGrid DG = new clsDataGrid();
		
		
		string UserID = "";
		string MachineName = "";
		string FQN = "";
		string PendingDelete = "";
		
		
		
		
		//** Generate the SET methods
		public void setUserid(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			UserID = val;
		}
		
		
		public void setMachinename(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			MachineName = val;
		}
		
		
		public void setFqn(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			FQN = val;
		}
		
		
		public void setPendingdelete(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			if (val.Equals("Y"))
			{
				val = "1";
			}
			if (val.Equals("N"))
			{
				val = "0";
			}
			val = UTIL.RemoveSingleQuotes(val);
			PendingDelete = val;
		}
		
		
		
		
		
		
		//** Generate the GET methods
		public string getUserid()
		{
			return UTIL.RemoveSingleQuotes(UserID);
		}
		
		
		public string getMachinename()
		{
			return UTIL.RemoveSingleQuotes(MachineName);
		}
		
		
		public string getFqn()
		{
			return UTIL.RemoveSingleQuotes(FQN);
		}
		
		
		public string getPendingdelete()
		{
			if (PendingDelete.Length == 0)
			{
				PendingDelete = "null";
			}
			return PendingDelete;
		}
		
		
		
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			return true;
		}
		
		
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			return true;
		}
		
		//** Generate the INSERT method
		public bool Insert()
		{
			bool b = false;
			string s = "";
			s = s + " INSERT INTO FilesToDelete(";
			s = s + "UserID,";
			s = s + "MachineName,";
			s = s + "FQN,";
			s = s + "PendingDelete) values (";
			s = s + "\'" + UserID + "\'" + ",";
			s = s + "\'" + MachineName + "\'" + ",";
			s = s + "\'" + FQN + "\'" + ",";
			s = s + PendingDelete + ")";
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
			
			
			s = s + " update FilesToDelete set ";
			s = s + "UserID = \'" + getUserid() + "\'" + ", ";
			s = s + "MachineName = \'" + getMachinename() + "\'" + ", ";
			s = s + "FQN = \'" + getFqn() + "\'" + ", ";
			s = s + "PendingDelete = " + getPendingdelete();
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
			s = s + "MachineName,";
			s = s + "FQN,";
			s = s + "PendingDelete ";
			s = s + " FROM FilesToDelete";
			
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
			s = s + "MachineName,";
			s = s + "FQN,";
			s = s + "PendingDelete ";
			s = s + " FROM FilesToDelete";
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
			
			
			s = " Delete from FilesToDelete";
			s = s + WhereClause;
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			
			s = s + " Delete from FilesToDelete";
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate Index Queries
		public int cnt_PK_FileToDelete(string FQN, string MachineName, string UserID)
		{
			
			
			int B = 0;
			string TBL = "FilesToDelete";
			string WC = "Where FQN = \'" + FQN + "\' and   MachineName = \'" + MachineName + "\' and   UserID = \'" + UserID + "\'";
			
			
			B = DB.iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_PK_FileToDelete
		
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PK_FileToDelete(string FQN, string MachineName, string UserID)
		{
			
			
			SqlDataReader rsData = null;
			string TBL = "FilesToDelete";
			string WC = "Where FQN = \'" + FQN + "\' and   MachineName = \'" + MachineName + "\' and   UserID = \'" + UserID + "\'";
			
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PK_FileToDelete
		
		
		/// Build Index Where Caluses
		///
		public string wc_PK_FileToDelete(string FQN, string MachineName, string UserID)
		{
			
			
			string WC = "Where FQN = \'" + FQN + "\' and   MachineName = \'" + MachineName + "\' and   UserID = \'" + UserID + "\'";
			
			
			return WC;
		} //** wc_PK_FileToDelete
		
		
		//** Generate the SET methods
		
		
	}
	
}

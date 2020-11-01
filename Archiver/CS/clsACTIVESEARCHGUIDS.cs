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
	public class clsACTIVESEARCHGUIDS
	{
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		string UserID = "";
		string DocGuid = "";
		string SeqNO = "";
		
		
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
		
		public void setDocguid(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Docguid\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			DocGuid = val;
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
		
		public string getDocguid()
		{
			if (DocGuid.Length == 0)
			{
				MessageBox.Show("GET: Field \'Docguid\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(DocGuid);
		}
		
		public string getSeqno()
		{
			if (SeqNO.Length == 0)
			{
				MessageBox.Show("GET: Field \'Seqno\' cannot be NULL.");
				return "";
			}
			if (SeqNO.Length == 0)
			{
				SeqNO = "null";
			}
			return SeqNO;
		}
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (UserID.Length == 0)
			{
				return false;
			}
			if (DocGuid.Length == 0)
			{
				return false;
			}
			if (SeqNO.Length == 0)
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
			if (DocGuid.Length == 0)
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
			s = s + " INSERT INTO ActiveSearchGuids(";
			s = s + "UserID,";
			s = s + "DocGuid) values (";
			s = s + "\'" + UserID + "\'" + ",";
			s = s + "\'" + DocGuid + "\'" + ")";
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
			
			s = s + " update ActiveSearchGuids set ";
			s = s + "UserID = \'" + getUserid() + "\'" + ", ";
			s = s + "DocGuid = \'" + getDocguid() + "\'" + ", ";
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
			s = s + "DocGuid,";
			s = s + "SeqNO ";
			s = s + " FROM ActiveSearchGuids";
			
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
			s = s + "DocGuid,";
			s = s + "SeqNO ";
			s = s + " FROM ActiveSearchGuids";
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
			
			s = " Delete from ActiveSearchGuids";
			s = s + WhereClause;
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			s = s + " Delete from ActiveSearchGuids";
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate Index Queries
		public int cnt_PI01_ActiveSearchGuids(int SeqNO, string UserID)
		{
			
			int B = 0;
			string TBL = "ActiveSearchGuids";
			string WC = (string) ("Where SeqNO = " + SeqNO.ToString() + (" and   UserID = \'" + UserID + "\'"));
			
			B = DB.iGetRowCount(TBL, WC);
			
			return B;
		} //** cnt_PI01_ActiveSearchGuids
		public int cnt_PK_ActiveSearchGuids(string DocGuid, string UserID)
		{
			
			int B = 0;
			string TBL = "ActiveSearchGuids";
			string WC = "Where DocGuid = \'" + DocGuid + "\' and   UserID = \'" + UserID + "\'";
			
			B = DB.iGetRowCount(TBL, WC);
			
			return B;
		} //** cnt_PK_ActiveSearchGuids
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PI01_ActiveSearchGuids(int SeqNO, string UserID)
		{
			
			SqlDataReader rsData = null;
			string TBL = "ActiveSearchGuids";
			string WC = (string) ("Where SeqNO = " + SeqNO.ToString() + (" and   UserID = \'" + UserID + "\'"));
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PI01_ActiveSearchGuids
		public SqlDataReader getRow_PK_ActiveSearchGuids(string DocGuid, string UserID)
		{
			
			SqlDataReader rsData = null;
			string TBL = "ActiveSearchGuids";
			string WC = "Where DocGuid = \'" + DocGuid + "\' and   UserID = \'" + UserID + "\'";
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PK_ActiveSearchGuids
		
		/// Build Index Where Caluses
		///
		public string wc_PI01_ActiveSearchGuids(int SeqNO, string UserID)
		{
			
			string WC = (string) ("Where SeqNO = " + SeqNO.ToString() + (" and   UserID = \'" + UserID + "\'"));
			
			return WC;
		} //** wc_PI01_ActiveSearchGuids
		public string wc_PK_ActiveSearchGuids(string DocGuid, string UserID)
		{
			
			string WC = "Where DocGuid = \'" + DocGuid + "\' and   UserID = \'" + UserID + "\'";
			
			return WC;
		} //** wc_PK_ActiveSearchGuids
		
		//** Generate the SET methods
		
	}
	
}

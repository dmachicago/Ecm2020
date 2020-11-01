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
	public class clsSUBDIR
	{
		
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		string UserID = "";
		string SUBFQN = "";
		string FQN = "";
		string ckPublic = "";
		string ckDisableDir = "";
		string OcrDirectory = "";
		
		
		
		
		//** Generate the SET methods
		public void setOcrDirectory(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Userid\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			OcrDirectory = val;
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
		
		
		public void setSubfqn(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Subfqn\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			SUBFQN = val;
		}
		
		
		public void setFqn(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Fqn\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			FQN = val;
		}
		
		
		public void setCkpublic(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			ckPublic = val;
		}
		
		
		public void setCkdisabledir(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			ckDisableDir = val;
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
		
		
		public string getSubfqn()
		{
			if (SUBFQN.Length == 0)
			{
				MessageBox.Show("GET: Field \'Subfqn\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(SUBFQN);
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
		
		
		public string getCkpublic()
		{
			return UTIL.RemoveSingleQuotes(ckPublic);
		}
		
		
		public string getCkdisabledir()
		{
			return UTIL.RemoveSingleQuotes(ckDisableDir);
		}
		
		
		
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (UserID.Length == 0)
			{
				return false;
			}
			if (SUBFQN.Length == 0)
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
			if (SUBFQN.Length == 0)
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
			if (OcrDirectory.Length == 0)
			{
				MessageBox.Show("OcrDirectory  must be set to either Y or N");
			}
			bool b = false;
			string s = "";
			s = s + " INSERT INTO SubDir(";
			s = s + "UserID,";
			s = s + "SUBFQN,";
			s = s + "FQN,";
			s = s + "ckPublic,";
			s = s + "ckDisableDir,OcrDirectory) values (";
			s = s + "\'" + UserID + "\'" + ",";
			s = s + "\'" + SUBFQN + "\'" + ",";
			s = s + "\'" + FQN + "\'" + ",";
			s = s + "\'" + ckPublic + "\'" + ",";
			s = s + "\'" + ckDisableDir + "\'" + ",";
			s = s + "\'" + OcrDirectory + "\'" + ")";
			return DB.ExecuteSqlNewConn(s, false);
			
			
		}
		
		
		
		
		//** Generate the UPDATE method
		public bool Update(string WhereClause)
		{
			bool b = false;
			string s = "";
			
			
			if (OcrDirectory.Length == 0)
			{
				MessageBox.Show("OcrDirectory  must be set to either Y or N");
			}
			if (WhereClause.Length == 0)
			{
				return false;
			}
			
			
			s = s + " update SubDir set ";
			s = s + "UserID = \'" + getUserid() + "\'" + ", ";
			s = s + "SUBFQN = \'" + getSubfqn() + "\'" + ", ";
			s = s + "FQN = \'" + getFqn() + "\'" + ", ";
			s = s + "ckPublic = \'" + getCkpublic() + "\'" + ", ";
			s = s + "ckDisableDir = \'" + getCkdisabledir() + "\'";
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
			s = s + "SUBFQN,";
			s = s + "FQN,";
			s = s + "ckPublic,";
			s = s + "ckDisableDir ";
			s = s + " FROM SubDir";
			
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
			s = s + "SUBFQN,";
			s = s + "FQN,";
			s = s + "ckPublic,";
			s = s + "ckDisableDir ";
			s = s + " FROM SubDir";
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
			
			
			s = " Delete from SubDir";
			s = s + WhereClause;
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			
			s = s + " Delete from SubDir";
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate Index Queries
		public int cnt_PKI14(string FQN, string SUBFQN, string UserID)
		{
			
			
			int B = 0;
			string TBL = "SubDir";
			string WC = "Where FQN = \'" + FQN + "\' and   SUBFQN = \'" + SUBFQN + "\' and   UserID = \'" + UserID + "\'";
			
			
			B = DB.iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_PKI14
		
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PKI14(string FQN, string SUBFQN, string UserID)
		{
			
			
			SqlDataReader rsData = null;
			string TBL = "SubDir";
			string WC = "Where FQN = \'" + FQN + "\' and   SUBFQN = \'" + SUBFQN + "\' and   UserID = \'" + UserID + "\'";
			
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PKI14
		
		
		/// Build Index Where Caluses
		///
		public string wc_PKI14(string FQN, string SUBFQN, string UserID)
		{
			
			
			string WC = "Where FQN = \'" + FQN + "\' and   SUBFQN = \'" + SUBFQN + "\' and   UserID = \'" + UserID + "\'";
			
			
			return WC;
		} //** wc_PKI14
	}
	
}

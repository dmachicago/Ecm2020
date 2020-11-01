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
	public class clsQUICKDIRECTORY
	{
		
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		string UserID = "";
		string IncludeSubDirs = "";
		string FQN = "";
		string DB_ID = "";
		string VersionFiles = "";
		string ckMetaData = "";
		string ckPublic = "";
		string ckDisableDir = "";
		string QuickRefEntry = "";
		
		
		
		
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
		
		
		public void setIncludesubdirs(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			IncludeSubDirs = val;
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
		
		
		public void setDb_id(ref string val)
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
		
		
		public void setVersionfiles(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			VersionFiles = val;
		}
		
		
		public void setCkmetadata(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			ckMetaData = val;
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
		
		
		public void setQuickrefentry(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = UTIL.RemoveSingleQuotes(val);
			QuickRefEntry = val;
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
		
		
		public string getIncludesubdirs()
		{
			return UTIL.RemoveSingleQuotes(IncludeSubDirs);
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
		
		
		public string getDb_id()
		{
			if (DB_ID.Length == 0)
			{
				//messagebox.show("GET: Field 'Db_id' cannot be NULL.")
				return "ECM.Library";
			}
			return UTIL.RemoveSingleQuotes(DB_ID);
		}
		
		
		public string getVersionfiles()
		{
			return UTIL.RemoveSingleQuotes(VersionFiles);
		}
		
		
		public string getCkmetadata()
		{
			return UTIL.RemoveSingleQuotes(ckMetaData);
		}
		
		
		public string getCkpublic()
		{
			return UTIL.RemoveSingleQuotes(ckPublic);
		}
		
		
		public string getCkdisabledir()
		{
			return UTIL.RemoveSingleQuotes(ckDisableDir);
		}
		
		
		public string getQuickrefentry()
		{
			if (QuickRefEntry.Length == 0)
			{
				QuickRefEntry = "null";
			}
			return QuickRefEntry;
		}
		
		
		
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (UserID.Length == 0)
			{
				return false;
			}
			if (FQN.Length == 0)
			{
				return false;
			}
			if (DB_ID.Length == 0)
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
			if (FQN.Length == 0)
			{
				return false;
			}
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
			s = s + " INSERT INTO QuickDirectory(";
			s = s + "UserID,";
			s = s + "IncludeSubDirs,";
			s = s + "FQN,";
			s = s + "DB_ID,";
			s = s + "VersionFiles,";
			s = s + "ckMetaData,";
			s = s + "ckPublic,";
			s = s + "ckDisableDir,";
			s = s + "QuickRefEntry) values (";
			s = s + "\'" + UserID + "\'" + ",";
			s = s + "\'" + IncludeSubDirs + "\'" + ",";
			s = s + "\'" + FQN + "\'" + ",";
			s = s + "\'" + DB_ID + "\'" + ",";
			s = s + "\'" + VersionFiles + "\'" + ",";
			s = s + "\'" + ckMetaData + "\'" + ",";
			s = s + "\'" + ckPublic + "\'" + ",";
			s = s + "\'" + ckDisableDir + "\'" + ",";
			s = s + QuickRefEntry + ")";
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
			
			
			s = s + " update QuickDirectory set ";
			s = s + "UserID = \'" + getUserid() + "\'" + ", ";
			s = s + "IncludeSubDirs = \'" + getIncludesubdirs() + "\'" + ", ";
			s = s + "FQN = \'" + getFqn() + "\'" + ", ";
			s = s + "DB_ID = \'" + getDb_id() + "\'" + ", ";
			s = s + "VersionFiles = \'" + getVersionfiles() + "\'" + ", ";
			s = s + "ckMetaData = \'" + getCkmetadata() + "\'" + ", ";
			s = s + "ckPublic = \'" + getCkpublic() + "\'" + ", ";
			s = s + "ckDisableDir = \'" + getCkdisabledir() + "\'" + ", ";
			s = s + "QuickRefEntry = " + getQuickrefentry();
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
			s = s + "IncludeSubDirs,";
			s = s + "FQN,";
			s = s + "DB_ID,";
			s = s + "VersionFiles,";
			s = s + "ckMetaData,";
			s = s + "ckPublic,";
			s = s + "ckDisableDir,";
			s = s + "QuickRefEntry ";
			s = s + " FROM QuickDirectory";
			
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
			s = s + "IncludeSubDirs,";
			s = s + "FQN,";
			s = s + "DB_ID,";
			s = s + "VersionFiles,";
			s = s + "ckMetaData,";
			s = s + "ckPublic,";
			s = s + "ckDisableDir,";
			s = s + "QuickRefEntry ";
			s = s + " FROM QuickDirectory";
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
			
			
			s = " Delete from QuickDirectory";
			s = s + WhereClause;
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			
			s = s + " Delete from QuickDirectory";
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate Index Queries
		public int cnt_PKII2QD(string FQN, string UserID)
		{
			
			
			int B = 0;
			string TBL = "QuickDirectory";
			string WC = "Where FQN = \'" + FQN + "\' and   UserID = \'" + UserID + "\'";
			
			
			B = DB.iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_PKII2QD
		
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PKII2QD(string FQN, string UserID)
		{
			
			
			SqlDataReader rsData = null;
			string TBL = "QuickDirectory";
			string WC = "Where FQN = \'" + FQN + "\' and   UserID = \'" + UserID + "\'";
			
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PKII2QD
		
		
		/// Build Index Where Caluses
		///
		public string wc_PKII2QD(string FQN, string UserID)
		{
			
			
			string WC = "Where FQN = \'" + FQN + "\' and   UserID = \'" + UserID + "\'";
			
			
			return WC;
		} //** wc_PKII2QD
		
		
		//** Generate the SET methods
		
		
	}
	
}

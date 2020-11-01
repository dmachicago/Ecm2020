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
	public class clsDIRECTORY
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
		string QuickRefEntry = "0";
		string OcrDirectory = "";
		string OcrPdf = "";
		bool ArchiveBit = false;
		string DeleteOnArchive = "";
		
		//DeleteOnArchive
		//** Generate the SET methods
		public void setDeleteOnArchive(string val)
		{
			DeleteOnArchive = val;
		}
		public void setSkipIfArchiveBit(string val)
		{
			if (val.ToUpper().Equals("TRUE"))
			{
				ArchiveBit = true;
			}
			else
			{
				ArchiveBit = false;
			}
		}
		public void setOcrPdf(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Userid\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			OcrPdf = val;
		}
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
		public void setQuickRefEntry(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			QuickRefEntry = val;
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
			if (IncludeSubDirs.ToUpper().Equals("TRUE"))
			{
				IncludeSubDirs = "Y";
			}
			if (IncludeSubDirs.ToUpper().Equals("FALSE"))
			{
				IncludeSubDirs = "N";
			}
			if (IncludeSubDirs.ToUpper().Equals("1"))
			{
				IncludeSubDirs = "Y";
			}
			if (IncludeSubDirs.ToUpper().Equals("0"))
			{
				IncludeSubDirs = "N";
			}
			
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
			if (VersionFiles.ToUpper().Equals("TRUE"))
			{
				VersionFiles = "Y";
			}
			if (VersionFiles.ToUpper().Equals("FALSE"))
			{
				VersionFiles = "N";
			}
			if (VersionFiles.ToUpper().Equals("1"))
			{
				VersionFiles = "Y";
			}
			if (VersionFiles.ToUpper().Equals("0"))
			{
				VersionFiles = "N";
			}
			
			return UTIL.RemoveSingleQuotes(VersionFiles);
		}
		
		public string getCkmetadata()
		{
			if (ckMetaData.ToUpper().Equals("TRUE"))
			{
				ckMetaData = "Y";
			}
			if (ckMetaData.ToUpper().Equals("FALSE"))
			{
				ckMetaData = "N";
			}
			if (ckMetaData.ToUpper().Equals("1"))
			{
				ckMetaData = "Y";
			}
			if (ckMetaData.ToUpper().Equals("0"))
			{
				ckMetaData = "N";
			}
			return UTIL.RemoveSingleQuotes(ckMetaData);
		}
		
		public string getCkpublic()
		{
			if (ckPublic.ToUpper().Equals("TRUE"))
			{
				ckPublic = "Y";
			}
			if (ckPublic.ToUpper().Equals("FALSE"))
			{
				ckPublic = "N";
			}
			if (ckPublic.ToUpper().Equals("1"))
			{
				ckPublic = "Y";
			}
			if (ckPublic.ToUpper().Equals("0"))
			{
				ckPublic = "N";
			}
			
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
			
			if (QuickRefEntry.Length == 0)
			{
				QuickRefEntry = "0";
			}
			if (OcrDirectory.Length == 0)
			{
				MessageBox.Show("OcrDirectory must be set to either Y or N");
			}
			
			bool b = false;
			string s = "";
			s = s + " INSERT INTO Directory(";
			s = s + "UserID,";
			s = s + "IncludeSubDirs,";
			s = s + "FQN,";
			s = s + "DB_ID,";
			s = s + "VersionFiles,";
			s = s + "ckMetaData,";
			s = s + "ckPublic,";
			s = s + "ckDisableDir, QuickRefEntry, OcrDirectory, OcrPdf, ArchiveSkipBit, DeleteOnArchive) values (";
			s = s + "\'" + UserID + "\'" + ",";
			s = s + "\'" + IncludeSubDirs + "\'" + ",";
			s = s + "\'" + FQN + "\'" + ",";
			s = s + "\'" + DB_ID + "\'" + ",";
			s = s + "\'" + VersionFiles + "\'" + ",";
			s = s + "\'" + ckMetaData + "\'" + ",";
			s = s + "\'" + ckPublic + "\'" + ",";
			s = s + "\'" + ckDisableDir + "\'" + ",";
			s = s + "\'" + QuickRefEntry + "\'" + ",";
			s = s + "\'" + OcrDirectory + "\'" + ",";
			s = s + "\'" + OcrPdf + "\'" + ",";
			if (ArchiveBit == true)
			{
				s = s + "1" + ",";
			}
			else
			{
				s = s + "0" + ",";
			}
			s = s + "\'" + DeleteOnArchive + "\')";
			
			return DB.ExecuteSqlNewConn(s, false);
			
		}
		
		
		//** Generate the UPDATE method
		public bool Update(string WhereClause, string OcrDirectory)
		{
			bool b = false;
			string s = "";
			
			if (OcrDirectory.Length == 0)
			{
				MessageBox.Show("OcrDirectory must be set to either Y or N");
			}
			
			if (WhereClause.Length == 0)
			{
				return false;
			}
			
			string ckDisableDir = getCkdisabledir();
			if (ckDisableDir.ToUpper == "TRUE")
			{
				ckDisableDir = "Y";
			}
			if (ckDisableDir.ToUpper == "FALSE")
			{
				ckDisableDir = "N";
			}
			if (ckDisableDir.ToUpper == "1")
			{
				ckDisableDir = "Y";
			}
			if (ckDisableDir.ToUpper == "0")
			{
				ckDisableDir = "N";
			}
			
			s = "";
			s = s + " update Directory set ";
			s = s + "UserID = \'" + getUserid() + "\'" + ", ";
			s = s + "IncludeSubDirs = \'" + getIncludesubdirs() + "\'" + ", ";
			s = s + "FQN = \'" + getFqn() + "\'" + ", ";
			s = s + "VersionFiles = \'" + getVersionfiles() + "\'" + ", ";
			s = s + "ckMetaData = \'" + getCkmetadata() + "\'" + ", ";
			s = s + "ckPublic = \'" + getCkpublic() + "\'" + ", ";
			s = s + "ckDisableDir = \'" + ckDisableDir + "\',";
			s = s + "OcrDirectory = \'" + OcrDirectory + "\',";
			s = s + "OcrPdf = \'" + OcrPdf + "\',";
			if (ArchiveBit == true)
			{
				s = s + "ArchiveSkipBit = 1, ";
			}
			else
			{
				s = s + "ArchiveSkipBit = 0, ";
			}
			s = s + "DeleteOnArchive = \'" + DeleteOnArchive + "\'";
			
			
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
			s = s + "ckDisableDir ";
			s = s + " FROM Directory";
			
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
			s = s + "ckDisableDir ";
			s = s + " FROM Directory";
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
			
			s = " Delete from Directory";
			s = s + WhereClause;
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			s = s + " Delete from Directory";
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate Index Queries
		public int cnt_PKII2(string FQN, string UserID)
		{
			
			int B = 0;
			string TBL = "Directory";
			string WC = "Where FQN = \'" + FQN + "\' and   UserID = \'" + UserID + "\'";
			
			B = DB.iGetRowCount(TBL, WC);
			
			return B;
		} //** cnt_PKII2
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PKII2(string FQN, string UserID)
		{
			
			SqlDataReader rsData = null;
			string TBL = "Directory";
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
		} //** getRow_PKII2
		
		/// Build Index Where Caluses
		///
		public string wc_PKII2(string FQN, string UserID)
		{
			
			string WC = "Where FQN = \'" + FQN + "\' and   UserID = \'" + UserID + "\'";
			
			return WC;
		} //** wc_PKII2
	}
	
}

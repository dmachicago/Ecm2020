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
	public class clsEMAILARCHPARMS
	{
		
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		string UserID = "";
		string ArchiveEmails = "";
		string RemoveAfterArchive = "";
		string SetAsDefaultFolder = "";
		string ArchiveAfterXDays = "";
		string RemoveAfterXDays = "";
		string RemoveXDays = "";
		string ArchiveXDays = "";
		string FolderName = "";
		string DB_ID = "";
		string ArchiveOnlyIfRead = "";
		string isSysDefault = "";
		
		
		
		
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
		
		public void setIsSysDefault(string Val)
		{
			Val = UTIL.RemoveSingleQuotes(Val);
			isSysDefault = Val;
		}
		
		public void setArchiveemails(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			ArchiveEmails = val;
		}
		
		
		public void setRemoveafterarchive(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			RemoveAfterArchive = val;
		}
		
		
		public void setSetasdefaultfolder(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			SetAsDefaultFolder = val;
		}
		
		
		public void setArchiveafterxdays(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			ArchiveAfterXDays = val;
		}
		
		
		public void setRemoveafterxdays(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			RemoveAfterXDays = val;
		}
		
		
		public void setRemovexdays(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = UTIL.RemoveSingleQuotes(val);
			RemoveXDays = val;
		}
		
		
		public void setArchivexdays(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = UTIL.RemoveSingleQuotes(val);
			ArchiveXDays = val;
		}
		
		
		public void setFoldername(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Foldername\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			FolderName = val;
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
		
		
		public void setArchiveonlyifread(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			ArchiveOnlyIfRead = val;
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
		
		
		public string getArchiveemails()
		{
			return UTIL.RemoveSingleQuotes(ArchiveEmails);
		}
		
		
		public string getRemoveafterarchive()
		{
			return UTIL.RemoveSingleQuotes(RemoveAfterArchive);
		}
		
		
		public string getSetasdefaultfolder()
		{
			return UTIL.RemoveSingleQuotes(SetAsDefaultFolder);
		}
		
		
		public string getArchiveafterxdays()
		{
			return UTIL.RemoveSingleQuotes(ArchiveAfterXDays);
		}
		
		
		public string getRemoveafterxdays()
		{
			return UTIL.RemoveSingleQuotes(RemoveAfterXDays);
		}
		
		
		public string getRemovexdays()
		{
			if (RemoveXDays.Length == 0)
			{
				RemoveXDays = "null";
			}
			return RemoveXDays;
		}
		
		
		public string getArchivexdays()
		{
			if (ArchiveXDays.Length == 0)
			{
				ArchiveXDays = "null";
			}
			return ArchiveXDays;
		}
		
		
		public string getFoldername()
		{
			if (FolderName.Length == 0)
			{
				MessageBox.Show("GET: Field \'Foldername\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(FolderName);
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
		
		
		public string getArchiveonlyifread()
		{
			return UTIL.RemoveSingleQuotes(ArchiveOnlyIfRead);
		}
		
		
		
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (UserID.Length == 0)
			{
				return false;
			}
			if (FolderName.Length == 0)
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
			if (FolderName.Length == 0)
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
		public bool Insert(string ContainerName)
		{
			
			ContainerName = UTIL.RemoveSingleQuotes(ContainerName);
			
			bool b = false;
			string s = "";
			s = s + " INSERT INTO EmailArchParms(";
			s = s + "UserID,";
			s = s + "ArchiveEmails,";
			s = s + "RemoveAfterArchive,";
			s = s + "SetAsDefaultFolder,";
			s = s + "ArchiveAfterXDays,";
			s = s + "RemoveAfterXDays,";
			s = s + "RemoveXDays,";
			s = s + "ArchiveXDays,";
			s = s + "FolderName,";
			s = s + "DB_ID,";
			s = s + "ArchiveOnlyIfRead,isSysDefault, ContainerName) values (";
			s = s + "\'" + UserID + "\'" + ",";
			s = s + "\'" + ArchiveEmails + "\'" + ",";
			s = s + "\'" + RemoveAfterArchive + "\'" + ",";
			s = s + "\'" + SetAsDefaultFolder + "\'" + ",";
			s = s + "\'" + ArchiveAfterXDays + "\'" + ",";
			s = s + "\'" + RemoveAfterXDays + "\'" + ",";
			s = s + RemoveXDays + ",";
			if (ArchiveXDays.Trim().Length == 0)
			{
				ArchiveXDays = "30";
			}
			s = s + ArchiveXDays + ",";
			s = s + "\'" + FolderName + "\'" + ",";
			s = s + "\'" + DB_ID + "\'" + ",";
			s = s + "\'" + ArchiveOnlyIfRead + "\', ";
			s = s + isSysDefault + ", ";
			s = s + "\'" + ContainerName + "\')";
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
			
			
			s = s + " update EmailArchParms set ";
			s = s + "UserID = \'" + getUserid() + "\'" + ", ";
			s = s + "ArchiveEmails = \'" + getArchiveemails() + "\'" + ", ";
			s = s + "RemoveAfterArchive = \'" + getRemoveafterarchive() + "\'" + ", ";
			s = s + "SetAsDefaultFolder = \'" + getSetasdefaultfolder() + "\'" + ", ";
			s = s + "ArchiveAfterXDays = \'" + getArchiveafterxdays() + "\'" + ", ";
			s = s + "RemoveAfterXDays = \'" + getRemoveafterxdays() + "\'" + ", ";
			s = s + "RemoveXDays = " + getRemovexdays() + ", ";
			s = s + "ArchiveXDays = " + getArchivexdays() + ", ";
			s = s + "FolderName = \'" + getFoldername() + "\'" + ", ";
			s = s + "DB_ID = \'" + getDb_id() + "\'" + ", ";
			s = s + "ArchiveOnlyIfRead = \'" + getArchiveonlyifread() + "\', ";
			s = s + "isSysDefault = " + isSysDefault + " ";
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
			s = s + "ArchiveEmails,";
			s = s + "RemoveAfterArchive,";
			s = s + "SetAsDefaultFolder,";
			s = s + "ArchiveAfterXDays,";
			s = s + "RemoveAfterXDays,";
			s = s + "RemoveXDays,";
			s = s + "ArchiveXDays,";
			s = s + "FolderName,";
			s = s + "DB_ID,";
			s = s + "ArchiveOnlyIfRead ";
			s = s + " FROM EmailArchParms";
			
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
			s = s + "ArchiveEmails,";
			s = s + "RemoveAfterArchive,";
			s = s + "SetAsDefaultFolder,";
			s = s + "ArchiveAfterXDays,";
			s = s + "RemoveAfterXDays,";
			s = s + "RemoveXDays,";
			s = s + "ArchiveXDays,";
			s = s + "FolderName,";
			s = s + "DB_ID,";
			s = s + "ArchiveOnlyIfRead ";
			s = s + " FROM EmailArchParms";
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
			
			
			s = " Delete from EmailArchParms";
			s = s + WhereClause;
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			
			s = s + " Delete from EmailArchParms";
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate Index Queries
		public int cnt_PK5EmailArchParms(string FolderName, string UserID)
		{
			
			
			int B = 0;
			string TBL = "EmailArchParms";
			string WC = "Where FolderName = \'" + FolderName + "\' and   UserID = \'" + UserID + "\'";
			
			
			B = DB.iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_PK5EmailArchParms
		
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PK5EmailArchParms(string FolderName, string UserID)
		{
			
			
			SqlDataReader rsData = null;
			string TBL = "EmailArchParms";
			string WC = "Where FolderName = \'" + FolderName + "\' and   UserID = \'" + UserID + "\'";
			
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PK5EmailArchParms
		
		
		/// Build Index Where Caluses
		///
		public string wc_PK5EmailArchParms(string FolderName, string UserID)
		{
			
			
			string WC = "Where FolderName = \'" + FolderName + "\' and   UserID = \'" + UserID + "\'";
			
			
			return WC;
		} //** wc_PK5EmailArchParms
	}
	
}

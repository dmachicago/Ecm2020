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
	public class clsEMAILFOLDER
	{
		
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		string UserID = "";
		string FolderName = "";
		string ParentFolderName = "";
		string FolderID = "";
		string ParentFolderID = "";
		string SelectedForArchive = "";
		string StoreID = "";
		
		
		
		
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
		
		
		public void setFoldername(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			FolderName = val;
		}
		
		
		public void setParentfoldername(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			ParentFolderName = val;
		}
		
		
		public void setFolderid(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Folderid\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			FolderID = val;
		}
		
		
		public void setParentfolderid(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			ParentFolderID = val;
		}
		
		
		public void setSelectedforarchive(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			SelectedForArchive = val;
		}
		
		
		public void setStoreid(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			StoreID = val;
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
		
		
		public string getFoldername()
		{
			return UTIL.RemoveSingleQuotes(FolderName);
		}
		
		
		public string getParentfoldername()
		{
			return UTIL.RemoveSingleQuotes(ParentFolderName);
		}
		
		
		public string getFolderid()
		{
			if (FolderID.Length == 0)
			{
				MessageBox.Show("GET: Field \'Folderid\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(FolderID);
		}
		
		
		public string getParentfolderid()
		{
			return UTIL.RemoveSingleQuotes(ParentFolderID);
		}
		
		
		public string getSelectedforarchive()
		{
			return UTIL.RemoveSingleQuotes(SelectedForArchive);
		}
		
		
		public string getStoreid()
		{
			return UTIL.RemoveSingleQuotes(StoreID);
		}
		
		
		
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (UserID.Length == 0)
			{
				return false;
			}
			if (FolderID.Length == 0)
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
			if (FolderID.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		//** Generate the INSERT method
		public bool Insert(string MasterFolder)
		{
			bool b = false;
			string s = "";
			
			MasterFolder = UTIL.RemoveSingleQuotes(MasterFolder);
			
			FolderName = MasterFolder.Trim + "|" + FolderName.Trim();
			
			FolderName = UTIL.RemoveSingleQuotes(FolderName);
			
			s = s + " INSERT INTO EmailFolder(";
			s = s + "UserID,";
			s = s + "FolderName,";
			s = s + "ParentFolderName,";
			s = s + "FolderID,";
			s = s + "ParentFolderID,";
			if (SelectedForArchive.Equals("Y") || SelectedForArchive.Equals("N"))
			{
				s = s + "SelectedForArchive,";
			}
			s = s + "StoreID, ContainerName) values (";
			s = s + "\'" + UserID + "\'" + ",";
			s = s + "\'" + FolderName + "\'" + ",";
			s = s + "\'" + ParentFolderName + "\'" + ",";
			s = s + "\'" + FolderID + "\'" + ",";
			s = s + "\'" + ParentFolderID + "\'" + ",";
			if (SelectedForArchive.Equals("Y") || SelectedForArchive.Equals("N"))
			{
				s = s + "\'" + SelectedForArchive + "\'" + ",";
			}
			s = s + "\'" + StoreID + "\'" + ",";
			s = s + "\'" + MasterFolder.Trim + "\'" + ")";
			
			b = DB.ExecuteSqlNewConn(s, false);
			
			if (b)
			{
				return true;
			}
			else
			{
				LOG.WriteToArchiveLog((string) ("ERROR: Failed to add email folder - " + MasterFolder + " : " + FolderName + " : " + ParentFolderName));
				return false;
			}
			
			
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
			
			string SelectedForArchive = getSelectedforarchive();
			
			s = s + " update EmailFolder set " + "\r\n";
			s = s + "UserID = \'" + getUserid() + "\'" + ", " + "\r\n";
			s = s + "FolderName = \'" + getFoldername() + "\'" + ", " + "\r\n";
			s = s + "ParentFolderName = \'" + getParentfoldername() + "\'" + ", " + "\r\n";
			s = s + "FolderID = \'" + getFolderid() + "\'" + ", " + "\r\n";
			s = s + "ParentFolderID = \'" + getParentfolderid() + "\'" + ", " + "\r\n";
			if (SelectedForArchive.Equals("Y") || SelectedForArchive.Equals("N"))
			{
				s = s + "SelectedForArchive = \'" + getSelectedforarchive() + "\'" + ", " + "\r\n";
			}
			s = s + "StoreID = \'" + getStoreid() + "\'" + "\r\n";
			WhereClause = " " + WhereClause + "\r\n";
			s = s + WhereClause + "\r\n";
			if (modGlobals.gClipBoardActive == true)
			{
				Clipboard.Clear();
			}
			if (modGlobals.gClipBoardActive == true)
			{
				Clipboard.SetText(s);
			}
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
			s = s + "FolderName,";
			s = s + "ParentFolderName,";
			s = s + "FolderID,";
			s = s + "ParentFolderID,";
			s = s + "SelectedForArchive,";
			s = s + "StoreID ";
			s = s + " FROM EmailFolder";
			
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
			s = s + "FolderName,";
			s = s + "ParentFolderName,";
			s = s + "FolderID,";
			s = s + "ParentFolderID,";
			s = s + "SelectedForArchive,";
			s = s + "StoreID ";
			s = s + " FROM EmailFolder";
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
			
			
			s = " Delete from EmailFolder";
			s = s + WhereClause;
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			
			s = s + " Delete from EmailFolder";
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate Index Queries
		public int cnt_IDX_FolderName(string ContainerName, string FolderName, string UserID)
		{
			
			
			int B = 0;
			string TBL = "EmailFolder";
			string WC = "Where ContainerName = \'" + ContainerName + "\' and FolderName = \'" + FolderName + "\' and   UserID = \'" + UserID + "\'";
			
			
			B = DB.iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_IDX_FolderName
		public int cnt_PK_EmailFolder(string FolderID, string UserID)
		{
			
			
			int B = 0;
			string TBL = "EmailFolder";
			string WC = "Where FolderID = \'" + FolderID + "\' and   UserID = \'" + UserID + "\'";
			
			
			B = DB.iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_PK_EmailFolder
		public int cnt_UI_EmailFolder(string TopLevelOutlookFolderName, string FolderName, string UserID)
		{
			
			TopLevelOutlookFolderName = UTIL.RemoveSingleQuotes(TopLevelOutlookFolderName);
			FolderName = UTIL.RemoveSingleQuotes(FolderName);
			FolderName = TopLevelOutlookFolderName + "|" + FolderName;
			
			int B = 0;
			string TBL = "EmailFolder";
			string WC = "Where ContainerName = \'" + TopLevelOutlookFolderName + "\' and FolderName = \'" + FolderName + "\' and   UserID = \'" + UserID + "\'";
			
			
			B = DB.iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_UI_EmailFolder
		
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_IDX_FolderName(string FolderName, string UserID)
		{
			
			
			SqlDataReader rsData = null;
			string TBL = "EmailFolder";
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
		} //** getRow_IDX_FolderName
		public SqlDataReader getRow_PK_EmailFolder(string FolderID, string UserID)
		{
			
			
			SqlDataReader rsData = null;
			string TBL = "EmailFolder";
			string WC = "Where FolderID = \'" + FolderID + "\' and   UserID = \'" + UserID + "\'";
			
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PK_EmailFolder
		public SqlDataReader getRow_UI_EmailFolder(string FolderName, string UserID)
		{
			
			
			SqlDataReader rsData = null;
			string TBL = "EmailFolder";
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
		} //** getRow_UI_EmailFolder
		
		
		/// Build Index Where Caluses
		///
		public string wc_IDX_FolderName(string FolderName, string UserID)
		{
			
			
			string WC = "Where FolderName = \'" + FolderName + "\' and   UserID = \'" + UserID + "\'";
			
			
			return WC;
		} //** wc_IDX_FolderName
		public string wc_PK_EmailFolder(string FolderID, string UserID)
		{
			
			
			string WC = "Where FolderID = \'" + FolderID + "\' and   UserID = \'" + UserID + "\'";
			
			
			return WC;
		} //** wc_PK_EmailFolder
		public string wc_UI_EmailFolder(string ContainerName, string FolderName, string UserID)
		{
			
			// "where [ContainerName] = '" + ContainerName  + "' and FolderName = 'Personal Folders|Junk E-mail' and UserID = 'wmiller'"
			ContainerName = UTIL.RemoveSingleQuotes(ContainerName);
			FolderName = UTIL.RemoveSingleQuotes(FolderName);
			
			string WC = "where [ContainerName] = \'" + ContainerName + "\' and FolderName = \'" + FolderName + "\' and UserID = \'" + UserID + "\'";
			
			
			return WC;
		} //** wc_UI_EmailFolder
		
		
		//** Generate the SET methods
		
		
	}
	
}

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
	public class clsLIBEMAIL
	{
		
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		
		string EmailFolderEntryID = "";
		string UserID = "";
		string LibraryName = "";
		string FolderName = "";
		
		
		
		
		//** Generate the SET methods
		public void setEmailfolderentryid(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Emailfolderentryid\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			EmailFolderEntryID = val;
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
		
		
		public void setLibraryname(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Libraryname\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			LibraryName = val;
		}
		
		
		public void setFoldername(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			FolderName = val;
		}
		
		
		
		
		
		
		//** Generate the GET methods
		public string getEmailfolderentryid()
		{
			if (EmailFolderEntryID.Length == 0)
			{
				MessageBox.Show("GET: Field \'Emailfolderentryid\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(EmailFolderEntryID);
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
		
		
		public string getLibraryname()
		{
			if (LibraryName.Length == 0)
			{
				MessageBox.Show("GET: Field \'Libraryname\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(LibraryName);
		}
		
		
		public string getFoldername()
		{
			return UTIL.RemoveSingleQuotes(FolderName);
		}
		
		
		
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (EmailFolderEntryID.Length == 0)
			{
				return false;
			}
			if (UserID.Length == 0)
			{
				return false;
			}
			if (LibraryName.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			if (EmailFolderEntryID.Length == 0)
			{
				return false;
			}
			if (UserID.Length == 0)
			{
				return false;
			}
			if (LibraryName.Length == 0)
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
			s = s + " INSERT INTO LibEmail(";
			s = s + "EmailFolderEntryID,";
			s = s + "UserID,";
			s = s + "LibraryName,";
			s = s + "FolderName) values (";
			s = s + "\'" + EmailFolderEntryID + "\'" + ",";
			s = s + "\'" + UserID + "\'" + ",";
			s = s + "\'" + LibraryName + "\'" + ",";
			s = s + "\'" + FolderName + "\'" + ")";
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
			
			
			s = s + " update LibEmail set ";
			s = s + "EmailFolderEntryID = \'" + getEmailfolderentryid() + "\'" + ", ";
			s = s + "UserID = \'" + getUserid() + "\'" + ", ";
			s = s + "LibraryName = \'" + getLibraryname() + "\'" + ", ";
			s = s + "FolderName = \'" + getFoldername() + "\'";
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
			s = s + "EmailFolderEntryID,";
			s = s + "UserID,";
			s = s + "LibraryName,";
			s = s + "FolderName ";
			s = s + " FROM LibEmail";
			
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
			s = s + "EmailFolderEntryID,";
			s = s + "UserID,";
			s = s + "LibraryName,";
			s = s + "FolderName ";
			s = s + " FROM LibEmail";
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
			
			
			s = " Delete from LibEmail ";
			s = s + WhereClause;
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			
			s = s + " Delete from LibEmail";
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate Index Queries
		public int cnt_PI01_LibEmail(string FolderName, string LibraryName)
		{
			
			
			int B = 0;
			string TBL = "LibEmail";
			//Dim WC  = "Where EmailFolderEntryID = '" + EmailFolderEntryID + "' and   FolderName = '" + FolderName + "'"
			string WC = "Where FolderName = \'" + FolderName + "\' and   LibraryName = \'" + LibraryName + "\'";
			
			
			B = DB.iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_PI01_LibEmail
		public int cnt_PK99(string EmailFolderEntryID, string LibraryName, string UserID)
		{
			
			
			int B = 0;
			string TBL = "LibEmail";
			string WC = "Where EmailFolderEntryID = \'" + EmailFolderEntryID + "\' and   LibraryName = \'" + LibraryName + "\' and   UserID = \'" + UserID + "\'";
			
			
			B = DB.iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_PK99
		
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PI01_LibEmail(string EmailFolderEntryID, string FolderName)
		{
			
			
			SqlDataReader rsData = null;
			string TBL = "LibEmail";
			string WC = "Where EmailFolderEntryID = \'" + EmailFolderEntryID + "\' and   FolderName = \'" + FolderName + "\'";
			
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PI01_LibEmail
		public SqlDataReader getRow_PK99(string EmailFolderEntryID, string LibraryName, string UserID)
		{
			
			
			SqlDataReader rsData = null;
			string TBL = "LibEmail";
			string WC = "Where EmailFolderEntryID = \'" + EmailFolderEntryID + "\' and   LibraryName = \'" + LibraryName + "\' and   UserID = \'" + UserID + "\'";
			
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PK99
		
		
		/// Build Index Where Caluses
		///
		public string wc_PI01_LibEmail(string EmailFolderEntryID, string FolderName)
		{
			
			
			string WC = "Where EmailFolderEntryID = \'" + EmailFolderEntryID + "\' and   FolderName = \'" + FolderName + "\'";
			
			
			return WC;
		} //** wc_PI01_LibEmail
		public string wc_PK99(string FolderName, string LibraryName, string UserID)
		{
			
			
			string WC = "Where FolderName = \'" + FolderName + "\' and   LibraryName = \'" + LibraryName + "\' and   UserID = \'" + UserID + "\'";
			
			
			return WC;
		} //** wc_PK99
		
		
		//** Generate the SET methods
		
		
	}
	
}

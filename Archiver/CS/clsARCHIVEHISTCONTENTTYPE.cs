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
	public class clsARCHIVEHISTCONTENTTYPE
	{
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		
		string ArchiveID = "";
		string Directory = "";
		string FileType = "";
		string NbrFilesArchived = "";
		
		
		//** Generate the SET methods
		public void setArchiveid(ref string val)
		{
			if (val.Length == 0)
			{
				val = Guid.NewGuid().ToString();
			}
			if (val.Length == 0)
			{
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show("SET: Field \'Archiveid\' cannot be NULL: 2100.");
				}
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			ArchiveID = val;
		}
		
		public void setDirectory(ref string val)
		{
			if (val.Length == 0)
			{
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show("SET: Field \'Directory\' cannot be NULL.");
				}
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			Directory = val;
		}
		
		public void setFiletype(ref string val)
		{
			if (val.Length == 0)
			{
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show("SET: Field \'Filetype\' cannot be NULL.");
				}
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			FileType = val;
		}
		
		public void setNbrfilesarchived(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = UTIL.RemoveSingleQuotes(val);
			NbrFilesArchived = val;
		}
		
		
		
		//** Generate the GET methods
		public string getArchiveid()
		{
			if (ArchiveID.Length == 0)
			{
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show("GET: Field \'Archiveid\' cannot be NULL: 2200.");
				}
				return "";
			}
			return UTIL.RemoveSingleQuotes(ArchiveID);
		}
		
		public string getDirectory()
		{
			if (Directory.Length == 0)
			{
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show("GET: Field \'Directory\' cannot be NULL.");
				}
				return "";
			}
			return UTIL.RemoveSingleQuotes(Directory);
		}
		
		public string getFiletype()
		{
			if (FileType.Length == 0)
			{
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show("GET: Field \'Filetype\' cannot be NULL.");
				}
				return "";
			}
			return UTIL.RemoveSingleQuotes(FileType);
		}
		
		public string getNbrfilesarchived()
		{
			if (NbrFilesArchived.Length == 0)
			{
				NbrFilesArchived = "null";
			}
			return NbrFilesArchived;
		}
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (ArchiveID.Length == 0)
			{
				return false;
			}
			if (Directory.Length == 0)
			{
				return false;
			}
			if (FileType.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			if (ArchiveID.Length == 0)
			{
				return false;
			}
			if (Directory.Length == 0)
			{
				return false;
			}
			if (FileType.Length == 0)
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
			s = s + " INSERT INTO ArchiveHistContentType(";
			s = s + "ArchiveID,";
			s = s + "Directory,";
			s = s + "FileType,";
			s = s + "NbrFilesArchived) values (";
			s = s + "\'" + ArchiveID + "\'" + ",";
			s = s + "\'" + Directory + "\'" + ",";
			s = s + "\'" + FileType + "\'" + ",";
			s = s + NbrFilesArchived + ")";
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
			
			s = s + " update ArchiveHistContentType set ";
			s = s + "ArchiveID = \'" + getArchiveid() + "\'" + ", ";
			s = s + "Directory = \'" + getDirectory() + "\'" + ", ";
			s = s + "FileType = \'" + getFiletype() + "\'" + ", ";
			s = s + "NbrFilesArchived = " + getNbrfilesarchived();
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
			s = s + "ArchiveID,";
			s = s + "Directory,";
			s = s + "FileType,";
			s = s + "NbrFilesArchived ";
			s = s + " FROM ArchiveHistContentType";
			
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
			s = s + "ArchiveID,";
			s = s + "Directory,";
			s = s + "FileType,";
			s = s + "NbrFilesArchived ";
			s = s + " FROM ArchiveHistContentType";
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
			
			s = " Delete from ArchiveHistContentType";
			s = s + WhereClause;
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			s = s + " Delete from ArchiveHistContentType";
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate Index Queries
		public int cnt_PK111(string ArchiveID, string Directory, string FileType)
		{
			
			int B = 0;
			string TBL = "ArchiveHistContentType";
			string WC = "Where ArchiveID = \'" + ArchiveID + "\' and   Directory = \'" + Directory + "\' and   FileType = \'" + FileType + "\'";
			
			B = DB.iGetRowCount(TBL, WC);
			
			return B;
		} //** cnt_PK111
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PK111(string ArchiveID, string Directory, string FileType)
		{
			
			SqlDataReader rsData = null;
			string TBL = "ArchiveHistContentType";
			string WC = "Where ArchiveID = \'" + ArchiveID + "\' and   Directory = \'" + Directory + "\' and   FileType = \'" + FileType + "\'";
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PK111
		
		/// Build Index Where Caluses
		///
		public string wc_PK111(string ArchiveID, string Directory, string FileType)
		{
			
			string WC = "Where ArchiveID = \'" + ArchiveID + "\' and   Directory = \'" + Directory + "\' and   FileType = \'" + FileType + "\'";
			
			return WC;
		} //** wc_PK111
		
		//** Generate the SET methods
		
	}
	
}

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
	public class clsAVAILFILETYPESUNDEFINED
	{
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		
		string FileType = "";
		string SubstituteType = "";
		string Applied = "";
		
		
		//** Generate the SET methods
		public void setFiletype(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Filetype\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			FileType = val;
		}
		
		public void setSubstitutetype(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			SubstituteType = val;
		}
		
		public void setApplied(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = UTIL.RemoveSingleQuotes(val);
			Applied = val;
		}
		
		
		
		//** Generate the GET methods
		public string getFiletype()
		{
			if (FileType.Length == 0)
			{
				MessageBox.Show("GET: Field \'Filetype\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(FileType);
		}
		
		public string getSubstitutetype()
		{
			return UTIL.RemoveSingleQuotes(SubstituteType);
		}
		
		public string getApplied()
		{
			if (Applied.Length == 0)
			{
				Applied = "null";
			}
			return Applied;
		}
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (FileType.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
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
			s = s + " INSERT INTO AvailFileTypesUndefined(";
			s = s + "FileType,";
			s = s + "SubstituteType,";
			s = s + "Applied) values (";
			s = s + "\'" + FileType + "\'" + ",";
			s = s + "\'" + SubstituteType + "\'" + ",";
			s = s + Applied + ")";
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
			
			s = s + " update AvailFileTypesUndefined set ";
			s = s + "FileType = \'" + getFiletype() + "\'" + ", ";
			s = s + "SubstituteType = \'" + getSubstitutetype() + "\'" + ", ";
			s = s + "Applied = " + getApplied();
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
			s = s + "FileType,";
			s = s + "SubstituteType,";
			s = s + "Applied ";
			s = s + " FROM AvailFileTypesUndefined";
			
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
			s = s + "FileType,";
			s = s + "SubstituteType,";
			s = s + "Applied ";
			s = s + " FROM AvailFileTypesUndefined";
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
			
			s = " Delete from AvailFileTypesUndefined";
			s = s + WhereClause;
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			s = s + " Delete from AvailFileTypesUndefined";
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate Index Queries
		public int cnt_PK_AFTU(string FileType)
		{
			
			int B = 0;
			string TBL = "AvailFileTypesUndefined";
			string WC = "Where FileType = \'" + FileType + "\'";
			
			B = DB.iGetRowCount(TBL, WC);
			
			return B;
		} //** cnt_PK_AFTU
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PK_AFTU(string FileType)
		{
			
			SqlDataReader rsData = null;
			string TBL = "AvailFileTypesUndefined";
			string WC = "Where FileType = \'" + FileType + "\'";
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PK_AFTU
		
		/// Build Index Where Caluses
		///
		public string wc_PK_AFTU(string FileType)
		{
			
			string WC = "Where FileType = \'" + FileType + "\'";
			
			return WC;
		} //** wc_PK_AFTU
	}
	
}

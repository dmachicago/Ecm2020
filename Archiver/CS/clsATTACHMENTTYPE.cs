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
	public class clsATTACHMENTTYPE
	{
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		
		string AttachmentCode = "";
		string Description = "";
		string isZipFormat = "";
		
		
		//** Generate the SET methods
		public void setAttachmentcode(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Attachmentcode\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			AttachmentCode = val;
		}
		
		public void setDescription(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			Description = val;
		}
		
		public void setIszipformat(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = UTIL.RemoveSingleQuotes(val);
			isZipFormat = val;
		}
		
		
		
		//** Generate the GET methods
		public string getAttachmentcode()
		{
			if (AttachmentCode.Length == 0)
			{
				MessageBox.Show("GET: Field \'Attachmentcode\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(AttachmentCode);
		}
		
		public string getDescription()
		{
			return UTIL.RemoveSingleQuotes(Description);
		}
		
		public string getIszipformat()
		{
			if (isZipFormat.Length == 0)
			{
				isZipFormat = "null";
			}
			return isZipFormat;
		}
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (AttachmentCode.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			if (AttachmentCode.Length == 0)
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
			
			if (AttachmentCode.Trim().Length > 10)
			{
				AttachmentCode = "UKN";
				Description = "Unknown Attachment Type";
			}
			
			if (isZipFormat.Length == 0)
			{
				isZipFormat = "0";
			}
			
			s = s + " INSERT INTO AttachmentType(";
			s = s + "AttachmentCode,";
			s = s + "Description,";
			s = s + "isZipFormat) values (";
			s = s + "\'" + AttachmentCode + "\'" + ",";
			s = s + "\'" + Description + "\'" + ",";
			s = s + isZipFormat + ")";
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
			
			s = s + " update AttachmentType set ";
			//s = s + "AttachmentCode = '" + getAttachmentcode() + "'" + ", "
			s = s + "Description = \'" + getDescription() + "\'" + ", ";
			s = s + "isZipFormat = " + getIszipformat();
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
			s = s + "AttachmentCode,";
			s = s + "Description,";
			s = s + "isZipFormat ";
			s = s + " FROM AttachmentType";
			
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
			s = s + "AttachmentCode,";
			s = s + "Description,";
			s = s + "isZipFormat ";
			s = s + " FROM AttachmentType";
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
			
			s = " Delete from AttachmentType";
			s = s + WhereClause;
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			s = s + " Delete from AttachmentType";
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate Index Queries
		public int cnt_PK29(string AttachmentCode)
		{
			
			int B = 0;
			string TBL = "AttachmentType";
			string WC = "Where AttachmentCode = \'" + AttachmentCode + "\'";
			
			B = DB.iGetRowCount(TBL, WC);
			
			return B;
		} //** cnt_PK29
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PK29(string AttachmentCode)
		{
			
			SqlDataReader rsData = null;
			string TBL = "AttachmentType";
			string WC = "Where AttachmentCode = \'" + AttachmentCode + "\'";
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PK29
		
		/// Build Index Where Caluses
		///
		public string wc_PK29(string AttachmentCode)
		{
			
			string WC = "Where AttachmentCode = \'" + AttachmentCode + "\'";
			
			return WC;
		} //** wc_PK29
		
		//** Generate the SET methods
		
	}
	
}

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
	public class clsSAVEDITEMS
	{
		
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		
		
		string Userid = "";
		string SaveName = "";
		string SaveTypeCode = "";
		string ValName = "";
		string ValValue = "";
		
		
		
		
		//** Generate the SET methods
		public void setUserid(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Userid\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			Userid = val;
		}
		
		
		public void setSavename(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Savename\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			SaveName = val;
		}
		
		
		public void setSavetypecode(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Savetypecode\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			SaveTypeCode = val;
		}
		
		
		public void setValname(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Valname\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			ValName = val;
		}
		
		
		public void setValvalue(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Valvalue\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			ValValue = val;
		}
		
		
		
		
		
		
		//** Generate the GET methods
		public string getUserid()
		{
			if (Userid.Length == 0)
			{
				MessageBox.Show("GET: Field \'Userid\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(Userid);
		}
		
		
		public string getSavename()
		{
			if (SaveName.Length == 0)
			{
				MessageBox.Show("GET: Field \'Savename\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(SaveName);
		}
		
		
		public string getSavetypecode()
		{
			if (SaveTypeCode.Length == 0)
			{
				MessageBox.Show("GET: Field \'Savetypecode\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(SaveTypeCode);
		}
		
		
		public string getValname()
		{
			if (ValName.Length == 0)
			{
				MessageBox.Show("GET: Field \'Valname\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(ValName);
		}
		
		
		public string getValvalue()
		{
			if (ValValue.Length == 0)
			{
				MessageBox.Show("GET: Field \'Valvalue\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(ValValue);
		}
		
		
		
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (Userid.Length == 0)
			{
				return false;
			}
			if (SaveName.Length == 0)
			{
				return false;
			}
			if (SaveTypeCode.Length == 0)
			{
				return false;
			}
			if (ValName.Length == 0)
			{
				return false;
			}
			if (ValValue.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			if (Userid.Length == 0)
			{
				return false;
			}
			if (SaveName.Length == 0)
			{
				return false;
			}
			if (SaveTypeCode.Length == 0)
			{
				return false;
			}
			if (ValName.Length == 0)
			{
				return false;
			}
			if (ValValue.Length == 0)
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
			s = s + " INSERT INTO SavedItems(";
			s = s + "Userid,";
			s = s + "SaveName,";
			s = s + "SaveTypeCode,";
			s = s + "ValName,";
			s = s + "ValValue) values (";
			s = s + "\'" + Userid + "\'" + ",";
			s = s + "\'" + SaveName + "\'" + ",";
			s = s + "\'" + SaveTypeCode + "\'" + ",";
			s = s + "\'" + ValName + "\'" + ",";
			s = s + "\'" + ValValue + "\'" + ")";
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
			
			
			s = s + " update SavedItems set ";
			s = s + "Userid = \'" + getUserid() + "\'" + ", ";
			s = s + "SaveName = \'" + getSavename() + "\'" + ", ";
			s = s + "SaveTypeCode = \'" + getSavetypecode() + "\'" + ", ";
			s = s + "ValName = \'" + getValname() + "\'" + ", ";
			s = s + "ValValue = \'" + getValvalue() + "\'";
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
			s = s + "Userid,";
			s = s + "SaveName,";
			s = s + "SaveTypeCode,";
			s = s + "ValName,";
			s = s + "ValValue ";
			s = s + " FROM SavedItems";
			
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
			s = s + "Userid,";
			s = s + "SaveName,";
			s = s + "SaveTypeCode,";
			s = s + "ValName,";
			s = s + "ValValue ";
			s = s + " FROM SavedItems";
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
			
			
			s = " Delete from SavedItems";
			s = s + WhereClause;
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			
			s = s + " Delete from SavedItems";
			
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
			
		}
		
		
		
		
		//** Generate Index Queries
		public int cnt_PK_SavedItems(string SaveName, string SaveTypeCode, string Userid, string ValName)
		{
			
			
			int B = 0;
			string TBL = "SavedItems";
			string WC = "Where SaveName = \'" + SaveName + "\' and   SaveTypeCode = \'" + SaveTypeCode + "\' and   Userid = \'" + Userid + "\' and   ValName = \'" + ValName + "\'";
			
			
			B = DB.iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_PK_SavedItems
		
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PK_SavedItems(string SaveName, string SaveTypeCode, string Userid, string ValName)
		{
			
			
			SqlDataReader rsData = null;
			string TBL = "SavedItems";
			string WC = "Where SaveName = \'" + SaveName + "\' and   SaveTypeCode = \'" + SaveTypeCode + "\' and   Userid = \'" + Userid + "\' and   ValName = \'" + ValName + "\'";
			
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PK_SavedItems
		
		
		/// Build Index Where Caluses
		///
		public string wc_PK_SavedItems(string SaveName, string SaveTypeCode, string Userid, string ValName)
		{
			
			
			string WC = "Where SaveName = \'" + SaveName + "\' and   SaveTypeCode = \'" + SaveTypeCode + "\' and   Userid = \'" + Userid + "\' and   ValName = \'" + ValName + "\'";
			
			
			return WC;
		} //** wc_PK_SavedItems
	}
	
}

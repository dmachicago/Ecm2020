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
	public class clsATTRIBUTES
	{
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		
		string AttributeName = "";
		string AttributeDataType = "";
		string AttributeDesc = "";
		string AssoApplication = "";
		string AllowedValues = "";
		
		
		//** Generate the SET methods
		public void setAttributename(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Attributename\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			AttributeName = val;
		}
		
		public void setAttributedatatype(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Attributedatatype\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			AttributeDataType = val;
		}
		
		public void setAttributedesc(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			AttributeDesc = val;
		}
		
		public void setAssoapplication(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			AssoApplication = val;
		}
		
		public void setAllowedvalues(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			AllowedValues = val;
		}
		
		
		
		//** Generate the GET methods
		public string getAttributename()
		{
			if (AttributeName.Length == 0)
			{
				MessageBox.Show("GET: Field \'Attributename\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(AttributeName);
		}
		
		public string getAttributedatatype()
		{
			if (AttributeDataType.Length == 0)
			{
				MessageBox.Show("GET: Field \'Attributedatatype\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(AttributeDataType);
		}
		
		public string getAttributedesc()
		{
			return UTIL.RemoveSingleQuotes(AttributeDesc);
		}
		
		public string getAssoapplication()
		{
			return UTIL.RemoveSingleQuotes(AssoApplication);
		}
		
		public string getAllowedvalues()
		{
			return UTIL.RemoveSingleQuotes(AllowedValues);
		}
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (AttributeName.Length == 0)
			{
				return false;
			}
			if (AttributeDataType.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			if (AttributeName.Length == 0)
			{
				return false;
			}
			if (AttributeDataType.Length == 0)
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
			s = s + " INSERT INTO Attributes(";
			s = s + "AttributeName,";
			s = s + "AttributeDataType,";
			s = s + "AttributeDesc,";
			s = s + "AssoApplication,";
			s = s + "AllowedValues) values (";
			s = s + "\'" + AttributeName + "\'" + ",";
			s = s + "\'" + AttributeDataType + "\'" + ",";
			s = s + "\'" + AttributeDesc + "\'" + ",";
			s = s + "\'" + AssoApplication + "\'" + ",";
			s = s + "\'" + AllowedValues + "\'" + ")";
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
			
			s = s + " update Attributes set ";
			//s = s + "AttributeName = '" + getAttributename() + "'" + ", "
			s = s + "AttributeDataType = \'" + getAttributedatatype() + "\'" + ", ";
			s = s + "AttributeDesc = \'" + getAttributedesc() + "\'" + ", ";
			s = s + "AssoApplication = \'" + getAssoapplication() + "\'" + ", ";
			s = s + "AllowedValues = \'" + getAllowedvalues() + "\'";
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
			s = s + "AttributeName,";
			s = s + "AttributeDataType,";
			s = s + "AttributeDesc,";
			s = s + "AssoApplication,";
			s = s + "AllowedValues ";
			s = s + " FROM Attributes";
			//** s=s+ "ORDERBY xxxx"
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
			s = s + "AttributeName,";
			s = s + "AttributeDataType,";
			s = s + "AttributeDesc,";
			s = s + "AssoApplication,";
			s = s + "AllowedValues ";
			s = s + " FROM Attributes";
			s = s + WhereClause;
			//** s=s+ "ORDERBY xxxx"
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
			
			s = " Delete from Attributes";
			s = s + WhereClause;
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			s = s + " Delete from Attributes";
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate Index Queries
		public int cnt_PK36(string AttributeName)
		{
			
			int B = 0;
			string TBL = "Attributes";
			string WC = "Where AttributeName = \'" + AttributeName + "\'";
			
			B = DB.iGetRowCount(TBL, WC);
			
			return B;
		} //** cnt_PK36
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PK36(string AttributeName)
		{
			
			SqlDataReader rsData = null;
			string TBL = "Attributes";
			string WC = "Where AttributeName = \'" + AttributeName + "\'";
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PK36
		
		/// Build Index Where Caluses
		///
		public string wc_PK36(string AttributeName)
		{
			
			string WC = "Where AttributeName = \'" + AttributeName + "\'";
			
			return WC;
		} //** wc_PK36
		
		//** Generate the SET methods
		
	}
	
}

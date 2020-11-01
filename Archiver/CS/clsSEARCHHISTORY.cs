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
	public class clsSEARCHHISTORY
	{
		
		//** DIM the selected table columns
		clsDatabase DB = new clsDatabase();
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		string SearchSql = "";
		string SearchDate = "";
		string UserID = "";
		string RowID = "";
		string ReturnedRows = "";
		string StartTime = "";
		string EndTime = "";
		string CalledFrom = "";
		string TypeSearch = "";
		
		
		//** Generate the SET methods
		public void setSearchsql(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			SearchSql = val;
		}
		
		public void setSearchdate(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			SearchDate = val;
		}
		
		public void setUserid(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			UserID = val;
		}
		
		public void setReturnedrows(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = UTIL.RemoveSingleQuotes(val);
			ReturnedRows = val;
		}
		
		public void setStarttime(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			StartTime = val;
		}
		
		public void setEndtime(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			EndTime = val;
		}
		
		public void setCalledfrom(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			CalledFrom = val;
		}
		
		public void setTypesearch(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			TypeSearch = val;
		}
		
		
		
		//** Generate the GET methods
		public string getSearchsql()
		{
			return UTIL.RemoveSingleQuotes(SearchSql);
		}
		
		public string getSearchdate()
		{
			return UTIL.RemoveSingleQuotes(SearchDate);
		}
		
		public string getUserid()
		{
			return UTIL.RemoveSingleQuotes(UserID);
		}
		
		//Public Function getRowid() As String
		//    If Len(RowID) = 0 Then
		//        messagebox.show("GET: Field 'Rowid' cannot be NULL.")
		//        Return ""
		//    End If
		//    If Len(RowID) = 0 Then
		//        RowID = "null"
		//    End If
		//    Return RowID
		//End Function
		
		public string getReturnedrows()
		{
			if (ReturnedRows.Length == 0)
			{
				ReturnedRows = "null";
			}
			return ReturnedRows;
		}
		
		public string getStarttime()
		{
			return UTIL.RemoveSingleQuotes(StartTime);
		}
		
		public string getEndtime()
		{
			return UTIL.RemoveSingleQuotes(EndTime);
		}
		
		public string getCalledfrom()
		{
			return UTIL.RemoveSingleQuotes(CalledFrom);
		}
		
		public string getTypesearch()
		{
			return UTIL.RemoveSingleQuotes(TypeSearch);
		}
		
		
		
		//** Generate the Required Fields Validation method
		//Public Function ValidateReqData() As Boolean
		//    If RowID.Length = 0 Then Return False
		//    Return True
		//End Function
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			return true;
		}
		
		
		//** Generate the INSERT method
		public bool Insert()
		{
			bool b = false;
			string s = "";
			if (ReturnedRows.Length == 0)
			{
				ReturnedRows = "-1";
			}
			s = s + " INSERT INTO SearchHistory(";
			s = s + "SearchSql,";
			s = s + "SearchDate,";
			s = s + "UserID,";
			s = s + "ReturnedRows,";
			s = s + "StartTime,";
			s = s + "EndTime,";
			s = s + "CalledFrom,";
			s = s + "TypeSearch) values (";
			s = s + "\'" + SearchSql + "\'" + ",";
			s = s + "\'" + SearchDate + "\'" + ",";
			s = s + "\'" + UserID + "\'" + ",";
			//s = s + RowID + ","
			s = s + ReturnedRows + ",";
			s = s + "\'" + StartTime + "\'" + ",";
			s = s + "\'" + EndTime + "\'" + ",";
			s = s + "\'" + CalledFrom + "\'" + ",";
			s = s + "\'" + TypeSearch + "\'" + ")";
			b = DB.ExecuteSqlNewConn(s, false);
			if (b == false)
			{
				Console.WriteLine("Error clsSearchHistory Insert");
			}
			return b;
			
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
			
			s = s + " update SearchHistory set ";
			s = s + "SearchSql = \'" + getSearchsql() + "\'" + ", ";
			s = s + "SearchDate = \'" + getSearchdate() + "\'" + ", ";
			s = s + "UserID = \'" + getUserid() + "\'" + ", ";
			s = s + "ReturnedRows = " + getReturnedrows() + ", ";
			s = s + "StartTime = \'" + getStarttime() + "\'" + ", ";
			s = s + "EndTime = \'" + getEndtime() + "\'" + ", ";
			s = s + "CalledFrom = \'" + getCalledfrom() + "\'" + ", ";
			s = s + "TypeSearch = \'" + getTypesearch() + "\'";
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
			s = s + "SearchSql,";
			s = s + "SearchDate,";
			s = s + "UserID,";
			s = s + "RowID,";
			s = s + "ReturnedRows,";
			s = s + "StartTime,";
			s = s + "EndTime,";
			s = s + "CalledFrom,";
			s = s + "TypeSearch ";
			s = s + " FROM SearchHistory";
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
			s = s + "SearchSql,";
			s = s + "SearchDate,";
			s = s + "UserID,";
			s = s + "RowID,";
			s = s + "ReturnedRows,";
			s = s + "StartTime,";
			s = s + "EndTime,";
			s = s + "CalledFrom,";
			s = s + "TypeSearch ";
			s = s + " FROM SearchHistory";
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
			
			s = " Delete from SearchHistory";
			s = s + WhereClause;
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			s = s + " Delete from SearchHistory";
			
			b = DB.ExecuteSqlNewConn(s, false);
			return b;
			
		}
		
		
		//** Generate Index Queries
		public int cnt_PK_SearchHist(int RowID)
		{
			
			int B = 0;
			string TBL = "SearchHistory";
			string WC = "Where RowID = " + RowID.ToString();
			
			B = DB.iGetRowCount(TBL, WC);
			
			return B;
		} //** cnt_PK_SearchHist
		
		//** Generate Index ROW Queries
		public SqlDataReader getRow_PK_SearchHist(int RowID)
		{
			
			SqlDataReader rsData = null;
			string TBL = "SearchHistory";
			string WC = "Where RowID = " + RowID.ToString();
			
			rsData = DB.GetRowByKey(TBL, WC);
			
			if (rsData.HasRows)
			{
				return rsData;
			}
			else
			{
				return null;
			}
		} //** getRow_PK_SearchHist
		
		/// Build Index Where Caluses
		///
		public string wc_PK_SearchHist(int RowID)
		{
			
			string WC = "Where RowID = " + RowID.ToString();
			
			return WC;
		} //** wc_PK_SearchHist
		
		//** Generate the SET methods
		
	}
	
}

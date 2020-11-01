// VBConversions Note: VB project level imports
using System.Windows.Input;
using System.Windows.Data;
using System.Windows.Documents;
using System.Xml.Linq;
using System.Collections.Generic;
using System.Windows.Navigation;
using System.Windows.Media.Imaging;
using System.Windows;
using Microsoft.VisualBasic;
using System.Windows.Media;
using System.Collections;
using System;
using System.Windows.Shapes;
using System.Windows.Controls;
using System.Threading.Tasks;
using System.Linq;
using System.Diagnostics;
// End of VB project level imports

using System.Configuration;
using System.IO;

//Imports System.Data.SqlClient
//Imports System.Data.Sql

namespace ECMSearchWPF
{
	public class clsSEARCHHISTORY
	{
		
		
		//Dim proxy As New SVCSearch.Service1Client
		//** DIM the selected table columns
		//Dim DB As New clsDatabase
		
		//Dim EP As New clsEndPoint
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		clsEncryptV2 ENC2 = new clsEncryptV2();
		
		string SearchSql = "";
		string SearchDate = "";
		string UserID = "";
		string RowID = "";
		string ReturnedRows = "";
		string StartTime = "";
		string EndTime = "";
		string CalledFrom = "";
		string TypeSearch = "";
		
		string SecureID;
		public clsSEARCHHISTORY()
		{
			SecureID = SecureID;
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
			//EP.setSearchSvcEndPoint(proxy)
			
		}
		
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
		//        MsgBox("GET: Field 'Rowid' cannot be NULL.")
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
		public bool Insert(string SearchSql)
		{
			bool b = false;
			string s = "";
			string SearchSqlCopy = SearchSql;
			SearchSqlCopy.Replace("\'", "`");
			if (SearchSqlCopy.IndexOf("\'") + 1 > 0)
			{
				for (int II = 1; II <= SearchSqlCopy.Length; II++)
				{
					string CH = SearchSqlCopy.Substring(II - 1, 1);
					if (CH.Equals("\'"))
					{
						modGlobals.MidX(SearchSqlCopy, II, "`");
					}
				}
			}
			
			if (ReturnedRows.Length == 0)
			{
				ReturnedRows = "-1";
			}
			s = s + " INSERT INTO SearchHistory(" + "\r\n";
			s = s + "SearchSql," + "\r\n";
			s = s + "SearchDate," + "\r\n";
			s = s + "UserID," + "\r\n";
			s = s + "ReturnedRows," + "\r\n";
			s = s + "StartTime," + "\r\n";
			s = s + "EndTime," + "\r\n";
			s = s + "CalledFrom," + "\r\n";
			s = s + "TypeSearch) values (" + "\r\n";
			s = s + "\'" + SearchSqlCopy + "\'" + "," + "\r\n";
			s = s + "getdate()" + "," + "\r\n";
			s = s + "\'" + UserID + "\'" + "," + "\r\n";
			s = s + ReturnedRows + "," + "\r\n";
			s = s + "\'" + (DateTime.Parse(StartTime)).ToString() + "\'" + "," + "\r\n";
			s = s + "\'" + EndTime + "\'" + "," + "\r\n";
			s = s + "\'" + CalledFrom + "\'" + "," + "\r\n";
			s = s + "\'" + TypeSearch + "\'" + ")";
			
			
			//AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn
			//EP.setSearchSvcEndPoint(proxy)
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			
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
			
			//AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn
			//EP.setSearchSvcEndPoint(proxy)
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			
			return true;
		}
		
		
		//'** Generate the SELECT method
		//Public Function SelectRecs() As SqlDataReader
		//    Dim b As Boolean = False
		//    Dim s As String = ""
		//    Dim rsData As SqlDataReader
		//    s = s + " SELECT "
		//    s = s + "SearchSql,"
		//    s = s + "SearchDate,"
		//    s = s + "UserID,"
		//    s = s + "RowID,"
		//    s = s + "ReturnedRows,"
		//    s = s + "StartTime,"
		//    s = s + "EndTime,"
		//    s = s + "CalledFrom,"
		//    s = s + "TypeSearch "
		//    s = s + " FROM SearchHistory"
		//    '** s=s+ "ORDERBY xxxx"
		//    Dim CS$ = db.getConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata = command.ExecuteReader()
		//    Return rsData
		//End Function
		
		
		//'** Generate the Select One Row method
		//Public Function SelectOne(ByVal WhereClause as string) As SqlDataReader
		//    Dim b As Boolean = False
		//    Dim s As String = ""
		//    Dim rsData As SqlDataReader
		//    s = s + " SELECT "
		//    s = s + "SearchSql,"
		//    s = s + "SearchDate,"
		//    s = s + "UserID,"
		//    s = s + "RowID,"
		//    s = s + "ReturnedRows,"
		//    s = s + "StartTime,"
		//    s = s + "EndTime,"
		//    s = s + "CalledFrom,"
		//    s = s + "TypeSearch "
		//    s = s + " FROM SearchHistory"
		//    s = s + WhereClause
		//    '** s=s+ "ORDERBY xxxx"
		//    Dim CS$ = db.getConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata = command.ExecuteReader()
		//    Return rsData
		//End Function
		
		
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
			
			
			//AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn
			//EP.setSearchSvcEndPoint(proxy)
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			
			return b;
			
		}
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			s = s + " Delete from SearchHistory";
			
			//AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn
			//EP.setSearchSvcEndPoint(proxy)
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			
			return b;
			
		}
		
		
		//'** Generate Index Queries
		//Public Function cnt_PK_SearchHist(ByVal RowID As Integer) As Integer
		
		//    Dim B As Integer = 0
		//    Dim TBL$ = "SearchHistory"
		//    Dim WC$ = "Where RowID = " & RowID
		
		//    B = DB.iGetRowCount(TBL$, WC)
		
		//    Return B
		//End Function     '** cnt_PK_SearchHist
		
		//'** Generate Index ROW Queries
		//Public Function getRow_PK_SearchHist(ByVal RowID As Integer) As SqlDataReader
		
		//    Dim rsData As SqlDataReader = Nothing
		//    Dim TBL$ = "SearchHistory"
		//    Dim WC$ = "Where RowID = " & RowID
		
		//    rsData = DB.GetRowByKey(TBL$, WC)
		
		//    If rsData.HasRows Then
		//        Return rsData
		//    Else
		//        Return Nothing
		//    End If
		//End Function     '** getRow_PK_SearchHist
		
		// ''' Build Index Where Caluses
		// '''
		//Public Function wc_PK_SearchHist(ByVal RowID As Integer) As String
		
		//    Dim WC$ = "Where RowID = " & RowID
		
		//    Return WC
		//End Function     '** wc_PK_SearchHist
		
		//'** Generate the SET methods
		
		public void client_ExecuteSqlNewConn(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			if (e.Error == null)
			{
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR clsSearchHistory: client_ExecuteSqlNewConn: " + e.Error.Message));
			}
		}
		~clsSEARCHHISTORY()
		{
			try
			{
				
			}
			finally
			{
				base.Finalize(); //define the destructor
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn);
				
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
		}
		
		private void setXXSearchSvcEndPoint()
		{
			
			if (GLOBALS.SearchEndPoint.Length == 0)
			{
				return;
			}
			
			Uri ServiceUri = new Uri(GLOBALS.SearchEndPoint);
			System.ServiceModel.EndpointAddress EPA = new System.ServiceModel.EndpointAddress(ServiceUri, null);
			
			GLOBALS.ProxySearch.Endpoint.Address = EPA;
			GC.Collect();
			GC.WaitForPendingFinalizers();
		}
		
	}
	
}

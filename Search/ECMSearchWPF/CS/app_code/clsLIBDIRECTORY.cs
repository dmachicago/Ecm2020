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
	public class clsLIBDIRECTORY
	{
		
		
		//Dim proxy As New SVCSearch.Service1Client
		//Dim EP As New clsEndPoint
		//** DIM the selected table columns
		//Dim DB As New clsDatabase
		//Dim DMA As New clsDma
		//Dim UTIL As New clsUtility
		clsLogging LOG = new clsLogging();
		clsEncryptV2 ENC2 = new clsEncryptV2();
		
		string DirectoryName = "";
		string UserID = "";
		string LibraryName = "";
		string SecureID = "-1";
		
		public clsLIBDIRECTORY()
		{
			
			SecureID = GLOBALS._SecureID.ToString();
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
			//EP.setSearchSvcEndPoint(proxy)
			
		}
		
		//** Generate the SET methods
		public void setDirectoryname(ref string val)
		{
			if (val.Length == 0)
			{
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show("SET: clsLIBDIRECTORYField \'Directoryname\' cannot be NULL.");
				}
				return;
			}
			val = val.Replace("\'\'", "\'");
			val = val.Replace("\'", "\'\'");
			DirectoryName = val;
		}
		
		
		public void setUserid(ref string val)
		{
			if (val.Length == 0)
			{
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show("SET: clsLIBDIRECTORYField \'Userid\' cannot be NULL.");
				}
				return;
			}
			val = val.Replace("\'\'", "\'");
			val = val.Replace("\'", "\'\'");
			UserID = val;
		}
		
		
		public void setLibraryname(ref string val)
		{
			if (val.Length == 0)
			{
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show("SET: clsLIBDIRECTORYField \'Libraryname\' cannot be NULL.");
				}
				return;
			}
			val = val.Replace("\'\'", "\'");
			val = val.Replace("\'", "\'\'");
			LibraryName = val;
		}
		
		//** Generate the GET methods
		public string getDirectoryname()
		{
			if (DirectoryName.Length == 0)
			{
				if (modGlobals.gRunUnattended == false)
				{
					if (modGlobals.gRunUnattended == false)
					{
						MessageBox.Show("GET: clsLIBDIRECTORYField Field \'Directoryname\' cannot be NULL.");
					}
				}
				return "";
			}
			return DirectoryName.Replace("\'\'", "\'");
		}
		
		
		public string getUserid()
		{
			if (UserID.Length == 0)
			{
				if (modGlobals.gRunUnattended == false)
				{
					if (modGlobals.gRunUnattended == false)
					{
						MessageBox.Show("GET: clsLIBDIRECTORYField Field \'Userid\' cannot be NULL.");
					}
				}
				return "";
			}
			return UserID.Replace("\'\'", "\'");
		}
		
		
		public string getLibraryname()
		{
			if (LibraryName.Length == 0)
			{
				if (modGlobals.gRunUnattended == false)
				{
					if (modGlobals.gRunUnattended == false)
					{
						MessageBox.Show("GET: clsLIBDIRECTORYField Field \'Libraryname\' cannot be NULL.");
					}
				}
				return "";
			}
			return LibraryName.Replace("\'\'", "\'");
		}
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (DirectoryName.Length == 0)
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
			if (DirectoryName.Length == 0)
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
			s = s + " INSERT INTO LibDirectory(";
			s = s + "DirectoryName,";
			s = s + "UserID,";
			s = s + "LibraryName) values (";
			s = s + "\'" + DirectoryName + "\'" + ",";
			s = s + "\'" + UserID + "\'" + ",";
			s = s + "\'" + LibraryName + "\'" + ")";
			
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			return true;
			
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
			
			
			s = s + " update LibDirectory set ";
			s = s + "DirectoryName = \'" + getDirectoryname() + "\'" + ", ";
			s = s + "UserID = \'" + getUserid() + "\'" + ", ";
			s = s + "LibraryName = \'" + getLibraryname() + "\'";
			WhereClause = (string) (" " + WhereClause);
			s = s + WhereClause;
			
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
		//    s = s + "DirectoryName,"
		//    s = s + "UserID,"
		//    s = s + "LibraryName "
		//    s = s + " FROM LibDirectory"
		
		//    Dim CS$ = db.getConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata = command.ExecuteReader()
		//    Return rsData
		//End Function
		
		
		
		
		//'** Generate the Select One Row method
		//Public Function SelectOne(ByVal WhereClause as string) As SqlDataReader
		//    Dim b As Boolean = False
		//    Dim s As String = ""
		//    Dim rsData As SqlDataReader
		//    s = s + " SELECT "
		//    s = s + "DirectoryName,"
		//    s = s + "UserID,"
		//    s = s + "LibraryName "
		//    s = s + " FROM LibDirectory"
		//    s = s + WhereClause
		
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
			
			
			s = " Delete from LibDirectory";
			s = s + WhereClause;
			
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			return true;
			
			
		}
		
		
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			
			s = s + " Delete from LibDirectory";
			
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			return true;
			
			
		}
		
		
		
		
		//'** Generate Index Queries
		//Public Function cnt_PK98(ByVal DirectoryName As String, ByVal LibraryName As String, ByVal UserID As String) As Integer
		
		
		//    Dim B As Integer = 0
		//    Dim TBL$ = "LibDirectory"
		//    Dim WC$ = "Where DirectoryName = '" + DirectoryName + "' and   LibraryName = '" + LibraryName + "' and   UserID = '" + UserID + "'"
		
		
		//    B = DB.iGetRowCount(TBL$, WC)
		
		
		//    Return B
		//End Function     '** cnt_PK98
		
		
		//'** Generate Index ROW Queries
		//Public Function getRow_PK98(ByVal DirectoryName As String, ByVal LibraryName As String, ByVal UserID As String) As SqlDataReader
		
		
		//    Dim rsData As SqlDataReader = Nothing
		//    Dim TBL$ = "LibDirectory"
		//    Dim WC$ = "Where DirectoryName = '" + DirectoryName + "' and   LibraryName = '" + LibraryName + "' and   UserID = '" + UserID + "'"
		
		
		//    rsData = DB.GetRowByKey(TBL$, WC)
		
		
		//    If rsData.HasRows Then
		//        Return rsData
		//    Else
		//        Return Nothing
		//    End If
		//End Function     '** getRow_PK98
		
		
		/// Build Index Where Caluses
		///
		public string wc_PK98(string DirectoryName, string LibraryName, string UserID)
		{
			
			
			//Dim WC$ = "Where DirectoryName = '" + DirectoryName + "' and   LibraryName = '" + LibraryName + "' and   UserID = '" + UserID + "'"
			var WC = "Where DirectoryName = \'" + DirectoryName + "\' and   LibraryName = \'" + LibraryName + "\' ";
			
			
			return WC;
		} //** wc_PK98
		
		
		public void client_ExecuteSqlNewConn(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				
			}
			else
			{
				string ErrSql = (string) e.MySql;
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR PageLibrary 100: " + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR PageLibrary 100: " + ErrSql));
			}
		}
		
		~clsLIBDIRECTORY()
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

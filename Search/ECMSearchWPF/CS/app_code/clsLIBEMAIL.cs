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
	public class clsLIBEMAIL
	{
		
		
		//Dim proxy As New SVCSearch.Service1Client
		//Dim EP As New clsEndPoint
		clsEncryptV2 ENC2 = new clsEncryptV2();
		//** DIM the selected table columns
		//Dim DB As New clsDatabase
		//Dim DMA As New clsDma
		//Dim UTIL As New clsUtility
		
		string EmailFolderEntryID = "";
		string UserID = "";
		string LibraryName = "";
		string FolderName = "";
		clsLogging LOG = new clsLogging();
		
		string SecureID = "-1";
		public clsLIBEMAIL()
		{
			
			SecureID = GLOBALS._SecureID.ToString();
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
			//EP.setSearchSvcEndPoint(proxy)
			
		}
		
		//** Generate the SET methods
		public void setEmailfolderentryid(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: clsLIBEMAIL - Field \'Emailfolderentryid\' cannot be NULL.");
				return;
			}
			val = val.Replace("\'\'", "\'");
			val = val.Replace("\'", "\'\'");
			EmailFolderEntryID = val;
		}
		
		
		public void setUserid(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: clsLIBEMAIL - Field \'Userid\' cannot be NULL.");
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
				MessageBox.Show("SET: clsLIBEMAIL - Field \'Libraryname\' cannot be NULL.");
				return;
			}
			val = val.Replace("\'\'", "\'");
			val = val.Replace("\'", "\'\'");
			LibraryName = val;
		}
		
		
		public void setFoldername(ref string val)
		{
			val = val.Replace("\'\'", "\'");
			val = val.Replace("\'", "\'\'");
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
			return EmailFolderEntryID == EmailFolderEntryID.Replace("\'\'", "\'");
		}
		
		
		public string getUserid()
		{
			if (UserID.Length == 0)
			{
				MessageBox.Show("GET: Field \'Userid\' cannot be NULL.");
				return "";
			}
			return UserID.Replace("\'\'", "\'");
		}
		
		
		public string getLibraryname()
		{
			if (LibraryName.Length == 0)
			{
				MessageBox.Show("GET: Field \'Libraryname\' cannot be NULL.");
				return "";
			}
			return LibraryName.Replace("\'\'", "\'");
		}
		
		
		public string getFoldername()
		{
			return FolderName.Replace("\'\'", "\'");
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
			
			
			s = s + " update LibEmail set ";
			s = s + "EmailFolderEntryID = \'" + getEmailfolderentryid() + "\'" + ", ";
			s = s + "UserID = \'" + getUserid() + "\'" + ", ";
			s = s + "LibraryName = \'" + getLibraryname() + "\'" + ", ";
			s = s + "FolderName = \'" + getFoldername() + "\'";
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
		//    s = s + "EmailFolderEntryID,"
		//    s = s + "UserID,"
		//    s = s + "LibraryName,"
		//    s = s + "FolderName "
		//    s = s + " FROM LibEmail"
		
		//    Dim CS$ = db.getConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata = command.ExecuteReader()
		//    Return rsData
		//End Function
		
		
		
		
		//'** Generate the Select One Row method
		//Public Function SelectOne(ByVal WhereClause as string) As SqlDataReader
		//    Dim b As Boolean = False
		//    Dim s As String = ""
		//    Dim rsData As SqlDataReader
		//    s = s + " SELECT "
		//    s = s + "EmailFolderEntryID,"
		//    s = s + "UserID,"
		//    s = s + "LibraryName,"
		//    s = s + "FolderName "
		//    s = s + " FROM LibEmail"
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
			
			
			s = " Delete from LibEmail ";
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
			
			
			s = s + " Delete from LibEmail";
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			return true;
			
		}
		
		
		
		
		//'** Generate Index Queries
		//Public Function cnt_PI01_LibEmail(ByVal FolderName As String, ByVal LibraryName as string) As Integer
		
		
		//    Dim B As Integer = 0
		//    Dim TBL$ = "LibEmail"
		//    'Dim WC$ = "Where EmailFolderEntryID = '" + EmailFolderEntryID + "' and   FolderName = '" + FolderName + "'"
		//    Dim WC$ = "Where FolderName = '" + FolderName + "' and   LibraryName = '" + LibraryName + "'"
		
		
		//    B = DB.iGetRowCount(TBL$, WC)
		
		
		//    Return B
		//End Function     '** cnt_PI01_LibEmail
		
		//Public Function cnt_PK99(ByVal EmailFolderEntryID As String, ByVal LibraryName As String, ByVal UserID As String) As Integer
		
		
		//    Dim B As Integer = 0
		//    Dim TBL$ = "LibEmail"
		//    Dim WC$ = "Where EmailFolderEntryID = '" + EmailFolderEntryID + "' and   LibraryName = '" + LibraryName + "' and   UserID = '" + UserID + "'"
		
		
		//    B = DB.iGetRowCount(TBL$, WC)
		
		
		//    Return B
		//End Function     '** cnt_PK99
		
		
		//'** Generate Index ROW Queries
		//Public Function getRow_PI01_LibEmail(ByVal EmailFolderEntryID As String, ByVal FolderName As String) As SqlDataReader
		
		
		//    Dim rsData As SqlDataReader = Nothing
		//    Dim TBL$ = "LibEmail"
		//    Dim WC$ = "Where EmailFolderEntryID = '" + EmailFolderEntryID + "' and   FolderName = '" + FolderName + "'"
		
		
		//    rsData = DB.GetRowByKey(TBL$, WC)
		
		
		//    If rsData.HasRows Then
		//        Return rsData
		//    Else
		//        Return Nothing
		//    End If
		//End Function     '** getRow_PI01_LibEmail
		//Public Function getRow_PK99(ByVal EmailFolderEntryID As String, ByVal LibraryName As String, ByVal UserID As String) As SqlDataReader
		
		
		//    Dim rsData As SqlDataReader = Nothing
		//    Dim TBL$ = "LibEmail"
		//    Dim WC$ = "Where EmailFolderEntryID = '" + EmailFolderEntryID + "' and   LibraryName = '" + LibraryName + "' and   UserID = '" + UserID + "'"
		
		
		//    rsData = DB.GetRowByKey(TBL$, WC)
		
		
		//    If rsData.HasRows Then
		//        Return rsData
		//    Else
		//        Return Nothing
		//    End If
		//End Function     '** getRow_PK99
		
		
		// ''' Build Index Where Caluses
		// '''
		//Public Function wc_PI01_LibEmail(ByVal EmailFolderEntryID As String, ByVal FolderName As String) As String
		
		
		//    Dim WC$ = "Where EmailFolderEntryID = '" + EmailFolderEntryID + "' and   FolderName = '" + FolderName + "'"
		
		
		//    Return WC
		//End Function     '** wc_PI01_LibEmail
		//Public Function wc_PK99(ByVal FolderName As String, ByVal LibraryName As String, ByVal UserID As String) As String
		
		
		//    Dim WC$ = "Where FolderName = '" + FolderName + "' and   LibraryName = '" + LibraryName + "' and   UserID = '" + UserID + "'"
		
		
		//    Return WC
		//End Function     '** wc_PK99
		
		
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
				LOG.WriteToSqlLog((string) ("ERROR clsLibEmail 100: " + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR clsLibEmail 100: " + ErrSql));
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

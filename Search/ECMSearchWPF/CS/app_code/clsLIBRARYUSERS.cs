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
	public class clsLIBRARYUSERS
	{
		
		
		//Dim proxy As New SVCSearch.Service1Client
		
		//** DIM the selected table columns
		//Dim DMA As New clsDma
		//Dim UTIL As New clsUtility
		clsLogging LOG = new clsLogging();
		//Dim EP As New clsEndPoint
		clsEncryptV2 ENC2 = new clsEncryptV2();
		//Dim DG As New clsDataGrid
		
		int SingleUser = 0;
		string isReadOnly = "";
		string CreateAccess = "";
		string UpdateAccess = "";
		string DeleteAccess = "";
		string LibraryOwnerUserID = "";
		string LibraryName = "";
		string UserID = "";
		
		
		
		
		//** Generate the SET methods
		public void setReadonly(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = val.Replace("\'", "\'\'");
			isReadOnly = val;
		}
		
		
		public void setCreateaccess(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = val.Replace("\'", "\'\'");
			CreateAccess = val;
		}
		
		
		public void setUpdateaccess(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = val.Replace("\'", "\'\'");
			UpdateAccess = val;
		}
		
		
		public void setDeleteaccess(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = val.Replace("\'", "\'\'");
			DeleteAccess = val;
		}
		
		
		public void setLibraryowneruserid(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("clsLibraryUsers - SET: Field \'Libraryowneruserid\' cannot be NULL.");
				return;
			}
			val = val.Replace("\'", "\'\'");
			LibraryOwnerUserID = val;
		}
		
		
		public void setLibraryname(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("clsLibraryUsers - SET: Field \'Libraryname\' cannot be NULL.");
				return;
			}
			val = val.Replace("\'", "\'\'");
			LibraryName = val;
		}
		
		
		public void setUserid(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("clsLibraryUsers - SET: Field \'Userid\' cannot be NULL.");
				return;
			}
			val = val.Replace("\'", "\'\'");
			UserID = val;
		}
		
		public void setIsSingleUser(int val)
		{
			SingleUser = val;
		}
		
		//** Generate the GET methods
		public string getReadonly()
		{
			if (isReadOnly.Length == 0)
			{
				isReadOnly = "null";
			}
			return isReadOnly;
		}
		
		
		public string getCreateaccess()
		{
			if (CreateAccess.Length == 0)
			{
				CreateAccess = "null";
			}
			return CreateAccess;
		}
		
		
		public string getUpdateaccess()
		{
			if (UpdateAccess.Length == 0)
			{
				UpdateAccess = "null";
			}
			return UpdateAccess;
		}
		
		
		public string getDeleteaccess()
		{
			if (DeleteAccess.Length == 0)
			{
				DeleteAccess = "null";
			}
			return DeleteAccess;
		}
		
		
		public string getLibraryowneruserid()
		{
			if (LibraryOwnerUserID.Length == 0)
			{
				MessageBox.Show("clsLibraryUsers - GET: Field \'Libraryowneruserid\' cannot be NULL.");
				return "";
			}
			return LibraryOwnerUserID.Replace("\'\'", "\'");
		}
		
		
		public string getLibraryname()
		{
			if (LibraryName.Length == 0)
			{
				MessageBox.Show("clsLibraryUsers - GET: Field \'Libraryname\' cannot be NULL.");
				return "";
			}
			return LibraryName.Replace("\'\'", "\'");
		}
		
		
		public string getUserid()
		{
			if (UserID.Length == 0)
			{
				MessageBox.Show("clsLibraryUsers - GET: Field \'Userid\' cannot be NULL.");
				return "";
			}
			return UserID.Replace("\'\'", "\'");
		}
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (LibraryOwnerUserID.Length == 0)
			{
				return false;
			}
			if (LibraryName.Length == 0)
			{
				return false;
			}
			if (UserID.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			if (LibraryOwnerUserID.Length == 0)
			{
				return false;
			}
			if (LibraryName.Length == 0)
			{
				return false;
			}
			if (UserID.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		//** Generate the INSERT method
		public void Insert(int NotAddedAsGroupMember, int SingleUser, int GroupUser)
		{
			bool b = false;
			string s = "";
			string sSingleUser = "";
			string sGroupUser = "";
			
			if (SingleUser == null)
			{
				sSingleUser = null;
			}
			else
			{
				sSingleUser = SingleUser.ToString();
			}
			if (GroupUser == null)
			{
				sGroupUser = null;
			}
			else
			{
				sGroupUser = GroupUser.ToString();
			}
			
			s = s + " INSERT INTO LibraryUsers(";
			s = s + "ReadOnly,";
			s = s + "CreateAccess,";
			s = s + "UpdateAccess,";
			s = s + "DeleteAccess,";
			s = s + "LibraryOwnerUserID,";
			s = s + "LibraryName,";
			s = s + "UserID, NotAddedAsGroupMember, SingleUser) values (";
			s = s + isReadOnly + ",";
			s = s + CreateAccess + ",";
			s = s + UpdateAccess + ",";
			s = s + DeleteAccess + ",";
			s = s + "\'" + LibraryOwnerUserID + "\'" + ",";
			s = s + "\'" + LibraryName + "\'" + ",";
			s = s + "\'" + UserID + "\'" + ", ";
			s = s + NotAddedAsGroupMember.ToString() + ",";
			if (sSingleUser != null)
			{
				s = s + sSingleUser.ToString();
			}
			if (sGroupUser != null)
			{
				s = s + sGroupUser.ToString();
			}
			s = s + ")";
			
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
			//EP.setSearchSvcEndPoint(proxy)
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			
			
		}
		
		
		
		
		//** Generate the UPDATE method
		public void Update(string WhereClause, int NotAddedAsGroupMember, int SingleUser, int GroupUser)
		{
			bool b = false;
			string s = "";
			
			string sSingleUser = "";
			string sGroupUser = "";
			
			if (SingleUser == null)
			{
				sSingleUser = null;
			}
			else
			{
				sSingleUser = SingleUser.ToString();
			}
			if (GroupUser == null)
			{
				sGroupUser = null;
			}
			else
			{
				sGroupUser = GroupUser.ToString();
			}
			
			
			if (WhereClause.Length == 0)
			{
				return;
			}
			
			
			s = s + " update LibraryUsers set " + "\r\n";
			s = s + "ReadOnly = " + getReadonly() + ", " + "\r\n";
			s = s + "CreateAccess = " + getCreateaccess() + ", " + "\r\n";
			s = s + "UpdateAccess = " + getUpdateaccess() + ", " + "\r\n";
			s = s + "DeleteAccess = " + getDeleteaccess() + ", " + "\r\n";
			s = s + "LibraryOwnerUserID = \'" + getLibraryowneruserid() + "\'" + ", " + "\r\n";
			s = s + "LibraryName = \'" + getLibraryname() + "\'" + ", " + "\r\n";
			s = s + "UserID = \'" + getUserid() + "\'," + "\r\n";
			s = s + "NotAddedAsGroupMember = " + NotAddedAsGroupMember.ToString() + "," + "\r\n";
			if (sSingleUser != null)
			{
				s = s + "SingleUser = " + SingleUser.ToString() + "," + "\r\n";
			}
			if (sGroupUser != null)
			{
				s = s + "GroupUser = " + GroupUser.ToString() + "\r\n";
			}
			
			WhereClause = (string) (" " + WhereClause);
			s = s + WhereClause;
			
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
			//EP.setSearchSvcEndPoint(proxy)
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			
		}
		
		
		
		
		//'** Generate the SELECT method
		//Public Function SelectRecs() As SqlDataReader
		//    Dim b As Boolean = False
		//    Dim s As String = ""
		//    Dim rsData As SqlDataReader
		//    s = s + " SELECT "
		//    s = s + "ReadOnly,"
		//    s = s + "CreateAccess,"
		//    s = s + "UpdateAccess,"
		//    s = s + "DeleteAccess,"
		//    s = s + "LibraryOwnerUserID,"
		//    s = s + "LibraryName,"
		//    s = s + "UserID "
		//    s = s + " FROM LibraryUsers"
		
		//    Dim CS$ = db.getConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata = command.ExecuteReader()
		//    Return rsData
		//End Function
		
		
		
		
		//'** Generate the Select One Row method
		//Public Function SelectOne(ByVal WhereClause as string) As SqlDataReader
		//    Dim b As Boolean = False
		//    Dim s As String = ""
		//    Dim rsData As SqlDataReader
		//    s = s + " SELECT "
		//    s = s + "ReadOnly,"
		//    s = s + "CreateAccess,"
		//    s = s + "UpdateAccess,"
		//    s = s + "DeleteAccess,"
		//    s = s + "LibraryOwnerUserID,"
		//    s = s + "LibraryName,"
		//    s = s + "UserID "
		//    s = s + " FROM LibraryUsers"
		//    s = s + WhereClause
		
		//    Dim CS$ = db.getConnStr() : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata = command.ExecuteReader()
		//    Return rsData
		//End Function
		
		
		
		
		//** Generate the DELETE method
		public void Delete(string WhereClause)
		{
			bool b = false;
			string s = "";
			
			
			if (WhereClause.Length == 0)
			{
				return;
			}
			
			
			WhereClause = (string) (" " + WhereClause);
			
			
			s = " Delete from LibraryUsers";
			s = s + WhereClause;
			
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
			//EP.setSearchSvcEndPoint(proxy)
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			
			
		}
		
		
		
		
		//** Generate the Zeroize Table method
		public void Zeroize()
		{
			bool b = false;
			string s = "";
			
			s = s + " Delete from LibraryUsers";
			
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
			//EP.setSearchSvcEndPoint(proxy)
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			
		}
		
		
		
		
		//'** Generate Index Queries
		//Public Function cnt_PK87(ByVal LibraryName As String, ByVal LibraryOwnerUserID As String, ByVal UserID As String) As Integer
		
		
		//    Dim B As Integer = 0
		//    Dim TBL$ = "LibraryUsers"
		//    Dim WC$ = "Where LibraryName = '" + LibraryName + "' and   LibraryOwnerUserID = '" + LibraryOwnerUserID + "' and   UserID = '" + UserID + "'"
		
		
		//    B = DB.iGetRowCount(TBL$, WC)
		
		
		//    Return B
		//End Function     '** cnt_PK87
		
		
		//'** Generate Index ROW Queries
		//Public Function getRow_PK87(ByVal LibraryName As String, ByVal LibraryOwnerUserID As String, ByVal UserID As String) As SqlDataReader
		
		
		//    Dim rsData As SqlDataReader = Nothing
		//    Dim TBL$ = "LibraryUsers"
		//    Dim WC$ = "Where LibraryName = '" + LibraryName + "' and   LibraryOwnerUserID = '" + LibraryOwnerUserID + "' and   UserID = '" + UserID + "'"
		
		
		//    rsData = DB.GetRowByKey(TBL$, WC)
		
		
		//    If rsData.HasRows Then
		//        Return rsData
		//    Else
		//        Return Nothing
		//    End If
		//End Function     '** getRow_PK87
		
		
		/// Build Index Where Caluses
		///
		public string wc_PK87(string LibraryName, string LibraryOwnerUserID, string UserID)
		{
			
			
			var WC = "Where LibraryName = \'" + LibraryName + "\' and   LibraryOwnerUserID = \'" + LibraryOwnerUserID + "\' and   UserID = \'" + UserID + "\'";
			
			
			return WC;
		} //** wc_PK87
		
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
				LOG.WriteToSqlLog((string) ("ERROR clsLIBRARYUSERS 100: " + e.Error.Message));
				LOG.WriteToSqlLog((string) ("ERROR clsLIBRARYUSERS 100: " + ErrSql));
			}
		}
		~clsLIBRARYUSERS()
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

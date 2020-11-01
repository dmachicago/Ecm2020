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
	public class clsDATASOURCERESTOREHISTORY
	{
		
		clsCommonFunctions COMMON = new clsCommonFunctions();
		//Dim EP As New clsEndPoint
		clsEncryptV2 ENC2 = new clsEncryptV2();
		
		
		//Dim proxy As New SVCSearch.Service1Client
		
		//** DIM the selected table columns
		//Dim DB As New clsDatabase
		clsDma DMA = new clsDma();
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		
		string SourceGuid = "";
		string RestoredToMachine = "";
		string RestoreUserName = "";
		string RestoreUserID = "";
		string RestoreUserDomain = "";
		string RestoreDate = "";
		string DataSourceOwnerUserID = "";
		string SeqNo = "";
		string TypeContentCode = "";
		string CreateDate = "";
		string DocumentName = "";
		string FQN = "";
		string VerifiedData = "";
		string OrigCrc = "";
		string RestoreCrc = "";
		
		bool HandlerAdded = false;
		public clsDATASOURCERESTOREHISTORY()
		{
			
		}
		//** Generate the SET methods
		public void setSourceguid(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("clsDATASOURCERESTOREHISTORY - SET: Field \'Sourceguid\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			SourceGuid = val;
		}
		
		public void setRestoredtomachine(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			RestoredToMachine = val;
		}
		
		public void setRestoreusername(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			RestoreUserName = val;
		}
		
		public void setRestoreuserid(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			RestoreUserID = val;
		}
		
		public void setRestoreuserdomain(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			RestoreUserDomain = val;
		}
		
		public void setRestoredate(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			RestoreDate = val;
		}
		
		public void setDatasourceowneruserid(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("clsDATASOURCERESTOREHISTORY - SET: Field \'Datasourceowneruserid\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			DataSourceOwnerUserID = val;
		}
		
		public void setTypecontentcode(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			TypeContentCode = val;
		}
		
		public void setCreatedate(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			CreateDate = val;
		}
		
		public void setDocumentname(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			DocumentName = val;
		}
		
		public void setFqn(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			FQN = val;
		}
		
		public void setVerifieddata(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			VerifiedData = val;
		}
		
		public void setOrigcrc(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			OrigCrc = val;
		}
		
		public void setRestorecrc(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			RestoreCrc = val;
		}
		
		
		
		//** Generate the GET methods
		public string getSourceguid()
		{
			if (SourceGuid.Length == 0)
			{
				MessageBox.Show("clsDATASOURCERESTOREHISTORY - GET: Field \'Sourceguid\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(SourceGuid);
		}
		
		public string getRestoredtomachine()
		{
			return UTIL.RemoveSingleQuotes(RestoredToMachine);
		}
		
		public string getRestoreusername()
		{
			return UTIL.RemoveSingleQuotes(RestoreUserName);
		}
		
		public string getRestoreuserid()
		{
			return UTIL.RemoveSingleQuotes(RestoreUserID);
		}
		
		public string getRestoreuserdomain()
		{
			return UTIL.RemoveSingleQuotes(RestoreUserDomain);
		}
		
		public string getRestoredate()
		{
			return UTIL.RemoveSingleQuotes(RestoreDate);
		}
		
		public string getDatasourceowneruserid()
		{
			if (DataSourceOwnerUserID.Length == 0)
			{
				MessageBox.Show("clsDATASOURCERESTOREHISTORY - GET: Field \'Datasourceowneruserid\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(DataSourceOwnerUserID);
		}
		
		public string getSeqno()
		{
			if (SeqNo.Length == 0)
			{
				MessageBox.Show("clsDATASOURCERESTOREHISTORY - GET: Field \'Seqno\' cannot be NULL.");
				return "";
			}
			if (SeqNo.Length == 0)
			{
				SeqNo = "null";
			}
			return SeqNo;
		}
		
		public string getTypecontentcode()
		{
			return UTIL.RemoveSingleQuotes(TypeContentCode);
		}
		
		public string getCreatedate()
		{
			return UTIL.RemoveSingleQuotes(CreateDate);
		}
		
		public string getDocumentname()
		{
			return UTIL.RemoveSingleQuotes(DocumentName);
		}
		
		public string getFqn()
		{
			return UTIL.RemoveSingleQuotes(FQN);
		}
		
		public string getVerifieddata()
		{
			return UTIL.RemoveSingleQuotes(VerifiedData);
		}
		
		public string getOrigcrc()
		{
			return UTIL.RemoveSingleQuotes(OrigCrc);
		}
		
		public string getRestorecrc()
		{
			return UTIL.RemoveSingleQuotes(RestoreCrc);
		}
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (SourceGuid.Length == 0)
			{
				return false;
			}
			if (DataSourceOwnerUserID.Length == 0)
			{
				return false;
			}
			if (SeqNo.Length == 0)
			{
				return false;
			}
			return true;
		}
		
		
		//** Generate the Validation method
		public bool ValidateData()
		{
			if (SourceGuid.Length == 0)
			{
				return false;
			}
			if (DataSourceOwnerUserID.Length == 0)
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
			s = s + " INSERT INTO DataSourceRestoreHistory(" + "\r\n";
			s = s + "SourceGuid," + "\r\n";
			s = s + "RestoredToMachine," + "\r\n";
			s = s + "RestoreUserName," + "\r\n";
			s = s + "RestoreUserID," + "\r\n";
			s = s + "RestoreUserDomain," + "\r\n";
			s = s + "RestoreDate," + "\r\n";
			s = s + "DataSourceOwnerUserID," + "\r\n";
			s = s + "TypeContentCode," + "\r\n";
			s = s + "CreateDate)" + "\r\n";
			s = s + " values (" + "\r\n";
			s = s + "\'" + SourceGuid + "\'" + "," + "\r\n";
			s = s + "\'" + RestoredToMachine + "\'" + "," + "\r\n";
			s = s + "\'" + RestoreUserName + "\'" + "," + "\r\n";
			s = s + "\'" + RestoreUserID + "\'" + "," + "\r\n";
			s = s + "\'" + RestoreUserDomain + "\'" + "," + "\r\n";
			s = s + "\'" + DateTime.Now.ToString() + "\'" + "," + "\r\n";
			s = s + "\'" + DataSourceOwnerUserID + "\'" + "," + "\r\n";
			s = s + "\'" + TypeContentCode + "\'" + "," + "\r\n";
			s = s + "\'" + DateTime.Now.ToString() + "\')" + "\r\n";
			
			if (! HandlerAdded)
			{
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
				//EP.setSearchSvcEndPoint(proxy)
			}
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			
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
			
			s = s + " update DataSourceRestoreHistory set ";
			s = s + "SourceGuid = \'" + getSourceguid() + "\'" + ", ";
			s = s + "RestoredToMachine = \'" + getRestoredtomachine() + "\'" + ", ";
			s = s + "RestoreUserName = \'" + getRestoreusername() + "\'" + ", ";
			s = s + "RestoreUserID = \'" + getRestoreuserid() + "\'" + ", ";
			s = s + "RestoreUserDomain = \'" + getRestoreuserdomain() + "\'" + ", ";
			s = s + "RestoreDate = \'" + getRestoredate() + "\'" + ", ";
			s = s + "DataSourceOwnerUserID = \'" + getDatasourceowneruserid() + "\'" + ", ";
			s = s + "TypeContentCode = \'" + getTypecontentcode() + "\'" + ", ";
			s = s + "CreateDate = \'" + getCreatedate() + "\'" + ", ";
			s = s + "DocumentName = \'" + getDocumentname() + "\'" + ", ";
			s = s + "FQN = \'" + getFqn() + "\'" + ", ";
			s = s + "VerifiedData = \'" + getVerifieddata() + "\'" + ", ";
			s = s + "OrigCrc = \'" + getOrigcrc() + "\'" + ", ";
			s = s + "RestoreCrc = \'" + getRestorecrc() + "\'";
			WhereClause = (string) (" " + WhereClause);
			s = s + WhereClause;
			if (! HandlerAdded)
			{
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
				//EP.setSearchSvcEndPoint(proxy)
			}
			
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			
			return true;
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
			
			s = " Delete from DataSourceRestoreHistory";
			s = s + WhereClause;
			
			if (! HandlerAdded)
			{
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
				//EP.setSearchSvcEndPoint(proxy)
			}
			
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			
			return true;
			
		}
		
		
		//** Generate the Zeroize Table method
		public bool Zeroize()
		{
			bool b = false;
			string s = "";
			
			s = s + " Delete from DataSourceRestoreHistory";
			
			if (! HandlerAdded)
			{
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
				//EP.setSearchSvcEndPoint(proxy)
			}
			
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(GLOBALS._SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			
			return true;
			
		}
		
		
		//'** Generate Index Queries
		//Public Function cnt_PI01_RestoreHist(ByVal DataSourceOwnerUserID As String, ByVal TypeContentCode As String, ByVal VerifiedData As String) As Integer
		
		//    Dim B As Integer = 0
		//    Dim TBL$ = "DataSourceRestoreHistory"
		//    Dim WC$ = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   TypeContentCode = '" + TypeContentCode + "' and   VerifiedData = '" + VerifiedData + "'"
		
		//    B = DB.iGetRowCount(TBL$, WC)
		
		//    Return B
		//End Function     '** cnt_PI01_RestoreHist
		//Public Function cnt_PK83(ByVal SeqNo As Integer) As Integer
		
		//    Dim B As Integer = 0
		//    Dim TBL$ = "DataSourceRestoreHistory"
		//    Dim WC$ = "Where SeqNo = " & SeqNo
		
		//    B = DB.iGetRowCount(TBL$, WC)
		
		//    Return B
		//End Function     '** cnt_PK83
		
		//'** Generate Index ROW Queries
		//Public Function getRow_PI01_RestoreHist(ByVal DataSourceOwnerUserID As String, ByVal TypeContentCode As String, ByVal VerifiedData As String) As SqlDataReader
		
		//    Dim rsData As SqlDataReader = Nothing
		//    Dim TBL$ = "DataSourceRestoreHistory"
		//    Dim WC$ = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   TypeContentCode = '" + TypeContentCode + "' and   VerifiedData = '" + VerifiedData + "'"
		
		//    rsData = DB.GetRowByKey(TBL$, WC)
		
		//    If rsData.HasRows Then
		//        Return rsData
		//    Else
		//        Return Nothing
		//    End If
		//End Function     '** getRow_PI01_RestoreHist
		//Public Function getRow_PK83(ByVal SeqNo As Integer) As SqlDataReader
		
		//    Dim rsData As SqlDataReader = Nothing
		//    Dim TBL$ = "DataSourceRestoreHistory"
		//    Dim WC$ = "Where SeqNo = " & SeqNo
		
		//    rsData = DB.GetRowByKey(TBL$, WC)
		
		//    If rsData.HasRows Then
		//        Return rsData
		//    Else
		//        Return Nothing
		//    End If
		//End Function     '** getRow_PK83
		
		// ''' Build Index Where Caluses
		// '''
		//Public Function wc_PI01_RestoreHist(ByVal DataSourceOwnerUserID As String, ByVal TypeContentCode As String, ByVal VerifiedData As String) As String
		
		//    Dim WC$ = "Where DataSourceOwnerUserID = '" + DataSourceOwnerUserID + "' and   TypeContentCode = '" + TypeContentCode + "' and   VerifiedData = '" + VerifiedData + "'"
		
		//    Return WC
		//End Function     '** wc_PI01_RestoreHist
		//Public Function wc_PK83(ByVal SeqNo As Integer) As String
		
		//    Dim WC$ = "Where SeqNo = " & SeqNo
		
		//    Return WC
		//End Function     '** wc_PK83
		
		public void client_ExecuteSqlNewConn(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			int TrackingNbr = 0;
			if (e.Error == null)
			{
				bool B = System.Convert.ToBoolean(e.Result);
				if (B)
				{
					
				}
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog((string) ("ERROR clsSql 100: " + e.Error.Message));
			}
		}
		~clsDATASOURCERESTOREHISTORY()
		{
			try
			{
				
			}
			finally
			{
				base.Finalize(); //define the destructor
				HandlerAdded = false;
				GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(client_ExecuteSqlNewConn);
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
		}
		
		
	}
	
}

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
using System.Threading;

//Imports System.Data.SqlClient

namespace ECMSearchWPF
{
	public class clsGLOBALSEACHRESULTS
	{
		
		
		//Dim proxy As New SVCSearch.Service1Client
		
		//** DIM the selected table columns
		//Dim DB As New clsDatabase
		clsDma DMA = new clsDma();
		//Dim DG As New clsDataGrid
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		//Dim EP As New clsEndPoint
		clsEncryptV2 ENC2 = new clsEncryptV2();
		
		string ContentTitle = "";
		string ContentAuthor = "";
		string ContentType = "";
		string CreateDate = "";
		string ContentExt = "";
		string ContentGuid = "";
		string UserID = "";
		string FileName = "";
		string FileSize = "";
		string NbrOfAttachments = "";
		string FromEmailAddress = "";
		string AllRecipiants = "";
		string Weight = "";
		
		int B9999 = 0;
		
		string SecureID = "-1";
		public clsGLOBALSEACHRESULTS()
		{
			SecureID = GLOBALS._SecureID.ToString();
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteSqlNewConn);
			//EP.setSearchSvcEndPoint(proxy)
			
		}
		
		//** Generate the SET methods
		public void setContenttitle(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			ContentTitle = val;
		}
		
		public void setContentauthor(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			ContentAuthor = val;
		}
		
		public void setContenttype(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			ContentType = val;
		}
		
		public void setCreatedate(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			CreateDate = val;
		}
		
		public void setContentext(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			ContentExt = val;
		}
		
		public void setContentguid(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Contentguid\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			ContentGuid = val;
		}
		
		public void setUserid(ref string val)
		{
			if (val.Length == 0)
			{
				MessageBox.Show("SET: Field \'Userid\' cannot be NULL.");
				return;
			}
			val = UTIL.RemoveSingleQuotes(val);
			UserID = val;
		}
		
		public void setFilename(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			FileName = val;
		}
		
		public void setFilesize(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = UTIL.RemoveSingleQuotes(val);
			FileSize = val;
		}
		
		public void setNbrofattachments(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = UTIL.RemoveSingleQuotes(val);
			NbrOfAttachments = val;
		}
		
		public void setFromemailaddress(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			FromEmailAddress = val;
		}
		
		public void setAllrecipiants(ref string val)
		{
			val = UTIL.RemoveSingleQuotes(val);
			AllRecipiants = val;
		}
		
		public void setWeight(ref string val)
		{
			if (val.Length == 0)
			{
				val = "null";
			}
			val = UTIL.RemoveSingleQuotes(val);
			Weight = val;
		}
		
		
		
		//** Generate the GET methods
		public string getContenttitle()
		{
			return UTIL.RemoveSingleQuotes(ContentTitle);
		}
		
		public string getContentauthor()
		{
			return UTIL.RemoveSingleQuotes(ContentAuthor);
		}
		
		public string getContenttype()
		{
			return UTIL.RemoveSingleQuotes(ContentType);
		}
		
		public string getCreatedate()
		{
			return UTIL.RemoveSingleQuotes(CreateDate);
		}
		
		public string getContentext()
		{
			return UTIL.RemoveSingleQuotes(ContentExt);
		}
		
		public string getContentguid()
		{
			if (ContentGuid.Length == 0)
			{
				MessageBox.Show("GET: Field \'Contentguid\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(ContentGuid);
		}
		
		public string getUserid()
		{
			if (UserID.Length == 0)
			{
				MessageBox.Show("GET: Field \'Userid\' cannot be NULL.");
				return "";
			}
			return UTIL.RemoveSingleQuotes(UserID);
		}
		
		public string getFilename()
		{
			return UTIL.RemoveSingleQuotes(FileName);
		}
		
		public string getFilesize()
		{
			if (FileSize.Length == 0)
			{
				FileSize = "null";
			}
			return FileSize;
		}
		
		public string getNbrofattachments()
		{
			if (NbrOfAttachments.Length == 0)
			{
				NbrOfAttachments = "null";
			}
			return NbrOfAttachments;
		}
		
		public string getFromemailaddress()
		{
			return UTIL.RemoveSingleQuotes(FromEmailAddress);
		}
		
		public string getAllrecipiants()
		{
			return UTIL.RemoveSingleQuotes(AllRecipiants);
		}
		
		public string getWeight()
		{
			if (Weight.Length == 0)
			{
				Weight = "null";
			}
			return Weight;
		}
		
		
		
		//** Generate the Required Fields Validation method
		public bool ValidateReqData()
		{
			if (ContentGuid.Length == 0)
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
			if (ContentGuid.Length == 0)
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
		public bool Insert()
		{
			bool b = false;
			string s = "";
			s = s + " INSERT INTO GlobalSeachResults(";
			s = s + "ContentTitle,";
			s = s + "ContentAuthor,";
			s = s + "ContentType,";
			s = s + "CreateDate,";
			s = s + "ContentExt,";
			s = s + "ContentGuid,";
			s = s + "UserID,";
			s = s + "FileName,";
			s = s + "FileSize,";
			s = s + "NbrOfAttachments,";
			s = s + "FromEmailAddress,";
			s = s + "AllRecipiants,";
			s = s + "Weight) values (";
			s = s + "\'" + ContentTitle + "\'" + ",";
			s = s + "\'" + ContentAuthor + "\'" + ",";
			s = s + "\'" + ContentType + "\'" + ",";
			s = s + "\'" + CreateDate + "\'" + ",";
			s = s + "\'" + ContentExt + "\'" + ",";
			s = s + "\'" + ContentGuid + "\'" + ",";
			s = s + "\'" + UserID + "\'" + ",";
			s = s + "\'" + FileName + "\'" + ",";
			s = s + FileSize + ",";
			s = s + NbrOfAttachments + ",";
			s = s + "\'" + FromEmailAddress + "\'" + ",";
			s = s + "\'" + AllRecipiants + "\'" + ",";
			s = s + Weight + ")";
			
			//AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn
			//EP.setSearchSvcEndPoint(proxy)
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			
			return true;
			
		}
		
		public void client_ExecuteSqlNewConn(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			if (e.Error == null)
			{
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog("ERROR client_updateIp: Failed to update the associated IP address.");
			}
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
			
			s = s + " update GlobalSeachResults set ";
			s = s + "ContentTitle = \'" + getContenttitle() + "\'" + ", ";
			s = s + "ContentAuthor = \'" + getContentauthor() + "\'" + ", ";
			s = s + "ContentType = \'" + getContenttype() + "\'" + ", ";
			s = s + "CreateDate = \'" + getCreatedate() + "\'" + ", ";
			s = s + "ContentExt = \'" + getContentext() + "\'" + ", ";
			s = s + "ContentGuid = \'" + getContentguid() + "\'" + ", ";
			s = s + "UserID = \'" + getUserid() + "\'" + ", ";
			s = s + "FileName = \'" + getFilename() + "\'" + ", ";
			s = s + "FileSize = " + getFilesize() + ", ";
			s = s + "NbrOfAttachments = " + getNbrofattachments() + ", ";
			s = s + "FromEmailAddress = \'" + getFromemailaddress() + "\'" + ", ";
			s = s + "AllRecipiants = \'" + getAllrecipiants() + "\'" + ", ";
			s = s + "Weight = " + getWeight();
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
		//    s = s + "ContentTitle,"
		//    s = s + "ContentAuthor,"
		//    s = s + "ContentType,"
		//    s = s + "CreateDate,"
		//    s = s + "ContentExt,"
		//    s = s + "ContentGuid,"
		//    s = s + "UserID,"
		//    s = s + "FileName,"
		//    s = s + "FileSize,"
		//    s = s + "NbrOfAttachments,"
		//    s = s + "FromEmailAddress,"
		//    s = s + "AllRecipiants,"
		//    s = s + "Weight "
		//    s = s + " FROM GlobalSeachResults"
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
		//    s = s + "ContentTitle,"
		//    s = s + "ContentAuthor,"
		//    s = s + "ContentType,"
		//    s = s + "CreateDate,"
		//    s = s + "ContentExt,"
		//    s = s + "ContentGuid,"
		//    s = s + "UserID,"
		//    s = s + "FileName,"
		//    s = s + "FileSize,"
		//    s = s + "NbrOfAttachments,"
		//    s = s + "FromEmailAddress,"
		//    s = s + "AllRecipiants,"
		//    s = s + "Weight "
		//    s = s + " FROM GlobalSeachResults"
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
			
			s = " Delete from GlobalSeachResults";
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
			
			s = s + " Delete from GlobalSeachResults";
			
			//AddHandler ProxySearch.ExecuteSqlNewConnSecureCompleted, AddressOf client_ExecuteSqlNewConn
			s = ENC2.EncryptPhrase(s, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, s, GLOBALS._UserID, GLOBALS.ContractID);
			
			return b;
			
		}
		
		
		//** Generate Index Queries
		public int cnt_PK_GlobalSearch(string ContentGuid, string UserID)
		{
			
			B9999 = -9999;
			var TBL = "GlobalSeachResults";
			string S = "Select count(*) GlobalSeachResults from Where ContentGuid = \'" + ContentGuid + "\' and   UserID = \'" + UserID + "\'";
			
			//B = SVCSearch.iGetRowCount(TBL$, WC)
			//AddHandler ProxySearch.iGetRowCountCompleted, AddressOf client_iGetRowCount
			S = ENC2.EncryptPhrase(S, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, S, GLOBALS._UserID, GLOBALS.ContractID);
			
			int LoopCnt = 0;
			while (B9999 == -9999)
			{
				LoopCnt++;
				Thread.Sleep(25);
			}
			
			return B9999;
		}
		
		public void client_iGetRowCount(object sender, SVCSearch.iGetRowCountCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				B9999 = System.Convert.ToInt32(e.Result);
			}
			else
			{
				B9999 = -1;
				LOG.WriteToSqlLog("ERROR clsGLOBALSEACHRESULTS:client_iGetRowCount: Failed to update the associated IP address.");
			}
		}
		
		//'** Generate Index ROW Queries
		//Public Function getRow_PK_GlobalSearch(ByVal ContentGuid As String, ByVal UserID As String) As SqlDataReader
		
		//    Dim rsData As SqlDataReader = Nothing
		//    Dim TBL$ = "GlobalSeachResults"
		//    Dim WC$ = "Where ContentGuid = '" + ContentGuid + "' and   UserID = '" + UserID + "'"
		
		//    rsData = DB.GetRowByKey(TBL$, WC)
		
		//    If rsData.HasRows Then
		//        Return rsData
		//    Else
		//        Return Nothing
		//    End If
		//End Function     '** getRow_PK_GlobalSearch
		
		/// Build Index Where Caluses
		///
		public string wc_PK_GlobalSearch(string ContentGuid, string UserID)
		{
			
			var WC = "Where ContentGuid = \'" + ContentGuid + "\' and   UserID = \'" + UserID + "\'";
			
			return WC;
		} //** wc_PK_GlobalSearch
		
		//** Generate the SET methods
		public bool Add()
		{
			int iCnt = cnt_PK_GlobalSearch(ContentGuid, modGlobals.gCurrUserGuidID);
			if (iCnt > 0)
			{
				var WC = wc_PK_GlobalSearch(ContentGuid, modGlobals.gCurrUserGuidID);
				Update(WC);
			}
			else
			{
				Insert();
			}
			return true;
		}
		~clsGLOBALSEACHRESULTS()
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

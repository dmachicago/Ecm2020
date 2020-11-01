#define RemoteOcr
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
using System.Guid;
using System.Data.SqlClient;
using System.IO;
using System.Data.Sql;
using Microsoft.Win32;
//using System.Math;
using System.ServiceModel;
using Ionic.Zip;
using Microsoft.VisualBasic.CompilerServices;
using System.Threading;



//Imports Microsoft.SqlServer.Management.Smo

//' <summary>
//' This is a LINKED class lib.
//' clsDatabase: A set of standard utilities to perform repetitive database tasks through a public class
//' Copyright @ DMA, Limited, Chicago, IL., June 2003, all rights reserved.
//' Licensed on a use only basis for clients of DMA, Limited.
//' </summary>
//' <remarks></remarks>
namespace EcmArchiveClcSetup
{
	public class clsDatabase
	{
		//    Inherits System.Web.UI.Page
		bool bTrackUploads = true;
		
		clsIsolatedStorage ISO = new clsIsolatedStorage();
		clsRegistry REG = new clsRegistry();
		
		//Dim ProxyUpload As New SVCCLCArchive.Service1Client
		SVCCLCArchive.Service1Client Proxy = new SVCCLCArchive.Service1Client();
		SVCFS.Service1Client ProxyFS = new SVCFS.Service1Client();
		
		clsTimeCalcs TC = new clsTimeCalcs();
		clsCompression COMP = new clsCompression();
		
		int bUseCommandProcessForInventory; // VBConversions Note: Initial value of "System.Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings["UseCommandProcessForInventory"])" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		public bool dDebug = false;
		int IXV1 = 0;
		clsFile CF = new clsFile();
		clsEncrypt ENC = new clsEncrypt();
		clsLogging LOG = new clsLogging();
		clsUtility UTIL = new clsUtility();
		clsDma DMA = new clsDma();
		
		clsKeyGen KGEN = new clsKeyGen();
		
		//** Public ConnectionStringID As String = "XOMR1.1ConnectionString"
		//** Do not forget that this is a global access var to thte DB
		//** and MUST be changed to run on different platforms.
		public string ConnectionStringID = "";
		public string ServerName = "";
		public string TgtGuid = "";
		
		public Dictionary<string, string> slMachineNetwork = new Dictionary<string, string>();
		public Dictionary<string, Guid> slContainerGuid = new Dictionary<string, Guid>();
		public SortedList slProjects = new SortedList();
		public SortedList slProjectTeams = new SortedList();
		public SortedList slMetricPeriods = new SortedList();
		public SortedList slExcelColNames = new SortedList();
		public SortedList slGrowthPlatform = new SortedList();
		public SortedList slOperatingGroup = new SortedList();
		public SortedList slOperatingUnit = new SortedList();
		public SortedList slGeography = new SortedList();
		public SortedList slGeographicUnit = new SortedList();
		public SortedList slClientServiceGroup = new SortedList();
		public SortedList slDeliveryCenter = new SortedList();
		public SortedList slTypeOfWork = new SortedList();
		public SortedList slProjectTeamTypeOfWork = new SortedList();
		public SortedList slSubmissionStatus = new SortedList();
		public SortedList slSubmittedBy = new SortedList();
		public ArrayList EL = new ArrayList();
		
		
		public string[,] TblCols = new string[5, 1];
		
		// Dim owner As IWin32Window
		string gConnStr = "";
		string DBDIR = "C:\\Program Files\\Microsoft SQL Server\\MSSQL.1\\MSSQL\\Data\\org_db.mdf";
		string DQ; // VBConversions Note: Initial value of "'\u0022'" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		//Private gCurrUserGuidID = ""
		private string CurrUserPW = "";
		SqlConnection gConn = null;
		SqlCommand gCmd = null;
		bool OverwriteOnce = false;
		bool OverwriteAlways = false;
		
		private string _GatewayID = "";
		
		
		public clsDatabase()
		{
			// VBConversions Note: Non-static class variable initialization is below.  Class variables cannot be initially assigned non-static values in C#.
			bUseCommandProcessForInventory = System.Convert.ToInt32(System.Configuration.ConfigurationManager.AppSettings["UseCommandProcessForInventory"]);
			DQ = '\u0022';
			
			//Dim sDebug  = System.Configuration.ConfigurationManager.AppSettings("debug_clsDatabase")
			string sDebug = getUserParm("debug_ClsDatabase");
			if (sDebug.Equals("1"))
			{
				dDebug = true;
			}
			else
			{
				dDebug = false;
			}
			//LoadColInfo()
		}
		
		/// <summary>
		/// Gets or sets the global gateway ID.
		/// </summary>
		///
		public string GatewayID
		{
			get
			{
				return _GatewayID;
			}
			private set
			{
				_GatewayID = value;
			}
		}
		
		/// <summary>
		/// Sets the ocr processing parms.
		/// </summary>
		/// <param name="SourceGuid">The source GUID.</param>
		/// <param name="SourceTypeCode">The source type code.</param>
		/// <returns></returns>
		public bool setOcrProcessingParms(string SourceGuid, string SourceTypeCode, string FileName)
		{
			
			FileName = UTIL.RemoveSingleQuotes(FileName);
			
			bool b = false;
			string S = "";
			if (SourceTypeCode.ToUpper().Equals("A"))
			{
				S = "Update EmailAttachment set RequireOcr = 1 where EmailGuid = \'" + SourceGuid + "\' and AttachmentName = \'" + FileName + "\' ";
			}
			else if (SourceTypeCode.ToUpper().Equals("C"))
			{
				S = "Update DataSource set RequireOcr = 1 where SourceGuid = \'" + SourceGuid + "\'";
			}
			else
			{
				return false;
			}
			
			b = ExecuteSqlNewConn(S);
			
			if (b)
			{
				Proxy.consoleOcrSingleFile(modGlobals.gGateWayID, SourceGuid, SourceTypeCode);
			}
			
			return b;
		}
		
		public string CkColData(string TblName, string ColName, string tData)
		{
			string xData = "";
			int K;
			int CurrLen = tData.Length;
			int MaxLen = 0;
			string table_name = "";
			string column_name = "";
			string data_type = "";
			int character_maximum_length = 0;
			bool B = false;
			
			for (K = 1; K <= UBound(TblCols, 2); K++)
			{
				table_name = TblCols[0, K].ToUpper();
				column_name = TblCols[1, K].ToUpper();
				data_type = TblCols[2, K];
				character_maximum_length = int.Parse(TblCols[3, K]);
				if (table_name.Equals(TblName.ToUpper()))
				{
					if (column_name.Equals(ColName.ToUpper()))
					{
						B = true;
						xData = tData;
						break;
					}
				}
			}
			if (B)
			{
				if (character_maximum_length < CurrLen)
				{
					//tData  = Mid(tData, 1, MaxLen)
					xData = tData.Substring(0, character_maximum_length);
					//'Session("ErrMsgs") = 'Session("ErrMsgs") + "<br>" + "" + ColName + " > " + Str(character_maximum_length) + " characters - truncated."
				}
				else
				{
					xData = tData;
				}
			}
			return xData;
		}
		
		/// <summary>
		/// LoadColInfo reads table_name, column_name, data_type, character_maximum_length
		/// from INFORMATION_SCHEMA.COLUMNS.
		/// </summary>
		/// <remarks></remarks>
		public void LoadColInfo()
		{
			
			string S = "";
			S = S + " select table_name, column_name, data_type, character_maximum_length  ";
			S = S + " from INFORMATION_SCHEMA.COLUMNS ";
			//S = S + " where table_name = 'Project' "
			S = S + " order by table_name, column_name";
			
			bool b = true;
			int i = 0;
			int id = -1;
			int II = 0;
			string table_name = "";
			string column_name = "";
			string data_type = "";
			string character_maximum_length = "";
			
			if (Information.UBound(TblCols, 2) > 2)
			{
				return;
			}
			
			TblCols = new string[5, 1];
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					table_name = RSData.GetValue(0).ToString();
					column_name = RSData.GetValue(1).ToString();
					data_type = RSData.GetValue(2).ToString();
					character_maximum_length = RSData.GetValue(3).ToString();
					II = System.Convert.ToInt32(Information.UBound(TblCols, 2) + 1);
					TblCols = (string[,]) Microsoft.VisualBasic.CompilerServices.Utils.CopyArray((Array) TblCols, new string[5, II + 1]);
					TblCols[0, II] = table_name;
					TblCols[1, II] = column_name;
					TblCols[2, II] = data_type;
					TblCols[3, II] = character_maximum_length;
				}
			}
			else
			{
				id = -1;
			}
			RSData.Close();
			RSData = null;
			
		}
		
		public void setEmailCrcHash(bool isadmin)
		{
			
			if (! isadmin)
			{
				MessageBox.Show("Sorry, administrative authority needed for this function, please contact your corporate admin - returning.");
				return;
			}
			
			Dictionary<string, string> ListOfEmailIdentifiers = new Dictionary<string, string>();
			
			string S = "";
			S = S + " select EmailGuid, CreationTime, SenderEmailAddress, Subject ";
			S = S + " from Email ";
			
			bool b = true;
			int i = 0;
			int id = -1;
			int II = 0;
			
			string EmailGuid = "";
			DateTime CreationTime;
			string SenderEmailAddress = "";
			string Subject = "";
			
			if (Information.UBound(TblCols, 2) > 2)
			{
				return;
			}
			II = 0;
			TblCols = new string[5, 1];
			string Msg = "";
			SqlDataReader RSData = null;
			
			frmMain.Default.PB1.Value = 0;
			frmMain.Default.PB1.Maximum = 15000;
			
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					II++;
					frmMain.Default.SB.Text = II.ToString();
					frmMain.Default.SB.Refresh();
					Application.DoEvents();
					Msg = "";
					try
					{
						EmailGuid = RSData.GetValue(0).ToString();
						CreationTime = RSData.GetDateTime(1);
						SenderEmailAddress = (string) (RSData.GetValue(2).ToString());
						Subject = (string) (RSData.GetValue(3).ToString());
						
						string EmailIdentifier = UTIL.genEmailIdentifier(CreationTime, SenderEmailAddress, Subject);
						ListOfEmailIdentifiers.Add(EmailGuid, EmailIdentifier);
					}
					catch (Exception ex)
					{
						Console.WriteLine(ex.Message);
					}
				}
			}
			else
			{
				id = -1;
			}
			RSData.Close();
			RSData = null;
			
			frmMain.Default.PB1.Value = 0;
			frmMain.Default.PB1.Maximum = System.Convert.ToInt32(ListOfEmailIdentifiers.Count + 2);
			II = 0;
			List<string> ListOfGuids = new List<string>();
			string MySql = "";
			string sVal = "";
			foreach (string sGuid in ListOfEmailIdentifiers.Keys)
			{
				Application.DoEvents();
				sVal = ListOfEmailIdentifiers[sGuid];
				MySql = "*";
				MySql = "Update Email set EmailIdentifier = \'" + sVal + "\' where EmailGuid = \'" + sGuid + "\' ";
				b = ExecuteSqlNewConn(MySql);
				if (! b)
				{
					ListOfGuids.Add(sGuid);
				}
				II++;
				if (II % 5 == 0)
				{
					frmMain.Default.SB.Text = II.ToString() + " of " + ListOfEmailIdentifiers.Count.ToString() + " / " + ListOfGuids.Count.ToString();
					frmMain.Default.SB.Refresh();
				}
				Application.DoEvents();
				MySql = "***********";
			}
			II = 0;
			foreach (string sGuid in ListOfGuids)
			{
				Application.DoEvents();
				MySql = "*";
				MySql = "delete from Email where EmailGuid = \'" + sGuid + "\' ";
				b = ExecuteSqlNewConn(MySql);
				II++;
				if (II % 10 == 0)
				{
					frmMain.Default.SB.Text = II.ToString() + " of " + ListOfEmailIdentifiers.Count.ToString();
					frmMain.Default.SB.Refresh();
				}
				Application.DoEvents();
				MySql = "***********";
			}
			frmMain.Default.SB.Text = "Done.";
			MessageBox.Show("Update complete.");
		}
		
		/// <summary>
		/// LoadColInfo reads table_name, column_name, data_type, character_maximum_length
		/// from INFORMATION_SCHEMA.COLUMNS based on the provided Table Name.
		/// </summary>
		/// <param name="TableName">The name of the table to retrieve column information about.</param>
		/// <remarks></remarks>
		public void LoadColInfo(string TableName)
		{
			
			string S = "";
			S = S + " select table_name, column_name, data_type, character_maximum_length  " + "\r\n";
			S = S + " from INFORMATION_SCHEMA.COLUMNS " + "\r\n";
			S = S + " where table_name = \'" + TableName + "\' " + "\r\n";
			S = S + " order by table_name, column_name" + "\r\n";
			
			bool b = true;
			int i = 0;
			int id = -1;
			int II = 0;
			string table_name = "";
			string column_name = "";
			string data_type = "";
			string character_maximum_length = "";
			
			if (Information.UBound(TblCols, 2) > 2)
			{
				return;
			}
			
			TblCols = new string[5, 1];
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					table_name = RSData.GetValue(0).ToString();
					column_name = RSData.GetValue(1).ToString();
					data_type = RSData.GetValue(2).ToString();
					character_maximum_length = RSData.GetValue(3).ToString();
					II = System.Convert.ToInt32(Information.UBound(TblCols, 2) + 1);
					TblCols = (string[,]) Microsoft.VisualBasic.CompilerServices.Utils.CopyArray((Array) TblCols, new string[5, II + 1]);
					TblCols[0, II] = table_name;
					TblCols[1, II] = column_name;
					TblCols[2, II] = data_type;
					TblCols[3, II] = character_maximum_length;
				}
			}
			else
			{
				id = -1;
			}
			RSData.Close();
			RSData = null;
			
		}
		
		public void Audit(string sql, string UserID)
		{
			int i = 0;
			int j = 0;
			string s = sql.Trim();
			
			string Tbl = GetTableNameFromSql(sql);
			//Dim wc As String = GetWhereClauseFromSql(sql)
			string TypeStmt = GetTypeSqlStmt(sql);
			
			Tbl = Tbl.ToUpper();
			
			sql = UTIL.RemoveSingleQuotes(sql);
			string[] A = sql.Split(' ');
			
			modGlobals.gCurrUserGuidID = UserID;
			
			bool b = AuditInsert(DateTime.Today.ToString(), modGlobals.gCurrUserGuidID, sql, Tbl, TypeStmt, DateTime.Now.ToString());
			
			if (! b)
			{
				Console.WriteLine("Audit Failed: " + sql);
			}
			
		}
		
		public string ckNull(string tVal)
		{
			if (tVal.Trim().Length == 0)
			{
				return "null";
			}
			else
			{
				return tVal;
			}
		}
		
		public bool AuditInsert(string ChangeID, string UserID, string Msg, string TableName, string TypeChange, string ChangeDate)
		{
			bool b = false;
			
			string S = "";
			S = S + " INSERT INTO audit(";
			S = S + "UserID,";
			S = S + "SqlStmt,";
			S = S + "TableName,";
			S = S + "TypeChange,";
			S = S + "ChangeDate, ChangeID) values (";
			S = S + "\'" + UserID + "\'" + ",";
			S = S + "\'" + Msg + "\'" + ",";
			S = S + "\'" + TableName + "\'" + ",";
			S = S + "\'" + TypeChange + "\'" + ",";
			S = S + "\'" + ChangeDate + "\',";
			S = S + "\'" + ChangeID + "\'" + ")";
			
			b = ExecuteSqlNoAudit(S);
			
			if (! b)
			{
				Console.WriteLine("Audit Failed: " + S);
			}
			
			return b;
			
		}
		
		public string AddNulls(string S)
		{
			int i = 0;
			int j = 0;
			
			while (S.IndexOf(",,") + 1 > 0)
			{
				i = S.IndexOf(",,") + 1;
				j = i + 1;
				var s1 = S.Substring(0, i);
				var s2 = S.Substring(i + 1 - 1);
				S = s1 + "null" + s2;
			}
			while (S.IndexOf(",)") + 1 > 0)
			{
				i = S.IndexOf(",)") + 1;
				j = i + 1;
				var s1 = S.Substring(0, i);
				var s2 = S.Substring(i + 1 - 1);
				S = s1 + "null" + s2;
			}
			while (S.IndexOf("=)") + 1 > 0)
			{
				i = S.IndexOf("=)") + 1;
				j = i + 1;
				var s1 = S.Substring(0, i);
				var s2 = S.Substring(i + 1 - 1);
				S = s1 + "null" + s2;
			}
			while (S.IndexOf("= ,") + 1 > 0)
			{
				i = S.IndexOf("= ,") + 1;
				j = i + 1;
				var s1 = S.Substring(0, i);
				var s2 = S.Substring(i + 2 - 1);
				S = s1 + "null" + s2;
			}
			while (S.IndexOf("= )") + 1 > 0)
			{
				i = S.IndexOf("= )") + 1;
				j = i + 1;
				var s1 = S.Substring(0, i);
				var s2 = S.Substring(i + 2 - 1);
				S = s1 + "null" + s2;
			}
			return S;
		}
		
		public string AddNullsToUpdate(string S)
		{
			int i = 0;
			int j = 0;
			
			while (S.IndexOf("= ,") + 1 > 0)
			{
				i = S.IndexOf("= ,") + 1;
				j = i + 1;
				var s1 = S.Substring(0, i);
				var s2 = S.Substring(i + 2 - 1);
				S = s1 + "null" + s2;
			}
			while (S.IndexOf("= )") + 1 > 0)
			{
				i = S.IndexOf("= )") + 1;
				j = i + 1;
				var s1 = S.Substring(0, i);
				var s2 = S.Substring(i + 2 - 1);
				S = s1 + "null" + s2;
			}
			
			while (S.IndexOf("=,") + 1 > 0)
			{
				i = S.IndexOf("=,") + 1;
				j = i + 1;
				var s1 = S.Substring(0, i);
				var s2 = S.Substring(i + 1 - 1);
				S = s1 + "null" + s2;
			}
			while (S.IndexOf("=)") + 1 > 0)
			{
				i = S.IndexOf("=)") + 1;
				j = i + 1;
				var s1 = S.Substring(0, i);
				var s2 = S.Substring(i + 1 - 1);
				S = s1 + "null" + s2;
			}
			
			return S;
		}
		
		public bool ckDbConnection(string From)
		{
			dDebug = false;
			
			bool b = false;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			
			try
			{
				if (gConn == null)
				{
					
					try
					{
						gConn.ConnectionString = getGateWayConnStr(modGlobals.gGateWayID);
						gConn.Open();
						b = true;
					}
					catch (Exception ex)
					{
						this.xTrace(28000, "ckDbConnection", "clsDatabase", ex);
						b = false;
						LOG.WriteToErrorLog((string) ("ERROR From \'" + From + "\' clsDatabase : ckDbConnection : 243a : " + ex.Message));
						if (dDebug)
						{
							LOG.WriteToArchiveLog((string) ("clsDatabase : ckDbConnection : 25 : " + gConn.ConnectionString));
						}
					}
				}
				if (gConn.State == System.Data.ConnectionState.Closed)
				{
					if (dDebug)
					{
						LOG.WriteToArchiveLog((string) ("clsDatabase : ckDbConnection : 26 : " + gConn.ConnectionString));
					}
					try
					{
						CS = getGateWayConnStr(modGlobals.gGateWayID);
						if (CS == null)
						{
							CS = System.Configuration.ConfigurationManager.AppSettings["ECMREPO"];
						}
						if (gConn.State == ConnectionState.Open)
						{
							gConn.Close();
						}
						gConn.ConnectionString = CS;
						gConn.Open();
						b = true;
					}
					catch (Exception ex)
					{
						try
						{
							if (gConn.State == ConnectionState.Open)
							{
								gConn.Close();
							}
							CS = System.Configuration.ConfigurationManager.AppSettings["ECMREPO"];
							if (gConn.State == ConnectionState.Open)
							{
								gConn.Close();
							}
							gConn.ConnectionString = CS;
							gConn.Open();
							return true;
						}
						catch (Exception)
						{
							LOG.WriteToArchiveLog((string) ("ERROR From \'" + From + " \' clsDatabase : ckDbConnection : 23e: " + ex.Message));
						}
						LOG.WriteToArchiveLog((string) ("ERROR From \'" + From + " \' clsDatabase : ckDbConnection : 23b: " + ex.Message));
						b = false;
						bool ShowBox = false;
						if (ShowBox && modGlobals.gRunUnattended == false)
						{
							MessageBox.Show((string) ("The database connection failed at error marker 2301.2334.1 : " + "\r\n" + ex.Message));
						}
					}
				}
				else
				{
					b = true;
				}
			}
			catch (Exception ex)
			{
				if (dDebug)
				{
					LOG.WriteToArchiveLog((string) ("clsDatabase : ckDbConnection : 43 : " + CS));
				}
				this.xTrace(28002, "ckDbConnection", "clsDatabase", ex);
				b = false;
				LOG.WriteToArchiveLog((string) ("clsDatabase : ckDbConnection : 313 : " + ex.Message));
			}
			if (dDebug)
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase : ckDbConnection : 44 : " + CS));
			}
			return b;
		}
		
		public bool UseEncrypted()
		{
			string strVal = System.Configuration.ConfigurationManager.AppSettings["UseEncrypted"];
			if (strVal.Equals("1"))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public string getGateWayConnStr(int SecureID)
		{
			
			string CS = "";
			
			if (modGlobals.gDictOfConstr.Count > 0)
			{
				if (modGlobals.gDictOfConstr.ContainsKey(SecureID))
				{
					CS = modGlobals.gDictOfConstr[SecureID];
					CS = ENC.AES256DecryptString(CS);
				}
			}
			else
			{
				SVCGateway.Service1Client ProxyGateway = new SVCGateway.Service1Client();
				try
				{
					CS = (string) (ProxyGateway.GetCS(SecureID));
					modGlobals.gDictOfConstr.Add(SecureID, CS);
					CS = ENC.AES256DecryptString(CS);
				}
				catch (Exception ex)
				{
					CS = "";
					xTrace(666, "getGateWayConnStr", (string) ("Failed to get Gateway CS: " + ex.Message));
				}
				finally
				{
					ProxyGateway = null;
					GC.Collect();
					GC.WaitForPendingFinalizers();
				}
			}
			
			return CS;
			
		}
		
		public string setConnStr()
		{
			
			return getGateWayConnStr(modGlobals.gGateWayID);
			
		}
		
		public string getGateWayConnStr(string gGateWayID)
		{
			
			return setConnStr();
			
		}
		
		public string setThesaurusConnStr()
		{
			
			string S = "";
			if (UseEncrypted())
			{
				S = System.Configuration.ConfigurationManager.AppSettings["ENC.ECM_ThesaurusConnectionString"];
				S = ENC.AES256DecryptString(S);
			}
			else
			{
				S = System.Configuration.ConfigurationManager.AppSettings["ECM_ThesaurusConnectionString"];
			}
			
			return S;
			
		}
		public string getThesaurusConnStr()
		{
			
			return setThesaurusConnStr();
			
		}
		
		public void setpW(string tVal)
		{
			CurrUserPW = tVal;
		}
		
		public SqlConnection GetConnection()
		{
			
			CkConn();
			return gConn;
		}
		
		public SqlDataAdapter getSqlAdaptor(string Sql)
		{
			CkConn();
			string sSelect = Sql;
			SqlDataAdapter da = new SqlDataAdapter(sSelect, gConn);
			//da.MissingSchemaAction = MissingSchemaAction.AddWithKey
			SqlCommandBuilder cmd = new SqlCommandBuilder(da);
			return da;
		}
		
		public void CkConn()
		{
			if (gConn == null)
			{
				try
				{
					gConn = new SqlConnection();
					gConn.ConnectionString = getGateWayConnStr(modGlobals.gGateWayID);
					gConn.Open();
				}
				catch (Exception ex)
				{
					//do Write to log
					this.xTrace(29000, "clsDatabase:CkConn", ex.Message);
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine("Error 121.21");
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine(ex.Source);
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine(ex.StackTrace);
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine(ex.Message);
					}
					LOG.WriteToArchiveLog((string) ("ERROR: clsDatabase : CkConn : 338 : " + ex.Message));
				}
			}
			if (gConn.State == System.Data.ConnectionState.Closed)
			{
				try
				{
					gConn.ConnectionString = getGateWayConnStr(modGlobals.gGateWayID);
					gConn.Open();
				}
				catch (Exception ex)
				{
					this.xTrace(29001, "clsDatabase:CkConn", ex.Message);
					//WDM Write to log
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine("Error 121.21");
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine(ex.Source);
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine(ex.StackTrace);
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine(ex.Message);
					}
					LOG.WriteToArchiveLog((string) ("clsDatabase : CkConn : 348.1 : " + ex.Message));
				}
			}
		}
		
		public void CloseConn()
		{
			if (gConn == null)
			{
			}
			else
			{
				if (gConn.State == ConnectionState.Open)
				{
					gConn.Close();
				}
				gConn.Dispose();
			}
			GC.Collect();
		}
		
		
		public void ResetConn()
		{
			if (gConn == null)
			{
				try
				{
					gConn.ConnectionString = getGateWayConnStr(modGlobals.gGateWayID);
					gConn.Open();
				}
				catch (Exception ex)
				{
					//WDM Write to log
					this.xTrace(29010, "ResetConn", "clsDatabase", ex);
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine("Error 121.21");
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine(ex.Source);
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine(ex.StackTrace);
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine(ex.Message);
					}
					LOG.WriteToArchiveLog((string) ("clsDatabase : ResetConn : 378 : " + ex.Message));
				}
			}
			else
			{
				if (gConn.State == System.Data.ConnectionState.Open)
				{
					gConn.Close();
				}
				try
				{
					gConn.ConnectionString = getGateWayConnStr(modGlobals.gGateWayID);
					gConn.Open();
				}
				catch (Exception ex)
				{
					//WDM Write to log
					this.xTrace(29020, "ResetConn", "clsDatabase", ex);
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine("Error 121.21");
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine(ex.Source);
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine(ex.StackTrace);
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine(ex.Message);
					}
					LOG.WriteToArchiveLog((string) ("clsDatabase : ResetConn : 390 : " + ex.Message));
				}
			}
			if (gConn.State == System.Data.ConnectionState.Closed)
			{
				try
				{
					gConn.ConnectionString = getGateWayConnStr(modGlobals.gGateWayID);
					gConn.Open();
				}
				catch (Exception ex)
				{
					//WDM Write to log
					this.xTrace(29021, "ResetConn", "clsDatabase", ex);
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine("Error 121.21");
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine(ex.Source);
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine(ex.StackTrace);
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine(ex.Message);
					}
					LOG.WriteToArchiveLog((string) ("clsDatabase : ResetConn : 400 : " + ex.Message));
				}
			}
		}
		
		public int iExecCountStmt(string S)
		{
			
			string tQuery = "";
			string s1 = "";
			string s2 = "";
			string s3 = "";
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			string wc = "";
			
			try
			{
				using (gConn)
				{
					
					SqlDataReader RSData = null;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					RSData = command.ExecuteReader();
					
					RSData.Read();
					cnt = RSData.GetInt32(0);
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				
			}
			catch (Exception ex)
			{
				this.xTrace(30021, "iExecCountStmt", "clsDatabase", ex);
				cnt = -1;
				LOG.WriteToArchiveLog((string) ("clsDatabase : iExecCountStmt : 100 : " + ex.Message));
			}
			
			return cnt;
			
		}
		
		public int iGetRowCount(string S)
		{
			
			string tQuery = "";
			string s1 = "";
			string s2 = "";
			string s3 = "";
			string queryString = S;
			
			CloseConn();
			CkConn();
			
			int i;
			int cnt = -1;
			string wc = "";
			
			i = S.IndexOf("order by") + 1;
			if (i > 0)
			{
				S = S.Substring(0, i - 1);
			}
			i = S.IndexOf(" WHERE") + 1;
			if (i > 0)
			{
				wc = S.Substring(i - 1);
			}
			i = S.IndexOf("select") + 1;
			if (i > 0)
			{
				s1 = "Select count(*) as CNT from";
				i = S.IndexOf(" from") + 1;
				if (i > 0)
				{
					s2 = S.Substring(i + 5 - 1);
					s2 = s2.Trim();
					i = s2.IndexOf(" ") + 1;
					if (i > 0)
					{
						s2 = s2.Substring(0, i);
						s2 = s2.Trim();
					}
				}
				else
				{
					return -1;
				}
			}
			else
			{
				return -1;
			}
			
			S = s1 + " " + s2 + wc;
			try
			{
				using (gConn)
				{
					//Console.WriteLine(gConnStr)
					
					SqlDataReader RSData = null;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					RSData = command.ExecuteReader();
					// Call Read before accessing data.
					RSData.Read();
					cnt = RSData.GetInt32(0);
					//Dim ss As String = ""
					//ss = RSData.GetValue(0).ToString
					//cnt = RSData.Item(0)
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				
			}
			catch (Exception ex)
			{
				//WDM Write to log
				this.xTrace(30021, "iGetRowCount", "clsDatabase", ex);
				cnt = -1;
				LOG.WriteToArchiveLog((string) ("clsDatabase : iGetRowCount : 449 : " + ex.Message));
			}
			
			return cnt;
			
		}
		
		public int iDataExist(string S)
		{
			
			string tQuery = "";
			string s1 = "";
			string s2 = "";
			string s3 = "";
			string queryString = S;
			
			CloseConn();
			CkConn();
			
			int cnt = 0;
			
			using (gConn)
			{
				//Console.WriteLine(gConnStr)
				
				
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				
				// Call Read before accessing data.
				RSData.Read();
				cnt = RSData.GetInt32(0);
				//Dim ss As String = ""
				//ss = RSData.GetValue(0).ToString
				//cnt = RSData.Item(0)
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
			}
			
			
			return cnt;
			
		}
		
		public int iGetMaxRowNbrFromXml()
		{
			
			string tQuery = "";
			string s1 = "";
			string s2 = "";
			string s3 = "";
			string S = " select max(RowNbr) from InitialLoadData";
			
			CloseConn();
			CkConn();
			
			int cnt = 1;
			
			using (gConn)
			{
				//Console.WriteLine(gConnStr)
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				// Call Read before accessing data.
				RSData.Read();
				cnt = RSData.GetInt32(0);
				//Dim ss As String = ""
				//ss = RSData.GetValue(0).ToString
				//cnt = RSData.Item(0)
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
			}
			
			
			return cnt;
			
		}
		
		public string getOneVal(string S)
		{
			
			string tVal = S;
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			
			using (gConn)
			{
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				tVal = RSData.GetValue(0).ToString();
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
			}
			
			
			return tVal;
			
		}
		
		public bool xckEmailExists(string SenderEmailAddress, string ReceivedByName, string ReceivedTime, string SenderName, string SentOn)
		{
			string tQuery = "";
			string S = "";
			
			S = S + " SELECT [SenderEmailAddress]     ";
			S = S + " ,[ReceivedByName]";
			S = S + " ,[ReceivedTime]     ";
			S = S + " ,[SenderName]";
			S = S + " ,[SentOn]";
			S = S + " FROM  [Email]";
			S = S + " where [UserID] = \'" + modGlobals.gCurrUserGuidID + "\'";
			S = S + " and [SenderEmailAddress] = \'XXX\'";
			S = S + " and [ReceivedByName] = \'XXX\'";
			S = S + " and [ReceivedTime] = \'2008-01-10 12:22:06.000\'";
			S = S + " and [SenderName] = \'XXX\'";
			S = S + " and [SentOn] = \'2008-01-10 12:19:14.000\'";
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = RSData.GetInt32(0);
				RSData.Close();
				RSData = null;
				cmd.Connection.Close();
				cmd = null;
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			if (cnt > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public int ckEmailGuidExists(string EmailGuid)
		{
			
			string S = "";
			S = S + " SELECT count(*) from Email where EmailGuid = \'" + EmailGuid + "\'";
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = RSData.GetInt32(0);
				RSData.Close();
				RSData = null;
				cmd.Connection.Close();
				cmd = null;
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			return cnt;
		}
		
		public int ckContentGuidExists(string SourceGuid)
		{
			
			string S = "";
			S = S + " SELECT count(*) from DataSource where SourceGuid = \'" + SourceGuid + "\'";
			CloseConn();
			CkConn();
			int cnt = -1;
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = RSData.GetInt32(0);
				RSData.Close();
				RSData = null;
				cmd.Connection.Close();
				cmd = null;
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			return cnt;
		}
		
		public string getSourceDatatypeByGuid(string SourceGuid)
		{
			
			string S = "";
			S = S + " SELECT[SourceTypeCode] from DataSource where SourceGuid = \'" + SourceGuid + "\'";
			CloseConn();
			CkConn();
			string tVal = "";
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				tVal = RSData.GetValue(0).ToString();
				RSData.Close();
				RSData = null;
				cmd.Connection.Close();
				cmd = null;
				GC.Collect();
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			return tVal;
		}
		
		public void IncrementNextID()
		{
			CloseConn();
			CkConn();
			string S = "update [NextIdNbr] set IdNbr = IdNbr + 1 ";
			bool b = this.ExecuteSqlNewConn(S, false);
		}
		
		public bool SetFolderAsActive(string FolderName, string sAction)
		{
			string SS = " ";
			SS = "update  [EmailFolder] set [SelectedForArchive] = \'" + sAction + "\' where FolderName = \'" + FolderName + "\'";
			bool b = this.ExecuteSqlNewConn(SS, false);
			return b;
		}
		
		public int getNextID()
		{
			string tQuery = "";
			string S = "Select max([IdNbr]) FROM [NextIdNbr] ";
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			
			using (gConn)
			{
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = RSData.GetInt32(0);
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				cnt++;
			}
			
			
			return cnt;
			
		}
		
		public void SetUserDefaultNotifications(string UserID)
		{
			string S = "INSERT INTO [OwnerNotifications]";
			S = S + " ([OwnerNotificationID]";
			S = S + " ,[NotifyText]";
			S = S + " ,[NotifyType]";
			S = S + " ,[ImportanceLevel]";
			S = S + " ,[CreateDate]";
			S = S + " , [ExpireDate]";
			S = S + " ,[ResponseRequired]";
			S = S + " ,[OwnerNotificationDate]";
			S = S + " ,[EnteredById]";
			S = S + " )";
			S = S + " VALUES ";
			S = S + " (\'" + UserID + "\'";
			S = S + " ,\'Please Setup your account\'";
			S = S + " ,\'O\'";
			S = S + " ,\'H\'";
			S = S + " ,getdate()";
			S = S + " ,getdate() + 360";
			S = S + " ,\'Y\'";
			S = S + " ,getdate()";
			S = S + " ,\'AutoUpdate\')";
			
			bool b = this.ExecuteSqlNewConn(S, false);
			
		}
		
		public int CountUserEntries()
		{
			string tQuery = "";
			string S = "Select count(*) from UserData ";
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			
			using (gConn)
			{
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = RSData.GetInt32(0);
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
			}
			
			
			return cnt;
			
		}
		
		public int getGlobalSeachCnt(string UID)
		{
			string tQuery = "";
			string S = "Select count(*) FROM [GlobalSeachResults] where userid = \'" + UID + "\'";
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			
			using (gConn)
			{
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = RSData.GetInt32(0);
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
			}
			
			
			return cnt;
			
		}
		
		public void ckUserInfoData()
		{
			
			string tQuery = "";
			string S = "Select count(*) from UserData where UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			
			using (gConn)
			{
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = RSData.GetInt32(0);
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
			}
			
			if (cnt < 100)
			{
				for (int i = 100; i <= 705; i++)
				{
					string tUid = "PP" + str[i].Trim();
					if (i == 700)
					{
						tUid = "PPADMIN";
					}
					if (i == 701)
					{
						tUid = "PPDEV";
					}
					string S1 = "Select count(*) from UserData where UserID = \'" + tUid + "\'";
					int k = SelCount(S1);
					if (k == 0)
					{
						S1 = "INSERT INTO Userdata";
						S1 = S1 + " (UserID";
						S1 = S1 + " ,UserPW";
						S1 = S1 + " ,ExpireDate";
						S1 = S1 + " ,UserLevel";
						S1 = S1 + " ,UserClassification";
						S1 = S1 + " ,CreateDate";
						S1 = S1 + " ,UserName";
						S1 = S1 + " ,UserEmail";
						S1 = S1 + " ,SecurityQuestion";
						S1 = S1 + " ,SecurityAnswer";
						S1 = S1 + " ,EmergencyPhoneNbr)";
						S1 = S1 + " VALUES ";
						S1 = S1 + " (\'" + tUid + "\'";
						
						if (tUid.Equals("PP621") || tUid.Equals("PPADMIN") || tUid.Equals("PPDEV"))
						{
							S1 = S1 + " ,\'junebug\'";
						}
						else
						{
							S1 = S1 + " ,\'password\'";
						}
						S1 = S1 + " ,getdate() + 720";
						
						if (tUid.Equals("PP621") || tUid.Equals("PPADMIN") || tUid.Equals("PPDEV"))
						{
							S1 = S1 + " ,\'" + "A" + "\'";
						}
						else
						{
							S1 = S1 + " ,\'" + "U" + "\'";
						}
						
						S1 = S1 + " ,\'" + "O" + "\'";
						
						S1 = S1 + " ,\'" + DateTime.Now.ToString() + "\'";
						S1 = S1 + " ,\'Owner Name\'";
						S1 = S1 + " ,\'" + tUid + ".PassagePoint.org" + "\'";
						S1 = S1 + " ,\'" + "You need to set this up." + "\'";
						S1 = S1 + " ,\'" + "You need to set this up." + "\'";
						S1 = S1 + " ,\'" + "555-555-1212" + "\')";
						bool b = this.ExecuteSqlNewConn(S1, false);
						if (b)
						{
							SetUserDefaultNotifications(tUid);
						}
					}
				}
			}
		}
		
		public int SelCount(string S)
		{
			
			string tQuery = "";
			string s1 = "";
			string s2 = "";
			string s3 = "";
			string queryString = S;
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			
			using (gConn)
			{
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = RSData.GetInt32(0);
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
			}
			
			
			return cnt;
			
		}
		
		public bool ckAdminUser(string Userid, string PW)
		{
			bool b = true;
			string S = "Select userid from dco.<SchemaName>.admin_user where userid = \'" + Userid + "\' and password = \'" + PW + "\'";
			S = "Select userid from ADMIN_USER where userid = \'" + Userid + "\' and password = \'" + PW + "\'";
			int i = 0;
			
			SqlDataReader rsData;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				b = true;
			}
			else
			{
				b = false;
			}
			rsData.Close();
			rsData = null;
			return b;
		}
		
		public string getAdminUserId(string Userid, string PW)
		{
			bool b = true;
			string S = "Select useridnbr from admin_user where userid = \'" + Userid + "\' and password = \'" + PW + "\'";
			S = "Select useridnbr from ADMIN_USER where userid = \'" + Userid + "\' and password = \'" + PW + "\'";
			int i = 0;
			string id = "";
			
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				id = rsData.GetValue(0).ToString();
			}
			else
			{
				id = "";
			}
			rsData.Close();
			rsData = null;
			return id;
		}
		
		public string getDocCatIdByName(string CatName)
		{
			bool b = true;
			string S = "Select CategoryID  FROM DocumentCategories  where CategoryName = \'" + CatName + "\' ";
			int i = 0;
			string id = "";
			
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				id = rsData.GetValue(0).ToString();
			}
			else
			{
				id = "";
			}
			rsData.Close();
			rsData = null;
			return id;
		}
		
		public string getUserNameByID(string Userid)
		{
			bool b = true;
			string S = "Select UserName FROM Users where UserID = \'" + Userid + "\' ";
			int i = 0;
			string id = "";
			
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				id = rsData.GetValue(0).ToString();
			}
			else
			{
				id = "";
			}
			rsData.Close();
			rsData = null;
			return id;
		}
		public string getUserLoginByUserid(string Userid)
		{
			bool b = true;
			string S = "Select UserLoginID FROM Users where UserID = \'" + Userid + "\' ";
			int i = 0;
			string id = "";
			
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				id = rsData.GetValue(0).ToString();
			}
			else
			{
				id = "";
			}
			rsData.Close();
			rsData = null;
			return id;
		}
		public void AddProfileFileTypes(string ProfileName, ListBox LB)
		{
			SqlDataReader rsData = null;
			try
			{
				bool b = true;
				string S = "Select [SourceTypeCode] FROM  [LoadProfileItem] where ProfileName = \'" + ProfileName + "\' order by [SourceTypeCode]";
				int i = 0;
				string FileType = "";
				int II = 0;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					while (rsData.Read())
					{
						b = true;
						FileType = rsData.GetValue(0).ToString();
						for (II = 0; II <= LB.Items.Count - 1; II++)
						{
							string tStr = LB.Items[II].ToString();
							if (tStr == FileType)
							{
								b = false;
								break;
							}
						}
						if (b == true)
						{
							LB.Items.Add(FileType);
						}
					}
				}
			}
			catch (Exception ex)
			{
				//WDM Write to log
				this.xTrace(30021, "AddProfileFileTypes", "clsDatabase", ex);
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show((string) ("ERROR AddProfileFileTypes: " + ex.Message));
				}
				LOG.WriteToArchiveLog((string) ("clsDatabase : AddProfileFileTypes : 816 : " + ex.Message));
			}
			
			rsData.Close();
			rsData = null;
			
		}
		public void GetSkipWords(ArrayList A)
		{
			SqlDataReader rsData = null;
			try
			{
				bool b = true;
				string S = "Select [tgtWord] FROM [SkipWords] order by [tgtWord]";
				int i = 0;
				string SkipWord = "";
				int II = 0;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					while (rsData.Read())
					{
						b = true;
						SkipWord = rsData.GetValue(0).ToString().ToUpper();
						A.Add(SkipWord);
					}
				}
			}
			catch (Exception ex)
			{
				//WDM Write to log
				this.xTrace(300277, "GetSkipWords", "clsDatabase", ex);
				LOG.WriteToArchiveLog((string) ("clsDatabase : GetSkipWords : 100 : " + ex.Message));
			}
			
			rsData.Close();
			rsData = null;
			
		}
		public string getDeviceID(string InventoryNo)
		{
			bool b = true;
			string S = (string) ("Select DEVICEID FROM INVENTORY WHERE INVENTORYNO = " + InventoryNo);
			int i = 0;
			string id = "";
			
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				id = rsData.GetValue(0).ToString();
			}
			else
			{
				id = "";
			}
			rsData.Close();
			rsData = null;
			return id;
		}
		
		public string getPhotoTitle(ref int PhotoID, ref string pTitle)
		{
			bool b = true;
			string S = "Select Caption, PhotoID from photos ";
			int i = 0;
			string tempTitle = "";
			
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				while (rsData.Read())
				{
					if (i == PhotoID)
					{
						PhotoID = rsData.GetInt32(1);
						pTitle = rsData.GetValue(0).ToString();
						break;
					}
					i++;
				}
				tempTitle = pTitle;
			}
			else
			{
				tempTitle = "No Photo Found";
			}
			rsData.Close();
			rsData = null;
			return tempTitle;
		}
		
		public string getPhotoTitle(int PhotoID)
		{
			bool b = true;
			string S = "Select Caption from photos where PhotoID = " + PhotoID.ToString();
			int i = 0;
			string id = "";
			
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				id = rsData.GetValue(1).ToString();
			}
			else
			{
				id = "No Photo Found";
			}
			rsData.Close();
			rsData = null;
			return id;
		}
		
		public string getContactID(string FirstName, string LastName)
		{
			bool b = true;
			string SS = "Select ContactID FROM Contacts ";
			SS = SS + " where NameFirst = \'" + FirstName + "\' ";
			SS = SS + " 	and NameLast = \'" + LastName + "\'";
			
			int i = 0;
			string id = "";
			
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(SS, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				id = rsData.GetValue(0).ToString();
			}
			else
			{
				id = "";
			}
			rsData.Close();
			rsData = null;
			return id;
		}
		
		public bool RecordExists(string Tbl, string WhereVar, string CompareVal)
		{
			bool b = true;
			string SQL = "Select * from " + Tbl + " where " + WhereVar + " = \'" + CompareVal + "\'";
			int i = 0;
			
			i = iGetRowCount(SQL);
			if (i == 0)
			{
				b = false;
			}
			return b;
		}
		
		public string getNextKey(string TBL, string tCol)
		{
			
			CloseConn();
			CkConn();
			string tQuery = "";
			string s1 = "";
			string s2 = "";
			string s3 = "";
			string S = (string) ("Select max(" + tCol + ") + 1 from " + TBL);
			string d = "";
			
			//Dim cnt As Double = -1
			
			SqlDataReader rsData = null;
			bool b = false;
			try
			{
				//rsData = SqlQry(sql, rsData)
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				rsData.Read();
				d = rsData.GetValue(0).ToString();
				if (d.Length == 0)
				{
					d = "0";
				}
				//Dim ss As String = ""
				//ss = rsData.GetValue(0).ToString
				//cnt = rsData.Item(0)
				rsData.Close();
				//End Using
			}
			catch (Exception ex)
			{
				//WDM Write to log
				xTrace(1010177, (string) ("Error 99.23.1x - " + S), "getNextKey", ex);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getNextKey : 908 : " + ex.Message));
			}
			
			return d;
		}
		
		public string getNextKey(string TBL, string tCol, string SQL)
		{
			
			string tQuery = "";
			string s1 = "";
			string s2 = "";
			string s3 = "";
			//Dim sql As String = "Select max(" + tCol + ") + 1 from " + TBL
			string d = "";
			
			//Dim cnt As Double = -1
			
			SqlDataReader rsData = null;
			bool b = false;
			
			b = SqlQry(SQL, ref rsData);
			
			rsData.Read();
			d = rsData.GetValue(0).ToString();
			
			rsData.Close();
			
			return d;
		}
		
		public string getKeyByLookupCol(string TBL, string kCol, string tCol, string LookUpVal)
		{
			
			string tQuery = "";
			string s1 = "";
			string s2 = "";
			string s3 = "";
			string sql = "Select " + kCol + " from " + TBL + " where " + tCol + " = \'" + LookUpVal + "\'";
			string d = "";
			
			//Dim cnt As Double = -1
			
			SqlDataReader rsData = null;
			bool b = false;
			
			b = SqlQry(sql, ref rsData);
			
			if (rsData.HasRows)
			{
				rsData.Read();
				d = rsData.GetValue(0).ToString();
			}
			else
			{
				d = "";
			}
			rsData.Close();
			//End Using
			return d;
		}
		
		public string getKeyByLookupCol(string TBL, string kCol, string tCol, int LookUpVal)
		{
			
			string tQuery = "";
			string s1 = "";
			string s2 = "";
			string s3 = "";
			string sql = (string) ("Select " + kCol + " from " + TBL + " where " + tCol + " = " + LookUpVal.ToString());
			string d = "";
			
			//Dim cnt As Double = -1
			
			SqlDataReader rsData = null;
			bool b = false;
			b = SqlQry(sql, ref rsData);
			if (rsData.HasRows)
			{
				rsData.Read();
				d = rsData.GetValue(0).ToString();
			}
			else
			{
				d = "";
			}
			rsData.Close();
			//End Using
			return d;
		}
		
		public int ValidateUserByUid(string uid, string upw)
		{
			
			string S = "Select count(*) as CNT from Users where UserID = \'" + uid + "\' and UserPassword = \'" + upw + "\'";
			int i = -1;
			
			using (gConn)
			{
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				try
				{
					RSData.Read();
					i = RSData.GetInt32(0);
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				catch (Exception ex)
				{
					//WDM Write to log
					i = 0;
					LOG.WriteToArchiveLog((string) ("clsDatabase : ValidateUserByUid : 965 : " + ex.Message));
				}
				
			}
			
			return i;
		}
		public bool ValidateContentOwnership(string tgtGuid, string contentTypeCode)
		{
			
			string S = "";
			string uid = modGlobals.gCurrUserGuidID;
			
			if (contentTypeCode.ToUpper().Equals(".MSG"))
			{
				S = "Select count(*) as CNT from EMAIL where Emailguid = \'" + tgtGuid + "\' and UserID = \'" + uid + "\' ";
			}
			else
			{
				S = "Select count(*) as CNT from DataSource where SourceGuid = \'" + tgtGuid + "\' and DataSourceOwnerUserID = \'" + uid + "\' ";
			}
			
			bool isOwner = false;
			int i = -1;
			
			using (gConn)
			{
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				try
				{
					// Call Read before accessing data.
					RSData.Read();
					i = RSData.GetInt32(0);
					//Dim ss As String = ""
					//ss = RSData.GetValue(0).ToString
					//cnt = RSData.Item(0)
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
					if (i > 0)
					{
						isOwner = true;
					}
					else
					{
						isOwner = false;
					}
				}
				catch (Exception ex)
				{
					//WDM Write to log
					i = 0;
					LOG.WriteToArchiveLog((string) ("clsDatabase : ValidateContentOwnership : 100 : " + ex.Message));
					isOwner = false;
				}
				
			}
			
			return isOwner;
		}
		
		public bool ValidateCoOwner(string OwnerGuid)
		{
			
			string S = "Select count(*) from CoOwner where PreviousOwnerUserID = \'" + OwnerGuid + "\' and CurrentOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\'";
			string uid = modGlobals.gCurrUserGuidID;
			
			//If contentTypeCode.ToUpper.Equals(".MSG") Then
			//    S = "Select count(*) as from EMAIL where Emailguid = '" + tgtGuid  + "' and UserID = '" + uid + "' "
			//Else
			//    S = "Select count(*) as from DataSource where SourceGuid = '" + tgtGuid  + "' and DataSourceOwnerUserID = '" + uid + "' "
			//End If
			
			bool isCoOwner = false;
			int i = -1;
			
			using (gConn)
			{
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				try
				{
					// Call Read before accessing data.
					RSData.Read();
					i = RSData.GetInt32(0);
					//Dim ss As String = ""
					//ss = RSData.GetValue(0).ToString
					//cnt = RSData.Item(0)
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
					if (i > 0)
					{
						isCoOwner = true;
					}
					else
					{
						isCoOwner = false;
					}
				}
				catch (Exception ex)
				{
					//WDM Write to log
					i = 0;
					LOG.WriteToArchiveLog((string) ("clsDatabase : ValidateContentOwnership : 100 : " + ex.Message));
					isCoOwner = false;
				}
				
			}
			
			return isCoOwner;
		}
		public bool ValidateCoOwnerOfContent(string ContentGuid, string ContentType)
		{
			
			string OwnerGuid = getContentOwnerGuid(ContentGuid, ContentType);
			
			if (OwnerGuid.Trim.Length == 0)
			{
				return false;
			}
			
			string S = "Select count(*) from CoOwner where PreviousOwnerUserID = \'" + OwnerGuid + "\' and CurrentOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\'";
			string uid = modGlobals.gCurrUserGuidID;
			
			bool isCoOwner = false;
			int i = -1;
			
			using (gConn)
			{
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				try
				{
					// Call Read before accessing data.
					RSData.Read();
					i = RSData.GetInt32(0);
					//Dim ss As String = ""
					//ss = RSData.GetValue(0).ToString
					//cnt = RSData.Item(0)
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
					if (i > 0)
					{
						isCoOwner = true;
					}
					else
					{
						isCoOwner = false;
					}
				}
				catch (Exception ex)
				{
					//WDM Write to log
					i = 0;
					LOG.WriteToArchiveLog((string) ("clsDatabase : ValidateContentOwnership : 100 : " + ex.Message));
					isCoOwner = false;
				}
				
			}
			
			return isCoOwner;
		}
		public string getContentOwnerGuid(string tgtGuid, string contentTypeCode)
		{
			
			string S = "";
			string OwnerGuid = "";
			
			if (contentTypeCode.ToUpper().Equals(".MSG"))
			{
				S = "Select Userid from EMAIL where Emailguid = \'" + tgtGuid + "\'";
			}
			else
			{
				S = "Select DataSourceOwnerUserID from DataSource where SourceGuid = \'" + tgtGuid + "\' ";
			}
			
			bool isOwner = false;
			int i = -1;
			
			using (gConn)
			{
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				try
				{
					// Call Read before accessing data.
					if (RSData.HasRows)
					{
						RSData.Read();
						OwnerGuid = RSData.GetValue(0).ToString();
						RSData.Close();
						RSData = null;
						command.Connection.Close();
						command = null;
					}
					else
					{
						OwnerGuid = "";
					}
				}
				catch (Exception ex)
				{
					//WDM Write to log
					i = 0;
					LOG.WriteToArchiveLog((string) ("clsDatabase : ValidateContentOwnership : 100 : " + ex.Message));
				}
			}
			
			return OwnerGuid;
		}
		public int ValidateUserId(string uid)
		{
			
			string S = "Select count(*) as CNT from Userdata where UserID = \'" + uid + "\'";
			int i = -1;
			
			using (gConn)
			{
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				try
				{
					// Call Read before accessing data.
					RSData.Read();
					i = RSData.GetInt32(0);
					//Dim ss As String = ""
					//ss = RSData.GetValue(0).ToString
					//cnt = RSData.Item(0)
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				catch (Exception ex)
				{
					//WDM Write to log
					i = 0;
					LOG.WriteToArchiveLog((string) ("clsDatabase : ValidateUserId : 980 : " + ex.Message));
				}
				
			}
			
			return i;
		}
		
		public string getAuthority(string uid)
		{
			if (uid == null)
			{
				//"Error","User id has not been set...")
				return "";
			}
			string S = "";
			S = S + " Select Admin ";
			S = S + " FROM Users ";
			S = S + " where UserID = \'" + uid + "\'";
			string Auth = "";
			string queryString = S;
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			
			SqlDataReader rsData = null;
			bool b = false;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			
			rsData.Read();
			Auth = rsData.GetValue(0).ToString();
			rsData.Close();
			rsData = null;
			
			string AuthDesc = "User";
			if (Auth.ToUpper().Equals("A"))
			{
				AuthDesc = "Admin";
			}
			if (Auth.ToUpper().Equals("G"))
			{
				AuthDesc = "Global Searcher";
			}
			if (Auth.ToUpper().Equals("S"))
			{
				AuthDesc = "Super Admin";
			}
			
			return AuthDesc;
			
		}
		
		public string getPhotoExt(string pid)
		{
			if (pid == null)
			{
				//"Error","User id has not been set...")
				return "";
			}
			string S = "";
			S = S + " Select [PhotoFqn]";
			S = S + " FROM Photos ";
			S = S + " where PhotoID = \'" + pid + "\'";
			string Auth = "";
			string queryString = S;
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			
			SqlDataReader rsData = null;
			bool b = false;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			rsData.Read();
			Auth = rsData.GetValue(0).ToString();
			rsData.Close();
			rsData = null;
			
			return Auth;
			
		}
		
		public string getPhotoImgType(string pid)
		{
			if (pid == null)
			{
				//"Error","User id has not been set...")
				return "";
			}
			string S = "";
			S = S + " Select ImgType ";
			S = S + " FROM Photos ";
			S = S + " where PhotoID = \'" + pid + "\'";
			string Auth = "";
			string queryString = S;
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			
			SqlDataReader rsData = null;
			bool b = false;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			rsData.Read();
			Auth = rsData.GetValue(0).ToString();
			rsData.Close();
			rsData = null;
			
			return Auth;
			
		}
		
		public string getUserType(string uid)
		{
			
			string S = "";
			S = S + " Select [UserID]";
			S = S + " ,[UserPW]";
			S = S + " ,[ExpireDate]";
			S = S + " ,[UserLevel]";
			S = S + " ,[UserNbr]";
			S = S + " ,[UserClassification]";
			S = S + " ,[CreateDate]";
			S = S + " FROM Userdata";
			S = S + " where UserID = \'" + uid + "\'";
			string Auth = "";
			string queryString = S;
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			
			SqlDataReader rsData = null;
			bool b = false;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			rsData.Read();
			Auth = rsData.GetValue(5).ToString();
			rsData.Close();
			rsData = null;
			
			return Auth.Trim();
			
		}
		public string getSourceCrc(string SourceGuid, string SourceType)
		{
			
			try
			{
				string S = "";
				if (SourceType.Equals("EMAIL"))
				{
					S = "Select CRC from email where EmailGuid = \'" + SourceGuid + "\'";
				}
				else
				{
					S = "Select AttributeValue from SourceAttribute where SourceGuid = \'" + SourceGuid + "\' AND AttributeName = \'CRC\'";
				}
				string CRC = "";
				string queryString = S;
				CloseConn();
				CkConn();
				int cnt = -1;
				SqlDataReader rsData = null;
				bool b = false;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				rsData.Read();
				CRC = rsData.GetValue(0).ToString();
				rsData.Close();
				rsData = null;
				return CRC.Trim;
			}
			catch (Exception)
			{
				return "";
			}
		}
		
		public int getSourceLength(string SourceGuid, string SourceType)
		{
			
			try
			{
				string S = "";
				if (SourceType.Equals("EMAIL"))
				{
					S = "Select MsgSize from Email where EmailGuid = \'" + SourceGuid + "\'";
				}
				else
				{
					S = "Select FileLength from DataSource where SourceGuid = \'" + SourceGuid + "\'";
				}
				int CRC = 0;
				string queryString = S;
				CloseConn();
				CkConn();
				int cnt = -1;
				SqlDataReader rsData = null;
				bool b = false;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				rsData.Read();
				CRC = rsData.GetInt32(0);
				rsData.Close();
				rsData = null;
				return CRC;
			}
			catch (Exception)
			{
				return -1;
			}
		}
		
		public bool SqlQry(string sql, ref SqlDataReader rsData)
		{
			
			
			if (dDebug)
			{
				LOG.WriteToArchiveLog("____________________________________________");
				LOG.WriteToArchiveLog((string) ("Started: " + DateTime.Now.ToString()));
				LOG.WriteToArchiveLog(sql);
				
				Console.WriteLine("____________________________________________");
				Console.WriteLine("Started: " + DateTime.Now.ToString());
				Console.WriteLine(sql);
			}
			
			SqlCommand CMDX = new SqlCommand();
			
			string queryString = sql;
			bool rc = false;
			
			rsData = null;
			
			if (gConn.State == System.Data.ConnectionState.Open)
			{
				gConn.Close();
			}
			
			CloseConn();
			CkConn();
			
			if (dDebug)
			{
				Console.WriteLine("SQLQRY Started: " + DateTime.Now.ToString());
			}
			if (dDebug)
			{
				LOG.WriteToArchiveLog((string) ("SQLQRY Started: " + DateTime.Now.ToString()));
			}
			
			try
			{
				//Dim CMDX As New SqlCommand(sql, gConn)
				CMDX.Connection = gConn;
				CMDX.ExecuteReader();
				
				rsData = CMDX.ExecuteReader();
				CMDX.Dispose();
				CMDX = null;
				return true;
			}
			catch (Exception ex)
			{
				this.xTrace(3100771, "SqlQry", "clsDatabase", ex);
				//WDM Write to log
				LOG.WriteToArchiveLog((string) ("clsDatabase : SqlQry : 1085 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : SqlQry : 1021 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : SqlQry : 1022 : " + ex.Message));
				return false;
			}
		}
		
		public int NewID(string Tbl, string idCol)
		{
			string s = "";
			s = (string) ("Select max(" + idCol + ")+1 from " + Tbl);
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				int iStr = rsData.GetInt32(0);
				rsData.Close();
				rsData = null;
				return iStr;
			}
			else
			{
				rsData.Close();
				rsData = null;
				return 0;
			}
			
		}
		
		public string getMaxPhotoID()
		{
			string s = "";
			s = "Select max(photoid) from photos ";
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				string iStr = rsData.GetValue(0).ToString();
				rsData.Close();
				rsData = null;
				return iStr;
			}
			else
			{
				rsData.Close();
				rsData = null;
				return "0";
			}
			
		}
		
		public string getPhotoIDBycaption(string Caption)
		{
			string s = "";
			s = "Select photoid from photos where caption = \'" + Caption + "\'";
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				string iStr = rsData.GetValue(0).ToString();
				rsData.Close();
				rsData = null;
				return iStr;
			}
			else
			{
				rsData.Close();
				rsData = null;
				return "0";
			}
			
		}
		
		public string getUserPW(string UID)
		{
			string s = "";
			s = "Select UserPW from userdata where userid = \'" + UID + "\'";
			SqlDataReader rsData = null;
			int I = 0;
			string iStr = "";
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				iStr = rsData.GetValue(0).ToString();
				rsData.Close();
				rsData = null;
			}
			else
			{
				rsData.Close();
				rsData = null;
			}
			return iStr.Trim();
		}
		
		public string getFqnFromGuid(string SourceGuid)
		{
			string s = "";
			s = "Select FQN FROM DataSource Where SourceGuid = \'" + SourceGuid + "\'";
			SqlDataReader rsData = null;
			int I = 0;
			string iStr = "";
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			
			if (rsData.HasRows)
			{
				rsData.Read();
				iStr = rsData.GetValue(0).ToString();
				rsData.Close();
				//rsData = Nothing
			}
			else
			{
				rsData.Close();
				//rsData = Nothing
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			command.Dispose();
			command = null;
			
			if (CONN.State == ConnectionState.Open)
			{
				CONN.Close();
			}
			CONN.Dispose();
			
			return iStr.Trim();
		}
		
		public string getFilenameByGuid(string SourceGuid)
		{
			string s = "";
			s = "Select SourceName FROM DataSource Where SourceGuid = \'" + SourceGuid + "\'";
			SqlDataReader rsData = null;
			int I = 0;
			string iStr = "";
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				iStr = rsData.GetValue(0).ToString();
				rsData.Close();
				rsData = null;
			}
			else
			{
				rsData.Close();
				rsData = null;
			}
			return iStr.Trim();
		}
		
		public string getUserGuidID(string UserLoginId)
		{
			string s = "";
			s = "Select [UserID] FROM  [Users] Where UserLoginID = \'" + UserLoginId + "\'";
			int I = 0;
			string iStr = "";
			SqlDataReader rsData = null;
			try
			{
				
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(s, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					rsData.Read();
					iStr = rsData.GetValue(0).ToString();
					rsData.Close();
					rsData = null;
				}
				else
				{
					rsData.Close();
					rsData = null;
				}
			}
			catch (Exception)
			{
				MessageBox.Show("Could not attach to the server with the current loginid of: " + UserLoginId + " - continuing.");
			}
			
			return iStr.Trim();
		}
		
		public string getQuickRefIdNbr(string QuickRefName, string UserGuidID)
		{
			string s = "";
			s = "Select  [QuickRefIdNbr] FROM [QuickRef] where QuickRefName = \'" + QuickRefName + "\' and UserID = \'" + UserGuidID + "\'";
			SqlDataReader rsData = null;
			int I = 0;
			string iStr = "";
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				iStr = rsData.GetValue(0).ToString();
				rsData.Close();
				rsData = null;
			}
			else
			{
				iStr = "-1";
				rsData.Close();
				rsData = null;
			}
			return iStr.Trim();
		}
		
		public string getNextDocID()
		{
			
			string s = "";
			s = "Select max (DocumentID) FROM [Documents]";
			SqlDataReader rsData = null;
			int I = 0;
			string iStr = "";
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				iStr = rsData.GetValue(0).ToString();
				rsData.Close();
				rsData = null;
			}
			else
			{
				rsData.Close();
				rsData = null;
			}
			return iStr.Trim();
			
		}
		
		public string getDocIdByFqn(string FQN)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			string s = "";
			s = "Select DocumentID FROM [Documents] where DocFqn = \'" + FQN + "\'";
			SqlDataReader rsData = null;
			int I = 0;
			string iStr = "";
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				iStr = rsData.GetValue(0).ToString();
				rsData.Close();
				rsData = null;
			}
			else
			{
				rsData.Close();
				rsData = null;
			}
			return iStr.Trim();
			
		}
		
		public bool ckDocExistByFqn(string FQN)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			string s = "";
			s = "Select DocumentID FROM [Documents] where DocFqn = \'" + FQN + "\'";
			SqlDataReader rsData = null;
			int I = 0;
			bool B = false;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Close();
				rsData = null;
				B = true;
			}
			else
			{
				rsData.Close();
				rsData = null;
				B = false;
			}
			return B;
			
		}
		
		public int ExecCountSQL(string S)
		{
			int I = 0;
			try
			{
				SqlDataReader rsData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					rsData.Read();
					string iStr = rsData.GetValue(0).ToString();
					I = int.Parse(iStr);
					rsData.Close();
					rsData = null;
				}
				else
				{
					rsData.Close();
					rsData = null;
					I = 0;
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase : ExecCountSQL : 0001 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : ExecCountSQL : 0001a : " + S));
				I = -1;
			}
			return I;
		}
		
		public bool VerifyUserID(string UID)
		{
			string s = "";
			s = "Select count(*) from Userdata where Userid = \'" + UID + "\'";
			SqlDataReader rsData = null;
			int I = 0;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				string iStr = rsData.GetValue(0).ToString();
				I = int.Parse(iStr);
				rsData.Close();
				rsData = null;
				if (I > 0)
				{
					return true;
				}
				else
				{
					return false;
				}
			}
			else
			{
				rsData.Close();
				rsData = null;
				return false;
			}
			
		}
		
		public bool ItemExists(string Tbl, string idCol, string ColVal, string ColType)
		{
			string s = "";
			bool b = false;
			CloseConn();
			CkConn();
			if (ColType == "N")
			{
				s = (string) ("Select count(*) from " + Tbl + " where " + idCol + " = " + ColVal);
			}
			else
			{
				s = "Select count(*) from " + Tbl + " where " + idCol + " = \'" + ColVal + "\'";
			}
			
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				int iStr = rsData.GetInt32(0);
				if (iStr > 0)
				{
					b = true;
				}
				else
				{
					b = false;
				}
			}
			else
			{
				return b;
			}
			rsData.Close();
			rsData = null;
			return b;
		}
		
		public bool ValidateDeviceID(string ID)
		{
			string s = "";
			if (ID.Length == 0)
			{
				return false;
			}
			bool b = false;
			s = (string) ("Select count(*) from Devices where deviceid = " + ID);
			
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				int iStr = rsData.GetInt32(0);
				if (iStr > 0)
				{
					b = true;
				}
				else
				{
					b = false;
				}
			}
			else
			{
				return b;
			}
			rsData.Close();
			rsData = null;
			return b;
		}
		
		public SqlDataReader xxSqlQry(string sql)
		{
			lock(this)
			{
				try
				{
					//'Session("ActiveError") = False
					bool dDebug = true;
					string queryString = sql;
					bool rc = false;
					SqlDataReader rsDataQry = null;
					
					CloseConn();
					CkConn();
					
					if (gConn.State == System.Data.ConnectionState.Open)
					{
						gConn.Close();
					}
					
					CloseConn();
					CkConn();
					
					SqlCommand command = new SqlCommand(sql, gConn);
					
					try
					{
						rsDataQry = command.ExecuteReader();
					}
					catch (Exception ex)
					{
						LOG.WriteToArchiveLog((string) ("clsDatabase : SqlQry : 1319 : " + ex.Message));
						LOG.WriteToArchiveLog((string) ("clsDatabase : SqlQry : 1319 Server too Busy : " + "\r\n" + sql));
					}
					
					command.Dispose();
					command = null;
					
					return rsDataQry;
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("ERROR: SqlQry 100 - Server too busy: " + ex.Message));
				}
			}
		}
		
		public void SqlQryNewThread(string tSql, SqlConnection tConn, ref SqlDataReader rsDataQry)
		{
			
			bool rc = false;
			
			//SyncLock Me
			//Dim tConn As New SqlConnection
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection xConn = new SqlConnection(CS);
			xConn.Open();
			
			SqlCommand command = new SqlCommand(tSql, xConn);
			
			try
			{
				rsDataQry = command.ExecuteReader();
			}
			catch (Exception ex)
			{
				xTrace(10081, "clsDataBase:SqlQry", ex.Message);
				xTrace(10092, "clsDataBase:SqlQry", ex.StackTrace);
				xTrace(10033, "clsDataBase:SqlQry", tSql);
				LOG.WriteToArchiveLog((string) ("clsDatabase : SqlQryNewThread : 1337 : " + ex.Message));
			}
			
			command.Dispose();
			command = null;
			
			//End SyncLock
			
			
		}
		
		public SqlDataReader SqlQry(string sql, SqlConnection Conn)
		{
			//'Session("ActiveError") = False
			bool dDebug = false;
			string queryString = sql;
			bool rc = false;
			SqlDataReader rsDataQry = null;
			
			if (Conn.State != System.Data.ConnectionState.Open)
			{
				Conn.Open();
			}
			
			SqlCommand command = new SqlCommand(sql, Conn);
			
			try
			{
				rsDataQry = command.ExecuteReader();
			}
			catch (Exception ex)
			{
				//'Session("ActiveError") = True
				//'Session("ErrMsg") = ex.Message
				//'Session("ErrStack") = ex.StackTrace + vbCrLf + vbCrLf + sql
				xTrace(18001, "clsDataBase:SqlQry", ex.Message);
				xTrace(19002, "clsDataBase:SqlQry", ex.StackTrace);
				xTrace(13003, "clsDataBase:SqlQry", sql);
				LOG.WriteToArchiveLog((string) ("clsDatabase : SqlQry : 1352 : " + ex.Message));
			}
			
			//If dDebug Then log.WriteToArchiveLog("SQLQRY Ended: " + Now.tostring)
			//If dDebug Then Console.WriteLine("SQLQRY Ended: " + Now.tostring)
			
			command.Dispose();
			command = null;
			
			return rsDataQry;
		}
		
		public SqlDataReader SqlQryNewConn(string sql)
		{
			//'Session("ActiveError") = False
			bool dDebug = false;
			string queryString = sql;
			bool rc = false;
			SqlDataReader rsDataQry = null;
			
			SqlConnection CN = new SqlConnection(getGateWayConnStr(modGlobals.gGateWayID));
			
			if (CN.State == ConnectionState.Closed)
			{
				CN.Open();
			}
			
			SqlCommand command = new SqlCommand(sql, CN);
			
			try
			{
				rsDataQry = command.ExecuteReader();
			}
			catch (Exception ex)
			{
				//'Session("ActiveError") = True
				//'Session("ErrMsg") = ex.Message
				//'Session("ErrStack") = ex.StackTrace + vbCrLf + vbCrLf + sql
				xTrace(10301, "clsDataBase:SqlQry", ex.Message);
				xTrace(10042, "clsDataBase:SqlQry", ex.StackTrace);
				xTrace(10035, "clsDataBase:SqlQry", sql);
				LOG.WriteToArchiveLog((string) ("clsDatabase : SqlQryNewConn : 1368a : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : SqlQryNewConn : 1368b : " + sql));
			}
			
			//If dDebug Then log.WriteToArchiveLog("SQLQRY Ended: " + Now.tostring)
			//If dDebug Then Console.WriteLine("SQLQRY Ended: " + Now.tostring)
			
			command.Dispose();
			command = null;
			
			return rsDataQry;
		}
		public void UpdateRemoteMachine(string CompanyID, string MachineID, string Applied, string LicenseID)
		{
			string RemoteConnStr = "";
			
			CompanyID = UTIL.RemoveSingleQuotes(CompanyID);
			MachineID = UTIL.RemoveSingleQuotes(MachineID);
			
			RemoteConnStr = System.Configuration.ConfigurationManager.AppSettings["HELP.DB"];
			RemoteConnStr = ENC.AES256DecryptString(RemoteConnStr);
			
			SqlConnection CN = new SqlConnection(RemoteConnStr);
			
			if (CN.State == ConnectionState.Closed)
			{
				CN.Open();
			}
			
			string QrySql = (string) ("UPDATE [License] SET [MachineID] = \'" + MachineID + "\' ,[Applied] = " + Applied + " WHERE CompanyID = \'" + CompanyID + "\' and LicenseID = " + LicenseID);
			
			SqlCommand command = new SqlCommand(QrySql, CN);
			int iRows = command.ExecuteNonQuery();
			
			if (iRows == 0)
			{
				LOG.WriteToArchiveLog("ERROR 132.34.1 - Failed to udpate remote Machine ID.");
			}
			
			//UPDATE [License] SET [MachineID] = 'XX' ,[Applied] = 1 WHERE CompanyID = 'XX' and LicenseID = 0
		}
		public SqlDataReader SqlQryRemoteConn(string QrySql)
		{
			//'Session("ActiveError") = False
			bool dDebug = false;
			bool rc = false;
			SqlDataReader rsDataQry = null;
			string RemoteConnStr = "";
			
			RemoteConnStr = System.Configuration.ConfigurationManager.AppSettings["HELP.DB"];
			RemoteConnStr = ENC.AES256DecryptString(RemoteConnStr);
			
			SqlConnection CN = new SqlConnection(RemoteConnStr);
			
			if (CN.State == ConnectionState.Closed)
			{
				CN.Open();
			}
			
			SqlCommand command = new SqlCommand(QrySql, CN);
			
			try
			{
				rsDataQry = command.ExecuteReader();
			}
			catch (Exception ex)
			{
				//'Session("ActiveError") = True
				//'Session("ErrMsg") = ex.Message
				//'Session("ErrStack") = ex.StackTrace + vbCrLf + vbCrLf + sql
				xTrace(104501, "clsDataBase:SqlQryRemoteConn", ex.Message);
				xTrace(106502, "clsDataBase:SqlQryRemoteConn", ex.StackTrace);
				xTrace(107503, "clsDataBase:SqlQryRemoteConn", QrySql);
				LOG.WriteToArchiveLog((string) ("clsDatabase : SqlQryRemoteConn : 1368 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : SqlQryRemoteConn : 1368a : " + QrySql));
			}
			
			//If dDebug Then log.WriteToArchiveLog("SQLQRY Ended: " + Now.tostring)
			//If dDebug Then Console.WriteLine("SQLQRY Ended: " + Now.tostring)
			
			command.Dispose();
			command = null;
			
			return rsDataQry;
		}
		
		public SqlDataReader SqlQryNewConn(string sql, string ConnectionString)
		{
			//'Session("ActiveError") = False
			bool dDebug = false;
			string queryString = sql;
			bool rc = false;
			SqlDataReader rsDataQry = null;
			
			SqlConnection CN = new SqlConnection(ConnectionString);
			
			if (CN.State == ConnectionState.Closed)
			{
				CN.Open();
			}
			
			SqlCommand command = new SqlCommand(sql, CN);
			
			try
			{
				rsDataQry = command.ExecuteReader();
			}
			catch (Exception ex)
			{
				//'Session("ActiveError") = True
				//'Session("ErrMsg") = ex.Message
				//'Session("ErrStack") = ex.StackTrace + vbCrLf + vbCrLf + sql
				xTrace(80401, "clsDataBase:SqlQry", ex.Message);
				xTrace(80052, "clsDataBase:SqlQry", ex.StackTrace);
				xTrace(80036, "clsDataBase:SqlQry", sql);
				LOG.WriteToArchiveLog((string) ("clsDatabase : SqlQryNewConn : 1368aa : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : SqlQryNewConn : 1368bb : " + sql));
			}
			
			//If dDebug Then log.WriteToArchiveLog("SQLQRY Ended: " + Now.tostring)
			//If dDebug Then Console.WriteLine("SQLQRY Ended: " + Now.tostring)
			
			command.Dispose();
			command = null;
			
			return rsDataQry;
		}
		
		public void setGlobalConection()
		{
			CloseConn();
			CkConn();
		}
		
		public void closeGlobalConection()
		{
			if (gConn.State == System.Data.ConnectionState.Open)
			{
				gConn.Close();
			}
		}
		
		public void ckSiteFacility(string FacilityID)
		{
			string NewKey = FacilityID.Trim();
			string H = Conversion.Hex(int.Parse(NewKey));
			
			int iCnt = SelCount((string) ("Select count(*) from sites where facilityID = " + FacilityID));
			if (iCnt > 0)
			{
				return;
			}
			
			iCnt = SelCount("Select count(*) from sites where sitecode = \'?" + H + "\'");
			if (iCnt > 0)
			{
				return;
			}
			
			int NextDispOrder = NewID("SITES", "SiteDisplayOrder");
			
			string S = "";
			S = S + " insert into sites (sitecode, sitename, facilityid, sitemenuname, SiteDisplayOrder)";
			S = S + " values ";
			S = S + " (\'?" + H + "\', \'Undefined Site\', " + FacilityID + ", \'NA\',\'" + NextDispOrder.ToString() + "\')";
			
			bool b = ExecuteSqlNewConn(S, false);
			
		}
		
		public bool ExecuteSqlTx(string sql)
		{
			
			string TxName = "TX001";
			bool rc = false;
			
			//'Session("ActiveError") = False
			//'Session("ErrMsg") = ""
			//'Session("ErrStack") = ""
			
			CloseConn();
			CkConn();
			
			using (gConn)
			{
				SqlCommand dbCmd = gConn.CreateCommand();
				SqlTransaction transaction;
				
				// Start a local transaction
				transaction = gConn.BeginTransaction(TxName);
				
				// Must assign both transaction object and connection
				// to dbCmd object for a pending local transaction.
				dbCmd.Connection = gConn;
				dbCmd.Transaction = transaction;
				
				try
				{
					dbCmd.CommandText = sql;
					dbCmd.ExecuteNonQuery();
					// Attempt to commit the transaction.
					transaction.Commit();
					
					//Audit(sql)
					
					//Dim debug As Boolean = False
					//If debug Then
					//    Console.WriteLine("Successful execution: " + vbCrLf + sql)
					//End If
					rc = true;
				}
				catch (Exception ex)
				{
					rc = false;
					
					//'Session("ActiveError") = True
					//'Session("ErrMsg") = "SQL Error check table PgmTrace: " + ex.Message
					//'Session("ErrStack") = "Stack Trace: " + vbCrLf + vbCrLf + ex.StackTrace
					LOG.WriteToArchiveLog((string) ("clsDatabase : ExecuteSqlTx : 1412.1 : " + ex.Message));
					xTrace(1991, "ExecuteSql: ", "-----------------------");
					xTrace(1992, "ExecuteSql: ", ex.Message.ToString());
					xTrace(2993, "ExecuteSql: ", ex.StackTrace.ToString());
					xTrace(3994, "ExecuteSql: ", sql);
					
					EL.Add("error 12.23.67: " + ex.Message);
					
					// Attempt to roll back the transaction.
					try
					{
						transaction.Rollback();
					}
					catch (Exception ex2)
					{
						// This catch block will handle any errors that may have occurred
						// on the server that would cause the rollback to fail, such as
						// a closed connection.
						Console.WriteLine("Rollback Exception Type: {0}", ex2.GetType());
						Console.WriteLine("  Message: {0}", ex2.Message);
						LOG.WriteToArchiveLog((string) ("clsDatabase : ExecuteSqlTx : 1412 : " + ex2.Message));
					}
				}
			}
			
			
			return rc;
		}
		
		public bool ExecuteSqlNoTx(string sql)
		{
			
			bool rc = false;
			
			//'Session("ActiveError") = False
			//'Session("ErrMsg") = ""
			//'Session("ErrStack") = ""
			
			CloseConn();
			CkConn();
			
			using (gConn)
			{
				
				SqlCommand dbCmd = gConn.CreateCommand();
				
				// Must assign both transaction object and connection
				// to dbCmd object for a pending local transaction.
				dbCmd.Connection = gConn;
				
				try
				{
					dbCmd.CommandText = sql;
					dbCmd.ExecuteNonQuery();
					rc = true;
				}
				catch (Exception ex)
				{
					rc = false;
					
					//'Session("ActiveError") = True
					//'Session("ErrMsg") = "ExecuteNoTx SQL: " + vbCrLf + sql + vbCrLf + vbCrLf + ex.Message
					//'Session("ErrStack") = "Stack Trace: " + vbCrLf + vbCrLf + ex.StackTrace
					
					xTrace(87, "ExecuteSqlNoTx: ", "-----------------------");
					xTrace(134360, "ExecuteSqlNoTx: ", ex.Message.ToString());
					xTrace(234361, "ExecuteSqlNoTx: ", ex.StackTrace.ToString());
					xTrace(334362, "ExecuteSqlNoTx: ", sql);
					
					EL.Add("error 12.23.68: " + ex.Message);
					
					LOG.WriteToArchiveLog((string) ("clsDatabase : ExecuteSqlNoTx : 1428 : " + ex.Message));
				}
			}
			
			
			return rc;
		}
		
		public bool xExecuteSqlNewConn(string sql, bool ValidateOwnerShip)
		{
			if (ValidateOwnerShip == true)
			{
				if (TgtGuid.Length == 0)
				{
					if (modGlobals.gRunUnattended == false)
					{
						MessageBox.Show("ERROR 666.01 - TgtGuid left blank and is required, contact Dale as this is an error.");
					}
					LOG.WriteToArchiveLog("ERROR 666.01 - TgtGuid left blank and is required, contact Dale as this is an error.");
					return false;
				}
				bool isOwner = ckContentOwnership(TgtGuid, modGlobals.gCurrUserGuidID);
				if (isOwner == false)
				{
					if (modGlobals.gRunUnattended == false)
					{
						MessageBox.Show("ERROR 666.01a - This will be removed - tried to update content you do not own, ABORTED!");
					}
					LOG.WriteToTraceLog("ExecuteSql: User \'" + modGlobals.gCurrUserGuidID + "\' tried to change \'" + TgtGuid + "\' w/o ownership.");
					return false;
				}
			}
			
			bool rc = false;
			CloseConn();
			CkConn();
			using (gConn)
			{
				SqlCommand dbCmd = gConn.CreateCommand();
				// Must assign both transaction object and connection
				// to dbCmd object for a pending local transaction.
				dbCmd.Connection = gConn;
				try
				{
					dbCmd.CommandText = sql;
					dbCmd.ExecuteNonQuery();
					return true;
				}
				catch (Exception ex)
				{
					rc = false;
					if (ex.Message.IndexOf("The DELETE statement conflicted with the REFERENCE") + 1 > 0)
					{
						MessageBox.Show((string) ("It appears this user has DATA within the repository associated to them and cannot be deleted." + "\r\n" + "\r\n" + ex.Message));
					}
					else if (ex.Message.IndexOf("duplicate key row") + 1 > 0)
					{
						LOG.WriteToArchiveLog((string) ("clsDatabase : ExecuteSql : 1442.a : " + ex.Message));
						LOG.WriteToArchiveLog((string) ("clsDatabase : ExecuteSql : 1442.a : " + sql));
						return true;
					}
					else
					{
						//messagebox.show("Execute SQL: " + ex.Message + vbCrLf + "Please review the trace log." + vbCrLf + sql)
						if (dDebug)
						{
							Clipboard.SetText(sql);
						}
					}
					
					//xTrace(39901, "ExecuteSqlNoTx: ", ex.Message.ToString)
					//xTrace(39901, "ExecuteSqlNoTx: ", ex.StackTrace.ToString)
					//xTrace(39901, "ExecuteSqlNoTx: ", Mid(sql, 1, 2000))
					LOG.WriteToArchiveLog((string) ("clsDatabase : ExecuteSql : 1442.x : " + ex.Message));
					LOG.WriteToArchiveLog("clsDatabase : ExecuteSql : 1442.x : " + "\r\n" + sql + "\r\n");
					
				}
			}
			
			
			return rc;
		}
		
		public string MachineRegister(string MachineName, string NetWorkName)
		{
			
			string MySql = "Select Count(*) from MachineRegistered where MachineName =\'" + MachineName + "\' and NetworkName = \'" + NetWorkName + "\' ";
			int iCnt = iCount(MySql);
			string MachineGuid = "";
			
			if (iCnt > 0)
			{
				try
				{
					MySql = "Select MachineGuid from MachineRegistered where MachineName =\'" + MachineName + "\' and NetworkName = \'" + NetWorkName + "\' ";
					CloseConn();
					CkConn();
					
					SqlDataReader rsData = null;
					bool b = false;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(MySql, CONN);
					rsData = command.ExecuteReader();
					rsData.Read();
					MachineGuid = rsData.GetValue(0).ToString();
					rsData.Close();
					rsData = null;
				}
				catch (Exception ex)
				{
					xTrace(12306, "clsDataBase:MachineRegister", ex.Message);
					LOG.WriteToArchiveLog((string) ("ERROR 56453.21: " + ex.Message));
					LOG.WriteToArchiveLog((string) ("clsDatabase : MachineRegister : 2054 : " + ex.Message));
					return "NA";
				}
			}
			else
			{
				
				MySql = "";
				
				MachineGuid = getGuid();
				MySql += "INSERT INTO [MachineRegistered]" + "\r\n";
				MySql += "(" + "\r\n";
				MySql += "[MachineGuid]" + "\r\n";
				MySql += ",[MachineName]" + "\r\n";
				MySql += ",[NetWorkName]" + "\r\n";
				MySql += ")" + "\r\n";
				MySql += "VALUES " + "\r\n";
				MySql += "(" + "\r\n";
				MySql += "\'" + MachineGuid + "\'," + "\r\n";
				MySql += "\'" + MachineName + "\'," + "\r\n";
				MySql += "\'" + NetWorkName + "\'" + "\r\n";
				MySql += ")" + "\r\n";
				
				bool B = ExecuteSqlNewConn(MySql);
				
			}
			
			return MachineGuid;
			
		}
		
		public bool ExecuteSqlNewConn(string sql, bool ValidateOwnerShip)
		{
			bool BB = true;
			
			lock(this)
			{
				if (ValidateOwnerShip == true)
				{
					if (TgtGuid.Length == 0)
					{
						if (modGlobals.gTgtGuid.Length > 0)
						{
							TgtGuid = modGlobals.gTgtGuid;
						}
						else
						{
							if (modGlobals.gRunUnattended == false)
							{
								MessageBox.Show("ERROR 666.04x1 - TgtGuid left blank and is required, contact ADMINISTRATOR as this is an error.");
							}
							LOG.WriteToArchiveLog("ERROR 666.04x1 - TgtGuid left blank and is required, contact ADMINISTRATOR as this is an error.");
							return false;
						}
					}
					bool isOwner = ckContentOwnership(TgtGuid, modGlobals.gCurrUserGuidID);
					if (isOwner == false)
					{
						//messagebox.show("ERROR 666.04a - This will be removed - tried to update content you do not own, ABORTED!")
						LOG.WriteToTraceLog("ExecuteSqlNewConn: User \'" + modGlobals.gCurrUserGuidID + "\' tried to change \'" + TgtGuid + "\' w/o ownership.");
						return false;
					}
				}
				bool rc = false;
				string CnStr = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CN = new SqlConnection(CnStr);
				CN.Open();
				SqlCommand dbCmd = CN.CreateCommand();
				
				
				using (CN)
				{
					dbCmd.Connection = CN;
					try
					{
						dbCmd.CommandText = sql;
						dbCmd.ExecuteNonQuery();
						BB = true;
					}
					catch (Exception ex)
					{
						rc = false;
						
						if (ex.Message.IndexOf("Could not allocate space") + 1 > 0 && ex.Message.IndexOf("is full") + 1 > 0)
						{
							frmOutOfSpace.Default.Show();
							Application.DoEvents();
						}
						if (ex.Message.IndexOf("The DELETE statement conflicted with the REFERENCE") + 1 > 0)
						{
							if (modGlobals.gRunUnattended == false)
							{
								MessageBox.Show((string) ("It appears this user has DATA within the repository associated to them and cannot be deleted." + "\r\n" + "\r\n" + ex.Message));
							}
							LOG.WriteToEbExecLog((string) ("clsDatabase : ExecuteSqlNewConn : 1464c0 It appears this user has DATA within the repository associated to them and cannot be deleted." + "\r\n" + "\r\n" + ex.Message));
							BB = false;
						}
						else if (ex.Message.IndexOf("HelpText") + 1 > 0)
						{
							BB = true;
						}
						else if (ex.Message.IndexOf("duplicate key row") + 1 > 0)
						{
							LOG.WriteToEbExecLog("clsDatabase : ExecuteSqlNewConn : 1464c1 - NOT AN ERROR, JUST RI PROTECTING THE DB.");
							LOG.WriteToEbExecLog((string) ("Advisory - clsDatabase : ExecuteSqlNewConn : 1464c1 : " + ex.Message));
							LOG.WriteToEbExecLog((string) ("Advisory - clsDatabase : ExecuteSqlNewConn : 1464c1 : " + sql));
							BB = true;
						}
						else if (ex.Message.IndexOf("duplicate key") + 1 > 0)
						{
							LOG.WriteToEbExecLog("clsDatabase : ExecuteSqlNewConn : 1464c2 - NOT AN ERROR, JUST RI PROTECTING THE DB.");
							LOG.WriteToEbExecLog((string) ("Advisory - clsDatabase : ExecuteSqlNewConn : 1465c2 : " + ex.Message));
							LOG.WriteToEbExecLog((string) ("Advisory - clsDatabase : ExecuteSqlNewConn : 1465c2 : " + sql));
							BB = true;
						}
						else if (ex.Message.IndexOf("duplicate") + 1 > 0)
						{
							LOG.WriteToEbExecLog("clsDatabase : ExecuteSqlNewConn : 1464c3 - NOT AN ERROR, JUST RI PROTECTING THE DB.");
							LOG.WriteToEbExecLog((string) ("Advisory - clsDatabase : ExecuteSqlNewConn : 1466c3 : " + ex.Message));
							LOG.WriteToEbExecLog((string) ("Advisory - clsDatabase : ExecuteSqlNewConn : 1466c3 : " + sql));
							BB = true;
						}
						else
						{
							//messagebox.show("Execute SQL: " + ex.Message + vbCrLf + "Please review the trace log." + vbCrLf + sql)
							//If dDebug Then Clipboard.SetText(sql)
							BB = false;
							xTrace(1998121, "ExecuteSqlNoTx: ", ex.Message.ToString());
							xTrace(2998121, "ExecuteSqlNoTx: ", ex.StackTrace.ToString());
							xTrace(3998121, "ExecuteSqlNoTx: ", sql.Substring(0, 2000));
							LOG.WriteToEbExecLog((string) ("clsDatabase : ExecuteSqlNewConn : 9448a2x.1: " + ex.Message + "\r\n" + ex.StackTrace.ToString()));
							LOG.WriteToEbExecLog("clsDatabase : ExecuteSqlNewConn : 9448a2x.2: " + "\r\n" + sql + "\r\n");
						}
					}
					finally
					{
						if (CN != null)
						{
							if (CN.State == ConnectionState.Open)
							{
								CN.Close();
							}
							CN = null;
						}
						if (dbCmd != null)
						{
							dbCmd = null;
						}
					}
				}
				
				
				GC.Collect();
				GC.WaitForPendingFinalizers();
				GC.WaitForFullGCComplete();
			}
			return BB;
		}
		public bool ExecuteSqlSameConn(string sql, SqlConnection CN)
		{
			bool rc = false;
			
			SqlCommand dbCmd = CN.CreateCommand();
			bool BB = true;
			using (CN)
			{
				dbCmd.Connection = CN;
				try
				{
					dbCmd.CommandText = sql;
					dbCmd.ExecuteNonQuery();
					BB = true;
				}
				catch (Exception ex)
				{
					rc = false;
					
					if (ex.Message.IndexOf("The DELETE statement conflicted with the REFERENCE") + 1 > 0)
					{
						if (modGlobals.gRunUnattended == false)
						{
							MessageBox.Show((string) ("It appears this user has DATA within the repository associated to them and cannot be deleted." + "\r\n" + "\r\n" + ex.Message));
						}
						LOG.WriteToEbExecLog((string) ("clsDatabase : ExecuteSqlNewConn : 1464c0 It appears this user has DATA within the repository associated to them and cannot be deleted." + "\r\n" + "\r\n" + ex.Message));
						BB = false;
					}
					else if (ex.Message.IndexOf("HelpText") + 1 > 0)
					{
						BB = true;
					}
					else if (ex.Message.IndexOf("duplicate key row") + 1 > 0)
					{
						LOG.WriteToEbExecLog("clsDatabase : ExecuteSqlNewConn : 1464c1 - NOT AN ERROR, JUST RI PROTECTING THE DB.");
						LOG.WriteToEbExecLog((string) ("Notification - clsDatabase : ExecuteSqlNewConn : 1464c1 : " + ex.Message));
						LOG.WriteToEbExecLog((string) ("Notification - clsDatabase : ExecuteSqlNewConn : 1464c1 : " + sql));
						BB = true;
					}
					else if (ex.Message.IndexOf("duplicate key") + 1 > 0)
					{
						LOG.WriteToEbExecLog("clsDatabase : ExecuteSqlNewConn : 1464c2 - NOT AN ERROR, JUST RI PROTECTING THE DB.");
						LOG.WriteToEbExecLog((string) ("Notification - clsDatabase : ExecuteSqlNewConn : 1465c2 : " + ex.Message));
						LOG.WriteToEbExecLog((string) ("Notification - clsDatabase : ExecuteSqlNewConn : 1465c2 : " + sql));
						BB = true;
					}
					else if (ex.Message.IndexOf("duplicate") + 1 > 0)
					{
						LOG.WriteToEbExecLog("clsDatabase : ExecuteSqlNewConn : 1464c3 - NOT AN ERROR, JUST RI PROTECTING THE DB.");
						LOG.WriteToEbExecLog((string) ("Notification - clsDatabase : ExecuteSqlNewConn : 1466c3 : " + ex.Message));
						LOG.WriteToEbExecLog((string) ("Notification - clsDatabase : ExecuteSqlNewConn : 1466c3 : " + sql));
						BB = true;
					}
					else
					{
						//messagebox.show("Execute SQL: " + ex.Message + vbCrLf + "Please review the trace log." + vbCrLf + sql)
						if (dDebug)
						{
							Clipboard.SetText(sql);
						}
						BB = false;
						xTrace(1998134, "ExecuteSqlNoTx: ", ex.Message.ToString());
						xTrace(2998134, "ExecuteSqlNoTx: ", ex.StackTrace.ToString());
						xTrace(3998134, "ExecuteSqlNoTx: ", sql.Substring(0, 2000));
						LOG.WriteToEbExecLog((string) ("clsDatabase : ExecuteSqlNewConn : 9442a2x.1: " + ex.Message));
						LOG.WriteToEbExecLog("clsDatabase : ExecuteSqlNewConn : 9442a2x.2: " + "\r\n" + sql + "\r\n");
					}
				}
			}
			
			
			GC.Collect();
			
			return BB;
		}
		public bool ExecuteSqlNewConn(string sql)
		{
			
			bool RC = true;
			string RetMsg = "";
			
			//Dim Proxy As New SVCCLCArchive.Service1Client
			//RC = Proxy.ExecuteSqlNewConn(101101, gCurrUserGuidID, sql, RetMsg)
			
			//If RetMsg.Trim.Length > 0 Then
			//    RC = False
			//End If
			
			SqlCommand CMD = new SqlCommand();
			string connString = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection conn = new SqlConnection(connString);
			conn.Open();
			
			bool SkipThis = false;
			
			if (! SkipThis)
			{
				
				if (conn == null)
				{
					conn = new SqlConnection(getGateWayConnStr(modGlobals.gGateWayID));
				}
				if (conn.State == ConnectionState.Closed)
				{
					conn.ConnectionString = getGateWayConnStr(modGlobals.gGateWayID);
					conn.Open();
				}
				
				CMD = conn.CreateCommand();
				CMD.Connection = conn;
				
				//Dim dbCmd As SqlCommand = conn.CreateCommand()
				bool BB = true;
				using (conn)
				{
					if (CMD.Connection.State == ConnectionState.Closed)
					{
						CMD.Connection = conn;
					}
					
					try
					{
						CMD.CommandText = sql;
						CMD.ExecuteNonQuery();
						BB = true;
					}
					catch (Exception ex)
					{
						RC = false;
						
						if (ex.Message.IndexOf("The DELETE statement conflicted with the REFERENCE") + 1 > 0)
						{
							if (modGlobals.gRunUnattended == false)
							{
								MessageBox.Show((string) ("It appears this user has DATA within the repository associated to them and cannot be deleted." + "\r\n" + "\r\n" + ex.Message));
							}
							LOG.WriteToArchiveLog((string) ("It appears this user has DATA within the repository associated to them and cannot be deleted." + "\r\n" + "\r\n" + ex.Message));
						}
						else if (ex.Message.IndexOf("HelpText") + 1 > 0)
						{
							BB = true;
						}
						else if (ex.Message.IndexOf("duplicate key row") + 1 > 0)
						{
							//log.WriteToArchiveLog("clsDatabase : ExecuteSqlNewConn : 1464c1 : " + ex.Message)
							//log.WriteToArchiveLog("clsDatabase : ExecuteSqlNewConn : 1464c1 : " + sql)
							BB = true;
						}
						else if (ex.Message.IndexOf("duplicate key") + 1 > 0)
						{
							//log.WriteToArchiveLog("clsDatabase : ExecuteSqlNewConn : 1465c2 : " + ex.Message)
							//log.WriteToArchiveLog("clsDatabase : ExecuteSqlNewConn : 1464c2 : " + sql)
							BB = true;
						}
						else if (ex.Message.IndexOf("duplicate") + 1 > 0)
						{
							//log.WriteToArchiveLog("clsDatabase : ExecuteSqlNewConn : 1466c3 : " + ex.Message)
							//log.WriteToArchiveLog("clsDatabase : ExecuteSqlNewConn : 1464c3 : " + sql)
							BB = true;
						}
						else
						{
							//messagebox.show("Execute SQL: " + ex.Message + vbCrLf + "Please review the trace log." + vbCrLf + sql)
							if (dDebug)
							{
								Clipboard.SetText(sql);
							}
							BB = false;
							xTrace(19981647, "ExecuteSqlNoTx: ", ex.Message.ToString());
							if (dDebug)
							{
								Debug.Print(ex.Message.ToString());
							}
							xTrace(29981647, "ExecuteSqlNoTx: ", ex.StackTrace.ToString());
							xTrace(39981647, "ExecuteSqlNoTx: ", sql.Substring(0, 2000));
							LOG.WriteToArchiveLog((string) ("clsDatabase : ExecuteSqlNewConn : 9442a1p1: " + ex.Message));
							LOG.WriteToArchiveLog("clsDatabase : ExecuteSqlNewConn : 9442a1p2: " + "\r\n" + sql + "\r\n");
						}
						
					}
				}
				
				
				//If gConn.State = ConnectionState.Open Then
				//    gConn.Close()
				//End If
				
				//gConn = Nothing
				//gCmd = Nothing
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			if (conn.State == ConnectionState.Open)
			{
				conn.Close();
			}
			
			conn.Dispose();
			CMD.Dispose();
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return RC;
		}
		
		
		public bool ApplySqlStmt(string sql, ref string ErrMsg)
		{
			
			bool rc = false;
			
			SqlConnection CN = new SqlConnection(getGateWayConnStr(modGlobals.gGateWayID));
			CN.Open();
			SqlCommand dbCmd = CN.CreateCommand();
			
			using (CN)
			{
				dbCmd.Connection = CN;
				try
				{
					dbCmd.CommandText = sql;
					dbCmd.ExecuteNonQuery();
					rc = true;
					ErrMsg = "";
				}
				catch (Exception ex)
				{
					ErrMsg = ex.Message;
					LOG.WriteToArchiveLog((string) ("clsDatabase : ApplySqlStmt : 100: " + ex.Message));
				}
			}
			
			
			if (CN.State == ConnectionState.Open)
			{
				CN.Close();
			}
			CN = null;
			dbCmd = null;
			return rc;
		}
		public bool ExecuteSqlLookupTable(string sql)
		{
			
			bool rc = false;
			
			SqlConnection CN = new SqlConnection(getGateWayConnStr(modGlobals.gGateWayID));
			CN.Open();
			SqlCommand dbCmd = CN.CreateCommand();
			
			using (CN)
			{
				dbCmd.Connection = CN;
				try
				{
					dbCmd.CommandText = sql;
					dbCmd.ExecuteNonQuery();
					rc = true;
				}
				catch (Exception ex)
				{
					rc = false;
					if (ex.Message.IndexOf("duplicate key row") + 1 > 0)
					{
						return true;
					}
					xTrace(934161, "ExecuteSqlLookupTable: ", ex.Message.ToString());
					xTrace(934162, "ExecuteSqlLookupTable: ", sql.Substring(0, 2000));
				}
			}
			
			
			if (CN.State == ConnectionState.Open)
			{
				CN.Close();
			}
			CN = null;
			dbCmd = null;
			return rc;
		}
		public bool ExecuteSql(string sql, string NewConnectionStr, bool ValidateOwnerShip)
		{
			if (ValidateOwnerShip == true)
			{
				if (TgtGuid.Length == 0)
				{
					if (modGlobals.gRunUnattended == false)
					{
						MessageBox.Show("ERROR 666.05 - TgtGuid left blank and is required, contact ADMIN as this is an error.");
					}
					LOG.WriteToArchiveLog("ERROR 666.05 - TgtGuid left blank and is required, contact ADMIN as this is an error.");
					return false;
				}
				bool isOwner = ckContentOwnership(TgtGuid, modGlobals.gCurrUserGuidID);
				if (isOwner == false)
				{
					if (modGlobals.gRunUnattended == false)
					{
						MessageBox.Show("ERROR 666.05a - This will be removed - tried to update content you do not own, ABORTED!");
					}
					LOG.WriteToTraceLog("ExecuteSqlNewConn2: User \'" + modGlobals.gCurrUserGuidID + "\' tried to change \'" + TgtGuid + "\' w/o ownership.");
					return false;
				}
			}
			try
			{
				bool rc = false;
				
				SqlConnection CN = new SqlConnection(NewConnectionStr);
				CN.Open();
				SqlCommand dbCmd = CN.CreateCommand();
				
				using (CN)
				{
					dbCmd.Connection = CN;
					try
					{
						dbCmd.CommandText = sql;
						dbCmd.ExecuteNonQuery();
						rc = true;
					}
					catch (Exception ex)
					{
						rc = false;
						if (ex.Message.IndexOf("The DELETE statement conflicted with the REFERENCE") + 1 > 0)
						{
							if (modGlobals.gRunUnattended == false)
							{
								MessageBox.Show((string) ("It appears this user has DATA within the repository associated to them and cannot be deleted." + "\r\n" + "\r\n" + ex.Message));
							}
							LOG.WriteToArchiveLog((string) ("It appears this user has DATA within the repository associated to them and cannot be deleted." + "\r\n" + "\r\n" + ex.Message));
						}
						else if (ex.Message.IndexOf("duplicate key row") + 1 > 0)
						{
							LOG.WriteToArchiveLog((string) ("clsDatabase : ExecuteSqlNewConn : 1464 : " + ex.Message + "\r\n" + sql));
							LOG.WriteToArchiveLog((string) ("clsDatabase : ExecuteSqlNewConn : 1408 : " + ex.Message));
							LOG.WriteToArchiveLog((string) ("clsDatabase : ExecuteSqlNewConn : 1411 : " + ex.Message));
							return true;
						}
						else
						{
							//messagebox.show("Execute SQL: " + ex.Message + vbCrLf + "Please review the trace log." + vbCrLf + sql)
							if (dDebug)
							{
								Clipboard.SetText(sql);
							}
						}
						xTrace(2343111, "ExecuteSqlNoTx: ", "-----------------------");
						xTrace(2343112, "ExecuteSqlNoTx: ", ex.Message.ToString());
						xTrace(2343113, "ExecuteSqlNoTx: ", ex.StackTrace.ToString());
						xTrace(2343114, "ExecuteSqlNoTx: ", sql.Substring(0, 2000));
						LOG.WriteToArchiveLog((string) ("ERROR: ExecuteSql 2001 - " + sql));
					}
				}
				
				
				if (CN.State == ConnectionState.Open)
				{
					CN.Close();
				}
				CN = null;
				dbCmd = null;
				return rc;
			}
			catch (Exception ex)
			{
				xTrace(9914, "ExecuteSqlNewConn", "ExecuteSqlNewConn Failed", ex);
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show(ex.Message);
				}
				LOG.WriteToArchiveLog((string) ("ERROR ExecuteSql 100a1: " + ex.Message + "\r\n" + ex.StackTrace));
				return false;
			}
			
		}
		public bool ExecSP(string spName)
		{
			bool B = false;
			bool TimeTrk = true;
			try
			{
				CloseConn();
				CkConn();
				if (TimeTrk)
				{
					System.Console.WriteLine(spName + " Start: " + DateTime.Today.ToString());
				}
				SqlCommand command = new SqlCommand(spName, gConn);
				command.CommandType = System.Data.CommandType.StoredProcedure;
				command.CommandText = spName;
				command.CommandTimeout = 3600;
				command.ExecuteNonQuery();
				command = null;
				gConn.Close();
				B = true;
				if (TimeTrk)
				{
					System.Console.WriteLine(spName + " End: " + DateTime.Today.ToString());
				}
			}
			catch (Exception ex)
			{
				//Session("ErrorLocation") = 'Session("ErrorLocation") + " : " + ex.Message
				xTrace(3014, spName, "Stored Procedure Failed", ex);
				B = false;
				LOG.WriteToArchiveLog((string) ("clsDatabase : ExecSP : 1498 : " + ex.Message));
			}
			return B;
		}
		public bool SP_ApplyUpdate(string UpdateSql)
		{
			string spName = "";
			
			spName = (string) ("funcEcmUpdateDB " + UpdateSql);
			bool B = false;
			//Dim TimeTrk As Boolean = True
			try
			{
				CloseConn();
				CkConn();
				//If TimeTrk Then
				//    System.Console.WriteLine(spName + " Start: " + DateTime.Today.ToString)
				//End If
				//Dim command As SqlCommand = New SqlCommand(spName, gConn)
				//command.CommandType = Data.CommandType.StoredProcedure
				//command.CommandText = spName
				//command.CommandTimeout = 3600
				//command.ExecuteNonQuery()
				//command = Nothing
				//gConn.Close()
				
				
				using (SqlConnection connection = new SqlConnection(getGateWayConnStr(modGlobals.gGateWayID)))
				{
					using (SqlCommand command = new SqlCommand("funcEcmUpdateDB", connection))
					{
						command.CommandType = CommandType.StoredProcedure;
						command.Parameters.Add(new SqlParameter("@pSql", UpdateSql));
						connection.Open();
						command.ExecuteNonQuery();
						connection.Close();
						connection.Dispose();
						command.Dispose();
					}
					
				}
				
				B = true;
				//If TimeTrk Then
				//    System.Console.WriteLine(spName + " End: " + DateTime.Today.ToString)
				//End If
			}
			catch (Exception ex)
			{
				//Session("ErrorLocation") = 'Session("ErrorLocation") + " : " + ex.Message
				Console.WriteLine(ex.Message);
				xTrace(3014, spName, "SP_ApplyUpdate: Stored Procedure Failed", ex);
				B = false;
				LOG.WriteToArchiveLog((string) ("clsDatabase : SP_ApplyUpdate : 100 : " + ex.Message));
			}
			return B;
		}
		
		public bool ExecuteSqlNoAudit(string sql)
		{
			
			string TxName = "TX001";
			bool rc = false;
			
			CloseConn();
			CkConn();
			
			using (gConn)
			{
				
				SqlCommand dbCmd = gConn.CreateCommand();
				
				//Dim transaction As SqlTransaction
				
				//transaction = gConn.BeginTransaction(TxName)
				
				// Must assign both transaction object and connection
				// to dbCmd object for a pending local transaction.
				dbCmd.Connection = gConn;
				//dbCmd.Transaction = transaction
				
				try
				{
					dbCmd.CommandText = sql;
					dbCmd.ExecuteNonQuery();
					// Attempt to commit the transaction.
					//transaction.Commit()
					//Dim debug As Boolean = False
					//If debug Then
					//    Console.WriteLine("Successful execution: " + vbCrLf + sql)
					//End If
					rc = true;
				}
				catch (Exception ex)
				{
					rc = false;
					Console.WriteLine("Exception Type: {0}", ex.GetType());
					Console.WriteLine("  Message: {0}", ex.Message);
					Console.WriteLine(sql);
					
					//'Session("ActiveError") = True
					//'Session("ErrMsg") = "ExecuteSqlNoAudit - SQL Error check table PgmTrace: " + ex.Message
					//'Session("ErrStack") = "Stack Trace: " + vbCrLf + vbCrLf + ex.StackTrace
					
					xTrace(23435460, "ExecuteSql: ", "-----------------------");
					xTrace(23435461, "ExecuteSql: ", ex.Message.ToString());
					xTrace(23435462, "ExecuteSql: ", ex.StackTrace.ToString());
					xTrace(23435463, "ExecuteSql: ", sql);
					
					LOG.WriteToArchiveLog((string) ("clsDatabase : ExecuteSqlNoAudit : 1516 : " + ex.Message));
				}
			}
			
			
			return rc;
		}
		
		public bool saveHistory(string SQL)
		{
			bool b = true;
			string typeSql = "";
			string tbl = "";
			int i = 0;
			int j = 0;
			
			i = SQL.IndexOf(" ") + 1;
			typeSql = SQL.Substring(0, i - 1);
			typeSql = typeSql.ToUpper();
			
			if (typeSql == "INSERT")
			{
				i = SQL.IndexOf("into") + 1;
				i = i + "into ".Length;
				j = SQL.IndexOf(" ", i - 1) + 1;
				tbl = SQL.Substring(i - 1, j - i);
			}
			if (typeSql == "DELETE")
			{
				i = SQL.IndexOf("from") + 1;
				i = i + "from ".Length;
				j = SQL.IndexOf(" ", i - 1) + 1;
				tbl = SQL.Substring(i - 1, j - i);
			}
			if (typeSql == "UPDATE")
			{
				i = SQL.IndexOf(" ") + 1;
				i = i + " ".Length;
				j = SQL.IndexOf(" ", i - 1) + 1;
				tbl = SQL.Substring(i - 1, j - i);
			}
			
			tbl = tbl.ToUpper();
			if (tbl == "USER_ACCESS")
			{
				return true;
			}
			if (tbl == "HISTORY")
			{
				return true;
			}
			
			SQL = UTIL.RemoveSingleQuotes(SQL);
			//** select tbl, sqlstmt,LAST_MOD_DATE,user_name,action from history
			//Public MachineName As String = ""
			//Public MachineIP As String = ""
			//Public UserID As String = ""
			
			string S = "insert into HISTORY (tbl, sqlstmt,LAST_MOD_DATE,user_name,action, HostName, IPAddr, Last_Mod_User, Create_user) values (";
			S = S + "\'" + tbl + "\',";
			S = S + "\'" + SQL + "\', ";
			S = S + " getdate(), ";
			//S = S + "'" + Now() + "',"
			S = S + "\'" + LOG.getEnvVarUserID() + "\',";
			S = S + "\'" + typeSql + "\',";
			S = S + "\'" + DMA.getHostname() + "\',";
			S = S + "\'" + DMA.getIpAddr() + "\',";
			S = S + "\'" + LOG.getEnvVarUserID() + "\',";
			S = S + "\'" + LOG.getEnvVarUserID() + "\')";
			
			//Clipboard.Clear()
			//Clipboard.SetText(S)
			
			b = ExecuteSqlNewConn(S, false);
			
			return b;
		}
		
		public string getCpuTime()
		{
			//** You can browse the available performance counters by
			//** going to Control Panel | Administrative Tools | Performance and clicking Add.
			System.Diagnostics.PerformanceCounter perfCounter = new System.Diagnostics.PerformanceCounter();
			int loopCount;
			string CPU = "";
			
			perfCounter.CategoryName = "Processor";
			perfCounter.CounterName = "% Processor Time";
			perfCounter.InstanceName = "_Total";
			
			for (loopCount = 1; loopCount <= 2; loopCount++)
			{
				//Debug.WriteLine(perfCounter.NextValue.ToString())
				CPU = perfCounter.NextValue().ToString();
			}
			
			perfCounter.Close();
			
			return CPU;
			
		}
		
		public string GetTableNameFromSql(string Sql)
		{
			bool b = true;
			string typeSql = "";
			string tbl = "";
			int i = 0;
			int j = 0;
			
			Sql = Sql.Trim();
			
			string s1 = "";
			string s2 = "";
			string ch = "";
			
			for (i = 1; i <= Sql.Length; i++)
			{
				ch = Sql.Substring(i - 1, 1);
				if (ch == "(")
				{
					s1 = s1 + " " + ch;
				}
				else if (ch == ")")
				{
					s1 = s1 + ch + " ";
				}
				else
				{
					s1 = s1 + ch;
				}
			}
			
			Sql = s1;
			
			i = Sql.IndexOf(" ") + 1;
			typeSql = Sql.Substring(0, i - 1);
			typeSql = typeSql.ToUpper();
			
			if (typeSql == "INSERT")
			{
				i = Sql.IndexOf("into") + 1;
				i = i + "into ".Length;
				j = Sql.IndexOf(" ", i - 1) + 1;
				tbl = Sql.Substring(i - 1, j - i);
			}
			if (typeSql == "DELETE")
			{
				i = Sql.IndexOf("from") + 1;
				i = i + "from ".Length;
				j = Sql.IndexOf(" ", i - 1) + 1;
				tbl = Sql.Substring(i - 1, j - i);
			}
			if (typeSql == "UPDATE")
			{
				i = Sql.IndexOf(" ") + 1;
				i = i + " ".Length;
				j = Sql.IndexOf(" ", i - 1) + 1;
				tbl = Sql.Substring(i - 1, j - i);
			}
			
			return tbl;
			
		}
		
		public string GetWhereClauseFromSql(string Sql)
		{
			bool b = true;
			string typeSql = "";
			string wc = "";
			string tbl = "";
			int i = 0;
			int j = 0;
			
			i = Sql.IndexOf(" where") + 1;
			if (i > 0)
			{
				wc = Sql.Substring(i - 1);
			}
			
			return wc;
			
		}
		
		public string GetTypeSqlStmt(string Sql)
		{
			bool b = true;
			string typeSql = "";
			string tbl = "";
			int i = 0;
			int j = 0;
			string SqlType = "";
			
			Sql = Sql.Trim();
			i = Sql.IndexOf(" ") + 1;
			typeSql = Sql.Substring(0, i - 1);
			typeSql = typeSql.ToUpper();
			
			if (typeSql == "INSERT")
			{
				SqlType = typeSql;
			}
			if (typeSql == "DELETE")
			{
				SqlType = typeSql;
			}
			if (typeSql == "UPDATE")
			{
				SqlType = typeSql;
			}
			if (typeSql == "SELECT")
			{
				SqlType = typeSql;
			}
			return SqlType;
		}
		
		public bool ckModuleAuth(string UID, string AuthCode)
		{
			AuthCode = AuthCode.ToUpper();
			bool AuthGranted = false;
			switch (AuthCode)
			{
				case "DBA":
					AuthGranted = false;
					break;
				case "GRAPHICS":
					AuthGranted = false;
					break;
				case "INVENTORY":
					AuthGranted = false;
					break;
				case "STANDARDS":
					AuthGranted = false;
					break;
				case "ACCESS":
					AuthGranted = false;
					break;
				case "ACTION":
					AuthGranted = false;
					break;
				case "REPORTS":
					AuthGranted = false;
					break;
				case "COMPLAINTS":
					AuthGranted = false;
					break;
				case "COMPLAINANTS":
					AuthGranted = false;
					break;
				case "EMPLOYMENT":
					AuthGranted = false;
					break;
				default:
					AuthGranted = false;
					//DMA.SaveErrMsg(, "Error 121.99.2", "100.10c - Incorrect authority code entered, returning...")
					//'Session("ErrMsg") = "Error 121.99.2"
					//'Session("ErrStack") = "100.10c - Incorrect authority code entered, returning..."
					//Response.Redirect("frmErrDisplay.aspx")
					return AuthGranted;
			}
			
			string Level = "";
			
			string s = "Select * from user_rights where user_name = \'" + UID + "\'";
			SqlDataReader rsData = null;
			bool b = false;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			try
			{
				if (rsData.IsClosed)
				{
					Console.WriteLine("ckModuleAuth HERE it is closed: " + UID);
				}
				else
				{
					Console.WriteLine("ckModuleAuth HERE it is OPEN: " + UID);
				}
			}
			catch (Exception ex)
			{
				//DMA.SaveErrMsg(, ex.Message, ex.StackTrace.ToString)
				//'Session("ErrMsg") = ex.Message
				//'Session("ErrStack") = ex.StackTrace
				//Response.Redirect("frmErrDisplay.aspx")
				LOG.WriteToArchiveLog((string) ("clsDatabase : ckModuleAuth : 1680 : " + ex.Message));
			}
			
			if (rsData.HasRows)
			{
				rsData.Read();
				Level = rsData.GetValue(rsData.GetOrdinal(AuthCode)).ToString();
				if (Level != "0")
				{
					AuthGranted = true;
				}
				else
				{
					AuthGranted = false;
				}
			}
			else
			{
				AuthGranted = false;
			}
			rsData.Close();
			//connection.Close()
			
			return AuthGranted;
		}
		
		public string getServerDbName()
		{
			//SELECT DB_NAME() AS DataBaseName
			string s = "Select DB_NAME() AS DataBaseName";
			SqlDataReader rsData = null;
			bool b = false;
			string ServerDbName = "";
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			try
			{
				if (rsData.IsClosed)
				{
					Console.WriteLine("getServerName HERE it is closed.");
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase : getServerDbName : 10 : " + ex.Message));
			}
			
			if (rsData.HasRows)
			{
				rsData.Read();
				ServerDbName = rsData.GetValue(0).ToString();
			}
			rsData.Close();
			rsData = null;
			return ServerDbName;
		}
		public bool ckAuthority(string UID, string AuthCode)
		{
			bool AuthGranted = false;
			AuthCode = AuthCode.ToUpper();
			switch (AuthCode)
			{
				case "ADMIN":
					AuthGranted = false;
					break;
				case "SUPER USER":
					AuthGranted = false;
					break;
				case "USER":
					AuthGranted = false;
					break;
				default:
					AuthGranted = false;
					LOG.WriteToArchiveLog("Error 100.10a - Incorrect authority code entered, returning.");
					return AuthGranted;
			}
			string Auth = "";
			string s = "Select user_type_cd from user_database where user_name = \'" + UID + "\' ";
			SqlDataReader rsData = null;
			bool b = false;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			
			rsData.Read();
			Auth = rsData.GetValue(rsData.GetOrdinal(AuthCode)).ToString();
			if (Auth == AuthCode)
			{
				AuthGranted = true;
			}
			else
			{
				AuthGranted = false;
			}
			rsData.Close();
			
			return AuthGranted;
		}
		
		public bool UserHasAuthority(string UID, string AuthCode)
		{
			bool AuthGranted = false;
			AuthCode = AuthCode.ToUpper();
			switch (AuthCode)
			{
				case "EDIT":
					AuthGranted = false;
					break;
				case "INSERT":
					AuthGranted = false;
					break;
				case "UPDATE":
					AuthGranted = false;
					break;
				case "DELETE":
					AuthGranted = false;
					break;
				case "READ":
					AuthGranted = false;
					break;
				case "MAINT":
					AuthGranted = false;
					break;
				case "EXECUTE":
					AuthGranted = false;
					break;
				default:
					AuthGranted = false;
					LOG.WriteToArchiveLog("Error 100.10t - Incorrect authority code entered, returning.");
					return AuthGranted;
			}
			string Auth = "";
			string s = "Select user_type_cd from user_database where user_name = \'" + UID + "\' ";
			SqlDataReader rsData = null;
			bool b = false;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			rsData.Read();
			Auth = rsData.GetValue(0).ToString();
			if (Auth == "ADMIN")
			{
				AuthGranted = true;
			}
			else
			{
				switch (AuthCode)
				{
					case "INSERT":
						if (Auth == "SUPER USER")
						{
							AuthGranted = true;
						}
						else if (Auth == "USER")
						{
							AuthGranted = false;
						}
						else
						{
							AuthGranted = false;
						}
						break;
					case "EDIT":
						if (Auth == "SUPER USER")
						{
							AuthGranted = true;
						}
						else if (Auth == "USER")
						{
							AuthGranted = false;
						}
						else
						{
							AuthGranted = false;
						}
						break;
					case "UPDATE":
						if (Auth == "SUPER USER")
						{
							AuthGranted = true;
						}
						else if (Auth == "USER")
						{
							AuthGranted = false;
						}
						else
						{
							AuthGranted = false;
						}
						break;
					case "DELETE":
						if (Auth == "SUPER USER")
						{
							AuthGranted = false;
						}
						else if (Auth == "USER")
						{
							AuthGranted = false;
						}
						else
						{
							AuthGranted = false;
						}
						break;
					case "READ":
						if (Auth == "SUPER USER")
						{
							AuthGranted = true;
						}
						else if (Auth == "USER")
						{
							AuthGranted = true;
						}
						else
						{
							AuthGranted = false;
						}
						break;
					case "MAINT":
						if (Auth == "SUPER USER")
						{
							AuthGranted = true;
						}
						else if (Auth == "USER")
						{
							AuthGranted = false;
						}
						else
						{
							AuthGranted = false;
						}
						break;
					case "EXECUTE":
						if (Auth == "SUPER USER")
						{
							AuthGranted = true;
						}
						else if (Auth == "USER")
						{
							AuthGranted = false;
						}
						else
						{
							AuthGranted = false;
						}
						break;
					default:
						AuthGranted = false;
						break;
				}
			}
			rsData.Close();
			
			return AuthGranted;
		}
		
		public bool ckFldLen(string Title, string fld)
		{
			if (fld.Length == 0)
			{
				LOG.WriteToArchiveLog("Error ckFldLen 100.10i - " + Title + " is a required field.");
				return false;
			}
			else
			{
				return true;
			}
		}
		
		//Public Sub log.WriteToArchiveLog(ByVal Msg )
		
		//    Dim cPath As String = GetCurrDir()
		//    Dim tFQN  = cPath + "\AdmsApp.Log"
		//    ' Create an instance of StreamWriter to write text to a file.
		//    Using sw As StreamWriter = New StreamWriter(tFQN, True)
		//        ' Add some text to the file.
		//        sw.WriteLine(Now() + ": " + Msg)
		//        sw.Close()
		//    End Using
		
		//End Sub
		
		public string GetCurrDir()
		{
			string s = "";
			string ch = "";
			int i = 0;
			//s = Application.ExecutablePath
			s = System.Reflection.Assembly.GetExecutingAssembly().Location.ToString();
			if (s.IndexOf("\\") + 1 > 0)
			{
				i = s.Length;
				ch = "";
				while (ch != "\\")
				{
					i--;
					ch = s.Substring(i - 1, 1);
				}
			}
			string cPath = "";
			cPath = s.Substring(0, i - 1);
			return cPath;
		}
		
		public byte[] RetrieveDocument(string DocID)
		{
			
			SqlConnection cn = null;
			cn.ConnectionString = gConnStr;
			cn.Open();
			
			string sql = "Select DocumentText from documents where documentid = " + DocID;
			SqlCommand cmd = new SqlCommand(sql, cn);
			SqlDataAdapter da = new SqlDataAdapter(cmd);
			System.Data.DataSet ds = new System.Data.DataSet();
			
			da.Fill(ds, "BLOBIMAGE");
			
			int c = ds.Tables["BLOBIMAGE"].Rows.Count;
			
			if (c > 0)
			{
				try
				{
					byte[] bytBLOBData = (byte[]) (ds.Tables["BLOBIMAGE"].Rows[c - 1]["DocumentText"]);
					//Dim stmBLOBData As New MemoryStream(bytBLOBData)
					//MS = stmBLOBData
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine("Document Bytes Retrieved: " + bytBLOBData.Length);
					}
					cn.Close();
					cn = null;
					return bytBLOBData;
				}
				catch (Exception ex)
				{
					xTrace(12304, "clsDataBase:RetrieveDocument", ex.Message);
					Console.Write(ex.StackTrace);
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine("*************************************");
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine(ex.Message);
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine("********Inner Exception *********");
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine(ex.InnerException.Message);
					}
					LOG.WriteToArchiveLog((string) ("clsDatabase : RetrieveDocument : 1856 : " + ex.Message));
				}
				
			}
			cn.Close();
			cn = null;
			return null;
		}
		
		public string getDocumentFqnById(string DocID)
		{
			
			SqlConnection cn = null;
			
			//gConnStr = ConfigurationManager.ConnectionStrings(ConnectionStringID).ConnectionString
			
			cn.ConnectionString = gConnStr;
			cn.Open();
			
			string sql = "Select DocFqn from documents where documentid = " + DocID;
			SqlCommand cmd = new SqlCommand(sql, cn);
			SqlDataAdapter da = new SqlDataAdapter(cmd);
			System.Data.DataSet ds = new System.Data.DataSet();
			
			da.Fill(ds, "DocFqn");
			
			int c = ds.Tables["DocFqn"].Rows.Count;
			
			if (c > 0)
			{
				try
				{
					string FQN = (string) (ds.Tables["DocFqn"].Rows[c - 1]["DocFqn"]);
					//Dim stmBLOBData As New MemoryStream(bytBLOBData)
					//MS = stmBLOBData
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine("Graphic Bytes Retrieved: " + FQN.Length);
					}
					cn.Close();
					cn = null;
					return FQN;
				}
				catch (Exception ex)
				{
					xTrace(12305, "clsDataBase:GetDocumentFqnById", ex.Message);
					Console.Write(ex.StackTrace);
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine("*************************************");
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine(ex.Message);
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine("********Inner Exception *********");
					}
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine(ex.InnerException.Message);
					}
					LOG.WriteToArchiveLog((string) ("clsDatabase : getDocumentFqnById : 1880 : " + ex.Message));
				}
				
			}
			cn.Close();
			cn = null;
			return "";
		}
		
		public void xTrace(int StmtID, string Stmt, string PgmName, Exception ex)
		{
			
			string ErrStack = ex.StackTrace.ToString();
			string ErrorSource = ex.Source.ToString();
			// Dim InnerException = ex.InnerException.Message.ToString
			string ErrMsg = ex.Message.ToString();
			//Dim exData As Collection = ex.Data
			string ConnectiveGuid = this.getGuid();
			
			PgmName = UTIL.RemoveSingleQuotes(PgmName);
			string S = "";
			Stmt = UTIL.RemoveSingleQuotes(Stmt);
			S = (string) ("INSERT INTO PgmTrace ([StmtID] ,[PgmName], ConnectiveGuid, stmt, UserID) VALUES(" + StmtID.ToString() + ", \'" + PgmName + ("\' , \'" + ConnectiveGuid + "\', \'" + Stmt + "\', \'" + modGlobals.gCurrUserGuidID + "\')"));
			bool b = ExecuteSqlNewConn(S, false);
			if (b == false)
			{
				//'Session("ErrMsg") = "StmtId Call: " + 'Session("ErrMsg")
				//'Session("ErrStack") = "StmtId Call Stack: " + ''Session("ErrStack")
			}
			
			SaveErrMsg(ErrMsg, ErrStack, StmtID.ToString(), ConnectiveGuid);
			
		}
		public void FixSingleQuotes(ref string Stmt)
		{
			int I = 0;
			string CH = "";
			for (I = 1; I <= Stmt.Length; I++)
			{
				CH = Stmt.Substring(I - 1, 1);
				if (CH == "\'")
				{
					StringType.MidStmtStr(ref Stmt, I, 1, "`");
				}
			}
		}
		public void xTrace(int StmtID, string PgmName, string Stmt)
		{
			
			if (Stmt.Contains("Failed to save search results"))
			{
				return;
			}
			if (Stmt.Contains("Column names in each table must be unique"))
			{
				return;
			}
			if (Stmt.Contains("clsArchiver:ArchiveQuickRefItems"))
			{
				return;
			}
			
			
			try
			{
				FixSingleQuotes(ref Stmt);
				string S = "";
				PgmName = UTIL.RemoveSingleQuotes(PgmName);
				S = "INSERT INTO PgmTrace (StmtID ,PgmName, Stmt) VALUES(" + StmtID.ToString() + ", \'" + PgmName + "\',\'" + Stmt + "\')";
				bool b = this.ExecuteSqlNewConn(S, false);
				if (b == false)
				{
					//'Session("ErrMsg") = "StmtId Call: " + 'Session("ErrMsg")
					//'Session("ErrStack") = "StmtId Call Stack: " + ''Session("ErrStack")
				}
			}
			catch (Exception ex)
			{
				
				if (dDebug)
				{
					Debug.Print(ex.Message);
				}
				if (modGlobals.gClipBoardActive == true)
				{
					Console.WriteLine(ex.Message);
				}
				LOG.WriteToArchiveLog((string) ("clsDatabase : xTrace : 1907 : " + ex.Message));
				
			}
			
		}
		
		public void ZeroTrace()
		{
			string S = "";
			S = "delete from PgmTrace ";
			bool b = ExecuteSqlNewConn(S, false);
			if (b == false)
			{
				//'Session("ErrMsg") = "ZeroTrace Call: " + 'Session("ErrMsg")
				//'Session("ErrStack") = "ZeroTrace Call Stack: " + ''Session("ErrStack")
				//Response.Redirect("frmErrDisplay.aspx")
			}
		}
		
		public void ZeroizeEmailToDelete(string Userid)
		{
			string S = "";
			S = "delete from EmailToDelete where UserID = \'" + Userid + "\'";
			bool b = ExecuteSqlNewConn(S, false);
			if (b == false)
			{
				//'Session("ErrMsg") = "ZeroTrace Call: " + 'Session("ErrMsg")
				//'Session("ErrStack") = "ZeroTrace Call Stack: " + ''Session("ErrStack")
				//Response.Redirect("frmErrDisplay.aspx")
			}
		}
		
		public int LogEntryNew(string IPADDR)
		{
			
			string NextKey = getNextKey("LOGINS", "LoginTrackingNbr");
			string S = "";
			
			S = S + "INSERT INTO [Logins]";
			S = S + "([LoginID]";
			S = S + ",[LoginDate]";
			S = S + ",[LoginTrackingNbr]";
			S = S + ",[Duration]";
			S = S + ",[IPAddress])";
			S = S + "VALUES( ";
			S = S + "\'VISITOR\'";
			S = S + ",getdate()";
			S = S + "," + NextKey;
			S = S + ",getdate()";
			S = S + ",\'" + IPADDR + "\')";
			
			bool b = ExecuteSqlNoTx(S);
			if (b)
			{
				return int.Parse(NextKey);
			}
			else
			{
				return -1;
			}
			
		}
		
		public void LogEntryUpdate(string UID, int LoginTrackingNbr)
		{
			
			if (UID == null)
			{
				if (LoginTrackingNbr != null)
				{
					LogEntryUpdate(LoginTrackingNbr);
				}
				return;
			}
			
			if (UID.Length == 0)
			{
				return;
			}
			
			string S = "";
			
			S = S + "UPDATE [Logins]";
			S = S + " SET [LoginID] = \'" + UID + "\'";
			S = S + " ,[Duration] = getdate()      ";
			S = S + " WHERE (LoginTrackingNbr = " + str[LoginTrackingNbr] + ") ";
			
			bool b = ExecuteSqlNoTx(S);
			
		}
		
		public void LogEntryUpdate(int LoginTrackingNbr)
		{
			
			string S = "";
			
			S = S + "UPDATE [Logins]";
			S = S + " SET [Duration] = getdate()      ";
			S = S + " WHERE (LoginTrackingNbr = " + str[LoginTrackingNbr] + ") ";
			
			bool b = ExecuteSqlNoTx(S);
			
		}
		
		public bool InsertEmail(string EmailFrom, string EmailTo, string EmailSubj, string EmailCC, string EmailBCC, string EMailBody, string EMailBody2, DateTime EmailDate)
		{
			
			string S = "";
			S = S + " INSERT INTO [Emails]";
			S = S + " ([EmailTo]";
			S = S + " ,[EmailFrom]";
			S = S + " ,[EmailSubj]";
			S = S + " ,[EmailBody]";
			S = S + " ,[EmailBody2]";
			S = S + " ,[EmailDate]";
			S = S + " ,[EmailCC]";
			S = S + " ,[EmailBcc])";
			S = S + " VALUES";
			S = S + " (\'" + EmailTo + "\',\'";
			S = S + EmailFrom + "\',\'";
			S = S + EmailSubj + "\',\'";
			S = S + EMailBody + "\',\'";
			S = S + EMailBody2 + "\',\'";
			S = S + EmailDate.ToString() + "\',\'";
			S = S + EmailCC + "\',\'";
			S = S + EmailBCC + "\')";
			
			bool b = ExecuteSqlNewConn(S, false);
			return b;
		}
		
		public void AddUploadFileData(string FQN, string UploadedBy)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			bool B = ckDatasourceExists(FQN, UploadedBy);
			if (! B)
			{
				InsertFileAudit(FQN, UploadedBy);
			}
		}
		
		public bool InsertFileAudit(string FN, string UploadedBy)
		{
			
			bool b = false;
			string s = "";
			
			b = ckDatasourceExists(FN, UploadedBy);
			
			if (b)
			{
				return true;
			}
			
			s = s + " INSERT INTO [FileUpload] ([FileName],[UploadedBy]) VALUES( ";
			s = s + "\'" + FN + "\',";
			s = s + "\'" + UploadedBy + "\')";
			
			b = ExecuteSqlNoAudit(s);
			
			if (! b)
			{
				Console.WriteLine("Audit Failed: " + s);
			}
			
			return b;
			
		}
		
		public bool setUploadSuccessTrue(int UploadID)
		{
			
			bool b = false;
			string s = "";
			
			s = " Update FileUpload set SuccessfulLoad = 1 where UploadID = " + UploadID.ToString();
			b = ExecuteSqlNoAudit(s);
			s = " Update FileUpload set EndTime = getdate() where UploadID = " + UploadID.ToString();
			b = ExecuteSqlNoAudit(s);
			s = " update FileUpload set ElapsedTime = DATEDIFF(second, StartTime, GETDATE()) where UploadID = " + UploadID.ToString();
			b = ExecuteSqlNoAudit(s);
			if (! b)
			{
				Console.WriteLine("Audit Failed: " + s);
			}
			return b;
		}
		
		public string GetLastUploadTime()
		{
			
			CloseConn();
			CkConn();
			string S = "";
			S = "Select max(UploadID) from FileUpload where SuccessfulLoad = 1 ";
			SqlDataReader rsData = null;
			int I = 0;
			string iStr = "";
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				iStr = rsData.GetValue(0).ToString();
				rsData.Close();
				rsData = null;
			}
			else
			{
				rsData.Close();
				rsData = null;
			}
			
			if (iStr.Length == 0)
			{
				return "No file has been loaded as of now...";
			}
			
			string FN = "";
			string ET = "";
			GetElapsedTime(iStr, ref FN, ref ET);
			
			if (FN.Length > 0)
			{
				return "The last upload, \'" + FN + "\', took " + ET + " seconds.";
			}
			else
			{
				return "The current load could possibly take several minutes...";
			}
			
		}
		
		public void GetElapsedTime(string UploadID, ref string FN, ref string ET)
		{
			
			try
			{
				string S = "";
				S = (string) ("Select FileName, ElapsedTime from FileUpload where UploadID = " + UploadID);
				SqlDataReader rsData = null;
				int I = 0;
				string iStr = "";
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					rsData.Read();
					FN = rsData.GetValue(0).ToString();
					ET = rsData.GetValue(1).ToString();
					rsData.Close();
					rsData = null;
				}
				else
				{
					rsData.Close();
					rsData = null;
				}
			}
			catch (Exception ex)
			{
				FN = "";
				ET = "";
				LOG.WriteToArchiveLog((string) ("clsDatabase : GetElapsedTime : 2043 : " + ex.Message));
			}
		}
		
		public bool ckAttributeExists(string AttributeName, string PropVal)
		{
			
			string s = "Select count(*) from Attribute where AttributeName = \'" + AttributeName + "\'";
			int Cnt;
			SqlDataReader rsData = null;
			bool b = false;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			
			rsData.Read();
			Cnt = rsData.GetInt32(0);
			if (Cnt > 0)
			{
				b = true;
			}
			else
			{
				b = false;
			}
			rsData.Close();
			
			return b;
		}
		
		//' <summary>
		//' Determines of a file has alraedy been loaded into the system or not.
		//' </summary>
		//' <param name="FN"></param>
		//' <returns>TRUE if the file has been loaded, FALSE if not.</returns>
		//' <remarks></remarks>
		public bool ckDatasourceExists(string FQN, string UID)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			CloseConn();
			CkConn();
			
			int Cnt;
			string s = "Select count(*) FROM DataSource ";
			s = s + " where FQN = \'" + FQN + "\' and UserID = \'" + UID + "\'";
			SqlDataReader rsData = null;
			bool b = false;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			
			rsData.Read();
			Cnt = rsData.GetInt32(0);
			if (Cnt > 0)
			{
				b = true;
			}
			else
			{
				b = false;
			}
			rsData.Close();
			
			return b;
			
		}
		
		public int getTableCount(string TblName)
		{
			try
			{
				string S = (string) ("Select  count(*) FROM " + TblName);
				CloseConn();
				CkConn();
				int Cnt;
				SqlDataReader rsData = null;
				bool b = false;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				
				rsData.Read();
				Cnt = rsData.GetInt32(0);
				
				rsData.Close();
				
				return Cnt;
			}
			catch (Exception ex)
			{
				xTrace(12306, "clsDataBase:getTableCount", ex.Message);
				if (dDebug)
				{
					Debug.Print(ex.Message);
				}
				LOG.WriteToArchiveLog((string) ("clsDatabase : getTableCount : 2083 : " + ex.Message));
				
				return 0;
			}
			
		}
		
		public int iCount(string S)
		{
			lock(this)
			{
				try
				{
					
					CloseConn();
					CkConn();
					int Cnt;
					SqlDataReader rsData = null;
					bool b = false;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					rsData = command.ExecuteReader();
					rsData.Read();
					Cnt = rsData.GetInt32(0);
					rsData.Close();
					rsData = null;
					return Cnt;
				}
				catch (Exception ex)
				{
					xTrace(12306, "clsDataBase:iCount", ex.Message);
					LOG.WriteToArchiveLog((string) ("ERROR 1993.21: " + ex.Message));
					LOG.WriteToArchiveLog((string) ("clsDatabase : iCount : 2054 : " + ex.Message));
					return -1;
				}
			}
		}
		
		public int iCountContent(string S)
		{
			
			int I = 0;
			int J = 0;
			int K = 0;
			string S1 = "";
			string S2 = "";
			S = S.Trim();
			string NewSql = "";
			string[] A = S.Split(char.Parse("\r\n").ToString().ToCharArray());
			for (I = 0; I <= (A.Length - 1); I++)
			{
				if ((A[I]).IndexOf("and KEY_TBL.RANK") + 1 > 0)
				{
					//Console.WriteLine(A(I))
				}
				else
				{
					NewSql = NewSql + A[I] + "\r\n";
				}
				S = NewSql;
			}
			
			if (S.IndexOf("FROM ") + 1 > 0)
			{
				I = S.IndexOf("select") + 1;
				//I = I + 5
				//I = InStr(I, S, "select", CompareMethod.Text)
				if (I <= 0)
				{
					return -1;
				}
				J = S.IndexOf("FROM ") + 1;
				S1 = "";
				S2 = S.Substring(J - 1);
				string SS = (string) ("Select count(*) " + S2);
				J = SS.IndexOf("order by") + 1;
				if (J > 0)
				{
					SS = SS.Substring(0, J - 1);
				}
				S = SS;
				//Clipboard.Clear()
				//Clipboard.SetText(S)
				//Console.WriteLine(S)
			}
			else
			{
				return 1;
			}
			
			K = S.IndexOf("order by") + 1;
			if (K > 0)
			{
				S = S.Substring(0, K - 1);
			}
			
			try
			{
				
				CloseConn();
				CkConn();
				int Cnt;
				SqlDataReader rsData = null;
				bool b = false;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				rsData.Read();
				Cnt = rsData.GetInt32(0);
				rsData.Close();
				rsData = null;
				return Cnt;
			}
			catch (Exception ex)
			{
				xTrace(12309, "clsDataBase:iCountContent", ex.Message);
				LOG.WriteToArchiveLog((string) ("Warning - clsDatabase : iCountContent : 2150 : " + ex.Message + "\r\n" + S));
				return 1;
			}
			
		}
		
		public string getSSCountDataSourceFiles(string SourceName, string CRC)
		{
			string SourceGuid = "";
			try
			{
				SourceName = UTIL.RemoveSingleQuotes(SourceName);
				
				string S = "Select top 1 SourceGuid from DataSource";
				S = S + " where ";
				S = S + " [SourceName] = \'" + SourceName + "\'";
				S = S + " and CRC = \'" + CRC + "\'";
				try
				{
					CloseConn();
					CkConn();
					
					SqlDataReader rsData = null;
					bool b = false;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					
					rsData = command.ExecuteReader();
					rsData.Read();
					SourceGuid = rsData.GetValue(0).ToString();
					rsData.Close();
					
				}
				catch (Exception)
				{
					return "";
				}
			}
			catch (Exception ex)
			{
				xTrace(12309, "clsDataBase:getCountDataSourceFiles", ex.Message);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getCountDataSourceFiles : 2162a : " + ex.Message));
				return "";
			}
			return SourceGuid;
		}
		
		public int getCountDataSourceFiles(string SourceName, string CRC)
		{
			int CNT = -1;
			try
			{
				SourceName = UTIL.RemoveSingleQuotes(SourceName);
				
				string S = "Select  count(*) FROM DataSource where SourceName = \'" + SourceName + "\' and CRC = \'" + CRC + "\' ";
				CloseConn();
				CkConn();
				SqlDataReader rsData = null;
				bool b = false;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				
				rsData.Read();
				CNT = rsData.GetInt32(0);
				rsData.Close();
			}
			catch (Exception ex)
			{
				xTrace(12311, "clsDataBase:getCountDataSourceFiles", ex.Message);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getCountDataSourceFiles : 2174 : " + ex.Message));
			}
			return CNT;
		}
		public int getCountDataSourceFiles(string SourceName, DateTime WebPagePublishDate)
		{
			int CNT = -1;
			try
			{
				SourceName = UTIL.RemoveSingleQuotes(SourceName);
				
				string S = "Select  count(*) FROM DataSource where SourceName = \'" + SourceName + "\' and WebPagePublishDate = \'" + WebPagePublishDate.ToString() + "\' ";
				CloseConn();
				CkConn();
				SqlDataReader rsData = null;
				bool b = false;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				
				rsData.Read();
				CNT = rsData.GetInt32(0);
				rsData.Close();
			}
			catch (Exception ex)
			{
				xTrace(12311, "clsDataBase:getCountDataSourceFiles", ex.Message);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getCountDataSourceFiles : 2174 : " + ex.Message));
			}
			return CNT;
		}
		public int getCountRssFile(string SourceName, string WebPagePublishDate)
		{
			int CNT = -1;
			try
			{
				SourceName = UTIL.RemoveSingleQuotes(SourceName);
				
				string S = "Select  count(*) FROM DataSource where SourceName = \'" + SourceName + "\' and WebPagePublishDate = \'" + WebPagePublishDate + "\' ";
				CloseConn();
				CkConn();
				SqlDataReader rsData = null;
				bool b = false;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				
				rsData.Read();
				CNT = rsData.GetInt32(0);
				rsData.Close();
			}
			catch (Exception ex)
			{
				xTrace(12311, "clsDataBase:getCountDataSourceFiles", ex.Message);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getCountDataSourceFiles : 2174 : " + ex.Message));
			}
			return CNT;
		}
		
		public int GetMaxDataSourceVersionNbr(string UserID, string FQN)
		{
			try
			{
				FQN = UTIL.RemoveSingleQuotes(FQN);
				
				string S = "Select  max ([VersionNbr]) FROM DataSource where FQN = \'" + FQN + "\' and DataSourceOwnerUserID = \'" + UserID + "\'";
				CloseConn();
				CkConn();
				int Cnt;
				
				SqlDataReader rsData = null;
				bool b = false;
				
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				
				try
				{
					if (rsData.HasRows)
					{
						rsData.Read();
						Cnt = rsData.GetInt32(0);
					}
					else
					{
						Cnt = -1;
					}
				}
				catch (Exception)
				{
					Cnt = -1;
				}
				
				
				
				if (! rsData.IsClosed)
				{
					rsData.Close();
				}
				rsData = null;
				command.Dispose();
				command = null;
				
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				
				return Cnt;
			}
			catch (Exception ex)
			{
				xTrace(12311, "clsDataBase:GetMaxDataSourceVersionNbr", ex.Message);
				LOG.WriteToArchiveLog((string) ("clsDatabase : GetMaxDataSourceVersionNbr : 2157 : " + ex.Message));
				return 0;
			}
		}
		public int GetMaxDataSourceVersionNbr(string SourceName, string CRC, string FileLength)
		{
			try
			{
				SourceName = UTIL.RemoveSingleQuotes(SourceName);
				
				string S = "Select  max ([VersionNbr]) FROM DataSource  where  SourceName = \'" + SourceName + "\' and FIleLength = " + FileLength + " and CRC = \'" + CRC + "\'";
				CloseConn();
				CkConn();
				int Cnt;
				
				SqlDataReader rsData = null;
				bool b = false;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				
				if (rsData.HasRows)
				{
					rsData.Read();
					Cnt = rsData.GetInt32(0);
				}
				else
				{
					Cnt = -1;
				}
				
				rsData.Close();
				rsData = null;
				
				return Cnt;
			}
			catch (Exception ex)
			{
				xTrace(12311, "clsDataBase:GetMaxDataSourceVersionNbr", ex.Message);
				LOG.WriteToArchiveLog((string) ("clsDatabase : GetMaxDataSourceVersionNbr : 2157 : " + ex.Message));
				return 0;
			}
		}
		
		public string getGuid()
		{
			Guid MyGuid = Guid.NewGuid();
			return MyGuid.ToString();
		}
		
		//' <summary>
		//' Bilds the sorted lists for blazing fast lookup speeds.
		//' </summary>
		//' <remarks></remarks>
		public void PopulateSortedLists()
		{
			PopulateProjectSortedList();
			PopulateProjectTeamSortedList();
		}
		
		//' <summary>
		//' The subroutine PopulateProjectSortedList populates a sorted list with all projects
		//' from the input Excel spreadsheet. This list allows us to verify that a project exists
		//' without having to access the database thus giving us extreme speed.
		//' </summary>
		//' <remarks></remarks>
		public void PopulateProjectSortedList()
		{
			int PID = 0;
			string s = "Select RomID, ProjectID from Project";
			SqlDataReader rsData = null;
			
			slProjects.Clear();
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			rsData.Read();
			
			if (rsData.HasRows)
			{
				while (rsData.Read())
				{
					string RomID = rsData.GetValue(0).ToString();
					int ProjectID = rsData.GetInt32(1);
					slProjects.Add(ProjectID, RomID);
				}
			}
			else
			{
				slProjects.Add(-1, "  New Project");
			}
			
			rsData.Close();
		}
		
		public void PopulateProjectTeamSortedList()
		{
			
			slProjectTeams.Clear();
			int PID = 0;
			string s = "Select [ProjectTeamIdentifier] +\'|\'+ cast([ProjectID] as varchar(50)), ProjectTeamID FROM [ProjectTeam]";
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			rsData.Read();
			
			if (rsData.HasRows)
			{
				while (rsData.Read())
				{
					string TeamKey = rsData.GetValue(0).ToString();
					int ProjectTeamID = rsData.GetInt32(1);
					slProjectTeams.Add(ProjectTeamID, TeamKey);
				}
			}
			else
			{
				slProjectTeams.Add(-1, "XXXX");
			}
			
			rsData.Close();
		}
		
		public void PopulateMetricPeriodSortedList()
		{
			
			slMetricPeriods.Clear();
			int PID = 0;
			string s = "Select cast([MetricPeriod] as varchar(50)) + \'|\' + cast([ProjectTeamID] as varchar(50)), [MetricRowGuid] FROM [MetricPeriodData]";
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			rsData.Read();
			
			if (rsData.HasRows)
			{
				while (rsData.Read())
				{
					string MetricKey = rsData.GetValue(0).ToString();
					int MetricID = rsData.GetInt32(1);
					slMetricPeriods.Add(MetricID, MetricKey);
				}
			}
			else
			{
				slMetricPeriods.Add(-1, "~~~~");
			}
			
			rsData.Close();
		}
		
		public string getMetricPeriodIdByKey(string MetricPeriod, string ProjectTeamID)
		{
			
			slMetricPeriods.Clear();
			int PID = 0;
			string s = "";
			string tKey = "";
			
			s = s + "Select [MetricRowGuid] ";
			s = s + "FROM [MetricPeriodData]";
			s = s + "where MetricPeriod= \'" + MetricPeriod + "\'";
			s = s + "and ProjectTeamID = " + ProjectTeamID;
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			rsData.Read();
			
			if (rsData.HasRows)
			{
				while (rsData.Read())
				{
					tKey = rsData.GetValue(0).ToString();
				}
			}
			else
			{
				tKey = "";
			}
			
			rsData.Close();
			return tKey;
		}
		
		public void LinkRunId()
		{
			int LoadID = 0;
			string s = "Select max([UploadID]) FROM [FileUpload]";
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			rsData.Read();
			
			if (rsData.HasRows)
			{
				
				LoadID = rsData.GetInt32(0);
				
				rsData.Close();
				
				s = s + "update MetricPeriodData set UploadID = " + LoadID.ToString() + " where UploadID is null";
				
				bool b = ExecuteSqlNoAudit(s);
				
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			
		}
		
		public int getLastUploadID()
		{
			
			int LoadID = -1;
			string s = "Select max([UploadID]) FROM [FileUpload]";
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			rsData.Read();
			
			if (rsData.HasRows)
			{
				
				LoadID = rsData.GetInt32(0);
				
				rsData.Close();
				
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			
			return LoadID;
			
		}
		
		public int getLastProjectID()
		{
			
			int LoadID = -1;
			string s = "Select max([ProjectID]) FROM [Project]";
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			rsData = command.ExecuteReader();
			rsData.Read();
			
			if (rsData.HasRows)
			{
				
				LoadID = rsData.GetInt32(0);
				
				rsData.Close();
				
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			
			return LoadID;
			
		}
		
		public bool ckExcelColName(string ColName)
		{
			bool B = false;
			int I = this.slExcelColNames.IndexOfKey(ColName);
			if (I < 0)
			{
				B = false;
			}
			else
			{
				B = true;
			}
			return B;
		}
		
		public void populateSortedLists(string ListName, string tKey, string tDesc)
		{
			
			//Public slGrowthPlatform As New SortedList
			//Public slOperatingGroup As New SortedList
			//Public slOperatingUnit As New SortedList
			//Public slGeography As New SortedList
			//Public slGeographicUnit As New SortedList
			//Public slClientServiceGroup As New SortedList
			//Public slDeliveryCenter As New SortedList
			//Public slTypeOfWork As New SortedList
			//Public slProjectTeamTypeOfWork As New SortedList
			//Public slSubmissionStatus As New SortedList
			
			if (ListName.Equals("GrowthPlatform"))
			{
				slGrowthPlatform.Add(tKey, tDesc);
			}
			else if (ListName.Equals("OperatingGroup"))
			{
				slOperatingGroup.Add(tKey, tDesc);
			}
			else if (ListName.Equals("OperatingUnit"))
			{
				slOperatingUnit.Add(tKey, tDesc);
			}
			else if (ListName.Equals("Geography"))
			{
				slGeography.Add(tKey, tDesc);
			}
			else if (ListName.Equals("GeographicUnit"))
			{
				slGeographicUnit.Add(tKey, tDesc);
			}
			else if (ListName.Equals("ClientServiceGroup"))
			{
				slClientServiceGroup.Add(tKey, tDesc);
			}
			else if (ListName.Equals("DeliveryCenter"))
			{
				slDeliveryCenter.Add(tKey, tDesc);
			}
			else if (ListName.Equals("TypeOfWork"))
			{
				slTypeOfWork.Add(tKey, tDesc);
			}
			else if (ListName.Equals("ProjectTeamTypeOfWork"))
			{
				slProjectTeamTypeOfWork.Add(tKey, tDesc);
			}
			else if (ListName.Equals("SubmissionStatus"))
			{
				slSubmissionStatus.Add(tKey, tDesc);
			}
			else if (ListName.Equals("SubmittedBy"))
			{
				slSubmittedBy.Add(tKey, tDesc);
			}
		}
		
		public void AddLookupData(string TBL, string CodeCol, string DescCol, string tCode, string tDesc)
		{
			string S = "";
			
			populateSortedLists(TBL, tCode, tDesc);
			
			bool b = ItemExists(TBL, CodeCol, tCode, "S");
			
			if (! b)
			{
				S = "";
				S = S + " insert into " + TBL + " (" + CodeCol + "," + DescCol + ")";
				S = S + " values ";
				S = S + " (\'" + tCode + "\',\'" + tDesc + "\')";
				
				b = ExecuteSqlNewConn(S, false);
				
			}
			
		}
		
		public void SetConfigDb(string DbId)
		{
			ConnectionStringID = DbId;
		}
		
		public string GetDsValue(SqlDataReader RS, int I)
		{
			string tVal = RS.GetValue(I).ToString();
			tVal = UTIL.RemoveSingleQuotes(tVal);
			return tVal;
		}
		
		public void AddToSL(SortedList SL, string S, ref int dups)
		{
			try
			{
				int I = SL.IndexOfKey(S);
				if (I >= 0)
				{
					dups++;
				}
				else
				{
					SL.Add(S, S);
				}
			}
			catch (Exception ex)
			{
				Console.WriteLine("Duplicate SQL statement, skipping and continuing.");
				dups++;
				LOG.WriteToArchiveLog((string) ("clsDatabase : AddToSL : 2351 : " + ex.Message));
			}
		}
		
		public void spCkNextID(string ID)
		{
			bool B = false;
			bool TimeTrk = true;
			try
			{
				CloseConn();
				CkConn();
				SqlCommand command = new SqlCommand((string) ("exec spCkNextID " + ID), gConn);
				command.CommandType = System.Data.CommandType.Text;
				//command.CommandText = "spCkNextID " + ID
				command.CommandTimeout = 3600;
				command.ExecuteNonQuery();
				command = null;
				gConn.Close();
			}
			catch (Exception ex)
			{
				//Session("ErrorLocation") = 'Session("ErrorLocation") + " : " + ex.Message
				LOG.WriteToArchiveLog((string) ("clsDatabase : spCkNextID : 2361 : " + ex.Message));
			}
		}
		
		public bool InsertEmailMsg(int ID, string UID, string FQN, string EmailGUID, string UserID, string ReceivedByName, DateTime ReceivedTime, string SenderEmailAddress, string SenderName, DateTime SentOn, string RetentionCode, string isPublic)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			bool B = false;
			try
			{
				byte[] EmailBinary = CF.FileToByte(FQN);
				
				//*******************************************************
				int OriginalSize = EmailBinary.Length;
				
				EmailBinary = COMP.CompressBuffer(EmailBinary);
				
				int CompressedSize = EmailBinary.Length;
				bool RC = false;
				string rMsg = "";
				DateTime TransmissionStartTime = DateTime.Now;
				DateTime txEndTime = DateTime.Now;
				
				
				//Dim Proxy As New SVCCLCArchive.Service1Client
				B = System.Convert.ToBoolean(Proxy.InsertEmailMsg(modGlobals.gGateWayID, ID, UID, FQN, EmailGUID, UID, ReceivedByName, ReceivedTime, SenderEmailAddress, SenderName, SentOn, EmailBinary, OriginalSize, CompressedSize, RC, rMsg, TransmissionStartTime, txEndTime, RetentionCode, isPublic));
				
				//*******************************************************
				
				//    'UserID, ReceivedByName As String, ReceivedTime As DateTime, SenderEmailAddress As String, SenderName As String, SentOn As DateTime
				//    Using connection As New SqlConnection(getGateWayConnStr(gGateWayID))
				//        Using command As New SqlCommand("spInsertEmailMsg", connection)
				//            command.CommandType = CommandType.StoredProcedure
				//            command.Parameters.Add(New SqlParameter("@EmailGuid", EmailGUID))
				//            command.Parameters.Add(New SqlParameter("@EmailImage", EmailBinary))
				
				//            command.Parameters.Add(New SqlParameter("@UserID", UserID))
				//            command.Parameters.Add(New SqlParameter("@ReceivedByName", ReceivedByName))
				//            command.Parameters.Add(New SqlParameter("@ReceivedTime", ReceivedTime))
				//            command.Parameters.Add(New SqlParameter("@SenderEmailAddress", SenderEmailAddress))
				//            command.Parameters.Add(New SqlParameter("@SenderName", SenderName))
				//            command.Parameters.Add(New SqlParameter("@SentOn", SentOn))
				
				//            connection.Open()
				//            command.ExecuteNonQuery()
				//            connection.Close()
				//            connection.Dispose()
				//            command.Dispose()
				//        End Using
				//    End Using
				//    B = True
			}
			catch (Exception ex)
			{
				xTrace(12315, "clsDataBase:InsertEmailMsg", ex.Message);
				if (dDebug)
				{
					Debug.Print(ex.Message);
				}
				B = false;
				LOG.WriteToArchiveLog((string) ("clsDatabase : InsertEmailMsg : 2386 : " + ex.Message));
			}
			return B;
		}
		
		public bool UpdateEmailMsg(string OriginalName, int ID, string UID, string FQN, string EmailGUID, string RetentionCode, string isPublic, string CrcHash)
		{
			int LL = 0;
			FQN = UTIL.RemoveSingleQuotes(FQN);
			LL = 1;
			bool B = false;
			LL = 2;
			
			int OriginalSize = 0;
			int CompressedSize = 0;
			
			try
			{
				byte[] EmailBinary = CF.FileToByte(FQN);
				//*******************************************************
				OriginalSize = EmailBinary.Length;
				
				//** Use Compression to cut down on transmit time here
				EmailBinary = COMP.CompressBuffer(EmailBinary);
				
				CompressedSize = EmailBinary.Length;
				
				bool RC = false;
				string rMsg = "";
				DateTime TransmissionStartTime = DateTime.Now;
				DateTime txEndTime = DateTime.Now;
				
				//*******************************************************
				bool bUseNewDbArch = true;
				if (bUseNewDbArch)
				{
					UploadFileImage(OriginalName, EmailGUID, FQN, "Email", RetentionCode, isPublic, CrcHash);
					B = true;
				}
				else
				{
					B = System.Convert.ToBoolean(Proxy.UpdateEmailMsg(modGlobals.gGateWayID, ID, UID, FQN, EmailGUID, EmailBinary, OriginalSize, CompressedSize, RC, rMsg, TransmissionStartTime, txEndTime));
				}
				//*******************************************************
				
				LOG.WriteToArchiveLog((string) ("clsDatabase : UPLOADED EMAIL - OriginalSize = " + OriginalSize.ToString() + " : CompressedSize =" + CompressedSize.ToString()));
			}
			catch (Exception ex)
			{
				xTrace(12315, "clsDataBase:UpdateEmailMsg", ex.Message);
				if (dDebug)
				{
					Debug.Print(ex.Message);
				}
				B = false;
				LOG.WriteToArchiveLog((string) ("clsDatabase : UpdateEmailMsg : 2404 : LL = " + LL.ToString() + " : " + ex.Message + "\r\n" + " : " + FQN + "\r\n" + " : " + EmailGUID));
				LOG.WriteToUploadLog((string) ("clsDatabase ERROR: UpdateEmailMsg : OriginalSize = " + OriginalSize.ToString() + " : CompressedSize =" + CompressedSize.ToString()));
			}
			return B;
		}
		
		public bool UpdateAttachment(string EmailGUID, byte[] AttachmentBinary, string AttachmentName, string AttachmentCode)
		{
			
			bool bExtendTime = false;
			if (AttachmentBinary.Length > 4000000000)
			{
				LOG.WriteToArchiveLog((string) ("Notification : InsertSourcefile : 661b : Loading extremely large file: " + AttachmentName + "\r\n" + "File Length: " + AttachmentBinary.Length.ToString()));
			}
			
			string InsertConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			UTIL.ExtendTimeoutBySize(InsertConnStr, AttachmentBinary.Length);
			
			bool B = false;
			try
			{
				using (SqlConnection connection = new SqlConnection(InsertConnStr))
				{
					using (SqlCommand command = new SqlCommand("UpdateAttachment", connection))
					{
						command.CommandType = CommandType.StoredProcedure;
						command.Parameters.Add(new SqlParameter("@EmailGuid", EmailGUID));
						command.Parameters.Add(new SqlParameter("@Attachment", AttachmentBinary));
						command.Parameters.Add(new SqlParameter("@AttachmentName", AttachmentName));
						command.Parameters.Add(new SqlParameter("@AttachmentCode", AttachmentCode));
						connection.Open();
						command.ExecuteNonQuery();
						connection.Close();
						command.Dispose();
					}
					
				}
				
				B = true;
			}
			catch (Exception ex)
			{
				xTrace(12315, "clsDataBase:UpdateAttachment", ex.Message);
				if (dDebug)
				{
					Debug.Print(ex.Message);
				}
				B = false;
				LOG.WriteToArchiveLog((string) ("clsDatabase : UpdateAttachment : 2423 : " + ex.Message));
			}
			return B;
		}
		
		public bool UpdateAttachmentByFQN(int ID, string UID, string FQN, string EmailGUID, string AttachmentName, string AttachmentCode)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			bool B = false;
			try
			{
				byte[] AttachmentBinary = CF.FileToByte(FQN);
				//*******************************************************
				int OriginalSize = AttachmentBinary.Length;
				
				AttachmentBinary = COMP.CompressBuffer(AttachmentBinary);
				
				int CompressedSize = AttachmentBinary.Length;
				bool RC = false;
				string rMsg = "";
				DateTime TransmissionStartTime = DateTime.Now;
				DateTime txEndTime = DateTime.Now;
				
				
				//Dim Proxy As New SVCCLCArchive.Service1Client
				B = System.Convert.ToBoolean(Proxy.UpdateAttachmentByFQN(modGlobals.gGateWayID, ID, UID, FQN, EmailGUID, AttachmentName, AttachmentCode, AttachmentBinary, OriginalSize, CompressedSize, RC, rMsg, TransmissionStartTime, txEndTime));
				//*******************************************************
				
				//Using connection As New SqlConnection(getGateWayConnStr(gGateWayID))
				//    Using command As New SqlCommand("UpdateAttachment", connection)
				//        command.CommandType = CommandType.StoredProcedure
				//        command.Parameters.Add(New SqlParameter("@EmailGuid", EmailGUID))
				//        command.Parameters.Add(New SqlParameter("@Attachment", AttachmentBinary))
				//        command.Parameters.Add(New SqlParameter("@AttachmentName", AttachmentName))
				//        command.Parameters.Add(New SqlParameter("@AttachmentCode", AttachmentCode))
				//        connection.Open()
				//        command.ExecuteNonQuery()
				//        connection.Close()
				//        command.Dispose()
				//    End Using
				//End Using
				B = true;
			}
			catch (Exception ex)
			{
				xTrace(12315, "clsDataBase:UpdateAttachmentByFQN", ex.Message);
				if (dDebug)
				{
					Debug.Print(ex.Message);
				}
				B = false;
				LOG.WriteToArchiveLog((string) ("clsDatabase : UpdateAttachmentByFQN : 2443 : " + ex.Message));
			}
			return B;
		}
		
		public bool xInsertAttachment(string EmailGUID, byte[] AttachmentBinary, string AttachmentName, string AttachmentCode)
		{
			bool B = false;
			try
			{
				using (SqlConnection connection = new SqlConnection(getGateWayConnStr(modGlobals.gGateWayID)))
				{
					using (SqlCommand command = new SqlCommand("InsertAttachment", connection))
					{
						command.CommandType = CommandType.StoredProcedure;
						command.Parameters.Add(new SqlParameter("@EmailGuid", EmailGUID));
						command.Parameters.Add(new SqlParameter("@Attachment", AttachmentBinary));
						command.Parameters.Add(new SqlParameter("@AttachmentName", AttachmentName));
						command.Parameters.Add(new SqlParameter("@AttachmentCode", AttachmentCode));
						connection.Open();
						command.ExecuteNonQuery();
					}
					
				}
				
				B = true;
			}
			catch (Exception ex)
			{
				xTrace(82711, "clsDatabase:InsertAttachment: ", ex.Message.ToString(), ex);
				if (dDebug)
				{
					Debug.Print(ex.Message);
				}
				B = false;
				LOG.WriteToArchiveLog((string) ("clsDatabase : InsertAttachment : 2460 : " + ex.Message));
			}
			return B;
		}
		public void ValidateExtExists(string FQN)
		{
			clsATTACHMENTTYPE ATYPE = new clsATTACHMENTTYPE();
			string FileExt = (string) ("." + UTIL.getFileSuffix(FQN));
			int bCnt = ATYPE.cnt_PK29(FileExt);
			if (bCnt == 0)
			{
				ATYPE.setDescription("Auto added this code.");
				ATYPE.setAttachmentcode(ref FileExt);
				ATYPE.Insert();
			}
			ATYPE = null;
		}
		
		public bool InsertAttachmentFqn(string UID, string FQN, string EmailGUID, string AttachmentName, string AttachmentCode, string UserGuidID, string RetentionCode, string CrcHASH, string isPublic, string ContainerName)
		{
			
			
			//** See if the attachment has been added previously
			string OriginalFileName = DMA.getFileName(FQN);
			string AttachmentType = DMA.getFileExtension(FQN);
			
			FQN = UTIL.RemoveSingleQuotes(FQN);
			AttachmentName = UTIL.RemoveSingleQuotes(AttachmentName);
			
			bool B = false;
			bool RC = false;
			string ReturnMsg = "";
			DateTime TxStartTime = DateTime.Now;
			DateTime TxEndTime = DateTime.Now;
			string RetMsg = "";
			
			string SS = "select COUNT(*) from EmailAttachment where AttachmentName = \'" + AttachmentName + "\' and CRC = \'" + CrcHASH + "\'";
			int iCnt = iCount(SS);
			
			if (iCnt > 0)
			{
				frmNotify2.Default.BackColor = Color.HotPink;
				frmNotify2.Default.Refresh();
				string RowGuid = GetEmailAttachmentGuid(AttachmentName, CrcHASH);
				saveContentOwner(RowGuid, UID, "A", ContainerName, modGlobals.gMachineID, modGlobals.gNetworkID);
				return true;
			}
			//** See if the file already exists in the EMAIL ATTACHMENT table
			//** If so, increment the counter and return
			//** If not, add it and fall through to the rest of the code
			
			//If UseFileStream Then
			string NewAttachmentGuid = "";
			
			//********************************************************************************************************************************************
			NewAttachmentGuid = (string) (Proxy.InsertEmailAttachmentRecord(modGlobals.gGateWayID, EmailGUID, AttachmentName, AttachmentCode, AttachmentType, UID, RetMsg, CrcHASH));
			saveContentOwner(NewAttachmentGuid, UserGuidID, "A", ContainerName, modGlobals.gMachineID, modGlobals.gNetworkID);
			UploadFileImage(AttachmentName, NewAttachmentGuid, FQN, "EmailAttachment", RetentionCode, isPublic, CrcHASH);
			//********************************************************************************************************************************************
			GC.Collect();
			GC.WaitForPendingFinalizers();
			TxEndTime = DateTime.Now;
			Console.WriteLine("TX Time: " + TC.ElapsedTimeInMS(TxStartTime, TxEndTime));
			if (RetMsg.Length == 0)
			{
				if (ckOcrNeeded(AttachmentType))
				{
					setOcrProcessingParms(EmailGUID, "A", AttachmentName);
					//** call service to LAUNCH server side console app here
				}
				B = true;
			}
			else
			{
				B = false;
			}
			return B;
		}
		
		public bool ckOcrNeeded(string AttachmentType)
		{
			//** Convert to use [ImageTypeCode] table in database
			if (AttachmentType.ToLower().Equals(".pdf"))
			{
				return true;
			}
			else if (AttachmentType.ToLower().Equals("pdf"))
			{
				return true;
			}
			else if (AttachmentType.ToLower().Equals("jpg"))
			{
				return true;
			}
			else if (AttachmentType.ToLower().Equals(".jpg"))
			{
				return true;
			}
			else if (AttachmentType.ToLower().Equals("png"))
			{
				return true;
			}
			else if (AttachmentType.ToLower().Equals(".png"))
			{
				return true;
			}
			else if (AttachmentType.ToLower().Equals("trf"))
			{
				return true;
			}
			else if (AttachmentType.ToLower().Equals(".trf"))
			{
				return true;
			}
			else if (AttachmentType.ToLower().Equals("gif"))
			{
				return true;
			}
			else if (AttachmentType.ToLower().Equals(".gif"))
			{
				return true;
			}
			else if (AttachmentType.ToLower().Equals("bmp"))
			{
				return true;
			}
			else if (AttachmentType.ToLower().Equals(".bmp"))
			{
				return true;
			}
			else if (AttachmentType.ToLower().Equals("tif"))
			{
				return true;
			}
			else if (AttachmentType.ToLower().Equals(".tif"))
			{
				return true;
			}
			else if (AttachmentType.ToLower().Equals("tiff"))
			{
				return true;
			}
			else if (AttachmentType.ToLower().Equals(".tiff"))
			{
				return true;
			}
			else if (AttachmentType.ToLower().Equals("jif"))
			{
				return true;
			}
			else if (AttachmentType.ToLower().Equals(".jif"))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		
		public bool UpdateEmailBinary(int ID, string UID, string FQN, string EmailGUID)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			bool B = false;
			byte[] EmailBinary = CF.FileToByte(FQN);
			
			//*******************************************************
			int OriginalSize = EmailBinary.Length;
			
			EmailBinary = COMP.CompressBuffer(EmailBinary);
			
			int CompressedSize = EmailBinary.Length;
			bool RC = false;
			string rMsg = "";
			DateTime TransmissionStartTime = DateTime.Now;
			DateTime txEndTime = DateTime.Now;
			
			
			//Dim Proxy As New SVCCLCArchive.Service1Client
			B = System.Convert.ToBoolean(Proxy.UpdateEmailBinary(modGlobals.gGateWayID, ID, UID, FQN, EmailGUID, EmailBinary, OriginalSize, CompressedSize, RC, rMsg, TransmissionStartTime, txEndTime));
			return B;
			//*******************************************************
			
			//Try
			//    Using connection As New SqlConnection(getGateWayConnStr(gGateWayID))
			//        Using command As New SqlCommand("spUpdateEmailMsg", connection)
			//            command.CommandType = CommandType.StoredProcedure
			//            command.Parameters.Add(New SqlParameter("@EmailGuid", EmailGUID))
			//            command.Parameters.Add(New SqlParameter("@EmailImage", EmailBinary))
			//            connection.Open()
			//            command.ExecuteNonQuery()
			//        End Using
			//    End Using
			//    B = True
			//Catch ex As Exception
			//    xTrace(82713, "UpdateEmailBinary: ", ex.Message.ToString, ex)
			//    If dDebug Then Debug.Print(ex.Message)
			//    B = False
			//    log.WriteToArchiveLog("clsDatabase : UpdateEmailBinary : 2495a : " + ex.Message)
			//End Try
			//Return B
		}
		
		public bool ckDocumentExists(string SourceName, string CRC)
		{
			SourceName = UTIL.RemoveSingleQuotes(SourceName);
			string S = "";
			bool B = false;
			int cnt = -1;
			
			try
			{
				S = " select count(*) from DataSource where SourceName = \'" + SourceName + "\' and CRC = \'" + CRC.ToString() + "\' ";
				CloseConn();
				CkConn();
				using (gConn)
				{
					
					SqlDataReader RSData = null;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					RSData = command.ExecuteReader();
					RSData.Read();
					cnt = int.Parse(RSData.GetValue(0).ToString());
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				
				if (cnt > 0)
				{
					B = true;
				}
				else
				{
					B = false;
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("Error 199.99.1 - clsDatabase : ckDocumentExists: " + ex.Message + "\r\n" + S));
				B = false;
			}
			
			
			return B;
			
		}
		public bool ckDocumentExists(string SourceName, string MachineID, string CRC)
		{
			SourceName = UTIL.RemoveSingleQuotes(SourceName);
			string S = "";
			bool B = false;
			int cnt = -1;
			
			try
			{
				S = " select count(*) from DataSource where SourceName = \'" + SourceName + "\' and CRC = \'" + CRC + "\' and MachineID = \'" + MachineID + "\'";
				CloseConn();
				CkConn();
				using (gConn)
				{
					
					SqlDataReader RSData = null;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					RSData = command.ExecuteReader();
					RSData.Read();
					cnt = int.Parse(RSData.GetValue(0).ToString());
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				
				if (cnt > 0)
				{
					B = true;
				}
				else
				{
					B = false;
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("Error 199.99.1 - clsDatabase : ckDocumentExists: " + ex.Message + "\r\n" + S));
				B = false;
			}
			
			
			return B;
			
		}
		
		public bool InsertSourcefile(string UID, string MachineID, string NetworkName, string SourceGuid, string UploadFQN, string SourceName, string SourceTypeCode, string sLastAccessDate, string sCreateDate, string sLastWriteTime, string DataSourceOwnerUserID, int VersionNbr, string RetentionCode, string isPublic, string CrcHASH, string FolderName)
		{
			
			DateTime LastAccessDate = null;
			DateTime CreateDate = null;
			DateTime LastWriteTime = null;
			
			saveContentOwner(SourceGuid, DataSourceOwnerUserID, "C", FolderName, MachineID, NetworkName);
			
			try
			{
				LastWriteTime = DateTime.Parse(sLastWriteTime);
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: InsertSourceFile 100 - LastWriteTime: " + ex.Message + "\r\n" + sLastWriteTime));
			}
			
			try
			{
				LastAccessDate = DateTime.Parse(sLastAccessDate);
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: InsertSourceFile 101 - LastAccessDate: " + ex.Message + "\r\n" + sLastAccessDate));
			}
			
			try
			{
				CreateDate = DateTime.Parse(sCreateDate);
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: InsertSourceFile 102 - CreateDate: " + ex.Message + "\r\n" + sCreateDate));
			}
			
			string fExt = DMA.getFileExtension(UploadFQN);
			
			if (fExt.Length == 0)
			{
				UploadFQN = UploadFQN + ".UKN";
				SourceTypeCode = ".txt";
			}
			else
			{
				string SubstituteFileType = getProcessFileAsExt(fExt);
				if (SubstituteFileType.Trim.Length > 0)
				{
					SourceTypeCode = SubstituteFileType;
				}
			}
			
			UploadFQN = UTIL.ReplaceSingleQuotes(UploadFQN);
			
			bool B = false;
			B = ckDocumentExists(SourceName, CrcHASH);
			if (B == true)
			{
				saveContentOwner(SourceGuid, modGlobals.gCurrUserGuidID, "C", FolderName, modGlobals.gMachineID, modGlobals.gNetworkID);
				LOG.WriteToArchiveLog((string) ("Info: clsDatabase : InsertSourcefile: file exists, did not update or overwrite." + "\r\n" + UploadFQN));
				return true;
			}
			else
			{
				Console.WriteLine("No Exists: " + SourceName);
			}
			
			SourceName = UTIL.RemoveSingleQuotes(SourceName);
			SourceTypeCode = UTIL.RemoveSingleQuotes(SourceTypeCode);
			LastAccessDate = DateTime.Parse(UTIL.RemoveSingleQuotes(LastAccessDate.ToString()));
			CreateDate = DateTime.Parse(UTIL.RemoveSingleQuotes(CreateDate.ToString()));
			LastWriteTime = DateTime.Parse(UTIL.RemoveSingleQuotes(LastWriteTime.ToString()));
			DataSourceOwnerUserID = UTIL.RemoveSingleQuotes(DataSourceOwnerUserID);
			
			UploadFQN = UTIL.ReplaceSingleQuotes(UploadFQN);
			
			File F;
			if (! F.Exists(UploadFQN))
			{
				LOG.WriteToArchiveLog("ERROR - InsertSourcefile : 2519.2c : could not find file {" + UploadFQN + "}, skipped.");
				return false;
			}
			
			F = null;
			
			byte[] AttachmentBinary = CF.FileToByte(UploadFQN);
			if (AttachmentBinary == null)
			{
				LOG.WriteToArchiveLog("Notification : InsertSourcefile : 661c1 : FILE Failed to load: " + UploadFQN + ".");
				return false;
			}
			if (AttachmentBinary.Length == 0)
			{
				LOG.WriteToArchiveLog("Notification : InsertSourcefile : 661z1 : FILE Failed to load: " + UploadFQN + ".");
				return false;
			}
			if (AttachmentBinary.Length > 500000000)
			{
				LOG.WriteToArchiveLog((string) ("Notification : InsertSourcefile : 661b : Loading large file: " + UploadFQN + "\r\n" + "File Length: " + AttachmentBinary.Length.ToString()));
			}
			if (AttachmentBinary.Length > 1000000000)
			{
				LOG.WriteToArchiveLog((string) ("Notification : InsertSourcefile : 661b : Loading extremely large file: " + UploadFQN + "\r\n" + "File Length: " + AttachmentBinary.Length.ToString()));
			}
			
			try
			{
				
				bool RC = false;
				string ReturnMsg = "";
				DateTime TxStartTime = DateTime.Now;
				DateTime TxEndTime = DateTime.Now;
				
				int OriginalSize = AttachmentBinary.Length;
				AttachmentBinary = COMP.CompressBuffer(AttachmentBinary);
				int CompressedSize = AttachmentBinary.Length;
				
				
				//** Check to see if this file requires OCR or PDF processing here
				//** If so, copy it to the Processing directory and let the command line utiltiy process it
				//Dim Proxy As New SVCCLCArchive.Service1Client
				B = System.Convert.ToBoolean(Proxy.InsertSourcefile(modGlobals.gGateWayID, 444121, UID, MachineID, SourceGuid, UploadFQN, SourceName, SourceTypeCode, sLastAccessDate, sCreateDate, sLastWriteTime, UID, VersionNbr, AttachmentBinary, OriginalSize, CompressedSize, RC, ReturnMsg, TxStartTime, TxEndTime, RetentionCode, isPublic));
				
				if (! B)
				{
					LOG.WriteToArchiveLog((string) ("ERROR Load Failed for: " + UploadFQN + "\r\n" + ReturnMsg));
				}
				else
				{
					LOG.WriteToArchiveLog((string) ("Notice Load successful for: " + UploadFQN));
					saveContentOwner(SourceGuid, modGlobals.gCurrUserGuidID, "C", FolderName, modGlobals.gMachineID, modGlobals.gNetworkID);
					if (ckOcrNeeded(fExt))
					{
						setOcrProcessingParms(SourceGuid, "C", SourceName);
					}
					
				}
				
				
				//proxy = Nothing
				GC.Collect();
				GC.WaitForPendingFinalizers();
				
			}
			catch (Exception ex)
			{
				B = false;
				xTrace(82715, "InsertSourcefile: ", ex.Message.ToString(), ex);
				LOG.WriteToArchiveLog((string) ("clsDatabase : xInsertSourcefile : 2495b : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : xInsertSourcefile : 2495b File: " + UploadFQN));
			}
			return B;
		}
		
		public bool UpdateSourceImage(string OriginalFileName, string UID, string MachineID, string SourceGuid, string LastAccessDate, string CreateDate, string LastWriteTime, int VersionNbr, string UploadFQN, string RetentionCode, string isPublic, string CrcHASH)
		{
			
			string TrackUploads = System.Configuration.ConfigurationManager.AppSettings["TrackUploads"];
			
			int LL = 0;
			bool B = false;
			bool bLogUploads = true;
			
			int OriginalSize = 0;
			int CompressedSize = 0;
			bool bError = false;
			try
			{
				
				if (TrackUploads.Equals("1"))
				{
					bLogUploads = true;
				}
				else
				{
					bLogUploads = false;
				}
				
				LL = 1;
				LastAccessDate = UTIL.RemoveSingleQuotes(LastAccessDate);
				CreateDate = UTIL.RemoveSingleQuotes(CreateDate);
				LastWriteTime = UTIL.RemoveSingleQuotes(LastWriteTime);
				LL = 2;
				File F;
				LL = 3;
				if (UploadFQN.IndexOf("\'\'") + 1 > 0)
				{
					UploadFQN = UTIL.ReplaceSingleQuotes(UploadFQN);
				}
				LL = 4;
				if (! F.Exists(UploadFQN))
				{
					LOG.WriteToArchiveLog("NOTICE 100-B: Cannot update \'" + UploadFQN + "\' as it does not appear to exist.");
					return false;
				}
				LL = 5;
				F = null;
				
				byte[] AttachmentBinary = CF.FileToByte(UploadFQN);
				
				bool bExtendTime = false;
				LL = 6;
				if (AttachmentBinary.Length <= 0)
				{
					LOG.WriteToArchiveLog("ERROR : InsertSourcefile : 661b failed to open file: " + UploadFQN + ".");
					return false;
				}
				if (AttachmentBinary.Length > 1000000)
				{
					bExtendTime = true;
				}
				LL = 7;
				if (AttachmentBinary.Length > 4000000000)
				{
					LOG.WriteToArchiveLog((string) ("Notification : InsertSourcefile : 661b : Loading extremely large file: " + UploadFQN + "\r\n" + "File Length: " + AttachmentBinary.Length.ToString()));
				}
				if (AttachmentBinary.Length > 1000000000)
				{
					LOG.WriteToArchiveLog((string) ("Notification : InsertSourcefile : 661b : Loading HUGE large file: " + UploadFQN + "\r\n" + "File Length: " + AttachmentBinary.Length.ToString()));
					frmNotifyMessage.Default.Show((IWin32Window) ("Notification : 661 : Loading HUGE large file: " + UploadFQN + "\r\n" + "File Length: " + AttachmentBinary.Length.ToString() + "\r\n" + "Over a network, this can take hours."));
				}
				LL = 8;
				
				bool RC = false;
				string ReturnMsg = "";
				DateTime TxStartTime = DateTime.Now;
				DateTime TxEndTime = DateTime.Now;
				
				LL = 9;
				
				bool bFileCompressed = false;
				byte[] CopyOfAttachmentBinary = AttachmentBinary;
				OriginalSize = AttachmentBinary.Length;
				AttachmentBinary = COMP.CompressBuffer(AttachmentBinary);
				CompressedSize = AttachmentBinary.Length;
				
				LL = 10;
				
				if (CompressedSize >= OriginalSize)
				{
					LL = 11;
					AttachmentBinary = CopyOfAttachmentBinary;
					CopyOfAttachmentBinary = null;
					bFileCompressed = false;
				}
				else
				{
					LL = 12;
					CopyOfAttachmentBinary = null;
					bFileCompressed = true;
				}
				LL = 13;
				if (bLogUploads)
				{
					LL = 14;
					string sMsg = (string) ("Start Upload: oSize=" + OriginalSize.ToString() + " / cSize=" + CompressedSize.ToString() + (", Time: " + DateTime.Now.ToString() + " - " + UploadFQN));
					LOG.WriteToUploadLog(sMsg);
				}
				LL = 15;
				//** Herein lies the Problem:
				//**     1 - 16k seems to be the maximum size that will successfully upload.
				//**     2 - See if MS will help us setup a STREAM to memory upload as well
				//**     3 - See if MS can get us a 4GB upload both in stream to file on the
				//**         server side as well as a stream to memory on the server side.
				//**     4 - Possibly MS can give us a better way to compresss/zip messages on both ends
				//Dim Proxy As New SVCCLCArchive.Service1Client
				
				bool bUseNewDbArch = true;
				
				if (bUseNewDbArch)
				{
					LL = 16;
					UploadFileImage(OriginalFileName, SourceGuid, UploadFQN, "DataSource", RetentionCode, isPublic, CrcHASH);
					B = true;
				}
				else
				{
					LL = 17;
					B = System.Convert.ToBoolean(Proxy.UpdateSourceImage(modGlobals.gGateWayID, bFileCompressed, 3, UID, SourceGuid, LastAccessDate, CreateDate, LastWriteTime, VersionNbr, UploadFQN, MachineID, AttachmentBinary, OriginalSize, CompressedSize, RC, ReturnMsg, TxStartTime, TxEndTime));
				}
				LL = 18;
				if (ReturnMsg.Length > 0 || ! B)
				{
					LL = 19;
					string sMsg = (string) ("ERROR Upload: " + ReturnMsg + "  / oSize=" + OriginalSize.ToString() + " / cSize=" + CompressedSize.ToString() + (", Time: " + DateTime.Now.ToString() + " - " + UploadFQN));
					LOG.WriteToUploadLog(sMsg);
				}
				LL = 20;
				//Proxy = Nothing
				GC.Collect();
				GC.WaitForPendingFinalizers();
				LL = 24;
			}
			catch (Exception ex)
			{
				bError = true;
				FileInfo FI = new FileInfo(UploadFQN);
				int fSIze = (int) FI.Length;
				FI = null;
				
				xTrace(7321, (string) ("Unrecoverable Error - clsDatabase : UpdateSourcefile: in line: " + LL.ToString()), ex.Message.ToString(), ex);
				B = false;
				LOG.WriteToArchiveLog((string) ("Unrecoverable Error - clsDatabase : UpdateSourcefile : 2517a LL= \'" + LL.ToString() + "\' : SourceGuid = \'" + SourceGuid + "\' : Size = " + fSIze.ToString() + "\r\n" + ex.Message));
				LOG.WriteToArchiveLog((string) ("ERROR         UpdateSourcefile : 2517a : " + UploadFQN));
				if (ex.InnerException != null)
				{
					LOG.WriteToArchiveLog((string) ("ERROR         UpdateSourcefile : 2517a.1 : " + ex.InnerException.ToString()));
				}
				
			}
			
			if (bLogUploads)
			{
				if (bError)
				{
					string sMsg = (string) ("END Upload: (ERROR) oSize=" + OriginalSize.ToString() + " / cSize=" + CompressedSize.ToString() + (", Time: " + DateTime.Now.ToString() + " - " + UploadFQN));
					LOG.WriteToUploadLog(sMsg);
				}
				else
				{
					string sMsg = (string) ("END Upload: oSize=" + OriginalSize.ToString() + " / cSize=" + CompressedSize.ToString() + (", Time: " + DateTime.Now.ToString() + " - " + UploadFQN));
					LOG.WriteToUploadLog(sMsg);
				}
				
			}
			
			return B;
		}
		
		public bool UpdateUrlBinaryHtml(string UID, string SourceGuid, string LastAccessDate, string CreateDate, string LastWriteTime, int VersionNbr, string HTML)
		{
			
			bool B = false;
			bool RC = false;
			string ReturnMsg = "";
			DateTime TxStartTime = DateTime.Now;
			DateTime TxEndTime = DateTime.Now;
			byte[] AttachmentBinary = StrToByteArray(HTML);
			
			int OriginalSize = AttachmentBinary.Length;
			AttachmentBinary = COMP.CompressBuffer(AttachmentBinary);
			int CompressedSize = AttachmentBinary.Length;
			
			//Dim Proxy As New SVCCLCArchive.Service1Client
			B = System.Convert.ToBoolean(Proxy.UpdateUrlBinaryHtml(modGlobals.gGateWayID, 2, UID, SourceGuid, LastAccessDate, CreateDate, LastWriteTime, VersionNbr, AttachmentBinary, OriginalSize, CompressedSize, RC, ReturnMsg, TxStartTime, TxEndTime));
			//proxy = Nothing
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			Console.WriteLine("TX Time: " + TC.ElapsedTimeInMS(TxStartTime, TxEndTime));
			
			return B;
		}
		
		public bool isSourcefileOlderThanLastEntry(string SourceName, string CrcHASH)
		{
			
			bool B = false;
			string S = "";
			SqlDataReader rsData = null;
			
			try
			{
				SourceName = UTIL.RemoveSingleQuotes(SourceName);
				
				S = "Select  count(*) from DataSource where SourceName = \'" + SourceName + "\' and CRC = \'" + CrcHASH + "\' ";
				
				int iCnt = 0;
				iCnt = iCount(S);
				
				if (iCnt > 0)
				{
					B = true;
				}
				else
				{
					B = false;
				}
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: 9755.21cx - " + ex.Message + "\r\n" + S));
				B = true;
			}
			finally
			{
				rsData = null;
			}
			
			return B;
		}
		
		public bool XXisSourcefileOlderThanLastEntry(string UserID, string SourceGuid, string UploadFQN, string SourceName, string SourceTypeCode, string FileLength, string LastAccessDate, string CreateDate, string LastWriteTime, string VersionNbr)
		{
			
			bool B = false;
			string S = "";
			SqlDataReader rsData = null;
			
			try
			{
				UploadFQN = UTIL.RemoveSingleQuotes(UploadFQN);
				
				S = "Select  ";
				S = S + "  [FileLength]";
				S = S + " ,[LastAccessDate]";
				S = S + " ,[CreateDate]";
				S = S + " ,[LastWriteTime]";
				S = S + " FROM DataSource ";
				S = S + " where FQN = \'" + UploadFQN + "\' ";
				S = S + " and VersionNbr = " + VersionNbr;
				S = S + " and DataSourceOwnerUserID = \'" + UserID + "\'";
				
				int i = 0;
				string id = "";
				
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				
				if (rsData.HasRows)
				{
					
					rsData.Read();
					
					string tFileLength = rsData.GetValue(0).ToString();
					string tLastAccessDate = rsData.GetValue(1).ToString();
					string tCreateDate = rsData.GetValue(2).ToString();
					string tLastWriteTime = rsData.GetValue(3).ToString();
					
					LastAccessDate = UTIL.VerifyDate(LastAccessDate);
					CreateDate = UTIL.VerifyDate(CreateDate);
					LastWriteTime = UTIL.VerifyDate(LastWriteTime);
					
					tLastAccessDate = UTIL.VerifyDate(tLastAccessDate);
					tCreateDate = UTIL.VerifyDate(tCreateDate);
					tLastWriteTime = UTIL.VerifyDate(tLastWriteTime);
					
					if (int.Parse(FileLength) != int.Parse(tFileLength))
					{
						B = true;
					}
					else if (DateTime.Parse(CreateDate) != DateTime.Parse(tCreateDate))
					{
						B = true;
					}
					else if (DateTime.Parse(LastWriteTime) > DateTime.Parse(tLastWriteTime))
					{
						B = true;
					}
					
				}
				else
				{
					id = "";
				}
				
				rsData.Close();
				rsData = null;
				
				command.Dispose();
				command = null;
				
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: 9755.21cx - " + ex.Message + "\r\n" + S));
				B = true;
			}
			finally
			{
				rsData = null;
			}
			
			return B;
		}
		
		public byte[] GetAttachmentFromDB(string EmailGuid)
		{
			
			SqlConnection con = new SqlConnection(getGateWayConnStr(modGlobals.gGateWayID));
			SqlDataAdapter da = new SqlDataAdapter("Select * From EmailAttachment where EmailGuid = \'" + EmailGuid + "\'", con);
			SqlCommandBuilder MyCB = new SqlCommandBuilder(da);
			System.Data.DataSet ds = new System.Data.DataSet();
			string TypeAttachmentCode = "";
			
			con.Open();
			da.Fill(ds, "Attachments");
			System.Data.DataRow myRow;
			myRow = ds.Tables["Attachments"].Rows[0];
			
			byte[] MyData;
			MyData = (byte[]) (myRow["Attachment"]);
			TypeAttachmentCode = myRow["AttachmentCode"].ToString();
			
			MyCB = null;
			ds = null;
			da = null;
			
			con.Close();
			con = null;
			return MyData;
			
		}
		
		/// <summary>
		/// Determines if an email has already been stored based on the short subject, received time, and the sender's email address.
		/// </summary>
		/// <param name="EmailSubj">The subject of the email.</param>
		/// <param name="EmailReceivedTime">The time the email was received.</param>
		/// <param name="SenderEmailAddress">The email addres of the sender.</param>
		/// <returns>Boolean</returns>
		/// <remarks>This funcition, if extended to include other parms in the lookup will be overloaded.</remarks>
		public bool isEmailStored(string EmailSubj, string EmailCreationTime, string EmailReceivedTime, string EmailSentOn, string SenderEmailAddress)
		{
			
			string S = "";
			bool B = false;
			int cnt = -1;
			
			EmailSubj = UTIL.RemoveSingleQuotes(EmailSubj);
			SenderEmailAddress = UTIL.RemoveSingleQuotes(SenderEmailAddress);
			
			S = " SELECT count(*)";
			S = S + " FROM [Email] ";
			S = S + " where [ShortSubj] = \'" + EmailSubj + "\' ";
			S = S + " and creationtime = \'" + EmailCreationTime + "\' ";
			S = S + " and SentOn = \'" + EmailSentOn + "\' ";
			S = S + " and [ReceivedTime] = \'" + EmailReceivedTime + "\' ";
			S = S + " and [SenderEmailAddress] = \'" + SenderEmailAddress + "\' ";
			
			CloseConn();
			CkConn();
			
			using (gConn)
			{
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = int.Parse(RSData.GetValue(0).ToString());
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
			}
			
			
			if (cnt > 0)
			{
				B = true;
			}
			else
			{
				B = false;
			}
			
			return B;
			
		}
		
		public bool ckBackupFolder(string UserID, string FolderName)
		{
			
			string S = "";
			bool B = false;
			int cnt = -1;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			
			
			S = " SELECT count(*)";
			S = S + " FROM [EmailFolder] ";
			S = S + " WHERE [UserID] = \'" + UserID + "\' ";
			S = S + " AND [FolderName] = \'" + FolderName + "\' ";
			S = S + " AND [ArchiveEmails] = \'Y\' ";
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			
			using (CONN)
			{
				
				SqlDataReader RSData = null;
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = int.Parse(RSData.GetValue(0).ToString());
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
			}
			
			
			if (cnt > 0)
			{
				B = true;
			}
			else
			{
				B = false;
			}
			
			if (CONN.State == ConnectionState.Open)
			{
				CONN.Close();
			}
			
			CONN = null;
			
			return B;
			
		}
		
		public void delSubDirs(string UID, string FQN)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			string S = "";
			bool B = false;
			int cnt = -1;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			
			S = "delete FROM [SubDir] where [UserID] = \'" + UID + "\' and [FQN] = \'" + FQN + "\' ";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				this.ExecuteSqlNewConn(S, false);
			}
			
			
		}
		
		public void delFileParms(string SGUID)
		{
			string S = "";
			bool B = false;
			int cnt = -1;
			
			CloseConn();
			CkConn();
			
			//Dim ConnStr  = System.Configuration.ConfigurationManager.AppSettings(ConnStrID)
			//Dim Conn As New SqlConnection(ConnStr)
			
			S = "DELETE FROM [SourceAttribute] WHERE SourceGuid = \'" + SGUID + "\'";
			
			using (gConn)
			{
				if (gConn.State == ConnectionState.Closed)
				{
					gConn.Open();
				}
				B = this.ExecuteSqlNewConn(S, false);
			}
			
			
		}
		
		/// <summary>
		/// Looks to see what filetypes have been defined to the system It
		/// looks in table AvailFileTypes.
		/// </summary>
		/// <returns>Bolean True/False</returns>
		/// <remarks></remarks>
		public bool ckFileExtExists()
		{
			string S = "";
			bool B = false;
			int cnt = -1;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			
			S = "Select count(*) FROM [AvailFileTypes]";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = int.Parse(RSData.GetValue(0).ToString());
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			
			if (cnt > 0)
			{
				B = true;
			}
			else
			{
				B = false;
			}
			
			return B;
			
		}
		
		public bool ckUserExists(string UserID)
		{
			string S = "";
			bool B = false;
			int cnt = -1;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			
			S = "Select count(*) FROM [Users] where UserID = \'" + UserID + "\' ";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					try
					{
						Conn.Open();
					}
					catch (Exception ex)
					{
						xTrace(12325, "clsDataBase:ckUserExists", ex.Message);
						LOG.WriteToArchiveLog((string) ("clsDatabase : ckUserExists : 2656 : " + ex.Message));
						
						return false;
					}
					
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = int.Parse(RSData.GetValue(0).ToString());
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			
			if (cnt > 0)
			{
				B = true;
			}
			else
			{
				B = false;
			}
			
			return B;
			
		}
		public bool ckUserLoginExists(string UserLogin)
		{
			string S = "";
			bool B = false;
			int cnt = -1;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			
			S = "Select count(*) FROM [Users] where UserLoginID = \'" + UserLogin + "\' ";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					try
					{
						Conn.Open();
					}
					catch (Exception ex)
					{
						xTrace(12325, "clsDataBase:ckUserExists", ex.Message);
						LOG.WriteToArchiveLog((string) ("clsDatabase : ckUserExists : 2656 : " + ex.Message));
						
						return false;
					}
					
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = int.Parse(RSData.GetValue(0).ToString());
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			
			if (cnt > 0)
			{
				B = true;
			}
			else
			{
				B = false;
			}
			
			return B;
			
		}
		public string getBinaryPassword(string UserLogin)
		{
			string S = "";
			bool B = false;
			string BPW = "";
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			
			S = "Select UserPassword FROM [Users] where UserLoginID = \'" + UserLogin + "\' ";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					try
					{
						Conn.Open();
					}
					catch (Exception ex)
					{
						xTrace(12325, "clsDataBase:ckUserExists", ex.Message);
						LOG.WriteToArchiveLog((string) ("clsDatabase : ckUserExists : 2656 : " + ex.Message));
						
						return false.ToString();
					}
					
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				RSData.Read();
				BPW = RSData.GetValue(0).ToString();
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			
			
			return BPW;
			
		}
		public bool ckFolderExists(string ContainerName, string UserID, string FolderName)
		{
			try
			{
				string S = "";
				bool B = false;
				int cnt = -1;
				
				string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection Conn = new SqlConnection(ConnStr);
				
				ContainerName = UTIL.RemoveSingleQuotes(ContainerName);
				
				S = "Select count(*) FROM [EmailArchParms] where ContainerName = \'" + ContainerName + "\' and [UserID] = \'" + UserID + "\' and [FolderName] = \'" + FolderName + "\' ";
				//S = "Select count(*) FROM [EmailFolder] where [UserID] = '" + UserID  + "' and [FolderName] = '" + FolderName  + "' "
				//SELECT COUNT(*)  FROM EmailArchParms where UserID = 'wmiller' and FolderName = 'Personal Folders|Dale''s Stuff'
				using (Conn)
				{
					if (Conn.State == ConnectionState.Closed)
					{
						Conn.Open();
					}
					
					SqlCommand command = new SqlCommand(S, Conn);
					SqlDataReader RSData = null;
					RSData = command.ExecuteReader();
					RSData.Read();
					cnt = int.Parse(RSData.GetValue(0).ToString());
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
					Conn.Close();
					Conn = null;
				}
				
				
				if (cnt > 0)
				{
					B = true;
				}
				else
				{
					B = false;
				}
				
				return B;
				
			}
			catch (Exception ex)
			{
				xTrace(12325, "clsDataBase:ckFolderExists", ex.Message);
				LOG.WriteToArchiveLog((string) ("clsDatabase : ckFolderExists : 2704 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : ckFolderExists : 2670 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : ckFolderExists : 2681 : " + ex.Message));
				return false;
			}
			
		}
		public bool ckUrlExists(string FQN)
		{
			try
			{
				string S = "";
				bool B = false;
				int cnt = -1;
				
				string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection Conn = new SqlConnection(ConnStr);
				
				S = "Select count(*) FROM DataSource where FQN = \'" + FQN + "\' ";
				
				using (Conn)
				{
					if (Conn.State == ConnectionState.Closed)
					{
						Conn.Open();
					}
					
					SqlCommand command = new SqlCommand(S, Conn);
					SqlDataReader RSData = null;
					RSData = command.ExecuteReader();
					RSData.Read();
					cnt = int.Parse(RSData.GetValue(0).ToString());
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
					Conn.Close();
					Conn = null;
				}
				
				
				if (cnt > 0)
				{
					B = true;
				}
				else
				{
					B = false;
				}
				
				return B;
				
			}
			catch (Exception ex)
			{
				xTrace(12325, "clsDataBase:ckFolderExists", ex.Message);
				LOG.WriteToArchiveLog((string) ("clsDatabase : ckFolderExists : 2681 : " + ex.Message));
				return false;
			}
			
		}
		public bool ckMasterExists(string FileName, string TblName, string ColName, string SourceGuid = null)
		{
			//SELECT count(*) FROM  [DataSource] where [SourceName] = 'Current State of ECM.docx' and [isMaster] = 'Y'
			
			//SELECT SourceName FROM  [DataSource] where SourceGuid = 'XX'
			
			if (SourceGuid == null)
			{
			}
			else
			{
				FileName = this.getFilenameByGuid(SourceGuid);
			}
			
			try
			{
				string S = "";
				bool B = false;
				int cnt = -1;
				
				string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection Conn = new SqlConnection(ConnStr);
				
				S = "Select count(*) FROM  [DataSource] where [SourceName] = \'" + FileName + "\' and [isMaster] = \'Y\'";
				
				using (Conn)
				{
					if (Conn.State == ConnectionState.Closed)
					{
						Conn.Open();
					}
					
					SqlCommand command = new SqlCommand(S, Conn);
					SqlDataReader RSData = null;
					RSData = command.ExecuteReader();
					RSData.Read();
					cnt = int.Parse(RSData.GetValue(0).ToString());
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
					Conn.Close();
					Conn = null;
				}
				
				
				if (cnt > 0)
				{
					B = true;
				}
				else
				{
					B = false;
				}
				
				return B;
				
			}
			catch (Exception ex)
			{
				xTrace(12326, "clsDataBase:ckMasterExists", ex.Message);
				LOG.WriteToArchiveLog((string) ("clsDatabase : ckMasterExists : 2738 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : ckMasterExists : 2704 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : ckMasterExists : 2716 : " + ex.Message));
				return false;
			}
			
		}
		
		public bool ckParmsFolderExists(string UserID, string FolderName)
		{
			try
			{
				string S = "";
				bool B = false;
				int cnt = -1;
				
				string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection Conn = new SqlConnection(ConnStr);
				
				S = "Select count(*) FROM [EmailArchParms] where [UserID] = \'" + UserID + "\' and [FolderName] = \'" + FolderName + "\' ";
				
				using (Conn)
				{
					if (Conn.State == ConnectionState.Closed)
					{
						Conn.Open();
					}
					
					SqlCommand command = new SqlCommand(S, Conn);
					SqlDataReader RSData = null;
					RSData = command.ExecuteReader();
					RSData.Read();
					cnt = int.Parse(RSData.GetValue(0).ToString());
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
					Conn.Close();
					Conn = null;
				}
				
				
				if (cnt > 0)
				{
					B = true;
				}
				else
				{
					B = false;
				}
				
				return B;
				
			}
			catch (Exception ex)
			{
				xTrace(12326, "clsDataBase:ckParmsFolderExists", ex.Message);
				LOG.WriteToArchiveLog((string) ("clsDatabase : ckParmsFolderExists : 2768 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : ckParmsFolderExists : 2734 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : ckParmsFolderExists : 2747 : " + ex.Message));
				return false;
			}
			
		}
		
		public Array SelectOneEmailParm(string WhereClause)
		{
			
			string[] A = new string[12];
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			
			bool b = false;
			string s = "";
			
			s = s + " SELECT ";
			s = s + "UserID,";
			s = s + "ArchiveEmails,";
			s = s + "RemoveAfterArchive,";
			s = s + "SetAsDefaultFolder,";
			s = s + "ArchiveAfterXDays,";
			s = s + "RemoveAfterXDays,";
			s = s + "RemoveXDays,";
			s = s + "ArchiveXDays,";
			s = s + "FolderName,";
			s = s + "DB_ID ,";
			s = s + "ArchiveOnlyIfRead, isSysDefault ";
			s = s + " FROM EmailArchParms ";
			s = s + WhereClause;
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(s, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					A[0] = RSData.GetValue(0).ToString();
					A[1] = RSData.GetValue(1).ToString();
					A[2] = RSData.GetValue(2).ToString();
					A[3] = RSData.GetValue(3).ToString();
					A[4] = RSData.GetValue(4).ToString();
					A[5] = RSData.GetValue(5).ToString();
					A[6] = RSData.GetValue(6).ToString();
					A[7] = RSData.GetValue(7).ToString();
					A[8] = RSData.GetValue(8).ToString();
					A[9] = RSData.GetValue(9).ToString();
					A[10] = RSData.GetValue(10).ToString();
					A[11] = RSData.GetValue(11).ToString();
					//UserID = a(0)
					//ArchiveEmails = a(1)
					//RemoveAfterArchive = a(2)
					//SetAsDefaultFolder = a(3)
					//ArchiveAfterXDays = a(4)
					//RemoveAfterXDays = a(5)
					//RemoveXDays = a(6)
					//ArchiveXDays = a(7)
					//FolderName = a(8)
					//DB_ID = a(9)
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			return A;
		}
		
		public void LoadAvailFileTypes(ComboBox CB)
		{
			CB.Items.Clear();
			string[] A = new string[10];
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			string s = "";
			
			s = " SELECT distinct [ExtCode] FROM [AvailFileTypes] order by [ExtCode]";
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				SqlCommand command = new SqlCommand(s, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						string SS = RSData.GetValue(0).ToString();
						CB.Items.Add(SS);
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
		}
		
		public void LoadAvailUsers(ComboBox CB)
		{
			CB.Items.Clear();
			string[] A = new string[10];
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			string s = "";
			
			s = " SELECT UserLoginID FROM Users ";
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				SqlCommand command = new SqlCommand(s, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						string SS = RSData.GetValue(0).ToString();
						CB.Items.Add(SS);
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
		}
		
		public void LoadRetentionCodes(ComboBox CB)
		{
			CB.Items.Clear();
			string[] A = new string[10];
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			string s = "";
			
			int iCnt = 0;
			
			s = " select RetentionCode from Retention order by RetentionCode";
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(s, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						iCnt++;
						string SS = RSData.GetValue(0).ToString();
						CB.Items.Add(SS);
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
				if (iCnt == 0)
				{
					if (modGlobals.gRunUnattended == false)
					{
						MessageBox.Show("Failed to load the retention codes, this will cause issues.");
					}
					LOG.WriteToArchiveLog("ERROR - Failed to load the retention codes, this will cause issues.");
				}
			}
			
		}
		
		public void LoadAvailFileTypes(ListBox LB)
		{
			LB.Items.Clear();
			string[] A = new string[10];
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			string s = "";
			
			s = " SELECT distinct [ExtCode] FROM [AvailFileTypes] order by ExtCode";
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(s, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						string SS = RSData.GetValue(0).ToString();
						if (SS.Equals("*"))
						{
						}
						else if (SS.Equals(".*"))
						{
						}
						else
						{
							LB.Items.Add(SS);
						}
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
		}
		
		public void LoadFileTypeProfiles(ComboBox CB)
		{
			
			CB.Items.Clear();
			string[] A = new string[10];
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			string s = "";
			
			s = " SELECT [ProfileName] FROM [LoadProfile] order by [ProfileName] ";
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(s, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						string SS = RSData.GetValue(0).ToString();
						CB.Items.Add(SS);
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
		}
		
		public void LoadIncludedFileTypes(ListBox LB, string UserID, string DirName)
		{
			LB.Items.Clear();
			string[] A = new string[10];
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			string s = "";
			
			DirName = UTIL.RemoveSingleQuotes(DirName);
			
			s = " SELECT [UserID]";
			s = s + " ,[ExtCode]";
			s = s + " ,[FQN]";
			s = s + " FROM IncludedFiles ";
			s = s + " where Userid = \'" + UserID + "\' ";
			s = s + " and FQN = \'" + DirName + "\'";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(s, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						string SS = RSData.GetValue(1).ToString();
						LB.Items.Add(SS);
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
		}
		
		public void LoadExcludedFileTypes(ListBox LB, string UserID, string DirName)
		{
			LB.Items.Clear();
			string[] A = new string[10];
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			string s = "";
			
			DirName = UTIL.RemoveSingleQuotes(DirName);
			
			s = " SELECT [UserID]";
			s = s + " ,[ExtCode]";
			s = s + " ,[FQN]";
			s = s + " FROM ExcludedFiles ";
			s = s + " where Userid = \'" + UserID + "\' ";
			s = s + " and FQN = \'" + DirName + "\'";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(s, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						string SS = RSData.GetValue(1).ToString();
						LB.Items.Add(SS);
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
		}
		
		public void GetActiveEmailFolders(string TopLevelOutlookFolderName, ListBox LB, string UserID, SortedList<string, string> CF, ArrayList ArchivedEmailFolders)
		{
			
			ArchivedEmailFolders.Clear();
			
			TopLevelOutlookFolderName = UTIL.RemoveSingleQuotes(TopLevelOutlookFolderName);
			
			string S = " ";
			S = " Select distinct FolderName ";
			S = S + " FROM EmailFolder ";
			S = S + " where (UserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
			S = S + " and SelectedForArchive = \'Y\' ";
			S = S + " and ContainerName like \'" + TopLevelOutlookFolderName + "\') ";
			S = S + " or isSysDefault = 1 ";
			S = S + " order by FolderName ";
			
			LB.Items.Clear();
			string[] A = new string[10];
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						string SS = RSData.GetValue(0).ToString();
						string[] A2 = SS.Split('|'.ToString().ToCharArray());
						SS = A2[(A2.Length - 1)];
						LB.Items.Add(SS);
						ArchivedEmailFolders.Add(SS);
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
				
				//Dim S  = "Update EmailFolder set SelectedForArchive = NULL where UserID = '" + gCurrUserGuidID + "'"
				//Dim BB As Boolean = ExecuteSqlNoTx(S)
				
				
				bool BB = true;
				
				bool B1 = false;
				if (BB)
				{
					for (int II = 0; II <= LB.Items.Count - 1; II++)
					{
						ActivateArchiveFolder(TopLevelOutlookFolderName, LB.Items[II].ToString(), UserID);
					}
				}
				
			}
			
			
		}
		
		public void ActivateArchiveFolder(string ParentFolder, string FolderName, string UserID)
		{
			//Update EmailFolder set
			//SelectedForArchive = 'Y'
			//where UserID = 'wmiller'
			//and FolderName = '_Passage'
			//and ParentFolderName = 'Personal Folders'
			string FolderFQN = ParentFolder + "|" + FolderName;
			FolderFQN = UTIL.RemoveSingleQuotes(FolderFQN);
			string S = "Update EmailFolder set SelectedForArchive = \'Y\' where UserID = \'" + UserID + "\' and FolderName = \'" + FolderFQN + "\' and ContainerName = \'" + ParentFolder + "\' ";
			bool B1 = ExecuteSqlNoTx(S);
			if (! B1)
			{
				MessageBox.Show((string) ("Failed to Activate folder " + FolderName));
			}
		}
		
		public void deActivateArchiveFolder(string FolderName, string UserID)
		{
			string S = "Update EmailFolder set SelectedForArchive = \'N\' where UserID = \'" + UserID + "\' and FolderName = \'" + FolderName + "\'";
			bool B1 = ExecuteSqlNoTx(S);
			if (! B1)
			{
				MessageBox.Show((string) ("Failed to Activate folder " + FolderName));
			}
		}
		
		public int setActiveEmailFolders(string TopLevelOutlookFolder, string UserID)
		{
			
			int SubFoldersToProcess = 0;
			
			SortedList SLB = new SortedList();
			string S = " Select distinct FolderName ";
			S = S + " FROM EmailFolder ";
			S = S + " where UserID = \'" + UserID + "\' and FolderName like \'" + TopLevelOutlookFolder + "|%\'  ";
			S = S + " and SelectedForArchive = \'Y\' ";
			S = S + " or isSysDefault = 1 ";
			S = S + " order by FolderName ";
			
			//        select distinct FolderName from EmailFolder
			//where FolderName like 'Personal Folders|%' and UserID = 'wmiller'
			
			//Dim A (9)
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						SubFoldersToProcess++;
						string SS = RSData.GetValue(0).ToString();
						int bKeyExists = -1;
						bKeyExists = SLB.IndexOfKey(SS);
						if (bKeyExists < 0)
						{
							//If CF.ContainsKey(SS) Then
							//    SLB.Add(SS, SS)
							//End If
							SLB.Add(SS, SS);
						}
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
				
				//'** in - Determined we may not need to do the following on 9/27/2009
				//Dim WeNeedThis As Boolean = True
				//If WeNeedThis Then
				//    Dim S  = "Update EmailFolder set SelectedForArchive = 'N' where UserID = '" + UserID  + "'"
				//    Dim BB As Boolean = ExecuteSqlNoTx(S)
				//    Dim B1 As Boolean = False
				//    If BB Then
				//        For II As Integer = 0 To SLB.Count - 1
				//            If dDebug Then Debug.Print(SLB.GetKey(II).ToString)
				//            S  = "Update EmailFolder set SelectedForArchive = 'Y' where UserID = '" + UserID  + "' and FolderName = '" + SLB.GetKey(II).ToString + "'"
				//            B1 = ExecuteSqlNoTx(S)
				//            If Not B1 Then
				//                messagebox.show("Failed to set the Selected For Archive flag for folder " + SLB.GetKey(II).ToString)
				//            End If
				//        Next
				//    End If
				//End If
			}
			
			return SubFoldersToProcess;
		}
		
		public void GetDirectoryData(string UserID, string FQN, ref string DBID, ref string IncludeSubDirs, ref string VersionFiles, ref string FolderDisabled, ref string ckMetaData, ref string ckPublic, ref string OcrDirectory, ref string isSysDefault, ref bool ArchiveSkipBit, bool ListenForChanges, ref bool ListenDirectory, ref bool ListenSubDirectory, ref string DirGuid, ref string OcrPdf, ref string DeleteOnArchive)
		{
			
			FQN = UTIL.RemoveSingleQuotes(FQN);
			string S = "Select IncludeSubDirs, DB_ID, VersionFiles, ckDisableDir, ckMetaData, ckPublic, OcrDirectory,isSysDefault, ArchiveSkipBit, DirGuid, ListenDirectory,ListenSubDirectory, OcrPdf, DeleteOnArchive FROM [Directory] where [UserID] = \'" + UserID + "\' and FQN = \'" + FQN + "\'";
			//Dim A (9)
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						IncludeSubDirs = RSData.GetValue(0).ToString();
						DBID = RSData.GetValue(1).ToString();
						VersionFiles = RSData.GetValue(2).ToString();
						FolderDisabled = RSData.GetValue(3).ToString();
						ckMetaData = RSData.GetValue(4).ToString();
						ckPublic = RSData.GetValue(5).ToString();
						OcrDirectory = RSData.GetValue(6).ToString();
						isSysDefault = RSData.GetValue(7).ToString();
						ArchiveSkipBit = RSData.GetBoolean(8);
						DirGuid = RSData.GetValue(9).ToString();
						string SX = RSData.GetValue(10).ToString();
						SX = RSData.GetValue(11).ToString();
						OcrPdf = RSData.GetValue(12).ToString();
						DeleteOnArchive = RSData.GetValue(13).ToString();
						try
						{
							ListenDirectory = RSData.GetBoolean(10);
						}
						catch (Exception)
						{
							ListenDirectory = false;
						}
						try
						{
							ListenSubDirectory = RSData.GetBoolean(11);
						}
						catch (Exception)
						{
							ListenSubDirectory = false;
						}
						
						//If sArchiveSkipBit Then
						//    ArchiveSkipBit = True
						//Else
						//    ArchiveSkipBit = False
						//End If
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			
		}
		
		public bool isSubDirProcessed(string UserID, string DirFQN)
		{
			
			DirFQN = UTIL.RemoveSingleQuotes(DirFQN);
			string S = "Select IncludeSubDirs FROM [Directory] where [UserID] = \'" + UserID + "\' and FQN = \'" + DirFQN + "\'";
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool B = false;
			string IncludeSubDirs = "";
			try
			{
				using (Conn)
				{
					if (Conn.State == ConnectionState.Closed)
					{
						Conn.Open();
					}
					
					SqlCommand command = new SqlCommand(S, Conn);
					SqlDataReader RSData = null;
					RSData = command.ExecuteReader();
					if (RSData.HasRows)
					{
						while (RSData.Read())
						{
							IncludeSubDirs = RSData.GetValue(0).ToString();
							if (IncludeSubDirs.ToUpper().Equals("Y"))
							{
								B = true;
							}
							else
							{
								B = false;
							}
						}
					}
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
					Conn.Close();
					Conn = null;
				}
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR isSubDirProcessed 100: " + ex.Message + "\r\n" + S));
				B = false;
			}
			
			return B;
			
		}
		
		public void GetDirectories(ListBox LB, string UserID, bool ShowDisabled)
		{
			//*WDM 7/20/2009 - Modified query to bring back DISTINCT directories
			string S = "";
			S = "update Directory set ckDisableDir = \'N\'  where [UserID] = \'" + modGlobals.gCurrUserGuidID + "\' and ckDisableDir is null ";
			ExecuteSqlNewConn(S);
			
			S = "";
			if (ShowDisabled == true)
			{
				S = "Select    distinct [FQN], ckDisableDir " + "\r\n";
				S = S + "             FROM [Directory] " + "\r\n";
				S = S + " where [UserID] = \'" + modGlobals.gCurrUserGuidID + "\' " + "\r\n";
				S = S + " and (QuickRefEntry = 0  or QuickRefEntry is null) and ckDisableDir = \'Y\'" + "\r\n";
				S = S + " or isSysDefault = 1" + "\r\n";
				S = S + " group by FQN, ckDisableDir " + "\r\n";
				S = S + " order by fqn " + "\r\n";
			}
			else
			{
				S = "Select    distinct [FQN], ckDisableDir " + "\r\n";
				S = S + "             FROM [Directory] " + "\r\n";
				S = S + " where [UserID] = \'" + modGlobals.gCurrUserGuidID + "\' " + "\r\n";
				S = S + " and (QuickRefEntry = 0  or QuickRefEntry is null) and ckDisableDir <> \'Y\'  " + "\r\n";
				//** S = S + " or isSysDefault = 1" + vbCrLf
				S = S + " group by FQN, ckDisableDir " + "\r\n";
				S = S + " order by fqn " + "\r\n";
			}
			
			//Clipboard.Clear()
			//Clipboard.SetText(S)
			
			LB.Items.Clear();
			string[] A = new string[10];
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				int II = 0;
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						II++;
						string SS = RSData.GetValue(0).ToString();
						//frmReconMain.SB2.Text = "Processing Dir/File # " + II.ToString
						//frmReconMain.Refresh()
						Application.DoEvents();
						if (SS.IndexOf("%userid%") + 1 > 0)
						{
							LB.Items.Add(SS);
						}
						else if (System.IO.Directory.Exists(SS))
						{
							LB.Items.Add(SS);
						}
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			
		}
		
		public void GetIncludedFiles(ListBox LB, string UserID, string FQN)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			string S = "Select [ExtCode] FROM [IncludedFiles] where [UserID] = \'" + UserID + "\'  and [FQN] = \'" + FQN + "\'";
			
			LB.Items.Clear();
			string[] A = new string[10];
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			int II = 0;
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						II++;
						frmMain.Default.SB2.Text = (string) ("Processing Extension# " + II.ToString());
						frmMain.Default.Refresh();
						Application.DoEvents();
						string SS = RSData.GetValue(0).ToString();
						LB.Items.Add(SS);
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			
		}
		
		public void GetActiveDatabases(ComboBox CB)
		{
			
			string S = " SELECT [DB_ID] FROM [Databases] ";
			
			CB.Items.Clear();
			string[] A = new string[10];
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						string SS = RSData.GetValue(0).ToString();
						CB.Items.Add(SS);
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			
		}
		
		public void GetProcessAsList(ComboBox CB)
		{
			
			string S = "Select [ExtCode] ,[ProcessExtCode] FROM [ProcessFileAs] order by [ExtCode],[ProcessExtCode]";
			
			CB.Items.Clear();
			string[] A = new string[10];
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						string P = RSData.GetValue(0).ToString();
						string C = RSData.GetValue(1).ToString();
						CB.Items.Add(P + " --> " + C);
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			
		}
		
		public bool ckReconParmExists(string UserID, string ReconParm)
		{
			string S = "";
			bool B = false;
			int cnt = -1;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			
			S = "Select count(*) FROM [RunParms] ";
			S = S + " where Parm = \'" + ReconParm + "\' ";
			S = S + " and UserID = \'" + UserID + "\'";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = int.Parse(RSData.GetValue(0).ToString());
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			
			if (cnt > 0)
			{
				B = true;
			}
			else
			{
				B = false;
			}
			
			return B;
		}
		
		public bool ckProcessAsExists(string Pext)
		{
			string S = "";
			bool B = false;
			int cnt = -1;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			
			S = "Select count(*) FROM [ProcessFileAs] where [ExtCode] = \'" + Pext + "\' ";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = int.Parse(RSData.GetValue(0).ToString());
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			
			if (cnt > 0)
			{
				B = true;
			}
			else
			{
				B = false;
			}
			
			return B;
		}
		
		public bool ckExtExists(string tExt)
		{
			string S = "";
			bool B = false;
			int cnt = -1;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			
			S = "Select count(*) from AvailFileTypes where ExtCode = \'" + tExt + "\' ";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = int.Parse(RSData.GetValue(0).ToString());
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			
			if (cnt > 0)
			{
				B = true;
			}
			else
			{
				B = false;
			}
			
			return B;
		}
		
		public bool ckDirectoryExists(string UserID, string FQN)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			string S = "";
			bool B = false;
			int cnt = -1;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			
			FQN = UTIL.RemoveSingleQuotes(FQN);
			
			S = "Select count(*) FROM [Directory] ";
			S = S + " where FQN = \'" + FQN + "\' ";
			S = S + " and UserID = \'" + UserID + "\'";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = int.Parse(RSData.GetValue(0).ToString());
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			
			if (cnt > 0)
			{
				B = true;
			}
			else
			{
				B = false;
			}
			
			return B;
		}
		
		public string getRconParm(string UserID, string ParmID)
		{
			
			string S = " SELECT [ParmValue] FROM [RunParms] where Parm = \'" + ParmID + "\' and UserID = \'" + UserID + "\'";
			string SS = "";
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						SS = RSData.GetValue(0).ToString();
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			return SS;
		}
		
		public bool ExecuteSqlNewConn(string sql, string ConnStr, bool ValidateOwnerShip)
		{
			if (ValidateOwnerShip == true)
			{
				if (TgtGuid.Length == 0)
				{
					if (modGlobals.gRunUnattended == false)
					{
						MessageBox.Show("ERROR 666.02 - TgtGuid left blank and is required, contact ADMIN as this is an error.");
					}
					LOG.WriteToArchiveLog("ERROR 666.02 - TgtGuid left blank and is required, contact ADMIN as this is an error.");
					return false;
				}
				bool isOwner = ckContentOwnership(TgtGuid, modGlobals.gCurrUserGuidID);
				if (isOwner == false)
				{
					if (modGlobals.gRunUnattended == false)
					{
						MessageBox.Show("ERROR 666.02b - This will be removed - tried to update content you do not own, ABORTED!");
					}
					LOG.WriteToTraceLog("ExecuteSql2: User \'" + modGlobals.gCurrUserGuidID + "\' tried to change \'" + TgtGuid + "\' w/o ownership.");
					return false;
				}
			}
			string TxName = "TX001";
			bool rc = false;
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				SqlCommand dbCmd = Conn.CreateCommand();
				dbCmd.Connection = Conn;
				try
				{
					dbCmd.CommandText = sql;
					dbCmd.ExecuteNonQuery();
					bool debug = true;
					rc = true;
				}
				catch (Exception ex)
				{
					rc = false;
					Console.WriteLine("Exception Type: {0}", ex.GetType());
					Console.WriteLine("  Message: {0}", ex.Message);
					Console.WriteLine(sql);
					xTrace(997110, "ExecuteSql: ", "-----------------------");
					xTrace(997111, "ExecuteSql: ", ex.Message.ToString());
					xTrace(997112, "ExecuteSql: ", ex.StackTrace.ToString());
					xTrace(997113, "ExecuteSql: ", sql);
					LOG.WriteToArchiveLog((string) ("clsDatabase : ExecuteSql : 3382 : " + ex.Message));
				}
			}
			
			if (Conn.State == ConnectionState.Closed)
			{
				Conn.Close();
			}
			Conn = null;
			return rc;
		}
		
		public string GetEmailDBConnStr(string DBID)
		{
			
			string S = "Select DB_CONN_STR from databases where DB_ID = \'" + DBID + "\' ";
			string[] A = new string[10];
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			string DbConnStr = "";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						DbConnStr = RSData.GetValue(0).ToString();
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			
			return DbConnStr;
			
		}
		
		public void GetEmailFolders(string UID, ref string[] aFolders)
		{
			
			string S = "Select ";
			S = S + "  [FolderName]";
			S = S + " FROM Email ";
			S = S + " where UserID = \'" + UID + "\' ";
			
			aFolders = new string[1];
			int I = 0;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			string DbConnStr = "";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						DbConnStr = RSData.GetValue(0).ToString();
						if (I == 0)
						{
							aFolders[0] = DbConnStr;
						}
						else
						{
							Array.Resize(ref aFolders, I + 1);
							aFolders[I] = DbConnStr;
						}
						I++;
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			
		}
		
		public void GetContentArchiveFileFolders(string UID, ref string[] aFolders)
		{
			IXV1 = 0;
			DMA.IXV1 = 0;
			string S = " ";
			S = S + " SELECT Directory.FQN, ";
			S = S + " Directory.IncludeSubDirs, ";
			S = S + " Directory.DB_ID,";
			S = S + " Directory.VersionFiles, ";
			S = S + " Directory.ckDisableDir, ";
			S = S + " Directory.OcrDirectory, ";
			S = S + " Directory.RetentionCode, ";
			S = S + " SubDir.SUBFQN ";
			S = S + " FROM  Directory FULL OUTER JOIN";
			S = S + " SubDir ON Directory.FQN = SubDir.FQN";
			S = S + " WHERE (Directory.UserID = \'" + UID + "\') OR";
			S = S + " (Directory.isSysDefault = 1) ";
			S = S + " order by Directory.fqn";
			
			aFolders = new string[1];
			int I = 0;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			string FQN = "";
			string IncludeSubDirs = "";
			string DB_ID = "";
			string VersionFiles = "";
			string DisableFolder = "";
			string OcrDirectory = "";
			string RetentionCode = "";
			bool FirstEntryComplete = false;
			string SUBFQN = "";
			
			List<string> ListOfFiles = new List<string>();
			
			string DbConnStr = "";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				I = 0;
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						
						FQN = RSData.GetValue(0).ToString();
						FQN = UTIL.RemoveSingleQuotes(FQN);
						
						Directory D;
						if (! D.Exists(FQN))
						{
							goto SkipThisOne;
						}
						
						IncludeSubDirs = RSData.GetValue(1).ToString();
						DB_ID = RSData.GetValue(2).ToString();
						VersionFiles = RSData.GetValue(3).ToString();
						DisableFolder = RSData.GetValue(4).ToString();
						OcrDirectory = RSData.GetValue(5).ToString();
						RetentionCode = RSData.GetValue(6).ToString();
						SUBFQN = RSData.GetValue(7).ToString();
						
						if (DisableFolder.ToUpper.Equals("Y"))
						{
							goto SkipThisOne;
						}
						
						if (SUBFQN.Length == 0)
						{
							//** do nothing
						}
						else if (SUBFQN.Trim().Length > 0)
						{
							FQN = SUBFQN;
						}
						
						ListOfFiles.Clear();
						if (IncludeSubDirs.Equals("Y"))
						{
							//ListOfFiles = DMA.GetFilesRecursive(FQN)
							//DMA.GetAllDirs(FQN, ListOfFiles)
							if (bUseCommandProcessForInventory == 1)
							{
								bool BB = DMA.GetSubDirs(FQN, ListOfFiles);
								if (BB == false)
								{
									ListOfFiles = DMA.GetDirsRecursive(FQN);
								}
							}
							else
							{
								ListOfFiles = DMA.GetDirsRecursive(FQN);
							}
						}
						
						if (! ListOfFiles.Contains(FQN))
						{
							ListOfFiles.Add(FQN);
						}
						
						for (int k = 0; k <= ListOfFiles.Count - 1; k++)
						{
							string tFqn = (string) (ListOfFiles.Item(k));
							if (FirstEntryComplete == false)
							{
								FirstEntryComplete = true;
								aFolders[0] = FQN + "|" + IncludeSubDirs + "|" + DB_ID + "|" + VersionFiles + "|" + DisableFolder + "|" + OcrDirectory + "|" + RetentionCode;
							}
							else
							{
								int X = System.Convert.ToInt32((aFolders.Length - 1) + 1);
								Array.Resize(ref aFolders, X + 1);
								aFolders[X] = FQN + "|" + IncludeSubDirs + "|" + DB_ID + "|" + VersionFiles + "|" + DisableFolder + "|" + OcrDirectory + "|" + RetentionCode;
							}
						}
SkipThisOne:
						I++;
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			
		}
		
		public void GetContentArchiveFileFolders(string UID, List<string> tgtFolders, string TgtFolder)
		{
			//, ByRef tgtFolders As List(Of String)
			if (UID == null)
			{
				UID = modGlobals.gCurrUserGuidID;
			}
			if (UID.Length == 0)
			{
				UID = modGlobals.gCurrUserGuidID;
			}
			TgtFolder = UTIL.RemoveSingleQuotes(TgtFolder);
			
			
			string S = " ";
			IXV1 = 0;
			DMA.IXV1 = 0;
			string AutoIncludeSubDirs = System.Configuration.ConfigurationManager.AppSettings["AutoIncludeSubDirs"];
			
			//S = "delete FROM [DirectoryTemp] where [gCurrUserGuidID] = '" + gCurrUserGuidID + "' "
			//Me.ExecuteSqlNewConn(S, False)
			
			S = S + " SELECT Directory.FQN, ";
			S = S + " Directory.IncludeSubDirs, ";
			S = S + " Directory.DB_ID,";
			S = S + " Directory.VersionFiles, ";
			S = S + " Directory.ckDisableDir, ";
			S = S + " Directory.OcrDirectory, ";
			S = S + " Directory.RetentionCode, ";
			S = S + " Directory.ArchiveSkipBit, ";
			S = S + " Directory.OcrPdf, ";
			S = S + " Directory.DeleteOnArchive, ";
			S = S + " Directory.ckPublic ";
			S = S + " FROM  Directory ";
			if (TgtFolder.Trim.Length > 0)
			{
				S = S + " WHERE Directory.UserID = \'" + UID + "\' and (AdminDisabled = 0 or AdminDisabled is null) and FQN = \'" + TgtFolder + "\' or isSysDefault = 1 ";
			}
			else
			{
				S = S + " WHERE Directory.UserID = \'" + UID + "\' and (AdminDisabled = 0 or AdminDisabled is null)  or isSysDefault = 1 ";
			}
			
			S = S + " order by Directory.fqn";
			
			tgtFolders.Clear();
			
			int I = 0;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			string FQN = "";
			string IncludeSubDirs = "";
			string DB_ID = "";
			string VersionFiles = "";
			string DisableFolder = "";
			string OcrDirectory = "";
			string OcrPdf = "";
			string RetentionCode = "";
			bool FirstEntryComplete = false;
			string SUBFQN = "";
			string ArchiveSkipBit = "";
			string DeleteOnArchive = "";
			string ckPublic = "";
			
			List<string> ListOfFiles = new List<string>();
			
			string DbConnStr = "";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				I = 0;
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						if (modGlobals.gTerminateImmediately)
						{
							return;
						}
						FQN = RSData.GetValue(0).ToString();
						FQN = UTIL.RemoveSingleQuotes(FQN);
						
						string ParentDir = FQN;
						
						//If InStr(FQN, "xuser", CompareMethod.Text) > 0 Then
						//    Console.WriteLine("Here 999")
						//End If
						
						if (FQN.IndexOf("%userid%") + 1 > 0 && ! modGlobals.gCurrLoginID.ToUpper().Equals("SERVICEMANAGER"))
						{
							if (modGlobals.gClipBoardActive == true)
							{
								Console.WriteLine("Wildcard directory: " + FQN);
							}
							string S1 = "";
							string S2 = "";
							int iLoc = FQN.IndexOf("%userid%") + 1;
							S1 = FQN.Substring(0, iLoc - 1);
							S2 = FQN.Substring(iLoc + "%userid%".Length - 1);
							string UserName = System.Environment.UserName;
							FQN = S1 + UserName + S2;
							ParentDir = FQN;
						}
						else
						{
							Directory D;
							FQN = UTIL.ReplaceSingleQuotes(FQN);
							if (! D.Exists(FQN))
							{
								goto SkipThisOne;
							}
						}
						
						IncludeSubDirs = RSData.GetValue(1).ToString();
						DB_ID = RSData.GetValue(2).ToString();
						VersionFiles = RSData.GetValue(3).ToString();
						DisableFolder = RSData.GetValue(4).ToString();
						OcrDirectory = RSData.GetValue(5).ToString();
						RetentionCode = RSData.GetValue(6).ToString();
						ArchiveSkipBit = RSData.GetValue(7).ToString();
						OcrPdf = RSData.GetValue(8).ToString();
						DeleteOnArchive = RSData.GetValue(9).ToString();
						ckPublic = RSData.GetValue(10).ToString();
						
						if (DisableFolder.ToUpper.Equals("Y"))
						{
							goto SkipThisOne;
						}
						
						if (FQN.Trim().Length > 260)
						{
							FQN = modGlobals.getShortDirName(FQN);
						}
						
						AddArchiveDir(FQN);
						
						if (SUBFQN.Length == 0)
						{
							//** do nothing
						}
						else if (SUBFQN.Trim().Length > 0)
						{
							FQN = SUBFQN;
						}
						
						ListOfFiles.Clear();
						
						if (! ListOfFiles.Contains(FQN))
						{
							ListOfFiles.Add(FQN);
						}
						
						for (int k = 0; k <= ListOfFiles.Count - 1; k++)
						{
							string tFqn = (string) (ListOfFiles.Item(k));
							string SS = tFqn + "|" + IncludeSubDirs + "|" + DB_ID + "|" + VersionFiles + "|" + DisableFolder + "|" + OcrDirectory + "|" + RetentionCode + "|" + ParentDir + "|" + ArchiveSkipBit + "|" + OcrPdf + "|" + DeleteOnArchive + "|" + ckPublic;
							if (tgtFolders.Contains(SS))
							{
								//Console.WriteLine("Duplicate: " + FQN)
							}
							else
							{
								tgtFolders.Add(SS);
							}
						}
SkipThisOne:
						I++;
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			
		}
		
		public bool setContentArchiveFileFolder(string UID, List<string> tgtFolders, string TgtFolder)
		{
			
			TgtFolder = UTIL.RemoveSingleQuotes(TgtFolder);
			
			bool isGood = false;
			
			string S = " ";
			IXV1 = 0;
			DMA.IXV1 = 0;
			string AutoIncludeSubDirs = System.Configuration.ConfigurationManager.AppSettings["AutoIncludeSubDirs"];
			
			S = S + " SELECT Directory.FQN, ";
			S = S + " Directory.IncludeSubDirs, ";
			S = S + " Directory.DB_ID,";
			S = S + " Directory.VersionFiles, ";
			S = S + " Directory.ckDisableDir, ";
			S = S + " Directory.OcrDirectory, ";
			S = S + " Directory.RetentionCode, ";
			S = S + " Directory.ArchiveSkipBit ";
			S = S + " FROM  Directory ";
			if (TgtFolder.Trim.Length > 0)
			{
				S = S + " WHERE Directory.UserID = \'" + UID + "\' and (AdminDisabled = 0 or AdminDisabled is null) and FQN = \'" + TgtFolder + "\' ";
			}
			else
			{
				S = S + " WHERE Directory.UserID = \'" + UID + "\' and (AdminDisabled = 0 or AdminDisabled is null) ";
			}
			
			S = S + " order by Directory.fqn";
			
			tgtFolders.Clear();
			
			int I = 0;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			string FQN = "";
			string IncludeSubDirs = "";
			string DB_ID = "";
			string VersionFiles = "";
			string DisableFolder = "";
			string OcrDirectory = "";
			string RetentionCode = "";
			bool FirstEntryComplete = false;
			string SUBFQN = "";
			string ArchiveSkipBit = "";
			
			List<string> ListOfFiles = new List<string>();
			
			string DbConnStr = "";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				I = 0;
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						isGood = true;
						if (modGlobals.gTerminateImmediately)
						{
							return false;
						}
						FQN = RSData.GetValue(0).ToString();
						FQN = UTIL.RemoveSingleQuotes(FQN);
						
						string ParentDir = FQN;
						
						//If InStr(FQN, "xuser", CompareMethod.Text) > 0 Then
						//    Console.WriteLine("Here 999")
						//End If
						
						if (FQN.IndexOf("%userid%") + 1 > 0 && ! modGlobals.gCurrLoginID.ToUpper().Equals("SERVICEMANAGER"))
						{
							if (modGlobals.gClipBoardActive == true)
							{
								Console.WriteLine("Wildcard directory: " + FQN);
							}
							string S1 = "";
							string S2 = "";
							int iLoc = FQN.IndexOf("%userid%") + 1;
							S1 = FQN.Substring(0, iLoc - 1);
							S2 = FQN.Substring(iLoc + "%userid%".Length - 1);
							string UserName = System.Environment.UserName;
							FQN = S1 + UserName + S2;
							ParentDir = FQN;
						}
						else
						{
							Directory D;
							FQN = UTIL.ReplaceSingleQuotes(FQN);
							if (! D.Exists(FQN))
							{
								goto SkipThisOne;
							}
						}
						
						IncludeSubDirs = RSData.GetValue(1).ToString();
						DB_ID = RSData.GetValue(2).ToString();
						VersionFiles = RSData.GetValue(3).ToString();
						DisableFolder = RSData.GetValue(4).ToString();
						OcrDirectory = RSData.GetValue(5).ToString();
						RetentionCode = RSData.GetValue(6).ToString();
						ArchiveSkipBit = RSData.GetValue(7).ToString();
						
						if (DisableFolder.ToUpper.Equals("Y"))
						{
							goto SkipThisOne;
						}
						
						if (FQN.Trim().Length > 254)
						{
							FQN = modGlobals.getShortDirName(FQN);
						}
						
						AddArchiveDir(FQN);
						
						if (SUBFQN.Length == 0)
						{
							//** do nothing
						}
						else if (SUBFQN.Trim().Length > 0)
						{
							FQN = SUBFQN;
						}
						
						ListOfFiles.Clear();
						if (IncludeSubDirs.Equals("Y") && TgtFolder.Trim.Length == 0)
						{
							if (bUseCommandProcessForInventory == 1)
							{
								bool BB = DMA.GetSubDirs(FQN, ListOfFiles);
								if (BB == false)
								{
									ListOfFiles = DMA.GetDirsRecursive(FQN);
								}
							}
							else
							{
								ListOfFiles = DMA.GetDirsRecursive(FQN);
							}
						}
						
						if (! ListOfFiles.Contains(FQN))
						{
							ListOfFiles.Add(FQN);
						}
						
						for (int k = 0; k <= ListOfFiles.Count - 1; k++)
						{
							string tFqn = (string) (ListOfFiles.Item(k));
							string SS = tFqn + "|" + IncludeSubDirs + "|" + DB_ID + "|" + VersionFiles + "|" + DisableFolder + "|" + OcrDirectory + "|" + RetentionCode + "|" + ParentDir + "|" + ArchiveSkipBit;
							if (tgtFolders.Contains(SS))
							{
								//Console.WriteLine("Duplicate: " + FQN)
							}
							else
							{
								tgtFolders.Add(SS);
							}
						}
SkipThisOne:
						I++;
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			return isGood;
		}
		
		public void xGetContentArchiveFileFolders(string UID, ref string[] aFolders)
		{
			
			string S = " ";
			S = S + " select FQN, IncludeSubDirs, DB_ID, VersionFiles, ckDisableDir, OcrDirectory, RetentionCode";
			S = S + " from Directory where UserID = \'" + UID + "\' or isSysDefault = 1 ";
			S = S + " UNION ALL ";
			S = S + " select subFQN as FQN, \'N\' as IncludeSubDirs, \'na\' AS DB_ID, VersionFiles, ckDisableDir, OcrDirectory, \' \'  as RetentionCode ";
			S = S + " from SubDir where UserID = \'" + UID + "\' or isSysDefault = 1 ";
			S = S + " and subFQN not in (select FQN from Directory)";
			S = S + " ORDER BY FQN";
			
			aFolders = new string[1];
			int I = 0;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			string SUBFQN = "";
			string IncludeSubDirs = "";
			string DB_ID = "";
			string VersionFiles = "";
			string DisableFolder = "";
			string OcrDirectory = "";
			string RetentionCode = "";
			
			string DbConnStr = "";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				I = 0;
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						SUBFQN = RSData.GetValue(0).ToString();
						SUBFQN = UTIL.RemoveSingleQuotes(SUBFQN);
						IncludeSubDirs = RSData.GetValue(1).ToString();
						DB_ID = RSData.GetValue(2).ToString();
						VersionFiles = RSData.GetValue(3).ToString();
						DisableFolder = RSData.GetValue(4).ToString();
						OcrDirectory = RSData.GetValue(5).ToString();
						RetentionCode = RSData.GetValue(6).ToString();
						
						if (I == 0)
						{
							aFolders[0] = SUBFQN + "|" + IncludeSubDirs + "|" + DB_ID + "|" + VersionFiles + "|" + DisableFolder + "|" + OcrDirectory + "|" + RetentionCode;
						}
						else
						{
							Array.Resize(ref aFolders, I + 1);
							aFolders[I] = SUBFQN + "|" + IncludeSubDirs + "|" + DB_ID + "|" + VersionFiles + "|" + DisableFolder + "|" + OcrDirectory + "|" + RetentionCode;
						}
						I++;
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			
		}
		
		public void GetContentArchiveFileFolders(string UID, ref string[] aFolders, string DirPath)
		{
			
			string S = "Select     S.SUBFQN, D.IncludeSubDirs, D.DB_ID, D.VersionFiles, D.ckDisableDir, D.FQN";
			S = S + " FROM         Directory AS D FULL OUTER JOIN";
			S = S + "                       SubDir AS S ON D.UserID = S.UserID AND D.FQN = S.FQN";
			S = S + " WHERE     (D.UserID = \'" + UID + "\')";
			S = S + " ORDER BY S.SUBFQN";
			
			aFolders = new string[1];
			int I = 0;
			bool DirFound = false;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			string SUBFQN = "";
			string IncludeSubDirs = "";
			string DB_ID = "";
			string VersionFiles = "";
			string DisableFolder = "";
			string ParentDir = "";
			
			string DbConnStr = "";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				I = 0;
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						SUBFQN = RSData.GetValue(0).ToString();
						SUBFQN = UTIL.RemoveSingleQuotes(SUBFQN);
						IncludeSubDirs = RSData.GetValue(1).ToString();
						DB_ID = RSData.GetValue(2).ToString();
						VersionFiles = RSData.GetValue(3).ToString();
						DisableFolder = RSData.GetValue(4).ToString();
						ParentDir = RSData.GetValue(5).ToString();
						ParentDir = UTIL.RemoveSingleQuotes(ParentDir);
						if (SUBFQN.ToUpper().Equals(DirPath.ToUpper()))
						{
							aFolders[0] = SUBFQN + "|" + IncludeSubDirs + "|" + DB_ID + "|" + VersionFiles + "|" + DisableFolder;
							DirFound = true;
							break;
						}
						if (SUBFQN.Length == 0 && (ParentDir.ToUpper().Equals(DirPath.ToUpper())))
						{
							aFolders[0] = ParentDir + "|" + IncludeSubDirs + "|" + DB_ID + "|" + VersionFiles + "|" + DisableFolder;
							DirFound = true;
							break;
						}
						I++;
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
				if (! DirFound)
				{
					aFolders[0] = DirPath + "|" + IncludeSubDirs + "|" + DB_ID + "|" + VersionFiles + "|" + DisableFolder;
				}
			}
			
			
		}
		
		public void GetQuickArchiveFileFolders(string UID, ref string[] aFolders, string DirPath)
		{
			
			string S = "Select     S.SUBFQN, D.IncludeSubDirs, D.DB_ID, D.VersionFiles, D.ckDisableDir, D.FQN, D.RetentionCode";
			S = S + " FROM         QuickDirectory AS D FULL OUTER JOIN";
			S = S + "                       SubDir AS S ON D.UserID = S.UserID AND D.FQN = S.FQN";
			S = S + " WHERE     (D.UserID = \'" + UID + "\')";
			S = S + " ORDER BY S.SUBFQN";
			
			aFolders = new string[1];
			int I = 0;
			bool DirFound = false;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			string SUBFQN = "";
			string IncludeSubDirs = "";
			string DB_ID = "";
			string VersionFiles = "";
			string DisableFolder = "";
			string ParentDir = "";
			string RetentionCode = "";
			
			string DbConnStr = "";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				I = 0;
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						SUBFQN = RSData.GetValue(0).ToString();
						SUBFQN = UTIL.RemoveSingleQuotes(SUBFQN);
						IncludeSubDirs = RSData.GetValue(1).ToString();
						DB_ID = RSData.GetValue(2).ToString();
						VersionFiles = RSData.GetValue(3).ToString();
						DisableFolder = RSData.GetValue(4).ToString();
						ParentDir = RSData.GetValue(5).ToString();
						ParentDir = UTIL.RemoveSingleQuotes(ParentDir);
						RetentionCode = RSData.GetValue(6).ToString();
						if (SUBFQN.ToUpper().Equals(DirPath.ToUpper()))
						{
							aFolders[0] = SUBFQN + "|" + IncludeSubDirs + "|" + DB_ID + "|" + VersionFiles + "|" + DisableFolder + "|" + RetentionCode;
							DirFound = true;
							break;
						}
						if (SUBFQN.Length == 0 && (ParentDir.ToUpper().Equals(DirPath.ToUpper())))
						{
							aFolders[0] = ParentDir + "|" + IncludeSubDirs + "|" + DB_ID + "|" + VersionFiles + "|" + DisableFolder + "|" + RetentionCode;
							DirFound = true;
							break;
						}
						I++;
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
				if (! DirFound)
				{
					aFolders[0] = DirPath + "|" + IncludeSubDirs + "|" + DB_ID + "|" + VersionFiles + "|" + DisableFolder;
				}
			}
			
			
		}
		
		//     SELECT [ArchiveEmails]
		//      ,[RemoveAfterArchive]
		//      ,[SetAsDefaultFolder]
		//      ,[ArchiveAfterXDays]
		//      ,[RemoveAfterXDays]
		//      ,[RemoveXDays]
		//      ,[ArchiveXDays]
		//      ,[DB_ID]
		//  FROM [Email]
		//where UserID = 'wmiller'
		public bool GetEmailFolderParms(string TopFolder, string UID, string FolderName, ref string ArchiveEmails, ref string RemoveAfterArchive, ref string SetAsDefaultFolder, ref string ArchiveAfterXDays, ref string RemoveAfterXDays, ref string RemoveXDays, ref string ArchiveXDays, ref string DB_ID, ref string ArchiveOnlyIfRead)
		{
			
			ArchiveEmails = "";
			RemoveAfterArchive = "";
			SetAsDefaultFolder = "";
			ArchiveAfterXDays = "";
			RemoveAfterXDays = "";
			RemoveXDays = "";
			ArchiveXDays = "";
			DB_ID = "";
			
			bool BB = false;
			
			FolderName = UTIL.RemoveSingleQuotes(FolderName);
			
			//** Sometimes, the full name includeing the "|" is passed in -
			//** If so, just remove the string up to the "|" and fix it,
			//** and continue.
			
			if (FolderName.IndexOf("|") + 1 > 0)
			{
				FolderName = FolderName.Substring(FolderName.IndexOf("|") + 2 - 1);
			}
			
			string S = "Select [ArchiveEmails]";
			S = S + " ,[RemoveAfterArchive]";
			S = S + " ,[SetAsDefaultFolder]";
			S = S + " ,[ArchiveAfterXDays]";
			S = S + " ,[RemoveAfterXDays]";
			S = S + " ,[RemoveXDays]";
			S = S + " ,[ArchiveXDays]";
			S = S + " ,[DB_ID], ArchiveOnlyIfRead ";
			S = S + " from [EmailArchParms] ";
			S = S + " where UserID = \'" + UID + "\' ";
			S = S + " and  [FolderName] = \'" + TopFolder + "|" + FolderName + "\'";
			
			int I = 0;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			string DbConnStr = "";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						BB = true;
						ArchiveEmails = RSData.GetValue(0).ToString();
						RemoveAfterArchive = RSData.GetValue(1).ToString();
						SetAsDefaultFolder = RSData.GetValue(2).ToString();
						ArchiveAfterXDays = RSData.GetValue(3).ToString();
						RemoveAfterXDays = RSData.GetValue(4).ToString();
						RemoveXDays = RSData.GetValue(5).ToString();
						ArchiveXDays = RSData.GetValue(6).ToString();
						DB_ID = RSData.GetValue(7).ToString();
						ArchiveOnlyIfRead = RSData.GetValue(8).ToString();
					}
				}
				else
				{
					LOG.WriteToArchiveLog((string) ("ERROR GetEmailFolderParms 100: - could not find: " + S));
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			return BB;
		}
		
		public string GetEmailSubject(string EmailGuid)
		{
			
			string Subject = "";
			
			bool BB = false;
			
			string S = "Select [Subject]";
			S = S + " from [Email] ";
			S = S + " where EmailGuid = \'" + EmailGuid + "\' ";
			
			int I = 0;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			string DbConnStr = "";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						BB = true;
						Subject = RSData.GetValue(0).ToString();
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			return Subject;
		}
		
		public string GetEmailAttachmentGuid(string AttachmentName, string CrcHASH)
		{
			
			string RowGuid = "";
			
			bool BB = false;
			
			string SS = "select RowGuid from EmailAttachment where AttachmentName = \'" + AttachmentName + "\' and CRC = \'" + CrcHASH + "\'";
			
			int I = 0;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			string DbConnStr = "";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				SqlCommand command = new SqlCommand(SS, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						BB = true;
						RowGuid = RSData.GetValue(0).ToString();
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			return RowGuid;
		}
		
		public string GetEmailBody(string EmailGuid)
		{
			
			string Subject = "";
			
			bool BB = false;
			
			string S = "Select [Body]";
			S = S + " from [Email] ";
			S = S + " where EmailGuid = \'" + EmailGuid + "\' ";
			
			int I = 0;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			string DbConnStr = "";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						BB = true;
						Subject = RSData.GetValue(0).ToString();
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			return Subject;
		}
		
		public string GetDocTitle(string SourceGuid)
		{
			
			bool TitleFound = false;
			
			string Subject = "";
			
			bool BB = false;
			
			string S = "Select [AttributeValue]     ";
			S = S + "   FROM [SourceAttribute]";
			S = S + " where [AttributeName] like \'Title\'";
			S = S + " and [SourceGuid] = \'" + SourceGuid + "\'";
			
			int I = 0;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			string DbConnStr = "";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					TitleFound = true;
					
					BB = true;
					Subject = RSData.GetValue(0).ToString();
					
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			
			if (TitleFound == false)
			{
				Subject = (string) ("No subject metadata found, document name is: " + GetDocFilename(SourceGuid));
			}
			
			return Subject;
		}
		
		public string GetDocFilename(string SourceGuid)
		{
			
			string FileName = "";
			
			bool BB = false;
			
			string S = "Select [SourceName] FROM  [DataSource] where [SourceGuid] = \'" + SourceGuid + "\'";
			
			int I = 0;
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			string DbConnStr = "";
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					BB = true;
					RSData.Read();
					FileName = RSData.GetValue(0).ToString();
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
			}
			
			if (BB == false)
			{
				FileName = "No file name supplied for this content.";
			}
			else
			{
				FileName = (string) ("\r\n" + FileName);
			}
			return FileName;
		}
		public void AddIncludedFiletypes(string FQN, ArrayList L, string IncludeSubDirs)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			string[] AllDirs = new string[1];
			string tDir = "";
			IncludeSubDirs = IncludeSubDirs.ToUpper();
			if (IncludeSubDirs.Equals("N"))
			{
				tDir = FQN;
				GetIncludedFiletypes(tDir, L);
			}
			else
			{
				AllDirs = FQN.Split(char.Parse("\\").ToString().ToCharArray());
				for (int i = 0; i <= (AllDirs.Length - 1); i++)
				{
					tDir = tDir + AllDirs[i];
					GetIncludedFiletypes(tDir, L);
					tDir = tDir + "\\";
				}
			}
		}
		
		public void AddExcludedFiletypes(string FQN, ArrayList L, string IncludeSubDirs)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			string[] AllDirs = new string[1];
			string tDir = "";
			IncludeSubDirs = IncludeSubDirs.ToUpper();
			if (IncludeSubDirs.Equals("N"))
			{
				tDir = FQN;
				GetExcludedFiletypes(tDir, L);
			}
			else
			{
				AllDirs = FQN.Split(char.Parse("\\").ToString().ToCharArray());
				for (int i = 0; i <= (AllDirs.Length - 1); i++)
				{
					tDir = tDir + AllDirs[i];
					this.GetExcludedFiletypes(tDir, L);
					tDir = tDir + "\\";
				}
			}
		}
		
		public void GetAllIncludedFiletypes(string FQN, ArrayList L, string IncludeSubDirs)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			L.Clear();
			string[] AllDirs = new string[1];
			string tDir = "";
			IncludeSubDirs = IncludeSubDirs.ToUpper();
			if (IncludeSubDirs.Equals("N"))
			{
				tDir = FQN;
				GetIncludedFiletypes(tDir, L);
			}
			else
			{
				AllDirs = FQN.Split(char.Parse("\\").ToString().ToCharArray());
				for (int i = 0; i <= (AllDirs.Length - 1); i++)
				{
					tDir = tDir + AllDirs[i];
					GetIncludedFiletypes(tDir, L);
					tDir = tDir + "\\";
				}
			}
		}
		public void GetAllExcludedFiletypes(string FQN, ArrayList L, string IncludeSubDirs)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			L.Clear();
			string[] AllDirs = new string[1];
			string tDir = "";
			IncludeSubDirs = IncludeSubDirs.ToUpper();
			if (IncludeSubDirs.Equals("N"))
			{
				tDir = FQN;
				GetExcludedFiletypes(tDir, L);
			}
			else
			{
				AllDirs = FQN.Split(char.Parse("\\").ToString().ToCharArray());
				for (int i = 0; i <= (AllDirs.Length - 1); i++)
				{
					tDir = tDir + AllDirs[i];
					this.GetExcludedFiletypes(tDir, L);
					tDir = tDir + "\\";
				}
			}
		}
		
		public void GetIncludedFiletypes(string FQN, ArrayList L)
		{
			L.Clear();
			
			FQN = UTIL.RemoveSingleQuotes(FQN);
			string S = "";
			
			if (FQN.Length == 0)
			{
				S = "Select distinct [ExtCode] FROM [IncludedFiles] order by [ExtCode]";
			}
			else
			{
				FQN = UTIL.RemoveSingleQuotes(FQN);
				S = "Select [ExtCode] FROM [IncludedFiles] where FQN = \'" + FQN + "\' order by [ExtCode]";
			}
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			string IncludeExt = "";
			L.Clear();
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						IncludeExt = RSData.GetValue(0).ToString();
						IncludeExt = IncludeExt.ToUpper();
						IncludeExt = IncludeExt.Trim();
						if (IncludeExt.Substring(0, 1) == ".")
						{
							IncludeExt = IncludeExt.Substring(1);
							IncludeExt = IncludeExt.Trim();
						}
						if (! L.Contains(IncludeExt))
						{
							L.Add(IncludeExt);
						}
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
				L.Sort();
			}
			
			
		}
		
		public void GetExcludedFiletypes(string FQN, ArrayList L)
		{
			
			L.Clear();
			
			FQN = UTIL.RemoveSingleQuotes(FQN);
			
			string S = "Select [ExtCode] FROM [ExcludedFiles] where FQN = \'" + FQN + "\' order by [ExtCode]";
			
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			string IncludeExt = "";
			L.Clear();
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						IncludeExt = RSData.GetValue(0).ToString();
						IncludeExt = IncludeExt.ToUpper();
						IncludeExt = IncludeExt.Trim();
						if (IncludeExt.Substring(0, 1) == ".")
						{
							IncludeExt = IncludeExt.Substring(1);
							IncludeExt = IncludeExt.Trim();
						}
						if (! L.Contains(IncludeExt))
						{
							L.Add(IncludeExt);
						}
					}
				}
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
				Conn.Close();
				Conn = null;
				L.Sort();
			}
			
			
		}
		
		public void AddSecondarySOURCETYPE(string Sourcetypecode, string Sourcetypedesc, string Storeexternal, string Indexable)
		{
			clsSOURCETYPE ST = new clsSOURCETYPE();
			ST.setSourcetypecode(ref Sourcetypecode);
			ST.setSourcetypedesc(ref Sourcetypedesc);
			ST.setStoreexternal(ref Storeexternal);
			ST.setIndexable(ref Indexable);
			ST.Insert();
		}
		
		public void delSecondarySOURCETYPE(string Sourcetypecode)
		{
			clsSOURCETYPE ST = new clsSOURCETYPE();
			ST.setSourcetypecode(ref Sourcetypecode);
			string WhereClause = "Where SourceTypeCode = \'" + Sourcetypecode + "\'";
			ST.Delete(WhereClause);
		}
		
		public Array FindAllTableIndexes(string TBL)
		{
			SortedList SL = new SortedList();
			string S = "";
			S = S + " select distinct si.name";
			S = S + " from sys.indexes si";
			S = S + " inner join sys.index_columns ic on si.object_id = ic.object_id and si.index_id = ic.index_id";
			S = S + " inner join information_schema.tables st on object_name(si.object_id) = st.table_name";
			S = S + " inner join information_schema.columns sc on ic.column_id = sc.ordinal_position and sc.table_name = st.table_name";
			S = S + " where si.name Is Not null And si.index_id > 0 And si.is_hypothetical = 0 ";
			S = S + " and sc.table_name = \'" + TBL + "\'";
			
			bool b = true;
			int i = 0;
			int id = -1;
			int II = 0;
			string IndexName = "";
			
			string[] TblIndexes = new string[1];
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					IndexName = RSData.GetValue(0).ToString();
					II = System.Convert.ToInt32((TblIndexes.Length - 1) + 1);
					Array.Resize(ref TblIndexes, II + 1);
					TblIndexes[II] = IndexName;
				}
			}
			else
			{
				id = -1;
			}
			RSData.Close();
			RSData = null;
			
			return TblIndexes;
			
		}
		
		public Array FindAllIndexCols(string TBL, string IdxName)
		{
			SortedList SL = new SortedList();
			string S = "";
			S = S + " select distinct sc.table_name,si.name,si.type_desc,sc.column_name";
			S = S + " from sys.indexes si";
			S = S + " inner join sys.index_columns ic on si.object_id = ic.object_id and si.index_id = ic.index_id";
			S = S + " inner join information_schema.tables st on object_name(si.object_id) = st.table_name";
			S = S + " inner join information_schema.columns sc on ic.column_id = sc.ordinal_position and sc.table_name = st.table_name";
			S = S + " where si.name Is Not null And si.index_id > 0 And si.is_hypothetical = 0 ";
			S = S + " and sc.table_name = \'" + TBL + "\'";
			S = S + " and name = \'" + IdxName + "\'";
			
			bool b = true;
			int i = 0;
			int id = -1;
			int II = 0;
			string ColName = "";
			
			string[] IndexColumns = new string[1];
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					ColName = RSData.GetValue(3).ToString();
					ColName = TBL + "|" + ColName;
					II = System.Convert.ToInt32((IndexColumns.Length - 1) + 1);
					Array.Resize(ref IndexColumns, II + 1);
					IndexColumns[II] = ColName;
				}
			}
			else
			{
				id = -1;
			}
			RSData.Close();
			RSData = null;
			
			return IndexColumns;
			
		}
		
		public string getColumnDataType(string TBL, string ColName)
		{
			SortedList SL = new SortedList();
			string S = "";
			S = S + " SELECT table_name, column_name, is_nullable, data_type, character_maximum_length";
			S = S + " FROM information_schema.columns ";
			S = S + " where  table_name = \'" + TBL + "\'";
			S = S + " AND column_name = \'" + ColName + "\'";
			
			bool b = true;
			int i = 0;
			int id = -1;
			int II = 0;
			string DataType = "";
			string IsNullable = "";
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					IsNullable = RSData.GetValue(2).ToString();
					DataType = RSData.GetValue(3).ToString();
					DataType = DataType + "|" + IsNullable;
				}
			}
			else
			{
				id = -1;
			}
			RSData.Close();
			RSData = null;
			
			return DataType;
			
		}
		
		public SqlDataReader GetRowByKey(string TBL, string WC)
		{
			try
			{
				string Auth = "";
				string s = (string) ("Select * from " + TBL + " " + WC);
				SqlDataReader rsData = null;
				bool b = false;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(s, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					rsData.Read();
					Auth = rsData.GetValue(0).ToString();
					return rsData;
				}
				else
				{
					return null;
				}
				
			}
			catch (Exception ex)
			{
				xTrace(12330, "clsDataBase:GetRowByKey", ex.Message);
				if (dDebug)
				{
					Debug.Print(ex.Message);
				}
				LOG.WriteToArchiveLog((string) ("clsDatabase : GetRowByKey : 3963 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : GetRowByKey : 3931 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : GetRowByKey : 3945 : " + ex.Message));
				return null;
			}
			
		}
		
		
		
		public int ckArchEmailFolder(string KeyFolder, string UserID)
		{
			
			bool b = true;
			string S = "Select count(*) ";
			S = S + "   FROM [EmailFolder]";
			S = S + " where [SelectedForArchive] = \'Y\'";
			S = S + " and FolderName =\'" + KeyFolder + "\'";
			S = S + " and UserID =\'" + UserID + "\'";
			int i = 0;
			string tQuery = "";
			
			//Dim i As Integer
			int cnt = -1;
			
			using (gConn)
			{
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = RSData.GetInt32(0);
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
			}
			
			
			return cnt;
			
		}
		
		public string getArchEmailFolderIDByFolder(string KeyFolder, string UserID)
		{
			
			bool b = true;
			string S = "Select FolderID ";
			S = S + "   FROM [EmailFolder]";
			S = S + " where [SelectedForArchive] = \'Y\'";
			S = S + " and FolderName =\'" + KeyFolder + "\'";
			S = S + " and UserID =\'" + UserID + "\'";
			int i = 0;
			string tQuery = "";
			
			//Dim i As Integer
			string xint = "";
			
			using (gConn)
			{
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				try
				{
					xint = RSData.GetValue(0).ToString();
				}
				catch (Exception)
				{
					xint = "";
				}
				
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
			}
			
			
			return xint;
			
		}
		public int ckArchChildEmailFolder(string FolderID, string UserID)
		{
			
			bool b = true;
			string S = "Select COUNT(*) from EmailFolder ";
			S = S + " where FolderID = \'" + FolderID + "\'";
			S = S + " and UserID = \'" + UserID + "\'";
			int i = 0;
			string tQuery = "";
			
			//Dim i As Integer
			int cnt = -1;
			
			using (gConn)
			{
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = RSData.GetInt32(0);
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
			}
			
			
			return cnt;
			
		}
		
		public string getArchEmailFolderRetentionCode(string FolderID, string UserID)
		{
			string rCode = "";
			bool b = true;
			string S = "Select RetentionCode ";
			S = S + "   FROM [EmailFolder]";
			S = S + " where ";
			S = S + " FolderID =\'" + FolderID + "\'";
			S = S + " and UserID =\'" + UserID + "\'";
			int i = 0;
			string tQuery = "";
			
			//Dim i As Integer
			int cnt = -1;
			
			using (gConn)
			{
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				rCode = RSData.GetValue(0).ToString();
				RSData.Close();
				RSData = null;
				command.Connection.Close();
				command = null;
			}
			
			
			return rCode;
			
		}
		
		public bool iCount(string Tbl, string WhereClause)
		{
			bool b = true;
			string SQL = (string) ("Select count(*) from " + Tbl + " " + WhereClause);
			int i = 0;
			
			i = iGetRowCount(SQL);
			if (i == 0)
			{
				b = false;
			}
			return b;
		}
		
		public int iGetRowCount(string TBL, string WhereClause)
		{
			
			int cnt = -1;
			
			try
			{
				string tQuery = "";
				string s = "";
				
				s = (string) ("Select count(*) as CNT from " + TBL + " " + WhereClause);
				
				using (gConn)
				{
					
					SqlDataReader RSData = null;
					
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(s, CONN);
					RSData = command.ExecuteReader();
					
					
					RSData.Read();
					cnt = RSData.GetInt32(0);
					
					if (! RSData.IsClosed)
					{
						RSData.Close();
					}
					RSData = null;
					command.Dispose();
					command = null;
					
					if (CONN.State == ConnectionState.Open)
					{
						CONN.Close();
					}
					CONN.Dispose();
				}
				
			}
			catch (Exception ex)
			{
				xTrace(12335, "clsDataBase:iGetRowCount", ex.Message);
				//messagebox.show("Error 3932.11: " + ex.Message)
				if (dDebug)
				{
					Debug.Print((string) ("Error .11: " + ex.Message));
				}
				Console.WriteLine("Error 3932.11.11: " + ex.Message);
				cnt = 0;
				LOG.WriteToArchiveLog((string) ("clsDatabase : iGetRowCount : 4010 : " + ex.Message));
			}
			
			return cnt;
			
		}
		
		public int iGetRowCount(string TBL, string WhereClause, string ConnectionStr)
		{
			
			int cnt = -1;
			
			SqlConnection tConn = new SqlConnection(ConnectionStr);
			if (tConn.State == ConnectionState.Closed)
			{
				tConn.Open();
			}
			
			try
			{
				string tQuery = "";
				string s = "";
				
				s = (string) ("Select count(*) as CNT from " + TBL + " " + WhereClause);
				
				using (tConn)
				{
					
					SqlDataReader RSData = null;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(s, CONN);
					RSData = command.ExecuteReader();
					RSData.Read();
					cnt = RSData.GetInt32(0);
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				
			}
			catch (Exception ex)
			{
				xTrace(12335, "clsDataBase:iGetRowCount", ex.Message);
				//messagebox.show("Error 3932.11: " + ex.Message)
				if (dDebug)
				{
					Debug.Print((string) ("Error 3932.11.12: " + ex.Message));
				}
				Console.WriteLine("Error 3932.11.12: " + ex.Message);
				cnt = 0;
				LOG.WriteToArchiveLog((string) ("clsDatabase : iGetRowCount : 4010 : " + ex.Message));
			}
			if (tConn.State == ConnectionState.Open)
			{
				tConn.Close();
			}
			
			tConn = null;
			return cnt;
			
		}
		
		public bool ArchiveEmail(string UID, string FqnEmailImage, string EmailGuid, string SUBJECT, string SentTO, string Body, string Bcc, string BillingInformation, string CC, string Companies, DateTime CreationTime, string ReadReceiptRequested, string ReceivedByName, DateTime ReceivedTime, string AllRecipients, string UserID, string SenderEmailAddress, string SenderName, string Sensitivity, DateTime SentOn, string MsgSize, DateTime DeferredDeliveryTime, string EntryID, DateTime ExpiryTime, DateTime LastModificationTime, string ShortSubj, string SourceTypeCode, string OriginalFolder)
		{
			int ID = 13345;
			FqnEmailImage = UTIL.RemoveSingleQuotes(FqnEmailImage);
			bool B = false;
			
			EmailGuid = UTIL.RemoveSingleQuotes(EmailGuid);
			SUBJECT = UTIL.RemoveSingleQuotes(SUBJECT);
			SentTO = UTIL.RemoveSingleQuotes(SentTO);
			Body = UTIL.RemoveSingleQuotes(Body);
			Bcc = UTIL.RemoveSingleQuotes(Bcc);
			BillingInformation = UTIL.RemoveSingleQuotes(BillingInformation);
			CC = UTIL.RemoveSingleQuotes(CC);
			Companies = UTIL.RemoveSingleQuotes(Companies);
			CreationTime = DateTime.Parse(UTIL.RemoveSingleQuotes(CreationTime.ToString()));
			ReadReceiptRequested = UTIL.RemoveSingleQuotes(ReadReceiptRequested);
			ReceivedByName = UTIL.RemoveSingleQuotes(ReceivedByName);
			ReceivedTime = DateTime.Parse(UTIL.RemoveSingleQuotes(ReceivedTime.ToString()));
			AllRecipients = UTIL.RemoveSingleQuotes(AllRecipients);
			UserID = UTIL.RemoveSingleQuotes(UserID);
			SenderEmailAddress = UTIL.RemoveSingleQuotes(SenderEmailAddress);
			SenderName = UTIL.RemoveSingleQuotes(SenderName);
			Sensitivity = UTIL.RemoveSingleQuotes(Sensitivity);
			SentOn = DateTime.Parse(UTIL.RemoveSingleQuotes(SentOn.ToString()));
			MsgSize = UTIL.RemoveSingleQuotes(MsgSize);
			DeferredDeliveryTime = DateTime.Parse(UTIL.RemoveSingleQuotes(DeferredDeliveryTime.ToString()));
			EntryID = UTIL.RemoveSingleQuotes(EntryID);
			ExpiryTime = DateTime.Parse(UTIL.RemoveSingleQuotes(ExpiryTime.ToString()));
			LastModificationTime = DateTime.Parse(UTIL.RemoveSingleQuotes(LastModificationTime.ToString()));
			
			try
			{
				
				byte[] EmailBinary = CF.FileToByte(FqnEmailImage);
				
				int OriginalSize = EmailBinary.Length;
				
				EmailBinary = COMP.CompressBuffer(EmailBinary);
				
				int CompressedSize = EmailBinary.Length;
				bool RC = false;
				string rMsg = "";
				DateTime TransmissionStartTime = DateTime.Now;
				DateTime txEndTime = DateTime.Now;
				
				//Dim proxy As New SVCCLCArchive.Service1Client
				B = System.Convert.ToBoolean(Proxy.ArchiveEmail(modGlobals.gGateWayID, ID, UID, FqnEmailImage, EmailGuid, SUBJECT, SentTO, Body, Bcc, BillingInformation, CC, Companies, CreationTime, ReadReceiptRequested, ReceivedByName, ReceivedTime, AllRecipients, UserID, SenderEmailAddress, SenderName, Sensitivity, SentOn, MsgSize, DeferredDeliveryTime, EntryID, ExpiryTime, LastModificationTime, ShortSubj, SourceTypeCode, OriginalFolder, EmailBinary, OriginalSize, CompressedSize, RC, rMsg, TransmissionStartTime, txEndTime));
				
				//Using connection As New SqlConnection(getGateWayConnStr(gGateWayID))
				//    Using command As New SqlCommand("EmailInsProc", connection)
				//        command.CommandType = CommandType.StoredProcedure
				
				//        command.Parameters.Add(New SqlParameter("@EmailGuid", EmailGuid))
				//        command.Parameters.Add(New SqlParameter("@SUBJECT", SUBJECT))
				//        command.Parameters.Add(New SqlParameter("@SentTO", SentTO))
				//        command.Parameters.Add(New SqlParameter("@Body", Body))
				//        command.Parameters.Add(New SqlParameter("@Bcc", Bcc))
				//        command.Parameters.Add(New SqlParameter("@BillingInformation", BillingInformation))
				//        command.Parameters.Add(New SqlParameter("@CC", CC))
				//        command.Parameters.Add(New SqlParameter("@Companies", Companies))
				//        command.Parameters.Add(New SqlParameter("@CreationTime", CreationTime))
				//        command.Parameters.Add(New SqlParameter("@ReadReceiptRequested", ReadReceiptRequested))
				//        command.Parameters.Add(New SqlParameter("@ReceivedByName", ReceivedByName))
				//        command.Parameters.Add(New SqlParameter("@ReceivedTime", ReceivedTime))
				//        command.Parameters.Add(New SqlParameter("@AllRecipients", AllRecipients))
				//        command.Parameters.Add(New SqlParameter("@UserID", UserID))
				//        command.Parameters.Add(New SqlParameter("@SenderEmailAddress", SenderEmailAddress))
				//        command.Parameters.Add(New SqlParameter("@SenderName", SenderName))
				//        command.Parameters.Add(New SqlParameter("@Sensitivity", Sensitivity))
				//        command.Parameters.Add(New SqlParameter("@SentOn", SentOn))
				//        command.Parameters.Add(New SqlParameter("@MsgSize", MsgSize))
				//        command.Parameters.Add(New SqlParameter("@DeferredDeliveryTime", DeferredDeliveryTime))
				//        command.Parameters.Add(New SqlParameter("@EntryID", EntryID))
				//        command.Parameters.Add(New SqlParameter("@ExpiryTime", ExpiryTime))
				//        command.Parameters.Add(New SqlParameter("@LastModificationTime", LastModificationTime))
				//        command.Parameters.Add(New SqlParameter("@EmailImage", EmailBinary))
				//        command.Parameters.Add(New SqlParameter("@ShortSubj", ShortSubj))
				//        command.Parameters.Add(New SqlParameter("@SourceTypeCode", SourceTypeCode))
				//        command.Parameters.Add(New SqlParameter("@OriginalFolder", OriginalFolder))
				
				//        connection.Open()
				//        command.ExecuteNonQuery()
				//        connection.Close()
				//        connection.Dispose()
				//        command.Dispose()
				//    End Using
				//End Using
			}
			catch (Exception ex)
			{
				xTrace(12340, "clsDataBase:ArchiveEmail", ex.Message);
				if (dDebug)
				{
					Debug.Print(ex.Message);
				}
				//Debug.Print(ex.StackTrace)
				B = false;
				LOG.WriteToArchiveLog((string) ("clsDatabase :  : 4076 : " + ex.Message));
			}
			return B;
		}
		
		public void InsertEmailBinary(string FQN, string tGuid)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			// Read a bitmap contents in a stream
			FileStream fs = new FileStream(FQN, FileMode.OpenOrCreate, FileAccess.Read);
			byte[] rawData = new byte[((int) fs.Length)+ 1];
			fs.Read(rawData, 0, System.Convert.ToInt32(fs.Length));
			fs.Close();
			// Construct a SQL string and a connection object
			string S = " ";
			S = S + " select * ";
			S = S + " FROM  [Email]";
			S = S + " where [EmailGuid] = \'" + tGuid + "\'";
			
			CloseConn();
			CkConn();
			
			// Open connection
			if (gConn.State != ConnectionState.Open)
			{
				gConn.Open();
			}
			// Create a data adapter and data set
			//Dim cmd As New SqlCommand(S, gConn)
			//Dim da As New SqlDataAdapter(cmd)
			//Dim ds As New Data.DataSet
			
			SqlConnection con = new SqlConnection(getGateWayConnStr(modGlobals.gGateWayID));
			SqlDataAdapter da = new SqlDataAdapter(S, con);
			SqlCommandBuilder MyCB = new SqlCommandBuilder(da);
			System.Data.DataSet ds = new System.Data.DataSet();
			
			da.Fill(ds, "Emails");
			System.Data.DataRow myRow;
			myRow = ds.Tables["Emails"].Rows[0];
			
			myRow["EmailImage"] = rawData;
			ds.AcceptChanges();
			
			MyCB = null;
			ds = null;
			da = null;
			
			con.Close();
			con = null;
			
		}
		
		public void ApplyCC()
		{
			List<string> L = new List<string>();
			clsRECIPIENTS RECIPS = new clsRECIPIENTS();
			SortedList SL = new SortedList();
			string S = " SELECT [EmailGuid]     ";
			S = S + " ,[CC]      ";
			S = S + " FROM  [Email]";
			S = S + " where CC Is Not null ";
			S = S + " and len(cc) > 0 ";
			
			bool b = true;
			int i = 0;
			int id = -1;
			int II = 0;
			string CC = "";
			string EmailGuid = "";
			
			SL.Clear();
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					EmailGuid = RSData.GetValue(0).ToString();
					CC = RSData.GetValue(1).ToString();
					if (CC != null)
					{
						SL.Clear();
						if (CC.Trim().Length > 0)
						{
							string[] A = new string[1];
							if (CC.IndexOf(";") + 1 > 0)
							{
								A = CC.Split(';');
							}
							else
							{
								A[0] = CC;
							}
							for (int KK = 0; KK <= (A.Length - 1); KK++)
							{
								string SKEY = A[KK];
								if (SKEY != null)
								{
									bool BX = SL.ContainsKey(SKEY);
									if (! BX)
									{
										SL.Add(SKEY, SKEY);
									}
								}
							}
						}
						for (int KK = 0; KK <= SL.Count - 1; KK++)
						{
							string Addr = SL.GetKey(KK).ToString();
							
							RECIPS.setEmailguid(ref EmailGuid);
							RECIPS.setRecipient(ref Addr);
							
							int BX = RECIPS.cnt_PK32A(EmailGuid, Addr);
							if (BX == 0)
							{
								RECIPS.setTyperecp("RECIP");
								RECIPS.Insert();
							}
							else
							{
								RECIPS.setTyperecp("CC");
								string SS = "UPDATE  [Recipients]";
								SS = SS + " SET [TypeRecp] = \'CC\'";
								SS = SS + " WHERE EmailGuid = \'" + EmailGuid + "\' ";
								SS = SS + " and Recipient = \'" + Addr + "\'";
								L.Add(SS);
							}
							
						}
					}
				}
			}
			else
			{
				id = -1;
			}
			RSData.Close();
			RSData = null;
			
			for (II = 0; II <= L.Count - 1; II++)
			{
				S = L.Item(II).ToString();
				bool bb = ExecuteSqlNewConn(S, false);
				if (! bb)
				{
					if (dDebug)
					{
						Debug.Print((string) ("ERROR: " + S));
					}
				}
			}
			
		}
		
		public void BuildAllRecips()
		{
			List<string> L = new List<string>();
			clsRECIPIENTS RECIPS = new clsRECIPIENTS();
			SortedList SL = new SortedList();
			string S = " SELECT [EmailGuid] ,[Recipient] ,[TypeRecp] FROM  [Recipients] order by EmailGuid ";
			
			bool b = true;
			int i = 0;
			int id = -1;
			int II = 0;
			string CC = "";
			string EmailGuid = "";
			string Recipient = "";
			string TypeRecp = "";
			string CurrGuid = "";
			string PrevGuid = "";
			string AllRecipients = "";
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					II++;
					EmailGuid = RSData.GetValue(0).ToString();
					Recipient = RSData.GetValue(1).ToString();
					TypeRecp = RSData.GetValue(2).ToString();
					if (II == 1)
					{
						PrevGuid = EmailGuid;
					}
					if (! EmailGuid.Equals(PrevGuid))
					{
						string SS = "UPDATE  [Email]";
						SS = SS + " SET [AllRecipients] = \'" + AllRecipients.Substring(1) + "\'";
						SS = SS + " WHERE EmailGuid = \'" + EmailGuid + "\' ";
						L.Add(SS);
						AllRecipients = "";
						AllRecipients = AllRecipients + ";" + Recipient;
					}
					else
					{
						AllRecipients = AllRecipients + ";" + Recipient;
					}
					PrevGuid = EmailGuid;
					frmMain.Default.SB.Text = (string) ("Recips: " + II.ToString());
					Application.DoEvents();
				}
			}
			RSData.Close();
			RSData = null;
			
			for (II = 0; II <= L.Count - 1; II++)
			{
				S = L.Item(II).ToString();
				bool bb = ExecuteSqlNewConn(S, false);
				if (! bb)
				{
					if (dDebug)
					{
						Debug.Print((string) ("ERROR: " + S));
					}
				}
				frmMain.Default.SB.Text = (string) ("Applying Recips: " + II.ToString());
				Application.DoEvents();
			}
			
		}
		
		public void BuildAllMissingData()
		{
			List<string> L = new List<string>();
			clsRECIPIENTS RECIPS = new clsRECIPIENTS();
			SortedList SL = new SortedList();
			string S = " SELECT SourceGuid, FQN FROM DataSource ";
			
			bool b = true;
			int i = 0;
			int id = -1;
			int II = 0;
			string CC = "";
			string SourceGuid = "";
			var FQN = "";
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					II++;
					SourceGuid = RSData.GetValue(0).ToString();
					FQN = RSData.GetValue(1).ToString();
					FQN = DMA.GetFilePath(FQN);
					
					string SS = "UPDATE [DataSource] ";
					SS = SS + " SET [FileDirectory] = \'" + FQN + "\'";
					SS = SS + " WHERE SourceGuid = \'" + SourceGuid + "\' ";
					L.Add(SS);
					
					frmMain.Default.SB.Text = (string) ("Files Read: " + II.ToString());
					Application.DoEvents();
				}
			}
			RSData.Close();
			RSData = null;
			
			for (II = 0; II <= L.Count - 1; II++)
			{
				S = L.Item(II).ToString();
				bool bb = ExecuteSqlNewConn(S, false);
				if (! bb)
				{
					if (dDebug)
					{
						Debug.Print((string) ("ERROR: " + S));
					}
				}
				frmMain.Default.SB.Text = (string) ("Applying Files: " + II.ToString());
				Application.DoEvents();
			}
			
		}
		
		public void BuildAllCCs()
		{
			List<string> L = new List<string>();
			clsRECIPIENTS RECIPS = new clsRECIPIENTS();
			SortedList SL = new SortedList();
			string S = " SELECT [EmailGuid] ,[Recipient] ,[TypeRecp] FROM  [Recipients] where TypeRecp = \'CC\' order by EmailGuid ";
			
			bool b = true;
			int i = 0;
			int id = -1;
			int II = 0;
			string CC = "";
			string EmailGuid = "";
			string Recipient = "";
			string TypeRecp = "";
			string CurrGuid = "";
			string PrevGuid = "";
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					II++;
					EmailGuid = RSData.GetValue(0).ToString();
					Recipient = RSData.GetValue(1).ToString();
					TypeRecp = RSData.GetValue(2).ToString();
					if (II == 1)
					{
						PrevGuid = EmailGuid;
					}
					if (! EmailGuid.Equals(PrevGuid))
					{
						string SS = "UPDATE  [Email]";
						SS = SS + " SET [CC] = \'" + CC.Substring(1) + "\'";
						SS = SS + " WHERE EmailGuid = \'" + EmailGuid + "\' ";
						L.Add(SS);
						CC = "";
						CC = CC + ";" + Recipient;
					}
					else
					{
						CC = CC + ";" + Recipient;
					}
					PrevGuid = EmailGuid;
					frmMain.Default.SB.Text = (string) ("CC: " + II.ToString());
					Application.DoEvents();
				}
			}
			RSData.Close();
			RSData = null;
			
			for (II = 0; II <= L.Count - 1; II++)
			{
				S = L.Item(II).ToString();
				bool bb = ExecuteSqlNewConn(S, false);
				if (! bb)
				{
					if (dDebug)
					{
						Debug.Print((string) ("ERROR: " + S));
					}
				}
				frmMain.Default.SB.Text = (string) ("Applying CC: " + II.ToString());
				Application.DoEvents();
			}
			
		}
		
		public void getExcludedEmails(string UserID)
		{
			List<string> L = new List<string>();
			clsRECIPIENTS RECIPS = new clsRECIPIENTS();
			SortedList SL = new SortedList();
			string S = " SELECT [FromEmailAddr] FROM  [ExcludeFrom] where  Userid = \'" + modGlobals.gCurrUserGuidID + "\' ";
			
			modGlobals.zeroizeExcludedEmailAddr();
			
			bool b = true;
			string Email = "";
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					Email = RSData.GetValue(0).ToString();
					modGlobals.AddExcludedEmailAddr(Email);
					Application.DoEvents();
				}
			}
			RSData.Close();
			RSData = null;
		}
		
		public bool getDirectoryParms(ref string[] A, string FQN, string UserID)
		{
			
			FQN = UTIL.RemoveSingleQuotes(FQN);
			bool B = false;
			A = new string[1];
			string IncludeSubDirs = "";
			string VersionFiles = "";
			string ckMetaData = "";
			int NumberOfDirs = 0;
			int CurrDir = 0;
			int I = 0;
			string OcrDirectory = "";
			string OcrPdf = "";
			string RetentionCode = "";
			string ckPublic = "";
			
			for (I = 1; I <= FQN.Length; I++)
			{
				string ch = FQN.Substring(I - 1, 1);
				if (ch == "\\")
				{
					NumberOfDirs++;
				}
			}
			CurrDir = NumberOfDirs;
			string[] DIRS = FQN.Split('\\');
REDO:
			string CurrFqn = "";
			for (I = 0; I <= CurrDir; I++)
			{
				if (I == 0)
				{
					CurrFqn = DIRS[0];
				}
				else
				{
					CurrFqn = CurrFqn + "\\" + DIRS[I];
				}
			}
			
			try
			{
				SqlDataReader rsData = null;
				string S = "";
				S = S + " SELECT [UserID]" + "\r\n";
				S = S + " ,[IncludeSubDirs]" + "\r\n";
				S = S + " ,[FQN]" + "\r\n";
				S = S + " ,[DB_ID]" + "\r\n";
				S = S + " ,[VersionFiles]" + "\r\n";
				S = S + " ,[ckMetaData] " + "\r\n";
				S = S + " ,OcrDirectory " + "\r\n";
				S = S + " ,RetentionCode" + "\r\n";
				S = S + " ,OcrPdf" + "\r\n";
				S = S + " ,ckPublic" + "\r\n";
				S = S + " FROM [Directory]" + "\r\n";
				S = S + " where fqn = \'" + CurrFqn + "\' and Userid = \'" + UserID + "\'";
				
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				
				setConnStr();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				
				if (rsData.HasRows)
				{
					while (rsData.Read())
					{
						B = true;
						IncludeSubDirs = rsData.GetValue(1).ToString();
						VersionFiles = rsData.GetValue(4).ToString();
						ckMetaData = rsData.GetValue(5).ToString();
						OcrDirectory = rsData.GetValue(6).ToString();
						RetentionCode = rsData.GetValue(7).ToString();
						OcrPdf = rsData.GetValue(8).ToString();
						ckPublic = rsData.GetValue(9).ToString();
						A = new string[8];
						A[0] = IncludeSubDirs;
						A[1] = VersionFiles;
						A[2] = ckMetaData;
						A[3] = OcrDirectory;
						A[4] = RetentionCode;
						A[5] = OcrPdf;
						A[6] = ckPublic;
					}
				}
				rsData.Close();
				rsData = null;
				
				command.Dispose();
				command = null;
				
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				
			}
			catch (Exception ex)
			{
				xTrace(12341, "clsDataBase:getDirectoryParms", ex.Message);
				if (dDebug)
				{
					Debug.Print(ex.Message);
				}
				B = false;
				LOG.WriteToArchiveLog((string) ("clsDatabase : getDirectoryParms : 4390 : " + ex.Message));
			}
			if (B)
			{
				return true;
			}
			else
			{
				A = new string[8];
				A[0] = IncludeSubDirs;
				A[1] = VersionFiles;
				A[2] = ckMetaData;
				A[3] = OcrDirectory;
				if (RetentionCode.Length == 0)
				{
					RetentionCode = getFirstRetentionCode();
				}
				A[4] = RetentionCode;
				A[5] = OcrPdf;
				A[6] = ckPublic;
				if (CurrDir == 1)
				{
					return false;
				}
				else
				{
					CurrDir--;
					if (CurrDir <= 0)
					{
						A[0] = "N"; //IncludeSubDirs
						A[1] = "Y"; //VersionFiles
						A[2] = "N"; //ckMetaData
						A[3] = "Y"; //OcrDirectory
						A[4] = getFirstRetentionCode();
						A[5] = "Y"; //OcrPdf
						A[6] = "N"; //OcrPdf
						return false;
					}
					else
					{
						goto REDO;
					}
					
				}
			}
		}
		public string getFirstRetentionCode()
		{
			string rCode = "";
			string S = "Select RetentionCode ";
			S = S + " FROM [Retention]";
			int I = 0;
			try
			{
				SqlDataReader RSData = null;
				//RSData = SqlQryNo'Session(S)
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				
				if (RSData.HasRows)
				{
					RSData.Read();
					rCode = RSData.GetValue(0).ToString();
				}
				
				if (! RSData.IsClosed)
				{
					RSData.Close();
				}
				RSData = null;
				command.Dispose();
				command = null;
				
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				
				
			}
			catch (Exception ex)
			{
				xTrace(12341, "clsDataBase:getFirstRetentionCode", ex.Message);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getFirstRetentionCode : 4419 : " + ex.Message));
			}
			return rCode;
		}
		public int getNextDocVersionNbr(string Userid, string FQN)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			string S = "Select max([VersionNbr]) ";
			S = S + " FROM DataSource";
			S = S + " where fqn = \'" + FQN + "\'";
			S = S + " and [DataSourceOwnerUserID] = \'" + Userid + "\'";
			int I = 0;
			try
			{
				SqlDataReader RSData = null;
				//RSData = SqlQryNo'Session(S)
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					I = int.Parse(RSData.GetValue(0).ToString());
				}
				RSData.Close();
				RSData = null;
				return I + 1;
			}
			catch (Exception ex)
			{
				xTrace(12341, "clsDataBase:getNextDocVersionNbr", ex.Message);
				I = -1;
				LOG.WriteToArchiveLog((string) ("clsDatabase : getNextDocVersionNbr : 4419 : " + ex.Message));
			}
			return I;
		}
		
		public bool DeleteDocumentByName(string Userid, string FQN, string SourceGuid)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			bool b = false;
			
			string S = "delete ";
			
			S = S + " FROM DataSource";
			S = S + " where fqn = \'" + FQN + "\'";
			S = S + " and [DataSourceOwnerUserID] = \'" + Userid + "\' or SourceGuid = \'" + SourceGuid + "\'";
			
			try
			{
				b = ExecuteSqlNewConn(S, false);
				return b;
			}
			catch (Exception ex)
			{
				xTrace(12345, "clsDataBase:DeleteDocumentByName", ex.Message);
				if (dDebug)
				{
					Debug.Print(ex.Message);
				}
				LOG.WriteToArchiveLog((string) ("clsDatabase : DeleteDocumentByName : 4429 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : DeleteDocumentByName : 4402 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : DeleteDocumentByName : 4417 : " + ex.Message));
				return b;
			}
			
			//S = " delete FROM DataSource"
			//S = S + " where SourceGuid = '" + SourceGuid  + "'"
			
			//Try
			//    b = ExecuteSqlNewConn(S,false)
			//    Return b
			//Catch ex As Exception
			// if ddebug then    Debug.Print(ex.Message)
			//    Return b
			//End Try
			
		}
		
		public bool DeleteDocumentByGuid(string SourceGuid)
		{
			clsSEARCHHISTORY SHIST = new clsSEARCHHISTORY();
			bool b = false;
			
			string S = "delete ";
			
			S = S + " FROM DataSource";
			S = S + " where SourceGuid = \'" + SourceGuid + "\'";
			int I = 0;
			try
			{
				b = ExecuteSqlNewConn(S, false);
				S = "DELETE FROM [SourceAttribute] WHERE SourceGuid = \'" + SourceGuid + "\' ";
				b = ExecuteSqlNewConn(S, false);
				
				SHIST.setCalledfrom("clsDatabase:DeleteDocumentByGuid");
				SHIST.setEndtime(DateTime.Now.ToString());
				SHIST.setReturnedrows("1");
				SHIST.setTypesearch("Delete");
				SHIST.setStarttime(DateTime.Now.ToString());
				SHIST.setSearchdate(DateTime.Now.ToString());
				SHIST.setSearchsql(ref S);
				SHIST.setUserid(ref modGlobals.gCurrUserGuidID);
				b = SHIST.Insert();
				if (! b)
				{
					Console.WriteLine("Error 1943.244 - Failed to save history of search.");
				}
				b = true;
			}
			catch (Exception ex)
			{
				xTrace(12345, "clsDataBase:DeleteDocumentByGuid", ex.Message);
				if (dDebug)
				{
					Debug.Print(ex.Message);
				}
				LOG.WriteToArchiveLog((string) ("clsDatabase : DeleteDocumentByGuid : 4438 : " + ex.Message));
				b = false;
			}
			
			SHIST = null;
			return b;
		}
		
		public bool hasDocumentBeenUpdated(string Userid, string FQN)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			bool b = false;
			
			string S = "delete ";
			
			S = S + " FROM DataSource";
			S = S + " where fqn = \'" + FQN + "\'";
			S = S + " and [DataSourceOwnerUserID] = \'" + Userid + "\'";
			int I = 0;
			try
			{
				b = ExecuteSqlNewConn(S, false);
				return b;
			}
			catch (Exception ex)
			{
				xTrace(12345, "clsDataBase:hasDocumentBeenUpdated", ex.Message);
				if (dDebug)
				{
					Debug.Print(ex.Message);
				}
				LOG.WriteToArchiveLog((string) ("clsDatabase : hasDocumentBeenUpdated : 4449 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : hasDocumentBeenUpdated : 4424 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : hasDocumentBeenUpdated : 4441 : " + ex.Message));
				return b;
			}
			
		}
		
		public void UpdateDocSize(string DocGuid, string fSize)
		{
			string S = "";
			S = S + "  UPDATE [DataSource]";
			S = S + "  set [FileLength] = " + fSize;
			S = S + "  WHERE [SourceGuid] = \'" + DocGuid + "\'";
			
			bool B = ExecuteSqlNewConn(S, false);
			
			if (! B)
			{
				LOG.WriteToArchiveLog("Failed to update File Size for GUID \'" + DocGuid + "\'.");
			}
			
		}
		
		public void UpdateDocSize(string FQN, string UID, string fSize)
		{
			
			FQN = UTIL.RemoveSingleQuotes(FQN);
			
			string S = "";
			S = S + "  UPDATE [DataSource]";
			S = S + "  set [FileLength] = " + fSize;
			S = S + "  WHERE [DataSourceOwnerUserID] = \'" + UID + "\' and FQN = \'" + FQN + "\'";
			
			bool B = ExecuteSqlNewConn(S, false);
			
			if (! B)
			{
				LOG.WriteToArchiveLog("Failed to update File Size for FQN \'" + FQN + "\'.");
			}
			
		}
		
		public void UpdateRssLinkFlgToTrue(string DocGuid)
		{
			
			string S = "";
			S = S + "  UPDATE [DataSource]";
			S = S + "  set [RssLinkFlg] = 1 ";
			S = S + "  WHERE [SourceGuid] = \'" + DocGuid + "\'";
			
			bool B = this.ExecuteSqlNewConn(S, false);
			
			if (! B)
			{
				LOG.WriteToArchiveLog("Failed to update File UpdateWebLinkFlgToTrue Feed \'" + DocGuid + "\'.");
			}
			
		}
		public void UpdateWebLinkFlgToTrue(string DocGuid)
		{
			
			string S = "";
			S = S + "  UPDATE [DataSource]";
			S = S + "  set [isWebPage] = \'Y\' ";
			S = S + "  WHERE [SourceGuid] = \'" + DocGuid + "\'";
			
			bool B = this.ExecuteSqlNewConn(S, false);
			
			if (! B)
			{
				LOG.WriteToArchiveLog("Failed to update File UpdateWebLinkFlgToTrue Feed \'" + DocGuid + "\'.");
			}
			
		}
		public void UpdateSourceCRC(string SourceGuid, string CRC)
		{
			
			string S = "";
			S = S + "  UPDATE [DataSource]";
			S = S + "  set [CRC] = \'" + CRC + "\' ";
			S = S + "  WHERE [SourceGuid] = \'" + SourceGuid + "\'";
			
			bool B = this.ExecuteSqlNewConn(S, false);
			
			if (! B)
			{
				LOG.WriteToArchiveLog("Failed to update File UpdateSourceCRC Feed \'" + SourceGuid + "\'.");
			}
			
		}
		
		public void UpdateContentDescription(string DocGuid, string Description)
		{
			
			string sDescription = Description.Replace("\'", "\'\'");
			
			string S = "";
			S = S + "  UPDATE [DataSource]";
			S = S + "  set [Description] = \'" + Description + "\' ";
			S = S + "  WHERE [SourceGuid] = \'" + DocGuid + "\'";
			
			bool B = this.ExecuteSqlNewConn(S, false);
			
			if (! B)
			{
				LOG.WriteToArchiveLog("Failed to update File UpdateContentDescription \'" + DocGuid + "\'.");
			}
			
		}
		public void UpdateContentKeyWords(string DocGuid, string KeyWords)
		{
			
			string sKeyWords = KeyWords.Replace("\'", "\'\'");
			if (sKeyWords.Length > 1999)
			{
				sKeyWords = sKeyWords.Substring(0, 1999);
			}
			sKeyWords = sKeyWords.Trim();
			string S = "";
			S = S + "  UPDATE [DataSource]";
			S = S + "  set [KeyWords] = \'" + sKeyWords + "\' ";
			S = S + "  WHERE [SourceGuid] = \'" + DocGuid + "\'";
			
			bool B = this.ExecuteSqlNewConn(S, false);
			
			if (! B)
			{
				LOG.WriteToArchiveLog("Failed to update File UpdateContentKeyWords \'" + DocGuid + "\'.");
			}
			
		}
		
		public void UpdateWebPageUrlRef(string DocGuid, string PageUrl)
		{
			
			string sPageUrl = PageUrl.Replace("\'", "\'\'");
			
			string S = "";
			S = S + "  UPDATE [DataSource]";
			S = S + "  set [PageUrl] = \'" + sPageUrl + "\' ";
			S = S + "  WHERE [SourceGuid] = \'" + DocGuid + "\'";
			
			bool B = this.ExecuteSqlNewConn(S, false);
			
			if (! B)
			{
				LOG.WriteToArchiveLog("Failed to update WebPage reference Feed \'" + DocGuid + "\'.");
			}
			
		}
		public void UpdateWebPageHash(string DocGuid, string URLHash)
		{
			
			string sURLHash = URLHash.Replace("\'", "\'\'");
			
			string S = "";
			S = S + "  UPDATE [DataSource]";
			S = S + "  set [URLHash] = \'" + sURLHash + "\' ";
			S = S + "  WHERE [SourceGuid] = \'" + DocGuid + "\'";
			
			bool B = this.ExecuteSqlNewConn(S, false);
			
			if (! B)
			{
				LOG.WriteToArchiveLog("Failed to update WebPage URL HASH: \'" + DocGuid + "\'.");
			}
			
		}
		public void UpdateWebPagePublishDate(string DocGuid, string WebPagePublishDate)
		{
			
			string sWebPagePublishDate = WebPagePublishDate.Replace("\'", "\'\'");
			
			string S = "";
			S = S + "  UPDATE [DataSource]";
			S = S + "  set [WebPagePublishDate] = \'" + sWebPagePublishDate + "\' ";
			S = S + "  WHERE [SourceGuid] = \'" + DocGuid + "\'";
			
			bool B = this.ExecuteSqlNewConn(S, false);
			
			if (! B)
			{
				LOG.WriteToArchiveLog("Failed UpdateWebPagePublishDate \'" + DocGuid + "\'.");
			}
			
		}
		
		public void UpdateDocFqn(string DocGuid, string FQN)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			string S = "";
			S = S + "  UPDATE [DataSource]";
			S = S + "  set [FQN] = \'" + FQN + "\' ";
			S = S + "  WHERE [SourceGuid] = \'" + DocGuid + "\'";
			
			bool B = this.ExecuteSqlNewConn(S, false);
			
			if (! B)
			{
				LOG.WriteToArchiveLog("Failed to update File FQN \'" + FQN + "\'.");
			}
			
		}
		
		public void UpdateDocCrc(string DocGuid, string CRC)
		{
			
			string S = "";
			S = S + "  UPDATE [DataSource]";
			S = S + "  set [CRC] = \'" + CRC + "\' ";
			S = S + "  WHERE [SourceGuid] = \'" + DocGuid + "\'";
			
			bool B = this.ExecuteSqlNewConn(S, false);
			
			if (! B)
			{
				LOG.WriteToSaveSql("Failed to update File FQN \'" + CRC + "\'.");
			}
			
		}
		public void xUpdateAllDocCrc(string FQN, string CRC)
		{
			
			string S = "";
			S = S + "  UPDATE [DataSource]";
			S = S + "  set [CRC] = \'" + CRC + "\' ";
			S = S + "  WHERE [FQN] = \'" + FQN + "\'";
			
			bool B = this.ExecuteSqlNewConn(S, false);
			
			if (! B)
			{
				LOG.WriteToSaveSql("Failed to update File FQN \'" + CRC + "\'.");
			}
			
		}
		public void UpdateDocOriginalFileType(string DocGuid, string OriginalFileType)
		{
			OriginalFileType = UTIL.RemoveSingleQuotes(OriginalFileType);
			string S = "";
			S = S + "  UPDATE [DataSource]";
			S = S + "  set [OriginalFileType] = \'" + OriginalFileType + "\' ";
			S = S + "  WHERE [SourceGuid] = \'" + DocGuid + "\'";
			
			bool B = ExecuteSqlNewConn(S, false);
			
			if (! B)
			{
				LOG.WriteToArchiveLog("Failed to update OriginalFileType \'" + OriginalFileType + "\'.");
			}
			
		}
		
		public void UpdateZipFileIndicator(string DocGuid, bool cZipFile)
		{
			
			string C = "";
			if (cZipFile)
			{
				C = "Y";
			}
			else
			{
				C = "N";
			}
			
			string S = "";
			S = S + "  UPDATE [DataSource]";
			S = S + "  set [IsZipFile] = \'" + C + "\' ";
			S = S + "  WHERE [SourceGuid] = \'" + DocGuid + "\'";
			
			bool B = ExecuteSqlNewConn(S, false);
			
			if (! B)
			{
				LOG.WriteToArchiveLog("ERROR 285.34.2 Failed to update ZIPFILE flag: \'" + DocGuid + "\'.");
			}
			
		}
		public void UpdateEmailIndicator(string DocGuid, string EmailGuid)
		{
			string S = "";
			S = S + "  UPDATE [DataSource]";
			S = S + "  set [EmailGuid] = \'" + EmailGuid + "\', isEmailAttachment = 1 ";
			S = S + "  WHERE [SourceGuid] = \'" + DocGuid + "\'";
			
			bool B = ExecuteSqlNewConn(S, false);
			if (! B)
			{
				LOG.WriteToArchiveLog("ERROR 285.34.2 UpdateEmailIndicator: Failed to update EMAIL flag: \'" + DocGuid + "\'.");
			}
			
		}
		
		public void UpdateZipFileOwnerGuid(string ParentGuid, string ZipFileGuid, string ZipFileFQN)
		{
			
			string S = "";
			S = S + "  UPDATE [DataSource]";
			S = S + "  set [ZipFileGuid] = \'" + ParentGuid + "\', ZipFileFQN = \'" + ZipFileFQN + "\', isContainedWithinZipFile = \'Y\', ParentGuid = \'" + ParentGuid + "\'  ";
			S = S + "  WHERE [SourceGuid] = \'" + ZipFileGuid + "\'";
			
			bool B = ExecuteSqlNewConn(S, false);
			
			if (! B)
			{
				LOG.WriteToArchiveLog("ERROR 2858.34.2 Failed to update ZIPFILE FQN: \'" + ZipFileGuid + "\'.");
			}
			
			S = "Update DataSource set isZipFile = \'Y\' where SourceGuid = \'" + ParentGuid + "\' ";
			B = ExecuteSqlNewConn(S, false);
			if (! B)
			{
				LOG.WriteToArchiveLog("ERROR 2858.34.3 Failed to update ZIPFILE FQN: \'" + ParentGuid + "\'.");
			}
			
			
		}
		
		public void UpdateIsContainedWithinZipFile(string DocGuid)
		{
			
			string C = "";
			
			string S = "";
			S = S + "  UPDATE [DataSource]";
			S = S + "  set [isContainedWithinZipFile] = \'Y\' ";
			S = S + "  WHERE [SourceGuid] = \'" + DocGuid + "\'";
			
			bool B = ExecuteSqlNewConn(S, false);
			
			if (! B)
			{
				LOG.WriteToArchiveLog("ERROR 285.34.21 Failed to update ZIPFILE flag: \'" + DocGuid + "\'.");
			}
			
		}
		
		public void UpdateDocDir(string DocGuid, string DocDir)
		{
			
			DocDir = UTIL.RemoveSingleQuotes(DocDir);
			DocDir = DMA.GetFilePath(DocDir);
			
			string S = "";
			S = S + "  UPDATE [DataSource]";
			S = S + "  set [FileDirectory] = \'" + DocDir + "\' ";
			S = S + "  WHERE [SourceGuid] = \'" + DocGuid + "\'";
			
			bool B = ExecuteSqlNewConn(S, false);
			
			if (! B)
			{
				LOG.WriteToArchiveLog("Failed to update File Size for GUID \'" + DocGuid + "\'.");
			}
			
		}
		
		public bool DeleteDataSourceAndAttrs(string WhereClause)
		{
			string s = "";
			bool B = false;
			s = "delete from SourceAttribute where [SourceGuid] in (SELECT [SourceGuid] FROM DataSource " + WhereClause + ")";
			B = ExecuteSqlNewConn(s, false);
			if (B)
			{
				s = (string) ("delete from datasource " + WhereClause);
				B = ExecuteSqlNewConn(s, false);
			}
			else
			{
				B = false;
			}
			return B;
		}
		
		public string getProcessFileAsExt(string FileExt)
		{
			if (FileExt.Trim().Length == 0)
			{
				return ".UKN";
			}
			string NexExt = "";
			string ProcessExtCode = "";
			string S = "Select [ExtCode]";
			S = S + " ,[ProcessExtCode]";
			S = S + " FROM  [ProcessFileAs]";
			S = S + " where ExtCode = \'" + FileExt + "\'";
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			
			if (RSData.HasRows)
			{
				RSData.Read();
				NexExt = RSData.GetValue(0).ToString();
				ProcessExtCode = RSData.GetValue(1).ToString();
			}
			else
			{
				NexExt = null;
			}
			if (! RSData.IsClosed)
			{
				RSData.Close();
			}
			if (RSData != null)
			{
				RSData = null;
			}
			return ProcessExtCode;
		}
		
		public void SetDocumentPublicFlagByOwnerDir(string FQN, bool PublicFlag, bool bDisableDir, string OcrDirectory)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			string UID = modGlobals.gCurrUserGuidID;
			
			string S = "";
			string sFlag = "";
			//Dim iFlag  = ""
			bool B;
			string DisableDir = "";
			
			if (PublicFlag)
			{
				sFlag = "Y";
				//iFlag  = "1"
			}
			else
			{
				sFlag = "N";
				//iFlag  = "0"
			}
			if (bDisableDir)
			{
				DisableDir = "Y";
			}
			else
			{
				DisableDir = "N";
			}
			
			string SS = "";
			
			//*******************************************************
			S = "update [Directory] set [ckPublic] = \'" + sFlag + "\', ckDisableDir = \'" + DisableDir + "\' where Userid = \'" + UID + "\' and [FQN] = \'" + FQN + "\'";
			SS = SS + "\r\n" + "\r\n" + S;
			B = ExecuteSqlNewConn(S, false);
			if (! B)
			{
				xTrace(93925, "clsDataBase:SetDocumentPublicFlag", "Failed to set public flag in DIRECTORY table.");
				xTrace(93925, "clsDataBase:SetDocumentPublicFlag", S);
			}
			else
			{
				LOG.WriteToArchiveLog((string) ("Info 01 : SetDocPubFlg: " + S));
			}
			
			S = "update [Directory] set [ckPublic] = \'" + sFlag + "\', ckDisableDir = \'" + DisableDir + "\' where Userid = \'" + UID + "\' and [FQN] = \'" + FQN + "\'";
			SS = SS + "\r\n" + "\r\n" + S;
			B = ExecuteSqlNewConn(S, false);
			if (! B)
			{
				xTrace(93925, "clsDataBase:SetDocumentPublicFlag", "Failed to set public flag in DIRECTORY table.");
				xTrace(93925, "clsDataBase:SetDocumentPublicFlag", S);
			}
			else
			{
				LOG.WriteToArchiveLog((string) ("Info 02 : SetDocPubFlg: " + S));
			}
			
			S = "update [Directory] set [OcrDirectory] = \'" + OcrDirectory + "\' where Userid = \'" + UID + "\' and [FQN] = \'" + FQN + "\'";
			SS = SS + "\r\n" + "\r\n" + S;
			B = ExecuteSqlNewConn(S, false);
			if (! B)
			{
				xTrace(93925, "clsDataBase:SetDocumentPublicFlag", "Failed to set public flag in DIRECTORY table.");
				xTrace(93925, "clsDataBase:SetDocumentPublicFlag", S);
			}
			else
			{
				LOG.WriteToArchiveLog((string) ("Info 03 : SetDocPubFlg: " + S));
			}
			
			//*******************************************************
			S = "update [SubDir] set ckPublic = \'" + sFlag + "\', ckDisableDir = \'" + DisableDir + "\' where Userid = \'" + UID + "\' ";
			S = S + " and ([FQN] = \'" + FQN + "\' or [SUBFQN] = \'" + FQN + "\')";
			SS = SS + "\r\n" + "\r\n" + S;
			B = ExecuteSqlNewConn(S, false);
			if (! B)
			{
				xTrace(93926, "clsDataBase:SetDocumentPublicFlag", "Failed to set public flag in SUBDIR table.");
				xTrace(93926, "clsDataBase:SetDocumentPublicFlag", S);
			}
			else
			{
				if (dDebug)
				{
					LOG.WriteToArchiveLog((string) ("Info 04 : SetDocPubFlg: " + S));
				}
			}
			
			S = "update [SubDir] set ckPublic = \'" + sFlag + "\', ckDisableDir = \'" + DisableDir + "\' where Userid = \'" + UID + "\' ";
			S = S + " and ([FQN] = \'" + FQN + "\' or [SUBFQN] = \'" + FQN + "\')";
			SS = SS + "\r\n" + "\r\n" + S;
			B = ExecuteSqlNewConn(S, false);
			if (! B)
			{
				xTrace(93926, "clsDataBase:SetDocumentPublicFlag", "Failed to set public flag in SUBDIR table.");
				xTrace(93926, "clsDataBase:SetDocumentPublicFlag", S);
			}
			else
			{
				if (dDebug)
				{
					LOG.WriteToArchiveLog((string) ("Info 05 : SetDocPubFlg: " + S));
				}
			}
			//*******************************************************
			S = "update [DataSource] set [isPublic] = \'" + sFlag + "\'";
			S = S + " where FileDirectory = \'" + FQN + "\'";
			S = S + " and DataSourceOwnerUserID = \'" + UID + "\'";
			SS = SS + "\r\n" + "\r\n" + S;
			B = ExecuteSqlNewConn(S, false);
			if (! B)
			{
				xTrace(93926, "clsDataBase:SetDocumentPublicFlag", "Failed to set public flag in DataSource table.");
				xTrace(93926, "clsDataBase:SetDocumentPublicFlag", S);
			}
			else
			{
				if (dDebug)
				{
					LOG.WriteToArchiveLog((string) ("Info 06 : SetDocPubFlg: " + S));
				}
			}
			
			S = "update [DataSource] set [isPublic] = \'" + sFlag + "\'";
			S = S + " where FileDirectory = \'" + FQN + "\'";
			S = S + " and DataSourceOwnerUserID = \'" + UID + "\'";
			SS = SS + "\r\n" + "\r\n" + S;
			B = ExecuteSqlNewConn(S, false);
			if (! B)
			{
				xTrace(93926, "clsDataBase:SetDocumentPublicFlag", "Failed to set public flag in DataSource table.");
				xTrace(93926, "clsDataBase:SetDocumentPublicFlag", S);
			}
			else
			{
				if (dDebug)
				{
					LOG.WriteToArchiveLog((string) ("Info 07 : SetDocPubFlg: " + S));
				}
			}
			
		}
		
		public void SetDocumentPublicFlag(string UID, string FQN, bool PublicFlag)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			string S = "";
			string sFlag = "";
			string iFlag = "";
			bool B;
			string DisableDir = "";
			
			if (PublicFlag)
			{
				sFlag = "Y";
				//iFlag  = "1"
			}
			else
			{
				sFlag = "N";
				//iFlag  = "0"
			}
			
			S = "update [Directory] set [ckPublic] = \'" + sFlag + "\' where Userid = \'" + UID + "\' and [FQN] = \'" + FQN + "\'";
			B = ExecuteSqlNewConn(S, false);
			if (! B)
			{
				xTrace(93925, "clsDataBase:SetDocumentPublicFlag", "Failed to set public flag in DIRECTORY table.");
				xTrace(93925, "clsDataBase:SetDocumentPublicFlag", S);
			}
			
			S = "update [SubDir] set ckPublic = \'" + sFlag + "\' where Userid = \'" + UID + "\' ";
			S = S + " and ([FQN] = \'" + FQN + "\' or [SUBFQN] = \'" + FQN + "\')";
			B = ExecuteSqlNewConn(S, false);
			if (! B)
			{
				xTrace(93926, "clsDataBase:SetDocumentPublicFlag", "Failed to set public flag in SUBDIR table.");
				xTrace(93926, "clsDataBase:SetDocumentPublicFlag", S);
			}
			
			S = "update [DataSource] set [isPublic] = \'" + sFlag + "\'";
			S = S + " where FileDirectory = \'" + FQN + "\'";
			S = S + " and DataSourceOwnerUserID = \'" + UID + "\'";
			B = ExecuteSqlNewConn(S, false);
			if (! B)
			{
				xTrace(93926, "clsDataBase:SetDocumentPublicFlag", "Failed to set public flag in DataSource table.");
				xTrace(93926, "clsDataBase:SetDocumentPublicFlag", S);
			}
			
		}
		public int ckMasterAlreadyDefined(string SourceName)
		{
			
			SqlConnection con = new SqlConnection(getGateWayConnStr(modGlobals.gGateWayID));
			con.Open();
			//Dim command As New SqlCommand(s, con)
			SqlDataReader RSData = null;
			
			int cnt = -1;
			
			try
			{
				string tQuery = "";
				
				string S = "Select COUNT(*) from DataSource where SourceName = \'" + SourceName + "\' and isMaster =\'Y\'";
				
				using (con)
				{
					RSData = SqlQry(S, con);
					RSData.Read();
					cnt = RSData.GetInt32(0);
					RSData.Close();
				}
				
			}
			catch (Exception ex)
			{
				xTrace(12360, "clsDataBase:ckMasterAlreadyDefined", ex.Message);
				Console.WriteLine("Error ckMasterAlreadyDefined 3932.11.14: " + ex.Message);
				cnt = 0;
				LOG.WriteToArchiveLog((string) ("clsDatabase : ckMasterAlreadyDefined : 5163 : " + ex.Message));
			}
			finally
			{
				if (! RSData.IsClosed)
				{
					RSData.Close();
				}
				RSData = null;
				//command.Connection.Close()
				//command = Nothing
				if (con.State == ConnectionState.Open)
				{
					con.Close();
				}
				con = null;
				
			}
			
			return cnt;
			
		}
		public void SetDocumentToMaster(string SourceGuid, bool MasterFlag)
		{
			
			string S = "";
			string sFlag = "";
			string iFlag = "";
			bool B;
			string DisableDir = "";
			
			if (MasterFlag)
			{
				sFlag = "Y";
				//iFlag  = "1"
			}
			else
			{
				sFlag = "N";
				//iFlag  = "0"
			}
			
			S = "update [DataSource] set [isMaster] = \'" + sFlag + "\'";
			S = S + " where SourceGuid = \'" + SourceGuid + "\'";
			B = ExecuteSqlNewConn(S, false);
			if (! B)
			{
				xTrace(93926, "clsDataBase:SetDocumentToMaster", "Failed to set public flag in DataSource table.");
				xTrace(93926, "clsDataBase:SetDocumentToMaster", S);
			}
			
		}
		public void SetDocumentPublicFlag(string SourceGuid, bool isPublic)
		{
			
			string S = "";
			string sFlag = "";
			string iFlag = "";
			bool B;
			string DisableDir = "";
			
			if (isPublic)
			{
				sFlag = "Y";
				//iFlag  = "1"
			}
			else
			{
				sFlag = "N";
				//iFlag  = "0"
			}
			
			S = "update [DataSource] set [isPublic] = \'" + sFlag + "\'";
			S = S + " where SourceGuid = \'" + SourceGuid + "\'";
			B = ExecuteSqlNewConn(S, false);
			if (! B)
			{
				xTrace(939288, "clsDataBase:SetDocumentPublicFlag", "Failed to set public flag in DataSource table.");
				xTrace(939288, "clsDataBase:SetDocumentPublicFlag", S);
			}
			
		}
		public void SetEmailPublicFlag(string EmailGuid, bool isPublic)
		{
			
			string S = "";
			string sFlag = "";
			string iFlag = "";
			bool B;
			string DisableDir = "";
			
			if (isPublic)
			{
				sFlag = "Y";
				//iFlag  = "1"
			}
			else
			{
				sFlag = "N";
				//iFlag  = "0"
			}
			
			S = "update [Email] set [isPublic] = \'" + sFlag + "\'";
			S = S + " where EmailGuid = \'" + EmailGuid + "\'";
			B = ExecuteSqlNewConn(S, false);
			if (! B)
			{
				xTrace(939288, "clsDataBase:SetEmailPublicFlag", "Failed to set public flag in Email table.");
				xTrace(939288, "clsDataBase:SetEmailPublicFlag", S);
			}
			
		}
		
		
		public void addImageUsingDataset(string S, string FQN, string SrcTable)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			//Dim da As New SqlDataAdapter("Select SourceImage From SourceImage where SourceGuid = 'SourceGuid' and DataSourceOwnerUserID = 'DataSourceOwnerUserID'", gConn)
			//FQN = "C:\winnt\Gone Fishing.BMP"
			CloseConn();
			CkConn();
			
			SqlDataAdapter da = new SqlDataAdapter(S, gConn);
			SqlCommandBuilder MyCB = new SqlCommandBuilder(da);
			DataSet ds = new DataSet();
			
			da.MissingSchemaAction = MissingSchemaAction.AddWithKey;
			
			FileStream fs = new FileStream(FQN, FileMode.OpenOrCreate, FileAccess.Read);
			byte[] MyData = new byte[(int) fs.Length + 1];
			fs.Read(MyData, 0, (int) fs.Length);
			fs.Close();
			gConn.Open();
			da.Fill(ds, SrcTable);
			DataRow myRow;
			
			myRow = ds.Tables[SrcTable].NewRow();
			myRow["SourceImage"] = MyData;
			
			ds.Tables[SrcTable].Rows.Add(myRow);
			da.Update(ds, SrcTable);
			
			fs = null;
			MyCB = null;
			ds = null;
			da = null;
			
			gConn.Close();
			gConn = null;
			if (modGlobals.gRunUnattended == false)
			{
				MessageBox.Show("Image saved to database");
			}
		}
		
		public void updateImageUsingDataset(string S, string FQN, string SrcTable)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			//Dim da As New SqlDataAdapter("Select SourceImage From SourceImage where SourceGuid = 'SourceGuid' and DataSourceOwnerUserID = 'DataSourceOwnerUserID'", gConn)
			//FQN = "C:\winnt\Gone Fishing.BMP"
			CloseConn();
			CkConn();
			
			SqlDataAdapter da = new SqlDataAdapter(S, gConn);
			SqlCommandBuilder MyCB = new SqlCommandBuilder(da);
			DataSet ds = new DataSet();
			
			da.MissingSchemaAction = MissingSchemaAction.AddWithKey;
			
			FileStream fs = new FileStream(FQN, FileMode.OpenOrCreate, FileAccess.Read);
			byte[] MyData = new byte[(int) fs.Length + 1];
			fs.Read(MyData, 0, (int) fs.Length);
			fs.Close();
			gConn.Open();
			da.Fill(ds, SrcTable);
			DataRow myRow;
			
			//.NewRow()
			myRow = ds.Tables[SrcTable].NewRow();
			myRow["SourceImage"] = MyData;
			
			//.Add(myRow)
			ds.Tables["MyImages"].Rows.Add(myRow);
			da.Update(ds, "MyImages");
			
			fs = null;
			MyCB = null;
			ds = null;
			da = null;
			
			gConn.Close();
			gConn = null;
			if (modGlobals.gRunUnattended == false)
			{
				MessageBox.Show("Image saved to database");
			}
		}
		
		public bool writeImageSourceDataFromDbWriteToFile(string SourceGuid, string FQN, bool OverWrite)
		{
			
			FQN = UTIL.RemoveSingleQuotes(FQN);
			bool B = true;
			string SourceTblName = "DataSource";
			string ImageFieldName = "SourceImage";
			
			try
			{
				string S = "";
				S = S + " SELECT ";
				S = S + " [SourceImage]";
				S = S + " FROM  [DataSource]";
				S = S + " where [SourceGuid] = \'" + SourceGuid + "\'";
				
				SqlConnection CN = new SqlConnection(getGateWayConnStr(modGlobals.gGateWayID));
				
				if (CN.State == ConnectionState.Closed)
				{
					CN.Open();
				}
				
				SqlDataAdapter da = new SqlDataAdapter(S, CN);
				SqlCommandBuilder MyCB = new SqlCommandBuilder(da);
				DataSet ds = new DataSet();
				
				da.Fill(ds, SourceTblName);
				DataRow myRow;
				myRow = ds.Tables[SourceTblName].Rows[0];
				
				byte[] MyData;
				MyData = (byte[]) (myRow[ImageFieldName]);
				
				if (MyData.Length == 0)
				{
					return false;
				}
				
				long K;
				K = MyData.Length - 1;
				try
				{
					FileStream fs = new FileStream(FQN, FileMode.Create, FileAccess.Write);
					//** Liz and Dale try magic
					fs.Write(MyData, 0, (int) (K + 1));
					fs.Close();
					fs = null;
				}
				catch (Exception ex)
				{
					if (modGlobals.gRunUnattended == false)
					{
						MessageBox.Show((string) ("No restore: " + ex.Message));
					}
					if (dDebug)
					{
						Debug.Print(ex.Message);
					}
					xTrace((int) 58342.15, "clsDataBase:imageDataReadFromDbWriteToFile", ex.Message);
					LOG.WriteToArchiveLog((string) ("clsDatabase : writeImageSourceDataFromDbWriteToFile : 4749 : " + ex.Message + "\r\n" + ex.StackTrace));
				}
				
				MyCB = null;
				ds = null;
				da = null;
				
				CN.Close();
				CN = null;
				GC.Collect();
			}
			catch (Exception ex)
			{
				string AppName = ex.Source;
				xTrace((int) 58342.1, "clsDataBase:imageDataReadFromDbWriteToFile", ex.Message);
				LOG.WriteToArchiveLog((string) ("clsDatabase : writeImageSourceDataFromDbWriteToFile : 4757 : " + ex.Message));
			}
			return B;
			
		}
		
		public bool writeAttachmentFromDbWriteToFile(string RowID, string FQN, bool OverWrite)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			bool B = true;
			string SourceTblName = "EmailAttachment";
			string ImageFieldName = "Attachment";
			
			try
			{
				string S = "";
				S = S + " SELECT ";
				S = S + " [Attachment]";
				S = S + " FROM  [EmailAttachment]";
				S = S + " where [RowID] = " + RowID;
				
				SqlConnection CN = new SqlConnection(getGateWayConnStr(modGlobals.gGateWayID));
				
				if (CN.State == ConnectionState.Closed)
				{
					CN.Open();
				}
				
				SqlDataAdapter da = new SqlDataAdapter(S, CN);
				SqlCommandBuilder MyCB = new SqlCommandBuilder(da);
				DataSet ds = new DataSet();
				
				da.Fill(ds, SourceTblName);
				DataRow myRow;
				myRow = ds.Tables[SourceTblName].Rows[0];
				
				byte[] MyData;
				MyData = (byte[]) (myRow[ImageFieldName]);
				long K;
				K = MyData.Length - 1;
				try
				{
					if (OverWrite)
					{
						//If File.Exists(FQN) Then
						//    File.Delete(FQN )
						//End If
					}
					else
					{
						if (File.Exists(FQN))
						{
							return false;
						}
					}
					FileStream fs = new FileStream(FQN, FileMode.Create, FileAccess.Write);
					//** Liz and Dale try magic
					fs.Write(MyData, 0, (int) (K + 1));
					fs.Close();
					fs = null;
				}
				catch (Exception ex)
				{
					if (dDebug)
					{
						Debug.Print(ex.Message);
					}
					xTrace((int) 58342.15, "clsDataBase:imageDataReadFromDbWriteToFile", ex.Message);
					LOG.WriteToArchiveLog((string) ("clsDatabase : writeAttachmentFromDbWriteToFile : 4795 : " + ex.Message));
				}
				
				MyCB = null;
				ds = null;
				da = null;
				
				CN.Close();
				CN = null;
				GC.Collect();
			}
			catch (Exception ex)
			{
				string AppName = ex.Source;
				xTrace((int) 58342.1, "clsDataBase:imageDataReadFromDbWriteToFile", ex.Message);
				LOG.WriteToArchiveLog((string) ("clsDatabase : writeAttachmentFromDbWriteToFile : 4803 : " + ex.Message));
			}
			return B;
			
		}
		
		public void xPopulateComboBox(ComboBox CB, string TblColName, string S)
		{
			try
			{
				CloseConn();
				CkConn();
				if (gConn.State == ConnectionState.Closed)
				{
					gConn.Open();
				}
				SqlDataAdapter DA = new SqlDataAdapter(S, gConn);
				DataSet DS = new DataSet();
				DA.Fill(DS, TblColName);
				
				//Create and populate the DataTable to bind to the ComboBox:
				DataTable dt = new DataTable();
				dt.Columns.Add(TblColName, typeof(System.String));
				
				// Populate the DataTable to bind to the Combobox.
				
				DataRow drNewRow;
				int iRowCnt = 0;
				foreach (DataRow drDSRow in DS.Tables[TblColName].Rows)
				{
					drNewRow = dt.NewRow();
					drNewRow[TblColName] = drDSRow[TblColName];
					dt.Rows.Add(drNewRow);
					iRowCnt++;
				}
				if (iRowCnt == 0)
				{
					return;
				}
				//Bind the DataTable to the ComboBox by setting the Combobox's DataSource property to the DataTable. To display the "Description" column in the Combobox's list, set the Combobox's DisplayMember property to the name of column. Likewise, to use the "Code" column as the value of an item in the Combobox set the ValueMember property.
				CB.DropDownStyle = ComboBoxStyle.DropDown;
				CB.DataSource = dt;
				CB.DisplayMember = TblColName;
				CB.SelectedIndex = 0;
				
				if (DS != null)
				{
					DS = null;
				}
				if (DA != null)
				{
					DA = null;
				}
				if (gConn != null)
				{
					gConn.Close();
					gConn = null;
				}
				
			}
			catch (Exception ex)
			{
				if (dDebug)
				{
					Debug.Print((string) ("Error 2194.23: " + ex.Message));
				}
				LOG.WriteToArchiveLog((string) ("clsDatabase : xPopulateComboBox : 4841 : " + ex.Message));
			}
			finally
			{
				GC.Collect();
				
			}
		}
		public void getEmailRestoreFqnParms(string EmailGuid, ref string Subject, ref string CreationTime, ref string SentOn, ref string MsgSize)
		{
			string S = "";
			S = S + " select Subject, CreationTime, SentOn, MsgSize, EmailGuid";
			S = S + " from Email ";
			S = S + " where EmailGuid = \'" + EmailGuid + "\'";
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					Subject = RSData.GetValue(0).ToString();
					CreationTime = RSData.GetValue(1).ToString();
					SentOn = RSData.GetValue(2).ToString();
					MsgSize = RSData.GetValue(3).ToString();
				}
			}
			RSData.Close();
			RSData = null;
		}
		
		public string getEmailFileRestoreName(string EmailGuid, string WorkingDirectory, string Suffix)
		{
			
			bool SkipExistingFiles = false;
			bool OverwriteExistingFiles = false;
			bool doThisForAllFiles = false;
			bool VersionFiles = false;
			
			string FQN;
			string Subject = "";
			string SourceName = "";
			string CreationTime = "";
			string SentOn = "";
			string MsgSize = "";
			int K = 1;
			
			getEmailRestoreFqnParms(EmailGuid, ref Subject, ref CreationTime, ref SentOn, ref MsgSize);
			if (Subject.Trim().Length == 0)
			{
				Subject = "NO SUBJECT";
			}
			SourceName = Subject + "." + CreationTime + "." + SentOn + "." + MsgSize;
			//** WDM 3/12/2010 SourceName  = DMA.CheckFileName(SourceName )
			UTIL.StripUnwantedChars(ref SourceName);
			
			SourceName += Suffix.ToUpper();
			
			string CH = WorkingDirectory.Substring(WorkingDirectory.Trim().Length - 1, 1);
			if (CH.Equals("\\"))
			{
			}
			else
			{
				WorkingDirectory = WorkingDirectory + "\\";
			}
			
			FQN = WorkingDirectory + SourceName;
			
			File F;
			if (F.Exists(FQN))
			{
				
				//** WDM This section to be incorporated at a later time
				//If doThisForAllFiles = True Then
				//    If SkipExistingFiles = True Then
				
				//    End If
				//    If OverwriteExistingFiles = True Then
				
				//    End If
				
				//    If VersionFiles = True Then
				
				//    End If
				//Else
				//    If SkipExistingFiles = True Then
				
				//    End If
				//    If OverwriteExistingFiles = True Then
				
				//    End If
				
				//    If VersionFiles = True Then
				
				//    End If
				//End If
				
				while (File.Exists(FQN))
				{
					K++;
					
					Subject = Subject.Substring(0, 80);
					Subject = Subject.Trim();
					SourceName = Subject + "." + CreationTime + "." + SentOn + "." + MsgSize + ".Ver" + K.ToString() + Suffix;
					SourceName = DMA.CheckFileName(SourceName);
					CH = WorkingDirectory.Substring(WorkingDirectory.Trim().Length - 1, 1);
					if (CH.Equals("\\"))
					{
					}
					else
					{
						WorkingDirectory = WorkingDirectory + "\\";
					}
					SourceName = DMA.CheckFileName(SourceName);
					FQN = WorkingDirectory + SourceName;
				}
			}
			return FQN;
		}
		
		public bool writeEmailFromDbToFile(string EmailGuid, string WorkingDirectory, string Suffix, double currFileSize)
		{
			
			string FQN = "";
			
			FQN = getEmailFileRestoreName(EmailGuid, WorkingDirectory, Suffix);
			UTIL.RemoveDoubleSlashes(ref FQN);
			bool B = true;
			
			//Dim SourceFqn  = DMA.CheckFileName(FQN)
			
			string SourceTblName = "Email";
			string ImageFieldName = "EmailImage";
			
			try
			{
				//CloseConn()
				CkConn();
				
				string S = "";
				S = S + " SELECT ";
				S = S + " [EmailImage]";
				S = S + " FROM  [Email]";
				S = S + " where [EmailGuid] = \'" + EmailGuid + "\'";
				
				string NewConnStr = getGateWayConnStr(modGlobals.gGateWayID);
				UTIL.ExtendTimeoutBySize(NewConnStr, currFileSize);
				
				SqlConnection CN = new SqlConnection(NewConnStr);
				
				if (CN.State == ConnectionState.Closed)
				{
					CN.Open();
				}
				
				SqlDataAdapter da = new SqlDataAdapter(S, CN);
				SqlCommandBuilder MyCB = new SqlCommandBuilder(da);
				DataSet ds = new DataSet();
				
				da.Fill(ds, SourceTblName);
				DataRow myRow;
				myRow = ds.Tables[SourceTblName].Rows[0];
				
				byte[] MyData;
				MyData = (byte[]) (myRow[ImageFieldName]);
				long K;
				K = MyData.Length - 1;
				
				try
				{
					FileStream fs = new FileStream(FQN, FileMode.CreateNew, FileAccess.Write);
					fs.Write(MyData, 0, (int) (K + 1));
					fs.Close();
					fs = null;
				}
				catch (Exception ex)
				{
					if (dDebug)
					{
						Debug.Print(ex.Message);
					}
					xTrace((int) 42342.15, "clsDataBase:writeEmailFromDbToFile", ex.Message);
					LOG.WriteToArchiveLog((string) ("clsDatabase : writeEmailFromDbToFile : 4871 : " + ex.Message));
					LOG.WriteToArchiveLog((string) ("clsDatabase : writeEmailFromDbToFile : FQN : 4871 : " + FQN));
				}
				
				MyCB = null;
				ds = null;
				da = null;
				
				CN.Close();
				CN = null;
				GC.Collect();
			}
			catch (Exception ex)
			{
				string AppName = ex.Source;
				xTrace((int) 42342.1, "clsDataBase:writeEmailFromDbToFile", ex.Message);
				LOG.WriteToArchiveLog((string) ("clsDatabase : writeEmailFromDbToFile : 4879 : " + ex.Message));
			}
			return B;
			
		}
		
		public void PopulateComboBox(ComboBox CB, string TblColName, string S)
		{
			CB.Items.Clear();
			
			SqlConnection tConn = new SqlConnection(getGateWayConnStr(modGlobals.gGateWayID));
			SqlDataAdapter DA = new SqlDataAdapter(S, tConn);
			DataSet DS = new DataSet();
			
			try
			{
				
				if (tConn.State == ConnectionState.Closed)
				{
					tConn.Open();
				}
				
				DA.Fill(DS, TblColName);
				
				//Create and populate the DataTable to bind to the ComboBox:
				DataTable dt = new DataTable();
				dt.Columns.Add(TblColName, typeof(System.String));
				
				// Populate the DataTable to bind to the Combobox.
				
				DataRow drNewRow;
				int iRowCnt = 0;
				foreach (DataRow drDSRow in DS.Tables[TblColName].Rows)
				{
					drNewRow = dt.NewRow();
					drNewRow[TblColName] = drDSRow[TblColName];
					dt.Rows.Add(drNewRow);
					iRowCnt++;
					string tItem = drDSRow[0].ToString();
					tItem = UTIL.RemoveSingleQuotes(tItem);
					CB.Items.Add(tItem);
				}
				if (iRowCnt == 0)
				{
					return;
				}
				//Bind the DataTable to the ComboBox by setting the Combobox's DataSource property to the DataTable. To display the "Description" column in the Combobox's list, set the Combobox's DisplayMember property to the name of column. Likewise, to use the "Code" column as the value of an item in the Combobox set the ValueMember property.
				CB.DropDownStyle = ComboBoxStyle.DropDown;
				//CB.DataSource = dt
				CB.DisplayMember = TblColName;
				
				try
				{
					if (CB.Items.Count > 0)
					{
						CB.SelectedIndex = 0;
					}
				}
				catch (Exception)
				{
					
				}
				
				
				if (DS != null)
				{
					DS = null;
				}
				if (DA != null)
				{
					DA = null;
				}
				if (tConn != null)
				{
					tConn.Close();
					tConn = null;
				}
				
			}
			catch (Exception ex)
			{
				xTrace(12350, "clsDataBase:PopulateComboBox", ex.Message);
				if (dDebug)
				{
					Debug.Print((string) ("Error 2194.23: " + ex.Message));
				}
				LOG.WriteToArchiveLog((string) ("clsDatabase : PopulateComboBox : 4928.b : " + ex.Message));
			}
			finally
			{
				if (DA != null)
				{
					DA = null;
				}
				if (DS != null)
				{
					DS = null;
				}
				if (tConn != null)
				{
					tConn.Close();
					tConn = null;
				}
				GC.Collect();
				
			}
		}
		public void PopulateComboBoxMerge(ComboBox CB, string TblColName, string S)
		{
			
			SqlConnection tConn = new SqlConnection(getGateWayConnStr(modGlobals.gGateWayID));
			SqlDataAdapter DA = new SqlDataAdapter(S, tConn);
			DataSet DS = new DataSet();
			
			try
			{
				
				if (tConn.State == ConnectionState.Closed)
				{
					tConn.Open();
				}
				
				DA.Fill(DS, TblColName);
				
				//Create and populate the DataTable to bind to the ComboBox:
				DataTable dt = new DataTable();
				dt.Columns.Add(TblColName, typeof(System.String));
				
				// Populate the DataTable to bind to the Combobox.
				
				DataRow drNewRow;
				int iRowCnt = 0;
				foreach (DataRow drDSRow in DS.Tables[TblColName].Rows)
				{
					drNewRow = dt.NewRow();
					drNewRow[TblColName] = drDSRow[TblColName];
					dt.Rows.Add(drNewRow);
					iRowCnt++;
					string tItem = drDSRow[0].ToString();
					tItem = UTIL.RemoveSingleQuotes(tItem);
					bool bAdd = true;
					for (int II = 0; II <= CB.Items.Count - 1; II++)
					{
						if (CB.Items[II].ToString().Equals(tItem))
						{
							bAdd = false;
							break;
						}
					}
					if (bAdd == true)
					{
						CB.Items.Add(tItem);
					}
				}
				if (iRowCnt == 0)
				{
					return;
				}
				//Bind the DataTable to the ComboBox by setting the Combobox's DataSource property to the DataTable. To display the "Description" column in the Combobox's list, set the Combobox's DisplayMember property to the name of column. Likewise, to use the "Code" column as the value of an item in the Combobox set the ValueMember property.
				CB.DropDownStyle = ComboBoxStyle.DropDown;
				//CB.DataSource = dt
				CB.DisplayMember = TblColName;
				try
				{
					if (CB.Items.Count > 0)
					{
						CB.SelectedIndex = 0;
					}
				}
				catch (Exception)
				{
					
				}
				
				
				if (DS != null)
				{
					DS = null;
				}
				if (DA != null)
				{
					DA = null;
				}
				if (tConn != null)
				{
					tConn.Close();
					tConn = null;
				}
				
			}
			catch (Exception ex)
			{
				xTrace(12350, "clsDataBase:PopulateComboBox", ex.Message);
				if (dDebug)
				{
					Debug.Print((string) ("Error 2194.23: " + ex.Message));
				}
				LOG.WriteToArchiveLog((string) ("clsDatabase : PopulateComboBox : 4928.c : " + ex.Message));
			}
			finally
			{
				if (DA != null)
				{
					DA = null;
				}
				if (DS != null)
				{
					DS = null;
				}
				if (tConn != null)
				{
					tConn.Close();
					tConn = null;
				}
				GC.Collect();
				
			}
		}
		public void PopulateListBoxMerge(ListBox LB, string TblColName, string S)
		{
			
			SqlConnection tConn = new SqlConnection(getGateWayConnStr(modGlobals.gGateWayID));
			SqlDataAdapter DA = new SqlDataAdapter(S, tConn);
			DataSet DS = new DataSet();
			
			try
			{
				
				if (tConn.State == ConnectionState.Closed)
				{
					tConn.Open();
				}
				
				DA.Fill(DS, TblColName);
				
				//Create and populate the DataTable to bind to the ComboBox:
				DataTable dt = new DataTable();
				dt.Columns.Add(TblColName, typeof(System.String));
				
				// Populate the DataTable to bind to the Combobox.
				
				DataRow drNewRow;
				int iRowCnt = 0;
				foreach (DataRow drDSRow in DS.Tables[TblColName].Rows)
				{
					drNewRow = dt.NewRow();
					drNewRow[TblColName] = drDSRow[TblColName];
					dt.Rows.Add(drNewRow);
					iRowCnt++;
					string tItem = drDSRow[0].ToString();
					tItem = UTIL.RemoveSingleQuotes(tItem);
					bool bAdd = true;
					for (int II = 0; II <= LB.Items.Count - 1; II++)
					{
						if (LB.Items[II].ToString().Equals(tItem))
						{
							bAdd = false;
							break;
						}
					}
					if (bAdd == true)
					{
						LB.Items.Add(tItem);
					}
				}
				if (iRowCnt == 0)
				{
					return;
				}
				
				LB.DisplayMember = TblColName;
				try
				{
					if (LB.Items.Count > 0)
					{
						LB.SelectedIndex = 0;
					}
				}
				catch (Exception)
				{
					
				}
				
				
				if (DS != null)
				{
					DS = null;
				}
				if (DA != null)
				{
					DA = null;
				}
				if (tConn != null)
				{
					tConn.Close();
					tConn = null;
				}
				
			}
			catch (Exception ex)
			{
				xTrace(12350, "clsDataBase:PopulateComboBox", ex.Message);
				if (dDebug)
				{
					Debug.Print((string) ("Error 2194.23: " + ex.Message));
				}
				LOG.WriteToArchiveLog((string) ("clsDatabase : PopulateComboBox : 4928.d : " + ex.Message));
			}
			finally
			{
				if (DA != null)
				{
					DA = null;
				}
				if (DS != null)
				{
					DS = null;
				}
				if (tConn != null)
				{
					tConn.Close();
					tConn = null;
				}
				GC.Collect();
				
			}
		}
		public void PopulateListBoxRemove(ListBox LB, string TblColName, string S)
		{
			
			SqlConnection tConn = new SqlConnection(getGateWayConnStr(modGlobals.gGateWayID));
			SqlDataAdapter DA = new SqlDataAdapter(S, tConn);
			DataSet DS = new DataSet();
			
			try
			{
				
				if (tConn.State == ConnectionState.Closed)
				{
					tConn.Open();
				}
				
				DA.Fill(DS, TblColName);
				
				//Create and populate the DataTable to bind to the ComboBox:
				DataTable dt = new DataTable();
				dt.Columns.Add(TblColName, typeof(System.String));
				
				// Populate the DataTable to bind to the Combobox.
				
				DataRow drNewRow;
				int iRowCnt = 0;
				foreach (DataRow drDSRow in DS.Tables[TblColName].Rows)
				{
					drNewRow = dt.NewRow();
					drNewRow[TblColName] = drDSRow[TblColName];
					dt.Rows.Add(drNewRow);
					iRowCnt++;
					string tItem = drDSRow[0].ToString();
					tItem = UTIL.RemoveSingleQuotes(tItem);
					bool bAdd = true;
					for (int II = 0; II <= LB.Items.Count - 1; II++)
					{
						if (LB.Items[II].ToString().Equals(tItem))
						{
							LB.Items.RemoveAt(II);
							break;
						}
					}
				}
				if (iRowCnt == 0)
				{
					return;
				}
				
				LB.DisplayMember = TblColName;
				try
				{
					if (LB.Items.Count > 0)
					{
						LB.SelectedIndex = 0;
					}
				}
				catch (Exception)
				{
					
				}
				
				if (DS != null)
				{
					DS = null;
				}
				if (DA != null)
				{
					DA = null;
				}
				if (tConn != null)
				{
					tConn.Close();
					tConn = null;
				}
				
			}
			catch (Exception ex)
			{
				xTrace(12350, "clsDataBase:PopulateComboBox", ex.Message);
				if (dDebug)
				{
					Debug.Print((string) ("Error 2194.23: " + ex.Message));
				}
				LOG.WriteToArchiveLog((string) ("clsDatabase : PopulateComboBox : 4928.a : " + ex.Message));
			}
			finally
			{
				if (DA != null)
				{
					DA = null;
				}
				if (DS != null)
				{
					DS = null;
				}
				if (tConn != null)
				{
					tConn.Close();
					tConn = null;
				}
				GC.Collect();
				
			}
		}
		public void PopulateListBox(ListBox LB, string TblColName, string SelectionSql)
		{
			try
			{
				LB.DataSource = null;
				LB.Items.Clear();
				CloseConn();
				CkConn();
				if (gConn.State == ConnectionState.Closed)
				{
					gConn.Open();
				}
				SqlDataAdapter DA = new SqlDataAdapter(SelectionSql, gConn);
				DataSet DS = new DataSet();
				DA.Fill(DS, TblColName);
				
				//Create and populate the DataTable to bind to the ComboBox:
				DataTable dt = new DataTable();
				dt.Columns.Add(TblColName, typeof(System.String));
				
				// Populate the DataTable to bind to the Combobox.
				
				DataRow drNewRow;
				int iRowCnt = 0;
				foreach (DataRow drDSRow in DS.Tables[TblColName].Rows)
				{
					drNewRow = dt.NewRow();
					drNewRow[TblColName] = drDSRow[TblColName];
					dt.Rows.Add(drNewRow);
					iRowCnt++;
				}
				if (iRowCnt == 0)
				{
					return;
				}
				//Bind the DataTable to the ComboBox by setting the Combobox's DataSource property to the DataTable.
				//To display the "Description" column in the Combobox's list, set the Combobox's DisplayMember property
				//to the name of column. Likewise, to use the "Code" column as the value of an item in the Combobox set
				//the ValueMember property.
				LB.DataSource = dt;
				LB.DisplayMember = TblColName;
				LB.SelectedIndex = 0;
				
				if (DS != null)
				{
					DS = null;
				}
				if (DA != null)
				{
					DA = null;
				}
				if (gConn != null)
				{
					gConn.Close();
					gConn = null;
				}
				
			}
			catch (Exception ex)
			{
				xTrace(12350, "clsDataBase:PopulateListBox", ex.Message);
				if (dDebug)
				{
					Debug.Print((string) ("Error 2194.23: " + ex.Message));
				}
				LOG.WriteToArchiveLog((string) ("clsDatabase : PopulateListBox : 4968 : " + ex.Message));
			}
			finally
			{
				GC.Collect();
				
			}
		}
		
		public void PopulateUserSL(SortedList SL)
		{
			SL.Clear();
			string S = "Select [UserName], [UserID]  FROM [Users] order by [UserName]";
			
			bool b = true;
			int i = 0;
			int id = -1;
			int II = 0;
			string UserName = "";
			string UserID = "";
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					UserName = RSData.GetValue(0).ToString();
					UserID = RSData.GetValue(1).ToString();
					SL.Add(UserID, UserName);
				}
			}
			else
			{
				id = -1;
			}
			RSData.Close();
			RSData = null;
		}
		
		public string getDatasourceParm(string AttributeName, string SourceGuid)
		{
			
			//Select AttributeValue
			//  FROM [SourceAttribute]
			//where AttributeName = 'Author'
			//and SourceGuid = '6ff1c120-66cd-4aac-b2ec-85dda9f48bc8'
			//go
			
			string S = "";
			bool b = true;
			int i = 0;
			int id = -1;
			int II = 0;
			string UserName = "";
			string UserID = "";
			string ColVAl = "";
			
			S = "Select AttributeValue ";
			S = S + " FROM [SourceAttribute]";
			S = S + " where AttributeName = \'" + AttributeName + "\'";
			S = S + " and SourceGuid = \'" + SourceGuid + "\'";
			
			//Dim dDebug As Boolean = False
			//Dim queryString As String = Sql
			//Dim rc As Boolean = False
			SqlDataReader rsDataQry = null;
			SqlConnection CN = new SqlConnection(getGateWayConnStr(modGlobals.gGateWayID));
			
			if (CN.State == ConnectionState.Closed)
			{
				CN.Open();
			}
			
			SqlCommand command = new SqlCommand(S, CN);
			
			try
			{
				rsDataQry = command.ExecuteReader();
				if (rsDataQry.HasRows)
				{
					while (rsDataQry.Read())
					{
						ColVAl = rsDataQry.GetValue(0).ToString();
					}
				}
				else
				{
					ColVAl = "";
				}
			}
			catch (Exception ex)
			{
				xTrace(1001, "clsDataBase:getDatasourceParm", ex.Message);
				xTrace(1002, "clsDataBase:getDatasourceParm", ex.StackTrace);
				xTrace(1003, "clsDataBase:getDatasourceParm", S);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getDatasourceParm : 5019 : " + ex.Message));
			}
			
			if (CN.State == ConnectionState.Open)
			{
				CN.Close();
			}
			
			CN = null;
			command.Dispose();
			command = null;
			rsDataQry.Close();
			rsDataQry = null;
			return ColVAl;
			
		}
		public string getTblColString(string S)
		{
			
			//Select AttributeValue
			//  FROM [SourceAttribute]
			//where AttributeName = 'Author'
			//and SourceGuid = '6ff1c120-66cd-4aac-b2ec-85dda9f48bc8'
			//go
			
			
			bool b = true;
			int i = 0;
			int id = -1;
			int II = 0;
			string UserName = "";
			string UserID = "";
			string ColVAl = "";
			
			
			
			//Dim dDebug As Boolean = False
			//Dim queryString As String = Sql
			//Dim rc As Boolean = False
			SqlDataReader rsDataQry = null;
			SqlConnection CN = new SqlConnection(getGateWayConnStr(modGlobals.gGateWayID));
			
			if (CN.State == ConnectionState.Closed)
			{
				CN.Open();
			}
			
			SqlCommand command = new SqlCommand(S, CN);
			
			try
			{
				rsDataQry = command.ExecuteReader();
				if (rsDataQry.HasRows)
				{
					while (rsDataQry.Read())
					{
						ColVAl = rsDataQry.GetValue(0).ToString();
					}
				}
				else
				{
					ColVAl = "";
				}
			}
			catch (Exception ex)
			{
				xTrace(1001, "clsDataBase:getTblColString", ex.Message);
				xTrace(1002, "clsDataBase:getTblColString", ex.StackTrace);
				xTrace(1003, "clsDataBase:getTblColString", S);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getTblColString : 5019 : " + ex.Message));
			}
			
			if (CN.State == ConnectionState.Open)
			{
				CN.Close();
			}
			
			CN = null;
			command.Dispose();
			command = null;
			rsDataQry.Close();
			rsDataQry = null;
			return ColVAl;
			
		}
		public string getSavedValue(string userid, string SaveName, string SaveTypeCode, string ValName)
		{
			string S = "";
			bool b = true;
			int i = 0;
			int id = -1;
			int II = 0;
			string UserName = "";
			string ColVAl = "";
			
			S = S + " Select [ValName]";
			S = S + " ,[ValValue]";
			S = S + " FROM [SavedItems]";
			S = S + " where userid = \'" + userid + "\'";
			S = S + " and SaveName = \'" + SaveName + "\'";
			S = S + " and SaveTypeCode = \'" + SaveTypeCode + "\'";
			S = S + " and ValName = \'" + ValName + "\'";
			
			SqlDataReader RSData = null;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					ColVAl = RSData.GetValue(1).ToString();
					ColVAl = ColVAl.Trim();
					ColVAl = UTIL.RemoveSingleQuotes(ColVAl);
				}
			}
			else
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase : getSavedValue : Error 0000 : Did not find library item: " + SaveName + " : " + SaveTypeCode + " : " + ValName));
				ColVAl = "";
			}
			RSData.Close();
			RSData = null;
			
			if (ColVAl.ToLower().Equals("null"))
			{
				ColVAl = "";
			}
			
			return ColVAl;
			
		}
		
		public string getLastSuccessfulArchiveDate(string ArchiveType, string UserID)
		{
			
			string S = "Select  max(archiveEndDate)";
			S = S + " FROM  [ArchiveStats]";
			S = S + " where ";
			S = S + " [ArchiveType] = \'" + ArchiveType + "\'";
			S = S + " and [UserID] = \'" + UserID + "\'";
			S = S + " and Status = \'Successful\'";
			
			string ColVAl = "";
			
			SqlDataReader RSData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					ColVAl = RSData.GetValue(0).ToString();
					ColVAl = ColVAl.Trim();
					ColVAl = UTIL.RemoveSingleQuotes(ColVAl);
				}
			}
			else
			{
				ColVAl = "";
			}
			//RSData.Close()
			//RSData = Nothing
			
			if (ColVAl.ToLower().Equals("null"))
			{
				ColVAl = "";
			}
			
			DateTime d1;
			
			if (ColVAl.Trim().Length == 0)
			{
				//d1 = CDate("01/01/1900")
				d1 = null;
			}
			else
			{
				d1 = DateTime.Parse(ColVAl);
			}
			
			if (! RSData.IsClosed)
			{
				RSData.Close();
			}
			RSData = null;
			command.Dispose();
			command = null;
			
			if (CONN.State == ConnectionState.Open)
			{
				CONN.Close();
			}
			CONN.Dispose();
			
			return d1.ToString();
			
		}
		
		public int ckUserStartUpParameter(string Userid, string ValName)
		{
			
			//        where [SaveName] = 'UserStartUpParameters'
			//and [SaveTypeCode] = 'StartUpParm'
			//and ValName = 'Temp Directory'
			//and userid = 'smiller'
			
			string S = "";
			S = S + " where [SaveName] = \'UserStartUpParameters\'";
			S = S + " and [SaveTypeCode] = \'StartUpParm\'";
			S = S + " and ValName = \'" + ValName + "\'";
			S = S + " and userid = \'" + Userid + "\'";
			int B = iGetRowCount("SavedItems", S);
			
			return B;
			
		}
		
		public string getWorkingDirectory(string Userid, string ValName)
		{
			string ColVAl = "";
			string S = "";
			
			try
			{
				S = S + "Select [ValValue]";
				S = S + " FROM [SavedItems]";
				S = S + " where [SaveName] = \'UserStartUpParameters\'";
				S = S + " and [SaveTypeCode] = \'StartUpParm\'";
				S = S + " and ValName = \'" + ValName + "\'";
				S = S + " and userid = \'" + Userid + "\'";
				
				
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						ColVAl = RSData.GetValue(0).ToString();
						ColVAl = ColVAl.Trim();
						ColVAl = UTIL.RemoveSingleQuotes(ColVAl);
					}
				}
				else
				{
					ColVAl = "";
				}
				RSData.Close();
				RSData = null;
				
				if (ColVAl.ToLower().Equals("null"))
				{
					ColVAl = "";
				}
				
				if (ValName == "CONTENT WORKING DIRECTORY")
				{
					if (ColVAl.Length > 0)
					{
						if (! System.IO.Directory.Exists(ColVAl))
						{
							ColVAl = System.IO.Path.GetTempPath();
						}
					}
				}
				else if (ValName == "EMAIL WORKING DIRECTORY")
				{
					if (ColVAl.Length > 0)
					{
						if (! System.IO.Directory.Exists(ColVAl))
						{
							ColVAl = System.IO.Path.GetTempPath();
						}
					}
				}
				else if (ValName == "DB WARNING LEVEL")
				{
					if (ColVAl.Length == 0)
					{
						ColVAl = "250";
					}
				}
				else if (ValName == "DB RETURN INCREMENT")
				{
					if (ColVAl.Length == 0)
					{
						ColVAl = "100";
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR clsDatabase:getWorkingDirectory 100 - " + ex.Message + "\r\n" + ex.StackTrace));
			}
			
			return ColVAl;
			
		}
		
		public int iCountNbrEmailAttachments(string EMailGuid)
		{
			
			SqlConnection con = new SqlConnection(getGateWayConnStr(modGlobals.gGateWayID));
			con.Open();
			//Dim command As New SqlCommand(s, con)
			SqlDataReader RSData = null;
			
			int cnt = -1;
			
			try
			{
				string tQuery = "";
				string s = "";
				
				s = "Select count(*) as TheCount From EmailAttachment where EmailGuid = \'" + EMailGuid + "\'";
				
				using (con)
				{
					RSData = SqlQry(s, con);
					RSData.Read();
					cnt = RSData.GetInt32(0);
					RSData.Close();
				}
				
			}
			catch (Exception ex)
			{
				xTrace(12360, "clsDataBase:iCountNbrEmailAttachments", ex.Message);
				if (dDebug)
				{
					Debug.Print((string) ("Error 3932.11.13: " + ex.Message));
				}
				Console.WriteLine("Error 3932.11.13: " + ex.Message);
				cnt = 0;
				LOG.WriteToArchiveLog((string) ("clsDatabase : iCountNbrEmailAttachments : 5163 : " + ex.Message));
			}
			finally
			{
				if (! RSData.IsClosed)
				{
					RSData.Close();
				}
				RSData = null;
				//command.Connection.Close()
				//command = Nothing
				if (con.State == ConnectionState.Open)
				{
					con.Close();
				}
				con = null;
				
			}
			
			return cnt;
			
		}
		
		public void DefineFileExt(ref List<string> LB)
		{
			string ColVAl = "";
			string S = "";
			S = S + " SELECT distinct [OriginalFileType]";
			S = S + " FROM DataSource";
			S = S + " order by OriginalFileType";
			
			SqlDataReader RSData = null;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					ColVAl = RSData.GetValue(0).ToString();
					ColVAl = ColVAl.Trim();
					ColVAl = UTIL.RemoveSingleQuotes(ColVAl);
					DMA.ListRegistryKeys(ColVAl, LB);
				}
			}
			
		}
		
		public bool UpdateBlob(string TblName, string ImageColumnName, string WhereClause, string FQN)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			bool b = false;
			try
			{
				string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection connection = new SqlConnection(ConnStr);
				
				SqlCommand command = new SqlCommand((string) ("UPDATE " + TblName + " SET " + ImageColumnName + " = @FileContents " + WhereClause), connection);
				command.Parameters.Add("@FileContents", SqlDbType.VarBinary).Value = System.IO.File.ReadAllBytes(FQN);
				connection.Open();
				command.ExecuteNonQuery();
				connection.Close();
				b = true;
			}
			catch (Exception ex)
			{
				xTrace(12365, "clsDataBase:UpdateBlob", ex.Message);
				b = false;
				LOG.WriteToArchiveLog((string) ("clsDatabase : UpdateBlob : 5190 : " + ex.Message));
			}
			return b;
		}
		
		public void RebuildFulltextCatalog()
		{
			string S = "";
			S = "EXEC sp_fulltext_catalog \'ftCatalog\', \'start_full\' ";
			ExecuteSqlNewConn(S, false);
			S = "EXEC sp_fulltext_catalog \'EMAIL_CATELOG\', \'start_full\' ";
			ExecuteSqlNewConn(S, false);
		}
		
		public bool isAdmin(string Userid)
		{
			bool B = false;
			
			string ColVAl = "";
			string S = "Select [Admin] FROM [Users] where userid = \'" + modGlobals.gCurrUserGuidID + "\'";
			
			SqlDataReader RSData = null;
			//Dim CS  = getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata= command.ExecuteReader()
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			
			
			if (RSData.HasRows)
			{
				RSData.Read();
				ColVAl = RSData.GetValue(0).ToString();
				ColVAl = ColVAl.Trim();
				if (ColVAl.Equals("True"))
				{
					B = true;
				}
				if (ColVAl.Equals("0"))
				{
					B = false;
				}
				if (ColVAl.Equals("1"))
				{
					B = true;
				}
				if (ColVAl.Equals(""))
				{
					B = false;
				}
				if (ColVAl.Equals("Y"))
				{
					B = true;
				}
				if (ColVAl.Equals("N"))
				{
					B = false;
				}
				if (ColVAl.Equals("A"))
				{
					B = true;
				}
				if (ColVAl.Equals("S"))
				{
					B = true;
				}
				if (ColVAl.Equals("G"))
				{
					B = false;
				}
			}
			
			if (! RSData.IsClosed)
			{
				RSData.Close();
			}
			RSData = null;
			command.Dispose();
			command = null;
			
			if (CONN.State == ConnectionState.Open)
			{
				CONN.Close();
			}
			CONN.Dispose();
			
			return B;
		}
		public bool isGlobalSearcher(string Userid)
		{
			bool B = false;
			
			string ColVAl = "";
			string S = "Select [Admin] FROM [Users] where userid = \'" + Userid + "\'";
			
			SqlDataReader RSData = null;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				RSData.Read();
				ColVAl = RSData.GetValue(0).ToString();
				ColVAl = ColVAl.Trim();
				if (ColVAl.Equals("G") || ColVAl.Equals("A") || ColVAl.Equals("S"))
				{
					B = true;
				}
			}
			return B;
		}
		public bool isSuperAdmin(string Userid)
		{
			bool B = false;
			
			string ColVAl = "";
			string S = "Select [Admin] FROM [Users] where userid = \'" + Userid + "\'";
			
			SqlDataReader RSData = null;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				RSData.Read();
				ColVAl = RSData.GetValue(0).ToString();
				ColVAl = ColVAl.Trim();
				if (ColVAl.Equals("S"))
				{
					B = true;
				}
			}
			return B;
		}
		
		public bool isImageFile(string tFileType)
		{
			
			
			if (tFileType.IndexOf("\\") + 1 > 0)
			{
				tFileType = DMA.getFileExtension(tFileType);
			}
			
			bool B = false;
			
			B = ckOcrNeeded(tFileType);
			if (B)
			{
				return true;
			}
			
			int I = 0;
			string S = "Select count(*) FROM [ImageTypeCodes] where [ImageTypeCode] = \'" + tFileType + "\'";
			
			SqlDataReader RSData = null;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				RSData.Read();
				I = RSData.GetInt32(0);
				if (I > 0)
				{
					B = true;
				}
				else
				{
					B = false;
				}
			}
			return B;
		}
		
		public int getEmailSize(string EmailGuid)
		{
			
			int I = 0;
			bool B = false;
			string S = "Select msgsize from Email where EmailGuid = \'" + EmailGuid + "\'";
			SqlDataReader RSData = null;
			
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					I = RSData.GetInt32(0);
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("getEmailSize - Warning: email - no msgsize found: " + ex.Message));
				I = 0;
			}
			finally
			{
				CloseConn();
				RSData.Close();
				RSData = null;
			}
			
			return I;
		}
		public string getDirGuid(string DirFQN, string MachineName)
		{
			
			DirFQN = UTIL.RemoveSingleQuotes(DirFQN);
			
			bool B = false;
			string tGuid = "";
			string S = "";
			S = " SELECT [DirGuid] FROM [DirectoryGuids] where [DirFQN]   = \'" + DirFQN + "\' ";
			
			SqlDataReader RSData = null;
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					tGuid = RSData.GetValue(0).ToString();
				}
				else
				{
					tGuid = Guid.NewGuid().ToString();
					S = "Insert into DirectoryGuids (DirFQN,DirGuid) values (\'" + DirFQN + "\',\'" + tGuid + "\') ";
					bool BB = ExecuteSqlNewConn(S);
					if (BB == false)
					{
						tGuid = "";
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR getDirGuid - : " + ex.Message));
			}
			finally
			{
				CloseConn();
				RSData.Close();
				RSData = null;
			}
			return tGuid;
		}
		
		public string getDirListenerNameByGuid(string DirGuid)
		{
			
			bool B = false;
			string DirName = "";
			string S = "";
			S = " SELECT [DirFqn] FROM [DirectoryGuids] where [DirGuid]   = \'" + DirGuid + "\' ";
			
			SqlDataReader RSData = null;
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					DirName = RSData.GetValue(0).ToString();
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR getDirListenerNameByGuid - Warning: : " + ex.Message));
			}
			finally
			{
				CloseConn();
				RSData.Close();
				RSData = null;
			}
			return DirName;
		}
		
		public string getDescription(string SourceGuid)
		{
			bool B = false;
			string sData = "";
			string S = "Select Description from DataSource where SourceGuid = \'" + SourceGuid + "\'";
			SqlDataReader RSData = null;
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					sData = RSData.GetValue(0).ToString();
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("getDocSize - Warning: email - no msgsize found: " + ex.Message));
			}
			finally
			{
				CloseConn();
				RSData.Close();
				RSData = null;
			}
			
			sData = UTIL.RemoveSingleQuotes(sData);
			
			return sData;
		}
		
		public string getSdCols(string ConnstrName, string TableName)
		{
			
			ConnstrName = UTIL.RemoveSingleQuotes(ConnstrName);
			TableName = UTIL.RemoveSingleQuotes(TableName);
			
			bool B = false;
			string sData = "";
			string S = "Select [SelectedColumns] FROM [ConnectionStringsSaved] where ConnstrName  = \'" + ConnstrName + "\' and TableName = \'" + TableName + "\' ";
			SqlDataReader RSData = null;
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					sData = RSData.GetValue(0).ToString();
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("getDocSize - Warning: email - no msgsize found: " + ex.Message));
			}
			finally
			{
				CloseConn();
				RSData.Close();
				RSData = null;
			}
			
			sData = UTIL.RemoveSingleQuotes(sData);
			
			return sData;
		}
		public string RefactorUserid(string FromUserid, string ToUserid)
		{
			
			string Msg = "";
			
			SqlConnection myConnection = new SqlConnection("Data Source=localhost;Initial Catalog=Northwind;uid=sa;pwd=sa;");
			myConnection.Open();
			
			var myTrans = myConnection.BeginTransaction();
			SqlCommand myCommand = new SqlCommand();
			myCommand.Connection = myConnection;
			myCommand.Transaction = myTrans;
			try
			{
				myCommand.CommandText = "Insert into Region (RegionID, RegionDescription) VALUES (100, \'Description\')";
				myCommand.ExecuteNonQuery();
				myCommand.CommandText = "delete * from Region where RegionID=101";
				myCommand.ExecuteNonQuery();
				myTrans.Commit();
				Msg = "The userid was successfully changed from " + FromUserid + " to " + ToUserid + " throughout the entire repository for both content and emails.";
			}
			catch (Exception ep)
			{
				myTrans.Rollback();
				Msg = "ERROR: The userid Failed to change from " + FromUserid + " to " + ToUserid + ". All transactions rolled back to original state.";
				LOG.WriteToArchiveLog((string) ("clsDatabase : RefactorUserid : 5255 : " + ep.Message));
			}
			finally
			{
				myConnection.Close();
				
			}
			return Msg;
		}
		
		public string getPw(string UID)
		{
			
			string ColVAl = "";
			string S = "Select [UserPassword] FROM  [Users] where UserLoginID = \'" + UID + "\'";
			
			SqlDataReader RSData = null;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				RSData.Read();
				ColVAl = RSData.GetValue(0).ToString();
				ColVAl = ColVAl.Trim();
			}
			return ColVAl;
		}
		
		public int iCountUserContent(string UID)
		{
			string S = "Select count(*) from DataSource where DataSourceOwnerUserID = \'" + UID + "\'";
			
			int cnt = 0;
			CloseConn();
			CkConn();
			try
			{
				using (gConn)
				{
					
					SqlDataReader RSData = null;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					RSData = command.ExecuteReader();
					RSData.Read();
					cnt = RSData.GetInt32(0);
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				
			}
			catch (Exception ex)
			{
				xTrace(12370, "clsDataBase:iCountUserContent", ex.Message);
				LOG.WriteToArchiveLog((string) ("clsDatabase : iCountUserContent : 5280 : " + ex.Message));
			}
			
			return cnt;
		}
		
		public int iCountUserEmails(string UID)
		{
			string S = "Select count(*) from email where Userid = \'" + UID + "\'";
			
			int cnt = 0;
			CloseConn();
			CkConn();
			try
			{
				using (gConn)
				{
					
					SqlDataReader RSData = null;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					RSData = command.ExecuteReader();
					RSData.Read();
					cnt = RSData.GetInt32(0);
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				
			}
			catch (Exception ex)
			{
				xTrace(12371, "clsDataBase:iCountUserEmails", ex.Message);
				LOG.WriteToArchiveLog((string) ("clsDatabase : iCountUserEmails : 5296 : " + ex.Message));
			}
			
			return cnt;
		}
		
		public string SaveErrMsg(string ErrMsg, string ErrStack, string IDNBR, string ConnectiveGuid)
		{
			
			clsDatabase DB = new clsDatabase();
			string rc = "";
			string SQL = "";
			
			string ConnectionString = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CN = new SqlConnection(ConnectionString);
			
			try
			{
				if (CN.State == ConnectionState.Closed)
				{
					CN.Open();
				}
				
				ErrMsg = UTIL.RemoveSingleQuotes(ErrMsg);
				ErrStack = UTIL.RemoveSingleQuotes(ErrStack);
				
				string S = "INSERT INTO [RuntimeErrors] ";
				S = S + "([ErrorMsg]";
				S = S + ",[StackTrace]";
				S = S + ",IdNbr, ConnectiveGuid, Userid)";
				S = S + "VALUES ";
				S = S + "(\'" + ErrMsg + "\'";
				S = S + ",\'" + ErrStack + "\'";
				S = S + ",\'" + IDNBR + "\' ";
				S = S + ",\'" + ConnectiveGuid + "\' ";
				S = S + ",\'" + modGlobals.gCurrUserGuidID + "\')";
				
				using (CN)
				{
					SqlCommand dbCmd = CN.CreateCommand();
					dbCmd.Connection = CN;
					try
					{
						dbCmd.CommandText = S;
						dbCmd.ExecuteNonQuery();
						// Attempt to commit the transaction.
						//transaction.Commit()
						
						//Dim debug As Boolean = True
						//If debug Then
						//    Console.WriteLine("Successful execution: " + vbCrLf + S )
						//End If
						rc = true.ToString();
					}
					catch (Exception ex)
					{
						rc = (string) ("SaveErrMsg" + "\r\n" + ex.Message + "\r\n" + "\r\n" + ex.StackTrace);
						LOG.WriteToArchiveLog((string) ("clsDatabase : SaveErrMsg : 5325 : " + ex.Message));
					}
					if (CN.State == System.Data.ConnectionState.Open)
					{
						CN.Close();
					}
					if (CN != null)
					{
						CN = null;
					}
					if (dbCmd == null)
					{
						dbCmd = null;
					}
				}
				
				
			}
			catch (Exception ex)
			{
				rc = (string) ("SaveErrMsg" + "\r\n" + ex.Message + "\r\n" + "\r\n" + ex.StackTrace);
				LOG.WriteToArchiveLog((string) ("clsDatabase : SaveErrMsg : 5336 : " + ex.Message));
			}
			
			//If CN.State = Data.ConnectionState.Open Then
			//    CN.Close()
			//End If
			//If Not CN Is Nothing Then
			//    CN = Nothing
			//End If
			
			return rc;
			
		}
		
		public void getMissingVaules(string tGuid, ref string VersionNbr, ref string LastAccessDate, ref string LastWriteTime, ref string RetentionExpirationDate, ref string IsPublic)
		{
			string S = " SELECt  [VersionNbr]";
			S = S + " ,[LastAccessDate]      ";
			S = S + " ,[LastWriteTime]";
			S = S + " ,[RetentionExpirationDate]";
			S = S + " ,[IsPublic]";
			S = S + " FROM DataSource";
			S = S + " where [SourceGuid] = \'" + tGuid + "\' ";
			
			int cnt = 0;
			CloseConn();
			CkConn();
			try
			{
				using (gConn)
				{
					
					SqlDataReader RSData = null;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					RSData = command.ExecuteReader();
					RSData.Read();
					VersionNbr = RSData.GetValue(0).ToString();
					LastAccessDate = RSData.GetValue(1).ToString();
					LastWriteTime = RSData.GetValue(2).ToString();
					RetentionExpirationDate = RSData.GetValue(3).ToString();
					IsPublic = RSData.GetValue(4).ToString();
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				
			}
			catch (Exception ex)
			{
				xTrace(9001, "clsDataBase:getMissingVaules", ex.Message);
				xTrace(9002, "clsDataBase:getMissingVaules", S);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getMissingVaules : 5363 : " + ex.Message));
			}
			
		}
		
		public void getMissingEmailVaules(string tGuid, ref string RetentionExpirationDate, ref string IsPublic)
		{
			string S = " SELECT [isPublic],[RetentionExpirationDate] FROM [Email] where [EmailGuid] = \'" + tGuid + "\'";
			
			int cnt = 0;
			CloseConn();
			CkConn();
			try
			{
				using (gConn)
				{
					
					SqlDataReader RSData = null;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					RSData = command.ExecuteReader();
					RSData.Read();
					IsPublic = RSData.GetValue(0).ToString();
					RetentionExpirationDate = RSData.GetValue(1).ToString();
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				
			}
			catch (Exception ex)
			{
				xTrace(92301, "clsDataBase:getMissingEmailVaules", ex.Message);
				xTrace(92302, "clsDataBase:getMissingEmailVaules", S);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getMissingEmailVaules : 5381 : " + ex.Message));
			}
			
		}
		
		public string getMetaData(string tGuid)
		{
			
			string S = "";
			S = S + " SELECT [AttributeValue], [AttributeName] ";
			S = S + " FROM  [SourceAttribute]";
			S = S + " where [SourceGuid] = \'" + tGuid + "\' ";
			S = S + " order by [AttributeName]";
			
			string Msg = "";
			
			int cnt = 0;
			CloseConn();
			CkConn();
			try
			{
				using (gConn)
				{
					
					SqlDataReader RSData = null;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					RSData = command.ExecuteReader();
					if (RSData.HasRows)
					{
						while (RSData.Read())
						{
							string AttributeValue = (string) (RSData.GetValue(0).ToString() + " ... " + "\r\n");
							string AttributeName = (string) (RSData.GetValue(1).ToString() + " ... " + "\r\n");
							Msg += AttributeName + ":" + AttributeValue + "\r\n";
						}
					}
					
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				
			}
			catch (Exception ex)
			{
				xTrace(10101, "clsDataBase:getMetaData", ex.Message);
				xTrace(10102, "clsDataBase:getMetaData", S);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getMetaData : 5406 : " + ex.Message));
			}
			return Msg;
		}
		
		public string getSystemParm(string SysParm)
		{
			
			SysParm = UTIL.RemoveSingleQuotes(SysParm);
			
			string S = "";
			S = S + " SELECT [SysParmVal] FROM [SystemParms] where [SysParm] = \'" + SysParm + "\' ";
			
			string SystemParameter = "";
			
			int cnt = 0;
			CloseConn();
			CkConn();
			try
			{
				using (gConn)
				{
					
					SqlDataReader RSData = null;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					RSData = command.ExecuteReader();
					if (RSData.HasRows)
					{
						while (RSData.Read())
						{
							SystemParameter = RSData.GetValue(0).ToString();
						}
					}
					
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				
			}
			catch (Exception ex)
			{
				xTrace(10101, "clsDataBase:getSystemParm", ex.Message);
				xTrace(10102, "clsDataBase:getSystemParm", S);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getSystemParm : 5406 : " + ex.Message));
			}
			return SystemParameter;
		}
		
		public string getUserParm(string UserParm)
		{
			if (modGlobals.gCurrUserGuidID.Length == 0)
			{
				return "0";
			}
			UserParm = UTIL.RemoveSingleQuotes(UserParm);
			
			string S = "Select ParmValue from [RunParms] where Parm = \'" + UserParm + "\' and userid = \'" + modGlobals.gCurrUserGuidID + "\'";
			string SystemParameter = "";
			
			int cnt = 0;
			CloseConn();
			CkConn();
			try
			{
				using (gConn)
				{
					
					SqlDataReader RSData = null;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					RSData = command.ExecuteReader();
					if (RSData.HasRows)
					{
						while (RSData.Read())
						{
							SystemParameter = RSData.GetValue(0).ToString();
						}
					}
					
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				
			}
			catch (Exception ex)
			{
				xTrace(10101, "clsDataBase:getUserParm", ex.Message);
				xTrace(10102, "clsDataBase:getUserParm", S);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getUserParm : 5406 : " + ex.Message));
			}
			return SystemParameter;
		}
		
		public string getUserParm(string UserParm, string DefaultValue)
		{
			if (modGlobals.gCurrUserGuidID.Length == 0)
			{
				return "0";
			}
			UserParm = UTIL.RemoveSingleQuotes(UserParm);
			
			string S = "Select ParmValue from [RunParms] where Parm = \'" + UserParm + "\' and userid = \'" + modGlobals.gCurrUserGuidID + "\'";
			string SystemParameter = "";
			
			int cnt = 0;
			CloseConn();
			CkConn();
			try
			{
				using (gConn)
				{
					
					SqlDataReader RSData = null;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					RSData = command.ExecuteReader();
					if (RSData.HasRows)
					{
						while (RSData.Read())
						{
							SystemParameter = RSData.GetValue(0).ToString();
						}
					}
					
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				
			}
			catch (Exception ex)
			{
				xTrace(10101, "clsDataBase:getUserParm", ex.Message);
				xTrace(10102, "clsDataBase:getUserParm", S);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getUserParm : 5406 : " + ex.Message));
			}
			return SystemParameter;
		}
		
		public void getContentColumns(string SourceGuid, ref SortedList SL)
		{
			string S = "";
			S = S + " SELECT  ";
			S = S + " [CreateDate]()";
			S = S + " ,[SourceName]";
			S = S + " ,[SourceTypeCode]";
			S = S + " ,[FQN]";
			S = S + " ,[VersionNbr]";
			S = S + " ,[LastAccessDate]";
			S = S + " ,[FileLength]";
			S = S + " ,[LastWriteTime]";
			S = S + " ,[UserID]";
			S = S + " ,[DataSourceOwnerUserID]";
			S = S + " ,[isPublic]";
			S = S + " ,[FileDirectory]";
			S = S + " ,[OriginalFileType]";
			S = S + " ,[RetentionExpirationDate]";
			S = S + " ,[IsPublicPreviousState]";
			S = S + " ,[isAvailable]";
			S = S + " ,[isContainedWithinZipFile]";
			S = S + " ,[ZipFileGuid]";
			S = S + " ,[IsZipFile]";
			S = S + " ,[DataVerified]";
			S = S + " FROM([DataSource])";
			S = S + " where [SourceGuid] = \'" + SourceGuid + "\'";
			
			CloseConn();
			CkConn();
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			SL.Clear();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					SL.Clear();
					int iCols = RSData.FieldCount - 1;
					for (iCols = 0; iCols <= RSData.FieldCount - 1; iCols++)
					{
						FillSortedList(RSData, iCols, SL);
					}
				}
			}
			else
			{
				SL.Clear();
			}
			RSData.Close();
			RSData = null;
			
		}
		
		public void getEmailColumns(string SourceGuid, ref SortedList SL)
		{
			string S = "";
			S = S + " SELECT  ";
			S = S + " [EmailGuid]";
			S = S + " ,[SUBJECT]";
			S = S + " ,[SentTO]";
			S = S + " ,[Body]";
			S = S + " ,[Bcc]";
			S = S + " ,[BillingInformation]";
			S = S + " ,[CC]";
			S = S + " ,[Companies]";
			S = S + " ,[CreationTime]";
			S = S + " ,[ReadReceiptRequested]";
			S = S + " ,[ReceivedByName]";
			S = S + " ,[ReceivedTime]";
			S = S + " ,[AllRecipients]";
			S = S + " ,[UserID]";
			S = S + " ,[SenderEmailAddress]";
			S = S + " ,[SenderName]";
			S = S + " ,[Sensitivity]";
			S = S + " ,[SentOn]";
			S = S + " ,[MsgSize]";
			S = S + " ,[DeferredDeliveryTime]";
			S = S + " ,[EntryID]";
			S = S + " ,[ExpiryTime]";
			S = S + " ,[LastModificationTime]";
			S = S + " ,[EmailImage]";
			S = S + " ,[Accounts]";
			S = S + " ,[RowID]";
			S = S + " ,[ShortSubj]";
			S = S + " ,[SourceTypeCode]";
			S = S + " ,[OriginalFolder]";
			S = S + " ,[StoreID]";
			S = S + " ,[isPublic]";
			S = S + " ,[RetentionExpirationDate]";
			S = S + " ,[IsPublicPreviousState]";
			S = S + " ,[isAvailable]";
			S = S + " FROM  [Email]";
			S = S + " where [EmailGuid] = \'" + SourceGuid + "\'";
			
			CloseConn();
			CkConn();
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			SL.Clear();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					SL.Clear();
					int iCols = RSData.FieldCount - 1;
					for (iCols = 0; iCols <= RSData.FieldCount - 1; iCols++)
					{
						FillSortedList(RSData, iCols, SL);
					}
				}
			}
			else
			{
				SL.Clear();
			}
			RSData.Close();
			RSData = null;
			
		}
		
		public void FillSortedList(SqlDataReader RSData, int iRow, SortedList SL)
		{
			string cName = RSData.GetName(iRow).ToString();
			try
			{
				string tColValue = RSData.GetValue(0).ToString();
				SL.Add(cName, tColValue);
			}
			catch (Exception ex)
			{
				string tColValue = "";
				SL.Add(cName, tColValue);
				LOG.WriteToArchiveLog((string) ("clsDatabase : FillSortedList : 5508 : " + ex.Message));
			}
			
		}
		
		public string GetGuidByFqn(string FQN, string VersionNbr)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			
			string S = (string) ("Select SourceGuid from DataSource where FQN = \'" + FQN + "\' and machineid = \'" + modGlobals.gMachineID + "\' and VersionNbr = " + VersionNbr);
			CloseConn();
			CkConn();
			string xGuid = "";
			
			SqlDataReader rsData = null;
			bool b = false;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			
			if (rsData.HasRows)
			{
				rsData.Read();
				xGuid = rsData.GetValue(0).ToString();
			}
			else
			{
				xGuid = "";
			}
			
			rsData.Close();
			rsData = null;
			
			return xGuid;
			
		}
		public string GetGuidByURL(string FQN)
		{
			FQN = UTIL.RemoveSingleQuotes(FQN);
			
			string S = "Select  SourceGuid FROM DataSource where FQN = \'" + FQN + "\' ";
			CloseConn();
			CkConn();
			string xGuid = "";
			
			SqlDataReader rsData = null;
			bool b = false;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			
			if (rsData.HasRows)
			{
				rsData.Read();
				xGuid = rsData.GetValue(0).ToString();
			}
			else
			{
				xGuid = "";
			}
			
			rsData.Close();
			rsData = null;
			
			return xGuid;
			
		}
		
		public string GetLibOwnerByName(string LibraryName)
		{
			
			if (LibraryName.IndexOf("\'\'") + 1 > 0)
			{
			}
			else
			{
				LibraryName = UTIL.RemoveSingleQuotes(LibraryName);
			}
			
			string S = "Select UserID from Library where LibraryName = \'" + LibraryName + "\' ";
			CloseConn();
			CkConn();
			string xGuid = "";
			
			SqlDataReader rsData = null;
			bool b = false;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			
			if (rsData.HasRows)
			{
				rsData.Read();
				xGuid = rsData.GetValue(0).ToString();
			}
			else
			{
				xGuid = "";
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			command.Dispose();
			command = null;
			
			if (CONN.State == ConnectionState.Open)
			{
				CONN.Close();
			}
			CONN.Dispose();
			
			return xGuid;
			
		}
		
		public bool addDocSourceDescription(string SourceGuid, string Description)
		{
			Description = UTIL.RemoveSingleQuotes(Description);
			string S = "";
			S = "UPDATE [DataSource] set Description = \'" + Description + "\' where SourceGuid = \'" + SourceGuid + "\'";
			bool b = ExecuteSqlNewConn(S, false);
			return b;
		}
		
		//Function addDocSourceError(ByVal SourceGuid , ByVal Notes ) As Boolean
		//    Notes = UTIL.RemoveSingleQuotes(Notes)
		//    Dim S  = ""
		//    S  = "UPDATE [DataSource] set Notes = '" + Notes + "' where SourceGuid = '" + SourceGuid + "'"
		//    Dim b As Boolean = ExecuteSqlNewConn(S, False)
		//    Return b
		//End Function
		
		public bool addDocSourceKeyWords(string SourceGuid, string KeyWords)
		{
			KeyWords = UTIL.RemoveSingleQuotes(KeyWords);
			string S = "";
			S = "UPDATE [DataSource] set KeyWords = \'" + KeyWords + "\' where SourceGuid = \'" + SourceGuid + "\'";
			bool b = ExecuteSqlNewConn(S, false);
			return b;
		}
		
		public bool UpdateMetaData(string Author, string Description, string Keywords, string QuickRefIdNbr, string FQN, string MetadataTag, string MetadataValue, string Library)
		{
			
			MetadataTag = UTIL.RemoveSingleQuotes(MetadataTag);
			MetadataValue = UTIL.RemoveSingleQuotes(MetadataValue);
			Library = UTIL.RemoveSingleQuotes(Library);
			
			FQN = UTIL.RemoveSingleQuotes(FQN);
			Author = UTIL.RemoveSingleQuotes(Author);
			Description = UTIL.RemoveSingleQuotes(Description);
			Keywords = UTIL.RemoveSingleQuotes(Keywords);
			FQN = UTIL.RemoveSingleQuotes(FQN);
			string S = "";
			
			S = (string) ("update QuickRefItems set Author = \'" + Author);
			S = S + "\', Description = \'" + Description;
			S = S + "\', Keywords = \'" + Keywords;
			S = S + "\', MetadataTag = \'" + MetadataTag;
			S = S + "\', MetadataValue = \'" + MetadataValue;
			S = S + "\', Library = \'" + Library;
			S = S + "\' where QuickRefIdNbr = " + QuickRefIdNbr;
			S = S + " and FQN = \'" + FQN.ToString() + "\'";
			
			bool b = ExecuteSqlNewConn(S, false);
			
			return b;
			
		}
		
		public void LoadProcessDates()
		{
			
			string S = "";
			S = S + " select OriginalFolder, max(CreationTime) as MaxDate ";
			S = S + " FROM EMAIL ";
			S = S + " group by OriginalFolder";
			
			string OriginalFolder = "";
			DateTime MaxDate = DateTime.Now;
			
			SqlDataReader RSData = null;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			UTIL.setConnectionStringTimeout(600.ToString());
			SqlConnection CONN = new SqlConnection(CS);
			
			try
			{
				CloseConn();
				CkConn();
				
				modGlobals.slProcessDates.Clear();
				
				
				//RSData = SqlQryNo'Session(S)
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						OriginalFolder = RSData.GetValue(0).ToString();
						MaxDate = DateTime.Parse(RSData.GetValue(1).ToString());
						modGlobals.addEmailProcessDate(OriginalFolder, MaxDate);
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: LoadProcessDates 100 - " + ex.Message));
			}
			finally
			{
				if (RSData != null)
				{
					if (! RSData.IsClosed)
					{
						RSData.Close();
					}
					RSData = null;
					
				}
				if (CONN != null)
				{
					if (CONN.State == ConnectionState.Open)
					{
						CONN.Close();
					}
				}
				RSData = null;
				CONN.Dispose();
				//Command = Nothing
			}
			
			
		}
		//select LibraryName FROM LibDirectory where DirectoryName = 'c:\temp'
		public void getLibDirs(string DirectoryName, List<string> L)
		{
			
			L.Clear();
			DirectoryName = UTIL.RemoveSingleQuotes(DirectoryName);
			
			string S = "Select LibraryName FROM LibDirectory where DirectoryName = \'" + DirectoryName + "\'";
			
			CloseConn();
			CkConn();
			
			modGlobals.slProcessDates.Clear();
			
			string LibraryName = "";
			
			SqlDataReader RSData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					LibraryName = RSData.GetValue(0).ToString();
					LibraryName = UTIL.RemoveSingleQuotes(LibraryName);
					
					if (! L.Contains(LibraryName))
					{
						L.Add(LibraryName);
					}
				}
			}
			RSData.Close();
			RSData = null;
		}
		
		public string getSourceGuidByFqn(string fqn, string UserID)
		{
			fqn = UTIL.RemoveSingleQuotes(fqn);
			try
			{
				string S = " SELECT SourceGuid FROM DataSource where FQN = \'" + fqn + "\' AND DataSourceOwnerUserID = \'" + UserID + "\' ";
				string SourceGuid = "";
				
				SqlDataReader RSData = null;
				//RSData = SqlQryNo'Session(S)
				// Dim CS  = getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata= command.ExecuteReader()
				
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						SourceGuid = RSData.GetValue(0).ToString();
						Application.DoEvents();
					}
				}
				
				RSData.Close();
				RSData = null;
				
				command.Dispose();
				command = null;
				
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				
				return SourceGuid;
			}
			catch (Exception ex)
			{
				this.xTrace(23456, "getSourceGuidByFqn", "clsDatabase", ex);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getSourceGuidByFqn : 5593 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : getSourceGuidByFqn : 5585 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : getSourceGuidByFqn : 5603 : " + ex.Message));
				return "";
			}
			
		}
		
		public string getSourceGuidBySourcenameCRC(string Sourcename, string CRC)
		{
			string sGuid = "";
			try
			{
				Sourcename = UTIL.RemoveSingleQuotes(Sourcename);
				
				string S = "Select  SourceGuid FROM DataSource where SourceName = \'" + Sourcename + "\' and CRC = \'" + CRC + "\' ";
				CloseConn();
				CkConn();
				SqlDataReader rsData = null;
				bool b = false;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					rsData.Read();
					sGuid = rsData.GetString(0);
				}
				
				rsData.Close();
			}
			catch (Exception ex)
			{
				xTrace(12311, "clsDataBase:getCountDataSourceFiles", ex.Message);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getCountDataSourceFiles : 2174 : " + ex.Message));
			}
			return sGuid;
			
		}
		public void LoadEntryIdByUserID(SortedList L)
		{
			
			string S = "Select EmailIdentifier from email where UserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
			L.Clear();
			
			CloseConn();
			CkConn();
			int I = 0;
			
			SqlDataReader RSData = null;
			RSData = this.SqlQryNewConn(S);
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					string EmailIdentifier = RSData.GetValue(0).ToString();
					I++;
					if (I % 10 == 0)
					{
						frmMain.Default.SB.Text = (string) ("ID# " + I.ToString());
						frmMain.Default.SB.Refresh();
					}
					//Dim II As Integer = L.IndexOfKey(EntryId)
					if (! L.ContainsKey(EmailIdentifier))
					{
						L.Add(EmailIdentifier, I);
					}
					else
					{
						if (dDebug)
						{
							Debug.Print("Dup found");
						}
					}
					Application.DoEvents();
				}
			}
			else
			{
				L.Clear();
			}
			frmMain.Default.PB1.Value = 0;
			if (! RSData.IsClosed)
			{
				RSData.Close();
			}
			if (RSData != null)
			{
				RSData = null;
			}
			frmMain.Default.SB.Text = "";
		}
		
		public int getCountStoreIdByFolder()
		{
			int iCnt = 0;
			string S = "Select count(*) from email where Userid = \'" + modGlobals.gCurrUserGuidID + "\'";
			
			CloseConn();
			CkConn();
			int I = 0;
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			RSData = this.SqlQryNewConn(S);
			if (RSData == null)
			{
				return 0;
			}
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					iCnt = RSData.GetInt32(0);
				}
			}
			
			if (! RSData.IsClosed)
			{
				RSData.Close();
			}
			if (RSData != null)
			{
				RSData = null;
			}
			return iCnt;
		}
		
		public void getGroupUsers(string GroupName, ArrayList GroupList)
		{
			
			if (GroupName.IndexOf("\'\'") + 1 > 0)
			{
			}
			else
			{
				GroupName = UTIL.RemoveSingleQuotes(GroupName);
			}
			
			string S = "Select [UserID] FROM  [GroupUsers] where [GroupName] = \'" + GroupName + "\' ";
			CloseConn();
			CkConn();
			int I = 0;
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			RSData = this.SqlQryNewConn(S);
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					string UserID = RSData.GetValue(0).ToString();
					GroupList.Add(UserID);
				}
			}
			
			if (! RSData.IsClosed)
			{
				RSData.Close();
			}
			if (RSData != null)
			{
				RSData = null;
			}
		}
		
		public bool UpdateArchiveFlag(string ParentFolder, string UID, string aFlag, string FolderName)
		{
			bool b = false;
			string s = "";
			
			s = s + " update EmailFolder set ";
			s = s + "SelectedForArchive = \'" + aFlag + "\'" + " where UserID = \'" + UID + "\' and FolderName = \'" + FolderName + "\' and ParentFolderName = \'" + ParentFolder + "\' ";
			
			return ExecuteSqlNewConn(s, false);
		}
		public bool DeleteEmailArchiveFolder(string ParentFolder, string UID, string aFlag, string FolderName)
		{
			bool b = false;
			string s = "";
			
			string ConcatParName = ParentFolder + "|" + FolderName;
			
			s = s + " delete from EmailFolder ";
			//s = s + " where UserID = '" + UID + "' and FolderName = '" + FolderName + "' and ParentFolderName = '" + ParentFolder  + "' "
			s = s + " where UserID = \'" + UID + "\' and FolderName = \'" + FolderName + "\' ";
			
			return ExecuteSqlNewConn(s, false);
		}
		
		//Public Function getFolderNameById(ByVal FolderID ) As String
		//    Dim b As Boolean = True
		//    Dim S As String = ""
		//    S = "Select [FolderName]      "
		//    S = S + " FROM [EmailFolder]"
		//    S = S + " where [FolderID] = '" + FolderID + "'"
		//    Dim i As Integer = 0
		//    Dim id  = ""
		
		//    Dim rsData As SqlDataReader = Nothing
		
		//    Dim CS  = getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata= command.ExecuteReader()
		//    If rsData.HasRows Then
		//        rsData.Read()
		//        id = rsData.GetValue(0).ToString
		//    Else
		//        id = ""
		//    End If
		//    rsData.Close()
		//    rsData = Nothing
		//    Return id
		//End Function
		public string getParentFolderNameById(string FolderID)
		{
			bool b = true;
			string S = "";
			S = "Select [ParentFolderName]      ";
			S = S + " FROM [EmailFolder]";
			S = S + " where [FolderID] = \'" + FolderID + "\'";
			int i = 0;
			string id = "";
			
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				id = rsData.GetValue(0).ToString();
			}
			else
			{
				id = "";
			}
			rsData.Close();
			rsData = null;
			return id;
		}
		
		public void getArchiveFolderIds(ref DataGridView DGV)
		{
			
			SortedList<string, string> SA = new SortedList<string, string>();
			try
			{
				bool b = true;
				string S = "";
				
				S = "Select ContainerName, FolderName, FolderID, storeid from EmailFolder where SelectedForArchive = \'Y\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
				string cNames = "ContainerName, FolderName, FolderID, storeid";
				string[] A = cNames.Split(','.ToString().ToCharArray());
				clsDataGrid DGX = new clsDataGrid();
				DGX.PopulateDataGrid(S, DGV, ref A);
				DGX = null;
				int II = DGV.Rows.Count;
				LOG.WriteToArchiveLog((string) ("NOTICE: DGX Rowcount = " + II.ToString() + " : " + S));
				return;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR getArchiveFolderIds 100 - : " + ex.Message));
				SA = null;
			}
			
			DGV = null;
			
		}
		
		public bool RemoveGroupUser(string GroupName, string UserID)
		{
			bool B = true;
			ArrayList SqlList = new ArrayList();
			try
			{
				string S = " SELECT     GroupUsers.GroupName, GroupLibraryAccess.LibraryName, GroupUsers.UserID ";
				S = S + " FROM         GroupUsers INNER JOIN";
				S = S + "                       GroupLibraryAccess ON GroupUsers.GroupName = GroupLibraryAccess.GroupName";
				S = S + " where GroupUsers.groupName = \'" + GroupName + "\'";
				S = S + " and GroupUsers.UserID = \'" + UserID + "\'";
				S = S + " group by GroupUsers.GroupName, GroupLibraryAccess.LibraryName, GroupUsers.UserID ";
				
				string LibraryName = "";
				
				SqlDataReader RSData = null;
				//RSData = SqlQryNo'Session(S)
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						LibraryName = RSData.GetValue(1).ToString();
						
						S = "delete from libraryusers where libraryname = \'" + LibraryName + "\' and UserID = \'" + UserID + "\'";
						SqlList.Add(S);
						
						Application.DoEvents();
					}
				}
				RSData.Close();
				RSData = null;
				
				for (int i = 0; i <= SqlList.Count - 1; i++)
				{
					S = SqlList[i].ToString();
					bool BB = this.ExecuteSqlNewConn(S, false);
				}
				
				SqlList.Clear();
				SqlList = null;
				GC.Collect();
				
				return B;
			}
			catch (Exception ex)
			{
				this.xTrace((int) 23.456, "getSourceGuidByFqn", "clsDatabase", ex);
				LOG.WriteToArchiveLog((string) ("clsDatabase : RemoveGroupUser : 5704 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : RemoveGroupUser : 5697 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : RemoveGroupUser : 5716 : " + ex.Message));
				return false;
			}
		}
		
		public string getGroupOwnerGuidByGroupName(string GroupName)
		{
			
			if (GroupName.IndexOf("\'\'") + 1 > 0)
			{
			}
			else
			{
				GroupName = UTIL.RemoveSingleQuotes(GroupName);
			}
			
			try
			{
				string S = "Select [GroupOwnerUserID] ,[GroupName] FROM  [UserGroup] where GroupName = \'" + GroupName + "\'";
				string SourceGuid = "";
				
				SqlDataReader RSData = null;
				//RSData = SqlQryNo'Session(S)
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						SourceGuid = RSData.GetValue(0).ToString();
						Application.DoEvents();
					}
				}
				RSData.Close();
				RSData = null;
				
				return SourceGuid;
			}
			catch (Exception ex)
			{
				this.xTrace(23456, "getSourceGuidByFqn", "clsDatabase", ex);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getGroupOwnerGuidByGroupName : 5718 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : getGroupOwnerGuidByGroupName : 5712 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : getGroupOwnerGuidByGroupName : 5732 : " + ex.Message));
				return "";
			}
			
		}
		
		public string getUserEmailAddrByUserID(string UserID)
		{
			try
			{
				string S = "Select EmailAddress FROM Users where UserID = \'" + UserID + "\'";
				string SourceGuid = "";
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						SourceGuid = RSData.GetValue(0).ToString();
						Application.DoEvents();
					}
				}
				RSData.Close();
				RSData = null;
				return SourceGuid;
			}
			catch (Exception ex)
			{
				this.xTrace(23, "getUserEmailAddrByUserID", "clsDatabase", ex);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getUserEmailAddrByUserID : 5732 : " + ex.Message));
				return "";
			}
		}
		
		public string getUserNameByEmailAddr(string EmailAddress)
		{
			try
			{
				string S = "Select UserName FROM email where EmailAddress = \'" + EmailAddress + "\'";
				string SourceGuid = "";
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						SourceGuid = RSData.GetValue(0).ToString();
						Application.DoEvents();
					}
				}
				RSData.Close();
				RSData = null;
				
				return SourceGuid;
			}
			catch (Exception ex)
			{
				this.xTrace(2334, "getUserNameByEmailAddr", "clsDatabase", ex);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getUserNameByEmailAddr : 5746 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : getUserNameByEmailAddr : 5742 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : getUserNameByEmailAddr : 5764 : " + ex.Message));
				return "";
			}
		}
		
		public void loadReassignHistory(string OldUid, string NewUid, ArrayList UserArray)
		{
			UserArray.Clear();
			string S = "  SELECT [UserID]";
			S = S + " ,[UserName]";
			S = S + " ,[EmailAddress]";
			S = S + " ,[UserPassword]";
			S = S + " ,[Admin]";
			S = S + " ,[isActive]";
			S = S + " ,[UserLoginID]";
			S = S + " from users WHERE (Users.UserID = \'" + OldUid + "\') ";
			string SourceGuid = "";
			SqlDataReader RSData = null;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			int II = 0;
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					II++;
					string UserID = RSData.GetValue(0).ToString();
					string UserName = RSData.GetValue(1).ToString();
					string EmailAddress = RSData.GetValue(2).ToString();
					string UserPassword = RSData.GetValue(3).ToString();
					string Admin = RSData.GetValue(4).ToString();
					string isActive = RSData.GetValue(5).ToString();
					string UserLoginID = RSData.GetValue(6).ToString();
					
					UserArray.Add(UserID);
					UserArray.Add(UserName);
					UserArray.Add(EmailAddress);
					UserArray.Add(UserPassword);
					UserArray.Add(Admin);
					UserArray.Add(isActive);
					UserArray.Add(UserLoginID);
					
					Application.DoEvents();
				}
			}
			RSData.Close();
			RSData = null;
			
			S = "  SELECT [UserID]";
			S = S + " ,[UserName]";
			S = S + " ,[EmailAddress]";
			S = S + " ,[UserPassword]";
			S = S + " ,[Admin]";
			S = S + " ,[isActive]";
			S = S + " ,[UserLoginID]";
			S = S + " from users WHERE Users.UserID = \'" + NewUid + "\' ";
			SourceGuid = "";
			
			CS = getGateWayConnStr(modGlobals.gGateWayID);
			CONN = new SqlConnection(CS);
			CONN.Open();
			command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			II = 0;
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					II++;
					string UserID = RSData.GetValue(0).ToString();
					string UserName = RSData.GetValue(1).ToString();
					string EmailAddress = RSData.GetValue(2).ToString();
					string UserPassword = RSData.GetValue(3).ToString();
					string Admin = RSData.GetValue(4).ToString();
					string isActive = RSData.GetValue(5).ToString();
					string UserLoginID = RSData.GetValue(6).ToString();
					
					UserArray.Add(UserID);
					UserArray.Add(UserName);
					UserArray.Add(EmailAddress);
					UserArray.Add(UserPassword);
					UserArray.Add(Admin);
					UserArray.Add(isActive);
					UserArray.Add(UserLoginID);
					
					Application.DoEvents();
				}
			}
			RSData.Close();
			RSData = null;
		}
		
		public string xGetXrt()
		{
			int iMax = GetMaxLicenseID();
			try
			{
				string S = (string) ("Select Agreement FROM  License where LicenseID = " + iMax.ToString());
				string tCnt = "";
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						tCnt = RSData.GetValue(0).ToString();
						Application.DoEvents();
					}
				}
				RSData.Close();
				RSData = null;
				
				return tCnt;
			}
			catch (Exception ex)
			{
				this.xTrace(2334, "getUserNameByEmailAddr", "clsDatabase", ex);
				LOG.WriteToArchiveLog((string) ("clsDatabase : xGetXrt : 5829 : " + ex.Message));
				return "";
			}
		}
		
		//Function GetCurrMachineCnt() As Integer
		//    Try
		//        Dim S As String  = "Select count(*) FROM [Machine]"
		//        Dim tCnt  = ""
		//        Dim RSData As SqlDataReader = Nothing
		//        Dim CS  = getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata= command.ExecuteReader()
		//        If RSData.HasRows Then
		//            RSData.Read()
		//            tCnt  = RSData.GetValue(0).ToString
		//            Application.DoEvents()
		//        Else
		//            tCnt = 0
		//        End If
		
		//        RSData.Close()
		//        RSData = Nothing
		
		//        Return cint(tCnt )
		//    Catch ex As Exception
		//        Me.xTrace(2334, "getUserNameByEmailAddr", "clsDatabase", ex)
		//        Return -1
		//    End Try
		//End Function
		
		//SELECT max([LicenseID]) FROM  [License]
		public int GetMaxLicenseID()
		{
			string tCnt = "";
			try
			{
				string S = "Select max([LicenseID]) FROM [License]";
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					tCnt = RSData.GetValue(0).ToString();
					Application.DoEvents();
				}
				else
				{
					tCnt = "0";
				}
				
				RSData.Close();
				RSData = null;
			}
			catch (Exception ex)
			{
				this.xTrace(2334, "getUserNameByEmailAddr", "clsDatabase", ex);
				LOG.WriteToArchiveLog((string) ("clsDatabase : GetMaxLicenseID : 5844 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : GetMaxLicenseID : 5842 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : GetMaxLicenseID : 5866 : " + ex.Message));
				tCnt = "-1";
			}
			return int.Parse(tCnt);
		}
		
		public bool LicenseExists()
		{
			bool b = false;
			string CS = "";
			CS = getGateWayConnStr(modGlobals.gGateWayID);
			
			try
			{
				
				this.CloseConn();
				CkConn();
				string s = "Select count(*) from License ";
				int Cnt;
				SqlDataReader rsData = null;
				
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(s, CONN);
				rsData = command.ExecuteReader();
				
				rsData.Read();
				Cnt = rsData.GetInt32(0);
				if (Cnt > 0)
				{
					b = true;
				}
				else
				{
					b = false;
				}
				rsData.Close();
				rsData = null;
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: LicenseExists - " + ex.Message));
				string Msg = "License validation error:" + "\r\n";
				Msg += "A license could not be found for the product." + "\r\n";
				Msg += ex.Message + "\r\n";
				Msg += CS + "\r\n" + "\r\n";
				Msg += "This message is on the clipboard if needed for debug.";
				MessageBox.Show(Msg);
				Clipboard.Clear();
				Clipboard.SetText(Msg);
				b = false;
			}
			
			return b;
		}
		public void getLicenseLastVersion()
		{
			
		}
		public string GetXrt()
		{
			string S = "Select Agreement from License where [LicenseID] = (SELECT max([LicenseID]) FROM [License])";
			int iMax = GetMaxLicenseID();
			try
			{
				
				string tCnt = "";
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						S = RSData.GetValue(0).ToString();
						Application.DoEvents();
					}
				}
				RSData.Close();
				RSData = null;
				
				return S;
			}
			catch (Exception ex)
			{
				this.xTrace(2334, "GetXrt", "clsDatabase", ex);
				LOG.WriteToArchiveLog((string) ("clsDatabase : GetXrt : 5874 : " + ex.Message + "\r\n" + S));
				S = "";
				return S;
			}
		}
		
		public int GetCurrMachineCnt()
		{
			try
			{
				string S = "Select count(*) FROM [Machine]";
				string tCnt = "";
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					tCnt = RSData.GetValue(0).ToString();
					Application.DoEvents();
				}
				else
				{
					tCnt = 0.ToString();
				}
				
				RSData.Close();
				RSData = null;
				
				return int.Parse(tCnt);
			}
			catch (Exception ex)
			{
				this.xTrace(2334, "GetCurrMachineCnt", "clsDatabase", ex);
				LOG.WriteToArchiveLog((string) ("clsDatabase : GetCurrMachineCnt : 5889 : " + ex.Message));
				return -1;
			}
		}
		public int GetNbrUsers()
		{
			try
			{
				string S = "Select count(*) from Users ";
				int tCnt;
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					tCnt = RSData.GetInt32(0);
					tCnt--;
					Application.DoEvents();
				}
				else
				{
					tCnt = 0;
				}
				
				RSData.Close();
				RSData = null;
				
				return tCnt;
			}
			catch (Exception ex)
			{
				this.xTrace(2334, "GetNbrMachine", "clsDatabase", ex);
				LOG.WriteToArchiveLog((string) ("clsDatabase : GetNbrMachine : 5904 : " + ex.Message));
				return -1;
			}
		}
		public int GetNbrMachine()
		{
			try
			{
				string S = "Select count(*) from MachineRegistered ";
				string tCnt = "";
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					tCnt = RSData.GetValue(0).ToString();
					Application.DoEvents();
				}
				else
				{
					tCnt = 0.ToString();
				}
				
				RSData.Close();
				RSData = null;
				
				return int.Parse(tCnt);
			}
			catch (Exception ex)
			{
				this.xTrace(2334, "GetNbrMachine", "clsDatabase", ex);
				LOG.WriteToArchiveLog((string) ("clsDatabase : GetNbrMachine : 5904 : " + ex.Message));
				return -1;
			}
		}
		public int GetNbrMachine(string MachineName)
		{
			try
			{
				string S = "Select COUNT(Distinct MachineName) from machine ";
				string tCnt = "";
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					tCnt = RSData.GetValue(0).ToString();
					Application.DoEvents();
				}
				else
				{
					tCnt = 0.ToString();
				}
				
				RSData.Close();
				RSData = null;
				
				return int.Parse(tCnt);
			}
			catch (Exception ex)
			{
				this.xTrace(2334, "GetNbrMachine", "clsDatabase", ex);
				LOG.WriteToArchiveLog((string) ("clsDatabase : GetNbrMachine : 5904 : " + ex.Message));
				return -1;
			}
		}
		public int GetCurrUserCnt()
		{
			try
			{
				string S = "Select count(*) FROM [Users]";
				string tCnt = "";
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					tCnt = RSData.GetValue(0).ToString();
					Application.DoEvents();
				}
				else
				{
					tCnt = 0.ToString();
				}
				
				RSData.Close();
				RSData = null;
				
				return int.Parse(tCnt);
			}
			catch (Exception ex)
			{
				this.xTrace(2334, "GetCurrUserCnt", "clsDatabase", ex);
				LOG.WriteToArchiveLog((string) ("clsDatabase : GetCurrUserCnt : 5904 : " + ex.Message));
				return -1;
			}
		}
		
		public bool saveLicenseCutAndPaste(string LS, string CustomerID, string MachineID)
		{
			
			string S = "Select count(*) from License where CustomerID = \'" + CustomerID + "\' and MachineID = \'" + MachineID + "\' ";
			int iCnt = iCount(S);
			string sLic = "";
			
			if (iCnt == 0)
			{
				sLic = sLic + "INSERT INTO [License]";
				sLic = sLic + "([Agreement]";
				sLic = sLic + ",[VersionNbr]";
				sLic = sLic + ",[ActivationDate]";
				sLic = sLic + ",[InstallDate]";
				sLic = sLic + ",[CustomerID]";
				sLic = sLic + ",[CustomerName]";
				sLic = sLic + ",[XrtNxr1], MachineID)";
				sLic = sLic + "VALUES ";
				sLic = sLic + "(\'" + LS + "\'";
				sLic = sLic + ",1";
				sLic = sLic + ",GETDATE()";
				sLic = sLic + ",GETDATE()";
				sLic = sLic + ",\'" + CustomerID + "\'";
				sLic = sLic + ",\'XX\'";
				sLic = sLic + ",\'XX\', \'" + MachineID + "\')";
			}
			else
			{
				sLic = sLic + " Update [License] ";
				sLic = sLic + " set [Agreement] = \'" + LS + "\' ";
				sLic = sLic + " where CustomerID = \'" + CustomerID + "\' and MachineID = \'" + MachineID + "\' ";
			}
			
			bool B = false;
			B = ExecuteSqlNewConn(sLic, false);
			if (! B)
			{
				Clipboard.Clear();
				Clipboard.SetText(sLic);
				MessageBox.Show("The License did not APPLY - check the error log. Error 66.527 loading License Failed.");
			}
			
			return B;
		}
		
		public string GetProfileDesc(string ProfileName)
		{
			try
			{
				string S = "Select [ProfileDesc] FROM [LoadProfile] where [ProfileName] =\'" + ProfileName + "\'";
				string tVal = "";
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					tVal = RSData.GetValue(0).ToString();
					Application.DoEvents();
				}
				else
				{
					tVal = "";
				}
				
				RSData.Close();
				RSData = null;
				
				return tVal;
			}
			catch (Exception ex)
			{
				this.xTrace(2334, "GetCurrUserCnt", "clsDatabase", ex);
				LOG.WriteToArchiveLog((string) ("clsDatabase : GetProfileDesc : 5942 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : GetProfileDesc : 5945 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : GetProfileDesc : 5974 : " + ex.Message));
				return "";
			}
		}
		
		public string getAttributeDataType(string AttributeName)
		{
			string tVal = "";
			string S = "Select AttributeDataType FROM [Attributes] where AttributeName = \'" + AttributeName + "\'";
			try
			{
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					tVal = RSData.GetValue(0).ToString();
					Application.DoEvents();
				}
				else
				{
					tVal = "";
				}
				
				RSData.Close();
				RSData = null;
				
				return tVal;
			}
			catch (Exception ex)
			{
				this.xTrace(2334, "getAttributeDataType", "clsDatabase", ex);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getAttributeDataType : 5957 : " + ex.Message));
				return "";
			}
		}
		public string getAttributeAllowedValues(string AttributeName)
		{
			string tVal = "";
			string S = "Select AllowedValues FROM [Attributes] where AttributeName = \'" + AttributeName + "\'";
			try
			{
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					tVal = RSData.GetValue(0).ToString();
					Application.DoEvents();
				}
				else
				{
					tVal = "";
				}
				
				RSData.Close();
				RSData = null;
				
				return tVal;
			}
			catch (Exception ex)
			{
				this.xTrace(2334, "getAttributeDataType", "clsDatabase", ex);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getAttributeDataType : 5957 : " + ex.Message));
				return "";
			}
		}
		
		public bool QuotesRequired(string DataType)
		{
			bool B = false;
			DataType = DataType.ToUpper();
			
			switch (DataType)
			{
				case "INT":
					return false;
				case "DATETIME":
					return true;
				case "DECIMAL":
					return false;
				case "FLOAT":
					return false;
				case "VARCHAR":
					return true;
				case "NVARCHAR":
					return true;
				case "CHAR":
					return true;
				case "NCHAR":
					return true;
				default:
					B = true;
					break;
			}
			return B;
		}
		
		public double getDataSourceImageLength(string SourceGuid)
		{
			string S = "Select max(datalength(SourceImage)) from DataSource where SourceGuid = \'" + SourceGuid + "\'";
			string tVal = "";
			SqlConnection NewCN = new SqlConnection(getGateWayConnStr(modGlobals.gGateWayID));
			if (NewCN.State == ConnectionState.Closed)
			{
				NewCN.Open();
			}
			try
			{
				SqlDataReader RSData = null;
				RSData = SqlQry(S, NewCN);
				if (RSData.HasRows)
				{
					RSData.Read();
					tVal = RSData.GetValue(0).ToString();
					Application.DoEvents();
				}
				else
				{
					tVal = "0";
				}
				
				RSData.Close();
				RSData = null;
				NewCN.Close();
				NewCN = null;
				
				return int.Parse(tVal);
			}
			catch (Exception ex)
			{
				this.xTrace(2334, "getDataSourceImageLength", "clsDatabase", ex);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getDataSourceImageLength : 5992 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : getDataSourceImageLength : 5997 : " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase : getDataSourceImageLength : 6028 : " + ex.Message));
				return 0;
			}
		}
		
		public void UpdateCurrArchiveStats(string FQN, string SourceTypeCode)
		{
			
			if (modGlobals.gCurrentArchiveGuid.Trim().Length == 0)
			{
				modGlobals.gCurrentArchiveGuid = Guid.NewGuid().ToString();
			}
			
			FQN = UTIL.RemoveSingleQuotes(FQN);
			clsARCHIVEHIST ARCHHIST = new clsARCHIVEHIST();
			clsARCHIVEHISTCONTENTTYPE ARCHHISTTYPE = new clsARCHIVEHISTCONTENTTYPE();
			
			if (SourceTypeCode.Equals("MSG"))
			{
				if (dDebug)
				{
					Debug.Print((string) ("Processing Folder: " + FQN));
				}
			}
			else if (SourceTypeCode.Equals("EML"))
			{
				if (dDebug)
				{
					Debug.Print((string) ("Processing Folder: " + FQN));
				}
			}
			else
			{
				FQN = DMA.GetFilePath(FQN);
				FQN = UTIL.RemoveSingleQuotes(FQN);
			}
			
			int iCnt = ARCHHIST.cnt_PK110(modGlobals.gCurrentArchiveGuid);
			if (iCnt == 0)
			{
				ARCHHIST.setUserguid(ref modGlobals.gCurrUserGuidID);
				ARCHHIST.setArchivedate(DateTime.Now.ToString());
				ARCHHIST.setArchiveid(ref modGlobals.gCurrentArchiveGuid);
				ARCHHIST.setNbrfilesarchived(1.ToString());
				bool BBB = ARCHHIST.Insert();
				if (! BBB)
				{
					if (dDebug)
					{
						Debug.Print("Error 22.921.3: Failed to update current archive data.");
					}
				}
				else
				{
					iCnt = ARCHHISTTYPE.cnt_PK111(modGlobals.gCurrentArchiveGuid, FQN, SourceTypeCode);
					if (iCnt == 0)
					{
						ARCHHISTTYPE.setArchiveid(ref modGlobals.gCurrentArchiveGuid);
						ARCHHISTTYPE.setDirectory(ref FQN);
						ARCHHISTTYPE.setFiletype(ref SourceTypeCode);
						ARCHHISTTYPE.setNbrfilesarchived(1.ToString());
						bool BBBB = ARCHHISTTYPE.Insert();
						if (! BBBB)
						{
							if (dDebug)
							{
								Debug.Print("Error 22.921.3d: Failed to update current archive data.");
							}
						}
					}
					else
					{
						string SS = "UPDATE [ArchiveHistContentType] SET ";
						SS = SS + " NbrFilesArchived = NbrFilesArchived + 1";
						SS = SS + " WHERE [ArchiveID] = \'" + modGlobals.gCurrentArchiveGuid + "\'";
						SS = SS + " and [Directory] = \'" + FQN + "\'";
						SS = SS + " and [FileType] = \'" + SourceTypeCode + "\'";
						bool BBBB = ExecuteSqlNewConn(SS, false);
						if (! BBBB)
						{
							if (dDebug)
							{
								Debug.Print("Error 22.921.3b: Failed to update current archive data.");
							}
						}
					}
				}
			}
			else
			{
				string SS = "Update ArchiveHist set NbrFilesArchived = NbrFilesArchived + 1 where ArchiveID = \'" + modGlobals.gCurrentArchiveGuid + "\'";
				bool BBB = ExecuteSqlNewConn(SS, false);
				if (! BBB)
				{
					if (dDebug)
					{
						Debug.Print("Error 22.921.3b: Failed to update current archive data.");
					}
				}
				else
				{
					iCnt = ARCHHISTTYPE.cnt_PK111(modGlobals.gCurrentArchiveGuid, FQN, SourceTypeCode);
					if (iCnt == 0)
					{
						ARCHHISTTYPE.setArchiveid(ref modGlobals.gCurrentArchiveGuid);
						ARCHHISTTYPE.setDirectory(ref FQN);
						ARCHHISTTYPE.setFiletype(ref SourceTypeCode);
						ARCHHISTTYPE.setNbrfilesarchived(1.ToString());
						bool BBBB = ARCHHISTTYPE.Insert();
						if (! BBBB)
						{
							if (dDebug)
							{
								Debug.Print("Error 22.921.3d: Failed to update current archive data.");
							}
						}
					}
					else
					{
						SS = "UPDATE [ArchiveHistContentType] SET";
						SS = SS + " NbrFilesArchived = NbrFilesArchived + 1";
						SS = SS + " WHERE [ArchiveID] = \'" + modGlobals.gCurrentArchiveGuid + "\'";
						SS = SS + " and [Directory] = \'" + FQN + "\'";
						SS = SS + " and [FileType] = \'" + SourceTypeCode + "\'";
						bool BBBB = ExecuteSqlNewConn(SS, false);
						if (! BBBB)
						{
							if (dDebug)
							{
								Debug.Print("Error 22.921.3b: Failed to update current archive data.");
							}
						}
					}
				}
			}
		}
		public void UpdateCurrArchiveStats(string FQN, string SourceTypeCode, string ArchiveGuid)
		{
			
			if (modGlobals.gCurrentArchiveGuid.Trim().Length == 0)
			{
				modGlobals.gCurrentArchiveGuid = Guid.NewGuid().ToString();
			}
			
			FQN = UTIL.RemoveSingleQuotes(FQN);
			clsARCHIVEHIST ARCHHIST = new clsARCHIVEHIST();
			clsARCHIVEHISTCONTENTTYPE ARCHHISTTYPE = new clsARCHIVEHISTCONTENTTYPE();
			
			if (SourceTypeCode.Equals("MSG"))
			{
				if (dDebug)
				{
					Debug.Print((string) ("Processing Folder: " + FQN));
				}
			}
			else if (SourceTypeCode.Equals("EML"))
			{
				if (dDebug)
				{
					Debug.Print((string) ("Processing Folder: " + FQN));
				}
			}
			else
			{
				FQN = DMA.GetFilePath(FQN);
				FQN = UTIL.RemoveSingleQuotes(FQN);
			}
			
			int iCnt = ARCHHIST.cnt_PK110(ArchiveGuid);
			if (iCnt == 0)
			{
				ARCHHIST.setUserguid(ref modGlobals.gCurrUserGuidID);
				ARCHHIST.setArchivedate(DateTime.Now.ToString());
				ARCHHIST.setArchiveid(ref ArchiveGuid);
				ARCHHIST.setNbrfilesarchived(1.ToString());
				bool BBB = ARCHHIST.Insert();
				if (! BBB)
				{
					if (dDebug)
					{
						Debug.Print("Error 22.921.3: Failed to update current archive data.");
					}
				}
				else
				{
					iCnt = ARCHHISTTYPE.cnt_PK111(ArchiveGuid, FQN, SourceTypeCode);
					if (iCnt == 0)
					{
						ARCHHISTTYPE.setArchiveid(ref ArchiveGuid);
						ARCHHISTTYPE.setDirectory(ref FQN);
						ARCHHISTTYPE.setFiletype(ref SourceTypeCode);
						ARCHHISTTYPE.setNbrfilesarchived(1.ToString());
						bool BBBB = ARCHHISTTYPE.Insert();
						if (! BBBB)
						{
							if (dDebug)
							{
								Debug.Print("Error 22.921.3d: Failed to update current archive data.");
							}
						}
					}
					else
					{
						string SS = "UPDATE [ArchiveHistContentType] SET ";
						SS = SS + " NbrFilesArchived = NbrFilesArchived + 1";
						SS = SS + " WHERE [ArchiveID] = \'" + ArchiveGuid + "\'";
						SS = SS + " and [Directory] = \'" + FQN + "\'";
						SS = SS + " and [FileType] = \'" + SourceTypeCode + "\'";
						bool BBBB = ExecuteSqlNewConn(SS, false);
						if (! BBBB)
						{
							if (dDebug)
							{
								Debug.Print("Error 22.921.3b: Failed to update current archive data.");
							}
						}
					}
				}
			}
			else
			{
				string SS = "Update ArchiveHist set NbrFilesArchived = NbrFilesArchived + 1 where ArchiveID = \'" + ArchiveGuid + "\'";
				bool BBB = ExecuteSqlNewConn(SS, false);
				if (! BBB)
				{
					if (dDebug)
					{
						Debug.Print("Error 22.921.3b: Failed to update current archive data.");
					}
				}
				else
				{
					iCnt = ARCHHISTTYPE.cnt_PK111(ArchiveGuid, FQN, SourceTypeCode);
					if (iCnt == 0)
					{
						ARCHHISTTYPE.setArchiveid(ref ArchiveGuid);
						ARCHHISTTYPE.setDirectory(ref FQN);
						ARCHHISTTYPE.setFiletype(ref SourceTypeCode);
						ARCHHISTTYPE.setNbrfilesarchived(1.ToString());
						bool BBBB = ARCHHISTTYPE.Insert();
						if (! BBBB)
						{
							if (dDebug)
							{
								Debug.Print("Error 22.921.3d: Failed to update current archive data.");
							}
						}
					}
					else
					{
						SS = "UPDATE [ArchiveHistContentType] SET";
						SS = SS + " NbrFilesArchived = NbrFilesArchived + 1";
						SS = SS + " WHERE [ArchiveID] = \'" + ArchiveGuid + "\'";
						SS = SS + " and [Directory] = \'" + FQN + "\'";
						SS = SS + " and [FileType] = \'" + SourceTypeCode + "\'";
						bool BBBB = ExecuteSqlNewConn(SS, false);
						if (! BBBB)
						{
							if (dDebug)
							{
								Debug.Print("Error 22.921.3b: Failed to update current archive data.");
							}
						}
					}
				}
			}
		}
		
		/// <summary>
		/// Now, we can get this data...
		/// So what, how do we pass it all back
		/// </summary>
		/// <param name="frm"></param>
		/// <param name="fControl"></param>
		/// <remarks></remarks>
		public void getFormHelpData(string FormName, SortedList<string, string> slFormHelp)
		{
			
			try
			{
				slFormHelp.Clear();
				string S = "";
				S = S + " SELECT [ScreenName]";
				S = S + " ,[HelpText]";
				S = S + " ,[WidgetName]";
				S = S + " FROM [HelpText]";
				S = S + " where ScreenName = \'" + FormName + "\' ";
				S = S + " and [DisplayHelpText] <> 0 ";
				
				bool b = true;
				int i = 0;
				int id = -1;
				int II = 0;
				string table_name = "";
				string column_name = "";
				string data_type = "";
				string character_maximum_length = "";
				
				string ScreenName = "";
				string HelpText = "";
				string WidgetName = "";
				string tKey = "";
				
				SqlDataReader RSData = null;
				//RSData = SqlQryNo'Session(S)
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						ScreenName = RSData.GetValue(0).ToString();
						HelpText = RSData.GetValue(1).ToString();
						WidgetName = RSData.GetValue(2).ToString();
						tKey = ScreenName + "," + WidgetName;
						b = slFormHelp.ContainsKey(tKey);
						if (b == false)
						{
							slFormHelp.Add(tKey, HelpText);
						}
					}
				}
				else
				{
					id = -1;
				}
				RSData.Close();
				RSData = null;
			}
			catch (Exception ex)
			{
				this.xTrace(27000, "getFormHelpData", "clsDatabase", ex);
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show((string) ("Error 142.33.21: " + "\r\n" + ex.Message));
				}
				LOG.WriteToArchiveLog((string) ("clsDatabase : getFormHelpData : 6102 : " + ex.Message));
			}
			
		}
		
		public void getFormTooltips(Form frm, ToolTip TT, bool setActive)
		{
			
			clsHELPTEXT HELP = new clsHELPTEXT();
			SortedList<string, string> slFormHelp = new SortedList<string, string>();
			
			string FormName = frm.Name;
			string WidgetName = "";
			Control loControl;
			
			string lsTmp = "";
			ArrayList A = new ArrayList();
			string SS = "";
			string ctlText = "";
			string ControlType = "";
			string HelpText = "";
			
			getFormHelpData(FormName, slFormHelp);
			
			foreach (Control tempLoopVar_loControl in frm.Controls)
			{
				loControl = tempLoopVar_loControl;
				ctlText = loControl.Text;
				WidgetName = loControl.Name;
				string tKey = FormName + "," + WidgetName;
				if (slFormHelp.ContainsKey(tKey))
				{
					//** Great - now what ?
					int iDx = slFormHelp.IndexOfKey(tKey);
					HelpText = slFormHelp.Values(iDx);
					TT.SetToolTip(loControl, HelpText);
					TT.Active = setActive;
				}
			}
			
		}
		
		public void MarkImageCopyForDeletion(string fqn)
		{
			fqn = UTIL.RemoveSingleQuotes(fqn);
			bool B = false;
			clsFILESTODELETE FTD = new clsFILESTODELETE();
			string mName = DMA.GetCurrMachineName();
			
			FTD.setFqn(ref fqn);
			FTD.setMachinename(ref mName);
			FTD.setPendingdelete("Y");
			FTD.setUserid(ref modGlobals.gCurrUserGuidID);
			int iCnt = FTD.cnt_PK_FileToDelete(fqn, mName, modGlobals.gCurrUserGuidID);
			if (iCnt > 0)
			{
				string WC = FTD.wc_PK_FileToDelete(fqn, mName, modGlobals.gCurrUserGuidID);
				B = FTD.Update(WC);
			}
			else
			{
				B = FTD.Insert();
			}
			if (! B)
			{
				if (dDebug)
				{
					Debug.Print("Error on OCR 12.99.1");
				}
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show("Error on OCR 12.99.1");
				}
				LOG.WriteToArchiveLog((string) ("Error on OCR 12.99.1 - " + fqn));
			}
			FTD = null;
			GC.Collect();
		}
		
		public void DeleteMarkedImageCopyFiles()
		{
			
			ArrayList FileToDelete = new ArrayList();
			SqlDataReader rsData;
			string mName = DMA.GetCurrMachineName();
			string FQN = "";
			string S = "";
			
			//** S = S + " SELECT [UserID],[MachineName],[FQN],[PendingDelete]"
			S = S + " SELECT [FQN] ";
			S = S + " FROM [FilesToDelete] ";
			S = S + " where MachineName = \'" + mName + "\'";
			
			try
			{
				bool b = true;
				int i = 0;
				string FileType = "";
				int II = 0;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					while (rsData.Read())
					{
						Application.DoEvents();
						b = true;
						FQN = rsData.GetValue(0).ToString();
						FileToDelete.Add(FQN);
					}
				}
			}
			catch (Exception ex)
			{
				this.xTrace(27000, "DeleteMarkedImageCopyFiles", "clsDatabase", ex);
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show((string) ("ERROR AddProfileFileTypes: " + ex.Message));
				}
				LOG.WriteToArchiveLog((string) ("clsDatabase : DeleteMarkedImageCopyFiles : 6168 : " + ex.Message));
			}
			
			if (rsData != null)
			{
				rsData.Close();
				rsData = null;
			}
			
			try
			{
				for (int i = 0; i <= FileToDelete.Count - 1; i++)
				{
					Application.DoEvents();
					FQN = FileToDelete[i].ToString();
					FileInfo F = new FileInfo(FQN);
					if (F.Exists)
					{
						try
						{
							F.Delete();
						}
						catch (Exception ex)
						{
							LOG.WriteToArchiveLog((string) ("NOTICE: DeleteMarkedImageCopyFiles : 6180.01 : " + ex.Message));
						}
					}
					
					F = null;
					GC.Collect();
				}
			}
			catch (Exception ex)
			{
				this.xTrace(27001, "DeleteMarkedImageCopyFiles", "clsDatabase", ex);
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show((string) ("ERROR DeleteMarkedImageCopyFiles: " + ex.Message));
				}
				LOG.WriteToArchiveLog((string) ("clsDatabase : DeleteMarkedImageCopyFiles : 6180 : " + ex.Message));
			}
			
			GC.Collect();
			
			S = "Delete from FilesToDelete where MachineName = \'" + mName + "\'";
			var BB = this.ExecuteSqlNewConn(S, false);
			if (! BB)
			{
				if (dDebug)
				{
					Debug.Print("Error Here");
				}
			}
			
		}
		
		public void SetOcrAttributesToPass(string SourceGuid)
		{
			string S = "update DataSource set OcrPerformed = \'Y\', isGraphic = \'Y\' where SourceGuid = \'" + SourceGuid + "\'";
			bool b = this.ExecuteSqlNewConn(S, false);
			if (! b)
			{
				if (dDebug)
				{
					Debug.Print("Failed to set OCR Attributes");
				}
			}
		}
		
		public void SetOcrAttributesToFail(string SourceGuid)
		{
			string S = "update DataSource set OcrPerformed = \'F\', isGraphic = \'Y\' where SourceGuid = \'" + SourceGuid + "\'";
			bool b = this.ExecuteSqlNewConn(S, false);
			if (! b)
			{
				if (dDebug)
				{
					Debug.Print("Failed to set OCR Attributes");
				}
			}
		}
		
		public void SetOcrAttributesToNotPerformed(string SourceGuid)
		{
			string S = "update DataSource set OcrPerformed = \'N\', isGraphic = \'Y\' where SourceGuid = \'" + SourceGuid + "\'";
			bool b = this.ExecuteSqlNewConn(S, false);
			if (! b)
			{
				if (dDebug)
				{
					Debug.Print("Failed to set OCR Attributes");
				}
			}
		}
		
		//GraphicContainsText
		public void SetImageHiddenText(string SourceGuid, string ImageHiddenText)
		{
			
			ImageHiddenText = UTIL.RemoveSingleQuotes(ImageHiddenText);
			
			string S = "update DataSource set GraphicContainsText = \'Y\' where SourceGuid = \'" + SourceGuid + "\'";
			bool b = this.ExecuteSqlNewConn(S, false);
			if (! b)
			{
				if (dDebug)
				{
					Debug.Print("Failed to set OCR Attributes");
				}
			}
			
			S = "update DataSource set ImageHiddenText = \'" + ImageHiddenText + "\' where SourceGuid = \'" + SourceGuid + "\'";
			b = this.ExecuteSqlNewConn(S, false);
			if (! b)
			{
				if (dDebug)
				{
					Debug.Print("Failed to set OCR Attributes");
				}
			}
		}
		
		public void AppendImageHiddenText(string SourceGuid, string ImageHiddenText)
		{
			
			ImageHiddenText = UTIL.RemoveSingleQuotes(ImageHiddenText);
			
			string S = "update DataSource set GraphicContainsText = \'Y\' where SourceGuid = \'" + SourceGuid + "\'";
			bool b = this.ExecuteSqlNewConn(S, false);
			if (! b)
			{
				if (dDebug)
				{
					Debug.Print("Failed to set OCR Attributes");
				}
			}
			
			S = "update DataSource set ImageHiddenText = ImageHiddenText + \'|\' + \'" + ImageHiddenText + "\' where SourceGuid = \'" + SourceGuid + "\'";
			b = this.ExecuteSqlNewConn(S, false);
			if (! b)
			{
				if (dDebug)
				{
					Debug.Print("Failed to set OCR Attributes");
				}
			}
		}
		
		public void AppendOcrText(string SourceGuid, string OcrText)
		{
			DateTime DTE = DateTime.Now;
			
			LOG.WriteToTimerLog("clsDatabase", "AppendOcrText", "START");
			
			string ExistingOcrText = getOcrText(SourceGuid, "DOC", "");
			
			ExistingOcrText = ExistingOcrText + " " + OcrText;
			
			OcrText = UTIL.RemoveSingleQuotes(ExistingOcrText);
			
			string S = "update DataSource set GraphicContainsText = \'Y\' where SourceGuid = \'" + SourceGuid + "\'";
			bool b = this.ExecuteSqlNewConn(S, false);
			if (! b)
			{
				if (dDebug)
				{
					Debug.Print("Failed to set OCR Attributes");
				}
			}
			
			BlankOutSingleQuotes(ref OcrText);
			S = "update DataSource set OcrText = \'" + OcrText + "\' where SourceGuid = \'" + SourceGuid + "\'";
			b = this.ExecuteSqlNewConn(S, false);
			if (! b)
			{
				if (dDebug)
				{
					Debug.Print("Failed to set OCR text");
				}
			}
			LOG.WriteToTimerLog("clsDatabase", "AppendOcrText", "END", DTE);
		}
		
		public void AppendEmailOcrText(string EmailGuid, string OcrText, string AttachmentName)
		{
			
			AttachmentName = AttachmentName.Replace("\'", "\'\'");
			
			string ExistingOcrText = getOcrText(EmailGuid, "EMAIL", AttachmentName);
			
			ExistingOcrText = ExistingOcrText + " " + OcrText;
			
			OcrText = UTIL.RemoveSingleQuotes(ExistingOcrText);
			BlankOutSingleQuotes(ref OcrText);
			
			string S = "update EmailAttachment set OcrText = \'" + OcrText + "\' where EmailGuid = \'" + EmailGuid + "\' and AttachmentName = \'" + AttachmentName + "\' ";
			bool b = this.ExecuteSqlNewConn(S, false);
			if (! b)
			{
				if (dDebug)
				{
					Debug.Print("Failed to set OCR Attributes");
				}
			}
		}
		public void BlankOutSingleQuotes(ref string sText)
		{
			for (int i = 1; i <= sText.Length; i++)
			{
				string CH = sText.Substring(i - 1, 1);
				if (CH.Equals("\'"))
				{
					StringType.MidStmtStr(ref sText, i, 1, "`");
				}
			}
		}
		
		public void SetEmailOcrText(string EmailGuid, string OcrText, string AttachmentName)
		{
			AttachmentName = AttachmentName.Replace("\'", "\'\'");
			try
			{
				UTIL.CleanText(ref OcrText);
				OcrText = UTIL.ReplaceSingleQuotes(OcrText);
				this.BlankOutSingleQuotes(ref OcrText);
				
				string S = "update EmailAttachment set OcrText = \'" + OcrText.Trim() + "\' where EmailGuid = \'" + EmailGuid + "\' and AttachmentName = \'" + AttachmentName + "\'";
				bool b = ExecuteSqlNewConn(S, false);
				if (! b)
				{
					LOG.WriteToArchiveLog("ERROR: SetEmailOcrText 100 Failed to set Email OCR Attributes");
				}
			}
			catch (Exception)
			{
				LOG.WriteToArchiveLog("ERROR: SetEmailOcrText 200 Failed to set Email OCR Attributes");
			}
			
			
		}
		
		public void concatEmailBody(string BodyText, string EmailGuid)
		{
			
			try
			{
				
				BodyText = BodyText + GetEmailBody(EmailGuid);
				
				UTIL.CleanText(ref BodyText);
				
				BodyText = BodyText.Replace("\'", "`");
				
				string S = "update Email " + "\r\n";
				S += "set Body = \'" + BodyText + "\'" + "\r\n";
				S += " where EmailGuid = \'" + EmailGuid + "\'";
				bool b = ExecuteSqlNewConn(S);
				
				if (! b)
				{
					LOG.WriteToArchiveLog("ERROR: concatEmailBody 100 Failed to set Email body");
				}
				
			}
			catch (Exception)
			{
				LOG.WriteToArchiveLog("ERROR: concatEmailBody 200 Failed to set Email body");
			}
			
			
		}
		
		public void UpdateAttachmentCounts()
		{
			string S = "update Email ";
			S = S + " set NbrAttachments = (select count(*) from EmailAttachment where Email.EmailGuid = EmailAttachment.EmailGuid)";
			//S = S + " WHERE NbrAttachments Is NULL "
			bool B = this.ExecuteSqlNewConn(S, false);
			if (! B)
			{
				LOG.WriteToArchiveLog((string) ("NOTICE: Failed to update the Attachment counts for Emails." + "\r\n" + S));
			}
		}
		
		public void UserParmUpdate(string ParmName, string UserID, string ParmVal)
		{
			int iCnt = UserParmExists(ParmName, UserID);
			if (iCnt == 0)
			{
				return;
			}
			
			ParmName = UTIL.RemoveSingleQuotes(ParmName);
			ParmVal = UTIL.RemoveSingleQuotes(ParmVal);
			//ParmName = UTIL.RemoveSingleQuotes(ParmName)
			
			string S = "UPDATE [UserCurrParm]";
			S = S + " SET ParmVal = \'" + ParmVal + "\'";
			S = S + " where UserID = \'" + UserID + "\'";
			S = S + " and ParmName = \'" + ParmName + "\'";
			
			bool B = this.ExecuteSqlNewConn(S, false);
			if (! B)
			{
				MessageBox.Show("UserParmUpdate failed.");
			}
		}
		
		public void UserParmDelete(string ParmName, string UserID)
		{
			int iCnt = UserParmExists(ParmName, UserID);
			if (iCnt == 0)
			{
				return;
			}
			
			ParmName = UTIL.RemoveSingleQuotes(ParmName);
			//ParmVal = UTIL.RemoveSingleQuotes(ParmVal)
			//ParmName = UTIL.RemoveSingleQuotes(ParmName)
			
			string S = "delete from [UserCurrParm]";
			S = S + " where UserID = \'" + UserID + "\'";
			S = S + " and ParmName = \'" + ParmName + "\'";
			
			bool B = this.ExecuteSqlNewConn(S, false);
			if (! B)
			{
				MessageBox.Show("UserParmDelete Failed.");
			}
		}
		public ArrayList GetActiveEmailFolders(string UserID)
		{
			ArrayList A = new ArrayList();
			string S = "Select distinct foldername from EmailArchParms where UserID = \'" + UserID + "\'";
			SqlDataReader RSData = null;
			string foldername = "";
			
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						foldername = RSData.GetValue(0).ToString();
						if (! A.Contains(foldername))
						{
							A.Add(foldername);
						}
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase:GetActiveEmailFolders 300.23.1a - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase:GetActiveEmailFolders 300.23.1b - " + ex.StackTrace.ToString()));
			}
			
			RSData.Close();
			RSData = null;
			return A;
		}
		public bool ValidateCurrUserPW(string EncPW)
		{
			
			string S = "Select count(*) from Users where UserID = \'" + modGlobals.gCurrUserGuidID + "\' and UserPassword = \'" + EncPW + "\' ";
			SqlDataReader RSData = null;
			string foldername = "";
			bool B = false;
			
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					int i = RSData.GetInt32(0);
					if (i == 1)
					{
						B = true;
					}
					else
					{
						B = false;
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase:GetActiveEmailFolders 300.23.1a - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase:GetActiveEmailFolders 300.23.1b - " + ex.StackTrace.ToString()));
			}
			
			RSData.Close();
			RSData = null;
			GC.Collect();
			
			return B;
		}
		public string GetEmailRetentionCode(string FolderName, string UserID)
		{
			
			FolderName = UTIL.RemoveSingleQuotes(FolderName);
			
			string S = "";
			S = S + "Select RetentionCode from EmailFolder ";
			S = S + "where FolderName = \'" + FolderName + "\' ";
			S = S + "and UserID = \'" + UserID + "\'";
			
			SqlDataReader RSData = null;
			string rCode = "";
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						rCode = RSData.GetValue(0).ToString();
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase:GetActiveEmailFolders 300.23.1a - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDatabase:GetActiveEmailFolders 300.23.1b - " + ex.StackTrace.ToString()));
			}
			
			RSData.Close();
			RSData = null;
			return rCode;
		}
		public void UserParmInsert(string ParmName, string UserID, string ParmVal)
		{
			
			int iCnt = UserParmExists(ParmName, UserID);
			if (iCnt > 0)
			{
				return;
			}
			
			ParmVal = UTIL.RemoveSingleQuotes(ParmVal);
			
			string S = "INSERT INTO [UserCurrParm]";
			S = S + " ([UserID]";
			S = S + " ,[ParmName]";
			S = S + " ,[ParmVal])";
			S = S + " VALUES ";
			S = S + " (\'" + UserID + "\',";
			S = S + " \'" + ParmName + "\',";
			S = S + "\'" + ParmVal + "\')";
			
			bool b = this.ExecuteSqlNewConn(S, false);
			if (! b)
			{
				MessageBox.Show((string) ("Failed UserParmInsert " + S));
			}
		}
		
		public void UserParmInsertUpdate(string ParmName, string UserID, string ParmVal)
		{
			
			int iCnt = UserParmExists(ParmName, UserID);
			if (iCnt > 0)
			{
				UserParmUpdate(ParmName, UserID, ParmVal);
				return;
			}
			
			ParmVal = UTIL.RemoveSingleQuotes(ParmVal);
			
			string S = "INSERT INTO [UserCurrParm]";
			S = S + " ([UserID]";
			S = S + " ,[ParmName]";
			S = S + " ,[ParmVal])";
			S = S + " VALUES ";
			S = S + " (\'" + UserID + "\',";
			S = S + " \'" + ParmName + "\',";
			S = S + "\'" + ParmVal + "\')";
			
			bool b = this.ExecuteSqlNewConn(S, false);
			if (! b)
			{
				MessageBox.Show((string) ("Failed UserParmInsert " + S));
			}
		}
		public int iSelectCount(string S)
		{
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = RSData.GetInt32(0);
				RSData.Close();
				RSData = null;
				cmd.Connection.Close();
				cmd = null;
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			return cnt;
		}
		public int UserParmExists(string ParmName, string UserID)
		{
			string S = "";
			
			ParmName = UTIL.RemoveSingleQuotes(ParmName);
			//ParmVal = UTIL.RemoveSingleQuotes(ParmVal)
			//ParmName = UTIL.RemoveSingleQuotes(ParmName)
			
			S = S + " SELECT count(*)";
			S = S + " FROM [UserCurrParm]";
			S = S + " where UserID = \'" + UserID + "\'";
			S = S + " and ParmName = \'" + ParmName + "\'";
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = RSData.GetInt32(0);
				RSData.Close();
				RSData = null;
				cmd.Connection.Close();
				cmd = null;
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			return cnt;
		}
		
		public string UserParmRetrive(string ParmName, string UserID)
		{
			string S = "";
			int iCnt = UserParmExists(ParmName, UserID);
			if (iCnt == 0)
			{
				return "";
			}
			
			ParmName = UTIL.RemoveSingleQuotes(ParmName);
			//ParmVal = UTIL.RemoveSingleQuotes(ParmVal)
			//ParmName = UTIL.RemoveSingleQuotes(ParmName)
			
			S = S + " SELECT [ParmVal]";
			S = S + " FROM [UserCurrParm]";
			S = S + " where UserID = \'" + UserID + "\'";
			S = S + " and ParmName = \'" + ParmName + "\'";
			
			CloseConn();
			CkConn();
			
			string sVal = "";
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				
				
				RSData.Read();
				try
				{
					if (! RSData.IsDBNull(0))
					{
						sVal = RSData.GetString(0);
					}
					else
					{
						sVal = "";
					}
					
				}
				catch (Exception ex)
				{
					this.xTrace(27000, "UserParmRetrive", "clsDatabase", ex);
					sVal = "";
					LOG.WriteToArchiveLog((string) ("clsDatabase : UserParmRetrive : 6331 : " + ex.Message));
				}
				if (! RSData.IsClosed)
				{
					RSData.Close();
				}
				RSData = null;
				command.Dispose();
				command = null;
				
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			return sVal;
		}
		public string getHelpConnStr()
		{
			bool bUseConfig = true;
			string HelpConnStr = "";
			HelpConnStr = System.Configuration.ConfigurationManager.AppSettings["HELP.DB"];
			return HelpConnStr;
		}
		public void LoadUserSearchHistory(int MaxNbrSearches, string Uid, string Screen, ArrayList SearchHistoryArrayList, ref int NbrReturned)
		{
			try
			{
				NbrReturned = 0;
				SearchHistoryArrayList.Clear();
				int EntryID = -1;
				string QryParms = "";
				string S = "";
				S = S + " SELECT top " + MaxNbrSearches.ToString() + " [EntryID], QryParms ";
				S = S + " FROM [SearhParmsHistory] ";
				S = S + " where [UserID] = \'" + Uid + "\' ";
				S = S + " and Screen = \'" + Screen + "\'";
				S = S + " order by [EntryID] DESC ";
				SqlDataReader RSData = null;
				//RSData = SqlQryNo'Session(S)
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						NbrReturned++;
						EntryID = RSData.GetInt32(0);
						QryParms = RSData.GetValue(1).ToString();
						SearchHistoryArrayList.Add(QryParms);
					}
				}
				RSData.Close();
				RSData = null;
			}
			catch (Exception)
			{
				LOG.WriteToArchiveLog("NOTICE: clsDatabase:LoadUserSearchHistory - Failed to load search history.");
			}
		}
		public void LimitToExistingRecs(DataGridView DGV, string UIDCellName, string GuidCellName, ProgressBar PB, bool DeleteAll)
		{
			clsACTIVESEARCHGUIDS ASG = new clsACTIVESEARCHGUIDS();
			
			
			if (DeleteAll == true)
			{
				string S = "delete FROM ActiveSearchGuids where  UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
				bool B = ExecuteSqlNewConn(S, false);
			}
			
			int iRec = 0;
			PB.Value = 0;
			PB.Maximum = DGV.Rows.Count + 1;
			int iCnt = 0;
			foreach (DataGridViewRow DR in DGV.Rows)
			{
				try
				{
					iCnt++;
					PB.Value = iCnt;
					PB.Refresh();
					Application.DoEvents();
					string TgtGuid = DR.Cells[GuidCellName].Value.ToString();
					string TgtUserID = DR.Cells[UIDCellName].Value.ToString();
					ASG.setDocguid(ref TgtGuid);
					ASG.setUserid(ref TgtUserID);
					bool BB = ASG.Insert();
					if (BB)
					{
						if (dDebug)
						{
							LOG.WriteToTraceLog("clsDatabase:LimitingToExistingRecs SUCCESSFUL");
						}
					}
					else
					{
						if (dDebug)
						{
							LOG.WriteToTraceLog("clsDatabase:LimitingToExistingRecs FAILED \'" + TgtGuid + "\'");
						}
					}
				}
				catch (Exception ex)
				{
					Console.WriteLine(ex.Message);
				}
			}
			PB.Value = 0;
			ASG = null;
		}
		
		public void LimitToExistingRecs(List<string> CurrentGuids)
		{
			
			clsACTIVESEARCHGUIDS ASG = new clsACTIVESEARCHGUIDS();
			string S = "delete FROM ActiveSearchGuids where  UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
			bool B = ExecuteSqlNewConn(S, false);
			
			int iRec = 0;
			int iCnt = 0;
			for (iCnt = 0; iCnt <= CurrentGuids.Count - 1; iCnt++)
			{
				try
				{
					Application.DoEvents();
					string TgtGuid = CurrentGuids(iCnt);
					string TgtUserID = modGlobals.gCurrUserGuidID;
					ASG.setDocguid(ref TgtGuid);
					ASG.setUserid(ref TgtUserID);
					bool BB = ASG.Insert();
					if (BB)
					{
						if (dDebug)
						{
							LOG.WriteToTraceLog("clsDatabase:LimitingToExistingRecs SUCCESSFUL");
						}
					}
					else
					{
						if (dDebug)
						{
							LOG.WriteToTraceLog("clsDatabase:LimitingToExistingRecs FAILED \'" + TgtGuid + "\'");
						}
					}
				}
				catch (Exception ex)
				{
					Console.WriteLine(ex.Message);
				}
			}
			ASG = null;
		}
		
		public string getDefaultThesaurus()
		{
			//Dim EcmLibConnectionString As String = ""
			
			string DefaultThesaurus = "";
			string s = "";
			
			CloseConn();
			CkConn();
			
			try
			{
				string tQuery = "";
				s = "Select [SysParmVal] FROM [SystemParms] where [SysParm] = \'Default Thesaurus\' ";
				using (gConn)
				{
					
					SqlDataReader RSData = null;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(s, CONN);
					RSData = command.ExecuteReader();
					RSData.Read();
					DefaultThesaurus = RSData.GetValue(0).ToString();
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				
			}
			catch (Exception ex)
			{
				//xTrace(12335, "clsDataBase:iGetRowCount", ex.Message)
				//messagebox.show("Error 3932.11: " + ex.Message)
				if (dDebug)
				{
					Debug.Print((string) ("Error 3932.11.10: CountOfThesauri " + ex.Message));
				}
				Console.WriteLine("Error 3932.11.10: getDefaultThesaurus" + ex.Message);
				DefaultThesaurus = "";
				LOG.WriteToArchiveLog((string) ("clsDB : getDefaultThesaurus : 100 : " + ex.Message));
			}
			if (gConn.State != ConnectionState.Closed)
			{
				gConn.Close();
			}
			gConn = null;
			GC.Collect();
			return DefaultThesaurus;
		}
		
		public string ExpandInflectionTerms(string S)
		{
			string Msg = "";
			try
			{
				SqlDataReader RSData = null;
				//RSData = SqlQryNo'Session(S)
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						string S1 = RSData.GetValue(0).ToString();
						string S2 = RSData.GetValue(1).ToString();
						Msg = Msg + S1 + " : " + S2 + "\r\n";
					}
				}
				RSData.Close();
				RSData = null;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase : ExpandInflectionTerms : 100 : " + ex.Message));
			}
			return Msg;
		}
		//SELECT COUNT(*) FROM [DB_UpdateHist] where [FixID] = 1 and Status = 'applied'
		public int ckDbUpdate(string FixID)
		{
			string S = "Select COUNT(*) FROM [DB_UpdateHist] where [FixID] = " + FixID + " and Status = \'applied\'";
			int ii = 0;
			try
			{
				SqlDataReader RSData = null;
				//RSData = SqlQryNo'Session(S)
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						ii = RSData.GetInt32(0);
					}
				}
				RSData.Close();
				RSData = null;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase : ckDbUpdate : 100 : " + ex.Message));
			}
			return ii;
		}
		public void DeleteEmailByGuid(string EmailGuid)
		{
			clsSEARCHHISTORY SHIST = new clsSEARCHHISTORY();
			
			string S = "";
			bool B = true;
			
			S = "delete from Recipients where EmailGuid = \'" + EmailGuid + "\'";
			B = this.ExecuteSqlNewConn(S, false);
			if (! B)
			{
				LOG.WriteToArchiveLog("Error 126.77.13 - failed to delete Recipients = \'" + EmailGuid + "\'");
			}
			else
			{
				LOG.WriteToArchiveLog("Notice 126.77.13 - Deleted Email Recipients = \'" + EmailGuid + "\'");
				SHIST.setCalledfrom("clsDatabase:DeleteEmailByGuid");
				SHIST.setEndtime(DateTime.Now.ToString());
				SHIST.setReturnedrows("1");
				SHIST.setTypesearch("Delete");
				SHIST.setStarttime(DateTime.Now.ToString());
				SHIST.setSearchdate(DateTime.Now.ToString());
				SHIST.setSearchsql(ref S);
				SHIST.setUserid(ref modGlobals.gCurrUserGuidID);
				B = SHIST.Insert();
				if (! B)
				{
					Console.WriteLine("Error 1943.244 - Failed to save history of search.");
				}
			}
			
			S = "delete from LibraryItems where SourceGuid = \'" + EmailGuid + "\'";
			B = this.ExecuteSqlNewConn(S, false);
			if (! B)
			{
				LOG.WriteToArchiveLog("Error 126.77.13a - failed to delete Library Items = \'" + EmailGuid + "\'");
			}
			
			S = "delete from EmailAttachment where EmailGuid = \'" + EmailGuid + "\'";
			B = this.ExecuteSqlNewConn(S, false);
			if (! B)
			{
				LOG.WriteToArchiveLog("Error 126.77.13 - failed to delete EmailAttachment = \'" + EmailGuid + "\'");
			}
			else
			{
				LOG.WriteToArchiveLog("Notice 126.77.13 - Deleted Email EmailAttachment = \'" + EmailGuid + "\'");
				SHIST.setCalledfrom("clsDatabase:DeleteEmailByGuid");
				SHIST.setEndtime(DateTime.Now.ToString());
				SHIST.setReturnedrows("1");
				SHIST.setTypesearch("Delete");
				SHIST.setStarttime(DateTime.Now.ToString());
				SHIST.setSearchdate(DateTime.Now.ToString());
				SHIST.setSearchsql(ref S);
				SHIST.setUserid(ref modGlobals.gCurrUserGuidID);
				B = SHIST.Insert();
				if (! B)
				{
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine("Error 1943.244 - Failed to save history of search.");
					}
					LOG.WriteToArchiveLog("Notice 1943.244 - Failed to save history of search = \'" + EmailGuid + "\'");
				}
			}
			S = "delete from Email where EmailGuid = \'" + EmailGuid + "\'";
			B = this.ExecuteSqlNewConn(S, false);
			if (! B)
			{
				LOG.WriteToArchiveLog("Error 126.77.13 - failed to delete Email = \'" + EmailGuid + "\'");
			}
			else
			{
				LOG.WriteToArchiveLog("Notice 1943.244 -  failed to delete Email = \'" + EmailGuid + "\'");
				SHIST.setCalledfrom("clsDatabase:DeleteEmailByGuid");
				SHIST.setEndtime(DateTime.Now.ToString());
				SHIST.setReturnedrows("1");
				SHIST.setTypesearch("Delete");
				SHIST.setStarttime(DateTime.Now.ToString());
				SHIST.setSearchdate(DateTime.Now.ToString());
				SHIST.setSearchsql(ref S);
				SHIST.setUserid(ref modGlobals.gCurrUserGuidID);
				B = SHIST.Insert();
				if (! B)
				{
					if (modGlobals.gClipBoardActive == true)
					{
						Console.WriteLine("Error 1943.244 - Failed to save history of search.");
					}
					LOG.WriteToArchiveLog("Error 1943.244 - Failed to save history of search." + EmailGuid + "\'");
				}
			}
			
			SHIST = null;
		}
		public void DeleteSourceByGuid(string SourceGuid)
		{
			string S = "";
			bool B = true;
			
			S = "delete from SourceAttribute where SourceGuid = \'" + SourceGuid + "\'";
			B = this.ExecuteSqlNewConn(S, false);
			if (! B)
			{
				LOG.WriteToArchiveLog("Error 126.77.13 - failed to delete SourceAttribute = \'" + SourceGuid + "\'");
			}
			S = "delete from DataSource  where SourceGuid = \'" + SourceGuid + "\'";
			B = this.ExecuteSqlNewConn(S, false);
			if (! B)
			{
				LOG.WriteToArchiveLog("Error 126.77.13 - failed to delete DataSource = \'" + SourceGuid + "\'");
			}
		}
		public void RetentionTempZeroize()
		{
			string S = "DELETE FROM [RetentionTemp] WHERE UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
			bool B = this.ExecuteSqlNewConn(S, false);
			if (! B)
			{
				LOG.WriteToArchiveLog("Error 772.00.13 - failed to Zeroize RetentionTemp");
			}
		}
		public void RetentionTempInsert(string UserID, string ContentGuid, string TypeContent)
		{
			
			string S = "";
			S = S + " INSERT INTO [RetentionTemp]";
			S = S + " ([UserID]";
			S = S + " ,[ContentGuid]";
			S = S + " ,[TypeContent])";
			S = S + " VALUES";
			S = S + " (\'" + UserID + "\'";
			S = S + " ,\'" + ContentGuid + "\'";
			S = S + " ,\'" + TypeContent + "\')";
			bool B = this.ExecuteSqlNewConn(S, false);
			if (! B)
			{
				LOG.WriteToArchiveLog("Error 772.00.13 - failed to Zeroize RetentionTemp");
			}
			
		}
		public int RetentionTempCountType(string TypeContent, string UserID)
		{
			
			string S = "";
			
			S = S + " SELECT COUNT(*) as iCnt";
			S = S + " FROM [RetentionTemp] ";
			S = S + " where [TypeContent] = \'" + TypeContent + "\' and UserID = \'" + UserID + "\' ";
			
			CloseConn();
			CkConn();
			
			int cnt = 0;
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = RSData.GetInt32(0);
				RSData.Close();
				RSData = null;
				cmd.Connection.Close();
				cmd = null;
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			return cnt;
		}
		public bool adminExist()
		{
			string S = "";
			S = S + " SELECT [UserID]";
			S = S + " ,[UserName]";
			S = S + " ,[EmailAddress]";
			S = S + " ,[UserPassword]";
			S = S + " ,[Admin]";
			S = S + " ,[isActive]";
			S = S + " ,[UserLoginID]";
			S = S + " FROM [Users]";
			S = S + " where UserLoginID = \'admin\'";
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			bool b = false;
			
			using (Conn)
			{
				if (Conn.State == ConnectionState.Closed)
				{
					Conn.Open();
				}
				
				SqlCommand command = new SqlCommand(S, Conn);
				SqlDataReader RSData = null;
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
					Conn.Close();
					Conn = null;
					return true;
				}
				else
				{
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
					Conn.Close();
					Conn = null;
					S = "";
					S = S + "INSERT INTO [Users]";
					S = S + "([UserID]";
					S = S + ",[UserName]";
					S = S + ",[EmailAddress]";
					S = S + ",[UserPassword]";
					S = S + ",[Admin]";
					S = S + ",[isActive]";
					S = S + ",[UserLoginID])";
					S = S + "VALUES( ";
					S = S + "\'admin\'";
					S = S + ",\'administrator\'";
					S = S + ",\'NA\'";
					S = S + ",\'password\'";
					S = S + ",\'Y\'";
					S = S + ",\'Y\'";
					S = S + ",\'admin\')";
					b = this.ExecuteSqlNewConn(S, false);
					if (! b)
					{
						MessageBox.Show("Failed to add the required ADMIN account. Add the account manually to allow login.");
						return false;
					}
					else
					{
						MessageBox.Show("The ADMIN account has been created, you will have to login under ADMIN using the password \'password\' to continue." + "\r\n" + "You must change the password or security will be compromised.");
						return false;
					}
				}
				
			}
			
		}
		public bool LicenseVersionExist(string VersionNbr)
		{
			string S = (string) ("Select count(*) FROM [License] where VersionNbr = " + VersionNbr);
			CloseConn();
			CkConn();
			
			int cnt = -1;
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = RSData.GetInt32(0);
				RSData.Close();
				RSData = null;
				cmd.Connection.Close();
				cmd = null;
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			if (cnt == 0)
			{
				return false;
			}
			else
			{
				return true;
			}
			
		}
		public void getLicenseDataCurrent(ref string ExistingVersionNbr, ref string ExistingActivationDate, ref string ExistingInstallDate, ref string ExistingCustomerID, ref string ExistingCustomerName, ref string ExistingLicenseID, ref string ExistingXrtNxr1, ref string ExistingServerIdentifier, ref string ExistingSqlInstanceIdentifier)
		{
			
			string S = "";
			S = S + "Select [Agreement] ";
			S = S + "      ,[VersionNbr] ";
			S = S + "      ,[ActivationDate] ";
			S = S + "      ,[InstallDate] ";
			S = S + "      ,[CustomerID] ";
			S = S + "      ,[CustomerName] ";
			S = S + "      ,[LicenseID] ";
			S = S + "      ,[XrtNxr1] ";
			S = S + "      ,[SqlServerInstanceNameX] ";
			S = S + "      ,[SqlServerMachineName] ";
			S = S + "  FROM [License] ";
			S = S + "  where VersionNbr = (select MAX(versionnbr) from License) ";
			
			CloseConn();
			CkConn();
			
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					ExistingVersionNbr = RSData.GetValue(0).ToString();
					ExistingActivationDate = RSData.GetValue(0).ToString();
					ExistingInstallDate = RSData.GetValue(0).ToString();
					ExistingCustomerID = RSData.GetValue(0).ToString();
					ExistingCustomerName = RSData.GetValue(0).ToString();
					ExistingLicenseID = RSData.GetValue(0).ToString();
					ExistingXrtNxr1 = RSData.GetValue(0).ToString();
					ExistingServerIdentifier = RSData.GetValue(0).ToString();
					ExistingSqlInstanceIdentifier = RSData.GetValue(0).ToString();
				}
				RSData.Close();
				RSData = null;
				cmd.Connection.Close();
				cmd = null;
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			
			
		}
		public int CountQuickRefItems(int QuickRefIdNbr)
		{
			
			string S = (string) ("Select count(*) from QuickRefItems where QuickRefIdNbr = " + QuickRefIdNbr.ToString());
			CloseConn();
			CkConn();
			
			int cnt = -1;
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = RSData.GetInt32(0);
				RSData.Close();
				RSData = null;
				cmd.Connection.Close();
				cmd = null;
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			
			return cnt;
			
		}
		public int getQuickRefId(string QuickRef)
		{
			
			string S = "Select QuickRefIdNbr from QuickRef where QuickRefName = \'" + QuickRef + "\'";
			CloseConn();
			CkConn();
			
			int cnt = -1;
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					cnt = RSData.GetInt32(0);
				}
				RSData.Close();
				RSData = null;
				cmd.Connection.Close();
				cmd = null;
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			
			return cnt;
			
		}
		public void retrieveSearchHistory(ArrayList SearchHistoryArrayList)
		{
			
			SearchHistoryArrayList.Clear();
			string S = "Select top 25 * from SearchHistory where UserID = \'" + modGlobals.gCurrUserGuidID + "\' order by RowID desc ";
			int ii = 0;
			try
			{
				SqlDataReader RSData = null;
				//RSData = SqlQryNo'Session(S)
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						ii = RSData.GetInt32(0);
					}
				}
				RSData.Close();
				RSData = null;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase : ckDbUpdate : 100 : " + ex.Message));
			}
			
		}
		public void AddMissingCrc()
		{
			//SELECT FQN, SourceGuid FROM DataSource
			string S = "Select count(*) ";
			S = S + " FROM DataSource ";
			string WC = " where DataSource.SourceGuid not in (Select SourceGuid from SourceAttribute where AttributeName = \'CRC\')";
			
			int iMax = iGetRowCount("DataSource", WC);
			
			S = "Select DataSource.FQN, DataSource.SourceGuid";
			S = S + " FROM DataSource ";
			S = S + " where DataSource.SourceGuid not in (";
			S = S + " Select SourceGuid from SourceAttribute where AttributeName = \'CRC\')";
			int ii = 0;
			string FQN = "";
			string sGuid = "";
			//'FrmMDIMain.TSPB1.Maximum = iMax + 2
			
			try
			{
				SqlDataReader RSData = null;
				//RSData = SqlQryNo'Session(S)
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						ii++;
						//'FrmMDIMain.TSPB1.Value = ii
						//If ii Mod 100 = 0 Then
						//    frmreconMain.SB.Text = ii.ToString
						//    ''FrmMDIMain.Refresh()
						//End If
						Application.DoEvents();
						FQN = RSData.GetValue(0).ToString();
						sGuid = RSData.GetValue(1).ToString();
						File F;
						if (F.Exists(FQN))
						{
							string HexStr = ENC.getSha1HashFromFile(FQN);
							InsertSrcAttrib(sGuid, "CRC", HexStr, "CONTENT");
						}
					}
				}
				RSData.Close();
				RSData = null;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase : ckDbUpdate : 100 : " + ex.Message));
			}
			//'FrmMDIMain.TSPB1.Value = 0
		}
		public void InsertSrcAttrib(string SGUID, string aName, string aVal, string OriginalFileType)
		{
			clsSOURCEATTRIBUTE SRCATTR = new clsSOURCEATTRIBUTE();
			SRCATTR.setSourceguid(ref SGUID);
			SRCATTR.setAttributename(ref aName);
			SRCATTR.setAttributevalue(ref aVal);
			SRCATTR.setDatasourceowneruserid(ref modGlobals.gCurrUserGuidID);
			SRCATTR.setSourcetypecode(ref OriginalFileType);
			SRCATTR.Insert();
			SRCATTR = null;
		}
		//select count(*) from Attributes where AttributeName = 'XX'
		public void AttributeExists(string AttributeName)
		{
			//SELECT FQN, SourceGuid FROM DataSource
			string S = "Select count(*) from Attributes where AttributeName = \'" + AttributeName + "\'";
			string WC = " where AttributeName = \'" + AttributeName + "\'";
			int iMax = iGetRowCount("Attributes", WC);
			
			if (iMax > 0)
			{
				return;
			}
			
			S = "";
			S = S + " INSERT INTO [Attributes]";
			S = S + " ([AttributeName]";
			S = S + " ,[AttributeDataType]";
			S = S + " ,[AttributeDesc]";
			S = S + " ,[AssoApplication])";
			S = S + " VALUES ";
			S = S + " (\'" + AttributeName + "\'";
			S = S + " ,\'NVARCHAR\'";
			S = S + " ,\'ADDED BY ECM Library\'";
			S = S + " ,\'???\')";
			
			bool B = this.ExecuteSqlNewConn(S, false);
			if (! B)
			{
				LOG.WriteToArchiveLog("clsDatabase : AttributeExists : 100 : Failed to add attribute.");
			}
			
		}
		public bool ckAttributeExists(string AttributeName)
		{
			
			string S = "Select count(*) from Attributes where AttributeName = \'" + AttributeName + "\'";
			string WC = " where AttributeName = \'" + AttributeName + "\'";
			int iMax = iGetRowCount("Attributes", WC);
			
			if (iMax > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
			
			
		}
		public void RemoveFreetextStopWords(ref string SearchPhrase)
		{
			
			SearchPhrase = SearchPhrase.Trim();
			if (SearchPhrase.Trim().Length == 0)
			{
				return;
			}
			
			ArrayList AL = new ArrayList();
			GetSkipWords(AL);
			
			for (int i = 1; i <= SearchPhrase.Length; i++)
			{
				string CH = SearchPhrase.Substring(i - 1, 1);
				if (CH == '\u0022')
				{
					StringType.MidStmtStr(ref SearchPhrase, i, 1, " ");
				}
			}
			string NewPhrase = "";
			string[] A = SearchPhrase.Split(' '.ToString().ToCharArray());
			for (int i = 0; i <= (A.Length - 1); i++)
			{
				string tWord = A[i].Trim();
				string TempWord = tWord;
				tWord = tWord.ToUpper();
				if (tWord.Length > 0)
				{
					if (AL.Contains(tWord))
					{
						A[i] = "";
					}
					else
					{
						A[i] = TempWord;
					}
				}
			}
			NewPhrase = "";
			for (int i = 0; i <= (A.Length - 1); i++)
			{
				if (A[i].Trim().Length > 0)
				{
					NewPhrase = NewPhrase + " " + A[i];
				}
			}
			SearchPhrase = NewPhrase;
		}
		
		public bool SetSourceGlobalAccessFlags(string tgtGuid, string FileType, bool rbPublic, bool rbPrivate, bool rbMstrYes, bool rbMstrNot, TextBox SB)
		{
			
			string tKey = tgtGuid;
			bool Bb = true;
			
			if (rbPublic)
			{
				string SS = "";
				
				bool isOwner = ValidateContentOwnership(tgtGuid, FileType);
				if (isOwner == false)
				{
					isOwner = ValidateCoOwnerOfContent(tgtGuid, FileType);
					if (isOwner == false)
					{
						//SB.Text = "You do not own all of this content, so some changes are not allowed."
						SB.Text = "You do not own all of this content, so some changes are not allowed.";
						return false;
					}
				}
				
				if (! FileType.ToUpper().Equals(".MSG") && ! FileType.ToUpper().Equals(".EML"))
				{
					SS = "Update DataSource set isPublic = \'Y\' where SourceGuid = \'" + tKey + "\'";
				}
				else
				{
					SS = "Update email set isPublic = \'Y\' where EmailGuid = \'" + tKey + "\'";
				}
				Bb = ExecuteSqlNewConn(SS, false);
				if (Bb)
				{
					LOG.WriteToArchiveLog("Reset the isPublic  for guid \'" + tKey + "\'");
				}
			}
			if (rbPrivate)
			{
				string SS = "";
				
				bool isOwner = ValidateContentOwnership(tgtGuid, FileType);
				if (isOwner == false)
				{
					isOwner = ValidateCoOwnerOfContent(tgtGuid, FileType);
					if (isOwner == false)
					{
						SB.Text = "You do not own all of this content, so some changes are not allowed.";
						//messagebox.show("You do not own all of this content, so some changes are not allowed.")
						return false;
					}
				}
				
				if (! FileType.ToUpper().Equals(".MSG") && ! FileType.ToUpper().Equals(".EML"))
				{
					SS = "Update DataSource set isPublic = \'N\' where SourceGuid = \'" + tKey + "\'";
				}
				else
				{
					SS = "Update email set isPublic = \'N\' where EmailGuid = \'" + tKey + "\'";
				}
				Bb = ExecuteSqlNewConn(SS, false);
				if (Bb)
				{
					LOG.WriteToArchiveLog("Reset the isPublic  for guid \'" + tKey + "\'");
				}
			}
			if (rbMstrYes)
			{
				string SS = "";
				
				bool isOwner = ValidateContentOwnership(tgtGuid, FileType);
				if (isOwner == false)
				{
					isOwner = ValidateCoOwnerOfContent(tgtGuid, FileType);
					if (isOwner == false)
					{
						SB.Text = "You do not own all of this content, so some changes are not allowed.";
						//messagebox.show("You do not own all of this content, so some changes are not allowed.")
						return false;
					}
				}
				
				if (! FileType.ToUpper().Equals(".MSG") && ! FileType.ToUpper().Equals(".EML"))
				{
					
					SS = "Update DataSource set isMaster = \'Y\' where SourceGuid = \'" + tKey + "\'";
					//Else
					//    SS  = "Update email set isPublic = 'Y' where EmailGuid = '" + tKey  + "'"
					Bb = ExecuteSqlNewConn(SS, false);
					if (Bb)
					{
						LOG.WriteToArchiveLog("Reset the isMaster for guid \'" + tKey + "\'");
					}
				}
				else
				{
					SS = "Update Email set isMaster = \'Y\' where EmaileGuid = \'" + tKey + "\'";
					//Else
					//    SS  = "Update email set isPublic = 'N' where EmailGuid = '" + tKey  + "'"
					Bb = ExecuteSqlNewConn(SS, false);
					if (Bb)
					{
						LOG.WriteToArchiveLog("Reset the isMaster  for EMAIL guid \'" + tKey + "\'");
					}
				}
			}
			if (rbMstrNot)
			{
				
				
				string SS = "";
				
				bool isOwner = ValidateContentOwnership(tgtGuid, FileType);
				if (isOwner == false)
				{
					isOwner = ValidateCoOwnerOfContent(tgtGuid, FileType);
					if (isOwner == false)
					{
						SB.Text = "You do not own all of this content, so some changes are not allowed.";
						//messagebox.show("You do not own all of this content, so some changes are not allowed.")
						return false;
					}
				}
				
				if (! FileType.ToUpper().Equals(".MSG") && ! FileType.ToUpper().Equals(".EML"))
				{
					SS = "Update DataSource set isMaster = \'N\' where SourceGuid = \'" + tKey + "\'";
					//Else
					//    SS  = "Update email set isPublic = 'N' where EmailGuid = '" + tKey  + "'"
					Bb = ExecuteSqlNewConn(SS, false);
					if (Bb)
					{
						LOG.WriteToArchiveLog("Reset the isMaster  for guid \'" + tKey + "\'");
					}
				}
				else
				{
					SS = "Update Email set isMaster = \'N\' where EmaileGuid = \'" + tKey + "\'";
					//Else
					//    SS  = "Update email set isPublic = 'N' where EmailGuid = '" + tKey  + "'"
					Bb = ExecuteSqlNewConn(SS, false);
					if (Bb)
					{
						LOG.WriteToArchiveLog("Reset the isMaster  for EMAIL guid \'" + tKey + "\'");
					}
				}
				
			}
			return Bb;
		}
		public bool DoIownThisContent(string SourceGuid)
		{
			
			bool b = true;
			int i = 0;
			string id = "";
			string S = "";
			
			try
			{
				S = S + " select DataSourceOwnerUserID  ";
				S = S + " from DataSource ";
				S = S + " where SourceGuid = \'" + SourceGuid + "\' ";
				
				SqlDataReader RSData = null;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				
				if (RSData.HasRows)
				{
					RSData.Read();
					id = RSData.GetValue(0).ToString();
					if (id == modGlobals.gCurrUserGuidID)
					{
						b = true;
					}
					else
					{
						b = false;
					}
				}
				else
				{
					id = -1.ToString();
				}
				RSData.Close();
				RSData = null;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase:DoIownThisContent: " + ex.Message + "\r\n" + S));
				b = false;
			}
			return b;
		}
		
		public bool isEmailPublic(string EmailGuid)
		{
			
			bool b = true;
			int i = 0;
			string id = "";
			string S = "";
			
			try
			{
				S = "Select ispublic from Email where EmailGuid = \'" + EmailGuid + "\'";
				
				SqlDataReader RSData = null;
				//Dim CS  = getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata= command.ExecuteReader()
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				
				
				if (RSData.HasRows)
				{
					RSData.Read();
					id = RSData.GetValue(0).ToString();
					if (id.ToUpper().Equals("Y"))
					{
						b = true;
					}
					else
					{
						b = false;
					}
				}
				else
				{
					b = false;
				}
				RSData.Close();
				RSData = null;
				
				
				command.Dispose();
				command = null;
				
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase:isEmailPublic: " + ex.Message + "\r\n" + S));
				b = false;
			}
			return b;
		}
		public void ZeroizeGlobalSearch()
		{
			string S = "delete from GlobalSeachResults where UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
			bool B = false;
			try
			{
				B = ExecuteSqlNewConn(S, false);
				if (! B)
				{
					LOG.WriteToArchiveLog((string) ("ERROR 100 - clsDatabase:ZeroizeGlobalSearch: Failed to seroize global search - " + "\r\n" + S));
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR 200 - clsDatabase:ZeroizeGlobalSearch: " + ex.Message));
				B = false;
			}
		}
		public string getOwnerGuid(string SourceGuid)
		{
			//select DataSourceOwnerUserID from DataSource where SourceGuid= 'XX'
			bool b = true;
			int i = 0;
			string id = "";
			string S = "";
			
			try
			{
				S = "Select DataSourceOwnerUserID from DataSource where SourceGuid= \'" + SourceGuid + "\'";
				
				SqlDataReader RSData = null;
				
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				
				if (RSData.HasRows)
				{
					RSData.Read();
					id = RSData.GetValue(0).ToString();
				}
				else
				{
					id = "";
				}
				if (! RSData.IsClosed)
				{
					RSData.Close();
				}
				RSData = null;
				command.Dispose();
				command = null;
				
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase:getOwnerGuid: " + ex.Message + "\r\n" + S));
				id = "";
			}
			return id;
		}
		public bool ckContentOwnership(string SourceGuid, string LoggedInUserGuid)
		{
			
			if (isAdmin(LoggedInUserGuid))
			{
				return true;
			}
			
			bool b = true;
			int i = 0;
			string id = "";
			string S = "";
			string OwnerGuid = getOwnerGuid(SourceGuid);
			if (OwnerGuid.Equals(LoggedInUserGuid))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		public void GetAllLibrariesUserCanAccess(ArrayList AccessibleLibraries, bool isAdmin)
		{
			SqlDataReader rsData = null;
			string LibraryName = "";
			AccessibleLibraries.Clear();
			
			if (isAdmin == true)
			{
				string S = "Select LibraryName, UserID from Library order by LibraryName";
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					while (rsData.Read())
					{
						LibraryName = rsData.GetValue(0).ToString();
						if (! AccessibleLibraries.Contains(LibraryName))
						{
							AccessibleLibraries.Add(LibraryName);
						}
					}
				}
			}
			else
			{
				try
				{
					string S = "Select   distinct   GroupLibraryAccess.LibraryName ";
					S = S + " FROM         GroupUsers INNER JOIN";
					S = S + " GroupLibraryAccess ON GroupUsers.UserID = GroupLibraryAccess.UserID";
					S = S + " group by GroupUsers.UserID, GroupLibraryAccess.LibraryName, GroupLibraryAccess.GroupName  ";
					S = S + " HAVING      (GroupUsers.UserID = \'" + modGlobals.gCurrUserGuidID + "\')  ";
					
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					rsData = command.ExecuteReader();
					if (rsData.HasRows)
					{
						while (rsData.Read())
						{
							LibraryName = rsData.GetValue(0).ToString();
							if (! AccessibleLibraries.Contains(LibraryName))
							{
								AccessibleLibraries.Add(LibraryName);
							}
						}
					}
					
					if (! rsData.IsClosed)
					{
						rsData.Close();
					}
					
					S = "Select LibraryName from Library where userid = \'" + modGlobals.gCurrUserGuidID + "\'";
					CONN = new SqlConnection(CS);
					CONN.Open();
					command = new SqlCommand(S, CONN);
					rsData = command.ExecuteReader();
					if (rsData.HasRows)
					{
						while (rsData.Read())
						{
							LibraryName = rsData.GetValue(0).ToString();
							if (! AccessibleLibraries.Contains(LibraryName))
							{
								AccessibleLibraries.Add(LibraryName);
							}
						}
					}
					
				}
				catch (Exception)
				{
					
				}
			}
			
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			GC.Collect();
			
		}
		public string getServerInstanceName()
		{
			
			string S = "Select @@SERVERNAME AS \'ServerName\'";
			SqlDataReader rsData = null;
			string ServerName = "";
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				while (rsData.Read())
				{
					ServerName = rsData.GetValue(0).ToString();
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase:getServerName Error 100: " + ex.Message));
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			GC.Collect();
			return ServerName;
			
		}
		public string getServerMachineName()
		{
			
			string S = "Select SERVERPROPERTY(\'MachineName\')";
			SqlDataReader rsData = null;
			string ServerName = "";
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				while (rsData.Read())
				{
					ServerName = rsData.GetValue(0).ToString();
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase:getServerName Error 100: " + ex.Message));
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			GC.Collect();
			return ServerName;
			
		}
		
		public bool setServerIdentifier(string SqlServerInstanceNameX, string CustomerID, string LicenseID)
		{
			string X = ENC.AES256EncryptString(SqlServerInstanceNameX);
			X = UTIL.RemoveSingleQuotes(X);
			string S = "Update License set  SqlServerInstanceNameX = \'" + SqlServerInstanceNameX + "\' where CustomerID = \'" + CustomerID + "\' and VersionNbr = \'" + LicenseID + "\'";
			bool B = this.ExecuteSqlNewConn(S);
			if (B == false)
			{
				LOG.WriteToArchiveLog("clsDatabase:setServerIdentifier Error 100: Failed to add Server Identifier, system may be inoperable.");
				MessageBox.Show("clsDatabase:setServerIdentifier Error 100: Failed to add Server Identifier, system may be inoperable.");
				return false;
			}
			return true;
		}
		public string getServerIdentifier(string CustomerID, string LicenseID)
		{
			string SqlServerInstanceNameX = "";
			string S = "Select SqlServerInstanceNameX from License where CustomerID = \'" + CustomerID + "\' and VersionNbr = \'" + LicenseID + "\'";
			SqlDataReader rsData = null;
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					rsData.Read();
					SqlServerInstanceNameX = rsData.GetValue(0).ToString();
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase:getServerIdentifier Error 100: " + ex.Message));
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			GC.Collect();
			return SqlServerInstanceNameX;
		}
		
		public bool setSqlInstanceIdentifier(string SqlServerMachineName, string CustomerID, string LicenseID)
		{
			string X = ENC.AES256EncryptString(SqlServerMachineName);
			X = UTIL.RemoveSingleQuotes(X);
			string S = "Update License set  SqlServerInstanceNameX = \'" + SqlServerMachineName + "\' where CustomerID = \'" + CustomerID + "\' and LicenseID = \'" + LicenseID + "\'";
			bool B = this.ExecuteSqlNewConn(S);
			if (B == false)
			{
				LOG.WriteToArchiveLog("clsDatabase:setServerIdentifier Error 100: Failed to add SQL Instance Identifier, system may be inoperable.");
				MessageBox.Show("clsDatabase:setServerIdentifier Error 100: Failed to add SQL Instance Identifier, system may be inoperable.");
				return false;
			}
			return true;
		}
		public bool getSqlInstanceIdentifier(string CustomerID, string LicenseID)
		{
			string SqlServerMachineName = "";
			string S = "Select SqlServerMachineName from License where CustomerID = \'" + CustomerID + "\' and LicenseID = \'" + LicenseID + "\'";
			SqlDataReader rsData = null;
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					rsData.Read();
					SqlServerMachineName = rsData.GetValue(0).ToString();
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase:getSqlInstanceIdentifier Error 100: " + ex.Message));
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			GC.Collect();
			return bool.Parse(SqlServerMachineName);
		}
		public static byte[] StrToByteArray(string str)
		{
			System.Text.ASCIIEncoding encoding = new System.Text.ASCIIEncoding();
			//Dim encoding As New System.Text.UnicodeEncoding
			return encoding.GetBytes(str);
		} //StrToByteArray
		public void getSatusFlags(CheckBox isPublic, CheckBox isMaster, CheckBox isWebPage, string SourceGuid, string SourceType)
		{
			string sPublic = "";
			string sMaster = "";
			string sWebPage = "";
			isMaster.Checked = false;
			isPublic.Checked = false;
			isWebPage.Checked = false;
			string S = "";
			if (SourceType.ToUpper().Equals(".EML"))
			{
				S = "Select isPublic, \'N\' as isMaster, \'N\' as isWebPage from EMAIL where EmailGuid = \'" + SourceGuid + "\' ";
			}
			else if (SourceType.ToUpper().Equals(".MSG"))
			{
				S = "Select isPublic, \'N\' as isMaster, \'N\' as isWebPage from EMAIL where EmailGuid = \'" + SourceGuid + "\' ";
			}
			else
			{
				S = "Select isPublic, isMaster, isWebPage from DataSource where SourceGuid = \'" + SourceGuid + "\'";
			}
			SqlDataReader rsData = null;
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					rsData.Read();
					try
					{
						if (Information.IsDBNull(rsData.GetValue(0).ToString()))
						{
							sPublic = "N";
						}
						else
						{
							sPublic = rsData.GetValue(0).ToString();
						}
					}
					catch (Exception)
					{
						sPublic = "N";
					}
					try
					{
						if (Information.IsDBNull(rsData.GetValue(1).ToString()))
						{
							sMaster = "N";
						}
						else
						{
							sMaster = rsData.GetValue(1).ToString();
						}
					}
					catch (Exception)
					{
						sMaster = "N";
					}
					try
					{
						if (Information.IsDBNull(rsData.GetValue(2).ToString()))
						{
							sWebPage = "N";
						}
						else
						{
							sWebPage = rsData.GetValue(2).ToString();
						}
					}
					catch (Exception)
					{
						sWebPage = "N";
					}
					
				}
				if (sPublic.Equals("Y"))
				{
					isPublic.Checked = true;
				}
				else
				{
					isPublic.Checked = false;
				}
				if (sMaster.Equals("Y"))
				{
					isMaster.Checked = true;
				}
				else
				{
					isMaster.Checked = false;
				}
				if (sWebPage.Equals("Y"))
				{
					isWebPage.Checked = true;
				}
				else
				{
					isWebPage.Checked = false;
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase:getSqlInstanceIdentifier Error 100: " + ex.Message));
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			GC.Collect();
			
		}
		public int getRetentionPeriod(string RetentionCode)
		{
			
			if (RetentionCode.Trim().Length == 0)
			{
				return 50;
			}
			
			//Dim SqlServerMachineName  = ""
			RetentionCode = UTIL.RemoveSingleQuotes(RetentionCode);
			string S = "Select RetentionUnits from Retention where RetentionCode = \'" + RetentionCode + "\'";
			SqlDataReader rsData = null;
			int rPeriod = 10;
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					rsData.Read();
					rPeriod = rsData.GetInt32(0);
				}
			}
			catch (Exception ex)
			{
				rPeriod = 10;
				LOG.WriteToArchiveLog((string) ("clsDatabase:getSqlInstanceIdentifier Error 100: " + ex.Message));
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			GC.Collect();
			return rPeriod;
		}
		
		public string getRetentionPeriodMax()
		{
			
			//Dim SqlServerMachineName  = ""
			string S = "";
			string MaxYears = getRetentionPeriodYearsMax();
			string MaxPeriod = "";
			
			S = (string) (" SELECT [RetentionCode] FROM [Retention] where RetentionUnits = " + MaxYears);
			
			SqlDataReader rsData = null;
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					rsData.Read();
					MaxPeriod = rsData.GetValue(0).ToString();
				}
			}
			catch (Exception ex)
			{
				MaxPeriod = "";
				LOG.WriteToArchiveLog((string) ("clsDatabase:getRetentionPeriodMax Error 100: " + ex.Message));
			}
			if (rsData != null)
			{
				if (! rsData.IsClosed)
				{
					rsData.Close();
				}
				rsData = null;
			}
			
			GC.Collect();
			return MaxPeriod;
			
		}
		public string getRetentionPeriodYearsMax()
		{
			
			//Dim SqlServerMachineName  = ""
			string S = "";
			S = " select MAX(RetentionUnits) FROM [Retention]";
			
			SqlDataReader rsData = null;
			string rPeriod = "100";
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					rsData.Read();
					rPeriod = rsData.GetValue(0).ToString();
				}
			}
			catch (Exception ex)
			{
				rPeriod = 10.ToString();
				LOG.WriteToArchiveLog((string) ("clsDatabase:getRetentionPeriodYearsMax Error 100: " + ex.Message));
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			GC.Collect();
			return rPeriod;
		}
		
		public void SetExchangeDefaultRetentionCode()
		{
			string S = "";
			S = S + " update ExchangeHostPop ";
			S = S + " set RetentionCode = (select top(1) RetentionCode from Retention)";
			S = S + " where RetentionCode Is null ";
			this.ExecuteSqlNewConn(S);
		}
		public string GetDirRetentionCode(string FQN, string UserID)
		{
			
			FQN = UTIL.RemoveSingleQuotes(FQN);
			
			string S = "";
			string rCode = "";
			try
			{
				
				S = S + " select RetentionCode from Directory";
				S = S + " where UserID = \'" + UserID + "\'";
				S = S + " and FQN = \'" + FQN + "\'";
				
				SqlDataReader rsData = null;
				int rPeriod = 10;
				try
				{
					
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					rsData = command.ExecuteReader();
					
					if (rsData.HasRows)
					{
						rsData.Read();
						rCode = rsData.GetValue(0).ToString();
					}
					
					if (! rsData.IsClosed)
					{
						rsData.Close();
					}
					rsData = null;
					command.Dispose();
					command = null;
					
					if (CONN.State == ConnectionState.Open)
					{
						CONN.Close();
					}
					CONN.Dispose();
					
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("clsDatabase:GetDirRetentionCode Error 100: " + ex.Message));
				}
				
				//If Not rsData.IsClosed Then
				//    rsData.Close()
				//End If
				//rsData = Nothing
				GC.Collect();
				return rCode;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("Error 2323.45 GetDirRetentionCode: " + ex.Message + "\r\n" + S));
				return "Retain 20";
			}
			
			return "";
			
		}
		public string GetRetentionMgr(string RetentionCode)
		{
			string S = "";
			S = S + " select ManagerName from Retention   ";
			S = S + " where RetentionCode = \'" + RetentionCode + "\'";
			
			string rCode = "";
			
			SqlDataReader rsData = null;
			int rPeriod = 10;
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					rsData.Read();
					rCode = rsData.GetValue(0).ToString();
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase:GetRetentionMgr Error 100: " + ex.Message));
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			GC.Collect();
			return rCode;
			
		}
		public void setRetentionDate(string SourceGuid, string RetentionCode, string FileExtention)
		{
			
			int RetentionUnits = getRetentionPeriod(RetentionCode);
			DateTime rightNow = DateTime.Now;
			rightNow = rightNow.AddYears(RetentionUnits);
			string RetentionExpirationDate = rightNow.ToString();
			string S = "";
			
			if (FileExtention.ToUpper().Equals(".MSG") || FileExtention.ToUpper().Equals(".EML"))
			{
				S = "Update email set RetentionExpirationDate = \'" + RetentionExpirationDate + "\' where EmailGuid = \'" + SourceGuid + "\' ";
			}
			else
			{
				S = "Update DataSource set RetentionExpirationDate = \'" + RetentionExpirationDate + "\' where SourceGuid = \'" + SourceGuid + "\' ";
			}
			
			bool B = this.ExecuteSqlNewConn(S, false);
			
			if (FileExtention.ToUpper().Equals(".MSG") || FileExtention.ToUpper().Equals(".EML"))
			{
				S = "Update email set RetentionCode = \'" + RetentionCode + "\' where EmailGuid = \'" + SourceGuid + "\' ";
			}
			else
			{
				S = "Update DataSource set RetentionCode = \'" + RetentionCode + "\' where SourceGuid = \'" + SourceGuid + "\' ";
			}
			
			B = this.ExecuteSqlNewConn(S, false);
		}
		
		public bool cntMachine(string MachineName, string FQN, string SourceGuid)
		{
			
			FQN = UTIL.RemoveSingleQuotes(FQN);
			
			string S = "";
			bool B = false;
			int cnt = -1;
			
			SqlDataReader RSData = null;
			S = " SELECT COUNT(*) FROM [Machine] where MachineName = \'" + MachineName + "\' and FQN = \'" + FQN + "\' and SourceGuid = \'" + SourceGuid + "\' ";
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			
			try
			{
				using (CONN)
				{
					
					
					
					RSData.Read();
					cnt = int.Parse(RSData.GetValue(0).ToString());
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				
				
				if (cnt > 0)
				{
					B = true;
				}
				else
				{
					B = false;
				}
				
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				
				CONN = null;
				
			}
			catch (Exception)
			{
				LOG.WriteToArchiveLog((string) ("Error - 1432.654.a - Failed to add machine for " + FQN));
				B = false;
			}
			
			return B;
			
		}
		public bool AddMachineSourceXX(string FQN, string SourceGuid)
		{
			
			bool B = false;
			string MachineName = Environment.MachineName.ToString();
			B = cntMachine(MachineName, FQN, SourceGuid);
			if (! B)
			{
				string S = "INSERT INTO [Machine]";
				S = S + " ([MachineName]";
				S = S + " ,[FQN]";
				S = S + " ,[ContentType]";
				S = S + " ,[CreateDate]";
				S = S + " ,[LastUpdate]";
				S = S + " ,[SourceGuid]";
				S = S + " ,[UserID])";
				S = S + " VALUES ";
				S = S + " (\'" + MachineName + "\'";
				S = S + " ,\'" + FQN + "\'";
				S = S + " ,\'Source\'";
				S = S + " ,GETDATE()";
				S = S + " ,GETDATE()";
				S = S + " ,\'" + SourceGuid + "\'";
				S = S + " ,\'" + modGlobals.gCurrUserGuidID + "\'";
				S = S + " )";
				
				B = this.ExecuteSqlNewConn(S, false);
				
			}
			return B;
		}
		public bool isLibOwner(string LibName)
		{
			string S = "";
			bool B = false;
			int cnt = -1;
			
			S = " SELECT count(*) FROM [Library] where LibraryName = \'" + LibName + "\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
			
			SqlDataReader RSData = null;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			
			try
			{
				using (CONN)
				{
					RSData.Read();
					cnt = RSData.GetInt32(0);
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				
				
				if (cnt > 0)
				{
					B = true;
				}
				else
				{
					B = false;
				}
				
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				
				CONN = null;
				
			}
			catch (Exception)
			{
				LOG.WriteToArchiveLog("Error - 2133.654.x - Failed to validate lib owner.");
				B = false;
			}
			
			return B;
		}
		
		public bool isLibItemOwner(string LibraryItemGuid)
		{
			string S = "";
			bool B = false;
			int cnt = -1;
			
			S = " SELECT count(*) FROM [LibraryItems] where LibraryItemGuid = \'" + LibraryItemGuid + "\' and LibraryOwnerUserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
			
			
			SqlDataReader RSData = null;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			
			try
			{
				using (CONN)
				{
					RSData.Read();
					cnt = RSData.GetInt32(0);
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				
				
				if (cnt > 0)
				{
					B = true;
				}
				else
				{
					B = false;
				}
				
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				
				CONN = null;
				
			}
			catch (Exception)
			{
				LOG.WriteToArchiveLog("Error - 2133.696.y - Failed to validate lib item owner.");
				B = false;
			}
			
			return B;
		}
		public void getWebMetadata(string SourceGuid, SortedList<string, string> WebParms)
		{
			
			WebParms.Clear();
			
			string S = "Select ";
			S = S + " [SourceName]";
			S = S + " ,[SourceTypeCode]";
			S = S + " ,[FQN]";
			S = S + " ,[FileLength]";
			S = S + " ,[FileDirectory]";
			S = S + " ,[OriginalFileType]";
			S = S + " ,[Description]";
			S = S + " ,[isGraphic]";
			S = S + " ,[isWebPage]";
			S = S + " FROM DataSource";
			S = S + " where SourceGuid  = \'" + SourceGuid + "\'";
			
			string SourceName = "";
			string SourceTypeCode = "";
			string FQN = "";
			string FileLength = "";
			string FileDirectory = "";
			string OriginalFileType = "";
			string Description = "";
			string isGraphic = "";
			string isWebPage = "";
			
			
			SqlDataReader RSData = null;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			
			try
			{
				using (CONN)
				{
					if (RSData.HasRows)
					{
						RSData.Read();
						SourceName = RSData.GetValue(0).ToString();
						WebParms.Add("SourceName", SourceName);
						
						SourceTypeCode = RSData.GetValue(1).ToString();
						WebParms.Add("SourceTypeCode", SourceTypeCode);
						
						FQN = RSData.GetValue(2).ToString();
						WebParms.Add("FQN", FQN);
						
						FileLength = RSData.GetValue(3).ToString();
						WebParms.Add("FileLength", FileLength);
						
						FileDirectory = RSData.GetValue(4).ToString();
						WebParms.Add("FileDirectory", FileDirectory);
						
						OriginalFileType = RSData.GetValue(5).ToString();
						WebParms.Add("OriginalFileType", OriginalFileType);
						
						Description = RSData.GetValue(6).ToString();
						WebParms.Add("Description", Description);
						
						isGraphic = RSData.GetValue(7).ToString();
						WebParms.Add("isGraphic", isGraphic);
						
						isWebPage = RSData.GetValue(8).ToString();
						WebParms.Add("isWebPage", isWebPage);
						
					}
					
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
					
				}
				
				
				
				CONN.Close();
				CONN = null;
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("Error getWebMetadata - 2133.696.y - Failed to acquire web metadata: " + ex.Message));
			}
		}
		public void PopulateLibCombo(ref ComboBox CB)
		{
			
			try
			{
				CB.Items.Clear();
			}
			catch (Exception ex)
			{
				Debug.Print(ex.Message);
			}
			string S = "";
			bool isAdmin = this.isAdmin(modGlobals.gCurrUserGuidID);
			if (isAdmin)
			{
				S = "Select LibraryName FROM Library order by LibraryName ";
			}
			else
			{
				S = "Select distinct [LibraryName]";
				S = S + " FROM [LibraryUsers]";
				S = S + " where UserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
				S = S + " group by LibraryName";
			}
			
			this.PopulateComboBox(CB, "LibraryName", S);
			
		}
		
		public int getCntSource(string SourceName, string CRC)
		{
			
			SourceName = UTIL.RemoveSingleQuotes(SourceName);
			
			string S = "";
			S = S + " SELECT count(*) ";
			S = S + " FROM DataSource";
			S = S + " where SourceName = ";
			S = S + "\'" + SourceName + "\'";
			S = S + " and CRC = \'" + CRC + "\'";
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				//Dim CS  = getGateWayConnStr(gGateWayID) : Dim CONN As New SqlConnection(CS) : CONN.Open() : Dim command As New SqlCommand(S, CONN) : rsdata= command.ExecuteReader()
				
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				
				RSData.Read();
				cnt = RSData.GetInt32(0);
				RSData.Close();
				RSData = null;
				cmd.Connection.Close();
				cmd = null;
				command.Dispose();
				command = null;
				
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
				
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			return cnt;
		}
		//select datalength(SourceImage)  from DataSource where SourceGuid = '15bd8f45-5795-4526-adee-b0ddde66490b'
		public int GetImageSize(string SourceGuid)
		{
			string S = "";
			S = "Select datalength(SourceImage)  from DataSource where SourceGuid = \'" + SourceGuid + "\'";
			CloseConn();
			CkConn();
			
			int cnt = -1;
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = RSData.GetInt32(0);
				RSData.Close();
				RSData = null;
				cmd.Connection.Close();
				cmd = null;
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			return cnt;
		}
		public int GetMaxVersionNbr(string SourceName, string CRC)
		{
			int cnt = -1;
			string S = "";
			
			int iCnt = getCntSource(SourceName, CRC);
			
			if (iCnt == 0)
			{
				return -1;
			}
			
			SourceName = UTIL.RemoveSingleQuotes(SourceName);
			S = S + " SELECT MAX(VersionNbr) FROM DataSource where SourceName = \'" + SourceName + "\' ";
			
			try
			{
				CloseConn();
				CkConn();
				
				//Dim cmd As New SqlCommand(S, gConn)
				SqlDataReader RSData = null;
				
				using (gConn)
				{
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					RSData = command.ExecuteReader();
					if (RSData.HasRows)
					{
						RSData.Read();
						cnt = RSData.GetInt32(0);
						RSData.Close();
						RSData = null;
					}
					else
					{
						cnt = 0;
					}
					//cmd.Connection.Close()
					//cmd = Nothing
				}
				
				if (RSData != null)
				{
					RSData = null;
				}
				//If Not cmd Is Nothing Then
				//    cmd = Nothing
				//End If
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: clsDatabase : GetMaxVersionNbr 100 - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("ERROR: clsDatabase : GetMaxVersionNbr 100 - SQL: " + "\r\n" + S));
			}
			
			return cnt;
		}
		
		public void ckFilesNeedUpdate(ref List<string> ListOfFiles, bool CheckArchiveBit)
		{
			
			clsDbLocal DBLocal = new clsDbLocal();
			string HexCrc = "";
			
			try
			{
				string[] A = new string[1];
				string ArchFlag = "";
				for (int i = 0; i <= ListOfFiles.Count - 1; i++)
				{
					System.Windows.Forms.Application.DoEvents();
					if (i % 1 == 0)
					{
						frmNotify.Default.lblFileSpec.Text = (string) ("Check Update Needed: " + i.ToString() + " of " + ListOfFiles.Count.ToString());
						frmNotify.Default.Refresh();
					}
					System.Windows.Forms.Application.DoEvents();
					string S = ListOfFiles(i);
					
					if (CheckArchiveBit)
					{
						ArchFlag = S.Substring(0, S.IndexOf("|") + 0);
						ArchFlag = ArchFlag.ToUpper();
						if (ArchFlag.Equals("FALSE"))
						{
							ListOfFiles(i) = "";
							goto NxtRec;
						}
					}
					
					//False| xx.png|.png|C:\Temp\Tiff_Files|17630|22-Dec-10 8:00:57 PM|22-Dec-10 8:04:55 PM|22-Dec-10 8:01:02 PM
					if (S == null)
					{
						goto NxtRec;
					}
					if (S.IndexOf("|") + 1 == 0)
					{
						goto NxtRec;
					}
					A = S.Split('|'.ToString().ToCharArray());
					
					string Indicator = A[0];
					var fiName = A[1].ToString();
					var fiExtension = A[2].ToString();
					var fiFullName = A[3].ToString() + "\\" + A[1];
					var Filength = A[4].ToString();
					
					var fiCreationTime = A[5].ToString();
					var fiLastAccessTime = A[6].ToString();
					var fiLastWriteTime = A[7].ToString();
					
					double FileLength = int.Parse(Filength);
					DateTime LastAccessDate = null;
					try
					{
						LastAccessDate = DateTime.Parse(fiLastAccessTime);
					}
					catch (Exception)
					{
						LastAccessDate = DateTime.Now;
					}
					
					DateTime LastWriteTime = null;
					try
					{
						LastWriteTime = DateTime.Parse(fiLastWriteTime);
					}
					catch (Exception)
					{
						LastWriteTime = DateTime.Now;
					}
					DateTime CreateDate = null;
					try
					{
						CreateDate = DateTime.Parse(fiCreationTime);
					}
					catch (Exception)
					{
						CreateDate = LastWriteTime;
					}
					
					bool BB = false;
					if (Indicator.ToUpper().Equals("FALSE"))
					{
						BB = false;
					}
					else
					{
						BB = true;
					}
					
					BB = DBLocal.ckNeedsArchive(fiFullName, BB, ref HexCrc);
					
					if (! BB)
					{
						ListOfFiles(i) = "";
						goto NxtRec;
					}
					
					bool b = false;
					
					int VersionNbr = GetMaxVersionNbr(fiName, HexCrc);
					
					if (VersionNbr < 0)
					{
						//** The file does not exist in the repository, add it.
						b = true;
					}
					else
					{
						
						
						b = ckSourceNeedsUpdate(fiName, HexCrc);
						
						if (b)
						{
							if (! ListOfFiles.Contains(S))
							{
								ListOfFiles.Add(S);
							}
						}
						else
						{
							ListOfFiles(i) = "";
						}
					}
NxtRec:
					1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR 100 clsDatabase:ckFilesNeedUpdate - " + ex.Message));
			}
			finally
			{
				DBLocal = null;
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			
			frmNotify.Default.lblFileSpec.Text = (string) ("Check Completed: " + ListOfFiles.Count.ToString());
			frmNotify.Default.Refresh();
			
		}
		
		public bool ckSourceNeedsUpdate(string SourceName, string CRC)
		{
			
			bool bNeedsUpdating = true;
			
			SourceName = UTIL.RemoveSingleQuotes(SourceName);
			
			try
			{
				string S = "";
				S = S + " select count(*) from datasource  where SourceName = \'" + SourceName + "\' and crc = \'" + CRC + "\' ";
				
				int iCnt = iCount(S);
				if (iCnt > 0)
				{
					bNeedsUpdating = false;
				}
				else
				{
					bNeedsUpdating = true;
				}
				
			}
			catch (Exception ex)
			{
				bNeedsUpdating = true;
				LOG.WriteToArchiveLog((string) ("ERROR 001 clsDatabase:ckSourceNeedsUpdate - " + ex.Message));
			}
			
			return bNeedsUpdating;
			
		}
		public void AddArchiveDir(string DirFQN)
		{
			DirFQN = UTIL.RemoveSingleQuotes(DirFQN);
			
			int iCnt = ArchiveDirExists(DirFQN, modGlobals.gMachineID);
			
			if (iCnt == 0)
			{
				string S = "";
				bool B = false;
				
				S = "INSERT INTO [DirectoryTemp]";
				S = S + " ([DirFQN]";
				S = S + " ,[CurrUserGuidID]";
				S = S + " ,[MachineID])";
				S = S + " VALUES ";
				S = S + " (\'" + DirFQN + "\'";
				S = S + " ,\'" + modGlobals.gCurrUserGuidID + "\'";
				S = S + " ,\'" + modGlobals.gMachineID + "\'";
				
			}
			
		}
		public int ArchiveDirExists(string DirFqn, string MachineID)
		{
			string S = "";
			
			DirFqn = UTIL.RemoveSingleQuotes(DirFqn);
			
			S = S + " SELECT COUNT(*) FROM [DirectoryTemp] where [DirFQN] = \'" + DirFqn + "\' and [CurrUserGuidID] = \'" + modGlobals.gCurrUserGuidID + "\' and [MachineID] = \'" + MachineID + "\'";
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					cnt = RSData.GetInt32(0);
					RSData.Close();
					RSData = null;
				}
				
				cmd.Connection.Close();
				cmd = null;
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			return cnt;
		}
		public void getDbInfo(ref string ProductVersion, ref string ProductLevel, ref string Edition, ref string VersionDesc)
		{
			string S = "";
			S = S + " SELECT SERVERPROPERTY(\'productversion\') as ProductVersion, ";
			S = S + " SERVERPROPERTY (\'productlevel\') as ProductLevel, ";
			S = S + " SERVERPROPERTY (\'edition\') as Edition, ";
			S = S + " @@VERSION as VersionDesc";
			
			CloseConn();
			CkConn();
			
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				ProductVersion = RSData.GetValue(0).ToString();
				ProductLevel = RSData.GetValue(1).ToString();
				Edition = RSData.GetValue(2).ToString();
				VersionDesc = RSData.GetValue(3).ToString();
				RSData.Close();
				RSData = null;
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			GC.Collect();
			GC.WaitForFullGCComplete();
		}
		public void PopulateAllUserLibCombo(ComboBox cb)
		{
			string S = "";
			try
			{
				cb.Items.Clear();
				
				S = "";
				S = S + "Select LibraryName from Library order by LibraryName ";
				
				SqlDataReader RSData = null;
				//RSData = SqlQryNo'Session(S)
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						string LibraryName = RSData.GetValue(0).ToString();
						if (cb.Items.Contains(LibraryName))
						{
						}
						else
						{
							cb.Items.Add(LibraryName);
						}
					}
				}
				RSData.Close();
				RSData = null;
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR 33.44.1 - " + ex.Message + "\r\n" + S));
			}
			
		}
		public void PopulateGroupUserLibCombo(ComboBox cb)
		{
			string S = "";
			bool bIsAdmin = isAdmin(modGlobals.gCurrUserGuidID);
			try
			{
				cb.Items.Clear();
				if (bIsAdmin == true)
				{
					S = "";
					S = S + "Select [LibraryName] FROM [Library] order by [LibraryName]";
				}
				else
				{
					S = "";
					S = S + "Select distinct LibraryName from GroupLibraryAccess " + "\r\n";
					S = S + " where GroupName in " + "\r\n";
					S = S + " (select distinct GroupName from GroupUsers where UserID = \'" + modGlobals.gCurrUserGuidID + "\')" + "\r\n";
					S = S + "             union " + "\r\n";
					S = S + " select distinct LibraryName from LibraryUsers where UserID = \'" + modGlobals.gCurrUserGuidID + "\'" + "\r\n";
					S = S + " and LibraryName in (select LibraryName from Library)" + "\r\n";
					S = S + "             union " + "\r\n";
					S = S + " select LibraryName from Library where UserID = \'" + modGlobals.gCurrUserGuidID + "\'" + "\r\n";
				}
				
				SqlDataReader RSData = null;
				//RSData = SqlQryNo'Session(S)
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						string LibraryName = RSData.GetValue(0).ToString();
						if (cb.Items.Contains(LibraryName))
						{
						}
						else
						{
							cb.Items.Add(LibraryName);
						}
					}
				}
				RSData.Close();
				RSData = null;
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR 33.44.1 - " + ex.Message + "\r\n" + S));
			}
			
		}
		
		public ArrayList GetUserGroupMembership()
		{
			ArrayList A = new ArrayList();
			string S = "Select distinct GroupName from GroupUsers where UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
			try
			{
				SqlDataReader RSData = null;
				//RSData = SqlQryNo'Session(S)
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						string GroupyName = RSData.GetValue(0).ToString();
						A.Add(GroupyName);
					}
				}
				RSData.Close();
				RSData = null;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR GetUserGroupMembership 33.44.2 - " + ex.Message + "\r\n" + S));
			}
			return A;
		}
		public int ckWorkingDirExists(string TypeDir)
		{
			TypeDir = TypeDir.ToUpper;
			
			string S = "";
			if (TypeDir.Equals("CONTENT"))
			{
				S = S + " select COUNT(*) from SavedItems where ValName = \'CONTENT WORKING DIRECTORY\' and Userid = \'" + modGlobals.gCurrUserGuidID + "\'";
			}
			if (TypeDir.Equals("EMAIL"))
			{
				S = S + " select COUNT(*) from SavedItems where ValName = \'EMAIL WORKING DIRECTORY\' and Userid = \'" + modGlobals.gCurrUserGuidID + "\'";
			}
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = RSData.GetInt32(0);
				RSData.Close();
				RSData = null;
				cmd.Connection.Close();
				cmd = null;
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			return cnt;
		}
		public bool CreateNewWorkingDir(string TypeDir, string DirName)
		{
			string S = "";
			
			bool B = false;
			
			DirName = UTIL.RemoveSingleQuotes(DirName);
			int iCnt = 0;
			
			if (TypeDir.Equals("EMAIL"))
			{
				
				iCnt = ckWorkingDirExists(TypeDir);
				if (iCnt == 0)
				{
					S = S + " INSERT INTO [SavedItems]";
					S = S + " ([Userid]";
					S = S + " ,[SaveName]";
					S = S + " ,[SaveTypeCode]";
					S = S + " ,[ValName]";
					S = S + " ,[ValValue])";
					S = S + " VALUES ";
					S = S + " (\'" + modGlobals.gCurrUserGuidID + "\'";
					S = S + " ,\'UserStartUpParameters\'";
					S = S + " ,\'StartUpParm\'";
					S = S + " ,\'EMAIL WORKING DIRECTORY\'";
					S = S + " ,\'" + DirName + "\')";
				}
				else
				{
					S = S + " update SavedItems ";
					S = S + " set ValValue = \'" + DirName + "\'";
					S = S + " where ValName = \'EMAIL WORKING DIRECTORY\'";
					S = S + " and Userid = \'" + modGlobals.gCurrUserGuidID + "\'";
				}
				
				B = ExecuteSqlNewConn(S);
				if (B)
				{
					LOG.WriteToArchiveLog((string) ("The new EMAIL working directory has been set to : " + DirName + " for User " + modGlobals.gCurrUserGuidID));
				}
				else
				{
					LOG.WriteToArchiveLog((string) ("Failed to set new EMAIL working directory to : " + DirName + " for User " + modGlobals.gCurrUserGuidID));
				}
				
			}
			else if (TypeDir.Equals("CONTENT"))
			{
				iCnt = ckWorkingDirExists(TypeDir);
				if (iCnt == 0)
				{
					S = S + " INSERT INTO [SavedItems]";
					S = S + " ([Userid]";
					S = S + " ,[SaveName]";
					S = S + " ,[SaveTypeCode]";
					S = S + " ,[ValName]";
					S = S + " ,[ValValue])";
					S = S + " VALUES ";
					S = S + " (\'" + modGlobals.gCurrUserGuidID + "\'";
					S = S + " ,\'UserStartUpParameters\'";
					S = S + " ,\'StartUpParm\'";
					S = S + " ,\'CONTENT WORKING DIRECTORY\'";
					S = S + " ,\'" + DirName + "\')";
				}
				else
				{
					S = S + " update SavedItems ";
					S = S + " set ValValue = \'" + DirName + "\'";
					S = S + " where ValName = \'CONTENT WORKING DIRECTORY\'";
					S = S + " and Userid = \'" + modGlobals.gCurrUserGuidID + "\'";
				}
				
				B = ExecuteSqlNewConn(S);
				if (B)
				{
					LOG.WriteToArchiveLog((string) ("The new CONTENT working directory has been set to : " + DirName + " for User " + modGlobals.gCurrUserGuidID));
				}
				else
				{
					LOG.WriteToArchiveLog((string) ("Failed to set new CONTENT working directory to : " + DirName + " for User " + modGlobals.gCurrUserGuidID));
				}
				
			}
			
			return B;
		}
		
		public void ckMissingWorkingDirs()
		{
			int iCnt = 0;
			string TempDirName = DMA.getEnvVarTempDir();
			iCnt = ckWorkingDirExists("EMAIL");
			if (iCnt == 0)
			{
				CreateNewWorkingDir("EMAIL", TempDirName);
			}
			iCnt = ckWorkingDirExists("CONTENT");
			if (iCnt == 0)
			{
				CreateNewWorkingDir("CONTENT", TempDirName);
			}
		}
		
		public bool ExchangeEmailExists(string EmailIdentifier)
		{
			
			EmailIdentifier = UTIL.RemoveSingleQuotes(EmailIdentifier);
			
			//Dim SS As String = "select COUNT(*) from Email where EmailIdentifier = '" + EmailIdentifier + "' and RecHash = '" + RecHash + "'"
			string SS = "select COUNT(*) from Email where EmailIdentifier = \'" + EmailIdentifier + "\' ";
			int iCnt = iCount(SS);
			
			if (iCnt == 0)
			{
				return false;
			}
			else
			{
				return true;
			}
			
			
		}
		public bool ExchangeEmailExistsV2(string EmailIdentifier, string RecHash)
		{
			
			EmailIdentifier = UTIL.RemoveSingleQuotes(EmailIdentifier);
			
			//Dim SS As String = "select COUNT(*) from Email where EmailIdentifier = '" + EmailIdentifier + "' and RecHash = '" + RecHash + "'"
			string SS = "select COUNT(*) from Email where EmailIdentifier = \'" + EmailIdentifier + "\' ";
			int iCnt = iCount(SS);
			
			if (iCnt == 0)
			{
				return false;
			}
			else
			{
				return true;
			}
			
			
		}
		
		public bool isArchiveDisabled(string ArchiveTypeCode)
		{
			
			string S = "";
			bool b = false;
			
			try
			{
				if (ArchiveTypeCode.Equals("EXCHANGE"))
				{
					S = "Select ParmValue from RunParms where Parm = \'ExchangeDisabled\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
				}
				else if (ArchiveTypeCode.Equals("CONTENT"))
				{
					S = "Select ParmValue from RunParms where Parm = \'ContentDisabled\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
				}
				else if (ArchiveTypeCode.Equals("EMAIL"))
				{
					S = "Select ParmValue from RunParms where Parm = \'OutlookDisabled\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
				}
				else if (ArchiveTypeCode.Equals("ALL"))
				{
					S = "Select ParmValue from RunParms where Parm = \'ckDisable\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
				}
				else
				{
					return false;
				}
				
				
				string ParmVal = "";
				
				SqlDataReader RSData = null;
				//RSData = SqlQryNo'Session(S)
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					ParmVal = RSData.GetValue(0).ToString();
					if (ParmVal.ToUpper().Equals("TRUE"))
					{
						b = true;
					}
					else
					{
						b = false;
					}
				}
				else
				{
					b = false;
				}
				RSData.Close();
				RSData = null;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR - isArchiveDisabled : " + ex.Message));
				b = false;
			}
			
			
			GC.Collect();
			GC.WaitForFullGCComplete();
			
			return b;
			
		}
		
		public void WriteXMLData(string TblName, string FQN)
		{
			getGateWayConnStr(modGlobals.gGateWayID);
			
			string S = (string) ("Select * from " + TblName);
			
			DataSet dsXmlData = new DataSet();
			
			SqlConnection cn = new SqlConnection(gConnStr);
			SqlDataAdapter daTempData = new SqlDataAdapter(S, cn);
			
			// Load data from database
			daTempData.Fill(dsXmlData, TblName);
			
			// Write XML to file
			dsXmlData.WriteXml(FQN);
			
		}
		public void LoadRsFromXML(string TblName, string FQN)
		{
			
			getGateWayConnStr(modGlobals.gGateWayID);
			string S = (string) ("Select * from " + TblName);
			SqlDataAdapter daSvr = new SqlDataAdapter(S, gConn);
			
			DataSet DsSvr = new DataSet();
			daSvr.Fill(DsSvr, TblName);
			
			DataSet dsXml = new DataSet();
			// Read in XML from file
			dsXml.ReadXml(FQN);
			int iCols = DsSvr.Tables[0].Columns.Count;
			
			DataTable DT;
			DT = DsSvr.Tables[0];
			
			SqlCommandBuilder myBuilder = new SqlCommandBuilder(daSvr);
			myBuilder.GetUpdateCommand();
			daSvr.UpdateCommand = myBuilder.GetUpdateCommand();
			daSvr.InsertCommand = myBuilder.GetInsertCommand();
			if (modGlobals.gClipBoardActive == true)
			{
				Console.WriteLine(myBuilder.GetUpdateCommand());
			}
			if (modGlobals.gClipBoardActive == true)
			{
				Console.WriteLine(daSvr.UpdateCommand.ToString());
			}
			
			for (int I = 0; I <= dsXml.Tables[0].Rows.Count - 1; I++)
			{
				DataRow DR = null;
				DR = DT.NewRow();
				for (int II = 0; II <= iCols - 1; II++)
				{
					DR[II] = dsXml.Tables[0].Rows[I][II];
				}
				DT.Rows.Add(DR);
				try
				{
					daSvr.Update(DsSvr, TblName);
				}
				catch (Exception ex)
				{
					if (ex.Message.ToString().IndexOf("duplicate key") + 1 > 0)
					{
						Console.WriteLine("ERROR clsDatabase:LoadRsFromXML - " + ex.Message);
					}
					else
					{
						LOG.WriteToArchiveLog((string) ("ERROR clsDatabase:LoadRsFromXML - " + ex.Message));
					}
					
				}
				DR = null;
			}
			daSvr.Update(DsSvr, TblName);
			daSvr.Dispose();
			daSvr = null;
		}
		public bool FixIdExists(int ID)
		{
			string S = "";
			bool B = false;
			
			S = S + " select count(*) from [DB_Updates] where FixID = " + ID.ToString();
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				RSData.Read();
				cnt = RSData.GetInt32(0);
				RSData.Close();
				RSData = null;
				cmd.Connection.Close();
				cmd = null;
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			
			if (cnt > 0)
			{
				B = true;
			}
			else
			{
				B = false;
			}
			
			return B;
		}
		public void InitializeServiceParameters()
		{
			
			string S = "";
			bool B = false;
			
			B = SysParmExists("srv_LogDirectory");
			if (B == false)
			{
				S = "insert into SystemParms (SysParm,SysParmDesc,SysParmVal,flgActive)";
				S = S + " values (\'srv_LogDirectory\',\'Set to blank for default. Change where the service logs are written. This directory is relative to the SERVICE machine.\',\'\',\'Y\')";
				B = ExecuteSqlNewConn(S);
			}
			
			B = SysParmExists("srv_DetailedLogging");
			if (B == false)
			{
				S = "insert into SystemParms (SysParm,SysParmDesc,SysParmVal,flgActive)";
				S = S + " values (\'srv_DetailedLogging\',\'When set to 0 no logging will be limited, when 1, full execution details will be logged.\',\'0\',\'Y\')";
				B = ExecuteSqlNewConn(S);
			}
			
			B = SysParmExists("srv_MaxFileSize");
			if (B == false)
			{
				S = "insert into SystemParms (SysParm,SysParmDesc,SysParmVal,flgActive)";
				S = S + " values (\'srv_MaxFileSize\',\'When set to 0 no limit on upload file size, any other value set the max limit.\',\'0\',\'Y\')";
				B = ExecuteSqlNewConn(S);
			}
			
			B = SysParmExists("srv_disable");
			if (B == false)
			{
				S = "insert into SystemParms (SysParm,SysParmDesc,SysParmVal,flgActive)";
				S = S + " values (\'srv_disable\',\'When set to anything other than 0 the ECM Service will continue to run but will NOT archive.\',\'0\',\'Y\')";
				B = ExecuteSqlNewConn(S);
			}
			
			B = SysParmExists("srv_shutdown");
			if (B == false)
			{
				S = "insert into SystemParms (SysParm,SysParmDesc,SysParmVal,flgActive)";
				S = S + " values (\'srv_shutdown\',\'When set to 1, the service (next poll) will stop running.\',\'0\',\'Y\')";
				B = ExecuteSqlNewConn(S);
			}
			
			B = SysParmExists("srv_PollingInterval");
			if (B == false)
			{
				S = "insert into SystemParms (SysParm,SysParmDesc,SysParmVal,flgActive)";
				S = S + " values (\'srv_PollingInterval\',\'This is the number of MINUTES between executing an archive.\',\'60\',\'Y\')";
				B = ExecuteSqlNewConn(S);
			}
			
			B = SysParmExists("srv_ArchiveNow");
			if (B == false)
			{
				S = "insert into SystemParms (SysParm,SysParmDesc,SysParmVal,flgActive)";
				S = S + " values (\'srv_ArchiveNow\',\'Set this value to a 1 to set the archive state to immediate."; //,'0','Y')"
				B = ExecuteSqlNewConn(S);
			}
			
			B = SysParmExists("srv_LastArchive");
			if (B == false)
			{
				S = "insert into SystemParms (SysParm,SysParmDesc,SysParmVal,flgActive)";
				S = S + " values (\'srv_LastArchive\',\'This is the datetime of the last completed archive.\',\'" + DateTime.Now.ToString() + "\',\'Y\')";
				B = ExecuteSqlNewConn(S);
			}
			
		}
		public bool SysParmExists(string ParmName)
		{
			bool B = false;
			int I = 0;
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			
			try
			{
				
				
				string S = "Select count(*) FROM [SystemParms] where [SysParm] = \'" + ParmName + "\'";
				SqlDataReader dsSharePoint = SqlQryNewConn(S, ConnStr);
				
				if (dsSharePoint.HasRows)
				{
					dsSharePoint.Read();
					I = dsSharePoint.GetInt32(0);
					if (I > 0)
					{
						B = true;
					}
					else
					{
						B = false;
					}
				}
				else
				{
					B = false;
				}
				
				dsSharePoint.Close();
				dsSharePoint = null;
				
			}
			catch (Exception ex)
			{
				B = false;
				LOG.WriteToArchiveLog("SysParmExists: 100 - " + ex.Message + "\r\n" + ConnStr + "\r\n");
			}
			
			return B;
			
		}
		public void AddDefaultRetentionCode()
		{
			
			string UID = getUserGuidID("admin");
			string S = "INSERT INTO [Retention]";
			S = S + " ([RetentionCode]";
			S = S + " ,[RetentionDesc]";
			S = S + " ,[RetentionUnits]";
			S = S + " ,[RetentionAction]";
			S = S + " ,[ManagerID]";
			S = S + " ,[ManagerName])";
			S = S + " VALUES ";
			S = S + " (\'R-10\'";
			S = S + " ,\'Retain for 10 years.\'";
			S = S + " ,10";
			S = S + " ,\'Move\'";
			S = S + " ,\'admin\'";
			S = S + " ,\'admin\')";
			bool b = ExecuteSqlNewConn(S, false);
		}
		
		public void updateIp(string HostName, string IP, int checkCode)
		{
			// 0 = add if new
			// 1 = update access count
			// 2 = update search count
			// 2 = update access count and search count
			bool B = false;
			string S = "";
			if (checkCode == 0)
			{
				S = "Select count(*) from IP where HostName =\'" + HostName + "\' and AccessingIP = \'" + IP + "\'";
				string WC = "where  HostName =\'" + HostName + "\' and AccessingIP = \'" + IP + "\'";
				int iCnt = iGetRowCount("IP", WC);
				
				if (iCnt == 0)
				{
					S = "INSERT INTO [IP]";
					S = S + " (HostName, [AccessingIP]";
					S = S + " ,[AccessCnt]";
					S = S + " ,[BlockIP]";
					S = S + " ,[SearchCnt]";
					S = S + " ,[FirstAccessDate]";
					S = S + " ,[LastAccessDate])";
					S = S + " VALUES ";
					S = S + " (\'" + HostName + "\', \'" + IP + "\'";
					S = S + " ,1";
					S = S + " ,0";
					S = S + " ,0";
					S = S + " ,\'" + DateTime.Now.ToString() + "\'";
					S = S + " ,\'" + DateTime.Now.ToString() + "\')";
					B = ExecuteSqlNewConn(S);
					if (B == false)
					{
						this.xTrace(952, (string) ("updateIp: Failed to add IP - " + IP), "updateIp");
					}
				}
			}
			else if (checkCode == 1)
			{
				S = "update [IP] set LastAccessDate = \'" + DateTime.Now.ToString() + "\', AccessCnt = AccessCnt + 1 where HostName =\'" + HostName + "\' and AccessingIP = \'" + IP + "\' ";
				B = ExecuteSqlNewConn(S);
				if (B == false)
				{
					this.xTrace(953, (string) ("updateIp: Failed to update IP - " + IP), "updateIp");
				}
			}
			else if (checkCode == 2)
			{
				S = "update [IP] set LastAccessDate = \'" + DateTime.Now.ToString() + "\', SearchCnt = SearchCnt + 1 where HostName =\'" + HostName + "\' and AccessingIP = \'" + IP + "\' ";
				B = ExecuteSqlNewConn(S);
				if (B == false)
				{
					this.xTrace(954, (string) ("updateIp: Failed to add IP - " + IP), "updateIp");
				}
			}
			else if (checkCode == 3)
			{
				S = "update [IP] set LastAccessDate = \'" + DateTime.Now.ToString() + "\', SearchCnt = SearchCnt + 1, AccessCnt = AccessCnt + 1 where HostName =\'" + HostName + "\' and AccessingIP = \'" + IP + "\' ";
				B = ExecuteSqlNewConn(S);
				if (B == false)
				{
					this.xTrace(955, (string) ("updateIp: Failed to add IP - " + IP), "updateIp");
				}
			}
			
		}
		
		public bool UpdateDoNotChangeHelpText(string WhereClause, string ScreenName, string WidgetName, string WidgetText)
		{
			
			bool b = false;
			string s = "";
			
			if (WhereClause.Length == 0)
			{
				return false;
			}
			
			s = s + " update HelpText set ";
			s = s + "ScreenName = \'" + ScreenName + "\'" + ", ";
			s = s + "WidgetName = \'" + WidgetName + "\'" + ", ";
			s = s + "WidgetText = \'" + WidgetText + "\'";
			WhereClause = (string) (" " + WhereClause);
			s = s + WhereClause;
			b = ExecuteSqlNewConn(s, false);
			
			return b;
		}
		public bool isClientOnly(string UserID)
		{
			
			bool B = false;
			string S = "Select ClientOnly from Users where UserID = \'" + UserID + "\'";
			try
			{
				CloseConn();
				CkConn();
				
				SqlCommand cmd = new SqlCommand(S, gConn);
				SqlDataReader RSData = null;
				
				using (gConn)
				{
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					RSData = command.ExecuteReader();
					if (RSData.HasRows)
					{
						RSData.Read();
						try
						{
							B = RSData.GetBoolean(0);
						}
						catch (Exception)
						{
							B = false;
						}
						RSData.Close();
						RSData = null;
						cmd.Connection.Close();
						cmd = null;
					}
					else
					{
						B = false;
					}
					
				}
				
				if (RSData != null)
				{
					RSData = null;
				}
				if (cmd != null)
				{
					cmd = null;
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERR: isClientOnly - " + ex.Message));
				LOG.WriteToArchiveLog((string) ("ERR: isClientOnly - " + ex.StackTrace));
				B = false;
			}
			
			return B;
			
		}
		public bool isSingleInstance()
		{
			//select SysParmVal from SystemParms where SysParm = 'SYS_SingleInstance'
			string S = "";
			bool B = false;
			
			S = S + " select SysParmVal from SystemParms where SysParm = \'SYS_SingleInstance\' ";
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					string tVal = RSData.GetValue(0).ToString();
					RSData.Close();
					RSData = null;
					cmd.Connection.Close();
					cmd = null;
					B = false;
					if (tVal.Equals("Y") || tVal.Equals("y"))
					{
						B = true;
					}
					if (tVal.Equals("1"))
					{
						B = true;
					}
				}
				else
				{
					B = false;
				}
				
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			return B;
			
		}
		
		public bool isExtendedPdfProcessing()
		{
			//select SysParmVal from SystemParms where SysParm = 'SYS_SingleInstance'
			string S = "";
			bool B = true;
			
			S = S + " select SysParmVal from SystemParms where SysParm = \'SYS_EcmPDFX\' ";
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					string tVal = RSData.GetValue(0).ToString();
					RSData.Close();
					RSData = null;
					cmd.Connection.Close();
					cmd = null;
					B = false;
					if (tVal.Equals("Y") || tVal.Equals("y"))
					{
						B = true;
					}
					if (tVal.Equals("1"))
					{
						B = true;
					}
				}
				else
				{
					B = false;
				}
				
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			return B;
			
		}
		
		
		public string getPdfProcessingDir()
		{
			//select SysParmVal from SystemParms where SysParm = 'SYS_SingleInstance'
			string S = "";
			bool B = true;
			
			S = S + " select SysParmVal from SystemParms where SysParm = \'SYS_EcmPDFdir\' ";
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					S = RSData.GetValue(0).ToString();
					RSData.Close();
					RSData = null;
					cmd.Connection.Close();
					cmd = null;
				}
				else
				{
					B = false;
				}
				
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			
			if (S.Length == 0)
			{
				string InsertSql = "";
				InsertSql = "INSERT [dbo].[SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES (\'SYS_EcmPDFdir\', \'Set this as the temporary PDF/Graphics processing directory. NO SPACES ALLOWED IN NAME.\', \'C:\\TEMP\\PdfProcessing\\\', NULL, NULL, NULL, NULL)";
				ExecuteSqlNewConn(InsertSql);
				S = "C:\\TEMP\\PdfProcessing\\";
			}
			
			return S;
			
		}
		
		public bool isPublicAllowed()
		{
			
			string S = "";
			bool B = false;
			
			S = S + " select SysParmVal from SystemParms where SysParm = \'SYS_AllowPublic\' ";
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					string tVal = RSData.GetValue(0).ToString();
					RSData.Close();
					RSData = null;
					cmd.Connection.Close();
					cmd = null;
					B = false;
					if (tVal.Equals("Y") || tVal.Equals("y"))
					{
						B = true;
					}
					else if (tVal.Equals("1"))
					{
						B = true;
					}
					else
					{
						B = false;
					}
				}
				else
				{
					B = true;
				}
				
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			return B;
			
		}
		
		public void setMaxFileUploadSize()
		{
			
			string S = "";
			bool B = false;
			
			S = S + " select SysParmVal from SystemParms where SysParm = \'SYS_MaxFileSize\' ";
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			double MaxSize = 0;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					string tVal = RSData.GetValue(0).ToString();
					RSData.Close();
					RSData = null;
					cmd.Connection.Close();
					cmd = null;
					modGlobals.gMaxSize = int.Parse(tVal);
				}
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			CloseConn();
			
		}
		
		public bool ShowGraphicMetaDataScreen()
		{
			//select SysParmVal from SystemParms where SysParm = 'SYS_SingleInstance'
			string S = "";
			bool B = false;
			
			S = S + " select SysParmVal from SystemParms where SysParm = \'SYS_EmbededJPGMetadata\' ";
			
			CloseConn();
			CkConn();
			
			int cnt = -1;
			SqlCommand cmd = new SqlCommand(S, gConn);
			SqlDataReader RSData = null;
			
			using (gConn)
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					string tVal = RSData.GetValue(0).ToString();
					RSData.Close();
					RSData = null;
					cmd.Connection.Close();
					cmd = null;
					B = false;
					if (tVal.Equals("Y") || tVal.Equals("y"))
					{
						B = true;
					}
					if (tVal.Equals("1"))
					{
						B = true;
					}
				}
				else
				{
					B = false;
				}
				
			}
			
			if (RSData != null)
			{
				RSData = null;
			}
			if (cmd != null)
			{
				cmd = null;
			}
			return B;
			
		}
		
		//Sub LoadDefaultSystemParms()
		//    Dim S  = ""
		//    Dim I As Integer = 0
		
		//    S = "Select count(*) from SystemParms where SysParm = 'Default Thesaurus'"
		//    I = iCount(S)
		//    If I = 0 Then
		//        S = " INSERT into [SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('MaxUrlsToProcess', 'The number of levels to penetrate in a web site.', '2', NULL, NULL, NULL, NULL)"
		//        Me.ExecuteSqlNewConn(S)
		//    End If
		
		//    S = "Select count(*) from SystemParms where SysParm = 'EmailFolder1'"
		//    I = iCount(S)
		//    If I = 0 Then
		//        S = " INSERT into [SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('Default Thesaurus', 'This is the thesaurus that will be used when a specific thesaurus is not specified.', 'Roget', NULL, NULL, NULL, NULL)"
		//        Me.ExecuteSqlNewConn(S)
		//    End If
		
		//    S = "Select count(*) from SystemParms where SysParm = 'MaxSearchesToTrack'"
		//    I = iCount(S)
		//    If I = 0 Then
		//        S = " INSERT into [SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('RETENTION YEARS', 'The default number years to retain content.', '10', 'N', NULL, NULL, NULL)"
		//        Me.ExecuteSqlNewConn(S)
		//    End If
		
		//    S = "Select count(*) from SystemParms where SysParm = 'MaxUrlsToProcess'"
		//    I = iCount(S)
		//    If I = 0 Then
		//        S = " INSERT into [SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('EmailFolder1', 'This is the Top Level folder name and is required. It can be overridden for an individual user using the APP.CONFIG file, entry name EmailFolder1', 'Personal Folders', 'Y', NULL, NULL, NULL)"
		//        Me.ExecuteSqlNewConn(S)
		//    End If
		
		//    S = "Select count(*) from SystemParms where SysParm = 'RETENTION YEARS'"
		//    I = iCount(S)
		//    If I = 0 Then
		//        S = " INSERT into [SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SharePointVirtualLimit', 'When there are less records than this number, then a linked list is used for PURE speed.', '100001', 'Y', NULL, NULL, NULL)"
		//        Me.ExecuteSqlNewConn(S)
		//    End If
		
		//    S = "Select count(*) from SystemParms where SysParm = 'SharePointECMVirtualLimit'"
		//    I = iCount(S)
		//    If I = 0 Then
		//        S = " INSERT into [SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SharePointECMVirtualLimit', 'When there are less records than this number, then a linked list is used for PURE speed.', '1000001', 'Y', NULL, NULL, NULL)"
		//        Me.ExecuteSqlNewConn(S)
		//    End If
		
		//    S = "Select count(*) from SystemParms where SysParm = 'SharePointVirtualLimit'"
		//    I = iCount(S)
		//    If I = 0 Then
		//        S = " INSERT into [SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('srv_disable', 'When set to anything other than 0 the ECM Service will continue to run but will NOT archive.', '0', 'Y', NULL, NULL, NULL)"
		//        Me.ExecuteSqlNewConn(S)
		//    End If
		
		//    S = "Select count(*) from SystemParms where SysParm = 'SqlServerTimeout'"
		//    I = iCount(S)
		//    If I = 0 Then
		//        S = " INSERT into [SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('srv_PollingInterval', 'This is the number of MINUTES between executing an archive.', '60', 'Y', NULL, NULL, NULL)"
		//        Me.ExecuteSqlNewConn(S)
		//    End If
		
		//    S = "Select count(*) from SystemParms where SysParm = 'srv_disable'"
		//    I = iCount(S)
		//    If I = 0 Then
		//        S = " INSERT into [SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('srv_LastArchive', 'This is the datetime of the last completed archive.', '10/22/2009 7:58:57 PM', 'Y', NULL, NULL, NULL)"
		//        Me.ExecuteSqlNewConn(S)
		//    End If
		
		//    S = "Select count(*) from SystemParms where SysParm = 'srv_LastArchive'"
		//    I = iCount(S)
		//    If I = 0 Then
		//        S = " INSERT into [SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('MaxSearchesToTrack', 'The number of searches the user has in their immediate history.', '25', NULL, NULL, NULL, NULL)"
		//        Me.ExecuteSqlNewConn(S)
		//    End If
		
		//    S = "Select count(*) from SystemParms where SysParm = 'srv_PollingInterval'"
		//    I = iCount(S)
		//    If I = 0 Then
		//        S = " INSERT into [SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SqlServerTimeout', 'This is the value that will be assigned to the SQL Server timeout for users that do not have a specific timeout established.', '90', NULL, NULL, NULL, NULL)"
		//        Me.ExecuteSqlNewConn(S)
		//    End If
		
		//    S = "Select count(*) from SystemParms where SysParm = 'srv_shutdown'"
		//    I = iCount(S)
		//    If I = 0 Then
		//        S = " INSERT into [SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('srv_shutdown', 'When set to 1, the service (next poll) will stop running.', '0', 'Y', NULL, NULL, NULL)"
		//        Me.ExecuteSqlNewConn(S)
		//    End If
		
		//    S = "Select count(*) from SystemParms where SysParm = 'SYS_SingleInstance'"
		//    I = iCount(S)
		//    If I = 0 Then
		//        S = " INSERT into [SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SYS_SingleInstance', 'When set to 1, ECM will store just 1 copy of an archive.', '0', NULL, NULL, NULL, NULL)"
		//        Me.ExecuteSqlNewConn(S)
		//    End If
		
		//    S = "Select count(*) from SystemParms where SysParm = 'SYS_AllowPublic'"
		//    I = iCount(S)
		//    If I = 0 Then
		//        S = " INSERT into [SystemParms] ([SysParm], [SysParmDesc], [SysParmVal], [flgActive], [isDirectory], [isEmailFolder], [flgAllSubDirs]) VALUES ('SYS_AllowPublic', 'When set to 1, ECM will allow a user to set their content so it can be viewed by all users, otherwise, only they can see their content.', '0', NULL, NULL, NULL, NULL)"
		//        Me.ExecuteSqlNewConn(S)
		//    End If
		
		//End Sub
		
		public Guid getContainerGuid(string ContainerName)
		{
			
			ContainerName = ContainerName.Substring(0, 449);
			ContainerName = UTIL.RemoveSingleQuotes(ContainerName);
			
			string S = "Select ContainerGuid from Container where ContainerName = \'" + ContainerName + "\' ";
			string S2 = "Select Count(*) from Container where ContainerName = \'" + ContainerName + "\' ";
			Guid TgtGuid;
			
			int iCnt = iCount(S2);
			if (iCnt == 0)
			{
				TgtGuid = Guid.NewGuid();
				S2 = "INSERT INTO [Container]([ContainerGuid],[ContainerName])VALUES(\'" + TgtGuid.ToString() + "\', \'" + ContainerName + "\')";
				bool B = ExecuteSqlNewConn(S2);
				if (B == false)
				{
					return null;
				}
			}
			
			try
			{
				
				CkConn();
				SqlDataReader rsData = null;
				bool b = false;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				rsData.Read();
				TgtGuid = rsData.GetGuid(0);
				rsData.Close();
				rsData = null;
			}
			catch (Exception ex)
			{
				xTrace(12455, "clsDataBase:getContainerGuid", ex.Message);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getContainerGuid : 4445 : " + ex.Message));
				TgtGuid = null;
			}
			
			return TgtGuid;
		}
		
		
		public bool saveContentContainer(Guid ContainerGuid, Guid ContenUserRowGuid)
		{
			bool B = true;
			
			string S = "";
			S += " if not exists (select ContainerGuid from [ContentContainer] where [ContentUserRowGuid] = \'" + ContenUserRowGuid.ToString() + "\' and [ContainerGuid] = \'" + ContainerGuid.ToString() + "\')" + "\r\n";
			S += " begin " + "\r\n";
			S += " INSERT INTO [ContentContainer]" + "\r\n";
			S += " ([ContentUserRowGuid]" + "\r\n";
			S += " ,[ContainerGuid])" + "\r\n";
			S += " VALUES " + "\r\n";
			S += " (\'" + ContenUserRowGuid.ToString() + "\'" + "\r\n";
			S += " ,\'" + ContainerGuid.ToString() + "\')" + "\r\n";
			S += " END" + "\r\n";
			
			B = ExecuteSqlNewConn(S);
			
			if (! B)
			{
				LOG.WriteToErrorLog((string) ("ERROR 77342.A - Failed to insert content container: " + S));
			}
			
			return B;
			
		}
		
		public bool saveContentOwner(string ContentGuid, string UserID, string ContentTypeCode, string ContainerName, string MachineName, string NetworkName)
		{
			int iCnt = 0;
			string S = "";
			
			string MachineGuid = "\"";
			Guid ContainerGuid;
			
			if (! slMachineNetwork.ContainsKey(MachineName + "|" + NetworkName))
			{
				MachineGuid = MachineRegister(MachineName, NetworkName);
				slMachineNetwork.Add(MachineName + "|" + NetworkName, MachineGuid);
			}
			else
			{
				MachineGuid = slMachineNetwork[MachineName + "|" + NetworkName];
			}
			
			if (! slContainerGuid.ContainsKey(ContainerName))
			{
				ContainerGuid = getContainerGuid(ContainerName);
				slContainerGuid.Add(ContainerName, ContainerGuid);
			}
			else
			{
				ContainerGuid = getContainerGuid(ContainerName);
			}
			
			
			S = "Select count(*) from ContentUser where ContentGuid = \'" + ContentGuid + "\' and UserID = \'" + UserID + "\'";
			iCnt = iCount(S);
			
			if (iCnt == 0)
			{
				try
				{
					S = "INSERT INTO [ContentUser] ([ContentGuid] ,[UserID], ContentTypeCode, NbrOccurances) VALUES (\'" + ContentGuid + "\' ,\'" + UserID + "\' ,\'" + ContentTypeCode + "\', 1)";
					bool B = ExecuteSqlNewConn(S);
					if (! B)
					{
						xTrace(88652, "saveContentOwner", (string) ("ERROR: AddContentOwner - " + "\r\n" + S));
						LOG.WriteToArchiveLog((string) ("ERROR: AddContentOwner - " + S));
					}
					else
					{
						saveMachine(MachineGuid, ContentGuid, UserID);
					}
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("ERROR: AddContentOwner - " + ex.Message + "\r\n" + S));
				}
			}
			
			Guid ContentUserRowGuid = getContentUserGuid(ContentGuid, UserID);
			bool BB = saveContentContainer(ContainerGuid, ContentUserRowGuid);
			
			return BB;
			
		}
		
		/// <summary>
		/// Saves the machine by name and the associated peice of content on that machine.
		/// </summary>
		/// <param name="MachineName">Name of the machine.</param>
		/// <param name="SourceGuid">The source GUID.</param>
		/// <param name="UserID">The user ID.</param>
		public void saveMachine(string MachineName, string SourceGuid, string UserID)
		{
			
			string MySql = "";
			
			MySql += "  if NOT exists (Select MachineName from Machine " + "\r\n";
			MySql += "      where MachineName = \'" + MachineName + "\' " + "\r\n";
			MySql += "      and SourceGuid = \'" + SourceGuid + "\' " + "\r\n";
			MySql += "      and UserID = \'" + UserID + "\')" + "\r\n";
			MySql += "  Begin " + "\r\n";
			MySql += "      INSERT INTO [Machine] (SourceGuid, MachineName, UserID) VALUES (\'" + SourceGuid + "\',\'" + MachineName + "\', \'" + UserID + "\' )" + "\r\n";
			MySql += "  End" + "\r\n";
			
			bool BB = ExecuteSqlNewConn(MySql);
			
			if (! BB)
			{
				xTrace(334561, "SaveMachine", (string) ("ERRROR 77623.11 - Failed to add Machine: " + "\r\n" + MySql));
				LOG.WriteToErrorLog("ERRROR 77623.11 - Failed to add Machine.");
			}
			
		}
		
		
		/// <summary>
		/// Gets the content GUID based on the name of the File/Email and the HASH code.
		/// </summary>
		/// <param name="SourceName">Name of the source document.</param>
		/// <param name="CrcHash">The CRC hash.</param>
		/// <returns></returns>
		public string getContentGuid(string SourceName, string CrcHash)
		{
			
			SourceName = UTIL.RemoveSingleQuotes(SourceName);
			string S = "Select SourceGuid from DataSource where SourceName = \'" + SourceName + "\' and CRC = \'" + CrcHash + "\' ";
			string TgtGuid = "";
			
			try
			{
				
				CkConn();
				SqlDataReader rsData = null;
				bool b = false;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					rsData.Read();
					TgtGuid = rsData.GetString(0);
				}
				rsData.Close();
				rsData = null;
			}
			catch (Exception ex)
			{
				xTrace(12455, "clsDataBase:getContentUserGuid", ex.Message);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getContentUserGuid : 4445 : " + ex.Message));
				TgtGuid = null;
			}
			
			return TgtGuid;
		}
		
		public Guid getContentUserGuid(string ContentGuid, string UserID)
		{
			
			string S = "Select ContentUserRowGuid from ContentUser where ContentGuid = \'" + ContentGuid + "\' and UserID = \'" + UserID + "\' ";
			Guid TgtGuid;
			
			try
			{
				
				CkConn();
				SqlDataReader rsData = null;
				bool b = false;
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				rsData.Read();
				TgtGuid = rsData.GetGuid(0);
				rsData.Close();
				rsData = null;
			}
			catch (Exception ex)
			{
				xTrace(12455, "clsDataBase:getContentUserGuid", ex.Message);
				LOG.WriteToArchiveLog((string) ("clsDatabase : getContentUserGuid : 4445 : " + ex.Message));
				TgtGuid = null;
			}
			
			return TgtGuid;
		}
		
		public bool ContentOwnerExists(string ContentGuid, string UserID)
		{
			int iCnt = 0;
			string S = "";
			
			S = "Select count(*) from ContentUser where ContentGuid = \'" + ContentGuid + "\' and UserID = \'" + UserID + "\'";
			iCnt = iCount(S);
			
			if (iCnt == 0)
			{
				return false;
			}
			else
			{
				return true;
			}
			
		}
		
		public void SyncSourceOwners()
		{
			
			List<string> SqlStmts = new List<string>();
			
			string S = "Select Count(*) from DataSource";
			int iCnt = iCount(S);
			int I = 0;
			//frmreconMain.SB.Text = "0 of " + iCnt.ToString
			
			S = "Select SourceGuid, DataSourceOwnerUserID from DataSource where [SourceGuid] not in (Select SourceGuid from [ContentUser]) ";
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					I++;
					if (I % 100 == 0)
					{
						//frmreconMain.SB.Text = I.ToString + " of " + iCnt.ToString
						//'FrmMDIMain.Refresh()
						Application.DoEvents();
					}
					string SourceGuid = RSData.GetValue(0).ToString();
					string DataSourceOwnerUserID = RSData.GetValue(0).ToString();
					//Dim B As Boolean = ContentOwnerExists(SourceGuid , gCurrUserGuidID)
					//If Not B Then
					S = "INSERT INTO [ContentUser] ([ContentGuid] ,[UserID], NbrOccurances) VALUES (\'" + SourceGuid + "\' ,\'" + DataSourceOwnerUserID + "\', 1)";
					SqlStmts.Add(S);
					//End If
				}
			}
			RSData.Close();
			RSData = null;
			
			for (I = 0; I <= SqlStmts.Count - 1; I++)
			{
				if (I % 100 == 0)
				{
					//frmreconMain.SB.Text = "+ " + I.ToString + " of " + iCnt.ToString
					//'FrmMDIMain.Refresh()
					Application.DoEvents();
				}
				S = SqlStmts(I);
				bool B = ExecuteSqlNewConn(S);
				if (! B)
				{
					LOG.WriteToArchiveLog((string) ("ERROR: SyncSourceOwners - " + S));
				}
			}
			
		}
		public void ckRunAtStartUp()
		{
			
			string C = "";
			bool RunAtStart = false;
			
			C = getRconParm(modGlobals.gCurrUserGuidID, "LoadAtStartup");
			if (C.Length > 0)
			{
				if (C.Equals("True"))
				{
					RunAtStart = true;
				}
				else if (C.Equals("False"))
				{
					RunAtStart = false;
				}
				else
				{
					return;
				}
				try
				{
					string aPath = "";
					aPath = System.Reflection.Assembly.GetExecutingAssembly().Location;
					if (RunAtStart)
					{
						RegistryKey oReg = Registry.CurrentUser;
						//Dim oKey As RegistryKey = oReg.OpenSubKey("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", True)
						RegistryKey oKey = oReg.OpenSubKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run", true);
						oKey.CreateSubKey("EcmLibrary");
						oKey.SetValue("EcmLibrary", aPath);
						oKey.Close();
					}
					else
					{
						RegistryKey oReg = Registry.CurrentUser;
						RegistryKey oKey = oReg.OpenSubKey("Software\\Microsoft\\Windows\\CurrentVersion\\Run", true);
						oKey.CreateSubKey("EcmLibrary");
						oKey.SetValue("EcmLibrary", "");
						oKey.DeleteSubKey("EcmLibrary");
						oKey.Close();
					}
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("ERROR ckRunAtStartUp 102.22.1 - Failed to set start up parameter." + "\r\n" + ex.Message));
				}
			}
		}
		public void RegisterMachineToDB(string MachineName)
		{
			MachineName = UTIL.RemoveSingleQuotes(MachineName);
			int iCnt = iGetRowCount("MachineRegistered", " Where MachineName = \'" + MachineName + "\' ");
			if (iCnt == 0)
			{
				string S = "";
				bool B = false;
				S = "Insert into MachineRegistered (MachineName,CreateDate,LastUpdate) values (\'" + MachineName + "\', \'" + DateTime.Now.ToString() + "\', \'" + DateTime.Now.ToString() + "\')";
				B = ExecuteSqlNewConn(S);
				if (! B)
				{
					LOG.WriteToArchiveLog((string) ("ERROR RegisterMachineToDB 100 - Failed to add machine ID." + "\r\n" + S));
				}
			}
			
		}
		public bool isMachineRegistered(string MachineName)
		{
			MachineName = UTIL.RemoveSingleQuotes(MachineName);
			int iCnt = iGetRowCount("MachineRegistered", " Where MachineName = \'" + MachineName + "\' ");
			if (iCnt == 0)
			{
				return false;
			}
			else
			{
				return true;
			}
		}
		public void RegisterEcmClient(string MachineName)
		{
			int iCnt = 0;
			
			MachineName = UTIL.ReplaceSingleQuotes(MachineName);
			
			iCnt = this.iCount("Select count(*) from LoginClient where MachineName = \'" + MachineName + "\'");
			if (iCnt == 0)
			{
				string S = "Insert into LoginClient (MachineName) values (\'" + MachineName + "\') ";
				bool B = this.ExecuteSqlNewConn(S);
				if (! B)
				{
					LOG.WriteToArchiveLog("ERROR: RegisterEcmClient - Failed to register client for " + MachineName + ".");
				}
			}
		}
		
		public bool isDirAdminDisabled(string UserID, string FQN)
		{
			
			FQN = UTIL.RemoveSingleQuotes(FQN);
			
			bool B = false;
			try
			{
				string S = "Select count(*) from Directory where UserID = \'" + UserID + "\' and FQN = \'" + FQN + "\' and AdminDisabled = 1";
				int I = this.iCount(S);
				if (I >= 1)
				{
					B = true;
				}
				else
				{
					B = false;
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR clsDatabase:isDirAdminDisabled 100 - " + ex.Message));
				B = false;
			}
			return B;
		}
		
		public string getFolderNameById(string FolderID)
		{
			bool b = true;
			string S = "";
			S = "Select [FolderName]      ";
			S = S + " FROM [EmailFolder]";
			S = S + " where [FolderID] = \'" + FolderID + "\' and Userid = \'" + modGlobals.gCurrUserGuidID + "\' ";
			int i = 0;
			string id = "";
			
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			
			if (rsData.HasRows)
			{
				rsData.Read();
				id = rsData.GetValue(0).ToString();
			}
			else
			{
				id = "";
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			command.Dispose();
			command = null;
			
			if (CONN.State == ConnectionState.Open)
			{
				CONN.Close();
			}
			CONN.Dispose();
			//log.WriteToArchiveLog("*** FOLDER NOTICE getFolderNameById ID 001z - : " + id + vbCrLf + S)
			return id;
		}
		
		public string getFolderIdByName(string FolderName, string UID)
		{
			
			FolderName = UTIL.RemoveSingleQuotes(FolderName);
			
			bool b = true;
			string S = "";
			S = "Select [FolderID]      ";
			S = S + " FROM [EmailFolder]";
			S = S + " where [FolderName] = \'" + FolderName + "\' and UserID = \'" + UID + "\' ";
			int i = 0;
			string id = "";
			
			SqlDataReader rsData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			rsData = command.ExecuteReader();
			if (rsData.HasRows)
			{
				rsData.Read();
				id = rsData.GetValue(0).ToString();
			}
			else
			{
				id = "";
			}
			
			rsData.Close();
			rsData = null;
			
			return id;
			
		}
		
		public void RemoveLibraryDirectories(string DirectoryName, string LibraryName)
		{
			
			DirectoryName = UTIL.RemoveSingleQuotes(DirectoryName);
			
			string s = "";
			s = s + " select count(*) from LibraryItems";
			s = s + " where LibraryName = \'" + LibraryName + "\'";
			s = s + " and SourceGuid in (select SourceGuid from DataSource where FileDirectory = \'" + DirectoryName + "\')";
			
			int icnt = iCount(s);
			if (icnt == 0)
			{
				MessageBox.Show("No archived DOCUMENTS associated with Library \'" + LibraryName + "/" + DirectoryName + "\', returning.");
			}
			else
			{
				MessageBox.Show("There are " + icnt.ToString() + " DOCUMENTS associated with Library \'" + LibraryName + "/" + DirectoryName + "\', removing the association.");
			}
			
			LOG.WriteToArchiveLog("INFO RemoveLibraryDirectories: removed " + icnt.ToString() + " rows from directory " + DirectoryName + " in library " + LibraryName + ".");
			
			string ULogin = this.getUserLoginByUserid(modGlobals.gCurrUserGuidID);
			
			s = "";
			s = s + " DELETE FROM LibraryItems ";
			s = s + " where LibraryName = \'" + LibraryName + "\'";
			s = s + " and SourceGuid in (select SourceGuid from DataSource where FileDirectory = \'" + DirectoryName + "\')";
			
			bool B = ExecuteSqlNewConn(s);
			if (B == true)
			{
				string Msg = "Notice: Directory \'" + DirectoryName + "\' was removed from library \'" + LibraryName + "\' by User \'" + ULogin + "\'";
				LOG.WriteToArchiveLog(Msg);
				AddSysMsg(Msg);
			}
			else
			{
				string Msg = "Notice: Directory \'" + DirectoryName + "\' FAILED to remove from library \'" + LibraryName + "\' by User \'" + ULogin + "\'";
				LOG.WriteToArchiveLog(Msg);
				AddSysMsg(Msg);
			}
		}
		public void RemoveLibraryEmails(string FolderName, string LibraryName, string UserID)
		{
			
			string s = "";
			string CurrentmailFolderID = getFolderIdByName(FolderName, UserID);
			
			s = s + " select count(*) from LibraryItems";
			s = s + " where LibraryName = \'" + LibraryName + "\'";
			s = s + " and SourceGuid in (select EmailGuid from Email where OriginalFolder = \'" + FolderName + "\')";
			
			int icnt = iCount(s);
			if (icnt == 0)
			{
				MessageBox.Show("No archived emails associated with Library \'" + LibraryName + "/" + FolderName + "\', returning.");
			}
			else
			{
				MessageBox.Show("There are " + icnt.ToString() + " emails associated with Library \'" + LibraryName + "/" + FolderName + "\', removing the association.");
			}
			
			LOG.WriteToArchiveLog("INFO: RemoveLibraryEmails removed " + icnt.ToString() + " records from email folder + " + FolderName + " and Library " + LibraryName + ".");
			
			s = "";
			s = s + " delete from LibraryItems";
			s = s + " where LibraryName = \'" + LibraryName + "\'";
			s = s + " and SourceGuid in (select EmailGuid from Email where OriginalFolder = \'" + FolderName + "\')";
			
			bool B = ExecuteSqlNewConn(s);
			
			if (B == true)
			{
				string Msg = "Notice: EMAIL Folder \'" + FolderName + "\' was removed from library \'" + LibraryName + "\' by User \'" + UserID + "\'";
				LOG.WriteToArchiveLog(Msg);
				AddSysMsg(Msg);
			}
			else
			{
				string Msg = "Notice: EMAIL Folder \'" + FolderName + "\' - FAILED to remove from library \'" + LibraryName + "\' by User \'" + UserID + "\'";
				LOG.WriteToArchiveLog(Msg);
				AddSysMsg(Msg);
			}
			
		}
		public void AddLibraryDirectory(string FolderName, string LibraryName, string UserID, ref int RecordsAdded, bool bAddSubDir)
		{
			//select sourceguid,SourceName,OriginalFileType from DataSource where FileDirectory = 'c:\temp'
			RecordsAdded = 0;
			string s = "Select count(*) from DataSource where FileDirectory = \'" + FolderName + "\' and DataSourceOwnerUserID = \'" + UserID + "\' ";
			
			if (bAddSubDir)
			{
				s = "Select count(*) from DataSource where FileDirectory like \'" + FolderName + "%\' and DataSourceOwnerUserID = \'" + UserID + "\' ";
			}
			else
			{
				s = "Select count(*) from DataSource where FileDirectory = \'" + FolderName + "\' and DataSourceOwnerUserID = \'" + UserID + "\' ";
			}
			
			int iCnt = this.iCount(s);
			if (iCnt == 0)
			{
				return;
			}
			
			if (bAddSubDir)
			{
				s = "Select sourceguid,SourceName,OriginalFileType from DataSource where FileDirectory like \'" + FolderName + "%\' and DataSourceOwnerUserID = \'" + UserID + "\' ";
			}
			else
			{
				s = "Select sourceguid,SourceName,OriginalFileType from DataSource where FileDirectory = \'" + FolderName + "\' and DataSourceOwnerUserID = \'" + UserID + "\' ";
			}
			
			
			
			//  Select [SourceGuid]
			//,[SourceName]
			//,[ItemType]
			//,[LibraryItemGuid]
			//,[DataSourceOwnerUserID]
			//,[LibraryOwnerUserID]
			//,[LibraryName]
			//,[AddedByUserGuidId]
			
			
			string SourceName = "";
			string ItemType = "";
			string LibraryItemGuid = "";
			string LibraryOwnerUserID = GetLibOwnerByName(LibraryName);
			string AddedByUserGuidId = modGlobals.gCurrUserGuidID;
			string DataSourceOwnerUserID = UserID;
			
			
			string SourceGuid;
			string OriginalFileType;
			int i = 0;
			SqlDataReader RSData = null;
			
			string TempDirName = DMA.getEnvVarTempDir();
			string TempFQN = TempDirName + "\\AddLibItems.txt";
			
			File F;
			if (F.Exists(TempFQN))
			{
				F.Delete(TempFQN);
			}
			F = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			RSData = command.ExecuteReader();
			
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					Application.DoEvents();
					i++;
					if (i % 2 == 0)
					{
						frmLibraryAssignment.Default.SB.Text = i.ToString() + " of " + iCnt.ToString();
						//'FrmMDIMain.Refresh()
						Application.DoEvents();
					}
					
					SourceGuid = RSData.GetValue(0).ToString();
					SourceName = RSData.GetValue(1).ToString();
					OriginalFileType = RSData.GetValue(2).ToString();
					ItemType = OriginalFileType;
					LibraryItemGuid = Guid.NewGuid().ToString();
					
					string sData = SourceGuid;
					sData += (string) (Strings.Chr(254) + SourceName);
					sData += (string) (Strings.Chr(254) + ItemType);
					sData += (string) (Strings.Chr(254) + LibraryItemGuid);
					sData += (string) (Strings.Chr(254) + DataSourceOwnerUserID);
					sData += (string) (Strings.Chr(254) + LibraryOwnerUserID);
					sData += (string) (Strings.Chr(254) + LibraryName);
					sData += (string) (Strings.Chr(254) + AddedByUserGuidId);
					
					LOG.WriteToTempFile(TempFQN, sData);
					
				}
			}
			RSData.Close();
			RSData = null;
			
			int iRecCount = 0;
			System.IO.StreamReader objReaderCtr = new System.IO.StreamReader(TempFQN);
			while (objReaderCtr.Peek() != -1)
			{
				string TextLine = objReaderCtr.ReadLine();
				iRecCount++;
				if (i % 2 == 0)
				{
					frmLibraryAssignment.Default.SB.Text = (string) ("Pass #2: " + i.ToString() + " of " + iCnt.ToString());
					//'FrmMDIMain.Refresh()
					Application.DoEvents();
				}
			}
			
			objReaderCtr = null;
			
			//'FrmMDIMain.TSPB1.Minimum = 0
			//'FrmMDIMain.TSPB1.Maximum = iRecCount + 10
			//'FrmMDIMain.SB.Text = "Remaining to validate: " + iRecCount.ToString
			
			clsLIBRARYITEMS LI = new clsLIBRARYITEMS();
			
			i = 0;
			System.IO.StreamReader objReader = new System.IO.StreamReader(TempFQN);
			while (objReader.Peek() != -1)
			{
				
				if (modGlobals.gTerminateImmediately == true)
				{
					return;
				}
				
				i++;
				//'FrmMDIMain.SB4.Text = i.ToString
				Application.DoEvents();
				
				if (i % 2 == 0)
				{
					frmLibraryAssignment.Default.SB.Text = (string) ("Pass #3: " + i.ToString() + " of " + iCnt.ToString());
					//'FrmMDIMain.Refresh()
					Application.DoEvents();
				}
				
				string TextLine = objReader.ReadLine();
				if (TextLine.Length == 0)
				{
					goto NextRec;
				}
				
				string[] A = TextLine.Split(Strings.Chr(254).ToString().ToCharArray());
				
				if (A.Length < 2)
				{
					goto NextRec;
				}
				
				SourceGuid = A[0];
				SourceName = A[1];
				ItemType = A[2];
				LibraryItemGuid = A[3];
				DataSourceOwnerUserID = A[4];
				LibraryOwnerUserID = A[5];
				LibraryName = A[6];
				AddedByUserGuidId = A[7];
				
				RecordsAdded++;
				s = "Select count(*) from LibraryItems where LibraryName = \'" + LibraryName + "\' and SourceGuid = \'" + SourceGuid + "\'";
				iCnt = iCount(s);
				
				if (iCnt == 0)
				{
					LI.setAddedbyuserguidid(ref AddedByUserGuidId);
					LI.setDatasourceowneruserid(ref DataSourceOwnerUserID);
					LI.setItemtitle(ref SourceName);
					LI.setItemtype(ref ItemType);
					LI.setLibraryitemguid(ref LibraryItemGuid);
					LI.setLibraryname(ref LibraryName);
					LI.setLibraryowneruserid(ref LibraryOwnerUserID);
					LI.setSourceguid(ref SourceGuid);
					bool b = LI.Insert();
					if (! b)
					{
						LOG.WriteToArchiveLog("ERROR: Failed to add Library Item Directory: \'" + FolderName + "\', Library: \'" + LibraryName + "\', SourceName: \'" + SourceName + "\'");
					}
				}
NextRec:
				1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
			}
			
			objReader = null;
			
			LI = null;
			GC.Collect();
			
			s = "Select count(*) from LibraryItems where LibraryName = \'" + LibraryName + "\' and SourceGuid = \'" + SourceGuid + "\'";
			iCnt = iCount(s);
			
			//'FrmMDIMain.SB.Text = "Library additions: " + iCnt.ToString + " added."
			//'FrmMDIMain.SB4.Text = ""
			frmLibraryAssignment.Default.SB.Text = "Library additions complete: " + iCnt.ToString() + " added.";
			frmLibraryAssignment.Default.SB.Text = (string) ("Done: " + i.ToString() + " of " + iCnt.ToString());
		}
		public void AddLibraryEmail(string EmailFolder, string LibraryName, string UserID, int RecordsAdded)
		{
			
			string CurrentmailFolderID = getFolderIdByName(EmailFolder, UserID);
			
			//select emailguid, SUBSTRING(subject,1,100) as Subject, sourcetypecode from Email where Currmailfolderid  = '00000000AE37B53150C4EF4991D438C857CB5B08A2B40000'
			string s = "Select count(*) from Email where OriginalFolder  = \'" + EmailFolder + "\'";
			s = "";
			s = s + " select count(*) ";
			s = s + " from Email where OriginalFolder  = \'" + EmailFolder + "\'";
			s = s + " and Email.UserID in (select UserID from LibraryUsers where LibraryName = \'" + LibraryName + "\')";
			
			int iCnt = this.iCount(s);
			if (iCnt == 0)
			{
				frmLibraryAssignment.Default.SB.Text = "Done.";
				frmLibraryAssignment.Default.SB.Refresh();
				return;
			}
			
			s = "Select emailguid, SUBSTRING(subject,1,100) as Subject, SUBSTRING(body,1,100) as Body, sourcetypecode from Email where OriginalFolder  = \'" + EmailFolder + "\'";
			
			s = "";
			s = s + " select emailguid, SUBSTRING(subject,1,100) as Subject, SUBSTRING(body,1,100) as Body, sourcetypecode ";
			s = s + " from Email where OriginalFolder  = \'" + EmailFolder + "\'";
			s = s + " and Email.UserID in (select UserID from LibraryUsers where LibraryName = \'" + LibraryName + "\')";
			
			string SourceName = "";
			string ItemType = "";
			string LibraryItemGuid = "";
			string LibraryOwnerUserID = GetLibOwnerByName(LibraryName);
			string AddedByUserGuidId = modGlobals.gCurrUserGuidID;
			string DataSourceOwnerUserID = UserID;
			string Body = "";
			
			
			string EmailGuid = "";
			string OriginalFileType = "";
			int i = 0;
			SqlDataReader RSData = null;
			
			string TempDirName = DMA.getEnvVarTempDir();
			string TempFQN = TempDirName + "\\AddLibItems.txt";
			
			File F;
			if (F.Exists(TempFQN))
			{
				try
				{
					F.Delete(TempFQN);
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("Warning: could not delete " + TempFQN + "." + "\r\n" + ex.Message));
				}
			}
			F = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(s, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					
					i++;
					if (i % 5 == 0)
					{
						frmLibraryAssignment.Default.SB.Text = (string) ("Applied: " + i.ToString() + " of " + iCnt.ToString());
						frmLibraryAssignment.Default.SB.Refresh();
						//'FrmMDIMain.SB.Text = i.ToString + " of " + iCnt.ToString
						//'FrmMDIMain.Refresh()
						Application.DoEvents();
					}
					
					EmailGuid = RSData.GetValue(0).ToString();
					SourceName = RSData.GetValue(1).ToString();
					Body = RSData.GetValue(2).ToString();
					OriginalFileType = RSData.GetValue(3).ToString();
					
					if (SourceName.IndexOf("\r\n") + 1 > 0 || SourceName.IndexOf(Constants.vbCr) + 1 > 0 || SourceName.IndexOf(Constants.vbLf) + 1 > 0)
					{
						SourceName = UTIL.RemoveCrLF(SourceName);
					}
					if (Body.IndexOf("\r\n") + 1 > 0 || Body.IndexOf(Constants.vbCr) + 1 > 0 || Body.IndexOf(Constants.vbLf) + 1 > 0)
					{
						Body = UTIL.RemoveCrLF(Body);
					}
					
					if (SourceName.Trim.Length == 0)
					{
						SourceName = "-";
					}
					
					if (Body.Trim().Length == 0)
					{
						Body = "-";
					}
					if (OriginalFileType.Trim.Length == 0)
					{
						OriginalFileType = "?";
					}
					
					ItemType = OriginalFileType;
					LibraryItemGuid = Guid.NewGuid().ToString();
					
					string sData = "";
					sData = EmailGuid + Strings.Chr(253);
					sData = sData + SourceName + Strings.Chr(253);
					sData = sData + Body + Strings.Chr(253);
					sData = sData + ItemType + Strings.Chr(253);
					sData = sData + LibraryItemGuid + Strings.Chr(253);
					sData = sData + DataSourceOwnerUserID + Strings.Chr(253);
					sData = sData + LibraryOwnerUserID + Strings.Chr(253);
					sData = sData + LibraryName + Strings.Chr(253);
					sData = sData + AddedByUserGuidId + Strings.Chr(253);
					
					LOG.WriteToTempFile(TempFQN, sData);
					
				}
			}
			RSData.Close();
			RSData = null;
			
			int iRecCount = 0;
			System.IO.StreamReader objReaderCtr = new System.IO.StreamReader(TempFQN);
			while (objReaderCtr.Peek() != -1)
			{
				string TextLine = objReaderCtr.ReadLine();
				iRecCount++;
			}
			
			objReaderCtr = null;
			
			clsLIBRARYITEMS LI = new clsLIBRARYITEMS();
			
			//'FrmMDIMain.SB.Text = "Validating library entries: " + iRecCount.ToString
			//'FrmMDIMain.TSPB1.Minimum = 0
			//'FrmMDIMain.TSPB1.Maximum = iRecCount + 10
			
			i = 0;
			System.IO.StreamReader objReader = new System.IO.StreamReader(TempFQN);
			while (objReader.Peek() != -1)
			{
				i++;
				if (i % 10 == 0)
				{
					int iToProcess = iRecCount - i;
					//If iToProcess > 0 Then
					//    'FrmMDIMain.TSPB1.Value = iToProcess
					//End If
					Application.DoEvents();
				}
				string TextLine = objReader.ReadLine();
				
				if (TextLine.Trim.Length == 0)
				{
					goto SkipRec01;
				}
				
				string[] A = TextLine.Split(Strings.Chr(253).ToString().ToCharArray());
				
				if (A.Length != 10)
				{
					LOG.WriteToArchiveLog((string) ("Warning: Failed to enter email lib item " + A[1].Trim() + ",  " + A[0].Trim()));
					goto SkipRec01;
				}
				
				EmailGuid = A[0].Trim();
				SourceName = A[1].Trim();
				Body = A[2].Trim();
				ItemType = A[3].Trim();
				LibraryItemGuid = A[4].Trim();
				DataSourceOwnerUserID = A[5].Trim();
				LibraryOwnerUserID = A[6].Trim();
				LibraryName = A[7].Trim();
				AddedByUserGuidId = A[8].Trim();
				
				string NewSubj = SourceName + " : " + Body;
				NewSubj = NewSubj.Substring(0, 199);
				
				
				s = "Select count(*) from LibraryItems where LibraryName = \'" + LibraryName + "\' and SourceGuid = \'" + EmailGuid + "\'";
				iCnt = iCount(s);
				
				if (iCnt == 0)
				{
					LI.setAddedbyuserguidid(ref AddedByUserGuidId);
					LI.setDatasourceowneruserid(ref DataSourceOwnerUserID);
					LI.setItemtitle(ref NewSubj);
					LI.setItemtype(ref ItemType);
					LI.setLibraryitemguid(ref LibraryItemGuid);
					LI.setLibraryname(ref LibraryName);
					LI.setLibraryowneruserid(ref LibraryOwnerUserID);
					LI.setSourceguid(ref EmailGuid);
					bool b = LI.Insert();
					if (! b)
					{
						LOG.WriteToArchiveLog("ERROR: Failed to add Library Item to EMAIL Folder: \'" + EmailFolder + "\', Library: \'" + LibraryName + "\', ItemTitle: \'" + SourceName + "\'");
					}
				}
SkipRec01:
				1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
			}
			
			objReader = null;
			
			LI = null;
			GC.Collect();
			
			frmMain.Default.SB.Text = "Library audit complete.";
		}
		public void AddSysMsg(string tMsg)
		{
			
			tMsg = UTIL.RemoveSingleQuotesV1(tMsg);
			
			bool b = false;
			string S = "";
			var eGuid = "";
			eGuid = Guid.NewGuid().ToString();
			
			S = S + " INSERT INTO [SystemMessage]";
			S = S + "            ([UserID]";
			S = S + "            ,[EntryDate]";
			S = S + "            ,[EntryGuid]";
			S = S + "            ,[EntryMsg])";
			S = S + " VALUES ";
			S = S + "            (\'" + modGlobals.gCurrUserGuidID + "\'";
			S = S + "            ,\'" + DateTime.Now.ToString() + "\'";
			S = S + "            ,\'" + eGuid + "\'";
			S = S + "            ,\'" + tMsg + "\')";
			
			b = ExecuteSqlNewConn(S);
			
			if (! b)
			{
				LOG.WriteToArchiveLog("Warning: Failed to add system notice \'" + tMsg + "\' to log.");
			}
		}
		public bool isDirEnabled(string FQN)
		{
			
			FQN = UTIL.RemoveSingleQuotes(FQN);
			
			bool B = true;
			string S = "Select ckDisableDir from Directory where fqn = \'" + FQN + "\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
			CloseConn();
			GC.Collect();
			
			//Dim CNN As New SqlConnection
			SqlDataReader RSData = null;
			string tVal = "";
			try
			{
				CloseConn();
				CkConn();
				using (gConn)
				{
					SqlCommand command = new SqlCommand(S, gConn);
					RSData = SqlQryNewConn(S);
					RSData.Read();
					tVal = RSData.GetValue(0).ToString();
					command.Connection.Close();
					command = null;
				}
				
				if (tVal.ToUpper().Equals("Y"))
				{
					B = true;
				}
				else
				{
					B = false;
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("Error 100 - CLSDBARCH : isDirEnabled: " + ex.Message + "\r\n" + S));
				LOG.WriteToArchiveLog((string) ("Error 100 - CLSDBARCH : isDirEnabled: " + ex.StackTrace));
				B = false;
			}
			finally
			{
				if (RSData != null)
				{
					if (! RSData.IsClosed)
					{
						RSData.Close();
					}
					RSData = null;
				}
				//CNN.Close()
				//CNN.Dispose()
				//CNN = Nothing
				GC.Collect();
			}
			
			CloseConn();
			return B;
			
		}
		
		public void AddHashedDirName(string sName)
		{
			
			string S = "";
			double d = UTIL.HashName(sName);
			bool NameExists = false;
			string NewGuid = Guid.NewGuid().ToString();
			try
			{
				string HashedString = "";
				int icnt = iCount((string) ("Select count(*) from HashDir where Hash = " + d.ToString()));
				if (icnt == 0)
				{
					HashedString = UTIL.ReplaceSingleQuotes(sName);
					S = "Insert into HashDir (Hash, HashedString, HashID) values (" + d.ToString() + ",\'" + HashedString + "\', \'" + NewGuid + "\' ) ";
					bool B = ExecuteSqlNewConn(S);
					if (B == false)
					{
						LOG.WriteToArchiveLog((string) ("ERROR: AddHashedDirName 200 - " + S));
					}
					return;
				}
				else
				{
					NameExists = false;
					S = (string) ("Select HashedString, HashID from HashDir where Hash = " + d.ToString());
					SqlDataReader RSData = null;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					RSData = command.ExecuteReader();
					if (RSData.HasRows)
					{
						while (RSData.Read())
						{
							string tName = RSData.GetValue(0).ToString();
							string ID = RSData.GetValue(1).ToString();
							if (tName.ToUpper().Equals(sName.ToUpper()))
							{
								//* it already exists
								NameExists = true;
								break;
							}
						}
						if (NameExists == false)
						{
							
							HashedString = UTIL.ReplaceSingleQuotes(sName);
							S = "Insert into HashDir (Hash, HashedString, HashID) values (" + d.ToString() + ",\'" + HashedString + "\', \'" + NewGuid + "\') ";
							bool B = ExecuteSqlNewConn(S);
							if (B == false)
							{
								LOG.WriteToArchiveLog((string) ("ERROR: AddHashedDirName 400 - " + S));
							}
						}
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: AddHashedDirName 100 - " + ex.Message + "\r\n" + S));
			}
			
		}
		
		public void AddHashedFileName(string sName)
		{
			
			string S = "";
			//Dim d As Double = UTIL.HashName(sName )
			double d = UTIL.HashCalc(sName);
			bool NameExists = false;
			string NewGuid = Guid.NewGuid().ToString();
			try
			{
				string HashedString = "";
				int icnt = iCount((string) ("Select count(*) from HashFile where Hash = " + d.ToString()));
				if (icnt == 0)
				{
					HashedString = UTIL.ReplaceSingleQuotes(sName);
					S = "Insert into HashFile (Hash, HashedString, HashID) values (" + d.ToString() + ",\'" + HashedString + "\', \'" + NewGuid + "\' ) ";
					bool B = ExecuteSqlNewConn(S);
					if (B == false)
					{
						LOG.WriteToArchiveLog((string) ("ERROR: AddHashedFileName 200 - " + S));
					}
					return;
				}
				else
				{
					NameExists = false;
					S = (string) ("Select HashedString, HashID from HashFile where Hash = " + d.ToString());
					SqlDataReader RSData = null;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					RSData = command.ExecuteReader();
					if (RSData.HasRows)
					{
						while (RSData.Read())
						{
							string tName = RSData.GetValue(0).ToString();
							string ID = RSData.GetValue(1).ToString();
							if (tName.ToUpper().Equals(sName.ToUpper()))
							{
								//* it already exists
								NameExists = true;
								break;
							}
						}
						if (NameExists == false)
						{
							
							HashedString = UTIL.ReplaceSingleQuotes(sName);
							S = "Insert into HashFile (Hash, HashedString, HashID) values (" + d.ToString() + ",\'" + HashedString + "\', \'" + NewGuid + "\') ";
							bool B = ExecuteSqlNewConn(S);
							if (B == false)
							{
								LOG.WriteToArchiveLog((string) ("ERROR: AddHashedFileName 400 - " + S));
							}
						}
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: AddHashedFileName 100 - " + ex.Message + "\r\n" + S));
			}
			
		}
		
		public ArrayList getFqns(string Qty)
		{
			
			ArrayList A = new ArrayList();
			
			string S = "";
			S = S + " select top " + Qty + " fqn from DataSource";
			
			bool b = true;
			int i = 0;
			int id = -1;
			int II = 0;
			string table_name = "";
			string column_name = "";
			string data_type = "";
			string character_maximum_length = "";
			
			SqlDataReader RSData = null;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					string FQN = RSData.GetValue(0).ToString();
					A.Add(FQN);
				}
			}
			else
			{
				id = -1;
			}
			RSData.Close();
			RSData = null;
			
			return A;
			
		}
		public bool AddPstFolder(string StoreID, string ParentFolderName, string ParentFolderID, string FolderKeyName, string FolderID, string PstFQN, string RetentionCode)
		{
			//ByVal FolderID , ByVal CurrFolder As Microsoft.Office.Interop.Outlook.MAPIFolder,
			bool B = true;
			
			ParentFolderName = UTIL.RemoveSingleQuotes(ParentFolderName);
			
			string FolderName = ParentFolderName;
			string UID = modGlobals.gCurrUserGuidID;
			string SelectedForArchive = "Y";
			
			//Dim FolderFQN  = ParentFolderName + "|" + FolderKeyName
			string FolderFQN = FolderKeyName;
			FolderFQN = UTIL.RemoveSingleQuotes(FolderFQN);
			
			//Dim SS  = " select count(*) from EmailFolder where UserID = '" + gCurrUserGuidID + "' and FolderID = '" + ParentFolderName  + "'"
			string SS = " select count(*) from EmailFolder where UserID = \'" + modGlobals.gCurrUserGuidID + "\' and FolderID = \'" + FolderFQN + "\'";
			int iCnt = iCount(SS);
			
			if (iCnt == 1)
			{
				return true;
			}
			
			string S = "";
			S = S + " INSERT INTO [EmailFolder]";
			S = S + "    ([UserID]";
			S = S + "    ,[FolderName]";
			S = S + "    ,[ParentFolderName]";
			S = S + "    ,[FolderID]";
			S = S + "    ,[ParentFolderID]";
			S = S + "    ,[SelectedForArchive]";
			S = S + "    ,[StoreID]";
			S = S + "    ,[isSysDefault]";
			S = S + "    ,[RetentionCode])";
			S = S + " VALUES ";
			S = S + "    (\'" + UID + "\'";
			//S = S + "    ,'" + UTIL.RemoveSingleQuotes(FolderKeyName ) + "'"
			S = S + "    ,\'" + UTIL.RemoveSingleQuotes(FolderFQN) + "\'";
			S = S + "    ,\'" + UTIL.RemoveSingleQuotes(ParentFolderName) + "\'";
			S = S + "    ,\'" + FolderID + "\'";
			S = S + "    ,\'" + ParentFolderID + "\'";
			S = S + "    ,\'" + SelectedForArchive + "\'";
			S = S + "    ,\'" + StoreID + "\'";
			S = S + "    ,0";
			S = S + "    ,\'" + RetentionCode + "\')";
			
			B = ExecuteSqlNewConn(S);
			
			if (! B)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: AddPstFolder 100 - " + S));
			}
			
			return B;
		}
		
		public string getDirProfile(string ProfileName)
		{
			
			ProfileName = UTIL.RemoveSingleQuotes(ProfileName);
			
			string S = "";
			S = S + " Select [ProfileName]";
			S = S + " ,[Parms]";
			S = S + " FROM [DirProfiles]";
			S = S + " where ProfileName = \'" + ProfileName + "\' ";
			
			CloseConn();
			CkConn();
			
			string ProfileStr = "";
			string wc = "";
			
			try
			{
				using (gConn)
				{
					
					SqlDataReader RSData = null;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					RSData = command.ExecuteReader();
					RSData.Read();
					ProfileStr = RSData.GetValue(1).ToString();
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				
			}
			catch (Exception ex)
			{
				this.xTrace(30021, "iExecCountStmt", "clsDatabase", ex);
				ProfileStr = -1.ToString();
				LOG.WriteToArchiveLog((string) ("clsDatabase : iExecCountStmt : 100 : " + ex.Message));
			}
			
			return ProfileStr;
		}
		
		public string getNameOfCurrentServer()
		{
			string SvrName = "";
			string S = "Select serverproperty(\'MachineName\')";
			CloseConn();
			CkConn();
			
			string wc = "";
			
			try
			{
				using (gConn)
				{
					
					SqlDataReader RSData = null;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					RSData = command.ExecuteReader();
					RSData.Read();
					SvrName = RSData.GetValue(0).ToString();
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				
			}
			catch (Exception ex)
			{
				this.xTrace(30021, "iExecCountStmt", "clsDatabase", ex);
				SvrName = "";
				LOG.WriteToArchiveLog((string) ("clsDatabase : iExecCountStmt : 100 : " + ex.Message));
			}
			
			return SvrName;
		}
		
		public int getQuickRowCnt(string TableName)
		{
			int I = 0;
			TableName = UTIL.RemoveSingleQuotes(TableName);
			string S = "Select o.name, rows from sysobjects o inner join sysindexes i on o.id = i.id where i.indid < 2 and o.name = \'" + TableName + "\'";
			CloseConn();
			CkConn();
			
			try
			{
				using (gConn)
				{
					
					SqlDataReader RSData = null;
					string CS = getGateWayConnStr(modGlobals.gGateWayID);
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					RSData = command.ExecuteReader();
					RSData.Read();
					I = RSData.GetInt32(0);
					RSData.Close();
					RSData = null;
					command.Connection.Close();
					command = null;
				}
				
			}
			catch (Exception ex)
			{
				this.xTrace(30021, "iExecCountStmt", "clsDatabase", ex);
				I = -1;
				LOG.WriteToArchiveLog((string) ("clsDatabase : iExecCountStmt : 100 : " + ex.Message));
			}
			return I;
		}
		public string getHelpInfo()
		{
			
			SqlDataReader RSData = null;
			string S = "Select [HelpName],[HelpEmailAddr],[HelpPhone],[AreaOfFocus],[HoursAvail] FROM [HelpInfo] order by HelpName ";
			string HelpInfo = "";
			
			try
			{
				
				string HelpName = "";
				string HelpEmailAddr = "";
				string HelpPhone = "";
				string AreaOfFocus = "";
				string HoursAvail = "";
				
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						
						HelpName = RSData.GetValue(0).ToString();
						HelpEmailAddr = RSData.GetValue(1).ToString();
						HelpPhone = RSData.GetValue(2).ToString();
						AreaOfFocus = RSData.GetValue(3).ToString();
						HoursAvail = RSData.GetValue(4).ToString();
						
						if (HelpName.Trim.Length > 0)
						{
							HelpInfo = HelpInfo + "Contact - " + HelpName + "\r\n";
						}
						if (HelpName.Trim.Length > 0)
						{
							HelpInfo = HelpInfo + "Email - " + HelpEmailAddr + "\r\n";
						}
						if (HelpName.Trim.Length > 0)
						{
							HelpInfo = HelpInfo + "Phone - " + HelpPhone + "\r\n";
						}
						if (HelpName.Trim.Length > 0)
						{
							HelpInfo = HelpInfo + "Help Area - " + AreaOfFocus + "\r\n";
						}
						if (HelpName.Trim.Length > 0)
						{
							HelpInfo = HelpInfo + "Hours - " + HoursAvail + "\r\n";
						}
						
						HelpInfo += "\r\n";
						
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR getHelpInfo 100: " + ex.Message));
				return "";
			}
			finally
			{
				RSData.Close();
				RSData = null;
			}
			
			return HelpInfo;
			
		}
		public string getHelpEmail()
		{
			
			SqlDataReader RSData = null;
			string S = "Select [HelpEmailAddr] from HelpInfo where EmailNotification = 1 ";
			string HelpInfo = "";
			
			try
			{
				
				string HelpName = "";
				string HelpEmailAddr = "";
				string HelpPhone = "";
				string AreaOfFocus = "";
				string HoursAvail = "";
				
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						HelpEmailAddr = RSData.GetValue(0).ToString();
						HelpInfo = HelpInfo + HelpEmailAddr + "|";
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR getHelpEmail 100: " + ex.Message));
				return "support@EcmLibrary.com|dale@ecmlibrary.com|";
			}
			finally
			{
				RSData.Close();
				RSData = null;
				GC.Collect();
			}
			
			return HelpInfo;
			
		}
		
		public void PopulateGrid(string S, DataGridView DGV)
		{
			//System.Windows.Forms.DataGridViewCellEventArgs
			try
			{
				
				BindingSource BS = new BindingSource();
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection sqlcn = new SqlConnection(CS);
				SqlDataAdapter sadapt = new SqlDataAdapter(S, sqlcn);
				DataSet ds = new DataSet();
				
				if (sqlcn.State == ConnectionState.Closed)
				{
					sqlcn.Open();
				}
				
				sadapt.Fill(ds, "GridData");
				
				DGV.DataSource = ds.Tables["GridData"];
				
			}
			catch (Exception ex)
			{
				xTrace(100423, S, "frmTrace:PopulateGrid", ex);
				if (modGlobals.gRunUnattended == false)
				{
					MessageBox.Show((string) ("Error PopulateGrid 122165.4: " + ex.Message));
				}
				LOG.WriteToArchiveLog((string) ("Error PopulateGrid 122165.4: " + ex.Message));
			}
			
			
		}
		
		public void TraceActivity(string Msg)
		{
			string S = "";
			Msg = UTIL.RemoveSingleQuotes(Msg);
			S = "Insert into Trace ( [LogEntry] ) values ( \'" + Msg + "\' ) ";
			ExecuteSqlNewConn(S);
		}
		
		public void UpdateVersionInfo(string Product, string ProductVersion)
		{
			
			Product = UTIL.RemoveSingleQuotes(Product);
			ProductVersion = UTIL.RemoveSingleQuotes(ProductVersion);
			
			string S = "Select count(*) from VersionInfo where Product = \'" + Product + "\' ";
			
			int iCnt = iCount(S);
			
			if (iCnt == 0)
			{
				S = " INSERT INTO [VersionInfo] ([Product] ,[ProductVersion]) VALUES (\'" + Product + "\',\'" + ProductVersion + "\')";
			}
			else
			{
				S = " UPDATE [VersionInfo] SET [ProductVersion] = \'" + ProductVersion + "\' WHERE Product = \'" + Product + "\' ";
			}
			
			bool B = ExecuteSqlNewConn(S, false);
			if (B == false)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: UpdateVersionInfo - 100 : failed to update version info. " + "\r\n" + S));
			}
			
			
		}
		
		public string getVersionInfo(string Product)
		{
			string VerInfo = "";
			Product = UTIL.RemoveSingleQuotes(Product);
			
			string S = "Select count(*) from VersionInfo where Product = \'" + Product + "\' ";
			
			int iCnt = iCount(S);
			
			if (iCnt == 0)
			{
				VerInfo = (string) ("No version info exists on " + Product);
			}
			else
			{
				S = "Select [ProductVersion] FROM [VersionInfo] where [Product] = \'" + Product + "\' ";
				//S = "Select FixID, Applied, AppliedDate from DB_Updates order by FixID"
				SqlDataReader RSData = null;
				//RSData = SqlQryNo'Session(S)
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						VerInfo += RSData.GetValue(0).ToString();
						//VerInfo  += " : " + RSData.GetValue(1).ToString
						//VerInfo  += " : " + RSData.GetValue(2).ToString + vbCrLf
					}
				}
				else
				{
					VerInfo = (string) ("No version info exists on " + Product);
				}
			}
			
			bool B = ExecuteSqlNewConn(S, false);
			if (B == false)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: UpdateVersionInfo - 100 : failed to update version info. " + "\r\n" + S));
			}
			
			return VerInfo;
			
		}
		
		public bool FixEmailKeys()
		{
			try
			{
				//SELECT [FolderName], [ContainerName] FROM [EmailFolder]
				string S = "Select [FolderName] FROM [EmailFolder]";
				var FolderName = "";
				List<string> L = new List<string>();
				
				SqlDataReader RSData = null;
				//RSData = SqlQryNo'Session(S)
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						FolderName = RSData.GetValue(0).ToString();
						if (FolderName.IndexOf("|") + 1 > 0)
						{
							string tFolderName = FolderName.Substring(0, FolderName.IndexOf("|") + 0);
							tFolderName = tFolderName.Trim;
							if (tFolderName.Length > 0)
							{
								if (L.Contains(tFolderName))
								{
								}
								else
								{
									L.Add(tFolderName);
								}
							}
						}
						else
						{
							if (L.Contains(FolderName))
							{
							}
							else
							{
								L.Add(FolderName);
							}
						}
					}
				}
				
				RSData.Close();
				RSData = null;
				
				S = "update EmailFolder set ContainerName = \'xx\' where FolderName like \'xx%\'";
				
				for (int i = 0; i <= L.Count - 1; i++)
				{
					string tgtFolder = L(i);
					tgtFolder = UTIL.RemoveSingleQuotes(tgtFolder);
					S = "update EmailFolder set ContainerName = \'" + tgtFolder + "\' where FolderName like \'" + tgtFolder + "|%\' and ContainerName is null";
					bool BB = ExecuteSqlNewConn(S);
					if (! BB)
					{
						LOG.WriteToArchiveLog((string) ("ERROR - FixEmailKeys 200 : " + S));
					}
					
					S = "update EmailArchParms set ContainerName = \'" + tgtFolder + "\' where FolderName like \'" + tgtFolder + "|%\' and ContainerName is null";
					BB = ExecuteSqlNewConn(S);
					if (! BB)
					{
						LOG.WriteToArchiveLog((string) ("ERROR - FixEmailKeys 300 : " + S));
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR FixEmailKeys 100: " + ex.Message));
				return false;
			}
			
			
		}
		
		public void getAttachmentWeights(SortedList<string, int> SL)
		{
			SL.Clear();
			string S = "Select EmailGuid, Weight from EmailAttachmentSearchList where UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
			S = S + " and EmailGuid is not null";
			string EmailGuid = "";
			int Weight = -1;
			SqlDataReader RSData = null;
			
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					try
					{
						EmailGuid = RSData.GetValue(0).ToString();
						try
						{
							Weight = RSData.GetInt32(1);
						}
						catch (Exception)
						{
							Weight = 0;
							LOG.WriteToArchiveLog((string) ("INFO - returned null weights \'" + EmailGuid + "\' : " + S));
						}
						
						if (SL.Keys.Contains(EmailGuid))
						{
						}
						else
						{
							SL.Add(EmailGuid, Weight);
						}
					}
					catch (Exception)
					{
						LOG.WriteToArchiveLog((string) ("INFO - returned null values: " + S));
					}
					
				}
			}
			
			if (! RSData.IsClosed)
			{
				RSData.Close();
			}
			RSData = null;
			command.Dispose();
			command = null;
			
			if (CONN.State == ConnectionState.Open)
			{
				CONN.Close();
			}
			CONN.Dispose();
			
		}
		
		public void getDisabledDirectories(List<string> ListOfDirs)
		{
			ListOfDirs.Clear();
			string S = "Select [FQN] FROM [Directory] where UserID = \'" + modGlobals.gCurrUserGuidID + "\' and (ckDisableDir = \'Y\' or AdminDisabled = 1)";
			string DirFQN = "";
			int Weight = -1;
			SqlDataReader RSData = null;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					DirFQN = RSData.GetValue(0).ToString();
					if (ListOfDirs.Contains(DirFQN))
					{
					}
					else
					{
						ListOfDirs.Add(DirFQN);
					}
				}
			}
			RSData.Close();
			RSData = null;
		}
		
		public bool RunUnattended()
		{
			string ckVal = getUserParm("user_RunUnattended");
			//Dim ckVal  = getSystemParm("srv_RunUnattended")
			if (ckVal.Equals("1"))
			{
				modGlobals.gRunUnattended = true;
				return true;
			}
			else if (ckVal.Equals("0"))
			{
				modGlobals.gRunUnattended = false;
				return false;
			}
			else if (ckVal.ToUpper.Equals("Y"))
			{
				modGlobals.gRunUnattended = true;
				return true;
			}
			else if (ckVal.ToUpper.Equals("N"))
			{
				return false;
			}
			else
			{
				modGlobals.gRunUnattended = false;
				return false;
			}
			
		}
		
		public double getDbSize(ref System.Windows.Forms.DataGridView TargetGrid)
		{
			
			string S = " ";
			S = S + " SELECT";
			S = S + " a.FILEID,";
			S = S + " CONVERT(decimal(12,2),ROUND(a.size/128.000,2)) as [FILESIZEINMB] ,";
			S = S + " CONVERT(decimal(12,2),ROUND(fileproperty(a.name,\'SpaceUsed\')/128.000,2)) as [SPACEUSEDINMB],";
			S = S + " CONVERT(decimal(12,2),ROUND((a.size-fileproperty(a.name,\'SpaceUsed\'))/128.000,2)) as [FREESPACEINMB],";
			S = S + " a.name as [DATABASENAME],";
			S = S + " a.FILENAME as [FILENAME]";
			S = S + "     FROM ";
			S = S + "     dbo.sysfiles a ";
			
			PopulateGrid(S, TargetGrid);
			
		}
		
		public void getTableDasdUse(System.Windows.Forms.DataGridView TargetGrid)
		{
			string S = "";
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Connection = new SqlConnection(CS);
			if (Connection.State == ConnectionState.Closed)
			{
				Connection.Open();
			}
			SqlCommand Command = new SqlCommand();
			Command.Connection = Connection;
			Command.CommandText = "GetAllTableSizes";
			SqlDataAdapter Adapter = new SqlDataAdapter(Command);
			
			DataSet DataSet = new DataSet(Command.CommandText);
			
			Adapter.Fill(DataSet);
			TargetGrid.DataSource = DataSet.Tables[0];
			
		}
		
		public void getSpaceUsed(System.Windows.Forms.DataGridView TargetGrid)
		{
			string S = "";
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Connection = new SqlConnection(CS);
			if (Connection.State == ConnectionState.Closed)
			{
				Connection.Open();
			}
			
			SqlCommand Command = new SqlCommand();
			Command.Connection = Connection;
			Command.CommandText = "ECM_spaceused";
			SqlDataAdapter Adapter = new SqlDataAdapter(Command);
			
			DataSet DataSet = new DataSet(Command.CommandText);
			
			Adapter.Fill(DataSet);
			TargetGrid.DataSource = DataSet.Tables[0];
			
		}
		
		public bool isListeningOn()
		{
			string MachineName = DMA.GetCurrMachineName();
			string S = "Select COUNT(*) FROM [DirectoryListener] where Machinename = \'" + MachineName + "\' and [ListenerActive] = 1";
			int iCnt = iCount(S);
			if (iCnt > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public void GetListenerFiles(SortedList<string, string> L)
		{
			
			string S = "";
			L.Clear();
			string MachineName = DMA.GetCurrMachineName();
			MachineName = UTIL.RemoveSingleQuotes(MachineName);
			
			S = "Select [SourceFile], DirGuid  FROM [DirectoryListenerFiles] where Archived = 0 and MachineName = \'" + modGlobals.gMachineID + "\'";
			
			string FQN = "";
			string SourceFile = "";
			bool Archived = false;
			DateTime EntryDate = null;
			string UserID = "";
			string DirGuid = "";
			
			SqlDataReader RSData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			
			try
			{
				if (CONN.State == ConnectionState.Closed)
				{
					CONN.Open();
				}
			}
			catch (Exception ex)
			{
				L.Clear();
				LOG.WriteToArchiveLog((string) ("ERROR : GetListenerFiles 100 - " + ex.Message));
				return;
			}
			
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			
			try
			{
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						SourceFile = RSData.GetValue(0).ToString();
						DirGuid = RSData.GetValue(1).ToString();
						if (! L.ContainsKey(SourceFile))
						{
							L.Add(SourceFile, DirGuid);
						}
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: GetListenerFiles 100 - " + ex.Message + "\r\n" + S));
			}
			finally
			{
				if (! RSData.IsClosed)
				{
					RSData.Close();
				}
				RSData = null;
				command.Dispose();
				command = null;
				
				if (CONN.State == ConnectionState.Open)
				{
					CONN.Close();
				}
				CONN.Dispose();
			}
			
			
			
			
		}
		public void getModifiedFiles()
		{
			
			string cPath = LOG.getTempEnvironDir();
			string tFQN = cPath + "\\ListenerFilesLog.ECM";
			string NewFile = tFQN + ".rdy";
			FileInfo F0 = new FileInfo(NewFile);
			FileInfo F = new FileInfo(tFQN);
			SortedList<string, string> SL = new SortedList<string, string>();
			try
			{
				
				if (F0.Exists)
				{
					LOG.WriteToInstallLog("ACTIVATED the TimerUploadFiles: getModifiedFiles - the RDY file missing. ");
					goto P1;
				}
				
				if (F.Exists)
				{
					File.Move(tFQN, NewFile);
				}
				else
				{
					F = null;
					GC.Collect();
					return;
				}
				
P1:
				
				// Create new StreamReader instance with Using block.
				// Open file.txt with the Using statement.
				
				File F2;
				if (! F2.Exists(NewFile))
				{
					return;
				}
				
				F2 = null;
				StreamReader R = new StreamReader(NewFile);
				try
				{
					using (R)
					{
						// Store contents in this String.
						string line;
						
						// Read first line.
						line = R.ReadLine();
						int I = 0;
						// Loop over each line in file, While list is Not Nothing.
						while (! R.EndOfStream)
						{
							Application.DoEvents();
							
							I++;
							//'FrmMDIMain.ListenerStatus.Text = I.ToString
							Application.DoEvents();
							if (line.Trim().Length > 0)
							{
								string[] a = line.Split(Strings.Chr(254).ToString().ToCharArray());
								string CDE = a[0].ToUpper();
								string Fqn = a[1];
								if (SL.Count > 10000)
								{
									SL.Clear();
								}
								if (SL.ContainsKey(Fqn))
								{
								}
								else
								{
									FileInfo FI = new FileInfo(Fqn);
									if (FI.Exists)
									{
										string tDir = FI.DirectoryName;
										RegisterArchiveFile(Fqn, tDir);
										if (SL.ContainsKey(Fqn))
										{
										}
										else
										{
											SL.Add(Fqn, tDir);
											LOG.WriteToInstallLog((string) ("Registered file: getModifiedFiles: " + Fqn));
										}
									}
									FI = null;
								}
							}
							line = R.ReadLine();
						}
					}
					
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("ERROR getModifiedFiles - 288: " + ex.Message));
				}
				finally
				{
					R.Close();
					R.Dispose();
					GC.Collect();
				}
				
				try
				{
					if (F != null)
					{
						F = null;
					}
					if (F0 != null)
					{
						//F0.Delete()
						F0 = null;
					}
				}
				catch (Exception)
				{
					LOG.WriteToArchiveLog((string) ("ERROR getModifiedFiles 100 - could not delete file - " + tFQN));
				}
				finally
				{
					try
					{
						Kill(NewFile);
					}
					catch (Exception ex)
					{
						Console.WriteLine(ex.Message);
					}
				}
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: getModifiedFiles 200 Listener Files could not be processed for = " + tFQN + "\r\n" + ex.Message));
			}
			//'FrmMDIMain.ListenerStatus.Text = "."
		}
		
		public int getDocSize(string SourceGuid)
		{
			bool B = false;
			int I = 0;
			string S = "Select FileLength from DataSource where SourceGuid = \'" + SourceGuid + "\'";
			SqlDataReader RSData = null;
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					RSData.Read();
					I = RSData.GetInt32(0);
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("getDocSize - Warning: email - no msgsize found: " + ex.Message));
			}
			finally
			{
				CloseConn();
				RSData.Close();
				RSData = null;
			}
			return I;
		}
		
		public bool RegisterArchiveFile(string SourceFile, string DirName)
		{
			
			modGlobals.gListenerActivityStart = DateTime.Now;
			Application.DoEvents();
			bool B = true;
			
			string RunGuid = getDirGuid(DirName, modGlobals.gMachineID);
			
			SourceFile = UTIL.RemoveSingleQuotes(SourceFile);
			
			string S = "Select count(*) FROM [DirectoryListenerFiles] where [DirGuid] = \'" + RunGuid + "\' and SourceFile = \'" + SourceFile + "\'  AND archived = 0 ";
			//Dim S  = "Select count(*) FROM [DirectoryListenerFiles] where SourceFile = '" + SourceFile + "'  AND archived = 0 and MachineName = '" + gMachineID + "' "
			
			var iCnt = iCount(S);
			
			if (iCnt == 0)
			{
				S = "";
				S = S + " INSERT INTO [DirectoryListenerFiles]";
				S = S + "            ([DirGuid]";
				S = S + "            ,[SourceFile]";
				S = S + "            ,[Archived]";
				S = S + "            ,[EntryDate]";
				S = S + "            ,[UserID]";
				S = S + "            ,[MachineName], NameHash)";
				S = S + "      VALUES";
				S = S + "            (\'" + RunGuid + "\'";
				S = S + "            ,\'" + SourceFile + "\'";
				S = S + "            ,0";
				S = S + "            ,\'" + DateTime.Now.ToString() + "\'";
				S = S + "            ,\'" + modGlobals.gCurrUserGuidID + "\'";
				S = S + "            ,\'" + modGlobals.gMachineID + "\'";
				S = S + "            ," + 555.555;
				S = S + " )";
				
				B = ExecuteSqlNewConn(S);
				
			}
			
			modGlobals.gListenerActivityStart = DateTime.Now;
			
			return B;
		}
		
		public void CleanOutOldListenerFiles()
		{
			string S = "delete from DirectoryListenerFiles where DATEDIFF(dd,entrydate,GETDATE()) > 30";
			bool B = ExecuteSqlNewConn(S);
			if (! B)
			{
				LOG.WriteToArchiveLog((string) ("ERROR CleanOutOldListenerFiles 100 - failed to delete files: " + S));
			}
		}
		public void removeTempOcrFiles()
		{
			try
			{
				string WorkingDirectory = getWorkingDirectory(modGlobals.gCurrUserGuidID, "CONTENT WORKING DIRECTORY");
				LOG.PurgeDirectory(WorkingDirectory, "*.tif*");
			}
			catch (Exception)
			{
				LOG.WriteToArchiveLog((string) ("WARNING: removeTempOcrFiles Some temporary files may remain for a while in " + getWorkingDirectory(modGlobals.gCurrUserGuidID, "CONTENT WORKING DIRECTORY")));
			}
			
		}
		
		public void RemoveNullEmails()
		{
			string S = "";
			S = "Select count(*) from email where datalength(emailimage) < 1 or EmailImage is null";
			
			int icnt = iCount(S);
			
			if (icnt == 0)
			{
				MessageBox.Show("None to remove... returning");
				return;
			}
			
			string msg = "This will DELETE " + icnt.ToString() + " NULL items from emails, are you sure?";
			DialogResult dlgRes = MessageBox.Show(msg, "Delete Emails", MessageBoxButtons.YesNo);
			if (dlgRes == System.Windows.Forms.DialogResult.No)
			{
				return;
			}
			
			S = "Select EmailGuid, ShortSubj from email where datalength(emailimage) < 1 or EmailImage is null";
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			int I = 0;
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					I++;
					string EmailGuid = RSData.GetValue(0).ToString();
					string ShortSubj = RSData.GetValue(1).ToString();
					Application.DoEvents();
					//'FrmMDIMain.SB4.Text = I.ToString
					this.DeleteContent(EmailGuid, "EMAIL", ShortSubj);
				}
			}
			RSData.Close();
			RSData = null;
			
			//'FrmMDIMain.SB4.Text = "Done"
		}
		
		public void RemoveNullSource()
		{
			string S = "";
			S = "Select count(*) from dataSource where datalength(SourceImage) < 1 or SourceImage is null";
			
			int icnt = iCount(S);
			
			if (icnt == 0)
			{
				MessageBox.Show("None to remove... returning");
				return;
			}
			
			string msg = "This will remove " + icnt.ToString() + " NULL items from Source, are you sure?";
			DialogResult dlgRes = MessageBox.Show(msg, "Delete Content", MessageBoxButtons.YesNo);
			if (dlgRes == System.Windows.Forms.DialogResult.No)
			{
				return;
			}
			
			S = "Select SourceGuid, fqn from dataSource where datalength(SourceImage) < 1 or SourceImage is null";
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			int I = 0;
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					I++;
					string SourceGuid = RSData.GetValue(0).ToString();
					string fqn = RSData.GetValue(1).ToString();
					Application.DoEvents();
					//FrmMDIMain.SB4.Text = I.ToString
					this.DeleteContent(SourceGuid, "CONTENT", fqn);
				}
			}
			RSData.Close();
			RSData = null;
			
			//FrmMDIMain.SB4.Text = "Done"
			
		}
		
		public void GetDirectoryLibraries(string DirectoryName, List<string> L)
		{
			L.Clear();
			
			string ParentDirectoryToUse = "";
			bool isIncludedAsSubDir = isSubDirIncluded(DirectoryName, ref ParentDirectoryToUse);
			
			if (ParentDirectoryToUse.Length > 0)
			{
				DirectoryName = ParentDirectoryToUse;
			}
			
			DirectoryName = UTIL.RemoveSingleQuotes(DirectoryName);
			
			string LibName = "";
			string S = "Select LibraryName from LibDirectory where DirectoryName = \'" + DirectoryName + "\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\'";
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					LibName = RSData.GetValue(0).ToString();
					if (! L.Contains(LibName))
					{
						L.Add(LibName);
					}
				}
			}
			RSData.Close();
			RSData = null;
			
		}
		
		public bool ckFolderDisabled(string UID, string DirFQN)
		{
			
			string S = " ";
			
			DirFQN = UTIL.RemoveSingleQuotes(DirFQN);
			
			CloseConn();
			CkConn();
			
			S = "Select COUNT(*) from Directory where ckDisableDir = \'Y\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\' and FQN = \'" + DirFQN + "\'";
			
			int iCnt = iCount(S);
			
			if (iCnt > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
			
		}
		
		public void AddFileExt(string FileExt, string Description)
		{
			//FrmMDIMain.SB4.Text = FileExt
			FileExt = UTIL.RemoveSingleQuotes(FileExt);
			Description = UTIL.RemoveSingleQuotes(Description);
			string S = "Insert into FileType (FileExt, Description) Values (\'" + FileExt + "\', \'" + Description + "\')";
			bool B = ExecuteSqlNewConn(S);
		}
		
		public void DeleteContent(string TgtGuid, string TypeContent, string FQN)
		{
			
			string S = "";
			bool B = false;
			
			S = "Delete from SourceAttribute where SourceGuid = \'" + TgtGuid + "\' ";
			B = ExecuteSqlNewConn(S);
			
			S = "Delete from LibraryItems where SourceGuid = \'" + TgtGuid + "\' ";
			B = ExecuteSqlNewConn(S);
			
			if (TypeContent.ToUpper().Equals("EMAIL"))
			{
				
				S = "Delete from [Recipients] where EmailGuid = \'" + TgtGuid + "\' ";
				B = ExecuteSqlNewConn(S);
				
				S = "Delete from EMAIL where EmailGuid = \'" + TgtGuid + "\' ";
				B = ExecuteSqlNewConn(S);
				
			}
			else
			{
				
				S = "Delete from DataSource where SourceGuid = \'" + TgtGuid + "\' ";
				B = ExecuteSqlNewConn(S);
				
			}
			
			xTrace(666, "DeleteContent : F10 : " + modGlobals.gCurrLoginID + " deleted file " + FQN + ".", "frmDocSearch");
			
		}
		
		public bool isParentDirDisabled(string DirFQN)
		{
			string TgtLib = "";
			string TempDir = "";
			string SS = "";
			if (DirFQN.Trim().Length > 2)
			{
				if (DirFQN.Substring(0, 2) == "\\\\")
				{
					SS = "\\\\";
				}
				else
				{
					SS = "";
				}
			}
			
			List<string> DirList = new List<string>();
			
			string[] A = DirFQN.Split(char.Parse("\\").ToString().ToCharArray());
			
			for (int I = 0; I <= (A.Length - 1); I++)
			{
				TempDir = SS + TempDir + A[I];
				DirList.Add(TempDir);
				TempDir = TempDir + "\\";
			}
			
			for (int II = DirList.Count - 1; II >= 0; II--)
			{
				
				TempDir = DirList(II);
				TempDir = UTIL.RemoveSingleQuotes(TempDir);
				int iCnt = isDirectoryDisabled(TempDir);
				
				if (iCnt == 1)
				{
					return true;
				}
				else if (iCnt == 0)
				{
					return false;
				}
				
				TempDir = TempDir + "\\";
			}
			
			return false;
			
		}
		
		public int isDirectoryDisabled(string DirFqn)
		{
			
			int RC = -1;
			//Dim CNN As New SqlConnection
			SqlDataReader rsData = null;
			
			try
			{
				string S = "Select ckDisableDir from Directory where FQN = \'" + DirFqn + "\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
				
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				//Dim CONN As New SqlConnection(CS)
				//CONN.Open()
				
				bool b = false;
				rsData = SqlQryNewConn(S, CS);
				rsData.Read();
				if (rsData.HasRows)
				{
					string sChar = rsData.GetValue(0).ToString();
					if (sChar.ToUpper().Equals("Y"))
					{
						RC = 1;
					}
					else if (sChar.ToUpper().Equals("N"))
					{
						RC = 0;
					}
					else
					{
						RC = 0;
					}
				}
				else
				{
					RC = -1;
				}
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR isDirectoryDisabled 1993.21: " + ex.Message));
				RC = -1;
			}
			finally
			{
				//CloseConn()
				//GC.Collect()
				if (rsData != null)
				{
					if (! rsData.IsClosed)
					{
						rsData.Close();
					}
					rsData = null;
				}
				//CNN.Close()
				//CNN.Dispose()
				//CNN = Nothing
				GC.Collect();
			}
			
			return RC;
		}
		
		public int isSubDirIncludedBitON(string DirFqn)
		{
			
			int RC = -1;
			//Dim CNN As New SqlConnection
			SqlDataReader rsData = null;
			
			try
			{
				string S = "Select IncludeSubDirs from Directory where FQN = \'" + DirFqn + "\' and UserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
				
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				//Dim CONN As New SqlConnection(CS)
				//CONN.Open()
				
				bool b = false;
				rsData = SqlQryNewConn(S, CS);
				rsData.Read();
				if (rsData.HasRows)
				{
					string sChar = rsData.GetValue(0).ToString();
					if (sChar.ToUpper().Equals("Y"))
					{
						RC = 1;
					}
					else if (sChar.ToUpper().Equals("N"))
					{
						RC = 0;
					}
					else
					{
						RC = 0;
					}
				}
				else
				{
					RC = -1;
				}
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR isDirectoryDisabled 1993.21: " + ex.Message));
				RC = -1;
			}
			finally
			{
				//CloseConn()
				//GC.Collect()
				if (rsData != null)
				{
					if (! rsData.IsClosed)
					{
						rsData.Close();
					}
					rsData = null;
				}
				//CNN.Close()
				//CNN.Dispose()
				//CNN = Nothing
				GC.Collect();
			}
			
			return RC;
		}
		
		public bool isIndexed(string FileTypeCode)
		{
			
			if (FileTypeCode.IndexOf(".") + 1 == 0)
			{
				FileTypeCode = (string) ("." + FileTypeCode);
			}
			
			int iCnt = iCount("Select COUNT(*) from sys.fulltext_document_types where document_type = \'" + FileTypeCode + "\'");
			if (iCnt > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
			
		}
		//
		public bool isOcrd(string FileTypeCode)
		{
			
			if (FileTypeCode.IndexOf(".") + 1 == 0)
			{
				FileTypeCode = (string) ("." + FileTypeCode);
			}
			
			int iCnt = iCount("Select COUNT(*)  FROM [ImageTypeCodes] where ImageTypeCode = \'" + FileTypeCode + "\'");
			if (iCnt > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
			
		}
		public void getOcrTypes(List<string> L)
		{
			string S = "Select ImageTypeCode from ImageTypeCodes";
			
			L.Clear();
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					string FileExt = RSData.GetValue(0).ToString();
					FileExt = FileExt.ToUpper;
					if (! L.Contains(FileExt))
					{
						L.Add(FileExt);
					}
				}
			}
			RSData.Close();
			RSData = null;
			
		}
		public void getIndexedTypes(List<string> L)
		{
			string S = "Select document_type from sys.fulltext_document_types";
			
			L.Clear();
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					string FileExt = RSData.GetValue(0).ToString();
					FileExt = FileExt.ToUpper;
					if (! L.Contains(FileExt))
					{
						L.Add(FileExt);
					}
				}
			}
			RSData.Close();
			RSData = null;
			
		}
		public void getProcesssAsExt(SortedList<string, string> L)
		{
			L.Clear();
			string S = "Select [ExtCode],[ProcessExtCode] FROM [ProcessFileAs]";
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					string ExtCode = RSData.GetValue(0).ToString().ToUpper();
					string ProcessExtCode = RSData.GetValue(1).ToString().ToUpper();
					if (! L.ContainsKey(ExtCode))
					{
						L.Add(ExtCode, ProcessExtCode);
					}
				}
			}
			RSData.Close();
			RSData = null;
		}
		public void ShowIndexedFiles(DataGridView D)
		{
			
			ArrayList AL = new ArrayList();
			string[] dgCols;
			List<string> OCRTYPES = new List<string>();
			List<string> INDEXTYPES = new List<string>();
			string S = "";
			
			SortedList<string, string> ProcessAsExt = new SortedList<string, string>();
			getProcesssAsExt(ProcessAsExt);
			
			getOcrTypes(OCRTYPES);
			getIndexedTypes(INDEXTYPES);
			
			S = "Select     document_type AS FileExt, \'\' as Indexed, \'\' as Ocrd, \'\' as IndexedAs ";
			S = S + " FROM sys.fulltext_document_types ";
			S = S + " UNION";
			S = S + " SELECT     ExtCode AS FileExt, \'\' as Indexed, \'\' as Ocrd, \'\' as IndexedAs  ";
			S = S + " FROM AvailFileTypes ";
			S = S + " UNION";
			S = S + " SELECT     ImageTypeCode AS FileExt, \'\' as Indexed, \'\' as Ocrd, \'\' as IndexedAs  ";
			S = S + " FROM ImageTypeCodes ";
			S = S + " UNION";
			S = S + " SELECT DISTINCT OriginalFileType AS FileExt, \'\' as Indexed, \'\' as Ocrd, \'\' as IndexedAs  ";
			S = S + " FROM DataSource ";
			S = S + " ORDER BY FileExt";
			
			int iCount = 0;
			D.Rows.Clear();
			D.Columns.Add(0.ToString(), "EXT");
			D.Columns.Add(1.ToString(), "Indexed");
			D.Columns.Add(2.ToString(), "Ocrd");
			D.Columns.Add(3.ToString(), "IndexedAs");
			
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					string FileExt = RSData.GetValue(0).ToString();
					FileExt = FileExt.ToUpper;
					//If InStr(FileExt, "JPG", CompareMethod.Text) > 0 Then
					//    Console.WriteLine("XXX")
					//End If
					if (FileExt.IndexOf(".") + 1 == 0)
					{
						FileExt = (string) ("." + FileExt);
					}
					string Indexed = RSData.GetValue(1).ToString();
					string Ocrd = RSData.GetValue(2).ToString();
					bool BB = false;
					if (OCRTYPES.Contains(FileExt))
					{
						Ocrd = "Y";
						Indexed = "Y";
						BB = true;
					}
					else
					{
						Ocrd = "N";
					}
					if (BB == false)
					{
						if (INDEXTYPES.Contains(FileExt))
						{
							Indexed = "Y";
						}
						else
						{
							Indexed = "N";
						}
					}
					
					string IndexedAs = "-";
					if (ProcessAsExt.ContainsKey(FileExt))
					{
						int II = ProcessAsExt.IndexOfKey(FileExt);
						IndexedAs = ProcessAsExt[FileExt].ToString();
						//IndexedAs = ProcessAsExt.Values(II)
					}
					
					D.Rows.Add(FileExt, Indexed, Ocrd, IndexedAs);
					
					iCount++;
					
					
				}
			}
			RSData.Close();
			RSData = null;
			
			
		}
		
		public string getOcrText(string SourceGuid, string ContentType, string AttachmentName)
		{
			
			string S = "Select document_type from sys.fulltext_document_types";
			if (ContentType.Equals("DOC"))
			{
				S = "Select OcrText from DataSource where SourceGuid = \'" + SourceGuid + "\' ";
			}
			else
			{
				AttachmentName = UTIL.RemoveSingleQuotes(AttachmentName);
				S = "Select OcrText from EmailAttachment where EmailGuid = \'" + SourceGuid + "\' and AttachmentName = \'" + AttachmentName + "\' ";
			}
			
			string OcrText = "";
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					OcrText = RSData.GetValue(0).ToString();
				}
			}
			RSData.Close();
			RSData = null;
			return OcrText;
			
		}
		public string getSqlServerVersion()
		{
			
			string S = "Select @@VERSION AS \'ServerVersion\'";
			SqlDataReader rsData = null;
			string ServerVersion = "";
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				while (rsData.Read())
				{
					ServerVersion = rsData.GetValue(0).ToString();
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("Error: clsDatabase:getSqlServerVersion Error 100: " + ex.Message));
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			GC.Collect();
			return ServerVersion;
			
		}
		public double getDBSIZEMB()
		{
			
			string S = "exec Sp_spaceused";
			S = "Select ";
			S = S + "     a.name as [DatabaseName], a.FILEID,";
			S = S + "     CONVERT(decimal(12,2),ROUND(a.size/128.000,2)) as [FileSizeInMB] ,";
			S = S + "     CONVERT(decimal(12,2),ROUND(fileproperty(a.name,\'SpaceUsed\')/128.000,2)) as [SpaceUsedInMB],";
			S = S + "     CONVERT(decimal(12,2),ROUND((a.size-fileproperty(a.name,\'SpaceUsed\'))/128.000,2)) as [FreeSpaceInMB],    ";
			S = S + "     a.FILENAME as [FILENAME]";
			S = S + "     FROM";
			S = S + "     dbo.sysfiles a";
			SqlDataReader rsData = null;
			double DBSIZEMB = 0;
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				while (rsData.Read())
				{
					DBSIZEMB += (double) (rsData.GetDecimal(2));
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("Error: clsDatabase:getSqlDBSIZEMB Error 100: " + ex.Message));
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			GC.Collect();
			return DBSIZEMB;
			
		}
		
		public void RebuildCrossIndexFileTypes()
		{
			string S = " SELECT  ProcessFileAs.ExtCode, DataSource.SourceGuid, DataSource.OriginalFileType, DataSource.SourceTypeCode, ProcessFileAs.ProcessExtCode";
			S = S + " FROM         ProcessFileAs INNER JOIN";
			S = S + " DataSource ON ProcessFileAs.ExtCode = DataSource.OriginalFileType";
			//S = S + " where SourceTypeCode = OriginalFileType "
			
			int I = 0;
			int K = 0;
			string ExtCode = "";
			string SourceGuid = "";
			string OriginalFileType = "";
			string SourceTypeCode = "";
			string ProcessExtCode = "";
			
			SqlDataReader rsData = null;
			string ServerVersion = "";
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				while (rsData.Read())
				{
					Application.DoEvents();
					ExtCode = rsData.GetValue(0).ToString().ToLower();
					SourceGuid = rsData.GetValue(1).ToString();
					OriginalFileType = rsData.GetValue(2).ToString().ToLower();
					SourceTypeCode = rsData.GetValue(3).ToString().ToLower();
					ProcessExtCode = rsData.GetValue(4).ToString().ToLower();
					K++;
					if (K % 10 == 0)
					{
						//FrmMDIMain.SB4.Text = K.ToString + "/" + I.ToString
					}
					if (ProcessExtCode.Equals(SourceTypeCode))
					{
					}
					else
					{
						I++;
						S = "Update DataSource set SourceTypeCode = \'" + ProcessExtCode + "\' where SourceGuid = \'" + SourceGuid + "\' ";
						bool b = ExecuteSqlNewConn(S);
						if (! b)
						{
							LOG.WriteToArchiveLog("ERROR RebuildCrossIndexFileTypes: File with GUID \'" + SourceGuid + "\' did not UPDATE file type from \'" + OriginalFileType + "\' to \'" + ProcessExtCode + "\'.");
						}
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("Error: clsDatabase:getSqlServerVersion Error 100: " + ex.Message));
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			GC.Collect();
			//FrmMDIMain.SB4.Text = ""
			
		}
		
		public void ValidateFileTypesEmail()
		{
			string S = "Select rowid, attachmentname from EmailAttachment where OriginalFileTypeCode is null ";
			int I = 0;
			int rowid = 0;
			string ExtCode = "";
			string attachmentname = "";
			string OriginalFileType = "";
			string SourceTypeCode = "";
			string ProcessExtCode = "";
			int K = 0;
			
			SqlDataReader rsData = null;
			string ServerVersion = "";
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				while (rsData.Read())
				{
					Application.DoEvents();
					rowid = rsData.GetInt32(0);
					attachmentname = rsData.GetValue(1).ToString();
					OriginalFileType = UTIL.getFileSuffix(attachmentname).ToLower();
					K++;
					if (K % 10 == 0)
					{
						//FrmMDIMain.SB4.Text = K.ToString + "/" + I.ToString
					}
					if (OriginalFileType.IndexOf(".") + 1 == 0)
					{
						OriginalFileType = (string) ("." + OriginalFileType);
					}
					I++;
					S = (string) ("Update EmailAttachment set OriginalFileTypeCode = \'" + OriginalFileType + "\' where rowid = " + rowid.ToString());
					bool b = ExecuteSqlNewConn(S);
					if (! b)
					{
						LOG.WriteToArchiveLog("ERROR ValidateFileTypesEmail: File with ROWID \'" + rowid.ToString() + "\' did not UPDATE file type from \'" + OriginalFileType + "\' to \'" + ProcessExtCode + "\'.");
					}
					//End If
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("Error: clsDatabase:ValidateFileTypesEmail Error 100: " + ex.Message));
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			GC.Collect();
			//FrmMDIMain.SB4.Text = ""
			
		}
		
		public void RebuildCrossIndexFileTypesEmail()
		{
			
			ValidateFileTypesEmail();
			
			string S = "";
			S = S + " SELECT     ProcessFileAs.ExtCode, ProcessFileAs.ProcessExtCode, EmailAttachment.AttachmentName, EmailAttachment.RowID, EmailAttachment.OriginalFileTypeCode ";
			S = S + " FROM         ProcessFileAs INNER JOIN";
			S = S + "              EmailAttachment ON ProcessFileAs.ExtCode = EmailAttachment.AttachmentCode                     ";
			
			int I = 0;
			int K = 0;
			string AttachmentName = "";
			string ExtCode = "";
			int RowID = 0;
			string OriginalFileTypeCode = "";
			string SourceTypeCode = "";
			string ProcessExtCode = "";
			
			SqlDataReader rsData = null;
			string ServerVersion = "";
			try
			{
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				while (rsData.Read())
				{
					Application.DoEvents();
					ExtCode = rsData.GetValue(0).ToString().ToLower();
					ProcessExtCode = rsData.GetValue(1).ToString();
					AttachmentName = rsData.GetValue(2).ToString().ToLower();
					RowID = rsData.GetInt32(3);
					OriginalFileTypeCode = rsData.GetValue(4).ToString().ToLower();
					K++;
					if (K % 10 == 0)
					{
						//FrmMDIMain.SB4.Text = K.ToString + "/" + I.ToString
					}
					if (ProcessExtCode.Equals(SourceTypeCode))
					{
					}
					else
					{
						I++;
						S = (string) ("Update EmailAttachment set AttachmentCode = \'" + ProcessExtCode + "\' where RowID = " + RowID.ToString());
						bool b = ExecuteSqlNewConn(S);
						if (! b)
						{
							LOG.WriteToArchiveLog("ERROR RebuildCrossIndexFileTypesEmail: File with RowID \'" + RowID.ToString() + "\' did not UPDATE file type from \'" + OriginalFileTypeCode + "\' to \'" + ProcessExtCode + "\'.");
						}
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("Error: clsDatabase:getSqlServerVersion Error 100: " + ex.Message));
			}
			
			if (! rsData.IsClosed)
			{
				rsData.Close();
			}
			rsData = null;
			GC.Collect();
			//FrmMDIMain.SB4.Text = ""
			
			
		}
		public int EmailExists(string EmailIdentifier)
		{
			
			EmailIdentifier = UTIL.RemoveSingleQuotes(EmailIdentifier);
			
			int B = 0;
			string TBL = "Email";
			string WC = "Where EmailIdentifier = \'" + EmailIdentifier + "\'";
			
			
			B = iGetRowCount(TBL, WC);
			
			return B;
		}
		//update Email set EmailIdentifier = EmailGuid where EmailIdentifier is null
		public void resetMissingEmailIds()
		{
			
			bool B = false;
			string S = "";
			int ID = 217;
			
			S = S + "update Email set EmailIdentifier = EmailGuid where EmailIdentifier is null and UseriD = \'" + modGlobals.gCurrUserGuidID + "\' ";
			B = ExecuteSqlNewConn(S, false);
		}
		
		public void getLibUsers(bool isAdmin, DataGridView G)
		{
			G.Columns.Clear();
			G.Rows.Clear();
			
			G.Columns.Add("LibraryName", "Library Name");
			G.Columns.Add("UserName", "User Name");
			G.Columns.Add("OwnerName", "Owner Name");
			
			string S = "";
			if (isAdmin == true)
			{
				S = S + " SELECT distinct L.LibraryName, ";
				S = S + " L.LibraryOwnerUserID, ";
				S = S + " L.UserID";
				S = S + " from LibraryUsers L ";
				S = S + " order by LibraryName";
			}
			else
			{
				S = S + " SELECT distinct L.LibraryName, ";
				S = S + " L.LibraryOwnerUserID, ";
				S = S + " L.UserID";
				S = S + " from LibraryUsers L ";
				S = S + " Where  L.UserID = \'" + modGlobals.gCurrUserGuidID + "\' ";
				S = S + " order by LibraryName";
			}
			
			string LibraryName = "";
			string UserGuid = "";
			string OwnerGuid = "";
			string UserLoginID = "";
			string OwnerLoginID = "";
			string UserName = "";
			string OwnerName = "";
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					LibraryName = RSData.GetValue(0).ToString();
					OwnerGuid = RSData.GetValue(1).ToString();
					UserGuid = RSData.GetValue(2).ToString();
					OwnerLoginID = getUserLoginByUserid(OwnerGuid);
					UserLoginID = getUserLoginByUserid(UserGuid);
					OwnerName = getUserNameByID(OwnerGuid);
					UserName = getUserNameByID(UserGuid);
					G.Rows.Add(LibraryName, UserName, OwnerName);
				}
			}
			
			if (CONN.State == ConnectionState.Open)
			{
				CONN.Close();
			}
			
			CONN.Dispose();
			RSData.Close();
			RSData = null;
			GC.Collect();
			
		}
		
		
		public void cleanUpLibraryItems()
		{
			
			string S = "";
			S = S + " delete from LibraryItems where " + "\r\n";
			S = S + " SourceGuid not in (select emailguid as TgtGuid from Email" + "\r\n";
			S = S + " union " + "\r\n";
			S = S + " select sourceguid as TgtGuid from DataSource)";
			
			bool B = ExecuteSqlNewConn(S);
			if (! B)
			{
				LOG.WriteToArchiveLog("Warning cleanUpLibraryItems 100: did not successfully complete.");
			}
			
			S = "delete FROM LibraryItems where LibraryName not in  (select LibraryName from Library)";
			B = ExecuteSqlNewConn(S);
			if (! B)
			{
				LOG.WriteToArchiveLog("Warning cleanUpLibraryItems 200: did not successfully complete.");
			}
			
			S = "delete from LibraryUsers where LibraryName not in  (select LibraryName from Library)";
			B = ExecuteSqlNewConn(S);
			if (! B)
			{
				LOG.WriteToArchiveLog("Warning cleanUpLibraryItems 300: did not successfully complete.");
			}
			
			S = "delete from LibraryUsers where UserID not in  (select userid from users)";
			B = ExecuteSqlNewConn(S);
			if (! B)
			{
				LOG.WriteToArchiveLog("Warning cleanUpLibraryItems 300.1: did not successfully complete.");
			}
			
			S = "delete from GroupUsers where UserID not in (select userid from users) ";
			B = ExecuteSqlNewConn(S);
			if (! B)
			{
				LOG.WriteToArchiveLog("Warning cleanUpLibraryItems 400: did not successfully complete.");
			}
			
			S = "delete from GroupUsers where GroupName not in (select GroupName from UserGroup) ";
			B = ExecuteSqlNewConn(S);
			if (! B)
			{
				LOG.WriteToArchiveLog("Warning cleanUpLibraryItems 500: did not successfully complete.");
			}
			
		}
		public void inventoryContentLibraryItems()
		{
			
			string S = "";
			S = S + " SELECT COUNT(*)";
			S = S + " FROM LibDirectory INNER JOIN";
			S = S + " DataSource ON LibDirectory.DirectoryName = DataSource.FileDirectory";
			
			int II = 0;
			int iCnt = iCount(S);
			int RecsToProcess = iCnt;
			
			if (iCnt == 0)
			{
				return;
			}
			
			string TGuid = Guid.NewGuid().ToString();
			
			//S = ""
			//S = S + " SELECT LibDirectory.DirectoryName, LibDirectory.LibraryName, DataSource.SourceGuid, DataSource.OriginalFileType"
			//'S = S + "   INTO #T" + TGuid
			//S = S + " FROM LibDirectory INNER JOIN"
			//S = S + " DataSource ON LibDirectory.DirectoryName = DataSource.FileDirectory"
			
			S = "";
			S = S + " SELECT DISTINCT LibDirectory.LibraryName, DataSource.SourceGuid, DataSource.OriginalFileType, Library.UserID, DataSource.SourceName, DataSource.DataSourceOwnerUserID";
			S = S + " FROM         LibDirectory INNER JOIN";
			S = S + " DataSource ON LibDirectory.DirectoryName = DataSource.FileDirectory INNER JOIN";
			S = S + " Library ON LibDirectory.UserID = Library.UserID";
			//S = S + " GROUP BY LibDirectory.LibraryName, DataSource.SourceGuid, DataSource.OriginalFileType, Library.UserID, DataSource.SourceName"
			
			//SELECT FirstName, LastName
			//INTO TestTable
			//FROM Person.Contact
			//WHERE EmailPromotion = 2
			//----Verify that Data in TestTable
			//SELECT FirstName, LastName
			//FROM TestTable
			//----Clean Up Database
			//DROP TABLE TestTable
			
			string tDir = LOG.getTempEnvironDir();
			string LIKEYS = tDir + "\\" + TGuid + ".txt";
			StreamWriter SW = new StreamWriter(LIKEYS);
			
			string DirectoryName = "";
			string LibraryName = "";
			string SourceGuid = "";
			string OriginalFileType = "";
			string SourceName = "";
			string DataSourceOwnerUserID = "";
			string UserID = "";
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					II++;
					//FrmMDIMain.SB4.Text = "Step 1 of 2: " + II.ToString + " of " + RecsToProcess.ToString
					Application.DoEvents();
					
					LibraryName = RSData.GetValue(0).ToString();
					SourceGuid = RSData.GetValue(1).ToString();
					OriginalFileType = RSData.GetValue(2).ToString();
					UserID = RSData.GetValue(3).ToString();
					SourceName = RSData.GetValue(4).ToString();
					DataSourceOwnerUserID = RSData.GetValue(5).ToString();
					
					if (OriginalFileType.IndexOf(".") + 1 == 0)
					{
						OriginalFileType = (string) ("." + OriginalFileType);
					}
					
					S = "";
					S += LibraryName + Strings.Chr(254);
					S += SourceGuid + Strings.Chr(254);
					S += OriginalFileType + Strings.Chr(254);
					S += UserID + Strings.Chr(254);
					S += SourceName + Strings.Chr(254);
					S += DataSourceOwnerUserID;
					
					SW.WriteLine(S);
					
				}
			}
			RSData.Close();
			RSData = null;
			SW.Close();
			
			System.IO.StreamReader srFileReader;
			string sInputLine = "";
			
			II = 0;
			srFileReader = System.IO.File.OpenText(LIKEYS);
			sInputLine = srFileReader.ReadLine();
			while (!(sInputLine == null))
			{
				//FrmMDIMain.SB4.Text = "Step 2 of 2: " + II.ToString + " of " + RecsToProcess.ToString
				Application.DoEvents();
				
				sInputLine = srFileReader.ReadLine();
				
				if (sInputLine == "")
				{
					goto NextRow;
				}
				
				string[] A = sInputLine.Split(Strings.Chr(254).ToString().ToCharArray());
				
				LibraryName = UTIL.RemoveSingleQuotes(A[0]);
				SourceGuid = A[1];
				OriginalFileType = A[2];
				UserID = A[3];
				SourceName = A[4];
				DataSourceOwnerUserID = A[5];
				
				S = "Select count(*) from LibraryItems where LibraryName = \'" + LibraryName + "\' and SourceGuid = \'" + SourceGuid + "\'";
				iCnt = iCount(S);
				
				if (iCnt == 0)
				{
					S = "";
					S = S + " INSERT INTO [LibraryItems]" + "\r\n";
					S = S + " ([SourceGuid]" + "\r\n";
					S = S + " ,[ItemTitle]" + "\r\n";
					S = S + " ,[ItemType]" + "\r\n";
					S = S + " ,[LibraryItemGuid]" + "\r\n";
					S = S + " ,[DataSourceOwnerUserID]" + "\r\n";
					S = S + " ,[LibraryOwnerUserID]" + "\r\n";
					S = S + " ,[LibraryName]" + "\r\n";
					S = S + " ,[AddedByUserGuidId])" + "\r\n";
					S = S + "      VALUES( " + "\r\n";
					S = S + " (\'" + SourceGuid + "\'" + "\r\n";
					S = S + " ,\'" + SourceName + "\'" + "\r\n";
					S = S + " ,\'" + OriginalFileType + "\'" + "\r\n";
					S = S + " ,\'" + Guid.NewGuid().ToString() + "\'" + "\r\n";
					S = S + " ,\'" + DataSourceOwnerUserID + "\'" + "\r\n";
					S = S + " ,\'" + LibraryName + "\'" + "\r\n";
					S = S + " ,\'" + modGlobals.gCurrUserGuidID + "\')";
					
					bool B = ExecuteSqlNewConn(S);
					if (! B)
					{
						LOG.WriteToArchiveLog("Error: ValidateLibraryItems 100 - Failed to add library item Library: [" + LibraryName + "], SourceName: [" + SourceName + "], SourceGuid: [" + SourceGuid + "]");
					}
					
				}
NextRow:
				1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
			}
			
			srFileReader.Close();
			srFileReader.Dispose();
			SW.Dispose();
			RSData = null;
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
		}
		
		public void inventoryEmailLibraryItems()
		{
			
			string S = "";
			//S = S + " SELECT COUNT(*)"
			//S = S + " FROM LibEmail INNER JOIN"
			//S = S + " DataSource ON LibDirectory.DirectoryName = DataSource.FileDirectory"
			
			int II = 0;
			int iCnt = 0; //iCount(S)
			int RecsToProcess = iCnt;
			
			//If iCnt = 0 Then
			//    Return
			//End If
			
			string TGuid = Guid.NewGuid().ToString();
			S = "";
			S = S + " Select DISTINCT" + "\r\n";
			S = S + " LibEmail.LibraryName , email.emailGuid, " + "\r\n";
			S = S + " email.SourceTypeCode, Library.UserID, Email.ShortSubj, " + "\r\n";
			S = S + " Email.UserID" + "\r\n";
			S = S + " FROM         LibEmail INNER JOIN" + "\r\n";
			S = S + " Email ON LibEmail.FolderName = Email.OriginalFolder" + "\r\n";
			S = S + " INNER Join " + "\r\n";
			S = S + " Library ON LibEmail.UserID = Library.UserID";
			
			Clipboard.Clear();
			Clipboard.SetText(S);
			
			string tDir = LOG.getTempEnvironDir();
			string LIKEYS = tDir + "\\" + TGuid + ".txt";
			StreamWriter SW = new StreamWriter(LIKEYS);
			
			string LibraryName = "";
			string SourceGuid = "";
			string OriginalFileType = "";
			string DataSourceOwnerUserID = "";
			string SourceName = "";
			string UserID = "";
			
			SqlDataReader rsEmail = null;
			//rsEmail = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			
			Clipboard.Clear();
			Clipboard.SetText(S);
			
			rsEmail = command.ExecuteReader();
			
			if (rsEmail.HasRows)
			{
				while (rsEmail.Read())
				{
					II++;
					//FrmMDIMain.SB4.Text = "Step 3 of 4: " + II.ToString + " of " + RecsToProcess.ToString
					Application.DoEvents();
					
					LibraryName = rsEmail.GetValue(0).ToString();
					SourceGuid = rsEmail.GetValue(1).ToString();
					OriginalFileType = rsEmail.GetValue(2).ToString();
					DataSourceOwnerUserID = rsEmail.GetValue(3).ToString();
					SourceName = rsEmail.GetValue(4).ToString();
					UserID = rsEmail.GetValue(5).ToString();
					
					if (OriginalFileType.IndexOf(".") + 1 == 0)
					{
						OriginalFileType = (string) ("." + OriginalFileType);
					}
					
					S = "";
					S += LibraryName + Strings.Chr(254);
					S += SourceGuid + Strings.Chr(254);
					S += OriginalFileType + Strings.Chr(254);
					S += UserID + Strings.Chr(254);
					S += SourceName + Strings.Chr(254);
					S += DataSourceOwnerUserID;
					
					SW.WriteLine(S);
					
				}
			}
			rsEmail.Close();
			rsEmail = null;
			SW.Close();
			
			System.IO.StreamReader srFileReader;
			string sInputLine = "";
			
			II = 0;
			srFileReader = System.IO.File.OpenText(LIKEYS);
			sInputLine = srFileReader.ReadLine();
			while (!(sInputLine == null))
			{
				//FrmMDIMain.SB4.Text = "Step 4 of 4: " + II.ToString + " of " + RecsToProcess.ToString
				Application.DoEvents();
				
				sInputLine = srFileReader.ReadLine();
				
				if (sInputLine == "")
				{
					goto NextRow;
				}
				
				string[] A = sInputLine.Split(Strings.Chr(254).ToString().ToCharArray());
				
				LibraryName = UTIL.RemoveSingleQuotes(A[0]);
				SourceGuid = A[1];
				OriginalFileType = A[2];
				UserID = A[3];
				SourceName = A[4];
				DataSourceOwnerUserID = A[5];
				
				S = "Select count(*) from LibraryItems where LibraryName = \'" + LibraryName + "\' and SourceGuid = \'" + SourceGuid + "\'";
				iCnt = iCount(S);
				
				if (iCnt == 0)
				{
					S = "";
					S = S + " INSERT INTO [LibraryItems]" + "\r\n";
					S = S + " ([SourceGuid]" + "\r\n";
					S = S + " ,[ItemTitle]" + "\r\n";
					S = S + " ,[ItemType]" + "\r\n";
					S = S + " ,[LibraryItemGuid]" + "\r\n";
					S = S + " ,[DataSourceOwnerUserID]" + "\r\n";
					S = S + " ,[LibraryOwnerUserID]" + "\r\n";
					S = S + " ,[LibraryName]" + "\r\n";
					S = S + " ,[AddedByUserGuidId])" + "\r\n";
					S = S + "      VALUES( " + "\r\n";
					S = S + " (\'" + SourceGuid + "\'" + "\r\n";
					S = S + " ,\'" + SourceName + "\'" + "\r\n";
					S = S + " ,\'" + OriginalFileType + "\'" + "\r\n";
					S = S + " ,\'" + Guid.NewGuid().ToString() + "\'" + "\r\n";
					S = S + " ,\'" + DataSourceOwnerUserID + "\'" + "\r\n";
					S = S + " ,\'" + LibraryName + "\'" + "\r\n";
					S = S + " ,\'" + modGlobals.gCurrUserGuidID + "\')";
					
					bool B = ExecuteSqlNewConn(S);
					if (! B)
					{
						LOG.WriteToArchiveLog("Error: ValidateLibraryItems 100 - Failed to add library item Library: [" + LibraryName + "], SourceName: [" + SourceName + "], SourceGuid: [" + SourceGuid + "]");
					}
					
				}
NextRow:
				1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
			}
			
			srFileReader.Close();
			srFileReader.Dispose();
			SW.Dispose();
			rsEmail = null;
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			//FrmMDIMain.SB4.Text = "Validation Complete"
			
		}
		
		public void GetListOfAssignedLibraries(string DirectoryName, string TypeEntry, List<string> AssignedLibraries)
		{
			
			string S = "";
			AssignedLibraries.Clear();
			
			if (TypeEntry.Equals("EMAIL"))
			{
				S = "Select LibraryName from LibEmail where FolderName = \'" + DirectoryName + "\'";
			}
			else
			{
				S = "Select LibraryName from LibDirectory where DirectoryName = \'" + DirectoryName + "\'";
			}
			
			
			string LibraryName = "";
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					LibraryName = RSData.GetValue(0).ToString();
					if (! AssignedLibraries.Contains(LibraryName))
					{
						AssignedLibraries.Add(LibraryName);
					}
				}
			}
			else
			{
				AssignedLibraries.Add("No assigned libraries");
			}
			RSData.Close();
			RSData = null;
			command.Dispose();
			if (CONN.State == ConnectionState.Open)
			{
				CONN.Close();
			}
			CONN.Dispose();
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
		}
		
		public bool isSubDirIncluded(string DirFQN, ref string ParentDir)
		{
			
			ParentDir = "";
			
			string TgtLib = "";
			string TempDir = "";
			string SS = "";
			if (DirFQN.Trim().Length > 2)
			{
				if (DirFQN.Substring(0, 2) == "\\\\")
				{
					SS = "\\\\";
				}
				else
				{
					SS = "";
				}
			}
			
			List<string> DirList = new List<string>();
			
			string[] A = DirFQN.Split(char.Parse("\\").ToString().ToCharArray());
			
			for (int I = 0; I <= (A.Length - 1); I++)
			{
				TempDir = SS + TempDir + A[I];
				DirList.Add(TempDir);
				TempDir = TempDir + "\\";
			}
			
			for (int II = DirList.Count - 1; II >= 0; II--)
			{
				
				TempDir = DirList(II);
				TempDir = UTIL.RemoveSingleQuotes(TempDir);
				
				int iCnt = isSubDirIncludedBitON(TempDir);
				
				if (iCnt == 1)
				{
					ParentDir = TempDir;
					return true;
				}
				else if (iCnt == 0)
				{
					return false;
				}
				
				TempDir = TempDir + "\\";
			}
			
			return false;
		}
		public void getLibraryOwnerGuids(SortedList<string, string> LibraryOwnerGuids)
		{
			string S = "Select LibraryName,UserID from Library";
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			try
			{
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						var LibraryName = RSData.GetValue(0).ToString();
						var UserID = RSData.GetValue(1).ToString();
						if (! LibraryOwnerGuids.ContainsKey(LibraryName))
						{
							LibraryOwnerGuids.Add(LibraryName, UserID);
						}
					}
					
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: AddLibraryGroupUser 100 - " + ex.Message + "\r\n" + S));
			}
			finally
			{
				RSData.Close();
				RSData = null;
			}
		}
		
		public void AddLibraryGroupUser(string GroupName)
		{
			
			GroupName = UTIL.RemoveSingleQuotes(GroupName);
			
			SortedList<string, string> LibraryOwnerGuids = new SortedList<string, string>();
			
			getLibraryOwnerGuids(LibraryOwnerGuids);
			
			string S = "";
			
			S = S + " SELECT     GroupLibraryAccess.LibraryName, GroupLibraryAccess.GroupOwnerUserID, GroupLibraryAccess.GroupName, ";
			S = S + "               GroupUsers.UserID AS GroupUserGuid, GroupUsers.FullAccess, GroupUsers.ReadOnlyAccess, GroupUsers.DeleteAccess, GroupUsers.Searchable, ";
			S = S + "                       GroupUsers.GroupOwnerUserID AS GroupOwnerUserIDGuid";
			S = S + " FROM         GroupLibraryAccess INNER JOIN";
			S = S + "               GroupUsers ON GroupLibraryAccess.GroupName = GroupUsers.GroupName";
			if (GroupName.Equals("*"))
			{
			}
			else
			{
				S = S + " WHERE     (GroupLibraryAccess.GroupName = \'" + GroupName + "\')";
			}
			S = S + " order by GroupLibraryAccess.LibraryName";
			
			string LibraryName = "";
			string GroupOwnerUserID = "";
			string tGroupName = "";
			string GroupUserGuid = "";
			string FullAccess = "";
			string ReadOnlyAccess = "";
			string DeleteAccess = "";
			string Searchable = "";
			string GroupOwnerUserIDGuid = "";
			
			List<string> deleteExecutionList = new List<string>();
			List<string> insertExecutionList = new List<string>();
			string PrevLibName = "";
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			try
			{
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						
						LibraryName = RSData.GetValue(0).ToString();
						GroupOwnerUserID = RSData.GetValue(1).ToString();
						tGroupName = RSData.GetValue(2).ToString();
						GroupUserGuid = RSData.GetValue(3).ToString();
						FullAccess = RSData.GetValue(4).ToString();
						ReadOnlyAccess = RSData.GetValue(5).ToString();
						DeleteAccess = RSData.GetValue(6).ToString();
						Searchable = RSData.GetValue(7).ToString();
						GroupOwnerUserIDGuid = RSData.GetValue(8).ToString();
						
						//If PrevLibName <> LibraryName Then
						//    Dim tsql As String = "DELETE FROM LibraryUsers where [LibraryName] = '" + LibraryName + "' and (SingleUser is null or SingleUser = 0)"
						//    deleteExecutionList.Add(tsql)
						//End If
						
						string LibraryOwnerUserID = "";
						if (LibraryOwnerGuids.ContainsKey(LibraryName)) //
						{
							int iName = LibraryOwnerGuids.IndexOfKey(LibraryName);
							LibraryOwnerUserID = LibraryOwnerGuids.Values(iName);
						}
						else
						{
							LibraryOwnerUserID = modGlobals.gCurrUserGuidID;
						}
						
						LibraryName = UTIL.RemoveSingleQuotes(LibraryName);
						
						string iSql = "";
						//iSql = iSql + ""
						//iSql = iSql + "INSERT INTO [LibraryUsers]"
						//iSql = iSql + " ([ReadOnly]"
						//iSql = iSql + ",[CreateAccess]"
						//iSql = iSql + ",[UpdateAccess]"
						//iSql = iSql + ",[DeleteAccess]"
						//iSql = iSql + ",[UserID]"
						//iSql = iSql + ",[LibraryOwnerUserID]"
						//iSql = iSql + ",[LibraryName])"
						//iSql = iSql + " VALUES"
						//iSql = iSql + " (0"
						//iSql = iSql + ",1"
						//iSql = iSql + ",1"
						//iSql = iSql + ",1"
						//iSql = iSql + ",'" + GroupUserGuid + "'"
						//iSql = iSql + ",'" + LibraryOwnerUserID + "'"
						//iSql = iSql + ",'" + LibraryName + "')"
						
						iSql = "";
						iSql += "INSERT INTO [LibraryUsers]" + "\r\n";
						iSql += "           ([ReadOnly]" + "\r\n";
						iSql += "           ,[CreateAccess]" + "\r\n";
						iSql += "           ,[UpdateAccess]" + "\r\n";
						iSql += "           ,[DeleteAccess]" + "\r\n";
						iSql += "           ,[UserID]" + "\r\n";
						iSql += "           ,[LibraryOwnerUserID]" + "\r\n";
						iSql += "           ,[LibraryName]" + "\r\n";
						iSql += "           ,[NotAddedAsGroupMember]" + "\r\n";
						iSql += "           ,[GroupUser])" + "\r\n";
						iSql += "     VALUES" + "\r\n";
						iSql += "           (0" + "\r\n";
						iSql += "           ,1" + "\r\n";
						iSql += "           ,1" + "\r\n";
						iSql += "           ,0" + "\r\n";
						iSql += "           ,\'" + GroupUserGuid + "\'" + "\r\n";
						iSql += "           ,\'" + GroupOwnerUserIDGuid + "\'" + "\r\n";
						iSql += "           ,\'" + LibraryName + "\'" + "\r\n";
						iSql += "           ,0" + "\r\n";
						iSql += "           ,1)" + "\r\n";
						
						insertExecutionList.Add(iSql);
						
						PrevLibName = LibraryName;
						
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: AddLibraryGroupUser 100 - " + ex.Message + "\r\n" + S));
			}
			finally
			{
				RSData.Close();
			}
			
			RSData = null;
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			for (int I = 0; I <= deleteExecutionList.Count - 1; I++)
			{
				string tSql = deleteExecutionList(I);
				bool B = true;
				B = ExecuteSqlNewConn(tSql);
				if (! B)
				{
					LOG.WriteToArchiveLog((string) ("ERROR: Failed to DELETE library users for library " + LibraryName + " : " + tSql));
				}
			}
			
			for (int I = 0; I <= insertExecutionList.Count - 1; I++)
			{
				string tSql = insertExecutionList(I);
				bool B = true;
				B = ExecuteSqlNewConn(tSql);
				if (! B)
				{
					LOG.WriteToArchiveLog((string) ("ERROR: Failed to ADD library user. " + "\r\n" + tSql));
				}
				else
				{
					LOG.WriteToArchiveLog((string) ("NOTICE: ADDED library user. " + "\r\n" + tSql));
				}
			}
			
		}
		
		public void DeleteLibraryGroupUser(string GroupName, string LibraryName)
		{
			
			GroupName = UTIL.RemoveSingleQuotes(GroupName);
			LibraryName = UTIL.RemoveSingleQuotes(LibraryName);
			
			string S = "";
			
			S += " SELECT     GroupLibraryAccess.GroupName, GroupLibraryAccess.LibraryName, GroupUsers.UserID AS Userid" + "\r\n";
			S += " FROM       GroupLibraryAccess INNER JOIN" + "\r\n";
			S += "            GroupUsers ON GroupLibraryAccess.GroupName = GroupUsers.GroupName" + "\r\n";
			S += " WHERE      GroupLibraryAccess.GroupName = \'" + GroupName + "\'" + "\r\n";
			S += " AND        LibraryName = \'" + LibraryName + "\'" + "\r\n";
			S += " order by   GroupLibraryAccess.GroupName, GroupLibraryAccess.LibraryName" + "\r\n";
			
			string Userid = "";
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			try
			{
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						Userid = RSData.GetValue(2).ToString();
						string SS = "delete from GroupLibraryAccess where UseriD = \'" + Userid + "\' and LibraryName = \'" + LibraryName + "\' and groupname = \'" + GroupName + "\'";
						int iCnt = countGroupsUserBelongsTo(LibraryName, Userid);
						if (iCnt == 0)
						{
							SS = "delete from LibraryUsers where UserID = \'" + Userid + "\' and LibraryName = \'" + LibraryName + "\'  and SingleUser != 1";
							bool B1 = ExecuteSqlNewConn(S);
							if (! B1)
							{
								Console.WriteLine("Failed to delete " + Userid + " from Library " + LibraryName + ".");
							}
						}
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: AddLibraryGroupUser 100 - " + ex.Message + "\r\n" + S));
			}
			finally
			{
				RSData.Close();
			}
			
			RSData = null;
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
		}
		
		public void DeleteLibraryGroupUser(string GroupName, string LibraryName, string GroupUserID)
		{
			
			GroupName = UTIL.RemoveSingleQuotes(GroupName);
			LibraryName = UTIL.RemoveSingleQuotes(LibraryName);
			
			string S = "";
			
			S += " SELECT     GroupLibraryAccess.GroupName, GroupLibraryAccess.LibraryName, GroupUsers.UserID AS Userid" + "\r\n";
			S += " FROM         GroupLibraryAccess INNER JOIN" + "\r\n";
			S += "                       GroupUsers ON GroupLibraryAccess.GroupName = GroupUsers.GroupName" + "\r\n";
			S += " WHERE     (GroupLibraryAccess.GroupName = \'" + GroupName + "\') " + "\r\n";
			S += "     AND (GroupLibraryAccess.LibraryName = \'" + LibraryName + "\') " + "\r\n";
			S += "     AND (GroupUsers.UserID = \'" + GroupUserID + "\')" + "\r\n";
			
			Clipboard.Clear();
			Clipboard.SetText(S);
			
			string Userid = "";
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			try
			{
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						Userid = GroupUserID;
						string SS = "delete from GroupLibraryAccess where UseriD = \'" + Userid + "\' and LibraryName = \'" + LibraryName + "\' and groupname = \'" + GroupName + "\'";
						int iCnt = countGroupsUserBelongsTo(LibraryName, Userid);
						if (iCnt == 0)
						{
							SS = "delete from LibraryUsers where UserID = \'" + Userid + "\' and LibraryName = \'" + LibraryName + "\'  and SingleUser != 1";
							bool B1 = ExecuteSqlNewConn(S);
							if (! B1)
							{
								Console.WriteLine("Failed to delete " + Userid + " from Library " + LibraryName + ".");
							}
						}
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: AddLibraryGroupUser 100 - " + ex.Message + "\r\n" + S));
			}
			finally
			{
				RSData.Close();
			}
			
			RSData = null;
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
		}
		
		public void VerifyOrphanSourceData()
		{
			try
			{
				string S = "Select sourceguid from DataSource where DATALENGTH(SourceImage) = 0";
				string sourceguid = "";
				
				SqlDataReader RSData = null;
				//RSData = SqlQryNo'Session(S)
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				//Data Source=DELLT100\ECMLIB;Initial Catalog=ECM.Library;Integrated Security=True; Connect Timeout = 30
				if (CS.IndexOf("Connect Timeout") + 1 > 0)
				{
					int II = CS.IndexOf("Connect Timeout") + 1;
					CS = CS.Substring(0, II - 1);
				}
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						Application.DoEvents();
						System.Threading.Thread.Sleep(100);
						sourceguid = RSData.GetValue(0).ToString();
						DeleteContent(sourceguid, "CONTENT", "Orphan records");
					}
				}
				RSData.Close();
				RSData = null;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: VerifyOrphanSourceData - " + ex.Message));
			}
			
			MessageBox.Show("Source Validation Complete.");
			
		}
		
		public void VerifyOrphanEmailData()
		{
			
			try
			{
				string S = "Select emailguid from Email where DATALENGTH(EmailImage) = 0 ";
				string EmailGuid = "";
				
				SqlDataReader RSData = null;
				//RSData = SqlQryNo'Session(S)
				string CS = getGateWayConnStr(modGlobals.gGateWayID);
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				//Data Source=DELLT100\ECMLIB;Initial Catalog=ECM.Library;Integrated Security=True; Connect Timeout = 30
				if (CS.IndexOf("Connect Timeout") + 1 > 0)
				{
					int II = CS.IndexOf("Connect Timeout") + 1;
					CS = CS.Substring(0, II - 1);
				}
				
				if (RSData.HasRows)
				{
					while (RSData.Read())
					{
						System.Threading.Thread.Sleep(100);
						Application.DoEvents();
						EmailGuid = RSData.GetValue(0).ToString();
						DeleteEmailByGuid(EmailGuid);
					}
				}
				RSData.Close();
				RSData = null;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: VerifyOrphanEmailData - " + ex.Message));
			}
			
			MessageBox.Show("Email Validation Complete.");
			
		}
		
		
		public void AddStdTriggers(string TblName, List<string> Keys)
		{
			string S = "";
			bool B = false;
			
			string TriggerName = "";
			
			TriggerName = "trig<XX>_Update";
			TriggerName = TriggerName.Replace("<XX>", TblName.Trim());
			S = "";
			S = S + " IF EXISTS (SELECT * FROM sys.triggers" + "\r\n";
			S = S + "     WHERE name = \'<XX>\')" + "\r\n";
			S = S + " DROP TRIGGER <XX>" + "\r\n";
			S = S.Replace("<XX>", TriggerName.Trim());
			B = ExecuteSqlNewConn(S);
			if (! B)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: Failed to drop trigger - " + TriggerName));
			}
			
			Clipboard.Clear();
			Clipboard.SetText(S);
			
			S = "";
			S = S + "CREATE TRIGGER trig<XX>_Update" + "\r\n";
			S = S + "   ON <XX>" + "\r\n";
			S = S + "         AFTER Update " + "\r\n";
			S = S + "   AS" + "\r\n";
			S = S + "         BEGIN " + "\r\n";
			S = S + "         UPDATE <XX> " + "\r\n";
			S = S + "   SET RowLastModDate = GETDATE(), [RepoSvrName] = @@SERVERNAME" + "\r\n";
			S = S + "         FROM inserted " + "\r\n";
			S = S + "   WHERE ";
			for (int i = 0; i <= Keys.Count - 1; i++)
			{
				if (i == 0)
				{
					S = S + "     <XX>" + "." + Keys(i) + " = inserted." + Keys(i) + "\r\n";
				}
				else
				{
					S = S + "     and <XX>" + "." + Keys(i) + " = inserted." + Keys(i) + "\r\n";
				}
			}
			S = S.Replace("<XX>", TblName.Trim());
			S = S + " End" + "\r\n";
			
			Clipboard.Clear();
			Clipboard.SetText(S);
			
			B = ExecuteSqlNewConn(S);
			if (! B)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: Failed to CREATE trigger - " + TriggerName));
			}
			
			TriggerName = "<XX>_INS";
			TriggerName = TriggerName.Replace("<XX>", TblName.Trim());
			S = "";
			S = S + " IF EXISTS (SELECT * FROM sys.triggers" + "\r\n";
			S = S + "     WHERE name = \'<XX>\')" + "\r\n";
			S = S + " DROP TRIGGER <XX>" + "\r\n";
			S = S.Replace("<XX>", TriggerName.Trim());
			
			Clipboard.Clear();
			Clipboard.SetText(S);
			
			
			B = ExecuteSqlNewConn(S);
			if (! B)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: Failed to drop trigger - " + TriggerName));
			}
			
			S = "";
			S = S + " Create TRIGGER <XX>_INS" + "\r\n";
			S = S + "   ON dbo.<XX>" + "\r\n";
			S = S + "   FOR UPDATE " + "\r\n";
			S = S + " AS" + "\r\n";
			S = S + "   IF ( @@ROWCOUNT = 0 )" + "\r\n";
			S = S + "                 Return" + "\r\n";
			S = S + "   IF TRIGGER_NESTLEVEL() > 1" + "\r\n";
			S = S + "                 Return" + "\r\n";
			S = S + "   UPDATE <XX>" + "\r\n";
			S = S + "   SET RowLastModDate = getdate(),  RowCreationDate = getdate(), [RepoSvrName] = @@SERVERNAME" + "\r\n";
			S = S + "   FROM <XX> t" + "\r\n";
			S = S + "   JOIN inserted i" + "\r\n";
			//S = S + "   ON t.ArchiveID = i.ArchiveID" + vbCrLf
			S = S + "   ON " + "\r\n";
			for (int i = 0; i <= Keys.Count - 1; i++)
			{
				if (i == 0)
				{
					S = S + "     t" + "." + Keys(i) + " = i." + Keys(i) + "\r\n";
				}
				else
				{
					S = S + "     and t" + "." + Keys(i) + " = i." + Keys(i) + "\r\n";
				}
			}
			S = S.Replace("<XX>", TblName.Trim());
			
			Clipboard.Clear();
			Clipboard.SetText(S);
			
			B = ExecuteSqlNewConn(S);
			if (! B)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: Failed to CREATE trigger - " + TriggerName));
			}
			
			return;
		}
		
		public void VerifyStandardTriggers()
		{
			
			List<string> Keys = new List<string>();
			string S = "";
			S = S + " select s.name as TABLE_SCHEMA, t.name as TABLE_NAME";
			S = S + " , k.name as CONSTRAINT_NAME, k.type_desc as CONSTRAINT_TYPE";
			S = S + " , c.name as COLUMN_NAME, ic.key_ordinal AS ORDINAL_POSITION";
			S = S + " from sys.key_constraints as k";
			S = S + " join sys.tables as t";
			S = S + " on t.object_id = k.parent_object_id";
			S = S + " join sys.schemas as s";
			S = S + " on s.schema_id = t.schema_id";
			S = S + " join sys.index_columns as ic";
			S = S + " on ic.object_id = t.object_id";
			S = S + " and ic.index_id = k.unique_index_id";
			S = S + " join sys.columns as c";
			S = S + " on c.object_id = t.object_id";
			S = S + " and c.column_id = ic.column_id";
			S = S + " order by TABLE_SCHEMA, TABLE_NAME, CONSTRAINT_NAME, ORDINAL_POSITION;";
			
			SqlDataReader RSData = null;
			
			string TABLE_NAME = "";
			string CONSTRAINT_NAME = "";
			string COLUMN_NAME = "";
			string CONSTRAINT_TYPE = "";
			
			string prevTABLE_NAME = "";
			string prevCONSTRAINT_NAME = "";
			string prevCOLUMN_NAME = "";
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			
			bool bFirstRow = true;
			
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					TABLE_NAME = RSData.GetValue(1).ToString();
					CONSTRAINT_NAME = RSData.GetValue(2).ToString();
					COLUMN_NAME = RSData.GetValue(4).ToString();
					//FrmMDIMain.SB4.Text = "Processing " + TABLE_NAME
					Application.DoEvents();
					if (TABLE_NAME.Equals(prevTABLE_NAME) && CONSTRAINT_NAME.Equals(prevCONSTRAINT_NAME))
					{
						if (prevTABLE_NAME.Length > 0)
						{
							Keys.Add(COLUMN_NAME);
						}
					}
					else
					{
						if (bFirstRow)
						{
							bFirstRow = false;
							Keys.Add(COLUMN_NAME);
						}
						else
						{
							AddStdTriggers(prevTABLE_NAME, Keys);
							System.Windows.Forms.Keys.Clear;
							Keys.Add(COLUMN_NAME);
						}
					}
					
					prevTABLE_NAME = TABLE_NAME;
					prevCONSTRAINT_NAME = CONSTRAINT_NAME;
					
				}
			}
			
			RSData.Close();
			RSData = null;
			//FrmMDIMain.SB4.Text = ""
			MessageBox.Show("Triggers validated!");
			
		}
		
		public int countGroupsUserBelongsTo(string TcbLibraryName, string UserID)
		{
			
			string S = "";
			TcbLibraryName = UTIL.RemoveSingleQuotes(TcbLibraryName);
			S = S + " select COUNT(*) from GroupLibraryAccess where UserID = \'" + UserID + "\'  and LibraryName = \'" + TcbLibraryName + "\'";
			int iCnt = iCount(S);
			return iCnt;
			
		}
		
		
		public void GetGroupLibraries(string GroupName, List<string> ListOfLibraries)
		{
			
			ListOfLibraries.Clear();
			string S = "";
			S = S + " SELECT     LibraryName from GroupLibraryAccess WHERE     GroupName = \'" + GroupName + "\' ";
			
			bool b = true;
			string LibraryName = "";
			
			//If UBound(TblCols, 2) > 2 Then
			//    Return
			//End If
			
			//ReDim TblCols (4, 0)
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					LibraryName = RSData.GetValue(0).ToString();
					ListOfLibraries.Add(LibraryName);
				}
			}
			RSData.Close();
			RSData = null;
			
		}
		
		public void ResetLibraryUsersCount()
		{
			
			bool b = true;
			string S = "update LibraryUsers set GroupCnt = 0 ";
			
			b = ExecuteSqlNewConn(S);
			if (! b)
			{
				LOG.WriteToArchiveLog("ERROR: failed to reset the LibraryUsers GroupCnt - aborting.");
				return;
			}
			
			S = "";
			S += " SELECT     GroupUsers.UserID, GroupLibraryAccess.LibraryName, GroupLibraryAccess.GroupName";
			S += " FROM         GroupLibraryAccess INNER JOIN";
			S += "                       GroupUsers ON GroupLibraryAccess.GroupName = GroupUsers.GroupName";
			S += " group by GroupUsers.UserID, LibraryName, GroupLibraryAccess.GroupName                      ";
			S += " order by GroupUsers.UserID, LibraryName, GroupName";
			
			string UserID = "";
			string LibraryName = "";
			string GroupName = "";
			
			SqlDataReader RSData = null;
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			int II = 0;
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					II++;
					if (II % 5 == 0)
					{
						//FrmMDIMain.SB4.Text = II.ToString
					}
					UserID = RSData.GetValue(0).ToString();
					LibraryName = RSData.GetValue(1).ToString();
					GroupName = RSData.GetValue(2).ToString();
					
					LibraryName = UTIL.RemoveSingleQuotes(LibraryName);
					GroupName = UTIL.RemoveSingleQuotes(GroupName);
					
					S = "update LibraryUsers set GroupCnt = GroupCnt + 1 where LibraryName = \'" + LibraryName + "\' and UserID = \'" + UserID + "\'";
					b = ExecuteSqlNewConn(S);
					if (! b)
					{
						LOG.WriteToArchiveLog("ERROR: Failed to udpate LibraryUsers GroupCnt for Library \'xx\' and user \'xx\'.");
					}
				}
			}
			RSData.Close();
			RSData = null;
			
			S = "select count(*) from LibraryUsers where (SingleUser is null or SingleUser = 0) and GroupCnt = 0 ";
			int iCnt = iCount(S);
			
			if (iCnt > 0)
			{
				S = "delete from LibraryUsers where (SingleUser is null or SingleUser = 0) and GroupCnt = 0 ";
				b = ExecuteSqlNewConn(S);
				if (! b)
				{
					LOG.WriteToArchiveLog((string) ("ERROR: Failed to delete NULL LibraryUsers." + "\r\n" + S));
				}
			}
			//FrmMDIMain.SB4.Text = "Complete."
		}
		
		public string getListOfContainingLibraries(string tGuid)
		{
			string S = "select LibraryName from LibraryItems where SourceGuid = \'" + tGuid + "\' ";
			string LibName = "";
			string ListOfLibs = "";
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					LibName = RSData.GetValue(0).ToString();
					ListOfLibs += LibName + "\r\n";
				}
			}
			else
			{
				ListOfLibs += "None";
			}
			RSData.Close();
			RSData = null;
			return ListOfLibs;
		}
		
		public void FixEmailFields()
		{
			
			string S = "";
			S = "";
			S = S + " select emailGuid, SenderEmailAddress,SentTO  ,AllRecipients ,SenderName ,ReceivedByName ,OriginalFolder, CC , BCC ";
			S = S + " from Email ";
			S = S + " where ";
			S = S + " SenderEmailAddress like \'%\'\'%\'";
			S = S + " or SentTO  like \'%\'\'%\'";
			S = S + " or AllRecipients like \'%\'\'%\'";
			S = S + " or SenderName like \'%\'\'%\'";
			S = S + " or ReceivedByName like \'%\'\'%\'";
			S = S + " or OriginalFolder like \'%\'\'%\' ";
			S = S + " or CC like \'%\'\'%\'";
			S = S + " or BCC like \'%\'\'%\'";
			
			bool b = true;
			int i = 0;
			int id = -1;
			int II = 0;
			
			string EmailGuid = "";
			string SenderEmailAddress = "";
			string SentTO = "";
			string AllRecipients = "";
			string SenderName = "";
			string ReceivedByName = "";
			string OriginalFolder = "";
			string CC = "";
			string BCC = "";
			
			if (Information.UBound(TblCols, 2) > 2)
			{
				return;
			}
			
			int iRec = 0;
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					Application.DoEvents();
					iRec++;
					if (iRec % 5 == 0)
					{
						//FrmMDIMain.SB4.Text = "** " + iRec.ToString
						Application.DoEvents();
					}
					EmailGuid = (string) (RSData.GetValue(0).ToString());
					SenderEmailAddress = (string) (RSData.GetValue(1).ToString());
					SentTO = (string) (RSData.GetValue(2).ToString());
					AllRecipients = (string) (RSData.GetValue(3).ToString());
					SenderName = (string) (RSData.GetValue(4).ToString());
					ReceivedByName = (string) (RSData.GetValue(5).ToString());
					OriginalFolder = (string) (RSData.GetValue(6).ToString());
					CC = (string) (RSData.GetValue(7).ToString());
					BCC = (string) (RSData.GetValue(8).ToString());
					
					UTIL.StripSingleQuotes(ref SenderEmailAddress);
					UTIL.StripSingleQuotes(ref SentTO);
					UTIL.StripSingleQuotes(ref AllRecipients);
					UTIL.StripSingleQuotes(ref SenderName);
					UTIL.StripSingleQuotes(ref ReceivedByName);
					UTIL.StripSingleQuotes(ref OriginalFolder);
					UTIL.StripSingleQuotes(ref CC);
					UTIL.StripSingleQuotes(ref BCC);
					
					string UpdateSql = "";
					UpdateSql = UpdateSql + " update Email set ";
					UpdateSql = UpdateSql + " SenderEmailAddress =\'" + SenderEmailAddress + "\',";
					UpdateSql = UpdateSql + "  SentTO =\'" + SentTO + "\',";
					UpdateSql = UpdateSql + "  AllRecipients =\'" + AllRecipients + "\',";
					UpdateSql = UpdateSql + "  SenderName =\'" + SenderName + "\',";
					UpdateSql = UpdateSql + "  ReceivedByName =\'" + ReceivedByName + "\',";
					UpdateSql = UpdateSql + "  OriginalFolder =\'" + OriginalFolder + "\',";
					UpdateSql = UpdateSql + "  CC =\'" + CC + "\',";
					UpdateSql = UpdateSql + "  BCC =\'" + BCC + "\' ";
					UpdateSql = UpdateSql + " where EmailGuid = \'" + EmailGuid + "\'";
					
					b = ExecuteSqlNewConn(UpdateSql);
					if (! b)
					{
						Console.WriteLine("ERROR: " + UpdateSql);
					}
					
				}
			}
			else
			{
				id = -1;
			}
			RSData.Close();
			RSData = null;
			//FrmMDIMain.SB4.Text = ""
			
			FixEmailRecipients();
			
		}
		
		public void FixEmailRecipients()
		{
			
			string Recipient = "";
			string S = "SELECT distinct [Recipient] FROM [Recipients] where [Recipient] like \'%\'\'%\'";
			List<string> L = new List<string>();
			
			bool b = true;
			int i = 0;
			int id = -1;
			int II = 0;
			
			string EmailGuid = "";
			
			if (Information.UBound(TblCols, 2) > 2)
			{
				return;
			}
			
			int iRec = 0;
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					Application.DoEvents();
					iRec++;
					if (iRec % 5 == 0)
					{
						//FrmMDIMain.SB4.Text = "** " + iRec.ToString
						Application.DoEvents();
					}
					Recipient = (string) (RSData.GetValue(0).ToString());
					
					if (! L.Contains(Recipient))
					{
						L.Add(Recipient);
					}
				}
			}
			else
			{
				id = -1;
			}
			RSData.Close();
			RSData = null;
			
			for (i = 0; i <= L.Count - 1; i++)
			{
				S = (string) (L.Item(i));
				S = UTIL.RemoveSingleQuotes(S);
				Recipient = (string) (L.Item(i));
				UTIL.StripSingleQuotes(ref Recipient);
				string UpdateSql = "";
				UpdateSql = UpdateSql + " update Recipients set ";
				UpdateSql = UpdateSql + " Recipient =\'" + Recipient + "\' ";
				UpdateSql = UpdateSql + " where Recipient = \'" + S + "\'";
				
				b = ExecuteSqlNewConn(UpdateSql);
				if (! b)
				{
					Console.WriteLine("ERROR: " + UpdateSql);
				}
			}
			
			//FrmMDIMain.SB4.Text = ""
		}
		
		public void RecordGrowth()
		{
			string S = "";
			S = S + " IF OBJECT_ID(\'DatabaseFiles\') IS NULL";
			S = S + " BEGIN";
			S = S + " SELECT TOP 0 * INTO DatabaseFiles";
			S = S + " FROM sys.database_files    ";
			S = S + " ";
			S = S + " ALTER TABLE DatabaseFiles";
			S = S + " ADD CreationDate DATETIME DEFAULT(GETDATE())";
			S = S + " End";
			bool b = ExecuteSqlNewConn(S);
			if (! b)
			{
				Console.WriteLine("ERROR: RecordGrowth = " + S);
			}
			
			S = S + " EXECUTE sp_msforeachdb \'INSERT INTO DatabaseFiles SELECT *, GETDATE() FROM [?].sys.database_files\'";
			b = ExecuteSqlNewConn(S);
			if (! b)
			{
				Console.WriteLine("ERROR: RecordGrowth = " + S);
			}
			
		}
		
		public void EmailHashRows()
		{
			
			string S = "";
			S = "";
			S = S + " select subject, CreationTime, SenderEmailAddress, nbrAttachments, SourceTypeCode ";
			S = S + " from Email where RecHash is NULL";
			
			string EmailGuid = "";
			string SenderEmailAddress = "";
			string subject = "";
			string body = "";
			string CreationTime = "";
			string nbrAttachments = "";
			string SourceTypeCode = "";
			string FileExt = "";
			string tHash = "";
			string tKey = "";
			
			int iCnt = 0;
			
			SortedList<string, string> L = new SortedList<string, string>();
			
			SqlDataReader RSData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			UTIL.setConnectionStringTimeout(ref CS, "10000");
			int JumpTo = 0;
			
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			
			bool ProcessData = false;
			
			if (RSData.HasRows && ProcessData == true)
			{
				while (RSData.Read())
				{
					iCnt++;
					Application.DoEvents();
					if (iCnt % 50 == 0)
					{
						//FrmMDIMain.SB4.Text = iCnt.ToString
						Application.DoEvents();
						//System.Threading.Thread.Sleep(250)
					}
					
					if (JumpTo > 0 && iCnt < JumpTo)
					{
						goto NextOne;
					}
					
					EmailGuid = (string) (RSData.GetValue(0).ToString());
					subject = (string) (RSData.GetValue(1).ToString());
					CreationTime = (string) (RSData.GetValue(2).ToString());
					SenderEmailAddress = (string) (RSData.GetValue(3).ToString());
					nbrAttachments = (string) (RSData.GetValue(4).ToString());
					SourceTypeCode = (string) (RSData.GetValue(5).ToString());
					
					tKey = subject + Strings.Chr(254) + CreationTime + Strings.Chr(254) + SenderEmailAddress + Strings.Chr(254) + nbrAttachments + Strings.Chr(254) + SourceTypeCode;
					tHash = KGEN.genEmailHashCode(subject, body, SenderEmailAddress, CreationTime, nbrAttachments, FileExt);
					
					LOG.WriteToEmailDuplicateLog("E", EmailGuid, tHash);
NextOne:
					1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
				}
			}
			else
			{
				RSData.Close();
				RSData = null;
				//FrmMDIMain.SB4.Text = ""
				return;
			}
			RSData.Close();
			RSData = null;
			//FrmMDIMain.SB4.Text = ""
			
			LOG.LoadEmailDupLog(L);
			EmailHashRowsApply(L, CS);
			
			//FrmMDIMain.SB4.Text = "Done."
			L = null;
			
			
		}
		
		
		public void EmailHashRowsApply(SortedList<string, string> L, string CS)
		{
			bool rc = false;
			SqlConnection CN = new SqlConnection(CS);
			CN.Open();
			SqlCommand dbCmd = CN.CreateCommand();
			bool BB = true;
			string EmailGuid = "";
			string tHash = "";
			int iCnt = 0;
			
			
			int SkipTo = 215035;
			
			string UpdateSql = "";
			bool B = true;
			for (int I = SkipTo; I <= L.Count - 1; I++)
			{
				Application.DoEvents();
				try
				{
					EmailGuid = L.Keys(I);
					tHash = L.Values(I);
					UpdateSql = "Update Email set RecHash = \'" + tHash + "\' where EmailGuid = \'" + EmailGuid + "\'";
					
					//B = ExecuteSqlNewConn(UpdateSql)
					try
					{
						B = true;
						dbCmd.CommandText = UpdateSql;
						dbCmd.ExecuteNonQuery();
					}
					catch (Exception ex)
					{
						Console.WriteLine(ex.Message);
						B = false;
					}
					
					//If I Mod 100 = 0 Then
					//    Try
					//        dbCmd.CommandText = "GO"
					//        dbCmd.ExecuteNonQuery()
					//    Catch ex As Exception
					//        Console.WriteLine("ERROR: EmailHashRows 200 - " + ex.Message)
					//    End Try
					
					//End If
					
					if (! B)
					{
						Console.WriteLine("ERROR: " + UpdateSql);
					}
					iCnt++;
					if (I % 10 == 0)
					{
						//FrmMDIMain.SB4.Text = "** " + I.ToString
						Application.DoEvents();
					}
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("ERROR 100 - EmailHashRowsApply: " + ex.Message + "\r\n" + UpdateSql));
					B = false;
				}
			}
			if (B == true)
			{
				L.Clear();
			}
			
			CN.Close();
			CN.Dispose();
		}
		
		public void ContentHashRows()
		{
			
			string S = "";
			S = "";
			S = S + " SELECT [SourceGuid],[VersionNbr], CreateDate,[SourceName],[OriginalFileType],[FileLength],[CRC] ";
			S = S + " FROM [DataSource] where RecHash is NULL";
			
			string SourceGuid = "";
			//Dim VersionNbr As String = ""
			string CreateDate = "";
			string SourceName = "";
			string OriginalFileType = "";
			string FileLength = "";
			string CRC = "";
			
			string tHash = "";
			string tKey = "";
			
			int iCnt = 0;
			
			SortedList<string, string> L = new SortedList<string, string>();
			
			SqlDataReader RSData = null;
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			UTIL.setConnectionStringTimeout(ref CS, "10000");
			int JumpTo = 0;
			
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			
			bool ProcessData = false;
			
			if (RSData.HasRows && ProcessData == true)
			{
				while (RSData.Read())
				{
					iCnt++;
					Application.DoEvents();
					if (iCnt % 50 == 0)
					{
						//FrmMDIMain.SB4.Text = iCnt.ToString
						Application.DoEvents();
						//System.Threading.Thread.Sleep(250)
					}
					
					if (JumpTo > 0 && iCnt < JumpTo)
					{
						goto NextOne;
					}
					
					SourceGuid = (string) (RSData.GetValue(0).ToString());
					//VersionNbr = RSData.GetValue(1).ToString()
					CreateDate = (string) (RSData.GetValue(2).ToString());
					SourceName = (string) (RSData.GetValue(3).ToString());
					OriginalFileType = (string) (RSData.GetValue(4).ToString());
					FileLength = (string) (RSData.GetValue(5).ToString());
					CRC = (string) (RSData.GetValue(6).ToString());
					
					tKey = CreateDate + Strings.Chr(254) + SourceName + Strings.Chr(254) + OriginalFileType + Strings.Chr(254) + FileLength + Strings.Chr(254) + CRC;
					tHash = KGEN.genHashContent(CreateDate, SourceName, OriginalFileType, FileLength, CRC);
					
					LOG.WriteToContentDuplicateLog("C", SourceGuid, tHash);
NextOne:
					1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
				}
			}
			else
			{
				RSData.Close();
				RSData = null;
				//FrmMDIMain.SB4.Text = ""
				return;
			}
			RSData.Close();
			RSData = null;
			//FrmMDIMain.SB4.Text = ""
			
			LOG.LoadContentDupLog(L);
			ContentHashRowsApply(L, CS);
			
			//FrmMDIMain.SB4.Text = "Done: Content Keyed"
			L = null;
			
		}
		
		public void ContentHashRowsApply(SortedList<string, string> L, string CS)
		{
			bool rc = false;
			SqlConnection CN = new SqlConnection(CS);
			CN.Open();
			SqlCommand dbCmd = CN.CreateCommand();
			bool BB = true;
			string SourceGuid = "";
			string tHash = "";
			int iCnt = 0;
			
			
			int SkipTo = 215035;
			
			string UpdateSql = "";
			bool B = true;
			for (int I = SkipTo; I <= L.Count - 1; I++)
			{
				Application.DoEvents();
				try
				{
					SourceGuid = L.Keys(I);
					tHash = L.Values(I);
					UpdateSql = "Update DataSource set RecHash = \'" + tHash + "\' where SourceGuid = \'" + SourceGuid + "\'";
					
					try
					{
						B = true;
						dbCmd.CommandText = UpdateSql;
						dbCmd.ExecuteNonQuery();
					}
					catch (Exception ex)
					{
						Console.WriteLine(ex.Message);
						B = false;
					}
					
					if (! B)
					{
						Console.WriteLine("ERROR: " + UpdateSql);
					}
					iCnt++;
					if (I % 10 == 0)
					{
						//FrmMDIMain.SB4.Text = "** " + I.ToString
						Application.DoEvents();
					}
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("ERROR 100 - EmailHashRowsApply: " + ex.Message + "\r\n" + UpdateSql));
					B = false;
				}
			}
			if (B == true)
			{
				L.Clear();
			}
			
			CN.Close();
			CN.Dispose();
		}
		
		public void ContentAddHash(string SourceGuid, string tHash, string MachineID)
		{
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CN = new SqlConnection(CS);
			CN.Open();
			SqlCommand dbCmd = CN.CreateCommand();
			bool BB = true;
			int iCnt = 0;
			//where FQN = '" + FQN + "' and DataSourceOwnerUserID = '" + UserID  + "'"
			string UpdateSql = "Update DataSource set RecHash = \'" + tHash + "\', MachineID = \'" + MachineID + "\' where SourceGuid = \'" + SourceGuid + "\'";
			
			bool B = true;
			try
			{
				B = true;
				dbCmd.CommandText = UpdateSql;
				dbCmd.ExecuteNonQuery();
				if (! B)
				{
					LOG.WriteToArchiveLog((string) ("ERROR: ContentHashRowsApply - 100 " + UpdateSql));
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: ContentHashRowsApply - 200 " + ex.Message + "\r\n" + UpdateSql));
				B = false;
			}
			
			CN.Close();
			CN.Dispose();
		}
		
		public void EmailAddHash(string EmailGuid, string EmailIdentifier)
		{
			
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CN = new SqlConnection(CS);
			CN.Open();
			SqlCommand dbCmd = CN.CreateCommand();
			bool BB = true;
			int iCnt = 0;
			
			EmailIdentifier = EmailIdentifier.Replace("\'", "\'\'");
			
			string UpdateSql = "Update Email set EmailIdentifier = \'" + EmailIdentifier + "\' where EmailGuid = \'" + EmailGuid + "\'";
			
			bool B = true;
			try
			{
				B = true;
				dbCmd.CommandText = UpdateSql;
				dbCmd.ExecuteNonQuery();
				if (! B)
				{
					LOG.WriteToArchiveLog((string) ("ERROR: EmailHashRowsApply - 100 " + UpdateSql));
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: EmailHashRowsApply - 200 " + ex.Message + "\r\n" + UpdateSql));
				B = false;
			}
			
			CN.Close();
			CN.Dispose();
		}
		
		public string genEmailHashCode(string subject, string body, string CreationTime, string SenderEmailAddress, string nbrAttachments, string SourceTypeCode)
		{
			
			string tHash = KGEN.genEmailHashCode(subject, body, SenderEmailAddress, CreationTime, nbrAttachments, SourceTypeCode);
			return tHash;
			
		}
		
		public void XXaddContentHashKey(string SourceGuid, string VersionNbr, string CreateDate, string SourceName, string OriginalFileType, string FileLength, string CRC, string MachineID)
		{
			
			string tHash = KGEN.genHashContent(CreateDate, SourceName, OriginalFileType, FileLength, CRC);
			ContentAddHash(SourceGuid, tHash, MachineID);
			
		}
		
		~clsDatabase()
		{
			KGEN = null;
			base.Finalize();
		}
		
		public void CleanUpEmailFolders()
		{
			
			string S = "";
			S = S + "         DELETE";
			S = S + "         FROM EmailFolder ";
			S = S + " WHERE nRowID NOT IN";
			S = S + " (";
			S = S + " Select Max(nRowID)";
			S = S + " FROM EmailFolder";
			S = S + " GROUP BY userid, folderid";
			S = S + " )";
			
			bool B = ExecuteSqlNewConn(S);
			
			S = "";
			S = S + " delete from EmailArchParms ";
			S = S + " where FolderName not in (select FolderName from EmailFolder)";
			
			B = ExecuteSqlNewConn(S);
			
		}
		
		public bool bFileNameExists(string SourceName)
		{
			bool B = true;
			int I = 0;
			string S = "";
			S = S + " SELECT count(*) from DataSource where SourceName = \'" + SourceName + "\'";
			I = iCount(S);
			if (I > 0)
			{
				B = true;
			}
			else
			{
				B = false;
			}
			return B;
		}
		
		public bool bIdenticalFile(string SourceName, string CRC, string CreateDate, string LastAccessDate, int FileLength)
		{
			
			bool B = true;
			
			B = bFileNameExists(SourceName);
			if (B == false)
			{
				//** the file does not exist.
				return B;
			}
			
			//** The file does exist, verify wherther it is a duplicate file or not
			
			return B;
		}
		
		
		
		public string getUserGuidByLoginID(string LoginID)
		{
			
			if (LoginID.Length == 0)
			{
				return "";
			}
			
			string S = "SELECT [UserID] FROM [Users] where [UserLoginID] = \'" + LoginID + "\'";
			string UGuid = "";
			int cnt = 0;
			SqlDataReader rsCnt = null;
			
			try
			{
				rsCnt = SqlQryNewConn(S);
				if (rsCnt.HasRows)
				{
					while (rsCnt.Read())
					{
						UGuid = rsCnt.GetValue(0).ToString();
					}
				}
			}
			catch (Exception ex)
			{
				UGuid = "";
				LOG.WriteToArchiveLog((string) ("getUserGuidByLoginID : 5406 : " + ex.Message));
			}
			finally
			{
				if (rsCnt != null)
				{
					if (! rsCnt.IsClosed)
					{
						rsCnt.Close();
					}
					rsCnt = null;
				}
			}
			
			return UGuid;
		}
		
		public void AppendOcrTextEmail(string SourceGuid, string OCR_Text)
		{
			
			string OcrText = OCR_Text;
			string S = "";
			bool b = false;
			
			string EmailBody = GetEmailBody(SourceGuid);
			
			EmailBody = EmailBody + " " + OCR_Text;
			
			EmailBody = EmailBody.Replace("\'\'", "\'");
			EmailBody = EmailBody.Replace("\'", "\'\'");
			
			S = "update EMAIL set Body = \'" + EmailBody + "\' where EmailGuid = \'" + SourceGuid + "\'";
			
			b = ExecuteSqlNewConn(S);
			if (! b)
			{
				if (dDebug)
				{
					Debug.Print("Failed to set OCR Attributes");
				}
			}
		}
		public void AppendOcrTextEmail(string SourceGuid)
		{
			
			string OcrText = "";
			string S = "";
			bool b = false;
			
			//Dim S  = "update DataSource set GraphicContainsText = 'Y' where SourceGuid = '" + SourceGuid + "'"
			//Dim b As Boolean = ExecuteSqlNewConn(S, False)
			//If Not b Then
			//    If dDeBug Then Debug.Print("Failed to set OCR Attributes")
			//End If
			
			string EmailBody = GetEmailBody(SourceGuid);
			
			OcrText = GetAllOcrData(SourceGuid);
			OcrText = UTIL.ReplaceSingleQuotesV1(OcrText);
			
			EmailBody = UTIL.ReplaceSingleQuotesV1(EmailBody);
			EmailBody = EmailBody + OcrText;
			//CleanText(EmailBody)
			
			
			S = "update EMAIL set BODY = \'" + EmailBody + "\' where EmailGuid = \'" + SourceGuid + "\'";
			//System.Windows.Forms.Clipboard.Clear()
			//System.Windows.Forms.Clipboard.SetText(S)
			
			b = ExecuteSqlNewConn(S);
			if (! b)
			{
				if (dDebug)
				{
					Debug.Print("Failed to set OCR Attributes");
				}
			}
		}
		
		private string GetAllOcrData(string EmailGuid)
		{
			string S = "select OcrText from emailattachment where EmailGuid = \'" + EmailGuid + "\'";
			string AllText = "";
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection Conn = new SqlConnection(ConnStr);
			if (Conn.State == ConnectionState.Closed)
			{
				Conn.Open();
			}
			
			SqlDataReader rsData = null;
			rsData = SqlQryNewConn(S);
			
			if (rsData.HasRows)
			{
				while (rsData.Read())
				{
					AllText = AllText + rsData.GetValue(0).ToString() + Strings.Chr(254);
				}
			}
			
			return AllText;
			
		}
		
		public int cnt_UniqueEntry(string LibraryName, string SourceGuid)
		{
			
			LibraryName = UTIL.RemoveSingleQuotes(LibraryName);
			
			int B = 0;
			string TBL = "LibraryItems";
			string WC = "Where LibraryName = \'" + LibraryName + "\' and SourceGuid = \'" + SourceGuid + "\' ";
			
			
			B = iGetRowCount(TBL, WC);
			
			
			return B;
		} //** cnt_UK_LibItems
		
		public void SetEmailOcrText(string Body, string EmailGuid, string OcrText, string AttachmentName)
		{
			
			AttachmentName = AttachmentName.Replace("\'", "\'\'");
			
			OcrText = UTIL.BlankOutSingleQuotes(OcrText);
			
			string S = "update EmailAttachment set OcrText = \'" + OcrText + "\' where EmailGuid = \'" + EmailGuid + "\' and AttachmentName = \'" + AttachmentName + "\'";
			
			bool b = ExecuteSqlNewConn(S, false);
			if (! b)
			{
				LOG.WriteToArchiveLog("ERROR: 100 Failed to set Email OCR Attributes");
			}
			
		}
		
		public bool addDocSourceError(string SourceType, string SourceGuid, string Notes)
		{
			Notes = UTIL.RemoveSingleQuotes(Notes);
			string mySql = "";
			if (SourceType.ToUpper().Equals("CONTENT"))
			{
				mySql = "UPDATE [DataSource] set Notes = \'" + Notes + "\' where SourceGuid = \'" + SourceGuid + "\'";
			}
			else
			{
				mySql = "UPDATE Email set Notes = \'" + Notes + "\' where EmailGuid = \'" + SourceGuid + "\'";
			}
			bool b = ExecuteSqlNewConn(mySql, false);
			return b;
		}
		
		public bool AddLibraryItem(string SourceGuid, string ItemTitle, string FileExt, string LibraryName)
		{
			
			ItemTitle = UTIL.RemoveSingleQuotes(ItemTitle);
			LibraryName = UTIL.RemoveSingleQuotes(LibraryName);
			
			string LibraryOwnerUserID = modGlobals.gCurrUserGuidID;
			string DataSourceOwnerUserID = modGlobals.gCurrUserGuidID;
			string LibraryItemGuid = Guid.NewGuid().ToString();
			string AddedByUserGuidId = modGlobals.gCurrUserGuidID;
			
			string SS = "Select count(*) from LibraryItems where LibraryName = \'" + LibraryName + "\' and SourceGuid = \'" + SourceGuid + "\'";
			int iCnt = iCount(SS);
			if (iCnt > 0)
			{
				return true;
			}
			
			bool b = false;
			string s = "";
			s = s + " INSERT INTO LibraryItems(";
			s = s + "SourceGuid,";
			s = s + "ItemTitle,";
			s = s + "ItemType,";
			s = s + "LibraryItemGuid,";
			s = s + "DataSourceOwnerUserID,";
			s = s + "LibraryOwnerUserID,";
			s = s + "LibraryName,";
			s = s + "AddedByUserGuidId) values (";
			s = s + "\'" + SourceGuid + "\'" + ",";
			s = s + "\'" + ItemTitle + "\'" + ",";
			s = s + "\'" + FileExt + "\'" + ",";
			s = s + "\'" + LibraryItemGuid + "\'" + ",";
			s = s + "\'" + DataSourceOwnerUserID + "\'" + ",";
			s = s + "\'" + LibraryOwnerUserID + "\'" + ",";
			s = s + "\'" + LibraryName + "\'" + ",";
			s = s + "\'" + AddedByUserGuidId + "\'" + ")";
			
			System.Windows.Forms.Application.DoEvents();
			
			bool BB = ExecuteSqlNewConn(s, false);
			
			if (BB == false)
			{
				LOG.WriteToArchiveLog("ERROR: AddLibraryItem 100 - Failed to add \'" + ItemTitle + "\' to library \'" + LibraryName + "\'.");
			}
			else
			{
				if (dDebug)
				{
					LOG.WriteToArchiveLog("NOTICE : AddLibraryItem :\'" + ItemTitle + "\' to library \'" + LibraryName + "\'.");
				}
			}
			
			return BB;
			
		}
		
		public void AddExcgKey(string ExcgKey)
		{
			string S = "INSERT INTO [ExcgKey] ([MailKey]) VALUES (\'" + ExcgKey.ToString() + "\')";
			bool B = ExecuteSqlNewConn(S);
		}
		
		public bool DeleteDirectory(string dirPath)
		{
			
			DirectoryInfo objDI = new DirectoryInfo(dirPath);
			try
			{
				objDI.Delete(true);
				return true;
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
				return false;
			}
		}
		
		public void CreateDir(string dirPath)
		{
			try
			{
				Directory D;
				if (D.Exists(dirPath))
				{
				}
				else
				{
					D.CreateDirectory(dirPath);
				}
				D = null;
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
			}
			
		}
		
		//    Public Sub PDFXTRACT(ByVal SourceGuid , ByVal FQN , ByVal SourceType As String)
		
		//        Dim currDir As String = DMA.GetFilePath(FQN)
		
		//        Dim RetentionCode As String = "Retain 10"
		//        Dim ispublic As String = "N"
		
		//        If gPdfExtended = False Then
		//            Return
		//        End If
		//        Dim xDate As Date = #8/31/2010#
		
		//        Dim PdfImages As New List(Of String)
		//        '**WDM Dim PDF As New clsPdfAnalyzer
		//        Dim B As Boolean = False
		
		//        Try
		//            Dim FileExt  = DMA.getFileExtension(FQN)
		//            If FileExt.ToUpper.Equals(".PDF") Then
		
		//                Dim S  = ""
		//                If SourceType.ToUpper.Equals("CONTEXT") Then
		//                    S  = "Update DataSource set OcrText = '' where SourceGuid = '" + SourceGuid  + "' "
		//                Else
		//                    S  = "Update EmailAttachment set OcrText = '' where EmailGuid = '" + SourceGuid  + "' "
		//                End If
		
		//                B = ExecuteSqlNewConn(S)
		
		//                Dim iCnt As Integer = PDF.ExtractImages(SourceGuid , FQN , PdfImages)
		
		//                If iCnt > 0 Then
		//                    Try
		//                        frmExchangeMonitor.lblMessageInfo.Text = FQN
		//                        frmExchangeMonitor.lblMessageInfo.Refresh()
		//                        System.Windows.Forms.Application.DoEvents()
		//                        Dim tFqn As String = ""
		//                        For II As Integer = 0 To PdfImages.Count - 1
		
		//                            Dim Sha1Hash As String = ENC.getSha1HashFromFile(tFqn)
		
		//                            frmExchangeMonitor.lblMessageInfo.Text = II.ToString + " of " + PdfImages.Count.ToString + " PDF Images."
		//                            frmExchangeMonitor.lblMessageInfo.Refresh()
		//                            System.Windows.Forms.Application.DoEvents()
		
		//                            tFqn  = PdfImages(II)
		//                            Dim AttachmentName As String = DMA.getFileName(tFqn )
		//                            'DOES THE FILE EXIST HERE
		//                            If SourceType.Equals("CONTENT") Then
		//                            Else
		//                                Dim AttachmentExists As Integer = iCount("select count(*) from EmailAttachment where EmailGuid = '" + SourceGuid  + "' and AttachmentName = '" + AttachmentName + "' ")
		//                                If AttachmentExists = 0 Then
		//                                    Dim BB As Boolean = InsertAttachmentFqn(gCurrUserGuidID, tFqn , SourceGuid , AttachmentName , FileExt , gCurrUserGuidID, RetentionCode, Sha1Hash, ispublic, currDir)
		//                                    If BB = False Then
		//                                        GoTo SKIPX01
		//                                    End If
		//                                End If
		//                            End If
		
		//                            System.Threading.Thread.Sleep(100)
		//SKIPX01:
		//                        Next
		
		//                    Catch ex As Exception
		//                        LOG.WriteToArchiveLog("ERROR PDFXTRACT 100 - " + FQN + vbCrLf + ex.Message)
		//                    End Try
		//                End If
		
		//                Dim PdfContent As String = PDF.ExtractText(FQN )
		
		//                If PdfContent.Trim.Length > 0 Then
		//                    AppendOcrText(SourceGuid , PdfContent)
		//                End If
		
		//            End If
		//        Catch ex As Exception
		//            LOG.WriteToArchiveLog("ERROR: PDFXTRACT 100 - " + ex.Message + vbCrLf + FQN)
		//        Finally
		//            PDF = Nothing
		//            PdfImages = Nothing
		//            GC.Collect()
		//        End Try
		
		//        System.Windows.Forms.Application.DoEvents()
		
		//    End Sub
		
		public void LoadExckKeys(SortedList<string, string> L)
		{
			string SS = "select count(*) from [ExcgKey]";
			int iKeyCnt = iCount(SS);
			
			if (iKeyCnt == 0)
			{
				return;
			}
			else
			{
				frmMain.Default.PB1.Maximum = iKeyCnt + 5;
			}
			frmMain.Default.PB1.Value = 0;
			
			string S = "select distinct(mailkey) from [ExcgKey]";
			L.Clear();
			string mailkey = "";
			
			int cnt = 0;
			CloseConn();
			CkConn();
			string ConnStr = getGateWayConnStr(modGlobals.gGateWayID);
			try
			{
				using (gConn)
				{
					SqlCommand command = new SqlCommand(S, gConn);
					SqlDataReader rsCnt = null;
					rsCnt = SqlQry(S, gConn);
					if (rsCnt.HasRows)
					{
						while (rsCnt.Read())
						{
							cnt++;
							frmMain.Default.PB1.Value = cnt;
							mailkey = rsCnt.GetValue(0).ToString();
							if (L.IndexOfKey(mailkey) < 0)
							{
								try
								{
									L.Add(mailkey, mailkey);
								}
								catch (System.Exception ex2)
								{
									Console.WriteLine(ex2.Message);
								}
							}
						}
					}
					
					rsCnt.Close();
					rsCnt = null;
					command.Connection.Close();
					command = null;
				}
				
			}
			catch (System.Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDatabase : LoadExckKeys : 100 : " + ex.Message));
			}
			finally
			{
				frmMain.Default.PB1.Value = 0;
			}
			CloseConn();
		}
		
		// ''' <summary>
		// ''' This is not HOOKED into the system yet (3/20/11). It's purpose will be to speed up the
		// ''' search and loading of emails by 100 fold.
		// ''' </summary>
		// ''' <param name="L">A sorted list of strings/strings</param>
		// ''' <param name="CurrUserID">The user ID currently executing the archive.</param>
		// ''' <remarks></remarks>
		//Function LoadOutlookKeys(ByRef L As SortedList(Of String, String), ByVal CurrUserID As String) As Boolean
		
		//    Dim Limit As Integer = 1000000
		//    Dim B As Boolean = True
		//    Dim SS As String = "select COUNT(*) from Email where UserID = '" + CurrUserID + "'"
		//    Dim iKeyCnt As Integer = iCount(SS)
		
		//    If iKeyCnt = 0 Or iKeyCnt > Limit Then
		//        Return False
		//    Else
		//        frmReconMain.SB.Text = "Loading " + iKeyCnt.ToString + "Outlook keys, standby."
		//        frmReconMain.PB1.Maximum = iKeyCnt + 5
		//    End If
		//    frmReconMain.PB1.Value = 0
		
		//    Dim S As String = "select distinct(EntryID) from Email where UserID = '" + CurrUserID + "'"
		//    L.Clear()
		//    Dim mailkey As String = ""
		
		//    Dim cnt As Integer = 0
		//    CloseConn()
		//    CkConn()
		//    Dim ConnStr As String = getGateWayConnStr(gGateWayID)
		//    Try
		//        Using gConn
		//            Dim command As New SqlCommand(S, gConn)
		//            Dim rsCnt As SqlDataReader = Nothing
		//            rsCnt = SqlQry(S, gConn)
		//            If rsCnt.HasRows Then
		//                Do While rsCnt.Read
		//                    cnt += 1
		//                    frmReconMain.PB1.Value = cnt
		//                    mailkey = rsCnt.GetValue(0).ToString
		//                    If L.IndexOfKey(mailkey) < 0 Then
		//                        Try
		//                            L.Add(mailkey, cnt.ToString)
		//                        Catch ex2 As System.Exception
		//                            Console.WriteLine(ex2.Message)
		//                        End Try
		//                    End If
		//                Loop
		//            End If
		
		//            rsCnt.Close()
		//            rsCnt = Nothing
		//            command.Connection.Close()
		//            command = Nothing
		//        End Using
		//    Catch ex As System.Exception
		//        log.WriteToArchiveLog("clsDatabase : LoadExckKeys : 100 : " + ex.Message)
		//        B = False
		//    Finally
		//        frmReconMain.PB1.Value = 0
		//    End Try
		//    CloseConn()
		//    Return B
		//End Function
		
		/// <summary>
		/// This is not HOOKED into the system yet (3/20/11). It's purpose will be to speed up the search for existing
		/// outlook emails but will not be as fast as if the function "LoadOutlookKeys" is used, but has unlimited size
		/// as one record at a time is searched.
		/// </summary>
		/// <param name="EntryID"></param>
		/// <param name="CurrUserID"></param>
		/// <returns></returns>
		/// <remarks></remarks>
		public bool ckEntryIdExists(string EntryID, string CurrUserID)
		{
			string SS = "select COUNT(*) from Email where UserID = \'" + CurrUserID + "\'";
			int iKeyCnt = iCount(SS);
			if (iKeyCnt > 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public void AddSourceTypeCode(string SourceTypeCode, int bStoreExternal, string SourceTypeDesc, int bIndexable)
		{
			
			if (SourceTypeCode.IndexOf(".") + 1 == 0)
			{
				SourceTypeCode = (string) ("." + SourceTypeCode);
			}
			SourceTypeDesc = SourceTypeDesc.Replace("\'", "`");
			
			bool b = false;
			string s = "";
			s = s + " IF not Exists (Select SourceTypeCode from SourceType where SourceTypeCode = \'" + SourceTypeCode + "\') " + "\r\n";
			s = s + " INSERT INTO SourceType(" + "\r\n";
			s = s + "SourceTypeCode," + "\r\n";
			s = s + "StoreExternal," + "\r\n";
			s = s + "SourceTypeDesc," + "\r\n";
			s = s + "Indexable) values (" + "\r\n";
			s = s + "\'" + SourceTypeCode + "\'" + "," + "\r\n";
			s = s + bStoreExternal.ToString() + ("," + "\r\n");
			s = s + "\'" + SourceTypeDesc + "\'" + "," + "\r\n";
			s = s + bIndexable.ToString() + (")" + "\r\n");
			
			b = ExecuteSqlNewConn(s, false);
			if (! b)
			{
				LOG.WriteToArchiveLog((string) ("clsSOURCETYPE : Insert : 01 : " + "ERROR: An unknown file type was NOT inserted. The SQL is: " + s));
				LOG.WriteToArchiveLog((string) ("clsSOURCETYPE : Insert : 01 : " + "ERROR: An unknown file type was NOT inserted. The SQL is: " + s));
			}
		}
		
		public void LoadProfiles()
		{
			string S = "";
			bool B = false;
			//*********************************************************************************
			S = " INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Graphics Files\', N\'Known graphic file types.\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'All MS Office content.\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - C#\', N\'Source Code - C#\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfile] ([ProfileName], [ProfileDesc], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'Source Code - VB\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB752 AS DateTime), CAST(0x00009D8B00CBB752 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			//*********************************************************************************
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.xlsx\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.xls\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.pdf\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.html\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.htm\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.docx\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.doc\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Graphics Files\', N\'.Tiff\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Graphics Files\', N\'.tif\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Graphics Files\', N\'.gif\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.docm\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.dotx\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.dotm\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.xlsm\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.xltx\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.xltm\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.xlsb\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.xlam\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.pptx\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.PDF\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.TXT\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.pptm\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.potx\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.potm\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.ppam\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.ppsx\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Office Documents\', N\'.ppsm\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Graphics Files\', N\'.bmp\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Graphics Files\', N\'.png\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.vb\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.xsd\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.xss\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.xsc\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.ico\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.rpt\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.rdlc\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.resx\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.sql\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.xml\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.sln\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Source Code - VB\', N\'.vbx\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			S = " INSERT [dbo].[LoadProfileItem] ([ProfileName], [SourceTypeCode], [HiveConnectionName], [HiveActive], [RepoSvrName], [RowCreationDate], [RowLastModDate]) VALUES (N\'Graphics Files\', N\'.jpg\', NULL, 0, N\'DELLT100\\ECMLIB\', CAST(0x00009D8B00CBB786 AS DateTime), CAST(0x00009D8B00CBB786 AS DateTime))";
			B = ExecuteSqlNewConn(S);
			
		}
		
		public void LoadFileTypeDictionary(Dictionary<string, int> DICT)
		{
			DICT.Clear();
			string S = "Select distinct SourceTypeCode from SourceType";
			string TgtVal;
			SqlDataReader RSData = null;
			int iKey = 0;
			//RSData = SqlQryNo'Session(S)
			string CS = getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					iKey++;
					TgtVal = RSData.GetValue(0).ToString();
					DICT.Add(TgtVal, iKey);
				}
			}
			RSData.Close();
			RSData = null;
			CONN.Dispose();
			GC.Collect();
		}
		
		public bool UpdateSourceImageCompressed(int ID, string UID, string UploadFQN, string SourceGuid, string LastAccessDate, string CreateDate, string LastWriteTime, int VersionNbr, byte[] CompressedImageBinary, string MachineID, string RetStr, int OriginalSize, int CompressedSize, bool RC, string rMsg, DateTime TransmissionStartTime, DateTime txEndTime)
		{
			
			DateTime TxStartTime = DateTime.Now;
			bool B = false;
			//Dim Proxy As New SVCCLCArchive.Service1Client
			B = System.Convert.ToBoolean(Proxy.UpdateSourceImageCompressed(modGlobals.gGateWayID, ID, UID, UploadFQN, SourceGuid, LastAccessDate, CreateDate, LastWriteTime, VersionNbr, CompressedImageBinary, MachineID, RetStr, OriginalSize, CompressedSize, RC, rMsg, TransmissionStartTime, txEndTime));
			//proxy = Nothing
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			Console.WriteLine("TX Time: " + TC.ElapsedTimeInMS(TxStartTime, txEndTime));
			return B;
			
		}
		public string getZipPassword()
		{
			string S = "";
			S += "X";
			S += "@";
			S += "v";
			S += "1";
			S += "3";
			S += "r";
			return S;
		}
		
		public void UploadFileImage(string OriginalFileName, string FileGuid, string FQN, string RepositoryTable, string RetentionCode, string isPublic, string CrcHASH)
		{
			
			
			//** Check for a SingleSource upload here. If there exists a file with the same name and the same CRC, then just add it to the ContentUser table.
			
			if (bTrackUploads)
			{
				LOG.WriteToArchiveLog((string) ("UploadFileImage: File - start " + DateTime.Now.ToString() + FQN));
			}
			
			long OriginalSize = 0;
			long CompressedSize = 0;
			DateTime StartTime = DateTime.Now;
			DateTime CompressStartTime = DateTime.Now;
			DateTime CompressEndTime = DateTime.Now;
			string TransmissionType = "";
			
			long totalCompressSecs = 0;
			long totalTransmitSecs = 0;
			
			TimeSpan ElapsedTime;
			TimeSpan ElapsedZipTime;
			
			bool RC = true;
			if (! File.Exists(FQN))
			{
				return;
			}
			
			FileInfo FIOriginal = new FileInfo(FQN);
			OriginalSize = FIOriginal.Length;
			string oFileName = FIOriginal.Name;
			FIOriginal = null;
			
			string tPath = LOG.getTempEnvironDir();
			string TransferFileName = FileGuid + ".NotReady";
			
			TransferFileName = tPath + "\\" + TransferFileName;
			
			//******************************************
			CompressStartTime = DateTime.Now;
			//Dim myZip As New C1.C1Zip.C1ZipFile
			//'myZip.Password = getZipPassword()
			//myZip.Create(TransferFileName)
			//myZip.Entries.Add(FQN)
			
			using (ZipFile myZip = new ZipFile())
			{
				myZip.AddFile(FQN);
				myZip.Save(TransferFileName);
			}
			
			
			long ZipFileLength = 0;
			FileInfo FITemp = new FileInfo(TransferFileName);
			ZipFileLength = FITemp.Length;
			FITemp = null;
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			
			CompressEndTime = DateTime.Now;
			//******************************************
			
			byte[] FileBuffer;
			
			System.IO.FileInfo oFile;
			oFile = new System.IO.FileInfo(TransferFileName);
			
			System.IO.FileStream oFileStream = oFile.OpenRead();
			long lBytes = oFileStream.Length;
			
			if (lBytes > 0)
			{
				FileBuffer = new byte[(int) (lBytes - 1) + 1];
				oFileStream.Read(FileBuffer, 0, (int) lBytes);
				oFileStream.Close();
			}
			
			FileInfo FI = new FileInfo(TransferFileName);
			long FLength = FI.Length;
			CompressedSize = FLength;
			FI = null;
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			long MaxMeg = 25000000;
			long MaxGig = 2000000000;
			
			FI = null;
			try
			{
				if (RepositoryTable.ToUpper().Equals("EMAILATTACHMENT"))
				{
					TransmissionType = "Buffered";
					UploadBuffered(1, FileBuffer, OriginalFileName, FileGuid, TransferFileName, RepositoryTable, RetentionCode, isPublic, CrcHASH);
				}
				else if (RepositoryTable.ToUpper().Equals("EMAIL"))
				{
					TransmissionType = "Buffered";
					UploadBuffered(2, FileBuffer, OriginalFileName, FileGuid, TransferFileName, RepositoryTable, RetentionCode, isPublic, CrcHASH);
				}
				else if (FLength > 0 && FLength <= MaxMeg)
				{
					//** This is a small file and can be loaded quite well with a BUFFERED load
					TransmissionType = "Buffered";
					UploadBuffered(3, FileBuffer, OriginalFileName, FileGuid, TransferFileName, RepositoryTable, RetentionCode, isPublic, CrcHASH);
				}
				else if (FLength > MaxMeg && FLength < MaxGig)
				{
					//** This is a Large file and can be loaded much better with a Streamed load
					TransmissionType = "File Stream";
					UploadFileStream(OriginalFileName, FileGuid, TransferFileName, RepositoryTable, CrcHASH);
				}
				else
				{
					//** This is a Stupidly largr file to upload - better with a chunk load.
					TransmissionType = "Chunked";
					ChunkFileUpload(OriginalFileName, FileGuid, TransferFileName, RepositoryTable, CrcHASH);
				}
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: UploadFileStrem - " + ex.Message));
				RC = false;
			}
			finally
			{
				RC = true;
				//ISO.saveIsoFile(" FilesToDelete.dat", TransferFileName + "|")
				//File.Delete(TransferFileName)
			}
			
			ElapsedTime = DateTime.Now.Subtract(StartTime);
			totalTransmitSecs = (int) ElapsedTime.TotalMilliseconds;
			
			ElapsedZipTime = CompressEndTime.Subtract(CompressStartTime);
			totalCompressSecs = ElapsedZipTime.Milliseconds;
			
			string Msg = "";
			if (RC)
			{
				Msg = "Successful Upload: " + TransmissionType + "\r\n";
				Msg += "   Original Size: " + OriginalSize.ToString() + "\r\n";
				Msg += "   Compressed Size: " + CompressedSize.ToString() + "\r\n";
				Msg += "   Compress Time: " + (totalCompressSecs / 1000).ToString() + " sec" + "\r\n";
				Msg += "   Transmit Time: " + (totalTransmitSecs / 1000).ToString() + " sec" + "\r\n";
				Msg += "   BPS: " + (CompressedSize / (totalTransmitSecs / 100)).ToString() + "\r\n";
				Msg += "   File: " + FQN + "\r\n";
				LOG.WriteToArchiveLog(Msg);
				Console.WriteLine(Msg);
			}
			else
			{
				Msg = "Failed Upload: " + TransmissionType + "\r\n";
				Msg += "   Original Size: " + OriginalSize.ToString() + "\r\n";
				Msg += "   Compressed Size: " + CompressedSize.ToString() + "\r\n";
				Msg += "   Compress Time: " + (totalCompressSecs / 1000).ToString() + " sec" + "\r\n";
				Msg += "   Transmit Time: " + (totalTransmitSecs / 1000).ToString() + " sec" + "\r\n";
				Msg += "   BPS: " + (CompressedSize / (totalTransmitSecs / 1000)).ToString() + "\r\n";
				Msg += "   File: " + FQN + "\r\n";
				LOG.WriteToArchiveLog(Msg);
				Console.WriteLine(Msg);
			}
			
			decimal BPS = CompressedSize / (totalTransmitSecs / 1000);
			decimal TxTotalTime = System.Convert.ToDecimal((totalCompressSecs / 1000) + (totalTransmitSecs / 1000));
			
			//** Mark the file as successfully uploaded here and capture the stats
			string AttachmentName = oFileName;
			Proxy.SaveUploadStats(modGlobals.gGateWayID, RepositoryTable, FileGuid, (int) OriginalSize, (int) CompressedSize, StartTime, DateTime.Now, TxTotalTime, BPS, AttachmentName);
			
			if (bTrackUploads)
			{
				LOG.WriteToArchiveLog((string) ("UploadFileImage: File - start " + DateTime.Now.ToString() + FQN + " : Size - " + CompressedSize.ToString()));
			}
			
		}
		
		public void UploadBuffered(int LocID, byte[] CompressedBuffer, string OriginalFileName, string FileGuid, string FQN, string RepositoryTable, string RetentionCode, string isPublic, string Sha1HASH)
		{
			
			if (bTrackUploads)
			{
				LOG.WriteToArchiveLog((string) ("UploadBuffered: File - start " + DateTime.Now.ToString() + FQN));
			}
			int LL = 0;
			FileInfo FI = new FileInfo(FQN);
			string SourceName = FI.Name;
			string SourceTypeCode = FI.Extension;
			string sLastAccessDate = FI.LastAccessTime.ToString();
			string sCreateDate = FI.CreationTime.ToString();
			string sLastWriteTime = FI.LastAccessTime.ToString();
			int OriginalSize = (int) FI.Length;
			int CompressedSize = (int) FI.Length;
			bool RC = true;
			string RMsg = "";
			DateTime TxStartDate = DateTime.Now;
			DateTime TxEndDate = DateTime.Now;
			int VersionNbr = 1;
			//Dim CompressedBuffer As Byte() = Nothing
			FI = null;
			
			//** Used only in testing
			bool bTesting = false;
			if (bTesting)
			{
				try
				{
					Proxy.InsertSourcefile(modGlobals.gGateWayID, 22011, modGlobals.gCurrUserGuidID, modGlobals.gMachineID, FileGuid, FQN, SourceName, SourceTypeCode, sLastAccessDate, sCreateDate, sLastWriteTime, modGlobals.gCurrUserGuidID, VersionNbr, CompressedBuffer, OriginalSize, CompressedSize, RC, RMsg, TxStartDate, TxEndDate, RetentionCode, isPublic);
					
				}
				catch (Exception ex)
				{
					MessageBox.Show(ex.Message);
					return;
				}
			}
			
			//Dim Sha1HASH As String = ""
			long Ticks = 0;
			long TotalTicks = 0;
			DateTime EndTime = DateTime.Now;
			
			if (! File.Exists(FQN))
			{
				return;
			}
			
			Ticks = DateTime.Now.Ticks;
			//Sha1HASH = ENC.getSha1HashFromFile(FQN)
			TotalTicks = DateTime.Now.Ticks - Ticks;
			
			long Filength = 0;
			string FIName = "";
			
			FileInfo FI2 = new FileInfo(FQN);
			
			Filength = FI2.Length;
			FIName = FI2.Name;
			
			FI2 = null;
			
			// Open a file that is to be loaded into a byte array
			System.IO.FileInfo oFile;
			LL = 1;
			oFile = new System.IO.FileInfo(FQN);
			
			System.IO.FileStream oFileStream = oFile.OpenRead();
			long lBytes = oFileStream.Length;
			byte[] fileData = new byte[(int) (lBytes - 1) + 1];
			LL = 10;
			
			if (lBytes > 0)
			{
				LL = 11;
				// Read the file into a byte array
				oFileStream.Read(fileData, 0, (int) lBytes);
				LL = 12;
				oFileStream.Close();
				LL = 13;
			}
			
			oFileStream.Close();
			LL = 14;
			oFileStream.Dispose();
			LL = 15;
			oFile = null;
			LL = 16;
			
			DateTime StartTime = DateTime.Now;
			LL = 20;
			System.Net.ServicePointManager.DefaultConnectionLimit = 200;
			//Dim fStream As New System.IO.FileStream(FQN, FileMode.Open)
			//WDMXXXX
			try
			{
				LL = 30;
				GC.Collect();
				GC.WaitForPendingFinalizers();
				LL = 31;
				if (Proxy == null)
				{
					LL = 32;
					Application.DoEvents();
					SVCCLCArchive.Service1Client Proxy = new SVCCLCArchive.Service1Client();
					if (Proxy == null)
					{
						MessageBox.Show("Proxy is STILL nothing");
					}
					LL = 33;
					string Errmsg = (string) (Proxy.UploadBufferedCreate(modGlobals.gGateWayID, 1, modGlobals.gCurrUserGuidID, FileGuid, fileData.Length, Sha1HASH, Filength, FIName, RepositoryTable, true, OriginalFileName, fileData));
					LL = 34;
					if (Errmsg.Length > 0)
					{
						MessageBox.Show((string) ("ERROR: " + Errmsg));
					}
					LL = 35;
				}
				else
				{
					LL = 37;
					
					int iFlen = fileData.Length;
					
					string sErrmsg = "";
					
					//sErrmsg = Proxy.UploadBufferedCreate(gCurrUserGuidID, FileGuid, iFlen, Sha1HASH, Filength, FIName, RepositoryTable, True, OriginalFileName, fileData) : LL = 37
					bool BB = true;
					LL = 38;
					
					//Dim SX As String = Proxy.ReturnString() : LL = 39
					
					sErrmsg = (string) (Proxy.UploadBufferedCreate(modGlobals.gGateWayID, 2, modGlobals.gCurrUserGuidID, FileGuid, iFlen, Sha1HASH, Filength, FIName, RepositoryTable, BB, OriginalFileName, fileData));
					LL = 40;
					//ProxyUpload = Nothing : LL = 40
					
					if (sErrmsg.Length > 0)
					{
						MessageBox.Show((string) ("ERROR: " + sErrmsg));
					}
					
					GC.Collect();
					GC.WaitForPendingFinalizers();
					LL = 49;
				}
				LL = 50;
			}
			catch (Exception ex)
			{
				frmNotifyMessage.Default.MsgToDisplay = "ERROR 167: - UploadBuffer: " + ex.Message;
				frmNotifyMessage.Default.Show();
				xTrace(990134, (string) ("UploadBuffer LL:" + LL.ToString()), ex.Message);
				xTrace(990135, (string) ("UploadBuffer LL:" + LL.ToString()), ex.InnerException.ToString());
			}
			finally
			{
				//Proxy.Close()
				//Proxy = Nothing
				//oFileStream.Close()
				//oFileStream.Dispose()
				//oFile = Nothing
				GC.Collect();
				GC.WaitForPendingFinalizers();
				LL = 41;
			}
			
			int ElapsedSecs = modGlobals.ElapsedTimeSec(StartTime, DateTime.Now);
			double BytesPerSec = Filength / ElapsedSecs;
			if (bTrackUploads)
			{
				LOG.WriteToArchiveLog((string) ("UploadBuffered: File - start " + DateTime.Now.ToString() + " + / " + FQN + " : " + Filength.ToString() + " / " + DateTime.Now.ToString()));
			}
			
		}
		
		public void ChunkFileUpload(string OriginalFileName, string FileGuid, string FQN, string RepositoryTable, string CrcHASH)
		{
			
			long Ticks = 0;
			long TotalTicks = 0;
			DateTime StartTime = DateTime.Now;
			DateTime EndTime = DateTime.Now;
			long CurrByte = 0;
			string RetMsg = "";
			bool LastSegment = false;
			
			//Dim ProxyFS As New SvcFS.Service1Client
			
			if (! File.Exists(FQN))
			{
				return;
			}
			
			Ticks = DateTime.Now.Ticks;
			TotalTicks = DateTime.Now.Ticks - Ticks;
			
			long Filength = 0;
			string FIName = "";
			
			FileInfo FI = new FileInfo(FQN);
			
			Filength = FI.Length;
			FIName = FI.Name;
			
			FI = null;
			
			System.Net.ServicePointManager.DefaultConnectionLimit = 200;
			System.IO.FileStream fStream = new System.IO.FileStream(FQN, FileMode.Open);
			string ErrMsg = "";
			StartTime = DateTime.Now;
			
			byte[] Buffer = new byte[65537];
			int iBuffer = 65536;
			int I = 0;
			int P = 0;
			int iLoop = 0;
			
			//WDMXX()
			
			try
			{
				I = fStream.Read(Buffer, 0, iBuffer);
				while (I > 0)
				{
					if (iLoop == 0)
					{
						iLoop++;
						if (I < Buffer.Length)
						{
							LastSegment = true;
						}
						ErrMsg = (string) (Proxy.UploadBufferedCreate(modGlobals.gGateWayID, 3, modGlobals.gCurrUserGuidID, FileGuid, I, CrcHASH, Filength, FIName, RepositoryTable, LastSegment, OriginalFileName, Buffer));
						if (ErrMsg.Length > 0)
						{
							MessageBox.Show((string) ("ERROR: " + ErrMsg));
							LOG.WriteToArchiveLog((string) ("ERROR: " + ErrMsg));
						}
					}
					else
					{
						iLoop++;
						if (I < Buffer.Length)
						{
							LastSegment = true;
						}
						ErrMsg = (string) (Proxy.UploadBufferedAppend(modGlobals.gGateWayID, modGlobals.gCurrUserGuidID, FileGuid, I, CrcHASH, Filength, FIName, RepositoryTable, RetMsg, LastSegment, OriginalFileName, Buffer));
						if (ErrMsg.Length > 0)
						{
							MessageBox.Show((string) ("ERROR: " + ErrMsg));
							LOG.WriteToArchiveLog((string) ("ERROR: " + ErrMsg));
						}
					}
					P += iBuffer - 1;
					I = fStream.Read(Buffer, 0, iBuffer);
					if (I == 0 && ! LastSegment)
					{
						LastSegment = true;
						ErrMsg = (string) (Proxy.UploadBufferedAppend(modGlobals.gGateWayID, modGlobals.gCurrUserGuidID, FileGuid, I, CrcHASH, Filength, FIName, RepositoryTable, RetMsg, LastSegment, OriginalFileName, Buffer));
					}
				}
				Console.WriteLine("Loops to process = " + iLoop.ToString());
			}
			catch (Exception ex)
			{
				MessageBox.Show(ex.Message);
			}
			EndTime = DateTime.Now;
			
			int ElapsedSecs = modGlobals.ElapsedTimeSec(StartTime, EndTime);
			double BytesPerSec = Filength / ElapsedSecs;
			
			Console.WriteLine("Chunk Upload: Size= " + Filength.ToString() + " / Seconds: " + ElapsedSecs.ToString() + " / Bytes per sec: " + BytesPerSec.ToString());
			
			//ProxyFS.Close()
			Console.WriteLine("Loops to process = " + iLoop.ToString());
			fStream.Close();
			fStream.Dispose();
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
		}
		
		public void UploadFileStream(string OriginalFileName, string FileGuid, string FQN, string RepositoryTable, string Sha1HASH)
		{
			
			//WDMXX()
			
			bool isCompressed = true;
			//Dim Sha1HASH As String = ""
			long Ticks = 0;
			long TotalTicks = 0;
			DateTime StartTime = DateTime.Now;
			DateTime EndTime = DateTime.Now;
			
			if (! File.Exists(FQN))
			{
				LOG.WriteToArchiveLog((string) ("NOTICE: File not found - " + FQN));
				return;
			}
			
			if (bTrackUploads)
			{
				LOG.WriteToArchiveLog((string) ("FileStream: File - start " + DateTime.Now.ToString() + FQN));
			}
			
			Ticks = DateTime.Now.Ticks;
			//Sha1HASH = ENC.getSha1HashFromFile(FQN)
			TotalTicks = DateTime.Now.Ticks - Ticks;
			
			long Filength = 0;
			string FIName = "";
			
			FileInfo FI = new FileInfo(FQN);
			
			Filength = FI.Length;
			FIName = FI.Name;
			
			FI = null;
			
			System.Net.ServicePointManager.DefaultConnectionLimit = 200;
			System.IO.FileStream fStream = new System.IO.FileStream(FQN, FileMode.Open);
			
			string ErrMsg = "";
			StartTime = DateTime.Now;
			try
			{
				ProxyFS.RemoteFileUpload(Sha1HASH, FileGuid, Filength, FIName, RepositoryTable, modGlobals.gCurrUserGuidID, isCompressed, fStream);
			}
			catch (Exception ex)
			{
				MessageBox.Show(ex.Message);
				if (bTrackUploads)
				{
					LOG.WriteToArchiveLog((string) ("ERROR FileStream: File - start " + DateTime.Now.ToString() + FQN + " : " + ex.Message));
				}
			}
			EndTime = DateTime.Now;
			
			int ElapsedSecs = modGlobals.ElapsedTimeSec(StartTime, EndTime);
			double BytesPerSec = Filength / ElapsedSecs;
			
			if (bTrackUploads)
			{
				LOG.WriteToArchiveLog((string) ("ERROR FileStream: File - END " + DateTime.Now.ToString() + FQN + " : Bytes = " + Filength.ToString()));
			}
			
			fStream.Close();
			fStream.Dispose();
			GC.Collect();
			GC.WaitForPendingFinalizers();
		}
		
		public void VerifyRetentionDates()
		{
			string MySql = "";
			bool B = false;
			
			MySql = "";
			MySql += " update DataSource set RetentionCode = \'Retain 50\',";
			MySql += " RetentionExpirationDate = getdate() + (select RetentionUnits from Retention where RetentionCode = DataSource.RetentionCode) * 365.255";
			MySql += " where RetentionExpirationDate < GETDATE() - 25 * 365.55";
			B = ExecuteSqlNewConn(MySql);
			
			
			MySql = "";
			MySql += " update email set";
			MySql += " RetentionExpirationDate = getdate() + (select RetentionUnits from Retention where RetentionCode = email.RetentionCode) * 365.255";
			MySql += " where RetentionExpirationDate < GETDATE() - 25 * 365.55";
			B = ExecuteSqlNewConn(MySql);
			
			MySql = "";
			MySql += " update EmailAttachment set ";
			MySql += " RetentionExpirationDate = getdate() + (select RetentionUnits from Retention where RetentionCode = EmailAttachment.RetentionCode) * 365.255";
			MySql += " where RetentionExpirationDate < GETDATE() - 25 * 365.55";
			B = ExecuteSqlNewConn(MySql);
			
		}
		
		public bool XXsaveContentUserRecord(string MachineName, string NetworkName, string ContentTypeCode, string ContentGuid, string UserID)
		{
			
			int iCnt = ckContentUserRecordExists(ContentTypeCode, ContentGuid, UserID);
			if (iCnt == 0)
			{
				int I = 1;
				
				string MachineGuid = MachineRegister(MachineName, NetworkName);
				
				InsertContentUserRecord(ContentTypeCode, ContentGuid, UserID, I);
				
				string MySql = "";
				MySql += " if NOT exists (Select userID from Machine " + "\r\n";
				MySql += " where MachineGuid = \'" + MachineGuid + "\' " + "\r\n";
				MySql += " and ContentGuid = \'" + ContentGuid + "\')" + "\r\n";
				MySql += " Begin " + "\r\n";
				MySql += " INSERT INTO [Machine] ([UserID],[ContentGuid],[ContentTypeCode],[MachineGuid]) VALUES (\'" + UserID + "\',\'" + ContentGuid + "\',\'" + ContentTypeCode + "\',\'" + MachineGuid + "\')" + "\r\n";
				MySql += " End" + "\r\n";
				
				bool BB = ExecuteSqlNewConn(MySql);
				
			}
			
		}
		
		public int ckContentUserRecordExists(string ContentTypeCode, string ContentGuid, string UserID)
		{
			
			string s = "";
			s = s + " Select count(*) from [ContentUser]" + "\r\n";
			s = s + " where ContentGuid = \'" + ContentGuid + "\' and UserID = \'" + UserID + "\' ";
			
			int i = iCount(s);
			
			return i;
		}
		
		/// <summary>
		/// Inserts the content user record.
		/// </summary>
		/// <param name="ContentTypeCode">The content type code.</param>
		/// <param name="ContentGuid">The content GUID.</param>
		/// <param name="UserID">The user ID.</param>
		/// <param name="NbrOccurances">The NBR occurances.</param>
		/// <returns></returns>
		public bool InsertContentUserRecord(string ContentTypeCode, string ContentGuid, string UserID, int NbrOccurances)
		{
			bool b = false;
			string NewID = Guid.NewGuid().ToString();
			string s = "";
			
			s = s + " INSERT INTO [ContentUser]" + "\r\n";
			s = s + " ([ContentTypeCode]" + "\r\n";
			s = s + " ,[ContentGuid]" + "\r\n";
			s = s + " ,[UserID]" + "\r\n";
			s = s + " ,[NbrOccurances])" + "\r\n";
			s = s + " VALUES " + "\r\n";
			s = s + " (\'" + ContentTypeCode + "\'" + "\r\n";
			s = s + " ,\'" + ContentGuid + "\'" + "\r\n";
			s = s + " ,\'" + UserID + "\'" + "\r\n";
			s = s + " ," + NbrOccurances.ToString() + " )";
			
			bool BB = ExecuteSqlNewConn(s);
			
			return BB;
		}
		
		//**************************************************************
		public bool Save_RssPull(int SecureID, string RssName, string RssUrl, string UserID, string RetentionCode, ref bool RC)
		{
			
			RC = true;
			
			var sRssName = RssName.Replace("\'", "\'\'");
			var sUserID = UserID.Replace("\'", "\'\'");
			var sRssUrl = RssUrl.Replace("\'", "\'\'");
			
			string WhereClause = " where RssUrl  = \'" + sRssUrl + "\' and UserID = \'" + sUserID + "\' ";
			
			string S = (string) ("Select count(*) from RssPull" + WhereClause);
			bool B = false;
			int iCnt = iCount(S);
			string MySql = "";
			string NewCS = getGateWayConnStr(SecureID);
			SqlConnection connection = new SqlConnection(NewCS);
			
			if (connection.State == ConnectionState.Closed)
			{
				connection.Open();
			}
			
			if (iCnt == 0)
			{
				try
				{
					
					SqlCommand command = new SqlCommand(MySql, connection);
					command.CommandType = CommandType.Text;
					
					command.Parameters.Add(new SqlParameter("@RssName", RssName));
					command.Parameters.Add(new SqlParameter("@RssUrl", RssUrl));
					command.Parameters.Add(new SqlParameter("@UserID", UserID));
					command.Parameters.Add(new SqlParameter("@RetentionCode", RetentionCode));
					
					MySql = MySql + "INSERT INTO [dbo].[RssPull]";
					MySql = MySql + "(";
					MySql = MySql + "           [RssName]";
					MySql = MySql + "           ,[RssUrl]";
					MySql = MySql + "           ,[UserID]";
					MySql = MySql + "           ,[RetentionCode]";
					MySql = MySql + ")";
					MySql = MySql + "VALUES";
					MySql = MySql + "(";
					MySql = MySql + "@RssName";
					MySql = MySql + ",@RssUrl";
					MySql = MySql + ",@UserID";
					MySql = MySql + ",@RetentionCode";
					MySql = MySql + ")";
					
					command.CommandText = MySql;
					command.ExecuteNonQuery();
					connection.Close();
					command.Dispose();
					B = true;
				}
				catch (Exception ex)
				{
					Console.WriteLine("ERROR: " + ex.Message);
					B = false;
				}
			}
			else
			{
				try
				{
					SqlCommand command = new SqlCommand(MySql, connection);
					command.CommandType = CommandType.Text;
					
					command.Parameters.Add(new SqlParameter("@RssName", RssName));
					command.Parameters.Add(new SqlParameter("@RssUrl", RssUrl));
					command.Parameters.Add(new SqlParameter("@UserID", UserID));
					command.Parameters.Add(new SqlParameter("@RetentionCode", RetentionCode));
					
					
					MySql = MySql + "UPDATE [dbo].[RssPull]";
					MySql = MySql + " SET [RssName] = @RssName ";
					MySql = MySql + " ,[RssUrl] = @RssUrl ";
					MySql = MySql + " ,[UserID] = @UserID ";
					MySql = MySql + " ,[RetentionCode] = @RetentionCode ";
					
					MySql = MySql + WhereClause;
					
					//connection.Open()
					command.CommandText = MySql;
					command.ExecuteNonQuery();
					connection.Close();
					command.Dispose();
					B = true;
				}
				catch (Exception ex)
				{
					Console.WriteLine("ERROR: 157848 " + ex.Message + Environment.NewLine + MySql);
					B = false;
				}
			}
			
			return B;
			
		}
		
		public BindingSource GET_RssPull(int SecureID, string WhereClause, bool RC)
		{
			
			string MySql = null;
			MySql += "Select ";
			MySql += "[RssName], ";
			MySql += "[RssUrl], ";
			MySql += "[UserID], ";
			MySql += "[RetentionCode] ";
			MySql += " From [RssPull] ";
			
			
			if (WhereClause != null)
			{
				MySql += WhereClause;
			}
			
			MySql += " Order by RssName ";
			
			string CSstr = getGateWayConnStr(SecureID);
			string ConnStr = CSstr;
			SqlConnection CONN = new SqlConnection(ConnStr);
			if (CONN.State == ConnectionState.Closed)
			{
				CONN.Open();
			}
			
			BindingSource BSource = new BindingSource();
			SqlCommand command = new SqlCommand(MySql, CONN);
			SqlDataReader rsDataQry = null;
			
			try
			{
				var dataAdapter = new SqlDataAdapter(MySql, ConnStr);
				SqlCommandBuilder commandBuilder = new SqlCommandBuilder(dataAdapter);
				DataTable table = new DataTable();
				Table.Locale = System.Globalization.CultureInfo.InvariantCulture;
				dataAdapter.Fill(table);
				BSource.DataSource = table;
			}
			catch (Exception e)
			{
				xTrace(13321, "clsDataBase:getRssPull", e.Message.ToString());
			}
			finally
			{
				if (rsDataQry != null)
				{
					if (! rsDataQry.IsClosed)
					{
						rsDataQry.Close();
					}
					rsDataQry = null;
				}
				command.Dispose();
				command = null;
			}
			
			return BSource;
			
			
		}
		
		public List<string> GET_RssPullData(int SecureID, string WhereClause, bool RC)
		{
			
			List<string> ListOfUrls = new List<string>();
			string RssName = "";
			string RssUrl = "";
			string UserID = "";
			string RetentionCode = "";
			string RowGuid = "";
			
			string MySql = null;
			MySql += "Select ";
			MySql += "[RssName], ";
			MySql += "[RssUrl], ";
			MySql += "[UserID], RetentionCode, RowGuid ";
			MySql += " From [RssPull] ";
			
			if (WhereClause != null)
			{
				MySql += WhereClause;
			}
			
			string CSstr = getGateWayConnStr(SecureID);
			string ConnStr = CSstr;
			SqlConnection CONN = new SqlConnection(ConnStr);
			if (CONN.State == ConnectionState.Closed)
			{
				CONN.Open();
			}
			
			SqlDataReader RSData = null;
			SqlCommand command = new SqlCommand(MySql, CONN);
			
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					RssName = RSData.GetValue(0).ToString();
					RssUrl = RSData.GetValue(1).ToString();
					UserID = RSData.GetValue(2).ToString();
					RetentionCode = RSData.GetValue(3).ToString();
					RowGuid = RSData.GetValue(4).ToString();
					var strItems = RssName + "|" + RssUrl + "|" + UserID + "|" + RetentionCode + "|" + RowGuid;
					ListOfUrls.Add(strItems);
				}
			}
			RSData.Close();
			RSData = null;
			
			return ListOfUrls;
			
		}
		public List<string> GET_WebSiteData(int SecureID, string WhereClause, bool RC)
		{
			
			List<string> ListOfUrls = new List<string>();
			string WebSite = "";
			string WebUrl = "";
			string UserID = "";
			string Depth = "";
			string Width = "";
			string RetentionCode = "";
			string RowGuid = "";
			
			string MySql = null;
			MySql += "Select ";
			MySql += "[WebSite], ";
			MySql += "[WebUrl], ";
			MySql += "Depth, ";
			MySql += "Width, ";
			MySql += "[UserID], ";
			MySql += "RetentionCode, ";
			MySql += "RowGuid ";
			MySql += " From [WebSite] ";
			
			if (WhereClause != null)
			{
				MySql += WhereClause;
			}
			
			string CSstr = getGateWayConnStr(SecureID);
			string ConnStr = CSstr;
			SqlConnection CONN = new SqlConnection(ConnStr);
			if (CONN.State == ConnectionState.Closed)
			{
				CONN.Open();
			}
			
			SqlDataReader RSData = null;
			SqlCommand command = new SqlCommand(MySql, CONN);
			
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					WebSite = RSData.GetValue(0).ToString();
					WebUrl = RSData.GetValue(1).ToString();
					Depth = RSData.GetValue(2).ToString();
					Width = RSData.GetValue(3).ToString();
					UserID = RSData.GetValue(4).ToString();
					RetentionCode = RSData.GetValue(5).ToString();
					RowGuid = RSData.GetValue(6).ToString();
					var strItems = WebSite + "|" + WebUrl + "|" + UserID + "|" + Depth + "|" + Width + "|" + RetentionCode + "|" + RowGuid;
					ListOfUrls.Add(strItems);
				}
			}
			RSData.Close();
			RSData = null;
			
			return ListOfUrls;
			
		}
		public List<string> GET_WebPageData(int SecureID, string WhereClause, bool RC)
		{
			
			List<string> ListOfUrls = new List<string>();
			string WebSite = "";
			string WebUrl = "";
			string UserID = "";
			string Depth = "1";
			string Width = "0";
			string RetentionCode = "";
			string RowGuid = "";
			
			string MySql = null;
			MySql += "Select ";
			MySql += "[WebScreen], ";
			MySql += "[WebUrl], ";
			MySql += "\'1\' as Depth, ";
			MySql += "\'0\' as Width, ";
			MySql += "[UserID], ";
			MySql += "RetentionCode, ";
			MySql += "RowGuid ";
			MySql += " From [WebScreen] ";
			
			if (WhereClause != null)
			{
				MySql += WhereClause;
			}
			
			string CSstr = getGateWayConnStr(SecureID);
			string ConnStr = CSstr;
			SqlConnection CONN = new SqlConnection(ConnStr);
			if (CONN.State == ConnectionState.Closed)
			{
				CONN.Open();
			}
			
			SqlDataReader RSData = null;
			SqlCommand command = new SqlCommand(MySql, CONN);
			
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				while (RSData.Read())
				{
					WebSite = RSData.GetValue(0).ToString();
					WebUrl = RSData.GetValue(1).ToString();
					Depth = RSData.GetValue(2).ToString();
					Width = RSData.GetValue(3).ToString();
					UserID = RSData.GetValue(4).ToString();
					RetentionCode = RSData.GetValue(5).ToString();
					RowGuid = RSData.GetValue(6).ToString();
					var strItems = WebSite + "|" + WebUrl + "|" + UserID + "|" + Depth + "|" + Width + "|" + RetentionCode + "|" + RowGuid;
					ListOfUrls.Add(strItems);
				}
			}
			RSData.Close();
			RSData = null;
			
			return ListOfUrls;
			
		}
		
		public BindingSource GET_WebScreenForGRID(int SecureID, string WhereClause, bool RC)
		{
			
			string MySql = null;
			MySql += "Select ";
			MySql += "[WebScreen], ";
			MySql += "[WebUrl], ";
			MySql += "[UserID], ";
			MySql += "[RetentionCode] ";
			MySql += " From [WebScreen]" + "\r\n";
			
			if (WhereClause != null)
			{
				MySql += WhereClause;
			}
			MySql += " order by [WebScreen]" + "\r\n";
			
			string ConnStr = getGateWayConnStr(SecureID);
			SqlConnection CONN = new SqlConnection(ConnStr);
			if (CONN.State == ConnectionState.Closed)
			{
				CONN.Open();
			}
			
			BindingSource BSource = new BindingSource();
			SqlCommand command = new SqlCommand(MySql, CONN);
			SqlDataReader rsDataQry = null;
			
			try
			{
				var dataAdapter = new SqlDataAdapter(MySql, ConnStr);
				SqlCommandBuilder commandBuilder = new SqlCommandBuilder(dataAdapter);
				DataTable table = new DataTable();
				Table.Locale = System.Globalization.CultureInfo.InvariantCulture;
				dataAdapter.Fill(table);
				BSource.DataSource = table;
			}
			catch (Exception e)
			{
				xTrace(13322, "clsDataBase:GET_WebScreen", e.Message.ToString());
			}
			finally
			{
				if (rsDataQry != null)
				{
					if (! rsDataQry.IsClosed)
					{
						rsDataQry.Close();
					}
					rsDataQry = null;
				}
				command.Dispose();
				command = null;
			}
			
			return BSource;
			
			
		}
		public bool Save_WebScreenURL(int SecureID, string WebScreen, string WebUrl, string RetentionCode, string UserID, ref bool RC)
		{
			
			var sWebScreen = WebScreen.Replace("\'", "\'\'");
			var sWebUrl = WebUrl.Replace("\'", "\'\'");
			var sUserID = UserID.Replace("\'", "\'\'");
			
			RC = true;
			string WhereClause = " where WebUrl  = \'" + sWebUrl + "\' and UserID = \'" + UserID + "\' ";
			
			string S = (string) ("Select count(*) from WebScreen" + WhereClause);
			bool B = false;
			int iCnt = iCount(S);
			string MySql = "";
			SqlConnection connection = new SqlConnection(getGateWayConnStr(SecureID));
			
			if (connection.State == ConnectionState.Closed)
			{
				connection.Open();
			}
			
			if (iCnt == 0)
			{
				try
				{
					
					SqlCommand command = new SqlCommand(MySql, connection);
					command.CommandType = CommandType.Text;
					
					command.Parameters.Add(new SqlParameter("@WebScreen", WebScreen));
					command.Parameters.Add(new SqlParameter("@WebUrl", WebUrl));
					command.Parameters.Add(new SqlParameter("@UserID", UserID));
					command.Parameters.Add(new SqlParameter("@RetentionCode", RetentionCode));
					
					MySql = MySql + "INSERT INTO [dbo].[WebScreen]";
					MySql = MySql + "(";
					MySql = MySql + "           [WebScreen]";
					MySql = MySql + "           ,[WebUrl]";
					MySql = MySql + "           ,[UserID]";
					MySql = MySql + "           ,[RetentionCode]";
					MySql = MySql + ")";
					MySql = MySql + "VALUES";
					MySql = MySql + "(";
					MySql = MySql + "@WebScreen";
					MySql = MySql + ",@WebUrl";
					MySql = MySql + ",@UserID";
					MySql = MySql + ",@RetentionCode";
					MySql = MySql + ")";
					
					//connection.Open()
					command.CommandText = MySql;
					command.ExecuteNonQuery();
					connection.Close();
					command.Dispose();
					B = true;
				}
				catch (Exception ex)
				{
					Console.WriteLine("ERROR: " + ex.Message);
					B = false;
				}
			}
			else
			{
				try
				{
					SqlCommand command = new SqlCommand(MySql, connection);
					command.CommandType = CommandType.Text;
					
					command.Parameters.Add(new SqlParameter("@WebScreen", WebScreen));
					command.Parameters.Add(new SqlParameter("@WebUrl", WebUrl));
					command.Parameters.Add(new SqlParameter("@UserID", UserID));
					command.Parameters.Add(new SqlParameter("@RetentionCode", RetentionCode));
					
					MySql = MySql + "UPDATE [dbo].[WebScreen] ";
					MySql = MySql + " SET [WebScreen] = @WebScreen ";
					MySql = MySql + " ,[WebUrl] = @WebUrl ";
					MySql = MySql + " ,[UserID] = @UserID ";
					MySql = MySql + " ,[RetentionCode] = @RetentionCode ";
					
					MySql = MySql + WhereClause;
					
					//connection.Open()
					command.CommandText = MySql;
					command.ExecuteNonQuery();
					connection.Close();
					command.Dispose();
					B = true;
				}
				catch (Exception ex)
				{
					Console.WriteLine("ERROR: 157848 " + ex.Message + Environment.NewLine + MySql);
					B = false;
				}
			}
			
			return B;
			
		}
		
		public BindingSource GET_WebSite(int SecureID, string WhereClause, bool RC)
		{
			
			string MySql = null;
			MySql += "Select ";
			MySql += "[WebSite], ";
			MySql += "[WebUrl], ";
			MySql += "[UserID], ";
			MySql += "[Depth], ";
			MySql += "[Width], ";
			MySql += "[RetentionCode] ";
			MySql += " From [WebSite]" + "\r\n";
			
			if (WhereClause != null)
			{
				MySql += WhereClause;
			}
			MySql += "Order by WebSite";
			System.Collections.Generic.List<DS_WebSite> ListOfRows = new System.Collections.Generic.List<DS_WebSite>();
			
			string ConnStr = getGateWayConnStr(SecureID);
			SqlConnection CONN = new SqlConnection(ConnStr);
			
			if (CONN.State == ConnectionState.Closed)
			{
				CONN.Open();
			}
			
			BindingSource BSource = new BindingSource();
			SqlCommand command = new SqlCommand(MySql, CONN);
			SqlDataReader rsDataQry = null;
			
			try
			{
				var dataAdapter = new SqlDataAdapter(MySql, ConnStr);
				SqlCommandBuilder commandBuilder = new SqlCommandBuilder(dataAdapter);
				DataTable table = new DataTable();
				Table.Locale = System.Globalization.CultureInfo.InvariantCulture;
				dataAdapter.Fill(table);
				BSource.DataSource = table;
			}
			catch (Exception e)
			{
				xTrace(13322, "clsDataBase:GET_WebSite", e.Message.ToString());
			}
			finally
			{
				if (rsDataQry != null)
				{
					if (! rsDataQry.IsClosed)
					{
						rsDataQry.Close();
					}
					rsDataQry = null;
				}
				command.Dispose();
				command = null;
			}
			
			return BSource;
			
			
		}
		
		
		public bool Save_WebSiteURL(int SecureID, string WebSite, string WebUrl, int depth, int width, string RetentionCode, string UserID, ref bool RC)
		{
			
			var sWebSite = WebSite.Replace("\'", "\'\'");
			var sUserID = UserID.Replace("\'", "\'\'");
			
			RC = true;
			string WhereClause = " where WebSite  = \'" + sWebSite + "\' and UserID = \'" + sUserID + "\' ";
			
			string S = (string) ("Select count(*) from WebSite" + WhereClause);
			bool B = false;
			int iCnt = iCount(S);
			string MySql = "";
			SqlConnection connection = new SqlConnection(getGateWayConnStr(SecureID));
			
			if (connection.State == ConnectionState.Closed)
			{
				connection.Open();
			}
			
			if (iCnt == 0)
			{
				try
				{
					
					SqlCommand command = new SqlCommand(MySql, connection);
					command.CommandType = CommandType.Text;
					
					command.Parameters.Add(new SqlParameter("@WebSite", WebSite));
					command.Parameters.Add(new SqlParameter("@WebUrl", WebUrl));
					command.Parameters.Add(new SqlParameter("@UserID", UserID));
					command.Parameters.Add(new SqlParameter("@depth", depth));
					command.Parameters.Add(new SqlParameter("@width", width));
					command.Parameters.Add(new SqlParameter("@RetentionCode", RetentionCode));
					MySql = "";
					MySql = MySql + "INSERT INTO [dbo].[WebSite]";
					MySql = MySql + "(";
					MySql = MySql + "           [WebSite]";
					MySql = MySql + "           ,[WebUrl]";
					MySql = MySql + "           ,[UserID]";
					MySql = MySql + "           ,[depth]";
					MySql = MySql + "           ,[Width]";
					MySql = MySql + "           ,[RetentionCode]";
					MySql = MySql + ")";
					MySql = MySql + "VALUES";
					MySql = MySql + "(";
					MySql = MySql + "@WebSite";
					MySql = MySql + ",@WebUrl";
					MySql = MySql + ",@UserID";
					MySql = MySql + ",@depth";
					MySql = MySql + ",@width";
					MySql = MySql + ",@RetentionCode";
					MySql = MySql + ")";
					
					//connection.Open()
					command.CommandText = MySql;
					command.ExecuteNonQuery();
					connection.Close();
					command.Dispose();
					B = true;
				}
				catch (Exception ex)
				{
					Console.WriteLine("ERROR: " + ex.Message);
					B = false;
				}
			}
			else
			{
				try
				{
					SqlCommand command = new SqlCommand(MySql, connection);
					command.CommandType = CommandType.Text;
					
					command.Parameters.Add(new SqlParameter("@WebSite", WebSite));
					command.Parameters.Add(new SqlParameter("@WebUrl", WebUrl));
					command.Parameters.Add(new SqlParameter("@UserID", UserID));
					command.Parameters.Add(new SqlParameter("@depth", depth));
					command.Parameters.Add(new SqlParameter("@width", width));
					command.Parameters.Add(new SqlParameter("@RetentionCode", RetentionCode));
					
					MySql = MySql + "UPDATE [dbo].[WebSite]";
					MySql = MySql + " SET [WebSite] = @WebSite ";
					MySql = MySql + " ,[WebUrl] = @WebUrl ";
					MySql = MySql + " ,[UserID] = @UserID ";
					MySql = MySql + " ,[depth] = @depth ";
					MySql = MySql + " ,[width] = @width ";
					MySql = MySql + " ,[RetentionCode] = @RetentionCode ";
					
					MySql = MySql + WhereClause;
					
					//connection.Open()
					command.CommandText = MySql;
					command.ExecuteNonQuery();
					connection.Close();
					command.Dispose();
					B = true;
				}
				catch (Exception ex)
				{
					Console.WriteLine("ERROR: 157848 " + ex.Message + Environment.NewLine + MySql);
					B = false;
				}
			}
			
			return B;
			
		}
		
		public bool Save_RetentionCode(int SecureID, string RetentionCode, string RetentionDesc, int RetentionUnits, string RetentionAction, string ManagerID, int DaysWarning, string ResponseRequired, string RetentionPeriod, ref bool RC)
		{
			
			var sRetentionCode = RetentionCode.Replace("\'", "\'\'");
			
			RC = true;
			string WhereClause = " where RetentionCode  = \'" + sRetentionCode + "\' ";
			
			string S = (string) ("Select count(*) from Retention" + WhereClause);
			bool B = false;
			int iCnt = iCount(S);
			string MySql = "";
			SqlConnection connection = new SqlConnection(getGateWayConnStr(SecureID));
			
			if (connection.State == ConnectionState.Closed)
			{
				connection.Open();
			}
			
			if (iCnt == 0)
			{
				try
				{
					
					SqlCommand command = new SqlCommand(MySql, connection);
					command.CommandType = CommandType.Text;
					
					command.Parameters.Add(new SqlParameter("@RetentionCode", RetentionCode));
					command.Parameters.Add(new SqlParameter("@RetentionDesc", RetentionDesc));
					command.Parameters.Add(new SqlParameter("@RetentionUnits", RetentionUnits));
					command.Parameters.Add(new SqlParameter("@RetentionAction", RetentionAction.ToUpper()));
					command.Parameters.Add(new SqlParameter("@ManagerID", ManagerID));
					command.Parameters.Add(new SqlParameter("@DaysWarning", DaysWarning));
					command.Parameters.Add(new SqlParameter("@ResponseRequired", ResponseRequired));
					command.Parameters.Add(new SqlParameter("@RetentionPeriod", RetentionPeriod));
					
					MySql = "INSERT INTO [dbo].[Retention]";
					MySql = MySql + "(";
					MySql = MySql + "           [RetentionCode]";
					MySql = MySql + "           ,[RetentionDesc]";
					MySql = MySql + "           ,[RetentionUnits]";
					MySql = MySql + "           ,[RetentionAction]";
					MySql = MySql + "           ,[ManagerID]";
					MySql = MySql + "           ,[DaysWarning]";
					MySql = MySql + "           ,[ResponseRequired]";
					MySql = MySql + "           ,[RetentionPeriod]";
					MySql = MySql + ")";
					MySql = MySql + "VALUES";
					MySql = MySql + "(";
					MySql = MySql + "@RetentionCode";
					MySql = MySql + ",@RetentionDesc";
					MySql = MySql + ",@RetentionUnits";
					MySql = MySql + ",@RetentionAction";
					MySql = MySql + ",@ManagerID";
					MySql = MySql + ",@DaysWarning";
					MySql = MySql + ",@ResponseRequired";
					MySql = MySql + ",@RetentionPeriod";
					MySql = MySql + ")";
					
					//connection.Open()
					command.CommandText = MySql;
					command.ExecuteNonQuery();
					connection.Close();
					command.Dispose();
					B = true;
				}
				catch (Exception ex)
				{
					Console.WriteLine("ERROR: " + ex.Message);
					B = false;
				}
			}
			else
			{
				try
				{
					SqlCommand command = new SqlCommand(MySql, connection);
					command.CommandType = CommandType.Text;
					
					command.Parameters.Add(new SqlParameter("@RetentionCode", RetentionCode));
					command.Parameters.Add(new SqlParameter("@RetentionDesc", RetentionDesc));
					command.Parameters.Add(new SqlParameter("@RetentionUnits", RetentionUnits));
					command.Parameters.Add(new SqlParameter("@RetentionAction", RetentionAction.ToUpper()));
					command.Parameters.Add(new SqlParameter("@ManagerID", ManagerID));
					command.Parameters.Add(new SqlParameter("@DaysWarning", DaysWarning));
					command.Parameters.Add(new SqlParameter("@ResponseRequired", ResponseRequired));
					command.Parameters.Add(new SqlParameter("@RetentionPeriod", RetentionPeriod));
					
					
					MySql = MySql + "UPDATE [dbo].[Retention] ";
					MySql = MySql + " SET [RetentionCode] = @RetentionCode ";
					MySql = MySql + " ,[RetentionDesc] = @RetentionDesc ";
					MySql = MySql + " ,[RetentionUnits] = @RetentionUnits ";
					MySql = MySql + " ,[RetentionAction] = @RetentionAction ";
					MySql = MySql + " ,[ManagerID] = @ManagerID ";
					MySql = MySql + " ,[DaysWarning] = @DaysWarning ";
					MySql = MySql + " ,[ResponseRequired] = @ResponseRequired ";
					MySql = MySql + " ,[RetentionPeriod] = @RetentionPeriod ";
					
					MySql = MySql + WhereClause;
					
					//connection.Open()
					command.CommandText = MySql;
					command.ExecuteNonQuery();
					connection.Close();
					command.Dispose();
					B = true;
				}
				catch (Exception ex)
				{
					Console.WriteLine("ERROR: 157848 " + ex.Message + Environment.NewLine + MySql);
					B = false;
				}
			}
			
			return B;
			
		}
		public BindingSource GET_RetentionCodes(int SecureID, bool RC)
		{
			
			string MySql = null;
			MySql += "Select ";
			MySql += "[RetentionCode], ";
			MySql += "[RetentionDesc], ";
			MySql += "[RetentionUnits], ";
			MySql += "[RetentionAction], ";
			MySql += "[ManagerID], ";
			MySql += "[DaysWarning], ";
			MySql += "[ResponseRequired], ";
			MySql += "[RetentionPeriod] ";
			MySql += " From [Retention] ";
			MySql += " Order by [RetentionCode] ";
			
			
			string CSstr = getGateWayConnStr(SecureID);
			string ConnStr = CSstr;
			SqlConnection CONN = new SqlConnection(ConnStr);
			if (CONN.State == ConnectionState.Closed)
			{
				CONN.Open();
			}
			
			BindingSource BSource = new BindingSource();
			SqlCommand command = new SqlCommand(MySql, CONN);
			SqlDataReader rsDataQry = null;
			
			try
			{
				var dataAdapter = new SqlDataAdapter(MySql, ConnStr);
				SqlCommandBuilder commandBuilder = new SqlCommandBuilder(dataAdapter);
				DataTable table = new DataTable();
				Table.Locale = System.Globalization.CultureInfo.InvariantCulture;
				dataAdapter.Fill(table);
				BSource.DataSource = table;
			}
			catch (Exception e)
			{
				xTrace(13321, "clsDataBase:getRssPull", e.Message.ToString());
			}
			finally
			{
				if (rsDataQry != null)
				{
					if (! rsDataQry.IsClosed)
					{
						rsDataQry.Close();
					}
					rsDataQry = null;
				}
				command.Dispose();
				command = null;
			}
			
			return BSource;
			
			
		}
		public void insertSourceChild(string ParentSourceGuid, string ChildSourceGuid)
		{
			//SELECT FQN, SourceGuid FROM DataSource
			var S = "Select count(*) from [DataSourceChildren] where ParentSourceGuid = \'" + ParentSourceGuid + "\' and ChildSourceGuid = \'" + ChildSourceGuid + "\' ";
			
			int iMax = iCount(S);
			
			if (iMax > 0)
			{
				return;
			}
			
			S = "INSERT INTO [dbo].[DataSourceChildren] ([ParentSourceGuid] ,[ChildSourceGuid]) VALUES (\'" + ParentSourceGuid + "\' ,\'" + ChildSourceGuid + "\')";
			bool B = this.ExecuteSqlNewConn(S, false);
			
			if (! B)
			{
				LOG.WriteToArchiveLog("clsDatabase : insertSourceChild : 100 : Failed to add relationship.");
			}
			
		}
		
		public void insertrSSChild(string rssRowGuid, string SourceGuid)
		{
			
			var S = "Select count(*) from [RSSChildren] where RssRowGuid = \'" + rssRowGuid + "\' and SourceGuid = \'" + SourceGuid + "\' ";
			int iMax = iCount(S);
			
			if (iMax > 0)
			{
				return;
			}
			
			S = "INSERT INTO [dbo].[DataSourceChildren] ([ParentSourceGuid] ,[ChildSourceGuid]) VALUES (\'" + rssRowGuid + "\' ,\'" + SourceGuid + "\')";
			bool B = this.ExecuteSqlNewConn(S, false);
			
			if (! B)
			{
				LOG.WriteToArchiveLog("clsDatabase : AttributeExists : 100 : Failed to add attribute.");
			}
			
		}
		
	}
	
	
	
}

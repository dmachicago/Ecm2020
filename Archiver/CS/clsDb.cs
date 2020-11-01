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
//using System.Configuration.ConfigurationSettings;
using Microsoft.VisualBasic.CompilerServices;

/// <summary>
/// This is the database class for the thesaurus developed and
/// used by ECM Library developers. It is copyrighted and
/// confidential as this is critical to our products uniqueness.
/// I promise you, if you are reading this code without our WRITTEN
/// permission, I will find you , I will hunt you down,
/// and I will do my very best to completely and utterly
/// DESTROY YOU - count on it.
/// </summary>
/// <remarks></remarks>
namespace EcmArchiveClcSetup
{
	public class clsDb
	{
		clsDma DMA = new clsDma();
		clsLogging LOG = new clsLogging();
		clsUtility UTIL = new clsUtility();
		
		bool dDebug = false;
		SqlConnection TrexConnection = new SqlConnection();
		string ThesaurusConnectionString = "";
		string EcmLibConnectionString = "";
		
		public void setEcmLibConnStr()
		{
			bool bUseConfig = true;
			string S = "";
			S = My.Settings.Default["UserDefaultConnString"];
			if (S.Equals("?"))
			{
				S = System.Configuration.ConfigurationManager.AppSettings["ECMREPO"];
			}
			//setConnectionStringTimeout(S)
			//S = ENC.AES256DecryptString(S)
			EcmLibConnectionString = S;
		}
		public bool ExecuteSqlNewConn(string sql, string NewConnectionStr)
		{
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
							MessageBox.Show((string) ("It appears this user has DATA within the repository associated to them and cannot be deleted." + "\r\n" + "\r\n" + ex.Message));
						}
						else if (ex.Message.IndexOf("duplicate key row") + 1 > 0)
						{
							//log.WriteToArchiveLog("clsDatabase : ExecuteSqlNewConn : 1464 : " + ex.Message)
							//log.WriteToArchiveLog("clsDatabase : ExecuteSqlNewConn : 1408 : " + ex.Message)
							//log.WriteToArchiveLog("clsDatabase : ExecuteSqlNewConn : 1411 : " + ex.Message)
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
						//xTrace(0, "ExecuteSqlNoTx: ", "-----------------------")
						//xTrace(1, "ExecuteSqlNoTx: ", ex.Message.ToString)
						if (dDebug)
						{
							Debug.Print(ex.Message.ToString());
						}
						//xTrace(2, "ExecuteSqlNoTx: ", ex.StackTrace.ToString)
						//xTrace(3, "ExecuteSqlNoTx: ", Mid(sql, 1, 2000))
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
				//xTrace(9914, "ExecuteSqlNewConn", "ExecuteSqlNewConn Failed", ex)
				MessageBox.Show(ex.Message);
				return false;
			}
			
		}
		public SqlDataReader SqlQry(string sql)
		{
			//'Session("ActiveError") = False
			bool dDebug = true;
			string queryString = sql;
			bool rc = false;
			SqlDataReader rsDataQry = null;
			CkConn();
			SqlCommand command = new SqlCommand(sql, TrexConnection);
			try
			{
				rsDataQry = command.ExecuteReader();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDB : SqlQry : 1319db : " + ex.Message.ToString() + "\r\n" + sql));
			}
			command.Dispose();
			command = null;
			return rsDataQry;
		}
		public string getDefaultThesaurus()
		{
			//Dim EcmLibConnectionString As String = ""
			setEcmLibConnStr();
			string DefaultThesaurus = "";
			string s = "";
			
			SqlConnection EcmConn = new SqlConnection(EcmLibConnectionString);
			if (EcmConn.State == ConnectionState.Closed)
			{
				EcmConn.Open();
			}
			
			try
			{
				string tQuery = "";
				s = "Select [SysParmVal] FROM [SystemParms] where [SysParm] = \'Default Thesaurus\' ";
				using (TrexConnection)
				{
					SqlCommand command = new SqlCommand(s, EcmConn);
					SqlDataReader RSData = null;
					RSData = SqlQry(s);
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
					Debug.Print((string) ("Error 3932.11: CountOfThesauri " + ex.Message));
				}
				Console.WriteLine("Error 3932.11: getDefaultThesaurus" + ex.Message);
				DefaultThesaurus = "";
				MessageBox.Show("Check the sql error log");
				LOG.WriteToArchiveLog((string) ("ERROR clsDB : getDefaultThesaurus : 100a : " + EcmLibConnectionString));
				LOG.WriteToArchiveLog((string) ("clsDB : getDefaultThesaurus : 100b : " + ex.Message + "\r\n" + s));
				DefaultThesaurus = "Roget";
			}
			if (EcmConn.State != ConnectionState.Closed)
			{
				EcmConn.Close();
			}
			EcmConn = null;
			GC.Collect();
			return DefaultThesaurus;
		}
		public bool ThesaurusExist()
		{
			
			int I = getCountOfThesauri();
			if (I <= 0)
			{
				string CS = getThesaurusConnectionString();
				string InsertSql = "INSERT INTO [dbo].[Thesaurus] ([ThesaurusName],[ThesaurusID]) VALUES (\'Roget\',\'D7A21DA7-0818-4B75-8BBA-D0339D3E1D54\')";
				bool B = ExecuteSqlNewConn(InsertSql, CS);
				if (! B)
				{
					LOG.WriteToArchiveLog("ERROR :ThesaurusExist - Failed to add default Thesaurus.");
				}
			}
		}
		public int getCountOfThesauri()
		{
			int cnt = -1;
			string s = "";
			
			try
			{
				string tQuery = "";
				s = "Select count(*) FROM [Thesaurus] ";
				using (TrexConnection)
				{
					
					SqlDataReader RSData = null;
					string CS = ThesaurusConnectionString;
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
				//xTrace(12335, "clsDataBase:iGetRowCount", ex.Message)
				//messagebox.show("Error 3932.11: " + ex.Message)
				if (dDebug)
				{
					Debug.Print((string) ("Error 3932.11: CountOfThesauri " + ex.Message));
				}
				Console.WriteLine("Error 3932.11: CountOfThesauri" + ex.Message);
				cnt = 0;
				LOG.WriteToArchiveLog((string) ("clsDB : CountOfThesauri : 100 : " + ex.Message));
			}
			
			return cnt;
			
		}
		public int iGetRowCount(string TBL, string WhereClause)
		{
			
			int cnt = -1;
			string s = "";
			
			try
			{
				string tQuery = "";
				s = (string) ("Select count(*) as CNT from " + TBL + " " + WhereClause);
				using (TrexConnection)
				{
					
					SqlCommand command = new SqlCommand(s, TrexConnection);
					SqlDataReader RSData = null;
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
				//xTrace(12335, "clsDataBase:iGetRowCount", ex.Message)
				//messagebox.show("Error 3932.11: " + ex.Message)
				if (dDebug)
				{
					Debug.Print((string) ("Error 3932.11: " + ex.Message));
				}
				Console.WriteLine("Error 3932.11: " + ex.Message);
				cnt = 0;
				LOG.WriteToArchiveLog((string) ("clsDatabase : iGetRowCount : 4010 : " + ex.Message));
			}
			
			return cnt;
			
		}
		public SqlDataReader GetRowByKey(string TBL, string WC)
		{
			try
			{
				string Auth = "";
				string s = (string) ("Select * from " + TBL + " " + WC);
				SqlDataReader rsData = null;
				bool b = false;
				string CS = ThesaurusConnectionString;
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
				//xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
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
		public void CkConn()
		{
			string S = "";
			if (TrexConnection == null)
			{
				try
				{
					TrexConnection = new SqlConnection();
					TrexConnection.ConnectionString = getThesaurusConnectionString();
					S = getThesaurusConnectionString();
					TrexConnection.Open();
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("clsDatabase : CkConn : 338 : " + ex.Message));
				}
			}
			if (TrexConnection.State == System.Data.ConnectionState.Closed)
			{
				try
				{
					TrexConnection.ConnectionString = getThesaurusConnectionString();
					S = getThesaurusConnectionString();
					TrexConnection.Open();
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("clsDatabase : CkConn : 348.2 : " + ex.Message + "\r\n" + S));
				}
			}
		}
		public void setConnThesaurusStr()
		{
			bool bUseConfig = true;
			string S = "";
			try
			{
				LOG.WriteToInstallLog("INFO: clsDb:setConnThesaurusStr 100: " + My.Settings.Default["UserThesaurusConnString"].ToString());
				if (My.Settings.Default["UserThesaurusConnString"].Equals("?"))
				{
					S = System.Configuration.ConfigurationManager.AppSettings["ECM_ThesaurusConnectionString"].ToString();
					LOG.WriteToInstallLog((string) ("INFO: clsDb:setConnThesaurusStr 200: " + S));
					My.Settings.Default["UserThesaurusConnString"] = S;
					LOG.WriteToInstallLog("INFO: clsDb:setConnThesaurusStr 300: " + My.Settings.Default["UserThesaurusConnString"].ToString());
				}
				else
				{
					S = My.Settings.Default["UserThesaurusConnString"];
					LOG.WriteToInstallLog("INFO: clsDb:setConnThesaurusStr 400: " + My.Settings.Default["UserThesaurusConnString"].ToString());
				}
				ThesaurusConnectionString = S;
			}
			catch (Exception ex)
			{
				MessageBox.Show(ex.Message);
			}
			
			//S = ENC.AES256DecryptString(S)
			ThesaurusConnectionString = S;
			LOG.WriteToInstallLog((string) ("INFO: clsDb:setConnThesaurusStr 500: " + S));
			
		}
		
		public string getThesaurusConnectionString()
		{
			if (ThesaurusConnectionString == "")
			{
				setConnThesaurusStr();
			}
			return ThesaurusConnectionString;
		}
		public string getClassName(string ClassonomyName, string Token)
		{
			string S = "";
			S = S + " SELECT GroupID";
			S = S + " FROM [ECM.Thesaurus].[dbo].[ClassonomyData]";
			S = S + " where [CalssonomyName] = \'" + ClassonomyName + "\'";
			S = S + " and [Token] = \'" + Token + "\'";
			string ClassID = "";
			SqlDataReader rsData = null;
			
			try
			{
				string Auth = "";
				bool b = false;
				string CS = ThesaurusConnectionString;
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					rsData.Read();
					ClassID = rsData.GetValue(0).ToString();
				}
				else
				{
					ClassID = "";
				}
				
			}
			catch (Exception ex)
			{
				//xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
				if (dDebug)
				{
					Debug.Print(ex.Message);
				}
				LOG.WriteToArchiveLog((string) ("clsDatabase : getClassName : 3963 : " + ex.Message));
				return "";
			}
			if (rsData.IsClosed)
			{
			}
			else
			{
				rsData.Close();
			}
			rsData = null;
			return ClassID;
		}
		public string getThesaurusID(string ThesaurusName)
		{
			
			if (ThesaurusName.Trim.Length == 0)
			{
				ThesaurusName = getDefaultThesaurus();
			}
			
			string S = "";
			S = S + " SELECT [ThesaurusID] FROM [Thesaurus] where [ThesaurusName] = \'" + ThesaurusName + "\'";
			string TID = "";
			SqlDataReader rsData = null;
			
			try
			{
				string Auth = "";
				bool b = false;
				string CS = getThesaurusConnectionString();
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					rsData.Read();
					TID = rsData.GetValue(0).ToString();
				}
				else
				{
					MessageBox.Show("Did not find the Thesaurus listed in the DB - aborting: " + ThesaurusName + ", so the query will continue without a thesaurus.");
					LOG.WriteToArchiveLog((string) ("clsDatabase : getThesaurusID : ERROR 3963 : " + "\r\n" + S));
				}
				
			}
			catch (Exception ex)
			{
				//xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
				if (dDebug)
				{
					Debug.Print(ex.Message);
				}
				LOG.WriteToArchiveLog((string) ("clsDatabase : getThesaurusID : 3963 : " + ex.Message));
				return "";
			}
			if (rsData.IsClosed)
			{
			}
			else
			{
				rsData.Close();
			}
			rsData = null;
			return TID;
		}
		public int getThesaurusNumberID(string ThesaurusName)
		{
			
			string S = "";
			S = S + " SELECT [ThesaurusSeqID] FROM [Thesaurus] where [ThesaurusName] = \'" + ThesaurusName + "\'";
			int TID = -1;
			SqlDataReader rsData = null;
			
			try
			{
				string Auth = "";
				
				
				bool b = false;
				string CS = ThesaurusConnectionString;
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					rsData.Read();
					TID = rsData.GetInt32(0);
				}
				else
				{
					MessageBox.Show((string) ("Did not find the Thesaurus listed in the DB - aborting: " + ThesaurusName));
					ProjectData.EndApp();
				}
				
			}
			catch (Exception ex)
			{
				//xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
				if (dDebug)
				{
					Debug.Print(ex.Message);
				}
				LOG.WriteToArchiveLog((string) ("clsDatabase : getClassName : 3963 : " + ex.Message));
				return 0;
			}
			if (rsData.IsClosed)
			{
			}
			else
			{
				rsData.Close();
			}
			rsData = null;
			return TID;
		}
		public bool InsertChildWord(string RootID, string Token, int TokenID)
		{
			string ConnStr = getThesaurusConnectionString();
			bool B = false;
			string S = "";
			try
			{
				S = S + " INSERT INTO [RootChildren]";
				S = S + " ([Token]";
				S = S + " ,[TokenID]";
				S = S + " ,[RootID])";
				S = S + " VALUES";
				S = S + " (\'" + Token + "\'";
				S = S + " ," + TokenID.ToString();
				S = S + " ,\'" + RootID + "\')";
				
				B = this.ExecuteSqlNewConn(S, ConnStr);
			}
			catch (Exception ex)
			{
				B = false;
				Console.WriteLine(ex.Message);
				MessageBox.Show(ex.Message);
			}
			
			return B;
			
		}
		public bool RootWordExists(string RootToken)
		{
			string ConnStr = getThesaurusConnectionString();
			bool B = false;
			SqlDataReader rsData = null;
			int iCnt = -1;
			string S = "";
			try
			{
				S = "Select COUNT(*) FROM [Rootword] WHERE [RootToken] = \'" + RootToken + "\'";
				try
				{
					string CS = ThesaurusConnectionString;
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					rsData = command.ExecuteReader();
					if (rsData.HasRows)
					{
						rsData.Read();
						iCnt = rsData.GetInt32(0);
					}
				}
				catch (Exception ex)
				{
					//xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
					if (dDebug)
					{
						Debug.Print(ex.Message);
					}
					LOG.WriteToArchiveLog((string) ("clsDatabase : getClassName : 3963 : " + ex.Message));
					iCnt = -1;
				}
				if (rsData.IsClosed)
				{
				}
				else
				{
					rsData.Close();
				}
				rsData = null;
				return iCnt;
			}
			catch (Exception ex)
			{
				B = false;
				Console.WriteLine(ex.Message);
				MessageBox.Show(ex.Message);
			}
			if (iCnt > 0)
			{
				B = true;
			}
			else
			{
				B = false;
			}
			return B;
			
		}
		public int AddToken(string Token)
		{
			int TokenID = -1;
			TokenID = getTokenID(Token);
			if (TokenID > 0)
			{
				return TokenID;
			}
			string S = "";
			
		}
		
		public int getTokenID(string Token)
		{
			Token = UTIL.RemoveSingleQuotes(Token);
			int ID = 0;
			string S = "Select [TokenID] FROM [Tokens] where [Token] = \'" + Token + "\'";
			string ConnStr = getThesaurusConnectionString();
			bool B = false;
			SqlDataReader rsData = null;
			int iCnt = -1;
			try
			{
				string CS = ThesaurusConnectionString;
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				rsData = command.ExecuteReader();
				if (rsData.HasRows)
				{
					rsData.Read();
					iCnt = rsData.GetInt32(0);
				}
			}
			catch (Exception ex)
			{
				//xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
				if (dDebug)
				{
					Debug.Print(ex.Message);
				}
				LOG.WriteToArchiveLog((string) ("clsDatabase : getTokenID : 3963 : " + ex.Message));
				iCnt = -1;
			}
			if (rsData.IsClosed)
			{
			}
			else
			{
				rsData.Close();
			}
			rsData = null;
			return iCnt;
			
		}
		public bool ChildWordExists(string RootID, string Token, int TokenID)
		{
			string ConnStr = getThesaurusConnectionString();
			bool B = false;
			SqlDataReader rsData = null;
			int iCnt = -1;
			string S = "";
			try
			{
				S = S + "Select count(*)";
				S = S + "FROM [RootChildren] ";
				S = S + "where ";
				S = S + "[Token] = \'" + Token + "\'";
				S = S + "and [TokenID] = " + TokenID.ToString();
				S = S + "and [RootID] = \'" + RootID + "\'";
				try
				{
					string CS = ThesaurusConnectionString;
					SqlConnection CONN = new SqlConnection(CS);
					CONN.Open();
					SqlCommand command = new SqlCommand(S, CONN);
					rsData = command.ExecuteReader();
					if (rsData.HasRows)
					{
						rsData.Read();
						iCnt = rsData.GetInt32(0);
					}
				}
				catch (Exception ex)
				{
					//xTrace(12330, "clsDataBase:GetRowByKey", ex.Message)
					if (dDebug)
					{
						Debug.Print(ex.Message);
					}
					LOG.WriteToArchiveLog((string) ("clsDatabase : getClassName : 3963 : " + ex.Message));
					iCnt = -1;
				}
				if (rsData.IsClosed)
				{
				}
				else
				{
					rsData.Close();
				}
				rsData = null;
				return iCnt;
			}
			catch (Exception ex)
			{
				B = false;
				Console.WriteLine(ex.Message);
				MessageBox.Show(ex.Message);
			}
			if (iCnt > 0)
			{
				B = true;
			}
			else
			{
				B = false;
			}
			return B;
			
		}
		public bool InsertRootWord(string ThesaurusID, string RootToken, string RootID)
		{
			string ConnStr = getThesaurusConnectionString();
			bool B = false;
			string S = "";
			try
			{
				S = S + " INSERT INTO [ECM.Thesaurus].[dbo].[Rootword]";
				S = S + " (ThesaurusID, [RootToken]";
				S = S + " ,[RootID])";
				S = S + " VALUES ";
				S = S + " (\'" + ThesaurusID + "\'";
				S = S + " ,\'" + RootToken + "\'";
				S = S + " ,\'" + RootID + "\')";
				B = this.ExecuteSqlNewConn(S, ConnStr);
			}
			catch (Exception ex)
			{
				B = false;
				Console.WriteLine(ex.Message);
				MessageBox.Show(ex.Message);
			}
			
			return B;
			
		}
		public string getSynonyms(string ThesaurusID, string Token, ListBox lbSynonyms)
		{
			string ConnStr = getThesaurusConnectionString();
			bool B = false;
			SqlDataReader rsData = null;
			int iCnt = -1;
			string Synonyms = "";
			
			lbSynonyms.Items.Clear();
			
			string S = " SELECT     RootChildren.Token";
			S = S + " FROM       Rootword INNER JOIN";
			S = S + " RootChildren ON Rootword.RootID = RootChildren.RootID";
			S = S + " where  Rootword.RootToken = \'" + Token + "\'  and    ThesaurusID  = \'D7A21DA7-0818-4B75-8BBA-D0339D3E1D54\'";
			S = S + " order by RootChildren.Token";
			
			SqlDataReader rsSynonyms = null;
			//rsSynonyms = SqlQryNo'Session(S)
			rsSynonyms = SqlQry(S);
			if (rsSynonyms.HasRows)
			{
				while (rsSynonyms.Read())
				{
					Synonyms += (string) (rsSynonyms.GetValue(0).ToString() + ",");
					lbSynonyms.Items.Add(rsSynonyms.GetValue(0).ToString());
				}
			}
			if (Synonyms.Trim.Length)
			{
				Synonyms = Synonyms.Substring(0, Synonyms.Length - 1);
			}
			rsSynonyms.Close();
			rsSynonyms = null;
			
			return Synonyms;
		}
		public void getSynonyms(string ThesaurusID, string Token, ArrayList SynonymsArray, bool AppendToList)
		{
			string ConnStr = getThesaurusConnectionString();
			bool B = false;
			SqlDataReader rsData = null;
			int iCnt = -1;
			string Synonym = "";
			
			if (AppendToList == false)
			{
				SynonymsArray.Clear();
			}
			
			string S = " SELECT     RootChildren.Token";
			S = S + " FROM       Rootword INNER JOIN";
			S = S + " RootChildren ON Rootword.RootID = RootChildren.RootID";
			S = S + " where  Rootword.RootToken = \'" + Token + "\'  and    ThesaurusID  = \'" + ThesaurusID + "\'";
			S = S + " order by RootChildren.Token";
			
			SqlDataReader rsSynonyms = null;
			//rsSynonyms = SqlQryNo'Session(S)
			rsSynonyms = SqlQry(S);
			if (rsSynonyms.HasRows)
			{
				while (rsSynonyms.Read())
				{
					Synonym = rsSynonyms.GetValue(0).ToString().Trim();
					Console.WriteLine(Synonym);
					if (! SynonymsArray.Contains(Synonym))
					{
						SynonymsArray.Add(Synonym);
					}
					
				}
			}
			//If Synonyms .Trim.Length Then
			//    Synonyms  = Mid(Synonyms , 1, Synonyms .Length - 1)
			//End If
			rsSynonyms.Close();
			rsSynonyms = null;
			
		}
		public void getAllTokens(ListBox LB, string ThesaurusID)
		{
			LB.Items.Clear();
			string ConnStr = getThesaurusConnectionString();
			bool B = false;
			SqlDataReader rsData = null;
			int iCnt = -1;
			string Synonyms = "";
			
			string S = " select RootToken from Rootword order by RootToken ";
			SqlDataReader rsSynonyms = null;
			//rsSynonyms = SqlQryNo'Session(S)
			rsSynonyms = SqlQry(S);
			if (rsSynonyms.HasRows)
			{
				while (rsSynonyms.Read())
				{
					Synonyms = rsSynonyms.GetValue(0).ToString().Trim();
					LB.Items.Add(Synonyms);
				}
			}
			rsSynonyms.Close();
			rsSynonyms = null;
		}
		public void PopulateComboBox(ComboBox CB, string TblColName, string S)
		{
			
			bool TryAgain = false;
RETRY1:
			string ConnStr = getThesaurusConnectionString();
			SqlConnection tConn = new SqlConnection(ConnStr);
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
					CB.Items.Add(drDSRow[0].ToString());
				}
				if (iRowCnt == 0)
				{
					string SS = "insert into Thesaurus (ThesaurusName, ThesaurusID) values (\'Roget\', \'D7A21DA7-0818-4B75-8BBA-D0339D3E1D54\')";
					bool BB = ExecuteSqlNewConn(SS, ConnStr);
					MessageBox.Show("Please close and reopen the Search Assistant screen - there is a connectivity issue with the thesaurus.");
					return;
				}
				//Bind the DataTable to the ComboBox by setting the Combobox's DataSource property to the DataTable. To display the "Description" column in the Combobox's list, set the Combobox's DisplayMember property to the name of column. Likewise, to use the "Code" column as the value of an item in the Combobox set the ValueMember property.
				CB.DropDownStyle = ComboBoxStyle.DropDown;
				//CB.DataSource = dt
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
				if (tConn != null)
				{
					tConn.Close();
					tConn = null;
				}
				
			}
			catch (Exception ex)
			{
				if (dDebug)
				{
					Debug.Print((string) ("Error 2194.23: " + ex.Message));
				}
				LOG.WriteToArchiveLog((string) ("clsDB : PopulateComboBox : 1000 : " + ex.Message + "\r\n" + S + "\r\n" + ConnStr));
				if (ex.Message.IndexOf("XX") + 1 && TryAgain == false)
				{
					My.Settings.Default["UserThesaurusConnString"] = "?";
					LOG.WriteToArchiveLog("clsDB : PopulateComboBox : 1000a : try again using APP Config.");
					TryAgain = true;
					goto RETRY1;
				}
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
	}
	
	
}

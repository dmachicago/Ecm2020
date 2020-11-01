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

using System.Data.SqlClient;
using System.IO;
using System.Threading;


namespace EcmArchiveClcSetup
{
	public class clsRemoteSupport
	{
		
		clsDma DMA = new clsDma();
		clsDatabase DB = new clsDatabase();
		clsHELPTEXT HELP = new clsHELPTEXT();
		clsEncrypt ENC = new clsEncrypt();
		
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		
		
		SortedList<string, DateTime> slRemoteHelp = new SortedList<string, DateTime>();
		
		string ScreenName = "";
		string HelpText = "";
		string WidgetName = "";
		string WidgetText = "";
		string DisplayHelpText = "";
		string LastUpdate = "";
		string CreateDate = "";
		string UpdatedBy = "";
		
		int RecordsAdded = 0;
		int RecordsUpdated = 0;
		int ErrorCnt = 0;
		
		string RemoteHelpConnStr = "";
		
		public clsRemoteSupport()
		{
			RemoteHelpConnStr = getRemoteHelpConnString();
		}
		public void getHelpQuiet()
		{
			Thread myThread = new Thread(new System.Threading.ThreadStart(UpdateHelp));
			myThread.Start();
		}
		public string getRemoteHelpConnString()
		{
			string RemoteHelpConnStr = "";
			RemoteHelpConnStr = DB.getHelpConnStr();
			RemoteHelpConnStr = ENC.AES256DecryptString(RemoteHelpConnStr);
			return RemoteHelpConnStr;
		}
		public bool isConnectedToInet()
		{
			bool B = DMA.isConnected();
			return B;
		}
		public bool isConnectedEcmLibrary()
		{
			int I = 0;
			I = getCountRemoteTable("helptext");
			if (I >= 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		public int getCountRemoteTable(string TableName)
		{
			
			try
			{
				int iCnt = 0;
				string S = (string) ("Select COUNT(*) from " + TableName);
				
				int I = 0;
				
				SqlDataReader rsColInfo = null;
				rsColInfo = DB.SqlQryNewConn(S, RemoteHelpConnStr);
				if (rsColInfo.HasRows)
				{
					while (rsColInfo.Read())
					{
						iCnt = rsColInfo.GetInt32(0);
					}
				}
				
				if (! rsColInfo.IsClosed)
				{
					rsColInfo.Close();
				}
				if (rsColInfo != null)
				{
					rsColInfo = null;
				}
				return iCnt;
			}
			catch (Exception ex)
			{
				//messagebox.show("getCountRemoteTable: Connection to remote server failed:" + vbCrLf + ex.Message)
				LOG.WriteToArchiveLog((string) ("getCountRemoteTable: Connection to remote server failed:" + "\r\n" + ex.Message));
			}
			return -1;
		}
		public DateTime getRemoteRowLastupdate(string ScreenName, string WidgetName)
		{
			
			try
			{
				string LastUpdate = "";
				string S = "Select [LastUpdate] FROM [HelpText] where ScreenName = \'" + ScreenName + "\' and WidgetName = \'" + WidgetName + "\'";
				int I = 0;
				SqlDataReader rsColInfo = null;
				
				rsColInfo = DB.SqlQryNewConn(S, RemoteHelpConnStr);
				if (rsColInfo.HasRows)
				{
					while (rsColInfo.Read())
					{
						LastUpdate = rsColInfo.GetValue(0).ToString();
					}
				}
				
				if (! rsColInfo.IsClosed)
				{
					rsColInfo.Close();
				}
				if (rsColInfo != null)
				{
					rsColInfo = null;
				}
				return DateTime.Parse(LastUpdate);
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("getRemoteRowLastupdate: Connection to remote server failed:" + "\r\n" + ex.Message));
				LOG.WriteToArchiveLog((string) ("getRemoteRowLastupdate: Connection to remote server failed:" + "\r\n" + ex.Message));
			}
			
			return Convert.ToDateTime(null);
			
		}
		public bool ckRemoteConnection()
		{
			
			bool B = false;
			
			try
			{
				int iCnt = 0;
				string S = "Select COUNT(*) from helptext";
				
				int I = 0;
				
				SqlDataReader rsColInfo = null;
				//rsColInfo = SqlQryNo'Session(S)
				rsColInfo = DB.SqlQryNewConn(S, RemoteHelpConnStr);
				if (rsColInfo.HasRows)
				{
					while (rsColInfo.Read())
					{
						iCnt = rsColInfo.GetInt32(0);
					}
				}
				
				if (! rsColInfo.IsClosed)
				{
					rsColInfo.Close();
				}
				if (rsColInfo != null)
				{
					rsColInfo = null;
				}
				B = true;
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Connection to remote server failed:" + "\r\n" + ex.Message));
				LOG.WriteToArchiveLog((string) ("Connection to remote server failed:" + "\r\n" + ex.Message));
				B = false;
			}
			
			return B;
		}
		public void UpdateHelp()
		{
			
			bool DoNotDoThisAnyLonger = true;
			
			if (DoNotDoThisAnyLonger == true)
			{
				return;
			}
			
			bool B = false;
			B = ckLookupTblNeedsUpdate("HelpText");
			if (B)
			{
				LOG.WriteToArchiveLog("Help update needed.");
				PushHelpToServer();
				PullHelpFromServer();
				//log.WriteToArchiveLog("Help last updated: " + Now.ToString)
			}
			else
			{
				LOG.WriteToArchiveLog("clsRemoteSupport:UpdateHelp - Help update checked and not needed.");
			}
			
		}
		
		public bool ckLookupTblNeedsUpdate(string TableName)
		{
			
			if (! isConnectedToInet())
			{
				LOG.WriteToArchiveLog("Not connected to the internet.");
				return false;
			}
			else
			{
				LOG.WriteToArchiveLog("Connected to the internet.");
			}
			if (! isConnectedEcmLibrary())
			{
				LOG.WriteToArchiveLog("Not connected to EcmLibrary.com.");
				return false;
			}
			else
			{
				LOG.WriteToArchiveLog("Connected to EcmLibrary.com.");
			}
			
			bool B = false;
			int NbrLocalHelpRecs = 0;
			DateTime LastLocalHelpUpdate = DateTime.Now;
			int NbrRemoteHelpRecs = 0;
			DateTime LastRemoteHelpUpdate = DateTime.Now;
			
			ckGetHelpUpdateEvalParms(TableName, RemoteHelpConnStr, ref NbrRemoteHelpRecs, ref LastLocalHelpUpdate);
			
			string LocalConnStr = DB.getGateWayConnStr(modGlobals.gGateWayID);
			ckGetHelpUpdateEvalParms(TableName, LocalConnStr, ref NbrLocalHelpRecs, ref LastRemoteHelpUpdate);
			
			if (NbrLocalHelpRecs != NbrRemoteHelpRecs)
			{
				B = true;
			}
			if (LastLocalHelpUpdate != LastRemoteHelpUpdate)
			{
				B = true;
			}
			return B;
		}
		public void ckGetHelpUpdateEvalParms(string TableName, string ConnStr, ref int NbrHelpRecs, ref DateTime LastHelpUpdate)
		{
			bool UpdateHelp = false;
			string S = " SELECT count(*) as TotRecs ,max([LastUpdate]) as LastUpdate    ";
			S = S + " FROM " + TableName + " "; //** [HelpText]
			int iCnt = 0;
			DateTime LastDate = DateTime.Parse("01/01/1980");
			
			try
			{
				
				SqlDataReader rsColInfo = null;
				rsColInfo = DB.SqlQryNewConn(S, ConnStr);
				if (rsColInfo.HasRows)
				{
					while (rsColInfo.Read())
					{
						iCnt = rsColInfo.GetInt32(0);
						LastDate = rsColInfo.GetDateTime(1);
					}
				}
				
				if (! rsColInfo.IsClosed)
				{
					rsColInfo.Close();
				}
				if (rsColInfo != null)
				{
					rsColInfo = null;
				}
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("ckLookupTblNeedsUpdate: Error:" + "\r\n" + ex.Message));
				LOG.WriteToArchiveLog((string) ("ckLookupTblNeedsUpdate: Error:" + "\r\n" + ex.Message));
			}
			
			NbrHelpRecs = iCnt;
			LastHelpUpdate = LastDate;
			
		}
		public bool LoadRemoteSortedList()
		{
			
			bool BB = false;
			
			slRemoteHelp.Clear();
			//RemoteHelpConnStr  = DB.getHelpConnStr()
			
			if (RemoteHelpConnStr.Trim.Length == 0)
			{
				LOG.WriteToArchiveLog("clsRemoteSupport:LoadRemoteSortedList - Could not retrieve the CONNECTION STRING for the remote help server, aborting - contact an administrator.");
				return false;
			}
			
			int iCnt = 0;
			iCnt = getCountRemoteTable("helptext");
			
			if (iCnt == 0)
			{
				return true;
			}
			
			int II = 0;
			string GetRemoteHelpSQL = "";
			
			GetRemoteHelpSQL = GetRemoteHelpSQL + " Select [ScreenName]";
			GetRemoteHelpSQL = GetRemoteHelpSQL + " ,[HelpText]";
			GetRemoteHelpSQL = GetRemoteHelpSQL + " ,[WidgetName]";
			GetRemoteHelpSQL = GetRemoteHelpSQL + " ,[WidgetText]";
			GetRemoteHelpSQL = GetRemoteHelpSQL + " ,[DisplayHelpText]";
			GetRemoteHelpSQL = GetRemoteHelpSQL + " ,[LastUpdate]";
			GetRemoteHelpSQL = GetRemoteHelpSQL + " ,[CreateDate]";
			GetRemoteHelpSQL = GetRemoteHelpSQL + " ,[UpdatedBy]";
			GetRemoteHelpSQL = GetRemoteHelpSQL + " FROM [HelpText] ";
			
			int KK = 0;
			SqlDataReader rsRemoteHelp = null;
			//rsRemoteHelp = SqlQryNo'Session(S)
			rsRemoteHelp = DB.SqlQryNewConn(GetRemoteHelpSQL, RemoteHelpConnStr);
			if (rsRemoteHelp.HasRows)
			{
				try
				{
					while (rsRemoteHelp.Read())
					{
						II++;
						KK++;
						//If II = 99 Then
						//    Console.WriteLine("Here 00101 ")
						//End If
						ScreenName = gcStr(rsRemoteHelp, 0);
						HelpText = gcStr(rsRemoteHelp, 1);
						WidgetName = gcStr(rsRemoteHelp, 2);
						WidgetText = gcStr(rsRemoteHelp, 3);
						DisplayHelpText = gcStr(rsRemoteHelp, 4);
						if (DisplayHelpText.Equals("1"))
						{
						}
						else if (DisplayHelpText.Equals("0"))
						{
						}
						else if (DisplayHelpText.Equals("-1"))
						{
						}
						else if (DisplayHelpText.ToUpper().Equals("TRUE"))
						{
							DisplayHelpText = "1";
						}
						else
						{
							DisplayHelpText = "0";
						}
						LastUpdate = gcStr(rsRemoteHelp, 5);
						CreateDate = gcStr(rsRemoteHelp, 6);
						UpdatedBy = gcStr(rsRemoteHelp, 7);
						
						Application.DoEvents();
						string tKey = ScreenName.Trim + Strings.Chr(254) + WidgetName;
						if (slRemoteHelp.IndexOfKey(tKey) >= 0)
						{
						}
						else
						{
							slRemoteHelp.Add(tKey, DateTime.Parse(LastUpdate));
						}
					}
				}
				catch (Exception)
				{
					//messagebox.show("clsRemoteSupport:LoadRemoteSortedList - Failed to read help record for: " + ScreenName  + ":" + WidgetName  + ".")
					LOG.WriteToArchiveLog("clsRemoteSupport:LoadRemoteSortedList - Failed to read help record for: " + ScreenName + ":" + WidgetName + ".");
				}
				
			}
			rsRemoteHelp.Close();
			rsRemoteHelp = null;
			
		}
		public void PushHelpToServer()
		{
			
			bool BB = ckRemoteConnection();
			if (! BB)
			{
				return;
			}
			
			LoadRemoteSortedList();
			
			if (RemoteHelpConnStr.Trim.Length == 0)
			{
				LOG.WriteToArchiveLog("clsRemoteSupport:PushHelpToServer - Could not retrieve the CONNECTION STRING for the remote help server, aborting - contact an administrator.");
				return;
			}
			
			int iCnt = 0;
			iCnt = getCountLocalTable("helptext");
			
			int II = 0;
			string S = "";
			
			S = S + " Select [ScreenName]";
			S = S + " ,[HelpText]";
			S = S + " ,[WidgetName]";
			S = S + " ,[WidgetText]";
			S = S + " ,[DisplayHelpText]";
			S = S + " ,[LastUpdate]";
			S = S + " ,[CreateDate]";
			S = S + " ,[UpdatedBy]";
			S = S + " FROM [HelpText] order by [LastUpdate] desc ";
			
			SqlDataReader RSData = null;
			//RSData = SqlQryNo'Session(S)
			string CS = DB.getGateWayConnStr(modGlobals.gGateWayID);
			SqlConnection CONN = new SqlConnection(CS);
			CONN.Open();
			SqlCommand command = new SqlCommand(S, CONN);
			RSData = command.ExecuteReader();
			if (RSData.HasRows)
			{
				try
				{
					while (RSData.Read())
					{
						II++;
						//** All of the below variables are public to the entire class
						ScreenName = RSData.GetValue(0).ToString();
						HelpText = RSData.GetValue(1).ToString();
						WidgetName = RSData.GetValue(2).ToString();
						WidgetText = RSData.GetValue(3).ToString();
						DisplayHelpText = RSData.GetValue(4).ToString();
						LastUpdate = RSData.GetValue(5).ToString();
						CreateDate = RSData.GetValue(6).ToString();
						UpdatedBy = RSData.GetValue(7).ToString();
						
						Application.DoEvents();
						
						publishRemoteHelpKey(DisplayHelpText, ScreenName, WidgetName);
					}
				}
				catch (Exception)
				{
					//messagebox.show("clsRemoteSupport:PushHelpToServer - Failed to read help record for: " + ScreenName  + ":" + WidgetName  + ".")
					LOG.WriteToArchiveLog("clsRemoteSupport:PushHelpToServer - Failed to read help record for: " + ScreenName + ":" + WidgetName + ".");
				}
				
			}
			RSData.Close();
			RSData = null;
			string msg = "";
			msg = (string) ("Upload Complete - Records Added: " + RecordsAdded.ToString());
			msg = msg + ", Records Updated: " + RecordsUpdated.ToString();
			msg = msg + ", Errors: " + ErrorCnt.ToString();
			LOG.WriteToArchiveLog(msg);
		}
		/// <summary>
		/// Get value from Sql Data Reader Column as string
		/// </summary>
		/// <param name="rsRemoteHelp"></param>
		/// <returns></returns>
		/// <remarks></remarks>
		public string gcStr(SqlDataReader SDR, int ColNbr)
		{
			string tVal = "";
			try
			{
				//RSData.GetValue(7).ToString
				tVal = SDR.GetValue(ColNbr).ToString();
			}
			catch (Exception ex)
			{
				tVal = "";
				Console.WriteLine(ex.ToString());
			}
			return tVal;
		}
		public int getCountLocalTable(string TableName)
		{
			int iCnt = 0;
			string S = (string) ("Select COUNT(*) from " + TableName);
			
			DB.CloseConn();
			DB.CkConn();
			int I = 0;
			
			SqlDataReader rsColInfo = null;
			//rsColInfo = SqlQryNo'Session(S)
			rsColInfo = DB.SqlQryNewConn(S);
			if (rsColInfo.HasRows)
			{
				while (rsColInfo.Read())
				{
					iCnt = rsColInfo.GetInt32(0);
				}
			}
			
			if (! rsColInfo.IsClosed)
			{
				rsColInfo.Close();
			}
			if (rsColInfo != null)
			{
				rsColInfo = null;
			}
			return iCnt;
		}
		public bool publishRemoteHelpKey(string DisplayHelpText, string ScreenName, string WidgetName)
		{
			bool BB = false;
			bool B = false;
			
			string NowUser = LOG.getEnvVarUserID();
			if (DisplayHelpText.ToUpper().Equals("TRUE"))
			{
				DisplayHelpText = "1";
			}
			else
			{
				DisplayHelpText = "0";
			}
			
			B = ckRecordExists(ScreenName, WidgetName);
			if (B)
			{
				B = ckRecordNeedsUpdating(ScreenName, WidgetName);
				if (B)
				{
					//** Update the help
					//** Update the help
					string UpdateSql = "";
					UpdateSql = UpdateSql + " UPDATE [HelpText]";
					UpdateSql = UpdateSql + " SET ";
					UpdateSql = UpdateSql + "  [HelpText] = \'" + HelpText + "\' ";
					UpdateSql = UpdateSql + " ,[DisplayHelpText] = " + DisplayHelpText;
					UpdateSql = UpdateSql + " ,[WidgetText] = \'" + WidgetText + "\'";
					UpdateSql = UpdateSql + " ,[LastUpdate] = \'" + LastUpdate + "\'";
					UpdateSql = UpdateSql + " ,[UpdatedBy] = \'" + NowUser + "\'";
					UpdateSql = UpdateSql + " WHERE ";
					UpdateSql = UpdateSql + " ScreenName = \'" + ScreenName + "\' ";
					UpdateSql = UpdateSql + " and WidgetName = \'" + WidgetName + "\' ";
					
					BB = DB.ExecuteSqlNewConn(UpdateSql, bool.Parse(RemoteHelpConnStr));
					if (! BB)
					{
						LOG.WriteToArchiveLog("frmHelpEditor : btnPushToServer_Click - Failed to update help record for: " + ScreenName + ":" + WidgetName + ".");
						ErrorCnt++;
					}
					else
					{
						RecordsUpdated++;
					}
				}
			}
			else
			{
				//** Insert the help
				HELP.setDisplayhelptext(ref DisplayHelpText);
				HELP.setHelptext(ref HelpText);
				HELP.setLastupdate(DateTime.Now.ToString());
				HELP.setScreenname(ref ScreenName);
				HELP.setUpdatedby(ref NowUser);
				HELP.setWidgetname(ref WidgetName);
				HELP.setWidgettext(ref WidgetText);
				BB = HELP.InsertRemote(RemoteHelpConnStr);
				if (! BB)
				{
					MessageBox.Show("frmHelpEditor : btnPushToServer_Click - 005 Failed to ADD help record for: " + ScreenName + ":" + WidgetName + ".");
					LOG.WriteToArchiveLog("frmHelpEditor : btnPushToServer_Click - 006 Failed to ADD help record for: " + ScreenName + ":" + WidgetName + ".");
					ErrorCnt++;
				}
				else
				{
					RecordsAdded++;
				}
			}
			
			return B;
			
		}
		public bool ckRecordExists(string ScreenName, string WidgetName)
		{
			bool B = false;
			string tKey = ScreenName.Trim() + Strings.Chr(254) + WidgetName.Trim();
			
			int I = slRemoteHelp.IndexOfKey(tKey);
			
			if (I >= 0)
			{
				B = true;
			}
			
			return B;
		}
		public bool ckRecordNeedsUpdating(string ScreenName, string WidgetName)
		{
			bool B = false;
			string tKey = ScreenName.Trim() + Strings.Chr(254) + WidgetName.Trim();
			DateTime LastUpdateDate;
			
			int idx = slRemoteHelp.IndexOfKey(tKey);
			if (idx >= 0)
			{
			}
			else
			{
				return true;
			}
			LastUpdateDate = slRemoteHelp[tKey];
			
			if (DateTime.Parse(LastUpdate) > LastUpdateDate)
			{
				B = true;
			}
			
			return B;
		}
		public void PullHelpFromServer()
		{
			
			RecordsAdded = 0;
			RecordsUpdated = 0;
			ErrorCnt = 0;
			//RemoteHelpConnStr  = DB.getHelpConnStr()
			if (RemoteHelpConnStr.Trim.Length == 0)
			{
				MessageBox.Show("clsRemoteSupport:PullHelpFromServer - Could not retrieve the CONNECTION STRING for the remote help server, aborting - contact an administrator.");
				LOG.WriteToArchiveLog("clsRemoteSupport:PullHelpFromServer - Failed to read help record for: " + ScreenName + ":" + WidgetName + ".");
				return;
			}
			
			bool BB = ckRemoteConnection();
			if (! BB)
			{
				return;
			}
			
			LoadLocalSortedList();
			
			int iCnt = 0;
			iCnt = getCountLocalTable("helptext");
			
			int II = 0;
			
			string RemoteSQL = "";
			RemoteSQL = RemoteSQL + " Select [ScreenName]";
			RemoteSQL = RemoteSQL + " ,[HelpText]";
			RemoteSQL = RemoteSQL + " ,[WidgetName]";
			RemoteSQL = RemoteSQL + " ,[WidgetText]";
			RemoteSQL = RemoteSQL + " ,[DisplayHelpText]";
			RemoteSQL = RemoteSQL + " ,[LastUpdate]";
			RemoteSQL = RemoteSQL + " ,[CreateDate]";
			RemoteSQL = RemoteSQL + " ,[UpdatedBy]";
			RemoteSQL = RemoteSQL + " FROM [HelpText] ";
			int KK = 0;
			SqlDataReader rsRemoteHelp = null;
			//rsRemoteHelp = SqlQryNo'Session(S)
			rsRemoteHelp = DB.SqlQryNewConn(RemoteSQL, RemoteHelpConnStr);
			if (rsRemoteHelp.HasRows)
			{
				try
				{
					while (rsRemoteHelp.Read())
					{
						II++;
						KK++;
						//** All of the below variables are public to the entire class
						ScreenName = rsRemoteHelp.GetValue(0).ToString();
						HelpText = rsRemoteHelp.GetValue(1).ToString();
						WidgetName = rsRemoteHelp.GetValue(2).ToString();
						WidgetText = rsRemoteHelp.GetValue(3).ToString();
						DisplayHelpText = rsRemoteHelp.GetValue(4).ToString();
						if (DisplayHelpText.Equals("1"))
						{
						}
						else if (DisplayHelpText.Equals("0"))
						{
						}
						else if (DisplayHelpText.Equals("-1"))
						{
						}
						else if (DisplayHelpText.ToUpper().Equals("TRUE"))
						{
							DisplayHelpText = "1";
						}
						else
						{
							DisplayHelpText = "0";
						}
						LastUpdate = rsRemoteHelp.GetValue(5).ToString();
						CreateDate = rsRemoteHelp.GetValue(6).ToString();
						UpdatedBy = rsRemoteHelp.GetValue(7).ToString();
						
						publishLocalHelpKey(ScreenName, WidgetName);
						
						Application.DoEvents();
						
					}
				}
				catch (Exception)
				{
					MessageBox.Show("frmHelpEditor : btnPushToServer_Click - Failed to read help record for: " + ScreenName + ":" + WidgetName + ".");
					LOG.WriteToArchiveLog("frmHelpEditor : btnPushToServer_Click - Failed to read help record for: " + ScreenName + ":" + WidgetName + ".");
				}
				
			}
			rsRemoteHelp.Close();
			rsRemoteHelp = null;
			
			string Msg = "";
			Msg = (string) ("HELP Download Complete - RecordsAdded: " + RecordsAdded.ToString());
			Msg = Msg + ", RecordsUpdated: " + RecordsUpdated.ToString();
			Msg = Msg + ", Errors: " + ErrorCnt.ToString();
			LOG.WriteToArchiveLog(Msg);
		}
		public bool LoadLocalSortedList()
		{
			try
			{
				bool BB = false;
				
				slRemoteHelp.Clear();
				
				int iCnt = 0;
				iCnt = getCountLocalTable("helptext");
				
				int II = 0;
				string S = "";
				
				S = S + " Select [ScreenName]";
				S = S + " ,[HelpText]";
				S = S + " ,[WidgetName]";
				S = S + " ,[WidgetText]";
				S = S + " ,[DisplayHelpText]";
				S = S + " ,[LastUpdate]";
				S = S + " ,[CreateDate]";
				S = S + " ,[UpdatedBy]";
				S = S + " FROM [HelpText] ";
				int KK = 0;
				SqlDataReader RSData = null;
				
				string CS = getRemoteHelpConnString();
				SqlConnection CONN = new SqlConnection(CS);
				CONN.Open();
				SqlCommand command = new SqlCommand(S, CONN);
				RSData = command.ExecuteReader();
				if (RSData.HasRows)
				{
					try
					{
						while (RSData.Read())
						{
							II++;
							KK++;
							ScreenName = RSData.GetValue(0).ToString();
							HelpText = RSData.GetValue(1).ToString();
							WidgetName = RSData.GetValue(2).ToString();
							WidgetText = RSData.GetValue(3).ToString();
							DisplayHelpText = RSData.GetValue(4).ToString();
							if (DisplayHelpText.Equals("1"))
							{
							}
							else if (DisplayHelpText.Equals("0"))
							{
							}
							else if (DisplayHelpText.Equals("-1"))
							{
							}
							else if (DisplayHelpText.ToUpper().Equals("TRUE"))
							{
								DisplayHelpText = "1";
							}
							else
							{
								DisplayHelpText = "0";
							}
							LastUpdate = RSData.GetValue(5).ToString();
							CreateDate = RSData.GetValue(6).ToString();
							UpdatedBy = RSData.GetValue(7).ToString();
							
							Application.DoEvents();
							string tKey = ScreenName.Trim + Strings.Chr(254) + WidgetName;
							if (slRemoteHelp.IndexOfKey(tKey) >= 0)
							{
							}
							else
							{
								slRemoteHelp.Add(tKey, DateTime.Parse(LastUpdate));
							}
						}
					}
					catch (Exception)
					{
						//messagebox.show("clsRemoteSupport:LoadLocalSortedList - Failed to read help record for: " + ScreenName  + ":" + WidgetName  + ".")
						LOG.WriteToArchiveLog("clsRemoteSupport:LoadLocalSortedList - Failed to read help record for: " + ScreenName + ":" + WidgetName + ".");
					}
					
				}
				RSData.Close();
				RSData = null;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsRemoteSupport : LoadLocalSortedList 100 " + ex.Message));
			}
			
		}
		public bool publishLocalHelpKey(string ScreenName, string WidgetName)
		{
			if (DisplayHelpText.ToUpper().Equals("TRUE"))
			{
				DisplayHelpText = "1";
			}
			else
			{
				DisplayHelpText = "0";
			}
			bool B = false;
			
			B = ckRecordExists(ScreenName, WidgetName);
			bool BB = false;
			string NowUser = LOG.getEnvVarUserID();
			//HELP.setUpdatedby(NowUser )
			if (B)
			{
				B = ckRecordNeedsUpdating(ScreenName, WidgetName);
				if (B)
				{
					//** Update the help
					string UpdateSql = "";
					UpdateSql = UpdateSql + " UPDATE [HelpText]" + "\r\n";
					UpdateSql = UpdateSql + " SET " + "\r\n";
					UpdateSql = UpdateSql + "  [HelpText] = \'" + HelpText + "\' " + "\r\n";
					UpdateSql = UpdateSql + " ,[DisplayHelpText] = " + DisplayHelpText + "\r\n";
					UpdateSql = UpdateSql + " ,[WidgetText] = \'" + WidgetText + "\' " + "\r\n";
					UpdateSql = UpdateSql + " ,[LastUpdate] = \'" + LastUpdate + "\'" + "\r\n";
					UpdateSql = UpdateSql + " ,[UpdatedBy] = \'" + NowUser + "\'" + "\r\n";
					UpdateSql = UpdateSql + " WHERE " + "\r\n";
					UpdateSql = UpdateSql + " ScreenName = \'" + ScreenName + "\' " + "\r\n";
					UpdateSql = UpdateSql + " and WidgetName = \'" + WidgetName + "\' ";
					
					BB = DB.ExecuteSqlNewConn(UpdateSql, false);
					if (! BB)
					{
						LOG.WriteToArchiveLog("frmHelpEditor : btnPushToServer_Click - Failed to update help record for: " + ScreenName + ":" + WidgetName + ".");
						ErrorCnt++;
					}
					else
					{
						RecordsUpdated++;
					}
				}
			}
			else
			{
				//** Insert the help
				HELP.setDisplayhelptext(ref DisplayHelpText);
				HELP.setHelptext(ref HelpText);
				HELP.setLastupdate(DateTime.Now.ToString());
				HELP.setScreenname(ref ScreenName);
				HELP.setUpdatedby(ref NowUser);
				HELP.setWidgetname(ref WidgetName);
				HELP.setWidgettext(ref WidgetText);
				BB = HELP.Insert();
				if (! BB)
				{
					//ErrorCnt += 1
					//messagebox.show("frmHelpEditor : btnPushToServer_Click - 007 Failed to ADD help record for: " + ScreenName  + ":" + WidgetName  + ".")
					LOG.WriteToArchiveLog("frmHelpEditor : btnPushToServer_Click - 008 Failed to ADD help record for: " + ScreenName + ":" + WidgetName + ".");
				}
				else
				{
					RecordsAdded++;
				}
			}
			
			return B;
			
		}
		public void UpdateHooverHelp()
		{
			RecordsAdded = 0;
			RecordsUpdated = 0;
			ErrorCnt = 0;
			//RemoteHelpConnStr  = DB.getHelpConnStr()
			if (RemoteHelpConnStr.Trim.Length == 0)
			{
				MessageBox.Show("clsRemoteSupport:UpdateHooverHelp - Could not retrieve the CONNECTION STRING for the remote help server, aborting - contact an administrator.");
				LOG.WriteToArchiveLog("clsRemoteSupport:UpdateHooverHelp - Could not retrieve the CONNECTION STRING for the remote help server, aborting - contact an administrator.");
				return;
			}
			
			bool BB = ckRemoteConnection();
			if (! BB)
			{
				MessageBox.Show("Update Hoover Help Failed to connect to remote server.");
				return;
			}
			
			LoadLocalSortedList();
			
			int iCnt = 0;
			iCnt = getCountLocalTable("helptext");
			
			//FrmMDIMain.TSPB1.Minimum = 0
			//FrmMDIMain.TSPB1.Maximum = iCnt + 10
			//FrmMDIMain.TSPB1.Value = 0
			int II = 0;
			
			string RemoteSQL = "";
			RemoteSQL = RemoteSQL + " Select [ScreenName]";
			RemoteSQL = RemoteSQL + " ,[HelpText]";
			RemoteSQL = RemoteSQL + " ,[WidgetName]";
			RemoteSQL = RemoteSQL + " ,[WidgetText]";
			RemoteSQL = RemoteSQL + " ,[DisplayHelpText]";
			RemoteSQL = RemoteSQL + " ,[LastUpdate]";
			RemoteSQL = RemoteSQL + " ,[CreateDate]";
			RemoteSQL = RemoteSQL + " ,[UpdatedBy]";
			RemoteSQL = RemoteSQL + " FROM [HelpText] ";
			int KK = 0;
			SqlDataReader rsRemoteHelp = null;
			//rsRemoteHelp = SqlQryNo'Session(S)
			rsRemoteHelp = DB.SqlQryNewConn(RemoteSQL, RemoteHelpConnStr);
			if (rsRemoteHelp.HasRows)
			{
				try
				{
					while (rsRemoteHelp.Read())
					{
						II++;
						KK++;
						//If II >= FrmMDIMain.TSPB1.Maximum Then
						//    II = 0
						//End If
						//FrmMDIMain.TSPB1.Value = II
						
						//** All of the below variables are public to the entire class
						ScreenName = rsRemoteHelp.GetValue(0).ToString();
						HelpText = rsRemoteHelp.GetValue(1).ToString();
						WidgetName = rsRemoteHelp.GetValue(2).ToString();
						WidgetText = rsRemoteHelp.GetValue(3).ToString();
						DisplayHelpText = rsRemoteHelp.GetValue(4).ToString();
						if (DisplayHelpText.Equals("1"))
						{
						}
						else if (DisplayHelpText.Equals("0"))
						{
						}
						else if (DisplayHelpText.Equals("-1"))
						{
						}
						else if (DisplayHelpText.ToUpper().Equals("TRUE"))
						{
							DisplayHelpText = "1";
						}
						else
						{
							DisplayHelpText = "0";
						}
						
						LastUpdate = rsRemoteHelp.GetValue(5).ToString();
						CreateDate = rsRemoteHelp.GetValue(6).ToString();
						UpdatedBy = rsRemoteHelp.GetValue(7).ToString();
						
						publishLocalHelpKey(ScreenName, WidgetName);
						
						Application.DoEvents();
						
					}
				}
				catch (Exception)
				{
					MessageBox.Show("frmHelpEditor : btnPushToServer_Click - Failed to read help record for: " + ScreenName + ":" + WidgetName + ".");
					LOG.WriteToArchiveLog("frmHelpEditor : btnPushToServer_Click - Failed to read help record for: " + ScreenName + ":" + WidgetName + ".");
				}
				
			}
			rsRemoteHelp.Close();
			rsRemoteHelp = null;
			//FrmMDIMain.TSPB1.Value = 0
			string Msg = "";
			Msg = (string) ("Hoover Help Download Complete - RecordsAdded: " + RecordsAdded.ToString());
			Msg = Msg + ", RecordsUpdated: " + RecordsUpdated.ToString();
			Msg = Msg + ", Errors: " + ErrorCnt.ToString();
			//FrmMDIMain.TSSB2.Text = Msg
		}
		public string getClientLicenseServer(string CompanyID, string LicenseID)
		{
			string ClientLicenseServer = "";
			try
			{
				string S = (string) ("Select MachineID, Applied from license where CompanyID = \'" + CompanyID + "\' and LicenseID = " + LicenseID);
				int I = 0;
				SqlDataReader rsColInfo = null;
				
				rsColInfo = DB.SqlQryNewConn(S, RemoteHelpConnStr);
				if (rsColInfo.HasRows)
				{
					rsColInfo.Read();
					ClientLicenseServer = rsColInfo.GetValue(0).ToString();
				}
				
				if (! rsColInfo.IsClosed)
				{
					rsColInfo.Close();
				}
				if (rsColInfo != null)
				{
					rsColInfo = null;
				}
				GC.Collect();
				GC.WaitForFullGCApproach();
				return ClientLicenseServer;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("getClientLicenseServer: Failed to retrieve Server ID:" + "\r\n" + ex.Message));
			}
			
			return ClientLicenseServer;
			
		}
		public string getAvailClientLicenseServerName(string CompanyID)
		{
			string ClientLicenseServer = "";
			bool isApplied = false;
			bool B = false;
			try
			{
				string S = "Select MachineID, Applied from license where CompanyID = \'" + CompanyID + "\'";
				int I = 0;
				SqlDataReader rsColInfo = null;
				
				rsColInfo = DB.SqlQryNewConn(S, RemoteHelpConnStr);
				if (rsColInfo.HasRows)
				{
					while (rsColInfo.Read())
					{
						ClientLicenseServer = rsColInfo.GetValue(0).ToString();
						isApplied = rsColInfo.GetBoolean(0);
						if (isApplied == false)
						{
							B = true;
							break;
						}
					}
					
				}
				
				if (! rsColInfo.IsClosed)
				{
					rsColInfo.Close();
				}
				if (rsColInfo != null)
				{
					rsColInfo = null;
				}
				GC.Collect();
				GC.WaitForFullGCApproach();
				if (B == true)
				{
				}
				else
				{
					ClientLicenseServer = "";
				}
				return ClientLicenseServer;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("getClientLicenseServer: Failed to retrieve Server ID:" + "\r\n" + ex.Message));
			}
			
			return ClientLicenseServer;
			
		}
		public bool setClientLicenseServer(string CompanyID, string LicenseID, string MachineID)
		{
			string ClientLicenseServer = "";
			bool B = false;
			try
			{
				string S = "Update License set MachineID = \'" + MachineID + "\' ";
				S = S + "where CompanyID = \'" + CompanyID + "\' and LicenseID = " + LicenseID;
				B = DB.ExecuteSqlNewConn(S, RemoteHelpConnStr, false);
				GC.Collect();
				GC.WaitForFullGCApproach();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("setClientLicenseServer: Failed to set Server ID:" + "\r\n" + ex.Message));
			}
			return B;
			
		}
		
		public bool getClientLicenses(string CompanyID, DataGridView dg)
		{
			string ClientLicenseServer = "";
			bool isApplied = false;
			bool B = false;
			
			string LicenseID = "";
			string MachineID = "";
			string LicenseTypeCode = "";
			string Applied = "";
			string EncryptedLicense = "";
			string SupportActiveDate = "";
			string SupportInactiveDate = "";
			string PurchasedMachines = "";
			string PurchasedUsers = "";
			string SupportActive = "";
			string LicenseText = "";
			
			string ServerNAME = "";
			string SqlInstanceName = "";
			
			try
			{
				string S = "Select ";
				S = S + " CompanyID,";
				S = S + " MachineID,";
				S = S + " LicenseId,";
				S = S + " Applied,";
				S = S + " PurchasedMachines,";
				S = S + " PurchasedUsers,";
				S = S + " SupportActive,";
				S = S + " SupportActiveDate,";
				S = S + " SupportInactiveDate,";
				S = S + " LicenseText,";
				S = S + " LicenseTypeCode,";
				S = S + " EncryptedLicense, ServerNAME, SqlInstanceName";
				S = S + " from License	";
				S = S + " where CompanyID = \'" + CompanyID + "\' ";
				int I = 0;
				SqlDataReader rsColInfo = null;
				
				dg.Columns.Clear();
				dg.Rows.Clear();
				dg.Columns.Add("CompanyID", "CompanyID");
				dg.Columns.Add("MachineID", "MachineID");
				dg.Columns.Add("LicenseId", "LicenseId");
				dg.Columns.Add("Applied", "Applied");
				dg.Columns.Add("PurchasedMachines", "PurchasedMachines");
				dg.Columns.Add("PurchasedUsers", "PurchasedUsers");
				dg.Columns.Add("SupportActive", "SupportActive");
				dg.Columns.Add("SupportActiveDate", "SupportActiveDate");
				dg.Columns.Add("SupportInactiveDate", "SupportInactiveDate");
				dg.Columns.Add("LicenseText", "LicenseText");
				dg.Columns.Add("LicenseTypeCode", "LicenseTypeCode");
				dg.Columns.Add("EncryptedLicense", "EncryptedLicense");
				dg.Columns.Add("ServerName", "ServerName");
				dg.Columns.Add("SqlInstanceName", "SqlInstanceName");
				
				rsColInfo = DB.SqlQryNewConn(S, RemoteHelpConnStr);
				if (rsColInfo.HasRows)
				{
					while (rsColInfo.Read())
					{
						dg.Rows.Add();
						int MaxRowNbr = dg.Rows.Count - 1;
						
						CompanyID = rsColInfo.GetValue(0).ToString();
						MachineID = rsColInfo.GetValue(1).ToString();
						LicenseID = rsColInfo.GetValue(2).ToString();
						Applied = rsColInfo.GetValue(3).ToString();
						PurchasedMachines = rsColInfo.GetValue(4).ToString();
						PurchasedUsers = rsColInfo.GetValue(5).ToString();
						SupportActive = rsColInfo.GetValue(6).ToString();
						SupportActiveDate = rsColInfo.GetValue(7).ToString();
						SupportInactiveDate = rsColInfo.GetValue(8).ToString();
						LicenseText = rsColInfo.GetValue(9).ToString();
						LicenseTypeCode = rsColInfo.GetValue(10).ToString();
						EncryptedLicense = rsColInfo.GetValue(11).ToString();
						ServerNAME = rsColInfo.GetValue(12).ToString();
						SqlInstanceName = rsColInfo.GetValue(13).ToString();
						
						dg.Rows[MaxRowNbr].Cells["CompanyID"].Value = CompanyID;
						
						dg.Rows[MaxRowNbr].Cells["MachineID"].Value = MachineID;
						dg.Rows[MaxRowNbr].Cells["LicenseId"].Value = LicenseID;
						dg.Rows[MaxRowNbr].Cells["Applied"].Value = Applied;
						dg.Rows[MaxRowNbr].Cells["PurchasedMachines"].Value = PurchasedMachines;
						dg.Rows[MaxRowNbr].Cells["PurchasedUsers"].Value = PurchasedUsers;
						dg.Rows[MaxRowNbr].Cells["SupportActive"].Value = SupportActive;
						dg.Rows[MaxRowNbr].Cells["SupportActiveDate"].Value = SupportActiveDate;
						dg.Rows[MaxRowNbr].Cells["SupportInactiveDate"].Value = SupportInactiveDate;
						dg.Rows[MaxRowNbr].Cells["LicenseText"].Value = LicenseText;
						dg.Rows[MaxRowNbr].Cells["LicenseTypeCode"].Value = LicenseTypeCode;
						dg.Rows[MaxRowNbr].Cells["EncryptedLicense"].Value = EncryptedLicense;
						dg.Rows[MaxRowNbr].Cells["ServerNAME"].Value = ServerNAME;
						dg.Rows[MaxRowNbr].Cells["SqlInstanceName"].Value = SqlInstanceName;
					}
				}
				else
				{
					MessageBox.Show("License not found, please insure the required Company ID and other information is correct.");
				}
				
				if (! rsColInfo.IsClosed)
				{
					rsColInfo.Close();
				}
				if (rsColInfo != null)
				{
					rsColInfo = null;
				}
				GC.Collect();
				GC.WaitForFullGCApproach();
				LOG.WriteToArchiveLog((string) ("getClientLicenses: Retrieve Server license:" + DateTime.Now.ToString()));
				B = true;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("getClientLicenses: Failed to retrieve Server data:" + "\r\n" + ex.Message));
				B = false;
			}
			
			return B;
			
		}
		public bool ckCompanyID(string CompanyID)
		{
			string ClientLicenseServer = "";
			bool B = false;
			int I = 0;
			try
			{
				string S = "Select count(*) from license ";
				S = S + "where CompanyID = \'" + CompanyID + "\'";
				//B = DB.ExecuteSqlNewConn(S, RemoteHelpConnStr , False)
				
				SqlDataReader rsColInfo = null;
				
				rsColInfo = DB.SqlQryNewConn(S, RemoteHelpConnStr);
				if (rsColInfo.HasRows)
				{
					rsColInfo.Read();
					I = rsColInfo.GetInt32(0);
				}
				
				if (I > 0)
				{
					B = true;
				}
				else
				{
					B = false;
				}
				
				GC.Collect();
				GC.WaitForFullGCApproach();
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("setClientLicenseServer: Failed to set Server ID:" + "\r\n" + ex.Message));
			}
			return B;
		}
		public string getClientLicense(string CompanyID, string LicenseID)
		{
			string ServerLicense = "";
			try
			{
				string S = (string) ("Select EncryptedLicense from license where CompanyID = \'" + CompanyID + "\' and LicenseID = " + LicenseID);
				int I = 0;
				SqlDataReader rsColInfo = null;
				
				rsColInfo = DB.SqlQryNewConn(S, RemoteHelpConnStr);
				if (rsColInfo.HasRows)
				{
					rsColInfo.Read();
					ServerLicense = rsColInfo.GetValue(0).ToString();
				}
				
				if (! rsColInfo.IsClosed)
				{
					rsColInfo.Close();
				}
				if (rsColInfo != null)
				{
					rsColInfo = null;
				}
				GC.Collect();
				GC.WaitForFullGCApproach();
				return ServerLicense;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("getClientLicenseServer: Failed to retrieve Server ID:" + "\r\n" + ex.Message));
			}
			
			return ServerLicense;
			
		}
		public bool getLicenseServerName(string CompanyID, ref string ServerName, ref string SqlInstanceName)
		{
			bool B = false;
			try
			{
				string S = "Select MachineID, ServerName, SqlInstanceName from license ";
				S = S + " where CompanyID = \'" + CompanyID + "\'";
				S = S + " and ServerName = \'" + ServerName + "\' ";
				S = S + " and SqlInstanceName = \'" + SqlInstanceName + "\' ";
				int I = 0;
				SqlDataReader rsColInfo = null;
				
				rsColInfo = DB.SqlQryNewConn(S, RemoteHelpConnStr);
				if (rsColInfo.HasRows)
				{
					rsColInfo.Read();
					ServerName = rsColInfo.GetValue(1).ToString();
					SqlInstanceName = rsColInfo.GetValue(2).ToString();
				}
				
				if (! rsColInfo.IsClosed)
				{
					rsColInfo.Close();
				}
				if (rsColInfo != null)
				{
					rsColInfo = null;
				}
				GC.Collect();
				GC.WaitForFullGCApproach();
				
				return true;
			}
			catch (Exception ex)
			{
				B = false;
				LOG.WriteToArchiveLog((string) ("getClientLicenseServer: Failed to retrieve Server ID:" + "\r\n" + ex.Message));
			}
			
			return B;
			
		}
		//Function ckRemoteConnection() As Boolean
		//    Dim ClientLicenseServer  = ""
		//    Dim B As Boolean = False
		//    Dim I As Integer = 0
		//    Try
		//        Dim S  = "Select count(*) from license "
		//        Dim rsColInfo As SqlDataReader = Nothing
		
		//        rsColInfo = DB.SqlQryNewConn(S, RemoteHelpConnStr )
		//        If rsColInfo.HasRows Then
		//            rsColInfo.Read()
		//            I = rsColInfo.GetInt32(0)
		//        End If
		
		//        B = True
		
		//        GC.Collect()
		//        GC.WaitForFullGCApproach()
		//    Catch ex As Exception
		//        log.WriteToArchiveLog("setClientLicenseServer: Failed to set Server ID:" + vbCrLf + ex.Message)
		//    End Try
		//    Return B
		//End Function
		
		
	}
	
}

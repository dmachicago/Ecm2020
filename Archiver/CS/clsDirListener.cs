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

using System.IO;
using System.Data.SqlClient;
using System.Threading;
using Microsoft.VisualBasic.CompilerServices;



namespace EcmArchiveClcSetup
{
	public class clsDirListener
	{
		public clsDirListener()
		{
			// VBConversions Note: Non-static class variable initialization is below.  Class variables cannot be initially assigned non-static values in C#.
			CS = (string) (My.Settings.Default.UserDefaultConnString.ToString());
			
		}
		//Inherits clsArchiver
		public bool BUSY = false;
		int ThreadCnt = 0;
		SqlConnection SCONN = null;
		clsLogging LOG = new clsLogging();
		clsUtility UTIL = new clsUtility();
		
		string CS; // VBConversions Note: Initial value of "(string) (My.Settings.Default.UserDefaultConnString.ToString())" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		private FileSystemWatcher watchfolder;
		private string _Directory = "";
		private string _DirGuid = "";
		private string _SourceFile = "";
		
		//Dim gFilesToArchive As New List(Of String)
		List<string> CopyOfFilesToArchive = new List<string>();
		private string _Machinename = "";
		
		public string SourceFile
		{
			get
			{
				return _SourceFile;
			}
			set
			{
				_SourceFile = value;
			}
		}
		public string DirGuid
		{
			get
			{
				return _DirGuid;
			}
			set
			{
				_DirGuid = value;
			}
		}
		public string WatchDirectory
		{
			get
			{
				return _Directory;
			}
			set
			{
				_Directory = value;
			}
		}
		public string Machinename
		{
			get
			{
				return _Machinename;
			}
			set
			{
				_Machinename = value;
			}
		}
		
		public bool ExecuteSqlNewConn(string sql)
		{
			bool rc = false;
			SqlConnection CN = new SqlConnection(CS);
			CN.Open();
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
						LOG.WriteToArchiveLog((string) ("It appears this user has DATA within the repository associated to them and cannot be deleted." + "\r\n" + "\r\n" + ex.Message));
					}
					else if (ex.Message.IndexOf("HelpText") + 1 > 0)
					{
						BB = true;
					}
					else if (ex.Message.IndexOf("duplicate key row") + 1 > 0)
					{
						//log.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 1464c1 : " + ex.Message)
						//log.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 1464c1 : " + sql)
						BB = true;
					}
					else if (ex.Message.IndexOf("duplicate key") + 1 > 0)
					{
						//log.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 1465c2 : " + ex.Message)
						//log.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 1464c2 : " + sql)
						BB = true;
					}
					else if (ex.Message.IndexOf("duplicate") + 1 > 0)
					{
						//log.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 1466c3 : " + ex.Message)
						//log.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 1464c3 : " + sql)
						BB = true;
					}
					else
					{
						//messagebox.show("Execute SQL: " + ex.Message + vbCrLf + "Please review the trace log." + vbCrLf + sql)
						BB = false;
						xTrace(885121, "ExecuteSqlNewConn 10: ", ex.Message.ToString());
						xTrace(885122, "ExecuteSqlNewConn 10: ", ex.StackTrace.ToString());
						xTrace(885123, "ExecuteSqlNewConn 10: ", sql.Substring(0, 2000));
						LOG.WriteToArchiveLog((string) ("clsDirListener : ExecuteSqlNewConn : 9442a1p1: " + ex.Message));
						LOG.WriteToArchiveLog((string) ("clsDirListener : ExecuteSqlNewConn : 9442a1p1: " + ex.StackTrace));
						LOG.WriteToArchiveLog("clsDirListener : ExecuteSqlNewConn : 9442a1p2: " + "\r\n" + sql + "\r\n");
					}
					
				}
			}
			
			
			if (CN.State == ConnectionState.Open)
			{
				CN.Close();
			}
			
			CN = null;
			dbCmd = null;
			GC.Collect();
			
			return BB;
		}
		public void CloseConn()
		{
			if (SCONN == null)
			{
			}
			else
			{
				if (SCONN.State == ConnectionState.Open)
				{
					SCONN.Close();
				}
				SCONN.Dispose();
			}
			GC.Collect();
		}
		
		public void CkConn()
		{
			if (SCONN == null)
			{
				try
				{
					SCONN = new SqlConnection();
					SCONN.ConnectionString = CS;
					SCONN.Open();
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("clsDirListener : CkConn : 338 : " + ex.Message));
				}
			}
			if (SCONN.State == System.Data.ConnectionState.Closed)
			{
				try
				{
					SCONN.ConnectionString = CS;
					SCONN.Open();
				}
				catch (Exception ex)
				{
					
					LOG.WriteToArchiveLog((string) ("clsDirListener : CkConn : 348 : " + ex.Message));
				}
			}
		}
		
		public int iCount(string S)
		{
			try
			{
				CloseConn();
				CkConn();
				int Cnt;
				SqlDataReader rsData = null;
				bool b = false;
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
				xTrace(12306, "clsDirListener:iCount", ex.Message);
				LOG.WriteToArchiveLog((string) ("ERROR 1993.21: " + ex.Message));
				LOG.WriteToArchiveLog((string) ("clsDirListener : iCount : 2054 : " + ex.Message));
				return -1;
			}
		}
		
		public SqlDataReader SqlQry(string sql)
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
				
				if (SCONN.State == System.Data.ConnectionState.Open)
				{
					SCONN.Close();
				}
				
				CloseConn();
				CkConn();
				
				SqlCommand command = new SqlCommand(sql, SCONN);
				
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
			
			return null;
			
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
				string mySql = "";
				PgmName = UTIL.RemoveSingleQuotes(PgmName);
				mySql = "INSERT INTO PgmTrace (StmtID ,PgmName, Stmt) VALUES(" + StmtID.ToString() + ", \'" + PgmName + "\',\'" + Stmt + "\')";
				bool b = this.ExecuteSqlNewConn(mySql);
				if (b == false)
				{
					//'Session("ErrMsg") = "StmtId Call: " + 'Session("ErrMsg")
					//'Session("ErrStack") = "StmtId Call Stack: " + ''Session("ErrStack")
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("clsDirListener : xTrace : 1907 : " + ex.Message));
			}
			
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
		
		//** Start the Listeners listening
		public void StartListening(bool IncludeSubDirs)
		{
			try
			{
				watchfolder = new System.IO.FileSystemWatcher();
				//Add a list of Filters we want to specify, making sure
				//you use OR for each Filter as we need to all of those
				watchfolder.NotifyFilter = System.IO.NotifyFilters.DirectoryName;
				watchfolder.NotifyFilter = watchfolder.NotifyFilter || System.IO.NotifyFilters.FileName;
				watchfolder.NotifyFilter = watchfolder.NotifyFilter || System.IO.NotifyFilters.Attributes;
				watchfolder.NotifyFilter = watchfolder.NotifyFilter || System.IO.NotifyFilters.Security;
				
				watchfolder.IncludeSubdirectories = IncludeSubDirs;
				
				//this is the path we want to monitor
				watchfolder.Path = _Directory;
				watchfolder.Filter = "*.*";
				
				// add the handler to each event
				watchfolder.Changed += new System.IO.FileSystemEventHandler(DirectoryChange);
				watchfolder.Created += new System.IO.FileSystemEventHandler(DirectoryChange);
				watchfolder.Deleted += new System.IO.FileSystemEventHandler(DirectoryChange);
				
				// add the rename handler as the signature is different AddHandler watchfolder.Renamed, AddressOf logrename
				
				//Set this property to true to start watching
				watchfolder.EnableRaisingEvents = true;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ATTENTION: Listener NOT started for: " + _Directory + "\r\n" + ex.Message + "\r\n" + ex.StackTrace.ToString()));
			}
			
		}
		
		public void StopListening()
		{
			
			// Stop watching the folder
			watchfolder.EnableRaisingEvents = false;
			
		}
		public void PauseListening(bool bPause)
		{
			
			if (bPause == true)
			{
				// Stop watching the folder
				watchfolder.EnableRaisingEvents = false;
			}
			else
			{
				// start watching the folder
				watchfolder.EnableRaisingEvents = true;
			}
			
		}
		
		//Sub UploadAwaitingFiles()
		
		//    If gFilesToArchive.Count > 0 Then
		//        CopyOfFilesToArchive.Clear()
		//        SyncLock Me
		//            For IX As Integer = 0 To gFilesToArchive.Count - 1
		//                CopyOfFilesToArchive.Add(gFilesToArchive(IX))
		//            Next
		//            gFilesToArchive.Clear()
		//        End SyncLock
		//    End If
		
		//    If CopyOfFilesToArchive.Count > 0 Then
		//        '** OK _ process the waiting files
		//        Application.DoEvents()
		//        Dim t As Thread
		//        t = New Thread(AddressOf RegisterArchiveFileList)
		//        t.Name = "Update: gFilesToArchive " & ThreadCnt.ToString
		//        t.Start(CopyOfFilesToArchive)
		//        Application.DoEvents()
		
		//    End If
		
		//End Sub
		
		//** This is the heart of the listener -
		//** One will launch for each listened to directory
		//** The listener detects a change or addition or deletion to a file
		//** within a directory or subdirectory
		private bool DirectoryChange(object source, System.IO.FileSystemEventArgs e)
		{
			
			if (isListenerPaused() == true)
			{
				modGlobals.gListenerActivityStart = DateTime.Now;
				LOG.WriteToArchiveLog("Listener for Dir: " + WatchDirectory + " is disabled.");
				return false;
			}
			
			BUSY = true;
			
			string FQN = "";
			bool InstantArchive = true;
			string Description = "";
			string Keywords = "";
			bool isEmailAttachment = false;
			
			if (e.ChangeType == System.IO.WatcherChangeTypes.Changed)
			{
				modGlobals.gListenerActivityStart = DateTime.Now;
				LOG.WriteListenerLog((string) ("CHG" + Strings.Chr(254) + e.FullPath));
				LOG.WriteToArchiveLog("File " + e.FullPath + " has been changed.");
				frmMain.Default.TimerUploadFiles.Enabled = true;
				if (! modGlobals.gFilesToArchive.ContainsKey(e.FullPath))
				{
					modGlobals.gFilesToArchive.Add(e.FullPath, modGlobals.gFilesToArchive.Count);
				}
			}
			else if (e.ChangeType == System.IO.WatcherChangeTypes.Renamed)
			{
				modGlobals.gListenerActivityStart = DateTime.Now;
				LOG.WriteListenerLog((string) ("NEW" + Strings.Chr(254) + e.FullPath));
				LOG.WriteToArchiveLog("File " + e.FullPath + " has been renamed.");
				frmMain.Default.TimerUploadFiles.Enabled = true;
				if (! modGlobals.gFilesToArchive.ContainsKey(e.FullPath))
				{
					modGlobals.gFilesToArchive.Add(e.FullPath, modGlobals.gFilesToArchive.Count);
				}
			}
			else if (e.ChangeType == System.IO.WatcherChangeTypes.Created)
			{
				modGlobals.gListenerActivityStart = DateTime.Now;
				LOG.WriteListenerLog((string) ("NEW" + Strings.Chr(254) + e.FullPath));
				LOG.WriteToArchiveLog("File " + e.FullPath + " has been created.");
				frmMain.Default.TimerUploadFiles.Enabled = true;
				if (! modGlobals.gFilesToArchive.ContainsKey(e.FullPath))
				{
					modGlobals.gFilesToArchive.Add(e.FullPath, modGlobals.gFilesToArchive.Count);
				}
				
			}
			else if (e.ChangeType == System.IO.WatcherChangeTypes.Deleted)
			{
				modGlobals.gListenerActivityStart = DateTime.Now;
				LOG.WriteToArchiveLog((string) ("File " + e.FullPath + " has been deleted by " + modGlobals.gCurrUserGuidID));
				LOG.WriteListenerLog((string) ("DEL" + Strings.Chr(254) + e.FullPath));
			}
			BUSY = false;
			return true;
		}
		
		public void RegisterArchiveFileList(SortedList<string, string> L)
		{
			clsDatabase DB = new clsDatabase();
			string SourceFile = "";
			string DirFQN = "";
			try
			{
				bool B = false;
				foreach (string S in L.Keys)
				{
					string sKey = S;
					Application.DoEvents();
					SourceFile = S;
					int IDX = L.IndexOfValue(S);
					DirFQN = L.Values(IDX);
					B = DB.RegisterArchiveFile(SourceFile, DirFQN);
					modGlobals.gListenerActivityStart = DateTime.Now;
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: RegisterArchiveFileList 100 - " + ex.Message));
			}
			finally
			{
				DB = null;
			}
			
		}
		
		
		
		public bool isListenerPaused()
		{
			bool B = false;
			if (modGlobals.gActiveListeners.IndexOfKey(DirGuid) >= 0)
			{
				B = System.Convert.ToBoolean(modGlobals.gActiveListeners[DirGuid]);
			}
			
			return B;
		}
		
	}
	
}

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

using System.IO;


namespace ECMSearchWPF
{
	public class clsLogging
	{
		
		/// <summary>
		/// The gvar
		/// </summary>
		
		
		private SVCSearch.Service1Client proxy = new SVCSearch.Service1Client();
		//Dim EP As New clsEndPoint
		clsEncryptV2 ENC2 = new clsEncryptV2();
		
		private bool dDeBug = false;
		private string SecureID = "-1";
		
		public clsLogging()
		{
			SecureID = SecureID;
		}
		//Public Function getEnvApplicationExecutablePath() As String
		//    Return Application.ExecutablePath
		//End Function
		public string getEnvVarSpecialFolderMyDocuments()
		{
			return Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
		}
		public string getEnvVarSpecialFolderLocalApplicationData()
		{
			return Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData);
		}
		public string getEnvVarSpecialFolderCommonApplicationData()
		{
			return Environment.GetFolderPath(Environment.SpecialFolder.CommonApplicationData);
		}
		public string getEnvVarSpecialFolderApplicationData()
		{
			return Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData);
		}
		public string getEnvVarVersion()
		{
			return Environment.Version.ToString();
		}
		//Public Function getEnvVarUserDomainName() As String
		//    Return Environment.UserDomainName.ToString
		//End Function
		public string getEnvVarProcessorCount()
		{
			return Environment.ProcessorCount.ToString();
		}
		public string getEnvVarOperatingSystem()
		{
			return Environment.OSVersion.ToString();
		}
		public string getEnvVarMachineName()
		{
			return Environment.MachineName;
		}
		//Public Function getEnvVarUserID() As String
		//    Return Environment.UserName
		//End Function
		
		public void WriteToArchiveFileTraceLog(string Msg, bool Zeroize)
		{
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				var TempFolder = getEnvVarSpecialFolderApplicationData();
				var M = DateTime.Now.Month.ToString().Trim();
				var D = DateTime.Now.Day.ToString().Trim();
				var Y = DateTime.Now.Year.ToString().Trim();
				
				var SerialNo = M + "." + D + "." + Y + ".";
				
				var tFQN = TempFolder + "\\ECMLibrary.Archive.FileTrace.Log." + SerialNo + "txt";
				if (Zeroize)
				{
					if (File.Exists(tFQN))
					{
						File.Delete(tFQN);
						return;
					}
				}
				// Create an instance of StreamWriter to write text to a file.
				using (StreamWriter sw = new StreamWriter(tFQN, true))
				{
					// Add some text to the file.
					sw.WriteLine(DateTime.Now.ToString() + ": " + Msg + "\r\n");
					sw.Close();
				}
				
			}
			catch (Exception ex)
			{
				if (dDeBug)
				{
					Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message);
				}
			}
		}
		public void WriteToSaveSql(string Msg)
		{
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				var TempFolder = getEnvVarSpecialFolderApplicationData();
				
				var tFQN = TempFolder + "\\$SQL.Generator.txt";
				// Create an instance of StreamWriter to write text to a file.
				using (StreamWriter sw = new StreamWriter(tFQN, true))
				{
					// Add some text to the file.
					sw.WriteLine(DateTime.Now.ToString() + "___________________________________________________________________________________" + "\r\n");
					sw.WriteLine(DateTime.Now.ToString() + ": " + Msg + "\r\n");
					sw.Close();
				}
				
			}
			catch (Exception ex)
			{
				if (dDeBug)
				{
					Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message);
				}
			}
		}
		
		public string getTempEnvironDir()
		{
			return getEnvVarSpecialFolderApplicationData();
		}
		public void WriteToSqlApplyLog(string tFqn, string Msg)
		{
			try
			{
				//Dim cPath As String = getTempEnvironDir()
				//Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
				//Dim tFQN$ = TempFolder$ + "\ECMLibrary.SQL.Application.Log.txt"
				using (StreamWriter sw = new StreamWriter(tFqn, true))
				{
					sw.WriteLine(DateTime.Now.ToString() + ": " + Msg + "\r\n");
					sw.Close();
				}
				
			}
			catch (Exception ex)
			{
				if (dDeBug)
				{
					Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message);
				}
			}
		}
		public void WriteToTempSqlApplyFile(string Msg)
		{
			try
			{
				string cPath = getTempEnvironDir();
				var TempFolder = getEnvVarSpecialFolderApplicationData();
				var tFQN = TempFolder + "\\ECMLibrary.SQL.Statements.txt";
				using (StreamWriter sw = new StreamWriter(tFQN, true))
				{
					sw.WriteLine(DateTime.Now.ToString() + ": " + Msg + "\r\n");
					sw.Close();
				}
				
			}
			catch (Exception ex)
			{
				if (dDeBug)
				{
					Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message);
				}
			}
		}
		public void WriteToNewFile(string FileText, string FQN)
		{
			try
			{
				string cPath = getTempEnvironDir();
				var TempFolder = getEnvVarSpecialFolderApplicationData();
				var tFQN = FQN;
				using (StreamWriter sw = new StreamWriter(tFQN, false))
				{
					sw.WriteLine(FileText + "\r\n");
					sw.Close();
				}
				
			}
			catch (Exception ex)
			{
				if (dDeBug)
				{
					Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message);
				}
			}
		}
		
		public void WriteToOcrLog(string Msg)
		{
			string LogName = "OCR";
			string Severity = "UKN";
			if (Msg.ToUpper().IndexOf("ERROR") + 1 > 0)
			{
				Severity = "Error";
			}
			else if (Msg.ToUpper().IndexOf("NOTIF") + 1 > 0)
			{
				Severity = "Notice";
			}
			else
			{
				Severity = "-";
			}
			
			WriteToLog(LogName, Msg, Severity);
		}
		public void WriteToSqlLog(string Msg)
		{
			string LogName = "SQL";
			string Severity = "UKN";
			if (Msg.ToUpper().IndexOf("ERROR") + 1 > 0)
			{
				Severity = "Error";
			}
			else if (Msg.ToUpper().IndexOf("NOTIF") + 1 > 0)
			{
				Severity = "Notice";
			}
			else
			{
				Severity = "-";
			}
			
			WriteToLog(LogName, Msg, Severity);
		}
		public void WriteToContentDuplicateLog(string TypeRec, string RecGuid, string RecIdentifier)
		{
			try
			{
				string cPath = getTempEnvironDir();
				var TempFolder = getEnvVarSpecialFolderApplicationData();
				var tFQN = TempFolder + "\\ECMLibrary.Duplicate.Content.Analysis.Log." + "txt";
				// Create an instance of StreamWriter to write text to a file.
				using (StreamWriter sw = new StreamWriter(tFQN, true))
				{
					// Add some text to the file.
					sw.WriteLine(DateTime.Now.ToString() + ": " + TypeRec + Strings.ChrW(254) + RecGuid + Strings.ChrW(254) + RecIdentifier + "\r\n");
					sw.Close();
				}
				
				if (modGlobals.gRunUnattended == true)
				{
					modGlobals.gUnattendedErrors++;
				}
			}
			catch (Exception ex)
			{
				if (dDeBug)
				{
					Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message);
				}
			}
		}
		
		public void WriteToEmailDuplicateLog(string TypeRec, string RecGuid, string RecIdentifier)
		{
			try
			{
				string cPath = getTempEnvironDir();
				var TempFolder = getEnvVarSpecialFolderApplicationData();
				var tFQN = TempFolder + "\\ECMLibrary.Duplicate.Email.Analysis.Log." + "txt";
				// Create an instance of StreamWriter to write text to a file.
				using (StreamWriter sw = new StreamWriter(tFQN, true))
				{
					// Add some text to the file.
					sw.WriteLine(DateTime.Now.ToString() + ": " + TypeRec + Strings.ChrW(254) + RecGuid + Strings.ChrW(254) + RecIdentifier + "\r\n");
					sw.Close();
				}
				
			}
			catch (Exception ex)
			{
				if (dDeBug)
				{
					Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message);
				}
			}
		}
		public void LoadEmailDupLog(Dictionary<string, string> L)
		{
			string cPath = getTempEnvironDir();
			var TempFolder = getEnvVarSpecialFolderApplicationData();
			var tFQN = TempFolder + "\\ECMLibrary.Duplicate.Email.Analysis.Log." + "txt";
			string tGuid = "";
			string tHashKey = "";
			
			System.IO.StreamReader srFileReader;
			string sInputLine;
			int I = 0;
			//10/1/2010 8:32:12 AM: EÃ¾00002995-49b2-4306-ac83-440e3fa37f16Ã¾5f08a162d39aa43aec2c09f31458d3da
			
			srFileReader = System.IO.File.OpenText(tFQN);
			sInputLine = srFileReader.ReadLine();
			//FrmMDIMain.SB4.Text = "Loading Hash Keys"
			//FrmMDIMain.Refresh()
			while (!(sInputLine == null))
			{
				I++;
				sInputLine = sInputLine.Trim();
				if (sInputLine.Length == 0)
				{
					goto GetNextLine;
				}
				string[] A;
				A = sInputLine.Split(Strings.ChrW(254).ToString().ToCharArray());
				tGuid = A[1];
				tHashKey = A[2];
				try
				{
					if (L.ContainsKey(tGuid))
					{
						//Console.WriteLine("Key Already Exists: " + tGuid)
					}
					else
					{
						L.Add(tGuid, tHashKey);
					}
				}
				catch (Exception ex)
				{
					Console.WriteLine("Key Exists Error: " + ex.Message);
				}
GetNextLine:
				sInputLine = srFileReader.ReadLine();
			}
			
		}
		
		public void LoadContentDupLog(Dictionary<string, string> L)
		{
			string cPath = getTempEnvironDir();
			var TempFolder = getEnvVarSpecialFolderApplicationData();
			var tFQN = TempFolder + "\\ECMLibrary.Duplicate.Content.Analysis.Log." + "txt";
			string tGuid = "";
			string tHashKey = "";
			
			System.IO.StreamReader srFileReader;
			string sInputLine;
			int I = 0;
			//10/1/2010 8:32:12 AM: EÃ¾00002995-49b2-4306-ac83-440e3fa37f16Ã¾5f08a162d39aa43aec2c09f31458d3da
			
			srFileReader = System.IO.File.OpenText(tFQN);
			sInputLine = srFileReader.ReadLine();
			
			while (!(sInputLine == null))
			{
				I++;
				sInputLine = sInputLine.Trim();
				if (sInputLine.Length == 0)
				{
					goto GetNextLine;
				}
				
				string[] A;
				A = sInputLine.Split(Strings.ChrW(254).ToString().ToCharArray());
				tGuid = A[1];
				tHashKey = A[2];
				try
				{
					if (L.ContainsKey(tGuid))
					{
						//Console.WriteLine("Key Already Exists: " + tGuid)
					}
					else
					{
						L.Add(tGuid, tHashKey);
					}
				}
				catch (Exception ex)
				{
					Console.WriteLine("Key Exists Error: " + ex.Message);
				}
GetNextLine:
				sInputLine = srFileReader.ReadLine();
			}
			
		}
		
		public void WriteToNoticeLog(string Msg)
		{
			string LogName = "NOTICE";
			string Severity = "UKN";
			if (Msg.ToUpper().IndexOf("ERROR") + 1 > 0)
			{
				Severity = "Error";
			}
			else if (Msg.ToUpper().IndexOf("NOTIF") + 1 > 0)
			{
				Severity = "Notice";
			}
			else
			{
				Severity = "-";
			}
			
			WriteToLog(LogName, Msg, Severity);
		}
		
		public void WriteToPDFLog(string Msg)
		{
			string LogName = "PDF";
			string Severity = "UKN";
			if (Msg.ToUpper().IndexOf("ERROR") + 1 > 0)
			{
				Severity = "Error";
			}
			else if (Msg.ToUpper().IndexOf("NOTIF") + 1 > 0)
			{
				Severity = "Notice";
			}
			else
			{
				Severity = "-";
			}
			
			WriteToLog(LogName, Msg, Severity);
		}
		
		public void WriteToInstallLog(string Msg)
		{
			string LogName = "INSTALL";
			string Severity = "UKN";
			if (Msg.ToUpper().IndexOf("ERROR") + 1 > 0)
			{
				Severity = "Error";
			}
			else if (Msg.ToUpper().IndexOf("NOTIF") + 1 > 0)
			{
				Severity = "Notice";
			}
			else
			{
				Severity = "-";
			}
			
			WriteToLog(LogName, Msg, Severity);
		}
		
		public void WriteToListenLog(string Msg)
		{
			string LogName = "LISTENER";
			string Severity = "UKN";
			if (Msg.ToUpper().IndexOf("ERROR") + 1 > 0)
			{
				Severity = "Error";
			}
			else if (Msg.ToUpper().IndexOf("NOTIF") + 1 > 0)
			{
				Severity = "Notice";
			}
			else
			{
				Severity = "-";
			}
			
			WriteToLog(LogName, Msg, Severity);
		}
		public void WriteFilesLog(string Msg)
		{
			string LogName = "FILES";
			string Severity = "UKN";
			if (Msg.ToUpper().IndexOf("ERROR") + 1 > 0)
			{
				Severity = "Error";
			}
			else if (Msg.ToUpper().IndexOf("NOTIF") + 1 > 0)
			{
				Severity = "Notice";
			}
			else
			{
				Severity = "-";
			}
			
			WriteToLog(LogName, Msg, Severity);
		}
		
		public void WriteToAttachLog(string Msg)
		{
			string LogName = "ATTACH";
			string Severity = "UKN";
			if (Msg.ToUpper().IndexOf("ERROR") + 1 > 0)
			{
				Severity = "Error";
			}
			else if (Msg.ToUpper().IndexOf("NOTIF") + 1 > 0)
			{
				Severity = "Notice";
			}
			else
			{
				Severity = "-";
			}
			
			WriteToLog(LogName, Msg, Severity);
		}
		public void WriteToEbExecLog(string Msg)
		{
			string LogName = "DBEXEC";
			string Severity = "UKN";
			if (Msg.ToUpper().IndexOf("ERROR") + 1 > 0)
			{
				Severity = "Error";
			}
			else if (Msg.ToUpper().IndexOf("NOTIF") + 1 > 0)
			{
				Severity = "Notice";
			}
			else
			{
				Severity = "-";
			}
			
			WriteToLog(LogName, Msg, Severity);
		}
		public void WriteToErrorLog(string Msg)
		{
			string LogName = "SEVERE_ERR";
			string Severity = "UKN";
			if (Msg.ToUpper().IndexOf("ERROR") + 1 > 0)
			{
				Severity = "Error";
			}
			else if (Msg.ToUpper().IndexOf("NOTIF") + 1 > 0)
			{
				Severity = "Notice";
			}
			else
			{
				Severity = "-";
			}
			
			WriteToLog(LogName, Msg, Severity);
		}
		public void WriteToTraceLog(string Msg)
		{
			string LogName = "TRACE";
			string Severity = "";
			if (Msg.ToUpper().IndexOf("ERROR") + 1 > 0)
			{
				Severity = "Error";
			}
			else if (Msg.ToUpper().IndexOf("NOTIF") + 1 > 0)
			{
				Severity = "Notice";
			}
			else
			{
				Severity = "-";
			}
			
			WriteToLog(LogName, Msg, Severity);
		}
		
		public void WriteToCrawlerLog(string Msg)
		{
			string LogName = "CRAWLER";
			string Severity = "UKN";
			if (Msg.ToUpper().IndexOf("ERROR") + 1 > 0)
			{
				Severity = "Error";
			}
			else if (Msg.ToUpper().IndexOf("NOTIF") + 1 > 0)
			{
				Severity = "Notice";
			}
			else
			{
				Severity = "-";
			}
			
			WriteToLog(LogName, Msg, Severity);
		}
		public void WriteToArchiveLog(string Msg)
		{
			string LogName = "Archive";
			string Severity = "UKN";
			if (Msg.ToUpper().IndexOf("ERROR") + 1 > 0)
			{
				Severity = "Error";
			}
			else if (Msg.ToUpper().IndexOf("NOTIF") + 1 > 0)
			{
				Severity = "Notice";
			}
			else
			{
				Severity = "-";
			}
			
			WriteToLog(LogName, Msg, Severity);
		}
		
		public void WriteToAttachmentSearchyLog(string Msg)
		{
			string LogName = "ATTACH_SEARCH";
			string Severity = "UKN";
			if (Msg.ToUpper().IndexOf("ERROR") + 1 > 0)
			{
				Severity = "Error";
			}
			else if (Msg.ToUpper().IndexOf("NOTIF") + 1 > 0)
			{
				Severity = "Notice";
			}
			else
			{
				Severity = "-";
			}
			
			WriteToLog(LogName, Msg, Severity);
		}
		
		public void ZeroizeSaveSql()
		{
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				var TempFolder = getEnvVarSpecialFolderApplicationData();
				
				var tFQN = TempFolder + "\\$SQL.Generator.txt";
				if (File.Exists(tFQN))
				{
					File.Delete(tFQN);
				}
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			catch (Exception ex)
			{
				if (dDeBug)
				{
					Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message);
				}
			}
		}
		
		//Sub CleanOutTempDirectoryImmediate()
		
		//    Try
		//        Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
		//        Dim storefile As Directory
		//        Dim directory As String
		//        Dim files As String()
		//        Dim FQN As String
		
		//        files = storefile.GetFiles(TempFolder$, "ECM*.*")
		//        Dim T As TimeSpan
		
		//        For Each FQN In files
		//            Try
		//                Kill(FQN)
		//            Catch ex As Exception
		//                MsgBox("Delete Notice: " + FQN + vbCrLf + ex.Message)
		//            End Try
		//        Next
		
		//    Catch ex As Exception
		//        Me.WriteToSqlLog("NOTICE CleanOutTempDirectory: " + ex.Message)
		//    End Try
		
		//End Sub
		
		//Sub CleanOutTempDirectory()
		
		//    Try
		//        Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
		//        Dim storefile As Directory
		//        Dim directory As String
		//        Dim files As String()
		//        Dim FQN As String
		
		//        files = storefile.GetFiles(TempFolder$, "ECM*.*")
		//        Dim T As TimeSpan
		
		//        For Each FQN In files
		//            Dim FileDate As Date = GetFileCreateDate(FQN)
		
		//            'Dim objFileInfo As New FileInfo(FQN)
		//            'Dim dtCreationDate As DateTime = objFileInfo.CreationTime
		
		//            Dim tsTimeSpan As TimeSpan
		//            Dim iNumberOfDays As Integer
		//            Dim strMsgText As String
		
		//            tsTimeSpan = Now.Subtract(FileDate)
		
		//            iNumberOfDays = tsTimeSpan.Days
		//            If iNumberOfDays > gDaysToKeepTraceLogs Then
		//                Kill(FQN)
		//            End If
		//        Next
		
		//    Catch ex As Exception
		//        Me.WriteToSqlLog("NOTICE CleanOutTempDirectory: " + ex.Message)
		//    End Try
		
		//End Sub
		
		//Sub CleanOutErrorDirectoryImmediate()
		
		//    Try
		//        Dim UTIL As New clsUtility
		
		//        Dim TempFolder$ = UTIL.getTempPdfWorkingErrorDir
		
		//        UTIL = Nothing
		
		//        Dim storefile As Directory
		//        Dim directory As String
		//        Dim files As String()
		//        Dim FQN As String
		
		//        files = storefile.GetFiles(TempFolder$, "*.*")
		//        Dim T As TimeSpan
		
		//        For Each FQN In files
		//            Try
		//                Kill(FQN)
		//            Catch ex As Exception
		//                MsgBox("Delete Notice: " + FQN + vbCrLf + ex.Message)
		//            End Try
		//        Next
		
		//    Catch ex As Exception
		//        Me.WriteToSqlLog("NOTICE CleanOutTempDirectory: " + ex.Message)
		//    End Try
		
		//End Sub
		
		//Sub CleanOutErrorDirectory()
		
		//    Try
		//        Dim UTIL As New clsUtility
		
		//        Dim TempFolder$ = UTIL.getTempPdfWorkingErrorDir
		
		//        UTIL = Nothing
		
		//        Dim storefile As Directory
		//        Dim directory As String
		//        Dim files As String()
		//        Dim FQN As String
		
		//        files = storefile.GetFiles(TempFolder$, "*.*")
		//        Dim T As TimeSpan
		
		//        For Each FQN In files
		//            Dim FileDate As Date = GetFileCreateDate(FQN)
		
		//            'Dim objFileInfo As New FileInfo(FQN)
		//            'Dim dtCreationDate As DateTime = objFileInfo.CreationTime
		
		//            Dim tsTimeSpan As TimeSpan
		//            Dim iNumberOfDays As Integer
		//            Dim strMsgText As String
		
		//            tsTimeSpan = Now.Subtract(FileDate)
		
		//            iNumberOfDays = tsTimeSpan.Days
		//            If iNumberOfDays > gDaysToKeepTraceLogs Then
		//                Kill(FQN)
		//            End If
		//        Next
		
		//    Catch ex As Exception
		//        Me.WriteToSqlLog("NOTICE CleanOutTempDirectory: " + ex.Message)
		//    End Try
		
		//End Sub
		
		public int GetFileSize(string MyFilePath)
		{
			FileInfo MyFile = new FileInfo(MyFilePath);
			int FileSize = MyFile.Length;
			MyFile = null;
			return FileSize;
		}
		public DateTime GetFileCreateDate(string MyFilePath)
		{
			FileInfo MyFile = new FileInfo(MyFilePath);
			DateTime FileDate = MyFile.CreationTime;
			MyFile = null;
			return FileDate;
		}
		public void WriteToTempFile(string FQN, string Msg)
		{
			try
			{
				using (StreamWriter sw = new StreamWriter(FQN, true))
				{
					sw.WriteLine(Msg + "\r\n");
					sw.Close();
				}
				
			}
			catch (Exception ex)
			{
				if (dDeBug)
				{
					Console.WriteLine("clsDma : WriteToTempFile : 688 : " + ex.Message);
				}
			}
		}
		
		//Sub PurgeDirectory(ByVal DirectoryName As String, ByVal Pattern As String)
		
		//    Try
		//        Dim TempFolder$ = getEnvVarSpecialFolderApplicationData()
		//        Dim storefile As Directory = Nothing
		//        'Dim directory As String = ""
		//        Dim files As String()
		//        Dim FQN As String
		
		//        files = storefile.GetFiles(DirectoryName, Pattern)
		//        Dim T As TimeSpan
		
		//        For Each FQN In files
		//            Dim FileDate As Date = GetFileCreateDate(FQN)
		//            Dim tsTimeSpan As TimeSpan
		//            Dim iNumberOfMin As Integer
		
		//            tsTimeSpan = Now.Subtract(FileDate)
		
		//            iNumberOfMin = tsTimeSpan.Minutes
		//            If iNumberOfMin > 1 Then
		//                Kill(FQN)
		//            End If
		//        Next
		
		//    Catch ex As Exception
		//        Me.WriteToSqlLog("NOTICE CleanOutTempDirectory: " + ex.Message)
		//    End Try
		
		//End Sub
		
		public void WriteToProcessLog(string Msg)
		{
			string LogName = "PROCESS";
			string Severity = "UKN";
			if (Msg.ToUpper().IndexOf("ERROR") + 1 > 0)
			{
				Severity = "Error";
			}
			else if (Msg.ToUpper().IndexOf("NOTIF") + 1 > 0)
			{
				Severity = "Notice";
			}
			else
			{
				Severity = "-";
			}
			
			WriteToLog(LogName, Msg, Severity);
		}
		
		public void WriteToTimerLog(string LocaterID, string TimerName, string StartStop, DateTime StartTime = null)
		{
			
			TimeSpan ExecutionTime;
			string sExecutionTime = "";
			if (StartTime == null)
			{
			}
			else
			{
				DateTime stop_time = DateTime.Now;
				ExecutionTime = stop_time.Subtract(StartTime);
				sExecutionTime = ExecutionTime.TotalSeconds.ToString("0.000000");
			}
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN$ = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				
				var TempFolder = getEnvVarSpecialFolderApplicationData();
				var M = DateTime.Now.Month.ToString().Trim();
				var D = DateTime.Now.Day.ToString().Trim();
				var Y = DateTime.Now.Year.ToString().Trim();
				
				var SerialNo = M + "." + D + "." + Y + ".";
				
				var tFQN = TempFolder + "\\ECMLibrary.Timer.Log." + SerialNo + "txt";
				// Create an instance of StreamWriter to write text to a file.
				using (StreamWriter sw = new StreamWriter(tFQN, true))
				{
					// Add some text to the file.
					if (sExecutionTime.Length > 0)
					{
						sw.WriteLine(TimerName + " : " + StartStop + " : " + TimerName + " : Elapsed Time: " + sExecutionTime + " : " + DateTime.Now.ToString());
					}
					else
					{
						sw.WriteLine(TimerName + " : " + StartStop + " : " + TimerName + " : " + DateTime.Now.ToString());
					}
					
					sw.Close();
				}
				
				if (modGlobals.gRunUnattended == true)
				{
					modGlobals.gUnattendedErrors++;
					//FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
					//FrmMDIMain.SB4.BackColor = Color.Silver
				}
			}
			catch (Exception ex)
			{
				if (dDeBug)
				{
					Console.WriteLine("clsDma : WriteToSqlLog : 688 : " + ex.Message);
				}
			}
		}
		public void WriteToFileProcessLog(string MSG)
		{
			
			string LogName = "FILE_PROCESS";
			string Severity = "UKN";
			if (MSG.ToUpper().IndexOf("ERROR") + 1 > 0)
			{
				Severity = "Error";
			}
			else if (MSG.ToUpper().IndexOf("NOTIF") + 1 > 0)
			{
				Severity = "Notice";
			}
			else
			{
				Severity = "-";
			}
			
			WriteToLog(LogName, MSG, Severity);
		}
		
		public void WriteToLog(string LogName, string Msg, string Severity)
		{
			if (Severity.Length == 0)
			{
				Severity = "ERROR";
			}
			string MsgCopy = Msg;
			MsgCopy = MsgCopy.Replace("\'", "`");
			MsgCopy = MsgCopy.Replace(Strings.ChrW(9), " ");
			//MsgCopy = MsgCopy.Replace(vbCrLf + vbCrLf, vbCrLf)
			while (MsgCopy.Contains("  "))
			{
				MsgCopy = MsgCopy.Replace(" ", "");
			}
			string S = "";
			S += " INSERT INTO [ErrorLogs]" + "\r\n";
			S += " ([LogName]" + "\r\n";
			S += " ,[LoggedMessage]" + "\r\n";
			S += " ,[EntryDate]" + "\r\n";
			S += " ,[EntryUserID]" + "\r\n";
			S += " ,[Severity])" + "\r\n";
			S += " VALUES( " + "\r\n";
			S += "\'" + LogName + "\'" + "\r\n";
			S += " ,\'" + MsgCopy + "\'" + "\r\n";
			S += " ,getdate()" + "\r\n";
			S += " ,\'" + modGlobals.gCurrLoginID + "\'" + "\r\n";
			S += " ,\'" + Severity + "\')" + "\r\n";
			ExecuteLogWriteSql(SecureID, S);
		}
		
		public void ExecuteLogWriteSql(string SecureID, string Mysql)
		{
			
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted += new System.EventHandler(client_ExecuteLogWriteSql);
			//EP.setSearchSvcEndPoint(proxy)
			modGlobals.bExecSqlHAndler = true;
			
			Mysql = ENC2.EncryptPhrase(Mysql, GLOBALS.ContractID);
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureAsync(SecureID, GLOBALS.gRowID, Mysql, GLOBALS._UserID, GLOBALS.ContractID);
		}
		
		public void client_ExecuteLogWriteSql(object sender, SVCSearch.ExecuteSqlNewConnSecureCompletedEventArgs e)
		{
			if (e.Error == null)
			{
			}
			else
			{
				modGlobals.gErrorCount++;
				clsLogging LOG = new clsLogging();
				LOG.WriteToSqlLog((string) ("ERROR 100.1 ExecuteLogWriteSql: " + e.Error.Message + "\r\n" + e.MySql));
				LOG = null;
			}
			GLOBALS.ProxySearch.ExecuteSqlNewConnSecureCompleted -= new System.EventHandler(GLOBALS.client_ExecuteSql);
		}
		
		private void setXXSearchSvcEndPoint()
		{
			
			string CurrEndPoint = (string) (GLOBALS.ProxySearch.Endpoint.Address.ToString());
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

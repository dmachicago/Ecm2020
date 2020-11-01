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
using System.Drawing.Imaging;
using O2S.Components.PDF4NET;
using O2S.Components.PDF4NET.PDFFile;
using Microsoft.VisualBasic.CompilerServices;


namespace EcmArchiveClcSetup
{
	public class clsLogging
	{
		
		bool dDeBug = false;
		//Dim DMA As New clsDma
		
		public string getEnvApplicationExecutablePath()
		{
			return Application.ExecutablePath;
		}
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
		public string getEnvVarUserDomainName()
		{
			return Environment.UserDomainName.ToString();
		}
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
		public string getEnvVarNetworkID()
		{
			return System.Security.Principal.WindowsIdentity.GetCurrent().Name;
			//Return Environment.UserDomainName
		}
		public string getEnvVarUserID()
		{
			return Environment.UserName;
		}
		
		public void WriteToArchiveFileTraceLog(string Msg, bool Zeroize)
		{
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				
				string SerialNo = M + "." + D + "." + Y + ".";
				
				string tFQN = TempFolder + "\\ECMLibrary.Archive.FileTrace.Log." + SerialNo + "txt";
				if (Zeroize)
				{
					File F;
					if (F.Exists(tFQN))
					{
						F.Delete(tFQN);
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		public void WriteToSaveSql(string Msg)
		{
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				
				string tFQN = TempFolder + "\\ SQL.Archive.Generator.txt";
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
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
				//Dim TempFolder  = getEnvVarSpecialFolderApplicationData()
				//Dim tFQN  = TempFolder  + "\ECMLibrary.SQL.Application.Log.txt"
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		public void WriteToTempSqlApplyFile(string Msg)
		{
			try
			{
				string cPath = getTempEnvironDir();
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string tFQN = TempFolder + "\\ECMLibrary.Archive.SQL.Statements.txt";
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		public void WriteToNewFile(string FileText, string FQN)
		{
			try
			{
				string cPath = getTempEnvironDir();
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string tFQN = FQN;
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		public void OpenEcmErrorLog()
		{
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				string SerialNo = M + "." + D + "." + Y + ".";
				string tFQN = TempFolder + "\\ECMLibrary.Archive.Trace.ECMQry.Log." + SerialNo + "txt";
				// Create an instance of StreamWriter to write text to a file.
				System.Diagnostics.Process.Start("notepad.exe", tFQN);
			}
			catch (Exception ex)
			{
				if (dDeBug)
				{
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		public void WriteToOcrLog(string Msg)
		{
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				
				string SerialNo = M + "." + D + "." + Y + ".";
				
				string tFQN = TempFolder + "\\ECMLibrary.Archive.OCR.Log." + SerialNo + "txt";
				// Create an instance of StreamWriter to write text to a file.
				using (StreamWriter sw = new StreamWriter(tFQN, true))
				{
					// Add some text to the file.
					sw.WriteLine(DateTime.Now.ToString() + ": " + Msg + "\r\n");
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		public void WriteToSqlLog(string Msg)
		{
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				
				string SerialNo = M + "." + D + "." + Y + ".";
				
				string tFQN = TempFolder + "\\ECMLibrary.CLC.Archive.Event.Log." + SerialNo + "txt";
				// Create an instance of StreamWriter to write text to a file.
				using (StreamWriter sw = new StreamWriter(tFQN, true))
				{
					// Add some text to the file.
					sw.WriteLine(DateTime.Now.ToString() + ": " + Msg + "\r\n");
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		public void WriteToUploadLog(string Msg)
		{
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				
				string SerialNo = M + "." + D + "." + Y + ".";
				
				string tFQN = TempFolder + "\\ECMLibrary.Archive.UploadLog.Log." + SerialNo + "txt";
				// Create an instance of StreamWriter to write text to a file.
				using (StreamWriter sw = new StreamWriter(tFQN, true))
				{
					// Add some text to the file.
					sw.WriteLine(DateTime.Now.ToString() + ": " + Msg + "\r\n");
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		public void WriteToContentDuplicateLog(string TypeRec, string RecGuid, string RecIdentifier)
		{
			try
			{
				string cPath = getTempEnvironDir();
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string tFQN = TempFolder + "\\ECMLibrary.Archive.Duplicate.Content.Analysis.Log." + "txt";
				// Create an instance of StreamWriter to write text to a file.
				using (StreamWriter sw = new StreamWriter(tFQN, true))
				{
					// Add some text to the file.
					sw.WriteLine(DateTime.Now.ToString() + ": " + TypeRec + Strings.Chr(254) + RecGuid + Strings.Chr(254) + RecIdentifier + "\r\n");
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		
		public void WriteToEmailDuplicateLog(string TypeRec, string RecGuid, string RecIdentifier)
		{
			try
			{
				string cPath = getTempEnvironDir();
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string tFQN = TempFolder + "\\ECMLibrary.Archive.Duplicate.Email.Analysis.Log." + "txt";
				// Create an instance of StreamWriter to write text to a file.
				using (StreamWriter sw = new StreamWriter(tFQN, true))
				{
					// Add some text to the file.
					sw.WriteLine(DateTime.Now.ToString() + ": " + TypeRec + Strings.Chr(254) + RecGuid + Strings.Chr(254) + RecIdentifier + "\r\n");
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		public void LoadEmailDupLog(SortedList<string, string> L)
		{
			string cPath = getTempEnvironDir();
			string TempFolder = getEnvVarSpecialFolderApplicationData();
			string tFQN = TempFolder + "\\ECMLibrary.Archive.Duplicate.Email.Analysis.Log." + "txt";
			string tGuid = "";
			string tHashKey = "";
			
			System.IO.StreamReader srFileReader;
			string sInputLine;
			int I = 0;
			//10/1/2010 8:32:12 AM: EÃƒÂ¾00002995-49b2-4306-ac83-440e3fa37f16ÃƒÂ¾5f08a162d39aa43aec2c09f31458d3da
			
			srFileReader = System.IO.File.OpenText(tFQN);
			sInputLine = srFileReader.ReadLine();
			//FrmMDIMain.SB4.Text = "Loading Hash Keys"
			//FrmMDIMain.Refresh()
			Application.DoEvents();
			while (!(sInputLine == null))
			{
				I++;
				sInputLine = sInputLine.Trim();
				if (sInputLine.Length == 0)
				{
					goto GetNextLine;
				}
				if (I % 50 == 0)
				{
					//FrmMDIMain.SB4.Text = "## " + I.ToString
					//FrmMDIMain.Refresh()
					Application.DoEvents();
				}
				string[] A;
				A = sInputLine.Split(Strings.Chr(254).ToString().ToCharArray());
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
			//FrmMDIMain.SB4.Text = " - "
			Application.DoEvents();
		}
		
		public void LoadContentDupLog(SortedList<string, string> L)
		{
			string cPath = getTempEnvironDir();
			string TempFolder = getEnvVarSpecialFolderApplicationData();
			string tFQN = TempFolder + "\\ECMLibrary.Archive.Duplicate.Content.Analysis.Log." + "txt";
			string tGuid = "";
			string tHashKey = "";
			
			System.IO.StreamReader srFileReader;
			string sInputLine;
			int I = 0;
			//10/1/2010 8:32:12 AM: EÃƒÂ¾00002995-49b2-4306-ac83-440e3fa37f16ÃƒÂ¾5f08a162d39aa43aec2c09f31458d3da
			
			srFileReader = System.IO.File.OpenText(tFQN);
			sInputLine = srFileReader.ReadLine();
			//FrmMDIMain.SB4.Text = "Loading Hash Keys"
			//FrmMDIMain.Refresh()
			Application.DoEvents();
			while (!(sInputLine == null))
			{
				I++;
				sInputLine = sInputLine.Trim();
				if (sInputLine.Length == 0)
				{
					goto GetNextLine;
				}
				if (I % 50 == 0)
				{
					//FrmMDIMain.SB4.Text = "## " + I.ToString
					//FrmMDIMain.Refresh()
					Application.DoEvents();
				}
				string[] A;
				A = sInputLine.Split(Strings.Chr(254).ToString().ToCharArray());
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
			//FrmMDIMain.SB4.Text = " - "
			Application.DoEvents();
		}
		
		public void WriteToNoticeLog(string Msg)
		{
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				
				string SerialNo = M + "." + D + "." + Y + ".";
				
				string tFQN = TempFolder + "\\ECMLibrary.Archive.Notice.Log." + SerialNo + "txt";
				// Create an instance of StreamWriter to write text to a file.
				using (StreamWriter sw = new StreamWriter(tFQN, true))
				{
					// Add some text to the file.
					sw.WriteLine(DateTime.Now.ToString() + ": " + Msg + "\r\n");
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		
		public void WriteToPDFLog(string Msg)
		{
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				
				string SerialNo = M + "." + D + "." + Y + ".";
				
				string tFQN = TempFolder + "\\ECMLibrary.Archive.PDF.Log." + SerialNo + "txt";
				// Create an instance of StreamWriter to write text to a file.
				using (StreamWriter sw = new StreamWriter(tFQN, true))
				{
					// Add some text to the file.
					sw.WriteLine(DateTime.Now.ToString() + ": " + Msg + "\r\n");
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		
		public void WriteToParmLog(string Msg)
		{
			try
			{
				string cPath = getTempEnvironDir();
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				
				string SerialNo = M + "." + D + "." + Y + ".";
				
				string tFQN = TempFolder + "\\ECMLibrary.Archive.Installation.Parm.Log." + SerialNo + "txt";
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
			
		}
		public void WriteToInstallLog(string Msg)
		{
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				
				string SerialNo = M + "." + D + "." + Y + ".";
				
				string tFQN = TempFolder + "\\ECMLibrary.Archive.Client.Installation.Log." + SerialNo + "txt";
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		
		public void WriteToListenLog(string Msg)
		{
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				
				string SerialNo = M + "." + D + "." + Y + ".";
				
				string tFQN = TempFolder + "\\ECMLibrary.Archive.Client.Listen.Log." + SerialNo + "txt";
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		
		public void WriteListenerLog(string Msg)
		{
			try
			{
				string cPath = getTempEnvironDir();
				string tFQN = cPath + "\\ListenerFilesLog.ECM";
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
					Console.WriteLine("clsDma : WriteListenerLog : 688 : " + ex.Message);
				}
			}
		}
		
		public void WriteToAttachLog(string Msg)
		{
			try
			{
				string cPath = getTempEnvironDir();
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				
				string SerialNo = M + "." + D + "." + Y + ".";
				
				string tFQN = TempFolder + "\\ECMLibrary.Archive.Client.Attach.Log." + SerialNo + "txt";
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
					Console.WriteLine("clsDma : WriteToAttachLog : 688 : " + ex.Message);
				}
			}
		}
		public void WriteToEbExecLog(string Msg)
		{
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN  = cPath + "\ECMLibrary.Db.ExecQry.Log.txt"
				
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				
				string SerialNo = M + "." + D + "." + Y + ".";
				
				string tFQN = TempFolder + "\\ECMLibrary.Archive.Db.ExecQry.Log." + SerialNo + "txt";
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		public void WriteToErrorLog(string Msg)
		{
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				
				string SerialNo = M + "." + D + "." + Y + ".";
				
				string tFQN = TempFolder + "\\ECMLibrary.Archive.Error.Log." + SerialNo + "txt";
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		public void WriteToTraceLog(string Msg)
		{
			try
			{
				string cPath = getTempEnvironDir();
				
				Directory dx;
				if (dx.Exists("c:\\EcmTrace"))
				{
					cPath = "c:\\EcmTrace";
				}
				else
				{
					try
					{
						cPath = "c:\\EcmTrace";
						dx.CreateDirectory(cPath);
					}
					catch (Exception)
					{
						cPath = getTempEnvironDir();
					}
				}
				
				//Dim cPath As String = GetCurrDir()
				
				//Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				
				string TempFolder = cPath;
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				
				string SerialNo = M + "." + D + "." + Y + ".";
				
				string tFQN = TempFolder + "\\ECMLibrary.Archive.Trace." + SerialNo + "txt";
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		
		public void WriteToCrawlerLog(string Msg)
		{
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				
				string SerialNo = M + "." + D + "." + Y + ".";
				
				string tFQN = TempFolder + "\\ECMLibrary.Archive.WebCrawl." + SerialNo + "txt";
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		public void WriteToArchiveLog(string Msg)
		{
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				
				string SerialNo = M + "." + D + "." + Y + ".";
				
				string tFQN = TempFolder + "\\ECMLibrary.Archive.Log." + SerialNo + "txt";
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		
		public void WriteToAttachmentSearchyLog(string Msg)
		{
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				
				string SerialNo = M + "." + D + "." + Y + ".";
				
				string tFQN = TempFolder + "\\ECMLibrary.Archive.AttachSearch.Trace.Log." + SerialNo + "txt";
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		
		public void ZeroizeSaveSql()
		{
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				
				string tFQN = TempFolder + "\\ SQL.Archive.Generator.txt";
				File F;
				if (F.Exists(tFQN))
				{
					F.Delete(tFQN);
				}
				F = null;
				GC.Collect();
				GC.WaitForPendingFinalizers();
			}
			catch (Exception ex)
			{
				if (dDeBug)
				{
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		public void CleanOutTempDirectoryImmediate()
		{
			
			try
			{
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				Directory storefile;
				string directory;
				string[] files;
				
				
				files = storefile.GetFiles(TempFolder, "ECM*.*");
				TimeSpan T;
				
				foreach (string FQN in files)
				{
					try
					{
						Kill(FQN);
					}
					catch (Exception ex)
					{
						MessageBox.Show((string) ("Delete Notice: " + FQN + "\r\n" + ex.Message));
					}
				}
				
			}
			catch (Exception ex)
			{
				this.WriteToArchiveLog((string) ("NOTICE CleanOutTempDirectory: " + ex.Message));
			}
			
		}
		public void CleanOutTempDirectory()
		{
			
			try
			{
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				Directory storefile;
				string directory;
				string[] files;
				
				
				files = storefile.GetFiles(TempFolder, "ECM*.*");
				TimeSpan T;
				
				foreach (string FQN in files)
				{
					DateTime FileDate = GetFileCreateDate(FQN);
					
					//Dim objFileInfo As New FileInfo(FQN)
					//Dim dtCreationDate As DateTime = objFileInfo.CreationTime
					
					TimeSpan tsTimeSpan;
					int iNumberOfDays;
					string strMsgText;
					
					tsTimeSpan = DateTime.Now.Subtract(FileDate);
					
					iNumberOfDays = tsTimeSpan.Days;
					if (iNumberOfDays > modGlobals.gDaysToKeepTraceLogs)
					{
						Kill(FQN);
					}
				}
				
			}
			catch (Exception ex)
			{
				this.WriteToArchiveLog((string) ("NOTICE CleanOutTempDirectory: " + ex.Message));
			}
			
		}
		
		public void CleanOutErrorDirectoryImmediate()
		{
			
			try
			{
				clsUtility UTIL = new clsUtility();
				
				string TempFolder = UTIL.getTempPdfWorkingErrorDir();
				
				UTIL = null;
				
				Directory storefile;
				string directory;
				string[] files;
				
				
				files = storefile.GetFiles(TempFolder, "*.*");
				TimeSpan T;
				
				foreach (string FQN in files)
				{
					try
					{
						Kill(FQN);
					}
					catch (Exception ex)
					{
						MessageBox.Show((string) ("Delete Notice: " + FQN + "\r\n" + ex.Message));
					}
				}
				
			}
			catch (Exception ex)
			{
				this.WriteToArchiveLog((string) ("NOTICE CleanOutTempDirectory: " + ex.Message));
			}
			
		}
		
		public void CleanOutErrorDirectory()
		{
			
			try
			{
				clsUtility UTIL = new clsUtility();
				
				string TempFolder = UTIL.getTempPdfWorkingErrorDir();
				
				UTIL = null;
				
				Directory storefile;
				string directory;
				string[] files;
				
				
				files = storefile.GetFiles(TempFolder, "*.*");
				TimeSpan T;
				
				foreach (string FQN in files)
				{
					DateTime FileDate = GetFileCreateDate(FQN);
					
					//Dim objFileInfo As New FileInfo(FQN)
					//Dim dtCreationDate As DateTime = objFileInfo.CreationTime
					
					TimeSpan tsTimeSpan;
					int iNumberOfDays;
					string strMsgText;
					
					tsTimeSpan = DateTime.Now.Subtract(FileDate);
					
					iNumberOfDays = tsTimeSpan.Days;
					if (iNumberOfDays > modGlobals.gDaysToKeepTraceLogs)
					{
						Kill(FQN);
					}
				}
				
			}
			catch (Exception ex)
			{
				this.WriteToArchiveLog((string) ("NOTICE CleanOutTempDirectory: " + ex.Message));
			}
			
		}
		
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
		public void PurgeDirectory(string DirectoryName, string Pattern)
		{
			
			try
			{
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				Directory storefile = null;
				//Dim directory As String = ""
				string[] files;
				
				
				files = storefile.GetFiles(DirectoryName, Pattern);
				TimeSpan T;
				
				foreach (string FQN in files)
				{
					DateTime FileDate = GetFileCreateDate(FQN);
					TimeSpan tsTimeSpan;
					int iNumberOfMin;
					
					tsTimeSpan = DateTime.Now.Subtract(FileDate);
					
					iNumberOfMin = tsTimeSpan.Minutes;
					if (iNumberOfMin > 1)
					{
						Kill(FQN);
					}
				}
				
			}
			catch (Exception ex)
			{
				this.WriteToArchiveLog((string) ("NOTICE CleanOutTempDirectory: " + ex.Message));
			}
			
		}
		
		public void WriteToProcessLog(string Msg)
		{
			try
			{
				//Dim cPath As String = GetCurrDir()
				string cPath = getTempEnvironDir();
				//Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				
				string SerialNo = M + "." + D + "." + Y + ".";
				
				string tFQN = TempFolder + "\\ECMLibrary.Archive.Memory.Process.Log." + SerialNo + "txt";
				// Create an instance of StreamWriter to write text to a file.
				using (StreamWriter sw = new StreamWriter(tFQN, true))
				{
					// Add some text to the file.
					sw.WriteLine(DateTime.Now.ToString() + ": " + Msg + "\r\n");
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
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
				//Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
				
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				
				string SerialNo = M + "." + D + "." + Y + ".";
				
				string tFQN = TempFolder + "\\ECMLibrary.Archive.Timer.Log." + SerialNo + "txt";
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		public void WriteToFileProcessLog(string FQN)
		{
			
			try
			{
				string cPath = getTempEnvironDir();
				string TempFolder = getEnvVarSpecialFolderApplicationData();
				string M = DateTime.Now.Month.ToString().Trim();
				string D = DateTime.Now.Day.ToString().Trim();
				string Y = DateTime.Now.Year.ToString().Trim();
				
				string SerialNo = M + "." + D + "." + Y + ".";
				
				string tFQN = TempFolder + "\\ECMLibrary.Archive.FilesProcessed.Log." + SerialNo + "txt";
				// Create an instance of StreamWriter to write text to a file.
				using (StreamWriter sw = new StreamWriter(tFQN, true))
				{
					// Add some text to the file.
					sw.WriteLine(DateTime.Now.ToString() + " : " + FQN);
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
					Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
		}
		public void WriteMemoryTrack()
		{
			
			
			foreach (Process p in p.GetProcesses())
			{
				string S = "";
				double D = double.Parse((p.WorkingSet64).ToString());
				string P1 = p.ToString().Remove(0, 27);
				string P2 = (string) ((D / 1000000) + " MB");
				
				if (P1.IndexOf("ECM") + 1 > 0)
				{
					WriteToProcessLog(P1 + " : " + P2);
				}
			}
		}
		
		public string PullOutSingleQuotes(string tVal)
		{
			
			if (tVal.IndexOf("\'") + 1 == 0)
			{
				return (tVal);
			}
			
			if (tVal.IndexOf("\'\'") + 1 > 0)
			{
				return (tVal);
			}
			
			int i = tVal.Length;
			string ch = "";
			string NewStr = "";
			string S1 = "";
			string S2 = "";
			string[] A;
			if (tVal.IndexOf("\'") + 1 > 0)
			{
				A = tVal.Split("\'".ToCharArray());
				for (i = 0; i <= (A.Length - 1); i++)
				{
					NewStr = NewStr + A[i].Trim() + "\'\'";
				}
				NewStr = NewStr.Substring(0, NewStr.Length - 2);
			}
			else
			{
				NewStr = tVal;
			}
			return NewStr;
		}
		public string PutBackSingleQuotes(string tStr)
		{
			
			if (tStr.IndexOf("\'\'") + 1 == 0)
			{
				return (tStr);
			}
			
			string TgtStr = "\'\'";
			string S1 = "";
			string S2 = "";
			int L = TgtStr.Length;
			int I = 0;
			
			while (tStr.IndexOf(TgtStr) + 1 > 0)
			{
				I = tStr.IndexOf(TgtStr) + 1;
				S1 = tStr.Substring(0, I - 1);
				S2 = tStr.Substring(I + L - 1);
				tStr = S1 + "\'" + S2;
			}
			
			return tStr;
		}
		
		public string genEmailIdentifier(string MessageSize, string ReceivedTime, string SenderEmailAddress, string Subject, string CurrentUserID)
		{
			string EmailIdentifier = MessageSize + "~" + ReceivedTime + "~" + SenderEmailAddress + "~" + Subject.Substring(0, 80) + "~" + CurrentUserID;
			
			EmailIdentifier = PullOutSingleQuotes(EmailIdentifier);
			
			return EmailIdentifier;
		}
		
		public string getTempPdfWorkingDir()
		{
			string TempSysDir = System.IO.Path.GetTempPath() + "ECM\\PDA\\Extract";
			Directory D;
			if (! D.Exists(TempSysDir))
			{
				D.CreateDirectory(TempSysDir);
			}
			ZeroizeDir();
			return TempSysDir;
		}
		
		public string getTempPdfWorkingErrorDir()
		{
			string TempSysDir = System.IO.Path.GetTempPath() + "ECM\\FileERRORS";
			Directory D;
			if (! D.Exists(TempSysDir))
			{
				D.CreateDirectory(TempSysDir);
			}
			return TempSysDir;
		}
		
		private void ZeroizeDir()
		{
			
			string TempSysDir = System.IO.Path.GetTempPath() + "ECM\\PDA\\Extract";
			Directory D;
			if (! D.Exists(TempSysDir))
			{
				D.CreateDirectory(TempSysDir);
			}
			
			string s;
			foreach (string tempLoopVar_s in System.IO.Directory.GetFiles(TempSysDir))
			{
				s = tempLoopVar_s;
				try
				{
					System.IO.File.Delete(s);
				}
				catch (Exception ex)
				{
					Console.WriteLine("99.131 - " + ex.Message);
				}
				
			}
		}
		
		public string BlankOutSingleQuotes(string sText)
		{
			for (int i = 1; i <= sText.Length; i++)
			{
				string CH = sText.Substring(i - 1, 1);
				if (CH.Equals("\'"))
				{
					StringType.MidStmtStr(ref sText, i, 1, " ");
				}
			}
			return sText;
		}
		
		public int ExtractImages(string SourceGuid, string FQN, List<string> PdfImages)
		{
			
			
			string fName = System.IO.Path.GetFileName(FQN);
			string TempDir = getTempPdfWorkingDir();
			PdfImages.Clear();
			
			int RC = 0;
			
			try
			{
				// Load the PDF file.
				PDFDocument doc = new PDFDocument(FQN);
				try
				{
					// Serial number goes here
					doc.SerialNumber = "PDF4NET-H7WXK-B98L9-AOP4W-XLTFH-DRBS6";
					int i = 0;
					while (i < doc.Pages.Count)
					{
						// Convert the pages to PDFImportedPage to get access to ExtractImages method.
						PDFImportedPage ip = doc.Pages[i] as PDFImportedPage;
						Bitmap[] images = ip.ExtractImages();
						// Save the page images to disk, if there are any.
						int j = 0;
						while (j < images.Length)
						{
							RC++;
							string NewFileName = TempDir + "\\ECM.PDF.Image." + SourceGuid + "." + i.ToString() + "." + j.ToString() + ".TIF";
							images[j].Save(NewFileName, ImageFormat.Tiff);
							PdfImages.Add(NewFileName);
							j++;
						}
						i++;
						
						frmExchangeMonitor.Default.lblMessageInfo.Text = FQN + " : " + i.ToString() + ": Embedded Images";
						frmExchangeMonitor.Default.lblMessageInfo.Refresh();
						System.Windows.Forms.Application.DoEvents();
						
					}
				}
				catch (Exception ex)
				{
					WriteToArchiveLog((string) ("ERROR 02 clsPdfAnalyzer:ExtractImages Message - " + ex.Message));
				}
				finally
				{
					doc.Dispose();
				}
			}
			catch (Exception ex)
			{
				WriteToArchiveLog((string) ("ERROR 01 clsPdfAnalyzer:ExtractImages Message - " + ex.Message));
				WriteToArchiveLog((string) ("ERROR 02 clsPdfAnalyzer:ExtractImages FQN - " + FQN));
				Console.WriteLine(ex.Message);
				//Console.WriteLine(ex.InnerException.ToString)
			}
			return RC;
		}
		
		public void WriteToKeyLog(string sKey, bool AppendToFile)
		{
			
			string tFQN = GetKeyLogFileName();
			StreamWriter SW = new StreamWriter(tFQN, AppendToFile);
			
			try
			{
				//Dim cPath As String = GetCurrDir()
				// Create an instance of StreamWriter to write text to a file.
				using (SW)
				{
					// Add some text to the file.
					SW.WriteLine(sKey);
				}
				
			}
			catch (Exception ex)
			{
				if (dDeBug)
				{
					Console.WriteLine("clsDmaArch : WriteToArchiveLog : 688 : " + ex.Message);
				}
			}
			finally
			{
				SW.Close();
				SW.Dispose();
			}
		}
		
		public string GetKeyLogFileName()
		{
			string cPath = getTempEnvironDir();
			//Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
			
			string TempFolder = getEnvVarSpecialFolderApplicationData();
			
			string TempSysDir = TempFolder + "\\ECM\\KeyLog";
			Directory D;
			if (! D.Exists(TempSysDir))
			{
				D.CreateDirectory(TempSysDir);
			}
			
			TempFolder = TempSysDir;
			
			string M = DateTime.Now.Month.ToString().Trim();
			//Dim D  = Now.Day.ToString.Trim
			string Y = DateTime.Now.Year.ToString().Trim();
			
			//Dim SerialNo  = M + "." + D + "." + Y + "."
			string SerialNo = M + "." + Y + ".";
			
			string tFQN = TempFolder + "\\ECMLibrary.Archive.KeyLog.Log." + SerialNo + "txt";
			return tFQN;
		}
		
	}
	
}

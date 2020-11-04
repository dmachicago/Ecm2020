using System;
using System.Collections.Generic;
using System.Diagnostics;
using global::System.Drawing.Imaging;
using global::System.IO;
using global::System.Security.Principal;
using System.Windows.Forms;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using MODI;
using global::O2S.Components.PDF4NET;
using global::O2S.Components.PDF4NET.PDFFile;

namespace EcmArchiver
{
    public class clsLogging
    {
        private string LoggingPath = System.Configuration.ConfigurationManager.AppSettings["LoggingPath"];
        private bool ddebug = false;
        // Dim DMA As New clsDma

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
            return WindowsIdentity.GetCurrent().Name;
            // Return Environment.UserDomainName
        }

        public string getEnvVarUserID()
        {
            return Environment.UserName;
        }

        public void WriteToArchiveFileTraceLog(string Msg, bool Zeroize)
        {
            try
            {
                // Dim cPath As String = GetCurrDir()        
                string cPath = getTempEnvironDir();
                // Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.Archive.FileTrace.Log." + SerialNo + "txt";
                if (Zeroize)
                {
                    File F;
                    if (File.Exists(tFQN))
                    {
                        File.Delete(tFQN);
                        return;
                    }
                }
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToSaveSql(string Msg)
        {
            try
            {
                // Dim cPath As String = GetCurrDir()        
                string cPath = getTempEnvironDir();
                // Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string tFQN = cPath + @"\SQL.Archive.Generator.txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + "___________________________________________________________________________________" + Constants.vbCrLf);
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
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
                // Dim cPath As String = getTempEnvironDir()
                // Dim cpath  = getEnvVarSpecialFolderApplicationData()
                // Dim tFQN  = cpath  + "\ECMLibrary.SQL.Application.Log.txt"
                using (var sw = new StreamWriter(tFqn, true))
                {
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToTempSqlApplyFile(string Msg)
        {
            try
            {
                string cPath = getTempEnvironDir();
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string tFQN = cPath + @"\ECMLibrary.Archive.SQL.Statements.txt";
                using (var sw = new StreamWriter(tFQN, true))
                {
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToNewFile(string FileText, string FQN)
        {
            try
            {
                string cPath = getTempEnvironDir();
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string tFQN = FQN;
                using (var sw = new StreamWriter(tFQN, false))
                {
                    sw.WriteLine(FileText + Constants.vbCrLf);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void OpenEcmErrorLog()
        {
            try
            {
                // Dim cPath As String = GetCurrDir()        
                string cPath = getTempEnvironDir();
                // Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.Archive.Trace.ECMQry.Log." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                Process.Start("notepad.exe", tFQN);
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToOcrLog(string Msg)
        {
            try
            {
                // Dim cPath As String = GetCurrDir()        
                string cPath = getTempEnvironDir();
                // Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.Archive.OCR.Log." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }

                if (modGlobals.gRunUnattended == true)
                {
                    modGlobals.gUnattendedErrors += 1;
                    // FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
                    // FrmMDIMain.SB4.BackColor = Color.Silver
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToSqlLog(string Msg)
        {
            try
            {
                // Dim cPath As String = GetCurrDir()        
                string cPath = getTempEnvironDir();
                // Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.CLC.Archive.Event.Log." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }

                if (modGlobals.gRunUnattended == true)
                {
                    modGlobals.gUnattendedErrors += 1;
                    // FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
                    // FrmMDIMain.SB4.BackColor = Color.Silver
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToContentDuplicateLog(string TypeRec, string RecGuid, string RecIdentifier)
        {
            try
            {
                string cPath = getTempEnvironDir();
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string tFQN = cPath + @"\ECMLibrary.Archive.Duplicate.Content.Analysis.Log." + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + TypeRec + Conversions.ToString('þ') + RecGuid + Conversions.ToString('þ') + RecIdentifier + Constants.vbCrLf);
                    sw.Close();
                }

                if (modGlobals.gRunUnattended == true)
                {
                    modGlobals.gUnattendedErrors += 1;
                    // FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
                    // FrmMDIMain.SB4.BackColor = Color.Silver
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToEmailDuplicateLog(string TypeRec, string RecGuid, string RecIdentifier)
        {
            try
            {
                string cPath = getTempEnvironDir();
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string tFQN = cPath + @"\ECMLibrary.Archive.Duplicate.Email.Analysis.Log." + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + TypeRec + Conversions.ToString('þ') + RecGuid + Conversions.ToString('þ') + RecIdentifier + Constants.vbCrLf);
                    sw.Close();
                }

                if (modGlobals.gRunUnattended == true)
                {
                    modGlobals.gUnattendedErrors += 1;
                    // FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
                    // FrmMDIMain.SB4.BackColor = Color.Silver
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void LoadEmailDupLog(ref SortedList<string, string> L)
        {
            string cPath = getTempEnvironDir();
            if (Directory.Exists(LoggingPath))
            {
                cPath = LoggingPath;
            }
            else
            {
                try
                {
                    cPath = LoggingPath;
                    Directory.CreateDirectory(cPath);
                }
                catch (Exception ex)
                {
                    cPath = getTempEnvironDir();
                }
            }

            string tFQN = cPath + @"\ECMLibrary.Archive.Duplicate.Email.Analysis.Log." + "txt";
            string tGuid = "";
            string tHashKey = "";
            StreamReader srFileReader;
            string sInputLine;
            int I = 0;
            // 10/1/2010 8:32:12 AM: EÃ¾00002995-49b2-4306-ac83-440e3fa37f16Ã¾5f08a162d39aa43aec2c09f31458d3da

            srFileReader = File.OpenText(tFQN);
            sInputLine = srFileReader.ReadLine();
            // FrmMDIMain.SB4.Text = "Loading Hash Keys"
            // FrmMDIMain.Refresh()
            Application.DoEvents();
            while (!(sInputLine is null))
            {
                I += 1;
                sInputLine = sInputLine.Trim();
                if (sInputLine.Length == 0)
                {
                    goto GetNextLine;
                }

                if (I % 50 == 0)
                {
                    // FrmMDIMain.SB4.Text = "## " + I.ToString
                    // FrmMDIMain.Refresh()
                    Application.DoEvents();
                }

                string[] A;
                A = sInputLine.Split('þ');
                tGuid = A[1];
                tHashKey = A[2];
                try
                {
                    if (L.ContainsKey(tGuid))
                    {
                    }
                    // Console.WriteLine("Key Already Exists: " + tGuid)
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
                ;
                sInputLine = srFileReader.ReadLine();
            }
            // FrmMDIMain.SB4.Text = " - "
            Application.DoEvents();
        }

        public void LoadContentDupLog(ref SortedList<string, string> L)
        {
            string cPath = getTempEnvironDir();
            if (Directory.Exists(LoggingPath))
            {
                cPath = LoggingPath;
            }
            else
            {
                try
                {
                    cPath = LoggingPath;
                    Directory.CreateDirectory(cPath);
                }
                catch (Exception ex)
                {
                    cPath = getTempEnvironDir();
                }
            }

            string tFQN = cPath + @"\ECMLibrary.Archive.Duplicate.Content.Analysis.Log." + "txt";
            string tGuid = "";
            string tHashKey = "";
            StreamReader srFileReader;
            string sInputLine;
            int I = 0;
            // 10/1/2010 8:32:12 AM: EÃ¾00002995-49b2-4306-ac83-440e3fa37f16Ã¾5f08a162d39aa43aec2c09f31458d3da

            srFileReader = File.OpenText(tFQN);
            sInputLine = srFileReader.ReadLine();
            // FrmMDIMain.SB4.Text = "Loading Hash Keys"
            // FrmMDIMain.Refresh()
            Application.DoEvents();
            while (!(sInputLine is null))
            {
                I += 1;
                sInputLine = sInputLine.Trim();
                if (sInputLine.Length == 0)
                {
                    goto GetNextLine;
                }

                if (I % 50 == 0)
                {
                    // FrmMDIMain.SB4.Text = "## " + I.ToString
                    // FrmMDIMain.Refresh()
                    Application.DoEvents();
                }

                string[] A;
                A = sInputLine.Split('þ');
                tGuid = A[1];
                tHashKey = A[2];
                try
                {
                    if (L.ContainsKey(tGuid))
                    {
                    }
                    // Console.WriteLine("Key Already Exists: " + tGuid)
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
                ;
                sInputLine = srFileReader.ReadLine();
            }
            // FrmMDIMain.SB4.Text = " - "
            Application.DoEvents();
        }

        public void WriteToNoticeLog(string Msg)
        {
            try
            {
                // Dim cPath As String = GetCurrDir()        
                string cPath = getTempEnvironDir();
                // Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.Archive.Notice.Log." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }

                if (modGlobals.gRunUnattended == true)
                {
                    modGlobals.gUnattendedErrors += 1;
                    // FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
                    // FrmMDIMain.SB4.BackColor = Color.Silver
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToPDFLog(string Msg)
        {
            try
            {
                // Dim cPath As String = GetCurrDir()        
                string cPath = getTempEnvironDir();
                // Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.Archive.PDF.Log." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }

                if (modGlobals.gRunUnattended == true)
                {
                    modGlobals.gUnattendedErrors += 1;
                    // FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
                    // FrmMDIMain.SB4.BackColor = Color.Silver
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToParmLog(string Msg)
        {
            try
            {
                string cPath = getTempEnvironDir();
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.Archive.Installation.Parm.Log." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToInstallLog(string Msg)
        {
            try
            {
                // Dim cPath As String = GetCurrDir()        
                string cPath = getTempEnvironDir();
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.Archive.Client.Installation.Log." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToListenLog(string Msg)
        {
            try
            {
                // Dim cPath As String = GetCurrDir()        
                string cPath = getTempEnvironDir();
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.Archive.Client.Listen.Log." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteListenerLog(string Msg)
        {
            try
            {
                string cPath = getTempEnvironDir();
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string tFQN = cPath + @"\ListenerFilesLog.ECM";
                using (var sw = new StreamWriter(tFQN, true))
                {
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteListenerLog : 688 : " + ex.Message);
            }
        }

        public void WriteToAttachLog(string Msg)
        {
            try
            {
                string cPath = getTempEnvironDir();
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.Archive.Client.Attach.Log." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToAttachLog : 688 : " + ex.Message);
            }
        }

        public void WriteToEbExecLog(string Msg)
        {
            try
            {
                // Dim cPath As String = GetCurrDir()        
                string cPath = getTempEnvironDir();
                // Dim tFQN  = cPath + "\ECMLibrary.DBARCH.ExecQry.Log.txt"
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.Archive.DBARCH.ExecQry.Log." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToErrorLog(string Msg)
        {
            try
            {
                // Dim cPath As String = GetCurrDir()        
                string cPath = getTempEnvironDir();
                // Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.Archive.Error.Log." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToErrorLog : 688 : " + ex.Message);
            }
        }

        public void WriteToTraceLog(string Msg)
        {
            try
            {
                string cPath = getTempEnvironDir();
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.Archive.Trace." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToCrawlerLog(string Msg)
        {
            try
            {
                // Dim cPath As String = GetCurrDir()        
                string cPath = getTempEnvironDir();
                // Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"


                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.Archive.WebCrawl." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public string getArchiveLogPath()
        {
            string cpath = "";
            try
            {
                cpath = getEnvVarSpecialFolderApplicationData();
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }

            return cpath;
        }

        public void WriteToArchiveLog(string Msg, Exception ex1)
        {
            try
            {

                // Dim st As New StackTrace(True)
                // st = New StackTrace(ex1, True)

                string errmsg = "eRRmSG: " + ex1.Message;
                // Dim linemsg As String = "Line: " & st.GetFrame(0).GetFileLineNumber().ToString

                if (errmsg.Contains("Access to the path"))
                {
                    var wi = WindowsIdentity.GetCurrent();
                    string userIdentity = wi.Name;
                    string AuthenticationType = wi.AuthenticationType;
                    errmsg = errmsg + Constants.vbCrLf + "userIdentity: " + userIdentity;
                    errmsg = errmsg + Constants.vbCrLf + "AuthenticationType: " + AuthenticationType;
                    errmsg = errmsg + Constants.vbCrLf + "IsAuthenticated: " + wi.IsAuthenticated.ToString();
                    wi.Dispose();
                }

                WriteToArchiveLog(errmsg);
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
                var st = new StackTrace(true);
                st = new StackTrace(ex, true);
            }
        }

        public void WriteToArchiveLog(string Msg)
        {
            try
            {
                string cPath = getTempEnvironDir();
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.Archive.Log." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToDBUpdatesLog(string Msg)
        {
            try
            {
                string cPath = getTempEnvironDir();
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.DBUpdates.Log." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    sw.WriteLine("-- " + DateAndTime.Now.ToString());
                    sw.WriteLine(Msg + Constants.vbCrLf);
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToDeleteLog(string Msg)
        {
            try
            {
                string cPath = getTempEnvironDir();
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.Delete.Log." + SerialNo + "txt";
                using (var sw = new StreamWriter(tFQN, true))
                {
                    sw.WriteLine(DateAndTime.Now.ToString() + "|" + Msg);
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToDirAnalysisLog(string Msg, bool ZeroizeFile)
        {
            try
            {
                string cPath = getTempEnvironDir();
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.DIrAnalysis.Log." + SerialNo + "txt";
                if (ZeroizeFile.Equals(true) & File.Exists(tFQN))
                {
                    File.Delete(tFQN);
                    return;
                }

                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg);
                    // sw.Close()
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToDirFileLog(string Msg)
        {
            try
            {
                string cPath = getTempEnvironDir();
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.DirectoryFile.Error.Log." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToInventoryLog(bool xexists, string FQN)
        {
            try
            {
                string cPath = getTempEnvironDir();
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string Msg = "";
                string tFQN = cPath + @"\ECMLibrary.Inventory.Log." + SerialNo + "txt";
                // If File.Exists(tFQN) Then
                // File.Delete(tFQN)
                // End If
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    if (xexists)
                    {
                        Msg = "FOUND: " + FQN;
                    }
                    else
                    {
                        Msg = "MISSING: " + FQN;
                    }

                    sw.WriteLine(Msg);
                    // sw.Close()
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToUploadLog(string Msg)
        {
            try
            {
                string cPath = getTempEnvironDir();
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.Upload.Log." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToAttachmentSearchyLog(string Msg)
        {
            try
            {
                // Dim cPath As String = GetCurrDir()        
                string cPath = getTempEnvironDir();
                // Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.Archive.AttachSearch.Trace.Log." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void ZeroizeSaveSql()
        {
            try
            {
                // Dim cPath As String = GetCurrDir()        
                string cPath = getTempEnvironDir();
                // Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"

                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string tFQN = cPath + @"\ SQL.Archive.Generator.txt";
                File F;
                if (File.Exists(tFQN))
                {
                    File.Delete(tFQN);
                }

                F = null;
                GC.Collect();
                GC.WaitForPendingFinalizers();
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void CleanOutTempDirectoryImmediate()
        {
            try
            {
                string cpath = getEnvVarSpecialFolderApplicationData();
                Directory storefile;
                string directory;
                string[] files;
                files = Directory.GetFiles(cpath, "ECM*.*");
                TimeSpan T;
                foreach (var FQN in files)
                {
                    try
                    {
                        FileSystem.Kill(FQN);
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Delete Notice: " + FQN + Constants.vbCrLf + ex.Message);
                    }
                }
            }
            catch (Exception ex)
            {
                WriteToArchiveLog("NOTICE CleanOutTempDirectory: " + ex.Message);
            }
        }

        public void CleanOutTempDirectory()
        {
            try
            {
                string cpath = getEnvVarSpecialFolderApplicationData();
                Directory storefile;
                string directory;
                string[] files;
                files = Directory.GetFiles(cpath, "ECM*.*");
                TimeSpan T;
                foreach (var FQN in files)
                {
                    var FileDate = GetFileCreateDate(FQN);

                    // Dim objFileInfo As New FileInfo(FQN)
                    // Dim dtCreationDate As DateTime = objFileInfo.CreationTime

                    TimeSpan tsTimeSpan;
                    int iNumberOfDays;
                    string strMsgText;
                    tsTimeSpan = DateAndTime.Now.Subtract(FileDate);
                    iNumberOfDays = tsTimeSpan.Days;
                    if (iNumberOfDays > modGlobals.gDaysToKeepTraceLogs)
                    {
                        FileSystem.Kill(FQN);
                    }
                }
            }
            catch (Exception ex)
            {
                WriteToArchiveLog("NOTICE CleanOutTempDirectory: " + ex.Message);
            }
        }

        public void CleanOutErrorDirectoryImmediate()
        {
            try
            {
                var UTIL = new clsUtility();
                string cpath = UTIL.getTempPdfWorkingErrorDir();
                UTIL = null;
                Directory storefile;
                string directory;
                string[] files;
                files = Directory.GetFiles(cpath, "*.*");
                TimeSpan T;
                foreach (var FQN in files)
                {
                    try
                    {
                        FileSystem.Kill(FQN);
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show("Delete Notice: " + FQN + Constants.vbCrLf + ex.Message);
                    }
                }
            }
            catch (Exception ex)
            {
                WriteToArchiveLog("NOTICE CleanOutTempDirectory: " + ex.Message);
            }
        }

        public void CleanOutErrorDirectory()
        {
            try
            {
                var UTIL = new clsUtility();
                string cpath = UTIL.getTempPdfWorkingErrorDir();
                UTIL = null;
                Directory storefile;
                string directory;
                string[] files;
                files = Directory.GetFiles(cpath, "*.*");
                TimeSpan T;
                foreach (var FQN in files)
                {
                    var FileDate = GetFileCreateDate(FQN);

                    // Dim objFileInfo As New FileInfo(FQN)
                    // Dim dtCreationDate As DateTime = objFileInfo.CreationTime

                    TimeSpan tsTimeSpan;
                    int iNumberOfDays;
                    string strMsgText;
                    tsTimeSpan = DateAndTime.Now.Subtract(FileDate);
                    iNumberOfDays = tsTimeSpan.Days;
                    if (iNumberOfDays > modGlobals.gDaysToKeepTraceLogs)
                    {
                        FileSystem.Kill(FQN);
                    }
                }
            }
            catch (Exception ex)
            {
                WriteToArchiveLog("NOTICE CleanOutTempDirectory: " + ex.Message);
            }
        }

        public int GetFileSize(string MyFilePath)
        {
            var MyFile = new FileInfo(MyFilePath);
            int FileSize = (int)MyFile.Length;
            MyFile = null;
            return FileSize;
        }

        public DateTime GetFileCreateDate(string MyFilePath)
        {
            var MyFile = new FileInfo(MyFilePath);
            var FileDate = MyFile.CreationTime;
            MyFile = null;
            return FileDate;
        }

        public void WriteToTempFile(string FQN, string Msg)
        {
            try
            {
                using (var sw = new StreamWriter(FQN, true))
                {
                    sw.WriteLine(Msg + Constants.vbCrLf);
                    sw.Close();
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToTempFile : 688 : " + ex.Message);
            }
        }

        public void PurgeDirectory(string DirectoryName, string Pattern)
        {
            try
            {
                string cpath = getEnvVarSpecialFolderApplicationData();
                Directory storefile = null;
                // Dim directory As String = ""
                string[] files;
                files = Directory.GetFiles(DirectoryName, Pattern);
                // Dim T As TimeSpan

                foreach (var FQN in files)
                {
                    var FileDate = GetFileCreateDate(FQN);
                    TimeSpan tsTimeSpan;
                    int iNumberOfMin;
                    tsTimeSpan = DateAndTime.Now.Subtract(FileDate);
                    iNumberOfMin = tsTimeSpan.Minutes;
                    if (iNumberOfMin > 1)
                    {
                        FileSystem.Kill(FQN);
                    }
                }
            }
            catch (Exception ex)
            {
                WriteToArchiveLog("NOTICE CleanOutTempDirectory: " + ex.Message);
            }
        }

        public void WriteToProcessLog(string Msg)
        {
            try
            {
                // Dim cPath As String = GetCurrDir()        
                string cPath = getTempEnvironDir();
                // Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"


                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.Archive.Memory.Process.Log." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.                                    
                    sw.WriteLine(DateAndTime.Now.ToString() + ": " + Msg + Constants.vbCrLf);
                    sw.Close();
                }

                if (modGlobals.gRunUnattended == true)
                {
                    modGlobals.gUnattendedErrors += 1;
                    // FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
                    // FrmMDIMain.SB4.BackColor = Color.Silver
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToTimerLog(string LocaterID, string TimerName, string StartStop, DateTime StartTime = default)
        {
            TimeSpan ExecutionTime;
            string sExecutionTime = "";
            if (StartTime == default)
            {
            }
            else
            {
                var stop_time = DateAndTime.Now;
                ExecutionTime = stop_time.Subtract(StartTime);
                sExecutionTime = ExecutionTime.TotalSeconds.ToString("0.000000");
            }

            try
            {
                // Dim cPath As String = GetCurrDir()        
                string cPath = getTempEnvironDir();
                // Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"


                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.Archive.Timer.Log." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.   
                    if (sExecutionTime.Length > 0)
                    {
                        sw.WriteLine(TimerName + " : " + StartStop + " : " + TimerName + " : Elapsed Time: " + sExecutionTime + " : " + DateAndTime.Now.ToString());
                    }
                    else
                    {
                        sw.WriteLine(TimerName + " : " + StartStop + " : " + TimerName + " : " + DateAndTime.Now.ToString());
                    }

                    sw.Close();
                }

                if (modGlobals.gRunUnattended == true)
                {
                    modGlobals.gUnattendedErrors += 1;
                    // FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
                    // FrmMDIMain.SB4.BackColor = Color.Silver
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteToFileProcessLog(string FQN)
        {
            try
            {
                string cPath = getTempEnvironDir();
                if (Directory.Exists(LoggingPath))
                {
                    cPath = LoggingPath;
                }
                else
                {
                    try
                    {
                        cPath = LoggingPath;
                        Directory.CreateDirectory(cPath);
                    }
                    catch (Exception ex)
                    {
                        cPath = getTempEnvironDir();
                    }
                }

                string M = DateAndTime.Now.Month.ToString().Trim();
                string D = DateAndTime.Now.Day.ToString().Trim();
                string Y = DateAndTime.Now.Year.ToString().Trim();
                string SerialNo = M + "." + D + "." + Y + ".";
                string tFQN = cPath + @"\ECMLibrary.Archive.FilesProcessed.Log." + SerialNo + "txt";
                // Create an instance of StreamWriter to write text to a file.
                using (var sw = new StreamWriter(tFQN, true))
                {
                    // Add some text to the file.   
                    sw.WriteLine(DateAndTime.Now.ToString() + " : " + FQN);
                    sw.Close();
                }

                if (modGlobals.gRunUnattended == true)
                {
                    modGlobals.gUnattendedErrors += 1;
                    // FrmMDIMain.SB4.Text = " " + gUnattendedErrors.ToString
                    // FrmMDIMain.SB4.BackColor = Color.Silver
                }
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDma : WriteToArchiveLog : 688 : " + ex.Message);
            }
        }

        public void WriteMemoryTrack()
        {
            foreach (var p in Process.GetProcesses())
            {
                string S = "";
                double D = Conversions.ToDouble(((double)p.WorkingSet64).ToString());
                string P1 = p.ToString().Remove(0, 27);
                string P2 = D / 1000000d + " MB";
                if (Strings.InStr(P1, "ECM", CompareMethod.Text) > 0)
                {
                    WriteToProcessLog(P1 + " : " + P2);
                }
            }
        }

        public string PullOutSingleQuotes(string tVal)
        {
            if (Strings.InStr(tVal, "'") == 0)
            {
                return tVal;
            }

            if (Strings.InStr(tVal, "''") > 0)
            {
                return tVal;
            }

            int i = Strings.Len(tVal);
            string ch = "";
            string NewStr = "";
            string S1 = "";
            string S2 = "";
            string[] A;
            if (Strings.InStr(1, tVal, "'") > 0)
            {
                A = tVal.Split('\'');
                var loopTo = Information.UBound(A);
                for (i = 0; i <= loopTo; i++)
                    NewStr = NewStr + A[i].Trim() + "''";
                NewStr = Strings.Mid(NewStr, 1, NewStr.Length - 2);
            }
            else
            {
                NewStr = tVal;
            }

            return NewStr;
        }

        public string PutBackSingleQuotes(string tStr)
        {
            if (Strings.InStr(tStr, "''") == 0)
            {
                return tStr;
            }

            string TgtStr = "''";
            string S1 = "";
            string S2 = "";
            int L = Strings.Len(TgtStr);
            int I = 0;
            while (Strings.InStr(tStr, TgtStr, CompareMethod.Text) > 0)
            {
                I = Strings.InStr(tStr, TgtStr, CompareMethod.Text);
                S1 = Strings.Mid(tStr, 1, I - 1);
                S2 = Strings.Mid(tStr, I + L);
                tStr = S1 + "'" + S2;
            }

            return tStr;
        }

        public string genEmailIdentifier(string MessageSize, string ReceivedTime, string SenderEmailAddress, string Subject, string CurrentUserID)
        {
            string EmailIdentifier = MessageSize + "~" + ReceivedTime + "~" + SenderEmailAddress + "~" + Strings.Mid(Subject, 1, 80) + "~" + CurrentUserID;
            EmailIdentifier = PullOutSingleQuotes(EmailIdentifier);
            return EmailIdentifier;
        }

        public string getTempPdfWorkingDir()
        {
            string TempSysDir = Path.GetTempPath() + @"ECM\PDA\Extract";
            Directory D;
            if (!Directory.Exists(TempSysDir))
            {
                Directory.CreateDirectory(TempSysDir);
            }

            ZeroizeDir();
            return TempSysDir;
        }

        public string getTempPdfWorkingErrorDir()
        {
            string TempSysDir = Path.GetTempPath() + @"ECM\FileERRORS";
            Directory D;
            if (!Directory.Exists(TempSysDir))
            {
                Directory.CreateDirectory(TempSysDir);
            }

            return TempSysDir;
        }

        private void ZeroizeDir()
        {
            string TempSysDir = Path.GetTempPath() + @"ECM\PDA\Extract";
            Directory D;
            if (!Directory.Exists(TempSysDir))
            {
                Directory.CreateDirectory(TempSysDir);
            }

            foreach (var s in Directory.GetFiles(TempSysDir))
            {
                try
                {
                    File.Delete(s);
                }
                catch (Exception ex)
                {
                    Console.WriteLine("99.131 - " + ex.Message);
                }
            }
        }

        public string BlankOutSingleQuotes(string sText)
        {
            for (int i = 1, loopTo = sText.Length; i <= loopTo; i++)
            {
                string CH = Strings.Mid(sText, i, 1);
                if (CH.Equals("'"))
                {
                    StringType.MidStmtStr(ref sText, i, 1, " ");
                }
            }

            return sText;
        }

        public int ExtractImages(string SourceGuid, string FQN, ref List<string> PdfImages)
        {
            string fName = Path.GetFileName(FQN);
            string TempDir = getTempPdfWorkingDir();
            PdfImages.Clear();
            int RC = 0;
            try
            {
                // Load the PDF file.
                var doc = new PDFDocument(FQN);
                try
                {
                    // Serial number goes here
                    doc.SerialNumber = "PDF4NET-H7WXK-B98L9-AOP4W-XLTFH-DRBS6";
                    int i = 0;
                    while (i < doc.Pages.Count)
                    {
                        // Convert the pages to PDFImportedPage to get access to ExtractImages method.
                        PDFImportedPage ip = doc.Pages[i] as PDFImportedPage;
                        var images = ip.ExtractImages();
                        // Save the page images to disk, if there are any.
                        int j = 0;
                        while (j < images.Length)
                        {
                            RC += 1;
                            string NewFileName = TempDir + @"\ECM.PDF.Image." + SourceGuid + "." + i.ToString() + "." + j.ToString() + ".TIF";
                            images[j].Save(NewFileName, ImageFormat.Tiff);
                            PdfImages.Add(NewFileName);
                            j = j + 1;
                        }

                        i = i + 1;
                        My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Text = FQN + " : " + i.ToString() + ": Embedded Images";
                        My.MyProject.Forms.frmExchangeMonitor.lblMessageInfo.Refresh();
                        Application.DoEvents();
                    }
                }
                catch (Exception ex)
                {
                    WriteToArchiveLog("ERROR 02 clsPdfAnalyzer:ExtractImages Message - " + ex.Message);
                }
                finally
                {
                    doc.Dispose();
                }
            }
            catch (Exception ex)
            {
                WriteToArchiveLog("ERROR 01 clsPdfAnalyzer:ExtractImages Message - " + ex.Message);
                WriteToArchiveLog("ERROR 02 clsPdfAnalyzer:ExtractImages FQN - " + FQN);
                Console.WriteLine(ex.Message);
                // Console.WriteLine(ex.InnerException.ToString)
            }

            return RC;
        }

        public void WriteToKeyLog(string sKey, bool AppendToFile)
        {
            string tFQN = GetKeyLogFileName();
            var SW = new StreamWriter(tFQN, AppendToFile);
            try
            {
                // Dim cPath As String = GetCurrDir()        
                // Create an instance of StreamWriter to write text to a file.
                using (SW)
                    // Add some text to the file.                                    
                    SW.WriteLine(sKey);
            }
            catch (Exception ex)
            {
                if (ddebug)
                    Console.WriteLine("clsDmaArch : WriteToArchiveLog : 688 : " + ex.Message);
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
            // Dim tFQN  = cPath + "\ECMLibrary.Trace.EMCQry.Log.txt"


            if (Directory.Exists(LoggingPath))
            {
                cPath = LoggingPath;
            }
            else
            {
                try
                {
                    cPath = LoggingPath;
                    Directory.CreateDirectory(cPath);
                }
                catch (Exception ex)
                {
                    cPath = getTempEnvironDir();
                }
            }

            string TempSysDir = cPath + @"\ECM\KeyLog";
            Directory D;
            if (!Directory.Exists(TempSysDir))
            {
                Directory.CreateDirectory(TempSysDir);
            }

            cPath = TempSysDir;
            string M = DateAndTime.Now.Month.ToString().Trim();
            // Dim D  = Now.Day.ToString.Trim
            string Y = DateAndTime.Now.Year.ToString().Trim();

            // Dim SerialNo  = M + "." + D + "." + Y + "."
            string SerialNo = M + "." + Y + ".";
            string tFQN = cPath + @"\ECMLibrary.Archive.KeyLog.Log." + SerialNo + "txt";
            return tFQN;
        }
    }
}
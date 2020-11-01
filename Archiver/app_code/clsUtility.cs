using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Drawing;
using global::System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using global::System.Threading;
using System.Windows.Forms;
using global::ECMEncryption;
using Microsoft.VisualBasic;
using Microsoft.VisualBasic.CompilerServices;
using global::Microsoft.Win32;
using MODI;

namespace EcmArchiver
{
    public class clsUtility
    {
        private clsLogging LOG = new clsLogging();
        private clsIsolatedStorage ISO = new clsIsolatedStorage();
        private ECMEncrypt ENC = new ECMEncrypt();
        private clsDbLocal dblocal = new clsDbLocal();

        public enum OnOff
        {
            TurnON = 1,
            TurnOFF = 0
        }

        private static PerformanceCounter ramCounter = new PerformanceCounter("Memory", "Available MBytes");

        [DllImport("kernel32.dll")]
        private static extern long GetTickCount();

        private void wait(int seconds)
        {
            for (int i = 0, loopTo = seconds * 100; i <= loopTo; i++)
            {
                Thread.Sleep(10);
                Application.DoEvents();
            }
        }

        public List<string> getListenerDirs()
        {
            var ListOfDirs = new List<string>();
            string fqn = "";
            string[] S = null;
            var sr = new StreamReader(modGlobals.SQLiteListenerDB);
            string strLine = string.Empty;
            DateTime RowDate = default;
            int Rowid = 0;
            string action = "";
            string dir = "";
            string FileFQN = "";
            string ext = "";
            int DirCnt = 0;
            try
            {
                while (sr.Peek() >= 0)
                {
                    strLine = string.Empty;
                    strLine = sr.ReadLine();
                    S = strLine.Split('|');
                    if (ext.Equals("?"))
                    {
                        dir = S[4];
                    }
                    else
                    {
                        dir = S[3];
                    }

                    if (!ListOfDirs.Contains(dir))
                    {
                        ListOfDirs.Add(dir);
                    }

                    DirCnt += 1;
                }

                return ListOfDirs;
            }
            catch (Exception ex)
            {
                ListOfDirs.Clear();
                return ListOfDirs;
            }
        }

        public List<string> getListenerFiles()
        {
            var ListOfFiles = new List<string>();
            string fqn = "";
            string[] S = null;
            var sr = new StreamReader(modGlobals.SQLiteListenerDB);
            string strLine = string.Empty;
            DateTime RowDate = default;
            int Rowid = 0;
            string action = "";
            string dir = "";
            string FileFQN = "";
            string ext = "";
            int DirCnt = 0;
            try
            {
                while (sr.Peek() >= 0)
                {
                    strLine = string.Empty;
                    strLine = sr.ReadLine();
                    S = strLine.Split('|');
                    RowDate = Convert.ToDateTime(S[0]);
                    Rowid = Convert.ToInt32(S[1]);
                    action = S[2];
                    dir = S[3];
                    FileFQN = S[4];
                    ext = S[5];
                    // 10/11/2020 3:21:27 PM|21|U|C:\Users\wdale\Documents\Visual Studio 2017\Backup Files|C:\Users\wdale\Documents\Visual Studio 2017\Backup Files\Archiver|?
                    if (!ext.Equals("?"))
                    {
                        if (!ListOfFiles.Contains(FileFQN))
                        {
                            ListOfFiles.Add(FileFQN);
                        }

                        DirCnt += 1;
                    }
                }

                return ListOfFiles;
            }
            catch (Exception ex)
            {
                ListOfFiles.Clear();
                return ListOfFiles;
            }
        }

        public string ConvertUrlToFQN(string DirPath, string URL, string FileExt)
        {
            string[] S;
            string WebFQN = URL.ToUpper();
            WebFQN = WebFQN.Replace(".COM", "");
            WebFQN = WebFQN.Replace("HTTPS", "");
            WebFQN = WebFQN.Replace("HTTP", "");
            WebFQN = WebFQN.Replace("//", "");
            WebFQN = WebFQN.Replace("/", " ");
            WebFQN = WebFQN.Replace(".", " ");
            WebFQN = WebFQN.Replace(":", "");
            WebFQN = WebFQN.Replace("?", " ");
            WebFQN = WebFQN.Replace("=", " ");
            WebFQN = WebFQN.Replace(@"\", "");
            WebFQN = WebFQN.Replace("*", "");
            WebFQN = WebFQN.Replace("<", "");
            WebFQN = WebFQN.Replace(">", "");
            WebFQN = WebFQN.Replace("|", "");
            WebFQN = WebFQN.Replace("-", " ");
            WebFQN = WebFQN.Replace(",", " ");
            WebFQN = WebFQN.Replace("#", " ");
            string sToken = "";
            S = WebFQN.Split(' ');
            if (S.Count() > 0)
            {
                WebFQN = "";
                foreach (string stemp in S)
                {
                    stemp = stemp.ToLower();
                    if (stemp.Length > 0)
                    {
                        var midTmp = Strings.Mid(stemp, 1, 1).ToUpper();
                        StringType.MidStmtStr(ref stemp, 1, 1, midTmp);
                        WebFQN += stemp;
                    }
                }
            }

            WebFQN = DirPath + WebFQN + FileExt;
            return WebFQN;
        }

        public int countApplicationInstances(string AppName)
        {
            int AppCnt = 0;
            string pName = "";
            foreach (Process p in Process.GetProcesses())
            {
                pName = p.ProcessName.ToUpper();
                Console.WriteLine(pName);
                if (pName.Equals(AppName))
                {
                    AppCnt += 1;
                }
            }

            return AppCnt;
        }

        public bool isImage(string FQN)
        {
            string fExt = "";
            var MyFile = new FileInfo(FQN);
            if (MyFile.Exists)
            {
                try
                {
                    fExt = MyFile.Extension;
                    fExt = getFileSuffix(FQN);
                    if (Strings.InStr(fExt, ".") == 0)
                    {
                        fExt = "." + fExt;
                    }
                }
                catch (Exception ex)
                {
                    Debug.Print(ex.Message);
                    LOG.WriteToArchiveLog("clsModi : isImageFile : 10 : " + ex.Message);
                }
            }
            else
            {
                return false;
            }

            fExt = fExt.ToUpper();
            bool B = false;
            if (fExt.Equals(".JPG"))
            {
                B = true;
            }
            else if (fExt.Equals(".JPEG"))
            {
                B = true;
            }
            else if (fExt.Equals(".BMP"))
            {
                B = true;
            }
            else if (fExt.Equals(".PNG"))
            {
                B = true;
            }
            else if (fExt.Equals(".TRF"))
            {
                B = true;
            }
            else if (fExt.Equals(".TIFF"))
            {
                B = true;
            }
            else if (fExt.Equals(".TIF"))
            {
                B = true;
            }
            else if (fExt.Equals(".GIF"))
            {
                B = true;
            }
            else if (fExt.Equals(".TIF"))
            {
                B = true;
            }
            else
            {
                B = false;
            }

            return B;
        }

        public void RemoveBlanks(ref string tStr)
        {
            string S = tStr;
            string NewStr = "";
            int BlankCnt = 0;
            string CH = "";
            for (int i = 1, loopTo = S.Length; i <= loopTo; i++)
            {
                CH = Strings.Mid(S, i, 1);
                if (CH.Equals(" "))
                {
                    BlankCnt += 1;
                }
                else if (CH.Equals(Conversions.ToString('\t')))
                {
                    BlankCnt += 1;
                }
                else if (CH.Equals(Conversions.ToString('"')))
                {
                    BlankCnt += 1;
                }
                else if (CH.Equals(Constants.vbCrLf))
                {
                    BlankCnt += 1;
                }
                else if (CH.Equals(Constants.vbCr))
                {
                    BlankCnt += 1;
                }
                else if (CH.Equals(Constants.vbLf))
                {
                    BlankCnt += 1;
                }
                else
                {
                    NewStr = NewStr + CH;
                }
            }

            tStr = NewStr;
        }

        public int spaceCnt(string FQN)
        {
            int I = 0;
            int iCnt = 0;
            var loopTo = FQN.Length;
            for (I = 1; I <= loopTo; I++)
            {
                string CH = Strings.Mid(FQN, I, 1);
                if (CH.Equals(" "))
                {
                    iCnt += 1;
                }
            }

            return iCnt;
        }

        public string getTempProcessingDir()
        {
            string S = "";
            try
            {
                S = System.Configuration.ConfigurationManager.AppSettings["TempProcessingDir"];
                if (spaceCnt(S) > 0)
                {
                    LOG.WriteToArchiveLog(@"ERROR: getTempProcessingDir (config.app) CANNOT HAVE SPACES IN THE NAME, defauling to C:\TempUploads\");
                    S = @"C:\TempUploads\";
                    if (!Directory.Exists(S))
                    {
                        Directory.CreateDirectory(S);
                    }
                }
            }
            catch (Exception ex)
            {
                S = @"C:\TempUploads\";
                if (!Directory.Exists(S))
                {
                    Directory.CreateDirectory(S);
                }
            }

            if (!Strings.Mid(S, S.Length, 1).Equals(@"\"))
            {
                S = S + @"\";
            }

            return S;
        }

        public string GetParentImageProcessingFile()
        {
            string S = "";
            try
            {
                S = System.Configuration.ConfigurationManager.AppSettings["PdfProcessingDir"];
                if (spaceCnt(S) > 0)
                {
                    LOG.WriteToArchiveLog(@"ERROR: PdfProcessingDir (config.app) CANNOT HAVE SPACES IN THE NAME, defauling to C:\TempUploads\");
                    S = @"C:\TempUploads\";
                    if (!Directory.Exists(S))
                    {
                        Directory.CreateDirectory(S);
                    }
                }
            }
            catch (Exception ex)
            {
                S = @"C:\TempUploads\";
                if (!Directory.Exists(S))
                {
                    Directory.CreateDirectory(S);
                }
            }

            return S;
        }

        public string getTempPdfWorkingErrorDir()
        {
            string TempSysDir = GetParentImageProcessingFile() + @"\ErrorFiles\";
            if (!Directory.Exists(TempSysDir))
            {
                Directory.CreateDirectory(TempSysDir);
            }

            return TempSysDir;
        }

        private void ZeroizePdaDir()
        {
            string TempSysDir = GetParentImageProcessingFile() + @"ECM\OCR\Extract";
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

        public void StripUnwantedChars(ref string sText)
        {
            string NewText = "";
            for (int i = 1, loopTo = sText.Length; i <= loopTo; i++)
            {
                string CH = Strings.Mid(sText, i, 1);
                if (CH.Equals("/"))
                {
                    CH = ".";
                }
                else if (CH.Equals(" "))
                {
                    CH = "_";
                }

                if (Strings.InStr("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_.@-01233456789", CH, CompareMethod.Text) > 0)
                {
                    NewText = NewText + CH;
                }
            }

            sText = NewText;
        }

        public int getNbrDaysComputerRunning()
        {
            int TotalDaysRunning = 0;
            try
            {
                double dTicks; // Store the number of days the systems has been running
                dTicks = GetTickCount() / 1000d / 60d / 60d / 24d;
                TimeSpan T;
                dTicks = dTicks * -1;
                var DateStartedRunning = DateAndTime.Now.AddDays(dTicks);
                T = DateAndTime.Now.Subtract(DateStartedRunning);
                TotalDaysRunning = (int)T.TotalDays;
            }
            catch (Exception ex)
            {
                TotalDaysRunning = 2;
            }

            return TotalDaysRunning;
        }

        // Here is a call that uses the function above to determine if Excel is installed:
        // MessageBox.Show("Is MS Excel installed? - " & IsApplicationInstalled("Excel.Application").ToString)
        // RESULT:  Is MS Excell Installed? – True
        public bool IsApplicationInstalled(string pSubKey)
        {
            bool isInstalled = false;

            // Declare a variable of type RegistryKey named classesRootRegisteryKey.
            // Assign the Registry's ClassRoot key to the classesRootRegisteryKey 
            // variable.
            var classesRootRegistryKey = Registry.ClassesRoot;

            // Declare a variable of type RegistryKey named subKeyRegistryKey.
            // Call classesRootRegistryKey's OpenSubKey method passing in the 
            // pSubKey parameter passed into this function. 
            // Assign the result returned to suKeyRegistryKey.
            var subKeyRegistryKey = classesRootRegistryKey.OpenSubKey(pSubKey);

            // If subKeyRegistryKey was assigned a value...
            if (subKeyRegistryKey is object)
            {
                // Key exists; application is installed.
                isInstalled = true;
            }

            // Close the subKeyRgisteryKey.
            subKeyRegistryKey.Close();
            return isInstalled;
        }

        public bool isOfficeInstalled()
        {
            // Microsoft Office Enterprise 2007 | 12 | 0 | 1
            // Microsoft Office Professional Edition 2003 | 11 | 0 | 1
            var LOS = new List<string>();
            LOS = getInstalledSoftware();
            foreach (string S in LOS)
            {
                if (Strings.InStr(S, "Microsoft Office", CompareMethod.Text) > 0)
                {
                    var A = S.Split('|');
                    if (A.Length > 1)
                    {
                        string tVal = A[1];
                        tVal = tVal.Trim();
                        if (tVal.Equals("12") | tVal.Equals("11"))
                        {
                            return true;
                        }
                    }
                }
            }

            return false;
        }

        public bool isOffice2003Installed()
        {
            // Microsoft Office Professional Edition 2003 | 11 | 0 | 1
            // Microsoft Office Enterprise 2007 | 12 | 0 | 1
            // Microsoft Office Professional Edition 2003 | 11 | 0 | 1
            var LOS = new List<string>();
            LOS = getInstalledSoftware();
            foreach (string S in LOS)
            {
                if (Strings.InStr(S, "Microsoft Office", CompareMethod.Text) > 0)
                {
                    var A = S.Split('|');
                    if (A.Length > 1)
                    {
                        string tVal = A[1];
                        tVal = tVal.Trim();
                        if (tVal.Equals("11"))
                        {
                            return true;
                        }
                    }
                }
            }

            return false;
        }

        public bool isOffice2007Installed()
        {
            // Microsoft Office Enterprise 2007 | 12 | 0 | 1
            var LOS = new List<string>();
            LOS = getInstalledSoftware();
            foreach (string S in LOS)
            {
                if (Strings.InStr(S, "Microsoft Office", CompareMethod.Text) > 0)
                {
                    var A = S.Split('|');
                    if (A.Length > 1)
                    {
                        string tVal = A[1];
                        tVal = tVal.Trim();
                        if (tVal.Equals("12"))
                        {
                            return true;
                        }
                    }
                }
            }

            return false;
        }

        public bool isOutlookInstalled()
        {
            return default;
            // Update for Microsoft Office Outlook 2007 Help (KB963677)

        }

        public bool isOutlook2003Installed()
        {
            return default;
            // Update for Microsoft Office Outlook 2007 Help (KB963677)

        }

        public bool isOutlook2007Installed()
        {
            return default;
            // Update for Microsoft Office Outlook 2007 Help (KB963677)

        }

        public List<string> getInstalledSoftware()
        {
            if (modGlobals.gSoftware.Count > 0)
            {
                return modGlobals.gSoftware;
            }

            var strList = new List<string>();
            bool xdebug = false;
            string UninstallKey = "";
            UninstallKey = @"SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall";
            var RK = Registry.LocalMachine.OpenSubKey(UninstallKey);
            foreach (string skName in RK.GetSubKeyNames())
            {
                using (var sk = RK.OpenSubKey(skName))
                {
                    string PackageName = "";
                    try
                    {
                        PackageName = Conversions.ToString(sk.GetValue("DisplayName"));
                        if (xdebug.Equals(true))
                        {
                            Console.WriteLine(PackageName);
                        }

                        if (PackageName is null)
                        {
                            Console.WriteLine(PackageName);
                        }
                        else if (PackageName.Trim().Length > 0)
                        {
                            try
                            {
                                string VersionMajor = Conversions.ToString(sk.GetValue("VersionMajor"));
                                string VersionMinor = Conversions.ToString(sk.GetValue("VersionMinor"));
                                string WindowsInstaller = Conversions.ToString(sk.GetValue("WindowsInstaller"));
                                if (VersionMajor == null)
                                {
                                    if (xdebug.Equals(true))
                                    {
                                        Debug.Print("No VersionMajor");
                                    }
                                }
                                else if (VersionMajor.Trim().Length > 0)
                                {
                                    PackageName = PackageName + " | " + VersionMajor;
                                }

                                if (VersionMinor == null)
                                {
                                    if (xdebug.Equals(true))
                                    {
                                        Debug.Print("No VersionMinor");
                                    }
                                }
                                else if (VersionMinor.Trim().Length > 0)
                                {
                                    PackageName = PackageName + " | " + VersionMinor;
                                }

                                if (WindowsInstaller == null)
                                {
                                    if (xdebug.Equals(true))
                                    {
                                        Debug.Print("No WindowsInstaller");
                                    }
                                }
                                else if (WindowsInstaller.Trim().Length > 0)
                                {
                                    PackageName = PackageName + " | " + WindowsInstaller;
                                }
                            }
                            catch (Exception ex)
                            {
                                PackageName = PackageName + " | " + "NA";
                                if (xdebug.Equals(true))
                                {
                                    Debug.Print("NOTICE 01A: No entry found, skipping...");
                                }
                            }

                            strList.Add(PackageName);
                        }
                    }
                    catch (Exception ex)
                    {
                        if (xdebug.Equals(true))
                        {
                            Debug.Print("NOTICE 01b: No entry found, skipping...");
                        }
                    }
                }
            }

            strList.Sort();
            modGlobals.gSoftware = strList;
            return strList;
        }

        public string RemoveSingleQuotes(string tVal)
        {
            tVal = tVal.Replace("''", "'");
            tVal = tVal.Replace("'", "''");
            return tVal;
        }

        public string RemoveBadChars(string tVal)
        {
            try
            {
                int i = Strings.Len(tVal);
                string ch = "";
                string S = "0123456789 abcdefghijklmnopqrstuvwxyz.";
                var loopTo = Strings.Len(tVal);
                for (i = 1; i <= loopTo; i++)
                {
                    ch = Strings.Mid(tVal, i, 1);
                    if (Strings.InStr(S, ch, CompareMethod.Text) > 0)
                    {
                    }
                    else
                    {
                        StringType.MidStmtStr(ref tVal, i, 1, " ");
                    }
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: clsUtility:RemoveBadChars - " + ex.Message + Constants.vbCrLf + ex.StackTrace);
            }

            return tVal.Trim();
        }

        public string RemoveSingleQuotesV1(string tVal)
        {
            int I = 0;
            string CH = "";
            var loopTo = Strings.Len(tVal);
            for (I = 1; I <= loopTo; I++)
            {
                CH = Strings.Mid(tVal, I, 1);
                if (CH == "'")
                {
                    StringType.MidStmtStr(ref tVal, I, 1, "`");
                }
            }

            return tVal;
        }

        /// RemoveSingleQuotes - DO NOT SHOOT THE MESSENGER.
    /// This is a huge MS isssue. Reverse tick cannot be
    /// be processed in WEIGHTED searhes as it is in
    /// a non weighted search - pos THAT IT IS - it is what we have
    /// to deal with. So be it. Check out this code and love it!
    /// SHIT - am I good or what !!!
        public string RemoveSingleQuotes(string tVal, bool isWeightedSearch)
        {
            string[] A;
            string NewStr = "";
            if (isWeightedSearch == true)
            {
                if (Strings.InStr(1, tVal, "`") > 0)
                {
                    tVal = ReplaceSingleQuotes(tVal);
                }

                if (Strings.InStr(1, tVal, "''") > 0)
                {
                    NewStr = tVal;
                }
                else if (Strings.InStr(1, tVal, "'") > 0)
                {
                    A = tVal.Split('\'');
                    for (int i = 0, loopTo = Information.UBound(A); i <= loopTo; i++)
                        NewStr = NewStr + A[i].Trim() + "''";
                    NewStr = Strings.Mid(NewStr, 1, NewStr.Length - 2);
                }
                else if (Strings.InStr(1, tVal, "`") > 0)
                {
                    A = tVal.Split('`');
                    for (int i = 0, loopTo1 = Information.UBound(A); i <= loopTo1; i++)
                        NewStr = NewStr + A[i].Trim() + "''";
                    NewStr = Strings.Mid(NewStr, 1, NewStr.Length - 2);
                }
                else
                {
                    NewStr = tVal;
                }

                NewStr = NewStr.Trim();
            }
            else if (isWeightedSearch == true)
            {
                if (Strings.InStr(1, tVal, "`") > 0)
                {
                    A = tVal.Split('`');
                    for (int i = 0, loopTo2 = Information.UBound(A); i <= loopTo2; i++)
                        NewStr = NewStr + A[i].Trim() + "''";
                }
                else
                {
                    NewStr = tVal;
                }

                NewStr = NewStr.Trim();
            }
            else if (Strings.InStr(1, tVal, "''") > 0)
            {
                NewStr = tVal;
            }
            else
            {
                NewStr = RemoveSingleQuotes(tVal);
            }

            return NewStr;
        }

        public string RemoveUnwantedCharacters(string tVal)
        {
            tVal = tVal.Trim();
            string UCH = "()[]";
            string CH;
            for (int i = 1, loopTo = tVal.Length; i <= loopTo; i++)
            {
                CH = Strings.Mid(tVal, i, 1);
                if (Strings.InStr(UCH, CH) > 0)
                {
                    StringType.MidStmtStr(ref tVal, i, 1, " ");
                }
            }

            return tVal;
        }

        public string RemoveCrLF(string tVal)
        {
            tVal = tVal.Trim();
            string CH;
            for (int i = 1, loopTo = tVal.Length; i <= loopTo; i++)
            {
                CH = Strings.Mid(tVal, i, 1);
                if ((CH ?? "") == Constants.vbCr)
                {
                    StringType.MidStmtStr(ref tVal, i, 1, " ");
                }

                if ((CH ?? "") == Constants.vbLf)
                {
                    StringType.MidStmtStr(ref tVal, i, 1, " ");
                }
            }

            return tVal;
        }

        public string fixSingleQuotes(string tVal)
        {
            string tempStr = "";
            bool bLastCharIsQuote = false;
            tVal = tVal.Trim();
            if (tVal.Length == 0)
            {
                return tVal;
            }

            string CH = Strings.Mid(tVal, tVal.Length, 1);
            if (CH.Equals("'"))
            {
                bLastCharIsQuote = true;
            }

            var A = Strings.Split(tVal, "'");
            if (Strings.InStr(tVal, "'") > 0)
            {
                for (int i = 0, loopTo = Information.UBound(A); i <= loopTo; i++)
                    tempStr += A[i] + "''";
            }
            else
            {
                tempStr = tVal;
                return tempStr;
            }

            tempStr = Strings.Mid(tempStr, 1, tempStr.Length - 2);
            return tempStr;
        }

        public string setFilelenUnits(int file_Length)
        {
            decimal fl = Convert.ToDecimal(file_Length);
            string nbr = "";
            string units = "";
            int bytes = 0;
            decimal kb = 1000m;
            decimal mb = kb * 1000m;
            decimal gb = mb * 1000m;
            decimal tb = gb * 1000m;
            decimal pb = gb * 1000m;
            if (file_Length < kb)
            {
                units = " Bytes";
                nbr = file_Length.ToString() + units;
            }
            else if (file_Length >= kb & file_Length < mb)
            {
                fl = fl / kb;
                fl = Math.Round(fl, 2);
                units = "Kb";
                nbr = fl.ToString() + units;
            }
            else if (file_Length >= mb & file_Length < gb)
            {
                fl = fl / mb;
                fl = Math.Round(fl, 2);
                units = "Mb";
                nbr = fl.ToString() + units;
            }
            else if (file_Length >= gb & file_Length < tb)
            {
                fl = fl / gb;
                fl = Math.Round(fl, 2);
                units = "Gb";
                nbr = fl.ToString() + units;
            }
            else
            {
                units = "-HUGE";
                nbr = fl.ToString() + units;
            }

            return nbr;
        }

        public string ReplaceSingleQuotes(string tStr)
        {
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

        public string ReplaceSingleQuotesV1(string tVal)
        {
            int i = Strings.Len(tVal);
            string ch = "";
            var loopTo = Strings.Len(tVal);
            for (i = 1; i <= loopTo; i++)
            {
                ch = Strings.Mid(tVal, i, 1);
                if (ch == "`")
                {
                    StringType.MidStmtStr(ref tVal, i, 1, "'");
                }
            }

            return tVal;
        }

        public string RemoveCommas(string tVal)
        {
            int i = Strings.Len(tVal);
            string ch = "";
            var loopTo = Strings.Len(tVal);
            for (i = 1; i <= loopTo; i++)
            {
                ch = Strings.Mid(tVal, i, 1);
                if (ch == ",")
                {
                    StringType.MidStmtStr(ref tVal, i, 1, "^");
                }
            }

            return tVal;
        }

        public string RemoveOcrProblemChars(string tVal)
        {
            int i = Strings.Len(tVal);
            string ch = "";
            var loopTo = Strings.Len(tVal);
            for (i = 1; i <= loopTo; i++)
            {
                ch = Strings.Mid(tVal, i, 1);
                if (ch == ",")
                {
                    StringType.MidStmtStr(ref tVal, i, 1, "z");
                }
                else if (ch == " ")
                {
                    StringType.MidStmtStr(ref tVal, i, 1, "z");
                }
                else if (ch == "#")
                {
                    StringType.MidStmtStr(ref tVal, i, 1, "z");
                }
                else if (ch == "@")
                {
                    StringType.MidStmtStr(ref tVal, i, 1, "z");
                }
            }

            return tVal;
        }

        public void RemoveDoubleSlashes(ref string FQN)
        {
            int i = 0;
            string s1 = "";
            string S2 = "";
            string s = FQN;
            while (Strings.InStr(1, s, "//") > 0)
            {
                i = Strings.InStr(1, s, "//");
                s1 = Strings.Mid(s, 1, i + 1);
                S2 = Strings.Mid(s, 1, i + 2);
                s = s1 + S2;
            }

            FQN = s;
        }

        public void setConnectionStringTimeout(ref string ConnStr)
        {
            int I = 0;
            string S = "";
            string NewConnStr = "";
            S = ConnStr;
            I = Strings.InStr(1, S, "Connect Timeout =", CompareMethod.Text);
            if (I > 0)
            {
                string SqlTimeout = modGlobals.SystemSqlTimeout;
                if (SqlTimeout.Trim().Length == 0)
                {
                    return;
                }
                else
                {
                    I = I + "Connect Timeout =".Length;
                    NewConnStr = setNewTimeout(ConnStr, I);
                }
            }
            else
            {
                NewConnStr = S;
                NewConnStr += "; Connect Timeout = 600;";
            }

            GC.Collect();
            GC.WaitForFullGCApproach();
            ConnStr = NewConnStr;
        }

        public void setConnectionStringTimeout(ref string ConnStr, string TimeOutSecs)
        {
            int I = 0;
            string S = "";
            string NewConnStr = "";
            S = ConnStr;
            I = Strings.InStr(1, S, "Connect Timeout =", CompareMethod.Text);
            if (I > 0)
            {
                string SqlTimeout = modGlobals.SystemSqlTimeout;
                if (SqlTimeout.Trim().Length == 0)
                {
                    return;
                }
                else
                {
                    I = I + "Connect Timeout =".Length;
                    NewConnStr = setNewTimeout(ConnStr, I, TimeOutSecs);
                }
            }
            else
            {
                NewConnStr = S;
                NewConnStr += "; Connect Timeout = " + TimeOutSecs + ";";
            }

            GC.Collect();
            GC.WaitForFullGCApproach();
            ConnStr = NewConnStr;
        }

        public string setNewTimeout(string tgtStr, int StartingPoint, string NewVal)
        {
            string NextNumber = "";
            int NumberStartPos = 0;
            int NumberEndPos = 0;
            string NewStr = "";
            string S1 = "";
            string S2 = "";
            try
            {
                int I = 0;
                string CH = Strings.Mid(tgtStr, StartingPoint, 1);
                bool bFound = false;
                while (!(Strings.InStr("0123456789", CH) > 0 | StartingPoint > tgtStr.Length))
                {
                    StartingPoint += 1;
                    CH = Strings.Mid(tgtStr, StartingPoint, 1);
                    bFound = true;
                }

                if (!bFound)
                {
                    return tgtStr;
                }
                else
                {
                    NumberStartPos = StartingPoint;
                    NumberEndPos = StartingPoint;
                    while (!(Strings.InStr("0123456789", CH) == 0 | NumberEndPos >= tgtStr.Length))
                    {
                        NumberEndPos += 1;
                        CH = Strings.Mid(tgtStr, NumberEndPos, 1);
                    }
                }

                string CurrVal = Strings.Mid(tgtStr, NumberStartPos, NumberEndPos - NumberStartPos + 1);
                S1 = Strings.Mid(tgtStr, 1, NumberStartPos - 1);
                S2 = Strings.Mid(tgtStr, NumberEndPos + 1);
                NewStr = S1 + " " + NewVal + " " + S2;
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("FindNextNumberInStr: " + ex.Message);
                NewStr = tgtStr;
            }

            return NewStr;
        }

        public string setNewTimeout(string tgtStr, int StartingPoint)
        {
            string NextNumber = "";
            int NumberStartPos = 0;
            int NumberEndPos = 0;
            string NewStr = "";
            string S1 = "";
            string S2 = "";
            try
            {
                int I = 0;
                string CH = Strings.Mid(tgtStr, StartingPoint, 1);
                bool bFound = false;
                while (!(Strings.InStr("0123456789", CH) > 0 | StartingPoint > tgtStr.Length))
                {
                    StartingPoint += 1;
                    CH = Strings.Mid(tgtStr, StartingPoint, 1);
                    bFound = true;
                }

                if (!bFound)
                {
                    return tgtStr;
                }
                else
                {
                    NumberStartPos = StartingPoint;
                    NumberEndPos = StartingPoint;
                    while (!(Strings.InStr("0123456789", CH) == 0 | NumberEndPos >= tgtStr.Length))
                    {
                        NumberEndPos += 1;
                        CH = Strings.Mid(tgtStr, NumberEndPos, 1);
                    }
                }

                string CurrVal = Strings.Mid(tgtStr, NumberStartPos, NumberEndPos - NumberStartPos + 1);
                S1 = Strings.Mid(tgtStr, 1, NumberStartPos - 1);
                S2 = Strings.Mid(tgtStr, NumberEndPos + 1);
                NewStr = S1 + " " + modGlobals.SystemSqlTimeout + " " + S2;
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("FindNextNumberInStr: " + ex.Message);
                NewStr = tgtStr;
            }

            return NewStr;
        }

        public string getFileSuffix(string FQN)
        {
            int i = 0;
            string ch = "";
            string suffix = "";
            for (i = FQN.Length; i >= 1; i -= 1)
            {
                ch = Strings.Mid(FQN, i, 1);
                if (ch == ".")
                {
                    suffix = Strings.Mid(FQN, i + 1);
                    break;
                }
            }

            return suffix;
        }

        public string substConnectionStringServer(string ConnStr, string Server)
        {
            // Data Source=XXX;Initial Catalog=ECM.Thesaurus;Integrated Security=True; Connect Timeout = 30

            int I = 0;
            string Str1 = "";
            string Str2 = "";
            string NewStr = "";
            try
            {
                I = Strings.InStr(ConnStr, "=");
                Str1 = Strings.Mid(ConnStr, 1, I);
                I = Strings.InStr(I + 1, ConnStr, ";");
                Str2 = Strings.Mid(ConnStr, I);
                NewStr = Str1 + Server + Str2;
            }
            catch (Exception ex)
            {
                return "";
            }

            return NewStr;
        }

        public string getLicenseFromFile(string CustomerID, string ServerName, string LicenseDirectory)
        {
            bool B = true;
            bool bApplied = false;
            if (CustomerID.Length == 0)
            {
                MessageBox.Show("Customer ID required: " + Constants.vbCrLf + "If you do not know your Customer ID, " + Constants.vbCrLf + "please contact ECM Support or your ECM administrator.");
                return "";
            }

            try
            {
                string SelectedServer = ServerName;
                if (SelectedServer.Length == 0)
                {
                    MessageBox.Show("Please select the Server to which this license applies." + Constants.vbCrLf + "The server name and must match that contained within the license.");
                    return Conversions.ToString(false);
                }

                string FQN = LicenseDirectory + @"\" + "EcmLicense." + ServerName + ".txt";
                string S = LoadLicenseFile(FQN);
                if (S.Length == 0)
                {
                    return "";
                }
                else
                {
                    // ** Put the license into the DBARCH
                    return S;
                }
            }
            catch (Exception ex)
            {
                return "";
            }
        }

        public string LoadLicenseFile(string FQN)
        {
            string strContents;
            StreamReader objReader;
            try
            {
                objReader = new StreamReader(FQN);
                strContents = objReader.ReadToEnd();
                objReader.Close();
            }
            // Return strContents
            catch (Exception Ex)
            {
                MessageBox.Show("Failed to load License file: " + Constants.vbCrLf + Ex.Message);
                // LogThis("clsDatabaseARCH : LoadLicenseFile : 5914 : " + Ex.Message)
                return "";
            }

            return strContents;
        }

        /// <summary>
    /// Sets the archive bit.
    /// </summary>
    /// <param name="filespec">The filespec.</param>
    /// <param name="Action">The action.</param>
        public void SetArchiveBit(string filespec, OnOff Action)
        {
            object fs, f;
            fs = Interaction.CreateObject("Scripting.FileSystemObject");
            f = fs.GetFile(fs.GetFileName(filespec));
            if (Conversions.ToBoolean(Operators.AndObject(f.attributes, 32)))
            {
                // r = Debug.Print "The Archive bit is set, do you want to clear it?", vbYesNo, "Set/Clear Archive Bit" 
                if (Action == OnOff.TurnOFF)
                {
                    f.attributes = Operators.SubtractObject(f.attributes, 32);
                    Console.WriteLine("Archive bit is cleared.");
                }
                else
                {
                    Console.WriteLine("Archive bit remains set.");
                }
            }
            // r = Console.WriteLine("The Archive bit is not set. Do you want to set it?", vbYesNo, "Set/Clear Archive Bit")
            else if (Action == OnOff.TurnON)
            {
                f.attributes = Operators.AddObject(f.attributes, 32);
                Console.WriteLine("Archive bit is set.");
            }
            else
            {
                Console.WriteLine("Archive bit remains clear.");
            }
        }

        public bool ckArchiveBit(string FQN)
        {
            object fs, f;
            fs = Interaction.CreateObject("Scripting.FileSystemObject");
            f = fs.GetFile(fs.GetFileName(FQN));
            if (Conversions.ToBoolean(Operators.AndObject(f.attributes, 32)))
            {
                return true;
            }
            else
            {
                return false;
            }

            // Dim FI As New FileInfo(FQN)
            // Dim fAttr As FileAttribute
            // fAttr = File.GetAttributes(FQN)

            // Dim isArchive As Boolean = ((File.GetAttributes(FQN) And FileAttribute.Archive) = FileAttribute.Archive)
            // Dim bArchive As Boolean = FileAttribute.Archive
            // Return isArchive

        }

        public void setArchiveBitToNoArchNeeded(string FQN)
        {
            var FI = new FileInfo(FQN);
            FileAttribute fAttr;
            fAttr = (FileAttribute)File.GetAttributes(FQN);
            bool isArchive = ((int)File.GetAttributes(FQN) & (int)FileAttribute.Archive) == (int)FileAttribute.Archive;
            bool bArchive = Conversions.ToBoolean(FileAttribute.Archive);
            if (isArchive == false)
            {
                File.SetAttributes(FQN, (FileAttributes)(-32));
            }


            // Try
            // Dim fso, f
            // fso = CreateObject("Scripting.FileSystemObject")
            // f = fso.GetFile(FQN)

            // If f.attributes And 32 Then
            // f.attributes = f.attributes - 32
            // 'ToggleArchiveBit = "Archive bit is cleared."
            // Else
            // f.attributes = f.attributes + 32
            // 'ToggleArchiveBit = "Archive bit is set."
            // End If
            // Catch ex As Exception
            // messagebox.show("clsDma : ToggleArchiveBit : 648 : " + ex.Message)
            // End Try

        }

        public void setArchiveBitFasle(string FQN)
        {
            var FI = new FileInfo(FQN);
            FileAttribute fAttr;
            FI.Attributes = FileAttributes.Archive;
            fAttr = (FileAttribute)File.GetAttributes(FQN);
            bool isArchive = Conversions.ToDouble(((int)File.GetAttributes(FQN)).ToString() + ((int)FileAttribute.Archive).ToString()) == (double)FileAttribute.Archive;
            if (isArchive == false)
            {
                FI.Attributes = (FileAttributes)((int)FI.Attributes - 32);
            }
        }

        public void ExtendTimeoutBySize(ref string ConnectionString, double currFileSize)
        {
            double NewTimeOut = 30d;
            if (currFileSize > 1000000d & currFileSize < 2000000d)
            {
                NewTimeOut = 90d;
            }
            else if (currFileSize >= 2000000d & currFileSize < 5000000d)
            {
                NewTimeOut = 180d;
            }
            else if (currFileSize >= 5000000d & currFileSize < 10000000d)
            {
                NewTimeOut = 360d;
            }
            else if (currFileSize >= 10000000d)
            {
                NewTimeOut = 600d;
            }
            else
            {
                return;
            }

            string InsertConnStr = ConnectionString;
            string S1 = "";
            int II = Strings.InStr(InsertConnStr, "Connect Timeout", CompareMethod.Text);
            if (II > 0)
            {
                II = Strings.InStr(II + 5, InsertConnStr, "=");
                if (II > 0)
                {
                    int K = Strings.InStr(II + 1, InsertConnStr, ";");
                    if (K > 0)
                    {
                        string S2 = "";
                        // ** The connect time is delimited with a semicolon
                        S1 = Strings.Mid(InsertConnStr, 1, II + 1);
                        S2 = Strings.Mid(InsertConnStr, K);
                        S1 = S1 + NewTimeOut.ToString() + S2;
                        InsertConnStr = S1;
                    }
                    else
                    {
                        // ** The connect time is NOT delimited with a semicolon
                        S1 = Strings.Mid(InsertConnStr, 1, II + 1);
                        S1 = S1 + NewTimeOut.ToString();
                        InsertConnStr = S1;
                    }
                }
            }
        }

        public void ExtendTimeoutByCount(ref string ConnectionString, double RecordCount)
        {
            double NewTimeOut = 30d;
            if (RecordCount > 1000d & RecordCount < 2000d)
            {
                NewTimeOut = 90d;
            }
            else if (RecordCount >= 2000d & RecordCount < 5000d)
            {
                NewTimeOut = 180d;
            }
            else if (RecordCount >= 5000d & RecordCount < 10000d)
            {
                NewTimeOut = 360d;
            }
            else if (RecordCount >= 10000d)
            {
                NewTimeOut = 600d;
            }
            else
            {
                return;
            }

            string InsertConnStr = ConnectionString;
            string S1 = "";
            int II = Strings.InStr(InsertConnStr, "Connect Timeout", CompareMethod.Text);
            if (II > 0)
            {
                II = Strings.InStr(II + 5, InsertConnStr, "=");
                if (II > 0)
                {
                    int K = Strings.InStr(II + 1, InsertConnStr, ";");
                    if (K > 0)
                    {
                        string S2 = "";
                        // ** The connect time is delimited with a semicolon
                        S1 = Strings.Mid(InsertConnStr, 1, II + 1);
                        S2 = Strings.Mid(InsertConnStr, K);
                        S1 = S1 + NewTimeOut.ToString() + S2;
                        InsertConnStr = S1;
                    }
                    else
                    {
                        // ** The connect time is NOT delimited with a semicolon
                        S1 = Strings.Mid(InsertConnStr, 1, II + 1);
                        S1 = S1 + NewTimeOut.ToString();
                        InsertConnStr = S1;
                    }
                }
            }
        }

        public double HashCalc(string S)
        {
            string[] AR;
            int I = 0;
            double a = 1d;
            var loopTo = Strings.Len(S);
            for (I = 1; I <= loopTo; I++)
            {
                a = Strings.Asc(Strings.Mid(S, I, 1)) * 1000 + Strings.Asc(Strings.Mid(S, I, 1)) + I;
                a = Math.Sqrt(a * I * Strings.Asc(Strings.Mid(S, I, 1))); // Numeric Hash
            }

            AR = S.Split('.');
            var loopTo1 = Information.UBound(AR);
            for (I = 0; I <= loopTo1; I++)
            {
                if (Information.IsNumeric(AR[I]))
                {
                    a = a + Conversion.Val(AR[I]);
                }
            }

            a = Math.Round(a, 4);
            return a;
        }

        public double HashName(string sName)
        {
            double dHash = 0d;
            dHash = HashCalc(sName);
            return dHash;
        }

        public string HashFqn(string FQN)
        {
            double dHash = 0d;
            dHash = HashCalc(FQN);
            int I = FQN.Length;
            string sHash = FQN.Length.ToString() + ":" + dHash.ToString();
            return sHash;
        }

        public string HashDirName(string DirName)
        {
            double dHash = 0d;
            dHash = HashCalc(DirName);
            int I = DirName.Length;
            string sHash = DirName.Length.ToString() + ":" + dHash.ToString();
            return sHash;
        }

        public string HashFileName(string FileName)
        {
            double dHash = 0d;
            dHash = HashCalc(FileName);
            int I = FileName.Length;
            string sHash = FileName.Length.ToString() + ":" + dHash.ToString();
            return sHash;
        }

        public string HashDirFileName(string DirName, string FileName)
        {
            string sHash = HashDirName(DirName) + ":" + HashFileName(FileName);
            return sHash;
        }

        public void SaveNewUserSettings()
        {
            LOG.WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 100");
            // Dim ECMDB  = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
            // log.WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 200 " + ECMDB )
            string ECMDB = Conversions.ToString(My.MySettingsProperty.Settings["UserDefaultConnString"]);
            // log.WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 300 " + ECMDB )

            My.MySettingsProperty.Settings["UpgradeSettings"] = false;
            My.MySettingsProperty.Settings["DB_EcmLibrary"] = My.MySettingsProperty.Settings["UserDefaultConnString"];
            My.MySettingsProperty.Settings["DB_Thesaurus"] = My.MySettingsProperty.Settings["UserThesaurusConnString"];
            My.MySettingsProperty.Settings.Save();
            LOG.WriteToInstallLog(Conversions.ToString(Operators.AddObject("NOTICE: clsUtility: SaveNewUserSettings - 400 ", My.MySettingsProperty.Settings["DB_EcmLibrary"])));
            LOG.WriteToInstallLog(Conversions.ToString(Operators.AddObject("NOTICE: clsUtility: SaveNewUserSettings - 500 ", My.MySettingsProperty.Settings["DB_Thesaurus"])));
            LOG.WriteToInstallLog(Conversions.ToString(Operators.AddObject("NOTICE: clsUtility: SaveNewUserSettings - 600 ", My.MySettingsProperty.Settings["UserDefaultConnString"])));
            LOG.WriteToInstallLog(Conversions.ToString(Operators.AddObject("NOTICE: clsUtility: SaveNewUserSettings - 700 ", My.MySettingsProperty.Settings["UserThesaurusConnString"])));
        }

        // Dim fso As New Scripting.FileSystemObject()
        public bool EnumerateDiskDrives(ref SortedList<string, string> Drives)
        {
            object objFSO;
            objFSO = Interaction.CreateObject("Scripting.FileSystemObject");
            var colDrives = objFSO.Drives;
            foreach (var objDrive in (IEnumerable)colDrives)
            {
                string DriveType = "";
                string DriveLetter = Conversions.ToString(objDrive.DriveLetter);
                int NumData = Conversions.ToInteger(objDrive.drivetype);
                switch (NumData)
                {
                    case 1:
                        {
                            DriveType = "Removable";
                            break;
                        }

                    case 2:
                        {
                            DriveType = "Fixed";
                            break;
                        }

                    case 3:
                        {
                            DriveType = "Network";
                            break;
                        }

                    case 4:
                        {
                            DriveType = "CD-ROM";
                            break;
                        }

                    case 5:
                        {
                            DriveType = "RAM Disk";
                            break;
                        }

                    default:
                        {
                            DriveType = "Unknown";
                            break;
                        }
                }

                if (Drives.IndexOfKey(DriveLetter) >= 0)
                {
                }
                else
                {
                    Drives.Add(DriveLetter, DriveType);
                }
            }

            return default;
        }

        public void xSaveCurrentConnectionInfo()
        {
            var ENC = new ECMEncrypt();
            string TempDir = Environment.GetEnvironmentVariable("temp");
            string EcmConStr = "ECM" + Conversions.ToString('þ');
            string ThesaurusStr = "THE" + Conversions.ToString('þ');
            string FileName = "EcmLoginInfo.DAT";
            string FQN = TempDir + @"\" + FileName;
            File oFile;
            StreamWriter oWrite;
            try
            {
                EcmConStr = Conversions.ToString(EcmConStr + My.MySettingsProperty.Settings["UserDefaultConnString"]);
                ThesaurusStr = Conversions.ToString(ThesaurusStr + My.MySettingsProperty.Settings["UserThesaurusConnString"]);
                oWrite = File.CreateText(FQN);
                EcmConStr = ENC.AES256EncryptString(EcmConStr);
                ThesaurusStr = ENC.AES256EncryptString(ThesaurusStr);
                oWrite.WriteLine(EcmConStr);
                oWrite.WriteLine(ThesaurusStr);
                oWrite.Close();
            }
            catch (Exception ex)
            {
                LOG.WriteToInstallLog("ERROR: 100.11 - SaveCurrentConnectionInfo : " + ex.Message);
                LOG.WriteToInstallLog("ERROR: 100.11 - SaveCurrentConnectionInfo : " + ex.StackTrace);
            }
            finally
            {
                oWrite = null;
                oFile = null;
            }
        }

        public void xgetCurrentConnectionInfo()
        {
            try
            {
                LOG.WriteToInstallLog("Track 1");
                var ENC = new ECMEncrypt();
                string TempDir = Environment.GetEnvironmentVariable("temp");
                string EcmConStr = "ECM" + Conversions.ToString('þ');
                string ThesaurusStr = "THE" + Conversions.ToString('þ');
                string FileName = "EcmLoginInfo.DAT";
                string FQN = TempDir + @"\" + FileName;
                string LineIn = "";
                File oFile;
                var oRead = default(StreamReader);
                LOG.WriteToInstallLog("Track 2");
                File F;
                if (!File.Exists(FQN))
                {
                    oRead.Close();
                    oRead = null;
                    oFile = null;
                    return;
                }

                LOG.WriteToInstallLog("Track 3");
                try
                {
                    oRead = File.OpenText(FQN);
                    bool NeedsSaving = false;
                    while (oRead.Peek() != -1)
                    {
                        LineIn = oRead.ReadLine();
                        LineIn = ENC.AES256DecryptString(LineIn);
                        var A = LineIn.Split('?');
                        string tCode = A[0];
                        string cs = A[1];
                        if (tCode.Equals("ECM"))
                        {
                            My.MySettingsProperty.Settings["DB_EcmLibrary"] = cs;
                            My.MySettingsProperty.Settings["UserDefaultConnString"] = cs;
                            NeedsSaving = true;
                        }

                        if (tCode.Equals("THE"))
                        {
                            My.MySettingsProperty.Settings["DB_Thesaurus"] = cs;
                            My.MySettingsProperty.Settings["UserThesaurusConnString"] = cs;
                            NeedsSaving = true;
                        }
                    }

                    if (NeedsSaving == true)
                    {
                        My.MySettingsProperty.Settings.Save();
                    }
                }
                catch (Exception ex)
                {
                    LOG.WriteToInstallLog("ERROR: 100.11 - getCurrentConnectionInfo : " + ex.Message);
                    LOG.WriteToInstallLog("ERROR: 100.11 - getCurrentConnectionInfo : " + ex.StackTrace);
                }
                finally
                {
                    oRead.Close();
                    oFile = null;
                    ENC = null;
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToInstallLog("ERROR: 300.11 - getCurrentConnectionInfo : " + ex.Message);
                LOG.WriteToInstallLog("ERROR: 300.11 - getCurrentConnectionInfo : " + ex.StackTrace);
            }
        }

        public void CleanText(ref string sText)
        {
            for (int i = 1, loopTo = sText.Length; i <= loopTo; i++)
            {
                string CH = Strings.Mid(sText, i, 1);
                if (Strings.InStr("abcdefghijklmnopqrstuvwxyz .,'`-+%@01233456789~|", CH, CompareMethod.Text) == 0)
                {
                    StringType.MidStmtStr(ref sText, i, 1, " ");
                }
            }
        }

        public string genEmailIdentifier(DateTime CreatedTime, string SenderEmailAddress, string Subject)
        {
            try
            {
                if (Subject.Length == 0)
                {
                    Subject = " ";
                }

                string HashKey = ENC.getSha1HashKey(Subject);
                string EmailIdentifier = SenderEmailAddress + "|" + CreatedTime.ToString() + "|" + HashKey;
                EmailIdentifier = RemoveSingleQuotes(EmailIdentifier);
                RemoveBlanks(ref EmailIdentifier);
                CleanText(ref EmailIdentifier);
                return EmailIdentifier;
            }
            catch (Exception ex)
            {
                LOG.WriteToInstallLog("ERROR: 400.22 - genEmailIdentifier : " + ex.Message);
                return "";
            }
        }

        public string genEmailIdentifierV2(string msgBody, int MessageSize, string CreatedTime, string SenderEmailAddress, string Subject, int NbrAttachments)
        {
            string HashKey = ENC.getSha1HashKey(msgBody);
            string EmailIdentifier = MessageSize.ToString() + "~" + CreatedTime + "~" + SenderEmailAddress + "~" + Strings.Mid(Subject, 1, 80) + "~" + NbrAttachments.ToString() + "~" + HashKey;
            EmailIdentifier = RemoveSingleQuotes(EmailIdentifier);
            RemoveBlanks(ref EmailIdentifier);
            CleanText(ref EmailIdentifier);
            return EmailIdentifier;
        }

        public void ckSqlQryForDoubleKeyWords(ref string MyQry)
        {
            for (int i = 1, loopTo = MyQry.Length; i <= loopTo; i++)
            {
                string CH = "";
                CH = Strings.Mid(MyQry, i, 1);
                if (CH.Equals(Constants.vbCrLf))
                {
                    StringType.MidStmtStr(ref MyQry, i, 1, " ");
                }
            }

            var A = Strings.Split(MyQry, " ");
            string Token = "";
            string PrevToken = "";
            for (int i = 0, loopTo1 = Information.UBound(A); i <= loopTo1; i++)
            {
                Token = A[i].Trim();
                if (Strings.InStr(Token, "SenderEmailAddress", CompareMethod.Text) > 0)
                {
                    Console.WriteLine("Here");
                }

                if (Token.Length > 0)
                {
                    if (Token.ToUpper().Equals("AND") & PrevToken.ToUpper().Equals("AND"))
                    {
                        A[i] = "";
                    }

                    if (Token.ToUpper().Equals("AND") & PrevToken.ToUpper().Equals("OR"))
                    {
                        A[i] = "";
                    }

                    if (Token.ToUpper().Equals("OR") & PrevToken.ToUpper().Equals("OR"))
                    {
                        A[i] = "";
                    }

                    PrevToken = Token;
                }
            }

            MyQry = "";
            for (int i = 0, loopTo2 = Information.UBound(A); i <= loopTo2; i++)
            {
                MyQry = MyQry + A[i] + " ";
                Token = A[i];
                if (Token.Length > 0)
                {
                    if (Token.ToUpper().Equals("FROM"))
                    {
                        MyQry = Constants.vbCrLf + Constants.vbTab + MyQry;
                    }

                    if (Token.ToUpper().Equals("WHERE"))
                    {
                        MyQry = Constants.vbCrLf + Constants.vbTab + MyQry;
                    }

                    if (Token.ToUpper().Equals("AND"))
                    {
                        MyQry = Constants.vbCrLf + Constants.vbTab + MyQry;
                    }

                    if (Token.ToUpper().Equals("OR"))
                    {
                        MyQry = Constants.vbCrLf + Constants.vbTab + MyQry;
                    }

                    PrevToken = Token;
                }
            }
            // Clipboard.Clear()
            // Clipboard.SetText(MyQry)
        }

        public void AddHiveSearch(ref string tSql, List<string> HiveServers)
        {
            if (Strings.InStr(tSql, "HIVE_", CompareMethod.Text) > 0)
            {
                return;
            }

            var ModifiedList = new List<string>();
            var NewList = new List<string>();
            string tempSql = "";
            string tStr = "";
            string OrderByClause = "";
            var A = tSql.Split(Conversions.ToChar(Constants.vbCrLf));
            for (int I = 0, loopTo = Information.UBound(A) - 1; I <= loopTo; I++)
            {
                tStr = A[I].Trim();
                if (Strings.InStr(tStr, "order by", CompareMethod.Text) > 0)
                {
                    A[I] = "";
                    OrderByClause = tStr;
                }
                else if (tStr.Length == 0)
                {
                }
                else
                {
                    NewList.Add(tStr);
                }
            }

            ModifiedList.Clear();
            for (int I = 0, loopTo1 = NewList.Count - 1; I <= loopTo1; I++)
            {
                if (NewList[I].Trim().Length > 0)
                {
                    Console.WriteLine(NewList[I]);
                    ModifiedList.Add(NewList[I]);
                }
            }

            ModifiedList.Add("UNION ALL" + Constants.vbCrLf);
            for (int I = 0, loopTo2 = ModifiedList.Count - 1; I <= loopTo2; I++)
                Console.WriteLine(ModifiedList[I]);
            for (int I = 0, loopTo3 = HiveServers.Count - 1; I <= loopTo3; I++)
            {
                string SvrAlias = HiveServers[I];
                for (int J = 0, loopTo4 = NewList.Count - 1; J <= loopTo4; J++)
                {
                    tStr = NewList[J];
                    Console.WriteLine(tStr);
                    if (Strings.InStr(tStr, " FROM ", CompareMethod.Text) > 0)
                    {
                        int X = Strings.InStr(tStr, " FROM ", CompareMethod.Text);
                        Console.WriteLine(NewList[J]);
                        string S1 = Strings.Mid(tStr, 1, X - 1);
                        string S2 = Strings.Mid(tStr, X + " FROM ".Length);
                        tStr = S1 + " FROM " + SvrAlias + ".[ECM.Library].dbo." + S2;
                        Console.WriteLine(tStr);
                        Debug.Print(tStr);
                    }
                    else if (tStr.Length > 5)
                    {
                        if (Strings.Mid(tStr.ToUpper(), 1, 5).Equals("FROM "))
                        {
                            int X = Strings.InStr(tStr, " FROM ", CompareMethod.Text);
                            Console.WriteLine(NewList[J]);
                            string S1 = Strings.Mid(tStr, 1, 5);
                            string S2 = Strings.Mid(tStr, 6);
                            tStr = S1 + SvrAlias + ".[ECM.Library].dbo." + S2;
                            Console.WriteLine(tStr);
                            Debug.Print(tStr);
                        }
                    }

                    ModifiedList.Add(tStr);
                }

                if (I < HiveServers.Count - 1)
                {
                    ModifiedList.Add("UNION ALL");
                    ModifiedList.Add("/**************************/");
                }
            }

            ModifiedList.Add(OrderByClause + Constants.vbCrLf);
            tempSql = "";
            for (int I = 0, loopTo5 = ModifiedList.Count - 1; I <= loopTo5; I++)
            {
                tempSql += ModifiedList[I] + Constants.vbCrLf;
                Console.WriteLine(ModifiedList[I]);
            }

            Clipboard.Clear();
            Clipboard.SetText(tempSql);
            Console.WriteLine(tempSql);
            tSql = tempSql;
        }

        public void StripSingleQuotes(ref string S)
        {
            if (S is null)
            {
                S = " ";
                return;
            }

            try
            {
                if (S.Contains("'"))
                {
                    for (int i = 1, loopTo = S.Length; i <= loopTo; i++)
                    {
                        string CH = Strings.Mid(S, i, 1);
                        if (CH.Equals("'"))
                        {
                            StringType.MidStmtStr(ref S, i, 1, " ");
                        }
                    }
                }

                S = S.Trim();
            }
            catch (Exception ex)
            {
                Console.WriteLine("Notice: 199.1z2 - " + ex.Message);
            }
        }

        public void StripSemiColon(ref string S)
        {
            if (S is null)
            {
                S = " ";
                return;
            }

            try
            {
                if (S.Contains(";"))
                {
                    S.Replace(";", " , ");
                    S = S.Trim();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Notice: 199.1z - " + ex.Message);
            }
        }

        public bool FileOnLocalComputer(string MachineName, string FQN)
        {
            bool B = false;
            string CurrMachine = Environment.MachineName;
            MachineName = MachineName.ToUpper();
            CurrMachine = CurrMachine.ToUpper();
            if (CurrMachine.Equals(MachineName))
            {
                File F;
                if (File.Exists(FQN))
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

            return default;
        }

        public bool FileOnLocalComputer(string FQN)
        {
            bool B = false;
            File F;
            if (File.Exists(FQN))
            {
                B = true;
            }
            else
            {
                B = false;
            }

            return default;
        }

        public bool isOutLookRunning()
        {
            var procs = Process.GetProcessesByName("Outlook");
            if (procs.Count() > 0)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        public void KillOutlookRunning()
        {
            foreach (var RunningProcess in Process.GetProcessesByName("Outlook"))
                RunningProcess.Kill();
        }

        public string RemoveCommaNbr(string sNbr)
        {
            if (Strings.InStr(sNbr, " ") == 0 & Strings.InStr(sNbr, ",") == 0)
            {
                return sNbr;
            }

            string NewNbr = "";
            string CH = "";
            int I = 0;
            var loopTo = Strings.Len(sNbr);
            for (I = 1; I <= loopTo; I++)
            {
                CH = Strings.Mid(sNbr, I, 1);
                if (CH.Equals(" "))
                {
                }
                else if (CH.Equals(","))
                {
                }
                else
                {
                    NewNbr += CH;
                }
            }

            return NewNbr;
        }

        public string ConvertDate(DateTime tDate)
        {
            string sMonth = "";
            string sDay = "";
            string sYear = "";
            string sHour = "";
            string sMin = "";
            string sSecond = "";
            string sDayOfYear = "";
            string sTimeOfDay = "";
            string xDate = "";
            int LL = 0;
            try
            {
                sMonth = tDate.Month.ToString();
                LL = 1;
                sDay = tDate.Day.ToString();
                LL = 2;
                sYear = tDate.Year.ToString();
                LL = 3;
                sHour = tDate.Hour.ToString();
                LL = 4;
                sMin = tDate.Minute.ToString();
                LL = 5;
                sSecond = tDate.Second.ToString();
                LL = 6;
                sDayOfYear = tDate.DayOfYear.ToString();
                LL = 7;
                sTimeOfDay = tDate.TimeOfDay.ToString();
                LL = 8;
                if (Strings.InStr(sTimeOfDay, ".") > 0)
                {
                    LL = 9;
                    sTimeOfDay = Strings.Mid(sTimeOfDay, 1, Strings.InStr(sTimeOfDay, ".") - 1);
                    LL = 10;
                }

                LL = 11;
                xDate = sDay + "/" + sMonth + "/" + sYear + " " + sTimeOfDay;
                LL = 12;
            }
            catch (Exception ex)
            {
                xDate = "01/01/1800 01:01:01";
                LOG.WriteToArchiveLog("ERRROR date: ConvertDate 100: LL= " + LL.ToString() + ", error on converting date '" + tDate.ToString() + "'." + Constants.vbCrLf + ex.Message);
            }

            return xDate;
        }

        public string VerifyDate(string DTE)
        {
            DateTime tDate = default;
            try
            {
                tDate = Conversions.ToDate(DTE);
                for (int I = 1, loopTo = DTE.Length; I <= loopTo; I++)
                {
                    string CH = Strings.Mid(DTE, I, 1);
                    if (CH.Equals("/"))
                    {
                        StringType.MidStmtStr(ref DTE, I, 1, "-");
                    }
                }
            }
            catch (Exception ex)
            {
                string[] A = null;
                if (Strings.InStr(DTE, "-") > 0)
                {
                    A = DTE.Split('-');
                    DTE = A[1] + "-" + A[0] + "-" + A[2];
                }

                if (Strings.InStr(DTE, "/") > 0)
                {
                    A = DTE.Split('/');
                    DTE = A[1] + "-" + A[0] + "-" + A[2];
                }
            }

            return DTE;
        }

        public string getFileToArchive(string DirToInventory, List<string> FileExt, bool ckArchiveBit, bool InclSubDirs)
        {

            // dir *.txt *.xls *.docx /a:a /s /b
            string cPath = LOG.getTempEnvironDir();
            string TempFolder = LOG.getEnvVarSpecialFolderApplicationData();
            string tFQN = "";
            string Ext = "";
            string DirStmt = "";
            DirStmt = "DIR ";
            for (int I = 0, loopTo = FileExt.Count - 1; I <= loopTo; I++)
            {
                Ext = FileExt[I];
                if (Strings.InStr(Ext, ".") == 0)
                {
                    Ext = "." + Ext;
                }

                if (Strings.InStr(Ext, "*") == 0)
                {
                    Ext = "*" + Ext;
                }

                DirStmt += Ext + " ";
            }

            if (ckArchiveBit)
            {
                DirStmt += " /a:a ";
            }
            else
            {
                DirStmt += " ";
            }

            if (InclSubDirs == true)
            {
                DirStmt += " /s";
            }
            else
            {
                DirStmt += " ";
            }

            DirStmt += " /b ";
            string OutputFile = "";
            tFQN = TempFolder + @"\FilesToArchive.txt";
            DirStmt += " /a:a /s /b " + ">" + tFQN;
            string BatchFileName = TempFolder + @"\InventoryFiles.Bat";
            File F = null;
            if (File.Exists(BatchFileName))
            {
                File.Delete(BatchFileName);
            }

            F = null;
            using (var sw = new StreamWriter(BatchFileName, false))
            {
                sw.WriteLine("CD " + DirToInventory + Constants.vbCrLf);
                sw.WriteLine(DirStmt);
                sw.Close();
            }

            Process P;
            P = new Process();
            try
            {
                P.StartInfo.FileName = BatchFileName;
                P.StartInfo.WindowStyle = ProcessWindowStyle.Normal;
                P.Start();
                P.WaitForExit();
                P.Close();
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR: getFileToArchive 100 - " + ex.Message);
            }
            finally
            {
                if (P is object)
                {
                    P.Dispose();
                }
            }

            return tFQN;
        }

        public List<FileInfo> GetFiles(string Path, List<string> FilterList)
        {
            var d = new DirectoryInfo(Path);
            var files = new List<FileInfo>();
            foreach (string Filter in FilterList)
            {
                // the files are appended to the file array
                Application.DoEvents();
                files.AddRange(d.GetFiles(Filter));
            }

            return files;
        }

        public List<FileInfo> GetFilesRecursive(string initial, List<string> FilterList)
        {
            // This list stores the results.
            var result = new List<FileInfo>();

            // This stack stores the directories to process.
            var stack = new Stack<string>();

            // Add the initial directory
            stack.Push(initial);

            // Continue processing for each stacked directory
            while (stack.Count > 0)
            {
                // Get top directory string
                Application.DoEvents();
                string dir = stack.Pop();
                My.MyProject.Forms.frmNotify.Label1.Text = dir;
                My.MyProject.Forms.frmNotify.lblFileSpec.Text = "File Cnt: " + stack.Count.ToString();
                My.MyProject.Forms.frmNotify.Refresh();
                try
                {
                    // Add all immediate file paths

                    // Loop through all subdirectories and add them to the stack.
                    result.AddRange(GetFiles(dir, FilterList));
                    foreach (var directoryName in Directory.GetDirectories(dir))
                        stack.Push(directoryName);
                }
                catch (Exception ex)
                {
                }
            }

            // Return the list
            return result;
        }

        public void GetFilesToArchive(ref int iInventoryCnt, bool ckArchiveBit, bool IncludeSubDir, string DirToInventory, List<string> FilterList, ref List<string> FilesToArchive, ArrayList IncludedTypes, ArrayList ExcludedTypes)
        {
            if (modGlobals.gTraceFunctionCalls.Equals(1))
            {
                LOG.WriteToArchiveLog("--> CALL: " + System.Reflection.MethodBase.GetCurrentMethod().ToString());
            }

            FilesToArchive.Clear();
            int TotalFilesInDir = 0;
            string EXT = "";
            bool NeedsUpdate = false;
            var FINFO = new Dictionary<string, string>();
            string MSG = "";
            bool ArchiveAttr = false;
            FileInfo fi;
            int FileLength = 0;
            DateTime LastAccessDate = default;
            List<FileInfo> Files = null;
            string File_Name = "";
            string FQN = "";

            // Dim tempDebug As Boolean = False
            // If tempDebug.Equals(True) Then
            // IncludeSubDir = True
            // End If
            My.MyProject.Forms.frmNotify.Text = "CONTENT: Inventory";
            if (IncludeSubDir == true)
            {
                Files = GetFilesRecursive(DirToInventory, FilterList);
            }
            else
            {
                Files = GetFiles(DirToInventory, FilterList);
            }

            int GoodFileCNT = 0;
            string FOLDER_FQN = "";
            int iCnt = 0;
            modGlobals.MoreFileToProcess = 0;
            TotalFilesInDir = Files.Count;
            My.MyProject.Forms.frmNotify.Text = "CONTENT: Processing Files";
            foreach (var currentFi in Files)
            {
                fi = currentFi;
                try
                {
                    iCnt += 1;
                    FOLDER_FQN = fi.DirectoryName;
                    File_Name = fi.Name;
                    FQN = fi.FullName;
                    FileLength = (int)fi.Length;
                    if (FileLength >= modGlobals.MaxFileToLoadMB * 1000000)
                    {
                        LOG.WriteToArchiveLog("ERROR GetFileToArchive: file : " + FQN + " EXCEEDS MAXIMUM ALLOWED FILE SIZE, SKIPPING.");
                        goto SkipIT;
                    }

                    if (FOLDER_FQN.Trim().Length > 248)
                    {
                        LOG.WriteToArchiveLog("ERROR GetFileToArchive: folder name too long: " + FOLDER_FQN);
                        FOLDER_FQN = modGlobals.getShortDirName(FOLDER_FQN);
                        LOG.WriteToArchiveLog("NOTICE GetFileToArchive: Shortened name: " + FOLDER_FQN);
                        if (FOLDER_FQN.Trim().Length > 248)
                        {
                            LOG.WriteToArchiveLog("ERROR GetFileToArchive: SHORTENED folder name too long, skipping ENTIRE DIRECTORY");
                            return;
                        }
                    }

                    if (File_Name.Trim().Length > 260)
                    {
                        LOG.WriteToArchiveLog("ERROR GetFileToArchive: file name too long: " + File_Name + " - SKIPPING FILE.");
                        goto SkipIT;
                    }

                    FQN = FOLDER_FQN + @"\" + File_Name;
                    try
                    {
                        if (File.Exists(FQN))
                        {
                            GoodFileCNT += 1;
                        }
                    }
                    catch (Exception ex)
                    {
                        LOG.WriteToArchiveLog("ERROR GetFileToArchive: could not verify FQN : " + FQN + " - SKIPPING FILE.");
                        LOG.WriteToArchiveLog(ex.Message);
                        goto SkipIT;
                    }

                    if (iInventoryCnt % 2 == 0)
                    {
                        My.MyProject.Forms.frmNotify.Label1.Text = Path.GetDirectoryName(FOLDER_FQN);
                        My.MyProject.Forms.frmNotify.lblFileSpec.Text = "#Files: " + iInventoryCnt.ToString() + " of " + Files.Count.ToString();
                        My.MyProject.Forms.frmNotify.Refresh();
                    }

                    EXT = fi.Extension.ToUpper();
                    EXT = EXT.Substring(1);
                    iInventoryCnt += 1;
                    Application.DoEvents();
                    NeedsUpdate = false;
                    FINFO = dblocal.getFileArchiveInfo(FQN);
                    if (FINFO.Count.Equals(0) | FINFO.Count.Equals(1))
                    {
                        NeedsUpdate = true;
                    }
                    else if (fi.LastWriteTime > Convert.ToDateTime(FINFO["LastArchiveDate"]))
                    {
                        NeedsUpdate = true;
                    }
                    else if (FileLength != Convert.ToInt64(FINFO["FileSize"]))
                    {
                        NeedsUpdate = true;
                    }

                    if (FINFO["AddNewRec"].Equals("Y"))
                    {
                        dblocal.AddFileArchiveInfo(FQN);
                    }

                    if (IncludedTypes.Count > 0)
                    {
                        if (!IncludedTypes.Contains(EXT))
                        {
                            NeedsUpdate = false;
                        }
                    }

                    if (ExcludedTypes.Count > 0)
                    {
                        if (ExcludedTypes.Contains(EXT))
                        {
                            NeedsUpdate = false;
                        }
                    }

                    if (NeedsUpdate)
                    {
                        modGlobals.FilesBackedUp += 1;
                        MSG = ArchiveAttr + "|" + File_Name + "|" + fi.Extension + "|" + FOLDER_FQN + "|" + fi.Length + "|" + fi.CreationTime + "|" + fi.LastWriteTime + "|" + fi.LastAccessTime;
                        FilesToArchive.Add(MSG);
                    }
                    else
                    {
                        modGlobals.FilesSkipped += 1;
                    }

                    if (modGlobals.ContentBatchSize > 0)
                    {
                        if (iCnt >= modGlobals.ContentBatchSize)
                        {
                            LOG.WriteToArchiveLog("NOTICE: Maximumn file limit reached for this directory: " + fi.DirectoryName + ", more to be processed next run.");
                            modGlobals.MoreFileToProcess = 1;
                            break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("ERROR: GetFilesToArchive: " + ex.Message + Constants.vbCrLf + "DIRECTORY:" + FOLDER_FQN + Constants.vbCrLf + "File: " + File_Name);
                }

                SkipIT:
                ;
            }

            LOG.WriteToArchiveLog("GetFilesToArchive: Total Files In Dir: " + FOLDER_FQN + " = " + TotalFilesInDir.ToString());
            LOG.WriteToArchiveLog("GetFilesToArchive: Good Files In Dir: " + FOLDER_FQN + " = " + GoodFileCNT.ToString());
            if (TotalFilesInDir - GoodFileCNT != 0)
            {
                LOG.WriteToArchiveLog("GetFilesToArchive: REJECTED Files In Dir: " + FOLDER_FQN + " = " + (TotalFilesInDir - GoodFileCNT).ToString());
            }

            fi = null;
            GC.Collect();
            GC.WaitForFullGCApproach();
        }

        public bool ckPdfSearchable(string FQN)
        {
            string EntireFile;
            File oFile;
            StreamReader oRead;
            FQN = ReplaceSingleQuotes(FQN);
            oRead = File.OpenText(FQN);
            EntireFile = oRead.ReadToEnd();
            bool B = false;
            if (EntireFile.Contains("FontName"))
            {
                B = true;
            }

            EntireFile = "";
            oRead.Close();
            oRead.Dispose();
            oFile = null;
            GC.Collect();
            GC.WaitForPendingFinalizers();
            return B;
        }

        public bool isArchiveBitOn(string filespec)
        {
            bool B = false;
            object fso, f;
            fso = Interaction.CreateObject("Scripting.FileSystemObject");
            f = fso.GetFile(filespec);
            if (Conversions.ToBoolean(Operators.AndObject(f.attributes, 32)))
            {
                // f.attributes = f.attributes - 32
                // TurnOffArchiveBit = "Archive bit is cleared."
                B = true;
            }
            else
            {
                // f.attributes = f.attributes + 32
                // TurnOffArchiveBit = "Archive bit is set."
                B = false;
            }

            return B;
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

        public void deleteDirectoryFile(string DirFQN)
        {
            try
            {
                foreach (var FileName in Directory.GetFiles(DirFQN))
                {
                    try
                    {
                        File.Delete(FileName);
                    }
                    catch (Exception ex)
                    {
                        LOG.WriteToArchiveLog("ERROR 100 clsEmailFunctions:deleteDirectoryFile - failed to delete file '" + FileName + "'.");
                    }
                }
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("ERROR 200 :deleteDirectoryFile - failed to delete from Dir '" + DirFQN + "'.");
            }
        }

        public bool isFileArchiveAttributeSet(string FQN)
        {
            var fileDetail = My.MyProject.Computer.FileSystem.GetFileInfo(FQN);
            // Console.WriteLine(fileDetail.IsReadOnly)
            int A = (int)FileAttributes.Archive;
            int R = (int)FileAttributes.ReadOnly;
            int H = (int)FileAttributes.Hidden;
            int C = (int)FileAttributes.Compressed;
            int D = (int)FileAttributes.Directory;
            int E = (int)FileAttributes.Encrypted;
            int N = (int)FileAttributes.Normal;
            int NCI = (int)FileAttributes.NotContentIndexed;
            int OL = (int)FileAttributes.Offline;
            int S = (int)FileAttributes.System;
            int T = (int)FileAttributes.Temporary;

            // Console.WriteLine(CBool(fileDetail.Attributes And IO.FileAttributes.Hidden))

            if ((fileDetail.Attributes & FileAttributes.Archive) == FileAttributes.Archive)
            {
                // 'MessageBox.Show(fileDetail.Name & " is Archived")
                return false;
            }
            else
            {
                // 'MessageBox.Show(fileDetail.Name & " is NOT Archived")
                return true;
            }
        }

        public bool TurnOffArchiveBit(string filespec)
        {
            bool B = false;
            filespec = ReplaceSingleQuotes(filespec);
            try
            {
                var f = new FileInfo(filespec);
                f.Attributes = f.Attributes & ~FileAttributes.Archive;
                f = null;
            }
            catch (Exception ex)
            {
                LOG.WriteToArchiveLog("Warning: TurnOffArchiveBit 100 - " + ex.Message);
                B = false;
            }

            return B;
        }

        public long getUsedMemory()
        {
            return (long)ramCounter.NextValue();
        }

        public bool getImpersonateFileName(ref string FQN)
        {
            bool B = true;
            string tPath = LOG.getTempEnvironDir();
            if (Strings.Mid(tPath, tPath.Length, 1).Equals(@"\"))
            {
            }
            else
            {
                tPath = tPath + @"\";
            }

            tPath = tPath + "EcmDefaultLogin";
            // Dim D As Directory = Nothing
            if (!Directory.Exists(tPath))
            {
                try
                {
                    Directory.CreateDirectory(tPath);
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Fatal ERROR: Failed to create the required directory, please ensure you have the required authority." + Constants.vbCrLf + ex.Message);
                    return Conversions.ToBoolean("Fatal ERROR: Failed to create the required directory, please ensure you have the required authority." + Constants.vbCrLf + ex.Message);
                    B = false;
                }
            }

            if (B)
            {
                FQN = tPath + @"\DefaultLogin.dat";
            }
            else
            {
                FQN = "";
            }

            return B;
        }

        public bool isImpersonationSet(ref string Login)
        {
            Login = "";
            bool ImpersonationSet = false;
            string FQN = "";
            bool B = getImpersonateFileName(ref FQN);
            if (B)
            {
                if (File.Exists(FQN))
                {
                    string strContents;
                    StreamReader objReader;
                    try
                    {
                        objReader = new StreamReader(FQN);
                        strContents = objReader.ReadToEnd();
                        objReader.Close();
                        Login = strContents;
                        ImpersonationSet = true;
                    }
                    catch (Exception Ex)
                    {
                        ImpersonationSet = false;
                        Login = "";
                        MessageBox.Show("ERROR: Could not process Impersonation - 100x: " + Constants.vbCrLf + Ex.Message);
                    }
                }
                else
                {
                    ImpersonationSet = false;
                }
            }
            else
            {
                ImpersonationSet = false;
            }

            return ImpersonationSet;
        }

        public string GetFileContents(string FullPath, [Optional, DefaultParameterValue("")] ref string ErrInfo)
        {
            string strContents;
            StreamReader objReader;
            try
            {
                objReader = new StreamReader(FullPath);
                strContents = objReader.ReadToEnd();
                objReader.Close();
            }
            catch (Exception Ex)
            {
                strContents = "";
                ErrInfo = Ex.Message;
            }

            return strContents;
        }

        public int GetFileCountDir(string strPath)
        {
            try
            {
                return Directory.GetFiles(strPath).Length;
            }
            catch (Exception ex)
            {
                throw new Exception("Error From GetFileCountDir Function" + ex.Message, ex);
            }
        }

        public int GetFileCountSubdir(string strPath)
        {
            try
            {
                return Directory.GetFiles(strPath, "*.*", SearchOption.AllDirectories).Length;
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error From GetFileCountSubdir Function" + Constants.vbCrLf + ex.Message);
            }

            return default;
        }

        public void cleanTempWorkingDir()
        {
            string tPath = LOG.getTempEnvironDir();
            string TransferFileName = "*.NotReady";
            int I = 0;
            if (Directory.Exists(tPath))
            {
                foreach (string _file in Directory.GetFiles(tPath, "*.NotReady"))
                {
                    try
                    {
                        File.Delete(_file);
                        I += 1;
                    }
                    catch (Exception ex)
                    {
                        LOG.WriteToErrorLog("NOTICE: failed to remove " + _file + " from temp storage.");
                    }
                }
            }

            LOG.WriteToErrorLog("NOTICE 02: frmReconMain_FormClosing: removed " + I.ToString() + " temporary files.");
            var FilterList = new List<string>();
            string ZipProcessingDir = getTempProcessingDir();
            List<FileInfo> Files = null;
            bool IncludeSubDir = false;
            FileInfo FI;
            DateTime StartTime;
            TimeSpan ElapsedTime;
            int NbrOdDaysToKeep = 3;
            FilterList.Add("*.*");
            Files = GetFilesRecursive(ZipProcessingDir, FilterList);
            foreach (var currentFI in Files)
            {
                FI = currentFI;
                try
                {
                    string fqn = FI.FullName;
                    var CreateDate = FI.CreationTime;
                    StartTime = DateAndTime.Now;
                    ElapsedTime = DateAndTime.Now.Subtract(CreateDate);
                    int iDays = (int)ElapsedTime.TotalDays;
                    if (iDays > NbrOdDaysToKeep)
                    {
                        if (File.Exists(fqn))
                        {
                            File.Delete(fqn);
                        }
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Failed to delete AF1:" + FI.Name + ex.Message);
                    LOG.WriteToArchiveLog("ERROR Failed to DELETE: " + FI.Name, ex);
                }
            }

            FI = null;
            string S = ISO.readIsoFile(" FilesToDelete.dat");
            var sFilesToDelete = S.Split('|');
            foreach (var currentS in sFilesToDelete)
            {
                S = currentS;
                try
                {
                    S = S.Trim();
                    if (S.Trim().Length > 0)
                    {
                        if (File.Exists(S))
                        {
                            File.Delete(S);
                        }
                    }
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("NOTICE: Failed to delete temp file '" + S + "'.");
                }
            }

            RemoveEmptyDirectories(ZipProcessingDir);
            ISO.saveIsoFileZeroize(" FilesToDelete.dat", " ");
            GC.Collect();
        }

        // ******************************************************************************
        // *Purpose   :                   Removes all empty subdirectories under a directory
        // *Inputs: strPath(string)   :   Path of the folder.
        // * W. Dale Miller
        // ******************************************************************************
        public void RemoveEmptyDirectories(string RootDir)
        {
            var Root = new DirectoryInfo(RootDir);
            var DirsToRemove = new List<string>();
            try
            {
                var Files = Root.GetFiles("*.*");
                var Dirs = Root.GetDirectories("*.*");
                try
                {
                    Console.WriteLine("Root Directories");
                    foreach (var DirectoryName in Dirs)
                    {
                        try
                        {
                            Console.Write(DirectoryName.FullName);
                            if (DirectoryName.GetFiles().Count() == 0)
                            {
                                DirsToRemove.Add(DirectoryName.FullName);
                            }
                        }
                        catch (Exception E)
                        {
                            LOG.WriteToArchiveLog("ERROR: RemoveEmptyDirectories 01 - Failed to SAVE temp directory: " + DirectoryName.FullName + " into delete file.");
                        }
                    }
                }
                catch (Exception ex)
                {
                    LOG.WriteToArchiveLog("ERROR: RemoveEmptyDirectories 02 - " + ex.Message);
                }
                finally
                {
                    foreach (string S in DirsToRemove)
                    {
                        try
                        {
                            Directory.Delete(S);
                        }
                        catch (Exception ex)
                        {
                            Console.WriteLine("ERROR: RemoveEmptyDirectories 01 - Failed to DELETE temp directory: " + S + ".");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("ERROR: RemoveEmptyDirectories 05 - Failed to DELETE temp directory: " + ex.Message + ".");
            }

            DirsToRemove = null;
            GC.Collect();
        }
        // ******************************************************************************
        // *Purpose   :                   Get File Count in a specified directory
        // *Inputs: strPath(string)   :   Path of the folder.
        // * W. Dale Miller
        // *Returns   :   File Count
        // ******************************************************************************
        public int GetFileCount(string strPath)
        {
            try
            {
                return Directory.GetFiles(strPath).Length;
            }
            catch (Exception ex)
            {
                throw new Exception("Error From GetFileCount Function" + ex.Message, ex);
            }
        }

        // ******************************************************************************
        // *Purpose   :   Convert a bitmap from color to black and white only
        // *Inputs    :   strPath(string)   :   Path of the folder.
        // *By        :   W. Dale Miller
        // *Copyright :   @DMA, Limited, June 2005, all rights reserved.
        // *Returns   :   Bitmap
        // ******************************************************************************
        public Bitmap ConvertGraphicToBlackWhite(Bitmap image, BWMode Mode = BWMode.By_Lightness, float tolerance = 0f)
        {
            int x;
            int y;
            if (tolerance > 1f | tolerance < -1)
            {
                throw new ArgumentOutOfRangeException();
                return default;
            }

            var loopTo = image.Width - 1;
            for (x = 0; x <= loopTo; x += 1)
            {
                var loopTo1 = image.Height - 1;
                for (y = 0; y <= loopTo1; y += 1)
                {
                    var clr = image.GetPixel(x, y);
                    if (Mode == BWMode.By_RGB_Value)
                    {
                        if (clr.R + clr.G + clr.B > 383f - tolerance * 383f)
                        {
                            image.SetPixel(x, y, Color.White);
                        }
                        else
                        {
                            image.SetPixel(x, y, Color.Black);
                        }
                    }
                    else if (clr.GetBrightness() > 0.5d - tolerance / 2f)
                    {
                        image.SetPixel(x, y, Color.White);
                    }
                    else
                    {
                        image.SetPixel(x, y, Color.Black);
                    }
                }
            }

            return image;
        }

        public enum BWMode
        {
            By_Lightness,
            By_RGB_Value
        }
    }
}
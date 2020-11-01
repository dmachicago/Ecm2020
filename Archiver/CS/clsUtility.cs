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

using System.Threading;
using Microsoft.Win32;
using System.IO;
//using System.Diagnostics.PerformanceCounter;
using System.Runtime.InteropServices;
using Microsoft.VisualBasic.CompilerServices;


namespace EcmArchiveClcSetup
{
	public class clsUtility
	{
		
		clsLogging LOG = new clsLogging();
		clsIsolatedStorage ISO = new clsIsolatedStorage();
		clsEncrypt ENC = new clsEncrypt();
		
		static System.Diagnostics.PerformanceCounter ramCounter = new System.Diagnostics.PerformanceCounter("Memory", "Available MBytes");
		[DllImport("kernel32.dll", ExactSpelling=true, CharSet=CharSet.Ansi, SetLastError=true)]
		private static extern long GetTickCount();
		
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
			WebFQN = WebFQN.Replace("\\", "");
			WebFQN = WebFQN.Replace("*", "");
			WebFQN = WebFQN.Replace("<", "");
			WebFQN = WebFQN.Replace(">", "");
			WebFQN = WebFQN.Replace("|", "");
			WebFQN = WebFQN.Replace("-", " ");
			WebFQN = WebFQN.Replace(",", " ");
			WebFQN = WebFQN.Replace("#", " ");
			
			string sToken = "";
			S = WebFQN.Split(" ".ToCharArray());
			if (S.Count > 0)
			{
				WebFQN = "";
				foreach (string stemp in S)
				{
					stemp = stemp.ToLower();
					if (stemp.Length > 0)
					{
						StringType.MidStmtStr(ref stemp, 1, 1, stemp.Substring(0, 1).ToUpper());
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
					AppCnt++;
				}
			}
			return AppCnt;
		}
		
		public bool isImage(string FQN)
		{
			
			string fExt = "";
			FileInfo MyFile = new FileInfo(FQN);
			if (MyFile.Exists)
			{
				try
				{
					fExt = MyFile.Extension;
					fExt = getFileSuffix(FQN);
					if (fExt.IndexOf(".") + 1 == 0)
					{
						fExt = (string) ("." + fExt);
					}
				}
				catch (Exception ex)
				{
					Debug.Print(ex.Message);
					LOG.WriteToArchiveLog((string) ("clsModi : isImageFile : 10 : " + ex.Message));
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
			for (int i = 1; i <= S.Length; i++)
			{
				CH = S.Substring(i - 1, 1);
				if (CH.Equals(" "))
				{
					BlankCnt++;
				}
				else if (CH.Equals('\t'))
				{
					BlankCnt++;
				}
				else if (CH.Equals('\u0022'))
				{
					BlankCnt++;
				}
				else if (CH.Equals("\r\n"))
				{
					BlankCnt++;
				}
				else if (CH.Equals(Constants.vbCr))
				{
					BlankCnt++;
				}
				else if (CH.Equals(Constants.vbLf))
				{
					BlankCnt++;
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
			for (I = 1; I <= FQN.Length; I++)
			{
				string CH = FQN.Substring(I - 1, 1);
				if (CH.Equals(" "))
				{
					iCnt++;
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
					LOG.WriteToArchiveLog("ERROR: getTempProcessingDir (config.app) CANNOT HAVE SPACES IN THE NAME, defauling to C:\\TempUploads\\");
					S = "C:\\TempUploads\\";
					if (! Directory.Exists(S))
					{
						Directory.CreateDirectory(S);
					}
				}
			}
			catch (Exception)
			{
				S = "C:\\TempUploads\\";
				if (! Directory.Exists(S))
				{
					Directory.CreateDirectory(S);
				}
			}
			
			if (! S.Substring(S.Length - 1, 1).Equals("\\"))
			{
				S = S + "\\";
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
					LOG.WriteToArchiveLog("ERROR: PdfProcessingDir (config.app) CANNOT HAVE SPACES IN THE NAME, defauling to C:\\TempUploads\\");
					S = "C:\\TempUploads\\";
					if (! Directory.Exists(S))
					{
						Directory.CreateDirectory(S);
					}
				}
			}
			catch (Exception)
			{
				S = "C:\\TempUploads\\";
				if (! Directory.Exists(S))
				{
					Directory.CreateDirectory(S);
				}
			}
			
			return S;
			
		}
		
		public string getTempPdfWorkingErrorDir()
		{
			string TempSysDir = (string) (GetParentImageProcessingFile() + "\\ErrorFiles\\");
			
			if (! Directory.Exists(TempSysDir))
			{
				Directory.CreateDirectory(TempSysDir);
			}
			return TempSysDir;
			
		}
		
		private void ZeroizePdaDir()
		{
			
			string TempSysDir = (string) (GetParentImageProcessingFile() + "ECM\\OCR\\Extract");
			if (! Directory.Exists(TempSysDir))
			{
				Directory.CreateDirectory(TempSysDir);
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
		
		public void StripUnwantedChars(ref string sText)
		{
			string NewText = "";
			for (int i = 1; i <= sText.Length; i++)
			{
				string CH = sText.Substring(i - 1, 1);
				if (CH.Equals("/"))
				{
					CH = ".";
				}
				else if (CH.Equals(" "))
				{
					CH = "_";
				}
				if ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_.@-01233456789".IndexOf(CH) + 1 > 0)
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
				double dTicks; //Store the number of days the systems has been running
				dTicks = System.Convert.ToDouble(GetTickCount() / 1000 / 60 / 60 / 24);
				TimeSpan T;
				dTicks = dTicks * -1;
				DateTime DateStartedRunning = DateTime.Now.AddDays(dTicks);
				T = DateTime.Now.Subtract(DateStartedRunning);
				TotalDaysRunning = (int) T.TotalDays;
			}
			catch (Exception)
			{
				TotalDaysRunning = 2;
			}
			return TotalDaysRunning;
		}
		
		//Here is a call that uses the function above to determine if Excel is installed:
		//MessageBox.Show("Is MS Excel installed? - " & IsApplicationInstalled("Excel.Application").ToString)
		//RESULT:  Is MS Excell Installed? â€“ True
		public bool IsApplicationInstalled(string pSubKey)
		{
			bool isInstalled = false;
			
			// Declare a variable of type RegistryKey named classesRootRegisteryKey.
			// Assign the Registry's ClassRoot key to the classesRootRegisteryKey
			// variable.
			RegistryKey classesRootRegistryKey = Registry.ClassesRoot;
			
			// Declare a variable of type RegistryKey named subKeyRegistryKey.
			// Call classesRootRegistryKey's OpenSubKey method passing in the
			// pSubKey parameter passed into this function.
			// Assign the result returned to suKeyRegistryKey.
			RegistryKey subKeyRegistryKey = classesRootRegistryKey.OpenSubKey(pSubKey);
			
			// If subKeyRegistryKey was assigned a value...
			if (subKeyRegistryKey != null)
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
			//Microsoft Office Enterprise 2007 | 12 | 0 | 1
			//Microsoft Office Professional Edition 2003 | 11 | 0 | 1
			List<string> LOS = new List<string>();
			LOS = getInstalledSoftware();
			foreach (string S in LOS)
			{
				if (S.IndexOf("Microsoft Office") + 1 > 0)
				{
					object[] A = S.Split("|".ToCharArray());
					if (A.Length > 1)
					{
						string tVal = A[1];
						tVal = tVal.Trim();
						if (tVal.Equals("12") || tVal.Equals("11"))
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
			//Microsoft Office Professional Edition 2003 | 11 | 0 | 1
			//Microsoft Office Enterprise 2007 | 12 | 0 | 1
			//Microsoft Office Professional Edition 2003 | 11 | 0 | 1
			List<string> LOS = new List<string>();
			LOS = getInstalledSoftware();
			foreach (string S in LOS)
			{
				if (S.IndexOf("Microsoft Office") + 1 > 0)
				{
					object[] A = S.Split("|".ToCharArray());
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
			//Microsoft Office Enterprise 2007 | 12 | 0 | 1
			List<string> LOS = new List<string>();
			LOS = getInstalledSoftware();
			foreach (string S in LOS)
			{
				if (S.IndexOf("Microsoft Office") + 1 > 0)
				{
					object[] A = S.Split("|".ToCharArray());
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
			//Update for Microsoft Office Outlook 2007 Help (KB963677)
			
		}
		public bool isOutlook2003Installed()
		{
			//Update for Microsoft Office Outlook 2007 Help (KB963677)
			
		}
		public bool isOutlook2007Installed()
		{
			//Update for Microsoft Office Outlook 2007 Help (KB963677)
			
		}
		public List<string> getInstalledSoftware()
		{
			List<string> strList = new List<string>();
			
			string UninstallKey = "";
			UninstallKey = "SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Uninstall";
			RegistryKey RK = Registry.LocalMachine.OpenSubKey(UninstallKey);
			foreach (string skName in RK.GetSubKeyNames())
			{
				using (RegistryKey sk = RK.OpenSubKey(skName))
				{
					//Console.WriteLine(sk.Name)
					//Console.WriteLine(sk.GetSubKeyNames)
					//Console.WriteLine(sk.GetSubKeyNames)
					string PackageName = "";
					try
					{
						PackageName = (string) (sk.GetValue("DisplayName"));
						if (PackageName.Trim.Length > 0)
						{
							try
							{
								string VersionMajor = (string) (sk.GetValue("VersionMajor"));
								string VersionMinor = (string) (sk.GetValue("VersionMinor"));
								string WindowsInstaller = (string) (sk.GetValue("WindowsInstaller"));
								if (VersionMajor.Trim.Length > 0)
								{
									PackageName = PackageName + " | " + VersionMajor;
								}
								if (VersionMinor.Trim.Length > 0)
								{
									PackageName = PackageName + " | " + VersionMinor;
								}
								if (WindowsInstaller.Trim.Length > 0)
								{
									PackageName = PackageName + " | " + WindowsInstaller;
								}
							}
							catch (Exception)
							{
								
							}
							strList.Add(PackageName);
						}
					}
					catch (Exception)
					{
						
					}
				}
				
			}
			strList.Sort();
			return strList;
		}
		
		public string RemoveSingleQuotes(string tVal)
		{
			
			if (tVal.IndexOf("\'\'") + 1 > 0)
			{
				return (tVal);
			}
			if (tVal.IndexOf("\'") + 1 == 0)
			{
				return (tVal);
			}
			
			string SS = tVal;
			tVal = SS.Replace("\'", "\'\'");
			
			return tVal;
		}
		public string RemoveBadChars(string tVal)
		{
			try
			{
				int i = tVal.Length;
				string ch = "";
				string S = "0123456789 abcdefghijklmnopqrstuvwxyz.";
				for (i = 1; i <= tVal.Length; i++)
				{
					ch = tVal.Substring(i - 1, 1);
					if (S.IndexOf(ch) + 1 > 0)
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
				LOG.WriteToArchiveLog((string) ("ERROR: clsUtility:RemoveBadChars - " + ex.Message + "\r\n" + ex.StackTrace));
			}
			
			return tVal.Trim();
		}
		public string RemoveSingleQuotesV1(string tVal)
		{
			int I = 0;
			string CH = "";
			for (I = 1; I <= tVal.Length; I++)
			{
				CH = tVal.Substring(I - 1, 1);
				if (CH == "\'")
				{
					StringType.MidStmtStr(ref tVal, I, 1, "`");
				}
			}
			return tVal;
		}
		
		///
		/// RemoveSingleQuotes - DO NOT SHOOT THE MESSENGER.
		/// This is a huge MS isssue. Reverse tick cannot be
		/// be processed in WEIGHTED searhes as it is in
		/// a non weighted search - pos THAT IT IS - it is what we have
		/// to deal with. So be it. Check out this code and love it!
		/// SHIT - am I good or what !!!
		///
		public string RemoveSingleQuotes(string tVal, bool isWeightedSearch)
		{
			string[] A;
			string NewStr = "";
			if (isWeightedSearch == true)
			{
				if (tVal.IndexOf("`") + 1 > 0)
				{
					tVal = this.ReplaceSingleQuotes(tVal);
				}
				if (tVal.IndexOf("\'\'") + 1 > 0)
				{
					NewStr = tVal;
				}
				else if (tVal.IndexOf("\'") + 1 > 0)
				{
					A = tVal.Split("\'".ToCharArray());
					for (int i = 0; i <= (A.Length - 1); i++)
					{
						NewStr = NewStr + A[i].Trim() + "\'\'";
					}
					NewStr = NewStr.Substring(0, NewStr.Length - 2);
				}
				else if (tVal.IndexOf("`") + 1 > 0)
				{
					A = tVal.Split("`".ToCharArray());
					for (int i = 0; i <= (A.Length - 1); i++)
					{
						NewStr = NewStr + A[i].Trim() + "\'\'";
					}
					NewStr = NewStr.Substring(0, NewStr.Length - 2);
				}
				else
				{
					NewStr = tVal;
				}
				NewStr = NewStr.Trim();
			}
			else if (isWeightedSearch == true)
			{
				if (tVal.IndexOf("`") + 1 > 0)
				{
					A = tVal.Split("`".ToCharArray());
					for (int i = 0; i <= (A.Length - 1); i++)
					{
						NewStr = NewStr + A[i].Trim() + "\'\'";
					}
				}
				else
				{
					NewStr = tVal;
				}
				NewStr = NewStr.Trim();
			}
			else
			{
				if (tVal.IndexOf("\'\'") + 1 > 0)
				{
					NewStr = tVal;
				}
				else
				{
					NewStr = RemoveSingleQuotes(tVal);
				}
			}
			return NewStr;
		}
		
		public string RemoveUnwantedCharacters(string tVal)
		{
			tVal = tVal.Trim();
			string UCH = "()[]";
			string CH;
			for (int i = 1; i <= tVal.Length; i++)
			{
				CH = tVal.Substring(i - 1, 1);
				if (UCH.IndexOf(CH) + 1 > 0)
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
			for (int i = 1; i <= tVal.Length; i++)
			{
				CH = tVal.Substring(i - 1, 1);
				if (CH == Constants.vbCr)
				{
					StringType.MidStmtStr(ref tVal, i, 1, " ");
				}
				if (CH == Constants.vbLf)
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
			string CH = tVal.Substring(tVal.Length - 1, 1);
			if (CH.Equals("\'"))
			{
				bLastCharIsQuote = true;
			}
			
			string[] A = tVal.Split('\'');
			if (tVal.IndexOf("\'") + 1 > 0)
			{
				for (int i = 0; i <= (A.Length - 1); i++)
				{
					tempStr += (string) (A[i] + "\'\'");
				}
			}
			else
			{
				tempStr = tVal;
				return tempStr;
			}
			
			tempStr = tempStr.Substring(0, tempStr.Length - 2);
			
			return tempStr;
		}
		
		public string ReplaceSingleQuotes(string tStr)
		{
			
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
		
		public string ReplaceSingleQuotesV1(string tVal)
		{
			int i = tVal.Length;
			string ch = "";
			for (i = 1; i <= tVal.Length; i++)
			{
				ch = tVal.Substring(i - 1, 1);
				if (ch == "`")
				{
					StringType.MidStmtStr(ref tVal, i, 1, "\'");
				}
			}
			return tVal;
		}
		
		
		public string RemoveCommas(string tVal)
		{
			int i = tVal.Length;
			string ch = "";
			for (i = 1; i <= tVal.Length; i++)
			{
				ch = tVal.Substring(i - 1, 1);
				if (ch == ",")
				{
					StringType.MidStmtStr(ref tVal, i, 1, "^");
				}
			}
			return tVal;
		}
		
		public string RemoveOcrProblemChars(string tVal)
		{
			int i = tVal.Length;
			string ch = "";
			for (i = 1; i <= tVal.Length; i++)
			{
				ch = tVal.Substring(i - 1, 1);
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
			while (s.IndexOf("//") + 1 > 0)
			{
				i = s.IndexOf("//") + 1;
				s1 = s.Substring(0, i + 1);
				S2 = s.Substring(0, i + 2);
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
			I = S.IndexOf("Connect Timeout =") + 1;
			if (I > 0)
			{
				string SqlTimeout = modGlobals.SystemSqlTimeout;
				if (SqlTimeout.Trim.Length == 0)
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
			I = S.IndexOf("Connect Timeout =") + 1;
			if (I > 0)
			{
				string SqlTimeout = modGlobals.SystemSqlTimeout;
				if (SqlTimeout.Trim.Length == 0)
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
				string CH = tgtStr.Substring(StartingPoint - 1, 1);
				bool bFound = false;
				while (!("0123456789".IndexOf(CH) + 1 > 0 || StartingPoint > tgtStr.Length))
				{
					StartingPoint++;
					CH = tgtStr.Substring(StartingPoint - 1, 1);
					bFound = true;
				}
				if (! bFound)
				{
					return tgtStr;
				}
				else
				{
					NumberStartPos = StartingPoint;
					NumberEndPos = StartingPoint;
					while (!("0123456789".IndexOf(CH) + 1 == 0 || NumberEndPos >= tgtStr.Length))
					{
						NumberEndPos++;
						CH = tgtStr.Substring(NumberEndPos - 1, 1);
					}
				}
				string CurrVal = tgtStr.Substring(NumberStartPos - 1, NumberEndPos - NumberStartPos + 1);
				S1 = tgtStr.Substring(0, NumberStartPos - 1);
				S2 = tgtStr.Substring(NumberEndPos + 1 - 1);
				NewStr = S1 + " " + NewVal + " " + S2;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("FindNextNumberInStr: " + ex.Message));
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
				string CH = tgtStr.Substring(StartingPoint - 1, 1);
				bool bFound = false;
				while (!("0123456789".IndexOf(CH) + 1 > 0 || StartingPoint > tgtStr.Length))
				{
					StartingPoint++;
					CH = tgtStr.Substring(StartingPoint - 1, 1);
					bFound = true;
				}
				if (! bFound)
				{
					return tgtStr;
				}
				else
				{
					NumberStartPos = StartingPoint;
					NumberEndPos = StartingPoint;
					while (!("0123456789".IndexOf(CH) + 1 == 0 || NumberEndPos >= tgtStr.Length))
					{
						NumberEndPos++;
						CH = tgtStr.Substring(NumberEndPos - 1, 1);
					}
				}
				string CurrVal = tgtStr.Substring(NumberStartPos - 1, NumberEndPos - NumberStartPos + 1);
				S1 = tgtStr.Substring(0, NumberStartPos - 1);
				S2 = tgtStr.Substring(NumberEndPos + 1 - 1);
				NewStr = S1 + " " + modGlobals.SystemSqlTimeout + " " + S2;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("FindNextNumberInStr: " + ex.Message));
				NewStr = tgtStr;
			}
			return NewStr;
		}
		
		public string getFileSuffix(string FQN)
		{
			int i = 0;
			string ch = "";
			string suffix = "";
			for (i = FQN.Length; i >= 1; i--)
			{
				ch = FQN.Substring(i - 1, 1);
				if (ch == ".")
				{
					suffix = FQN.Substring(i + 1 - 1);
					break;
				}
			}
			return suffix;
		}
		public string substConnectionStringServer(string ConnStr, string Server)
		{
			//Data Source=XXX;Initial Catalog=ECM.Thesaurus;Integrated Security=True; Connect Timeout = 30
			
			int I = 0;
			string Str1 = "";
			string Str2 = "";
			string NewStr = "";
			
			try
			{
				I = ConnStr.IndexOf("=") + 1;
				Str1 = ConnStr.Substring(0, I);
				I = ConnStr.IndexOf(";", I + 1 - 1) + 1;
				Str2 = ConnStr.Substring(I - 1);
				NewStr = Str1 + Server + Str2;
			}
			catch (Exception)
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
				MessageBox.Show("Customer ID required: " + "\r\n" + "If you do not know your Customer ID, " + "\r\n" + "please contact ECM Support or your ECM administrator.");
				return "";
			}
			
			try
			{
				string SelectedServer = ServerName;
				if (SelectedServer.Length == 0)
				{
					MessageBox.Show("Please select the Server to which this license applies." + "\r\n" + "The server name and must match that contained within the license.");
					return false;
				}
				string FQN = LicenseDirectory + "\\" + "EcmLicense." + ServerName + ".txt";
				string S = LoadLicenseFile(FQN);
				if (S.Length == 0)
				{
					return "";
				}
				else
				{
					//** Put the license into the DB
					return S;
				}
			}
			catch (Exception)
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
				//Return strContents
			}
			catch (Exception Ex)
			{
				MessageBox.Show((string) ("Failed to load License file: " + "\r\n" + Ex.Message));
				//LogThis("clsDatabase : LoadLicenseFile : 5914 : " + Ex.Message)
				return "";
			}
			return strContents;
		}
		public bool ArchiveBitSet(string FQN)
		{
			
			FileInfo FI = new FileInfo(FQN);
			FileAttribute fAttr;
			fAttr = File.GetAttributes(FQN);
			bool isArchive = System.Convert.ToBoolean((File.GetAttributes(FQN) && FileAttribute.Archive) == FileAttribute.Archive);
			bool bArchive = FileAttribute.Archive;
			return isArchive;
			
		}
		public void setArchiveBitToNoArchNeeded(string FQN)
		{
			
			FileInfo FI = new FileInfo(FQN);
			FileAttribute fAttr;
			fAttr = File.GetAttributes(FQN);
			bool isArchive = System.Convert.ToBoolean((File.GetAttributes(FQN) && FileAttribute.Archive) == FileAttribute.Archive);
			bool bArchive = FileAttribute.Archive;
			
			if (isArchive == false)
			{
				File.SetAttributes(FQN, -32);
			}
			
			
			//Try
			//    Dim fso, f
			//    fso = CreateObject("Scripting.FileSystemObject")
			//    f = fso.GetFile(FQN)
			
			//    If f.attributes And 32 Then
			//        f.attributes = f.attributes - 32
			//        'ToggleArchiveBit = "Archive bit is cleared."
			//    Else
			//        f.attributes = f.attributes + 32
			//        'ToggleArchiveBit = "Archive bit is set."
			//    End If
			//Catch ex As Exception
			//    messagebox.show("clsDma : ToggleArchiveBit : 648 : " + ex.Message)
			//End Try
			
		}
		public void setArchiveBitFasle(string FQN)
		{
			
			FileInfo FI = new FileInfo(FQN);
			FileAttribute fAttr;
			FI.Attributes = FileAttributes.Archive;
			fAttr = File.GetAttributes(FQN);
			bool isArchive = System.Convert.ToBoolean((File.GetAttributes(FQN) + FileAttribute.Archive) == FileAttribute.Archive);
			if (isArchive == false)
			{
				FI.Attributes = FI.Attributes - 32;
			}
			
		}
		
		public void ExtendTimeoutBySize(string ConnectionString, double currFileSize)
		{
			
			double NewTimeOut = 30;
			
			if (currFileSize > 1000000 && currFileSize < 2000000)
			{
				NewTimeOut = 90;
			}
			else if (currFileSize >= 2000000 && currFileSize < 5000000)
			{
				NewTimeOut = 180;
			}
			else if (currFileSize >= 5000000 && currFileSize < 10000000)
			{
				NewTimeOut = 360;
			}
			else if (currFileSize >= 10000000)
			{
				NewTimeOut = 600;
			}
			else
			{
				return;
			}
			
			
			string InsertConnStr = ConnectionString;
			string S1 = "";
			int II = InsertConnStr.IndexOf("Connect Timeout") + 1;
			if (II > 0)
			{
				II = InsertConnStr.IndexOf("=", II + 5 - 1) + 1;
				if (II > 0)
				{
					int K = InsertConnStr.IndexOf(";", II + 1 - 1) + 1;
					if (K > 0)
					{
						string S2 = "";
						//** The connect time is delimited with a semicolon
						S1 = InsertConnStr.Substring(0, II + 1);
						S2 = InsertConnStr.Substring(K - 1);
						S1 = S1 + NewTimeOut.ToString() + S2;
						InsertConnStr = S1;
					}
					else
					{
						//** The connect time is NOT delimited with a semicolon
						S1 = InsertConnStr.Substring(0, II + 1);
						S1 = S1 + NewTimeOut.ToString();
						InsertConnStr = S1;
					}
				}
			}
			
		}
		
		public void ExtendTimeoutByCount(string ConnectionString, double RecordCount)
		{
			
			double NewTimeOut = 30;
			
			if (RecordCount > 1000 && RecordCount < 2000)
			{
				NewTimeOut = 90;
			}
			else if (RecordCount >= 2000 && RecordCount < 5000)
			{
				NewTimeOut = 180;
			}
			else if (RecordCount >= 5000 && RecordCount < 10000)
			{
				NewTimeOut = 360;
			}
			else if (RecordCount >= 10000)
			{
				NewTimeOut = 600;
			}
			else
			{
				return;
			}
			
			
			string InsertConnStr = ConnectionString;
			string S1 = "";
			int II = InsertConnStr.IndexOf("Connect Timeout") + 1;
			if (II > 0)
			{
				II = InsertConnStr.IndexOf("=", II + 5 - 1) + 1;
				if (II > 0)
				{
					int K = InsertConnStr.IndexOf(";", II + 1 - 1) + 1;
					if (K > 0)
					{
						string S2 = "";
						//** The connect time is delimited with a semicolon
						S1 = InsertConnStr.Substring(0, II + 1);
						S2 = InsertConnStr.Substring(K - 1);
						S1 = S1 + NewTimeOut.ToString() + S2;
						InsertConnStr = S1;
					}
					else
					{
						//** The connect time is NOT delimited with a semicolon
						S1 = InsertConnStr.Substring(0, II + 1);
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
			double a = 1;
			for (I = 1; I <= S.Length; I++)
			{
				a = System.Convert.ToDouble(Strings.Asc(S.Substring(I - 1, 1)) * 1000 + Strings.Asc(S.Substring(I - 1, 1)) + I);
				a = System.Math.Sqrt(a * I * Strings.Asc(S.Substring(I - 1, 1))); //Numeric Hash
			}
			
			AR = S.Split(".".ToCharArray());
			for (I = 0; I <= (AR.Length - 1); I++)
			{
				if (Information.IsNumeric(AR[I]))
				{
					a = a + val[AR[I]];
				}
			}
			
			a = Math.Round(a, 4);
			return a;
			
		}
		
		public double HashName(string sName)
		{
			double dHash = 0;
			dHash = HashCalc(sName);
			return dHash;
		}
		
		public string HashFqn(string FQN)
		{
			
			double dHash = 0;
			dHash = HashCalc(FQN);
			
			int I = int.Parse(FQN.Length);
			string sHash = FQN.Length.ToString() + ":" + dHash.ToString();
			return sHash;
			
		}
		
		public string HashDirName(string DirName)
		{
			
			double dHash = 0;
			dHash = HashCalc(DirName);
			
			int I = DirName.Length;
			string sHash = DirName.Length.ToString() + ":" + dHash.ToString();
			return sHash;
			
		}
		
		public string HashFileName(string FileName)
		{
			
			double dHash = 0;
			dHash = HashCalc(FileName);
			
			int I = int.Parse(FileName.Length);
			string sHash = FileName.Length.ToString() + ":" + dHash.ToString();
			return sHash;
			
		}
		
		public string HashDirFileName(string DirName, string FileName)
		{
			
			string sHash = (string) (HashDirName(DirName) + ":" + HashFileName(FileName));
			return sHash;
			
		}
		
		
		public void SaveNewUserSettings()
		{
			LOG.WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 100");
			//Dim ECMDB  = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
			//log.WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 200 " + ECMDB )
			string ECMDB = My.Settings.Default["UserDefaultConnString"];
			//log.WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 300 " + ECMDB )
			
			My.Settings.Default["UpgradeSettings"] = false;
			My.Settings.Default["DB_EcmLibrary"] = My.Settings.Default["UserDefaultConnString"];
			My.Settings.Default["DB_Thesaurus"] = My.Settings.Default["UserThesaurusConnString"];
			//My.Settings("UserDefaultConnString") = System.Configuration.ConfigurationManager.AppSettings("ECMREPO")
			// My.Settings("UserThesaurusConnString") = System.Configuration.ConfigurationManager.AppSettings("ECM_ThesaurusConnectionString")
			My.Settings.Default.Save();
			
			LOG.WriteToInstallLog((string) ("NOTICE: clsUtility: SaveNewUserSettings - 400 " + My.Settings.Default["DB_EcmLibrary"]));
			LOG.WriteToInstallLog((string) ("NOTICE: clsUtility: SaveNewUserSettings - 500 " + My.Settings.Default["DB_Thesaurus"]));
			LOG.WriteToInstallLog((string) ("NOTICE: clsUtility: SaveNewUserSettings - 600 " + My.Settings.Default["UserDefaultConnString"]));
			LOG.WriteToInstallLog((string) ("NOTICE: clsUtility: SaveNewUserSettings - 700 " + My.Settings.Default["UserThesaurusConnString"]));
			
		}
		
		public bool EnumerateDiskDrives(SortedList<string, string> Drives)
		{
			
			// Dim fso As New Scripting.FileSystemObject()
			
			object objFSO;
			
			objFSO = Interaction.CreateObject("Scripting.FileSystemObject", "");
			var colDrives = objFSO.Drives;
			
			foreach (object objDrive in colDrives)
			{
				string DriveType = "";
				string DriveLetter = objDrive.DriveLetter;
				int NumData = int.Parse(objDrive.drivetype);
				switch (NumData)
				{
					case 1:
						DriveType = "Removable";
						break;
					case 2:
						DriveType = "Fixed";
						break;
					case 3:
						DriveType = "Network";
						break;
					case 4:
						DriveType = "CD-ROM";
						break;
					case 5:
						DriveType = "RAM Disk";
						break;
					default:
						DriveType = "Unknown";
						break;
				}
				if (Drives.IndexOfKey(DriveLetter) >= 0)
				{
				}
				else
				{
					Drives.Add(DriveLetter, DriveType);
				}
			}
			
		}
		
		public void xSaveCurrentConnectionInfo()
		{
			
			clsEncrypt ENC = new clsEncrypt();
			
			string TempDir = Environment.GetEnvironmentVariable("temp");
			string EcmConStr = (string) ("ECM" + Strings.Chr(254));
			string ThesaurusStr = (string) ("THE" + Strings.Chr(254));
			string FileName = "EcmLoginInfo.DAT";
			string FQN = TempDir + "\\" + FileName;
			
			
			System.IO.File oFile;
			System.IO.StreamWriter oWrite;
			
			try
			{
				EcmConStr += My.Settings.Default["UserDefaultConnString"];
				ThesaurusStr += My.Settings.Default["UserThesaurusConnString"];
				
				oWrite = oFile.CreateText(FQN);
				
				EcmConStr = ENC.AES256EncryptString(EcmConStr);
				ThesaurusStr = ENC.AES256EncryptString(ThesaurusStr);
				oWrite.WriteLine(EcmConStr);
				oWrite.WriteLine(ThesaurusStr);
			}
			catch (Exception ex)
			{
				LOG.WriteToInstallLog((string) ("ERROR: 100.11 - SaveCurrentConnectionInfo : " + ex.Message));
				LOG.WriteToInstallLog((string) ("ERROR: 100.11 - SaveCurrentConnectionInfo : " + ex.StackTrace));
			}
			finally
			{
				oWrite.Close();
				oWrite = null;
				oFile = null;
			}
			
		}
		public void xgetCurrentConnectionInfo()
		{
			
			try
			{
				LOG.WriteToInstallLog("Track 1");
				clsEncrypt ENC = new clsEncrypt();
				
				string TempDir = Environment.GetEnvironmentVariable("temp");
				string EcmConStr = (string) ("ECM" + Strings.Chr(254));
				string ThesaurusStr = (string) ("THE" + Strings.Chr(254));
				string FileName = "EcmLoginInfo.DAT";
				string FQN = TempDir + "\\" + FileName;
				string LineIn = "";
				System.IO.File oFile;
				System.IO.StreamReader oRead;
				LOG.WriteToInstallLog("Track 2");
				File F;
				if (! F.Exists(FQN))
				{
					oRead.Close();
					oRead = null;
					oFile = null;
					return;
				}
				LOG.WriteToInstallLog("Track 3");
				try
				{
					oRead = oFile.OpenText(FQN);
					bool NeedsSaving = false;
					while (oRead.Peek() != -1)
					{
						LineIn = oRead.ReadLine();
						LineIn = ENC.AES256DecryptString(LineIn);
						
						string[] A = LineIn.Split("?".ToCharArray());
						string tCode = A[0];
						string cs = A[1];
						
						if (tCode.Equals("ECM"))
						{
							My.Settings.Default["DB_EcmLibrary"] = cs;
							My.Settings.Default["UserDefaultConnString"] = cs;
							NeedsSaving = true;
						}
						if (tCode.Equals("THE"))
						{
							My.Settings.Default["DB_Thesaurus"] = cs;
							My.Settings.Default["UserThesaurusConnString"] = cs;
							NeedsSaving = true;
						}
						
					}
					if (NeedsSaving == true)
					{
						My.Settings.Default.Save();
					}
				}
				catch (Exception ex)
				{
					LOG.WriteToInstallLog((string) ("ERROR: 100.11 - getCurrentConnectionInfo : " + ex.Message));
					LOG.WriteToInstallLog((string) ("ERROR: 100.11 - getCurrentConnectionInfo : " + ex.StackTrace));
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
				LOG.WriteToInstallLog((string) ("ERROR: 300.11 - getCurrentConnectionInfo : " + ex.Message));
				LOG.WriteToInstallLog((string) ("ERROR: 300.11 - getCurrentConnectionInfo : " + ex.StackTrace));
			}
			
		}
		
		public void CleanText(ref string sText)
		{
			for (int i = 1; i <= sText.Length; i++)
			{
				string CH = sText.Substring(i - 1, 1);
				if ("abcdefghijklmnopqrstuvwxyz .,\'`-+%@01233456789~|".IndexOf(CH) + 1 == 0)
				{
					StringType.MidStmtStr(ref sText, i, 1, " ");
				}
			}
		}
		
		public string genEmailIdentifier(DateTime CreatedTime, string SenderEmailAddress, string Subject)
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
		
		public string genEmailIdentifierV2(string msgBody, int MessageSize, string CreatedTime, string SenderEmailAddress, string Subject, int NbrAttachments)
		{
			
			string HashKey = ENC.getSha1HashKey(msgBody);
			
			string EmailIdentifier = MessageSize.ToString() + "~" + CreatedTime + "~" + SenderEmailAddress + "~" + Subject.Substring(0, 80) + "~" + NbrAttachments.ToString() + "~" + HashKey;
			EmailIdentifier = RemoveSingleQuotes(EmailIdentifier);
			RemoveBlanks(ref EmailIdentifier);
			CleanText(ref EmailIdentifier);
			
			return EmailIdentifier;
			
		}
		
		public void ckSqlQryForDoubleKeyWords(ref string MyQry)
		{
			for (int i = 1; i <= MyQry.Length; i++)
			{
				string CH = "";
				CH = MyQry.Substring(i - 1, 1);
				if (CH.Equals("\r\n"))
				{
					StringType.MidStmtStr(ref MyQry, i, 1, " ");
				}
			}
			string[] A = MyQry.Split(' ');
			
			string Token = "";
			string PrevToken = "";
			
			for (int i = 0; i <= (A.Length - 1); i++)
			{
				Token = A[i].Trim();
				if (Token.IndexOf("SenderEmailAddress") + 1 > 0)
				{
					Console.WriteLine("Here");
				}
				if (Token.Length > 0)
				{
					if (Token.ToUpper().Equals("AND") && PrevToken.ToUpper().Equals("AND"))
					{
						A[i] = "";
					}
					if (Token.ToUpper().Equals("AND") && PrevToken.ToUpper().Equals("OR"))
					{
						A[i] = "";
					}
					if (Token.ToUpper().Equals("OR") && PrevToken.ToUpper().Equals("OR"))
					{
						A[i] = "";
					}
					PrevToken = Token;
				}
			}
			
			MyQry = "";
			for (int i = 0; i <= (A.Length - 1); i++)
			{
				MyQry = MyQry + A[i] + " ";
				Token = A[i];
				if (Token.Length > 0)
				{
					if (Token.ToUpper().Equals("FROM"))
					{
						MyQry = (string) ("\r\n" + "\t" + MyQry);
					}
					if (Token.ToUpper().Equals("WHERE"))
					{
						MyQry = (string) ("\r\n" + "\t" + MyQry);
					}
					if (Token.ToUpper().Equals("AND"))
					{
						MyQry = (string) ("\r\n" + "\t" + MyQry);
					}
					if (Token.ToUpper().Equals("OR"))
					{
						MyQry = (string) ("\r\n" + "\t" + MyQry);
					}
					PrevToken = Token;
				}
			}
			//Clipboard.Clear()
			//Clipboard.SetText(MyQry)
		}
		
		public void AddHiveSearch(ref string tSql, List<string> HiveServers)
		{
			
			if (tSql.IndexOf("HIVE_") + 1 > 0)
			{
				return;
			}
			
			List<string> ModifiedList = new List<string>();
			List<string> NewList = new List<string>();
			string tempSql = "";
			string tStr = "";
			string OrderByClause = "";
			string[] A = tSql.Split("\r\n".ToCharArray());
			for (int I = 0; I <= (A.Length - 1) - 1; I++)
			{
				tStr = A[I].Trim();
				if (tStr.IndexOf("order by") + 1 > 0)
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
			for (int I = 0; I <= NewList.Count - 1; I++)
			{
				if (NewList(I).Trim.Length > 0)
				{
					Console.WriteLine(NewList(I));
					ModifiedList.Add(NewList(I));
				}
			}
			
			ModifiedList.Add("UNION ALL" + "\r\n");
			
			for (int I = 0; I <= ModifiedList.Count - 1; I++)
			{
				Console.WriteLine(ModifiedList(I));
			}
			
			for (int I = 0; I <= HiveServers.Count - 1; I++)
			{
				string SvrAlias = HiveServers(I);
				for (int J = 0; J <= NewList.Count - 1; J++)
				{
					tStr = NewList(J);
					Console.WriteLine(tStr);
					if (tStr.IndexOf(" FROM ") + 1 > 0)
					{
						int X = tStr.IndexOf(" FROM ") + 1;
						Console.WriteLine(NewList(J));
						string S1 = tStr.Substring(0, X - 1);
						string S2 = tStr.Substring(X + " FROM ".Length - 1);
						tStr = S1 + " FROM " + SvrAlias + ".[ECM.Library].dbo." + S2;
						Console.WriteLine(tStr);
						Debug.Print(tStr);
					}
					else
					{
						if (tStr.Length > 5)
						{
							if (tStr.ToUpper().Substring(0, 5).Equals("FROM "))
							{
								int X = tStr.IndexOf(" FROM ") + 1;
								Console.WriteLine(NewList(J));
								string S1 = tStr.Substring(0, 5);
								string S2 = tStr.Substring(5);
								tStr = S1 + SvrAlias + ".[ECM.Library].dbo." + S2;
								Console.WriteLine(tStr);
								Debug.Print(tStr);
							}
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
			
			ModifiedList.Add(OrderByClause + "\r\n");
			
			tempSql = "";
			
			for (int I = 0; I <= ModifiedList.Count - 1; I++)
			{
				tempSql += (string) (ModifiedList(I) + "\r\n");
				Console.WriteLine(ModifiedList(I));
			}
			
			Clipboard.Clear();
			Clipboard.SetText(tempSql);
			
			Console.WriteLine(tempSql);
			
			tSql = tempSql;
			
		}
		
		public void StripSingleQuotes(ref string S)
		{
			
			if (S == null)
			{
				S = " ";
				return;
			}
			
			try
			{
				if (S.Contains("\'"))
				{
					for (int i = 1; i <= S.Length; i++)
					{
						string CH = S.Substring(i - 1, 1);
						if (CH.Equals("\'"))
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
			
			if (S == null)
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
			string CurrMachine = System.Environment.MachineName;
			MachineName = MachineName.ToUpper();
			CurrMachine = CurrMachine.ToUpper();
			
			if (CurrMachine.Equals(MachineName))
			{
				File F;
				if (F.Exists(FQN))
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
			
		}
		
		public bool FileOnLocalComputer(string FQN)
		{
			
			bool B = false;
			File F;
			if (F.Exists(FQN))
			{
				B = true;
			}
			else
			{
				B = false;
			}
			
		}
		
		public bool isOutLookRunning()
		{
			Process[] procs = Process.GetProcessesByName("Outlook");
			if (procs.Count > 0)
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
			{
				RunningProcess.Kill();
			}
			
		}
		
		public string RemoveCommaNbr(string sNbr)
		{
			if (sNbr.IndexOf(" ") + 1 == 0 && sNbr.IndexOf(",") + 1 == 0)
			{
				return sNbr;
			}
			string NewNbr = "";
			string CH = "";
			int I = 0;
			for (I = 1; I <= sNbr.Length; I++)
			{
				CH = sNbr.Substring(I - 1, 1);
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
				if (sTimeOfDay.IndexOf(".") + 1 > 0)
				{
					LL = 9;
					sTimeOfDay = sTimeOfDay.Substring(0, sTimeOfDay.IndexOf(".") + 0);
					LL = 10;
				}
				LL = 11;
				xDate = sDay + "/" + sMonth + "/" + sYear + " " + sTimeOfDay;
				LL = 12;
			}
			catch (Exception ex)
			{
				xDate = "01/01/1800 01:01:01";
				LOG.WriteToArchiveLog((string) ("ERRROR date: ConvertDate 100: LL= " + LL.ToString() + ", error on converting date \'" + tDate.ToString() + "\'." + "\r\n" + ex.Message));
			}
			
			return xDate;
			
		}
		
		
		
		public string VerifyDate(string DTE)
		{
			DateTime tDate = null;
			try
			{
				tDate = DateTime.Parse(DTE);
				for (int I = 1; I <= DTE.Length; I++)
				{
					string CH = DTE.Substring(I - 1, 1);
					if (CH.Equals("/"))
					{
						StringType.MidStmtStr(ref DTE, I, 1, "-");
					}
				}
			}
			catch (Exception)
			{
				string[] A = null;
				if (DTE.IndexOf("-") + 1 > 0)
				{
					A = DTE.Split("-".ToCharArray());
					DTE = (string) (A[1] + "-" + A[0] + "-" + A[2]);
				}
				if (DTE.IndexOf("/") + 1 > 0)
				{
					A = DTE.Split("/".ToCharArray());
					DTE = (string) (A[1] + "-" + A[0] + "-" + A[2]);
				}
			}
			return DTE;
			
		}
		
		public string getFileToArchive(string DirToInventory, List<string> FileExt, bool ckArchiveBit, bool InclSubDirs)
		{
			
			//dir *.txt *.xls *.docx /a:a /s /b
			string cPath = LOG.getTempEnvironDir();
			string TempFolder = LOG.getEnvVarSpecialFolderApplicationData();
			string tFQN = "";
			string Ext = "";
			string DirStmt = "";
			DirStmt = "DIR ";
			for (int I = 0; I <= FileExt.Count - 1; I++)
			{
				Ext = FileExt(I);
				if (Ext.IndexOf(".") + 1 == 0)
				{
					Ext = (string) ("." + Ext);
				}
				if (Ext.IndexOf("*") + 1 == 0)
				{
					Ext = (string) ("*" + Ext);
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
			tFQN = TempFolder + "\\FilesToArchive.txt";
			DirStmt += (string) (" /a:a /s /b " + ">" + tFQN);
			string BatchFileName = TempFolder + "\\InventoryFiles.Bat";
			File F = null;
			if (F.Exists(BatchFileName))
			{
				F.Delete(BatchFileName);
			}
			F = null;
			
			using (StreamWriter sw = new StreamWriter(BatchFileName, false))
			{
				sw.WriteLine("CD " + DirToInventory + "\r\n");
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
				LOG.WriteToArchiveLog((string) ("ERROR: getFileToArchive 100 - " + ex.Message));
			}
			finally
			{
				if (P != null)
				{
					P.Dispose();
				}
				
			}
			return tFQN;
		}
		
		public List<FileInfo> GetFiles(string Path, List<string> FilterList)
		{
			DirectoryInfo d = new DirectoryInfo(Path);
			List<FileInfo> files = new List<FileInfo>();
			//Iterate through the FilterList
			foreach (string Filter in FilterList)
			{
				//the files are appended to the file array
				Application.DoEvents();
				files.AddRange(d.GetFiles(Filter));
			}
			return (files);
		}
		public List<FileInfo> GetFilesRecursive(string initial, List<string> FilterList)
		{
			// This list stores the results.
			List<FileInfo> result = new List<FileInfo>();
			
			// This stack stores the directories to process.
			Stack<string> stack = new Stack<string>();
			
			// Add the initial directory
			stack.Push(initial);
			
			// Continue processing for each stacked directory
			while (stack.Count > 0)
			{
				frmNotify.Default.lblFileSpec.Text = (string) ("Dir Inventory Remaining: " + stack.Count.ToString());
				frmNotify.Default.Refresh();
				// Get top directory string
				Application.DoEvents();
				string dir = (string) (stack.Pop());
				try
				{
					// Add all immediate file paths
					result.AddRange(GetFiles(dir, FilterList));
					
					// Loop through all subdirectories and add them to the stack.
					
					foreach (string directoryName in Directory.GetDirectories(dir))
					{
						stack.Push(directoryName);
					}
					
				}
				catch (Exception)
				{
				}
			}
			
			// Return the list
			return result;
		}
		
		public void GetFilesToArchive(ref int iInventoryCnt, bool ckArchiveBit, bool IncludeSubDir, string DirToInventory, List<string> FilterList, List<string> FilesToArchive)
		{
			
			FilesToArchive.Clear();
			
			string MSG = "";
			bool ArchiveAttr = false;
			System.IO.FileInfo fi;
			
			List<FileInfo> Files = null;
			
			if (IncludeSubDir == true)
			{
				Files = GetFilesRecursive(DirToInventory, FilterList);
			}
			else
			{
				Files = GetFiles(DirToInventory, FilterList);
			}
			foreach (System.IO.FileInfo tempLoopVar_fi in Files)
			{
				fi = tempLoopVar_fi;
				if (iInventoryCnt % 5 == 0)
				{
					frmNotify.Default.lblFileSpec.Text = (string) ("Cataloging File: " + iInventoryCnt.ToString() + " of " + Files.Count.ToString());
				}
				
				frmNotify.Default.Refresh();
				iInventoryCnt++;
				Application.DoEvents();
				if (fi.Attributes && 32)
				{
					ArchiveAttr = true;
				}
				else
				{
					ArchiveAttr = false;
					if (ckArchiveBit == true)
					{
						goto SkipIT;
					}
				}
				
				//Console.WriteLine(fi.Name)
				//Console.WriteLine(fi.Extension)
				//Console.WriteLine(fi.DirectoryName)
				//Console.WriteLine(fi.Length)
				//Console.WriteLine(fi.CreationTime)
				//Console.WriteLine(fi.LastWriteTime)
				//Console.WriteLine(fi.LastAccessTime)
				//Console.WriteLine(fi.Length)
				//Console.WriteLine(fi.Attributes)
				
				MSG = System.Convert.ToString(ArchiveAttr + "|" + fi.Name + "|" + fi.Extension + "|" + fi.DirectoryName + "|" + fi.Length + "|" + fi.CreationTime + "|" + fi.LastWriteTime + "|" + fi.LastAccessTime);
				//Console.WriteLine(MSG)
				FilesToArchive.Add(MSG);
SkipIT:
				1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
			}
			
			fi = null;
			GC.Collect();
			GC.WaitForFullGCApproach();
			
		}
		public bool ckPdfSearchable(string FQN)
		{
			
			string EntireFile;
			System.IO.File oFile;
			System.IO.StreamReader oRead;
			FQN = ReplaceSingleQuotes(FQN);
			oRead = oFile.OpenText(FQN);
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
			object fso;
			object f;
			fso = Interaction.CreateObject("Scripting.FileSystemObject", "");
			f = fso.GetFile(filespec);
			if (f.attributes && 32)
			{
				//f.attributes = f.attributes - 32
				//TurnOffArchiveBit = "Archive bit is cleared."
				B = true;
			}
			else
			{
				//f.attributes = f.attributes + 32
				//TurnOffArchiveBit = "Archive bit is set."
				B = false;
			}
			return B;
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
		
		public void deleteDirectoryFile(string DirFQN)
		{
			string FileName;
			try
			{
				foreach (string tempLoopVar_FileName in System.IO.Directory.GetFiles(DirFQN))
				{
					FileName = tempLoopVar_FileName;
					try
					{
						System.IO.File.Delete(FileName);
					}
					catch (System.Exception)
					{
						LOG.WriteToArchiveLog("ERROR 100 clsEmailFunctions:deleteDirectoryFile - failed to delete file \'" + FileName + "\'.");
					}
				}
			}
			catch (System.Exception)
			{
				LOG.WriteToArchiveLog("ERROR 200 :deleteDirectoryFile - failed to delete from Dir \'" + DirFQN + "\'.");
			}
			
		}
		
		public bool isFileArchiveAttributeSet(string FQN)
		{
			
			System.IO.FileInfo fileDetail = (new Microsoft.VisualBasic.Devices.ServerComputer()).FileSystem.GetFileInfo(FQN);
			//Console.WriteLine(fileDetail.IsReadOnly)
			int A = fileDetail.Attributes.Archive;
			int R = fileDetail.Attributes.ReadOnly;
			int H = fileDetail.Attributes.Hidden;
			int C = fileDetail.Attributes.Compressed;
			int D = fileDetail.Attributes.Directory;
			int E = fileDetail.Attributes.Encrypted;
			int N = fileDetail.Attributes.Normal;
			int NCI = fileDetail.Attributes.NotContentIndexed;
			int OL = fileDetail.Attributes.Offline;
			int S = fileDetail.Attributes.System;
			int T = fileDetail.Attributes.Temporary;
			
			//Console.WriteLine(CBool(fileDetail.Attributes And IO.FileAttributes.Hidden))
			
			if ((fileDetail.Attributes && fileDetail.Attributes.Archive) == fileDetail.Attributes.Archive)
			{
				//'MessageBox.Show(fileDetail.Name & " is Archived")
				return false;
			}
			else
			{
				//'MessageBox.Show(fileDetail.Name & " is NOT Archived")
				return true;
			}
			
		}
		
		public bool TurnOffArchiveBit(string filespec)
		{
			
			bool B = false;
			filespec = this.ReplaceSingleQuotes(filespec);
			
			try
			{
				FileInfo f = new FileInfo(filespec);
				f.Attributes = f.Attributes && ! FileAttributes.Archive;
				f = null;
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("Warning: TurnOffArchiveBit 100 - " + ex.Message));
				B = false;
			}
			
			return B;
		}
		
		public long getUsedMemory()
		{
			return ramCounter.NextValue();
		}
		
		public bool getImpersonateFileName(ref string FQN)
		{
			
			bool B = true;
			string tPath = LOG.getTempEnvironDir();
			if (tPath.Substring(tPath.Length - 1, 1).Equals("\\"))
			{
			}
			else
			{
				tPath = tPath + "\\";
			}
			tPath = tPath + "EcmDefaultLogin";
			//Dim D As Directory = Nothing
			if (! Directory.Exists(tPath))
			{
				try
				{
					Directory.CreateDirectory(tPath);
				}
				catch (Exception ex)
				{
					MessageBox.Show((string) ("Fatal ERROR: Failed to create the required directory, please ensure you have the required authority." + "\r\n" + ex.Message));
					return "Fatal ERROR: Failed to create the required directory, please ensure you have the required authority." + "\r\n" + ex.Message;
//					B = false;
				}
			}
			
			if (B)
			{
				FQN = tPath + "\\DefaultLogin.dat";
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
						MessageBox.Show((string) ("ERROR: Could not process Impersonation - 100x: " + "\r\n" + Ex.Message));
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
		public string GetFileContents(string FullPath, ref string ErrInfo)
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
				return System.IO.Directory.GetFiles(strPath).Length;
			}
			catch (Exception ex)
			{
				throw (new Exception("Error From GetFileCountDir Function" + ex.Message, ex));
			}
		}
		
		public int GetFileCountSubdir(string strPath)
		{
			try
			{
				return System.IO.Directory.GetFiles(strPath, "*.*", System.IO.SearchOption.AllDirectories).Length;
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error From GetFileCountSubdir Function" + "\r\n" + ex.Message));
			}
		}
		
		public void cleanTempWorkingDir()
		{
			List<string> FilterList = new List<string>();
			string ZipProcessingDir = getTempProcessingDir();
			List<FileInfo> Files = null;
			bool IncludeSubDir = false;
			FileInfo FI;
			DateTime StartTime;
			TimeSpan ElapsedTime;
			
			int NbrOdDaysToKeep = 3;
			
			FilterList.Add("*.*");
			Files = GetFilesRecursive(ZipProcessingDir, FilterList);
			
			foreach (FileInfo tempLoopVar_FI in Files)
			{
				FI = tempLoopVar_FI;
				try
				{
					DateTime CreateDate = FI.CreationTime;
					StartTime = DateTime.Now;
					ElapsedTime = DateTime.Now.Subtract(CreateDate);
					int iDays = (int) ElapsedTime.TotalDays;
					if (iDays > NbrOdDaysToKeep)
					{
						FI.Delete();
					}
				}
				catch (Exception)
				{
					Console.WriteLine("Failed to delete:" + FI.Name);
				}
			}
			
			FI = null;
			
			string S = ISO.readIsoFile(" FilesToDelete.dat");
			string[] sFilesToDelete = S.Split("|".ToCharArray());
			foreach (string tempLoopVar_S in sFilesToDelete)
			{
				S = tempLoopVar_S;
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
				catch (Exception)
				{
					LOG.WriteToArchiveLog("NOTICE: Failed to delete temp file \'" + S + "\'.");
				}
			}
			
			RemoveEmptyDirectories(ZipProcessingDir);
			ISO.saveIsoFileZeroize(" FilesToDelete.dat", " ");
			
			GC.Collect();
		}
		
		//******************************************************************************
		//*Purpose   :                   Removes all empty subdirectories under a directory
		//*Inputs: strPath(string)   :   Path of the folder.
		//* W. Dale Miller
		//******************************************************************************
		public void RemoveEmptyDirectories(string RootDir)
		{
			
			DirectoryInfo Root = new DirectoryInfo(RootDir);
			FileInfo[] Files = Root.GetFiles("*.*");
			DirectoryInfo[] Dirs = Root.GetDirectories("*.*");
			List<string> DirsToRemove = new List<string>();
			
			try
			{
				Console.WriteLine("Root Directories");
				
				foreach (DirectoryInfo DirectoryName in Dirs)
				{
					try
					{
						Console.Write(DirectoryName.FullName);
						if (DirectoryName.GetFiles().Count == 0)
						{
							DirsToRemove.Add(DirectoryName.FullName);
						}
					}
					catch (Exception)
					{
						LOG.WriteToArchiveLog("ERROR: RemoveEmptyDirectories 01 - Failed to SAVE temp directory: " + DirectoryName.FullName + " into delete file.");
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR: RemoveEmptyDirectories 02 - " + ex.Message));
			}
			finally
			{
				foreach (string S in DirsToRemove)
				{
					try
					{
						Directory.Delete(S);
					}
					catch (Exception)
					{
						Console.WriteLine("ERROR: RemoveEmptyDirectories 01 - Failed to DELETE temp directory: " + S + ".");
					}
				}
			}
			DirsToRemove = null;
			GC.Collect();
		}
		//******************************************************************************
		//*Purpose   :                   Get File Count in a specified directory
		//*Inputs: strPath(string)   :   Path of the folder.
		//* W. Dale Miller
		//*Returns   :   File Count
		//******************************************************************************
		public int GetFileCount(string strPath)
		{
			try
			{
				return System.IO.Directory.GetFiles(strPath).Length;
			}
			catch (Exception ex)
			{
				throw (new Exception("Error From GetFileCount Function" + ex.Message, ex));
			}
		}
		
		//******************************************************************************
		//*Purpose   :   Convert a bitmap from color to black and white only
		//*Inputs    :   strPath(string)   :   Path of the folder.
		//*By        :   W. Dale Miller
		//*Copyright :   @DMA, Limited, June 2005, all rights reserved.
		//*Returns   :   Bitmap
		//******************************************************************************
		public System.Drawing.Bitmap ConvertGraphicToBlackWhite(System.Drawing.Bitmap image, BWMode Mode = BWMode.By_Lightness, float tolerance = 0)
		{
			int x;
			int y;
			if (tolerance > 1 || tolerance < -1)
			{
				throw (new ArgumentOutOfRangeException);
				return null;
			}
			for (x = 0; x <= image.Width - 1; x++)
			{
				for (y = 0; y <= image.Height - 1; y++)
				{
					Color clr = image.GetPixel(x, y);
					if (Mode == BWMode.By_RGB_Value)
					{
						if (((clr.R) + (clr.G) + clr.B) > 383 - (tolerance * 383))
						{
							image.SetPixel(x, y, Color.White);
						}
						else
						{
							image.SetPixel(x, y, Color.Black);
						}
					}
					else
					{
						if (clr.GetBrightness() > 0.5 - (tolerance / 2))
						{
							image.SetPixel(x, y, Color.White);
						}
						else
						{
							image.SetPixel(x, y, Color.Black);
						}
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

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

using System.Threading;
using System.IO;
using System.Configuration;
using System.Runtime.InteropServices;

//Imports Microsoft.VisualBasic
//Imports Microsoft.Win32


namespace ECMSearchWPF
{
	public class clsUtility
	{
		
		
		//Dim proxy As New SVCSearch.Service1Client
		
		clsLogging LOG = new clsLogging();
		//Dim EP As New clsEndPoint
		
		string SystemSqlTimeout = "90";
		
		[DllImport("kernel32.dll", ExactSpelling=true, CharSet=CharSet.Ansi, SetLastError=true)]
		private static extern long GetTickCount();
		
		string SecureID;
		public clsUtility()
		{
			SecureID = GLOBALS._SecureID.ToString();
		}
		
		public void RemoveBlanks(ref string tStr)
		{
			string S = tStr;
			var NewStr = "";
			int BlankCnt = 0;
			var CH = "";
			for (int i = 1; i <= S.Length; i++)
			{
				CH = S.Substring(i - 1, 1);
				if (CH.Equals(" "))
				{
					BlankCnt++;
				}
				else if (CH.Equals(Strings.ChrW(9)))
				{
					BlankCnt++;
				}
				else if (CH.Equals(Strings.ChrW(34)))
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
		
		public string ParseLic(string tKey)
		{
			string S = "";
			if (modGlobals.gLicenseItems.ContainsKey(tKey))
			{
				S = modGlobals.gLicenseItems[tKey];
			}
			return S;
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
		public string GetParentImageProcessingFile()
		{
			
			string S = "";
			try
			{
				S = "c:\\temp\\";
				if (spaceCnt(S) > 0)
				{
					LOG.WriteToSqlLog("ERROR: PdfProcessingDir (config.app) CANNOT HAVE SPACES IN THE NAME, defauling to C:\\Temp\\");
					S = "C:\\Temp\\";
				}
			}
			catch (Exception)
			{
				S = "C:\\Temp\\";
			}
			
			return S;
			
		}
		
		public void getMachineName()
		{
			string S = "";
			
			
			GLOBALS.ProxySearch.GetMachineIPCompleted += new System.EventHandler(client_GetMachineIPAddr);
			//EP.setSearchSvcEndPoint(proxy)
			GLOBALS.ProxySearch.GetMachineIPAsync(S);
			
		}
		public void client_GetMachineIPAddr(object sender, SVCSearch.GetMachineIPCompletedEventArgs e)
		{
			if (e.Error == null)
			{
				modGlobals.gMachineID = (string) e.Result;
			}
			else
			{
				modGlobals.gErrorCount++;
				LOG.WriteToSqlLog("ERROR client_GetMachineIPAddr: Failed to the Machine Name.");
			}
			GLOBALS.ProxySearch.GetMachineIPCompleted -= new System.EventHandler(client_GetMachineIPAddr);
		}
		
		public string getTempPdfWorkingDir(bool RetainFiles)
		{
			
			var TempSysDir = GetParentImageProcessingFile() + "ECM\\OCR\\Extract";
			if (! Directory.Exists(TempSysDir))
			{
				Directory.CreateDirectory(TempSysDir);
			}
			if (RetainFiles == false)
			{
				ZeroizePdaDir();
			}
			return TempSysDir;
			
		}
		
		public string getTempPdfWorkingErrorDir()
		{
			var TempSysDir = GetParentImageProcessingFile() + "ECM\\ErrorFile";
			if (! Directory.Exists(TempSysDir))
			{
				Directory.CreateDirectory(TempSysDir);
			}
			return TempSysDir;
		}
		
		private void ZeroizePdaDir()
		{
			
			var TempSysDir = GetParentImageProcessingFile() + "ECM\\OCR\\Extract";
			if (! Directory.Exists(TempSysDir))
			{
				Directory.CreateDirectory(TempSysDir);
			}
			
			string s;
			foreach (string tempLoopVar_s in System.IO.Directory.EnumerateFiles(TempSysDir))
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
		
		//'Here is a call that uses the function above to determine if Excel is installed:
		//'MessageBox.Show("Is MS Excel installed? - " & IsApplicationInstalled("Excel.Application").ToString)
		//'RESULT:  Is MS Excell Installed? – True
		//Function IsApplicationInstalled(ByVal pSubKey As String) As Boolean
		//    Dim isInstalled As Boolean = False
		
		//    ' Declare a variable of type RegistryKey named classesRootRegisteryKey.
		//    ' Assign the Registry's ClassRoot key to the classesRootRegisteryKey
		//    ' variable.
		//    Dim classesRootRegistryKey As RegistryKey = Registry.ClassesRoot
		
		//    ' Declare a variable of type RegistryKey named subKeyRegistryKey.
		//    ' Call classesRootRegistryKey's OpenSubKey method passing in the
		//    ' pSubKey parameter passed into this function.
		//    ' Assign the result returned to suKeyRegistryKey.
		//    Dim subKeyRegistryKey As RegistryKey = _
		//          classesRootRegistryKey.OpenSubKey(pSubKey)
		
		//    ' If subKeyRegistryKey was assigned a value...
		//    If Not subKeyRegistryKey Is Nothing Then
		//        ' Key exists; application is installed.
		//        isInstalled = True
		//    End If
		
		//    ' Close the subKeyRgisteryKey.
		//    subKeyRegistryKey.Close()
		
		//    Return isInstalled
		//End Function
		
		//Function isOfficeInstalled() As Boolean
		//    'Microsoft Office Enterprise 2007 | 12 | 0 | 1
		//    'Microsoft Office Professional Edition 2003 | 11 | 0 | 1
		//    Dim LOS As New List(Of String)
		//    LOS = getInstalledSoftware()
		//    For Each S As String In LOS
		//        If InStr(S, "Microsoft Office", CompareMethod.Text) > 0 Then
		//            Dim A() = S.Split("|")
		//            If A.Length > 1 Then
		//                Dim tVal$ = A(1)
		//                tVal = tVal.Trim
		//                If tVal.Equals("12") Or tVal.Equals("11") Then
		//                    Return True
		//                End If
		//            End If
		//        End If
		//    Next
		//    Return False
		//End Function
		
		//Function isOffice2003Installed() As Boolean
		//    'Microsoft Office Professional Edition 2003 | 11 | 0 | 1
		//    'Microsoft Office Enterprise 2007 | 12 | 0 | 1
		//    'Microsoft Office Professional Edition 2003 | 11 | 0 | 1
		//    Dim LOS As New List(Of String)
		//    LOS = getInstalledSoftware()
		//    For Each S As String In LOS
		//        If InStr(S, "Microsoft Office", CompareMethod.Text) > 0 Then
		//            Dim A() = S.Split("|")
		//            If A.Length > 1 Then
		//                Dim tVal$ = A(1)
		//                tVal = tVal.Trim
		//                If tVal.Equals("11") Then
		//                    Return True
		//                End If
		//            End If
		//        End If
		//    Next
		//    Return False
		//End Function
		
		//Function isOffice2007Installed() As Boolean
		//    'Microsoft Office Enterprise 2007 | 12 | 0 | 1
		//    Dim LOS As New List(Of String)
		//    LOS = getInstalledSoftware()
		//    For Each S As String In LOS
		//        If InStr(S, "Microsoft Office", CompareMethod.Text) > 0 Then
		//            Dim A() = S.Split("|")
		//            If A.Length > 1 Then
		//                Dim tVal$ = A(1)
		//                tVal = tVal.Trim
		//                If tVal.Equals("12") Then
		//                    Return True
		//                End If
		//            End If
		//        End If
		//        If InStr(S, "Microsoft Office", CompareMethod.Text) > 0 Then
		//            Dim A() = S.Split("|")
		//            If A.Length > 1 Then
		//                Dim tVal$ = A(1)
		//                tVal = tVal.Trim
		//                If tVal.Equals("14") Then
		//                    Return True
		//                End If
		//            End If
		//        End If
		//    Next
		//    Return False
		//End Function
		
		//Function isOutlookInstalled() As Boolean
		//    'Update for Microsoft Office Outlook 2007 Help (KB963677)
		//    Return False
		//End Function
		//Function isOutlook2003Installed() As Boolean
		//    'Update for Microsoft Office Outlook 2007 Help (KB963677)
		//    Return False
		//End Function
		//Function isOutlook2007Installed() As Boolean
		//    'Update for Microsoft Office Outlook 2007 Help (KB963677)
		//    Return False
		//End Function
		
		//Function getInstalledSoftware() As List(Of String)
		//    Dim strList As New List(Of String)
		
		//    Dim UninstallKey As String = ""
		//    UninstallKey = "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
		//    Dim RK As RegistryKey = Registry.LocalMachine.OpenSubKey(UninstallKey)
		//    For Each skName As String In RK.GetSubKeyNames
		//        Using sk As RegistryKey = RK.OpenSubKey(skName)
		//            'Console.WriteLine(sk.Name)
		//            'Console.WriteLine(sk.GetSubKeyNames)
		//            'Console.WriteLine(sk.GetSubKeyNames)
		//            Dim PackageName$ = ""
		//            Try
		//                PackageName$ = sk.GetValue("DisplayName")
		//                If PackageName$.Trim.Length > 0 Then
		//                    Try
		//                        Dim VersionMajor$ = sk.GetValue("VersionMajor")
		//                        Dim VersionMinor$ = sk.GetValue("VersionMinor")
		//                        Dim WindowsInstaller$ = sk.GetValue("WindowsInstaller")
		//                        If VersionMajor$.Trim.Length > 0 Then
		//                            PackageName$ = PackageName$ + " | " + VersionMajor$
		//                        End If
		//                        If VersionMinor$.Trim.Length > 0 Then
		//                            PackageName$ = PackageName$ + " | " + VersionMinor$
		//                        End If
		//                        If WindowsInstaller$.Trim.Length > 0 Then
		//                            PackageName$ = PackageName$ + " | " + WindowsInstaller$
		//                        End If
		//                    Catch ex As Exception
		
		//                    End Try
		//                    strList.Add(PackageName as string)
		//                End If
		//            Catch ex As Exception
		
		//            End Try
		//        End Using
		//    Next
		//    strList.Sort()
		//    Return strList
		//End Function
		
		public string RemoveSingleQuotes(string tVal)
		{
			
			string S = tVal;
			
			S = S.Replace("\'\'", "\'");
			S = S.Replace("\'", "\'\'");
			tVal = S;
			
			return tVal;
		}
		
		public string RemoveBadChars(string tVal)
		{
			
			string SS = tVal;
			
			try
			{
				int i = tVal.Length;
				string ch = "";
				string S = "0123456789 abcdefghijklmnopqrstuvwxyz.";
				for (i = 1; i <= tVal.Length; i++)
				{
					ch = tVal.Substring(i, 1);
					if (! SS.Contains(ch))
					{
						SS.Replace(ch, " ");
					}
				}
			}
			catch (Exception ex)
			{
				LOG.WriteToSqlLog((string) ("ERROR: clsUtility:RemoveBadChars - " + ex.Message + "\r\n" + ex.StackTrace));
			}
			
			return tVal.Trim();
		}
		public string RemoveSingleQuotesV1(string tVal)
		{
			string S = tVal;
			
			
			if (tVal.IndexOf("\'\'") + 1 > 0)
			{
				return (tVal);
			}
			if (tVal.IndexOf("\'") + 1 == 0)
			{
				return (tVal);
			}
			
			S.Replace("\'", "`");
			tVal = S;
			
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
			var NewStr = "";
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
			string SS = tVal;
			try
			{
				SS = SS.Replace("(", " ");
				SS = SS.Replace(")", " ");
				SS = SS.Replace("[", " ");
				SS = SS.Replace("]", " ");
			}
			catch (Exception ex)
			{
				LOG.WriteToSqlLog((string) ("ERROR: clsUtility:RemoveUnwantedCharacters - " + ex.Message + "\r\n" + ex.StackTrace));
			}
			
			return SS;
		}
		
		public string RemoveCrLF(string tVal)
		{
			string SS = tVal;
			try
			{
				SS = SS.Replace("\r\n", " ");
			}
			catch (Exception ex)
			{
				LOG.WriteToSqlLog((string) ("ERROR: clsUtility:RemoveCrLF - " + ex.Message + "\r\n" + ex.StackTrace));
			}
			return SS;
		}
		
		public string fixSingleQuotes(string tVal)
		{
			var tempStr = "";
			bool bLastCharIsQuote = false;
			
			tVal = tVal.Trim();
			if (tVal.Length == 0)
			{
				return tVal;
			}
			var CH = tVal.Substring(tVal.Length - 1, 1);
			if (CH.Equals("\'"))
			{
				bLastCharIsQuote = true;
			}
			
			object[] A = tVal.Split('\'');
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
			
			var TgtStr = "\'\'";
			var S1 = "";
			var S2 = "";
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
			string S = tVal;
			S.Replace("\'", "`");
			return S;
		}
		
		public string RemoveCommas(string tVal)
		{
			string S = tVal;
			S.Replace(",", "^");
			return S;
		}
		
		public string RemoveOcrProblemChars(string tVal)
		{
			string S = tVal;
			S.Replace(",", "z");
			S.Replace("$", "z");
			S.Replace("#", "z");
			S.Replace("@", "z");
			return S;
		}
		public void RemoveDoubleSlashes(ref string FQN)
		{
			string S = FQN;
			S.Replace("//", "");
			FQN = S;
		}
		
		public void setConnectionStringTimeout(ref string ConnStr, string TimeOutSecs)
		{
			
			int I = 0;
			string S = "";
			var NewConnStr = "";
			S = ConnStr;
			I = S.IndexOf("Connect Timeout =") + 1;
			if (I > 0)
			{
				var SqlTimeout = TimeOutSecs;
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
			ConnStr = NewConnStr;
		}
		public string setNewTimeout(string tgtStr, int StartingPoint, string NewVal)
		{
			var NextNumber = "";
			int NumberStartPos = 0;
			int NumberEndPos = 0;
			var NewStr = "";
			var S1 = "";
			var S2 = "";
			try
			{
				int I = 0;
				var CH = tgtStr.Substring(StartingPoint - 1, 1);
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
				var CurrVal = tgtStr.Substring(NumberStartPos - 1, NumberEndPos - NumberStartPos + 1);
				S1 = tgtStr.Substring(0, NumberStartPos - 1);
				S2 = tgtStr.Substring(NumberEndPos + 1 - 1);
				NewStr = S1 + " " + NewVal + " " + S2;
			}
			catch (Exception ex)
			{
				LOG.WriteToSqlLog((string) ("FindNextNumberInStr: " + ex.Message));
				NewStr = tgtStr;
			}
			return NewStr;
		}
		public string setNewTimeout(string tgtStr, int StartingPoint)
		{
			var NextNumber = "";
			int NumberStartPos = 0;
			int NumberEndPos = 0;
			var NewStr = "";
			var S1 = "";
			var S2 = "";
			try
			{
				int I = 0;
				var CH = tgtStr.Substring(StartingPoint - 1, 1);
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
				var CurrVal = tgtStr.Substring(NumberStartPos - 1, NumberEndPos - NumberStartPos + 1);
				S1 = tgtStr.Substring(0, NumberStartPos - 1);
				S2 = tgtStr.Substring(NumberEndPos + 1 - 1);
				NewStr = S1 + " " + SystemSqlTimeout + " " + S2;
			}
			catch (Exception ex)
			{
				LOG.WriteToSqlLog((string) ("FindNextNumberInStr: " + ex.Message));
				NewStr = tgtStr;
			}
			return NewStr;
		}
		
		public string getFileSuffix(string FQN)
		{
			int i = 0;
			var ch = "";
			var suffix = "";
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
			var Str1 = "";
			var Str2 = "";
			var NewStr = "";
			
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
				var SelectedServer = ServerName;
				if (SelectedServer.Length == 0)
				{
					MessageBox.Show("Please select the Server to which this license applies." + "\r\n" + "The server name and must match that contained within the license.");
					return false;
				}
				var FQN = LicenseDirectory + "\\" + "EcmLicense." + ServerName + ".txt";
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
			FileAttributes fAttr;
			fAttr = File.GetAttributes(FQN);
			bool isArchive = System.Convert.ToBoolean((File.GetAttributes(FQN) && FileAttributes.Archive) == FileAttributes.Archive);
			bool bArchive = FileAttributes.Archive;
			return isArchive;
			
		}
		public void setArchiveBitToNoArchNeeded(string FQN)
		{
			
			FileInfo FI = new FileInfo(FQN);
			FileAttributes fAttr;
			fAttr = File.GetAttributes(FQN);
			bool isArchive = System.Convert.ToBoolean((File.GetAttributes(FQN) && FileAttributes.Archive) == FileAttributes.Archive);
			bool bArchive = FileAttributes.Archive;
			
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
			//    MessageBox.Show("clsDma : ToggleArchiveBit : 648 : " + ex.Message)
			//End Try
			
		}
		public void setArchiveBitFasle(string FQN)
		{
			
			FileInfo FI = new FileInfo(FQN);
			FileAttributes fAttr;
			FI.Attributes = FileAttributes.Archive;
			fAttr = File.GetAttributes(FQN);
			bool isArchive = System.Convert.ToBoolean((File.GetAttributes(FQN) + FileAttributes.Archive) == FileAttributes.Archive);
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
			var S1 = "";
			int II = InsertConnStr.IndexOf("Connect Timeout") + 1;
			if (II > 0)
			{
				II = InsertConnStr.IndexOf("=", II + 5 - 1) + 1;
				if (II > 0)
				{
					int K = InsertConnStr.IndexOf(";", II + 1 - 1) + 1;
					if (K > 0)
					{
						var S2 = "";
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
			var S1 = "";
			int II = InsertConnStr.IndexOf("Connect Timeout") + 1;
			if (II > 0)
			{
				II = InsertConnStr.IndexOf("=", II + 5 - 1) + 1;
				if (II > 0)
				{
					int K = InsertConnStr.IndexOf(";", II + 1 - 1) + 1;
					if (K > 0)
					{
						var S2 = "";
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
			
			object[] AR;
			
			int I = 0;
			double a = 1;
			for (I = 1; I <= S.Length; I++)
			{
				a = System.Convert.ToDouble(Strings.AscW(S.Substring(I - 1, 1)) * 1000 + Strings.AscW(S.Substring(I - 1, 1)) + I);
				a = System.Math.Sqrt(a * I * Strings.AscW(S.Substring(I - 1, 1))); //Numeric Hash
			}
			
			AR = S.Split(".".ToCharArray());
			for (I = 0; I <= (AR.Length - 1); I++)
			{
				if (modGlobals.isNumericDma((string) (AR[I])))
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
			
			int I = FQN.Length;
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
			
			int I = FileName.Length;
			string sHash = FileName.Length.ToString() + ":" + dHash.ToString();
			return sHash;
			
		}
		
		public string HashDirFileName(string DirName, string FileName)
		{
			
			string sHash = (string) (HashDirName(DirName) + ":" + HashFileName(FileName));
			return sHash;
			
		}
		
		
		//Sub SaveNewUserSettings()
		//    WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 100")
		//    'Dim ECMDB$ = System.Configuration.ConfigurationManager.AppSettings("CONN_DMA.DB")
		//    'WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 200 " + ECMDB  )
		//    Dim ECMDB$ = My.Settings("UserDefaultConnString")
		//    'WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 300 " + ECMDB  )
		
		//    My.Settings("UpgradeSettings") = False
		//    My.Settings("DB_EcmLibrary") = My.Settings("UserDefaultConnString")
		//    My.Settings("DB_Thesaurus") = My.Settings("UserThesaurusConnString")
		//    'My.Settings("UserDefaultConnString") = System.Configuration.ConfigurationManager.AppSettings("CONN_DMA.DB")
		//    ' My.Settings("UserThesaurusConnString") = System.Configuration.ConfigurationManager.AppSettings("ECM_ThesaurusConnectionString")
		//    My.Settings.Save()
		
		//    WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 400 " + My.Settings("DB_EcmLibrary"))
		//    WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 500 " + My.Settings("DB_Thesaurus"))
		//    WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 600 " + My.Settings("UserDefaultConnString"))
		//    WriteToInstallLog("NOTICE: clsUtility: SaveNewUserSettings - 700 " + My.Settings("UserThesaurusConnString"))
		
		//End Sub
		
		//Function EnumerateDiskDrives(ByRef Drives As SortedList(Of String, String)) As Boolean
		
		//    ' Dim fso As New Scripting.FileSystemObject()
		//    Dim objDrive
		//    Dim objFSO As Object
		
		//    objFSO = CreateObject("Scripting.FileSystemObject")
		//    Dim colDrives = objFSO.Drives
		
		//    For Each objDrive In colDrives
		//        Dim DriveType$ = ""
		//        Dim DriveLetter$ = objDrive.DriveLetter
		//        Dim NumData As Integer = objDrive.drivetype
		//        Select Case NumData
		//            Case 1
		//                DriveType$ = "Removable"
		//            Case 2
		//                DriveType$ = "Fixed"
		//            Case 3
		//                DriveType$ = "Network"
		//            Case 4
		//                DriveType$ = "CD-ROM"
		//            Case 5
		//                DriveType$ = "RAM Disk"
		//            Case Else
		//                DriveType$ = "Unknown"
		//        End Select
		//        If Drives.IndexOfKey(DriveLetter) >= 0 Then
		//        Else
		//            Drives.Add(DriveLetter, DriveType)
		//        End If
		//    Next
		
		//End Function
		
		//Sub xSaveCurrentConnectionInfo()
		
		//    Dim ENC As New clsEncrypt
		
		//    Dim TempDir$ = Environment.GetEnvironmentVariable("temp")
		//    Dim EcmConStr$ = "ECM" + Chr(254)
		//    Dim ThesaurusStr$ = "THE" + Chr(254)
		//    Dim FileName$ = "EcmLoginInfo.DAT"
		//    Dim FQN$ = TempDir + "\" + FileName
		
		
		//    Dim oFile As System.IO.File
		//    Dim oWrite As System.IO.StreamWriter
		
		//    Try
		//        EcmConStr$ += My.Settings("UserDefaultConnString")
		//        ThesaurusStr$ += My.Settings("UserThesaurusConnString")
		
		//        oWrite = oFile.CreateText(FQN  )
		
		//        EcmConStr = ENC.AES256EncryptString(EcmConStr)
		//        ThesaurusStr$ = ENC.AES256EncryptString(ThesaurusStr  )
		//        oWrite.WriteLine(EcmConStr)
		//        oWrite.WriteLine(ThesaurusStr)
		//    Catch ex As Exception
		//        WriteToInstallLog("ERROR: 100.11 - SaveCurrentConnectionInfo : " + ex.Message)
		//        WriteToInstallLog("ERROR: 100.11 - SaveCurrentConnectionInfo : " + ex.StackTrace)
		//    Finally
		//        oWrite.Close()
		//        oWrite = Nothing
		//        oFile = Nothing
		//    End Try
		
		//End Sub
		//Sub xgetCurrentConnectionInfo()
		
		//    Try
		//        WriteToInstallLog("Track 1")
		//        Dim ENC As New clsEncrypt
		
		//        Dim TempDir$ = Environment.GetEnvironmentVariable("temp")
		//        Dim EcmConStr$ = "ECM" + Chr(254)
		//        Dim ThesaurusStr$ = "THE" + Chr(254)
		//        Dim FileName$ = "EcmLoginInfo.DAT"
		//        Dim FQN$ = TempDir + "\" + FileName
		//        Dim LineIn$ = ""
		//        Dim oFile As System.IO.File
		//        Dim oRead As System.IO.StreamReader
		//        WriteToInstallLog("Track 2")
		//        Dim F As File
		//        If Not F.Exists(FQN  ) Then
		//            oRead.Close()
		//            oRead = Nothing
		//            oFile = Nothing
		//            Return
		//        End If
		//        WriteToInstallLog("Track 3")
		//        Try
		//            oRead = oFile.OpenText(FQN)
		//            Dim NeedsSaving As Boolean = False
		//            While oRead.Peek <> -1
		//                LineIn = oRead.ReadLine()
		//                LineIn = ENC.AES256DecryptString(LineIn)
		
		//                Dim A$() = LineIn.Split("?")
		//                Dim tCode$ = A(0)
		//                Dim cs$ = A(1)
		
		//                If tCode.Equals("ECM") Then
		//                    My.Settings("DB_EcmLibrary") = cs$
		//                    My.Settings("UserDefaultConnString") = cs$
		//                    NeedsSaving = True
		//                End If
		//                If tCode.Equals("THE") Then
		//                    My.Settings("DB_Thesaurus") = cs$
		//                    My.Settings("UserThesaurusConnString") = cs$
		//                    NeedsSaving = True
		//                End If
		
		//            End While
		//            If NeedsSaving = True Then
		//                My.Settings.Save()
		//            End If
		//        Catch ex As Exception
		//            WriteToInstallLog("ERROR: 100.11 - getCurrentConnectionInfo : " + ex.Message)
		//            WriteToInstallLog("ERROR: 100.11 - getCurrentConnectionInfo : " + ex.StackTrace)
		//        Finally
		//            oRead.Close()
		//            oFile = Nothing
		//            ENC = Nothing
		//        End Try
		//    Catch ex As Exception
		//        WriteToInstallLog("ERROR: 300.11 - getCurrentConnectionInfo : " + ex.Message)
		//        WriteToInstallLog("ERROR: 300.11 - getCurrentConnectionInfo : " + ex.StackTrace)
		//    End Try
		
		//End Sub
		
		public string genEmailIdentifier(string MessageSize, string ReceivedTime, string SenderEmailAddress, string Subject, string CurrentUserID)
		{
			string EmailIdentifier = MessageSize + "~" + ReceivedTime + "~" + SenderEmailAddress + "~" + Subject.Substring(0, 80) + "~" + CurrentUserID;
			
			EmailIdentifier = RemoveSingleQuotes(EmailIdentifier);
			return EmailIdentifier;
		}
		
		public void ckSqlQryForDoubleKeyWords(ref string MyQry)
		{
			
			MyQry = RemoveCrLF(MyQry);
			
			object[] A = MyQry.Split(' ');
			
			string Token = "";
			string PrevToken = "";
			
			for (int i = 0; i <= (A.Length - 1); i++)
			{
				Token = (string) (A[i].Trim);
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
		
		public void AddHiveSearch(ref string tSql, System.Windows.Documents.List<string> HiveServers)
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
			
			tSql = tempSql;
			
		}
		
		public void StripSingleQuotes(ref string S)
		{
			
			if (S == null)
			{
				S = " ";
				return;
			}
			
			S = S.Replace("\'", " ");
			
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
		
		public bool FileOnLocalComputer(string FQN)
		{
			
			bool B = false;
			if (File.Exists(FQN))
			{
				B = true;
			}
			else
			{
				B = false;
			}
			return B;
		}
		
		//Function isOutLookRunning() As Boolean
		//    Dim procs() As Process = Process.GetProcessesByName("Outlook")
		//    If procs.Count > 0 Then
		//        Return True
		//    Else
		//        Return False
		//    End If
		//End Function
		
		//Sub KillOutlookRunning()
		
		//    For Each RunningProcess In Process.GetProcessesByName("Outlook")
		//        RunningProcess.Kill()
		//    Next
		
		//End Sub
		
		public string RemoveCommaNbr(string sNbr)
		{
			if (sNbr.IndexOf("$") + 1 == 0 && sNbr.IndexOf(",") + 1 == 0)
			{
				return sNbr;
			}
			string NewNbr = "";
			string CH = "";
			int I = 0;
			for (I = 1; I <= sNbr.Length; I++)
			{
				CH = sNbr.Substring(I - 1, 1);
				if (CH.Equals("$"))
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
				LOG.WriteToSqlLog((string) ("ERRROR date: ConvertDate 100: LL= " + LL.ToString() + ", error on converting date \'" + tDate.ToString() + "\'." + "\r\n" + ex.Message));
			}
			
			return xDate;
			
		}
		
		public bool ckPdfSearchable(string FQN)
		{
			
			string EntireFile;
			System.IO.StreamReader oRead;
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
			
			GC.Collect();
			GC.WaitForPendingFinalizers();
			
			return B;
			
		}
		
		public void RemoveFreetextStopWords(ref string SearchPhrase)
		{
			
			SearchPhrase = SearchPhrase.Trim();
			if (SearchPhrase.Trim().Length == 0)
			{
				return;
			}
			
			List<string> AL = new List<string>();
			//** The below needs to be added back as a SERVICE call to ClsDatabase if this function is used 3/22/2011 WDM
			//GetSkipWords(AL)
			
			for (int i = 1; i <= SearchPhrase.Length; i++)
			{
				var CH = SearchPhrase.Substring(i - 1, 1);
				if (CH == Strings.ChrW(34))
				{
					//Mid(SearchPhrase, i, 1) = " "
					modGlobals.MidX(SearchPhrase, i, " ");
				}
			}
			string NewPhrase = "";
			string[] A = SearchPhrase.Split(" ".ToCharArray());
			for (int i = 0; i <= (A.Length - 1); i++)
			{
				var tWord = A[i].Trim();
				var TempWord = tWord;
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
			
			for (int i = 0; i <= (A.Length - 1); i++)
			{
				if (A[i].Trim().Length > 0)
				{
					NewPhrase = NewPhrase + " " + A[i];
				}
			}
			SearchPhrase = NewPhrase;
		}
		
		public void SetVersionAndServer()
		{
			try
			{
				System.Reflection.Assembly ASSM = System.Reflection.Assembly.GetExecutingAssembly();
				string FullName = ASSM.FullName;
				//Dim fullversion As String = ASSM.version
				//Dim S as string = " APP:" & Application.Info.Version.Major & "." & Application.Info.Version.Minor & "." & Application.Info.Version.Build & "." & Application.Info.Version.Revision & " "
			}
			catch (Exception ex)
			{
				Console.WriteLine(ex.Message);
				LOG.WriteToSqlLog((string) ("Notice 001.z1 : SetVersionAndServer - " + ex.Message));
			}
			
		}
		
		
		
	}
	
}

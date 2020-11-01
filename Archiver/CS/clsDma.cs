#define Offfice2007
#define GetAllWidgets
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

using Microsoft.Win32;
using System.Configuration;
//using System.Net.Dns;
using System.Data.SqlClient;
using System.IO;
using System.Security.Permissions;
using System.Net;
using System.Net.Sockets;
using System.Text.RegularExpressions;
using System.Text;
using System.Data.Sql;
using Microsoft.SqlServer;
using System.Speech;
using System.Speech.Synthesis;
using Microsoft.SqlServer.Management.Smo;
using Microsoft.SqlServer.Management.Common;
using Microsoft.SqlServer.Management.Smo.Agent;
using System.Runtime.InteropServices;
using Microsoft.VisualBasic.CompilerServices;

//clsDma: A set of standard utilities to perofrm repetitive tasks through a public class
//Copyright @DMA, Limited, Chicago, IL., June 2003, all rights reserved.
//Licensed on a use only basis for clients of DMA, Limited.

//Imports VB = Microsoft.VisualBasic



namespace EcmArchiveClcSetup
{
	public class clsDma
	{
		public clsDma()
		{
			// VBConversions Note: Non-static class variable initialization is below.  Class variables cannot be initially assigned non-static values in C#.
			TempEnvironDir = getEnvVarTempDir();
			
		}
		
		const int MUST_BE_LESS_THAN = 100000000; //8 decimal digits
		clsUtility UTIL = new clsUtility();
		clsLogging LOG = new clsLogging();
		public int IXV1 = 0;
		//Dim DFLT As New clsDefaults
		
		//Dim owner As IWin32Window
		private const long BUFFERSIZE = 65535;
		long GraphicWidth = 0;
		long GraphicHeight = 0;
		long GraphicDepth = 0;
		
		// image type enum
		[DllImport("urlmon",EntryPoint="URLDownloadToFileA", ExactSpelling=true, CharSet=CharSet.Ansi, SetLastError=true)]
		private static extern long URLDownloadToFile(long pCaller, string szURL, string szFileName, long dwReserved, long lpfnCB);
		
		bool dDeBug = false;
		bool bb = false;
		public string TempEnvironDir; // VBConversions Note: Initial value of "getEnvVarTempDir()" cannot be assigned here since it is non-static.  Assignment has been moved to the class constructors.
		private string CurrHostName = "";
		private string MachineIP = "";
		
		System.Net.IPAddress myIPAddress;
		System.Net.IPAddress MacAddr;
		System.Net.IPAddress x;
		System.Net.IPHostEntry myIPHostEntry = new System.Net.IPHostEntry();
		
		//Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)
		
		Microsoft.Win32.Registry oReg;
		Microsoft.Win32.RegistryKey oRegKey;
		
		public bool RetC;
		
		public void WildCardCharValidate(string StringToEval)
		{
			
			string S = StringToEval.Trim();
			int I = 0;
			int J = 0;
			string CH = "";
			
			for (I = 0; I <= S.Length; I++)
			{
				CH = S.Substring(I - 1, 1);
				if (CH == '\u0022')
				{
					I++;
					CH = S.Substring(I - 1, 1);
					while (CH != '\u0022' && I <= S.Length)
					{
						CH = S.Substring(I - 1, 1);
						I++;
					}
				}
				else if (CH == "*")
				{
					StringType.MidStmtStr(ref S, I, 1, "%");
				}
			}
			
		}
		
		public void getSubDirs(ref string[] Dirs, string TargetDir)
		{
			//String [] subs = Directory.GetDirectories("C:\\Inetpub\\wwwroot");
			//String [] subs = Directory.GetDirectories("C:/Inetpub/wwwroot");
			Dirs = new string[1];
			//ReDim Files (0)
			string path = TargetDir;
			try
			{
				if (! Directory.Exists(path))
				{
					return;
				}
				else
				{
					Dirs = Directory.GetDirectories(path);
					//Files = Directory.GetFiles(path)
				}
			}
			catch (Exception ex)
			{
				if (dDeBug)
				{
					Console.WriteLine(ex.Source);
				}
				if (dDeBug)
				{
					Console.WriteLine(ex.StackTrace);
				}
				if (dDeBug)
				{
					Console.WriteLine(ex.Message);
				}
				
				LogThis((string) ("clsDma : getSubDirs : 27 : " + ex.Message));
				LogThis((string) ("clsDma : getSubDirs : 28 : " + ex.Message));
				LogThis((string) ("clsDma : getSubDirs : 29 : " + ex.Message));
				
			}
		}
		
		public void getDirFiles(ref string[] Files, string TargetDir)
		{
			//String [] subs = Directory.GetDirectories("C:\\Inetpub\\wwwroot");
			//String [] subs = Directory.GetDirectories("C:/Inetpub/wwwroot");
			//ReDim Dirs (0)
			Files = new string[1];
			string path = TargetDir;
			try
			{
				if (! Directory.Exists(path))
				{
					return;
				}
				else
				{
					//Dirs = Directory.GetDirectories(path)
					Files = Directory.GetFiles(path);
				}
			}
			catch (Exception ex)
			{
				LogThis((string) ("clsDma : getDirFiles : 37 : " + ex.Message));
			}
		}
		
		public string ckVar2(ref string tVal)
		{
			if (tVal == "&nbsp;")
			{
				tVal = "";
			}
			return tVal;
		}
		
		public void ListDirs(ref string[] Dirs, ref string[] Files, string TargetDir)
		{
			//String [] subs = Directory.GetDirectories("C:\\Inetpub\\wwwroot");
			//String [] subs = Directory.GetDirectories("C:/Inetpub/wwwroot");
			Dirs = new string[1];
			Files = new string[1];
			string path = TargetDir;
			try
			{
				if (! Directory.Exists(path))
				{
					return;
				}
				else
				{
					Dirs = Directory.GetDirectories(path);
					Files = Directory.GetFiles(path);
				}
			}
			catch (Exception ex)
			{
				if (dDeBug)
				{
					Console.WriteLine(ex.Source);
				}
				if (dDeBug)
				{
					Console.WriteLine(ex.StackTrace);
				}
				if (dDeBug)
				{
					Console.WriteLine(ex.Message);
				}
				LogThis((string) ("clsDma : ListDirs : 52 : " + ex.Message));
				LogThis((string) ("clsDma : ListDirs : 55 : " + ex.Message));
				LogThis((string) ("clsDma : ListDirs : 58 : " + ex.Message));
			}
		}
		
		public bool DownloadWebFile(string WebFqn, string ToFqn)
		{
			bool B = false;
			WebFqn = "http://www.vb-helper.com/vbhelper_425_64.gif";
			ToFqn = modGlobals.gTempDir + "\\vbhelper_425_64.gif";
			
			try
			{
				URLDownloadToFile(0, WebFqn, ToFqn, 0, 0);
				B = true;
			}
			catch (Exception ex)
			{
				B = false;
				LogThis((string) ("clsDma : DownloadWebFile : 59 : " + ex.Message));
				LogThis((string) ("clsDma : DownloadWebFile : 63 : " + ex.Message));
				LogThis((string) ("clsDma : DownloadWebFile : 67 : " + ex.Message));
			}
			return B;
		}
		
		public void setHostName()
		{
			string shostname = "";
			shostname = System.Net.Dns.GetHostName();
			if (dDeBug)
			{
				Console.WriteLine("Your Machine Name = " + shostname);
			}
			CurrHostName = shostname;
		}
		
		public string getHostname()
		{
			if (CurrHostName == "")
			{
				setHostName();
			}
			return CurrHostName;
		}
		
		public void setIPAddr()
		{
			
			string s = "";
			bool dd = false;
			string server;
			server = System.Net.Dns.GetHostName();
			
			try
			{
				System.Text.ASCIIEncoding ASCII = new System.Text.ASCIIEncoding();
				
				// Get server related information.
				IPHostEntry heserver = Dns.GetHostEntry(server);
				
				// Loop on the AddressList
				IPAddress curAdd;
				foreach (IPAddress tempLoopVar_curAdd in heserver.AddressList)
				{
					curAdd = tempLoopVar_curAdd;
					
					// Display the type of address family supported by the server. If the
					// server is IPv6-enabled this value is: InternNetworkV6. If the server
					// is also IPv4-enabled there will be an additional value of InterNetwork.
					//** Console.WriteLine(("AddressFamily: " + curAdd.AddressFamily.ToString()))
					s = (string) ("AddressFamily: " + curAdd.AddressFamily.ToString());
					if (dDeBug)
					{
						Console.WriteLine(s);
					}
					
					// Display the ScopeId property in case of IPV6 addresses.
					if (curAdd.AddressFamily.ToString() == ProtocolFamily.InterNetworkV6.ToString())
					{
						s = (string) ("Scope Id: " + curAdd.ScopeId.ToString());
						if (dDeBug)
						{
							if (dDeBug)
							{
								Console.WriteLine(s);
							}
						}
					}
					
					// Display the server IP address in the standard format. In
					// IPv4 the format will be dotted-quad notation, in IPv6 it will be
					// in in colon-hexadecimal notation.
					s = (string) ("Address: " + curAdd.ToString());
					s = curAdd.ToString();
					Console.WriteLine(s);
					if (isFourPartIP(s))
					{
						MachineIP = s;
						break;
					}
					// Display the server IP address in byte format.
					//Console.Write("AddressBytes: ")
					//s = ""
					//Dim bytes As [Byte]() = curAdd.GetAddressBytes()
					//Dim i As Integer
					//For i = 0 To bytes.Length - 1
					//    Console.Write(bytes(i))
					//    s = s + bytes(i).ToString
					//Next i
					//Console.WriteLine(ControlChars.Cr + ControlChars.Lf)
					//Console.WriteLine(s)
				}
				
			}
			catch (Exception e)
			{
				if (dDeBug)
				{
					Console.WriteLine("[DoResolve] Exception: " + e.ToString());
				}
				LogThis((string) ("clsDma : setIPAddr : 87 : " + e.Message));
				LogThis((string) ("clsDma : setIPAddr : 92 : " + e.Message));
				LogThis((string) ("clsDma : setIPAddr : 97 : " + e.Message));
			}
			
			MachineIP = s;
			
		}
		
		public bool isFourPartIP(string IP)
		{
			if (IP.IndexOf(":") + 1 > 0)
			{
				return false;
			}
			string[] A = IP.Split(".".ToCharArray());
			if (A.Length == 4)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public string getIpAddr()
		{
			if (MachineIP == "")
			{
				setIPAddr();
			}
			return MachineIP;
		}
		
		public string getEnvVarTempDir()
		{
			string td = "";
			
			try
			{
				td = Interaction.Environ("TEMP");
				TempEnvironDir = td;
			}
			catch (Exception ex)
			{
				td = "";
				if (dDeBug)
				{
					Console.WriteLine(ex.Message);
				}
			}
			
			return td;
		}
		
		
		public byte[] LoadGraphic(string filePath)
		{
			FileStream stream = new FileStream(filePath, FileMode.Open, FileAccess.Read);
			BinaryReader reader = new BinaryReader(stream);
			byte[] photo = reader.ReadBytes(stream.Length);
			
			reader.Close();
			stream.Close();
			
			return photo;
		}
		
		
		public string CheckFileName(string tVal)
		{
			int i = tVal.Length;
			int j = 0;
			string CH = "";
			
			for (i = 1; i <= tVal.Length; i++)
			{
				CH = tVal.Substring(i - 1, 1);
				if (CH.Equals("/"))
				{
					StringType.MidStmtStr(ref tVal, i, 1, ".");
				}
				else if (CH.Equals(":"))
				{
					StringType.MidStmtStr(ref tVal, i, 1, ".");
				}
			}
			
			for (i = 1; i <= tVal.Length; i++)
			{
				CH = tVal.Substring(i - 1, 1);
				//j = InStr("0123456789 _~abcdefghijklmnopqrstuvwxyz.-@ :", CH, CompareMethod.Text)
				j = "0123456789 _~abcdefghijklmnopqrstuvwxyz-@ .".IndexOf(CH) + 1;
				if (j == 0)
				{
					tVal = RemoveChar(tVal, CH);
				}
			}
			
			return tVal;
			
		}
		
		public string RemoveChar(string tVal, string CharToRemove)
		{
			int i = tVal.Length;
			string[] A;
			string S = "";
			A = tVal.Split(CharToRemove.ToCharArray());
			for (i = 0; i <= (A.Length - 1); i++)
			{
				string Token = A[i].ToString();
				if (Token.Length > 0)
				{
					S = S + A[i];
				}
			}
			if (S.Length > 0)
			{
				return S;
			}
			else
			{
				return tVal;
			}
			
		}
		
		public string ReplaceCommas(string tVal)
		{
			int i = tVal.Length;
			string ch = "";
			for (i = 1; i <= tVal.Length; i++)
			{
				ch = tVal.Substring(i - 1, 1);
				if (ch == "^")
				{
					StringType.MidStmtStr(ref tVal, i, 1, ",");
				}
			}
			return tVal;
		}
		
		public string ReplaceChar(string InputString, string CharToReplace, string ReplaceWith)
		{
			int i = InputString.Length;
			string ch = "";
			for (i = 1; i <= InputString.Length; i++)
			{
				ch = InputString.Substring(i - 1, 1);
				if (ch.Equals(CharToReplace))
				{
					StringType.MidStmtStr(ref InputString, i, 1, ReplaceWith);
				}
			}
			return InputString;
		}
		
		//Public Function GetFileName(ByVal FQN ) As String
		//    Dim fn  = ""
		
		//    Dim i# = 0
		//    Dim j# = 0
		//    Dim ch  = ""
		//    For i = Len(FQN) To 1 Step -1
		//        ch = Mid(FQN, i, 1)
		//        If ch = "\" Then
		//            fn = Mid(FQN, i + 1)
		//            Exit For
		//        End If
		//        If ch = "/" Then
		//            fn = Mid(FQN, i + 1)
		//            Exit For
		//        End If
		//    Next
		//    If fn = "" And FQN.Length > 0 Then
		//        Return FQN
		//    Else
		//        Return fn
		//    End If
		
		//End Function
		
		public string GetFilePath(string FQN)
		{
			
			string fn = "";
			
			try
			{
				
				double i = 0;
				double j = 0;
				string ch = "";
				for (i = FQN.Length; i >= 1; i--)
				{
					ch = FQN.Substring(i - 1, 1);
					if (ch == "\\")
					{
						fn = FQN.Substring(0, i - 1);
						break;
					}
					if (ch == "/")
					{
						fn = FQN.Substring(0, i - 1);
						break;
					}
				}
				if (fn.Length == 0)
				{
					return FQN;
				}
				else
				{
					return fn;
				}
				
			}
			catch (Exception ex)
			{
				fn = "";
				LOG.WriteToArchiveLog((string) ("(ERROR clsDma:GetFilePath: COuld not get file path - " + ex.Message + "\r\n" + ex.StackTrace));
				return fn;
			}
			
			
		}
		
		public void tWait(double tDelay)
		{
			double start = 0;
			double finish = 0;
			double totalTime = 0;
			
			start = Microsoft.VisualBasic.DateAndTime.Timer;
			// Set end time for 1/5-second duration.
			double mSduration = System.Convert.ToDouble(tDelay / 1000);
			finish = start + mSduration;
			while (Microsoft.VisualBasic.DateAndTime.Timer < finish)
			{
				// Do other processing while waiting for 5 seconds to elapse.
			}
			totalTime = Microsoft.VisualBasic.DateAndTime.Timer - start;
			
		}
		
		public bool FileExist(string fqn)
		{
			bool returnValue;
			//*************************************************************
			//* @Copyright:  @ DMA, Limited June 2002, all rights reserved.;
			//* @Typecall:   Function;
			//* @Name:       AddEncryptedUser;
			//* @Author:     W. Dale Miller;
			//* @Purpose:    This PUBLIC FUNCTION removes empty tArray elements
			
			//* @Parms:
			//* @Parms:
			//* @Return:
			//* @RC:
			//*************************************************************
			
			//* @Flow:
			//* @Flow:
			
			try
			{
				string MyFile;
				if (fqn.Trim().Length == 0)
				{
					returnValue = false;
					return returnValue;
				}
				MyFile = fqn;
				MyFile = (string) (Dir(MyFile));
				if (MyFile.Trim().Length > 0)
				{
					returnValue = true;
				}
				else
				{
					returnValue = false;
				}
			}
			catch
			{
				// On Error GoTo 0 VBConversions Note: Statement had no effect.
				returnValue = false;
			}
			
			return returnValue;
		}
		
		public string getHelpFile()
		{
			string returnValue;
			string URL;
			URL = "WDM URL.hlp";
			//**WDM getHelpFile = App.Path & App.EXEName & ".HLP"
			returnValue = URL;
			return returnValue;
		}
		
		//** Gets and returns a registry value for the current UserID
		public string CapiInterface(string Key1, string Key2)
		{
			
			string s = "";
			RegistryKey rkCurrentUser = Registry.CurrentUser;
			RegistryKey rkTest = rkCurrentUser.OpenSubKey(Key1 + ":" + Key2);
			
			if (rkTest == null)
			{
				s = "";
			}
			else
			{
				s = (string) (rkTest.GetValue(Key1 + ":" + Key2));
				rkTest.Close();
				rkCurrentUser.Close();
			}
			
			return s;
			
		}
		
		//** Sets a registry value for the current UserID
		public string CApiSetLocalIniValue(string Key1, string Key2, string SuppliedVal)
		{
			string RegistryKey = Key1 + ":" + Key2;
			//RegistryKey = Key1 + ":" + Key2
			RegistryKey rkTest = Registry.CurrentUser.OpenSubKey("RegistryOpenSubKeyExample", true);
			if (rkTest == null)
			{
				RegistryKey rk = Registry.CurrentUser.CreateSubKey("RegistryOpenSubKeyExample");
				rk.Close();
			}
			else
			{
				rkTest.SetValue(RegistryKey, SuppliedVal);
				//        Console.WriteLine("Test value for TestName: {0}", rkTest.GetValue("TestName"))
				rkTest.Close();
			}
			return SuppliedVal;
		}
		
		// Modify a phone-number to the format "XXX-XXXX" or "(XXX) XXX-XXXX".
		public string xFormatPhoneNumber(string text)
		{
			long i;
			// ignore empty strings
			if (text.Length == 0)
			{
				return "";
			}
			// get rid of dashes and invalid chars
			for (i = text.Length; i >= 1; i--)
			{
				if ("0123456789".IndexOf(text.Substring(i - 1, 1)) + 1 == 0)
				{
					text = (string) (text.Substring(0, i - 1) + text.Substring(i + 1 - 1));
				}
			}
			// then, re-insert them in the correct position
			if (text.Length <= 7)
			{
				return Strings.Format(text, "!@@@-@@@@");
			}
			else
			{
				return Strings.Format(text, "!(@@@) @@@-@@@@");
			}
		}
		
		public void GetIPAddress()
		{
			//This sub will get all IP addresses, the first one should be the adapters MAC
			//address, the second one the IP Address when connected to the internet.
			
			System.Net.IPAddress myIPAddress;
			System.Net.IPAddress MacAddr;
			
			System.Net.IPHostEntry myIPHostEntry = new System.Net.IPHostEntry();
			myIPHostEntry = System.Net.Dns.GetHostEntry(System.Net.Dns.GetHostName());
			int i = 0;
			myIPAddress = null;
			MacAddr = null;
			foreach (System.Net.IPAddress x in myIPHostEntry.AddressList)
			{
				//i = i + 1
				//If i = 1 Then
				//    MacAddr = x.ToString()
				//End If
				//If i = 2 Then
				//    myIPAddress = x.ToString()
				//End If
				//ShowMsg(owner, x.ToString())
			}
		}
		
		public string ckVar(ref string sText)
		{
			int i = 0;
			int j = 0;
			if (sText == "&nbsp;")
			{
				sText = "";
				return sText;
			}
			
			sText = ReplaceOccr(sText, "&gt", "<");
			sText = ReplaceOccr(sText, "&Lt", ">");
			sText = ReplaceOccr(sText, "&nbsp;", " ");
			
			sText = UTIL.RemoveSingleQuotes(sText);
			
			return sText;
		}
		
		private string ReplaceOccr(string tStr, string TgtStr, string ReplacementStr)
		{
			string S1 = "";
			string S2 = "";
			int L = TgtStr.Length;
			int I = 0;
			
			while (tStr.IndexOf(TgtStr) + 1 > 0)
			{
				I = tStr.IndexOf(TgtStr) + 1;
				S1 = tStr.Substring(0, I - 1);
				S2 = tStr.Substring(I + L - 1);
				tStr = S1 + S2;
			}
			
			return tStr;
		}
		
		public int SaveFile(string sFileName, byte[] bytFileByteArr)
		{
			
			// Saves a file with no file extension
			
			// Get the file name and set a new path
			// to the local storage folder
			string strFile = System.IO.Path.GetFileNameWithoutExtension(sFileName);
			
			//Dim GL As New clsGlobals
			//strFile = System.Web.Hosting.HostingEnvironment.MapPath(GL.getServerStroragePath(strFile))
			
			//write the file out to the storage location
			try
			{
				
				FileStream stream = new FileStream(strFile, FileMode.CreateNew);
				stream.Write(bytFileByteArr, 0, bytFileByteArr.Length);
				stream.Close();
				return 0;
				
			}
			catch (Exception ex)
			{
				
				LogThis((string) ("clsDma :  : 308 : " + ex.Message));
				LogThis((string) ("clsDma :  : 313 : " + ex.Message));
				LogThis((string) ("clsDma :  : 318 : " + ex.Message));
				LogThis((string) ("clsDma :  : 959 : " + ex.Message));
				return 1;
				
			}
			
		}
		
		
		
		public string GetMimeType(string FileSuffix)
		{
			string MimeTypes = "application/andrew-inset | ez,application/mac-binhex40 | hqx,application/mac-compactpro | cpt,application/msword | doc,application/octet-stream | bin,application/octet-stream | dms,application/octet-stream | lha,application/octet-stream | lzh,application/octet-stream | exe,application/x-rar-compressed | rar,application/octet-stream | class,application/octet-stream | so,application/octet-stream | dll,application/oda | oda,application/pdf | pdf,application/postscript | ai,application/postscript | eps,application/postscript | ps,application/smil | smi,application/smil | smil,application/vnd.mif | mif,application/vnd.ms-excel | xls,application/vnd.ms-powerpoint | ppt,application/vnd.wap.wbxml | wbxml,application/vnd.wap.wmlc | wmlc,application/vnd.wap.wmlscriptc | wmlsc,application/x-bcpio | bcpio,application/x-cdlink | vcd,application/x-chess-pgn | pgn,application/x-cpio | cpio,application/x-csh | csh,application/x-director | dcr,application/x-director | dir,application/x-director | dxr,application/x-dvi | dvi,application/x-futuresplash | spl,application/x-gtar | gtar,application/x-hdf | hdf,application/x-javascript | js,application/x-koan | skp,application/x-koan | skd,application/x-koan | skt,application/x-koan | skm,application/x-latex | latex,application/x-netcdf | nc,application/x-netcdf | cdf,application/x-sh | sh,application/x-shar | shar,application/x-shockwave-flash | swf,application/x-stuffit | sit,application/x-sv4cpio | sv4cpio,application/x-sv4crc | sv4crc,application/x-tar | tar,application/x-tcl | tcl,application/x-tex | tex,application/x-texinfo | texinfo,application/x-texinfo | texi,application/x-troff | t,application/x-troff | tr,application/x-troff | roff,application/x-troff-man | man,application/x-troff-me | me,application/x-troff-ms | ms,application/x-ustar | ustar,application/x-wais-source | src,application/xhtml+xml | xhtml,application/xhtml+xml | xht,application/zip | zip,audio/basic | au,audio/basic | snd,audio/midi | mid,audio/midi | midi,audio/midi | kar,audio/mpeg | mpga,audio/mpeg | mp2,audio/mpeg | mp3,audio/x-aiff | aif,audio/x-aiff | aiff,audio/x-aiff | aifc,audio/x-mpegurl | m3u,audio/x-pn-realaudio | ram,audio/x-pn-realaudio | rm,audio/x-pn-realaudio-plugin | rpm,audio/x-realaudio | ra,audio/x-wav | wav,chemical/x-pdb | pdb,chemical/x-xyz | xyz,image/bmp | bmp,image/gif | gif,image/ief | ief,image/jpeg | jpeg,image/jpeg | jpg,image/jpeg | jpe,image/png | png,image/tiff | tiff,image/tiff | tif,image/vnd.djvu | djvu,image/vnd.djvu | djv,image/vnd.wap.wbmp | wbmp,image/x-cmu-raster | ras,image/x-portable-anymap | pnm,image/x-portable-bitmap | pbm,image/x-portable-graymap | pgm,image/x-portable-pixmap | ppm,image/x-rgb | rgb,image/x-xbitmap | xbm,image/x-xpixmap | xpm,image/x-xwindowdump | xwd,model/iges | igs,model/iges | iges,model/mesh | msh,model/mesh | mesh,model/mesh | silo,model/vrml | wrl,model/vrml | vrml,text/css | css,text/html | html,text/html | htm,text/plain | asc,text/plain | txt,text/richtext | rtx,text/rtf | rtf,text/sgml | sgml,text/sgml | sgm,text/tab-separated-values | tsv,text/vnd.wap.wml | wml,text/vnd.wap.wmlscript | wmls,text/x-setext | etx,text/xml | xsl,text/xml | xml,video/mpeg | mpeg,video/mpeg | mpg,video/mpeg | mpe,video/quicktime | qt,video/quicktime | mov,video/vnd.mpegurl | mxu,video/x-msvideo | avi,video/x-sgi-movie | movie,x-conference/x-cooltal | ice";
			string[] A = MimeTypes.Split(',');
			int I = 0;
			string Classification = "";
			string TgtMime = "";
			for (I = 0; I <= (A.Length - 1); I++)
			{
				string[] b = (A[I]).Split('|');
				Classification = b[0].Trim();
				string tMime = b[1].Trim();
				if (Strings.StrComp(FileSuffix, tMime, CompareMethod.Text) == 0)
				{
					TgtMime = tMime;
					break;
				}
			}
			return Classification;
		}
		
		private static string BinToHex(byte[] data)
		{
			if (data != null)
			{
				System.Text.StringBuilder sb = new System.Text.StringBuilder();
				for (int i = 0; i <= data.Length - 1; i++)
				{
					sb.Append(data[i].ToString("X2"));
				}
				return sb.ToString();
			}
			else
			{
				return "";
			}
		}
		
		public static byte[] HexToBin(string s)
		{
			int arraySize = s.Length / 2;
			byte[] bytes = new byte[arraySize - 1 + 1];
			int counter;
			
			for (int i = 0; i <= s.Length - 1; i += 2)
			{
				string hexValue = s.Substring(i, 2);
				
				// Tell convert to interpret the string as a 16 bit hex value
				int intValue = Convert.ToInt32(hexValue, 16);
				// Convert the integer to a byte and store it in the array
				bytes[counter] = Convert.ToByte((short) intValue);
				counter++;
			}
			
			return bytes;
		}
		
		public bool RecursiveSearch(string path, ref string[] A)
		{
			try
			{
				Application.DoEvents();
				bool dirfound = false;
				path = UTIL.ReplaceSingleQuotes(path);
				System.IO.DirectoryInfo dirInfo = new System.IO.DirectoryInfo(path);
				
				foreach (FileSystemInfo fileObject in dirInfo.GetFileSystemInfos())
				{
					
					Application.DoEvents();
					int iCode = fileObject.Attributes;
					string SS = fileObject.Attributes.ToString();
					bool isDirectory = false;
					if (SS.IndexOf(", directory") + 1)
					{
						if (dDeBug)
						{
							Debug.Print(fileObject.Attributes.ToString());
						}
						isDirectory = true;
					}
					
					if (iCode == 16)
					{
						isDirectory = true;
					}
					
					if (isDirectory == true)
					{
						
						frmMain.Default.SB.Text = fileObject.FullName;
						frmMain.Default.SB.Refresh();
						Application.DoEvents();
						
						//Dim tDir  = GetFilePath(fileObject.FullName)
						dirfound = true;
						Array.Resize(ref A, (A.Length - 1) + 1 + 1);
						A[(A.Length - 1)] = fileObject.FullName;
						frmMain.Default.SubDirectories.Add(fileObject.FullName);
						RecursiveSearch(fileObject.FullName, ref A);
					}
					
				}
				return dirfound;
			}
			catch (Exception ex)
			{
				LogThis((string) ("clsDma : RecursiveSearch : 422 : " + ex.Message));
				return false;
			}
			
		}
		
		/// <summary>
		///
		/// </summary>
		/// <param name="DirName"></param>
		/// <param name="DirFiles"></param>
		/// <param name="IncludedTypes"></param>
		/// <param name="ExcludedTypes"></param>
		/// <param name="ckArchiveFlag"></param>
		/// <returns></returns>
		/// <remarks></remarks>
		public int getFilesInDir(string DirName, List<string> DirFiles, ArrayList IncludedTypes, ArrayList ExcludedTypes, bool ckArchiveFlag)
		{
			
			//WDM - Convert the below to use a data structure class
			
			int I = System.Convert.ToInt32(DirFiles.Count);
			int iFilesAdded = 0;
			string xFileName = "";
			List<string> FilterList = new List<string>();
			bool ArchiveAttr = false;
			
			for (int II = 0; II <= IncludedTypes.Count - 1; II++)
			{
				if ((IncludedTypes[II]).ToString().IndexOf(".") + 1 == 0)
				{
					IncludedTypes[II] = "." + IncludedTypes[II];
				}
				if ((IncludedTypes[II]).ToString().IndexOf("*") + 1 == 0)
				{
					IncludedTypes[II] = "*";
				}
				if ((IncludedTypes[II]).ToString().IndexOf("*.*") + 1 > 0)
				{
					IncludedTypes[II] = "*";
				}
				if (IncludedTypes[II].Equals("*.*"))
				{
					IncludedTypes[II] = "*";
				}
				if (IncludedTypes[II].Equals(".*"))
				{
					IncludedTypes[II] = "*";
				}
				FilterList.Add(IncludedTypes[II]);
			}
			try
			{
				string FileAttributes = "";
				
				string strFileSize = "";
				int iFileSize = 0;
				System.IO.DirectoryInfo di = new System.IO.DirectoryInfo(DirName);
				
				//Dim aryFi As IO.FileInfo() = di.GetFiles("*.*")
				System.IO.FileInfo fi;
				
				List<FileInfo> Files = null;
				bool IncludeSubDir = false;
				
				if (IncludeSubDir == true)
				{
					Files = UTIL.GetFilesRecursive(DirName, FilterList);
				}
				else
				{
					Files = UTIL.GetFiles(DirName, FilterList);
				}
				int XX = 0;
				try
				{
					foreach (System.IO.FileInfo tempLoopVar_fi in Files)
					{
						fi = tempLoopVar_fi;
						XX++;
						if (fi.Attributes && 32)
						{
							ArchiveAttr = true;
							//frmReconMain.SB.Text = fi.Name
							Application.DoEvents();
							//frmReconMain.SB.Text = "Processed: -" & XX
						}
						else
						{
							ArchiveAttr = false;
							if (ckArchiveFlag == true)
							{
								//frmReconMain.SB.Text = "Processed: -" & XX
								Application.DoEvents();
								goto NextFile;
							}
							else
							{
								//frmReconMain.SB.Text = "Processed: +" & XX
								Application.DoEvents();
							}
						}
						
						string fExt = fi.Extension;
						if (fi.FullName.IndexOf(".") + 1 == 0)
						{
							LogThis("Warning: File \'" + fi.Name + "\' has no extension, skipping.");
							goto NextFile;
						}
						if (fExt.Length == 0)
						{
							fExt = getFileExtension(fi.FullName);
						}
						FixFileExtension(ref fExt);
						
						string TempExt = fExt;
						if (fExt.IndexOf(".") + 1 == 0)
						{
							TempExt = (string) ("." + fExt);
						}
						if (fExt.IndexOf("*") + 1 == 0)
						{
							TempExt = (string) ("*" + fExt);
						}
						bool bbExt = isExtIncluded(TempExt, IncludedTypes);
						
						for (int IX = 0; IX <= IncludedTypes.Count - 1; IX++)
						{
							if (IncludedTypes[IX].Equals("*.*") || IncludedTypes[IX].Equals("*"))
							{
								bbExt = true;
							}
						}
						
						if (! bbExt)
						{
							goto NextFile;
						}
						
						bbExt = isExtExcluded(fExt, ExcludedTypes);
						if (bbExt)
						{
							goto NextFile;
						}
						if (ckArchiveFlag == true)
						{
							bool bArch = this.isArchiveBitOn(fi.FullName);
							if (bArch == false)
							{
								//This file does not need to be archived
								goto NextFile;
							}
						}
						
						xFileName = fi.FullName;
						
						strFileSize = (string) ((Math.Round(fi.Length / 1024)).ToString());
						FileAttributes = "";
						FileAttributes = FileAttributes + fi.Name + "|";
						FileAttributes = FileAttributes + fi.FullName + "|";
						FileAttributes = FileAttributes + fi.Length.ToString() + "|";
						FileAttributes = FileAttributes + fi.Extension + "|";
						
						DateTime xdate = fi.LastAccessTime;
						//Dim sDate As String = UTIL.ConvertDate(xdate)
						string sDate = xdate.ToString();
						
						//Console.WriteLine(xdate.ToString)
						//Console.WriteLine(sDate)
						
						//FileAttributes  = FileAttributes  + fi.LastAccessTime.ToString + "|"
						FileAttributes = FileAttributes + xdate + "|";
						
						xdate = fi.CreationTime;
						//sDate = UTIL.ConvertDate(xdate)
						sDate = xdate.ToString();
						FileAttributes = FileAttributes + xdate + "|";
						
						xdate = fi.LastWriteTime;
						//sDate = UTIL.ConvertDate(xdate)
						sDate = xdate.ToString();
						FileAttributes = FileAttributes + xdate;
						
						DirFiles.Add(FileAttributes);
						iFilesAdded++;
NextFile:
						I++;
					}
				}
				catch (Exception ex)
				{
					LogThis((string) ("ERROR - clsDma : getFilesInDir : 22012c : " + ex.Message + "\r\n" + "DIR: " + DirName + "\r\n" + "FILE: " + fi.Name));
				}
				
			}
			catch (Exception ex)
			{
				//messagebox.show("Error 22013: " + ex.Message)
				modGlobals.NbrOfErrors++;
				//'FrmMDIMain.SB.Text = "Errors: " + NbrOfErrors.ToString
				LogThis((string) ("clsDma : getFilesInDir : 471 : " + ex.Message));
			}
			return iFilesAdded;
		}
		
		public int getFileInDir(string DirName, List<string> DirFiles)
		{
			int I = 0;
			
			try
			{
				DirFiles.Clear();
				string FileAttributes = "";
				
				string strFileSize = "";
				int iFileSize = 0;
				System.IO.DirectoryInfo di = new System.IO.DirectoryInfo(DirName);
				System.IO.FileInfo[] aryFi = di.GetFiles("*.*");
				
				
				try
				{
					foreach (System.IO.FileInfo fi in aryFi)
					{
						strFileSize = (string) ((Math.Round(fi.Length / 1024)).ToString());
						FileAttributes = "";
						FileAttributes = FileAttributes + fi.Name + "|";
						FileAttributes = FileAttributes + fi.FullName + "|";
						FileAttributes = FileAttributes + fi.Length.ToString() + "|";
						FileAttributes = FileAttributes + fi.Extension + "|";
						FileAttributes = FileAttributes + fi.LastAccessTime.ToString() + "|";
						FileAttributes = FileAttributes + fi.CreationTime.ToString() + "|";
						FileAttributes = FileAttributes + fi.LastWriteTime.ToString();
						
						DirFiles.Add(FileAttributes);
						
						I++;
					}
				}
				catch (Exception ex)
				{
					MessageBox.Show((string) ("Error 22012a: " + ex.Message));
					LogThis((string) ("clsDma : getFileInDir : 480 : " + ex.Message));
					LogThis((string) ("clsDma : getFileInDir : 491 : " + ex.Message));
					LogThis((string) ("clsDma : getFileInDir : 502 : " + ex.Message));
				}
				
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 22013: " + ex.Message));
				LogThis((string) ("clsDma : getFileInDir : 481 : " + ex.Message));
				LogThis((string) ("clsDma : getFileInDir : 493 : " + ex.Message));
				LogThis((string) ("clsDma : getFileInDir : 505 : " + ex.Message));
			}
			return I;
		}
		
		public int getFilesInDir(string DirName, List<string> DirFiles, string ExactFileName)
		{
			
			DirName = UTIL.RemoveSingleQuotes(DirName);
			ExactFileName = UTIL.RemoveSingleQuotes(ExactFileName);
			
			int I = 0;
			string FQN = DirName + "\\" + ExactFileName;
			try
			{
				DirFiles.Clear();
				string FileAttributes = "";
				
				string strFileSize = "";
				int iFileSize = 0;
				System.IO.DirectoryInfo di = new System.IO.DirectoryInfo(DirName);
				System.IO.FileInfo fInfo = new System.IO.FileInfo(DirName + "\\" + ExactFileName);
				//Dim aryFi As IO.FileInfo() = di.GetFiles(ExactFileName )
				//Dim fi As IO.FileInfo
				
				try
				{
					//For Each fi In aryFi
					strFileSize = (string) ((Math.Round(fInfo.Length / 1024)).ToString());
					FileAttributes = "";
					FileAttributes = FileAttributes + fInfo.Name + "|";
					FileAttributes = FileAttributes + fInfo.FullName + "|";
					FileAttributes = FileAttributes + fInfo.Length.ToString() + "|";
					FileAttributes = FileAttributes + fInfo.Extension + "|";
					
					//Dim ZDate As DateTime = DateTime.Parse(fInfo.LastAccessTime.ToString)
					//Date.ToString("ddMMyy")
					//Date.ToString("hhmm")
					
					DateTime xDate = fInfo.LastAccessTime;
					xDate.ToString("MM/dd/yyyy");
					
					FileAttributes = FileAttributes + xDate.ToString() + "|";
					
					
					xDate = fInfo.CreationTime;
					xDate.ToString("MM/dd/yyyy");
					FileAttributes = FileAttributes + fInfo.CreationTime.ToString() + "|";
					FileAttributes = FileAttributes + fInfo.LastWriteTime.ToString();
					
					if (I == 0)
					{
						DirFiles.Add(FileAttributes);
					}
					else
					{
						DirFiles.Add(FileAttributes);
					}
					I++;
					//Next
				}
				catch (Exception ex)
				{
					MessageBox.Show((string) ("Error 22012b: " + ex.Message));
					LogThis((string) ("clsDma : getFilesInDir : 508 : " + ex.Message));
					LogThis((string) ("clsDma : getFilesInDir : 521 : " + ex.Message));
					LogThis((string) ("clsDma : getFilesInDir : 534 : " + ex.Message));
				}
				
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("Error 22013: " + ex.Message));
				LogThis((string) ("clsDma : getFilesInDir : 509 : " + ex.Message));
				LogThis((string) ("clsDma : getFilesInDir : 523 : " + ex.Message));
				LogThis((string) ("clsDma : getFilesInDir : 537 : " + ex.Message));
			}
			return I;
		}
		
		public void ReplaceStar(ref string tVal)
		{
			string CH = "";
			if (tVal.IndexOf("*") + 1 == 0)
			{
				return;
			}
			if (tVal.Length > 0)
			{
				if (tVal.Length > 1)
				{
					CH = tVal.Substring(0, 1);
					if (CH.Equals("*"))
					{
						StringType.MidStmtStr(ref tVal, 1, 1, "%");
					}
					CH = tVal.Substring(tVal.Length - 1, 1);
					if (CH.Equals("*"))
					{
						StringType.MidStmtStr(ref tVal, tVal.Length, 1, "%");
					}
				}
			}
		}
		public void ReplaceSingleTick(ref string tVal)
		{
			tVal = tVal.Trim();
			string CH = "";
			if (tVal.IndexOf("\'") + 1 == 0)
			{
				return;
			}
			for (int i = 1; i <= tVal.Length; i++)
			{
				CH = tVal.Substring(i - 1, 1);
				if (CH.Equals("\'"))
				{
					StringType.MidStmtStr(ref tVal, i, 1, "`");
				}
			}
		}
		public void GetStartAndStopDate(ref DateTime StartDate, ref DateTime EndDate)
		{
			//'5/14/2009 12:00:00 AM'
			string S1 = StartDate.ToString();
			string S2 = EndDate.ToString();
			int I = 0;
			I = S1.IndexOf("12:00:00") + 1;
			
			
			StringType.MidStmtStr(ref S1, I, 1, "1");
			I++;
			StringType.MidStmtStr(ref S1, I, 1, "2");
			I++;
			StringType.MidStmtStr(ref S1, I, 1, ":");
			I++;
			StringType.MidStmtStr(ref S1, I, 1, "0");
			I++;
			StringType.MidStmtStr(ref S1, I, 1, "0");
			I++;
			StringType.MidStmtStr(ref S1, I, 1, ":");
			I++;
			StringType.MidStmtStr(ref S1, I, 1, "0");
			I++;
			StringType.MidStmtStr(ref S1, I, 1, "0");
			
			I = S2.IndexOf("12:00:00") + 1;
			StringType.MidStmtStr(ref S2, I, 1, "1");
			StringType.MidStmtStr(ref S2, I, 1, "1");
			I++;
			StringType.MidStmtStr(ref S2, I, 1, "1");
			I++;
			StringType.MidStmtStr(ref S2, I, 1, ":");
			I++;
			StringType.MidStmtStr(ref S2, I, 1, "5");
			I++;
			StringType.MidStmtStr(ref S2, I, 1, "9");
			I++;
			StringType.MidStmtStr(ref S2, I, 1, ":");
			I++;
			StringType.MidStmtStr(ref S2, I, 1, "5");
			I++;
			StringType.MidStmtStr(ref S2, I, 1, "9");
			I++;
			StringType.MidStmtStr(ref S2, I, 1, " ");
			I++;
			StringType.MidStmtStr(ref S2, I, 1, "P");
			
			StartDate = DateTime.Parse(S1);
			EndDate = DateTime.Parse(S2);
			
			
		}
		public string ckQryDate(string StartDate, string EndDate, string Evaluator, string DbColName, ref bool FirstTime)
		{
			
			//** Set to false by WDM on 3/10/2010 to allow for parens and the AND operator
			FirstTime = false;
			
			string S = "";
			string CH = "";
			string WhereClause = "";
			if (Evaluator.ToUpper().Equals("OFF"))
			{
				return WhereClause;
			}
			else
			{
				if (Evaluator.Equals("OFF"))
				{
					return WhereClause;
				}
				else if (Evaluator.Equals("After"))
				{
					if (FirstTime)
					{
						WhereClause = " " + DbColName + " > \'" + (DateTime.Parse(StartDate)).ToString() + "\'" + "\r\n";
						FirstTime = false;
					}
					else
					{
						WhereClause = " AND (" + DbColName + " > \'" + (DateTime.Parse(StartDate)).ToString() + "\')" + "\r\n";
					}
				}
				else if (Evaluator.Equals("Before"))
				{
					if (FirstTime)
					{
						WhereClause = " " + DbColName + " < \'" + (DateTime.Parse(StartDate)).ToString() + "\'" + "\r\n";
						FirstTime = false;
					}
					else
					{
						WhereClause = " AND (" + DbColName + " < \'" + (DateTime.Parse(StartDate)).ToString() + "\')" + "\r\n";
					}
				}
				else if (Evaluator.Equals("Between"))
				{
					GetStartAndStopDate(ref StartDate, ref EndDate);
					//select * from Production.Product where Sellcdate(StartDate).tostring between â€˜2001-06-29â€² and â€˜2001-07-02â€²
					if (FirstTime)
					{
						FirstTime = false;
						WhereClause = " " + DbColName + " between \'" + (DateTime.Parse(StartDate)).ToString() + "\' and \'" + (DateTime.Parse(EndDate)).ToString() + "\' " + "\r\n";
					}
					else
					{
						WhereClause = " AND (" + DbColName + " between \'" + (DateTime.Parse(StartDate)).ToString() + "\' and \'" + (DateTime.Parse(EndDate)).ToString() + "\')" + "\r\n";
					}
				}
				else if (Evaluator.Equals("Not Between"))
				{
					GetStartAndStopDate(ref StartDate, ref EndDate);
					//select * from Production.Product where SellStartDate between â€˜2001-06-29â€² and â€˜2001-07-02â€²
					if (FirstTime)
					{
						FirstTime = false;
						WhereClause = " " + DbColName + " NOT between \'" + (DateTime.Parse(StartDate)).ToString() + "\' and \'" + (DateTime.Parse(EndDate)).ToString() + "\'" + "\r\n";
					}
					else
					{
						WhereClause = " AND (" + DbColName + " NOT between \'" + (DateTime.Parse(StartDate)).ToString() + "\' and \'" + (DateTime.Parse(EndDate)).ToString() + "\')" + "\r\n";
					}
				}
				else if (Evaluator.Equals("On"))
				{
					GetStartAndStopDate(ref StartDate, ref EndDate);
					if (FirstTime)
					{
						FirstTime = false;
						WhereClause = " " + DbColName + " between \'" + (DateTime.Parse(StartDate)).ToString() + "\' and \'" + (DateTime.Parse(EndDate)).ToString() + "\'" + "\r\n";
					}
					else
					{
						WhereClause = " AND (" + DbColName + " between \'" + (DateTime.Parse(StartDate)).ToString() + "\' and \'" + (DateTime.Parse(EndDate)).ToString() + "\')" + "\r\n";
					}
				}
				else
				{
					return WhereClause;
				}
				
			}
			return WhereClause;
		}
		
		public void AddSlashToDirName(ref string tDir)
		{
			
			if (tDir.Trim.Length == 0)
			{
				return;
			}
			
			int I = 0;
			tDir = tDir.Trim();
			I = tDir.Length;
			string CH = tDir.Substring(I - 1, 1);
			if (CH == "\\")
			{
				return;
			}
			else
			{
				tDir = tDir + "\\";
			}
			
		}
		
		public void ListRegistryKeys(string FileExt, List<string> LB)
		{
			try
			{
				RegistryKey rootKey;
				rootKey = Registry.ClassesRoot;
				string S;
				
				RegistryKey regSubKey;
				
				
				
				RegistryKey tmp;
				rootKey = rootKey.OpenSubKey(FileExt, false);
				Debug.Print((string) (rootKey.GetValue("").ToString()));
				Debug.Print((string) (rootKey.GetValue("Content Type").ToString()));
				
				string ControlApp = (string) (rootKey.GetValue("Content Type").ToString());
				
				LB.Add("Content Type: " + rootKey.GetValue("Content Type").ToString());
				
				foreach (string subk in rootKey.GetSubKeyNames())
				{
					//MessageBox.Show(subk)
					S = subk + " : ";
					tmp = rootKey.OpenSubKey(subk);
					S = tmp.ToString();
					LB.Add(S);
				}
			}
			catch (Exception ex)
			{
				Debug.Print(ex.Message);
				LogThis((string) ("clsDma : ListRegistryKeys : 595 : " + ex.Message));
				LogThis((string) ("clsDma : ListRegistryKeys : 610 : " + ex.Message));
				LogThis((string) ("clsDma : ListRegistryKeys : 625 : " + ex.Message));
			}
			
		}
		
		public string GetCurrUserName()
		{
			string S = "";
			S = Environment.UserName.ToString();
			return S;
		}
		
		public string GetCurrOsVersionName()
		{
			string S = "";
			S = Environment.OSVersion.ToString();
			return S;
		}
		
		public string GetCurrEnvironmentVersionName()
		{
			string S = "";
			S = Environment.Version.ToString();
			return S;
		}
		
		public string GetCurrSystemDirectory()
		{
			string S = "";
			S = Environment.SystemDirectory.ToString();
			return S;
		}
		
		public string GetCurrUptime()
		{
			string S = "";
			S = (string) (Strings.Mid(System.Convert.ToString(Environment.TickCount / 3600000), 1, 5) + " :Hours");
			S = Environment.SystemDirectory.ToString();
			return S;
		}
		
		public string GetCurrMachineName()
		{
			string S = "";
			S = Environment.MachineName.ToString();
			return S;
		}
		
		public string GetCurrentDirectory()
		{
			string S = "";
			S = Environment.CurrentDirectory.ToString();
			return S;
		}
		
		public string GetUserDomainName()
		{
			string S = "";
			S = Environment.UserDomainName.ToString();
			return S;
		}
		
		public string GetWorkingSet()
		{
			string S = "";
			S = Environment.WorkingSet.ToString();
			return S;
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
				//MessageBox.Show(fileDetail.Name & " is Archived")
				return false;
			}
			else
			{
				//MessageBox.Show(fileDetail.Name & " is NOT Archived")
				return true;
			}
			
		}
		
		public bool setFileArchiveAttributeSet(string FQN, bool SetOn)
		{
			
			System.IO.FileInfo fileDetail = (new Microsoft.VisualBasic.Devices.ServerComputer()).FileSystem.GetFileInfo(FQN);
			
			if (SetOn == true)
			{
				fileDetail.Attributes = fileDetail.Attributes && fileDetail.Attributes.Archive;
			}
			else
			{
				fileDetail.Attributes = fileDetail.Attributes && ! fileDetail.Attributes.Archive;
			}
			
		}
		
		public bool setFileArchiveBitOn(string FQN)
		{
			System.IO.FileInfo fileDetail = (new Microsoft.VisualBasic.Devices.ServerComputer()).FileSystem.GetFileInfo(FQN);
			fileDetail.Attributes = fileDetail.Attributes + fileDetail.Attributes.Archive;
		}
		
		public bool setFileArchiveBitOff(string FQN)
		{
			System.IO.FileInfo fileDetail = (new Microsoft.VisualBasic.Devices.ServerComputer()).FileSystem.GetFileInfo(FQN);
			fileDetail.Attributes = fileDetail.Attributes - fileDetail.Attributes.Archive;
		}
		//WDM This could be a problem
		public bool ToggleArchiveBit(string filespec)
		{
			
			filespec = UTIL.ReplaceSingleQuotes(filespec);
			
			try
			{
				object fso;
				object f;
				fso = Interaction.CreateObject("Scripting.FileSystemObject", "");
				f = fso.GetFile(filespec);
				
				if (f.attributes && 32)
				{
					f.attributes = f.attributes - 32;
					//ToggleArchiveBit = "Archive bit is cleared."
					return true;
				}
				else
				{
					f.attributes = f.attributes + 32;
					//ToggleArchiveBit = "Archive bit is set."
					return false;
				}
			}
			catch (Exception ex)
			{
				LogThis((string) ("clsDma : ToggleArchiveBit : 648 : " + ex.Message));
				return false;
			}
		}
		
		public bool isArchiveBitOn(string filespec)
		{
			
			//Dim skipThis As Boolean = True
			//If skipThis = True Then
			//Return False
			//End If
			
			bool B = false;
			
			try
			{
				
				FileAttribute MyAttr;
				// Assume file TESTFILE is normal and readonly.
				MyAttr = GetAttr(filespec); // Returns vbNormal.
				//Dim iAttr As Integer = GetAttr(filespec)
				
				// Test for Archived.
				if ((MyAttr && FileAttribute.Archive) == FileAttribute.Archive)
				{
					//If (MyAttr And FileAttribute.Archive) = 1 Then
					//The "A" is showing.
					return true;
				}
				else
				{
					return false;
				}
				
				//Feb 7, 2010 - Set the above code in place and removed the following - WDM
				//Dim fso, f
				//fso = CreateObject("Scripting.FileSystemObject")
				//f = fso.GetFile(filespec)
				
				//If f.attributes And 32 Then
				//    'f.attributes = f.attributes - 32
				//    'ToggleArchiveBit = "Archive bit is cleared."
				//    B = True
				//Else
				//    'f.attributes = f.attributes + 32
				//    'ToggleArchiveBit = "Archive bit is set."
				//    B = False
				//End If
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("Warning: clsDMa:isArchiveBitOn 100 - " + ex.Message));
				B = false;
			}
			
			return B;
		}
		
		public bool setArchiveBitOff(string filespec)
		{
			
			bool B = false;
			filespec = UTIL.ReplaceSingleQuotes(filespec);
			
			try
			{
				//'Dim MyAttr As FileAttribute
				/// Assume file TESTFILE is normal and readonly.
				//'MyAttr = GetAttr(filespec )   ' Returns vbNormal.
				//If F.Exists(filespec) Then
				//    F.SetAttributes(filespec, FileAttributes.Archive)
				//    'SetAttr(filespec , FileAttribute.Archive)
				//End If
				
				FileInfo f = new FileInfo(filespec);
				f.Attributes = f.Attributes && ! FileAttributes.Archive;
				f = null;
				
				//SetAttr(filespec , FileAttribute.Archive)
				//B = True
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("Warning: clsDMa:setArchiveBitOn 100 - " + ex.Message));
				B = false;
			}
			
			return B;
		}
#if GetAllWidgets
		public void getFormWidgets(Form F)
		{
			
			clsHELPTEXT HELP = new clsHELPTEXT();
			
			string FormName = F.Name;
			Control loControl;
			
			string lsTmp = "";
			string S = "";
			ArrayList A = new ArrayList();
			string SS = "";
			string ctlText = "";
			string ControlType = "";
			foreach (Control tempLoopVar_loControl in F.Controls)
			{
				loControl = tempLoopVar_loControl;
				SS = FormName + "," + loControl.Name + "," + loControl.Text + "," + "<help text here>";
				ctlText = loControl.Text;
				Debug.Print(loControl.Name);
				lsTmp += loControl.Name + Constants.vbNewLine;
				ControlType = loControl.GetType().ToString();
				int iCnt = loControl.Controls.Count - 1;
				bool B = true;
				if (ControlType.Equals("System.Windows.Forms.GroupBox"))
				{
					SS = FormName;
					Debug.Print((string) ("GBox: " + loControl.Name));
					for (int x = 0; x <= loControl.Controls.Count - 1; x++)
					{
						B = false;
						string Ctrl2 = loControl.Controls[x].Name;
						S += "TT.SetToolTip(" + Ctrl2 + ", " + '\u0022' + "<" + loControl.Controls[x].Text + ">" + '\u0022' + ")" + " \'*GB" + "\r\n";
						
						SS = FormName + "," + Ctrl2 + "," + loControl.Controls[x].Text + "," + "<help text here>";
						A.Add(SS);
						//For Each ctrl As Control In loControl.Controls
						//    Debug.Print("Inside GBox: " + ctrl.Name)
						//Next
					}
				}
				if (B == true)
				{
					A.Add(SS);
				}
				S += "TT.SetToolTip(" + loControl.Name + ", " + '\u0022' + "<" + ctlText + ">" + '\u0022' + ")" + "\r\n";
			}
			S = S + " " + "\r\n";
			S = S + " " + "\r\n";
			for (int i = 0; i <= A.Count - 1; i++)
			{
				string ScreenName = "";
				string WidgetName = "";
				string WidgetText = "";
				S = S + A[i] + "\r\n";
				string[] tArray = Strings.Split(A[i], ",", -1, 0);
				
				if (tArray[0].Trim().Length == 0)
				{
					goto NEXTONE;
				}
				if (tArray[0].Trim().Length == 0)
				{
					goto NEXTONE;
				}
				
				tArray[0] = this.UTIL.RemoveSingleQuotes(tArray[0]);
				tArray[1] = this.UTIL.RemoveSingleQuotes(tArray[1]);
				tArray[2] = this.UTIL.RemoveSingleQuotes(tArray[2]);
				tArray[3] = this.UTIL.RemoveSingleQuotes(tArray[3]);
				
				ScreenName = tArray[0];
				WidgetName = tArray[1];
				WidgetText = tArray[2];
				
				int iCnt = HELP.cnt_PK_HelpText(ScreenName, WidgetName);
				if (iCnt == 0)
				{
					//ScreenName = tArray(0)
					//WidgetName  = tArray(1)
					if (WidgetName.Length == 0)
					{
						goto NEXTONE;
					}
					HELP.setScreenname(ref tArray[0]);
					HELP.setWidgetname(ref tArray[1]);
					HELP.setWidgettext(ref tArray[2]);
					HELP.setHelptext(ref tArray[3]);
					bool BB = HELP.Insert();
					if (BB == false)
					{
						Debug.Print("Failed to enter help...");
					}
				}
				else
				{
					//ScreenName = tArray(0)
					//WidgetName  = tArray(1)
					if (WidgetName.Length == 0)
					{
						goto NEXTONE;
					}
					HELP.setScreenname(ref tArray[0]);
					HELP.setWidgetname(ref tArray[1]);
					HELP.setWidgettext(ref tArray[2]);
					HELP.setHelptext(ref tArray[3]);
					string WC = HELP.wc_PK_HelpText(ScreenName, WidgetName);
					bool Bb = UpdateDoNotChangeHelpText(WC, ScreenName, WidgetName, WidgetText);
					if (Bb == false)
					{
						Debug.Print("Failed to UPDATE help...");
					}
				}
NEXTONE:
				1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
			}
			//If dDeBug Then Clipboard.SetText(S)
		}
#endif
		/// <summary>
		/// OK - to anyone that reads this later...
		/// This is kind of a thought that should not be tried,
		/// but what the heck. MAybe we can pass a control in
		/// by REF and let the object modify itself. I figure if
		/// an ameba can do it, maybe a reflective object can too!
		/// Speaking of stupid, remember to wrap this in a TRY/CATCH.
		/// </summary>
		/// <param name="TT">.NET ToolTip</param>
		/// <param name="ctrl">Any form control</param>
		/// <param name="TipText">The Tooltip object must exist on the form or this will blow up.</param>
		/// <remarks></remarks>
		public void addToolTip(ToolTip TT, Control ctrl, string TipText)
		{
			//** Holy shit, this may work!
			try
			{
				TT.SetToolTip(ctrl, TipText);
			}
			catch (Exception ex)
			{
				MessageBox.Show((string) ("You blew this idiot," + "\r\n" + ex.Message));
				LogThis((string) ("clsDma : addToolTip : 749 : " + ex.Message));
				LogThis((string) ("clsDma : addToolTip : 770 : " + ex.Message));
				LogThis((string) ("clsDma : addToolTip : 784 : " + ex.Message));
			}
			
		}
		
		//Public Sub smoLoadServers(ByRef CB As Windows.Forms.ComboBox)
		
		//    Dim dt As DataTable = SmoApplication.EnumAvailableSqlServers(False)
		//    Dim ServersFound As Boolean = False
		
		//    If dt.Rows.Count > 0 Then
		//        For Each dr As DataRow In dt.Rows
		//            ServersFound = True
		//            If dDeBug Then Console.WriteLine(dr("Name"))
		//            CB.Items.Add(dr("Name"))
		//        Next
		//    End If
		//    If Not ServersFound Then
		//        CB.Items.Add("NO SQL SERVERS FOUND")
		//    End If
		//End Sub
		
		//Public Sub LoadServersCombo(ByRef CB As Windows.Forms.ComboBox)
		//    Dim oSQLApp As SQLDMO.Application
		//    Dim oNames As SQLDMO.NameList
		//    Dim i As Integer
		//    oSQLApp = New SQLDMO.Application    'POPULATE CBO ONLY WITH SQL SERVERS
		//    oNames = oSQLApp.ListAvailableSQLServers
		//    CB.Items.Clear()
		//    For i = 1 To oNames.Count
		//        CB.Items.Add(oNames.Item(i))
		//    Next i
		//    If oNames.Count = 0 Then
		//        CB.Items.Add("NO SQL SERVERS FOUND")
		//    End If
		//End Sub
		
		
		
		//Public Sub LoadDatabases(ByVal ServerName , ByVal UserID , ByVal PW , ByRef CB As Windows.Forms.ComboBox)
		//    Dim oSQLServer As New SQLDMO.SQLServer
		//    Dim i As Integer
		//    CB.Items.Clear()
		//    Try
		//        If UserID = "" And PW = "" Then
		//            oSQLServer.LoginSecure = True
		//        End If
		//        oSQLServer.Connect(ServerName, UserID, PW)
		//        For i = 1 To oSQLServer.Databases.Count
		//            Dim dbName  = oSQLServer.Databases.Item(i).Name.ToString
		//            CB.Items.Add(dbName)
		//        Next i
		//    Catch ex As Exception
		//        CB.Items.Clear()
		//        CB.Items.Add(ex.Message.Trim)
		//    End Try
		//End Sub
		
		public string formatTextSearch(string SearchString)
		{
			if (SearchString.Trim.Length == 0)
			{
				return "";
			}
			int I = 0;
			int J = 0;
			string CH = "";
			string currWord = "";
			string prevWord = "";
			bool prevWordIsKeyWord = false;
			bool currWordIsKeyWord = false;
			ArrayList tStack = new ArrayList();
			ArrayList aList = new ArrayList();
			for (I = 1; I <= SearchString.Length; I++)
			{
				CH = SearchString.Substring(I - 1, 1);
				if (CH == '\u0022')
				{
					I++;
					CH = SearchString.Substring(I - 1, 1);
					while (CH != '\u0022' && I < SearchString.Length)
					{
						I++;
						CH = SearchString.Substring(I - 1, 1);
					}
				}
				else if (CH == " ")
				{
					StringType.MidStmtStr(ref SearchString, I, 1, Strings.Chr(254));
				}
			}
			
			ArrayList NewText = new ArrayList();
			string[] A = SearchString.Split(Strings.Chr(254));
			for (I = 0; I <= (A.Length - 1); I++)
			{
				currWord = A[I];
				currWordIsKeyWord = ckKeyWord(currWord);
				prevWordIsKeyWord = ckKeyWord(prevWord);
				if (dDeBug)
				{
					Console.WriteLine(SearchString);
				}
				if (dDeBug)
				{
					Console.WriteLine(currWord, currWordIsKeyWord);
				}
				if (dDeBug)
				{
					Console.WriteLine(currWord, prevWordIsKeyWord);
				}
				if (currWordIsKeyWord == false && prevWordIsKeyWord == false)
				{
					if (prevWord.Trim().Length > 0 && currWord.Trim().Length > 0)
					{
						string CH1 = currWord.Substring(0, 1);
						if (CH1.Equals('\u0022'))
						{
							NewText.Add("OR");
							NewText.Add(currWord);
						}
						else if ("+-^|".IndexOf(CH1) + 1 == 0)
						{
							NewText.Add("OR");
							NewText.Add(currWord);
						}
						else
						{
							NewText.Add(currWord);
						}
					}
					else if (currWord.Trim().Length > 0)
					{
						NewText.Add(currWord);
					}
				}
				else
				{
					NewText.Add(currWord);
				}
				prevWord = currWord;
			}
			string ReformattedSearch = "";
			for (I = 0; I <= NewText.Count - 1; I++)
			{
				bool isContainsDoubleQuote = false;
				bool isContainsStar = false;
				string tWord = NewText[I].ToString();
				if (tWord.IndexOf("*") + 1 > 0)
				{
					isContainsStar = true;
				}
				if (tWord.IndexOf(('\u0022').ToString()) + 1 > 0)
				{
					isContainsDoubleQuote = true;
				}
				if (isContainsDoubleQuote == false && isContainsStar == true)
				{
					//** Wrap this word in double quotes
					tWord = tWord.Trim();
					tWord = (string) ('\u0022' + tWord + '\u0022');
				}
				ReformattedSearch += tWord + " ";
			}
			return ReformattedSearch;
		}
		
		public bool ckKeyWord(string KW)
		{
			bool B = false;
			KW = KW.ToUpper();
			switch (KW)
			{
				case "NEAR":
					return true;
				case "AND":
					return true;
				case "OR":
					return true;
				case "NOT":
					return true;
				case "FORMSOF":
					return true;
				case "FROM":
					return true;
				case "ISABOUT":
					return true;
				case "INFLECTIONAL":
					return true;
				case "CONTAINS":
					return true;
				case "ORDER":
					return true;
				case "BY":
					return true;
				case "CONTAINSTABLE":
					return true;
				case "FREETEXT":
					return true;
				case "WHERE":
					return true;
				case "WITH":
					return true;
				case "AS":
					return true;
				case "AS":
					return true;
				case "INNER":
					return true;
				case "JOIN":
					return true;
				case "LEFT":
					return true;
				case "RIGHT":
					return true;
				case "OUTER":
					return true;
			}
			return B;
		}
		
		public void ckFirstTokenKeyWord(ref string tStr)
		{
			try
			{
				string S = tStr;
				string[] A = S.Split(' ');
				if ((A.Length - 1) > 0)
				{
					bool B = ckKeyWord(A[0]);
					if (B)
					{
						S = "";
						for (int i = 1; i <= (A.Length - 1); i++)
						{
							S += (string) (A[i] + " ");
						}
					}
				}
				
				tStr = S;
			}
			catch (Exception ex)
			{
				tStr = "";
				LogThis((string) ("clsDma : ckFirstTokenKeyWord : 910 : " + ex.Message));
				LogThis((string) ("clsDma : ckFirstTokenKeyWord : 934 : " + ex.Message));
				LogThis((string) ("clsDma : ckFirstTokenKeyWord : 951 : " + ex.Message));
			}
			
		}
		
		public bool getDebug(string FormID)
		{
			bool bUseConfig = true;
			string S = "";
			bool B = false;
			
			try
			{
				FormID = (string) ("debug_" + FormID);
				S = System.Configuration.ConfigurationManager.AppSettings[FormID];
				if (S.Equals("0"))
				{
					B = false;
				}
				else if (S.Equals("1"))
				{
					B = true;
				}
				else if (S.Equals("-1"))
				{
					B = true;
				}
				else if (S.ToUpper().Equals("TRUE"))
				{
					B = true;
				}
				else if (S.ToUpper().Equals("FALSE"))
				{
					B = false;
				}
			}
			catch (Exception ex)
			{
				B = false;
				LogThis((string) ("clsDma : getDebug : 928 : " + ex.Message));
				LogThis((string) ("clsDma : getDebug : 953 : " + ex.Message));
				LogThis((string) ("clsDma : getDebug : 971 : " + ex.Message));
			}
			
			return B;
			
		}
		
		public string getEnvironmentDir(string DirName)
		{
			//        0	Desktop			C:\Documents and Settings\Charlie\Desktop
			//2	Programs		C:\Documents and Settings\Charlie\Start Menu\Programs
			//5	Personal		D:\documents
			//6	Favorites		C:\Documents and Settings\Charlie\Favorites
			//8	Recent			C:\Documents and Settings\Charlie\Recent
			//9	SendTo			C:\Documents and Settings\Charlie\SendTo
			//11	StartMenu		C:\Documents and Settings\Charlie\Start Menu
			//13	MyMusic			D:\documents\My Music
			//16	DesktopDirectory	C:\Documents and Settings\Charlie\Desktop
			//17:     MyComputer()
			//26	ApplicationData		C:\Documents and Settings\Charlie\Application Data
			//28	LocalApplicationData	C:\Documents and Settings\Charlie\Local Settings\Application Data
			//32	InternetCache		C:\Documents and Settings\Charlie\Local Settings\Temporary Internet Files
			//33	Cookies			C:\Documents and Settings\Charlie\Cookies
			//34	History			C:\Documents and Settings\Charlie\Local Settings\History
			//35	CommonApplicationData	C:\Documents and Settings\All Users\Application Data
			//37	System			C:\WINDOWS\System32
			//38	ProgramFiles		C:\Program Files
			//39	MyPictures		D:\documents\My Pictures
			//43	CommonProgramFiles	C:\Program FilesCommon Files
			
			string S = "";
			
			//Environment.SpecialFolder.ApplicationData()
			//Environment.SpecialFolder.System()
			//Environment.SpecialFolder.CommonApplicationData()
			//Environment.SpecialFolder.CommonProgramFiles()
			//Environment.SpecialFolder.Cookies()
			//Environment.SpecialFolder.Desktop()
			//Environment.SpecialFolder.DesktopDirectory()
			//Environment.SpecialFolder.Favorites()
			//Environment.SpecialFolder.History()
			//Environment.SpecialFolder.InternetCache()
			//Environment.SpecialFolder.LocalApplicationData()
			//Environment.SpecialFolder.MyComputer()
			//Environment.SpecialFolder.MyMusic()
			//Environment.SpecialFolder.MyPictures()
			//Environment.SpecialFolder.Personal()
			//Environment.SpecialFolder.ProgramFiles()
			//Environment.SpecialFolder.Programs()
			//Environment.SpecialFolder.Recent()
			//Environment.SpecialFolder.SendTo()
			//Environment.SpecialFolder.StartMenu()
			
			return S;
			
		}
		
		public string App_Path()
		{
			return System.AppDomain.CurrentDomain.BaseDirectory;
		}
		
		public string setHelpDir(string HelpFile)
		{
			string tDir = App_Path();
			tDir = tDir + "HelpFiles\\" + HelpFile;
			return tDir;
		}
		
		public bool isConnected()
		{
			bool bDebugConnection = false;
			bool B = false;
			// Returns True if connection is available
			// Replace www.yoursite.com with a site that
			// is guaranteed to be online - perhaps your
			// corporate site, or microsoft.com
			
			if (bDebugConnection)
			{
				LogThis("clsDma: ECM Library Connection step 1.");
			}
			System.Uri objUrl = new System.Uri("http://www.ecmlibrary.com/");
			// Setup WebRequest
			
			if (bDebugConnection)
			{
				LogThis("clsDma: ECM Library Connection step 2.");
			}
			System.Net.WebRequest objWebReq;
			
			if (bDebugConnection)
			{
				LogThis("clsDma: ECM Library Connection step 3.");
			}
			objWebReq = System.Net.WebRequest.Create(objUrl);
			
			if (bDebugConnection)
			{
				LogThis("clsDma: ECM Library Connection step 4.");
			}
			System.Net.WebResponse objResp;
			
			if (bDebugConnection)
			{
				LogThis("clsDma: ECM Library Connection step 5.");
			}
			try
			{
				// Attempt to get response and return True
				if (bDebugConnection)
				{
					LogThis("clsDma: ECM Library Connection step 6.");
				}
				objResp = objWebReq.GetResponse();
				
				if (bDebugConnection)
				{
					LogThis("clsDma: ECM Library Connection step 7.");
				}
				objResp.Close();
				
				if (bDebugConnection)
				{
					LogThis("clsDma: ECM Library Connection step 8.");
				}
				objWebReq = null;
				
				if (bDebugConnection)
				{
					LogThis("clsDma: ECM Library Connection step 9.");
				}
				B = true;
			}
			catch (Exception ex)
			{
				// Error, exit and return False
				//objResp.Close()
				//objWebReq = Nothing
				B = false;
				if (bDebugConnection)
				{
					LogThis("clsDma: ECM Library Connection step 10.");
				}
				LogThis((string) ("FAILED TO CONNECT clsDma : isConnected : 987 : " + ex.Message));
			}
			if (bDebugConnection)
			{
				LogThis("clsDma: ECM Library Connection step 11.");
			}
			return B;
		}
		
		//Public Sub SetSearchFields(ByVal txtSearch , ByVal txtThesaurus )
		//    Try
		//        frmQuickSearch.txtThesaurus.Text = txtThesaurus
		//        frmQuickSearch.txtSearch.Text = txtSearch
		//    Catch ex As Exception
		//        Console.WriteLine(ex.Message)
		//    End Try
		//    Try
		//        frmDocSearch.txtThesaurus.Text = txtThesaurus
		//        frmDocSearch.txtSearch.Text = txtSearch
		//    Catch ex As Exception
		//        Console.WriteLine(ex.Message)
		//    End Try
		//    Try
		//        frmEmailSearch.txtThesaurus.Text = txtThesaurus
		//        frmEmailSearch.txtSearch.Text = txtSearch
		//    Catch ex As Exception
		//        Console.WriteLine(ex.Message)
		//    End Try
		//End Sub
		
		
		// Only the first X bytes of the file are read into a byte array.
		// BUFFERSIZE is X.  A larger number will use more memory and
		// be slower.  A smaller number may not be able to decode all
		// JPEG files.  Feel free to play with this number.
		//
		// CImageInfo
		//
		// Author: David Crowell
		// davidc@qtm.net
		// http://www.qtm.net/~davidc
		//
		// Released to the public domain
		// use however you wish
		//
		// CImageInfo will get the image type ,dimensions, and
		// color depth from JPG, PNG, BMP, and GIF files.
		//
		// version date: June 16, 1999
		//
		// http://www.wotsit.org is a good source of
		// file format information.  This code would not have been
		// possible without the files I found there.
		//
		
		// read-only properties
		
		//Public Function GetWidth() As Long
		//    Return GraphicWidth
		//End Function
		//Public Function GetHeight() As Long
		//    Return GraphicHeight
		//End Function
		//Public Function GetDepth() As Byte
		//    Return graphicDepth
		//End Function
		//Public Function GetImageType() As eImageType
		//    Return ImageType
		//End Function
		
		//Public Sub ReadImageInfo(ByVal sFileName As String)
		//    ' This is the sub to call to retrieve information on a file.
		
		//    ' Byte array buffer to store part of the file
		//    Dim bBuf(BUFFERSIZE) As Byte
		//    ' Open file number
		//    Dim iFN As Integer
		
		//    ' Set all properties to default values
		//    GraphicWidth = 0
		//    GraphicHeight = 0
		//    GraphicDepth = 0
		//    ImageType = itUNKNOWN
		
		//    ' here we will load the first part of a file into a byte
		//    'array the amount of the file stored here depends on
		//    'the BUFFERSIZE constant
		//    iFN = FreeFile()
		//Open sFileName For Binary As iFN
		//Get #iFN, 1, bBuf()
		//    Close(iFN)
		
		//    If bBuf(0) = 137 And bBuf(1) = 80 And bBuf(2) = 78 Then
		//        ' this is a PNG file
		
		//        m_ImageType = itPNG
		
		//        ' get bit depth
		//        Select Case bBuf(25)
		//            Case 0
		//                ' greyscale
		//                m_Depth = bBuf(24)
		
		//            Case 2
		//                ' RGB encoded
		//                m_Depth = bBuf(24) * 3
		
		//            Case 3
		//                ' Palette based, 8 bpp
		//                m_Depth = 8
		
		//            Case 4
		//                ' greyscale with alpha
		//                m_Depth = bBuf(24) * 2
		
		//            Case 6
		//                ' RGB encoded with alpha
		//                m_Depth = bBuf(24) * 4
		
		//            Case Else
		//                ' This value is outside of it's normal range, so
		//                'we'll assume
		//                ' that this is not a valid file
		//                m_ImageType = itUNKNOWN
		
		//        End Select
		
		//        If m_ImageType Then
		//            ' if the image is valid then
		
		//            ' get the width
		//            m_Width = Mult(bBuf(19), bBuf(18))
		
		//            ' get the height
		//            m_Height = Mult(bBuf(23), bBuf(22))
		//        End If
		
		//    End If
		
		//    If bBuf(0) = 71 And bBuf(1) = 73 And bBuf(2) = 70 Then
		//        ' this is a GIF file
		
		//        m_ImageType = itGIF
		
		//        ' get the width
		//        m_Width = Mult(bBuf(6), bBuf(7))
		
		//        ' get the height
		//        m_Height = Mult(bBuf(8), bBuf(9))
		
		//        ' get bit depth
		//        m_Depth = (bBuf(10) And 7) + 1
		//    End If
		
		//    If bBuf(0) = 66 And bBuf(1) = 77 Then
		//        ' this is a BMP file
		
		//        m_ImageType = itBMP
		
		//        ' get the width
		//        m_Width = Mult(bBuf(18), bBuf(19))
		
		//        ' get the height
		//        m_Height = Mult(bBuf(22), bBuf(23))
		
		//        ' get bit depth
		//        m_Depth = bBuf(28)
		//    End If
		
		//    If m_ImageType = itUNKNOWN Then
		//        ' if the file is not one of the above type then
		//        ' check to see if it is a JPEG file
		//        Dim lPos As Long
		
		//        Do
		//            ' loop through looking for the byte sequence FF,D8,FF
		//            ' which marks the begining of a JPEG file
		//            ' lPos will be left at the postion of the start
		//            If (bBuf(lPos) = &HFF And bBuf(lPos + 1) = &HD8 _
		//                 And bBuf(lPos + 2) = &HFF) _
		//                 Or (lPos >= BUFFERSIZE - 10) Then Exit Do
		
		//            ' move our pointer up
		//            lPos = lPos + 1
		
		//            ' and continue
		//        Loop
		
		//        lPos = lPos + 2
		//        If lPos >= BUFFERSIZE - 10 Then Exit Sub
		
		
		//        Do
		//            ' loop through the markers until we find the one
		//            'starting with FF,C0 which is the block containing the
		//            'image information
		
		//            Do
		//                ' loop until we find the beginning of the next marker
		//                If bBuf(lPos) = &HFF And bBuf(lPos + 1) _
		//               <> &HFF Then Exit Do
		//                lPos = lPos + 1
		//                If lPos >= BUFFERSIZE - 10 Then Exit Sub
		//            Loop
		
		//            ' move pointer up
		//            lPos = lPos + 1
		
		//            Select Case bBuf(lPos)
		//                Case &HC0 To &HC3, &HC5 To &HC7, &HC9 To &HCB, _
		//                &HCD To &HCF
		//                    ' we found the right block
		//                    Exit Do
		//            End Select
		
		//            ' otherwise keep looking
		//            lPos = lPos + Mult(bBuf(lPos + 2), bBuf(lPos + 1))
		
		//            ' check for end of buffer
		//            If lPos >= BUFFERSIZE - 10 Then Exit Sub
		
		//        Loop
		
		//        ' If we've gotten this far it is a JPEG and we are ready
		//        ' to grab the information.
		
		//        m_ImageType = itJPEG
		
		//        ' get the height
		//        m_Height = Mult(bBuf(lPos + 5), bBuf(lPos + 4))
		
		//        ' get the width
		//        m_Width = Mult(bBuf(lPos + 7), bBuf(lPos + 6))
		
		//        ' get the color depth
		//        m_Depth = bBuf(lPos + 8) * 8
		
		//    End If
		
		//End Sub
		//Private Function Mult(ByVal lsb As Byte, ByVal msb As Byte) As Long
		//    Mult = lsb + (msb * CLng(256))
		//End Function
		
		public void SayWords(string Words)
		{
			if (modGlobals.gVoiceOn == false)
			{
				return;
			}
#if Offfice2007
			SpeechSynthesizer Voice = new SpeechSynthesizer();
			Voice.Rate = 0;
			Voice.Speak(Words);
#endif
		}
		
		
		public void ckFreetextSearchLine(TextBox SearchText)
		{
			string S = SearchText.Text.Trim();
			string[] A = S.Split(" ".ToCharArray());
			for (int I = 0; I <= (A.Length - 1); I++)
			{
				string token = A[I];
				if (token.IndexOf(('\u0022').ToString()) + 1 > 0)
				{
					while (token.IndexOf(('\u0022').ToString()) + 1 > 0)
					{
						int II = token.IndexOf(('\u0022').ToString()) + 1;
						StringType.MidStmtStr(ref token, II, 1, " ");
					}
				}
				token = token.Trim();
				A[I] = token;
				if (token.ToUpper().Equals("AND"))
				{
					A[I] = "";
				}
				else if (token.ToUpper().Equals("NOT"))
				{
					A[I] = "";
				}
				else if (token.ToUpper().Equals("OR"))
				{
					A[I] = "";
				}
			}
			S = "";
			for (int i = 0; i <= (A.Length - 1); i++)
			{
				if (A[i].Trim().Length > 0)
				{
					S = S + A[i].Trim() + " ";
				}
			}
			S = S.Trim();
			SearchText.Text = S;
		}
		public void ckFreetextRemoveOr(ref string SqlQuery, string LocatorPhrase)
		{
			//" FREETEXT ("
			//FREETEXT (EMAIL.*
			//freetext (subject,
			string S = SqlQuery.Trim;
			int I = 0;
			int J = 0;
			
			string Part1 = "";
			string Part2 = "";
			
			I = SqlQuery.IndexOf(LocatorPhrase) + 1;
			if (I == 0)
			{
				return;
			}
			
			I = SqlQuery.IndexOf("\'", I + 2 - 1) + 1;
			J = SqlQuery.IndexOf("\'", I + 1 - 1) + 1;
			
			Part1 = SqlQuery.Substring(0, I).Trim();
			Part2 = SqlQuery.Substring(J - 1).Trim();
			
			//Clipboard.Clear()
			//Clipboard.SetText(Part1)
			
			
			string S2 = S.Substring(I + 1 - 1, J - I - 1).Trim();
			string[] A = S2.Split(" ".ToCharArray());
			
			for (I = 0; I <= (A.Length - 1); I++)
			{
				string token = A[I];
				//If InStr(1, token, Chr(34)) > 0 Then
				//    Do While InStr(1, token, Chr(34)) > 0
				//        Dim II As Integer = InStr(1, token, Chr(34))
				//        Mid(token, II, 1) = " "
				//    Loop
				//End If
				token = token.Trim();
				A[I] = token;
				if (token.ToUpper().Equals("OR"))
				{
					A[I] = "";
				}
			}
			
			S = "";
			for (I = 0; I <= (A.Length - 1); I++)
			{
				if (A[I].Trim().Length > 0)
				{
					S = S + A[I].Trim() + " ";
				}
			}
			S = S.Trim();
			
			S = Part1 + " " + S + " " + Part2;
			//Clipboard.Clear()
			//Clipboard.SetText(S)
			SqlQuery = S;
		}
		
		public bool SaveScreen(string theFile)
		{
			PictureBox Pic = new PictureBox();
			IDataObject data;
			data = Clipboard.GetDataObject();
			Bitmap bmap;
			if (data.GetDataPresent(typeof(System.Drawing.Bitmap)))
			{
				bmap = (Bitmap) (data.GetData(typeof(System.Drawing.Bitmap)));
				Pic.Image = bmap;
				Pic.Image.Save(theFile, System.Drawing.Imaging.ImageFormat.Jpeg);
			}
		}
		public string getFileNameWithoutExtension(string FullPath)
		{
			return System.IO.Path.GetFileNameWithoutExtension(FullPath);
		}
		public string getDirName(string FQN)
		{
			string dirName = System.IO.Path.GetDirectoryName(FQN);
			return dirName;
		}
		public string getFileName(string FQN)
		{
			try
			{
				string dirName = System.IO.Path.GetFileName(FQN);
				return dirName;
			}
			catch (Exception)
			{
				return FQN;
			}
		}
		public string getFullPath(string FQN)
		{
			string dirName = System.IO.Path.GetFullPath(FQN);
			return dirName;
		}
		public string getFileExtension(string FQN)
		{
			string dirName = System.IO.Path.GetExtension(FQN);
			return dirName;
		}
		
		
		/// <summary>
		/// This method starts at the specified directory, and traverses all subdirectories.
		/// It returns a List of those directories.
		/// </summary>
		public List<string> GetFilesRecursive(string initial)
		{
			// This list stores the results.
			List<string> result = new List<string>();
			
			// This stack stores the directories to process.
			Stack<string> stack = new Stack<string>();
			
			// Add the initial directory
			stack.Push(initial);
			
			// Continue processing for each stacked directory
			while (stack.Count > 0)
			{
				// Get top directory string
				string dir = (string) (stack.Pop());
				try
				{
					// Add all immediate file paths
					Result.AddRange(Directory.GetFiles(dir, "*.*"));
					
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
		public bool GetSubDirs(string ParentDir, List<string> Result)
		{
			
			ParentDir = UTIL.ReplaceSingleQuotes(ParentDir);
			
			try
			{
				string MS = DateTime.Now.Millisecond.ToString();
				bool B = false;
				string TempDir = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData);
				string sCmd = "DIR " + ParentDir + "\\*.* /AD /S >" + TempDir + "\\ServiceManager.DirListing." + MS + ".txt";
				
				string OutputFileFQN = TempDir + "\\ServiceManager.DirListing." + MS + ".txt";
				
				string BatchFileName = TempDir + "\\ServiceManger.GetDirListing.bat";
				
				StreamWriter objReader;
				try
				{
					objReader = new StreamWriter(BatchFileName);
					objReader.Write(sCmd);
					objReader.Close();
					objReader.Dispose();
					B = true;
				}
				catch (Exception Ex)
				{
					LOG.WriteToArchiveLog((string) ("ERROR: GetSubDirs 200: " + Ex.Message));
					return B;
				}
				
				frmMain.Default.SB2.Text = (string) ("Directory Inventory: " + DateTime.Now.ToString());
				
				ProcessStartInfo starter = new ProcessStartInfo(BatchFileName);
				
				System.Diagnostics.Process P = new System.Diagnostics.Process();
				
				P.StartInfo = starter;
				P.Start();
				P.WaitForExit();
				
				int I = 0;
				while (! P.HasExited)
				{
					I++;
					System.Threading.Thread.Sleep(2000);
					frmMain.Default.SB2.Text = (string) ("Directory Inventory:" + I.ToString() + " : " + DateTime.Now.ToString());
					frmMain.Default.SB2.Refresh();
					Application.DoEvents();
				}
				
				string sFileName = "";
				System.IO.StreamReader srFileReader;
				string sInputLine;
				string DirToSave = "";
				
				File F;
				if (! F.Exists(OutputFileFQN))
				{
					LOG.WriteToArchiveLog("ERROR - failed to create the Quick Directory List.");
					return false;
				}
				
				F = null;
				
				sFileName = OutputFileFQN;
				srFileReader = System.IO.File.OpenText(sFileName);
				sInputLine = srFileReader.ReadLine();
				while (!(sInputLine == null))
				{
					DirToSave = "";
					sInputLine = srFileReader.ReadLine();
					if (sInputLine == null)
					{
						goto LoopOver;
					}
					sInputLine = sInputLine.Trim();
					if (sInputLine.IndexOf("Directory of") + 1)
					{
						string T = sInputLine.Substring(0, "Directory of".Length);
						if (T.ToUpper().Equals("DIRECTORY OF"))
						{
							DirToSave = sInputLine.Substring("Directory of".Length + 1 - 1);
							DirToSave = DirToSave.Trim;
							if (Result.Contains(DirToSave))
							{
							}
							else
							{
								if (DirToSave.Trim.Length > 254)
								{
									DirToSave = modGlobals.getShortDirName(DirToSave);
								}
								Result.Add(DirToSave);
							}
						}
					}
LoopOver:
					1.GetHashCode() ; //VBConversions note: C# requires an executable line here, so a dummy line was added.
				}
				
				srFileReader.Close();
				srFileReader = null;
				
				File F2;
				if (F2.Exists(OutputFileFQN))
				{
					F2.Delete(OutputFileFQN);
				}
				
				F2 = null;
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("ERROR GetSubDirs - 100.23.1 - " + ex.Message));
				return false;
			}
			
			return true;
			
		}
		
		public List<string> GetDirsRecursive(string initial)
		{
			// This list stores the results.
			List<string> result = new List<string>();
			
			initial = UTIL.ReplaceSingleQuotes(initial);
			
			// This stack stores the directories to process.
			Stack<string> stack = new Stack<string>();
			
			// Add the initial directory
			stack.Push(initial);
			
			// Continue processing for each stacked directory
			while (stack.Count > 0)
			{
				// Get top directory string
				string dir = (string) (stack.Pop());
				if (Result.Contains(dir))
				{
				}
				else
				{
					Result.Add(dir);
				}
				
				IXV1++;
				//'FrmMDIMain.SB4.Text = "Pre-inventory: " + IXV1.ToString
				Application.DoEvents();
				
				try
				{
					// Add all immediate file paths
					//result.AddRange(Directory.GetFiles(dir, "*.*"))
					// Loop through all subdirectories and add them to the stack.
					
					
					frmMain.Default.SB2.Text = dir;
					frmMain.Default.SB2.Refresh();
					Application.DoEvents();
					
					int iDirCnt = Directory.GetDirectories(dir).Count;
					if (iDirCnt > 0)
					{
						foreach (string directoryName in Directory.GetDirectories(dir))
						{
							IXV1++;
							//'FrmMDIMain.SB4.Text = "Pre-inventory: " + IXV1.ToString
							Application.DoEvents();
							
							stack.Push(directoryName);
							if (Result.Contains(dir))
							{
							}
							else
							{
								Result.Add(directoryName);
							}
						}
					}
					
				}
				catch (Exception)
				{
				}
			}
			
			// Return the list
			return result;
		}
		public void GetAllDirs(string DirFqn, ref List<string> result)
		{
			
			DirectoryInfo Root = new DirectoryInfo(DirFqn);
			FileInfo[] Files = Root.GetFiles("*.*");
			DirectoryInfo[] Dirs = Root.GetDirectories("*.*");
			
			Console.WriteLine("Root Directories");
			
			
			foreach (DirectoryInfo DirectoryName in Dirs)
			{
				try
				{
					Console.Write(DirectoryName.FullName);
					//Console.Write(" contains {0} files ", DirectoryName.GetFiles().Length)
					//Console.WriteLine(" and {0} subdirectories ", DirectoryName.GetDirectories().Length)
					
					frmMain.Default.SB2.Text = DirectoryName.FullName;
					frmMain.Default.SB2.Refresh();
					Application.DoEvents();
					
					if (DirectoryName.GetDirectories().Length > 0)
					{
						object A = DirectoryName.GetDirectories("*.*");
						foreach (string DirName in (IEnumerable) A)
						{
							GetAllDirs(DirFqn, ref result);
						}
					}
					
					if (Result.Contains(DirectoryName.FullName))
					{
					}
					else
					{
						Result.Add(DirectoryName.FullName);
					}
				}
				catch (Exception)
				{
					Console.WriteLine("Error accessing");
				}
			}
			
		}
		public void GetFilesRecursive(string initial, List<string> List)
		{
			// This list stores the results.
			List<string> result = new List<string>();
			
			// This stack stores the directories to process.
			Stack<string> stack = new Stack<string>();
			
			// Add the initial directory
			stack.Push(initial);
			
			// Continue processing for each stacked directory
			while (stack.Count > 0)
			{
				// Get top directory string
				string dir = (string) (stack.Pop());
				try
				{
					// Add all immediate file paths
					Result.AddRange(Directory.GetFiles(dir, "*.*"));
					
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
			CombineLists(List, result);
		}
		
		public void CombineLists(List<string> ParentList, List<string> ChildList)
		{
			int I = 0;
			for (I = 0; I <= ChildList.Count - 1; I++)
			{
				string S = (string) (ChildList.Item(I));
				ParentList.Add(S);
			}
			ChildList.Clear();
		}
		public void FixFileExtension(ref string Extension)
		{
			Extension = Extension.Trim;
			Extension = Extension.ToLower;
			if (Extension.IndexOf(".") + 1 == 0)
			{
				Extension = (string) ("." + Extension);
			}
			while (Extension.IndexOf(",") + 1 > 0)
			{
				StringType.MidStmtStr(ref Extension, Extension.IndexOf(",") + 1, 1, ".");
			}
			return;
		}
		public bool isExtIncluded(string fExt, ArrayList IncludedTypes)
		{
			fExt = fExt.ToUpper();
			if (fExt.Length > 1)
			{
				fExt = fExt.ToUpper();
				if (fExt.Substring(0, 1) == ".")
				{
					StringType.MidStmtStr(ref fExt, 1, 1, " ");
					fExt = fExt.Trim();
				}
			}
			
			//Dim B As Boolean = False
			if (IncludedTypes.Contains("*"))
			{
				return true;
			}
			else if (IncludedTypes.Contains(".*"))
			{
				return true;
			}
			else if (IncludedTypes.Contains(fExt))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		public bool isExtExcluded(string fExt, ArrayList ExcludedTypes)
		{
			
			fExt = fExt.ToUpper();
			if (fExt.Length > 1)
			{
				fExt = fExt.ToUpper();
				if (fExt.Substring(0, 1) == ".")
				{
					StringType.MidStmtStr(ref fExt, 1, 1, " ");
					fExt = fExt.Trim();
				}
			}
			
			//Dim B As Boolean = False
			
			if (ExcludedTypes.Contains("*"))
			{
				return true;
			}
			else if (ExcludedTypes.Contains(".*"))
			{
				return true;
			}
			else if (ExcludedTypes.Contains(fExt))
			{
				return true;
			}
			else
			{
				return false;
			}
			
		}
		public string commentOutOrderBy(string sTxt)
		{
			string S = sTxt;
			if (S.Trim().Length == 0)
			{
				return "";
			}
			//** Find the starting point of the order by and start the comment there
			int X = 0;
			X = S.IndexOf("order by") + 1;
			string S1 = S.Substring(0, X - 1);
			string S2 = S.Substring(X - 1);
			string S3 = S1 + "\r\n" + "  /* " + S2 + "  */";
			S = S3;
			return S;
		}
		public bool CreateMissingDir(string DirFQN)
		{
			
			bool B = false;
			Directory D;
			if (D.Exists(DirFQN))
			{
				return true;
			}
			try
			{
				D.CreateDirectory(DirFQN);
				return true;
			}
			catch (Exception ex)
			{
				LogThis((string) ("ERROR 76.54.32 - Could not create restore directory. " + "\r\n" + ex.Message));
				MessageBox.Show((string) ("ERROR 76.54.32 - Could not create restore directory. " + "\r\n" + "\r\n" + "Please verify that you have authority to create this directory." + ex.Message));
				return false;
			}
			finally
			{
				D = null;
				GC.Collect();
				GC.WaitForPendingFinalizers();
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
				LogThis((string) ("clsDatabase : LoadLicenseFile : 5914 : " + Ex.Message));
				return false;
			}
			return strContents;
		}
		
		public void LogThis(string MSG)
		{
			clsLogging LOG = new clsLogging();
			LOG.WriteToArchiveLog(MSG);
			LOG = null;
		}
		public string ReadFile(string fName)
		{
			System.IO.StreamReader SR = new System.IO.StreamReader(fName);
			string FullText = "";
			while (! SR.EndOfStream)
			{
				string S = SR.ReadLine();
				FullText = FullText + S + "\r\n";
			}
			SR.Close();
			return FullText;
		}
		public void WriteFile(string FQN, string sText)
		{
			try
			{
				System.IO.StreamWriter SW = new System.IO.StreamWriter(FQN);
				string S = sText.Trim();
				
				if (S.Length > 0)
				{
					SW.WriteLine(S);
				}
				SW.Close();
			}
			catch (Exception ex)
			{
				LogThis((string) ("clsDMa:WriteFile - " + ex.Message));
			}
			
		}
		public void ModifyAppConfig(string ServerName, string ItemToModify)
		{
			string AppConfigBody = "";
			string aPath = App_Path();
			string AppName = aPath + "EcmArchiveSetup.exe.config";
			
			File F;
			if (F.Exists(AppName))
			{
				AppConfigBody = ReadFile(AppName);
				if (AppConfigBody.Trim().Length > 0)
				{
					ApplyAppConfigChange(ServerName, ItemToModify, ref AppConfigBody);
					if (AppConfigBody.Trim().Length > 0)
					{
						WriteFile(AppName, AppConfigBody);
						SetUserConnectionString(ServerName);
						SetThesaurusConnectionStringToConfig(ServerName);
					}
				}
			}
		}
		public void SetUserConnectionString(string ServerName)
		{
			
			string sCurr = ServerName;
			
			My.Settings.Default["UserDefaultConnString"] = "?";
			My.Settings.Default.Save();
			
			string S = System.Configuration.ConfigurationManager.AppSettings["ECMREPO"];
			
			//*****************************************************************************
			string Str1 = "";
			string Str2 = "";
			string NewStr = ServerName;
			
			int NumberOfCycles = 0;
			int I = 1;
			while (S.IndexOf("Data Source=", I - 1) + 1 > 0)
			{
				
				I = S.IndexOf("Data Source=", I - 1) + 1;
				I = S.IndexOf("=", I + 1 - 1) + 1;
				int J = S.IndexOf(";", I + 1 - 1) + 1;
				Str1 = S.Substring(0, I);
				Str2 = S.Substring(J - 1);
				S = Str1 + sCurr + Str2;
				NumberOfCycles++;
				if (NumberOfCycles > 50)
				{
					break;
				}
				I = J + 1;
				
			}
			//*****************************************************************************
			
			UTIL.setConnectionStringTimeout(ref S);
			//S = ENC.AES256DecryptString(S)
			
			My.Settings.Default.Reload();
			Console.WriteLine(My.Settings.Default["UserDefaultConnString"]);
			My.Settings.Default["UserDefaultConnString"] = S;
			Console.WriteLine(My.Settings.Default["UserDefaultConnString"]);
			My.Settings.Default.Save();
			
		}
		public void SetThesaurusConnectionStringToConfig(string ServerName)
		{
			
			string sCurr = ServerName;
			
			My.Settings.Default["UserThesaurusConnString"] = "?";
			My.Settings.Default.Save();
			string S = System.Configuration.ConfigurationManager.AppSettings["ECM_ThesaurusConnectionString"].ToString();
			
			//*****************************************************************************
			string Str1 = "";
			string Str2 = "";
			string NewStr = ServerName;
			
			int NumberOfCycles = 0;
			int I = 1;
			while (S.IndexOf("Data Source=", I - 1) + 1 > 0)
			{
				
				I = S.IndexOf("Data Source=", I - 1) + 1;
				I = S.IndexOf("=", I + 1 - 1) + 1;
				int J = S.IndexOf(";", I + 1 - 1) + 1;
				Str1 = S.Substring(0, I);
				Str2 = S.Substring(J - 1);
				S = Str1 + sCurr + Str2;
				NumberOfCycles++;
				if (NumberOfCycles > 50)
				{
					break;
				}
				I = J + 1;
				
			}
			//*****************************************************************************
			
			UTIL.setConnectionStringTimeout(ref S);
			//S = ENC.AES256DecryptString(S)
			
			My.Settings.Default.Reload();
			Console.WriteLine(My.Settings.Default["UserDefaultConnString"]);
			My.Settings.Default["UserThesaurusConnString"] = S;
			Console.WriteLine(My.Settings.Default["UserDefaultConnString"]);
			My.Settings.Default.Save();
			
		}
		public void ApplyAppConfigChange(string ServerName, string ItemToModify, ref string AppConFigBody)
		{
			
			if (ServerName.Trim.Length == 0)
			{
				return;
			}
			
			string AppText = AppConFigBody;
			string Str1 = "";
			string Str2 = "";
			string NewStr = ServerName;
			
			int NumberOfCycles = 0;
			int I = 1;
			while (AppText.IndexOf("Data Source=", I - 1) + 1 > 0)
			{
				I = AppText.IndexOf("Data Source=", I - 1) + 1;
				I = AppText.IndexOf("=", I + 1 - 1) + 1;
				int J = AppText.IndexOf(";", I + 1 - 1) + 1;
				Str1 = AppText.Substring(0, I);
				//messagebox.show(Str1)
				Str2 = AppText.Substring(J - 1);
				//messagebox.show(Str2)
				AppText = Str1 + ServerName + Str2;
				//messagebox.show(AppText)
				NumberOfCycles++;
				if (NumberOfCycles > 50)
				{
					break;
				}
				I = J + 1;
				//Clipboard.Clear()
				//Clipboard.SetText(AppText)
			}
			
			AppConFigBody = AppText;
			
		}
		
		public void deleteDirectoryFiles(string DirFQN)
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
		
		public int getFileInDir(string DirName, ref string[] DirFiles)
		{
			int I = 0;
			
			try
			{
				DirFiles = new string[1];
				string FileAttributes = "";
				
				string strFileSize = "";
				int iFileSize = 0;
				System.IO.DirectoryInfo di = new System.IO.DirectoryInfo(DirName);
				System.IO.FileInfo[] aryFi = di.GetFiles("*.*");
				
				
				try
				{
					foreach (System.IO.FileInfo fi in aryFi)
					{
						strFileSize = (string) ((Math.Round(fi.Length / 1024)).ToString());
						FileAttributes = "";
						FileAttributes = FileAttributes + fi.Name + "|";
						FileAttributes = FileAttributes + fi.FullName + "|";
						FileAttributes = FileAttributes + fi.Length.ToString() + "|";
						FileAttributes = FileAttributes + fi.Extension + "|";
						FileAttributes = FileAttributes + fi.LastAccessTime.ToString() + "|";
						FileAttributes = FileAttributes + fi.CreationTime.ToString() + "|";
						FileAttributes = FileAttributes + fi.LastWriteTime.ToString();
						if (I == 0)
						{
							DirFiles[0] = FileAttributes;
						}
						else
						{
							Array.Resize(ref DirFiles, I + 1);
							DirFiles[I] = FileAttributes;
						}
						I++;
					}
				}
				catch (Exception ex)
				{
					LOG.WriteToArchiveLog((string) ("Error 22012: " + ex.Message));
				}
				
			}
			catch (Exception ex)
			{
				LOG.WriteToArchiveLog((string) ("Error 22013: " + ex.Message));
			}
			return I;
		}
		
		
	}
	
}

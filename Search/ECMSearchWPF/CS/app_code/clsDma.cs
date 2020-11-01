#define Offfice2007
#define GetAllWidgets
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

using Microsoft.Win32;
using System.Configuration;
using System.Net;
using System.IO;
using System.Security.Permissions;
using System.Net.Sockets;
using System.Text.RegularExpressions;
using System.Text;
using System.Threading;
//using System.Windows.Application;
using System.Runtime.InteropServices;
using Microsoft.VisualBasic.CompilerServices;


//clsDma: A set of standard utilities to perofrm repetitive tasks through a public class
//Copyright @DMA, Limited, Chicago, IL., June 2003, all rights reserved.
//Licensed on a use only basis for clients of DMA, Limited.

//Imports VB = Microsoft.VisualBasic
//Imports System.Data.SqlClient

namespace ECMSearchWPF
{
	public class clsDma
	{
		
		
		
		bool WaitingForIP = false;
		string TimeOutSecs = "89";
		int NbrOfErrors = 0;
		
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
		public bool RetC;
		
		string SecureID = "-1";
		public clsDma()
		{
			// VBConversions Note: Non-static class variable initialization is below.  Class variables cannot be initially assigned non-static values in C#.
			TempEnvironDir = getEnvVarTempDir();
			
			SecureID = GLOBALS._SecureID.ToString();
		}
		
		public string ckVar2(ref string tVal)
		{
			if (tVal == "&nbsp;")
			{
				tVal = "";
			}
			return tVal;
		}
		
		//Public Sub ListDirs(ByRef Dirs$(), ByRef Files$(), ByVal TargetDir as string)
		//    'String [] subs = Directory.GetDirectories("C:\\Inetpub\\wwwroot");
		//    'String [] subs = Directory.GetDirectories("C:/Inetpub/wwwroot");
		//    ReDim Dirs$(0)
		//    ReDim Files$(0)
		//    Dim path$ = TargetDir$
		//    Try
		//        If Not Directory.Exists(path) Then
		//            Return
		//        Else
		//            Dirs = Directory.GetDirectories(path)
		//            Files = Directory.GetFiles(path)
		//        End If
		//    Catch ex As Exception
		//        If dDeBug Then Console.WriteLine(ex.Source)
		//        If dDeBug Then Console.WriteLine(ex.StackTrace)
		//        If dDeBug Then Console.WriteLine(ex.Message)
		//        LogThis("clsDma : ListDirs : 52 : " + ex.Message)
		//        LogThis("clsDma : ListDirs : 55 : " + ex.Message)
		//        LogThis("clsDma : ListDirs : 58 : " + ex.Message)
		//    End Try
		//End Sub
		
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
			//shostname = Application.Current.Host.Source.Host
			shostname = System.Net.Dns.GetHostName();
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
		
		//Public Sub setIPAddr()
		
		//    Dim s As String = ""
		//    Dim dd As Boolean = False
		//    Dim server As String
		//    'server = System.Net.Dns.GetHostName
		//    server = Application.Current.Host.Source.Host
		//    Try
		//        Dim ASCII As New System.Text.UnicodeEncoding()
		
		//        ' Get server related information.
		//        Dim heserver As IPHostEntry = Dns.GetHostEntry(server)
		
		//        ' Loop on the AddressList
		//        Dim curAdd As IPAddress
		//        For Each curAdd In heserver.AddressList
		
		//            ' Display the type of address family supported by the server. If the
		//            ' server is IPv6-enabled this value is: InternNetworkV6. If the server
		//            ' is also IPv4-enabled there will be an additional value of InterNetwork.
		//            '** Console.WriteLine(("AddressFamily: " + curAdd.AddressFamily.ToString()))
		//            s = "AddressFamily: " & curAdd.AddressFamily.ToString()
		//            If dDeBug Then Console.WriteLine(s)
		
		//            ' Display the ScopeId property in case of IPV6 addresses.
		//            If curAdd.AddressFamily.ToString() = ProtocolFamily.InterNetworkV6.ToString() Then
		//                s = "Scope Id: " + curAdd.ScopeId.ToString()
		//                If dDeBug Then
		//                    If dDeBug Then Console.WriteLine(s)
		//                End If
		//            End If
		
		//            ' Display the server IP address in the standard format. In
		//            ' IPv4 the format will be dotted-quad notation, in IPv6 it will be
		//            ' in in colon-hexadecimal notation.
		//            s = "Address: " + curAdd.ToString()
		//            s = curAdd.ToString()
		//            Console.WriteLine(s)
		//            If isFourPartIP(s) Then
		//                MachineIP = s
		//                Exit For
		//            End If
		//            ' Display the server IP address in byte format.
		//            'Console.Write("AddressBytes: ")
		//            's = ""
		//            'Dim bytes As [Byte]() = curAdd.GetAddressBytes()
		//            'Dim i As Integer
		//            'For i = 0 To bytes.Length - 1
		//            '    Console.Write(bytes(i))
		//            '    s = s + bytes(i).ToString
		//            'Next i
		//            'Console.WriteLine(ControlChars.Cr + ControlChars.Lf)
		//            'Console.WriteLine(s)
		//        Next curAdd
		
		//    Catch e As Exception
		//        If dDeBug Then Console.WriteLine(("[DoResolve] Exception: " + e.ToString()))
		//        LogThis("clsDma : setIPAddr : 87 : " + e.Message)
		//        LogThis("clsDma : setIPAddr : 92 : " + e.Message)
		//        LogThis("clsDma : setIPAddr : 97 : " + e.Message)
		//    End Try
		
		//    MachineIP = s
		
		//End Sub
		
		public bool isFourPartIP(string IP)
		{
			if (IP.IndexOf(":") + 1 > 0)
			{
				return false;
			}
			object[] A = IP.Split(".".ToCharArray());
			if (A.Length == 4)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public string getEnvVarTempDir()
		{
			
			string td = "";
			clsIsolatedStorage ISO = new clsIsolatedStorage();
			td = ISO.getTempDir();
			ISO = null;
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
			var CH = "";
			string S = tVal;
			
			S.Replace("/", ".");
			S.Replace(":", ".");
			
			for (i = 1; i <= tVal.Length; i++)
			{
				CH = tVal.Substring(i - 1, 1);
				j = "0123456789 _~abcdefghijklmnopqrstuvwxyz-@$.".IndexOf(CH) + 1;
				if (j == 0)
				{
					tVal = RemoveChar(tVal, CH);
				}
			}
			
			return S;
			
		}
		
		public string RemoveChar(string tVal, string CharToRemove)
		{
			
			int i = tVal.Length;
			object[] A;
			string S = "";
			A = tVal.Split(CharToRemove.ToCharArray());
			for (i = 0; i <= (A.Length - 1); i++)
			{
				var Token = A[i].ToString();
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
			tVal.Replace("^", ".");
			return tVal;
		}
		
		public string ReplaceChar(string InputString, string CharToReplace, string ReplaceWith)
		{
			string S = InputString;
			S.Replace(CharToReplace, ReplaceWith);
			return S;
		}
		
		//Public Function GetFileName(ByVal FQN as string) As String
		//    Dim fn$ = ""
		
		//    Dim i# = 0
		//    Dim j# = 0
		//    Dim ch$ = ""
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
			
			var fn = "";
			
			try
			{
				
				double i = 0;
				double j = 0;
				var ch = "";
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
				LOG.WriteToSqlLog((string) ("ERROR clsDma:GetFilePath: Could not get file path - " + ex.Message + "\r\n" + ex.StackTrace));
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
		//Public Function CapiInterface(ByVal Key1 As String, ByVal Key2 As String) As String
		
		//    Dim s As String = ""
		//    Dim rkCurrentUser As RegistryKey = Registry.CurrentUser
		//    Dim rkTest As RegistryKey = rkCurrentUser.OpenSubKey(Key1 + ":" + Key2)
		
		//    If rkTest Is Nothing Then
		//        s = ""
		//    Else
		//        s = rkTest.GetValue(Key1 + ":" + Key2)
		//        rkTest.Close()
		//        rkCurrentUser.Close()
		//    End If
		
		//    Return s
		
		//End Function
		
		//'** Sets a registry value for the current UserID
		//Public Function CApiSetLocalIniValue(ByVal Key1 As String, ByVal Key2 As String, ByVal SuppliedVal As String) As String
		//    Dim RegistryKey As String = Key1 + ":" + Key2
		//    'RegistryKey = Key1 + ":" + Key2
		//    Dim rkTest As RegistryKey = Registry.CurrentUser.OpenSubKey("RegistryOpenSubKeyExample", True)
		//    If rkTest Is Nothing Then
		//        Dim rk As RegistryKey = Registry.CurrentUser.CreateSubKey("RegistryOpenSubKeyExample")
		//        rk.Close()
		//    Else
		//        rkTest.SetValue(RegistryKey, SuppliedVal)
		//        '        Console.WriteLine("Test value for TestName: {0}", rkTest.GetValue("TestName"))
		//        rkTest.Close()
		//    End If
		//    Return SuppliedVal
		//End Function
		
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
		
		public void GetIPAddress(System.Net.IPAddress myIPAddress)
		{
			//This sub will get all IP addresses, the first one should be the adapters MAC
			//address, the second one the IP Address when connected to the internet.
			
			Debug.Print("myIPAddress2", myIPAddress.ToString());
			
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
			var S1 = "";
			var S2 = "";
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
			var MimeTypes = "application/andrew-inset | ez,application/mac-binhex40 | hqx,application/mac-compactpro | cpt,application/msword | doc,application/octet-stream | bin,application/octet-stream | dms,application/octet-stream | lha,application/octet-stream | lzh,application/octet-stream | exe,application/x-rar-compressed | rar,application/octet-stream | class,application/octet-stream | so,application/octet-stream | dll,application/oda | oda,application/pdf | pdf,application/postscript | ai,application/postscript | eps,application/postscript | ps,application/smil | smi,application/smil | smil,application/vnd.mif | mif,application/vnd.ms-excel | xls,application/vnd.ms-powerpoint | ppt,application/vnd.wap.wbxml | wbxml,application/vnd.wap.wmlc | wmlc,application/vnd.wap.wmlscriptc | wmlsc,application/x-bcpio | bcpio,application/x-cdlink | vcd,application/x-chess-pgn | pgn,application/x-cpio | cpio,application/x-csh | csh,application/x-director | dcr,application/x-director | dir,application/x-director | dxr,application/x-dvi | dvi,application/x-futuresplash | spl,application/x-gtar | gtar,application/x-hdf | hdf,application/x-javascript | js,application/x-koan | skp,application/x-koan | skd,application/x-koan | skt,application/x-koan | skm,application/x-latex | latex,application/x-netcdf | nc,application/x-netcdf | cdf,application/x-sh | sh,application/x-shar | shar,application/x-shockwave-flash | swf,application/x-stuffit | sit,application/x-sv4cpio | sv4cpio,application/x-sv4crc | sv4crc,application/x-tar | tar,application/x-tcl | tcl,application/x-tex | tex,application/x-texinfo | texinfo,application/x-texinfo | texi,application/x-troff | t,application/x-troff | tr,application/x-troff | roff,application/x-troff-man | man,application/x-troff-me | me,application/x-troff-ms | ms,application/x-ustar | ustar,application/x-wais-source | src,application/xhtml+xml | xhtml,application/xhtml+xml | xht,application/zip | zip,audio/basic | au,audio/basic | snd,audio/midi | mid,audio/midi | midi,audio/midi | kar,audio/mpeg | mpga,audio/mpeg | mp2,audio/mpeg | mp3,audio/x-aiff | aif,audio/x-aiff | aiff,audio/x-aiff | aifc,audio/x-mpegurl | m3u,audio/x-pn-realaudio | ram,audio/x-pn-realaudio | rm,audio/x-pn-realaudio-plugin | rpm,audio/x-realaudio | ra,audio/x-wav | wav,chemical/x-pdb | pdb,chemical/x-xyz | xyz,image/bmp | bmp,image/gif | gif,image/ief | ief,image/jpeg | jpeg,image/jpeg | jpg,image/jpeg | jpe,image/png | png,image/tiff | tiff,image/tiff | tif,image/vnd.djvu | djvu,image/vnd.djvu | djv,image/vnd.wap.wbmp | wbmp,image/x-cmu-raster | ras,image/x-portable-anymap | pnm,image/x-portable-bitmap | pbm,image/x-portable-graymap | pgm,image/x-portable-pixmap | ppm,image/x-rgb | rgb,image/x-xbitmap | xbm,image/x-xpixmap | xpm,image/x-xwindowdump | xwd,model/iges | igs,model/iges | iges,model/mesh | msh,model/mesh | mesh,model/mesh | silo,model/vrml | wrl,model/vrml | vrml,text/css | css,text/html | html,text/html | htm,text/plain | asc,text/plain | txt,text/richtext | rtx,text/rtf | rtf,text/sgml | sgml,text/sgml | sgm,text/tab-separated-values | tsv,text/vnd.wap.wml | wml,text/vnd.wap.wmlscript | wmls,text/x-setext | etx,text/xml | xsl,text/xml | xml,video/mpeg | mpeg,video/mpeg | mpg,video/mpeg | mpe,video/quicktime | qt,video/quicktime | mov,video/vnd.mpegurl | mxu,video/x-msvideo | avi,video/x-sgi-movie | movie,x-conference/x-cooltal | ice";
			object[] A = MimeTypes.Split(',');
			int I = 0;
			var Classification = "";
			var TgtMime = "";
			for (I = 0; I <= (A.Length - 1); I++)
			{
				object[] b = (A[I]).Split('|');
				Classification = (string) (b[0].Trim);
				var tMime = b[1].Trim;
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
				bytes[counter] = Convert.ToByte(intValue);
				counter++;
			}
			
			return bytes;
		}
		
		//    Function getFilesInDir(ByVal DirName as string, byref DirFiles$(), ByVal IncludedTypes As ArrayList, ByVal ExcludedTypes As ArrayList, ByVal ckArchiveFlag As Boolean) As Integer
		//        Dim I As Integer = UBound(DirFiles)
		//        Dim iFilesAdded As Integer = 0
		//        Dim xFileName$ = ""
		//        Try
		//            Dim FileAttributes = ""
		
		//            Dim strFileSize As String = ""
		//            Dim iFileSize As Integer = 0
		//            Dim di As New IO.DirectoryInfo(DirName)
		//            Dim aryFi As IO.FileInfo() = di.GetFiles("*.*")
		//            Dim fi As IO.FileInfo
		
		//            Try
		//                For Each fi In aryFi
		
		//                    'If DirName$.Equals("D:\dev\ECM\EcmLibrary\Documentation") Or DirName$.Equals("D:\dev\ECM\EcmLibrary\Documentation") Then
		//                    '    Dim tMsg$ = "Files in: " + DirName$ + " : " + fi.Name
		//                    '    WriteToArchiveFileTraceLog(tMsg$, False)
		//                    'End If
		
		//                    Dim fExt$ = fi.Extension
		//                    If InStr(fi.FullName, ".") = 0 Then
		//                        LogThis("Warning: File '" + fi.Name + "' has no extension, skipping.")
		//                        GoTo NextFile
		//                    End If
		//                    If fExt.Length = 0 Then
		//                        fExt = getFileExtension(fi.FullName)
		//                    End If
		//                    FixFileExtension(fExt as string)
		
		//                    Dim bbExt As Boolean = isExtIncluded(fExt$, IncludedTypes)
		//                    If Not bbExt Then
		//                        GoTo NextFile
		//                    End If
		
		//                    bbExt = isExtExcluded(fExt$, ExcludedTypes)
		//                    If bbExt Then
		//                        GoTo NextFile
		//                    End If
		//                    If ckArchiveFlag = True Then
		//                        Dim bArch As Boolean = Me.isArchiveBitOn(fi.FullName)
		//                        If bArch = False Then
		//                            'This file does not need to be archived
		//                            GoTo NextFile
		//                        End If
		//                    End If
		
		//                    xFileName$ = fi.FullName
		
		//                    strFileSize = (Math.Round(fi.Length / 1024)).ToString()
		//                    FileAttributes = ""
		//                    FileAttributes = FileAttributes + fi.Name + "|"
		//                    FileAttributes = FileAttributes + fi.FullName + "|"
		//                    FileAttributes = FileAttributes + fi.Length.ToString + "|"
		//                    FileAttributes = FileAttributes + fi.Extension + "|"
		
		//                    Dim xdate As Date = fi.LastAccessTime
		//                    Dim sDate As String = UTIL.ConvertDate(xdate)
		
		//                    FileAttributes = FileAttributes & xdate & "|"
		
		//                    xdate = fi.CreationTime
		//                    sDate = UTIL.ConvertDate(xdate)
		//                    FileAttributes = FileAttributes & xdate & "|"
		
		//                    xdate = fi.LastWriteTime
		//                    sDate = UTIL.ConvertDate(xdate)
		//                    FileAttributes = FileAttributes & xdate
		
		//                    If I = 0 Then
		//                        DirFiles(0) = FileAttributes
		//                        iFilesAdded += 1
		//                    Else
		//                        ReDim Preserve DirFiles(UBound(DirFiles) + 1)
		//                        DirFiles(UBound(DirFiles)) = FileAttributes
		//                        iFilesAdded += 1
		//                    End If
		//NextFile:
		//                    I = I + 1
		//                Next
		//            Catch ex As Exception
		//                LogThis("ERROR - clsDma : getFilesInDir : 22012c : " + ex.Message + vbCrLf + "DIR: " + DirName$ + vbCrLf + "FILE: " + fi.Name)
		//            End Try
		
		//        Catch ex As Exception
		//            'MsgBox("Error 22013: " + ex.Message)
		//            NbrOfErrors += 1
		//            '''FrmMDIMain.SB.Text = "Errors: " + NbrOfErrors.ToString
		//            LogThis("clsDma : getFilesInDir : 471 : " + ex.Message)
		//        End Try
		//        Return iFilesAdded
		//    End Function
		
		//Function getFileInDir(ByVal DirName as string, byref DirFiles$()) As Integer
		//    Dim I As Integer = 0
		
		//    Try
		//        ReDim DirFiles(0)
		//        Dim FileAttributes = ""
		
		//        Dim strFileSize As String = ""
		//        Dim iFileSize As Integer = 0
		//        Dim di As New IO.DirectoryInfo(DirName)
		//        Dim aryFi As IO.FileInfo() = di.GetFiles("*.*")
		//        Dim fi As IO.FileInfo
		
		//        Try
		//            For Each fi In aryFi
		//                strFileSize = (Math.Round(fi.Length / 1024)).ToString()
		//                FileAttributes = ""
		//                FileAttributes = FileAttributes + fi.Name + "|"
		//                FileAttributes = FileAttributes + fi.FullName + "|"
		//                FileAttributes = FileAttributes + fi.Length.ToString + "|"
		//                FileAttributes = FileAttributes + fi.Extension + "|"
		//                FileAttributes = FileAttributes + fi.LastAccessTime.ToString + "|"
		//                FileAttributes = FileAttributes + fi.CreationTime.ToString + "|"
		//                FileAttributes = FileAttributes + fi.LastWriteTime.ToString
		//                If I = 0 Then
		//                    DirFiles(0) = FileAttributes
		//                Else
		//                    ReDim Preserve DirFiles(I)
		//                    DirFiles(I) = FileAttributes
		//                End If
		//                I = I + 1
		//            Next
		//        Catch ex As Exception
		//            MsgBox("Error 22012a: " + ex.Message)
		//            LogThis("clsDma : getFileInDir : 480 : " + ex.Message)
		//            LogThis("clsDma : getFileInDir : 491 : " + ex.Message)
		//            LogThis("clsDma : getFileInDir : 502 : " + ex.Message)
		//        End Try
		
		//    Catch ex As Exception
		//        MsgBox("Error 22013: " + ex.Message)
		//        LogThis("clsDma : getFileInDir : 481 : " + ex.Message)
		//        LogThis("clsDma : getFileInDir : 493 : " + ex.Message)
		//        LogThis("clsDma : getFileInDir : 505 : " + ex.Message)
		//    End Try
		//    Return I
		//End Function
		
		public int getFilesInDir(string DirName, ref string[] DirFiles, string ExactFileName)
		{
			
			DirName = UTIL.RemoveSingleQuotes(DirName);
			ExactFileName = UTIL.RemoveSingleQuotes(ExactFileName);
			
			int I = 0;
			string FQN = DirName + "\\" + ExactFileName;
			try
			{
				DirFiles = new string[1];
				var FileAttributes = "";
				
				string strFileSize = "";
				int iFileSize = 0;
				System.IO.DirectoryInfo di = new System.IO.DirectoryInfo(DirName);
				System.IO.FileInfo fInfo = new System.IO.FileInfo(DirName + "\\" + ExactFileName);
				//Dim aryFi As IO.FileInfo() = di.GetFiles(ExactFileName as string)
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
						DirFiles[0] = FileAttributes;
					}
					else
					{
						Array.Resize(ref DirFiles, I + 1);
						DirFiles[I] = FileAttributes;
					}
					I++;
					//Next
				}
				catch (Exception ex)
				{
					LogThis((string) ("clsDma : getFilesInDir : 508 : " + ex.Message));
					LogThis((string) ("clsDma : getFilesInDir : 521 : " + ex.Message));
					LogThis((string) ("clsDma : getFilesInDir : 534 : " + ex.Message));
				}
				
			}
			catch (Exception ex)
			{
				LogThis((string) ("clsDma : getFilesInDir : 509 : " + ex.Message));
				LogThis((string) ("clsDma : getFilesInDir : 523 : " + ex.Message));
				LogThis((string) ("clsDma : getFilesInDir : 537 : " + ex.Message));
			}
			return I;
		}
		
		public void ReplaceStar(ref string tVal)
		{
			if (tVal.IndexOf("*") + 1 == 0)
			{
				return;
			}
			tVal = tVal.Replace("*", "%");
		}
		public void ReplaceSingleTick(ref string tVal)
		{
			tVal = tVal.Trim();
			var CH = "";
			if (tVal.IndexOf("\'") + 1 == 0)
			{
				return;
			}
			tVal = tVal.Replace("\'", "`");
		}
		
		public void GetStartAndStopDate(ref DateTime StartDate, ref DateTime EndDate)
		{
			//5/14/2009 12:00:00 AM'
			string S1 = StartDate.ToString();
			string S2 = EndDate.ToString();
			
			S2 = S2.Replace("12:00:00 AM", "11:59:59 PM");
			
			StartDate = DateTime.Parse(S1);
			EndDate = DateTime.Parse(S2);
			
			
		}
		
		public string ckQryDate(string StartDate, string EndDate, string Evaluator, string DbColName, ref bool FirstTime)
		{
			
			//** Set to false by WDM on 3/10/2010 to allow for parens and the AND operator
			FirstTime = false;
			
			string S = "";
			var CH = "";
			var WhereClause = "";
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
			
			if (tDir.Trim().Length == 0)
			{
				return;
			}
			
			int I = 0;
			tDir = tDir.Trim();
			I = tDir.Length;
			var CH = tDir.Substring(I - 1, 1);
			if (CH == "\\")
			{
				return;
			}
			else
			{
				tDir = tDir + "\\";
			}
			
		}
		
		//Sub ListRegistryKeys(ByVal FileExt as string, byref LB As List(Of String))
		//    Try
		//        Dim rootKey As RegistryKey
		//        rootKey = Registry.ClassesRoot
		//        Dim S as string
		
		//        Dim regSubKey As RegistryKey
		
		//        Dim subk As String
		
		//        Dim tmp As RegistryKey
		//        rootKey = rootKey.OpenSubKey(FileExt, False)
		//        Debug.Print(rootKey.GetValue("").ToString())
		//        Debug.Print(rootKey.GetValue("Content Type").ToString())
		
		//        Dim ControlApp$ = rootKey.GetValue("Content Type").ToString()
		
		//        LB.Add("Content Type: " + rootKey.GetValue("Content Type").ToString())
		
		//        For Each subk In rootKey.GetSubKeyNames()
		//            'MessageBox.Show(subk)
		//            S = subk + " : "
		//            tmp = rootKey.OpenSubKey(subk)
		//            S = tmp.ToString
		//            LB.Add(S)
		//        Next
		//    Catch ex As Exception
		//        Debug.Print(ex.Message)
		//        LogThis("clsDma : ListRegistryKeys : 595 : " + ex.Message)
		//        LogThis("clsDma : ListRegistryKeys : 610 : " + ex.Message)
		//        LogThis("clsDma : ListRegistryKeys : 625 : " + ex.Message)
		//    End Try
		
		//End Sub
		
		//Function GetCurrUserName() As String
		//    Dim S as string = ""
		//    S = Environment.UserName.ToString
		//    Return S
		//End Function
		
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
			S = Environment.CurrentDirectory.ToString();
			return S;
		}
		
		public string GetCurrUptime()
		{
			string S = "";
			S = (string) (Strings.Mid(System.Convert.ToString(Environment.TickCount / 3600000), 1, 5) + " :Hours");
			return S;
		}
		
		public string GetCurrMachineName()
		{
			string S = "";
			S = Environment.MachineName;
			return S;
		}
		
		public string GetCurrentDirectory()
		{
			string S = "";
			S = Environment.CurrentDirectory.ToString();
			return S;
		}
		
		//Function GetUserDomainName() As String
		//    Dim S as string = ""
		//    S = Environment.UserDomainName.ToString
		//    Return S
		//End Function
		
		//Function GetWorkingSet() As String
		//    Dim S as string = ""
		//    S = Environment.WorkingSet.ToString
		//    Return S
		//End Function
		
		//Function isFileArchiveAttributeSet(ByVal FQN as string) As Boolean
		
		//    Dim fileDetail As IO.FileInfo = My.Computer.FileSystem.GetFileInfo(FQN)
		//    'Console.WriteLine(fileDetail.IsReadOnly)
		//    Dim A As Integer = fileDetail.Attributes.Archive
		//    Dim R As Integer = fileDetail.Attributes.ReadOnly
		//    Dim H As Integer = fileDetail.Attributes.Hidden
		//    Dim C As Integer = fileDetail.Attributes.Compressed
		//    Dim D As Integer = fileDetail.Attributes.Directory
		//    Dim E As Integer = fileDetail.Attributes.Encrypted
		//    Dim N As Integer = fileDetail.Attributes.Normal
		//    Dim NCI As Integer = fileDetail.Attributes.NotContentIndexed
		//    Dim OL As Integer = fileDetail.Attributes.Offline
		//    Dim S As Integer = fileDetail.Attributes.System
		//    Dim T As Integer = fileDetail.Attributes.Temporary
		
		//    'Console.WriteLine(CBool(fileDetail.Attributes And IO.FileAttributes.Hidden))
		
		//    If (fileDetail.Attributes And fileDetail.Attributes.Archive) = fileDetail.Attributes.Archive Then
		//        'MessageBox.Show(fileDetail.Name & " is Archived")
		//        Return False
		//    Else
		//        'MessageBox.Show(fileDetail.Name & " is NOT Archived")
		//        Return True
		//    End If
		
		//End Function
		
		//Function setFileArchiveAttributeSet(ByVal FQN as string, byval SetOn As Boolean) As Boolean
		
		//    Dim fileDetail As IO.FileInfo = My.Computer.FileSystem.GetFileInfo(FQN)
		
		//    If SetOn = True Then
		//        fileDetail.Attributes = fileDetail.Attributes And fileDetail.Attributes.Archive
		//    Else
		//        fileDetail.Attributes = fileDetail.Attributes And Not fileDetail.Attributes.Archive
		//    End If
		
		//End Function
		
		//Function setFileArchiveBitOn(ByVal FQN as string) As Boolean
		//    Dim fileDetail As IO.FileInfo = My.Computer.FileSystem.GetFileInfo(FQN)
		//    fileDetail.Attributes = fileDetail.Attributes + fileDetail.Attributes.Archive
		//End Function
		
		//Function setFileArchiveBitOff(ByVal FQN as string) As Boolean
		//    Dim fileDetail As IO.FileInfo = My.Computer.FileSystem.GetFileInfo(FQN)
		//    fileDetail.Attributes = fileDetail.Attributes - fileDetail.Attributes.Archive
		//End Function
		//'WDM This could be a problem
		//Function ToggleArchiveBit(ByVal filespec as string) As Boolean
		
		//    filespec$ = UTIL.ReplaceSingleQuotes(filespec as string)
		
		//    Try
		//        Dim fso, f
		//        fso = CreateObject("Scripting.FileSystemObject")
		//        f = fso.GetFile(filespec)
		
		//        If f.attributes And 32 Then
		//            f.attributes = f.attributes - 32
		//            'ToggleArchiveBit = "Archive bit is cleared."
		//            Return True
		//        Else
		//            f.attributes = f.attributes + 32
		//            'ToggleArchiveBit = "Archive bit is set."
		//            Return False
		//        End If
		//    Catch ex As Exception
		//        LogThis("clsDma : ToggleArchiveBit : 648 : " + ex.Message)
		//        Return False
		//    End Try
		//End Function
		
		//Function isArchiveBitOn(ByVal filespec as string) As Boolean
		
		//    'Dim skipThis As Boolean = True
		//    'If skipThis = True Then
		//    'Return False
		//    'End If
		
		//    Dim B As Boolean = False
		
		//    Try
		
		//        Dim MyAttr As FileAttribute
		//        ' Assume file TESTFILE is normal and readonly.
		//        MyAttr = GetAttr(filespec as string)   ' Returns vbNormal.
		//        'Dim iAttr As Integer = GetAttr(filespec)
		
		//        ' Test for Archived.
		//        If (MyAttr And FileAttribute.Archive) = FileAttribute.Archive Then
		//            'If (MyAttr And FileAttribute.Archive) = 1 Then
		//            'The "A" is showing.
		//            Return True
		//        Else
		//            Return False
		//        End If
		
		//        'Feb 7, 2010 - Set the above code in place and removed the following - WDM
		//        'Dim fso, f
		//        'fso = CreateObject("Scripting.FileSystemObject")
		//        'f = fso.GetFile(filespec)
		
		//        'If f.attributes And 32 Then
		//        '    'f.attributes = f.attributes - 32
		//        '    'ToggleArchiveBit = "Archive bit is cleared."
		//        '    B = True
		//        'Else
		//        '    'f.attributes = f.attributes + 32
		//        '    'ToggleArchiveBit = "Archive bit is set."
		//        '    B = False
		//        'End If
		//    Catch ex As Exception
		//        LOG.WriteToSqlLog("Warning: clsDMa:isArchiveBitOn 100 - " + ex.Message)
		//        B = False
		//    End Try
		
		//    Return B
		//End Function
		
		//Function setArchiveBitOff(ByVal filespec as string) As Boolean
		
		//    Dim B As Boolean = False
		//    filespec$ = UTIL.ReplaceSingleQuotes(filespec as string)
		
		//    Try
		//        ''Dim MyAttr As FileAttribute
		//        ''' Assume file TESTFILE is normal and readonly.
		//        ''MyAttr = GetAttr(filespec as string)   ' Returns vbNormal.
		//        'If F.Exists(filespec) Then
		//        '    F.SetAttributes(filespec, FileAttributes.Archive)
		//        '    'SetAttr(filespec$, FileAttribute.Archive)
		//        'End If
		
		//        Dim f As New FileInfo(filespec as string)
		//        f.Attributes = f.Attributes And Not FileAttributes.Archive
		//        f = Nothing
		
		//        'SetAttr(filespec$, FileAttribute.Archive)
		//        'B = True
		//    Catch ex As Exception
		//        LOG.WriteToSqlLog("Warning: clsDMa:setArchiveBitOn 100 - " + ex.Message)
		//        B = False
		//    End Try
		
		//    Return B
		//End Function
		
		//Public Sub smoLoadServers(ByRef CB As List(Of String))
		
		//    Dim dt As DataTable = SmoApplication.EnumAvailableSqlServers(False)
		//    Dim ServersFound As Boolean = False
		
		//    If dt.Rows.Count > 0 Then
		//        For Each dr As DataRow In dt.Rows
		//            ServersFound = True
		//            If dDeBug Then Console.WriteLine(dr("Name"))
		//            CB.Add(dr("Name"))
		//        Next
		//    End If
		//    If Not ServersFound Then
		//        CB.Add("NO SQL SERVERS FOUND")
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
		//        CB.Add(oNames.Item(i))
		//    Next i
		//    If oNames.Count = 0 Then
		//        CB.Add("NO SQL SERVERS FOUND")
		//    End If
		//End Sub
		
		
		
		//Public Sub LoadDatabases(ByVal ServerName as string, byval UserID as string, byval PW as string, byref CB As Windows.Forms.ComboBox)
		//    Dim oSQLServer As New SQLDMO.SQLServer
		//    Dim i As Integer
		//    CB.Items.Clear()
		//    Try
		//        If UserID = "" And PW = "" Then
		//            oSQLServer.LoginSecure = True
		//        End If
		//        oSQLServer.Connect(ServerName, UserID, PW)
		//        For i = 1 To oSQLServer.Databases.Count
		//            Dim dbName$ = oSQLServer.Databases.Item(i).Name.ToString
		//            CB.Add(dbName)
		//        Next i
		//    Catch ex As Exception
		//        CB.Items.Clear()
		//        CB.Add(ex.Message.Trim)
		//    End Try
		//End Sub
		
		public string formatTextSearch(string SearchString)
		{
			if (SearchString.Trim().Length == 0)
			{
				return "";
			}
			int I = 0;
			int J = 0;
			var CH = "";
			var currWord = "";
			var prevWord = "";
			bool prevWordIsKeyWord = false;
			bool currWordIsKeyWord = false;
			List<string> tStack = new List<string>();
			List<string> aList = new List<string>();
			
			SearchString = SearchString.Replace(" ", Strings.ChrW(254));
			for (I = 1; I <= SearchString.Length; I++)
			{
				CH = SearchString.Substring(I - 1, 1);
				if (CH == Strings.ChrW(34))
				{
					I++;
					CH = SearchString.Substring(I - 1, 1);
					while (CH != Strings.ChrW(34) && I < SearchString.Length)
					{
						I++;
						CH = SearchString.Substring(I - 1, 1);
					}
					//ElseIf CH = " " Then
					//    Mid(SearchString, I, 1) = ChrW(254)
				}
			}
			
			List<string> NewText = new List<string>();
			object[] A = SearchString.Split(Strings.ChrW(254).ToString().ToCharArray());
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
						var CH1 = currWord.Substring(0, 1);
						if (CH1.Equals(Strings.ChrW(34)))
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
			var ReformattedSearch = "";
			for (I = 0; I <= NewText.Count - 1; I++)
			{
				bool isContainsDoubleQuote = false;
				bool isContainsStar = false;
				string tWord = NewText.Item(I).ToString();
				if (tWord.IndexOf("*") + 1 > 0)
				{
					isContainsStar = true;
				}
				if (tWord.IndexOf((Strings.ChrW(34)).ToString()) + 1 > 0)
				{
					isContainsDoubleQuote = true;
				}
				if (isContainsDoubleQuote == false && isContainsStar == true)
				{
					//** Wrap this word in double quotes
					tWord = tWord.Trim();
					tWord = (string) (Strings.ChrW(34) + tWord + Strings.ChrW(34));
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
				object[] A = S.Split(' ');
				if ((A.Length - 1) > 0)
				{
					bool B = ckKeyWord((string) (A[0]));
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
		
		//Public Function getDebug(ByVal FormID as string) As Boolean
		//    Dim bUseConfig As Boolean = True
		//    Dim S as string = ""
		//    Dim B As Boolean = False
		
		//    Try
		//        FormID = "debug_" + FormID
		//        S = System.Configuration.ConfigurationManager.AppSettings(FormID as string)
		//        If S.Equals("0") Then
		//            B = False
		//        ElseIf S.Equals("1") Then
		//            B = True
		//        ElseIf S.Equals("-1") Then
		//            B = True
		//        ElseIf UCase(S).Equals("TRUE") Then
		//            B = True
		//        ElseIf UCase(S).Equals("FALSE") Then
		//            B = False
		//        End If
		//    Catch ex As Exception
		//        B = False
		//        LogThis("clsDma : getDebug : 928 : " + ex.Message)
		//        LogThis("clsDma : getDebug : 953 : " + ex.Message)
		//        LogThis("clsDma : getDebug : 971 : " + ex.Message)
		//    End Try
		
		//    Return B
		
		//End Function
		
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
		
		//Public Function App_Path() As String
		//    Return System.AppDomain.CurrentDomain.BaseDirectory()
		//End Function
		
		//Public Function setHelpDir(ByVal HelpFile as string) As String
		//    Dim tDir$ = App_Path()
		//    tDir$ = tDir$ + "HelpFiles\" + HelpFile
		//    Return tDir
		//End Function
		
		//Function isConnected() As Boolean
		//    Dim bDebugConnection As Boolean = False
		//    Dim B As Boolean = False
		//    ' Returns True if connection is available
		//    ' Replace www.yoursite.com with a site that
		//    ' is guaranteed to be online - perhaps your
		//    ' corporate site, or microsoft.com
		
		//    If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 1.")
		//    Dim objUrl As New System.Uri("http://www.ecmlibrary.com/")
		//    ' Setup WebRequest
		
		//    If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 2.")
		//    Dim objWebReq As System.Net.WebRequest
		
		//    If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 3.")
		//    objWebReq = System.Net.WebRequest.Create(objUrl)
		
		//    If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 4.")
		//    Dim objResp As System.Net.WebResponse
		
		//    If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 5.")
		//    Try
		//        ' Attempt to get response and return True
		//        If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 6.")
		//        objResp = objWebReq.GetResponse
		
		//        If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 7.")
		//        objResp.Close()
		
		//        If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 8.")
		//        objWebReq = Nothing
		
		//        If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 9.")
		//        B = True
		//    Catch ex As Exception
		//        ' Error, exit and return False
		//        'objResp.Close()
		//        'objWebReq = Nothing
		//        B = False
		//        If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 10.")
		//        LogThis("FAILED TO CONNECT clsDma : isConnected : 987 : " + ex.Message)
		//    End Try
		//    If bDebugConnection Then LogThis("clsDma: ECM Library Connection step 11.")
		//    Return B
		//End Function
		
		//Public Sub SetSearchFields(ByVal txtSearch as string, byval txtThesaurus as string)
		//    Try
		//        frmQuickSearch.txtThesaurus.Text = txtThesaurus
		//        frmQuickSearch.txtSearch.Text = txtSearch$
		//    Catch ex As Exception
		//        Console.WriteLine(ex.Message)
		//    End Try
		//    Try
		//        frmDocSearch.txtThesaurus.Text = txtThesaurus
		//        frmDocSearch.txtSearch.Text = txtSearch$
		//    Catch ex As Exception
		//        Console.WriteLine(ex.Message)
		//    End Try
		//    Try
		//        frmEmailSearch.txtThesaurus.Text = txtThesaurus
		//        frmEmailSearch.txtSearch.Text = txtSearch$
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
		
		//    Sub SayWords(ByVal Words as string)
		//        If gVoiceOn = False Then
		//            Return
		//        End If
		//#If Offfice2007 Then
		//        Dim Voice As New SpeechSynthesizer
		//        Voice.Rate = 0
		//        Voice.Speak(Words)
		//#End If
		//    End Sub
		
		
		public void ckFreetextSearchLine(TextBox SearchText)
		{
			string S = SearchText.Text.Trim();
			string[] A = S.Split(" ".ToCharArray());
			
			for (int I = 0; I <= (A.Length - 1); I++)
			{
				string token = A[I];
				if (token.IndexOf((Strings.ChrW(34)).ToString()) + 1 > 0)
				{
					token = token.Replace(Strings.ChrW(34), " ");
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
			string S = SqlQuery.Trim();
			int I = 0;
			int J = 0;
			
			var Part1 = "";
			var Part2 = "";
			
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
			
			
			var S2 = S.Substring(I + 1 - 1, J - I - 1).Trim();
			object[] A = S2.Split(" ".ToCharArray());
			
			for (I = 0; I <= (A.Length - 1); I++)
			{
				var Token = A[I];
				//If InStr(1, token, Chrw(34)) > 0 Then
				//    Do While InStr(1, token, Chrw(34)) > 0
				//        Dim II As Integer = InStr(1, token, Chrw(34))
				//        Mid(token, II, 1) = " "
				//    Loop
				//End If
				Token = Token.Trim;
				A[I] = Token;
				if (Strings.UCase(Token).Equals("OR"))
				{
					A[I] = "";
				}
			}
			
			S = "";
			for (I = 0; I <= (A.Length - 1); I++)
			{
				if (A[I].Trim.Length > 0)
				{
					S = S + A[I].Trim + " ";
				}
			}
			S = S.Trim();
			
			S = Part1 + " " + S + " " + Part2;
			//Clipboard.Clear()
			//Clipboard.SetText(S)
			SqlQuery = S;
		}
		
		//Function CalcCRC(ByVal FQN as string) As String
		
		//    If InStr(FQN$, "''") > 0 Then
		//        FQN$ = UTIL.ReplaceSingleQuotes(FQN as string)
		//    End If
		
		//    Dim zipCrc As New Chilkat.ZipCrc()
		//    Dim crc As Long = 0
		//    crc = zipCrc.FileCrc(FQN as string)
		//    Dim hexStr As String
		//    hexStr = zipCrc.ToHex(crc)
		//    Return hexStr
		
		//End Function
		
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
		
		
		// <summary>
		// This method starts at the specified directory, and traverses all subdirectories.
		// It returns a List of those directories.
		// </summary>
		//Public Function GetFilesRecursive(ByVal initial As String) As List(Of String)
		//    ' This list stores the results.
		//    Dim result As New List(Of String)
		
		//    ' This stack stores the directories to process.
		//    Dim stack As New Stack(Of String)
		
		//    ' Add the initial directory
		//    stack.Push(initial)
		
		//    ' Continue processing for each stacked directory
		//    Do While (stack.Count > 0)
		//        ' Get top directory string
		//        Dim dir As String = stack.Pop
		//        Try
		//            ' Add all immediate file paths
		//            result.AddRange(Directory.GetFiles(dir, "*.*"))
		
		//            ' Loop through all subdirectories and add them to the stack.
		//            Dim directoryName As String
		//            For Each directoryName In Directory.GetDirectories(dir)
		//                stack.Push(directoryName)
		//            Next
		
		//        Catch ex As Exception
		//        End Try
		//    Loop
		
		//    ' Return the list
		//    Return result
		//End Function
		
		//Public Sub GetFilesRecursive(ByVal initial As String, ByVal List As List(Of String))
		//    ' This list stores the results.
		//    Dim result As New List(Of String)
		
		//    ' This stack stores the directories to process.
		//    Dim stack As New Stack(Of String)
		
		//    ' Add the initial directory
		//    stack.Push(initial)
		
		//    ' Continue processing for each stacked directory
		//    Do While (stack.Count > 0)
		//        ' Get top directory string
		//        Dim dir As String = stack.Pop
		//        Try
		//            ' Add all immediate file paths
		//            result.AddRange(Directory.GetFiles(dir, "*.*"))
		
		//            ' Loop through all subdirectories and add them to the stack.
		//            Dim directoryName As String
		//            For Each directoryName In Directory.GetDirectories(dir)
		//                stack.Push(directoryName)
		//            Next
		
		//        Catch ex As Exception
		//        End Try
		//    Loop
		
		//    ' Return the list
		//    CombineLists(List, result)
		//End Sub
		
		public void CombineLists(System.Windows.Documents.List<string> ParentList, System.Windows.Documents.List<string> ChildList)
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
			Extension = Extension.Trim();
			Extension = Extension.ToLower();
			if (Extension.IndexOf(".") + 1 == 0)
			{
				Extension = (string) ("." + Extension);
			}
			Extension = Extension.Replace(",", ".");
			return;
		}
		
		public bool isExtIncluded(string fExt, System.Windows.Documents.List<string> IncludedTypes)
		{
			fExt = fExt.ToUpper();
			fExt = fExt.Replace(".", " ");
			
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
		public bool isExtExcluded(string fExt, System.Windows.Documents.List<string> ExcludedTypes)
		{
			
			fExt = fExt.ToUpper();
			fExt = fExt.Replace(".", " ");
			
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
			var S1 = S.Substring(0, X - 1);
			var S2 = S.Substring(X - 1);
			var S3 = S1 + "\r\n" + "  /* " + S2 + "  */";
			S = S3;
			return S;
		}
		
		public bool CreateMissingDir(string DirFQN)
		{
			
			bool B = false;
			if (Directory.Exists(DirFQN))
			{
				return true;
			}
			try
			{
				Directory.CreateDirectory(DirFQN);
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
			LOG.WriteToSqlLog(MSG);
			LOG = null;
		}
		public string ReadFile(string fName)
		{
			System.IO.StreamReader SR = new System.IO.StreamReader(fName);
			var FullText = "";
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
		
		//Sub ModifyAppConfig(ByVal ServerName as string, byval ItemToModify as string)
		//    Dim AppConfigBody As String = ""
		//    Dim aPath$ = App_Path()
		//    Dim AppName$ = aPath$ + "ECMLibrary.exe.config"
		
		//    Dim F As File
		//    If F.Exists(AppName) Then
		//        AppConfigBody = ReadFile(AppName)
		//        If AppConfigBody.Trim.Length > 0 Then
		//            ApplyAppConfigChange(ServerName$, ItemToModify$, AppConfigBody)
		//            If AppConfigBody.Trim.Length > 0 Then
		//                WriteFile(AppName, AppConfigBody)
		//                SetUserConnectionString(ServerName as string)
		//                SetThesaurusConnectionStringToConfig(ServerName as string)
		//            End If
		//        End If
		//    End If
		//End Sub
		
		//Sub SetUserConnectionString(ByVal ServerName as string)
		
		//    Dim sCurr$ = ServerName$
		
		//    My.Settings("UserDefaultConnString") = "?"
		//    My.Settings.Save()
		
		//    Dim S as string = System.Configuration.ConfigurationManager.AppSettings("CONN_DMA.DB")
		
		//    '*****************************************************************************
		//    Dim Str1$ = ""
		//    Dim Str2$ = ""
		//    Dim NewStr$ = ServerName$
		
		//    Dim NumberOfCycles As Integer = 0
		//    Dim I As Integer = 1
		//    Do While InStr(I, S$, "Data Source=", CompareMethod.Text) > 0
		
		//        I = InStr(I, S$, "Data Source=", CompareMethod.Text)
		//        I = InStr(I + 1, S$, "=", CompareMethod.Text)
		//        Dim J As Integer = InStr(I + 1, S$, ";", CompareMethod.Text)
		//        Str1 = Mid(S$, 1, I)
		//        Str2 = Mid(S$, J)
		//        S$ = Str1 + sCurr$ + Str2
		//        NumberOfCycles += 1
		//        If NumberOfCycles > 50 Then
		//            Exit Do
		//        End If
		//        I = J + 1
		
		//    Loop
		//    '*****************************************************************************
		
		//    UTIL.setConnectionStringTimeout(S, TimeOutSecs)
		//    'S = ENC.AES256DecryptString(S)
		
		//    My.Settings.Reload()
		//    Console.WriteLine(My.Settings("UserDefaultConnString"))
		//    My.Settings("UserDefaultConnString") = S
		//    Console.WriteLine(My.Settings("UserDefaultConnString"))
		//    My.Settings.Save()
		
		//End Sub
		
		//Sub SetThesaurusConnectionStringToConfig(ByVal ServerName as string)
		
		//    Dim sCurr$ = ServerName$
		
		//    My.Settings("UserThesaurusConnString") = "?"
		//    My.Settings.Save()
		//    Dim S as string = System.Configuration.ConfigurationManager.AppSettings("ECM_ThesaurusConnectionString").ToString
		
		//    '*****************************************************************************
		//    Dim Str1$ = ""
		//    Dim Str2$ = ""
		//    Dim NewStr$ = ServerName$
		
		//    Dim NumberOfCycles As Integer = 0
		//    Dim I As Integer = 1
		//    Do While InStr(I, S$, "Data Source=", CompareMethod.Text) > 0
		
		//        I = InStr(I, S$, "Data Source=", CompareMethod.Text)
		//        I = InStr(I + 1, S$, "=", CompareMethod.Text)
		//        Dim J As Integer = InStr(I + 1, S$, ";", CompareMethod.Text)
		//        Str1 = Mid(S$, 1, I)
		//        Str2 = Mid(S$, J)
		//        S$ = Str1 + sCurr$ + Str2
		//        NumberOfCycles += 1
		//        If NumberOfCycles > 50 Then
		//            Exit Do
		//        End If
		//        I = J + 1
		
		//    Loop
		//    '*****************************************************************************
		
		//    UTIL.setConnectionStringTimeout(S, TimeOutSecs)
		//    'S = ENC.AES256DecryptString(S)
		
		//    My.Settings.Reload()
		//    Console.WriteLine(My.Settings("UserDefaultConnString"))
		//    My.Settings("UserThesaurusConnString") = S
		//    Console.WriteLine(My.Settings("UserDefaultConnString"))
		//    My.Settings.Save()
		
		//End Sub
		
		public void ApplyAppConfigChange(string ServerName, string ItemToModify, ref string AppConFigBody)
		{
			
			if (ServerName.Trim().Length == 0)
			{
				return;
			}
			
			var AppText = AppConFigBody;
			var Str1 = "";
			var Str2 = "";
			var NewStr = ServerName;
			
			int NumberOfCycles = 0;
			int I = 1;
			while (AppText.IndexOf("Data Source=", I - 1) + 1 > 0)
			{
				I = AppText.IndexOf("Data Source=", I - 1) + 1;
				I = AppText.IndexOf("=", I + 1 - 1) + 1;
				int J = AppText.IndexOf(";", I + 1 - 1) + 1;
				Str1 = AppText.Substring(0, I);
				//MsgBox(Str1)
				Str2 = AppText.Substring(J - 1);
				//MsgBox(Str2)
				AppText = Str1 + ServerName + Str2;
				//MsgBox(AppText)
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
		
		//Public Sub deleteDirectoryFiles(ByVal DirFQN as string)
		//    Dim FileName As String
		//    Try
		//        For Each FileName In System.IO.Directory.GetFiles(DirFQN as string)
		//            Try
		//                System.IO.File.Delete(FileName)
		//            Catch ex As System.Exception
		//                LOG.WriteToSqlLog("ERROR 100 clsEmailFunctions:deleteDirectoryFile - failed to delete file '" + FileName + "'.")
		//            End Try
		//        Next FileName
		//    Catch ex As System.Exception
		//        LOG.WriteToSqlLog("ERROR 200 :deleteDirectoryFile - failed to delete from Dir '" + DirFQN$ + "'.")
		//    End Try
		
		//End Sub
		
		
		
	}
	
}
